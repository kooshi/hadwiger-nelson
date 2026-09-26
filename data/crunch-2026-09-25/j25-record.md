# J25 — the final front-page batch, and the crunch's close (record)

*De Bruijn (Opus 5.5), 2026-09-26, crunch job J25, under `data/crunch-2026-09-25/briefs/J25-final-batch-and-crunch-close.md` (template
`J44-front-page-row88-FS67.md`) and `STANDING-RULES.md`. HEAD at launch: `82dd14f8`. Touch list: the brief's "Rules"; no job record, Poros
record, verification record or Lean file is touched.*

## Theorems this phase proved

None — a front-page pass and a queue close apply and score; they prove nothing.

## Would have searched here

None — bookkeeping and editing only.

## Stage 1 — SAVED (quotation check; gates at launch; the edit list)

### 1.1 Quotation check (standing rule 5)

| # | in the brief | source | result |
|---|---|---|---|
| Q1 | "`m₁(ℝ²) ≤ 0.246989 < 0.2470` [cert + hand]" | `data/crunch-2026-09-25/reports/J49.md` INVENTORY 1: "m₁(ℝ²) ≤ 0.246989 < 0.2470 now [cert + hand]" | verbatim |
| Q2 | "about 640,000 points" becomes 493,471 distinct points | `plans/FS100-KT1-ambrus-ball.md` §3.3: "§3.2's 'the value of `J₀` at about 640,000 points …' … the covering has **493,471** distinct points (about 646,000 evaluations …)" | agrees |
| Q3 | "J26-T1's 'not interval-certified' is superseded by J49-T1/T2" | same §3.3: "J26-T1's 'H4 in double precision (… not interval-certified …)' … superseded by J49-T1/T2" | agrees |
| Q4 | "the *Prior art:* / grade fields of FS86-Cx-C14 and FS86-CL1"; "the R88 entry that cites it" | J49 §3.3: "`plans/FS86-derivation.md` FS86-Cx-C14 and FS86-CL1, `LEDGER.md` § B's C14 line, `plans/R88-derivation.md` line 88" | agrees (R88's entry is the inputs paragraph at line 88) |
| Q5 | "row 92 and row 112" | J49 §3.3 names row 92; J49's report INVENTORY 4 names "row 112" too | agrees |
| Q6 | J48 "found BC-1 to BC-8 all TRUE, blind, with no difference of truth" | `reports/J48.md`: "BC-1..BC-8 all TRUE … blind, no difference of truth" | agrees |
| Q7 | "T-J39-3 step 5 needs Lemma C and is repaired by a finite-index coset extension (the ℚ(√5) exception)"; "T-J39-5 (ii) drops the hypothesis on 43's ratio"; "T-J38-3 says 'per R-coset'" | `plans/FS100-BC-verification.md` §3.4 items 1, 2, 4 | agree; item 4 also asks to flag the one-mind class forms outside ℚ(√47) and type (B) — carried |
| Q8 | "MR(F) ⟹ χ(F²) ≥ 5 for every totally real F with N₄(F) = ∅" | J48 §2.4, J48-N4cor: "For every totally real `F` with `N₄(F) = ∅` … MR(F) ⟹ `χ(F²) ≥ 5`" | verbatim in substance (J48's words kept in the stub) |
| Q9 | "Register the prior for MR (X-MR), which no record gives, as 'unregistered: the FS-100 planner registers it at stage 0'" | FS-100 stub §4, X-MR: "**unregistered**: the opening registers one …"; J47's report: "X-MR's prior unregistered anywhere" | agrees; the wording is the brief's |
| Q10 | FS-59: "the wording from post-close inventory row 42 verbatim" | row 42: "refusing five at ℚ(√167) (χ ≥ 6) needs χ_CP(ℝ²) ≥ 6 modulo MR, PL(23,43), FS-69; FS-59's own χ ≥ 5 waits only on MR (T-J39-4)" | used verbatim |
| Q11 | FS-96: "J39's R3" | `plans/POROS-2026-09-25-wanted-poster-167.md` line 349: "(i) for existence the places are `{∞, 23, 43}`, modulo SP (the split places drop out, T-J39-1); (ii) GAP-1 does not arise in the CP format; (iii) GAP-2 is PL(23, 43), FS-67's Hedetniemi question in CP form (rows 114–115); (iv) its payoff is T-J39-5" | used verbatim |
| Q12 | "FS-97 is absorbed into FS-100 (owner ruling on J47's proposal)" | FS-100 stub §9: "This stub proposes that FS-97 be absorbed into FS-100 … Held for the owner" | agrees; the ruling is the brief's |
| Q13 | post-ban stages: FS-84's own; FS-90 (Y1); FS-64 (Y2); J37's R4 (EI-F); FS-67's PB-2; FS-100's P1 | Y1, Y2: `plans/FS86-row88-rigidity.md` §S.3 table and `plans/FS86-row88-close-inventory.md` rows 52–53 (Y2 is "χ_f(ℚ(√59)²) = 4 by an exact LP", FS-64's row); PB-2: `plans/FS67-tight-products.md` line 640; P1 = J37's R4: FS-100 stub §6.4; FS-84's S2–S4: `plans/FS84-five-colours-47.md` §4.2 | all exist; J37's R4 and FS-100's P1 are **one** stage (the stub: "P1 — J37's R4") — listed once in §8 |
| Q14 | in-ban work left: FS-100 stages 0, 3, 4 (Kronecker selection, after the crunch per Kooshi), 5 and 6 | FS-100 stub §6 table; handoff §6: "Kronecker selection = FS-100 stage 4, after the crunch" | agrees |
| Q15 | "`--dupes`: 13 or fewer" | at launch: 13 (below) | agrees |

### 1.2 Gates at launch (HEAD `82dd14f8`; each exit read directly)

| gate | exit | verdict |
|---|---|---|
| `tools/claude_md_fact_audit.py --base 82dd14f8` | 0 | AUDIT PASSED (0 failures) |
| `--dupes` | 0 | 13 repeated runs, 910 bytes |
| `tools/bib_audit.py` | 0 | every cited work resolves |
| `tools/fs71_ledger_b_check.py --strict` | 0 | PASS (714 entries, 714 § B rows) |
| `tools/check_architecture.py` | 0 | PASS |

`CLAUDE.md` at launch: **295,923 bytes** (J44 left 294,994; J47's FS-100 row added the rest).

### 1.3 The edit list

- **Stage 2 — the Ambrus upgrade (A.1):** `LEDGER.md` rows 92, 112 and § B's FS86-Cx-C14 line; `plans/FS86-derivation.md` FS86-Cx-C14 and
  FS86-CL1 grade brackets; `plans/R88-derivation.md` line 88; `BIBLIOGRAPHY.md` `[AmbrusEtAl2023]`'s role; `plans/PA-ambrus2023-audit.md`'s two
  corrections. `CLAUDE.md` names no grade for the Ambrus input (it cites the paper only in the prior-art list, for the fractional blow-up):
  nothing to upgrade there.
- **Stage 3 — FS-100 and the re-aims (A.2, A.3):** the FS-100 stub (stages 1–2 done, J48's corrections, T-J39-4 on two routes, J48's
  corollary, X-MR's wording, FS-97 absorbed); FS-59 (row 42 verbatim), FS-96 (J39's R3), FS-97 (banner); `plans/FRONTIER-STUBS.md` and
  `CLAUDE.md` § Paths forward.
- **Stage 4 — the inventory and the index (A.4, A.5).**
- **Stage 5 — the crunch's close (Part B):** the queue's banner, §2 statuses, §8.
- **Stage 6 — gates, report.**

## Stage 2 — SAVED (the `[AmbrusEtAl2023]` grade upgrade, brief A.1)

Applied by `data/crunch-2026-09-25/j25/apply_ambrus.py`, every anchor asserted at its expected count before anything is written (plant — an
anchor no file holds — fired first, exit 1, nothing written; a re-run refuses, exit 1). The new grade reads as J49 §3.3 proposes, with the
brief's number: "cert + hand: `m₁(ℝ²) ≤ 0.246989 < 0.2470` — exact on H1–H3 and H6 (J26), ball arithmetic on H4 and H5 (J49); Watson §13.74 and
§15.31 cited".
- `LEDGER.md`: row 92's grade bracket; row 112's input list; § B's FS86-Cx-C14 grade cell.
- `plans/FS86-derivation.md`: FS86-Cx-C14's and FS86-CL1's grade brackets (the same sentence, twice). Their *Prior art:* fields name the
  paper as "the input" and carry no grade; unchanged.
- `plans/R88-derivation.md`: the inputs paragraph (lines 88–89).
- `BIBLIOGRAPHY.md`: `[AmbrusEtAl2023]`'s role column gains "H4 and H5 re-checked in ball arithmetic by J49 (`tools/fs100_kt1_ball.py`)".
- `plans/PA-ambrus2023-audit.md`: "about 640,000 points" → "493,471 distinct points (about 646,000 evaluations …)", both places; a superseding
  note at J26-T1 (J49-T1/T2 [cert]; J49-T3 added to J26-T3's reading, in the same note, so J26-T3's own text is untouched).
- **Not touched, with the reason:** the poster rows P4, P5, P7–P9 and T-J38-1/2/3, T-J39-4 live in Poros records (never touched); their
  grades move in the FS-100 stub (stage 3). `CLAUDE.md` names no grade for the Ambrus input. § B's FS86-CL1 line ("hand, one mind +
  external") names no Ambrus grade; left. Row 113 cites "row 112's inputs" and so inherits the grade without an edit.

**Gates after the stage:** fact audit `--base 82dd14f8` exit 0, PASSED; `--strict` exit 0, PASS; bib audit exit 0, PASS.

## Stage 3 — SAVED (FS-100, the re-aims, FS-97's absorption, their mirrors; brief A.2, A.3)

Applied by `data/crunch-2026-09-25/j25/apply_stage3.py` (plant fired first — every other anchor matched, exit 1, nothing written; a re-run
refuses, exit 1).
- **FS-100** (`plans/STUB-measure-rigidity-three-fields.md`): a status block under the header (stage 1 DONE by J48 with its route caveat
  verbatim; stage 2 DONE, certified, by J49; FS-97 absorbed; what is left in-ban; "Nothing here is a Frontier result"); J38's and J39's
  theorem lists marked blind-checked TRUE by J48; **J48's corrections** under T-J38-3 (per `R`-coset; the one-mind class forms), T-J39-3
  (step 5 by Lemmas C, C′ and a finite-index coset extension, the ℚ(√5) exception; the theorem unchanged) and T-J39-5 (ii) (the 43 hypothesis
  dropped); **T-J39-4 on two routes** (J39's through `m₁`; J48's through de Grey's graph, no `[AmbrusEtAl2023]`) and **J48's corollary**
  (J48-N4cor, verbatim); P4, P5, P7 and the identity table's Ambrus row marked "[cert + hand] since J49"; §4: X-KT1 scored met, X-BC scored by
  J48, **X-MR "unregistered: the FS-100 planner registers it at stage 0"**, X-R1 carried from FS-97; §6's stage rows and §6.1/§6.2 headings
  DONE; §6.2's T-J39-4 row (the de Grey route survives a violated H4); §7's two clauses "did not fire"; §9: FS-97 absorbed, and J38's DP lemma
  and control card homed here (post-close inventory row 35), T-J38-4 as the card's evidence (row 34).
- **FS-59**: a re-aim block, post-close inventory row 42 verbatim, J39's ranking line, and "local at no prime, 43 at depth excepted (FS-69)".
- **FS-96**: the J47 cross-reference replaced by the re-aim, J39's R3 verbatim.
- **FS-97**: the banner "Absorbed into FS-100 … demoted, never deleted".
- **FS-98** (`plans/STUB-ultrametric-continuation.md`): re-aimed to T-B1 alone, J38's R1 statement verbatim (post-close inventory rows 34–35).
- **`plans/FRONTIER-STUBS.md`**: a re-rank paragraph (no rank moved); FS-59's, FS-100's, FS-96's, FS-98's rows; FS-97's row marked absorbed
  and a closed-list entry.
- **`CLAUDE.md`**: "Last updated" (the crunch closed, 2026-09-26; FS-100's stages 1–2 ran, FS-97 absorbed — pointers only); the ranked-stubs
  note; the FS-59, FS-100, FS-97, FS-96, FS-98 rows. **295,923 → 296,569 bytes.**

| choice | alternative | why | confidence |
|---|---|---|---|
| FS-97 keeps rank 13 under an "absorbed" banner; no rank moves | drop it from the table and renumber ranks 14–58 | renumbering changes every group-rank range the fact audit tracks, which needs reviewed ALLOW lines in `tools/claude_md_fact_audit.py` — outside my touch list (J47's slip was exactly that); a banner row is honest and costs nothing | medium — if the owner wants absorbed stubs out of the table, the next re-rank removes the row and adds the ALLOW lines |
| re-aim FS-98's stub under brief A.4 (inventory rows 34–35) | leave FS-98 untouched (not among "the stubs named above") | A.4 authorises open inventory rows "whose target is a front-page file, stub or index", and rows 34–35 target FS-98 and FS-97's MR home | medium — if the touch list was meant literally, the FS-98 block is one revert |
| home J38's DP lemma and control card in FS-100 | put them in FS-98 | row 35 says "DP and MR one home in FS-97", and FS-97 is now FS-100 | high |
| T-J39-4's two routes and J48's corollary go in the stub only | a `LEDGER.md` § B line | nothing from FS-100 enters the Frontier or the ledger before its milestone runs (brief A.6) | high |

**Gates after the stage:** fact audit `--base 82dd14f8` exit 0, PASSED, **no new ALLOW line**; `--dupes` exit 0, **13**.

## Stage 4 — SAVED (the post-close inventory's ticks; the crunch index; brief A.4, A.5)

Applied by `data/crunch-2026-09-25/j25/apply_stage4.py` (plant fired first, exit 1, nothing written; a re-run refuses, exit 1).
- **Post-close inventory ticked done:** 32 (the ceiling is 325,000 until the crunch ends, 6460c11e), 34 and 35 (J25 stage 3: FS-98 re-aimed;
  DP and the control card in FS-100), 37 (15f5f37e), 38 and 39 (974f8810), 42 (J25 stage 3).
- **Left open, not front-page targets** (listed for the owner): 1, 2, 15, 26, 29, 30, 31, 36 (job records, Poros records, plan bodies,
  derivation files); 5 (a Lean module doc); 6, 14, 16, 18, 19, 20, 40 (tools and scripts); 21, 24 (briefs, standing rules); 22 (the owner's
  decline, its own disposition); 23 (a loose data file, `data/m2/j23b/signatures.txt`, still untracked). 12 and 17 are dispositioned ("see
  row 22"); 3, 4, 7–11, 13, 25, 27, 28, 33, 41 were already done.
- **J48's and J49's reports are not folded** into any inventory (the clerk last folded through J47). Their front-page items are applied here
  (stages 2–3); their other items — J48's plant slip, J49's prediction scores — stay in their records. The inventory is the owner's pen: I add
  no rows.
- **The index** (`plans/CRUNCH-2026-09-25-INDEX.md`): a second addendum, addresses only — J36, J37, J38, J39, J45, J46, J47, J48, J49 and FS-100.

## Stage 5 — SAVED (the crunch's close: the queue's banner, §2, §8; brief Part B)

Applied by `data/crunch-2026-09-25/j25/apply_queue.py` from the draft `data/crunch-2026-09-25/j25/section8.md` (plant fired first, exit 1;
a re-run refuses, exit 1). No `wait`, `ready`, `run` or `HALTED` status is left in §2.
- **Banner:** "CLOSED 2026-09-26 by front-page job J25".
- **§2 final statuses:** J00 DONE (last fold through J47); J05 not run (the ceiling rose); J01 and J28V annotated from their reports; the
  generic J23 row DONE through its instances; J25 DONE; J29-S4 post-ban; J43 READY, the bookend after J25; FS100-BC "DONE — run as J48"; new
  rows J48 and J49, DONE.
- **§8.1** the jobs, from the 60 reports: status and harness total ("not reported" where a report gave "?" or only its own count, the own
  count in brackets); 33 reported harness figures summing to 9,616k.
- **§8.2 §5 scored once:** 28 lines scored, 21 met, 7 missed (E2b, E3, E4, E5, E8c, E10b, E10c), E9 unscored (no instrument); Brier 0.170;
  every miss is an event that happened below even odds — the planner under-priced blind-verified derivation. "A good crunch": all four met.
- **§8.3** closed M1, M2, M3, row 88, FS-67; open FS-84; minted FS-92 to FS-100 (FS-97 absorbed).
- **§8.4** the hand-over: FS-84's S2–S4, FS-90 (Y1), FS-64 (Y2), FS-100's P1 = J37's R4 (EI-F; one stage, two names), FS-67's PB-2, FS-45's D3
  (§2's "Not queued" names it post-ban too); in-ban left: FS-100 stages 0, 3, 4 (after the crunch), 5, 6, and J43.
- **§8.5** Kooshi's rulings (ten lines, the last the open ones), the owner's slips (seven, each with the job that found it), and the owner
  rulings the front page applied.

| choice | alternative | why | confidence |
|---|---|---|---|
| score §5 by "met when it happened at p ≥ 0.5, or did not at p < 0.5", with the Brier score beside it | a Brier score alone | the brief asks "met or missed" per line; the Brier score keeps the probabilities' information the binary loses | high |
| list FS-45's D3 among the post-ban stages | only the six the brief names | §2's own "Not queued" list names D3 as post-ban; leaving it out would drop a thread the queue already holds | medium — one line to remove if the owner's list was meant to be complete |
| harness totals only from the reports' first lines, own counts in brackets | read the task notifications | the brief says "read from the reports"; the owner holds the notifications | high |

## Stage 6 — SAVED (gates, final; the report)

| gate | exit | verdict |
|---|---|---|
| `tools/claude_md_fact_audit.py --base 82dd14f8` | 0 | AUDIT PASSED (0 failures); **no ALLOW line added** (the tool untouched) |
| `--dupes` | 0 | 13 repeated runs, 910 bytes — unchanged from launch |
| `tools/bib_audit.py` | 0 | every cited work resolves |
| `tools/fs71_ledger_b_check.py --strict` | 0 | PASS (714 entries, 714 § B rows) |
| `tools/check_architecture.py` | 0 | PASS |

`CLAUDE.md`: **296,569 bytes** — under the 300,000 default Kooshi re-decides after the crunch (ceiling 325,000 until then). No `[PROTECTED]`
paragraph, status tag, *Do* line or killing test touched. No Lean file touched; no build run.

Report: `data/crunch-2026-09-25/reports/J25.md`, sent to the owner by SendMessage.
