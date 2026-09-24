# FS-85 input audit — Parts's trees, his root case split, and two prior-art debts

*The auditor (de Bruijn, round 3 of FS-85), 2026-09-24. Brief: `data/fs85/briefs/R3-input-audit-brief.md`. Tools and
transcriptions: `data/fs85/audit/`. Scratch (page renders, cropped strips, extracted text; never committed):
`/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-audit/`.*

**What this audits.** FS-85's headline — every proper four-colouring of de Grey's lattice Λ is periodic, `F ⊇ 1680Λ`, `P = F`
(`plans/FS85-V-verification.md`, `plans/FS85-C-Coxeter.md`) — rests on one published input, **(S)**: no proper four-colouring of
the plane has a monochromatic equilateral triangle of side √3, proved in `[Parts2020hv]` by a 481-vertex graph G481 and nine
colouring trees S, L1–L8 that his program found and a human can check. The blind verifier re-transcribed G481, placed it in Λ
in the five inner orientations, and walked tree S; it could not walk L1–L8 (raster images only) and left Table 1's root case
split unchecked.

## Verdicts

| task | verdict | grade |
|---|---|---|
| **A1** trees L1–L8 walked as a fixed certificate | **all eight walk**, and S again; every one of the 880 cells of L1–L8 read by eye, none unreadable; the transcription reproduces Table 2's five parameters for all nine trees and Table 3's 261 per-orbit used-vertex counts exactly; nine planted faults, one per tree, each refused for its planted reason | [tools exact] on a by-eye transcription |
| **A2** Table 1's root case split | **exhaustive, and every branch reaches its tree's root** — proved by hand (Lemma G below; no gap); each of the 36 root colourings carried onto its tree's root by an exhibited symmetry, checked exactly against the roots read in A1; Parts's counts (6 + 10 + 10 + 10 = 36; 19 with a monochromatic opposite pair) confirmed | [hand] + [tools exact] |
| **A3** prior-art debts | **(1)** the wiki's "Algebraic formulation" page *claims* 8-periodicity of every four-colouring of `R₂` as a computer result and proves nothing about periodicity; nothing on de Grey's lattice. In the threads, Gibbs announced a hand route from "no monochromatic √3-triangle" to period 16 on `R₂` (3 June 2018) and dropped it because the input was missing; Tao's Cor. 9 stops one step in; nothing later. **No hand proof of periodicity found anywhere — FS-85's is the first found, on its exact scope.** **(2)** zbMATH, 39 queries: nothing on periodicity of all colourings of a lattice unit-distance graph. **(3)** "every `k`" is **not found stated in print**, but it is a two-line corollary of Klotz–Sander's own Theorem 4.2 (after Greenwell–Lovász 1974), given a triangle-free circulant of chromatic number `> k`, which FS-85's embedding supplies; Bašić stops at `k = 3`; Nešetřil 1973 has triangle-free uniquely `k`-colourable graphs for every `k`, none of them circulant. **(4)** a triangle-free distance graph or circulant with a forced pair, or unique up to period: **not found** | [searched; negatives recorded] |

## A1. The trees L1–L8, walked

### Method

1. **Images.** Table 4 (pages 16–23) is ten raster images, 1024 px wide at 214 ppi (`pdfimages`), one row of ten cells per
   ~125 px: S `t4-002`; L1 `t4-005`, `t4-006`; L2 `t4-009`; L3 `t4-012`, `t4-013`; L4 `t4-016`; L5 `t4-019`; L6 `t4-022`;
   L7 `t4-025`; L8 `t4-028`, `t4-029`. Each image was cut into strips of four cell rows and enlarged 1.5× (scratch
   `crop.py`) and read by eye, strip by strip, straight into `data/fs85/audit/trees/<T>.txt`, one line per cell: node number,
   the node listed in each of the four colour ports (`-` for the empty port, 0 for a root's unused colour), the four vertex
   coordinates `(a, b, c, d)`, and the cell's displayed colour (1–4, `b` grey = branch, `e` white = end).
   **No cell was unreadable at 1.5×.** One reading changed before any walk: L1 node 73, read at native resolution as a yellow
   stem with ports `(6, -, 66, 72)`, is at 1.5× a red stem with ports `(-, 6, 66, 72)`; the enlarged reading is the one filed.
   No reading was changed after a walk: every tree walked on its first run.
2. **The walker** (`data/fs85/audit/walk_trees.py`, new; `data/fs85/verifier/treeS.py` was the template, no code shared).
   It trusts no transcription and never searches; it reads each tree as given and checks the one deduction each cell records.
   - *Unit distance, two independent exact tests*: the integer identity `144|z|² = Δa² + 33Δb² + 3Δc² + 11Δd² + 2√33(ΔaΔb + ΔcΔd)`,
     and membership in Parts's own list of the 30 unit differences (§4, "Verification notes"); the walker asserts they agree
     on every pair it tests.
   - *G481*, rebuilt from Table 3's 29 representatives by an integer orbit generator of our own (rotation by 60° as
     `(a,b,c,d) ↦ ((a−3c)/2, (b−d)/2, (a+c)/2, (3b+d)/2)`, complex conjugation, and Parts's conjugation symmetry
     `(b, c) ↦ (−b, −c)`); 481 points, every orbit's size and degree equal to Table 3's. Every node's vertex must lie in it.
   - *Roots*: three 0-ports and one empty port; displayed colour = the empty port; the root colouring proper.
   - *The tree*: the non-root cells, in order, are a binary tree in preorder whose shape the port counts alone fix — four
     ports filled is an end (a leaf), three a stem (forced colour = the empty port, which must be the displayed colour), two
     a branch (two children), fewer refused. Every port neighbour of a node must be an **ancestor** of it — never a node of a
     sibling branch — carry that colour on the node's path, and be at unit distance. A branch's colour on each side is read
     off the references to it on that side, and the two sides must take its two free colours, one each. The whole list must
     be consumed exactly, and every cell visited once.
   - *Parameters*: Table 2's nodes, roots, ends, distinct vertices and non-root nodes, and Table 3's used-vertex count per
     orbit and tree, recomputed from the transcription.
