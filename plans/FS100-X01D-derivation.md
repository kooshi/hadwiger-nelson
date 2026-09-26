# FS-100 ×2×3 crunch, job X01D — route (A): does Einsiedler–Fish transfer to `U` acting on `R̂`?

*de Bruijn (Opus 5.5), 2026-09-26, from the brief `data/crunch-2026-09-26-x2x3/briefs/X01D-einsiedler-fish-derivation.md` (with its two
addenda) and `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md`. The product owner is "main". A blind verifier, X01V, works the same
claims; no contact. Working files: `data/fs100/x01d/`. Exact checks: `tools/x01d_*.py`.*

## Theorems this phase proved

*(one line each, grade per `CLAUDE.md` § Notation; filled in as stages land)*

- (stage 1: none — reading and priors only)
- **EF-G (a) is false for non-totally-real F**: over ℚ(∛2) a non-torsion norm-one unit `u₀` has `H(u₀) = 1 < exp h_m(u₀)` — [hand + tools: `tools/x01d_unit_check.py`], §2.1
- **Haar entropy of `u ∈ U`**: `h_m(u) = Σ_v log⁺|u|_v` over all places of `L`; `= log H(u)` iff `u` is isometric at every archimedean place (always, when `F` is totally real) — [hand, cites the finite-S formula (Chothi–Everest–Ward)], §2.1
- **EF-G (b)**: `#U_N(F) ≥ c·N^{1/[F:ℚ]}` via `U_ℚ ⊆ U_F` — [hand], §2.1
- **EF-X**: the uniform measure on an archimedean circle is `U`-ergodic, zero-entropy for every `u`, non-atomic — [hand], §2.2
- **Lemma PF** (product-formula gap for `R^∨`) — [hand], §3.1
- **Lemma 3.1′** (one zero-entropy non-torsion `u*` ⟹ boxes thin at one expanding place `v*` carry mass `≥ δ^β` off a small set) — [hand], §3.3
- **Lemma 3.2′ / Steps 3–5** (pigeonhole with `U_ℚ` multipliers + product formula ⟹ `x̃_{v*} ∈ L` for `μ`-a.e. `x`) — [hand], §3.4–3.6
- **EF_F⁺** (one zero-entropy non-torsion `u` ⟹ `μ(R̂ ∖ (T + A)) = 0`, no ergodicity) and hence **EF_F** — [hand, one mind], §3.0–3.8
- **EF-MR** (PE-2 + EF_F ⟹ MR(F); over ℚ(√47) with SP-Cor, T-C(A) at `S = ∅` and the held `χ ≤ 5`: `χ = 5`) — [hand], §4.1
- **Corollary MR⟺PE**: for every real number field, MR(F) ⟺ PE-2(F), given R-U — [hand, one mind], §4.3

---

## Stage 1 — SAVED

### 1.1 The claims, copied verbatim (`plans/CRUNCH-2026-09-26-x2x3-queue.md` §2)

