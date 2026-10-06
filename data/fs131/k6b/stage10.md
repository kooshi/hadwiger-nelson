
## Stage 10 — SAVED: the fan as a library module, with its inhabitant

### 10.1 The modules

- **`Plane/Saturated/Fan`** (no `sorry`): `polarGraph z r φ`, `polarRegion z r φ ψ`, `cyclicNext φ i` (over wave 3's `polarPt`; the same shape as
  wave 3's `BranchGerms` / `IsSectorChart` for arc maps, whose branches are the circular germs `β + arcsin(κ s/2)` — a fan's are any continuous
  polar graphs); `c.SingLocallyFinite`; `c.arcsAt z`, `c.RegJLiteral`; the structure `c.Fan z` (the first pass's § 6 design, its `bdry` and
  `region` fields written through `polarGraph`, `polarRegion`, `cyclicNext`); `c.RegJFan`; `Fan.branch`, `Fan.cell`, `Fan.nextDir`,
  `Fan.HasSector`, `Fan.HasHorn`. API proved: `polarGraph_subset`, `polarRegion_subset`, `Fan.branch_subset_interfaceSet` (branch points are
  interface points), `Fan.φ_lt_cyclicNext`, `Fan.tendsto_cyclicNext`, `Fan.dir_le_nextDir` (a region's angle is non-negative),
  `Fan.hasSector_or_hasHorn`, `SingLocallyFinite.exists_ball_subset`. Two tools for inhabitants: `notMem_essClosure_of_mem_densitySet`,
  `AeColouring.twoColourNhd_of_halves` (a convex open set cut into two colours by two convex open pieces is a two-colour neighbourhood).
  `RegJBridge` is not a definition any more: it is the theorem `regJFan_of_saturated` (stage 11).
- **`Plane/Saturated/FanExamples`** (no `sorry`): `sq9` at the grid vertex `sqVertex = 1/2 + i/2`, radius `1/4`.

### 10.2 The two facts the design's `Fan` has no field for: lemmas about any fan, not fields (ruling 492 (b))

The deriver's § 4.6 names them: the curvature bound along a branch, and the convergence of the branch's unit tangent (not only its polar angle).
Read against the arguments that consume them (`plans/FS121-V2-verification.md` §§ 2.1–2.3, read in full), they are consumed in **two set-level
forms, neither of which mentions a curve**: (L) *the lens* — the branch stays outside the two open unit discs tangent to its limit direction at
`z` (V2 § 2.3: "it lies on or below that arc, outside `B(y, 1)`"); (T) *the contacts* — Lemma T (ii): the contacts `x ± ν(x)` of the branch's
points converge, so `z ± i e(dir i)` lies in the support of the right colour, or the branch is a unit arc about that point.

**Decision: theorems about every fan under saturation in its punctured disc** (`Fan.branch_outside_discs`, `Fan.branch_contacts`, stated in
`Plane/Saturated/FanBridge`), **not fields.** Why:
1. They are consequences of saturation, not part of what a fan is: a polygonal colouring has fans at its vertices and no curvature bound, and the
   close's note defining the fan has no such clause. A field would make `Fan` mean "saturated fan" and every inhabitant prove it.
2. They are provable for **any** fan, not only the one the bridge builds: under saturation a branch is a connected component of the essential
   boundary in the punctured disc with `z` in its closure (it is relatively closed, and locally all of the boundary by FS131-E8-LOCAL), so
   FS131-E8-GAMMA and -BETA describe it. "Lemmas the bridge exports beside the fan" would be facts about one particular fan that every consumer
   must carry as extra hypotheses; lemmas about any fan are carried by nobody.
3. In the set-level forms the consumers never see a curve: the curve notion stays inside the bridge's modules.
Cost: the two lemmas hold within distance `1/2` of `z` (the chord bound's range), so they are stated for `t < min F.r (1/2)`.

### 10.3 The inhabitant, and the validation

**`sq9Fan : sq9.Fan sqVertex`** — four branches along the half-axes (`φ i t = i π/2`), four regions (the open quadrants) of the four colours
`sqQuad b b'`. Each field is a theorem about `sq9`: `sq9_singular_near_vertex` (`Σ ∩ B(vertex, 1/4) ⊆ {vertex}`: no cusp near the vertex,
`sq9_not_isCuspAt_near_vertex`; the essential boundary there is the two axes, `sq9_axis_of_mem_essBdry`; every axis point but the vertex has a
two-colour ball, `sq9_twoColourNhd_of_re`, `_of_im`), `sq9_bdry_near_vertex`, `sq9_region_near_vertex`. With it: **`sqVertex_mem_singularSet`**
(the vertex is singular: every ball about it holds four colours), so the hypotheses "a fan at `z`", "`z ∈ Σ`", "`Σ ∩ B(z, R) ⊆ {z}`" and
"saturated" (`sq9_tight_saturated`) are met together, at `k = 9`. Spec examples: `sq9Fan_hasSector` (each quadrant colour a sector of angle
`π/2`), `sq9Fan_not_hasHorn`; for the definitions, `polarGraph_subset`, `polarRegion_subset`, `cyclicNext_of_lt`, `cyclicNext_of_not_lt`,
`Fan.hasSector_or_hasHorn`, `RegJFan.singLocallyFinite`, `RegJLiteral.singLocallyFinite`.
**Owed** (a leaf for an implementer, not stated): `sq9.SingLocallyFinite` — the vertex analysis at every grid vertex `(n/2, m/2)` (the lemmas of
`FanExamples` with `n`, `m` general; wave 2's `sq9Sq` lemmas already are) — which with stage 11's bridge gives `sq9.RegJFan`, the model of every
theorem that takes `RegJFan` and saturation. `HasHorn`'s adversary (R7 at a lattice point: three sectors and three horns) is not built.

**Negative control** (2026-10-06, `lake env lean` on a scratch copy of the two modules): an appended
`example : sqQuad true true = sqQuad false true := by decide` is refused ("proved that the proposition is false"); `#print axioms sq9Fan`,
`sqVertex_mem_singularSet`, `sq9Fan_not_hasHorn` read the standard three — the files are elaborated to their end.

**Price, for re-pricing**: the inhabitant is 545 lines; written and closed in this stage in three elaborations (two errors, one line each). The
first pass priced leaves of this kind (floor computations on `sq9`) at 2 h each.
