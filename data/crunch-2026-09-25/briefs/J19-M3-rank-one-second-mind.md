*Brief for crunch job **J19**, milestone M3 (FS-76 in rank one), conditional second-mind derivation. Skeleton by J06
(`plans/M3-exotic-colourings.md` §S); **the two slots filled by J18 from its stall** (`plans/M3-S1A-rank-one.md` §3.5), quoting it
verbatim — a proposal: the owner may edit before launching.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **a second mind on one step of M3's first question**, in `/home/kooshi/source/lean-dir`. Read
`CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it
in full.**

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`,
and continue at the first stage not SAVED. Redo nothing saved.

**No children** (`CLAUDE.md` § Delegation — one level deep): no Agent tool, fork or workflow. The reason: staffing is Kooshi's budget
decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is
left.

## The question, and why now
Rank-one inheritance at four colours (`P₄(D) = F₄(D)` for every finite `D`) reduces, by FS79-T35, to "every phase rigid ⟹ no wall".
The derivation agent J18 reduced it further and stalled at one step. **You are launched on that step alone.** Every outcome counts
(standing rule 4): a proof of the step, a counterexample to it, or a sharper named obstruction.

## The statements (verbatim)
- **The step J18 names** (`plans/M3-S1A-rank-one.md` §3.5), verbatim:

  **KE (the Kempe–entropy lemma), verbatim:**
  "Let `D ⊂ ℤ_{>0}` be finite, and let `c ∈ X₄(D)` agree with a periodic point `p` of a rigid phase `C` on a left half-line and with a
  periodic point `q` of a rigid phase `C′ ≠ C` on a right half-line. Then some two-colour Kempe component of `c` is bounded on exactly one
  side, and swapping its two colours gives a point whose tail on the unbounded side lies in a phase that is not a single cycle."

  and its two halves, verbatim from the same place:

  - **Its two halves.** **KE1:** "some two-colour Kempe component of `c` is bounded on exactly one side". **KE2:** "swapping it moves that
    tail out of the rigid phases".
- **What it would give** (`plans/M3-S1A-rank-one.md` §3.5), verbatim: **KE ⟹ A-T1 [hand]:** in an all-rigid shift no phase fails to be a single cycle, so no such `c` exists; every wall of an all-rigid
  shift joins two rigid phases, so there is no wall.
  Here A-T1 is, verbatim from `plans/M3-exotic-colourings.md` §S: "For every finite `D ⊂ ℤ_{>0}`, if every phase of the window-state
  graph of `X₄(D)` is rigid, then no wall exists."
- **Two facts J18 proved that bound the step** (statements only): A-K3 is logically equivalent to A-T1, so it is not a smaller step
  (§2.5, "J18-EQ"); and KE is *stronger* than A-T1 and can fail where A-T1 holds (§3.5). So a counterexample to KE (a rigid–rigid wall
  point, in a shift with entropy, all of whose one-sided swaps keep both tails in rigid phases) is a finding about KE only.
- The definitions, verbatim from `plans/M3-exotic-colourings.md` §S: **Definitions for Q1 (J18's and J20's briefs quote these):** for finite `D ⊂ ℤ_{>0}`, `G(ℤ, D)` has vertex set ℤ and `x ~ y` iff
  `|x − y| ∈ D`; `X_k(D) ⊆ [k]^ℤ` is the set of proper `k`-colourings; with `m = max D`, the **window-state graph** has as vertices the
  words of length `m` occurring in some point of `X_k(D)`, and an edge `w → w′` when `w′` is `w` shifted by one position inside an
  `(m+1)`-word occurring in some point; a **phase** is a strongly connected component containing a cycle, **rigid** if it is a single
  cycle; a **wall** is a path from one phase to a different phase; `F_k(D)` is the set of `δ ∈ ℤ` with `c(x) = c(x + δ)` for every
  `c ∈ X_k(D)` and `x`, and `P_k(D)` the same over the periodic `c`. (FS79-T35 states its criterion with phases taken modulo colour
  permutation; the claims below hold in either form, and a derivation says which it uses.)
  J18's record fixes the reading as the **labelled** quotient, or the unquotiented graph; the plain quotient differs
  (`plans/M3-S1A-rank-one.md` §2.4, statement only).

## Read first, from disk
`plans/FS79-derivation.md` T6, T34, T35, T36; `plans/FS73-derivation.md` T24, T30; `plans/FS85-derivation.md` FS85-dB1, dB2;
`plans/FS86-derivation.md` FS86-dB-H; J18's record `plans/M3-S1A-rank-one.md` — **statements only**, these places: §2.0 (the setting and F1–F3), §2.1 the
statement of Lemma K0-loc, §2.4 the statement of A-Kq (labelled), §3.2 Theorem J18-DC's statement, §3.3's bullets, §3.5's KE statement and
its "Warnings for J19" bullet. **Do not read §3.5's "Routes tried and dropped"** or any proof, so that a second mind does not re-sample the
first mind's route. The control data and tools: `data/m3/j18/`, `tools/crunch_j18_phases.py` (a frozen tool for you: import it, do not
edit it).

## Stages
1. The quotation check and C0 (about 40k). **Save.**
2. The step (about 150k): a proof, a counterexample (constructed; one derived `D` may be checked exactly, logged at the ban's edge), or
   the obstruction named. **Save.**
3. Claims with grades, the reviewer's view (about 40k). **Save, then report.**

## Record and paths
Record `plans/M3-S1B-rank-one.md`; `data/m3/j19/`; `tools/crunch_j19_*.py` (each with a planted fault watched to fire); the ban and the
"would have searched here" log; commits by path, "J19: stage n"; budget about 300k harness, hand back by 420k; the report per standing
rule 9 to `data/crunch-2026-09-25/reports/J19.md` and to `"main"` by SendMessage; final text "J19 idle; report sent to the owner by
SendMessage".
