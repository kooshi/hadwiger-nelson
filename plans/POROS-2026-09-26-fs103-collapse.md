# Poros — advising FS-103, the collapse (job FS103-A)

*Advisor's record (brief `data/fs103/briefs/A103-advisor.md`; standing rules `data/fs103/briefs/STANDING-RULES.md`). The planner is de
Bruijn, job FS103-P (`plans/FS103-collapse-cp-plane.md`, claim list `data/fs103/claims.md`). Nothing here is a result; grades are the
sources'. My own derivations are marked [hand, one mind — FS103-A], unverified.*

## Stage 1 — expectation, written before reading any draft of the planner's

*Timeline, for honesty: everything below was formed from the record (the stub, R2's record, T-J39-3's proof at
`plans/POROS-2026-09-25-wanted-poster-167.md` §3.2, `LEDGER.md` rows 120, 123, 125, X21D's input table) and one PARI run. The planner's §G
bears list arrived by message while that run was going; I had already worked out the Doob point it raises (item E4 below). I have not opened
`plans/FS103-collapse-cp-plane.md` or `data/fs103/claims.md`.*

### Quotation check (standing rule 5)

| brief's quotation | source | result |
|---|---|---|
| T-J39-3 as quoted in the stub, "Let `N_k(F)` be the finite set … `Y_{F,k}` has a CP `k`-colouring." | wanted-poster §3.2, lines 112–116 | verbatim, but the stub elides the (A)/(B) dichotomy; the "given MR" sentence is verbatim |
| "`k`-thick" (M3-J21-TH) | stub item 2 | not re-opened in `plans/M3-derivation.md` (budget); the verifiers must quote it from the source |
| row 120's grade string | `LEDGER.md` line 165 | verbatim |
| "`χ(F²) ≤ χ_CP(ℝ²)` for every countable `F ⊆ ℝ`" | `LEDGER.md` row 125 | verbatim |
| Kooshi: "If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup." | `CLAUDE.md` § Publication | verbatim |

### Evidence inventory (read against an expectation written first)

- T-J39-3's proof, steps 1–7 (wanted-poster §3.2) — expected: "some step uses a finite non-thick set or two real places essentially" —
  surprised: **no**. At `N_k(F) = ∅` every step reads the same; step 6 already runs over infinitely many thick places at ℚ(√167).
- X21D's input table (`plans/FS100-X21D-derivation.md` lines 102–103, 211) — expected: "`N_k = ∅` never exercised" — surprised: **yes**.
  X21D-A4 uses "T-J39-3 at `k = 4` with `N₄ = ∅`" (J48-N4cor) at ℚ(√167). So `N_k = ∅` over infinitely many thick places is exercised, at
  `k = 4`. R-U's scope is "every real number field" (line 211).
- Row 120 (MR) — expected: "stated at degree 2 only" — surprised: no; it is stated "for every real number field `F` with `R_F = O′`", with
  PE-2 "applied only under admissibility — every finite-index subgroup of `Γ` spans `L`". At degree 16, `L = F(i)` has degree 32 and many
  CM subfields; admissible pieces exist (take `Γ ∋ u` with `ℚ(uᵐ) = L` for all `m`), but no mind has walked PE-2 there.
- The stub's "`χ_CP ≤ χ_m`" and `CLAUDE.md` paths-forward row 1's "`χ_CP ≤ χ_m`" — expected: "a derivation on record" — surprised: **yes,
  none found** (grep over `plans/FS100-*`, `plans/RERANK-2026-09-26.md`). It is asserted, not derived (see E5 for a sketch).
- De Grey's field, PARI (`nfinit`, `idealprimedec`, primes below 400; seconds) — expected: "first stable place at 131" — surprised: no.
  Degree 16; disc primes 2, 3, 5, 7, 11, each with `e = 2, f = 2` (four places each, residue field `𝔽_{p²}`, so `−1` is a square and
  none is stable); the only stable places below 400 are the sixteen above 131. Control: `K = ℚ(√3,√11)` shows the stable places at 2
  and 11, as it must. The script is in `data/fs103/fs103-a/dg.gp`.

### My expectation, per named step (F1 conditional on MR; probabilities that the step holds as the chain needs it)

| step | holds | why, and where it would break |
|---|---|---|
| **S1. T-J39-3 (⟹) with `N_k(F) = ∅`** (scope) | 0.95 | nothing in steps 1–7 uses a non-empty `N_k`; the scope is "every totally real `F`" (the stub's "a real field" must narrow to totally real, since the complex place is "Not claimed") |
| **S2. The thick deletion, infinitely many places, `k = 6`** (step 6) | 0.93 | exercised at `k = 4, 5`; at 6 only the threshold interval changes, `(λ*/(1+λ*), 1/6)`, non-empty iff `λ* < 1/5`. The thin points: (a) the fibre densities need a jointly measurable version, which FS100-BC's definition does not grant (the Mackey realisation of step 5 gives one, or Doob's theorem from continuity in probability); (b) the bound needed is `sup_v λ*_v < 1/5` for **one** uniform choice `K = ∏ O_{L_w}`, `ν = ⊗ Haar(T_w)` at all levels, not per-place thickness with place-dependent `(K_v, ν_v)` |
| **S3. Step 5's extension** | 0.96 | needs `cl ι(U)` = the full product of local circles (weak approximation for the norm-one torus, true because a quadratic norm-one torus is rational — weak approximation can fail for tori in general) and `ι(R)` dense in `G_∅` (strong approximation for `𝔾_a`, omitting one split place) |
| **S4. MR at degree 16** | 0.85 | not a step of F1-given-MR; it decides whether the publication instance is at [hand] through MR. PE-2's admissibility and EF_F⁺'s count (`c·M^{1/16}`) never walked at degree 16 |
| **S5. Merging sixteen real places** | 0.99 | the diagonal `ℝ² → (ℝ²)^16` is a homomorphism `UD(ℝ²) → UD(ℝ²)^{×16}`; pull back |
| **S6. De Grey's stable-place list** | 0.99 | PARI above: all stable places at `q = p ≥ 131`, unramified; Weil `0.1734`, new levels `2/132` |
| **S7. `χ(ℝ²) ≤ χ_CP(ℝ²)`** | 0.99 | de Bruijn–Erdős; a CP colouring restricted to a finite graph is proper with probability 1 |

**Outcome expectation** (at ℚ(√635087), MR assumed at degree 2): survives two blind verifiers **0.85**; a named GAP 0.10 (step 6's
format 0.04, step 5's approximation 0.03, a statement mismatch between T-J39-3's "CP colouring" and FS100-BC's `χ_CP` 0.02, SI at `k = 6`
or R-U 0.01); FALSE 0.02; in print 0.03. At de Grey's field add S4 (the publication instance's MR), 0.15 of a gap there.

