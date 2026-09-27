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

## Stage 3 — SAVED (`BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`)

- `BIBLIOGRAPHY.md`, from §R-close 4.5: new § A row `[Townsend1979ms]` (after `[Townsend1981]`); copy and read columns rewritten for
  `[Townsend1981]` (held, read in full, no proof; its citation's "not fetched" removed), `[Townsend2005]` (unheld, request sent 2026-09-27),
  `[Coulson2004]` (read in full), `[Woodall1973]` (read §3), `[Thomassen1999]`, `[Pritikin1998]`, `[Parts2020c]` (held; statuses as drafted),
  `[SokolovVoronov2025]`, `[Voronov2023]` (re-reads), `[BendaPerles2000]` (held as a scan, not read). The role columns of `[Townsend1981]`,
  `[Thomassen1999]`, `[Pritikin1998]` and `[Parts2020c]` gained one clause each naming what of FS-106 rests on them (the row's column (i)).
  § B: six new file rows (every path checked with `ls`); Coulson, Woodall and S–V statuses updated; both "Held and not read" lists lose
  Coulson and Woodall and gain `[BendaPerles2000]`. § C: listing rows for `[AmbrosioCasellesMasnouMorel2001]`, `[CherkashinVoronov2024]`,
  `[AxenovichLiuSagdeev2025]`, `[LukesMalyZajicek1986]`, `[Wilczynski2002]` (titles from P §PA, marked "[title from a search listing]";
  authors by surname, as P gives them). `[DidinVoronov2026]` already had a row (§ C, FS103-G); unchanged. `[deGreyParts2023]`: no row change
  (C: "No new row"; the correction is to inventory item 51 and TQ §4.7).
- **Beyond the drafts, to pass the gate** (my decision): `tools/bib_audit.py` exited 1 on four citations FS-106's own records make and no
  draft logged — arXiv:2208.02230, 2302.09972, 2404.11454 (P §PA.1's citing works) and `[MartiniSwanepoelWeiss2001]` (FS106-V l. 94). Logged
  each as a § C listing row from the citing text alone (titles not recorded; the Minkowski survey "[title unverified]"). Alternative: leave the
  gate red and report — rejected, because the rows add no claim beyond what the records say. Confidence high.
- `CLOSED-QUESTIONS.md` §3, from 4.6: "`[SokolovVoronov2025]` answers no" → "… answers no — its printed proof repaired at FS-106 except one edge
  case, `d = 2` (row 132)."
- Gate: `tools/bib_audit.py` exit 0 ("every cited work resolves to a row or a recorded alias").

## Stage 3 — SAVED

## Stage 4 — SAVED (`plans/FRONTIER-STUBS.md`)

From §R-close 4.7: open-milestones paragraph ← D-C7's text (its bold lead dropped, the section heading already says it); ranked table: FS-106
leaves, FS-107 rank 1 (C's cells; its question cell is D-C8 row 1's question plus C's pointer to the stub, the in-cell `δ₀|U_R|` escaped),
FS-104 rank 2 (its lead "Re-ranked 2026-09-26 (RF1; 1 → 3) …" rewritten to current state, "FS-107's sub-question" kept), FS-109 rank 3 and
FS-108 rank 4 (question and bearing cells from D-C8 rows 3–4; cost "unpriced"; solver columns as C gives them), old ranks 4–62 → 5–63
(the tail "30–62" row inside CLAUDE.md is not in this file); a close note at the head of "Ranked stubs"; the closed list's first entry, verbatim.
**Left:** "The stub rows' provisional bearings for FS-107, FS-104, FS-62 and FS-67 gain G82" — those lines live in the stub files, not in this
file: `plans/STUB-regularity-wall.md` already has G82 (C wrote it); `plans/STUB-cp-plane-six.md`, `plans/STUB-six-is-not-a-value.md` and
`plans/STUB-tight-product-colourings.md` do not, and are outside my touch list — for the owner.

## Stage 4 — SAVED

## Stage 5 — SAVED (`plans/GROKKING-INSTANCES.md` instances; the protocol's run record)

- Seven instances from §R-close 4.8, each verbatim under its section with a heading naming FS106-C and its source address: §G50, §G21, § Make
  the gate fail ("exactly one thing may differ"), §G72 (sixteenth), §G79, § Delegation, §G51 (quote verbatim). The moves M1–M9 go with
  `CLAUDE.md` in stage 6, so the fact audit sees each move's two ends in one commit.
- `plans/PROTOCOL-competitor-and-advisor.md` §3: the eighth run (4.9), verbatim, after the seventh run and before "The next use".
- Gate: `tools/claude_md_fact_audit.py --base 6d3d5072` exits 1 with one failure, "dangling pointer: G82 is cited and no such entry exists":
  LEDGER row 131 (committed at stage 2) cites G82, which stage 6 mints (D-C9). **My slip:** stage 2 was committed after the § B check alone;
  the fact audit should have run then. Not caused by this stage's edits; cleared by stage 6.

## Stage 5 — SAVED
