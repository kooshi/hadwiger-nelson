*Brief for job **J51V**: a blind verifier for FS-100's stage 4. Opus 5.5. Written by J51, the FS-100 planner. **Sized for about 2 hours
and 300k harness tokens.** Runs beside a derivation job on the same claims; never contact it.*

Hello. You are Coxeter, a verifier, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md`
and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.**

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-J51V-verification.md`.

## Blind — the fences (until your stage 3 is committed)

Do not open: `plans/FS100-three-field-lemma.md`; anything under `data/fs100/j51/` or `data/fs100/j51d/`; `plans/FS100-J51D-derivation.md`;
the reports `data/crunch-2026-09-25/reports/J51*.md`; the brief `J51D-FS100-kronecker-derivation.md`; J37's poster
`plans/POROS-2026-09-25-wanted-poster-47.md` §3.3 (d) and §4.4–§4.5; `plans/STUB-measure-rigidity-three-fields.md` §3 after its first
block quote; the bodies of commits whose subjects start "J51". Everything else is open.

## The fixed claim list (verbatim; written before any claim was derived)

Notation: `F ⊆ ℝ` a real number field, `L = F(i)`, `U = U_F` the unit vectors (norm-one elements of `L/F`), `R = ℤ[U]`, `R̂` its dual;
`T` the torsion characters, `A(R_F)` the archimedean ones, `E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split
places) — `LEDGER.md` rows 98, 113.

- **KS-1.** "Let `F ⊆ ℝ` be a real number field, `R = ℤ[U_F]`, `n ≥ 1`, `Θ : R → Tⁿ` a homomorphism, `K = cl Θ(R)`, `K̂′ = {m ∈ ℤⁿ : m·Θ ∈ T + A(R_F)}`, `K₀ = ann_K(K̂′)`, `π : K → K′ = K/K₀`, and `W : K → {0,1,2,3}` measurable with `W(t) ≠ W(t + s)` for Haar-almost every `t ∈ K` and every `s ∈ cl Θ(U)`. Then there is a measurable `W′ : K′ → {0,1,2,3}` with `W′(t′) ≠ W′(t′ + s′)` for almost every `t′` and every `s′ ∈ cl π(Θ(U))`."
- **KS-2.** "If, for every `s ∈ cl Θ(U)`, `s + K₀ ⊆ cl Θ(U)` (KS-sat), then the conclusion of KS-1 holds, with `W′(π(t))` any measurable selection from the colours `W` takes on a positive-measure part of `t + K₀`."
- **KS-3.** "KS-sat holds for every real number field `F`, every `n` and every homomorphism `Θ : R → Tⁿ`."
- **KS-4.** "Over ℚ(√11), with `Θ = (θ_{C9}, θ₁)`, `θ_{C9}` row 94's character `(2x + 3y)/7` plus an archimedean term below `1/28`, `θ₁ ∉ E`, and `W` reading only the first coordinate as `⌊4·⌋`, KS-1's conclusion holds with `W′` the same window."
- **KS-5.** "Over ℚ(√11), with `Θ = (θ_{C9}, θ_{C9} + θ₁)`, `θ₁ ∉ E`, and `W(t₁, t₂) = ⌊4t₁⌋`, KS-1's conclusion holds, and `K′` is the image of `θ_{C9}`."
- **KS-C.** "Over ℚ(√47), KS-1 together with T-C(A) at `S = ∅` implies: no four-colouring of ℚ(√47)'s plane has the form `x ↦ W(Θ(x) + t)` with `Θ : R → Tⁿ` a homomorphism, `W` measurable and the colouring proper for almost every `t`."
- **K0.** "J45's A⁺ and SP-Cor hold, with the same proofs, over every real quadratic field in T-C(A)'s class (so over ℚ(√143), ℚ(√311), ℚ(√335)), given T-C(A) there at `S = ∅`."

**Verified inputs you may use as given, by statement:** row 98 (band rigidity at every band, `Θ_k(R_F) ⊆ T + A`); row 109 (M3-J21-MX, the
mixing selection, `plans/M3-derivation.md`); row 96 (`Θ₄(ℚ(√47)) = ∅`); row 94 (C9); R88-TCA (T-C(A), `plans/R88-derivation.md`); row 105
and Lemmas C, C′ (`R = O′`); J45's lemma statements (`plans/FS84-SI-D-derivation.md` §5.4: SI-1 to SI-5, RU, SP-oi, SP-if, A⁺, B⁺); Berend
1983/1984 and Furstenberg 1967 (held); weak approximation for norm-one tori of quadratic extensions.

## Stages

1. Quotation check; a C0 table of your probabilities per claim, before any derivation. Save.
2. Blind derivation, claim by claim: TRUE / FALSE with a counterexample / GAP at a named step. **Run the controls first** (KS-4, KS-5), and
   for each control say what a wrong-reason pass would look like (G21). Save.
3. The write-up with per-claim verdicts; commit **before** opening anything fenced. Save.
4. **Fallback (FS-89's rule):** if stage 2 stalls on a claim, and only after stage 3 is committed, you may read J51D's lemma statements
   (not its proofs) and check them one by one. Save; the report.

**Stop rule:** at 250k harness tokens, finish the current claim, save, report. Every verdict counts; do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The finite-witness ban runs to 2026-10-01** (standing rule 3); keep a "would have searched here" log.
- Record `plans/FS100-J51V-verification.md` with "Theorems this phase proved"; working files `data/fs100/j51v/`; exact checks
  `tools/j51v_*.py` with plants watched firing. Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`.
- Commits by explicit path, subjects "J51V: stage n", never amend, push after each commit, never force-push.
- Report (standing rule 9) to `data/crunch-2026-09-25/reports/J51V.md`, committed, and by SendMessage to "main"; final turn text
  "J51V idle; report sent to the owner by SendMessage".

Thank you.
