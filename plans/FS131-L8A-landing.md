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

## Stage 5 — SAVED (FS131-L8A): what the wave assumes, the registration, the vacuity scan and its ruling, the heads as the kernel holds them

### 5.1 What the wave assumes: nothing — two conditions declared

`./scripts/assumptions.sh --self-test` first, on the merged tree with the list as it came: exit 0, "OK — all 33 checks behaved:
every planted fault fired, and every partner stayed silent" (`data/fs131/l8a/assumptions-selftest-first.out`). Then the step
itself: **exit 1, 2 failures** (`assumptions-first.out`; the scan, `assumptions-first.scan.log`):

```
FAIL undeclared-never-concluded HadwigerNelson.Plane.ArcMap.OuterPairFree :: taken as a hypothesis by 3 constant(s) ([…crossed_semiHub, …ringGerm_outward]), concluded by none: an assumption (.former) or a condition (.condition)?
FAIL undeclared-never-concluded HadwigerNelson.Plane.ArcMap.TipPairFree :: taken as a hypothesis by 2 constant(s) ([…star_tip_nonempty, …ringGerm_inward]), concluded by none: an assumption (.former) or a condition (.condition)?
```

Both read from their definitions and the planners' record, not from their names. `TipPairFree p ψ` is `¬ F.GermOnQ p (ψ − π/3) .cw
∧ ¬ F.GermOnQ p (ψ + π/3) .ccw` ("**The tip pair** `{v⁻, u⁺}` at `r(ψ)` lies on no (Q) arc", `Plane/RingCalculus/Basic` l. 70);
`OuterPairFree` is the same of the other two germs. The first planner's record: "The two germ pairs are kept as two explicit
conjunctions (`TipPairFree`, `OuterPairFree`)", "Hypothesis "neither v⁻ nor u⁺ lies on a (Q) arc" is `TipPairFree`"
(`plans/FS131-w8-kernel-plan.md` ll. 132, 173): each is a row's own hypothesis about the theorem's map, point and angle — a
configuration of the ring — and stands for no result. They hold at every angle of a (Q)-free ring (`QFreeRing.not_germOnQ`, twice),
and so on `halfPlane2` at `0`; no theorem *concludes* the former by name because `IsHub`, which `QFreeRing.isHub` concludes, is
stated over the four germs and equals the two pairs only through `isHub_iff`. **Declared as two `.condition` lines** in
`AssumptionAudit.declared` (`scripts/Assumptions.lean`), each with that reason. Ratified by the coordinator's message ("right as
you describe them").

After them: **exit 0** — "assumptions: OK — 1 outside theorem(s) as axioms, with 8 theorem(s) resting on them; 19 named and 16
inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1" (`assumptions-declared.out`).

| | `main` (FS131-LT5's gated scan) | this tree |
|---|---|---|
| `=== SCANNED ===` | constants=13795 theorems=10173 formers=303 hypotheses=17192 closed=1473 | constants=14063 theorems=10405 formers=320 hypotheses=18013 closed=1473 |
| the nine | axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 | **the same nine** |
| the rest | conditions=33 … silent=1 cohyp=58 hints=0 unseen=15214 fails=0 | conditions=35 … silent=1 cohyp=58 hints=0 unseen=16035 fails=0 |

**The wave brings no assumption in either form**: no `axiom`, no named hypothesis, no closed hypothesis (`closed` did not move),
no consumer of a declared one. The nine counts are `main`'s, so the front page's nine **do not go stale** at this landing: both
recorded sources read "match (9 of 9 compared)". `--write-ledger`: exit 0, "ledger written (107 rows)", and **the ledger gains no
row and loses none** (the section "rows the ledger gains (+) and loses (-)" is empty; the file's digest is unchanged;
`assumptions-write-ledger.out`).

**The class the step cannot see** (a hand result or an open question written out in a binder over the theorem's own variables),
read with the last landing's aid (`tools/fs131_lt5_docwords.py`, 29 words; `docwords-wave8.out`): twelve modules, 347 doc
comments, **one hit**, `SemiHub`'s module doc, for "named hypothes" — the sentence "So the three rows are theorems, not
implications from a named hypothesis", which says there is none (inventory item 571's ruling, as built). None is written out in
a binder. `unseen` rises by 821: the wave's hypotheses over its own variables — a valid map, a non-Siamese map, a cover, a count of
colours, a change point, an arc of `Γ` — each a condition on the theorem's objects.

### 5.2 The registration: thirteen records in a block of this job's

From the kernel's own list of theorems (`data/fs131/l5/count-modules.lean` on this tree against `main`'s gated list,
`data/fs131/lt5/gate/count-modules-landed2.out`), by `tools/fs131_l8a_register.py` (the last landing's tool with the wave's
modules, blocks and header in place of wave 10's; `register-list.out`): "main 9513 theorems, landing 9744 … the wave adds 231
(Basic 32, Empty 20, HubCount 25, OuterAdj 6, RingColour 16, SemiHub 53, SemiHubPlaces 22, SimpleOn 8, SoleTip 8, Star 17,
StarChart 17, TilesAt 7); generated by Lean 11 …; hand-written 220; with a record 207; MISSING 13; STALE 0; FOREIGN-MODULE 0".
The thirteen, all of `Basic`: ten lemmas no block listed (`GammaFreeRing.not_isRingArc`, `GermOnQWith.germOnQ`,
`IsFullSemiHub.isSemiHub`, `IsHub.not_isSemiHub`, `IsOuterTileAt.not_isTip`, `IsTip.tileAt`, `QFreeRing.not_germOnQ`,
`TileAt.subset_ball`, `outerTileColours_subset`, `tipColours_subset`) and three theorems Lean generates for the enumeration
`SemiKind` that the generated-name pattern does not know (`SemiKind.O.sizeOf_spec`, `SemiKind.T.sizeOf_spec`,
`SemiKind.ofNat_ctorIdx`) — registered rather than exempted: a record is the stronger of the two. Written as a block
"FS131-L8A" above the PURCHASED banner (`--write`: "wrote 13 records"); after it "hand-written 220; with a record 220; MISSING 0;
STALE 0", the blocks summing to 220 (`register-after.out`). The tool's two plants (`register-selftest.out`): a wave theorem's
record removed — MISSING fired; a record naming no declaration planted in a wave block — STALE fired.

### 5.3 The vacuity scan: red on a marker, a ruling, green

**The scan's own procedure** (`scripts/Vacuity.lean`, "How a later wave registers its carriers"), step (1): the census
(`data/fs131/l8a/census.lean`, wave 5's with its scope changed to the twelve modules and nothing else; `census.out`): 19 formers —
seventeen predicates, the enumeration `SemiKind` and one generated auxiliary of it. **None has an unconditional `¬ P …` at a
closed instance, none an `IsEmpty` instance, none a binder site at a closed instance** (`SemiKind`'s 15 closed sites are binders
of the enumeration itself, which is data), so for none could step (3)'s `VACUOUS` control be planted. **No new carrier IN**; each
OUT with its reason in the wave's entry of `scripts/Vacuity.lean` (the registry is a comment of the scan; no library module
changes). Two decisions a later reader should see:
- **`IsStar4`**: "does one exist" is a theorem (`exists_isStar4`), so by the procedure's first clause alone it would be IN. Kept
  OUT by the law as wave 5 applied it and wave 6's landing was ruled on (`AeColouring.Fan`): nothing refutes a star at a closed
  instance, so no control can be planted. The third instance of that case; one mind's application of a ruled law.
- **`SimpleOn`** (wave 7's foundation, landed here): OUT where the tracked `Simple` is IN — nothing refutes it at a closed
  instance. Its closed model is `halfDisc` at `{0}`, inside an `example`.

**The first scan: red.** `./scripts/vacuity.sh`, exit 1 (`vacuity-probe.out`, scan `vacuity-probe.scan.log`):

```
SITE STALE HadwigerNelson.Plane.ArcMap.v6_hubs :: F.Valid
SITE STALE HadwigerNelson.Plane.ArcMap.v6_hubs :: F.NonSiamese
=== SCANNED === declarations=14807 refutations-skipped=215
=== TOTALS === sites=1446 vacuous=0 stale=2 declared=3 witnessed=38 generic=1401 unknown=2 untelescoped=0
==> vacuity: FAIL — 2 site(s) that no baseline can excuse
```

**The mechanism** (`scripts/Vacuity.lean`, `marker`, `probe`): the docstring marker makes each tracked binder of the declaration
read `DECLARED` when that binder's carrier is provably empty and `STALE` when it is not — "a docstring declares emptiness that is
not proved" — and `STALE` fails before the baseline. `v6_hubs` binds `F.Valid` and `F.NonSiamese` at a variable `F : ArcMap 6`,
both tracked since wave 3, neither empty alone. The emptiness its marker named is **joint**, across five hypotheses, and is a
kernel fact (`v6_hubs_vacuous`: `False` from the exact hypotheses); a per-binder scan cannot see it, and its header says so.
`v6_hug` carried the same marker and concludes `False`: a refutation, skipped, its marker never read. Inventory item 518 placed
the markers "whatever the scan prints", on the premise that the scan does not track `ArcMap` binders; the one print that is a
hard failure is the one it got.

**Sent to the coordinator** with the scan's lines and three options. **Ruled, by its message of 2026-10-06: "your option (i),
now; option (ii) is filed for the tooling job … in `Empty`, the docstrings of `v6_hubs` and `v6_hug` lose the scan's `VACUITY
DECLARED:` marker and say the joint vacuity in words the scan does not parse, with every fact kept … Why not leave the marker and
excuse the sites: the marker, as the scan defines it, is false of `v6_hubs` — no single carrier is empty — so `STALE` is the gate
being right, and I do not want a baseline or a special case to make it quiet. … Your touches are extended to exactly these two doc
comments in `Empty`."**

**The two doc comments** (`data/fs131/l8a/docstring-edits-2.py`, exact replacements; before and after in `docstring-edits-2.list`):
in each, the line "VACUITY DECLARED: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a step of that refutation…"
becomes "**Jointly vacuous, and a kernel fact (`v6_hubs_vacuous`)**: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is
a step of that refutation and is consumed nowhere else. (Not the scan's `VACUITY DECLARED` marker, which claims that one
binder's carrier is empty; here each hypothesis is satisfiable alone and the five are not together.)" — and for `v6_hug` the
same with `v6_hug_vacuous`, "each of the first five hypotheses", and the sentence that the scan skips it as a refutation. The
script refuses to write if the marker's string (the two words and a colon) still stands in the file; it stands 0 times in the
ring calculus now. Shown twice as before: **text**, against `23389f17`: `files=1 doc-comments-changed=2 failed=0`
(`docstring-text-check-2.out`); **elaborated**, the twelve modules after the rebuild against the dump before
(`sigs-compare-2.out`): `before=398 after=398 … missing=0 added=0 changed=0`, IDENTICAL — and identical to the dump taken before
any docstring was touched. The rebuild: "473 of 473 batches, 2 module(s) rebuilt, 0 module(s) with warnings"
(`build-empty-docstrings.log`: `Empty`, `Proofs`).

**The scan after it: green** (`vacuity-probe2.out`, scan `vacuity-probe2.scan.log`), "vacuity: OK":

| | `main` | first scan | after the rewording |
|---|---|---|---|
| declarations | 14501 | 14807 | 14807 |
| refutations-skipped | 199 | 215 | 215 |
| sites | 1269 | 1446 | 1446 |
| vacuous / stale | 0 / 0 | 0 / **2** | 0 / 0 |
| declared | 3 | 3 | **3** |
| witnessed | 38 | 38 | 38 |
| generic | 1226 | 1401 | 1403 |
| unknown | 2 | 2 | 2 |

`declared` stays 3 — not the 5 the first implementer's draft expected: the two markers are gone, and `v6_hug`'s was never
counted. **How the scan classes every new site** (`tools/fs131_l5_vacdiff.py` against `main`'s gated scan; the gated run's output
is in stage 6): 177 added sites, **every one `GENERIC`**, each on a carrier tracked since the first waves and taken at a variable
map — `Valid` 82, `NonSiamese` 52, `IsChangePoint` 23, `IsRingArc` 14, `IsHub` 5, `Simple` 1 — by module `SemiHub` 64,
`SemiHubPlaces` 39, `Star` 27, `Basic` 11, `Empty` 9, `StarChart` 8, `RingColour` 7, `OuterAdj` 6, `SoleTip` 3, `TilesAt` 2,
`SimpleOn` 1; no row of `main` lost, none added to a declaration `main` held, no new evidence row. **No site reads `VACUOUS` or
`UNKNOWN`; nothing asks for a baseline entry.** `declarations` +306 and `refutations-skipped` +16 are, module by module, the
twelve new modules' and no other's. The sixteen refutations skipped: four rows that conclude `False` (`emptyNS`, `doubleTip`,
`v6_hug`, `not_sole_tip_of_adjacent_changePoints`), the two kernel facts of joint vacuity, six steps inside a proof by
contradiction or negative clauses (`GammaFreeRing.changePoint_gap`, `not_double_two_classes`, `fin_four_three_pairs`,
`qcol_not_one_arc`, `star_anti_ne`, `false_of_antipodal_gaps`), and four whose conclusion is a predicate that unfolds to one
(`halfPlane2_gammaFreeRing`, `GammaFreeRing.qFreeRing`, `halfDisc_valid`, `halfDisc_nonSiamese`) — the reducing telescope's
standing reading of `GammaFreeRing`, `QFreeRing`, `Valid`, `NonSiamese`, as for every `_valid` theorem `main` holds.
**What the scan cannot see, and the docstrings say**: the theorems whose hypotheses no Lean object is known to meet together —
a star, a semi-hub, two change points 60° apart, `emptyNS`'s class at nine colours. They read `GENERIC`, binder by binder, which
is true and is not evidence that the hypotheses hold together. They are the landing's open gate items (drafts, item 8).

**`scripts/vacuity-baseline.txt`**: the header's two count lines, from `scripts/gate_report.py header` on the green scan; no
entry added, removed or reworded (`vacuity-baseline.diff`):

```
-#   declarations=14501  refutations-skipped=199  sites=1269
-#   vacuous=0 stale=0 declared=3 witnessed=38 generic=1226 unknown=2
+#   declarations=14807  refutations-skipped=215  sites=1446
+#   vacuous=0 stale=0 declared=3 witnessed=38 generic=1403 unknown=2
```

### 5.4 Every head's statement, read from the kernel

`data/fs131/l8a/kernel-sigs.lean` (the last landing's lister with the twelve modules in place of its own; its printer
byte-identical, by `diff`) prints every theorem of the twelve modules from its stored type: 241 records. Read against the files
by `tools/fs131_l8a_kernelsig.py`, this job's wrapper of the last landing's reader (`tools/fs131_l10b_kernelsig.py`, imported,
not edited); `kernel-sigs-read-probe.txt`, the table `kernel-sigs-table-probe.txt` (the gated run's are in stage 6):

- **"records read: 241 (theorems 241, axioms 0); generated by Lean, not compared: 24; compared with their files: 217"**;
  **no `MISSING-BINDER`**: every named binder of every file signature is a binder of the kernel's statement; "INCLUDED 310 …
  ABSENT inst/term 62 (reviewed 62, not reviewed 0)"; all 72 heads (`data/fs131/l8a/heads.txt`, taken from the audit's blocks by
  unique suffix) have a record; "kernel-signatures: PASS".
- **The class of inventory item 556 has no instance to find here.** The twelve modules declare these section variables and no
  other: `{k : ℕ}`, `(F : ArcMap k)` / `{F : ArcMap k}`, and in `RingColour`'s section `GermColouring` `{p : ℂ} {κ : ℝ → Side →
  Fin k}`. None is a hypothesis; every hypothesis of every theorem is a binder of its own signature. The 62 ABSENT rows are bare
  `k` (36) and bare `F` (26) in statements that fix a map of their own (`{F : ArcMap 6}`) or speak of no map (angles, points of
  `ℂ`, sets, finite data); written to `kernelsig-reviewed.txt` by `mk-reviewed.py`, by class and only where the statement's
  `SIG` line does not hold the variable's name as a token ("reviewed 62; left unreviewed 0").
- **Thirteen theorems the kernel holds have no text of their own** — the ten fields of the `Prop`-valued structure `IsStar4`
  and three of the enumeration `SemiKind` — which the reader would report `NOT-FOUND`. The wrapper does not exempt them by
  name: for each record with no text it looks in the module's own file for the structure and the field line, or the inductive
  and the constructor, and counts the record as generated only then, printing the field's line beside the kernel's conclusion
  (read: each pair agrees — e.g. "`cone₄ : coneAt t₄ p = angleIcc e₄ (e₁ + 2 * π)`" against "`coneAt t₄ p = angleIcc e₄ (e₁ +
  2 * Real.pi)`"). Its plants (`--plant`, `kernelsig-plant.out`): a name `IsStar4.zzNoSuchField`, a `SemiKind.ZZ.sizeOf_spec`
  and a plain theorem name with no text each stay `NOT-FOUND` and are not exempted; a true field is exempted. "plant: PASS".
- **The five heads the brief names, as the kernel holds them** (the table's `kernel:` lines against its `file:` lines): `emptyNS`
  — `{F : ArcMap 6}`, five hypotheses (`F.Valid`, `F.NonSiamese`, `F.Covers p 1`, `4 ≤ (F.coloursAt p).ncard`,
  `F.GammaFreeRing p`), `False`; `outerAdj` — `{F : ArcMap 6}`, eight; `star_anti` — `{F : ArcMap 6}`, fifteen, the two ruled
  ones (`hp''`, `hm''`) among them; `ringArc_star` — `{k} {F : ArcMap k}`, eight; `semiHub_places` — `{k} {F : ArcMap k}`, seven,
  with `(F.coloursAt p).ncard = 4`. In each the kernel's binders are the file's, one for one.

**Token count at this stage**: no reading of the harness's count; my own estimate is about 420k.

## Stage 6 — SAVED (FS131-L8A): the full gate on one commit — `126bff4d`

One pass is every step in order, one at a time under the slot (`data/fs131/l8a/run-gate.sh <tag>`, after the last landing's
runner; every log under `data/fs131/l8a/gate/` with its exit status on its last line; `run-gate-<tag>.head` records the commit
and that **no tracked file was modified**; `run-pass-<tag>.out` holds every step's exit). It ran twice.

- **First pass, tag `first`, on `1f094eb2`** (01:37:13Z–01:56:54Z): every step exit 0 but the planted controls that must exit 1
  and one step of the instrument's own — the last landing's kernel-signature reader's `--self-test`, which plants its second
  fault in `Arith/NormOneTarget` and reads its partner in `Arith/Floor128`, modules of the landing it was written for; a
  listing of the ring calculus holds no record of either, so it printed "DID NOT FIRE" and "FAILED" for want of records
  (`kernel-sigs-selftest-first.txt`). Not a fault of the tree. Its four checks are re-made on the wave's modules in this job's
  wrapper (`tools/fs131_l8a_kernelsig.py --plant`, part (b)), and the runner calls that.
- **Between the passes, the lint's negative control** — which the wave's three implementers each left to this gate ("it needs a
  build of its own"): an unused anonymous instance binder planted in a leaf module (`theorem zz_l8a_lint_plant [Nonempty ℕ] :
  (1 : ℕ) = 1 := rfl`, appended to `Plane/RingCalculus/OuterAdj`; never committed), built — "473 of 473 batches, 3 module(s)
  rebuilt, **0 module(s) with warnings**" (`data/fs131/l8a/lint-plant-build.log`: the build's own linters do not see it, as
  `LEAN.md` § The gate says) — and then the guarded lint: **exit 1**, "`unusedArguments`: (2/2) Failed with 1 messages",
  "error: @HadwigerNelson.Plane.ArcMap.zz_l8a_lint_plant 1 unused argument: argument 1: [Nonempty ℕ]"
  (`data/fs131/l8a/lint-plant.log`). The module restored by `git checkout`: its digest is the one taken before the plant
  (`lint-plant-digest-before.txt`), no tracked file modified, the plant's name in the file 0 times; the next pass's build rebuilt
  the three modules and its lint is green.
- **Second pass, tag `final`, on `126bff4d`** (02:14:26Z–02:33:39Z; `126bff4d` differs from `1f094eb2` in `tools/`, `data/` and
  `plans/` alone — the wrapper's part (b), the runner, the logs, this record): **every step exit 0** but the three plants that
  must exit 1. The three scans' rows are the first pass's, row for row (`cmp` on every `SITE`/`EVIDENCE` row of the vacuity
  scan and on every `AXIOM`, `RESTS`, `ASSUMPTION`, `TAKES`, `MENTIONS`, `CONDITION`, `SILENT`, `COHYP`, `CLOSED` row of the
  assumptions scan; the axiom audit's counts). **The landing's evidence is this pass.**

**The machine incident of 02:00:15–02:02:50Z** (the coordinator's message: another job's unslotted process exhausted the RAM
twice; two out-of-memory kills, both of that job's own process). What of mine ran in that window, as it asks, each with its exit
status and its log's last line:

| run | overlap | exit | the log's last lines |
|---|---|---|---|
| any step of a gate pass | **none**: the first pass's last log was written at 01:56:54Z, and the final pass started at 02:14:26Z | — | — |
| the lint control's planted build (`lint-plant-build.log`; Lake's log `build/gate/build/20261007T020053Z-792599.log`) | launched 02:00:53Z; held three times by the slot's reserve ("slot: waiting (MemAvailable 16.5 - 40 < reserve 25 GiB)", "4.9", "14.1"); admitted and at batch 1 by 02:01:04Z; **ran through the rest of the window** and ended at 02:11:57Z | 0 | "==> build: OK — 473 of 473 batches, 3 module(s) rebuilt, 0 module(s) with warnings, 10m53s", "EXIT=0" |
| a run of the wrapper's `--plant` at the prompt (a Python reader of text files), a commit, a push | about 02:00Z | 0 | "plant: PASS" (re-run by the final pass: the same eight lines) |

The planted build is a control with a fault in it and is evidence of nothing but the lint's red; **the three modules it
compiled (`OuterAdj` with the plant, `Empty`, `Proofs`) were each compiled again by the final pass**, which started after the
window, so no artifact written during the window is in the tree the gate read: every other module was up to date and untouched
by that build. Nothing failed in the window; no step needed a re-run for it.

| step | result, read from its saved log (`data/fs131/l8a/gate/`, tag `final`) | log |
|---|---|---|
| build | "build: OK — 473 of 473 batches, 3 module(s) rebuilt, **0 module(s) with warnings**, 9m5s" (`OuterAdj`, `Empty`, `Proofs`: the restore after the lint control); lines holding "warning" in the build log: 1, that sentence; in Lake's full log: 0. The first pass, on an untouched build: "all 1843 modules already up to date, nothing built, 0 module(s) with warnings" | `build-final.log`, `receipt-build-final.log`; `build-first.log` |
| `sorry` | narrow pattern (`^\s*sorry\s*$`, `:= sorry`, `by sorry`): **0** lines; `\bsorry\b`: 8, all prose, the eight `main` holds, file and line (the wave's two lines of prose were corrected in stage 4) | `sorry-narrow-final.txt`, `sorry-wide-final.txt` |
| doubled names, **after the build and before the audit** | "dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)" | `dupnames-final.log` |
| its self-test (`--mem 4 --cpus 4`) | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-final.log` |
| axioms | "audited: **6554 records — 6521 clean on the standard axioms, 20 axiom-free, 8 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "declared imports (1): HadwigerNelson.StandingFive.kloosterman_bound"; "library axioms other than native auxiliaries: 1, every one declared"; "axioms: OK". Against `main`'s receipt: 220 rows added, none removed. `CLAUDE.md` § Trust ledger flagged stale, "6304 clean → 6521" (draft 1) | `axioms-final.log`, `receipt-axioms-final.log`, `digest-axioms-final.txt` |
| its self-test | "OK — every planted fault fired, and every partner passed." (23 controls; `scripts/axioms-controls.txt` untouched: no control's expected count moved) | `axioms-selftest-final.log` |
| **every record of the wave registered and within the standard three** | records: "main: 9513 theorems; landing: 9744; wave (landing only): 231 = 220 hand-written + 11 generated with no record asked; gone (main only): 0; records in the log: 6554"; "wave records on exactly the three: 215", "on fewer: [Quot.sound, propext]: 2", "on none: 3"; **all 72 heads "exactly the standard three"**; "whole log: records under IMPORTED 8; records carrying the import 8; records listing Falconer's lemma as an axiom 0"; "records: PASS". Registration: "hand-written 220; with a record 220; MISSING 0; STALE 0", "FOREIGN-MODULE 0" | `records-final.txt`, `register-final.txt` |
| their plants | records `--plant`: exit 1, **"plants fired: 7 of 8 NOT FIRED: ['IMPORT-RECORD …circle_sum_le_weil']"** — the eighth plant strips the import from a record of `main`, and this tool reads a record's axioms only for the landing's own theorems, which hold none of the eight: unreachable on a landing that brings no imported theorem (that state is the audit's own to refuse, under its IMPORTED rule). Registration `--self-test`: MISSING fired, STALE fired | `records-plant-final.txt`, `register-selftest-final.txt` |
| this job's receipt, from the compiled modules | "220 records in 8 blocks — 215 on exactly the standard three, 5 on a proper subset, 0 bad; 329 theorems in 12 modules (230 hand-written, 99 generated; 10 hand-written with no record in the eight blocks), 0 bad" — no `sorry` beneath any; the 5 are the two kernel tables and `SemiKind`'s three; the 10 are `IsStar4`'s fields, theorems to the kernel that the lister counts generated. The control prints `['sorryAx']`; with `--fault`, exit 1 naming it. The sibling's tool: 29 of 29, none resting | `l8a-axioms-final.txt`, `l8a-axioms-fault-final.txt`, `i8d-axioms-final.txt` |
| vacuity | "scanned: **declarations=14807 refutations-skipped=215**"; "sites: **sites=1446 vacuous=0 stale=0 declared=3 witnessed=38 generic=1403 unknown=2**"; "vacuity: OK"; the baseline's header "match (9 of 9 compared)"; `CLAUDE.md` § The gate flagged stale on four counts (draft 3). Against `main`'s scan, row for row: "main rows 1350, landing rows 1527; lost 0; added 177" — GENERIC on `Valid` 82, `NonSiamese` 52, `IsChangePoint` 23, `IsRingArc` 14, `IsHub` 5, `Simple` 1; "by module: declarations +306, refutations +16: equal to the scans difference"; "vacdiff: PASS" | `vacuity-final.log`, `receipt-vacuity-final.log`, `digest-vacuity-final.txt`, `vacdiff-final.txt` |
| its self-test, and the diff's plants | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent."; vacdiff `--plant`: exit 1 — COUNTER-DISAGREES, LOST, NOT NEW, FLAGGED, MODULE-SUM | `vacuity-selftest-final.log`, `vacdiff-plant-final.txt` |
| assumptions | "assumptions: OK — 1 outside theorem(s) as axioms, with 8 theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1"; `=== TOTALS === axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 … conditions=35 … silent=1 … cohyp=58 hints=0 unseen=16035 fails=0`; **both recorded sources "match (9 of 9 compared)"** — the front page's nine are not stale. Against `main`'s receipt the only rows added are the two `CONDITION` rows | `assumptions-final.log`, `receipt-assumptions-final.log`, `digest-assumptions-final.txt` |
| its self-test | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent." | `assumptions-selftest-final.log` |
| architecture | "RESULT: PASS" | `arch-final.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!"; its control red between the passes (above) | `lint-final.log`; `../lint-plant.log` |
| notes | `tools/fs131_l5_notes.py --only-flagged`: "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", **0 CONFLICT** — `main`'s count: the check reads the modules of QA4's audit, none of them the wave's; `tools/fs131_qa4_notes.py --self-test`: "OK (6 controls, 1 planted)" | `notes-l5-final.txt`, `notes-qa4-selftest-final.txt` |
| every theorem of the twelve modules as the kernel holds it | "records read: 241 …; generated by Lean, not compared: 24; compared with their files: 217"; no MISSING-BINDER; "ABSENT inst/term 62 (reviewed 62, not reviewed 0)"; "kernel-signatures: PASS"; the reviewed list regenerated on this commit is the committed one (`cmp`). `--plant`: eight of eight behave — three false exemptions refused, a true field exempted; a hypothesis of `emptyNS` dropped from the kernel's record (MISSING-BINDER); `variable (hplant : (1 : Nat) = 1)` in scope of `OuterAdj` (ABSENT term on 6 of 6 theorems); a head with no record (NO-RECORD); `Empty`'s `{F : ArcMap k}` INCLUDED in 13 theorems and ABSENT in 7 | `kernel-sigs-final.out`, `kernel-sigs-read-final.txt`, `kernel-sigs-table-final.txt`, `kernel-sigs-plant-final.txt` |
| the docstring corrections, all eleven | text against the merge of `main`, `1171c25b`: "files=3 doc-comments-changed=11 failed=0"; elaborated, the twelve modules against the dump taken before any edit: "before=398 after=398 (theorems before=329) missing=0 added=0 changed=0", IDENTICAL (so the lint's plant left no constant behind either) | `docstring-text-final.txt`, `sigs-final.txt`, `docstring-elaborated-final.txt` |
| the census | 19 formers; byte-identical to stage 5's | `census-final.out` |

**Read aloud against the informal claim.** The claim of this landing: "wave 8's first two planning passes are in the kernel
on the standard three, with no assumption". What the gate shows: the 220 hand-written theorems of the twelve modules each have
one record under CLEAN on a subset of `[propext, Classical.choice, Quot.sound]`, with no `sorry` beneath any theorem of those
modules, no name declared twice (so each stored list is the list of the proof the kernel checked), and no hypothesis standing
for an unproved result — by the assumptions step for the forms it can find, and by a reading of all 347 doc comments for the
one it cannot. What it does not show, and the docstrings say: that the hypotheses of the star rows, the semi-hub rows,
`outerAdj`, `doubleTip` and `emptyNS` hold together on any object — no Lean model of any (drafts, item 8). `emptyNS` read
aloud: *no valid non-Siamese six-coloured map whose domain holds the closed unit disc about `p`, with at least four colours at
`p`, has a ring about `p` no sub-arc of which lies in `Γ`* — the row's sentence ("No non-Siamese … valid six-coloured fragment on
a closed disc of radius above 1 about a vertex of at least four colours has a ring carrying no arc of Γ"), with *simple*
removed by FS129-SR3 and "radius above 1" read as `F.Covers p 1` (`covers_one_iff`).

**Token count at this stage**: no reading of the harness's count; my own estimate is about 520k — past the brief's guidance,
inside its hand-back line; what is left is the landing and the report.

## Drafts for the front page (FS131-L8A)

*For the coordinator to file; nothing here is filed by this job. Each names its slot and the log line it comes from. The gated
commit is `126bff4d`; its logs are `data/fs131/l8a/gate/*-final.*` (`receipt-axioms-final.log`, `receipt-vacuity-final.log`,
`receipt-assumptions-final.log` are the three scans' full outputs).*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence** (slot: "the current audit reads 6304 clean and 5 declared purchases, and 8
imported (and 17 axiom-free; 6,334 records at wave 10's second landing, FS131-L10B, 2026-10-06)") — from `axioms-final.log`,
"audited: 6554 records — 6521 clean on the standard axioms, 20 axiom-free, 8 imported (resting on a declared outside theorem), 5
declared purchase(s)":

> the current audit reads 6521 clean and 5 declared purchases, and 8 imported (and 20 axiom-free; 6,554 records at wave 8's first
> landing, FS131-L8A, 2026-10-06)

The 220 records the landing adds: 215 on exactly the standard three, 2 on `[propext, Quot.sound]` (the kernel tables
`V6Count.table`, `V6Count.doublesTable`; counted clean), 3 axiom-free (`SemiKind`'s generated theorems). 6304 + 217 = 6521;
17 + 3 = 20. Imported and purchases do not move; the library still declares one axiom.

**2. `CLAUDE.md` § Trust ledger, the nine assumption counts — no change.** `receipt-assumptions-final.log`, `=== TOTALS ===`:
`axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — the paragraph "What the library assumes, in
both forms" stands as filed, its "98 (hypothesis, statement) pairs by 51 statements" included; the digest reads both recorded
sources "match (9 of 9 compared)". Wave 8 brings no assumption in either form. (If the paragraph is to say so: "wave 8's first
landing, FS131-L8A, brought none".)

**3. `CLAUDE.md` § The gate, the vacuity scan's two count lines** (slot: "`declarations=14501 refutations-skipped=199 sites=1269`,
`vacuous=0 stale=0 declared=3 witnessed=38 generic=1226 unknown=2`.") — from `vacuity-final.log`, "scanned: declarations=14807
refutations-skipped=215", "sites: sites=1446 vacuous=0 stale=0 declared=3 witnessed=38 generic=1403 unknown=2":

> `declarations=14807 refutations-skipped=215 sites=1446`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1403 unknown=2`.

The baseline's two entries are unchanged. Until this is filed the scan flags `CLAUDE.md` § The gate stale (not failed), on four
counts: declarations, refutations-skipped, sites, generic.

**4. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`** — one entry after the last (`(("6148", "5"), ("6304", "5"))`):

```python
    (("6304", "5"), ("6521", "5")): "FS-131, wave 8's first landing (FS131-L8A; copy data/fs131/l8a/gate/receipt-axioms-final.log, gated commit 126bff4d): 6,554 records, 6,521 clean, 20 axiom-free, 8 imported, 5 purchases",
```

The previous landing's receipts, against which the three digests were taken: `data/fs131/lt5/gate/receipt-axioms-landed2.log`,
`receipt-vacuity-landed2.log`, `receipt-assumptions-landed2.log`.

**5. `LEAN.md` § The gate, a sentence in the vacuity bullet** (slot: after "`DECLARED` (deliberate emptiness, named with its reason
in the docstring as `VACUITY DECLARED:` and printed every run)"; the coordinator's ruling of 2026-10-06 on `v6_hubs`, in my words):

> **The marker is for a declaration one of whose binders has a provably empty carrier**; the scan reads it binder by binder, and on
> a binder whose carrier is not empty it reads `STALE` and fails. A route lemma whose hypotheses are *jointly* unsatisfiable — each
> satisfiable alone — does not carry it: its docstring says the joint vacuity in words and names the theorem that derives `False`
> from its exact hypotheses (`v6_hubs` with `v6_hubs_vacuous`, FS131-L8A). A statement that concludes `False` is skipped as a
> refutation, so a marker on it is never read and proves nothing either way.

And `plans/FS131-kernel-plan.md` § 7.3 item 5 (which asks the marker on route lemmas over an empty class) gets the same
clarification. **For the tooling job** (ruling 475 (d); filed by the coordinator's ruling as option (ii)): honouring a marker on
the evidence of a named theorem that refutes the declaration's exact hypotheses — joint emptiness as evidence — with its controls.

**6. `LEDGER.md` — the regrades, each [kernel] at this landing** (gated commit `126bff4d`; every declaration below is of
`HadwigerNelson.Plane.ArcMap` in `Proofs/HadwigerNelson/Plane/RingCalculus/` unless a namespace is given; **each rests on exactly
`[propext, Classical.choice, Quot.sound]` and on no assumption**: `records-final.txt` reads all 72 heads "exactly the standard
three", and the assumptions step lists no consumer among them). The implementers' and planners' drafts, gathered; what the join
changed is in bold.

- **Row 148** (the Γ-free four-colour vertex), slot: its grade and address — "[kernel] at the wider class of FS129-SR3-EMPTY-NS —
  non-Siamese, simple or not: `emptyNS` (`Empty.lean`). Its steps: `v6_hubs`, `v6_hug` (route lemmas over the empty class; jointly
  vacuous, refuted by `v6_hubs_vacuous`, `v6_hug_vacuous`), `v6_count` (a kernel table, `decide +kernel`, no native axiom),
  `exists_ne_mem_closure_inter_of_split`, `v6_anti`. No Lean object meets its hypotheses at a living parameter: the nine-colour
  model (`sq9Map`, five facts) is owed." (I8A's draft 2, with "VACUITY DECLARED" replaced by what the docstrings now say.)
- **Row 150** (two change points 60° apart), slot: after "share neither a sole tip" — "**both halves [kernel]**: the sole-tip half
  `doubleTip`, from `not_sole_tip_of_adjacent_changePoints` (`SoleTip.lean`), which reads no simplicity and no condition on the
  far germs; the sole-outer-colour half `outerAdj` (`Empty.lean`), from `not_sole_outer_of_adjacent_changePoints`
  (`OuterAdj.lean`), which reads at most two colours absent at `p` and never six. No Lean object has two change points 60°
  apart." (I8A's draft 3 said the second half was open; **closed by FS131-I8D and unconditional since the join**.)
- **§ B, FS129-SR3-EMPTY-NS, FS116-Y4-EMPTY, FS116-Y4-OBST** — kernel: `emptyNS`.
- **§ B, FS116-V6-HUBS** (grade cell "hand; one mind; true vacuously (FS116-Y4-EMPTY, held)") — "kernel: `v6_hubs`, with
  `ringPt_sixth_dist_le_one`; over the empty class (`v6_hubs_vacuous`)". **FS116-V6-COUNT** — "kernel: `v6_count`
  (`V6Count.count`, `HubCount.lean`: the kernel's check of 13⁴ quadruples), `exists_ne_mem_closure_inter_of_split`; finite
  combinatorics with no map in it". **FS116-V6-ANTI** — "kernel: `v6_anti`, class-free (any valid map), so not vacuous".
  **FS116-V6-HUG** — "kernel: `v6_hug`; not vacuous at the class its proof reads (`not_sole_tip_of_adjacent_changePoints`: no
  Γ-free ring)". **FS116-V6-ADJ** — carried by FS129-SR3-OUTERADJ, below.
- **§ B, FS129-MR1-DOUBLETIP** — kernel: `doubleTip` (its hypotheses `hS`, `hv`, `hu` idle). **FS129-SR3-OUTERADJ** (grade cell
  "hand; one mind") — "kernel: `outerAdj`, from `not_sole_outer_of_adjacent_changePoints`; the argument reads at most two colours
  absent at `p`, never six" (I8D's draft 2).
- **§ B, FS116-RING-GERM** (l. 1423, "derived; held, two minds (the second blind)") — kernel, in tile form: `ringGerm_inward`,
  `ringGerm_outward` (no non-Siamese hypothesis in (ii)); its first clause and (iii) are wave 3's `germS_absent`, `germS_four`.
  **FS116-N2-STAR** (l. 1447) — kernel, whole: `star_coloursAt`, `star_absent`, `IsTip.coneAt_subset`, `star_outer_cone`,
  `star_flank`, `star_flank_interior`, `star_tip_nonempty`, `star_outer_nonempty`. **FS116-V5-OUT2** (l. 1491) — kernel, a
  citation: it is `star_outer_cone`, valid and non-Siamese only.
- **§ B, FS116-N2-RECIP** (l. 1448) — "kernel: `star_recip`, at a change point `y` of four colours (never a hub, never
  non-Siamese), `Covers p 2`" (I8A's draft 5). **FS116-N2-ANTI** (l. 1449, "derived; one mind") — "kernel: `star_anti`; *simple*
  read at the tiles of `p` only; with the row's *not claimed* case as two hypotheses (no other tile of `p` approaches `p` along
  `ψ ± 90°`: inventory item 568)" (I8B's draft 2).
- **§ B, FS116-V5-QCOL** (l. 1489, "hand; one mind") — "kernel, **all clauses but the one never stated**: `qcol_cw`, `qcol_ccw`,
  `qcol_inner_tile`, `ringArc_dist_le_one`, `IsTile.not_mem_closure_of_not_subset_ball`, `qcol_not_one_arc`,
  `GermOnQWith.exists_isRingArc_ccw`, `…_cw`; the clause "a (Q) arc holding u⁺ (v⁻) and not u⁻ (v⁺) ends at u (v)" was not
  stated in Lean and stays at its filed grade" (I8C's draft 2).
- **§ B, FS116-N3-PAIR** (l. 1484) — "kernel: `germPair_inner_ne`, `germPair_swap`; with no change point, no *simple*, any `k`".
  **FS116-V5-DICHO** (l. 1492) — "kernel: `germPair_dicho`, at a point of exactly four colours simple for the map, any `k`; its
  dichotomy clause for any two arcs of `Γ` on `ω(p)` whose side colours are carried at `p`, `ringArc_pair_eq_or_disjoint`".
  **FS116-N3-CONE** (l. 1483) — "kernel: (a) `ringTile_uMinus`, `…_vMinus`, `…_vPlus`, `…_uPlus` (no *simple*); (b) the four
  `germOnQ_bar_*`; (c) `closure_inter_subset_sphere`, `isRingArc_of_edge` ("is an arc of ω(w)" read as: `y` lies on an arc of `Γ`
  on `ω(w)` with those side colours), `four_le_of_bothKind` (with `w ∈ dom` and *simple* at `w`)". **FS116-N3-STAR2** (l. 1485) —
  "kernel: `exists_isStar4`, `ringArc_star`, `fullSemiHub_star_crossed`, `fullSemiHub_star_parallel`; at exactly four colours;
  the row's "full semi-hub of kind O" read as its two arcs".
- **§ B, FS116-N3-CROSS** (l. 1487, "derived; held on every clause but the last (one mind and a checking reading)") — "**kernel,
  every clause, the last included, and unconditional since the join**: `crossed_no_tip` (with `crossed_tip_zeroAngle`),
  `crossed_outer`, `crossed_four`, `crossed_changePoint`, `crossed_semiHub` (`SemiHubPlaces.lean`); at a vertex of exactly four
  colours in the last three (`(F.coloursAt p).ncard = 4`, inventory item 592); the last clause reads neither the freedom of `y`'s
  outer pair nor *simple* at `y`". **FS116-N3-SEMI** (l. 1486) — "**kernel**: `semiHub_places`, both kinds, at exactly four
  colours". **FS116-RING-TRANSFER-QC** (l. 1488) — "**kernel**, its first clause: `transferQC`". (I8D's draft 3 said "on the
  standard three once `…/SemiHub` holds no `sorry`": **it holds none; the fourteen records that rested on its leaves rest on
  nothing** — stage 2, item 3.)
- **No ledger row**: `fullSemiHub_star_parallel_T` (kernel; FS116-N3-STAR2's *not claimed* line excludes kind T; no held model) —
  a row is the deriver's to mint (ruling 597 (a)). `Plane/SimpleOn` (wave 7's foundation: `Simple.simpleOn`, `simpleOn_univ`,
  `SimpleOn.mono`, `simpleOn_ball_iff`) — kernel; definitions' lemmas, no row.

**`plans/LEAN-BACKLOG.md`** — the rows that are kernel at this landing, by their numbers there: 99 (FS116-N3-PAIR), 100
(FS116-N3-STAR2), 104 (FS116-RING-GERM), 105 (FS116-N2-STAR), 106 (FS116-N2-ANTI), 107 (FS116-N2-RECIP), 110 (FS116-N3-CONE),
111 (FS116-N3-CROSS), 131 (FS116-V5-OUT2), 132 (FS116-V5-QCOL — all clauses but one), 140 (FS116-V5-DICHO), 141 (FS116-N3-SEMI),
142 (FS116-RING-TRANSFER-QC, its first clause), 143 (FS116-V6-HUBS), 144 (FS116-V6-ANTI), 145 (FS116-V6-HUG), 146
(FS116-V6-COUNT), and the rows of FS129-SR3-EMPTY-NS and FS129-SR3-OUTERADJ (items 24 and 26 of its replacements list) and of
FS129-MR1-DOUBLETIP. Not kernel: FS116-N2-SIXRING, FS116-RING-TWIST-C (item 9).

**7. Errata — the rows the wave found wider or narrower than filed, each with the Lean name that shows it** (the deriver's files;
drafts only).

*Wider than filed (generalizations):*
- FS116-V6-HUG, FS129-MR1-DOUBLETIP — no Γ-free ring, no simplicity, no condition on the far germs, any `k` with at most two
  colours absent: `not_sole_tip_of_adjacent_changePoints`. Not restated at this landing (ruling 598 (b)): `v6_hug`, `doubleTip`
  keep their statements beside it.
- FS129-SR3-OUTERADJ — any `k` with at most two colours absent at `p`, no simplicity: `not_sole_outer_of_adjacent_changePoints`.
  Its entry's wording "the only colour carried at y by a tile that is not a tile of p" is never met read literally; read as
  `O_y = {c} = O_y′` (`plans/FS129-derivation.md` l. 795; inventory item 518).
- FS116-N2-STAR — the flank clause for any tile of any valid map at any point and direction: `star_flank`. FS116-RING-GERM (ii)
  and STAR's outer-tile clauses — no non-Siamese hypothesis: `ringGerm_outward`, `star_outer_nonempty`.
- FS116-N2-RECIP — a change point of four colours, never a hub, never non-Siamese: `star_recip`.
- FS116-V6-ANTI — class-free: `v6_anti`. FS116-V6-COUNT — finite combinatorics with no map: `v6_count`; its last step by a
  connected circle, no sectors: `exists_ne_mem_closure_inter_of_split`. FS116-V6-HUBS reads no finiteness of the ring's Γ points:
  `v6_hubs`. `emptyNS` reads one conjunct of the count.
- FS116-V5-OUT2 — valid and non-Siamese only: `star_outer_cone`. FS116-V5-QCOL's carried-colour clause — Siamese pairs allowed:
  `qcol_cw`, `qcol_ccw`; its one-arc clause — no change point: `qcol_not_one_arc`.
- FS116-N3-PAIR — no change point, no *simple*, any `k`: `germPair_inner_ne`, `germPair_swap`.
- FS116-V5-DICHO — its dichotomy clause (the two colour pairs equal as sets, or disjoint) for any two arcs of `Γ` on `ω(p)` whose
  side colours are carried at `p`: `ringArc_pair_eq_or_disjoint`. **Its parenthesis (inner and outer exchanged) does not
  generalize**: it reads the two germs' position (`germPair_swap`); FS116-N3-PAIR's *not claimed* line stands.
- FS116-N3-CONE (c) — the two tiles need not be assumed distinct: `isRingArc_of_edge` (its `hne` is not read). (a) — no *simple*:
  the four `ringTile_*`.
- FS116-N3-CROSS — its last clause holds at a closed change point: `crossed_semiHub` reads neither `ho` nor *simple* at `y`; its
  first clause is true in the stronger form "no tile of `p` has `y` in its closure": `crossed_no_tip`. Its minds line: "the last
  clause: kernel-checked (FS131-I8D), the stall of V5's blind verdict closed by the disjoint cones of the two side classes at `y`
  (`crossed_not_germOnQ_inside`)".
- Class-free lemmas the plans listed and the library did not hold: `GermIn.tangent_mem_coneAt` (a germ of `ω(p)` approaches its
  ring point along the tangent), `IsRingArc.inner_ne_outer`.

*Narrower than filed:*
- FS116-N2-ANTI — its *not claimed* case ("anything when an edge of p leaves at ψ + 90° or ψ − 90°") is two hypotheses of
  `star_anti` (`hp''`, `hm''`): the interior of a cone that is every direction does not give it (inventory item 568). Slot: after
  "let ψ + 90° and ψ − 90° lie in the interiors of the cones at p of tiles t⁺ and t⁻".
- FS116-N3-STAR2, FS116-N3-CROSS (its last three clauses), FS116-N3-SEMI, FS116-RING-TRANSFER-QC — "at least four colours" at `p`
  is **exactly four** in the kernel: `(F.coloursAt p).ncard = 4` in `fullSemiHub_star_crossed`, `…_parallel`, `crossed_four`,
  `crossed_changePoint`, `crossed_semiHub`, `semiHub_places`, `transferQC`. At a change point two colours are absent
  (`germS_absent`: `ncard + 2 = k`), so "at least four with at most two absent" is four only at `k = 6` (inventory item 592): for
  the rows' six-coloured fragments nothing is lost; the Lean statements over a general `k` say it.
- FS116-N3-CONE (c) — `four_le_of_bothKind` takes `w ∈ dom` and *simple* at `w` as hypotheses.
- FS116-N2-RECIP — the statement does not say the two tiles hold the directions `ψ ∓ 90°` (the planner's record).
- FS116-N3-STAR2's *not claimed* line: the parallel star of kind T is in the kernel (`fullSemiHub_star_parallel_T`), with no held
  model.

*Corrections to the plans (the planners' record; notes, no edit by this job):* `plans/FS131-w8-kernel-plan.md` § 9.4 A1 is false as
written — "…outside `B̄(p, 1)`, outside `B̄(y′, 1)` **and outside `B̄(v, 1)`**…; the arc of `ω(y′)` from `y` away from `p` is
outside `B̄(v, 1)` (`one_lt_norm_e_add_e_sub_e`)"; § 8.4's table of DICHO's one-shared-colour cases was not checked by the kernel
(the proof took another route): neither confirmed nor refuted; its route for `v6_hug` lacks a step (a second arc tangent at the
tip's edge), not taken; C1 was landed (wave 3's `exists_lift_of_Icc_subset_angleIcc`); two children it priced are landed lemmas
(`IsRingArc.disjoint_coneAt`, `exists_mem_coneAt_region`).

**A stub line** (`plans/FRONTIER-STUBS.md`, under FS-124's residues; ruling 568 (c)): "can a tile of a four-colour vertex have every
direction in its cone, with two antipodal hubs? (the case `star_anti` excludes by hypothesis; neither excluded nor constructed)".

**8. The open gate items at this landing, by name** (each said in the docstrings it concerns; none is an assumption, none is seen
by the vacuity scan, which reads these theorems `GENERIC` binder by binder):

| owed | the theorems whose hypotheses no Lean object is known to meet together | held by hand |
|---|---|---|
| **`emptyNS`'s model at a living parameter**: `sq9Map : ArcMap 9` with `Valid`, `NonSiamese`, `Covers` at a lattice vertex, four colours there, `GammaFreeRing` there (ruling 530 (c)) | `emptyNS` (a refutation at six colours; without the model nothing shows its five hypotheses hold together anywhere), and with it `v6_hubs`, `v6_hug`, `v6_count`'s use | SQ9's lattice vertex |
| **a Lean star** (`IsStar4`; `quadRing` at `0` is the candidate, about 150 lines) | `ringArc_star`, `fullSemiHub_star_crossed`, `fullSemiHub_star_parallel`, `ringArc_pair_eq_or_disjoint`, `germPair_dicho`, `IsStar4`'s lemmas (`exists_isStar4` proves one exists at a four-colour point simple for a valid non-Siamese map; no such point is a Lean term) | the strip's `P₀`, the bowtie's centre |
| **a Lean semi-hub**, and a full one | `semiHub_places`, `transferQC`, `crossed_no_tip`, `crossed_outer`, `crossed_four`, `crossed_changePoint`, `crossed_semiHub` | the strip's `P₀` at `P₂` (crossed), the bowtie's centre at `top` (parallel); `semiHub_places`' second and third alternatives have no held model (the third is SEMI-PAR3's open question) |
| `fullSemiHub_star_parallel_T` | itself | **no held model at all** (no held semi-hub of kind T) |
| **two change points 60° apart** | `outerAdj`, `not_sole_outer_of_adjacent_changePoints`, `doubleTip`, `not_sole_tip_of_adjacent_changePoints`, `v6_hug` | **held by no fragment**; satisfiability open (FS-124) |
| **a change point of a four-colour vertex with two colours absent** (wave 7's bowtie, as for wave 3's rows) | `ringGerm_inward`, `ringGerm_outward`, the `star_*` rows, `star_recip`, `star_anti`, `qcol_cw`, `qcol_ccw`, the four `ringTile_*` | the bowtie's top, the strip's `P₂` |
| a named `example` of `isRingArc_of_edge`'s hypotheses; a Lean `example` of one of `v6_count`'s 72 configurations | those two | `quadRing`; the exact tool's 72 |

Paid at this wave: the class of `StarChart`'s lemmas (`halfDisc` at `0`: valid, non-Siamese, simple, two colours); `GammaFreeRing`
at `halfPlane2`, `0`. **Standing from earlier landings and unchanged**: `Plane.NoPar`'s docstring (the assumptions step's one
`SILENT` row), and the open gate items of FS131-L6A's and FS131-L10A's drafts. **Docstrings owed, not made** (outside the doc
comments my touches name): `v6_hubs_vacuous`'s and `v6_hug_vacuous`'s docstrings and their section title in `Empty` still say "the
marker" for what the two docstrings now say in words; the block comments of "FS131-K8" and "FS131-K8b" in `scripts/Axioms.lean`
say their open leaves "join this block" (they joined the implementers' blocks).

**9. What a third planning pass (FS131-K8c) still has to state — two rows and one clause.**
- **FS116-N2-SIXRING** (`LEDGER.md` § B l. 1445, "derived; one mind"): not stated. What it starts from: the first pass's
  disposition; `ringArc_dist_le_one` gives "each arc is at most 60°" for its covering step, and its clause "cone at p in
  `[α + 60°i − 30°, α + 60°i + 90°]`" is `ringArc_cone_inner` on the tile's arc (`plans/FS131-w8-kernel-plan.md` § 9.7). The
  covering step is unpriced.
- **FS116-RING-TWIST-C** (l. 1421): not stated; designed (§ 9.7) so that it and wave 7's `ring_odd` are one theorem and a
  corollary at the join: `twistC_four`, the colour off a finite set and its swap, a new word *colour change*, and the last clause
  in `ring_odd`'s own shape. Its first clause and L1 are landed (`ringD`, `finite_ringD_off_ringArc`,
  `IsRingArc.not_mem_closure_third`).
- **FS116-V5-QCOL's clause** "a (Q) arc holding u⁺ (v⁻) and not u⁻ (v⁺) ends at u (v)": never stated in Lean (no consumer: the two
  sub-arc lemmas stand in for its uses); it stays at its filed grade (ruling 597 (c)).

**At the joins with the other waves** (for their landings; nothing is discharged there): `qcol_inner_tile` and wave 7's
`qArc_inner`'s first clause are one lemma under two names; `simpleOn_not_hasRepeatedColour` (`SemiHub`) has the statement of wave
9's leaf `not_hasRepeatedColour_of_simpleOn` (`Plane/Classes/QFree`) — one becomes a one-line corollary; `four_le_of_bothKind` and
wave 7's `IsTacticAt.four_le_centre` share that child; FS116-RING-TWIST-C's last clause is `ring_odd`'s corollary. **`Plane/SimpleOn`
is on `main` from this landing**: waves 7 and 9 hold the same blob and meet it as their own file.

**10. `CLAUDE.md` § Frontier.** No change of state: FS-131 stays open. A line, if one is wanted where the landings are listed:
"wave 8's first two planning passes are on `main` through the full gate (FS131-L8A, 2026-10-06): the ring calculus in the
non-Siamese class — row 148 at its wider class (`emptyNS`) and both halves of row 150 (`doubleTip`, `outerAdj`) in the kernel, with
the star, germ, cone and semi-hub rows of FS-116; twelve modules, 220 records, no assumption; two rows and one clause left for a
third pass; no Lean model yet of a star, a semi-hub, two adjacent change points, or `emptyNS`'s class at nine colours."

**11. Proof Atlas grade changes** — to [kernel]: FS129-SR3-EMPTY-NS, FS116-Y4-EMPTY, FS116-Y4-OBST, FS116-V6-HUBS, FS116-V6-HUG,
FS116-V6-COUNT, FS116-V6-ANTI, FS116-V6-ADJ (through FS129-SR3-OUTERADJ), FS129-SR3-OUTERADJ, FS129-MR1-DOUBLETIP,
FS116-RING-GERM, FS116-N2-STAR, FS116-N2-RECIP, FS116-N2-ANTI (with its two hypotheses), FS116-V5-OUT2, FS116-V5-QCOL (all clauses
but one), FS116-N3-PAIR, FS116-V5-DICHO, FS116-N3-CONE, FS116-N3-STAR2 (at exactly four colours), FS116-N3-CROSS, FS116-N3-SEMI,
FS116-RING-TRANSFER-QC (its first clause); rows 148 and 150. Each with the scope of item 6.

**12. Two notes for `LEAN.md` § Searching — Lean / § The gate** (drafts).
- "A `Prop`-valued `structure`'s fields and an enumeration's `sizeOf_spec` / `ofNat_ctorIdx` are theorems to the kernel with no
  text of their own: the audit's generated-name pattern does not know them (register them, or identify them in the file before
  exempting them — `tools/fs131_l8a_kernelsig.py`), and `data/fs131/l5/count-modules.lean` counts the fields `GEN` and the
  enumeration's three `THM`."
- "Name a merged commit by its hash in every check, never by `origin/main`: the worktrees share one set of refs, and another job's
  fetch moves the ref between two runs of a check (FS131-L8A: a merge-index check compared the index with a commit that was not
  the one merged)."

## Theorems this phase proved, final

**This job proved none; it landed these.** [kernel] at the gated commit `126bff4d`, each a declaration of
`HadwigerNelson.Plane.ArcMap` in `Proofs/HadwigerNelson/Plane/RingCalculus/` unless a namespace is given, **each on exactly
`[propext, Classical.choice, Quot.sound]`** (`data/fs131/l8a/gate/records-final.txt`: 72 heads, each "exactly the standard
three") **and on no assumption** (`receipt-assumptions-final.log`: none is a `RESTS`, `TAKES` or `MENTIONS` row). Proved by the
jobs named; read against their rows in those jobs' records; read from the kernel against their files in stage 5.4.

- **FS129-SR3-EMPTY-NS** (carrying FS116-Y4-EMPTY, FS116-Y4-OBST; `LEDGER.md` row 148 at its wider class) — `emptyNS` (`Empty`;
  FS131-I8A): `{F : ArcMap 6}`, `F.Valid`, `F.NonSiamese`, `F.Covers p 1`, `4 ≤ (F.coloursAt p).ncard`, `F.GammaFreeRing p` ⊢
  `False`. With `v6_hubs_vacuous`, `v6_hug_vacuous`.
- **FS116-V6-HUBS** — `v6_hubs`, `ringPt_sixth_dist_le_one`; **FS116-V6-COUNT** — `v6_count`,
  `exists_ne_mem_closure_inter_of_split` (`V6Count.table`, `V6Count.doublesTable` on `[propext, Quot.sound]`: the kernel's own
  evaluation); **FS116-V6-ANTI** — `v6_anti` (FS131-K8); **FS116-V6-HUG** — `v6_hug`; **FS129-MR1-DOUBLETIP** — `doubleTip`;
  both from `not_sole_tip_of_adjacent_changePoints` (`SoleTip`) (FS131-I8A).
- **FS129-SR3-OUTERADJ** (carrying FS116-V6-ADJ; with DOUBLETIP, both halves of row 150) — `outerAdj` (`Empty`), from
  `not_sole_outer_of_adjacent_changePoints` (`OuterAdj`) (FS131-I8D).
- **FS116-RING-GERM**, tile form — `ringGerm_inward`, `ringGerm_outward`; **FS116-N2-STAR** — `star_coloursAt`, `star_absent`,
  `IsTip.coneAt_subset`, `star_outer_cone` (which is **FS116-V5-OUT2**), `star_flank`, `star_flank_interior`,
  `star_tip_nonempty`, `star_outer_nonempty` (`Basic`, `Star`; FS131-K8).
- **FS116-N2-RECIP** — `star_recip` (FS131-I8A); **FS116-N2-ANTI** — `star_anti`, with `star_anti_ne` (`Star`; FS131-I8B, at
  the statement of inventory item 568).
- **FS116-V5-QCOL**, all clauses but the one never stated — `qcol_cw`, `qcol_ccw`, `IsTile.not_mem_closure_of_not_subset_ball`
  (FS131-K8b), `qcol_inner_tile`, `ringArc_dist_le_one`, `qcol_not_one_arc`, `GermOnQWith.exists_isRingArc_ccw`, `…_cw`;
  **FS116-N3-PAIR** — `germPair_inner_ne`, `germPair_swap`; **FS116-V5-DICHO** — `germPair_dicho`,
  `ringArc_pair_eq_or_disjoint`; **FS116-N3-CONE** — `ringTile_uMinus`, `…_vMinus`, `…_vPlus`, `…_uPlus`, `germOnQ_bar_uPlus`,
  `…_vMinus`, `…_uMinus`, `…_vPlus`, `closure_inter_subset_sphere`, `isRingArc_of_edge`, `four_le_of_bothKind`;
  **FS116-N3-STAR2**, at exactly four colours — `exists_isStar4`, `ringArc_star`, `fullSemiHub_star_crossed`,
  `fullSemiHub_star_parallel`; and, with no row, `fullSemiHub_star_parallel_T` (`SemiHub`; FS131-I8C).
- **FS116-N3-CROSS**, every clause — `crossed_no_tip`, `crossed_tip_zeroAngle`, `crossed_outer`, `crossed_four`,
  `crossed_changePoint`, `crossed_semiHub`; **FS116-N3-SEMI** — `semiHub_places`; **FS116-RING-TRANSFER-QC**, its first clause —
  `transferQC` (`SemiHubPlaces`; FS131-I8D, at the statements of inventory item 592).
- The shared lemmas (`StarChart`; FS131-I8B): `HadwigerNelson.Plane.exists_int_of_angleIcc_subset`, `mem_closure_tile_of_near`,
  `ncard_tileAt_eq`, `IsSectorChart.tileAt_equiv`, `exists_sectorChart_tileAt`, `exists_initialPiece_of_ncard_le_three`.
- Wave 7's foundation (`Plane/SimpleOn`; FS131-K7): `Simple.simpleOn`, `simpleOn_univ`, `SimpleOn.mono`, `simpleOn_ball_iff`.

The whole landing: twelve modules, 306 declarations, 231 theorems (220 hand-written, each with one record; 215 on exactly the
standard three, 2 on `[propext, Quot.sound]`, 3 axiom-free). The audit: 6,554 records — 6,521 clean, 20 axiom-free, 8 imported,
5 declared purchases; one library axiom, `StandingFive.kloosterman_bound`, on which nothing of this wave rests.

## Slips, my own

1. **A check run against a ref that moved** (stage 3): `origin/main` was moved by another job's fetch between two runs of the
   merge-index check, which then compared the index with a commit that was not merged. Caught by the check's own `WRONG-MERGE`
   line; every check of the stage re-run against the commit's hash.
2. **A fault's anchor that stood twice** (stage 2): my first plant in `SemiHubPlaces` matched two signatures; the instrument
   stopped with exit 2 as built, the anchor was made unique, the self-test re-run.
3. **A sleep longer than the harness's wait, twice**, moved to the background by the harness; nothing depended on it.
4. **No build at the merge of `main` alone** (stage 3): the queued build was stopped before the slot admitted it and one build
   was made at the next commit (doc comments and registry prose only). Said where it happened.
5. **The record was committed once while the first gate pass ran** (`fd37fa78`, `plans/` alone). The pass's head file names the
   commit it started on; no step reads the record. The final pass ran on a commit that did not move under it.
6. **The marker in `v6_hug`'s new docstring**: both reworded docstrings hold the two words of the scan's marker in backticks
   without its colon, as the ruled sentence does; a later edit that adds a colon there would bring the marker back. The edit
   script refuses a file in which the marker's string stands; nothing guards a later hand.
7. **One plant of another job's tool is unreachable on this landing** (stage 6, the records check: 7 of 8) and I did not make
   a reachable twin of it: the state it plants is the axiom audit's own to refuse.
8. No token count was read at any saved stage: I have no instrument for the harness's count, and wrote my own estimate each time.
