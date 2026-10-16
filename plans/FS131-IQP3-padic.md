# FS131-IQP3 — the p-adic plane to the gate: the ruled drops, five colours at 23, lint, the gate, the read-aloud and the drafts

*de Bruijn, the kernel lane's implementer. Brief `data/fs131/briefs/FS131-IQP3-padic.md` (on `main`; a copy is
`data/fs131/iqp3/brief-copy.md`). Worktree `.claude/worktrees/il5`, branch `fs131-kpa1`, from `f8ebf37f5`. The successor of
FS131-IQP2 (record `plans/FS131-IQP2-padic.md`, stopped at stage 1 at a pause Kooshi called) and FS131-IQP1 (record
`plans/FS131-IQP1-padic.md`); the plan is `plans/FS131-KPA1-padic-plan.md`. No fence. Started 2026-10-16.*

## Theorems this phase proved

Kernel theorems, built and gated on `7180f4b40` (axioms from `data/fs131/iqp3/gate/receipt-axioms.log`; "std3" is
`[propext, Classical.choice, Quot.sound]`):

- `PadicPlane.five_le_borelChromaticNumber_padicPlane_twentyThree : 5 ≤ borelChromaticNumber (padicPlane 23)` — std3. New
  (item 1014 (2)), in place of FS131-IQP1's `four_le_…` (which read Weil's bound).
- `PadicPlane.charSum_unitCircle_ge_of_circleCos` (private, `PadicPlane/Values`) — the cosine sums over the circle of `(ℤ/Q)²`
  bound the character sums — std3 (in the private records of `data/fs131/iqp3/axioms-all.txt`).
- `PadicPlane.exists_levelEmbedding` and `PadicPlane.charSum_levelOne_of_unitCircle`, each with one binder fewer (item 1014 (1):
  `hk`, `hpP`) — std3; the proofs are FS131-IQP1's, unread binders removed.

Through the gate with them, FS131-IQP1's proofs (its record, stages 2–4): the heads `PadicPlane.le_borelChromaticNumber_of_charSum`
(std3), `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`, `not_exists_bound_borelChromaticNumber_padicPlane`
and `borelChromaticNumber_padicPlane_three` (std3 and `StandingFive.kloosterman_bound`), `borelChromaticNumber_padicPlane_seven`,
`_eleven`, `_nineteen`, `borelChromaticNumber_padicPlane_twentyThree_le_eight`, the level clauses
`unitQuadrance_zmod_seven_pow_not_colorable_three`, `…_eleven_pow_not_colorable_four`, `…_nineteen_pow_not_colorable_four`, and
`FibreCertSound.sum_le_seven` (std3); 68 public records in all (stage 3).

## Stage 1 — SAVED: the readback

### 1.1 The quotations

The brief's four quotations (inventory items 1018, 1020, 1014 and 1002, `plans/FS131-close-inventory.md`), checked with
line breaks folded by the planner's checker, unchanged (`tools/fs131_kpa1_quotes.py`):

- against this worktree's copy of the inventory: **all four verbatim** (`data/fs131/iqp3/quotes.out`, exit 0);
- against `main`'s copy (`--root /home/kooshi/source/lean-dir`): **all four verbatim** (`data/fs131/iqp3/quotes-main.out`,
  exit 0);
- the planted control (one character of the first quotation changed) is refused: exit 1, `[0] NOT FOUND`
  (`data/fs131/iqp3/quotes-plant.out`).

The branch is at `f8ebf37f5`, as the brief says; `git status` showed no tracked change at the start (only the first job's
untracked logs under `data/fs131/iqp1/` and `data/fs131/kpa1/`). The worktree's `.lake/build` holds no `.olean` of the
eight landing modules (`PadicPlane/*`, `Arith/FibreCert7*`): it is `main`'s build, so the first build compiles them.

### 1.2 What is left, in order (FS131-IQP2's § 1.2, checked against the source)

Each line number of FS131-IQP2's § 1.2 was read against `PadicPlane/Tower.lean` at `f8ebf37f5` and holds: the binder
`(hk : 1 ≤ k)` at l. 346 and its `have _ := hk` at ll. 349–350, the call at l. 421; the binder `hpP` of
`charSum_levelOne_of_unitCircle` at l. 442, its `have _ := hpP` at ll. 447–448, the call at l. 486. `exists_levelEmbedding`
reads `hpP` (its own, for `p ≠ 2` and `charP_quot_pow`), which stays. No other file of `Proofs/` or `scripts/` names either
theorem (`grep -rn`). One correction to the route at 23: FS131-IQP1 and item 1002 give `κ ≈ 7.97`; the exact least cosine
sum over the circle of `𝔽₂₃²` is `−7.9606871…` (a float evaluation, for the docstring only; stage 2) and `circleCos_ge`'s
certificate (`M = 7960687200`, `κ₀ = M/(24·10⁹)`) gives `κ = 24κ₀ = M/10⁹ = 7.9606872`, so `1 + 24/κ = 4.0148…`; the value
`⌈·⌉ = 5` is unchanged.

The order: (1) the two drops; (2) `five_le_borelChromaticNumber_padicPlane_twentyThree` in place of `four_le_…`, with the
module docstring and `ARCHITECTURE.md`'s row brought to it; (3) the build and the lint — a saved stage; (4) the gate on one
commit with the statement comparison, the ruled changes listed, the vacuity scan's new sites and `#print axioms` of every
head statement — a saved stage; (5) the read-aloud — a saved stage; (6) the drafts — a saved stage; (7) the report.

## Stage 2 — SAVED: the ruled drops, five colours at 23, the build and the lint

**The two drops** (inventory item 1014, ruling (1)), `PadicPlane/Tower.lean`: `(hk : 1 ≤ k)` removed from
`exists_levelEmbedding` with its `have _ := hk` and comment, the call in `towerRatio_of_ratioAtMost` now
`exists_levelEmbedding p P hpP h2 hQ k`; `(hpP : ((p : ℕ) : 𝓞 (fieldI ⊥)) ∈ P.P)` removed from
`charSum_levelOne_of_unitCircle` with its `have _ := hpP` and comment, the call in `towerRatio_of_charSum` now
`charSum_levelOne_of_unitCircle p P h2 hQ h`. No proof line other than those changed: both proofs read neither binder.

**`five_le_borelChromaticNumber_padicPlane_twentyThree`** (item 1014, ruling (2)), `PadicPlane/Values.lean`, in place of
`four_le_…`: `5 ≤ borelChromaticNumber (padicPlane 23)`. The route the predecessors priced, with one private helper:
- `charSum_unitCircle_ge_of_circleCos` (private, 47 lines with its docstring): for a prime `Q` and any `κ`, the cosine-sum
  hypothesis of `CircleCos.circleCos_ge` (every `(α, β) ≠ 0` below `Q`) gives the character-sum form that
  `le_borelChromaticNumber_of_charSum` takes, `−κ(Q + 1) ≤ Re Σ_{s ∈ unitCircle Q} ψ s` for every `ψ ≠ 1`. The plane's form of
  `Rigidity/ClassRatio`'s private `charBound_one_of_circleCos`, with no residue field: `ψ(1, 0) = ζ^α`, `ψ(0, 1) = ζ^β`
  (`IsPrimitiveRoot.eq_pow_of_pow_eq_one` at `Complex.isPrimitiveRoot_exp`; `Q • v = 0` by `ext <;> simp`), so
  `ψ v = ζ^{(αv₁ + βv₂) mod Q}` from `v = v₁.val • (1, 0) + v₂.val • (0, 1)`; `ψ ≠ 1` gives `(α, β) ≠ 0`; the real part of `ζ^m`
  is `cos(2πm/Q)` (`Complex.exp_ofReal_mul_I_re`); `unitCircle Q` is the same `Finset.filter` as `circleCos_ge`'s sum, by
  definition, so no bijection is needed.
