# FS131-ID1 — the implementer's record: `Arith/DyadicQuadratic`, 10 leaves

*de Bruijn, the implementer (Opus 5.5). Brief: `data/fs131/briefs/FS131-ID1-leaves.md` (on `main`). Worktree
`.claude/worktrees/fs131-wdq`, branch `fs131-wdq`, cut at the skeleton's commit `34d9113b2`. Working files:
`data/fs131/id1/`. Nothing pushed (the brief: the remote is unreachable).*

## Theorems this phase proved

*(filled at each stage; one line per kernel theorem, with its declaration and its axioms — printed at the end from the
built module, § the last stage)*

## Stage 1 — SAVED: the readback

**The brief's quotations, against their sources** (`data/fs131/id1/readback.py`, reading the main checkout; log
`data/fs131/id1/logs/readback.out`): five quotations — W2 (`data/fs131/REQUEST-2026-10-13.md`), NF4-THEOREM and the three
dated lines of 2026-10-13 (`data/fs131/claims-NF4.md`) — each **IDENTICAL**, character for character
(`compared=5 differing=0`). Control (`--control`, one word changed in each): five of five read DIFFERS
(`logs/readback.control.out`). No finding about the brief.

**The plans read**, in the brief's order: the dated section at the end of
`plans/FS131-KN4-three-four-colours-plan.md` (branch `fs131-wr2`; "§ 4.5 is replaced whole by the record's § Stage 5"),
`plans/FS131-KN5-three-four-colours-passes.md` §§ Stage 3, 5, 7, and the first plan's § 4.5–4.6. The names the plan cites
are in `data/fs131/kn5/lean/NameCheck.lean` with its log (`logs/NameCheck.out`, branch `fs131-wr2`): each resolves under
this module's imports.

**The skeleton as it stands**: `lake env lean` with the lakefile's two options, exit 0, ten `declaration uses sorry` and
no other message (`data/fs131/id1/logs/DyadicQuadratic.out` at this stage); 3.6 GB, 6 s of elaboration behind a slot.

**Each leaf, read in the source, in one line, with the plan's route** (the statement is the file's; this is a reading,
not a copy):

| # | leaf | what it says | the plan's route (KN5 § Stage 5) | agree? |
|---|---|---|---|---|
| 1 | `colorable_planeOver_of_addMonoidHom` | `Λ ≤ ℂ` an additive subgroup, `ψ : Λ →+ G`, `G` finite, every unit vector of `F²` in `Λ` with `ψ u ≠ 0` ⟹ the plane over `F` is `Nat.card G`-colourable; every `F ≤ ℝ` | `colorable_of_residue` at `f = (↑)`; an edge's difference is a unit vector; `cosetResidue_apply_of_mem` | yes |
| 2 | `exists_rat_add_mul_sqrt_eq` | every `x ∈ fieldOfRadicands {m}` is `p + q√m`, `p q : ℚ`; every `m : ℕ` | `Subfield.closure_induction`; product by `√m·√m = m`; inverse by the conjugate, or `x = 2p` when the conjugate is `0`; no irrationality | yes |
| 3 | `exists_int_solution_of_mem_unitVectors` | `m` not a square, `u` a unit vector of `ℚ(√m)²` ⟹ integers `a b c d N`, `N ≠ 0`, not all even, `a² + c² + m(b² + d²) = N²`, `ab + cd = 0`, `N·u = (a + b√m) + (c + d√m)i` | (2) at `re`, `im`; `‖u‖ = 1` and `√m` irrational split the rational and the `√m` part; clear denominators; a least `N` is not all even | yes (the plan says `N > 0`, the statement `N ≠ 0`: weaker, and enough for every reader) |
| 4 | `dyadic_shape_one_mod_four` | `m ≡ 1 (4)`, an integer solution not all even ⟹ `N` odd and `a+b+c+d` odd, or `N ≡ 2 (4)`, `2 ∣ a−b`, `2 ∣ c−d`, `(a−b+c−d)/2` odd | cast to `ZMod 8`, `decide` over `8⁵` tuples per value of `m`; price it from the first | yes |
| 5 | `dyadic_shape_two_mod_four` | `m ≡ 2 (4)` ⟹ `N` odd and `a+c` odd, or `N ≡ 2 (4)`, `a`, `c` even, `b`, `d` odd, `a/2 + c/2 + d` odd | the same | yes |
| 6 | `dyadic_shape_three_mod_eight` | `m ≡ 3 (8)` ⟹ `N` odd and `a+b+c+d` odd, or `N ≡ 2 (4)`, `2 ∣ a−d`, `2 ∣ b−c`, `b+d` odd | all-odd quadruples excluded modulo 16 first, then modulo 8 | yes |
| 7 | `exists_addMonoidHom_one_mod_four` | `m ≡ 1 (4)`, not a square ⟹ `Λ ≤ ℂ`, `ψ : Λ →+ ZMod 2`, every unit vector of `ℚ(√m)²` in `Λ` with `ψ u ≠ 0` | `e : ℚ⁴ →+ ℂ` injective; `Γ` = the `p` whose forms `(p₁−p₂, 2p₂, p₃−p₄, 2p₄)` have odd denominators; `ψ₀ = red t₁ + red t₃`; `Λ = Γ.map e` | yes |
| 8 | `exists_addMonoidHom_two_mod_four` | `m ≡ 2 (4)` ⟹ the same | forms `(p₁, p₃, p₂−p₄, 2p₄)`; `ψ₀ = red t₁ + red t₂ + red t₄` | yes |
| 9 | `exists_addMonoidHom_three_mod_eight` | `m ≡ 3 (8)` ⟹ the same into `ZMod 2 × ZMod 2` | forms `(p₁−p₄, p₃+p₂, 2p₄, −2p₂)`; `ψ₀ = (red t₁ + red t₂, red t₃ + red t₄)` | yes |
| 10 | `colorable_two_planeOver_sqrt` | `m` squarefree, `m ≢ 3 (4)` ⟹ the plane over `ℚ(√m)` is two-colourable | `4 ∣ m` against squarefree; `m = 1` inside `ℚ(√2)`; the two classes by (7), (8) and (1) | yes |

