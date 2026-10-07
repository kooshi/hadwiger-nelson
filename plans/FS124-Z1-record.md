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

## Stage 6 — SAVED: the front page's drafts

*The section below is the stage. Every draft names its slot. The ledger rows and the `CLAUDE.md` slots are written by
`data/fs124/z1/drafts.py`: statements copied from `plans/FS124-derivation.md`, each quoted* not claimed *phrase asserted to be in
its entry, each slot's old words asserted to occur exactly once on disk, bytes counted. `CLAUDE.md` was read from disk for its
slots (lines 86, 188–190, 211–230, 238, 249–251), not from the copy loaded at my launch, which was older (it ended at row 154).*

## Drafts for the front page

### `LEDGER.md` — four rows, 161 to 164

*Slot: `LEDGER.md`, the table of rows, after row 160. Each row is one line. Statements are copied by script from `plans/FS124-derivation.md`; every quoted *not claimed* phrase is checked to be in its entry (`data/fs124/z1/drafts.py`).*

| 161 | **The disc criterion, in measure — weak six-colourings of the open discs of every radius give `χ(ℝ²) ≤ 6` with no import, and a disc with none gives seven over one declared outside theorem:** "Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a finite subset of U. Then the rigid motions g with g(V) ⊂ U form a non-empty open set, and for almost every one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1; so the unit-distance graph on V has a proper k-colouring." (C124-RADIUS-GRAPH; for a countable set with compact closure in the open set, C124-RADIUS-COUNTABLE). "For every integer k ≥ 1: if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring, then every finite unit-distance graph in the plane has a proper k-colouring, and χ(ℝ²) ≤ k." (C124-RADIUS-UP). "For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of the plane has a weak measurable k-colouring." (C124-RADIUS-DOWN, over the declared outside theorem `Outside.OAI158.proper_to_borel_weak`). So at each `k` the two hold together or fail together, and at six, with row 33, the plane needs seven colours precisely if some open disc has no weak measurable six-colouring. At five: "There is R > 0 such that no open disc of radius R has a weak measurable five-colouring." (C124-RADIUS-FIVE, over `Outside.OAI158.no_proper_five_coloring`). For a measurable weak colouring every direction is good: "Let U be a measurable subset of the plane and c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U. Then for every unit vector u, c(z) ≠ c(z + u) for almost every point z of U with z + u in U." (C124-EVERY-DIRECTION). **Class:** every weak `k`-colouring of an open set, every `k ≥ 1`; no entry reads a number of labels. **Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending. **Kernel-checked on a branch, not through the gate, not held** (`fs124-wk1`, 57 theorems): `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`, each on the standard three axioms and that one declared outside theorem; (up) and its contrapositive on the standard three alone. The kernel planner's own generalizations there are its module's, not entries: the colouring's measurability idle in the finite-set form, the countable form and (up); (down) for every subset. **Not claimed:** "an explicit radius at any k"; "that the hypothesis holds at k = 6"; "anything without that import" (C124-RADIUS-DOWN); "any value of R" (C124-RADIUS-FIVE). **Prior art:** partly — for a colouring of the whole plane the motion argument is `[GwynStavrianos2022]` Lemma 2 and this library's N-EASY; for arc maps of discs the conclusion is row 145's; the bounded case for proper colourings is Kruskal 2008 (Zbl 1139.05023, held at abstract); (down) is `[OAIMath2026]` family 158's transfer, restricted; the disc form for weak colourings not found in print. | `plans/FS124-derivation.md` § 1; `plans/FS124-E1-derivation.md` Stage 3; branch `fs124-wk1` | FS-124 (2026-10-07) |

