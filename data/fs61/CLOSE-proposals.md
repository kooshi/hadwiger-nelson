# FS-61 — proposals to the product owner at the close (phase F items F.3, F.4, F.5)

*Written by the implementer. **These are proposals, not edits**: `CLAUDE.md`, `plans/FRONTIER-STUBS.md` and the
stubs are the owner's files. Phase F.4 — the two sweeps and the §PA re-read — is complete below; F.3 and F.5 are
filled in when phase E's last numbers land.*

---

## F.4 — the sweeps


## Sweep 1 — every occurrence of "conjecture" in `plans/FS61-quadratic-census.md`

| line | what it says | mint a stub? |
|---|---|---|
| 23, 35, 105, 256, 719, 753 | all refer to **the project's local–global conjecture (G48)** and to its level-4 clause, which this milestone tests. Not a conjecture this milestone MINTED. | **decline** — it is CLAUDE.md G48, already carried, and FS-59 is its open consumer |
| 206 | Duffus–Sands–Woodrow's statement **B(n)** (1985) is *conjectural*, quoted from the prior-art sweep as the general form behind FS-58 D3.4 | **decline as a stub of ours, but it belongs in the bibliography's read-status**: none of the four originals was reached (all paywalled), so the census cites a conjecture nobody here has read. Recorded, not pursued |
| **T4** (§3 D-F.2, not containing the word) | *for every squarefree `d ≡ 11 (mod 12)`, `χ(ℚ(√d)²) ≥ 4`* — the milestone's own candidate class theorem | **already a named deliverable** (E.5, P10); the close reports it unproved with what was tried |

## Sweep 2 — "not claimed" / "not proved" / "not attempted"

| line | what it says | mint a stub? |
|---|---|---|
| 802 (§M2) | **FS-58 D3.4's repair** — 3-colourings of `G × H` with `χ(H) > 3` factor through `G` when `G` is gap-free — *"not used and not attempted here"*, with an unverified eigenvalue sketch from the prior-art sweep, and the fact measured but unproved at `q = 7, 11` | **MINT A STUB.** The plan itself says *"proposed to the owner as a stub at the close"*, so this is the sweep firing exactly as designed. It is a statement about Hoffman-tight `G` whose proof is not in the literature found, and it is the missing justification under FS-58's D3.4 and under phase A.7's rule for non-affine quotient colourings |

## The §PA re-read — *what did the prior-art gate teach us about our own object?*

Not *were we first*, which is what §PA was filed under. Four answers:

1. **Headline 4 — the unit-vector supply is a class-group question.** `[ZanardoZannier1991]` Thm 3 gives a basis of the
   free part of the norm-one group indexed by the split primes, with the obstruction in `Cl(S)/M`. Phase E's **shape
   table** is the same statement seen from the other end: one integral shape holds 108 unit vectors over `d = 11` and
   20 over `d = 371`, and that count is what decides whether its graph refuses. **The census has measured, field by
   field, the quantity that theorem computes** — and the connection is not drawn anywhere in this repository.
   *Recommendation: a grokking, or a line in the ledger row.*
2. **Headline 2 — Fischer split this family at exactly this modulus in 1990** (`d ≡ 3 mod 8` has an additive
   4-colouring; `d ≡ −1 mod 24` has no additive `k`-colouring for small `k`). Phase E now has **two** `d ≡ 3 (mod 8)`
   fields refusing by the direct route (11 and 59), so the census's lower bounds cut across his division rather than
   along it. *Recommendation: say so in the close; it is the sharpest thing the census says about a published division.*
3. **Headline 1 — Moorhouse asks "What about `χ(ℚ(√47)²)`?" by name**, and the census answers a question he posed in
   general (*"how much can the chromatic number grow for quadratic extensions"*) with a table. *Recommendation: this
   belongs in `CLOSED-QUESTIONS.md`, and the close should state exactly which of his questions is answered and which
   is not.*
4. **Headline 5 — `[Sokolov2018]`'s rank-2 layers.** E.5 now answers it exactly (every witness has ℚ-rank 4), which
   turns an informal FS-58 remark into a checkable column. *Recommendation: one line in the ledger row; no stub.*
