# PA — audit of `[AmbrusEtAl2023]`'s verification code and certificate (crunch job J26)

*de Bruijn, Opus 5.5, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J26-ambrus2023-audit.md` (with `STANDING-RULES.md`).
Resuming: read this file and the brief, check the last SAVED stage against `git log -- plans/PA-ambrus2023-audit.md`, continue at
the first stage not SAVED.*

**The paper.** G. Ambrus, A. Csiszárik, M. Matolcsi, D. Varga, P. Zsámboki, *The density of planar sets avoiding unit distances*,
arXiv:2207.14179 (v1 28 Jul 2022, v2 20 Oct 2022, v3 28 Jul 2023); published **Mathematical Programming 207 (1–2), 303–327**,
DOI 10.1007/s10107-023-02012-9 — first online 6 October 2023, print issue September 2024 (Crossref, fetched 2026-09-25; received
11 Nov 2022, accepted 25 Jul 2023). Held copy: `~/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf`
(v3, 24 pp.). The published version is paywalled here (Springer page: `"Open Access":"N"`); v3's arXiv comment reads "Final version,
to appear in Mathematical Programming".

## Theorems this phase proved

*(filled at the close of the audit; none expected — this is a reading and a run-or-price.)*

## "Would have searched here" log

*(one line per move that would have been a search, and what was done instead)*

## Stage 1 — SAVED: the ruling, the quotations, and where everything is

### 1.1 The ruling this audit revisits

`plans/FS86-close-inventory.md` item 70, verbatim (its "kind" column: "ruling (owner, at the close)"):

> "**No auditor for C14's external input** (2026-09-25, the close planner's recommendation, owner agreed): C14 is filed at "hand, two
> derivations; at every real place it rests on `[AmbrusEtAl2023]` Thm 1, `m₁(ℝ²) ≤ 0.2470` [external, computer-assisted, published; not
> re-checked here]", and the audit is a named post-close item (an existing checker on an existing certificate, allowed during the ban
> once the certificate and code are found). **Alternative weighed:** an auditor alongside the close. **Why this won:** no certificate
> file or checker is held, so an audit means finding and reproducing their verification code first, a job of unknown size competing
> for the cap; the dependency is only at real places (a complex place behaves like a split place, ratio → 0); nothing else in print
> gives `m₁(ℝ²) < 1/4` (`[KMOR2016]` 0.2588, Ambrus–Matolcsi 0.2544). Confidence medium. The row's grade line is written so it can be
> upgraded in place."

What this audit changes about that ruling's premises is recorded at the verdict (Stage 4). Already at this stage: the premise "no
certificate file or checker is held" is now false in its first half — both are found and held (§1.3) — and the "job of unknown size"
now has a size (Stage 3).

### 1.2 Every quotation in the brief, checked against its source (standing rule 5)

| # | the brief says | the source says | verdict |
|---|---|---|---|
| Q1 | FS-86's C14 "uses, at the real place, the bound `m₁(ℝ²) ≤ 0.2470`" | `plans/FS86-derivation.md` FS86-Cx-C14: "inputs: at every real place AmbrusEtAl2023 Thm 1 (m₁(ℝ²) ≤ 0.2470; external, computer-assisted, published; not re-checked here)"; the paper's Theorem 1 (p. 4): "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." | matches |
| Q2 | "G60's `χ_f(K²) = 4` uses the same paper's geometric fractional chromatic number and its graph `G27`" | `CLAUDE.md` G60: "[hand, from `[MatolcsiEtAl2025]`; …]"; Frontier item 13: "`[MatolcsiEtAl2025]`'s blow-up never leaves the field … with their `G27` and Theorem B, **χ_f(K²) = 4**"; `BIBLIOGRAPHY.md` line 176 (`[MatolcsiEtAl2025]`, arXiv:2311.10069): "a 27-vertex witness `G27` … `χ_gf(G27) = 4`, blown up by the amenability of the plane's isometry group". The paper under audit: Definition 2 (p. 9) — "The geometric fractional chromatic number of G, denoted by χgf (G)" — defines `χ_gf`; it contains no `G27` and no blow-up (its Corollary 2 gives only the measurable bound `m₁(ℝ²) ≤ 1/χ_gf(G)`). | **half wrong.** The definition of `χ_gf` is this paper's; `G27` and the blow-up behind G60 are `[MatolcsiEtAl2025]`'s, a different paper (four authors, two shared). G60 reads this paper for a definition only, and no computation of this paper enters it (Stage 4 §4.3). |
| Q3 | "the bibliography holds two keys for this one paper (`[AmbrusEtAl2023]`, held; `[AmbrusEtAl2024]`, "not held, not read")" | `BIBLIOGRAPHY.md` line 188: key column "**[AmbrusEtAl2024]** / **[Ambrus2023]**", copy column "not held", read column "**not read — second-hand (the web-Claude analysis, `[Ducz2026]`, `[MatolcsiEtAl2025]`)**"; line 259: "**[AmbrusEtAl2023]**", copy `pdf/arXiv-2207.14179-…pdf`, "read — §2 (Lemma 1) and §5 (2026-09-14)" | matches in substance; the inner quotation joins two columns and drops "— second-hand (…)"; and the duplicate is **three** keys, not two (`[Ambrus2023]` too) |
| Q4 | "FS-86's close logged (item 70 …): find the authors' verification code and certificate, and run it unmodified" | item 70 (§1.1): "the audit is a named post-close item (an existing checker on an existing certificate, allowed during the ban once the certificate and code are found)" | a paraphrase, unquoted; "run it unmodified" is the brief's instruction, not item 70's words; consistent in substance |
| Q5 | "Ambrus–Matolcsi 0.2544", "`[KMOR2016]` 0.2588" (inside item 70) | the paper p. 4: "Keleti, Matolcsi, de Oliveira Filho and Ruzsa [KeMOR16] showed that m1 (R2 ) ⩽ 0.2588 … Ambrus and Matolcsi [AmM22] proved that m1 (R2 ) ⩽ 0.2544" | matches |

**One slip logged (Q2):** the brief attributes `G27` to this paper; it is `[MatolcsiEtAl2025]`'s. The `CLAUDE.md` Frontier's "Not ours" list
reads "the geometric fractional chromatic number, the blow-up and `G27` (`[AmbrusEtAl2023]`, `[MatolcsiEtAl2025]`)", which is right if
read respectively (the number from the first, the blow-up and `G27` from the second); nothing to correct there.

### 1.3 Where everything is (every version)

| piece | where | version / date | licence | held here |
|---|---|---|---|---|
| arXiv ancillary files | `arxiv.org/abs/2207.14179v1`, `v2`, `v3` — none of the three abstract pages lists ancillary files; `arxiv.org/src/2207.14179vN/anc` returns 404 for N = 1, 2, 3 | — | — | — (there are none) |
| arXiv source | `arxiv.org/e-print/2207.14179vN`: v1 = `main.tex` + 8 figure PDFs (including `x24.pdf`, a 24-point set); v2 = `main.tex` + 8 figures (`x_23.pdf`, `g_23_phi_1000.pdf`); v3 = `main_final_version.tex` + 9 EPS figures (`g_23_phi_10000.eps`) | 2022-07-28, 2022-10-20, 2023-07-28 | arXiv default | not kept (only TeX and figures; no code, no data) |
| the paper's "[Web]" | `https://bit.ly/unit-distances` → HTTP 301 → `https://static.renyi.hu/ai-shared/daniel/unit-distances/`, a page titled "Supplementary material for 'The density of planar sets avoiding unit distances'", section "Verification": "This page contains all the tools necessary to verify the computer-aided proof presented in the paper" | fetched 2026-09-25 | **none stated** (page, notebook and CSV carry no licence or copyright text; grep for "licen"/"copyright" returns 0 in all three) | `data/pa-ambrus2023/index.html` (sha256 `d0732213…`) |
| the checker | `verification23.nb` — "Mathematica notebook for verification"; 450,992 bytes, ASCII, CRLF | server Last-Modified 2022-10-19 19:49:02 GMT | none stated | `data/pa-ambrus2023/verification23.nb` (sha256 `7d230f20d41a2a3355bee78241c9d626134548c18eeec4de8a1d1217a74cecec`) |
| the checker, as run | `verification23.pdf` — "Pdf version of the Mathematica notebook"; 11 pp., Creator "Wolfram Mathematica 13.0.0.0 for Microsoft Windows (64-bit) (December 2, 2021)", created 2022-10-19 | 2022-10-19 | none stated | `data/pa-ambrus2023/verification23.pdf` (sha256 `cab617df632c675c6239080350d9eceaef0bd8ce07e1a9cbd612c52743c0af11`) |
| the certificate | `g23.csv` — "Text file describing the solution of the witness linear program"; 2,350 lines, one non-zero dual coefficient each (`w_0`, `w_T`, `w_1,i`, `w_2,i,j`, `w_C,"{I}","{J}"`) — the paper's "There are 2350 non-zero coefficients, of which 2321 are of type wc (I, J)" (§8) | 2022-10-19 | none stated | `data/pa-ambrus2023/g23.csv` (sha256 `cbfe22f5028f23a84f17d97802a93517e702eea0181d692ad7f5477763cf7274`) |
| the published version's supplement | Springer ESM `10107_2023_2012_MOESM1_ESM.pdf` ("Supplementary file 1 (pdf 219 KB)", the article's only supplementary item) | with the 2023 publication | Springer | **byte-identical to `verification23.pdf`** (same sha256 `cab617df…`), so not kept twice |
| slides | `https://static.renyi.hu/ai-shared/daniel/udg/geoszem-v1.0.pdf` (1.8 MB, 2022-09-24), "a self-contained talk at the Budapest Big Combinatorics + Geometry Seminar" | 2022-09-24 | none stated | not fetched (not a verification input) |

