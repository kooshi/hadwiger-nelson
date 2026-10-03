
## Stage 4 — SAVED: J11–J24, the mechanical half, and the cross-era line

### J11 — FS-120: the pinch at a junction
**The step**: (`plans/STUB-pinch-at-junction.md` ll. 28–29): "**The question: where the ladder ends — at a junction of three or more colours, at a class with disconnected local parts, or at an irregular class — is the cascade absorbed?** Three questions, in order:"

**Kind of input**: a modification lemma along the ladder of unit parallels, ending at a junction. Admissible.
**Read for it**: FS111-M4-LADDER, -M4-CUT, -M4-MOVE, -M4-HC, -M3-CASCADE, -M3-MOVE, -M3-COVER, -M3-FIN-U; FS121-D4-FALL, -D4-GRID, -D3-FALLSAT.
**Verdict: null.** M4-MOVE (the classes at every rung agree when two partitions differ only over a gap, "no spare colour enters, at any k") and
M3-CASCADE (every gaining class loses all its old material) are the stub's own inputs; no lane-R result says where the cascade ends at a junction.

### J12 — FS-104 route (c): correlation constraints on stationary colourings
**The step**: (`plans/STUB-cp-plane-six.md` ll. 67–69): "- **(c) `k`-point correlation constraints** on stationary colourings — the tetrahedral embedding at five colours, three- and four-point Bessel kernels à la Bachoc–Oliveira–Vallentin; FS-80's averaged certificate at the real place (FS-80 re-aimed). An optimisation: post-ban unless its shape is derived first (the advisor)."

**Kind of input**: a spectrum or multi-point correlation of an invariant random colouring; § 2's row 91 / G75 note excludes pair correlations on a
real field. Admissible at three or more points.
**Read for it**: FS106-SUP, -EQ, -COMP, -REM, -PDEQ; FS107-W-EQ-K.
**Verdict: null** (lane R, as the list expected). Near miss: FS106-SUP (`µ₆⁰` is attained by a stationary family and by almost every sample of it) supplies
the stationary object route (c) would take correlations of; it constrains nothing.

### J13 — FS-104 routes (0) and (b): Falconer's mechanism, read as a CP statement
**The step**: (`plans/STUB-cp-plane-six.md` ll. 59–61): "- **(0) Read `[Falconer1981]` first, as a CP statement** — the advisor: continuity in probability lets a forced pair's distance vary continuously, which may be Falconer's mechanism. Owed before any route is ranked (G50). With it: Soifer's measurability chapter, the Polymath16 measurable page, Bachoc–Nebe–Oliveira–Vallentin (arXiv:0801.1059), `[AmbrusEtAl2023]`."

**Kind of input**: a compulsion — a pair forced equal or apart at a continuously varying distance. Admissible.
**Read for it**: FS106-REM (kept points never at distance in `[1 − ε, 1 + ε]`; its uniform form false), -COMP, -EQ; FS111-V0-ID1.
**Verdict: null** (lane R). The reading of `[Falconer1981]` is lane A's and the stub's.

### J14 — FS-122: B-RR, a cone-scale bound independent of the holes
**The step**: (`plans/STUB-forced-pair.md` ll. 23–24): "1. **B-RR** — a cone-scale lower bound `s₀`, **independent of `δ`**, at the pairs (A) supplies. The `δ`-dependent form B-NONABS is FALSE as written (`FS111-W-B-NONABS`: a fragment has holes `≲ (ε + s)²` near the forced point at every scale `s`); B-RR cannot be refuted by a wild object."

**Kind of input**: a feature's scale bounded below, priced at the feature's scale (G82 as corrected). Admissible.
**Read for it**: FS107-RR, -R-CP, -V-CP, -W-TAN, -R-SW, -R-OB2, -K-AD, -MEET; FS111-W-B-NONABS, -W-HX-PAIRS, -W-NEG, -C1-FALS, -V0-WIGGLE.
**Verdict: null.** Near misses: FS111-W-HX-PAIRS (HX carries complementary fat-junction pairs blocking toward points inside its voids — the holes sit
where R-CP puts them, at an `ε`-independent scale set by the design) and FS111-V0-WIGGLE (notching raises complexity at fixed slack and fixed cones,
cost `O(α²)`) bound B-RR's form from the construction side; neither is a lower bound.

