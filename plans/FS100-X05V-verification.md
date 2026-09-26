*Verification record of crunch job **X05V** (Coxeter, blind verifier, Opus 5.5), the ×2×3 crunch, 2026-09-26. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X05V-sp-cor-flip-verifier.md`, with `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` as part of
it. Blind to X03D (fences in the brief). No subagents; no finite-witness search (ban to 2026-10-01). I touch only this file,
`data/fs100/x05v/`, `tools/x05v_*.py` and my report.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| X05V-1 | SP-Cor, re-derived blind from J45's lemma statements (P0–P8): a four-colouring of ℚ(√47)'s plane gives a rotation-invariant `μ` whose `σ` contradicts MR + R-U + A⁺ at `S = ∅` | [hand; given N1, N2, R-U (J45) and R88-TCA at `S = ∅`] | §2.1, §2.3 |
| X05V-2 | A⁺ at `S = ∅` from SI-1, SI-3, SI-4, N2 and R88-TCA at `S = ∅` (J45's statement, restricted) | [hand; given N2, R88-TCA] | §2.1 |
| X05V-3 | KC: at K and at ℚ(√11) the chain P0–P7 goes through and stops at P8, exactly at T-C(A) (false there, witnessed); F2's noisy colouring has `σ = σ_D + (2/21)·m`, `σ_D` on `T` | [hand + tools exact (check 5, plants fire)] | §2.2 |
| X05V-4 | FL-1's example invariant, corrected: `τ₀ := σ|_{R̂∖E}` is not a multiple of Haar, and `τ̂₀(u) = τ̂₀(1) = −(4/3)A < 0` for every `u ∈ U`, `A = Σ_j E[p_j(0)p_j(u)]` (constant in `u`) | [hand; given A⁺ at `S = ∅`, R-U, N2] | §3.1 |
| X05V-5 | FL-1's inequality `τ̂(1) ≤ −τ(R̂)/3` is equivalent to `A ≥ (1 − B)/3 − a/4`, i.e. to `σ̂_E(1) ≥ −(σ_E(R̂) + a)/3` | [hand + tools exact (check 2a)] | §3.1 |
| X05V-6 | no spectral route to X05V-5 at `a = 0`: for a `U`-invariant positive `ν` on `T + A`, `ν̂(1) ≥ λ_*·ν(R̂)` is sharp and `λ_* ≤ min J₀ < −0.4027 < −1/3`; the pointwise form fails | [hand + tools exact (checks 2b, 3, 4)] | §3.1 |
| X05V-7 | for `κ > 0`, "every `U`-invariant `E`-null finite positive `τ ≠ 0` has `τ̂(1) > −κ·τ(R̂)`" (H_κ) plus QTCA_κ imply `χ(ℚ(√47)²) ≥ 5`; and H_κ for every `κ > 0` holds iff MR(ℚ(√47)) | [hand; the second half given SP-if] | §3.2 |
| X05V-8 | MR ⟹ H_{1/3} (a Haar multiple `τ ≠ 0` has `τ̂(1) = 0`) | [hand] | §3.2 |

## Stage 1 — SAVED (quotation check, C0)

### 1.1 Quotation check (standing rule 5)

| item in the brief | source | result |
|---|---|---|
| SP-Cor, "Over ℚ(√47): if every finite positive `U`-invariant measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`." | `plans/FS84-SI-D-derivation.md` l. 321–322 (the statement lines only; §4's proof not read) | **verbatim match**; grade "[hand; given T-C(A) at `S = ∅`]" matches |
| FL-1, FL-2 and §2's notation paragraph | `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, list X03 | copied verbatim below (1.2) |
| KC, "MR is consistent with Theorem B at K and with ℚ(√11)'s non-periodic four-colourings (row 94), whose spectral measures lie in T + Fin_S plus Haar. SP-Cor fails at those fields exactly at T-C(A)." | the advisor's [P-5a], in `plans/POROS-2026-09-26-x2x3-crunch.md` (fenced) | **not checkable** (source fenced); taken as the brief states it. Content note for stage 2: row 94's non-periodic colouring `⌊4θ⌋` has an archimedean term, so its spectrum is on `T + A` (row 112: "C9's colouring has spectrum on `T + A`"), not on `T + Fin_S` |
| "J45's lemma statements (§5.4: SI-1 to SI-5, RU, SP-oi, SP-if, A⁺, B⁺)" | `plans/FS84-SI-D-derivation.md` §5.4 | §5.4 lists N1, N2, SI-1…SI-5, SI-J, G2-11, SI-C, A⁺, B⁺, R-U, SP-if, SP-Cor. **SP-oi is not in §5.4**; it appears only in the theorems table (l. 24) as "SP's 'only if'". SP's statement is taken from J45's brief, quoted verbatim from the Poros record §4.4 (below) |
| R88-TCA | `plans/R88-derivation.md` l. 161 | read, statement only (quoted in 1.2) |
| rows 94, 98, 105, 112, 113, 117 | `LEDGER.md` | read |

