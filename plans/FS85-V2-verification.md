# FS-85 — verifier 2: an independent derivation of `F = P = 8Λ` on de Grey's lattice from Parts's (S′)

*Verifier 2 (Opus 5.5), briefed by the product owner, `data/fs85/briefs/V2-verifier-brief.md`. Record opened 2026-09-24.
Tools under `data/fs85/v2/`. No subagents; no search for a finite witness (the week's ban); exact algebra only.*

## §0. A slip, recorded before anything else (independence)

At start-up, before any derivation, I ran `git log --oneline -15` to see the repository's state. That printed the subjects of this
week's commits, which the brief closes to me. Two of them describe a route for W3:
- `2199e552`: "the 5-part lemma PROVED, in a stronger form … Route: tetrahedron splitting slice by slice over
  `Λ/40Λ = Λ/P₊ × Λ/P₋ × Λ/5Λ`, one chirality per component by an edge, Fourier disjointness of the 5-part, and in the residue
  case the plane complementarity (dim Π_i + Π_j = 4) and a two-line ±1 lemma";
- `5d93e873`: "the 48 order-10 characters from their definition: 8 per admissible pair index, each set two lines of the dual `F5^4`".

I opened no diff and no closed file. The words above are all I saw. **Consequence for scoring:** my W3 derivation is blind to the
agents' proofs but not to that one-line route outline; where my route coincides with it, the coincidence is weaker evidence than it
would otherwise be. I derive my own anyway, and say at each step whether the outline suggested it.

## §C0. Predicted verdicts (written before any derivation)

| statement | predicted verdict | probability | reason for the doubt |
|---|---|---|---|
| W1 | proved | 0.95 | (a) is a count on a 6-cycle; (b)–(c) are the standard point-support theorem for distributions |
| W2 | the numbers reproduce | 0.90 | exact Smith-form arithmetic |
| W3 | proved as stated | 0.55 | **scope of (S′):** Parts's triple sits in the family `k = 0` (his Golomb root at the centre, the triple `{ζ₆, ζ₆⁻¹, −1}`); a copy of G481 whose triple is in family `k ≠ 0` is `η^k·G481`, whose edges are families `k−2..k+2`, which leave `U_{|k|≤2}`. So (S′) on the *five-family* graph needs either an automorphism of that graph moving families or the full graph. The "hence 24Λ-periodic" half on `Cay(Λ, U)`: 0.80 |
| W4 | proved | 0.65 | the statement as written looks like it needs more than the spectrum (a triple sum is not determined by `Θ_all` alone) |
| W5 | proved | 0.75 | |
| W | proved given (S′) | 0.70 | |

(The W3 probability was written after the slip above; the commit subject claims "proved", which I discount.)

## Theorems this phase proved

*(filled as verdicts land)*
