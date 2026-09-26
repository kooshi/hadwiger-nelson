# FS-100, ×2×3 crunch, job X01V — blind verification of route (A), Einsiedler–Fish

*Coxeter (Opus 5.5), blind verifier. Brief: `data/crunch-2026-09-26-x2x3/briefs/X01V-einsiedler-fish-verifier.md`, with
`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md`. Fences kept: nothing of X01D, the advisor's record or the advisor's directory was
opened except `data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf`'s text `ef.txt`; §6 of the queue plan was not read.*

## Theorems this phase proved

*(filled at each stage; grades as in `CLAUDE.md` § Notation)*

## Stage 1 — SAVED (quotation check, the claim list, the paper's theorem, C0)

### 1.1 The claim list, copied verbatim from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2

**Notation** (from `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`, verbatim): "`F ⊆ ℝ` a real number field, `L = F(i)`,
`U = U_F` the unit vectors (norm-one elements of `L/F`), `R = ℤ[U]`, `R̂` its dual; `T` the torsion characters, `A(R_F)` the archimedean ones,
`E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split places) — `LEDGER.md` rows 98, 113." Added here: `U` acts on
`R̂` by `(u·χ)(x) = χ(ux)`; `m` is Haar probability on `R̂`; `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`; for `u ∈ U`,
`H(u) = ∏_w max(1, |u|_w)` over the finite places `w` of `L` (normalised absolute values); `U_N = {u ∈ U : H(u) ≤ N}`.

### List X01 — route (A), Einsiedler–Fish (X01D derives, X01V verifies blind)

- **EF-G.** "For every real number field `F`: (a) `h_m(u) = log H(u)` for every `u ∈ U`; (b) `liminf_{N→∞} log #U_N / log N > 0`."
- **EF_F** [Poros's target, P-1]. "For every real number field `F`: every `U`-invariant, `U`-ergodic probability measure `μ` on `R̂` such that
  `h_μ(u) = 0` for some non-torsion `u ∈ U` satisfies `μ(E) = 1`."
- **EF-MR.** "PE-2 (list X02) and EF_F together imply MR(F) for every real number field `F`; over ℚ(√47), with SP-Cor and T-C(A) at `S = ∅`,
  they imply `χ(ℚ(√47)²) = 5`."
- **EF-X** (a control; the conclusion's shape). "Over `F = ℚ` there is a `U`-invariant, `U`-ergodic probability measure on `R̂` with
  `h_μ(u) = 0` for every `u ∈ U` that is not finitely supported; so EF_F's conclusion cannot be strengthened to finite support."

The input to quote from the paper itself (a reading item, not a claim): Einsiedler–Fish, *Rigidity of measures invariant under the action of
a multiplicative semigroup of polynomial growth on 𝕋*, Ergodic Theory Dynam. Systems 30 (2010) 151–157, Zbl 1189.37005 — its main theorem,
verbatim, with its hypotheses.


PE-2, which EF-MR names (list X02, same section, verbatim):
- **PE-2** (PE-lim). "For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`: `τ = a·m + τ′` with
  `a ≥ 0`, `τ′` a `U`-invariant finite positive measure, and `h_{τ′}(u) = 0` for every `u ∈ U`."

### 1.2 Quotation check (standing rule 5)

| quotation in the brief | source | result |
|---|---|---|
| MR(F): "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure" (J38 §3.5, T-J38-2 (iii)) | `plans/STUB-measure-rigidity-three-fields.md` line 58 | **matches**, verbatim |
| Einsiedler–Fish, ETDS 30 (2010) 151–157, Zbl 1189.37005; arXiv 0804.3586 | zbMATH API record `an:1189.37005` (title, authors, pages 151–157, ETDS); `ef.txt` header "arXiv:0804.3586v2 [math.DS] 4 Sep 2008" | **matches** |
| "prove rigidity for multiplier semigroups of polynomial growth on 𝕋" | EF Thm 1.2 (quoted in 1.3) | **matches** in substance (a paraphrase in the brief; the theorem itself is quoted below) |
| the list X01 and PE-2 | queue plan §2, copied in 1.1 by `sed` from the file, not retyped | **verbatim by construction** |
| SP-Cor's statement at `plans/FS84-SI-D-derivation.md` §4.2 | §4.2, "Corollary SP-Cor": "Over ℚ(√47): if every finite positive `U`-invariant measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`." [hand; given T-C(A) at `S = ∅`] | **exists, as addressed**; note it concludes `≥ 5`, not `= 5` (used in stage 2 on EF-MR) |
| "EL2021 §1 (`data/fs100/j51/el2021.pdf`)" | that path does not exist | **wrong address**; the owner's correction (message, 05:5x): `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (commit 8e941a76) |

### 1.3 The paper's main theorem, verbatim (`ef.txt`, p. 1)

> "**Theorem 1.2.** Let α > 0 and let Σ ⊂ N be a multiplicative semigroup with
> (1.1) lim inf_{N→∞} #(Σ ∩ [1, N]) / N^α > 0.
> Let µ be an ergodic Σ-invariant Borel probability measure on T = R/Z. Then either µ is supported on a finite number of points or µ is
> Lebesgue measure."

The proof's parts, as the paper states them (verbatim):
- Lemma 3.1: "In the setting of Theorem 1.2, if hµ(Tp) = 0 for some p ∈ Σ, then for any ε > 0 and any β > 0, there exist δ0 > 0 and X′ ⊂ T of
  measure µ(X′) > 1 − ε, such that for every positive δ ≤ δ0 and every x ∈ X′, µ(Bδ(x)) > δ^β".
- Lemma 3.2: "Under the assumptions of Theorem 1.2, if hµ(Tp) = 0 for some p ∈ Σ, then the measure µ has finite support."
- Positive entropy: Johnson's theorem (Theorem 2.2): "If Σ is a nonlacunary multiplicative semigroup of integers whose action on T as
  multiplication (mod 1) has an ergodic invariant Borel probability measure µ, then either µ is Lebesgue measure or the entropy of each map Tn,
  n ∈ Σ, has µ-entropy zero."
- "Theorem 1.2 follows from A.Johnson theorem cited in Section 2 combined with Lemma 3.2."

**Reading status (G50):** EF §§1–4 read in full, from `ef.txt` (the arXiv v2 text; the journal version not compared). Johnson 1992 and
Rudolph 1990 not read (cited by EF; not needed below). **Bibliography:** no `BIBLIOGRAPHY.md` entry for arXiv 0804.3586 or Zbl 1189.37005
(grepped); not in `~/source/library/pdf/` (grepped "einsiedler", "fish"); proposed row in stage 3.

### 1.4 C0 — probabilities before any derivation (written after reading EF once)

| claim | P(TRUE as stated) | the reason, one line |
|---|---|---|
| EF-G (a) | 0.35 | the Lind–Ward/Yuzvinskii entropy of an automorphism of a solenoid sums over the archimedean places too; `H` omits them, which is right only if `\|u\|_w = 1` at every archimedean place — true for totally real `F`, doubtful for a real `F` with a complex place |
| EF-G (b) | 0.85 | one element per split prime of degree one already gives `#U_N ≫ N^{1/h}/log N` |
| EF_F | 0.10 (GAP 0.70, FALSE 0.20) | EF Lemma 3.2 needs every multiplier to expand the one direction where the ball is thin; each `u ∈ U` expands only its own split places, and the archimedean directions are isometric for all of `U` |
| EF-MR | 0.85 | a composition; the risks are measurability of `E` and entropy's affinity over the ergodic decomposition, and `= 5` needs the upper bound too |
| EF-X | 0.90 | Haar measure on a circle of archimedean characters is rotated by `U` |

### 1.5 Would-have-searched-here log

- (none at stage 1)
