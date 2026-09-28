*Brief for job **FS114-N**, the proof side of FS-114 (the unit-arc question). Opus 5.5. Written by the milestone planner FS114-P for the owner to
launch. **Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs114/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** Kooshi (2026-09-26, verbatim, `CLAUDE.md` § The aim and § Counter-priors): *"My goal is to fully solve, and then verify in Lean, HN.
Then we publish."* and *"Let's see some ambition. I know we can do it."*

## Reading

Read from disk, in this order:
- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors; then G83, G82, G79, G72, G71, G68, G60, G29, G24,
  G21, G17, G15, G13; `DEBRUIJN.md`;
- `LEDGER.md` rows 131–136 (rows 134–136 closely: their chains, grades and Not-claimed clauses);
- **`data/fs114/claims.md` in full** — the fixed claim list, §8 included. Work these statements; quote them, never paraphrase them (standing rule 5);
- `plans/FS114-unit-arc-question.md`: §1.3, §G part 3 (the extractions), §PA, §IQ, stage 5's 5.0, 5.1, 5.2 and 5.4, and stage 5b — **not 5.3, the
  registered expectations, until your stage 1 is committed** (the first measurement, card 2's verdict, is worth a sample only unprimed);
- FS-112's close, which you continue: `plans/FS112-derivation.md` in full; `data/fs112/claims.md` §0 and §11; `plans/FS112-N-proof.md` (the last proof
  side: N2 stage N2-4 and N3 stages N3-3, N3-4 closely); `plans/FS112-Y-construction.md`, `plans/FS112-Y3-construction.md` and
  `plans/FS112-YB2-verification.md` (the last construction side: the strip, the disk, the pinned corner, BOWTIE);
- the printed local NOs, as this project verified them: `plans/FS106-V-verification.md` §2.1 (`[Voronov2023]` Thm 1.3) and V3 stage 2 (`[Thomassen1999]`);
  the held text `~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt` (four pages; OCR — check against the page images
  before quoting a garbled line); `~/source/library/pdf/arXiv-2502.01958-maptype.pdf` (`[SokolovVoronov2025]`: Question 2, Cor. 1, Props. 7–19);
- **the Google group** `~/source/library/hadwiger-nelson-problem-group/` (README first): `threads/Z50mmulkXCQ.txt` ("6-coloring a degree 5 graph") in
  full, and `threads/J_Tw1_hUxQI.txt` at the sections the plan's stage 5b names. Do not fetch any outbound link from them;
- to fetch at stage 1 (reading is in): `[Mohar2002]` (B. Mohar, *Light structures in infinite planar graphs without the strong isoperimetric property*,
  Trans. AMS 354 (2002) 3059–3074) and Ágoston 2025 (*A lower bound on the number of colours needed to nicely colour a sphere*, DCG 74 (2025) 691–718; find
  its arXiv version). Record a reading status per section (G50).

**Fences** (standing rule 13; `plans/PROTOCOL-competitor-and-advisor.md` §1 rule 1). Do not open, list or grep:
- the session transcripts, everything under `~/.claude/projects/-home-kooshi-source-lean-dir/` (memory and subagents included); `chats-bak/` in the
  repository; every file in the shared harness scratchpad `/tmp/claude-1000/-home-kooshi-source-lean-dir/*/scratchpad/` that you did not create — work
  only in your own subdirectory `scratchpad/fs114-n/`;
- the other side's record, working directory and tools — `plans/FS114-Y-construction.md`, `data/fs114/fs114-y/`, `tools/fs114_y_*` — until you have handed
  back;
- the verifiers' records and directories `plans/FS114-NB-verification.md`, `plans/FS114-YB-verification.md`, `plans/FS114-CV-verification.md`,
  `data/fs114/fs114-nb/`, `data/fs114/fs114-yb/`, `data/fs114/fs114-cv/`; the advisor's `plans/POROS-2026-09-27-fs114-competition.md`, `data/fs114/fs114-a/`;
- BASE-V's record until it has reported: `plans/BASE-V-verification.md`, `data/base-v/`, `tools/base_v_*`;
- `plans/FS114-close-inventory.md`, `data/fs114/reports/`, and every brief in `data/fs114/briefs/` other than yours and `STANDING-RULES.md`;
- `git log` beyond the start-up snapshot, and `git log -p` on any path, until you have handed back.
Exclude every fenced path from every grep (`rg -g '!…'`). An accidental open or listing is a **fence touch**: log it in your record's fence log and tell
the owner in your report. A disclosed touch costs nothing; a hidden one voids a result's independence.

## The question