### E1–E6: what my attack found (candidates for the planner)

- **E1. The composition uses T-J39-3 only at `k ∈ {5, 6}`.** If `χ(F²) = 7`, then `χ_CP ≤ 7` by a random translate of the hexagonal
  seven-colouring. At `k = 7`, 131 is **not** 7-thick by Weil (`0.1734 > 1/6`); a chain that applies T-J39-3 at `k = 7` is wrong unless the
  exact spectrum rescues it. So `N₆(F) = ∅` is the whole arithmetic hypothesis (and it implies `N_k = ∅` for `k ≤ 6`).
- **E2. Hoffman's direction, free:** if a place is `k`-thick, its target has no measurable `k`-colouring (a class of density `≥ 1/k` would
  give `a/(1−a) ≤ λ*`). So `N₆(F) = ∅ ⟹ L(F) ≥ 7`: the collapse fields are exactly where the conjecture predicts seven, and F1 cannot
  falsify the conjecture there — it makes the bold form at `F` equivalent to `χ(ℝ²) = 7`.
- **E3. F1 is not formal: an abstract control where `χ < χ_CP`.** `G = Cay(ℝ, {±1, ±√2})` has `χ = 2` (cosets of `ℤ + √2ℤ` are grids) and
  `χ_CP = 3`: a CP two-colouring is a.s. invariant under the dense group `2ℤ + 2√2ℤ`, hence under every translation, contradicting
  `c(x+1) ≠ c(x)`; three colours by `⌊x/0.8⌋ mod 3`. In T-J39-3's language the parity colouring's spectrum is the torsion character
  `(1/2, 1/2)`, a non-thick "place". **Any verifier's argument for `χ ≤ k ⟹ χ_CP ≤ k` must visibly use MR and `λ* < 1/(k−1)`; if it
  would also run on this `G`, it is a wrong-reason TRUE.** (ℚ at `k = 2`, with its dyadic ramified place of `λ* = 1`, is the arithmetic
  twin.)
