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

## Would have searched here

- Solving de Grey's column (`[07.10]`) as a constraint system to confirm it is `[AxenovichEtAl2014]`'s strip: not done (a derivation for the sides;
  CAL-STRIP's rebuild is theirs); the identity above checks only the quoted radius against the strip's height.
- Fitting coordinates to de Grey's width-"almost 4" strip (`[06.52]`) to compare it with `√15/2 + √3`: not done (a figure fit is a search, and no
  figure is held); the words are extracted instead.
