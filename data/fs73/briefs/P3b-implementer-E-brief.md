# Brief — implementer E, FS-73 post-competition item: decide ℚ(√167)'s last surviving lattice exactly

You are **de Bruijn**, the Lean/tools engineer of `/home/kooshi/source/lean-dir`, working as an **implementer** on one bounded item.
I'm the product owner, the coordinating session. Kooshi, the human whose project this is, asked me to coordinate FS-73 rather than
do its mathematics. **Read `CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` from disk first.** Any copy loaded into your context predates
this session's edits, so the disk is authoritative.

## Why this item exists

FS-59 is the project's top-ranked open stub: **does the plane over ℚ(√167) need four colours?** Kooshi's local–global conjecture
predicts at least six; only three is proven. FS-61 built 57 lattices over ℚ(√167), and FS-73's P2b screen gave 55 of them periodic
3-colourings (`data/fs73/records/phase-P2b-q167.md`). Two survived. FS-73's competition then produced a theorem that turns
three-colourability of a lattice graph into an exact finite question:

- **H-i / T0** (`plans/FS73-C3-Coxeter.md` §3, `plans/FS73-C3-deBruijn.md` §2 C1; proved independently by both, checked by the
  owner). For Λ a finitely generated torsion-free abelian group and S = −S ⊂ Λ finite and generating, `Cay(Λ, S)` is
  3-colourable ⟺ there is θ ∈ Hom(Λ, ℝ) with θ(s) mod 1 ∈ [1/3, 2/3] for every s ∈ S. Such a θ gives the periodic colouring
  ⌊3{θ(x)}⌋, and a rational one always exists if any does.
- **One survivor is decided.** `Ld14c588b` (key `348|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`, 44 unit vectors) is 3-colourable with
  period index 1,080. The owner verified the functional in `data/fs73/q167/coxeter-Ld14c588b-linear-3colouring.json`.
- **Yours is the last one:** `L21cc6506`, key `420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`, 60 unit vectors.
  - Coxeter's float first-cell search explored 528,876 nodes in 880 s without finishing.
  - His hand-over note (`plans/FS73-C3-Coxeter.md` C-4) names the lever: a better frame. The LLL basis leaves unit coefficients
    up to about 400, so try a unimodular change minimising Σ‖u‖₁, or branch on the tightest u first.
  - A second exact handle from the theorem, for you to use or not: every nonempty cell of Θ is a bounded rational polytope. So it
    has a vertex where four independent constraints θ·uᵢ ∈ kᵢ/3 are tight, and its denominator divides 3·det(u₁..u₄).

**Both outcomes matter:**
- **Θ nonempty:** an explicit periodic 3-colouring. Then all 57 of FS-61's lattices at 167 are 3-colourable, and FS-59's lattice
  route there is closed; that is a clean negative.
- **Θ empty:** L21cc6506's graph is not 3-colourable. Since that graph is a subgraph of the plane's unit-distance graph, this proves
  **χ(ℚ(√167)²) ≥ 4**, FS-59's target and a new field value. A claim of that size is held to the full standard of evidence
  (`CLAUDE.md` § The standard of evidence above rung B). **Tell me the moment you have it, before anything else,** and I'll arrange
  an independent verification.

## The work, in order

1. **Register your prediction** in your record before any computation: empty or nonempty, with a confidence and the reason. Say
   whether both outcomes are reachable by your method (G21, and the "state the uninformative outcome" rule in § The gate).
2. **Controls first, both directions.** They test the pipeline, not the lattice.
   - Re-run `python3 data/fs73/coxeter-c3/certcheck.py data/fs73/coxeter-c3/cert_47.json`. It should report CERTIFICATE OK, EMPTY.
   - Build an **exact emptiness certificate** for FS-61's `Ld65c8ee8` over d = 11 (`30|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`,
     108 unit vectors). It is known not 3-colourable: FS-61's solver refused it (`data/fs61/shapes.md` line 24, `11:REF/108`), so Θ must be empty. Coxeter's d = 11 run was float-pruned, so this
     control has never been certified exactly.
   - Show that the same shape over d = 59 gives a point (Θ nonempty, known 3-colourable), and that your method finds Ld14c588b's
     point, or another one.
3. **Price L21cc6506 on a short sample** before the full run: nodes per second and the tree's growth.
4. **Decide it.**
   - A point: write it as an exact rational functional, like Coxeter's JSON, and check ψ(U) ⊆ [1/3, 2/3] in Fractions against an
     independent enumeration of U.
   - Emptiness: an exact certificate that `data/fs73/coxeter-c3/certcheck.py` accepts as it stands, or a checker of your own with
     the same contract (Fraction arithmetic only, re-enumerating U from the key). Also confirm it by a second, independent route,
     such as a different frame, a different branching order, or the vertex enumeration above.

## Rules, each with its reason

- **Exact arithmetic for every verdict.** Floats may propose; only Fractions decide, because a float-pruned branch is no certificate.
- **Checkpoint and resume anything expected to run over ~15 minutes** (`CLAUDE.md`'s protected checkpointing paragraph): tree
  state on disk at natural points, and the resume command written in your record. Coxeter's tools don't checkpoint, so build a
  resumable version before any long run.
- **Budget and stop rule:** at most about 4 CPU-hours in total and 8 GB. At the cap, persist and report "undecided at the cap"
  with the price of finishing. That is a complete report.
- **Heavy-job lock** for anything over ~2 minutes or ~8 GB:
  `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`.
  Another implementer (F, on phase P4) shares the machine. Kill by pid and verify by effect, never with `pkill -f`. `CLAUDE.md` has
  eight instances of that going wrong, and Coxeter added a ninth today.
- **Don't edit `data/fs73/coxeter-c3/`,** because the certificate checker there is a committed artifact. New tools go in
  `tools/fs73_theta_*.py`, and data in `data/fs73/q167/`.
- **Your record** is `data/fs73/records/phase-P3b-q167-theta.md`. It holds your prediction, the controls, the price, the verdict,
  and a heading "Theorems this phase proved" (WORKFLOW step 7). **Commit by explicit path; never push, never amend;** check every
  hash you report against `git log`.
- **Your scratch directory** is `…/scratchpad/fs73-implE/`.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation). Staffing is
  Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a clean boundary,
  persist, and tell me what's left.
- **Never run `lake build`;** use `./scripts/build.sh`. You shouldn't need Lean for this item.
- **Reaching me:** `SendMessage` with `to: "main"`, at any time: for the price, for a surprise, and at once for an empty Θ.
- **Budget:** about 250k tokens.

**What is yours to decide:** the method, the frame, the branching order, and whether my suggested second handle is any good. If
the item is subtly mis-posed, say so.
