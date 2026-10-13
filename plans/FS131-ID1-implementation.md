# FS131-ID1 — the implementer's record: `Arith/DyadicQuadratic`, 10 leaves

*de Bruijn, the implementer (Opus 5.5). Brief: `data/fs131/briefs/FS131-ID1-leaves.md` (on `main`). Worktree
`.claude/worktrees/fs131-wdq`, branch `fs131-wdq`, cut at the skeleton's commit `34d9113b2`. Working files:
`data/fs131/id1/`. Nothing pushed (the brief: the remote is unreachable).*

## Theorems this phase proved

Eleven kernel theorems, all in `Proofs/HadwigerNelson/Arith/DyadicQuadratic.lean`, namespace
`HadwigerNelson.DyadicQuadratic`; each **[kernel]**, on exactly `[propext, Classical.choice, Quot.sound]`, printed from
the built module (`data/fs131/id1/axioms.txt`; § Stage 4). Ten were the skeleton's leaves; the eleventh was proved over
them in the skeleton and is a theorem now that they are. No statement is this job's: they are FS131-KN4's and
FS131-KN5's, unchanged (§ Stage 4, the statement check). **No value here is new**: both rows are `[Fischer1990]`'s
(§ Drafts, the attribution).

| declaration | what it says | axioms |
|---|---|---|
| `colorable_planeOver_of_addMonoidHom` | an additive map on a subgroup of `ℂ` holding the unit vectors of `F²`, into a finite group `G`, never `0` at one, makes the plane over `F` `Nat.card G`-colourable; every `F ≤ ℝ` | the standard three |
| `exists_rat_add_mul_sqrt_eq` | every element of `ℚ(√m)` is `p + q√m`, `p q : ℚ`; every `m : ℕ` | the standard three |
| `exists_int_solution_of_mem_unitVectors` | `m` not a square: a unit vector of `ℚ(√m)²` is `((a + b√m) + (c + d√m)i)/N` in integers not all even, with `a² + c² + m(b² + d²) = N²`, `ab + cd = 0` | the standard three |
| `dyadic_shape_one_mod_four` | `m ≡ 1 (mod 4)`: such a solution has `N` odd and `a+b+c+d` odd, or `N ≡ 2 (mod 4)`, `a ≡ b`, `c ≡ d (mod 2)`, `(a−b+c−d)/2` odd | the standard three |
| `dyadic_shape_two_mod_four` | `m ≡ 2 (mod 4)`: `N` odd and `a+c` odd, or `N ≡ 2 (mod 4)`, `a`, `c` even, `b`, `d` odd, `a/2 + c/2 + d` odd | the standard three |
| `dyadic_shape_three_mod_eight` | `m ≡ 3 (mod 8)`: `N` odd and `a+b+c+d` odd, or `N ≡ 2 (mod 4)`, `a ≡ d`, `b ≡ c (mod 2)`, `b+d` odd | the standard three |
| `exists_addMonoidHom_one_mod_four` | `m ≡ 1 (mod 4)`, not a square: a subgroup `Λ ≤ ℂ` and `ψ : Λ →+ ZMod 2`, every unit vector of `ℚ(√m)²` in `Λ` with `ψ ≠ 0` there | the standard three |
| `exists_addMonoidHom_two_mod_four` | `m ≡ 2 (mod 4)`: the same | the standard three |
| `exists_addMonoidHom_three_mod_eight` | `m ≡ 3 (mod 8)`: the same into `ZMod 2 × ZMod 2` | the standard three |
| `colorable_two_planeOver_sqrt` | **NF4-DYADIC-TWO, kernel form**: `m` squarefree, `m ≢ 3 (mod 4)` ⟹ the plane over `ℚ(√m)` is two-colourable | the standard three |
| `colorable_four_planeOver_sqrt` | **NF4-DYADIC-FOUR, kernel form**: `m ≡ 3 (mod 8)` ⟹ the plane over `ℚ(√m)` is four-colourable | the standard three |

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

## Stage 4 — SAVED: the one build; the built module read back (statements, axioms, models); the linters

