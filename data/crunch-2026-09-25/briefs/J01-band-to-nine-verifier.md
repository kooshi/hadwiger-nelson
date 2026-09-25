*Brief for crunch job **J01**, milestone M1 (FS-91, stage 0): a blind verifier of PA-B2 and PA-B3. Opus 5.5, 2026-09-25. Written by
the crunch planner (`plans/CRUNCH-2026-09-25-queue.md` §2).*

Hello. You are de Bruijn (`DEBRUIJN.md`), working as a **blind verifier** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. The house rules are `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`; read all three from disk, since the
copy loaded at your start may be stale. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** The
product owner coordinates and reviews by artifact. The verdicts are yours.

## Why this check, and why blind

FS-89 proved (`LEDGER.md` row 95) that at four and five colours every **band character** of `Q = ℤ[i][1/p : p ≡ 1 (mod 4)]` is a
torsion character plus an archimedean one. A band character at `k` colours is a homomorphism `θ` to `ℝ/ℤ` with `θ(u) ∈ [1/k, 1 − 1/k]`
for every unit vector `u`.

At FS-89's close, two readers (the close planner, and the reader of Berend 1984) each noticed that the proof might reach **six to nine
colours**. They did not reach that independently: both came from one lemma. Neither checked it.
- **If it holds:** FS-89's result moves from five to nine colours for character colourings, and the character form of the conjecture at
  ℚ(√167), where the conjecture predicts six or more, becomes decidable.
- **Your job:** re-derive the claims from their statements alone, before you see anyone's argument for them.

**Every verdict counts, and none is preferred** (standing rule 4). This is a result the project would like to be true. That is exactly
when its recorded failure mode bites.

## Read first, from disk

1. `CLAUDE.md` § Notation, G21, G30, G71, G74, G76; `WORKFLOW.md`; `DEBRUIJN.md`.
2. `LEDGER.md` rows 95–97.
3. `plans/FS89-rational-band-rigidity.md` §0.1–§0.3 only: the objects `R_S`, `U_S`, `Θ_k`, `T`, `A`, the leaves, and the statements
   `MS_k`, `RS_k`, `RQ_k`.
4. **FS-89's verified records, in full.** They hold the four- and five-colour proofs you will re-derive at larger `k`:
   - `plans/FS89-S1VB-verification.md`: B1.0's four lemmas including Lemma SW, B1.1, the lemma verdicts, the assembly, VB1–VB4;
   - `plans/FS89-S1D-derivation.md`;
   - `plans/FS89-S1V-verification.md`;
   - `plans/FS89-S0A-gluing-verification.md`;
   - `plans/FS89-S0B-band-set.md`.
5. `plans/FS89-derivation.md`, **except** the entries named in the fence below.
6. The held papers: `~/source/library/pdf/Berend1984-multi-invariant-sets-compact-abelian-groups.pdf` (`[Berend1984]`, TAMS 286:
   Theorem I.2, p. 509, and Proposition II.6, p. 523); `…/Berend1984-minimal-sets-on-tori.pdf`; `…/Berend1983-multi-invariant-sets-on-tori.pdf`;
   `…/Furstenberg1967-disjointness-ergodic-theory-minimal-sets.pdf`.

## What you must not open until your verdicts are committed

They hold the argument for the claims below:
- `plans/FS89-PA-berend1984.md` §5 and §9;
- `plans/FS89-derivation.md`: its §10, and the proof lines of its PA-B2 and PA-B3 entries (read their statements only, as quoted here);
- `plans/STUB-band-rigidity-six.md`;
- `plans/FRONTIER-STUBS.md` row 2;
- `plans/FS89-close-inventory.md` items 41 and 47;
- `plans/POROS-2026-09-25-crunch-plan.md`;
- every other crunch brief and record.

After your verdicts are committed, you may open the first four to write a divergence table.

## The claims (verbatim)

The objects are FS-89's §0.1.

1. **PA-B2** (`plans/FS89-derivation.md`, its entry's statement): "for every finite `S` with `|S| ≥ 2`, every `U_S`-minimal closed
   `M ⊊ R̂_S` lies in `T + A` (D1-L2, D1-L3, Berend Thm I.2 + Prop. II.6)". The parenthesis names the inputs the reader used; you may use
   them or not. The reader's consequence, also to check: "So `MS_k(S)` holds at every band `k`."
2. **PA-B3** (`plans/FS89-derivation.md`, its table row): "(candidate) `RS_k(S)` for `k < 2·min S`, `|S| ≥ 2`; `RQ_k` for `k ≤ 9` (PA-B2
   with VB1–VB4)". Its source adds "at `S = {5, 13}`, **`RQ_k` for every `k ≤ 9`** (and `RS₅(S)` without `5 ∈ S`)".

**Your deliverable, per claim and at each of `k = 6, 7, 8, 9`:**
- a verdict, TRUE / FALSE / GAP;
- **the exact line of each proof you re-derive that uses the value of `k`**, and what it needs of `k` there;
- for the step from `RS_k({5, 13})` to `RQ_k`, whether the layering and gluing (VB3, VB4, D2-L1) use `k` anywhere.

## Stages

- **Stage 1 (C0; about 20k).** Check this brief's quotations against their sources. Then write a probability per claim and per `k`,
  before any derivation. Save.
- **Stage 2 (PA-B2; about 80k).** Derive or refute it from its statement, checking Berend's hypotheses against our action yourself.
  Save.
- **Stage 3 (PA-B3 at `k = 6`, then 8, then 9, then 7; about 150k).**
  - Re-derive the point step and every band step at each `k`, one `k` per saved section.
  - Any exact check goes in `tools/crunch_j01_*.py`, with a planted fault.
  - If your budget runs short, stop after `k = 6`, which is the one the next job consumes, with the record saved.
- **Stage 4 (the divergence table; about 30k).** Open the fenced files and compare: every difference of truth, scope or route.

## Your record and your paths

- **Record:** `plans/FS91-S0V-band-to-nine.md`. It holds C0, one section per claim and `k`, the divergence table, the would-have-searched
  log, and "Theorems this phase proved".
- **Data:** `data/fs91/j01/`.
- **Budget:** about 350k in the harness's count. Hand back by 420k.
- **Report:** standing rule 9. Report after stage 3's `k = 6` section as well, because the six-colour derivation job waits on it.

Thank you. This check decides whether the next derivation (character six-colourings at ℚ(√167)) stands on a verified theorem or on a
named hypothesis.
