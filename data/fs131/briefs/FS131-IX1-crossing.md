# Brief FS131-IX1 — the crossing lemma: `inter_nonempty_of_interleaved` in `Plane/PlaneTopology`, on its own branch `fs131-w5x`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IX1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: prove the crossing lemma `inter_nonempty_of_interleaved` under its exact statement, by a route that does not wait on the boundary graph, on branch `fs131-w5x`; measure it and save after each child
  launch: in the next slot that frees (inventory item 293 (c)), beside FS131-IP2 (the planar chain's map-level leaves, on `fs131-w5p`) and whichever of FS131-I4n, FS131-IMM1, FS131-I5d are still running, each in its own tree
  mission: § Why this job
  statements: § The statement
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job if the statement looks false, if it needs a hypothesis it lacks, or for a question you cannot work around; the report goes to `data/fs131/reports/FS131-IX1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IX1-crossing.md` (new, on branch `fs131-w5x`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5x` (branch `fs131-w5x`): `Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (the leaf and children beside it, no other statement changed), new modules of your own under `Proofs/HadwigerNelson/Plane/` or `Proofs/HadwigerNelson/Topology/` that `PlaneTopology` imports and that import nothing under `Plane/ValidMap/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-IX1", above the `=== PURCHASED ===` banner), `plans/FS131-IX1-crossing.md`, `tools/fs131_ix_*.py`, `data/fs131/ix/`, `data/fs131/reports/FS131-IX1.md`; nothing under `Proofs/HadwigerNelson/Plane/ValidMap/` (FS131-IP2's, on its own branch)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are taking one lemma of plane topology off the longest path of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; waves 1–3 are landed on `main`, wave 4 is being finished, and wave 5 (termination and density) needs seven planar leaves that rest
on plane topology Mathlib does not have. FS131-KP planned that topology; FS131-IP1 proved most of its foundation (unicoherence of the plane, from Mathlib's
lifting theorem for the covering `Complex.exp : ℂ → ℂ ∖ {0}`, and the frontier lemma), and left one leaf in `Plane/PlaneTopology` with its route open: the
crossing lemma. It is yours, in your own tree, so it runs beside the map-level leaves instead of after them. Your branch starts from `fs131-w5p` at `01011037`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 cannot
land with this open: `retArcs_not_interleaved` (wave 5's walk, `Plane/ValidMap/BaseWalk`) and F-RING (`Plane/ValidMap/MapGraph`) read it. The ruling:

> 293. **Rulings on IP1's held items, and its slot.** (a) The last exit's `hK`, `hR` → `_hK`, `_hR` **accepted** (rulings 185, 281 (a): a binder name is not part
> — source: plans/FS131-close-inventory.md

(its part (c) is this job: the route is yours, with one constraint from the schedule — route (b) needs the boundary graph BG, which FS131-IP2 builds later, so
you work a route that does not wait on it). Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statement

The leaf, with its docstring, at `01011037`:

> /-- **Two continua in a closed disc joining interleaved points of its circle meet** (the crossing lemma; `retArcs_nested`): `K` holds
> `r(s)`, `r(t)` and `K'` holds `r(s')`, `r(t')` with `s < s' < t < t' < s + 2π`. Classical (Newman's θ-curve form of Janiszewski's
> theorem). Proof planned (plan § 3.2): from unicoherence through the Phragmén–Brouwer property (in a connected, locally connected space
> unicoherence is equivalent to: if closed `A`, `B` with `A ∩ B` preconnected each leave `x`, `y` in one complementary component, so does
> `A ∪ B`), applied to `K` and `K'` each completed by the outward rays from their two circle points, which turns the crossing into "a line
> from infinity to infinity separates its two sides". **H**: the implementer measures it from its first
> child and reports; Keryx may split it into its own job. -/
> theorem inter_nonempty_of_interleaved {u : ℂ} {K K' : Set ℂ} (hK : IsClosed K) (hK' : IsClosed K') (hKc : IsPreconnected K)
>     (hK'c : IsPreconnected K') (hKd : K ⊆ closedBall u 1) (hK'd : K' ⊆ closedBall u 1) {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t)
>     (h₃ : t < t') (h₄ : t' < s + 2 * π) (hs : ringPt u s ∈ K) (ht : ringPt u t ∈ K) (hs' : ringPt u s' ∈ K')
>     (ht' : ringPt u t' ∈ K') : (K ∩ K').Nonempty := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5x/Proofs/HadwigerNelson/Plane/PlaneTopology.lean

The point on the circle it reads:

> noncomputable def ringPt (p : ℂ) (θ : ℝ) : ℂ := p + e θ
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5x/Proofs/HadwigerNelson/Plane/Basic.lean

IP1's finding on KP's planned route, and the two routes it named:

> `inter_nonempty_of_interleaved` (KP's H) is left for step 5. KP's sketch ("Phragmén–Brouwer from unicoherence … a line from infinity to
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5x/plans/FS131-planar-implementation.md 2.3 The crossing lemma — a route question, not a statement question

(the paragraph continues there: the Phragmén–Brouwer step needs a separation fact about a wild set that unicoherence alone does not give; route (a) is
no-retraction of the closed disc onto its circle, provable with the same lifting theorem, plus a Poincaré–Miranda-type construction from disjoint `K`, `K'`;
route (b) is the boundary graph). Everything IP1 proved in `Plane/PlaneTopology` is yours to use as given (its "Theorems this phase proved").

## Done means

1. **Your readback first**: check every quotation above against its source; read IP1's record §§ 2.1–2.3 and KP's plan (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5x/plans/FS131-planar-kernel-plan.md`)
   § 3.2 on this leaf; build the branch once as given (`01011037`) before editing anything; open your record with what you may and may not change. Commit and push.
2. **Grep before you build**: search Mathlib at the pin, by the statement's shape, for anything that gives the crossing or a step of it directly — a Jordan
   curve or Janiszewski-type theorem, Brouwer's fixed-point theorem or no-retraction in dimension two, Poincaré–Miranda, winding numbers or lifts of the
   argument along paths — and record each candidate with its `#check`, found or not found.
3. **The route chosen and recorded** (choice, alternative, why), then the proof, saving after each child; re-price in the record from the first two children.
   No statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
4. **The handover**: your record's last stage says what is proved and what is left, with the build log (last line, warnings other than `sorry`) and an axioms
   print against that build's oleans, including a partner that must show `sorryAx`. You do not merge into `fs131-w5p` or `fs131-w5`, run the gate, or touch
   `main`; the merge happens on my word.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage with the
   lemma unproved and the route's state named is a good report; so is a generalization found on the way.

## What is yours to decide

The route, the children, and where they live (in `PlaneTopology`, or in new modules of your own that it imports). If a route fails, record why and what
carries forward before trying another; three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. If the
statement looks false or short of a hypothesis, message me at once with the smallest counterexample or the missing hypothesis. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) under a small slot is for iteration only, never
evidence. The worktree's `.lake/build` is its own copy (from `fs131-w5p`); never replace it with a symlink. Nothing with a `sorry` reaches `main`.
