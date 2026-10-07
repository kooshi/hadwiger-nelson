# FS124-L2 — the landing: the one-piece and close-pair statements, their witnesses and the three-arcs lemma, through the gate and onto `main`

*Record of the landing implementer (de Bruijn, Opus 5.5). Brief: `data/fs124/briefs/FS124-L2-landing.md` on `main` at
`2698f666`. Branch `fs124-wi3`, worktree `.claude/worktrees/fs124-wi3`, at `e33b5088` when this job began. Working
files: `data/fs124/l2/`. Tools: `tools/fs124_l2_*.py`; other jobs' tools are run, never edited. The record is written
in stages; each is committed before the next starts.*

## Theorems this phase proved

*The final list, with the gated commit and the axioms as the gate printed them, is at the end of this record
("Theorems this phase proved, final").* This job proves one leaf of its own, by the kernel planner's two lines —
`ThreePiece.IsSector.hasArcEdges` (`Plane/SectorPoint`) — and gates and lands the statements of FS124-K2 and FS124-K3
(planners) with the proofs of FS124-I2, -I3, -I4 and -I5 (implementers): the eight modules `Plane/CircleCrossing`,
`OnePiece`, `ThreePiece`, `ClosePair`, `ClosePairWitness`, `ClosePairModel`, `ThreeArcs`, `SectorPoint`.

## Stage 1 — SAVED (FS124-L2): the readback, what was read, the branch built as given, the merges tried

### The brief's quotations

