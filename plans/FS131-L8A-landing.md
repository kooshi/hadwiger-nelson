# FS131-L8A — wave 8's first landing: the ring calculus joined, gated and landed

*The record of job FS131-L8A (de Bruijn, the implementer; a landing). Brief: `data/fs131/briefs/FS131-L8A-wave8-land.md` (on
`main`). Worktree `.claude/worktrees/fs131-w8l`, branch `fs131-w8l`, cut from `fs131-w8c` at `0bdf6ea9`. Everything this record
cites is under `data/fs131/l8a/`.*

## Theorems this phase proved

None of its own: this job joins two branches, merges `main`, corrects docstrings, declares what the wave assumes and runs the
gate; it changes no statement, definition or proof. The wave's theorems, as the gate's saved logs hold them on the gated commit,
are listed in "Theorems this phase proved, final" at the end of this record.

## Stage 1 — SAVED (FS131-L8A): the readback, what was read, the branch built as given

**The quotations.** The brief quotes sixteen statements, each as a first line with its source. All sixteen are whole lines of
their sources, verbatim, and each one cited with a section lies under that heading (`tools/fs131_lt5_readback.py`, the last
landing's reader, run from `main` and not edited; output `data/fs131/l8a/readback.out`: `quotations=16 mismatched=0`). Its controls
(`--self-test`, `data/fs131/l8a/readback-selftest.out`, four of four as expected): a faithful quotation reads MATCH; the same
line with one character changed, the same line cited under a section it is not in, and the same line cited from a file that does
not exist each read MISMATCH. The three front-page lines were read on `main`'s `CLAUDE.md` at `416a3830` (ll. 449, 455, 514); the
copy of `CLAUDE.md` loaded into this session at launch is older and reads 6148 clean, 4 imported and 14299 declarations — not
used.

**What was read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md` on `main` (all of it; § Assumptions and § The gate as
they stand since the assumptions step landed); `RUNNING.md` § Building and § Make the gate fail, and watch it fail; the last
landing's record, `plans/FS131-LT5-landing.md`, all ten stages and its drafts; inventory items 569, 571, 572, 586, 592, 597, 598;
the two parallel implementers' reports (`data/fs131/reports/FS131-I8C.md` on this branch, `FS131-I8D.md` on `fs131-w8d`) and, of
their records, "Theorems this phase proved", the findings and saves of their last stages, "For the join" and the drafts; of the
join job's record (`plans/FS131-I8B-implementation.md`) and the first implementer's (`plans/FS131-I8A-implementation.md`):
"Theorems this phase proved", the last stage's save, "For the two implementers who start from here", the drafts. **Read by
address, not whole**: the planners' record (`plans/FS131-w8-kernel-plan.md`: both "Theorems this phase proved", §§ 5.5–5.8,
9.5–9.8, 10.1–10.3 — the inhabitants owed, what a third pass starts from, the handoffs); the rest of the inventory.

**What the records say this landing will meet** (the expectations the gate's output is read against):

| from | what | expected at the gate |
|---|---|---|
| I8A draft 1 | 66 records, block "FS131-I8A"; two `decide +kernel` tables (`V6Count.table`, `V6Count.doublesTable`) on `[propext, Quot.sound]` | CLEAN; no purchase |
| I8A draft 1 | two `VACUITY DECLARED` lines, `v6_hubs` and `v6_hug`, each with its kernel refutation (`v6_hubs_vacuous`, `v6_hug_vacuous`) | `declared` 3 → 5 |
| I8B draft 1 | 21 records, block "FS131-I8B"; `star_anti` keeps a `VACUITY:` paragraph (satisfiability open) | CLEAN |
| I8C draft 1 | 35 records, block "FS131-I8C" | CLEAN |
| I8D draft 1 | 29 records, block "FS131-I8D"; 14 of them print `sorryAx` on its branch, by `SemiHub`'s leaves only | CLEAN after the join — **the receipt this job exists for** |
| K8, K8b | their own blocks (K8b: eighteen declarations) | CLEAN |
| K8b § 9.6, I8C, I8D | no Lean star, semi-hub, two adjacent change points; `emptyNS`'s nine-colour model owed | the vacuity scan reads those theorems GENERIC or UNKNOWN, not WITNESSED; an UNKNOWN or VACUOUS site is a message |
| ruling 571 (a) | no named hypothesis in the wave | the assumptions step asks for nothing; a failure no record explains is a message |
| I8C report | one line of prose in `SemiHub` holds the word `sorry` | a docstring correction of step 4 |

**The join, trialled** (`git merge-tree --write-tree --name-only HEAD origin/fs131-w8d`, nothing merged;
`data/fs131/l8a/merge-trial-w8d.out`): exit 1, two conflicts — `ARCHITECTURE.md` and `scripts/Axioms.lean` — and no Lean file,
as the coordinator's trial and both implementers' say. The merge base is `6e0cf10d`, the join job's tip.

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0: "All targets
up-to-date (5819 jobs)", "build: OK — all 1812 modules already up to date, nothing built, 2 module(s) with warnings"
(`data/fs131/l8a/build-stage1.log`). The two modules are `SemiHubPlaces` (six declarations with `sorry`, ll. 48, 69, 85, 95, 107,
123) and `Empty` (one, l. 559): seven, as the brief says, each proved on the branch about to be merged. `rg -c "^\s*sorry"` on the
ring calculus agrees: 6 and 1.

**`main` moved since the brief was written**: `d4fb9390` → `416a3830` (the inventory's item 598 and this job's brief).

**Token count at this stage**: I have no reading of the harness's count; my own estimate is about 190k, most of it the context
loaded at launch and this stage's reading.

## Stage 2 — SAVED (FS131-L8A): the join — the wave is whole

**The merge.** `git -c merge.conflictStyle=diff3 merge --no-commit --no-ff origin/fs131-w8d` (tip `989a0393`; base `6e0cf10d`), exit
1 with the two conflicts of the trial and no other (`data/fs131/l8a/merge-w8d.out`). Each resolved by the three-way rule — a
non-blank line stands ours + theirs − base times — with the last landings' resolver, run from `main` and not edited
(`tools/fs131_l10b_keepboth.py resolve`; `keepboth-resolve-arch.out`, `keepboth-resolve-axioms.out`: one hunk each):

- `ARCHITECTURE.md`: three neighbouring rows in one hunk. Ours rewrote the row of `Plane/RingCalculus/SemiHub`; theirs rewrote the
  rows of `…/Empty` and `…/SemiHubPlaces` and added a row for `…/OuterAdj`. Each row is its changer's; no row was changed by both.
- `scripts/Axioms.lean`: two blocks inserted at one place above the PURCHASED banner, "FS131-I8C" (35 records) and "FS131-I8D"
  (29). Both kept, ours first.

`check` on each, exit 0: `ARCHITECTURE.md` 719 non-blank lines, faults 0; `scripts/Axioms.lean` 6,524 non-blank lines, "`#print
axioms` lines 5757 = ours 5728 + theirs 5722 − base 5693; faults 0" (`keepboth-check-*.out`). The checker's own plants on each
file, each fired with its word (`keepboth-selftest-*.out`, both "self-test: PASS"): a line of theirs dropped (LOST), doubled
(EXTRA; TWICE for a record), a marker left in (MARKER), the base's row put back beside ours' rewriting (EXTRA), a record of
theirs dropped (COUNT).

**The index held the merge and nothing else** (`tools/fs131_l10b_mergeindex.py origin/fs131-w8d ARCHITECTURE.md scripts/Axioms.lean`,
`mergeindex-w8d.out`): "staged 49 path(s), 2 changed by both sides (ARCHITECTURE.md, scripts/Axioms.lean), 47 taken whole from
theirs", "merge-index: PASS". Its two controls, run live before it: with `scripts/Axioms.lean` left unstaged — FAIL (`UNMERGED`,
`DIRTY`); with an extra file staged — FAIL (`EXTRA staged, not of the merge`). Committed as the merge `a243db17` (parents
`8de00270`, `989a0393`). Under `Proofs/` the merge brings `SemiHubPlaces` (906 lines added), the new `OuterAdj` (323), `Empty`
(13) and one import in `Proofs.lean`: **no Lean file was changed by both sides**, so every Lean file of the joined tree is one
side's file, byte for byte.

**The build of the joined tree** (`data/fs131/l8a/build-join.log`): "build: OK — 468 of 468 batches, 4 module(s) rebuilt, **0
module(s) with warnings**, 9m16s", `EXIT=0`; rebuilt `OuterAdj`, `SemiHubPlaces`, `Empty`, `Proofs`. Its full log
(`build/gate/build/20261007T000139Z-29294.log`, scratch) holds no line with "warning"; its two lines with "error" are the
up-to-date probe naming the targets to rebuild, before batch 1. The seven `declaration uses sorry` warnings of stage 1 are gone.

**The receipt that the wave is whole.**

1. **Zero `sorry` under `Proofs/`**: `grep -rnP '^\s*sorry\s*$|:= sorry|by sorry' --include='*.lean' Proofs/ Proofs.lean` — 0
   lines; `rg -c "^\s*sorry"` on the ring calculus — no match (exit 1). And by the kernel, below: no theorem of the twelve
   modules has a `sorry` anywhere beneath it.
2. **Every record of the line on a subset of the standard three, nothing beneath it open** (`tools/fs131_l8a_axioms.py`, this
   job's, after the sibling implementer's; from the compiled modules; `axioms-join.verdict`, raw `axioms-join.txt`), exit 0:
   "207 records in 7 blocks — 205 on exactly the standard three, 2 on a proper subset, 0 bad; 329 theorems in 12 modules (230
   hand-written, 99 generated; 23 hand-written with no record in the seven blocks), 0 bad". By block: FS131-K7 8, FS131-K8 30,
   FS131-I8A 66, FS131-K8b 18, FS131-I8B 21, FS131-I8C 35, FS131-I8D 29 — the counts each implementer's drafts give (66, 21,
   35, 29). The two on a proper subset are `V6Count.table` and `V6Count.doublesTable`, on `[propext, Quot.sound]` (the kernel's
   own evaluation; no native axiom). For each record the tool reads the axioms *and* the sorry roots (every declaration beneath
   it whose type or proof mentions `sorryAx`), and it reads every theorem the kernel holds in the twelve modules, recorded or
   not, so a `sorry` could not hide under a theorem no block names. **The control fires**: a theorem proved by `sorry` in the
   scratch file prints `['sorryAx']` with itself as its root on every run, and with `--fault` (the control added to the audited
   records) the tool exits 1, "BAD record [(control)] FS131L8AControl.planted_sorry: axioms outside the three: sorryAx; a sorry
   beneath it" (`axioms-join-fault.verdict`).
3. **The fourteen records that rested on the other branch's leaves rest on nothing now**: the sibling implementer's own tool,
   as its record's "For the join" asks (`tools/fs131_i8d_axioms.py`, `axioms-join-i8d.verdict`), exit 0 — "29 records — 29 on a
   subset of the standard three, 0 resting besides on open leaves of SemiHub only (0 distinct), 0 bad". On its branch it read
   15 and 14.
4. **No name declared by two modules, on the joined tree** (`./scripts/dupnames.sh`, `dupnames-join.log`): "dupnames: OK — no
   name is declared by two modules (23 generated on demand, listed above)", exit 0. The readings of 2 and 3 are stored axiom
   lists, faithful only then (`LEAN.md` § The gate); the scan ran on the same compiled tree.
5. **No statement of either side changed by the merge**, on elaborated signatures (`tools/fs131_l8a_stmt.py`, this job's
   wrapper of the sibling's instrument over all eleven modules of the ring calculus, `OuterAdj` added to its list):
   - against theirs' tip `989a0393` (`stmt-join-vs-theirs-989a0393.log`), exit 0: "255 base declarations compared in 11
     modules; 0 changed or missing; 16 added since the base" — the sixteen are FS131-I8C's additions to `SemiHub`;
   - against ours' tip `0bdf6ea9` (`stmt-join-vs-ours-0bdf6ea9.log`), exit 0 with `--expect` the five of inventory item 592:
     "251 base declarations compared in 10 modules; 5 changed or missing; 14 added since the base", "EXPECTED: the changed
     declarations are exactly … `crossed_changePoint`, `crossed_four`, `crossed_semiHub`, `semiHub_places`, `transferQC`"
     (`OuterAdj` is absent at that base: every declaration of it is an addition). **Each of the five differs by exactly the
     ruled binder** — `4 ≤ (F.coloursAt p).ncard` replaced by `(F.coloursAt p).ncard = 4` (`tools/fs131_i8d_binders.py` on that
     log, `binders-join-vs-ours.log`: "5 of 5 as ruled"; its `--fault`, expecting `= 5`: "0 of 5", exit 1);
   - the wrapper's four planted faults, against `989a0393` (`stmt-selftest.log`), each adding exactly its culprit to the
     changed set: a hypothesis of `semiHub_places` altered in theirs' module; `include hbad in` above `ringArc_star` in ours'
     (the text of the statement unchanged, the kernel's statement gaining `0 = 1`); a binder added in `OuterAdj`; the
     definition `IsEdgeDir` weakened (read by its value hash). "self-test: OK — every planted fault fired, each adding exactly
     its culprit". A first run of the self-test stopped as an instrument failure (exit 2): my anchor for the first fault stood
     twice in the file (`semiHub_places` and `transferQC` share two signature lines); made unique and re-run.

**A twelfth module lands with the wave.** The line carries `Plane/SimpleOn` (wave 7's foundation, job FS131-K7, commit
`611ffa39`, "alone, for waves 8 and 9 to merge"; 157 lines, no `sorry`; block "FS131-K7", 8 records, each on exactly the
standard three). It is not on `main`; the same blob (`01a7215ae7`) stands on `origin/fs131-w7` and `origin/fs131-w9`, so those
lines meet it on `main` as their own file. The brief's "the wave's modules under `Plane/RingCalculus/`" are eleven; the landing
brings twelve.

**For the gate's records step**: of the 23 hand-written theorems with no record in the seven blocks, most are fields of the
structures `IsStar4`, `IsTip`, … that the kernel holds as theorems; the gate's records check (stage 7) says which are owed a
record.

## Stage 3 — SAVED (FS131-L8A): `main` merged in

**The trial first** (`git merge-tree --write-tree --name-only HEAD origin/main`, nothing merged; `data/fs131/l8a/merge-trial-main.out`):
exit 1, three conflicts — `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` — the three the coordinator's trial names, and no
other. Since the line's base on `main` (`e6e7b312`, before wave 5 landed) `main` changed 37 Lean files under `Proofs/` and the
line twelve; **no Lean file under `Proofs/` was changed by both** (the two lists of names have no line in common).

**The merge**: `git -c merge.conflictStyle=diff3 merge --no-commit --no-ff origin/main`, at `22f1ca6c` (`main` had moved from
`416a3830` by two commits of briefs; `merge-main.out`). Each conflict is one hunk with no base lines — blocks added at one place
by both sides — resolved by the three-way rule, `main`'s lines first (`tools/fs131_l10b_keepboth.py resolve --theirs-first`), so
that the file is `main`'s with the line's rows, imports and blocks after them:

| file | `check` against ours `ac8d0bcc`, theirs `22f1ca6c`, base `e6e7b312` | the checker's plants on it |
|---|---|---|
| `ARCHITECTURE.md` | "802 non-blank lines; faults 0", "three-way: PASS" | 3 fired, "self-test: PASS" |
| `Proofs.lean` | "288 non-blank lines; faults 0", PASS | 3 fired, PASS |
| `scripts/Axioms.lean` | "7364 non-blank lines; `#print axioms` lines 6541 = ours 5757 + theirs 6334 − base 5550; faults 0", PASS | 5 fired, PASS |

(`keepboth-main-check-*.out`, `keepboth-main-selftest-*.out`.) The check reads the whole file, so the parts of
`ARCHITECTURE.md` that merged by themselves (§ 5's subsection "Assumed as hypotheses", `main`'s) are held to the same rule.

**The index held the merge and nothing else** (`tools/fs131_l10b_mergeindex.py 22f1ca6c ARCHITECTURE.md Proofs.lean
scripts/Axioms.lean`, `mergeindex-main.out`): "staged 1230 path(s), 3 changed by both sides (ARCHITECTURE.md, Proofs.lean,
scripts/Axioms.lean), 1227 taken whole from theirs", "merge-index: PASS"; its two controls first — `scripts/Axioms.lean` put back
to `HEAD`'s in the index: FAIL (`MISSING from the index`, `CONFLICT-PATH not staged`, `DIRTY`); an extra file staged: FAIL
(`EXTRA staged, not of the merge`). **A first run of this check failed for a reason of its own, and showed something**: I had
given it the ref `origin/main`, which another job's fetch moved under me from `22f1ca6c` to `d38c118b` between two of its runs
(the worktrees share one set of refs), so it compared the index with a commit that was not merged — `WRONG-MERGE`, `MISSING`,
`NOT-THEIRS`. Every check of this stage was re-run against the commit's own hash, and from here on a merged commit is named by
hash, never by a ref that can move. Committed as the merge `1171c25b` (parents `ac8d0bcc`, `22f1ca6c`).