**Notation** (from `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`, verbatim): "`F ⊆ ℝ` a real number field, `L = F(i)`,
`U = U_F` the unit vectors (norm-one elements of `L/F`), `R = ℤ[U]`, `R̂` its dual; `T` the torsion characters, `A(R_F)` the archimedean ones,
`E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split places) — `LEDGER.md` rows 98, 113." Added here: `U` acts on
`R̂` by `(u·χ)(x) = χ(ux)`; `m` is Haar probability on `R̂`; `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`; for `u ∈ U`,
`H(u) = ∏_w max(1, |u|_w)` over the finite places `w` of `L` (normalised absolute values); `U_N = {u ∈ U : H(u) ≤ N}`.

**List X01:**

- **EF-G.** "For every real number field `F`: (a) `h_m(u) = log H(u)` for every `u ∈ U`; (b) `liminf_{N→∞} log #U_N / log N > 0`."
- **EF_F** [Poros's target, P-1]. "For every real number field `F`: every `U`-invariant, `U`-ergodic probability measure `μ` on `R̂` such that
  `h_μ(u) = 0` for some non-torsion `u ∈ U` satisfies `μ(E) = 1`."
- **EF-MR.** "PE-2 (list X02) and EF_F together imply MR(F) for every real number field `F`; over ℚ(√47), with SP-Cor and T-C(A) at `S = ∅`,
  they imply `χ(ℚ(√47)²) = 5`."
- **EF-X** (a control; the conclusion's shape). "Over `F = ℚ` there is a `U`-invariant, `U`-ergodic probability measure on `R̂` with
  `h_μ(u) = 0` for every `u ∈ U` that is not finitely supported; so EF_F's conclusion cannot be strengthened to finite support."

PE-2, quoted from list X02 of the same section, verbatim: "**PE-2** (PE-lim). "For every real number field `F` and every `U`-invariant finite
positive measure `τ` on `R̂`: `τ = a·m + τ′` with `a ≥ 0`, `τ′` a `U`-invariant finite positive measure, and `h_{τ′}(u) = 0` for every
`u ∈ U`.""

### 1.2 Quotation check (standing rule 5)

| # | quotation in the brief | source checked | result |
|---|---|---|---|
| Q1 | MR(F): "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure" | `plans/STUB-measure-rigidity-three-fields.md` line 58 | **verbatim** (the stub attributes it to J38 §3.5, T-J38-2 (iii)) |
| Q2 | list X01 (EF-G, EF_F, EF-MR, EF-X) and the notation paragraph | `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, lines 51–71 | **verbatim** (copied by `sed` into §1.1 above) |
| Q3 | SP-Cor, cited as `plans/FS84-SI-D-derivation.md` §4.2 | that file, lines 321–322: "Over ℚ(√47): if every finite positive `U`-invariant measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`." | agrees; **note** it gives `≥ 5`, so EF-MR's "`= 5`" also needs the upper bound `χ(ℚ(√47)²) ≤ 5` (row 84) — recorded for stage 4 |
| Q4 | "row 118: MR = its zero-entropy half plus an owed lemma PE-lim" | paraphrase in the brief, not in quotation marks | not checked as a quotation; `LEDGER.md` row 118 read at stage 4 |
| Q5 | EF's Lemmas 3.1, 3.2, as relayed from Poros | `data/crunch-2026-09-26-x2x3/poros/ef.txt` | **relayed, a message, logged as such.** Substance agrees with the paper: Lemma 3.1 is SMB ⟹ `μ(B_δ(x)) > δ^β` on a set of measure `> 1 − ε`; Lemma 3.2 is the pigeonhole with `M^{α/2}` images and the Diophantine step `x = k/(q₁−q₂) + κ`, `|κ| ≤ 2M^{−4}`, then stability across `M₁, M₁²`. EF's constants: `β = α/20`, `δ = M^{−5}`. |
| Q6 | Poros's sketch (a)–(c), addenda 1–2 | none (messages) | **relayed, unchecked**; written out or refuted in stages 2–3 |
| Q7 | EL2021 path `data/fs100/j51/el2021.pdf` | does not exist; the owner corrected it to `~/source/library/pdf/EinsiedlerLindenstrauss2022-…pdf` (commit 8e941a76) | path error in the brief, corrected by the owner |

### 1.3 The paper's main theorem, verbatim (Einsiedler–Fish, arXiv:0804.3586v2, ETDS 30 (2010) 151–157, Zbl 1189.37005)

> "**Theorem 1.2.** Let α > 0 and let Σ ⊂ N be a multiplicative semigroup with
> (1.1) lim inf_{N→∞} #(Σ ∩ [1, N]) / N^α > 0.
> Let µ be an ergodic Σ-invariant Borel probability measure on T = R/Z. Then either µ is supported on a finite number of points or µ is
> Lebesgue measure."

and the lemma that carries the zero-entropy half:

> "**Lemma 3.2.** Under the assumptions of Theorem 1.2, if hµ(Tp) = 0 for some p ∈ Σ, then the measure µ has finite support."

(The positive-entropy half is Johnson's theorem, their Thm 2.2; route (A) needs only Lemma 3.2's mechanism, since PE-2 is supposed to supply
the positive-entropy half.)

### 1.4 Reading status (G50)

| work | held at | read |
|---|---|---|
| `[EinsiedlerFish2010]` arXiv:0804.3586 | `data/crunch-2026-09-26-x2x3/poros/` (pdf + `ef.txt`) | **in full**, §§1–4 and references (2026-09-26, X01D) |
| H. Huang, *Fourier coefficients of ×p-invariant measures*, J. Mod. Dyn. 11 (2017) 551–562, Zbl 1402.37006, arXiv:1606.06078 | fetched to `data/fs100/x01d/huang2017-1606.06078.pdf` | §1 (pp. 1–3), Remark 5.4 and the reference list. **Circle only; a Fourier (Lyons-type) method, not EF's entropy route.** It records that EF's Thm 1.2 was found first by **E. A. Sataev, "On measures invariant with respect to polynomial semigroups of circle transformations", Uspehi Mat. Nauk 30 (1975) no. 2, 203–204** ("[Sat75, Thm. 1]") — not held, not read |
| H. Huang, H. Li, E. Shi, H. Xu, *Strongly independent matrices and rigidity of ×A-invariant measures on n-torus*, Front. Math. (Beijing) 18 (2023) 153–166, Zbl 1537.37013, arXiv:1908.02611 | fetched to `data/fs100/x01d/hlsx2023-1908.02611.pdf` | §1 (pp. 1–4: Thms 1.4–1.7, Cor. 1.8). **Tori `ℝⁿ/ℤⁿ` with integer matrices, by Huang's Fourier method; hypotheses are ×(Aʲ+Bᵢ)-invariance along density-one sets. Not the higher-dimensional EF, not S-adic, not solenoids.** |
| EL2021 `[EinsiedlerLindenstrauss2022]` | `~/source/library/pdf/…` | not re-read (FS-100's J51 read §1); not needed for route (A) |

`BIBLIOGRAPHY.md` greps (standing rule 11): no row for Einsiedler–Fish (0804.3586, 1189.37005), Huang 2017 (1402.37006), HLSX (1537.37013),
Sataev 1975; library holds none of them. **Proposed rows** are in stage 4's §4.x.

**Prior-art search for "EF on S-adic solenoids / number fields"** (zbMATH API, 2026-09-26): `ab:"polynomial growth" & ab:"invariant measure"`
(35 hits, none on multiplier semigroups of number fields); `ab:solenoid & ab:"invariant measures" & ab:semigroup` (1 hit, unrelated);
`ab:"polynomial growth" & ab:"invariant measure" & (ab:solenoid | ab:adelic | ab:"number field" | ab:"S-adic")` (0 hits);
`ab:"Einsiedler" & ab:"Fish"` (0 hits). **Negative, and it measures these words (G21).** The two citing works the brief named do not contain
an S-adic or number-field EF.

### 1.5 C0 — probabilities before the derivation

*Honest caveat: written after reading EF in full and the advisor's sketch, and after a first mental pass over the transfer — so these are
not blind priors.*

| claim | P(TRUE) | P(FALSE) | P(GAP) | the one fact that would move it |
|---|---|---|---|---|
| EF-G (as stated, "every real number field") | 0.15 | 0.80 | 0.05 | **(a) fails if `F` is not totally real**: then `L` is not CM, `U ∩ O_L^×` can have positive rank, `H(u) = 1` while `h_m(u) > 0` (archimedean expansion). If "real number field" meant totally real, (a) would be TRUE with ≈ 0.9. (b) TRUE ≈ 0.9. |
| EF_F | 0.65 | 0.05 | 0.30 | whether the pigeonhole survives multipliers that expand places other than the one the zero-entropy element thins (the planner's risk), and whether the product formula absorbs the height of `ℓ = v₁ − v₂` |
| EF-MR | 0.55 | 0.05 | 0.40 | inherits EF_F; the second half needs SP-Cor's `≥ 5` plus row 84's `≤ 5`, and T-C(A) at `S = ∅` |
| EF-X | 0.95 | 0.02 | 0.03 | the uniform measure on an archimedean circle — needs `A → R̂` injective and `U` dense in the circle |

### 1.6 Would-have-searched-here log

- (stage 1) none: nothing here invites a search; the prior-art sweep was reading and one zbMATH query set.

---

## Stage 2 — SAVED

### 2.0 Conventions used from here on (stated once)

- `L = F(i)`, `σ` the generator of `Gal(L/F)` (complex conjugation on `L ⊂ ℂ`, since `F ⊆ ℝ`); `U = {u ∈ L^× : uσ(u) = 1}`.
- `R = ℤ[U] = O′`, the ring of elements integral at every **stable** prime (row 100); so `R = O_L[1/𝔓 : 𝔓 ≠ σ𝔓]`, the split primes inverted.
- Normalised absolute values `|·|_v` on `L` (at a complex place `|x|_v = |x|²`); product formula `∏_v |x|_v = 1` for `x ∈ L^×`.
- `W = L_∞ × ∏′_{w split} L_w` (restricted product w.r.t. `O_w`). **Duality** (Tate; for S-integer rings Chothi–Everest–Ward 1997, and
  Lind–Ward 1988 for solenoids): `a ↦ (r ↦ ψ(ar))` induces `W / R^∨ ≅ R̂`, `R^∨ = {y ∈ L : ψ(yR) = 1}` a fractional `R`-ideal
  (`= 𝔡^{-1}R` up to the choice of `ψ`), discrete and cocompact in `W`, with `u·χ` ↔ multiplication by `u`. Stable places do **not** appear
  in `W` (they are integral in `R`, so their characters are killed). Under this identification `T = L/R^∨`, `A = image of L_∞`,
  `Fin_S = image of ∏_{w ∈ S} L_w`.

### 2.1 EF-G

**(a) FALSE as stated** — counterexample `F = ℚ(∛2)`. `L = ℚ(∛2, i)` is totally complex of degree 6 (unit rank 2); `F` has signature (1,1)
(unit rank 1). `N_{L/F} : O_L^× → O_F^×` has image containing `N(O_F^×) = (O_F^×)²` (rank 1), so its kernel `U ∩ O_L^×` has rank ≥ 1: there is
a **non-torsion** `u₀ ∈ U` that is a unit of `O_L`. Then `H(u₀) = 1` (unit at every finite place), while `h_m(u₀) > 0`: the inclusion
`O_L ⊂ R` gives a `u₀`-equivariant surjection `R̂ → Ô_L = L_∞/O_L^∨` (a 6-torus) carrying Haar to Haar, so `h_m(u₀) ≥ h_{Haar}(u₀ on the torus)
= Σ_{v|∞} log⁺|u₀|_v` (the toral-automorphism formula), which is `> 0` because a non-torsion algebraic integer unit has a conjugate of modulus
`> 1` (Kronecker). So `h_m(u₀) > 0 = log H(u₀)`. **Exact check:** `tools/x01d_unit_check.py` (PARI) finds `u = ε/σ(ε)` for both fundamental
units `ε` of `O_L`, verifies `uσ(u) = 1` exactly and that `u` is a unit (integral monic characteristic polynomial, constant term ±1), and reads
a conjugate of modulus 5.5724 (float, far from 1); **control**: over the totally real `ℚ(√2)` (where `L` is CM) the same pipeline finds no
non-torsion element (Kronecker); **plant**: `σ = id` makes every `u = 1` and the check reports the claim false — **caught** (run 2026-09-26,
exit 0 with `--plant`). *Also refutes the advisor's relayed "U ∩ O_L^× is torsion by Kronecker's theorem, because |u|_v = 1 at every
archimedean place of L": true exactly when `F` is totally real.*

**(a′) TRUE for totally real `F`** [hand; cites the finite-`S` entropy formula]. `L` is CM, so `|u|_v = 1` at every archimedean `v`. For `u ∈ U`
let `P₀` be the finitely many primes of `F` below the places where `|u|_w ≠ 1` (all split: `|u|_w² = |uσu|_w = 1` at a stable `w`). With
`R₀ = O_L[1/P₀] ⊆ R_n ↑ R` (adjoining the other split primes one at a time), `R̂ = lim← R̂_n`; each kernel of `R̂_n → R̂₀` is the dual of the
torsion group `R_n/R₀`, a compact totally disconnected group on which `u` is an isometry, so the fibre entropy is 0 and (Yuzvinskii's addition
formula, then the inverse limit) `h_m(u) = h(u on R̂₀) = Σ_{v ∈ ∞ ∪ P₀-places} log⁺|u|_v` (Chothi–Everest–Ward's `S`-integer formula) `= log H(u)`.
In general (any real `F`) the same argument gives **`h_m(u) = Σ_{all places v of L} log⁺|u|_v = log H(u) + Σ_{v|∞} log⁺|u|_v`**, the corrected
statement. **Consequence kept for EF_F:** every non-torsion `u ∈ U` has `h_m(u) > 0` (Kronecker plus the product formula) — the advisor's
first sentence stands, his reason does not outside the totally real case.

**(b) TRUE** [hand; the advisor's two-line proof, checked]. `ℚ ⊂ F`, so `U_ℚ = {u ∈ ℚ(i) : uū = 1} ⊆ U_F`. Since `F ⊆ ℝ`, `i ∉ F` and
`[L : ℚ(i)] = [F : ℚ] =: n`; for `x ∈ ℚ(i)` and a place `w₀` of `ℚ(i)`, `∏_{w|w₀} max(1,|x|_w) = max(1,|x|_{w₀})^n` (normalised absolute values,
`Σ_{w|w₀}[L_w : ℚ(i)_{w₀}] = n`), so `H_L(u) = H_{ℚ(i)}(u)^n`. Over `ℚ(i)`: `u = z/z̄` with `z = a + bi`, `gcd(a,b) = 1`, `a + b` odd; `z, z̄` are
coprime and `H(u) = ∏ p_j^{e_j} = a² + b²` (at `π̄_j` the valuation of `u` is `−e_j`). Distinct primitive triples give distinct `u`, and the
number of primitive Pythagorean triples with hypotenuse `≤ N` is `~ N/(2π)` (D. N. Lehmer, 1900). Hence `#U_N(F) ≥ #U_{N^{1/n}}(ℚ) ≥ c·N^{1/n}`
and `liminf log #U_N / log N ≥ 1/[F:ℚ] > 0`. *Caveat:* for `F` not totally real `U_1 ⊇ ⟨u₀⟩` is infinite, so `#U_N = ∞` for every `N ≥ 1`
and (b) holds only with `log ∞ = ∞` — the height `H` does not see archimedean expansion, which is (a)'s defect again. **For EF_F the multipliers
are taken from `U_ℚ`**, which are isometries at every archimedean place of `L` for every `F`, and whose count is (b)'s lower bound.

**Verdict EF-G: FALSE (at (a), counterexample ℚ(∛2)); (a) TRUE for totally real `F`; (b) TRUE (degenerate — infinite — when `F` is not
totally real).**

### 2.2 EF-X

**TRUE** [hand]. `F = ℚ`, `L = ℚ(i)`, `R = ℤ[i][1/p : p ≡ 1 (4)]`. For `a ∈ ℂ` put `ι(a) = (r ↦ e^{2πi·Tr_{ℂ/ℝ}(ar)}) ∈ R̂`. `ι` is a continuous
homomorphism, **injective** (if `r ↦ Tr(ar) mod 1` is trivial on `R`, which is dense in `ℂ` since `ℤ[1/5][i] ⊆ R`, it is trivial on `ℂ`, so
`a = 0`), and **equivariant**: `u·ι(a) = ι(ua)`. Its image is `A`. Let `λ_ρ = ι_*`(uniform probability on the circle `|a| = ρ`), `ρ > 0`.
- *Invariant:* every `u ∈ U` has `|u| = 1` in `ℂ`, so acts on the circle by a rotation.
- *Ergodic:* `u₁ = (3+4i)/5 ∈ U` is not a root of unity (the roots of unity of `ℚ(i)` are `±1, ±i`), so its rotation angle is an irrational
  multiple of `π`; the uniform measure is the unique `u₁`-invariant probability on the circle, hence `U`-ergodic.
- *Zero entropy for every `u`:* `ι` restricted to the compact circle is a homeomorphism onto its image, so `(R̂, λ_ρ, u)` is isomorphic to a
  circle rotation: `h = 0`.
- *Not finitely supported:* non-atomic.
And `λ_ρ(T + A) = 1`, so it is consistent with EF_F's conclusion and shows that conclusion cannot be "finite support". Over any real `F` the
same measure on a circle in the real place's copy of `ℂ` works.

**What a wrong-reason pass would look like** (the control's failure modes, named so the verifier can check they are absent): (i) `ρ = 0` —
a Dirac at the trivial character, finitely supported (the example must be non-atomic); (ii) a circle whose image in `R̂` collapses (`ι` not
injective), which would make the "non-atomic" claim false — excluded by density of `R` in `ℂ`; (iii) ergodicity claimed from a finite-index
subgroup or from density of `U` in `S¹` without a single irrational rotation (density suffices too, but the one-element argument is the checkable
one); (iv) zero entropy argued from "small support" rather than from an isomorphism with an isometry (small support alone proves nothing).
Also recorded: **the control does not test EF_F's direction** — it only shows the conclusion's shape must allow `A`.

### 2.3 Would-have-searched-here log

- EF-G (a): would have run a solver-free but exhaustive PARI hunt over many non-totally-real fields for norm-one units; instead derived the
  rank count and checked one field (ℚ(∛2)) with a control and a plant — seconds.

---

## Stage 3 — SAVED

### 3.0 Verdict first

**EF_F: TRUE** [hand, one mind; the transfer written out step by step below, every constant explicit]. In fact the derivation proves the
**stronger statement**, recorded separately beside EF_F (brief, addendum 1):

> **EF_F⁺.** For every real number field `F`: every `U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for **one**
> non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`. (No ergodicity; one element; the conclusion `T + A ⊆ E`.)

**The planner's named risk, answered.** The pigeonhole runs with multipliers that expand places other than the one `u*` thins. The zero-entropy
element is used once, to make boxes thin at **one** place `v*` where it expands (Lemma 3.1′). The multipliers `v ∈ U_ℚ` then act freely: their
expansion at other places is paid for by their height, polynomially in `M`, and the product formula trades that against the `M^{−K}` thinness
at `v*` (Steps 4–5). EF_F does **not** need weakening to "zero entropy for every `u`". The other places are then killed not by entropy but by
invariance: the wandering-shell recurrence (Step 7) — which is where the one-place conclusion becomes `T + A`.

### 3.1 The one lemma everything uses

`Λ := R^∨ ⊂ W` (§2.0), a fractional `R`-ideal; `C_Λ := ∏_{w stable} sup_{y∈Λ} |y|_w` (finite: `Λ = 𝔡^{-1}R` differs from `R` at finitely many
stable places; `C_R = 1`). `L` is totally complex (every embedding sends `i` off `ℝ`), so every archimedean place is complex, `|x|_v = |x|²`.

**Lemma PF (product-formula gap)** [hand]. For `y ∈ Λ ∖ {0}`: `∏_{v|∞} |y|_v · ∏_{w split} |y|_w ≥ 1/C_Λ`; for `y ∈ R ∖ {0}` the bound is `≥ 1`.
*Proof.* The product formula, with `∏_{w stable}|y|_w ≤ C_Λ` (resp. `≤ 1`). ∎

Also used: `W_{v} := {a ∈ W : a_v = 0}` meets `L` (hence `Λ`) only in `0`, for any single place `v` of `W` — an element of a field with a
zero component is `0`.

### 3.2 Step 0 — an expanding place

`u*` non-torsion ⟹ some place `v*` of `L` in `W` (a split finite place, or an archimedean one) has `|u*|_{v*} > 1`: otherwise `|u*|_v ≤ 1`
everywhere, so `= 1` everywhere by the product formula, and `u*` is an algebraic integer unit with all conjugates of modulus 1, a root of unity
(Kronecker). (A stable `w` has `|u|_w = 1` for every `u ∈ U`, so `v*` is split or archimedean.) Put `s := |u*|_{v*} > 1`. When `F` is totally
real, `v*` is split finite (L is CM).

### 3.3 Step 1–2 — Lemma 3.1′: zero entropy makes thin boxes heavy

Boxes: `Q(ε) := {a ∈ W : |a|_v < ε at every archimedean v (ordinary modulus), a_w ∈ O_w at every split w}`, open; and
`Q_{v*}(ε, δ) := {a ∈ Q(ε) : |a|_{v*} ≤ δ}`. `π : W → R̂ = W/Λ`.

**Lemma 3.1′** [hand; EF Lemma 3.1 transferred]. Fix `ε > 0` with `∏_{v|∞}(2ε(1 + |u*|_v^{1/2}))² · ∏_{w split} max(1,|u*|_w) < 1/C_Λ`
(ordinary moduli inside, normalised outside). For every `β > 0` and `η > 0` there are `δ₀ > 0` and a Borel `X′ ⊆ R̂` with `μ(X′) > μ(R̂) − η`
such that `μ(π(x̃ + Q_{v*}(2ε, δ))) ≥ δ^β` for every `x ∈ X′`, every lift `x̃`, and every `0 < δ ≤ δ₀`.

*Proof.* (i) *Partition.* `π(Q(ε))` is open and `R̂` compact, so finitely many translates `π(c_j + Q(ε))` cover `R̂`; let `ξ` be a Borel
partition with each cell inside one of them. (ii) *Bowen atoms are thin at `v*`* (local injectivity). Let `x, y` lie in one atom of
`ξ_n := ⋁_{i<n} u*^{−i}ξ`. Choose lifts `x̃, ỹ` in the `c_{j₀} + Q(ε)` of their common cell, `a₀ := ỹ − x̃ ∈ Q′ := Q(ε) − Q(ε)` (arch `< 2ε`,
integral at every split `w`). Induction on `i < n − 1`: if `u*^i a₀ ∈ Q′`, the points `u*^{i+1}x, u*^{i+1}y` share a cell `j`, whose lifts give
`b ∈ Q′` with `y′ := u*·u*^i a₀ − b ∈ Λ`. Bounds: ordinary `|y′|_v < 2ε(1 + |u*|_v^{1/2})` at archimedean `v`; `|y′|_w ≤ max(1,|u*|_w)` at split
`w` (ultrametric). By the choice of `ε` and Lemma PF, `y′ = 0`, so `u*^{i+1}a₀ = b ∈ Q′`. Hence the atom of `x` lies in
`π(x̃ + {a ∈ Q′ : u*^i a ∈ Q′ ∀ i < n}) ⊆ π(x̃ + Q_{v*}(2ε, c·s^{−(n−1)}))`, `c = 1` at a finite `v*`, `c = (2ε)²` at an archimedean one.
(iii) *SMB* (EF Thm 2.1, a countably generated σ-algebra, a finite partition): `(1/n)I_μ(ξ_n)(x) → h_{μ_x^E}(u*, ξ)` a.e.; `0 ≤
h_{μ_x^E}(u*, ξ) ≤ h_{μ_x^E}(u*)` and `∫ h_{μ_x^E}(u*) dμ = h_μ(u*) = 0` (Jacobs' integral formula), so the limit is `0` a.e. By Egorov there are
`X′` with `μ(X′) > μ(R̂) − η` and `N₀` with `μ(ξ_n(x)) ≥ e^{−nβ₁}` for `n ≥ N₀`, `x ∈ X′`. (iv) Given `δ ≤ δ₀ := c·s^{−N₀}`, take the least `n`
with `c·s^{−(n−1)} ≤ δ`; then `μ(π(x̃ + Q_{v*}(2ε, δ))) ≥ μ(ξ_n(x)) ≥ e^{−nβ₁} ≥ (δ/(cs))^{β₁/log s}`; choosing `β₁` small against `β`
(and `δ₀` smaller) gives `≥ δ^β`. The set does not depend on the lift. ∎

*Where the advisor's addendum 2 agrees:* "Along the two-sided refinement under u_p, the correction r ∈ R at each step is integral off S and
≤ 2η at ∞ … r = 0 at every step." Here the one-sided refinement suffices, because only the expanding place `v*` is needed.

### 3.4 Step 3 — Lemma 3.2′(a): the pigeonhole with free multipliers

Multipliers: `V_M := {v ∈ U_ℚ : H(v) ≤ M} ⊆ U`. Every `v ∈ U_ℚ ⊂ ℚ(i)` has modulus 1 at **every** archimedean place of `L`, for every real `F`
(each archimedean place of `L` restricts to the complex place of `ℚ(i)`). By §2.1 (b), `#V_M ≥ c₀M^α` for `M ≥ M₁`, `α = 1/[F:ℚ]`.

Fix `K := 16`, `β := α/(2K)`, `δ(M) := M^{−K}` (at a finite `v*`, read in the normalised absolute value; at an archimedean one in the
ordinary modulus), and `X′, δ₀` from Lemma 3.1′ for this `β` (any `η`). Let `M₂ ≥ M₁` with `δ(M₂) ≤ δ₀` and `c₀M₂^{α/2} > μ(R̂)`.

For `x ∈ X′`, a fixed lift `x̃`, `M ≥ M₂`, put `B := π(x̃ + Q_{v*}(2ε, δ(M)))`. Each `v ∈ V_M` is a `μ`-preserving automorphism of `R̂`, so
`μ(vB) = μ(B) ≥ δ(M)^β = M^{−α/2}`, and `Σ_{v∈V_M} μ(vB) ≥ c₀M^{α/2} > μ(R̂)`: two of the sets meet. So there are `v₁ ≠ v₂ ∈ V_M` and
`a₁, a₂ ∈ Q_{v*}(2ε, δ(M))` with `r := v₁(x̃ + a₁) − v₂(x̃ + a₂) ∈ Λ`. Put `ℓ := v₁ − v₂ ∈ R ∖ {0}` and `e := ℓx̃ − r = v₂a₂ − v₁a₁ ∈ W`.
With `m(w) := max(1, |v₁|_w, |v₂|_w)` (`∏_w m(w) ≤ H(v₁)H(v₂) ≤ M²`):

| place | `|e|` | `|ℓ|` |
|---|---|---|
| archimedean `v` (ordinary) | `< 4ε` (or `≤ 2δ(M)` at `v* `if archimedean) | `≤ 2` |
| `v*` finite (normalised) | `≤ M·δ(M)` | `≤ M` |
| split `w ≠ v*` | `≤ m(w)` (`a_i ∈ O_w`) | `≤ m(w)` |

**The planner's risk lives in the third row**: `e` is not small at `w ≠ v*` — each multiplier expands its own places — only bounded by the
multipliers' heights. EF has no such row.

### 3.5 Step 4 — two scales give one global point (the advisor's sketch (a), written out)

Run Step 3 at `M` and at `M²` (same `x`, same lift): `(ℓ₁, r₁, e₁)`, `(ℓ₂, r₂, e₂)`. Then
`z := ℓ₂r₁ − ℓ₁r₂ = ℓ₂(ℓ₁x̃ − e₁) − ℓ₁(ℓ₂x̃ − e₂) = ℓ₁e₂ − ℓ₂e₁ ∈ Λ` (an `R`-module); **`x̃` cancels exactly**. If `z ≠ 0`, Lemma PF gives
`∏_{v|∞}|z|_v ∏_{w}|z|_w ≥ 1/C_Λ`. Upper bounds: archimedean, ordinary `|z| < 16ε`, so the normalised product is `< (16ε)^{[L:ℚ]}`; at a finite
`v*`: `|z|_{v*} ≤ max(M·M²δ(M²), M²·Mδ(M)) ≤ M^{3−K}`; over split `w ≠ v*`: `∏|z|_w ≤ ∏_w m₁(w)m₂(w) ≤ M²·M⁴ = M⁶`. So
`∏ ≤ (16ε)^{[L:ℚ]}·M^{9−K} = (16ε)^{[L:ℚ]}·M^{−7} < 1/C_Λ` for `M` large (and `ε < 1/16`). (An archimedean `v*`: its factor is
`≤ (8δ(M))² ≤ 64M^{−32}` in place of `M^{3−K}`, and the rest is the same.) So **`z = 0`** and `t := r₁/ℓ₁ = r₂/ℓ₂ ∈ L`.

*No `|ℓ|_{v*}^{-1}` appears here*, as the advisor said; the division comes in Step 5 and is paid for by Lemma PF applied to `ℓ`.

### 3.6 Step 5 — the point is global at `v*`

`e_j = ℓ_j x̃ − r_j = ℓ_j(x̃ − t)` in `W` (componentwise; `t ∈ L` diagonal). Lemma PF for `ℓ_j ∈ R ∖ {0}`:
`|ℓ_j|_{v*} ≥ (∏_{v|∞, v≠v*}|ℓ_j|_v ∏_{w≠v*}|ℓ_j|_w)^{−1} ≥ 4^{−[L:ℚ]/2}·M_j^{−2}`. So, at a finite `v*`,
`|x̃ − t|_{v*} = |e_j|_{v*}/|ℓ_j|_{v*} ≤ 2^{[L:ℚ]}·M_j^{3−K}`. Iterate the scales `M, M², M⁴, …` with one choice `(ℓ, r)` per scale; each
consecutive pair gives `z = 0`, so all share **one** `t`. Letting `j → ∞`: **`(x̃ − t)_{v*} = 0`** (the same at an archimedean `v*`).

So every `x ∈ X′` lies in `T + K_{v*}`, `K_{v*} := π(W_{v*})`; as `η` was arbitrary, `μ(R̂ ∖ (T + K_{v*})) = 0`. **Borel:** `W_{v*}` is closed
in the σ-compact `W`, so `π(W_{v*})` is σ-compact, and `T = π(L)` is countable.

### 3.7 Step 6 — leaves

(i) `π` is injective on `W_{v*}` (`W_{v*} ∩ Λ = 0`), and the leaves `φ_t(W_{v*})`, `φ_t(a) := π(t + a)`, `t ∈ L/Λ`, are pairwise **disjoint**:
`t + a ≡ t′ + a′ (mod Λ)` forces `t − t′ − λ ∈ L ∩ W_{v*} = 0`. Each `φ_t` is a continuous injection of a Polish space, hence a Borel
isomorphism onto its (Borel) image (Lusin–Souslin). (ii) `L/Λ ≅ ⊕_{w stable} L_w/Λ_w` (strong approximation; `Λ` allows every split
denominator), and `U` acts there by units, so every `U`-orbit on `L/Λ` is **finite** and the stabiliser `U_t` has finite index. (iii) For
`u ∈ U_t`: `ut − t ∈ Λ`, so `u·φ_t(a) = π(ut + ua) = φ_t(ua)`, and `ν_t := (φ_t^{−1})_*(μ|_{φ_t(W_{v*})})` is a finite Borel measure on `W_{v*}`
invariant under `a ↦ ua` for `u ∈ U_t`. (`μ` restricted to the finite union of the leaves of one orbit is `U`-invariant.)

*The planner's measurability questions:* the lift is well defined and Borel (i); `K_{v*}` is Borel (σ-compact); the conclusion of Step 5 holds
for `μ`-almost every `x` from Lemma 3.1′ at the single element `u*`.

### 3.8 Step 7 — wandering shells kill every other place

For a split place `w ≠ v*` of `W`: `(γ) = 𝔓_w^h` (`h` the class number) gives `g := γ/σ(γ) ∈ U` with `|g|_w = N𝔓_w^{−h} ≠ 1` (`v_{σw}(γ) = 0`),
and some `g^k ∈ U_t`. The shells `A_j := {a ∈ W_{v*} : |a_w|_w = N𝔓_w^{j}}`, `j ∈ ℤ`, satisfy `g^k A_j = A_{j−hk}`, so `ν_t(A_j)` is periodic in
`j`; their sum `ν_t(a_w ≠ 0)` is finite; so every `ν_t(A_j) = 0` and `ν_t(a_w ≠ 0) = 0`. Over the countably many split `w`: `ν_t` is carried by
`W_{v*} ∩ L_∞`, i.e. by the archimedean coordinates. Hence `μ` is carried by `⋃_t π(t + L_∞) = T + A`. ∎ (EF_F⁺, hence EF_F, since
`T + A = T + A + Fin_∅ ⊆ E`.) The same shells argument at an archimedean coordinate on which some `u ∈ U` is not isometric (only when `F` is not
totally real) kills that coordinate too; not needed.

**Sanity check (the advisor's):** a finite `U`-invariant measure on one `Fin_S` leaf is carried by `T + A` by Step 7 alone — that is R-U, a
held result (SP-Cor's proof cites it), so EF_F⁺ agrees with it.

### 3.9 The risks (i)–(iii) of the relayed reading, scored

| risk | outcome |
|---|---|
| (i) "Lemma 3.1 applies to one u, and gives smallness only at S(u)" | **true, and enough**: one expanding place `v*` suffices; the rest is Step 7 |
| (ii) "ℓ = v1 − v2 can be w-adically tiny … a product of maxima over two approximations is not a product of products" | **handled**: Step 4 multiplies through (`z = ℓ₁e₂ − ℓ₂e₁`, no division); Step 5 divides by `|ℓ_j|_{v*}` once, bounded below by Lemma PF for the single element `ℓ_j` (`≥ 2^{−[L:ℚ]}M_j^{−2}`). No product over two approximations of maxima is needed |
| (iii) "the count #{v ∈ U : H(v) ≤ M} ≥ M^α … cite it rather than assume it" | **cited in its simplest form**: `U_ℚ ⊆ U_F` and Lehmer's Pythagorean count (§2.1 (b)); no torus point count is needed. Using `U_ℚ` also makes the multipliers archimedean isometries when `F` is not totally real, where the full `U_M` is infinite |
| advisor's (b): "S = {π, π̄} and u = u_p … hyperbolically, as (a, a^{-1})" | **simplified**: one place `v* = π̄` from Lemma 3.1′ (one-sided refinement), then one coordinate at a time in Step 7; the hyperbolic pair is not needed. His conclusion ("carried by T + A") is confirmed |
| advisor's constants "K > 6" | with my accounting `K > 9` (I keep `m(w)` rather than his local bounds); any fixed `K` works, so the discrepancy is bookkeeping |

### 3.10 Audit of the result I like (standing rule 4)

The result is the one the advisor predicted and the one that flatters the milestone, so each step was re-read looking for a failure:
- **Lemma PF at stable places** — `Λ = R^∨` is not integral at the different's stable primes; the constant `C_Λ` absorbs it (finite). Checked.
- **Totally complex `L`** — used to normalise archimedean factors as squares; true since `i ∉ ℝ`. Checked.
- **Is `v*` in `W`?** — yes: `|u|_w = 1` at stable `w` for every `u ∈ U`, so an expanding place is split or archimedean. Checked.
- **Different lifts at different scales** — one lift `x̃` is fixed for all scales; the atoms and boxes do not depend on it. Checked.
- **SMB's limit is the ergodic components' entropy, not `h_μ`** — handled by Jacobs' formula (zero integral of a nonnegative function). Checked.
- **Could the pigeonhole pair `v₁, v₂` give `ℓ` with `|ℓ|_{v*}` far below `M^{−2}`?** — impossible by Lemma PF: `ℓ ∈ R ∖ {0}` of height `≤ M²`.
- **Is `T + K_{v*}` really `μ`-conull, not just `X′`?** — `η` arbitrary, `X′` depends on `η` only. Checked.
- **Finite orbits on `L/Λ`** — `L/Λ` is a direct sum over stable places (split denominators are free in `Λ`), units act on each summand. Checked.
- **A counterexample would have to be:** a `U`-invariant measure with one zero-entropy non-torsion element and mass off `T + A`. The only
  candidates the project knows (EF-X's circles, the colourings' spectra at K and ℚ(√11), stage 4) are all on `T + A`. None found.
- **What this does not prove:** anything about positive entropy — PE-2 is untouched. Grade: [hand, one mind]; the blind verifier X01V has the
  claim list only.

### 3.11 Would-have-searched-here log

- None in stage 3: the transfer is a derivation; the only computation was bookkeeping of exponents, done by hand in §3.5–3.6.

---

## Stage 4 — SAVED

### 4.1 EF-MR

**First half — TRUE** [hand; a composition]. *Hypotheses used:* PE-2(F) exactly as quoted in §1.1, and EF_F (or EF_F⁺). Let `τ` be a
`U`-invariant finite positive measure with `τ(E) = 0`. PE-2 gives `τ = a·m + τ′`, `a ≥ 0`, `τ′` positive `U`-invariant with `h_{τ′}(u) = 0` for
every `u`. `U` contains the non-torsion `(3+4i)/5 ∈ U_ℚ`. *Via EF_F⁺ (no decomposition):* `τ′(R̂ ∖ (T + A)) = 0`. *Via EF_F as stated:* `U` is
countable, so `τ′/τ′(R̂)` has an ergodic decomposition `∫ μ_s dP(s)`; the `u`-ergodic decomposition of `τ′` is the integral of those of the
`μ_s`, so Jacobs' formula gives `0 = h_{τ′}(u) = ∫ h_{μ_s}(u) dP`, hence `h_{μ_s}(u) = 0` for `P`-a.e. `s`, and EF_F gives `μ_s(E) = 1`.
Either way `τ′` is carried by `E` (Borel: a countable union of σ-compact sets). But `τ′ ≤ τ` and `τ(E) = 0`, so `τ′ = 0` and `τ = a·m`: **MR(F)**.
(`m(E) = 0` is not needed.)

**Second half — TRUE, with one input the claim does not list** [hand; a composition]. Over ℚ(√47): MR (first half, given PE-2) and SP-Cor
(`plans/FS84-SI-D-derivation.md` §4.2, quoted in §1.2 Q3; given T-C(A) at `S = ∅`, i.e. R88-TCA, `plans/R88-derivation.md` line 161) give
`χ(ℚ(√47)²) ≥ 5`. **The equality also needs `χ(ℚ(√47)²) ≤ 5`**, which is not in the claim: it is the proven upper bound (`CLAUDE.md` § Where the
problem stands, item 10: "a proven 4 ≤ χ ≤ 5"), from the usable residue plane at 11 (Theorem A, row 52, and `χ(Γ₁₁) = 5`). With it:
`χ(ℚ(√47)²) = 5`.

**The named inputs of "χ(ℚ(√47)²) = 5 via route (A)"**, graded: PE-2(ℚ(√47)) — **open** (X02's claim); EF_F — this record, [hand, one mind];
SP-Cor — [hand]; T-C(A) at `S = ∅` over ℚ(√47) — [hand, two derivations blind to each other]; R-U (inside SP-Cor's proof) — held;
`χ ≤ 5` — held.

### 4.2 Control (c): the known four-colourings survive

MR must be consistent with the four-colourings that exist: over K (Theorem B) and over ℚ(√11) (row 94's C9). EF_F⁺ + PE-2 give MR at K and at
ℚ(√11) too (the derivation is uniform in `F`), so if the chain "MR ⟹ χ ≥ 5" ran there, a step would be wrong. It does not run, and it breaks
exactly where the advisor predicted:

| field | the known colourings' spectra | where SP-Cor's chain breaks | does anything here claim them Haar? |
|---|---|---|---|
| K = ℚ(√3,√11) | every four-colouring is, per coset, local at one dyadic place and `4R_K`-periodic (row 89): spectral measure carried by `T` | **T-C(A)**: K is outside R88-TCA's class — its stable dyadic place is Hoffman-tight at four colours, all-levels ratio exactly `1/4`, not `< 1/4`. Concretely `τ = σ_μ|_{R̂∖E} = 0` and `∫ Re χ(1) dτ = 0`, not `< 0`: A⁺ fails | **No.** `σ_μ(R̂ ∖ E) = 0`, MR returns `a = 0`; EF_F⁺ says zero-entropy measures lie on `T + A`, and these do |
| ℚ(√11) | C9's colouring `⌊4θ⌋`, `θ` = a torsion character at the stable prime above 7 plus an archimedean linear term: spectral measure on `ℤθ ⊆ T + A` (rotation-averaged: on `Uθ ⊆ T + A`) | **T-C(A)**: the stable place above 7 has level-one ratio `α(Γ₇)/49 = 14/49 = 2/7 > 1/4` (and the tower does not lower it), so ℚ(√11) is outside the class; again `τ = 0` | **No**, same reason |

So the control passes for the right reason: MR holds at both fields and is harmless there, because every known four-colouring's spectrum is
carried by `E` (in fact by `T + A`); SP-Cor's field-specific input T-C(A) is what fails. **What a wrong-reason pass would look like:** a
control that "passes" because EF_F⁺ was never applied at K (it applies uniformly), or because MR was checked only against Haar-like
spectra; or a derivation that makes some non-`T + A` spectrum at K zero-entropy and then declares it Haar. None occurs: the argument's only
conclusion about zero-entropy measures is `T + A`, which is exactly where these spectra live.

### 4.3 A corollary the route yields: MR is exactly PE-2

**Corollary MR⟺PE** [hand, one mind; given R-U]. For every real number field `F`: **MR(F) ⟺ PE-2(F).**
*Proof.* ⟸ is §4.1. ⟹: given `τ`, split `τ = τ|_{R̂∖E} + τ|_E` (both `U`-invariant, `E` being `U`-invariant). MR gives `τ|_{R̂∖E} = a·m`. By
R-U, `τ|_E` is carried by `T + A`; by Step 7's shells it is carried by `T + A_iso` (the archimedean coordinates on which all of `U` is isometric;
all of `L_∞` when `F` is totally real); on each finite orbit of leaves a power `u^k` fixes every leaf and acts on it as a norm-preserving
linear isometry, which preserves every closed ball, a compact metric space on which an isometry has zero entropy; so `h_{τ|_E}(u) = 0` for
every `u`, and `τ = a·m + τ|_E` is PE-2's decomposition. ∎
**What it means for FS-100:** row 118's "MR is its zero-entropy half plus an owed lemma PE-lim" becomes, given EF_F⁺, **"MR ⟺ PE-lim"**: the
zero-entropy half is closed by Einsiedler–Fish's mechanism, and the whole remaining difficulty is the positive-entropy decomposition PE-2
(route (B), X02). The honest statement of how hard MR is: exactly as hard as PE-2, and no harder.

### 4.4 Verdicts (one line each)

| claim | verdict | grade | where |
|---|---|---|---|
| EF-G | **FALSE** at (a): counterexample ℚ(∛2) (non-torsion norm-one unit, `H = 1`, `h_m > 0`); (a) TRUE for totally real `F`; (b) TRUE (infinite `#U_N` when `F` is not totally real) | [hand + tools] | §2.1 |
| EF_F | **TRUE**, with the stronger EF_F⁺ (one element, no ergodicity, conclusion `T + A`) | [hand, one mind] | §3 |
| EF-MR | **TRUE** as an implication; the second half also needs `χ(ℚ(√47)²) ≤ 5` (held, unlisted) | [hand] | §4.1 |
| EF-X | **TRUE** (archimedean circle measures) | [hand] | §2.2 |

C0 scored: EF-G predicted FALSE at 0.80 (won, for the predicted reason); EF_F predicted TRUE at 0.65 (won; the GAP mass sat on the planner's
risk, which dissolved at the product formula); EF-MR TRUE at 0.55 (won, with the unlisted upper bound found); EF-X TRUE at 0.95 (won).

### 4.5 Proposed edits (standing rule 7: I do not edit these files)

- **`LEDGER.md`, a row (draft for the close):** "Einsiedler–Fish transfers to the unit-vector group: over every real number field, a
  `U`-invariant finite measure on `R̂` with zero entropy for one non-torsion `u` is carried by `T + A` (EF_F⁺); so MR(F) ⟺ PE-2(F), and the
  zero-entropy half of row 118 is closed. EF-G (a) is false off the totally real fields (ℚ(∛2)). [hand, one mind; X01V blind on the claim
  list]" — `plans/FS100-X01D-derivation.md` §§3–4.
- **Row 118's text:** "MR is its zero-entropy half plus an owed lemma PE-lim" → "MR ⟺ PE-lim, given EF_F⁺ (the zero-entropy half, by
  Einsiedler–Fish's mechanism and the product formula)".
- **G76** (its "For colourings rigidity splits into invariant measures and transience" sentence) and **G79**: FS-100's route (A) is an
  example-invariant result? No — it is a structural (every-measure) statement found by transferring a known tool; record under G72's count as
  "extending a known tool", not as a structural-question result.
- **`BIBLIOGRAPHY.md` rows:**
  - `[EinsiedlerFish2010]` M. Einsiedler, A. Fish, *Rigidity of measures invariant under the action of a multiplicative semigroup of
    polynomial growth on T*, Ergodic Theory Dynam. Systems 30 (2010) 151–157, Zbl 1189.37005, arXiv:0804.3586 — FS-100 route (A): Lemmas 3.1–3.2
    transfer to `U` on `R̂` (EF_F⁺) — held `data/crunch-2026-09-26-x2x3/poros/` — **read in full** (X01D, 2026-09-26).
  - `[Huang2017]` H. Huang, *Fourier coefficients of ×p-invariant measures*, J. Mod. Dyn. 11 (2017) 551–562, Zbl 1402.37006, arXiv:1606.06078 —
    names Sataev 1975 as EF's precursor; circle only — held `data/fs100/x01d/` — read §1, Remark 5.4, references.
  - `[HuangLiShiXu2023]` H. Huang, H. Li, E. Shi, H. Xu, *Strongly independent matrices and rigidity of ×A-invariant measures on n-torus*,
    Front. Math. 18 (2023) 153–166, Zbl 1537.37013, arXiv:1908.02611 — tori, Fourier method; not an S-adic EF — held `data/fs100/x01d/` — read §1.
  - `[Sataev1975]` E. A. Sataev, *On measures invariant with respect to polynomial semigroups of circle transformations*, Uspekhi Mat. Nauk
    30 (1975) no. 2, 203–204 — EF's Thm 1.2 first (per Huang) — **not held, unread**.
  - Chothi–Everest–Ward 1997 (*S-integer dynamical systems: periodic points*, J. reine angew. Math. 489) and Lind–Ward 1988 (*Automorphisms
    of solenoids and p-adic entropy*, ETDS 8): **cited from memory for EF-G (a′) only — a prior-art debt**; nothing in EF_F rests on them.

### 4.6 Would-have-searched-here log (whole job)

- Stage 2: would have hunted norm-one units over many non-totally-real fields by PARI; instead derived the rank count and checked one field
  with a control and a plant.
- Stages 3–4: none; derivation only.