`tools/fs132_i1_quotes.py` (FS132-I1's checker, run unedited) on the brief, relative sources read under `main`'s
checkout (`--root /home/kooshi/source/lean-dir`) and absolute ones as given: **25 quotations, 0 mismatches**, exit 0
(`data/fs124/l2/quotes.out`). By source: `Plane/OnePiece.lean` 5, `Plane/ClosePair.lean` 5, `Plane/SectorPoint.lean`
2 (in this worktree), `CLAUDE.md` 4, `LEDGER.md` 2 (rows 162 and 163, whole), `plans/FS124-close-inventory.md` 6, the
request file 1. Its self-test plants a changed word, a wrong source and an empty quotation: each **FIRED**, exit 0
(`data/fs124/l2/quotes-selftest.out`). No finding about a quotation.

**Two notes on the brief** (neither changes the job):
1. `main` has moved since the brief was written: `07bf6096` → `2698f666` (the brief's own regeneration) → `9febc276`
   (inventory item 49 and the handoff: `plans/`, two paths, nothing else).
2. The brief's item 2 lists eight modules to hold no `sorry`; `Plane/ClosePairWitness` is the third implementer's
   helper module (its row in the architecture file is that job's), so the count is eight, as listed.

### What was read

Whole: the brief; `plans/STANDING-RULES.md`; `LEAN.md` as on `main`; `RUNNING.md` § Building and § Make the gate
fail, and watch it fail; the last landing's record `plans/FS124-L1-landing.md` (ten stages, its drafts, its slips —
stage 8: the audit's self-test went red on the two controls that read the count of IMPORTED records). By section:
the planner's record `plans/FS124-kernel-plan-2.md` § 3.7 and § 4.6; the implementers' records —
`plans/FS124-I2-implementation.md` Stage 4 and its drafts, `plans/FS124-I3-implementation.md` § 3.3 and its drafts,
`plans/FS124-I4-implementation.md` Stage 4 (§ 4.1–4.5) and its drafts; on the other branch,
`plans/FS124-kernel-plan-3.md` § 3.1, § 4.4, § 4.5 and `plans/FS124-I5-implementation.md` Stage 4 and its drafts.
`CLAUDE.md` § Trust ledger and § The gate **from disk on `main`** (the copy loaded at launch is an older snapshot).

### The branch as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`, at `e33b5088`: **exit 0** —
"build: OK — all 1854 modules already up to date, nothing built, 1 module(s) with warnings, 3s"; **one `declaration
uses sorry` warning, `Proofs/HadwigerNelson/Plane/SectorPoint.lean:52:8` — the θ-leaf — and no other**
(`data/fs124/l2/build-0-as-given.log`).

### The two merges, tried before either is made

`git merge-tree --write-tree --name-only`, the branch tip `e33b5088` against each:

- **`origin/fs124-wk3` at `9af859b7`** (`data/fs124/l2/merge-trial-wk3.out`): exit 1, **one conflict —
  `ARCHITECTURE.md`** (each side added a row after the same row); `Proofs.lean` merges automatically. Against the
  merge base `fb515b25` that branch changes, outside `plans/` and `data/`: `ARCHITECTURE.md` (1 line), `Proofs.lean`
  (1 line), `Proofs/HadwigerNelson/Plane/ThreeArcs.lean` (new, 855 lines). **No conflict in a file under `Proofs/`.**
- **`origin/main` at `9febc276`** (`data/fs124/l2/merge-trial-main-before-join.out`): exit 1, **one conflict —
  `ARCHITECTURE.md`**; `Proofs.lean`, `scripts/Axioms.lean` merge automatically. The merge base is `80ee1983` (the
  first module's branch tip); since it `main` changes 24 paths under `Proofs/` (FS132-L2's 22 modules, its licence
  copy, the import module's licence sentence), `Proofs.lean`, 5 under `scripts/`, 9 under `tools/`,
  `ARCHITECTURE.md`, and the coordinator's files; this branch changes 7 under `Proofs/` (its seven modules),
  `Proofs.lean`, `ARCHITECTURE.md`, `data/`, `plans/`. **No conflict in a file under `Proofs/`**, as the brief's
  trial found. It is tried again on the joined tree before it is made (stage 2).

## Stage 2 — SAVED (FS124-L2): the join — the three-arcs branch merged, the leaf closed, `main` merged in

**The first merge**: `git merge --no-ff --no-commit 9af859b7dcf63899973c04b8ff3d00165e98940d` (the hash, never the
ref; `data/fs124/l2/merge-wk3.out`) — `Proofs.lean` merged automatically (the one import line of `Plane/ThreeArcs`
after this branch's seven); **one conflict, `ARCHITECTURE.md`, resolved by keeping both sides**: this branch's three
rows (`Plane/ClosePairWitness`, and the rows of `Plane/ClosePairModel` and `Plane/SectorPoint` with the imports cell
this branch gave them), then the other side's row of `Plane/ThreeArcs`. Checked by script before writing: the two
doubled rows differ between the sides in their imports cell only. **No conflict in a file under `Proofs/`.** Merge
commit `35704355`.

**The leaf** (`Proofs/HadwigerNelson/Plane/SectorPoint.lean`; `git diff` against the as-given file: 20 lines added, 10
removed): the import `Proofs.HadwigerNelson.Plane.ThreeArcs`; the body of `ThreePiece.IsSector.hasArcEdges` — the
`sorry` replaced by the kernel planner's two lines (`plans/FS124-kernel-plan-3.md` § 3.1), as written there:

```lean
  obtain ⟨r, hr, J, h1, h2, h3, h4, h5, -, h7⟩ := h
  exact fun i j hij => IsTriodCut.exists_arc ⟨⟨hr, h1, h2, h3, h4, h5⟩, D.isOpen_piece, D.isPreconnected_piece,
    fun _ _ hab => D.disjoint_piece hab, h7⟩ D.nbhd_mem hij
```

the spec example of its § 4.4 after `sectorPoint_isSector` — `example : sectorPoint.HasArcEdges :=
sectorPoint_isSector.hasArcEdges`, the lemma run on the model of its hypotheses; and two docstrings that the leaf's
closing makes false as written: the module header's title and its item on the leaf ("the θ-lemma is owed", "Owed as a
kernel job of its own") and the leaf's own docstring ("owed as a kernel job of its own") now say what the bridge rests
on — `IsTriodCut.exists_arc`, which half of the classical fact it proves, and that the definition's sixth clause is
not read. **No statement and no definition of the file is touched** (stage 3's kernel-side comparison).

**Built** (`data/fs124/l2/build-1-joined.log`): **exit 0** — "build: OK — 477 of 477 batches, 3 module(s) rebuilt, 0
module(s) with warnings, 8m44s" (`Plane.ThreeArcs`, `Plane.SectorPoint`, `Proofs`); lines holding "warning" in Lake's
full log: 0. **No `sorry` in the eight modules**: the narrow search (`^\s*sorry\s*$`, `:= sorry`, `by sorry`) over
`Proofs/` and `Proofs.lean` finds 0 lines; the word occurs in none of the eight files but in prose. The leaf and the
two theorems over it print the standard three (`data/fs124/l2/probes/checks-probe.out`: 26 prints, every one
`[propext, Classical.choice, Quot.sound]`) — on the as-given tree each of the three printed `sorryAx` (the third
implementer's controls). Commit `fb86127a` (the leaf), pushed to the branch.

**The second merge**, tried again on the joined tree (`data/fs124/l2/merge-trial-main.out`: the same one conflict)
and made by hash: `git merge --no-ff --no-commit a61ea9150aade8ebac38014a004bf4c732230232`
(`data/fs124/l2/merge-main.out`) — `main` had moved three commits past `9febc276` (FS-136's inventory and a brief:
`plans/` 2 paths, `data/` 2). `Proofs.lean` and `scripts/Axioms.lean` merged automatically; **one conflict,
`ARCHITECTURE.md`** — § 3.13's table, where `main` reworded the first module's three rows at its landing and this
branch added eight rows after them — **resolved by keeping both sides**: `main`'s three rows, then this branch's
eight. Checked: the resolved file differs from `main`'s by exactly eight added lines, and `Proofs.lean` from `main`'s
by exactly the eight import lines (316 import lines, none twice). **No conflict in a file under `Proofs/`.** Merge
commit `16cb9018`.

**Built** (`data/fs124/l2/build-2-merged.log`), with stage 3's docstring rewordings in the tree: **exit 0** — "build:
OK — 481 of 481 batches, 30 module(s) rebuilt, 0 module(s) with warnings, 10m15s". The thirty: the import module
(`main`'s licence sentence is a docstring, so it and everything downstream recompiled here — the nine ported modules,
the thirteen of `Plane/SixRing`, `Plane/RadiusOutside`), the five modules downstream of the reworded docstrings
(`Plane/ThreePiece`, `ClosePair`, `ClosePairWitness`, `ClosePairModel`, `SectorPoint`), and the root. The library is
1,877 modules: `main`'s 1,869 and the eight.

## Stage 3 — SAVED (FS124-L2): the registrations

**What the landing brings, as the kernel lists it** (`data/fs124/l2/decls.lean`, after FS124-L1's dumper; output
`data/fs124/l2/probes/decls-probe.out`): **558 constants in eight modules** — `Plane/CircleCrossing` 69, `OnePiece`
89, `ThreePiece` 99, `ClosePair` 51, `ClosePairWitness` 152, `ClosePairModel` 3, `ThreeArcs` 89, `SectorPoint` 6;
**405 declarations a person typed** — 340 theorems, 56 definitions, 9 structures and inductive types (38, 60, 72, 35,
136, 3, 55, 6 by module); the other 153 are the elaborator's (projections, constructors, recursors, `eq_1`,
`congr_simp`, `_proof_n`).

**One block of mine in `scripts/Axioms.lean`**, under CLEAN, after FS124-L1's block and above the PURCHASED banner:
headed "FS124-L2", generated from the kernel's list (`tools/fs124_l2_records.py DECLS --block`; the text is
`data/fs124/l2/audit-block.txt`), **405 records, one for every declaration a person typed**. Against the four
implementers' blocks (80, 91, 130, 51 = 352 lines, no name twice): every theorem and every definition of theirs is in
it but three lines of the third block, `labHi.congr_simp`, `labLo.congr_simp`, `planeMotion.congr_simp` — theorems
Lean generates on demand, which no author declares and which the last two landings' blocks do not file (`LEAN.md`
§ The gate: "reserved names"); and it holds 56 more — the three theorems of `Plane/SectorPoint` that rested on the
leaf (`ThreePiece.IsSector.hasArcEdges`, `.isFull`, `closePair_both_saved_of_isSector`), and **53 definitions,
structures and inductive types the implementers' blocks left out** (they listed theorems, and the three definitions
that hold proofs). **A decision of mine, and the count it moves**: my brief counts the implementers' records and
says "definitions that hold proofs are filed"; the last two landings filed every declaration, the coordinator's
ruling on the last one kept them ("a definition has axioms too", inventory item 40 (a)), and I hold this landing to
the same standard — so the audit gains **405 records, where the brief's count gives 355**.
`tools/fs124_l2_records.py … --unfiled`: "declarations the landing brings: 405 (of 558 constants in 8 modules); with
one line: 405; unfiled: 0; doubled: 0"; no name is printed twice in the whole script (7,420 `#print axioms` lines =
`main`'s 7,015 + 405). The IMPORTED section's prose is untouched: this landing files no record there.

**The audit on the registered tree** (`./scripts/axioms.sh` under the slot;
`data/fs124/l2/probes/axioms-probe.out`): exit 0 — "audited: **7420 records — 7364 clean on the standard axioms, 28
axiom-free, 23 imported** (resting on a declared outside theorem), **5 declared purchase(s)**". Against `main` (6967
clean, 20 axiom-free, 23 imported, 7,015 records): clean +397, axiom-free +8, records +405; imported and purchases do
not move. The digest reads `CLAUDE.md` § Trust ledger as stale ("6967 clean → 7364"), as it must until refiled.

**Each filed on what it rests on, read from the audit's own output** (`tools/fs124_l2_records.py`, this job's, on
the kernel's list and the audit's saved log; `probes/records-probe.txt`): "records: PASS" — "landing records on
exactly the three: 393", "on fewer: [Quot.sound, propext]: 1", "on fewer: [propext]: 3", "on none: 8"; each of the
twenty theorems the landing is for — the nine claims' ten theorems, `closePair_both_saved_of_isSector`, the bridge
and `IsSector.isFull`, `IsTriodCut.exists_opposite` and `exists_arc`, the four existence theorems and
`sectorPoint_isSector` — "under CLEAN: [Classical.choice, Quot.sound, propext]"; over the whole log "records
carrying kloosterman_bound: 8 (filed: 8); of the landing's: 0", "no_proper_five_coloring: 6 (filed: 6); of the
landing's: 0", "proper_to_borel_weak: 9 (filed: 9); of the landing's: 0"; "records under IMPORTED 23; carrying two
imports 0; carrying sorryAx 0". **Twelve plants, in memory, one at a time, every one fired**
(`probes/records-plant-probe.txt`): a record dropped; doubled; `sorryAx` under one; **the leaf still open —
`sorryAx` under the bridge**; a record on the Borel transfer; one filed under IMPORTED; one under PURCHASED; a native
auxiliary; a claim's theorem on the five-colour theorem; the three-arcs lemma under IMPORTED; a theorem with no
record; a module absent from the dump.

**The audit's self-test, among the probes this time** (the last landing's slip): `./scripts/axioms.sh --self-test`,
exit 0, "OK — every planted fault fired, and every partner passed" (`probes/axioms-selftest-probe.out`). Its two
controls that read the library's state assert the count of IMPORTED records, twenty-three, which this landing does
not move: **`scripts/axioms-controls.txt` is untouched.**

