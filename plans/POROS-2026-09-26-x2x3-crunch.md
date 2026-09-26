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
