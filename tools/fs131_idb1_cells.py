#!/usr/bin/env python3
"""FS131-IDB1 — generator of the J₀ covering's modules (untrusted: a wrong datum can only make the kernel refuse a cell).

The covering checks `w₁ + Σₖ Wₖ J₀(t dₖ) ≥ 1 − 6·10⁻⁵` on [0, 800] by 847 cells (the planner's plan,
`data/fs131/kdb1/proto/plan800.json`: each cell's left end, width and degree; the plan's own states are not used) and
on [800, ∞) by the tail. The states between cells are computed by **the checker's own definitions** in Lean's compiled
evaluator (`termNext` of `Plane/DensityBound/BesselCert`), so that the kernel re-checks exactly what was computed.

  chain    write data/fs131/idb1/gen/Chain.lean (the parameters, the cells, an #eval of the chain printing one packed
           code per cell boundary, the compiled check of every cell, and the final states)
  modules  read data/fs131/idb1/gen/Chain.out and write Proofs/HadwigerNelson/Plane/DensityBound/Cells/
           {Data, PartNN, Covering}.lean; refuses if any cell's compiled check failed or the tail does not pass
  --budget N  the cells' degree sum per module (default 420: about 45 modules)

Run from the worktree root (proto_chain reads the certificate files relative to it):
  python3 tools/fs131_idb1_cells.py chain
  data/fs131/idb1/lean1.sh data/fs131/idb1/gen/Chain.lean 6 > data/fs131/idb1/gen/Chain.out
  python3 tools/fs131_idb1_cells.py modules
"""
import json
import math
import sys
from fractions import Fraction as Fr
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'data/fs131/kdb1/proto'))
import proto_chain as PC  # noqa: E402  (reads data/pa-ambrus2023/verification23.nb and g23.csv; floats only for D)

GEN = ROOT / 'data/fs131/idb1/gen'
CELLS = ROOT / 'Proofs/HadwigerNelson/Plane/DensityBound/Cells'
PLAN = ROOT / 'data/fs131/kdb1/proto/plan800.json'
NS = 'HadwigerNelson.DensityBound.BesselCert.Cells'
S = 1 << 64
TB = 20
WS = 10 ** 20
TN, TD = 99994, 100000
F72, F144, F216, H71 = 1 << 72, 1 << 144, 1 << 216, 1 << 71


def params():
    Ws = [int(w * WS) for w in PC.W]
    assert all(Fr(x, WS) == w for x, w in zip(Ws, PC.W)), 'a weight is not exact at scale 10^20'
    w1N = int(PC.w1 * WS)
    assert Fr(w1N, WS) == PC.w1
    Ds = list(PC.Dt)
    assert Ds[0] == S and all(d > 0 for d in Ds) and len(Ds) == len(Ws) == 27
    return Ws, Ds, w1N


def cells():
    plan = json.load(open(PLAN))['cells']
    out = []
    for c in plan:
        t0, w = Fr(c[0]) * (1 << TB), Fr(c[1]) * (1 << TB)
        assert t0.denominator == 1 and w.denominator == 1
        out.append((int(t0), int(w), int(c[2])))
    t = 0
    for t0, w, _ in out:
        assert t0 == t and w > 0
        t += w
    assert t == 800 << TB, t
    return out


def lean_list(xs):
    return '[' + ', '.join(str(x) for x in xs) + ']'


def params_lean():
    Ws, Ds, w1N = params()
    return f'⟨{WS}, {w1N}, {TN}, {TD}, {lean_list(Ws)}, {lean_list(Ds)}⟩'