**Runtime needed:** the notebook is Mathematica (13.0, per the PDF's producer). **Nothing that runs a Mathematica notebook is installed
on the desktop**: `wolframscript`, `math`, `MathKernel`, `WolframKernel`, `wolfram`, `mathics`, `mathics3` are all absent (`command -v`),
and there is no `/usr/local/Wolfram`, `/opt/Wolfram` or `~/.Wolfram`. So "run it unmodified" needs an install first (priced in Stage 3).

## Stage 2 — SAVED: what was read, and what the certificate proves

### 2.1 Read, per section (held v3; the authors' notebook PDF)

| part | read | notes |
|---|---|---|
| paper §1 (pp. 1–5) | in full | Theorem 1 verbatim: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." `m₁(ℝ²)` is defined (eq. (1)) as the supremum of **upper** densities of measurable 1-avoiding sets. |
| §2 Lemma 1 (pp. 5–6) | in full, with proof | the atoms `a_X(ε)`; (ieP), (ieI), (ieT), (ie1), (ie2); the reduction to periodic `A` is cited to [deOV10, KeMOR16] ("m1 (R2 ) may be approximated arbitrarily well by densities of 1-avoiding, measurable, periodic sets") |
| §3 (pp. 7–8) | in full, with proofs | Definition 1, Lemma 2, Corollary 1 (`m₁ ≤ 1/χ_f(G)`) |
| §4 (pp. 8–10) | in full | the O(2) averaging `å_X`, the congruence constraint (ieC), **Definition 2 — the geometric fractional chromatic number `χ_gf`**, Corollary 2 (`m₁(ℝ²) ⩽ 1/χgf (G)`), and a Remark announcing, "elaborated only in a follow-up publication", that `χ_f(ℝ²) = χ_gf(ℝ²)` and conjecturing `χ_f(R2 ) = χgf (R2 ) = 4` |
| §5 (pp. 10–12) | in full | Fourier side: `f̊(x) = Σ_t κ(t) Ω₂(t|x|)`, `Ω₂ = J₀`, `κ(t) ≥ 0`, `δ(A) = Σ_t κ(t)` |
| §6 (pp. 12–14) | in full, with Proposition 1's proof | (LP); **Proposition 1** (the dual certificate, quoted in §2.2); the Remark that only independent atoms need `V(ε) ≥ 0` |
| §7 (pp. 14–16) | in full | the beam search (a week on 128 CPUs, 186,472 LPs) produced `X₂₃`; "the linear program defined by X23 has 13552 atom variables and 12000 Fourier variables … 23 (IE1) constraints, 206 (IE2) constraints … and 5868 (IEC) congruence constraints"; numerical LP value 0.24697 |
| §8 Verification (pp. 16–19) | in full | quoted in §2.3 |
| §9 Implementation (pp. 19–20) | in full | "The final estimate was verified by a piece of independently developed Mathematica code that we publish at [Web]"; the checklist (1)–(3) quoted in §2.3 |
| Appendix (Tables 1–2) | not re-read line by line | Table 1's coordinates are compared with the notebook's in Stage 3 by the exact tool (the notebook's list is what the checker uses) |
| `verification23.pdf` (the notebook as run, 11 pp.) | **in full, code and every output** | §2.4 |
| arXiv v1, v2 source | the numbers only (grep) | v1: `ν = 10^{-10}`, `μ = 0.00005`, `w_T = 0.2469726133341685`, a 24-point figure `x24.pdf`; v2 and v3: `ν = 10^{-5}`, `μ = 0.00006`, `w_T = 0.24697262945998308` — **the web certificate is v2/v3's** (its `w_T` line: `0.24697262945998308,w_T`), not v1's |

### 2.2 What the certificate is (Proposition 1, verbatim, p. 13–14)

> "Proposition 1. Let X be a set of n points in the plane. Suppose that the real numbers w0 , wT , {w1 (i) : i ∈ [n]}, {w2 (i, j) :
> {i, j} ∈ (n 2)}, {wc (I, J) : {I, J} ∈ C(X)} are such that the function defined by (19) W (t) = w0 Ω2 (t) + Σ_{i∈[n]} w1 (i) +
> Σ_{{i,j}} w2 (i, j)Ω2 (t|xi − xj |) satisfies W (t) ⩾ 1 for every t ⩾ 0, and the quantity defined by (20) V (ε) = wT −
> Σ_{i∈[n]: εi =1} w1 (i) − Σ_{{i,j}: εi =εj =1} w2 (i, j) + Σ_{{I,J}∈C(X):ε∈σ(n;I)} wc (I, J) − Σ_{{I,J}∈C(X):ε∈σ(n;J)} wc (I, J)
> satisfies V (ε) ⩾ 0 for every ε ∈ σ(n). Then (21) m1 (R2 ) ⩽ wT ."

*(Sums transcribed from the two-line display; `C(X)` is the set of pairs of congruent index sets.)* The certificate is `(X₂₃, w)`: 23
exact points in the Moser ring and 2,350 non-zero decimal coefficients (`g23.csv`). The hypotheses a checker must establish, and why each
is load-bearing:

| # | obligation | kind | load-bearing because |
|---|---|---|---|
| H1 | the 23 coordinates, and which pairs are at distance exactly 1 | exact algebra (ℚ(√3, √11, i)) | a missed unit edge adds atoms (conservative); a false unit edge removes an atom whose `V(ε)` is then never checked |
| H2 | each listed pair `{I, J}` with `w_C ≠ 0` is a **congruent** pair of point sets | exact algebra | a non-congruent pair is a false constraint (ieC); the dual bound then proves nothing |
| H3 | `V(ε) ≥ −ν` on every independent atom (13,552 of `2²³`) | finite, arithmetic on the decimal coefficients | the atom side of the dual |
| H4 | `W(t) ≥ 1 − μ` on `[0, 10000]` | **continuous**: infinitely many `t`, Bessel functions | the Fourier side of the dual |
| H5 | `W(t) ≥ 1` on `(10000, ∞)` | analytic (Bessel asymptotics) | the tail |
| H6 | `(w_T + ν)/(1 − μ) < 0.2470` | arithmetic | the headline |

Not load-bearing on the certificate but on Theorem 1: the reduction to periodic sets ([deOV10, KeMOR16], §2), the O(2) averaging and
Proposition 1's proof — all hand, all read and found sound (Proposition 1's proof is LP weak duality written out; it uses (C0), (IE1),
(IE2), (IEC), `κ ≥ 0`, `å ≥ 0` and `å = 0` on non-independent atoms, which is why H3 is needed only on independent atoms).

