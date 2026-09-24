# FS-85 round 3: the 5-part lemma (de Bruijn's working file)

*Opened 2026-09-24 by de Bruijn (Opus 5.5). Brief: `data/fs85/briefs/R3-five-part-brief.md`. Only writer: de Bruijn. Tools:
`data/fs85/r3/`. The finite-witness-free week is in force: no colouring of any quotient is enumerated or searched.*

**The target.** *The 5-part lemma:* every proper four-colouring of de Grey's lattice `Cay(Λ, U)` is `24Λ`-periodic. By Coxeter's
Corollary U (`F ⊇ 120Λ` from Parts's G481, prior art) this says the spectrum carries no weight on the 48 order-10 characters of
`Θ_{−2..2}`; with his alternate-triple lemma C15 and Theorem R it gives `F ⊇ 8Λ` and all of Hubai's description on `Λ`.

## State (a fresh agent resumes from here)

- 2026-09-24: brief and the six inputs read in the brief's order (`CLAUDE.md` from context, checked current against `git log`; the
  FS-85 plan §0, §IQ, §R-review; Coxeter R2.0–R2.12; de Bruijn dB5–dB11; the verification; Poros §13). §IQ and the prediction below
  written before any tool beyond `lat.py` (the unit vectors) and `phi.py` (the 48 order-10 characters, recomputed from the
  definition; it agrees with Coxeter's `sub5.py`: 8 per admissible pair index).

## §IQ. The invariant question for this sub-question (WORKFLOW 3.3)

1. **The existence form.** Is there a proper four-colouring of `Cay(Λ, U)` whose Fourier spectrum puts weight on one of the 48
   order-10 characters `π/2 + θ₅` of `Θ_{−2..2}`? Equivalently: a colouring that is not `24Λ`-periodic.
2. **The structural form.** Classify *every* tetrahedron-valued function on `Λ₅/40Λ₅` whose spectrum lies in the 90 characters of
   `Θ_{−2..2}|_{Λ₅}` (42 of 2-power order, 48 of order 10). By C7 and G481 this is exactly the set of proper four-colourings of one
   component of the **five-family graph** `Cay(Λ, U_{|k|≤2})` — the most general graph on which the spectral input holds, with the
   outer families ±3, ±4 stripped. In the frame's words (Poros §13): `Λ/40Λ = Λ/8Λ × Λ/5Λ` and the graph is a sparse subgraph of the
   categorical product of the tight 2-adic quotient with the (five-chromatic) plane at 5; must every colouring be pulled back from
   the 2-adic factor?
3. **The invariant it forces.** Not named in advance by the discipline; my candidate, from the CRT: the **slice function**
   `b ↦ (chirality, slice colouring)` on the 625 cosets of `5Λ₅` in a component (no edge lies inside a slice). Each slice sees all of
   `Λ/8Λ = Λ/P₊ × Λ/P₋`, so a tetrahedron splitting applies slice by slice. The second invariant is the **line structure of the
   5-part**: for each admissible pair index `π`, the 8 characters `θ₅` with `π/2 + θ₅ ∈ Θ_{−2..2}` are the nonzero points of two
   lines of the dual `𝔽₅⁴` (`phi.py`). A function whose Fourier support is two lines is a sum `φ₁(ℓ₁(b)) + φ₂(ℓ₂(b))` of two
   one-variable functions — which a {−1, 0, 1}-valued function can only be in two rigid shapes.
4. **The route.** Derivation only: tetrahedron splitting across the product; Fourier disjointness of the 5-part between pair
   indices; the sumset shapes of a two-line function. Exact computer algebra only to compute the finite sets the derivation names
   (`Θ_all`, the two chirality lattices `P_±`, the lines and planes of the 5-part) and to check derived identities.
5. **The open instances it would decide.** `F ⊇ 8Λ` on de Grey's lattice from Parts's G481 alone (with C15 and Theorem R), replacing
   row 78's 2,044-point certificate; Coxeter's open question whether the five-family graph alone forces the 5-part (R2.12 item 3);
   the "middle case" shape of R2-dB1 / gap B (a slack product of a tight factor with a non-colourable one).

## Prediction (registered before the route is written)

| outcome | probability |
|---|---|
| **proof** of the 5-part lemma, given Parts's G481 and Coxeter's Θ tables | **0.75** |
| reduction to one named finite statement I cannot close | 0.15 |
| a proved no-go for a named certificate format (beyond C14) | 0.03 |
| an error found upstream (a counterexample would contradict row 78's certificate) | 0.07 |

**Not blind, stated plainly:** while reading Coxeter's R2.10 and Poros's §13 I sketched a route in my head — split every
`5Λ₅`-slice by the tetrahedron splitting across the two primes above 2, then kill the 5-part with its line structure — before
writing anything. The 0.75 is conditioned on that sketch; the named risks are (i) the three planes spanned by the 5-part lines at
one prime might coincide (then the sumset argument needs a second step), (ii) a mis-identification of which order-2 characters
factor through which chirality lattice, (iii) a gap in the Fourier bookkeeping between `Λ₅`-cosets.

## Theorems this phase proved

*(none yet)*

## Retractions

*(none)*

## "Would have searched here" log

1. The first impulse on reading the target: colour `Cay(Λ₅/40Λ₅, U_{≤2})` (40⁴ = 2,560,000 points, one component) with a solver
   and look for order-10 spectrum. Not done: the structural form above replaces it.
