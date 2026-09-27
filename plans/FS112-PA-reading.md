# FS112-PA — FS-112's reading job (phase P0): Polymath16 threads 6–9 and 16, `[Coulson2004]`'s figures, `[Soifer2024]` on nice colourings

*Job FS112-PA, Opus 5.5, launched 2026-09-27 at HEAD `f409fd5d`. Brief: `data/fs112/briefs/PA112-reading.md` with
`data/fs112/briefs/STANDING-RULES.md`. Reading and quotation only: no derivation, no repair, no fitting of figures, no search (standing rule 3).
Products: `data/fs112/fs112-pa/extracts.md` (the verbatim extracts), this record (stages, grades of the print claims, reading status, proposed
bibliography rows). Reading aid: `data/fs112/fs112-pa/split_threads.py` splits the held one-line-per-thread text into numbered comments
`[TT.n] author | date`; the **unique verbatim phrase** beside each locator is authoritative (grep it in
`~/source/library/notes/polymath16-threads-1-18-text.txt`). `ag24ag24` is Aubrey de Grey's handle.*

## Theorems this phase proved

None (a reading job).

## Stage 1 — SAVED (quotation check, standing rule 5)

Every quotation in the brief, and every quotation the claim list (`data/fs112/claims.md` §§2, 6) and the plan (`plans/FS112-unit-arc-half.md` §PA
row 3) take from the sources this job reads, checked against the held text:

| quoted | where quoted | verdict |
|---|---|---|
| thread titles "Wrestling with infinite graphs", "Upper bounds", "More upper bounds", "Searching for a 6-coloring" | brief § Why | **exact** (threads 6, 7, 8, 9 headers) |
| thread 16 | brief § Why (unquoted) | its title is "Writing the paper and chasing down loose ends, II", posted May 11, 2020 |
| "figures not viewed" | brief § What to read, item 2 | **exact** (`BIBLIOGRAPHY.md` l. 137 and l. 518) |
| HOCK, first sentence "So far all possible tesselations that use some other kind of boundary can be reduced to one using only straight lines and unit radius arcs." | claims §6 | **exact**; Bernhard Hockertz, thread 6, June 8, 2018 at 1:11 am (`[06.31]`) |
| HOCK, second sentence "The curvature of the boundary is limited …" | claims §6 | **exact** up to the apostrophe (the source has `that’s`, U+2019; claims.md types `that's`); Bernhard Hockertz, thread 6, **June 13, 2018 at 1:19 am (`[06.91]`) — a different comment from the first sentence**, five days later |
| "One thing all of these efficient tilings have in common …" | plan §PA row 3 | **exact**; `[06.31]`, the same comment as HOCK's first sentence |
| "If B is a pentagon there must be another cell C touching B with the same colour as A. This necessitates an arc of radius one between B and C joining vertices W to U." | plan §PA row 3, **attributed to "Aubrey de Grey (ag24ag24)"** | text **exact**; **attribution WRONG**: the comment is **Philip Gibbs**, thread 6, June 14, 2018 at 3:57 am (`[06.62]`, locator "Cell A touches cell B at a vertex V with valency (at least) 4"). A correction owed to the plan's §PA row 3 and to every place that calls this "de Grey's degree-4 sketch" (the brief; claims §2's framing of the print claims) |
| C-V56 "those six tiles must jointly cover a disk of radius 1 centred on V, … defined by its vertices." | claims §2, sourced "Polymath16 thread 7 or 8, a comment by Aubrey de Grey" | **exact**; **thread 8**, ag24ag24, June 28, 2018 at 2:23 pm (`[08.17]`) — the "7 or 8" resolves to 8 |
| Gibbs "The definition of a constraint I am using is …" | plan §PA row 3 | **exact**; Philip Gibbs, thread 8, June 29, 2018 at 2:56 pm (`[08.39]`) |

Splitter check: the count of ` says: ` headers per thread equals the count of comments split (109, 106, 120, 105, 350 for threads 6, 7, 8, 9, 16) after one
fix (an author name in quotation marks, `"Boris"`, thread 7, June 17, 2018 at 11:30 pm, was first merged into the comment before it).

## Stage 2 — SAVED (thread 6 read in full)

