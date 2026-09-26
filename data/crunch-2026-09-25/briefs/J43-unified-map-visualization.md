*Brief for crunch job **J43**, the crunch's bookend: a new visualization that unifies the project's findings. It runs **after the
crunch's scoring (J25)**. Opus 5.5. Written by the product owner at Kooshi's request, 2026-09-25.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`, and for this job you
are the **designer and builder of one visualization**. Read `CLAUDE.md`, `WORKFLOW.md` (including "How to report to the user") and
`DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your directory already exists, you are resuming.** Read your `DESIGN.md` and `git log -- visualizations/<your dir>`, then continue at
the first stage not SAVED.

## What Kooshi asked for, verbatim

> I'd like a session to create a new visualization (in the ./visualizations dir) which somehow unifies our findings. The intent is for me
> to better understand, explore, and see what we now know, in a way that I can explore patterns. A lot of our recent work has been deep in
> domains I don't have a strong grasp of, though I've grown to understand them at a surface level. Seeing it all together would help me
> catch up to you and ask better questions. The difficulty is that it must unify the findings in some way, unlike the previous atlas
> visualizaitons. I want to be able to see where our knowledge has solidified, and where it is sparse. The structure of the colorings we
> own, and the shadows of the ones we don't. I want to see the walls, both standing and broken. All of this expressed in geometry,
> coordinates, and colors more than the symbols of math.

Read it as a specification. Each sentence is a requirement:
1. **One unifying frame.** Choose one coordinate system in which fields, places (primes, and the real place), colour counts, colourings and
   theorems all live. The previous visualizations, `visualizations/unit-distance-atlas/`, `finite-plane-atlas/` and `wall-at-six/`, are
   catalogues: one object at a time, or one question. This one is a map. Read all three READMEs and pages first, so you know what not to
   repeat.
2. **Solid and sparse.** Every result carries a grade: kernel, certificate, hand with two derivations, hand with one mind, measured,
   reading, or open (§ Notation). Encode that grade as *solidity* in the geometry: fill, opacity, texture, edge. Also encode how densely the
   theorems cover each region (`LEDGER.md` § B indexes 675 of them, each with a home and a grade). A region nobody has worked must look
   empty, not blank.
3. **The colourings we own.** Draw residue colourings (local at one place), character colourings, dyadic pullbacks, periodic and window
   colourings, and the plane's 7-colouring, each where it lives in the frame.
4. **The shadows of the colourings we don't own.** Draw the wanted posters: what a counterexample would have to be. Four colours over
   ℚ(√47); a non-pullback four-colouring over ℚ(√59); five colours over ℚ(√167); a six-colouring of the plane. Take them from the Poros
   wanted-poster records J37–J39 and `plans/POROS-2026-09-25-infinitely-many-primes.md`. Draw each as the region left over once every
   excluded format is carved away. For example, tonight's result says such a colouring must "read infinitely many primes", which can be
   shown as a shadow that runs off the edge of finitely many places.
5. **The walls, standing and broken.** Draw each no-go or barrier as a boundary in the frame. Examples: the 2-adic wall; the 3-adic barrier;
   the wall at six (the window planes 23, 27, 31, 43, 47 and U₆₄); the linear instruments' blindness above four; the one-prime failure of
   band rigidity; the cell-local four-colour no-gos; the in-field descent. Mark a *standing* wall differently from a *broken* one (a wall a
   result got past, with the result that broke it). Kooshi's observation belongs here (post-close inventory row 25): walls show up as
   counterexample invariants, and breakthroughs came from example invariants. If the frame can show both kinds, it should.
