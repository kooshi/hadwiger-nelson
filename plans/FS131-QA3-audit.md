# FS131-QA3 — the definitions audit: waves 4 and 5's definitions and source-restating clauses, each read against its source (de Bruijn, Opus)

*Brief: `data/fs131/briefs/FS131-QA3-definitions.md`. Read-only toward every `Proofs/` file, worktree and branch. Started 2026-10-04 22:29 UTC.*

## Theorems this phase proved

None. This is an audit: its results are findings (a definition or clause that says less, more, or other than its source), each with a
counterexample, and verdicts of fidelity.

## Stage 1 — SAVED

### 1.1 The brief's quotations (standing rule 3)

Each quotation in the brief checked against its source by reading the source lines:

| quotation | source | result |
|---|---|---|
| item 231's first line ("**FS131-I5 mid-job, a definition defect in KB's skeleton** (message 2026-10-04): `BaseCtx.retArcs_nested` … cannot be proved by any") | `plans/FS131-close-inventory.md` l. 1656 | verbatim (a truncated first line, marked as such by the brief's "each item continues there") |
| item 241's first line ("… **`cvb_hole_disconnected` is false as written**, because Lean's `IsHoleOf` is weaker") | same, l. 1725 | verbatim |
| item 251's first line ("… `Contact.lean` on `fs131-w4c` at `addcfbf3`, l. 4065): the clause") | same, l. 1797 | verbatim |
| item 255's first line (Kooshi's approval, *"That audit is approved, but no special slot. It must use one of the"*) | same, l. 1828 | verbatim; the sentence continues *"4, as we have no usage headroom for a fifth."* |
| the inhabitant rule ("inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a") | `LEAN.md` § The gate | verbatim |

No mismatch. The "known and ruled" items (142, 158, 213/227, 231/232, 241/242, 251/252) were read in full (l. 866, 1045, 1503, 1629,
1656–1663, 1725–1733, 1797–1807), and items 256–265 for the current state (item 258: `pair_i` gains `h3 : dist u₁ u₂ < 3`; item 263: the
second move into `Cone`).

### 1.2 The code read, and its revisions

Read by `git show <branch>:<path>` at these heads (2026-10-04 22:29 UTC); a later commit on a branch is outside this audit unless named:

| branch | head | modules audited |
|---|---|---|
| `fs131-w5` | `0db34854` | `Plane/ValidMap/Chain`, `Terminal`, `Dense`, `HexRing`, `MapGraph`, `BaseWalk`, `BaseDense` |
| `fs131-w4` | `d391f480` | `Plane/ValidMap/Basic`, `Sectors`, `UnitArc`, `BaseSteps`, `Plane/SVMap`, `Plane/StuckChain` |
| `fs131-w4c` | `9988cbb8` | `Plane/ValidMap/Contact` |
| `fs131-w4m` | `aee53d57` | `Plane/ValidMap/Moves`, `Cone` |

Wave 5 carries older copies of wave 4's modules (`Basic` 690 lines against `fs131-w4`'s 802; the difference is 112 added lines on
`fs131-w4`, no change to a definition read here). Wave 4's definitions are read on `fs131-w4`.

### 1.3 The census instrument

