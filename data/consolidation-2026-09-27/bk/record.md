# BK — the bookkeeping of the consolidation and library run, 2026-09-27 (record)

*de Bruijn (Opus 5.5), job BK. Brief: `data/consolidation-2026-09-27/briefs/BK-bookkeeping.md`, with
`data/consolidation-2026-09-27/briefs/STANDING-RULES.md`. HEAD at launch: a5fe409d (the fact audit's `--base`). Rule 0 first: `CLAUDE.md` § The aim
and § Counter-priors read before anything else. Read from disk: `plans/CONSOLIDATION-2026-09-27.md`; `CLAUDE.md`'s header, § The aim,
§ Counter-priors, § Where the problem stands, § Paths forward; `WORKFLOW.md` steps 2 and 9; `plans/RERANK-2026-09-27.md` §§ 3–4; `LEDGER.md` rows
131–134.*

## Theorems this phase proved

None. This job files and rewrites; it derives nothing.

## Stage 1 — SAVED (CE1–CE7 filed)

**What was owed.** FS-110's close inventory item 115: *"Owed: CE1–CE7 derivation entries (no § B lines yet)"*. Source:
`plans/FS110-CE-verification.md` § "Theorems this phase proved" and the sections each cites (§E1–§E6, Stage 3's verdict table); grades as item 113
set them (D4 one reading, CE; D5 items 1–4, 6 true after CE's local repair, one mind; the `d = 2` closure by two routes, CD's Theorem D2 and CE's
Antipodal Lemma).

**Filed** in `plans/FS110-derivation.md` § 1, after FS110-CUSP-BASE, in that file's entry form (`**<id> — <title>. [<grade>]**` with the five
fields), and one `LEDGER.md` § B line each, milestone cell "row 134", placed after FS110-CUSP-BASE's line:

| id | the theorem | grade | kernel |
|---|---|---|---|
| FS110-CE1 | CB's D4 bicycle, overshoot included, holds at cusp and double-cusp vertices | hand and tools; one mind on cusps (CE); endpoint cases two minds (CB, CE) | with FS110-CLOSURE |
| FS110-CE2 | CB's "WLOG n = −1" completed: every band offset `k ≠ 0, −1` dies | hand and tools; one mind | with FS110-CLOSURE |
| FS110-CE3 | CB's D5 item 2 parenthetical FALSE at (β) and at spike returns, TRUE where the circle changes colour | hand and tools; two minds at (β) (CD, CE), one at spikes | declined (a counterexample to CB's text; its positive half inside CE6) |
| FS110-CE4 | CB's D5 item 4 a GAP at (E3) and (β), cusp instances included | hand and tools; two minds (CD, CE) | declined (superseded by CE6) |
| FS110-CE5 | the Antipodal Lemma, one-sided | hand and tools; one mind | with FS110-CLOSURE |
| FS110-CE6 | D5 repaired by R1–R4 and the Antipodal Lemma: no pair at distance 2 reaches Lemma 3 or Cor. 3 | hand; one mind by this route | with FS110-CLOSURE |
| FS110-CE7 | D5 item 1's "= 1 is (P′)" needs (ii) when the ends' third colours differ | hand; one mind | declined (carried inside CE6) |

Every header uses an ASCII id, has no parenthetical before the dash, and nests no brackets inside its grade.

