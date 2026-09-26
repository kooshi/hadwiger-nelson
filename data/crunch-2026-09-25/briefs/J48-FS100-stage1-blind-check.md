*Brief for crunch job **J48**: FS-100's stage 1, the bundled blind check of the wanted-poster sessions' one-mind theorems. Opus 5.5,
2026-09-25. Written by the product owner; Kooshi approved running it inside the crunch. The claim list below was fixed, verbatim, in the
FS-100 stub's §6.1 before any verifier existed.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **a blind verifier**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read
`CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in
full.** I'm the product owner.

**If your record `plans/FS100-BC-verification.md` already exists, you are resuming:** continue at the first stage not SAVED (`git log`).

## Your job

Decide each claim below **by your own route**: TRUE with a proof, FALSE with a counterexample, GAP at a named step, or ill-posed as written
(with the reason). **Every verdict counts equally** (standing rule 4); do not lean toward a yes. These claims were proved tonight by one mind
each, in three advisor sessions; you are the second mind, and your value is that you have not seen their routes.

## Fenced until your blind phase (stage 2) is committed

Do not open: the three poster records `plans/POROS-2026-09-25-wanted-poster-{47,59,167}.md`; the reports `data/crunch-2026-09-25/reports/J37.md`,
`J38.md`, `J39.md`, `J47.md`; the FS-100 stub `plans/STUB-measure-rigidity-three-fields.md` and `data/crunch-2026-09-25/j47-record.md`;
`plans/FS84-close-inventory.md`; `plans/CRUNCH-2026-09-25-post-close-inventory.md`; the crunch index; `tools/crunch_j38_*`, `tools/crunch_j39_*`;
and the bodies of commits whose subjects start "J37", "J38", "J39" or "J47".

**You may use, as given by their statements:** J45's lemma statements and theorems table (`plans/FS84-SI-D-derivation.md` §5.4: SI-1 to SI-5,
N1, N2, RU, SP-oi, SP-if, A⁺, B⁺) and the blind check that confirmed them (`plans/FS84-SI-V-verification.md`); J21-MX and J21-SL
(`plans/M3-derivation.md`); `LEDGER.md` row 98; T-C(A) and Theorem C (`plans/R88-derivation.md`: R88-TCA, R88-TC); `[AmbrusEtAl2023]` Thm 1;
FS-84's S1b-i (`plans/FS84-S1-derivation.md`, verified in `plans/FS84-S1V-verification.md`). You may read `CLAUDE.md`, `LEDGER.md`, every
other `plans/*-derivation.md`, and the cited papers.

## Definitions the claims use (quoted from the FS-100 stub, which is otherwise fenced)

> "**MR(F)** is 'every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure'" — J38 §3.5, T-J38-2 (iii).

**J39 (ℚ(√167), five colours) — every theorem [hand, one mind]; `Y` uses J39's notation: `G_v` the full-depth local plane at a stable place,
"CP colouring" a translation-invariant random colouring, continuous in probability, proper almost surely at each fixed edge; "thick" means the
place's compact local piece has mixing constant `λ* < 1/(k−1)`:**

PL(23, 43), as the stub quotes it: PL(23, 43) is "every CP five-colouring of `UD(ℝ²) × G₂₃ × G₄₃` yields one of `UD(ℝ²)`" (§3.3 (b)).

## The fixed claim list

| # | claim, verbatim (from the FS-100 stub §6.1) |
|---|---|
| BC-1 | T-J39-3: "Let `N_k(F)` be the finite set of stable places of `F` that are not `k`-thick, and `Y_{F,k} = UD(ℝ²) × ∏_{v ∈ N_k(F)} G_v`. If `F²` is `k`-colourable, then **either** (A) `Y_{F,k}` carries a CP `k`-colouring, **or** (B) some `U`-invariant finite positive measure `τ` on `R̂` has `τ(E) = 0` and `∫ Re χ(1) dτ(χ) < 0` (an SP witness, so MR(F) fails, J45 SP-oi). Conversely (A) ⟹ `F²` is `k`-colourable. **So, given MR(F): `F²` is `k`-colourable iff `Y_{F,k}` has a CP `k`-colouring.**" (every `k`, every totally real `F`) |
| BC-2 | T-J39-1: "At `F = ℚ(√167)`, `k = 5`: `N₅(F)` is the four places above 23 and 43 (J21-TH; §2.3), and merging each conjugate pair (J21-SL) gives `Y = UD(ℝ²) × G₂₃ × G₄₃`. **The split places 2, 3, 5, 7, 29, 61 do not appear.**" |
| BC-3 | T-J39-4: "A four-colouring of ℚ(√167)'s plane yields an SP witness over ℚ(√167); so MR(ℚ(√167)) ⟹ `χ(ℚ(√167)²) ≥ 5`." |
| BC-4 | T-J39-5: "(i) Unconditionally: `χ(ℚ(√167)²) ≥ 6 ⟹ χ_CP(ℝ²) ≥ 6`. (ii) If MR(ℚ(√167)) holds, 43's all-levels ratio is `< 1/5`, and PL(23, 43) holds, then `χ_CP(ℝ²) ≥ 6 ⟹ χ(ℚ(√167)²) ≥ 6`." |
| BC-5 | T-J38-1: "Over ℚ(√59), ℚ(√83), ℚ(√131), if `θ ∈ R̂`, `W : ℝ/ℤ → {0,1,2,3}` is Lebesgue measurable and `c_t(x) = W(θ(x) + t)` is proper for almost every `t ∈ ℝ/ℤ`, then `c_t ∈ Pull` for almost every `t`." |
| BC-6 | T-J38-2, (i)–(iii) as quoted in §2.3 of this stub |
| BC-7 | T-J38-3: "*for every real field `F` in T-C(A)'s class or in Theorem C's class S2, MR(F) ∧ Iso(F) ⟹ every four-colouring of `F²` is a pullback from a tight place.* Here Iso(F) is T-B1, vacuous when there is no tight place." |
| BC-8 *(owner's call)* | T-J37-3: "for an `R ⋊ U`-invariant `μ`, every atom of `σ_μ` is torsion (finite `U`-orbit; Levitz–Mott); so off `E` the averaged spectrum is atomless" |

BC-6's quoted statement (the stub's §2.3 / §5 text of T-J38-2):

- **T-J38-2** (§3.5): "Let `F` be of type (B), and assume **T-B1** ('every point of Pull is isolated in `X₄(F)`', R88 §G). Then: (i) `X′ =
  X₄(F) ∖ Pull` is closed and `Aff_F`-invariant, and **no translation-invariant Borel probability on `X′` has spectral measure carried by `T + A
  + Fin_S`** for any finite `S` — T-C(A)'s statement, with `X′` in place of `X₄`; (ii) if `X′ ≠ ∅`, there is a `U`-invariant finite positive
  measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ(χ) < 0` — a witness of J45's SP, hence a `U`-invariant `E`-null measure that is not a
  multiple of Haar measure; (iii) so **MR(F) ∧ T-B1 ⟹ `F(R) ≠ 0`** … **given MR(F), row 88 is equivalent to T-B1.**"
- **T-J38-3** (§4.7): "*for every real field `F` in T-C(A)'s class or in Theorem C's class S2, MR(F) ∧ Iso(F) ⟹ every four-colouring of `F²` is
  a pullback from a tight place.* Here Iso(F) is T-B1, vacuous when there is no tight place."

**Controls the verifier must run** (each named in a source, or a consistency the sources' facts force): at seven colours G-∞ is non-empty
"for every field — the hexagonal seven-colouring pulled back along a real place" (J39 §3.3 (c)), so BC-1's (⟸) must reproduce `χ(F²) ≤ 7`;
at ℚ(√11) with `k = 4` four-colourings exist (C9, row 94), so BC-1 forces branch (A) or an SP witness there — the verifier says which, or
names what it cannot decide; for BC-5, T-J37-1's own control transposed: "over ℚ(√11) the theorem must fail, and does" (J37 §3.4).


*(Owner's note: the stub quotes T-J38-2 with an ellipsis "…" inside (iii); judge the statement as quoted, and say if the ellipsis hides
something the claim needs. Fix any term not defined above in your stage 1 and say how you read it.)*

## Stages (save and commit after each: `git commit <paths>`, subject "J48: stage n"; push after each; never force-push)

1. **Readings and C0** (~30k): every term fixed; a probability per claim before deriving.
2. **The blind phase** (~200k, at most 60 % of budget): a verdict per claim with its proof, counterexample or named gap; **run the three
   controls**; exact checks of seconds allowed (`tools/crunch_j48_*.py`, each with a planted fault that fires). Save and commit **before
   opening anything fenced**.
3. **The comparison** (~60k): open the three poster records; per claim, a divergence row (truth, route, wording) and whether the routes are
   independent. If your blind route stalled on a claim, re-derive the poster's lemma statements from their statements alone (FS-89's
   fallback).
4. **The report.**

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation). Reason:
  staffing is Kooshi's budget decision and I can only review work I know about. If the work outgrows your context, stop at a saved stage and
  tell me what is left.
- **No finite-witness search** (the ban runs to 2026-10-01). Keep a "would have searched here" log.
- **Touch only** `plans/FS100-BC-verification.md`, `data/fs100/j48/`, `tools/crunch_j48_*`.
- **Commits by explicit path**; end commit messages with your harness's attribution lines; push after each; never force-push.
- **Budget:** about 330k by the harness's count; hand back by 420k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J48.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J48 idle; report sent to the owner by SendMessage".

Thank you.
