# G2 — G30's tally, taken now and made self-maintaining; draft *Do* lines for G21, G30, G46

*Job G2 of the 2026-09-26 documentation consolidation (brief `data/consolidation-2026-09-26/briefs/G2-grokking-maintenance.md`
with `STANDING-RULES.md`). Opus 5.5, de Bruijn. HEAD at launch: `b559e820`. No subagents; no search of any kind.*

## Stage 1 — SAVED (the tally's last date, the sources, the counting rule)

### 1.1 When the tally was last taken

- **2026-08-13** (`513981ef`): G30 minted from "sorting the whole record by how each claim was reached" — "Roughly 7-for-7 against
  0-for-10" (text as at `c5e55f12^`, now in `plans/GROKKING-INSTANCES.md` §G30).
- **2026-09-05** (`5d895b85`, "G30's eighth instance and the write-it-up-first rule"): the field wall, "settled by derivation — the
  derivation-first column wins again, now 8-for-8 against the measurement-first column's 0-for-10". This is the tally's last date.
- 2026-09-10 (`c5e55f12`) cut the evidence; 2026-09-26 (F1, `8d432d80`) restored it with the clause "the tally is falsifiable and should
  be re-sorted at every tenth milestone". No re-sort ran in between (F1's report, FOUND: owed).

**Period of this tally:** claims whose fate was decided from **2026-09-05** (M54 and M55 opened that day; ledger row 48 onward) through
**2026-09-26** (`b559e820`, which holds ledger rows to 127 — the ×2×3 crunch included).

### 1.2 Sources read (and what was not)

| source | how read |
|---|---|
| `LEDGER.md` rows 48–127 | every row's headline and grade tags (awk over the table) |
| `LEDGER.md` § B | every line, counted by milestone and by grade (744 lines from M54 on; parse in §2.1) |
| `LEDGER.md`, whole file | `rg` for `false clause`, `was/is/were false`, `false as stated`, `wrong`, `withdrawn`, `retracted`, `demoted`, `corrected`, `LOST`, `lost`, `refuted`, `falsified` — each hit read in its sentence |
| `CLAUDE.md` § Grokkings | every *Demotion record*, "as minted", "this entry first", "withdrawn", "lost", "What lost" — each read in place |
| the close inventories (`plans/*close-inventory*.md`, FS-73 → ×2×3) and the two crunch indexes | `grep` for scored predictions, "lost", "refuted", "killed", "false" — read in passing, used only to place a claim already found above |
| each milestone plan's §R-close | **not read in full** (budget); a claim a plan scores but neither `CLAUDE.md` nor `LEDGER.md` records is outside this count |

G21 applies to this count: it measures the enumeration above, which is the corpus of record (`CLAUDE.md`, `LEDGER.md`), as G30's
first sort was ("the whole record"). The registered-prediction scorecards in the plans are a larger population, mostly of a genre G30's
sort never held (probability priors on whether a derivation lands); they are listed as genre C below and not counted into the ratio.

### 1.3 The counting rule (fixed before counting)

1. **Unit.** A *claim*: a general statement that goes beyond the finite data it was reached from — a theorem, a law, a reading, a
   registered prediction about the objects, a conjecture. **Not units:** a method rule; a claim about the literature ("not in print");
   an owner's slip in wording; an error in a proof's prose that leaves its statement true.
