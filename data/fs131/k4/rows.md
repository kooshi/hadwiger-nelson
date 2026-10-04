# FS131-K4 — wave 4's rows, quoted verbatim from `plans/LEAN-BACKLOG.md`

*Written by `tools/fs131_k4_rows.py`; `--check` re-reads it against the backlog. Each row is its whole backlog section, byte for byte (the backlog's script copies each field from the derivation file at the row's address).*

## FS106-L
`plans/LEAN-BACKLOG.md:137`

### 2. FS106-L
<!--row FS106-L plans/FS106-derivation.md:160-->
**Address** `plans/FS106-derivation.md:160` · **Role** upstream · **Era** R · **Was** 3 in `lean-order.md` · **Upstream ids** none
<!--needs FS106-L: -->

<!--q FS106-L statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> Lemma (L): a two-colour change point of a two-coloured open set with no monochrome unit has its unit circle outside the set.

<!--q FS106-L not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-L grade-->
**Grade as filed:**
> hand; one mind: V3

<!--q FS106-L minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-L handoff-->
**`*Kernel:*` line as filed:**
> declined.

## FS106-TS-T
`plans/LEAN-BACKLOG.md:214`

### 5. FS106-TS-T
<!--row FS106-TS-T plans/FS106-derivation.md:151-->
**Address** `plans/FS106-derivation.md:151` · **Role** upstream · **Era** R · **Was** 8 in `lean-order.md` · **Upstream ids** FS106-TS-C
<!--needs FS106-TS-T: FS106-TS-C-->

<!--q FS106-TS-T statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> Every point of an almost-everywhere-proper map has a point of chromaticity ≥ 3 within 1/√2 + ε (TS: within 1); with Condition 5 it is trichromatic, with Condition 6 of degree 3 — closing S–V Lemma 4 (a) under Conditions 5–6.

