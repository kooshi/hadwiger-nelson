# FS132-L2 — the landing: the first night's exclusion, with the outside lemmas ported under it, through the gate and onto `main`

*Record of the landing implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-L2-landing.md` on `main` at
`53ce5626`. Branch `fs132-wl2`, worktree `.claude/worktrees/fs132-wl2`, cut from `fs132-wi4` at `7e4e5d2a`. Working
files: `data/fs132/l2/`. Tools: `tools/fs132_l2_*.py`; other jobs' tools are run, never edited, except the two
generators the brief names (the port's, through which the generated modules change).*

## Theorems this phase proved

*The final list is at the end of this record ("Theorems this phase proved, final").* One theorem is this job's own, by
its brief's Amendment 1: `HadwigerNelson.SixRing.not_ae_outside_points` — [kernel], `[propext, Classical.choice,
Quot.sound]`. The others it gates and lands are FS132-K1's and -K2's (statements), FS132-I2's (the port), FS132-I3's
and FS132-I4's (the leaves), listed in their records.

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

## Stage 3 — SAVED (FS132-L2): `main` merged in

**Tried before it was made** (`data/fs132/l2/merge-trial.out`, on the tip before the cut against `5c6c52e8`;
`merge-trial-2.out`, on the committed tree against `357e42de`): `git merge-tree --write-tree --name-only` exits 0 and
names no conflict. `main` had moved three times since the brief was written (`045d3d71` → `53ce5626` → `5c6c52e8` →
`357e42de`); since the merge base `808ef9bf` it changes 211 paths — `data/` 161, `plans/` 37, `tools/` 6
(`claude_md_fact_audit.py`, `fs124_p1_cones.py`, `fs132_z2_append.py`, `fs132_z2_brier.py`, `fs132_z2_frontpage.py`,
`viz_proof_atlas_facts.py`), and one each of `BIBLIOGRAPHY.md`, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `RUNNING.md`,
`.claude/`, `visualizations/` — and **none under `Proofs/`, `Proofs.lean`, `scripts/`, `ARCHITECTURE.md`, the lakefile,
the toolchain file or the manifest** (counted: 0).

**Made**: `git merge --no-ff 357e42de237b84656febcb262a5bfac4fc67814e` (the hash, never the ref) — **merge commit
`26e0cb326`, automatic, no conflict.**

**Built** (`data/fs132/l2/build-2-merged.log`): **exit 0** — "build: OK — all 1866 modules already up to date, nothing
built, 0 module(s) with warnings, 2s" (1868 − the two skeleton modules; the merge brought no Lean source, so the
compiled modules are those of stage 2's build).

## Stage 4 — SAVED (FS132-L2): the port's three loose ends

**(a) The licence.** `Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt` is a byte-identical copy of the release's
`LICENSE` (`/home/kooshi/source/math/LICENSE` at commit `adc7f124`: Apache License 2.0, 11,357 bytes, sha256
`c71d239d…`; the release has no `NOTICE` file and its Lean files carry no header of their own). The name says whose it
is by this project's bibliography key. **Through the generator**: `tools/fs132_i2_port.py` writes the copy when it
writes the modules, `--check` compares the two files byte for byte, and every generated header — the eight ported
modules' and, through `tools/fs132_k1_port.py`, the palette module's — names it in its licence sentence ("a
byte-identical copy of that licence text is beside this file, `Outside/OAIMath2026-LICENSE.txt`"). Checks
(`data/fs132/l2/port/`): `--check` exit 0, "CHECK OK" (ten files and the audit's block of 163 records);
`--self-test` exit 0, "**10 plants refused and 1 partner accepted**" — the port's eight and two new ones, the copy
changed by one byte and the copy absent; and **in the real files** (`port-check-planted.out`): one word of the copy
changed — "FAIL: OAIMath2026-LICENSE.txt differs from the release's LICENSE", exit 1; restored, digest the same,
"CHECK OK". *Not done, and held for the coordinator*: `Outside/OAI158.lean`, the import's module on `main`
(hand-written by FS132-I1; ten declarations copied from the release's `Coloring.lean`), names the release and its
commit and does not name the licence; it is not one of this landing's modules and not generated, so I did not edit it.

**(b) The three instances on Mathlib's types — all three are scoped, and every module builds.** In
`Outside/OAI158Palette` (the port's record § 3.5): `CompactSpace` and `MetrizableSpace` on `WeakBall.Space E`, a
reducible abbreviation of a subtype of Mathlib's weak dual (`Compactness.lean` 160–162), and a private
`Fact ((2 : ENNReal) ≠ ⊤)` (line 250). Through the palette module's generator (`tools/fs132_k1_port.py`, its `SCOPED`
and `ADDED_AFTER` tables): the keyword `scoped` on the three lines, and — because the first two are declared inside the
child namespace `WeakBall`, where `scoped` alone would hide them from the parent in which every use stands — one added
line after that namespace closes, `attribute [scoped instance] WeakBall.instCompactSpaceSpace
WeakBall.instMetrizableSpaceSpace`, inside `namespace HadwigerNelson.Outside.OAI158`. The header's notice of change
gains an item 6 saying so. No name, statement or proof text moved (the port's read-back below prints the same bytes).
- *Before the edit*, the mechanism at the pin, in a file that imports nothing (`data/fs132/l2/probes/scoped-probe.lean`,
  exit 0): an anonymous `scoped instance` keeps its generated name; `attribute [scoped instance]` in the parent adds
  the parent's scope; `private scoped instance` parses; outside the namespace none is found; under `open` each is.
- *After the build* (stage 2's: exit 0, 23 modules rebuilt, 0 with warnings — the nine outside modules and the thirteen
  of `Plane/SixRing`, every one downstream of the palette module), on the built module
  (`data/fs132/l2/probes/scoped-built.lean` → `.out`): **outside the namespace all three `#synth` fail** ("failed to
  synthesize `CompactSpace (…WeakBall.Space E)`", "`TopologicalSpace.MetrizableSpace (…)`", "`Fact (2 ≠ ⊤)`", at lines
  12–14 — the three reds the file is written to show, hence its exit 1); **under `open
  HadwigerNelson.Outside.OAI158`, inside that namespace, and in a `HadwigerNelson.SixRing` section with `open
  Outside.OAI158`, each is found** (seven prints of the three names).
- The generator's check with one of the three made global again in the real file: "FAIL: … OAI158Palette.lean
  differs from the generated text", exit 1; restored (`port-check-planted.out`).
- Left as the release has them, and safe: the two instances on the release's **own** types
  (`angularMeasure.instIsAddHaarMeasure` here; `instIsFiniteMeasureRealPlaneAngleChartMeasure` in `OAI158CircleMaps`),
  found only for those constants.

**(c) Both stored-term comparisons, again, on the joined tree — no verdict changed.** Commit `f5a4863c`, no tracked
file modified, the release's clone at `adc7f124` and clean; nothing written at the release's side (0 files under
`~/.cache/ext-oai1`, 0 under `~/source/math`, by marker file).
- **The import's** (`tools/fs132_i1_readback.py`, driven by FS132-L1's runner with its output directory changed and
  nothing else — `data/fs132/l2/run-readback-import.sh`; summary `data/fs132/l2/readback-import-joined.txt`, prints
  under `readback-import/`): every step as expected; the release's print made again at its pin equals the import's
  committed print; the module's print equals the import's own (the module's olean is `0f3b15f3…`, the one FS132-L1
  gated: this landing does not recompile it); "declarations: 8 compared: 8 identical: 8 different: 0", "READ-BACK
  IDENTICAL: all 8 declarations, term for term, modulo the namespace"; "SELF-TEST OK … 6 plants"; the Lean control
  "FIRED AS EXPECTED" on the six altered declarations and refused when read as a plain comparison; level one, no
  constant absent; the nine characterisations elaborate with no message. "READ-BACK RUN joined: OK".
- **The port's** (`tools/fs132_i2_readback.py compare`, as its record's § 3.3 runs it —
  `data/fs132/l2/run-readback-port.sh`; summary `readback-port-joined.txt`, prints under `readback-port/`, the two
  large ones compressed): the release's print made again at its pin is the port's committed print byte for byte
  (`c3343d13…`); **this library's print from the modules as built on the joined tree, with the three instances scoped,
  is the port's own print byte for byte (`7874161e…`)** — scoping an instance changes no stored type and no stored
  value; `compare`: "READBACK OK", its output identical to the port's, its three tables unchanged as git sees them
  (4 targets IDENTICAL; 58 definitions 44 / 14; 181 lemmas 158 / 23; no DIFFERENT); "SELF-TEST OK: 13 plants refused,
  the unplanted pair passes"; "LEVEL1 OK", the table identical to the port's. "PORT READ-BACK RUN joined: OK".

