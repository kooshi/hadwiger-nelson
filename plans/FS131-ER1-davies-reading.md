# FS131-ER1 — `[Davies2026]` read in full, and four rows placed against it

*Job record of FS131-ER1 (brief: `data/fs131/briefs/FS131-ER1-davies-reading.md`; a reading job, Ephodos). The paper: J. Davies,
*Measurable obstructions for unmeasurable colourings*, arXiv:2610.12301v1 (8 October 2026), 47 pp.; the copy read is
`~/source/library/pdf/Davies2026-measurable-obstructions-unmeasurable-colourings.pdf` (sha256 `58e7154a…a7af`, 47 pages by `pdfinfo`).
Page numbers below are the paper's printed page numbers, which are the PDF's. Mathematics is transcribed from the rendered pages into
Unicode; `(2.3)` and the like are the paper's equation numbers. The PDF is not committed. Working files: `data/fs131/er1/`.*

**Reading status, by section** (2026-10-13): pp. 1–37 (abstract, §§ 1–10, acknowledgements and the closing statement) read in full from
the rendered pages; pp. 38–41 (references) read as text; pp. 41–47 (Appendices A and B) read in full from the rendered pages, and the
proofs of Lemma B.1, Lemma B.2 and of the converse of Theorem 2.2 checked line by line (Stage 3). Proofs read but not re-derived: §§ 4–6
(the exponential-sum estimates and the two transference theorems), §§ 8–10. Not read: the computational supplement `[48]`, and the cited
works except where a stage says so.

## Theorems this phase proved

- **ER1-WEAK-TO-PROPER** — a weak measurable `k`-colouring of `ℝ^d` (Lebesgue measurable, proper at almost every pair at a distance in a
  finite `D`) gives a Lebesgue-measurable `k`-colouring proper at every such pair; so `χ_m⁰(ℝ²) = χ_m(ℝ²)`. **[hand]**, one mind, over
  `[Davies2026]` Lemma B.1 as printed (p. 44; its proof checked here) and the density-point step printed in
  `[DeCorteOliveiraVallentin2022]` (proof of Lemma 5.6). § M.
- **ER1-PLANE-FALCONER** — `χ(ℝ²) = χ_m(ℝ²)`, Falconer's number. **[derived]** from ER1-WEAK-TO-PROPER and the declared outside theorem
  `Outside.OAI158.proper_to_borel_weak`; one mind; in neither paper as far as each was read. § M.

Both are compositions of two outside results; neither is this project's mathematics beyond the composing. Nothing else was proved: this
is a reading.

## Stage 1 — SAVED: readback

**The brief's quotations, checked by script** (`data/fs131/er1/readback_check.py`; each block quote of the brief must occur character
for character in the file its source line names):

| quotation | source | result |
|---|---|---|
| W2, Kooshi's rule | `data/fs131/REQUEST-2026-10-13.md` | MATCH (278 chars) |
| the abstract | `data/fs131/pn1/arxiv-2026-10-13.md` | MATCH (1,871 chars) |
| row 121 | `LEDGER.md` | MATCH (2,603 chars) |
| row 123 | `LEDGER.md` | MATCH (4,115 chars) |
| row 128 | `LEDGER.md` | MATCH (3,620 chars) |
| row 129 | `LEDGER.md` | MATCH (3,661 chars) |
| the invention-signal line | `data/fs131/reports/FS131-PN1.md` | MATCH (388 chars) |
| the held line on FS-133 | `data/fs131/reports/FS131-PN1.md` | MATCH (281 chars) |

Eight of eight; with the planted fault (`--fault`: one character of each quotation altered) eight of eight read MISMATCH, so the check
can fire. The brief's unquoted facts, checked against the paper: version 1, 8 October 2026, 47 pages (p. 1 and `pdfinfo`); the sentence
"In the plane we suspect that a more complicated extension of ℚ² might be required" is on p. 5, as the asking lane quoted it; the
sentence with three residue classes modulo 168 and four citations is on p. 5; the release `[53]` is mentioned once, in the closing lines
of p. 37. No mismatch in the brief.

**One slip in the paper itself, met while checking the abstract.** The abstract (p. 1, and the arXiv listing) prints the upper bound as
`χ(ℝ^d) ≤ (3√3/4 + o(1))^d`; Theorem 1.5 (p. 4), the display after it and the end of its proof (p. 37) print `(3√3/2 + o(1))^d`, with
"3√3/2 = 2.5981…" (p. 4). `3√3/4 ≈ 1.299` is below the abstract's own lower base 2, so the abstract's constant is the slip; `3√3/4` is
the radius constant inside the proof ((10.2), p. 36). The theorem is the body's.

**The four rows, in my words.**