- the theorem (20 lines with its docstring): `circleCos_ge` at `Q = 23` gives `κ₀ < 1/3` with `2/24 ≤ κ₀`; `κ = 24κ₀` has `2 ≤ κ` and
  `1 + 24/κ = 1 + 1/κ₀ > 4`, so `5 ≤ ⌈1 + 24/κ⌉` by `Nat.lt_ceil`, and `le_borelChromaticNumber_of_charSum 23` closes it. No
  import added (`Arith/CircleCos` is in `Values`' closure through `Tower` → `Rigidity/ClassRatio`).
- Elaborated first in a scratch file over `Rigidity/ClassRatio`'s compiled closure (`data/fs131/iqp3/scratch/Five23.lean`,
  the value step against a stand-in for the bound with its exact statement), two rounds: one `rw` chain for `Q • (0, 1) = 0`
  that did not fire, replaced by `ext <;> simp`, and one argument order. Then copied into `Values`.
- 67 lines added, docstrings included, against `four_le`'s 11 removed: within the 50–70 the predecessors priced. **Its axioms are fewer than
  `four_le`'s**: the cosine bound is a `decide +kernel` certificate on the standard three, where `four_le` read Weil's bound
  (stage 4 prints them).
- The exact least cosine sum, for the docstring only (a float evaluation, not a check): `−7.9606871865…` over the 24 points;
  the certificate's `κ = 7.9606872` is above it, as a lower bound's constant must be.

**Text brought to what is proved** (docstrings and the map only): `Values`' module docstring (`5 ≤ χ_Bor(ℚ₂₃²) ≤ 8`, the lower
end's source, "any value at 23 beyond `[5, 8]`", the Models paragraph's model at 23, the title's "and FS131-IQP3");
`ARCHITECTURE.md`'s `PadicPlane/Values` row (the same; "proved by FS131-IQP1 and FS131-IQP3"); `tools/check_architecture.py`
PASS (`data/fs131/iqp3/arch0.txt`).

**The build** (the brief's command line: `--mem 8 --cpus 5`, `MEMMAX=8G BATCH=3`; `data/fs131/iqp3/build1.log`, full output
`build/gate/build/20261016T174449Z-4091013.log`): **OK — 736 of 736 batches, 9 modules rebuilt** (`Arith/FibreCert7` 3.3 s,
`FibreCert7Check` 33 s, `FibreCert7Bound` 1.3 s, `PadicPlane/Basic`, `Measure`, `Upper`, `Tower` 9.1 s, `Values` 4.6 s, and the
root), **0 with warnings, 22 m 59 s**. `grep -rnP '\bsorry\b'` over the eight landing modules: 0 lines.

**The lint** (`lake lint --no-build -- --no-build --trace` under the slot; `data/fs131/iqp3/lint1.log`): exit 0, "Linting passed
for Proofs.", all 14 linters `(2/2) Passed!`. With the two binders gone, `unusedArguments` has nothing to find in them; the new
helper is private, the new theorem has its docstring.

## Stage 3 — SAVED: the gate on one commit

**The commit of record: `7180f4b40`** (branch `fs131-kpa1`): stage 2's library (`4456013b3`, built green there) and the gate's
inputs (below); no Lean between the build and the pass — the pass's up-to-date check reads exit 0 in 4 s. **The pass**
(`data/fs131/iqp3/run-gate.sh`, `data/fs131/clone1/run-gate.sh`'s steps with this job's paths; logs `data/fs131/iqp3/gate/`),
18:35:43–18:51:04 UTC, `HEAD=7180f4b40…`, tracked files modified 0 at the start and 0 after. Every step exited 0. Read from the
saved logs, against `main`'s last gate (the collapse's, `data/fs131/ico2/gate/`, `7c72b9bf7`):

| step | `main`'s last gate (`7c72b9bf7`) | this pass (`7180f4b40`) | the change, explained |
|---|---|---|---|
| up to date | exit 0 | exit 0 (4 s) | — |
| `sorry` (narrow) | 0 lines | 0 lines | — |
| line-initial `axiom` | 5 lines | 5 lines, identical (`diff` empty) | no axiom added |
| doubled names | OK, 31 generated on demand | OK, 31, the list identical | no `congr_simp` or `eq_n` generated by the landing (the statement dump reads "generated on demand []" in each of the eight modules) |
| its self-test | 15 of 15 | 15 of 15 | — |
| axiom audit | 11398 records: 10747 clean, 569 axiom-free, 77 imported, 5 purchases | 11466: **10804** clean, **574** axiom-free, **83** imported, 5 | +68 records, every public record of the eight modules: 57 on the standard three or a subset (53 on all three, 3 on `propext`, 1 on `propext, Quot.sound`), 5 axiom-free (`FibreCert.cert7`, `cert7_nseg`, `cert7_p`, `cert7_scale`, `cert7_unum`), 6 IMPORTED on Weil's bound alone (`towerRatio_weil`, `charSum_unitCircle_ge_weil`, `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`, `not_exists_bound_borelChromaticNumber_padicPlane`, `borelChromaticNumber_padicPlane_three`); declared imports 3, library axioms 3, native auxiliaries 10, unchanged |
| its self-test | 23 of 23 | 23 of 23 | after the two state controls moved (below) |
| vacuity | declarations=22357, refutations-skipped=242; sites=1455 vacuous=0 stale=0 declared=3 witnessed=38 generic=1412 unknown=2 | declarations=**22431**, refutations-skipped=**243**; sites=**1458** … generic=**1415**, the rest identical | +74 declarations: the scan's own predicates read on the eight modules (`data/fs131/iqp3/lean/VacuityNew.lean`, `vacuity-new.txt`: `Basic` 11, `Measure` 17, `Upper` 6, `Tower` 9, `Values` 19, `FibreCert7` 1, `FibreCert7Check` 3, `FibreCert7Bound` 8); +1 refutation-skip, `PadicPlane.isIndepSet_wellFilled` (below); +3 sites, all `GENERIC` (below) |
| its self-test | 65 of 65 | 65 of 65 | — |
| assumptions | axioms=3 rests=99 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2 | rests=**105**, the rest identical | +6 `RESTS` rows, the six IMPORTED records' pairs with `kloosterman_bound` (its consumers 65 → 71); also constants 22111 → 22192, theorems 16208 → 16282, formers 456 → 457 (`TowerRatio`, concluded by `towerRatio_one`, `towerRatio_weil`, `towerRatio_of_charSum`, `towerRatio_of_fibreShareBound`; not flagged), hypotheses 26653 → 26785, `cohyp` 80, `unseen` 21481 → 21567 (the new theorems' other hypotheses, every one a condition on the theorem's own variables — `p` prime, `p % 4 = 3`, `κ ≥ 2` and the character-sum lower bound, `TowerRatio p c`, the stable-prime facts, a colouring's Borel classes: **no hand result of ours is written out in a binder**, said here on the landing's word as the step asks) |
| its self-test | 33 of 33 | 33 of 33 | — |
| architecture | PASS, 625 modules | PASS, **633** modules and rows, 0 import mismatches | +8 modules and rows (FS131-IQP1's; the `Values` row's text moved at stage 2) |
| lint | 14 linters `(2/2) Passed!`, "Linting passed for Proofs." | the same (16 s) | — |
| digests | the two ledgers' headers matching; `CLAUDE.md` matching | the two ledgers' headers match (9 of 9 each); `CLAUDE.md` flagged stale in exactly three places: § Trust ledger `10747 clean → 10804, 77 imported → 83`; § Trust ledger `rests 99 → 105`; § The gate `declarations 22357 → 22431, refutations-skipped 242 → 243, sites 1455 → 1458, generic 1412 → 1415` | `CLAUDE.md` is Keryx's to write: the drafts below |