**The build** — `data/fs131/id1/build_sampled.sh data/fs131/id1/logs/build1 8`, i.e. `scripts/slot.py --mem 10 --cpus 4
-- env MEMMAX=10G BATCH=8 ./scripts/build.sh`: **exit 0**, `==> build: OK — 248 of 248 batches, 39 module(s) rebuilt,
3 module(s) with warnings, 8m46s` (2026-10-13 20:07:49Z to 20:16:40Z; `data/fs131/id1/logs/build1.{out,err,peak,exit}`;
the gate's own copy `build/gate/build/20261013T200749Z-786451.log`). Resume command, had it died: the same line (Lake
keeps every module it finished).
- **Zero warnings from this file**: `✔ [5161/5161] Built Proofs.HadwigerNelson.Arith.DyadicQuadratic (13s)` with no
  message under it; the gate log holds no line naming `Arith/DyadicQuadratic.lean`. (The two lines naming the module at
  the log's head are the up-to-date probe's "target is out-of-date", exit 3, before the walk.)
- The three modules with warnings are the line's other three skeletons on this branch — `Arith/ThreeColourCharacter`,
  `Arith/TorsionExtraction`, `Arith/ThreeColourCriterion` — 31 `declaration uses sorry` (8 + 10 + 13), nothing else.
  They are other jobs' and are as the skeleton's commit has them here.
- 39 rebuilt because this tree's `.lake/build` was an older job's: `Plane/…` (24), `Outside/…` (10), this line's four
  and `Proofs`. Peak: 15.6 GB as a sum of resident memory over the build's process
  tree (four `lean` at once in the widest batches; pages of `.olean` files mapped by several processes are counted once
  each time, so an upper estimate — the planner's 5.4 GB was a chain two wide); the scope's 10 GB cap did not fire.

**No statement changed, from the kernel's side** (Done means 3) — two readings, each with its control:
1. *Between builds* (`data/fs131/id1/statements.sh`, at stages 1–3): the skeleton at `34d9113b2` and the working file,
   each elaborated at one path with a footer printing every constant's stored type; 11 of 11 identical in kind, Lean's
   hash and text; each theorem's head and the Spec section (the four `example`s) identical as source text. Control: 3
   of 3 planted faults reported, each time.
2. *From the built module* (`data/fs131/id1/lean/StatementDump.lean` → `statements-built.txt`, 127 constants stored;
   `statements_built.py` against `stmt/Skeleton.txt`): **11 of 11 the same kind, the same hash, the same text**; no
   public constant in the built module beyond the skeleton's eleven; 21 private helpers (`logs/statements-built.out`).
   The two prints come from two paths, so the one statement with instance binders
   (`colorable_planeOver_of_addMonoidHom`: `[AddCommGroup G] [Finite G]`) stores binder *names* carrying each file's
   module name; the reader rewrites exactly those two module names inside the pattern `_@.<module>.<n>._hygCtx` and
   says how many statements it touched (1). Lean's hash reads no binder name and is equal unrewritten.
   Controls (`logs/statements-built.control.out`): three planted faults, 3 of 3; a hash moved by one, reported; **the
   rewrite switched off: one TEXT difference, on the one statement carrying such a name** — so the rewrite is not what
   makes the other ten agree.
3. The source's side: `git diff 34d9113b2` on the module removes **exactly ten lines, each `  sorry`**, and adds 548
   (`logs/module.diff`). No docstring of the skeleton was edited.

**The tool defect I made and its control caught** (the brief asked me to read IU1's before copying; this is its
sibling): my first rewrite pattern matched any module name, so it also "normalized" a hygienic binder name minted in
Mathlib (`x._@.Mathlib.Data.FunLike.Basic.2582841819._hygCtx._hyg.11`, in the three `exists_addMonoidHom_*` statements)
that is the same from every path. The comparison passed either way; the control "rewrite off ⟹ a difference on every
statement the rewrite touches" read 1 difference against 4 touched and failed, as it should. The pattern now names
this file's two module names and nothing else.

**The axioms, from the built module** (Done means 4): `data/fs131/id1/lean/Axioms.lean` (generated with the audit block
by `make_audit.py` from the kernel's list and the source's order) → `axioms.txt`: **11 records, each
`[propext, Classical.choice, Quot.sound]`**, the same list in the same order as the audit block
(`read_axioms.py`, `logs/axioms.out`); control: a `sorryAx` record and an undeclared axiom, 2 of 2 reported. No declared
outside theorem is read; no `native_decide` (the three exhaustions are `decide +kernel`).

**The models** (`data/fs131/id1/lean/Models.lean` → `models.txt`, 15 theorems, each on the standard three): § Drafts.

**The environment linters** — `lake lint --no-build -- --no-build --trace` under the slot, after the build: exit 0,
`-- Linting passed for Proofs.`, fourteen linters `(2/2) Passed!` (`logs/lint.out`). `tools/check_architecture.py`:
`RESULT: PASS` (`logs/check_architecture.out`; no module was added). I planted no fault in the house's linters: their
controls are the gate's.

**Not run, because they are the landing's** (the brief; KN5's § Stage 7): `scripts/axioms.sh` with the block filed,
`scripts/dupnames.sh`, `scripts/vacuity.sh`, `scripts/assumptions.sh` on the joined tree. This module declares no axiom,
no hypothesis former and no public definition, and every name it adds is private.

