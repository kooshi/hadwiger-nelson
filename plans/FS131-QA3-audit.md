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

## Stage 3 — SAVED: wave 4 (`fs131-w4` at `d391f480`; `Contact` read at `fs131-w4c`'s `f975677b`, IC5's hand-back; `Moves`, `Cone` at `fs131-w4m`'s `fe10562b`, IM2's stage 5)

### 3.1 The finding

**QA3-1. `exists_merge` (FS110-W-MERGE) is false as stated** — sent to Keryx at once (message of 2026-10-04). Its clause
`(∀ x ∉ sphere v ρ, F'.coloursAt x ⊆ F.coloursAt x)` (`Contact.lean` l. 4097 on `fs131-w4` and `fs131-w4c`, l. 1482 on `fs131-w4m`; the copy
`exists_merge_aux`, `Moves.lean` l. 265 on `fs131-w4m`) quantifies over the open disc `B(v, ρ)`, where the merge recolours the gap.

*The argument (exact, by reading).* Let F's `c`-sectors at `v` have closures meeting only at `v` (true whenever no arc of `Γ` through `v` has
`c` on both sides). Suppose `F'` agrees with `F` off `B̄(v, ρ)` and meets the clause. At a point interior to both maps, `coloursAt` is the
singleton of the colour, so the clause forces `F'`'s colour to be `F`'s; on `F`'s arcs it forces `F'`'s colour into `F.coloursAt`. Hence
`F'.region c ∩ B(v, r) ⊆ ⋃ᵢ cl Sᵢ` (the `Sᵢ` F's `c`-sectors). `v` is not `F'`-interior (a neighbourhood of `v` would meet a sector of another
colour, coloured that colour in `F'` too). A connected component of `F'`'s interior points of colour `c` near `v` lies in `(⋃ cl Sᵢ) ∖ {v}`,
a disjoint union of the relatively closed `cl Sᵢ ∖ {v}`, so in one of them; and each `Sᵢ` contributes one (its `F'`-interior points keep colour
`c`). So `F'` has at least `n + 1` sectors of colour `c` at `v`, and `F'.HasSectors v c n` fails. The conclusion is unsatisfiable.

*An instance of the hypotheses* (so the theorem is false, at any `k` large enough): `dom = B(0, 2)`, `v = 0`; inside `B(0, 1/4)` an X of two
segments, open quadrants I and III of colour `0`, II and IV of colours `1` and `2`; the annulus `1/4 < |z| < 2` cut by a grid of side `1/4`,
every cell its own colour. Valid (the only repeated colour is `0`, on two quadrants within `1/2` of each other; every tile has diameter below
`1`); `Covers 0 1`; `HasSectors 0 0 2`; no point of colour `0` within `1/4` of `0` has a point of `ω(0)` in its closure, so `allowedCone 0 0 =
univ` and `hD` holds with `n = 1`.

