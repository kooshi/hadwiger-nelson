# Brief FS131-K2b — wave 2 of the Lean backlog, finished: the six example rows, the obligation-modeling pass, one question about a merged clause

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K2b
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the successor of FS131-K2 on wave 2's plan — state the six rows it left, run the obligation-modeling pass over the whole wave, settle one question about a merged clause, and bring the implementer's handoff to all 28 rows
  launch: now, beside FS131-I1 (wave 1's implementer) and FS131-K3 (wave 3's planner), each in its own worktree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K2b.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w2-kernel-plan.md` (on branch `fs131-w2`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): the wave-2 modules (`Proofs/HadwigerNelson/Plane/CoverExamples.lean` above all, and any wave-2 module the obligation pass reshapes without changing a statement already read back), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w2-kernel-plan.md`, `tools/fs131_k2_*.py`, `data/fs131/k2/`, `data/fs131/reports/FS131-K2b.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k

Hello. You are picking up wave 2's plan from a colleague who ran out of room. FS131-K2 (de Bruijn on Opus, like you) built wave 2's foundation
sorry-free, stated 22 of its 28 rows as a Lean skeleton with read-backs and leaf plans, found one false clause (ruled; see below), and handed back
at its context line with a precise list of what is left. Its record is the handoff: start there, not from scratch.

## Why this job

This milestone formalizes the hand results the milestones before Workflow 3.1 left on paper, wave by wave; a wave lands on `main` only when every
one of its rows is stated and its implementer's gate is green, so wave 2 cannot go to its implementer until these six rows are written. The six
are the examples — the colourings R7, DISC7 and HC and the band, fixed-point and irregularity rows — and they matter beyond their own rows: they are
the inhabitants the vacuity gate needs for wave 2's and later waves' class statements (the opening plan § 7.3, item 5).

## The statements

Your rows are the six FS131-K2 left: FS111-M-R7, FS111-M2-DISC7, FS111-M3-BAND, FS111-M3-HC, FS111-M3-FIXCONV, FS111-M3-IRREG — each quoted with its
errata and merge notes in `plans/LEAN-BACKLOG.md` at its heading (and in K2's `data/fs131/k2/rows-wave2.md`), its definitions in
`plans/FS111-derivation.md` at the address the backlog gives. K2's own list of what is left, which is your starting point:

> State FS111-M-R7, FS111-M2-DISC7, FS111-M3-BAND, FS111-M3-HC, FS111-M3-FIXCONV, FS111-M3-IRREG in `Plane/CoverExamples`, each object
> — source: .claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md § 4.4 Left for the next planning session

(read it on the branch: `git -C /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2 show HEAD:plans/FS131-w2-kernel-plan.md`, or open the file
in the worktree; it continues with each object's construction and ends "Then run `debruijn-obligation-modeling` over the whole wave and re-price.")

The rulings already in force for this wave, in `plans/FS131-close-inventory.md`: item 19 (FS111-M-COVER-SC's second clause takes the curvature form,
with the Lipschitz semiconcavity as a corollary — R7's cusped down triangles are its counterexample, so your R7 construction is that defect's
witness: state the failure of the literal clause on R7 as a lemma if it costs little), item 22 (`Row130M1`, `hR78`, `hR88`, `hR88per` as named
hypotheses from outside the backlog), and item 23 (the question below).

## Done means

1. **The six rows stated** in Lean with `sorry` at every leaf, each object defined sorry-free first with a spec example, each read back against its row
   in the record (a § 4.1-style table), each with a leaf plan (a § 4.2-style entry); the branch building through the worktree's `./scripts/build.sh`
   with only `sorry` warnings; `tools/check_architecture.py` exit 0; `Proofs.lean` and `scripts/Axioms.lean` updated.
2. **The obligation-modeling pass** (`debruijn-obligation-modeling`, invoked fresh) over the whole wave's skeleton — all 28 rows — with the leaf plans
   re-priced and any decomposition it changes recorded. It may add or split children and reshape proofs' plans; it may not change a statement already
   read back without telling me first (a statement change is a ruling).
3. **The question of inventory item 23 settled**: read QB § 2.7 (the argument FS106-COMP's ⟸ direction cites; find it from COMP's entry in
   `plans/FS106-derivation.md`) and say whether it uses FS106-SUP's attainment clause, which SUPK, merged in SUP's place, drops at general k. If it does,
   state attainment where COMP needs it as carried content of SUP's merged row, and message me — a merged form that lost a needed clause is a finding.
4. **The handoff section** (K2's § "Where it is, and how the implementer works", stage 5) brought to all 28 rows: the leaf count, the build log, what the
   implementer may and may not change, how the wave lands.
5. Your stages appended to the record, headed "Stage n — SAVED" from the next number; the report in standing rule 11's form.

## What is yours to decide

The constructions' Lean representation (K2's sketch is a sketch), the order of the six, and the obligation pass's decompositions. If an example's
object cannot be built as its derivation describes — a gap function that misses its bounds, a claimed cover that is not maximal — that is a finding:
message me with the object and the failure. A widening the kernel allows is a generalization: message me as well.

## Stages

1. **The readback**: check the quotation above against the record on the branch; restate the six rows, the three rulings, and the question in your
   record. Confirm the worktree builds as K2 left it (one `./scripts/build.sh` run under the slot). Commit on the branch and push.
2. **The six rows**. Commit after each object is sorry-free and after the rows are stated.
3. **The question** (item 23). Commit.
4. **The obligation-modeling pass** and the re-pricing. Commit.
5. **The handoff section**, then report.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5); on
exit 75, wait ten minutes and retry. `lake env lean <file>` is for iteration only. The worktree's `.lake/build` is its own copy; never replace it with a
symlink. Nothing with a `sorry` reaches `main`: the wave stays on `fs131-w2` until its implementer lands it.