## Drafts for the front page

*For the landing. Each names its slot. Nothing here is filed by this job.*

### D1 — `scripts/Axioms.lean`, the CLEAN section: the audit block for this file

`data/fs131/id1/audit-block.txt`, verbatim (11 `#print axioms` lines under a four-line header): every public
declaration a person typed, in the file's order, all theorems. The 21 private declarations (16 theorems, 5 definitions:
`shapeCheck`, `oddDen`, `red`, `form`, `coordHom`) cannot be named there; each is read by one of the eleven. Expected at
the landing: **11 CLEAN records more, no purchase, no import** (`CLAUDE.md` § Trust ledger's first count moves by 11
for this module; its other counts and the nine of the assumptions step do not move for it).

### D2 — the models: for the landing's record (`LEAN.md` § The gate, "every theorem whose hypothesis is a structure")

The vacuity scan tracks none of this module's hypotheses (sets, maps under predicates, integer equations), so silence
there is not evidence; these are the inhabitants, **each held by the kernel** in `data/fs131/id1/lean/Models.lean`
(outside the library; 15 theorems, each on the standard three, `data/fs131/id1/models.txt`):

| statement | every hypothesis satisfied at | the model's theorem |
|---|---|---|
| `colorable_planeOver_of_addMonoidHom` | `F = ℚ(√2)`, `G = ZMod 2`; `F = ℚ(√5)`, `G = ZMod 2`; `F = ℚ(√3)`, `G = ZMod 2 × ZMod 2` — the hypothesis is the conclusion of the three `exists_addMonoidHom_*`; and it is no statement about an empty set: `1` is a unit vector of every `F` | `hom_model_two`, `hom_model_five`, `hom_model_three`, `colorable_model`, `one_mem_unitVectors` |
| `exists_rat_add_mul_sqrt_eq` | `m = 7`, `x = √7` | `coordinates_model` |
| `exists_int_solution_of_mem_unitVectors` | `m = 2` (not a square), `u = 1` | `int_solution_model` |
| `dyadic_shape_one_mod_four` | `N` odd: `m = 5`, `(1, 0, 0, 0, 1)`; `N ≡ 2 (mod 4)`: `m = 17`, `(1, 1, 1, −1, 6)` — the unit vector `((1 + √17) + (1 − √17)i)/6` | `shape_one_odd`, `shape_one_even` |
| `dyadic_shape_two_mod_four` | `m = 2`: `(1, 0, 0, 0, 1)`; `(0, 1, 0, 1, 2)` — `(√2 + i√2)/2` | `shape_two_odd`, `shape_two_even` |
| `dyadic_shape_three_mod_eight` | `m = 3`: `(1, 0, 0, 0, 1)`; `(1, 0, 0, 1, 2)` — `(1 + i√3)/2` | `shape_three_odd`, `shape_three_even` |
| `exists_addMonoidHom_one_mod_four` / `_two_` / `_three_mod_eight` | `m = 5`; `m = 2`; `m = 3` | `hom_model_five`, `hom_model_two`, `hom_model_three` |
| `colorable_two_planeOver_sqrt` | `m = 1`, `2`, `5`, `17` (squarefree, not `3 (mod 4)`) | `two_model` |
| `colorable_four_planeOver_sqrt` | `m = 3`, `11`, `35` | `four_model` |