- **E4. The format point** (reached before the planner's message): step 6 needs `b ↦ C(x, b)` measurable. Worth a claim of its own.
- **E5. Which problem `χ_CP(ℝ²)` is — a sketch [hand, one mind — FS103-A; unverified].** *CP ⟺ stationary with a jointly measurable
  version:* one way is Doob; the other is `E|F(0) − F(h)| = E∫_{[0,1]²}|F(z) − F(z+h)| dz → 0` by stationarity, Fubini and the
  L¹-continuity of translation. *Hence* `χ_CP(ℝ²) = χ_m⁰(ℝ²)`, the least `k` with a Lebesgue-measurable `k`-colouring proper at almost
  every edge (equivalently, by Lebesgue density points, proper off a null set of vertices). ⟸: take the weak-* orbit closure of the
  colouring in `L^∞(ℝ², Δ_k)`, an invariant probability on it (amenability), properness passing to limits because convolution with the
  unit-circle measure is compact on `L²_loc` (`|σ̂(ξ)| ~ |ξ|^{−1/2}`), continuity in probability from the L¹ argument, and a random
  threshold to round `Δ_k` to `[k]`. So, unconditionally, `χ(ℝ²) ≤ χ_CP(ℝ²) = χ_m⁰(ℝ²) ≤ χ_m(ℝ²)` — and **the stub's "`χ_CP ≤ χ_m`" is
  true but was never derived**.
- **E6. The known open problem, if F1 holds.** HN collapses to the plane's measurable chromatic number **modulo null sets**, `χ_m⁰(ℝ²)`,
  which is `χ_CP(ℝ²)` (E5). What is named in print: Falconer's `χ_m(ℝ²)` (everywhere-proper; `5 ≤ χ_m ≤ 7`, open since 1981 —
  second-hand, `[Falconer1981]` unread), and the Shelah–Soifer question of whether `χ(ℝ²)` depends on the axioms (in ZF+DC+LM it is
  `χ_m`). Given MR, F1 says the ZFC value is `χ_m⁰`; it reaches Falconer's `χ_m` only through "does null-set tolerance change `χ_m`?",
  which I do not know to be in print. Corollaries worth stating: given MR, `χ_m(ℝ²) = 5 ⟹ χ(ℝ²) = 5`; `χ(ℝ²) ≥ 6 ⟹ χ_m⁰(ℝ²) ≥ 6`.

### Hunch ledger

```
hunch: f1-composes-at-635087
  claim: given MR(ℚ(√635087)), χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²), with T-J39-3 used only at k ≤ 6 and N₆ = ∅
  basis: read
  falsifier: a step of T-J39-3's (⟹) that fails at N₆ = ∅, k = 6; or a derivation that also runs on Cay(ℝ, {1, √2})
  registered: 2026-09-26
  status: open

hunch: chi-cp-is-null-tolerant-measurable
  claim: χ_CP(ℝ²) equals the least k with a Lebesgue-measurable k-colouring of ℝ² proper at almost every edge
  basis: derived
  falsifier: a gap in the orbit-closure step (compactness of convolution with the circle measure, or the rounding)
  registered: 2026-09-26
  status: open

hunch: null-tolerance-question-not-in-print
  claim: whether χ_m⁰(ℝ²) = χ_m(ℝ²) is not stated as a question or answered in print
  basis: prior
  falsifier: the gate (FS103-G) finding it, or Falconer 1981 proving χ_m ≥ 5 explicitly modulo null sets as a named variant
  registered: 2026-09-26
  status: open

hunch: mr-degree-16-is-the-thin-link
  claim: of the publication instance's steps, the one most likely to need repair is MR at degree 16, not the composition
  basis: prior
  falsifier: a walk of PE-2 and EF_F⁺ at F_dG that needs nothing beyond degree 2's argument
  registered: 2026-09-26
  status: open
```