<!--q FS106-TS-T not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-TS-T grade-->
**Grade as filed:**
> hand; two minds, one blind: TS (hull growth), SB (Lebesgue's covering theorem, sharper)

<!--q FS106-TS-T minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-TS-T handoff-->
**`*Kernel:*` line as filed:**
> declined.

<!--q FS106-TS-T merge@SR2-4.3-12-->
**Merge note — to formalize** (SR2-4.3 item 12, `plans/FS129-SR2-audit.md:474-474`; status applied):
> 12. **FS106-TS-T** in place of **FS112-DISC1** (FS129-SR2-DISC1TS).

## FS106-WO
`plans/LEAN-BACKLOG.md:241`

### 6. FS106-WO
<!--row FS106-WO plans/FS106-derivation.md:73-->
**Address** `plans/FS106-derivation.md:73` · **Role** upstream · **Era** R · **Was** 9 in `lean-order.md` · **Upstream ids** FS106-L
<!--needs FS106-WO: FS106-L-->

<!--q FS106-WO statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> `[Woodall1973]` Thm 6 (maps need six): step 6 is a GAP (it rests on the assertion Townsend's ⅔π counterexample refutes), repaired by Townsend's ⅓π lemma; Woodall's step-4 lemma holds for arcs strictly longer than ⅔π, by lemma (L).

<!--q FS106-WO not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-WO grade-->
**Grade as filed:**
> hand; one mind: V3; steps 2, 3, 5, 7 in outline, step 8 unchecked

<!--q FS106-WO minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-WO handoff-->
**`*Kernel:*` line as filed:**
> declined.

## FS106-TW
`plans/LEAN-BACKLOG.md:264`

### 7. FS106-TW
<!--row FS106-TW plans/FS106-derivation.md:67-->
**Address** `plans/FS106-derivation.md:67` · **Role** upstream · **Era** R · **Was** 10 in `lean-order.md` · **Upstream ids** FS106-L, FS106-WO
<!--needs FS106-TW: FS106-L,FS106-WO-->

<!--q FS106-TW statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> `[Townsend1981]` states "Every 5-coloured map in the plane contains a monochrome unit" and a lemma (constant π/3), with no proof of the theorem; the lemma is TRUE. Townsend's 1979 manuscript proves the ⅓π lemma, his Thm 2 and the Corollaries of Thms 3–4 region-only (Thm 4 itself GAP in its generality, petal-shaped sets; its Corollary repaired, sketch), and his Thm 5 (maps need six) is a GAP at simplification (c), which Woodall's steps 2, 3, 5 fill.

<!--q FS106-TW not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-TW grade-->
**Grade as filed:**
> hand; "no proof": three readers (V, VB, V3); the lemma one mind in general (V3), two on a one-sided annulus (VB blind); the manuscript one mind (V3); the fill in outline

<!--q FS106-TW minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-TW handoff-->
**`*Kernel:*` line as filed:**
> declined until the fill is walked.

## FS106-AE-MAP6
`plans/LEAN-BACKLOG.md:287`

### 8. FS106-AE-MAP6
<!--row FS106-AE-MAP6 plans/FS106-derivation.md:121-->
**Address** `plans/FS106-derivation.md:121` · **Role** upstream · **Era** R · **Was** 11 in `lean-order.md` · **Upstream ids** FS106-TS-T, FS106-TW
<!--needs FS106-AE-MAP6: FS106-TS-T,FS106-TW-->

<!--q FS106-AE-MAP6 statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> No map-type colouring (Conditions 2–4) with five colours is almost-everywhere proper, modulo Townsend's simplification (c) as filled by Woodall's steps 2, 3, 5; no step uses "boundaries of measure 0", which only identifies D-AEMAP with Leb ⊗ σ-a.e. properness.

<!--q FS106-AE-MAP6 not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS106-AE-MAP6 grade-->
**Grade as filed:**
> hand; one mind per link: TS (the reduction to Townsend's annulus lemma), V3 (the lemma and Thms 1–2 region-only); the fill in outline

<!--q FS106-AE-MAP6 minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS106-AE-MAP6 handoff-->
**`*Kernel:*` line as filed:**
> declined.

## FS110-N3-CONF
`plans/LEAN-BACKLOG.md:310`

### 9. FS110-N3-CONF
<!--row FS110-N3-CONF plans/FS110-derivation.md:57-->
**Address** `plans/FS110-derivation.md:57` · **Role** upstream · **Era** R · **Was** — in `lean-order.md` · **Upstream ids** none
<!--needs FS110-N3-CONF: -->

<!--q FS110-N3-CONF statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> Contacts of a colour on `ω(v)` are in-type or out-type; directions of `c`-sectors lie in `D_c(v)`; compact sets inside `int D_c(v)` are clear near `v`; tangent in- and out-contacts are upward closed.

<!--q FS110-N3-CONF not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS110-N3-CONF grade-->
**Grade as filed:**
> hand; two minds, one blind: N3; NB3

<!--q FS110-N3-CONF minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS110-N3-CONF handoff-->
**`*Kernel:*` line as filed:**
> with FS110-CLOSURE.

## FS110-N3-DEG
`plans/LEAN-BACKLOG.md:333`

### 10. FS110-N3-DEG
<!--row FS110-N3-DEG plans/FS110-derivation.md:61-->
**Address** `plans/FS110-derivation.md:61` · **Role** upstream · **Era** R · **Was** — in `lean-order.md` · **Upstream ids** FS110-N3-CONF
<!--needs FS110-N3-DEG: FS110-N3-CONF-->

<!--q FS110-N3-DEG statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> `int D_c(v)` is empty only in Woodall's cone: out-type `c`-contacts at both `v ± n`, every `c`-sector a cusp horn along `±a` with bounding curvatures in `(−1, 1)`.

<!--q FS110-N3-DEG not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS110-N3-DEG grade-->
**Grade as filed:**
> hand; three minds, two blind: N3; NB3; NB4

<!--q FS110-N3-DEG minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS110-N3-DEG handoff-->
**`*Kernel:*` line as filed:**
> with FS110-CLOSURE.

## FS110-N4-SHADOW
`plans/LEAN-BACKLOG.md:356`

### 11. FS110-N4-SHADOW
<!--row FS110-N4-SHADOW plans/FS110-derivation.md:70-->
**Address** `plans/FS110-derivation.md:70` · **Role** upstream · **Era** R · **Was** — in `lean-order.md` · **Upstream ids** none
<!--needs FS110-N4-SHADOW: -->

<!--q FS110-N4-SHADOW statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> The shadow near `v` of a tile at `N = v + n` beyond an arc tangent to `a` at `N` is one side of the circle through `v` concentric with that arc; curvature `f(λ) = λ/(1 + λ)` going down, `f̃(υ) = υ/(1 − υ)` going up; a horn is shadowed by its flanks only through out-type tiles at `S′` and `N` tangent to `a` (N4-FLANK).

<!--q FS110-N4-SHADOW not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS110-N4-SHADOW grade-->
**Grade as filed:**
> hand; four minds, two blind: N4; Y4 as Y4-MU; NB4; YB4

<!--q FS110-N4-SHADOW minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS110-N4-SHADOW handoff-->
**`*Kernel:*` line as filed:**
> with FS110-CLOSURE.

## FS110-N4-SHAVE
`plans/LEAN-BACKLOG.md:379`

### 12. FS110-N4-SHAVE
<!--row FS110-N4-SHAVE plans/FS110-derivation.md:75-->
**Address** `plans/FS110-derivation.md:75` · **Role** upstream · **Era** R · **Was** — in `lean-order.md` · **Upstream ids** FS110-N4-SHADOW
<!--needs FS110-N4-SHAVE: FS110-N4-SHADOW-->

<!--q FS110-N4-SHAVE statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> A horn tip can be recoloured by its two flank colours, valid and keeping Condition 5, unless doubly shadowed (`σ_h < σ_g`); two horns of one colour on one ray merge (N4-RAY).

<!--q FS110-N4-SHAVE not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS110-N4-SHAVE grade-->
**Grade as filed:**
> hand; two minds, one blind: N4; NB4

<!--q FS110-N4-SHAVE minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS110-N4-SHAVE handoff-->
**`*Kernel:*` line as filed:**
> with FS110-CLOSURE.

## FS110-N4-STUCK
`plans/LEAN-BACKLOG.md:402`

### 13. FS110-N4-STUCK
<!--row FS110-N4-STUCK plans/FS110-derivation.md:80-->
**Address** `plans/FS110-derivation.md:80` · **Role** upstream · **Era** R · **Was** — in `lean-order.md` · **Upstream ids** FS110-N3-DEG, FS110-N4-SHAVE
<!--needs FS110-N4-STUCK: FS110-N3-DEG,FS110-N4-SHAVE-->

<!--q FS110-N4-STUCK statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> At a vertex admitting no merge, ray merge or shave, a two-sector colour has exactly two horns `±a`, the vertex has degree 4, and the antipodes carry `P_cl(N) = {c, h, r}`, `P_cl(S′) = {c, g, r′}` with double sectors; in a terminal map a stuck vertex forces stuck vertices at unit spacing along the normal line, bi-infinite (N4-PROP).

<!--q FS110-N4-STUCK not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS110-N4-STUCK grade-->
**Grade as filed:**
> hand; two minds, one blind: N4; NB4

<!--q FS110-N4-STUCK minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS110-N4-STUCK handoff-->
**`*Kernel:*` line as filed:**
> with FS110-CLOSURE.

## FS110-N4-FIN
`plans/LEAN-BACKLOG.md:425`

### 14. FS110-N4-FIN
<!--row FS110-N4-FIN plans/FS110-derivation.md:84-->
**Address** `plans/FS110-derivation.md:84` · **Role** upstream · **Era** R · **Was** — in `lean-order.md` · **Upstream ids** FS110-N4-SHADOW, FS110-N4-STUCK
<!--needs FS110-N4-FIN: FS110-N4-SHADOW,FS110-N4-STUCK-->

<!--q FS110-N4-FIN statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`.

<!--q FS110-N4-FIN not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS110-N4-FIN grade-->
**Grade as filed:**
> hand; two minds, one blind: N4; NB4

<!--q FS110-N4-FIN minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS110-N4-FIN handoff-->
**`*Kernel:*` line as filed:**
> with FS110-CLOSURE — an exact inequality chain, a leaf.

## FS110-W-MERGE
`plans/LEAN-BACKLOG.md:448`

### 15. FS110-W-MERGE
<!--row FS110-W-MERGE plans/FS110-derivation.md:51-->
**Address** `plans/FS110-derivation.md:51` · **Role** upstream ROUTE-ONLY · **Era** R · **Was** — in `lean-order.md` · **Upstream ids** FS110-N3-CONF
<!--needs FS110-W-MERGE: FS110-N3-CONF-->

<!--q FS110-W-MERGE statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> Woodall's step 3 almost everywhere for curved arcs: if `int D_c(v)` is nonempty, two non-adjacent `c`-sectors at `v` are joined by recolouring the gap inside `D_c(v)` near `v`; validity and Condition 5 kept, types only shrink.

<!--q FS110-W-MERGE not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS110-W-MERGE grade-->
**Grade as filed:**
> hand; two minds, one blind: N3; NB3

<!--q FS110-W-MERGE minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS110-W-MERGE handoff-->
**`*Kernel:*` line as filed:**
> with FS110-CLOSURE.

## FS112-A4SIX
`plans/LEAN-BACKLOG.md:1078`

### 39. FS112-A4SIX
<!--row FS112-A4SIX plans/FS112-derivation.md:63-->
**Address** `plans/FS112-derivation.md:63` · **Role** upstream · **Era** R · **Was** 47 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-A4SIX: -->

<!--q FS112-A4SIX statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> A four-colour vertex with no covering pair on its unit circle has on that circle arcs of `Γ` centred at it of total length at least 60°, or at least six, one in each of six consecutive 60° windows (C-UA-BUDGET, branch 1).

<!--q FS112-A4SIX not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-A4SIX grade-->
**Grade as filed:**
> hand; three minds, one blind: A4; N; NB

<!--q FS112-A4SIX minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-A4SIX handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-BOWTIE
`plans/LEAN-BACKLOG.md:1103`

### 40. FS112-BOWTIE
<!--row FS112-BOWTIE plans/FS112-derivation.md:357-->
**Address** `plans/FS112-derivation.md:357` · **Role** upstream ROUTE-ONLY · **Era** R · **Was** 48 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-BOWTIE: -->

<!--q FS112-BOWTIE statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> An exact valid local fragment realises a one-vertex stuck chain bounded by unit arcs on both sides: `E = (0, 0)` with three colours, its two horns of colour 2 between `ω(E + n)` and `ω(E − n)`, shadowed by in-type radius-1 sectors of colours 1 and 3 at `E + n` and `E − n`; both neighbours four-coloured, one sector per colour, neither stuck, no MERGE, MERGE-RAY or SHAVE applicable at `E`, `E ± n`; every unit arc's end interior with its neighbourhood coloured.

<!--q FS112-BOWTIE not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-BOWTIE grade-->
**Grade as filed:**
> tools, exact; one fragment: YB3; one checker, YB2's tower checker; stuckness exact at the antipodes and at named points

<!--q FS112-BOWTIE minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-BOWTIE handoff-->
**`*Kernel:*` line as filed:**
> declined — an exact fragment; FS-115 may promote it.

## FS112-C-DOUBLE
`plans/LEAN-BACKLOG.md:1126`

### 41. FS112-C-DOUBLE
<!--row FS112-C-DOUBLE plans/FS112-derivation.md:237-->
**Address** `plans/FS112-derivation.md:237` · **Role** upstream ROUTE-ONLY · **Era** R · **Was** 50 in `lean-order.md` · **Upstream ids** FS112-BOWTIE
<!--needs FS112-C-DOUBLE: FS112-BOWTIE-->
**Cautions:** [C116](#c116)

<!--q FS112-C-DOUBLE statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> In a terminal valid map, a stuck vertex `E` all four of whose horn arcs are unit arcs, of `ω(E + n)` above and `ω(E − n)` below, carries an in-type tile of its upper flank colour at `E + n` and of its lower flank colour at `E − n`, and both are (Q) centres with at least four colours.

<!--q FS112-C-DOUBLE not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-C-DOUBLE grade-->
**Grade as filed:**
> hand; one mind: FS112-C2, a sketch over FS112-Y3-END-NEEDS's levels with n reversed and FS112-N2-TERM

<!--q FS112-C-DOUBLE minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-C-DOUBLE handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-115.

<!--q FS112-C-DOUBLE note@448-->
**errata-section item 3 (`plans/FS112-derivation.md:448`):**
> 3. **FS112-C-DOUBLE and FS112-C-PARTNERS — regrade (upgrade):** two minds, FS112-C (with FS112-C2 for C-DOUBLE) and FS114-CV, blind to the FS112-C
>    assembly; C-PARTNERS is a corollary of FS112-N3-COR3 (CV-PART). *Source:* `plans/FS114-CV-verification.md` §1.5, §2.4.

<!--q FS112-C-DOUBLE merge@SR2-4.3-QUOTE-->
**Merge note — quote with its errata** (SR2-4.3 item QUOTE, `plans/FS129-SR2-audit.md:492-493`; status applied):
> - Quote **FS112-C-ENDS** in its erratum's form (residue deleted), and **FS112-C-DOUBLE**, **FS112-N3-BASE**, **FS114-N2-ENDS**, **FS114-N3-JOINT**, **FS114-N7-3T** with the errata under them (§ 2.4): the backlog quotes entries by script and the index carries no erratum.

## FS112-FLANK
`plans/LEAN-BACKLOG.md:1188`

### 43. FS112-FLANK
<!--row FS112-FLANK plans/FS112-derivation.md:99-->
**Address** `plans/FS112-derivation.md:99` · **Role** upstream · **Era** R · **Was** 52 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-FLANK: -->

<!--q FS112-FLANK statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> N4-FLANK fails when a horn's bounding arc is a unit arc centred at `N` (`κ₊ = 1`) or `S′` (`κ₋ = −1`): an in-type flank tile at the centre is then Siamese with the flank and shadows a band of the horn, and SHAVE's criterion is incomplete there.

<!--q FS112-FLANK not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-FLANK grade-->
**Grade as filed:**
> hand; two minds: N, blind to NB; NB sighted, after its stage 1 had "survives"

<!--q FS112-FLANK minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-FLANK handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-ISO
`plans/LEAN-BACKLOG.md:1213`

### 44. FS112-ISO
<!--row FS112-ISO plans/FS112-derivation.md:82-->
**Address** `plans/FS112-derivation.md:82` · **Role** upstream · **Era** R · **Was** 53 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-ISO: -->

<!--q FS112-ISO statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> Isolated inner-colour contacts at `P + 2e_{w₀}` exist locally (an inner-colour tile outside `B̄(P, 2)` but for a corner), and block a first-order away-bend.

<!--q FS112-ISO not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-ISO grade-->
**Grade as filed:**
> hand; two minds: NB; N2 conceding

<!--q FS112-ISO minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-ISO handoff-->
**`*Kernel:*` line as filed:**
> declined — a local example.

## FS112-LOCK
`plans/LEAN-BACKLOG.md:1236`

### 45. FS112-LOCK
<!--row FS112-LOCK plans/FS112-derivation.md:72-->
**Address** `plans/FS112-derivation.md:72` · **Role** upstream · **Era** R · **Was** 54 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-LOCK: -->

<!--q FS112-LOCK statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> For `w` interior to a unit arc `α ⊂ ω(P)`, a tile of either side colour touches `ω(w)` only at `P`, or — the inner colour only — at `P + 2e_w`, from outside `B(P, 2)`.

<!--q FS112-LOCK not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-LOCK grade-->
**Grade as filed:**
> hand; two minds, one blind, different routes: N; NB; the outer colour's exclusion at radius 2 tools exact

<!--q FS112-LOCK minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-LOCK handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-N2-BENDS
`plans/LEAN-BACKLOG.md:1290`

### 47. FS112-N2-BENDS
<!--row FS112-N2-BENDS plans/FS112-derivation.md:87-->
**Address** `plans/FS112-derivation.md:87` · **Role** upstream · **Era** R · **Was** 56 in `lean-order.md` · **Upstream ids** FS112-ISO, FS112-LOCK
<!--needs FS112-N2-BENDS: FS112-ISO,FS112-LOCK-->

<!--q FS112-N2-BENDS statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> A whole unit arc, end vertices included, bends toward its centre whenever its outer colour is absent there, and away whenever its inner colour is absent there and no inner-colour tile touches the radius-2 arc `R₂(ᾱ)`; isolated R2 contacts are cleared by a tangent bend, and only R2 along an arc blocks. Its lemmas: every point `≠ P` of a side-colour tile is within `< 1` of all of `int α` or `> 1` from all of it (N2-SIGN); a lens point's disc leaves the union of unit discs about `ᾱ` only near `P` or near `R₂(ᾱ)` (N2-ENV).

<!--q FS112-N2-BENDS not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-N2-BENDS grade-->
**Grade as filed:**
> hand; two minds, one blind: N2; NB2; N2-TOWARD by different routes; identities tools exact

<!--q FS112-N2-BENDS minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-N2-BENDS handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

<!--q FS112-N2-BENDS merge@SR1-6.2-5-->
**Merge note — named** (SR1-6.2 item 5, `plans/FS129-SR1-audit.md:546-547`; status applied):
> 5. **FS129-SR1-BENDANY** and **FS129-SR1-BENDLE3** in place of FS129-OR1-BENDFRAG and FS129-OR1-BEND3, over FS129-OR1-WHOLE and FS112-N2-BENDS, by N2's route at end vertices (§ 2.1), with the connectedness step by quasi-components.

<!--q FS112-N2-BENDS merge@SR2-4.3-13-->
**Merge note — to formalize** (SR2-4.3 item 13, `plans/FS129-SR2-audit.md:475-475`; status applied):
> 13. **FS112-N2-BENDS** (or SR1's BENDANY) in place of **FS112-BEND**; **FS112-N2-TERM** in place of **FS112-N2-RED** (RED's procedure as TERM's lemma).

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-N2-FLANK-Q
`plans/LEAN-BACKLOG.md:1323`

### 48. FS112-N2-FLANK-Q
<!--row FS112-N2-FLANK-Q plans/FS112-derivation.md:108-->
**Address** `plans/FS112-derivation.md:108` · **Role** upstream · **Era** R · **Was** 57 in `lean-order.md` · **Upstream ids** FS112-FLANK
<!--needs FS112-N2-FLANK-Q: FS112-FLANK-->

<!--q FS112-N2-FLANK-Q statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> Every horn bound of exactly `±1` sits on a (Q) arc — FLANK's in-type exception, and then both horns' upper arcs form one arc of `ω(N)` through `v` — or on an (R2) arc, whose inner-colour tile along the radius-2 circle is FLANK's out-type tile at the far antipode.

<!--q FS112-N2-FLANK-Q not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-N2-FLANK-Q grade-->
**Grade as filed:**
> hand; two minds, one blind: N2; NB2, sighted on the one-arc clause

<!--q FS112-N2-FLANK-Q minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-N2-FLANK-Q handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-N2-RAY
`plans/LEAN-BACKLOG.md:1348`

### 49. FS112-N2-RAY
<!--row FS112-N2-RAY plans/FS112-derivation.md:112-->
**Address** `plans/FS112-derivation.md:112` · **Role** upstream · **Era** R · **Was** 58 in `lean-order.md` · **Upstream ids** FS112-FLANK
<!--needs FS112-N2-RAY: FS112-FLANK-->

<!--q FS112-N2-RAY statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> N4-FIN's application fails at a chain's end; a one-sided stuck chain with `λ_k = −1/(k+1)`, `υ_k = 0` is consistent with N4-FIN; so N4-CONE is a GAP under unit arcs — the extremal chain is the pencil of circles of radius `k + 1` about `P_{−1}` with straight upper arcs, every shadow tight.

<!--q FS112-N2-RAY not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-N2-RAY grade-->
**Grade as filed:**
> hand; two minds, one blind: N2; NB2; the pencil one mind, NB2; RAY exact

<!--q FS112-N2-RAY minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-N2-RAY handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-N3-ANTI
`plans/LEAN-BACKLOG.md:1373`

### 50. FS112-N3-ANTI
<!--row FS112-N3-ANTI plans/FS112-derivation.md:153-->
**Address** `plans/FS112-derivation.md:153` · **Role** upstream · **Era** R · **Was** 59 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-N3-ANTI: -->

<!--q FS112-N3-ANTI statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> CE5, the Antipodal Lemma, survives unit arcs: at a cubic trichromatic vertex no two points of its unit circle at distance 2 are both M-in.

<!--q FS112-N3-ANTI not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-N3-ANTI grade-->
**Grade as filed:**
> hand; two minds, one blind, different routes: N3; NB3; tools exact, ANTI

<!--q FS112-N3-ANTI minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-N3-ANTI handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-N3-FAIL
`plans/LEAN-BACKLOG.md:1398`

### 51. FS112-N3-FAIL
<!--row FS112-N3-FAIL plans/FS112-derivation.md:148-->
**Address** `plans/FS112-derivation.md:148` · **Role** upstream · **Era** R · **Was** 60 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-N3-FAIL: -->

<!--q FS112-N3-FAIL statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> At a cubic trichromatic `u`, CB's D2 strip fails at `q ∈ ω(u)` only when `q` is a leaving centre of `u` (the centre of a unit arc ending at `u`); there the colours of `c(u)` allowed inside `ω(u)` near `q` are exactly the inner colours of those arcs, outside exactly their outer colours.

<!--q FS112-N3-FAIL not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-N3-FAIL grade-->
**Grade as filed:**
> hand; two minds, one blind, different routes: N3; NB3; tools exact, VOTES; FAIL

<!--q FS112-N3-FAIL minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-N3-FAIL handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-N3-NOBOTH
`plans/LEAN-BACKLOG.md:1423`

### 52. FS112-N3-NOBOTH
<!--row FS112-N3-NOBOTH plans/FS112-derivation.md:144-->
**Address** `plans/FS112-derivation.md:144` · **Role** upstream · **Era** R · **Was** 61 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-N3-NOBOTH: -->

<!--q FS112-N3-NOBOTH statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour.

<!--q FS112-N3-NOBOTH not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-N3-NOBOTH grade-->
**Grade as filed:**
> hand; two minds, one blind: N3; NB3; over FS112-U1

<!--q FS112-N3-NOBOTH minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-N3-NOBOTH handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-N3-END
`plans/LEAN-BACKLOG.md:1448`

### 53. FS112-N3-END
<!--row FS112-N3-END plans/FS112-derivation.md:184-->
**Address** `plans/FS112-derivation.md:184` · **Role** upstream ROUTE-ONLY · **Era** R · **Was** 62 in `lean-order.md` · **Upstream ids** FS112-N2-FLANK-Q, FS112-N3-NOBOTH
<!--needs FS112-N3-END: FS112-N2-FLANK-Q,FS112-N3-NOBOTH-->

<!--q FS112-N3-END statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> A stuck chain's end with horn bound `−1` has a vertex one step beyond it carrying at least four colours and a repeated colour, and a both-kind unit arc centred two steps beyond it; or, if an in-type flank tile sits at the other neighbour, both horns' upper arcs lie on that neighbour's unit circle and the chain is the single vertex.

<!--q FS112-N3-END not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-N3-END grade-->
**Grade as filed:**
> hand; two minds, one blind: N3; NB3

<!--q FS112-N3-END minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-N3-END handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-N3-PAIRS
`plans/LEAN-BACKLOG.md:1473`

### 54. FS112-N3-PAIRS
<!--row FS112-N3-PAIRS plans/FS112-derivation.md:166-->
**Address** `plans/FS112-derivation.md:166` · **Role** upstream · **Era** R · **Was** 63 in `lean-order.md` · **Upstream ids** FS112-N3-NOBOTH
<!--needs FS112-N3-PAIRS: FS112-N3-NOBOTH-->

<!--q FS112-N3-PAIRS statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> The base's pair steps survive unit arcs: (i) never fails; (ii) fails only when a point read has at least four colours or its partner is a both-centre; two cubic trichromatic vertices with one multicolour are never at distance 1.

<!--q FS112-N3-PAIRS not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-N3-PAIRS grade-->
**Grade as filed:**
> hand; two minds, one blind: N3; NB3; (i)'s unconditional form one mind, N3, with NB3's sighted check

<!--q FS112-N3-PAIRS minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-N3-PAIRS handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-NB4P
`plans/LEAN-BACKLOG.md:1498`

### 55. FS112-NB4P
<!--row FS112-NB4P plans/FS112-derivation.md:55-->
**Address** `plans/FS112-derivation.md:55` · **Role** upstream · **Era** R · **Was** 64 in `lean-order.md` · **Upstream ids** FS112-A4SIX
<!--needs FS112-NB4P: FS112-A4SIX-->

<!--q FS112-NB4P statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> NB-4 corrected: at a vertex of exactly four colours, let `(v, y₀)` be a covering pair at a change point of its ring; if no point of `y₀`'s `σ_v`-orbit lies in the closure of an arc of `Γ` on `ω(v)`, and no arc of `Γ` on `ω(y_{k±1})` has `y_k` in its closure, contradiction; the bound on the colours at `y_k` is not needed.

<!--q FS112-NB4P not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-NB4P grade-->
**Grade as filed:**
> hand; three minds, one blind: N; NB; Y2

<!--q FS112-NB4P minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-NB4P handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS112-U1
`plans/LEAN-BACKLOG.md:1556`

### 57. FS112-U1
<!--row FS112-U1 plans/FS112-derivation.md:42-->
**Address** `plans/FS112-derivation.md:42` · **Role** upstream · **Era** R · **Was** 66 in `lean-order.md` · **Upstream ids** none
<!--needs FS112-U1: -->

<!--q FS112-U1 statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> At a unit arc `α ⊂ ω(P)` of angular length `ℓ`, an inner side colour in `P_cl(P)` has its sectors at `P` in the closed cone of width `π − ℓ` facing `α`, an outer one in the closed cone facing away; both side cones hold neither; the outer tile's first-order shadow near `P` contains the open facing cone of width `π + ℓ`.

<!--q FS112-U1 not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-U1 grade-->
**Grade as filed:**
> hand; two minds, one blind: N; NB

<!--q FS112-U1 minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-U1 handoff-->
**`*Kernel:*` line as filed:**
> stub — with the NO's map argument (FS-114).

<!--q FS112-U1 merge@SR1-6.2-4-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 4, `plans/FS129-SR1-audit.md:545-545`; status applied):
> 4. **FS116-V5-U1**'s first three clauses in place of FS112-U1's; U1's shadow clause and V5-U1's four-colour clause as two corollaries.

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS114-L60-LE
`plans/LEAN-BACKLOG.md:1660`

### 61. FS114-L60-LE
<!--row FS114-L60-LE plans/FS114-derivation.md:930-->
**Address** `plans/FS114-derivation.md:930` · **Role** upstream · **Era** R · **Was** 70 in `lean-order.md` · **Upstream ids** FS106-TS-C
<!--needs FS114-L60-LE: FS106-TS-C-->

<!--q FS114-L60-LE statement-->
**Statement as filed:**
> (L60-LE) a unit arc with constant sides has `ℓ ≤ 60°` (its ends lie in the closure of one tile); (L60-EQ) at `ℓ = 60°` both side tiles lie in the lens `B̄(A, 1) ∩ B̄(B, 1)`: `T_in ⊆ Reul(P, A, B)`, `T_out ⊆ Reul(A, B, C) ∖ B̄(P, 1)`, `C = A + B − P`; at each end their sectors lie in the two corner cones (120° and 60°), which fill exactly the closed half-plane facing the other end, so each end is a vertex carrying a third tile; (L60-REAL) equality is realised, by a valid fragment by formula on a neighbourhood of the closed arc

<!--q FS114-L60-LE not_claimed-->
**Not claimed:**
> FS112-L60 as filed ("below 60°": FALSE at exactly 60°, the erratum in `plans/FS112-derivation.md`); the second clause's "ends" reading (FALSE at equality); that the equality case occurs in a valid map

<!--q FS114-L60-LE grade-->
**Grade as filed:**
> hand

<!--q FS114-L60-LE minds-->
**Minds as filed:**
> 2 — blind to: nothing of the other's frame for the bound (FS114-L60 was briefed with FS114-N4's record open; N4 found it first) — blind to: the FS112-N and FS112-NB proofs' conclusions at the boundary, which both break at 60° by different steps (L60-PROOFS); method: N4 by the Reuleaux cap tile; L60 by the lens and the corner cones, with a fragment; the inner clause and the ends one mind

<!--q FS114-L60-LE handoff-->
**Handoff as filed:**
> none — a correction of an FS-112 lemma, filed with its erratum

<!--q FS114-L60-LE merge@SR2-4.3-14-->
**Merge note — to formalize** (SR2-4.3 item 14, `plans/FS129-SR2-audit.md:476-476`; status applied):
> 14. **FS114-L60-LE** in place of **FS112-L60**.

## FS112-BEND — merged into FS112-N2-BENDS
`plans/LEAN-BACKLOG.md:1261`

### 46. FS112-BEND
<!--row FS112-BEND plans/FS112-derivation.md:77-->
**Address** `plans/FS112-derivation.md:77` · **Role** upstream · **Era** R · **Was** 55 in `lean-order.md` · **Upstream ids** FS112-LOCK
<!--needs FS112-BEND: FS112-LOCK-->

<!--q FS112-BEND statement-->
**Statement as filed (the header's own words; the entry has no `statement:` field):**
> Off its end vertices a unit arc can be bent off radius 1, keeping validity and creating no unit arc: toward `P` unless its outer colour is at `P`; away from `P` unless its inner colour is at `P` or lies along the radius-2 circle.

<!--q FS112-BEND not_claimed-->
**Not claimed:** *(empty in the source — no such field)*

<!--q FS112-BEND grade-->
**Grade as filed:**
> hand; two minds, one blind: N; NB

<!--q FS112-BEND minds-->
**Minds as filed (older grammar: inside the grade):** *(empty in the source — no such field)*

<!--q FS112-BEND handoff-->
**`*Kernel:*` line as filed:**
> stub — with FS-114.

<!--q FS112-BEND merge@SR2-4.3-13-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 13, `plans/FS129-SR2-audit.md:475-475`; status applied):
> 13. **FS112-N2-BENDS** (or SR1's BENDANY) in place of **FS112-BEND**; **FS112-N2-TERM** in place of **FS112-N2-RED** (RED's procedure as TERM's lemma).

*Section notes of `plans/FS112-derivation.md` (items 7, 8) govern this row's `*Kernel:*` line: see § How to read this file.*

## FS114-L60-WALK — merged into FS114-L60-LE
`plans/LEAN-BACKLOG.md:1947`

### 70. FS114-L60-WALK
<!--row FS114-L60-WALK plans/FS114-derivation.md:951-->
**Address** `plans/FS114-derivation.md:951` · **Role** upstream · **Era** R · **Was** 80 in `lean-order.md` · **Upstream ids** FS112-N3-NOBOTH, FS114-L60-LE
<!--needs FS114-L60-WALK: FS112-N3-NOBOTH,FS114-L60-LE-->

<!--q FS114-L60-WALK statement-->
**Statement as filed:**
> (L60-WALK) no step of FS112-N2-RED, FS112-N3-COR3, FS112-N3-BASE, FS112-N3-DENSE3 or FS114-CV-EXISTS (with CVB-EXISTS) needs the strict bound; each use of "`< 60°`" in their frames needs `0 < ℓ ≤ 60°` or only `0 < ℓ < 180°`, and the equality case passes every step; two remarks outside the chain are false at equality (NB's C-UA-CHAIN aside, N's ends reading of the second clause) and nothing rests on them; (L60-D5) in N3-BASE's setting, the two ends of a circle-to-circle path (CB D5 item 1) are less than 1 apart

<!--q FS114-L60-WALK not_claimed-->
**Not claimed:**
> a blind second mind (the registered L60-P1, p 0.85, and L60-P2, p 0.9, wait for one that never ran)

<!--q FS114-L60-WALK grade-->
**Grade as filed:**
> hand

<!--q FS114-L60-WALK minds-->
**Minds as filed:**
> 1

<!--q FS114-L60-WALK handoff-->
**Handoff as filed:**
> none — an audit of a chain; its blind second mind is owed before publication

