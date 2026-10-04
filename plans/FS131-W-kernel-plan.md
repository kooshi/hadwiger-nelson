# FS131-W — the kernel plan for Woodall's chain: FS106-WO, FS106-TW, FS106-AE-MAP6

*Job FS131-W (de Bruijn, the planner; Opus 5.5), 2026-10-04. Brief `data/fs131/briefs/FS131-W-woodall.md` with `plans/STANDING-RULES.md`, `LEAN.md`
(read in full) and `RUNNING.md` § Building. Worktree `.claude/worktrees/fs131-ww`, branch `fs131-ww`, from wave 4's full skeleton `f620977c`. No fence
in this milestone (inventory ruling 1): the derivation's records were read from the start. Report: `data/fs131/reports/FS131-W.md`.*

## Theorems this phase proved

None so far (a planning job). Hand checks recorded below are a planner's checks, graded where they appear.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| FS106-AE-MAP6's statement | `plans/LEAN-BACKLOG.md` § 8, the `statement` cell (and `plans/FS106-derivation.md:121`) | **matches** verbatim |
| FS106-TW's statement | `plans/LEAN-BACKLOG.md` § 7 (and `plans/FS106-derivation.md:67`) | **matches** verbatim |
| FS106-WO's statement | `plans/LEAN-BACKLOG.md` § 6 (and `plans/FS106-derivation.md:73`) | **matches** verbatim |
| Kooshi on pricing ("Do not consider Lean formalization a cost. …") | `CLAUDE.md` § Counter-priors | **matches** |
| inventory items 54, 66, 67 (paraphrased in the brief, not quoted) | main tree `plans/FS131-close-inventory.md` (the branch's copy predates them) | the brief's glosses agree with the items |
| ruling R9 (glossed) | `plans/FS131-kernel-plan.md` § 4.3; `data/fs131/k1/dispositions.csv` rows 7–9 | agrees: WO and TW keep "its mathematical content only"; AE-MAP6 has no ruling |

No mismatch; no finding about the brief.

### 1.2 The rows and the rulings, quoted

> No map-type colouring (Conditions 2–4) with five colours is almost-everywhere proper, modulo Townsend's simplification (c) as filled by Woodall's steps 2, 3, 5; no step uses "boundaries of measure 0", which only identifies D-AEMAP with Leb ⊗ σ-a.e. properness.
> — source: `plans/LEAN-BACKLOG.md` § 8. FS106-AE-MAP6 (grade: "hand; one mind per link: TS (the reduction to Townsend's annulus lemma), V3 (the lemma and Thms 1–2 region-only); the fill in outline")

> `[Townsend1981]` states "Every 5-coloured map in the plane contains a monochrome unit" and a lemma (constant π/3), with no proof of the theorem; the lemma is TRUE. Townsend's 1979 manuscript proves the ⅓π lemma, his Thm 2 and the Corollaries of Thms 3–4 region-only (Thm 4 itself GAP in its generality, petal-shaped sets; its Corollary repaired, sketch), and his Thm 5 (maps need six) is a GAP at simplification (c), which Woodall's steps 2, 3, 5 fill.
> — source: `plans/LEAN-BACKLOG.md` § 7. FS106-TW (handoff: "declined until the fill is walked")

> `[Woodall1973]` Thm 6 (maps need six): step 6 is a GAP (it rests on the assertion Townsend's ⅔π counterexample refutes), repaired by Townsend's ⅓π lemma; Woodall's step-4 lemma holds for arcs strictly longer than ⅔π, by lemma (L).
> — source: `plans/LEAN-BACKLOG.md` § 6. FS106-WO (grade: "hand; one mind: V3; steps 2, 3, 5, 7 in outline, step 8 unchecked")

Definitions (`data/fs106/claims.md` § 0): **D-SV** Conditions 2–4 (a Jordan colouring: vertices, boundaries that are Jordan curves ending at vertices,
regions the components, adjacent regions differently coloured, every vertex an endpoint of at least three boundaries; locally finite); **D-AEMAP** ("no
two points of open regions of one colour are at distance 1; boundaries and vertices carry no colour"); **D-VMC** (the multicolour).

**Rulings that bind this job.** R9 (`plans/FS131-kernel-plan.md` § 4.3): WO's and TW's verdict clauses are dropped and their mathematics formalized —
WO = Woodall's Thm 6 as repaired and the step-4 lemma for arcs longer than `2π/3`; TW = Townsend's `π/3` lemma. **Inventory item 67**: FS106-L only at a
change point **in** the open set (`not_lemmaL_of_not_mem`). **Item 66**: Lebesgue's covering theorem (TS-T's first clause) is FS131-LEB's; used as stated.
**Item 54**: this chain is its own job and lands before wave 9.

### 1.3 The papers, read (standing rule 10)

| work, copy | section | status (this job) |
|---|---|---|
| `[Woodall1973]`, `library/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf` | § 3, pp. 194–200 (the map definition, Thm 5, Thm 6 steps 1–8, the closing remark) | **read in full**, text layer and page images (PDF pp. 8, 10–13 rendered at 110–130 dpi); every constant read from the image: step 2 `θ₂ − θ₁ < ½π`; step 4 "length `⅔π`", "greater than `⅓π`", "at `⅓π`", "The lower bound `⅔π` is critical"; **step 5 "`φ ≤ ⅓π`", "`π − φ ≥ ⅔π`"**; step 6 "at least `⅔π`"; step 7 "`⅓π < φ_b ≤ ½π`", "`π − φ_b ≥ ½π`", "within `⅓π`", "`φ_a > ⅓π` and `φ_c > ⅓π`"; step 8 "`⅓π < φ_b ≤ ⅖π`", "`π − φ_b ≥ ⅗π`" |
| | §§ 1–2 | not read (statements of Thms 1–4 seen in the text layer only) |
| `[Townsend1979ms]`, `library/pdf/townsend-colouring-plane-no-monochrome-units-author-manuscript-1979-posted-2024.pdf` | all 7 pp. (Defs 1–4, simplifications (a)–(c), Thms 1–5, the Lemma) | **read in full**, text layer only (dropped symbols ∃, ≤, ∈ read from context and from V3's rendering); `[Townsend2005]` is the same text (BIBLIOGRAPHY, job LP) |
| `[Townsend1981]` | the note | **not read by this job** — its lemma is the manuscript's Thm 1 word for word (V3, VB, V: three readers); nothing here rests on the note beyond that |
| `plans/FS106-V-verification.md` § Continuation — FS106-V3 (stages 1, 3, 4), `plans/FS106-TS-derivation.md` § 3 row C-AE-MAP6, `plans/FS106-VB-verification.md` § 3b row TW-81 | the derivation's records | read |

### 1.4 What the reading found (sent to Keryx at this stage, message "FS131-W stage 1")

- **F1 — GAP at Woodall's step 5, equality case** (correction owed to FS106-WO and to the fill FS106-AE-MAP6 cites). V3 stage 3: "Steps 5 and 7 use
  strict inequalities and survive". The page image of step 5 reads `φ ≤ ⅓π` and `π − φ ≥ ⅔π` (the OCR dropped the signs). At `φ = π/3` step 5 needs
  step 4's lemma at length **exactly** `2π/3`, which Townsend's counterexample refutes; the repaired lemma is strict. Steps 7–8 need the strict
  `φ > π/3` ("The strictness of these inequalities is necessary"). The case closes by a second-order argument unless both edges of the `π/3` sector are
  arcs of the unit circles centred at the two ends of the opposite arc (§ 3's leaf `step5_eq`); that last configuration is open.
- **F2 — GAP at Woodall's step 7.** "e must terminate (which it can do only by meeting a vertex on the unit circle with center P)": the colour `D`
  may reach `ω(P)` at a point `Q` of the window with only `D` and `E` near `Q` — along an arc of `ω(P)` (a unit arc, excluded by Condition 5), or at an
  isolated point (the tip of a `D` wedge pointing outward, or an arc of radius `< 1` tangent to `ω(P)` from inside, both allowed by Condition 5). `Q` is
  then a corner, not a vertex, and step 6 is never reached. **Corrected at this stage** (second message): F2 survives Condition 5; and step 8 has no such
  gap (outside the window only `B` is allowed, so the accumulation point carries `B, D, E` and step 6 applies there in Woodall's normal form). The full
  question is § 1.6 Q2.
- **F3 — TS's reduction is not the whole of the remaining step.** C-AE-MAP6 says "what is left is exactly Townsend's printed lemma"; Townsend's Thm 1
  applies at a point whose three colours sit in three pairwise adjacent sectors; at a three-colour point with a repeated colour (`c₁ c₃ c₂ c₃`) or at a
  degree-four point with three chosen colours the cut set has positive length. Reaching a good vertex is Woodall's case analysis (steps 3, 5–8).
- **F4 — representation (decision owed).** "Conditions 2–4" are general Jordan-arc boundaries; their local theory (sectors between consecutive arcs at a
  vertex; Woodall's step 2) needs plane topology Mathlib lacks (Jordan curve theorem, θ-curve theorem). Proposed: state the chain over wave 3/4's
  `ArcMap` (locally finite segments and circular arcs; `Valid` is D-AEMAP), the class route M's regularity produces (rows 140–141), the general Jordan
  form recorded as owed; wave 9's FS111-M2-REDUCE-C, which composes AE-MAP6 with Jordan-arc boundaries (REG-J′-C_k), is told.

**Keryx's rulings** (2026-10-04, inventory items 88–90): F4 (a) — the chain over `ArcMap`, the general Jordan form owed, wave 9 told; F1 and F2 to an
Ephodos job (FS131-E1), each written here as a self-contained question (§ 1.6); the plan accepted: formalize what holds (TW in collar form, WO's strict
step-4 lemma, Townsend's `2π/3` counterexample as an adversary), and state AE-MAP6 unconditionally with the F1 and F2 leaves open, and under Condition 5.
With F2 surviving Condition 5, the Condition-5 form has one open leaf (`step7`), the unconditional form two (`step5_eq`, `step7`).

### 1.6 The two questions for the deriver (FS131-E1), self-contained

*Common setting.* A map of the plane bounded by a locally finite family of segments and circular arcs (an arc map; the questions make sense for Jordan
boundaries too), five colours, **almost-everywhere proper** (D-AEMAP): no two points of open regions of one colour are at distance exactly `1`;
boundary points carry no colour. `ω(p)` is the unit circle about `p`; `e(θ) = (cos θ, sin θ)`. Woodall's steps 1–3 are taken as done (Woodall's normal
form: at every vertex the regions have distinct colours, edges enter vertices in well-defined directions). A **sector** at a vertex `P` is a region near
`P` between two consecutive edges; its **angle** is the difference of the edges' directions. For a sector `b` at `P` with edges in directions `β₁ < β₂`
(`φ_b = β₂ − β₁`) and neighbours `a` (before `β₁`) and `c` (after `β₂`) of colours `A`, `C`, the **interior arc opposite `b`** is the set of points
`z = P + ρ e(ψ)` with `ψ ∈ I_b = (β₂ − 3π/2, β₁ − π/2)` (length `π − φ_b`) and `ρ ∈ (1 − h, 1)`, `h` small: for each such `z`, `ω(z)` passes through `a`,
`b` and `c` near `P`, so no region point of the arc has colour `A`, `B` or `C`. **Lemma (L)** (FS106-L, held at [hand], stated in the kernel as
`lemmaL`): in an open set `W` coloured with two colours whose classes are open and have no unit pair, a point `b ∈ W` with both colours arbitrarily
near has `ω(b) ∩ W = ∅`. **The strict step-4 lemma** (FS106-WO): an interior or exterior arc of positive thickness of length `> 2π/3` cannot be coloured
with two colours; it is false at exactly `2π/3` (Townsend's counterexample: the annular sector `1 − h ≤ |x| ≤ 1`, angles `[0, 2π/3]`, cut by the arc of
`ω((1, 0))` through `e(π/3)` into two one-coloured parts).

*The page image.* `[Woodall1973]` p. 198 (`library/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf`, PDF page 12, rendered at 130 dpi),
step 5, verbatim: "We may suppose without loss of generality that each region subtends an angle of more than ⅓π at each of its vertices … For suppose
that some region subtends an angle φ ≤ ⅓π at a vertex P: let this region be in set B (say) and the neighboring regions, necessarily in different sets,
be in sets A and C. Then opposite the region in B there is an interior unit arc of positive thickness of length π − φ ≥ ⅔π with center P, no point of
which can be in A, B, or C, and every point of which is therefore in D or E. And this we know is impossible by step 4 above." The OCR text layer reads
"an angle 4 < Qr" and "π − φ > ⅔π" there; FS106-V3 (stage 3) read the inequalities as strict ("Steps 5 and 7 use strict inequalities and survive").
p. 199, step 7: "(This is because φ_a > ⅓π and φ_c > ⅓π: a diagram will make this clear. The strictness of these inequalities is necessary.)"

**Q1 (F1) — step 5 at `φ_b = π/3` exactly.** Is the following configuration excluded? A vertex `P` with consecutive sectors `a, b, c` of distinct colours
`A, B, C`, `φ_b = π/3`, so `I_b = (ψ₁, ψ₂)` has length exactly `2π/3`; write `Q₁ = P + e(ψ₁)`, `Q₂ = P + e(ψ₂)`. **The open case:** the edge between `b`
and `c` is, near `P`, an arc of `ω(Q₁)`, and the edge between `a` and `b` is, near `P`, an arc of `ω(Q₂)`. *What I checked* [planner's check, one mind]:
(i) unless the `b|c` edge lies on `ω(Q₁)` near `P`, the set `W` of points whose unit circles meet `a`, `b` and `c` contains a one-sided collar (inner or
outer, of positive thickness) over a neighbourhood of the angle `ψ₁` — for an arc map, by comparing the edge (a segment, or a circle of another radius or
centre) with `ω(Q₁)`, both tangent to the direction `β₂` at `P`; likewise at `ψ₂` with the `a|b` edge and `ω(Q₂)`; (ii) if at least one end carries
such a collar, a change point `b′` of the interior arc (which has a unit pair, so both colours `D, E`, so change points at every thickness) lands — its
circle crosses `ω(P)` at angles `θ ± α`, `α ∈ (π/3, π/3 + O(1 − |b′ − P|))` — inside `W`, against lemma (L). So only the double-unit-arc configuration is
open; there the arc's two ends are genuine cut points and Townsend's two-colouring of the `2π/3` sector is not excluded by anything I found. *Needed:*
a contradiction in that configuration (from the rest of the map), or a different argument giving every angle `> π/3`, or the configuration
exhibited. Under Condition 5 (no boundary contains an arc of a unit circle) Q1 does not arise.

**Q2 (F2) — step 7's terminal vertex.** Is the following configuration excluded? A vertex `P` with exactly four sectors `a, b, c, d` (colours `A, B, C, D`,
distinct), every angle `> π/3`, `φ_b` the smallest (`π/3 < φ_b ≤ π/2`). The interior arc opposite `b`, `I_b = (ψ₁, ψ₂)` of length `π − φ_b ∈ [π/2, 2π/3)`,
is coloured `D, E` only and contains unit pairs, so both colours. By lemma (L), every `D|E` change point of the arc at angle `θ` has both landings
`θ ± α` outside the arc, so as the thickness tends to `0` the change points accumulate in the **window** `[ψ₂ − π/3, ψ₁ + π/3]` (length `φ_b − π/3`), at a
point `Q ∈ ω(P)`, with `D` and `E` in the multicolour of `Q`. Just outside `ω(P)` near the window only `B` and `E` can occur (the unit circles about those
points pass through `a`, `c` and `d`: computed, using `φ_a, φ_c > π/3` strictly). **The open case:** `B` does not occur near `Q`: outside `ω(P)` near `Q`
is all `E`, and `D` reaches `ω(P)` only from inside — (a) along an arc of `ω(P)` from `Q` (a unit arc centred at `P`, `D` inside, `E` outside), or (b) at the
single point `Q`: the tip of a `D` wedge pointing outward (the two `D|E` edges meet at `Q`, transversally to `ω(P)`), or an arc of a circle of radius `< 1`
tangent to `ω(P)` from inside at `Q`. Then `Q` carries only `D` and `E`: under Condition 2 ("every vertex is an endpoint of at least three boundaries")
it is not a vertex, Woodall's "e must terminate … by meeting a vertex on the unit circle with center P" fails, and step 6 is never reached. *What I
checked* [planner's check, one mind]: lemma (L) at the change points on the `D|E` edges near `Q` (their landings fall beyond the ends of `I_b` when `Q` is
strictly inside the window); the sector `d` at `P` (with `φ_a, φ_c > π/3`, `d` lies in the open half-plane facing every direction of the window, so the
unit circles about the `D` points near `Q` miss `d` near `P`, and conversely); TS-U at `P` for form (a) (`D` at `P` faces the arc: consistent); unit pairs
inside the arc (the `D` part has angular length `≤ φ_b − π/3 ≤ π/6`, the two `E` parts `≤ π/3` each, and the cross pairs land beyond the ends). No
contradiction found. Form (a) needs a unit arc; form (b) survives Condition 5. *Needed:* a contradiction in this configuration (perhaps from the other
three opposite arcs at `P`, or from the window's exterior collar coloured `B, E`), a different argument excluding vertices with four regions, or the
configuration exhibited. In step 8 (five regions at `P`) the same accumulation point carries `B, D, E` (outside the window only `B` can occur), so step 8
reduces to step 6 at `Q` in Woodall's normal form: Q2 is step 7's alone.

### 1.5 The worktree builds as given

`./scripts/build.sh` under the slot (40 GiB, 8 cpus, `BATCH=4`), from inside the worktree: **OK — 442 of 442 batches, 16 modules rebuilt, 11 with
warnings** (every warning `declaration uses 'sorry'`, waves 3–4's skeleton modules), 8 m 28 s, exit 0 (`build/gate/build/20261004T094153Z-2467841.log`;
driver log `data/fs131/w/build-stage1.log`).

## Stage 2 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

### 2.1 The model, and why this shape

`Proofs/HadwigerNelson/Plane/Woodall/Basic.lean` (imports `Plane/ValidMap/Basic`), sorry-free. Region-only and extrinsic throughout: predicates on
sets and on one `ArcMap`, one two-constructor type.

**The intrinsic structure.** Every step of both papers, once repaired, is one move: an open set `W` coloured by two colours with no monochrome unit,
a change point `b ∈ W`, and a proof that `ω(b)` meets `W` — contradicting lemma (L) (`lemmaL`, FS106-L). `ω(b)` meets `W` because `ω(b)` crosses
`ω(u)` transversally at the two angles `θ_b ± α_b` (`α_b = arccos(|b − u|/2)`) and `W` carries a one-sided collar about one of them. So:
- Woodall's "unit arc of positive thickness" with a variable thickness `f(θ)` is incidental; intrinsic is **a collar about each angle**
  (`CollarAt W u s θ`: some collar of positive thickness and half-width around `θ`, on the side `s`). Over a compact sub-interval this gives a
  uniform collar.
- Townsend's "finitely disconnected unit annulus" (a closed doubly connected set, cut points as points whose removal makes it simply connected) is
  incidental framing; intrinsic is **a finite set of cut angles off which every angle carries a one-sided collar, and one seed** (a one-sided collar
  over an arc longer than `π/3`, which holds a unit pair in every thin band near `ω(u)`, hence change points at infinitely many radii, hence one
  avoiding the finitely many points whose circles pass through two cut points).
- The 2-coloured set is wave 4's `shadow`: `⋂ c ∈ T, shadow (F.region c)` — the points whose unit circles meet every class of `T`; its region
  points carry no colour of `T` (validity).
- Which collars exist is decided, to first order, by the **cones** of the classes at `u` (wave 3's `coneAt`): an outer collar about `ψ` meets a
  connected open piece `R` with `u ∈ cl R` when `cone(R)` meets the open half-circle about `ψ`, an inner collar when it meets the opposite one
  (connectedness: `R` has points inside and outside `B(z, 1)`). At the switching angles (normals to an edge at `u`) the second order decides: one
  side's collar survives unless the edge lies on the unit circle centred there — for arc maps, a comparison of a segment or circle with a unit circle.
- **The picture at a point** (`ArcMap.SectorsAt v n d c`) is Woodall's "regions at a vertex" read on colour changes: `n` sectors between monotone
  directions `d` (`d (last n) = d 0 + 2π`; zero-angle sectors are horns), adjacent colours different (Woodall's step 1 is automatic), truncated open
  sectors strictly inside each sector in its class, and the cone of each class equal to the union of its closed sectors. Edges have directions
  automatically for arcs (Woodall's step 2). `WoodallMerged` is step 3's conclusion in Woodall's words ("if two of the regions are in the same set,
  then each of them subtends angle 0 at P"); `WoodallNormal` is steps 3 and 5 (distinct colours, every angle above `π/3`, at points of three or more
  sectors).

**Placement.** Nothing is indexed but the picture's `n`, which every step inspects (degree 3, 4, 5): `d : Fin (n + 1) → ℝ`, `c : Fin n → Fin k`.

### 2.2 Alternatives weighed

| choice | taken | alternative | why |
|---|---|---|---|
| boundaries | wave 3/4's `ArcMap` | general Jordan arcs (Conditions 2–4) | F4, ruled (a): the local theory of Jordan arcs needs the Jordan curve and θ-curve theorems (not in Mathlib) and Woodall's step 2 |
| Townsend's annulus | cut angles + `CollarAt` + one-sided seed | his Definition 2 literally | the literal form is plane topology (doubly connected, cut points by removal) and its proof reads only the collar property |
| the seed | one-sided collar over an arc `> π/3` | a connected open set meeting both sides | the side-switching seed needs "an open connected set minus a finite set is connected" (not in Mathlib's relative form); every application has a one-sided seed (§ 3.2, `step6`'s plan) |
| Woodall's step 3 | a global modification `exists_woodallMerged` | modification-free choice of points | without recolouring, a three-colour point with a repeated colour (`c₁ c₃ c₂ c₃`) has a cut set of positive length and no lemma applies to it (F3) |
| the picture | on colour changes | on arcs (every arc through `v` a boundary) | arcs between equal colours are invisible to validity; the colour-change picture makes Woodall's step 1 free |

### 2.3 Validation and the gate on this commit

Spec examples (each fails if its definition drifts): a point of `annSector`; **adversary** the centre is in no annular sector; points of the inner and
outer collars; **adversary** a collar of thickness `≤ 1` misses its own circle; `angleIcc_zero_two_pi`, `coneAt_univ`. Inhabitants:
`ArcMap.const_sectorsAt` (the one-colour plane has the one-sector picture at every point), `const_woodallNormal`, `const_woodallMerged`; **adversary**
`not_woodallNormal_of_repeat` (a three-sector picture with a repeated colour violates `WoodallNormal`). Elaborated with `lake env lean` (lakefile
options passed), no warning; the build runs at stage 3. `Proofs.lean`, `ARCHITECTURE.md` (§ 3.11 row; `tools/check_architecture.py` PASS),
`scripts/Axioms.lean` (section "FS-131 Woodall's chain (job FS131-W) — the foundation", 7 records); `tools/fs131_w_decls.py --check` (7 names, 0
missing) and `--plant` (FIRED, 7 missing).

## Stage 3 — SAVED: the skeleton and the read-backs

### 3.1 The skeleton

Two skeleton modules over the foundation; every leaf `sorry`; elaborated with `lake env lean` (lakefile options) against scratch oleans, only
`sorry` warnings; the build is § 3.4.

| module | declarations (each `sorry`) |
|---|---|
| `Plane/Woodall/Collar` (imports `Woodall/Basic`, `SVMap`) | `isOpen_annSector`, `isPreconnected_annSector`, `isOpen_collar`, `collar_subset_collar`, `exists_collar_of_collarAt`, `exists_unit_pair_collar`, `exists_changePt`, `sphere_meets_of_collarAt`; **`woodall_step4`** (FS106-WO, clause 2); **`not_woodall_step4_two_thirds`** (adversary: Townsend's counterexample); **`townsend_lemma`** (FS106-TW); `collarAt_shadow_outer`, `collarAt_shadow_inner`, `ArcMap.col_not_mem_of_mem_shadow`, `ArcMap.subset_closure_of_subset_shadow` |
| `Plane/Woodall/Steps` (imports `Woodall/Collar`) | `ArcMap.exists_sectorsAt`, `SectorsAt.coloursAt_eq`; `exists_woodallMerged` (step 3); `step5_lt`, `step5_eq_of_condition5`, **`step5_eq` (open: Q1)**; `aeMap6_merged`, `aeMap6_merged_of_condition5`; `step6`, **`step7` (open: Q2)**, `step8`; `exists_three_le_sectors`; `aeMap6_normal`; **`ArcMap.aeMap6`** (FS106-AE-MAP6), `ArcMap.aeMap6_of_condition5`; **`woodall_thm6`** (FS106-WO, clause 1) |

`scripts/Axioms.lean`: section "FS-131 Woodall's chain (job FS131-W) — the skeleton", 31 records; `tools/fs131_w_decls.py --check`: 38 names (7
foundation + 31), 0 missing. `ARCHITECTURE.md` § 3.11: three rows; `tools/check_architecture.py` PASS. `Proofs.lean`: three imports.

**Vacuity.** Every theorem whose hypotheses include `k ≤ 5`, `F.Valid` and `F.IsPlaneMap` concludes `False`: by `aeMap6` itself their domain is
empty, so a non-`False` statement there would be vacuous (the scan skips refutations). This is why steps 3–5's normal form is not a stated lemma:
`aeMap6_merged` folds "merged ⇒ normal ⇒ `False`" (an implementer's private child "merged ⇒ normal" carries `VACUITY DECLARED`, with this reason).
The theorems with non-`False` conclusions quantify over domains the library inhabits: `exists_sectorsAt` and `SectorsAt.coloursAt_eq` (the one-colour
plane, `const_sectorsAt`), `exists_woodallMerged` and `exists_three_le_sectors` (any `k`: `sevenBrickMap`, `sevenBrickMap_valid`,
`sevenBrickMap_isPlaneMap`), `col_not_mem_of_mem_shadow` and `subset_closure_of_subset_shadow` (any valid map). No new vacuity carrier.

### 3.2 The read-backs (each formal statement against its row and against the papers)

| row | formal statement | read-back |
|---|---|---|
| **FS106-TW** (R9: "Townsend's π/3 lemma") | `townsend_lemma` | `[Townsend1979ms]` Thm 1: "Let A0 be a finitely disconnected unit annulus (see Definition 2) for which the unit circle contained in its closure, A, has at least one segment of length greater than ⅓π containing no cut points of A. Then any 2-colouring of A0 contains a monochrome unit." Formal: two open classes `A`, `B` with no unit pair in either (no monochrome unit, region-only: points outside the classes carry no colour — weaker than Townsend's colouring of every point, so stronger); the annulus is read as **a finite set of cut angles `K` off which every angle carries a collar, on either side, inside `closure (A ∪ B)`** (Definition 2's closed doubly connected set: its interior is a band about the circle, possibly one-sided, pinching only at cut points — V3: "one-sided width suffices"); the uncut segment is read as **one side carrying collars about every angle of a closed arc of length `> π/3`**. Differences: (i) generalization: one-sided width, varying side, region-only; (ii) narrowing: Townsend's component over the uncut segment may switch sides, the formal seed may not — every use (`step6`) has a one-sided seed (§ 4's plan for `step6`). The Corollary of Thm 4 ("Every 5-coloured planar map containing a vertex of degree 3 contains a monochrome unit") is `step6` (normal form at the vertex: the repaired form, V3's "regions pairwise sharing an edge"); the Corollary of Thm 3 (four colours) is `aeMap6` at `k ≤ 4`; Thm 2 is not stated (R9: the row's mathematical content is the lemma). The row's bibliographic clauses ("states … with no proof", "Thm 4 itself GAP", "Thm 5 a GAP at (c)") are verdicts on texts, dropped (R9). **Same, read as above** |
| **FS106-WO**, clause 2 ("Woodall's step-4 lemma holds for arcs strictly longer than ⅔π, by lemma (L)") | `woodall_step4` | `[Woodall1973]` p. 198, verbatim: "A set R in the plane is said to be an interior, respectively exterior, unit arc of positive thickness of length φ with center P, if there is an open interval (θ1, θ2) with θ2 − θ1 = φ, and a function f defined on (θ1, θ2) such that f(θ) < 1, respectively f(θ) > 1, for all θ (θ1 < θ < θ2), such that R = {z : arg(z − P) =: θ, θ1 < θ < θ2 and f(θ) < \|z − P\| < 1}, respectively, R = {z : arg(z − P) =: θ, θ1 < θ < θ2 and 1 < \|z − P\| < f(θ)}. The lemma is that an (interior or exterior) unit arc of positive thickness of length ⅔π cannot lie entirely in two of the covering sets." Formal: side `s` (interior/exterior); "of positive thickness" read as **a collar about every angle of `(θ₁, θ₂)`** (true of Woodall's `R` when `f` is locally bounded away from `1`, e.g. upper semicontinuous on the inner side; for an `f` tending to `1` at an inner angle `R` has no thickness there and nothing is claimed); "lie entirely in two of the covering sets" read region-only as "inside `closure (A ∪ B)`", `A`, `B` open with no unit pair; length **strictly** `> 2π/3` (the repair). The adversary `not_woodall_step4_two_thirds` states the printed `⅔π` form false (Townsend's counterexample, V3 stage 1's check) — the mathematics of "step 6 rests on the assertion Townsend's counterexample refutes", the verdict itself dropped (R9). **Same** |
| **FS106-WO**, clause 1 ("Thm 6 (maps need six) … repaired") | `woodall_thm6` | `[Woodall1973]` p. 195: "THEOREM 6. R(b) ≥ 6"; p. 196: "Suppose that the plane is covered by five sets, A, B, C, D and E, which are simultaneously divisible into regions with map M (say), in such a way that no two points that are unit distance apart are in the same set." Formal: `k ≤ 5` colours, an arc map `F` of the plane (inventory item 88: arcs in place of Woodall's Jordan arcs — narrower in the edges; no "regions are Jordan domains" or "G connected" — wider there), `col : ℂ → Fin k` equal to `F.col` at interior points (each region in one set; boundary points in any set), proper at every unit pair. A corollary of `aeMap6`, so its open leaves are `step5_eq` and `step7` (F1, F2). "Repaired" (step 6 by Townsend's lemma) is the route of `step6`. **Narrowed to arc maps (ruled); otherwise same** |
| **FS106-AE-MAP6** | `ArcMap.aeMap6` (and `aeMap6_of_condition5`) | Row: "No map-type colouring (Conditions 2–4) with five colours is almost-everywhere proper, modulo Townsend's simplification (c) as filled by Woodall's steps 2, 3, 5; no step uses 'boundaries of measure 0', which only identifies D-AEMAP with Leb ⊗ σ-a.e. properness." Formal: `F : ArcMap k`, `k ≤ 5`, `F.Valid` (no two interior points of one colour at distance `1` — D-AEMAP, boundaries uncoloured), `F.IsPlaneMap` ⟹ `False`. Conditions 2–4 read as arc maps (item 88: locally finite segments and circular arcs; Condition 2's "every vertex is an endpoint of at least three boundaries" and "regions sharing a boundary have different colours" are not assumed — wider). "Modulo (c) as filled by Woodall's steps 2, 3, 5" is not a hypothesis: the fill is formalized (step 2 free for arcs; step 3 `exists_woodallMerged`; step 5 `step5_lt`, `step5_eq`), and its step-5 equality case is F1's open leaf. No measure enters the statement (the row's last clause). **Same, over arc maps; the proof has two open leaves (F1, F2)** |

**Consumers checked against these forms.** FS111-C-SIX-M, FS111-M2-REDUCE-C, FS129-OR1-TOP5 (wave 9) cite "FS106-AE-MAP6": with `aeMap6` stated
as `∀ F : ArcMap k, k ≤ 5 → F.Valid → F.IsPlaneMap → False`, their REG-I₅ must produce a valid five-coloured arc map of the plane; REDUCE-C's
REG-J′-C₅ (Jordan arcs) needs its interfaces to be segments and arcs (Keryx, item 88, logged for wave 9).

### 3.3 Findings with this stage

Sent at stage 1 (two messages): F1 (step 5's equality case), F2 (step 7's terminal vertex, surviving Condition 5), F3 (TS's reduction), F4
(representation, ruled). New at this stage:
- **G-TW (generalization, small).** Townsend's lemma holds with one-sided collars of varying side, region-only (the formal hypothesis); the seed
  must be one-sided (a narrowing of Townsend's side-switching component, harmless for every use).
- **Vacuity of the chain's intermediate statements.** Every non-`False` statement over valid five-coloured maps of the plane is vacuous by
  `aeMap6`; the normal-form step is folded into `aeMap6_merged` (§ 3.1). A rule for wave 9's consumers too: a composition over "a valid five-coloured
  arc map" is a refutation, never a structure lemma.

### 3.4 The build of this stage

`./scripts/build.sh` under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — 444 of 444 batches, 4 modules rebuilt, 13 with warnings** (the two new
skeleton modules and waves 3–4's; every warning `declaration uses 'sorry'`; the one other line is the up-to-date probe's expected "target is
out-of-date"; `Woodall/Basic` builds with no warning), 8 m 19 s, exit 0 (`build/gate/build/20261004T095859Z-2589972.log`; driver log
`data/fs131/w/build-stage3.log`).
