#!/usr/bin/env python3
"""Emit a narrow-fan certificate: the classed distances and separating colourings for one pivot.

UNTRUSTED, like everything in `tools/`. Lean re-derives every claim from the emitted data against
its own vertex table and edge list: a wrong class value fails the exact `distSq` binding, a wrong
colouring fails the properness walk, a misordered class table fails the interval separation, and a
colouring that does not separate its class fails the per-vertex check. Nothing here can make the
theorem false; it can only make the build fail, loudly, with `NarrowFanDiagnose` naming the datum.

## The refusal

The module is emitted only when the sweep **settled every class as separated**. A deferred solve
(budget cut) or a confined class (the theorem would be false — and the milestone's answer would be
a *hit*, which goes to a different celebration entirely) refuses the whole file.

## The pre-flight

The emitter runs Lean's own interval arithmetic — the same integer corner products, the same
tower recursion, the same scale — and refuses to emit class values whose adjacent intervals
overlap, so a failed `decide +kernel` on separation means a *bug*, never bad luck with precision.

    python3 tools/emit_narrow.py degrey_cert --pivot 630 --colours 5
"""

from __future__ import annotations

import argparse
import json
import math
import sys

sys.set_int_max_str_digits(100_000)  # classIds is one ~5,200-digit numeral by design
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from field import mul_table, distsq, spindle_available  # noqa: E402
from narrow import classes_at, sweep_pivot, is_rational  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
TAB = mul_table()

#: numeric surd per component, in `unpackQ4`'s field order (bit j of the index ↔ √PRIMES[j])
SURDS = [math.sqrt(math.prod(p for j, p in enumerate([3, 5, 7, 11]) if (i >> j) & 1))
         for i in range(16)]

SCALE = 1 << 40  # the generator-bound denominator; Lean re-checks l² ≤ d·s² ≤ h²


# ------------------------------------------------------------------ Lean's interval arithmetic

def ival_add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def ival_scale_up(a, c):
    return (a[0] * c, a[1] * c)


def ival_mul(a, b):
    ps = (a[0] * b[0], a[0] * b[1], a[1] * b[0], a[1] * b[1])
    return (min(ps), max(ps))


def sqrt_bound(d: int) -> tuple[int, int]:
    lo = math.isqrt(d * SCALE * SCALE)
    hi = lo + 1
    assert lo * lo <= d * SCALE * SCALE <= hi * hi
    return lo, hi

BOUNDS = {3: sqrt_bound(3), 5: sqrt_bound(5), 7: sqrt_bound(7), 11: sqrt_bound(11)}


def approx(vec: tuple) -> tuple[int, int]:
    """`Q4.approx` mirrored: the four-level tower over the 16-component vector, field `i`'s
    radical set given by the bits of `i` (bit 0 ↔ √3 … bit 3 ↔ √11), exactly `unpackQ4`'s
    component order."""
    def level(idx: list[int], radicals: list[int]):
        if not radicals:
            return (vec[idx[0]], vec[idx[0]])
        d = radicals[-1]
        bit = len(radicals) - 1
        lo_idx = [i for i in idx if not (i >> bit) & 1]
        hi_idx = [i for i in idx if (i >> bit) & 1]
        re = level(lo_idx, radicals[:-1])
        im = level(hi_idx, radicals[:-1])
        return ival_add(ival_scale_up(re, SCALE), ival_mul(im, BOUNDS[d]))
    return level(list(range(16)), [3, 5, 7, 11])


# ------------------------------------------------------------------ packing

def zigzag(x: int) -> int:
    return 2 * x if x >= 0 else -2 * x - 1


def pack_fields(vals: list[int], bits: int) -> int:
    out = 0
    for i, v in enumerate(vals):
        assert 0 <= v < (1 << bits), f"field {v} does not fit {bits} bits"
        out |= v << (bits * i)
    return out


def pack_q4(vec: tuple, bits: int) -> int:
    return pack_fields([zigzag(x) for x in vec], bits)


# ------------------------------------------------------------------ emission