| 162 | **What an open piece of one label forces one unit away, in every weak colouring — the one lemma; its form for one connected piece and one side; and what one tight pair forces at its centre, beside its far end and at the opposite point, which is nothing beyond that first step:** "Let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and W an open subset of U almost every point of which has the label i. Then the set of points of U at distance exactly 1 from some point of W is open, and almost every point of it has a label other than i." (C124-SHADOW-OPEN). "Let c be a weak k-colouring of an open set U, P a connected open subset of U almost every point of which has the label i, x a point of the closure of P, and w a point of U with |w − x| = 1. If P has a point strictly inside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has a label other than i; if P has a point strictly outside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| < 1 has a label other than i." (C124-TYPE — by its deriver, row 157's C132-WITNESS followed by C132-WIT-SIDE in one statement). At a centre, collar by collar: "Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, ρ > 0 with B(z, ρ) ⊂ U, and a a label. If almost every point of B(z, ρ) with distance less than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label other than a; if almost every point of B(z, ρ) with distance more than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| < 1 has a label other than a." (C124-CENTRE-HALF; for a tight pair, both halves: C124-CENTRE). "Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has a label other than a and other than b." (C124-STRADDLE; at a rhombus completion, C124-COMPLETION). "Let c be a weak k-colouring of U, (q, z) tight for (a, b), and suppose p = 2z − q lies in U. Then there is η > 0 such that almost every point of B(p, η) has a label other than b, and almost every point w of B(p, η) with |w − q| < 2 has a label other than a." (C124-ANTIPODE). The conclusion at a completion "holds beside every interface between two open one-label pieces": read by formula ([tools]), on R7 no completion of an interior far end centres a tight arc (0 of 6) and on FS-112's strip no end of a unit-arc piece centres one (0 of 92). **Class:** every weak `k`-colouring of an open set; **no entry spends a number of labels.** A calibration at seven: "There is a weak measurable seven-colouring of the plane, by formula, with a tight pair (q, z) for (a, b) at which neither a nor b is present at q." (C124-KIND). A count at a centre, at every `k ≥ 4` and over a class with no held member: "Let k ≥ 4, U an open set containing the closed unit disc about q, c a weak k-colouring of U, ψ an angle, z_j = q + e(ψ + jπ/3) for j = 0, …, 5, and a, b, a′, b′ four distinct labels such that for j = 0, 2, 4 the pair (q, z_j) is tight for (a, b) or for (b, a), and for j = 1, 3, 5 the pair (q, z_j) is tight for (a′, b′) or for (b′, a′). Then a label other than a, b, a′, b′ is present at q." (C124-SIX). **Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending; C124-SHADOW-OPEN, C124-TYPE, C124-CENTRE-HALF, C124-CENTRE and C124-STRADDLE are in the kernel lane's second module, being planned. **Not claimed:** "anything for a set W that is not open"; "that any weak colouring has an open one-label set"; "anything for a piece that is not connected or not open"; "that any weak colouring has such a piece"; "that the configuration exists at any k" (C124-SIX). **Prior art:** partly — the lemma is the second half of the argument of C132-SHADOW (row 157) and G84's shadow identity for an open piece; in the map class the centre's statement is row 138's cone form; for a weak colouring not found in print; the entries name their debts. | `plans/FS124-derivation.md` §§ 2, 5, 6; `plans/FS124-E1-derivation.md` Stages 4–5; `plans/FS124-E2-derivation.md` Stages 4–5 | FS-124 (2026-10-07) |

| 163 | **What a close complementary pair forces at a common unit point, in measure — on pieces; with an arc where the members are sector points; by both members where they are full, at a point where exactly four labels are present; and the one exception, a member two of whose pieces meet at it only:** "Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc about w; the edge of those two pieces lies on S(w)." (C124-FORCED-PIECES — the statement with content of row 157's C132-COMP-SHARP, whose conclusion a one-point set meets). "Let c be a weak six-colouring of U, (x, y) a close complementary pair of sector points and w a common unit point of the pair lying in U. Then w is saved by x or by y; and for every interior point z of the arc so obtained the pair (w, z) is tight for the two labels of that edge, in one order along the arc." (C124-FORCED). The same for every three-piece point by the letter is **refuted** (C124-FORCED-AS-POSED; its verdict: "refuted: fragment BB with each bowtie's repeated label joined by a band — both members are three-piece points by the letter, their labels are 1, 2, 3 and 4, 5, 6, they are 1 apart, and no edge of either contains an arc of a circle"). "In the setting of C124-FORCED-PIECES suppose y does not separate at w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from B(w, 1) ∪ B(w′, 1), and their closures meet at x only." (C124-LONE), and that configuration exists: "There is a weak six-colouring of an open set U, by formula, with a close complementary pair (x, y) of three-piece points and a common unit point w of the pair in U at which y does not separate." (C124-LONE-EXISTS: fragment S1 with a band). "In the setting of C124-FORCED-PIECES, if x and y are full, both separate at w. If they are sector points, each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one member alone." (C124-BOTH). "In the setting of C124-FORCED-PIECES let x and y be full, each with exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w: those of the two inner and the two outer pieces." (C124-FOUR). "In the setting of C124-FORCED for sector points let both common unit points w, w′ lie in U, each with pattern (1, 1). Then the edge of x on the unit circle about w and its edge on the unit circle about w′ are different edges, and the edge of y on the unit circle about w and its edge on the unit circle about w′ are different edges; the labels present at w and those present at w′ are two sets of four with exactly two labels in common, one of each member; their absent pairs are disjoint; and the six labels have a cyclic order in which the three pairs read at w (the two edges, the absent pair) and the three read at w′ alternate." (C124-SECOND). From exclusion sets, the first round's forms: C124-HALF and C124-HALF-TWO, over the inherited C132-WIT-SIDE (the second the upper bound of C124-FOUR). **Class:** three-piece points by the letter (C124-FORCED-PIECES, C124-LONE); full members (C124-BOTH's first sentence, C124-FOUR); sector points (C124-FORCED, C124-BOTH's second sentence, C124-SECOND). **Every entry spends six**; at seven the count fails: "In the hexagonal seven-colouring at circumradius 2/5 there are two vertices less than 2 apart whose label triples are disjoint, with a common unit point interior to a tile of the seventh label; neither vertex separates there and no boundary of the colouring lies on a circle." (C124-FORCED-SEVEN). **Grade:** [hand] or derived from [hand] entries, one mind each, kernel pending; **a second mind is owed on C124-LONE's Step II**, on which C124-BOTH, C124-FOUR and C124-SECOND rest (its deriver's line; the kernel lane's second module is that mind, blind first); one topological input of C124-FORCED is recalled, not read. **Read on held objects** ([tools], one mind; C124-READ-SAVES): at every common unit point inside FS-112's strip and disk and FS-114's capped strip (71, 20, 71) one edge of each member lies on the point's unit circle and exactly four labels are present; fragments T2 and MX and the Searcher's kept model show two edges of one member, fragment BB none, fragment S1 a save by its bowtie alone; FS116-Y2-SIXFRAG has eighteen tight arcs of kind both and no close complementary pair. **Not claimed:** "that a weak six-colouring has a three-piece point, or a close complementary pair"; "anything with seven labels"; "that the saves close up along a chain of pairs; any exclusion" (C124-SECOND); "a value of the chromatic number of the plane" (C124-LONE-EXISTS). **Prior art:** partly — for maps C124-BOTH is FS112-N3-COR3 (row 135; two minds, one blind): "this is its form for a weak measurable colouring and full three-piece points, by another route"; the bowtie as the exception is FS107-W-TAN's (row 133); not found in print. | `plans/FS124-derivation.md` §§ 3, 5–7; `plans/FS124-E2-derivation.md` Stages 3–6; `plans/FS124-E1-derivation.md` Stage 5 | FS-124 (2026-10-07) |

| 164 | **FS-112's strip is closed at a point of its top edge against every weak six-colouring that keeps six named pieces — an exclusion of every weak six-colouring of a named open set by the open-piece lemma, local to one held family:** "There is no weak six-colouring of an open set that contains the point w = (1/4, √15/4 + √3/2), the three arches U_{−1}, U_0, U_1 of FS-112's strip and the parts of its tiles T_0, T_1, T_2 below the line y = √15/4, and that gives almost every point of each of these six sets the strip's label." (C124-EDGE-CLOSED): six uses of C124-TYPE (row 162) and exact comparisons in ℚ(√3, √15) bar all six labels on an open set near the point; nothing is assumed above the line `y = √15/4`. As posed, for a save by both members: C124-EDGE. **Class:** one held family — the strip at its own colouring; it spends six ("a seventh label takes the point"). **Grade:** [hand] with an exact check, one mind, kernel pending; it rests on C124-TYPE and on no entry of row 163. **Not claimed:** "anything about colourings that change the strip below y = √15/4"; "that no six-coloured object extends above the strip's top edge". **Prior art:** partly — for extensions of the strip as a map that keep all its tiles, FS112-EDGE (row 136); the held map statement about the strip's six tiles is FS114-Y-STRIPK6 (row 138; two minds, blind) — no valid map contains them, under any colouring — and neither statement is the other; for every weak six-colouring, not found in print. | `plans/FS124-derivation.md` § 4; `plans/FS124-E2-derivation.md` Stage 6 | FS-124 (2026-10-07) |

*Bytes: row 161: 3198, row 162: 4437, row 163: 5738, row 164: 1615.*

### `CLAUDE.md` § Frontier and § The aim

*`CLAUDE.md` on disk is 61543 bytes (budget 80,000). Each slot's old words occur exactly once on disk (asserted by the script). All seven drafts together: +1921 bytes, to 63464; without the last (§ The aim): +1681.*

**The "Last updated" line** — slot: `CLAUDE.md` § Frontier, the italic line beginning "*Last updated: 2026-10-07".

*Replaces, exactly:*

> Last filed: **FS-132, six by the nerve**, Derived (

*With:*

> Last filed: **FS-124, the unit arc**, Derived (rows 161–164; `plans/FS124-derivation.md`, 30 entries: 29 derived, 1 refuted; [hand], one mind each; no value moved; its first Lean module complete on a branch, its landing owed), its successor FS-136 named; before it **FS-132, six by the nerve**, Derived (

*Net change: +255 bytes.*

**The open-milestones paragraph** — slot: `CLAUDE.md` § Paths forward, ranked, the paragraph "**Open milestones.**".

*Replaces, exactly:*

> **Opened 2026-10-07: FS-124, the unit arc** (`plans/STUB-q-ring.md`; Kooshi's choice), re-posed for every measurable colouring proper at almost every unit pair: what a tight unit pair passes on (`plans/POROS-2026-10-07-fs124-question.md`).

*With:*

> **Derived 2026-10-07: FS-124, the unit arc** (`plans/FS124-derivation.md`, 30 entries: 29 derived, 1 refuted; [hand], one mind each; rows 161–164; stub `plans/STUB-q-ring.md`; Kooshi's choice): what a boundary along a unit circle about a point one unit away forces in a measurable colouring proper at almost every unit pair that has the pieces concerned — and whether any has them is not its claim. Its first Lean module, the disc criterion, is complete on branch `fs124-wk1` (57 theorems; kernel-checked on a branch, not through the gate; its landing is owed); its second is being planned; Closed when its modules pass the gate. Its eight cases pass to its successor, **FS-136, the point across** (`plans/STUB-covering-pairs.md`), Not started.

*Net change: +509 bytes.*

**Item 31, its head** — slot: `CLAUDE.md` § Where the problem stands, item 31.

*Replaces, exactly:*

> (§ The aim; rows 131–160; FS-117,

*With:*

> (§ The aim; rows 131–164; FS-117,

*Net change: +0 bytes.*

**Item 31, a sentence added** — slot: `CLAUDE.md` the same item, after the sentence ending "in an arbitrary colouring.".

*Replaces, exactly:*

> none produces a point with such data in an arbitrary colouring. What is open

*With:*

> none produces a point with such data in an arbitrary colouring. At the unit arc itself (FS-124; rows 161–164; [hand], one mind each, kernel pending): `χ(ℝ²) ≤ 6` exactly when every open disc has a measurable six-colouring proper at almost every unit pair, the direction toward seven over the outside theorem on Borel transfer (row 161); one tight pair forces nothing beyond its first step (row 162); two three-piece points less than 2 apart on disjoint triples force a piece of one of them inside and another outside the unit circle about each common unit point — of both where both are full, at a point of exactly four labels, and one member pays alone only where two of its pieces meet at it only (row 163); FS-112's strip is closed at a point of its top edge against every weak six-colouring keeping six of its pieces (row 164). A statement that reads pieces at named points does cross the unit arc; none gives a colouring a piece. What is open

*Net change: +881 bytes.*

**Item 31, its last sentence** — slot: `CLAUDE.md` the same item.

*Replaces, exactly:*

> now the unit arc in measure (FS-124),

*With:*

> now the point across a ring's covering pair (FS-136, FS-124's successor),

*Net change: +36 bytes.*

**The ledger's pointer** — slot: `CLAUDE.md` § The novel-results ledger.

*Replaces, exactly:*

> **Rows 1–160 live in `LEDGER.md`**

*With:*

> **Rows 1–164 live in `LEDGER.md`**

*Net change: +0 bytes.*

**§ The aim, the fifth point — if the coordinator judges the disc criterion belongs there** — slot: `CLAUDE.md` § The aim, point 5.

*Replaces, exactly:*

> or valid fragments on discs of every radius (row 145).

*With:*

> or valid fragments on discs of every radius (row 145) — in measure, exactly: `χ(ℝ²) ≤ 6` iff every open disc has a measurable six-colouring proper at almost every unit pair, toward seven over the outside theorem on Borel transfer (row 161; [hand], one mind; kernel-checked on a branch).

*Net change: +240 bytes.*

**Held for the landing of branch `fs124-wk1`, not for this filing** — slot: `CLAUDE.md` § Where the problem stands, after the sentence on `seven_le_chromaticNumber_plane_iff`; the first kernel planner's draft (its record § 4.4, on that branch), verbatim:

> On discs (`Plane/RadiusOutside`): `seven_le_chromaticNumber_plane_iff_exists_ball` — `7 ≤ χ(ℝ²)` exactly when some open disc about the origin has no weak measurable six-colouring — and `colorable_iff_forall_ball` at every `k`. *Seven gives such a disc* is the contrapositive of `radius_up` (`exists_radius_of_not_colorable`) and rests on the standard three axioms; *such a disc gives seven* is the contrapositive of `radius_down` and rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`. So an exclusion on a disc reaches seven only through the transfer, and weak six-colourings of every disc reach six with no import.

*Net change when filed: +652 bytes. When it is filed, the clause added to § The aim above loses "kernel-checked on a branch".*


### `plans/FRONTIER-STUBS.md`

- **§ Open milestones, in order**, the first paragraph: the sentence "**Opened 2026-10-07: FS-124, the unit arc** (`plans/STUB-q-ring.md`;
  Kooshi's choice), re-posed for every measurable colouring proper at almost every unit pair: what a tight unit pair passes on
  (`plans/POROS-2026-10-07-fs124-question.md`)." is the same sentence as `CLAUDE.md`'s; the same replacement (the "Derived 2026-10-07:
  FS-124" draft above) stands for it.
- **§ Ranked stubs**: the ranked table is the asking lane's — its draft is `plans/POROS-2026-10-07-fs124-round2.md` § Draft re-rank
  (the successor at rank 1 once this milestone is Derived; clauses for the rows of FS-122 and FS-117; the top three for
  `CLAUDE.md`). **One clause of that draft is larger than the entries it names, for the coordinator's choice**: "a close
  complementary pair of sector points is paid for by both members at four-label points (C124-BOTH, C124-FOUR, [hand], one mind)".
  C124-BOTH gives "both members" for sector points; C124-FOUR gives exactly four labels only where each member has "exactly one
  inner piece, one outer piece and one crossing piece" at the point, and its *not claimed* line excludes the other case ("anything
  when a member has two inner or two outer pieces (T2: five labels allowed, four present)"). A form no larger: "…is paid for by
  both members (C124-BOTH), at a point of exactly four labels where each member has one piece of each side (C124-FOUR); [hand],
  one mind; C124-BOTH and C124-FOUR rest on C124-LONE, a second mind owed".

### The registered predictions

Scored in one table: this record's Stage 5. For the front page nothing is drafted from it; for the asking lane's ledger, the three
lines it had not scored (marked † there) are scored "no".

### `.claude/skills/grokkings/SKILL.md` (180,656 bytes on disk; budget 200,000)

**G97, amended in place** — slot: entry G97; its status bracket, a demotion record after the sentence ending "and G84 says why a
tight colouring has it everywhere: contact.", and its *Do* and killing test. The asking lane drafted an amendment
(`plans/POROS-2026-10-07-fs124-round2.md` § 4.4); this is that draft with two things added from the entries — what C124-BOTH rests
on, and the pieces nobody is known to have. About +1,100 bytes.

> *Status:* **[reading, one mind; its killing test fired at FS-124 (2026-10-07): the wall is the palette calculus's, not the
> tools']**
>
> *Demotion record (FS-124, 2026-10-07):* as minted this entry called the unit arc about a ring point the object at which every
> exclusion on the measurable road stops, and named as its killing test "a statement by the same tools that excludes, builds or
> bounds a unit arc about a ring point". Two entries of FS-124 are such statements, each by the open-piece lemma (C124-SHADOW-OPEN,
> C124-TYPE; row 162): C124-BOTH excludes a configuration with such an arc — a common unit point of a close complementary pair of
> sector points paid for by one member alone (row 163; it rests on C124-LONE, on which a second mind is owed) — and
> C124-EDGE-CLOSED excludes every weak six-colouring that keeps six named pieces of FS-112's strip and contains one point of its
> top edge (row 164). What survives: the palette calculus of rows 155 and 159 stops at the arc; a statement that reads pieces at
> named points does not — and no weak six-colouring is known to have the pieces.
>
> *Do, amended:* say of each exclusion in the measurable class whether it reads palettes at a point or pieces at named points.
> For the first, plant the arc (fragment T2; the search's kept model) and put in the headline which side of the line the
> statement sits on. For the second, say in the headline that no weak six-colouring is known to have the pieces, and name the
> held map entry it restates (G99). *Killing test, amended:* a palette-level exclusion on the arc-free side whose residue is some
> other object; or a palette-level statement that excludes, builds or bounds a unit arc about a ring point.

**G99, proposed** — slot: after G98. In G67's form. It is the asking lane's draft (the same § 4.4), restated from the entries;
its status is the asking lane's reading, which that record calls "my reading of each argument's shape from its statement and its
'uses' line, not a derivation". About 1,900 bytes.

> * **G99 — With pieces, the local theory is the map class's; what measure owes is the piece. [hand for the lemma and three carried
>   steps, one mind each (rows 162–164); the reading one mind, from the shapes of ten map-class arguments, not derived]** A connected
>   open set almost all of one label does in any weak colouring what a tile does in a map: with a point of its closure one unit from
>   `w` and a point strictly on one side of the unit circle about `w`, it bars its label near `w` on one side of the unit circle
>   about that point (C124-TYPE). Three map statements have been carried by it and a count — the rhombus (FS112-N3-COR3: C124-BOTH,
>   C124-FOUR), "one failure is not enough" with the bowtie (C124-LONE, C124-LONE-EXISTS), the strip's six tiles at one point
>   (FS114-Y-STRIPK6: C124-EDGE-CLOSED). The measure form asks for pieces at the points it names and nothing elsewhere; where it
>   concludes an arc its hypothesis is a sector point, a three-tile vertex seen locally. *Reading:* every map statement that reads
>   finitely many tiles near finitely many points is one use of the lemma from holding for every weak colouring with those pieces,
>   and what has no measurable form reads the map whole — that a vertex exists, that a ring changes finitely often, that tiles can
>   be counted (G86). *Do: before posing a local claim for measurable colourings, search rows 133–138 and 145–150 and their
>   derivation files for the map entry it restates, name that entry in the claim, and pose in measure only what the map entry
>   cannot give — fewer hypotheses, or the piece itself (FS-127, FS-128); trigger: a card whose claim is about finitely many pieces
>   at finitely many points. Before citing a carried statement, say that no weak six-colouring is known to have the pieces.
>   Killing test: a map entry reading finitely many tiles whose measure form fails with pieces at its points (the dictionary needs
>   a third word); or a local statement in the piece class with no map antecedent that changes a move on the case list.*

**Not proposed, and why.** A third entry — "three tests before a statement is filed: the count, the smallest member, the
population" — was drafted and withdrawn: its three tests are the identity's own (the model of the hypotheses; *not claimed*) and
G21's headline rule, and the second card already carried the first ("hold at six, fail at seven, the witness named"). What the
day adds is instances, filed below under G21 and G92.

### `plans/GROKKING-INSTANCES.md`

**§ G21 — a new instance**, slot: the end of the section "## G21" (appended as its last paragraph):

> FS-124 (2026-10-07): three headlines larger than their statements, each caught the same day. (i) "94 of 94" — one edge of each
> member on the centre's unit circle at every centre read — was a sample, by one mind's script, on two maps built by one recipe;
> read whole on nine held objects it is the law of the strip, the disk and the capped strip "and of nothing else held"
> (`plans/FS124-E2-derivation.md` Stage 3 § 3.2; `plans/FS124-close-inventory.md` items 13 (a), 16 (d)). (ii) "Every statement but
> the count is true at every number of labels" named the wrong exception — the count is stated for `k ≥ 4`, and the two entries
> that spend six are the rhombus's (item 12 (a)); a brief's first draft said "fifteen of the sixteen are true at every number of
> colours" — "a count I had not read from the record" (item 10). (iii) "0 of 92 ends centre a unit arc" was true and hid a
> positive — all 40 interior ends of the strip are three-label points one unit from exactly two centres: "it was read for the
> wrong property" (item 12 (c)). A control satisfied with room: the first card expected the capped honeycomb at circumradius 1/2
> to be refused by the check, and it is still a weak seven-colouring — "The honeycomb at 1/2 is tight at its vertices only; its
> edges have room" — so R7 is the model with no room (`plans/FS124-E1-derivation.md` Stage 5, "Read against the card"). Three
> reader defects in two rounds, none flattering, each repaired before a count was kept (that record's Stage 4;
> `plans/FS124-E2-derivation.md` § 3.1). Source: `plans/FS124-Z1-record.md` Stage 7.

**§ G92 — a new instance**, slot: the end of the section "## G92 — A held result reaches as far as its argument, not as far as its
statement" (after the paragraph beginning "FS-132 (2026-10-07):"):

> FS-124 (2026-10-07): the trigger "a second milestone about to re-derive a near neighbour" did not fire at the asking lane and
> fired at the deriver. The second card posed as open — "must one edge of each member lie on its unit circle?", with 0.45 on a save
> by one member — a question FS112-N3-COR3 (row 135; two minds, one blind) answers for maps: "each a leaving centre of both `u`
> and `u′`". The deriver found it at its readback (`plans/FS124-E2-derivation.md` Stage 1); the asking lane: "The second card was
> written from a reading of two maps and not from that list" — the stub's own carry-over list, which names that lemma second
> (`plans/POROS-2026-10-07-fs124-round2.md` § 1.3, S4); the coordinator: "the second time today a card's unit was corrected by
> the deriver who took it" (`plans/FS124-close-inventory.md` item 15 (b)). Two held statements about one set of six tiles —
> FS114-Y-STRIPK6 and C124-EDGE-CLOSED — "do not cite each other" (S5). Reaches found the same day by reading arguments: the
> kernel planner, typing the radius clause blind, found the colouring's measurability idle in three statements and (down) true of
> every subset (item 14); C124-CENTRE-HALF is "C124-CENTRE with its hypothesis split (G92)" (its entry); the forcing count's
> argument reads "every label is a label of a piece at one of the two points", not two disjoint triples (item 26 — the asking
> lane's reading, to be derived at FS-136). Source: `plans/FS124-Z1-record.md` Stage 7.

### `BIBLIOGRAPHY.md`

No row drafted. The entries cite `[GwynStavrianos2022]`, `[OAIMath2026]`, `[SokolovVoronov2025]` and Kruskal 2008 (Zbl 1139.05023);
the first three are keys used across the front page, and Kruskal's row stands (the file's line 903, found by grep; "held at
abstract" is the first deriver's reading status). I did not check each key against every section. One debt with no row to
draft: the θ-curve form of the Jordan–Schoenflies theorem, which C124-FORCED recalls and nobody read — a source is owed before
C124-FORCED's topological input is cited.

### `tools/viz_proof_atlas_facts.py` — Proof Atlas facts

*Slot: after the node "FLOWERS" (row 160) and the edge from "PLACEDARC" to it; written by the filing after the ledger rows, because
each quote must be found in a filed row. Statuses and grades in the project's words. `at=` and `sector=` are the filing's to
place (near "COR3", "STRIP" and "STOP", which these stand beside). The meta line's `job` becomes "FS124-Z1" and its `as_of`
"FS-124, the unit arc, Derived (rows 161–164)".*

```python
N("DISCS", "the disc criterion", "held", "Weak measurable six-colourings of the open discs of every radius give χ(ℝ²) ≤ 6 with no import; a disc with none gives seven over one declared outside theorem.", L(161), "the plane needs seven colours precisely if some open disc has no weak measurable six-colouring", "[hand], one mind; kernel-checked on a branch, not held")
N("ONEPIECE", "one piece, one side", "held", "In every weak colouring an open piece of one label bars that label one unit away; one tight pair forces nothing beyond that first step.", L(162), "no entry spends a number of labels", "[hand], one mind")
N("PAIRPAYS", "a close pair pays at its common unit points", "held", "Of two three-piece points less than 2 apart on disjoint triples of six labels, one has a piece inside and another outside the unit circle about each common unit point; both where both are full; one alone only at a bowtie. Nothing says a colouring has such points.", L(163), "x or y separates at w", "[hand], one mind; a second mind owed on one step")
N("STRIPEDGE", "the strip's top edge is closed", "nogo", "No weak six-colouring keeps six named pieces of the strip and contains one point of its top edge.", L(164), "bar all six labels on an open set near the point", "[hand], one mind")
E("ONEPIECE", "PAIRPAYS", "context", L(163), "x or y separates at w", label="six uses of the lemma and a count")
E("ONEPIECE", "STRIPEDGE", "context", L(164), "six uses of C124-TYPE", label="six uses of the lemma")
E("COR3", "PAIRPAYS", "context", L(163), "for maps C124-BOTH is FS112-N3-COR3", label="the map theorem, in measure, by another route")
E("STOP", "STRIPEDGE", "context", L(164), "FS112-EDGE (row 136)", label="the same point, for every weak six-colouring keeping six pieces")
E("DISCS", "STRIPEDGE", "context", L(161), "an explicit radius at any k", label="an exclusion on a disc would reach seven here; this one is not on a disc")
```

*Not checked by me: the edge kinds the atlas accepts (I copied "context" from the one edge I read), the node ids "COR3" and "STOP"
beyond their titles, and the lint. The quotes are substrings of the rows as drafted above.*

**Stage 6 — SAVED** (2026-10-07).

## Stage 7 — SAVED: the sweeps

### 7.1 §G re-read — which extractions paid, and which entry should have borne

*Read for this: the lead line of each bearing in the plan's two walks (`plans/FS124-tight-pairs.md` § §G and § Second round, §G),
not their bodies; the two "Silent" lines exist (ll. 88, 325).*

**Paid** (the entry, the instruction it gave, what came of it): **G92** — "C132-SHADOW's argument has two halves": the half that
reads no direction is C124-SHADOW-OPEN; and in the second round "C132-COMP-SHARP's argument reads of an 'edge set' only two of its
points": the piece form (C124-TYPE, C124-FORCED-PIECES). **G95** — plant slack at seven: the two calibrations. **G21** — controls
on a model with no margin: R7; the card's expected control found wrong; three reader defects found and repaired. **G86** (second
round: the save's exception is a point where a label's germ is not connected) — the definitions *full* and *sector point*, and
with them C124-FORCED-AS-POSED and C124-LONE-EXISTS. **G91** — ask whether a type is inhabited: C124-LONE-EXISTS; C124-SIX's
class said to have no member in its own entry. **G97** — registered as falsifiable here in both rounds: fired in both (P7, Q5).
**G79** — read what the held objects carry: the readings of both rounds, and from them the unit of each next card. **G82, G93** —
the radius clause as the regular-objects form. **Bore and produced no entry**: G84, G85, G89 (saturation — passed to FS-125's
stub in Stage 4), G94, G98.

**Should have borne and was not used.**
1. **G92's trigger — "a second milestone about to re-derive a near neighbour" — at the asking lane's second card.** The instance
   is drafted (Stage 6, § G92). **The rewrite of the missed entry, in G67's form** — slot: `.claude/skills/grokkings/SKILL.md`,
   entry G92, its *Do* sentence, replaced by (additions in bold; about +330 bytes):
   > *Do: before applying or citing a held result, read its `uses only:` line, list the hypotheses its argument never consumes,
   > and restate it without them before asking where else it bears; **and before posing a claim as open in another class, search
   > the derivation files — not the ledger rows — of the milestones the stub cites for the entry the claim would restate, and
   > name that entry in the claim;** trigger: a statement whose class names a property its proof does not use, a second
   > milestone about to re-derive a near neighbour, **or a card written from a reading of objects**.*
2. **G21, at the opening's own §IQ**: "If anything recurs it is at the *ends* of the maximal arcs" was assessed from R7, the one
   inhabitant then read; on the strip no end of a unit-arc piece centres one (0 of 92). The deriver scored it itself (the plan's
   dated line under §IQ; `plans/FS124-E1-derivation.md` Stage 4). No rewrite: G21 says it. **One line for the G21 instance drafted
   in Stage 6**, to follow its "(iii)": "(iv) the opening's §IQ placed the recurrence 'at the ends' from R7 alone — R7's shape and
   the disk's pentagon's (10 of 40), false of the strip (0 of 92) (`plans/FS124-tight-pairs.md` § §IQ, the dated line)."

### 7.2 §IQ and G79 — only a counterexample to either rule

- **§IQ's rule: one result came from somewhere other than the structural question — the radius clause.** It is the existence
  form's own consumer statement (the plan's §IQ item 1: "By C124-RADIUS below (posed) a yes is `χ(ℝ²) = 6` and a no at one radius
  is `χ(ℝ²) = 7`") and reads no tight pair; it is the milestone's one module in the kernel and the one row a later milestone must
  cite for either answer. It is a counterexample of the weak kind: it moves no value, and its argument for the whole plane is
  held prior art. Everything derived in § 3 of the derivation file reads the invariant the second round's §IQ proposed before
  deriving — the side of each piece at each common unit point — which is the rule working.
- **G79: none.** No result came from a counterexample invariant alone. The refuted wording fell to a held example (fragment BB,
  banded) and the save by one member was found on a held example (fragment S1) before it was derived.

### 7.3 §PA — recognitions about what the object is, and where each went

| recognition | whose | where it went |
|---|---|---|
| the object is the unit shadow `W + S¹` of an open one-label set; "radius exactly 1" determines only the centre's and the antipode's statements and accompanies the rest | first deriver, Stage 2 | C124-SHADOW-OPEN at every open `W`; the drafted G99 |
| the object is the side — inner, outer, crossing — of a connected piece at a point one unit from its closure; the count is a function of the six sides and of nothing else | second deriver, Stage 2 | C124-TYPE, C124-FORCED-PIECES; G99; the successor's first claim (the count at the class its argument reads) |
| "A tight pair is an effect, not a cause"; every held stop is one kind of point | the asking lane | the successor's stub, minted by it |

**Prior-art debts carried, none paid by this job** (no search was run): the first round's gate items 4, 5, 7, 8 "were not done and
are debts"; "prior art: owed" at C124-RADIUS-COUNTABLE and C124-OPEN (the gate's two warnings); the θ-curve lemma and the
release's every-direction lemma recalled, not read; C124-SECOND "not searched against FS116-N2-STAR and -N2-RECIP" (the asking
lane, § 2.3); C124-ANTIPODE "owed beyond that".

### 7.4 The plan and the stubs, grepped for "conjecture" and "not claimed"

"conjecture": 0 hits in `plans/FS124-tight-pairs.md`, 0 in `plans/STUB-q-ring.md`, 0 in `plans/STUB-covering-pairs.md`.
"not claimed": 1, 2, 0.

| hit | what it is | a stub, or a decline |
|---|---|---|
| the plan, l. 70 | a dictate: every entry's *not claimed* line says the class of weak colourings with a tight pair is not known to be all weak six-colourings, nor inhabited at six | met by the entries; that every colouring has such data is FS-127's and FS-128's — open stubs; no new stub |
| the stub, l. 52 | FS-129's LOCAL-DENSE, its *not claimed* line on the radius | part of the eight cases, which pass to FS-136 |
| the stub, l. 642 | C132-PLACED-RING's *not claimed* line, in the block "Since FS-132" | see below |

**One thing the grep found that has no stated home.** The milestone's stub carries three items "Open, carried here from FS-132,
none started": C132-ARC, C132-PLACED's open line, C132-RADIUS. Two are now answered by entries — C132-RADIUS by C124-RADIUS-UP
and -DOWN (row 161's draft), C132-ARC by C124-HALF and C124-HALF-TWO (C124-HALF's *prior art* line: "posed as C132-ARC and by the
asking lane"). **C132-PLACED's open line** — whether any pair containing a label of the centre's triple is a witnessed edge at the
placed point — was not started by either round, and the asking lane's verdict passes "the eight cases" and two map steps to
FS-136 without naming it. A question for the asking lane, in the report's INVENTORY; I minted nothing for it.

**Stage 7 — SAVED** (2026-10-07).

## Stage 8 — SAVED: the gates, and where a successor takes over

| file | command, from `plans/` | result |
|---|---|---|
| `FS124-derivation.md` | `derive_gate.py all FS124-derivation.md` (background, under a slot) | **PASS**, 0 failures, 2 warnings (the sources' "prior art owed" ×2); entries 30, derived 29, refuted 1; controls 17, firing 17 |
| the same, against its sources | `derive_gate.py quotes FS124-derivation.md FS124-E1-derivation.md FS124-E2-derivation.md` | PASS; 30 statements, each identical in two files |
| `FS124-E1-derivation.md` | `derive_gate.py all`, before and after its two appended paragraphs | PASS, 2 warnings; PASS, 2 warnings |
| `FS124-E2-derivation.md` | the same, before and after its one | PASS, 0 warnings; PASS, 0 warnings |
| `FS132-derivation.md` | the same, before and after its two | PASS, 9 warnings; PASS, 9 warnings |
| this record | `derive_gate.py entries FS124-Z1-record.md` | **FAIL by construction**: "no derivation entry" — a record job's record holds none; the gated file is the derivation file |

Scripts, each with a fault watched firing: `quote_check.py` (0 of 6 with one character changed), `build_derivation.py --check`
(exit 1 with one byte appended to the file, then restored: `git status` clean), `brier.py --fault` (mean 0.083 → 0.678),
`append_corrections.py` and `append_stubs.py` (each refuses a second run). They are under `data/fs124/z1/`, not `tools/`, as the
brief asked while a landing is in flight.

**Where a successor takes over.** Every numbered item of the brief's § Done means is at a saved stage. Not done, and said:
(1) nothing here is a second reading of any argument — C124-LONE's Step II is still owed to the second kernel planner;
(2) the Proof Atlas draft's edge kinds and node ids were not checked against the atlas's lint; (3) the stubs' card check (the
asking lane's) and the front page's fact audit were not run — I wrote neither file they guard, except the stubs' bearing blocks;
(4) the launch's copy of `CLAUDE.md` was older than the disk's, so every slot was read from disk — a landing in flight may move
them again before the filing, and `data/fs124/z1/drafts.py` re-run will say which slot no longer matches (its asserts).

**Stage 8 — SAVED** (2026-10-07).