**No build at this commit alone.** The slot's ledger held two other 40 GiB builds, and my build of `1171c25b` was still waiting,
not admitted, when the coordinator's ruling on docstrings arrived; I stopped it by its task id before it had started (verified by
effect: no process with its working directory in this tree, its log unchanged across ten seconds, the slot's ledger never held
it, `Proofs.olean`'s digest unchanged) and built once, at the next commit, which differs from `1171c25b` in doc comments and
registry prose only (stage 4). What was forfeited: nothing was compiled; a place in a queue. What that one build shows of this
stage is in stage 4.

## Stage 4 — SAVED (FS131-L8A): the docstring corrections, and nothing else in the modules

**The edits** are `data/fs131/l8a/docstring-edits.py`: seventeen exact replacements (21 occurrences) in four files, each
refused unless its old text stands the expected number of times; its `--list` output, every before and after text, is
`docstring-edits.list`. A second run is refused at the first edit (`docstring-edits-second-run.out`).

*The brief's four.*

| # | where | before → after |
|---|---|---|
| 1 | `SemiHub`, `fullSemiHub_star_crossed`'s docstring | "…gives these hypotheses: the arcs by `GermOnQWith.exists_isRingArc_ccw`, `…_cw`, four colours by `germS_absent`." → "…gives the two arcs, by `GermOnQWith.exists_isRingArc_ccw`, `…_cw`. It does not give `h4`: at a change point `germS_absent` makes two colours absent at `p` (`ncard + 2 = k`), which is four colours only at `k = 6`; exactly four colours is a hypothesis of its own (inventory item 592)." (`germS_absent`'s statement read: `(F.coloursAt p).ncard + 2 = k ∧ (F.coloursAt p)ᶜ = {X, X'}`.) |
| 2 | `SemiHubPlaces`, the five ruled statements' docstrings (`semiHub_places`, `crossed_four`, `crossed_changePoint`, `crossed_semiHub`, `transferQC`) | "(`h4`; ruled on FS131-I8D's finding)" → "(`h4`; inventory item 592)" |
| 3 | `SemiHub`, `qcol_inner_tile`'s docstring | "stated there with `sorry` on a branch this one does not hold" → "stated there as an open leaf on a branch this one does not hold" |
| 4 | `ARCHITECTURE.md`, the row of `Plane/RingCalculus/StarChart` | "Imported by no module yet: `SemiHub` and `SemiHubPlaces` take it at their implementers' first stage." → "Imported by `SemiHub` and `SemiHubPlaces`." |