3. **Plants** (`python3 walk_trees.py --plant`), one per tree, each required to be refused **and** refused only for its planted
   reason (every message about the planted node, or a later node naming it, or the Table 2/3 counts the plant moved):

   | tree | planted fault | what isolates it | refused by |
   |---|---|---|---|
   | S | node 10's `d = −3` read as `3` | — | off G481, four unit failures |
   | L1 | node 94's green port `93` read as `91` (a red node) | — | wrong colour on the path |
   | L2 | node 30's `a = 18` read as `16` | — | off G481, unit failures |
   | L3 | node 28's port 2 redirected to node 25: yellow, adjacent, but in the sibling branch of 22 | the ancestor rule alone | "not on its path", the only message |
   | L4 | stem 40's displayed colour 1 read as 2 | — | display ≠ forced colour |
   | L5 | branch 22's side B replaced by a renumbered copy of side A, so both sides refute colour 3 | the branch-split rule | "no valid split" |
   | L6 | end node 65's blue port `62` read as empty | — | the last path has no end |
   | L7 | node 14's port 1 redirected to ancestor 2: red, on the path, not adjacent | the unit test alone | "not at unit distance", the only message |
   | L8 | node 150's `(0,−2,−2,0)` read as `(0,2,2,0)`, which **is** a vertex of G481 | the unit test, with membership blind | three unit failures |

   The unplanted transcription walks before and after (`ALL WALK`, exit 0).

### Result

**All nine trees walk.**

| tree | cells | roots | branches | ends | distinct vertices | non-root cells | Table 2 |
|---|---|---|---|---|---|---|---|
| S | 11 | 7 | 0 | 1 | 11 | 4 | = |
| L1 | 147 | 13 | 4 | 5 | 113 | 134 | = |
| L2 | 43 | 11 | 0 | 1 | 43 | 32 | = |
| L3 | 144 | 13 | 5 | 6 | 130 | 131 | = |
| L4 | 80 | 11 | 2 | 3 | 74 | 69 | = |
| L5 | 49 | 13 | 1 | 2 | 46 | 36 | = |
| L6 | 65 | 13 | 1 | 2 | 64 | 52 | = |
| L7 | 105 | 13 | 4 | 5 | 88 | 92 | = |
| L8 | 247 | 10 | 13 | 14 | 155 | 237 | = |

Every branch is a bifurcation (ends = branches + 1 in each tree, as Parts says), and Table 3's per-orbit used-vertex counts,
29 orbits × 9 trees, agree entry for entry. The non-root total is **787** as Parts states; L1–L8 hold **783** of them (the
verifier's "776" subtracted S's eleven cells instead of its four non-root ones).

**What this establishes.** For each tree T, no proper four-colouring of the unit-distance graph on T's vertices (all in
G481) extends T's root colouring. The walk is the whole argument: every cell is one deduction checked exactly, the tree's
branches cover both free colours at every branch node, and every path ends in a vertex with all four colours blocked.