- **Read:** thread 6, "Wrestling with infinite graphs", all 109 comments (May 30 – June 16, 2018), text only; the held file has no images, so every
  posted figure (de Grey's tilings, Gibbs's cell diagrams, Hockertz's SketchUp previews, Sirgedas's attempts) is unread. 44 extracts in
  `data/fs112/fs112-pa/extracts.md` § Thread 6, generated from `spec_06.txt` by `make_extracts.py` (every quotation cut from the held file by comment and
  phrase and checked verbatim; `--self-test` plants a phrase from another comment, a one-word alteration and an altered body, and all three are refused
  for their own reason while the faithful twin passes).
- **What thread 6 holds on this milestone's object** (pointers; the grades are Stage 7's): HOCK's two sentences, five days apart, with no argument beyond
  "two perpendicular lines are sufficient" (`[06.31]`, `[06.91]`); the degree-4 sketch, **Gibbs's** (`[06.62]`), with his pentagon constraint count
  (`[06.64]`) and the forbidden "red-green-red-green" pattern that de Grey names the **convexity conflict** (`[06.34]`, `[06.41]`); de Grey's
  **width-almost-4 six-coloured strip in words**, four Pritikin columns with the diamonds removed and the short edges fattened (`[06.52]`) —
  a blog construction in words only, whose width against `[AxenovichEtAl2014]`'s `√15/2 + √3 ≈ 3.6685` is not decidable from the words (no coordinates;
  thread 7 below computes the column's half-width exactly); Siamese pairs in de Grey's words (`[06.41]`, `[06.42]`, `[06.104]`); the only claimed six-colouring of the plane, Sirgedas's, withdrawn
  (`[06.70]`–`[06.73]`).
- **A correction owed** (logged in Stage 1): the degree-4 sketch is Gibbs's, not de Grey's.

## Stage 3 — SAVED (thread 7 read in full)

- **Read:** thread 7, "Upper bounds", all 106 comments (June 16 – June 25, 2018), text only (figures not held). 36 extracts, `spec_07.txt`.
- **The opening post** (Mixon, June 16, 2018; verbatim): "Theorem ( Thomassen ). Consider any infinite connected plane graph $G\subset\mathbb{R}^2$ such
  that each connected component of $\mathbb{R}^2\setminus G$ (or “face” of $G$ ) has diameter less than 1, is homeomorphic to a disk, and is bounded by
  a cycle in $G$ . Next, consider any proper coloring of $\mathbb{R}^2$ such that each color class is the union of faces of $G$ (and part of their
  boundaries) such that the distance between any two of these faces is greater than 1. All such colorings require at least 7 colors." and "Question. What
  is the radius of the largest disk in $\mathbb{R}^2$ that can be 6-colored?"
- **What thread 7 holds on this milestone's object:**
  1. **The strip's construction rule, in words, from the thread** (`[07.10]`, de Grey): "The curved lines are arcs at constant radius 1 from the opposite
     corner, so each vertex down the middle mandates four such curved edges, but they interdigitate without problems." The column is Pritikin's tiling
     with a column of diamonds removed (`[07.6]`). Its disk has radius, verbatim (`[07.45]`), "sqrt((sqrt(3)/2 + sqrt{15)/4)^2 + 1/16) ~= 1.85123",
     simplified by de Grey to `√(7+√45)/2` and by Gibbs to `(√10 + 3√2)/4` (`[07.47]`, `[07.48]`). **An identity of seconds (by hand, checking a quoted
     claim, not a derivation of this job's):** `√3/2 + √15/4 = (√15/2 + √3)/2`, the half-height of `[AxenovichEtAl2014]` Thm 4.2's strip, and
     `(√3/2 + √15/4)² + 1/16 = (7 + 3√5)/4`, so the three printed forms agree. So de Grey's June 2018 column is a strip of height `√15/2 + √3` with tiles
     of width 1/2 (the `1/16 = (1/4)²`), the same numbers as CAL-STRIP's print — **a recognition for the sides to check, not established here**: the
     words "tiles of width 1/2" are not in the thread; they are this job's reading of the `1/16`.
  2. **The first disk past radius 2, and its five-fold symmetry** (`[07.49]`–`[07.52]`): Gibbs, "I think it is possible to get beyond a radius of 2 with
     something like this"; de Grey's improvement acts "at multiples of 72 degrees rotated". The figure is not held; thread 8 continues it.
  3. **Tightness stated** (`[07.81]`, Gibbs): "In the large radius examples we have found there are points and edges at a distance of exactly one apart
     that cannot be shrunk or expanded without breaking the solution." Stated, no argument.
  4. **Gibbs's pentagon enumeration** (`[07.25]`–`[07.37]`): a claimed elimination of six-colourings by pentagons of diameter one each with exactly two
     valency-4 vertices, sketched, details not written (`[07.31]`); Gibbs's target statement "There is no six-colouring of the plane such that all points
     of the same colour separated by a distance less than one are connected by a monochromatic path" (`[07.38]`), i.e. no Siamese pair.
  5. **Gibbs's sectors** (`[07.106]`): the vertex neighbourhood cut by lines perpendicular to the edges, opposite sectors' colours distinct — the shape
     of FS-110's side-cone apparatus, with the topological hypothesis asked, not given.
  6. **This project's aim, link 2, in 2018** (`[07.2]`, Mixon): "If we can 6-color the plane almost everywhere, then every finite unit distance graph is
     6-colorable by Pritikin’s probabilistic argument, and then the entire plane is 6-colorable by De Bruijn–" (truncated in the held text). A prior-art
     pointer for row 130 / link 2's attribution, owed to the owner (not this milestone's object).
