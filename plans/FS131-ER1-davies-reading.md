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
