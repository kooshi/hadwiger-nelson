*Brief for job **VIZ-ATLAS**: an explorable map of the logic of the Hadwiger–Nelson hunt, for Kooshi. Opus 5.5, 2026-09-27. Written by the product
owner at Kooshi's request. **Sized for about 350k tokens by the harness's count, as guidance** (Kooshi, 2026-09-27: budgets are guidance, never a limit).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`, building one page. Kooshi's words, verbatim:

> "can you have a subagent write up a visualization for me (in the visualizations dir) which shows a graph of key lemmas and theorems (those being the
> nodes) with any missing theorems shown as such, and a source for each? I want them arranged around the goal (the solution to HN) in a visually
> appealing way in such a way that I can explore the different approaches we have, and roughly how far each is (perhaps using information theory?) from
> proving one answer or another. I want to get a sense of the structure of our logic, where the rungs have been built, on which paths, and how close we
> are."

Read `CLAUDE.md` § The aim and § Counter-priors first, from disk (a subagent sees a stale snapshot; read the file).

## What the page must let him do

1. **See the goal at the centre.** The goal is the answer: `χ(ℝ²) ∈ {5, 6, 7}`, with each answer (5, 6, 7) as a destination. Arrange the key theorems,
   lemmas and missing steps around it, so that a route to an answer reads as a path inward.
2. **Tell built from missing at a glance.** Each node's status, drawn so it can be read without a legend lookup:
   - **kernel** — checked by Lean's kernel;
   - **cert** — an exact certificate;
   - **hand, two minds, one blind** / **hand, two minds** / **hand, one mind**;
   - **reading** — believed, with a killing test;
   - **external** — claimed in print, not checked here;
   - **GAP / open** — a missing theorem: the step a route still needs, drawn as missing (hollow, dashed, or however reads best);
   - **closed / no-go** — a route proved not to work (e.g. "density cannot give six", row 129), drawn as a blocked edge, not deleted.
3. **Explore the approaches.** Pick a route (filter or highlight) and see its chain from what is held to an answer, and which answer it points to. At
   least these, each verified against the files, not taken from this list:
   - the classical interval, `5 ≤ χ(ℝ²) ≤ 7`, in the kernel (row 33; rung B);
   - the algebraic lower bound through measure rigidity (rows 120–123);
   - **the regularity wall toward seven** (§ The aim, links 1–6): MR → the collapse (row 128) → `χ_CP = χ_m⁰` (row 130) → stability (row 131) → the
     tight six-map at bounded complexity (row 133) → Condition 5 closed (row 134) → the unit-arc half (FS-112, closing tonight: its reduction to two
     missing steps, the **global step** and the **non-periodic stuck ray**, which become new milestones FS-114 and FS-115) → the cone scale (FS-111) →
     `χ_m⁰ = 7`, hence `χ(ℝ²) = 7` given MR; and MR in Lean (FS-113) for publication;
   - **the YES side** — a tight six-map or a vanishing-holes sequence, giving `χ(ℝ²) ≤ 6` with no MR; the held positives (the strip and the disk) and
     where they stop;
   - **toward six from below** (FS-104, FS-80, FS-59) and **toward exactly five** (FS-44);
   - the local–global conjecture's proved range (rows 99, 121, 123) as structure around the arithmetic routes.
4. **See roughly how far each route is.** Use information theory, stated on the page so he can check it:
   - give each status a default credence `p` (an instrument, never evidence — § Counter-priors rule 2; `CLAUDE.md` G21), and each missing step the
     registered probability its stub or plan gives it where one exists (cite it), otherwise a stated default;
   - a route's distance is its **surprisal**, `Σ −log₂ p` over its links, in bits: zero for a route wholly in the kernel;
   - let him **adjust the credence table** (sliders or inputs), and see the distances recompute;
   - show a second distance beside it, **distance to publication**: the number of the route's links not yet in Lean. Kooshi's bar is "Anything we do
     must be formalized in Lean before publishing", so a hand-proved route is not yet publishable;
   - say plainly on the page what the numbers are not: a belief about the answer is not evidence for it (G64's warning), and a credence is an
     instrument.
5. **Click any node for its card:** its statement in plain words and in the source's words; its status and grade exactly as the source writes it; its
   **source address** (a `LEDGER.md` row, a `plans/…` file and line, a stub `plans/STUB-….md`); what it rests on; what rests on it.

## Where the facts come from — and the standard

- **Every node and edge carries a source address, and every grade is the source's own words.** Sources, in order of authority: `LEDGER.md` (rows and
  § B), the derivation files `plans/FS*-derivation.md`, `CLAUDE.md` § The aim, § Where the problem stands, § Paths forward and the grokkings,
  `plans/FRONTIER-STUBS.md` and the stub files, and for FS-112 (not yet closed) `plans/FS112-close-inventory.md` with the records its items name.
- Follow the precedent `visualizations/local-global-map/` (read its `README.md` and `DESIGN.md`): **one fact table** (`data/viz/proof-atlas/facts.json`)
  that every mark is drawn from; **a checker** (`tools/viz_proof_atlas_check.py`) that re-reads each fact from its source address and fails on any
  mismatch or missing address, with a `--self-test` that plants a wrong grade and a dead address and watches each fire; a `build.py` that refuses to
  build when the check fails and inlines the table into the page. A node whose source you cannot find is left out and listed in your report, never
  guessed.
- **Choose the nodes by bearing on the answer**, not by count: the load-bearing theorems of each route and every missing step, with the ledger's detail
  one click away rather than drawn. A few dozen to a hundred or so nodes is the likely right scale; say what you left out.
- **Two things are in progress tonight; do not read their working files.** FS112-YB3 (a blind verifier, record `plans/FS112-YB3-verification.md` and
  `data/fs112/fs112-yb3/`) and FS112-C (the close planner: `plans/FS112-derivation.md`, any "§R-close" in `plans/FS112-unit-arc-half.md`,
  `data/fs112/fs112-c/`, the two new stub files). Show FS-112 as closing, its round-3 construction-side claims (Y3) as "under blind verification", and
  the two successor steps from `plans/FS112-close-inventory.md` items 59–63 and `plans/FS112-N-proof.md` (N3's GAP N3-ALPH; the global step).

## The page

- **Files:** `visualizations/proof-atlas/` with `README.md`, `DESIGN.md` (the frame, one or two alternatives weighed, the encodings, the distance
  measure), `page.tmpl.html`, `build.py` and the built `index.html`. The owner publishes `index.html` as a claude.ai artifact; you do not publish.
- **The page contract** (the artifact viewer's rules):
  - one self-contained `.html` file with no `<!doctype>`, `<html>`, `<head>` or `<body>` tags: it is wrapped at publish time; put your own `<title>`
    (two to four words, a name, not a caption) and `<style>` at the top;
  - external scripts **only** from `https://cdnjs.cloudflare.com` (pinned exact versions, UMD builds, e.g. d3 v7), stylesheets only from Google Fonts;
    everything else inline; no fetch of other files;
  - both themes: the full light palette as tokens on `:root`; the dark tokens under `@media (prefers-color-scheme: dark)` guarded as
    `:root:not([data-theme="light"])` **and** again under `:root[data-theme="dark"]`, with `color-scheme: dark` there; `body` gets an explicit token
    background;
  - works at phone width (about 400px): a 16px side gutter, no horizontal page scroll (the graph may pan inside its own container);
  - complete at rest: the first frame shows the goal, the routes and the distances without interaction;
  - no `alert`/`confirm`/`prompt`, no downloads, no print button; `localStorage` only for per-viewer conveniences, wrapped in try/catch;
  - deliberate design: a palette and type pairing chosen for this subject (not the generic looks — cream-and-terracotta, near-black with one neon
    accent, purple gradients, Inter everywhere); labels readable in both themes; `prefers-reduced-motion` respected.
