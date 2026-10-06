# FS-131, wave 10 — implementation record: the floor at 128 (`Floor128`, the bridge `charSum_128_ge`)

*Job FS131-I10E (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10e` (cut from the second planner's `330d2f48`, fast-forwarded
at launch to `a14f9ab0`, FS131-I10D's hand-back: the brief's Amendment 1). Brief: `data/fs131/briefs/FS131-I10E-wave10-second.md`.
Plan: `plans/FS131-w10-kernel-plan.md` §§ 7.1, 7.2, 9.3, 9.4.*

**What I may change, and what I may not.** Mine: the proof of the one open leaf of `Proofs/HadwigerNelson/Arith/Floor128.lean`,
`charSum_128_ge`; new helper declarations in that file, under names no other module declares (all in the namespace
`HadwigerNelson.Floor128`, which only this module opens); the file's import list; a docstring extended, never rewritten; a block
"FS131-I10E" in `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i10e_*.py`; `data/fs131/i10e/`;
the report. Not mine: any statement, hypothesis, conclusion or definition of the skeleton — the certificate (`clmul`, `P`, `qBig`,
`a4`, `b4`, `a128`, `b128`, `step`, `pass`, `counts`, `countsOk`) and its five kernel checks stay as they are; a new `axiom`;
`native_decide`; the wave's other files, `NormOneTarget` and `FloorPlanes` among them (their theorems `card_normOne`,
`card_filter_pow_eq_one`, `exists_mulShift_eq` are cited, never declared again); `ARCHITECTURE.md` (not in the brief's `touches`: an
edit it needs is drafted below); the planner's record; any landed module; `main`; the gate; another branch.

## Theorems this phase proved

**The one leaf of the brief is proved; `Floor128.lean` has no `sorry`, no `axiom`, no `native_decide`.** Kernel-checked on this
branch by `./scripts/build.sh` under the slot (Stage 3's log); axioms a subset of `[propext, Classical.choice, Quot.sound]` for each
of the 43 records of the "FS131-I10E" block of `scripts/Axioms.lean`, printed with two controls that show `sorryAx`
(`data/fs131/i10e/logs/axioms-all.log`). The branch does not run the gate, so the audit is the landing's. All in
`Proofs/HadwigerNelson/Arith/Floor128.lean`, namespace `HadwigerNelson.Floor128`, each [kernel on this branch]:

- **`charSum_128_ge`** (the leaf) — informal: "The character sums of `μ₁₂₉` in a field of `2¹⁴` elements are at least `−19`" (its
  docstring); the plan's § 7.2: "in a field of `2¹⁴` elements every non-trivial additive character sums to at least `−19` over
  `{u : u¹²⁹ = 1}`". Lean, read aloud: for every field `k : Type` with `Fintype.card k = 128 ^ 2` and every additive character
  `ψ : AddChar k ℂ` with `ψ ≠ 1`: `−19 ≤ Re Σ_{u ∈ k, u ^ (128 + 1) = 1} ψ(u)`. Says the sentence, no more: "at least" is read on
  the real part (the sums are real, `ψ` being `±1`-valued in characteristic 2; the statement does not say so and no consumer reads
  it). Axioms: the standard three. **No outside theorem and no named hypothesis.**
- **`targetFloor_eight_128 : StandingFive.TargetFloor 8 128`** (the planner's composition; now over proved leaves) — the row: G56,
  "Q = 128 has floor 8" (`.claude/skills/grokkings/SKILL.md`), which the plan reads as "U₁₂₈'s Hoffman floor is 8". Lean, read
  aloud: every field `k : Type` of `128²` elements (`Finite`, `Nat.card k = 128 ^ 2`) with a ring endomorphism `σ`, `σ (σ x) = x`
  for every `x`, `σ ≠ RingHom.id k`, has `(8 : ℕ∞) ≤ (normOneCayley k σ).chromaticNumber`. Axioms: the standard three. **Run at a
  model of every hypothesis** (the Spec's last example): `GaloisField 2 14` with `x ↦ x ^ 128` — eight colours for an actual graph.
- **`targetFloor_seven_128 : TargetFloor 7 128`** (the planner's; the form `StandingFloor 7` reads). Axioms: the standard three.
- New, the bridge's joints (each with a docstring in the file):
  - the code — **`ev`** (a definition: the value at `t` of the polynomial coded by `n`), `ev_zero`, `ev_eq`, `ev_one`,
    `ev_two_mul`, `ev_shiftLeft_one`, `ev_two_pow`, `ev_two`, `map_ev` (natural in ring homomorphisms), `coeff_ev_X` (at `t = X` the
    coefficient of `Xⁱ` is bit `i`), **`ev_xor`**, **`ev_clmul`** (in characteristic 2, `^^^` is the sum and `clmul` the product),
    `ev_step`, `ev_iterate_step` (at a root of `P`, a step of the register multiplies by `g`);
  - a root — `qBig_lt`, `qBig_testBit_one` (two `decide +kernel` on the certificate's literal), `charP_two`, **`exists_root`**:
    `P` has a root in every field of `2¹⁴` elements;
  - the register on codes — `step_lt`, `step_ne_zero`, `pass_fst`, `pass_snd`, `iterate_step_lt`, `iterate_step_ne_zero`,
    `iterate_step_period`, `eq_of_dvd_of_not_dvd`, **`minimalPeriod_step`** (`Function.minimalPeriod step 1 = 16383`),
    `iterate_step_injOn`, **`exists_iterate_step_eq`** (every non-zero code below `2¹⁴` is a state of the register);
  - the counters — `digit_sum`, `sum_range_mul_eq`, `pass_class`, **`class_le`** (for `r < 127`, at most 74 of the 129 states
    `127 j + r` have their low bit set);
  - the field — `root_pow_eq_one`, **`ev_ne_zero`**, `ev_inj`, `root_pow_inj`, `exists_code` (the codes below `2¹⁴` are the
    elements: `1, g, …, g¹³` is a basis), **`exists_root_pow_eq`** (a root of `P` generates the multiplicative group: `P` is
    primitive), `normOne_eq_image` (`{u : u¹²⁹ = 1} = {g^(127 j) : j < 129}`), **`exists_addChar`** (the coordinate-0 character).
- Also printed, the planner's compositions of `Arith/TargetFloors` (not my file; both floors are proved on this branch):
  `StandingFive.standingFloor_seven`, `standingFloor_five` — the standard three, over the hypothesis `KloostermanBound` alone.

**Not in the kernel, and not claimed**: the exact spectrum `−19, −15, …, 21` stays [tools] (`tools/fs131_k10b_u128.py`, re-run
here: `data/fs131/i10e/logs/u128-rerun.log`, max class count 74, as the kernel theorem's bound); the kernel holds the lower bound
`−19` at every non-trivial character, not that it is attained (the Spec's `countsOk 73 = false` says some counter exceeds 73).

## Stage 1 — SAVED (FS131-I10E): the readback, and the branch as given

**The brief's quotations** (standing rule 3), by script (`data/fs131/i10e/logs/quotations.sh`, `grep -F` of each quoted string in
the file the brief names; output `data/fs131/i10e/logs/quotations.txt`): **fourteen of fourteen match** — `CLAUDE.md`
§ Counter-priors; inventory items 500, 503, 509, 510 (`plans/FS131-close-inventory.md` on `main`); the two statements of
`Floor128.lean`; the plan's §§ 7.1, 7.2, 9.3, 9.4 headings; the amendment's three statements (`exists_mulShift_eq` in `FloorPlanes`,
`card_normOne` and `card_filter_pow_eq_one` in `NormOneTarget`). The script's control (a planted string that is in no file) reads
missing, as it must.

**Read whole**: the brief with its amendment; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail,
and watch it fail; the plan's Stages 6–9 (§§ 7.1, 7.2, 9.1–9.6 whole; § 7.3–7.4 for the sibling row); `Floor128.lean`;
`NormOneTarget.lean`; `FloorPlanes.lean` lines 296–375 (the three theorems the amendment names, with `exists_ringHom_pow`); the
definitions `normOneCayley`, `TargetFloor`, `StandingFloor` of `StandingFive.lean`; FS131-I10D's record (its theorems). **The row's
sentence**: G56 (`.claude/skills/grokkings/SKILL.md`), "Q = 128 has floor 8 (`data/fs54/char2/`)", which the plan's § 7.2 reads as
"U₁₂₈'s Hoffman floor is 8".

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, 454 of 454
batches, 5 modules rebuilt, 8 m 22 s (`data/fs131/i10e/logs/build-0-as-given.log`). **Seventeen `sorry` leaves, one mine**:
`Floor128` 1 (`charSum_128_ge`), `MajorityVote` 1, `NegCircleModel` 2, `ProductFactor` 1, `StandingFive` 9, `StationaryRatio` 3 —
counted as distinct `file:line` warnings of the build's full output. It agrees with the amendment's count.

**The statement checker**: `tools/fs131_i10e_statements.py` (FS131-I10D's checker, copied under this job's prefix), base
`a14f9ab0`: every base declaration of `Floor128.lean` — 14 chunks (the six certificate literals are one chunk), each compared
verbatim, a definition with its body, a docstring verbatim or extended — is present; `--self-test` plants a statement fault, a
definition fault and a docstring fault, each caught, and a docstring extension, passed and listed
(`data/fs131/i10e/logs/statements-0.txt`).

**The route, decided before the first leaf, and where it leaves the plan's** (the plan's children B1–B6, § 7.2):

- B1 (the code), B2 (a root, from `clmul_P_qBig`), B4 (the register), B6 (the sum) as planned. B5's second half and B6's count are
  now cited (`exists_mulShift_eq`, `card_normOne`), so `Floor128` gains the import `Arith/FloorPlanes`.
- **B3 (the basis) by the register's orbit, not by the two Bézout identities.** On codes, `step` has the point 1 of period exactly
  16383 (`counts_ok`'s first clause; `order_checks`; `16383 = 3·43·127`), and it keeps `[1, 2¹⁴)`; so the orbit of 1 is every
  non-zero code below `2¹⁴`. A non-zero code `n < 2¹⁴` is then some `step^[j] 1`, whose value at the root `g` is `gʲ ≠ 0`. That
  is the basis statement (`φ_g(n) = 0 ∧ n < 2¹⁴ → n = 0`), with no subfield, no minimal polynomial and no degree count; it also
  hands B4 and B6 the two facts they read (the powers `gʲ`, `j < 16383`, are distinct and are every non-zero element). **A
  shorter-route note, not a defect** (the amendment's item 3): `bezout4` and `bezout128` stay kernel theorems of the file and the
  bridge does not read them — the register's exact period already says `P` is primitive, which is more than irreducible.

**Draft for `ARCHITECTURE.md`** (not in my `touches`; slot: § 3, the row `Arith/Floor128`, its Imports cell, which reads
`` `Arith/NormOneTarget` ``): it becomes `` `Arith/NormOneTarget`, `Arith/FloorPlanes` `` once the bridge cites
`exists_mulShift_eq`. Until that cell is edited `tools/check_architecture.py` reports one import mismatch on this branch, this row.

Token count at this stage: own estimate ≈ 140k of the harness's (the launch context is most of it).

## Stage 2 — SAVED (FS131-I10E): the bridge proved

**The children, in the plan's order** (§ 7.2), each compiled before the next was written, in a working file against the built
module so that the certificate's kernel checks did not re-run at every round, then moved into `Floor128.lean` above the leaf:

| the plan's child | as proved | plan's lines | lines |
|---|---|---|---|
| B1 the code | `ev` by the bit recursion (`ev t n = bit₀ + t·ev t (n/2)`), `ev_xor`, `ev_clmul` by induction on the fuel, `map_ev`, `coeff_ev_X` | 80 | 112 |
| B2 a root | `exists_root`: at each `a ∈ k`, `ev a P · ev a qBig = a^(2¹⁴) + a = 0`; if `P` had no root the cofactor would vanish on all of `k`, and it is a non-zero polynomial of degree below `2¹⁴` (`Polynomial.eq_zero_of_natDegree_lt_card_of_eval_eq_zero`; `qBig_lt`, `qBig_testBit_one`). No splitting field, no product formula | 60 | 41 |
| B3 the basis | **by the register's orbit** (Stage 1's route note): `minimalPeriod_step`, `exists_iterate_step_eq`, then `ev_ne_zero`, `ev_inj`, `exists_code`. `bezout4`, `bezout128` not read | 120 | 63 + 58 |
| B4 the register | `pass_fst`, `pass_snd` (induction on the fuel), `pass_class` (regrouping by residue, then `digit_sum`), `class_le` | 120 | 56 + 62 |
| B5 the characters | `exists_addChar` (the code of `x`, by choice from `exists_code`; additive because `ev` turns `^^^` into `+`); the second half cited: `StandingFive.exists_mulShift_eq` | 60 | 32 |
| B6 the sum | `normOne_eq_image` (over the cited `StandingFive.card_normOne`); the leaf: a shift by `gⁱ` is a shift by `g^(i mod 127)` up to an element of the norm-one set (`Finset.sum_equiv` along `Equiv.mulLeft₀`), then `129 − 2·c ≥ −19` | 80 | 62 |

**Re-priced after the first two children, and it held to the end: the plan's line count stands** — the module grew from 120 lines to
657: 486 lines of the bridge's declarations (the plan: 520) and about 50 of module docstring and Spec — unlike the wave's first two implementers' third to two thirds. The token cost came
in under the plan's 300k: about 150k of work beyond the launch context. Elaboration rounds: three for the code and the root, three for
the register and the counters (one of them the kernel finding below), four for the field and the leaf.

**A kernel finding (measured), for `LEAN.md` § The kernel's cost model.** A rewrite of a *closed* natural-number term by a lemma
stated at other instances than the term's own sends the kernel to evaluate the term. `counts.2 = 0 + Σ_{m < 16383} …` rewritten by
`pass_snd` alone: 2 s. The same goal with Mathlib's `zero_add` after it (the `0 + _` of `AddZeroClass`): elaboration succeeds and
the **kernel** runs to "deterministic timeout" after 173 s (unslotted, memory unmeasured); under a slot of 8 GiB the same file is
killed at the cap after 27.6 s (the kernel journal: `Memory cgroup out of memory: Killed process (lean) … anon-rss:8184052kB`).
Two variants each differing in one thing: with the length and the seed as **variables**, Mathlib's `zero_add` — 2.1 s; the closed term
with core's `Nat.zero_add`, stated at the goal's own instances — 2.3 s (registered before the run at 0.8: it passes).
`data/fs131/i10e/lean/closed-term/` holds the three files and their outputs. *The mechanism is a reading, one mind, from memory of
the kernel's source, not read today*: comparing `0 + S` at two instance paths, the kernel unfolds both to `Nat.add 0 S`, and on a
closed `Nat.add` it normalizes the arguments to literals — here a sum of 16,383 register states. Hence `pass_class` is stated with
the seed and the block count free, and `class_le` instantiates it; its docstring says so.

**Evidence at this stage.**
- **Build 1** (`data/fs131/i10e/logs/build-1-bridge.log`): `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
  ./scripts/build.sh`, exit 0, 455 of 455 batches, 3 modules rebuilt (`Arith.Floor128` 6.8 s — the planner's skeleton was 6.4 s —
  `Arith.TargetFloors`, `Proofs`), 16 `sorry` warnings on the branch, none in `Floor128` (17 at Stage 1). It covers the module as
  committed at this stage **less** the Spec's last example (`targetFloor_eight_128` at `GaloisField 2 14`) and one sentence of the
  module docstring, both added after it and elaborated by `lake env lean` with the lakefile's options (clean); the final build is
  Stage 3's.
- **Axioms** (`lake env lean data/fs131/i10e/axioms-all.lean`, output `logs/axioms-all.log`): 43 records of this job's block and the
  two compositions of `TargetFloors`, 45 in all — 33 print `[propext, Classical.choice, Quot.sound]`, 12 a subset of it. The two
  controls print `sorryAx`, as they must: `StandingFive.usable_card_ge` and `StandingFive.seven_le_localBound_of_kloosterman`
  (both rest on `StandingFive`'s leaves, open on this branch).
- **Statements** (`tools/fs131_i10e_statements.py a14f9ab0 …`, `logs/statements-1.txt`): PASS, 14 of 14 base chunks verbatim, one
  docstring extended and listed (`charSum_128_ge`: the paragraph "As proved (FS131-I10E)"); `--self-test`: three faults caught, the
  partner passed. The certificate block is the generator's (`tools/fs131_k10b_gen128.py --check` exit 0, `--fault` exit 1:
  `logs/gen128-check.log`).
- **Negative controls of the bridge** (`data/fs131/i10e/lean/Controls.lean`, output `logs/controls.log`): `class_le` restated at
  73 with `class_le`'s own proof — type mismatch at its last line; the leaf's last inequality at `−18` — `linarith` fails;
  `step^[5461] 1 = 1` from `order_checks` — type mismatch. Three errors, at the three controls and nowhere else; the three partners
  at the true values pass.
- **The tool agrees with the kernel**: `tools/fs131_k10b_u128.py` re-run (`logs/u128-rerun.log`): `lambda_min = −19`, "max count
  c_i = 74".
- **Names**: each of the 41 new names is declared in one file of `Proofs/`, this one (`rg`, by declaration keyword); the namespace
  `HadwigerNelson.Floor128` is opened by this module alone. `tools/check_architecture.py`: exit 1 with the one mismatch Stage 1
  foretold — "imports of Arith/Floor128: … real-only ['Arith/FloorPlanes']" (`logs/arch.log`); nothing else.

**A slip, mine**: the first elaboration of the counters and two bisection runs (`lake env lean`, unslotted, two of them at once)
each ran about three minutes to the kernel timeout above with their memory unmeasured; the slotted re-run shows the blow-up passes
8 GiB in under half a minute. From the bisection on, every run that could reach that term went under a slot. Nothing was lost.

Token count at this stage: own estimate ≈ 300k of the harness's.

## Stage 3 — SAVED (FS131-I10E): the floor run at a model, the final build, the checks on it

**A model of every hypothesis of `TargetFloor 8 128`, in the file** (the Spec's last example): `GaloisField 2 14` with
`iterateFrobenius (GaloisField 2 14) 2 7`, the map `x ↦ x ^ 128`. It is an involution (`x ^ (128·128) = x`,
`FiniteField.pow_card`) and not the identity (it fixes exactly 128 of the 16,384 elements: FS131-I10D's
`StandingFive.card_filter_pow_eq_self`), so `targetFloor_eight_128` applies and gives
`(8 : ℕ∞) ≤ (normOneCayley (GaloisField 2 14) _).chromaticNumber` — the floor as a statement about one actual graph, which is what
"`TargetFloor n 128` does not quantify over an empty domain" (the module docstring, a note until now) asks for. Two more examples
run `exists_root` and `charSum_128_ge` at the same field.

**The final build** (`data/fs131/i10e/logs/build-2-final.log`): `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`, exit 0, 455 of 455 batches, 3 modules rebuilt (`Arith.Floor128` 6.6 s, `Arith.TargetFloors` 1.5 s, `Proofs`
1.7 s), 8 m 18 s after 9 minutes queued on the slot's ledger. **Sixteen `sorry` warnings on the branch, none in `Floor128`**:
`MajorityVote` 1, `NegCircleModel` 2, `ProductFactor` 1, `StandingFive` 9, `StationaryRatio` 3 (distinct `file:line` warnings of the
full output). The one line reading "error: target is out-of-date" in the full output is `build.sh`'s opening `lake build
--no-build` probe finding `Floor128` stale, as it must after an edit. The module as built is the module as committed.

**On the final build**:
- axioms (`logs/axioms-all.log`, re-run): 47 records — the 43 of this job's block and `standingFloor_seven`, `standingFloor_five`
  within the standard three (33 on all three, 12 on a proper subset); the two controls outside it, each printing `sorryAx`;
- the negative controls (`logs/controls.log`, re-run): exit 1 with three errors, at lines 19, 24, 30 of `Controls.lean` — the three
  controls — and none at the partners;
- statements: `logs/statements-1.txt` is of the final source (PASS; self-test as required);
- **the environment linters, run as a check of this module and not as the gate** (`scripts/slot.py --mem 8 --cpus 2 -- lake lint
  --no-build -- --no-build --trace`, `logs/lint.log`): 13 of 14 linters pass on the library; `unusedArguments` reports three
  declarations, all in wave 2's `Arith/` (`DyadicSqrt3Conclusion`, `falconerFan_five_placeHom`, `placeHom_step`: the unused
  `[NumberField _]` binders the inventory already holds). **Nothing of `Floor128` is reported by any linter.**

**Not done, by the brief**: the gate (`axioms.sh`, `vacuity.sh`, `dupnames.sh`), any merge, `main`. **Not done, and said**:
`ARCHITECTURE.md`'s Imports cell (not in my `touches`; drafted below, item 3).

Token count at this stage: own estimate ≈ 330k of the harness's.

## Drafts for the front page

*I ran no gate, so no count below is a gate's count; each is what this branch adds, for the landing to confirm.*

1. **`CLAUDE.md` § Trust ledger**, the sentence "the current audit reads … clean and 5 declared purchases, and 4 imported …": the
   landing of this branch adds **43 records, each on a subset of the standard three axioms** (the "FS131-I10E" block of
   `scripts/Axioms.lean`; `#print axioms` on this branch, `data/fs131/i10e/logs/axioms-all.log`): 31 on all three, 12 on a proper
   subset (`[propext, Quot.sound]` or `[propext]`), none axiom-free; **no purchase and nothing under IMPORTED**. With both floors
   proved on this branch the planner's `StandingFive.standingFloor_seven` and `standingFloor_five` (`Arith/TargetFloors`) also
   print the standard three, and can enter the landing's block.
2. **`CLAUDE.md` § The gate**, the vacuity counts: this branch adds 40 theorems and one definition (`Floor128.ev`) beyond the
   skeleton's declarations, and 6 `example`s; their sites and verdicts are the landing's to count (every binder is a ring, a field,
   a natural number or a character; no colouring binder). The hypotheses `ev g P = 0` and `Fintype.card k = 128 ^ 2` are inhabited
   in the file: the Spec's last three examples run `exists_root`, `charSum_128_ge` and `targetFloor_eight_128` at `GaloisField 2 14`.
3. **`ARCHITECTURE.md` § 3, the row `Arith/Floor128`** (the check fails on this branch until its Imports cell is edited: Stage 1).
   Imports cell, replacing `` `Arith/NormOneTarget` ``: `` `Arith/NormOneTarget`, `Arith/FloorPlanes` ``. Description cell,
   replacing "**FS-131 wave 10 (FS131-K10b), skeleton.**" by "**FS-131 wave 10 (FS131-K10b; the bridge FS131-I10E).**", and "the
   bridge `charSum_128_ge` (the leaf); `targetFloor_eight_128`, `targetFloor_seven_128` (proved over it)." by "the bridge
   `charSum_128_ge`, proved with no outside theorem: `ev` (a code read as a polynomial; `ev_xor`, `ev_clmul`), `exists_root`,
   `minimalPeriod_step` and `exists_iterate_step_eq` (the register's 16,383 states are the non-zero codes), `ev_ne_zero`,
   `exists_code`, `exists_root_pow_eq` (`P` is primitive), `class_le`, `exists_addChar`; `targetFloor_eight_128`,
   `targetFloor_seven_128`. `bezout4`, `bezout128` are kernel-checked and not read by the bridge."
4. **`LEAN.md` § The kernel's cost model**, a new bullet after "Data the kernel must *build* …": "**A closed `Nat` term rewritten by
   a lemma stated at other instances than its own is evaluated by the kernel.** `0 + S` with `S` a closed sum of 16,383 register
   states, rewritten by Mathlib's `zero_add`: elaboration succeeds, the kernel runs 173 s to `deterministic timeout`, and passes
   8 GiB in 27 s; with one variable free in `S`, or with core's `Nat.zero_add` on the closed term, 2 s
   (`data/fs131/i10e/lean/closed-term/`). State the lemma that does the algebra with the term's parameters free and instantiate it
   last (`Floor128.pass_class`, `class_le`); a `(kernel) deterministic timeout` is a memory event too, so bisect one under a slot."
5. **`LEDGER.md` § B, the row `FS91-J10-T9`** (`λ_min(U₆₄, U₁₂₈, U₂₅₆) = −15, −19, −31`, "tools exact (one computation)"), after it:
   "**`λ_min(U₁₂₈) ≥ −19` [kernel]**: `Floor128.charSum_128_ge` — in every field of `2¹⁴` elements every non-trivial additive
   character sums to real part at least `−19` over `{u : u¹²⁹ = 1}`; and **`χ(U₁₂₈) ≥ 8` [kernel]**:
   `Floor128.targetFloor_eight_128 : StandingFive.TargetFloor 8 128` (`Arith/Floor128.lean`), standard three axioms, no outside
   theorem, no named hypothesis. Rests on, by name (all kernel): the certificate `clmul_P_qBig`, `order_checks`, `counts_ok`;
   `RatioBound.le_chromaticNumber_of_charSum`; `StandingFive.involution_eq_pow`, `card_normOne`, `exists_mulShift_eq`. That `−19`
   is attained, and the other ten values, stay tools exact."
6. **`.claude/skills/grokkings/SKILL.md`, G56**, at "Q = 128 has floor 8 (`data/fs54/char2/`)": "Q = 128 has floor 8
   (`data/fs54/char2/`; **[kernel]**, `Floor128.targetFloor_eight_128`, FS131-I10E)".
7. **`plans/FS131-kernel-plan.md` § 7.4** (the named-hypotheses table), the `StandingFloor` row: its first half, `TargetFloor n 128`
   at `n ≤ 8`, is a theorem on this branch; with FS131-I10D's planes the whole of `StandingFloor 7` is
   `StandingFive.standingFloor_seven`, over `KloostermanBound` alone.
8. **The Frontier line** (`CLAUDE.md` § Frontier, "Last filed"), when the wave lands: "wave 10's floor at 128: `χ(U₁₂₈) ≥ 8` in the
   kernel on the standard three axioms, with no outside theorem (`Floor128.targetFloor_eight_128`)". **Proof Atlas grade changes**:
   G56's "Q = 128 has floor 8" — [tools] → [kernel]; `λ_min(U₁₂₈) = −19` (FS91-J10-T9) — the inequality `≥ −19` [tools] → [kernel],
   the equality unchanged; "`P = x¹⁴ + x⁵ + x³ + x + 1` is primitive over `𝔽₂`" — new, [kernel] in the form `exists_root_pow_eq`
   (a root of `P` in a field of `2¹⁴` elements generates its multiplicative group).

**For the joining job** (beside the plan's § 9.4): `fs131-w10e` contains `fs131-w10d` (the amendment's fast-forward), so merging it
brings FS131-I10D's two files with it. `Floor128` now imports `FloorPlanes`. New names, all in the namespace
`HadwigerNelson.Floor128`, which no other module opens: the 41 listed under "Theorems this phase proved"; none is declared in
another file of `Proofs/` (Stage 2). `scripts/Axioms.lean` gains one block, above the `=== PURCHASED ===` banner, after
FS131-I10D's. `bezout4`, `bezout128` and their four literals are read by no proof: keeping them costs under a second of kernel
time and they are in FS131-K10b's audit block; dropping them is a statement change, so it is the planner's and the coordinator's.

