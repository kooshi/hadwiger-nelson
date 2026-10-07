# FS132-L2 — the landing: the first night's exclusion, with the outside lemmas ported under it, through the gate and onto `main`

*Record of the landing implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-L2-landing.md` on `main` at
`53ce5626`. Branch `fs132-wl2`, worktree `.claude/worktrees/fs132-wl2`, cut from `fs132-wi4` at `7e4e5d2a`. Working
files: `data/fs132/l2/`. Tools: `tools/fs132_l2_*.py`; other jobs' tools are run, never edited, except the two
generators the brief names (the port's, through which the generated modules change).*

## Theorems this phase proved

*Filled at the gate (the final list is at the end of this record, "Theorems this phase proved, final").* This job proves
no theorem of its own: it gates and lands the theorems of FS132-K1, -K2 (statements), FS132-I2 (the port), FS132-I3
and FS132-I4 (the leaves), listed in their records.

## Stage 1 — SAVED (FS132-L2): the readback, what was read, the branch built as given

### The brief's quotations

`tools/fs132_i1_quotes.py` (the import's checker, run unedited) on the brief, relative sources read under `main`'s
checkout (`--root /home/kooshi/source/lean-dir`) and absolute ones as given: **14 quotations, 0 mismatches**, exit 0
(`data/fs132/l2/quotes.out`). By source: `Orbit.lean` 3, `TwoPairs.lean` 1, `CLAUDE.md` 4, the inventory 4, `LEDGER.md` 1
(row 155, whole), the request file 1. Its self-test plants a changed word, a wrong source and an empty quotation: each
**FIRED**, exit 0 (`data/fs132/l2/quotes-selftest.out`). No finding about the brief.

### What was read

Whole: the brief; `plans/STANDING-RULES.md`; `LEAN.md` as on `main`; `RUNNING.md` § Building and § Make the gate fail,
and watch it fail; `Plane/SixRing/Orbit.lean`, `TwoPairs.lean`, `Basic.lean`; the planner's record Stages 4–5 and § 6.1,
§ 6.4, § 7.1 (`plans/FS132-kernel-plan.md` ll. 419–633, 692–700, 852–860); the port's record §§ 2.1–2.4, 3.1–3.6 and its
drafts D1–D7 (`plans/FS132-I2-implementation.md` ll. 104–456); FS132-I4's record, its list of theorems, stages 1–2 and
5–7 and its drafts D1–D7; FS132-I3's list of theorems and its four drafts; the last landing's record, stages 5–6
(`plans/FS132-L1-landing.md` ll. 258–476) and its runner `data/fs132/l1/run-gate.sh`; inventory items 40, 44, 46, 47.
In part: the planner's Stage 7 (its head and its close; the tiers of later claims are not this landing's).

### The branch as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`, at `7e4e5d2a`: **exit 0** — "build:
OK — all 1868 modules already up to date, nothing built, 2 module(s) with warnings, 3s"; **19 `declaration uses sorry`
warnings, all in two modules** — `Plane/SixRing/Winding` 16, `Plane/SixRing/CyclicCentre` 3
(`data/fs132/l2/build-0-as-given.log`; the count by `grep -c`, by module by `uniq -c`). The brief's count.

## Stage 2 — SAVED (FS132-L2): the cut

**Removed** (`git rm`): `Proofs/HadwigerNelson/Plane/SixRing/Winding.lean` (16 `sorry`; C132-INDEX, C132-RING-WIND) and
`Proofs/HadwigerNelson/Plane/SixRing/CyclicCentre.lean` (3; C132-CORES-FREE), with their two import lines in
`Proofs.lean` and their two rows in `ARCHITECTURE.md` (the rows as they stood: `data/fs132/l2/cut-architecture-rows.txt`).
They stay on the planner's branch `fs132-wk1` for their own jobs.

**No module imports them**: the two names occur in `Proofs/`, `Proofs.lean`, `scripts/`, `tools/`, `ARCHITECTURE.md` and
`lakefile.toml` only as the two import lines of the root file and the two rows, all four removed; after the cut the
search finds neither (the hits for the bare word `Winding` are `ThreeColour.Winding`, FS-75's structure). No block of
`scripts/Axioms.lean` names a declaration of either. Their orphaned compiled files, and the deleted placeholder
module's, are removed from this worktree's own build copy (16 files; `data/fs132/l2/cut-stale-artifacts.txt`), so the
build directory holds no module the source does not.

**Zero `sorry` in `Proofs/`**, by a search that sees one (`data/fs132/l2/sorry-after-cut.txt`, `sorry-plant.txt`): the
narrow pattern (`^\s*sorry\s*$`, `:= sorry`, `by sorry`) over `Proofs/` and `Proofs.lean` — **0 lines**; the wide one
(`\bsorry\b`) — 25 lines, every one prose in a docstring or a header ("no `sorry`", "sorry-free"; listed in the file).
**The plant**: a theorem with a `sorry` body appended to `Plane/SixRing/Excl.lean` (never built, never committed) —
narrow lines 1, "PLANT FIRED" at `Excl.lean:74`; restored by `git checkout`, the file's digest the one taken before,
the plant's name in the file 0 times, narrow lines 0 again.

**Built** (`data/fs132/l2/build-1-cut.log`): **exit 0** — "build: OK — 478 of 478 batches, 23 module(s) rebuilt, **0
module(s) with warnings**, 9m49s"; no `declaration uses sorry` line. *A slip of mine, said once*: I ran the two
generators (stage 4's (a) and (b)) while this build was walking its early batches, before it had reached any module
they write; so this build is of the cut **and** of the regenerated outside modules together — the 23 rebuilt are the
palette module, the eight ported modules, the thirteen of `Plane/SixRing` and the root. Green, so both hold; a red
build would have had to be separated. The rule it breaks is my own gait's: no source file is written while a build
of the tree is in flight.