*Beyond the brief's list — sentences the join itself made false or stale, which no branch could see from its own tree.* Sent to
the coordinator mid-job with the alternative (file them as docstrings owed); **ruled, by its message of 2026-10-06: "make (a),
(b), (c), the `ARCHITECTURE.md` rows and the `scripts/Axioms.lean` block comment true of the joined state — doc comments and
registry prose only, shown by your two instruments, each listed in your record as beyond the brief's list with its before and
after text … Your touches are extended to exactly these."**

| | where | before → after |
|---|---|---|
| (a) | `SemiHub`, module doc, the table's row of FS116-N3-SEMI | "\| stated \|" → "\| proved there (job FS131-I8D) \|" |
| (a) | the same, the row of FS116-N3-CROSS | "\| `crossed_tip_zeroAngle` proved from `crossed_no_tip`; the rest stated \|" → "\| proved there (job FS131-I8D) \|" |
| (b) | `SemiHubPlaces`, module doc | "(job FS131-I8C's leaves, in a tree of its own until the wave's join): no declaration of this module holds a `sorry`, and each rests on that module's leaves it cites." → "(job FS131-I8C's leaves, proved in a tree of its own; the two were joined by job FS131-L8A): every declaration of this module is a kernel theorem with no open leaf beneath it." (also the second and last line of prose in the ring calculus holding the word `sorry`) |
| (c) | `SemiHubPlaces`, module doc | "**The class** (ruled on job FS131-I8D's finding):" → "**The class** (inventory item 592, on job FS131-I8D's finding):" |
| | `ARCHITECTURE.md`, the row of `SemiHubPlaces` | "ruled on FS131-I8D's finding:" → "inventory item 592:"; "No `sorry` in the module; until the wave's join its records rest on `…/SemiHub`'s open leaves." → "No `sorry` in the module, and since the wave's join (job FS131-L8A) none beneath it: every record is on the standard three." |
| | `ARCHITECTURE.md`, the rows of `Star`, `Empty`, `SemiHub` | the title's word "skeleton" → who stated and who proved ("**FS-131 wave 8** (stated by job FS131-K8, plan Stages 2–4; its two leaves proved by jobs FS131-I8A and FS131-I8B)", and likewise). `Star`'s row carried the word too, though my message named two rows: the same word of the same class, corrected with them. |
| | `ARCHITECTURE.md`, the row of `SemiHub` | the skeleton's five "(stated)", one "(proved)" beside them, and the sentence that apologized for them ("the words "(stated)" above are the skeleton's and no longer describe the module") removed |
| | `scripts/Axioms.lean`, the block comment of "FS131-I8D" | "…rests on that module's open leaves (`tools/fs131_i8d_axioms.py` names them per record)." → "…rested on that module's open leaves; since the join (job FS131-L8A) none does (`tools/fs131_i8d_axioms.py`: 29 on the standard three, none resting)." |

