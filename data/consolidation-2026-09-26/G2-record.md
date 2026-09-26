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
