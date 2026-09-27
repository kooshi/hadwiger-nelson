# Poros — advisor record, FS-105 (harden MR), job FS105-A

*Opus 5.5, 2026-09-26. Brief: `data/fs105/briefs/A105-advisor.md` + `data/fs105/briefs/STANDING-RULES.md`. Planner: de Bruijn, FS105-P
(agent a244e9774c10277da). Record path per brief. Stages SAVED in order; a successor resumes at the first stage not SAVED.*

## Theorems this phase proved

*(none yet — an advisor proves nothing by default; any hand fact used in advice is listed here with its grade)*

## Stage 1 — SAVED: the expectation, written before the planner's drafts

**Honesty note on timing.** Written after reading: the two briefs, the standing rules, `plans/STUB-harden-mr.md`, `LEDGER.md` rows 118,
120, 128–130 (and 116's head). Written **before** reading any FS-100 record (X01D, X01V, X02D, X02V, X12B, FS100-derivation §3), EL2021,
or the planner's `plans/FS105-harden-mr.md`. One planner message arrived before this was written (its §G bears list, with a G50 instance:
"EL2021 does not prove Thm 1.2 as stated; p. 2 says it was 'already proven in the announcement [7]' … EL2021 proves Thm 1.3"). That
message informs the PE-2 line below and is marked where it does.

