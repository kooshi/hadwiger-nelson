*Brief for crunch job **J13**, milestone M1 (FS-91), blind verifier of J12 (one prime). Opus 5.5, 2026-09-25. Written by J03
(`plans/FS91-character-local-global.md` §S) **before any J12 claim existed**.*

Hello. You are de Bruijn (`DEBRUIJN.md`), acting as **a blind verifier**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** The verdicts are yours.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`, and
continue at the first stage not SAVED. Redo nothing saved.

## The question, and why now

With one split prime `p` inverted, the four-colour band characters of `R_{{p}} = ℤ[i][1/p]` need not be torsion plus archimedean: at `p = 5`
a heteroclinic character exists (`LEDGER.md` row 97). A derivation agent (J12) is attempting the three statements below. Check them from the
statements, blind to its route. **Every verdict counts** (Kooshi: *"A proven theorem about why its impossible is also valid. All novel
knowledge is a success."*): TRUE, FALSE with a counterexample, GAP with the step named. Audit a construction you like as hard as one you
dislike (`CLAUDE.md` G21).

## The claims (verbatim; the fixed list)

Quoted from `plans/FS91-character-local-global.md` §S, "J12 — one prime"; objects FS-89's §0.1 (`plans/FS89-rational-band-rigidity.md`):
- **X1 = ONE-a (U3).** "For every prime `p ≡ 1 (mod 4)`, `Θ₄(R_{{p}}) ⊄ T + A`."
- **X2 = ONE-b (`MS₄({5})`).** "Is every `U₅`-minimal closed subset of `Θ₄(R₅)` contained in `T + A`?" — a verdict "yes" or "no", each with
  its proof; or GAP.
- **X3 = ONE-c (U5).** "Are the orders of band torsion characters of `R_{{p}}` unbounded at one prime — by a derived infinite family, each
  member checked by an exact finite computation; never a list extended in search of a pattern."

For X1, say whether the claim holds at every `p`, at all but named exceptions, or only at the primes you can check; for X3, whether the
family J12 names is infinite by proof.

## Read first, from disk — verified inputs

`plans/FS89-S0B-band-set.md` §1–§4 (the orbit model, leaves, the heteroclinic at 5, the torsion list — verified at FS-89; **not** its §6
reading); `plans/FS89-derivation.md` §2, §4, §6; `plans/FS89-S1V-verification.md` § V-A3, § V-A4; `[Berend1984min]` Lemma 3.3
(`~/source/library/pdf/Berend1984-minimal-sets-on-tori.pdf`); `data/fs89/s0b/torsion-points-k4-N130.txt`; `CLAUDE.md` G74, G76, § Notation.

## Fenced until your phase-1 verdicts are committed

- `plans/FS91-character-local-global.md` entirely (its §M.2 carries a reduction of X2), except the quoted blocks;
- J12's record `plans/FS91-S1D-one-prime.md`, `data/fs91/j12/` (in phase 2 only `lemma-statements.md`), `tools/crunch_j12_*`, J12's brief,
  `git log -p` / `git show` of commits whose subject begins "J12", `plans/FS91-close-inventory.md`;
- `plans/FS89-S1D-derivation.md` (the derivation agent's prediction and reasoning on `MS₄({5})`);
- every other crunch brief, record and report except `STANDING-RULES.md` and this brief; every scratch directory but your own.

## Stages

1. **Quotation check and C0 (about 20k).** A probability per claim. Save.
2. **Phase 1, blind (about 150k).** Derive or refute X1–X3. Exact checks in `tools/crunch_j13_*.py` — complete computations over sets your
   derivation fixed first, a planted fault firing for its own reason, a result file written even on a null. Commit the verdicts; report.
3. **Phase 2 (about 60k), after J12's stage 5 is committed:** open `data/fs91/j12/lemma-statements.md` and derive or refute each lemma your
   phase 1 did not establish; check the assembly. Save.
4. **Divergence table (about 30k).** Open J12's record. Save and report.

## Record and paths

- **Record:** `plans/FS91-S1V-one-prime.md`, with "Theorems this phase proved" and the would-have-searched log (no finite-witness search to
  2026-10-01).
- **Data:** `data/fs91/j13/`. **Tools:** `tools/crunch_j13_*.py`.
- **Budget:** about 300k harness; hand back with the record saved by 380k.
- **No children:** no subagents, forks or workflows — delegation is one level deep (`CLAUDE.md` § Delegation), because staffing is Kooshi's
  budget decision and the owner can only review work it knows about.
- **Report:** to `data/crunch-2026-09-25/reports/J13.md` and `"main"` by SendMessage.

Thank you.
