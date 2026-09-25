*Brief for crunch job **J10**, milestone M1 (FS-91), blind verifier of J07 (the character local–global theorem). Opus 5.5, 2026-09-25.
Written by J03 (`plans/FS91-character-local-global.md` §S) **before any J07 claim existed** (FS-89's V-A rule).*

Hello. You are de Bruijn (`DEBRUIJN.md`), acting as **a blind verifier**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** The verdicts are yours.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`, and
continue at the first stage not SAVED. Redo nothing saved.

## The question, and why now

A band character `θ` of the ring `R_F = ℤ[U_F]` (the unit vectors of a real field's plane) sends every unit vector into `B_k = [1/k, 1 − 1/k]`;
`⌊kθ⌋` is then a proper `k`-colouring — a **character colouring**. A derivation agent (J07) is attempting the claim below: every character
colouring comes from **one** residue target of the field, so the local–global conjecture holds for all character colourings. You check it
the way someone who trusts none of it would: from the statement, blind to the route. **Every verdict counts, and none is preferred**
(Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*). TRUE, FALSE with a counterexample
(a band character of some `R_F` with no band target), or GAP with the missing step named — each is a result. The project would like this
true, which is exactly when its failure mode bites (`CLAUDE.md` G21); audit it as hard as a result you disliked.

## The claims (verbatim; the fixed list)

Objects: FS-89's §0.1 notation (`plans/FS89-rational-band-rigidity.md`), and these definitions, quoted from
`plans/FS91-character-local-global.md` §S "The target statements": "`F` a real number field (a subfield of ℝ of finite degree; other
embeddings may be complex), `L = F(i)`, `c` complex conjugation, `U_F` the unit vectors of `F²` read in `L`, `R_F = ℤ[U_F]`. A **stable
place** is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`. The **residue target at level `m`** is `T_{𝔓,m} = Cay(O_𝔓/𝔓^m, S_{𝔓,m})`, `S_{𝔓,m}` the
image of the local norm-one group. A **band `k`-character** of an abelian Cayley graph `Cay(G, S)` is a homomorphism `λ : G → ℝ/ℤ` with
`λ(S) ⊆ B_k`; `χ_char(G, S)` is the least such `k` (∞ if none); `χ_char(F²)` is the least `k` with `Θ_k(R_F) ≠ ∅`. **`H_k`** is the
hypothesis `Θ_k(R_F) ⊆ T + A` for every real number field `F`."

- **V1 = CLG_k** (same file, §S): "Let `k ≥ 3` satisfy `H_k`, and let `F` be a real number field. Then `Θ_k(R_F) ≠ ∅` if and only if some
  stable place `𝔓` of `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`. Hence `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})`,
  and a character `k`-colouring of `F²` exists only if some residue target of `F` is `k`-colourable."
- **V2 = the κ-form** (§M.1): "`κ(R_F, U_F) = max over stable places 𝔓 of κ(O_𝔓, S_𝔓)`, under `H_β` for the `β` in question", where
  `κ(G, S) = max{β : some character λ has λ(S) ⊆ B_β}` and `B_β = [β, 1 − β]`.
- **V3 = CLG-g** (§S): "Under `H_k`, for every real number field `F`: a character `k`-colouring of `F²` exists only if `L(F) ≤ k`, except
  possibly through a place of residue characteristic `p ≤ k/2` above level one."
- **V4 = the controls, as consequences of V1** (§S, CLG-f): `[Fischer1994]`'s ℤ/4 colouring of K (`LEDGER.md` row 89) returns a dyadic target
  at level 3; row 94's C9 on ℚ(√11) returns Γ₇; row 96's three corollaries follow.

For each: TRUE / FALSE / GAP, **at `k ≤ 9`** (`H_k` verified there: row 95; J01's PA-B3, `plans/FS91-S0V-band-to-nine.md`, which you may read)
and **at every `k` given `H_k`**. Say which hypotheses you used, whether Lemma R's scope (`plans/FS86-derivation.md` FS86-B1-LR, scope
corrected by CL2) is needed, and whether fields with complex embeddings (for example ℚ(α, √7), `α³ = α + 1`) are covered.

## Read first, from disk — verified inputs

- `plans/FS89-derivation.md` §1–§9 (S0A-2 the gluing, S0A-3, S0A-4, S0A-7, S0A-8, S0A-9, D2-T1, D5-T2, CL2–CL5) and the records they cite
  (`plans/FS89-S0A-gluing-verification.md`, `plans/FS89-S1VB-verification.md`).
- `plans/FS86-derivation.md` FS86-B1-LR, FS86-LP, FS86-dB-Sv, FS86-V3; `LEDGER.md` rows 52, 57, 63, 67, 70, 88, 89, 94, 95, 96.
- `CLAUDE.md` G35, G43, G55, G56, G66, G71, G74, G76 and § Notation.

## Fenced until your phase-1 verdicts are committed

- `plans/FS91-character-local-global.md` (the plan: its §S lemma statements and §M.2 carry a route) — except the four quoted blocks above;
- J07's record `plans/FS91-S1D-character.md`, `data/fs91/j07/` (in phase 2 you open only `lemma-statements.md` there), `tools/crunch_j07_*`,
  J07's brief, `git log -p` / `git show` of commits whose subject begins "J07", and `plans/FS91-close-inventory.md`;
- `plans/FS91-S0F-three-colours.md` and `plans/FS91-S0FV-three-colours-blind.md` (the three-colour case's route);
- `plans/PA-tardif2023.md` §5; every other crunch brief, record and report except `STANDING-RULES.md`, this brief and J01's record;
- every scratch directory but your own.

## Stages

1. **Quotation check and C0 (about 20k).** Check the quotations; write a probability per claim before deriving. Save.
2. **Phase 1, blind (about 150k).** Derive or refute V1–V4 by your own route. If your route stalls, the verdict is **GAP at that step**, not a
   guess. Exact checks in `tools/crunch_j10_*.py`, each with a planted fault that fires for its own reason. Commit the verdicts, then report
   (standing rule 9, STAGE 2 SAVED).
3. **Phase 2, the lemma statements (about 80k)** — only after J07's stage 5 is committed and your phase-1 verdicts are. Open
   `data/fs91/j07/lemma-statements.md` (statements, no proofs) and derive or refute each lemma your phase 1 did not establish; then check the
   assembly. Save.
4. **Divergence table (about 30k).** Open J07's record; every difference of truth, scope or route. Save and report.

## Record and paths

- **Record:** `plans/FS91-S1V-character.md`, with "Theorems this phase proved" and the would-have-searched log (no finite-witness search to
  2026-10-01).
- **Data:** `data/fs91/j10/`. **Tools:** `tools/crunch_j10_*.py`.
- **Budget:** about 350k harness; hand back with the record saved by 420k.
- **No children:** no subagents, forks or workflows — delegation is one level deep (`CLAUDE.md` § Delegation), because staffing is Kooshi's
  budget decision and the owner can only review work it knows about. A saved stage with the remainder named is a good report.
- **Report:** to `data/crunch-2026-09-25/reports/J10.md` and `"main"` by SendMessage.

Thank you.
