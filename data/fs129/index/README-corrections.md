# The index — notes and corrections (FS129-Z2, 2026-10-03)

*Written by FS129-Z2, the record job's second part, beside FS129-IX1's `README.md`, which it does not edit. Read this file with the README:
it says which of the index's files to cite, which figures stated about the index have been withdrawn, and where its counts are upper bounds.*

## 1. Which files to cite

- **The corrected graph.** `edges-corrected.csv`, `hubs-corrected.md`, `roots-corrected.md`, `cycles-corrected.md`, `lean-order-corrected.md` and
  `vacuity-corrected.md` are written by `python3 tools/fs129_z2_index.py` from `edges.csv` and `theorems.jsonl` as IX1 wrote them, with the
  readers' edge sorts applied (FS129-SR1 § 4.1, 26 edges; FS129-SR2 § 2.3, 23; FS129-SA1 § 4.3, 9 plus the two correction edges into FS89-CL2) and
  two defects of item 111 repaired by rule. Edge by edge, with the reason: `corrections.md`; the dropped edges: `edges-dropped.csv`. Cite the
  `-corrected` files for any count of dependents, any chain, any cycle and the Lean order; the originals stay as the record of what IX1's run read.
- **The corrected counts** (the script's summary line): edges 1,330 → 1,315 — 44 dropped (35 false, 9 reversed), 16 kept and marked (9 `route`,
  7 `real`), 29 added (2 `reversed-fix`, 13 `range`, 14 `prefix`); dependency cycles 45 → 30 (lane R's 17 → 2: {FS114-N7-3T, FS114-N7-HUB} and
  {FS116-V5-LENS, FS116-Y3-SIX, FS116-Y3-TIPS}); the Lean order 197 → 178 entries on every kept edge, 166 on first routes (route edges left out);
  the readers' sorts alone give 171, FS129-SR2's printed figure, reproduced. 26 entries leave the Lean order and 7 join it (FS110-N3-CONF, -N3-DEG,
  -N4-FIN, -N4-SHADOW, -N4-SHAVE, -N4-STUCK, -W-MERGE — through `prefix` edges into FS114-CV-EXISTS and FS114-CV-HD).
- **Item 63's GAP lines (FS-129 item 132).** `data/fs129/sr2/item63-gap-lines.md` is the output of `tools/fs129_sr2_gaps.py --fault`, because that
  tool's fault run writes the same file as its clean run (36 table lines, against 29 in the clean list). Cite
  `data/fs129/sr3/item63-gap-lines-clean.md`, the clean run's list (FS129-SR3).

## 2. Figures withdrawn

Each was stated from the uncorrected graph; the corrected value replaces it.

| figure | where it was stated | corrected |
|---|---|---|
| "the longest chain of dependents has 13 edges, from FS111-V0-ID1 or FS111-C-HULL-SO to FS121-Z1-NOCURVED" | inventory item 18; `roots.md` ranks 1–2 | the longest chain has **10** edges, from FS112-U1 or FS112-A4SIX to FS116-C114-LOCAL-F (`roots-corrected.md` ranks 1–2); FS111-V0-ID1's longest chain has 9 (rank 3), and it is still the top hub (83 transitive dependents) |
| FS111-C-HULL-SO is the rank-2 root and rank-2 hub, 78 dependents | `roots.md`, `hubs.md` | **0** dependents: its one edge (to FS111-C-HULL) is false — "the corrected form is …" from a refuted entry (FS129-SR1 § 4.1) |
| FS121-D4-HOLE has 60 (or 61) transitive dependents and tops `vacuity.md` | inventory items 35, 99; `vacuity.md` § 1; `hubs.md` rank 6 | **0**: its one edge (to FS111-M-PINCH) is false — "it crosses with FS111-M-PINCH" (FS129-SR1 § 4.1). The top of `vacuity-corrected.md` is FS116-N1-QFREE4 (19), unchanged |
| FS111-M-HULL2 rank-4 root and hub (63 dependents) | `roots.md`, `hubs.md` | it left both top-100 lists and the Lean order: its 63 came through the false cycle {FS111-M-PINCH, FS121-D4-HOLE} |
| FS91-J01-3 a rank-45 root (depth 7) | `roots.md` | exists only through the false edge FS91-J01-3 → FS91-J01-2 (FS129-SA1 § 4.3); off the corrected top 100 |
| "87 of `roots.md`'s 100 are lane R" | inventory item 19 | 72 of `roots-corrected.md`'s 100 are lane R, 28 lane A; of the hubs, 66 R and 34 A (`hubs.md`: 90 and 10) |
| "lane-R cycles 17"; "7 cycles in the Lean order" | FS129-SR1's tool line; inventory item 99 | lane-R cycles 2 (above) |

## 3. Upper bounds and homonyms (FS-129 item 90; `plans/FS129-MA2-audit.md` § 4.2)

- **A grokking's mention count is an upper bound.** `grokking-uses.md` counts the token `G<n>` anywhere in an entry's text. Of the mentions of
  G1–G4, the lane-R ones (G1 6, G2 3, G3 5, G4 3) and FS-89's "G1" and "G2", FS-56's "G27" and M49's "G31" are other objects named G-something
  (FS-106's `[G2]`, `[G3]` labels; FS-125's open places G1–G3) — so in these entries the count is mostly homonyms, and item 51's majority rule
  assigned G2 and G3 to lane R on them (corrected by item 83).
- **Roots attributed to grokkings**: the lane-A roots FS129-MA1 attributed to G74 and G77 are FS-89's and FS-91's band-character chains, G76's;
  G74 enters only through FS89-S0A-2's layer gluing.
- **"gap" is not always an open step** (FS-129 item 44): at least 158 of `open-steps.md` § 4's 418 lowercase "gap" lines use the word in row 66's
  fan-gap sense.

## 4. Defects of item 111, repaired or listed

- **Range citations** ("CL3–CL5", "T22–T25") lost their middle members: the tokenizer read the two ends. Repaired by rule (13 `range` edges): a
  middle member is added when both ends and the member resolve by IX1's own tiers.
- **Milestone prefixes.** (a) The no-entry lookup (`checks.md` § "Ids that appear in no indexed entry") did not try a milestone prefix: 16 of item
  20's 68 ids are filed as `FS100-X27D-*`, `FS100-X28D-*`, `FS106-TS-L1`, `R88-TC-tab`, `FS89-D0-T1`, `FS89-D5-L2` (listed in `corrections.md`;
  FS100-X28D is not lost). (b) The same defect in the graph: a hyphenated id written without its prefix in a `uses only:` line (`C-HULL`,
  `M-PINCH`, `W-EQ-K`) was left as a suffix candidate. Repaired under a strict rule (14 `prefix` edges: exactly one candidate, in `uses only:` or a
  `derived from:` grade, the candidate's milestone not later than the citing entry's); the other 183 suffix candidates stay unresolved, listed in
  `corrections.md` § Suffix candidates for a reader.
- **"Rests on it: nothing …" read as edges** (items 77, 99, 118): sorted by the readers and applied (above). Four lane-A records whose Rests-on-it
  holds "none" or "nothing" mid-sentence (FS50-T2, FS66-L6, FS91-J08-5, MASCOT-T1) carry real edges and are unchanged (FS129-SA1 § 4.3).