- **Row 121.** *Claims:* the unit-distance graph on `ℚ(√47)²` has chromatic number exactly 5 — at least 5 given measure rigidity at
  `ℚ(√47)` (row 120, this project's hand result over `[EinsiedlerLindenstrauss2022]`), at most 5 by reduction to the finite plane at 11
  (prior art; since the row was written, kernel-checked with no hypothesis); the same value at `ℚ(√143)`, `ℚ(√311)`, `ℚ(√335)`;
  `χ(ℚ(√167)²) ≥ 5`; and, by compactness, that some finite triangle-free unit-distance graph is five-chromatic. Grade [hand], every
  half two blind minds. *Does not claim:* an explicit graph; six anywhere; that it is first — only "not found in print".
- **Row 123.** *Claims:* for every real number field `F`, `χ(F²) ≥ min(L(F), 5)`, so `χ(F²) = L(F)` whenever the local bound `L(F)` is
  at most 5; and a finite rule for `L(F) ≥ 5` (no stable place with residue field `𝔽₃` or `𝔽₇`, none dyadic and inert of norm at most
  32, none dyadic and ramified in `F(i)/F`). Among real quadratic fields that is five at every squarefree `d ≡ 47, 143, 167 (mod 168)`
  with `L = 5`. Given MR; [hand]. *Does not claim:* anything above five where `L ≥ 6`; an explicit graph; a kernel proof.
- **Row 128.** *Claims:* given MR at `F`, for a totally real number field all of whose stable places mix at six colours
  (`λ*_v < 1/5`), `χ(F²) = χ(ℝ²)`; instances `ℚ(√635087)` and de Grey's field. Its load-bearing step needs no MR: a `k`-colouring of
  such an `F²` gives an invariant (CP) `k`-colouring of the real plane's unit-distance graph, or an SP witness, which MR excludes. Since
  `[OAIMath2026]`, the plane half (`χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)`) is theirs with no hypothesis; what is this project's is the field
  half. *Does not claim:* fields with a complex place; anything at six.
- **Row 129.** *Claims:* row 123's chain bounds one colour class at a time, so its five is `⌈1/α_loc(F)⌉` and can never be six; given
  MR(F), `α₁(F²) = max(m₁(ℝ²), sup_v r_v)`; and — the plane clause, with no MR, FS-133's C133-ONE — `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` and
  `χ_f(ℝ²) = 1/m₁(ℝ²)`, over `[OAIMath2026]`'s Theorem 2.3. The plane clause is [hand], one mind, kernel pending. *Does not claim:*
  any value of `m₁`; `m₁ = δ_Croft`; anything at six.

## Stage 2 — SAVED: the paper's statements, and its definitions beside ours

### 2.1 Definitions (pp. 2, 6)

- **Chromatic numbers.** p. 2: "Requiring the colour classes to be Lebesgue measurable gives the measurable chromatic number
  χ^(m)(ℝ^d)." and "For D ⊆ (0, ∞) and X ⊆ ℝ^d, write χ_D(X) for the chromatic number of the graph whose edges join points at distances
  in D, and write χ_D^(m)(ℝ^d) for its measurable chromatic number." So `χ^(m)` is a colouring **proper at every pair**, with
  **Lebesgue-measurable** classes.
- **Densities.** p. 2: "A set is D-avoiding if it contains no pair of points at a distance in D. Write m_D(ℝ^d) for the supremum of
  the upper densities of measurable D-avoiding sets, and ᾱ_D(X) for the infimum of the independence ratios of the nonempty finite
  induced distance graphs on X. We write m₁ and omit the subscript on ᾱ when D = {1}." p. 6: "For a graph G, χ(G) denotes its chromatic
  number, and ᾱ(G) is the infimum of the independence ratios of its nonempty finite induced subgraphs."
- **The free comparisons** (p. 6, (2.1) and the display after): `m_D(ℝ^d) ≤ ᾱ_D(ℝ^d)`, `χ_D^(m)(ℝ^d) ≥ 1/m_D(ℝ^d)`; "Restriction to
  ℚ^d also gives ᾱ_D(ℚ^d) ≥ ᾱ_D(ℝ^d) ≥ m_D(ℝ^d), χ_D(ℚ^d) ≤ χ_D(ℝ^d) ≤ χ_D^(m)(ℝ^d)."

**Beside this project's** (`CLAUDE.md` § The aim, links 1–2, lines 74–75; row 130; `data/fs103/claims.md` D-M):

| the paper's | this project's | verdict |
|---|---|---|
| `χ^(m)(ℝ^d)`: classes Lebesgue measurable, proper at every pair | `χ_m(ℝ²)`: "the least `k` with a Lebesgue-measurable proper `k`-colouring of `UD(ℝ²)` (proper at every edge)" (D-M) — Falconer's number | **the same number** at `d = 2` |
| — (no name; its hypothesis in Lemma B.1 is "measurable D-avoiding sets whose union is conull") | `χ_m⁰(ℝ²)`: "the least `k` with a Lebesgue-measurable `k`-colouring proper at almost every unit pair" (row 130); in the kernel `Plane.AeColouring`, `Plane.chiM0` | **the paper never uses the almost-everywhere number.** Its Lemma B.1 with one printed step shows the two numbers agree (§ M) |
| `ᾱ(X)`: infimum of independence ratios of finite induced subgraphs | `α₁(F²)`, the finitary independence ratio (row 129) | **the same** |
| `m₁(ℝ^d)`: supremum of upper densities of measurable 1-avoiding sets | `m₁(ℝ²)` (row 129) | **the same** |
| `χ(ℚ(√n)²)` | `χ(F²)` at `F = ℚ(√n)` | the same |

So the paper's main theorem read at `d = 2` would say `ᾱ(ℝ²) = m₁(ℝ²)` — which is row 129's plane clause — and `χ(ℝ²) = χ_m(ℝ²)`,
which row 130 lists under "Not claimed" ("the null-set step, a GAP in every record"). A difference of definition between `χ^(m)` and
`χ_m⁰` is therefore real on the page, and § M shows it is not a difference of number.

### 2.2 The theorems, conjecture and posed questions of the introduction (pp. 3–5), verbatim

- **Theorem 1.1** (p. 3). "Let D = {d₁, …, d_t} ⊂ (0, ∞) be finite and nonempty with d₁², …, d_t² ∈ ℚ. Then
  ᾱ_D(ℝ⁴) = m_D(ℝ⁴) and χ_D(ℝ⁴) = χ_D^(m)(ℝ⁴), furthermore, for d ⩾ 5, ᾱ_D(ℚ^d) = ᾱ_D(ℝ^d) = m_D(ℝ^d) and
  χ_D(ℚ^d) = χ_D(ℝ^d) = χ_D^(m)(ℝ^d)."
- p. 3, after it: "In particular, χ(ℚ²) = χ(ℚ³) = 2 and χ(ℚ⁴) = 4 [6, 72], so the restriction d ⩾ 5 in our rational-point conclusion
  is necessary. Our four-dimensional construction instead uses a quadratic extension; in the unit-distance case, there exists a positive
  nonsquare integer n such that χ(ℝ⁴) = χ(ℚ(√n)⁴). We remark that a conjecture of Bukh [11] suggests that some kind of extra algebraic
  condition on the multiple distances D as in Theorem 1.1 may be necessary."
- **Theorem 1.2** (p. 3). "For every d ⩾ 4, k ⩾ 1, and ϵ > 0, there exists a real R such that if D = {d₁, …, d_k} with
  d₂/d₁, …, d_k/d_{k−1} ⩾ R and d₁², …, d_k² ∈ ℚ, then ᾱ_D(ℝ^d) ⩽ (m₁(ℝ^d) + ϵ)^k, and in particular χ_D(ℝ^d) ⩾ (m₁(ℝ^d) + ϵ)^{−k}."
- **Theorem 1.3** (p. 3). "For every finite colouring of ℝ⁴, there exists R > 0 such that, for every r > 0 with r² ∈ ℚ and r² ⩾ R,
  there is a monochromatic pair of points at distance r."
- **Theorem 1.4** (p. 4). "m₁(ℝ^d) ⩽ (2 + o(1))^{−d} and therefore χ(ℝ^d) ⩾ (2 + o(1))^d."
- **Theorem 1.5** (p. 4). "χ(ℝ^d) ⩽ (3√3/2 + o(1))^d."
- p. 5: "We boldly conjecture that one of these two bases is tight and cowardly do not specify which one."
- **The passage on low dimensions and quadratic fields** (p. 5), whole: "We hope that it will be possible to extend our techniques to
  dimensions 2 and 3. Besides the obvious application to lower bounds, a particularly tempting aspect of Theorem 1.1 is for d ⩾ 5 it
  reduces the problem of colouring ℝ^d to that of colouring ℚ^d. This opens up the possibility of using arithmetic techniques to obtain
  improved upper bounds on χ(ℝ^d). For this reason, it would be particularly interesting to have such a proof that χ(ℚ^d) is finite,
  even if it does not improve the known bounds. Although we cannot reduce colouring ℝ^d to colouring ℚ^d for d = 2, 3, 4, there is still
  hope of reducing the problem colouring a simpler subset of ℝ^d. For instance, in the four dimensional case the proof of Theorem 1.1
  shows that there exists some positive integer n such that χ(ℝ⁴) = χ(ℚ(√n)⁴). We conjecture that this also holds in the three
  dimensional case. In the plane we suspect that a more complicated extension of ℚ² might be required. Nevertheless, the problem of
  determining the chromatic number of ℚ(√n)² has been well studied [32, 39, 49, 56]. In particular, it is known that ℚ(√n)² is
  four-colourable for n ≢ 47, 143, 167 (mod 168). It would be particularly interesting to determine if the remaining cases are
  six-colourable and if any of them contain a five chromatic unit distance graph. Given this new approach to improving both the upper
  and lower bounds for the Hadwiger-Nelson problem, we boldly conjecture the following."
- **Conjecture 1.6** (p. 5). "χ(ℝ²) = 6."
- The introduction's standing of the plane (p. 2): "5 ⩽ χ(ℝ²) ⩽ 7." The release `[53]` ("OpenAI, *The Euclidean plane is not
  five-colorable*, OpenAI Math preprint, September 2026, 23 September 2026", p. 40) is not used: its one mention is p. 37, "Due to the
  very recent release of [53] by OpenAI, we have posted this paper slightly earlier than we would have liked."

**What is posed, listed** (each with its kind): (i) Conjecture 1.6, `χ(ℝ²) = 6` — a conjecture; (ii) `χ(ℝ³) = χ(ℚ(√n)³)` for some `n` —
"We conjecture"; (iii) for the plane, "a more complicated extension of ℚ² might be required" — "we suspect", with no argument on any
page (Stage 3, § 3.4); (iv) whether `ℚ(√n)²`, `n ≡ 47, 143, 167 (mod 168)`, is six-colourable — posed as open; (v) whether any of those
planes contains a five-chromatic unit-distance graph — posed as open; (vi) an arithmetic proof that `χ(ℚ^d)` is finite — asked for;
(vii) which of the bases `2` and `3√3/2` is tight — conjectured, one of the two; (viii) the extension of Theorem 1.1 to `d = 3` and
`d = 2` — hoped (abstract, p. 1; p. 5); (ix) whether Lemma B.1 is in the literature — "We suspect that this is a folklore result, but
have not found it in the literature" (p. 44).

### 2.3 The certificate theorems (§ 2, pp. 6–8), verbatim

Notation (p. 6): `σ_d` normalized surface measure on `S^{d−1}`; `Ω_d(t) := ∫_{S^{d−1}} e^{2πitω₁} dσ_d(ω)` ("real and continuous,
Ω_d(0) = 1, |Ω_d(t)| ⩽ 1, and for d ⩾ 2, Ω_d(t) → 0 as t → ∞"); for a finite set `I`, `COP(I)` the copositive matrices,
`BQC*(I) := {Z symmetric : xᵀZx ⩾ 0 for every x ∈ {0,1}^I}` (so `COP(I) ⊆ BQC*(I)`), `J_I` the all-ones matrix, `⟨A, B⟩` the Frobenius
pairing, `CP(I)` the completely positive matrices.

- **Theorem 2.1** (p. 7; "DeCorte, de Oliveira Filho, Vallentin [24]"). "Let D = {d₁, …, d_t} ⊆ (0, ∞) be finite and nonempty and let
  d ⩾ 2. Suppose finite nonempty sets U₁, …, U_ℓ ⊆ ℝ^d, matrices Z_q ∈ BQC*(U_q), and real numbers z₀, a₁, …, a_t satisfy
  (2.2) z₀ + Σ_s a_s − Σ_q ⟨Z_q, J_{U_q}⟩ ⩾ 1,
  (2.3) z₀ − Σ_q tr(Z_q) + Σ_s a_s Ω_d(d_s τ) − Σ_q Σ_{u,v ∈ U_q, u ≠ v} Z_q(u, v) Ω_d(‖u − v‖τ) ⩾ 0 (τ ⩾ 0).
  Then m_D(ℝ^d) ⩽ z₀. Conversely, for every ε > 0 there is such a certificate in which U_q ⊆ ℚ^d, Z_q ∈ COP(U_q) ⊆ BQC*(U_q), and
  z₀ < m_D(ℝ^d) + ε." Footnote 1: "Their work does not quite prove the full finite-point converse stated below. Appendix A fills the
  small gap by replacing thick copositive constraints uniformly by finitely many rational point constraints, and includes the extension
  to finite D."
- With `A_Z := (1/k²) Σ_{u,v ∈ U} Σ_{i,j} Z_{ui,vj}` (2.4) and `S_Z(u, v) := (1/k²) Σ_{i,j} Z_{ui,vj}(kδ_ij − 1)` (2.5) for a symmetric
  `Z` indexed by `U × [k]`:
  **Theorem 2.2** (pp. 7–8). "Let D = {d₁, …, d_t} ⊆ (0, ∞) be finite and nonempty, let d ⩾ 2, and let k ⩾ 2. Suppose finite nonempty
  sets U₁, …, U_ℓ ⊆ ℝ^d, matrices Z_q ∈ BQC*(U_q × [k]), and real numbers z, a₁, …, a_t satisfy
  (2.6) z − (1/(k−1)) Σ_s a_s + Σ_q A_{Z_q} < 0,
  (2.7) z − Σ_q tr(S_{Z_q}) + Σ_s a_s Ω_d(d_s τ) − Σ_q Σ_{u,v ∈ U_q, u ≠ v} S_{Z_q}(u, v) Ω_d(‖u − v‖τ) ⩾ 0 (τ ⩾ 0).
  Then χ_D^(m)(ℝ^d) > k. Conversely, if χ_D^(m)(ℝ^d) > k, there is such a certificate in which U_q ⊆ ℚ^d and
  Z_q ∈ COP(U_q × [k]) ⊆ BQC*(U_q × [k])."
  p. 8: "Only the converse direction of Theorem 2.2 is used in this paper. We include the sufficient direction for motivation and do
  not give a proof of it here."

Both theorems are stated **for every `d ⩾ 2`**: the plane has these certificates too. Theorem 2.2 is new with this paper; its converse
is proved in Appendix B.

### 2.4 The lattice theorems (§ 3, pp. 8–13), verbatim

- **Theorem 3.3** (p. 9). "Let C ⊆ ℤ^r ∖ {0} be finite with C = −C. For 1 ⩽ q ⩽ ℓ, let U_q ⊆ ℤ^r be finite and nonempty and let
  Z_q ∈ BQC*(U_q). Suppose z₀ ∈ ℝ and real coefficients a_s = a_{−s} (s ∈ C) satisfy
  (3.1) z₀ + Σ_{s∈C} a_s − Σ_q ⟨Z_q, J_{U_q}⟩ ⩾ 1,
  (3.2) z₀ − Σ_q tr(Z_q) + Σ_{s∈C} a_s e^{2πis·θ} − Σ_q Σ_{u,v ∈ U_q, u ≠ v} Z_q(u, v) e^{2πi(v−u)·θ} ⩾ 0 (θ ∈ 𝕋^r).
  Then ᾱ(Cay(ℤ^r, C)) ⩽ z₀." (`ℓ = 0` is Theorem 3.1, "Davies [17]", "essentially a weighted Hoffman's ratio bound [27, 38] or Lovász
  theta bound [44] for Cayley graphs of ℤ^r".)
- **Lemma 3.4** (p. 11). "Let k ⩾ 2, let U be finite, let Z ∈ BQC*(U × [k]), and let c : U → [k] be arbitrary. Then
  A_Z + Σ_{u,v∈U} S_Z(u, v) ξ_{c(u)} · ξ_{c(v)} ⩾ 0." (`ξ₁, …, ξ_k` the unit vectors of a regular simplex, `ξ_i · ξ_j = (kδ_ij − 1)/(k − 1)`.)
- **Theorem 3.5** (p. 11). "Let C ⊆ ℤ^r ∖ {0} be finite with C = −C. Let k ⩾ 2. For 1 ⩽ q ⩽ ℓ, let U_q ⊆ ℤ^r be finite and nonempty
  and let Z_q ∈ BQC*(U_q × [k]). Suppose z ∈ ℝ and real coefficients a_s = a_{−s} (s ∈ C) satisfy
  (3.6) z − (1/(k−1)) Σ_{s∈C} a_s + Σ_q A_{Z_q} < 0,
  (3.7) z − Σ_q tr(S_{Z_q}) + Σ_{s∈C} a_s e^{2πis·θ} − Σ_q Σ_{u,v ∈ U_q, u ≠ v} S_{Z_q}(u, v) e^{2πi(v−u)·θ} ⩾ 0 (θ ∈ 𝕋^r).
  Then χ(Cay(ℤ^r, C)) > k."

### 2.5 The estimates and the two transference theorems (§§ 4–6, pp. 13–27), verbatim

`X_p := {x ∈ ℤ⁴ : ‖x‖² = p²}` for an odd prime `p` (`|X_p| = 8(1 + p + p²)`); `M_p(θ) := |X_p|⁻¹ Σ_{x∈X_p} e^{2πix·θ}`;
`𝕋^r[q] := q⁻¹ℤ^r/ℤ^r`; `ℜ^r_Q := ⋃_{1⩽q⩽Q} 𝕋^r[q]`; `L_y`, `R_y` the matrices of left and right multiplication by a quaternion `y`;
`𝒦_{p,a}(θ) := |X_p|⁻¹ Σ_{x∈X_p} e^{2πiθ·L_x a} = M_p(R_aᵀθ)`.

- **Theorem 4.1** (p. 13; "Magyar [45]"). "There is a constant C > 0 such that, for every integer λ ⩾ 1 and every θ ∈ 𝕋⁴,
  |Σ_{x∈ℤ⁴, ‖x‖²=λ} e^{2πix·θ}| ⩽ C(λ Σ_{q⩽√λ} q^{−11/8} ρ_λ(q)^{1/2} (1 + √λ dist(θ, 𝕋⁴[q]))^{−3/2} + λ^{7/8})." p. 13: "Having such an
  estimate is crucial to our arguments. We remark that the corresponding theorem for d ⩾ 5 was proven by Magyar, Stein and Wainger [46]."
- **Lemma 4.2** (p. 14): `lim_{Q→∞} limsup_{p→∞} A_p(Q) = 0`, where `A_p(Q) := sup{|M_p(θ)| : dist(θ, ℜ⁴_Q) ⩾ Q/p}`.
  **Lemma 4.3** (p. 14): "For every C > 0, lim_{p→∞} sup_{‖u‖⩽C} |M_p(u/p) − Ω₄(‖u‖)| = 0." ("just an application of Malyshev's [47]
  equidistribution theorem for points of ℤ⁴ on a 3-sphere".)
- **Lemma 4.4** (p. 15). "Let W ⊆ ℤ⁴ ∖ {0} be finite and let 0 < δ. There are C₀ > 0 and a positive integer Q₀ such that, for every
  sufficiently large odd prime p, every a ∈ W, and every θ ∈ 𝕋⁴ satisfying dist(θ, ℜ⁴_{Q₀} ∖ {0}) ⩾ C₀/p, we have
  |𝒦_{p,a}(θ) − Ω₄(p‖a‖ dist(θ, 0))| < δ."
- **Lemma 5.1** (p. 17). "Let Q, K be positive integers. There exist an irrational number ϑ > 0 with ϑ² ∈ ℤ, a positive integer κ, a
  number γ > 0, and integer pairs (r_j, s_j), 0 ⩽ j < K, such that C_j := κ⁻¹ [[r_j, −ϑs_j], [ϑs_j, r_j]] ∈ SO(2) (0 ⩽ j < K), and,
  writing q = Q!, for every ω = (ω₁, ω₂) ∈ 𝕋² at most two indices j satisfy dist(r_jω₁ + s_jω₂, 𝕋¹[q] ∖ {0}) < γ. Moreover, the
  parameters may be chosen so that, gcd(ϑ², q) = 1, (κ + r_j)/ϑ² ∈ ℤ (0 ⩽ j < K)." (In the proof, `ϑ := √(4q^{2K} − 1)`.)
- **Theorem 5.2** (p. 19). "Let W ⊆ ℤ⁴ ∖ {0} be finite, let c_∞ ∈ ℝ, and let c_w ∈ ℝ for w ∈ W. Suppose
  (5.4) F(τ) := c_∞ + Σ_{w∈W} c_w Ω₄(‖w‖τ) ⩾ 0 (τ ⩾ 0).
  Then for every ε > 0 there exist a positive nonsquare integer n, an injective homomorphism E : ℤ⁸ ⟶ ℚ(√n)⁴ ⊆ ℝ⁴, and a finite
  symmetric family 𝒢 of injective homomorphisms Γ : ℤ⁴ → ℤ⁸, such that ‖EΓw‖ = ‖w‖ (w ∈ ℤ⁴, Γ ∈ 𝒢), and
  (5.5) F_ε(θ) := c_∞ + ε + |𝒢|⁻¹ Σ_{Γ∈𝒢} Σ_{w∈W} c_w e^{2πiΓw·θ} > 0 (θ ∈ 𝕋⁸)."
- **Lemma 6.1** (p. 21). "Let d ⩾ 5, and let Q, K be positive integers. Then there exist an integer λ ⩾ 1, a number γ > 0, a finite
  index set Σ, and matrices B_σ ∈ M_d(ℤ) (σ ∈ Σ) such that B_σᵀB_σ = λ²I_d (σ ∈ Σ), and, for every θ ∈ 𝕋^d,
  (6.1) #{σ ∈ Σ : dist(B_σᵀθ, 𝕋^d[Q!] ∖ {0}) < γ} ⩽ (2d/K)|Σ|." p. 21, before it: "The condition d ⩾ 5 ensures that the quaternionic
  four-dimensional block has a nonzero orthogonal complement."
- **Lemma 6.2** (p. 23). "Let d ⩾ 5, let W ⊆ ℤ^d ∖ {0} be finite with Π(a) ≠ 0 for every a ∈ W, and let 0 < δ < 1. Then there exist
  positive integers J, h, Q₀, a constant C₀ > 0, and matrices R₁, …, R_J ∈ M_d(ℤ) satisfying R_jᵀR_j = h²I_d (1 ⩽ j ⩽ J), such that for
  every sufficiently large odd prime p, every a ∈ W, and every θ ∈ 𝕋^d with dist(θ, ℜ^d_{Q₀} ∖ {0}) ⩾ C₀/p, we have
  |𝒦̄_{p,a}(θ) − Ω_d(hp‖a‖ dist(θ, 0))| < δ, where 𝒦̄_{p,a}(θ) := J⁻¹ Σ_j 𝒦_{p,a}(R_jᵀθ)." (`Π` the projection onto the first four
  coordinates; `𝒦_{p,a}(θ) := |X_p|⁻¹ Σ_{x∈X_p} e^{2πiθ·S_x a}`, `S_x := L_x ⊕ pI_{d−4}`.) p. 23, before it: "Lemma 4.4 also does not
  generalize to general d ⩾ 5 due to its use of the integral quaternions ℍ_ℤ to transport all of a fixed W ⊆ ℤ⁴∖{0} (although it does
  work for d = 8 by instead using the integral octonions)."
- **Theorem 6.3** (p. 26). "Let d ⩾ 5, let W ⊆ ℤ^d ∖ {0} be finite, let c_∞ ∈ ℝ, and let c_w ∈ ℝ for w ∈ W. Suppose
  (6.6) F(τ) := c_∞ + Σ_{w∈W} c_w Ω_d(‖w‖τ) ⩾ 0 (τ ⩾ 0).
  Then for every ε > 0 there exists a positive integer m, an injective homomorphism E = m⁻¹I_d : ℤ^d ⟶ ℚ^d ⊆ ℝ^d and a finite symmetric
  family 𝒢 of injective homomorphisms Γ : ℤ^d → ℤ^d, such that ‖EΓw‖ = ‖w‖ (w ∈ ℤ^d, Γ ∈ 𝒢), and
  (6.7) F_ε(θ) := c_∞ + ε + |𝒢|⁻¹ Σ_{Γ∈𝒢} Σ_{w∈W} c_w e^{2πiΓw·θ} > 0 (θ ∈ 𝕋^d)."

### 2.6 The bounds (§§ 8–10, pp. 30–37), verbatim

- **Theorem 8.1** (p. 30). "Let H(s) be a finite real linear combination of the functions ∂_r^j Ω_d(rs/2π)|_{r=1}, j = 0, 1, 2, …,
  normalized by H(0) = 1. If H(s) ⩾ −B for all s ⩾ 0, where B > 0, then m₁(ℝ^d) ⩽ B/(1 + B), χ^(m)(ℝ^d) ⩾ ⌈1 + 1/B⌉."
  Lemmas 8.2 and 8.3 (pp. 32–33) place the zeros of `J_ν` and the free roots of a polynomial; they give Theorem 1.4 (p. 34).
- **Theorem 9.1** (p. 34). "For 5 ⩽ d ⩽ 24, the upper bounds for m₁(ℝ^d) and the lower bounds for χ^(m)(ℝ^d) are those in the new
  columns of Table 1. The same bounds hold for ᾱ(ℝ^d) and χ(ℝ^d), respectively." Lemma 9.2 (p. 34) is the explicit derivative family;
  the certificates are in the supplement `[48]`, verified by "A standalone Python 3 verifier" (p. 35) — not read here. Table 1 (p. 4)
  gives, among others, `χ(ℝ⁴) = χ^(m)(ℝ⁴) ⩾ 11` (transferring `[24]`'s bound), `χ(ℝ⁵) ⩾ 24`, `χ(ℝ¹⁰) ⩾ 729`, `χ(ℝ²⁴) ⩾ 10,515,016`.
- Theorem 1.5's proof (§ 10, pp. 35–37) is a random periodic union of trimmed balls; p. 35: "We remark that the resulting colouring is
  Borel."

### 2.7 The appendices' statements (pp. 41–47), verbatim

- **Lemma A.1** (p. 41; "DeCorte, de Oliveira Filho, Vallentin [24]"). "For every ε > 0 there are finitely many thick radial functions
  R₁, …, R_N and real numbers λ, a₁, …, a_t, with λ < m_D(ℝ^d) + ε, such that (A.2) λ + Σ_s a_s − Σ_q R_q(0) ⩾ 1, (A.3)
  λ + Σ_s a_s Ω_d(d_s τ) − Σ_q R_q(τ) ⩾ 0 (τ ⩾ 0)." (A *thick radial function* is `R_{U,Z,δ}(τ) := Σ_{u,v∈U} Z(u, v) ∫_{B_u}∫_{B_v}
  Ω_d(‖x − y‖τ) dy dx` for finite `U`, disjoint balls `B_u = B(u, δ)` and `Z ∈ COP(U)`.) Taken from `[24]` with the remark that "The
  proof of their Theorem 10.3 carries over verbatim to finite D" — an outside input for the density half, not re-proved in the paper.
- **Lemma A.2** (p. 42). "Let R₁, …, R_N be thick radial functions. For every η > 0 there are finite sets U₁, …, U_L ⊆ ℚ^d and matrices
  Z_ℓ ∈ COP(U_ℓ) such that ‖Σ_q R_q − Σ_ℓ P_{U_ℓ,Z_ℓ}‖_∞ < η, Σ_ℓ P_{U_ℓ,Z_ℓ}(0) = Σ_q R_q(0)."
- **Lemma B.1** (p. 44). "Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets whose union is conull. Then ℝ^d admits a
  measurable proper k-colouring of its D-distance graph." (Appendix B's standing hypotheses, p. 44: "Throughout, D = {d₁, …, d_t} ⊆
  (0, ∞) is finite and nonempty, d ⩾ 2, and k ⩾ 2." Before the lemma: "We first show that a measurable proper colouring of a conull set
  can, after changes on a null set, be extended to a measurable proper colouring of ℝ^d. We suspect that this is a folklore result, but
  have not found it in the literature.")
- **Lemma B.2** (p. 44). "Let h : [0, ∞) → ℝ be continuous with h(d_s) = −1/(k − 1) (1 ⩽ s ⩽ t), and put
  C_ij(x, y) := (1 + (kδ_ij − 1)h(‖x − y‖))/k². If C_U := (C_ij(x, y))_{(x,i),(y,j)∈U×[k]} ∈ CP(U × [k]) for every finite nonempty
  U ⊆ ℚ^d, then χ_D^(m)(ℝ^d) ⩽ k."

## § M — SAVED: mine, a section of its own — the paper's Lemma B.1 with the outside release's transfer gives `χ(ℝ²) = χ_m(ℝ²)`

*Marked as the brief asks: this section is **mine**, one mind, a combination of two outside results, checked by nobody else. It is
written as exact statements with numbered steps at the coordinator's request (message of 2026-10-13, mid-job), so that a claim list
can be fixed from it. Neither `[Davies2026]` nor — as far as `plans/EXT-OAI2-reading.md` records its reading — `[OAIMath2026]` states
the conclusion. It closes what this project holds as a GAP: row 130, "**Not claimed:** `χ(ℝ²) = χ_m(ℝ²)` (the null-set step, a GAP in
every record)"; `plans/FS103-derivation.md` FS103-M-D, "The null-set step (C-FMT (d), `χ_m⁰ = χ_m`) reduced, still a GAP".*

### M.0 The words, each with its source

| word | meaning | measurability | "proper" | source |
|---|---|---|---|---|
| proper `k`-colouring | `c : ℂ → Fin k` with `c x ≠ c y` whenever `‖x − y‖ = 1` | none asked | **every** unit pair | `Outside.OAI158.ProperColoring` (`Proofs/HadwigerNelson/Outside/OAI158.lean:70`) |
| weak `k`-colouring | `AEMeasurable c volume`, and `c p.1 ≠ c (p.1 + direction p.2)` for almost every `p` in `volume.prod angularMeasure` | **Lebesgue** (a.e. equal to a Borel map) | **almost every** unit pair | `Outside.OAI158.WeakColoring` (same file, line 95); `[OAIMath2026]` Def. 1.2 |
| `χ_m⁰(ℝ²)` | "the least `k` with a Lebesgue-measurable `k`-colouring proper at almost every unit pair" | Lebesgue | almost every | `LEDGER.md` row 130; kernel `Plane.chiM0` over `Plane.AeColouring` |
| `χ_m(ℝ²)` | "the least `k` with a Lebesgue-measurable proper `k`-colouring of `UD(ℝ²)` (proper at every edge)" — Falconer's number; the paper's `χ^(m)(ℝ²)` (p. 2) | Lebesgue | every | `data/fs103/claims.md` D-M; row 130 ("Falconer's `χ_m` (proper at every edge)") |
| `χ_B(ℝ²)` | "the least `k` with a Borel proper `k`-colouring" | **Borel** | every | `data/fs103/claims.md` D-M |
| the transfer | `axiom proper_to_borel_weak {k : ℕ} [NeZero k] {c : ℂ → Fin k} (hc : ProperColoring k c) : ∃ d : ℂ → Fin k, Measurable d ∧ WeakColoring k d` | **Borel** out (`Measurable d`) | every in, almost every out | `Proofs/HadwigerNelson/Outside/OAI158.lean:123–124`, a declared outside theorem |

Row 130's chain, as filed: "`χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`".

### M.1 The steps, numbered

1. **(T) The transfer** — outside, declared: a proper `k`-colouring of the plane gives a **Borel** `k`-colouring proper at **almost
   every** unit pair. Source: `Outside.OAI158.proper_to_borel_weak` (above); `[OAIMath2026]` family 158, Theorem 1.3's forward direction.
2. **(D) The density-point step** — printed: in a weak `k`-colouring `d`, put `A_i := {x : d(x) = i and x is a density-one point of
   d⁻¹(i)}`. Then the `A_i` are **Lebesgue** measurable (Borel when `d` is Borel), pairwise disjoint, their union is conull, `d = i` on
   `A_i`, and **no two points of one `A_i` are at distance 1** — every pair, not almost every. Source: `[Davies2026]` p. 46, the first
   paragraph ("We now follow the density-point argument in [24, proof of Lemma 5.6]. … If x, y ∈ A_i and v := y − x has length in D,
   both {z : f_i(p, z) > 0} and {z : f_i(p, z + v) > 0} have density one at x. Their intersection has positive measure near x, so
   Γ_i^p(v) > 0, a contradiction."), read with `f_i = 1_{d⁻¹(i)}`; the continuity it needs is p. 45's ("It is continuous because
   translations are continuous in L²(dx)"); the original, on a compact group, is `[DeCorteOliveiraVallentin2022]`, proof of Lemma 5.6
   (arXiv:1804.09099v4, pp. 22–23: "Let I be the set of density points in the support of f … Claim: I is independent."). This project
   held the same step as FS103-M-D (D1). Written out in M.2.
3. **(B) Lemma B.1** — printed, `[Davies2026]` p. 44: "Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets whose union is
   conull. Then ℝ^d admits a measurable proper k-colouring of its D-distance graph." In: **Lebesgue**-measurable sets, avoiding at
   **every** pair, covering almost everything. Out: a **Lebesgue**-measurable colouring (never Borel: the change on the null set is made
   by a compactness argument), proper at **every** pair; by its proof, equal to `i` on each `A_i` once the `A_i` are made disjoint and
   cut to their density-one points. Its proof is checked in M.3.
4. **(=)** Compose 2 and 3: a weak `k`-colouring gives a Lebesgue-measurable `k`-colouring proper at every unit pair and equal to it
   almost everywhere. With the trivial inequality (a colouring proper at every pair is proper at almost every pair): `χ_m⁰(ℝ²) =
   χ_m(ℝ²)`. No outside theorem is used beyond the lemma's own six lines.
5. **(HN)** Compose 1 and 4: a proper `k`-colouring gives a Lebesgue-measurable proper `k`-colouring; the other direction is trivial.
   So `χ(ℝ²) = χ_m(ℝ²)` — on the one declared outside theorem `proper_to_borel_weak`.

### M.2 Argument for ER1-DENS

Let `d : ℝ² → [k]` be Lebesgue measurable and proper at almost every unit pair, `C_i := d⁻¹(i)`, `ρ(x) := e^{−‖x‖²}`, and for `v ∈ ℝ²`
put `Γ_i(v) := ∫ ρ(x) ρ(x + v) 1_{C_i}(x) 1_{C_i}(x + v) dx ⩾ 0`. (a) `Γ_i` is continuous: `ρ1_{C_i} ∈ L²` and translation is continuous
in `L²`. (b) By Fubini and the weak condition, `∫_{S¹} Γ_i(ω) dσ(ω) = ∫∫ ρ(x) ρ(x + ω) 1[d(x) = d(x + ω) = i] dx dσ(ω) = 0`; a
continuous non-negative function with zero integral against a measure of full support vanishes, so `Γ_i(ω) = 0` for **every** unit
vector `ω`. (c) If `x, y ∈ A_i` and `v := y − x` is a unit vector, then `C_i` has density one at `x` and at `y = x + v`, so `C_i` and
`C_i − v` both have density one at `x`; their intersection has positive measure in every ball about `x`, the integrand of `Γ_i(v)` is
positive there, and `Γ_i(v) > 0`, against (b). (d) By Lebesgue's density theorem `C_i ∖ A_i` is null, so `⋃ A_i` is conull; the `A_i`
are disjoint because the `C_i` are; the set of density-one points of a measurable set is measurable. ∎ The same lines run in `ℝ^d` for
a finite set `D` of distances, one distance at a time.

### M.3 Argument for ER1-B1 (the paper's proof, checked)

The paper's proof (p. 44), step by step, with what I checked. (1) Replace `A_i` by `A_i ∖ ⋃_{j<i} A_j`: subsets of avoiding sets avoid,
and the union is unchanged. (2) Keep of each `A_i` only its density-one points: a null change (Lebesgue's density theorem), the sets
still avoid, their union `A` is still conull, and every point of the new `A_i` is a density-one point of it (the old and new sets
differ by a null set). Let `c : A → [k]` be `i` on `A_i`. (3) For a finite `F ⊆ ℝ^d` the set
`⋂_{x∈F∩A} (A_{c(x)} − x) ∩ ⋂_{x∈F∖A} (A − x)` has positive measure in every ball about 0: the first sets have density one at 0, finitely
many of them; the others are conull. For `ξ` in it, `F + ξ ⊆ A`, and `x ↦ c(x + ξ)` is a proper colouring of `F` — two points of `F` at
a distance in `D` with one colour `i` would give two points of `A_i` at that distance — agreeing with `c` on `F ∩ A`. (4) So every finite
`F` has a proper `k`-colouring agreeing with `c` on `F ∩ A`; the sets of maps `ℝ^d → [k]` proper on `F` and equal to `c` on `F ∩ A` are
closed in the product topology, non-empty, and directed downward, so by Tychonoff one map lies in all of them: a proper `k`-colouring
of `ℝ^d` equal to `c` on `A` (the paper cites de Bruijn–Erdős `[20]`; the precoloured form is `[Johnson1994choice]` p. 125's list
version, already in `BIBLIOGRAPHY.md`). (5) Its classes differ from the `A_i` inside the null set `ℝ^d ∖ A`, so they are Lebesgue
measurable. ∎ Every step holds as printed. **What the argument uses:** that the graph and the null sets are invariant under
translations, Lebesgue's density theorem, and compactness. It never uses that `D` is finite, that `d ⩾ 2`, or the Euclidean norm: it
proves the same sentence for every translation-invariant graph on `ℝ^d` (stated here as the reach of the argument, not derived as an
entry). **Where this project stopped:** FS103-M-D (D3) reduced the step to list-colouring every finite piece of the null boundary and
named "a finite non-list-colourable configuration inside `E`" as the possible obstruction; step (3)'s translation shows there is none —
any finite set can be slid into the good set with its good points keeping their colours.

### M.4 Argument for ER1-CERT's sufficient direction (Theorem 2.2's, which the paper states without proof)

p. 8: "We include the sufficient direction for motivation and do not give a proof of it here. A proof can be obtained by averaging the
simplex correlations of a measurable colouring over translations and rotations…". For a **weak** measurable `k`-colouring `c` of `ℝ^d`
and `R > 0` put `g := ξ_{c(·)} 1_{B_R}` and `φ_R(v) := |B_R|⁻¹ ∫ g(x) · g(x + v) dx`: continuous, positive definite, `φ_R(0) = 1`; so
by Bochner its average over directions is `φ̄_R(r) = ∫ Ω_d(rτ) dµ_R(τ)` for a probability measure `µ_R` on `[0, ∞)`. Almost-everywhere
properness gives `φ̄_R(d_s) = −(1/(k − 1))(1 − O(1/R))`. For a finite `U` and a rigid motion `ρ`, Lemma 3.4 applied to `c ∘ ρ` on `U`
(it asks nothing of `c`) and averaged over the translations in `B_R` and all rotations gives `A_Z + Σ_{u,v∈U} S_Z(u, v) φ̄_R(‖u − v‖) ⩾
−O(1/R)`. Integrating (2.7) against `µ_R` gives `z + Σ_s a_s φ̄_R(d_s) − Σ_q Σ_{u,v∈U_q} S_{Z_q}(u, v) φ̄_R(‖u − v‖) ⩾ 0` (the trace
terms are the `u = v` terms, `φ̄_R(0) = 1`). Adding: `z − (1/(k − 1)) Σ_s a_s + Σ_q A_{Z_q} ⩾ −O(1/R)`, and `R → ∞` contradicts (2.6). ∎
So a certificate excludes weak measurable `k`-colourings, not only everywhere-proper ones. One mind; the paper's own sketch goes
through a spectral measure of a limit, which this avoids.

### M.5 The entries

derivation: ER1-B1
  statement: Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets whose union is conull. Then ℝ^d admits a measurable proper k-colouring of its D-distance graph.
  uses only: that the D-distance graph and the Lebesgue null sets are translation invariant; Lebesgue's density theorem; the
    compactness principle for colourings with finitely many colours, in its precoloured form
  not claimed: a Borel colouring — the change on the null set is made by compactness and the classes are only Lebesgue
    measurable; anything without the axiom of choice; that the hypothesis holds for any particular k
  argument: § M.3 Argument for ER1-B1 (the paper's proof, checked)
  verdict: derived
  grade: hand
  minds: 1
  model: d = 2, D = {1}, k = 7 — the open hexagons of the classical seven-colouring of the plane, by colour: seven open
    1-avoiding sets whose union misses only the hexagons' boundaries
  prior art: known: [Davies2026] Lemma B.1, p. 44, statement and proof; the paper says of it "We suspect that this is a
    folklore result, but have not found it in the literature"
  handoff: de Bruijn — the statement at d = 2, D = {1}, with "measurable" read as Lebesgue (null-measurable classes) and "proper"
    as every unit pair; it is the one new lemma ER1-WEAK-TO-PROPER needs

derivation: ER1-DENS
  statement: in a Lebesgue-measurable k-colouring of the plane proper at almost every unit pair, the sets A_i of points of colour i that are density-one points of colour class i are Lebesgue measurable and pairwise disjoint, their union is conull, and no two points of one A_i are at distance 1
  uses only: continuity of translation in L²; Fubini; that the circle measure has full support on the circle; Lebesgue's
    density theorem
  not claimed: anything at a point outside the A_i; that the colouring is proper at every unit pair of the union — only inside
    one A_i is a unit pair excluded, which is all properness of the induced colouring asks
  argument: § M.2 Argument for ER1-DENS
  verdict: derived
  grade: hand
  minds: 1
  model: the classical hexagonal seven-colouring with every boundary point given colour 1 — measurable, proper at almost
    every unit pair, improper at unit pairs of boundary points; its A_i are the open hexagons of colour i
  prior art: known: [Davies2026] p. 46 (proof of Lemma B.2, last paragraph) with p. 45's continuity, after
    [DeCorteOliveiraVallentin2022], proof of Lemma 5.6 (arXiv:1804.09099v4 pp. 22–23); held here as FS103-M-D (D1)
  handoff: de Bruijn — the statement as written, for a weak colouring in the sense of Outside.OAI158.WeakColoring

derivation: ER1-WEAK-TO-PROPER
  statement: for every k ⩾ 1, a Lebesgue-measurable k-colouring of the plane proper at almost every unit pair agrees almost everywhere with a Lebesgue-measurable k-colouring of the plane proper at every unit pair; so χ_m⁰(ℝ²) = χ_m(ℝ²)
  uses only: ER1-DENS; ER1-B1, read with its proof's clause that the new colouring is i on each A_i; that a colouring proper
    at every unit pair is proper at almost every unit pair
  not claimed: a Borel colouring proper at every unit pair, so nothing about χ_B(ℝ²) against χ_m(ℝ²); any value of either
    number; the same in ZF without choice
  argument: § M.1 The steps, numbered
  verdict: derived
  grade: derived from: ER1-DENS, ER1-B1
  minds: 1
  model: the same boundary-miscoloured hexagonal seven-colouring: it is weak and not proper, and the classical assignment of
    boundary points is a measurable proper colouring equal to it off the boundaries
  prior art: partly: [Davies2026] Lemma B.1 (p. 44) with its p. 46 — the composition is not stated there, and the paper never
    names the almost-everywhere number; this project's gate for the question (FS103-G § 2.2) found neither inequality in print;
    a search under "measurable chromatic number" with "null set" is owed
  handoff: de Bruijn — the statement; with Plane.chiM0 it gives the equality with Falconer's number, which the library does
    not yet define

derivation: ER1-PLANE-FALCONER
  statement: for every k ⩾ 1, the plane has a k-colouring proper at every unit pair if and only if it has a Lebesgue-measurable k-colouring proper at every unit pair; so χ(ℝ²) = χ_m(ℝ²)
  uses only: the declared outside theorem Outside.OAI158.proper_to_borel_weak (a proper colouring gives a Borel weak one);
    ER1-WEAK-TO-PROPER
  not claimed: χ(ℝ²) = χ_B(ℝ²); any value — with [OAIMath2026] Theorem 1.4 the common value is 6 or 7; the equality in any
    other dimension, where no transfer is declared here ([Davies2026] Theorem 1.1 has it for d ⩾ 4); that either paper states it
  converse: § M.1 The steps, numbered
  argument: § M.1 The steps, numbered
  verdict: derived
  grade: derived from: ER1-WEAK-TO-PROPER
  minds: 1
  model: k = 7 — the hexagonal colouring is a Borel colouring proper at every unit pair, so both sides hold; k = 5 — both
    sides fail given the declared outside theorem Outside.OAI158.no_proper_five_coloring
  prior art: partly: [OAIMath2026] Theorem 1.3 is the equality with the almost-everywhere number, and [Davies2026] Theorem 1.1
    is this equality in dimensions at least four; the plane's is the case [Davies2026]'s abstract names as a hope ("or possibly
    even to d = 2"); not stated in either as far as each was read here; a search is owed
  handoff: de Bruijn — the statement; it rests on the standard three axioms and the one declared outside theorem

derivation: ER1-CERT
  statement: for every k ⩾ 2, χ(ℝ²) > k if and only if there are finite non-empty sets U₁, …, U_ℓ ⊆ ℚ², matrices Z_q ∈ COP(U_q × [k]) and real numbers z, a satisfying (2.6) and (2.7) of [Davies2026] Theorem 2.2 at d = 2, D = {1}
  uses only: ER1-PLANE-FALCONER; the converse of [Davies2026] Theorem 2.2 (Appendix B), whose proof was read and checked in
    Stage 3; for the other direction, § M.4, which the paper states and does not prove
  not claimed: that any such certificate is known at k = 5, where one exists given [OAIMath2026] Theorem 1.4, or at k = 6,
    where its existence is Hadwiger–Nelson; a bound on its size; that it can be found by a search
  converse: § M.4 Argument for ER1-CERT's sufficient direction (Theorem 2.2's, which the paper states without proof)
  argument: § M.1 The steps, numbered
  verdict: derived
  grade: derived from: ER1-PLANE-FALCONER
  minds: 1
  model: k = 3 — ℓ = 0, a = 1 and any z with 0.4028 ⩽ z < 1/2, where min J₀ ≈ −0.4028 (at the first positive zero of J₁) and
    Ω₂(t) = J₀(2πt): (2.7) reads z + J₀(2πτ) ⩾ 0 and (2.6) reads z − 1/2 < 0, the spectral bound χ_m(ℝ²) ⩾ 4; at k = 4 no
    certificate with ℓ = 0 exists (z < 1/3 against z ⩾ 0.4028), so the configurations are what a certificate above four needs
  prior art: partly: [Davies2026] Theorem 2.2 for the measurable number in every dimension at least two; its reading for
    χ(ℝ²) itself needs ER1-PLANE-FALCONER and is in neither paper
  handoff: none — a relay-result; whether the kernel wants it is the coordinator's to say once ER1-PLANE-FALCONER is planned

## Stage 3 — SAVED: the method, where the dimension enters, and what the dimension hypothesis is

### 3.1 The proof of Theorem 1.1 in outline (pp. 5–8, 28–30)

The inequalities `ᾱ_D(ℚ^d) ⩾ ᾱ_D(ℝ^d) ⩾ m_D(ℝ^d)` and `χ_D(ℚ^d) ⩽ χ_D(ℝ^d) ⩽ χ_D^(m)(ℝ^d)` are free (p. 6; `m_D ⩽ ᾱ_D` is credited to
Larman and Rogers, p. 28). The theorem is the reverse comparisons, in three moves.

1. **A measurable obstruction is a finite certificate** (§ 2; Appendices A, B). The "measurable obstruction" of the title is the
   certificate of Theorem 2.1 or 2.2: finitely many finite point sets `U_q ⊆ ℚ^d`, a copositive matrix on each (on `U_q × [k]` for
   colourings), and real numbers, satisfying one linear normalization ((2.2), or the strict (2.6)) and one **radial inequality** ((2.3),
   (2.7)) — a finite linear combination of spherical transforms `Ω_d(‖w‖τ)` that is non-negative for every `τ ⩾ 0`. Theorem 2.1's
   converse says such certificates approach `m_D(ℝ^d)`; Theorem 2.2's converse says one exists whenever `χ_D^(m)(ℝ^d) > k`. With no
   configurations (`ℓ = 0`) the density certificate is the measurable ratio bound and the colouring one is the spectral bound; the
   configurations are what makes the certificates exact. The density converse is `[24]`'s completely positive formulation (Lemma A.1, by
   citation) made finite and rational by sampling (Lemma A.2); the colouring converse is proved in Appendix B: if no certificate exists,
   compactness gives a measure `µ` on `[0, ∞)` whose transform `h` makes every matrix `C_U` completely positive (p. 46), a completely
   positive `C_U` is a mixture of fractional colourings of `U`, a compactness and an `L²` limit turn the mixtures over rational points
   into measurable functions `f_i ⩾ 0`, `Σ f_i = 1`, whose positivity sets avoid the distances after passing to density points (pp. 44–46),
   and Lemma B.1 turns those sets into a measurable proper colouring. **I checked this proof line by line (the block sums, (B.1)–(B.3),
   the continuity that upgrades "almost every `v`" to "every `v`", the separation and the sampling) and found no gap**; it rests on
   Lemma A.2 and on nothing of `[24]` beyond notation. Both certificate theorems hold for every `d ⩾ 2`.
2. **A certificate on a lattice bounds a lattice graph** (§ 3). If the same data sit in `ℤ^r` and the radial inequality is replaced by a
   trigonometric inequality on the whole torus `𝕋^r` ((3.2), (3.7)), then `ᾱ(Cay(ℤ^r, C)) ⩽ z₀` (Theorem 3.3) and `χ(Cay(ℤ^r, C)) > k`
   (Theorem 3.5). These are the weighted ratio bound and its vector-colouring form (after Bilu, p. 11) with Boolean-quadratic
   constraints added; the proofs pass to `ℤ_n^r` and use Lemma 3.2's eigenvalues. No dimension enters; **nothing about measurability
   enters** — the colouring `c` in Theorem 3.5 is arbitrary.
3. **Transference** (§§ 4–6, used in § 7): given a radial inequality `F(τ) = c_∞ + Σ_{w∈W} c_w Ω_d(‖w‖τ) ⩾ 0` with `W ⊆ ℤ^d` (after
   scaling; the forbidden distances become integer vectors by Lagrange's four-square theorem, p. 28), find an injective homomorphism `E`
   of a lattice `ℤ^r` into `ℝ^d` and a finite family `𝒢` of injective maps `Γ : ℤ^d → ℤ^r` with `‖EΓw‖ = ‖w‖`, such that the average
   over `𝒢` of the characters `e^{2πiΓw·θ}` satisfies the inequality with `c_∞ + ε`, **for every `θ ∈ 𝕋^r`** (Theorems 5.2, 6.3). Then
   `E` embeds `Cay(ℤ^r, {Γw_s})` in the `D`-distance graph on `E(ℤ^r)`, the configurations are relabelled along each `Γ` and averaged
   (pp. 28–29), and move 2 applies. `E(ℤ^r) ⊆ ℚ(√n)⁴` for `d = 4` (`r = 8`) and `⊆ ℚ^d` for `d ⩾ 5` (`r = d`) — "These different
   arithmetic constructions account for the two conclusions of Theorem 1.1" (p. 5).

How a transference theorem is proved (pp. 19–20, 26–27). The family is `Γ = B·L_x` (and more factors for `d ⩾ 5`): `L_x` is left
multiplication by an integral quaternion `x` of norm `p²`, `p` a large odd prime, and `B` runs over a second, small family. For fixed
`B` the average over all `x ∈ X_p` of `e^{2πiθ·BL_x w}` is `𝒦_{p,w}(Bᵀθ)`, and Lemma 4.4 says that this is within `δ` of
`Ω₄(p‖w‖ dist(Bᵀθ, 0))` — the spherical transform at one frequency, the same for every `w ∈ W` — **provided `Bᵀθ` is not within `C₀/p` of a
non-zero torus point of denominator at most `Q₀`**. So each block contributes `F(τ) − c_∞ ⩾ −c_∞` up to `δΛ`, at a `τ` depending on
the block, and an average of non-negative values of `F` is non-negative. The second family is the **filter**: Lemma 5.1 gives `K` plane
rotations `C_j` with entries in `ℚ(ϑ)`, `ϑ² = n`, such that for every `θ` at most two (in `𝕋²`; eight in `𝕋⁸`, p. 20) of the points
`B_jᵀθ` are near a non-zero point of bounded denominator; the bad blocks are bounded trivially by `Λ = Σ|c_w|` and cost `δΛ` once
`8/K < δ`.

### 3.2 Exactly where the dimension is used

| step | what it needs | where | at `d = 4` | at `d ⩾ 5` | at `d = 3, 2` |
|---|---|---|---|---|---|
| certificates (Thms 2.1, 2.2) | `Ω_d(t) → 0`, so the constraints are weak-* closed | pp. 6, 46 ("Since d ⩾ 2 …") | holds | holds | **holds for `d ⩾ 2`** |
| lattice bounds (Thms 3.3, 3.5) | nothing | § 3 | — | — | **hold in every rank** |
| forbidden distances as integer vectors | every integer a sum of four squares | p. 28 ("By Lagrange's four-square theorem …"); p. 8 ("make this rescaling possible for d ⩾ 4") | used | used | for `D = {1}` not needed in any dimension |
| decay of sphere sums away from bounded denominators | `|Σ_{‖x‖²=λ} e^{2πix·θ}|` small off the major arcs | Theorem 4.1, "Magyar [45]", p. 13: "Having such an estimate is crucial to our arguments. We remark that the corresponding theorem for d ⩾ 5 was proven by Magyar, Stein and Wainger [46]." | **used** | used through the four-dimensional block | not stated; no remark on any page |
| equidistribution near 0 | `p⁻¹X_p` equidistributes on `S³` | Lemma 4.3, by Malyshev `[47]`, p. 14 | **used** | through the block | — |
| moving a whole configuration by one similitude | integral quaternions: `L_x ∈ M₄(ℤ)`, `L_xᵀL_x = ‖x‖²I₄`, simply transitive on spheres | p. 15: "This actually makes d = 4 an ideal dimension since we can identify ℝ⁴ with the quaternion algebra ℍ" | **used** | `S_x = L_x ⊕ pI_{d−4}`, then an average over rational rotations (Lemma 6.2; `SO(d, ℚ)` dense in `SO(d)`, `[25]`) | — |
| the filter | rotations whose integral multiples kill bounded-denominator torsion | Lemma 5.1 (planar, over `ℚ(ϑ)`) | `C_j ⊕ C_j`, entries in `ℚ(√n)`: hence the quadratic extension | Lemma 6.1: "The condition d ⩾ 5 ensures that the quaternionic four-dimensional block has a nonzero orthogonal complement" (p. 21) — a plane spanned by an integer vector of norm `ϑ` in the block and a unit vector outside carries `κC_jᵀ` as an integer matrix; hence `ℚ^d` | — |

**What the paper says fails at 3 and at 2, and what would be needed: nothing beyond three sentences.** The words about low dimensions
are, in full: the abstract's "We expect that our techniques could be developed much further. This includes the possibility of extending
our main theorem that χ(ℝ^d) = χ^(m)(ℝ^d) for d ⩾ 4 to d = 3 or possibly even to d = 2 to tackle the Hadwiger-Nelson problem" (p. 1);
"We hope that it will be possible to extend our techniques to dimensions 2 and 3" (p. 5); and "We conjecture that this also holds in
the three dimensional case. In the plane we suspect that a more complicated extension of ℚ² might be required" (p. 5). A search of all
47 pages for "d = 2", "d = 3", "dimension(s) 2", "three dimensional", "planar", "in the plane", "we suspect", "we hope", "we expect"
finds no other passage (the remaining hits are the planar filter and the history). **No step is named as failing, and no requirement is
stated.** What can be read off the proof (mine, from the table): of the transference's inputs, the certificates, the lattice bounds and
the filter lemma are available in the plane as printed; the three that are four-dimensional are Theorem 4.1, Lemma 4.3 and the
quaternions. Why the rational statement needs `d ⩾ 5` is stated (p. 3): "χ(ℚ²) = χ(ℚ³) = 2 and χ(ℚ⁴) = 4 [6, 72], so the restriction
d ⩾ 5 in our rational-point conclusion is necessary."

**The outside release** `[53]` is not used and not discussed: it is cited once, in the last lines of p. 37, as the reason the paper was
posted when it was. The introduction still gives the plane as "5 ⩽ χ(ℝ²) ⩽ 7" (p. 2). So the paper does not combine itself with the
release; § M does.

### 3.3 Recognition (`ephodos-recognition`, invoked fresh): what the dimension hypothesis is, in the field that owns it

*Mine; the parts that are facts about the paper are marked "read off the proof", the classical facts are recalled, not read, and the
identification at `d = 2` is a reading with its killing test.*

**For a stranger** (a number theorist who works with quadratic forms and with equidistribution on homogeneous spaces). Let `q = x₁² +
⋯ + x_d²`, `F` a real number field, `Λ ⊂ F^d` a finitely generated subgroup with dual torus `Λ̂`, and `W ⊂ Λ` finite. Wanted: a finite
family of `F`-rational similitudes of `q`, grouped in blocks, such that for **every** character `θ ∈ Λ̂` and every block, the block's
average of `θ(γw)` is, simultaneously for all `w ∈ W`, within `δ` of the value at `‖w‖` of one positive-definite radial function on
`ℝ^d` (the block may choose which) — for all but a `δ`-proportion of the blocks. *This is a uniform equidistribution statement for the
orbits of the rational points of the group of rotations of `q` acting on the characters of a lattice.* Its two halves have names. The
characters near a non-zero point of bounded denominator — the paper's major arcs, the ones the filter removes — are the characters that
factor through `Λ/NΛ`: the **local, finite-place** half. The rest — the minor arcs, Theorem 4.1's — is the **global** half.

**Features, sorted.**

| feature of the paper's proof | sort | receipt |
|---|---|---|
| the number four in "four squares" (Lagrange) | accompanies, for `D = {1}` | a unit distance is the integer vector `(m, 0, …)` after scaling in any dimension; consumed only for several distances (p. 28) |
| `ℚ^d` failing at `d = 4` and needing `ℚ(√n)` | **determines, through one consequence**: the unit sphere of `q` is compact at a finite place | recalled: `x₁² + ⋯ + x₄²` is the norm form of Hamilton's quaternions, anisotropic over `ℚ₂` and isotropic over `ℚ_p`, `p` odd; where the sphere is compact every rational rotation is integral there, reduction is a graph homomorphism to a finite graph, and `χ(ℚ⁴) = 4` (the paper's `[6, 72]`). The filter's rotations have 2-adically large denominators (`κ = 2q^K X`), which exist only where the sphere is not compact; over `ℚ₂(√n)`, `n ≡ 7 (mod 8)`, it is not (control `filter-minus-one`) |
| `d ⩾ 5` for rational points | **determines, same consequence** | recalled: a form in five or more variables is isotropic over every `ℚ_p` (Meyer; Hasse–Minkowski); read off the proof: the extra coordinate is consumed only to make `κC_jᵀ` integral (p. 21) |
| quaternions | determines, through "a rational family of rotations acting transitively on spheres whose points equidistribute" | read off the proof (p. 15, and p. 23's "it does work for d = 8 by instead using the integral octonions"); without it Lemma 6.2 has to average over more rotations |
| Magyar's bound | **determines**: the global half | p. 13, "crucial" |
| that the certificate has configurations, not only distances | accompanies the transference | the blocks move every `w ∈ W` by one similitude, so configurations ride along (pp. 28–29) |

**The homes.** (a) *Quadratic forms over local fields.* The local half is: **the unit sphere of `q` is non-compact at the finite places
that matter** — `q` isotropic there. A place where it is compact is, in this project's words, a **stable place**, and the finite graph
the reduction lands in is its **residue target** (`CLAUDE.md` § Notation; row 52). Dictionary: bounded-denominator torsion character ↔
character of a residue target; "filtered away" ↔ no stable place of residue characteristic at most `Q`; `χ(ℚ²) = χ(ℚ³) = 2`,
`χ(ℚ⁴) = 4` ↔ the dyadic place of `ℚ` is stable in dimensions 2, 3 and 4; `n ≡ 7 (mod 8)` ↔ the 2-adic wall broken (G35). The
exceptions vanish under this name: the three rational exceptions and the quadratic extension are one statement. (b) *Equidistribution
of rational points of a semisimple group* (Hecke points; Kloosterman's refinement of the circle method — Magyar's theorem lives here).
For `d ⩾ 3` the rotation group is semisimple, and where it is non-compact at a finite place its rational points equidistribute with a
rate at every frequency off the major arcs; that is the global half for `d ⩾ 4`, and the paper conjectures it for `d = 3` in the form
"this also holds in the three dimensional case". (c) *Rigidity of higher-rank diagonalizable actions* (Furstenberg's ×2×3; Berend;
Einsiedler–Lindenstrauss). **For `d = 2` the rotation group of `q` over `F` is a torus** — the unit vectors `U_F` of `F(i)`, an abelian
group of infinite rank acting on the solenoid `R̂_F` — and the global half becomes: every orbit average of a character under `U_F`,
off the torsion and archimedean characters, tends to the Haar value, uniformly. Its measure form — every `U_F`-invariant measure that
gives the exceptional set `E` no mass is Haar — **is this project's MR** (row 120), held at [hand] over `[EinsiedlerLindenstrauss2022]`
and an Einsiedler–Fish transfer; its uniform, finitary form is what a planar Theorem 5.2 would need, and is not held by anyone.

**So, at `d = 2` over `ℚ(√n)`, the two halves read:**

- *Local.* No number field `F ∌ i` has the plane's unit circle non-compact at every finite place: `−1` fails to be a square in `F_v`
  for a positive proportion of the places (recalled: Chebotarev for `F(i)/F`). So the hypothesis as the paper uses it in dimension four
  — no obstruction at any bounded denominator — can hold in the plane only **up to a bound `Q`**, or in an infinite extension (the
  release's algebraic plane, where no place is stable: G93). Up to a bound it does hold, **and the paper's own filter lemma supplies the
  fields**: `ℚ(√(4(Q!)^{2K} − 1))` has no stable place above any prime `p ⩽ Q` (ER1-FILTER-FIELDS below; at `Q = 4, K = 1` the field
  is `ℚ(√47)`, at `Q = 3, K = 1` it is `ℚ(√143)`). What replaces "no stable place" at a fixed number field is this project's
  **thickness**: at a stable place whose local piece mixes, the torsion characters' averages are small (row 128's `λ*_v < 1/5`; Weil's
  bound from residue characteristic 103 up), which is all a block average is asked to be.
- *Global.* MR for the unit-vector group, in a uniform form.

Read this way the paper's four-dimensional theorem and row 128 are the same two-step shape — make the finite places harmless, then
equidistribute — with the second step a theorem of analytic number theory in dimension four and a rigidity statement in dimension two.

**Tests of the name.** *The exceptions vanish:* above. *It predicts a neighbour:* the fields the four-dimensional proof builds, read as
planes, should be fields this project's theory calls interesting — and they are: from `Q = 7` on their squarefree parts lie in the three
classes modulo 168 that the paper's p. 5 calls "the remaining cases" (control `filter-classes`), which the paper does not remark.
*The remaining step is not the problem renamed:* at `d = 2` the remaining step is uniform equidistribution for `U_F`, which is a
statement about a group action with no colouring in it. *What it does not do:* it derives nothing; a planar transference is not proved
here or anywhere.

**Reading, with its killing test** [reading, one mind]: *in the plane, the paper's major arcs are this project's stable places and its
minor-arc estimate is MR in uniform form; nothing else of the proof is dimension-bound.* Killed by a planar analogue of Theorem 5.2
over a fixed real quadratic field whose proof uses no equidistribution or rigidity input for the unit-vector group; or by a failure of
planar transference, at a field all of whose stable places are thick, that is not a failure of equidistribution.

derivation: ER1-FILTER-FIELDS
  statement: for integers Q ⩾ 2 and K ⩾ 1, with q = Q! and n = 4q^{2K} − 1, the number −1 is a square in the completion of ℚ(√n) at every place above every prime p ⩽ Q; and for Q ⩾ 7 the squarefree part of n is congruent to 47, 143 or 167 modulo 168
  uses only: that every prime p ⩽ Q divides Q!; Hensel's lemma for squares in ℤ_p (1 + pℤ_p for odd p, 1 + 8ℤ₂ for p = 2); that
    168 divides Q! for Q ⩾ 7; that −1 is not a square modulo 7
  not claimed: that such a field has no stable place at all — it has infinitely many, above primes larger than Q; that the
    fields of the paper's four-dimensional proof have Q ⩾ 7, since its Q is whatever Lemma 4.4 returns for the certificate;
    anything about a chromatic number
  argument: § Argument for ER1-FILTER-FIELDS
  verdict: derived
  grade: hand
  minds: 1
  model: Q = 4, K = 1 — q = 24, n = 2303 = 7² · 47, the field ℚ(√47), where −1 ≡ 47 modulo 2, 3 (and 47 ≡ 15 modulo 16)
  prior art: partly: [Davies2026] Lemma 5.1 (p. 17) defines ϑ = √(4q^{2K} − 1) and notes gcd(ϑ², q) = 1; the reading of it at
    the places above the primes up to Q, and the classes modulo 168, are not in the paper; no search made
  handoff: none — a relay-result for the placements of rows 121, 123 and 128

control: filter-minus-one
  of: ER1-FILTER-FIELDS — the congruence n ≡ −1 modulo every prime p ⩽ Q (and n ≡ 15 modulo 16), on Q = 2..8, K = 1..3
  run: python3 ../data/fs131/er1/fields_check.py filter 1
  expect: 0
  fault: python3 ../data/fs131/er1/fields_check.py filter 3

control: filter-classes
  of: ER1-FILTER-FIELDS — the squarefree part of n modulo 168, on Q = 7, 8 and K = 1, 2: how many fall outside the three classes
  run: python3 ../data/fs131/er1/fields_check.py classes 7,8
  expect: 0 [167]
  fault: python3 ../data/fs131/er1/fields_check.py classes 2,3

### Argument for ER1-FILTER-FIELDS

Let `p ⩽ Q` be prime; then `p | q`, so `n ≡ −1 (mod p)` and `n` is a `p`-adic unit. Write `−1 = n − 4q^{2K} = n·(1 − 4q^{2K}/n)`. For
odd `p` the second factor lies in `1 + pℤ_p`, a square in `ℤ_p`. For `p = 2`: `q` is even and `K ⩾ 1`, so `16 | 4q^{2K}` and the factor
lies in `1 + 16ℤ₂ ⊆ 1 + 8ℤ₂`, a square in `ℤ₂`. In every completion of `ℚ(√n)` above `p` the number `n` is a square (it is `(√n)²`), so
`−1` is a square there. For the second clause let `Q ⩾ 7`, so `168 | q` and `n ≡ −1` modulo 8, 3 and 7. Write `n = ms²` with `m`
squarefree; `s` is prime to 2, 3 and 7, so `s² ≡ 1` modulo 8 and modulo 3 and `s²` is a non-zero square modulo 7. Hence `m ≡ 7 (mod 8)`,
`m ≡ 2 (mod 3)`, and `m ≡ −(a square)` modulo 7, a non-residue because `−1` is one. By ER1-168 those are the classes 47, 143, 167. ∎
(At `Q = 7, 8`, `K = 1, 2` the control prints the single class 167; `(Q, K) = (2, 1), (3, 1), (4, 1)` give `ℚ(√15)`, `ℚ(√143)`,
`ℚ(√47)` — `fields_check.py small`.)

## Stage 4 — SAVED: row 121 placed (`χ(ℚ(√47)²) = 5`)

- **Posed there — yes, by class, on p. 5.** "In particular, it is known that ℚ(√n)² is four-colourable for n ≢ 47, 143, 167
  (mod 168). It would be particularly interesting to determine if the remaining cases are six-colourable and if any of them contain a
  five chromatic unit distance graph." `ℚ(√47)` is the least of "the remaining cases". The paper does not print `ℚ(√47)`: the question
  is asked of the three classes, of which 47 is one class's name and the least member. So "asks for by name" is right of the class and
  not of the field; the field is named in `[Moorhouse2010slides]` (*"What about χ(ℚ(√47)²)?"*), which the paper does not cite (it
  cites the draft `[49]`).
  - Its second question, *does any of them contain a five-chromatic unit-distance graph* — row 121's lower half says **yes at 47**
    (and 143, 311, 335), given MR at the field, [hand]; no graph is exhibited.
  - Its first, *are they six-colourable* — at 47 **yes, five-colourable**, by the plane at 11: prior art (`[Moorhouse2010]`'s bound
    with `χ(𝔽₁₁²) = 5`), and kernel-checked here with no hypothesis.
- **Proved or implied there — no.** The paper has no lower bound for any `ℚ(√n)²` and no statement about a plane over a number field
  other than the two sentences quoted. Its field theorem is four-dimensional: "there exists a positive nonsquare integer n such that
  χ(ℝ⁴) = χ(ℚ(√n)⁴)" (p. 3).
- **In tension — no.** One sentence would be, read to the letter: "ℚ(√n)² is four-colourable for n ≢ 47, 143, 167 (mod 168)" at the
  non-squarefree `n = 423 = 9·47 ≡ 87 (mod 168)` says `ℚ(√47)²` is four-colourable (control `nonsquarefree`). The word "squarefree"
  is missing; the next sentence calls those planes open, so this is a slip of wording, not a claim against the row.
- **Untouched:** the triangle-free consequence; the chain MR → SP-Cor → T-C(A); every grade.
- **One thing the paper adds that the row does not have.** The field of its Lemma 5.1 at `Q = 4`, `K = 1` is `ℚ(√47)`
  (ER1-FILTER-FIELDS, model): the smallest "remaining case" is one of the fields its four-dimensional construction is built from. A
  curiosity with a mechanism (§ 3.3), not a result about the plane.
- **For the wording of the statement that goes out:** the row answers a question in print four times now — `[Johnson2006]` p. 214,
  `[Moorhouse2010slides]`, `[Soifer2024]` 55.1's existence half, and `[Davies2026]` p. 5 (8 October 2026), the last asking both for a
  five-chromatic graph and for six-colourability. Cite all four; say "not found in print", with the paper as the newest poser and as
  evidence the question was open on 8 October 2026 on its author's account.

## Stage 5 — SAVED: row 123 placed (the main clause through five)

- **Posed there — its quadratic instances, the same sentence of p. 5.** Row 123 gives `χ(ℚ(√n)²) ⩾ 5` for **every** squarefree
  `n ≡ 47, 143, 167 (mod 168)` (each has `L ⩾ 5`) and `= 5` wherever `L = 5` ("44 of the 52 with `d ⩽ 3000`"). So to "if any of them
  contain a five chromatic unit distance graph" the row answers: every one of them, given MR, [hand]. To "if the remaining cases are
  six-colourable": yes where `L = 5`; where `L ⩾ 6` (`ℚ(√167)`, `ℚ(√1319)`, `ℚ(√2351)`, …) this project holds only `χ ⩾ 5`, and at a
  remaining case all of whose stable places mix at six colours the question is Hadwiger–Nelson itself, given MR (row 128;
  `635087 ≡ 47 (mod 168)`, control `collapse-field`). So the paper's question of six-colourability over all remaining cases is, given
  MR at that one field, its own Conjecture 1.6 — which the paper does not say.
- **Proved or implied there — no.** The paper has no local bound, no place, no number field beyond `ℚ(√n)`; a full-text search finds no
  "number field", "p-adic", "residue", "local" in this sense. The general clause (every real number field; the rule for `L(F) ⩾ 5`) is
  **untouched**.
- **In tension — no.** Its "known" sentence agrees with the row's upper-bound side: the three classes are exactly where none of the
  three printed four-colourings applies (ER1-168), which is G61's "`L ⩾ 5` exactly at `d ≡ 47, 143, 167 (mod 168)`" read for upper
  bounds. The paper says nothing of *lower* bounds below five: that four colours are needed at `n ≡ 11 (mod 12)` (rows 73, 82–83) is
  neither stated nor asked.
- **What its method says about the row's mechanism** (§ 3.3): the row's rule lists the stable places that can four-colour; the paper's
  major arcs are those places. Its numbers fit the row's sibling, row 129: `χ(ℚ⁴) = 4` (p. 3) gives `ᾱ(ℚ⁴) ⩾ 1/4`, against
  `ᾱ(ℝ⁴) = m₁(ℝ⁴) ⩽ 0.09857010` (Table 1, p. 4) — a gap carried by one place, the dyadic one, as row 129's formula
  `α₁ = max(m₁, sup_v r_v)` has it in the plane. The paper states no such formula.

## Stage 6 — SAVED: row 128 placed (the collapse: a field's plane is the plane)

- **Its analogue is proved there, in dimension at least four, unconditionally.** Theorem 1.1 (p. 3): `χ_D(ℚ^d) = χ_D(ℝ^d) =
  χ_D^(m)(ℝ^d)` for `d ⩾ 5`; and for `d = 4`, by the proof (pp. 3, 5): "there exists a positive nonsquare integer n such that
  χ(ℝ⁴) = χ(ℚ(√n)⁴)". Generality: every finite `D` with rational squares; the density equalities beside the chromatic ones. Limits:
  the `n` is not exhibited and cannot be from the proof as it stands — it is `4(Q!)^{2K} − 1` for a `Q` and `K` fixed by a certificate
  at `k = χ^(m)(ℝ⁴) − 1`, a number nobody knows. Row 128 is the statement of the same form **in the plane**, at an **explicit** field
  (`ℚ(√635087)`; de Grey's field), **conditional** on MR there, with the plane's own half since `[OAIMath2026]` needing no MR.
- **Posed there, and guessed against — one sentence, p. 5.** "In the plane we suspect that a more complicated extension of ℚ² might be
  required." Its kind: **a suspicion** — the verb is "suspect", the mood "might" — beside a conjecture for dimension three and a
  theorem for dimension four. It is **not a theorem and not a heuristic**: no argument for it is given on p. 5 or on any other page
  (§ 3.2's search), and the paper never mentions invariant measures, rigidity or places.
- **The premise of ours it would have to deny.** Row 128's chain at `F = ℚ(√635087)` is: a `k`-colouring of `F²` gives a CP
  `k`-colouring of the real plane or an SP witness (the load-bearing step — "condition on the `T + A` factor, extend to the adelic
  completion, select over all stable places at once by mixing"; two derivations blind to each other); MR(F) excludes the SP witness;
  and `χ(ℝ²) ⩽ χ_CP(ℝ²)` is free. If no real quadratic field's plane had the plane's chromatic number, then at this field **either MR
  fails — some `U_F`-invariant measure on `R̂_F`, null on the exceptional set, is not Haar — or the selection over thick stable places
  is wrong.** Those are the only two places to stand. **The paper gives no reason against either**; it gives none at all.
- **What its method says, read in the plane** (§ 3.3; mine): nothing against the row, and one thing for its shape. The paper's
  obstruction to rational points is local — a finite place where the unit sphere is compact — and its cure in dimension four is a
  quadratic field chosen so that no such place lies above a small prime. Its own Lemma 5.1 builds those fields *in the plane*
  (ER1-FILTER-FIELDS), and they are of row 128's kind: no stable place up to a bound, hence only thick ones beyond it. What a planar
  version of its Theorem 5.2 would still need is uniform equidistribution for the unit-vector group — MR's finitary form — and I read
  the suspicion as the absence of that estimate on circles (an integer circle carries few lattice points; p. 13 calls the
  four-dimensional estimate "crucial"), not as an arithmetic obstruction to quadratic fields. That reading of the author's reason is a
  guess and is marked as one; the paper does not say.
- **The asking lane's invention signal** (`data/fs131/reports/FS131-PN1.md`: the sentence of p. 5 against row 128). Worked as
  recognition's collision of two descriptions: stated in their homes' words they agree on the mechanism and differ only where one of
  them guesses. A suspicion with no argument against a conditional theorem is **not two truths**; I find no premise the two share that
  neither earned, so nothing here licenses an invention job. What would make it a real collision: an argument that orbits of `U_F` fail
  to equidistribute over every real quadratic field — an SP witness — which would refute MR there (G80's killing test, in the field
  form row 129 keeps).
- **For the wording of what goes out.** (i) The form "`χ(ℝ^d) = χ(K^d)` for a number field `K`" is now in print as a theorem for
  `d ⩾ 5` (`K = ℚ`) and `d = 4` (`K = ℚ(√n)`, `n` not exhibited), a conjecture for `d = 3`, and a doubted statement for `d = 2`; row
  128's field half is the doubted case, at a named field, given MR. Say exactly that, and cite the sentence — it is evidence that the
  statement is not expected, which is to the row's credit only once MR is formalized. (ii) Row 128's "Prior art" clause should name
  the paper for the higher-dimensional analogue. (iii) Given MR at that field, the paper's Conjecture 1.6 is `χ(ℚ(√635087)²) = 6`.

## Stage 7 — SAVED: row 129 placed (the fractional principle; the plane clause)

- **The plane clause's first equality is the `d = 2` case of the paper's density statement, word for word — and the paper does not
  have it.** Theorem 1.1's real half is "ᾱ_D(ℝ⁴) = m_D(ℝ⁴)" and, for `d ⩾ 5`, "ᾱ_D(ℝ^d) = m_D(ℝ^d)"; with the definitions of § 2.1,
  `ᾱ(ℝ²) = m₁(ℝ²)` **is** row 129's "`α₁(ℝ²) = m₁(ℝ²)`" (C133-ONE). So the answer to the brief's question is: *neither implied by,
  nor merely equivalent to — it is the same sentence at `d = 2`, a dimension the theorem does not reach*; logically the paper's
  theorems (all `d ⩾ 4`) are independent of it.
- **Posed there — as a hope, and for the other half.** The abstract names the chromatic equality ("extending our main theorem that
  χ(ℝ^d) = χ^(m)(ℝ^d) for d ⩾ 4 to d = 3 or possibly even to d = 2"); p. 5 hopes for "our techniques" in dimensions 2 and 3. The
  density equality at `d = 2` is not singled out anywhere; `[1]` (`[AmbrusEtAl2023]`) is cited only in the list of works where the
  measurable/ordinary question recurs (p. 3) and `[41]` likewise. The published expectation that `α₁(ℝ²) ≠ m₁(ℝ²)`
  (row 129's "Mechanism" clause) is not discussed.
- **Does any part of its method plainly give the clause — no.** Available in the plane as printed: Theorem 2.1 (certificates on
  rational configurations approaching `m₁(ℝ²)`, by `[24]` and Appendix A) and Theorem 3.3 (the lattice bound). Missing: a planar
  transference, the step that is four-dimensional (§ 3.2). C133-ONE reaches the equality another way — invariant random independent
  sets of the algebraic plane, over the release's Theorem 2.3 — and uses neither of the two available pieces.
- **The rest of the row.** `α₁(𝒜²)` and the `χ_f` equalities: the algebraic plane is, in the paper's phrase, "a more complicated
  extension of ℚ²"; the paper has no fractional chromatic number. The field form (`α₁(F²) = α_loc(F)` given MR) and "that route never
  gives six": untouched, and the paper's own figures at `ℚ⁴` fit the field form's shape (Stage 5, last item). Theorem 1.4 and
  Table 1 concern `d ⩾ 4`.
- **The clock, stated plainly.** The paper's author states the aim of reaching `d = 2`. Of the plane's two halves over `ℝ`: the
  chromatic one, `χ(ℝ²) = χ^(m)(ℝ²)`, already follows from the release's Theorem 1.3 and the paper's own Lemma B.1 in a paragraph (§ M)
  — anyone holding both papers can write it; the density one, `ᾱ(ℝ²) = m₁(ℝ²)`, is C133-ONE, [hand], one mind, kernel pending, and
  needs the release's rigidity theorem with a Følner argument or a planar transference. Neither is in print as far as today's reading
  and the asking lane's search reach.

## Stage 8 — SAVED: what the paper calls known about planes over real quadratic fields

**The sentence** (p. 5): "Nevertheless, the problem of determining the chromatic number of ℚ(√n)² has been well studied [32, 39, 49,
56]. In particular, it is known that ℚ(√n)² is four-colourable for n ≢ 47, 143, 167 (mod 168)."

**The four works, by statement, against this project's copies** (`BIBLIOGRAPHY.md` rows; `CLOSED-QUESTIONS.md` § 1.7):

| the paper's | key here | what it holds on these planes | checked how |
|---|---|---|---|
| `[32]` | `[Fischer1990]` | two colours iff `N ≢ 3 (mod 4)` (Thm 8); three for `N ≡ 0, 1 (mod 3)` (Thm 9); an additive four-colouring for `N ≡ 3 (mod 8)` (Thm 10 (i)); lower bound three | held, read (bibliography row; § 1.7) |
| `[39]` | `[Johnson1987]` | two-colourable for squarefree `m ≡ 1, 2 (mod 4)` | **not held**: by its zbMATH review only (Zbl 0648.05006, quoted in the bibliography row) — **the one I could not check at its pages** |
| `[49]` | `[Moorhouse2010]` | the finite-plane bound (Thm 8.1, Cor. 8.3): four colours when the plane at 7 is a target; its slides add "If d ≢ 47, 59 or 83 mod 84, then χ(K²) ⩽ 4" and the question about `ℚ(√47)` | held, read; the slides held |
| `[56]` | `[Payne2009]` | § 3 indexes Johnson's and Fischer's bounds; its own subject is `χ ≠ χ_m` for translate graphs | held, read |

**The modulus.** 168 is `[Moorhouse2010slides]`'s 84 refined by `[Fischer1990]` Thm 10 (i): of the classes 47, 59, 83 modulo 84, the
members `≡ 3 (mod 8)` are four-colourable additively, which leaves 47, 143, 167 modulo 168 (ER1-168; controls `remaining-classes`, `remaining-classes-converse`). I
have not seen the modulus 168 in any of the four works as held here; it is their conjunction, and this project's G61 and rows 121, 123
state the same three classes as "`L ⩾ 5` exactly at `d ≡ 47, 143, 167 (mod 168)`".

**Is anything listed as ours already in the cited works, on the paper's account? No.** The paper's "known" is an upper bound only —
four-colourability off the three classes — and `CLOSED-QUESTIONS.md` § 1.7 already files those upper bounds as prior art ("**Only the
lower bounds are ours**"), as does `LEDGER.md` § The claim list ("**Not ours:** … the finite-plane bound and χ(𝔽₁₁²) = 5 (Moorhouse,
Manturov, Madore); the unit argument and the 1/k obstruction … (Fischer, 1990, additive colourings only)"). What the claim list calls
ours here — "the 3-adic barrier and the four-colour lower bounds for real quadratic fields (rows 72–73)", "the passage from additive
to all three-colourings at the field level" (rows 82–83), "`χ(ℚ(√47)²) = 5`" (rows 120–121) — the paper neither attributes to anyone
nor states: on its account the five-chromatic question is open, and lower bounds of four are not mentioned. Two cautions for the
wording: the sentence needs "squarefree" (Stage 4); and it says "well studied" of four works none of which, by statement, holds a
lower bound above three.

derivation: ER1-168
  statement: for an integer n, none of the four conditions n ≢ 3 (mod 4), n ≡ 3 (mod 8), n ≡ 0 or 1 (mod 3), n ≡ 0, 1, 2 or 4 (mod 7) holds if and only if n ≡ 47, 143 or 167 (mod 168)
  uses only: the Chinese remainder theorem for 8, 3 and 7; that the non-zero squares modulo 7 are 1, 2 and 4
  not claimed: that the four conditions are the only known four-colourings of ℚ(√n)²; anything about a non-squarefree n as a
    field — 423 = 9 · 47 lies outside the three classes and names the field of 47; any lower bound
  converse: § Argument for ER1-168
  argument: § Argument for ER1-168
  verdict: derived
  grade: hand
  minds: 1
  model: n = 47 — 47 ≡ 7 (mod 8), 47 ≡ 2 (mod 3), 47 ≡ 5 (mod 7), and 5 is not a square modulo 7
  prior art: partly: the three classes are printed in [Davies2026] p. 5 as the complement of what "is known"; the classes
    47, 59, 83 modulo 84 are [Moorhouse2010slides]'s; held here as G61's "L ⩾ 5 exactly at d ≡ 47, 143, 167 (mod 168)"
  handoff: none — arithmetic under the placements of rows 121 and 123

control: remaining-classes
  of: ER1-168 — the forward direction, on every squarefree n from 2 to 20000: how many n meet none of the four conditions and
    lie outside the three classes
  run: python3 ../data/fs131/er1/fields_check.py cover 47,143,167 fwd
  expect: 0
  fault: python3 ../data/fs131/er1/fields_check.py cover 47,143 fwd

control: remaining-classes-converse
  of: ER1-168 — the converse direction, on every squarefree n from 2 to 20000: how many n lie in one of the classes and meet
    one of the four conditions
  run: python3 ../data/fs131/er1/fields_check.py cover 47,143,167 conv
  expect: 0
  fault: python3 ../data/fs131/er1/fields_check.py cover 47,143,167,23 conv

control: nonsquarefree
  of: ER1-168 — the not-claimed line: the residue of 423 modulo 168, and of its squarefree part
  run: python3 ../data/fs131/er1/fields_check.py nonsqf 423
  expect: 87 47
  fault: python3 ../data/fs131/er1/fields_check.py nonsqf 47

control: collapse-field
  of: ER1-168 — row 128's field among the three classes: 635087 modulo 168
  run: python3 ../data/fs131/er1/fields_check.py field 635087
  expect: 47
  fault: python3 ../data/fs131/er1/fields_check.py field 635086

### Argument for ER1-168

None of the four holds exactly when `n ≡ 3 (mod 4)` and `n ≢ 3 (mod 8)`, i.e. `n ≡ 7 (mod 8)`; and `n ≡ 2 (mod 3)`; and `n` modulo 7 is
3, 5 or 6. Each is a condition on `n` modulo 8, 3, 7, so by the Chinese remainder theorem the set is three classes modulo 168: the
numbers `≡ 7 (mod 8)` and `≡ 2 (mod 3)` are those `≡ 23 (mod 24)`, namely 23, 47, 71, 95, 119, 143, 167 modulo 168, with residues
2, 5, 1, 4, 0, 3, 6 modulo 7; those with residue 3, 5 or 6 are 143, 47, 167. Both directions are this one enumeration. ∎ The four
conditions are the hypotheses of the printed colourings in the table above: two colours, the additive four, three, and the plane at 7.
