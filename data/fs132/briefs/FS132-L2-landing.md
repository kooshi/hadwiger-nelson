# Brief FS132-L2 — the landing: the first night's exclusion, with the outside lemmas ported under it, through the full gate and onto `main`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-L2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the landing implementer of this milestone's first theorem — take a branch on which four colleagues' work compiles together, cut from it the two modules that are still skeletons, join it with `main`, finish its registrations, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page sentences for the filing
  launch: now, in a tree of your own cut from the branch's tip; a deriver works under `plans/` and `data/` on `main` and a planner of another milestone on a branch of its own — neither writes a file you write; no other landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage mid-job, **at once**, for: a gap between one of the four theorems below and the sentence it is read aloud against; a declaration that prints an axiom other than the ones its record files; the vacuity scan reading a new site as vacuous or unknown, or the assumptions step having no class for a condition these modules introduce; a merge conflict in a Lean file; a gate step red for a reason you cannot repair within your touches; or a question you cannot work around. **And one line when the gate is green on the commit you will push, before you push.** The report goes to `data/fs132/reports/FS132-L2.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS132-L2-landing.md` (new, on branch `fs132-wl2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2` (branch `fs132-wl2`, cut from branch `fs132-wi4` at `7e4e5d2a`; its `.lake/build` is its own copy, made today): the merge of `main`; the removal of the two skeleton modules with their lines; under `Proofs/HadwigerNelson/`: docstrings and module headers of the landing's modules, and the generated outside modules **through their generator only**; a copy of the release's licence text beside the ported modules; `Proofs.lean`, `ARCHITECTURE.md`; `scripts/Axioms.lean` (blocks for every declaration the landing brings), `scripts/Assumptions.lean` and `scripts/assumptions-ledger.txt` (the second by `--write-ledger` only), `scripts/axioms-controls.txt` only if a control's expected count moves with your state, `scripts/vacuity-baseline.txt` (its header's count lines only, after the scan's final run; an entry is a message to me); the port's tools under `tools/` where a re-run needs them; `plans/FS132-L2-landing.md`, `tools/fs132_l2_*.py`, `data/fs132/l2/`, `data/fs132/reports/FS132-L2.md`; `main` by the one fast-forward push this brief names; **not** the statement of any theorem or definition (a statement that must change is a message), the import module's two axioms, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `tools/claude_md_fact_audit.py`, the derivation files (drafts for those go in your record), the outside clone at `/home/kooshi/source/math` and the audit's working copy under `/home/kooshi/.cache/ext-oai1` (read; write nothing there)
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k — you cannot read that count, so use this: **save a stage after each numbered item below, and if you have made three full gate runs without a green one, stop at a saved stage and hand back**

Hello. Last night a deriver of this project wrote, by hand, a proof that in a measurable six-colouring of the plane a point
where four colour classes meet in a cycle cannot have the unit circle about it show the two remaining colours in a certain
pattern. Today, within about fourteen hours, a planner stated that proof as forty-nine leaves, an implementer ported the three
outside lemmas it rests on with their proofs, and two more implementers proved every leaf. On the branch you stand on, the
theorem's axiom print reads the standard three. It has never been through the gate. You take it there, and onto `main`.

## Why this job

A result of this project is "held" only when its module passes the gate with its imports named — until then the ledger's
row for this theorem says "by hand, one mind". The gate is what stands between a proof that compiles and a statement a
reader who trusts none of us may rely on: that the theorem says what the row says, that no hypothesis is empty by accident,
that everything it assumes is declared, that nothing rests on a `sorry` or an axiom nobody filed. Kooshi put this theorem
first this morning, and asked that what it rests on be formalized with it; his words:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

How the branch came to be, and what its authors left for you (read each item whole in `plans/FS132-close-inventory.md`):

> 40. **FS132-I2 done (463k and 64 minutes by the task notice): the port is in — the three outside lemmas the exclusion and
> — source: plans/FS132-close-inventory.md § Items

> 44. **FS132-I3 done (375k and 56 minutes by the task notice): the step lemma's module and the shift's are proved — two of the
> — source: plans/FS132-close-inventory.md § Items

