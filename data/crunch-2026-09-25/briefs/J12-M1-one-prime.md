*Brief for crunch job **J12**, milestone M1 (FS-91), derivation (one prime). Opus 5.5, 2026-09-25. Written by J03
(`plans/FS91-character-local-global.md` §S, §M.2).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the derivation agent for the one-prime questions**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** The owner coordinates and reviews by artifact; the mathematics is yours.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`, and
continue at the first stage not SAVED. Redo nothing saved.

## The question, and why now

FS-89 proved that with two or more split primes inverted, every four-colour band character of `R_S = ℤ[i][1/p : p ∈ S]` is torsion plus
archimedean (row 95), and that with the one prime 5 this fails: a **heteroclinic** character reads the order-3 character forward and the
parity character backward, and continuum many switching characters exist (row 97, `plans/FS89-S0B-band-set.md`). Berend's Lemma 3.3
(`[Berend1984min]`) says one parameter always has minimal sets of positive dimension. Three questions were left: is the one-prime failure
**universal** (every `p ≡ 1 (mod 4)`), does it reach **minimal sets** at 5, and are the one-prime torsion **orders unbounded**? They decide
how sharp row 95's "two primes" is, and whether the rank-one failure is Berend's phenomenon or a stronger one. **Every outcome counts**
(Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*); do not lean toward either answer.

## The statements (verbatim)

From `plans/FS91-character-local-global.md` §S, "J12 — one prime":
- **ONE-a (U3).** "For every prime `p ≡ 1 (mod 4)`, `Θ₄(R_{{p}}) ⊄ T + A`."
- **ONE-b (`MS₄({5})`).** "Is every `U₅`-minimal closed subset of `Θ₄(R₅)` contained in `T + A`?"
- **ONE-c (U5).** "Are the orders of band torsion characters of `R_{{p}}` unbounded at one prime — by a derived infinite family, each member
  checked by an exact finite computation; never a list extended in search of a pattern."

The plan's §M.2 reduces ONE-b (one mind, unchecked): "a minimal set meeting `T + A` is a leaf circle, so a counterexample is a switching
character with bounded run lengths in both directions that is uniformly recurrent; the obligation is whether S0B-T5's tree admits switches
at bounded gaps." Check that reduction before using it. The source of U3 (`plans/FS89-rational-band-rigidity.md` §0.3): "`RS₄({p})` fails for
every single prime `p ≡ 1 (mod 4)`, by S0B's lens (the parity and order-3 discs meet, `√2/6 < 1/4`, independently of `p`)." Only `p = 5` is
proved (FS89-S0B-T3); the step rule `e_{m+1} − w̄_p e_m ∈ π_p^{−1}ℤ[i]` depends on `p`, the lens does not.

## Read first, from disk

- `plans/FS89-S0B-band-set.md` in full (the orbit model §1, leaves §2, the heteroclinic §3, the torsion list §4, the second prime §6) and its
  tools `tools/fs89_s0b_*.py` (read; do not edit — they are another job's) and `data/fs89/s0b/` (`torsion-points-k4-N130.txt`: 12 orders
  below 130, a finite measurement).
- `plans/FS89-derivation.md` §2 (S0B-T1 to T6, L4), §4 (D0-T1, the rank-`r` model), §6 (D1-L2, D1-L3 — why rank one fails);
  `plans/FS89-S1V-verification.md` § V-A3 (Theorem V4) and § V-A4 (V5, V6); `plans/FS89-S1D-derivation.md` where D predicts `MS₄({5})`
  false (0.75).
- `[Berend1984min]` (`~/source/library/pdf/Berend1984-minimal-sets-on-tori.pdf`) Lemma 3.3; `plans/FS89-PA-berend1984.md` for the TAMS papers'
  one-parameter constructions (Lemma II.6, Prop. II.3: homoclinic orbits).
- `CLAUDE.md` G74, G76, G21; `LEDGER.md` rows 95, 97.

## Fenced

Nothing is fenced from you. Your verifier J13 is fenced from your record, data, tools and brief; write nothing it reads.

## Stages

1. **Quotation check and C0 (about 20k).** Probabilities: ONE-a true; ONE-b answered "no"; ONE-c "unbounded". Save.
2. **ONE-a (about 100k).** The heteroclinic at a general `p`: set up S0B-T1's orbit model with `w_p`, `π_p`; construct the gluing and prove it
   stays in the band — a construction valid for every `p`, or the finitely many exceptions named with the reason. An exact check at
   `p = 5, 13, 17, 29` in `tools/crunch_j12_*.py`, a planted fault firing for its own reason. Save.
3. **ONE-b (about 100k).** Check §M.2's reduction; then construct a uniformly recurrent switching character with bounded runs, or prove every
   switching character has unbounded runs (so every minimal set is a leaf circle). Save.
4. **ONE-c (about 70k).** First derive the criterion for a torsion character of `ℤ[i]/N` (`5 ∤ N`) to be band on `U₅`; then derive an
   infinite family of orders `N` (the advisor's pointer: primes dividing `Φ_k(w₅)`), and check each member you name by an exact finite
   computation **over the set your derivation fixes**. The advisor's instruction for this list: brief it "as complete enumerations fixed by a
   derivation, and logged" (`plans/POROS-2026-09-25-crunch-plan.md`, line 130); trying orders until one works is out. Save.
5. **Lemma statements for your verifier (about 15k):** statements only, no proofs, to `data/fs91/j12/lemma-statements.md`. Save and report.

## Record and paths

- **Record:** `plans/FS91-S1D-one-prime.md`, with "Theorems this phase proved" and the would-have-searched log (no finite-witness search to
  2026-10-01).
- **Data:** `data/fs91/j12/`. **Tools:** `tools/crunch_j12_*.py`, each under 2 minutes and 2 GiB.
- **Budget:** about 350k harness; hand back with the record saved by 420k. Priority if short: ONE-a, then ONE-b.
- **No children:** no subagents, forks or workflows — delegation is one level deep (`CLAUDE.md` § Delegation), because staffing is Kooshi's
  budget decision and the owner can only review work it knows about.
- **Report:** after stage 5 (and at any halt), to `data/crunch-2026-09-25/reports/J12.md` and `"main"` by SendMessage.

Thank you.
