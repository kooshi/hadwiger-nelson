# FS131-KB — the base of row 134 with unit arcs: the plan of `row134BaseUA`'s proof

*de Bruijn, the planner (FS131-KB), 2026-10-04. Brief: `data/fs131/briefs/FS131-KB-base.md` (main tree). Branch `fs131-w5b` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5b`), from `fs131-w5` at `764cc558`. The model this record follows is `plans/FS131-kernel-plan.md`
§ 6; wave 5's vocabulary is `plans/FS131-w5-kernel-plan.md` §§ 2, 8, 10.*

## Theorems this phase proved

None: a planning job. The base's leaves are stated with `sorry`; no row is proved.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "197. **Ruling on F-BASE: the unit-arc statement stays, as an intermediate `Prop` proved inside FS-131 — not as the outside hypothesis.** Choice: K5's unit-arc" | `plans/FS131-close-inventory.md` item 197 (**main tree**, l. 1379; this branch's copy is older and ends before item 177) | verbatim (truncated, marked) |
| "Inventory item 197: the unit-arc statement of the base is wave 5's intermediate `Prop` **`Row134BaseUA`**, proved inside FS-131 (`row134BaseUA`," | `data/fs131/k5/STUB-row134-base-lean.md` § What stays outside (identical on `fs131-w5` and here) | verbatim (truncated) |
| "(b) **`NoInertNear` (exclude only inert arcs not ending at `u`?) is the base planner's call**, since `Row134BaseUA` is an intermediate of ours and the" | inventory item **199** (b) (the brief says "the ruling" without its number) | verbatim (truncated) |
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |

No mismatch. Two slips of address, harmless: the inventory quoted is the main tree's (the branch's copy predates item 177), and the `NoInertNear`
ruling is item 199 (b). The agent file's pointer "`.claude/agents/debruijn.md` § Building Lean" (from `RUNNING.md` § Building) names a section that
does not exist; `LEAN.md` § Building holds that text.

### 1.2 What I am planning, and what I may change

**Planning:** the proof of `row134BaseUA : Row134BaseUA` (`Plane/ValidMap/Dense`; the `Prop` in `Plane/ValidMap/Chain`) as named lemmas with `sorry`
at every leaf, in new modules under `Plane/ValidMap/`; a plan per leaf; the obligation pass; the implementer's handoff. **I may change:** the layout,
the leaves' names and cut, `Dense.lean` only to move `row134BaseUA` and its four consumers downstream of the base (statements unchanged),
`NoInertNear` (after a message), `Proofs.lean`, `ARCHITECTURE.md`, my block of `scripts/Axioms.lean`. **I may not change** any wave-4/5 statement
(`pair_*`, `fail_*`, `anti`, `noBoth`, `cor3`, `p17_ua`, `bv_*`, `rot_*`, `hex_regular`); where the walk needs one in another form, that is a finding.

### 1.3 The as-given build

`764cc558` under the slot (40 GiB, 8 cpus, `BATCH=4`): § 1.4 when it lands (driver log `data/fs131/kb/build-asgiven.log`).

### 1.4 The as-given build — not obtained separately (a slip, logged)

The as-given build was queued at stage 1 and held by the slot (`ledger 80 + 40 > budget 90 GiB`, four agents building). It had not started when
stage 3's files were written, so the build that runs builds the skeleton too: K5's slip repeated, for the same reason. Its result is § 3.3.

## Stage 2 — SAVED: the confirmation, the two questions, and the GAP (all sent to Keryx mid-job, 2026-10-04)

### 2.1 The confirmation: what of `[SokolovVoronov2025]` the walk uses by statement

Read for it: `plans/FS110-CB-verification.md` (in full), `plans/FS110-CE-verification.md` (in full), `plans/FS110-CD-verification.md` § 1.1, §§ 2.0–2.10,
`plans/BASE-V-verification.md` (in full), FS110-CUSP-BASE in `plans/FS110-derivation.md`, `plans/FS112-N-proof.md` stages N3-3 and N3-4, `plans/FS112-NB3-verification.md`
§§ 1.3–1.4, and the paper's Prop. 19, Lemma 6 and its Appendix (pp. 24, 27–28; Voronov 2023 Lemma 6.1, p. 12). `plans/FS110-CC-verification.md` was not opened
(its content, the strip and Prop. 17 at cusps, is replaced in the walk by `fail_*` and `p17_ua`/`bv_hex`; BASE-V § 2.0 read its C4–C6).

| printed piece | how the walk reads it |
|---|---|
| Props. 1–4, Lemma 1 | inside: the (P) sweep (CB D1; CD (F1)–(F3)) |
| Props. 9–11, Cor. 2 (the strip) | inside: N3-FAIL (`fail_leavingCentre`, `fail_colours`) — used by `cor3`, `pair_ii` |
| Cor. 3 | inside: N3-COR3 (`cor3`) |
| Props. 14–15 ((i), (ii)) | inside: N3-I, N3-II (`pair_i`, `pair_ii`); BV-ND1 (`bv_nd1`) |
| **Lemma 5, Prop. 18** | **inside**: CB took them from print, but FS110-CD § 2.5 and BASE-V § 1a.2–1a.3 derived both, blind, by different routes (two minds) |
| Prop. 17 | inside: `p17_ua` / `bv_hex` |
| Lemma 3 | inside: CB D4, BASE-V BV-L3 (the walk needs it in pseudo-colour form, § 2.2) |
| Prop. 19 (the plane recolouring) | not used: replaced by CD's Lemma R / CE's R1–R4 (the circle-only reduction) |
| Lemma 4's pigeonhole | inside: CD § 2.7, CB D5 item 6, CE E6 |
| **the eleventh point** (p. 28: "It remains to notice that on the boundary of the union of three regions of colors 1, 2, 3 whose vertex is u, there is at least one more trichromatic point (Fig. 6).") | **asserted in print; every source obtains it after hole-filling** (Voronov's Obs. 2.2 and Lemma 6.1; CB D5 item 6; CE E6). In the local base it is a GAP (§ 2.3), not an import |

**Result: no piece is used purely by statement, with one exception that cannot be imported.** The eleventh point is a step of our own walk whose
local truth is in question. An `axiom` for it would carry that question into the kernel, and an axiom importing a step of ours is forbidden anyway.

### 2.2 Question 2 settled: Lemma 3 with contact arcs

**Can in- or out-contact unit arcs occur on the circle of a pigeonhole vertex `p ∈ B̄(u, 1)`?** Yes. Under H and `NoInertNear`, only inert arcs (excluded
by `NoInertNear`) and both-kind arcs (excluded by `noBoth` with H) are ruled out. An in-contact arc of `ω(p)` (inner colour in `P_cl(p)`, outer colour not)
contradicts nothing: its pseudo-colour is the single outer colour along its interior. So wave 5's `bv_l3`, whose `RingProper` demands that
`Γ ∩ ω(p)` be finite, does not apply at such `p`.

**Choice:** a Lemma 3 tolerating such arcs, stated in the base module as `BaseCtx.l3_base`. It reads the pseudo-colourings as wave-3 `CircleColouring`s
(`exists_pseudoCircle`, whose finiteness counts non-singleton pseudo-colour points rather than points of `Γ`). (i) across the two circles is `pair_i`.
The double event is `pair_ii` with H, or `bv_nd`. The route is BASE-V's BV-L3: one linkage loop, the band, the jump at `c₀ ∈ 3ℤ`. The step where BV-L3
reads "generic points interior to tiles" becomes "germs with one pseudo-colour", and the (P) sweep still applies there because the transversal
circle enters the side of the arc that carries the pseudo-colour. That is N3-I's argument and needs no new mathematics.

**Alternative weighed:** widen `RingProper` (K5b's vocabulary) so that `bv_l3` covers arcs. Rejected: `bv_l3` is FS114-BV-HEX's row clause, stated at its
own class (BASE-V assumes generic points interior). Changing it would change a row's statement.

**Statements changed:** none. `l3_base` is new, and `bv_l3` is left unused by the walk. Its circle-abstract core (the linkage band) should be one
lemma shared by both (handoff § 5).

### 2.3 Question 1 settled: `NoInertNear` stays as stated — and GAP-ELEVEN

**`NoInertNear`.** **Choice:** unchanged (every inert unit arc centred in `B̄(u, 1)` excluded, those ending at `u` included). **Why:** the walk reads it
as the finiteness of `ω(p)`'s pseudo-colouring at every pigeonhole centre `p ∈ B̄(u, 1)`. Those centres include V-in endpoints on `ω(u)`, and an inert
arc of `ω(p)` there may end at `u`. Excluding only the arcs not ending at `u` would leave an infinite set of two-colour points on that circle.
**Alternative:** the narrower definition (inventory item 199 (b)'s question). Rejected for that reason. **Statements changed:** none. **Owed by
`n3_base`'s proof:** the pre-bend of an inert arc that ends at `u` must keep `u` cubic trichromatic with its colours (NB3 step 4: "at the ends the sector
structure is unchanged"). This is a strengthened-bend child for wave 5's implementer, and the bends must be iterated until none is left (a bend can
remove a colour from a point on the arc that is itself a unit-arc centre).

**GAP-ELEVEN (sent to Keryx).** The `10 + 1` count needs a three-colour point `q ∈ B̄(u, 1)` carrying exactly two colours of `u` (whose tiles lie in
`B(u, 1)`, as Theorem D2 (ii) needs). Every source finds it on the outer rim of `R*`, the `P_cl(u)`-component of `u`, **once tiles are simply connected**
(hole-filling). In the local base, `u` is fixed and H holds only on `B̄(u, 2)`. A tile `R°` of a colour of `u` that encloses `u` inside `B(u, 1)` makes
`R*`'s outer rim border `R°` alone, and filling `R°`'s hole destroys `u`. I found no local contradiction for that configuration (all distances inside the
hole are below `1`; Lemma H holds). FS110-CD § 2.6 and § 2.8 item 2 named the multiply connected case and left it open. **Not a counterexample to
`Row134BaseUA`. It is a GAP at the walk's eleventh-point step** (FS112-N3-3 asserts it), so also at rows 135 and 137 through FS112-N3-BASE. Repairs, for
Keryx and the deriver: (a) a local argument excluding enclosure under H, or closing the pigeonhole without `q`; (b) add a no-enclosure hypothesis to
`Row134BaseUA` and have `localDense` choose an un-enclosed `u`, at radius 4 if needed (a row change); (c) `BaseHyp` at radius 3. The skeleton isolates
the step as `BaseCtx.exists_eleventh`, so no other leaf changes whichever repair is chosen.

## Stage 3 — SAVED: the skeleton

### 3.1 Layout

| module | contents |
|---|---|
| `Plane/ValidMap/BaseWalk` (new; imports `Dense`, `RingBand`) | `BaseCtx` (the base's context, bundled), `VIn`, `IsEndpoint`, `IsRetArc`; circle-abstract `CircleColouring.Removable`, `ChangeWith`, `IsHex`, `reduce`, `select`; 17 map leaves — **19 `sorry` leaves** |
| `Plane/ValidMap/BaseDense` (new; imports `BaseWalk`) | `row134BaseUA` (the assembly, one `sorry`), `n3_base`, `localDense`, `dense3`, `cv_exists` — **moved from `Dense`, statements and names unchanged** (`cor3` stays in `Dense`, which the walk imports) |

`Proofs.lean`, `ARCHITECTURE.md` (two rows, `Dense`'s row amended; `tools/check_architecture.py` PASS, exit 0) and `scripts/Axioms.lean` (block "FS-131 wave 5 (job FS131-KB)", 19
records) are updated.

### 3.2 Read-backs (each leaf against the walk's line it formalizes)

| leaf | the walk's line | read-back |
|---|---|---|
| `cubic_of_three` | NB3 "under H … every centre the base reads … is cubic" | three colours and H give cubic trichromatic in `B̄(u, 2)` — same |
| `pseudo_nonempty` | N3-3 "`c′ ≠ ∅`: … both-kind at `p`" | same, at every `p ∈ B̄(u, 1)` cubic (the walk applies it at `u` and at the pigeonhole centres) |
| `pseudo_ncard_le_two` | N3-3 "`|c′| ≤ 2`" (N3-COR3) | same |
| `pseudo_finite` | N3-3 "finitely many two-colour points" (after the pre-bend) | **wider reading**: finitely many non-singleton points per period, which is what the circle model needs |
| `exists_pseudoCircle` | NB3 step 2 ("the pseudo-colouring exists"); (i), (ii) | the pseudo-colouring as wave 3's `CircleColouring`, no swap point ((ii) in BV-H1's form, BASE-V step 3) |
| `reduce` | CD Lemma R steps 4–5; CE R3 | circle-abstract, given removable arcs that nest or are disjoint — same |
| `select` | Lemma 6 (BV-L5, BV-C6, BV-P18; CD § 2.5) | hexagon, or three change points per pair with chords `> 1` — same |
| `retArc_partner` | CD Lemma R step 3 | **path-free**: the two tiles' connectedness replaces the path `β`; same conclusion |
| `retArcs_finite`, `retArcs_nested` | CB D5 item 1 ("paths do not cross") | same; nesting is planar core |
| `exists_endpoint` | Prop. 19(b), CD Lemma E, CE R1–R4 | endpoint in the closures of the two tiles at the change point, in `B(u, 1)` or V-in — same, path-free in its statement |
| `exists_eleventh` | S–V p. 28; CD § 2.6; N3-3 | **GAP** (§ 2.3) |
| `endpoint_dist_ge` | CB D5 item 6 ("`|p − p′| ≥ 1`") | same, every `k` |
| `vin_antipodal`, `eleventh_antipodal` | CD Theorem D2 (i), (ii); CE's Antipodal Lemma | same |
| `cor3_base` | NB3 step 5 | same |
| `l3_base` | Lemma 3 (CB D4; BV-L3) | pseudo-colour form (§ 2.2) |
| `hex_base` | NB3 step 10 (Prop. 17) | same, through `p17_ua` |
| `eleventh_type` | Lemma 4's `10 + 1` | finite combinatorics — same |
| `row134BaseUA` | the table's assembly | statement unchanged; its docstring now states the assembly |

### 3.3 The build

See § 3.4 (filled at the commit that records it).

## Stage 4 — SAVED (partial): the plan per leaf; owed: the obligation pass and the `#check`s