### Would have searched here

- Nothing yet. The PARI run is a number-theoretic enumeration of one field's primes, not a witness search.

## Stage 1 — SAVED

## Stage 4 — the comparison (V1 stages 1–3 at `d1864bd8`; V2 stages 1–4 at `e5d65927`, `accf865d`), on the owner's relay

*Read: `plans/FS103-V1-verification.md` lines 1–328 (theorems, stages 1–3; its stage 4 not opened, V1 still working), and
`plans/FS103-V2-verification.md` §2.3, stage 2b's C-FMT and C-CPM, stage 3's table, §4.1, §4.1′, and `data/fs103/reports/FS103-V2.md`. I did
not contact either verifier.*

**Agreements between V1 and V2**, each derivation blind to the other:
- **C-LB is TRUE at every `k ≥ 2` with `N_k(F) = ∅`, with no MR and no T-J39-3.** The two routes are the same in shape:
  - condition on the `T + A` factor (V1-L2, V2-L1);
  - get either an SP witness or disjoint adjacent supports (V1-L3, V2 step 2);
  - density by strong approximation;
  - weak approximation for the circle (V1 by Hilbert 90, V2 by the rational curve);
  - a jointly measurable version (V1 cites the classical theorem, V2 proves it);
  - selection with a randomised threshold on the fibre masses;
  - merge by the diagonal.
  They differ in one place: V1 selects on the Δ_k-valued conditional law, while V2 first rounds to `c′ = min supp p`. Both are sound as read.
- C-635-F1 and C-dG-F1 are TRUE given MR. The exact spectra agree: `0.192617` at 103 and `0.168047` at 131.
- C-S (c) is not finite at full depth (my registered hunch, now confirmed by two minds). C-S (d) needs Q-const.
- C-FMT (a) and (b) are TRUE. C-FMT (c), (d) and C-CPM are GAP, at the same steps in both records. C-MR16 was reached by neither.

**Divergences:**
1. **Scope (statement mismatch; not a gap).** V1 restricts to totally real `F` and says "complex places untreated". Its reason is that
   V1-L6 "needs the compact factor mixing". That reason is wrong: V1-L6 allows any second-countable LCA `G₀` and any `S₀`, and only its
   merge (V1-L8) is written for real places. V2's L4 supplies the missing merge. At a complex `v`, `a ↦ (a, ā)` embeds `ℂ` into
   `L ⊗_F F_v ≅ ℂ × ℂ` and carries the unit circle into `T(F_v) = {(z, z⁻¹)}`. I checked this and believe it is right.
   **My slip:** at stage 2 I endorsed "totally real" and the sealed wrong-reason line C-F1-GEN (3) for the wrong reason, reading
   T-J39-3's "Not claimed" as "false". A second mind for the widening is cheap: one lemma, V2's L4, plus V1-L6 read at a non-compact
   `S₀`. It has no bearing on the headline, which is totally real, and MR at complex places is itself unexercised (row 123).
   Default: record it at one mind.
2. **CTL-FRAC (agreement, not a divergence).** V2 locates integrality at L3's pigeonhole `max_j m_j(x) ≥ 1/k > θ′`. V1-L6 uses the same
   step ("exists: `max_a m_x(a) ≥ 1/k > θ`"). V1's "sharp at `K_k`" is the other side of the same inequality: the hypothesis `λ* < 1/(k−1)`,
   i.e. `λ*/(1+λ*) < 1/k`, is tight (`K_{k+1} × K_k`).
