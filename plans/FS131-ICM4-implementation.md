# FS131-ICM4 — the five-colour chain: M13's two dyadic certificates

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM4-dyadic-certs.md` (on `main`). Branch `fs131-wcm4`, cut
from `fs131-wcm3` at `c0b6798ed`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm4/`. Report:
`data/fs131/reports/FS131-ICM4.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

None yet (stage 1 is the readback).

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_icm4_quotes.py` (FS131-ICM3's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icm4/quotes.out`: **5 quotations, 5 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the dated line of
2026-10-14 "The count is typed" (`data/fs131/claims-NF2.md`), inventory items 905, 922 and 920
(`plans/FS131-close-inventory.md`). Control (`--plant`, `data/fs131/icm4/quotes-plant.out`): one character changed in each
quotation in memory, **5 of 5 reported**. The brief's pointers were read: the last implementer's record
(`plans/FS131-ICM3-implementation.md` § Stage 4's table of the three children, § Stage 5's "What is left of the dyadic
branch"), the two leaves at `Rigidity/ClassRatio.lean` ll. 1649 and 1657, `Arith/Floor128.lean` (661 lines), and X26B-T1's
tool and output (`tools/x26b_uq_colour.py`, `data/fs100/x26b/uq-colour.out`: 10, 36, 68 codimension-2 `𝔽₂`-subspaces
avoiding `μ_{Q+1}` at `Q = 4, 8, 16`; 11 `𝔽₄`-hyperplanes at 32).

### 1.2 The stored statements, dumped before any edit

`data/fs131/icm4/lean/StatementDump.lean` (FS131-ICM3's dumper with `Arith/Floor128` added; the modules `Arith/Floor128`,
`Arith/CircleCos`, `Rigidity/ClassRatio`, `CountCompletion`, `CountDescent`, `CountModels`), run by `lake env lean` under the
slot (`data/fs131/icm4/lean1.sh`) on the tree as given, its compiled library current for `c0b6798ed` (build 4):
`data/fs131/icm4/statements-before.txt` — **537 constants** (Floor128 119, CircleCos 58, ClassRatio 230, CountCompletion 50,
CountDescent 25, CountModels 55; sha256 in `statements-before.sha256`). With the `Floor128` section removed it is
**byte-identical** to FS131-ICM3's last dump (`data/fs131/icm3/statements-after4.txt.xz`), and the comparator
(`tools/fs131_icm4_statements.py`, ICM3's, renamed) reads it against that dump **SAME 72, PRIVATE-SAME 189, CHANGED 0 —
PASS** (`statements-vs-icm3.out`; Floor128's constants NEW-MODULE, since ICM3 did not dump it): the tree holds what the last
implementer left.

### 1.3 The two leaves, as the kernel holds them, beside their routes

*Both private, in `Rigidity/ClassRatio`; printed from `statements-before.txt` (`PP`).*

| leaf | stored statement | route (ICM3 § Stage 4; this job's choice) |
|---|---|---|
| `colorable_four_dyadic_small` | `∀ {f : ℕ}, 2 ≤ f → f ≤ 5 → ∀ (k : Type) [inst : Field k] [inst_1 : Fintype k], Fintype.card k = (2 ^ f) ^ 2 → (SimpleGraph.fromRel fun x y => (x - y) ^ (2 ^ f + 1) = 1).Colorable 4` | per `f`, a primitive polynomial `P` of degree `2f` (a root `g` in every field of `2^{2f}` elements whose powers are the non-zero elements, by the generic bridge) and two exponents `e₁, e₂`: the colour of `x` is `(L₀(g^{e₁}x), L₀(g^{e₂}x))`, `L₀` the coordinate-0 functional; proper because every `u ∈ μ_{Q+1} = {g^{(Q−1)j}}` has `L₀(g^{e₁}u) = 1` or `L₀(g^{e₂}u) = 1`, a check on the register's bit sequence. This is X26B-T1's encoding (`Tr(g^{ia}u)`, `Tr(g^{ib}u)`) with `L₀` for the trace |
| `charSum_64_ge` | `∀ {k : Type} [inst : Field k] [inst_1 : Fintype k] [inst_2 : DecidableEq k], Fintype.card k = 64 ^ 2 → ∀ (ψ : AddChar k ℂ), ψ ≠ 1 → -15 ≤ (∑ u with u ^ (64 + 1) = 1, ψ u).re` | `Floor128`'s route at `2¹²` through the generic bridge: a primitive `P` of degree 12, one pass of the register over its 4,095 states counting the coordinate-0 bit into 63 classes, every class at most 40, so every sum is at least `65 − 2·40 = −15` |
