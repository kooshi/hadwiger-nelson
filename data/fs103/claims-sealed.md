# FS-103 — the claim list, sealed half

*Written by the planner (job FS103-P), 2026-09-26. **A verifier opens this file only after its own stage 3 is committed**, then scores it
against its derivation: for each sub-claim, "agree" or what it missed or found extra; for each wrong-reason line, whether its own derivation
avoided it, and how. Definitions and inputs are those of `data/fs103/claims.md`. The advisor's contributions are marked. No proof is here.*

## 0. The held mixing selection (moved here by the owner's ruling)

- **I-MX** (`plans/M3-derivation.md` M3-J21-MX): "`K` compact abelian, `ν` a probability on `T_K ⊆ K`, `λ* = sup_{ξ≠0}|ν̂(ξ)| < 1/(k−1)`: for
  every Borel graph `X`, a Borel proper `k`-colouring of `X × Cay(K, T_K)` yields the Borel proper `k`-colouring `φ(x) = min{j :
  μ(W(x,·)^{-1}(j)) > λ*/(1+λ*)}` of `X`; for measurable `W` proper off a null vertex set, `φ` is measurable and proper off a null vertex set"
  (format N′). [hand, two (J21; J22)] — the Borel/measurable form, one compact factor; its CP form over infinitely many factors is not an input.

## A. The load-bearing claim, decomposed (sub-claims C-THKDEL, C-EXTk, C-APX, C-MERGE-n)