- You may look at the rendered page **once** before handing back (one headless screenshot of the local file, network off), then make one pass of edits.

## Rules

- **No children: do not use the Agent tool, a fork, a workflow, or anything else that starts another agent.** Delegation is one level deep
  (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can only review work it knows about. If the work does not fit, stop at
  a clean boundary, save, and tell `"main"` what is left.
- **Touch only** `visualizations/proof-atlas/`, `data/viz/proof-atlas/` and `tools/viz_proof_atlas_*.py`. Never edit the front files, the plans or any
  other agent's files. Never read credential files (`.env`, auth files, keyrings).
- **No searching for finite witnesses** (the ban runs to 2026-10-01); nothing here needs a solver.
- Jobs over about 2 minutes or 2 GiB run under `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`.
- **Contact:** only `"main"`; never message any other agent.
- **Commits:** by explicit path (never `git add -A`), subjects "VIZ-ATLAS: stage n". Push after each; never amend or force-push. On a race,
  `git fetch origin` and `git merge --ff-only origin/main`, then push.
- **Report** by SendMessage to `"main"`, in at most 15 lines: the page's path, the node and edge counts, the check's result, the credence defaults and
  where each came from, what you left out, and anything you could not source. Your final turn's text: "VIZ-ATLAS idle; report sent to the owner by
  SendMessage".

Thank you.
