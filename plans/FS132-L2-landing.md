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