**Why a misreading cannot have flattered the result.** A cell misread into a *different valid deduction* would still be a
valid certificate — the walker checks the logic, not fidelity — so the conclusion "these root colourings are impossible" does
not depend on the transcription being literally Parts's. Fidelity is separately supported by three things no misreading is
likely to survive together: every one of the 891 cells' vertices lies in G481; every one of the 2,370 port references is an adjacent,
correctly coloured ancestor; and the 45 parameters of Table 2 and the 261 counts of Table 3 — printed by Parts in text, read
independently of the images — are reproduced exactly. The one place fidelity *does* matter is the **roots**: a misread root
changes what is refuted. The roots are checked against Table 1 and Fig. 12 under A2.

**Parts's data files are not needed.** The Polymath16 comment and Dropbox folder `[Parts2020hv]` ref. [3] names would only
re-supply what the images already gave; no cell was unreadable. Nothing to ask Kooshi.

**What A1 does not cover.** (i) That the nine root colourings exhaust the cases — A2. (ii) The transfer of (S) to Λ: that
G481's rotated copies lie in Λ in the five inner orientations is the verifier's (V-T12, `g481.py`), not re-done here.
(iii) Parts's second half (stripes ⟹ χ ≥ 5) is not used by FS-85 and not audited.

### Would have searched here (A1)

- Where a cell was hard to read, the obvious move was to try the candidate digits and keep the one that walks — a search over
  readings. Not done: every cell was read at 1.5× before any walk, and none needed a second reading after one.
- To confirm the walker, one could have generated random trees; instead each rule was isolated by a plant aimed at it.

## A2. Table 1's root case split

### The claim, stated exactly

Let **H** be the 13-vertex 2-Golomb graph of Parts's Fig. 5 with the coordinates his trees give (1 the centre; 2, 3, 4 the
triple at angles 60°, −60°, 180°; 5, 6, 7 the other alternate hexagon vertices at 240°, 120°, 0°; 8 = (1,1,1,−1),
9 = (1,−1,−1,−1), 10 = (−2,0,0,2) the first inner triangle; 11 = −8, 12 = −9, 13 = −10 the second). Its 24 edges, computed
exactly (`data/fs85/audit/golomb.py`): the wheel (1 to each of 2–7, and the hexagon 7–2–6–4–5–3–7), the triangle 8–9–10 with
pendants 2–8, 3–9, 4–10, and the triangle 11–12–13 with pendants 5–11, 6–12, 7–13. Let **Γ₀ = ⟨rot120, gal⟩** — rotation by
120° and Parts's conjugation symmetry `(b, c) ↦ (−b, −c)` — a group of six automorphisms of G481, each preserving H and the
triple {2, 3, 4}.

> **Lemma G (Table 1 is exhaustive).** Every proper four-colouring c of H with c(2) = c(3) = c(4) is, after a permutation of
> the colours and a pull-back by an element of Γ₀, one of Table 1's 36 colourings R_ab — the six R1b (b = 1, 2, 4, 5, 7, 8,
> with vertices 11–13 coloured 134, 143, 314, 341, 413, 431) and the thirty R2b, R3b, R4b (b = 0…9, coloured by the header row).
>
> **Lemma T (every branch reaches a root).** Each R_ab restricts to the root colouring of the tree Table 1 assigns it —
> directly (L1, L3–L8; L2 for R17; L4 for all of R23–R26, whose common part is vertex 11 = 3; L8 for all of R40–R49, whose
> root is R4 on vertices 1–10), or after the pull-back by rot(−60°) and the colour swap (1 2) (R15 ↦ R17, Parts's stated
> isomorphism), or — for the fifteen entries marked S — after a pull-back by the element of ⟨rot120⟩ that moves the
> monochromatic opposite pair to (10, 13) and the colour permutation fixing 1 that makes the inner triangle (2, 3, 4).

Together with A1 (FS85-IA1): **no proper four-colouring of G481 makes vertices 2, 3, 4 one colour.** If c did, some π∘c∘σ
(σ ∈ Γ₀, or rot(−60°) for R15) would restrict to some tree's root, and that tree's vertices, all in G481, would carry a proper
four-colouring extending its root — which the walk refutes. This is (S) for every copy of G481 in the plane, and so, with the
verifier's placement of G481 in Λ in the five inner orientations (V-T12), (S) as FS-85 uses it.

### Proof of Lemma G (by hand)

1. Permute colours so that c(2) = c(3) = c(4) = 1; vertex 1 is adjacent to 2, so c(1) ≠ 1; permute so that c(1) = 4.
2. Each of 5, 6, 7 is adjacent to 1 (colour 4) and to two of 2, 3, 4 (colour 1; edges 5–3, 5–4, 6–2, 6–4, 7–2, 7–3). So
   c(5), c(6), c(7) ∈ {2, 3}.
