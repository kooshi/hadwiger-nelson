# FS-131, wave 10 — implementation record: the planes' floor (`NormOneTarget`, `FloorPlanes`)

*Job FS131-I10D (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10d` (cut from the second planner's `330d2f48`). Brief:
`data/fs131/briefs/FS131-I10D-wave10-second.md`. Plan: `plans/FS131-w10-kernel-plan.md` §§ 7.1, 7.3, 9.3, 9.4.*

**What I may change, and what I may not.** Mine: the proof of each open leaf of `Proofs/HadwigerNelson/Arith/NormOneTarget.lean`
(`involution_eq_pow`, `card_normOne`) and of `Proofs/HadwigerNelson/Arith/FloorPlanes.lean` (`sum_quadratic_eq`,
`circle_sum_eq_kloosterman`, `circle_sum_le`, `normOne_charSum_ge`); new helper declarations in those two files, under names no other
module declares; the docstring of `circle_sum_eq_kloosterman`, extended when it is proved (the brief's item 3); a block "FS131-I10D" in
`scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i10d_*.py`; `data/fs131/i10d/`; the report. Not
mine: any statement, hypothesis, conclusion or definition of the skeleton — `KloostermanBound` stays a `Prop` argument (rulings 500 and
510 (c)); a new `axiom`; `native_decide`; the wave's other files; the planner's record; any landed module; `main`; the gate; another
branch.

## Theorems this phase proved

**All six leaves of the brief are proved; neither file has a `sorry`.** Kernel-checked on this branch by `./scripts/build.sh` under
the slot (`data/fs131/i10d/logs/build-3-final.log`, exit 0); axioms `[propext, Classical.choice, Quot.sound]` for each of the 20
records of the "FS131-I10D" block of `scripts/Axioms.lean`, printed with a control that shows `sorryAx`
(`data/fs131/i10d/logs/axioms-all.log`). The branch does not run the gate, so the audit is the landing's. **`KloostermanBound` is
still a `Prop` hypothesis**: no `axiom`, no `native_decide` in either file (grep).

`Proofs/HadwigerNelson/Arith/NormOneTarget.lean` (namespace `HadwigerNelson.StandingFive`), each [kernel on this branch]:

- **`involution_eq_pow`** — informal: "A non-trivial involution of a field of `Q²` elements is the `Q`-th power map" (the file's
  docstring; the plan's P1). Lean, read aloud: for a finite field `k`, a ring endomorphism `σ` with `σ (σ x) = x` for every `x` and
  `σ ≠ RingHom.id k`, and `Fintype.card k = Q ^ 2`: `σ x = x ^ Q` for every `x`. Says the sentence, no more.
- **`card_normOne`** — informal: "the norm-one set has `Q + 1` elements". Lean: in a finite field of `Q²` elements,
  `#{u : u ^ (Q + 1) = 1} = Q + 1`. Over the new **`card_filter_pow_eq_one`**: in a finite field, `u ^ d = 1` has exactly `d`
  solutions when `d ≠ 0` and `d ∣ |k| − 1`.
- **`targetFloor_of_charSum`** (the planner's composition, proved by the planner over the two leaves; now over proved leaves): the
  ratio bound at the level-one target.

`Proofs/HadwigerNelson/Arith/FloorPlanes.lean` (same namespace), each [kernel on this branch]:

- **`sum_quadratic_eq`** — informal: "completing the square: `Σ_y ψ(r y² + c y) = ψ(−c²/(4r))·χ(r)·G`" (`[MMST1996]` (7)–(9) as the
  plan's § 7.3 reads them). Lean: `F` a finite field with `ringChar F ≠ 2`, `ψ ≠ 1`, `r ≠ 0`, any `c`; `χ` is `quadraticChar F` cast
  to `ℂ`, `G = gaussSum χ ψ`. Over **`sum_addChar_mul_sq`** (`Σ_y ψ(r y²) = χ(r)·G`) and **`sum_addChar_mul_left`** (orthogonality).
- **`circle_sum_eq_kloosterman`** — informal: "`λ(c) = −K(1, c/4)`", the identity M58 §R1 checked in floats and FS-20's open item
  R4; `[MMST1996]` formula (11) at `n = 2`. Lean, read aloud: for a finite field of odd characteristic, `ψ ≠ 1`, **any** `a`, and
  `b ≠ 0` in `F × F`: `Σ_{s₁² + s₂² = a} ψ(b₁s₁ + b₂s₂) = χ(−1)·Σ_{x ∈ Fˣ} ψ(−a·x + −((b₁² + b₂²)/4)·x⁻¹)`. At `a = 1` and
  `|F| ≡ 3 (mod 4)`, `χ(−1) = −1`, and `x ↦ −x` turns the right side into `−Σ_x ψ(x + (c/4)·x⁻¹) = −K(1, c/4)` with
  `c = b₁² + b₂²`: the informal identity (the substitution is not a Lean statement; the kernel theorem is the displayed one). Against
  (11) as the plan quotes it, `λ_{2b} = (1/q)·G₁ⁿ·K(χⁿ | a, d(b,0))`: at `n = 2`, `G₁² = χ(−1) q` and `d(2b,0)/4 = d(b,0)` — agrees,
  up to the paper's own definition of `K`, which I did not read. **Its docstring now says it is the kernel form of an identity the
  project had only ever checked numerically** (the brief's item 3). Over **`sum_plane_quadratic`** and
  **`sum_eq_zero_add_sum_units`**.
- **`circle_sum_le`** — informal: `[MMST1996]` Theorem 3 at `n = 2` with the restriction `a ≠ 0` its print omits. Lean: odd
  characteristic, `KloostermanBound F`, `ψ ≠ 1`, `a ≠ 0`, `b ≠ 0`: `‖Σ_{s₁² + s₂² = a} ψ(b·s)‖ ≤ 2·√|F|`. It is the `a ≠ 0` case of
  the new **`circle_sum_le_of_ne`**, which holds at the class the argument reads: `a ≠ 0` **or** `b₁² + b₂² ≠ 0`.
- **`normOne_charSum_ge`** — informal: "every non-trivial additive character sums to real part at least `−2√Q` over
  `{u : u ^ (Q + 1) = 1}`, given Weil's bound at the fields of `Q` elements" (its docstring; the plan's P6). Lean: `k : Type` a field
  of `Q²` elements, `Q % 4 = 3`, `KloostermanBound F` at every field `F : Type` of `Q` elements, `ψ ≠ 1`:
  `−(2·√Q) ≤ Re Σ_{u ^ (Q+1) = 1} ψ(u)`. Over **`exists_ringHom_pow`**, **`card_filter_pow_eq_self`**, **`exists_mulShift_eq`**.
- **`targetFloor_seven_of_kloosterman`** (the planner's composition; now over proved leaves) — the row: G56's "every usable plane …
  refuses six by Weil from 98". Lean: for `Q % 4 = 3`, `98 ≤ Q`, if `KloostermanBound F` holds at every field of `Q` elements then
  `TargetFloor 7 Q` — every field of `Q²` elements with a non-trivial involution has a level-one target needing seven colours. **Its
  one assumption, by name: `StandingFive.KloostermanBound`, a hypothesis.** Not checked by me: that the level-one target at `Q` is
  `finitePlane Q` as a graph (no Lean statement in these two files links them; `normOne_charSum_ge`'s proof builds the coordinates
  `k = k₀ ⊕ k₀·ι` and the norm `u₁² + u₂²`, at the level of the sums only).
- **New, not in the plan, one mind (mine), owed the planner's read-back**: **`circle_sum_le_of_ne`** (above);
  **`circle_sum_zero_of_isotropic`** — at radius `0` and `b ≠ 0` with `b₁² + b₂² = 0` the circle sum **is** `χ(−1)·(|F| − 1)`;
  **`two_sqrt_lt_circle_sum_zero`** — and so exceeds `2√|F|` as soon as `|F| ≥ 6`. Together: given Weil's bound, the printed
  `[MMST1996]` Theorem 3 at `n = 2` fails exactly at radius zero with `b` isotropic, in fields of at least six elements; the spec
  example runs it at the planner's `q = 13`, `b = (1, 5)`.
- Helpers of general use: `sum_units_addChar_mul` (`Σ_{x ≠ 0} ψ(c x) = −1`), and those named above (twelve new theorems in
  all, listed in Stage 3 for the join).

## Stage 1 — SAVED (FS131-I10D): the readback, the build as given

**Quotations** (standing rule 3), by script — `grep -F` of each quoted string in the file the brief names, with a planted string that
must read missing (`data/fs131/i10d/logs/quotations.sh`, output `data/fs131/i10d/logs/quotations.txt`): **seventeen of seventeen
match** — `CLAUDE.md` § Counter-priors; inventory items 500, 503, 509, 510 (`plans/FS131-close-inventory.md` on `main`, where they are
filed; this branch's copy predates them); the six leaves' first lines and `KloostermanBound`'s in my two files; the plan's five
headings.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch it fail
(to its two-sided-plant paragraph); the plan's "Theorems this phase proved (FS131-K10b)" and Stages 6–9; inventory items 500, 509,
510 (503 is `ProductFactor`'s, read for its first sentence only); `NormOneTarget.lean` and `FloorPlanes.lean`; `StandingFive.lean`
ll. 1–25, 104–156 (`normOneCayley`, `TargetFloor`, `StandingFloor`); `RatioBound.lean` ll. 1–40, 148–201. The row's entry: G56's
"every usable plane … refuses six by Weil from 98" as the plan's § 7.3 reads it back, and `BIBLIOGRAPHY.md`'s `[MMST1996]` and
`[Weil1948]` rows on `main` (the second now held: its p. 207 displays the bound for a field of `q` elements, characteristic not 2 —
the read-back against `KloostermanBound` is the importing job's, not mine).

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, "all 1781 modules
already up to date", **23** `declaration uses sorry` warnings — `NormOneTarget` 2 and `FloorPlanes` 4 (mine), `Floor128` 1,
`ProductFactor` 1, `MajorityVote` 1, `NegCircleModel` 2 (the pass's other implementers'), `StandingFive` 9, `StationaryRatio` 3
(proved on other branches): the brief's count (`data/fs131/i10d/logs/build-0-as-given.log`).

**The statement check** (`tools/fs131_i10d_statements.py`, against `330d2f48`): every declaration of the base version of a file must
be in the working tree with its statement verbatim — a theorem to its first ` :=`, a definition whole — and its docstring verbatim or
*extended* (listed on every run, not a failure: the brief asks one docstring to gain a sentence). `--self-test` plants a theorem fault,
a definition fault and a mid-docstring fault, each required to fire, and a docstring extension required to pass and be listed; where
a file declares no definition the control says "NOT RUN" instead of passing in silence (the copied tool printed "FIRED" there).
Output at the base: 3 + 7 declarations kept, both self-tests as required (`data/fs131/i10d/logs/statements-0.txt`).

**Mathlib names confirmed by `grep` in the pinned source before any proof** (the plan's ✓ list, and the ones it left to me):
`FiniteField.bijective_frobeniusAlgHom_pow`, `FiniteField.orderOf_frobeniusAlgHom`, `FiniteField.pow_card`,
`FiniteField.forall_pow_eq_one_iff`, `FiniteField.even_card_iff_char_two`, `FiniteField.isSquare_neg_one_iff`,
`FixedPoints.finrank_eq_card`, `Subfield`'s `RingHom.eqLocusField`, `quadraticChar_card_sqrts`, `quadraticChar_sq_one`,
`gaussSum_mulShift`, `gaussSum_sq`, `AddChar.sum_mulShift`, `AddChar.sum_eq_zero_of_ne_one`, `AddChar.to_mulShift_inj_of_isPrimitive`,
`AddChar.card_eq`, `AddChar.exists_apply_ne_zero`.

Token count at this stage: about 120k by my own estimate (the launch context is most of it).

## Stage 2 — SAVED (FS131-I10D): `NormOneTarget` — P1 `involution_eq_pow`, P2 `card_normOne`

**P1, by another route than the plan's** (said here, and in a `--` comment at the head of the proof; the theorem's docstring is the
planner's and still describes the fixed-field argument, which is a true proof and not the one the kernel holds). The plan: the fixed
field has `[k : k₀] = 2` by Artin (`FixedPoints.finrank_eq_card`), then the polynomial `(T − x)(T − σ x)`; hard part named, "the group
action's instances". Taken instead: `σ` is an algebra endomorphism of `k` over its prime field (`ZMod.subsingleton_ringHom` gives
`commutes'`), so it is `Frob ^ j` for one `j < n = [k : 𝔽_p]` (`FiniteField.bijective_frobeniusAlgHom_pow`, in Mathlib at the pin);
`σ² = 1` gives `n ∣ 2j` (`FiniteField.orderOf_frobeniusAlgHom`), `σ ≠ 1` gives `j ≠ 0`, so `2j = n`, `Q² = p^n = (p^j)²`, `Q = p^j`
and `σ x = x ^ p ^ j`. No group action, no fixed field, no polynomial. 43 lines against the plan's 120; one elaboration round.

**P2** over a new helper, **`card_filter_pow_eq_one`**: in a finite field, `u ^ d = 1` has exactly `d` solutions when `d ∣ |k| − 1`,
`d ≠ 0` (`IsCyclic.card_powMonoidHom_ker` on `kˣ`, carried to `k` by an explicit equivalence). `card_normOne` is its instance at
`d = Q + 1`; Stage 3 reads it again at `d = Q − 1`. 30 lines for the two against the plan's 50; two rounds (one unknown constant,
`Nat.sq_sub_sq'`, replaced by a two-line case split).

**Re-priced from these two leaves** (the brief's item 2): 85 inserted lines in `NormOneTarget` — proofs, the helper, comments and one
spec example — against the plan's 170 for P1 + P2, so **half the plan's line count**, as the wave's first two implementers found. The
remaining four leaves, planned at 440 lines, are re-priced at about 220; the whole job at about 250k by the harness's count in place of
the plan's 300k.

**New imports** in `NormOneTarget.lean`: `Mathlib.Algebra.Algebra.ZMod`, `Mathlib.FieldTheory.Finite.Basic`,
`Mathlib.GroupTheory.SpecificGroups.Cyclic` (none was reached through `StandingFive`; `lake env lean` said so by an unknown constant).

**Evidence.** Build under the slot, exit 0, 454 of 454 batches, 5 modules rebuilt (`NormOneTarget`, `FloorPlanes`, `Floor128`,
`TargetFloors`, `Proofs`), every warning a `sorry` of another leaf: 21 left — `FloorPlanes` 4 (mine), the eleven-less-six of this
pass's other files (5), `StandingFive` 9, `StationaryRatio` 3 (`data/fs131/i10d/logs/build-1-p1-p2.log`). Axioms
(`data/fs131/i10d/axioms-group1.lean`, log `data/fs131/i10d/logs/axioms-group1.log`): `involution_eq_pow`, `card_filter_pow_eq_one`,
`card_normOne` and `targetFloor_of_charSum` (the planner's composition, now over proved leaves) each on
`[propext, Classical.choice, Quot.sound]`; the control, `sum_quadratic_eq` (open at this stage), prints `sorryAx`, as it must.
Statement check against `330d2f48`: 3 + 7 declarations kept, PASS (`data/fs131/i10d/logs/statements-1.txt`). `scripts/Axioms.lean`:
block "FS131-I10D" opened with these four.

Token count at this stage: about 190k by my own estimate.

## Stage 3 — SAVED (FS131-I10D): `FloorPlanes` — P3 `sum_quadratic_eq`, P4 `circle_sum_eq_kloosterman`, P5 `circle_sum_le`, P6 `normOne_charSum_ge`

**Routes, per leaf** (each written first in a standalone scratch file over Mathlib alone, then moved into the module; the rounds are
elaboration rounds of the scratch file).

- **P3**, the plan's route, split in two: `sum_addChar_mul_sq` — the fibres of `y ↦ y²` have `1 + χ(x)` points
  (`quadraticChar_card_sqrts`, through `Set.toFinset_setOf`), `Σ_x ψ(r x) = 0`, and `gaussSum_mulShift` with `χ(r)² = 1` — then the
  re-indexing `y ↦ y + c/(2r)` (`Fintype.sum_equiv (Equiv.addRight _)`, `field_simp; ring` for the square). One round.
- **P4**, the plan's route: multiply by `q`; `q·1[t = 0] = Σ_r ψ(r t)` (`sum_addChar_mul_left`, which restates
  `AddChar.sum_mulShift` with the `if` outside the cast — the one thing that cost a round); swap; `sum_plane_quadratic` factors the
  plane sum; at `r = 0` one linear sum vanishes because `b ≠ 0`; at `r ≠ 0` two P3's, `χ(r)² = 1`, `gaussSum_sq`; the split
  `Σ_r = (r = 0) + Σ_{x ∈ Fˣ}` is `sum_eq_zero_add_sum_units`. The "two re-indexings" the plan called hard were one `field_simp;
  ring` each. Three rounds. **The identity holds at every radius, `a = 0` included**; nothing in the proof reads `a ≠ 0`.
- **P5**: stated first at the class the argument reads (`circle_sum_le_of_ne`: `a ≠ 0` or `b` anisotropic), the leaf its `a ≠ 0`
  case. With exactly one of `a`, `b₁² + b₂²` zero the Kloosterman sum is `Σ_{x ≠ 0} ψ(c x) = −1` (for `a = 0` after `x ↦ x⁻¹`,
  `Equiv.inv Fˣ`), and `1 ≤ 2√q`; with neither zero, `hK`. One round.
- **P6**, the plan's route with two simplifications. (i) The `Q`-th power map is a ring endomorphism `τ` (`exists_ringHom_pow`:
  `Q ∣ p^n`, so `Q = p^m`, `iterateFrobenius`), `k₀ = τ.eqLocusField (RingHom.id k)`, and `|k₀| = Q` by counting
  (`card_filter_pow_eq_self`: zero and the `Q − 1` roots of `x ^ (Q − 1) = 1`, Stage 2's `card_filter_pow_eq_one`) — no degree
  argument. (ii) **`ι ^ Q = −ι` directly** from `ι² = −1` and `Q = 4t + 3`; the plan's "`−1` is not a square in `k₀`" is not read.
  Then `φ(u₁, u₂) = u₁ + u₂ ι` is injective (apply `τ`, add and subtract; `2 ≠ 0`, `ι ≠ 0`), bijective by cardinality,
  `φ(s) ^ (Q + 1) = s₁² + s₂²` (`linear_combination`), and `ψ ∘ φ = ψ₀(b₁· + b₂·)` for a non-trivial `ψ₀` of `k₀`
  (`AddChar.exists_apply_ne_zero`) because every character of a finite field is a shift of `ψ₀` (`exists_mulShift_eq`: injective by
  `AddChar.to_mulShift_inj_of_isPrimitive`, onto by `AddChar.card_eq`); `b ≠ 0` since `ψ ≠ 1`; then P5 at radius 1 and
  `|Re z| ≤ ‖z‖`. `hK` is applied at `↥k₀ : Type` with `Subtype.fintype` from a local `DecidablePred (· ∈ k₀)`. One round after the
  helpers (one more for a conjunction in `FiniteField.card`).

**The brief's item 3, "if a proof finds another case the printed sketch glosses, that is a message": none found — the opposite.**
The proofs locate the failure of the printed `[MMST1996]` Theorem 3 at `n = 2` exactly: radius zero **and** `b` isotropic
(`circle_sum_zero_of_isotropic`, `two_sqrt_lt_circle_sum_zero`: the sum is `χ(−1)(q − 1)`, over the bound from `q ≥ 6`); in every
other case the bound holds given Weil's (`circle_sum_le_of_ne`), with the sum equal to `±1` in the two half-degenerate cases. So the
restriction the leaf needs is the one it carries (`a ≠ 0`), and it is not the weakest: `a = 0` with `b` anisotropic is also fine —
in particular at every `q ≡ 3 (mod 4)`, where no isotropic `b ≠ 0` exists (the classical fact, `−1` not a square; [hand] here —
no Lean statement in these files says it), the printed theorem is true as it stands. Not sent
mid-job: it changes no statement of the skeleton. [kernel on this branch]; the "exactly" is over `KloostermanBound`.

**Prices, measured** (lines of docstring, statement and proof, helpers counted with the leaf that first needs them;
`git diff --stat 330d2f48`: 496 insertions in the two files): P1 48 (plan 120); P2 32 (50); P3 67 (80); P4 84 (120); P5 51 (40 —
at the wider class); P6 160 (200): **442 for the six leaves against the plan's 610, 72 %**; 28 more for the two theorems on the
failing case and about 50 for five spec examples. **My Stage 2 re-price of the last four leaves, "about 220", was low** (they came
to 362, two thirds more): P1 and P2 were the two leaves where Mathlib already held the argument, and I priced the rest from them. The job's
harness cost is about 300k by my estimate, the plan's figure.

**Spec examples added** (each fails if its theorem drifts): `card_filter_pow_eq_one` at `ZMod 3`, `d = 2`; `circle_sum_le` at
`ZMod 3` with Weil's bound discharged by `kloostermanBound_of_card_le_five` — a model of every hypothesis at once;
`circle_sum_le_of_ne` on its second branch (`ZMod 3`, radius 0, `b = (1, 0)`); the failing case at `ZMod 13`, `b = (1, 5)`
(`2√13 < ‖Σ‖`); **`normOne_charSum_ge` at `GaloisField 3 2`, `Q = 3`, with `hK` discharged — so at `𝔽₉` the bound `−2√3` is
unconditional**, and the theorem's hypotheses have a model.

**New import** in `FloorPlanes.lean`: `Mathlib.FieldTheory.Finite.GaloisField` (the `𝔽₉` example).

**Evidence.** `data/fs131/i10d/logs/build-2-all-leaves.log`: exit 0, 3 modules rebuilt, the first build with the six leaves proved.
`data/fs131/i10d/logs/build-3-final.log` (after one helper's docstring was made exact and the second-branch example added): under the
slot, exit 0, 454 of 454 batches, 3 modules rebuilt (`FloorPlanes` 2.9 s, `TargetFloors`, `Proofs`), **17 `sorry` warnings left on
the branch, none in my two files** — `Floor128` 1, `ProductFactor` 1, `MajorityVote` 1, `NegCircleModel` 2, `StandingFive` 9,
`StationaryRatio` 3 — and no other warning in the log (`grep "warning\|error"` reads 18 lines: the 17 `sorry` warnings, which shows it reads
warning lines, and the build's own summary "6 module(s) with warnings"; nothing else). Axioms (`data/fs131/i10d/axioms-all.lean`, log
`data/fs131/i10d/logs/axioms-all.log`): the 20 records of the block each on `[propext, Classical.choice, Quot.sound]` — counted by
reading the log, since `targetFloor_seven_of_kloosterman`'s line is wrapped over three and a one-line `grep -c` reads 19; the control
`StandingFive.usable_card_ge` (open on this branch) prints `sorryAx`; `sum_quadratic_eq` printed `sorryAx` in Stage 2's log and is
clean here, the same declaration seen both ways; `standingFloor_seven` prints `sorryAx`, as it must until `Floor128`'s leaf (another
implementer's) joins. Statement check against `330d2f48`: 3 + 7 base declarations kept, one docstring extended and listed
(`circle_sum_eq_kloosterman`'s, the brief's item 3), PASS, self-tests as required (`data/fs131/i10d/logs/statements-2.txt`).
`tools/check_architecture.py`: PASS (`data/fs131/i10d/logs/arch.log`). Names: none of the twelve new helper names is declared in
`Proofs/` on `main` or on any `fs131-w10*` branch as fetched (`git grep`, 0 hits on eight refs). Not run, by the brief: the gate
(`axioms.sh`, `vacuity.sh`, `dupnames.sh`, the linters).

**For the joining job**, beyond the plan's § 9.4:
- New names in `HadwigerNelson.StandingFive` from these two files: `card_filter_pow_eq_one` (`NormOneTarget`);
  `sum_addChar_mul_left`, `sum_eq_zero_add_sum_units`, `sum_units_addChar_mul`, `sum_addChar_mul_sq`, `sum_plane_quadratic`,
  `circle_sum_le_of_ne`, `circle_sum_zero_of_isotropic`, `two_sqrt_lt_circle_sum_zero`, `exists_ringHom_pow`,
  `card_filter_pow_eq_self`, `exists_mulShift_eq` (`FloorPlanes`).
- **`Floor128`'s child B5** (the plan's § 7.2: "every `ψ ≠ 1` is `ψ₀(a ·)`") **is `exists_mulShift_eq`**, and its B6 counts
  `{u : u¹²⁹ = 1}`, which is `card_normOne` at `Q = 128`. If that branch states them again under its own names, the join may make
  one declaration of each; `Floor128` imports `NormOneTarget` already, and would need `FloorPlanes` for the first (or the lemma
  moves to `NormOneTarget`).
- `involution_eq_pow`'s docstring still describes the fixed-field proof; the kernel's proof is by the Frobenius' powers (a `--`
  comment at its head says so). If the join edits docstrings, that one may be brought into line.

Token count at this stage: about 300k by my own estimate.

## Drafts for the front page

*I ran no gate, so no count below is a gate's count; each is what this branch adds, for the landing to confirm.*

1. **`CLAUDE.md` § Trust ledger**, the sentence "the current audit reads 5525 clean and 5 declared purchases, and 4 imported …":
   the landing of this branch adds **20 records, each on the standard three axioms** (the "FS131-I10D" block of
   `scripts/Axioms.lean`; `#print axioms` on this branch, `data/fs131/i10d/logs/axioms-all.log`), **no purchase and nothing under
   IMPORTED**: `KloostermanBound` is a `Prop` argument. None of the 20 is axiom-free.
2. **`CLAUDE.md` § The gate**, the vacuity counts: this branch adds 12 theorems beyond the skeleton's declarations and 5 `example`s;
   their sites and verdicts are the landing's to count (all binders are generic fields and characters; no colouring binder).
3. **`LEDGER.md`, row 53**, after "[derived] Kloosterman eigenvalues make every plane at p ≡ 3 (mod 4) from 59 up refuse five":
   "**[kernel, over the named hypothesis `StandingFive.KloostermanBound` at the fields of `Q` elements]** every level-one target at
   `Q ≡ 3 (mod 4)`, `Q ≥ 98` (prime powers included) needs seven colours — `StandingFive.targetFloor_seven_of_kloosterman`
   (`Arith/FloorPlanes.lean`), standard three axioms; and **[kernel, no hypothesis]** the eigenvalue identity itself,
   `StandingFive.circle_sum_eq_kloosterman`: `Σ_{s₁² + s₂² = a} ψ(b·s) = χ(−1)·Σ_{x ≠ 0} ψ(−a x − ((b₁² + b₂²)/4) x⁻¹)` at every
   finite field of odd characteristic, every radius `a`, every `b ≠ 0`." Rests on, by name: `KloostermanBound` (Weil's bound for
   Kloosterman sums, a hypothesis until imported); `RatioBound.le_chromaticNumber_of_charSum`, `involution_eq_pow`, `card_normOne`,
   `normOne_charSum_ge` (all kernel).
4. **`BIBLIOGRAPHY.md`, `[MMST1996]` row**, replacing "**The identity is verified numerically here and has not been checked against
   the paper** (FS-20 open item R4)": "**The identity is a kernel theorem** — `StandingFive.circle_sum_eq_kloosterman`
   (FS131-I10D), at every finite field of odd characteristic and every radius; it agrees with formula (11) at `n = 2` as FS131-K10b
   quotes it, up to the paper's definition of `K`, not read." And after "It holds with `a ≠ 0` on … [measured …]": "**In the
   kernel**: given Weil's bound it holds whenever `a ≠ 0` or `b` is anisotropic (`circle_sum_le_of_ne`), and at `a = 0`, `b ≠ 0`
   isotropic `λ_b = χ(−1)(q − 1)` exactly (`circle_sum_zero_of_isotropic`), over `2√q` from `q ≥ 6`
   (`two_sqrt_lt_circle_sum_zero`) — so the printed theorem is false exactly there, and true as printed at every `q ≡ 3 (mod 4)` (no isotropic `b ≠ 0`
   there; that last step [hand])."
5. **`plans/STUB-theorem-B-writeup.md` § 5**, replacing "* **R4 — `[MMST1996]`**, still second-hand.": "* **R4 — `[MMST1996]`**:
   pp. 225–232 read (FS131-K10b); the identity `λ(c) = −K(1, c/4)` is `StandingFive.circle_sum_eq_kloosterman`, kernel-checked on
   `fs131-w10d` (FS131-I10D); the paper's own definition of `K` is still unread."
6. **The Frontier line** (`CLAUDE.md` § Frontier, "Last filed"), when the wave lands: "wave 10's planes' floor: `χ(Γ_Q) ≥ 7` for
   every `Q ≡ 3 (mod 4)`, `Q ≥ 98`, in the kernel over Weil's Kloosterman bound as a named hypothesis
   (`targetFloor_seven_of_kloosterman`)". **Proof Atlas grade changes**: G56's "refuses six by Weil from 98" — [derived] → [kernel
   over `KloostermanBound`]; the Kloosterman eigenvalue identity (row 53, M58 §R1) — [measured] → [kernel]; `[MMST1996]` Theorem 3's
   defect at `a = 0` — [measured] → [kernel over `KloostermanBound` for "exactly", kernel outright for the failing case].
7. **`plans/FS131-kernel-plan.md` § 7.4** (the named-hypotheses table), the `KloostermanBound` row the planner drafted: add "consumers
   read it only at fields of odd cardinality (`Q ≡ 3 (mod 4)`); `[Weil1948]` p. 207 assumes characteristic not 2 (the bibliography
   row), so the axiom is stated with `ringChar F ≠ 2` — `∀ F, ringChar F ≠ 2 → KloostermanBound F` discharges
   `standingFloor_seven`'s hypothesis by `FiniteField.even_card_iff_char_two`."
