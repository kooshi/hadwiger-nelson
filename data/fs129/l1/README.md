# FS129-L1 — the Lean backlog's input: record

*The Clerk, Sonnet 5.5, 2026-10-03. Brief: `data/fs129/briefs/FS129-L1-backlog.md`. Script: `tools/fs129_l1_backlog.py`. Output: `plans/LEAN-BACKLOG.md`. Everything in the output is read from files by the script; nothing is judged.*

## Theorems this phase proved

none — a filing job.

## Stage 1 — SAVED (readback)

### The brief's quotations against their sources

Compared as whitespace-normalised substrings (line breaks joined), by a one-off python check:

| quotation in the brief | source | result |
|---|---|---|
| Kooshi's four answers, "1. yes, we don't want O(N^2) here. … so it'll pick up the latest changes." (§ Why this job) | `plans/FS129-cross-application-audit.md` § 1 (the decisions block, line 14) | identical |
| the plan's Stage 6 sentence, "`plans/LEAN-BACKLOG.md`: `lean-order.md` with stage 4's merges applied, each statement quoted by script from its derivation file, each" (the brief gives it as § 3. The shape) | same file, Stage 6, lines 96–98 | identical |
| the coordinator's words, "the audit prepares its input — the build order from the dependency map, and the merged and strengthened statements — so that the backlog formalizes each statement once, in its strong form" | same file § 1, question 3 (line 25) | identical |
| the sentence's continuation, "with its *not claimed* line and its upstream ids" | same file, Stage 6, line 98 | identical |

No mismatch. Two small findings about the brief, neither a defect in a quotation:
- the Stage 6 sentence sits under `## 3. The shape: one index, three passes, then the record` in the plan; the brief's address `§ 3. The shape` is right;
- the brief says the order has 178 entries and that three seeds are conditional: `data/fs129/index/lean-order-corrected.md` has 178 table rows, 78 SEED roles and three roles reading "SEED (conditional: handoff begins `none`)" (FS116-Y4-SPOKE, TC1-SQRT3-DYADIC, TC1-STANDING-FIVE), as inventory item 13 says.

### What a row of § The order must contain, in my words