**`ARCHITECTURE.md`** (§ 3.13, retitled "The radius clause, and what a region of one label forces"): a second
paragraph says what this landing brings — whose the statements and the proofs are, eight modules, 340 theorems, no
`sorry`, the rows, the two forms of C124-BOTH's second clause and which half of the classical fact the three-arcs
lemma proves. The eight rows no longer say "a skeleton on branch …": each reads "planned by …, proved by …" (the
two the third implementer flagged among them: `Plane/ClosePairModel`, "its three leaves proved by FS124-I4", and
`Plane/SectorPoint`, "the bridge closed at the landing by FS124-K3's two lines over `Plane/ThreeArcs`"); the row of
`Plane/SectorPoint` names the bridge and gains `Plane/ThreeArcs` in its imports cell, and that module's row now
stands before its importer's; the Row cells carry 162 (`OnePiece`), 163 (the pair's modules) or both
(`CircleCrossing`). § 5 Trust: nothing — no purchase, no import. `tools/check_architecture.py`: exit 0, "RESULT:
PASS" (`probes/arch-probe.out`); its item [7] lists, without failing, `Plane/ClosePair`, `Plane/ClosePairModel` and
`Plane/SectorPoint` against row 163, whose text as filed names the claims and no identifier — the drafted grade
sentence names them.

**The docstring rewordings** (three files; no statement): `Plane/SectorPoint` (stage 2); `Plane/ThreePiece`, the
module header's sentence on the sector point — "one leaf of that module" now names the bridge and the three-arcs
lemma; `Plane/ClosePair` — the third implementer's drafts 2 and 3: `closePair_both_saved`'s note describes the
witness as built ("two radii and an arc of the unit circle about the common unit point", for "arcs of unit circles")
and says what the clause in the list's words rests on (for "a leaf there"), and the header's paragraph on
inhabitants names where they are constructed. Its draft 4 needs no edit: every "Inhabitant of the hypotheses" note of
the five claims' theorems names a theorem that is now proved.

**No statement and no definition changed — from the kernel's side** (`data/fs124/l2/StatementDump.lean`, after the
third implementer's dumper; reader `tools/fs124_l2_statements.py`; `data/fs124/l2/statements/`). Every constant of
the eight modules' compiled data, with its stored type and a definition's stored value, was dumped **before** the
merged build recompiled anything but the sector module (`before-joined.compact`; six modules then still the
implementers' compiled files), and again after it (`after-merged.compact`): "statements: PASS: no statement and no
definition changed — 523 named constants compared in 8 module(s)" (`diff-before-vs-merged.txt`). The two modules the
join had already recompiled or brought are compared with their makers' own states: `Plane/SectorPoint` and
`Plane/ClosePairModel` against the third implementer's last dump (`data/fs124/i4/statements-after-3.txt`: "9 named
constants compared", PASS — so the sector module's new import stores no term differently), and `Plane/ThreeArcs`
against a dump made from the compiled file in the other branch's worktree at `9af859b7` (87 named constants, PASS).
Four plants — a stored type changed, a definition's value changed, a constant dropped, one added — each fired
(`diff-plant.txt`). In text, against the as-given commits: `CircleCrossing`, `OnePiece`, `ClosePairWitness`,
`ClosePairModel` byte for byte; `ThreePiece` +2 −2 and `ClosePair` +6 −4 (docstring lines); `SectorPoint` +20 −10
(stage 2); `ThreeArcs` byte for byte the other branch's.

**The doubled-name check on the joined tree** (`./scripts/dupnames.sh`, after the build and before the audit;
`probes/dupnames-probe.out`): exit 0, "dupnames: OK — no name is declared by two modules (24 generated on demand,
listed above)". The join of the two branches with `main` made no doubled name.

