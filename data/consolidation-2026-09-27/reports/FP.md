# Job FP — the consolidation run's front page: report to the owner

*Job FP of the consolidation and library run, 2026-09-27 (de Bruijn, Opus 5.5). Record: `data/consolidation-2026-09-27/fp/record.md` (stages 1–5,
all SAVED; commits c28c5886, f8749cb9, 90964cb3, d2df03c1, 990cf9f5). The job took the drafts that the reading jobs (LP, LV, LW, LW2, LW3)
wrote for the project's front files — the summary file `CLAUDE.md`, the results ledger, the file of questions answered, the bibliography,
the milestone stubs — checked every quotation that had only one reader against its printed page, and applied them. Nothing here moves the
answer to the Hadwiger–Nelson problem. It changes what the files credit to others, and it records which questions were already posed in print.*

## What landed

| file | what changed |
|---|---|
| `CLAUDE.md` | **295,835 → 296,956 bytes** (+1,121; the ceiling is 300,000). LV's corrected drafts D-1 to D-7, as accepted (item 24). § The aim, link 2: its argument is in print (Gwyn–Stavrianos 2022); link 2 uses choice only in de Bruijn–Erdős (**worded as a reading, one mind**). Paths forward: FS-112's row (its question posed in print, one exact known positive, the tactic measured), FS-109's (a second dial, X₆), FS-108's and FS-102's (LV's D-7, D-4). G81: the Soifer–Shelah translate graphs. G56's status tag carries the bridge's new credit |
| `WORKFLOW.md` | 3.2 item 8, one sentence only: the two Johnson surveys cite `[Fischer1994]` and restate its value, and are not in OpenAlex either, so "no **database** citation walk can arrive at it" |
| `LEDGER.md` | Prior-art sentences of rows 106, 130, 131, 132, 134; row 59's **Open:** clause (LV-T3 in `ℚ⁴`, now that LX gave it a blind second derivation). No row renumbered |
| `CLOSED-QUESTIONS.md` §3 | The absoluteness entry gains its print addresses (Shelah–Soifer 2003b p. 45, Soifer 2007 p. 86). Four new entries: Gwyn–Stavrianos's Conjecture 1 (answered at [hand] in its Definition-13 form); Kainen's 1992 robustness conjecture (reduced to `χ(ℝ²) = 7`, not answered); Polymath 2021's question (FS-112's own, answered only in the complementary direction by row 134); Erdős's band question (closed by others) |
| `BIBLIOGRAPHY.md` (outside § G) | Copy and read-status cells for 15 entries, with § B and rules 0d/0e kept in step. Four listing-only § C rows from Soifer 2003's references. `[Johnson1982]` left to LX |
| stubs | FS-112 (a banner with the four re-aims; its "a YES by formula (0.03)" flagged for re-registration at the opening, **not re-registered**); FS-111, FS-109, FS-102, FS-20, FS-104 (Johnson 1994's question and the Graham problem are recorded there). `plans/FRONTIER-STUBS.md` ranks 1, 4, 5, 17: row text only, **no rank moved** |
| other | `plans/FS103-derivation.md` FS103-M-EASY's prior art; `plans/GROKKING-INSTANCES.md` §G49, the consolidation run's instance; one reviewed ALLOW line in `tools/claude_md_fact_audit.py` |

## Quotations: two drafts misquoted their sources, both corrected

| draft | what it said | what the page says | fix |
|---|---|---|---|
| LW2's `CLAUDE.md` row for FS-112 | "'eliminate the unit-radius tactic'", in quotation marks | `[Polymath2021]` p. 199: "It may be possible to eliminate criterion (ii) …" and "(ii) the unit-radius tactic is employed". The quoted phrase is not in the paper | Carried as the two verbatim fragments |
| LW3's quotation of `[Johnson1994choice]` p. 125 | "[...] if c(H) ≤ k for every finite subgraph H of G, then c(G) ≤ k" | "That is, if G is an infinite graph, k is a positive integer, and c(H) ≤ k …". The elision sits between "if" and "c(H)", so the quoted "if" was not followed by those words | Carried as the full sentence |

Every other single-reader quotation checked out word for word against its page: Kainen pp. 34–35; Hoffman–Soifer p. 38; Soifer's X₆ pp. 140–141;
Brown–Dunfield–Perry p. 113; Parts 2021 pp. 181–182; Soifer 2019 p. 213; Parts 2020c pp. 34 and 37; Axenovich et al. Thm 4.2; Johnson 1994
p. 124; Shelah–Soifer 2003b pp. 42, 43 and 45; Soifer 2007 p. 86; Kuperberg's question in Johnson 2018, p. 90; the Polymath16 wiki's Theorem 20.
One draft was also narrowed on scope. Brown–Dunfield–Perry's six for every band comes "from the proof of Theorem 9", not from Theorem 9's
statement, and row 132 now says so.

## Decisions I made (each: the choice · the alternative I weighed · why · confidence)

| choice | alternative | why this one | confidence |
|---|---|---|---|
| **Posed questions that no row answers go to the stub they bear on, not to `CLOSED-QUESTIONS.md`.** X₆ and the almost chromatic number go to FS-109, the Graham problem to FS-104, and Kuperberg's 2 × n question to its bibliography entry only | Add them to §3 as LW2 drafted | Your ruling on Johnson 1994 ("which lists questions our rows answer"), applied to all of them the same way | high |
| **Polymath 2021's question stays in `CLOSED-QUESTIONS.md` §3** (and in FS-112's banner) | Keep it in the stub only | It is FS-112's question as posed in print, and FS-112 is the next milestone. §3's own rule (b), "unusually well placed to find one", fits it, and §2.8 already points at FS-112 for the same half | **medium** — if you want §3 limited to questions some row answers, one bullet moves to the stub |
| **Link 2's prior art is credited to the argument, not the theorem.** It reads: "its argument is in print (Gwyn–Stavrianos Lemma 2, Thm 2, under an invariant mean; the Haar-average line unprinted, row 130)" | LW2's "… Thm 2, from which it follows with Haar averages" | LW2's own second reading says that for an arbitrary invariant mean, link 2 does not follow from Theorem 2's statement. Its draft could be read the other way | high |
| **Row 131: the step from a refutation to `χ(ℝ²) ≤ 6` is credited to link 2's argument run with Haar averages**, not to Theorem 2 under any invariant mean (LW's draft) | Keep LW's wording | GS's own Theorem 3 (p. 14) makes a periodic colouring's badness a finitely additive measure that need not be Haar. So "badness at most twice the hole density" is proved for Haar averages only | high |
| **Row 59's LV-T3 clause is applied, not held** | Leave it for you, with item 28 | The condition LV set ("a second reader") is met by LX's blind derivation (item 27). The clause states the law, not the corollary LX found mis-scoped | medium-high |
| **`[GwynStavrianos2022]` is not moved into § A** (LW's draft) | Add a second bold row in § A | Its defining row is in § G, which this job may not edit, and § G's rule is "cited here, not redefined". The move needs both edits made together | high; left to you |
| **G81's new clause says "two readers: LW3, FP"** | Leave it at LW3's one mind | I checked the argument: a class of positive measure meets its own translate by some `ε + q` near 0 in positive measure | high |

## Declined, with the reason

- **LP's fold of the fractional sandwich into row 129.** Both LP and LV defaulted to keeping it in `CLOSED-QUESTIONS.md` §3, and it stays there.
- **LW's `CLAUDE.md` drafts** (link 2, and the disk as a second known positive). LW2 superseded them: the disk prints no coordinates.
- **LW/LW2's § B lines for the new issue files.** Already done: § B's Geombinatorics paragraph points at § G.
- **LW3's new `CLOSED-QUESTIONS.md` entry for Johnson 1994.** Moved to FS-104's banner, by your ruling.

## For you, ranked

1. **Apply run-record item 28** (LV-T3's entry in `CLOSED-QUESTIONS.md` §3: grade it two minds, one blind, and scope the corollary to realised `d`). I have finished with the file. **Default if nothing is done:** the §3 entry keeps "one mind" and the mis-scoped corollary, while row 59 already cites LV-T3 at two minds.
2. **Move `[GwynStavrianos2022]` into § A**, un-bolding its § G row in the same edit. **Default:** it stays defined in § G only, which is correct for the audit, but a load-bearing prior-art key then lives outside § A.
3. **Johnson 1994's question may already be answered, by one standard fact.** *A reading, one mind (FP), in no front file:* the hypercube `Q_k` is a unit-distance graph in the plane (the Minkowski sum of `k` unit vectors in general position), and its minimum degree is `k`. If Alon's lower bound on choice numbers by minimum degree holds as I recall it (`ch(G) ≥ (1/2 − o(1)) log₂ δ`; recalled, unread: N. Alon, *Degrees and choice numbers*, 2000), then the plane's choice number is infinite. FS-104's item (1) would then need the lists' origin, as LW3 said. **Killing test:** read Alon's paper; the recalled bound failing for bipartite graphs of large minimum degree would kill the reading. **Default:** it stays LW3's "check first" debt in FS-104's banner.
4. **`CLAUDE.md` is at 296,956 bytes.** Its headroom is 3,044 bytes.

## Gates (each exit status read directly, output to a file, never through a pipe)

| gate | result |
|---|---|
| `python3 tools/claude_md_fact_audit.py --base cc0881df` | **exit 0**, AUDIT PASSED: 0 failures, nothing lost in any class, no dangling pointer. One ALLOW line added, with its reason. G56's status tag changed because the bridge's credit moved to Benda–Perles (the audit reads a tag up to its first `]`) |
| `python3 tools/claude_md_fact_audit.py --dupes` | **exit 0**; 10 repeated runs, the base's count. My first pass made it 12, both repeats in my own §G49 instance; I replaced them with pointers |
| `python3 tools/fs71_ledger_b_check.py --strict` | **exit 0**, PASS (947 rows) |
| `python3 tools/bib_audit.py` | **exit 0**, every cited work resolves |
| `python3 tools/check_architecture.py` | **exit 0**, PASS |
| `python3 data/rerank-2026-09-27/rk_mirror_check.py` | **exit 0**, PASS |

Theorems this job proved: none. One second reading is recorded (G81's clause).
