# FS-91 stage 0 — three colours over real number fields, a blind derivation (crunch job J09)

*De Bruijn (Opus 5.5), 2026-09-25, crunch job J09 (brief `data/crunch-2026-09-25/briefs/J09-three-colours-blind.md`, standing rules
`data/crunch-2026-09-25/briefs/STANDING-RULES.md`). Blind: until stage 3's verdicts are committed I have not opened the advisor's crunch
plan, J02's brief, J02's record or `data/fs91/j02/`, any commit naming J02, the FS-91 close inventory, M1's plan, or the crunch queue past
§1. Grades are `CLAUDE.md` § Notation's.*

## Stage 1 — SAVED

### 1.1 Quotations checked against their sources

| quotation in the brief | source I may open | result |
|---|---|---|
| the advisor's F1 sentence ("If this holds: χ(F²) ≤ 3 ⟺ L(F) ≤ 3 for every real number field, so the conjecture's L ≤ 4 clause holds everywhere.") and "First instance ℚ(α,√7): Θ₃ = ∅, so χ = 4." | `plans/POROS-2026-09-25-crunch-plan.md` §1.2 F1 — **fenced** | **not checkable by me**; taken as the brief's fixed statements S1–S3 |
| S3's field "`F = ℚ(α, √7)`, `α³ = α + 1`" and its prediction | `plans/STUB-three-colours-residue-degree-three.md`: "**First instance: `F = ℚ(α, √7)`, `α³ = α + 1`.**" and "`Θ₃(ℚ(α, √7)) = ∅`, so χ = 4 (the conjecture's prediction)" | matches |
| "`L(F)` and 'usable prime': `CLAUDE.md` § Notation" | § Notation, read from disk: "**Usable prime** of F: one whose residue field is 𝔽_q with q ≡ 3 (mod 4) — for q = p^f that is p ≡ 3 (mod 4) **and f odd**; then χ(F²) ≤ χ(Γ_q) (row 52). **L(F)**, F's *local bound*: the least chromatic number among the residue targets its conjugation-fixed primes supply." | matches |
| "`Θ₃(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(u) ∈ [1/3, 2/3] for every u ∈ U_F}`" | `LEDGER.md` row 82: "`Θ₃(F) = {θ ∈ Hom(ℤ[U_F], ℝ/ℤ) : θ(U_F) ⊆ [1/3, 2/3]}`" | matches (R = ℤ[U_F]) |
| "At three colours it is proved for real quadratic fields and for fields containing √3" | § Notation / Mission: "proved only for L ≤ 3 generally, L ≤ 4 given √3, and L ≤ 5 for multiquadratic F ⊇ K (G55); since FS-81 also L ≤ 4 for every real quadratic field (row 82)" | matches |
| the stub's arithmetic of ℚ(α,√7) | to be re-derived (stage 3), not trusted | — |

One wording note, not a divergence of truth: the stub says of ℚ(α,√7) "the dyadic targets have `χ ≥ 4`". Re-derived at stage 3: the one
dyadic prime of `F` **splits** in `F(i)` (`F_𝔭 ⊇ ℚ₂(√7) = ℚ₂(i)`), so it supplies no target at all; `L(F) = 4` comes from 7 alone.

### 1.2 C0 — priors, before any written derivation