## Stage 4 — SAVED (FS124-L2): what the library assumes

`./scripts/assumptions.sh --self-test` first (`data/fs124/l2/probes/assumptions-selftest-first.out`): exit 0, "OK —
all 33 checks behaved: every planted fault fired, and every partner stayed silent". Then the step
(`probes/assumptions-first.out`): **exit 1, two failures, one kind, both read**:

```
FAIL undeclared-never-concluded HadwigerNelson.Plane.IsTriod :: taken as a hypothesis by 14 constant(s) ([HadwigerNelson.Plane.IsTriod.range_subset_of_isPreconnected, HadwigerNelson.Plane.IsTriod.apply_one_ne]), concluded by none: an assumption (.former) or a condition (.condition)?
FAIL undeclared-never-concluded HadwigerNelson.Plane.IsTriodCut :: taken as a hypothesis by 20 constant(s) ([HadwigerNelson.Plane.IsTriodCut.closure_inter_closure_subset, HadwigerNelson.Plane.IsTriodCut.mem_diff_of_mem]), concluded by none: an assumption (.former) or a condition (.condition)?
```

**The step does not say a theorem takes an assumption; it asks which of two things a predicate is, and I can class
it.** `IsTriod x r J` and `IsTriodCut x r J P` are the three-arcs module's two structures of hypotheses: predicates
of a theorem's own point, radius, arcs and pieces. No theorem of the library *concludes* either — the bridge builds
an `IsTriodCut` inside its proof and no declaration states one — so the step cannot tell them from a named
hypothesis standing for a result. They are conditions: neither is a statement about the world, an outside theorem, a
hand result of ours or an open question, and every other structure of hypotheses of the eight modules is read
without a declaration because a model theorem concludes it (`IsTight`: `isTight_tightModel`; `CrossAt`:
`crossAt_zero_one_add_I`; `IsSector`: `sectorPoint_isSector`; `HasArcEdges`: `sectorPoint_hasArcEdges`). **Two lines
added to `AssumptionAudit.declared`** (`scripts/Assumptions.lean`), each `.condition`, each saying that no
declaration concludes it and where one is built — the form of the list's entry for
`SpectralInputs.IsSpectralMeasureOf`. **What the planners' records expected and the step did not bear out**: "no
declared hypothesis and no axiom, so nothing for the assumptions step" (`plans/FS124-kernel-plan-3.md` § 4.4). The
class is right as far as I can read it; what stays owed is in the open gate items — a library theorem that concludes
`IsTriodCut` (one line from `sectorPoint_isSector`; a term of this job's checks file today) would make both
declarations unnecessary, and it is a statement, so not this job's.

After it (`probes/assumptions-second.out`): **exit 0** — "assumptions: OK — 3 outside theorem(s) as axioms, with 23
theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s)
and mentioned by 1". `./scripts/assumptions.sh --write-ledger` (`probes/assumptions-write-ledger.out`): "ledger
written (122 rows)"; **the ledger gains no row and loses none** (`git diff scripts/assumptions-ledger.txt`: empty).

