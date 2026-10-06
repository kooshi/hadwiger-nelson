# Brief FS131-QA4 — impossible assumptions, third pass: every theorem landed or about to land since FS131-QA3, read against the inhabitant rule's letter

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-QA4
  identity: de Bruijn, the Lean 4 engineer — your agent file (`.claude/agents/debruijn.md`) is your identity and its standard of evidence is yours; this is an audit job, not a planning job, so the planning workflow's stages do not apply — § Done means gives this job's own
  role: find every theorem landed since the last audit, or about to land with wave 5, whose hypotheses no named Lean object satisfies all at once; attack each such hypothesis set; and hand back a priced list of what would close each gap — report plainly, with the fix and who should make it
  launch: now, beside FS131-IR1 (the procedure's last steps, on `fs131-w5c`) and FS131-I5q (wave 5's last non-`Terminal` leaves, on `fs131-w5`), neither of whose files or trees you touch
  mission: § Why this job
  statements: § What is audited
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage mid-job at once for any hypothesis set you find unsatisfiable on real instances, or any statement that says less or other than its source; the report goes to `data/fs131/reports/FS131-QA4.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate above all) and `CLAUDE.md` § The standard of evidence above rung B
  record: `plans/FS131-QA4-audit.md`
  touches: `plans/FS131-QA4-audit.md`, `data/fs131/qa4/` (your scratch Lean and exact checks live here, never in `/tmp`, which this machine wipes at power-off), `tools/fs131_qa4_*.py`, `data/fs131/reports/FS131-QA4.md`; **read-only everywhere else** — no edit to any `Proofs/` file, any worktree, or any branch but `main` for the files just named
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. This is the third pass of an audit that has twice found what nothing else could. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones. Its gate checks, by script, that no theorem quantifies over an empty type; it cannot check that a theorem's hypotheses can all
hold together on a real object. That is read by people, under a rule in `LEAN.md`. The first two passes of this audit (FS131-QA2, FS131-QA3) read every
definition then in the backlog's Lean and found two real defects, a normal form no map could satisfy and a clause of MERGE no map could meet. Both passes
were on 2026-10-04. Since then four landings have reached `main` and most of wave 5 has been written, and nobody has read the new statements against the
rule. One landed theorem says in its own docstring that it has no Lean inhabitant yet. I ruled on another from memory this morning and got the rule wrong.
So: a third pass, by a mind that reads the rule fresh.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and this item
of the gate is the one no script runs. The rule, in the two lines that carry it (read the whole bullet in `LEAN.md` § The gate):

>   inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a
> — source: LEAN.md

>   real instance and the gate stays green. **The inhabitant satisfies every hypothesis the theorem does not refute, at once, at a parameter the refutation leaves alive** — for a
> — source: LEAN.md

The findings that made it, and what the first two passes covered:

> 158. **Statement defect — definitions: `WoodallMerged` and `WoodallNormal` are unsatisfiable on every valid plane map; `exists_woodallMerged` is false at
> — source: plans/FS131-close-inventory.md

> 172. **FS131-QA2 done** (report `data/fs131/reports/FS131-QA2.md`; record `plans/FS131-QA2-audit.md`; commits `a16446fd` … `bf15a62d`, and `d1777466`, a merge of
> — source: plans/FS131-close-inventory.md

> 268. **Statement defect — `exists_merge` (FS110-W-MERGE) is unsatisfiable as stated** (FS131-QA3, by message, 2026-10-04; record `plans/FS131-QA3-audit.md`
> — source: plans/FS131-close-inventory.md

> 273. **FS131-QA3 done** (harness ≈ 255k; report `data/fs131/reports/FS131-QA3.md`, record `plans/FS131-QA3-audit.md`; commits `f0e41a11`, `efe68c61`, `a711e04c`,
> — source: plans/FS131-close-inventory.md

What prompts this pass:

> 408. **FS131-IO3 done — OPEN held** (Stage 15 SAVED at Kooshi's halt, all three of its items finished; harness ≈ 384k by the task notice; record `fs131-wop`'s
> — source: plans/FS131-close-inventory.md

> 414. **OPEN LANDED on `main`, held in the kernel: FS131-OL1 done** (harness ≈ 342k by the task notice; record `plans/FS131-IO-implementation.md`, Stages 16–20
> — source: plans/FS131-close-inventory.md

> 416. **FS131-CC2 done: the collar bend is proved** (harness ≈ 514k by the task notice; record `fs131-w5k`'s `plans/FS131-collar-C-implementation.md`,
> — source: plans/FS131-close-inventory.md

> 419. **Rulings on LN1's held items; a correction to ruling 417 (b); the slot.** (a) **The three binders are removed** (two theorems become strictly stronger,
> — source: plans/FS131-close-inventory.md

and the landed docstring that says it plainly:

> **Inhabitant** (`LEAN.md` § The gate): none in Lean yet. FS131-E6's model (`plans/FS131-E6-derivation.md` § 3.1–3.3: a valid plane map
> — source: Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

## What is audited

Two bodies of Lean, each read at a fixed commit so that running jobs do not move it under you:

- **`main`** at its head when you start (record the commit): every theorem this milestone landed after FS131-QA3's last commit `7abff9b9` — wave 4 as
  landed, Woodall's chain, MERGE (`MergeMove`, `exists_merge`), OPEN (`OpenMove`), and what else `git diff --name-only 7abff9b9 <head> -- Proofs` names.
- **Wave 5, not yet landed**: `fs131-w5` at `3b120cd3` (the planar chain, the base case's walk and density modules, the collar bend:
  `RadialPush`, `CollarMap`, `Pushforward`, `BendCollar`) and `fs131-w5c` at `87e95385` (`Terminal`, `HornShadow`, `Limit`, `Procedure`). Read them with
  `git show <commit>:<path>`. Two statements in `Procedure` are being restated today (`exists_vertexStep`, `exists_arcStep`): audit the drafts in
  `plans/FS131-E6-derivation.md` § 4.5 instead of the old forms.

Three statements are known cases (Done means 4), as they stand at those commits (read each whole there), their first lines:

> theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

> theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

The earlier passes' records say what was read then and how (`plans/FS131-QA2-audit.md`, `plans/FS131-QA3-audit.md`; tools `tools/fs131_qa1_decls.py`,
`tools/fs131_qa3_census.py`); a definition they read and that has not changed since needs no second reading, only its place in your table. For scratch
Lean, two trees are idle with green builds: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop` (`main`'s line) and
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k` (`fs131-w5` at `3b120cd3`); run `lake env lean` on a file of yours against their oleans, and
never build or write in them. The trees `fs131-w5` and `fs131-w5c` have jobs compiling in them: do not read their working files or their oleans.

## Done means

1. **Your readback first**: check every quotation above against its source; read `LEAN.md` § The gate whole, and the two earlier audits' records; open your
   record with the commits you read and what you may and may not change. Commit and push.
2. **The census, heads first**: every theorem in scope that is a backlog row's statement, or is cited from another module, or heads a construction (the
   moves, the bends, the limit, the procedure, the planar reduction, the density steps) — with its hypotheses, the inhabitant its file names (or the note
   naming a supplying theorem), and one of: *inhabited at once* (one named object satisfies every hypothesis the theorem does not refute, and exercises every
   clause); *inhabited only hypothesis by hypothesis*; *a note that none exists*; *nothing named*; *a refutation step where none is expected, and the
   docstring says so*. A construction's internal children inherit their head's line; say where you drew that boundary. Then every definition used as a
   hypothesis that is new or changed since `7abff9b9`, as the first two passes tabled them. A script makes the census, with a planted control.
3. **The attack**: for each hypothesis set not inhabited at once, try to break it — derive `False` from the hypotheses, by hand, by an exact check, or in
   scratch Lean — or build the object that satisfies them (a hand model with its clauses checked one by one counts, graded [hand]). A set you can neither
   break nor inhabit is reported as exactly that. **A hypothesis set unsatisfiable on real instances is a message to me at once**, with the smallest
   contradiction.
4. **Three known cases, each given a verdict and a remedy with its price**: `exists_open` (E6's twelve-colour map, `plans/FS131-E6-derivation.md`
   §§ 3.1–3.3 — what a Lean model of it would take); `bend_toward_collar` (the kernel shows `hmax` and `hlen` unused; without them `collarModel`'s arc
   looks like an inhabitant — check that it is, hypothesis by hypothesis); `exists_merge` and the other two moves on `main` (which named object, if any,
   satisfies each one's hypotheses together).
5. **The list of what is owed**, one line each, ranked by what rests on the theorem: the remedy (a Lean model and of which object; an unused hypothesis
   dropped; a docstring note naming the supplier that already exists), who should make it (an implementer, a deriver for a model nobody has, the planner
   for a statement), and a price. Say which of them should hold up wave 5's landing, in your judgment, and which can follow it.
6. **Your record**, stages headed "Stage n — SAVED (FS131-QA4)"; the report in standing rule 11's form. You prove nothing in `Proofs/` and change no
   statement; a model you build in scratch stays under `data/fs131/qa4/` for the remedy job. Leave no background process running. Stopping at a saved stage
   with part of the census unread, named, is a good report.

## What is yours to decide

How the census is cut, how deep each attack goes, and what the remedies are — including "this theorem should not land as stated", if that is what you
find; a no-go is a result here, and I have no stake in the list being short. If the rule itself is unclear at some case, say how you read it and why, and
flag it: the rule is mine to sharpen, not yours to stretch. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).