`tools/fs131_qa3_census.py` (imports FS131-QA1's parser read-only): `list` prints every definition and theorem of the audited modules
from the git refs; `check <tsv>` confirms a committed census still names declarations at their refs. Self-test: 4 controls OK; planted
fault (structures dropped from the kinds) **fired** ("missed Bar", exit 1). Output `data/fs131/qa3/census-raw.tsv`: **208 definitions
and constructions, 802 theorems** across 16 modules, no module missing.

Of the 208 definitions, the ones that are **predicates or vocabulary a source defines** (the audit's object) number about 100; the rest
are **constructions** (`bowtie*`, `sevenBrick*`, `holed*`, `cusp*`, `halfDisc*`, `l60*`, `iso*`, `brickCorner*`, `rayParam`, `reul`),
whose fidelity matters only as models and which are sampled, not censused. The clauses audited are those of the **row statements and
supporting lemmas** (the theorems whose docstrings name a row or a source step), not the children an implementer added.

### 1.4 The method, per item

For each definition: (1) find the source sentence that defines the term (the derivation the docstring cites, else the row, else the
planner's read-back); (2) quote it; (3) try to build **an instance the Lean admits and the source excludes** (too weak), **one the source
admits and the Lean excludes, or no non-degenerate instance at all** (too strong), or **an idiom change** (pointwise for directional,
set-level for pathwise, closure-level for boundary, `∀ᶠ r` for "near", `encard` for "number"); (4) a verdict: MATCH, MATCH-WITH-READING
(a reading the planner recorded, which I check is harmless for the consumers), or FINDING. Order: wave 5's definitions that most
statements rest on first (`Chain`, then `Terminal`, `HexRing`, `BaseWalk`, `MapGraph`), then wave 5's row clauses, then wave 4's
`Basic` (which everything rests on), `BaseSteps`, `UnitArc`, `Sectors`, `SVMap`, `StuckChain`, `Contact`, `Cone`, `Moves`.

## Stage 2 — SAVED: wave 5 (`fs131-w5` at `0db34854`)

### 2.1 The definitions, each against its source

Verdicts: **M** match; **M-R** match with a reading the planner recorded (checked harmless for every consumer); **M-W** the Lean is weaker
(says less) where it sits in a conclusion, or stronger where it sits in a hypothesis — safe; **F** finding; **K** known and ruled (not
re-reported). "Adversary" is the instance I tried; "none" means none exists, by the reason given.

| definition (module l.) | source sentence (address) | adversary tried | verdict |
|---|---|---|---|
| `StuckAlong v α` (Chain 50) | N4 frame: a stuck vertex, its two-sector colour's horns along `±a` (`plans/FS110-N-proof.md` § 2.4 (i)) | a stuck vertex whose two-sector colour has no horn along `e α`: excluded by the clause; a ≥ 4-colour stuck vertex: admitted, but its run is empty (not a chain vertex) | M |
| `IsChainVertex v` (Chain 54) | "stuck" in N2-TERM's trichotomy; the chain runs "until it meets … an NB4′ exception" (`plans/FS112-N-proof.md` l. 476–478) | a stuck vertex of ≥ 4 colours continuing a run: excluded (matches "NB4′ ends the chain"); a stuck ≤ 3-colour neighbour along another axis continuing the run: admitted, but N4-PROP forces the axis `±α` in a terminal map (plan § 9.1's child `stuckAlong_of_run`; FS110 § 2.5's proof at `N`; with unit arcs the exceptions all carry ≥ 4 colours, FS112 l. 476) | M-R (R-CHAIN) |
| `stuckRun v α` (Chain 58) | "every stuck vertex lies on a stuck chain along its normal line; the chain is not bi-infinite" (N2-TERM item 3, l. 495) | none: a convex set of integers containing `0` exactly when `v` is a chain vertex (proved: `zero_mem_stuckRun_iff`, `mem_stuckRun_of_between`) | M |
| `fourSet`, `repSet` (Chain 62, 65) | "`F(M)`: the vertices of at least four colours; `R(M)`: the vertices carrying a repeated colour" (`plans/FS112-derivation.md` l. 14) | a phantom arc (one colour on both sides) makes its points repeated-colour points — the source's WLOG ("every arc separates two different colours", FS110 § N4-2 setting) is not in `ArcMap`; in hypotheses (`BaseHyp`) this only strengthens, in conclusions (`localDense`, `dense3`) a phantom point satisfies the conclusion trivially, and every consumer applies it to a map it can clean (or a terminal map, where a phantom point has MERGE available) | M (note 2.4 a) |
| `QROnly` (Chain 71) | "every unit arc is (Q) (both side colours at its centre, ≥ 4 colours there, the two side cones covered by distinct other colours) or (R2)" (N2-TERM item 1, l. 492) | a constant-sided unit arc whose side cones are not covered by distinct colours: admitted by `IsQArc`, excluded by the source; derivable in a terminal map (no MERGE: l. 437); in hypotheses (`IsTerminalMap`) the consumers never read the side-cone clause | M-W |
| `IsTerminalMap` (Chain 76) | "`M*` is a terminal valid modification" — no MERGE, MERGE-RAY, SHAVE or bend (`plans/FS114-CV-verification.md` § 1.3) | — | M-R (R-CDOUBLE) |
| `IsModification M` (Chain 80) | "a valid modification by W-MERGE and whole-arc bends, creating no unit arc" (FS112-N2-RED); consumers read "keeps a four-colour vertex's colours" (FS114-CV-EXISTS) | **any valid map on the same domain with no unit arc and no four-colour point** is a modification of every map — so `exists_red` is provable at `k ≥ 7` by `sevenBrickMap`, whatever `F` is (the planner's recorded adversary, § 2.2) | M-R (R-MOD; note 2.4 b) |
| `BaseHyp u` (Chain 92) | "the closed disc of radius 2 about … `u` holds no vertex of at least four colours and none with a repeated colour" (FS112-N3-BASE, l. 171) | none (on a fragment covering `B̄(u, 2)` every point is in the domain) | M |
| `NoInertNear u` (Chain 96) | "inert unit arcs centred within 1 of `u` first bent toward their centres" (FS112-N3-BASE) | a phantom unit arc of a colour absent at its centre counts as inert: hypothesis only strengthened; the pre-bend deletes it | M |
| `UnenclosedC`, `Unenclosed` (Chain 101, 106) | E4's words (`plans/FS131-E4-derivation.md` l. 166–168) and its drafted Lean (§ 5.2, l. 431–438) | none: verbatim; E4-RIM step 3 reads exactly "a point of `S` in a bounded component of `ℂ ∖ cl R°`" | M |
| `Row134BaseUA` (Chain 121) | E4 § 5.2's draft (l. 440–444) over FS112-N3-BASE | none: verbatim; radius 2 kept (item 227: "no radius change") | M |
| `OnQR2Arc`, `HornBoundsQR` (Terminal 31, 37) | "each end … within distance 1 of a (Q) or (R2) arc or an NB4′ exception, and every horn bound `±1` on it is a (Q) or (R2) arc" (N2-TERM item 3) | the arc of `ω(w + n)` from angle `β − π/2` counter-clockwise starts at `w` on the `+e β` side (checked at `β = 0`: `i + e(−π/2 + t) = sin t + i(1 − cos t)`), and the lower one's clockwise end likewise (`sin t + i(cos t − 1)`): the horn's own bounding arcs | M |
| `GermPseudo` (HexRing 47) | CB's pseudo-colour on a germ of `ω(u)` (`plans/BASE-V-verification.md` § 1a.4) | a germ along an arc with both sides absent at `u` (pseudo-colour of two elements): no singleton, so excluded — that arc is inert, excluded by `NoInertNear` wherever the walk reads it | M |
| `HexRing` (HexRing 54) | "`c′(x_k) = {a_k, a_k + 1}` … the arc just before `x_k` has colour `a_k` and just after has `a_k + 1`" (BASE-V § 1a.4, l. 117–120) | the opposite orientation (`a_{k+1} = a_k − 1`): any period-3 sequence of three distinct colours is `b` of an injective `b : ZMod 3 → Fin k`, so both orientations are in | M |
| `RingProper` (HexRing 62) | "finite proper circle colourings … (i) no two monochromatic points at distance 1 share a colour; (ii) no two bichromatic points at distance 1 share a pair" (BASE-V l. 54–55, § 1b.3) | change points read by tile colours, not pseudo-colours: off `Γ` a germ of `ω(u)` lies in a tile of a colour absent at `u` (a tile of a colour of `u` meeting `ω(u)` gives a unit pair against `u`'s sector), so the two agree; same-pair same-sense pairs are excluded by validity, so (ii) as an unordered-pair condition is exactly the print's | M |
| `DoubleEvent` (HexRing 72) | "a double event is `(x₀, y₀) ∈ Φ` at which, as the linkage moves, `f₁` switches `α → β` at `x₀` and `f₂` switches `β → α` at `y₀`"; `μ = e·λ₁τ₁ = e·λ₂τ₂` (BASE-V § 1b.2) | the case `μ < 0`: reversing the motion swaps `α, β`, so "both components positive" with `α, β` free covers both signs; `μ = 0` is excluded by the positivity (BV-ND step 1's content) | M |
| `BaseCtx` (BaseWalk 43) | `Row134BaseUA`'s hypotheses | none: field for field | M |
| `VIn` (BaseWalk 58) | "Call `z` **V-in** if its `i`-region meets `B(u, 1)`" for a vertex `z ∈ ω(u)` with `c(z) = {a, c, i}` (`plans/FS110-CD-verification.md` l. 170) | a V-in point with more or fewer than three colours: admitted by `VIn`, but every use pairs it with `ncard = 3` (`IsEndpoint`) or with a refutation that reads only the `i`-tile (`vin_antipodal`, `eleventh_antipodal`) | M-W |
| `IsEndpoint` (BaseWalk 63) | Lemma E: the continuation's endpoint, "in `B(u, 1)`, or … a V-in vertex on `ω(u)`. Its multicolour is `{a, c, i}`" (CD l. 194–196) | a three-colour point in the closures of the two tiles but not the end of the continuation (path-free): admitted; it sits only in `exists_endpoint`'s conclusion, and the count reads only "in the closures of `x`'s `a`- and `c`-tiles" (`endpoint_dist_ge`) and the type (its third colour in `P_cl(u)` follows from `cor3_base`) | M-W |
| `IsRetArc` (BaseWalk 73) | CD Lemma R (l. 200) | after items 231–232's `K`: within `B̄(u, 2)` under H the common boundary of one `a`-tile and one `c`-tile is a disjoint union of paths (a branch would be a repeated colour), so a continuum `K ∋ r(s), r(t)` inside it and the closed disc is the continuation from `r(s)` — CD's returning pair; CD's step 1 gives `t − s < 60°` | K (repaired form checked: M) |
| `Removable`, `ChangeWith`, `IsHex` (BaseWalk 86, 91, 96) | CD Lemma R steps 2–3 (l. 202–210); BV-C6 | none | M |
| `LocallyHamiltonian` (MapGraph 41) | "`G` is locally Hamiltonian if, for each `x` in `V(G)`, `G` has a cycle with vertex set `D₁(x)`" (`[Thomassen1999]` p. 850, library txt l. 70) | a vertex of degree 1 or 2: no cycle (Mathlib's `IsCycle` has length ≥ 3, as Thomassen's cycles do) | M |
| `offTwo`, `twoSepInterior`, `IsTwoSep`, `IsMaximalTwoSep`, `reducedVerts`, `reduced` (MapGraph 45–63) | CVB B2 step 2: "in the plane take `int(M, x, y)` to be their union [the finite components of `M − x − y`], and no curve `R` is needed"; Thomassen p. 852 ("If no such 2-separator `{u, v}` exists, then we say that `{x, y}` is a maximal 2-separator"; "`H` … obtained by deleting `int(M, x, y)` for each maximal 2-separator") | none | M |
| `triLattice` (MapGraph 446) | a model (Lemma 1's hypotheses) | — | construction |
| `mapGraph` (MapGraph 560) | "`M`: tiles, adjacent when their closures meet" (CVB § 1.9 frame) | none | M |
| `IsHoleOf` (MapGraph 567) | — | — | K (items 241–242) |
| `fill`, `IsOuterTile`, `filledGraph` (MapGraph 573–580) | "Replace each tile `x` by `x̂ = x ∪` its holes …; its map graph is `M` minus the hole contents" (CVB B2 step 1) | `fill T` omits the curve between `T` and a hole (so it is not the open filled tile), but `filledGraph` reads only `closure (fill T)`, which is right; all three inherit `IsHoleOf`'s defect | M (inherits K) |
| `Side.flip` (HexRing 31) | — | — | M |

**Count: 41 definitions read; 38 match (M, M-R, M-W), 1 construction, 2 known (`IsRetArc`, `IsHoleOf`). No new definition defect in wave 5.**

### 2.2 The statement clauses that restate a source in a Lean idiom

| statement (module l.) | clause and idiom | source | adversary | verdict |
|---|---|---|---|---|
| `exists_terminal` (Terminal 87) | clause 3's ends: "∃ z within 1 of the end vertex on a (Q)/(R2) arc or of ≥ 4 colours" (point-level for "within distance 1 of an arc") | N2-TERM item 3; N2-4 "until it meets a point that is a (Q) or (R2) centre or an NB4′ exception, within distance 1 of a unit arc" | the source's end lies on the arc (distance 0) or its next point centres it; the Lean form is implied by either reading | M-W |
| `cv_hd`, `cv_hd_main`, `y3_end_needs`, `c_double`, `n3_end_chain` | `G_N` as `IsContact ∧ InType` (a ∀ over the `g`-tiles at `N`) | CV § 1.3: "**`G_N`**: a `g`-tile with `N` in its closure lying in `B̄(E, 1)`" (∃) | a contact with one inside tile and one outside: impossible in a valid map (N3-CONF, "both types at one point are impossible"; `contact_inType_or_outType`); so ∀ and ∃ agree given the contact | M |
| same | `υ± = 1` as `κ₂ = 1 ∧ κ₃ = −1`, `λ± = −1` as `κ₁ = −1 ∧ κ₄ = 1` | CV § 1.3 | the `−e α` horn's frame is rotated by `π`, so its arc on `ω(N)` is its *lower* arc with curvature `−1` (checked: `n' = −n`, `N = v − n'`) | M |
| `cv_class` (Terminal 164) | case (II) omits "`¬G_N` and `¬H_S`" | CV-CLASS (II): "`¬G_N` and `¬H_S`, and then …" | weaker conclusion; a consumer wanting `¬G_N` in case (II) gets it from `cv_hd` | M-W (note 2.4 c) |
| `c_double` (Terminal 208) | "both are (Q) centres" read as "the four horn-bounding arcs are (Q)" | C-DOUBLE; CVB § 1.6 "Hence" | stronger, but derived: each arc's two side colours are at its centre, so not (R2), so (Q) by `QROnly` | M |
| `rot_out`, `rot_in` (HexRing 195, 209) | "`g` fills the outward cone `(−30°, 30°)`" as "every interior point near `x` outside both `B̄(σx, 1)` and `B̄(σ⁻¹x, 1)` has colour `g`" (pointwise on the curvilinear region) | N2-ROT (`plans/FS110-N-proof.md` l. 374–380) | the curvilinear region is wider than the angular cone (slivers between the tangent rays at `±30°` and the two circles); there no `p` (it lies in `B̄(σ⁻¹x, 1)`, (A−)), no `q` (in `B̄(σx, 1)`, (A+)) and no `r`, so the colour is the cubic `x`'s third colour `g` — the clause is true as stated; inward cone likewise with the open discs | M |
| `rot_out`, `rot_in`, `hex_regular` | "`u`'s `g`-sector lies in the closed half-plane away from `x`" as a condition on `coneAt (region g) u` (tangent-cone level) | N2-ROT; N2-HEX's count reads only angles ("a sector of angle `α` centred at `β` fits away from `x_k` iff …"); BV-HEX step 5 reads the closed tangent cone | the cone-level form is weaker than "the sector lies in the half-plane" (a sector may cross at second order) and is exactly what both counts read | M |
| `hex_regular` (HexRing 228) | the double-cusp disjunct | N2-HEX | the planner's F-HEXCUSP (plan § 8.4, filed) | K |
| `linkage_dot_ne_zero` (HexRing 276) | conclusion `dot₁ ≠ 0 ∨ dot₂ ≠ 0`; the docstring says "**both** points move with non-zero component along `e`" | BV-ND step 1: "`μ ≠ 0`" with `μ = e·λ₁τ₁ = e·λ₂τ₂` | `x₀ = u₁ + e(arg(x₀ − u₁))` with `u₁, x₀, y₀` collinear, `|u₁ − y₀| = 2` (the ends of BV-L3's arc `Y`): `dot₁ = 0`, `dot₂ ≠ 0` — the disjunction is all that holds; "both" needs the switch to be a passage (`λ₁, λ₂ ≠ 0`), which BV-ND states separately | M-W (note 2.4 d: docstring overstates) |
| `bv_nd`, `bv_nd1`, `bv_hex`, `bv_l3`, `p17_ua` | H read at the event points / six points / both circles | BASE-V §§ 1a.4, 1b.2–1b.3 | each uses H only where the source's step 3 / adjacency reads it (BASE-V: "H is used here, and only here") | M (planner's G-BVHEX, G-BVND, N-BVL3) |
| `exists_endpoint` (BaseWalk 190) | hypothesis `hc : ccw c ∨ (cw c ∧ ccw a)` beside `ha : cw a` | Lemma E for a change point with pair `{a, c}` | the second disjunct contradicts `ha` and `a ≠ c` (the cw germ cannot be pseudo-coloured `{a}` and `{c}`), so it is dead; the reversed orientation is still covered by swapping `a, c` (`IsEndpoint` is symmetric) | M (note 2.4 e) |
| `exists_eleventh`, `vin_antipodal`, `eleventh_antipodal`, `cor3_base` | E4-RIM's statement; CD Theorem D2 (i), (ii) | E4 l. 172–175; CD l. 266–278 | `vin_antipodal` reads one colour `i` at both points (CD's Lemma H(b) runs through `u`'s `i`-sector, `S_i ⊆ B̄(p, 1) ∩ B̄(p′, 1) = {u}`) ✓; `eleventh_antipodal`'s disjointness forces `p`'s V-in colour to be `u`'s third ✓ | M |
| `cvb_thom_reduced`, `cvb_thom`, `lemma1` | Thomassen's "`H` connected, locally connected, locally Hamiltonian", "at most 12 vertices"; CVB B2 step 3 ("each contradiction … becomes 'M is finite'") | — | `Infinite (reducedVerts …)` is CVB's replacement of the diameter bound | M |
| `cvb_pinch_connected` (MapGraph 638) | "no hole" as `∀ Hc, ¬ IsHoleOf T Hc` | B1 | true as written (I5b, item 241), because Lean's `IsHoleOf` holds at least wherever CVB has a hole; **constraint for item 242's repair**: if the repaired `IsHoleOf` ever fails at a CVB hole (for instance a cluster of bounded components touching one another but not the outer one, I5b's repair), this statement becomes false — the tile has a CVB hole and `M − x` is disconnected | M (note 2.4 f) |
| `disc1_local` (Dense 47) | three colours (TS-T's form) on a fragment | FS112-DISC1 (degree ≥ 3); FS106-TS-T (plane maps) | TS-T's Lebesgue argument is local to the square inside `B̄(x, 1/√2 + ε)`, and the closures of the same-colour clusters (diameter ≤ 1 by validity) are its closed sets, so the fragment form holds; no consumer since E4 (`localDense` reads `exists_unenclosed_or_bad`) | M (orphan) |

### 2.3 What else was read

`zero_mem_stuckRun_iff`, `mem_stuckRun_add_pi`, `IsModification.refl/trans`, `stuck_structure_ua` (its sides clause is items 251–252's,
still unapplied on `fs131-w5`, owed by wave 5's next implementer — known), `flankQ_*_of_qrOnly`, `cv_l0`, `c_ends`, `cor3`, `disc1ts`,
`not_row134BaseUA_seven`, `exists_preBend`, `n3_base`, `exists_unenclosed_or_bad`, `localDense`, `dense3`, `cv_exists`, `reduce`, `select`,
the BaseWalk A-leaves, `exists_holed_valid_fragment`: each statement matches its row or the planner's read-back (plan §§ 3.2, 8.2) with the
readings recorded there.

### 2.4 Notes (none is a defect; each is a precision a later job may want)

a. **Phantom arcs.** `ArcMap` does not carry the source's WLOG "every arc separates two different colours". A phantom arc makes its points
   repeated-colour points and can count as inert or as a horn bound; I found no statement of waves 4–5 that this makes false — in every
   hypothesis it strengthens, and every conclusion it weakens is applied to a map that can be cleaned or is terminal (a phantom point in a
   terminal map would have MERGE available: a colour of two sectors with no contacts forcing a degenerate cone). A named predicate
   `F.Clean` (every arc of `Γ` has different colours on its two sides) would let a future statement say it outright.
b. **`IsModification`** makes `exists_red` true at `k ≥ 7` for a reason unrelated to `F` (`sevenBrickMap` is a modification of every
   valid plane map). The planner recorded this adversary; its consequence is only that the "widened to every `k`" in plan § 3.2's read-back of
   FS112-N2-RED is empty above six colours. At six it carries the content.
c. **`cv_class` (II)** could carry "`¬G_N ∧ ¬H_S`" as the row does; nothing reads it today.
d. **`linkage_dot_ne_zero`'s docstring** should read "at least one of the two points moves with non-zero component along `e`; at a switch of
   both colours (no turning point, `λ₁, λ₂ ≠ 0`) the two components are equal, so both are non-zero". The implementer of `bv_l3` / `l3_base`
   needs the turning-point step; the statement is right.
e. **`exists_endpoint`'s `hc`** has a dead disjunct; harmless.
f. **For item 242's design question** (the planar job): `cvb_pinch_connected` stays true only if the repaired `IsHoleOf` holds at every CVB
   hole (a boundary component disjoint from the outer one), clusters included; `cvb_hole_disconnected` is true only if it holds nowhere else.
   Both directions bind the repair.
