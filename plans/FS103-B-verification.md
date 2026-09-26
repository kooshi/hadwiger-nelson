# FS103-B — blind verification of the fractional shadow (FS103-F's claims)

*Job FS103-B, Opus 5.5, 2026-09-26. Verifier ("Coxeter" seat). Blind to `plans/FS103-F-fractional-shadow.md` and every fenced file until
stage 3 is committed. Claims: `data/fs103/claims-f2.md` (statements only). Brief: `data/fs103/briefs/B103-fractional-blind-check.md`.*

## Theorems this phase proved

*(filled per stage; grades per `CLAUDE.md` § Notation; "one mind" = this job, blind)*

| id | statement (one line) | grade | where |
|---|---|---|---|

## Stage 1 — SAVED (quotation check; controls written before deriving)

### 1.1 Quotation check (standing rule 5)

| quoted text (where it appears) | source | result |
|---|---|---|
| claims-f2 §"Definitions" and §"The claims" (FS103-F §2.3 and its theorem table) | `plans/FS103-F-fractional-shadow.md` — **fenced** | not checkable until stage 4; checked there |
| "MR(F): `LEDGER.md` row 120, verbatim there" (claims-f2 Known inputs) | row 120; `data/fs103/claims.md` D-MR | matches word for word |
| D-SP "a finite positive `U`-invariant Borel measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0`" | `plans/FS100-BC-verification.md` l.72 | matches |
| "`m₁(ℝ²) ≤ 0.246989` (`[AmbrusEtAl2023]` Thm 1; row 92)" | row 92 | matches ("its certificate re-checked here … `m₁(ℝ²) ≤ 0.246989`") |
| "Croft's `m₁ ≥ 0.22936` (`BIBLIOGRAPHY.md` `[Croft1967]`)" | BIBLIOGRAPHY l.706; `[DuczVarga2026]` §2.1 "δCroft = 0.22936 . . ."; `[MatolcsiEtAl2025]` (13) "1/δCroft = 4.35987..." | matches; Croft's paper itself unheld, unread (the value is by statement, via two held papers) |
| brief: "`χ_f(K²) = 4` (G60)" | `CLAUDE.md` G60 "instance: χ_f(K²) = 4" | matches |
| brief: "the first clause of a conjecture published in 2026 (`[DuczVarga2026]`, Conjecture 1)" | `[DuczVarga2026]` §2.1, p. 3 (held copy `library/pdf/arXiv-2606.28157-ducz-varga-…pdf`): "**Conjecture 1.** f (n)/n = m1 (R2 ) + o(1) / and in particular that m1 (R2 ) = δCroft ." | matches; the conjecture has two clauses joined by "and in particular" (the second does not follow from the first); "first clause" = `f(n)/n = m₁(ℝ²) + o(1)`. `f(n)` is their §1: "the minimum possible independence number of a unit-distance graph arising from n points in the plane" |
| claims-f2 FS103-F-DV "`χ_f,0(ℝ²) = χ_f(ℝ²)`" | `[MatolcsiEtAl2025]` §2 p. 4–5: "χf,0 (R2 ) := sup{χf (G) : G ⊆ R2 , G is finite}. It is clear that χf,0 (R2 ) ≤ χf (R2 ), but it is not known whether equality holds"; `χ_f(ℝ²)` there = inf over fractional colourings of the whole plane | the notation is MRVZ's (not DV's; DV do not use `χ_f,0`); the claim's middle equality is therefore a claim about the *whole-plane* number, checked at stage 3 |
| claims-f2's `α₁(F²)` | MRVZ p. 5: "α1 (R2 ) = inf{α1 (G) : G ⊆ R2 , G is finite}" | the claim's definition is MRVZ's with `F²` for `ℝ²` |
| "31's `1/4 − 2.745·10⁻⁶`" (claims-f2 FS103-F-47) | row 117 "the Hoffman table (31's `1/4 − 2.745·10⁻⁶` the largest)"; G54 | matches; re-computed exactly at stage 3 |
| "X25B-L1" (claims-f2 definition of `r_v`) | `plans/FS100-X25B-derivation.md` l.72 "X25B-L1 (the profinite reduction)" | exists; its statement is the profinite reduction, not the Weil/level bound `X26B-L1` that row 123 quotes (two different lemmas with near-identical names — noted, not an error) |

### 1.2 Controls, written before deriving (each: what must come out; what a wrong-reason pass looks like)

- **K = ℚ(√3, √11)** (G60: `χ_f(K²) = 4`). K's two dyadic places have `K_v = ℚ₂(√3) ∌ i`, stable, `L_w/K_v` unramified (inert), target
  `U₂ = Cay(𝔽₄, μ₃) = K₄`, ratio `1/4` at every level (the 2-adic tower is tight, row 67). So any correct FRAC must give `ρ(K) = 1/4`, attained by
  the dyadic pullback, **not** by `m₁`. *Wrong-reason pass:* a chain that bounds the density by `m₁ < 1/4` (dropping the tight place), or whose
  product step needs every factor `< 1/4` — it would "prove" `χ_f(K²) > 4`, contradicting Theorem B. *Where the chain must stop:* nowhere; it must
  reproduce `1/4` exactly.
- **ℚ(√3).** Triangles give `α_inv ≤ 1/3`; the three-colouring gives `≥ 1/3`. The place above 3 (ramified, residue `𝔽₃`, `Γ₃`, ratio `3/9`) must
  give `ρ = 1/3`. *Wrong-reason pass:* `ρ` computed from `m₁` or from the dyadic `1/4`.
- **ℚ(√11).** Stable 7 (`(11/7) = 1`), `Γ₇` ratio `2/7`. FRAC must give `ρ ≥ 2/7`, so `χ_f(ℚ(√11)²) = 7/2` given MR; G60's unconditional ceiling
  (`χ_f(F²) ≤ χ_f(Γ₇) = 3.5`) is the independent check of the direction `ρ ≥ ` truth. *Wrong-reason pass:* a `ρ` below `2/7` (would contradict the
  pullback from `Γ₇`, which exists unconditionally).
- **Arithmetic-free `Cay(ℝ, {±1, ±√2})`** on `Λ = ℤ + ℤ√2 ≅ ℤ²`: here "`E`" is `T + A` (torsion plus `x ↦ e(ξx)`), there is no `U` and no MR; the
  Kronecker sets `{x : {βx} ∈ [0, 1/2 − ε)}` with `{β}, {β√2}` near `1/2` show the measurable ratio of `ℝ` is `1/2`, and the parity set shows
  `α_inv(Λ) = 1/2`. The chain's non-arithmetic steps (the `E`-factor, the per-class positivity trick, extension, product count) must run
  unchanged and give nothing false; the MR step has no analogue (off-`E` invariant measures that are not Haar abound — a point mass at a generic
  `θ ∉ T + A`), so only the unconditional clause survives, vacuously (`ρ = 1/2`). *Wrong-reason pass:* any step of FRAC that silently uses
  arithmetic (strong approximation, R-U, weak approximation of the torus) but is labelled generic would be exposed here as unjustified.

### 1.3 Would-have-searched-here log

- None at stage 1.
