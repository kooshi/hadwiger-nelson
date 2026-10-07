# FS124-Z1 — the record job of FS-124 (tight unit pairs): the record

*Job FS124-Z1 (brief `data/fs124/briefs/FS124-Z1-record.md`), 2026-10-07 (UTC). Identity: Ephodos. The milestone's theorem record
is `plans/FS124-derivation.md`; this file is the job's record — stages headed "Stage n — SAVED", each committed before the next.
Scripts: `data/fs124/z1/`. Gate of the theorem record: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all
FS124-derivation.md`, from `plans/`.*

## Theorems this phase proved

None. A record job derives nothing: every entry of `plans/FS124-derivation.md` is copied by script from the two derivers' records
(`plans/FS124-E1-derivation.md`, `plans/FS124-E2-derivation.md`), statement, verdict, grade and minds unchanged.

## Stage 1 — SAVED: the readback, and the table of the two records' entries

### 1.1 The readback

**Quotations.** 6 of 6 blockquotes of the brief match their sources (`data/fs124/z1/quote_check.py`: exit 0; with its fault —
one character changed in each — 0 of 6 match, exit 1).

**The brief's counts against the sources, read by me.** "Sixteen entries" (first round) and "fourteen" (second): met — 16 and 14
`derivation:` blocks. "Thirty statements are derived": **29 are derived and 1 is refuted** (C124-FORCED-AS-POSED); the reading
C124-READ-SAVES is a table, not an entry, and is not among the thirty. "Inventory items 1 to 26": the file has item 27 (this job's
launch), written after the brief. Neither is a mismatch of a quotation.

**The job, in my words.** One file in which each of the thirty entries stands once, under the name its deriver gave it, its
statement character for character; ordered so that the strongest form of each chain is the head and the weaker forms sit under it
as its corollaries; each with its class and whether its argument spends the number six. Then five dated corrections appended under
the texts they correct; bearing lines in the stubs; every registered prediction scored; the front page's drafts; the sweeps; the
gates. I raise no grade and no count of minds.

**What I read, and what I did not** (standing rule 10's sense, for this project's own files). *Read whole*: the brief; the
standing rules; every `derivation:` and `control:` block of both records, with the first round's arguments for Stages 3 and 4, the
second round's Stage 3 and its arguments for the closed edge and the pair's two points; the inventory's items 10–27; the asking
lane's last record §§ 1.2–2.3, 4.1–4.4 and its draft re-rank; the first kernel planner's record §§ 4.2–4.4 on its branch. *Read at
the entry only*: `plans/FS132-derivation.md`'s C132-COMP-SHARP and C132-CORES-SQUARE with the prose under each; `LEDGER.md` rows
157, 159, 160. *Not read*: the second round's arguments of Stages 4–5 beyond their headings (C124-TYPE's, C124-LONE's two steps,
the banded bowtie) — so nothing in this job is a second reading of C124-LONE's Step II, which stays owed to a second mind; the
inventory's items 1–9; the asking lane's first two records beyond the lines grepped for the predictions; the second kernel
planner's branch (fenced from nobody, but unfinished).

### 1.2 The thirty entries

*Columns: verdict; grade and minds as the source's `grade:` and `minds:` fields give them; what the `grade:` or `uses only:` line
names as its inputs; whether the argument spends the number six ("every" — it reads no number of labels; "six" — it uses that six
labels are all the labels, and its entry or a companion names the failure at seven; "k ≥ 4", "seven", "five" as the statement
says); and where a later entry or a later reader widens, narrows, restates or corrects it. E1 = `plans/FS124-E1-derivation.md`,
E2 = `plans/FS124-E2-derivation.md`. Every entry: one mind, kernel pending; the kernel lane's state is in § 1.3.*

| # | entry (record, stage) | verdict | grade | minds | inputs | count | later: widened / narrowed / restated / corrected |
|---|---|---|---|---|---|---|---|
| 1 | C124-RADIUS-GRAPH (E1, 3) | derived | hand | 1 | — | every | the kernel planner's generalizations, its own and not entered: measurability of the colouring idle; the almost-every clause pair by pair for a countable set anywhere (inventory item 14 (1)–(3)). One clause of the hand argument, "measurable (`c` is)", used by no later line (item 19) — correction owed, Stage 3 |
| 2 | C124-RADIUS-COUNTABLE (E1, 3) | derived | derived from: C124-RADIUS-GRAPH | 1 | C124-RADIUS-GRAPH | every | the planner: measurability idle (item 14 (1)) |
| 3 | C124-RADIUS-UP (E1, 3) | derived | derived from: C124-RADIUS-GRAPH | 1 | C124-RADIUS-GRAPH; de Bruijn–Erdős | every | the planner: measurability idle; discs at any centres; its contrapositive needs no import (item 14 (1), (5)) |
| 4 | C124-RADIUS-DOWN (E1, 3) | derived | hand | 1 | the declared outside theorem `Outside.OAI158.proper_to_borel_weak` | every | the planner: holds for every subset of the plane (item 14 (4)) |
| 5 | C124-RADIUS-FIVE (E1, 3) | derived | derived from: C124-RADIUS-UP | 1 | C124-RADIUS-UP; the declared outside theorem `Outside.OAI158.no_proper_five_coloring` | five | the planner: discs at any centres (item 14 (5)); the asking lane files it with the calibrations (its § 2.1) |
| 6 | C124-SHADOW-OPEN (E1, 4) | derived | hand | 1 | — | every | "the one lemma": every later entry of both rounds but the radius clause, C124-EVERY-DIRECTION and the objects rests on it |
| 7 | C124-OPEN (E1, 4) | derived | hand | 1 | — | every | — |
| 8 | C124-CENTRE (E1, 4) | derived | derived from: C124-SHADOW-OPEN | 1 | C124-SHADOW-OPEN | every | restated collar by collar, each half from one collar: C124-CENTRE-HALF (E2, 5), of which it is the conjunction (that entry's handoff line) |
| 9 | C124-STRADDLE (E1, 4) | derived | derived from: C124-SHADOW-OPEN | 1 | C124-SHADOW-OPEN | every | the wide form of C124-COMPLETION |
| 10 | C124-COMPLETION (E1, 4) | derived | derived from: C124-STRADDLE | 1 | C124-STRADDLE | every | a case of C124-STRADDLE (its own `uses only:` line) |
| 11 | C124-ANTIPODE (E1, 4) | derived | derived from: C124-SHADOW-OPEN | 1 | C124-SHADOW-OPEN | every | — |
| 12 | C124-KIND (E1, 5) | derived | hand | 1 | — | seven (a calibration) | — |
| 13 | C124-SIX-CONES (E1, 5) | derived | derived from: C124-CENTRE | 1 | C124-CENTRE | every | subsumed by C124-SIX |
| 14 | C124-SIX (E1, 5) | derived | derived from: C124-SIX-CONES | 1 | C124-SIX-CONES | k ≥ 4 — **does not spend six** (the asking lane's finding (a), inventory item 12) | no held object meets its hypothesis at any number of labels (its own *model* line; not changed by the second round) |
| 15 | C124-HALF (E1, 5) | derived | hand | 1 | C132-WIT-SIDE (FS-132; [hand], one mind, statement read by its deriver, argument not) | six | **corrected**: "no held object meets the hypothesis" — fragment S1 meets it with the one-point set `{x}` on the circle (E2 Stage 5; its report's drafted line) — correction owed, Stage 3 |
| 16 | C124-HALF-TWO (E1, 5) | derived | hand | 1 | C132-WIT-SIDE | six | its hypothesis read on held objects by the second round: met at 71, 20, 71 points of the three maps and 3 of the kept model's (E2 Stage 3's table; [tools]); the upper bound of C124-FOUR |
| 17 | C124-EVERY-DIRECTION (E2, 4) | derived | hand | 1 | — | every | the answer to the kernel planner's question (item 14 (7)); not stated in the first module (item 19) |
| 18 | C124-TYPE (E2, 4) | derived | hand | 1 | C124-SHADOW-OPEN | every | by its deriver, two of last night's entries in one statement: C132-WITNESS followed by C132-WIT-SIDE, on C124-SHADOW-OPEN (its *prior art* line) |
| 19 | C124-FORCED-PIECES (E2, 4) | derived | derived from: C124-TYPE | 1 | C124-TYPE | six | the form with content of last night's C132-COMP-SHARP (correction owed there, Stage 3); the asking lane: its argument reads "every label is a label of a piece at one of the two points", not two disjoint triples (inventory item 26) — a reading of the argument, not entered |
| 20 | C124-FORCED (E2, 4) | derived | derived from: C124-FORCED-PIECES | 1 | C124-FORCED-PIECES; a θ-curve lemma recalled, not read | six | the posed claim, narrowed to sector points |
| 21 | C124-FORCED-AS-POSED (E2, 4) | **refuted**: fragment BB with each bowtie's repeated label joined by a band | hand | 1 | fragment BB (FS110-FRAGS) | six | the posed wording, by the letter; what stands in its place is C124-FORCED-PIECES and C124-FORCED |
| 22 | C124-FORCED-SEVEN (E2, 4) | derived | hand | 1 | exact arithmetic | seven (a calibration) | — |
| 23 | C124-CENTRE-HALF (E2, 5) | derived | hand | 1 | the argument of C124-CENTRE, inherited | every | the stronger form of C124-CENTRE |
| 24 | C124-LONE (E2, 5) | derived | derived from: C124-FORCED-PIECES, C124-CENTRE-HALF | 1 | those two; C124-TYPE | six | **a second mind is owed on its Step II** before C124-BOTH, C124-FOUR or C124-EDGE-CLOSED is built on outside the milestone (its deriver, inventory item 21); the kernel planner of the second module is that mind, blind first (ruling 21 (b)) |
| 25 | C124-BOTH (E2, 5) | derived | derived from: C124-LONE | 1 | C124-LONE; for its second sentence C124-FORCED's argument | six | the measurable form of FS112-N3-COR3 (row 135), by another route (its *prior art* line) |
| 26 | C124-LONE-EXISTS (E2, 5) | derived | hand | 1 | fragment S1; the band of C124-FORCED-AS-POSED's argument | six (an object) | makes C124-LONE, and C124-HALF, statements over inhabited classes |
| 27 | C124-FOUR (E2, 5) | derived | derived from: C124-LONE | 1 | C124-LONE; C124-TYPE | six | — |
| 28 | C124-EDGE (E2, 6) | derived | hand | 1 | the strip's tiles | six (one held family) | subsumed by C124-EDGE-CLOSED |
| 29 | C124-EDGE-CLOSED (E2, 6) | derived | hand | 1 | C124-TYPE, six times; exact comparisons | six (one held family) | its prior-art line misses FS114-Y-STRIPK6, the held map statement about the same six tiles (the asking lane's S5) — correction owed, Stage 3. It uses C124-TYPE only — not C124-LONE (its `uses only:` line; § Argument: "it needs neither C124-BOTH nor any regularity above the line") |
| 30 | C124-SECOND (E2, 6) | derived | derived from: C124-BOTH, C124-FOUR | 1 | C124-BOTH, C124-FOUR | six | — |

**The reading** C124-READ-SAVES (E2 Stage 3) is [tools], one mind, floats from the objects' exact pieces, and proves nothing; it
says on which objects: FS-112's strip (tiles −4 to 6) and disk, FS-114's capped strip, fragments T2, BB, S1, MX, FS116-Y2-SIXFRAG
and the Searcher's kept model at six; R7 and the honeycomb at circumradius 2/5 at seven as controls.

**One observation of this table, mine, for the coordinator.** The deriver's caution names three entries that wait for the second
mind on C124-LONE's Step II: C124-BOTH, C124-FOUR and C124-EDGE-CLOSED. By their `grade:` and `uses only:` lines the first two
rest on C124-LONE, and so does C124-SECOND (derived from both); **C124-EDGE-CLOSED does not** — it uses C124-TYPE six times and
exact comparisons. I change no entry on this; it is said so that a later citation of the closed edge is not held for a step its
argument does not read, and so that C124-SECOND is not cited as if it were free of that step.

### 1.3 The kernel lane's state, said once

**The radius clause's module** (entries 1–5): complete on branch `fs124-wk1` (tip `80ee1983`) — 57 of 57 theorems, build exit 0;
the disc criterion `seven_le_chromaticNumber_plane_iff_exists_ball` and `colorable_iff_forall_ball` each on the standard three
axioms and the one declared outside theorem `Outside.OAI158.proper_to_borel_weak`; 52 of the 57 on the standard three alone
(inventory items 23, 24). **Kernel-checked on a branch, not through the gate, not held.** I did not build it or read its prints.
**The second module** (entries 6, 8, 9, 18, 19, 23, 24, 25, 27 — nine statements, `data/fs124/claims-K2.md`) is being planned
blind on branch `fs124-wk2` (item 25). The other sixteen entries have no kernel job.

**Stage 1 — SAVED** (2026-10-07).

## Stage 2 — SAVED: the derivation file

**Filed: `plans/FS124-derivation.md`** — 30 entries (29 derived, 1 refuted), 17 controls, 8 sections, written by
`data/fs124/z1/build_derivation.py` (`--check`: the file on disk is what the script writes).

**How it was made, and why that way.** Every `derivation:` and `control:` block is copied by the script, character for character,
from the record of the deriver who wrote it; the one change is that `argument: § <heading>` gains its record's file name, so the
address resolves from the new file. I typed no statement, no grade and no count of minds. The gate's own check of this:
`derive_gate.py quotes FS124-derivation.md FS124-E1-derivation.md FS124-E2-derivation.md` — "statements named in more than one
place: 30", PASS, 0 failures.

**The decisions that were mine.**
1. **No new merged statement is written.** "Its strongest merged form" is met by order: each chain's head is its strongest
   form and the weaker forms sit under it marked *corollary*, each under its deriver's name. A statement that fused two entries
   would be a derivation by a record job, graded by nobody, and nine of these names are fixed in the kernel lane's claim list
   for a planner working blind. Three places where two entries are one statement in two strengths, and which is the head:
   C124-CENTRE-HALF over C124-CENTRE (the second is the conjunction of the first's two halves — the second deriver's `handoff:`
   line; C124-CENTRE keeps its source's grade, derived from C124-SHADOW-OPEN); C124-STRADDLE over C124-COMPLETION;
   C124-EDGE-CLOSED over C124-EDGE.
2. **Order**: § 1 the class (the radius clause; every direction); § 2 the one lemma and what one piece forces; § 3 the pair;
   § 4 the strip's edge; § 5 the first round's two chains at a centre that the second round did not continue; § 6 the two
   calibrations; § 7 the reading; § 8 what the file does not hold.
3. **Class and count** stand in the prose under each entry, from the entry's statement first; the tags of § 1.2's table are
   the same. Two places where a tag and a statement had disagreed during the day, the statement followed: C124-SIX is `k ≥ 4`
   and does not spend six; C124-FORCED is for sector points, the posed wording being its own refuted entry.
4. **The kernel planner's generalizations** are recorded under § 1's entries as the planner's own and are not entered: the
   measurability of the colouring idle in three (C124-RADIUS-GRAPH, -COUNTABLE, -UP); every subset in one (C124-RADIUS-DOWN);
   discs at any centres; the contrapositive of (up) with no import. The two join theorems of its module are named under
   C124-RADIUS-DOWN as the kernel's, on a branch.
5. **Calibrations**: C124-KIND and C124-FORCED-SEVEN, each called one by its own `handoff:` line. C124-RADIUS-FIVE stays in
   § 1 as a corollary; that the asking lane files it with the calibrations is said under it.
6. **The reading** is § 7, in prose with its table quoted, not an entry: its deriver did not enter it and it proves nothing.

**Grades and minds lowered or raised**: none. **Sentences I am least sure are no larger than their entries** (for the
coordinator's eye): § 3's "C124-BOTH, C124-FOUR and C124-SECOND rest on this entry; C124-EDGE-CLOSED does not" under C124-LONE
(my reading of four `uses only:` lines; § 1.2 above) and § 5's "Its class is inhabited" under C124-HALF (the second deriver's
finding, with a one-point set — the sentence says so).

**Gate.** `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-derivation.md`, from `plans/`, run in the
background under a slot (several minutes): **GATE: PASS (0 failures, 2 warnings)** — entries 30, derived 29, refuted 1; controls
17, fired on their faults 17. The two warnings are the sources' own: "prior art owed" at C124-RADIUS-COUNTABLE and C124-OPEN.
Output: `data/fs124/z1/gate-FS124-derivation.txt`.

**Stage 2 — SAVED** (2026-10-07).

## Stage 3 — SAVED: the five dated corrections

*Each is one paragraph, inserted by `data/fs124/z1/append_corrections.py` after the blank line that ends the text it corrects;
it begins "\*Correction, dated 2026-10-07 (filed by FS-124's record job, FS124-Z1; source: …" and ends by saying that the
entry's statement, verdict, grade and count of minds are unchanged. `git diff` of the three files: 58 lines added, none removed.
The script refuses to run twice.*

| # | file, and the text it stands under | what it corrects | its source | words quoted |
|---|---|---|---|---|
| 1 | `plans/FS124-E1-derivation.md`, under the entry C124-RADIUS-GRAPH | in § Argument — a random rigid motion, the clause "measurable (`c` is)" is used by no later line | the first kernel planner's record § 4.1 on branch `fs124-wk1` (the row "the bad pairs `N`"); inventory item 19 | the planner's sentence |
| 2 | the same file, under the entry C124-HALF | "no held object meets the hypothesis" — in the entry's *not claimed* and *model* lines, in § Theorems this phase proved and in Stage 5: fragment S1 meets it, its set on the circle a single point | `data/fs124/reports/FS124-E2.md`, INVENTORY, "correction owed" | the second deriver's drafted line, whole |
| 3 | `plans/FS124-E2-derivation.md`, under the entry C124-EDGE-CLOSED | its *prior art* line misses FS114-Y-STRIPK6 (row 138; two minds, blind), a held map statement about the strip's six tiles | the asking lane's last record § 1.2 and § 1.3 (S5) | FS114-Y-STRIPK6's statement from `plans/FS114-derivation.md`, its first clause and its conclusion; the asking lane's S5 sentence |
| 4 | `plans/FS132-derivation.md`, under the prose that follows the entry C132-COMP-SHARP | as stated, the conclusion is met by a one-point set; the statement with content is on pieces | `plans/FS124-E2-derivation.md`: C124-FORCED-PIECES (*prior art*, statement), Stage 5's "Read against the card"; `LEDGER.md` row 157 | the deriver's two sentences; C124-FORCED-PIECES's statement, whole |
| 5 | the same file, under the prose that follows the entry C132-CORES-SQUARE | "the comparison, one short stage, that nobody has done" — it was made by the kernel planner's successor, as a checking reading, one mind; the verdict stays "gap" | `data/fs132/claims.md`, the dated line after FS132-K2's Stage 6; `plans/FS132-close-inventory.md` item 39, ruling (b) | the claim list's line |

**What I added of my own in them, so that it can be struck if it is too much.** In 3: "Neither statement is the other", with
the difference said in one sentence, and "Which six tiles each names was not compared tile by tile by the record job" — the
held entry names the tiles at a valley `V_m` and at the apex of `U_{m+1}`; C124-EDGE-CLOSED names three arches and the cut parts
of three top tiles; I did not match them. In 4: "A compact set `K_j` containing `x` may be `{x}` alone, and `x` lies on the unit
circle about `w`" — the one-line reason the deriver's sentence is true, read off the entry's own hypotheses; and that the
quoted sentence about fragment S1 was said of C124-HALF, "whose hypothesis is this entry's setting with exactly one set on that
circle".

**Gates, before and after** (each from `plans/`, in the background under a slot; outputs `data/fs124/z1/gate-*.before.txt`,
`gate-*.after.txt`):

| file | before | after |
|---|---|---|
| `FS124-E1-derivation.md` | PASS, 0 failures, 2 warnings | PASS, 0 failures, 2 warnings |
| `FS124-E2-derivation.md` | PASS, 0 failures, 0 warnings | PASS, 0 failures, 0 warnings |
| `FS132-derivation.md` | PASS, 0 failures, 9 warnings (32 controls, 32 firing) | PASS, 0 failures, 9 warnings |

`build_derivation.py --check` after the appends: identical — no copied block moved.

**Stage 3 — SAVED** (2026-10-07).

## Stage 4 — SAVED: the stubs

*Eight dated blocks, each headed "(FS124-Z1, the record job, 2026-10-07; every entry named is in `plans/FS124-derivation.md`,
[hand] or derived from [hand] entries, **one mind, kernel pending**)", inserted by `data/fs124/z1/append_stubs.py` at the end of
a stub's "Provisional bearings" section (in the milestone's own stub, after the asking lane's paragraph of the same day). 95
lines added, none removed; no question section and no banner touched.*

| stub | what the block says | the entries it is from |
|---|---|---|
| `plans/STUB-covering-pairs.md` (**FS-136**, the successor) | its provisional bearings from this milestone, each at its grade and class: the tool (C124-TYPE); the count as an entry is for three-piece points with disjoint triples, and its reach to members of four labels is the asking lane's reading, to be derived there; what is held at the pair, with the second mind owed under three of them; the method for a stop; the calibrations; the reading; the radius clause as the consumer of either answer; what is not held | C124-TYPE, -FORCED-PIECES, -FORCED, -LONE, -LONE-EXISTS, -BOTH, -FOUR, -SECOND, -EDGE-CLOSED, -FORCED-SEVEN, -KIND, the reading, C124-RADIUS-UP, -DOWN |
| `plans/STUB-q-ring.md` (FS-124) | what it delivered, section by section of the derivation file; what it did not; **its eight cases pass to FS-136** | the file whole |
| `plans/STUB-forced-pair.md` (FS-122) | the sharp form's statement with content is on pieces; for full members both pay, at a four-label point; nothing forces a pair | C124-FORCED-PIECES, -BOTH, -FOUR, -LONE |
| `plans/STUB-seed-remainder.md` (FS-135) | two entries stated on exclusion sets; the arc is no wall for a statement that reads pieces (G97's test, fired) | C124-HALF, -HALF-TWO, -BOTH, -EDGE-CLOSED |
| `plans/STUB-exclusion-back-to-maps.md` (FS-134) | three map entries now have a measure statement beside them, by other routes; the read-back at a map vertex not done; the cusp question | C124-BOTH, -FOUR, -LONE, -LONE-EXISTS, -EDGE-CLOSED |
| `plans/STUB-lateral-extent.md` (FS-127) | what its regularity would supply to the derivation file is the piece, and no more is asked | C124-SHADOW-OPEN, -TYPE, -FORCED-PIECES, -FORCED, -BOTH |
| `plans/STUB-saturated-local.md` (FS-125) | what one tight pair forces with no saturation — three statements; C124-ANTIPODE as the unsaturated neighbour of row 140's unit parallels; the first deriver's sentence on where binding has to enter | C124-CENTRE, -STRADDLE, -ANTIPODE, -KIND |
| `plans/STUB-qfree-ring.md` (FS-123) | no entry assumes a map, simplicity or the absence of Siamese pairs; they give the stub no kill | C124-FORCED-PIECES, -FORCED, -BOTH |

**New stubs: none minted; FS-137 is not used.** Each candidate the two rounds surfaced has a home or an explicit decline:

| candidate | where it is | who placed it |
|---|---|---|
| the six-colour point (FS116-Y2-SIXFRAG: eighteen arcs, no pair) | two of the successor's five first claims, and FS-124's case 4, which passes there | the asking lane, its last record § 4.1: "It does not need a stub of its own" |
| the partner count and the placing rule in measure (FS112-C-PARTNERS, FS116-N3-SEMI) | the successor's first claims | the asking lane, § 1.2 and the stub's dated block |
| the disk's rim and the flower's far vertex by C124-EDGE-CLOSED's method | the successor's first claims ("exact computations, the deriver's, not searches") | the asking lane, § 4.2 |
| an inhabitant of C124-SIX's hypothesis at seven or more (the first deriver's item 3) | **declined** as search line 13: "neither answer changes a move" | the asking lane, its second record; inventory item 13 |
| the per-class reciprocity rule (the second deriver's sweep item (2), "Not entered") | the successor, as the measurable form of FS112-N3-NOBOTH — "one step" | the asking lane, § 1.2's table |
| whether a three-tile vertex with a cusp is a sector point | a line in FS-134's stub (this stage) | this job |
| C124-EVERY-DIRECTION's consumer | the kernel lane, "only with a consumer" | the first kernel planner, § 4.2 |
| a second mind on C124-LONE's Step II | the second kernel planner, blind first | the coordinator, inventory item 21 (b) |

**Stage 4 — SAVED** (2026-10-07).

## Stage 5 — SAVED: every registered prediction, scored

*Reconciled, not redone: each outcome is the one its scorer wrote — the first deriver (E1 = `plans/FS124-E1-derivation.md`,
"Predictions scored" of Stages 3–5), the second (E2 = `plans/FS124-E2-derivation.md`, Stages 3–6), the asking lane (its ledger,
`plans/POROS-2026-10-07-fs124-round2.md`). Where nobody had scored a line, the score is mine and marked †. Brier: for a yes/no
line `(p − outcome)²`; for a card's branches the sum over the branches. Arithmetic: `data/fs124/z1/brier.py` (with its fault —
every outcome flipped — the mean over the 44 yes/no lines moves from 0.083 to 0.678).*

| who registered | the prediction | p | outcome | scored by | Brier |
|---|---|---|---|---|---|
| asking lane, first card (`plans/STUB-q-ring.md` l. 264) | C124-RADIUS (up) derived as posed | 0.90 | yes | E1, P1 | 0.0100 |
| | (down) | 0.92 | yes | E1, P1 | 0.0064 |
| | C124-CENTRE derived as posed | 0.92 | yes | E1, P2 | 0.0064 |
| | C124-COMPLETION derived as posed | 0.85 | yes | E1, P2 | 0.0225 |
| | C124-KIND true by formula | 0.80 | yes | E1, P4 | 0.0400 |
| | C124-SIX: derived as posed / restated at its wording / refuted by an object | 0.70 / 0.25 / 0.05 | the first — "derived as posed, and it says less than its wording in one respect" (E1, Stage 5) | E1 | 0.1550 |
| | C124-HALF derived as posed | 0.65 | yes | E1, P6 | 0.1225 |
| | **the card**: recurs / runs out / nothing forced beyond the first step | 0.50 / 0.12 / 0.38 | **the third** (E1 Stage 4: "it is the third"; the asking lane: "one card, answered on its third branch") | E1; the asking lane | 0.6488 |
| | an exclusion at an explicit radius, in measure, for every weak six-colouring with a tight pair of a named kind, within this milestone | 0.10 | no † | this job | 0.0100 |
| | a six-coloured object past `φ²/√2` about a tight pair's centre, within this milestone | 0.12 | no † | this job | 0.0144 |
| | six against seven decided by this milestone | 0.03 | no † | this job | 0.0009 |
| asking lane, second card (the stub, l. 424) | the reading's statement holds on the strip and the disk read whole | 0.9 | yes | E2, Stage 3 | 0.0100 |
| | some unread object shows a pattern other than (1, 1) | 0.5 | yes | E2, Stage 3 | 0.2500 |
| | a save by one member on a held object | 0.1 | **yes** (fragment S1) | E2, Stage 3: "met, against its 0.1" | 0.8100 |
| | every tight arc of kind both on the five unread objects is an edge of a save | 0.6 | **no** (FS116-Y2-SIXFRAG, S1) | E2, Stage 3 | 0.3600 |
| | C124-FORCED: derived as posed / restated at its wording | 0.8 / 0.15 (0.05 unassigned) | **the second** (E2, Stage 4) | E2 | 1.3650 |
| | C124-ONE-MEMBER: an object by formula / excluded / a gap at a named step | 0.45 / 0.2 / 0.35 | **excluded** for full members and sector points; an object exists only at a bowtie joined by the letter (E2, Stage 6) — not cleanly one branch | E2 | 0.9650 (scored as "excluded") |
| | C124-EDGE holds as read | 0.7 | yes | E2, Stage 6 | 0.0900 |
| | C124-SECOND derived as posed | 0.9 | yes, for sector points | E2, Stage 6 | 0.0100 |
| | **the card**: one edge of each member forced / a save by one member exists / neither decided | 0.2 / 0.45 / 0.35 | **the first**, for sector points ("the 0.2 occurred: the mass was on the branch a held map theorem had closed" — the asking lane) | E2; the asking lane | 0.9650 |
| | an exclusion at an explicit radius, in measure, for every weak six-colouring with a close complementary pair, within this milestone | 0.07 | no † | this job | 0.0049 |
| | a six-coloured object above the strip's top edge or outside the disk, within this milestone | 0.12 | no † | this job | 0.0144 |
| | six against seven decided by this milestone | 0.03 | no † | this job | 0.0009 |
| first deriver (`plans/FS124-tight-pairs.md` ll. 243–258) | P1: (up) as posed and in the wider form; (down) at every `k` | 0.95; 0.95 | yes; yes | E1, Stage 3 | 0.0025; 0.0025 |
| | P2: C124-CENTRE; C124-COMPLETION; C124-STRADDLE; C124-ANTIPODE | 0.97; 0.95; 0.90; 0.85 | yes ×4 | E1, Stage 4 | 0.0009; 0.0025; 0.0100; 0.0225 |
| | P3: nothing forced beyond the first step, exhibited at seven; on R7 every end a centre and no completion an end | 0.85; 0.90 | yes; yes ("as registered") | E1, Stage 4 | 0.0225; 0.0100 |
| | P4: C124-KIND true by formula | 0.93 | yes | E1, Stage 5 | 0.0049 |
| | P5: C124-SIX derived as posed; found to say less than its wording | 0.85; 0.40 | yes; yes | E1, Stage 5 | 0.0225; 0.3600 |
| | P6: C124-HALF derived as posed | 0.75 | yes | E1, Stage 5 | 0.0625 |
| | P7: G97's killing test fires in its second clause | 0.80 | yes "as registered", with its caution — "it bounds a configuration nobody has exhibited" | E1, Stage 5 | 0.0400 |
| second deriver (the plan, ll. 381–393) | Q1: the maps' statement; another pattern; every three-sector member separates at every common unit point; a save by a bowtie alone | 0.85; 0.8; 0.9; 0.6 | yes; yes; **no, as worded** (S1's sector member); yes | E2, Stage 3 | 0.0225; 0.0400; 0.8100; 0.1600 |
| | Q2: the piece form; as posed for sector points; fails by the letter | 0.9; 0.9; 0.7 | yes ×3 | E2, Stage 4 | 0.0100; 0.0100; 0.0900 |
| | Q3: excluded for members whose pieces pairwise share boundary; an object at a member of that kind | 0.85; 0.03 | yes; no | E2, Stage 5 | 0.0225; 0.0009 |
| | Q4: the top-edge computation; C124-SECOND for sector points; exactly four labels | 0.8; 0.9; 0.8 | yes ×3 | E2, Stage 6 | 0.0400; 0.0100; 0.0400 |
| | Q5: G97's killing test fires in the second clause | 0.8 | yes | E2, Stage 6 | 0.0400 |
| asking lane, third card (`plans/STUB-covering-pairs.md` § Registered expectations) | always empty 0.08; a ring by formula past print 0.12; turns on the ring's type 0.8; decides six against seven 0.03 | — | **open** — they are FS-136's | — | — |
| kernel lane, first planner | no probability registered; a price — the module "about 270 lines of proof", from its eight hardest leaves | — | "about half an hour, 204 lines, one retry on one leaf — the planner's estimate held" (inventory item 24) | the implementer; the coordinator | — |
| kernel lane, second planner | its record is on an unfinished branch; not read | — | — | — | — |

**Means over the yes/no lines** (the branch lines apart): the first card 0.026 (n = 9), the second card 0.172 (n = 9), the first
deriver 0.043 (n = 13), the second deriver 0.100 (n = 13); all 44: 0.083. **The five branch lines**: 0.155, 0.649, 1.365, 0.965,
0.965 — on four of the five the largest mass was on a branch that did not occur.

**What the scores say, in two lines.** The derivers' lines about whether a statement would be derived were nearly all met at
high probabilities — they measure little: each was registered after its recognition. The lines that moved a decision and lost
were the two cards' branch lines, and by the asking lane's own account for one mechanism: the second card put 0.45 on a save by
one member "on a branch already closed for maps" (FS112-N3-COR3, row 135), which the card had not read.

**The † lines, so that they can be overruled.** No entry excludes every weak six-colouring with a tight pair, or with a close
complementary pair, at an explicit radius: the nearest is C124-EDGE-CLOSED, which is for the colourings that keep six named
pieces of one held object at their labels. No six-coloured object was built past the strip's edge or the disk: C124-LONE-EXISTS
lives "on four flowers of radius at most about 1/4 and one band". Nothing here moves a value.

**Stage 5 — SAVED** (2026-10-07).