*E easy, M moderate, H hard. Library names below were read in the source; Mathlib names are **not yet confirmed with `#check`** (owed, § 6).*

**A — the pseudo-colouring at a centre `p ∈ B̄(u, 1)`, cubic trichromatic.**
- A0 `cubic_of_three` — **E** over K5b's child `isCubicTrichromatic_of_three_of_noRep` (wave 5, not yet written) and `BaseHyp`'s `repSet` clause.
- A1 `pseudo_nonempty` — **M**. If `P_cl(x) ⊆ P_cl(p)`: colours near `x` are colours at `x` (closedness of `closure (region j)`); by the (P) sweep (`Valid` + `ω(p)` through
  an interior point of a `P_cl(p)`-coloured tile is impossible) `ω(p)` near `x` has no interior point, so it lies in `Γ`. Child **`exists_isRingArc_of_onRingArc`**
  (K5b's, shared): a sub-arc with constant sides (local finiteness: finitely many arcs, a non-concentric arc meets `ω(p)` twice at most). Its sides lie in
  `P_cl(x) ⊆ P_cl(p)`: `BothKind p`, then `noBoth` gives four colours or a repeated colour at `p ∈ B̄(u, 2)`, against H.
- A2 `pseudo_ncard_le_two` — **M**. `c′(x)` all three absent colours ⟹ `#P_cl(x) ≥ 3`; H at `x ∈ B̄(u, 2)` ⟹ exactly 3 ⟹ A0 ⟹ `cor3 hF p x` (covers `B̄(p, 1)`,
  `B̄(x, 1)` ⊆ `B̄(u, 2)`... `x` may sit at distance 2: `B̄(x, 1) ⊄ B̄(u, 2)` — **check**: `cor3` needs `F.Covers x 1`; `x ∈ ω(p)`, `p ∈ B̄(u, 1)` gives `|x − u| ≤ 2`,
  so `B̄(x, 1) ⊆ B̄(u, 3)`, not covered. **Repair inside the leaf**: `cor3`'s argument reads only small discs about the rhombus corners and the arcs at `u`, `x`
  (its docstring: "the class the argument reads: the strips at `q±` and the arcs at `u`, `u′`"); either prove a local `cor3` variant (covers `B̄(p, 1)` and a
  neighbourhood of `x`), or ask whether `cor3`'s hypothesis can be weakened (a finding for Keryx if needed). Then the corners `q` with `|q − p| = 1` lie in
  `B̄(u, 2)` and carry four colours, against H.
- A3 `pseudo_finite` — **M–H**. `Γ ∩ ω(p)` off concentric arcs is finite (compactness + `locallyFinite` + two points per non-concentric arc). A concentric arc's
  interior points have pseudo-colour exactly one colour: they carry exactly its two side colours (`innerColours ∪ outerColours` at a point of a ring arc), and
  in/out-contact means exactly one lies in `P_cl(p)`. Inert is excluded by `B.noInert` (`p ∈ B̄(u, 1)`) and both-kind by `noBoth` with H. Children: `coloursAt_eq_sides`
  (a point inside a ring arc carries exactly its sides), `finite_inter_sphere_of_nonconcentric`.
- A4 `exists_pseudoCircle` — **M**. `S := {θ | non-singleton at θ, or the germs differ}`, `c θ := g⁻¹` of the germ value (`g`: `ZMod 3 ≃` the absent colours);
  `locallyConstant` from closedness; `proper` from `pair_i` (`u₁ = u₂ = p`); no swap from `pair_ii` at `(x, σx)` (`htr`: `dist y p = 1 ≠ 2`) with A2 and H (or `bv_nd1`).
  Pattern: wave 3's `ringCircleColouring` (`Plane/RingBand` l. 1170) and `ring_finite_S`, `ring_locallyConstant`, `ring_proper`.

**B — circle-abstract (no map).**
- B1 `reduce` — **M–H**. CD Lemma R step 5's six cases over the maximal arcs (finiteness: pick maximal elements of the nested family). Represent `C′.c` as `C.c`
  overwritten on each maximal span (periodic), `C′.S := C.S \ ⋃ spans`. Children: `maximal_of_nested`, the case lemmas (inherited; open arc vs unchanged; end vs
  unchanged; open vs closed; end vs end).
- B2 `select` — **H** (the long circle-abstract leaf). BASE-V § 1a.2–1a.3 over wave 3's `Lift` (`exists_lift`, `D0_mod_ne`, `W_eq`): BV-H1 (the band: `D ∉ 3ℤ`,
  ±2 jumps only across non-multiples, by no swap), BV-L5 (the running maximum `h′ x = max_{y ≤ x} h y`: a lift of a cyclic colouring with the same kept pairs),
  BV-C6 (`n ≡ 6, 9, 12 mod 18`; `n = 6` ⟹ the hexagon), BV-P18 (index gap `k + 1`). Children named by BASE-V's ids. Alternative route for Prop. 18: CD § 2.5
  (Voronov's Prop. 3.3 gap propagation).

**C — the planar core (the hard part; the infrastructure decision is Keryx's, § 5.3).**
- C1 `retArc_partner` — **M**. `ω(y) ∩ ω(u) = {x, x ± 120°}`, so `r(s)`, `r(t)` lie strictly on opposite sides of `ω(y)` (exact: `dist` to `y` below/above `1`);
  each tile is connected with points near both ends, so it meets `ω(y)` at an interior point; the (P) sweep gives the colour's absence at `y`.
- C2 `retArcs_finite` — **E** over A3 (ends are non-singleton points or germ changes, finitely many per period).
- C3 `retArcs_nested` — **H, planar**. Interleaved ends: the `a₂`-tile and `c₂`-tile of one pair connect a point inside the region bounded by the other pair's
  tiles to one outside. Needs a separation statement. Route: the finite boundary graph (below), or a direct chord-crossing lemma for the `a|c` boundary.
- C4 `exists_endpoint` — **H, planar**. Route: the finite boundary graph of `F` in `B̄(u, 1)` (vertices: three-colour points, points of `Γ ∩ ω(u)`, arc ends and
  crossings; edges: maximal arc pieces). Its `a|c` subgraph has degree 2 at `{a, c}` points inside, 1 at three-colour points and at exits on `ω(u)` (change
  points), 2 at spikes (R1). Mathlib's handshake lemma on the component of `r(θ)` gives a second odd vertex: a three-colour point (V-in on `ω(u)` by R2, R4) or
  an exit, which is a returning partner (excluded by `hout`). Children: `boundaryGraph` (finite, from compactness and `locallyFinite`), `degree_ac` (from the
  sector charts, `Plane/LocalStructure`'s `IsSectorChart`), `exit_isRetArc`.
- C5 `exists_eleventh` — **GAP** (§ 2.3). Not planned until the deriver answers. With simply connected tiles in `B̄(u, 1)`, the route is: the outer boundary of
  `R*` (CD § 2.6, Corollary H′ for `R* ⊆ B(u, 1)`) carries two colours of `u` because one tile does not bound it, so a vertex with two colours of `u` lies on it.

**D — refuters and distances.**
- D1 `endpoint_dist_ge` — **M**. `T₁ ≠ T₂`, since a tile's closure has diameter `≤ 1` (wave 3's `Plane/Diameter`) while `1 < |x₁ − x₂|`. Validity on the connected
  `T₁ × T₂` ⟹ all cross distances `> 1` or all `< 1` (`IsPreconnected.prod`, IVT on `dist`). Points near `x₁`, `x₂` give `> 1`; closures give `≥ 1`.
- D2 `vin_antipodal` — **M** (CD Theorem D2 (i)): Lemma H(b) (a tile of colour `i` meeting `B(u, 1)` lies within `1` of `u`'s `i`-tile), and two closed unit discs
  with centres `2` apart meet only at `u` (`tools/fs110_cd_checks.py` A1's identity).
- D3 `eleventh_antipodal` — **M** (Theorem D2 (ii)): the cusp points `u + t e⊥` lie outside both discs (`1 + t²`), and the sectors at `u` cover a punctured disc.
- D4 `cor3_base` — **E–M** over `cor3` (the same covering caveat as A2: `p, p′ ∈ B̄(u, 1)` gives `Covers p 1` ✓).
- D5 `l3_base` — **H**. A4 at `u₁`, `u₂`; one shared circle-abstract child **`linkage_band`** (BASE-V § 1b.3: the loop `Φ` over the proper arc `Y`, the band
  from BV-H1, `c₀ = h₁(P) − h₂(P) ∈ 3ℤ` at an intersection point, since the pseudo-colours relative to `u₁` and `u₂` agree when `P_cl(u₁) = P_cl(u₂)`; a jump
  across `c₀` is a double event), with its map inputs `pair_i` (cross (i)) and `pair_ii`/`bv_nd` (double events, using `linkage_dot_ne_zero`). `bv_l3` should
  be re-routed through `linkage_band` too (wave 5's implementer).
- D6 `hex_base` — **E–M**: `C.IsHex` with the germ transfer gives `HexRing u ψ (g ∘ b)` (pseudo-colours at the six points from A2 and the germs); `p17_ua`.

**E — the count, and the assembly.**
- E1 `eleventh_type` — **E** (`decide` over `Fin 6` after fixing `U` by symmetry, or a direct `Finset` argument).
- F1 `row134BaseUA` — **M** once A–E land: the order in its docstring. `pair_P'` excludes distance exactly `1`.

**Price, to be re-priced from the first two leaves:** A and D without D5 about one implementer session; B2 and D5 one session each; C3 and C4 are the
planar core, one to two sessions after its infrastructure; C5 waits on the deriver.

## Stage 5 — SAVED: the handoff (wave 4's plan § 14 form, short)

### 5.1 Where it is, and how the implementer works

Branch `fs131-w5b` (worktree `.claude/worktrees/fs131-w5b`). Modules `Plane/ValidMap/BaseWalk` (19 `sorry` leaves) and `Plane/ValidMap/BaseDense`
(`row134BaseUA` plus the four moved consumers, as on `fs131-w5`). Build: from inside the worktree, `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`.
Work order: A0–A4 → D1, D4, D6, E1 → B1 → B2 → D2, D3 → D5 → C1, C2 → (planar core) C3, C4 → F1. C5 waits.

### 5.2 What the implementer may and may not change

It may add children (shared ones in `Chain`/`BaseSteps` foundations, each with a spec example) and change imports, updating `ARCHITECTURE.md`'s Imports
cell and `scripts/Axioms.lean`. It may not change any statement of § 3.2, the definitions `BaseCtx`, `VIn`, `IsEndpoint`, `IsRetArc`, `Removable`,
`ChangeWith`, `IsHex`, or any wave-4/5 statement. A statement that fails comes back through Keryx. Watch especially A2's covering caveat (`cor3` at a centre
`x ∈ ω(p)` needs `B̄(x, 1)`, which `B̄(u, 2)` does not cover).

### 5.3 For Keryx: the planar core, and the landing

The planar core (C3, C4, and C5 once repaired) needs boundary-path topology; Mathlib has no Jordan curve theorem at the pin. This is the same kind of
work as `cvb_thom_reduced`'s boundary walks (`Plane/ValidMap/MapGraph`). **Recommendation:** one infrastructure job, the finite boundary graph of an
`ArcMap` in a compact disc with its degree lemma, serving both. **Landing:** `fs131-w5b` merges into `fs131-w5` when Keryx says. Conflicts are append-only
in `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`, plus `Dense.lean`'s removed block. `n3_base`, `localDense`, `dense3`, `cv_exists` keep their
statements and names, in the new module `BaseDense`. Wave 5's implementer works on them there after the merge. Nothing with a `sorry` reaches `main`.

### 5.4 Vacuity carriers

`BaseCtx`: **OUT** (the hypothesis of refutation steps; its emptiness is `row134BaseUA` itself). `IsRetArc`, `IsEndpoint`, `VIn`: OUT (atoms read at
variable maps). `CircleColouring.Removable`, `IsHex`: OUT (existence is a construction; `hexColouring` is a hexagon). Every leaf is `GENERIC` or a step
inside the refutation. `eleventh_type` and `endpoint_dist_ge` are unconditional or at a variable map.

## 6. What is left (owed by this job, not done)

1. **The obligation pass** (`debruijn-obligation-modeling`, invoked fresh) over § 3.2's statements. Not run (budget). § 4's decompositions are
   un-audited by it.
2. **`#check` confirmation** of the Mathlib names § 4 assumes (handshake lemma, `IsPreconnected.prod`, `Metric` disc lemmas).
3. **GAP-ELEVEN's resolution** (Keryx and the deriver), then C5's plan.
4. **A2/D4's covering caveat**: decide between a local `cor3` variant and a hypothesis change to `cor3` (the latter would be a finding).
5. The skeleton build's result (§ 3.4).

## Stage 3, § 3.4 — the skeleton build (SAVED)

`./scripts/build.sh` under the slot (40 GiB, 8 cpus, `BATCH=4`) on `c48f0ba8`'s tree: **OK, 446 of 446 batches, 4 modules rebuilt, 9 with warnings, exit 0**
(`build/gate/build/20261004T192248Z-1722529.log`; driver log `data/fs131/kb/build-asgiven.log`). Every warning was `declaration uses sorry` except five
`missing doc string for public field BaseCtx.*` in `BaseWalk`. Those are fixed (field docstrings), and `lake env lean` on `BaseWalk` shows only `sorry`
warnings. The confirming build is `data/fs131/kb/build-stage3b.log`, recorded in the report if it lands before hand-back.