## The mid-job message, and the brief's Amendment 1 (read whole on `main`, commit `1f3849cb`)

Sent to the coordinator when the reading aloud found it (stage 8): the library states the ring form over four compact
sets (`not_ae_outside`, C132-M-EXCL's wording), the ledger's ring sentence is over four points (C132-WIT-EXCL), and the
second follows from the first at the two-point sets — checked as a term, `l2_not_ae_outside_points` in
`data/fs132/l2/points-form.lean`, on the standard three. With it, two clauses for the filing's words: Borel
measurability in every statement; no Lean theorem for the row's clause on an extracted centre. **Ruled by a dated
amendment of the brief**:

> You found that the library states the ring form over four compact sets, that the ledger's sentence is over four points, and
> that the second follows from the first as a term (your iteration file's `l2_not_ae_outside_points`, on the standard three
> axioms). **Added to your job, and to your touches**: put that corollary into the exclusion's assembly module as a library
> theorem, named to match the orbit form's pair of names (`not_ae_outside_points`), under a docstring that reads it against the
> ledger's ring sentence and says it is the compact-set form at the two-point sets; register it in your audit block; then the
> full gate pass as planned. No other statement is added and none changes.
> — source: data/fs132/briefs/FS132-L2-landing.md § Amendment 1

**Done under it**: `theorem not_ae_outside_points` in `Proofs/HadwigerNelson/Plane/SixRing/Orbit.lean`, after
`not_ae_outside` — the binders of `no_outside_orbit_points` through `hr`, name for name, and the conclusion of
`not_ae_outside`; its proof the term of the iteration file; its docstring quotes row 155's ring sentence and says it is
`not_ae_outside` at `K j = {p, q j}`. One line in the module header's list, one record in this job's audit block, the
row of `ARCHITECTURE.md`. **No other statement is added and none changed.** Built (`data/fs132/l2/build-4-amendment.log`):
exit 0, "479 of 479 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 8m49s" (`Plane.SixRing.Orbit`, `Proofs`).

## Stage 5 — SAVED (FS132-L2): the registrations

**What the landing brings, as the kernel lists it** (`data/fs132/l2/decls.lean`, a dumper of this job: every constant
of the landing's twenty-two modules with its kind, whether it has a declaration range of its own — what a typed
declaration has and the elaborator's auxiliaries have not — and whether it is machine-written API of a structure):
**447 constants in 22 modules; 377 declarations a person or a generator typed** — 308 theorems, 66 definitions, 3
structures (the other 70: 45 auxiliaries such as `match_1`, `_proof_1`, `eq_1`, and 25 projections and constructors).

**Every one of the 377 is in a block of `scripts/Axioms.lean`, once** (`tools/fs132_l2_records.py … --unfiled`: "with
one line: 377; unfiled: 0; doubled: 0"). Before this job 262 were (the port's block 163, FS132-I3's 33, FS132-I4's 66),
and **115 were in none** — more than the brief's three groups name, and counted here by the kernel's list, not by eye:

| in no block | declarations | which |
|---|---|---|
| `Outside/OAI158Palette` (FS132-K1's port: the palette chain) | 94 | 60 lemmas, 34 definitions — the whole module |
| `Plane/SixRing/Basic` (FS132-K2) | 12 | 7 definitions (`hub`, `chart`, `ringRadius`, `shift`, `IsTip`, `HubColours`, `NoDoubleChange`), 2 structures (`ShiftBounds`, `OutsideOrbit`), 3 theorems (`ShiftBounds.mono`, `shiftBounds_model`, `HubColours.mono`) |
| `Plane/SixRing/Confine` (FS132-K1) | 6 | its six theorems |
| strays | 3 | `IsDensityPt` (the step lemma's one definition), `mem_liftPalette` (the one lemma of the palettes' module FS132-I4's block lacks), `FourCycleStraddle` (the structure) |

**The block headed "FS132-L2"** (`data/fs132/l2/axioms-block.txt` is its first form, generated from the unfiled list):
those 115, and by Amendment 1 `not_ae_outside_points` — **116 records**, under CLEAN, above the PURCHASED banner.
Definitions and structures are filed with the theorems, as the port's block files its 24 definitions. FS132-I3's block
loses one line (`chart_eq_polar_shift`, below): 32. The audit script holds 6,953 `#print axioms` lines = `main`'s 6,576 +
377. The port's generator still finds its block as generated ("OK: scripts/Axioms.lean holds the block, 163 records").

**Each filed on what it rests on, read from the audit's own output and not from the filing**: `tools/fs132_l2_records.py`
(this job's; after FS132-L1's, whose readers and whose filing of the eighteen imported records it imports) reads the
kernel's list and the saved log of `scripts/axioms.sh`, and requires every declaration of the landing to have exactly
one record, under CLEAN, on a subset of the standard three; the five headline theorems on exactly the three; and over
the whole log the records under IMPORTED to be the eighteen earlier landings filed and no other, no record outside an
import's filed set carrying it, none carrying two imports, none carrying `sorryAx`. **Twelve plants, in memory, one at
a time** — a record dropped; doubled; `sorryAx` under one; **a landing record resting on the transfer; one resting on
the five-colour theorem; one filed under IMPORTED on the three and the transfer** (the wrong filing); one under
PURCHASED; a native auxiliary under one; the headline on two of the three; a theorem of the landing with no record;
one of `main`'s records stripped of Weil's bound; a module absent from the dump. Its run on the gate's log is stage 9's.
**The import's own block and its wrong-filing control** (`tools/fs132_l1_block.py`, FS132-L1's, unedited) are run in
the gate pass on the import's module as it stands.

**The stale rows and the one docstring** (FS132-I4's draft D7). `ARCHITECTURE.md`: the eighteen rows of the landing's
modules that named a branch (`fs132-wk1`, `fs132-wi2`, `fs132-wi4`) no longer do — on `main` a branch name in a row is
false; five rows' "no `sorry` of its own" reads "no `sorry`" (nothing beneath has one); the two skeleton rows are gone
with their modules (stage 2); the palette module's row says the three instances are scoped and where the licence text
is; `Orbit`'s row names the four-point ring form. `Orbit.lean`'s module docstring, which said its leaves "are `sorry`
until implemented", says what is now true: no `sorry` here or beneath, who proved the leaves, and that each theorem
prints the standard three and rests on neither declared outside theorem. `tools/check_architecture.py`: `RESULT: PASS`
— 329 rows against 329 modules, 0 import mismatches (`data/fs132/l2/probes/arch-probe.out`).

**The one identity under two names — one of the two is gone, by one edit to an import.** `Chart.chart_eq_polar` and
`Shift.chart_eq_polar_shift` stated the chart's polar form, binder for binder the same (`(p : ℂ) (α d : ℝ) : chart p α
d = p + ((ringRadius d : ℝ) : ℂ) * Plane.e (α - π / 3 - d / 2)`), in two modules neither of which imported the other.
`Plane/SixRing/Shift` now imports `Plane/SixRing/Chart` in place of `Basic` (no cycle: `Chart` imports `Basic` alone,
and `Shift` reached `Basic` only directly); the helper `chart_eq_polar_shift` is deleted (its text:
`data/fs132/l2/Shift-removed-helper.txt`; the module before: `Shift-before.lean.txt`), and its one use — two rewrites in
`dist_chart_chart_shift`'s proof — calls `chart_eq_polar`. No statement of any other declaration moved; the two module
headers and the `Shift` row say it. A helper of FS132-I3's is removed, not a leaf of the planner's. Built
(`data/fs132/l2/build-3-registrations.log`): exit 0, "479 of 479 batches, 8 module(s) rebuilt, 0 module(s) with
warnings, 9m27s".

## Stage 6 — SAVED (FS132-L2): what the library assumes

`./scripts/assumptions.sh --self-test` first (`data/fs132/l2/probes/assumptions-selftest-first.out`): exit 0, "OK — all
33 checks behaved: every planted fault fired, and every partner stayed silent". Then the step
(`probes/assumptions-first.out`): **exit 1, three failures, one kind**, every one read:

```
FAIL undeclared-never-concluded HadwigerNelson.Outside.OAI158.RealState :: taken as a hypothesis by 3 constant(s) ([…states_densityOne, …two_state_impossible]), concluded by none: an assumption (.former) or a condition (.condition)?
FAIL undeclared-never-concluded HadwigerNelson.SixRing.FourCycleStraddle :: taken as a hypothesis by 2 constant(s) ([…not_ae_outside, …no_outside_orbit]), concluded by none: an assumption (.former) or a condition (.condition)?
FAIL undeclared-never-concluded HadwigerNelson.SixRing.OutsideOrbit :: taken as a hypothesis by 10 constant(s) ([…OutsideOrbit.ae_add_mem_or, …OutsideOrbit.hubColours_flip]), concluded by none: an assumption (.former) or a condition (.condition)?
```

**The scheme has a class for each: a condition on the theorem's parameters** (`LEAN.md` § Assumptions: "a former that
is only a condition on a theorem's parameters by `.condition ``Full.Name "reason"`"). None stands for an outside
theorem, a hand result of ours or an open question: each is a predicate of objects the theorem itself binds, taken to
be refuted or carried. Three lines in `AssumptionAudit.declared` (`scripts/Assumptions.lean`; before:
`data/fs132/l2/Assumptions-before.lean.txt`), each with its reason:
- `Outside.OAI158.RealState` — the release's state of a set of angles (`States.lean:92`): measurable and, up to a null
  set, inside the lifted palette of every label of `J`; built in the proof of `no_alternating_groups` from a measurable
  two-valued map.
- `SixRing.FourCycleStraddle` — the four-set hypothesis; taken only to be refuted together with `OutsideOrbit` under a
  weak six-colouring; the constant colouring satisfies it and is not weak (checked as a term, stage 7).
- `SixRing.OutsideOrbit` — the ring hypothesis, clauses (i) and (ii); taken only to be refuted or carried by the leaves
  under that refutation; **no declaration exhibits one** (said in the reason, and in stage 7).

**The brief's other five conditions ask nothing of the declared list**: `HubColours`, `NoDoubleChange`, `IsTip`,
`ShiftBounds` and `IsDensityPt` are each concluded by a theorem that takes no assumption (`OutsideOrbit.hubColours`,
`no_double_change`, `exists_tip`, `shiftBounds_model` and `exists_shiftBounds`, `ae_mem_imp_isDensityPt`), so the step
does not ask whether they are assumptions and prints no row for them.

After the three lines (`probes/assumptions-second.out`; after Amendment 1's theorem, `assumptions-third.out`): **exit
0** — "assumptions: OK — 3 outside theorem(s) as axioms, with 18 theorem(s) resting on them; 19 named and 16 inline
hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1".

| | `main` (FS132-L1's gated scan) | this tree |
|---|---|---|
| `=== SCANNED ===` | constants=14095 theorems=10430 formers=322 hypotheses=18019 closed=1473 | constants=14516 theorems=10782 formers=338 hypotheses=18802 closed=1473 |
| the nine | axioms=3 rests=18 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 | **the same nine** |
| the rest | conditions=35 … silent=1 cohyp=58 hints=0 unseen=16040 fails=0 | conditions=**38** … silent=1 cohyp=58 hints=0 unseen=16765 fails=0 |

`closed` does not move: the landing brings no hypothesis that is a statement about the world. The recorded counts in
the ledger's header and in `CLAUDE.md` § Trust ledger both read "match (9 of 9 compared)" — nothing there is stale.
`./scripts/assumptions.sh --write-ledger` (`probes/assumptions-write-ledger.out`): exit 0, "ledger written (117
rows)"; **the ledger gains no row and loses none** (`diff` with the text before, `data/fs132/l2/assumptions-ledger-before.txt`:
empty). No theorem of the landing rests on an axiom of the library or takes a declared hypothesis: nothing it brings
is conditional.

## Stage 7 — SAVED (FS132-L2): the vacuity step

`./scripts/vacuity.sh` (`data/fs132/l2/probes/vacuity-probe2.out`, after Amendment 1's build): **exit 0, "vacuity:
OK"**.

| | `main` (FS132-L1's gated scan) | this tree |
|---|---|---|
| declarations | 14845 | **15292** (+447: the landing's 447 constants, the dump's own count) |
| refutations-skipped | 215 | **226** (+11) |
| sites | 1447 | 1447 |
| vacuous / stale / declared / witnessed / generic / unknown | 0 / 0 / 3 / 38 / 1404 / 2 | the same |

**How the scan classes every new site: there is none.** A site is a binder on a tracked carrier — a `Coloring` type,
or one of the scan's tracked predicates (`scripts/Vacuity.lean`, `trackedProps`). No statement of the landing has one:
its colourings are maps `c : ℂ → Fin k` under `WeakColoring k c`, which the scan does not track (FS132-L1 found the
same of the import's `ProperColoring`). So no row is added, none reads `VACUOUS` or `UNKNOWN`, the baseline's two
entries are as they were, and **the scan is silent about these theorems — it is not evidence that their hypotheses can
be met.** That evidence is below. `scripts/vacuity-baseline.txt`: its header's two count lines, from
`scripts/gate_report.py header` on the final scan (`diff` of the script's output with the file's lines: none); no entry
touched.

**The eleven refutations it skips** (the counter's `REF` lines, `probes/count-modules-probe.out`): of the exclusion,
`no_outside_orbit_points`, `no_outside_orbit`, `adjacent_tip_false` (`Orbit`), `chart_step_false`, `step_kill`,
`step_kill_left` (`Kill`), `density_triple_false` (`StepLemma`), `no_alternating_groups`, `no_alternating_pairs`
(`TwoPairs`); of the port, `two_state_impossible` and `triangleAngle_ratio_irrational`. `not_ae_outside` and
`not_ae_outside_points` conclude a stated negation, so they are audited, not skipped — and have no tracked binder.

**The five theorems: each structure of hypotheses, and its model short of the conclusion.** A refutation's hypotheses
are jointly unsatisfiable; what is asked is that no single structure among them is empty by accident.

| structure of hypotheses | its model | how it is held |
|---|---|---|
| a Borel colouring of the plane, weak, at six labels (`hc`, `hw`) | **whether one exists is the open question**: one exists exactly when the plane is six-colourable (`Outside.OAI158.exists_weakColoring_iff_nonempty_aeColouring`, `colorable_iff_nonempty_aeColouring`, the second on the declared outside theorem `proper_to_borel_weak`). At seven labels: `Outside.OAI158.proper_to_borel_weak_model` — a Borel weak seven-colouring, this library's `Plane.r7_aeColouring` | [kernel] at seven; open at six, and the docstrings of all five say so |
| four labels in a cycle and the two others (`ha`, `hXY`, `hX`, `hY`) | `a = (0, 1, 2, 3)`, `X = 4`, `Y = 5` | [kernel, an iteration file]: `l2_labels_model`, `data/fs132/l2/points-form.lean` (four `decide`s) |
| the four points or sets with their straddle exclusions (`hq`, `hl`, `hr`; `FourCycleStraddle`) | the constant colouring `X` with any four two-point sets through `p`: the classes of the cycle's labels are empty, so their essential supports are — **a measurable colouring that is not weak** | [kernel, an iteration file]: `l2_fourCycleStraddle_model`, the same file, on the standard three; the structure's docstring says it in words. With a **weak** colouring: at seven labels, near a vertex of the hexagonal colouring for the vertex's three labels — the theorem record's control `margin-witness`, [tools], and for three labels, not a four-cycle |
| the ring hypothesis, clauses (i) and (ii) (`hδ`, `hi`, `hii`; `OutsideOrbit`) | the two-colouring of the plane by a line through `p`, `X` on one side and `Y` on the other, at the line's direction — measurable, not weak | **in words only**: `OutsideOrbit`'s docstring says "not proved here". A palette is a limit of angular samples; no declaration of this library computes one for a given colouring |
| the two disjoint pairs and the map `w` (`no_alternating_pairs`) | `D = {0, 1}`, `D' = {2, 3}`; a measurable `w` alternating under the 60° rotation: `w(t) = ⌊3t/π⌋ mod 2` | the pairs are immediate; the inclusion `w(e) ⊆ P_p(e)` almost everywhere is the clause the theorem refutes at six labels, and "at `k = 7` … the statement is not claimed" (its docstring) |
| the real-analysis and chart leaves under them (`ShiftBounds`, (†), density points, `HubColours`) | `shiftBounds_model`, `exists_shiftBounds`; the half-line examples of `StepLemma`; `isDensityPt_of_mem_nhds` | [kernel], in the modules (`Basic`'s `shiftBounds_model`, `Confine`'s model of both cases, and `StepLemma`'s `example`s headed "Model of the hypotheses of …", one per leaf) |

**All hypotheses but weakness, at once**: the line two-colouring meets the labels, the four points (its classes of the
cycle's labels are empty) and, in words, the ring hypothesis — and is not weak. **All hypotheses but "six"**: at seven
labels a weak colouring exists, and whether it meets the others at some centre "is not known to this library"
(`OutsideOrbit`'s docstring). So the theorems are not vacuous by an empty structure that the kernel can see; the two
places where the model is in words and not in the kernel are named in "Open gate items" below.

## Stage 8 — SAVED (FS132-L2): read aloud — the five theorems against the row's sentence and the entries' statements

*The statements are read as the kernel holds them (`data/fs132/l2/gate/checks-final.out`: `#check @…` of each, and
`#print` of every definition they name), never as the files print them. The row is `LEDGER.md` row 155; the entries are
`plans/FS132-derivation.md` § 1.*

**The definitions the statements name**, each at its source line in `Outside/OAI158` and `Outside/OAI158Palette`:
`WeakColoring k c` — `c` is almost-everywhere measurable and `c z ≠ c (z + direction u)` for almost every pair `(z, u)`
of a point and an angle, plane measure times normalized Haar measure on the circle of angles; `spatialSupport c i` —
the support of plane measure restricted to the class `{z | c z = i}`, a closed set: the row's "closed essential
support of the class"; `Straddle K` — `{z | ∃ p ∈ K, ∃ q ∈ K, dist z p < 1 ∧ 1 < dist z q}`: the row's "min over q ∈ K
of |z − q| below 1 and max over q ∈ K of |z − q| above 1" (for the two-point sets and for compact `K` the two say the
same; `Confine.mem_straddle_iff_min_max` is that statement); `palette c hc x t` — the release's Definition 5.1 at the
centre `x`, a finite set of labels for each angle `t`; `sixty` — `π/3`; `angularMeasure` — normalized Haar measure on
`ℝ / 2π`.

**1. `SixRing.no_outside_orbit_points` — the orbit form over four points (the row's first sentence; entry C132-WIT-ORBIT).**

| the row's clause | the Lean binder | verdict |
|---|---|---|
| "let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (…)" | `{c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}` | **the instance `U = ℂ` only**; "measurable" is Borel measurability here (`Measurable c`), beside the release's weak-colouring condition |
| "let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two" | `{a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y) (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y)` | the same: four distinct labels, two distinct others |
| "for each j modulo 4 let q_j be a point other than p" | `{q : Fin 4 → ℂ} (hq : ∀ j, q j ≠ p)` | the same |
| "with H_{a_j} ∩ Δ({p, q_j}) = ∅ and H_{a_{j+1}} ∩ Δ({p, q_j}) = ∅" | `(hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))`, `(hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j}))` | the same; `j + 1` is addition in `Fin 4`, modulo 4 |
| "then there are no angle ψ and number δ > 0 such that" | `(ψ δ : ℝ) (hδ : 0 < δ)` … `: False` | the same |
| "(i) for every integer k and almost every θ with \|θ − ψ − kπ/3\| < δ the palette P_p(e(θ)) … contains X or Y" | `(hi : ∀ k : ℤ, ∀ᵐ θ : ℝ, \|θ - ψ - k * (Real.pi / 3)\| < δ → X ∈ palette c hc p (θ : Angles) ∨ Y ∈ palette c hc p (θ : Angles))` | the same; almost every with respect to Lebesgue measure on the line, the angle read modulo `2π`; "with samplings inside U" has nothing to say at `U = ℂ` |
| "(ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure" | `(hii : ∀ η : ℝ, 0 < η → 0 < volume {θ : ℝ \| θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ X ∈ palette …} ∧ 0 < volume {θ : ℝ \| θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ Y ∈ palette …})` | the same |

Aloud: *colour the whole plane with six labels, Borel measurably, so that almost every pair of points one unit apart
gets two labels. Fix a point, four of the labels in a cyclic order and the two that are left. Suppose that for each
consecutive pair of the cycle there is a second point such that neither label of the pair has any of its mass among the
points nearer than one to one of the two points and farther than one from the other. Then the two left-over labels
cannot do this on the unit circle about the point: appear, one or the other, in almost every palette near each of six
directions sixty degrees apart, and both appear with positive measure in every neighbourhood of one of those
directions.* **It is the row's sentence at `U = ℂ`.**

**2. `SixRing.no_outside_orbit` — the orbit form over four compact sets (entry C132-M-ORBIT).** As 1, with the
entry's "for each j modulo 4 let K_j be a compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅
and H_{a_{j+1}} ∩ Δ(K_j) = ∅" as `{K : Fin 4 → Set ℂ} (hK : FourCycleStraddle c p a K)`, the structure's five fields
being those five conditions (`compact`, `centre_mem`, `other`, `left`, `right`). **The entry's statement at `U = ℂ`.**

**3. `SixRing.not_ae_outside` — the ring form over four compact sets (entry C132-M-EXCL).** "let U, p, c, the labels
a_0, a_1, a_2, a_3, X, Y and the sets K_0, K_1, K_2, K_3 be as in C132-M-ORBIT; then it is not the case that for almost
every unit vector e the palette P_p(e) contains X or Y" — the binders of 2 without `ψ`, `δ`, (i), (ii), and the
conclusion `¬ ∀ᵐ t ∂angularMeasure, X ∈ palette c hc p t ∨ Y ∈ palette c hc p t`: almost every direction with respect
to the circle's normalized measure. **The entry's statement at `U = ℂ`.** *It is not the row's ring sentence word for
word*: the row writes the ring form over four **points** ("the points q_0, q_1, q_2, q_3 be as in C132-WIT-ORBIT").
The Lean statement is the stronger of the two wordings; sent to the coordinator when found, and ruled by the brief's
Amendment 1 (below).

**4. `SixRing.not_ae_outside_points` — the ring form over four points (the row's ring sentence; entry C132-WIT-EXCL).
Added by this landing under the brief's Amendment 1** ("put that corollary into the exclusion's assembly module as a
library theorem, named to match the orbit form's pair of names"). "let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and
the points q_0, q_1, q_2, q_3 be as in C132-WIT-ORBIT; then it is not the case that for almost every unit vector e the
palette P_p(e) contains X or Y" — the binders of 1 through `hr`, name for name and kind for kind, and the conclusion
of 3. Its proof is one term: `not_ae_outside` at `K j = {p, q j}`, each a finite set (compact), containing `p` and
`q j ≠ p`. First checked in an iteration file (`data/fs132/l2/points-form.lean`), then a theorem of
`Plane/SixRing/Orbit.lean`. **The row's ring sentence at `U = ℂ`.**

**5. `SixRing.no_alternating_pairs` — the two-pair ring (entry C132-DIAG-WIDE; in the row "beside it, and not this
milestone's").** "let U be an open set …, c a weak measurable six-colouring of U, and D, D′ two disjoint pairs of
labels; then there is no measurable map w from the unit circle to {D, D′} with w(e) ⊂ P_p(e) and w(Re) ≠ w(e) for
almost every unit vector e, R the rotation by π/3" — `(hc : Measurable c) (hw : WeakColoring 6 c) (p : ℂ) {D D' : Finset
(Fin 6)} (hD : D.card = 2) (hD' : D'.card = 2) (hdisj : Disjoint D D') (w : Angles → Bool) (hwm : Measurable w) (hsub :
∀ᵐ t ∂angularMeasure, (if w t then D' else D) ⊆ palette c hc p t) (halt : ∀ᵐ t ∂angularMeasure, w (t + (sixty :
Angles)) ≠ w t) : False`. The map to `{D, D′}` is a map to `Bool` (`false ↦ D`, `true ↦ D'`); the rest clause for
clause. **The entry's statement at `U = ℂ`**; the release's `two_state_impossible` read at six labels, as the row says.

**What the Lean statements do not say that the row does** — in words the filing can use:

1. **The open-set form.** Every Lean statement is for a colouring of the whole plane. The row and the entries are
   written for a colouring of an open set `U` containing the closed unit disc about `p`, with palettes read from
   samplings inside `U`. That form is in no Lean theorem; it stands, as the entry's "What it stands on" says, on one
   mind's reading of the release's two palette proofs as local (M0), [hand].
2. **The extracted centre.** The row's last clause of its ring sentence — "at an extracted centre with a cycle of four
   labels, C132-M-EMPTY" — has no Lean theorem: nothing in the library states the extraction or its fixed form.
3. **Borel measurability.** Every Lean statement asks `Measurable c` — Borel measurability of the colouring — beside
   `WeakColoring 6 c`, whose own first clause is only measurability almost everywhere. The palette is defined from a
   Borel colouring (`palette c hc`). The row says "measurable"; the kernel's theorem is for Borel colourings.
4. Nothing else: the labels, the points or sets, the straddle regions, the two clauses on the ring and the conclusion
   are the row's, clause for clause, and the row's "Not claimed" lines are true of the Lean statements too (the
   labels `a j` are not asked to be present near `p`; nothing at seven labels; nothing about a cycle of another length).

## Stage 9 — SAVED (FS132-L2): the full gate on one commit — `b46a9d57`

One pass is every step in order, one at a time under the slot (`data/fs132/l2/run-gate.sh final`, after FS132-L1's
runner, launched from a snapshot copy; every log under `data/fs132/l2/gate/` with its exit status on its last line;
`run-gate-final.head` records the commit and that **no tracked file was modified**; `run-pass-final.out` holds every
step's exit; 15:31Z–15:56Z). **Every step exit 0 but the one planted control that must exit 1** (the scan difference's
plants); "tracked files modified after the pass: 0". Counts below are read from the saved logs, not from the runner's
summary. It is the **first** full pass of this job: none was red.

**Before the pass, the lint's negative control** (`data/fs132/l2/lint-plant.sh`, FS132-L1's script pointed at a module
of this landing; `lint-plant-run.out`): `theorem zz_l2_lint_plant [Nonempty ℕ] : (1 : ℕ) = 1 := rfl` planted at the end
of `Plane/SixRing/TwoPairs.lean` (never committed), built — "479 of 479 batches, 2 module(s) rebuilt, **0 module(s)
with warnings**" (`lint-plant-build.log`: the build's own linters do not see it) — then the guarded lint: **exit 1**,
"`unusedArguments`: (2/2) Failed with 1 messages", "error: @zz_l2_lint_plant 1 unused argument" (`lint-plant.log`).
Restored by `git checkout` under a trap: the digest is the one taken before, the plant's name in the file 0 times, no
tracked file modified; the pass's build recompiled the module and the root from the restored text.

| step | result, read from its saved log (`data/fs132/l2/gate/`, tag `final`) | log |
|---|---|---|
| build | "build: OK — 479 of 479 batches, 2 module(s) rebuilt, **0 module(s) with warnings**, 8m49s" (`Plane.SixRing.TwoPairs`, `Proofs`: the restore after the lint control); lines holding "warning" in the build log: 1, that sentence; in Lake's full log: 0 | `build-final.log`, `receipt-build-final.log` |
| `sorry` | narrow pattern (`^\s*sorry\s*$`, `:= sorry`, `by sorry`): **0** lines; `\bsorry\b`: 24, all prose (stage 2's 25 less the header line this job rewrote) | `sorry-narrow-final.txt`, `sorry-wide-final.txt` |
| `axiom` lines in `Proofs/` | 4 line-initial, as on `main`: the two imports (`OAI158.lean` ll. 107, 119), `kloosterman_bound`, and one line of a docstring's code block (`Sat/Lrat.lean` l. 85). **Three axioms; the landing brings none** | `axiom-lines-final.txt` |
| doubled names, **after the build and before the audit** (`--mem 16`) | "scanned 7490 modules, 1866 of them the package's (1866 source files)"; "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)" | `dupnames-final.log` |
| its self-test | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-final.log` |
| every declaration in a block, before the audit | "declarations the landing brings: 377 (of 447 constants in 22 modules); with one line: 377; unfiled: 0; doubled: 0" | `unfiled-final.txt` |
| axioms | "audited: **6953 records — 6910 clean on the standard axioms, 20 axiom-free, 18 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "declared imports (3): …kloosterman_bound, …no_proper_five_coloring, …proper_to_borel_weak"; "library axioms other than native auxiliaries (3): … every one declared"; "axioms: OK". `CLAUDE.md` § Trust ledger flagged stale, "6533 clean → 6910" (draft 1) | `axioms-final.log`, `receipt-axioms-final.log` |
| its self-test | "OK — every planted fault fired, and every partner passed." (the controls file is untouched: no control's expected count reads a number this landing moves — it adds no import) | `axioms-selftest-final.log`, `receipt-axioms-self-test-final.log.xz` |
| **every declaration of the landing filed on what it rests on** (`tools/fs132_l2_records.py`) | "landing: 447 constants in 22 modules; declarations it brings: 377 (308 THM, 66 DEF, 3 IND); records in the log: 6953"; "landing records on exactly the three: 376", "on fewer: [Quot.sound, propext]: 1"; the five headline lines, each "under CLEAN: [Classical.choice, Quot.sound, propext]"; "records carrying kloosterman_bound: 8 (filed: 8); of the landing's: 0", "…no_proper_five_coloring: 5 (filed: 5); of the landing's: 0", "…proper_to_borel_weak: 5 (filed: 5); of the landing's: 0"; "records under IMPORTED 18; carrying two imports 0; carrying sorryAx 0"; "records: PASS" | `records-final.txt` |
| its plants | twelve, one at a time, "every one of 12 fired; the unplanted lists pass" (stage 5 lists them; the wrong filing — a landing record under IMPORTED on the transfer — among them) | `records-plant-final.txt` |
| the import's block as filed, with its two controls (`tools/fs132_l1_block.py`, FS132-L1's) | "records filed: 22 as filed: 22 (clean 12, on H 5, on T 5) refused: 0"; the wrong filing: refused exactly `six_le_chiM0`, `chiM0_six_or_seven`, `seven_le_chromaticNumber_plane_iff`, "CONTROL FIRED AS EXPECTED"; the planted `sorry`: refused eleven; each read as a plain check exits 1; "block: PASS — every record as filed; both controls fired" | `block-final.txt`, `block-*-final.*` |
| the generated modules and the licence copy against the generator | "CHECK OK" (ten files; the block of 163 records); "SELF-TEST OK: 10 plants refused and 1 partner accepted" | `port-check-final.txt`, `port-selftest-final.txt` |
| vacuity | "scanned: **declarations=15292 refutations-skipped=226**"; "sites: **sites=1447 vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2**"; "evidence: 18 emptiness proof(s), 63 witness(es)"; the baseline's header "match (9 of 9 compared)"; "UNKNOWN …hexShell_plane5", "UNKNOWN …hexShell_plane6", held as on `main`; "vacuity: OK". `CLAUDE.md` § The gate flagged stale on two counts (draft 4) | `vacuity-final.log`, `receipt-vacuity-final.log` |
| the scan against `main`'s, row for row | "main rows 1528, landing rows 1528; lost 0 (0 with a removed declaration); added 0"; twenty-two new modules, "by module: declarations +447, refutations +11: equal to the scans difference"; "vacdiff: PASS" | `vacdiff-final.txt` |
| its self-test, and the difference's plants | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent."; the plants: exit 1 — COUNTER-DISAGREES, LOST, NOT NEW, FLAGGED, MODULE-SUM | `vacuity-selftest-final.log`, `vacdiff-plant-final.txt` |
| assumptions | "assumptions: OK — 3 outside theorem(s) as axioms, with 18 theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1"; "assumed: **axioms=3 rests=18 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1**"; "decided: … conditions=38 fails=0"; "hints=0 silent=1 unseen=16765"; the ledger's header and `CLAUDE.md` § Trust ledger both "match (9 of 9 compared)" | `assumptions-final.log`, `receipt-assumptions-final.log` |
| its self-test | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent." | `assumptions-selftest-final.log` |
| architecture | "RESULT: PASS" | `arch-final.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!"; its control red before the pass (above) | `lint-final.log`; `../lint-plant.log` |
| notes, as the last landing ran them | `tools/fs131_l5_notes.py --only-flagged`: "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", 0 CONFLICT — `main`'s count: **the check reads the modules of QA4's audit, none of them this landing's**; `tools/fs131_qa4_notes.py --self-test`: "OK (6 controls, 1 planted)" | `notes-l5-final.txt`, `notes-qa4-selftest-final.txt` |
| **the import's stored-term comparison, on this commit** (the module's olean `0f3b15f3…`, FS132-L1's) | "declarations: 8 compared: 8 identical: 8 different: 0", "READ-BACK IDENTICAL: all 8 declarations, term for term, modulo the namespace"; "SELF-TEST OK: … 6 plants"; the Lean control "FIRED AS EXPECTED"; 0 files written at the release's side; "READ-BACK RUN gate-final: OK" | `readback-import-final.txt`; `../readback-import/*-gate-final.*` |
| **the port's stored-term comparison, on this commit** | the release's print `c3343d13…` and this library's print `7874161e…`, each the port's committed print byte for byte; "READBACK OK"; the port's tables unchanged as git sees them; "SELF-TEST OK: 13 plants refused, the unplanted pair passes"; "LEVEL1 OK"; "PORT READ-BACK RUN gate-final: OK" | `readback-port-final.txt`; `../readback-port/*-gate-final.*` |
| the five theorems by `#check`, with their axioms | each as stage 8 reads it; each "depends on axioms: [propext, Classical.choice, Quot.sound]"; the two controls print their imports (`not_colorable_five`, `chromaticNumber_plane_eq_chiM0`) | `checks-final.out` |
| the baseline and the scan's source | "baseline entries: unchanged from main's (2)"; lines of `scripts/Vacuity.lean` that differ from `main`'s: 0 | `baseline-final.txt` |
| the three digests against the previous landing's receipts (`data/fs132/l1/gate/receipt-*-final.log`) | axioms: **377 rows added**, every one CLEAN, none removed; "clean records, by axiom set: 6745 [propext, Classical.choice, Quot.sound], 86 [propext, Quot.sound], 78 [propext], 1 [Quot.sound]". vacuity: the two counts move, **no row added or removed**. assumptions: **three rows added**, the three `CONDITION` rows of stage 6, nothing else | `digest-axioms-final.txt`, `digest-vacuity-final.txt`, `digest-assumptions-final.txt` |

**Read aloud against the informal claim.** The claim of this landing: "the first night's exclusion is a kernel theorem
for a colouring of the whole plane, and so is everything of the release that it stands on." What the gate shows: no
`axiom` enters and no `sorry` is in `Proofs/`; every one of the 377 declarations the landing brings has one record,
under CLEAN, on a subset of the standard three, and none rests on either declared outside theorem or on Weil's bound;
no name is declared twice, so each printed list is the list of the proof the kernel checked; nothing the landing brings
takes a declared hypothesis, so nothing in it is conditional; the ported text is the generator's, the licence copy the
release's file, and the stored statements and definitions print as the port's own did. **What the gate does not show,
and this record says**: that the hypotheses of the five theorems can be met short of the conclusion — the scan has no
site there, and stage 7 names each model and how it is held; that the row's own sentence, on an open set, is a theorem
— it is not, and stage 8 says what is; and that the port is the release's term for term, which no check can show
across two Mathlib pins (the port's record § 3.3).

## Open gate items at this landing

1. **`OutsideOrbit` has no kernel model.** Its docstring names one in words (the two-colouring by a line through `p`,
   "not proved here"), and `scripts/Assumptions.lean`'s reason says "no declaration exhibits one". Computing a palette
   of a given colouring is not something this library can yet do; a model would be a small module of its own.
2. **The hypotheses of the five theorems have no joint kernel model short of one clause.** At six labels the first
   hypothesis is the open question; the docstrings say so and name what satisfies the rest (`LEAN.md` § The gate, the
   rule's third form). The two iteration terms of `data/fs132/l2/points-form.lean` (the labels; `FourCycleStraddle` at
   the constant colouring) are checked and are not library theorems: Amendment 1 adds one statement and no other.
3. **The note on the hexagonal colouring in `no_outside_orbit_points`'s docstring** ("satisfies the analogous local
   hypotheses on the points `q j` at a point near which three tiles meet") stands on the theorem record's control
   `margin-witness` — [tools], and for the vertex's three labels, not a four-cycle. It says "analogous"; a reader should
   not take it for a model of the four-cycle hypothesis.
4. **`Outside/OAI158.lean`'s header does not name the licence** (the import's module, on `main`, hand-written; ten
   declarations copied from the release's `Coloring.lean`). Not this landing's module and not generated; held.
5. **The vacuity scan tracks no carrier of these modules** (`WeakColoring`, as `ProperColoring` at FS132-L1): for the
   tooling job, beside FS132-L1's questions. And the notes check reads QA4's modules only: no instrument reads the
   model notes of `Plane/SixRing`.

## Drafts for the front page (FS132-L2)

*For the coordinator to file; nothing here is filed by this job. Each names its slot — the file, the section, and **the
exact words on `main` it replaces or follows**, read on the merged tree — and the log line it comes from. The gated
commit is `b46a9d57`; its logs are `data/fs132/l2/gate/*-final.*` (`receipt-axioms-final.log`,
`receipt-vacuity-final.log`, `receipt-assumptions-final.log` are the three scans' full outputs).*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 6533 clean and 5 declared
purchases, and 18 imported (and 20 axiom-free; 6,576 records at the landing of FS-132's import, FS132-L1, 2026-10-07)"
— from `axioms-final.log`, "audited: 6953 records — 6910 clean on the standard axioms, 20 axiom-free, 18 imported
(resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 6910 clean and 5 declared purchases, and 18 imported (and 20 axiom-free; 6,953 records at the
> landing of FS-132's first theorem, FS132-L2, 2026-10-07)

The 377 records the landing adds are all clean (`records-final.txt`: 376 on exactly the standard three, one on two of
them; none imported, none a purchase): 6533 + 377 = 6910; 6576 + 377 = 6953; imported, axiom-free and purchases do
not move. Until it is filed the audit flags the sentence stale (not failed): "6533 clean → 6910".

**2. `CLAUDE.md` § Trust ledger, one sentence on the port** (the port's draft D1, at the joined tree). *Follows* "its
first import, `[Falconer1981]` Lemma 2 (i), is a theorem since FS131-IF1." and stands before "Rung B holds none." —
from `records-final.txt` ("whole log: records carrying … of the landing's: 0", three times) and
`readback-port-final.txt`:

> Four lemmas of `[OAIMath2026]` family 158 that FS-132's first theorem stands on — `Outside.OAI158.palette_transfer_pair`,
> `palette_sixty_disjoint`, `two_state_impossible` and `mem_spatialSupport_ae` — are not imports: their proofs are ported
> (the palette chain and 163 further declarations in nine generated modules, FS132-K1 and FS132-I2), kernel-checked at
> this pin on the standard three, and rest on neither declared outside theorem; the release's licence text is kept beside
> them (`Outside/OAIMath2026-LICENSE.txt`).

**3. `CLAUDE.md` § Trust ledger, the nine assumption counts.** *No change*: `receipt-assumptions-final.log`,
`=== TOTALS ===`, reads `axioms=3 rests=18 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1`, the nine
on `main`; the step reads "recorded counts in CLAUDE.md § Trust ledger: match (9 of 9 compared)". The landing declares
three conditions on parameters (`conditions=35 → 38`), which are not among the nine, and the ledger gains no row.

**4. `CLAUDE.md` § The gate, the vacuity scan's two count lines.** *Replaces* "`declarations=14845
refutations-skipped=215 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`." — from
`vacuity-final.log`, "scanned: declarations=15292 refutations-skipped=226", "sites: sites=1447 vacuous=0 stale=0
declared=3 witnessed=38 generic=1404 unknown=2":

> `declarations=15292 refutations-skipped=226 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`.

Until it is filed the scan flags `CLAUDE.md` § The gate stale (not failed) on two counts: declarations,
refutations-skipped. The sentences on the baseline's two entries stand.

**5. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`** — one entry after the last (`(("6521", "5"), ("6533", "5"))`):

```python
    (("6533", "5"), ("6910", "5")): "FS-132, the landing of its first theorem — the first night's exclusion at the whole plane over the release's palette lemmas, ported (FS132-L2; copy data/fs132/l2/gate/receipt-axioms-final.log, gated commit b46a9d57): 6,953 records, 6,910 clean, 20 axiom-free, 18 imported, 5 purchases",
```

and, in the same file's table of superseded counts, after the entries for `"6521"` and `"6554"`, the two that this
filing supersedes, in that table's own form: `"6533"` (6910 clean) and `"6576"` (6,953 records), "refiled at FS132-L2's
landing from data/fs132/l2/gate/receipt-axioms-final.log; the old count stays in
data/fs132/l1/gate/receipt-axioms-final.log and in GATE_CHANGES". The previous landing's receipts, against which the
three digests were taken: `data/fs132/l1/gate/receipt-axioms-final.log`, `receipt-vacuity-final.log`,
`receipt-assumptions-final.log`.

**6. `CLAUDE.md` § Frontier, § Paths forward, "Open milestones" — the sentence on this milestone's Lean phase.**
*Replaces* "Its Lean phase has begun, on the first night's exclusion (row 155; branches `fs132-wk1`, `fs132-wi2`), what
the module rests on being formalized in that phase (his word of the same day); Closed when the module passes the gate.":

> Its Lean phase's first theorem is through the gate (FS132-L2, 2026-10-07): the first night's exclusion for a Borel
> colouring of the whole plane — the orbit form `SixRing.no_outside_orbit_points`, `no_outside_orbit` and the ring form
> `not_ae_outside_points`, `not_ae_outside` (row 155) — kernel-checked on the standard three axioms, with no import and
> no assumption, over the release's palette lemmas ported with their proofs (`Outside/OAI158Palette` … `OAI158States`;
> what the module rests on is formalized with it, his word of the same day). The statement on an open set and the
> clause on an extracted centre stay [hand]. The milestone is Closed when the rest of its module passes the gate: the
> index lemmas and the centres are skeletons on branch `fs132-wk1`.

And in the same section's "Last filed:" sentence, *replaces* "no value moved; its Lean phase begun)" by "no value
moved; its first theorem through the gate at the whole plane, FS132-L2)". Whether "Last filed" names this landing as
its own item, as it names FS132-L1's, is the coordinator's.

**7. `LEDGER.md` row 155.** *(a) Replaces* its grade sentence, "**[hand], one mind, with a line-by-line checking
reading of its steps M4–M9 by a second mind — the kernel lane's planner, whose own blind route reached the state, the
chart, a forced label at each hub, the unit-pair relation and the kill for a clean change, and stopped at the step
lemma; steps M6 and M8 have one derivation each; kernel pending (the first module of FS-132's Lean phase).**" — from
`records-final.txt` (the five headline lines) and `checks-final.out`:

> **[kernel] for a Borel colouring of the whole plane (FS132-L2, 2026-10-07; every step M1–M9):
> `HadwigerNelson.SixRing.no_outside_orbit_points` (the orbit form over four points, C132-WIT-ORBIT), `no_outside_orbit`
> (over four compact sets, C132-M-ORBIT), `not_ae_outside_points` (the ring form over four points, C132-WIT-EXCL) and
> `not_ae_outside` (over four compact sets, C132-M-EXCL), `Proofs/HadwigerNelson/Plane/SixRing/Orbit.lean`, each on
> `[propext, Classical.choice, Quot.sound]`, resting on no declared outside theorem and taking no assumption in
> hypothesis form — over the release's palette lemmas, ported with their proofs and kernel-checked here
> (`Outside/OAI158Palette`, `OAI158CircleMaps` … `OAI158States`). [hand], one mind, with a line-by-line checking reading
> of its steps M4–M9 by a second mind — the kernel lane's planner, whose own blind route reached the state, the chart, a
> forced label at each hub, the unit-pair relation and the kill for a clean change, and stopped at the step lemma — for
> what no Lean theorem states: the statement as written, on an open set containing the closed unit disc (it adds M0, one
> mind's reading of the release's two proofs as local), and the clause at an extracted centre (C132-M-EMPTY).**

*(b) Replaces*, in "**What it stands on:** for a colouring of the whole plane, two statements of `[OAIMath2026]`,
kernel-checked there at every number of labels (the transfer of palettes for a pair; the 60° disjointness), and its
nine steps M1–M9;", the words "kernel-checked there at every number of labels" by "kernel-checked there at every number
of labels and, ported, here (`Outside.OAI158.palette_transfer_pair`, `palette_sixty_disjoint`)", and "its nine steps
M1–M9" by "its nine steps M1–M9, each now a kernel theorem".

*(c) Replaces*, in "no ring alternates under the 60° rotation between two disjoint pairs of labels (C132-DIAG-WIDE) —
for the whole plane an instance of `[OAIMath2026]`'s Lean theorem `two_state_impossible`;", the words after the dash up
to the semicolon by "for the whole plane an instance of `[OAIMath2026]`'s Lean theorem `two_state_impossible`, in this
library `SixRing.no_alternating_pairs` (`Plane/SixRing/TwoPairs.lean`, [kernel], the standard three, from the ported
theorem)".

*(d) The row's address cell*: *follows* "`plans/FS132-kernel-plan.md` on branch `fs132-wk1`" with "; `Proofs/HadwigerNelson/Plane/SixRing/`
(`Orbit.lean`: the four theorems; `TwoPairs.lean`), `plans/FS132-L2-landing.md`", and "on branch `fs132-wk1`" goes: the
plan is on `main` since this landing.

*What the row may not say*: "[kernel]" without "for the whole plane" — the row's own sentence is written on an open
set, and that form is [hand]; "two derivations" of M6 or M8 — the kernel checked those steps, which is not a second
mind's derivation and is stronger for the statement it checked.

**8. `plans/FS132-derivation.md` § 1 — one dated line under the entries C132-M-ORBIT, C132-WIT-ORBIT, C132-M-EXCL,
C132-WIT-EXCL, and under "Who did what, step by step"** (FS132-I3's draft 2 and FS132-I4's D1, reconciled, at the gated
commit; the entries' `grade:` and `minds:` fields are the coordinator's):

> **2026-10-07, FS132-L2 — [kernel], for a Borel colouring of the whole plane (the instance `U = ℂ`), through the full
> gate at `b46a9d57`**: `HadwigerNelson.SixRing.no_outside_orbit_points` (C132-WIT-ORBIT), `no_outside_orbit`
> (C132-M-ORBIT), `not_ae_outside` (C132-M-EXCL), `not_ae_outside_points` (C132-WIT-EXCL; added at the landing, the
> compact-set form at the two-point sets), `Proofs/HadwigerNelson/Plane/SixRing/Orbit.lean`, each on `[propext,
> Classical.choice, Quot.sound]`, no assumption in hypothesis form, no outside theorem — over the release's palette
> lemmas ported with their proofs (`Outside/OAI158…`, FS132-K1 and FS132-I2). Statements FS132-K2's (the four-point
> ring form FS132-L2's, by a ruling). **Every step M1–M9 is checked by the kernel**: M1–M3 `State` (FS132-I4); M4–M6
> `Tips`, with M6's count as 64 patterns by `decide` (FS132-I4); M7 `Shift` — the unit-pair relation in the direction
> used (`dist_chart_chart_shift`), the sign (`shift_pos`), the bounds (`exists_shiftBounds`), with no derivative
> computed and the square's side not explicit (FS132-I3) — and its null sets, `ChartMeasure.unitPair_chart_ae`, by the
> partner point's motion on its unit circle, with no inverse function theorem (FS132-I4); M8 `StepLemma.step_lemma`,
> Lemma S along the planner's variant — a dyadic window, a base point of four density points (FS132-I3) — and (†),
> `Kill.no_double_change` (FS132-I4); M9 `Kill.step_kill` (FS132-I4). Three hypotheses of the skeleton were idle and
> are dropped: `X ≠ Y` in the ring form's reduction, `0 < κ'` in (†), measurability of the state in M9; two more in
> the step lemma's module (`u < w` in `exists_shiftMap`; measurability of the set in `volume_change_pairs_pos`). **Not kernel**: the statement on an open set
> containing the closed unit disc (M0's local reading of the release's two proofs stays [hand], one mind), and
> C132-M-EMPTY.

and under the entry C132-DIAG-WIDE (FS132-I4's D2):

> **2026-10-07, FS132-L2 — [kernel] at the whole plane**: `HadwigerNelson.SixRing.no_alternating_pairs`
> (`Plane/SixRing/TwoPairs.lean`), the standard three axioms, from the ported `two_state_impossible` through
> `no_alternating_groups`; the release's theorem read at six, not a result of this milestone. Its reading on an open set
> stays [hand], one mind.

**9. `LEAN.md`.** *(a) § Assumptions*, after the bullet "An imported theorem carries four things" (the port's draft D3,
with what the landing added):

> - **An outside Lean proof may be ported instead of imported** (`Outside/OAI158Palette`, `OAI158CircleMaps` …
>   `OAI158States`; FS132-K1, FS132-I2, landed by FS132-L2): compute the cone of the wanted statements from the source's
>   own compiled constants at its pin, copy those declarations by line range with a generator that refuses a patch to a
>   statement or a definition (`tools/fs132_i2_port.py`), and build. The kernel then checks every proof here and no axiom
>   enters. A read-back across pins (`tools/fs132_i2_readback.py`) is an instrument for "this is the source's lemma",
>   never a gate on truth, and it cannot read "term for term": the same text elaborates against another Mathlib. It
>   reports IDENTICAL, or identical up to instance and proof arguments with the differing constants recorded, under an
>   explicit map of Mathlib's renames between the pins; what it leaves to trust is that Mathlib's instances for one
>   class on one type agree at each pin. The landing runs it again on the joined tree. **A port carries the source's
>   licence**: a byte-identical copy of its text beside the modules, written and compared by the generator, each header
>   the notice of change. **An instance the source declares on a type that is Mathlib's is scoped here**, through the
>   generator (the keyword; an instance declared in a child namespace needs `attribute [scoped instance]` in the
>   parent, where its uses stand) — scoping changes no stored term, so the read-back prints the same bytes.

*(b) § Searching — Lean*, three bullets to follow the last (FS132-I4's draft D6, as written):

> - `tauto` exhausts its heartbeats in a context holding long implications it does not need (two pulled-back
>   `HubColours` statements): write the case split (`SixRing.no_double_change`, FS132-I4).
> - `rw [Measure.ae_prod_iff_ae_ae h]` finds no pattern in a goal that `filter_upwards` has beta-reduced; apply it as
>   `refine (Measure.ae_prod_iff_ae_ae (p := fun w => …) h).mpr ?_` with the predicate written out. A section of a
>   measurable set of triples is `measurable_prodMk_left hmeas` (FS132-I4, `unitPair_chart_ae`).
> - A map from a set of the line into a metric space that is `K`-antilipschitz there pulls sets of one-dimensional
>   Hausdorff measure zero back to Lebesgue-null sets (`SixRing.volume_preimage_inter_le_hausdorff`); with
>   `abs_dist_sub_le` it replaces an inverse function theorem wherever a point is known to move away from a fixed
>   centre at a definite rate. Shears of `ℝ × (ℝ × ℝ)` are `MeasurePreserving.skew_product` between two swaps
>   (`SixRing.shear_measurePreserving`); a statement almost everywhere on the line pulls back to triples by
>   `QuasiMeasurePreserving.prod_of_right` (FS132-I4).

*(c) § Searching — Lean*, one bullet of this job's:

> - A `scoped instance` declared inside `namespace A.B` is found in `A.B` and under `open A.B`, **not** in `A`:
>   `attribute [scoped instance] B.instName` inside `namespace A` adds `A`'s scope. An anonymous scoped instance keeps
>   the name the unscoped one has, and `private scoped instance` parses (measured at the pin:
>   `data/fs132/l2/probes/scoped-probe.lean`; on a built module, `scoped-built.lean`; FS132-L2).

*(d) § The gate*, in the bullet on `./scripts/vacuity.sh`, *follows* the sentence ending "…until the tooling job rules
how such emptiness is counted (`hexShell_plane5` given `Outside.OAI158.no_proper_five_coloring`, FS132-L1).":

> **The scan is silent on a module whose colourings are maps under a predicate it does not track** (`WeakColoring k c`,
> `ProperColoring k c`): the landing of FS-132's first theorem added 447 declarations and no site. Silence is not
> evidence; the landing names, for each structure of hypotheses, its model and whether the kernel holds it (FS132-L2,
> its record's stage 7).

**10. `BIBLIOGRAPHY.md`, `[OAIMath2026]`'s entry** (the port's draft D6, with the licence) — to add to what of ours
rests on it and what of it is held:

> Ported into this library (FS132-K1, FS132-I2, landed by FS132-L2, 2026-10-07; Apache-2.0 — a byte-identical copy of
> the release's `LICENSE` is `Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`, and each generated module's header
> is the notice of change): of `lean/OAI/Geometry/PlaneColoring/` at commit `adc7f124`, `CircleMaps.lean` whole and parts
> of `Expansion`, `CircleTransport`, `PaletteDensity`, `PaletteTransport`, `BinaryPalettes`, `States`, `AngularBoundary` —
> 163 declarations, 1,791 lines — with FS132-K1's 620 lines of `WeakColoring`, `Compactness`, `Palettes`: the cone of
> `palette_transfer_pair` (the manuscript's Lemma 5.2 (1)), `palette_sixty_disjoint` (Corollary 5.3),
> `two_state_impossible` (Lemma 6.4 at every `k`) and `mem_spatialSupport_ae`. Seven proof lines patched and one Mathlib
> name written at this pin; three instances on Mathlib's types scoped; no statement and no definition changed. Row 155's
> kernel theorems stand on the first two; `SixRing.no_alternating_pairs` on the third. Read for the port: those files'
> cone declarations as text (by the generator) and the four statements with their definitions by eye; the proofs were
> compiled, not read.

**11. The Proof Atlas.** The node of row 155 (C132-M-ORBIT, C132-WIT-ORBIT, C132-M-EXCL, C132-WIT-EXCL): **[hand] →
[kernel] for the whole plane**, with the caveat of draft 7 in the node's text — the open-set form and C132-M-EMPTY stay
[hand]; its edge from `[OAIMath2026]` family 158 is an edge to **ported, kernel-checked lemmas**, not to an import: no
declared outside theorem is under it. C132-DIAG-WIDE: [kernel] for the whole plane (the release's theorem). No other
node moves; no value moves.

**12. `ARCHITECTURE.md` § Trust**: no new row (no purchase, no import). Its § 3 rows are on the branch as landed: the
twenty-two modules' rows name no branch, the two skeleton rows are gone with their modules.

**13. `plans/FS132-close-inventory.md`** (for the item on this landing): the ruling of item 40 (b) is done — the
licence copy is in; of item 40 (c) — all three instances are scoped; of item 47 — the two skeleton modules did not
land, and one of the two names of one identity is gone.

## Theorems this phase proved, final

*Each [kernel], through the full gate at `b46a9d57`; axioms as `scripts/axioms.sh` printed them on that commit
(`data/fs132/l2/gate/receipt-axioms-final.log`), every record under CLEAN. Namespace `HadwigerNelson.SixRing` unless
said; modules under `Proofs/HadwigerNelson/`.*

- **`no_outside_orbit_points`** (`Plane/SixRing/Orbit.lean`) — the first night's exclusion, orbit form over four points
  (C132-WIT-ORBIT, row 155's first sentence), for a Borel colouring of the whole plane. `[propext, Classical.choice,
  Quot.sound]`. No assumption in hypothesis form; no outside theorem. FS132-K2's statement and assembly.
- **`no_outside_orbit`** (the same file) — the orbit form over four compact sets (C132-M-ORBIT). The standard three.
- **`not_ae_outside`** (the same file) — the ring form over four compact sets (C132-M-EXCL). The standard three.
- **`not_ae_outside_points`** (the same file) — the ring form over four points (C132-WIT-EXCL, row 155's ring
  sentence). The standard three. **This job's**, by the brief's Amendment 1: `not_ae_outside` at the two-point sets.
- **`no_alternating_pairs`** (`Plane/SixRing/TwoPairs.lean`) — the two-pair ring (C132-DIAG-WIDE) for the whole plane,
  the release's `two_state_impossible` read at six. The standard three. Not a result of this milestone.
- **The 303 other theorems the landing brings**, each with one record under CLEAN on a subset of the standard three
  (`data/fs132/l2/gate/records-final.txt`: 377 declarations — 308 theorems, 66 definitions, 3 structures — 376 on
  exactly the three, one on two of them), listed with what each says in their authors' records: the leaves and helpers
  of `Plane/SixRing/State`, `Excl`, `ChartMeasure`, `Kill`, `NullSets`, `Chart`, `Tips` and the assembly's
  `adjacent_tip_false`, `chart_step_false`, `no_alternating_groups` (`plans/FS132-I4-implementation.md` § Theorems this
  phase proved); `StepLemma` and `Shift`, less the helper removed at stage 5 (`plans/FS132-I3-implementation.md`);
  `Confine` and `Basic` (`plans/FS132-kernel-plan.md`); and the ported lemmas of `Outside/OAI158Palette`,
  `OAI158CircleMaps`, `OAI158Expansion`, `OAI158CircleTransport`, `OAI158PaletteDensity`, `OAI158PaletteTransport`,
  `OAI158BinaryPalettes`, `OAI158States`, `OAI158AngularBoundary` — among them `Outside.OAI158.palette_transfer_pair`,
  `palette_sixty_disjoint`, `two_state_impossible`, `mem_spatialSupport_ae` (`plans/FS132-I2-implementation.md`).

## Stage 10 — SAVED (FS132-L2): the landing

`main` had moved again while the gate ran: `f81abeec`, 26 commits past the commit merged at stage 3. **Tried, then
merged by hash** (`data/fs132/l2/merge-final-trial.out`, `merge-final.out`): since the merge base `357e42de` it changes
`data/` (35 paths), `plans/` (18) and `LEAN.md` — **0 paths outside `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md`,
`LEDGER.md`, `LEAN.md`, `RUNNING.md`** — so the gate is not re-run. `git merge --no-ff
f81abeecde0c8945132dac16d90d6f0d83683f6f`: **merge commit `780225d8f3ccd086183550a7a31302e4cba23039`, automatic.** The
diff that shows it, between the gated commit and the merged one: `git diff --name-only b46a9d57 780225d8` — `data/`
118, `plans/` 19, `LEAN.md` 1, nothing else; `git diff --stat b46a9d57 780225d8 -- Proofs Proofs.lean scripts tools
ARCHITECTURE.md lakefile.toml lean-toolchain lake-manifest.json` — **empty**. The merged tree holds zero `sorry` by
the narrow search, and `f81abeec` is its ancestor.

**The push** (`data/fs132/l2/push-main.out`): `git push origin HEAD:main` from the worktree, at `3ab61fcd` (the merged
commit and one commit of this job's logs under `data/`): "f81abeecd..3ab61fcdc HEAD -> main" — **a fast-forward; no
force.** `origin/main` by `ls-remote`: `f81abeec…` before, `3ab61fcd…` after. The record's last stages and the report
follow in a second fast-forward that touches `plans/` and `data/` only.

## Slips, my own

1. **A build's inputs written while it walked** (stage 2): I ran the two generators during the build after the cut.
   It had not reached the modules they write, and the build was green, so nothing was lost; a red build would have had
   two causes to separate. Since then no source file was written with a build in flight.
2. **The brief's order, items 3 and 4**: the licence copy and the scoping (4 (a), (b)) were made before `main` was
   merged (3). Item 4 (c), the comparisons, was run after the merge, on the joined tree, as the brief asks.
3. **A count in a tool's docstring** ("eleven faults" for twelve plants), corrected before the tool was first run on a
   gate log.
4. **The first draft of stage 6 said "the brief's other four conditions"** for five; corrected before the commit.
