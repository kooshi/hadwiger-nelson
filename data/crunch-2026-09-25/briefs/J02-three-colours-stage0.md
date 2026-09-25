*Brief for crunch job **J02**, milestone M1 (FS-91, stage 0): derive or refute an advisor's sketch that three colours obey the
local–global conjecture over every real number field. Opus 5.5, 2026-09-25. Written by the crunch planner
(`plans/CRUNCH-2026-09-25-queue.md` §2).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the **derivation agent** for this stage, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. The house rules are `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`; read all three from disk, since the
copy loaded at your start may be stale. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** The
product owner coordinates and reviews by artifact.

## The question, and why now

The local–global conjecture (G48) says `χ(F²) = L(F)`, the best bound a residue plane gives, wherever `L(F) ≤ 6`. At three colours it
is proved for real quadratic fields and fields containing √3 (G55, row 82). The one class of real number fields left open is **FS-82**
(`plans/STUB-three-colours-residue-degree-three.md`): non-bipartite fields whose primes above 3 of odd residue degree all have degree at
least 3. Its first instance is `ℚ(α, √7)`, `α³ = α + 1`, where `L = 4`.

FS-82's stub was minted before FS-89 proved **row 95**. Row 95 says every four-colour band character of every real field's unit-vector
ring is torsion plus archimedean, and the band `[1/3, 2/3]` lies inside `[1/4, 3/4]`. The advisor (Poros) saw that this may make FS-82 a
corollary and sent a sketch. **Your job:** turn the sketch into a proof, or find where it fails.

**Independence.** A second agent (J09) is deriving the same statements at the same time, blind to this sketch and to you. Do not contact
it, and do not read its record until your own verdicts are committed. If both land, the result carries row 82's grade, "two independent
derivations".

**Every outcome counts** (standing rule 4). A named gap in the sketch, or a point of `Θ₃(ℚ(α,√7))`, is as valuable as a proof. A point
there would be a three-colouring local at no prime: a falsifier of the conjecture at `L = 4`.

## The sketch, verbatim

These are the advisor's words, from two messages to the planner on 2026-09-25. The first is committed in
`plans/POROS-2026-09-25-crunch-plan.md` §1.2, F1.

> F1 sharpened after reading FS89-derivation CL2 and S0A-3. I now hold it at about 0.75, as a 1–2 agent-hour job plus a verifier.
>
> CL2 is stated for every subfield F ⊆ ℝ: Θ₄(R_F) ⊆ T₁₆₈ + A. At band 1/3 each rational layer's type is C1(5)'s:
> - (a) parity plus an archimedean part of norm at most 1/6;
> - (b) order 3 with |α| ≤ 1/12 (S0A-3 gives the same bound).
>
> The sketch for every real number field F, with χ(F²) ≤ 3 ⟹ L(F) ≤ 3:
> 1. FS73-T22 gives θ ∈ Θ₃(R_F).
> 2. Type (a) is the walk-parity ring map R_F → 𝔽₂, so F² is bipartite (G55).
> 3. Type (b): τ factors through R_F/3R_F, the product over the stable 𝔭 | 3, collapsed to level one by the band (row 96's remark).
> 4. The step I called the risk is elementary. The unit vectors are the norm-one torus of F(i)/F, which the Cayley parametrisation u = (t+i)/(t−i) makes rational. Weak approximation in t then makes U_F jointly dense in the product of the local circles and the archimedean circle.
> 5. So if every local part's circle image contains 0, some unit vector has τ(u) = 0, and |θ(u)| ≤ 1/12 falls outside the band.
> 6. Hence some local part avoids 0 on its whole circle. That is an additive three-colouring of Γ_{3^f}, which forces f = 1 (Γ₂₇'s Hoffman floor is 6 and the larger ones are higher), so there is a stable 𝔽₃ prime and L(F) = 3.
> 7. Conclusion: the conjecture's L ≤ 4 clause holds for every real number field. First instance ℚ(α,√7): Θ₃ = ∅, so χ = 4.
>
> What a derivation agent should check, not assume:
> - the band collapse at a ramified prime above 3;
> - that C1(5)'s type bound carries through CL2's gluing to R_F;
> - the parity-type step for fields where 1/2 ∉ R_F.
>
> Prior art to gate: [Fischer1990] Thm 10 and the Johnson papers, which are not held.

Also from its first message: "The sum of several local parts is the one step to check; it is a sumset question, not a search."

## The statements to prove or refute

1. **S1.** For every real number field `F`: `χ(F²) ≤ 3 ⟹ L(F) ≤ 3`.
2. **S2.** The conjecture's `L ≤ 4` clause holds for every real number field: `χ(F²) = L(F)` whenever `L(F) ≤ 4`. Say which known results
   supply the other directions (the two-colour case, G55 and the FS-45 stub's Theorem 2.1; `χ(F²) ≤ L(F)`, row 52; L = 4 ⟹ χ ≤ 4).
3. **S3.** `Θ₃(ℤ[U_F]) = ∅` for `F = ℚ(α, √7)`, `α³ = α + 1`, so `χ(F²) = 4`. Re-derive the stub's arithmetic first: 3 inert in the cubic
   and split in ℚ(√7); the prime above 7 of residue field `𝔽₇`, stable in `F(i)`.

For each statement, state the hypotheses you actually use. Say whether the proof uses the finiteness of `[F : ℚ]`, and whether S1 extends
to every subfield of ℝ.

## Read first, from disk

1. `CLAUDE.md` § Notation, G21, G35, G38, G43, G48, G55, G56, G61, G71, G74, G76.
2. `LEDGER.md` rows 52, 57, 63, 79, 82, 95–97.
3. `plans/FS89-derivation.md`: CL2, CL4, CL5, and the entries they cite.
4. `plans/FS89-S0A-gluing-verification.md`: S0A-3 and the approximation step.
5. `plans/FS81-derivation.md`: T1–T8; and `plans/FS73-derivation.md` T22.
6. The FS-82 stub, in full.

**Fenced until your verdicts are committed:** J09's record `plans/FS91-S0FV-three-colours-blind.md`, and `plans/FS91-close-inventory.md`.

## Stages

- **Stage 1 (about 30k).** Check this brief's quotations against their sources: the advisor's record, CL2, S0A-3, FS73-T22, row 95. Then
  write C0, a probability per statement and per step 1–6 of the sketch. Save.
- **Stage 2 (about 120k).** Derive S1, step by step. Give the advisor's three checks a section each, plus the sumset step (several stable
  primes above 3 at once, with the archimedean part). Any exact check, such as `Γ₂₇` admitting no additive three-colouring (a hyperplane
  avoiding the 28 norm-one elements of `𝔽₇₂₉`), goes in `tools/crunch_j02_*.py` with a planted fault; a complete enumeration of that finite
  set is at the ban's edge and is logged (standing rule 3). Save after each step.
- **Stage 3 (about 60k).** S2 and S3. Save.
- **Stage 4 (about 40k).** Write the fixed claim list: every lemma you proved, stated verbatim with no proof, in
  `data/fs91/j02/lemma-statements.md`, for J09's second phase. Also write the prior-art debts: `[Fischer1990]` Thm 10 is held; the
  Johnson papers are not. Save and report.

## Your record and your paths

- **Record:** `plans/FS91-S0F-three-colours.md`, with C0, the stages, the would-have-searched log, and "Theorems this phase proved".
- **Data and tools:** `data/fs91/j02/`, `tools/crunch_j02_*.py`.
- **Budget:** about 330k in the harness's count. Hand back by 420k.
- **Report:** standing rule 9.
