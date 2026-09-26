# FS-100 ×2×3 crunch, job X01D — route (A): does Einsiedler–Fish transfer to `U` acting on `R̂`?

*de Bruijn (Opus 5.5), 2026-09-26, from the brief `data/crunch-2026-09-26-x2x3/briefs/X01D-einsiedler-fish-derivation.md` (with its two
addenda) and `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md`. The product owner is "main". A blind verifier, X01V, works the same
claims; no contact. Working files: `data/fs100/x01d/`. Exact checks: `tools/x01d_*.py`.*

## Theorems this phase proved

*(one line each, grade per `CLAUDE.md` § Notation; filled in as stages land)*

- (stage 1: none — reading and priors only)

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
