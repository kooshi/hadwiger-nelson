*Brief for crunch job **J28**: the reframe and subplan of a new milestone, "row 88's question — is (0, 4) forced over ℚ(√59)?"
(FS-86's open question; queue row J28). Opus 5.5, 2026-09-25. Written by the product owner per `plans/CRUNCH-2026-09-25-queue.md` §4.2.
**The reframe template is J03's brief** (`data/crunch-2026-09-25/briefs/J03-M1-reframe.md`): read it in full and follow it, with the
changes below, which override it where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the milestone's planner**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.**
I'm the product owner.

**If your plan already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS86-row88-rigidity.md` and
continue at the first stage not SAVED.

## The milestone (replaces J03's milestone block)

**The question** — `LEDGER.md` row 88 (read the whole row; its opening, verbatim): "**The field-level frame for type-(B) fields: over
ℚ(√59), ℚ(√83), ℚ(√131) either every four-colouring of the plane is periodic or some one is not (`F(R) ∈ {0, P(R)}`), every periodic one
is local at the dyadic place (`P(R) = R ∩ 𝔓⁴`), so the whole four-colour rigidity question is whether the single pair `(0, 4)` is
forced**". The queue states the milestone as: "row 88's own question: a non-character four-colouring of ℚ(√59)'s plane, or a proof that
`(0, 4)` is forced. The true frontier; prior 0.05–0.1."

**What is already known, and must be read first** (CLAUDE.md item 24 and G76 point to all of it): rows 88–94 and 96; the FS-86 records
(the plan `plans/FS86-dyadic-rigidity.md`, its §R-close first; `plans/FS86-derivation.md`; the competitors' and verifiers' records `plans/FS86-C-*.md`, `plans/FS86-V-*.md`, `plans/FS86-B*.md`); FS-89's row 96
(HD1: no character four-colouring breaks inheritance on these fields). **And today's crunch** (M1–M3 closes, in their plans' §R-close; the
index `plans/CRUNCH-2026-09-25-INDEX.md`): M1's class theorem CLG (an **existence** statement: a band k-character exists iff one exists at
some stable place — never "every character colouring is local"); band rigidity at every band (`[Manners2015]` Lemma 5.3 is the one-ring
special case in print); M3's windows result over ℚ(√167) (J21-MX, J21-RED: measurable windows reduce to a few non-mixing places) —
FS-86's row 92 excluded measurable windows at four colours on type-(B) planes, and M3's machinery may bear on the non-periodic side here.
**The shape G76 dictates:** a "no" must disagree with every pullback in every archimedean direction, patch no two pullbacks, read
infinitely many split places, and be no character; a "yes" is a local forcer realised without triangles (ℚ(√59) has no √3) — which is
Soifer's Open Problem 55.1's territory (`CLOSED-QUESTIONS.md` §3).

**Change J03's other blocks accordingly:** one milestone, one verdict column; the §PA disciplines are the stub's and G76's (Furstenberg–Berend
rigidity, forced periodicity / Kari–Szabados, invariant random colourings, triangle-free rigidity) plus "four-colourings of the unit-distance
graph over ℚ(√59)"; §IQ as WORKFLOW 3.3 (the structural form must be about every four-colouring of a type-(B) plane); the briefs you write
are this milestone's derivation and its blind verifier's fixed claim list (before any claim exists, FS-89's V-A rule); the paths are
`plans/FS86-row88-rigidity.md`, `data/fs86r88/j28/`, `tools/crunch_j28_*`. Register priors (P-…) before any derivation.

## Rules (in addition to J03's)

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **The finite-witness ban** runs to 2026-10-01: no SAT, MILP, Θ trees or finders, quotient searches or sweeps; a stage that needs one is
  written as a post-ban stage, dated, with its brief. FS-90's two sanctioned hours are Kooshi's to grant, not this plan's.
- Every outcome counts — a proof that `(0, 4)` is forced, a non-periodic four-colouring, or a named obstruction; do not lean toward a yes.
- Do not edit the index, any M1–M3 file, FS-84's files, or the four front-page files (a front-page job may be running).
- **Commits by explicit path**, subjects "J28: stage n"; push; never force-push.
- **Budget:** about 350k by the harness's count; hand back by 420k.
- **Report** in the fixed ≤ 12-line form to `data/crunch-2026-09-25/reports/J28.md`, committed, and by SendMessage `to: "main"`, with
  the jobs it proposes as Q-lines plus their brief files. Keep your turn's final text content-free: "J28 idle; report sent to the owner
  by SendMessage".

Thank you.
