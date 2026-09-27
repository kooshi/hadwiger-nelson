# BK — the bookkeeping job of the 2026-09-27 consolidation run: report

*de Bruijn (Opus 5.5), 2026-09-27, 15:52–16:10 UTC by the clock. Brief: `data/consolidation-2026-09-27/briefs/BK-bookkeeping.md`. Record, with
every stage's detail: `data/consolidation-2026-09-27/bk/record.md`. Commits: db72a8c8 (stage 1), ef39dc98 (2), a96588c7 (3), 1fad9ce1 (4),
3f766ed9 (5), and this report's commit (6). All six stages done; nothing left over.*

**What the job was.** The project keeps two records of every theorem proved outside the Lean kernel: an entry in the milestone's derivation file
and a one-line index row in `LEDGER.md` § B, kept in step by a checker script. The last three milestones (FS-106, the regular half; FS-107,
stability; FS-110, the tangency seam) and the ranking pass left low-urgency bookkeeping behind. This job did it. It proved nothing new
("Theorems this phase proved": none).

## 1. Entries filed (stage 1)

The second-mind check of FS-110 at cusp vertices (FS110-CE: `plans/FS110-CE-verification.md`) had seven results with no derivation entries.
Filed as **FS110-CE1 to FS110-CE7** in `plans/FS110-derivation.md` § 1 (after FS110-CUSP-BASE), each with its five fields, and one `LEDGER.md`
§ B line each pointing at row 134. Grades follow the owner's ruling (FS-110 inventory item 113).

| id | in plain words | grade | kernel |
|---|---|---|---|
| CE1 | the "bicycle" step (S–V Lemma 3, as the blind checker CB proved it) holds at cusp vertices too | hand and tools; one mind on cusps | with FS110-CLOSURE |
| CE2 | CB's "without loss of generality" step, completed for every band offset | hand and tools; one mind | with FS110-CLOSURE |
| CE3 | CB's item 2 is false as written at two configurations, true where the circle changes colour | hand and tools; two minds at (β), one at spikes | declined (a counterexample to CB's text) |
| CE4 | CB's item 4 has a gap at the same configurations | hand and tools; two minds | declined (superseded by CE6) |
| CE5 | the Antipodal Lemma (no two such points of the circle at distance 2) | hand and tools; one mind | with FS110-CLOSURE |
| CE6 | CB's argument repaired (rules R1–R4 plus CE5): no pair at distance 2 ever reaches Lemma 3, cusps included | hand; one mind by this route | with FS110-CLOSURE |
| CE7 | CB's item 1 needs one extra step when the two ends' third colours differ | hand; one mind | declined (carried inside CE6) |

Four sentences in the same file still called these steps "under check" or "running"; they now cite CE1–CE7.

## 2. The checker's change and its plants (stage 2)

**The defect.** `tools/fs71_ledger_b_check.py` silently skipped an entry whose header had (a) nested brackets in its grade, (b) a non-ASCII id, or
(c) a parenthetical before the dash: the entry vanished from the count and nothing failed unless its index row happened to exist.
**The change.** Each such header now **fails the run in every mode, naming the header and the shape**; so does a fourth shape found on the way (an
unclosed interval bracket in a title that the parser read as the grade, which once hit FS110-YB4-WINDOW), and the old warning for a header with no
grade bracket now fails too. Two headers that must not fail are recognised: a legitimate unclosed bracket inside a grade (FS91-J07-10's
`[t, t + β)`), and a header that declares itself not an entry ("NOT given a fresh id", M53), which is listed as a `note:` on every run.
`--self-test` plants all four shapes and both non-failures.

**Plants** (`data/consolidation-2026-09-27/bk/plant_headers.sh`, on a scratch copy of every derivation file): the new checker exits 1 with one
FAIL line per planted header, each naming its own shape; the checker as it stood at launch, on the same tree, gave a warning for (a), nothing for
(b) and (c), and misparsed (d). The real tree passes (947 entries, 947 rows).

## 3. Stubs rewritten (stage 3)

The ranking pass listed 28 places in **27** stub files (the brief said 26) whose "bearing" text still measured the stub against the old target,
six colours. Each is rewritten in current-state words — what the stub contributes to deciding `χ(ℝ²)` or to formalizing it, related to the six
links of `CLAUDE.md` § The aim — agreeing with its row in `plans/FRONTIER-STUBS.md`, and headed "Bearing on the answer". Grades and "soft as to
truth" warnings kept. Nothing else in the files changed. The full table (rank, file, the bearing in short) is in the record's stage 3.
- **25 of 27 read "none on the answer"**, most with the reason (the direction works at fields where every place mixes, so field-level and
  residue-plane questions do not enter).