Honesty note (as verifier G's at FS-89): written after reading the brief, the rules, the stub, `LEDGER.md` rows 52–60, 72–74, 79, 82–84,
95–97, `plans/FS81-derivation.md` §1–§2, `plans/FS89-derivation.md` §1–§2, `plans/FS89-S0A-gluing-verification.md` §C1 and FS86's Lemma R
entries. While reading I made a first mental pass at a route (below), so these are priors of that moment, not of a blank mind.

| statement | predicted verdict | probability |
|---|---|---|
| **S1** for every real **number** field | TRUE | 0.75 |
| S1 for every **algebraic** subfield of ℝ (L read through places) | TRUE, by König's lemma from the number-field case | 0.65 |
| S1 for every subfield of ℝ | GAP at the definition of `L(F)` for transcendental `F` (§ Notation defines it through primes) | 0.6 that the honest verdict is a named gap |
| **S2** | TRUE, as a corollary of S1, G55 and the residue upper bound | 0.75 |
| **S3** | TRUE (`Θ₃ = ∅`, `χ = 4`) | 0.8 |
| a point of `Θ₃(ℚ(α,√7))` exists (the falsifier) | — | 0.1 |

**The route I expect.** FS81-T4 already types every `ℤ[i][1/5]`-layer of a point `θ ∈ Θ₃(F)` as parity (`τ = 1/2`) or order 3 (`τ = ±1/3`);
its torsion part `τ` has an order-3 component `τ₃ = 4τ` that vanishes exactly on the parity-type unit vectors. Non-bipartite forces `τ₃ ≠ 0`.
The one piece of information FS-81 did not exploit: **the zero set of `τ₃` on `U_F` is invariant under multiplication by `i`** (a layer
contains `i` times each of its vectors). If `τ₃` is local at the stable primes above 3 and reads residues, weak approximation for the norm-one
torus turns that invariance into a statement about an `𝔽₃`-linear functional on `∏ 𝔽_{q_𝔓²}` restricted to `∏ μ_{q_𝔓+1}` — which should
fail when every `q_𝔓 ≥ 27` by a character-sum count, and hold at `q = 3` exactly by the four order-3 characters. The two risks: (a) that
`τ₃` is local (a Lemma R at 3 without FS86-B1-LR's Galois hypothesis), and (b) the count at `q = 27`, where Weil's bound may be too weak.

## Stage 2 — SAVED

**Result of the stage: S1 is TRUE for every real number field, by a route that is not the one C0 expected. C0's route fails: its key
lemma (K1 below) is FALSE at `q = 27`, with an explicit counterexample, independently confirmed.** What closes S1 instead is that the
parity part of a three-colour character lives at the dyadic places and its order-3 part at the 3-adic places, and weak approximation
makes the two independent, so a character cannot mix the two layer types (Theorem J4).

### 2.0 Notation (fixed once)

`F ⊆ ℝ` a number field, `L = F(i)`, `x ↦ x̄` complex conjugation (the non-trivial element of `Gal(L/F)`), `U = U_F = {u ∈ L : uū = 1}`,
`R = ℤ[U]` (the additive span of `U`), `R₅ = ℤ[i][1/5]`. A prime `𝔓` of `L` is **stable** if `𝔓̄ = 𝔓`; `S_p` is the set of stable primes
above `p`. `O′ = {x ∈ L : v_𝔓(x) ≥ 0 for every stable 𝔓}`. For `𝔓` stable over `𝔭` of `F`, `T(F_𝔭) = {t ∈ L_𝔓 : N_{L_𝔓/F_𝔭}(t) = 1}`,
residue field `𝔽_{q²}` with `q = N𝔭`, and `T(O_𝔓) = T(F_𝔭)` reduces onto `μ_{q+1}`. An odd stable prime is inert in `L/F` (`L/F` is
unramified at odd primes), and "stable above 3" is "a prime of `F` above 3 of odd residue degree `f`", `q = 3^f` (FS81-T7).
For `θ ∈ Θ₃(R)`, `τ = lim_k θ(25^{−k}·)` is FS81-T4's character `R → (1/6)ℤ/ℤ`; put `τ₂ = 3τ` (order ≤ 2), `τ₃ = 4τ` (order ≤ 3),
`α = θ − τ`. A unit `u` is **P-type** if its layer `uR₅` is parity-type (`θ(u·)|_{R₅} = θ₂ + λ_e`, `|e| ≤ 1/6`), **O-type** if it is in
FS81-T3's `X₃`.

### 2.1 Lemma J1 — the typing, read on `τ₂` and `τ₃` [derived from FS81-T3, T4]

For every `F ⊆ ℝ`, `θ ∈ Θ₃(R)` and `u ∈ U`: `τ₃(u) = 0 ⟺ τ₂(u) = 1/2 ⟺ u` is P-type; on an O-type layer `α = 0` and `τ₂ = 0`.
*Proof.* FS81-T4: `τ(u) = 1/2` on P-type units and `τ(u) ∈ {1/3, 2/3}` on O-type ones; `τ₂ = 3τ` is `1/2` resp. `0`, `τ₃ = 4τ` is `0` resp.
`τ(u)`. On an O-type layer `θ(b·)|_{R₅} = χ ∈ X₃` factors through `ℤ[i]/3` and `25 ≡ 1 (mod 3)`, so `τ(b·) = χ` there and `α = θ − τ = 0`
on the layer. ∎ (C0's route used only the consequence `τ₃(u) = 0 ⟺ τ₃(iu) = 0`, since `iu ∈ uR₅`; see 2.4.)

### 2.2 Lemma J2 — the unit-vector ring is the stable-integral ring at every prime with no ramified stable place [hand, one mind]

**Statement.** Let `F` be a real number field and `p` a prime such that no `𝔓 ∈ S_p` is ramified in `L/F` (automatic for odd `p`). Then
`R_(p) = O′_(p)` (localisation at `ℤ ∖ pℤ`). Hence (i) `R/pR ≅ O′/pO′ ≅ ∏_{𝔓∈S_p} O_𝔓/pO_𝔓`, so every character of `R` killed by `p`
reads only `x mod pO_𝔓` at the finitely many `𝔓 ∈ S_p`; (ii) if `S_p = ∅` then `1/p ∈ R` (prime inversion's "if" half). If no stable
prime at all is ramified in `L/F`, `R = O′`.

*Proof.*
- (a) `R ⊆ O′`: for stable `𝔓` and `u ∈ U`, `v_𝔓(ū) = v_{𝔓̄}(u) = v_𝔓(u)` (conjugation carries `𝔓̄` to `𝔓`) and `v_𝔓(u) + v_𝔓(ū) = v_𝔓(1) = 0`, so `v_𝔓(u) = 0`.
- (b) **`cO′ ⊆ R` for an integer `c ≥ 1`.** `ℚR` is a finite-dimensional ℚ-subalgebra of the field `L`, hence a field; it contains `i` and,
  for `s ∈ F`, `u = (1+is)/(1−is) ∈ U` and `s = (u−1)/(i(u+1))`, so `ℚR = L`. Choose a ℚ-basis `u₁, …, u_{2n}` of `L` in `U` and integers
  `m_j` with `m_ju_j ∈ O_L`; `O″ = ℤ[m₁u₁, …] ⊆ R ∩ O_L` is an order, so `cO_L ⊆ O″ ⊆ R` with `c = [O_L : O″]`. For a non-stable prime `𝔔`
  with `𝔔^h = (π)` (`h` the class number), `u_𝔔 = π̄/π ∈ U`, and since `(π^k)` and `(π̄^k)` are coprime, `π^{−k}O_L = O_L + u_𝔔^kO_L`. An
  `x ∈ O′` has poles only at non-stable primes `𝔔₁, …, 𝔔_r`, so `x ∈ O_L[1/π₁, …, 1/π_r] ⊆ O_L[u_{𝔔₁}, …, u_{𝔔_r}]`, and
  `c·O_L[u_{𝔔₁}, …] ⊆ R` termwise (`c·a ∈ R` for `a ∈ O_L`, `u_𝔔 ∈ R`). So `cx ∈ R`.
- (c) **`R` is dense in `∏_{𝔓∈Σ} O_𝔓` for every finite set `Σ` of stable primes unramified in `L/F`.** The closure `Ā` is a closed (compact)
  subring containing the closure of `U`, which is `∏ T(F_𝔭)` by weak approximation for the rational torus `T` (Cayley's
  `s ↦ (1+is)/(1−is)`, `F` dense in `∏ F_𝔭`). *Idempotents:* take `t ∈ ∏T(F_𝔭)` with `t_{𝔓₁} ≡ ζ ≠ 1` and `t_𝔓 = 1` elsewhere;
  `(t−1)^{(q₁²−1)q₁^{2n}} → e₁`. *Each factor:* `π₁(Ā)` is a closed subring of `O_{𝔓₁}` whose residue image contains `μ_{q+1}`, which
  generates `𝔽_{q²}` (it is not inside `𝔽_q`), so it holds every Teichmüller representative (`lim x^{q^{2n}}`); it holds an element of
  valuation 1 (`t = z/z̄`, `z = 1 + ϖω`, `ω` a Teichmüller unit with `ω ≠ ω̄ mod 𝔓`, `ϖ` a uniformizer of `F_𝔭`: `t − 1 = ϖ(ω − ω̄)/z̄`;
  at odd `𝔓` also `t = (1+iϖ)/(1−iϖ)`), so it is `O_{𝔓₁}` (`Σ [a_j]ϖ^j`). Hence `Ā = ∏ e_jĀ = ∏ O_𝔓`.
- (d) Write `c = p^a c′`, `p ∤ c′`. Then `p^aO′_(p) = cO′_(p) ⊆ R_(p)` by (b), and `R → O′/p^aO′ ≅ ∏_{𝔓∈S_p} O_𝔓/p^a` is onto by (c), so
  `O′_(p) = R_(p) + p^aO′_(p) = R_(p)`. (i): `R/pR = R_(p)/pR_(p)`. (ii): `S_p = ∅` makes `p` a unit of `O′`, so `1/p ∈ O′_(p) = R_(p)`,
  `m/p ∈ R` with `p ∤ m`, hence `1/p ∈ R`. If no stable prime is ramified, `O′/R` is killed by `c` and is `p`-torsion-free for every
  `p | c`, so `R = O′`. ∎

**Relation to the record.** This is FS86-B1-LR (Lemma R) **without its hypothesis "`L/ℚ` Galois"**; its corrected scope's other half (no
ramified stable prime) is exactly (c)'s, and FS86-CL2 shows it is needed. The only uses of `[F : ℚ] < ∞` in this stage are here: the
class number in (b), `O_L` finitely generated in (b), and finitely many primes above `p` in (d).

### 2.3 Lemma J3 — independence of finitely many places [hand; standard]

For a finite set `Σ` of stable primes and `k ≥ 1`, `U → ∏_{𝔓∈Σ} T(O_𝔓)/(T ∩ (1 + 𝔓^k))` is onto (2.2 (c)'s weak approximation). ∎

### 2.4 The route C0 expected, and why it fails: Lemma K1 is FALSE at `q = 27` [tools exact; two representations]

C0's route: by J1, `Z = {u : τ₃(u) = 0}` satisfies `iZ = Z`; by J2 (at 3) and J3 this is a statement about `g = τ₃` as an `𝔽₃`-functional on
`∏ O_𝔓/3O_𝔓`: `g(t) = 0 ⟺ g(it) = 0` on `∏ T(O_𝔓)`. A sumset argument in `𝔽₃²` on `G(t) = (g(t), g(it))` (the orbits of `(x,y) ↦ (y,−x)`
are `{0}`, the axes `A`, the diagonals `D`; `A + w` meets `A` for every `w`, `D + D = 𝔽₃²`) puts `g` at one place, and a level-collapse
puts it at level 1 as `g(t) = Tr_{𝔽_{q²}/𝔽₃}(at)`; the condition becomes **K1**: *`M_a(t) = Tr_{𝔽_{q²}/𝔽₉}(at)` meets `μ₄` on
`μ_{q+1}`*. Counting gives `#{t : M_a(t) ∈ μ₄} = (4/9)[(q+1) − K(n) + 2K(−n)]`, `n = N(a)`, `K` the Kloosterman sum over `𝔽_q` (via
`Σ_{t∈μ_{q+1}} ψ(Tr(bt)) = −K(N(b))`, `N(1+i) = −1`), and Weil settles `q ≥ 243`. **At `q = 27` the bracket is `28 − K(1) + 2K(−1) =
28 − 8 − 20 = 0`: for the 28 values `a` with `N(a) = 1` — `a = 1` among them — `Tr_{𝔽₇₂₉/𝔽₉}(t)` avoids `μ₄` on all of `μ₂₈`.** So the
rotation-invariance of the zero set alone cannot exclude an `𝔽₂₇`-place: `g = Tr_{𝔽₇₂₉/𝔽₃}` at one place above 3 of `ℚ(α,√7)` passes it.
*Evidence:* `tools/crunch_j09_lemma_k.py` (output `data/fs91/j09/lemma-k-check.txt`: formula = brute force for all 728 `a` at 27, all 8
at 3, all 242 norm classes at 243; `S = −K` for every `b`; K1 false at 27 exactly on `N(a) = 1`, true at 243 (min count 80), false at 3
exactly on `N(a) = −1` — the four order-3 characters; three planted faults fire); decorrelated by PARI's `ffgen` on a different field
model (`data/fs91/j09/k1-pari.gp`: 28 failing `a`, all of norm 1). **C0's route is dead at the first instance.** What it misses is J1's
other half: the zero set of `τ₃` is also where `τ₂ = 1/2`.

### 2.5 Theorem J4 — no mixing: a three-colour character of a real number field is parity everywhere or additive mod 3 at one `𝔽₃`-prime [hand, one mind; Weil external]

**Statement.** Let `F` be a real number field with no stable dyadic prime ramified in `L/F`, and `θ ∈ Θ₃(R_F)`. Then `α = 0`, `τ₂ = 0`, and
`θ = τ₃` is an additive three-colouring: `θ(R) ⊆ (1/3)ℤ/ℤ`, `θ(U) ⊆ {1/3, 2/3}`; it reads residues at exactly one stable prime `𝔓` above 3,
whose residue field is `𝔽₉` (so `𝔭 = 𝔓 ∩ F` has residue field `𝔽₃`), as `θ(x) = Tr_{𝔽₉/𝔽₃}(a·(x mod 𝔓))/3` with `a ∈ (1+i)μ₄`.
Conversely each of these `4·N₃` characters (`N₃` = number of primes of `F` above 3 with residue field `𝔽₃`) lies in `Θ₃(R_F)`. So
**`Θ₃(R_F)` is exactly `4N₃` points** (and parity-type points occur only if a stable dyadic prime ramifies, when `F²` is bipartite, G56).

*Proof.*
1. *Localisation.* By J2, `τ₂` (killed by 2) reads only `x mod 2O_𝔓`, `𝔓 ∈ S₂` (and `τ₂ = 0` if `S₂ = ∅`: `1/2 ∈ R`); `τ₃` reads only
   `x mod 3O_𝔓`, `𝔓 ∈ S₃`. The two sets of places are disjoint.
2. *No mixing.* Let `V₃ = τ₃(U)` (symmetric: `τ₃(−u) = −τ₃(u)`). If `0 ∈ V₃` and `c ∈ V₃ ∖ {0}`, pick `u₀, u₁` with `τ₃(u₀) = 0`,
   `τ₃(u₁) = c`; J1 gives `τ₂(u₀) = 1/2`, `τ₂(u₁) = 0`. By J3 some `u ∈ U` agrees with `u₁` modulo 2 at `S₂` and with `u₀` modulo 3 at `S₃`;
   then `τ₂(u) = 0` and `τ₃(u) = 0`, against J1. So `V₃ = {0}` or `0 ∉ V₃`.
3. `V₃ = {0}`: every unit is P-type, `τ = 1/2` on `U`, and `x ↦ 2τ(x)` two-colours `F²`. Without a ramified stable dyadic prime this is
   impossible (G55: `χ(F²) = 2 ⟺ L(F) = 2`, and `L = 2` comes only from such a prime, G56) — so this case is the bipartite one.
4. `0 ∉ V₃`: every unit is O-type, so (J1) `α = 0` on every layer, hence on `R = Σ_b bR₅`; `τ₂ = 0` on `U`, hence on `R`; `θ = τ₃`.
5. *One place.* Write `τ₃ = Σ_{𝔓∈S₃} g_𝔓` (J2 (i)) with `V_𝔓 = g_𝔓(T(O_𝔓))` symmetric in `𝔽₃`; `0 ∉ ΣV_𝔓` (J3). A non-zero symmetric
   `V_𝔓` contains `±1`; `m ≥ 2` such sets sum to a set containing 0 (`1 − 1` in pairs, plus `1 + 1 + 1` if `m` is odd); so exactly one
   `g_𝔓 ≠ 0` on `T(O_𝔓)`, and it avoids 0 there.
6. *Level 1.* If `g = g_𝔓` has exact level `k ≥ 2` (`g(𝔓^k) = 0 ≠ g(𝔓^{k−1})`, possible only if 3 ramifies at `𝔭`), then `λ = g|_{𝔓^{k−1}/𝔓^k}`
   is a non-zero `𝔽₃`-functional on `𝔓^{k−1}/𝔓^k ≅ 𝔽_{q²}`; the lines `it₀ϖ^{k−1}𝔽_q`, `t₀ ∈ μ_{q+1}`, span it (the span of `μ_{q+1}` is an
   `𝔽_{q²}`-subspace), so `λ ≠ 0` on one of them, and `w_s = (1+is)/(1−is) ≡ 1 + 2is (mod 𝔓^k)` for `s ∈ 𝔭^{k−1}` gives
   `g(t₀w_s) = g(t₀) + λ(2it₀s)`, which runs over all of `𝔽₃` — it hits 0. So `k = 1`: `g(t) = Tr_{𝔽_{q²}/𝔽₃}(a t̄)`, `a ≠ 0`.
7. *`q = 3`.* `#{t ∈ μ_{q+1} : Tr(at) = 0} = (q + 1 − 2K(N(a)))/3 ≥ (q + 1 − 4√q)/3 > 0` for `q = 3^f ≥ 27` (Weil, `|K| ≤ 2√q`; exact at 27
   and 243 in the tool: minima 4 and 62). So `q = 3` (`f = 1`), and on `μ₄` the non-vanishing functionals `Tr(a·)` are exactly
   `a ∈ (1+i)μ₄` (the tool's `q = 3` row).
8. *Converse.* For `𝔓` with residue field `𝔽₉`, `x ↦ Tr_{𝔽₉/𝔽₃}(a x̄)/3` (`a ∈ (1+i)μ₄`) is a character of `R ⊆ O′` (reduction is a ring
   map on `O′`), and every `u ∈ U` reduces into `μ₄`, where it is non-zero: `θ(u) ∈ {1/3, 2/3}`. ∎

**What J4 uses:** FS81-T3, T4 (hence FS73-T22 is not needed here; it enters S1 only through FS81-T2), J1–J3, Weil's bound for
Kloosterman sums over `𝔽_{3^f}` (external; replaceable at `q = 27, 243` by the tool's exact counts), G55/G56 for step 3's reading only.
**Not used:** Lemma K1, the archimedean analysis, Lemma R's Galois hypothesis, any finite configuration.

**By-products.** (a) FS81-T6's open item — "whether every additive 3-colouring is Fischer's up to symmetry depends on `ℤ[U]/3ℤ[U]`, and is
**not settled**" (`plans/FS81-derivation.md` T6) — is settled: `ℤ[U]/3ℤ[U] ≅ ∏_{𝔓∈S₃} O_𝔓/3O_𝔓` (J2), and the additive three-colourings of
a real quadratic plane with `d ≡ 3, 7 (mod 12)` are the four per prime of residue field `𝔽₃` (one prime at `d ≡ 3 mod 12`, two conjugate
ones at `d ≡ 7`), one orbit under rotations by `μ₄` and the Galois flip — Fischer's, up to symmetry. (b) FS86-B1-LR holds without "`L/ℚ`
Galois" (J2).

### 2.6 Corollary — S1 for real number fields [hand, one mind]

**S1: for every real number field `F`, `χ(F²) ≤ 3 ⟹ L(F) ≤ 3`. TRUE.** If a stable dyadic prime ramifies in `L/F`, `L(F) = 2` (G56).
Otherwise `χ(F²) ≤ 3` gives `Θ₃(R_F) ≠ ∅` (FS81-T2), so `N₃ ≥ 1` (J4): a prime of `F` above 3 with residue field `𝔽₃`, stable, whose plane
`Γ₃` is three-chromatic, so `L(F) ≤ 3`. With the converse (row 52 / Theorem A at `𝔽₃`, and G55 at two colours): **`χ(F²) = 3` ⟺ `F²` is
not bipartite and `F` has a prime above 3 with residue field `𝔽₃`** — T7's "odd residue degree" sharpened to "residue degree 1".

**Hypotheses S1's proof uses:** `F ⊆ ℝ` (the plane; conjugation is `Gal(L/F)`); `[F : ℚ] < ∞` (J2 only: class number, finitely many primes
above `p`, `O_L` finitely generated); FS81-T2 (so FS73-T22 ⟹, hand, never kernel); FS81-T3, T4; Weil for `q = 3^f ≥ 27`; G55/G56 at two
colours; the residue bound at `𝔽₃` for the converse.

**Beyond number fields.**
- *Every algebraic `F ⊆ ℝ`*, reading `L(F)` through places (valuations) of `F` with finite residue field: TRUE by König's lemma. Write
  `F = ⋃ F_n` (number fields); `χ(F_n²) ≤ χ(F²) ≤ 3`, so each `F_n` has a *good* place (a prime above 3 with residue `𝔽₃`, or a stable dyadic
  prime ramified in `F_n(i)`); good places restrict to good places (a residue field inside `𝔽₃` is `𝔽₃`; a dyadic prime split in `F_n(i)`
  stays split above, and one unramified in `F_n(i)` stays unramified in the compositum), each level has finitely many, so a compatible chain
  exists: a place of `F` with residue field `𝔽₃`, or a ramified stable dyadic place — `L(F) ≤ 3` (Theorem A through the valuation ring,
  row 57's `colorable_unitDistance_induce_of_valuationSubring`).
- *`F = E(t₁, …, t_d)` purely transcendental over an algebraic `E ⊆ ℝ`*: `χ(F²) = χ(E²)` (`[Fischer1990]` Thm 6, G63), so `E` has a good
  place, and composing with `t_j ↦ 0` gives a (higher-rank) place of `F` with residue field `𝔽₃`. TRUE under the place reading.
- *Every other subfield of ℝ*: **GAP at two named steps** — (1) § Notation defines `L(F)` through primes, which a non-algebraic `F` does not
  have in the needed sense (a definition must be chosen: places with finite residue field, of any rank); (2) J2's finiteness (the proof's
  one use of `[F : ℚ] < ∞`) has no replacement for a finitely generated `F` that is not purely transcendental over an algebraic field —
  FS-39's gap (G63) in another costume.

## Stage 3 — SAVED

### 3.1 Verdicts

| statement | verdict | hypotheses the proof actually uses |
|---|---|---|
| **S1** — for every real number field `F`: `χ(F²) ≤ 3 ⟹ L(F) ≤ 3` | **TRUE** (§2.6), with the sharper form `χ(F²) = 3 ⟺ F²` non-bipartite and `F` has a prime above 3 **of residue field `𝔽₃`**; and `Θ₃(R_F)` is exactly `4N₃` additive characters when no stable dyadic prime ramifies (J4) | `[F : ℚ] < ∞` (only in J2); FS81-T2 (so FS73-T22 ⟹); FS81-T3, T4; Weil for `q = 3^f ≥ 27`; G56 (a ramified stable dyadic prime gives `L = 2`) |
| S1 on every **algebraic** `F ⊆ ℝ` | **TRUE**, `L` read through places (König's lemma over the number subfields) | as S1, plus row 57's valuation-subring colouring |
| S1 on `E(t₁,…,t_d)`, `E` algebraic | **TRUE** under the place reading (`[Fischer1990]` Thm 6 = G63, composite places) | as above |
| S1 on **every** subfield of ℝ | **GAP** at two named steps: (1) `L(F)` is defined by § Notation through primes, which a general transcendental `F` lacks — a place reading must be chosen; (2) J2's one use of finite degree has no replacement for finitely generated fields that are not purely transcendental over an algebraic field (FS-39's gap, G63) | — |
| **S2** — `χ(F²) = L(F)` whenever `L(F) ≤ 4`, every real number field | **TRUE** (§3.2) | S1/J4; G55 (`χ = 2 ⟺ L = 2`); row 52 and G56 for `χ ≤ L` (the residue bound at `𝔽₃`, at `𝔽₇` — `χ(Γ₇) = 4`, `[Moorhouse2010]` — and at the inert dyadic targets `U_Q`, `Q ≤ 32`, four-colourable at [tools] grade, FS-54); FS81-T2 |
| **S3** — `Θ₃(ℤ[U_F]) = ∅` for `F = ℚ(α, √7)`, `α³ = α + 1`, so `χ(F²) = 4` | **TRUE** (§3.3), two routes | J1, J2 at 3 (route B also J2 at 2), J3, Weil or the exact count at `q = 27`; PARI's prime decompositions (exact); FS81-T2; the residue bound at 7 |

**The falsifier did not appear, and cannot:** J4 leaves no room for a point of `Θ₃` in any real number field without an `𝔽₃`-prime
(or a ramified stable dyadic prime), so the conjecture's `L = 4` clause has no three-colour character counterexample anywhere.

### 3.2 S2

Let `F` be a real number field with `L(F) ≤ 4`; `χ(F²) ≤ L(F)` always (row 52 for odd targets, G56 for dyadic ones, Theorem A).
- `L = 2`: `χ ≥ 2` (the plane has edges), so `χ = 2`.
- `L = 3`: `χ ≠ 2` (G55: `χ = 2 ⟺ L = 2`), so `χ = 3`.
- `L = 4`: no target is three-colourable, so no stable dyadic prime ramifies (that target is 2-colourable) and no prime above 3 has residue
  field `𝔽₃` (`Γ₃`); by J4 `N₃ = 0` gives `Θ₃(R_F) = ∅`, so `χ ≥ 4` (FS81-T2's contrapositive). Hence `χ = 4`. ∎

So the conjecture's `L ≤ 4` clause, proved before for real quadratic fields and for fields containing √3 (G55, row 82), holds for every
real number field, and (under the place reading) for every algebraic subfield of ℝ.

### 3.3 S3 — `ℚ(α, √7)`, re-derived arithmetic and two routes

**Arithmetic** (PARI, exact; `data/fs91/j09/field-arithmetic.gp` and `.out`): `F` has degree 6, signature `[2, 2]`, discriminant
`2⁶·7³·23²`. Above 2: one prime of `F`, `e = 2, f = 3`, which **splits** in `L` (two primes) — so there is no stable dyadic prime
(`F_𝔭 ⊇ ℚ₂(√7) = ℚ₂(i)`, as `−7 ≡ 1 (mod 8)`). Above 3: two primes, `e = 1, f = 3`, each **inert** in `L` (`f = 6`): stable, residue field
`𝔽₇₂₉`, `q = 27`. Above 7: `(e, f) = (2, 1)`, inert in `L` (stable, residue `𝔽₄₉`, `q = 7`: usable), and `(2, 2)`, split in `L`. So
`L(F) = χ(Γ₇) = 4` (the only targets are `Γ₇`, `Γ₂₇` with `χ ≥ 6`, and planes at larger usable primes, all `≥ 4`; no `𝔽₃`-prime; no
dyadic target). The stub's arithmetic is confirmed except its phrase "the dyadic targets have `χ ≥ 4`": there is no dyadic target.

**Route A (J4).** No ramified stable dyadic prime and `N₃ = 0`, so `Θ₃(R_F) = ∅`.

**Route B (shorter at 2).** `S₂ = ∅` gives `1/2 ∈ R_F` (J2 (ii); prime inversion, G55), so `τ₂ = 0`; by J1 every unit is O-type
(`τ₂(u) = 0 ≠ 1/2`), so `θ = τ₃` is an additive colouring non-zero on `U` (J1: `α = 0`); by J2 at 3 and J4 steps 5–6 it is
`Tr_{𝔽₇₂₉/𝔽₃}(a·)` at one of the two primes above 3, non-zero on `μ₂₈`; but every such functional vanishes somewhere on `μ₂₈` (at least 4
zeros for every `a`, exact: `data/fs91/j09/lemma-k-check.txt` and `k1-pari.out`; also Weil, `28 > 4√27 = 20.8`). So `Θ₃(R_F) = ∅`.

**Hence** `χ(F²) ≥ 4` (FS81-T2), and `χ(F²) ≤ χ(Γ₇) = 4`: **`χ(ℚ(α, √7)²) = 4`**, the conjecture's prediction met, at `L = 4` in a field
with neither √3 nor a four-chromatic quadratic subfield (its quadratic subfield ℚ(√7) is three-chromatic).

**What C0's own route says about this field**, recorded because it is the instructive part: J1's rotation invariance alone does not
refute it — `g = Tr_{𝔽₇₂₉/𝔽₃}` at one place above 3 has an `i`-invariant zero set (§2.4). The refutation needs the parity half of J1, and at
this field the parity half is free because the 2-adic wall is broken.

### 3.4 C0 scored

| C0 line | outcome |
|---|---|
| S1 for number fields TRUE, 0.75 | **won** |
| S1 for algebraic fields TRUE, 0.65 | **won** |
| S1 for every subfield: a named GAP, 0.6 | **won** (two named steps) |
| S2 TRUE, 0.75 | **won** |
| S3 TRUE, 0.8 | **won** |
| a falsifier exists, 0.1 | did not occur; J4 excludes it for every real number field |
| the **route** C0 expected (rotation invariance + a character count), with risk (b) "the count at `q = 27`, where Weil's bound may be too weak" | **lost, at exactly the named risk**: the bracket is 0 at `q = 27`, and K1 is false there. The repair (J4's no-mixing) was not in C0. |

### 3.5 Proposed edits for the front-page lane (not made here; standing rule 7)

- `LEDGER.md`: a row for J2 + J4 + S1–S3 at [hand, one mind] until a second derivation is compared (J02's, stage 5); § B lines for J1–J4,
  J-K, J4-C, J4-A, J4-T6.
- `CLAUDE.md` Frontier items 10 and 14, Mission (2): the conjecture's L ≤ 4 clause for every real number field; G74's "residual three-colour
  case ... (FS-82)" and G61/G38's three-colour sentences; T7's "odd residue degree" becomes "residue field `𝔽₃`".
- `plans/FS81-derivation.md` T6: its open item settled (J4-T6). FS86-B1-LR's scope line: "`L/ℚ` Galois" is not needed (J2).
- The FS-82 stub: closed by J4 (its §Shape item 4 "the other side" answered: no point exists); its "dyadic targets have `χ ≥ 4`" corrected.
- FS-48's three-colour half (multiquadratic fields without √3) is decided by J4: `χ = 3` iff a prime above 3 of residue field `𝔽₃`.
- FS-75 (the kernel): J4 is a better kernel target than the per-field route — its inputs are FS81-T3/T4, J2 and one character-sum bound.
- **Prior-art debt:** no gate was run for J2 or J4 (a blind job); `[Johnson2000]`, `[Johnson2006]` stay unread; J4's statement in the
  literature's words ("every circular 3-colouring of the unit-distance graph over a real number field is a residue colouring at a prime of
  norm 3") should be searched before any claim of novelty.

## Stage 4 — SAVED

Read after stage 3's commit (011e1551): `data/fs91/j02/lemma-statements.md` (J02's claim list, statements only). J02's record, data and
tools were not opened for this stage.

### 4.1 Each J02 statement against this record

| J02 statement (quoted from `data/fs91/j02/lemma-statements.md`) | status here | how |
|---|---|---|
| **L1** "if `θ ∈ Θ₃(R_F)`, then `τ(x) := lim_k θ(25^{−k}x)` is a character of `R_F` with `6τ = 0` and `τ(U_F) ⊆ {1/3, 1/2, 2/3}`, so `τ ∈ Θ₃(R_F)`" | **TRUE; already established** | FS81-T4, as used in J1 (§2.1) |
| **L2 (a)** "`A_p = R/pR` is a finite `𝔽_p`-algebra with `dim A_p ≤ n`, and `c` induces a ring involution on it" — for **every** prime `p` | **TRUE; J2 covers only `p` with no ramified stable prime; the general case derived now** (4.2) | `R/pR ≅ Ā_p/pĀ_p`, `Ā_p` the closure of `R` in `∏_{S_p} O_𝔓` |
| **L2 (b)** "Every maximal ideal `𝔪 ∋ p` of `R` equals `R ∩ 𝔓` for a stable prime `𝔓 | p` of `L`, and `c(𝔪) = 𝔪`" | **TRUE; derived now** (4.2) | lying-over in the integral extension `Ā_p ⊆ ∏O_𝔓`; `c(R) = R` |
| **L2 (c)** unramified stable `𝔓`: "`k_𝔪 = κ_𝔓 = 𝔽_{q²}`, `c` acts as its non-trivial involution …, and `𝒩(k_𝔪) = μ_{q+1}`" | **TRUE; established** | J2 (c)'s density; `c` generates the decomposition group of an inert prime |
| **L2 (d)** ramified `𝔓`: "`c` acts trivially on `k_𝔪` and `𝒩(k_𝔪) = {1}`" | **TRUE; derived now** | `c` lies in the inertia group; `s² = 1` in characteristic 2 forces `s = 1` |
| **L3** the Teichmüller section `T_p = {a^{p^M}}` "is a `c`-stable subring … `T_p ≅ ∏_{𝔪 ∋ p} k_𝔪`"; "**Every `s ∈ 𝒩(T)` is the image of a unit vector `u ∈ U`.** In particular the image of `U` in `R/6R` contains the product set `𝒩(T₃) × 𝒩(T₂)`" | **TRUE; the second half is J3 in other words; the first derived now** (4.2) | `a ↦ a^{p^M}` is a ring endomorphism commuting with `c`, killing the nilradical and bijective on each `k_𝔪`; Teichmüller lifts `[ξ]` of `ξ ∈ μ_{q+1}` lie in `T(F_𝔭)`, and weak approximation (J3) |
| **L4 (a)** "For `q = 3^f`, `f` odd, an additive `λ : 𝔽_{q²} → (1/3)ℤ/ℤ` with `λ(t) ≠ 0` for every `t ∈ μ_{q+1}` exists iff `q = 3`" | **TRUE; established** | J4 step 7 (zero count `(q+1−2K)/3`, Weil; exact at 27 and 243) |
| **L4 (b)** "For `Q = 2^f`, no additive `λ : 𝔽_{Q²} → (1/2)ℤ/ℤ` equals 1/2 on all of `μ_{Q+1}`" | **TRUE; derived now, elementary** | `Σ_{t∈μ_{Q+1}} λ(t) = λ(Σt) = λ(0) = 0`, but `(Q+1)·(1/2) = 1/2` since `Q+1` is odd |
| **T1** "A character `τ` of `R_F` with `6τ = 0` and `τ(U_F) ⊆ [1/3, 2/3]` exists iff `F` has a stable prime above 3 whose residue field is `𝔽₃`, or a stable prime above 2 ramified in `F(i)/F`" | **TRUE**; ⟹ is J4 applied to `τ` when no stable dyadic prime ramifies (and trivially true when one does); ⟸ is J4 step 8 and the dyadic residue character | — |
| **T2 (= S1)** the five-way equivalence | **TRUE**; = §2.6's corollary with (3) added | (1)⟹(2) FS81-T2; (2)⟹(3) L1; (3)⟹(4) T1; (4)⟹(5) definition; (5)⟹(1) row 52, G56 |
| **C2** additive 3-colourings ⟺ a stable 3-prime of residue `𝔽₃`; additive 2-colourings ⟺ a ramified stable dyadic prime | **TRUE**; the first is J4's by-product (§2.5 (a)) with J2 at 3; the second derived now from L3 and L4 (b) (4.2) | — |
| **T3 (= S2)** | **TRUE**; = §3.2 | — |
| **C1 (= S3)** and its arithmetic | **TRUE**; arithmetic identical to `data/fs91/j09/field-arithmetic.out`, line for line | §3.3 |
| "Also stated": bipartite ⟹ a ramified stable dyadic prime, via the walk-parity character | **TRUE** (derived now: the walk-parity map is an additive `R → ℤ/2` with `U ↦ 1`, then C2's second half) | — |

**Nothing is refuted.** Every J02 statement is TRUE by a derivation independent of J02's proofs (which I have not read).

### 4.2 The derivations made now

- **L2 (a), (b) for every `p`.** Let `Ā` be the closure of `R` in `∏_{𝔓∈S_p} O_𝔓` (compact). By J2 (b) `p^aO′_(p) ⊆ R_(p)`, so `Ā ⊇
  p^a∏O_𝔓` and `Ā` is a `ℤ_p`-order of full rank. **Claim `R/pR ≅ Ā/pĀ`.** Onto: `R` is dense and `pĀ` is open. Kernel: if `x ∈ R ∩ pĀ`,
  `y = x/p` is integral at every stable prime (at `S_p` because `y ∈ Ā ⊆ ∏O_𝔓`), so `y ∈ O′_(p)`; choose `r ∈ R` with `r ≡ y` modulo
  `p^a∏O_𝔓` (density; `p^a∏O_𝔓 ⊆ Ā` is open); then `(y − r)/p^a ∈ O′_(p)`, so `y − r ∈ p^aO′_(p) ⊆ R_(p)`, `y ∈ R_(p)`, `mx ∈ pR` with
  `p ∤ m`, and `x ∈ pR`. Hence `dim A_p = Σ_{𝔓∈S_p}[L_𝔓 : ℚ_p] ≤ n`. Maximal ideals of `Ā/pĀ` lie under maximal ideals of `∏O_𝔓`
  (integrality, lying-over), so each is `R ∩ 𝔓`; `c(R ∩ 𝔓) = R ∩ c(𝔓) = R ∩ 𝔓`. This extends J2 to ramified stable primes: `R/pR` is
  always the reduction of the closure, which is `∏ O_𝔓/p` exactly when no stable prime above `p` ramifies (FS86-CL2's `𝔽₂`-diagonal shows
  the difference).
- **L2 (d).** At a ramified stable `𝔓`, `c` generates the inertia group of `𝔓` in `L/F`, so acts trivially on `κ_𝔓 ⊇ k_𝔪`; then
  `s·c(s) = s² = 1` gives `s = 1`.
- **L3, first half.** In a finite commutative `𝔽_p`-algebra, `φ = Frob^M` is a ring endomorphism commuting with `c`; it kills the
  nilradical once `p^M` exceeds its index, and is bijective on each residue field `k_𝔪` once `[k_𝔪 : 𝔽_p] | M`; its image is a subring
  mapping isomorphically onto `∏ k_𝔪`.
- **L4 (b).** Above.
- **C2, second half, ⟹.** A homomorphism `λ : R → ℤ/2` with `λ(U) = 1`: if `S₂ = ∅`, `1/2 ∈ R` (J2 (ii)) and `λ = 0`. If every `𝔓 ∈ S₂` is
  unramified, `λ` on `𝒩(T₂) = ∏ μ_{Q_𝔓+1}` (L3) is `Σ λ_𝔓` and is `1` on the whole product; varying one coordinate makes each `λ_𝔓` constant
  on `μ_{Q_𝔓+1}`, and L4 (b)'s sum makes that constant 0 — so the total is 0, not 1. Hence some stable dyadic prime ramifies.

### 4.3 Do J02's statements, as stated, imply S1–S3?

**Yes.** S1 is T2's (1) ⟹ (5), given the inputs J02 names (FS81-T2, T3, T4, row 52, Astra's Thm 2.1, Weil); S2 follows from T2 with the
residue upper bound (T3); S3 from T2's (2) ⟺ (4) with C1's arithmetic (no stable prime above 3 of residue `𝔽₃`, no ramified stable dyadic
prime). The chain T1 ⟸ L1, L3, L4 is complete as stated: T1's ⟹ needs only the **band values on the Teichmüller unit vectors of
`𝒩(T₃) × 𝒩(T₂)`**, and the independence of the two factors is exactly L3's product set. **One remark on economy, not a gap:** J02's route
needs no level collapse (it evaluates `τ` only on Teichmüller elements, which L3 realises by unit vectors), where this record's J4 step 6
proves the level collapse; and J02's T1 is stated for `τ` only, while this record's J4 classifies all of `Θ₃(R_F)` (`4N₃` points) — J02's
statements imply S1–S3 but not that classification.

## Stage 5 — SAVED: the divergence table against J02's record

Read after stage 4's commit: `plans/FS91-S0F-three-colours.md` (J02), §2.0–§2.10, §3.1–§3.2, headings of §4. **Are the two S1/S2
statements the same statement?** Yes: both are "for every real number field `F`, `χ(F²) ≤ 3 ⟹ L(F) ≤ 3`" and "`χ(F²) = L(F)` whenever
`L(F) ≤ 4`", with the same hypotheses — `[F : ℚ] < ∞`, no Galois condition, no condition at 2, no √3, non-bipartiteness not used — and
the ramified-dyadic case inside the statement (J02 as a disjunct of T2 (4); here disposed of first by G56). They differ in what else is
claimed and in route:

| # | kind | J02 (`plans/FS91-S0F-three-colours.md`) | J09 (this record) | resolution |
|---|---|---|---|---|
| 1 | **truth (small)** | §2.10: "a stable ramified dyadic prime [restricts] to a stable dyadic one that is ramified **or inert**", so the algebraic case is "**Not claimed**" | §2.6: a ramified stable dyadic prime restricts to a **ramified** one | J09's: if the prime below were inert (unramified) in `F_n(i)`, the base change `F_{n+1,𝔭′}(i)/F_{n+1,𝔭′}` would be unramified; if split, `i` would lie in the completion above. So König applies cleanly and S1 holds on every algebraic `F ⊆ ℝ` under the place reading |
| 2 | scope | T1/T2: existence only ("additive and any coincide **for existence**"); "FS81-T6's additivity of every slope … left open here outside `d ≡ 3, 7 (mod 12)`" (§3.2 remark 2) | J4: **every** point of `Θ₃(R_F)` is additive, `Θ₃` is exactly `4N₃` points (no ramified stable dyadic prime); FS81-T6's open item settled (J4-T6) | not a conflict; J09 claims more, one mind |
| 3 | scope / route | the sketch's step 3 "`R/3R` = the product over stable 𝔭 \| 3" is "Lemma R(b), unproved outside `L/ℚ` Galois" — avoided by the Teichmüller section | J2 proves `R_(p) = O′_(p)` for every `p` with no ramified stable prime above it, **without the Galois hypothesis**; J2′ (= J02-L2) for every `p` | not a conflict; J09 closes what J02 routed around |
| 4 | route | no level collapse: `τ` evaluated on Teichmüller unit vectors only (L3) | level collapse proved (J4 step 6) | both valid; J02's is shorter |
| 5 | route | torsion part `τ` of one point, via L1, then T1 on `τ` | the P/O typing of **every** unit (J1) plus independence (J3); applied to `θ` itself | same core idea — the dyadic and 3-adic parts are independent (J02: the product set `𝒩(T₃) × 𝒩(T₂)`; J09: weak approximation on `S₂ ∪ S₃`) — reached independently |
| 6 | route (a failed one) | the advisor's sketch: GAPs at steps 2–5, repaired by T1's joint form (§2.9) | C0's own route (rotation invariance + character count): **K1 FALSE at `q = 27`** (§2.4) | both first routes failed where they ignored the parity half; different failures |
| 7 | inputs | GPT Astra's Lemma 1.1 and §3.1–3.3; Astra's Thm 2.1 re-derived (⟹) | not used; J2 derived from scratch (orders, class group, density); Astra's Thm 2.1 re-derived as C2's second half (§4.2) | independent inputs for the ring structure |
| 8 | where finite degree enters | L2(a) and Lemma 1.1 | J2 (class number; `O_L` finitely generated; finitely many primes above `p`) | same role |
| 9 | transcendental `F` | "S1 does not extend as a statement about `L(F)`"; G63 handles purely transcendental extensions; FS-39's gap | GAP at two named steps (definition of `L`; J2's finiteness), TRUE on `E(t₁,…,t_d)` under the place reading | the same substance; J09 states the purely transcendental case as a claim |
| 10 | S3 | arithmetic by PARI; `L(F) = 4`, `Θ₃ = ∅`, `χ = 4` | the same arithmetic line for line; two routes (J4; and route B through `1/2 ∈ R`) | agree |
| 11 | exact checks | `tools/crunch_j02_additive_check.py` at `q = 27, 243`, `Q ≤ 32` (not opened) | `tools/crunch_j09_lemma_k.py` at `q = 3, 27, 243` + PARI `ffgen` | agree on the zero-count claim (L4 (a)); J09 also records K1's failure, which J02 did not need |

**No divergence of truth on S1, S2 or S3.** The one divergence of truth is item 1 (a restriction claim J02 used to withhold the algebraic
case); J09's derivation of it is two lines and one mind. **Grade:** with J02's derivation and this one, independent and compared here,
S1–S3 meet row 82's standard, "two independent derivations"; J2 and J4's classification (items 2–3) remain **one mind**.

## Would-have-searched-here log

| # | the move I would have made by search | what I did instead |
|---|---|---|
| — | (stage 1: none) | — |
| 1 | a Θ₃ relation tree / float finder on a finite configuration of unit vectors of ℚ(α,√7), to look for a point or an EMPTY | derived J4, which decides `Θ₃` for every real number field with no configuration |
| 2 | a search over "all 𝔽₃-functionals" at level ≥ 2 for a ramified 3-adic counterexample | the level-collapse spanning argument (J4 step 6) |
| 3 | (at the edge, logged) complete exact enumeration of `𝔽₇₂₉^* × μ₂₈` (and the 242 norm classes at `q = 243`) — the finite set that Weil's bound left, fixed by the derivation before it ran; it found K1 false | it is the ban's edge case, allowed; recorded here and in the tool's docstring |

## Theorems this phase proved

- **J1** — typing on `τ₂`, `τ₃`: `τ₃(u) = 0 ⟺ τ₂(u) = 1/2`; `α = τ₂ = 0` on O-type layers. [derived from FS81-T3, T4] — §2.1.
- **J2** — `ℤ[U_F]_(p) = O′_(p)` for every real number field and every `p` with no ramified stable prime above it; `R/pR ≅ ∏_{S_p} O_𝔓/p`;
  `1/p ∈ R` if `S_p = ∅`; `R = O′` if no stable prime ramifies (FS86-B1-LR without "L/ℚ Galois"). [hand, one mind] — §2.2.
- **J3** — independence of finitely many stable places for `U_F`. [hand, standard] — §2.3.
- **J-K** — Lemma K1 is FALSE at `q = 27` exactly for `N(a) = 1` (e.g. `Tr_{𝔽₇₂₉/𝔽₉}(μ₂₈) ∩ μ₄ = ∅`); true at 243; false at 3 exactly for
  `N(a) = −1`; the count `(4/9)[(q+1) − K(n) + 2K(−n)]`. [tools exact; two representations] — §2.4, `tools/crunch_j09_lemma_k.py`,
  `data/fs91/j09/`.
- **J4** — no mixing: for a real number field with no ramified stable dyadic prime, `Θ₃(R_F)` is exactly the `4N₃` additive characters,
  one quadruple per prime above 3 of residue field `𝔽₃`. [hand, one mind; Weil external] — §2.5.
- **J4-C** — S1 for every real number field; `χ(F²) = 3 ⟺` non-bipartite and a prime above 3 of residue field `𝔽₃`. [hand, one mind] — §2.6.
- **J4-A** — S1 for every algebraic subfield of ℝ and every purely transcendental extension of one (places; König; G63). [hand, one mind] — §2.6.
- **J2′** — for every real number field and every prime `p`: `ℤ[U_F]/p ≅ Ā_p/pĀ_p`, `Ā_p` the closure in `∏_{S_p} O_𝔓`; finite of
  dimension `Σ_{S_p}[L_𝔓 : ℚ_p] ≤ [L : ℚ]`; maximal ideals `R ∩ 𝔓`, `𝔓` stable (= J02-L2 (a), (b), derived independently). [hand, one mind] — §4.2.
- **J-L4b** — for `Q = 2^f` no additive `λ : 𝔽_{Q²} → (1/2)ℤ/ℤ` is `1/2` on all of `μ_{Q+1}` (= J02-L4 (b)); hence an additive 2-colouring of
  a real number field's plane exists iff a stable dyadic prime ramifies (= J02-C2's second half). [hand, elementary] — §4.2.
- **J4-T6** — FS81-T6's open item settled: the additive 3-colourings of `ℚ(√d)`, `d ≡ 3, 7 (mod 12)`, are Fischer's up to symmetry. [hand, one mind, from J2, J4] — §2.5.
