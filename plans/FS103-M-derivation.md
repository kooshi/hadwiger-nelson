# FS103-M — where `χ_CP(ℝ²)` sits: against `χ_m⁰(ℝ²)`, `χ_m(ℝ²)` and `χ_B(ℝ²)`

*Job FS103-M (de Bruijn), Opus 5.5, 2026-09-26. Brief `data/fs103/briefs/M103-where-cp-sits.md`; standing rules
`data/fs103/briefs/STANDING-RULES.md`. Not blind: every file open. Definitions are `data/fs103/claims.md` D-CP (b) and D-M, used verbatim.
Grades are `CLAUDE.md` § Notation's; every count of minds says whose.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, address)*

## Would-have-searched-here log (standing rule 3)

- Stage 1: none. Reading only.

## Stage 1 — SAVED (Falconer first-hand; the quotation check)

### 1.0 Resuming check

`plans/FS103-M-derivation.md` did not exist at start; `data/fs103/fs103-m/` did not exist. Fresh start at stage 1.

### 1.1 The quotation check of the brief (standing rule 5)

| brief's text | source checked | result |
|---|---|---|
| "**`χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²) = χ(F_dG²)`**", both verifiers' stage 3 | `plans/FS103-V1-verification.md` Stage 3 ("So, given MR (row 120), **χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²) = χ(F_dG²)** at my one-mind [hand] grade"); V2 Stage 3 table | matches V1 verbatim; V2 states it claim by claim (C-635-F1, C-dG-F1) |
| V1: "the Følner limit of random translates need not be continuous in probability" | V1 Stage 3 table, row C-FMT (c) | verbatim |
| V1: "colouring the null set of non-density points (the rest proved: density-point classes avoid distance 1 everywhere)" | V1 Stage 3 table, row C-FMT (d) | verbatim |
| Kooshi: *"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup."* | `CLAUDE.md` § Publication | verbatim |
| D-CP (b) "verbatim there" | `data/fs103/claims.md` §0 | present; used below exactly as written there |
| A-E5 "`χ_CP = χ_m⁰`" | `plans/POROS-2026-09-26-fs103-collapse.md` table: "`χ_CP(ℝ²) = χ_m⁰(ℝ²)`, so `χ(ℝ²) ≤ χ_CP(ℝ²) ≤ χ_m(ℝ²)`"; body E5 | matches; E5 is "a sketch [hand, one mind — FS103-A; unverified]" |
| A-E3 "`Cay(ℝ, {±1, ±√2})` with `χ = 2 < 3 = χ_CP`" | same file, table row A-E3 and E3 | matches |
| "the gate's record §2.3 (Payne 2009's 'ambiguous chromatic number'; `[BachocEtAl2014]`'s null-set-tolerant chromatic number; Shelah–Soifer 2003; Soifer 2024 Open AC Problem 62.14)" | `plans/FS103-G-prior-art.md` | **address slip (minor):** only Payne's term is in §2.3 (item 1). `[BachocEtAl2014]` is §2.2; Shelah–Soifer 2003 and Soifer's 62.14 are §2.1's table. All four read there |
| "The gate read it second-hand (`plans/FS103-G-prior-art.md` §3)" | §3.1: "**Primary not held; … The reading below is second-hand**" | matches |
| C-FMT (a), (b), (c), (d), C-CPM verdicts | V1 Stage 3 table; V2 Stage 3 table and Stage 2b | match (V2's (d) text: "**GAP** (null-set step, not derived)") |

**The gate's quotations of the printed sources, re-checked first-hand against the held texts** (all match, modulo OCR ligatures):
- `[Payne2009]` (arXiv:0707.1177v3, held `library/pdf/arXiv-0707.1177.pdf`), §1: "We say that a graph has ambiguous chromatic number when
  χ ≠ χm." Abstract: "…may be seen as further evidence that the chromatic number of the plane might depend on set theory." §3: "In the most
  famous case of the plane we have χ(TQ²) = 2 while χm(TQ²) ≥ 5." **Payne poses no numbered question** about the plane itself being
  ambiguous; the abstract's sentence is the nearest thing.
- `[BachocEtAl2014]` (held, arXiv:1301.1054), Def. 2.1: "A measurable set I ⊆ V is called an independent set of A if (Af, f) = 0 for each
  f ∈ L2 (V) which vanishes almost everywhere outside of I. Notice that sets of µ-measure zero are always independent." §2.4: "The chromatic
  number of A, denoted by χ(A), equals the smallest number k such that one can partition V into k independent sets." §3.1 (their (9)):
  "(Aν f)(x) = (f ∗ ν)(x) = ∫ f(x − y)dν(y)", and "So Aν respects G(Rⁿ, N) and χ(Aν) ≤ χm(G(Rⁿ, N))."
- `[KechrisMarks2020]` Example 5.1 (pp. 45–46): "the unit distance graph on R², … is known to have 5 ≤ χ(U) ≤ χµ(U) ≤ χB(U) ≤ 7, see [DG]
  and [So], but the exact values of χ(U), χµ(U), χB(U) are unknown."
- Shelah–Soifer 2003 (held `data/fs103/fs103-g/shelah-soifer-2003-…pdf`): "Falconer, for example, showed [F] that χ is at least 5 if
  monochromatic sets are Lebesgue measurable"; "DC is sufficient for Falconer's result [F]"; the Conditional Theorem and the closing question,
  as the gate quotes them.
- `[Soifer2024]` p. (ch. 62): "Open AC Problem 62.14 For which values of n is the chromatic number χ(En) of the n-space En is defined 'in the
  absolute,' i.e., in ZF regardless of the addition of the Axiom of Choice or its relative?"

### 1.2 `[Falconer1981]`, first-hand

**Held:** `~/source/library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf` (Kooshi's upload,
6 pp., JCTA 31 (1981) 184–189). **Read in full** (all six pages, text layer and page images of pp. 186–188 checked against each other).

**What it proves, verbatim.**
- **Theorem 2** (p. 188): "Suppose that Rⁿ is covered by n + 2 measurable sets S₁,…,S_{n+2}. Then one of the sets contains a pair of points at
  unit distance apart." So `χ_m(ℝⁿ) ≥ n + 3`, and `χ_m(ℝ²) ≥ 5`.
- **Theorem 1** (p. 186): "Suppose that in Rⁿ there is a configuration C of M points with critical distance 1 and critical number D. Then if Rⁿ
  is covered by M/D or fewer measurable sets Sⱼ, there is a set in the covering within which all distances are realized." With the remark (p.
  186–187): "Theorem 1 gives an improvement of one for the chromatic number in the measurable case if the configuration employed has M/D
  integral."
