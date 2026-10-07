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