**The gate's inputs, each seen red for its named cause before it moved** (`data/fs131/iqp3/prep/`, all at `7180f4b40`):
- **the audit's blocks**, generated from the kernel's print of every record of the eight modules (`lean/AxiomsAll.lean` →
  `axioms-all.txt`: 79 records, 68 public, 11 private — the helpers, which the audit does not take) by `audit_block.py` (FS131-ICO2's
  generator; its plant made reachable when no record is filed yet, and made to check each planted fault by name): 62 CLEAN in a
  block at the end of CLEAN, 6 IMPORTED under `kloosterman_bound`'s banner, each block with its job line. Its coverage check after
  filing reads all 68 filed under their class (`audit-coverage.out`); against the pre-filing audit (`scripts/Axioms.lean` at
  `4456013b3`) it reports the 68 `UNFILED`, exit 1 (`audit-coverage-plant.out`); its plant (an unknown axiom in `TowerRatio`, a
  `sorryAx` in `TowerRatio.mono`, `borelChromaticNumber` filed under PURCHASED) reports all three by name and nothing else
  (`audit-block-plant.out`, `PLANT FIRED`).
- **`scripts/axioms-controls.txt`**: the self-test on the filed audit failed exactly `baseline` (expected `imported=77`, got 83) and
  `imported_declared` (78, got 84), the other 21 behaving (`prep/axioms-selftest-red.log`); moved by the file's rule (the two
  counts, the two `old` digests' texts, the header's tally: eighty-three IMPORTED, Weil's bound 64), then 23 of 23 in the pass.
  `banner_dropped` needs no change: no import was declared.
- **`scripts/assumptions-ledger.txt`**: the step failed on exactly six `unlisted-consumer` rows, the six `RESTS` pairs
  (`prep/assumptions-red.log`); written by `--write-ledger` (6 rows in, none out; `prep/assumptions-write-ledger.log`).
- **`scripts/vacuity-baseline.txt`**: the header's count line, after the scan flagged it stale and nothing else
  (`prep/vacuity.log`).
- No `AssumptionAudit.declared` line: the landing takes no hypothesis standing for an assumption.

**The statement comparison** (`data/fs131/iqp3/statements.py`, shaped like FS131-ICO2's, against
`data/fs131/iqp1/statements-before.txt` — the skeleton's compiled library dumped by FS131-IQP1 before any proof; the after-dump
`statements-after.txt.gz` from this job's dumper, `lean/StatementDump.lean`, FS131-IQP1's with the three `Arith/FibreCert7*`
modules added, on the gated build; `gate/statements.out`): **CLEAN**. In the five `PadicPlane/` modules every stored type, and
every definition's data (the value with proofs erased: `borelChromaticNumber`, `padicPlane`, `TowerRatio`, `haar`, `res` and the
scoped instances), is the skeleton's — 54 constants SAME by raw text and Lean's hash — but the ruled changes:
- **the two drops** (item 1014 (1)), shown from the kernel's side by term surgery on the gated build (`lean/ReAdd.lean`, after
  FS131-LCH1's): the binder put back into the stored type with `mkArrow` after its leading binders gives the before-print exactly,
  by hash and by raw text (which shows every binder's kind) — `exists_levelEmbedding`, `(hk : 1 ≤ k)` after seven binders, hash
  `722125952`; `charSum_levelOne_of_unitCircle`, `hpP` after three, its domain read from `exists_levelEmbedding`'s own `hpP`,
  hash `423489433`. For each, two controls must and do differ from the before-print in hash and text: the domain `True`, and a
  near miss (`2 ≤ k`; `hpP` at `p.succ`);
- **the three leaves at 23 removed** (item 1002): `fibreShareBound_twentyThree`,
  `unitQuadrance_zmod_twentyThree_pow_not_colorable_five`, `six_le_borelChromaticNumber_padicPlane_twentyThree` — kept verbatim
  in `data/fs131/iqp1/leaves-23.lean`;
- **`four_le` → `five_le`** (item 1014 (2)): `four_le_borelChromaticNumber_padicPlane_twentyThree` was added after the before-dump
  and is gone, so it is in neither print; `five_le_borelChromaticNumber_padicPlane_twentyThree` is ADDED, public, the one public
  constant the five modules gain;
- **the helpers**, ADDED, private, each named in the comparator: FS131-IQP1's ten (`Basic`: `not_sq_eq_neg_one`,
  `norm_le_one_of_le_of_sq_add_sq`; `Tower`: `normOne_iff_pow`, `card_normOneSet_one`, `finrank_int_le_two`, `charP_quot_pow`;
  `Measure`: `isAddHaarMeasure_haar`, `res_eq_iff_dist_le`, `res_eq_of_le`, `haar_bad_le`) and this job's one (`Values`:
  `charSum_unitCircle_ge_of_circleCos`);