### J15 — Route R's pairs and route M's four-colour vertices, with unit arcs (Poros's invention signal)
**The step**: (Poros's words): with unit arcs — where route M's open steps live — does every close complementary pair of route R meet a vertex of at
  least four colours at its common unit points, so that FS-123's and FS-124's exclusions bear on route R below the answer?

**Kind of input**: a band-stable form of row 135's rhombus lemma. Admissible.

**Read for it**: FS112-N3-COR3, -STOP, -Y3-R3, -STRIP-SEAMS, -C-PARTNERS, -Y3-T2-BUDGET, -FORCE; FS110-NB-5, -N-SEAM, -Y-T2W; FS107-W-TAN, -R-CP, -MEET,
-RR; FS114-Y-PAIRSHARE; FS129-OR1-QFREE.

**The collision, both sides quoted, no side picked until the premise is named.**
- *Side 1* (`plans/STUB-forced-pair.md` ll. 35–37, verbatim): "Under Condition 5 at bounded complexity no close complementary pair exists in a valid map
  at all (row 134, NB-5), which is why the map line never needed (A); so this route and FS-121's meet nowhere below the answer."
- *Side 2* (`LEDGER.md` row 135, as the demand list quotes it): "a close complementary pair of cubic trichromatic vertices sits on a unit rhombus with
  four-colour corners (FS-110's T2, forced)"; and FS112-STOP (`plans/FS112-derivation.md`, verbatim): "The pinned corner: the strip and the disk stop at
  the same kind of point, the second common unit point of a close complementary trivalent pair saved at its first by a four-colour vertex where both
  members emit arcs of its circle"; FS112-Y3-R3: "At both held positives every close complementary pair of vertices is saved at one common unit point by
  half of T2, at both exactly when it is a rhombus completion (T2 twice), and its unsaved second point is where the positive stops".

**The premise both sides share, named:** that "close complementary pair" names one object across the two routes. Side 1's *reason* is a theorem about
exact valid maps **under Condition 5** (row 134; FS110-NB-5: "Under Condition 5 a tight six-map in `𝓜_K` has no close covering pair"); its *conclusion*
("meet nowhere below the answer") carries no such restriction. With unit arcs — where route M's open steps live — exact valid fragments carry close
complementary pairs (24 per period on the strip, 20 on the disk, FS112-Y3-R3's exact recount), FS112-N3-COR3 forces four-colour vertices at both common
unit points of every cubic trichromatic one in a valid map, and both held positives stop exactly at a pair's unsaved second common unit point — which is
route R's mechanism (FS107-R-CP: a complementary pair blocking toward `w` forces holes at `w`) at `ε = 0`. FS107-MEET already reads W-TAN and R-CP as
"one fact, C-T-TAN's cone case, read as a design rule and as an area".

**Verdict: the invention signal does not stand** — no two held results contradict; side 1 is a stub's bearing sentence whose conclusion exceeds its reason.
It is a **statement defect** in `plans/STUB-forced-pair.md` l. 37 (correction owed, Keryx's file): "meet nowhere below the answer" holds under Condition 5;
with unit arcs the routes meet at the pinned corner (FS112-STOP). **Answer to Poros's question**, in its exact-map form: yes for cubic trichromatic pairs —
in a valid map both common unit points are vertices of at least four colours whose rings carry both-kind, hence (Q), arcs (FS112-N3-COR3), so they are
FS-124's class (FS129-OR1-QFREE confirms none is (Q)-free), and a local exclusion of four-colour vertices with (Q) rings leaves no such pair in any valid
map. At `ε > 0` the bearing on route R needs a band-stable four-colour kill: **J15 reduces to J16's carried card**. Not covered: route R's fat junctions of
higher degree (COR3 is for cubic trichromatic vertices).

### J16 — FS-122: a robust count, and whether the kills survive a band
**The step**: (`plans/STUB-forced-pair.md` ll. 25–27): "2. **What replaces the bicycle's swap at unbounded complexity** — the index of density traces (G71, row 132) is the one integer invariant held for six-colour interfaces, and it fails where a unit-arc interface faces a bowtie; `[Voronov2023]` Lemma 6.1's branch (i) ends at a bicycle, whose swap FS107-R-SW prices at `2εs` and `s³/256`."

**Kind of input**: a margin bounded below at a feature's scale. Admissible.
**Read for it**: FS114-Y4-RSTOPALL, -Y3-RSTOP, -Y5-PXKILL, -Y5-PINALL; FS107-R-SW, -R-OB2; FS106-IND, -IND-X; FS116-V6-HUG.
**Verdict: null.** FS107-R-SW (`2εs` and `s³/256` at a flat swap) and V6-HUG's second-order deficit are the stub's own data; no lane-R kill is stated with
a margin. J15 now reduces to this step.

### J17 — FS-124 cases 3, 5 and 6: crossed reciprocity, the recurrence, FS114-K1's (Q) residues
**The step**: (`plans/STUB-q-ring.md` ll. 34–35): "3. **Crossed reciprocity** (FS116-RING-TRANSFER-Q's third place): whether a crossed semi-hub's placed vertex has `p` as a crossed semi-hub — the order of its outer tiles; and FS116-N3-CROSS's last clause ("p is a semi-hub of kind O of the ring of y"), one mind and a checking reading (item 118)."

**Kind of input**: a label conserved along placements (case 5); points and distances at named configurations (cases 3, 6). Admissible.
**Read for it**: FS116-N2-STAR, -N2-RECIP, -N2-ANTI, -N3-CROSS, -V5-CROSS-S, -RING-TRANSFER-QC; FS114-K1, -N7-QOPP, -Y6-E1CAP, -Y6-E2RED, -Y6-HALF,
-Y4-RSTOPALL; FS129-OR1-BENDFRAG, -QFREE.
**Verdict: shortened, case 6 only** (no new entry). FS114-K1's residues on (Q)-free rings have no instance (FS129-OR1-QFREE, non-Siamese simple — K1's own
class); on rings with (Q) arcs, a residue whose exclusion reads below `√3` about `p` may assume `p`'s ring carries (Q) arcs and finitely many points and no
other arc of `Γ` (FS129-OR1-BENDFRAG) — N7-HUBQ's step and the (Q)-pinwheel's residual at `1 + ε` among them; the Reuleaux `(2, 1, 1, 0)` past `√3` is not
reached. Cases 3 and 5: null in lane R (the recurrence's `KG(4, 2)` reading is lane A's G73).

### J18 — FS-123 question 2: the (R2)-arc ring, directly
**The step**: (`plans/STUB-qfree-ring.md` ll. 32–34): "2. **The (R2)-arc ring, directly.** Inventory item 126: "The successor question: does FLANK's mechanism close the (Q)-free rings that carry (R2) arcs after the bends (FS114-N6-RING60's class, where N7-HUB and N7-3T live), a semi-hub whose tip is shared with the next change point, and OC?" There a change point may end an (R2) arc, RING-GERM's tip is not given, and the double tip's existence is not shown (`plans/FS116-Y4-construction.md` § 3.3)."

**Verdict: moot** — it was conditional on J1's answer being no; J1 closed yes (stage 2, FS129-OR1-QFREE): in the non-Siamese simple class no ring of a
vertex of at least four colours is (Q)-free on any disc of radius above 1, so the (R2)-arc rings of FS114-N6-RING60's class do not occur there.

### J19 — FS-124 case 8: DISC-F and LOCAL-DENSE
**The step**: (`plans/STUB-q-ring.md` ll. 47–50): "8. **The exclusion's two other forms, not worked at FS-116** (`data/fs116/claims.md` § 6): **DISC-F**, "there are an explicit radius `R` and a derivation that no valid fragment exists on any closed disc of radius `R`" (its *not claimed* line: any `R` at most the disk's `≈ 2.1246`), and **LOCAL-DENSE**, "there is an explicit `r ≥ 3` such that every valid fragment on a closed disc `B̄(x, r)` has, in `B̄(x, 3)`, a vertex of at least four colours or a vertex with a repeated colour" — with LOCAL-DENSE, C114-LOCAL-F and DISC-F are one question (`plans/FS116-local-exclusion.md` § 3.6)."

**Kind of input**: a local density lemma — a bounded-radius form of FS112-N3-DENSE3. Admissible.

**Read for it**: FS112-N3-DENSE3, -N3-BASE, -DISC1, -N2-DENSE, -N3-NOBOTH; NB3's walk of the base (`plans/FS112-NB3-verification.md` § 1.4, "every point
whose colours it reads lies in `B̄(u, 2)`", "C-LOCAL: radius 2 about `u`"); NB2's DISC1; FS114-N114-COMPACT, -CV-EXISTS; `plans/FS116-local-exclusion.md`
§ 3.6.

**Verdict: LOCAL-DENSE closed, at `r = 3`** (FS129-OR1-LOCALDENSE), **and DISC-F reduced to C114-LOCAL-F in the non-Siamese simple class**
(FS129-OR1-DISCF-NS). DENSE3's proof was already local — DISC1 reads `B̄(x, 1)`, the base reads `B̄(u, 2)` — but no record stated the fragment form.
**A correction owed to FS-116's § 3.6** ("with a local form of FS112-N3-DENSE3 … they would be the same question"): LOCAL-DENSE's alternative is a vertex
of at least four colours *or one with a repeated colour*, and C114-LOCAL-F excludes only the first. So DISC-F follows from C114-LOCAL-F with LOCAL-DENSE in
the non-Siamese simple class, where no vertex has a repeated colour; in the Siamese or non-simple class it needs, besides, either the same exclusion about
repeated-colour vertices or four-colour vertices within a bounded distance of every repeated-colour vertex — which is FS114-CV-EXISTS's *not claimed*
("GS-4's density form, which still needs FS-115's (b′) and (b″) for aperiodic maps"). **So FS-115 bears on DISC-F in the Siamese class**, against the
demand list's § 5 ("no bearing on the NO since FS114-CV-EXISTS"): a stub to re-aim (FS-115's bearing line).

derivation: FS129-OR1-LOCALDENSE
  statement: every valid six-coloured fragment on a closed disc B̄(x, 3) has, in B̄(x, 3), a vertex of at least four colours or a vertex with a repeated
    colour
  uses only: FS112-DISC1 (a closed disc of radius 1 holds a vertex of degree at least 3), read on a fragment: its argument nests tiles surrounding x, each
    of diameter at most 1 and so inside B̄(x, 1); FS112-N3-BASE, read on a fragment: if B̄(u, 2) about a cubic trichromatic vertex u holds no vertex of at
    least four colours and none with a repeated colour, the base derives a contradiction from the colours of points of B̄(u, 2) alone, after N2-TOWARD
    bends of inert unit arcs centred in B̄(u, 1) (NB3's walk: "every point whose colours it reads lies in B̄(u, 2)"; "C-LOCAL: radius 2 about u")
  not claimed: that the vertex found has at least four colours (it may have a repeated colour instead); anything below radius 3; that FS112-N3-BASE's own
    inputs (row 134's base, BASE-V's residue: CUSP-BASE's D5 items 1–4, 6 at one mind) are stronger than their grade
  argument: § Argument for FS129-OR1-LOCALDENSE
  verdict: derived
  grade: derived from: FS112-DISC1, FS112-N3-BASE
  minds: 1
  model: the capped strip on B̄(x, 3) about a point x with |x − P_0| small enough that the disc lies in the strip's validity region is not available (the
    strip's half-height is about 1.84); the disk of FS112-CAL-DISK on B̄(O, 2.1246) is too small; so the model is any valid six-coloured map restricted
    to B̄(x, 3), and no valid map is known — the statement is the local form of FS112-N3-DENSE3 and carries its use on fragments, where the YES side lives
  prior art: owed — in-house; FS112-N3-DENSE3's own prior art is "not found in print"
  handoff: de Bruijn — with FS112-N3-DENSE3's module (FS-114's stub), stated on fragments

#### Argument for FS129-OR1-LOCALDENSE

Let `F` be a valid fragment on `B̄(x, 3)`, a map of an open set `V ⊇ B̄(x, 3)`. *A vertex in `B̄(x, 1)`.* If `B̄(x, 1)` held no vertex of degree at
least 3, the tile `T₀` at `x` (or one with `x` in its closure) would be bounded near `B̄(x, 1)` by edges with no branch point, so one tile `T₁` lies across
its whole boundary and surrounds it; `T₁` has diameter at most 1 (FS116-V5-NE1) and meets every ray from `x` (it surrounds `x`), so for `y ∈ T₁` the ray
from `x` away from `y` meets `T₁` at some `w`, and `|y − x| ≤ |y − w| ≤ 1`: `T₁ ⊆ B̄(x, 1) ⊆ V`. Repeating gives infinitely many nested tiles in
`B̄(x, 1)`, against local finiteness. (This is NB2's DISC1 argument; it reads only `B̄(x, 1)`.) Let `u` be the vertex found. *If `u` has a repeated
colour or at least four colours*, done (`u ∈ B̄(x, 1) ⊆ B̄(x, 3)`). *Else `u` is cubic trichromatic.* Suppose `B̄(u, 2) ⊆ B̄(x, 3)` held no vertex of at
least four colours and none with a repeated colour (NB3's hypothesis H). FS112-N3-BASE's argument, as NB3 walks it step by step, reads the colours of
points of `B̄(u, 2)` only, and its pre-processing bends inert unit arcs centred in `B̄(u, 1)` toward their centres by N2-TOWARD, whose validity on a
fragment is FS129-OR1-BENDFRAG's "read on a fragment" (fewer tiles, fewer contacts) and which keeps H and `u`'s type (NB3 step 4); all of it lies in `V`.
So the base's contradiction is reached inside `F`: H fails, and `B̄(x, 3)` holds the vertex.

derivation: FS129-OR1-DISCF-NS
  statement: if for some R > 0 no non-Siamese simple valid six-coloured fragment exists on a closed disc of radius R about a vertex of at least four
    colours, then no non-Siamese simple valid six-coloured fragment exists on any closed disc of radius R + 3
  uses only: FS129-OR1-LOCALDENSE; that a non-Siamese simple fragment has no vertex with a repeated colour (two tiles of one colour at a vertex are near,
    FS116-V4-DICHOTOMY; one tile twice at a vertex has a closure that meets itself); that a fragment on a disc is a fragment on every smaller disc inside it
  not claimed: the Siamese or non-simple form (there LOCAL-DENSE's repeated-colour alternative is not covered by C114-LOCAL-F); the hypothesis itself
    (C114-LOCAL-F in the non-Siamese simple class, open — FS-124)
  argument: § Argument for FS129-OR1-DISCF-NS
  verdict: derived
  grade: derived from: FS129-OR1-LOCALDENSE, FS116-V4-DICHOTOMY
  minds: 1
  model: the hypothesis is open, so the model is its class: FS114-Y2-BOWTIE, a non-Siamese valid fragment about a four-colour vertex on B̄(p, 3√3/5),
    inhabits the class the hypothesis quantifies over at radius below 3√3/5
  prior art: owed — in-house
  handoff: de Bruijn — with FS129-OR1-LOCALDENSE

#### Argument for FS129-OR1-DISCF-NS

Let `F` be a non-Siamese simple valid fragment on `B̄(x, R + 3)`. It is a fragment on `B̄(x, 3)`, so FS129-OR1-LOCALDENSE gives a vertex `v ∈ B̄(x, 3)`
of at least four colours or with a repeated colour; the class has no repeated colours, so `v` has at least four. `B̄(v, R) ⊆ B̄(x, R + 3)`, so `F` is a
non-Siamese simple valid fragment on `B̄(v, R)` about a vertex of at least four colours — excluded by the hypothesis.

### J20 — FS-128: C121-NOPAR-C5
**The step**: (`plans/STUB-top-colour.md` ll. 12–14): "route, the map such a colouring would be is in the class `𝒫_6` (FS121-C1-GMAP, held), and **C121-NOPAR** says `𝒫_6` is empty; its part under Condition 5 (every boundary meets every unit circle in finitely many points) is **C121-NOPAR-C5**, where row 134's chain stops at the vertex data and at N4-FIN's strictness, which smooth horns lack (FS121-C1-FLAT, held)."

**Kind of input**: jets of boundaries along unit parallels; § 2's FS121-C1-FLAT excludes germs at the chain's points alone. Admissible.
**Read for it**: FS110-CLOSURE, -N4-FIN, -N4-TERM, -W-MERGE, -NB-4, -NB-5; FS121-C1-GMAP, -C1-SAT, -C1-FLAT, -C1-BOUND, -NOPAR-C5 (its GAP line).
**Verdict: null.** FS110-CLOSURE (row 134) answers the segment-and-arc members under Condition 5, which NOPAR-C5's own GAP line already records ("the
transfer of row 134's chain from segment-and-arc edges to edges lying on unit parallels"); the open part is smooth edges, where C1-FLAT stops the chain.

### J21 — FS-104 route (a): the density family at j = 4
**The step**: (`plans/STUB-cp-plane-six.md` ll. 62–65): "- **(a) The density family.** A CP five-colouring needs `m_j(ℝ²) ≥ j/5` for every `j ≤ 4` (X21D-Y). R1's reading, **unchecked**: disjoint translates of Croft's set into its lattice's deep holes give `m₂ > 2/5` and `m₃ > 3/5`, so `j = 2, 3` die as `j = 1` did; `j = 4` unknown (`m₄(ℝ²) < 4/5`?). [reading, R1; the advisor: "a check on Croft's parameters, not a derivation"]. The route to six, if any, is integrality (G24; X21D's B-3 answer: "a non-density (integrality) argument")."

**Kind of input**: a density of a union of `j` classes. Admissible, but § 2's row 129 caps single-class arguments.
**Read for it**: FS105-W-D1, -W-D2; FS106-EPS2, -COMP. **Verdict: null** (lane R; lane A holds row 129).

### J22 — A root: row 134's base, Lemma 4 at cusps
**The step**: (Poros's words, from the owed-minds lines of every route-M stub, e.g. `plans/STUB-qfree-ring.md` l. 101: "row 134's base, Lemma 4 at
  cusps (BASE-V), before any publication"): derive S–V's Lemma 4 at cusp vertices in the curved, almost-everywhere setting, or locate its failure.

**Kind of input**: a second mind on CUSP-BASE's D5 items at cusp vertices — a verification, not a composition. Admissible.
**Read for it**: FS110-CUSP-BASE, -CE1–CE7, -COR1-NOD2; FS112-N3-BASE, -N3-ANTI, -N3-FAIL; FS114-BV-HEX (BV-L3); `plans/BASE-V-verification.md` §§ 1b.5,
2.5.
**Verdict: null.** BASE-V § 2.5 names the residue that stays at one mind: "CUSP-BASE's D5 items 1–4, 6 (CE)" — Prop. 19(b) at cusps and Lemma 4's final
selection (BASE-V § 1b.5's blind GAP). No held lane-R result is a second route to them; FS110-CE4 and -CE6 are the repairs whose second mind is owed.

### J23 — A root: Townsend's simplification (c), in full
**The step**: (Poros's words, from `plans/STUB-regular-half-residuals.md` l. 7, "what is left is Townsend's (c) in full"): fill Townsend's (c) by a
  derivation, beyond FS106-TW's outline from Woodall's steps 2, 3, 5.

**Kind of input**: a modification that merges two non-adjacent same-colour regions at a vertex — (c) as `[Soifer2024]` ch. 25 reprints it
(`plans/FS110-PA-prior-art.md` stage 4) — or a five-colour map NO that needs no (c). Admissible.

**Read for it**: FS106-TW, -WO, -AE-MAP6; FS110-W-MERGE, -N3-DEG, -N4-SHAVE, -N4-STUCK, -N4-FIN, -N4-TERM, -NB4-CS; FS112-N2-RED, -N2-TERM, -N2-RAY;
FS114-N2-AVG, -N2-FIVE, -CV-EXISTS; `plans/STUB-regular-half-residuals.md` banners.

**Verdict: shortened, by two held results applied where they bear** (no new entry; both statements are held verbatim):
- **Under Condition 5, (c)'s outcome is held**: FS110-W-MERGE is Woodall's step 3 almost everywhere for curved arcs, and FS110-N4-TERM gives a terminal
  valid modification in which "no colour has two sectors at any vertex: every vertex is cubic" — the a.e. curved form of Woodall's steps 3 and 5, which
  V3 named as (c)'s fill. So for Condition-5 maps bounded by segments and circular arcs, AE-MAP6's "modulo (c)" is discharged by FS110-N4-TERM (row 134),
  leaving the rest of Townsend's Thm 5 at FS106-TW's grade. (Unchecked here: that N4's operations spend no sixth colour — NB2 records "six is spent nowhere"
  for FS-112's reduction, not for FS-110's N4.)
- **With unit arcs, in the simple non-Siamese class, no (c) is needed at all**: FS114-N2-AVG's N2-FIVE-PLANE, "no simple non-Siamese valid five-colour map
  of the plane exists" (one mind, by counting) — "maps need six" in that class, by Euler, with no merge.
- What remains of (c) in full: maps with unit arcs that are Siamese or non-simple (there FS112-N2-TERM's terminal map keeps stuck vertices, and N2-RAY's
  one-sided chain is the obstruction — FS-115 again), and map-type maps whose boundaries are not segments and arcs.

### J24 — FS-117: K2′, GAP-μ and COVER-3 (the non-Siamese NO only)
**The step**: (`plans/STUB-route-t-count.md` ll. 41–46): "- **K2′** — strictness: a unit unused in every disc of radius `R₀` (N3-DR1's and N3-DR2's forced non-tactic edges are the first candidate sources). - **GAP-μ** — repeated contacts: a pocket between two tiles meeting twice meets at most 65 tiles (Jung's `2/√3`, non-Siamese), a hole at most five; no payment rule. **And its hull form** (NB6-MTP): the mass-transport route (Kooshi's lead, `[AldousLyons2007]` Ex. 9.5, `[AngelHutchcroftNachmiasRay2018]` Thm 1) needs GAP-μ in the hull, because limits of simple hole-free maps can pinch or open holes — a pointer for FS-111's limit objects. - **COVER-3** (FS114-N2-ENC3): every colour meets `B̄(u, 1)` at every cubic vertex of a non-Siamese valid map — the local content of Sirgedas's"

**Kind of input**: a count (route T) — a unit unused per disc, a payment rule for repeated contacts, a covering of `B̄(u, 1)`. § 2's G86: a count is blind
to Siamese pairs, so the non-Siamese NO at best. Admissible within that.
**Read for it**: FS114-N2-ENDS, -N2-AVG, -N3-JOINT, -N3-DR, -N2-ENC3, -N2-LEMMAS, -ROUTE-T, -K1; FS129-OR1-QFREE.
**Verdict: null for the three named items.** Side note: route T's K1′ on (Q)-free rings has no instance (FS129-OR1-QFREE), so K1′ is owed only on (Q) rings.

### The mechanical half (`data/fs129/index/open-steps.md` §§ 2–4): how far I got

- **§ 2** (12 "stalls at" lines): read in full. Every lane-R line is a step on the list (FS114-GSD, -N7-3T's per-pattern kills, FS116-Y-SAT,
  -N1-F15TOUCH, FS107-HX-STALL, FS112's stuck-ray YES; row 133) or lane A's (FS38).
- **§ 3** (372 GAP lines): counted by file; read line by line for FS106, FS106-TS, FS106-TQ, FS107 and FS110 (about 66 lines), the oldest lane-R files and
  the least likely to be on the list. Two FS-110 GAPs are **leads for pass 2**: FS110-A3-HOLE ("A2-V56 and the four-colour Act One step hold when the
  vertex's unit circle carries no arc of `Γ` and are a GAP when it does") and FS110-N2-SWAP ("TRUE under Condition 5, GAP without") fail exactly where the
  unit circle carries an arc of `Γ` — what FS129-OR1-BEND3 and FS129-OR1-BENDFRAG remove on a whole-tile fragment below `√3` in the non-Siamese simple
  class. Whether their reading radius fits below `√3` is not checked. The rest of the lines read are steps on the list (AE-Q2's G1–G3, AE-FA, C-Q-STAB,
  TW, WO), superseded (SV1, AE-FA, by row 134) or closed in their own entries.
- **§ 4** (418 lowercase "gap" lines): counted by file, not read line by line; lane A finds at least 158 of them in the fan-gap sense (a property of a
  colouring, row 66), not open steps (`plans/FS129-OA1-audit.md` § 4.1 item 3). Lane R's share by file: FS111 23, FS121 15, FS116 14, FS106-TQ 7.

### The cross-era line (results of lane A's era seen bearing on a step; noted for lane A, not derived)

- **G71** (three colours have a height; Chandgotia) on J2 and J17: its lane-R image is FS-110's winding (FS110-N2-RING, -Y3-GP), and lane A's
  FS129-OA1-RINGWIND re-derives the same mechanism — a merge for pass 3 (stage 3, J2 addendum).
- **Row 66 / G13** (a gap frees every pair above it; fans) on J4: the finite face of an unsaturated class growing; not composed here.
- **G73** (`KG(4, 2)`, the `V₄` of `K₄`'s matchings) on J17 case 5: the recurrence's label algebra; lane A's.
- Nothing of lane A's era was seen bearing on J1, J3, J7, J10, J15, J19 or J23.
