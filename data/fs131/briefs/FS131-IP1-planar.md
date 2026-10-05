# Brief FS131-IP1 — the planar infrastructure, implemented: plane topology and wave 5's seven planar leaves on `fs131-w5p`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IP1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the planar infrastructure's first implementer — prove FS131-KP's skeleton on `fs131-w5p` in its plan's § 5.1 work order (the plane-topology foundation first, measured), saving after each leaf, and re-price from the first two
  launch: now, beside FS131-IM3 (wave 4's moves, on `fs131-w4m`), FS131-I4m (wave 4, on `fs131-w4`) and FS131-I5c (wave 5's other leaves, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, the answer to the 60° question below if it is no, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IP1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-planar-implementation.md` (new, on branch `fs131-w5p`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): `Proofs/HadwigerNelson/Plane/PlaneTopology.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean`, and in `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` only the declarations FS131-KP's plan § 5.1 lists and children beside them; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend), `plans/FS131-planar-implementation.md`, `tools/fs131_ip_*.py`, `data/fs131/ip/`, `data/fs131/reports/FS131-IP1.md`; not FS131-KP's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the first implementer of the plane topology that wave 5 of the Lean backlog needs. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–3 are landed on `main`, wave 4 is being finished, and wave 5 (termination and density) is being proved on `fs131-w5`
by FS131-I5c — all but seven leaves that share plane topology Mathlib does not have. FS131-KP planned those seven on this branch: it repaired the definition of
a hole, found that unicoherence of the plane can be proved from Mathlib's covering-space lifting theorem (so nothing is imported), and laid out a skeleton of
two new modules that builds green. You prove it.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 cannot
land with these open. This chain is the longest path to wave 5's landing. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` FS131-KP left on `fs131-w5p` at `d0868ff5`: `Plane/PlaneTopology` (8), `Plane/ValidMap/MapTopology` (15), and the joints and children in
`MapGraph`, `BaseWalk` and `BaseDense` its plan names. Each is read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md` §§ 3.2 and 4.1. The work order:

> **Work order** (each step unblocks the next; re-price after the first two):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.1 Where it is, and how the implementer works

(the six steps follow there). What you may change:

> **May:** add children (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), change imports (updating `ARCHITECTURE.md`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.2 What the implementer may and may not change

What KP handed back, and the ruling that launched you:

> 282. **FS131-KP done** (harness ≈ 430k; record `fs131-w5p`'s `plans/FS131-planar-kernel-plan.md`; report `data/fs131/reports/FS131-KP.md`; commits `397a89de` …
> — source: plans/FS131-close-inventory.md

> 283. **Ruling: KP's slot → the planar implementer FS131-IP1 on `fs131-w5p`; the parallel MERGE implementer takes the next slot.** Choice: IP1 works plan § 5.1's
> — source: plans/FS131-close-inventory.md

The definition of a hole, as ruled:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read KP's plan in full (§§ 3–5 above all); build the branch once as given
   (`d0868ff5`) before editing anything; open your record with what you may and may not change. Commit and push.
2. **The foundation, measured**: § 5.1 step 1 (`isPreconnected_inter_of_union_eq_univ` first), then step 2; record the cost of each, and re-price the chain
   after the first two leaves in your record.
3. **The rest in the work order**, saving after each leaf; before `endpoint_of_far_end`, read FS110-CD Lemma E/R and FS110-CE R1–R4 (`plans/FS110-derivation.md`
   and the records it names) and record whether a two-colour exit returns within 60° of `r(θ)`; if it does not, stop that leaf and message me. No statement
   changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
4. **For the coordinator**: measure F-RING and T-GRAPH from their first children and say in your report whether each deserves its own job, and what a second
   implementer could take beside you without sharing a file.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge into `fs131-w5`, run
   the gate, or touch `main`. Stopping at a saved stage with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the work order's dependencies, and where a shared child lives (`PlaneTopology` or `MapTopology`). If a leaf cannot
be proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on
with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) under a small slot is for iteration only, never
evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.