def write_chain():
    GEN.mkdir(parents=True, exist_ok=True)
    cl = ', '.join(f'({a}, {b}, {n})' for a, b, n in cells())
    (GEN / 'Chain.lean').write_text(f'''import Proofs.HadwigerNelson.Plane.DensityBound.BesselCheck
/-! FS131-IDB1 generator stage (written by tools/fs131_idb1_cells.py; untrusted): the chain of states by the
checker's own `termNext`, one packed code per cell boundary, and the compiled `cellCheck` of every cell. -/
open HadwigerNelson.DensityBound.BesselCert

def genP : Params := {params_lean()}
def genCells : List (Int × Int × Nat) := [{cl}]

def encodeSt (st : St) : Nat := (st.m0 + H71).toNat + F72 * (st.m1 + H71).toNat + F144 * (st.r + H71).toNat
def encode : List St → Nat
  | [] => 0
  | st :: l => encodeSt st + F216 * encode l

def nextAll (P : Params) (sts : List St) (t0 w : Int) (N : Nat) : List St :=
  ((P.Ws.zip P.Ds).zip sts).map fun p => termNext (core p.1.1 p.1.2 p.2 t0 w N)

def run : IO Unit := do
  let mut sts := initStates genP.Ds.length
  let mut i := 0
  IO.println s!"CODE 0 {{encode sts}}"
  for (t0, w, N) in genCells do
    let sts' := nextAll genP sts t0 w N
    let rt := decode genP (encode sts') == sts'
    let ok := cellCheck genP (decode genP (encode sts)) t0 w N (decode genP (encode sts'))
    i := i + 1
    IO.println s!"CODE {{i}} {{encode sts'}}"
    IO.println s!"OK {{i - 1}} {{ok}} {{rt}}"
    sts := sts'
  for st in sts do
    IO.println s!"FINAL {{st.m0}} {{st.m1}} {{st.r}}"

#eval run
''')
    print('wrote', GEN / 'Chain.lean', len(cells()), 'cells')


def read_chain():
    codes, oks, final = {}, {}, []
    for ln in open(GEN / 'Chain.out'):
        p = ln.split()
        if not p:
            continue
        if p[0] == 'CODE':
            codes[int(p[1])] = int(p[2])
        elif p[0] == 'OK':
            oks[int(p[1])] = (p[2] == 'true', p[3] == 'true')
        elif p[0] == 'FINAL':
            final.append(tuple(int(x) for x in p[1:4]))
    return codes, oks, final


def decode(code, n=27):
    out = []
    for _ in range(n):
        f = [(code >> (72 * j)) % F72 - H71 for j in range(3)]
        out.append(tuple(f))
        code >>= 216
    return out