### 1.2 The inputs, verbatim

**Notation** (queue §2, verbatim): "`F ⊆ ℝ` a real number field, `L = F(i)`, `U = U_F` the unit vectors (norm-one elements of `L/F`),
`R = ℤ[U]`, `R̂` its dual; `T` the torsion characters, `A(R_F)` the archimedean ones, `E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the
finite set `S` of split places) — `LEDGER.md` rows 98, 113." Added there: "`U` acts on `R̂` by `(u·χ)(x) = χ(ux)`; `m` is Haar probability on
`R̂`; `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`; for `u ∈ U`, `H(u) = ∏_w max(1, |u|_w)` over the finite places `w` of `L`
(normalised absolute values); `U_N = {u ∈ U : H(u) ≤ N}`."

**FL-1** (queue §2, list X03, verbatim): "Over ℚ(√47), given T-C(A) at `S = ∅` and rows 112–113's inputs: for every translation- and
rotation-invariant random proper four-colouring of the plane, with the colours embedded as the vertices of a regular tetrahedron centred at
`0` and `σ` the trace of its spectral measure on `R̂` (`σ(R̂) = 1`), write `σ = a·m + σ_E + τ` with `σ_E` carried by `E` and `τ(E) = 0`
non-Haar. Then `τ ≠ 0`, and `τ̂(u) = τ̂(1) ≤ −τ(R̂)/3` for every `u ∈ U`."

**FL-2** (verbatim): "Over ℚ(√47), given T-C(A) at `S = ∅`: if every `U`-invariant, `E`-null finite positive measure `τ` on `R̂` satisfies
`τ̂(1) > −τ(R̂)/3` whenever `τ ≠ 0`, then `χ(ℚ(√47)²) = 5`."

**SP** (J45's brief, quoting the Poros record §4.4, verbatim): "a `U_F`-invariant finite positive measure `τ` on `R̂` with `τ(E) = 0` and
`∫ Re χ(1) dτ < 0` exists if and only if some `U_F`-invariant finite measure on `R̂` with `τ(E) = 0` is not a multiple of Haar measure."

**R88-TCA** (`plans/R88-derivation.md` l. 161, statement): "over ℚ(√47), and (J28D) over every real field whose stable places all have
all-levels ratio `< 1/4`, no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S` for a finite
set `S` of split places, dyadic ones included; …"

