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
  **width-almost-4 six-coloured strip in words**, four Pritikin columns with the diamonds removed (`[06.52]`) — a strip construction older than
  nothing in print this project holds, and wider than `[AxenovichEtAl2014]`'s `√15/2 + √3 ≈ 3.6685` if "almost 4" is above it (not checked: no
  coordinates); Siamese pairs in de Grey's words (`[06.41]`, `[06.42]`, `[06.104]`); the only claimed six-colouring of the plane, Sirgedas's, withdrawn
  (`[06.70]`–`[06.73]`).
- **A correction owed** (logged in Stage 1): the degree-4 sketch is Gibbs's, not de Grey's.

## Would have searched here

- Fitting coordinates to de Grey's width-"almost 4" strip (`[06.52]`) to compare it with `√15/2 + √3`: not done (a figure fit is a search, and no
  figure is held); the words are extracted instead.