3. **C-FMT (c) and C-CPM (a gap in their route, not in the claim).** Both verifiers take the Følner limit in `[k]^{ℝ²}` (pointwise), where
   continuity in probability can fail along the sequence. A-E5 (stage 1) takes the limit in weak-* `L^∞(ℝ², Δ_k)` instead:
   - every stationary random measurable function is continuous in probability (pathwise L¹-continuity of translation plus dominated
     convergence, then mollify to a version defined at every point);
   - properness passes to the limit because `1_B (σ * ·) 1_{B′}` is compact (`σ̂ = J₀ → 0`);
   - a random threshold rounds `Δ_k` to `[k]`.
   If A-E5 holds, then with no MR, `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≤ χ_m(ℝ²)`: C-FMT (c) and C-CPM are TRUE and only (d) stays open. It is one mind,
   mine, and it needs a second.
4. **C-FMT (d) (agreed; a real gap).** Colouring the null set of non-density points is open in both records and in mine. This is the one
   step between F1 and Falconer's `χ_m`.

### Hunch ledger (status updates)

- `f1-composes-at-635087`: **confirmed** by derivation. C-LB was derived by two minds blind to each other and to J39/J48; C-635-F1 was
  assembled twice.
- `chi-cp-is-null-tolerant-measurable`: open. Both verifiers reached GAP at the Følner step by the pointwise route; the weak-* route has not
  been checked by a second mind.
- `null-tolerance-question-not-in-print`: open (the gate's record is not read here).
- `mr-degree-16-is-the-thin-link`: open (C-MR16 unreached).
- `cs-family-not-finite-at-depth`: **confirmed** by two derivations (V1 and V2, stage 2b).
- `sealed-lines-change-the-verdict-texture`: not tested. The lines were sealed, and the blind verifiers found the measurability and
  stationarity pitfalls unaided.

## Stage 4 — SAVED

## Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| A-E3 | `χ(Cay(ℝ, {±1, ±√2})) = 2 < 3 = χ_CP` | [hand, one mind — FS103-A] | E3 |
| A-E5 | `χ_CP(ℝ²) = χ_m⁰(ℝ²)`, so `χ(ℝ²) ≤ χ_CP(ℝ²) ≤ χ_m(ℝ²)` | [hand, one mind — FS103-A; a sketch] | E5 |

## Stage 2 — the planner's §G bears list read; advice sent

**Read:** FS103-P's message (§G saved at `23a6058f`): bears list, and six changes to the stub's plan (the scope narrowed to totally real,
the load-bearing step named as step 6, `N_k = ∅` exercised at `k = 4`, stop-controls K(√7)/83, K(√5)/11, ℚ(√167)/{23, 43}, Kooshi's
"only 4-quadratic field" not literal, the format worry). Agreements with my stage 1: all six. The format worry is my E4, reached
independently (my stage 1 records the timeline).

**Advice sent to FS103-P by SendMessage** (ten items, the full text in the message; summary here):
1. State the uniform bound as one claim: `sup_v λ*_v < 1/5` for the single choice `K = ∏ O_{L_w}`, `ν = ⊗ Haar(T(O_w))`, every level.
2. Step 5's two approximation inputs as claims: weak approximation for the norm-one torus (rational, so it holds; it can fail for
   tori in general) and density of `ι(R)` in `G_∅` (strong approximation for `𝔾_a`).