J45's §5.4 statements used below (verbatim): "SI-1: for every `u ∈ U`, `−1/3 = E⟨h(0), h(u)⟩ + ∫_{R̂∖E_S} χ(u) dσ_μ(χ)`, with
`h = E[g | 𝒜_S]`." "SI-3: `∫_{R̂∖E_S} Re χ(u) dσ_μ = −(4/3) Σ_j E[P(c(0) = j | 𝒜_S) P(c(u) = j | 𝒜_S)]`; it is `0` iff the supports at `x`
and `x + u` are a.s. disjoint for every `x`." "SI-4: if equality holds for every `u ∈ U`, then `x ↦ min supp P(c(x) = · | 𝒜_S)` is an
`𝒜_S`-measurable, translation-equivariant proper four-colouring." "A⁺: over ℚ(√47), given T-C(A), every `μ` and every finite `S` have some `u`
with strict inequality." "R-U: every finite `U`-invariant measure on `R̂` gives `E_S ∖ (T + A)` measure 0, for every finite `S`." "N1: … `E_S`
is a proper, dense, Haar-null Borel subgroup of `R̂`." "N2: for `f ∈ L²(μ)`, `σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous, and
these `f` are exactly `L²(𝒜_S)` for a translation-invariant σ-algebra `𝒜_S`."

### 1.3 C0 — probabilities per claim

*Honest timing:* written after reading the inputs above and a first informal pass (about ten minutes), not as a clean prior.

| claim | TRUE | GAP | FALSE |
|---|---|---|---|
| SP-Cor (re-derived from the lemma statements) | 0.85 | 0.12 | 0.03 |
| KC (the chain stops exactly at T-C(A) at K and at ℚ(√11)) | 0.80 | 0.15 | 0.05 |
| FL-1 as written, every clause | 0.25 | 0.60 | 0.15 |
| FL-2 | 0.30 | 0.60 | 0.10 |

### 1.4 Slips, logged as they happen

- **Fence touched (05:53):** a `grep -n "P-5a\|P-5\b"` over the whole queue printed line 228, which is in §6 (fenced): "P-5 (adopted): a blind
  check of SP-Cor (X05V) and the headline cap (inventory item 8); the known-positive control KC." Nothing about any derivation; no further
  §6 text read. Logged for the owner.

### 1.5 Would-have-searched-here log

- none in stage 1.

## Stage 2 — SAVED (KC, then SP-Cor)

Conventions as §1.2. `g(x) = e_{c(x)}` with `⟨e_i, e_j⟩ = (4/3)δ_ij − 1/3`; `C(y) = E_μ⟨g(0), g(y)⟩ = σ̂(y) := ∫ χ(y) dσ(χ)`; `E_∅ = T + A`
(`Fin_∅` is the trivial group). For `S = ∅` write `𝒜 = 𝒜_∅`, `p_j(x) = P(c(x) = j | 𝒜)`, `h = Σ_j p_j e_j`, and
`A_u = Σ_j E[p_j(0) p_j(u)]`, `B = Σ_j E[p_j(0)²]`. Exact checks: `tools/x05v_checks.py` (18 lines PASS, exit 0; every plant fires; two
mutants of the file go red, `mut1` at check 3 and 4b, `mut2` at check 5).

### 2.1 The ladder as I run it (P0–P8), each step's input and grade

Suppose a proper four-colouring of ℚ(√47)'s plane exists.

| step | content | input | grade of the input |
|---|---|---|---|
| P0 | restrict it to `R ⊂ L` (the plane): a proper four-colouring of `Cay(R, U)`, so `X₄(F) ≠ ∅` | definition | — |
| P1 | `R ⋊ U` is countable and solvable, hence amenable; it acts on the compact metrizable `X₄(F)` by translations and by rotations `(u·c)(x) = c(ux)` (proper, since `uU = U`); so an `R ⋊ U`-invariant Borel probability `μ` exists | Markov–Kakutani–Day | standard |
| P2 | `σ := σ_μ` (Bochner on the discrete `R`): `σ(R̂) = C(0) = 1`; `σ̂(u) = C(u) = −1/3` for every `u ∈ U` (proper + Gram); rotation-invariance gives `C(uy) = C(y)`, so `σ` is `U`-invariant (uniqueness of Fourier–Stieltjes transforms on the compact `R̂`) | Bochner; check 1a | standard; tools exact |
| P3 | `E = ⋃_S E_S` is a countable union of Borel sets (N1; finite sets of split places are countable), so Borel; `U`-invariant (`T`, `A`, `Fin_S` are each stable under `χ ↦ u·χ`, multiplication by `u` being an automorphism of `R` continuous for each topology); `m(E) = 0` (N1) | N1 | J45 [hand] |
| P4 | `σ(E ∖ (T + A)) = 0` | R-U applied to the `U`-invariant finite `σ` | J45 [hand, one mind] |
| P5 | **MR's hypothesis** applied to `σ|_{R̂∖E}` (finite, positive, `U`-invariant by P2–P3, `E`-null): `σ|_{R̂∖E} = a·m`, `a ≥ 0` | the hypothesis | — |
| P6 | `m̂(y) = 0` for `y ≠ 0` (a non-trivial character integrates to 0 against Haar); `u ≠ 0`; so `∫_{R̂∖E} χ(u) dσ = 0` for every `u ∈ U` | Pontryagin duality | standard |
| P7 | P4 + P6: `∫_{R̂∖(T+A)} Re χ(u) dσ = 0` for every `u ∈ U` | — | — |
| P8 | **A⁺ at `S = ∅`**: some `u` has `∫_{R̂∖(T+A)} Re χ(u) dσ_μ < 0`. Contradiction with P7, so `χ(ℚ(√47)²) ≥ 5` | A⁺ (only its `S = ∅` instance) | J45 [hand, one mind], resting on T-C(A) at `S = ∅` |

**P8 re-derived from its inputs** (so that the only load-bearing black boxes are N2, R-U and T-C(A)): by SI-1 and N2 (the spectral
projection onto `E_∅` is `E[· | 𝒜]` and commutes with translation), `∫_{R̂∖E_∅} χ(u) dσ_μ = C(u) − E⟨h(0), h(u)⟩ = −1/3 −
((4/3)A_u − 1/3) = −(4/3)A_u` (check 1b: `⟨Σ p_j e_j, Σ q_k e_k⟩ = (4/3)⟨p, q⟩ − 1/3` for probability vectors) — SI-3, real and `≤ 0`, zero
iff `p_j(x) p_j(x+u) = 0` a.s. for every `j`, `x`. If it were zero at every `u`, `c′(x) := min supp p(x)` is defined a.s. (`Σ_j p_j = 1`),
`𝒜`-measurable, translation-equivariant (`𝒜` is translation-invariant) and proper (disjoint supports on every edge): SI-4. Its law `ν` is a
translation-invariant probability on `X₄(F)`; the coordinates of `g(c′(0))` lie in `L²(𝒜)`, so by N2 their spectral measures, which the
factor map `ω ↦ c′_ω` carries to `σ_ν`, are carried by `E_∅ = T + A`. R88-TCA at `S = ∅` forbids such a `ν`. ∎ — **the same as J45's
statement of A⁺, restricted to `S = ∅`.**

### 2.2 KC first — the known-positive control

**What a wrong-reason pass looks like (G21), written before running it.**
- (W1) The chain halts at K or ℚ(√11) *before* P8 — no invariant `μ` (P1), `σ` not `U`-invariant (P2), R-U failing on the control's
  spectrum (P4). Then "it stops" says nothing about P8, the one step that uses T-C(A).
- (W2) MR's step (P5) is exercised only as `0 = 0·m` — the control's colourings have no `E`-null spectrum at all — so the MR step is never
  tested with `a > 0`.
- (W3) T-C(A) "fails" at the control field only vacuously, with no colouring whose spectrum is on `T + A` witnessing it.
- (W4) The chain *runs through* at K and outputs `χ(K²) ≥ 5`, contradicting Theorem B. That is a FAIL (a defect in SP-Cor), not a pass.

**At K = ℚ(√3,√11).** P0: four-colourings exist (Theorem B, row 57, kernel); take a residue colouring at a prime `𝔭` above 2. P1: its
`R ⋊ U`-orbit is finite (rotations act on `R/(𝔭 ∩ R)` by multiplication by residues of unit vectors), so the uniform measure on the orbit is
invariant. P2: the process is `(𝔭 ∩ R)`-periodic, so `σ` sits on the finitely many characters trivial on `𝔭 ∩ R`, all in `T`. P3–P4 ✓
(`σ` on `T`). P5: `σ|_{R̂∖E} = 0 = 0·m` — consistent with MR (W2: exercised trivially here). P6–P7 ✓. **P8 fails exactly at its input:**
T-C(A) at `S = ∅` is false at K, witnessed by this `μ` (spectrum on `T ⊂ T + A`; W3 answered); consistently, SI holds with equality
(`𝒜 = everything`, `A_u = P(c(0) = c(u)) = 0`). By row 89 every four-colouring of `K²` is on `R` a pullback from one dyadic place, so every
run at K stops at P8 the same way. (W4) does not occur.

**At ℚ(√11).** Two colourings, each at a different step's full strength.
- *Row 94's non-periodic C9* `⌊4θ⌋`, `θ = (2x+3y)/7` at the stable prime above 7 plus an archimedean term below `1/28`. Check 5: the 8
  points of the circle over `𝔽₇` have `(2x+3y) mod 7 ∈ {2,3,4,5}`, and a step `s ∈ {2,…,5}/7` always changes `⌊4θ⌋ mod 4` (plants fire).
  Its invariant measure has spectrum on `T + A` (row 112: "C9's colouring has spectrum on `T + A`"), so P5 is again `0 = 0·m`, and P8 fails
  at T-C(A), witnessed.
- *J45's F2 noisy colouring* (SI-C): the periodic pullback `γ` of `⌊4θ⌋` from `Γ₇`, with independent fair bits recolouring `Z̄ = {θ = 0}`
  (density `1/7`) from 0 to 3. `Z̄` is independent (`θ(u) ≠ 0` on `U`) and its points miss colour 3 (G2-11), so the result is proper. Write
  the bit as `½ + ½η`, `η = ±1`: `g = D + N`, `D` a function of the periodic structure, `N(x) = ½·1_{Z̄}(x)·η(x)·(e₃ − e₀)`. For `y ≠ 0`,
  `E⟨N(0), N(y)⟩ = 0` and `E⟨D(0), N(y)⟩ = 0` (`η(y)` independent, mean 0), so `C = C_D + κ·δ₀` with
  `κ = ¼·|e₃ − e₀|²·(1/7) = ¼·(8/3)·(1/7) = 2/21`, and **`σ = σ_D + (2/21)·m`**, `σ_D` on `T` (after averaging over the finite rotation
  image, which keeps both parts). So P5 is exercised with **`a = 2/21 > 0`**: MR's conclusion holds non-trivially on this spectrum (W2
  answered). P6–P7: `∫_{R̂∖(T+A)} Re χ(u) dσ = 0`, which is SI with equality — J45's SI-C, recovered. P8 fails exactly at T-C(A) (witness: `γ`,
  spectrum on `T`).

**Verdict KC: TRUE.** At both fields every step P0–P7 goes through and the chain stops at P8, exactly at T-C(A) at `S = ∅`, which is false
there with a witness; at ℚ(√11) the MR step runs with a Haar part of mass `2/21`. **One correction to KC's wording:** "whose spectral
measures lie in T + Fin_S plus Haar" is right for F2's noisy periodic colourings (`T` plus Haar), but row 94's *non-periodic* colourings —
the ones KC names — have spectrum on `T + A` (their archimedean term is what makes them non-periodic), which is not in `T + Fin_S`. Read
"T + A, or T plus Haar for the noisy ones".

### 2.3 SP-Cor

**Verdict: TRUE** — re-derived blind from the lemma statements (§2.1, P0–P8), with no step of §4's proof read. **What it rests on:**
N1 (Borel, `U`-invariant, Haar-null `E`), N2, R-U, and A⁺ at `S = ∅` (re-derived above from SI-1, SI-3, SI-4 and N2), all J45 [hand, one
mind]; R88-TCA at `S = ∅` (two minds at ℚ(√47)); standard facts (amenability of `R ⋊ U`, Bochner, `m̂(y) = 0` for `y ≠ 0`). **Not used:**
SI-2, SI-5, SI-J, B⁺, SP-if, SP-oi, K0 (K0 is SP-Cor at ℚ(√143), ℚ(√311), ℚ(√335)). **For the headline:** the load-bearing single-mind
inputs are **R-U** (P4; without it the `E ∖ (T + A)` part of `σ` is not controlled, since A⁺ is available only at a finite `S` while `E`
is a union over all of them) and **N2** (P8). Two remarks that the record should carry:
- P1 must produce a *rotation*-invariant `μ` (or average over `U`); a merely translation-invariant `μ` gives a `σ` to which neither MR nor
  R-U applies. SP-Cor's statement is unaffected (the existence step is free by amenability), but a write-up must say it.
- The argument uses MR only on measures of the form `σ_μ|_{R̂∖E}`, so SP-Cor holds under the weaker hypothesis "MR for colouring spectra";
  that is the observation FL-2 tries to sharpen (stage 3).

### 2.4 Would-have-searched-here log (stage 2)

- Would have searched for a four-colouring of a control plane with a non-Haar `E`-null spectrum (to exercise P5 harder). Instead: used the
  two held explicit colourings (row 94, J45's F2) and computed their spectra by hand.

## Stage 3 — SAVED (FL-1, FL-2, the write-up)

### 3.1 FL-1

Take a rotation-invariant `μ` over ℚ(√47) (FL-1's hypothesis) and `σ = σ_μ`. `σ_E` is forced: `σ_E = σ|_E` (both `a·m` and `τ` are
`E`-null, `m(E) = 0` by N1). The split of `τ₀ := σ|_{R̂∖E}` into `a·m + τ` is **not unique**: any `a ∈ [0, a_max]` with `τ₀ − a·m ≥ 0`
works, and "non-Haar" can be read "not a multiple of `m`" or "no Haar component left" (`a = a_max`). `a = 0` is always admissible once
`τ₀` is not a Haar multiple. I score every clause under every reading; they agree except where said.

- **(i) `τ ≠ 0`. TRUE** under every reading. P0–P4 and P6–P8 of §2.1 run without MR: if `τ₀ = a·m` then `∫_{R̂∖(T+A)} Re χ(u) dσ = 0`
  for every `u`, against A⁺ at `S = ∅`. So `τ₀` is not a Haar multiple and every admissible `τ = τ₀ − a·m` is non-zero.
- **(ii) `τ̂(u) = τ̂(1)`. TRUE.** `τ₀` is `U`-invariant (P2, P3), so is `τ`, and `τ̂(u) = ∫ (u·χ)(1) dτ = τ̂(1)`; `τ̂` is real (`σ`, `E`, `m`
  are conjugation-symmetric).
- **The sign, which FL-1 does not state but which is the example invariant: TRUE.** By R-U, `σ|_E = σ|_{T+A}`, which by N2 is the spectral
  measure of `h = E[g | 𝒜]`; so `σ̂_E(u) = (4/3)A_u − 1/3`, `σ_E(R̂) = (4/3)B − 1/3` (check 1b), and
  `τ̂(u) = τ̂₀(u) = −1/3 − σ̂_E(u) = −(4/3)A_u` (`m̂(u) = 0`). `A_u` is constant in `u` by (ii), and `> 0` by A⁺. So **`τ̂ ≡ −(4/3)A < 0`
  on `U`**: an actual four-colouring's `E`-null spectrum is negatively correlated on the whole unit circle — the flip of G79, derived.
- **(iii) `τ̂(1) ≤ −τ(R̂)/3`. GAP.** With `τ(R̂) = 1 − a − σ_E(R̂)`, check 2a gives
  `τ̂(1) + τ(R̂)/3 = −(4/3)(A − (1 − B)/3 + a/4)`, so (iii) **is equivalent to `A ≥ (1 − B)/3 − a/4`**, i.e. to
  `σ̂_E(1) ≥ −(σ_E(R̂) + a)/3`; at `a = 0` (admissible, and the hardest case) it is a Hoffman-type lower bound on the correlation of the
  `E`-factor at unit distance. Name the missing step:

  > **QTCA_κ** (not an input, not known to me): for every translation- and rotation-invariant random proper four-colouring of ℚ(√47)'s plane,
  > `Σ_j E[p_j(0) p_j(u)] ≥ κ·(1 − Σ_j E[p_j(0)²])`, `p_j(x) = P(c(x) = j | 𝒜_∅)`. FL-1 (iii) at `a = 0` is QTCA_{1/3}.

  What the inputs give is only `A > 0` (A⁺), with no uniform constant. Why the obvious routes stop:
  - *Pointwise* the inequality is false: `p = (½,½,0,0)`, `q = (0,0,½,½)` give `A = 0 < (1 − ½)/3` (check 2b; the extremes `p` uniform and
    `p` deterministic give equality, plants).
  - *Spectrally* it is out of reach: `σ_E` is a `U`-invariant positive measure on `T + A = Ĝ_∅`, so `σ̂_E(1) = ∫ λ(χ) dσ_E` with
    `λ(χ) = ∫_{Ū} χ(u) du`, and the only bound from `σ_E` alone is `σ̂_E(1) ≥ λ_*·σ_E(R̂)`, sharp. An archimedean character at one complex
    place of `L`, frequency `|ξ| = 3.83/2π`, has `λ = J₀(3.83) ∈ [−0.402760, −0.402759]` (check 3, a rational enclosure; plant at `J₀(2)`
    fires), and the stable places 11 and 19 of ℚ(√47) fail H* (R88-TC-tab: some character there has `λ/d ≤ −1/3`). So `λ_* < −1/3`: this is
    the real place's Hoffman failure (`0.2871 > 1/4`) that R88-TC had to route around with the non-spectral `m₁ ≤ 0.2470`.
  - *The shape of a would-be failure* (check 4): an `E`-part `h = s·v·cos(2π⟨ξ, x⟩ + φ)`, `|s| ≤ 1/3` (inside the tetrahedron), at the
    `J₀`-minimising radius, violates (iii) by `(s²/2)(0.4027 − 1/3) > 0` at `a = 0`. T-C(A) does not exclude such an `E`-part: it excludes
    only colourings whose *whole* spectrum is on `T + A + Fin_S`. Whether a proper four-colouring can carry it is the open content of QTCA.

  **FL-1 cannot be FALSE by a counterexample short of a four-colouring of ℚ(√47)'s plane** (if `χ = 5` it is vacuously TRUE), so GAP is the
  strongest verdict available. **Verdict FL-1: GAP at clause (iii) — the missing step is QTCA_{1/3}; clauses (i), (ii) and the sign TRUE.**
  Proposed corrected statement, TRUE [hand; given A⁺ at `S = ∅`, R-U, N2] (X05V-4): *"… Then `τ₀ := σ|_{R̂∖E}` is not a multiple of Haar,
  and `τ̂₀(u) = τ̂₀(1) = −(4/3) Σ_j E[P(c(0) = j | 𝒜_∅) P(c(u) = j | 𝒜_∅)] < 0` for every `u ∈ U`."*

### 3.2 FL-2

`χ(ℚ(√47)²) ≤ 5` is held (row 84: `4 ≤ χ ≤ 5`; the usable plane at 11), so FL-2 is "H_{1/3} ⟹ `χ ≥ 5`", where
**H_κ** = "every `U`-invariant, `E`-null finite positive `τ ≠ 0` has `τ̂(1) > −κ·τ(R̂)`".

- **The route.** Suppose a four-colouring; P0–P4 give `τ₀ ≠ 0` (3.1 (i)), `U`-invariant, `E`-null. H_{1/3} applied to `τ₀`:
  `−(4/3)A > −(4/9)(1 − B)`, i.e. `A < (1 − B)/3`. A contradiction needs `A ≥ (1 − B)/3`, which is **QTCA_{1/3} again**. Applying H_{1/3}
  to other measures the colouring supplies does not help: for any `φ : {0,…,3} → ℂ^d` the `E`-null part of `φ(c)` has
  `τ̂_φ(1) = E⟨φ(c(0)), φ(c(u))⟩ − E⟨φ(c¹(0)), φ(c²(u))⟩` (relatively independent joining over `𝒜`), and for the indicator embedding this is
  `(3/4)` times the tetrahedral `τ₀` — the same inequality. **Verdict FL-2: GAP at the same step (QTCA_{1/3}); the "`= 5`" upper half
  TRUE (held).**
- **What the consumer needs, stated exactly (X05V-7, X05V-8).** For `κ > 0`: H_κ ∧ QTCA_κ ⟹ `χ(ℚ(√47)²) ≥ 5` (the route above with `κ` for
  `1/3`). H_κ weakens as `κ` grows, so a uniform `κ` buys a hypothesis strictly easier than MR (MR ⟹ H_{1/3}: a Haar multiple `τ ≠ 0` has
  `τ̂(1) = 0`), but only against QTCA_κ. Without QTCA the one-sided route collapses back to MR: each colouring has its own
  `κ_μ = A/(1 − B) > 0`, so what is needed without a uniform constant is H_κ for every `κ > 0`, i.e. "every `τ ≠ 0` has `τ̂(1) ≥ 0`", and
  by SP-if (a non-Haar `U`-invariant `E`-null measure yields one with `∫ Re χ(1) dτ < 0`) that is exactly MR. **So the consumer needs MR, or
  H_κ together with QTCA_κ for one `κ > 0`.** The flip lowers the bar only if QTCA can be proved, and QTCA is a quantitative T-C(A) whose
  spectral proof fails at the same real place (and at 11, 19) where T-C(A)'s spectral proof failed.

### 3.3 Verdicts

| claim | verdict | the step | C0 (TRUE / GAP / FALSE) |
|---|---|---|---|
| SP-Cor | **TRUE** | blind re-derivation P0–P8 from the lemma statements; load-bearing one-mind inputs R-U, N2, A⁺ (re-derived from SI-1, SI-3, SI-4) | 0.85 / 0.12 / 0.03 — scored TRUE |
| KC | **TRUE**, with a wording correction ("`T + A`" for row 94's non-periodic colourings, not "`T + Fin_S`") | chain stops exactly at P8's input T-C(A), witnessed; MR step exercised with `a = 2/21` | 0.80 / 0.15 / 0.05 — scored TRUE |
| FL-1 | **GAP at clause (iii)**, missing step QTCA_{1/3}; (i), (ii) and `τ̂ < 0` on `U` TRUE | §3.1 | 0.25 / 0.60 / 0.15 — scored GAP |
| FL-2 | **GAP at QTCA_{1/3}**; upper half TRUE | §3.2 | 0.30 / 0.60 / 0.10 — scored GAP |

**Queue §5 item 8** ("FL-1 TRUE as written (FL-2 then TRUE with it: 0.8)", P = 0.40): not met by this verification (GAP). Item 9 (the headline
at the close) needs MR; X05V clears SP-Cor for it, with R-U and N2 named as the one-mind inputs.

### 3.4 Corrections owed (proposed; the front-page lane decides)

1. KC's parenthetical: row 94's non-periodic colourings have spectrum on `T + A` (row 112), not on `T + Fin_S`; F2's noisy ones on `T` plus
   Haar (mass `2/21`).
2. This brief lists "SP-oi" among `plans/FS84-SI-D-derivation.md` §5.4's statements; §5.4 has no SP-oi line (the theorems table does, l. 24).
3. SP-Cor's write-up should say that P1 takes a *rotation*-invariant `μ` (R⋊U amenable); MR and R-U need `σ` `U`-invariant.
4. FL-1's decomposition is not unique in `a`; replace FL-1 by X05V-4 (TRUE), and state (iii) as QTCA_{1/3}, open.
5. If FS-100's stub records "the consumer needs less than MR", it should read: "MR, or H_κ with QTCA_κ for some `κ > 0`" (X05V-7).

### 3.5 Would-have-searched-here log (stage 3)

- Would have searched for a stationary four-colouring model on a toy abelian Cayley graph whose `E`-factor is a `J₀`-type wave, to test
  QTCA numerically. Instead: derived the equivalence (X05V-5), the spectral no-go (X05V-6) and the reduction (X05V-7), and left QTCA as a
  named GAP.

### 3.6 Reading

No paper read. The `J₀` minimum and the measurable Hoffman ratio `0.2871` are `[BachocEtAl2014]`'s (held; cited through row 112).