> 46. **FS132-I4, third message (14:14 UTC): the last leaf is in — the first night's exclusion, in its four-point form at the
> — source: plans/FS132-close-inventory.md § Items

> 47. **FS132-I4 done (590k and 90 minutes by the task notice): the exclusion is whole on its branch — every step of the hand
> — source: plans/FS132-close-inventory.md § Items

## The statements

**No statement changes in this job.** The four theorems the landing is for, in your worktree (`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/Proofs/HadwigerNelson/Plane/SixRing/Orbit.lean` and
`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/Proofs/HadwigerNelson/Plane/SixRing/TwoPairs.lean`; read each whole, with its docstring and the definitions it names):

> theorem no_outside_orbit_points {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/Proofs/HadwigerNelson/Plane/SixRing/Orbit.lean

> theorem no_outside_orbit {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/Proofs/HadwigerNelson/Plane/SixRing/Orbit.lean

> theorem not_ae_outside {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/Proofs/HadwigerNelson/Plane/SixRing/Orbit.lean

> theorem no_alternating_pairs {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) (p : ℂ)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/Proofs/HadwigerNelson/Plane/SixRing/TwoPairs.lean

**The row they are read aloud against**, as filed this morning ([hand], one mind, with a checking reading — the grade your
landing lets the filing change, for the whole plane only):

> | 155 | **The (Q)-free exclusion with no map and no Siamese clause: for every measurable six-colouring proper at almost every unit pair on an open set containing the closed unit disc about a point, if four labels meet at the point in a witnessed cycle, the palettes on its unit circle cannot almost everywhere hold one of the two other labels.** The orbit form, over four points: "let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let q_j be a point other than p with H_{a_j} ∩ Δ({p, q_j}) = ∅ and H_{a_{j+1}} ∩ Δ({p, q_j}) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure" (C132-WIT-ORBIT; C132-M-ORBIT is the same theorem over four compact sets through `p`). The ring form: "let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the points q_0, q_1, q_2, q_3 be as in C132-WIT-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y" (C132-WIT-EXCL, which is C132-M-EXCL); at an extracted centre with a cycle of four labels, C132-M-EMPTY. **[hand], one mind, with a line-by-line checking reading of its steps M4–M9 by a second mind — the kernel lane's planner, whose own blind route reached the state, the chart, a forced label at each hub, the unit-pair relation and the kill for a clean change, and stopped at the step lemma; steps M6 and M8 have one derivation each; kernel pending (the first module of FS-132's Lean phase).** **What it stands on:** for a colouring of the whole plane, two statements of `[OAIMath2026]`, kernel-checked there at every number of labels (the transfer of palettes for a pair; the 60° disjointness), and its nine steps M1–M9; on an open set, as the statement is written, also one mind's reading of those two proofs as local (M0). **Where it sits:** its hypothesis asks an outside label in almost every palette near all six orbit directions — in the map class, no (Q) arc at the orbit; every held positive escapes there (at each of the eight change points of the held fragments' four-colour vertices at least two of the four germs at ±60° lie on (Q) arcs), so nothing held is excluded. It is rows 148–149's exclusion in measure, and covers those rows' fragments given two facts about maps — a map's edge carries the two-colour exclusion (derived for connected open tiles, C132-WITNESS, row 157; the composition unwritten) and a map's palette is its ring read two-sidedly (underived; FS-134). **Not claimed:** "anything when the palettes near one of the six directions ψ + kπ/3 hold no outside label on a set of positive measure (rings with (Q) arcs at the orbit: FS-124)"; "that a six-colouring with hypothesis (a) exists"; "anything at seven labels or more (M2 and M9 spend six)"; "anything about a cycle of three, five or six labels"; "any value of χ(ℝ²)". Beside it, and not this milestone's: no ring alternates under the 60° rotation between two disjoint pairs of labels (C132-DIAG-WIDE) — for the whole plane an instance of `[OAIMath2026]`'s Lean theorem `two_state_impossible`; this milestone adds its reading on an open set, one mind. **Prior art:** partly — the palette calculus is `[OAIMath2026]` §§ 5.1–5.3; steps M1–M5 and M9 are row 148's steps restated in measure; M6, M8 and the statement are not in the release; the search in print is owed. It moves no value. | `plans/FS132-derivation.md` § 1 (C132-M-ORBIT, C132-WIT-ORBIT, C132-M-EXCL, C132-WIT-EXCL, C132-DIAG-WIDE), § 10 (C132-M-EMPTY, C132-DIAG); `plans/FS132-E3-derivation.md`, `plans/FS132-E5-derivation.md`; `plans/FS132-kernel-plan.md` on branch `fs132-wk1` | FS-132 (2026-10-07) |
> — source: LEDGER.md

and the theorem record's entries, `plans/FS132-derivation.md` § 1 (C132-M-ORBIT, C132-WIT-ORBIT, C132-M-EXCL, C132-DIAG-WIDE):
the entries are written on an open set containing the closed unit disc; **the Lean theorems are at the whole plane**, and the
paragraph "What it stands on" in that section says what differs.

**The gate's recorded state on `main`**, which your counts are reconciled against:

> as a set); the current audit reads 6533 clean and 5 declared purchases, and 18 imported (and 20 axiom-free; 6,576 records at the landing of FS-132's import, FS132-L1, 2026-10-07), each purchase listed in `ARCHITECTURE.md` § Trust; an imported record rests on a
> — source: CLAUDE.md § Trust ledger

> **What the library assumes, in both forms** (`scripts/assumptions.sh`, whose digest reads these counts and fails if
> — source: CLAUDE.md § Trust ledger

> `declarations=14845 refutations-skipped=215 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`.
> — source: CLAUDE.md § The gate

**The four records to read**, each in your worktree: the planner's (`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/plans/FS132-kernel-plan.md`, Stages 4 to 7:
the modules, the models in the basic module, each leaf's readback); the port's (`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/plans/FS132-I2-implementation.md`: the cone, the
generator, the read-back across the two toolchains, §§ 3.4–3.5, its drafts D1 to D7); the two implementers'
(`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/plans/FS132-I3-implementation.md`, `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wl2/plans/FS132-I4-implementation.md`: what each proved, the hypotheses dropped, their drafts). And on
`main`: the last landing's record, `plans/FS132-L1-landing.md`, for the gate's procedure step by step, with its receipts
under `data/fs132/l1/gate/`.

## Done means

1. **Your readback first**: check every quotation above against its source; read the four records and the last landing's
   record; `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main`. Build the branch once as given
   (it should print 19 `sorry` warnings, all in two modules). Open your record. Commit and push.
2. **The cut.** Remove the two skeleton modules — the index lemmas' and the centres' — with their lines in `Proofs.lean` and
   their rows in `ARCHITECTURE.md`; they stay on the planner's branch for their own jobs. Confirm no module imports them
   (I found only the root file) and that `Proofs/` then holds **zero `sorry`**, by a search that would see one (plant one,
   watch it fire, remove it). Build.
3. **`main` merged in** (at `045d3d71` when this was written). Trial it first and name the conflicts before you make it: I
   expect none in a Lean file — `main` has moved only in plans, data and the front files since the branches were cut. A
   conflict in a Lean file under `Proofs/` is a message to me. Build.
4. **The port's three loose ends.** (a) A byte-identical copy of the release's licence text (`/home/kooshi/source/math/LICENSE`)
   beside the ported modules, under a name that says whose it is, and each generated header naming it — through the
   generator. (b) The three instances on Mathlib types in the palette module (the port's record § 3.5): make them scoped
   through the generator if every module still builds; if one cannot be, keep it and say in the header why it is safe; say
   which in your record. (c) Re-run both stored-term comparisons on the joined tree — the import's
   (`tools/fs132_i1_readback.py`: the two axioms and the copied definitions, identical to the release's) and the port's
   (`tools/fs132_i2_readback.py compare`, as its record's § 3.3 runs it) — with their planted faults still firing. Any
   change of verdict: message me before repairing it.
5. **The registrations.** Every declaration the landing brings is in a block of `scripts/Axioms.lean` (three groups are in
   none: the planner's basic and confinement modules and one lemma of the palettes' module; the palette module's own
   declarations), each filed on what it rests on — nothing here should rest on either declared outside theorem, and the
   wrong-filing control must still fire. The six architecture rows and the one module docstring that still name the
   planner's branch or say "sorry until implemented" (the last implementer's draft D7) are corrected. The two modules that
   state one identity under two names: leave both unless one edit to an import removes one with no cycle; say what you did.
6. **What the library assumes.** These modules introduce conditions on parameters that no theorem concludes — the orbit's
   hypothesis, the hub's colours, the relation with no double change, the four-cycle's straddle condition, a tip, the
   shift's bounds, a density point. Read `LEAN.md` § Assumptions and the assumptions script for how such a condition is
   declared (a hypothesis standing for an outside theorem, for a hand result of ours, or for an open question is one thing;
   a condition with a model in the same module is another); run `./scripts/assumptions.sh --self-test`, then
   `./scripts/assumptions.sh`, read every failure before `--write-ledger`, and list every row the ledger gains. If the
   scheme has no class for one of them, message me with the script's line.
7. **The vacuity step**, with care — this is a theorem that concludes `False`. `scripts/vacuity.sh` and its `--self-test`;
   say how the scan classes every new site, and in particular how it treats the four theorems (a refutation's hypotheses
   are meant to be jointly unsatisfiable; what the gate asks is that each *structure* of hypotheses has an inhabitant short
   of the conclusion — the planner's basic module holds the models: name the model for each). A site read as vacuous or
   unknown is a message to me with the scan's line.
8. **Read aloud.** In your record, each of the four theorems against the row's sentence and the entry's statement, clause by
   clause — the colouring's class, the four labels and the two others, the points and their straddle sets, the two clauses
   on the ring, the conclusion — and what the Lean statement does **not** say that the row does (the open-set form), in
   words the filing can use.
9. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`; the
   doubled-name check after the build and before the axiom audit (`./scripts/dupnames.sh` under the slot with `--mem 16`,
   then its `--self-test`); `scripts/axioms.sh` clean with `--self-test` green — still three declared outside axioms, every
   new record clean; `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line above;
   `./scripts/assumptions.sh` and its `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint,
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`, silent; the notes check and the records
   check as the last landing ran them. Take the three digests against the previous landing's receipts
   (`data/fs132/l1/gate/receipt-axioms-final.log`, `data/fs132/l1/gate/receipt-vacuity-final.log`,
   `data/fs132/l1/gate/receipt-assumptions-final.log`). Save every step's log under `data/fs132/l2/` and name them.
   **Message me one line when it is green, before you push.**
10. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`,
    `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise re-run
    the gate on the merged commit. Name the merged commit by its hash in every check, never by a ref. Then
    `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch, merge
    and try again.
11. **Drafts for the filing**, in your record under "Drafts for the front page (FS132-L2)", each with the log line it comes
    from and **the exact words on `main` it replaces**: `CLAUDE.md` § Trust ledger (the audit's sentence with the joined
    tree's counts; the assumption counts) and § The gate's two count lines; a `GATE_CHANGES` entry; the Frontier's sentence
    on this milestone's Lean phase; `LEDGER.md` row 155 — its grade sentence for the whole plane, with what stays by hand
    (the open-set form) and the names and addresses of the four theorems; the dated lines for the theorem record (the three
    implementers' drafts, reconciled into one); `LEAN.md` (the port's draft for § Assumptions on porting an outside Lean
    proof; the last implementer's three bullets); `BIBLIOGRAPHY.md` (the port's draft for the release's row); the atlas
    grade for the exclusion's node. And **the open gate items at this landing**, by name, if any.
12. **Your record**, stages headed "Stage n — SAVED (FS132-L2)"; the report in standing rule 11's form, the counts read from
    the gate's saved logs. Leave no background process running. **Stopping at a saved stage with the gate red at a named
    check is a good report** — say which check, its log, and what you would try next.

## What is yours to decide

The order of the registrations; how the instances are scoped; the wording of docstrings and rows; how each gate step's
finding is repaired within your touches. Not yours: any statement — if the gate shows a theorem says less or other than its
row, that is the most valuable message this job can send, and nothing is repaired around it. Three failed attempts on one
route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