Each row stands for one entry of the corrected Lean order, in the corrected file's order (dependencies first). It carries: the entry's id; its address (`plans/<file>:<line>`, the line of its header); its role as the corrected file writes it (SEED, upstream, ROUTE-ONLY, CYCLE, or a seed marked conditional); the statement exactly as filed, taken by the script from the derivation file (for an entry in the older grammar the header's own words, since such an entry has no `statement:` field), with any dated erratum or correction filed under the entry quoted below it; the *not claimed* line exactly as filed (empty where the entry has none, and listed); its grade and its minds as filed; its upstream ids, which are the order file's `needs`; its `handoff:` (or, in the older grammar, `*Kernel:*`) line, since the conditional seeds and the backlog read it; and the merge notes, each the audit's own line, quoted with its list address, where a merge or a "do not formalize as stated" applies. Cautions are attached by their inventory item.

The order's source is `data/fs129/index/lean-order-corrected.md`, never `lean-order.md`. The derivation text comes from `plans/*-derivation.md` through the census parser (`tools/fs71_ledger_b_check.py` and, for the newer grammar, the Ephodos gate it imports). The merges come from the four audits' lists (SR1 § 6.2, SR2 § 4.3, SA1 § 6.3, SR3 § 5.1), copied by the script into `data/fs129/l1/merges.csv` with their addresses.

### Reading budget

The brief's reading list fits: the script reads the files itself. I read the four audits' list sections, the inventory items named, the corrected order and its README, and the census and gate sources, in part.

## Stage 2 — SAVED (the script, its merges, its self-test)

- `tools/fs129_l1_backlog.py` written (standard library plus `tools/fs71_ledger_b_check.py` and, through it, the Ephodos gate). `data/fs129/l1/merges.csv`: 42 lines keyed by hand from the four audits' lists (list, item, kind, status, the ids each line names, its address as `file:first-last`), their `text` column filled by `python3 tools/fs129_l1_backlog.py --fill-merges` from those lines and re-checked against them on every run.
- **Negative controls** (`python3 tools/fs129_l1_backlog.py --self-test`, output in `data/fs129/l1/self-test.out`, exit 0): the clean run has 0 failures and counts 259 rows, 28 dated notes and 147 merge notes (so it cannot pass by checking nothing); then each of the five planted faults is caught and named: a statement altered by one character (FS116-Y4-EMPTY), an erratum dropped from its entry (FS114-N7-3T), a superseded entry listed for formalization (FS129-MA1-FALC-19), a merge line naming an id that is no entry (FS129-NO-SUCH-ENTRY, in a planted copy of `merges.csv`, removed afterwards), an entry placed before something it rests on (FS106-TS-C before FS106-DIAM).
- Second route: the written file is re-read and each quoted block is compared with its source by regular expressions over the raw lines at the row's address, not through the gate's parser (`indep`, `indep_notes` in the script).

## Stage 3 — SAVED (the output, the checks, the record)

`python3 tools/fs129_l1_backlog.py` wrote `plans/LEAN-BACKLOG.md` (259 rows, 449 KB) and verified it, exit 0, `RESULT: PASS` (`data/fs129/l1/final-run.out`, the run at the commit its header names, inputs clean). Counts, as the file's § Counts states them: 178 rows in § The order (SEED 75, SEED conditional 3, upstream 100; 12 ROUTE-ONLY, 5 CYCLE), 32 in § FS-129's compositions (44 entries less the 12 superseded, none of which has a row; each is in the table under them with its superseding form), 26 in § Left the order, 23 in the last section (named by a merge line or a caution, in no other section); 42 merge lines, 147 merge notes attached to rows; 28 dated notes (errata, corrections, banners, errata-section items) attached; 54 (row, caution) pairs; 54 rows with no *not claimed* line (52 are in the older grammar, which has no such field) and 2 rows with no grade (FS111-C-HULL-SO, FS114-K1, both rows of § Left the order).

The index README (`data/fs129/index/README.md`) has the one pointer line to `README-corrections.md` at its top, and no other edit.

**What the check compares.** For every row the statement, *not claimed*, grade, minds and handoff blocks equal their source by a second route; the dated notes under the entry equal those found between its header and the next header or heading; each merge note equals its audit's lines; each caution equals its inventory item; no row of § The order stands before a row it rests on; no superseded FS-129 entry has a row; the file's own count line equals its markers. The script also fails if the order is not 178 rows with 78 seeds and 3 conditional, if `Left`/`Joined` do not equal the difference of the two order files, if `plans/FS129-derivation.md` does not have 44 entries of which 12 superseded, if the derivation files do not hold 17 errata of FS129-Z1/SA1 (inventory item 136), or if any of the seven entries of item 116 has no note filed under it.

## CHECK lines

(`CHECK:` is the script's own word for what it will not decide; the lines below are the script's output at the final run, then the ones it cannot see.)

- **CHECK:** FS129-OA1-FALC-RED (superseded) and FS129-SA1-FALC-RED have identical statements (SA1 § 6.3 item 6 names the OA1 statement with the SA1 argument; the backlog row is the SA1 entry)
- **CHECK:** FS114-N7-3T is named by a do-not-formalize line and by a quote-with-errata line; both are attached
- **CHECK:** FS116-N2-HEX6 is a SEED row of the order (its handoff names de Bruijn) and a merge line says do not formalize it as stated (the line may name a clause only)
- **CHECK:** FS116-N2-HEX3 is a SEED row of the order (its handoff names de Bruijn) and a merge line says do not formalize it as stated (the line may name a clause only)
- **CHECK:** FS116-RING-TRANSFER-C is a SEED row of the order (its handoff names de Bruijn) and a merge line says do not formalize it as stated (the line may name a clause only)
- **CHECK:** FS116-S1-KAPPA is a SEED row of the order (its handoff names de Bruijn) and a merge line says do not formalize it as stated (the line may name a clause only)
- **CHECK:** FS116-Y3-NOQ is a SEED row of the order (its handoff names de Bruijn) and a merge line says do not formalize it as stated (the line may name a clause only)
- **CHECK:** FS116-Y3-TIGHTLENS is a SEED row of the order (its handoff names de Bruijn) and a merge line says do not formalize it as stated (the line may name a clause only)
- **CHECK:** FS116-Y3-STARFORCE is a SEED row of the order (its handoff names de Bruijn) and a merge line says do not formalize it as stated (the line may name a clause only)
- **CHECK:** FS116-Y4-SPOKE is a SEED (conditional: handoff begins `none`) row of the order (its handoff names de Bruijn) and a merge line says do not formalize it as stated (the line may name a clause only)
- **CHECK:** FS111-M-COVER-SC has a row (it is in the Lean order), and its handoff says: none — superseded by FS111-M2-HULLC's fuller form; crosses with it
- **CHECK:** FS114-N3-DR has a row (it is in the Lean order), and its handoff says: none — superseded by FS114-Y4-RSTOPALL as a statement; its lemmas are relay-results
- **CHECK:** FS114-N4-D has a row (it is in the Lean order), and its handoff says: none — superseded in scope by FS114-Y4-RSTOPALL; kept as the proof side's route
- **CHECK:** SA1-6.3 item 6 names FS129-OA1-FALC-RED to formalize, and `plans/FS129-derivation.md` marks FS129-OA1-FALC-RED superseded
- **CHECK:** 92 order rows carry a stale address (the derivation files gained lines after the index was written); the backlog uses the current lines: plans/FS106-derivation.md: 1 rows, shifts 2..2; plans/FS111-derivation.md: 13 rows, shifts 2..6; plans/FS112-derivation.md: 25 rows, shifts 2..2; plans/FS114-derivation.md: 8 rows, shifts 2..8; plans/FS116-derivation.md: 45 rows, shifts 2..4
- **CHECK:** the `Rests on it:` prose of FS129-SR1-TWOCIRC names FS129-MR1-DOUBLETIP, but FS129-MR1-DOUBLETIP's `uses only:` does not reach FS129-SR1-TWOCIRC; the order puts FS129-SR1-TWOCIRC before FS129-MR1-DOUBLETIP anyway
- **CHECK:** the `Rests on it:` prose of FS129-SR3-OUTERADJ names FS129-MR1-DOUBLETIP, but FS129-MR1-DOUBLETIP's `uses only:` does not reach FS129-SR3-OUTERADJ; the order puts FS129-SR3-OUTERADJ before FS129-MR1-DOUBLETIP anyway
- **CHECK:** the `Rests on it:` prose of FS129-MR1-DOUBLETIP names FS129-SR3-EMPTY-NS and that of FS129-SR3-EMPTY-NS names FS129-MR1-DOUBLETIP; neither `uses only:` reaches the other; no order constraint taken from either
- **CHECK:** the `Rests on it:` prose of FS129-OR1-LOCALDENSE names FS129-SR2-DISC1TS and that of FS129-SR2-DISC1TS names FS129-OR1-LOCALDENSE; neither `uses only:` reaches the other; no order constraint taken from either
- **CHECK:** the `Rests on it:` prose of FS129-OR1-QFREE-CLASS names FS129-SR1-BENDANY, but FS129-OR1-QFREE-CLASS's `uses only:` reaches FS129-SR1-BENDANY (the two disagree on the direction); the order follows `uses only:`
- **CHECK:** the `Rests on it:` prose of FS129-SR2-QFCASE names FS129-SR3-QFREE-NS, but FS129-SR2-QFCASE's `uses only:` reaches FS129-SR3-QFREE-NS (the two disagree on the direction); the order follows `uses only:`
- **CHECK:** the `Rests on it:` prose of FS129-SR3-OUTERADJ names FS129-SR1-TWOCIRC, but FS129-SR3-OUTERADJ's `uses only:` reaches FS129-SR1-TWOCIRC (the two disagree on the direction); the order follows `uses only:`
- **CHECK:** the `Rests on it:` prose of FS129-SR3-QFREE-NS names FS129-SR1-BENDANY, but FS129-SR3-QFREE-NS's `uses only:` reaches FS129-SR1-BENDANY (the two disagree on the direction); the order follows `uses only:`

By hand, from reading the output:
- **CHECK:** ids written in a shortened form in a merge line and expanded to the entry the line's own audit names (`ALIASES` in the script; the lines' text is quoted as written): FS84-S1e → `FS84-S1-S1e` (SA1 § 6.3 item 1), "SR1's BENDANY" → `FS129-SR1-BENDANY` (SR2 § 4.3 item 13), "FALC-FAN", "DICHO-K" → `FS129-SA1-FALC-FAN`, `FS129-SA1-FALC-DICHO-K` (SA1 item 5), "EMPTY" → `FS116-Y4-EMPTY` (SR3 item 25).
- **CHECK:** names a merge line mentions that are no entry: `FS114-Y5-PXKILL` (SR1 § 6.2 item 1: "the identity steps inside FS114-Y5-PXKILL"), `FS114-Y5-PIN120` (SR3 item 27; inventory item 138 says it has no entry); "MA2's k = 4 note" (SA1 item 1) is a note in `plans/FS129-MA2-audit.md` § 2.3, not an id. None has a row.
- **CHECK:** inventory item 139 names "S1b-i, S1b-ii" (FS84-S1V's blind records): no entry has either id (`FS84-S1-S1b` and `S1b-47` are the nearest ids); item 139's governed rows are therefore J45-N1, -N2, -SI-4, -SI-5 and `FS84-S1-S1e` only.
- **CHECK:** `FS121-V5-FACE-SHARP` (SR1 item 6's form to formalize in place of FS121-D4-FACE's hypothesis), `FS114-Y6-E2RED` (SR3 item 27), `FS116-Y4-OBST` (SR3 item 24's consequence) and twenty more are named by the merge lines and are in neither the corrected order nor § Left the order; they stand in the last section so that the backlog has the form each line points to. The full list of that section is the 23 ids in § Named by a merge line or a caution (J45-* and X25B-* are SA1's "Upstream missing from the backlog's closure"; the inventory's item 139 names four J45 entries). This section is an addition beyond the brief's list; the coordinator may strike it.
- **CHECK:** the index (`theorems.jsonl`, 1,295 records) predates FS129-Z1's filings: the derivation files now hold 1,355 entries. The order's `needs` columns come from the index; FS-129's 32 compositions' upstream ids are read by the script from their `uses only:` and `derived from:` lines (a superseded form named there read as the form its handoff names; both lists shown), and an entry of the older order that rests on a lost theorem filed after the index (the J45-* family, X25B-*) carries no such edge.
- **CHECK:** the notes under entries that are not rows, and the two with no entry above, are in § Coverage below; none of them is a note under a row of the backlog.
- **CHECK:** every FS-112 row's `*Kernel:*` line reads "stub — with FS-114" as filed; FS112's errata-section item 8 says it now reads "with FS-116". The script points each such row to item 8 (quoted in § How to read) and does not edit the line.
- **CHECK:** the `Left` rows' *why* is the path in `edges.csv` as IX1 wrote it with each edge's fate in `edges-dropped.csv`; for FS111-M-HULL2, FS111-C-HULL-SO and FS121-D4-HOLE the README of the corrections' own lines about them are quoted too (5 lines). For the other 23 the README of the corrections says only that 26 left.

## Coverage — every dated note in the derivation files, and where the backlog puts it

(`python3 tools/fs129_l1_backlog.py --coverage`, saved as `data/fs129/l1/coverage.md`.)


| note | begins | filed under | in this file |
|---|---|---|---|
| `plans/ASTRA-2026-09-14-derivation.md:57` | *Erratum (2026-10-03, FS129-SA1; `plans/FS129-close-inventor | ASTRA-2026-09-14-T10 | yes, under ASTRA-2026-09-14-T10 |
| `plans/FS100-derivation.md:127` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SA1-audit. | FS100-T1 | no — entry is not a row |
| `plans/FS106-derivation.md:205` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR2-audit. | FS106-EQ | yes, under FS106-EQ |
| `plans/FS107-derivation.md:160` | **Erratum, 2026-09-28 — FS-111's close (job FS111-C), to FS1 | — | no — no entry above it |
| `plans/FS110-derivation.md:210` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-MR1-audit. | FS110-A3-HOLE | no — entry is not a row |
| `plans/FS111-derivation.md:455` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit. | FS111-M-PINCH | yes, under FS111-M-PINCH |
| `plans/FS111-derivation.md:501` | *Correction (2026-10-03, FS-121's close; FS121-DB1 § 3.3 ite | FS111-W-NOREP | yes, under FS111-W-NOREP |
| `plans/FS111-derivation.md:503` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR2-audit. | FS111-W-NOREP | yes, under FS111-W-NOREP |
| `plans/FS111-derivation.md:553` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR2-audit. | FS111-M-COVER-SC | yes, under FS111-M-COVER-SC |
| `plans/FS112-derivation.md:53` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit. | FS112-SIX | yes, under FS112-SIX |
| `plans/FS114-derivation.md:255` | *Erratum (FS116-O1, 2026-09-29): the model line said the str | FS114-N2-ENDS | yes, under FS114-N2-ENDS |
| `plans/FS114-derivation.md:277` | *Erratum (FS116-O1, 2026-09-29): the model line changed with | FS114-N3-JOINT | yes, under FS114-N3-JOINT |
| `plans/FS114-derivation.md:619` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR2-audit. | FS114-Y3-RSTOP | yes, under FS114-Y3-RSTOP |
| `plans/FS114-derivation.md:663` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit. | FS114-Y5-PINALL | yes, under FS114-Y5-PINALL |
| `plans/FS114-derivation.md:702` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit. | FS114-Y6-E2RED | yes, under FS114-Y6-E2RED |
| `plans/FS114-derivation.md:746` | *Erratum (FS116-Z2, 2026-10-03; FS-116's close, `plans/FS116 | FS114-N7-3T | yes, under FS114-N7-3T |
| `plans/FS114-derivation.md:820` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit. | FS114-K1 | yes, under FS114-K1 |
| `plans/FS116-derivation.md:818` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit. | FS116-S1-KAPPA | yes, under FS116-S1-KAPPA |
| `plans/FS116-derivation.md:1749` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR1-audit. | FS116-Y4-EMPTY | yes, under FS116-Y4-EMPTY |
| `plans/FS116-derivation.md:1888` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit. | FS116-C114-LOCAL-F | no — entry is not a row |
| `plans/FS38-derivation.md:142` | **Correction (FS-86's close, 2026-09-25; found by FS-86's B2 | FS38-L1 | no — entry is not a row |
| `plans/FS81-derivation.md:101` | > **Correction owed (2026-09-25 crunch):** see `plans/FS91-S | FS81-T6 | no — entry is not a row |
| `plans/FS86-derivation.md:65` | > **Correction owed (2026-09-25 crunch):** see `plans/FS91-S | FS86-B1-LR | no — entry is not a row |
| `plans/FS86-derivation.md:416` | > **Correction owed (2026-09-25 crunch):** see `plans/M3-S1D | FS86-CL1 | no — entry is not a row |
| `plans/FS89-derivation.md:23` | > **Correction owed (2026-09-25 crunch):** see `plans/FS91-S | — | no — no entry above it |
| `plans/FS89-derivation.md:32` | *Erratum (2026-10-03, FS129-SA1, from FS91-J03a-9 and FS91-J | FS89-S0A-2, FS89-S0A-10, FS89-CL2 | yes, under FS89-S0A-2, FS89-S0A-10, FS89-CL2 |
| `plans/FS89-derivation.md:91` | > **Correction owed (2026-09-25 crunch):** see `plans/FS91-S | FS89-S0A-10 | yes, under FS89-S0A-10 |
| `plans/FS89-derivation.md:326` | > **Correction owed (2026-09-25 crunch):** see `plans/FS91-S | FS89-CL2 | yes, under FS89-CL2 |
| `plans/FS89-derivation.md:332` | *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SA1-audit. | FS89-S0A-2, FS89-S0A-10, FS89-CL2 | yes, under FS89-S0A-2, FS89-S0A-10, FS89-CL2 |

attached to a row: 20; under an entry that is not a row: 7; no entry above: 2


## Five rows of the output beside their source

Chosen by `random.Random(129).sample(<the 259 row ids in file order>, 5)`; the left block is the row's statement as `plans/LEAN-BACKLOG.md` holds it (read back by the script's own block parser), the right block the entry's own lines in the derivation file (ten lines at most; the script folded the wrapped `statement:` lines into one).


#### FS116-V5-DICHO — `plans/FS116-derivation.md:1572`

**In `plans/LEAN-BACKLOG.md` (statement block):**

> in V5-QCOL's setting, if both germs of one pair at y lie on (Q) arcs A₁, A₂ with colour pairs Π₁, Π₂, then Π₁ = Π₂ (and then the inner colour of each is the outer colour of the other) or Π₁ ∩ Π₂ = ∅

**In the source (the entry's own lines, as `sed -n` prints them):**

```
derivation: FS116-V5-DICHO
  statement: in V5-QCOL's setting, if both germs of one pair at y lie on (Q) arcs A₁, A₂ with colour pairs Π₁, Π₂, then Π₁ = Π₂ (and then the inner
    colour of each is the outer colour of the other) or Π₁ ∩ Π₂ = ∅
  uses only: V5-QCOL, V5-U1 at p, V5-NE1; simple (one sector per tile at p) and the four tiles of p
  not claimed: that either case occurs
  argument: FS116-V5-verification.md § V5-DICHO's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known
```

#### FS111-C-HULL — `plans/FS111-derivation.md:267`

**In `plans/LEAN-BACKLOG.md` (statement block):**

> in a tight a.e.-proper k-colouring in D-NF, for C ⊆ S̃_j path-connected and x ∈ A*_j, either |x − c| < 1 for every c ∈ C or |x − c| > 1 for every c ∈ C; the form with sup_{c∈C}|x − c| < 1 or dist(x, C) > 1 holds when C is compact

**In the source (the entry's own lines, as `sed -n` prints them):**

```
derivation: FS111-C-HULL
  statement: in a tight a.e.-proper k-colouring in D-NF, for C ⊆ S̃_j path-connected and x ∈ A*_j, either |x − c| < 1 for every c ∈ C or |x − c| > 1
    for every c ∈ C; the form with sup_{c∈C}|x − c| < 1 or dist(x, C) > 1 holds when C is compact
  uses only: I-D1 in V0's form (FS111-V0-ID1: |x − c| ≠ 1 for c ∈ S̃_j, x ∈ A*_j); continuity of c ↦ |x − c| on a path-connected C
  not claimed: A*_j ⊆ {x : sup_{c∈C}|x − c| < 1} ∪ {x : dist(x, C) > 1} for non-compact C — refuted (FS111-C-HULL-SO)
  argument: FS111-V0-verification.md § 2.8
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: the same interval argument; M re-derived it sighted (M-HULL1)
  model: the tight hexagonal seven-colouring, C a hexagon's interior, x a point of another hexagon
```

#### FS129-SR3-E2ONE — `plans/FS129-derivation.md:874`

**In `plans/LEAN-BACKLOG.md` (statement block):**

> in a non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about p, with a pinwheel at p, no edge at p of length 60° (no E1) and E2 at exactly one blade t_{c+1}, the pocket colours satisfy m_{c−1} ≠ m_c; hence POCKET at w_c and CASE at q_c hold, and no such pinwheel exists at radius 1 + ε; in particular FS114-Y6-E2RED's survivor family S6, (120°, b, 180° − b, 60°), has no member

**In the source (the entry's own lines, as `sed -n` prints them):**

```
derivation: FS129-SR3-E2ONE
  statement: in a non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about p, with a pinwheel at p, no edge at p of
    length 60° (no E1) and E2 at exactly one blade t_{c+1}, the pocket colours satisfy m_{c−1} ≠ m_c; hence POCKET at w_c and CASE at q_c hold, and no
    such pinwheel exists at radius 1 + ε; in particular FS114-Y6-E2RED's survivor family S6, (120°, b, 180° − b, 60°), has no member
  uses only: FS114-Y5-ALT at the three pairs (μ_c, μ_{c+1}), (μ_{c+1}, μ_{c+2}), (μ_{c+2}, μ_{c+3}) — each needs only all edges below 60° and no E2 at
    t_{c+2}, t_{c+3}, t_c respectively; that each pocket colour m_j is one of the two colours absent at p (FS114-Y5-MU's setting: pocket tiles lie
    inside B(p, 1) and are not tiles of p); FS114-Y6-E2RED's chain clause (E2 at t_{c+1} breaks only ALT(μ_{c−1}, μ_c), which only POCKET at w_c reads,
    which only CASE at q_c reads — two readings, FS114-Y6's and YB5's blind one); FS114-Y5-PINALL's chain outside E1 and E2 (POCKET, CASE, REDUCE,
    PIN120-60, PXKILL), whose use of "no E2" is ALT alone (YB4 item 11, YB5 item 6)
  not claimed: E2 at two or more blades (two broken ALTs leave the parity free: plant --fault-two); E1, with or without E2 (E1 breaks MU at its edge,
```

#### FS116-S1-CLUSTER — `plans/FS116-derivation.md:838`

**In `plans/LEAN-BACKLOG.md` (statement block):**

> in a valid k-coloured fragment, for any k, Siamese pairs allowed, let 𝒯 be a finite family of tiles of one colour c the union of whose closures is connected, and U a tile of colour c; if some point of that union is at distance below 1 from some point of cl U, every point of the union is at distance at most 1 from every point of cl U

**In the source (the entry's own lines, as `sed -n` prints them):**

```
derivation: FS116-S1-CLUSTER
  statement: in a valid k-coloured fragment, for any k, Siamese pairs allowed, let 𝒯 be a finite family of tiles of one colour c the union of whose
    closures is connected, and U a tile of colour c; if some point of that union is at distance below 1 from some point of cl U, every point of the
    union is at distance at most 1 from every point of cl U
  uses only: validity; tiles are open and connected; the distances between two tiles form an interval; no point is at distance exactly 1 from every
    point of an open set
  not claimed: anything for an infinite family; that the tiles of 𝒯 are pairwise near
  argument: FS116-S1-proof.md § 2.3 Clusters (FS116-S1-CLUSTER) and the rung (FS116-S1-RUNG); STRIPCEIL recovered
  verdict: derived
  grade: hand
```

#### FS121-O1-ENDS — `plans/FS121-derivation.md:20`

**In `plans/LEAN-BACKLOG.md` (statement block):**

> in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius ends, off a null set of normals, at a unit arc J_1 whose centre z carries J_1's outer colour; either z also carries J_1's inner colour — J_1 is of kind both and z is a vertex with at least four colours or a repeated colour, at least four when no colour at z has density 0, so J_1 is (Q) — or it does not — J_1 is (R2), and z is a point of Σ carrying at least three colours counted by sector — the outer colour and at least two further sectors of positive angle — and at least three distinct colours when no colour at z has density 0

**In the source (the entry's own lines, as `sed -n` prints them):**

```
derivation: FS121-O1-ENDS
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius ends, off a
    null set of normals, at a unit arc J_1 whose centre z carries J_1's outer colour; either z also carries J_1's inner colour — J_1 is of kind both
    and z is a vertex with at least four colours or a repeated colour, at least four when no colour at z has density 0, so J_1 is (Q) — or it does not
    — J_1 is (R2), and z is a point of Σ carrying at least three colours counted by sector — the outer colour and at least two further sectors of
    positive angle — and at least three distinct colours when no colour at z has density 0
  uses only: FS111-M2-INTRAD steps (1)–(2) (the chain toward the centre stops at radius 1 or at Σ); FS111-M-PINCH's two types; C-HULL's first clause;
    FS112-N3-NOBOTH's sector argument with N112-U1's cones; FS121-DB1-L3 for the no-repeat step (FS111-W-NOREP, which the first derivation cited, does
    not reach a centre whose neighbours at distance 1 carry cusps); FS111-M-HALF; no colour count
  not claimed: that every chain ends at a (Q) arc; that an (R2) end exists in any saturated colouring; that an (R2) centre has four colours; that the
```



## Expectations and what I did not do

- What the first runs found, which I had not expected: the statements, errata and merge notes agreed with their sources by both routes from the first full run, but the check failed on the order's addresses (stale by two to eight lines in 92 rows, because FS129-Z1 filed errata under earlier entries after the index was written), on merge lines that name entries by abbreviation, and on an older-grammar entry whose header wraps lines. All three are handled above; no expectation was registered beforehand.
- Not done: no merge line was paraphrased; no cell was filled from prose; no entry was graded; the 78 seeds were not re-judged. Nothing here ran a search or a Lean build.