3. rot120 fixes 1 and the set {2, 3, 4} and cycles 5 → 7 → 6 (as vertices; 240° → 0° → 120°). If c(5) = c(6) = c(7), swap
   colours 2 and 3 if needed: **(5, 6, 7) = (2, 2, 2)** (case A). Otherwise exactly one differs; pull back by the power of
   rot120 that puts it at 7 and swap 2 and 3 if needed: **(5, 6, 7) = (2, 2, 3)** (case B). Colours 1 and 4 are untouched.
4. 8, 9, 10 are a triangle, and 8–2, 9–3, 10–4 are edges to colour 1, so (c8, c9, c10) is a permutation of {2, 3, 4}.
   - *Case A.* Γ₀ fixes the colouring of 1–7 (it permutes 2, 3, 4 among themselves and 5, 6, 7 among themselves, all of one
     colour each), and acts on {8, 9, 10} as the full symmetric group (rot120: 8 → 10 → 9 → 8; gal: 8 ↔ 9, 10 fixed). Pull
     back by the element that puts colour 2 at 8, 3 at 9 and 4 at 10: **R1 = 4 111 222 234**.
   - *Case B.* The elements of Γ₀ fixing (5, 6, 7) = (2, 2, 3) are id and gal (gal swaps 5 ↔ 6 and fixes 7); gal swaps
     8 ↔ 9 and fixes 10. The six permutations fall into three pairs by c(10): c(10) = 4 gives (2,3,4) ~ (3,2,4), take
     **R2 = 4 111 223 234**; c(10) = 2 gives (3,4,2) ~ (4,3,2), take **R3 = 4 111 223 342**; c(10) = 3 gives (4,2,3) ~ (2,4,3),
     take **R4 = 4 111 223 423** — pulling back by gal where needed (it fixes the colouring of 1–7: 2 ↔ 3 are both 1, 5 ↔ 6
     both 2, and 1, 4, 7 are fixed).
5. 11, 12, 13 are a triangle with pendant edges 5–11, 6–12, 7–13, so their colours are distinct with c11 ≠ c5, c12 ≠ c6,
   c13 ≠ c7.
   - *Case A* (c5 = c6 = c7 = 2): a bijection of {11, 12, 13} onto {1, 3, 4}: **134, 143, 314, 341, 413, 431** — the six R1b,
     with Table 1's note that R12 is 143 (not the header's 142) and R17 is 413 (not 412); the four "−" cells (132, 312, 342,
     432) put colour 2 on 11, 12 or 13 and are rightly empty.
   - *Case B* (c5 = c6 = 2, c7 = 3): c11, c12 ∈ {1, 3, 4} distinct, c13 ∈ {1, 2, 4} \ {c11, c12}: (1,3) → 132, 134;
     (3,1) → 312, 314; (1,4) → 142; (4,1) → 412; (3,4) → 341, 342; (4,3) → 431, 432 — **exactly the ten strings of Table 1's
     header**, for each of R2, R3, R4.
   So 6 + 3 × 10 = 36, as Parts says. ∎

No step needs a symmetry outside Γ₀, and every element of Γ₀ is an automorphism of G481 (checked exactly in `golomb.py`), so
the trees, which live in G481, transport with the colourings.

### Lemma T, checked (`python3 data/fs85/audit/golomb.py`)

For each of the 36, the script builds R_ab from Table 1 as printed, checks it is a proper colouring of H with the triple
monochromatic, applies the stated symmetry — computed from its rule, not searched — and compares the result with the root
colouring **read from Table 4 in A1** (`trees/*.txt`), vertex by vertex: **all 36 restrict to their tree's root.** The
fifteen S-entries each have a monochromatic opposite pair (c(x) = c(−x), x ∈ {8, 9, 10}), and exactly **19** of the 36 do
(Parts: "19 contain a mono-pair"; the other four are R24, inside L4's merged cell, and R47–R49, inside L8's). The roots,
in H's numbering: S = {2,3,4:1; 8:2; 9:3; 10:4; 13:4} (Fig. 11's mono-pair 10–13); L1 = R12; L2 = R17 without vertices 2 and 4
(Fig. 12's two grey vertices); L3 = R22; L4 = R2 plus 11:3; L5 = R27; L6 = R31; L7 = R38; L8 = R4 on 1–10. Plant
(`--plant`): L6's vertex 13 misread as colour 3 — refused (R31 no longer reaches L6's root).

