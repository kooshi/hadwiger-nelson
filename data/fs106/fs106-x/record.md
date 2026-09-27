# FS106-X — the front-page pass for FS-106's close (record)

*de Bruijn (Opus 5.5), 2026-09-27. Brief `data/fs106/briefs/X106-front-page.md` with `data/fs106/briefs/STANDING-RULES.md`. HEAD at launch
`6d3d5072` (the `--base` for the fact audit). Drafts applied from `plans/FS106-regular-half.md` §R-close (stages 4a, 4b); owner rulings from
`plans/FS106-close-inventory.md` items 77 (FS-107's rename and link 5's equivalent form: D-C2 applied), 79 (row 131 accepted), 82 (rows 4–62's
six-framed bearings not this job's).*

## Theorems this phase proved

None: an editing pass.

## Stage 1 — SAVED (quotation check; plan of stages)

Quotation check (standing rule 5), each against its source on disk:
- *"Ignore the 300kB limit while you reframe the file."* — `CLAUDE.md` header: present verbatim. MATCH.
- *"From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will
  surprise yourself."* — `CLAUDE.md` § Counter-priors (line-wrapped): MATCH.
- *"A proven theorem about why its impossible is also valid. All novel knowledge is a success"* — `CLAUDE.md` Where the problem stands item
  23: MATCH.
- FS-107's new name "stability: can vanishing holes save a colour?" — inventory item 77 and `plans/STUB-regularity-wall.md`: MATCH.
- Standing rule 3's "The intent of the ban is …" is recorded by FS106-C (§R-close 4.8) as a phrase not in Kooshi's words; not used here.

Stages: 2 `LEDGER.md` (rows 131–132, row 40, § B); 3 `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`; 4 `plans/FRONTIER-STUBS.md`; 5
`plans/GROKKING-INSTANCES.md` (instances and M1–M9) and the protocol's run record; 6 `CLAUDE.md` (D-C1…D-C12, the moves, the header, the
paths-forward mirror, the budget); 7 report.

Would have searched here: nothing (an editing pass).

## Stage 1 — SAVED

## Stage 2 — SAVED (`LEDGER.md`)

- Rows 131 and 132 inserted after row 130, verbatim from §R-close 4.1; row 40's clause replaced in place by 4.1's text.
- § B: 46 lines appended after FS-105's block (4.2's table has 46 ids, FS106-V23 … FS106-PDEQ; "45" in C's prose is a miscount — the
  derivation file also holds 46 once its FS106-LOCAL header parsed).
- One formatting change, no words: the in-cell pipes of `|ΔInd| ≤ 1`, `|ΔInd| = 2` (twice) and `|P(x)| ≥ 5` escaped as `\|` so the table rows
  keep their columns (FS-105's `\|G\|` is the precedent).
- Gate: `tools/fs71_ledger_b_check.py --strict` first FAILED (FS106-LOCAL: no derivation entry) — the derivation header's grade nested
  "[external]" inside its bracket; outside my touch list, asked the owner; the owner fixed it (3234df20, "over Parts (external)"). Re-run:
  exit 0, RESULT: PASS, FS106=46.

## Stage 2 — SAVED