| | `main` (FS124-L1's gated scan) | this tree |
|---|---|---|
| `scanned` | constants=14582 theorems=10843 formers=340 hypotheses=18856 closed=1473 | constants=15036 theorems=11225 formers=361 hypotheses=19527 closed=1473 |
| the nine | axioms=3 rests=23 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 | **the same nine** |
| the rest | conditions=38 … silent=1 cohyp=58 hints=0 unseen=16817 fails=0 | conditions=**40** … silent=1 cohyp=58 hints=0 unseen=17480 fails=0 |

**None of the nine counts moves**: no theorem of the eight modules rests on a declared outside theorem (no `RESTS`
row; the audit's records agree: of the landing's, 0 carry any of the three), and none takes an assumption in
hypothesis form (no `TAKES` row, no closed hypothesis: `closed=1473`, `main`'s count). `conditions` moves by the two
declared; it is not one of the nine.

## Stage 5 — SAVED (FS124-L2): the vacuity step

`./scripts/vacuity.sh` (`data/fs124/l2/probes/vacuity-probe.out`): **exit 0, "vacuity: OK"**.

| | `main` (FS124-L1's gated scan) | this tree |
|---|---|---|
| declarations | 15370 | **15928** (+558: the landing's 558 constants, the dump's own count) |
| refutations-skipped | 226 | **228** (+2) |
| sites | 1448 | 1448 |
| vacuous / stale / declared / witnessed / generic / unknown | 0 / 0 / 3 / 38 / 1405 / 2 | the same six |

**How the scan classes every new site: there is none.** Row for row against `main`'s gated scan
(`tools/fs131_l5_vacdiff.py`, `probes/vacdiff-probe.txt`): "by module: declarations +558, refutations +2: equal to
the scans difference"; no row lost, none added; "vacdiff: PASS". Nothing reads `VACUOUS`, `STALE` or `UNKNOWN`; the
baseline's two entries are as on `main`. **Two declarations are skipped as refutations**
(`probes/count-modules-probe.out`, the lines marked `REF`), and they are two different things:

- `CircleSide.ball_antipode_subset_outside` (`Plane/CircleCrossing`) is not a refutation. Its conclusion is an
  inclusion in the outside region of a circle, a complement, which the scan reads through to `→ False`. Its one
  hypothesis is `dist z q = 1` (`z = 1`, `q = 0`).
- `IsTriod.not_mem_closure_both_sides` (`Plane/ThreeArcs`) is one: a step inside the three-arcs lemma's proof by
  contradiction — "no preconnected set of the closed disc off two of the arcs reaches the rim on both sides of their
  far ends" — whose hypotheses are jointly unsatisfiable, and it is the theorem that says so. Each alone is
  satisfiable: the triod is the model's; a preconnected set of the closed disc off two radii with one rim point in
  its closure is a sector.

**The scan is silent on every hypothesis of the landing**, as it was on the last two landings': the colourings are
maps `c : ℂ → Fin k` under `IsWeakColouringOn U c`, the arcs and pieces are sets under predicates, and the scan
tracks none of them. Silence is not evidence. **The model of each hypothesis, by hand**, and whether the kernel
holds it — "library" is a theorem or an `example` of a module, checked in the build; "term" is a theorem of the
iteration file `data/fs124/l2/checks.lean`, kernel-checked when the gate's pass elaborates it and not a library
theorem (every term on the standard three):

| statement | its hypotheses | the model | held |
|---|---|---|---|
| all nine, and the clause | `IsOpen U`, `IsWeakColouringOn U c` at `c : ℂ → Fin k` (the pair's at `Fin 6`) | three small discs: `tightModelDom` with `tightModel` at `k = 3` (`isWeakColouringOn_tightModel`); `threeDisc y` with `loneCol`, `squareCol` at six (`isWeakColouringOn_loneCol`, `isWeakColouringOn_squareCol`). **Inhabited at every parameter the statements take**, with no import and no open question: the set is free and may be small. On a large disc the class at six is the Hadwiger–Nelson problem and at five is empty given `radius_five`; no statement here asks a large set | library |
| `shadow_open` | `W` open in `U`, almost all of one label | the disc about `0` of `tightModelDom`, label `2`: the module's `example` runs the theorem there | library |
| `piece_type` | `P` open, connected, in `U`, almost all of one label; `x ∈ closure P`; `w ∈ U`; for a clause, a point of `P` on one side of `S(w)` | the inner collar of the model's tight pair, `x = 1`, `w = 0` (the module's `example`, first clause). The second clause's side is run on no object: it is the first with the two sides exchanged (`IsPieceAt.ae_ne_region` at the other side) | library, one clause |
| `centre_half` | `q ∈ U`, `dist q z = 1`, `ball z ρ ⊆ U`, one collar almost all of one label | the model's pair `(0, 1)`, `ρ = 1/10`: the module's `example` runs both halves | library |
| `tight_centre`, `tight_straddle` | `IsTight U c q z a b`; `p ∈ U` one unit from `z`, not `q`, not `2z − q` | `isTight_tightModel` (the pair `(0, 1)` tight for `(0, 1)`), and `p = 1 + i`, the centre of the third disc: two `example`s; `FS124L2.model_tight` | library; term |
| `closePair_forced_pieces`, `closePair_lone` | `C : ClosePair U c x y`, `w ∈ U`, `IsCommonUnitPoint x y w`; for the second, `¬ C.right.SeparatesAt w` | `lonePair`: the petal point at `0`, a sector point at `1 + i`, `w = 1` — `exists_closePair_not_separatesAt`, every hypothesis at once; `FS124L2.model_lone` draws `closePair_lone`'s conclusion on it | library; term |
| `closePair_both_separate`, `closePair_both_saved`, `closePair_four` | the same and `IsFull` (or `HasArcEdges`) of both members; for the last, one piece of each kind at both | `squarePair`: the split point at `0` and, turned, at `1 − i`, `w = 1` — `exists_closePair_full`, every hypothesis at once; the module's `example`s run the three theorems on it | library |
| `closePair_both_saved_of_isSector` | the same with `IsSector` of both members | `exists_closePair_sector`, on `squarePair` (its arcs: two radii and an arc of the unit circle about `1`); `FS124L2.model_sector` draws the conclusion | library; term |
| `ThreePiece.IsSector.hasArcEdges`, `.isFull` | `D.IsSector` | `sectorPoint_isSector` — the three-sector point, arcs the radii along `1`, `i`, `−1 − i`; **the spec example added at the join runs the bridge on it**, and `sectorPoint_hasArcEdges` proves the same fact by construction | library |
| `IsTriodCut.exists_opposite`, `exists_arc` (and the module's 34 theorems over `IsTriod` or `IsTriodCut`) | `IsTriodCut x r J P` | **no library theorem concludes it.** `FS124L2.model_triodCut`: the three-sector point's radii and sectors are an `IsTriodCut`, from `sectorPoint_isSector` by the bridge's own construction; `model_triodCut_arc` runs `exists_arc` on it. The bridge builds one for every sector point, so `exists_closePair_sector`'s two members give two more | **term**; the library holds it only inside the bridge's proof |
| the control `exists_closePair_seven_not_separatesAt` | none (an existence) | at seven labels the conclusion of `closePair_forced_pieces` fails on `sevenPair`: the one hypothesis that cannot be dropped is "every label is the label of a piece of `x` or of `y`" (an `example` of `Plane/ClosePairModel` draws its failure through `ClosePair.separatesAt_or`) | library |

**No hypothesis of the nine claims' theorems, of the clause in the list's words or of the bridge is without a kernel
model in the library; the three-arcs lemma's is a term.** What the witnesses are not, in the third implementer's
words: "maps of the plane, or fragments of one — each is a colouring of three discs of radius `1/4`, and nothing
here says that a colouring of the plane has such a pair". **No older statement is emptied by this landing**: it
brings no axiom, and its carriers are new with it.

## Stage 6 — SAVED (FS124-L2): read aloud — the nine claims' theorems against rows 162 and 163 and the entries' statements

*The statements are read as the kernel holds them (`data/fs124/l2/probes/checks-probe.out`, and again in the gate's
pass as `gate/checks-final.out`, from `data/fs124/l2/checks.lean`: `#print` of each definition, `#check @…` of each
theorem with every binder shown, `#print axioms` of each), never as the files print them. The rows are `LEDGER.md`
rows 162 and 163; the entries are `plans/FS124-derivation.md` §§ 2–3; the kernel claim list is
`data/fs124/claims-K2.md`.*

**The three texts are one text.** `tools/fs124_l2_entries.py` (this job's; `probes/entries-probe.txt`): each of the
nine entries' statements stands word for word, whitespace apart, in the kernel claim list with its *not claimed*
line, and — for the eight whose sentence the ledger quotes — in row 162 or row 163 ("entries: PASS"; four plants
fired, a changed word in C124-LONE's statement among them). C124-CENTRE is the one the ledger names without quoting
("for a tight pair, both halves"). So the implementers' clause-by-clause readings against the claim list
(`plans/FS124-I2-implementation.md` § 4.2, `plans/FS124-I3-implementation.md` § 3.2) are readings against the rows'
sentences; I read each again against the stored statement, and what follows is that reading, with every place where
a theorem says less, more or other than its sentence.

**Four readings hold throughout.** (1) *The class*: "a weak `k`-colouring of an open set `U`" is `IsOpen U` and the
first module's `IsWeakColouringOn U c` for a total `c : ℂ → Fin k`, Borel measurable, with the monochromatic unit
pairs inside `U` null — read on `U` alone (FS124-L1's record, stage 7). **Measurability is idle in all nine**: each
is the corollary of a statement for `AeProperOn U c` at any label type, and the proofs pass `hc.aeProperOn` only.
(2) "Almost every point" is `∀ᵐ` for Lebesgue measure on `ℂ`; `B(p, r)`, `B̄(p, r)`, `S(p)` are `ball p r`,
`closedBall p r`, `sphere p 1`; inside and outside `S(p)` are `dist z p < 1` and `1 < dist z p`. (3) Every `η` is
existential and comes after the points it is about: no statement gives a uniform one. (4) Each theorem's axioms, as
the audit prints its record: `[propext, Classical.choice, Quot.sound]`, under CLEAN.

**1. `shadow_open` — C124-SHADOW-OPEN (row 162's first sentence).** `IsOpen U → IsWeakColouringOn U c → IsOpen W → W
⊆ U → (∀ᵐ z, z ∈ W → c z = i) → IsOpen (U ∩ unitShadow W) ∧ ∀ᵐ z, z ∈ U ∩ unitShadow W → c z ≠ i`, with `unitShadow
W = {z | ∃ y ∈ W, dist z y = 1}`. Aloud: *if an open part of the set has one label almost everywhere, the points of
the set at distance exactly 1 from some point of that part form an open set, and almost every one of them has another
label.* Clause for clause the sentence; "a finite set of labels" is `Fin k`. Not claimed, and not said: nothing for a
`W` that is not open; no open one-label set is asserted to exist.

**2. `piece_type` — C124-TYPE.** `IsOpen P → IsConnected P → P ⊆ U → (∀ᵐ z, z ∈ P → c z = i) → x ∈ closure P → w ∈ U
→ ((∃ y ∈ P, dist y w < 1) → ∃ η > 0, ∀ᵐ z, z ∈ ball w η → 1 < dist z x → c z ≠ i) ∧ ((∃ y ∈ P, 1 < dist y w) → ∃ η
> 0, ∀ᵐ z, z ∈ ball w η → dist z x < 1 → c z ≠ i)`. **More than the sentence in one place: there is no hypothesis
`|w − x| = 1`.** The theorem holds at every `w ∈ U`, and the row's sentence is its case at distance one (the
planner's generalization, in the claim list's dated line). Nothing less: each of the two clauses is one conjunct with
its own `η`, on the side of `S(x)` the sentence names.

**3. `centre_half` — C124-CENTRE-HALF.** `q ∈ U → dist q z = 1 → 0 < ρ → ball z ρ ⊆ U → ∀ a, ((∀ᵐ w, w ∈ ball z ρ →
dist w q < 1 → c w = a) → ∃ η > 0, ∀ᵐ p, p ∈ ball q η → 1 < dist p z → c p ≠ a) ∧ ((∀ᵐ w, w ∈ ball z ρ → 1 < dist w q
→ c w = a) → ∃ η > 0, ∀ᵐ p, p ∈ ball q η → dist p z < 1 → c p ≠ a)`. The sentence, collar by collar. "`z` a point
of `U`" is no binder: it is the centre of a disc inside `U`.

**4. `tight_centre` — C124-CENTRE.** `q ∈ U → IsTight U c q z a b → ∃ η > 0, (∀ᵐ w, w ∈ ball q η → 1 < dist w z → c w
≠ a) ∧ ∀ᵐ w, w ∈ ball q η → dist w z < 1 → c w ≠ b`. `IsTight U c q z a b` is `∃ ρ, IsTightWith …`, whose fields
are the claim list's object word for word: `a ≠ b`, `0 < ρ`, `ball z ρ ⊆ U`, `dist q z = 1`, almost every point of
`ball z ρ` inside `S(q)` has the label `a`, outside it `b`. One `η` for both halves, as the entry says.

**5. `tight_straddle` — C124-STRADDLE.** `IsTight U c q z a b → p ∈ U → dist p z = 1 → p ≠ q → p ≠ 2 * z - q → ∃ η >
0, ∀ᵐ w, w ∈ ball p η → c w ≠ a ∧ c w ≠ b`. The sentence. The two excluded points are hypotheses; nothing is said at
them (the row's C124-CENTRE and C124-ANTIPODE).

**Row 162's other sentences have no Lean theorem**: C124-COMPLETION (the case of `tight_straddle` at a rhombus
completion; no statement names a completion), C124-ANTIPODE, C124-KIND, C124-SIX, and the readings by formula of R7
and the strip ([tools]). Its *not claimed* items are true of the five theorems: an open `W`, a connected open `P`
and the tight pair are hypotheses, and no theorem asserts that a weak colouring has one.

**6. `closePair_forced_pieces` — C124-FORCED-PIECES (row 163's first sentence).** `(C : ClosePair U c x y) → w ∈ U →
IsCommonUnitPoint x y w → (∃ i j, InnerAt (C.left.piece i) w ∧ OuterAt (C.left.piece j) w ∧ C.left.edge i j ⊆ sphere
w 1) ∨ (∃ i j, InnerAt (C.right.piece i) w ∧ OuterAt (C.right.piece j) w ∧ C.right.edge i j ⊆ sphere w 1)`, at `c :
ℂ → Fin 6`. "A close complementary pair of three-piece points, each with a decomposition" is the structure
`ClosePair`: a decomposition at each (`ThreePiece`: a neighbourhood in `U`, three open preconnected pieces in it
with the point in each closure, one label almost everywhere on each, the three labels distinct, the rest of the
neighbourhood null), `x ≠ y`, `dist x y < 2`, no label of one a label of the other. `InnerAt P w` is `P ⊆ closedBall
w 1`, `OuterAt P w` is `Disjoint P (ball w 1)`, `edge i j` is `closure (piece i) ∩ closure (piece j) ∩ nbhd`. **One
word of the sentence is not a conjunct — "another"**: `i ≠ j` is not stated; it follows, since a piece is a
non-empty open set and none is both inner and outer (`not_innerAt_and_outerAt`). Which member separates is not
said: a disjunction.

**7. `closePair_lone` — C124-LONE.** With `¬ C.right.SeparatesAt w` added: `∃ σ : Equiv.Perm (Fin 3),
C.left.OneOfEach w σ ∧ (∃ τ : CircleSide, ∃ η > 0, (∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z =
C.left.label (σ 0)) ∧ ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = C.left.label (σ 1)) ∧ ∃ w' ∈ sphere
x 1, w' ≠ w ∧ ∃ η' > 0, C.left.piece (σ 0) ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧ Disjoint (C.left.piece
(σ 1) ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧ closure (C.left.piece (σ 0)) ∩ closure (C.left.piece (σ 1)) ∩ ball x η'
= {x}`. "Exactly one inner piece, one outer piece and one crossing piece" is the permutation `σ` with `σ 0` inner,
`σ 1` outer, `σ 2` crossing (neither): a bijection of three pieces onto three kinds that exclude one another. "A
side of `S(y)`" is `τ.region y`. **"Their closures meet at `x` only" is read inside `B(x, η′)`**, as the sentence's
"inside `B(x, η′)`" governs its three clauses. Every clause has its conjunct; the configuration is not said to be
impossible, and nothing is said of the crossing piece's edges.

**8. C124-BOTH, first sentence — `closePair_both_separate`.** `C.left.IsFull → C.right.IsFull → C.left.SeparatesAt w
∧ C.right.SeparatesAt w`, `IsFull` being: for every two pieces, the point is a limit of points other than itself of
their edge. The sentence.

**9. C124-BOTH, second sentence — both forms.** "If they are sector points, each has an edge that contains an arc of
S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one
member alone."

- **For arc-edged decompositions — `closePair_both_saved`**: `C.left.HasArcEdges → C.right.HasArcEdges → C.left.Saves
  w ∧ C.right.Saves w`. `HasArcEdges`: every edge contains an injective continuous image of `[0, 1]` starting at the
  point. `Saves w`: some edge of two different pieces contains the points `w + (x − w) e(s t)`, `0 ≤ t ≤ δ`, for a
  turning sense `s = ±1` and some `δ > 0` — an arc of the unit circle about `w` from the point. This is what the
  clause reads of a sector point, and it is wider than the list's class: nothing is asked of the pieces beyond their
  edges.
- **In the claim list's words — `closePair_both_saved_of_isSector`** (`Plane/SectorPoint`): `C.left.IsSector →
  C.right.IsSector → C.left.Saves w ∧ C.right.Saves w`. `D.IsSector` is the list's definition clause for clause —
  "for some r > 0 there are three arcs J_0, J_1, J_2 (homeomorphic images of [0, 1])": `∃ r > 0, ∃ J : Fin 3 →
  C(unitInterval, ℂ)`, each injective (a continuous injection of a compact interval is a homeomorphism onto its
  image); "from x to the circle ∂B(x, r)": `J m 0 = x`, `dist (J m 1) x = r`; "inside B(x, r) but for their far
  ends": `t ≠ 1 → dist (J m t) x < r`; "disjoint but for x": `m ≠ m' → J m s = J m' t → J m s = x`; "such that the
  three components of B(x, r) ∖ (J_0 ∪ J_1 ∪ J_2) are the pieces": each piece is a component of the cut disc, and
  the pieces fill it. **Since this landing the sentence is a kernel theorem in these words**, on the standard three:
  the bridge `ThreePiece.IsSector.hasArcEdges` no longer prints `sorryAx`.

**What the three-arcs lemma's hypotheses assume of the classical fact.** The θ-curve theorem of plane topology says
of three arcs from the centre of a disc to its rim, disjoint but for the centre: (i) the disc less the arcs has
exactly three components; (ii) each arc lies in the closure of exactly two of them, and every two share one.
`IsTriodCut x r J P` — the hypothesis of `IsTriodCut.exists_opposite` and `exists_arc` — is the three arcs together
with **three open preconnected pairwise disjoint sets given as filling the cut disc**. So **(i) is assumed, in that
form, and (ii) is what the module proves from it**, by this library's unicoherence of the plane and its crossing
lemma; no Jordan curve theorem is read, and that a cut disc has three components is proved nowhere and used
nowhere. For row 163 this costs nothing: a sector point is, by the list's own definition, *given* with its three
pieces as the components, so `IsSector` supplies the three sets and the bridge needs no more — the definition's
sixth clause (each piece is a component) is not even read, the seventh (the pieces fill the cut disc) and the
decomposition's fields give what the lemma asks. What it would cost: a statement about three arcs with no pieces
given ("any such three arcs cut the disc into three regions, and …") is not a theorem here. `exists_opposite` reads
aloud: *there is a bijection from arcs to pieces, the piece opposite an arc, such that each arc lies in the closure
of the two other pieces and meets the closure of its opposite piece at the centre only.*

**10. `closePair_four` — C124-FOUR.** With both members full and `C.left.OneOfEach w σ`, `C.right.OneOfEach w τ`:
`presentAt U c w = {C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} ∧ (presentAt U
c w).ncard = 4`. "Present at `w`" is `presentAt U c w = {i | w ∈ essSupport (U ∩ c ⁻¹' {i})}`: every disc about `w`
meets the class of `i` in `U` in positive measure. The set of labels present is the four named, and it has four
elements: "exactly four". Which label fills which region is not said.

**Row 163's other sentences.** C124-FORCED: no Lean theorem states it; its first half ("w is saved by x or by y")
follows from sentence 9's theorem, its second (tightness along the arc) is in no module, and its topological input —
"recalled, not read" in the row — is now `IsTriodCut.exists_opposite`. C124-FORCED-AS-POSED, C124-SECOND, C124-HALF,
C124-HALF-TWO, C124-FORCED-SEVEN and the reading of held objects: by hand or [tools], no Lean theorem.
**C124-LONE-EXISTS: its sentence is a kernel theorem by another witness** — `exists_closePair_not_separatesAt`
states "there is a weak six-colouring of an open set with a close complementary pair and a common unit point in the
set at which the second member does not separate", on `lonePair` (a petal point and a sector point on three discs),
not on the entry's object, fragment S1 with a band. The grade of the entry is the coordinator's.

**Two places where the modules say something a row's *not claimed* line might be read against.** (a) "That a weak
six-colouring has a three-piece point, or a close complementary pair" (row 163): the four existence theorems
exhibit weak six-colourings **of three discs of radius `1/4`** that have one — they are the models of the
hypotheses, C124-LONE-EXISTS's kind — and say nothing of a weak six-colouring of the plane or of a disc of any
given radius. (b) "Anything with seven labels": the modules hold the general statement at any label type under the
hypothesis "every label is the label of a piece of `x` or of `y`" (`ClosePair.separatesAt_or`) and a control at
seven where it fails (`exists_closePair_seven_not_separatesAt`); neither is an entry, and neither says anything at
seven under the row's own hypotheses beyond that the conclusion can fail.

**What the read-aloud found.** No clause of the nine is missing; no hypothesis is added; no theorem claims an item
of a *not claimed* line. One theorem is wider than its sentence (`piece_type`, no `|w − x| = 1`); one word is a
consequence and not a conjunct ("another"); one sentence is held in two forms, the second in the list's words since
this landing. **No gap between a theorem and the sentence it is read against.**

### Which of the milestone's thirty entries are kernel theorems after this landing, and which stay by hand

`tools/fs124_l2_entries.py --table` (the table is this job's reading, written once in the tool and checked: the
theorem record holds exactly these thirty; every Lean name has one record under the banner said): **fourteen kernel
theorems — five since FS124-L1, nine by this landing — and sixteen by hand.**

| entry | after this landing | Lean | note |
|---|---|---|---|
| C124-RADIUS-GRAPH | kernel, since FS124-L1 | `radius_graph` | — |
| C124-RADIUS-COUNTABLE | kernel, since FS124-L1 | `radius_countable` | — |
| C124-RADIUS-UP | kernel, since FS124-L1 | `radius_up` | — |
| C124-RADIUS-DOWN | kernel, since FS124-L1 | `radius_down` | on the declared outside theorem `proper_to_borel_weak` |
| C124-RADIUS-FIVE | kernel, since FS124-L1 | `radius_five` | on the declared outside theorem `no_proper_five_coloring` |
| C124-EVERY-DIRECTION | by hand | — | no kernel job: stated in no module (FS124-L1's open item 1) |
| C124-SHADOW-OPEN | **kernel, by this landing** | `shadow_open` | — |
| C124-TYPE | **kernel, by this landing** | `piece_type` | wider than the entry: no hypothesis |w − x| = 1 |
| C124-CENTRE-HALF | **kernel, by this landing** | `centre_half` | — |
| C124-CENTRE | **kernel, by this landing** | `tight_centre` | — |
| C124-STRADDLE | **kernel, by this landing** | `tight_straddle` | — |
| C124-COMPLETION | by hand | — | no kernel job: a corollary of C124-STRADDLE at one point, stated in no module (its handoff: "subsumed by C124-STRADDLE, which crosses") |
| C124-ANTIPODE | by hand | — | no kernel job: handed off "as written" and not among the nine a planner fixed |
| C124-OPEN | by hand | — | no kernel job: a relay-result (its handoff: none) |
| C124-FORCED-PIECES | **kernel, by this landing** | `closePair_forced_pieces` | — |
| C124-FORCED | by hand | — | no kernel job for the entry: its first sentence follows from the kernel's C124-BOTH (`closePair_both_saved_of_isSector`: saved by both); its second, tightness along the arc, is stated in no module; its topological input is now a kernel theorem (`IsTriodCut.exists_opposite`) |
| C124-FORCED-AS-POSED | by hand | — | a refutation by a held object (fragment BB with a band): no kernel job |
| C124-LONE | **kernel, by this landing** | `closePair_lone` | — |
| C124-LONE-EXISTS | by hand | — | needs a held object's tiles: the entry's object is fragment S1 with a band; the kernel holds the same sentence by another witness (`exists_closePair_not_separatesAt`, on `lonePair`) |
| C124-BOTH | **kernel, by this landing** | `closePair_both_separate`, `closePair_both_saved`, `closePair_both_saved_of_isSector` | first clause; second clause in both forms — for arc-edged decompositions, and in the list's words for sector points over the three-arcs lemma |
| C124-FOUR | **kernel, by this landing** | `closePair_four` | — |
| C124-SECOND | by hand | — | no kernel job: handed off "after C124-FOUR" and not among the nine |
| C124-EDGE-CLOSED | by hand | — | needs a held object's tiles (FS-112's strip); its handoff: only with a consumer |
| C124-EDGE | by hand | — | a computation on one held object; subsumed by C124-EDGE-CLOSED |
| C124-SIX | by hand | — | no kernel job: handed off "after C124-CENTRE" and not among the nine |
| C124-SIX-CONES | by hand | — | no kernel job: subsumed by C124-SIX |
| C124-HALF | by hand | — | no kernel job: over the inherited C132-WIT-SIDE, whose module is not built |
| C124-HALF-TWO | by hand | — | no kernel job: subsumed by C124-HALF's module |
| C124-KIND | by hand | — | a calibration at seven by formula; its handoff: only with a consumer |
| C124-FORCED-SEVEN | by hand | — | needs a held object (the hexagonal seven-colouring); the kernel holds a control of the same kind on another object (`exists_closePair_seven_not_separatesAt`) |

**Complete for every statement a planner planned**: FS124-K1's five entries and the criterion (landed by FS124-L1),
FS124-K2's nine, FS124-K3's lemma and the bridge. Of the sixteen by hand, five were handed to the kernel lane "as
written" or "after" a landed entry and no planner has fixed them: C124-ANTIPODE, C124-SECOND, C124-SIX, C124-HALF,
and C124-FORCED's second sentence.