- **the three new modules** (the plan's leaf C7, FS131-IQP1), every public constant named: `FibreCert.cert7`; `cert7_global`,
  `cert7_seg0`, `cert7_psd`; `cert7_p`, `cert7_unum`, `cert7_scale`, `cert7_nseg`, `cert7_ok`, `FibreCertSound.sum_le_seven`,
  `model_seven`.
Its plants (`gate/statements-plant.out`, `PLANTS ALL FIRED`): a changed stored type, a dropped constant, an unlisted public
constant, an unlisted constant in a new module, and a re-added type one character off — each reported by name, nothing else new.
The `.gz` prints read the same as the plain ones (checked, then the plain copies removed: item 1011).

**The scan's new sites, and its new refutation-skip, read by hand.**
- `SITE GENERIC PadicPlane.one_add_div_le_of_borelColoring`, `one_le_mul_of_borelColoring` — `(padicPlane p).Coloring (Fin k)`
  with Borel classes: inhabited at `p = 3`, `k = 3` (`exists_borelColoring_of_colorable 3 _ finitePlane3_colorable_three`, kernel,
  standard three; the composition `borelChromaticNumber_padicPlane_three` runs through it), and likewise at `7, 4`; `11, 5`;
  `19, 5`; `23, 8`. Empty below the bound at each `p`: that emptiness is the theorem, and no statement takes it as an assumption.
- `SITE GENERIC PadicPlane.borelChromaticNumber_le_of_coloring` — `G.Coloring (Fin k)`, generic in `G`: the same colourings, and the
  spec example in `Basic` (the empty graph's constant colouring).
- **refutation-skipped**: `PadicPlane.isIndepSet_wellFilled` concludes `IsIndepSet …`, which the reducing telescope reads through
  to `→ False`; it refutes nothing (the cosets a measurable independent set fills to more than half are independent). Its carrier,
  a measurable independent `I ⊆ ℤ_p²`, is inhabited by the pulled-back colour classes the proof of `one_le_mul_of_borelColoring`
  feeds it (at `p = 3`, `k = 3` above; one class has measure at least `1/3`, so some coset is more than half filled), and in
  mathematics by the level-one coset of `0`, which fills itself (not stated in the library).

**The structure hypotheses, by hand** (the scan has no site for them):

| hypothesis | where taken | model, and grade |
|---|---|---|
| `TowerRatio p c` | `Basic`, `Measure`, `Values` | `towerRatio_one` at every `p` (kernel, standard three); at `c = 2√p/(p + 1 + 2√p)`, `towerRatio_weil` (kernel, on Weil's bound); at `U/p²`, `towerRatio_of_fibreShareBound` at 7, 11, 19 (kernel, standard three) |
| `P : StablePrime ⊥` with `↑p ∈ P`, `2 ∉ P`, `|𝓞 ⧸ P| = p²` | `Tower` | `exists_stablePrime_above p hp` at every `p ≡ 3 (mod 4)` (kernel, standard three) |
| `CertLink.FibreShareBound p U` | `Tower`, `Values` | `fibreShareBound_seven`, `CertLink.fibreShareBound_eleven`, `CertLink.exists_fibreShareBound_nineteen` (kernel, standard three) |
| `2 ≤ κ` and `∀ ψ ≠ 1, −κ ≤ Re Σ_{circle} ψ` | `Tower`, `Values` | at `κ = 2√p`, `charSum_unitCircle_ge_weil` (kernel, on Weil's bound); at `p = 23`, `κ = 7.9606872`, the private `charSum_unitCircle_ge_of_circleCos` with `CircleCos.circleCos_ge` (kernel, standard three) |
| `(finitePlane p).Colorable k` | `Upper` | `finitePlane3_colorable_three`, `finitePlane7_colorable_four`, `finitePlane11_colorable_five`, `finitePlane19_colorable_five`, `CayleyCert.colorable_finitePlane23_eight` (kernel, standard three) |

**`#print axioms` of every head statement** (the receipt of record, `gate/receipt-axioms.log`; the same lists in
`data/fs131/iqp3/read-aloud.txt`):
- the bound by characters, `le_borelChromaticNumber_of_charSum`: `[propext, Classical.choice, Quot.sound]` — as expected;
- the Weil form and the unboundedness — `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`,
  `not_exists_bound_borelChromaticNumber_padicPlane` — and the value at 3, `borelChromaticNumber_padicPlane_three`: those three
  and `StandingFive.kloosterman_bound` (the value at 3 reads the bound at `κ = 2√3`);
- **the lower end at 23, `five_le_borelChromaticNumber_padicPlane_twentyThree`: `[propext, Classical.choice, Quot.sound]`** — no
  Weil, where `four_le` read it: the cosine bound is the kernel's own certificate;
- the values at 7, 11, 19, `…_twentyThree_le_eight`, the three level clauses, `borelChromaticNumber_le_chromaticNumber` and
  `FibreCertSound.sum_le_seven`: the standard three.

**Negative controls watched red in this job**: the quotation checker's plant; the comparator's five plants and the re-add's two
controls per drop; the audit block's three plants and the coverage check against the pre-filing audit; the audit's two state
controls and the assumptions step's six rows, each red for its named cause before its input moved; the vacuity header, flagged
stale before it moved. Each self-test plants its own (15, 23, 65, 33 controls). **Not run: a lint plant** — the lint step is the
driver over the whole library, its control watched at FS131-LGT1; no lint finding arose here.

## Stage 4 — SAVED: the read-aloud, against `LEDGER.md` row 75 and FS66-T7

The stored statements as the gated build prints them (`data/fs131/iqp3/lean/ReadAloud.lean` → `data/fs131/iqp3/read-aloud.txt`,
`pp.fullNames`, and `pp.explicit` for the Borel clause), read against FS66-T7 (`plans/FS66-derivation.md` l. 316) and row 75's
"Consequences" clause, with the posers' question quoted from `CLOSED-QUESTIONS.md` § 1.8 (`[BardestaniMallahiKarai2017]`
Question 1, p. 2: *"Is it true that there exists a universal constant B (independent of p) such that χ_Bor(QG_{𝒬_p}) ≤ B, holds
as p ranges over all primes of the form 4k + 3?"*).

**The objects.**
- `borelChromaticNumber G = ⨅ k, ⨅ (_ : ∃ c : G.Coloring (Fin k), ∀ i, MeasurableSet (c ⁻¹' {i})), (k : ℕ∞)`, the σ-algebra
  `borel X` of the graph's topology (the explicit print shows `@borel (ℚ_[p] × ℚ_[p]) (instTopologicalSpaceProd …)` of the
  `p`-adic norm topology): *the least number of colours of a proper colouring whose every colour class is a Borel set, `⊤` if
  there is none* — the posers' `χ_Bor`, read in `ℕ∞`.
- `padicPlane p = unitQuadrance ℚ_[p] = addCayley {v | v.1² + v.2² = 1}`: *vertices `ℚ_p × ℚ_p`, `x ~ y` iff `x ≠ y` and
  `(x₁ − y₁)² + (x₂ − y₂)² = 1`* — `QG_{𝒬_p}` for the form `x² + y²`, which is anisotropic exactly at `p ≡ 3 (mod 4)`.
- `TowerRatio p c`: *for every `k ≥ 1`, every independent set of `UD(ℤ/p^k, 2)` has at most `c · p^{2k}` points.*

**The heads, read aloud.**
- `one_add_div_le_of_borelColoring : ∀ p [Fact p.Prime], p % 4 = 3 → ∀ {k} (c : (padicPlane p).Coloring (Fin k)),
  (∀ i, MeasurableSet (c ⁻¹' {i})) → 1 + (p + 1)/(2√p) ≤ k`. *For every prime `p ≡ 3 (mod 4)`, every proper colouring of the
  `p`-adic plane with Borel colour classes uses at least `1 + (p + 1)/(2√p)` colours.* FS66-T7's first sentence,
  `χ_Bor(QG_{ℚ_p}) ≥ 1 + (p+1)/(2√p)`, stated for colourings. **Matches.**
- `le_borelChromaticNumber_padicPlane : … → ⌈1 + (p + 1)/(2√p)⌉ ≤ borelChromaticNumber (padicPlane p)`. The same, as a number.
  **Matches** (`⌈·⌉` is the least integer above, which is what an integer-valued bound reads).
- `not_exists_bound_borelChromaticNumber_padicPlane : ¬ ∃ B : ℕ, ∀ p [Fact p.Prime], p % 4 = 3 → borelChromaticNumber
  (padicPlane p) ≤ B`. *There is no constant `B` with `χ_Bor(ℚ_p²) ≤ B` for every prime `p = 4k + 3`* — the posers' Question 1,
  negated in its own shape. `B : ℕ` against the posers' "universal constant": the same, since a real `B` would give `⌊B⌋`.
  T7's "`> √p/2`" is a step of the proof (`1 + (p + 1)/(2√p) ≥ √p/2`, with Mathlib's Dirichlet for primes `p ≡ 3 (mod 4)` above
  `4(B + 1)²`), not a stated theorem. **Matches T7's second sentence.**
- `le_borelChromaticNumber_of_charSum : ∀ p [Fact p.Prime], p % 4 = 3 → ∀ {κ}, 2 ≤ κ → (∀ ψ : AddChar ((ℤ/p)²) ℂ, ψ ≠ 1 →
  −κ ≤ Re Σ_{s ∈ unitCircle p} ψ s) → ⌈1 + (p + 1)/κ⌉ ≤ borelChromaticNumber (padicPlane p)`. *If every non-trivial character of
  `(ℤ/p)²` sums over the circle `a² + b² = 1` to real part at least `−κ`, with `κ ≥ 2`, the Borel `p`-adic plane needs
  `1 + (p + 1)/κ` colours* — Hoffman's ratio bound of `UD(𝔽_p, 2)` carried to every level and to Borel colourings. In neither
  T7 nor row 75: the general form, with T7 its case `κ = 2√p`; on the standard three.
- The values: `borelChromaticNumber (padicPlane 3) = 3`, `(padicPlane 7) = 4`, `(padicPlane 11) = 5`, `(padicPlane 19) = 5`;
  `5 ≤ borelChromaticNumber (padicPlane 23)` and `borelChromaticNumber (padicPlane 23) ≤ 8`. Row 75's "`χ_Bor(ℚ_p²) = 4, 5, 5`
  at 7, 11, 19" — **matches**; at 3 the kernel adds `3`, which the row does not state; at 23 the row's [cert] clause says
  `χ_Bor(ℚ₂₃²) ≥ 6` with the ceiling `χ(Γ₂₃) ∈ {6, 7, 8}`: **the kernel holds `[5, 8]`, not `≥ 6`.**
- The level clauses: `∀ k, 1 ≤ k → ¬ (unitQuadrance (ZMod (7^k))).Colorable 3`, and at `11^k`, `19^k` with `4`. Row 75's "no
  level at 11 or 19 is four-colourable, none at 7 three-colourable" — **matches**; "none at 23 five-colourable" — **not in the
  kernel.**
- `borelChromaticNumber_le_chromaticNumber : p % 4 = 3 → χ_Bor(padicPlane p) ≤ (finitePlane p).chromaticNumber`: the upper
  halves' source, `[Madore2015]` Prop. 3.2 made Borel (T8's upper half).
- The two drops, as the kernel now has them: `exists_levelEmbedding` holds at every `k`, `k = 0` included (both sides one
  point); `charSum_levelOne_of_unitCircle` asks only `2 ∉ P` and `|𝓞 ⧸ P| = p²` of the stable prime. Each is weaker in its
  hypotheses than the statement it replaces, so every former use still elaborates; both are internal steps, not heads.

**Not claimed**, and stated by no declaration: the plain chromatic number `χ(ℚ_p²)` — `chromaticNumber_le_borelChromaticNumber`
gives `χ ≤ χ_Bor` only, and nothing bounds `χ(ℚ_p²)` from below; `6 ≤ χ_Bor(ℚ₂₃²)` (it needs FS-66's certificate at 23, or a
reduced one, search request 26); the level clause at 23 (the same); anything at `p ≡ 1 (mod 4)` or `p = 2` — every head carries
`p % 4 = 3` or sits at a fixed `p ≡ 3 (mod 4)`; any growth rate between `√p/2` and `χ(UD(𝔽_p, 2))`.

**The trust each reading rests on** (stage 3's prints): the Weil form, the unboundedness and the value at 3 on
`StandingFive.kloosterman_bound` (`[Weil1948]` p. 207) and the standard three; everything else, the bound by characters and the
lower end at 23 included, on the standard three.

## Stage 5 — SAVED: the drafts

The drafts below are for files this lane does not write; each names its slot. They bring the planner's
`plans/FS131-KPA1-padic-plan.md` § 5.2–5.6 to what is proved (at 23 the kernel holds `5 ≤ χ_Bor(ℚ₂₃²) ≤ 8`, not `6 ≤`; row 75's
level clause at 23 is not in the kernel), with FS131-IQP1's two `LEAN.md` lines among them.

## Drafts for the front page

*Each draft names its slot: the file, the section, and the words it replaces or follows. Keryx files them. The commit of
record is the gate's (stage 4); the counts are read from its saved logs. The question is the posers' — M. Bardestani and
K. Mallahi-Karai's, `[BardestaniMallahiKarai2017]` Question 1 (`BIBLIOGRAPHY.md`'s row `[BardestaniMallahiKarai2015]`, the
same paper) — and every draft that names it says so.*

### D1 — `CLAUDE.md` § Trust ledger, the audit's sentence

Two replacements in the paragraph beginning "Audited at every milestone with `#print axioms`":

1. "the current audit reads 10747 clean and 5 declared purchases, and 77 imported (and 569 axiom-free; 11,398 records at
   FS131-ICO2, the collapse, 2026-10-16)" *becomes*

   > the current audit reads 10804 clean and 5 declared purchases, and 83 imported (and 574 axiom-free; 11,466 records at
   > FS131-IQP3, the p-adic plane, 2026-10-16)