`[SokolovVoronov2025]` Question 2 (verbatim): "Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be
arcs of unit circles and if trichromatic vertices of degree greater than 3 are allowed?" Its Condition-5 half is answered yes, almost everywhere (row
134). FS-112 reduced the other half: every valid map has a vertex of at least four colours or a repeated colour within 3 of every point
(FS112-N3-DENSE3). **The plan takes the global step in DENSE3's form — the NO itself** (plan 5.0; claim list §3, GS-D): exclude every valid map. A NO
answers Question 2's unit-arc half almost everywhere for segment-and-arc maps and `[Polymath2021]` p. 199's hope, and with row 134 closes door (A) at
every complexity bound; a YES (the construction side's) gives `χ(ℝ²) ≤ 6` with no MR.

## The contest (`plans/PROTOCOL-competitor-and-advisor.md` §1 as it stands, rules 1–14)

Two sides work the same claims from opposite ends: **FS114-N**, the proof side, excludes; **FS114-Y**, the construction side, realises. Both briefs carry
identical information and differ only in § Your side. A blind verifier checks each side after it hands back; a competition advisor (**FS114-A**) may
advise both identically if a slot is free — if none is launched, your hints and prior art go through the owner.
- **Prior art is shared**: send what you find to the owner (or A), who relays it to both. **No hints of routes** reach the other side through you.
- **If the challenge as posed is subtly the wrong challenge, say so** — a finding, not a refusal.
- **All novel knowledge is a success** (standing rule 4). A route that fails at a named step is a result. Audit a verdict you like at the rate of one
  you do not (G21).

## Your side: the proof (NO)

You are **FS114-N**. Your target is a NO of Q-full or of Q-full_K (say which, and whether you use the complexity bound), or the route that gets furthest
with its failing step named. Work in three stages, each SAVED and committed:

**Stage 1 — card 2, by derivation, before any route.** The night advisor's card (`plans/POROS-2026-09-27-night-aim.md` §3, verbatim): *"Is the unit-arc
NO local — an explicit radius past which no valid fragment survives around a four-colour vertex — or visible only to a count over the whole plane, as
Euler's formula and discharging give?"* Decide, with derivations:
1. **C114-COMPACT's use**: at each complexity bound `K` a NO gives some radius by compactness (FS112-A's reading). Can the radius be made **explicit**, and
   **uniform in `K`** (which would reach Q-full, row 134's chain using no bound)? Say what uniformity would need.
2. **C114-VOR**: name the step of `[Voronov2023]` Thm 1.3 (radius 3, closed classes) that closedness buys, and whether a valid map with unit arcs, read
   almost everywhere, can replace it.
3. **C114-THOM-TOP**: do `[Thomassen1999]`'s Lemma 1 and the topological steps of his proof hold for the map graph of every valid map? First candidates for
   failure: a face touching itself at a vertex, a face that is not a disc.
4. **Route T is Sirgedas's program** (plan stage 5b, PA-B): state it with its three gaps (proof in place of posts; Siamese pairs, which are FS112-N3-DENSE3's
   `R`; tiles with four edge-neighbours). **Its positive control is C114-FIVE-COUNT**: any count you build must yield that non-Siamese valid five-colour maps
   do not exist, and name where six's room enters.
5. **The verdict**: which route you take — local (C114-LOCAL-FR, or C114-LOCAL-F with C114-EXISTS-F, which the job FS114-CV second-minds), or the count
   (route T: C114-EDGE-RAINBOW, C114-RAINBOW, C114-CURV, C114-DUAL-COUNT, C114-REDBLOCK, C114-BUDGET) — and why. **Every step you write states the radius
   it reads.** Commit stage 1 before you read 5.3.

**Stage 2 — the route, torus first** (G68): on a doubly periodic valid map (a map on a torus, `V − E + F = 0` exactly; FS112-N3-PER gives a periodic
terminal modification). A NO for doubly periodic maps is a result (E4), not the question.

**Stage 3 — aperiodic maps**: the local exclusion's uniformity, or averaging over the plane (discharging on infinite planar graphs of subexponential
growth, `[Mohar2002]`); GS-D's verdict at its grade, or its GAP named.

The plan's extractions that bind you (`plans/FS114-unit-arc-question.md` §G part 3):
- **Pigeonhole × kill** (G15): a count is Act One (an unavoidable set), the local exclusions are the kills; a list of kills with no Act One decides
  nothing (C-ACT1) unless your route goes round it and says so.
- **Count at the centre** (G13): each local lemma a coverage statement at a vertex, its (Q) arcs' ends and the rhombus completions, before any pair.
- **No one class at a time** (G24, G60; row 129): a charge per tile of one colour is such a reduction.
- **Swaps** (G71): a winding or index route says what it does at a unit-arc interface facing a bowtie.
- **Which vertices** (G83): say which vertices of `F ∪ R` your argument reads.
- **The controls** (claim list §6): every NO step fails on the strip (radius `≈ 1.834` about a midline four-colour vertex) and the disk (`φ` about `A_0`,
  attained) and says where the plane beyond them is spent; the argument fails on the hexagonal seven-colouring and names where six is spent.
- **BASE-V** (a blind check of row 134's base) is running. If it reports a failing step, the owner tells you: FS112-N3-BASE and FS112-N3-DENSE3 are then
  regraded, and route T, which uses neither, is unaffected.

Your exact checks of derived identities go in `tools/fs114_n_*.py`, each with a planted fault that fires for its own reason (standing rule 7).

## Rules

- **Touch only** your record `plans/FS114-N-proof.md` (headings "Theorems this phase proved", the would-have-searched log and the fence log; SAVED
  stages), `data/fs114/fs114-n/` and `tools/fs114_n_*.py`. Commit by explicit path with neutral subjects "FS114-N: stage n"; push after each commit; never
  amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left — a good report, never a failure.
- **The ban** (standing rule 3): no SAT, MILP, optimiser, local-search colourer, enumeration of maps, tile graphs, dual graphs or vertex configurations,
  or scan over a parameter. Kooshi's ruling beyond 2026-10-01: *"search for a finite graph is out. It would be huge, not feasible."* Sirgedas's 2020
  search is prior art for its statements, never an input to a proof. An exact check of seconds on an object **given by formula**, or of a derived
  identity at named values, is in. Keep the "would have searched here" log.
- **Contact:** only `"main"` (and FS114-A if the owner names one). Every report goes to `"main"` by SendMessage. No message from you to anyone after your
  own hand-back (protocol rule 12).
- **Report** per standing rule 9 to `data/fs114/reports/FS114-N.md`, and the same text to `"main"` by SendMessage. **Your hand-back, and your final
  turn's text, is exactly: "FS114-N idle; no content in this hand-back; my reports go to the owner by SendMessage".**

Thank you.
