# The Proof Atlas — design record (job VIZ-ATLAS, 2026-09-27)

*Brief: `data/viz/proof-atlas/brief.md` (commit 968c2047), which quotes Kooshi's request verbatim: "a graph of key lemmas and theorems (those
being the nodes) with any missing theorems shown as such, and a source for each … arranged around the goal (the solution to HN) … so that I can
explore the different approaches we have, and roughly how far each is (perhaps using information theory?) from proving one answer or another."
Precedent followed: `visualizations/local-global-map/` (one fact table, a checker with controls, a build that refuses on failure).*

## 1. The frame

**The choice: a radial map with the three answers at the centre.** `χ(ℝ²) = 5`, `6` and `7` sit on a small inner circle; each is ringed by its
two halves (a lower and an upper bound). Every theorem, missing step and no-go lies outward, in a sector named for the answer it points to, so a
route reads as a path inward. Held ground falls mostly on the outer rings and the missing steps sit near the answers they would decide, which is
the picture Kooshi asked for: where the rungs are built, on which paths, and how close.

| alternative weighed | what it would have bought | why the radial map won |
|---|---|---|
| a layered DAG, left to right (held ground → answers) | the cleanest edge flow; no long edges | it puts the answers in a column at one edge, not "around the goal"; the three answers stop reading as destinations of one question |
| three ladders, one per answer, height = bits | distance read directly as height | the shared premises (measure rigidity, row 131's equivalence, W's equivalence) serve two or three answers and would be drawn two or three times |
| radius = remaining bits to the answer | distance is literally distance | every kernel-held node collapses onto the centre (0 bits), and positions jump whenever a credence slider moves, so the map never holds still long enough to learn |

**Confidence: medium.** The radial frame has long edges wherever one premise serves two answers (measure rigidity, row 131). They are routed
along an orbit (near the hub, or round the rim) and kept faint until a route, answer or mark they join is followed. If Kooshi finds the at-rest
view still too busy, the fallback is to hide the orbit edges at rest entirely.

## 2. Encodings

