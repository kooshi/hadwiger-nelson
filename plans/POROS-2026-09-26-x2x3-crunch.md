# Poros, advisor of the ×2×3 crunch (2026-09-26, 10:26–12:26 UTC)

*Brief: `data/crunch-2026-09-26-x2x3/briefs/ADV-x2x3-poros.md`. Planner: de Bruijn (queue `plans/CRUNCH-2026-09-26-x2x3-queue.md`).
Read before this stage: LEDGER rows 116–118; `plans/FS100-three-field-lemma.md` §PA, §IQ; `plans/STUB-measure-rigidity-three-fields.md`
(grep for SP, PE-lim, SP-Cor); my J50 card `plans/POROS-2026-09-26-next-two-milestones.md` §3. The planner's drafts were not read.*

## Stage 0 — expectation, written before the planner's drafts — SAVED

### 0.1 What "×2×3" is here

"The ×2×3 problem" names three different statements, and the crunch has to say which one it attacks:

| # | statement | who needs it | honest probability of landing in 2 h |
|---|---|---|---|
| X1 | Furstenberg's conjecture: ×2,×3-invariant ergodic measures on 𝕋 are Lebesgue or atomic | nobody here directly | < 0.1 % |
| X2 | MR(F)'s zero-entropy half: a `U`-invariant, `E`-null measure on `R̂` with zero entropy is 0 | SP-Cor: MR(ℚ(√47)) ⟹ χ = 5 | ~ 5–10 % (after 0.3 below; ≤ 1 % before) |
| X3 | the project's actual need: no four-colouring of ℚ(√47)'s plane | the conjecture's five-clause | via X2, or via the G79 flip |

