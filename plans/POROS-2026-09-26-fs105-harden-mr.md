# Poros — advisor record, FS-105 (harden MR), job FS105-A

*Opus 5.5, 2026-09-26. Brief: `data/fs105/briefs/A105-advisor.md` + `data/fs105/briefs/STANDING-RULES.md`. Planner: de Bruijn, FS105-P
(agent a244e9774c10277da). Record path per brief. Stages SAVED in order; a successor resumes at the first stage not SAVED.*

## Theorems this phase proved

- **PE-2's passage to `U` is clean given Thm 1.2 on the pieces** (the Haar weight is constant up the chain; `ν = μ − a·m` exists on `R̂` by
  Kolmogorov and is `U`-invariant of zero entropy) — [hand, one mind, a sketch for comparison], §Stage 1.
- **EL2021 Thm 1.3 ⟹ Thm 1.2** for totally irreducible, not virtually cyclic actions, given "virtually cyclic factor" read as *non-trivial*
  factor — [hand, one mind], §2.2.
- **X12B §2.2 (EF_F⁺'s core lemma) checked step by step: no failing line** — [checking reading, one mind, NOT blind; adds a reading, not a
  derivation], §2.1.

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

## Stage 2 — SAVED: readings against the stage-1 expectation, and the advice

**Read (against stage 1's expectations):** `plans/FS100-X01V-verification.md` §1.3, §1.4, §2.3–2.4, §4 (in full); `plans/FS100-X12B-derivation.md`
§1.2, fence log, §2.2–2.4 (in full); EL2021 pp. 1–4 (Thms 1.2, 1.3, definitions; `pdftotext`, scratch only); `data/fs105/claims.md` (the
planner's draft, stage 5); the planner's plan §G (stages 2–3). `BIBLIOGRAPHY.md` rows `[EinsiedlerFish2010]`, `[DuczVarga2026]`,
`[MatolcsiEtAl2025]`. **Not read:** X01D, X02D, X02V, `plans/FS100-derivation.md` §3, EL2021 §§3, 5–9.

### 2.1 EF_F⁺ — surprised, in the direction of soundness

- **X01V's blind GAP** (§2.3) was exactly my stage-1 worry (i): "Lemma 3.2's multiplier step … images `u′B` small at every place" — it
  required every multiplier to keep the neighbourhood thin, found only `(log M)^k` such multipliers, and named a missing lemma UZ. Its stage 4
  (§4.2) names the wrong premise concretely: "The adelic argument needs only that the *product* over all places of the error `z` be `< 1/C_Λ`."
- **X12B §2.2, read step by step** (my check, not blind): the overlap equation `(q₁ − q₂)x̃ = λ + q₂ỹ₂ − q₁ỹ₁` is read at `P⁺` (where `u*`
  expands) for smallness and everywhere else only for a height bound polynomial in `X`; two scales `X, X²` give `ℓ − ℓ′` of product `< 1`,
  hence `0`; Lemma Z (wandering shells, stabiliser `U_ℓ` of finite index because `L/Λ′ ≅ ⊕_{stable} L_v/Λ′_v` has finite `U`-orbits) kills
  every other split coordinate. Checked: step 1's box (the partition is pulled back from `X_Q = R̂/K_Q`, so atoms are `K_Q`-saturated — the
  fat `∏_{w∉Q}O_w` is honest); step 4's lower bounds `|q₁−q₂|_v ≥ X^{−2}` (arch, `N ∈ ℤ[i]∖0`) and `≥ (4X⁴)^{−[L:ℚ]}` (finite); `H′(ℓ)`'s
  finiteness (only places dividing `c₁c₂N`, `𝔡`, or the lift's support contribute); step 5's exponent bookkeeping; step 6's order of
  choices; Lemma Z's linearity on the coset (`gℓ − ℓ ∈ Λ′`). **No failing line.**
- **Degree:** the pigeonhole counts `U_ℚ(X) = {den ≤ X}`, `≈ (4/π)X`, **linear in `X` at every degree**; `[L:ℚ]` enters only the constants
  `a, b` of step 4, hence `K`, hence `β = 1/(2K)`, which SMB supplies for every `β > 0`. So C-MR16 for EF_F⁺ is a walk of constants, not a
  risk. (Row 120's "`c·M^{1/[F:ℚ]}`" is the same count in `H_L`-normalisation.)
- **Hunches scored:** `one-u-zero-entropy-overreach` — **killed** (by X12B §2.2 steps 3–5: one thin place suffices; the product formula pays for
  fatness elsewhere). `uq-multipliers-not-admissible` — **true and moot** (`U_ℚ` is used only as pigeonhole multipliers; PE-2 uses
  `Γ = ⟨u, w⟩`, admissible by Lemma W). `x01v-withdrawal-is-selection` — **half**: the withdrawal was a non-independent reading (X01V says so),
  but it names its wrong premise, and X12B's blind TRUE is the independent evidence. `ef-transfer-is-the-weak-step` — **weakened** (below).

### 2.2 PE-2 — the external step, read at its statement

EL2021 p. 2, Thm 1.2 has no `d ≥ 2`; "not virtually-cyclic" carries it. Thm 1.3 (p. 2–3) gives `Λ`, `µ = (1/J)(µ₁ + … + µ_J)`, closed
`G_j`, zero entropy on `X/G_j`. **Deduction 1.3 ⟹ 1.2** (my hand, one mind): total irreducibility makes each `G_j` finite or `X`; `G_j = X` for
one `j` gives all (`α^n G_j = G_k`), so `µ = m_X`; all finite gives zero entropy on `X` (finite-to-one extension, Abramov–Rokhlin with
finite fibres) for `n ∈ Λ`, hence for all `n`. **Two definitional points the claim list should carry:** (i) the trivial factor `X/X` is
virtually cyclic by the letter of p. 2's definition (`n = 0`), so "no virtually cyclic factors" must mean *non-trivial* factors; (ii)
totally irreducible + not virtually cyclic ⟹ no non-trivial virtually cyclic factor: a factor `X/Y` has `Y` finite, and `α^{m−kn} = id` on
`X/Y` gives `(α^{m−kn} − 1)X ⊆ Y`, so `= 0` by connectedness. Hyperbolicity is **not** a hypothesis of either statement (p. 4, Cor. 1.4:
"we do not assume that the actions are totally non-symplectic or hyperbolic") — which matters, because our pieces have a large isometric
(archimedean) part.

### 2.3 Row 129 (d) — surprised, and the test has a cheap form already scored

`[DuczVarga2026]` (held, read in full): a finite unit-distance graph with independence ratio **below 1/4** (`χ_gf(G29) > 4.0007`). A proof
that every finite UD graph has ratio `≥ 1/4` would have refuted MR at ℚ(√635087) (`m₁ ≤ 0.2470`); that failure was reachable and **did not
happen** — a met prediction, weak because nobody predicted otherwise after MRVZ's Conjecture 1 fell. The live refutation window is
`α₁(ℝ²) ∈ (0.2470, 0.24996]`. And (d1)'s softest link is not MR but **B-AMEN** (row 129: "B-AMEN and B-CHIF one mind") — the step
"finitary `α₁(F²)` = the sup density of `R ⋊ U`-invariant random independent sets" (amenability, Følner averaging): standard, one mind.

### 2.4 Updated probabilities (supersede stage 1's table for scoring at the close; stage 1's stays as registered)

| step | stage 1 | now | what moved it |
|---|---|---|---|
| PE-2 (EL Thm 1.2, admissibility, pieces, passage) | 0.08 | **0.04** | Thm 1.3's statement read; the deduction is short; hyperbolicity explicitly not assumed |
| EF_F⁺ | 0.25 | **0.05** | X12B §2.2 read step by step, no failing line; X01V's GAP located and its premise named |
| degree 16 | 0.07 | **0.03** | the count is linear in the denominator at every degree |
| scope `R_F = O′` | 0.05 | **0.04** | unchanged in substance; the non-totally-real clause stays the residual |
| **P(MR survives FS-105 with no named gap)** | 0.62 | **0.85** | |
| P(blind B reports GAP) | 0.40 | **0.35**; of which P(at X01V's step) ≈ 0.6 | |

*G21 note on myself:* every update above moved toward the liked result. The readings were of records that concluded TRUE; the one blind
contrary reading (X01V) I read too, and its withdrawal is concrete. What would reverse me: a failing line in X01D (unread by me) that X12B
does not share, or EL2021 §§4–7 using a hypothesis Thm 1.3's statement omits.

### Would have searched here (stage 2)

- none: every check was a reading of held records and one held paper.

## Stage 3 — SAVED: advice sent to the owner ("main"), then stand-by

The planner handed back before my claim-list reply reached it. The owner asked for the advice directly, so it went to `"main"` (12 lines)
after I read `data/fs105/briefs/B105-blind-efp.md` §"Blind — the fences" and grepped `W105-walker.md`. In summary:
1. **Leak in B105:** the session transcripts are unfenced — `chats-bak/` and `~/.claude/projects/-home-kooshi-source-lean-dir/` (717 files carry
   the route: "Lemma 3.1′", "wandering shell", "UZ", …). Fence them, `/tmp/claude-1000/` other than B's own scratchpad, and `git log -p` on
   fenced paths. Add grep-trigger words "Lemma Z", "UZ", "wandering shell", "local injectivity", "two-scale", "ℓ₁e₂".
2. Ask B for EF_F⁺ and EF_F⁰ both; MR needs only EF_F⁰ given PE-2.
3. The owner holds a classification key for the close, not for B: X01V's stall location and its resolution (§2.1 above).
4. Claims (a): add the passage (constant Haar weight, projective `ν`, `U`-invariance), Haar entropy > 0 on each piece, `⟨u,w⟩` torsion-free;
   in (a0)/(a4), "virtually cyclic factor" as non-trivial, and Abramov–Rokhlin in Thm 1.3 ⟹ 1.2.
5. W105 (d): B-AMEN is (d1)'s one-mind link; the cheap form is already met in print (G29, ratio < 1/4).

Stand-by: the owner may relay the jobs' records for comparison; resume at a new stage 4.
