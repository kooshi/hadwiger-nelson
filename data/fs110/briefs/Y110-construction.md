*Brief for job **FS110-Y**, FS-110 (the tangency seam). Opus 5.5, 2026-09-27. Written by the milestone planner FS110-P for the owner to launch.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs110/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** Kooshi (2026-09-26, verbatim): *"My goal is to fully solve, and then verify in Lean, HN. Then we publish."* and *"Let's see some
ambition. I know we can do it."*

## Reading

Read from disk, in this order:
- `data/fs110/briefs/STANDING-RULES.md` (part of this brief; rule 0 first), then `CLAUDE.md` § The aim and § Counter-priors, then G82, G79, G71,
  G21, G15, G13 and G46, and `DEBRUIJN.md`;
- `LEDGER.md` rows 131–133;
- **`data/fs110/claims.md` in full** — the fixed claim list: the definitions, the questions, the local calculus (§1b), the seams (§2), the shared
  constraints (§3), the killing tests (§4) and the failure clauses (§5). Work these statements; quote them, never paraphrase them (standing rule 5);
- `plans/FS110-tangency-seam.md` §G part 3 (the extractions), §PA (the prior-art gate: the question is S–V's Question 2; the spindle-convexity vocabulary for tight arcs) and §IQ (the blocking profile; the local-rule warning);
- `plans/STUB-tangency-seam.md`; `plans/FS107-derivation.md`;
- the sources the claims quote: `plans/FS106-TS-derivation.md` §2.2 (TS-U), l. 258 (C-T-TAN), l. 273–275 (C-T-IND, C-T-KILL); `plans/FS107-V-verification.md`
  §4.3; `plans/FS107-VW-verification.md` §2b.4, §4; `plans/FS107-W-near-colourings.md` §2.5, §4.2; `plans/FS107-R-stability.md` §3.2–3.6;
  `plans/FS106-V-verification.md` l. 368–374 (Townsend's ⅔π sector, checked);
- the papers, held in `~/source/library/`: `pdf/arXiv-2502.01958-maptype.pdf` (`[SokolovVoronov2025]`: Question 2, Conditions 5–7, Cor. 2,
  Props. 5, 10, 12, 17, Lemma 3); `townsend-colouring-plane-no-monochrome-units-author-manuscript-1979-posted-2024.pdf`;
  `pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf` §3; `pdf/jams-2004-coulson-chromatic-number-plane-tilings.pdf`;
  `pdf/arXiv-2304.10163-voronov.pdf` (Prop. 2.2, Lemma 6.1).

**Fences** (standing rule 13; `plans/PROTOCOL-competitor-and-advisor.md` §1 rule 1). Do not open, list or grep:
- the session transcripts, everything under `~/.claude/projects/-home-kooshi-source-lean-dir/` (memory and subagents included); `chats-bak/` in
  the repository; every file in the shared harness scratchpad `/tmp/claude-1000/-home-kooshi-source-lean-dir/*/scratchpad/` that you did not create —
  work only in your own subdirectory `scratchpad/fs110-y/`;
- the advisors' records and working directories: `plans/POROS-2026-09-27-fs110-tangency-seam.md`, `data/fs110/fs110-a/`,
  `plans/POROS-2026-09-27-fs110-competition.md`, `data/fs110/fs110-a2/`;
- the other side's record, working directory and tools: `plans/FS110-N-proof.md`, `data/fs110/fs110-n/`, `tools/fs110_n_*`, until you have handed back (do not open the
  other side's record before your own hand-back even if it is offered);
- the verifiers' records `plans/FS110-NB-verification.md`, `plans/FS110-YB-verification.md` and `data/fs110/fs110-nb/`, `data/fs110/fs110-yb/`;
- `plans/FS110-close-inventory.md`, `data/fs110/reports/`, and every brief in `data/fs110/briefs/` other than yours and `STANDING-RULES.md`;
- `git log` beyond the start-up snapshot, and `git log -p` on any path, until you have handed back.
Exclude every fenced path from every grep (`rg` with `-g '!…'`). Opening or listing a fenced path by accident is a **fence touch**: log it in your
record's fence log and tell the owner in your report. Nothing is lost by a disclosed touch; a hidden one voids a result's independence.

## The question

FS-110 asks one question in two forms (`data/fs110/claims.md` §1; keep them apart):
- **Q-full** (decisive): "Does a full tight a.e.-proper six-colouring of the plane by a locally finite map of bounded arc complexity exist?" A YES is
  `χ(ℝ²) ≤ 6` with no MR (through W-EQ-K); a NO closes door (A) at every `K` and answers `[SokolovVoronov2025]` Question 2 almost everywhere for
  such maps — a question in print.
- **Q-rule** (necessary conditions only): every close covering pair of vertices must be a tangent pair (T1 or T2), a bowtie or strong escape, or a
  cusp, and equal-type pairs in `(1, 2)` must survive the bicycle. The four seams (§2 of the list), a fifth vertex kind (V5: bichromatic vertices of
  degree `≥ 4`, and four-colour vertices), and Act One (C-ACT1: are seams necessary at all?).

## The contest (`plans/PROTOCOL-competitor-and-advisor.md` §1 as it stands)

Two sides work the same seams from opposite ends. **FS110-N**, the proof side, closes them; **FS110-Y**, the construction side, realises them.
A competition advisor, **FS110-A2**, advises both identically. A blind verifier checks each side after it hands back. Both sides get identical
information; this brief differs from the other side's only in § Your side.
- **Stage 1 (both sides, before any seam):** the quotation check (standing rule 5); then **derive the local calculus of §1b** — A-EXACT, A-CIRC
  (check it at a cusp colour), A-SIX, C-TAN-POS, D-TYPE — each with a verdict, your count of minds and your grade; then answer A2's pre-round
  question (A2 sends it: which step of the other side's programme you expect to fail, and why). Commit stage 1 before reading anything A2 sends
  about the other side. A2 compares the two sides' stage-1 verdicts before round 1: a disagreement about types is cheap now and costly later (G51).
- **Then the seams, in the order you choose.** For each claim you work (§1b, §2, C-ACT1, C-SEAMLIST): TRUE with your derivation, FALSE with a
  counterexample, GAP at a named step, or MISSTATED with the corrected statement, graded. A local TRUE for an escape (for instance C-BOW-K (i)) is
  not a loss for the proof side; the NO must win at the global claims.
- **Prior art is shared:** send what you find to A2, who relays it to both sides. **No hints of routes** reach the other side through you.
- **If the challenge as posed is subtly the wrong challenge, say so** — that is a finding, not a refusal.
- **All novel knowledge is a success** (standing rule 4): a seam realised, a seam closed, or a GAP at a named step are equally results. Audit a
  verdict you like at the rate you audit one you do not (G21: selection is the recorded failure mode).

## Your side: the construction (YES)

You are **FS110-Y**. Your target is a YES: realise each seam in a tight local fragment given by formula, then a full tight map in `𝓜_K` meeting
Q-rule — or a named obstruction on the way. The plan's extractions that bind you (`plans/FS110-tangency-seam.md` §G part 3):
- **Write your generator's image first** and count its free parameters against the constraints (X5, X17; FS-107's X9 paid most). A positive
  control proves only shapes the generator can represent.
- **Curved from the first line** (W-POLY closes polygons at bounded complexity). Name every unit arc; TS-U constrains each one.
- **For each seam, write the invariant every realisation of it carries** — a sliver, a unit arc, a zero angle, a rhombus of vertices (X13; G79's
  flip). The proof side will aim at that invariant.
- **Every candidate is a formula with its symmetry group** (X7), rebuildable by hand.
- **Build the exact curved-map checker** `tools/fs110_y_check.py` before any verdict. For each same-colour tile pair, **including a tile with itself**,
  it computes the exact minimum and maximum cross-distance in a named number field, and REJECTs when 1 is interior (killing test 6).
  - Its suspect verdict is ACCEPT (X17): a derived distance that loses a pair turns a REJECT into an ACCEPT. So first run planted faults, a
    known-REJECT control, and the tight hexagonal seven-colouring as an ACCEPT control.
  - Eroded members go through VW-ERODE and the held checkers (`tools/fs107_w_check.py`, `tools/fs107_vw_grid_check.py`).
  - The checker certifies members. A family's claim is a derivation.
- **Q-rule is a one-sided filter** (X18). List the ways a map can pass it and still fail Q-full: equal-type pairs in `(1, 2)`, V5 vertices, the
  `d = 2` configuration, class density above 0.2470, same-colour pairs that are neither Siamese nor `≥ 1` apart.
- **Six and five stay apart** (G64). A tight five-map would be its own result, `χ(ℝ²) ≤ 5`; report it as such.
- A candidate that fails the exact check measures the candidate, not the question (§5). A seam you cannot realise is a named obstruction: say where
  it breaks.

Your tools go in `tools/fs110_y_*.py`; anything over about 2 GiB or 2 minutes runs under `scripts/slot.py`.

## Rules

- **Touch only** your record `plans/FS110-Y-construction.md` (heading "Theorems this phase proved"; SAVED stages), `data/fs110/fs110-y/` and `tools/fs110_y_*.py`. Commit by explicit path with neutral subjects "FS110-Y: stage n"; push after each commit; never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is left — a good report, never a failure.
- **The ban** (standing rule 3): no SAT, MILP, optimiser, local-search colourer, enumeration of tile rings or vertex configurations, or scan over a
  parameter. Kooshi's ruling beyond 2026-10-01: *"search for a finite graph is out. It would be huge, not feasible."* An exact check of seconds on an
  object **given by formula**, or of a derived identity at named values, is in. Keep the "would have searched here" log.
- **Contact:** only `"main"` and the competition advisor `FS110-A2`. Every report goes to `"main"` by SendMessage. **Your hand-back is exactly:
  "FS110-Y idle; no content in this hand-back; my reports go to the owner by SendMessage"** (a message from you to an idle advisor resumes it, and its
  notices then route to you; content-free hand-backs make that harmless).
- **Budget:** about 400k tokens by the harness's count; your own count runs at 55–70 % of it, so hand back when your own count reaches about
  260k, with your record SAVED.
- **Report** per standing rule 9 to `data/fs110/reports/FS110-Y.md`, and the same text to `"main"` by SendMessage. Your final turn's text:
  "FS110-Y idle; no content in this hand-back; my reports go to the owner by SendMessage".

Thank you.