`colorable_four_planeOver_sqrt` is proved in the skeleton over (9) and (1).

**The table's rows re-derived by hand before any proof** (one mind, mine; the planner's exact check stands beside it):
with `Q1: a² + c² + m(b² + d²) = N²`, `Q2: ab + cd = 0`, not all even —
- every class, `N` odd: `Q1` modulo 2;
- `m ≡ 1 (4)`, `N` even: `Q1` modulo 4 makes the number of odd ones among `a, b, c, d` 0 or 4, so 4; odd squares are
  `1 (mod 8)`, so `N² ≡ 2 + 2m ≡ 4 (mod 8)` and `N ≡ 2 (mod 4)`; `Q2` modulo 4 makes exactly one of `a ≡ b`, `c ≡ d (mod 4)` hold;
- `m ≡ 2 (4)`, `N` even: `a ≡ c (mod 2)`; both odd gives `b² + d²` odd by `Q1` modulo 4 and then `ab + cd` odd; so `a = 2a'`,
  `c = 2c'`, `b ≡ d`, both odd; `Q2` gives `a' + c'` even, and `Q1` modulo 8 then `N² ≡ 4`;
- `m ≡ 3 (8)`, `N` even: `Q1` modulo 4 gives as many odd among `a, c` as among `b, d`; one each: `Q2` modulo 2 pairs the odd
  ones as `(a, d)` or `(c, b)`, `Q2` modulo 4 gives the even ones the same residue modulo 4, and `Q1` modulo 8 gives `N² ≡ 4`;
  all odd: `(b² + d²)(c² + m b²) = (N b)²` (from `Q1`, `Q2`: `b²·Q1 − (ab − cd)·Q2`), whose left side is `2·4 ≡ 8 (mod 16)`, not a square.
So: **`Q1` is read modulo 8 and `Q2` modulo 4, and both depend only on the residues of `a, b, c, d, N` modulo 4**
(`x² ≡ (x mod 4)² (mod 8)`), but for the all-odd case of the third class, which has a proof in three lines.