### 2.3 What the paper says the code checks (§8–§9, verbatim)

- §8, H3: "This is a finite set of inequalities, and high precision calculation ensures that V (ε) ⩾ −ν holds true for each ε ∈ σ(n) with
  ν = 10−5 ."
- §8, H5: "Set T = 10000. Then T · dmin ⩾ 1000. Hence, by taking the largest zero of J1 not exceeding 1000, which is s0 = 999.81148 . . .,
  (23) and (24) imply that for t > T , ϕ(t) > w1 (1) − 2|J0 (s0 )| = 1.00892 . . . > 1." — where (23) as printed reads "ϕ(t) ⩾ w1 (4) −
  (|w0 | + Σ |w2 (i, j)|) |J0 (s)|", a **typo: `w1 (4)` for `w1 (1)`** (the same paragraph: "w1 (i) = 0 except for i = 1").
- §8, H4: "This can be lower bounded by using interval arithmetic (note that |J0′ (t)| = |J1 (t)| < 1), which shows that ϕ(t) > 1 − µ with
  µ = 0.00006 for t ∈ [0, T ] (the global minimum of ϕ(t) is attained at t = 3.77488 . . . with ϕ(t) = 0.99995003 . . .)."
- §8, H6: "m1 (R2 ) ⩽ w̃T/(1−µ) = (wT + ν)/(1−µ) = 0.24699 . . . < 0.2470."
- §9: "(1) we verify that the supposed unit distances are symbolically equal to one. (2) we verify that all congruence constraints (ieC) are
  valid. (3) we estimate the errors resulting from discrete approximation of the continuous (LP), in particular, ensure that the function
  W (t) of (19) is at least 1 for all non-negative arguments."