- The tools. **Lemma 1** (a rigid motion `ρ` of a countable configuration `C` meets a given null set `E` in exactly one point, "for almost all
  … rotations"; Croft's Lemma 3). **Lemma 2**: "Let S be a measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ∖S) > 0 then (i) ∂S is non-empty and
  v(∂S) = 0, (ii) S̃ is a Borel set", where "the metrical boundary ∂S of S [is] those points of Rⁿ at which the Lebesgue density of S either
  fails to exist, or exists and has a value other than 0 or 1" and "the essential part S̃ of S [is] those points … where the Lebesgue density of
  S exists and equals 1". **The null set:** "Now let S₁,…,S_k be disjoint measurable subsets of Rⁿ with union equal to Rⁿ. If E = Rⁿ∖⋃ S̃ⱼ then
  E is the aggregate of the metrical boundaries of the Sⱼ." **Lemma 3** (Croft, his Theorem 8): "Suppose that x₁,…,x_M are points in Rⁿ such
  that x₁ ∈ E, say x₁ ∈ ∂S₁ ∩ ⋯ ∩ ∂S_r, and xᵢ ∈ S̃_{k(i)} for 2 ≤ i ≤ M. Then for every j (1 ≤ j ≤ r) there exists a small translation p such
  that p(x₁) ∈ Sⱼ, and p(xᵢ) ∈ S_{k(i)} if 2 ≤ i ≤ k." **Lemma 4** (the circle, `r > 1/2`, `θ = 2 sin⁻¹(1/2r)` an irrational multiple of `π`,
  "almost all points of T … belong to either S̃₁ or S̃₂" ⟹ a unit pair inside `S₁` or inside `S₂`), proved by Kronecker and "a set with
  arbitrarily small periods has either zero or full measure". The plane case: `sin⁻¹(1/(2√3)) = 2cos⁻¹(5/6)` … "(5 + i√11)^m = 6^m" is
  impossible by unique factorisation in `k(√−11)`.