Both alternatives of each shape lemma are met, so neither disjunct is idle. The module's own Spec section holds the
class arithmetic, one application of `colorable_four_planeOver_sqrt` at `m = 11`, and two of the solutions above.
No statement of the module concludes `False`, and no hypothesis is empty at any parameter.

### D3 — what a reader of the statements should be told that the docstrings do not say

1. **Attribution — both rows are prior art; nothing here is claimed as this project's but the kernel form.** By
   `BIBLIOGRAPHY.md`'s row for `[Fischer1990]` (K. G. Fischer, *Additive k-colorable extensions of the rational plane*,
   Discrete Math. 82 (1990) 181–195): "Theorems 8–10: the complete real-quadratic classification — 2 colours iff
   N ≢ 3 (mod 4), 3 colours for N ≢ 2 (mod 3) …, 4 colours for N ≡ 3 (mod 8), no additive k ≤ 6 for N ≡ 23 (mod 24)";
   and `[Johnson2000]` p. 176, as that file quotes it: "Fischer does show that if m ≡ 3 mod 8, then
   χ(ℚ²(√m), 1) ≤ 4". So `colorable_two_planeOver_sqrt` and `colorable_four_planeOver_sqrt` are **Fischer's values
   (1990)**, restated by Johnson; an additive colouring — a homomorphism from a group holding the unit vectors, never
   `0` at one — is Fischer's notion (the same row: "additive colourings = our residue colourings"), and
   `colorable_planeOver_of_addMonoidHom` is this library's `colorable_of_residue` read at the plane. The claim list
   says it in one line (NF4-NC): "any upper bound as this project's (every upper bound here is prior art…)". The
   two-colour *classification over every real number field* is an outside model's derivation (NF4-NC, NF4-OBJECTION);
   this module states the quadratic case only and reads none of it. **I have not read `[Fischer1990]` in this job**: the
   attribution is `BIBLIOGRAPHY.md`'s, copied; whether the map `ψ` of each class is Fischer's own colouring is not
   checked here. What is this job's is proofs of statements the planners typed.
