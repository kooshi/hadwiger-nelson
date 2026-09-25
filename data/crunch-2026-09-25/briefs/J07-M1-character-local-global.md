*Brief for crunch job **J07**, milestone M1 (FS-91, `plans/STUB-band-rigidity-six.md`), derivation. Opus 5.5, 2026-09-25. Written by J03
(`plans/FS91-character-local-global.md` §S, §M).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the derivation agent for the character local–global theorem**, in the Lean 4 Hadwiger–Nelson
workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** The owner coordinates and reviews by artifact; the mathematics is yours.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`, and
continue at the first stage not SAVED. Redo nothing saved.

## The question, and why now

A **character colouring** of a real field's plane colours `x` by `⌊kθ(x)⌋` for a band character `θ` — a homomorphism from the ring the
unit vectors generate to the circle, sending every unit vector into `[1/k, 1 − 1/k]`. FS-89 proved (row 95) that at four and five colours
every band character is a torsion character plus an archimedean one; this crunch's J01 verified the same to nine colours, and J01-7 (one
reader; J03a reading it blind now) proposes every `k`. The advisor's question (F2): does every character colouring then come from **one**
residue target — so the local–global conjecture holds for all character colourings, and rows 96's per-field corollaries (HD1, ℚ(√47),
ℚ(√167)) become one class theorem? **Either answer counts** (Kooshi: *"A proven theorem about why its impossible is also valid. All novel
knowledge is a success."*): a proof, a GAP with the step named, or a counterexample — a band character local at no prime — each is a result.
This project's failure mode is selection (`CLAUDE.md` G21): audit a proof you like as hard as one you dislike.

## The statements (verbatim)

From `plans/FS91-character-local-global.md` §S ("J07 — the class theorem"), with the definitions of its "The target statements" paragraph
(stable place, `T_{𝔓,m}`, band `k`-character, `χ_char`, `H_k`):

- **CLG_k.** "Let `k ≥ 3` satisfy `H_k`, and let `F` be a real number field. Then `Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of
  `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`. Hence `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})`, and a character
  `k`-colouring of `F²` exists only if some residue target of `F` is `k`-colourable."
- Its converged form (same file, §M.1): "**`κ(R_F, U_F) = max over stable places 𝔓 of κ(O_𝔓, S_𝔓)`, under `H_β` for the `β` in question.**"
- The sub-statements CLG-a (pullback), CLG-b (the peeling lemma), CLG-c (joint surjectivity), CLG-d (the archimedean factor), CLG-e (level
  collapse), CLG-f (controls), CLG-g (the conjecture for characters) — verbatim in §S; read them there.

**Hypotheses, as the owner has ruled them:** `H_k` for `k ≤ 9` is verified (row 95 at 4, 5; J01's PA-B3 at 6–9, `plans/FS91-S0V-band-to-nine.md`);
at every `k` it is "given J01-7, one reader" until J03a reports TRUE. J02's three-colour theorems are "given J02-T2/T3, one mind" until J09
reports. State every result with the hypotheses it uses, by name.

## Read first, from disk

- The plan, `plans/FS91-character-local-global.md`, **all but §P.basis** — especially §IQ, §S and §M.2 (the obligation tree: the `n`-fold
  peeling lemma, the finite quotient `R_F/NR_F`, the joint image, level collapse). **§M.2 is the planner's route, one mind, unchecked:
  check every step, never assume it.**
- `plans/FS89-derivation.md` (S0A-2 the gluing, S0A-3 N₀, S0A-4 level collapse at 1/4 and 1/5, S0A-7 archimedean averaging, S0A-8, S0A-9,
  CL2–CL5); `plans/FS89-S0A-gluing-verification.md` §C1 for their proofs.
- `plans/FS91-S0F-three-colours.md` (J02) §2.3–§2.8: J02-L2 (the finite quotients `R/pR`), J02-L3 (the Teichmüller section and Hilbert-90
  lift, which avoids Lemma R's Galois scope), J02-T1 (the `k = 3` torsion case — your theorem's first instance) and §2.8 (the warning that
  S0A-7's density step assumes compact archimedean norm-one groups, false for fields with complex places such as ℚ(α, √7)).
- `plans/FS86-derivation.md` FS86-B1-LR (Lemma R and its corrected scope, CL2), FS86-LP (Lemma P), FS86-dB-Sv; `LEDGER.md` rows 88, 89, 94,
  95, 96.
- `plans/PA-tardif2023.md` §5.2–§5.3 (PA-T4, PA-T5): the alternative product step through `[Zhu2011]` (unread) — use only if the peeling
  route fails, and say so.

**Not fenced for you**, but **write nothing into a shared file that a blind job reads**: J10 (your verifier) is fenced from your record, data,
tools and brief, and from the plan.

## Stages

1. **Quotation check and C0 (about 25k).** Check every quotation above against its source; log it. Write a probability per statement
   (CLG_k at `k ≤ 9`; at every `k` given J01-7; CLG-c without Lemma R's scope; CLG-d with complex places; CLG-e; CLG-g). Save.
2. **The core (about 110k).** CLG-a, CLG-b and its `n`-fold form, then CLG-c and CLG-d — the arithmetic steps. State first for totally
   real `F` in Lemma R's scope if the general case resists, and name exactly what the general case needs. Save.
3. **CLG_k assembled, CLG-e and CLG-g (about 90k).** Assemble; derive level collapse at a general band (odd `p > k/2`; what holds at `p = 2`
   and `p = 3`); state CLG-g with its exception made explicit. Save.
4. **Controls and corollaries (about 60k).** CLG-f: `θ₂` on a wall-standing field; `[Fischer1994]` on K (row 89: a dyadic target, level 3);
   C9 on ℚ(√11) (row 94: Γ₇); row 96's HD1, C-47, C-167; J02-T1 at `k = 3`; and §M.1's predicted lemma `κ(F′) ≤ κ(F)`. Any exact check
   goes in `tools/crunch_j07_*.py` with a planted fault that fires for its own reason. Save.
5. **Lemma statements for your verifier (about 20k).** Write every lemma you used, **statements only, no proofs**, to
   `data/fs91/j07/lemma-statements.md`, for J10's second phase. Save and report.

## Record and paths

- **Record:** `plans/FS91-S1D-character.md`, with "Theorems this phase proved" (one line each: statement, grade from `CLAUDE.md` § Notation,
  address) and the would-have-searched log (standing rule 3: no finite-witness search until 2026-10-01; exact arithmetic of seconds that
  checks a derived claim is in).
- **Data:** `data/fs91/j07/`. **Tools:** `tools/crunch_j07_*.py`.
- **Budget:** about 350k in the harness's count; hand back with the record saved by 420k (agents' own counts run at 55–70 % of it). If
  budget runs short, the priority is CLG at `k ≤ 9` for totally real `F` with its controls; say what is left.
- **No children:** you may not spawn subagents, forks or workflows — delegation is one level deep (`CLAUDE.md` § Delegation), because staffing
  is Kooshi's budget decision and the owner can only review work it knows about. Stopping at a saved stage with the remainder named is a
  good report.
- **Report:** standing rule 9, to `data/crunch-2026-09-25/reports/J07.md` and to `"main"` by SendMessage, after stage 5 (and at any halt).

Thank you.