**Not made, by ruling 598 (b)–(c)**: no row is restated at its wider class; `Empty` keeps its import of `SemiHub` through
`OuterAdj`. **Not made, and not asked**: the block comments of "FS131-K8" and "FS131-K8b" in `scripts/Axioms.lean` still say their
open leaves "join this block as their implementers close them" (they joined the implementers' blocks instead) — history, not a
claim about the tree; left.

**Shown to touch no line outside a doc comment, by two instruments** (the last landing's `tools/fs131_lt5_docstring_check.py`,
not edited; its `--self-test` on this tree, `docstring-check-selftest.out`: "self-test: OK — every planted fault fired and every
partner passed"):

1. **Text**, against the merge `1171c25b`: every doc comment of both versions replaced by a placeholder and the rest compared
   byte for byte — `text: files=2 doc-comments-changed=9 failed=0` (`docstring-text-check.out`, which lists the nine with their
   declarations: `SemiHub`'s module doc, `qcol_inner_tile`, `fullSemiHub_star_crossed`; `SemiHubPlaces`' module doc and the
   five). Registered before the run: 2 files, 9 doc comments.
2. **Elaborated**, independent of the lexer: every constant of the twelve modules from the built library — stored type (hash,
   and the length and hash of its full debug text), kind, universe parameters, a definition's value hash — dumped before any edit
   (`sigs-before.txt`, from the joined tree's build) and after the rebuild (`sigs-after.txt`): `before=398 after=398 (theorems
   before=329) missing=0 added=0 changed=0`, "IDENTICAL — every constant's stored type, kind, universe parameters and value hash
   agree" (`sigs-compare.out`). **The two dumps stand on either side of the merge of `main` as well**, so they also show that
   compiling the wave over `main`'s 37 changed files moved no statement or definition of the twelve modules.

`scripts/Axioms.lean`: the diff is the one comment (`docstring-axioms-diff.out`: no `#print axioms` line added or removed).
`ARCHITECTURE.md`: five rows changed; `tools/check_architecture.py` — `RESULT: PASS` (`arch-after-docstrings.txt`). Committed as
`2952622f`.

**The one build, of `2952622f`** (`data/fs131/l8a/build-main-and-docstrings.log`): "build: OK — 473 of 473 batches, 79 module(s)
rebuilt, **0 module(s) with warnings**, 17m22s", `EXIT=0` — `main`'s modules compiled in this tree for the first time (waves 5,
6's first half, 10, the example maps, the docstrings of the assumptions step), then `SemiHub`, `SemiHubPlaces`, their
dependents and `Proofs`.

**Token count at this stage**: no reading of the harness's count; my own estimate is about 330k.
