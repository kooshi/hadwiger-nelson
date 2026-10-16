# FS131-IQP3 — the p-adic plane to the gate: the ruled drops, five colours at 23, lint, the gate, the read-aloud and the drafts

*de Bruijn, the kernel lane's implementer. Brief `data/fs131/briefs/FS131-IQP3-padic.md` (on `main`; a copy is
`data/fs131/iqp3/brief-copy.md`). Worktree `.claude/worktrees/il5`, branch `fs131-kpa1`, from `f8ebf37f5`. The successor of
FS131-IQP2 (record `plans/FS131-IQP2-padic.md`, stopped at stage 1 at a pause Kooshi called) and FS131-IQP1 (record
`plans/FS131-IQP1-padic.md`); the plan is `plans/FS131-KPA1-padic-plan.md`. No fence. Started 2026-10-16.*

## Theorems this phase proved

To be filled at the gate, with each theorem's axioms as `#print axioms` gives them.

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