2. "with fifty-eight imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1; twenty-six the
   five-colour chain's, FS131-LGT1; two the main clause's through five as one theorem, FS131-IL5; ten the collapse's, FS131-ICO2:
   the thickness of ℚ(√635087) and de Grey's field, the two instances, the per-place form, the six-or-seven corollary, and D-E2's
   `Rigidity.norm_charSum_le_weil`);" *becomes*

   > with sixty-four imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1; twenty-six the
   > five-colour chain's, FS131-LGT1; two the main clause's through five as one theorem, FS131-IL5; ten the collapse's,
   > FS131-ICO2: the thickness of ℚ(√635087) and de Grey's field, the two instances, the per-place form, the six-or-seven
   > corollary, and D-E2's `Rigidity.norm_charSum_le_weil`; six the p-adic plane's, FS131-IQP3: the bound at `κ = 2√p`
   > `PadicPlane.charSum_unitCircle_ge_weil` and `towerRatio_weil`, the posers' question answered —
   > `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`, `not_exists_bound_borelChromaticNumber_padicPlane` —
   > and `borelChromaticNumber_padicPlane_three`);

The digest's own words for the check (`data/fs131/iqp3/gate/digest-axioms.txt`): "RECORDED COUNT IS STALE in CLAUDE.md § Trust
ledger — update it: 10747 clean → 10804, 77 imported → 83".

### D2 — `CLAUDE.md` § Trust ledger, the assumptions sentence

In the paragraph "**What the library assumes, in both forms**": "`axioms=3 rests=99 named=19 inline=14 outside=7 ours=21 open=5
takes=109 mentions=2` — three outside theorems declared as axioms, with ninety-nine (axiom, theorem) rows resting on them,
eighty-four theorems, thirteen of them on two and one on three;" *becomes*

> `axioms=3 rests=105 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2` — three outside theorems declared as
> axioms, with one hundred and five (axiom, theorem) rows resting on them, ninety theorems, thirteen of them on two and one on
> three;

(the six new rows are the p-adic plane's six records on Weil's bound alone: `kloosterman_bound`'s consumers 65 → 71; the digest:
"RECORDED COUNTS ARE STALE in CLAUDE.md § Trust ledger — update it: rests 99 → 105"; `scripts/assumptions-ledger.txt`'s header
is already moved, at `7180f4b40`).

### D3 — `CLAUDE.md` § The gate, the vacuity counts

In § The gate, "`declarations=22357 refutations-skipped=242 sites=1455`, `vacuous=0 stale=0 declared=3 witnessed=38
generic=1412 unknown=2`" *becomes*

> `declarations=22431 refutations-skipped=243 sites=1458`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1415 unknown=2`

