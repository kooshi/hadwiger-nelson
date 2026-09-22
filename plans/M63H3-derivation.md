# M63 phase H3 — the derivation file: dropping `[Parts2020a]`'s coordinate shape (FS-71 batch 4d)

*Filed 2026-09-23 by the batch-4d implementer (FS-71, the theorem audit). Home for theorems proved in
`plans/M63-phaseH3-*.md` and `plans/POROS-2026-09-12-m63-phaseH3.md` — the material behind ledger row 65
(the additive-pair route theorem, dropping the shape, the family's six results) and `CLAUDE.md` G62 (every
witness is a twisted bilayer / the coincidence-rotation family), whose home the seed inventory names as this
phase's §PA.4. Ids `M63H3-T1`… Enumeration in `data/fs71/batch-4d.md`.*

## The theorems

**M63H3-T1 — The cross-edge law for the type-M family, in closed form; the endpoint bound is its corollary.
[hand; the cross-edge engineer, 2026-09-12]** Setting: `K = ℚ(√3,√11)`, `h(K) = 1`, `𝔭` a prime of `O_K`
above 2 (`e = 2, f = 1`, residue field `𝔽₂`); `n ≥ 1`, `ρ_n = cos θ + i sin θ` with `cos θ = (2n−1)/(2n)`;
`M = (1/D)·O_K²`. **(H1)** `√(4n−1) ∉ K` (equivalently `sin θ ∉ K`) — load-bearing: if it fails, `ρ_n ∈ K(i)`
and `chromaticNumber_seamPlane` (kernel) four-colours the whole arena, so every statement below is vacuous
without it. For `u, v ∈ K²` under (H1): `|u − ρ_n v|² = 1 ⟺ det(u,v) = 0 ∧ 2cos θ·(u·v) = |u|² + |v|² − 1`
(the split lemma). Given `det(u,v) = 0`, every nonzero `x ∈ O_K²` is `c·x̂` with `x̂` primitive (`h(K) = 1`),
and the points of `M` on the line `K·x̂` are exactly `{(g/D)x̂ : g ∈ O_K}` (the line-structure lemma), so a
cross edge has a **kind** `t = h/g ∈ K`. With `V := n(g−h)² + gh` (the principal binary quadratic form of
discriminant `1 − 4n`, the family's own radicand): `|u|² = ng²/V`, `|v|² = nh²/V`, `σ = |u|²+|v|² = n(g²+h²)/V`,
`δ² = |u−v|² = n(g−h)²/V` — homogeneous of degree 0 in `(g,h)`, so coprimality is a normalisation only. **The
endpoint bound as a corollary:** with `τ = h/g`, `|u|² = n/(nτ² − (2n−1)τ + n)`, minimised at `τ = cos θ`,
giving `|u|² ≤ 4n²/(4n−1) = 1/sin²θ` at every Galois conjugate simultaneously — material outside that disk
carries no cross edge at all, whatever the base's own extent. *Proof:* `plans/M63-phaseH3-crossedges.md`
§12.1–§12.4 (Lemma "the split", Lemma "line structure", Proposition "the form", the endpoint-bound
corollary); the closed form verified against the original law at 4,000 random `(n,g,h)`, 0 disagreements, and
against every measured family (12/12 retrodicted, M63H3-T2). *Proof verdict:* closes. *Rests on it:* M63H3-T2's
two-case criterion; row 65 item (i); the base-free counting law `ν·V = n D²` (§12.4, a corollary of the split
lemma, `Sh(nD²/V)` the count of cross edges of kind `t` with no base and no radius — reproduced `ρ₆₃`'s
rational family `100/9 ↔ 64/9` out of sample, §12.7). *Rests on it:* M63H3-T3's monotonicity theorem (the
"material past the endpoint bound adds no cross edge" half). *Prior art:* `M63G-T2` (batch 4b,
`plans/M63G-derivation.md`) already proves the endpoint bound `t ≤ 1/|sin θ|` for a general `cos θ ∈ K`
collinear pair by the same positive-definite-quadratic-form argument; this entry's split/line/closed-form
chain is the same mechanism specialised and made exact (the `(g,h)`-parametrised `V, σ, δ²` closed form is new
here, not in M63G-T2's more general two-linear-equation statement, M63G-T3). Nearest held: none specific to
this closed form; zbMATH: `ab:"unit distance" & ab:"valuation"` (0 hits), `ab:"unit distance graph" &
ab:"number field"` (0 hits). *Kernel:* declined — depends on `h(K) = 1` and exact valuation arithmetic; no
Lean infrastructure built for the construction.

**M63H3-T2 — Theorem (the two-case monochromaticity criterion). [hand; the cross-edge engineer, 2026-09-12]**
With `g, h ∈ O_K` coprime, both nonzero, `g ≠ h`, `e = v_𝔭(g−h)`, `V = n(g−h)²+gh`: `v_𝔭(δ²) = 2e + v_𝔭(n) −
v_𝔭(V)`, and the cross edges of kind `t = h/g` are monochromatic (invisible to the residue colouring) iff
that is `> 0`. Exactly two cases arise (coprimality forbids `𝔭 | g` and `𝔭 | h` together): **Case A**
(`v_𝔭(g) = v_𝔭(h) = 0`): `e ≥ 1`, `v_𝔭(V) = 0`, so `v_𝔭(δ²) = 2e + v_𝔭(n) ≥ 2 > 0` — **monochromatic for
every `n`, odd `n` included**, and `v_𝔭(|u|²) = v_𝔭(|v|²) = v_𝔭(n)`. **Case B** (exactly one of `g,h`
divisible by `𝔭`): `e = 0`, monochromatic iff `v_𝔭(gh) < v_𝔭(n)` — **needs `n` even**, since
`v_𝔭(n) = 2v₂(n) = 0` for odd `n`. *Proof:* `plans/M63-phaseH3-crossedges.md` §12.5, ending "∎"; `O_K/𝔭 = 𝔽₂`
forces `g ≡ h ≡ 1 (mod 𝔭)` in Case A (a `𝔭`-unit is `≡ 1`), giving `e ≥ 1` and the strict-minimum valuation
argument; Case B is the same strict-minimum argument with `v_𝔭(g−h) = 0`. *Proof verdict:* closes. **§12.6
states what it does NOT say** (kept as scope, not a separate theorem): it classifies a given kind, not which
kinds a base realises (the gap that sank the family screen of `plans/M63-phaseH3-plan.md` §9); it is not a
colouring claim — 24 monochromatic off-diagonal constraints is not a refusal of four colours; one prime at a
time; the base must lie in `(1/D)O_K²` over this `K`. *Rests on it:* the retrodiction of all twelve measured
cross-edge families at `n = 2, 4, 16` exactly, including the case-A valuation signature; two out-of-sample
landings (`ρ₆₃`'s `100/9 ↔ 64/9` from the counting law before being looked up; P-XE-1's registered `n = 3`
prediction of two monochromatic families both at `v_𝔭 = 0` — later voided as an (H1)-violating test case, not
a landing, since `4·3−1=11 ∈ K`'s square classes, §12 of `plans/M63-phaseH3-plan.md`); ledger row 65 item (iv).
*Prior art:* the surrounding machinery (residue colouring, valuation law) is this project's own kernel result
(row 59); the two-case valuation classification over a specific `𝔭`-quadratic form is ours, not located
elsewhere; nearest held: none specific; zbMATH: `ab:"principal form" & ab:"discriminant" & ab:"representation"`
(2 hits, unrelated — quadratic-form representation theory, not this valuation criterion). *Kernel:* declined
— exact valuation arithmetic over `O_K`, no Lean infrastructure.

**M63H3-T3 — The base-growth monotonicity theorem, and the circle's position on the endpoint bound. [hand;
the arithmetic engineer, 2026-09-12]** Every proper four-colouring of a larger base `B' ⊇ B` restricts (via
`G.induce`) to one of `B`, so the set of interface patterns a base can present on a fixed circle is monotone
**non-increasing** as the base grows, while the circle count is fixed (every circle point lies inside the
endpoint-bound disk: `√n / (2n/√(4n−1)) = √(1 − 1/(4n)) < 1` for every `n`). Consequently, in G53's counting
compulsion (`CLAUDE.md`), `L = min_h |B(h)|` over proper four-colourings `h` of the base is monotone
**non-decreasing** as the base grows, so `2L > (circle count)` moves strictly the right way and never back:
**growing a base past the endpoint bound is a free lever for a refutation and can never hurt one.** **Corollary
(the corollary nobody predicted):** the diagonal circle sits at exactly `√(1 − 1/(4n))` of the endpoint-bound
radius in every member of the family (93.5% at `n=2`, 96.8% at `n=4`, 99.2% at `n=16`) — **so the circle is
essentially on the arena boundary by construction**, and the free-circle theorem's hypothesis (`M63H2-T2`,
full circle degree "once the arena reaches radius `|k|+1`") has never been satisfied by any object this
project has built (G30 failure mode 5 — a correct theorem over a domain nothing meets; the caveat is now
carried in `M63H2-T2`'s own entry, `plans/M63H2-derivation.md`, added by this batch). *Proof:* `plans/
M63-phaseH3-module.md`
§5b; the same statement and proof in `plans/M63-phaseH3-plan.md` §8, both drawing on `Absorb.lean`'s
`restrictColoring` for the restriction half (used explicitly and by name in the sharper restatement,
`M63H4-T2`). Measured directly: `[Parts2020a]`'s 374-vertex base sits *past* its own endpoint bound by
1.222× (37+14 orbits, not a disk cut; 12 of 509 vertices certainly beyond it, at most 27); phase H2's `n=16`
base stopped *exactly* at it (25,567 points, independently reproduced). *Proof verdict:* closes. *Rests on it:* row 65 item (ii); the interface-pricing instrument (`M63H3-T9`) and its "monotonicity lever" measurement
(`10²¹ → 10⁴` collapsing for a 2.6× base, `plans/M63-phaseH3-solver.md` §3a); the "un-eliminated is not alive"
scoping used throughout the phase. *Prior art:* elementary (restriction of a proper colouring to an induced
subgraph); the endpoint-bound-as-fraction-of-radius corollary and its use as a design lever are ours; nearest
held: none specific; zbMATH: `ab:"proper coloring" & ab:"monotone" & ab:"subgraph"` (0 hits). *Kernel:*
declined — the restriction half is already in `Absorb.lean` (`restrictColoring`); the circle-position corollary
is elementary algebra, not built as a Lean statement.

**M63H3-T4 — Theorem (the free-circle kill), and the additive-pair route theorem it produces. [hand; the
solver engineer, 2026-09-12]** **(the free-circle kill)** If every point of a type-M arena's diagonal circle
`|p|² = n` lies in `2L` (`L` the ℤ-span of the base's unit vectors), then every additive four-colouring `φ` of
`L` (a homomorphism `L → (ℤ/2)²` nonzero on every unit vector) sends the whole circle to the centre's colour
(the colour group is 2-torsion, so `φ(2w) = 0`), so every diagonal cross-edge constraint `f(v) ≠ g(v)` fails
for every additive pair `(f,g)`, and **no additive pair can four-colour the arena.** *Proof:* `plans/
M63-phaseH3-solver.md` §4a, ending "∎"; measured across four objects (`n=2` shape-free: circle at odd
multiples of the unit shell, spread colouring; `n=4` shape-free and shaped, and `n=16` shaped: circle exactly
`2×` or `4×` the shell, colouring concentrated wholly on the centre's colour). **The family screen it
defines, `plans/M63-phaseH3-solver.md` §4b:** run over the shape-free lattice at `n ≤ 20` (every count with
its population): the circle lies in `2L` iff `4 | n`, so — restated as ledger row 65's headline — **the
additive-pair route is open exactly when `4 ∤ n`, and killed exactly when `4 | n`**, base-free, radius-free,
solver-free, verified on all 19 members `n ≤ 20` with the circle count ranging 60–336 and the verdict never
tracking it. **Instance, at `n = 2` (the phase's object):** an exhaustive search over `144 additive f` ×
`144 additive g` × `6` centre-fixing permutations = 124,416 combinations finds **576** clearing all 132
interface constraints (60 diagonal + 72 off-diagonal; the centre's own `f(0)=g(0)` is enforced by
construction and its 120 further cross edges verified redundant), radius-independent by the same theorem
restated for `f, g` fixed and the cross-edge set fixed by the endpoint bound (`plans/M63-phaseH3-solver.md`
§2c, ending "∎"); exercised at three radii (32,617 / 83,905 / 301,537 vertices), 0 monochromatic each. *Proof verdict:* closes. *Rests on it:* row 65's headline and item structure; the
family-level consequence that every 6-open member FS-30 lists (16, 20, 44, 60, 64, 76, 108, 112) is `≡ 0
(mod 4)` and immune to this route; the retracted mechanism §2e ("dropping the shape multiplies the
colourings") REFUTED by the `n = 4` shape-free control (same 144-member family, still `0 of 124,416` — family
size is not the cause; recorded so it is not rediscovered). *Prior art:* the colouring-side instance of G52's
"the certificate's defeat is automatic whenever `t` is even" (already filed, `M63H2-T2`'s scope note and G52's
own grokking), read from the additive family rather than the residue map — the two are one fact, arrived at
from opposite directions; the 2-torsion mechanism itself is elementary group theory; nearest held: none
specific; zbMATH: `ab:"additive coloring" & ab:"unit distance"` (0 hits). *Kernel:* declined — an elementary
group-theoretic argument over a specific finite family of homomorphisms; no Lean form built.

**M63H3-T5 — Parts's coordinate shape is a `ζ₆`-submodule, not an `i`-submodule, and dropping it doubles the symmetry order without changing the ring. [hand + tools; the arithmetic engineer, 2026-09-12, correcting the product owner's own P-H3-3]** Parts's shape (`p₁ ∈ ℚ(√33)`, `p₂ ∈ √3ℚ ⊕ √11ℚ`) is stable under `ζ₆ =
(1+i√3)/2` and the whole order-24 group (verified: multiplying `p₁+ip₂` by `ζ₆` sends `p₁ ↦ (p₁−√3p₂)/2`,
`p₂ ↦ (√3p₁+p₂)/2`, and both slots return to where they started), but **not** stable under multiplication by
`i` (which swaps the two coordinate slots; `i·ℚ(√33) ⊄ ℚ(√33)`), so it is rank 4 inside a rank-8 module — not
an index-4 submodule, an infinite-index one — and its own rotation group has order 24 against the shape-free
module's order 48 (`⟨ζ₁₂⟩`, verified `i`-stable). **Dropping the shape IS adjoining the quarter turn.**
**The closure/ring distinction:** the maximal `ζ₆`-stable (order-24-stable) module in Parts's shape has index
4 in `ℤ⁴` — four times denser than his own index-16 congruence lattice — but his congruences are the
conditions for **multiplicative** closure (a ring, `R̄₂`), verified over 3,418,801 products with zero
failures, while the denser index-4 module fails multiplicative closure at its second product tested; **so
Parts's congruences are necessary for the ring and only sufficient (not necessary) for the group.** And
generation — the ℤ-span of the unit vectors, the operative condition for a unit-distance graph's edge set —
coincides with his lattice exactly (index 16 both ways) but not with the denser index-4 module (span index 16
≠ module index 4). *Proof:* `plans/M63-phaseH3-module.md` §3a–§3e (the `ζ₆`-action verified component by
component against `tools/typem.py`'s own comment; the 256 residue-class exhaustive sweep for maximal stable
submodules; the multiplicative-closure test at the ring's own denominator; the generation index computed two
independent ways — hand Hermite reduction and `sympy.hermite_normal_form` — agreeing on all six control
values). *Proof verdict:* closes. *Rests on it:* the shape-free module's construction throughout the phase
(16,309-point base, index 256 in `ℤ⁸`); the prior-art reading (`M63H3-T7`, `T8`) that dropping the shape is
adjoining `i`, credited to David Speyer. *Prior art:* the ring identification confirms (not merely repeats)
the Polymath16-wiki-sourced congruences already attributed in `plans/M63-phaseH3-prior-art.md` §PA.0 finding
2 (Gibbs's `R̄₂` conditions); the ring/group distinction and the generation criterion are ours; nearest held:
`[Polymath16threads]` (BIBLIOGRAPHY.md, the ring `R̄₂`); zbMATH: `ab:"submodule" & ab:"stable" & ab:"rotation"`
(0 hits). *Kernel:* declined — an exhaustive residue-class sweep and an exact index computation, no Lean form
built.

**M63H3-T6 — The `n = 2` shell is empty over the whole shape `M`, at every denominator, by Hasse local norms — an independent re-derivation of phase H2's Fact 2. [hand; the prior-art agent, 2026-09-12]** For
`p = u + v√−3 ∈ M` (Parts's shape), `|p|² = 2` means `u² + 3v² = 2` over `ℚ(√33)`, i.e. `2` is a relative
norm from `M/ℚ(√33)`. Since `33 ≡ 1 (mod 8)`, `2` splits in `ℚ(√33)` with each completion `≅ ℚ₂`; since
`−3 ≡ 5 (mod 8)`, `ℚ₂(√−3)` is the **unramified** quadratic extension of `ℚ₂`, whose norms all have even
valuation, while `v₂(2) = 1` is odd — so `2` is not a local norm at either place above 2, hence not a global
norm, and **the `n = 2` circle is empty over all of `M`, at every denominator.** *Proof:* `plans/
M63-phaseH3-prior-art.md` §PA.0 item 5. *Proof verdict:* closes. **Control, stated in the source as its own
purpose:** this re-derives phase H2's own Fact 2 (`plans/M63-phaseH2-arithmetic.md` §3b, "`v₂(d²n)` has the
same parity as `v₂(n)` for every `d`") by a route sharing no code or method with it — Hasse local norms
against Baake–Grimm's inert-prime shelling criterion — so the two constitute a free two-sided positive
control on each other rather than a new independent finding; this upgrades P-H3-2's measured "0 circle
points" from a count on one lattice to a theorem about the whole field. *Rests on it:* P-H3-2 (`plans/
M63-phaseH3-plan.md` §3); the phase's registered prediction scoring. *Prior art:* Hasse's local-global
principle for quadratic forms is classical (Hasse–Minkowski); the specific computation (splitting of 2 in
`ℚ(√33)`, ramification of `−3` there) is ours as applied; nearest held: none specific; zbMATH: `ab:"local
norm" & ab:"circle"` (0 hits). *Kernel:* declined — a two-line Hasse-principle computation, no Lean
infrastructure for local fields of this kind built here.

**M63H3-T7 — The coincidence-rotation identity: the type-M family is, up to a half-turn, the `Σ = n` coincidence-rotation family of an imaginary quadratic order. [hand + tools, verified symbolically; the prior-art agent, 2026-09-12; G62's core]** With `w = (1 + i√(4n−1))/2` (the standard generator of the ring of
integers of `ℚ(√−(4n−1))`, valid since `4n−1 ≡ 3 (mod 4)`): `|w|² = n` and **`w̄/w = −ρ_n`** exactly. Verified
symbolically for general `n`, and numerically at `n = 2, 3, 4, 16`: `−3/4 − i√7/4`, `−5/6 − i√11/6`,
`−7/8 − i√15/8`, `−31/32 − 3i√7/32`. Since `−1` is the coincidence rotation of index 1, **`ρ_n` is, up to a
half-turn, the coincidence rotation of index `Σ = n` of the planar lattice `ℤ[w]`** — the imaginary-quadratic
non-generic case of `[BaakeZeiner2017]` Theorem 5.14 (crediting `[BaakeScharlauZeiner2011]` Props. 2.3, Thm.
2.6). *Proof:* `plans/M63-phaseH3-prior-art.md` §PA.4(b), direct algebraic verification (`w̄/w` computed and
compared to `−ρ_n` symbolically, then at the four numerical instances). *Proof verdict:* closes. *Rests on it:* `CLAUDE.md` G62 in full (the entry's core identity); `M63H3-T8`'s commensurate/bounded corollary and Σ7
instance; G7's family theorem (M63H2-T1), now identified as a classical coincidence-rotation family rather
than a construction with no name in the literature. *Prior art:* `[BaakeZeiner2017]` Theorem 5.14 supplies the
general classification (multiplier ring an order in an imaginary quadratic field, the non-generic case); the
sweep found **no paper stating this specific family as a family** — "this is a recognition, not a citation"
(source's own words) — so what is ours is the identification `w̄/w = −ρ_n` and the `Σ = n` reading applied to
G7's radicand form. Nearest held: `[BaakeZeiner2017]`; zbMATH: `ab:"unit distance" & ab:"coincidence"` (0
hits), `ab:"coincidence rotation" & ab:"imaginary quadratic"` (0 hits). *Kernel:* declined — symbolic algebra
over a parametrised family, no Lean form built.

**M63H3-T8 — Commensurate ⟹ periodic ⟹ bounded by the base field's local bound, and the `Σ7` instance.
[hand; the owner, synthesised from M63H3-T7 and already-kernel facts, 2026-09-17]** A twist is *commensurate*
with a module when the two layers share a finite-index sublattice, equivalently when `√(4n−1)` already lies
in the module's field; then the bilayer is periodic under that shared sublattice, so the arena graph on it is
a pullback of `Cay(finite quotient)`, and its chromatic number is bounded by the quotient's — **a commensurate
twist cannot raise the colour count above its base field's local bound.** Instance: `n = 3` (the Moser twist,
`Σ3`, radicand 11 already in `K`) is commensurate and can never reach five; `n = 4` (`Σ4`, radicand 15 → `√5`)
and `n = 16` (`Σ16`, radicand 63 → `√7`) are incommensurate and generate new fields, screened by the 2-adic
wall test. **The `Σ7` instance:** the plane's own 7-colouring (`Instances/Seven.lean`, kernel, M36) colours by
cosets of the norm-7 Eisenstein ideal `(−3 + ζ₆)`; its index-7 sublattice is identified as the coincidence
site lattice of the 21.79° twist — the `Σ7` coincidence rotation, the textbook twisted-bilayer-graphene
commensurate angle. *Proof:* not written out as a derivation anywhere on disk in the phase H3 files — the
commensurate/periodic/bounded chain and the `Σ7` identification appear as assertions in `CLAUDE.md` G62 itself
("(Derived at M63 phase H3 and left in `plans/M63-phaseH3-prior-art.md` §PA.4; promoted here 2026-09-17.)"),
and §PA.4 as read here contains the core identity (`M63H3-T7`) but not a written proof of the periodicity
step or the `Σ7` computation; `Instances/Seven.lean`'s docstring (kernel, M36) independently confirms the
`τ = −3+ζ₆`, norm-7 ideal fact the `Σ7` reading rests on. *Proof verdict:* **unsure — owner to re-derive**
(the periodicity/bounded argument is plausible and elementary — a shared finite-index sublattice makes the
graph a covering of a finite quotient graph, whose chromatic number bounds any of its covers' — but no
written chain from "commensurate" to "bounded by the local bound" was found in the phase's own record, only
in the grokking's own prose). *Rests on it:* `CLAUDE.md` G62 in full; G7's ladder (row 64, M63H2-T1) restated
as "rung by rung, commensurate or not". *Prior art:* the periodicity-implies-bounded mechanism is the same
shape as row 56's finite-plane bound and G68's fan-gap closure (both kernel), applied here to a coincidence
sublattice rather than a residue ideal; the `Σ7` computation is `Instances/Seven.lean`'s own kernel fact,
reread in the crystallography vocabulary; nearest held: `[BaakeZeiner2017]`; zbMATH: `ab:"commensurate" &
ab:"periodic" & ab:"chromatic number"` (0 hits). *Kernel:* declined — pending the owner's re-derivation; if it
closes, a natural candidate to formalise as a general "periodic ⟹ bounded" lemma beside `unitQuadrance_
colorable_of_quotient` (row 66's mechanism, already kernel).

**M63H3-T9 — The local-freedom product is a certified lower bound on a base's achievable interface-pattern count, and it is a one-sided kill test for the interface reduction. [hand; the solver engineer, 2026-09-12]** Let `W` be an independent set of vertices in a base `B` (no induced unit edges — the "interface"). Fixing any
one proper colouring of `B ∖ W` and letting each `w ∈ W` independently take any colour outside `c(N(w))` gives
a family of colourings realising **at least `∏_{w∈W}(4 − |c(N(w))|)`** distinct patterns on `W` — a certified
lower bound, computable in milliseconds from one colouring, no search. **It is one-sided**: on phase H2's
`ρ₆₃` and on the record's own lattice the product evaluates to exactly 1 (no interface vertex has local
colour freedom in *any* colouring, since each already sees three colours in its neighbourhood), while their
TRUE achievable-pattern counts are 552 (enumerated, `M63H2-T10`) and unmeasured respectively — **a value of 1
is the instrument going silent, not evidence of rigidity**, and "large interface pattern count" (this
instrument, large) and "four-colourable by an additive pair" are demonstrably independent properties (the
`n=4` shape-free arena has the product `≥ 4.1 × 10³`, unaffordable by the phase-H2 route, and is still killed
by no additive pair). *Proof:* `plans/M63-phaseH3-solver.md` §3, §3a (the bound itself elementary — `W`
independent means each vertex's colour choice is unconstrained by the others once the rest of the graph is
fixed; the one-sidedness and the independence-of-properties claims established by direct measurement on four
named objects, not derived further). *Proof verdict:* closes. **Instance:** at `n=2`'s endpoint-bound arena
the product is `≥ 3.83 × 10²¹` against phase H2's exact 552 — nineteen orders of magnitude, certifying the
interface reduction was never affordable here without a solver. *Rests on it:* row 65 item (vi); the
"monotonicity lever" measurement (`10²¹ → 10⁴` for a 2.6× base, `M63H3-T3`'s consequence); the retraction of
the "worth more than the object" reading once a third object (`n=4` shape-free) separated the two properties.
*Prior art:* an elementary counting bound (the size of a product of independent local choices); the
"go/no-go before paying for a reduction" framing is a method rule, not a citable result; nearest held: none
specific; zbMATH: `ab:"list coloring" & ab:"independent set" & ab:"lower bound"` (3 hits, standard list-colouring
extremal results, unrelated to this specific interface-reduction application). *Kernel:* declined — a
one-line counting argument, applied ad hoc to named finite objects; no reusable Lean lemma built.

## Readings and measurements that were called theorems

- **The conjugate-condition cost, ≈ 2.0–2.6× per condition (`plans/M63-phaseH3-module.md` §5c).** Measured
  across three objects and one controlled imposition-order sweep (mean circle degree 26.00 → 10.40 → 4.00 →
  2.00 as embeddings are imposed one at a time), described as "a clean geometric decay" and "the mechanism"
  but never proved as a general law — no derivation of the decay rate is given, only the measurement and a
  predicted-vs-measured check (predicted 2.34, measured 2.00). Row 65 item (v); not filed as a theorem.
- **The three-way `24` "half-derives, and is still not called a theorem" (`plans/M63-phaseH3-crossedges.md`
  §14.2–§14.3).** `Sh(m) = 12` exactly when `m` is a pure power of 2 (measured 6/6 and 7/7); combined with
  Case A forcing `V` odd, this gives `24 = 2 × 12` **provided Case A forces `V` maximal** — which is explicitly
  **not proved** ("two for two observed, no proof, and it is not called a theorem" — the source's own words).
  Demoted here to a conjecture (below), not filed.
- **`γ̄ ~ n^0.485`, the additive-family factoring, and the `k=4`-only vulnerability of the circle multiplier**
  (`plans/M63-phaseH4-reduce-the-platform.md` §15, cross-filed under H3's family since it concerns the type-M
  construction generally): a two-point power-law fit and two observational notes, none stated as a general
  theorem in the source (filed under `M63H4`'s census instead, since the record itself is a phase H4 file).
- **The prediction that dropping the shape "multiplies the colourings, and that is what glues it"**
  (`plans/M63-phaseH3-solver.md` §2e): registered as a hypothesis, refuted by `M63H3-T4`'s own `n=4`
  shape-free control; the source explicitly leaves the retracted paragraph standing, struck, as a record of a
  registered-then-refuted hypothesis. Not filed.

## Conjectures surfaced, not claimed

- **Does Case A always force `V` maximal (hence `Sh = 24` always at a pure-2-power case-A member)?**
  (`plans/M63-phaseH3-crossedges.md` §14.2). Two instances (`n=2`, `n=4`'s case-A component), no proof; a
  case-A kind with `V = 3` would give 72 instead. Open.
- **Is `n = 2` the unique member both 6-open and affordable shape-free?** (`plans/M63-phaseH3-plan.md` §12).
  Reasoned toward (arena radius `2n/√(4n−1)` increases with `n`, so `n=2` is the family's cheapest member
  outright; `n=16` shape-free is estimated at ~40 million points), not verified by construction.
- **Whether the shape-free module's rotation group being order 48 rather than 24 changes anything about which
  `n` carry monochromatic cross edges** — raised in `plans/M63-phaseH3-prior-art.md` §PA.4 as "a live question
  sent to the arithmetic engineer" and resolved as a fact about symmetry (`M63H3-T5`) but not connected back
  to the cross-edge census.

## Prior art re-attributed

- **"Dropping the shape IS adjoining the quarter turn"** is David Speyer's restatement (Polymath16 blog,
  25 April 2018), already attributed in ledger row 65 and `plans/M63-phaseH3-prior-art.md` §PA.0 item 3; no
  `BIBLIOGRAPHY.md` edit needed (`[Polymath16blog]` is the key already in use in row 65; it does not match
  `tools/bib_audit.py`'s bracketed-key regex — `\d{4}` requires four consecutive digits and "16blog" has only
  two before the letters — so it is invisible to that check on both sides; pre-existing, not introduced here).
- **The exact move — points of a full field plane as a base, truncated by a disc — was proposed by Lior
  Silberman on the Polymath16 blog, 19 April 2018**, already attributed in `plans/M63-phaseH3-prior-art.md`
  §PA.0 items 1–2 and not repeated in `CLAUDE.md`; recorded here as a pointer, no edit needed.
- **The coincidence-rotation classification (`M63H3-T7`)** is `[BaakeZeiner2017]` Theorem 5.14 crediting
  `[BaakeScharlauZeiner2011]`; both rows already carry this role in `BIBLIOGRAPHY.md` (verified present); no
  edit needed.
- **D-reducibility's classical machinery** is cross-filed under `M63H4-T3` (a phase H4 file group), not
  repeated here.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M63H3-T1 | declined — exact valuation arithmetic over `O_K`, `h(K)=1`; no Lean infrastructure |
| M63H3-T2 | declined — exact valuation arithmetic, no Lean infrastructure |
| M63H3-T3 | declined — restriction half already in `Absorb.lean` (`restrictColoring`); the corollary is elementary algebra |
| M63H3-T4 | declined — elementary group theory over a named finite family |
| M63H3-T5 | declined — exhaustive residue-class sweep and exact index computation |
| M63H3-T6 | declined — a two-line Hasse-principle computation, no local-field infrastructure built |
| M63H3-T7 | declined — symbolic algebra over a parametrised family |
| M63H3-T8 | declined, pending the owner's re-derivation (unsure verdict); a candidate general lemma if it closes |
| M63H3-T9 | declined — an elementary counting bound applied ad hoc |