3. T-J39-3 is used only at `k ∈ {5, 6}`; at `k = 7` 131 is not 7-thick by Weil; hypothesis `N₆(F) = ∅`.
4. "`χ_CP ≤ χ_m`" is not derived on record; E5's sketch gives `χ_CP = χ_m⁰`; a claim C-FMT and a gate query; Shelah–Soifer to §PA.0.
5. S's scope: number fields versus all subfields of ℝ (Q-const, G63).
6. The abstract control `Cay(ℝ, {±1, ±√2})` (E3), and ℚ at `k = 2` as its arithmetic twin.
7. Hoffman's direction (E2); keep K at `k = 4` (U₄ tight, `λ* = 1/3` exactly) as the strict-inequality control.
8. Headline at ℚ(√635087); de Grey's field second, once FS-105 walks MR at degree 16.
9–10. Fence leaks: MEMORY.md's "read the handoff first" and the crunch memory file's line 48 reach every agent; fence the proofs
   (wanted-poster §3.2, J48, X21D §4, X21V §2.7–2.9) and J21-MX's proof until stage 3; the stubs, reports and records listed.

## Stage 2 — SAVED

## Stage 3 — the claim list read (`data/fs103/claims.md`, `694b7992`); advice sent

**What the planner adopted** (its message; decisions in `plans/FS103-collapse-cp-plane.md` §Stage 5): my items 1–7 and 9–10 of stage 2; item 8
in part — ℚ(√635087) is verified first, C-MR16 stays in V2's list as a one-mind first walk at degree 16, the headline held for the owner.

**Advice sent (two messages):**
1. **Fence / anchoring — the main disagreement.** The claim file sets the sub-claims C-EXTk, C-APX, C-THKDEL and C-MERGE-n beside C-LB6's
   wrong-reason lines (iv)–(vi) and I-MX's selection formula. Together they lay out the load-bearing step's whole route, so a "blind"
   derivation becomes a checking reading of the planner's decomposition (row 117's precedent), and a fresh mind no longer has to find the
   pitfalls itself. Proposed: two files. The top-level claims, definitions, inputs and controls stay in `claims.md`. The sub-claims and all
   wrong-reason lines go to `claims-sealed.md`, opened after each verifier commits its stage 3, and each verifier then scores the sealed
   decomposition against its own. If the planner keeps them, its plan should say that the step's blind content is "the CP/infinite-product
   transposition of a held lemma".
2. C-LB6 at `k ∈ {4, 5, 6}`, so C-635-F1's `χ ≥ 5` does not silently need row 123.
3. C-THKDEL's control is degenerate (`H` trivial forces a loop). A non-degenerate one: `H = ℝ`, `T_H = {±1, ±√2}`, `K = ℤ/2`, `ν = δ_1`,
   `k = 2`. There `λ* = 1`, `H × K` is CP-2-colourable, and `H` is not.
4. CTL-K7-6: "stops at `N₆ = ∅`" should read `N₆ ≠ ∅`.
5. C-S (c): my registered expectation is that the family is **not finite at full depth**, because ramification over `ℚ_p` is unbounded
   for a fixed residue field. It is finite at most up to level-one type.
6. C-MR16: last, and optional within budget.
7. C-635-PL: 2 is ramified in `F/ℚ` and split in `L/F`; "2 splits" is the wrong-reason reading.
8. C-THKDEL, checked by me (one mind, not a verifier): right as stated, with `λ*(⊗ν_v) = sup_v λ*(ν_v)` holding with equality. The
   wrong-reason line it lacks: the stationarity of the fibre integrals of a measurable **modification** must be argued, because they are
   functionals of uncountably many coordinates.
9. Forbid inputs by file and section, not by lemma name: "MXcp" and "EXT" are a two-word route.

### Hunch ledger (additions)

```
hunch: cs-family-not-finite-at-depth
  claim: the local graph types G_v, v ∈ N₆(F), over all totally real F, are infinitely many at full depth (finite at most up to level-one type)
  basis: derived
  falsifier: a proof that CP k-colourability of UD(ℝ²) × ∏ G_v depends only on the level-one targets
  registered: 2026-09-26
  status: open

hunch: sealed-lines-change-the-verdict-texture
  claim: verifiers who read the wrong-reason lines before deriving name no pitfall outside the planner's list
  basis: prior
  falsifier: a verifier with the lines in view naming a pitfall the planner's list lacks
  registered: 2026-09-26
  status: open
```

## Stage 3 — SAVED
