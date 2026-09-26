# J28V — blind verification of row 88's claims T-A, T-B1, T-B2, T-C, T-C(A) (crunch job J28V, 2026-09-25)

*Blind verifier for the milestone "row 88's question" (`plans/FS86-row88-rigidity.md`), de Bruijn (Opus 5.5). Brief:
`data/crunch-2026-09-25/briefs/J28V-row88-verifier.md`, with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. Data: `data/fs86r88/j28v/`.
Blind until stage 2 is committed: nothing listed in the brief's "Fenced" section has been opened (the plan's §S.2, §M, §IQ; J28D's
derivation record, data, tools, brief and report; the crunch index; J28D commits). Read so far: the plan's header, §0, §S.0, §S.1, §P;
`LEDGER.md` rows 67, 75, 80, 88–97; `plans/FS86-derivation.md` Notation, §1, §5, §6, §9–§11; `plans/FS86-V-D-verification.md` in full.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| J28V-1 | Extension lemma: a stationary random four-colouring of `Cay(R, U)` with spectral measure on `T + A + Fin_S` extends to a `G_S`-stationary process, continuous in probability, `{e_j}`-valued, proper at every pair of `G_S × T_S` | [hand; mine] | §2.1 C2 |
| J28V-2 | Regularisation: such a path, proper off an `(m × ν_T)`-null set of pairs, is a.e. equal to one proper on every pair inside a conull Borel set | [hand; mine] | §2.1 C3 |
| J28V-3 | The tail of odd stable places of a type-(B) field or ℚ(√47), minus 11 / 19, is one compact factor with measurable Hoffman ratio `< 1/4` | [hand + tools exact; mine] | §2.1 C4; `tools/crunch_j28v_facts.py` |
| J28V-4 | T-C, over ℚ(√59), ℚ(√83), ℚ(√131) | [hand; mine; given C14.1–C14.3, `[AmbrusEtAl2023]`, FS-66 at 11/19, Lemmas D, P, D2-A/B] | §2.1 |
| J28V-5 | T-C(A), over ℚ(√47), any finite set `S` of split places, dyadic included | [hand; mine; same inputs] | §2.2 |
| J28V-6 | C14.2 (c) holds at `q = 2` (the split-place integrals are `1, −1, 0, 0, …`) | [hand + tools float with exact target values; mine] | §2.2; facts (3) |
| J28V-7 | T-A (i)–(vi); every non-zero ideal of `ℤ[U_F]` has finite index, for every real `F` (no Lemma R) | [hand; mine] | §2.3 |
| J28V-8 | T-B2's reductions: Q-tr ⟹ T-B2; a counterexample gives `F(R) = 0`; a defect set lies in no finite union of cosets of a finitely generated subgroup; every finite union of unit circles has upper Banach density 0 in `R` | [hand; mine] | §2.4 |
| J28V-9 | T-B1's reductions: `F(R) ≠ 0` ⟹ T-B1; T-B1 ∧ Q-μ ⟹ `F(R) ≠ 0` | [hand; mine] | §2.5 |

## Would-have-searched-here log

- T-C: would have built a finite quotient and searched for a random non-pullback colouring with spectral support on `T + A + Fin_S` (a
  falsifier). Instead derived the extension lemma, which turns any such object into a window colouring C14's count forbids.
- T-C(A): would have run an exact window-frequency LP on a quotient to confirm no measure exists. Not needed: the count is derived.
- T-B1: would have run a SAT search on a ball of `Λ₅₁₀` for a colouring agreeing with a pullback on an inner ball and differing outside (a
  converging family of non-pullbacks). Not run (ban); recorded as GAP with the reductions B1-a–c.
- T-B2: would have searched a lattice quotient for a sparse defect set against a pullback. Not run; derived B2-a–e instead.
- C4's tail: would have computed normalised least eigenvalues at every stable place below some bound numerically. Instead used the recorded
  exact table (23, 31), Weil's inequality proved exactly for `p ≥ 34`, and Lemma P; the stability list is an exact Legendre check of
  seconds (`tools/crunch_j28v_facts.py`, plants fire).

## Stage 1 — SAVED (quotation check; C0 predictions)

### 1.1 Quotation check (standing rule 5)

The brief's "fixed claim list" (its §S.0 definitions and §S.1 target statements, from "### S.0 Definitions" to the controls paragraph)
was extracted mechanically and diffed against `plans/FS86-row88-rigidity.md` lines 388–428. **Result: identical**, character for
character, except for one trailing blank line in the brief. No paraphrase, no dropped qualifier. The brief's other quotations: the
fenced list and the stage list are the brief's own words, nothing to check; §0 item 3's two quotations (CLG, J21-MX) are the plan's,
not the brief's, and are checked when used.