### 2.4 What the notebook actually does (read line by line), against H1–H6

| # | the notebook's step | its recorded output | reading |
|---|---|---|---|
| H1 | `DX = Table[Simplify[Abs[X〚i〛 - X〚j〛]], …]`; unit pairs where `DX〚i〛〚j〛 == 1` | 27 distinct distances; distance 1 occurs 47 times | **symbolic and sound** (a `Simplify` that failed to reduce would drop an edge — the conservative direction) |
| H2 | translate each set so its first point is 0, then `X1R = # / X1T〚2〛 & /@ X1T` (divide by the second point), and test `X1R − X2R == 0` or `X1R − Conjugate[X2R] == 0`; one-element sets dropped | `True` on 2,321 | **checks similarity, not congruence.** Dividing by the complex number `X1T〚2〛` normalises scale as well as rotation. For a two-point set both normalised sets are `{0, 1}`, so **every listed two-point "congruence" passes whatever its two distances are**, and for larger sets a scaled copy passes. The notebook never compares `|X1T〚2〛|` with `|X2T〚2〛|`. **A checker gap**: H2 is not established by the notebook; whether the certificate is nonetheless valid is a question about the data (Stage 3 checks it exactly). |
| H3 | loop over the 13,552 independent atoms (found by a loop over all `2²³` sign vectors), `Meps` = `V(ε)` in machine floats (`Import[path, "Data"]` reads the decimals as doubles) | "The value of maximal error: 6.71224 × 10⁻⁸"; "nu = 0.000001 works" | sound up to double rounding (~10⁻¹³ against a margin of ~9·10⁻⁷); **the notebook uses ν = 10⁻⁶, the paper ν = 10⁻⁵** (both valid; the paper's is looser) |
| H5 | `FindMaximum[BesselJ[0, t], {t, 1000}]` → `s0 = 999.811`; `w1 − 2 BesselJ[0, s0]` | 1.00892; `Abs[w0] + Total[Abs /@ w2]` = 1.93062 | sound given Watson §15.31 (decreasing extrema of `|J₀|`) and `d_min ≥ 0.1` over the pairs with `w2 ≠ 0` (asserted by the search's restriction, **not checked in the notebook**; Stage 3 checks it) |
| H4, `[1000, 10000]` | `Min[Table[fi[1000 + k], {k, 1, 9000}]]` (grid step 1), with "Derivative is less than 0.03" from `NMaximize[Abs[BesselJ[1, t]], t > 1000]` = 0.0252 | 1.03829 | |
| H4, `[100, 1000]` | grid step 0.1; "Derivative less than 0.1" from `max |J₁(t)|, t > 100` = 0.0771 | 1.01102 | |
| H4, `[0, 100]` | `FindMinimum` from 999 starts (it warns "lstol" and suppresses further warnings), then a grid of step 0.001 selects the 2,629 points with `fi < 0.99995 + 0.001`, and a grid of step 10⁻⁵ on the 2·0.001-wide interval around each; "Maximal total error" = `1 − Mmin + eps` | smallest minimum 0.99995 at 3.77488; **maximal total error 0.000059969 against μ = 0.00006** — a margin of **3.1·10⁻⁸** | |
| H4, the argument | the derivative bound used everywhere is **`|J₁| < 1`, the derivative of `J₀` alone**; but `W′(t) = −w0 J₁(t) − Σ w2(i,j) d_ij J₁(t d_ij)`, so a Lipschitz constant for `W` is `sup|J₁| · (|w0| + Σ|w2(i,j)| d_ij)`, not `sup|J₁|` | — | **a checker gap**: the step "min on a grid of spacing h, plus L·h" uses a Lipschitz constant that omits the chain-rule factors `d_ij` and the weights. And the evaluations are machine-precision `BesselJ` values, not interval enclosures, so "interval arithmetic" in the paper and notebook means *grid sampling plus a derivative bound*, not interval arithmetic. Whether the H4 conclusion survives with the correct constant is a question about the numbers (Stage 3 derives the constant exactly enough to decide it). |
| H6 | `(wT + nu) / (1 - mu)` | 0.246988 | with the paper's ν = 10⁻⁵ it is 0.2469974…; both < 0.2470 |

**So the certificate, if H1–H6 hold, proves exactly Theorem 1's statement, `m₁(ℝ²) ≤ 0.2470` (upper densities, measurable sets, via
periodic approximation), and nothing about non-measurable sets or `χ_f(ℝ²)`.** What a reader must trust even after the notebook runs:
Mathematica's `Simplify` for H1/H2 (exact, sound), its machine-precision `BesselJ` for H4/H5 (no enclosures), `FindMinimum`/`NMaximize`
for the derivative sups and `s0` (numerical), and — by the two gaps — **an argument the notebook does not contain for H2 and H4**.

## Stage 3 — SAVED: the run's price, and an independent re-check of the certificate

### 3.1 The authors' checker, unmodified: priced, not run

| item | price |
|---|---|
| what it needs | a Wolfram kernel **and front end**: the first cell is `SetDirectory[NotebookDirectory[]]`, which needs a notebook front end (from `wolframscript`, `UsingFrontEnd[NotebookEvaluate["verification23.nb"]]`); with a bare kernel that line fails, and the `Import["g23.csv"]` then depends on the launch directory. The notebook was produced by Mathematica 13.0.0 (Windows); a current Wolfram Engine is 14.x, so `FindMinimum`/`NMaximize`/`Simplify` may differ in their printed digits. |
| installed here | nothing (Stage 1 §1.3) |
| to install | the free Wolfram Engine for Developers (Linux x86-64; a download of about 1.5 GB) needs a Wolfram ID, online activation, and acceptance of its licence, whose terms are for development use — **whether an audit run falls under them is Kooshi's call, not mine**; or a paid Mathematica licence |
| runtime | **not documented** anywhere (paper, page, notebook). Estimate from the notebook's loops [reading, unmeasured]: the `2²³` loop that finds independent atoms (8.4 M iterations of `IntegerDigits`, a 23×47 dot and `FirstPosition`) ~1–3 min; the `V(ε)` loop (13,552 atoms × a 2,321-term `Sum` with two dot products per term) ~3–15 min; the float grids (~640 k evaluations of a 27-term `BesselJ` sum) ~1–3 min; the 529 `Simplify[Abs[…]]` distances and the 2,321 `Simplify`s of the congruence test — nested radicals, divisions by algebraic complex numbers — the uncertain part, minutes to over an hour. **Total ~15 min to ~2 h; memory well under 2 GiB.** |
| what running it would establish | that a current Mathematica reproduces the authors' recorded outputs (§2.4). **It would not close either checker gap** (§2.4): its congruence test would still prove only similarity, and its `W(t)` step would still use a Lipschitz constant that omits the chain-rule factors. |

### 3.2 An independent re-check (`tools/j26_ambrus_check.py`)

Exact arithmetic of seconds on the existing certificate, reading the shipped files directly (the 23 points from the notebook source's
`X = {…}` cell, the 2,350 coefficients from `g23.csv` as exact decimals) — in under the ban; **no search, no optimisation, the certificate
not re-derived**. Run: `python3 tools/j26_ambrus_check.py` (2.7 s, 0.8 GB, desktop; exit 0) → `data/pa-ambrus2023/j26-check.out`
(sha256 `58bf8dc2…`); `--self-test` → `data/pa-ambrus2023/j26-selftest.out`, "SELF-TEST OK: every plant fired its check".

| # | what the tool checks | grade | result |
|---|---|---|---|
| H1 | squared distances exactly in ℚ(√3, √11) | exact | **47 unit pairs, 27 distinct distances** — the notebook's numbers |
| H2 | for each of the 2,321 listed pairs `(I, J)`: equal sizes, distinct indices, `I ≠ J` as sets, and **every pairwise squared distance equal under the listed correspondence** (for planar point sets with a fixed correspondence this is congruence, reflections included) | exact | **0 failures of 2,321** (sizes: 22 one-point, 180 two-point, 666, 870, 446, 116, 20, 1 up to eight points). **So the notebook's similarity-only test is harmless for this certificate**: every listed pair is congruent, not merely similar. |
| H3 | the independent atoms (every independent set of the 23-vertex unit graph, by a complete recursion — the LP's variable set, whose extent the paper fixes) and `V(ε)` on each, exactly, by 64-bit dot products on 32-bit halves of the integer-scaled coefficients | exact | **13,552 atoms**; **min V(ε) = −671224377807/10¹⁹ = −6.712244·10⁻⁸ exactly** — the notebook's "6.71224 × 10⁻⁸"; ≥ −10⁻⁶ (the notebook's ν) and ≥ −10⁻⁵ (the paper's) |
| H5 | `d_min` over the 26 pairs with `w2 ≠ 0`, exactly (`d² ≥ 1/100` decided by sympy on the exact algebraic number); `s₀` (the largest zero of `J₁` below 1000) and `|J₀(s₀)|` by mpmath at 40 digits; the tail bound with the certificate's own `|w0| + Σ|w2|` | exact (`d_min`); 40-digit numerics, Watson §15.31 cited | `d_min = 0.21494 ≥ 0.1`; `s₀ = 999.811486934`, `|J₀(s₀)| = 0.0252337` (the notebook's); `|w0| + Σ|w2| = 1.930624`; tail bound **1.01067 > 1** |
| H4a | the notebook's grids re-evaluated with scipy's `j0` (cephes), independent of Mathematica | double precision, not interval | step-1 grid min 1.038294 (nb 1.03829); step-0.1 min 1.011020 (nb 1.01102); 2,629 selected points (nb 2629); fine min 0.999950031 (nb 0.99995 at 3.77488); `1 − min + 10⁻⁵` = 0.000059969 (nb 0.000059969) — **every recorded output reproduced** |
| H4b | Lipschitz constants of `W` with the chain rule: `L ≤ sup|J₁| · (|w0| + Σ|w2| d_ij)` on `[0, 100]`; on `t ≥ 100`, `|J₁(u)| ≤ C/√u` for `u ≥ 10` with `C = √10 · M₁(10) = 0.79937` (`M₁² = J₁² + Y₁²`; `x M₁(x)²` is decreasing for `ν = 1 > 1/2`, Watson §13.74, sampled on `[10, 10⁴]`), so `L ≤ C (|w0| + Σ|w2| √d_ij)/√t_min` | derived from the certificate; classical Bessel facts cited | `L[0,100] ≤ 1.5365`, `L[100,1000] ≤ 0.1773`, `L[1000,10000] ≤ 0.0561` — against the notebook's implicit "< 1", "< 0.1", "< 0.03" |
| H4c | **the covering**: every `t ∈ [0, 10000]` lies between two consecutive points `a < b` of the notebook's own evaluation grids (coarse, fine where it refined, and `t = 0`), and `W ≥ (W(a) + W(b))/2 − L (b − a)/2` there | double-precision values, derived constants | **min lower bound 0.999942348 ≥ 1 − μ = 0.99994** (worst interval `[3.77488, 3.77489]`, the minimum); a margin of 2.3·10⁻⁶ against double-precision `j0` errors near 10⁻¹⁶ |
| H6 | `(w_T + ν)/(1 − μ)` exactly | exact | ν = 10⁻⁶: 0.246988449; ν = 10⁻⁵: 0.246997449; both < 0.2470 |

**Plants** (each breaks one input and must fail its check; all fired): `coord` (vertex 2 moved by 1/100) → H1 (41 unit pairs, 49
distances) and H2, H3; `cong2` (a two-point pair `{1,4}` listed as congruent to `{1,2}`, which the notebook's similarity test passes, since
both normalise to `{0, 1}`) → H2 (and H3, the constraint being load-bearing); `cong_order` (two entries of a three-point `J` swapped) → H2
alone; `wT` (`w_T` lowered by 10⁻⁶) → H3, with the two-sided bound `0 < min V_guarded − min V_planted ≤ 10⁻⁶` asserted; `w2scale` (every
`w2` doubled) → H4 (`L[0,100] ≤ 2.85 > 2`), and H3, H5.

**What the re-check establishes** [tools: exact for H1–H3, H6 and `d_min`; measured for H4 — two independent double-precision Bessel
implementations agree, not interval-certified; H5 and H4b rest on Watson §13.74 and §15.31, cited]: **the certificate `(X₂₃, g23.csv)`
satisfies Proposition 1's hypotheses with ν = 10⁻⁶ and μ = 6·10⁻⁵, so `m₁(ℝ²) ≤ 0.246989 < 0.2470`**, given Proposition 1 and the paper's
§2–§6 (hand; read and found sound) — and it does so **with arguments the authors' notebook lacks** for H2 (congruence, not similarity) and
H4 (a Lipschitz constant with the chain rule). The one step still taken on numerical trust is the value of `J₀` at about 640,000 points in
double precision, with a margin of 2.3·10⁻⁶ at the worst; a certified version would evaluate the same points with ball arithmetic (arb,
via `python-flint`, not installed — an install request, not made).