| data | channel |
|---|---|
| which answer a route serves | sector (angle), a faint wedge tinted with the answer's hue, and the sector's name set along the rim |
| distance from the answer, structurally | ring (radius): answers, then their halves, then the deciding steps, then their premises outward |
| grade (how solid) | **solidity**: kernel solid; certificate solid with a second ring; hand, two minds, one blind 62 % fill; two minds 38 %; one mind 18 %; in print hatched; a belief dashed amber |
| missing | hollow, red, dashed, with a question mark; an open question not split into named steps gets a second dashed ring |
| follows once its premises hold | hollow, dashed, in the answer's hue (the open halves `χ ≥ 7`, `χ ≥ 6`, `χ ≤ 6`, `χ ≤ 5`, and the conclusions such as `χ_m⁰(ℝ²) ≥ 7`) |
| role | circle a theorem or step; **octagon a no-go**; diamond an exact object (the strip, the disk, Parts's tiling); square Lean work |
| a no-go's effect | a maroon edge ending in a bar into what it rules out |
| under blind verification | an amber dotted ring (after FS-112's close: row 134, whose base steps BASE-V is re-deriving blind) |
| a question posed in print | a small flag beside the mark: filled when a result here answers it, half-filled when one reduced it without answering it, hollow when it is open; the card quotes the words that say which |
| a link held only as a reading | dashed amber, like a belief, and counted in its route (the meeting of the two doors to seven, FS107-MEET) |
| a held half of an answer | the answer's disc half-filled on the side of the held bound (7 on its `≤ 7` side, 5 on its `≥ 5` side; 6 empty) |
| the centre | the kernel's own seven-colouring behind the answers: 4/5 × 3/5 bricks, each row shifted 2/5, coloured (column + 3·row) mod 7 (`Instances/Seven.lean`); one cell's diagonal is drawn, exactly the unit distance |

Grades are the source's own words, folded to the page's statuses by one rule (`tools/viz_proof_atlas_common.py` `fold`), in order: a gap word
("GAP", "gaps", "open", "not claimed", a question, a stub's title) → missing; "kernel" → kernel; "exact checker" or "ACCEPT … exact" →
certificate, and so do "exact" with "checker(s)"; "external" or "in print" → in print; "reading", "a reading", "a one-mind reading" or
"conjecture" → belief; "blind" → hand, two minds, one blind; "two/three
minds, derivations, readings" → hand, two minds; "hand", "one mind" → hand, one mind. A Lean declaration (`@lean`) is kernel only if the checker
finds it. The card always shows the words themselves beside the folded status.

## 3. The distance measure

Each link of a route gets a credence `p`, the chance it holds as a proved step. A route's distance is its **surprisal**,
`d = Σ −log₂ p` over its links, in bits (links taken as independent). A route wholly in the kernel is at 0 bits. An answer needs both halves:
seven needs `χ ≥ 7` (the kernel holds `≤ 7`), five needs `χ ≤ 5` (the kernel holds `≥ 5`), six adds its nearest lower route to its nearest upper
route. **Distance to publication** is a count beside it: the route's links not yet in Lean (Kooshi: "Anything we do must be formalized in Lean
before publishing").

**Default credences** (all adjustable on the page; changes stay in the viewer's browser):

| status | p | where it comes from |
|---|---|---|
| kernel | 1.00 | checked by the kernel: 0 bits |
| certificate | 0.99 | exact objects accepted by exact checkers (the strip and the disk, rebuilt two or three times; the bowtie once, one checker) |
| hand, two minds, one blind | 0.95 | `LEDGER.md` row 77, the theorem audit: "184 hand, 23 derived, 31 tools, 2 cert", one proof wrong, grades under-stated four times for each over-statement — the measured record is better than this |
| hand, two minds | 0.90 | lower than blind: `plans/FS112-unit-arc-half.md` E16 registers "a blind verifier finds a divergence of truth" at 0.4, FS-110's rate |
| hand, one mind | 0.80 | a stated default |
| in print, not re-checked | 0.90 | a stated default (Einsiedler–Lindenstrauss's Thm 1.3; Parts's tiling) |
| belief | 0.50 | a stated default; the local–global conjecture is drawn but counted in no route; the meeting of the two doors (FS107-MEET, "a one-mind reading") counts on the route to seven |
| missing step named by a reduction | 0.30 | anchored on `plans/FS112-unit-arc-half.md` E14: "a NO of Q-full at one mind with every GAP named, within P1", 0.3 |
| open question, not split into named steps | 0.03 | anchored on the one registered credence for a question of the answer's size, E5: "a YES by formula (0.03)"; since FS-112's close it also prices FS-114's global step, the whole remaining unit-arc question |

**Registered probabilities used in place of the defaults** (only where the registration is for the link's own event): a tight six-map (FS-114's
YES), 0.03 — `plans/STUB-global-step.md`, "a YES by formula | 0.03"; the cone scale (door B), 0.15 — `plans/STUB-reg-scale.md`, "a cone-scale bound
for near-optimal colourings at one mind, 0.15"; the stuck ray (b′), 0.35, and bounded chains (b″), 0.25 — `plans/STUB-stuck-ray.md` (on no route).
**Shown on the card but not used:** FS-114's "the global step decided (NO or YES) at one mind within FS-114 | 0.2" — decided either way, a different
event from the NO holding, so the NO keeps the open-question default and the bits do not make it look smaller than it is; FS-114's "a NO for doubly
periodic maps (the four-colour form), one mind | 0.3", on the four-colour form's card. The stubs of FS-104, FS-80 and FS-44 give only words
("success low", "soft as to success", "soft as to truth"); the page shows those words on each card and uses the default.

**At the defaults, after FS-112's close** (the page recomputes live): seven **10.0 bits** (FS-114's global step as one open question, 5.06; FS-111's
cone scale, 2.74; the doors' meeting as a reading, 1.0; the composition at one mind, 0.32; 15 of 17 links not in Lean); six **10.6 bits** (two open
questions; 7 links); five **5.28 bits** (one open question; 3 links); the classical interval 0; five by measure rigidity 0.30 (a second proof of a held
bound). Version 1 read seven at 8.91 bits over four named steps; the rise is the honest price of FS-112's result — the NO is one whole question, not
three small steps and a composition. **What the numbers are not**, stated on the page: a credence is an instrument (§ Counter-priors rule 2), never
evidence; a belief about the answer is not evidence for it (§ The local–global conjecture, G64); the numbers are not a ranking (§ Counter-priors rule
1); and they count only named steps — a route resting on one open question hides the steps inside it. The page puts the counts of named steps, open
questions and readings beside every distance for that reason.

## 4. The facts, and the check

- **One table**, `data/viz/proof-atlas/facts.json`, written by `tools/viz_proof_atlas_facts.py` from hand-authored entries: 68 nodes, 84 edges,
  9 routes, 9 credence defaults, 4 notes, 5 posed-question marks (after FS-112's close). Every node carries its plain statement, a verbatim quote at an address (a `LEDGER.md` row, an item of
  `plans/FS112-close-inventory.md`, a row of `plans/FS112-N-proof.md`'s tables, a section of `CLAUDE.md` or of a plan, a stub, or a Lean
  declaration), the source's grade words at their own address, and any registered probability with its population. Every edge carries the quote
  that establishes it.
- **The checker**, `tools/viz_proof_atlas_check.py`: re-reads every quote from its address (after removing markdown marks and collapsing
  whitespace); re-folds every grade from its words; confirms each `@lean` declaration exists; confirms each registered number stands in its quote
  and at its address; confirms every posed question's state is what its words say; confirms every route reaches its half-answer along the
  edges; refuses any address inside tonight's fenced files before reading. Result: **checked 169, failed 0, errors 0.**
- **Controls** (`--self-test`, PASSED): the faithful table passes; eight plants each fire exactly once, naming their fact — a wrong grade (MR
  called kernel), a dead address (row 999), a missing file (ERROR), a quote not in its source, a wrong registered probability (0.03 → 0.3), a
  fenced address, a reduced question marked answered, a route link that is no node — and the fenced file is confirmed never opened.
- **`build.py`** runs the checker and the palette review, refuses to build when either fails or when the two dark token blocks disagree, inlines
  the table and asserts the page contract (no doctype, html, head or body tags).

## 5. Scope

**The routes drawn** (each verified against the files): the classical interval (row 33); five algebraically through measure rigidity (rows 120,
121); the regularity wall toward seven (§ The aim links 1–6; rows 128, 130–136; FS-114's global step; FS-111; the doors' meeting as a reading); the
YES side, bounded and unbounded complexity (rows 131, 133, 136; the strip and the disk; FS-114's YES); six from below by `χ_CP`, by an averaged
certificate, and through ℚ(√167) (FS-104, FS-80, row 125, FS-59); exactly five (FS-44, FS-104's NO); and the local–global structure (rows 52, 99,
119, 123, 127; the conjecture as a belief). Beside the route to seven, not on it: the four-colour form of the NO with FS-115's two steps, the stuck
ray (b′) and bounded chains (b″), and the lemmas toward them (N3-PER, N3-END, Y3-END-NEEDS as corrected, C-HORNEND with C-DOUBLE, the bowtie).
Lean work: row 127, FS-101, FS-113 and the wall's own chain.

**Left out, deliberately:** the finite-plane window and residue towers (rows 68–75: they bound fields, and the collapse makes the plane's question
archimedean); the kernel toolbox of rows 1–118 beyond what a route uses; the null-set step to Falconer's everywhere-proper `χ_m` (row 130's GAP; it
does not bear on the answer given MR); FS-62, FS-64, FS-109, FS-49, FS-108 and stubs ranked 14 and below; FS-112's other local lemmas (the § B lines
of rows 135–136: U1, SIX, NB4P, L60, LOCK, BEND, N2-RED, the pencil, the dial, the disc bound and the rest); C-ENDS and C-PARTNERS (quoted on the
cards of the four-colour form's neighbours and of the rhombus lemma, not drawn).

**Fenced (not read):** BASE-V's files (`plans/BASE-V-verification.md`, `data/base-v/`, `tools/base_v_*`), a blind verifier re-deriving row 134's
base steps tonight. Row 134 is drawn at its printed grade with the "under blind check" ring.

## Stage 1 — SAVED: the fact table and its checker (commit be8d53ce)

## Stage 2 — SAVED: the page

`page.tmpl.html` (no library; Google Fonts for Newsreader, Atkinson Hyperlegible and IBM Plex Mono, each with a fallback stack), `build.py`,
`index.html` (≈ 137 KB). **The one look** (a headless Firefox screenshot of the local file, network cut by `unshare -rn`, 1440 px wide; fonts
fell back, as expected offline) showed the frame working and one defect: edges routed along the orbits read as stray rings round the hub and
the rim, and two long "blocks" edges circled the whole rim. **The one pass of edits:** orbit edges faint at rest and brought forward when a
route, answer or mark they join is followed; long "blocks", "predicts" and "formalizes" edges shown only then. Not re-looked, per the brief.

## Theorems this phase proved

None. The job built an instrument; its only computation is the surprisal sum.

**Would have searched here:** none. Nothing here is a search.

## VIZ-ATLAS-2, stage 1 — SAVED: the theme control and the dark palette

*Brief: `data/viz/proof-atlas/brief-2.md` (commit 1c51a103). Kooshi: "Can you have the agent update it to have a dark mode please?" The page
already carried dark tokens that followed the viewer's system setting; he did not see them.*

**The control.** A three-way switch at the top right of the page, beside the eyebrow: System, Light, Dark. Light and Dark stamp `data-theme` on
the root element; System hands the page back to whatever the viewer's host stamped there at load (the artifact viewer stamps `data-theme` on an
explicit choice of its own and nothing on "system"), or to the device's `prefers-color-scheme` when it stamped nothing. The choice is remembered
per viewer in `localStorage` under `proof-atlas:theme`, every read and write in try/catch. It is applied by a small script placed before any
markup, so the page never paints the other theme first. A `MutationObserver` keeps an explicit page choice on top when the host re-stamps the
root later, capped at ten re-applications so a host that fights back cannot loop.

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| a segmented System / Light / Dark switch in the masthead | a single sun/moon toggle cycling light and dark | a two-state toggle cannot give the page back to the viewer's own setting, and "System" is what most viewers want | high |
| System restores the host's stamp, not "no attribute" | System always removes `data-theme` | removing it would override a viewer who chose Dark in the claude.ai viewer itself | medium: if the viewer never stamps the root, the two are the same |
| apply before the markup, in its own early script | wire it inside the main script at the end of the page | the main script runs after the whole page is parsed, so a Dark viewer would first see the light page | high |

**The dark palette, reviewed as its own design.** The dark ground stays a deep slate-teal (`#0f1618`, panel `#151f22`), the night version of the
light theme's cool survey paper; the text stays chalk (`#dde7e4`). What changed is the set of hues, placed around the LCh circle so the marks
that meet on the map stay apart by hue where dark ground forbids separating them by lightness: no-go a raspberry rose (h 2°, `#d7678a`), a
missing step vermilion (38°, `#fe7d63`), five amber (70°, `#e8a65d`), a belief straw-gold (96°, `#ebd563`), six sea-green (172°, `#68caae`),
the selection ring cyan (222°, `#4cceea`), seven cornflower (274°, `#7aaaf0`), in print orchid (312°, `#b498cb`). In version 1 the selection
ring and the seven hue were one colour in dark (CIELAB distance 12: a selected seven-hued mark showed no ring), and seven and in print were 13
apart. The brick hub's opacity rises from .16 to .20 in dark, where tints over a near-black lose their colour: its seven tints now span
distances 6 to 25 (version 1: 3 to 18), so the kernel's seven-colouring reads behind the answers instead of as a grey mottle.

The light palette kept its look, with three corrections the same review found: in print moves from slate to plum (`#7b5a87`; it was 16 from
seven), a belief from olive-gold to a yellower gold (`#8d7c08`; 28 from five, was 22), and the label halo from the ground colour to the
panel colour, so a dark label on the light map is knocked out in white rather than ringed in grey. In both themes the route bars' held
segments gained opacity (one mind .26 → .38, two minds .38 → .50, one blind .50 → .66; missing .70 → .80, an open question 1), and the side
panel's scrollbar is thin and quiet (the dark scheme's default thumb is a bright bar).

**The numbers** (`python3 tools/viz_proof_atlas_contrast.py` prints them all). Gated: every text token and answer hue at ≥ 4.5 on ground and
panel (the lowest: light muted 4.81 on the ground; in dark, muted 6.21 on the panel); every mark hue at ≥ 3.0 on the panel (lowest: light belief 3.99); every
pair that meets on the map at CIELAB distance ≥ 20 (lowest: light seven/in print 23, dark 25). Version 1's palette fails three of these pairs
(light seven/in print 16; dark seven/selection 12, seven/in print 13). Reported, not gated: the solidity ladder (lightness 16, 26, 50, 69, 85,
98 in light; 91, 84, 63, 44, 28, 11 in dark: the same steps mirrored); the hatch's mean tone (between two minds and one mind in both themes);
the route-bar segments against their track, weakest for a light one-mind segment (2.15), which carries at most a third of a bit and whose
grade is repeated in the route's link table.

**Controls.** `build.py` now refuses when the two dark token blocks differ or declare a token the light palette lacks (planted: `--nogo` changed
in one dark block, and a dark-only token; each refused with its name, and the page was not rewritten), and when the palette review fails.
`tools/viz_proof_atlas_contrast.py --self-test`: the faithful palette passes; a pale light text token (muted `#9aa6a7`) and the dark selection
ring moved onto the seven hue each fire exactly once.

**The one look.** One headless Firefox screenshot per theme (1440 px wide, network cut by `unshare -rn`, fonts fell back offline), each through
a copy of the page in the publish skeleton; the dark one stamps `data-theme="dark"` as the viewer does, so it also exercised System following
the host. Both themes read as designed: the rose no-go octagons and vermilion missing steps are distinct at a glance in dark, the hub's bricks
read as seven colours, and the labels hold on every wedge. One defect: in dark the side panel's scrollbar thumb was a bright bar the height of
the panel. **The one pass of edits:** a thin scrollbar coloured from the rule token, in both themes. Not re-looked.

## Theorems this phase proved

None. The stage is a control and a palette; its only computations are contrast ratios and colour distances.

**Would have searched here:** none. Nothing here is a search.

## VIZ-ATLAS-2, stage 2 — SAVED: FS-112's close folded in

*The owner's stage-2 message, after commit a9410925: FS-112 closed undecided (rows 135–136); the ranking is NIGHT-A's (FS-114, FS-111, FS-104,
FS-115); the composition makes the global step the NO with no ray step; FS-111 plus FS-114's NO giving seven is a one-mind reading; FS-104's bearing
corrected; FS112-YB3's verdicts; BASE-V fenced.*

**What the checker named first:** 14 facts had moved — the re-rank shifted every `PF(n)` address (FS-44 to 7, FS-80 to 8, FS-59 to 13), FS-104's
bearing was rewritten, and item 31 of § Where the problem stands no longer says "with unit arcs, open".

**What changed on the map.**
- **The route to seven, redrawn.** Version 1 drew the stuck ray as a required link and the composition as a missing step. Now: row 134 → N3-BASE →
  N3-DENSE3 → the global step (FS-114) and the composition (FS112-C-COMPOSE, one mind) → the unit-arc NO → door (A) → the doors' meeting → `χ_m⁰(ℝ²) ≥ 7`.
  The global step is drawn as an open question, the whole remaining unit-arc question, and its card says so; the stub's 0.2 (decided either way) is
  shown there and not used. The meeting of the two doors (FS107-MEET) is a new mark held only as a reading, with the night advisor's first question
  and hunch quoted as its killing test.
- **The stuck ray, beside the route.** FS-115's (b′) and the new (b″) feed the four-colour form of the NO by dotted context edges, labelled "needed by
  this form, aperiodic maps only"; N3-PER says periodic maps need neither. Its lemmas: N3-END, Y3-END-NEEDS as corrected (one mind for its scope; false
  as first stated), C-HORNEND with C-DOUBLE, and the bowtie, an exact fragment that refutes Y3-END-NEEDS as first stated and is a local positive a YES
  could use.