2. **Provenance — how the claim was first asserted as a conclusion** (not where the idea came from: Kooshi's catch-22 says most
   derivations began as a pattern in a measurement, and a pattern later derived counts as D):
   - **D** — asserted on a derivation (a proof, or a consequence drawn from held theorems), one mind or more;
   - **M** — asserted on data: a pattern in measured or computed data generalised beyond it (a count, a sweep's zero, a timing, a
     population extrapolated, a solver's null read as a fact about the object);
   - **X** — an exact computation on a finite object (a certificate, an exact census, a finite `decide`): the measurement itself, not an
     interpretation of it; tallied beside the dichotomy, not in it;
   - **C** — a conjecture, hunch or probability prior asserted on neither (by analogy, by where a derivation stalled, by intuition);
     listed, not counted into the ratio.
3. **Fate.** **Survived** — held today at its grade after something that could have killed it (a kernel check, a second or blind
   derivation, an exact check, a registered test). **Died** — refuted, withdrawn, demoted or corrected as false in the period, whatever its
   date of assertion. **Open** — neither; not tallied.
4. **Who killed it** is recorded for every death: a derivation, an exact counterexample, a registered replication or test, a review.
5. **Survivors are counted two ways**, because a ledger row bundles many claims: (a) ledger rows 48–127 by route (the brief's "results
   that moved a question"); (b) `LEDGER.md` § B lines from M54 on by grade (the comparable unit to a single death).
6. Where a death's provenance is not recorded in what I read, it is listed as **provenance not read** and kept out of the ratio.

## Stage 2 — SAVED (the count)

### 2.1 Survivors, two ways

**(a) Ledger rows 48–127 by route** (the results that moved a question; each row's headline and grade tags):

| route | rows | count |
|---|---|---|
| D — derived (kernel or hand), then checked | 48–63, 66, 67, 72, 75, 76, 79, 80, 82, 85–102, 108–126 | 61 |
| D, kernel port of a derivation held already | 103, 104, 105, 106, 107, 127 | 6 |
| X — exact computation on a finite object (certificate, exact census, found witness) | 64, 65, 68, 69, 70, 71, 73, 74, 78, 81, 83, 84 | 12 |
| M — a measured reading as the row's result | — | 0 |
| not a mathematical claim (the theorem audit) | 77 | 1 |

No ledger row's result is a measured reading: readings sit in the grokkings, and the ledger holds what a derivation or a certificate
bought. Two rows were *registered predictions met*: row 73 (four at ℚ(√11), ℚ(√23), the conjecture's cheapest predictions, by
certificate) and row 121 (five at ℚ(√47), by derivation).

**(b) `LEDGER.md` § B lines from M54 on, by grade column** (awk over the table; 784 lines in all, 40 of them M18–M53):

| grade class | lines |
|---|---|
| hand / derived (D) | 596 |
| kernel (D) | 9 |
| tools / exact / cert (X) | 94 |
| unparsed (an escaped `\|` inside the statement shifts the columns) | 45 |
| **total from M54** | **744** |

### 2.2 Deaths, 2026-09-05 → 2026-09-26

**D — asserted on a derivation, then found false (15).**

| # | claim (the source's words where short) | killed by | address |
|---|---|---|---|
| D1 | G35: the broken wall "says exactly" that `(−1,−1)_F` splits above 2, and "restates the wall as the ramification of a single algebra" | counterexample fields ℚ(√2), ℚ(√3), FS-71's gate, 09-22 | `CLAUDE.md` G35 demotion record |
| D2 | FS38-L1's tightness half: "tightness propagates up a constant-fibre tower" (row 67's clause, G54's sentence) | FS-86's B2 (a wrong-direction step) and row 93's exact counterexample (`Λ₅₁₀`: tight at 14, slack at 24), 09-25 | G54 second demotion record; row 93 |
| D3 | G56: "so over a field it seals the residue mechanism forces no pair" | outside review, 09-16 | G56 demotion record |
| D4 | G57: "a field contains √3 exactly when its usable planes have triangles" | counterexamples: ℚ at 11; every plane of characteristic 3 | G57 demotion record |
| D5 | FS-58's plan: periodic affinity from "finite quotients of the 3-integral group are 3-groups" | structure: the unit vectors' lattice maps onto every stable residue plane | G61 demotion records |
| D6 | G64 / FS62-T1: S ⟺ W, "Hadwiger–Nelson reduced from three values to two" | review, 09-19: both lines of the proof gave only S ⟹ W | G64 demotion record; § B FS62-T1 |
| D7 | M63H2-T2's converse (`\|p\|² = n` free iff `n = k²·m`, `m` realised) | `n = 5`, FS-71 batch 4c | G52 |
| D8 | M37's general-lattice bound (asserted before the period): "a crude Hermite-plus-covering chain gives `k ≥ 6` for every planar lattice" | FS-71: it "proves only `λ₁(Λ′) > 2λ₁(Λ)`"; demoted to conjecture M37-C1 | row 77; G21 |
| D9 | `plans/FIELD-WALL-THEOREM.md` Prop. 6.4, the multiquadratic two-colour criterion | FS-36: corrected into a full iff (FS36-T1) | G38; § B FS36-T1 |
| D10 | row 98's field clause (FS89-CL2, C2c) with one embedding's `λ_e` | FS-91's second reading: false at ℚ(√3), `k = 4` | row 98; FS-91 close inventory item 61 |
| D11 | FS-86's Theorem C clause "more generally a number field with no real place" | blind verifier D: an explicit quartic (FS86-VD-7) | row 94; § B FS86-VD-7 |
| D12 | FS86-Cx-C11's single-annihilator "iff" | retracted by its author | § B FS86-Cx-C11 |
| D13 | Lemma R's scope (FS-86) | scope corrected (CL2) | § B Lemma R line |
| D14 | FS-86 plan §0.4's side claim (ℚ(√11) by MIS-normality) | "the plan's §0.4 side claim was false" (row 66's gap transport instead) | row 88's note |
| D15 | M3: "an independent set of density above the ratio is a cylinder" (`[Zhang2012]` Thm 1.8 applied past its scope) | two constructions, every `B` | row 110; G50's M3 instance |

**M — asserted on data, then found false (17).**

| # | claim | killed by | address |
|---|---|---|---|
| M1 | G54 as minted: the sign classifies a plane's compulsions, slack read as free (from gapped slack planes at 7, 11, 19) | row 87's exact computation: `Λ/16Λ` slack, every four-colouring gap-free, forces (FS-85, 09-24) | G54 demotion record |
| M2 | G61: "every field with a usable plane at 7 has χ = 4" | ℚ(√2), ℚ(√7) | G61 demotion records |
| M3 | G61: "forcing at small size tracks short odd cycles in a COARSE 3-non-integral lattice" | FS-61's census: rich, not coarse | G61 |
| M4 | G61: "T4 … is unproved: no proof and no route to one — no witness transfers between fields" (read off failed searches) | derivation, row 82 (FS-81, 09-24) | G61 |
| M5 | FS-61's `d mod 8` reading | lost twice on the census (11 and 59) | row 74 "Readings scored" |
| M6 | FS-61's local-bound reading | lost on the census | row 74 |
| M7 | FS-61's character-mean reading | lost on the census | row 74 |
| M8 | G65: "every ball at degree ≥ 14 decides" | 2 of 17 ran to the wall — "a population extrapolated past its own edge" | G65 "What lost" |
| M9 | G65: the degree-18 ball's registered prediction (under 120 s; round 0 under 5,000) | its own run: "lost on both halves" | G65 |
| M10 | G65: certification cost predicted by ball points, plain solve time or the first core round (three statistics, one day; counted once) | the next five balls | G65 |
| M11 | FS-70: the owner's prediction that the fan gap is the rigidity classifier | L3, gap-free at every period and loose (`[2Λ : V] = 81`) | G69 |
| M12 | FS-66: the owner's ruling that 23 was out of reach because a relaxation "must beat the last instrument's reading" | the certified reading at 19 | G66 |
| M13 | FS-53: the bias-corrected growth law | "96–97 predicted at 23 against 87 found" | row 69 |
| M14 | FS-73: "`L3e1c94c6` has no periodic three-colouring" (the search stopped at `N = 20`) | least period 23 | G21 |
| M15 | FS-79: `L21cc6506` a candidate rigid lattice (a one-period census) | full-dimensional `Θ₄` cells, `P = F = 0` | G21; row 81 |
| M16 | G56's earlier reading: χ is "+1 over the spectral floor" | fails at the Hoffman-tight `q = 3` | G56 |
| M17 | G74's reading: the rational layer's rotation set is always a disc plus finitely many torsion points (generalised from FS73-T40's exact cells) | fired at one prime (rows 97, 102); holds at two or more (rows 95, 98) | G74 |

**X — an exact computation found wrong (1):** FS85-A1 — row 78's and FS73-T6's "`η^{±3} ∉ Λ`" is false (tools exact). § B FS85-A1.

**Provenance not read (3; kept out of the ratio):** P-D3 (row 67), refuted by derivation (FS73-T3); FS-53's P3, "falsified at 27 by one
integer" (row 69); M3's A-Kq plain-quotient rigidity clause, false at `D = {1}, {1,2}` (row 108).

**C — conjectures, hunches and priors that died, recorded in the corpus (11; listed, not in the ratio):** G71's reading "at four
colours the arithmetic must enter" (met in the abstract class, row 86); G76's reading "for all colourings the obstruction is the real
place" (row 112; demoted in MR's form, row 120); Kronecker selection as stated (registered at 0.4; row 116); J50's hunch "MR is ×2×3-hard"
(MR proved, row 120); PE-1 as first posed; CE-1's hypothesis; EF-G (a) off the totally real fields (all three row 120); KE (row 108);
plain density of periodic four-colourings in rank 1 (FS79-T3); the extension form at K along a fixed dyadic embedding (FS86-W-A1K); the
weighted form of "the tower never rises" (Lemma W, row 75). The close records score many more priors, won and lost; not counted here.

### 2.3 Measurement-first readings that survived a test (3)

| # | reading | the test it survived | address |
|---|---|---|---|
| S1 | the local–global conjecture (G48; minted at M61, 2026-09-07, on "attained at all six fields where χ is known") | every exposed prediction scored since: four at ℚ(√11), ℚ(√23) (row 73), `L ≤ 4` (row 99), five at ℚ(√47) (row 121), the main clause through five (row 123, given MR) — each bought by a certificate or a derivation | G48; rows 73, 99, 121, 123 |
| S2 | G59: "c is bounded by ≈ 0.93 over odd q" | its registered killing test at 19 (a set of 78), closed from the refusing side: `α(Γ₁₉) ≤ 77` (FS-66's certificate); still a reading | G59 |
| S3 | G65: the hardness peak at average degree 4–6 | the re-aim at degree 14 refused five new fields (FS-61) | G65 |

### 2.4 The count

| provenance | survived | died | died, per claim |
|---|---|---|---|
| D — derived from structure first | ≈ 605 § B theorems (596 hand/derived + 9 kernel), and 67 ledger rows | 15 | about 1 in 40 |
| M — measured first, then interpreted | 3, each bought afterwards by a registered test or a derivation | 17 | about 6 in 7 |
| X — exact computation | ≈ 94 § B lines, 12 ledger rows | 1 | about 1 in 100 |
| C — conjecture, hunch, prior | not tallied | ≥ 11 in the corpus | — |

The earlier sorts, for comparison: 7 of 7 against 0 of 10 (2026-08-13), 8 of 8 against 0 of 10 (2026-09-05).

**Who killed what.** Every one of the 33 deaths above (D, M, X) was killed by a derivation, an exact computation or counterexample, a
registered replication or test, or a review — none by a reading of a measurement alone. The D deaths were each one derivation's step:
six were caught inside their own milestone by a verifier, a second reading or the author (D10–D15), and nine had entered the record and were
killed later by a second derivation, a review, the FS-71 audit or a counterexample from structure (D1–D9).

**What the counts support.** The dichotomy survives the re-sort in its lopsided form, not in its "every one" form: a derivation-first
claim died about once in forty, and each death was one derivation's step caught by another derivation, a review or an exact
counterexample; a measurement-first reading died about six times in seven, and the few that survived had been bought afterwards by a
registered test or a derivation — which is G30's own rule ("a conclusion is bought by a derivation or a pre-registered replication").
Caveat (G21): the population is the corpus of record; the plans' own scorecards were read only where the corpus pointed to them.

## Stage 3 — SAVED (G30's sentence rewritten; the table to `plans/GROKKING-INSTANCES.md` §G30; gates)

**Correction to stage 2, made here:** stage 2 says the three measurement-first survivors were each bought "by a registered test or a
derivation". S3 (G65's re-aim at degree 14) was a test that could have failed; I did not read whether it was registered. The wording
carried forward is "a test it could have failed, or a derivation".

**`CLAUDE.md`, G30 only — two edits.**

1. The tally sentence. Old: "Sorted by provenance, the record is close to a clean dichotomy: **derived from structure first, then
   measured — survived, every one**; **measured first, then interpreted — died, every one** (the two lists: `plans/GROKKING-INSTANCES.md`
   §G30) — now 8-for-8 against the measurement-first column's 0-for-10." New: "Sorted by provenance — three times, the last over
   2026-09-05 to 2026-09-26 (the lists, the counting rule and the counts: `plans/GROKKING-INSTANCES.md` §G30) — the record is lopsided in
   one direction: **derived from structure first — survived, all but a few**, and each that died was one derivation's step, caught by
   another derivation, a review or an exact counterexample; **measured first, then interpreted — died, all but a few**, and each that
   survived had been bought afterwards by a test it could have failed or by a derivation." Dated, so it stays true without upkeep; no count
   in `CLAUDE.md` (one home per fact: the counts live in GI §G30).
2. The falsifier's upkeep clause. Old: "— but the tally is falsifiable and should be re-sorted at every tenth milestone." New: "— but the
   tally is falsifiable: by a measurement-first reading that survives with neither a registered test nor a derivation behind it, or by
   derivation-first claims dying at the measurement-first rate." Everything before the dash kept word for word ("*Falsifier: none
   needed; like G21 this is a methodological invariant and it fails only by being ignored"); the reasoning, the failure modes and the
   ladder untouched.

**Judgment call, flagged for the owner:** the brief asks both "keep G30's … killing test word for word" and "remove the 're-sort every
tenth milestone' obligation", which sit in one sentence. I kept the killing test's words and replaced only the obligation, with a
falsifier that fires on an event, not a schedule.

**`plans/GROKKING-INSTANCES.md` §G30:** a new subsection "The tally, re-sorted 2026-09-26 (job G2)" at the end of §G30 — Kooshi's
words, the earlier sorts, period, population, counting rule, the count table, the D and M deaths, the M survivors, the X death, what the
counts support. Four verbatim quotes of dead claims were first copied there and raised `--dupes` from 10 to 14 (each already quoted in
its `CLAUDE.md` demotion record); they were replaced by pointers to those records, and two phrasings of mine that repeated `CLAUDE.md`'s
new sentence were reworded.

**Gates (exit statuses read directly):** `claude_md_fact_audit.py --base b559e820` PASS (0 failures; "8-for-8" and "0-for-10" live in
GI §G30's pre-cut text); `--dupes` 10 (baseline 10); `fs71_ledger_b_check.py --strict` PASS; `bib_audit.py` exit 0; `check_architecture.py`
PASS; `CLAUDE.md` 291,894 bytes.

## Stage 4 — SAVED (the three *Do* drafts, not applied)

`data/consolidation-2026-09-26/G2-do-lines.md`: one draft per entry (G21, G30, G46), each opening with its trigger, built from quoted body
phrases, with a one-line reason, one alternative wording and where it would go. Checked against `CLAUDE.md` by appending the three drafts
to a scratch copy and running `--dupes --new`: one added repeated run (G46's killing test = its existing falsifier, which the draft
proposes to replace); four clauses that repeated ten body words were reworded before that check. Nothing in `CLAUDE.md` changed at this
stage — Kooshi approves first.

**Would have searched here:** nothing; no search was wanted.
