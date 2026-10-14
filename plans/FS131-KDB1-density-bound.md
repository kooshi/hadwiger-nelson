# FS131-KDB1 — the density bound `m₁(ℝ²) ≤ 0.2470`, planned for the kernel to its leaves and priced

*de Bruijn, the planner (Opus 5.5), 2026-10-14. Brief: `data/fs131/briefs/FS131-KDB1-density-bound.md` (with `plans/STANDING-RULES.md`).
Branch `fs131-wdb`, tree `.claude/worktrees/fs131-w10g`. Resuming: read this file and the brief, check the last SAVED stage against
`git log -- plans/FS131-KDB1-density-bound.md`, and continue at the first stage not SAVED.*

## Theorems this phase proved

None. A planning job: the statements are typed with `sorry` at their leaves, and the first leaves written for pricing are scratch
(`data/fs131/kdb1/`), not library theorems.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, against their sources (standing rule 3)

Checked mechanically (every `> ` line of the brief searched verbatim in its named source):

| # | the brief quotes | source | verdict |
|---|---|---|---|
| Q1 | W2 (2026-10-13) "I choose the second form. Any finding of ours must be formalized. …" | `data/fs131/REQUEST-2026-10-13.md` line 4 | verbatim |
| Q2 | item 818 (FS131-KR1's classical input; the rulings) | `plans/FS131-close-inventory.md` line 9255 | verbatim |
| Q3 | item 823 (FS131-KR1 handed back) | same file, line 9260 | verbatim |
| Q4 | item 828 (Kooshi's answers, W6) | same file, line 9265 | verbatim |
| Q5 | "Yes, prove the density bound." (inside Q4) | `data/fs131/REQUEST-2026-10-13.md` W6, line 26 | verbatim |
| Q6 | Theorem 1: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." (inside Q2) | the paper, held v3, p. 4 | verbatim |

No mismatch.

### 1.2 The first commit

`git checkout fs131-wkr -- Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean` (branch `fs131-wkr` at `3fabd5e10`); `git diff fs131-wkr
-- <path>` is empty (text unchanged); its import line after `Plane.Suprema` in `Proofs.lean` and its `ARCHITECTURE.md` row copied
verbatim from `fs131-wkr`; `tools/check_architecture.py` PASS. Build: `scripts/slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh` — **exit 0**, 249 batches, 2 modules rebuilt (the new module 1.0 s, and `Proofs`), 7 m 35 s; the one warning is the
module's own leaf (`OneAvoidingDensity.lean:54:8: declaration uses sorry`, `upperDensity_le_of_oneAvoidingDensityBound`). Log:
`data/fs131/kdb1/build1.log`. Commit `affb9142e`.

### 1.3 The statement, read aloud against the paper

`Plane.OneAvoidingDensityBound` (`Plane/OneAvoidingDensity.lean`, line 33):

```
∀ A : Set (EuclideanSpace ℝ (Fin 2)), NullMeasurableSet A volume → (∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) →
  ∀ x : EuclideanSpace ℝ (Fin 2),
    limsup (fun R : ℝ => volume (A ∩ ball x R) / volume (ball x R)) atTop ≤ ENNReal.ofReal 0.2470
```

| the paper (p. 2, eq. (1); p. 4) | the Lean | reading |
|---|---|---|
| "Lebesgue measurable" | `NullMeasurableSet A volume` | the completion of Borel for `volume` — exactly Lebesgue measurability |
| "1-avoiding": "independent in the unit distance graph" (p. 2) | `∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1` | the same; `a = b` gives `dist = 0 ≠ 1`, no exclusion needed |
| "planar set", `λ₂` | `EuclideanSpace ℝ (Fin 2)` with `volume` | Lebesgue measure on ℝ² |
| `δ(A) = lim sup_{R→∞} λ_d(A ∩ B_d(x,R))/λ_d(B_d(x,R))`, "where x is fixed"; "independent of the choice of x" | `∀ x, limsup … atTop` | the paper fixes one `x` and asserts independence; the Lean states it at every `x` — equal in truth (KR1's reading, item 823, confirmed); stronger in form, so a proof must work at an arbitrary centre (ours does: § 2) |
| `B_d(x,R)` "the ball of radius R centred at x" | `ball x R` (open) | open and closed balls differ by a null circle |
| "at most 0.2470" | `≤ ENNReal.ofReal 0.2470` | the real literal `0.2470 = 247/1000`; the ratio is an `ENNReal` (`0/0 = 0` for `R ≤ 0`, irrelevant along `atTop`) |

**No domain is empty**: the module's own `oneAvoidingDensityBound_model` (the open ball of radius `1/2`) inhabits the hypotheses; the
proof (§ 2) uses no hypothesis beyond the three. Not vacuous, not weaker than the page. **The proof target:** a theorem
`Plane.oneAvoidingDensityBound : OneAvoidingDensityBound` in a new module downstream of the parts (§ 3), the statement unchanged.

### 1.4 The paper's proof, as a chain of steps (held v3, read in full this job: §§ 1–9 and Tables 1–2; the certificate files as J26 found them)

| step | page | what it states | what it reads |
|---|---|---|---|
| P1 — periodic reduction | p. 5, §2 | "m₁(ℝ²) may be approximated arbitrarily well by densities of 1-avoiding, measurable, periodic sets [deOV10, KeMOR16]" | the upper density (p. 2); cited, not proved in the paper |
| P2 — autocorrelation | p. 5, eqs. (2), (3) | `f(x) = δ(A ∩ (A − x))`; `δ(A) = f(0)`; `f(x) = 0` for unit `x` | P1's periodicity (the density exists) |
| P3 — Lemma 1 (atoms) | pp. 5–6, eqs. (5), (6) | `a_X(ε) = δ(⋂(A − x_i)^{ε_i})`; (ieP) `≥ 0`, (ieI) `= 0` on non-independent atoms, (ieT) total 1, (ie1) `Σ_{σ(n;i)} = f(0)`, (ie2) `Σ_{σ(n;i,j)} = f(x_i − x_j)` | translation invariance of the density |
| P4 — O(2) averaging | pp. 8–9, eqs. (12), (13), (ieC) | `å_X`, `f̊` radial; congruent index sets give equal averaged sums (reflections included, so O(2), not SO(2)) | P3; Haar measure on O(2) |
| P5 — Fourier side | pp. 10–11, eqs. (14)–(17) | Fourier series on `ℝ²/L`: `f̂(u) = |1̂_A(u)|² ≥ 0` (Parseval); `f̊(x) = Σ_t κ(t) Ω₂(t|x|)`, `κ ≥ 0`, `Σκ = δ(A)`; `Ω₂ = J₀` (Schoenberg, p. 17) | P1 (the torus) |
| P6 — Proposition 1 (weak duality) | pp. 13–14, eqs. (19)–(21) | if `W(t) ≥ 1` on `[0, ∞)` and `V(ε) ≥ 0` for every `ε`, then `m₁(ℝ²) ≤ w_T`; only independent atoms need `V ≥ 0` (p. 14) | P2–P5 |
| P7 — the certificate | pp. 15–19, 23–24 | `X₂₃` (Table 1), `w` (Table 2 and [Web], 2,350 coefficients); `V ≥ −ν`, `ν = 10⁻⁵`; `ϕ(t) ≥ 1 − µ` on `[0, 10⁴]`, `µ = 6·10⁻⁵`, by "interval arithmetic"; the tail `t > 10⁴` by (23)–(24) with Watson §7.21 and §15.31; `m₁ ≤ (w_T + ν)/(1 − µ) = 0.24699… < 0.2470` | P6; the classical Bessel facts cited |
| P8 — symbolic checks | pp. 19–20, §9 | unit distances symbolically 1; congruences valid | exact algebra in the Moser ring |

What this project already holds on P7–P8 (read, not re-derived): J26 (`plans/PA-ambrus2023-audit.md`) — H1 47 unit pairs, H2 all 2,321
congruences exact (the notebook's own test proved only similarity), H3 13,552 atoms with `min V = −6.712244·10⁻⁸` exactly, H6
`(w_T + 10⁻⁶)/(1 − 6·10⁻⁵) = 0.246988449 < 0.2470`, `d_min = 0.21494` over the 26 `w₂` pairs; J49 (`plans/FS100-KT1-ambrus-ball.md`) — H4
on `[0, 10⁴]` in arb at 80 bits on J26's 493,471-point covering, margin `2.348·10⁻⁶`, H5 (tail) `1.0107 > 1`, both resting on Watson
§13.74 and §15.31 by citation. The paper's eq. (23) typo `w₁(4)` for `w₁(1)` (J26).