- **The YES side.** The strip and the disk now carry row 136's grades (three and two rebuilds, exact checkers); the pinned-corner obstructions
  (FS112-Y3-PIN) are two minds, one blind; the rhombus lemma (FS112-N3-COR3) explains the stop. FS-114's YES keeps 0.03, now from FS-114's stub.
- **FS-104, two-sided.** Its YES gives `χ(ℝ²) ≥ 6` given MR; its NO is a stationary five-colouring, FS-44's question, drawn as a context edge.
- **Posed questions.** A flag marks each question posed in print: Sokolov–Voronov's Question 2 answered for its Condition-5 half (row 134) and
  reduced, not answered, with unit arcs (row 135); Moorhouse's question and Soifer 55.1's existence half (row 121) and Ducz–Varga's Conjecture 1 and
  Matolcsi et al.'s equality question (row 129) answered given MR; Graham's $1,000 problem open. FS-112's close answered none.
- **Row 134 under blind check** (BASE-V); the "FS-112, closing" rings are gone.

**The one look** (one headless screenshot per theme, network cut, the page in the publish skeleton): both themes read; the seven sector holds its
new marks with no overlapping labels (the layout lint read 0 after moving eleven marks and folding C-DOUBLE into C-HORNEND's card). One defect: the
route bar drew the reading link as a grey held segment. **The one pass of edits:** reading segments in the reading colour (and the palette review
reports them: 2.68 against the track in light, 7.15 in dark). Not re-looked.

## Theorems this phase proved

None. The job folds a close into an instrument.

**Would have searched here:** none. The layout was placed by hand against the lint; nothing here is a search for a finite witness.


## FS129-F1 — SAVED: FS-129's record folded in

*The filing job FS129-F1 (`data/fs129/f1/README.md`); the coordinator's amendment R2 of `data/fs129/briefs/FS129-F1-front-page.md`.*

**What the checker named first:** 9 facts (three already failing on `main`: R134's second quote, FS124's grade words, the "publish" note). Six moved with
the filing: FS123's and FS120's title quotes (re-aimed names), FS104's registration and `PF(3)` text, FS-59's `FSR(20)` (now 21) and the BOWTIE→TSMYES
edge's row (18, now 19).

**What changed on the map** (every quote verbatim at its address; the checker reads 212, failed 0, errors 0):
- Three marks added from FS129-Z2's draft: QFREE (row 149, no-go), QPRUNE (row 150, held), TOP5 (row 154, held), with the edges GFREE→QFREE ("rests"),
  QFREE→LOCALF and QPRUNE→LOCALF ("context"). Positions chosen by `data/fs129/f1/place_atlas.py` against the lint: QFREE (84, 520), QPRUNE (80, 540), TOP5 (162, 434).
- Re-pointed quotes: FS123's title quote now "the Siamese class: …"; FS120's "the pinch at a junction, and the cover route at five: …"; FS-59's row address
  `FSR(21)`; the BOWTIE→TSMYES edge's row "19".
- Re-pointed by ruling R2: R134's second quote now at `plans/FRONTIER-STUBS.md` § Open milestones, in order, "with BASE-V beside them (row 134's base
  re-derived but for Lemma 4 at cusps)"; FS124's grade words now "The main remaining case set of the six-map NO with unit arcs, and the YES side's home"
  (`plans/STUB-q-ring.md`); the "publish" note's text and quote now "Nothing is published before it is formalized in Lean, in full."
- **FS-104's verbal registration removed**: its row in `CLAUDE.md` § Paths forward, as filed by FS129-P1, gives none ("success low, a named no-go the
  likely product" is gone from it), and the atlas takes a stub's registration only for that event.
- The FS123 node's label and plain text read "the Siamese class" (ruling R2). Not changed, not asked: the FS128 and FS120 nodes' labels ("the six-colour
  rungs", "the pinch at a junction"), and the edge FS123→LOCALF's quote "the (Q)-free ring", which still stands in its stub.

**The one look:** not done (no headless screenshot taken in this job). **Distances at the defaults:** not read; the build wrote `index.html` (176,030 bytes) and the page computes them.
The layout lint reads 0 overlaps. Palette review 0 failed; its self-test and the checker's self-test pass.

## Theorems this phase proved

None. The job folds a close into an instrument.
