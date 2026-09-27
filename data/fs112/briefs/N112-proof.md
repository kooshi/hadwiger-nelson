*Brief for job **FS112-N**, FS-112 (the unit-arc half). Opus 5.5. Written by the milestone planner FS112-P for the owner to launch. **Sized for about
400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs112/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** Kooshi (2026-09-26, verbatim, `CLAUDE.md` § The aim and § Counter-priors): *"My goal is to fully solve, and then verify in Lean, HN.
Then we publish."* and *"Let's see some ambition. I know we can do it."*

## Reading

Read from disk, in this order:
- `data/fs112/briefs/STANDING-RULES.md` (rule 0 first), then `CLAUDE.md` § The aim and § Counter-priors, then G82, G79, G71, G24, G21, G15, G13 and
  G46, and `DEBRUIJN.md`;
- `LEDGER.md` rows 131–134 (row 134 closely: its chain, its grade clause, its Not claimed);
- **`data/fs112/claims.md` in full** — the fixed claim list. Work these statements; quote them, never paraphrase them (standing rule 5);
- `plans/FS112-unit-arc-half.md` §1.3, §G part 3 (the extractions), §PA, §IQ and stage 5's §5.1, §5.2 and §5.4 — **not §5.3, the registered
  expectations, until your stage 1 is committed** (two blind walks of the chain are worth two samples only if they are not primed alike);
- `plans/FS112-PA-reading.md` and `data/fs112/fs112-pa/` (the P0 reading job's verbatim extracts of Polymath16's 2018 six-tiling discussions), once
  the owner says they have landed;
- FS-110's close, which you continue: `plans/FS110-derivation.md` in full; `data/fs110/claims.md` §§0–3 and §9; `plans/FS110-N-proof.md` (the last
  milestone's proof side — its §2.3 (S1)/(S2) and §5.2, and § Continuation — FS110-N3, N4); `plans/FS110-NB-verification.md` §2.3 (NB-4's derivation;
  check its l. 164 against the claim list's MISSTATED-suspect note first); `plans/FS110-CB-verification.md`, `plans/FS110-CD-verification.md`,
  `plans/FS110-CE-verification.md` (the base);
- the papers, held in `~/source/library/`: `pdf/arXiv-2502.01958-maptype.pdf` (`[SokolovVoronov2025]`: Question 2, Conditions 5–6, Lemmas 2–3, Props.
  7–19, Cor. 1); `pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf` §3 (steps 2, 3, 5; the cone); `papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt`;
  `geombinatorics/geombinatorics-v30-n4-2021-04.pdf` (`[Polymath2021]` pp. 190–201: the tactic on p. 194, the question on p. 199);
  `pdf/axenovich-2014-chromatic-number-subsets-euclidean-plane.pdf` p. 8 (the strip).

**Fences** (standing rule 13; `plans/PROTOCOL-competitor-and-advisor.md` §1 rule 1). Do not open, list or grep:
- the session transcripts, everything under `~/.claude/projects/-home-kooshi-source-lean-dir/` (memory and subagents included); `chats-bak/` in the
  repository; every file in the shared harness scratchpad `/tmp/claude-1000/-home-kooshi-source-lean-dir/*/scratchpad/` that you did not create — work
  only in your own subdirectory `scratchpad/fs112-n/`;
- the advisors' records and working directories: `plans/POROS-2026-09-27-fs112-unit-arc-half.md`, `data/fs112/fs112-a/`,
  `plans/POROS-2026-09-27-fs112-competition.md`, `data/fs112/fs112-a2/`;
- the other side's record, working directory and tools — `plans/FS112-Y-construction.md`, `data/fs112/fs112-y/`, `tools/fs112_y_*` — until you have
  handed back (do not open them before your own hand-back even if offered);
- the verifiers' records `plans/FS112-NB-verification.md`, `plans/FS112-YB-verification.md`, `data/fs112/fs112-nb/`, `data/fs112/fs112-yb/`;
- `plans/FS112-close-inventory.md`, `data/fs112/reports/`, and every brief in `data/fs112/briefs/` other than yours and `STANDING-RULES.md`;
- `git log` beyond the start-up snapshot, and `git log -p` on any path, until you have handed back.
Exclude every fenced path from every grep (`rg -g '!…'`). An accidental open or listing is a **fence touch**: log it in your record's fence log and
tell the owner in your report. A disclosed touch costs nothing; a hidden one voids a result's independence.

## The question

`[SokolovVoronov2025]` Question 2's Condition-5 half is answered yes, almost everywhere (row 134). FS-112 asks the other half, in two forms (claim list
§1; keep them apart):
- **Q-full** (decisive): "a locally finite map bounded by segments and circular arcs, arcs of radius 1 allowed, carrying a six-colouring in which no two
  interior points of one colour are at distance exactly 1." A YES at bounded complexity is `χ(ℝ²) ≤ 6` with no MR (W-EQ-K); a NO answers S–V's Question 2
  almost everywhere for circular-arc maps, and `[Polymath2021]` p. 199's question as posed for that class.