**Quotation check (standing rule 5).** Every quoted statement in my brief and the stub checked against `LEDGER.md` row 120 and 129 on disk:
MR's statement, its grade, "only under admissibility — every finite-index subgroup of `Γ` spans `L`", EF_F⁺'s parenthesis, and "any proof
that `α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087)" — all verbatim. My brief's parenthesis "(MR at ℚ(√635087) forces `α₁(ℝ²) = m₁(ℝ²)`)" is
the owner's paraphrase, not a quotation, and it is right in content (row 129: "At ℚ(√635087), given MR there: `α₁(ℝ²) = m₁(ℝ²)`").

### Where MR most likely breaks — probabilities (my prior, registered; P = probability the step, as used, is FALSE or has a GAP that the
hardening cannot close with held tools)

| step | P(break) | why, in one or two lines | the likeliest failure's shape |
|---|---|---|---|
| **PE-2's use of EL Thm 1.2** — admissibility, the f.g. pieces `M̂`, passage to `U` | **0.08** | The passage to `U` is clean by my own sketch (below): the Haar weight `a_n` is constant up the chain because Haar is `Γ_n`-ergodic with positive entropy and zero-entropy measures project to zero-entropy measures. Admissibility is inherited upward and an admissible `Γ₀` exists since `ℚ(U) = K` (shown below). Residual risk is in the *statement* used: [informed by the planner's message] Thm 1.2 is EL2003's announcement, unheld; the route through EL2021 Thm 1.3 needs a deduction nobody has written. | a hypothesis of the theorem not in row 120's list (ergodicity under the `ℤ^d` action, not `Γ`; torsion in `Γ`; "no virtually cyclic factor" at an S-adic prime) — met by construction but unwritten, so GAP-by-omission, closable |
| **EF_F⁺** — Einsiedler–Fish's pigeonhole through the product formula | **0.25** | The only step not in print, and the one whose checker (X01V) went GAP blind and withdrew after seeing the answer — the selection shape G21 names. Three places the transfer from `𝕋` can fail: (i) zero entropy of one `u` controls local dimension only along `u`'s own expanding primes, while the pigeonhole needs covering numbers of `τ` in a neighbourhood of 0 that constrains many primes at once (EF on `𝕋` has one expanding direction and it is everything); (ii) the archimedean coordinates are isometric under `U`, so "`(u−u′)x ≈ 0`" needs the arch part small by a separate device (my guess: the multipliers from `U_ℚ` act by ONE angle on all `2d` real coordinates, so a 1-D pigeonhole on the angle suffices); (iii) scale consistency — the torsion point found at scale `N` must be the one found at `N′`, which needs the approximation error below the separation of bounded-order torsion points, a Diophantine bound at infinitely many places | (i): the proof uses zero entropy of one `u` where it needs joint zero dimension over finitely many primes (a product-structure theorem, Einsiedler–Katok type, unstated) — GAP, probably closable with PE-2's all-`u` zero entropy |
| **degree 16** (de Grey's field; `K` of degree 32) | **0.07** | If EF_F⁺ uses `U_ℚ` multipliers, the arch pigeonhole is one-dimensional and the degree enters only the height normalisation (`c·M^{1/16}`) and kernel sizes `\|R/tR\|`; with zero entropy the pigeonhole beats any fixed power, so degree should not matter. Admissibility at degree 32 is generic. | a step that silently assumes `ℚ[Γ] = K` while building `Γ` from `U_ℚ ⊂ ℚ(i)` (which spans only `ℚ(i)` — NOT admissible); or an exponent inequality that holds at `d = 2` and fails at `d = 16` |
| **the scope `R_F = O′`** | **0.05** | Both FS-105 fields are wall-broken ⇒ no stable dyadic place ⇒ row 100's Lemma C applies. The residual is the "every real number field" clause used by row 123: non-totally-real `F` (arch places where `\|u\|_v ≠ 1`), where EF-G (a) already failed once. | a consumer (row 123) applying MR at a non-totally-real field where EF_F⁺'s arch bookkeeping was only done for CM `K` |

**Joint:** P(MR, as row 120 states it, survives FS-105 with no named gap) ≈ **0.62**; P(some named GAP) ≈ 0.30; P(FALSE with a counterexample)
≈ 0.08. P(the blind third EF_F⁺ derivation *reports* GAP, real or not) ≈ **0.40**; P(that GAP survives the owner's check as real) ≈ 0.20.

**My sketch of PE-2's passage to `U`** (hand, one mind, for the planner to compare — not a claim): take `μ` `U`-ergodic with `h_μ(u) > 0`,
a chain `Γ_n ↑ U` of admissible f.g. groups containing `u`, `M_n ↑ R` f.g. `ℤ[Γ_n]`-modules. Thm 1.2 on `M̂_n` gives
`π_n μ = a_n m_n + ν_n`, `ν_n` of zero entropy for all of `Γ_n`. Projecting level `n+1` to `n`: `π_n μ = a_{n+1} m_n + proj ν_{n+1}`, and
`proj ν_{n+1}` has zero entropy for `Γ_n` (factor entropy ≤ entropy), so it has no Haar component (Haar has `h(u) = Σ_v log⁺|u|_v > 0` for
non-torsion `u`: `|u|_v ≠ 1` only at primes inverted in `ℤ[Γ_n]`); uniqueness of the ergodic decomposition gives `a_n = a_{n+1} = a > 0`.
The `ν_n` form a projective system, so `ν` exists on `R̂`, `U`-invariant (as `μ − a m`), of zero entropy (inverse-limit entropy is the sup);
`μ` ergodic forces `μ = m`. **Why admissible `Γ` exist:** `ℚ(U) = K` — with `z = a + i`, `u = z/z̄` has real part `(a²−1)/(a²+1)` and
`(u − ū)/2 = 2ai/(a²+1)`, so `i` and then all of `F` lie in `ℚ(U)`; admissibility passes to supergroups (`Γ′ ∩ Γ₀` has finite index in
`Γ₀`).

### Row 129's finite-graph test: real risk or free consistency check? — my expectation

**Neither, exactly; closer to "free" as a refutation route, and "real" as a prediction.** (1) A refutation needs a *proof* that
`α₁(ℝ²) > m₁(ℝ²)`: a lower bound on the independence ratio of every finite unit-distance graph above the true `m₁` (≤ 0.2470 in print).
The only known universal lower bound on `α₁` is `α₁ ≥ m₁` itself (average a measurable avoiding set over a graph's congruent copies), so a
refutation needs a new kind of argument — in effect a non-measurable fractional colouring of the plane beating every measurable one.
Nothing held or in print comes near; P(refuted within FS-105) < 0.01. (2) But the implication is not free: it runs through
`α₁(F²) = α_loc(F)` at ℚ(√635087), which is where MR's content lives — an `R ⋊ U`-invariant random independent set of `F²` denser than
`max(m₁, sup_v r_v)` would be built from windows reading the real place and finite places *jointly*, on a Cayley graph whose connection set
is the **diagonal** `{(u, ι_v(u))}`, a subgraph of the categorical product — so Zhang's "max" for products does not apply directly. The
test is therefore the same question as MR's zero-entropy half, asked through independent sets. (3) As a *prediction* it is live and
already scored once in print, I expect: MR ⟹ finite UD graphs with independence ratio below 1/4 (χ_f > 4), against the 2023–2025
expectation that Moser-lattice graphs pin 1/4. If `[DuczVarga2026]` exhibits χ_f > 4 by finite graphs, that is a met prediction; if the
literature has a *proof* that χ_f of finite UD graphs is ≤ 4, MR falls. To be checked in stage 2 (bibliography read, no search).

### Hunch ledger

```markdown
hunch: ef-transfer-is-the-weak-step
  claim: of MR's four soft places, EF_F⁺ is the one most likely to carry a real GAP
  basis: prior
  falsifier: the blind third derivation and a careful reading of X01D/X12B both TRUE with every place-by-place bound written, and PE-2 or degree 16 failing instead
  registered: 2026-09-26
  status: open

hunch: x01v-withdrawal-is-selection
  claim: X01V's blind GAP was withdrawn because the answer was seen, not because the GAP was closed by an argument X01V could state blind
  basis: analogy
  falsifier: X01V §4 names the step its GAP was at and the argument that closes it, and that argument uses nothing from X01D beyond a lemma X01V could have derived
  registered: 2026-09-26
  status: open

hunch: one-u-zero-entropy-overreach
  claim: EF_F⁺ as written uses zero entropy of ONE u where the pigeonhole needs zero dimension over several primes; MR is rescued because PE-2 supplies zero entropy for EVERY u
  basis: derived (from the geometry: u expands only at its own non-stable primes)
  falsifier: the EF_F⁺ derivation controls every prime its neighbourhoods touch using only one u's entropy, correctly
  registered: 2026-09-26
  status: open

hunch: uq-multipliers-not-admissible
  claim: EF_F⁺'s multipliers U_ℚ span only ℚ(i), so any step that feeds them to EL Thm 1.2 would fail admissibility; the two halves must use different groups
  basis: derived
  falsifier: the records use U_ℚ only in EF_F⁺ and an admissible Γ in PE-2
  registered: 2026-09-26
  status: open
```

### Would have searched here

- nothing yet.
