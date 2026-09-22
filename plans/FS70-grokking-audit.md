# FS-70 — §G, the grokking audit (WORKFLOW step 3g; the step's first instance, run by the owner, 2026-09-22)

*Written after three implementer phases and a typed null, when Kooshi's questions ("is the radius hindering us?", "any other
grokkings we skipped?") showed the plan had been built from the literature's analogies while `CLAUDE.md` held four things that
bore on it. Every grokking G1–G66, every ledger row's mechanism (1–75) and every method rule is walked below, one line each, with a
verdict — **bears** (what it says about FS-70 and which phase it changes), **silent** (why), or **falsifiable here** — and every
*bears* is extracted into the phase table at the end. Marked ✓ where a phase already used it, ✗ where it was skipped. The
extractions marked ✗ are phase 1d's contract.*

## G. The grokkings

| entry | verdict | what it says about FS-70, and the extraction |
|---|---|---|
| G1 field wall is 2-adic | bears ✓ | the field breaks the wall (15 ≡ 7 mod 8); wall-breaking directions are the nonzero-depth vectors — the depth grading (plan §3.1) |
| G2 rings ⟺ rotation centres | bears ✓ | a forcer is base + rotated copy about a centre; the arena and the sweep are this |
| G3 radially crystal, angularly detuned | bears ✗ | the "detune" is a type-M rotation; **enumerate every in-field detune** (G7 below), not the one the base's norms happen to produce |
| G4 one shell vocabulary (~30–44 seam radii) | silent | K's seam-shell inventory; no seam group here (√11 absent) |
| G5 ownership factorization (a 1-sum of two systems) | bears ✓ | the arena's two halves share only the centre — G40 then says the copy absorbs |
| G6 hexagram is fabric, not seed | bears ✓ | FS-48's rhombus chain is fabric: containment, not causation; a single detuned copy stays four-chromatic — the arena null, predicted |
| G7 type-M family `cos θ = (2n−1)/(2n)`, radicand `4n−1` | bears ✗ | **in-field members: `4n−1 ∈ {3·k², 15·k²}` → `n ∈ {1, 4, 7, 19, 34, 37, 61, 91, 94, …}`**; only `n = 4` was asked. Phase 1d: each member's rotation, its 2-adic depth (a 2-unit rotation keeps the arena 2-unit and `ψ` colours it — screened out by theorem), its live radius sums (G52), then the arena |
| G8 direction group closes the 1581's directions | bears ✓ | fabric directions should be a group's bounded-length part — the `S_k` word shapes are that |
| G9 the 791-core forces six pairs: the axis pair at 4 and antipodal pairs at 4/√3 | bears ✗ | two forced distances over K the plan never listed here: **`δ = 4` (chain 3, `1/4 = v̄ + v² − v̄²`) — asked at one shape; and `4/√3` (chain 6: `√3/4 = (ζ₁₂+ζ̄₁₂)(v̄+v²−v̄²)`)** — never; and *antipodal* pairs on a circle (forced central symmetry) — a pair shape not asked. Phase 1d targets |
| G10 forcing is distributed | bears ✓ | cores must keep the whole; no organ to find |
| G11 Moser-free forcers exist | used ✓ | the gate |
| G12 quadrature law: one detune's pressure is one thin conic; mixed words couple nowhere | bears ✗ | **predicts the arena's 78 cross edges on one conic and why single rotations are weak**; extraction: unions of two rotated copies (de Grey's two centres) as a sweep shape, and rank rotations by cross-edge *density*, not count |
| G13 fan ladder; coverage is a k-set property invisible to pair sweeps | bears ✓ | the control ask sees the fan (a refusal); nothing between arity 2 and the control was asked — see row 42 |
| G14 width without degree does not force; a matching carries no pressure | bears ✗ | the arena's cross edges are near a matching → **null predicted before the run**; extraction: rotations whose cross edges close cycles with fabric edges (triangles through both halves) rank first |
| G15 pigeonhole × kill | bears ✗ | **the disjunctive route, never asked**: "every four-colouring of fabric F has a monochromatic δ-pair" + a kill gadget = a virtual edge at δ; refuses outright, no chain. Phase 1d |
| G16 distance-2 pigeonhole; Theorem B's colouring makes positive-valuation distances monochromatic; every kill needs a wall-breaking root | bears ✗ | **on 2-unit fabric `ψ` makes every depth-positive distance (2, 4/3, 8/3, 4) monochromatic — the pigeonhole is nearly free there; the kill must be wall-broken material**: `separated δ` asks on L6/L2/L3 at those δ (only `separated i√3` was ever asked). Phase 1d |
| G17 globality only at the top rung; sub-rung carriers are small | bears ✗ | the pigeonhole carrier over K was 122 points: ask the pigeonhole form on *modest* fabric first |
| G18 composition sees what search cannot; compose in the kernel | bears ✓ | plan §3.8's route B; row 31's bridge for the pigeonhole form |
| G19 5-tight fabric; the pattern-class sweep | bears ✗ | the class sweep at four colours (M35's `tools/` lineage) is the pigeonhole form over a class — same extraction as G15 |
| G20 brick colourings | silent | upper-bound machinery |
| G21 a negative measures its enumeration | used ✓ | every verdict names its population |
| G22–G24 cell family, gap law | silent | polygonal colourings |
| G25 the ladder is recursive; a forcer's kills are the previous rung's grade | bears ✓ | sizes: a five-forcer's kills are four-forcer grade (~10³) — P4's band |
| G26 the 6-forcer reduction | silent | six |
| G27 hidden arithmetic symmetry: Galois flips are graph automorphisms | bears ✗ | `√5 ↦ −√5` and `√3 ↦ −√3` preserve unit distance in every real embedding, so `Gal(F/ℚ) ≅ (ℤ/2)²` acts on every fabric as non-geometric automorphisms: **symmetry breaking in every SAT ask, and a Galois-invariant colouring finder (G58's shape) that halves instances**. Phase 1d encoding |
| G28, G29 fine tail, cell dial | silent | cell family |
| G30 measurement generates, derivation kills; the discipline ladder | used ✓ | the screens are derivations; the Kempe screen was recognised as Kempe's |
| G31 no held object carries a top-rung compulsion; a gadget must be constructed | bears ✓ | consistent with every null |
| G32 the two-distance dial μ(δ) | bears ✗ | **the `{1, δ}` distance-graph ask** (M49's `tools/twodist.py`, `killengine.py`): μ(δ) = fewest δ-edges of a non-four-colourable `{1, δ}` graph; μ = 1 is a forced pair, μ small is the pigeonhole. Phase 1d, same extraction as G15 |
| G33 batches compose, growth compounds | bears ✗ | **counterexample-guided growth** (M50's batch halos): from a colouring that separates `(0, δ)`, add the depth-one points that kill it, iterate — the descent toward a forced pair instead of a fixed ball. Phase 1d optional (priced) |
| G34 the field is the selection | bears ✓ | everything here is in-field by design |
| G35 the wall; `1/2 ∈ ℤ[U]` | used ✓ | |
| G36 the residue colouring is the canonical separating colouring | bears ✓ | on 2-unit fabric `ψ` separates every depth-zero pair and identifies every depth-positive one; the Kempe screen is G36's 2-SAT shape in finite form |
| G37 the endgame: fabric grown to four-colour rigidity supplies its own wall-breaking angle | bears ✗ | "grown to rigidity" = richer direction sets; the Kempe screen measures rigidity; **the rich 2-unit lattices were never Kempe-screened** (G61 below) |
| G38 linear thresholds 2/3/4 | used ✓ | the additive families |
| G39 redundancy before rigidity: a pair forced at χ(G) colours at distance > 2 has an empty critical set | bears ✗ | **a filter**: any candidate forcer for 4/3, 8/3, 4 must stay four-chromatic under every single vertex deletion — check cores before asking |
| G40 absorption: a copy hanging by its centre plus few chords carries no compulsion | bears ✗ | **predicted the arena's null**; design: the rotated copy must be joined thickly, or several copies |
| G41, G42 additive colourings; additive rigidity is closure | used ✓ | the additive screen; the Kempe screen is G42's finite form |
| G43 residue plane seals; the sieve | used ✓ | L = 5 at 11 |
| G44 Kloosterman | silent | spectra of finite planes |
| G45 lifting | silent | closed direction |
| G46 recognise the classical theory first | bears ✗ | **the split-prime local plane is a Cayley graph on `(O/𝔭^m)²` with the split torus as connection set — G54's object; nobody named it** |
| G47 compulsion face of sealing (five colours) | silent at four | |
| G48 the conjecture; its falsifiers | bears — falsifiable here | FS-70 *is* the test of "χ(F²) = L(F)" at L = 5; a falsifier is "a wall-broken, 5-sealed field whose plane is four-colourable by a colouring local at no prime" — **the free colourings the structure instruments found on L6 (local at no prime ≤ 7, no period) have exactly that shape on finite fabric**; not evidence, but the falsifier's silhouette — recorded |
| G49, G50 prior-art gate; read what was found | bears ✗ | the Kempe screen was minted mid-milestone with no search (Kempe equivalence, reconfiguration of lattice colourings, frozen colourings) — **owed** |
| G51 competitor + advisor | used ✓ | staffing as ruled |
| G52 breaking the wall is necessary, not sufficient; the live radius sums `d² = σ − (σ−1)/cos θ`; the off-diagonal share | bears ✗ | for every in-field rotation the **live radius sums are computable before any base exists** — a free prime filter on the sweep — and the arena record never measured the **off-diagonal monochromatic share** under the base's colourings (the record's `0/30` is G53, not G52) |
| G53 counting compulsion | used ✓ | `L = 0` at ρ₁₅ |
| G54 tight or slack; propagation up towers | **bears ✗ — the largest miss** | **the 2-unit local plane at the split prime is Hoffman-tight at four colours at level one** (owner, 2026-09-22: `Cay(𝔽₄², {(t, t⁻¹)})`, spectrum {3, −1}); by G54 it stays tight up the tower, so every four-colouring of the local plane is periodic under the minimising characters' common kernel and **forces pairs at some depth — the very mechanism of row 67 that Harder's and de Grey's forcers inherit**. Phase 1d: compute the tower (levels 2–5), the depth at which forcing starts, and which finite direction sets inherit it (the Kempe reach as the test) |
| G55 the chain theorem; `ℤ[U]` | used ✓ | the closers; `1/2, 1/3 ∈ ℤ[U]` |
| G56–G59 the window; six | silent | |
| G60 fractional colourings see fields the residue method cannot; `χ(F²) ≥ ⌈χ_gf(H)⌉`; cap `min(4.36, χ_f of every usable plane)` | bears ✗ | **over K the cap is 4 (Theorem B); over ℚ(√3,√5) the usable planes are 11, 59, 71 — no 𝔽₃ or 𝔽₇ place — so the cap is `121/28 = 4.32 > 4`, and a finite `H ⊂ F²` with `χ_gf(H) > 4` proves five colours with no forced pair and no refusal.** FS-56's LP and checker exist. Expectation low (G27 reads 3.90 over K, whose true value is 4), cost small on small dense `H`. Phase 1d exploratory |
| G61 three colours break at arithmetic; what decides is the supply of unit vectors | bears ✗ | **the rich 2-unit lattices (212, 660, 1,220 unit vectors) were screened additively only** (48 colourings survive); their Kempe reach was never computed and they were never asked; the plan's lattices were the poorest. Phase 1d |
| G62 twisted bilayers; commensurate twists are periodic, hence bounded by a finite quotient | bears ✗ | every in-field arena is periodic: **a proper four-colouring of `Λ/NΛ` (no unit vector in `NΛ`) four-colours every graph on `Λ` at once** (row 56's kernel lemma). Phase 1b tried `N = 2, 3, 4` on L6 (self-loops); **`N = 5 … 12` never** — rank 6 makes these small (`N⁶` vertices). Phase 1d: the one-line kill of L6, if it exists |
| G63, G64 transcendence; six | silent | |
| G65 phase diagram | used, misread, corrected ✓ | step up in degree — done; the speed carries no side information |
| G66 the tower and the carry | bears ✓ | the split-prime tower computation reuses FS-38/FS-66's tools |

## R. The ledger rows' mechanisms

| rows | verdict | extraction |
|---|---|---|
| 1–11 (two circles, seam, fan ⟺ coverage, one-pivot cap, strip) | bears, low | the concentric two-circle system over ℚ(√3,√5): the seam σ needs √33 and is absent; whether any unit chord joins the radius-1 and radius-1/√3 circles in-field is one computation (row 17's classification) — a seed question, deferred |
| 12–13, 15–16, 19, 21 | silent | K-specific negatives |
| 14, 17 (gluing classification; depth-one candidates finite in any field) | bears ✗ | the descent's candidate space is finite here too — the growth instrument of G33 |
| 20, 22–24 (exactly four-chromatic seam objects) | silent | K's ladders need σ |
| 25 | silent | no spindle |
| 26–27 (anatomy; quadrature law) | bears ✓ | G12 |
| 28 (`Quadrature.lean`: `sqrt5_indep`, `sqrt15_split`, `quadrature_rho15`) | bears ✗ | **kernel facts about ρ₁₅ already exist** — phase 2's kernel form starts from them |
| 30 (criticality factorization; pigeonhole carriers 122 / 49 / 9) | bears ✗ | carrier sizes for the pigeonhole form; G15 |
| 31 (`mono_pair_of_not_colorable_append`, the transmuter; a composed union five-chromatic by kernel-covered cubes) | bears ✗ | **the kernel route for pigeonhole × kill already exists** (`Pigeonhole.lean`) — phase 2's alternative to the chain if 1d lands the disjunctive form |
| 32–41 | silent | six-programme, interval, cells |
| 42 (arity floor; `arityFloor_le_of_degree`) | bears ✗ | **nothing was asked between arity 2 and the control**: measure the arity floor at four colours on the densest core (`tools/arity.py`) — a compulsion at arity 3 is a pigeonhole carrier |
| 43 (transport by isometry; `Forces.planeIn`) | used ✓ | the chain's transport |
| 44 (`not_colorable_of_forced_equal` at any d ≥ 1/2; the {1, d} tools) | bears ✗ | **for the two-copy closers (`δ = 2`, `δ = 4/7`) the kernel consumer is row 44's theorem directly**, no chain lemma needed; and `tools/twodist.py` is G32's instrument |
| 45 (batch descent; spare-colour lemma) | used ✓ / bears ✗ | the 3-adic gate used the lemma; the descent is G33's growth |
| 46 (`copyUnion`, `chromaticNumber_copyUnion_le`) | bears ✗ | the arena's kernel form, if ever needed |
| 47 (residue colouring proper on descent objects; the cheats) | bears, low | the "cheat" methodology = pigeonhole constraints as non-unit edges |
| 48, 49 | = G39, G40 | above |
| 50–51 | used ✓ | additive screens |
| 52–53 | used ✓ | L = 5 |
| 54 | silent | lifting |
| 55 (residue obstruction at 11, five colours) | silent at four | Γ₁₁ is not four-colourable, so the map carries no information at four |
| 56 (`unitQuadrance_colorable_of_quotient`; `addCayleyMap`) | bears ✗ | **the kernel form of the quotient screen** — G62's extraction lands as a theorem |
| 57 (Theorems A, B) | used ✓ | `ψ` is a Theorem-A colouring of the 2-unit sub-plane |
| 58 (Moser recipe threshold: no minimal gadget at k ≥ 4) | bears ✓ | forced pairs at four need non-minimal constructions; sizes |
| 59 (2-adic law over K) | used ✓ | its analogue is §3.1 |
| 60 (plane freedom over ZMod p) | silent | finite planes |
| 61 | silent | |
| 62 (overcompression = orbit-closure gap) | bears, phase 2 | minimisation |
| 63 | silent | |
| 64 (the ρ₆₃ arena: the field screen selected the rotation) | bears ✓ | the sweep's field restriction |
| 65 (dropping the shape: additive-pair route dead iff `4 ∣ n`; the free circle; growing a base only shrinks the interface pattern set) | bears ✓/✗ | `n = 4`: the additive-pair route is dead, so the arena's four-colouring is non-additive — consistent with G40; **the interface-pattern instrument** (a kill test from one base colouring) was not reused — phase 1d's sweep can use it as a fast screen |
| 66 (fan gap at 11) | silent at four | |
| 67 (the 2-adic tower over K: tight, forced from level 5, the classifier) | **bears ✗** | G54's extraction: the same computation at the split prime |
| 68–70 | silent | window |
| 71 (`χ_f(K²) = 4`; the blow-up stays in the field; FS-56's checker) | bears ✗ | G60's extraction |
| 72 (3-adic barrier) | used ✓ | the gate |
| 73–74 (quadratic witnesses; census; degree law; typed nulls) | used ✓ | shapes and aiming |
| 75 (towers do not drop) | bears, tools | the tower machinery |

## M. The method rules (§ Grokkings G21/G30 and § Building / § The gate)

| rule | verdict |
|---|---|
| ask the whole graph directly before any finder (G66) | used ✓ |
| measure before specifying (WORKFLOW 3) | used ✓ |
| a positive control proves an instrument finds the shape its generator can represent | **✗ — the only four-colour control was Haugland's, a virtual edge (contraction); the `forces` encoding at four colours has no positive control in any field.** Harder's forcer over K (V + V + H, 745 points) is it; it needs ℚ(√3,√11) arithmetic — my `po_kempe_control_K.py` has the field; the fabric tool does not. Phase 1d |
| every check seen to fail; plants | used ✓ |
| break the symmetry; UNKNOWN is about the encoding | used ✓ (G27's Galois symmetries not yet) |
| checkpoint; kill by pid, verify by effect; setsid forks | used; one owner miss |
| one heavy job at a time | used |
| enumerate the parameter first, screen objects second | ✓ the sweep |
| when two numbers are compared, one thing differs | used |
| carry what a number measures (G65's speed) | misread once, corrected |

## X. The extractions, ranked, and the phase they go to

| # | extraction | from | phase |
|---|---|---|---|
| 1 | **The split-prime tower classifier**: levels 1–5 of `Cay((O/𝔭^m)², split torus)` at four colours — tight up the tower? at which depth does forcing start? which finite direction sets inherit it (the Kempe reach as the test: full rank ⟹ inherits)? | G54, G46, row 67 | 1d |
| 2 | **Harder's forcer over K as the positive control** of the `forces` encoding and of the lens/word shapes at four colours | method rule | 1d |
| 3 | **The quotient sweep on L6** at `N = 5 … 12`: a proper four-colouring of `Λ/NΛ` kills the lattice at every radius (row 56 makes it kernel) | G62, row 56 | 1d |
| 4 | **The rich 2-unit lattices** (212 / 660 / 1,220 unit vectors): Kempe reach; if rigid, lens shapes on them | G61, G37 | 1d |
| 5 | **Lens shapes with cores**, per target, on L6 and on whatever 4 finds rigid; targets extended by `4/√3` and antipodal pairs | Haugland; G9 | 1d |
| 6 | **The pigeonhole × kill route**: `{1, δ}` distance-graph asks on 2-unit fabric (does every four-colouring have a monochromatic δ-pair?) and `separated δ` asks on wall-broken fabric (the kill) at δ ∈ {2, 4/3, 8/3, 4} | G15, G16, G32, rows 30–31, 44 | 1d |
| 7 | **The sweep's ranking**: cross-edge density and cycles through both halves, the live radius sums, the off-diagonal share; every in-field type-M member by name; unions of two rotated copies | G7, G12, G14, G52 | 1c/1d |
| 8 | Galois symmetry breaking and a Galois-invariant finder | G27 | 1d encoding |
| 9 | The critical-set filter on candidates for δ > 2 | G39 | 1d filter |
| 10 | The arity-floor measurement on the densest core | row 42 | 1d, if budget |
| 11 | `χ_gf` on small dense `H ⊂ L6` (FS-56's LP) | G60, row 71 | 1d exploratory |
| 12 | Counterexample-guided growth toward a forced pair | G33, rows 14, 17, 45 | priced, then decide |
| 13 | Prior art for the Kempe screen | G49 | the close |
| 14 | Kernel notes: `quadrature_rho15`, row 44 for two-copy closers, row 31 for the pigeonhole form | rows 28, 31, 44 | phase 2 |

*At the close (WORKFLOW 9): this section is re-read against what 1d found; every extraction that paid and every entry that should
have borne and did not is recorded under step 3g.*
