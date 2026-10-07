# Brief FS132-L1 — the import's landing: two outside theorems of `[OAIMath2026]` enter this library through the full gate, with the one question as a theorem

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-L1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the landing implementer of the import — merge `main` into the import's branch, add one two-line consequence and register it, re-run the stored-term comparison on the joined tree, write the assumptions ledger's new rows, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page sentences for the filing
  launch: now, in the import's own tree; two derivers work under `plans/` and `data/` on `main` and commit nothing else there; no other landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage mid-job, **at once**, for: a stored term of either imported statement or of a copied definition that no longer reads identical to the release's after `main` is merged (whatever the cause and however harmless — inventory item 629, ruling (a)); a merge conflict in a Lean file; a declaration that prints an axiom other than the ones its record files; a gate step red for a reason you cannot repair within your touches; the vacuity scan reading a new site as vacuous or unknown; or a question you cannot work around. The report goes to `data/fs132/reports/FS132-L1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS132-L1-landing.md` (new, on branch `fs132-wi1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1` (branch `fs132-wi1`, at `39d37838`): the merge's files; `Proofs/HadwigerNelson/Outside/OAI158.lean` — **one theorem added at its end, with its docstring, and nothing else**; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the import's block: one record more), `scripts/axioms-controls.txt` only if a control's expected count moves with your state; `scripts/assumptions-ledger.txt` (by `--write-ledger` only); `scripts/vacuity-baseline.txt` (its header's count lines only, after the scan's final run; an entry is a message to me); `plans/FS132-L1-landing.md`, `tools/fs132_l1_*.py`, `data/fs132/l1/`, `data/fs132/reports/FS132-L1.md`; `main` by the one fast-forward push this brief names; **not** either axiom's statement, any copied definition, any other statement or proof, any other module, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `tools/claude_md_fact_audit.py` (drafts for those go in your record), the outside clone at `/home/kooshi/source/math` and the audit's working copy under `/home/kooshi/.cache/ext-oai1` (read; write nothing)
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Two days ago an outside organisation published a Lean-formalized proof that the plane is not five-colourable, and with it a
transfer: a proper colouring of the plane with `k` colours exists if and only if a measurable one proper at almost every unit pair
does. This project built and audited that Lean at its own versions, and Kooshi chose to import its two theorems into this library
as declared outside theorems. A colleague wrote the import yesterday on the branch you now stand on: one module, the release's
definitions copied, the two statements as axioms compared with the release's stored terms symbol for symbol across the two
toolchains, and the bridges to this library's own vocabulary — `6 ≤ χ(ℝ²) ≤ 7`, and `χ(ℝ²) = χ_m⁰(ℝ²)` with no hypothesis. It is
built and probed on its branch, and not gated. You take it through the gate and onto `main`.

## Why this job

When this lands, the library's own interval for the plane reads six to seven, and the equality this project held only under a
hypothesis about measure rigidity is a theorem resting on one named outside statement. It is also the first time the library's
count of outside axioms rises above one, so the trust ledger's numbers and sentences all move, and every one of them is read by
whoever later asks what this project assumed. The reviews and rulings behind the job (read each item whole in
`plans/FS131-close-inventory.md`):

> 619. **EXT-OAI1 done: the outside release's Lean proof that the plane is not five-colourable stands under everything a build can show — built, axioms printed with a control, the statement equal by signature, and replayed module by module; the import is drafted as a skeleton at this repository's pin** (auditor, `debruijn`; harness 471k and 46 minutes by the task notice; record `plans/EXT-OAI1-audit.md` stages 1–8; report `data/external/reports/EXT-OAI1.md`; eight commits on `main`, the last `2015ff98`; working copy `~/.cache/ext-oai1/`, about 11 GB, kept).
> — source: plans/FS131-close-inventory.md

> 629. **FS132-I1 done at its Stage 4: the import is a module of this library on its branch — the release's two theorems as declared outside theorems, each the release's stored statement term for term; `6 ≤ χ(ℝ²) ≤ 7` and `χ(ℝ²) = χ_m⁰(ℝ²)` with no binder; built, not gated, not landed** (implementer, Opus; 416k and 40 minutes by the task notice; record on `fs132-wi1`, `plans/FS132-I1-implementation.md` Stages 1–4; report `data/fs132/reports/FS132-I1.md` there; four commits, tip `39d37838`, pushed, tree clean; module `Proofs/HadwigerNelson/Outside/OAI158.lean`, 316 lines, namespace `HadwigerNelson.Outside.OAI158`).
> — source: plans/FS131-close-inventory.md

