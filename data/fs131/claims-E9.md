# FS131-E9 — the claim list: integer curvature along a general chart, finitely many pieces of each radius, and arc interfaces

*Fixed by Keryx, 2026-10-07 (UTC), before the job launches. Every statement below is copied by script from its source, first line as the
address; read each whole at its address. Branch tips at this writing: `origin/fs131-w6l` `b5b8f4be`, `origin/fs131-w6`
`2aa3f720`, `origin/fs131-w6k` `2a8ed9eb`, `origin/fs131-w6z` `94a98a58`, `origin/fs131-w9` `50c0edc5`. A later change to this file
is a dated line at its end.*

## The filed entries

> derivation: FS111-M2-INTRAD
> — source: plans/FS111-derivation.md

>   statement: in an honest saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point (REG-J′), the unit
> — source: plans/FS111-derivation.md

>   uses only: FS111-M-C11 off Σ; (i) the near side of the parallel has density 0 for the partner colour (M2 from I-D1 and (H2); VM2 from M-HULL1);
> — source: plans/FS111-derivation.md

>   not claimed: exclusion of large-radius accumulation (radii → ∞: LRA, FS-115's stuck ray); the statement without REG-J′'s finitely-many-arcs clause
> — source: plans/FS111-derivation.md


> derivation: FS111-M-REDUCE-I
> — source: plans/FS111-derivation.md

>   statement: REG-I_k follows from the honest existence form of C-SAT-T at k together with REG-J′_k (a saturated colouring whose singular set Σ is locally
> — source: plans/FS111-derivation.md

>   not claimed: honest C-SAT-T at five; REG-J′₅; the statement without the finitely-many-arcs clause (the owner's brief dropped it; VMW's blind stage 1
> — source: plans/FS111-derivation.md


## E9-Q1 — integer curvature along a general chart

The Lean leaf (open), and the case that is proved (a circular arc):

> theorem curvature_integer_ae (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {a b : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem radius_integer (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {w : ℂ} {r : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean


**Q1.** For a unit-speed curve with 1-Lipschitz tangent angle in the interface of a saturated colouring whose singular set is locally
finite, of tangent type along its length: is its radius of curvature an integer at almost every parameter — by an argument that does
not presuppose the curve piecewise circular? Verdict: derived (a derivation whose every step an implementer can formalize, each step at
its grade), refuted (a saturated colouring exhibited exactly), or not derived, with the step where it stalls.

*Not claimed*: that the curve is piecewise circular; anything about how many pieces there are (that is Q2); anything without the
singular set locally finite.

## E9-Q2 — finitely many pieces of each radius

The Lean leaf (open), the theorem its filed argument passes through (proved, in a module downstream of the leaf's), and the theorem that
has since removed two of its readers:

> theorem finite_pieces_of_radius (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem ends_centre (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {α β : ℝ} (hαβ : α < β) {a b : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem no_arc_of_cocompact (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean


**Q2.** (a) Is there an argument for clause (iii) of FS111-M2-INTRAD — finitely many interface pieces of each radius near a point — that
does not pass through the finiteness of the terminal centres (FS121-O1-ENDS, the Lean `ends_centre`)? If not, say so: the leaf then
belongs after that theorem's module. (b) Which filed results still read clause (iii), now that under a cocompact symmetry no arc of
radius other than 1 lies in the interface's closure at all (`no_arc_of_cocompact`)? Verdict per part, as for Q1.

*Not claimed*: exclusion of large-radius accumulation; anything without REG-J′'s finitely-many-arcs clause.

## E9-Q3 — arc interfaces from saturation and a locally finite singular set

The named open statement (proved nowhere; a hypothesis where used), the theorem that takes it, and the two statements at the join of
waves 6 and 9:

> def HasArcInterfaces (c : AeColouring k) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/ReduceI.lean

> def ArcInterfacesOfRegJ (k : ℕ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/ReduceI.lean

> theorem reduce_i_of_arcInterfaces (hJ : ArcInterfacesOfRegJ k)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/ReduceI.lean

> theorem exists_arcMap_of_hasArcInterfaces (c : AeColouring k) (h : c.HasArcInterfaces) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6/Proofs/HadwigerNelson/Plane/Saturated/ReduceI.lean

> theorem exists_arcMap_of_arcBounded {C : Fin k → Set ℂ} {𝒜 : Set Arc} (h𝒜 : IsArcSystem 𝒜) (hfr : ArcBounded 𝒜 C)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean


**Q3.** Does a saturated colouring with locally finite singular set have interfaces that are locally finitely many segments and
circular arcs (`ArcInterfacesOfRegJ k`)? Answer ingredient by ingredient: what follows from held entries (FS111-M2-INTRAD (i) and (iii),
at the verdicts of Q1 and Q2), and what stays open — the filed entry names large-radius accumulation as not claimed; the kernel's
planner adds locally finitely many straight pieces. The verdict wanted is the exact residue: the weakest named open statement or
statements that, with the held entries, give `ArcInterfacesOfRegJ k` — or a derivation of it, or a colouring that refutes it.

*Not claimed*: REG-J′ for any colouring; honest C-SAT-T at any `k`; any value of a chromatic number.