One note on the definitions, logged now so it is not mistaken later for a finding: §S.0's `F_μ(R)` quantifies over
translation-invariant measures only (§M.1's remark is quoted inside §S.0, so the definition is fixed as stated); T-A (ii)–(iv) are
verified against exactly this definition.

### 1.2 C0 — predictions (written before any derivation; first ideas recorded so they can be scored)

| claim | TRUE | GAP | FALSE | the first idea behind it |
|---|---|---|---|---|
| T-A (i)–(vi) | 0.88 | 0.08 | 0.04 | (i)–(iv) are bookkeeping on the frame (V2's ideal argument run on measures; a periodic colouring's finite orbit is an invariant measure); (v) is the Furstenberg correspondence for clopen sets on a countable amenable group; (vi) is "an isolated point in an orbit closure is hit by the orbit". Risk: a quantifier in (v), or (ii) needing more than the frame |
| T-C | 0.35 | 0.55 | 0.10 | VD-C's two-point spectral route cannot work over a real field: FS86-dB-C0 gives a positive-definite function with value −1/3 on every unit vector and archimedean spectrum. A route: spectral support on `T + A + Fin_S` makes the unitary representation extend to the `S`-completion `G_S` (all stable places, the archimedean ones, `S`), so the colouring becomes a stationary measurable window colouring of `Cay(G_S, T_S)`, and then C14/C14′'s product counting — with infinitely many stable places, the tail handled by Hoffman. Risk: C14′ is one mind, and C14 is stated for finitely many places |
| T-C(A) | 0.35 | 0.55 | 0.10 | the same reduction; then CL1's count (every factor `< 1/4`) leaves no measure at all. Risk: dyadic split places in `S` (C14.2 (c) at `p = 2`) |
| T-B1 | 0.10 | 0.75 | 0.15 | isolation of a pullback from a finite patch is a finite-forcing statement conditional on a pattern; nothing on the record gives it short of row 88 itself (if `F(R) ≠ 0`, `X₄ = Pull` is finite and T-B1 is free; if FALSE, row 88 is answered no) |
| T-B2 | 0.20 | 0.65 | 0.15 | a defect at `z` against a gap-free pullback forces defects on an infinite subset of the circle `z + U`, but a circle has upper Banach density 0 in `R`; Q-tr would imply T-B2, not conversely |

Registered consequence: if T-B1 comes out TRUE by derivation, I would be surprised (0.10) and would audit it first (G21).

## Stage 2 — SAVED (the blind phase: my derivations and verdicts)

**Verdicts (blind, before any J28D text was opened):**

| claim | verdict | in one line |
|---|---|---|
| T-C | **TRUE** [hand; mine; inputs below] | spectral support on `T + A + Fin_S` extends the colouring to a stationary measurable window colouring of `Cay(G_S, T_S)`, all stable places included; C14's count, run with a compact tight factor and one Hoffman-controlled compact tail factor, then gives a pullback |
| T-C(A) | **TRUE** [hand; mine; same inputs, no tight place] | the same extension; every factor has ratio `< 1/4`, so four classes cannot cover |
| T-A (i)–(vi) | **TRUE** [hand; mine] | bookkeeping on the frame; (v) is the correspondence principle for clopen sets; two scope notes (§2.3) |
| T-B2 | **GAP** | the step from "each defect forces an infinite set of defects on its unit circle" to positive density; circles have Banach density 0, and nothing on the record supplies the missing expansion |
| T-B1 | **GAP** | isolation is a finite-patch forcing statement; H needs a half-space, and no route from a finite patch was found |

**Setting.** `F` type (B) (`d ∈ {59, 83, 131}`), `L = F(i)`, `U`, `R = ℤ[U]`, the tight place `𝔓` (completion `ℚ₂(√3)`, `O = O_𝔓`,
`𝔓⁴ = 4O`), `π₄ : R → O/𝔓⁴` onto with kernel `R ∩ 𝔓⁴` (FS86-VD-1). A translation-invariant Borel probability `μ` on `X₄(F)` is a
stationary random proper colouring `c`; `g(x) = e_{c(x)}` its tetrahedral embedding; `M` the matrix spectral measure of `g`, `μ_sp = tr M`
the spectral measure of §S.0. `G_S := ∏_{v stable} O_v × (L ⊗ ℝ) × ∏_{v ∈ S} L_v` (all stable places, `𝔓` included, at full depth), and
`T_S := ∏_{stable} T_v × (S¹)^{[F:ℚ]} × ∏_{v∈S} T(F_v)` (product of the local circles, a closed subset of `G_S` and a locally compact
multiplicative group with Haar measure `ν_T`).

### 2.1 T-C — TRUE

**C0. Why the two-point route cannot work (a remark, not a step).** VD-C (FS86-VD-8) needs weights `w` on `U` with `λ_w ≥ −1/3`, equality
only at dyadic minimisers. Over a real field that is impossible: FS86-dB-C0 (W's repair) gives a positive-definite `C` on `L ⊗ ℝ`, depending
on one real place, with `C(0) = 1`, `C(u) = −1/3` on every unit vector, spectral measure `w·δ₀ + (1 − w)·circle(j₁,₁)`; for any
probability `w` on `U`, `∫ λ_w dμ₁ = Σ w(u) C(u) = −1/3` while the atom at 0 contributes `+4w/3` to `∫(λ_w + 1/3)dμ₁`, so `λ_w < −1/3`
somewhere on the circle. So any proof of T-C must use more of the colouring than its pair correlations — here, `m₁(ℝ²) ≤ 0.2470` and
Zhang's product counting.

**C1. `R` is dense in `G_S`, and `T + A + Fin_S` is the image of `Ĝ_S`.** Strong approximation for `𝔾_a` away from one split place
`w ∉ S` (infinitely many exist) gives `x ∈ L` close to a target at finitely many places and integral at every other place `≠ w`; such `x` is
integral at every stable place, so `x ∈ R` (Lemma R). Hence `Ĝ_S → R̂` is a continuous injection; its image is exactly the characters
`χ_a`, `a` supported on stable (finite-level, i.e. torsion) × archimedean × `S` components: `T + A + Fin_S`. `Ĝ_S = (⊕_{stable} Ô_v) × ℝ^{2[F:ℚ]}
× ∏_S L̂_v` is σ-compact, so the image is Borel and "carried by" makes sense.

**C2. Extension lemma [hand; mine].** *If `μ_sp` is carried by `T + A + Fin_S`, there is a process `(G(h))_{h ∈ G_S}` on the same
probability space with (a) `G(x) = g(x)` for `x ∈ R`; (b) `h ↦ G(h)` continuous in `L²`; (c) `G(h) ∈ {e₀, …, e₃}` a.s. for every `h`;
(d) the law of `(G(h_i + k))_i` does not depend on `k ∈ G_S`; (e) `P(G(h) = G(h + t)) = 0` for every `h ∈ G_S` and every `t ∈ T_S`.*
*Proof.* `M ≪ μ_sp`, so `M` is carried by `Ĝ_S`. The closed span `H ⊂ L²(Ω)` of the coordinates of `g(x)`, `x ∈ R`, is `L²(Ĝ_S, M)` with `U_x`
(the Koopman operator of the shift by `x`) acting as multiplication by `χ(x)`. Multiplication by the extension `χ̃(h)`, `h ∈ G_S`, is a
strongly continuous unitary group `Ũ_h` extending `U_x` (dominated convergence); put `G(h) := Ũ_h g(0)` coordinatewise. (a), (b) are
immediate. (c): for `x_n → h` in `R`, `g(x_n) → G(h)` in `L²`, and a limit in probability of `{e_j}`-valued variables is `{e_j}`-valued.
(d): `Ũ_h` commutes with `U_x`, and `U_x` is composition with the measure-preserving shift, so `G(h + x) = G(h) ∘ T_x`: the laws are
`R`-invariant, hence `G_S`-invariant by (b). (e): `U` is dense in `T_S` (weak approximation for the rational torus at finitely many places;
product topology); for `x_n → h`, `u_n → t` in `U`, `P(G(h) = G(h+t)) ≤ P(G(h) ≠ g(x_n)) + P(G(h+t) ≠ g(x_n + u_n)) + P(c(x_n) = c(x_n + u_n)) → 0`,
the last term being 0 because `c` is proper surely. ∎

**C3. A measurable version, regularised to be proper on a conull set [hand; mine].** A process continuous in probability on a second
countable LC group has a jointly measurable version `Φ(ω, h)`. By (e) and Fubini, for a.e. `ω` the path `W = Φ(ω, ·)` satisfies
`W(h) ≠ W(h + t)` for `(m × ν_T)`-a.e. `(h, t)`. Regularise: with `C_n` the centred cube of side `2^{−n}` in `L ⊗ ℝ` and `V_n` a decreasing
sequence of compact open subgroups of the non-archimedean part with `⋂ V_n = 0`, the families `E_n = C_n × V_n` and `E′_n = 1.5C_n × V_n`
are nested with `m(E_n − E_n + E_n) ≤ 3^{2[F:ℚ]} m(E_n)`, so the Vitali lemma and Lebesgue differentiation hold along each. Let `Ω` be the
points that are density points of their own colour class along both families. If `h, h + t ∈ Ω` (`t ∈ T_S`) had one colour `j`, then for
every `t′ ∈ T_S` with `t′ − t ∈ ½C_n × V_n` (a relatively open, hence `ν_T`-positive, set) `h + E_n + t′ ⊆ h + t + E′_n`, so
`m{h′ ∈ h + E_n : W(h′) = W(h′ + t′) = j} ≥ m(E_n)(1 − ε_n − 1.5^{2[F:ℚ]} ε′_n) > 0` for large `n`: a positive measure of bad pairs. So
**`W` is proper on every pair inside the conull Borel set `Ω`** (C14′'s hypothesis), and the construction is translation-equivariant.

**C4. The non-tight part has ratio `< 1/4` [hand; transplant of C14.2–C14.4].** Split `G_S = G_X × O_𝔓`, `T_S = T_X × T_𝔓`, the
categorical product. `X` is the finite product of: the hard stable factor (`11` for `d = 59`; `19` for `83`, `131` — `tools/crunch_j28v_facts.py`
(1); `3`, `7` are never stable here), ratio `≤ U(p)/p²` at every level by FS-66's certificate (C14.2 (b)); **the tail** `K_tail = ∏` of all
other odd stable places, one compact factor; the `[F:ℚ] = 2` real places, ratio `m₁ ≤ 0.2470` each (C14.2 (a), `[AmbrusEtAl2023]`);
the split places of `S` (all odd here), ratio 0 (C14.2 (c)). **The tail by Hoffman, measurably and all at once:** with `ν = ⊗ Haar(T_v)`,
`ν̂(χ) = ∏_v ν̂_v(χ_v)` over the finitely many non-trivial components, each `ν̂_v ∈ [−a_v, 1]` real (`−1 ∈ T_v`), so
`ν̂(χ) ≥ −sup_v a_v`, `a_v` the least normalised eigenvalue at every level: 23 (0.3317) and 31 (`1/3 − 4.9·10⁻⁶`) from B1's exact table,
`p ≥ 37` by Weil (`2√p/(p+1) < 1/3` exactly when `36p < (p+1)²`, true for `p ≥ 34`; facts (2)), levels `≥ 2` by Lemma P (`≤ 2/(p+1)`),
the ramified `d` by V3ram (`< 1/5`). So `sup a_v < 1/3` and the measurable Hoffman bound `α ≤ a/(1+a)` gives `r_tail < 1/4`; `K_tail`
is compact, so it "has ratio `r_tail` with error 0" in C14's sense ((R2) with `D = K_tail`). C14.3's induction over these finitely many
factors gives **`X` ratio `r_X < 1/4` with error `η_X(n) → 0`**, and `⟨T_X⟩` is dense in `G_X` (VC-C2 at every odd stable place, `ℂ` at the
real places, `F_v²` at split places).

**C5. The main count with a compact tight factor, in stationary form [hand; mine, transplanting C14's count].** For a.e. `ω` run C14's
count on the regularised path with `P = Cay(O_𝔓, T_𝔓)` in place of `P_m`: sums over `b ∈ P` become Haar integrals, and Zhang's Prop. 1.7 in
`P` becomes C14.1 in `P` with `r = 1/4`, error 0 ((R1): the measurable Hoffman bound, `P` tight at every level, Lemma D; (R2): a pullback
class, `D = O`). Observations (i), (ii) hold verbatim (they use only properness on `Ω`). Summing the four classes gives, for every `n`,
`avg_{x ∈ Φ_n} f_ω(x) ≤ η_X(n)/(r_X κ)`, `κ = 1/(4r_X) − 1`, where `f_ω(x) = Σ_j m_P{b : x ∈ X^{j*}_b}`. **The finite-`P` step "some point
has no bad `b`" does not transplant** (a compact `P` allows `f` small and positive everywhere); stationarity replaces it: `f_ω(x)` is a
translation-equivariant function of the path's a.e.-class, whose law is `G_S`-invariant (C2 (d)), so `E f(x) = E f(0)` and
`E f(0) = E avg_{Φ_n} f ≤ η_X(n)/(r_X κ) → 0`. Hence a.s. `f(x) = 0` for a.e. `x`: at such `x`, a.e. `b` lies in `A^{W(x,b)}_x`, so the fibre's
four classes are a.e. inside the four independent sets `A^j_x ⊂ O`, each of measure `≤ 1/4`; so each has measure exactly `1/4`, and the
equality case of Hoffman (`Σ_{χ≠1}|Â|²(ν̂_𝔓(χ) + 1/3) = 0`) puts `Â` on the trivial character and the minimisers, which kill `𝔓⁴` at every
level (Lemma D, FS38-D2-B, as in VD-C). **So a.e. fibre `W(x, ·)` is `γ_x ∘ π₄` a.e., `γ_x` a proper four-colouring of `P₄`.**

**C6. Propagation [hand; C14's, a.e. form].** For a.e. `x` and `ν`-a.e. `t ∈ T_X`, with `y = x + t`: for a.e. `b` and a.e. `s ∈ T_𝔓`,
`(x, b − s), (y, b) ∈ Ω` and `W(y, b) ≠ γ_x(π₄(b − s))`; every residue of `T_𝔓` mod `𝔓⁴` has positive measure and `γ_x` is gap-free (D2-A),
so `W(y, b) = γ_x(π₄ b)` for a.e. `b`: `γ_y = γ_x`. The a.e.-periods of `x ↦ γ_x` form a closed subgroup containing a dense subset of
`T_X`, hence `⟨T_X⟩`'s closure `= G_X`. **So `W = γ_ω ∘ π₄` a.e. on `G_S`.**

**C7. Back to `R` [hand; mine].** `h ↦ P(G(h) = γ(π₄ h))` is continuous (`π₄` locally constant, `G` continuous in probability) and equals 1
for a.e. `h` (Fubini), so it is 1 everywhere, in particular on the countable `R`: a.s. `c = γ ∘ π₄` on `R`, and `γ` is a proper colouring
of `P₄` because `U ↠ T mod 𝔓⁴`. So `μ` is carried by Pull. ∎

**Inputs, and what is mine.** Mine: C0–C3, C5's stationary replacement of the finite-`P` step and the compact tight factor, C7, and the
tail-by-Hoffman factor in C4. Transplanted, re-walked here, not re-derived from scratch: C14.1, C14.3 (Coxeter; verifier C blind — two
derivations), C14.2 (a)–(c), C14's observations (i)–(ii) and propagation, C14′'s regularity idea (one mind; here replaced by my C3 and C5).
External or certified: `[AmbrusEtAl2023]` Thm 1 (audited by J26); FS-66's certificates at 11 and 19; B1's exact spectra at 23, 31; Lemma P,
Lemma D, FS38-D2-A/B, V3ram, VC-C2, Weil. **The real place enters only through `m₁ < 1/4`**: the proof is sharp at ℚ(√11), whose stable 7
(ratio 2/7) breaks C4 and where C9's colouring has spectral measure on `T + A` and is no pullback (P-controls: consistent).

### 2.2 T-C(A) — TRUE

Over ℚ(√47) the stable places are 11, 19, 23, 31, 43, 47, … (facts (1)); 3 and 7 are split; 2 is split (the wall is broken), so no
place is tight. Run C1–C3 unchanged (they never used the tight place). In C4 **every** factor of `G_S` has ratio `< 1/4`: 11 and 19 by
FS-66 (0.2331, 0.2147), the tail by Hoffman as above (23, 31 exact; Weil from 37), the ramified 47 by Lemma P, real places `m₁`, split
places 0 — **including dyadic ones, which C14.2 (c)'s computation covers**: its integrals `∫_{O^×} ψ(bε)dε` are `1, −1 = −1/(q−1), 0, 0, …`
at `v(b) = 0, −1, −2, …` for `q = 2` (facts (3); the non-stationary substitution `ε ↦ ε(1 + π^{−b}x)` needs only `−b ≥ 1`), so CL1's
restriction to odd split places is not needed. So `G_S` has ratio `r < 1/4` with error `η(n) → 0` (C14.3), and on a.e. regularised path the four
classes (independent on `Ω`, covering a.e.) give `1 = Σ_j d_n(S^j) ≤ 4(r + η(n))`, false for large `n`. So no such `μ` exists. **The
"hence":** a four-colouring's translation-orbit closure is a compact invariant subset of `X₄(F)` (per `R`-coset), so it carries a
translation-invariant probability (`R` is amenable), whose spectral measure by the first sentence is carried by no `T + A + Fin_S`. ∎
Relation to the record: this is FS86-CL1's count moved from measurable windows to invariant measures with that spectral type, now with every
stable place at once and dyadic split places allowed; it is one derivation (mine), a second to CL1's (one mind).

### 2.3 T-A — TRUE (all six parts)

(i) `π₄` is onto, so Pull is in bijection with the proper four-colourings of `P₄`: finite, hence closed. Translation by `t` sends
`γ∘π₄` to `γ(· − π₄t)∘π₄`; rotation by `u` to `γ(ū ·)∘π₄` (multiplication by a unit of `T mod 𝔓⁴` is an automorphism of `P₄`);
conjugation and every automorphism `σ` of `F(i)` preserving `R` fix `𝔓` (the stable primes are exactly the primes of `L` at which `R` is
integral, a set `σ` preserves, and `𝔓` is the only one with a tight four-colour plane) and induce automorphisms of `P₄`. ✓
(ii) By translation invariance, `δ ∈ F_μ` iff every invariant `μ` is carried by the `δ`-periodic colourings. A subgroup, and `U`-stable
(push `μ` forward by `m_u`, which normalises the translations), so an `R`-submodule: an ideal. **Every non-zero ideal has finite index, for
every `F`:** `δ ≠ 0` has a minimal polynomial with `a₀ ≠ 0`; clearing denominators puts a non-zero integer `m` in `δR`, and `|R/mR| ≤ m⁴`
(torsion-free of rank 4). `F ⊆ F_μ`: a forced pair is identified by every colouring. `F_μ ⊆ P`: a periodic colouring has a finite
translation orbit, whose uniform measure is invariant. If `F_μ ≠ 0` it has finite index, so every `μ` is carried by periodic colourings,
which (frame) are pullbacks, which are `(R ∩ 𝔓⁴)`-periodic: `P(R) ⊆ F_μ`. So `F_μ ∈ {0, P(R)}`. ✓
(iii) ⟸: Pull is `P(R)`-periodic and `P(R) ≠ 0`. ⟹: `F_μ = P(R)`, and a `P(R)`-periodic proper colouring is a proper colouring of
`R/(R ∩ 𝔓⁴) = O/𝔓⁴` with connection set `U mod 𝔓⁴ = T mod 𝔓⁴`, i.e. a pullback (no frame needed here). ✓
(iv) ⟹: `F = P(R)` makes every colouring a pullback, so `X₄ = Pull` and both halves hold vacuously. ⟸: a `c ∉ Pull` has an orbit closure
carrying invariant measures (amenability), all on Pull by Q-μ, so `c` is transient, against Q-tr; so `X₄ = Pull` and `F ⊇ R ∩ 𝔓⁴ ≠ 0`. ✓
(v) `U_B := {y : y|_B ∉ Pull|_B}` is clopen and `X₄ ∖ Pull = ⋃_B U_B` (increasing; Pull is finite). For a countable amenable group and
clopen `V`, `d*({t : t·c ∈ V}) = max{ν(V) : ν invariant on the orbit closure of c}` (≤: Følner empirical measures; ≥: pick `y` with
`K`-average `≥ ν(V) − ε`, then a translate of `c` agrees with `y` on `K + B`). So `c` is transient iff every such `ν` has `ν(U_B) = 0` for
every `B` iff every return-time set has upper Banach density 0. ✓
(vi) If `c` is transient its orbit closure `Y` meets Pull (it carries an invariant measure, which lives on Pull); an isolated `p ∈ Y ∩ Pull` has
a neighbourhood `{p}`, so some translate of `c` is `p` and `c ∈ Pull`: contradiction. So Q-tr, and by (iii)–(iv) `F ≠ 0 ⟺ F_μ ≠ 0`; both lie in
`{0, P(R)}`, so they are equal. ✓
**Scope notes (not defects of truth).** (a) For S2 fields other than type (B), "row 67's `P₄`" must be read as the tight place's own
stabilised level (for ℚ(√2,√3), C12.1's `P_c`), and `Aff_F` needs `σ(U) = U`, which "preserving `R`" gives when `F/ℚ` is Galois (then complex
conjugation is central in `Gal(L/ℚ)`), not obviously otherwise. (b) (ii)'s finite-index step needs no Lemma R (the rank argument above).

### 2.4 T-B2 — GAP

What I can prove: **(B2-a)** Q-tr ⟹ T-B2 (a defect set of upper Banach density 0 makes `c` transient: `c ∉ Pull`, since two distinct
pullbacks differ on a union of `(R ∩ 𝔓⁴)`-cosets, and every return-time set of (v) lies in finitely many translates of `D`). **(B2-b)** A
counterexample to T-B2 is a non-pullback, so it would give `F(R) = 0` (row 88 answered no): T-B2 FALSE is as hard as row 88. **(B2-c)
Propagation:** if `c(z) = a ≠ p(z)`, every `z + u` with `p(z + u) = a` is a defect; these `u` form 8 of the 24 residue classes of `U` mod
`𝔓⁴` (gap-freeness), an infinite set dense in `(S¹)²`. **(B2-d)** So `D` is contained in no finite union of cosets of a finitely generated
subgroup `Λ` (each residue class of `U` is infinite and bounded in `L ⊗ ℝ`, while a finite union of cosets of the discrete `Λ` has finite
bounded part). **(B2-e) But a circle has upper Banach density 0 in `R`:** two distinct circles meet in at most two points, so if `x + U` had
density `δ` in a Følner set almost invariant under `k` distinct translations, `k(δ − ε)|F| − 2k² ≤ |F|`, i.e. `δ ≤ 1/k + ε + o(1)`; the same for
any finite union of circles. **The gap:** from (B2-c), iterated, to `d*(D) > 0`. Iterating keeps `D` a countable union of circle-pieces, dense
archimedeanly in open sets after two steps, but density in `L ⊗ ℝ` is not Banach density in `R` (Følner sets of `R` are fine grids over
ever more primes), and neither H (half-spaces), D/D′ (patchworks) nor T-C (measures) gives an expansion bound for the defect graph. No
counterexample either: none is constructible without answering row 88.

### 2.5 T-B1 — GAP

What I can prove: **(B1-a)** `F(R) ≠ 0` ⟹ T-B1 (then `X₄ = Pull` is finite). **(B1-b)** A counterexample (non-pullbacks `c_n → p`) gives
`F(R) = 0`. **(B1-c)** T-B1 ∧ Q-μ ⟹ `F(R) ≠ 0` (T-A (vi), (iii), (iv)); so, given T-C, T-B1 reduces row 88 to Q-μ outside `T + A + Fin`.
**The gap:** isolation says a finite patch `p|_B` has the unique extension `p`, a conditional finite-forcing statement. Theorem H gets
unique continuation only from an additive half-space (its descent on `inf h` uses the unit vectors with `h(u) < 0` arbitrarily small, which a
finite `B` does not supply); the local plane's rigidity (row 90) comes through local forcers built on `√3`, absent from `F`; and by
compactness isolation of `p` is not implied by `⋂_B {c : c|_B = p|_B} = {p}`, which holds trivially. No route found.

## Stage 3 — SAVED (the lemma-statement phase: not available)

T-B1 and T-B2 stalled at GAP, so stage 3 applied. At 2026-09-25, after stage 2's commit, `plans/FS86-R88-D-derivation.md` was checked
**by its headings only**: it held "Theorems this phase proved", Stage 1 (quotation check, C0, log) and Stage 2 (T-A) — **no section
"Lemma statements for J28V"**. So there were no statements to re-derive, and nothing was re-derived here. The GAP verdicts on T-B1 and
T-B2 stand as the blind phase left them. If J28D later posts lemma statements for T-B1 or T-B2, this stage can be re-opened on the owner's
word (the statements only).

## Stage 4 — SAVED (the divergence table; partial: J28D's record holds T-A only)

Read after stage 3's commit: `plans/FS86-R88-D-derivation.md` in full as it stood (J28D's Stage 1 and Stage 2, 10.5 kB; T-A only; no T-C,
T-C(A), T-B1 or T-B2 section yet). **So only T-A can be compared; the other four claims are pending J28D's later stages**, and this table
must be completed when they are saved (about 40k of this job's budget remains for it).

| # | claim | kind | J28D | mine (blind) | verdict |
|---|---|---|---|---|---|
| V1 | T-A overall | none (truth) | TRUE (i)–(vi) | TRUE (i)–(vi) | agree |
| V2 | T-A (i), `τ` | scope, wording | repair: read `τ` as commuting with conjugation (≡ preserving `U`); automatic for type (B), `Gal ≅ V₄` | the same condition, stated as "preserving `R` gives `σ(U) = U` when `F/ℚ` is Galois (conjugation central)" | agree in substance; J28D's wording (commuting with conjugation) is the cleaner fix for the statement |
| V3 | T-A (ii), finite index of a non-zero ideal | route | V2 (Lemma R) | rank argument: a non-zero ideal contains a non-zero integer `m` (minimal polynomial), and `\|R/mR\| ≤ m⁴`; no Lemma R | both valid; mine removes Lemma R from (ii) for every real `F` (J28V-7), which matters for S2 fields outside Lemma R's proved scope |
| V4 | T-A (iv) ⟸ | route (order) | `F = 0` ⟹ a `c` with `c(0) ≠ c(4)`, not in Pull, not transient (Q-tr), so Q-μ fails | a `c ∉ Pull` is transient under Q-μ, against Q-tr, so `X₄ = Pull` | the same argument, contrapositive order |
| V5 | T-A (v), the correspondence | none | Lemma CL proved in place, both directions | the same two directions | identical route |
| V6 | Q-tr ⟹ T-B2 | route | via the pair orbit closure in `X₄ × Pull` (invariant measures carried by the diagonal) | via return times lying in finitely many translates of `D` (B2-a) | both valid |
| V7 | a FALSE for T-B1 or T-B2 decides row 88 "no" | agreement, and a slip of mine | recorded (T-A2), with a coherence note on the plan's §P (FALSE priced 0.10 / 0.15 against P-decide "no" 0.02) | recorded (B1-b, B2-b) — **but my own C0 priced FALSE at 0.15 for each, the same incoherence** | agree on the math; the slip is mine (standing rule 4's selection risk in the other direction: priors not re-read against a consequence I had written in the same row) |
| V8 | controls | agreement | ℚ(√11) outside T-A's hypotheses (the frame fails there); K per coset; ℚ(√2,√3) given T721 | consistent (§2.1's closing remark) | agree |
| V9 | T-C's formats | agreement, found independently | §1.1 Q5 flags both obstacles before deriving: C14 reads `𝔓` at finite level only; C14′'s conull-`Ω` format differs from the edge-a.e. format a random extension produces | the same two obstacles met and repaired in the blind phase: C5 (compact tight factor, stationary count) and C3 (density-point regularisation to a conull `Ω`) | agree on the obstacles; whether J28D's repair matches mine is pending its §3 |

**Pending (when J28D saves them):** T-C, T-C(A) (mine TRUE — compare the extension step, the regularisation, the compact tight factor and the
tail); T-B1, T-B2 (mine GAP — compare any route J28D finds against B1-a–c and B2-a–e).

### What the comparison changes in my verdicts
Nothing so far: T-A TRUE is confirmed by an independent derivation with the same steps and one different route (V3). My slip (V7) is in
the priors only.

## Stage 5 — SAVED (the four pending divergence rows; J28D's record at 3a4fc0fd, read in full)

J28D's record now holds §3 (T-C in class form over S2, T-C(A)), Stage 4 (T-B1, T-B2) and §5.2 (lemma statements). My verdicts were
committed blind at e1a29f37, before any of it was opened.

| # | claim | kind | J28D | mine (blind) | verdict |
|---|---|---|---|---|---|
| V10 | T-C | truth | TRUE, one mind | TRUE, one mind | agree |
| V11 | T-C, scope | scope | class form: every real field with one row-67 tight place and every other stable place of all-levels ratio `< 1/4` (all of S2) | stated for type (B); the route never used more than that class (C4 splits off the finitely many Hoffman-failing places the same way) | J28D's statement is the wider one, and my route reaches it unchanged |
| V12 | T-C, extension | route | C1–C2: the hypothesis **is** `τ_S`-continuity in probability of `y ↦ P(c(0) ≠ c(y))` (an iff, via Bochner on `G_S`); extend by uniform continuity | C2: spectral representation; the unitary group extends from `R` to `G_S` by multiplication by extended characters | the same extension, proved two ways; J28D's also gives the converse. Its C3 (`P(c̃(x) = c̃(x+w)) = (1 + 3C̃(w))/4 = 0`) is a one-line form of my C2 (e) |
| V13 | T-C, regularisation | route | edge-null sets handled directly (social/lonely points, essential neighbourhoods `N_e`); density points used only inside the doubling factor `X` (TC-reg, C14.1-e); C14′ judged inapplicable because a null set of bad edges can touch every vertex | C3: density points on **all** of `G_S` along a nested one-parameter family `C_n × V_n` (non-doubling, but `m(E_n − E_n + E_n) ≤ 3^{2[F:ℚ]}m(E_n)` suffices for Vitali), which yields a conull `Ω` with properness on every pair inside it — C14′'s format | both valid; J28D's objection applies to the unregularised path, which my C3 regularises. Different routes |
| V14 | T-C, the other stable places | route | **absorbed into the tight factor**: `Y′ = O_𝔓 × ∏_{H*} O_v` is Hoffman-tight with least eigenspace the `𝔓`-minimisers (Lemma Y′) | **kept in the non-tight side** as one compact tail factor of Hoffman ratio `< 1/4`, joined to `X` by C14.3 | different routes, each valid (Lemma Y′ re-derived from its statement below). Both split off the same finite set `B` (11 or 19) |
| V15 | T-C, the count | route | stationary from the start: expectations `ℓ_j ≤ r_X β_j`, `p_j ≤ ¼(1 − β_j) + r_X β_j`, summed | samplewise C14 count on the regularised path, then stationarity only to turn "window average of `f` → 0" into `f = 0` a.e. | the same Zhang counting idea (through C14.1, C14.3, observations (i)–(ii)), executed two ways |
| V16 | T-C, back to `R` | route | `C(δ) = 1` for `δ ∈ R ∩ 𝔓⁴` by stationarity and Fubini, so `c` is `R ∩ 𝔓⁴`-periodic | `h ↦ P(G(h) = γ(π₄h))` continuous and a.e. 1, hence 1 on `R` | two routes, both valid |
| V17 | T-C(A) | truth; route; one input | TRUE; `Y′ = ∏_H O_v` with no tight factor, count `1 ≤ 4 max(α(Y′), r_X)`; the dyadic split case from J21-D1-2, re-read, "a second reading, not a second derivation" | TRUE; tail joined to `X` by C14.3, then `1 ≤ 4(r + η(n))`; the dyadic split case re-derived by hand (J28V-6) | agree on truth. **C14.2 (c) at `q = 2` now has an independent derivation of mine** beside M3's |
| V18 | T-B1 | truth; the named step | GAP; re-centring closes when the nearest defect is archimedean-dominated (H applies) and stops when it is split-dominated (an ultrametric sphere, no ultrametric H); a pinned bootstrap stops at the discreteness of `T(O_S)` | GAP: isolation is conditional finite forcing, and H needs a half-space that a finite `B` does not supply | **the same step**: unique continuation from a region that is no archimedean half-space. J28D's statement of it is sharper (it closes the archimedean-dominated case and isolates the split-dominated one) |
| V19 | T-B2 | truth; the named step; a partial | GAP at "B2-growth"; B2-2: `d*(z + kU) = 0` for every `k`; B2-3: a sparse defect is transient, so no invariant-measure argument can reach T-B2 | GAP at the passage from propagation to positive density; finite unions of circles have density 0 (B2-e); defects lie in no finite union of cosets of a finitely generated subgroup (B2-d) | **the same step.** J28D's B2-2 is stronger than my B2-e (it covers every archimedean-bounded set); its B2-3 is a point I did not make |

### Are the two T-C routes independent?
- **Neither uses the other's new steps.** My C2, C3 and C5 were committed at e1a29f37 before I opened J28D's record, and J28D's header says J28V
  was not read. J28D's route has no counterpart of my C3's conull `Ω`, my tail factor, or my samplewise count; mine has no counterpart of its
  Lemma Y′, its social/lonely decomposition, or its `C(δ) = 1` ending.
- **What they share:** the architecture (extend to `G_S`, regularise by density points, a Zhang count against a tight compact factor, Hoffman
  equality, propagation). They also share every transplanted and external input: C14.1–C14.3 and C14.2 (a)–(c), themselves two derivations;
  `[AmbrusEtAl2023]`; FS-66's certificates at 11 and 19; Lemmas D and P; FS38-D2-A/B; VC-C2; weak and strong approximation.
- **So: two derivations of T-C, and two of T-C(A),** each one mind, blind to each other, with common inputs. That meets the standard a
  ledger row needs ("two derivations"), with the inputs listed once.
- **One asymmetry for T-C(A):** a split dyadic place in `S` rests on C14.2 (c) at `q = 2`. For that step, J28D's re-reading is not a
  derivation; mine is.

### §5.2's lemma statements, each re-derived here from its statement (the proofs checked only where they differ from mine)
- **L-A, L-A1, L-A2, L-CL:** TRUE. These are my §2.3 and B2-a, B1-b, B2-b.
- **L-C1:** TRUE.
  - ⟹ is my C1–C2.
  - ⟸: a `τ_S`-continuous positive-definite function on the dense `R` extends to one on `G_S`. Bochner gives a measure on `Ĝ_S`, and it
    restricts to `σ` by uniqueness on `R̂`.
- **L-C2, L-C3:** TRUE. These are my C2 (a)–(e) and C3's first sentence.
- **L-C4 (Y′ tight):** TRUE. The non-trivial characters have product values in `[−1/3, 1]`, each `H`-factor lies in `(−1/3, 1)` (VC-C2
  excludes the value 1), and equality forces a `𝔓`-minimiser with every other factor trivial. This is the same computation as my C4, used
  on the tight side.
- **L-C4b:** TRUE. It is my C3's density-point argument; mine also covers the non-doubling infinite product by using the nested family.
- **L-C5, L-C6:** TRUE. My C5 proves them with `Y′ = O_𝔓`, and the count runs unchanged for any compact factor that is Hoffman-tight at
  `1/4` with those minimisers.
- **L-C(A):** TRUE. This is my §2.2.
- **L-tab:** TRUE. It agrees with `tools/crunch_j28v_facts.py`: the sets are `{11}`, `{19}`, `{19}`, `{11, 19}`, and the margins are
  `1.6·10⁻³` and `4.88·10⁻⁶`.
- **L-B2-2:** TRUE, re-derived.
  - Let `B` be a bounded archimedean ball. If a fraction `δ` of a Følner set `F` lay in `B`, pick `m` translates `x_i` with the `B + x_i`
    pairwise disjoint. Then `|F ∩ (B + x_i)| ≥ (δ − ε)|F|` for each `i`, so `δ ≤ 1/m + ε`.
  - So every archimedean-bounded subset of `R` has upper Banach density 0.

### What stage 5 changes in my verdicts
Nothing. Every verdict stands: T-A, T-C and T-C(A) TRUE; T-B1 and T-B2 GAP at the step J28D also names. Two items are added to the
theorems list below.

| id | statement (one line) | grade | where |
|---|---|---|---|
| J28V-10 | every archimedean-bounded subset of `R` has upper Banach density 0 (J28D's L-B2-2, re-derived; it contains my B2-e) | [hand; re-derivation] | §Stage 5 |
| J28V-11 | J28D's §5.2 statements L-C1, L-C4, L-C4b, L-C5 re-derived from their statements | [hand; re-derivation] | §Stage 5 |