SP ⟺ ¬MR (J46-8, two derivations): at the level of measures the colouring adds nothing to MR. So the G79 flip (does an actual
four-colouring's process force positive entropy?) must use what a colouring carries beyond its spectral measure `σ_μ`.

### 0.2 My expectation, before any new reading

- The best two-hour attack is **not** on X1. It fixes where X2 sits relative to X1, and it names the step that decides that.
- A hardness reduction MR ⟹ (an open Furstenberg case) is unlikely, at about 5 %. A `U`-invariant measure is invariant under
  infinitely many independent multipliers. Building one from an exotic ×a×b measure needs averaging, and averaging tends to
  produce Haar or a measure carried by `E`. **More invariance makes MR easier than X1, not harder.**
- PE-lim, the step from EL2021 Thm 1.3 at a finitely generated `Γ` to all of `U`: about 45 % in an hour with a blind verifier. The
  input is that `U` acts irreducibly on `R̂` even though no finitely generated `Γ` does, because the closed `U`-invariant subgroups
  are `ann(I)` for ideals `I` of the Dedekind ring `R`, and each is finite or all of `R̂`.
- The G79 flip in two hours: about 15 % for a theorem either way. There is no known link between the entropy of the colouring
  process and the entropy of `U` on `σ_μ`.
- **The first three jobs I would start:**
  - (1) the model-problem reading;
  - (2) PE-lim with a blind verifier;
  - (3) the G79 flip as a derivation.

### 0.3 The surprise, found during stage 0 (a zbMATH query, the review read)

The model problem is Furstenberg for a **large** multiplier set. For that, rigidity is **proved**:

- **Einsiedler–Fish**, ETDS 30 (2010) 151–157, **Zbl 1189.37005**.
  - **Theorem:** if `liminf log#(Σ∩[1,N]) / log N > 0`, every ergodic Σ-invariant measure on 𝕋 is Lebesgue or finitely supported.
  - **Proof shape:** Johnson reduces to the case where every `n` has zero entropy, and EF show that zero entropy for some `n`
    forces finite support.
  - **Status:** I read the reviewer's review, not the paper. It is **not** in `BIBLIOGRAPHY.md`.
- A finitely generated Σ grows only polylogarithmically, so the hypothesis requires **infinitely many generators**.
- Our `U_F` has polynomial growth when `u` is measured by `e^{h_Haar(u)}`, the norm of its split-place denominator. Over ℚ, the
  rational points of the circle with denominator `≤ N` number about `cN`.
- **This contradicts my J50 hunch `mr-is-open-measure-rigidity`.** That hunch had an escape clause: "unless the stub's hypotheses
  supply the entropy or rank that the known theorems need". The clause may fire, because infinite rank is exactly EF's hypothesis.
- **What does not transfer for free:**
  - (a) `R̂` has dimension `2[F:ℚ]` and the acting group is a norm-one torus of automorphisms, not a semigroup of endomorphisms of 𝕋;
  - (b) the archimedean directions are isometric for every `u`, so zero-entropy invariant measures exist on the archimedean leaf `A`.
    The transferred conclusion therefore has to be "carried by `E`", not "finite".
- **Revised estimates:**
  - MR in 2 h: about 5–10 %.
  - EF read and either transferred or its failing step named, in 2 h: about 60 %.
  - The hardness reduction: below 5 %, and to be run only after EF is read.

**Sent to the planner at 05:3x as frame item 1** (EF as the rank-1 reading-and-transfer job, and no hardness job before it).

### 0.4 Hunch ledger (this crunch)

hunch: mr-is-open-measure-rigidity (J50; re-registered here)
  claim: MR(F) is at least as hard as an open Furstenberg-type measure-rigidity problem
  basis: prior
  falsifier: MR reduced to published theorems whose hypotheses hold here
  registered: 2026-09-26 (J50)
  status: **in doubt** — Einsiedler–Fish 2010 (review read) proves the large-semigroup analogue, and `U` is large. The test is EF's
    transfer to `U` on `R̂`.

hunch: ef-transfers-modulo-archimedean
  claim: EF's zero-entropy argument transfers to `U` on `R̂`, with the conclusion "carried by `E`"; the only new input is the
    isometric archimedean direction, where the measures are in `A` by definition
  basis: analogy
  falsifier: a step of EF that uses expansion of every nontrivial `n` (true on 𝕋, false along `A`), or the non-invertibility of `×n`,
    with no substitute here
  registered: 2026-09-26
  status: open — about 35 %

hunch: hardness-reduction-false-in-spirit
  claim: no two-hour job proves MR(F) ⟹ an open case of Furstenberg's conjecture
  basis: derived (the averaging argument, 0.2) and read (EF)
  falsifier: a construction taking an exotic ×a×b measure to a non-Haar, `E`-null, `U`-invariant measure
  registered: 2026-09-26
  status: open — about 95 %

## Stage 1 — Einsiedler–Fish read in full; two messages to the planner — SAVED

**EF read** (arXiv 0804.3586v2, all 8 pages; copy `data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf`, text `ef.txt`).
Theorem 1.2 = Johnson (positive entropy ⟹ Lebesgue) + Lemma 3.2 (zero entropy of one `p` ⟹ finite support). Lemma 3.1 is SMB: zero
entropy ⟹ `µ(B_δ(x)) > δ^β` on a set of mass `1 − ε`. Lemma 3.2: `M^{α/2}` images `qB_δ(x)` of mass `> δ^β` must meet, whence
`x ≈ k/ℓ`, `ℓ < M`, error `2M^{-4}`; then `|k₁/ℓ₁ − k₂/ℓ₂| ≥ 1/(ℓ₁ℓ₂)` stabilises the rational, so `x = k/ℓ`. §4: Nazarov's
semigroups of positive density along which `Σα` is not equidistributed (so the mechanism is not equidistribution). EF also note that
at `α = 1` Wiener's lemma suffices.

**My transfer sketch** [reading, one mind, not a derivation]: the separation step is the product formula; done adelically (lift to
`∏O_w ×` a fundamental domain at `∞`) the archimedean freedom lands in `A`, so the natural EF_F conclusion is "zero entropy for every
`u` ⟹ carried by `T + A`" — inside `E`. The positive-entropy half becomes the Johnson analogue, i.e. PE-lim / the planner's PE-2 —
**the crux moves to positive entropy, where the literature is strong.** Wiener's shortcut fails here: a `U`-orbit in `R` lies on one
archimedean circle, of density zero in any Følner set — the same fact as the circle measures in `A`.

**Named risks for EF_F** (sent): (i) Lemma 3.1 gives smallness only at `S(u)` (take `u = ∏u_p`); (ii) `ℓ = v₁ − v₂` can be tiny
`w`-adically at `S` — EF has `|ℓ| ≥ 1` free; (iii) `#{v ∈ U : H(v) ≤ M} ≥ M^α` over general `F` (anisotropic torus point count).

**The planner's two items** (de Bruijn, 05:35): (1) PE-2 — Thm 1.2 applies on `M̂` for a finitely generated `ℤ[Γ]`-module `M`,
`ℚM = L` (J51-T2's objection is about `R̂` only), then pass to the inverse limit. I checked total irreducibility in one line (`M/N`
finite length over a 1-dimensional Noetherian domain with finite residue fields) and named the risk: Thm 1.2 wants `Γ`-ergodicity,
`µ` is only `U`-ergodic. (2) FR-1 — `U` acts transitively on quadrance fibres, so MR is a Schoenberg-type theorem: radial
positive-definite functions on `R` with `E`-null spectral measure are `c·δ₀`. I added: `E`'s members are local spherical functions
(a circle in `A` has `τ̂(r) = J₀(2πρ|r|_∞)`); the discipline is **character rigidity** (a `U`-invariant positive-definite function on
`R` is a character of `R ⋊ U` restricted to `R`), and the J51 debt Bekka–Francini (Zbl 1518.22005) is now load-bearing.

**Frame items sent:** the claim ladder (a "χ(ℚ(√47)²) = 5" headline would rest on SP-Cor and K0, one mind each → a blind SP-Cor check,
or cap the headline at "MR(F) given PE-2 and EF_F"); EF_F's own prior art (5 citing works in OpenAlex; "Strongly independent matrices
and rigidity of ×A-invariant measures on n-torus", 2023, and Huang 2017, Zbl 1402.37006, first).

hunch: ef-transfers-modulo-archimedean — **re-scored after the full reading: about 45 %** (the Diophantine step is the product formula,
which is global; risk (ii) is the one I cannot see through in my head).

hunch: pe2-lands
  claim: PE-2 (positive entropy for some `u` ⟹ `τ = a·Haar + τ′`, `τ′` of zero entropy for every `u`) lands in the crunch with a blind verifier
  basis: derived (the planner's route; my irreducibility check)
  falsifier: the `Γ`-ergodic decomposition of `µ_M` producing zero-entropy components that do not recombine, or Thm 1.2's hypotheses failing on `M̂`
  registered: 2026-09-26
  status: open — about 55 %

### Would have searched here (stage 1)
- None: one zbMATH query, one arXiv query and one OpenAlex citing-works query, all literature.

## Stage 2 — the EF_F sketch sharpened; Bekka–Francini discharged at the abstract — SAVED

**Bekka–Francini** (arXiv 2002.07497, **abstract read, paper unread**): it assumes `G(k)` is generated by unipotents, and it uses Ratner.
`R ⋊ U` is a torus acting on a line, so the hypothesis fails. MR sits on the Cartan side (EL, EF), not the unipotent side. Sent to the planner.

**EF_F sketch** [reading, one mind, unchecked; sent to the planner at about 05:45 for X1D's brief, and withheld from X1V]:
- (a) **Multiply through instead of dividing.** Take `z = ℓ₂r₁ − ℓ₁r₂ = ℓ₁e₂ − ℓ₂e₁ ∈ R`. It is small at `S`, has height
  `M^{O(1)}` off `S`, and is bounded at `∞`. The stable places contribute `≤ 1`. The product formula then gives `z = 0`.
  Risk (ii) disappears, because no `|ℓ|_w⁻¹` enters.
- (b) **One prime suffices.** Lemma 3.1 and the adelic Lemma 3.2 at `S = {π, π̄}` give that `µ` is carried by `T + K_S`, where
  `K_S` is the injective image of `V_S = ℂ × ∏'_{w∉S} L_w`, and `K_S ∩ T = 0`.
  - The stabiliser of a leaf is a congruence subgroup of finite index.
  - For each `q ∉ S`, the element `u_q^k` acts hyperbolically, as `(a, a⁻¹)`, at `(π_q, π̄_q)`.
  - A finite invariant measure then gives measure zero to `{x ≠ 0}`: the function `log|x|` shifts by `log|a| ≠ 0` under the map.
  - So `µ` is carried by `T + A`.
- (c) **Lemma 3.1 transfers** (checked in my head after sending). Partition the fundamental domain `∏O_w × D_∞` into pieces that
  are small at `S` and at `∞`. Nonzero `r ∈ O_L[1/p]` with `|r|_∞ ≤ 2η` satisfy `|r|_π|r|_π̄ ≥ 1/(4η²)` by the product formula.
  Hence the reductions agree step by step, and the atoms of the two-sided refinement are `ηp⁻ⁿ`-small at `S`. This is the usual
  local-injectivity argument, and it works because the partition also controls `∞`.
- **EF_F stated:** every ergodic `U`-invariant `µ` with `h_µ(u_p) = 0` for **one** split `p` is carried by `T + A ⊂ E`. With PE-2,
  this gives MR(F) for **every** real number field.
- **Control sent:** MR has to be consistent with the four-colourings known to exist (Theorem B at K, and ℚ(√11)'s non-periodic ones
  from row 94). Their spectral measures lie in `T + Fin_S` plus Haar. SP-Cor must therefore fail at those fields exactly at T-C(A).

hunch: ef-transfers-modulo-archimedean — **re-scored: about 60 %** (after (a)–(c)). The falsifier is now precise: a step of the
adelic pigeonhole where an image `vB` fails to have measure `≥ µ(B)`, or where the height bound off `S` is not polynomial in `M`.

hunch: mr-is-open-measure-rigidity (J50) — **likely killed if X1 and X2 land.** Its escape clause fired: the infinite rank (EF's
growth) supplies what the known theorems need. The killing stays pending until X1V and X2V verify.

### Would have searched here (stage 2)
- None: one arXiv API query (literature).

## Stage 3 — the planner's queue draft (`8c865d6f`) reviewed — SAVED

The draft was read after stages 0–2 were saved. It adopts EF as route (A) [P-1], PE-2 as route (B) and FR-1 as route (C). The claim
lists are fixed at 05:45. Pushes sent at about 05:48, ranked:
1. **Waves.** Blind verifiers derive from the fixed claim lists, and the clerk is idle until reports exist. So wave 1 should be
   X01D, X01V, X02D and X02V; wave 2 (about 06:05) X05V (SP-Cor and the ladder), then X03D.
2. **ED-2 is harder than MR** (EF §4: Nazarov's semigroups are rigid without equidistribution). ED-1 is one line. Cap ED-2 at
   20 minutes, with GAP-at-a-step the expected outcome.
3. **EF-G(b) in two lines.** `U_ℚ ⊆ U_F`, and `H_L = H_{ℚ(i)}^{[F:ℚ]}`, so `#U_N(F) ≥ #U_{N^{1/n}}(ℚ) ~ N^{1/n}/(2π)`
   (primitive Pythagorean triples).
4. **EF-X is TRUE in one line** (the circle measure in `A`). EF_F may be stated in the stronger form `µ(T + A) = 1`.
5. **Missing items.** The known-positive control (K, ℚ(√11)). And PE-1 needs `ℚ(Γ′) = L` for every finite-index `Γ′`, not only
   for `Γ`.

### Would have searched here (stage 3)
- None.

## Stage 4 — PE-2's snag and fix; EF_F checked further; owner report — SAVED

**PE-2 snag** [reading, one mind]: `M` is only a `ℤ[Γ]`-module, so `U` does not act on `M̂`, and the planner's "components permuted
by `U`" cannot be said there. **Fix:**
1. Take the `Γ`-ergodic decomposition of `µ` on `R̂` itself. Each component pushes to a `Γ`-ergodic measure on every `M̂`.
2. If a component has positive entropy for `u`, then Thm 1.2 on a cofinal family of `M` makes it `m`.
3. Otherwise the component has zero entropy for all of `Γ`.
4. `U` commutes with `Γ`, so the split `µ = a·m + ν` is `U`-invariant, and `U`-ergodicity forces `a ∈ {0, 1}`.
5. **Ergodic PE-2 follows:** `µ = m` or `h_µ(u) = 0` for every `u`. Ergodic PE-2 plus EF_F gives ergodic MR, and ergodic
   decomposition then gives MR, since `E` is a `U`-invariant Borel set.

**EF_F further checks:**
- Lemma 3.1 transfers by local injectivity: the correction `r` has `|r|_π|r|_π̄ ≥ 1/(4η²)` unless `r = 0`.
- The last step divides by `|ℓ_k|_w`, which is fine because `|ℓ_k|_π|ℓ_k|_π̄ ≥ cM_k⁻²`, so the error is `≤ CM_k^{4−K}`.
- The pigeonhole needs `β < α/K`.
- A finite `U`-invariant measure on a Fin_S leaf lies in `T + A`, which matches R-U, a held result with two derivations.

hunch: ef-transfers-modulo-archimedean — **about 75 %** (a complete sketch now exists in my head; one mind, fluent, discounted).
hunch: pe2-lands — **ergodic form about 70 %**.
hunch: both-verified-in-crunch
  claim: X01V and X02V both verify EF_F and ergodic PE-2 before 06:55
  basis: derived (the sketches) and measured (the last crunch's verifier times, about 45–60 minutes)
  falsifier: either verifier returns FALSE or GAP, or neither has reported by 06:55
  registered: 2026-09-26
  status: open — about 45 %

**Owner report sent (about 05:47).** Recommendation on staying on: yes, but off-slot. I hand back at about 06:05 so the verifiers
get the slots; resume me by SendMessage at about 06:40 to read X01D's and X02D's drafts against my sketch (about 30k tokens).

### Would have searched here (stage 4)
- None.

## Stage 5 — for the close: where this came from, and the misses it exposes — SAVED

- **Where the route came from.** Neither G72's structural question nor a search produced it. It came from a recognition in the
  discipline's own words: `U` is a *multiplicative semigroup of polynomial growth*. The prior-art gate (G49/G46) did the work. The
  invariant used is the acting group's growth, not an invariant of solutions. G79: an example invariant of the acting group, not a
  counterexample invariant. **G72: from elsewhere (recognition).**
- **The miss, for 3.1/G49's instances.**
  - FS-100's gate (J51 §PA.2) searched `solenoid & invariant measure & (S-adic | infinitely many primes | S-integers)`, got 0 hits,
    and read the zero as support for "MR is ×2×3-hard".
  - The theorem that decides it is stated on 𝕋 for semigroups of ℕ, in one-dimensional vocabulary. The negative measured its query's
    words (G21, G49).
  - My own J50 hunch said "unless the stub's hypotheses supply the entropy **or rank** the known theorems need". Its escape clause
    named the resource, but I did not check it: at J50 I never asked whether infinite rank is a hypothesis anywhere in print.
    **Owned.**
- **Honesty line for the report.** If X01 and X02 land, the crunch has not touched the classical ×2×3 conjecture. It has shown that
  the project's version sidesteps it, because `U` is large. That is the sentence Kooshi should read first.
- **Consequences to list at the close, each with its weakest link:**
  - MR(F) for every real number field;
  - five at ℚ(√47), by SP-Cor (one mind, re-derived), T-C(A) (row 117) and A⁺;
  - five at ℚ(√143), ℚ(√311), ℚ(√335), by K0 (one mind);
  - `χ(ℚ(√167)²) ≥ 5`, which the stub's third poster names;
  - row 88 at ℚ(√59), ℚ(√83), ℚ(√131), given T-B1.
- **The control, stated plainly.** MR must hold at K and at ℚ(√11), where four-colourings exist, and SP-Cor must fail there exactly at T-C(A).

### Would have searched here (stage 5)
- None.

## Stage 6 — the launched briefs checked for blindness; EL2021 fetched — SAVED

- **Blindness check (05:45).** I grepped `X01V`, `X02V` and `X05V`'s briefs for my sketch's distinctive terms (multiply through;
  Poincaré; local injectivity; decompose on `R̂`; product formula; `T + A`; sketch). The only hit is `X01V`'s citation of row 98
  (`Θ_k ⊆ T + A`), which is a held result and not my sketch. **All three are clean.** `X01D` and `X02D` carry my messages verbatim
  as addenda, each marked "[reading, one mind] — write out or refute, never trust".
- **EL2021 copy.** The path in J51's record, `data/fs100/j51/el2021.pdf`, does not exist, so I fetched arXiv 2101.11120v1 to
  `data/crunch-2026-09-26-x2x3/poros/el2021-2101.11120.pdf`. I read pp. 1–3: Thm 1.2 and the definition of "totally irreducible",
  both quoted verbatim to the planner. Thm 1.2 needs `α`-ergodic `µ`, which confirms that the PE-2 fix, decomposing on `R̂`, is needed.
- **Simplification sent.** MR needs zero entropy for only one `u′`. Ergodic `µ ≠ m` gives `h_µ(u′) = 0` for an admissible `u′`, and
  EF_F then applies. `Γ`'s total irreducibility needs only one generator whose powers all avoid the proper subfields of `L`.
- **Companion skills.** I skimmed `poros-anomaly-hunt` and `poros-reframing` at their openings only. The reframing skill's test,
  "a wall of given brick is a theorem, and its door is the hypothesis the situation does not satisfy", is this crunch's move exactly:
  ×2×3's wall stands on a finitely generated multiplier set, and `U` fails that hypothesis.

### Would have searched here (stage 6)
- None: one arXiv fetch (literature).

## Stage 7 — X01V's GAP tested against my sketch (resumed 05:58, owner's request) — SAVED

**Read:** `plans/FS100-X01V-verification.md` §2.2–§2.4. Fenced files were not opened, and none of the derivers was messaged.

### 7.1 Verdict: UZ is not needed. The GAP sits in the literal transcription of EF Lemma 3.2, and my route (a) closes it.

- **X01V's steps 2–3.** X01V keeps EF's requirement that the images `u′N` be **small**. That leaves only the multipliers supported in
  `supp(u)`, and there are `(log M)^k` of them, which is lacunary.
- **Why the requirement is unnecessary.** The pigeonhole uses only measure: `µ(vN) = µ(N)` holds for **every** `v ∈ U_M`, however fat
  `vN` is off `S`. Where the images are fat, only the error bounds at the places off `S` are affected, and the product formula pays
  for that with the height, which is `M^{O(1)}` with a **fixed** exponent. Thinness at `S` is `δ = M^{−K}` with `K` **free**, because
  Lemma 3.1′ allows every `β > 0`.
- **The only element whose entropy is used is the fixed `u`.** So `δ₀(u)` and `X′` do not move with `M`, and UZ, the uniform-in-`M`
  bound, never arises.
- **X01V's item 4 already names the tool** ("the product formula with heights"). It does not notice that the same tool removes item 2's
  smallness requirement. **Its step 4(i) (tiny `|ℓ|_∞`) is harmless:** nothing is ever divided at `∞`, and a small `|ℓ|_∞` only
  enlarges `|ℓ|_π|ℓ|_π̄`.

### 7.2 The step, written out [hand, one mind; for totally real `F`]

**Setting.**
- `F` is totally real of degree `n`, and `L = F(i)`, so every `u ∈ U` has `|u|_v = 1` at the `n` complex places.
- The cover is `Y = L_∞ × ∏'_{w split} L_w`, and `R̂ ≅ Y/Λ`, where `Λ` is the dual lattice (`R` up to a fixed fractional ideal).
- The fundamental domain is `D = D_∞ × ∏ O_w`. It is one because `Λ ∩ (L_∞ × ∏O_w)` is a lattice in `L_∞`, and strong approximation
  away from `∞` gives surjectivity.
- The zero-entropy element is a fixed non-torsion `u`. Let `S = supp(u)`, the split places where `|u|_w ≠ 1`, and let `λ = min_{w∈S}
  |u|_w^{±1} > 1`.

**L3.1′.**
- Take `ξ`, a finite partition of `D` that is `η`-small at `∞` and at `S`, with no condition elsewhere.
- For the atoms of `⋁_{|i|≤k} u^{−i}ξ`, the corrections are elements `r ∈ Λ`. They satisfy `|r| ≤ 2η` at `∞`, `≤ C_uη` at `S`, `≤ 1`
  at split `w ∉ S`, and a fixed bound `c_v` at the stable places.
- The product formula therefore forces `r = 0`.
- So an atom is `x̃ + {d : |d|_∞ ≤ η, |d|_S ≤ ηλ^{−k}, d_w ∈ O_w elsewhere}`.
- Shannon–McMillan–Breiman and `h_µ(u) = 0` then give: for every `β, ε`, there are `X′` with `µ(X′) > 1 − ε` and `δ₀`, such that
  `µ(B) > δ^β` for the atom `B ∋ x` at every thinness `δ ≤ δ₀`. The same statement as X01V's L3.1 analogue.

**L3.2′ — pigeonhole.**
- Fix `x ∈ X′` and `M`. Set `δ ≈ M^{−K}` and take `β < α/K`, where `#U_M ≥ cM^α` (X01V's EF-G (b) gives `α ≥ 1/h_L`).
- Then `#U_M·δ^β > 1`, so `v₁B ∩ v₂B ≠ ∅` for some `v₁ ≠ v₂` in `U_M`.
- Lifting: `ℓx̃ − r = e := v₂d₂ − v₁d₁`, with `ℓ = v₁ − v₂ ∈ R ∖ 0` and `r ∈ Λ`.
- **Bounds on `e`:**
  - at each `∞`: `≤ 2η`;
  - at `w ∈ S`: `≤ Mδ`;
  - at split `w ∉ S`: `≤ m_w := max(1, |v₁|_w, |v₂|_w)`, with `∏ m_w ≤ H(v₁)H(v₂) ≤ M²`.
- **Bounds on `ℓ`:** `≤ 2` at `∞`, `≤ M` at `S`, `≤ m_w` off `S`, `≤ 1` at the stable places.

**L3.2′ — separation (my check (a)).**
- Take two scales: `M₁` and `M₂ = M₁²`.
- Set `z := ℓ₂r₁ − ℓ₁r₂ = ℓ₁e₂ − ℓ₂e₁ ∈ Λ`.
- **Normalised bounds on `z`:**
  - at each `∞`: `≤ (8η)²`;
  - at each `w ∈ S`: `≤ M₁M₂δ₁ = M₁^{3−K}`;
  - off `S`, in product: `≤ ∏ m_w^{(1)}m_w^{(2)} ≤ M₁⁶`;
  - at the stable places, in product: `≤ C_st`.
- If `z ≠ 0`, then `1 = ∏_v |z|_v ≤ (64η²)ⁿ · M₁^{2(3−K)} · M₁⁶ · C_st`, which is `< 1` for `K > 6` and `M₁` large. **So `z = 0`,
  and `q := r₁/ℓ₁ = r₂/ℓ₂`.**
- **Stability.**
  - Iterate along `M₁, M₁², M₁⁴, …`; the same `q` appears at every scale.
  - The product formula for `ℓ_k` gives `|ℓ_k|_π|ℓ_k|_π̄ ≥ 1/(4ⁿM_k²)`. With `|ℓ_k|_{π̄} ≤ M_k` this gives `|ℓ_k|_π ≥ 1/(4ⁿM_k³)`.
  - Hence `|x̃_π − q| ≤ M_kδ_k·4ⁿM_k³ = 4ⁿM_k^{4−K} → 0`, and likewise at `π̄`.
  - **So `x̃ = q` at `S`.**

**Conclusion.**
- **Leaves.** `x ∈ [q] + K_S`, with `[q] ∈ T` and `K_S` the image of `V_S = L_∞ × ∏'_{w∉S} L_w`. That image is injective, and
  `K_S ∩ T = 0`. Since `µ(X′) > 1 − ε` for every `ε`, `µ(T + K_S) = 1`.
- **Recurrence.**
  - The leaves `t + K_S` are countably many and disjoint, and `U` permutes them.
  - The stabiliser `U_t = {u : (u−1)t = 0}` has finite index, because `U` acts on the finite set `R̂[m]`.
  - Pull `µ|_{t+K_S}` back to `V_S`. The result is `U_t`-invariant under `a ↦ ua`.
  - For each split pair `(π′, π̄′) ∉ S`, some `u_{p′}^j ∈ U_t` shifts `f = log|a_{π′}|` by `−j·log p′ ≠ 0`. So `{a_{π′} ≠ 0}` is null,
    and likewise at `π̄′`.
  - **So `µ` is carried by `T + A ⊆ E`.** ∎
- **What this proves:** EF_F with the hypothesis on **one** non-torsion `u`, for totally real `F`. It contains the positive-entropy
  transfer that X01V's T5 notes. There is no conflict: EF's own Lemma 3.2 gives that on 𝕋 too, without Johnson.

### 7.3 What my sketch did get wrong (from X01V §2.2)

My "sanity fact" said that `U ∩ O_L^×` is torsion **for every real `F`**, by Kronecker. That is false for `F` with complex places,
because the relative units expand archimedean places. **EF_F (and EF-G (a)) must be stated for totally real `F`.** The three fields
(ℚ(√47), the type-(B) fields, ℚ(√167)) are totally real, so the consumer loses nothing. The non-totally-real case needs the full height
`exp h_m(u)`, and I do not claim it.

hunch: ef-transfers-modulo-archimedean — **status: open, about 70 %** (for totally real `F`). The route is now written out; nobody has
checked it but me. Its falsifier is a flaw in 7.2, most likely in the local-injectivity bound for L3.1′ or in the `Λ`-versus-`R`
bookkeeping at the stable places.

### Would have searched here (stage 7)
- None.

## Stage 8 — X01D §3 read against X01V's GAP (owner's update, 06:0x) — SAVED

**Read:** `plans/FS100-X01D-derivation.md` §3.0–§3.8, line by line, against 7.2. No job was messaged.

**The owner's question.** Does X01D's pigeonhole, with `U_ℚ` multipliers and the two-scale product formula, keep the neighbourhood thin at
the places outside `supp(u)`, with polynomially many multipliers?

**The answer.** No, and it does not need to. That requirement is exactly what the two-scale product formula removes.
- **Thin at one place only.** X01D thins at one expanding place `v*`. At every split `w ≠ v*` its error table has `|e|_w ≤ m(w)`, which is
  fat and bounded by the multipliers' heights.
- **The count.** The pigeonhole needs only `µ(vB) = µ(B)` and `#V_M ≥ c₀M^{1/[F:ℚ]}` (`V_M ⊂ U_ℚ`, primitive Pythagorean triples), so
  the multipliers are polynomially many.
- **The product formula.** At two scales, `z = ℓ₁e₂ − ℓ₂e₁ ∈ Λ` has `∏_v|z|_v ≤ (16ε)^{[L:ℚ]}·M^{3−K}·M⁶ < 1/C_Λ` at `K = 16`, so `z = 0`.
  The fatness off `v*` costs `M⁶` (fixed exponent) against thinness `M^{3−K}` (free exponent).
- **Where X01V's GAP sits.** It is in its item 2 ("the images are small: fails"), which carries over EF's requirement that the images be
  small. That requirement belongs to the real-line Diophantine step and is not needed adelically. UZ never arises, because only the fixed
  `u*`'s entropy is used, so `δ₀(u*)` and `X′` do not move with `M`.

**Checked line by line, and correct as far as I can see:**
- Lemma 3.1′'s local-injectivity induction. The correction `y′ ∈ Λ` is killed by Lemma PF, using an `ε` chosen from `u*`'s archimedean
  moduli and its finite support.
- The pigeonhole constants: `β = α/2K`, `δ^β = M^{−α/2}`.
- The `z`-bounds, place by place, including `C_Λ` at the stable places.
- Step 5's division: `|ℓ_j|_{v*} ≥ 4^{−[L:ℚ]/2}M_j^{−2}` by Lemma PF on `ℓ_j`, which gives `|x̃ − t|_{v*} ≤ 2^{[L:ℚ]}M_j^{3−K} → 0`.
- The leaf disjointness, and the finite `U`-orbits on `L/Λ ≅ ⊕_{stable} L_w/Λ_w`.
- Step 7's shells. `g = γ/σ(γ)` has `|g|_w ≠ 1`, the masses `ν_t(A_j)` are periodic in `j` with a finite sum, so every `ν_t(A_j)` is 0.

**Two improvements on my 7.2, both correct:**
- (i) One place `v*` suffices, with a one-sided refinement.
- (ii) Every `v ∈ U_ℚ ⊂ ℚ(i)` has modulus 1 at **every** archimedean place of `L`, for any real `F`. So the counting and the separation
  never meet an expanding archimedean multiplier. X01D's EF_F⁺ is stated for **every** real number field (with `v*` archimedean allowed),
  which makes my 7.3 restriction to totally real `F` unnecessary for EF_F⁺. EF-G (a) stays FALSE off the totally real fields, as X01V
  found, but EF_F⁺ does not use it.

**My independence.** I am **not** an independent check: X01D's route is my sketch written out. The independent check is X01V's stage 4
re-read. The question it must answer is whether its item 2 is required once the separation is done by the product formula over all places.

hunch: ef-transfers-modulo-archimedean — **about 80 %**. The route is now written out by X01D, and I have checked it line by line. It
still waits on a blind confirmation (X01V stage 4).

### Would have searched here (stage 8)
- None.

## Stage 9 — wave 3: which wanted posters the new tools move (resumed 06:17) — SAVED

**State read** (the reports in `data/crunch-2026-09-26-x2x3/reports/`):
- EF_F⁺ holds: X01D, then X01V at its stage 4 (UZ withdrawn), then X12B blind by its own route (Lemma Z).
- PE-2 is TRUE given EL2021 Thm 1.2 through (★) (X02D, X02V); PE-1 as stated is FALSE.
- X05V re-derived SP-Cor blind.
- X03D: FL-1 and FL-2 are GAP at QTCA; ED-2 is FALSE (X13R: VALID).
- `χ(ℚ(√47)²) = 5` [hand] was announced at 06:08.

**Frame items sent to the planner (about 06:20), ranked:**
- **F1. The posters are one theorem.** The inputs to SP-Cor (N1, N2, R-U, SI-1…4, A⁺) are field-general except T-C(A) at S=∅. The
  lead ask has two halves:
  - (a) SP-Cor(F) for every real `F` in the class. Named risk: A⁺'s archimedean step at `n = [F:ℚ]` real places, where `Λ = 0.4028 > 1/3`.
  - (b) Class(F): T-C(A) at S=∅ ⟺ `L(F) ≥ 5`, from held results. Named risks: `q = 27`, `U_Q` with `Q ≥ 64`, ramified stable places,
    the archimedean part.
  - Together: `χ(F²) ≥ min(L(F), 5)` for every real number field, which is the main clause through `L = 5`.
  - Degree 2 is already this: row 117 + K0 + MR. It gives every real quadratic field, **ℚ(√167) ≥ 5** included; the only extra owed is a
    blind check of K0.
- **F2. ℚ(√167) at six does not move.** That statement implies `χ(ℝ²) ≥ 6`, so it is rung D. What transfers is the reduction **SEL_k**:
  MR + FL-K ⟹ every `k`-colouring of `F²` induces one whose spectral measure is carried by `E`. At `k = 5` over ℚ(√167) this becomes
  row 110 / FS-96's window question at `{∞, 23, 43, …}`, together with a real-place part of `χ_B(ℝ²)` type. Grade it as a reduction.
- **F3. Row 88 / T-B1.** Only the conditional moves: "row 88 ⟺ T-B1" becomes unconditional. Transience is outside the reach of the
  invariant-measure tools. At most one 20-minute no-go note.
- **F4. ℚ(√3,√5).** Exact check (sympy, Legendre symbols; the ban allows it). Below 200 the stable odd places are
  **11, 59, 71, 131, 179, 191**. The primes 7, 19, 23, 31, 43, 47 are **not** stable, since their residue degree is 2. 3 has residue
  field `𝔽₉`, and no dyadic place is stable, since 15 ≡ 7 mod 8. So the field is plausibly in the class, modulo the archimedean step at
  `n = 4`. If that holds, `χ = 5` (`L = 5` via 11).
- **F5. Prior-art gate before "ours".** EL2021 §2 and §4 ("an adelic version of the positive entropy theorem") may already hold PE-2
  for `R̂`. Sataev 1975 may predate EF.

hunch: main-clause-through-five
  claim: SP-Cor(F) and Class(F) both hold for every real number field, so `χ(F²) ≥ min(L(F), 5)` in general
  basis: derived (field-generality of X05V's P0–P8 inputs) and analogy
  falsifier: A⁺ failing at `n ≥ 3` real places, or a stable-place target with `χ ≥ 5` and all-levels four-colour ratio `≥ 1/4`
  registered: 2026-09-26
  status: open — about 45 %. Degree 2 alone: about 80 %, since only K0's blind check is owed.

hunch: six-at-167-does-not-move
  claim: no wave-3 job proves `χ(ℚ(√167)²) ≥ 6`; the best transfer is the reduction SEL_5
  basis: derived (`χ(ℚ(√167)²) ≥ 6` ⟹ `χ(ℝ²) ≥ 6`)
  falsifier: a verified proof, which would be rung D itself
  registered: 2026-09-26
  status: open — about 99 %

### Would have searched here (stage 9)
- None: the ℚ(√3,√5) check was exact Legendre symbols.
