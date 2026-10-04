# FS131-W — the kernel plan for Woodall's chain: FS106-WO, FS106-TW, FS106-AE-MAP6

*Job FS131-W (de Bruijn, the planner; Opus 5.5), 2026-10-04. Brief `data/fs131/briefs/FS131-W-woodall.md` with `plans/STANDING-RULES.md`, `LEAN.md`
(read in full) and `RUNNING.md` § Building. Worktree `.claude/worktrees/fs131-ww`, branch `fs131-ww`, from wave 4's full skeleton `f620977c`. No fence
in this milestone (inventory ruling 1): the derivation's records were read from the start. Report: `data/fs131/reports/FS131-W.md`.*

## Theorems this phase proved

None (a planning job — FS131-W, and FS131-W2 in stages 6–10). The hand checks recorded below (§ 1.6's two configurations, § 4.5's bound for Townsend's counterexample) are a planner's checks, [hand, one mind], not theorems of this phase.

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

## Stage 4 — SAVED: the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), the plan per leaf, the handoff

### 4.1 What the pass found: four engines from which the contradiction leaves derive

Every contradiction in the chain is one local obligation — **a change point `b` inside an open two-coloured set `W` whose unit circle meets `W`** —
and the global claims differ only in how they find `b`. The engines (the implementer adds them to `Plane/Woodall/Collar` with these statements,
each a child of the leaves named; signatures fixed here, names free):

- **Engine A, the contradiction** (child of `woodall_step4`, `townsend_lemma`, `step5_eq_of_condition5`, `step8`):
  ```lean
  theorem false_of_changePt_landing {A B W : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
      (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) (hW : IsOpen W) (hWAB : W ⊆ closure (A ∪ B)) {u : ℂ} {ρ θ σ : ℝ} (hρ : 0 < ρ) (hρ2 : ρ < 2)
      (hσ : σ = 1 ∨ σ = -1) (hbW : u + (ρ : ℂ) * e θ ∈ W) (hbA : u + (ρ : ℂ) * e θ ∈ closure A) (hbB : u + (ρ : ℂ) * e θ ∈ closure B)
      {s : Rim} (hland : CollarAt W u s (θ + σ * Real.arccos (ρ / 2))) : False
  ```
  Proof: `lemmaL` gives `Disjoint (sphere b 1) W`; `sphere_meets_of_collarAt` gives a point of it. Two lines.
- **Engine B, change points in every band** (child of the same):
  ```lean
  theorem exists_changePt_band {A B : Set ℂ} (hA hB hAu hBu) {u : ℂ} {s : Rim} {θ₁ θ₂ h : ℝ} (hlen : π / 3 < θ₂ - θ₁) (hh : 0 < h)
      (hh1 : h ≤ 1) (hC : collar u s θ₁ θ₂ h ⊆ closure (A ∪ B)) :
      ∃ ρ θ, θ ∈ Ioo θ₁ θ₂ ∧ u + (ρ : ℂ) * e θ ∈ collar u s θ₁ θ₂ h ∧ u + (ρ : ℂ) * e θ ∈ closure A ∧ u + (ρ : ℂ) * e θ ∈ closure B
  ```
  applied to thinner collars (`collar_subset_collar`) it gives change points at radius as close to `1` as wanted. Proof: `exists_unit_pair_collar`,
  `isOpen_collar`, `isPreconnected_annSector`, `exists_changePt`; the radius and angle read from the image (`annSector`'s membership).
- **Engine C, the closed-arc form** (strengthening of `woodall_step4`, Polya's more general statement; child of `woodall_step4` and of
  `step5_eq_of_condition5`):
  ```lean
  theorem false_of_collars_closed {A B : Set ℂ} (hA hB hAu hBu) {u : ℂ} {θ₁ θ₂ : ℝ} (hlen : 2 * π / 3 ≤ θ₂ - θ₁)
      (hcov : ∀ θ ∈ Icc θ₁ θ₂, ∃ s, CollarAt (closure (A ∪ B)) u s θ)
      (hseed : ∃ (s : Rim) (φ₁ φ₂ : ℝ), θ₁ ≤ φ₁ ∧ φ₂ ≤ θ₂ ∧ π / 3 < φ₂ - φ₁ ∧ ∀ φ ∈ Icc φ₁ φ₂, CollarAt (closure (A ∪ B)) u s φ) : False
  ```
  Proof: Lebesgue's number for the cover of `[θ₁, θ₂]` by the collars' angular windows (`lebesgue_number_lemma_of_metric`, `isCompact_Icc`) gives
  `η > 0` such that every angle within `η` of `[θ₁, θ₂]` carries a collar; continuity of `arccos` at `1/2` (`Real.continuous_arccos`; `arccos (1/2)
  = π/3` by `Real.arccos_cos` with `Real.cos_pi_div_three`) gives a band `|ρ − 1| < t` with `|arccos (ρ/2) − π/3| < η`; Engine B gives a change
  point `θ ∈ [φ₁, φ₂] ⊆ [θ₁, θ₂]` in that band; since `θ₂ − θ₁ ≥ 2π/3`, `θ ≤ θ₂ − π/3` or `θ ≥ θ₁ + π/3`, so `θ + α` or `θ − α` lies within `η` of
  `[θ₁, θ₂]`; Engine A. **`woodall_step4` is its corollary** (a closed sub-arc of length `≥ 2π/3`, the seed the same side).
- **Engine D, the bad radii are finite** (child of `townsend_lemma`):
  ```lean
  theorem finite_bad_radii {K : Set ℝ} (hK : K.Finite) :
      {ρ : ℝ | 0 < ρ ∧ ρ < 2 ∧ ∃ κ ∈ K, ∃ κ' ∈ K, ∃ m : ℤ, 2 * Real.arccos (ρ / 2) = κ - κ' + 2 * π * m}.Finite
  ```
  Proof: `2 arccos(ρ/2) ∈ (0, 2π)` (`Real.arccos_pos`, `Real.arccos_le_pi` — strict inside), so for each of the finitely many `κ − κ'` only
  finitely many `m`; `arccos` is injective on `[−1, 1]` (`Real.arccos_injOn`), so finitely many `ρ`. Then `townsend_lemma`: the seed's uniform
  collar (`exists_collar_of_collarAt`), a band avoiding the finitely many bad radii (`t` below every `|ρ_bad − 1|`), Engine B's change point `b`,
  one of its landings off `K + 2πℤ` (else `ρ` is bad), `hcollar` there, Engine A with `W` the union of the two collars.

The **second-order lemma** (child of `step5_eq_of_condition5` and `step6`, statement fixed by the implementer from this description, recorded
back): at a point `v` of an arc map whose picture has an edge in direction `β` between sectors of colours `X ≠ Y`, at the angle `ψ₀ = β ± π/2` (the
normal on the side of the edge's concavity, or either for a segment), **unless the edge is, near `v`, an arc of the unit circle `ω(v + e(ψ₀))`**, a
collar (inner or outer) about `ψ₀` lies in `shadow (region X) ∩ shadow (region Y)`: compare the edge (a segment: curvature `0`; a circle of radius
`r` tangent to `β` at `v`: curvature `±1/r`) with `ω(v + e(ψ₀))` (curvature `1`) — if the edge bends less toward `v + e(ψ₀)`, inner points about
`ψ₀` have circles crossing it (into both sectors), if more, outer points do (wave 4's `tanHeight` frame: `TanAbove`, `TanBelow`, `curvDown` are the
vocabulary; FS110's curvature map is the same computation). Price **M+**.

### 4.2 Measures

No leaf recurses. Two finite searches, each by an extremal choice rather than recursion: `aeMap6_merged`'s horn chain (a zero-angle sector whose
next sector has positive angle exists when any zero-angle sector exists, since the angles sum to `2π`: take it directly, no induction), and
`exists_woodallMerged`'s merges at one vertex (each merge removes at least one sector: the number of sectors at the vertex is the measure; Woodall's
"Let us suppose that we have carried out all the extensions of the above form that are possible").

### 4.3 Smells read

None in the statements. One deliberate shape, recorded: `aeMap6_merged` concludes `False` rather than `WoodallNormal` (§ 3.1, vacuity). The
prove/test/assume partition: **prove** every leaf but `step5_eq` and `step7`; **assume** nothing new (`lebesgue_covering_square`, FS131-LEB's,
through `ts_t`); **test** — the adversary `not_woodall_step4_two_thirds` pins the strictness, the foundation's spec examples pin the definitions.

### 4.4 Mathlib names confirmed with `#check` at the pin (`v4.32.0`, scratch file, 2026-10-04)

`Complex.polarCoord` (an `OpenPartialHomeomorph ℂ (ℝ × ℝ)`), `Complex.polarCoord_symm_apply`, `Complex.polarCoord_target` (`= Ioi 0 ×ˢ Ioo (-π) π`),
`OpenPartialHomeomorph.isOpen_image_symm_of_subset_target`, `Complex.continuousAt_arg` (on `slitPlane`), `Complex.norm_mul_exp_arg_mul_I`,
`Real.cos_arccos`, `Real.arccos_le_pi`, `Real.arccos_pos`, `Real.continuous_arccos`, `Real.sin_arcsin`, `IsPreconnected.image`, `IsPreconnected.prod`,
`isPreconnected_Ioo`, `isPreconnected_closed_iff`, `IsPreconnected.subset_left_of_subset_union`, `IsCompact.elim_finite_subcover`, `isCompact_Icc`,
`lebesgue_number_lemma_of_metric`, `IsCompact.tendsto_subseq`, `Fintype.card_le_of_injective`, `Finite.card_range_le`, `Set.ncard_le_card`,
`Dense.inter_open_nonempty`, `Set.Finite.image`. **Not found**: `Real.arccos_one_half` (use `Real.arccos_cos` with `Real.cos_pi_div_three`),
`Set.ncard_range_le` (use `Finite.card_range_le`). Library vocabulary used: `lemmaL`, `ArcMap.ts_t` (`Plane/SVMap`), `shadow`, `ArcMap.Condition5`
(`Plane/ValidMap/Basic`), `coneAt`, `angleIcc`, `ArcMap.coneAt_region_eq_biUnion`, `ArcMap.finite_tiles_near`, `ArcMap.dense_interiorPts`,
`IsTile.isPreconnected` (waves 3–4).

### 4.5 The plan per leaf (E easy, M moderate, H hard; prices for an agent, to be re-priced from the first two leaves)

**`Plane/Woodall/Collar`**

| leaf | route | children / names | price |
|---|---|---|---|
| `isOpen_annSector` | rotate and translate (`z ↦ u + e c * z`, a homeomorphism) a window `(c − 1, c + 1)` of the angles into `(−π, π)` and take the image of `Ioo r₁ r₂ ×ˢ (window)` under `polarCoord.symm` (`isOpen_image_symm_of_subset_target`; `r₁ ≥ 0` keeps the radii in `Ioi 0`); cover `(θ₁, θ₂)` by such windows | `Complex.polarCoord_symm_apply` (it is `r (cos θ + sin θ i) = r e θ`, `e_eq`) | M |
| `isPreconnected_annSector` | `(isPreconnected_Ioo.prod isPreconnected_Ioo).image _ (by fun_prop)` | `continuous_e` | E |
| `isOpen_collar` | cases on `s`; `isOpen_annSector` with `1 − h ≥ 0` or `1 ≥ 0` | — | E |
| `collar_subset_collar` | cases on `s`; `image_subset` with `prod_mono` of `Ioo_subset_Ioo` | — | E |
| `exists_collar_of_collarAt` | finite subcover of `Icc θ₁ θ₂` by the windows `Ioo (θ − h_θ) (θ + h_θ)` (`IsCompact.elim_finite_subcover`); `h` the minimum (positive, finitely many); a point of `collar u s θ₁ θ₂ h` lies in the window of some `θ_i` and in its thinner band | `collar_subset_collar` | M− |
| `exists_unit_pair_collar` | inner: choose `ρ ∈ (1 − h, 1)` close to `1` with `α = 2 arcsin(1/(2ρ)) < θ₂ − θ₁` (continuity of `arcsin` at `1/2`), points `u + ρ e(θ₁ + ε)` and `u + ρ e(θ₁ + ε + α)`, distance `2ρ sin(α/2) = 1` (`Real.sin_arcsin`; the chord identity `‖e a − e b‖ = 2 |sin((a−b)/2)|`, wave 1's `Plane/Chord`); outer: any `ρ ∈ (1, 1 + h)`, `α < π/3` | `Plane/Chord`'s `ringPt_sub_ringPt` | M− |
| `exists_changePt` | (i) if `W ∩ B = ∅` then `A` is dense in `W` (`W` open, `W ⊆ closure A`), and sweeping gives a unit pair in `A`: `U = A ∩ W ∩ ball x δ` is open non-empty, `shadow U` is open (`⋃ θ, U + e θ`) and contains `y + (a − x)` for `a ∈ U`, within `δ` of `y ∈ W`, so it meets `A` (`Dense.inter_open_nonempty`): contradiction with `hAu`; symmetric for `B`; (ii) `isPreconnected_closed_iff` with the closed sets `closure A`, `closure B` covering `W` (`closure_union`) | `shadow` openness (a child) | M |
| `sphere_meets_of_collarAt` | the point `p = u + e(θ + σα)`, `α = arccos(ρ/2)`, lies on `ω(b)` (`‖e(θ+σα) − ρ e θ‖² = 1 + ρ² − 2ρ cos α = 1`, `Real.cos_arccos`); along `ω(b)`, `t ↦ ‖b + e(φ₀ + t) − u‖²` has non-zero derivative at `t = 0` (`u, b, p` not collinear for `0 < ρ < 2`), so points of `ω(b)` near `p` lie at radius in `(1 − h, 1)` and in `(1, 1 + h)`; their angle is near `θ + σα` (`Complex.continuousAt_arg` after rotating by `e(−(θ + σα))`); so one lies in the collar | an `IntermediateValue`/derivative-sign child, or an explicit second-order expansion | M |
| `woodall_step4` | Engine C's corollary (§ 4.1) | Engines A–C | M− |
| `not_woodall_step4_two_thirds` | `u = 0`, `s = inner`, `(θ₁, θ₂) = (0, 2π/3)`, `R₀ = collar 0 inner 0 (2π/3) (1/100)`, `A = R₀ ∩ ball 1 1`, `B = R₀ \ closedBall 1 1`. Open: yes. **No unit pair in `B`**: a point of `B` has `ρ < 1` and `ρ > 2 cos θ` hence `θ > π/3`, so two points have angles within `π/3` and `d² ≤ ρ₁² + ρ₂² − ρ₁ρ₂ < 1`. **No unit pair in `A`** (all pairs `< 1`, no case split): for `0 ≤ θ₁ ≤ θ₂` with `ρ₂ < 2 cos θ₂`, `cos(θ₂ − θ₁) ≥ cos θ₂`, so `d² ≤ ρ₁² + ρ₂² − 2ρ₁ρ₂ cos θ₂ < ρ₁² + ρ₂²(1 − ρ₁) < ρ₁² + 1 − ρ₁ ≤ 1` [planner's check, one mind; V3 stage 1 verified the counterexample]. `R₀ ⊆ closure (A ∪ B)`: points of `R₀` on `ω(1)` are limits of points of `R₀ ∩ ball 1 1` (`R₀` open). Collars about each `θ ∈ (0, 2π/3)` inside `R₀` (`collar_subset_collar`) | the polar form of points of `R₀` | M |
| `townsend_lemma` | Engine D's route (§ 4.1) | Engines A, B, D; `exists_collar_of_collarAt` | M |
| `collarAt_shadow_outer` | from `hβ` a point `w ∈ R`, `w ≠ u`, `‖w − u‖ = r₀ ≤ c/2` with `cos(arg(w−u) − ψ) > c := cos(β − ψ)/2`; for `z = u + ρ' e ψ'`, `1 < ρ' < 1 + h`, `\|ψ' − ψ\| < h`, `h` small: `‖w − z‖² = r₀² + ρ'² − 2r₀ρ' cos(·) < 1`, so `w ∈ ball z 1`; points of `R` within `ρ' − 1` of `u` (`u ∈ closure R`, `mem_closure_of_mem_coneAt`) lie outside `closedBall z 1`; a preconnected set meeting `ball z 1` and `(closedBall z 1)ᶜ` meets `sphere z 1` (`IsPreconnected.subset_left_of_subset_union` on the two disjoint open sets) | the "preconnected meets the sphere" child | M |
| `collarAt_shadow_inner` | the same with `ρ' < 1`: `u ∈ ball z 1`, and `w` (cos `< 0`) outside `closedBall z 1` for `h` small | as above | M |
| `ArcMap.col_not_mem_of_mem_shadow` | `hzT (F.col z) h` gives `y ∈ region (F.col z)` at distance `1`; `hF` | — | E |
| `ArcMap.subset_closure_of_subset_shadow` | `F.dom = univ ⊆ closure interiorPts` (`dense_interiorPts`); every interior point of `W` has its colour outside `T` | `col_not_mem_of_mem_shadow` | E |

**`Plane/Woodall/Steps`**

| leaf | route | children / names | price |
|---|---|---|---|
| `exists_sectorsAt` | finitely many arcs meet a ball about `v` (`locallyFinite`); shrink it to the arcs through `v`; each leaves `v` in one or two tangent directions and stays within angle `O(r)` of them at distance `r` (segments exactly; circles by curvature); sort the tangent directions; truncated sectors strictly between consecutive directions miss `Γ`, are preconnected, so lie in one tile (`IsTile`) and one colour; between two arcs tangent at `v` the horn is one tile; the cone equation from `coneAt_region_eq_biUnion` (wave 3); merge adjacent equal colours | wave 3's `finite_tiles_near`, `germ_dichotomy`, `coneAt_region_eq_biUnion`, `exists_mem_coneAt_region`; `Arc.isCompact_carrier` | **H** (the largest foundation leaf; a child per bullet) |
| `SectorsAt.coloursAt_eq` | `j ∈ coloursAt v ⟺ v ∈ closure (region j) ⟺ coneAt (region j) v ≠ ∅` (⟸ `mem_closure_of_mem_coneAt`; ⟹ compactness of the circle of directions, or `v ∈ region j` and then every direction) `⟺ j ∈ range c` (the cone equation; `angleIcc a b ≠ ∅` for `a ≤ b`) | — | M− |
| `exists_woodallMerged` | Woodall's step 3 as a simultaneous local modification: at each point `P` with a repeated colour on a sector of positive angle, (i) the **clearness lemma**: a run of sectors of total angle `< π` between two sectors `X`, `Y` of colour `c` has, within some `ε`, no point at distance `1` from a point of colour `c` (every unit circle through such a point not through `P` crosses `X` or `Y`; region-only, the circles through `P` handled by perturbing within the open run), and the clear sets of distinct vertices are clear of each other; (ii) Woodall's cone (two horns of one colour in the cusps outside two unit discs tangent at `P`) is filled; (iii) radii `ε(P)` small enough that the discs are disjoint and locally finite; (iv) the new map: arcs of `F` outside the discs, the circles of radius `ε(P)`, the colour changed on the runs; valid, plane, locally finite; Condition 5 kept (the new arcs have radius `< 1`); (v) `WoodallMerged` for it at old vertices (each repeated pair now has both runs of angle `≥ π`, hence both sectors of angle `0`) and at the new vertices on the small circles (three distinct colours, angles near `π, π/2, π/2`) | `SectorsAt` of the new map at every point (via `exists_sectorsAt`) | **H+** — plausibly a separate implementer's job by itself |
| `step5_lt` | the inner arc opposite sector `i` (directions `β₁ = d i.castSucc`, `β₂ = d i.succ`): for `ψ` in a compact sub-arc `J` of `I = (β₂ − 3π/2, β₁ − π/2)` of length `≥ 2π/3` (possible: `\|I\| = π − φ > 2π/3`), each of the three colours has a tile at `v` with a cone direction `β` in the open half `(ψ + π/2, ψ + 3π/2)` (`β₁ − δ` for the previous sector, `β₂ + δ` for the next, a direction of sector `i`; a horn's own direction) — `collarAt_shadow_inner` on those tiles, the minimum of the three collars, `subset_closure_of_subset_shadow` (two colours left, `k ≤ 5`), `woodall_step4` with `s = inner` | a child `SectorsAt.neighbour_dirs` (the previous sector ends at `β₁`, the next starts at `β₂`, through the `Fin` wrap and the `2π` shift) | M |
| `step5_eq_of_condition5` | as `step5_lt` on the open arc of length exactly `2π/3`, plus at each end `ψ₁`, `ψ₂` the second-order lemma (§ 4.1; Condition 5: no edge is a unit arc) for a collar about the end; Engine C with `[ψ₁, ψ₂]` and the inner seed over a closed sub-arc of length `> π/3` | second-order lemma; Engine C | M+ |
| `step5_eq` | **open** — § 1.6 Q1 (FS131-E1). Leave `sorry`; the implementer does not attempt it | — | — |
| `aeMap6_merged` | at a picture with `n ≥ 3` (`hM`): if some sector has angle `0`, one whose next sector has positive angle exists (the angles sum to `2π`); its neighbours' colours differ (the next one's colour is not repeated, by `hM`), so `step5_lt` kills it; hence no zero-angle sector, so no repeated colour (`hM`), so `c` injective; then every sector's neighbours have distinct colours, and `step5_lt`, `step5_eq` give every angle `> π/3`: `WoodallNormal` (a private child, `VACUITY DECLARED`, § 3.1); `aeMap6_normal` | `step5_lt`, `step5_eq`, `aeMap6_normal` | M |
| `aeMap6_merged_of_condition5` | the same with `step5_eq_of_condition5` | — | E (after `aeMap6_merged`) |
| `step6` | the three colours' cones are the three closed sectors; the first-order presence sets (inner collar about `ψ` when every sector meets the open half opposite `ψ`; outer when every sector meets the open half about `ψ`) cover every angle except the at most six normals to the three edges (two adjacent sectors are separated only by their common edge's line); `K` = those normals; `hcollar` from `collarAt_shadow_inner`/`_outer` on tiles and `subset_closure_of_subset_shadow`; the seed: some angle `φ < 2π/3` gives a one-sided arc of length `π − φ > π/3` (first order, a closed sub-arc); if all three angles are `2π/3`, a switching normal that is not a cut (at most three edges are unit arcs centred on `ω(v)`, so at least three of the six normals are not) carries a collar by the second-order lemma, extending the adjacent one-sided arc past `π/3`; `townsend_lemma` | second-order lemma; `collarAt_shadow_*`; `townsend_lemma` | **H−** |
| `step7` | **open** — § 1.6 Q2 (FS131-E1). Leave `sorry` | — | — |
| `step8` | `φ_b` the smallest angle (`π/3 < φ_b ≤ 2π/5`), the inner arc opposite `b` of length `π − φ_b ≥ 3π/5` coloured by the two colours `D, E` outside `{A, B, C}` (`step5_lt`'s set-up); Engine B gives change points in every thinner band; Engine A forbids a landing in the arc, so their angles lie in the window `[ψ₂ − π/3 − o(1), ψ₁ + π/3 + o(1)]`; a limit point `Q ∈ ω(v)` (`IsCompact.tendsto_subseq`) lies in `closure (region D) ∩ closure (region E)`; outside `ω(v)` near `Q` only `B` (each of `a, c, d, e` has a tile with a cone direction in the open half about the window's angles, by `φ_x > π/3` and `φ_b ≤ 2π/5` — the angle arithmetic of § 1.6's Q2 paragraph; `collarAt_shadow_outer`); interior points there exist (density) and carry `B`; so `coloursAt Q = {B, D, E}`; the picture at `Q` (`exists_sectorsAt`), normal (`hN`): `n = 3` (`coloursAt_eq`, injective); `step6` at `Q` | Engines A, B; `IsCompact.tendsto_subseq`; `step6` | **H−** |
| `exists_three_le_sectors` | `ts_t hF hP v (ε := 1)` gives `x` with `3 ≤ (coloursAt x).ncard`; `exists_sectorsAt hP x`; `coloursAt_eq` and `Finite.card_range_le` give `3 ≤ n` | `ArcMap.ts_t` (over `lebesgue_covering_square`, FS131-LEB) | M− |
| `aeMap6_normal` | `exists_three_le_sectors`; `hN` gives `c` injective, so `n ≤ k ≤ 5` (`Fintype.card_le_of_injective`); `interval_cases n`: `step6` (with `hN`'s angles), `step7`, `step8` | — | M− |
| `aeMap6` | `exists_woodallMerged`, then `aeMap6_merged` on the new map | — | E |
| `aeMap6_of_condition5` | the same, `aeMap6_merged_of_condition5` (Condition 5 kept by `exists_woodallMerged`) | — | E |
| `woodall_thm6` | `F.Valid` from `hproper` and `hdiv`; `ArcMap.aeMap6` | — | E |

### 4.6 Re-pricing

15 leaves in Collar (all priced E–M; Engines A–D add four children), 16 in Steps of which 2 are open (`step5_eq`, `step7`) and 1 is out of the
implementer's range in one context (`exists_woodallMerged`, H+). The held route under Condition 5 depends on `exists_sectorsAt` (H),
`exists_woodallMerged` (H+), `step6` and `step8` (H−) and the second-order lemma (M+); everything else is moderate. A plan's table prices high
(`LEAN.md` § The kernel's cost model): re-price from the first two leaves of each module.

### 4.7 The handoff to the chain's implementer (the form of `plans/FS131-w4-kernel-plan.md` § 14)

**Where it is.** Branch `fs131-ww` (this stage's commit on top of `630018e5`), worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww`
(`.lake/packages` a symlink to the main tree's, `.lake/build` its own copy — never replace it with a symlink). The branch sits on wave 4's full
skeleton `f620977c`. Three modules: `Plane/Woodall/Basic` (sorry-free), `Plane/Woodall/Collar` (15 `sorry` leaves), `Plane/Woodall/Steps` (16,
two of them open). The build is green with only `sorry` warnings (`build/gate/build/20261004T095859Z-2589972.log`). `Proofs.lean`, `ARCHITECTURE.md`
and `scripts/Axioms.lean` are updated; `tools/fs131_w_decls.py --check` lists and checks the 38 records.

**The build**: from inside the worktree, `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. For iteration, `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false`, against scratch oleans for
the new modules (mirror `.lake/build/lib/lean/Proofs` with `cp -rs`, write each new module's olean there with `lean -o`, the scratch first on
`LEAN_PATH`) — never as evidence.

**Dependencies not yet landed.** Waves 3 and 4 (`Plane/LocalStructure`, `Plane/SVMap`'s `lemmaL`, `ts_t`, …) are skeletons on their branches:
this chain cites their statements as committed at `f620977c`; merge their branches in when they land, or earlier to use their proofs while
iterating, resolving the append-only lines of `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`. `lebesgue_covering_square` is FS131-LEB's.

**The order**: the Collar foundation leaves (`isPreconnected_annSector`, `isOpen_collar`, `collar_subset_collar`, then `isOpen_annSector`,
`exists_collar_of_collarAt`) — the first two re-price the module; then `exists_unit_pair_collar`, `exists_changePt`, `sphere_meets_of_collarAt`; the
engines A, B, C, D (§ 4.1); `woodall_step4`, `townsend_lemma`, the adversary; the shadow lemmas. Then Steps: `coloursAt_eq`, `exists_sectorsAt`,
`step5_lt`, `aeMap6_normal`, `aeMap6_merged`, `exists_three_le_sectors`, the corollaries; then the second-order lemma, `step6`, `step8`,
`step5_eq_of_condition5`; `exists_woodallMerged` last (re-price it first; ask Keryx for a separate job if it outgrows the context).

**What the implementer may and may not change.** It may add children anywhere (the engines of § 4.1 with their signatures, the second-order lemma
with its statement recorded back, `SectorsAt.neighbour_dirs`, the private "merged ⇒ normal" with `VACUITY DECLARED`), supporting lemmas in the
foundation modules (statements of other waves unchanged), and imports (updating `ARCHITECTURE.md` and `scripts/Axioms.lean`, then
`tools/fs131_w_decls.py --check`). It may not change any statement of § 3.1's table or any definition of `Plane/Woodall/Basic`; `step5_eq` and
`step7` stay `sorry` until FS131-E1 reports (their statements may change then, through the planner). A statement that cannot be proved as written
comes back through Keryx with the stuck goal or the counterexample.

**Vacuity and inhabitants** (§ 3.1): every theorem over valid five-coloured maps of the plane concludes `False` (skipped by the scan); the others
are inhabited by `const_sectorsAt` and the brick map (`sevenBrickMap`, `sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`). No new carrier for
`scripts/Vacuity.lean`: `SectorsAt` and `WoodallNormal`/`WoodallMerged` appear only as hypotheses of refutations or with inhabitants beside them.

**How the chain lands.** It cannot land on `main` with `step5_eq` and `step7` open (nothing with a `sorry` reaches `main`). Two ways, Keryx's call
when the rest is green: (a) wait for FS131-E1; (b) land the held part — `Woodall/Basic`, `Woodall/Collar` and the Steps leaves other than
`step5_eq`, `step7`, `aeMap6`, `aeMap6_of_condition5`, `aeMap6_merged*`, `aeMap6_normal`, `woodall_thm6` — with the open statements taken as named
hypotheses of the three theorems (our own unproved results enter as hypotheses, `LEAN.md` § Assumptions), i.e. `aeMap6` restated over
`(h5eq : …) (h7 : …)`; that is a statement change and goes through the planner.

## Stage 5 — SAVED: drafts for the files Keryx writes, and the report

**Drafts** (standing rule 7; each names its slot):
- `CLAUDE.md` § The aim, link 4, after "Maps need six: `[Woodall1973]` Thm 6 and Townsend's manuscript, each repairing the other (`[Townsend1981]`
  prints no proof)": add "— the repair has two steps open, found at its formalization (FS131-W): Woodall's step 5 at angle exactly `π/3` when both
  edges are unit arcs, and step 7's terminal point when it carries two colours (FS131-E1)".
- `LEDGER.md` row 132, the clause on maps needing six: the same two open steps, with `plans/FS131-W-kernel-plan.md` § 1.6 as the address.
- `BIBLIOGRAPHY.md` `[Woodall1973]`, reading status: "§ 3 re-read in full from the page images (FS131-W, 2026-10-04): every constant of steps 2–8
  read from the image; step 5 reads `φ ≤ ⅓π`, `π − φ ≥ ⅔π` (the text layer drops the signs, and FS106-V3's 'strict inequalities' rests on it)".
- `BIBLIOGRAPHY.md` `[Townsend1979ms]`: "re-read in full, text layer (FS131-W, 2026-10-04)".
- `plans/FS106-derivation.md` FS106-WO's proof line (the derivation's errata, Keryx's or FS131-E1's to file): "Step 5's inequalities are `≤`/`≥` on
  the page image, not strict (FS131-W § 1.4 F1); step 7's 'e must terminate … by meeting a vertex' fails when the terminal point carries two colours
  (F2)".

The report is `data/fs131/reports/FS131-W.md`; its text is the job's hand-back.

---

*Stages 6 on: job **FS131-W2** (de Bruijn, the planner; Opus 5.5), 2026-10-04 from 10:55 UTC. Brief `data/fs131/briefs/FS131-W2-woodall-replan.md`
(on `main`) with `plans/STANDING-RULES.md` and `LEAN.md`, read in full, and `RUNNING.md` § Building. Resuming check (standing rule 2): this record's
last SAVED stage is 5, matching `git log` (`9b82b6e4`, then `7aaaf2c4` the report's commit list); W2 continues at stage 6 and redoes nothing saved.
Same worktree and branch (`fs131-ww`). Report: `data/fs131/reports/FS131-W2.md`. Working files: `data/fs131/w2/`.*

## Stage 6 — SAVED: FS131-W2's readback

### 6.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "waits for FS131-E1. If E1 closes the GAPs, the chain lands unconditionally; if not, it lands with the open steps as named propositions — hypotheses of" | `plans/FS131-close-inventory.md` (main) item 98 | **matches** verbatim (a prefix-cut substring of the item; the brief says so with "that ruling is item 98") |
| E1-NO45's statement ("in a five-colour almost-everywhere-proper arc map in Woodall's normal form, no point lies on the boundary of exactly four or exactly five sectors") | `plans/FS131-E1-derivation.md` § 3.6, `statement:` line | **matches** |
| E1-NOBRANCH's statement ("in an almost-everywhere-proper arc map satisfying (N1), with any finite number of colours, some point lies on the boundary of three or more sectors") | § 3.7, `statement:` line | **matches** |
| E1-MAPS6's statement ("no five-colour almost-everywhere-proper arc map in Woodall's normal form exists") | § 3.8, `statement:` line | **matches** |
| E1-NO45's handoff ("de Bruijn — replaces the open leaves `step5_eq` and `step7` (and the held step 8, which is no longer needed) …") | § 3.6, `handoff:` line | **matches** |
| E1-NOBRANCH's handoff ("de Bruijn — the last step of FS106-AE-MAP6 over ArcMap; it needs the Jordan curve theorem for arc curves …") | § 3.7, `handoff:` line | **matches** |
| items 106–107 (glossed: E1-NO45 at one mind; Kooshi asked about a blind second mind; the kernel the default second check) | inventory items 106, 107 | the glosses agree ("**Held for Kooshi**: a blind second mind on E1-NO45 before de Bruijn formalizes it, or the kernel as the second check (Workflow 3.1's default)") |

No mismatch; no finding about the brief.

### 6.2 The chain as E1 restores it

> In such a map every boundary point has two to five sectors (N1, five colours). Step 6 excludes three, E1-NO45 excludes four and five, so there is no
> branch point, against E1-NOBRANCH. ∎
> — source: `plans/FS131-E1-derivation.md` § E1-MAPS6, the argument

> uses only: (N1), which bounds the sectors at a point by five; step 6 (FS106-WO, held: no point of three sectors); E1-NO45 (none of four or five); E1-NOBRANCH; and through E1-NO45, strict step 5
> — source: § 3.8, E1-MAPS6's `uses only:` line

with E1-NO45's lemmas E1-SEE (§ 3.1), E1-RAY (§ 3.2), E1-CROSS (§ 3.3), E1-COVER (§ 3.4), E1-BAD (§ 3.5), and E1's normal form (§ 3.0): **(N1)** at
every boundary point the sectors carry pairwise distinct colours; **(N2)** at every branch point every sector has angle at least `π/3` (strict step 5).
So, on W's skeleton: FS106-AE-MAP6 = step 3 (`exists_woodallMerged`) + strict step 5 (`step5_lt`, giving the normal form with angles `≥ π/3`) + step 6
(`step6`) + E1-NO45 + E1-NOBRANCH. No step reads an angle equal to `π/3` (E1-Q1's handoff), and nothing of Woodall's steps 7–8 is used.

### 6.3 W's leaves (§ 4.5): what stays, goes, or changes

| leaf (W's § 4.5) | fate | why |
|---|---|---|
| every leaf of `Plane/Woodall/Collar` (15), and Engines A–D (§ 4.1) | **stay** | `woodall_step4` (Engine C), `townsend_lemma` (Engines A, B, D) and the shadow lemmas are still consumed (step 5, step 6) |
| `exists_sectorsAt`, `SectorsAt.coloursAt_eq`, `exists_woodallMerged`, `step5_lt`, `aeMap6`, `woodall_thm6` | **stay** | unchanged statements and routes |
| `step5_eq` (open, Q1) | **goes** | E1-Q1: no step of the restored chain reads an angle equal to `π/3` |
| `step7` (open, Q2), `step8` | **go** | replaced by E1-NO45 (E1-Q2; step 8 "no longer needed") |
| `step5_eq_of_condition5`, `aeMap6_merged_of_condition5` | **go** (W2's decision) | they served only `aeMap6_of_condition5`, which becomes a corollary of `aeMap6` (E1-MAPS6's handoff: "the Condition-5 form becomes a corollary"); nothing else consumes them |
| `ArcMap.WoodallNormal` (definition, `Woodall/Basic`) | **changes**: angles `π/3 ≤`, not `π/3 <` | E1's (N2) is "at least `π/3`" (strict step 5 only); the strict form needed `step5_eq` |
| `step6` | **changes** its hypothesis `hang` to `π/3 ≤` | it is now applied at a point of E1's normal form (angles `≥ π/3`); W's route for it reads only positivity and one angle `< 2π/3` (§ 4.5's row), so the weaker hypothesis costs nothing |
| `aeMap6_merged` | **changes** its route | merged ⇒ normal by `step5_lt` alone (W's horn chain, minus `step5_eq`) |
| `aeMap6_normal` | **changes** its route | degree 3: `step6`; degrees 4–5: E1-NO45 (in place of `step7`, `step8`) |
| `aeMap6_of_condition5` | **changes** its route | `aeMap6` (Condition 5 unused); statement unchanged |
| `exists_three_le_sectors` | **stays**, read back as **E1-NOBRANCH** | § 7.4 (the Jordan decision) |
| the second-order lemma (W's § 4.1, unstated, priced M+) | **changes**: stated, in its refined form | it now also carries E1-BAD's edge case (§ 7.2) |

### 6.4 The worktree builds as W left it

At `7aaaf2c4`: `./scripts/build.sh` under the slot (40 GiB, 8 cpus, `BATCH=4`), from inside the worktree: **OK — all 1744 modules already up to date,
nothing built, 13 module(s) with warnings**, 2 s, exit 0 (`build/gate/build/20261004T111525Z-3004683.log`; driver log `data/fs131/w2/build-stage1.log`).

## Stage 7 — SAVED: E1's argument read line by line (§§ 3.0–3.8), as the mind that formalizes it

Read: `plans/FS131-E1-derivation.md` §§ 1.3 (the normal form's reading), 3.0–3.10, 4.1–4.2, and the controls' tools (`tools/fs131_e1_count.py`
read in full). Message sent to the coordinator at this stage ("FS131-W2: E1's argument read …", 2026-10-04): items 7.1–7.4 below.

### 7.1 Step by step

| E1 entry | step | survives formalization? |
|---|---|---|
| E1-SEE (§ 3.1) | translate a disc of `q`'s region by `z − Y` | **yes**; it is wave 1's `dist_ne_one_of_mem_of_mem_closure` (FS129-SR2-CLOSURE) with `Valid.unitPairsNull_region` (`Plane/Tiles`): a three-line corollary |
| E1-RAY (§ 3.2) | the explicit root of the ray–circle equation | **yes**; it is W's `collarAt_shadow_inner/_outer` applied to a truncated sector (`SectorsAt`'s fifth clause), whose cone at `v` holds its open directions |
| E1-CROSS (§ 3.3) | a direction with `cos(γ − ψ) ≠ 0` in a sector of positive angle; E1-RAY; D-AEMAP | **yes**, read on colour classes (the argument reads no connectedness of `R`) |
| E1-COVER (§ 3.4) (a) | arc-end types I/O/A at a non-branch point of `ω(P)` | **not needed**: replaced by a colour-class lemma (7.3 (a)): at a point of `ω(P)` with at most two colours where no colour crosses, near it every interior point inside `ω(P)` has one colour `A` and every one outside another `B` (density of interior points, finitely many colours) |
| E1-COVER (c) | "a point of `Γ′` in the closures of two E regions would carry two sectors of colour E … against (N1)"; connectedness gives one E region | **fails in W's model** (two tiles of one colour may meet across an arc there, 7.2); **not needed**: one colour class suffices (7.3 (a)) |
| E1-COVER (d) | the intermediate value of `|x − ·|` on one connected region | **replaced** by: a connected subset of the closure of an open set with no unit pair has every two points at distance `≤ 1` (7.3 (a)) — the same argument with `z ∈ U` near `x` in place of `x ∈ R` |
| E1-COVER (e) | "at least six" | **replaced** by the pigeonhole downstream: at most five exceptional angles leave an open arc of length `2π/5 > π/3` free of them |
| E1-BAD (§ 3.5), the dichotomy | each branch of `ω(Y)` runs, near `P`, in one sector unless an edge lies on `ω(Y)` | **yes in E1's model**; in W's model it needs the arc-level (N1)/(N2) (7.2) and is replaced by the refined second-order lemma (7.3 (b)) |
| E1-BAD, "Counting" | "only for the one of these two on `s`'s side (the branches lie on `Y`'s side of the line through the two edges)" | **FALSE** — 7.4; the statement's count survives as a total |
| E1-NO45 (§ 3.6) | angles `≤ π` from `≥ π/3` at four or five sectors; E1-BAD; E1-COVER; E1-SEE; (N1); step 6 | **yes**, with E1-BAD's count recounted (7.4): at most `k` exceptional points, not `k + 1` |
| E1-NOBRANCH (§ 3.7) | regions of diameter `≤ 1`; a nested sequence of boundary curves by the Jordan curve theorem | **not formalized as argued**: its conclusion is W's `exists_three_le_sectors` from wave 4's `ts_t` (7.5) |
| E1-MAPS6 (§ 3.8) | degrees 2–5; step 6, E1-NO45, E1-NOBRANCH | **yes** (W's `aeMap6_normal` with `step7`, `step8` replaced) |

### 7.2 E1's caveats checked against W's definitions

**(N1) per sector, and (N2)'s "no two edges at a branch point leave it in one direction"** (§ 3.0, § 3.10's fifth attack). W's `ArcMap.SectorsAt` is
the picture *on colour changes* (§ 2.1): adjacent sectors of one colour are merged, so an arc of `F` with one colour on both sides (an *invisible* arc)
is not seen by the picture, and several arcs may leave a point in one direction (a horn inside a colour, or an invisible arc tangent to an edge).
`WoodallNormal` (every picture with at least three sectors has injective colours and angles `≥ π/3`) gives E1's (N1) **for colours** — no colour on two
sectors at a point of three or more — but not for arcs. E1-NO45 reads the arc-level form at two steps:
- E1-COVER (c) (above): **not needed** (7.3 (a)).
- E1-BAD's "one exceptional point per edge": in W's model it fails — at an edge direction `β` of `P` between `X` (below) and `Y` (above), a visible
  edge on `ω(P + e(β − π/2))` and an invisible unit arc on `ω(P + e(β + π/2))` bounding a cusp of `Y` make both normals exceptional in E1's exact
  sense. **Not needed**: 7.3 (b) counts at most one bad normal per edge direction in W's model, with no arc-level hypothesis.

So the formal E1-NO45 needs **no hypothesis beyond W's `WoodallNormal`** (with `π/3 ≤`). No hidden hypothesis; no statement defect.

**"The argument reads the arc-map form at three places"** (§ 3.6's *not claimed*): arc-end types (not read on this route), tangent curves meeting
once (read at `P`'s edges, in the second-order lemma), finiteness (read at `P`: finitely many arcs tangent to an edge; and of colours). **The arc-map
form is read only at the point of four or five sectors** — and in step 6 only at the point of three: a finding for the Jordan-boundaries stub
(item 107's "stub to mint"): the obstacle is local to vertices.

### 7.3 The two replacements (the routes the skeleton states)

**(a) E1-COVER on colour classes.** For a point `v` whose picture has positive angles and at most one colour `E` absent, and an open arc
`(θ₁, θ₂)` of `ω(v)` on which every point carries at most two colours:
1. *crossing*: a colour whose class has `v + e θ` in the closure of its part inside `ω(v)` and of its part outside is absent from `v` (E1-CROSS);
2. *non-crossing points* (`NC`): at most two colours and no crossing give `r > 0` and `A ≠ B` with every interior point of `B(v + e θ, r)`
   inside `ω(v)` coloured `A`, outside coloured `B`, none on `ω(v)`; so the colours there are `{A, B}`;
3. *the clopen argument*: `T = {θ : NC(θ) ∧ E ∉ coloursAt (v + e θ)}` is open (item 2's radius) and closed in `(θ₁, θ₂)` (a limit of points of `T`
   with colours `{A, B}` carries `A`, `B`, and — off `T` — `E`: three colours); its complement is `{θ : E ∈ coloursAt}` (a crossing colour is `E`). So
   `T = ∅` (every point in the closure of `E`'s class) or `T` is everything (the inside colour is locally constant, hence constant `X`): **one colour
   class `X` has every point of the arc in its closure**;
4. *diameter*: a connected subset of `closure U`, `U` open with null unit pairs, has every two points at distance `≤ 1` (for `x, y` at distance
   `> 1`, a point `z ∈ U` near `x` sees the value `1` of `dist z ·` on the subset, at a point of `closure U` — wave 1's
   `dist_ne_one_of_mem_of_mem_closure` forbids it); a closed sub-arc of length in `(π/3, π]` has chord `> 1`.
Neither (N1) on `ω(v)`, nor the normal form, nor five colours is read: **E1-COVER in E1-GEN6's form, region-only off `v`** (a generalization,
messaged).

**(b) E1-BAD's edge case: the refined second-order lemma.** At an edge direction `β` of a picture with positive angles, between `X` (the sector
before) and `Y` (the sector after): finitely many arcs of `F` through `v` are tangent to `β` (local finiteness), each the circle (or line) of some
upward curvature `κ ∈ K` (`tanHeight`'s frame); for `κ ∉ K` the points of the tangent circle `C_κ` near `v` on the `β` side are interior points of one
tile, of colour `f(κ) ∈ {X, Y}` (the only colours whose cone holds `β`). The unit circle about `v + e(β + π/2)` is `C_1`, about `v + e(β − π/2)` is
`C_{−1}`. For `z` in a thin inner collar about `β + π/2`, `ω(z)` meets `X` (first order) and, in the tangential regime, every tile `f(κ₀)`, `κ₀ < 1`
(its effective curvature sweeps `(−∞, 1)`; in the transversal regime it crosses the whole tangent bundle and meets `X` and `Y`); for an outer collar,
`Y` and every `f(κ₀)`, `κ₀ > 1`. So the normal `β + π/2` is **bad** (no two-colour collar on either side) only if `f ≡ X` on `(−∞, 1) ∖ K` and
`f ≡ Y` on `(1, ∞) ∖ K`; the normal `β − π/2` only if `f ≡ X` on `(−∞, −1) ∖ K` and `f ≡ Y` on `(−1, ∞) ∖ K`. Both force `X = Y` on `(−1, 1) ∖ K`.
**At least one normal of every edge is good** — no (N1), no (N2), no injectivity read. At a good normal the kill follows: the collar's side
`s` and the first-order collar on the other side (E1-RAY) put one of `X`, `Y` in the shadow on both sides, so its class misses a punctured
neighbourhood of the normal point and the colour is absent there. (W's § 4.1 form "unless the edge is a unit arc centred there" is true per normal
but allows two bad normals per direction in W's model; the refined form is what the count needs, and it serves `step6` equally: one good normal
per edge.)

### 7.4 The finding on E1-BAD's count (messaged; correction owed to E1-BAD's argument, no statement change)

E1-BAD's "Counting": "A sector `s` of angle `π` with edges at `σ, σ + π` contains both branches only if `ψ ± π/2 = σ, σ + π`, so
`Y = P + e(σ ± π/2)`, and only for the one of these two on `s`'s side (the branches lie on `Y`'s side of the line through the two edges)". **False**:
the region of `s` near `P` is bounded by the two edges, which may curve to `Y`'s side. Counterexample: `P = 0`, the edges of `s` the two arc-ends at
`P` of the circle `C` of radius `1/2` about `(0, −1/2)`, `s` outside `C`; both `Y₊ = (0, 1)` and `Y₋ = (0, −1)` have both branches of `ω(Y)` in `s`
(`ω(Y₋)`'s points `(sin t, −1 + cos t)` satisfy `|w − (0, −½)|² = 5/4 − cos t > 1/4`). Exact check: `tools/fs131_w2_bad_pi.py` → `Y+: in_s=10/10
Y-: in_s=10/10 both_exceptional=True` (exit 0); `--fault` (radius 2, curvature `1/2 < 1`) → `Y-: in_s=0/10 … both_exceptional=False` (exit 1). **The
statement survives** as a total count, and E1-NO45 with it: the second-kind points of a `π`-sector `[a, a + π]` are among `P + e(a ± π/2)`, the
normals of its two edges, among which the two edges' unit-arc centres also lie; so the exceptional set has at most `k` points (`≤ 4` at `k = 4`,
`≤ 5` at `k = 5`; E1 wrote `k + 1 = 5` at `k = 4`). Control e1-count's model ("(ii) one per sector of angle exactly π") has the wrong reason and a
correct upper bound. A draft for E1's record, for Keryx to file (slot: `plans/FS131-E1-derivation.md` § E1-BAD, the argument, after "one `Y` per such
sector. ∎"): *"Erratum (FS131-W2): 'only for the one of these two on s's side' is false — the edges may curve to Y's side (FS131-W2 § 7.4, with
`tools/fs131_w2_bad_pi.py`); a π-sector can carry two exceptional points, both normals of its two edges, among which those edges' unit-arc centres
lie; the total count `≤ (edges) + (π-sectors)` stands, and E1-NO45's bound improves to `k`."*

### 7.5 The Jordan curve theorem, decided: not needed (Done item 4)

E1-NOBRANCH's conclusion — a point of at least three sectors — is W's **`exists_three_le_sectors`**, planned in § 4.5 from wave 4's **`ArcMap.ts_t`**
(FS106-TS-T: a point of at least three colours within `1/√2 + ε` of every point), which rests on **`lebesgue_covering_square`** (Lebesgue's covering
theorem for the square, FS131-LEB's disposition, inventory item 66). The chain already depended on it; routing E1-NOBRANCH through it adds no outside
theorem. Alternatives weighed: (i) the Jordan curve theorem for closed curves of segments and circular arcs, formalized here — not in Mathlib, and
E1's argument needs with it the interior/exterior of each frontier curve and their nesting, a job of its own (several hours to a day of agent work,
unmeasured); (ii) an imported `axiom` — a second outside theorem where one (Lebesgue's) already carries the same plane topology; (iii) E1's
diameter step in collar language alone cannot suffice: "a valid map has a point of three colours" is false on the line (unit intervals two-coloured),
so some two-dimensional topology must enter, and the plan's is Lebesgue's. **Decision: (iv), `ts_t`.** E1-NOBRANCH is read back as
`exists_three_le_sectors` (§ 8), which is stronger (no (N1) read: a picture of `≥ 3` sectors exists in any valid map of the plane, any `k`).

### 7.6 Hand checks of this stage (planner's checks, one mind)

The refined second-order dichotomy (7.3 (b)) on three configurations: one straight edge (`K = {0}`: `β + π/2` good, inner side); a visible edge at
`κ = −1` with an invisible unit arc at `κ = 1` (W's-model counterexample to E1's exact count: `β − π/2` bad, `β + π/2` good, inner side); an
alternation `X | Y | X | Y` at `κ = −1, 0, 1` (both good). The angle arithmetic of E1-NO45 (`≥ π/3` at `n ≥ 4` gives `≤ π`, at most one `π`-sector,
none at `n = 5`), and the distinctness of the two kills off `K` (7.3; § 9's plan for E1-BAD).

## Stage 8 — SAVED: the domain-modeling pass (`debruijn-domain-modeling`, invoked fresh) and the skeleton changed

### 8.1 The model, and why this shape

**The intrinsic structure.** Every step of E1-NO45 ends in one atomic fact: *a colour `j` is absent at a point `Y = v + e ψ` of `ω(v)`*
(`j ∉ F.coloursAt Y`). Two mechanisms produce it, and nothing else: **exact** — an interior point of colour `j` at distance exactly `1` from `Y`
(E1-SEE); **robust** — an inner and an outer collar about `ψ` both in the shadow of `j`'s class (the class then misses a disc about `Y`). The
first-order mechanism (E1-RAY) and the second-order one (the parabola lemma) only manufacture collars. E1-COVER is the dual statement: along a
branch-point-free arc, one class has every point in its closure, and a connected subset of a closure cannot be longer than `1`. So the
vocabulary needed is the library's (`coloursAt`, `shadow`, `CollarAt`, `SectorsAt`) plus one predicate, `CrossesAt`.

**Incidental, and stripped:**
- *Regions (tiles) in place of colour classes.* E1 argues with one connected region at three places (E1-COVER (c), (d); E1-NOBRANCH (i)); the closure
  form of FS106-DIAM (`dist_le_one_of_subset_closure`) makes every one of them a statement about a colour class, so (N1) per sector — not
  expressible in W's colour-change picture — is never needed (§ 7.2).
- *Arc-end types I/O/A* (E1-COVER (a)): replaced by the colour-class dichotomy at a non-crossing point (`exists_side_colours_of_not_crossesAt`).
- *The exact exceptional set of E1-BAD* (edges on `ω(Y)`, branches in one sector): a proof artifact; the consumer reads only its size. Stated as an
  existential `K` of at most `n` angles, with the conclusion E1-BAD composed with E1-SEE (two distinct colours absent).
- *"At least six branch points"*: the consumer needs one branch point off `K`; stated as the pigeonhole `exists_Ioo_avoiding` (five angles leave an
  arc of `2π/5 > π/3`) feeding E1-COVER.
- *Circles of curvature `κ` for the second order*: the tangent **parabola** `y = κx²/2` (`framePt`) has the same second-order behaviour and no square
  roots.

**Placement.** Nothing indexed. `CrossesAt` is a predicate on one map (two statements and one internal step read it). Angles mod `2π` use the
`∀ m : ℤ, ψ ≠ κ + 2 * π * m` form of `townsend_lemma`. The previous sector is `(finRotate n).symm i`, as in `step5_lt`.

### 8.2 Alternatives weighed

| choice | taken | alternative | why |
|---|---|---|---|
| (N1) per sector | not assumed; colour-class routes | an arc-level predicate "every point of `Γ` carries two colours" added to the normal form, delivered by `exists_woodallMerged` | it adds an obligation to the H+ leaf, and the colour-class routes need none |
| E1-BAD's edge case | refined second-order lemma, inner side, `∃ σ` | E1's exact form (edge on `ω(Y)`) | the exact count fails in W's model (two tangent unit arcs, one invisible: § 7.2); the refined form needs no (N1)/(N2), no injectivity |
| the second-order lemma's statement | "one of the two normals carries an inner two-colour collar" | W's § 4.1 "unless the edge is a unit arc centred there", per normal | the per-normal form is true but allows two bad normals per direction in W's model; the count needs at most one, and `step6` is served by either |
| E1-COVER's scope | E1-GEN6's form: any `k`, at most one colour absent, positive angles, no normal form | E1's (five colours, normal form, four or five sectors) | the proof reads nothing more; the wider form is the one the six-colour questions can reuse (E1-GEN6's handoff); messaged as a generalization |
| E1-NOBRANCH | `exists_three_le_sectors` via `ts_t` | the Jordan curve theorem for arc curves | § 7.5 |
| `WoodallNormal` | angles `π/3 ≤` | keep `π/3 <` and prove `step5_eq` | E1-Q1: not needed; the strict form was the open leaf |
| module | new `Plane/Woodall/NoFourFive` between `Collar` and `Steps` | the lemmas in `Collar` | `Collar` is region-only two-colour geometry; the new lemmas read `ArcMap` and `SectorsAt`; `false_of_four_le_sectors` stays in `Steps` (it needs `step6`, `exists_sectorsAt`) |

### 8.3 Validation (the seams)

- **Spec examples** for the one new definition: `CrossesAt` holds for the one-colour plane at every angle; **adversary** — a colour inside `ω(v)`
  does not cross. Both proved (no `sorry`).
- **Sharpness** of `dist_le_one_of_subset_closure`: an `example` exhibiting two points at distance exactly `1` in `closure (ball 0 (1/2))` — the
  bound cannot be strict (FS106-DIAM's strict form is for the open set).
- **The unsampled member** for E1-BAD's count: the `π`-sector carrying two exceptional points (`tools/fs131_w2_bad_pi.py`, § 7.4) — the reason `K`'s
  bound is `n`, argued by the two edges' normals, never "one per `π`-sector".
- **Inhabitants** (the module's docstring): `const_sectorsAt` for the `SectorsAt` hypotheses without validity; `sevenBrickMap` at a brick corner
  (three sectors, angles `π, π/2, π/2`) for those over valid maps of the plane with pictures of two or three sectors; E1-COVER, E1-NO45 and the
  chain's theorems over five colours conclude `False` (refutations, skipped by the vacuity scan). `WoodallNormal`'s inhabitants
  (`const_woodallNormal`, the adversary `not_woodallNormal_of_repeat`) are unchanged by the weakened angle bound.
- **The next lemma** (`step6`'s need: a collar at a normal of an edge, to extend a one-sided arc past `π/3`) states in the new vocabulary:
  `SectorsAt.exists_normal_collarAt`.

### 8.4 The skeleton

| module | change |
|---|---|
| `Plane/Woodall/Basic` | `WoodallNormal`: `π / 3 <` → `π / 3 ≤` (and its docstring, the module docstring) |
| `Plane/Woodall/NoFourFive` (**new**, imports `Woodall/Collar`, `Plane/Tiles`) | 20 theorems, each `sorry` — see 8.5; the definition `ArcMap.CrossesAt` with two proved spec examples; one proved sharpness example. Two statements refined at the obligation pass before this stage's final build (§ 9.1): `exists_side_colours_of_not_crossesAt` also concludes `coloursAt = {A, B}`; `exists_parabola_region` names the parabola of curvature `1/2` |
| `Plane/Woodall/Steps` | imports `NoFourFive`; **removed**: `step5_eq_of_condition5`, `step5_eq`, `aeMap6_merged_of_condition5`, `step7`, `step8`; **added**: `false_of_four_le_sectors` (E1-NO45); `step6`'s `hang` now `π / 3 ≤`; docstrings of `aeMap6_merged`, `exists_three_le_sectors` (E1-NOBRANCH), `aeMap6_normal`, `aeMap6`, `aeMap6_of_condition5` and the module re-pointed |
| `Proofs.lean` | `import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive` |
| `ARCHITECTURE.md` § 3.11 | a `Plane/Woodall/NoFourFive` row; the `Basic` and `Steps` rows updated; `tools/check_architecture.py`: **PASS** |
| `scripts/Axioms.lean` | 5 records removed (the five leaves), the skeleton section's header updated, a section "FS-131 Woodall's chain (job FS131-W2)" with 20 records; `tools/fs131_w2_decls.py --check`: **53 theorems, 53 records; 0 missing, 0 stale**; `--plant` (one theorem dropped, one removed leaf re-added as a record): **FIRED** both ways |

### 8.5 The read-backs (each formal statement against its E1 entry)

| E1 entry (statement, verbatim in `plans/FS131-E1-derivation.md`) | declaration | read-back |
|---|---|---|
| **E1-SEE** "in an almost-everywhere-proper arc map, if a point q of an open region lies at distance exactly 1 from a point Y, then no region whose closure contains Y has the colour of q" | `ArcMap.not_mem_coloursAt_of_dist_eq_one` (`hF : F.Valid`, `q ∈ F.region j`, `dist q Y = 1` ⊢ `j ∉ F.coloursAt Y`) | "a region whose closure contains `Y` has colour `j`" implies `Y ∈ closure (F.region j)`, so the formal conclusion (`Y` not in the closure of the whole class) is the stronger. **Same, conclusion stronger.** The robust form `not_mem_coloursAt_of_collarAt` is new (§ 7.3 (b)) |
| **E1-RAY** "if a sector s at a point P contains a direction γ with cos(γ − ψ) < 0 (respectively > 0), then every point z close enough to P + e(ψ) with \|z − P\| < 1 (respectively \|z − P\| > 1) has a point of s on ω(z)" | `SectorsAt.collarAt_shadow_inner_of_mem`, `_outer_of_mem` (`γ ∈ Ioo (d i.castSucc) (d i.succ)`, `cos (γ − ψ) < 0` / `> 0` ⊢ `CollarAt (shadow (F.region (c i))) v .inner / .outer ψ`) | "contains" is E1's open range ("Let γ lie in the open angular range of s"); "every point close enough, inside" = a collar about `ψ` (`exists_mem_collar_of_dist_lt` converts); "a point of `s`" is read as a point of `s`'s colour class — weaker, and every consumer reads only the colour. **Same, conclusion read on the colour** |
| **E1-CROSS** "at a point P whose sectors all have positive angle, a region R whose closure meets ω(P) at a point Y both from inside and from outside — Y a limit of points of R with \|· − P\| < 1 and of points of R with \|· − P\| > 1 — has a colour different from every sector colour at P" | `SectorsAt.not_mem_range_of_crossesAt` (`hF`, `hpos`, `F.CrossesAt v X θ` ⊢ `X ∉ Set.range c`) | `CrossesAt` asks the two limits of the colour class, not of one region — a weaker hypothesis (one region crossing implies its class crosses). **Same, hypothesis weaker (stronger theorem)** |
| **E1-COVER** "in a five-colour almost-everywhere-proper arc map in Woodall's normal form, if a point P lies on the boundary of exactly four or exactly five sectors, then every open arc of ω(P) containing no branch point has angular length at most π/3, and ω(P) contains at least six branch points" | `SectorsAt.false_of_ncard_le_two_on_arc` (`hF`, `hP`, positive angles, at most one colour absent from the picture, `π/3 < θ₂ − θ₁`, every point of the open arc with at most two colours ⊢ `False`) | E1's hypotheses imply the formal ones (five colours and four or five sectors of distinct colours leave at most one absent; (N2) gives positive angles); "no branch point" (no point of three sectors) implies "at most two colours" under (N1), and the formal hypothesis is the weaker (it reads colours). The first clause, contrapositive. **Wider** (E1-GEN6's form, no normal form; messaged). The second clause ("at least six") is not stated: its consumer reads `exists_Ioo_avoiding` instead |
| **E1-BAD** "let every sector at a point P have angle in (0, π]; call Y ∈ ω(P) exceptional when …; then every Y ∈ ω(P) that is not exceptional has points of two different sectors of P on ω(Y), and there is at most one exceptional point per edge at P and at most one per sector of angle exactly π" | `SectorsAt.exists_two_absent` (`hF`, `hP`, `n ≥ 3`, `c` injective, angles in `(0, π]` ⊢ `∃ K : Finset ℝ, K.card ≤ n ∧ ∀ ψ off K mod 2π, ∃ i j, c i ≠ c j ∧ c i ∉ coloursAt (v + e ψ) ∧ c j ∉ coloursAt (v + e ψ)`) | **Different shape, by design**: E1-BAD composed with E1-SEE (points of two sectors on `ω(Y)` ⟹ those two colours absent at `Y`), the exceptional set an existential `K`; its bound `n` is E1's corrected total (§ 7.4: E1's per-`π`-sector clause is false, its total `(edges) + (π-sectors)` true, and the true bound is `n`). Validity and the plane enter because the conclusion is about colours; `n ≥ 3` and injectivity are the setting of every use. **Same content as "E1-BAD then E1-SEE", count corrected** |
| **E1-NO45** "in a five-colour almost-everywhere-proper arc map in Woodall's normal form, no point lies on the boundary of exactly four or exactly five sectors" | `ArcMap.false_of_four_le_sectors` (`k ≤ 5`, `hF`, `hP`, `F.WoodallNormal`, a picture with `4 ≤ n` ⊢ `False`) | "five-colour" read as at most five (`k ≤ 5`, wider); "Woodall's normal form" is `WoodallNormal` — (N1) on colours and (N2); E1's (N1) per sector at the arc level is **not** assumed (wider: maps with arcs between equal colours are covered, § 7.2); "exactly four or exactly five sectors" is `4 ≤ n` (`n ≤ k ≤ 5` by injectivity). **Same, wider** |
| **E1-NOBRANCH** "in an almost-everywhere-proper arc map satisfying (N1), with any finite number of colours, some point lies on the boundary of three or more sectors" | `ArcMap.exists_three_le_sectors` (`hF`, `hP` ⊢ `∃ v n d c, F.SectorsAt v n d c ∧ 3 ≤ n`) | E1's arc maps are maps of the plane (`hP`); (N1) not assumed (wider); a picture of `n ≥ 3` colour-change sectors gives at least three sectors in E1's sense. **Same, wider** |
| **E1-MAPS6** "no five-colour almost-everywhere-proper arc map in Woodall's normal form exists" | `ArcMap.aeMap6_normal` (`k ≤ 5`, `hF`, `hP`, `F.WoodallNormal` ⊢ `False`) | **Same, `k ≤ 5`** |
| the second-order lemma (W's § 4.1, described) | `SectorsAt.exists_normal_collarAt` | refined (§ 7.3 (b), 8.2): one of the two normals of every edge, inner side; with its children `exists_parabola_region` (map-level) and `collarAt_shadow_of_parabola` (region-only) |

The rows (`aeMap6`, `aeMap6_of_condition5`, `woodall_thm6`, `townsend_lemma`, `woodall_step4`) are unchanged statements, as the brief fixed.

### 8.6 The build of this stage

`./scripts/build.sh` under the slot (40 GiB, 8 cpus, `BATCH=4`), from inside the worktree, on the final statements: **OK — 444 of 444 batches, 3
modules rebuilt, 14 with warnings** (`Woodall/NoFourFive` the one new warned module; every Woodall warning `declaration uses 'sorry'`; the up-to-date
probe's "target is out-of-date" line expected), 8 m 31 s, exit 0 (`build/gate/build/20261004T113659Z-3156654.log`; driver log
`data/fs131/w2/build-stage8b.log`). The run before the two refinements of § 9.1: OK, 444 of 444, 5 rebuilt, 14 with warnings, 8 m 31 s
(`build/gate/build/20261004T112750Z-3099938.log`, `data/fs131/w2/build-stage8.log`). Iteration used `lake env lean` (lakefile options passed) with
a scratch olean for `NoFourFive` under `Steps` — never as evidence.

## Stage 9 — SAVED: the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), the plan per new leaf, the handoff

### 9.1 What the pass found

**The space.** No new leaf recurses; every obligation is a local geometric or topological check, and the global claims (E1-COVER, E1-BAD, E1-NO45)
differ only in which local checks they assemble. Five engines carry everything new (each a child some leaves already cite, signatures in § 9.3):

- **Engine E, the exclusion**: a point of `j`'s class lying in `shadow (F.region j)` contradicts `F.Valid` (two interior points of colour `j` at
  distance `1`). Every kill ends here (`not_mem_coloursAt_of_collarAt`, `not_mem_range_of_crossesAt`); E1-SEE is its closure form (wave 1).
- **Engine F, the value `1` on a connected set**: wave 1's `dist_lt_one_of_isPreconnected` (if a preconnected set holds a point nearer than `1` to
  `z` and no point at distance `1`, all its points are nearer than `1`). It closes `dist_le_one_of_subset_closure` and
  `collarAt_shadow_of_parabola`, as it closes W's `collarAt_shadow_*`.
- **Engine G, local constancy on an interval**: `IsPreconnected.constant` (discrete codomain) on `Ioo θ₁ θ₂` — both cases of
  `exists_closure_colour_of_arc` and the colour of the parabola in `exists_parabola_region`.
- **Engine H, finitely many colours give a uniform radius**: `Filter.eventually_all` over `Fin k` — `exists_side_colours_of_not_crossesAt` and the
  closedness half of the clopen argument.
- **Engine I, directions mod `2π`**: `SectorsAt.exists_mem_Ico` (every direction in one half-open sector) and the antipodal disjointness (§ 9.3,
  E1-BAD's children).

**Two statements derived at this pass** (each found by attempting the proof and reading the stuck step):
1. `exists_side_colours_of_not_crossesAt` now also concludes **`F.coloursAt (v + e θ) = {A, B}`**: the closedness half of the clopen argument
   needs "a non-crossing point lacking `E` carries exactly its two side colours" and could not get it from the side colouring alone without
   repeating the density argument.
2. `exists_parabola_region` now names **one parabola, curvature `1/2`**, and needs **no tangent-arc analysis**: a parabola lies on no circle and
   no line, so each arc meets it in at most four points (a nonzero polynomial of degree at most four in `x`); finitely many arcs pass near `v`
   (local finiteness), so the parabola's points `0 < x < r`, `r` small, avoid every arc and lie in one tile. Its curvature `1/2 ∈ (−1, 1)` is all
   the second-order lemma reads: if its colour is the one after the edge, the normal `β + π/2` is good, else `β − π/2`. (The stage-7 description
   with tangent curvatures `K` and the colour function `f(κ)` is the same argument at every `κ`; one `κ` suffices.) The leaf drops from H− to M.

**Measures.** None needed: no recursion. The pigeonhole is a cardinality comparison; the horn chain of `aeMap6_merged` is an extremal choice (W, § 4.2).

**Prove / test / assume.** *Prove*: every new leaf. *Test*: `CrossesAt`'s spec example and adversary, the sharpness example of
`dist_le_one_of_subset_closure` (all proved, in the module); `tools/fs131_w2_bad_pi.py` (the `π`-sector with two exceptional points — the unsampled
member of E1-BAD's count); `tools/fs131_w2_decls.py` (records both ways). *Assume*: nothing new — the chain's one outside dependency is still
`lebesgue_covering_square` (FS131-LEB) through `ts_t` and `exists_three_le_sectors`.

**Mutation audit** (statement level, by hand): dropping `hπ` from E1-BAD breaks it (a sector wider than `π` has an arc of normals with both branches in
it: no finite `K`); dropping `hc` breaks "`c i ≠ c j`"; dropping E1-COVER's `habs` breaks it (with two colours absent a crossing region may
alternate, E1's § 3.10 `k = 3` attack); dropping `hpos` breaks E1-CROSS (a horn has no direction to see by); `≤ 1` → `< 1` in
`dist_le_one_of_subset_closure` is false (its sharpness example); `K.card ≤ 5` → `≤ 6` in `exists_Ioo_avoiding` is false (six points at spacing
`π/3`). **The caveat W recorded holds here too**: every statement whose hypotheses include `k ≤ 5`, `F.Valid` and `F.IsPlaneMap` is provable from
`aeMap6` itself, so its mutation audit is empty — those statements conclude `False` and are refutations, not structure lemmas.

### 9.2 Mathlib and library names confirmed with `#check` at the pin (`v4.32.0`, scratch file, 2026-10-04)

`Metric.mem_closure_iff`, `closure_ball`, `IsPreconnected.image`, `isPreconnected_Ioo`, `isPreconnected_Icc`, `IsPreconnected.Icc_subset`,
`IsPreconnected.constant`, `IsPreconnected.subset_left_of_subset_union`, `Complex.continuousAt_arg`, `Complex.norm_mul_exp_arg_mul_I`,
`Real.cos_sub_pi_div_two`, `Real.cos_add_pi_div_two`, `Real.sin_pos_of_pos_of_lt_pi`, `Real.sin_neg_of_neg_of_neg_pi_lt`, `Real.sin_lt`,
`Real.two_mul_sin_mul_cos`, `Set.Ioo_infinite`, `Set.Infinite.exists_notMem_finset` (the `notMem` spelling at this pin), `Set.Finite.isClosed`,
`Set.Finite.exists_finset_coe`, `Finset.exists_ne_map_eq_of_card_lt_of_maps_to`, `Finset.card_image_le`, `Fintype.card_le_of_injective`,
`Set.ncard_le_ncard`, `Set.ncard_eq_two`, `toIcoMod`, `toIcoMod_mem_Ico`, `Filter.eventually_all`, `IsCompact.exists_isMinOn`, `IsClosed.preimage`,
`Continuous.dist`. Library: `dist_ne_one_of_mem_of_mem_closure` (`Plane/Closure`), `dist_lt_one_of_isPreconnected` (`Plane/Diameter`),
`ArcMap.Valid.unitPairsNull_region` (`Plane/Tiles`), `ArcMap.dense_interiorPts`, `ArcMap.coneAt_region_eq_biUnion`,
`Arc.finite_inter_sphere_or_eq_circ` (`Plane/LocalStructure`), `ArcMap.isOpen_region`, `ArcMap.continuousOn_col` (`Plane/LocalMap`),
`dist_ringPt_ringPt_cmp_one` (`Plane/Chord`), `collarAt_shadow_inner`, `isPreconnected_annSector` (`Plane/Woodall/Collar`), `framePt`,
`tanHeight` (`Plane/ValidMap/Basic`). **Not found**: `Set.ncard_le_two` (use `Set.ncard_eq_two` or `Set.ncard_le_ncard` against a pair).

### 9.3 The plan per new leaf (E easy, M moderate, H hard; prices for an agent — re-price from the first two leaves)

**`Plane/Woodall/NoFourFive` — region-only tools**

| leaf | route | children / names | price |
|---|---|---|---|
| `dist_le_one_of_subset_closure` | by contradiction (`1 < dist x y`); `z ∈ U` with `dist x z < min 1 ((dist x y − 1)/2)` (`Metric.mem_closure_iff` at `hSU hx`); Engine F with `s₀ = x`, `h := fun s hs => (dist_ne_one_of_mem_of_mem_closure hU hnull hz (hSU hs))` gives `dist z y < 1`; but `dist z y ≥ dist x y − dist x z > 1` | `dist_lt_one_of_isPreconnected`, `dist_ne_one_of_mem_of_mem_closure` | E |
| `exists_mem_collar_of_dist_lt` | rotate: `w = (z − u) * conj (e ψ)`, near `1`; `Complex.continuousAt_arg` at `1` (`Complex.one_mem_slitPlane`, `arg_one`) gives `ε₁` with `‖w − 1‖ < ε₁ → |arg w| < h`; `ε = min h ε₁`; `z = u + ‖z − u‖ * e (ψ + arg w)` (`Complex.norm_mul_exp_arg_mul_I`, `e_add`); radius `‖z − u‖ = dist z u ∈ (1 − h, 1)` or `(1, 1 + h)` | — | M− |
| `exists_Ioo_avoiding` | `K = ∅`: `θ = 0`. Else `κ₀ ∈ K`; for `κ ∈ K` its arc index `j κ = ⌊(toIcoMod two_pi_pos κ₀ κ − κ₀) / (2π/5)⌋ ∈ {0,…,4}`; `(K.erase κ₀).image j` has card `≤ 4 < 5` (`Finset.card_image_le`), so some `j₀ ∈ range 5` is missed; `θ = κ₀ + 2π j₀/5`. A hit `κ + 2πm ∈ Ioo θ (θ + 2π/5) ⊆ Ioo κ₀ (κ₀ + 2π)` is `κ`'s reduction (`toIcoMod` is the unique representative in `[κ₀, κ₀ + 2π)`), so `j κ = j₀` and `κ ≠ κ₀` (`κ₀` reduces to `κ₀ ∉ Ioo θ …`) | `toIcoMod_mem_Ico`, `toIcoMod` uniqueness (`toIcoMod_eq_iff` or the defining identity), `Int.floor_eq_iff` | M |
| `mem_coneAt_annSector` | for `ε`: `z = v + t * e γ`, `t = min r ε / 2`; `z ∈ annSector` (radius `t ∈ (0, r)`, angle `γ`), `z ≠ v`, `dist z v = t < ε`, `(z − v)/‖z − v‖ = e γ` | — | E |
| `collarAt_shadow_of_parabola` | frame coordinates of `z = v + ρ' e(β + σπ/2 + τ)`: `a = −σρ' sin τ`, `b = σρ' cos τ` (`cos (σπ/2 + τ) = −σ sin τ`, `sin (σπ/2 + τ) = σ cos τ` for `σ = ±1`); for the parabola point `w x = framePt v β x (κx²/2)`, `g x := ‖w x − z‖² − 1 = x²(1 − σκρ' cos τ) + 2σρ' sin τ · x + κ²x⁴/4 − (1 − ρ'²)` (a child, `norm_sq_framePt_sub`). **Inner** (`σκ < 1`): `m := 1 − max (σκ) 0 > 0`; fix `x₀ = r/2`; for `h ≤ m x₀² / (4 (x₀ + 1))` (and `h < π/2` so `cos τ > 0`), `g x₀ ≥ m x₀²/2 > 0` on the collar; `g x → ρ'² − 1 < 0` as `x → 0`: a point of the arc nearer than `1` to `z`; Engine F on the arc `{w x : x ∈ Ioc 0 x₀}` (preconnected image) forces a point at distance `1`. **Outer** (`σκ > 1`): `m' := (σκ − 1)/2`; `x₀ < min r (√m' / |κ|)` so `κ²x₀⁴/4 < m'x₀²/4`; for small `h` (`cos h ≥ …`), `g x₀ < 0` while `g x → ρ'² − 1 > 0`: same | `norm_sq_framePt_sub` (child: the frame distance formula); Engine F | M |

**`Plane/Woodall/NoFourFive` — map-level**

| leaf | route | children / names | price |
|---|---|---|---|
| `not_mem_coloursAt_of_dist_eq_one` (E1-SEE) | `fun hY => dist_ne_one_of_mem_of_mem_closure (F.isOpen_region j) (hF.unitPairsNull_region j) hq hY hqY` | — | E |
| `not_mem_coloursAt_of_collarAt` (robust E1-SEE) | `hY : v + e ψ ∈ closure (F.region j)`; thicknesses `h₁` (inner), `h₂` (outer), `h = min h₁ h₂`; `ε` from `exists_mem_collar_of_dist_lt v ψ h`; `q ∈ F.region j` with `dist (v + e ψ) q < ε`; if `dist q v < 1`, `q` lies in the inner collar (`collar_subset_collar` to `h₁`) hence in `shadow (F.region j)`: Engine E; `> 1` likewise; `= 1`: `F.region j` open, so `q' = v + (1 − t) (q − v)` for small `t > 0` is in the class, nearer than `ε` to `v + e ψ` and inside — Engine E | `exists_mem_collar_of_dist_lt`, `collar_subset_collar`, Engine E | M− |
| `SectorsAt.collarAt_shadow_inner_of_mem`, `_outer_of_mem` (E1-RAY) | `δ = min (γ − d i.castSucc) (d i.succ − γ) / 2`; `h.2.2.2.2.1 i δ` gives `r` and `R = annSector v 0 r (d i.castSucc + δ) (d i.succ − δ) ⊆ F.region (c i)`; `collarAt_shadow_inner (isPreconnected_annSector …) (mem_coneAt_annSector …) hcos`; monotonicity of `shadow` and of `CollarAt` in the set | `mem_coneAt_annSector`, W's `collarAt_shadow_inner/_outer` | E |
| `SectorsAt.not_mem_range_of_crossesAt` (E1-CROSS) | `rintro ⟨i, rfl⟩`; a direction `γ` in sector `i`'s open range with `cos (γ − θ) ≠ 0` (the midpoint, or the midpoint plus a small `ε < π`: `cos` vanishes at points `π` apart); `cos < 0`: E1-RAY inner, `exists_mem_collar_of_dist_lt`, a point of `hX.1` in the collar — Engine E; `> 0`: outer with `hX.2` | E1-RAY, Engine E | M− |
| `exists_side_colours_of_not_crossesAt` | `Y = v + e θ`. Engine H: `∀ᶠ z in 𝓝 Y, ∀ j ∉ F.coloursAt Y, z ∉ F.region j`. `Cin = {j | Y ∈ closure (F.region j ∩ ball v 1)}`, `Cout` likewise: nonempty (if `Cin = ∅`, Engine H gives a disc about `Y` whose inside part has no interior point, against density — `dense_interiorPts`, `hP`, and `ball Y δ ∩ ball v 1` open nonempty); `Cin ∪ Cout ⊆ coloursAt Y` (`closure_mono`), disjoint (`hnc`), `ncard ≤ 2`: both singletons `{A}`, `{B}`, `A ≠ B`. Engine H again: a disc about `Y` whose inside interior points are `A`, outside `B`; an interior point on `ω(v)` has a disc in its class (open) meeting both sides: `A = B`, impossible. `coloursAt Y = {A, B}`: `⊆` by the side colouring (no other colour near `Y`), `⊇` by `Cin`, `Cout` | Engine H, `dense_interiorPts`, `Set.ncard_eq_two` | M |
| `exists_closure_colour_of_arc` | **Case A**, no crossing on the arc: the inside colour `A_θ` (from the previous leaf) is locally constant on `Ioo θ₁ θ₂` (for `θ'` with `v + e θ'` within half of `θ`'s radius, the inside interior points near `v + e θ'` are `A_θ`, and they exist by density), so constant (Engine G, `ContinuousOn` of a locally constant function into `Fin k`); every `v + e θ` is in the closure of the inside points, of colour `X = A_{θ₀}`. Empty arc: `X = F.col 0`. **Case B**, a crossing at `θ₀` of colour `E`: `g θ = decide (E ∈ F.coloursAt (v + e θ))` is locally constant — where `E ∈`, by contradiction: frequently `E ∉` near `θ`; such `θ'` do not cross (a crossing colour is `E` by `hcross`, and crossing gives `E ∈`), so the previous leaf gives `coloursAt = {A, B}` with `E ∉ {A, B}`; finitely many pairs, so frequently one pair `(A, B)`; `{θ | A ∈ coloursAt (v + e θ)}` is closed (`IsClosed.preimage` of `isClosed_closure` under `θ ↦ v + e θ`), so `A, B ∈ coloursAt (v + e θ)` with `E`: three colours, against `hnb`; where `E ∉`: the same closedness. So `g` is constant, `true` at `θ₀` | the previous leaf; Engines G, H; `Filter.Frequently` + finite pigeonhole (`Finite.exists_... `, or `Filter.frequently_or_distrib` over the finite set of pairs) | M+ |
| `SectorsAt.false_of_ncard_le_two_on_arc` (E1-COVER) | crossing colours avoid `range c` (E1-CROSS), so by `habs` they are one colour: `hcross`; `exists_closure_colour_of_arc` gives `X`; `a = θ₁ + δ`, `b = a + min (θ₂ − θ₁ − 2δ) π` with `δ` small so `π/3 < b − a ≤ π`; `S = (fun θ => v + e θ) '' Icc a b` (preconnected) `⊆ closure (F.region X)`; `dist (v + e a) (v + e b) > 1` (`dist_ringPt_ringPt_cmp_one`, `ringPt v θ = v + e θ`); `dist_le_one_of_subset_closure` with `F.isOpen_region X`, `hF.unitPairsNull_region X` | E1-CROSS, the previous two leaves | M− |
| `SectorsAt.exists_mem_Ico` | `D' = toIcoMod two_pi_pos (d 0) D ∈ Ico (d 0) (d 0 + 2π)`, `D' = D + 2π m` (`toIcoMod`'s defining identity, `m = −toIcoDiv …`); `d 0 + 2π = d (last n)` (`h.2.2.1`); the largest `i` with `d i.castSucc ≤ D'` (`Finset.max'` of a nonempty filter of `Fin n`, `0 < n` from `h.1`) has `D' < d i.succ` (else `i + 1` qualifies, or `i` is last and `d (last n) > D'`) | `toIcoMod_mem_Ico`, `Finset.max'` | M− |
| `SectorsAt.not_mem_coloursAt_of_mem_Ioo` (E1-BAD, interior) | the point `q = v + e ψ + e (ψ + π ∓ 2φ)` of `ω(v + e ψ)` equals `v + 2 sin φ · e (D ± φ)` (`D = ψ ∓ π/2`; the identity `1 − e(2φ) = 2 sin φ · e(φ − π/2)`); `δ` the distance of `D + 2πm` to the sector's ends, `r` the truncated sector's radius; `φ = min (δ/2) (r/4)`: `0 < 2 sin φ < r` (`Real.sin_pos_of_pos_of_lt_pi`, `Real.sin_lt`), angle within `δ`, so `q ∈ F.region (c i)` (`e`'s `2π`-periodicity, `e_add_two_pi`); `dist q (v + e ψ) = 1`; E1-SEE | E1-SEE | M− |
| `SectorsAt.exists_parabola_region` | **κ = 1/2**, no tangent-arc analysis (9.1 item 2). (a) `F.locallyFinite v`: `t ∈ 𝓝 v` meeting finitely many arcs. (b) each nondegenerate arc meets the parabola `P = {framePt v β x (x²/4)}` at finitely many `x` — child **`Arc.finite_inter_parabola`**: the arc lies on a circle `‖w − c₀‖ = ρ`, `ρ > 0`, or a line `n · (w − p₀) = 0`, `n ≠ 0`; substituting `(x, x²/4)` gives a polynomial in `x` with leading coefficient `1/16` (circle: `(x²/4)²`) or, for a line, `n_y/4`, or then `n_x ≠ 0` (never the zero polynomial), so finitely many roots. (c) `r` below every such positive root and inside `t`: the points `0 < x < r` are interior points (`hP`). (d) the arc `{w x : x ∈ Ioo 0 r}` is preconnected and in `F.interiorPts`, so `F.col` is constant on it (Engine G with `F.continuousOn_col`): one colour `j`. (e) `d i.castSucc ∈ coneAt (F.region j) v` (the directions `(w x − v)/‖w x − v‖ → e β`); by `SectorsAt`'s cone clause, `β ∈ angleIcc` of a sector of colour `j`; child **`SectorsAt.eq_of_edge_mem_angleIcc`**: with positive angles, only the sectors `i` and `(finRotate n).symm i` hold `d i.castSucc` mod `2π` in their closed range | `Arc.finite_inter_parabola` (M−), `SectorsAt.eq_of_edge_mem_angleIcc` (M−), `ArcMap.continuousOn_col`, `IsPreconnected.constant` | M |
| `SectorsAt.exists_normal_collarAt` (the refined second-order lemma) | `exists_parabola_region` gives `r`, `j`. `j = c i`: `σ = 1`; `collarAt_shadow_of_parabola` (`σκ = 1/2 < 1`) puts an inner collar about `β + π/2` in `shadow (F.region (c i))`; E1-RAY inner with `γ` in the previous sector just below `β` (`cos (γ − β − π/2) = sin (γ − β) < 0`) puts one in `shadow (F.region (c (symm i)))`; intersect (thickness the minimum, `collar_subset_collar`). `j = c (symm i)`: `σ = −1`, `σκ = −1/2 < 1`; E1-RAY inner for sector `i` with `γ` just above `β` (`cos (γ − β + π/2) = −sin (γ − β) < 0`). For `i = 0` the previous sector is `n − 1`, its range `(d (n−1), d 0 + 2π)`: shift `γ` by `2π` | `exists_parabola_region`, `collarAt_shadow_of_parabola`, E1-RAY | M− |
| `SectorsAt.absent_at_normal` | `σ = 1`: the sector after the edge has `γ` just above `β` with `cos (γ − β − π/2) = sin (γ − β) > 0`: E1-RAY **outer** in `shadow (F.region (c i))`; with `hs`'s inner part, `not_mem_coloursAt_of_collarAt` kills `c i` (right disjunct). `σ = −1`: the previous sector, `cos (γ − β + π/2) = −sin (γ − β) > 0` for `γ` just below `β`: outer in its colour's shadow; kills `c (symm i)` (left disjunct) | E1-RAY, robust E1-SEE | E |
| `SectorsAt.exists_two_absent` (E1-BAD) | For each edge `i`, `σ_i` from `exists_normal_collarAt` (choice); `ψ_i := d i.castSucc − σ_i π/2` (the uncertified normal). Angles `≤ π`, positive, `n ≥ 3`: at most one sector `i₀` of angle `π` (two would sum to `2π`); if it exists, override `ψ_{i₀} := d i₀.castSucc + π/2`, `ψ_{i₀⁺} := d i₀.castSucc − π/2` (`i₀⁺ = finRotate n i₀`, whose edge is `d i₀.succ ≡ d i₀.castSucc + π`) — both normals of both its edges. `K := univ.image ψ`, card `≤ n` (`Finset.card_image_le`). Off `K`: for `D₊ = ψ + π/2` and `D₋ = ψ − π/2`, `exists_mem_Ico` gives a sector; interior → `not_mem_coloursAt_of_mem_Ioo` kills its colour; an edge `i` → `ψ ≡ d i ∓ π/2` is a normal of edge `i`, not `ψ_i` (off `K`), so it is the certified one (and `i` bounds no `π`-sector): `absent_at_normal` kills a colour of `{c (symm i), c i}`. Each kill lies in `N(D)`, the sectors whose closed range holds `D` mod `2π`. **Distinct**: child **`SectorsAt.eq_pi_of_mem_antipodal`** — a sector whose closed range holds `D` and `D + π` (mod `2π`) has angle `π` and ends at `D`, `D + π`; off `K` no such sector, so `N(D₊) ∩ N(D₋) = ∅` and injectivity gives `c i ≠ c j` | `exists_normal_collarAt`, `absent_at_normal`, `not_mem_coloursAt_of_mem_Ioo`, `exists_mem_Ico`; children `SectorsAt.eq_pi_of_mem_antipodal` (M−), `SectorsAt.at_most_one_pi` (E) | M+ |

**`Plane/Woodall/Steps` — the re-pointed and new leaves** (the rest of § 4.5's table stands)

| leaf | route | children / names | price |
|---|---|---|---|
| `false_of_four_le_sectors` (E1-NO45) | `hN v n d c h (by omega)`: `c` injective, angles `≥ π/3`; `n ≤ k ≤ 5` (`Fintype.card_le_of_injective`); angles `≤ π` (child `SectorsAt.sum_angles`: `∑ i, (d i.succ − d i.castSucc) = 2π`, telescoping with `h.2.2.1`; the other `n − 1 ≥ 3` angles sum to `≥ π`); `habs` (two absent colours leave `range c` in `k − 2 ≤ 3` colours); `exists_two_absent` → `K`, `K.card ≤ n ≤ 5`; `exists_Ioo_avoiding K` → `θ`; by contradiction with `false_of_ncard_le_two_on_arc` on `(θ, θ + 2π/5)` (`2π/5 > π/3`), some `θ'` there has `3 ≤ ncard`; `θ'` is off `K`, so two of `v`'s colours are absent: `coloursAt (v + e θ') ⊆ univ \ {c i, c j}`, `ncard ≤ k − 2 ≤ 3`, so `= 3`; `exists_sectorsAt hP`, `coloursAt_eq`: a picture `(n', d', c')` with `3 ≤ ncard (range c') ≤ n'` (`Set.ncard_range_le`… or `Finite.card_range_le`); `hN`: injective, so `n' = 3`; `subst`; `step6` with `hN`'s angles | `SectorsAt.sum_angles` (E) | M− |
| `aeMap6_merged` | W's route minus `step5_eq`: a zero-angle sector whose next has positive angle exists if any zero-angle sector does; its neighbours differ (`hM`), `step5_lt` kills it; so no horns, `c` injective (`hM`), and `step5_lt` gives every angle `≥ π/3` (`not_lt`): `WoodallNormal` for the merged map (private child, `VACUITY DECLARED`, W § 3.1); `aeMap6_normal` | `step5_lt`, `aeMap6_normal` | M |
| `aeMap6_normal` | `exists_three_le_sectors`; `hN` gives `c` injective, `n ≤ k ≤ 5`; `n = 3`: `subst`, `step6` (angles from `hN`); `4 ≤ n`: `false_of_four_le_sectors` | — | E |
| `aeMap6_of_condition5` | `aeMap6 F hk hF hP` | — | E |
| `step6` | W's route (§ 4.5), its hypothesis weakened to `π/3 ≤` (it read only positivity and one angle `< 2π/3`); the switching normal from `SectorsAt.exists_normal_collarAt` (one per edge), in place of W's "unless the edge is a unit arc" | `exists_normal_collarAt` | H− (unchanged) |

**Planner's checks of this stage.** `dist_le_one_of_subset_closure` and E1-SEE proved in a scratch file against the built library (both close as
planned; `data/fs131/w2/planner-checks.lean`, under the primed names — the implementer may paste them); the frame distance formula of
`collarAt_shadow_of_parabola`, `‖w x − z‖² − 1 = x²(1 − σκρ cos τ) + 2σρ sin τ · x + κ²x⁴/4 − (1 − ρ²)` for `z − v = ρ e(β + σπ/2 + τ)`, verified
symbolically (sympy, both `σ = ±1`: difference `0`).

### 9.4 Re-pricing

`Plane/Woodall/NoFourFive`: 20 leaves — 6 E, 9 M− or M, 2 M+ (`exists_closure_colour_of_arc`, `exists_two_absent`) — plus 5 children named above
(`norm_sq_framePt_sub`, `Arc.finite_inter_parabola`, `SectorsAt.eq_of_edge_mem_angleIcc`, `SectorsAt.eq_pi_of_mem_antipodal`,
`SectorsAt.at_most_one_pi`; and `SectorsAt.sum_angles` in `Steps`). Nothing in it is H. `Plane/Woodall/Steps`: 11 leaves, none open; its hard ones are
W's (`exists_sectorsAt` H, `exists_woodallMerged` H+, `step6` H−). The chain's hardest leaves are where they were (`exists_woodallMerged`,
`exists_sectorsAt`); E1's replacement of steps 5 (equality), 7 and 8 costs about one implementer session, against two open leaves before.

### 9.5 The handoff to the chain's implementer (§ 4.7's form, current; it supersedes § 4.7)

**Where it is.** Branch `fs131-ww`, worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (`.lake/packages` a symlink to the main tree's,
`.lake/build` its own copy — never replace it with a symlink), on wave 4's full skeleton `f620977c`. Four modules: `Plane/Woodall/Basic` (sorry-free;
`WoodallNormal` now `π/3 ≤`), `Plane/Woodall/Collar` (15 `sorry` leaves, unchanged), `Plane/Woodall/NoFourFive` (20 `sorry` leaves, new; one
definition and three examples proved), `Plane/Woodall/Steps` (11 `sorry` leaves). **No open leaf**: every leaf has a planned route (§ 4.5 for W's,
§ 9.3 for the new and re-pointed). The build is green with only `sorry` warnings (§ 8.6). `Proofs.lean`, `ARCHITECTURE.md` and
`scripts/Axioms.lean` are current; `tools/fs131_w2_decls.py --check` lists and checks the 53 records both ways (missing and stale).

**The build**: from inside the worktree, `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. For iteration, `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false`, against scratch oleans for
modules downstream of an edited one (mirror `.lake/build/lib/lean/Proofs` with `cp -rs`, write each edited module's olean there with `lean -o`, the
scratch first on `LEAN_PATH`) — never as evidence.

**Dependencies not yet landed.** Waves 3 and 4 (`Plane/LocalStructure`, `Plane/SVMap`'s `lemmaL`, `ts_t`, …) are skeletons on their branches: this
chain cites their statements as committed at `f620977c`; merge their branches in when they land, or earlier to use their proofs, resolving the
append-only lines of `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`. `lebesgue_covering_square` is FS131-LEB's. Wave 1's
`dist_ne_one_of_mem_of_mem_closure`, `dist_lt_one_of_isPreconnected` and `Valid.unitPairsNull_region` are proved (on `main`).

**The order.** (1) `Collar`'s foundation leaves as § 4.7 had them (`isPreconnected_annSector`, `isOpen_collar`, `collar_subset_collar`,
`isOpen_annSector`, `exists_collar_of_collarAt` — the first two re-price the module), and `collarAt_shadow_inner/_outer`. (2) `NoFourFive`'s
region-only tools: `dist_le_one_of_subset_closure`, `mem_coneAt_annSector`, `exists_mem_collar_of_dist_lt`, `collarAt_shadow_of_parabola`,
`exists_Ioo_avoiding`. (3) Its map-level leaves: E1-SEE, the robust kill, E1-RAY, E1-CROSS, `exists_side_colours_of_not_crossesAt`,
`exists_closure_colour_of_arc`, E1-COVER; `exists_mem_Ico`, `not_mem_coloursAt_of_mem_Ioo`, `exists_parabola_region` (children
`Arc.finite_inter_parabola`, `SectorsAt.eq_of_edge_mem_angleIcc`), `exists_normal_collarAt`, `absent_at_normal`, E1-BAD. (4) The rest of `Collar`
(§ 4.7's order: change points, landings, Engines A–D, `woodall_step4`, `townsend_lemma`, the adversary). (5) `Steps`: `coloursAt_eq`,
`exists_sectorsAt`, `step5_lt`, `false_of_four_le_sectors`, `aeMap6_normal`, `aeMap6_merged`, `exists_three_le_sectors`, the corollaries; then `step6`;
`exists_woodallMerged` last (re-price it first; ask Keryx for a separate job if it outgrows the context).

**What the implementer may and may not change.** It may add children anywhere (§ 4.1's engines, § 9.3's named children with the statements given or
fixed by it and recorded back, the private "merged ⇒ normal" with `VACUITY DECLARED`), supporting lemmas in the foundation modules (statements of other
waves unchanged), and imports (updating `ARCHITECTURE.md`, `scripts/Axioms.lean`, then `tools/fs131_w2_decls.py --check`). It may not change any
statement of § 3.1's table that § 8.4 kept, any statement of § 8.4–8.5, or any definition of `Plane/Woodall/Basic` or `Plane/Woodall/NoFourFive`. A
statement that cannot be proved as written comes back through Keryx with the stuck goal or the counterexample.

**Vacuity and inhabitants** (§ 3.1, § 8.3): every theorem over valid five-coloured maps of the plane concludes `False` (skipped by the scan); the
others are inhabited by `const_sectorsAt` and the brick map (`sevenBrickMap`, `sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`) at a corner; the one
new definition (`CrossesAt`) has its spec example and adversary. No new carrier for `scripts/Vacuity.lean`.

**How the chain lands.** Unconditionally (inventory item 98: E1 closed the GAPs): when every leaf is proved and the gate passes, after waves 3 and 4
land, by merging `main` and the implementer's gate. The open-leaf landing form (b) of § 4.7 is withdrawn.

## Stage 10 — SAVED: the report

The report is `data/fs131/reports/FS131-W2.md` (standing rule 11's form); its text is the job's hand-back. No drafts for Keryx's files beyond § 7.4's
erratum for E1's record: `CLAUDE.md` § The aim item 4 and `LEDGER.md` row 132 already state maps-need-six for arc maps through E1-NO45 (filed at
inventory item 107), and nothing here changes them.