2. **Each headline is an upper half.** `colorable_two_planeOver_sqrt` is `χ ≤ 2`; "`= 2`" also needs an edge (the
   lower bound 2 — by KN5's § Stage 7, `Instances/UpperHalfValues.two_le_chromaticNumber_planeOver` on branch
   `fs131-wnf`, which I have not opened).
   `colorable_four_planeOver_sqrt` is `χ ≤ 4` at every `m ≡ 3 (mod 8)`; it is sharp only where the lower bound four
   holds (`m ≡ 11 (mod 12)`, the three-colour line's `TorsionExtraction`), i.e. at `m ≡ 11 (mod 24)` — at `m = 3`, `19`
   the claim's printed value is 3 (NF4-THEOREM: "`3` for `m ≡ 3, 7 (mod 12)`").
3. **The claim's dated line speaks of primes; the module proves colourings.** NF4-DYADIC-TWO reads "needs a stable prime
   of Q(sqrt m)(i) above 2 ramified over Q(sqrt m)" and NF4-DYADIC-FOUR "needs the stable prime above 2 with residue
   field F_4". No `StablePrime` is built or read here: the module's docstring says so ("The primes themselves … are
   corollaries in the joining module"), and J.10 of the joining text is where the prime at `m ≡ 3 (mod 8)` is typed.
4. **The subgroup `Λ` of the proofs is larger than the lattice the docstrings describe.** The three
   `exists_addMonoidHom_*` docstrings name the points of the unit vectors' shape and `ψ` on them. The proofs take the
   subgroup where **one integer form** has odd denominator — `p₁ − p₂ + p₃ − p₄`; `p₁ + p₃ + 2p₄`; and the pair
   `p₁ + p₂ + p₃ − p₄`, `2p₄ − 2p₂` — and `ψ` = that form modulo 2. On the docstrings' lattice it is the docstrings'
   map; the statements are existential and say neither. A consumer (J.10) reads only: `Λ` is a subgroup holding every
   unit vector, `ψ` is additive, `ψ u ≠ 0`.
5. `exists_int_solution_of_mem_unitVectors` gives `N ≠ 0`; in the proof `N > 0` (a product of denominators), which the
   statement does not say and no reader here needs.
6. The shape lemmas are statements about integers alone (every solution not all even, from a unit vector or not);
   `dyadic_shape_three_mod_eight`'s proof never reads the parity of `a` in its all-odd case.

### D4 — `ARCHITECTURE.md`, the module map, row `Arith/DyadicQuadratic`

Replace "(FS131-KN4, its brief's Amendment 1; restated by FS131-KN5's passes; a skeleton: ten leaves are `sorry`)" by
"(statements FS131-KN4's and FS131-KN5's; proofs FS131-ID1's; no `sorry`; every theorem on the standard three)", and
"the lattice and its map by class" by "an additive map by class, one integer form's reduction modulo 2 on the subgroup
where it has odd denominator". The row's imports (`SpectralChain`) are unchanged: no import was added.

### D5 — `LEDGER.md` and `CLAUDE.md`: no row moves on this module alone

Both values are prior art; I found no numbered row of `LEDGER.md` whose result is either upper bound (searched for
the two classes; its claim list names "Fischer, 1990, additive colourings only" for the neighbouring facts). The first
plan's § 4.8 has the one line this module feeds — "**Row 73**: `χ(ℚ(√11)²) = 4` is then also the dyadic row at `m = 11`" — which waits on the joining module
(the lower half is row 73's). For `CLAUDE.md` § The gate and § Trust ledger the counts are the landing's to measure;
from this module: 11 CLEAN audit records, 127 stored constants, no axiom, no hypothesis former, no vacuity marker.
No Frontier line and no Proof Atlas grade changes on this module alone.

### D6 — `LEAN.md` § Searching — Lean: three lines, if wanted

- "A statement printed by a footer on a copy and the same statement dumped from the compiled module differ only in
  binder names minted in the file (`inst._@.<module>.<n>._hygCtx._hyg.<k>`): rewrite the file's own module names and
  no other — a hygienic name minted in Mathlib (`x._@.Mathlib.Data.FunLike.Basic…`) is the same from every path — and
  compare Lean's hash unrewritten; with the rewrite off the differences must be exactly the statements it touches
  (`data/fs131/id1/statements_built.py`; FS131-ID1)."
- "An exhaustion over residues is priced by its modulus before its instrument: `8⁵·2` tuples of `ℕ` arithmetic under
  `decide +kernel` are 10.6 s and 5.1 GB; a square modulo 8 is read from the residue modulo 4, and the same statement
  over `4⁵·2` tuples is under a second (`Arith/DyadicQuadratic.shapeCheck`; `data/fs131/id1/probes/decide_cost.lean`;
  FS131-ID1)."
- "`omega` reads `Int.natAbs`: after `rw [Int.natAbs_mul]` the term `Int.natAbs 2 * N.natAbs` is a product of two
  atoms to it; state `(2 * N).natAbs = 2 * N.natAbs` as a `have` and rewrite with that (FS131-ID1)."

## Left, and held

- **Leaves left as `sorry`: none.** All ten are proved; the file has no `sorry`.
- **A strengthening at no cost, kept out of the skeleton as the brief says**: `colorable_two_planeOver_sqrt` holds with
  `Squarefree m`, `m % 4 ≠ 3` weakened to **`m % 4 = 1 ∨ m % 4 = 2`** (a square `m ≡ 1 (mod 4)` gives `ℚ(√m) = ℚ ⊆ ℚ(√2)`;
  squarefree and `m % 4 ≠ 3` imply it). Checked by the kernel outside the library, 25 lines over this module's leaves:
  `data/fs131/id1/probes/two_colour_wider.lean` (`colorable_two_planeOver_sqrt_of_mod_four`, on the standard three; at
  `m = 9`, `18`). The skeleton's form is what the table's row reads, and is kept.
- **A simplification of the plan, for the planner's eye** (not a statement): one form per class instead of a lattice of
  four (§ Stage 3). If the joining text's J.10 or a docstring was written against the four-form lattice, D3 item 4 is
  what it should read.