- **An open remark** (p. 185–186): the closure of `∂S` has non-zero `(n−1)`-dimensional Hausdorff measure; "It would be useful to know if the
  same was true of ∂S itself."

**The format: proper everywhere, measurable classes.** The theorem's conclusion is one pair of points at unit distance **inside one set** `Sⱼ`;
so the colourings it refutes are measurable colourings whose classes avoid distance 1 **everywhere** (`χ_m`, D-M). The proof exhibits single
unit pairs (Lemma 3 gives "a small translation p", one translation, not a positive-measure set of them), so **as written it needs properness at
the exhibited edges, i.e. everywhere**; the paper says nothing about colourings proper only almost everywhere. Whether it survives for `χ_m⁰`
is a reading (the gate's, §2.2), and it is moot for the value five, which `χ_m⁰` has by the edge-null density bound (I-CP57's lower half).

**Against the gate's second-hand reading** (`plans/FS103-G-prior-art.md` §3.1, from `[Soifer2024]` ch. 9's print of Falconer's 2005
exposition, and `[Payne2009]`):

| item | gate (second-hand) | first-hand (1981) | verdict |
|---|---|---|---|
| statement | Soifer's Thm 9.1 (`n = 2`, four disjoint measurable sets); Payne: "χm(Rⁿ) ≥ n + 3" | Theorem 2, general `n`, `n + 2` measurable sets **covering** `ℝⁿ` (not assumed disjoint) | agree; the 1981 form is general `n`, as Payne reported |
| format | "Classes measurable and **proper everywhere**" | the same (the conclusion is a pair inside one set) | agree |
| translations | "translated by a positive-measure set of small vectors `v`" | Lemma 3: "there exists a small translation p" — existence only | **differs**: the positive-measure form is the 2005 exposition's (or Croft's proof), not the 1981 statement. It matters exactly for the a.e. question: the 1981 text does not supply what an a.e. adaptation needs |
| irrationality | Soifer: "(1 − i√11)^{2m} ≠ (−12)^m" | "(5 + i√11)^m = 6^m" impossible | agree: `(1 − i√11)² = −2(5 + i√11)` and `(−12)^m = (−2)^m 6^m` |
| the null set | "the density boundary `∂A` is null and non-empty" | Lemma 2 (i), and `E = ℝⁿ∖⋃S̃ⱼ`, "the aggregate of the metrical boundaries" | agree; **`E` is exactly the null set of question 2 (C-FMT (d))** |

**Bearing on this job (a recognition, not a result).** Falconer's proof lives on the null set `E` that question 2 must colour: its first move
(Lemmas 1 and 3) makes a point `x₁ ∈ ∂S₁ ∩ ∂S₂` "belong to two or more of the Sⱼ" (p. 186, proof of Theorem 1). Question 2 meets the same point
from the other side: a point of `E` needs a colour, and it sees at least two classes of positive density (§3 below).

**Proposed `BIBLIOGRAPHY.md` row change** (the close writes it): `[Falconer1981]` — copy: the path above; read status: **read in full,
first-hand (2026-09-26, FS103-M)**; role: `χ_m(ℝⁿ) ≥ n + 3` for measurable colourings proper everywhere (Thm 2); the essential parts `S̃` and
the null set `E` (Lemma 2, p. 186).