**Stale text made current in the same file** (the file is BK's; each sentence described CE as running or the cusp steps as under check):
the header's source list now names `plans/FS110-CE-verification.md`; the one-paragraph result's grade ("**under check at D4 and D5 items 1–4, 6**
(FS110-CE)") now reads one reading at D4 and one mind after CE's repair at D5 items 1–4, 6; FS110-CLOSURE's proof verdict ("D4's bicycle and D5
items 1–4, 6 at cusp vertices under check") now cites CE1 and CE6; FS110-COR1-NOD2's proof verdict cites CE3–CE7 beside CD's route; FS110-CUSP-BASE's
proof verdict ("Not yet read at cusps: … (FS110-CE, running)") now cites CE1–CE7.

**Checks, each exit status read directly:** `python3 tools/fs110_ce_scope.py` exit 0, "ALL AS PREDICTED" (the addresses the entries cite);
`python3 tools/fs71_ledger_b_check.py --strict` exit 0, PASS, 947 rows (940 before), census FS110 = 49 (42 before);
`python3 tools/claude_md_fact_audit.py --dupes` exit 0, 10 repeated runs (10 before: the seven new § B lines add none).

## Stage 2 — SAVED (the checker's silent skips made loud)

**The defect** (FS-106 inventory item 83; FS-107 item 39). `tools/fs71_ledger_b_check.py` read an entry header with one regular expression and
warned (never failed) on a header that began like an entry and did not parse; three shapes did not even warn: a parenthetical before the dash and a
non-ASCII id (the near-miss pattern needs an ASCII id followed at once by the dash), and nested brackets (warned only). An entry lost that way left
the census, and nothing failed unless its § B row happened to exist.

**The change** (the tool is BK's; not on the frozen list):
- `header_problems(text)`: every *entry-shaped* header — a line-opening bold span holding " — " and ending in "]" — that the entry grammar rejects
  is reported with its shape: a parenthetical before the dash; a non-ASCII id; a space in the id; nested brackets in the grade (found by balancing
  the brackets back from the final "]"); a title wrapped onto a second line; or "unclassified". Each one **FAILS the run, in every mode**, naming the
  header's first line and the shape.
- A fourth shape the scan turned up, the one that bit FS110-YB4-WINDOW: a header the grammar *does* parse, but whose grade began inside the title
  (an unclosed `[a, b)` in the title, so the parsed grade holds ". [" ). It now fails too. An unclosed `[` inside a true grade (FS91-J07-10's
  `[t, t + β)`) is legitimate and reads clean.
- The ASCII near-miss detector (no `[grade]**` closing the header) now FAILS instead of warning.
- **Declared non-entries** — a header saying it was "NOT given a fresh id" (M53's Proposition 6.4, the one instance in the tree that is
  entry-shaped) — are listed on every run as a `note:` line and not counted; they are never skipped in silence.
- `--self-test` plants the four shapes beside a faithful header (each must fire, naming its header) and two headers that must not fire (the
  legitimate unclosed `[` in a grade; a declared non-entry). It exits 0 only if all fire and both stay quiet.

**The plants** (`data/consolidation-2026-09-27/bk/plant_headers.sh <scratch dir>`: a scratch copy of every derivation file and `LEDGER.md`, four
planted headers appended to the copy of `FS110-derivation.md`, the new checker and the checker as it stood at a5fe409d run on the same tree):

| plant | new checker, `--strict` | checker at a5fe409d |
|---|---|---|
| `**FS110-PLANTA — … [hand; over Parts [external]]**` | FAIL: nested brackets in the grade, header named | a `warn:` line only |
| `**FS110-PLANTÉ — … [hand; one mind: BK]**` | FAIL: a non-ASCII id, header named | silent |
| `**FS110-PLANTC (the planted one) — … [hand; one mind: BK]**` | FAIL: a parenthetical before the dash, header named | silent |
| `**FS110-PLANTD — … the window `R_y = [a, b)` in the title. [hand; one mind: BK]**` | FAIL: the title's `[` read as the grade's opening, header named | parsed with the wrong grade; failed only because the plant has no § B row |

New checker on the planted tree: exit 1, `RESULT: FAIL (5)` — the four header lines plus "entry FS110-PLANTD has no LEDGER.md § B row" (the
row check, correctly: PLANTD parses). Old checker: exit 1, `RESULT: FAIL (1)`, that row line alone.

**The real tree:** `python3 tools/fs71_ledger_b_check.py --strict` exit 0, PASS, 947 rows, census 947 theorems in 71 files, one `note:` (M53's
declared non-entry); the non-strict run exit 0; `--self-test` exit 0, every line True. The first draft of the parsed-grade rule ("any `[` in a
grade") fired on FS91-J07-10's legitimate interval and the first draft of the shape rule on M53's declared non-entry; both were refined before
this stage was saved (the real tree never changed).

## Stage 3 — SAVED (the stubs' six-framed bearings rewritten)

**Scope.** `plans/RERANK-2026-09-27.md` § 3 lists 28 locations in **27** stub files (16 headings, 12 bold-led paragraphs, FS-67 in both lists);
the brief's "26" counts one fewer — every listed location was done. Each bearing is rewritten in current-state words, agreeing with the stub's
row in `plans/FRONTIER-STUBS.md` (read from disk at 290f5678), adding only what the stub's own text supports; grades and "soft" warnings kept.
Headings renamed "Bearing on the answer" (section numbers kept: "## 4. Bearing on the answer", "## §3 — Bearing on the answer"); bold leads
renamed "**Bearing on the answer…**". Nothing else in those files was touched: "Provisional bearings", "Solver" and "Cost" paragraphs inside a
bearing section are unchanged. The edits are `data/consolidation-2026-09-27/bk/stage3_bearings.py` (line ranges with a guard on each first
line; it refuses to run if a file moved).

| rank | stub | location | the bearing now, in short |
|---|---|---|---|
| 10 | FS-67 `STUB-tight-product-colourings` | status paragraph (l. 51); § 4 | none: product locality is content only at a place that is not 6-thick, and link 1's fields have none (row 128, G81); derived for S and six at ℚ(√167) (`PL_∃(23, 43)`, row 125); soft as to truth |
| 16 | FS-102 `STUB-writeup-main-clause-five` | heading | none: the fallback write-up; it writes up MR, on which link 1 rests; waits on formalization (FS-101, FS-113) |
| 7 | FS-80 `STUB-window-frequency-certificate` | heading | derived as the shape of a six certificate (link 3); soft as to success; gives `χ_CP ≥ 6`, so `χ(ℝ²) ≥ 6` given MR — the lower half only |
| 17 | FS-69 `STUB-certificate-at-43` | heading | none: 43 bounds only fields that use it, and link 1's fields have no usable plane there; field-level value kept |
| 19 | FS-100 `STUB-measure-rigidity-three-fields` | § 11 (first paragraph) | none: MR at link 1's fields held; left items at fields the direction does not visit; kernel port FS-101, MR in Lean FS-113 |
| 23 | FS-78 `STUB-five-colour-rigidity-table` | heading | none beyond FS-49's; medium as FS-49's supply; the direction does not use it |
| 28 | FS-75 `STUB-three-colour-criterion-kernel` | heading | none: row 82 to the kernel; row 99 in the kernel discharges a named hypothesis of FS-101 — the main clause's, not the answer's |
| 31 | FS-76 `STUB-four-colour-inheritance` | heading | none: a finite-fabric programme the direction does not use; high on that programme |
| 33 | FS-87 `STUB-de-grey-chain-kernel` | heading | none; the formalization a write-up of Mixon's question needs |
| 35 | FS-68 `STUB-tower-never-rises` | heading | none: at link 1's fields neither `L(F)` nor its all-levels form enters; mechanism and row 129's `r_v` at an odd place |
| 40 | FS-72 `STUB-last-lattice` | heading | none: five over ℚ(√3,√5) met (row 123); a periodic-free four-colouring would be C3-aper's counterexample, not a falsifier |
| 41 | FS-77 `STUB-kr6` | heading | none; the smallest place for a four-colour C3-aper counterexample |
| 42 | FS-88 `STUB-literal-ring-mixon` | heading | none; closes a question posed in print |
| 53 | FS-19 `STUB-padic-distance-classification` | § 5 | none; low-medium as mechanism; the "It should NOT displace FS-6" paragraph removed (FS-6 is dead by theorem, row 66) |
| 54 | FS-37 `STUB-field-level-criteria` | heading | none; feeds FS-20 and closes Theorem A's own gap |
| 59 | FS-35 `STUB-expansion-measure` | § 3 | none: the loop it serves (M62, a five-chromatic graph below 509) moves no value |
| 11 | FS-59 `STUB-four-colours-167` | paragraph | only through the plane: contains `χ_CP ≥ 6 ∧ PL_∃(23, 43)` (row 125), never cheaper than FS-104; the conjecture's widest gap |
| 13 | FS-64 `STUB-adelic-window-colouring` | paragraph | none on `χ(ℝ²)`; derived as one way six occurs at a field if HN = 7; soft; the only ceiling instrument for six at a field |
| 18 | FS-57 `STUB-fractional-wall` | paragraph | none: a statement about the residue method; link 1's fields have no window member |
| 8 | FS-101 `STUB-main-clause-five-kernel` | paragraph | none on deciding; conditional on the formalization: its collapse slot is link 1 in the kernel over named hypotheses; MR in Lean is FS-113 |
| 34 | FS-92 `STUB-character-classification` | paragraph | none; field-level shape of a character falsifier |
| 37 | FS-60 `STUB-quadratic-witnesses-kernel` | paragraph | none; field values to the kernel (the row says 13 values, the stub's old line six: neither number is restated) |
| 43 | FS-93 `STUB-pyjama-gluing` | paragraph | none; attribution and effectivity |
| 44 | FS-94 `STUB-one-prime-minimal-sets` | paragraph | none; mechanism |
| 49 | FS-20 `STUB-theorem-B-writeup` | § 9's bearing line | none; ranked on the publication trigger |
| 55 | FS-27 `STUB-consolidation-remainder` | paragraph | none; §2 blocks the paper; "the hunt continues in M63, M62 and FS-6" replaced by the direction |
| 61 | FS-29 `STUB-vacuity-coverage` | paragraph | none; the statement-level gate; "M62 (FS-6) remains the ranked rank-1 milestone" removed (stale) |

**Stale pointers removed, each inside a bearing section:** FS-6 (dead by theorem, row 66) in FS-19, FS-27 and FS-29; "the push toward six"
recast in FS-102; "Kooshi's 2026-09-26 target (six)" left out of FS-59's (the row still carries it). **Two facts a bearing now cites that
postdate the ranking pass:** FS-113, MR in full in Lean (`plans/STUB-mr-in-lean.md`, minted 290f5678), in FS-100, FS-101 and FS-102; and
FS-112 beside FS-111 in FS-101's "seven" clause (the row's "seven by FS-110's *no* with FS-111" predates FS-110's close; FS-111's row now reads
"decisive jointly with row 134 … and FS-112's unit-arc half"). **For the owner:** FS-101's ranked row still says "no row of this table carries
MR in full" — true until FS-113's row lands.

**Check:** no "Bearing on χ" or "Bearing on `χ" remains in the 27 files (grep); no file lost its final newline.