6. **Geometry, coordinates and colour over symbols.** Plain English everywhere a reader meets text: tooltips, legends, a guided first view.
   No identifier is ever the noun (WORKFLOW's reporting rule applies to the page). Every mark, hovered or clicked, says what it is in plain
   English, its grade, and its source address in the repository.
7. **Explorable, for asking better questions.** Provide filters (by grade, by colour count, by field family, by place), a way to follow one
   field or one prime across the whole map, and a way to see what changed in the crunch of 2026-09-25. A question Kooshi asks while looking
   should be answerable by looking.

**Candidate frames** (starting points only; choose, combine or replace them, and justify the choice in `DESIGN.md` against at least two
alternatives):
- **Fields by places.** One axis carries fields (ordered by the arithmetic of 2 and 3, or by discriminant); the other carries places.
  Each cell shows that local target's chromatic number, and each field carries its proven bracket for χ. A colouring we own lights one
  place; a shadow must light infinitely many.
- **The colour-count ladder.** Levels k = 2 to 7. Each field sits at its bracket, and each instrument is a band showing where it stops.
- **The character torus.** Bands `[1/k, 1 − 1/k]`, torsion points and archimedean discs, where CLG, band rigidity and the "infinitely many
  primes" theorems are pictures.

The G-entries in `CLAUDE.md` § Grokkings are the working theory. The frame that makes the most of them visible at once is probably the
right one.

## Data and truth

- **Sources, current after the crunch's final front-page pass:**
  - `CLAUDE.md` (the Frontier, Where the problem stands, Grokkings, Paths forward);
  - `LEDGER.md` (rows and § B);
  - `plans/FRONTIER-STUBS.md`;
  - `plans/CRUNCH-2026-09-25-INDEX.md`;
  - `data/fplane/map.json`, `data/fs54/*.out` and `data/fs53/window.md`;
  - the closes' §R-close sections, and the Poros records.
- **Every fact in the page lives in one table** (a `FACTS` array or a JSON file beside the page). Each entry holds the value, its grade and
  its source address. Write it with a **checker** (`tools/viz_<name>_check.py`) that re-reads each fact from its source and fails loudly on
  a mismatch or an unreadable source.
- **The controls:** plant one wrong grade and one wrong number and watch the checker go red naming each; a faithful copy must pass. Bound
  every plant on both sides (`CLAUDE.md` § The gate).
- **Never draw a reading as a theorem, or a measured null as a refusal** (G21, G30). If the page cannot say what grade a mark has, the mark
  does not ship.

## Stages (save and commit after each: `git commit <paths>`, subject "J43: stage n"; push after each; never force-push)

1. **Design** (~80k): read the sources and the three previous visualizations, then write `visualizations/<name>/DESIGN.md`. It holds:
   - the frame, chosen against at least two alternatives, in WORKFLOW's four parts;
   - the encodings: which data dimension goes to which visual channel;
   - what "standing" and "broken" mean for a wall, from the records;
   - the list of facts to extract;
   - three questions Kooshi could ask of the page, each with how the page answers it.

   Run the **`debruijn-experience-modeling`** skill freshly on the design: the consumer is Kooshi, and the surface *is* the purpose.
2. **Data** (~80k): the facts table and its checker, with the controls fired.
3. **Build** (~120k): a self-contained page, `visualizations/<name>/index.html` (no build step, or a small `build.py` as the unit-distance
   atlas has). Before writing the page, **load the `artifact-design` skill** (the Artifact tool's page contract: title, colour tokens with a
   dark mode, allowed CDNs, phone width).
4. **Publish and hand over** (~30k): publish the page with the Artifact tool as a private artifact. Put its URL in
   `visualizations/<name>/README.md` beside the sources, in the style of the other READMEs. Write a one-screen "how to read this map" into
   the page itself. If the Artifact tool is not available to you, say so in the report and I will publish.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left; a successor can take the build from your `DESIGN.md`.
- **Touch only** `visualizations/<name>/`, `tools/viz_<name>_*`, and `data/viz/<name>/`. Never edit `CLAUDE.md`, `LEDGER.md`, plans or
  records. If you find an error in a source, report it; do not fix it.
- **No finite-witness search** (the ban runs to 2026-10-01). Exact computations in the page, like the finite-plane atlas's spectra, are
  fine; an in-page colouring finder is not.
- **Commits by explicit path**, subjects "J43: stage n". End commit messages with your harness's attribution lines. Push after each
  commit; never force-push.
- **Budget:** about 330k by the harness's count; hand back by 420k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J43.md`, committed, and by SendMessage
  `to: "main"`. Include the artifact URL and the three questions from stage 1. Keep your turn's final text content-free: "J43 idle; report
  sent to the owner by SendMessage".

Thank you.
