# FS-86 stage C — Coxeter's working file

*Competitor Coxeter (Opus 5.5). Brief: data/fs86/briefs/C-competitor-brief-coxeter.md. Scratch only; commit nothing.*

## State (resume point)

- 2026-09-25 ~03:00 UTC: read the brief, plan §0, §IQ, §S.1–S.4, B1 (V0–V4, VK), B2/B3. CLAUDE.md on disk checked current.
- **Incident:** three consecutive replies hit the output-token limit and were discarded. Their content is not in my context: whatever
  reasoning they held is lost. Nothing was written to disk before this file. Rule from now on: short steps, save after each.
- First route written (C1–C4), second line (C6–C7). Poros told. Poros released HD1–HD4 (plan-phase hunches) and two cards to me:
  C-S2 (is ℚ(√2,√3) a class member with triangles?) and, on my route, "does `H(ℚ)` already refuse four colours?" (if yes, X is vacuous).
  Poros checked C1–C2 and C3's places: no gap found.
- Poros's `H(ℚ)` card answered (open in print; §First route). **Round-1 report sent to the owner** (2026-09-25): no K-item claimed
  outright; C7 offered as a candidate K1 with its "T(3) + monotonicity" caveat. Awaiting Poros's adjudication.
- **Budget:** about 390k consumed (the three lost replies included). Round 2's cap is about 400k, so a successor may take over from here.
- **Round-2 plan (not started, nothing claimed):** HD1 made rigorous — `Θ₄(ℚ(√59))` holds only torsion characters, so FS-83 at `k = 4`
  (the plan's §S.5 fallback) cannot give `F(R) = 0`. Sketch: let `C` be the closure of `(θ, ρ)(R)` in `ℝ/ℤ × O_𝔓`. If `C ∩ (ℝ/ℤ × 0)` is finite,
  `θ` is dyadic-continuous up to a finite group, hence torsion (profinite → circle has finite image). Otherwise `C = ℝ/ℤ × O_𝔓`, and one needs
  the closure `K_U` of `(θ, ρ)(U)` to spread in the first coordinate over some fibre `s ∈ S_m`. That spread plus `χ_c(P_m) = 4` (`χ_f = 4`,
  vertex-transitive) contradicts `θ(U) ⊆ [1/4, 3/4]`. **The missing lemma is the spread**, which is Poros's definitional caution in another
  form: a character is defined only modulo the global dual lattice, so "a component at a split place" needs the `C`-closure formulation.

- **2026-09-25, successor (Coxeter-2) started**; read the brief, addendum 2, preamble, this file, plan §0/§IQ/§S, FS81-T1–T6, FS38
  D2-A/D2-B, Zhang's theorem list. Poros resent HD1–HD4 and C-S2 verbatim (HD1 = "Θ₄ holds only torsion characters").
- **Round 2, step 2 done:** C10.0 and C10 (HD1 for finite-type characters, class-wide) written, §Round 2 step 2; the infinite-type gap named.
  Reported to the owner.
- **Round 2, step 3 done:** C-S2 answered yes (C12.1, C12), §Round 2 step 3.
- **Round 2, step 4 done:** the hexagon probe (C13.0, C13), §Round 2 step 4. Coxeter-2 stops here (~320k); hand-off via the preamble. **Next candidates:** (a) the relation-module lemma for "small η" (partial infinite type); (b) C-S2's card
  (exact spectra of ℚ(√2,√3)'s dyadic tower, then a derivation); (c) multi-character windows (needs `m₁(ℝ²) < 1/4`).
- Coxeter-2 token use: about 300k of 400k after C12 and report 2. Retractions now 1 (C11 overstated; corrected). Successor preamble updated.
- **2026-09-25 05:20 UTC, Coxeter-3 started** (second successor); read the brief, addendum 2, preamble, this file. Competitor now
  de Bruijn-3 (`ad2d8b0756257885b`). **Chosen move (my own, not on the ranked list): the window no-go (C14)** — every four-colouring of an
  S2-field plane pulled back from a proper four-colouring of the local unit-distance graph at finitely many archimedean and stable places
  (FS-64's adelic window format, finite level at the non-archimedean places) is periodic. Inputs: `m₁(ℝ²) ≤ 0.2470` ([AmbrusEtAl2023]
  Thm 1, Erdős's `< 1/4`), V3's level bounds, a measurable transplant of [Zhang2012]'s product argument, and gap-free propagation.
  It subsumes C10 (finite type) and item 3 (multi-character windows). Written in §Round 2 step 5.
- **Coxeter-3 stopping point (~250k by the counter):** C14, C14′, C14-K, C15 written; report 3 (final) sent. Resume from the preamble's
  Coxeter-3 update; open items ranked there.
- **Round 2, steps 5–6 done (Coxeter-3): C14, C14′ (regular windows), the FFT check of C14.2(c), C15 (homogeneous part of Θ₄ is torsion) written.** Budget: the harness counter shows ~230k consumed at this point (not the ~85k first reported).
- (earlier line) **Round 2, step 5 done (Coxeter-3): C14 proved and written** (§Round 2 step 5, with controls and scope). ~75k tokens used by Coxeter-3.
  Next: report to the owner; then candidate items: (i) the infinite-depth dyadic window (scope item 1); (ii) whether the window format can be
  widened to colourings measurable for the adelic σ-algebra (infinitely many places) — the natural home of HD1's infinite-type gap.

## First route: the split places (written 2026-09-24/25, before any held item)

**Idea.** Every stable place gives a *quotient* (a homomorphism out of `Cay(R,U)`), which bounds `P`. A **split** place `v` of `F`
(split in `L = F(i)`) gives an *embedding into* a local graph, which bounds colourings from above and transfers forcing outward.

**C1 (the split embedding) [hand].** `v` split in `L/F`: `L_v ≅ F_v × F_v`, `x ↦ ι(x) = (ι₁x, ι₂x)`, `ι₂ = ι₁∘c`, so `x̄ ↦` the swap and
`u ∈ U ↦ (t, 1/t)`. So `ι : Cay(R, U) → H(F_v) := Cay(F_v², {(t, t⁻¹) : t ∈ F_v^×})` is an injective graph homomorphism. `H(F_v)` is the
unit-distance graph of the **isotropic** plane `(F_v², x² + y²)` (`i ∈ F_v`), i.e. `[BardestaniMallahiKarai2017]`'s quadratic graph `QG_Q` for
`Q` split over the local field `F_v`.

**C2 (transfer of forcing to a split place) [hand].** If `F(R) ∋ δ ≠ 0`, then `H(F_v)` has **no** proper four-colouring.
*Proof.* Let `c` be one. For `z ∈ F_v²`, `λ ∈ F_v^×`, `g = τ_z ∘ s_λ` (`s_λ(a,b) = (λa, b/λ)`) is an automorphism of `H(F_v)`, so `c∘g∘ι` is a
four-colouring of `Cay(R,U)`, hence `c(z + s_λ ι(x)) = c(z + s_λ ι(x + δ))`; at `x = 0`, `c` is invariant under translation by every
`s_λ ι(δ) = (λd₁, d₂/λ)`, `d₁d₂ = N_{L/F}(δ) ≠ 0` (in `F_v`). The subgroup `W` these generate is `F_v²`: sums of two generators fill an open set
(the quadratic for `λ, λ′` has a square discriminant on an open set), so `W` is open, holds `π^N O²`, and holds `(λd₁, d₂/λ)` with `v(λ)`
large, whose second coordinates generate `F_v` modulo `π^N O`; symmetrically the first. So `c` is constant: improper. ∎
**Contrapositive:** a four-colouring of any split local plane `H(F_v)` gives `F(R) = 0`.

**C3 (the control at K) [derived].** VK (`F(R_K) = 4R_K`) and C2: `H(K_v)` has no four-colouring at every split place `v` of K — e.g.
`K_v = ℚ₃₇` (37 ≡ 1 mod 12, (11/37) = 1) and `K_v = ℚ₂₅` (above 5). So `χ(H(ℚ₃₇)) ≥ 5`, `χ(H(ℚ₂₅)) ≥ 5`, from row 78/85 by pure transfer.

**Where this stands (honest).** C2 is a necessary condition X for `F(R) ≠ 0`: *every split local plane of F refuses four colours.* It is
informative only if some `χ(H(E))` could be `≤ 4`. Prior art (`BIBLIOGRAPHY.md`): `[BardestaniMallahiKarai2017]` Thm 1.1 — over a local
field of characteristic 0, `χ_Bor(QG_Q) = ∞` iff `Q` is isotropic. So `H(E)` has **infinite Borel** chromatic number; its plain χ is the sup of
χ over finite subgraphs, i.e. over finitely generated `E₀ ⊂ E` of the split unit-distance graph `Cay(E₀², (t, 1/t))`. If the plain χ of
`H(ℚ₅)` (`ℚ(√59) ⊂ ℚ₅`) is also infinite (or ≥ 5), X holds on ℚ(√59) and is uninformative there. **Next step:** decide whether the plain χ of
`H(ℚ_p)` is ≥ 5 for every `p`, by a finite subgraph over a field inside every `ℚ_p` or by a Borel-to-plain argument.

**Reading of BMK (first-hand, `bmk.txt` from the held PDF, §1 Rem. 1.3 and §2 Lemma 2.7):** they call `H(E)` the *hyperbola graph*
`HG(E)` and prove only the **Borel** χ infinite; Rem. 1.3 says explicitly that the plain χ of the real isotropic graphs `G_{n,r}` may be
finite ("if the value … turns out to be finite …"). **So the plain χ of a hyperbola graph is open in print.**

**C2′ (all or nothing in `HG(E)`) [hand].** For any field `E` of characteristic ≠ 2 and any `k`: if some subgraph of `HG(E)` forces a nonzero
difference `d` at `k` colours, then `HG(E)` is not `k`-colourable. (C2's proof; for isotropic `d = (d₁, 0)` add the swap automorphism
`(a,b) ↦ (b,a)`.) So a `k`-colourable hyperbola graph has **no** forced difference at all — the local analogue of V2's dichotomy, with the
non-compact torus `s_λ` in place of the ideal property.

**What X costs at ℚ(√59) (the honest reading).** The split places `v` of ℚ(√59) are: degree one above `p ≡ 1 (mod 4)` split in `F`
(`F_v = ℚ₅, ℚ₁₇, ℚ₂₉, …`), and above every `p` inert in `F` (`F_v = ℚ_{p²}`). For `p ∤ 2·3·5·7·11`, `ℚ_{p²}` contains de Grey's field
`K(√5, √7)` and `i`, so `χ(HG(ℚ_{p²})) ≥ 5` for free — those places can never give a "no". The live ones are those with `√3 ∉ F_v`
(`ℚ₅`, `ℚ₉` at 3, `ℚ₁₇`, …). **Every real field inside such an `F_v` is triangle-free** (G57: `ω = 3` iff `√3 ∈ F`). So:
- a **"no"** by this route needs a four-colouring of `HG(ℚ₅)` (say), which would also four-colour every real field inside `ℚ₅`;
- a **"yes"** at ℚ(√59) implies `HG(ℚ₅)` holds a finite, **triangle-free** (`ζ₃ ∉ ℚ₅`), non-four-colourable subgraph: a triangle-free
  five-chromatic unit-distance graph over a subfield `E₀ ⊂ ℚ₅`, `i ∈ E₀` — Soifer 55.1's question, transplanted to the isotropic plane.
So X is a **reformulation** at ℚ(√59), not a decision: it is undecided on every member of S2. It passes no K-item as it stands.

**C4 (products of places) [hand].** For any finite set `S` of split places and any level `m`, `x ↦ (ι_v(x))_{v∈S} × (x mod 𝔓^m)` is an
injective graph homomorphism `Cay(R,U) → ×_{v∈S} HG(F_v) × P_m` (categorical product). So a four-colouring of that product **not** factoring
through `P_m` would pull back to a colouring of `Cay(R,U)`; if it separates `(0,…)` from `(ι(4),…)` it proves `F(R) = 0`. This is FS-64's
"several places at once" with split places in the role of the archimedean one. Proper colourings of `P₄` are isolated loops of the
exponential graph `K₄^{P₄}` (gap-freeness), so such a colouring must pass through improper maps `P₄ → 4`: `HG × P₄` would have to be a
Hedetniemi-type product (four-colourable while its factor `HG` perhaps is not; `[Tardif2023]` shows four is possible in general).

**Poros's card "does `H(ℚ)` already refuse four colours?" — answered from the record: open in print.** `[Madore2015]` ¶6.4 (read
first-hand, `madore.txt` l. 667–700): "The question of computing χ(ℝ², q_L), or even just deciding whether it is finite, seems an
interesting one (to which the present author does not know the answer)"; his Prop. 6.5 gives only odd cycles and no triangles over ℝ, so
`χ ≥ 3`. `[BardestaniMallahiKarai2017]` Rem. 1.3: plain χ of the real isotropic graphs possibly finite. Web search (two queries,
"Lorentzian/pseudo-Euclidean unit distance chromatic") found nothing further; "Minkowski plane" in that literature means normed planes.
`H(ℚ) ⊂ H(ℝ) = Γ(ℝ², q_L)`. **What C2′ adds:** in `H(E)` a finite subgraph forcing a nonzero pair at `k` colours proves `χ(H(E)) > k` (the
Lorentz boost `s_λ` is the spindle's rotation). So "does `H(ℚ)` refuse four colours" is itself a forced-pair question at four colours in a
triangle-free plane — S1's question transplanted to the rational Lorentz plane. **X (C2) stays undecided at every member; not claimed.**

## Second line: extensions (monotonicity) — the residue method is exhausted over ℚ(√59), by K

**C6 (monotone up a field extension) [hand, one line].** For real `F ⊆ F′`: `Cay(R_F, U_F)` is a subgraph of `Cay(R_{F′}, U_{F′})`, so
`F(R_F) ⊆ F(R_{F′})`. So **`F(R_{F′}) = 0` for one real finite extension `F′` ⟹ `F(R_F) = 0`** (when `χ(F′²) = 4`).
The natural "no" through this: `F′` with a stable place whose (four-colourable) target has a **gapped** colouring ⟹ every pair of `F′²` free
(row 66's transport, re-derived: move the pair's first point into the gap fibre by a translation, recolour that one vertex; the fibre is
independent because unit vectors are nonzero mod the prime) ⟹ `F(R_F) = 0`.

**C7 (that route is closed for ℚ(√59), by VK) [hand; uses VK + Krasner + weak approximation].**
- *Stable places only climb over stable places:* `c𝔓′ = 𝔓′ ⟹ c(𝔓′ ∩ L) = 𝔓′ ∩ L`. So every stable place of `F′ ⊇ ℚ(√59)` lies over 2, 59
  or a split `p ≡ 3 (4)` (11, 23, 31, 43, 47, 67, …). In particular **Γ₇ is never reachable** (7 inert in ℚ(√59): residue degree even in every
  `F′`, `q ≡ 1 (4)`), unlike ℚ(√11).
- *Odd stable places:* level one is `Γ_{p^f}`, `f` odd, `p ≥ 11`: not four-colourable (11: `χ = 5`; 23, 31, 43, 47: Hoffman; `p^f ≥ 37`:
  Weil), and at every level (FS-66's certificate at 11, Lemma P elsewhere, ramified bases included).
- *Dyadic stable places:* every completion `E = F′_{v′}` contains `ℚ₂(√59) = ℚ₂(√3) ⊇ K` (both `√3` and `√11` lie in `ℚ₂(√3)`: `11·3 ≡ 1 (8)`),
  and `i ∉ E`. Put `F″ = F′K` (real). Each dyadic place of `F′` splits completely in `F″` with the **same** completion `E`, so a gapped
  four-colouring of any level of `E`'s tower (or of a product of dyadic towers of `F′`, via one coordinate) is a gapped target of `F″`, giving
  `F(R_{F″}) = 0` — but `F(R_{F″}) ⊇ F(R_K) = 4R_K ≠ 0` (VK, C6). **So no dyadic tower of any real extension of ℚ(√59) has a gapped
  four-colouring at any level.** (Equivalently, a *local* theorem proved globally: for every finite `E ⊇ ℚ₂(√3)` with `i ∉ E` — each is a
  completion of some real `F′ ⊇ K`, by Krasner and weak approximation on a defining polynomial with a real root — the four-colourings of every
  level of the norm-one plane of `E(i)/E`, if any, are gap-free.)
- *Re-check (round 2, self):* the transfer needs **no surjectivity** of `R″ → O_w/𝔓_w^m` (so no Lemma R for the possibly non-Galois `F″`):
  row 66's recolouring only needs a graph homomorphism into the full level-`m` plane `P′_m` of `E(i)/E` and a gapped colouring `γ` of it,
  translated so the gap vertex `r` is the image of the pair's first point. Separation: if `γ(φ(0)+r) = γ(φ(4)+r)` (= `γ(r)`), recolour `0` to
  the gap colour `c ≠ γ(r)`; its neighbours map into `N(r)`, which misses `c`. And `K ⊂ F′_{v′}` because `√3, √11 ∈ ℚ₂(√3)` (`11·3 ≡ 1 (8)`),
  so `F″ = F′(√3, √11)` splits every dyadic `v′` completely with completion `F′_{v′}`.
- *Not covered:* composite targets mixing a dyadic factor whose independence ratio exceeds `1/4` with odd factors (Zhang's MIS-normality
  needs the classes to be maximum). Named, not closed.
**Poros's adjudication (via the owner, 2026-09-25): C7 is implied by T(2), not a K1.** The reduction: a gapped colouring `γ` of a stable
target of `F′` with gap vertex `x`; pick `w ∈ R_{F′}` over `x`; then `z ↦ γ(π′(w + z))` properly colours `Cay(R_F, U_F)` (a sub-Cayley graph) with
a gap at 0. **My own consequence of it:** that colouring is *periodic* on `R_F` (it factors through the finite `π′(R_F)`), so C7 already follows
from **V3** (every periodic colouring of ℚ(√59)'s plane is a `P₄` pull-back, hence gap-free, `P₄` being tight). **VK is not needed**, and neither
is the Krasner step: the local corollary (towers over `E ⊇ ℚ₂(√3)`, `i ∉ E`, are gap-free at every level) follows the same way from V3 for
ℚ(√59), realising `E` over ℚ(√59) instead of K. My VK route is valid but roundabout; **superseded, not retracted** (the statements stand).
Poros records C7's content as real (it closes the gap route through every extension); it is to be filed as a result.

**Reading.** Every residue target any real extension of ℚ(√59) can reach is either reachable from K (dyadic) or not four-colourable (odd), so
**the gap-transport "no" can never decide ℚ(√59), even through extensions** — the obstruction is exactly VK. The difference between K and
ℚ(√59) is invisible to every stable place of every extension; it lives in the triangles, the split places (C2) and non-periodic colourings.

## Round 2, step 1: HD1 — what is proved, and a positive control for the fallback

**C8 (the "stable-torsion + archimedean" form is dyadic torsion over ℚ(√59)) [hand].** Let `θ = τ + ℓ` with `τ` a character factoring
through a finite product of stable local planes and `ℓ(x) = λ(σ(x))` a real-linear functional of the archimedean embedding. If
`θ(U) ⊆ [1/4, 3/4]` then `ℓ = 0` on `U` and `τ` is dyadic. *Proof.* Weak approximation makes the stable residue of `u` and its archimedean
position independent, so `θ(U) ⊇ τ(S) + [−r, r]` with `r = max ℓ` on the torus `S¹ × S¹`. If `r > 0`, then `τ(S) ⊆ [1/4 + r, 3/4 − r]` gives a
circular colouring of the finite target with `χ_c ≤ 1/(1/4 + r) < 4`. But the target is `P_m × H`, whose `χ_f ≥ 4` (dyadic factor
vertex-transitive and tight; `χ_f(P_m × H) = min` over factors, `[Zhu2011]`), and `χ_c ≥ χ_f`. So `r = 0`. *The odd component, written out:* with `D = τ₂(S_dyadic)` and `E = τ_odd(S_odd)`, independence gives
`D + E ⊆ J`. So `E` lies in an arc of length 1/2 and is symmetric (`E = −E`). Such an arc is centred at `1/2` or at `0`.
- Centred at `1/2`: `E ⊆ J`, a circular four-colouring of the odd factor, against `χ_f > 4` there.
- Centred at `0`, with `E ≠ {0}`: `D ⊆ [1/4 + max|E|, 3/4 − max|E|]`, giving `χ_c(P_m) < 4`, against `χ_f(P_m) = 4`.
- `E = {0}` makes `τ_odd` trivial, because the circle spans. ∎ This proves HD1(b)–(c) for characters of
this form. **Not proved:** that every `θ ∈ Θ₄` has this form. Components at split places are defined only modulo the global dual lattice
(Poros's caution). A norm-one `S`-unit argument (units `w/w̄` with poles only in `S`) looks like the route; its density is unpriced.

**C9 (positive control for FS-83 at `k = 4`: ℚ(√11)) [hand; arithmetic checked mod 7].** On `Γ₇`, `f(x, y) = 2x + 3y` takes the values
`{2, 3, 4, 5}` on the eight circle points `(±1,0), (0,±1), (±2,±2)`. So `τ = f/7` puts the circle in `[2/7, 5/7]` (`χ_c(Γ₇) = 7/2 = χ_f`,
`α(Γ₇) = 14`), which leaves room `r = 1/28`. Over ℚ(√11), where 7 is stable with residue `𝔽₇`, `θ = τ∘(mod 7) + ℓ` with `0 < max ℓ ≤ 1/28` is a
**non-torsion point of Θ₄(ℚ(√11))**: an explicit, non-periodic four-colouring of ℚ(√11)², by formula. This agrees with `F = 0` there
(row 66). **Over ℚ(√59), 7 is not stable (`1/7 ∈ R`)**, and every stable target has `χ_c ≥ 4` (C8). So within C8's form the fallback
fires at ℚ(√11) and is silent at ℚ(√59); whether a general `θ` escapes C8's form is the whole of HD1's open part.

## Round 2, step 2 (Coxeter-2): HD1 for every character of finite type, class-wide; the infinite-type gap named

**Definition (finite type).** A character `θ` of `R = ℤ[U_F]` is **of finite type** if
`θ(x) = τ(x) + ψ_∞(a_∞x) + Σ_{v∈V} ψ_v(a_v x)` for some torsion `τ` (factoring through finitely many stable planes), `a_∞ ∈ L_∞`,
a finite set `V` of non-stable places of `L = F(i)` and `a_v ∈ L_v`. Each summand is a character of `R`. (FS-64's adelic window
colourings with one character and a finite set of places are exactly these.)

**Lemma C10.0 (components are well-defined for finite type) [hand].** If such a `θ` is torsion then `a_∞ = 0` and every `a_v = 0`.
So a finite-type character has unique components `(a_∞, (a_v)_V)`, and Poros's caution (components defined only modulo the global
dual lattice) does not arise in this class. *Proof.* `η := θ − τ` is torsion, say `mη = 0` on `R`. Now `mη` is the restriction to `R`
of the continuous character `y ↦ ψ_∞(ma_∞y_∞) + Σ_V ψ_v(ma_v y_v)` of `G = L_∞ × ∏_V L_v`, and `R` is dense in `G`: pick a non-stable
place `q` not above any prime below `V`; `O_{L,S}` with `S` = the places above those primes and above `q` lies in `R` and, by strong
approximation (drop the `q`-places, a nonempty set), is dense in `L_∞ × ∏_{S∖(q)} L_v`, which projects onto `G`. So the continuous
character vanishes on `G`: `ma_∞ = 0`, `ma_v = 0`. ∎ *(Replaces a first draft of this proof, written minutes earlier, that argued with a
finite-index subgroup and was muddled; not a retraction of any claim.)*

**Theorem C10 (HD1 for finite type, class S2) [hand].** Let `F` be real, with exactly one stable place whose local planes are
Hoffman-tight at four colours at every level (so `χ_f = χ_c = 4` there) and every other stable place with `χ_f > 4` at every level
(the class S2; ℚ(√59), ℚ(√83), ℚ(√131) by V3). Then every finite-type `θ ∈ Θ₄(F)` is a torsion character of the tight place's tower.
In particular every character colouring of finite type of `F²` is periodic, local at that place.

*Proof.* (1) *Continuity.* Let `W` be the places of `F` below `V`, `T_st` the stable places in `τ`'s support. For `u ∈ U`,
`θ(u) = f(u_∞, (u_w)_W, (u mod 𝔭^m)_{T_st})` with `f(t) = τ(t_st) + ψ_∞(a_∞t_∞) + Σ_{w∈W}[ψ_𝔮(a_𝔮t_w) + ψ_{c𝔮}(a_{c𝔮}t_w^{-1})]`,
continuous on `T(F_∞) × ∏_W T(F_w) × ∏_{T_st} S_v` (non-stable ⟺ split in `L/F`, so `T(F_w) ≅ F_w^×` via `t ↦ (t, t^{-1})`). No
term is contributed by poles of `u` outside `V`: `θ` has no component there.
(2) *Density.* `T = R¹_{L/F}𝔾_m` is `F`-rational (Hilbert 90: `t = z/z̄`), so weak approximation holds: `U = T(F)` is dense in that
finite product. Hence `θ(U) ⊆ J = [1/4, 3/4]` iff `f` maps the whole product into `J`.
(3) *Split components vanish.* Suppose `a_𝔮 ≠ 0` for some `w`. Fix every other coordinate; `f = C + ψ_𝔮(a_𝔮t) + ψ_{c𝔮}(a_{c𝔮}/t)`.
Take `t = π^{−N}ε`, `ε ∈ O_w^×`, `N` large: the last term is `0`, and `ψ_𝔮(a_𝔮π^{−N}O_w^×)` is a union of cosets of the subgroup
`ψ_𝔮(a_𝔮π^{−N+1}O_w)` of `ℚ_p/ℤ_p`, whose order `→ ∞` with `N`. So `f` takes values within `p^{−k}` of every point of `C + ℝ/ℤ`, for every
`k`; `ℝ/ℤ ∖ J` has interior, contradiction. Same for `a_{c𝔮}` (`N → −∞`). So `θ = τ + ℓ`, `ℓ = ψ_∞(a_∞·)`.
(4) *C8* (this file, round-2 step 1; its odd-component case analysis re-checked here, including the case `E ⊆ {0, 1/2}`, which forces
`τ₂(S) ⊆ {1/4, 3/4}` and so a bipartition of `P_m`, false): `ℓ = 0` on `U`, hence on `R`, and `τ` lives on the tight place alone. ∎

*Control (the hypothesis is needed).* C9: over ℚ(√11) the stable 7 has `χ_f(Γ₇) = 7/2 < 4`, and `τ₇ + ℓ` is a non-torsion point of
`Θ₄(ℚ(√11))` of finite type (`V = ∅`). *Nonemptiness (the conclusion is not vacuous).* Over ℚ(√59) the dyadic completion with its
conjugation is `ℚ₂(ζ₁₂)/ℚ₂(√3)`, the same as at each dyadic place of K, and Fischer's ℤ/4 colouring of K factors through `O/𝔓³` there
(addendum 2, item 4). So its local functional composed with `R → O/𝔓³` is a point of `Θ₄(ℚ(√59))`: an additive four-colouring of
ℚ(√59)², local at 2 at level 3. [derived from the addendum's statement; not re-checked on unit vectors here]

**The infinite-type gap, named precisely.** A general `θ ∈ R̂` has non-stable components at infinitely many places (dual of
`R ≅ O_L[1/p : p non-stable]` is the solenoid `(L_∞ × ∏_{non-st} 𝔡_v^{-1}O_v)/𝔡^{-1}`). Step (1) fails: `θ(u)` picks up a term at every
pole of `u`, and weak approximation controls a unit vector only at finitely many places, never its other poles (`T(F)` is discrete in
`T(𝔸_F)`). What survives is a cancellation identity: for `u ∈ U`, `y ∈ T(O_V)` with `y ≡ 1` to high order at the poles of `u`,
`θ(uy) − θ(u) = θ_V(u(y−1))` is of finite type; but the admissible `y` depend on `u`, and the depth needed to steer a digit grows with
the congruence level: every attempt I made to close it loops. **Sanity check any closing argument must pass:** the torsion Fischer
character, written in normalized form, has non-zero components at every non-stable place, so an argument that kills "a non-zero
component at one place" kills Fischer's colouring too (my first attempt did exactly this; not recorded as a claim).

**A partial infinite-type result (sketch, not claimed).** If `θ = τ + η` with `|η| < ε` on `U` for small `ε`, then `η` is real-valued
on short relations; if the relation module of `U` is generated by relations of bounded coefficient sum, `η` lifts to a `ℚ`-linear, hence
archimedean, functional, and C8 finishes. Unproved: the generation lemma.

**Shared prior art (the owner, 2026-09-25): Kari–Szabados, Herva–Kari** (annihilating polynomials force periodic decompositions of
finite-alphabet configurations on `ℤ^d`). *Bearing, one remark (C11), as corrected (see Retractions):* on `Cay(R, U_F)`, write `I` for the ideal of finitely supported `f` with
`f * g = 0` for every tetrahedral four-colouring `g`. **(a)** `F(R) ∋ δ ≠ 0` ⟹ `δ₀ − δ_δ ∈ I` (the owner checked this). **(b)** `F(R) ≠ 0`
⟺ the zero set `Z(I) ⊆ R̂` is a finite set of torsion characters. ⟹: every `g` then lies in the span of the 45 minimising characters of
`P₄` (D2-A (ii)), and `δ₀ − δ_δ`, `δ ∈ R ∩ 𝔓⁴`, cut `Z(I)` down to characters of `O/𝔓⁴`. ⟸: a bounded `g` with `f * g = 0` has spectrum
in `Z(f̂)`, and a finite set of frequencies is a set of spectral synthesis, so every `g` is a finite sum of torsion characters, hence
periodic. **Not claimed:** that `I ≠ 0` alone implies `F(R) ≠ 0`. A universal annihilator whose zero set is infinite (a hypersurface
in the solenoid) is compatible with non-periodic colourings, as the Kari–Szabados decompositions into sums of one-direction-periodic
configurations suggest on `ℤ²`. So G75's format "a local linear identity that pins the spectrum" is, un-narrowed, the question itself;
only a narrowed format can carry a K3 no-go. Not pursued further this round.

## Round 2, step 3 (Coxeter-2): Poros's card C-S2 answered — S2 has a member with triangles

**The card's question:** is `ℚ(√2,√3)`'s dyadic tower (`ℚ₂(ζ₂₄)/ℚ₂(√2,√3)`, `e = 4`, `f = 1` below, unramified quadratic above)
four-tight at every level, making `ℚ(√2,√3)` a member of S2 with triangles?

**C12.1 (every unramified quadratic dyadic tower stabilises; the general induction) [hand].** Let `E/ℚ₂` be finite with residue
field `𝔽₂`, `K = E(ζ₃)` (unramified quadratic, residue `𝔽₄`, conjugation = the nontrivial automorphism), `O = O_K`, `𝔓 = π_E O`,
`S_m` = norm-one units mod `𝔓^m`, `P_m = Cay(O/𝔓^m, S_m)`. Then:
- (i) `|S_m| = 3·2^{m−1}`; the kernel of `S_m → S_{m−1}` is `{1, 1 + π_E^{m−1}}` (`N(1 + π^{m−1}a) ≡ 1 + π^{m−1}Tr(a)`, and
  `Tr_{𝔽₄/𝔽₂}(a) = 0` iff `a ∈ 𝔽₂`), so a character pulled back from level `m−1` has eigenvalue `2λ′`.
- (ii) FS38-L2 holds verbatim (its proof is basis-free): a primitive `χ` has `λ_χ = 2Σ{χ(s₀) : s̄ ≡ a₀ (mod 𝔓)}`, `|λ_χ| ≤ 2^{m−1}`,
  equality only if `χ` is trivial on `a₀M_m`, `M_m = span{t − 1 : t ∈ S_m, t ≡ 1 (mod 𝔓)}`.
- (iii) `M := ℤ₂-span{t − 1 : t ∈ T, t ≡ 1 (mod 𝔓)}` contains `𝔓^c` for some finite `c`: `M` is a module over the `ℤ₂`-algebra
  generated by `T¹`, which has full rank (`t ↦ t + t̄` has open image in `E`, and `T¹ ⊄ E`), so `M ⊗ ℚ₂ = K`.
- (iv) Hence, with `c` as in (iii): if `P_c` is four-tight, every `P_m` (`m ≥ c`) is four-tight, its minimisers are the pullbacks of
  `P_c`'s, and `H_min(P_m) = H_min(P_c)` pulled back (FS38-D2-B's induction, which needs no FS38-L1: pullbacks give `2λ′ ≥ −|S_m|/3`,
  primitives give `|λ| < |S_m|/3` once `M_m ⊇ 𝔓^{m−1}/𝔓^m`, i.e. `m − 1 ≥ c`). **So a tower of this shape is tight at every level iff it is
  tight at the finitely many levels `≤ c`.** Row 67's tower is the case `E = ℚ₂(√3)`, `c = 4`.

**C12 (the card: yes) [tools exact + hand].** For `E = ℚ₂(√2,√3)`, `K = ℚ₂(ζ₂₄)`:
- levels 1–8 are four-tight, **exactly**: every eigenvalue `≥ −|S_m|/3`, equality decided in `ℚ(ζ_{2^K})`'s power basis, other gaps
  `≥ 4`; the minimiser counts are `3, 9, 21, 45, 45, 45, 45, 45`, the same as row 67's tower (reproduced on the same code as the
  control: 45 at level 4, as FS38-D2-B records);
- `𝔓⁴ ⊆ M` (the `ℤ₂`-span of 40 sampled `N(u)(u/ū − 1)`, `u ≡ 1 (mod 𝔓)`, odd norm, already contains `𝔓⁴`; a sample span is a lower
  bound, which is the direction needed; the same code gives row 67's elementary divisors `1, 2, 4, 4` exactly as FS38-L3 has them);
- the 45 level-4 minimisers have trivial common kernel (as in row 67).

So by C12.1(iv) **every level is four-tight, and every four-colouring of `P_m`, `m ≥ 5`, is a pullback from `P₄`**. Tools:
`cs2/tower.py`, `cs2/exact.py`, `cs2/mexp.py`, `cs2/hmin.py` (this directory; exact integer arithmetic in `ℤ[ζ_n]`; each run < 30 s).

**Consequence: `ℚ(√2,√3)` is in S2, and it has triangles.** Its odd stable places are the `p ≡ 23 (mod 24)` with residue `𝔽_p`
(Poros's card, one mind; re-derived here: `(2/p) = (3/p) = 1` and `p ≡ 3 (mod 4)`). All have `χ_f > 4` at every level: 23 by the exact
Hoffman margin `+0.039` (FS81-T25) with the constant ratio up an inert odd tower (G54's odd-`Q` fact, `[MMST1998]`); `p ≥ 47` by Weil
(`α/n ≤ 2√p/(p+1+2√p) < 1/4` for `p ≥ 34`); 3 is not stable (`𝔽₉ ∋ i`). With V2 and §0.3 (iii)'s frame (Lemma R and Zhang's
MIS-normality, both argued as for ℚ(√59) and assumed to transfer), `P(R) = R ∩ 𝔓⁴` and `F(R) ∈ {0, R ∩ 𝔓⁴}` there too, and C10 applies.
**What this buys S2:** "is the answer decided by triangles?" can now be asked inside the class. `ℚ(√2,√3)(i) = ℚ(ζ₂₄)`, so `U ⊇ μ₂₄`:
unit triangles, hexagons and dodecagons, and `Cay(ℤ[ζ₂₄], μ₂₄)` (rank 8) sits inside the plane. It has no √11, so no Moser spindle
and not de Grey's lattice: G75's hexagon mechanism must be re-derived there, not transferred. **`F(R)` for `ℚ(√2,√3)` is open**; it is
the triangle-bearing control for ℚ(√59).

## Round 2, step 4 (Coxeter-2): the bounded hexagon probe at ℚ(√2,√3) — √3 is a unit vector mod 𝔓⁴ there

**C13.0 (local) [tools exact + hand].** In `ℚ₂(ζ₂₄)` (`e(E/ℚ₂) = 4`), `√−3 = 1 + 2ω` is congruent to a norm-one unit mod `𝔓^m` exactly for
`m ≤ 4`; in row 67's `ℚ₂(ζ₁₂)` (`e = 2`) exactly for `m ≤ 2` (`cs2/sqrt3.py`, levels 1–6 both). *Why:* `N(1 + 2ω) = 3`, and for an
unramified `K/E`, `N(1 + 𝔓^m) = 1 + 𝔭_E^m`, so `√−3` is a unit vector mod `𝔓^m` iff `3 ∈ 1 + 𝔭_E^m` iff `m ≤ v_E(2) = e`. Also
`2 ∈ 𝔓⁴` when `e = 4`. Since `√3·i` differs from `√−3` by a unit vector's factor, **every `√3·u` (`u ∈ U`) is ≡ a unit vector mod 𝔓⁴,
and every `2u ∈ 𝔓⁴`**, in ℚ(√2,√3)'s tower.

**C13 (consequences at ℚ(√2,√3)) [hand, given the §0.3 frame's transfer to this field, argued in C12].**
- (i) Every periodic four-colouring of ℚ(√2,√3)² (each one a pullback from `P₄`) gives **every pair at distance √3 different colours**
  (the two points are adjacent in `P₄`) and **every pair at distance 2 the same colour**.
- (ii) **`F(R) ≠ 0` iff the pair `(0, 2)` is four-colour forced** (`2 ∈ R ∩ 𝔓⁴ = P(R)` and `F ∈ {0, P}`). Under a yes, every √3-pair is a
  four-colour virtual edge. **So one four-colouring of ℚ(√2,√3)² with a monochromatic √3-pair proves `F(R) = 0` there**; equivalently,
  by compactness, a "no" follows if no finite graph over the field separates a √3-pair at four colours.
- (iii) *The hexagon identities hold on every periodic colouring.* An alternate triple of a unit hexagon is a √3-triangle, rainbow by (i),
  so each hexagon about `x` uses each of the other three colours exactly twice: `A_b g = −2g` for every family `b` (G75's input, which on
  de Grey's lattice needed Parts's trees, holds here on the periodic colourings for free).
- (iv) *If* the identities held on every four-colouring (a Parts-type lemma over ℚ(√2,√3): no monochromatic √3-triangle), every
  colouring's spectrum would lie in `Z = ⋂_{b∈U} ⋃_{k=0,1,2} {θ : θ(bζ₆^k) = 1/2}`. **C10's sweep shows `Z`'s finite-type points are
  torsion** (at a split place the three values `θ(bζ₆^k)` sweep densely as `b`'s component grows, so none stays at 1/2). So the pinning
  question at ℚ(√2,√3) reduces to **the same infinite-type gap as HD1**: both ask whether a set of characters cut out by pointwise
  conditions on `U` can contain a character with infinitely many non-stable components.

**Reading (not claimed):** the triangle-bearing member of S2 turns the "no" side into a one-pair question, a monochromatic √3-pair,
the distance at which the real plane's hexShell lemma (G26, row 43) already forces a monochromatic pair unless a 2-pair is monochromatic.
At ℚ(√59) there is no √3 and no such handle. So the S2 question "do triangles decide?" now has a sharp form at ℚ(√2,√3):
**is √3 a four-colour virtual edge in ℚ(√2,√3)'s plane?**

## Round 2, step 5 (Coxeter-3): the window no-go — FS-64's format cannot carry a non-periodic four-colouring in S2

**Why this move.** HD1's infinite-type gap (item 1) is about one-character colourings; item 3 (multi-character windows) waited on
`m₁(ℝ²) < 1/4`, which is **proved**: `[AmbrusEtAl2023]` Thm 1, `m₁(ℝ²) ≤ 0.2470` for the upper density of every measurable 1-avoiding
set (Erdős's conjecture; read first-hand, p. 1–2). So the natural next object is the whole cut-and-project format at once: colourings
that read finitely many local coordinates through a measurable window. A local version of Zhang's MIS-normality, made measurable, plus
the gap-freeness of the tight dyadic plane, decides it.

**Setting.** `F` real, `L = F(i)`, `R = ℤ[U_F]`. For a place `v` of `F` put `T_v` = the norm-one elements of `L_v = L ⊗ F_v` and
- archimedean `v`: `G_v = ℂ`, `T_v = S¹` (so `Γ_v = UD(ℝ²)`);
- odd stable `v`: `G_v = O_v` (the ring of `L_v`; `R ⊂ O_v` by Lemma R), `T_v ⊂ O_v^×` compact;
- split `v`: `G_v = L_v ≅ F_v × F_v`, `T_v = {(t, 1/t)}` (C1's hyperbola graph `H(F_v)`);
- the tight place `𝔓`, at a finite level `m`: `G_𝔓 = O/𝔓^m`, `T_𝔓 = S_m`, `Γ_𝔓 = P_m`.
For a finite set `S` of places containing `𝔓`, `G_S = ∏_{v∈S} G_v`, `T_S = ∏ T_v`, **`Γ_S = Cay(G_S, T_S)`** (a categorical product of the
local graphs), and `ι_S : R → G_S` the diagonal map (archimedean coordinates `σ_v`, residues, split coordinates). `ι_S(U) ⊆ T_S`.

**Definition (measurable window colouring).** A map `W : G_S → {1,2,3,4}` with Haar-measurable colour classes that is a **proper colouring
of `Γ_S`** (every pair `z, z + τ`, `τ ∈ T_S`, gets different colours). Its colourings of the plane are `c_{W,t}(r) = W(ι_S(r) + t)`, `t ∈ G_S`
(on each `R`-coset of `F²` a separate `t`); each is proper on `Cay(R, U_F)`. This contains FS-64's adelic window colourings (windows at
finitely many places, compact-open at the non-archimedean ones), every finite-type character colouring `⌊4θ⌋` (C10's class; its classes
are preimages of half-open arcs under a continuous character, hence Borel), and every multi-character window.

**Theorem C14 (window no-go) [hand; inputs `[AmbrusEtAl2023]` Thm 1, V3's all-levels bounds, `[Zhang2012]` Prop. 1.7 and Thm 1.8,
row 67].** Let `F` be real, with one stable place `𝔓` whose planes `P_m` are Hoffman-tight at four colours at every level, and every
other stable place `v` with `r_v := sup_k α(Γ_{v,k})/|Γ_{v,k}| < 1/4` (the class S2; ℚ(√59), ℚ(√83), ℚ(√131) by V3). Then for every finite
`S ∋ 𝔓` and every measurable window colouring `W` of `Γ_S`, there are finitely many cosets `K` of the subgroup `⟨T_X⟩` of
`G_X = ∏_{v∈S∖𝔓} G_v` and proper four-colourings `γ_K` of `P_m` with **`W(x, a) = γ_K(a)` for every `x ∈ K` and every `a`** — pointwise,
not almost everywhere. Hence **every** `c_{W,t}` is periodic: on each `R`-coset it equals `r ↦ γ_K(r mod 𝔓^m + t_𝔓)`, a translate of a
pull-back from `P_m` (from `P₄` over ℚ(√59), ℚ(√83), ℚ(√131), by row 67).

### Proof of C14

**Window densities.** For `X = Cay(G_X, T_X)` a product of the non-tight local graphs above, take Følner windows
`Φ_n = Q_n^s × ∏_{odd st} O_v × ∏_{split} π_v^{−n}O_v²` (`Q_n = [0, n)² ⊂ ℂ`, `s` archimedean factors), `λ` = Lebesgue × Haar (Haar
normalised to `1` on `O_v` and on `O_v²`), and `d_n(Y) = λ(Y ∩ Φ_n)/λ(Φ_n)`. Put `ρ_n(X) = sup d_n(Y)` over measurable `X`-independent `Y`.
**`X` has ratio `r` with error `η`** if (R1) `ρ_n(X) ≤ r + η(n)` with `η(n) → 0`, and (R2) for each `ε > 0` there are an independent `I` and a
probability space `(D, dt)` of translations with `∫_D 1_I(x + t) dt ≥ r − ε` for **every** `x` ("averageable near-optimal sets").
*Measurability.* By inner regularity every measurable independent set contains a σ-compact one of the same measure, so the sup in `ρ_n`
may be taken over σ-compact sets; then every set the proofs build (sections, `Y + T`, differences) is Borel or analytic, hence universally
measurable, and Fubini holds for the completed product measures.

**Lemma C14.1 (window No-Homomorphism; `[Zhang2012]` Prop. 1.7 transplanted) [hand].** If `X` has ratio `r` with error `η`, then for every
independent `Y` with `N[Y] := Y ∪ (Y + T_X)` measurable, `d_n(Y) ≤ r·d_n(N[Y]) + η(n)` for every `n`.
*Proof.* Take `(I, D)` from (R2). For `t ∈ D`, `J_t = ((I − t) ∖ N[Y]) ∪ Y` is independent: `Y` and `I − t` are, and an edge from `y ∈ Y` to
`q ∈ (I − t)` puts `q ∈ N[Y]`. The union is disjoint (`Y ⊆ N[Y]`), so `d_n(I − t) − d_n((I − t) ∩ N[Y]) + d_n(Y) ≤ ρ_n(X)`. Average over
`t ∈ D` (Fubini on `Φ_n × D`), with `g(x) = ∫_D 1_I(x + t) dt ≥ r − ε`:
`d_n(Y) ≤ ρ_n − ∫_D d_n((I − t) ∖ N[Y]) dt = ρ_n − λ(Φ_n)^{−1}∫_{Φ_n ∖ N[Y]} g ≤ ρ_n − (r − ε)(1 − d_n(N[Y])) ≤ r·d_n(N[Y]) + η(n) + ε`;
let `ε → 0`. ∎
*(Check of the one step that differs from the finite lemma: `g` need not be constant; only `g ≥ r − ε` is used, on `Φ_n ∖ N[Y]`.)*

**Lemma C14.2 (the local factors) [hand].**
- **(a) Archimedean: `UD(ℝ²)` has ratio `m₁ := m₁(ℝ²) ≤ 0.2470` with error `η(n) = ((1 + 1/n)² − 1)m₁`.** (R1): if `A` is 1-avoiding, tile
  `A ∩ Q_n` with period lattice `(n + 1)ℤ²`; copies are more than distance 1 apart, so the tiling is a measurable 1-avoiding set of
  density `d_n(A)·n²/(n + 1)² ≤ m₁` (`[AmbrusEtAl2023]` Thm 1 bounds the upper density of every measurable 1-avoiding set). (R2): the same
  tiling of a set `A` with `d_n(A) ≥ m₁ − ε/2`, `n` large, is periodic; average over a fundamental domain `D`: `∫_D 1_I(x + t)dt = dens(I)`.
- **(b) Odd stable `v`: `Cay(O_v, T_v)` has ratio `r_v` with error `0`.** (R2): the pull-back `I` of a maximum independent set of `Γ_{v,k}`
  with `k` near the sup, `D = O_v` with Haar. (R1) for a measurable independent `A ⊆ O_v`: call a coset `x + 𝔭^k` *full* if
  `μ(A ∩ (x + 𝔭^k)) ≥ (1 − ε)μ(𝔭^k)`, `ε < 1/3`. The full cosets are independent in `Γ_{v,k}`: if `x + 𝔭^k` and `y + 𝔭^k` are full with
  `y − x ≡ s ∈ S_k`, let `T_s = T_v ∩ (s + 𝔭^k)` (nonempty, `S_k` being the image of `T_v`, and of positive measure for the Haar measure
  `σ` of `T_v`). For each `τ ∈ T_s`, `a ↦ a + τ` maps `x + 𝔭^k` onto `y + 𝔭^k` preserving measure, so
  `avg_{a ∈ x+𝔭^k} σ(τ ∈ T_s : a + τ ∉ A)/σ(T_s) ≤ ε`; hence some `a ∈ A ∩ (x + 𝔭^k)` has `a + τ ∈ A` for some `τ ∈ T_s ⊆ T_v`: an edge in
  `A`. So `#full ≤ α(Γ_{v,k})`, and by the martingale (Lebesgue differentiation) theorem the non-full cosets carry `o(1)` of `A` as `k → ∞`:
  `μ(A) ≤ r_v + o(1)`. So `μ(A) ≤ r_v`.
- **(c) Split `v`: `H(F_v)` has ratio `0` with error `η(n) ≤ 3/(2n + 4)`.** (R2) with `I = ∅`. (R1): `Y ∩ Φ_n` is independent in the compact
  Cayley graph on `Φ_n = π^{−n}O²` whose connection measure `ν_n` is the average over `k ∈ [−n, n]` of the Haar measures on
  `{(π^kε, π^{−k}ε^{−1}) : ε ∈ O^×}` (all inside `Φ_n`). Hoffman's bound for measurable independent sets of a compact Cayley graph (`⟨1_A, ν_n * 1_A⟩
  = 0`) gives `μ(A)/μ(Φ_n) ≤ −λ/(1 − λ)`, `λ = min_{ξ ≠ 0} ν̂_n(ξ)`. For a character `ξ = (ξ₁, ξ₂)` put `E_k = ∫_{O^×} ψ(ξ₁π^kε + ξ₂π^{−k}ε^{−1}) dε`,
  `a_k = v(ξ₁π^k)`, `b_k = v(ξ₂π^{−k})`. Then `E_k = 1` if `a_k, b_k ≥ 0`; `E_k ∈ {−1/(q − 1), 0}` if exactly one is negative (value `−1/(q−1)`
  only when that one is `−1`: at most two `k`); `E_k = 0` if both are negative and unequal (non-stationary: with `a < b < 0`, substitute
  `ε ↦ ε(1 + π^{−b}x)`; the `ξ₂`-term moves by an element of `O`, the `ξ₁`-term by `ξ₁π^kε π^{−b}x` of valuation `a − b < 0`, and the `x`-integral
  vanishes); `|E_k| ≤ 1` if `a_k = b_k < 0` (at most one `k`, since `a_k − b_k` moves by 2 with `k`). So `(2n + 1)ν̂_n(ξ) ≥ −1 − 2/(q − 1) ≥ −3`,
  `λ ≥ −3/(2n + 1)`, and the ratio is `≤ 3/(2n + 4)`. (The same computation with `ξ₁ = 0` or `ξ₂ = 0` is the one-negative case.)

**Lemma C14.3 (products; `[Zhang2012]` Thm 1.8's counting, measurable) [hand].** If `X₁` has ratio `r₁` (error `η₁`) and `X₂` ratio
`r₂ ≤ r₁` (error `η₂`), then `X₁ × X₂` has ratio `r₁` with error `η₁ + η₂`.
*Proof.* (R2): `I₁ × G₂` is independent in the product, averaged over `D₁ × {0}`. (R1): let `S` be σ-compact independent in `X₁ × X₂`
(windows `Φ¹_n × Φ²_n`). For `a ∈ G₁` let `X_a = {x ∈ G₂ : (a, x) ∈ S}`, `X′_a = X_a ∩ (X_a + T₂)`, `X*_a = X_a ∖ X′_a` (independent in `X₂`).
For `x ∈ G₂` let `A_x = {a : x ∈ X′_a}` and `B(x) = {b : x ∈ N₂[X*_b]}`. Zhang's two observations, re-walked:
(i) `A_x` is independent in `X₁` (if `a, a′ ∈ A_x` are adjacent, pick `y ∈ X_a` adjacent to `x`; then `(a, y), (a′, x) ∈ S` are adjacent);
(ii) `B(x) ∩ N₁[A_x] = ∅` (if `x ∈ X*_b + T₂`, some `y ∈ X*_b` is adjacent to `x`, and `(b, y), (a, x) ∈ S` force `b ≁ a` for all `a ∈ A_x`,
while `b ∈ A_x` would put `y ∈ X′_b`; if `x ∈ X*_b`, each `a ∈ A_x` has `z ∈ X_a` adjacent to `x`, so `(a, z), (b, x) ∈ S` force `a ≁ b`, and
`b ∉ A_x` because `x ∉ X′_b`). Then, with Fubini on the windows,
`d_n(S) = avg_{x ∈ Φ²_n} d¹_n(A_x) + avg_{b ∈ Φ¹_n} d²_n(X*_b)`,
`d¹_n(A_x) ≤ r₁ d¹_n(N₁[A_x]) + η₁ ≤ r₁(1 − d¹_n(B(x))) + η₁` (C14.1, then (ii)),
`avg_x d¹_n(B(x)) = avg_b d²_n(N₂[X*_b])`, and `d²_n(X*_b) ≤ r₂ d²_n(N₂[X*_b]) + η₂ ≤ r₁ d²_n(N₂[X*_b]) + η₂` (C14.1 in `X₂`).
Adding: `d_n(S) ≤ r₁ + η₁ + η₂`. ∎

**Corollary C14.4.** `X = Cay(G_X, T_X)` for `S ∖ {𝔓}` (all factors of C14.2) has ratio `r_X = max(m₁, max_v r_v) < 1/4` with an error
`η_X(n) → 0` (induction on the number of factors, C14.3; the order of the factors is by ratio). Over ℚ(√59) the largest `r_v` is at 31,
`≈ 1/4 − 10⁻⁵` by Hoffman (addendum 1, item 1), so `r_X` may exceed `m₁`; only `r_X < 1/4` is used.

**The main count (the tight factor on Zhang's larger side) [hand].** Let `W` be a measurable window colouring, `P = P_m`, `|P| = n_P`,
`α(P) = n_P/4`. For each colour `j`, replace the class `S^j` by a σ-compact subset of full measure (inner regularity); call the null
remainder `N₀`. For `b ∈ P` and class `j`: `X^j_b`, `X^{j′}_b`, `X^{j*}_b` as above (now over the finite `P`), `A^j_x = {a : x ∈ X^{j′}_a}`,
`B^j(x) = {b : x ∈ N_X[X^{j*}_b]}`. Observations (i), (ii) hold verbatim, and in the finite vertex-transitive `P` Zhang's Prop. 1.7 gives
`|A^j_x| ≤ ¼|N_P[A^j_x]| ≤ ¼(n_P − |B^j(x)|)`. Since `#{a : (x, a) ∈ S^j} = |A^j_x| + #{b : x ∈ X^{j*}_b}`,
`d_n(S^j) ≤ n_P/4 + Σ_b [d_n(X^{j*}_b) − ¼ d_n(N_X[X^{j*}_b])] ≤ n_P/4 − κ Σ_b d_n(X^{j*}_b) + n_P η_X(n)/(4r_X)`,
with `κ = 1/(4r_X) − 1 > 0` (C14.1 in `X`: `d_n(N[Y]) ≥ (d_n(Y) − η_X)/r_X`; if `S` has only split places besides `𝔓`, `r_X = 0` and C14.1 gives `d_n(X^{j*}_b) ≤ η_X(n)` directly). Summing over the four classes, `Σ_j d_n(S^j) = n_P` exactly, so
**`Σ_{j,b} d_n(X^{j*}_b) ≤ n_P η_X(n)/(r_X κ) → 0`.** Let `E = ⋃_{j,b} X^{j*}_b ∪ π_X(N₀)` (`π_X(N₀)` is null, `P` being finite). Then
`d_n(E) → 0`, so every coset `K` of the finite-index subgroup `⟨T_X⟩` (next paragraph) contains a point `x_K ∉ E`. At `x_K` every
`(x_K, a)` lies in the σ-compact part of its class `j = W(x_K, a)` with `x_K ∉ X^{j*}_a`, so `a ∈ A^j_{x_K}`: the fibre colouring
`g_{x_K} = W(x_K, ·)` has independent classes `A^j_{x_K}` — **it is a proper four-colouring `γ_K` of `P`.**

**Propagation (pointwise; the tight place's gap-freeness) [hand].** `P_m` is Hoffman-tight at four colours, so each class of a proper
four-colouring is a maximum independent set in `P`'s least eigenspace, and every vertex outside a class has exactly `|S_m|/3 > 0`
neighbours in it: every proper four-colouring of `P` is gap-free (D2-A's statement; `[BBH]`). If `g_x = γ` is proper and `y − x ∈ T_X`,
then for every `b`: `W(y, b) ≠ W(x, b − s) = γ(b − s)` for all `s ∈ S_m`, and `{γ(b − s)} = 4 ∖ {γ(b)}`, so `W(y, b) = γ(b)`: `g_y = γ`.
Hence `g ≡ γ_K` on the whole `⟨T_X⟩`-coset `K`, at every point. *`⟨T_X⟩` has finite index:* it contains `∏_v ⟨T_v − T_v⟩` (vary one
coordinate, fix the rest), and `⟨S¹ − S¹⟩ = ℂ`; `⟨T_v − T_v⟩ = F_v²` at a split place (`(t, 1/t) − (t′, 1/t′)` with `t, t′` large gives `(x, small)`
for every `x`, plus an open subgroup); `T_v − T_v` has interior in `O_v` at a stable place (the difference map of the one-dimensional
torus is a submersion off the diagonal), so `⟨T_v − T_v⟩` is open, of finite index in the compact `O_v`.
**Restriction to the plane.** `Cay(R, U)` is connected (`R` is the additive span of `U`, `U` being multiplicatively closed), so
`ι_S(R) + t` lies in one coset `K` and `c_{W,t}(r) = γ_K(r mod 𝔓^m + t_𝔓)`. ∎

**Tools check of C14.2(c) [tools, float FFT, a sanity check of a derived bound, not a search].** `c14/hyperbola_hoffman.py` builds the
averaged hyperbola measure `ν_n` on `p^{−n}ℤ_p²/p^Mℤ_p²` (`F_v = ℚ_p`) and reads every eigenvalue by one 2-D FFT: `(2n + 1)λ_min` is
`−1.000` (p = 3), `−0.809` (5), `−0.449` (7), `−0.402` (13), independent of `n` and `M` in every case run, against the derived floor
`−1 − 2/(p − 1)`. So the ratio of `H(ℚ_p)` on windows falls like `1/n`, as C14.2(c) says; at `p = 3` the single stationary Kloosterman
level is essentially the whole negative mass (`−1` exactly).

**Corollary C14′ (regular windows: proper off a null set) [hand].** Cut-and-project colourings with polygonal windows are proper only
between interior points. So suppose only that `W(z) ≠ W(z + τ)` whenever `z` and `z + τ` both lie in a conull measurable `Ω ⊆ G_S`
(`τ ∈ T_S`). Then on each `⟨T_X⟩`-coset `K`, `W = γ_K ∘ π_𝔓` almost everywhere, and **`c_{W,t}` is periodic for almost every `t`**.
*Proof.* Run the main count with `S^j ∩ Ω` (independent, full measure). `Q = {x : {x} × P ⊆ Ω and g_x is a proper colouring of P}`
contains every `x ∉ E` whose fibre lies in `Ω`, so it has window density `→ 1`. Split `Q = ⊔_γ Q_γ` by the colouring. Propagation now works for steps that stay in
`Ω`: for a.e. `x`, `σ`-a.e. `y ∈ x + T_X` has `{y} × P ⊆ Ω` (Fubini), so each `Q_γ` is invariant, up to null sets, under the random
walk with step law `σ` (a probability of full support on `T_X`, e.g. weights `2^{−|k|}` on the levels at split places): if `x` has its fibre
in `Ω`, a neighbour `y` with fibre in `Ω` has `g_y = g_x` when either is proper (gap-freeness, both directions). Bounded harmonic functions of that walk are constant on `K`, the closed subgroup `supp σ` generates
(Choquet–Deny), so each `Q_γ ∩ K` is null or conull, and exactly one `γ_K` is
conull because `Q ∩ K` has positive measure. Then `W = γ_K ∘ π_𝔓` off a null set `N`, and `ι_S(R) + t` misses `N` for a.e. `t` (a
countable union of null translates). ∎ *The pointwise statement of C14 needs properness at every pair; C14′ is its almost-every form.*

**Corollary C14-K (several tight places: the window form of VK) [hand, sketch; rests on VK].** Let every stable place of `F` be either
*tight* (planes Hoffman-tight at four colours at every level) or of all-levels ratio `< 1/4`, as over K (two dyadic places; B1's VK
proof supplies the odd bounds). Then every measurable window colouring is, on each `⟨T_X⟩`-coset, a pull-back from **one** tight place.
*Proof.* Put all tight places, at finite levels, into the finite factor `P = ∏ P^{(i)}_m`: it is vertex-transitive with ratio exactly
`1/4` (Zhang, equal ratios), so the main count runs unchanged and gives a point whose fibre is a proper four-colouring of `P`. Every
proper four-colouring of `P` is a pull-back from one factor: pull it back along the surjection `R → P` (Lemma R) and apply VK (every
four-colouring of the plane is local at one tight place). Such a colouring is gap-free in `P` (the neighbourhood of `(a_i)` is
`∏ N(a_i)`, and the one factor sees all three other colours), so the propagation of C14 goes through verbatim. ∎
*So the K control of C14 is not an exception but the same theorem:* windows cannot mix places, and cannot leave the tight ones.

### Controls, scope, and what C14 does and does not decide

**Each hypothesis is needed (controls).**
- *The strict ratio at the other stable places.* Over ℚ(√11) the stable 7 has `α(Γ₇)/49 = 2/7 > 1/4`, and C9's `θ = (2x + 3y)/7 ∘ (mod 7) + ℓ`
  gives `W = ⌊4θ̃⌋` on `ℂ × 𝔽₇²`: a measurable window colouring whose plane colourings are **not** periodic. C14's `r_X < 1/4` fails there,
  exactly at the factor the control uses.
- *Strictness, not `≤`.* Over K the second dyadic place has ratio exactly `1/4`; VK's colourings local at that place are window colourings
  at `S = {𝔓₁, 𝔓₂}` that are not pull-backs from `𝔓₁`. So C14's "one tight place, every other `< 1/4`" is sharp at K.
- *The archimedean input is Erdős's conjecture, and nothing weaker works in this proof.* Hoffman gives only `0.287` for `UD(ℝ²)`
  (`−J₀min/(1 − J₀min)`); with that the count in the main step has the wrong sign. `m₁(ℝ²) < 1/4` (`[AmbrusEtAl2023]`, 2023) is exactly
  what lets the archimedean places carry no non-periodic four-colouring in this format.
- *Non-vacuous.* Pull-backs from `P₄` are measurable window colourings (constant in every non-dyadic coordinate), and over ℚ(√59) Fischer's
  functional at level 3 is one (C10's nonemptiness).

**Scope (plan §C's rule).** Field planes of every member of S2 (one stable place tight at four colours at every level, every other stable
place with all-levels ratio `< 1/4`). The format: colourings read from finitely many local coordinates (archimedean, odd stable at full
level, split at full level, the tight place at any finite level) through a measurable window that is proper on the whole local graph.
**Not covered:** (1) windows that read the tight place at infinite depth (`W` depending on all of `O_𝔓`: the count still gives
`d_n(E) → 0` with `E` now the set where the fibre colouring fails to be proper on a set of positive measure, but "positive" is no longer
"≥ 1", and the pointwise start is lost); *(Remark, sketch: depth is free when the count is exact. If every factor of `X` is compact — only stable places, or archimedean coordinates read periodically, `ℂ^s/Λ`, whose periodic 1-avoiding sets have density `≤ m₁` exactly — the windows are the whole group, `η = 0`, and the count gives `μ{b : x ∈ X^{j*}_b} = 0` for a.e. `x`; each fibre class is then an independent set of measure `1/4` in the tight `Cay(O_𝔓, T_𝔓)`, so a.e. a `P₄` pull-back (Hoffman equality), and the a.e. propagation of C14′ finishes. What blocks the general case is only the Følner boundary error: the count then bounds the defect by `O(1/n)` per window, which a set of large-scale codimension one can meet.)* (2) colourings reading infinitely many places (HD1's infinite-type characters are among them);
(3) non-measurable colourings, and colourings of `R` that come from no colouring of a local graph at all.

**What it decides.** **FS-64's adelic window colouring and FS-83's layer method at `k = 4` cannot give `F(R) = 0` over ℚ(√59), ℚ(√83),
ℚ(√131) or any S2 field**: a non-periodic four-colouring, if one exists, is not measurable in any finite set of local coordinates. With C10
it is the plan's §S.5 fallback killed before it runs, now for every finite set of places and every measurable window, not only for
characters. **It does not decide S1**: `F(R)` stays open; a "no" now needs a colouring that is non-measurable or reads infinitely many places.
**On S2** it is a class theorem of the "no-go" kind, and it is **triangle-blind**: ℚ(√2,√3) (C12, triangles) and ℚ(√59) (none) behave
identically under it. So the triangle question (G75's) lives entirely outside the window format.

**Prior-art gate (this step).** Two web queries (measurable/amenable independence ratio of direct products; unit-distance graph times a
finite graph, no-homomorphism lemma): nothing measurable of Zhang's theorem found (Conley–Kechris's measurable independence numbers of
group-action graphs are the frame's home; `[Zhang2012]` itself is finite). The window format is this project's (FS-64); no print source
colours a field plane by adelic windows. The transplant C14.1–C14.3 is routine and is labelled as a transplant; the content is its use:
the tight place on Zhang's larger side, the archimedean place on the smaller one through `m₁ < 1/4`, and the pointwise propagation.

## Round 2, step 6 (Coxeter-3): HD1 after C14 — why the sweep stops, and the homogeneous part of Θ₄

**Where C14 leaves HD1.** Every character colouring whose character is continuous in finitely many local coordinates is periodic
(C14 ⊇ C10). The remaining characters are exactly those reading infinitely many split places, and there the sweep of C10 step (2) is
unavailable **for a structural reason, not a technical one**: write `R̂ = 𝔸_L/(L + R^⊥)` with `R^⊥ = ∏_{st}𝔡_v^{−1}` (zero at every
other place; `R` is dense in `L_v` at split `v` and in `L_∞`). A character is an adele `y`, `θ(x) = ψ_𝔸(xy)`, and `θ(u)` for `u ∈ U` sees `y`
only at the archimedean places, the (torsion) stable places, and the **poles of `u`**. For a finite set `S` of split places, the unit
vectors with poles in `S` form `T(O_S)`, which is **discrete and cocompact** in `T(F_∞) × ∏_{v∈S} T(F_v)` (`T` anisotropic): so
`Θ₄ = lim← C_S`, `C_S = {(y_∞, τ, (y_v)_{v∈S}) : θ(T(O_S)) ⊆ J}`, and each `C_S` is cut out on a lattice, with no density to sweep. Weak
approximation made `U = T(F)` dense in `∏_{v∈S}T(F_v)` only because C10's characters had no components outside `S`; an infinite-type `θ`
charges every pole. (This is the precise form of my predecessor's "wild poles" gap.)

**C15 (the homogeneous part of Θ₄ is torsion) [hand].** `U` acts on `R̂` by automorphisms (`(u·θ)(x) = θ(ux)`), and `Θ₄` is closed and
`U`-invariant. **If a coset `y + Y` of a closed subgroup `Y ⊆ R̂` lies in `Θ₄` and is `U`-invariant, it is a finite set of torsion
characters.** *Proof.* (1) The identity component `Y⁰` is closed, connected and `U`-invariant; for `u ∈ U`, `η ↦ η(u)` maps `Y⁰` onto a
connected closed subgroup of `ℝ/ℤ`, so onto `0` or all of `ℝ/ℤ`. The second would make `(y + η)(u)` take every value, leaving `J`. So
`Y⁰(u) = 0` for every `u`, and `U` spans `R`: `Y⁰ = 0`. (2) `Y` is profinite, so `R/Y^⊥` is torsion; `Y^⊥` is closed under multiplication by
`U`, hence an ideal, nonzero, so of finite index (V2): `Y` is finite. (3) `U`-invariance of the coset gives `(u − 1)·y ∈ Y`, so `y`
vanishes on `𝔞·Y^⊥`, `𝔞` the ideal generated by the `u − 1` (nonzero: it holds `−2`), again of finite index: `y` is torsion. ∎
*Non-vacuous:* Fischer's level-3 character's `U`-orbit is such a set. *Meaning:* every algebraic `U`-invariant probability measure on
`Θ₄` sits on torsion points. **So HD1 would follow from a measure-rigidity statement** — every `U`-invariant ergodic probability measure
on `Θ₄` is algebraic — applied to any weak-* limit of orbit averages of a non-torsion `θ`. [reading] The prior art is the rigidity of
higher-rank abelian actions on solenoids (Berend's multi-invariant sets, 1984; Einsiedler–Lindenstrauss, positive entropy); both need
expansion, and **every `u ∈ U` is an isometry at every archimedean place** (`|σ(u)| = 1`), so the archimedean directions carry zero entropy
and neither theorem applies as stated. Killing test of the reading: a non-torsion `θ ∈ Θ₄` (which would also answer S1 "no").
Not pursued further; named as the form HD1 now takes.

## Theorems this phase proved

- **FS86-Cx-C1 (split embedding).** For a place `v` of a real `F` split in `F(i)`, `ι : Cay(R_F, U_F) → H(F_v) = Cay(F_v², {(t,1/t)})` is an
  injective graph homomorphism. [hand; this file §First route; checked by Poros]
- **FS86-Cx-C2 (transfer of forcing to split places).** `F(R_F) ≠ 0` ⟹ `H(F_v)` has no four-colouring, for every split `v`. Contrapositive: a
  four-colouring of one split local plane gives `F(R_F) = 0`. [hand; §First route; checked by Poros] Scope: field plane.
- **FS86-Cx-C2′ (all or nothing in hyperbola graphs).** In `H(E)` (`char E ≠ 2`), a nonzero forced difference at `k` colours implies `χ(H(E)) > k`.
  [hand; §First route]
- **FS86-Cx-C6 (monotone in the field).** `F ⊆ F′` real ⟹ `F(R_F) ⊆ F(R_{F′})`. [hand, one line; §Second line]
- **FS86-Cx-C7 (the gap route is closed through every extension).** For every real finite `F′ ⊇ ℚ(√59)` (and ⊇ ℚ(√83), ℚ(√131): same
  argument, their dyadic completion is `ℚ₂(√3)`), no stable-place target local at the dyadic places has a gapped four-colouring at any
  level, and no odd stable-place target is four-colourable at any level. Local corollary: for every finite `E ⊇ ℚ₂(√3)` with `i ∉ E`, every
  four-colouring of every level of the norm-one plane of `E(i)/E` is gap-free. [hand; uses VK (B1, two derivations), Krasner, weak
  approximation, FS-66's certificate at 11, Lemma P; §Second line] Scope: all real extensions; one named gap (mixed dyadic–odd targets
  with a dyadic factor of ratio > 1/4). **Proof route superseded:** follows from V3 by Poros's restriction (no VK, no Krasner); Poros rules
  it implied by T(2) for scoring, and a real result in content.
- **FS86-Cx-C8 (the "stable torsion + archimedean" form of Θ₄ is dyadic torsion over ℚ(√59)).** [hand; §Round 2 step 1] Partial HD1:
  the general character is not yet reduced to this form.
- **FS86-Cx-C9 (FS-83 at k = 4 fires at ℚ(√11)).** `θ = (2x + 3y)/7 ∘ (mod the stable prime above 7) + ℓ`, `0 < max ℓ ≤ 1/28`, is a non-torsion
  point of Θ₄(ℚ(√11)): an explicit non-periodic four-colouring of ℚ(√11)² by formula. [hand; arithmetic checked mod 7; §Round 2 step 1]
  Scope: field plane of ℚ(√11) (a control, outside the class).

- **FS86-Cx-C10.0 (finite-type characters have well-defined components).** A torsion character of finite type has zero archimedean and
  zero non-stable components; so the components of a finite-type character are unique. [hand; §Round 2 step 2] Scope: any real `F`.
- **FS86-Cx-C10 (HD1 for finite type, class S2).** In the class S2 (one stable place tight at four colours at every level, every other
  stable place `χ_f > 4`), every finite-type point of `Θ₄(F)` is a torsion character of the tight tower; every finite-type character
  colouring of `F²` is periodic. Hypothesis needed (C9 at ℚ(√11)); conclusion non-vacuous (Fischer's functional, level 3). [hand; §Round 2
  step 2; uses weak approximation for `T`, V3, C8] Scope: class S2, field planes; finite-type characters only.
- **FS86-Cx-C12.1 (unramified quadratic dyadic towers: tight at every level iff tight up to the `M`-exponent).** [hand; §Round 2
  step 3; generalises FS38-L2 and D2-B's induction, basis-free, with no use of FS38-L1] Scope: every finite `E/ℚ₂` with residue `𝔽₂`.
- **FS86-Cx-C12 (C-S2: ℚ(√2,√3)'s dyadic tower is four-tight at every level; the field is in S2 with triangles).** [tools exact
  (levels 1–8, the `M` lower bound, `H_min`) + hand (C12.1); `cs2/*.py`] Scope: the local tower; field membership in S2 given the
  §0.3 frame's transfer (Lemma R, Zhang) to ℚ(√2,√3), argued, not re-derived.
- **FS86-Cx-C13.0 (√−3 is a unit vector mod 𝔓^m iff m ≤ e(E/ℚ₂)).** [tools exact, both towers, levels 1–6 + hand (the norm
  argument)] Scope: unramified quadratic dyadic towers.
- **FS86-Cx-C13 (ℚ(√2,√3): F(R) ≠ 0 iff (0,2) forced; a yes makes every √3-pair a virtual edge; the hexagon identities hold on every
  periodic colouring; the pinned spectrum's finite-type part is torsion).** [hand; §Round 2 step 4; field-level parts given the §0.3
  frame's transfer] Scope: the field plane of ℚ(√2,√3).
- **FS86-Cx-C14 (window no-go, class S2).** For every S2 field and every finite set `S` of places containing the tight place `𝔓`
  (archimedean, odd stable at full level, split at full level, `𝔓` at any finite level `m`), every proper four-colouring `W` of the local
  unit-distance graph `Γ_S = Cay(G_S, T_S)` with measurable classes equals, pointwise on each of finitely many `⟨T_X⟩`-cosets, a pull-back
  `γ_K` of a proper four-colouring of `P_m`; hence every plane colouring `r ↦ W(ι_S(r) + t)` of `F²` is periodic, local at `𝔓` (a `P₄`
  pull-back over ℚ(√59), ℚ(√83), ℚ(√131)). FS-64's adelic windows and FS-83 at `k = 4`, with any finite set of places, cannot give
  `F(R) = 0`. [hand; §Round 2 step 5; inputs `[AmbrusEtAl2023]` Thm 1 (`m₁(ℝ²) ≤ 0.2470`, external, computer-assisted), V3's all-levels
  bounds (B1), row 67 (tightness at every level), `[Zhang2012]` Prop. 1.7 (read)] Scope: field planes of S2; the measurable-window
  format. Sharp: fails at ℚ(√11) (C9) and at K (VK), exactly at the hypothesis each violates.
  - **C14.1** window No-Homomorphism lemma (Zhang Prop. 1.7, measurable, amenable windows) [hand, transplant].
  - **C14.2** local ratios: `UD(ℝ²)` ratio `m₁`; odd stable `Cay(O_v, T_v)` ratio `sup_k α(Γ_{v,k})/|Γ_{v,k}|` (full-coset shadow);
    split `H(F_v)` ratio `0`, error `≤ 3/(2n + 4)` (Hoffman on `π^{−n}O²` with the Kloosterman-integral count) [hand].
  - **C14.3** measurable Zhang: ratio of a product is the larger ratio [hand, transplant].
  - **C14.4** the non-tight part `X` of any `Γ_S` over S2 has ratio `< 1/4` [hand, from C14.2–C14.3 and V3].
- **FS86-Cx-C15 (the homogeneous part of Θ₄ is torsion).** A `U`-invariant coset of a closed subgroup of `R̂` lying in `Θ₄` is a finite set
  of torsion characters; so every algebraic `U`-invariant measure on `Θ₄` is atomic on torsion points. [hand; §Round 2 step 6; uses V2]
  Scope: every S2 field (and every field where nonzero ideals of `R` have finite index).
- **FS86-Cx-C14′ (regular windows).** If `W` is proper only on pairs inside a conull set, then `W` is a.e. a `P_m` pull-back on each coset
  and `c_{W,t}` is periodic for almost every `t`: polygonal cut-and-project windows included. [hand; §Round 2 step 5]
- **FS86-Cx-C14-K (window form of VK).** Over any field whose stable places are tight or of all-levels ratio `< 1/4` (K included), every
  measurable window colouring is, per coset, a pull-back from one tight place. [hand, sketch; §Round 2 step 5; rests on VK (B1)]
- **Not proved (named):** HD1 for characters with infinitely many non-stable components (the "wild poles" gap, §Round 2 step 2).

## Retractions

1. (Coxeter-2, 2026-09-25) **C11 as first reported to the owner** said a finitely supported annihilator of every tetrahedral colouring
   *exists iff* `F(R) ≠ 0`. The direction "exists ⟹ `F(R) ≠ 0`" was never proved and is not claimed. The correct statement uses the
   zero set of the whole annihilator ideal (C11 (b)). Caught on re-reading my own text, before anyone relied on it.

## "Would have searched here" log

1. Would have searched for a non-four-colourable finite subgraph of `H(ℚ)` or `H(ℚ₅)` (a solver on Lorentzian point sets), to decide X.
   Instead: read the record (Madore ¶6.4, BMK Rem. 1.3: open) and left X undecided.
2. Would have searched for a gapped four-colouring of a dyadic target of some extension of ℚ(√59) (e.g. `U₈ = Cay(𝔽₆₄, μ₉)` via the real
   cubic of conductor 7), to get a "no" through C6. Instead: derived C7 — no such gap exists, by transfer from VK.
3. (Coxeter-2) Would have enumerated the 256 characters of `O/𝔓⁴` against the 24 points of `S₄` to list `Θ₄`'s dyadic points. Instead:
   derived nonemptiness from Fischer's colouring (addendum 2, item 4) and left the full dyadic list unclassified.