Kooshi's word on how the release enters (`data/external/EXT-OAI1-request.md`, read whole):

> > 1. port or import: let's import and adopt parts piecemeal if needed. 2. indeed 3. definitely build on it... write the stub 4. not sure, probably allow, but audit what it does 5. pause the backlog, lets come to a stopping point, collect ourselves and have poros rerank.
> — source: data/external/EXT-OAI1-request.md

## The statements

**No statement on the branch changes in this job.** The two imports and the bridges they carry, as they stand in the module
(`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/Proofs/HadwigerNelson/Outside/OAI158.lean`; read each whole, with its docstring's four items):

> axiom no_proper_five_coloring : ¬ ∃ c : ℂ → Fin 5, ProperColoring 5 c
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/Proofs/HadwigerNelson/Outside/OAI158.lean

> axiom proper_to_borel_weak {k : ℕ} [NeZero k] {c : ℂ → Fin k} (hc : ProperColoring k c) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/Proofs/HadwigerNelson/Outside/OAI158.lean

> theorem weakColoring_iff_unitPairsNull {k : ℕ} {d : ℂ → Fin k} (hd : Measurable d) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/Proofs/HadwigerNelson/Outside/OAI158.lean

> theorem chromaticNumber_plane_six_or_seven :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/Proofs/HadwigerNelson/Outside/OAI158.lean

> theorem chromaticNumber_plane_eq_chiM0 : (unitDistance ℂ).chromaticNumber = Plane.chiM0 :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/Proofs/HadwigerNelson/Outside/OAI158.lean

**The one theorem you add** — the import's implementer checked it and left it out because no row stated it; I have ruled it in
(item 629, ruling (b)). Its file, checked by `lake env lean` on the branch and not built into the library, is
`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/data/fs132/i1/extra/seven-criterion.lean`:

> theorem seven_le_chromaticNumber_plane_iff :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/data/fs132/i1/extra/seven-criterion.lean

>     7 ≤ (unitDistance ℂ).chromaticNumber ↔ (⨆ ε > (0 : ℝ), Plane.mu 6 ε) < 1 := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/data/fs132/i1/extra/seven-criterion.lean

The sentence it is read aloud against — the front page's statement that the problem is one question, as filed today:

> 5. **So Hadwiger–Nelson is one question: can vanishing holes save the seventh colour?** `χ(ℝ²) = χ_m⁰(ℝ²) ∈ {6, 7}` (`[OAIMath2026]` Thms 1.3, 1.4), and `χ_m⁰(ℝ²) ≥ 7` iff six classes, each free of monochromatic pairs at distances in `[1−ε, 1+ε]`, cannot cover the plane up to holes of density tending to 0 as `ε → 0` (row 131; `[SokolovVoronov2025]` §9's hypothesis). A refutation needs no wild set: it is a sequence of periodic grid-square colourings, wild only in the limit, whose normal form FS-103 holds, or valid fragments on discs of every radius (row 145). Both answers decide the problem. *No* — Voronov's contradiction survives a free colour of vanishing density — gives `χ(ℝ²) = 7`. *Yes* — such a sequence with six colours — gives `χ(ℝ²) = 6`: the first move of the upper bound since 1950. At five the answer is in: the holes stay of density bounded below (`lim µ₅(ε) < 1`; row 131 with Thm 1.4).
> — source: CLAUDE.md § The aim

The gate's recorded state on `main`, which your counts are reconciled against:

> as a set); the current audit reads 6521 clean and 5 declared purchases, and 8 imported (and 20 axiom-free; 6,554 records at wave 8's first
> — source: CLAUDE.md § Trust ledger

> **What the library assumes, in both forms** (`scripts/assumptions.sh`, whose digest reads these counts and fails if
> — source: CLAUDE.md § Trust ledger

> `declarations=14807 refutations-skipped=215 sites=1446`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1403 unknown=2`.
> — source: CLAUDE.md § The gate

## Done means

1. **Your readback first**: check every quotation above against its source; read the import's record whole
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/plans/FS132-I1-implementation.md` — its stage 1's cross-pin comparison and the table of 83 constants, stage 3's probes and "At the join", its ten drafts,
   and "What was checked, and by whom"), the audit's Stage 8 (`plans/EXT-OAI1-audit.md`), `LEAN.md` § The gate, § Assumptions and § Trust ledger as
   they stand on `main`, and the last landing's record for the gate's procedure (`plans/FS131-L8A-landing.md`, stages 5–6). Build
   the branch once as given. Open your record. Commit and push.
2. **`main` merged in** (at `d1bbf25f` when this was written; the branch was cut before wave 8 of the Lean backlog landed and before
   today's front-page filing). Trial it first and name the conflicts before you make it: the import's implementer's dry run found
   `ARCHITECTURE.md` conflicting in one place, the end of § 3 — keep `main`'s rows, then the branch's § 3.12 — and `Proofs.lean`
   and `scripts/Axioms.lean` merging by themselves. A conflict in a Lean file under `Proofs/` is a message to me. Build.
3. **The comparison, again, on the joined tree.** Re-run the import's instrument on the built module
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/tools/fs132_i1_readback.py`, as its record's stage 2 ran it): the eight declarations must read identical to the release's,
   term for term, and its planted faults must still fire. Wave 8 brought modules and imports this branch never saw, and which
   instance a term elaborates with depends on the imports — that is how the one difference so far arose. Any difference: message
   me before repairing it.
4. **The one theorem added**, at the end of the module, under a docstring that says what it is (row 131's criterion read for the
   plane's chromatic number itself; on the standard three and the transfer alone) and reads it aloud against the sentence quoted
   above — term by term: is `(unitDistance ℂ).chromaticNumber` the plane's chromatic number in row 33's sense (the module's own
   bridge says how), is `⨆ ε > 0, Plane.mu 6 ε` that sentence's limit of the best six-class cover as `ε → 0`, and does `< 1` say
   "holes of density bounded below"? If the reading shows a gap between the Lean statement and the sentence, say so and leave the
   theorem out: that is a finding for the deriver's lane. Registered in the import's block of `scripts/Axioms.lean`, filed on the
   transfer alone, with the block's wrong-filing control re-run.
5. **What the library assumes, written**: `./scripts/assumptions.sh --self-test`, then `./scripts/assumptions.sh` — the import's
   record expects exactly the `unlisted-consumer` failures for the theorems that rest on the two new axioms (nine on its tree; ten
   with yours) and nothing else; read every failure before `--write-ledger`, and list every row the ledger gains or loses. No line
   of `scripts/Assumptions.lean` is expected; if the step asks for one, message me.
6. **The full gate on one commit**: `./scripts/build.sh` with zero warnings (count them); zero `sorry` in `Proofs/`; the
   doubled-name check after the build and before the axiom audit (`./scripts/dupnames.sh` under the slot with `--mem 16`, then its
   `--self-test`); `scripts/axioms.sh` clean with `--self-test` green — three declared imports, every record of the module filed on
   the one import it uses or on none; `scripts/vacuity.sh` and `--self-test` green, the counts reconciled against the line above —
   say how the scan classes every new site (the transfer's hypothesis is inhabited at seven by a model in the module; the
   five-colour statement has no hypothesis), and a site read as vacuous or unknown is a message to me with the scan's line;
   `./scripts/assumptions.sh` and its `--self-test` green; `tools/check_architecture.py` exit 0; the guarded lint,
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`, silent; the notes check and the records check as
   the last landing ran them. Take the three digests against the previous landing's receipts
   (`data/fs131/l8a/gate/receipt-axioms-final.log`, `data/fs131/l8a/gate/receipt-vacuity-final.log`,
   `data/fs131/l8a/gate/receipt-assumptions-final.log`). Save every step's log under `data/fs132/l1/` and name them.
7. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`, `.claude/`,
   `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise re-run the gate on the
   merged commit. Name the merged commit by its hash in every check, never by a ref (another job's fetch moves refs between two
   runs). Then `git push origin HEAD:main` from the worktree — a fast-forward only, never a force-push; on a rejected push, fetch,
   merge and try again.
8. **Drafts for the filing**, in your record under "Drafts for the front page (FS132-L1)", each with the log line it comes from and
   **the exact words on `main` it replaces** (the front page was refiled today: read it on `main` after your merge, not from the
   import's record, whose drafts were written against the text before wave 8's landing):
   - `CLAUDE.md` § Trust ledger — the audit's sentence with the joined tree's counts, the sentence naming the library's outside
     axioms (the import's draft 2, updated), and the nine assumption counts (its draft 3, updated); § The gate's two count lines;
     a `GATE_CHANGES` entry for `tools/claude_md_fact_audit.py` on the joined tree's counts.
   - The front-page sentences that today say the release's theorems are "not in this library": `CLAUDE.md` § The mission's row D
     and § Frontier's first paragraph under "Where the problem stands" — a replacement for each that says what the library now
     holds and on what (the declared outside theorem, by name), keeping what stays true (the classical interval
     `5 ≤ χ(ℝ²) ≤ 7` is still what the library proves with no import).
   - `LEDGER.md` rows 33 and 130: the audit's Stage 8 sentences with the import's additions (its draft 9), and for row 131 one
     sentence naming your theorem; `BIBLIOGRAPHY.md`, the release's row, its "what of ours rests on it" cell: the import's draft 9
     sentence; a dated note for the audit's record (item 629, ruling (e)); `LEAN.md`: the import's drafts 4 and 5.
   - **The open gate items at this landing**, by name, if any; and what the stored-term comparison does not cover (the import's
     record says it: Mathlib below the constants the statements name).
9. **Your record**, stages headed "Stage n — SAVED (FS132-L1)"; the report in standing rule 11's form, the counts read from the
   gate's saved logs. Leave no background process running. Stopping at a saved stage with the gate red at a named check is a good
   report — say which check, its log, and what you would try next.

## What is yours to decide

The order inside each step, how the registry files are resolved, how the scans' new sites are handled under their own procedures,
and whether the added theorem's reading-aloud holds. Do not weaken a check to pass it. If the join shows something the branch
could not — a term that elaborates differently, a name `main` now declares, a count that does not reconcile — that is a finding:
fix what is within your touches and ruled, and message me for the rest. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

## Amendment, 2026-10-07 — the coordinator's rulings on your mid-job message (the vacuity scan and the plane at five)

Thank you — this is the finding a landing exists to make: the import changes what an older statement says, and the gate
cannot see it. Standing rules unchanged; you start no agent of your own (rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists). `touches:` is extended by exactly the three items of R2 and R3 below.

**R1 — the emptiness theorem and the marker: not in this landing.** No `IsEmpty` statement from the import, no
`VACUITY DECLARED:` marker on `hexShell_plane5`, no entry removed from the baseline: its two entries and the declared count
stay as they are. Why: the scan does not look at axioms, so a marker honoured on that evidence would make "empty, by the
kernel on the standard three" and "empty, given a declared outside theorem" one count — a change in what the gate means,
which is the tooling job's to design with its controls, and Kooshi's to hear first. Alternative weighed: doing it here, since
the evidence is one line. Confidence: high. Put the question in your record under the tooling job's list (inventory ruling
475 (d)), with the sentence you sent me: the first emptiness evidence resting on a declared import.

**R2 — but the two texts inside your tree that are now false say so, in words, in this landing** (the rule of `LEAN.md`
§ The gate that wave 8 set: where the scan's marker is not the right instrument, the docstring says the vacuity in words and
names the theorem that shows it):
1. `Proofs/HadwigerNelson/Instances/HexShell.lean`, **`hexShell_plane5`'s docstring only**: one sentence added, saying that
   given the declared outside theorem `Outside.OAI158.no_proper_five_coloring` the plane has no five-colouring
   (`Outside.OAI158.not_colorable_five`), so this statement's hypothesis has no inhabitant and it says nothing beyond that
   import; that on the standard three axioms alone the scan cannot see this and holds it in its baseline; and that
   `hexShell_plane6` is the open case. No statement, no proof, no other line. Show by script that the diff touches no line
   outside that doc comment.
2. `scripts/vacuity-baseline.txt`, **its prose only**: the sentence that calls both entries the Hadwiger–Nelson problem is
   corrected for the first — empty given the import, by the same two names — and stays as it is for the second. The entries
   and the header's count lines are not touched beyond what the scan's own procedure writes.
Both edits go into the gated commit, so the gate runs on them.

**R3 — the registry comment: yes.** Add your one paragraph to the registry comment of `scripts/Vacuity.lean` — a comment
only: `ProperColoring` and `WeakColoring` OUT with the reason you gave, `Angles`, `angularMeasure`, `direction` as data, and
the plane-five fact of R2. My brief's touches omitted the scan's own registration step; that omission is mine.

**R4 — the front page's sentence is mine to file.** In your "Drafts for the front page", add the replacement for
`CLAUDE.md` § The gate's sentence "The baseline's two entries, `hexShell_plane5` and `hexShell_plane6`, cannot be discharged:
their inhabitant *is* Hadwiger–Nelson." — true of the second, and of the first what R2 says — with the exact words it
replaces.

Everything else as briefed: the one theorem, the comparison once more on the recompiled module at the gate, the full gate on
one commit, the fast-forward.