- **FS-80** (window-frequency certificate): derived as the shape a proof of six must take (link 3); soft as to success; the lower half only.
- **FS-59** (ℚ(√167)): bears only through the plane, and is never cheaper than FS-104's question.
- **FS-101** (the main clause in the kernel): none on deciding; its collapse slot is link 1 in Lean over named hypotheses.
- Stale pointers removed inside bearing sections: FS-6 (dead by theorem) in FS-19, FS-27, FS-29. New stub FS-113 (MR in full, in Lean) is cited
  in FS-100, FS-101 and FS-102.

## 4. Front files and byte counts (stage 4)

- `CLAUDE.md` § Where the problem stands, items 28–30: each "Bearing on χ ≥ 6: …" now "Bearing on the answer: …" (item 30: "link 1 — given MR,
  rung D is the value at ℚ(√635087) and of `χ_m⁰(ℝ²)`").
- `plans/FRONTIER-STUBS.md`: the open-milestones column "next, and bearing on the answer"; M63's and M62's cells (both "none"; M62's no longer
  calls itself a rehearsal for FS-6); the ranking rule now reads stubs against the direction first, and keeps the field sieve for field-level
  routes.
- **`CLAUDE.md`: 295,846 bytes before, 295,825 after (−21)**, against the 300,000 limit.

## 5. Inventory items, new status (stage 5)

Every "open" item in the three close inventories is now closed in its status cell; none is left open.

| inventory | items | new status |
|---|---|---|
| FS-106 | 78, 79, 81, 82, 83 | done (the close's products exist; the slip is recorded at §R-close 1.0; the bearings by the ranking pass and this job; the checker by stage 2) |
| FS-106 | 80 | done, with one follow-up: `CLOSED-QUESTIONS.md` still says S–V's proof is "repaired … except one edge case, `d = 2`", which FS-110 closed — draft D1 |
| FS-107 | 35, 36, 37, 38, 39 | done (16 entries = 16 index rows; the close report's "19" was a miscount — the file has always held 16; ranking since superseded; the six granted entries present; the checker by stage 2) |
| FS-110 | 109–113 | done (CE's results filed by stage 1; the owner's Form A applied by FS110-X) |

## 6. Drafts for the owner (files this job does not own)

| # | where | what | default if nothing is done |
|---|---|---|---|
| D1 | `CLOSED-QUESTIONS.md` §3, the `d(6) = 1` entry | replace "repaired at FS-106 except one edge case, `d = 2` (row 132)" with "repaired at FS-106, and its one edge case, `d = 2`, closed at FS-110 (CB, CD, both blind; row 132)" | the file understates row 132 |
| D2 | FS-101's ranked row and its `CLAUDE.md` mirror (rank 8) | "no row carries MR in full" becomes false once FS-113's row lands | stale once FS-113 is ranked |
| D3 | FS-101's ranked row | "seven by FS-110's *no* with FS-111" → "seven through row 134, FS-111 and FS-112" (FS-111's own row already says this) | a pre-close phrasing stays |
| D4 | FS-60's ranked row | "13 field values" — the stub lists five witnesses and six upper halves; worth a recount | a possibly wrong number stays |

## 7. Gates (stage 6; each exit status read directly)

| gate | result |
|---|---|
| fact audit `--base a5fe409d` | exit 0, PASS; nothing lost in any class. **ALLOW lines:** re-run with the allowance and external-home tables emptied — still 0 failures, so no ALLOW line bears on this diff; control: the same empty-table run from before FS-110's close gives 4 failures |
| fact audit `--dupes` | exit 0, 10 (unchanged; limit 10) |
| `fs71_ledger_b_check.py --strict` | exit 0, PASS (947 / 947); `--self-test` exit 0 |
| `bib_audit.py` | exit 0, PASS |
| `check_architecture.py` | exit 0, PASS |
| `rk_mirror_check.py` | exit 0, PASS |

## Decisions I settled (skip unless you disagree)

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| Malformed headers fail in every mode, not only `--strict` | fail only under `--strict`, as missing fields do | a malformed header loses an entry from the count, which is an id-level error, and the non-strict mode's contract is "exit 1 on an id mismatch" | high |
| Recognise "NOT given a fresh id" as a declared non-entry, listed as a `note:` | edit M53's header (outside my files) or flag it as a failure | the corpus uses that phrase for deliberate non-entries; listing it keeps the skip visible | medium — if a real entry ever carries that phrase it would be skipped, though still listed |
| Rewrite only the bearing paragraph(s), leaving "Provisional bearings", "Cost" and "Solver" paragraphs inside those sections alone | rewrite the whole section | the brief says touch nothing else, and those paragraphs are not bearings | high |
| Remove FS-19's "It should NOT displace FS-6" paragraph | keep it | it is inside the bearing section, and FS-6 is dead by theorem (row 66) | high |
| Update four "under check" sentences in `plans/FS110-derivation.md` while filing CE1–CE7 | leave them for the owner | the file is on my list, and leaving them would contradict the entries just filed | high |