def tail(final):
    Ws, Ds, w1N = params()
    E = -((-(800 << TB)) // (1 << TB))
    us = [math.isqrt(m0 * m0 + m1 * m1) + 1 for m0, m1, _ in final]
    s = sum(abs(W) * (u + r + E) for W, u, (_, _, r) in zip(Ws, us, final))
    ok = TN * WS * S <= TD * (w1N * S - s)
    slack = Fr(w1N * S - s, WS * S) - Fr(TN, TD)
    return us, ok, slack


def write_modules(budget):
    cs = cells()
    codes, oks, final = read_chain()
    assert len(codes) == len(cs) + 1 and len(oks) == len(cs) and len(final) == 27, (len(codes), len(oks), len(final))
    bad = [i for i, (ok, rt) in oks.items() if not (ok and rt)]
    if bad:
        raise SystemExit(f'REFUSED: compiled check failed at cells {bad[:10]}')
    assert decode(codes[len(cs)]) == final
    us, tok, slack = tail(final)
    if not tok:
        raise SystemExit('REFUSED: the tail does not pass')
    # group cells by degree sum
    groups, cur, acc = [], [], 0
    for i, (_, _, n) in enumerate(cs):
        if cur and acc + n > budget:
            groups.append(cur)
            cur, acc = [], 0
        cur.append(i)
        acc += n
    groups.append(cur)
    CELLS.mkdir(parents=True, exist_ok=True)
    for old in CELLS.glob('Part*.lean'):
        old.unlink()
    (CELLS / 'Data.lean').write_text(f'''import Proofs.HadwigerNelson.Plane.DensityBound.BesselCheck

/-!
# The `J₀` covering's parameters (FS-131, FS131-IDB1; generated by `tools/fs131_idb1_cells.py`)

`[AmbrusEtAl2023]`'s `ϕ(t) = w₀ J₀(t) + w₁ + Σ w₂ J₀(t |xᵢ − xⱼ|)` (`g23.csv`): term `0` is `w₀` at distance `1`, terms
`1 … 26` the `w₂` rows of `g23.csv` in its order, at the distances `|xᵢ − xⱼ|` of `verification23.nb`'s points. Weights
exactly at scale `10²⁰`; distances rounded to the nearest multiple of `2⁻⁶⁴` (the checker allows `|d − D/2⁶⁴| ≤ 2⁻⁶⁴`);
target `1 − 6·10⁻⁵`.
-/

namespace {NS}

open HadwigerNelson.DensityBound.BesselCert

/-- The covering's parameters: `WS = 10²⁰`, `w₁·WS`, the target `99994/100000`, the weights `Wₖ·WS`, the distances
`Dₖ·2⁶⁴`. -/
def P23 : Params := {params_lean()}

end {NS}
''')
    parts = []
    for g, idx in enumerate(groups):
        name = f'Part{g:02d}'
        parts.append(name)
        body = [f'''import Proofs.HadwigerNelson.Plane.DensityBound.Cells.Data

/-!
# The `J₀` covering, cells {idx[0]}–{idx[-1]} (FS-131, FS131-IDB1; generated by `tools/fs131_idb1_cells.py`)

Each cell is checked by `decide +kernel` from its literal packed entry states to its literal packed exit states.
-/

namespace {NS}

open HadwigerNelson.DensityBound.BesselCert
''']
        for i in idx:
            t0, w, n = cs[i]
            body.append(f'''
/-- Cell {i}: `t ∈ [{Fr(t0, 1 << TB)}, {Fr(t0 + w, 1 << TB)}]`, degree {n}. -/
def c{i} : CellSpec := ⟨{t0}, {w}, {n}, {codes[i]}, {codes[i + 1]}⟩

theorem c{i}_ok : CellOk P23 c{i} := by decide +kernel
''')
        body.append(f'''
/-- Cells {idx[0]}–{idx[-1]}. -/
def seg{g:02d} : List CellSpec := [{', '.join(f'c{i}' for i in idx)}]

theorem seg{g:02d}_ok : AllOk P23 seg{g:02d} :=
  ⟨{', '.join(f'c{i}_ok' for i in idx)}, trivial⟩

end {NS}
''')
        (CELLS / f'{name}.lean').write_text(''.join(body))
    imports = '\n'.join(f'import Proofs.HadwigerNelson.Plane.DensityBound.Cells.{p}' for p in parts)
    segs = ' ++ ('.join(f'seg{g:02d}' for g in range(len(groups))) + ')' * (len(groups) - 1)
    proof = 'trivial'
    for g in reversed(range(len(groups))):
        proof = f'(allOk_append _ _ _).2 ⟨seg{g:02d}_ok, {proof}⟩' if g < len(groups) - 1 else f'seg{g:02d}_ok'
    (CELLS / 'Covering.lean').write_text(f'''import Proofs.HadwigerNelson.Plane.DensityBound.BesselCert
{imports}

/-!
# The `J₀` covering assembled: `ϕ ≥ 1 − µ` on `[0, ∞)` (FS-131, FS131-IDB1; generated by `tools/fs131_idb1_cells.py`)

{len(cs)} cells cover `[0, 800]`, linked exit to entry from `J(0) = (1, 0)`; past `800` the tail reads the last states
(`tailCheck_sound`, slack `{float(slack):.6f}`). The conclusion holds for **any** distances within `2⁻⁶⁴` of the listed
ones: lane X supplies the certificate's.
-/

namespace {NS}

open HadwigerNelson.DensityBound.BesselCert

/-- All cells, in order. -/
def allCells : List CellSpec := {segs}

theorem allCells_ok : AllOk P23 allCells := {proof}

/-- The packed initial states, `J(0) = (1, 0)` for every term. -/
def code0 : ℕ := {codes[0]}

/-- Integer bounds `uₖ > ‖(m0, m1)‖` of the last states. -/
def us23 : List ℕ := {lean_list(us)}

theorem allCells_linked : Linked 0 code0 allCells = true := by decide +kernel

theorem code0_init : decode P23 code0 = initStates P23.Ds.length := by decide +kernel

theorem allCells_tail : tailCheck P23 (chainEnd 0 allCells) (decode P23 (chainExit code0 allCells)) us23 = true := by
  decide +kernel

/-- **`ϕ ≥ 1 − µ` on `[0, ∞)`**: for every `t ≥ 0` and all distances `dₖ` within `2⁻⁶⁴` of `Dₖ/2⁶⁴` (nonnegative),
`99994/100000 ≤ w₁ + Σₖ Wₖ J₀(t dₖ)` with the weights of `P23` at scale `10²⁰` — `[AmbrusEtAl2023]`'s `ϕ(t) ≥ 1 − µ`,
`µ = 6·10⁻⁵`, its eq. (22), checked in the kernel. -/
theorem phiApprox_ge : ∀ d : List ℝ, Close P23.Ds d → ∀ t : ℝ, 0 ≤ t →
    (P23.TN : ℝ) / P23.TD ≤ P23.w1N / P23.WS + jsum P23.Ws d t / P23.WS :=
  covering_sound P23 allCells code0 us23 allCells_ok allCells_linked code0_init allCells_tail

end {NS}
''')
    rows = ['| `Plane/DensityBound/Cells/Data` | **FS-131 (FS131-IDB1), generated.** `P23`: the covering\'s parameters (weights at `10²⁰`, distances at `2⁶⁴`, target `99994/100000`). | `Plane/DensityBound/BesselCheck` | — | FS-131 |']
    for g, idx in enumerate(groups):
        rows.append(f'| `Plane/DensityBound/Cells/Part{g:02d}` | **FS-131 (FS131-IDB1), generated.** Cells {idx[0]}–{idx[-1]} of the `J₀` covering, each `CellOk P23` by `decide +kernel`; `seg{g:02d}`, `seg{g:02d}_ok`. | `Plane/DensityBound/Cells/Data` | — | FS-131 |')
    rows.append('| `Plane/DensityBound/Cells/Covering` | **FS-131 (FS131-IDB1), generated.** `allCells`, `allCells_ok`, `allCells_linked`, `code0_init`, `allCells_tail`; **`phiApprox_ge`**: `[AmbrusEtAl2023]`\'s `ϕ ≥ 1 − µ` on `[0, ∞)` for any distances within `2⁻⁶⁴` of `P23`\'s. | `Plane/DensityBound/BesselCert`, ' + ', '.join(f'`Plane/DensityBound/Cells/Part{g:02d}`' for g in range(len(groups))) + ' | — | FS-131 |')
    (GEN / 'architecture-rows.md').write_text('\n'.join(rows) + '\n')
    (GEN / 'imports.txt').write_text(''.join(f'import Proofs.HadwigerNelson.Plane.DensityBound.Cells.{m}\n' for m in ['Data'] + parts + ['Covering']))
    print(f'wrote Data, {len(parts)} parts, Covering; tail slack {float(slack):.6f}; groups (cells, degree sum):',
          [(len(idx), sum(cs[i][2] for i in idx)) for idx in groups][:5], '...')


if __name__ == '__main__':
    args = sys.argv[1:]
    budget = 420
    if '--budget' in args:
        k = args.index('--budget')
        budget = int(args[k + 1])
        del args[k:k + 2]
    if args == ['chain']:
        write_chain()
    elif args == ['modules']:
        write_modules(budget)
    else:
        print(__doc__)
        sys.exit(2)