**Re-priced from the first leaf** (the brief; `LEAN.md` § The kernel's cost model): the plan's check — residues modulo 8,
`8⁵` tuples per value of `m` — as a `Bool` over `List.range 8`, `decide +kernel`: **10.6 s in the kernel for one class
and 5.1 GB** (`data/fs131/id1/probes/decide_cost.lean`, its log `logs/decide_cost.out`). Three of them would be half a
minute of every build of this module and over the 4 GB a one-file slot holds. **Route chosen**: the same exhaustion over
residues modulo 4 (`4⁵ = 1024` tuples per value of `m` modulo 8), one generic bridge from integers to the check, the all-odd
case of the third class by the identity above. The statements are untouched; this is the proof's shape only.

**The statement check, armed before any edit** (`data/fs131/id1/statements.sh`, `statement_diff.py`,
`lean/StatementFooter.lean`; the pattern is FS131-IU1's, and the defect its record names is avoided the same way — the
skeleton at `34d9113b2` and the working file are both elaborated at one path): on the untouched file, 11 theorems
compared (stored types by Lean's hash and text; each head as source text; the Spec section byte for byte), **PASS**;
control, three planted faults (one stored statement changed by a character, one kind changed, one declaration removed):
3 of 3 reported. The module has no compiled `.olean` in this tree (its build is an older job's), so the reading "before
the first rebuild" is the skeleton's own elaboration at the base commit, kept as `data/fs131/id1/stmt/Skeleton.txt`.

## Stage 2 — SAVED: leaves 1–3 (the residue colouring at the plane; coordinates; a unit vector in integers)

The file elaborates under `lake env lean` with the lakefile's options and `linter.missingDocs`: exit 0, seven
`declaration uses sorry` (the seven leaves left), no other message (`data/fs131/id1/logs/DyadicQuadratic.stage2.out`;
4 s, 3.6 GB). Statement check: PASS, control 3 of 3 (`logs/statements-stage2.out`).

- **`colorable_planeOver_of_addMonoidHom`** — the plan's route, as written: `Fintype.ofFinite`, `colorable_of_residue`
  at `f = (↑)`; an edge of the induced graph has a difference with coordinates in `F` (`Subfield.sub_mem`) and norm 1
  (`Complex.dist_eq`), so it is a unit vector; `cosetResidue_apply_of_mem`. 17 lines.
- **`exists_rat_add_mul_sqrt_eq`** — the plan's route: `Subfield.closure_induction`; the product by `√m·√m = m`; the
  inverse in three cases (conjugate `0`: `x = 2p`; `x = 0`; otherwise `(p − q√m)/(p² − mq²)`). No irrationality. 37 lines.
- **`exists_int_solution_of_mem_unitVectors`** — the plan's route with one change of instrument: "not all even" is by
  **induction on `|N|`** (an all-even representation halves), a private lemma `exists_not_all_even` that reads nothing
  about `m` or `u`, in place of `Nat.find` on the least `N` (the same descent, no decidability of the predicate needed).
  A second private lemma, `rat_eq_zero_of_add_mul_irrational` (`A + B·x = 0`, `x` irrational, `A B : ℚ` ⟹ `A = B = 0`),
  splits `|u|² = 1`. Denominators: `D` the product of the four, so `N = D > 0`.

Private helpers so far: `rat_eq_zero_of_add_mul_irrational`, `exists_not_all_even`.

## Stage 3 — SAVED: leaves 4–10 (the three shapes; the three additive maps; the two-colour row) — the file has no `sorry`

The file elaborates under `lake env lean` with the lakefile's options and `linter.missingDocs`: **exit 0 and an empty
message log** — no `sorry`, no warning (`data/fs131/id1/logs/DyadicQuadratic.stage3.out`, 0 bytes; 15.6 s behind the
slot, 3.9 GB). Statement check: PASS, control 3 of 3 (`logs/statements-stage3.out`): 11 skeleton theorems unchanged,
21 private helpers new (16 theorems, 5 definitions). Axioms of all 32 declarations, from a footer on a copy of the file
(`data/fs131/id1/axioms_footer.sh`, `axioms-footer.txt`): each within `[propext, Classical.choice, Quot.sound]`;
control (a planted `sorry`): reported (`logs/axioms-footer.control.out`). The build is the next stage.

**The three shape lemmas** — the plan's exhaustion, at a smaller modulus (§ Stage 1's re-pricing), by one generic bridge:
- `shapeCheck ms P : Bool` (private) — for every `m ∈ ms` (a residue modulo 8) and residues `a b c d n < 4`: `Q1` modulo 8
  → `Q2` modulo 4 → not all even → `P a b c d n`, as nested `List.all` over `decide` of the implication;
- `shape_of_check` (private) — if the check passes and `m % 8 ∈ ms`, an integer solution not all even has residues
  modulo 4 (as naturals, with their casts) satisfying `P`. Its two steps: `x mod 4 · x mod 4 ≡ x² (mod 8)`
  (`emod_four_mul_self_modEq`) and `Int.ModEq` congruence; `Int.natCast_modEq_iff` back to `ℕ`;
- each lemma is then `shape_of_check (by decide +kernel)` at its `P` and an `omega` read-back
  (`Int.odd_iff`; `/ 2`, `% 4`, `2 ∣` are literals to `omega`). The three checks are `4⁵·2`, `4⁵·2` and `4⁵` tuples.
- **`dyadic_shape_three_mod_eight`**: its `P` carries one alternative more, "`b`, `c`, `d` odd", which residues modulo 4
  cannot exclude; it is excluded by `not_odd_of_three_mod_eight` (private): `(b² + d²)(c² + m b²) = (N b)²`
  (`linear_combination b² · Q1 − (ab − cd) · Q2`), the left side `≡ 8 (mod 16)` (`sq_emod_eight_of_odd`), no square
  (`sq_emod_sixteen_ne_eight`). The parity of `a` is not read. This replaces the plan's cast to `ZMod 16`.
- **Negative control of the exhaustion** (`data/fs131/id1/probes/shape_plant.lean`, log `logs/shape_plant.out`): the
  module's three checks pass; four planted ones — class A's conclusion at `m ≡ 3 (mod 4)`, class B's at `m ≡ 0 (mod 4)`,
  class C's at `m ≡ 7 (mod 8)`, and class C's at `m ≡ 3 (mod 8)` with the all-odd alternative left out — each end in
  `decide`'s "proved that the proposition … is false": **four error lines, at the four plants**. The last is the reason
  the separate lemma exists.

**The three additive maps** — the plan's objects with one simplification, **found while writing and worth the
planner's eye: one form per class is enough**. The plan's lattice is the set of `p ∈ ℚ⁴` at which four forms have odd
denominator, and `ψ₀` is a sum of reductions of some of them. The leaf asks only for *some* subgroup `Λ`, so take the
subgroup where the one form `s = Σ` (the sum the plan reduces) has odd denominator, and `ψ₀ = red ∘ s`:

| class | the form `s` on `(p₁, p₂, p₃, p₄)` | at a unit vector `(a, b, c, d)/N` |
|---|---|---|
| `m ≡ 1 (4)` | `p₁ − p₂ + p₃ − p₄` | `N` odd: `(a − b + c − d)/N`, numerator odd; `N = 2M`: `((a − b + c − d)/2)/M`, numerator odd |
| `m ≡ 2 (4)` | `p₁ + p₃ + 2p₄` | `N` odd: `(a + c + 2d)/N`; `N = 2M`: `(a/2 + c/2 + d)/M` |
| `m ≡ 3 (8)` | `s₁ = p₁ + p₂ + p₃ − p₄`, `s₂ = 2p₄ − 2p₂` | `N` odd: `s₁` has odd numerator; `N = 2M`: `s₁ = ((a + b + c − d)/2)/M`, `s₂ = (d − b)/M` with `d − b` odd |

Private pieces: `oddDen : AddSubgroup ℚ` (odd denominators; `Rat.add_den_dvd`), `red : oddDen →+ ZMod 2` (`Rat.cast`,
additive by `Rat.cast_add_of_ne_zero`), `mem_oddDen_of_eq_div` (an integer over an odd integer), `red_ne_zero` (an odd
integer over an integer does not reduce to `0`: `M • q = z` and `red` is additive — the residue itself is never
computed), `form k₁ k₂ k₃ k₄ : ℚ⁴ →+ ℚ` with `form_div_eq`, `coordHom m : ℚ⁴ →+ ℂ` with `coordHom_injective` (`√m`
irrational), `exists_addMonoidHom_of_lattice` (any `Γ ≤ ℚ⁴` and `ψ₀`: `Λ = Γ.map`, `ψ = ψ₀ ∘ equivMapOfInjective⁻¹`,
as the plan has it), `exists_addMonoidHom_of_form` (one form: `Γ = oddDen.comap s`, `ψ₀ = red ∘ s`), and
`not_isSquare_of_mod_four` (`m ≡ 2, 3 (mod 4)` is no square). Each class's leaf is then its shape lemma and two `omega`s.

**`colorable_two_planeOver_sqrt`** — the plan's composition as written: `4 ∣ m` against `Squarefree` (`2 * 2 ∣ m`,
`Nat.isUnit_iff`); `m = 1` through `fieldOfRadicands {1} ≤ fieldOfRadicands {2}` and
`SimpleGraph.Colorable.of_hom (induceHomOfLE …).toHom`; `m ≡ 1`, `m ≠ 1`: not a square (`Squarefree` at `r`); `m ≡ 2`.
`Nat.card_zmod`.

**No leaf resisted**: every leaf went through on its first route; nothing is left as `sorry`.