def emit(cert_name: str, pivot: int, k: int, budget: float) -> None:
    d = json.load(open(Path(__file__).resolve().parent / f"{cert_name}.json"))
    coords = [(tuple(c[0]), tuple(c[1])) for c in d["coords"]]
    edges = [tuple(e) for e in d["edges"]]
    n = len(coords)

    sw = sweep_pivot(n, edges, coords, pivot, k, budget)
    print(sw.line())
    if sw.deferred:
        raise SystemExit(f"REFUSED: {len(sw.deferred)} deferred solves — nothing is emitted "
                         "from a sweep with unsettled answers")
    if sw.confined:
        raise SystemExit("REFUSED: a fan IS confined at this pivot — that is a narrowing HIT, "
                         "not a negative certificate; take it to the closing move instead")

    cl = classes_at(coords, pivot)
    # sorted ascending by real value; the pre-flight below re-checks this exactly
    keys = sorted(cl.keys(), key=lambda kk: sum(c * s for c, s in zip(kk, SURDS)))

    # pre-flight: Lean's own separation check, in exact integers
    ivals = [approx(kk) for kk in keys]
    for i in range(len(ivals) - 1):
        assert ivals[i][1] < ivals[i + 1][0], \
            f"REFUSED: classes {i},{i + 1} not separated at scale 2^40 — raise SCALE"

    class_of = {kk: i for i, kk in enumerate(keys)}
    id_bits = max(1, (len(keys) - 1).bit_length())
    class_ids = pack_fields(
        [class_of[tuple(distsq(coords[pivot], coords[v], TAB))] if v != pivot else 0
         for v in range(n)], id_bits)

    # one colouring per class, from the sweep's own pool
    hints = []
    for kk in keys:
        Q = cl[kk]
        j = next(i for i, m in enumerate(sw.models) if all(m[v] != m[pivot] for v in Q))
        hints.append(j)
    hint_bits = max(1, (len(sw.models) - 1).bit_length())
    hints_packed = pack_fields(hints, hint_bits)

    val_bits = max(zigzag(x).bit_length() for kk in keys for x in kk)
    class_vals = [pack_q4(kk, val_bits) for kk in keys]

    colour_bits = max(1, (k - 1).bit_length())
    colourings = [pack_fields([m[v] for v in range(n)], colour_bits) for m in sw.models]

    spin = sum(1 for kk in keys if is_rational(kk)
               and spindle_available(Fraction(kk[0], d["denom"] ** 2)))

    name = f"deGreyNarrow{pivot}"
    vals_lines = "\n".join(f"    {v}," for v in class_vals).rstrip(",")
    cols_lines = "\n".join(f"    {v}," for v in colourings).rstrip(",")
    text = f"""import Proofs.HadwigerNelson.NarrowFan
import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# GENERATED by `tools/emit_narrow.py` — do not edit; regenerate instead

**Untrusted data, kernel-checked below.** No fan at vertex {pivot} of de Grey's 1581-point graph
is confined to a single real distance: {len(keys)} distance classes ({spin} of them at
spindle-able radii), each separated from the pivot by one of {len(sw.models)} explicit proper
5-colourings, with the classes' real-distinctness certified by integer interval arithmetic at
denominator 2^40.

Expect the `check` reduction below to hold several gigabytes resident (the 1,580 exact tower
distances dominate); build this module in a memory-capped scope and not beside every sibling
at once — see CLAUDE.md § build.

If the check fails, the kernel cannot print the reason at this size. Run, in a scratch file
downstream of this one:

    import Proofs.HadwigerNelson.NarrowFanDiagnose
    #eval ({name}.firstFault deGrey.verts deGrey.edges).map NarrowFault.report
-/

namespace HadwigerNelson

set_option maxRecDepth 8192

/-- The narrow-fan certificate at pivot {pivot}: class table, sorted class values, generator
bounds, separating colourings, and per-class hints. Data, believed only through `check`. -/
def {name} : NarrowCert 1581 where
  pivot := {pivot}
  k := {k}
  bits := {colour_bits}
  idBits := {id_bits}
  hintBits := {hint_bits}
  valBits := {val_bits}
  bounds := ⟨{SCALE},
    ⟨{BOUNDS[3][0]}, {BOUNDS[3][1]}⟩,
    ⟨{BOUNDS[5][0]}, {BOUNDS[5][1]}⟩,
    ⟨{BOUNDS[7][0]}, {BOUNDS[7][1]}⟩,
    ⟨{BOUNDS[11][0]}, {BOUNDS[11][1]}⟩⟩
  classVals := [
{vals_lines}]
  classIds := {class_ids}
  hints := {hints_packed}
  colourings := [
{cols_lines}]

set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- The kernel accepts the certificate: bounds, separation, properness, and all 1,580 per-vertex
class bindings and separations. -/
theorem {name}_check : {name}.check deGrey.verts deGrey.edges = true := by
  first
  | decide +kernel
  | fail "the narrow-fan certificate for pivot {pivot} does not check — run \
#eval ({name}.firstFault deGrey.verts deGrey.edges).map NarrowFault.report \
in a scratch file importing Proofs.HadwigerNelson.NarrowFanDiagnose"

/-- **No fan at vertex {pivot} of de Grey's graph is narrow**: for every real distance `r`, no
list of vertices avoiding the pivot and all at distance `r` from it is a five-colour fan. The
closing move (`not_colorable_of_spindled_fan`) needs exactly such a fan, so this pivot — one of
the only four in any known graph at the χ ≥ 5 boundary that carry five-colour fans at all —
offers it nothing.

A sceptic re-checks this with: `#print axioms deGrey_no_narrow_fan_{pivot}` (expect exactly
`[propext, Classical.choice, Quot.sound]`); `scripts/axioms.sh`; and the claims to read aloud —
`Fan` ("every proper colouring paints the pivot like some partner"), `deGrey.point` (the exact
plane embedding at denominator 768), and this statement against the informal one above. -/
theorem deGrey_no_narrow_fan_{pivot} :
    ∀ (r : ℝ) (Q : List (Fin 1581)), ({pivot} : Fin 1581) ∉ Q →
      (∀ q ∈ Q, dist (deGrey.point q) (deGrey.point {pivot}) = r) →
      ¬ Fan (edgeGraph 1581 deGrey.edges) 5 {pivot} Q :=
  {name}.sound {name}_check

end HadwigerNelson
"""
    out = ROOT / "Proofs" / "HadwigerNelson" / "Instances" / "DeGrey" / f"Narrow{pivot}.lean"
    out.write_text(text)
    print(f"emitted {out} ({len(keys)} classes, {len(sw.models)} colourings, "
          f"valBits {val_bits}, idBits {id_bits}, hintBits {hint_bits})")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("cert")
    ap.add_argument("--pivot", type=int, action="append", required=True)
    ap.add_argument("--colours", type=int, default=5)
    ap.add_argument("--budget", type=float, default=300.0)
    args = ap.parse_args()
    for p in args.pivot:
        emit(args.cert, p, args.colours, args.budget)


if __name__ == "__main__":
    main()