**Where the gap would have been, and is not.** Table 1 is a hand claim in the paper with no argument written; the argument
above is ours. The two places it could have failed — a case missed in step 5 (the header's ten strings are exactly the
injections, and row 1's six exactly the permutations), and an S-entry without a monochromatic pair (all fifteen have one) —
both hold. Parts's "24 of these 36 quickly lead to a contradiction" is not needed and not checked; nor is it needed that the
gray cells are the large ones.

### Would have searched here (A2)

- The natural check of Lemma G is to enumerate the 4¹³ colourings of H and count the classes. Not done: the hand proof
  above, whose every step is a stated edge or symmetry.
- The symmetry carrying each S-entry to S's root could have been found by trying all 12 × 24 (symmetry, recolouring) pairs.
  Not done: the proof names it (the rotation that moves the monochromatic pair to (10, 13)), and the script only applies it.

## A3. The prior-art debts

Every negative below is a finding about where the unworked ground is (WORKFLOW 3.2); each measures the words it was searched
in (G21). The zbMATH queries, verbatim, are `data/fs85/audit/zbmath_queries.py` (39 queries; run with `--full` for the review
texts). New and re-read works are filed in `BIBLIOGRAPHY.md` (§ A rows `[Parts2020hv]`, `[Polymath16wiki]`,
`[KlotzSander2017]`, `[Basic2026]`; § B library rows; § C block "FS-85 input audit's prior-art gate").

### A3.1 The Polymath16 wiki's "Algebraic formulation" page, and the threads

**The page was already held** (`~/source/library/notes/polymath16-algebraic-formulation-2018.txt`, read in full at FS-23,
2026-09-09); the brief's "not held", and the verifier's "we do not hold" (`plans/FS85-V-verification.md` C3), are a slip in
the record, not a missing copy. Re-fetched anyway: the Wayback index has **five captures** (asone.ai 2021-04-12, 2021-06-21,
2021-09-19, 2022-06-25; michaelnielsen.org 2026-05-12) and none of the history page. All carry **one revision, last modified
4 June 2018, 20:40**, and their text, normalised, is identical (2021 against 2026). The 2026 capture's HTML is now saved beside
the text (`library/notes/polymath16-algebraic-formulation-2018-snapshot-20260512.html`). Read in full again.

**Verdict: the page claims periodicity, and proves none of it.** Its one sentence on the matter: *"A computer assisted analysis
has confirmed that R̄₂ has non-linear 4-colorings and that all 4-colorings are periodic with period 8. See also this"*. The
link goes to comment 4206 of the third thread. Its table enters `R₂` at four colours as "L+P 8". Nothing on the page is a
periodicity argument. It proves only: the linear-colouring obstruction (if `1/n ∈ R` and `k ∣ n`, there is no linear
`k`-colouring); the unit-modulus group `⟨ω, η⟩` of `R̄₂`, by factorisation in two UFDs; and linear five-colourings mod 5. It
also states `c(8/3) = c(0)` as known, which is Harder's computer result. **It says nothing about de Grey's lattice**; its rings
are `R̄₂ = ℤ[ζ₆, (1+i√11)/2, 1/3]` and extensions, and `Λ ⊂ R̄₂`.

**The threads** (`[Polymath16threads]`, searched in full for every periodicity passage in threads 6–18, each with its author
and date):
- **Mixon's question** opens the sixth thread (June 2018): *"Is Tamas's result that every 4-coloring of ℤ[ω₁,ω₃] is 8-periodic
  human-provable?"* The result is `[Hubai2018]` (9 May 2018, fourth thread): a computer search giving 9,120 colourings.
- **Gibbs, 30 May 2018** (sixth thread), three things:
  - (i) *"c₄(8/3) = c₄(0). This can be shown to be equivalent to general periodicity of 8, i.e. c₄(x) = c₄(x+8y)."* This is
    the forced-pair transport (G55's chain theorem, periodicity step, at `δ = 8/3` with `1/3 ∈ R₂`). Its input is Harder's
    computer-found forced pair.
  - (ii) His aim: *"showing that the periodicity of 8 follows by human proof from the absence of monochromatic triangles. As far
    as I know this has not been done yet but I think it is in reach."*
  - (iii) A hand sketch that no monochromatic √3-triangle makes every Eisenstein sublattice two-coloured along one edge
    direction. These are the stripes, the step Parts §3 makes in 2020 and FS-85 inherits through (S).
- **Hubai, same day:** stripes on `R₁` alone give no periodicity in other directions; *"we'll need to use that our colouring
  extends to R₂ in some stronger way."*
- **Gibbs, 2 June:** *"apart from the 8-periodicity all other features follow from the lack of a √3 monochromatic triangle."*
  A claim, with no argument.
- **Gibbs, 3 June 2018:** *"I think I know how to get from the lack of the monochromatic triangle to a periodicity of 16 using
  mostly algebraic methods. It might be possible to get to the known periodicity of 8 by similar means. However, I realise that
  this is not useful because showing the lack of a monochromatic triangle by human proof is already the missing part."* Never
  written. The wiki page's last edit is the next day, and it contains none of it.
- **Tao, 12 June 2018** (sixth thread, and the "Coloring R_2" page, `[Polymath16wikiR2]`): Corollary 9 extends `2R₁`-periodicity
  on `R₁` to `R₁ + η²R₁`. He *"was not able to finish this off yet, and also I would of course like to remove the initial
  hypothesis of periodicity on R₁."* **Gibbs, 14 June:** *"I have to come back to looking at 4-colourings of R₂ soon."*
- **Nothing later.** Every "periodic" passage in threads 7–18 (2018–2026) is about tilings, colouring periods of distance graphs
  or higher dimensions. Parts's human-verifiable proof (Geombinatorics, October 2020; sixteenth thread) supplies exactly the
  input Gibbs lacked, and spends it on χ ≥ 5, not on periodicity.

**Finding.** The periodicity *values* are computer results: Hubai's `8R₂` on the ring (2018), and on `Λ` FS-73's `F = P = 8Λ`
(one 2,044-point certificate). **A hand proof of periodicity, for `R₂` or for `Λ`, is in none of the page, the threads, or
zbMATH (A3.2).** FS-85's route is the one Gibbs announced on 3 June 2018 and dropped for want of (S). Parts's 2020 input and
FS-85's lemmas complete it on `Λ`, with period lattice `1680Λ` (Coxeter's `120Λ`); that is weaker than the computed `8Λ`.
- **Credit must name** Gibbs's announcement, Tao's Corollary 9, Parts's (S) and Hubai's computation.
- **It answers Mixon's 2018 question on its exact scope:** a finite-index period lattice on `Λ`, by hand, given Parts's checked
  trees. The verifier has already put it forward as a `CLOSED-QUESTIONS.md` candidate.

### A3.2 zbMATH, in the discipline's words

| topic | queries (verbatim in the script) | hits of note | bears? |
|---|---|---|---|
| periodicity of all colourings | `unit distance`+`periodic`+`color*`; `chromatic number of the plane`+`periodic`; `periodic`+`4-coloring*`; `colorings`+`lattice`+`periodic` (05C15); `colorings`+`Z^d`+`periodic` | Klee–Wagon 1991; Coulson 1997 (periodic colourings of space); Alkauskas 2025 (tilings); Chappell 1998 and Zhu 1998 (periods of distance-graph colourings) | no: all about *existence* of periodic colourings |
| frozen / rigid colourings | `frozen`+`coloring*`; `frozen`+`Z^d`; `proper colorings`+`Z^d`; `hom-shift*` | `[AlonEtAl2021]` (held; mixing of colourings of the grid), `[BrewsterEtAl2020]`, Chandgotia–Marcus 2018, Gangloff–Hellouin–Oprocha 2026 (hom-shifts) | no: the grid, and dynamics, not unit-distance lattices |
| the people | `au:"Hubai, Tamás"` (10), `au:"Parts, Jaan"` (12), `au:"Mixon, Dustin G."` (100, titles scanned), `au:"Gibbs, Philip*"`+`chromatic` (0), `au:"Polymath"`+`chromatic` (1) | Frankl–Hubai–Pálvölgyi 2020/2023 (almost-monochromatic sets); Parts's Geombinatorics papers; D.H.J. Polymath 2021 (disks and strips) | no: **Hubai's `R₂` result lives only in the blog comment** |
| the ring | `unit distance`+`ring`+`coloring*` | `[Ducz2026]` (held, read): geometric colourings of the Moser lattice — only the colourings where "same colour" depends only on distance; exactly two | no: a special class, not all colourings |

**Negative, as a finding:** no indexed work states or proves that every four-colouring of a unit-distance lattice or ring (the
Moser lattice, `R₂`, de Grey's lattice) is periodic, by computer or by hand. The ground is unworked in the indexed literature;
the only prior statements are the 2018 blog comments and wiki claims above.

### A3.3 "Triangle-free, uniquely `k`-colourable circulants for every `k ≥ 3`" (FS85-dB3, FS85-C2)

**Read:**
- `[Basic2026]` §§1, 3–5 (held):
  - §3 is `k = 3` only: `ICG_{12p}({2, p})`, with `ω = 2` and unique three-colourability.
  - §4 answers Klotz–Sander's Problem 2.4 with `Cay(Γ, Γ∖U)` for `U` a non-normal subgroup. That graph is complete
    multipartite and has no bearing here.
  - §5 poses no every-`k` question.
- `[KlotzSander2017]` §§1, 3, 4 (now held):
  - Problem 3.6 is on p. 161, as quoted.
  - **§4, Theorem 4.2**, extending `[GreenwellLovasz1974]`: *if X is uniquely n-colourable and 2K₂-free, and Y is connected with
    χ(Y) > n, then X × Y is uniquely n-colourable.* §4 also notes that a direct product of Cayley graphs is a Cayley graph over
    the product group.
- `[Nesetril1973]` in full (fetched from DML-CZ, held): Theorem 2 gives a **triangle-free uniquely (k+2)-colourable graph for
  every k ≥ 1**, a long path plus one vertex per chosen independent set. It is not vertex-transitive. The large-girth line after
  it — Bollobás–Sauer 1976, Zhu 1996, Emden-Weinert–Hougardy–Kreuter 1998, seen as zbMATH listings only — is probabilistic or
  explicit, and none of it is circulant as far as those listings show.

**The corollary the literature does not draw.** Take `X = K_k`, which is uniquely `k`-colourable and 2K₂-free. Take `Y` a
connected triangle-free circulant `Cay(ℤ/m, S)` with `gcd(m, k) = 1` and `χ(Y) > k`. Then:
- `K_k × Y = Cay(ℤ/k × ℤ/m, (ℤ/k∖0) × S)` is a circulant on `ℤ/km`, by the Chinese remainder theorem;
- it is triangle-free, because a triangle in a direct product projects to a triangle in each factor;
- `ω = 2`;
- it is uniquely `k`-colourable, by Theorem 4.2.

**That is "every `k`", one application of a printed theorem, in the paper that poses 3.6 a page earlier.** The only input it
needs is `Y`: a triangle-free circulant with chromatic number above `k` and order prime to `k`. zbMATH queries 29–32 (triangle-free
circulants; triangle-free Cayley graphs with large chromatic number; girth; "induced subgraph of a circulant") found no such
family in print. FS-85's own embedding supplies it. Put a triangle-free `(k+1)`-chromatic `H` (an iterated Mycielskian) into
`ℤ` by a B₃-type set `D`, as in `plans/FS85-C-Coxeter.md` C1 items 1–3. For a prime `p > 3·max D`, `Cay(ℤ/p, ±D)` is then
triangle-free, contains `H`, and is connected.

**Citing works, compared by identifier** (G49):
- OpenAlex (`W2562747661`) and Semantic Scholar (CorpusId `55418791`) each list **four** citing works of Klotz–Sander, and
  **not the same four**:
  - OpenAlex alone has `[Matsumoto2021]`.
  - Semantic Scholar alone has `[Basic2026]`.
  - Both have `[JanssenMacKeigan2020]`, `[Hujdurovic2020]` and `[ErskineGriggsSiran2022]`.
  - The union is five. A count comparison would have read "agree".
- What was opened:
  - Janssen–MacKeigan and Erskine–Griggs–Širáň: the passages using Klotz–Sander (Thms 2.2, 3.3 and the `ℤ_{p²}` circulant),
    all with cliques.
  - Hujdurović: Klotz–Sander is only in the reference list, as far as the extraction shows.
  - Matsumoto: paywalled; abstract only (game chromatic number).
- `[Basic2026]` has no citing works in either database (OpenAlex `W7208766586`).

**Verdict.** "Every `k ≥ 3`" is **not found stated in print**. It is **folklore-grade**: it is a direct corollary of a printed
theorem (Klotz–Sander Thm 4.2 / Greenwell–Lovász 1974), given triangle-free circulants of large chromatic number. The honest
claim is therefore narrower:
- **not seen in print:** the family, and the explicit input `Y` built from FS-85's embedding;
- **credit:** `[Basic2026]` for `k = 3`, `[GreenwellLovasz1974]` / `[KlotzSander2017]` for the product mechanism, and
  `[Nesetril1973]` for triangle-free uniquely `k`-colourable graphs of every `k`;
- **the product route is the shorter proof to write:** `K_k × Cay(ℤ/p, ±D)`, order `kp`, the same order as FS85-dB3's.

*Leads not followed (titles from memory, unverified, so not filed):* work on chromatic numbers of Cayley graphs on `ℤ` and
Bohr recurrence (Katznelson; Kříž) may already hold triangle-free circulants of large chromatic number. Worth one query before
any claim that `Y` is new.

### A3.4 The abstract "yes" (FS85-dB2, Coxeter's C1)

The claim: a triangle-free distance graph on `ℤ` with `χ = 4` and `F₄ = 4ℤ`, whose 24 four-colourings are the maps
`x ↦ f(x mod 4)`. Queries 23–28 and 35–38 (distance graphs with integers, triangle-free, periodic, sum-free, uniquely; Sidon
sets; Mycielski; circulants with "all colorings"), and one web search.
- **The integer distance graph literature asks other questions.** It studies `χ`, circular and fractional `χ`, and whether
  optimal periodic colourings exist and how short their period can be: Eggleton–Erdős–Skilton; Kemnitz–Kolberg and
  Kemnitz–Marangio; Zhu 1998 and 2002; Liu–Zhu; Chappell; Cervantes–Krebs 2025, whose title is about periods. None of it is
  about forced pairs or unique colourability.
- `[OravcovaSotak2024]` (read §1 and the statements) quotes **Zhu's conjecture** (`[Zhu2002]` Conj. 4.1): a triangle-free
  `G(ℤ, D)` with `|D| ≥ 3` has `χ ≤ |D|`. It also quotes the `|D| = 3` classification, whose four-chromatic cases all contain
  triangles. So a triangle-free four-chromatic distance graph needs `|D| ≥ 4`. FS-85's has `|D| = 70`, consistent with the
  conjecture and no test of it. Their forced-period argument (Thm 2.2) works at the maximal colour count, with triangles.
- **Circulants:** Klotz–Sander Thm 3.3 has cliques; Bašić is finite, `k = 3`.
- **Frozen colourings of `ℤ^d`** (`[AlonEtAl2021]`, `[BrewsterEtAl2020]`): the grid, not a triangle-free distance graph with a
  forced pair.

**Verdict: not found in print.** The ingredients are classical (Mycielski 1955; dissociated/B₃-type sets), so the folklore risk
is real, but no statement of a triangle-free distance graph or circulant with a forced pair, or with a colouring unique up to
period, was found. The unworked question in the discipline's words is **rigidity of colourings of distance graphs on `ℤ`**.

### Would have searched here (A3)

Nothing in A3 called for a colouring search. The one temptation was a positive control for the product corollary: build
`K_3 × Y` for a small triangle-free circulant `Y` and colour it. Not done, on two grounds: the corollary is an instance of a
printed theorem, and colouring it would have been a colouring search.

### Record corrections this audit owes (three for the close inventory; the fourth corrected here)

- `plans/FS85-V-verification.md` C3 says the "Algebraic formulation" page is not held. It has been held since 2026-09-09.
- The same record's count "776 non-root nodes in L1–L8" should be 783.
- `BIBLIOGRAPHY.md`'s `[Parts2020hv]` row said *"his proof imports one computer step, that every √3-triple is
  non-monochromatic (221 vtx)"*. That is false: the step is the nine checkable trees, and the 221-vertex graph is a §2 dead end.
  **Corrected in place in this commit**, since the audit is the reading that shows it.
- `tools/bib_audit.py` reports one unlogged arXiv id, `arXiv:2001.08801`, first seen in `plans/FS85-C-deBruijn.md`. It is not
  this audit's, and is left for its owner.

## Theorems this phase proved

- **FS85-IA1 — Parts's trees S, L1–L8 are valid refutations of their root colourings.** For each T ∈ {S, L1, …, L8}, the
  unit-distance graph on the vertices of T (a subgraph of G481) has no proper four-colouring extending T's root colouring
  (the roots as read from Table 4). [tools exact, on a by-eye transcription whose fidelity is corroborated by Tables 2 and 3]
  Proof: `data/fs85/audit/walk_trees.py` over `data/fs85/audit/trees/*.txt`; plants `--plant`.
- **FS85-IA2 — Parts's root case split is exhaustive (Lemma G).** Every proper four-colouring of the 2-Golomb graph H with the
  triple {2, 3, 4} monochromatic is, up to colours and a pull-back by ⟨rot120, gal⟩, one of Table 1's 36 R_ab. [hand]
  Proof: A2 above.
- **FS85-IA3 — every R_ab reaches its tree's root (Lemma T).** [tools exact] `data/fs85/audit/golomb.py`, plant `--plant`.
- **FS85-IA4 — (S) for G481.** No proper four-colouring of G481 gives vertices 2, 3, 4 one colour. [tools exact + hand:
  IA1 + IA2 + IA3] With V-T12 (G481's placements in Λ), this is FS-85's input (S) on Λ in the five inner orientations.
- **FS85-IA5 — triangle-free uniquely `k`-colourable circulants for every `k ≥ 3`, by the product route.** For `Y` a connected
  triangle-free circulant of order prime to `k` with `χ(Y) > k`, `K_k × Y` is a triangle-free (`ω = 2`) uniquely `k`-colourable
  circulant. [hand; an instance of `[KlotzSander2017]` Thm 4.2 / `[GreenwellLovasz1974]`, with `Y` from FS-85's C1 embedding]
  Proof: A3.3. Prior art: the mechanism is printed; the family is not seen stated. Kernel: declined — a corollary of a
  printed theorem, owed a citation, not a certificate.
