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
| missing | hollow, red, dashed, with a question mark; an open question not yet reduced to named steps gets a second dashed ring |
| follows once its premises hold | hollow, dashed, in the answer's hue (the open halves `χ ≥ 7`, `χ ≥ 6`, `χ ≤ 6`, `χ ≤ 5`, and the conclusions such as `χ_m⁰(ℝ²) ≥ 7`) |
| role | circle a theorem or step; **octagon a no-go**; diamond an exact object (the strip, the disk, Parts's tiling); square Lean work |
| a no-go's effect | a maroon edge ending in a bar into what it rules out |
| FS-112 closing tonight | a long-dashed ring in the seven hue; claims under blind verification tonight add an amber dotted ring |
| a held half of an answer | the answer's disc half-filled on the side of the held bound (7 on its `≤ 7` side, 5 on its `≥ 5` side; 6 empty) |
| the centre | the kernel's own seven-colouring behind the answers: 4/5 × 3/5 bricks, each row shifted 2/5, coloured (column + 3·row) mod 7 (`Instances/Seven.lean`); one cell's diagonal is drawn, exactly the unit distance |

Grades are the source's own words, folded to the page's statuses by one rule (`tools/viz_proof_atlas_common.py` `fold`), in order: a gap word
("GAP", "gaps", "open", "not claimed", a question, a stub's title) → missing; "kernel" → kernel; "exact checker" or "ACCEPT … exact" →
certificate; "external" or "in print" → in print; "reading", "a reading" or "conjecture" → belief; "blind" → hand, two minds, one blind; "two/three
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
| certificate | 0.99 | exact objects rebuilt twice blind and accepted by two exact checkers (the strip, the disk) |
| hand, two minds, one blind | 0.95 | `LEDGER.md` row 77, the theorem audit: "184 hand, 23 derived, 31 tools, 2 cert", one proof wrong, grades under-stated four times for each over-statement — the measured record is better than this |
| hand, two minds | 0.90 | lower than blind: `plans/FS112-unit-arc-half.md` E16 registers "a blind verifier finds a divergence of truth" at 0.4, FS-110's rate |
| hand, one mind | 0.80 | a stated default |
| in print, not re-checked | 0.90 | a stated default (Einsiedler–Lindenstrauss's Thm 1.3; Parts's tiling) |
| belief | 0.50 | a stated default; the conjecture is drawn but counted in no route |
| missing step named by a reduction | 0.30 | anchored on `plans/FS112-unit-arc-half.md` E14: "a NO of Q-full at one mind with every GAP named, within P1", 0.3 |
| open question not yet reduced | 0.03 | anchored on the one registered credence for a question of the answer's size, E5: "a YES by formula (0.03)" |

**Registered probabilities used in place of the defaults:** a tight six-map (the YES), 0.03 — `plans/FS112-unit-arc-half.md` E5, population
"within FS-112 … given by formula and accepted exactly, among asymmetric curved maps with unit-arc seams and four-colour vertices"; the cone scale
(door B), 0.15 — `plans/STUB-reg-scale.md`, "a cone-scale bound for near-optimal colourings at one mind, 0.15". The stubs of FS-104, FS-80 and
FS-44 give only words ("success low", "soft as to success", "soft as to truth"); the page shows those words on each card and uses the default.

**At the defaults** (the page recomputes live): seven **8.91 bits** (four named missing steps; 16 links not in Lean); six **10.6 bits** (two
open questions; 7 links); five **5.28 bits** (one open question; 3 links); the classical interval 0; five by measure rigidity 0.30 (a second
proof of a held bound). **What the numbers are not**, stated on the page: a credence is an instrument (§ Counter-priors rule 2), never evidence;
a belief about the answer is not evidence for it (§ The local–global conjecture, G64); the numbers are not a ranking (§ Counter-priors rule 1);
and they count only named steps — the route to seven is analysed furthest, so more of its cost shows, while a route resting on one open question
hides the steps inside it. The page puts the counts of named steps and open questions beside every distance for that reason.

## 4. The facts, and the check

- **One table**, `data/viz/proof-atlas/facts.json`, written by `tools/viz_proof_atlas_facts.py` from hand-authored entries: 61 nodes, 73 edges,
  9 routes, 9 credence defaults, 4 notes. Every node carries its plain statement, a verbatim quote at an address (a `LEDGER.md` row, an item of
  `plans/FS112-close-inventory.md`, a row of `plans/FS112-N-proof.md`'s tables, a section of `CLAUDE.md` or of a plan, a stub, or a Lean
  declaration), the source's grade words at their own address, and any registered probability with its population. Every edge carries the quote
  that establishes it.
- **The checker**, `tools/viz_proof_atlas_check.py`: re-reads every quote from its address (after removing markdown marks and collapsing
  whitespace); re-folds every grade from its words; confirms each `@lean` declaration exists; confirms each registered number stands in its quote
  and at its address; confirms every route reaches its half-answer along the edges; refuses any address inside tonight's fenced files before
  reading. Result: **checked 151, failed 0, errors 0.**
- **Controls** (`--self-test`, PASSED): the faithful table passes; seven plants each fire exactly once, naming their fact — a wrong grade (MR
  called kernel), a dead address (row 999), a missing file (ERROR), a quote not in its source, a wrong registered probability (0.03 → 0.3), a
  fenced address, a route link that is no node — and the fenced file is confirmed never opened.
- **`build.py`** runs the checker, refuses to build when it fails, inlines the table and asserts the page contract (no doctype, html, head or
  body tags).

## 5. Scope

**The routes drawn** (each verified against the files): the classical interval (row 33); five algebraically through measure rigidity (rows 120,
121); the regularity wall toward seven (§ The aim links 1–6; rows 128, 130–134; FS-112's reduction; FS-111); the YES side, bounded and unbounded
complexity (rows 131, 133; the strip and the disk; FS-112 E5); six from below by `χ_CP`, by an averaged certificate, and through ℚ(√167) (FS-104,
FS-80, row 125, FS-59); exactly five (FS-44); and the local–global structure (rows 52, 99, 119, 123, 127; the conjecture as a belief). Lean work:
row 127, FS-101, FS-113 and the wall's own chain.

**Left out, deliberately:** the finite-plane window and residue towers (rows 68–75: they bound fields, and the collapse makes the plane's question
archimedean); the kernel toolbox of rows 1–118 beyond what a route uses; the null-set step to Falconer's everywhere-proper `χ_m` (row 130's GAP; it
does not bear on the answer given MR); FS-62, FS-64, FS-109, FS-49, FS-108 and stubs ranked 13 and below; the (A)-by-compactness step
(`plans/FS112-unit-arc-half.md` E17, one mind), folded into the edge "no tight six-map ⟹ χ_m⁰ ≥ 7" as the frontier table states it
("decisive jointly with row 134 … and FS-112's unit-arc half").

**Could not source (fenced tonight):** FS-114's and FS-115's stubs and any registered probabilities they carry (the two gaps use the default);
how the two gaps compose into a NO (FS112-C is deriving it; drawn as its own missing step at the default); FS112-YB3's verdicts on Y3 (Y3's
claims are drawn at one mind, "under blind check").

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
