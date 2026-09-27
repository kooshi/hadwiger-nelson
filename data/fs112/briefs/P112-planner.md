*Brief for job **FS112-P**: open FS-112, the unit-arc half, by WORKFLOW steps 3–5. Opus 5.5, 2026-09-27. Written by the product owner. An
advisor (Poros, job FS112-A) works beside you. **Sized for about 300k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the milestone planner, in `/home/kooshi/source/lean-dir`. **`data/fs112/briefs/STANDING-RULES.md` is
part of this brief. Read it in full, rule 0 first.** Read from disk:
- `CLAUDE.md`: **§ The aim and § Counter-priors first**, then the rest (G82 closely);
- `LEDGER.md` in full, with rows 131–134 read closely;
- `WORKFLOW.md` steps 3–5, and `DEBRUIJN.md`;
- **the stub `plans/STUB-unit-arc-half.md`** (FS-112), all of it — its banner carries four re-aims from print found by the consolidation run —
  and the stubs it touches: `plans/STUB-reg-scale.md` (FS-111), `plans/STUB-regular-half-residuals.md` (FS-108), `plans/STUB-hole-dial.md` (FS-109);
- FS-110's close: `plans/FS110-tangency-seam.md` §R-close, `plans/FS110-derivation.md` (every entry the stub names: N2-S1, Y2-S1i, YB-V5X,
  YB3-SAME, A4-SIX-ARCS, A4-BAND, Y3-SIX, W-MERGE, NB-4, NB-5, N4's cone removal, CE1–CE7), `data/fs110/claims.md` (§7–§9 with their corrections),
  and `plans/FS110-close-inventory.md` items 68 and 78;
- the competition advisor's last stages, `plans/POROS-2026-09-27-fs110-competition.md` § Stage A6-2 (A6-2.1–A6-2.3) and § Stage A6-3;
- the print the banner cites, on the page: `[Polymath2021]` pp. 191–200 and `[Parts2021]` pp. 177–189 (`~/source/library/geombinatorics/geombinatorics-v30-n4-2021-04.pdf`),
  `[AxenovichEtAl2014]` Thm 4.2 (grep `BIBLIOGRAPHY.md` for its file), `[Parts2020c]` §2.5, `[Kainen1992]` pp. 34–35;
- `plans/PROTOCOL-competitor-and-advisor.md`, as amended at FS-110's close (§1 rule 12: no agent messages another after its own hand-back).

## Kooshi's words (verbatim)

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish." (2026-09-26)

> "Let's see some ambition. I know we can do it." (2026-09-26)

> "Looks like you've got plenty of context to coordinate another milestone or two. You're approved to continue." (2026-09-27, opening FS-112)

## The question

The stub's, verbatim at its head: *"does a tight six-map exist once boundary arcs of radius 1 are allowed?"* `[SokolovVoronov2025]` Question 2's
Condition-5 half is answered yes almost everywhere (row 134); what is left is the half with unit arcs. Keep its two forms apart, as FS-110 did:
- **Q-full** (decisive at bounded complexity): does a locally finite map bounded by segments and circular arcs, arcs of radius 1 allowed, carry a
  six-colouring proper at almost every unit pair? YES gives `χ(ℝ²) ≤ 6` with no MR (row 133, W-EQ-K). NO answers Question 2 almost everywhere for
  circular-arc maps, closes door (A), and answers `[Polymath2021]` p. 199's question as posed for that class (the stub's banner, item 1).
- **Q-rule** (a relaxation): the necessary conditions at the seams — (S1), the T2 rhombus, NB-4's four-colour exception — and which of the
  Condition-5 chain's steps survive unit arcs (the stub: *"the first question is which of the chain's steps survive unit arcs"*).

## What to produce: `plans/FS112-unit-arc-half.md`

1. **§G** (WORKFLOW 3.1): one short line per grokking, row mechanism and method rule, each *bears* extracted into a phase. Save it in two stages.
2. **§PA** (all eight questions). The banner's four items are this milestone's first prior art; start from them, and cover what they leave:
   Thomassen 1999 and its citing works (the unit-radius tactic's home), `[Polymath2021]`'s citing works, the curved-boundary tiling literature
   (Coulson, Townsend, Woodall, Sokolov–Voronov and theirs), and the Geombinatorics catalogue (`~/source/library/geombinatorics/CATALOGUE.md`)
   by its own words ("wavy", "arc of radius 1", "unit-radius", "curved", "map colouring").
3. **§IQ** (WORKFLOW 3.3): what must every tight six-map with unit arcs carry at a unit-arc centre? G79's flip: row 134 read the invariant a NO needs
   under Condition 5 — name the one that survives unit arcs, or say none is known.
4. **The fixed claim list** `data/fs112/claims.md`: statements only, each quoted verbatim from its source — Q-full and Q-rule; the three seams;
   the chain's steps with their Condition-5 grades (row 134's grade clause verbatim) and the question for each; YB3-SAME; the known positive (the
   strip) as the checkers' calibration; the killing tests; the failure clauses.
5. **The plan and the registrations.** Re-register the stub's three expectations with the banner's evidence in view, **stating each one's
   population** (G21) — in particular *"a YES by formula (0.03)"*, against `[Parts2021]`'s measured saving and `[Parts2020c]`'s voids. Both outcomes
   reachable for each. Choose the staffing; FS-110's shape was a proof side against a construction side, a competition advisor, and a blind verifier
   per side. Draft the briefs as `data/fs112/briefs/<id>-*.md` for the owner to launch. At most three agents at once, all Opus 5.5.
   - **The ban runs to 2026-10-01**, and Kooshi's ruling stands beyond it: *"search for a finite graph is out"*. The construction side's candidate
     maps are given by formula and checked exactly; nothing is searched. The exact curved checkers (`tools/fs110_y_check.py`,
     `tools/fs110_yb_check.py`, `tools/fs110_yb4_check.py`) are frozen: new checks go in new `tools/fs112_*` files, and **each accepts the strip
     before any of its refusals is believed**.

## Rules

- **Touch only** `plans/FS112-unit-arc-half.md`, `data/fs112/claims.md`, `data/fs112/briefs/<new job briefs>` and `data/fs112/fs112-p/`. Also
  create `plans/FS112-close-inventory.md` empty from `plans/FS110-close-inventory.md`'s header; from then on the owner is its only writer.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- Do not derive the seams yourself; the jobs do. State the claims exactly.
- Send the advisor your §G bears list and your claim-list draft by SendMessage (its id comes from me). You decide, and you record disagreements.
- Commit subjects "FS112-P: stage n", neutral.
- Report per standing rule 9 to `data/fs112/reports/FS112-P.md`: the claim ids, the phases, the registrations, and any paper still needed.

Thank you.