- **C-THKDEL (the step in its arithmetic-free form; this list's wording).** Let `H` be a second-countable LCA group with `T_H ⊆ H`, and `K =
  ∏_{v ∈ V}` of countably many compact abelian second-countable groups `K_v`, with probabilities `ν_v` on `T_v ⊆ K_v`, `T_K = ∏_v T_v`, `ν =
  ⊗_v ν_v`, and `λ*(ν) = sup_{ξ ≠ 0} |ν̂(ξ)| < 1/(k−1)`. Then every CP `k`-colouring (D-CP (b)) of `Cay(H × K, T_H × T_K)` yields a CP
  `k`-colouring of `Cay(H, T_H)`.
  - *Wrong-reason TRUE:* as C-LB (iv)–(vi), (viii); and treating `λ*(⊗ν_v)` as `sup_v λ*(ν_v)` without saying why (true or false, it needs a line).
  - *Control (the advisor's; non-degenerate):* `H = ℝ`, `T_H = {±1, ±√2}`, `K = ℤ/2`, `ν = δ_1`, `k = 2`: `λ* = 1`, the hypothesis fails;
    `H × K` has a CP 2-colouring (a pullback from `ℤ/2`, randomly shifted) and `H` has none (`χ_CP(H) = 3`) — the conclusion fails exactly
    when the hypothesis does.

- **C-EXTk (this list's wording).** I-EXT4 holds with "four" replaced by "`k`" (simplex embedding) and `S = ∅`, for every totally real `F`
  outside row 100's exception: a translation-invariant random `k`-colouring of `Cay(R, U)` with spectrum on `T + A` extends to a
  `G_∅`-stationary process, continuous in probability, with a jointly measurable version, proper a.s. at every fixed edge `(x, x + w)`, `w ∈ T_∅`.
  - *Wrong-reason TRUE:* an extension to `ι(R)` only, not to `G_∅`; properness checked on `ι(U)` and not on its closure.

- **C-APX (this list's wording, two parts).** For a totally real `F` outside row 100's exception: (a) the closure of `ι(U)` in `(L ⊗ ℝ) ×
  ∏_{stable w} O_{L_w}` is the full product of the local circles `∏ S¹ × ∏ T_w`; (b) `ι(R)` is dense in `G_∅`, so `T + A` is the image of the
  dual map `Ĝ_∅ → R̂`.
  - *Wrong-reason TRUE:* "weak approximation" cited for tori in general (it fails for some tori); name why it holds for this norm-one torus.

- **C-MERGE-n (this list's wording).** For a totally real `F` of degree `n`, `Cay((L ⊗ ℝ), cl ι(U))` has a CP `k`-colouring iff `UD(ℝ²)` does
  (`n` real places merge; `n = 2` at ℚ(√635087), `n = 16` at `F_dG`).

## B. What a pass for the wrong reason would look like, per claim

- **C-F1-GEN** — *Wrong-reason TRUE:* a chain that applies the `k`-colour step at `k = 7` (at `F_dG`, 131 is not 7-thick: `0.1734 > 1/6`); a chain that
    needs no MR and no `λ* < 1/(k−1)` (it would also "prove" the controls CTL-ABS and CTL-Q2); a chain valid for fields with complex places.

- **C-LB** — *Wrong-reason TRUE:* (i) citing T-J39-3, T-J39-1 or T-J39-4, or reading a fenced proof; (ii) deleting a place because its independence ratio is `< 1/k` rather
    than because `λ* < 1/(k−1)` (false in general: row 109, 125 colours); (iii) checking only `λ_min/d` (Hoffman's sign) instead of
    `sup|ν̂|`, both signs; (iv) using a place-dependent `(K_v, ν_v)` without producing one threshold below `1/k` that works for all places at
    once; (v) a selection `x ↦ min{j : Haar{b : C(x,b) = j} > θ}` that assumes `b ↦ C(x, b)` measurable without producing a jointly
    measurable version (D-CP (b) excludes joint measurability from the definition); (vi) Fubini on a null set of edges read as properness at
    every fixed edge; (vii) an argument that would also run on CTL-ABS; (viii) the fibre-measure vector `x ↦ (m_j(x))_j` of a measurable
    *modification* called stationary "because `C` is": the modification has the right finite-dimensional laws, and `m_j` depends on
    uncountably many coordinates — the step that fixes its law from finite-dimensional ones (e.g. `m_j` as an `L²`-limit of finite averages)
    must be written (the advisor's).

- **C-635-PL** — *Wrong-reason TRUE:* "2 splits in `F`": 2 is ramified in `ℚ(√635087)/ℚ`, and its one place is split in `L/F` because
    `ℚ₂(√635087) = ℚ₂(√7) = ℚ₂(i)` (the advisor's).

- **C-635-THK** — *Wrong-reason TRUE:* the ramified place 635087 or the dyadic places left out; Weil applied at a place whose residue field is not `𝔽_q`
    with `q ≡ 3 (mod 4)`.

- **C-dG-PL** — *Wrong-reason TRUE:* the residue field read from the subfield (G43: "a larger field can LOSE a prime its subfield had" — 11 has residue
    degree 2 in `F_dG`); a list over the unramified primes only.

- **C-MR16** — *Wrong-reason TRUE:* "row 120 says every real number field" taken as the check; the check is that each hypothesis is met at `F_dG`.

- **C-S** — *Wrong-reason TRUE:* S over all subfields written from number fields alone; place types counted by residue field alone.

- **C-S (c)** — *Registered expectation (the advisor's and the planner's):* not finite at full depth — for a fixed residue field the
    local field `F_v` can have unbounded ramification over `ℚ_p`, and the deeper levels of `G_v` differ; finite at most up to level-one type.

## C. The planner's and the advisor's controls (moved here by the owner's ruling)

- **CTL-167-4:** ℚ(√167), `k = 4`: every stable place is 4-thick (row 123: "`χ(ℚ(√167)²) ≥ 5` by two routes (the class; every stable place
  4-thick)"), so C-LB at `k = 4` plus I-CP57 gives `χ(ℚ(√167)²) ≥ 5` given MR — agreeing with row 123's class route.
- **CTL-dG4:** `F_dG`, `k = 4`: all stable places 4-thick; the same gives `χ(F_dG²) ≥ 5` given MR — agreeing with I-DG5 (kernel, no MR).
- **CTL-K-4 (tight boundary):** K = ℚ(√3,√11), `k = 4`: its dyadic places are stable and Hoffman-tight at four colours (`λ_min = −d/3`,
  row 67), so `λ* ≥ 1/3` and the chain stops at `N₄ ≠ ∅`; `χ(K²) = 4` (row 57).
- **CTL-K7-6:** `K(√7)`, `k = 6`: the place above 83 is not 6-thick (row 68: six at 83 needed a certificate beyond Hoffman) — the chain stops
  at the step "`N₆ = ∅`" (it fails: `N₆` holds the places above 83); at `k = 5` it goes through (`2√83/84 = 0.217 < 1/4`), giving, given MR, `χ(K(√7)²) ≤ 5 ⟺ χ_CP(ℝ²) ≤ 5`.
- **CTL-K5-5:** `K(√5) = ℚ(√3,√5,√11)` (Heule's field, `χ = 5`, row 53): 11 is usable and not 5-thick — the chain must stop, or it would
  "prove" `χ_CP(ℝ²) ≤ 5`.
- **CTL-167-5:** ℚ(√167), `k = 5`: `N₅ = {23, 23′, 43, 43′}` (row 110) — the chain stops; what holds is row 125's B-1.
- **CTL-ABS (arithmetic-free; the advisor's):** `G = Cay(ℝ, {±1, ±√2})` has `χ = 2` and `χ_CP = 3`: an argument for "χ ≤ k ⟹ χ_CP ≤ k" that
  would run on `G` is a wrong-reason pass. Check both values.
- **CTL-Q2:** ℚ at `k = 2`: the dyadic place is stable and ramified in `L/F` (`λ* = 1`), `χ(ℚ²) = 2`, `χ_CP(ℝ²) ≥ 5` — the chain must stop there.

## Owner's addition (2026-09-26, after the verifiers' launch) — CTL-FRAC, from the prior-art reader

*Added by the product owner from `plans/FS103-G-prior-art.md` §2.3 item 2 (the reader's words, one mind, a reading). Score it at stage 4 like
the other controls.*

- **CTL-FRAC.** Two published texts conjecture that the finitary fractional chromatic number of the plane is 4 while its measurable density is
  below 1/4: `[AmbrusEtAl2023]` §4 Remark ("we venture to conjecture that χf(R²) = χgf(R²) = 4. This would imply that α₁(R²) = 1/4 and m₁(R²)
  ≤ 0.247 hold simultaneously"), and `[MatolcsiEtAl2025]` ("Conjecture 1. χf,0(R²) = 4, and for all finite unit distance graphs G ⊆ R² we have
  χf(G) < 4"). The reader's words: "**if the chain's direction "a colouring of `F²` gives a CP colouring of `ℝ²`" runs on one colour class at a
  time** — one random independent set of density `δ`, with thickness at `λ* < δ/(1−δ)` — then at `F_dG` … it proves `α₁(ℝ²) ≤ m₁(ℝ²) < 1/4`,
  i.e. a finite unit-distance graph with `χ_f > 4.04`, refuting the published conjecture … If it does not, the step where the other classes
  enter … is where integrality carries F1." **Say which, for your own derivation of C-LB: does it run on one colour class at a time? If
  not, name the step where a second class enters.**