- **No six-colouring of the whole plane is claimed in thread 7.** Boris's SAT searches found none on a torus or a one-way-periodic square (`[07.77]`).

## Stage 4 — SAVED (thread 8 read in full)

- **Read:** thread 8, "More upper bounds", all 120 comments (June 24 – July 2, 2018), text only (figures and the linked files `philgibbs.uk/out*.txt`,
  `notcol.txt` not held). 46 extracts, `spec_08.txt`. The opening post's summary is quoted verbatim at the head of § Thread 8 (checked against the held
  file, as is the Thomassen statement quoted in Stage 3).
- **What thread 8 holds on this milestone's object:**
  1. **The six-colour-vertex sketch** (`[08.17]`, de Grey) with its **precondition, the transformation of `[08.16]`**: two same-colour tiles at a shared
     vertex lying inside a Reuleaux triangle with a corner there are merged by recolouring that triangle near the vertex ("I can’t think of a way to stop
     such a tiling from being transformed harmlessly"). The six-sector conclusion is then stated "unless I’m missing something really obvious"; Gibbs
     reached the same disk (`[08.18]`); the next layer is a case analysis never done in the thread. De Grey's rule "quads and pentagons can have at most one
     6-valent vertex, because such vertices must have an angle of exactly 60 degrees" (`[08.70]`) rests on it.
  2. **Mixon's no-six-edge-neighbours argument** (`[08.14]`) — the unit-rhombus argument — and **de Grey's objection** (`[08.15]`): it fails for small
     same-colour tiles inside each other's annulus of exclusion (Siamese pairs). The dual-valency statement is therefore argued only for tilings without
     Siamese pairs.
  3. **Gibbs's "constraint"** (`[08.39]`), quoted in the plan, sits in a thread of rules: de Grey's representation by valency sequences and pairs
     `{v_i,v_j}`, `{v_i,e_j}` "that need to be 1 apart" (`[08.45]`, strengthened in `[08.63]`, `[08.65]`), curated on the Polymath wiki (`[08.67]`; the wiki
     page is not held — a prior-art debt), and Gibbs's program's tile counts (just under 500, `[08.111]`). A constraint is a self in-contact in FS-112's
     vocabulary (claims §0): an edge on the unit circle about a vertex of the same tile.
  4. **HOCK again, as a question, with a counter-memory** (`[08.76]`, de Grey, June 30, 2018): "Am I right in saying that all edge in any tiling can be
     harmlessly (i.e. without needing to change any tile’s colour to preserve the chromatic number) flowed into ones that are either straight or have
     constant radius of curvature 1 ? Can we devise a tiling (of any chromatic number) in which that is not so?" — and "I recall my error regarding one of
     my promising-looking tilings (see June 7th) – a radius of 2 could be used in places but it enlarged the exclusion set." **No reply in thread 8.**
  5. **The strip's tiles in words** (`[08.12]`, Gibbs): tiles K and W, "The K tiles have two diagonals of length one in addition to the two forced by the
     constraints. They also have a width of 0.5".
  6. **"Siamese tiles"** first appears (`[08.120]`, de Grey, July 2, 2018), undefined in the thread ("map-based colourings, and indeed with ones that do
     not have Siamese tiles"); the word recurs in threads 10, 12, 14, 15, 16, 17 (grep count). De Grey's record claim: "we’ve failed to 6-tile a disk
     larger than about 4.5 across" (`[08.105]`).
- **No six-colouring of the whole plane is claimed in thread 8.**

## Stage 5 — SAVED (thread 9 read in full)

- **Read:** thread 9, "Searching for a 6-coloring", all 105 comments (July 2 – August 28, 2018), text only (Gibbs's spreadsheets `philgibbs.uk/out*.csv`,
  Parts's Google-drive figures, Hockertz's previews not held). The probability thread inside it (`[09.29]`–`[09.62]`, Tao's Propositions 35–36, Lemma 38)
  and the bichromatic-origin and two-distance items (`[09.75]`–`[09.88]`) are off this milestone's object and are not extracted. 27 extracts, `spec_09.txt`.
- **What thread 9 holds on this milestone's object:**
  1. **The strip's width, from the thread's own construction** (`[09.100]`, Jaan Parts, August 27, 2018): "we can do much more already using Pritikin’s
     style design, as it was described here: Polymath16, seventh thread: Upper bounds One should use the same infinite design without round boundaries. It
     gives the width $\sqrt3 (1+\sqrt5/2) \approx 3.668$ ." That is `√3 + √15/2`, `[AxenovichEtAl2014]` Thm 4.2's number; with Gibbs's "a strip of
     width 3.7 in thread 7" (`[09.15]`) and the thread-7 identity (Stage 3), **the thread's strip and the 2014 print's strip have the same height**. The
     threads never cite `[AxenovichEtAl2014]` (grep: no "Axenovich" in threads 1–18? — checked in Stage 7). Whether they are the same tiling is for the
     sides' rebuild (CAL-STRIP).
  2. **Curved boundaries are needed past about 2×2** (`[09.73]`, de Grey): "the only way to cover more than about a 2×2 area is by using unscaleable
     tilings with curves as boundaries" — stated, from the pixel searches' failures.
  3. **Gibbs's enumeration state** (`[09.28]`): 78 / 313 / 563 tile types by the constraint level; the search for a six-tiling of the plane was planned
     (`[09.20]`) and not reported finished in thread 9.
  4. **Parts's six-colouring with holes** (`[09.66]`, August 1, 2018): Pritikin-style, "attach round segments to some edges", every unit-distance graph of
     order 6906 six-colourable — the hole-density question of link 5 (FS-109's dial) in 2018 form, not a whole-plane colouring.
- **No six-colouring of the whole plane is claimed in thread 9.**

## Stage 6 — SAVED (thread 16 read in full; targeted reads of threads 10, 11, 12, 14, 15, 17)

- **Read:** thread 16, "Writing the paper and chasing down loose ends, II", all 350 comments (May 11, 2020 – February 1, 2021), text only (Parts's and
  de Grey's figures, Sirgedas's imgur disk images, the dropbox draft `stripdisk.pdf`, the Google group `hadwiger-nelson-problem` not held). Off-object
  stretches not extracted: the 3-disk proofs (`[16.165]`–`[16.236]`), higher-dimensional lattices (`[16.141]`, `[16.266]`–`[16.305]`), the human proof of
  CNP ≥ 5 (`[16.308]`–`[16.317]`, except `[16.317]`'s last paragraph). 27 extracts, `spec_16.txt`.
- **Targeted reads outside the brief's thread list** (the brief names threads 6–9 and 16; the held file is the same, so no fetch): a grep of the held file for
  "Siamese", "Philip's disk/disc", "6-flower", "Gibbs disc" and unit-arc words found 57 comments in threads 1–5, 10–15, 17, 18; the 12 bearing on the object
  were read whole and extracted (`spec_x_other.txt`, § Outside the brief's threads). **Their threads are not read.**
- **What thread 16 and the targeted reads hold on this milestone's object:**
  1. **The disk (CAL-DISK) is "Philip’s disk", Gibbs's `[07.49]` of June 17, 2018, and the threads print its skeleton and radius** (`[11.34]`, Jaan
     Parts, September 29, 2018, verbatim): "A little bit cleaner picture of 6-flower (Philip’s disk) is shown below. One can see here a skeleton from five
     connected regular pentagons with unit edges (dotted lines). Minimum radius of 6-flower is $r=\frac{1+\sqrt5}{2} \sqrt{\frac{15+\sqrt5}{10}}
     \approx 2.12426$ ." **An identity of seconds (by hand, checking the quoted radius):** `φ²·(15+√5)/10 = (3+√5)(15+√5)/20 = (25+9√5)/10`, which is
     CAL-DISK's `r² = (25 + 9√5)/10` and `[Polymath2021]` Fig. 10's `√(5/2 + 9/(2√5))`. So the paper's pentagon ABCDE is Parts's "five connected regular
     pentagons with unit edges". **What is not printed in the held text:** which edges are unit arcs, where each is centred, the tile list — the picture
     carrying them is not held. The nearest to a rule is Sirgedas's dual-graph statement (`[16.346]`, January 30, 2021): the largest 6-colour disk and the
     6-colour strip "both have quads on the interior, and triangles on the exterior. Arrows in the dual graph correspond to curved edges in the tile graph.
     Each quad in the dual graph “emits” four arrows." Two facts about the disk's tiles are stated in words: ten small tiles of a seventh colour extend it,
     and "they come in Siamese pairs" (`[16.91]`); and a `{1,3,5,6}` junction sits "at 2 o’clock on the central tile of the main disc" (`[16.106]`) — **a
     four-colour junction in the disk as de Grey describes it** (C-V4-K's question meets a held positive, if the words are right; for the sides to check
     in the rebuild).
  2. **HOCK contested in 2020, in the hole-minimising setting** (`[16.39]`–`[16.51]`, `[16.80]`, `[16.85]`): Parts's arcs of radius about 0.5, de Grey's
     "I can’t see any way that arcs of radius less than 1 could ever be optimal", Hockertz's restatement of HOCK, then de Grey's counter-calculation (a
     quadrilateral with unit diagonals fattened by radius-0.5 arcs has area about 0.64 against about 0.62 with radius-1 arcs), and Hockertz's concession
     that this is "just to minimize the area of one specific target color". **In a full six-colouring the question is never settled in the threads.**
  3. **A claimed near-proof of the NO, for non-Siamese tilings, held nowhere here** (`[16.317]`, de Grey, October 31, 2020): "prove that the plane cannot
     be 6-tlled with a non-Siamese tiling; Tom Sirgedas got very close to such a proof a while back and is trying a new approach now." With `[16.153]`
     ("an exhaustive search of non-Siamese 6-tilings", Gibbs and Sirgedas) — **a prior-art debt**: the Google group `hadwiger-nelson-problem` and any
     Sirgedas write-up.
  4. **Why the strip stops** (`[16.347]`, Sirgedas): in the dual graph "A triangle can’t be added because all 6 colors are within two “steps” of the new
     vertex. A quad can’t be added because each new vertex will emit a conflicting arrow" — an argument in words, about that strip, not a theorem.
  5. **Siamese defined** (`[10.59]`, de Grey, September 3, 2018): "Siamese tiles (tiles that lie entirely within each other’s annulus of exclusion)";
     the only Siamese tiling known in March 2019 was a stretched Pritikin seven-colouring (`[12.17]`). The threads disagree on what Thomassen leaves open
     (`[14.160]` unscaleable, `[15.19]` Siamese; `[16.252]` both conditions).
  6. **The T2 shape as an obstruction** (`[16.111]`, Parts): a unit rhombus `ABDE` with a boundary `AD` "all points of which must also be at a distance of 1
     from points B and E" — invalidating a sphere construction (`[16.112]`).
- **No six-colouring of the whole plane is claimed in thread 16.** Pálvölgyi's "there is a chance that CNP<=6" (`[16.253]`) is said of a sphere
  7-tiling.

## Stage 7 — SAVED (`[Coulson2004]`'s figures viewed; `[Soifer2024]` located and read)

**`[Coulson2004]`, figures** (`~/source/library/pdf/jams-2004-coulson-chromatic-number-plane-tilings.pdf`, pages rendered with `pdftoppm -r 110`, all five
figures viewed, 2026-09-27):
- Fig. 1 (p. 192), the Moser spindle; Fig. 2 (p. 193), the hexagonal seven-colouring with its sublattice cells hatched.
- Fig. 3 (a)–(c) (p. 195): Lemma 3.1's groups `G` and `M` in a **polygonal** tiling (straight edges only), the boundary component unbounded (a), interior
  (b), exterior (c).
- Fig. 4 (p. 195): (a) a tri-coloured vertex `T` (colours `a, b, c`) and the circle `C` of radius `D` about it with a neighbourhood `U`; (b) a non-interior
  point of `C` separating `d` from `e` at distance `D` from an interior point (Lemma 3.3); (c) **the six non-interior points on `C`, a regular hexagon of
  chords `D`, colours alternating `d, e`** (Corollary 3.4) — the same picture as FS-110's six change points of a ring (NB-4, A4-SIX-ARCS).
- Fig. 5 (p. 195): (a) at the six points, like-coloured tile boundaries leave `C` outwards as **straight rays** meeting the chord at an angle marked
  `90 − ε`, the text's "strictly acute angles with the line segment of length D"; (b) a boundary `B` between `a` and `b` at `T` and two points `P₁, P₂`
  at distance `D` on `C`.
- **No figure shows a curved boundary, let alone a unit arc**: Coulson's scheme is convex polygonal tiles with area bounded below (§2, p. 192, verbatim:
  "Let us consider a colouring of Euclidean 2-space using polygonal tiles that are convex, (vertices having interior angles strictly less than π), locally
  finite and all with area greater than some lower bound l."). A boundary lying along `C` itself — a unit arc about `T` — is outside his hypotheses and
  outside his figures; Fig. 5(a)'s acute angle is where it would enter. (A reading of the figure, not a derivation.)

**`[Soifer2024]`, located by the text layer** (`pdftotext -layout`, grep for "Thomassen", "nice colo(u)ring", "circular arc", "unit arc", "radius 1",
"Reuleaux", "curvature", "Siamese", "Polymath16", "Pritikin", "strip"):
- **Ch. 18, "Carsten Thomassen’s 7-Color Theorem", pp. 179–182 — read in full (text).** Verbatim, p. 179: "Given a graph G on a surface S, Thomassen
  deﬁnes nice coloring of S as a coloring in which each color class is the union of regions (and part of their boundaries) such that the distance between
  any two of these regions is greater than 1." Two notes for the sides, not derivations: (1) Soifer renders the hypothesis as "Thomassen assumes that each
  region that has diameter less than 1 is homeomorphic to a Euclidean disc and is bounded by a cycle in G" — a restrictive clause, where
  `[Thomassen1999]` p. 850 (claims §0) assumes each face "has diameter less than 1, is homeomorphic to a disc, and is bounded by a cycle in G"; the proof
  then uses "a face of diameter < 1" (p. 181), so the assumption is the print's, the book's sentence misrenders it. (2) The theorem's condition (iii) reads
  "12 k + 30" while the proof uses "12 k + 3", "12 k + 1" and "12 k + 29" — internal misprints. Soifer's closing remarks (p. 182) show the conditions are
  needed ("A thin two-way inﬁnite cylinder has a nice 6-coloring").
- **Map colourings with unit arcs: none in the book.** No occurrence of "Reuleaux", "Siamese", "unit arc" or "circular arc" as a tile boundary; Part IV
  ("Coloring Maps", ch. 19–22) is the four-colour history. Ch. 54 (pp. 693–697; read in full at FS-70) cites `[Polymath2021]` as "[Poly] … all related to
  circular disks and inﬁnite strips in the plane" and discusses only its 5-chromatic strip graph. Ch. 64 (p. 767) records `[Pritikin1998]`'s 6198 and
  Parts's 6993 ("a tiling of more than 99.985698% of the Euclidean plane with 6 colors"). Ch. 25 (Townsend) was read by FS110-PA and job LP.

## Would have searched here

- Solving de Grey's column (`[07.10]`) as a constraint system to confirm it is `[AxenovichEtAl2014]`'s strip: not done (a derivation for the sides;
  CAL-STRIP's rebuild is theirs); the identity above checks only the quoted radius against the strip's height.
- Fitting coordinates to de Grey's width-"almost 4" strip (`[06.52]`) to compare it with `√15/2 + √3`: not done (a figure fit is a search, and no
  figure is held); the words are extracted instead.