(+74 declarations, the eight modules'; +1 skip, `PadicPlane.isIndepSet_wellFilled`, which refutes nothing; +3 `GENERIC` sites,
the Borel-colouring binders, inhabited at `p = 3`, `k = 3`; `scripts/vacuity-baseline.txt`'s header is already moved). The
baseline's two entries are unchanged.

### D4 — `CLAUDE.md` § Frontier, the "Last filed" line

*Replaces* "Last filed: **the collapse** (FS131-KCL1, FS131-ICO1, FS131-ICO2, 2026-10-16: seven `Collapse/` modules through the
gate on `7c72b9bf7` — the field equality `χ(F²) = χ(ℝ²)` wherever the stable primes are uniformly thick below `1/5`, and with
no hypothesis at ℚ(√635087) and de Grey's field; row 128's field clause, its MR the kernel's `Rigidity.mrPlus`, stated in
§ Where the problem stands; no value of `χ(ℝ²)` moved); before it, every earlier filing, newest first: `plans/FILINGS.md`."
*with* (if this landing is filed after the collapse with nothing between):

> Last filed: **the p-adic plane** (FS131-KPA1, FS131-IQP1, FS131-IQP3, 2026-10-16: eight modules through the gate on
> `7180f4b40` — the posers' `[BardestaniMallahiKarai2017]` Question 1 answered no in the kernel: every Borel colouring of the
> anisotropic `ℚ_p²` uses at least `1 + (p + 1)/(2√p)` colours, on Weil's bound; `χ_Bor(ℚ_p²) = 3, 4, 5, 5` at
> `p = 3, 7, 11, 19` and `5 ≤ χ_Bor(ℚ₂₃²) ≤ 8`; row 75's consequences clause, stated in § Where the problem stands; no value
> of `χ(ℝ²)` moved); before it, **the collapse** (FS131-KCL1, FS131-ICO1, FS131-ICO2) and every earlier filing, newest first:
> `plans/FILINGS.md`.

### D5 — `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval"

*Inserted after* the collapse's clause (ending "…the derivation FS-103's, the kernel's check this landing's;") *and before*
"**Theorems A and B**":

