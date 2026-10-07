# Brief FS136-I1 — a corner reaches its point, a corner's side is read from its two edges, and a band is forced along an arc: twenty-seven leaves of a planner's skeleton, on `fs136-wk1`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS136-I1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the implementer of the kernel module of the milestone derived this evening — replace every `sorry` in four files of a planner's skeleton with a proof, changing no statement; print the axioms; draft what a landing will need
  launch: now, in the planner's own worktree — the planner has handed back and nobody else writes there; a landing of the module your branch is cut from is in flight on `main` (another worktree), and a deriver works under `plans/` and `data/` on `main` — you touch neither
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); **with one line when the forward step's and the collar's theorems print their axioms**; and for a question you cannot work around. The report goes to `data/fs136/reports/FS136-I1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS136-I1-implementation.md` (new, on branch `fs136-wk1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1` (branch `fs136-wk1`, at `b0ca8f84`; its `.lake/build` is its own, built by the planner an hour ago): `Proofs/HadwigerNelson/Plane/PieceTable.lean`, `Proofs/HadwigerNelson/Plane/CornerClass.lean`, `Proofs/HadwigerNelson/Plane/CutCorner.lean`, `Proofs/HadwigerNelson/Plane/Collar.lean` (proofs only; helpers under names no other module declares — **search `Proofs/` by name before you state one**: the planner's first build failed on a name the library already held); `plans/FS136-I1-implementation.md`, `data/fs136/i1/`, `data/fs136/reports/FS136-I1.md`; **not** any statement or definition; **not** the modules below these four (one leaf there is another job's, in a landing now in flight: it stays as it is on your branch); not `scripts/Axioms.lean`, `scripts/Assumptions.lean` (you draft your audit block as a file under `data/fs136/i1/`), `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **a saved stage after each of the planner's five groups of leaves; re-price each of the three long leaves from its first child and say the price in your record; a leaf on which three attempts fail stays `sorry` with a note, and you go on; if three leaves are so left, stop at the next saved stage and hand back**

Hello. This evening a milestone of this project was derived by hand: what the regions at the points one unit from a point
leave possible near it, in a measurable six-colouring proper at almost every unit pair — and, run the other way, that where
they leave one colour, that colour must be there, down to a band forced along an arc of a unit circle. A planner stated
seven statements of it in Lean without seeing the derivations, proved four of them outright, reduced two more to one leaf
each of plane geometry, and left a route for every remaining leaf. Twenty-seven are left. They are yours.

## Why this job

Two of these statements are the first this project holds that put a region of one colour where nobody assumed one, and the
milestone opened after this one cites them in its first claims. They are held by hand, one mind each; a second mind has
read them and found no error; the kernel is the check that counts. A leaf proved by changing what it says would be worse
than a leaf left open. Kooshi's word of this morning, and what he has said of formalizing:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

How the skeleton came to be, and what its planner found on the way (read each item whole):

> 22. **FS136-K1: its phase-1 plan is committed — `e62ebbbb` on branch `fs136-wk1`, 20:14 UTC, which dates its blindness — and the fence is lifted by my reply** (20:15 UTC). **"PROVED in the build, on the standard three axioms: C136-TABLE (`piece_table`), C136-COVER (`cover_separates`), C136-ONE (`one_point_six`), and the label half of C136-FORCED (`ae_eq_of_forced`: almost every point near w on the stated side of every circle has the label ℓ)"** — each for any function proper at almost every unit pair and any label type, "the number of labels is read only in a cover hypothesis". The forward step's first sentence "is proved in a scratch file from ONE leaf of plane geometry: for small ρ every connected component of `B(w, ρ)` less the circles has `w` in its closure", its route by inversion at the point. "Typed with routes, not proved": C136-CLASS (agreeing with the fibrewise truth on 6,888 sampled corners), C136-COLLAR ("for pieces of any shape; the corner form is the corollary"), the rest of C136-CORNERS. **"No statement defect found."** Four modules, 43 leaves left; build exit 0. **Four more findings of its own** (beyond item 19's): (5) the forward step's second sentence on the open set of points on the stated sides of the other circles — "every point of `S(x_i)` near `w` on those sides is the far end of a tight pair for (ℓ, ℓ′)"; (6) the collar "for `A` any connected subset of `S(x) ∩ U` — 'open' and 'arc' are not used"; (7) in the lemma on corners, "for every `0 < ρ ≤ ρ₀`" is load-bearing; (8) **"two round discs at `p`, tangent to `S(w)` at `p` from inside and from outside, with labels that are all the labels, are NOT a model … Purity at `w` is necessary for a label to be present on a side, not sufficient."** **What it judges should wait**: the count of `2m` corners and "the sides name the corner except for two tangent circles" — "neither is read by any of the seven" (agreed: out of this module). **Disclosed**: five commit subjects shown at launch, two of this milestone's fenced lanes. **Its slip, repaired before the commit**: a name already in the library — which was the helper it needed. **My receipt**: the commit and its time read on `origin`; the four new modules listed (1,057 lines); the four theorems' lines found in the first of them, which holds one `sorry`. Not checked by me: the axiom print; any statement against the claim list. **What this is**: the table, the two counts and the forward step's label half are **kernel-checked on a branch by routes found blind** — the second look those four were owed, in the workflow's sense; the hand entries stay "one mind, kernel pending" on the front page until a module lands. **Sent with the fence's lift**: the theorem record's sections and the two records' stages; **the three statements its deriver said have no second derivation — the forward step, the order in C136-CLASS, the collar — named now, a paragraph each asked as its first act**; the asking lane's two notes (item 21). **Routed at once**: findings 5–8 to the deriver running on FS-137, with my own reading of (8) labelled unchecked — a palette is an upper bound on what a side carries, so a count of palettes cannot by itself say a label is there.
> — source: plans/FS136-close-inventory.md § Items

> 24. **FS136-K1 done (20:41 UTC logged; hand-back 20:39 UTC; 500k by the harness's count — not resumed): the plan per leaf is final — 27 leaves left for an implementer — and four of the seven statements are kernel-checked on its branch** (branch `fs136-wk1`, tip `b0ca8f84`; record `plans/FS136-kernel-plan.md` there, Stages 1–5; report `data/fs136/reports/FS136-K1.md` there). **By statement, in its words**: C136-TABLE, C136-COVER, C136-ONE — "TRUE, [kernel] on the standard three … Found blind; the route is the deriver's"; **C136-FORCED** — "the label half TRUE, [kernel] …; the second sentence, restated on a larger open set, TRUE, [kernel] …; the first sentence proved from ONE leaf of plane geometry, not yet proved"; **C136-COLLAR** — "for pieces of any shape (`exists_collar`) proved from ONE leaf not yet proved (… the part of a small disc outside a unit circle through its centre is connected); in the claim's words … typed, planned"; **C136-CLASS** — "typed …, planned, not proved"; **C136-CORNERS — "NOT closed by this module"**: a corner is open, connected and on one side of each circle [kernel]; "each has `w` in its closure" is the one leaf; "the count `2m` and 'two corners on the same sides only for two tangent circles'" are deferred, typed outside the library, "read by none of the seven". "No statement defect found in any of the seven." Four modules (`PieceTable`, `CornerClass`, `CutCorner`, `Collar`); final build exit 0 with 28 `sorry` warnings (27 its leaves, one the landing's); 21 records on the standard three, six controls on `sorryAx`. **Its generalizations** are items 19 and 22's, with one more: a general lemma on unions over a connected index set, kernel-checked. **A stub it names**: a kernel job for the two deferred clauses "when a consumer asks" (about 300 lines for "a corner is named by its sides"; 600–900 for the count). **Its slips, disclosed**: the surface pass not run; the module below read at its statements, not every proof; a sampling check of its own that first reported 277 false disagreements, repaired. **My receipt**: the tip read on `origin`, the worktree clean; the four modules' placeholders counted by me (1, 15, 6, 5 — 27); the headline statements found at their lines. Not checked by me: the axiom print; the plan per leaf. **Filed from its record** (§ 4.2, by script): a dated block of corrections under the second round's entries in `plans/FS136-E2-derivation.md` — what each of the three arguments leaves implicit, "all three stand as written". **Rulings.** (a) **An implementer takes its skeleton now** (FS136-I1, launched on this hand-back): 27 leaves, about 1,050 lines by its estimate, in its worktree. Weighed: waiting until FS-124's second module has landed, since this branch is cut from that module's branch — the implementer writes four new files only, and its branch merges `main` at its own landing. Confidence: high. (b) **C136-CORNERS is closed only as far as the seven read it**; the two deferred clauses are a kernel job with no consumer, not briefed. If this milestone's close is judged on the claim in full, that job is the price; said in the open-milestones paragraph at the next filing. (c) Its two drafts for `LEAN.md` are filed with this module's landing.
> — source: plans/FS136-close-inventory.md § Items

## The statements

**The kernel claim list**, `data/fs136/claims-K1.md` (read it whole): the four whose leaves are yours —

> **C136-CORNERS** — statement: Let w be a point and x_1, …, x_m (m ≥ 1) distinct points with |x_i − w| = 1. There is ρ₀ > 0 such that for every 0 < ρ ≤ ρ₀ the disc B(w, ρ) less w and the circles S(x_i) is the disjoint union of 2m connected open sets, each with w in its closure and each lying inside or outside each S(x_i) — the sets Σ_ρ of the 2m corners at w cut by those circles; and two of them lie on the same side of every S(x_i) exactly when m = 2, x_1 + x_2 = 2w, and they are the two outside both circles.
> — source: data/fs136/claims-K1.md

> **C136-CLASS** — statement: Let Σ = (x; γ₁, γ₂) be a corner and w a point with |w − x| = 1. Order the curves from x that are rays or circular arcs cyclically, counter-clockwise by direction at x and, for one direction, by signed curvature (positive when the centre is to the left). Let β₋, β₊ be the two branches of S(w) at x, β₋ the one whose counter-clockwise neighbours are inside S(w). Then Σ is inner at w exactly when β₋ ≤ γ₁ < γ₂ ≤ β₊ in that order counted from β₋, and outer at w exactly when β₊ ≤ γ₁ < γ₂ ≤ β₋ counted from β₊.
> — source: data/fs136/claims-K1.md

> **C136-FORCED** — statement: About weak colourings that have the named pieces; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, w a point of U, x_1, …, x_m (m ≥ 1) distinct points with |x_i − w| = 1, 𝒫_i a family of pieces at x_i, Σ one of the corners at w cut by S(x_1), …, S(x_m), and ℓ a label such that every label other than ℓ is a label of some 𝒫_i that is not inner-pure at w for 𝒫_i if Σ is inside S(x_i), and not outer-pure at w for 𝒫_i if Σ is outside S(x_i). Then there is η > 0 such that Σ_η is a connected open subset of U with w in its closure and almost every point of Σ_η has the label ℓ: c has the labelled corner (w, Σ, ℓ). If two such corners, with labels ℓ ≠ ℓ′, are adjacent along a branch β of some S(x_i), then for some η > 0 the set Σ_η ∪ Σ′_η ∪ (β ∩ B(w, η)) is open, almost every point of it on one side of S(x_i) has the label ℓ, and almost every point of it on the other side the label ℓ′.
> — source: data/fs136/claims-K1.md

> **C136-COLLAR** — statement: About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, whose labels are all the labels but one, ℓ, and A an open arc of S(x) lying in U such that at every point w of A each label of F has a corner in F that is not inner at w. Then there is a connected open subset V of U inside S(x), almost every point of which has the label ℓ, such that every point w of A has a radius η > 0 with every point of B(w, η) inside S(x) in V. With "outer" in place of "inner" there is such a V outside S(x), holding the points of B(w, η) outside S(x).
> — source: data/fs136/claims-K1.md

**The skeleton**, in your worktree: `Proofs/HadwigerNelson/Plane/PieceTable.lean`, `Proofs/HadwigerNelson/Plane/CornerClass.lean`, `Proofs/HadwigerNelson/Plane/CutCorner.lean`, `Proofs/HadwigerNelson/Plane/Collar.lean`. The two leaves everything waits on, and the theorems they close (first
lines; read each whole in its file, with its docstring):

> theorem exists_forall_mem_closure_cutCorner {w : ℂ} {κ : Type*} [Finite κ] {x : κ → ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/CutCorner.lean

> theorem isPreconnected_ball_diff_closedBall {x w : ℂ} (hwx : dist w x = 1) {η : ℝ} (hη : 0 < η) (hη' : η ≤ 1 / 2) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/Collar.lean

> theorem exists_collar {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x : ℂ} {ι : Type*} [Finite ι]
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/Collar.lean

> theorem collar_of_corners {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x : ℂ} {ι : Type*}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/Collar.lean

> theorem corner_innerAt_iff (x : ℂ) {θ₀ : ℝ} {γ₁ γ₂ : CurveGerm} (hγ : IsCorner γ₁ γ₂) (h₁ : θ₀ ≤ γ₁.dir)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/CornerClass.lean

**The planner's record**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/plans/FS136-kernel-plan.md` — read it whole: Stage 2 (the definitions with a model each; the seven typed and read
back; § 2.3 what the typing found), Stage 3 (§ 3.1 the routes; **§ 3.2 every leaf with its route, its names checked at
this pin, and its size**; § 3.5 the docstring edits it owes), Stage 4 (its routes beside the derivers'; § 4.2 what the
derivers' arguments leave implicit — two of those steps are leaves of yours; § 4.5 the two clauses that are deferred and
are **not** yours), Stage 5 (the price, and the order: the leaf on which a corner reaches its point first; then the outer
half-disc; the models; the order of curves; the collar in the claim list's words).

**The hand arguments**, should a route fail: `/home/kooshi/source/lean-dir/plans/FS136-E2-derivation.md` Stage 2 (the
two lemmas on corners; the forward step) and Stage 8 (the collar), with the dated corrections filed under them today.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; your four files whole and what
   they import. Build the branch once as given, under the slot (28 `declaration uses sorry` warnings — 27 yours, one the
   leaf below — and no other). Open your record. Commit and push.
2. **The leaves, in the planner's order**, each by its route unless it fails — then yours, said in your record. After
   each of its five groups: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped; anything that must change is a message.
4. **When your last leaf is in**: the axioms of every theorem of the four files printed, with a control that fires;
   **message me the lines of the forward step's and the collar's theorems**; the statement check the earlier
   implementers used (a stored-type comparison against the skeleton, with its control); your audit block as a file;
   `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`. You do not run the full gate, merge another branch,
   or touch `main`.
5. **Read aloud**, in your record: the forward step's theorems and the collar's against the claim list's words and
   *not claimed* lines, clause by clause — and for each, the kernel model of its hypotheses the planner planned.
6. **Your record**, in stages headed "Stage n — SAVED (FS136-I1)", with "Theorems this phase proved", the price as measured,
   every leaf left `sorry` by name with what was tried, and drafts for the landing. The report in standing rule 11's
   form. **Stopping at a saved stage with the two closing leaves proved and the order of curves left is a good report.**

## What is yours to decide

The route for a leaf whose planned route fails; the helpers; how you iterate. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
