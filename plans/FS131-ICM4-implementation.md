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

## Stage 2 — SAVED: the bridge — `Arith/BinaryField` (generic in the degree, the polynomial and `Q`); `Floor128` left as it is

**The module** `Proofs/HadwigerNelson/Arith/BinaryField.lean` (559 lines with docstrings and Spec; namespace
`HadwigerNelson.BinaryField`; imports `Arith/Floor128` only, for its generic `ev` lemmas, `digit_sum`, `sum_range_mul_eq`).

| part | lines | content |
|---|---|---|
| the register | 41–194 | `step n P`, `orbitOk`, `primCheck`, `IsPrimitiveCode` (degree `n`; the orbit of `1` has length exactly `2ⁿ − 1`), `orbitOk_iff`, `isPrimitiveCode_of_check`, `step_lt`, `iterate_step_ne_zero` (from the period: `0` is fixed), `minimalPeriod_step`, `iterate_step_injOn`, `exists_iterate_step_eq` |
| evaluation and the root | 195–266 | `ev_step`, `ev_iterate_step`, `exists_ev_iterate_step` (modulo `P` the register multiplies by `t`, at any point), `charP_two_of_card`, **`exists_root`** |
| the field | 267–394 | `root_pow_eq_one`, `ev_ne_zero`, `ev_inj`, `root_pow_inj`, `exists_code`, **`exists_code_fun`** (additive codes; the code of `gᵐ` is the `m`-th state), `exists_root_pow_eq`, `sq_facts`, **`normOne_eq_image`**, **`exists_addChar`** |
| consumers | 395–537 | **`charSum_ge_of_classes`**; `pass`, `pass_snd`, `pass_class` (packed counters modulo `d`); `colourCheck`, **`colorable_four_of_check`** |
| Spec | 538–559 | `step`/`orbitOk` at `x² + x + 1`; `IsPrimitiveCode 2 7` (the inhabitant); refusals `primCheck 2 5`, `primCheck 4 31` (irreducible, not primitive); `pass`; `colourCheck 2 7 2 0 1 = true`, `… 0 0 = false` |

**One change of route from `Floor128`:** the root needs **no cofactor certificate**. `Floor128` proved `P ∣ x^(2¹⁴) + x` by a
4,096-hex-digit quotient `qBig`; here the orbit is the divisibility. In `k[x]` (`CharP 2` by `Polynomial.charP`),
`exists_ev_iterate_step` at `t = x` and `m = 2ⁿ − 1` gives `1 = x^(2ⁿ−1) + P·c`, so `P ∣ x·(x^(2ⁿ−1) − 1) = x^|k| − x`;
that splits in `k` (`splits_iff_card_roots`, `FiniteField.roots_X_pow_card_sub_X`), so `P` splits
(`Polynomial.Splits.of_dvd`) and, of degree `n ≥ 1`, has a root (`Splits.exists_eval_eq_zero`). Likewise the period
needs no factorization of `2ⁿ − 1`: `primCheck` checks every intermediate state against `1`.

**`Floor128` is left as it is.** Its certificate and bridge are proved and kernel-checked; its bridge is this one's
instance at `n = 14`, `P = 16427`, `Q = 128`; making it read this module would invert the import (this module reads
`Floor128`'s `ev` lemmas), rebuild `Floor128` and every dependent, and change no statement. Its public statements are
untouched (stage 3's dump: SAME).

**Elaborated** (`lake env lean` under the slot, `data/fs131/icm4/logs/bf-2.log`: exit 0, no message) and the axioms of the
consumers printed from a copy (`data/fs131/icm4/lean/BFCopy.lean`, `logs/bf-2-axioms.log`): `colorable_four_of_check`,
`charSum_ge_of_classes`, `pass_class` — `[propext, Classical.choice, Quot.sound]`; `isPrimitiveCode_of_check` —
`[propext, Quot.sound]`. (The build is the receipt: stage 3.)

**Re-priced from the first part:** the bridge's first part (register, root, field) ≈ 350 lines against the brief's
400–600; with both consumers and the generic pass, 559.