> **the p-adic plane** (FS-131, FS131-IQP3): every Borel colouring of the anisotropic `p`-adic plane — `ℚ_p²`, `p ≡ 3 (mod 4)`,
> `x ~ y` when `(x₁ − y₁)² + (x₂ − y₂)² = 1` — uses at least `1 + (p + 1)/(2√p)` colours, so no constant bounds its Borel
> chromatic number as `p` varies: the posers' `[BardestaniMallahiKarai2017]` Question 1, answered no
> (`PadicPlane.one_add_div_le_of_borelColoring`, `not_exists_bound_borelChromaticNumber_padicPlane`, on Weil's bound); the
> bound is Hoffman's ratio bound of the finite plane carried to every level of the residue tower and to Borel colourings
> (`le_borelChromaticNumber_of_charSum`, standard three), with no `[BardestaniMallahiKarai2017]` Theorem 2.5;
> `χ_Bor(ℚ_p²) = 3, 4, 5, 5` at `p = 3, 7, 11, 19` and `5 ≤ χ_Bor(ℚ₂₃²) ≤ 8` (`borelChromaticNumber_padicPlane_three`, …,
> `five_le_borelChromaticNumber_padicPlane_twentyThree`; the value at 3 on Weil's bound, the rest on the standard three: FS-66's
> fibre-share certificates at 7, 11, 19, the circle's exact cosine sums at 23); no level `UD(ℤ/p^k, 2)` three-colourable at 7,
> four-colourable at 11 or 19 (row 75). Not claimed: the plain `χ(ℚ_p²)`; `6 ≤ χ_Bor(ℚ₂₃²)` and the level clause at 23 (row
> 75's [cert]). The question and the bound `O(p²)` are the posers', the upper halves `[Madore2015]`'s construction; the lower
> bound and the values: prior art not found in print (FS66-T7's search); the kernel proof is this project's;

### D6 — `LEDGER.md` row 75

1. *A `**[kernel]**` clause, inserted before* "**[hand]** *The fibre-share inequality:*":

   > **[kernel]** (FS-131: `PadicPlane/`, planned by FS131-KPA1, proved by FS131-IQP1 and FS131-IQP3; `Arith/FibreCert7*`)
   > `PadicPlane.one_add_div_le_of_borelColoring` — every Borel colouring of `ℚ_p²` at `p ≡ 3 (mod 4)` uses at least
   > `1 + (p + 1)/(2√p)` colours — and `not_exists_bound_borelChromaticNumber_padicPlane` — the posers'
   > `[BardestaniMallahiKarai2017]` Question 1 answered no —, on the standard three and `StandingFive.kloosterman_bound`;
   > `le_borelChromaticNumber_of_charSum` — Hoffman's bound of `UD(𝔽_p, 2)` carried to `χ_Bor(ℚ_p²)` —,
   > `towerRatio_of_fibreShareBound` — a fibre-share bound `Σφ ≤ U` gives `α(UD(ℤ/p^k, 2)) ≤ U·p^{2(k−1)}` at every level
   > `k ≥ 1` —, the values `χ_Bor(ℚ_p²) = 4, 5, 5` at `p = 7, 11, 19` (`borelChromaticNumber_padicPlane_seven`, `…_eleven`,
   > `…_nineteen`: FS-66's certificate at 7, `cert-p7.json`, checked by `decide +kernel` in `Arith/FibreCert7Check`; at 11 the
   > kernel's certificate, at 19 the Searcher's reduced one, `U = 88.6434…`), `5 ≤ χ_Bor(ℚ₂₃²) ≤ 8`
   > (`five_le_borelChromaticNumber_padicPlane_twentyThree`, the bound at the circle's exact cosine sums `CircleCos.circleCos_ge`,
   > `κ = 7.9606872`; `…_twentyThree_le_eight`), and the level clauses — no level `UD(ℤ/7^k, 2)` three-colourable, none at 11 or
   > 19 four-colourable (`unitQuadrance_zmod_seven_pow_not_colorable_three`, `…_eleven_pow_not_colorable_four`,
   > `…_nineteen_pow_not_colorable_four`) —, on the standard three; `χ_Bor(ℚ₃²) = 3` on the standard three and Weil's bound.
   > With no `[BardestaniMallahiKarai2017]` Theorem 2.5: Hoffman's bound at every level and the well-filled cosets. Not in the
   > kernel: `6 ≤ χ_Bor(ℚ₂₃²)` and the level clause at 23 (FS-66's certificate there, 1,444,136 ops; its reduced form is search
   > request 26).

2. *After* "and **`α(Γ₂₃) ≤ 97`** (was 105; bracket [87, 97]; `46,023 ≤ α(UD(ℤ/529,2)) ≤ 51,833`)." *(the planner's grade
   note, `plans/FS131-KPA1-padic-plan.md` § 5.2, unchanged):*

   > The kernel's certificate at 19 is not FS-66's: `cert19_ok` (`Arith/FibreCert19Bound`) checks the Searcher's reduced
   > certificate (`data/search/2026-10-14/certs/v-p19-phi0-13-qs.json`, `U = 88.6434…`), not `cert-p19.json`
   > (`U = 77.511742`); so at 19 the kernel holds `Σφ ≤ 88.64` and the clauses `α(Γ₁₉) ∈ {76, 77}`, `27,981` and the Haar
   > bracket at 19 rest on `cert-p19.json`, `[cert]`.

3. *In "**Consequences:**", the words* "`χ_Bor(ℚ_p²) = 4, 5, 5` at 7, 11, 19 and `[BardestaniMallahiKarai2017]` Question 1
   answered **no** (`χ_Bor(ℚ_p²) ≥ 1 + (p+1)/(2√p)`; `CLOSED-QUESTIONS.md` §1.8)" *are followed by* "— both in the kernel
   (above)", *and* "`χ_Bor(ℚ₂₃²) ≥ 6` (ceiling χ(Γ₂₃) ∈ {6, 7, 8})" *becomes* "`χ_Bor(ℚ₂₃²) ≥ 6` [cert] (the kernel holds `≥ 5`
   and `≤ 8`; ceiling χ(Γ₂₃) ∈ {6, 7, 8})".

4. *The "Prior art" clause's first sentence* "the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(G_k) ≤ χ(G₁)` is `[Madore2015]`
   Prop. 3.8;" *is replaced by (the planner's correction, § 5.2):*

   > the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(G_k) ≤ χ(G₁)` at `p ≡ 3 (mod 4)` is `[Madore2015]` Prop. 3.2 with Rem. 3.6
   > (`χ((ℚ_p)²) ≤ χ((𝔽_p)²)`), the levels between being the tower's monotonicity, whose step `χ((A/m²)^d) ≤ χ((A/m)^d)` is
   > his Prop. 3.8;

   *and* "Ours: the inequality, the certificates and their checker, every value above, the answer." *becomes* "Ours: the
   inequality, the certificates and their checker, every value above, the answer, and the kernel proof (FS-131)."

5. *The address cell gains* `Proofs/HadwigerNelson/PadicPlane/`, `Arith/FibreCert7.lean`, `Arith/FibreCert7Check.lean`,
   `Arith/FibreCert7Bound.lean`.

### D7 — `CLOSED-QUESTIONS.md` § 1.8

1. *In the opening quotation's paragraph,* "and his Prop. 3.8 is the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(UD(ℤ/p^k, 2))
   ≤ χ(UD(𝔽_p, 2))` this whole entry stands on." *is replaced by (the planner's § 5.3):*

   > and his Prop. 3.2 with Rem. 3.6 gives the ends of the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(UD(ℤ/p^k, 2)) ≤
   > χ(UD(𝔽_p, 2))` this whole entry stands on (`χ((ℚ_p)²) ≤ χ((𝔽_p)²)` at `p ≡ 3 (mod 4)`), the levels between being the
   > tower's monotonicity (his Prop. 3.8 is the variant modulo `m²`).

2. *The first bullet's grade* "[hand]" *becomes* "[kernel, on Weil's bound]", *and after its last sentence:*

   > In the kernel (FS131-KPA1, FS131-IQP1, FS131-IQP3; `PadicPlane.one_add_div_le_of_borelColoring`,
   > `not_exists_bound_borelChromaticNumber_padicPlane`) the bound is proved without Theorem 2.5: Hoffman's ratio bound at
   > every finite level `UD(ℤ/p^k, 2)`, and the cosets a Borel colour class fills to more than half, which form an independent
   > set of a level.

3. *The second bullet's head* "**`χ_Bor(ℚ₇²) = 4`, `χ_Bor(ℚ₁₁²) = 5`, `χ_Bor(ℚ₁₉²) = 5`, and `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8`** [exact
   certificate + hand]" *becomes* "**`χ_Bor(ℚ₇²) = 4`, `χ_Bor(ℚ₁₁²) = 5`, `χ_Bor(ℚ₁₉²) = 5`** [kernel], **and
   `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8`** [exact certificate + hand; the kernel holds `5 ≤ χ_Bor(ℚ₂₃²) ≤ 8`, the lower end by the circle's exact
   cosine sums]", *and after the bullet's sentence ending* "…standard three axioms)." *:*

   > The three values, and `5 ≤ χ_Bor(ℚ₂₃²) ≤ 8`, are kernel theorems on the standard three (`PadicPlane/Values`); the kernel
   > checks FS-66's certificate at 7 itself, the library's at 11 and the Searcher's reduced one at 19.

4. *"What it does not say"*: "Nothing exact at `p = 23` until its finite plane is decided." *is followed by* "The kernel's lower
   end there is five; six rests on FS-66's certificate (search request 26 asks for one small enough to check)."

### D8 — `BIBLIOGRAPHY.md` (the planner's § 5.4, carried unchanged; this job read neither paper)

- `[Madore2015]`, read status: add "pp. 6–8 (Prop. 3.2 with its proof, Cor. 3.4, Rem. 3.5–3.6, ¶3.7, Prop. 3.8 with its proof,
  Prop. 3.9's statement), ¶1.5, ¶6.6 and ¶7's opening read 2026-10-16 (FS131-KPA1)".
- `[BardestaniMallahiKarai2015]` (cited as `[BardestaniMallahiKarai2017]`), read status: add "§1–§2 re-read 2026-10-16
  (FS131-KPA1): Definition 2.6, Theorem 2.2, Lemma 2.4, Theorem 2.5, Question 1". Its role cell might add: "Question 1 answered
  no in the kernel (FS-131, `PadicPlane/Values`), its Theorem 2.5 not used".

### D9 — a stub to mint (the planner's § 5.5, the coordinator's ruling (3) of item 999), brought to what is proved

**The Borel bound at every anisotropic local field — a reading.** *Claim (one mind, not checked line by line):* for every
non-archimedean local field `K` of odd residue characteristic whose residue field `𝔽_q` has `q ≡ 3 (mod 4)` — the fields over
which `x² + y²` is anisotropic — `χ_Bor(K²) ≥ 1 + (q + 1)/(2√q)`, and with the certificates `χ_Bor(K²) = 4, 5, 5` and `≥ 6`
whenever `𝔽_q = 𝔽₇, 𝔽₁₁, 𝔽₁₉, 𝔽₂₃` (at `𝔽₂₃` the kernel's route gives `≥ 5` from the circle's cosine sums alone; `≥ 6` needs
FS-66's certificate, [cert]), ramified extensions of `ℚ_p` and `𝔽_q((t))` included. *Why:* the route reads `ℚ_p` only as a
complete discrete valuation ring with odd residue characteristic: Lemma P's square-zero algebra (`Rigidity/ClassRatio`'s
`SqZeroInvT`) never reads the ramification; Madore's Prop. 3.2 (any valuation ring) makes unit vectors integral; Hensel lifts
the circle; Haar on `𝓞_K²` is regular. *Killing test:* a level of `UD(𝓞_K/𝔪^k, 2)` at a ramified `K` with an independent set
above `2√q/(q + 1 + 2√q)` of its points. *Bearing on the answer:* none on `χ(ℝ²)`; it widens the answer to the posers'
question from `ℚ_p` to every local field they consider (their Theorem 1.1 is for characteristic zero; their Rem. 1.5 asks for
positive characteristic). *Lean:* Mathlib at the pin has no general local field API this would read; `ℚ_p(√p)` or `𝔽_q((t))`
as instances would each be a job. *The kernel's `ℚ_p` case is `PadicPlane/Values` (FS-131), whose proof reads `ℚ_p` through
`ℤ_[p]`, `PadicInt.toZModPow` and Mathlib's Hensel.*

### D10 — `LEAN.md`

*§ Searching — Lean, appended (the planner's three, § 5.6; the first job's two, its report; one of this job's):*

- `MeasurableSet[m] s` is notation scoped in `MeasureTheory`: a module that writes it without `open MeasureTheory` fails
  with `failed to synthesize GetElem (Set ?m → Prop) (MeasurableSpace …)` (FS131-KPA1).
- Mathlib at the pin declares no `MeasurableSpace` on `ℚ_[p]` or `ℤ_[p]` and no continuity lemma for `PadicInt.toZModPow`;
  a scoped `noncomputable` Borel instance on `ℤ_[p]` makes `Measure.addHaarMeasure ⊤` on `ℤ_[p] × ℤ_[p]` elaborate with no
  further instance (compact, second countable, Borel product). An `abbrev` over `unitQuadrance ℚ_[p]` must be
  `noncomputable` (`instCommRingPadic`). `PadicInt.subring`, `PadicInt.Coe.ringHom`, `PadicInt.norm_le_pow_iff_mem_span_pow`,
  `PadicInt.cast_toZModPow` and `hensels_lemma` (`Mathlib/NumberTheory/Padics/Hensel.lean` l. 459) are the names
  (FS131-KPA1).
- `[OAIMath2026]`'s `OAI/NumberTheory/PrimePackets/HaarBounds.lean` l. 18 (`haar_kernel_eq_inv_card`) is the ten-line pattern
  for the measure of a kernel of finite index, over `AddSubgroup.index_mul_measure` (FS131-KPA1).
- At the pin `hensels_lemma` gives only `‖z − b₀‖ < 1`, not the distance, so a congruence modulo `p^k` needs the unit
  argument `(z − b₀)(z + b₀) = −δ` with `z + b₀` a unit (`PadicPlane.exists_unitVector_lift`, FS131-IQP1).
- Instances of `Measure.addHaarMeasure ⊤` are not found through a `def` that wraps it (`PadicPlane.haar p`): a local `haveI`
  from a private `isAddHaarMeasure_haar` serves, with no instance declared on the wrapper (FS131-IQP1).
- A character of `(ℤ/q)²` is a cosine sum's term with no residue field in between: `ψ(1, 0) = ζ^α` and `ψ(0, 1) = ζ^β`
  (`(Complex.isPrimitiveRoot_exp q _).eq_pow_of_pow_eq_one`, with `q • v = 0` by `ext <;> simp`), and
  `v = v₁.val • (1, 0) + v₂.val • (0, 1)` gives `ψ v = ζ^{(αv₁ + βv₂) mod q}` through `AddChar.map_nsmul_eq_pow` and
  `map_add_eq_mul`; `ψ ≠ 1` is `(α, β) ≠ 0` — `Rigidity/ClassRatio`'s private `charBound_one_of_circleCos` on the plane, in
  47 lines (`PadicPlane.charSum_unitCircle_ge_of_circleCos`, private; FS131-IQP3).
- A ruled drop of a non-dependent binder is shown from the kernel's side in two readings at once: put back with `mkArrow`
  inside `forallBoundedTelescope`, the stored type has the before-dump's `Expr.hash` (which reads no binder name) and its raw print
  character for character (which shows every binder's kind; a non-dependent binder prints as an arrow, with no name), and two
  controls — the domain `True`, and a near miss — differ in both (`data/fs131/iqp3/lean/ReAdd.lean`, after FS131-LCH1's;
  FS131-IQP3).

*§ The kernel's cost model, appended (the planner's, § 5.6, with the build's figure):*

- FS-66's fibre-share certificate at `p = 7` (8,598 ops, 495 slots, 14 PSD blocks; 707 KB of literals) checks as three
  `decide +kernel` theorems in one file in 48.8 s at 2.89 GB measured alone (shape 7.1 s, the identity 29.4 s, positive
  definiteness 7.5 s), and 33 s for the module in the build (`Arith/FibreCert7Check`); its certificate at `p = 23` is 1,444,136 ops over
  35,511 pairs, 168 times the 7's (FS131-KPA1, FS131-IQP1, FS131-IQP3).

### D11 — `ARCHITECTURE.md` § 5 (Trust), the declared import's consumer cell (outside this job's touches, so drafted)

In § 5's row for `StandingFive.kloosterman_bound`, its consumer cell's last words "(fifty-eight imported records in all)"
*become*:

> ; and, since FS131-IQP3, the p-adic plane's six: in `PadicPlane/Tower` `charSum_unitCircle_ge_weil`, `towerRatio_weil`; in
> `PadicPlane/Values` `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`,
> `not_exists_bound_borelChromaticNumber_padicPlane`, `borelChromaticNumber_padicPlane_three` (sixty-four imported records in all)

### D12 — `README.md` § Results

*A new subsection after "### Planes over number fields"'s table and before the paragraph "`LEDGER.md` holds 167 rows.":*

> ### Local fields
>
> | statement, in words | Lean name | rests on | whose | ledger |
> |---|---|---|---|---|
> | For every prime `p ≡ 3 (mod 4)`, every proper colouring of the `p`-adic plane `ℚ_p²` (two points adjacent when `(x₁ − y₁)² + (x₂ − y₂)² = 1`) whose colour classes are Borel sets uses at least `1 + (p + 1)/(2√p)` colours. So no constant bounds the Borel chromatic number of these planes as `p` varies. | `PadicPlane.one_add_div_le_of_borelColoring`, `PadicPlane.not_exists_bound_borelChromaticNumber_padicPlane` | std3 + **W** | the question is Bardestani and Mallahi-Karai's (`[BardestaniMallahiKarai2017]` Question 1), who prove `O(p²)` from above. The lower bound and the answer: prior art not found in print. The route is Hoffman's ratio bound on every finite level of the residue tower; it does not use their Theorem 2.5. The kernel proof is this project's | 75 |
> | The Borel chromatic number of `ℚ_p²` is 3, 4, 5 and 5 at `p = 3, 7, 11, 19`, and between 5 and 8 at `p = 23`. | `PadicPlane.borelChromaticNumber_padicPlane_three` (and `…_seven`, `…_eleven`, `…_nineteen`), `PadicPlane.five_le_borelChromaticNumber_padicPlane_twentyThree`, `PadicPlane.borelChromaticNumber_padicPlane_twentyThree_le_eight` | std3 (+ **W** at `p = 3`) | the upper halves are `[Madore2015]`'s construction with the finite planes' values (`[Moorhouse2010]` Table 6.1). The lower halves: prior art not found in print, from FS-66's fibre-share certificates (at 19 the Searcher's reduced one) and, at 23, the circle's exact cosine sums | 75 |

*and the section's opening sentence* "…and for the rows changed since, on 2026-10-16 at the commit each landing gated
(`113ca8ece`, the main clause through five as one theorem; `7c72b9bf7`, the collapse)." *gains* "; `7180f4b40`, the p-adic
plane".

### D13 — `ROADMAP.md`, and the Proof Atlas

`ROADMAP.md`'s appendix is generated from `LEDGER.md` (`data/fs131/pr1/nonkernel_rows.py`, `roadmap_appendix.py`): once D6 is
filed, row 75 stays listed (its `[hand]`, `[cert]` and `[tools]` clauses stand) with "part in the kernel: yes", as now; rerun the
generator. The Proof Atlas holds no node that cites row 75 or the `p`-adic plane (`data/viz/proof-atlas/facts.json`, 103 nodes,
searched by text): **no grade change**.