*Source.* FS110-W-MERGE (`plans/FS110-N-proof.md` l. 528): "the result is a full a.e.-proper colouring …, **types only shrink**, new vertices are
cubic with distinct colours, and no other vertex's `D_c` changes" — types are vertices' multicolours; inside the disc the only vertex is `v`
(`ρ` below the distance to every other vertex, § 2.7's clearance).

*Fix.* `F'.coloursAt v ⊆ F.coloursAt v` in place of the clause — the form `exists_shave` and `exists_rayMerge` already state; off the closed
disc the inclusion is `AgreesOff`'s, and the rim is the next clause's. **Who:** the moves' implementer (FS131-IM2, `fs131-w4m`) in both copies
under a ruling, re-running `tools/fs131_im_statements.py`. Nothing proved reads the clause (grep across the five branches). Rank: high — it
sits on the moves lane, wave 4's longest path, and wave 5's `exists_red`/`exists_terminal` compose the moves.

The other clauses of `exists_merge`, checked: the rim clause (new rim points are corners or cubic with distinct colours: the merged `c`-region
and an old sector, or the merged region and the two sides of an old arc — at most three colours, none repeated) holds; the `D_c` clause
(`∀ v' ∉ B̄(v, ρ), allowedCone` unchanged) holds for `ρ` chosen off the finitely many `|v′ − v| − 1` at vertices `v′` whose `c`-sector lies in an
angle below `π` (at any other point a new contact on the rim would make a gap point unclear, against the merge's clearness).

### 3.2 The definitions, each against its source

| definition | source | adversary tried | verdict |
|---|---|---|---|
| `frameX`, `frameY`, `framePt`, `tanHeight`, `TanAbove`, `TanBelow`, `curvDown`, `curvUp`, `dot` (Basic 38–72) | FS110 N4-2's frame and curvature bookkeeping (`f(λ) = λ/(1 + λ)`, `f̃(υ) = υ/(1 − υ)`) | spec examples at `α = 0` (Basic l. 609–632) | M |
| `hornSet` (Basic 59) | "the rows' `{κ₁x²/2 < y < κ₂x²/2, x > 0}`, exactly" | the exact circle form in place of the second-order one: every boundary arc is a circle or a line, so it is exact | M |
| `shadow` (Basic 76) | "`Sh(T) = {z : ω(z) ∩ T ≠ ∅}`" (FS110 N4-2) | none | M |
| `IsClear` (Basic 83) | "`z` may be recoloured `c`" | none | M |
| `IsSector`, `sectorsOf`, `HasSectors`, `HasDegree`, `HasRepeatedColour`, `IsCubicTrichromatic` (Basic 89–105) | `s_c(v)`, the number of `c`-sectors (FS110 N4-2 setting); "cubic trichromatic": three colours, one sector each | a pinched tile (one tile, two sectors at `v`): counted as a repeated colour, as `s_c(v) ≥ 2` reads it; infinitely many sectors: impossible (local finiteness); a phantom arc: see 2.4 a | M |
| `IsHorn`, `IsFlankAbove`, `IsFlankBelow` (Basic 109–117) | "`c` has a horn `H` along `+a` at `v`, between arcs of upward curvatures `κ₋ < κ₊`; the tile directly above `H` has colour `g`, directly below `h`" (N4-FLANK's setting) | a flank colour equal to `c`: admitted (the bounding arc is then a phantom arc); in `ShaveAvailable` this makes a shave available trivially, which only strengthens `IsStuck` and `Terminal` (2.4 a), and IM1 found the cases `g = c`, `h = c` provable in `exists_shave` | M |
| `IsContact`, `InType`, `OutType`, `allowedCone` (Basic 124–137) | N3-CONF: "`w ∈ cl(C_c°) ∩ ω(v)`"; `D_c(v) = ⋂_in {d·e_w ≥ 0} ∩ ⋂_out {d·e_w ≤ 0}` | a contact with tiles of both types: impossible in a valid map (`contact_inType_or_outType`); contact arcs: every point of the arc is a contact, as the source's intersection reads | M |
| `MergeAvailable`, `RayAvailable`, `ShaveAvailable`, `DoublyShadowed`, `TerminalOn`, `Terminal`, `IsStuck` (Basic 143–174) | W-MERGE's "if `int D_c(v) ≠ ∅`"; N4-RAY's "two `c`-horns along `+a`"; N4-SHAVE; N4-STUCK's hypothesis | MERGE-RAY at unit-arc bounds: the middle region's arcs lie strictly inside `(−1, 1)` (FS112-N-proof row 7, W3), so the precondition is the move's; SHAVE semantic (planner's § 2.2 choice, carries N4-FLANK into `shaveAvailable_of_not_doublyShadowed`) | M |
| `InContact`, `OutContact`, `BothKind`, `Inert` (Basic 179–190) | `data/fs112/claims.md` § 0: "in-contact — `s_in ∈ P_cl(P)`; out-contact — `s_out ∈ P_cl(P)`; both; inert — neither" (in- and out- not exclusive) | none | M |
| `radiusTwoArc`, `IsR2Arc` (Basic 193, 197) | "(R2): `P` carries the outer side colour, not the inner, and an inner-colour tile runs along the radius-2 circle about `P` over all of `α`" (`plans/FS112-N-proof.md` l. 243–245) | several inner-colour tiles covering `R₂(ᾱ)` in closure in place of one tile "along" it: admitted; the consumers read only that the far antipode is in the inner colour's closure with out-type tiles (`flankQ_upper`) and that the centre lacks the inner colour (`c_double`) | M-W |
| `Condition5`, `Condition6` (Basic 205, 210) | S–V's words, read on arcs | presentation dependence (QA1's D5) | M (known D5) |
| **`InMK`** (Basic 214) | "`𝓜_K`: … at most `K` circular or straight arcs per tile, arc radii at least `1/K`, at most `K` tiles per unit disc" (`plans/FS107-derivation.md` l. 11) | a periodic design with `K` tiles per unit disc each of `K` arcs: in `𝓜_K`, but has up to about `K²` arcs meeting a unit disc, so not `InMK K`; conversely `InMK K` bounds tiles per unit disc only by the arrangement count | **F (minor, QA3-2)**: the class is `𝓜_K` up to `K ↦ O(K²)`; no theorem uses it (one spec example) |
| `AgreesOff`, `RingArcsWithin`, `IsCoveringPair` (Basic 223–233) | "no unit arc created" (FS112-WALK); covering pair in the union sense (FS110 § 9 item 1) | none | M |
| `pseudoColours`, `IsLeavingCentre`, `leavingInner`, `leavingOuter` (BaseSteps 37–49) | S–V Def. 7; "the centre of a unit arc with endpoint `u`" | a unit arc of `ω(q)` through `u` (not ending there): its sub-arc ending at `u` makes `q` a leaving centre — the planar-graph sense (an edge through a vertex is two edges ending there) | M |
| `StripHolds` (BaseSteps 53) | CB D2: "every tile point of `N_e` strictly on side `σ_e` of `Ω` has colour in `{1,2,3}`" (`plans/FS110-CB-verification.md` l. 107–109) | none | M |
| `MIn` (BaseSteps 58) | CE's AL: "some tile of a colour in `M` has `x` in its closure and has interior points strictly inside `Ω` arbitrarily close to `x`" (`plans/FS110-CE-verification.md` l. 179–180) | the class form: local finiteness puts one tile at `x` | M |
| `multicolour`, `AeProperRegions`, `closedSquare`, `IsRegion` (SVMap 417–494) | D-VMC, D-AEMAP region-only | overlapping classes allowed (not in the source): only widens, and TS-T is proved over it | M-W |
| `r2Contacts` (UnitArc 2639) | "`C₂(ᾱ)`" (N2-TAN) | none | M |
| `reul` (UnitArc 1040) | "`Reul(P, A, B)`" (L60 audit) | none | M |
| `rayParam`, `rayPt`, `farSideAbove`, `farSideBelow`, `germArc`, `rayLower` | geometric helpers; `germArc`'s carrier proved | — | M |
| constructions (`bowtie*`, `sevenBrick*`, `brickCorner*`, `cusp*`, `halfDisc*`, `l60*`, `iso*`) | models | QA2 § 3.1 (satisfiability), YB3's exact fragment for the bowtie | sampled, not censused |

**Count: 58 definitions read (constructions apart); 56 match; 1 minor finding (`InMK`); `Condition5`'s known D5.**

### 3.3 The statement clauses that restate a source in a Lean idiom (beyond QA2's stage 4)

QA2 read wave 4's 29 skeleton rows against their statements at `f1f26a8a` (15 same, 8 stronger, 6 weaker, all filed). I re-read them for idiom
changes, and the statements added since (`Contact`'s and `Moves`'s moves, `stuck_structure` as proved):

| statement | idiom | verdict |
|---|---|---|
| `exists_merge`, `exists_merge_aux` | "types only shrink" as a pointwise inclusion over every point off the rim | **F (QA3-1)** |
| `exists_shave`, `exists_rayMerge` (and `_aux`) | "no colour is added at `v`" as `F'.coloursAt v ⊆ F.coloursAt v`; rim clause; `HasSectors v c n` | M |
| `bend_toward`, `bend_away`, `bend_away_whole` | "bends" as "removed as an arc of `ω(P)`"; only `c′` (resp. `c`) gains points, inside (resp. outside) the unit disc near the arc | M (the lens near an end may hold a third colour, which only loses points; allowed) |
| `stuck_structure` (proved, `f975677b`) | the sides clause in items 251–252's form (b); (iv) omits "every tile at `N` meeting `B̄(v, 1)` has colour `r`" and the tangency of `h`'s two sectors | M (K for the sides clause); the omissions only weaken |
| `stuck_chain` | N4-PROP's "as in N4-STUCK with cone colour `a_k`" read as `IsStuck` | M-W |
| `woodallCone` | "every `c`-sector is a cusp horn" as "every sector at radius `r` equals some `hornSet … r`", curvatures inside the `∀ r` | M (the curvatures are fixed by `S` for small `r`: shrinking `r` restricts a horn set to a horn set) |
| `flank_shadows`, `shadow_farSide_*` | N4-FLANK's "below the circle of largest curvature `σ_g`" as an iff on the horn near `v`; "an absent shadow is `σ_g = κ₁`" | M |
| `lock` | "touches … from outside `B(P, 2)`" as "near `P + 2e(θ)` the tile misses `B(P, 2)`" | M |
| `n2_sign` | "every point `≠ P` of a side-colour tile" as every point of the side colour's class (interior points) | M (`P` is never an interior point of a side colour in a valid map: its unit circle holds the arc's interior) |
| `l60_eq_third` | "each end is a vertex carrying a third tile" as "a tile with a cone direction strictly in the open half-plane facing away from the other end" | M (the inner and outer tiles' cones fill exactly the closed facing half-plane, `l60_eq_corners`) |
| `a4six` | "total length at least 60°" with `arcLength = volume` restricted to `[0, 2π)` | M (the restriction makes the periodic angle set's measure the arc length) |
| `nb4p` | "in the closure of an arc" as `OnRingArc` (closed arcs) | M (`Γ` is closed in the domain) |
| `pair_i` | `h3 : dist u₁ u₂ < 3` (ruling 258) | K |
| `fail_colours` | "exactly" as "only" | M-R (planner's reading, § 8.2) |
| `lemmaL`, `exists_three_le_multicolour`, `ts_t` | FS106-L, TS-T | M; `ts_t_trichromatic`, `ts_t_degree_three` are item 142's (K) |
| `n4_fin`, `ray_chain`, `exists_oneSided_chain`, `rayLower_pencil` | FIN's strict bounds (with unit arcs, FS112-END keeps a bi-infinite chain's bounds strict) | M |