- **Q-rule** (necessary conditions): the seams at close covering pairs — (S1), T2, NB-4's four-colour exception (claim list §2) — and the unit-arc centre
  (§6).

## The contest (`plans/PROTOCOL-competitor-and-advisor.md` §1 as it stands, rule 12 included)

Two sides work the same claims from opposite ends. **FS112-N**, the proof side, closes them; **FS112-Y**, the construction side, realises them. A
competition advisor, **FS112-A2**, advises both identically. A blind verifier checks each side after it hands back. Both briefs carry identical
information; they differ only in § Your side.
- **Stage 1 (both sides, before anything else):** the quotation check (standing rule 5); then **the chain walk** — every step C-CHAIN-1 … C-CHAIN-18 of
  claim list §3 with one verdict under unit arcs (holds as written; holds off a named exception, by contact kind; fails, with the configuration), and
  **the unit circles each step reads named** (a unit arc centred at `P` breaks Condition 5 on `ω(P)` alone). Then answer A2's pre-round question (A2
  sends it: which step of the other side's programme you expect to fail, and why). Commit stage 1 before you read anything A2 sends about the other
  side: A2 compares the two walks before round 1, while a disagreement is free (G51).
- **Then the claims, in the order you choose** — §2's seams, §6's unit-arc centre, C-BEYOND, C-LOCAL. For each: TRUE with your derivation, FALSE with a
  counterexample, GAP at a named step, or MISSTATED with the corrected statement, graded, with your count of minds.
- **Prior art is shared:** send what you find to A2, who relays it to both. **No hints of routes** reach the other side through you.
- **If the challenge as posed is subtly the wrong challenge, say so** — that is a finding, not a refusal.
- **All novel knowledge is a success** (standing rule 4). A step of row 134's chain that survives unit arcs and one that breaks are equally results.
  Audit a verdict you like at the rate you audit one you do not (G21).

## Your side: the proof (NO)

You are **FS112-N**. Your target is a NO of Q-full, or the first break of row 134's chain under unit arcs with the configuration named, or a named GAP
on the way. The plan's extractions that bind you (`plans/FS112-unit-arc-half.md` §G part 3):
- **Walk the printed chain first** (G82's *Do*): Woodall's step 3 and S–V's Cor. 1, made curved and almost everywhere, carried row 134; find which of
  its steps survive before inventing a route.
- **Count at the vertex, not the pair** (G13): at a vertex that is a unit-arc centre or lies on a unit arc, write what the rings must cover before any
  pair statement. NB-4's exception is a coverage statement.
- **Act One is kept** (G15; C-ACT1): a list of seam kills with no Act One decides nothing — unless your route goes round it, as row 134's did, and says so.
- **No per-class argument** (G24; K-INT): one class at a time stops below 4.37 colours.
- **The flip** (G79; §IQ): ask what every tight map with a unit arc carries at the arc's centre (claim list §6: C-UA-INC, C-UA-WEDGE, C-UA-BUDGET with
  both branches, C-UA-CHAIN, ARC-INERT) before sharpening any no-go.
- **The local positives** (C-BEYOND; killing test 8): `[AxenovichEtAl2014]`'s six-coloured strip of height `√15/2 + √3` is valid; any route whose steps
  all fit inside such a strip is refuted by it. Name the step of yours that reads beyond it, and answer C-LOCAL.
- **Name the line where "six" is spent** and check that the argument fails on the seven-colour controls (killing test 1).
- **At a bowtie with unit arcs the printed index may fail** (FS106-IND-X); G71's "fails only at a swap" is killing test 5 — test it, do not assume it.

Your exact checks of derived identities go in `tools/fs112_n_*.py`, each with a planted fault that fires for its own reason (standing rule 7).

## Rules

- **Touch only** your record `plans/FS112-N-proof.md` (headings "Theorems this phase proved", the would-have-searched log and the fence log; SAVED stages),
  `data/fs112/fs112-n/` and `tools/fs112_n_*.py`. Commit by explicit path with neutral subjects "FS112-N: stage n"; push after each commit; never amend or
  force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left — a good report, never a failure.
- **The ban** (standing rule 3): no SAT, MILP, optimiser, local-search colourer, enumeration of tile rings or vertex configurations, or scan over a
  parameter. Kooshi's ruling beyond 2026-10-01: *"search for a finite graph is out. It would be huge, not feasible."* An exact check of seconds on an object
  **given by formula**, or of a derived identity at named values, is in. Keep the "would have searched here" log.
- **Contact:** only `"main"` and the competition advisor FS112-A2 (its id comes from the owner). Every report goes to `"main"` by SendMessage. No message
  from you to anyone after your own hand-back (protocol rule 12).
- **Report** per standing rule 9 to `data/fs112/reports/FS112-N.md`, and the same text to `"main"` by SendMessage. **Your hand-back, and your final turn's
  text, is exactly: "FS112-N idle; no content in this hand-back; my reports go to the owner by SendMessage".**

Thank you.
