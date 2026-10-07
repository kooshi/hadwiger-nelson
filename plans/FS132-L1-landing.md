# FS132-L1 — the import's landing: `[OAIMath2026]` family 158's two outside theorems through the gate and onto `main`, with the one question as a theorem

*Record of the landing implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-L1-import-land.md` on `main` at
`f1febfb1`. Branch `fs132-wi1`, worktree `.claude/worktrees/fs132-wi1`, taken at `39d37838`. Working files: `data/fs132/l1/`.
Tools: `tools/fs132_l1_*.py`; the import's own (`tools/fs132_i1_*.py`) are run, never edited.*

## Theorems this phase proved

*Filled at the gate (the final list is at the end of this record, "Theorems this phase proved, final").* One theorem is
this job's own: `HadwigerNelson.Outside.OAI158.seven_le_chromaticNumber_plane_iff`. The module's other theorems are
FS132-I1's (`plans/FS132-I1-implementation.md` § Theorems this phase proved); this job gates and lands them.

## Stage 1 — SAVED (FS132-L1): the readback, what was read, the branch built as given

### The brief's quotations

`tools/fs132_i1_quotes.py` (the import's checker, run unedited) on the brief, relative sources read under `main`'s
checkout (`--root /home/kooshi/source/lean-dir`: the inventory, the request file and `CLAUDE.md` are `main`'s files) and
absolute ones as given: **14 quotations, 0 mismatches**, exit 0 (`data/fs132/l1/quotes.out`). By source: the module 5,
`CLAUDE.md` 4, the inventory 2, the left-out consequence's file 2, the request file 1. Its self-test plants a changed
word, a wrong source and an empty quotation: each **FIRED**, exit 0 (`data/fs132/l1/quotes-selftest.out`).

One thing the check shows that the launch context does not: the `CLAUDE.md` loaded into this session at launch is a
snapshot older than `main`'s (its § The aim item 5 reads "So, given MR, Hadwiger–Nelson is one question: can vanishing
holes save a colour?"); the brief's quotation is `main`'s text on disk ("So Hadwiger–Nelson is one question: can vanishing
holes save the seventh colour?"). Every front-page slot below is read from disk on the merged tree, never from the
snapshot.

### What was read

The brief whole; `plans/STANDING-RULES.md` whole; `LEAN.md` whole (as on `main`); `RUNNING.md` § Building and § Make the
gate fail, and watch it fail, whole. The import's record whole (`plans/FS132-I1-implementation.md`: stage 1's cross-pin
comparison and the table of 83 constants, stage 2, stage 3's probes and "At the join", its ten drafts, "What was checked,
and by whom", stage 4) and its report. The audit's Stage 8 and "What was checked, and by whom"
(`plans/EXT-OAI1-audit.md` ll. 611–751). The last landing's record, stages 5–6 and the head of its drafts
(`plans/FS131-L8A-landing.md` ll. 246–612). Inventory items 629 and 632 whole, 619 by its quoted head; the request file
whole (five words of Kooshi's). The module whole (316 lines) and the left-out consequence's file (8 lines).

### The branch as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`, at `39d37838`: **exit 0** — "build:
OK — all 1832 modules already up to date, nothing built, 0 module(s) with warnings, 2s"
(`data/fs132/l1/build-0-as-given.log`).

### The join, tried before it is made

`main` has moved past the brief's commit: `origin/main` is `aca251ee` (one commit after `f1febfb1`, a handoff), 102
commits past the branch's base `8386c256`. `git merge-tree --write-tree --name-only HEAD origin/main`, nothing merged
(`data/fs132/l1/merge-trial.out`): **one conflict, `ARCHITECTURE.md`**; `Proofs.lean` and `scripts/Axioms.lean` merge
by themselves — as the import's dry run found. No Lean file under `Proofs/` conflicts: the branch touches one module
there (`Outside/OAI158.lean`, new), `main` twelve others (the ring calculus and `Plane/SimpleOn`, wave 8).

## Stage 2 — SAVED (FS132-L1): `main` merged in

`git merge --no-ff aca251ee4d1f2e7031d3fc5b426eedf3460d6ca8` (the hash, never the ref): **merge commit `90ef4fa3`**.

- **The one conflict, `ARCHITECTURE.md`, the end of § 3** — `main` added twelve rows to § 3.11's table (`Plane/SimpleOn`
  and the eleven modules of `Plane/RingCalculus/`) where the branch adds § 3.12. Resolved as the brief says: `main`'s
  rows directly under § 3.11's last row (the table stays one table), then a blank line, then the branch's § 3.12 with
  its one row. Checked by script after the resolution: every line of the branch's file is in the result; every line of
  `main`'s is, but the one the branch rewrote in § 5 Trust ("One at present. …" → "Three at present. …", the branch's
  side, merged by git with no conflict); no conflict marker left. `git diff aca251ee -- ARCHITECTURE.md` is the branch's
  additions and nothing else: § 3.12, the two rows of § 5 Trust, the count sentence.
- **`Proofs.lean`** against `main`: one line added, `import Proofs.HadwigerNelson.Outside.OAI158`. **`scripts/Axioms.lean`**
  against `main`: the IMPORTED section's prose (three imports), the two `declareImport` lines, the nine records under
  IMPORTED, the block of twelve above PURCHASED — the import's own, merged by git with no conflict.
- **No Lean file under `Proofs/` conflicts, and none the module imports changed.** `git diff --name-status 39d37838
  90ef4fa3 -- Proofs/ Proofs.lean lakefile.toml lake-manifest.json lean-toolchain`: twelve files **added** (the wave's)
  and `Proofs.lean` modified; nothing else. So every file in `Outside/OAI158`'s import closure is byte for byte what the
  branch compiled it against.
- **`main`'s library has not moved since the last landing's gate**: `git diff --stat 126bff4d aca251ee -- Proofs/
  Proofs.lean scripts/ lakefile.toml lake-manifest.json lean-toolchain` is empty (113 commits, all outside those paths).
  FS131-L8A's receipts (`data/fs131/l8a/gate/*-final.*`, gated commit `126bff4d`) are therefore `main`'s gated state,
  and the digests of stage 6 are taken against them.

**The build of the joined tree** (`data/fs132/l1/build-1-merged.log`; Lake's full log
`build/gate/build/20261007T040520Z-1181891.log`): **exit 0** — "build: OK — 474 of 474 batches, 13 module(s) rebuilt,
0 module(s) with warnings, 9m34s". The thirteen: the wave's twelve (`HubCount` 23 s, the rest under 7 s each) and
`Proofs`. `Outside.OAI158` was **not** rebuilt — Lake's trace agrees with the diff above: its inputs did not change.

## Stage 3 — SAVED (FS132-L1): the comparison, again, on the joined tree — eight of eight identical

`data/fs132/l1/run-readback.sh joined` on `90ef4fa3`, no tracked file modified
(`data/fs132/l1/readback/summary-joined.txt`; every output of this run is under `data/fs132/l1/readback/` with the tag
in its name, the import's own prints untouched). The import's instrument is run unedited
(`tools/fs132_i1_readback.py`; the dump files of `data/fs132/i1/readback/`).

| step | result | saved |
|---|---|---|
| the release's eight declarations, **printed again** at the release's pin (Lean v4.34.1's own binary, `LEAN_PATH` the audit's compiled working copy, no `lake`) | exit 0; eight `DUMP` records; **identical to the print the import committed** (the slot's own admission line apart — the import's prints hold it, this run keeps stderr in its own file) | `ReleaseDump-joined.out` |
| the module's eight, from the module as built on the joined tree | exit 0; identical to the import's own print made before the join | `ModuleDump-joined.out` |
| **the comparison** (`decls`) | **exit 0 — "declarations: 8 compared: 8 identical: 8 different: 0 []", "READ-BACK IDENTICAL: all 8 declarations, term for term, modulo the namespace"** | `decls-module-joined.out` |
| the comparator's six planted faults (`--self-test`: a changed instance, a binder kind, a numeral, a missing declaration, a kind, a renamed constant) | exit 0 — each **FIRED**; "SELF-TEST OK: the unplanted pair identical on 8 declarations; 6 plants" | `selftest-joined.out` |
| the control in Lean, elaborated on the joined tree (`ControlDump.lean`: six declarations altered in one place each, two faithful) | "CONTROL FIRED AS EXPECTED": the six **DIFFERENT**, the two **IDENTICAL**; and read as a plain comparison it is refused, exit 1 | `ControlDump-joined.out`, `decls-control-joined.out`, `decls-control-red-joined.out` |
| one step down: the 83 constants the statements name, in the module's environment on the joined tree | no constant absent; the table is the import's, line for line (69 identical, 6 up to universe-parameter names, 8 different — the eight its stage 1 read) | `ModuleLevel1-joined.out`, `level1-joined.out` |
| the nine characterisations (`ModuleSemantic.lean`; its body is `SemanticBody.lean.inc`, by `diff`, as is `ReleaseSemantic.lean`'s) | exit 0, no message | `ModuleSemantic-joined.out`, `.err` |
| written at the release's side during the run | 0 files under `~/.cache/ext-oai1`, 0 under `~/source/math` (`find -newer` a marker); the clone is at `adc7f124`, clean | summary |

**Nothing differs, and the reason is stronger than the comparison**: the join added twelve modules the import's module
does not import and changed none it does (stage 2), so its compiled term is the branch's — the module was not
recompiled. The comparison is repeated in stage 6 on the module **as recompiled on the joined tree** (the added
theorem forces that), which is the run the landing's evidence rests on.

**A slip of my own, caught by the runner's first pass**: its first form compared the new prints with the import's by
`cmp` and read two as different; the difference was the slot's admission line (`slot: admitted … mem 10 GiB`), which
the import's saved prints hold as their first line. The runner now takes that one line out of both sides and compares
the rest; the first pass's summary was overwritten by the second's.

## Stage 4 — SAVED (FS132-L1): the one theorem, read aloud, registered; the block's controls

### The theorem

At the end of `Proofs/HadwigerNelson/Outside/OAI158.lean` (the last declaration before `end`), statement and proof as
the brief quotes them from the import's file, the docstring this job's (commit `b71b773b`):

```lean
theorem seven_le_chromaticNumber_plane_iff :
    7 ≤ (unitDistance ℂ).chromaticNumber ↔ (⨆ ε > (0 : ℝ), Plane.mu 6 ε) < 1 := by
  rw [chromaticNumber_plane_eq_chiM0]; exact Plane.seven_le_chiM0_iff
```

No import was added to the module (`Plane/YesLimit`, which it imports, imports `Plane/Slack`, where
`Plane.seven_le_chiM0_iff` is), so the copied definitions elaborate under the imports the comparison was made under.
The name is declared nowhere else: `rg` on `Proofs/` and `git grep` on every remote branch's `Proofs/` find it only in
the import's left-out file.

**As the kernel holds it** (`data/fs132/l1/checks.lean` on the built module, `probes/checks-probe.out`; `#check` with
`pp.notation false`): `Iff (LE.le 7 (HadwigerNelson.unitDistance Complex).chromaticNumber) (LT.lt (iSup fun ε => iSup
fun h => HadwigerNelson.Plane.mu 6 ε) 1)` — **no binder**; the module declares no `variable` and no `section`
(`grep`: its scope lines are `open MeasureTheory`, the namespace and its `end`). **Its axioms**: `[propext,
Classical.choice, Quot.sound, HadwigerNelson.Outside.OAI158.proper_to_borel_weak]` — the standard three and the
transfer, not the five-colour theorem; `Plane.seven_le_chiM0_iff` prints the standard three. The import's seventeen
statements print line for line as its record has them (`diff` of the first seventeen `#check`s with
`data/fs132/i1/checks.out`).

### Read aloud, against the front page's sentence — it holds, with one difference of wording that the library closes

The sentence (`CLAUDE.md` § The aim, item 5, as on `main`): "`χ(ℝ²) = χ_m⁰(ℝ²) ∈ {6, 7}` …, and `χ_m⁰(ℝ²) ≥ 7` iff six
classes, each free of monochromatic pairs at distances in `[1−ε, 1+ε]`, cannot cover the plane up to holes of density
tending to 0 as `ε → 0`". The theorem, aloud: *the plane needs at least seven colours exactly when there is a `δ > 0`
such that, for every `ε > 0`, any six disjoint measurable sets, each with only a null set of pairs of its own points at
a distance in `[1 − ε, 1 + ε]`, leave uncovered a part of the plane of lower density at least `δ`.* The brief's three
questions, each answered from a definition or a theorem read in its file, and each reading is a term the kernel
checked (`checks.lean`'s ten `example`s, exit 0):

1. **Is `(unitDistance ℂ).chromaticNumber` the plane's chromatic number in row 33's sense?** Yes:
   `chromaticNumber_plane_eq_complex : (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber = (unitDistance
   ℂ).chromaticNumber` (`Reduction.lean` l. 51, by the isometry `Complex.orthonormalBasisOneI.repr`), and row 33's
   `chromaticNumber_plane_interval` is stated at the left side. With its upper end, `7 ≤ χ` is `χ = 7`
   (`checks.lean`'s last `example` proves `χ = 7 ↔ sup < 1` from the theorem); with the import's `6 ≤ χ`, the negation
   is `χ = 6`.
2. **Is `⨆ ε > 0, Plane.mu 6 ε` the sentence's limit of the best six-class cover as `ε → 0`?** Yes. `Plane.mu k ε`
   (`Plane/Suprema.lean` l. 77) is `⨆` over families `C : Fin k → Set ℂ` that are partial colourings (measurable,
   pairwise disjoint) with every class `BandNull` at `ε`, of `upperDensity (⋃ j, C j)`; `upperDensity S` is `limsup_{R →
   ∞} |S ∩ B(0, R)| / |B(0, R)|` (l. 37). `antitone_mu` (a wider band is a stronger condition) makes the supremum over
   `ε > 0` the limit from the right at `0`, and `tendsto_mu 6 : Tendsto (mu 6) (𝓝[>] 0) (𝓝 (muZero 6))` names it.
3. **Does `< 1` say "holes of density bounded below"?** Yes: `mu_le_one` bounds the limit by `1`; it is `1` exactly
   when for every `δ > 0` some family at some `ε > 0` covers upper density above `1 − δ` (the form
   `chiM0_le_iff_periodic` states at every `k`); so `< 1` is one `δ > 0` such that every family at every `ε > 0`
   covers upper density at most `1 − δ` — the covered fraction of the discs about `0` has `limsup ≤ 1 − δ`, the
   uncovered fraction `liminf ≥ δ`.

**The one difference between the Lean statement and the sentence**: the sentence says each class is *free* of
monochromatic pairs in the band; `Plane.mu` asks that such pairs be *null* (`BandNull`: `Leb ⊗ Leb`-null). That is the
weaker condition (`bandNull_of_bandFree`) and the larger supremum (`muPer_le_muTile`, `muTile_le_mu`) — and **the limit
is the same** under the strict reading and under the strictest, periodic families of half-open grid squares with no
such pair at all: `tendsto_muTile 6` and `tendsto_muPer 6` have the same limit `muZero 6`, and `chiM0_le_iff_periodic`
states the criterion in that form. So no gap: the theorem is the sentence, for the limit. What the theorem does **not**
say, and the sentence does not ask: anything at a fixed `ε` (there the three suprema may differ), or which density
(the suprema are over upper density on discs about `0`; a single family's density depends on that choice, the
suprema's limit, by the periodic form, does not — `Plane/Suprema`'s module doc). The docstring says all of this, with
the names. **The theorem stays in.**

### The registrations

- `scripts/Axioms.lean`: one record more under the transfer's block (its header comment ends "; the last is
  FS132-L1's" — the import's reader takes a block as the header line and the `#print axioms` lines directly under it),
  and the IMPORTED section's prose reads "with five and five". No other line.
- `ARCHITECTURE.md`: the module's row in § 3.12 names the theorem and its rows are `33, 130, 131`; § 5 Trust, the
  transfer's row, lists it among the consumers.
- The build (`data/fs132/l1/build-2-theorem.log`): **exit 0** — "474 of 474 batches, 2 module(s) rebuilt, 0 module(s)
  with warnings, 8m30s" (`Outside.OAI158` 1.8 s, `Proofs` 1.5 s).

### The block as filed, with its two controls (`tools/fs132_l1_block.py`, driving the import's `fs132_i1_axioms.py`)

On the built module (`data/fs132/l1/probes/block-*-probe.*`): **22 records as filed — 12 clean, 5 on H, 5 on T; 0
refused**. The controls are made from the module's own text as it stands, by exact replacement, each asserted to have
happened:

- **the wrong filing** (the brief's): `six_le_chiM0` proved through the collapse (the import's own plant) and
  `seven_le_chromaticNumber_plane_iff` given `six_le_chiM0` as an idle step, so that each carries both imports —
  **FIRED**: refused exactly `six_le_chiM0`, `chiM0_six_or_seven`, `seven_le_chromaticNumber_plane_iff` ("filed on … alone;
  carries [both]"); nineteen as filed;
- **a planted `sorry`** in `direction_coe`: **FIRED** — refused exactly the eleven above it (the ten the import's
  control named, and the landing's theorem); the five on H as filed.
- Each control read as a plain check (without its expectation) exits 1.

## The mid-job message, and the coordinator's rulings (the brief's amendment on `main`, read whole)

Sent when the scan's probe on the joined tree came back green (`data/fs132/l1/probes/vacuity-joined.out`): **the
import makes one of the baseline's two entries an empty carrier, and the scan cannot see it.**
`Outside.OAI158.not_colorable_five : ¬ (unitDistance ℂ).Colorable 5` (on H) makes the type `(unitDistance ℂ).Coloring
(Fin 5)` empty; `hexShell_plane5 (C : (unitDistance ℂ).Coloring (Fin 5)) : ∃ x y, (dist x y = √3 ∨ dist x y = 2) ∧ C x
= C y` binds that type and concludes an `∃` — the `core9_plane` shape, given the import. The scan reads it `UNKNOWN,
held by the baseline`, before and after: `gather` (`scripts/Vacuity.lean`) takes as emptiness evidence an unconditional
`IsEmpty τ` or a `¬ P` of a tracked `P`, and `¬ Colorable 5` is neither. It is the only site the scan holds at the plane
with five colours (`rg` on the scan's `SITE` rows; no site at `AeColouring 5` or `CPColouring 5`). And a question: the
scan's own procedure has each landing enter its new hypothesis-formers in the registry comment of
`scripts/Vacuity.lean`, a file the brief's touches omitted.

The rulings (R1–R4; quoted from the amendment):

> **R1 — the emptiness theorem and the marker: not in this landing.** No `IsEmpty` statement from the import, no
> — source: data/fs132/briefs/FS132-L1-import-land.md

> **R2 — but the two texts inside your tree that are now false say so, in words, in this landing** (the rule of `LEAN.md`
> — source: data/fs132/briefs/FS132-L1-import-land.md

> **R3 — the registry comment: yes.** Add your one paragraph to the registry comment of `scripts/Vacuity.lean` — a comment
> — source: data/fs132/briefs/FS132-L1-import-land.md

> **R4 — the front page's sentence is mine to file.** In your "Drafts for the front page", add the replacement for
> — source: data/fs132/briefs/FS132-L1-import-land.md

**What was done under them** (one commit, the one after `b71b773b`; the report lists the hashes):
- **R2.1** — `Proofs/HadwigerNelson/Instances/HexShell.lean`, `hexShell_plane5`'s docstring: one sentence added, naming
  `Outside.OAI158.no_proper_five_coloring` and `Outside.OAI158.not_colorable_five`, saying the hypothesis has no
  inhabitant given that import, that on the standard three alone the scan cannot see it and holds it in its baseline,
  and that `hexShell_plane6` is the open case. **By script, against `b71b773b`**
  (`tools/fs131_lt5_docstring_check.py text`, FS131-LT5's lexer; `data/fs132/l1/docstring-text-probe.out`): "ok
  Proofs/HadwigerNelson/Instances/HexShell.lean: 1 doc comment(s) changed, nothing else", "docstring of: theorem
  hexShell_plane5", "files=1 doc-comments-changed=1 failed=0". The scan's marker string stands 0 times in the file. The
  elaborated half (the kernel's stored signatures of the module before and after) is in stage 6.
- **R2.2** — `scripts/vacuity-baseline.txt`, prose only: the header's sentence and the note above the entries now say
  that the second entry is the open half of the problem and the first is empty given the import, by the same two
  names, and that whether such evidence may discharge an entry is filed for the tooling job. The two `UNKNOWN` lines
  and the count lines are untouched by this edit (`diff` of those lines, before and after: none); the before-text is
  `data/fs132/l1/vacuity-baseline-before.txt`. (A `--baseline` regeneration rewrites the file's header and would drop
  this prose, as it would have dropped the prose it replaces: the entries are what the gate reads.)
- **R3** — `scripts/Vacuity.lean`, the registry comment (the docstring of `trackedProps`): one paragraph, 33 lines,
  after wave 8's — `ProperColoring` and `WeakColoring` OUT with the reason, `Angles`, `angularMeasure`, `direction` as
  data, what the scan reads of the landing, the plane at five, and the question for the tooling job. Checked by script:
  the text before the paragraph and the text after it are `main`'s byte for byte; the paragraph holds no comment
  delimiter; from `def trackedProps` to the end of the file no line differs from `126bff4d`'s. No name enters
  `trackedProps`; no control is planted.
- **R1, R4** — in "For the tooling job" and "Drafts for the front page" below.

**The decision on the two formers, by the scan's law** ("IN iff 'does one exist' is a theorem rather than a
construction, or the predicate can be refuted at a concrete instance", as waves 5, 6 and 8 applied it: IN only where a
`VACUOUS` control can be planted). `ProperColoring k c` and `WeakColoring k d` are predicates of a colour count and a
function; at each of their binder sites (`proper_to_borel_weak`; `nonempty_aeColouring_of_weak`) the function is a
bound variable, so the carrier has a free variable at a closed count as at a variable one, matches no closed evidence,
and reads `GENERIC`: no `VACUOUS` control exists to plant. The emptiness that matters — no proper colouring with four
colours (this library's), with five (the import), no weak colouring with one — is a statement over all functions, which
a per-binder scan cannot read. Both OUT; the module's docstring already says that the transfer is empty of content
where no proper `k`-colouring exists, and gives the model at seven.

## Stage 5 — SAVED (FS132-L1): what the library assumes, written; the audit's controls at the new state; the scan and its header; a second amendment

Everything in this stage is a probe on the tree as it will be gated (the theorem, the ruled edits, `main` merged at
`db43b298`); the gate's own run is stage 6. Build after the docstring edit (`data/fs132/l1/build-3-docstring.log`):
**exit 0** — "474 of 474 batches, 10 module(s) rebuilt, 0 module(s) with warnings, 9m4s": `Instances/HexShell` and the
nine modules downstream of it (`Instances/{ResidueObstruction11, FanGap11, LocalGlobal19, PlaneFreedom, FanGap19,
FalconerOrbit}`, `Arith/{PlaceHom, FalconerField}`, `Proofs`) — a docstring is environment data, so its dependents
rebuild. `Outside/OAI158` is not downstream of `HexShell` and was not rebuilt by it.

### 5.1 The assumptions step: ten rows, and nothing else

`./scripts/assumptions.sh --self-test` first (`probes/assumptions-selftest-first.out`): exit 0, "OK — all 33 checks
behaved: every planted fault fired, and every partner stayed silent". Then the step (`probes/assumptions-first.out`,
scan `probes/assumptions-first.scan.log`): **exit 1, ten failures, one kind** — `unlisted-consumer` for the ten `RESTS`
rows of the two new axioms (five each: the import's nine, and this job's theorem on the transfer). Every failure read;
there is no other: the scan's own `fails=0`, `hints=0`. **No line of `scripts/Assumptions.lean` is asked** (no
`undeclared-…` row, no `SILENT` or `CONDITION` row naming the module).

`./scripts/assumptions.sh --write-ledger` (`probes/assumptions-write-ledger.out`): exit 0, "ledger written (117 rows)".
**The ledger gains ten rows and loses none** (the before-text is `data/fs132/l1/assumptions-ledger-before.txt`; 107 →
117 rows), and its header's count line moves from `axioms=1 rests=8 …` to `axioms=3 rests=18 …`:

```
+ RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.chiM0_six_or_seven
+ RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.chromaticNumber_plane_six_or_seven
+ RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.not_colorable_five
+ RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.six_le_chiM0
+ RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.six_le_chromaticNumber_plane
+ RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.chiM0_le_chromaticNumber_plane
+ RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0
+ RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.colorable_iff_nonempty_aeColouring
+ RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.nonempty_aeColouring_of_colorable
+ RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.seven_le_chromaticNumber_plane_iff
```

Each row is a theorem that is conditional on one named outside statement. After it (`probes/assumptions-after.out`):
**exit 0** — "assumptions: OK — 3 outside theorem(s) as axioms, with 18 theorem(s) resting on them; 19 named and 16
inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1"; the ledger's header
"match (9 of 9 compared)"; `CLAUDE.md` § Trust ledger flagged stale, "axioms 1 → 3, rests 8 → 18" (drafts).

| | `main` (FS131-L8A's gated scan) | this tree |
|---|---|---|
| `=== SCANNED ===` | constants=14063 theorems=10405 formers=320 hypotheses=18013 closed=1473 | constants=14095 theorems=10430 formers=322 hypotheses=18019 closed=1473 |
| the nine | axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1 | **axioms=3 rests=18**, the other seven unmoved |
| the rest | conditions=35 … silent=1 cohyp=58 hints=0 unseen=16035 fails=0 | conditions=35 … silent=1 cohyp=58 hints=0 unseen=16040 fails=0 |

The two new formers are `ProperColoring` and `WeakColoring`: each is taken as a hypothesis and concluded by a theorem
with no assumption (`exists_properColoring_seven`; `weakColoring_of_aeColouring`), so the step does not ask whether
they are assumptions. `unseen` +5: the module's hypotheses over its own variables (a proper colouring, a measurable
map, a weak colouring, a colouring of the graph, an `AeColouring`), each a condition on the theorem's own objects.

### 5.2 The second finding, and the second amendment (R5, R6)

Reading the step's printed list of what the library assumes, not its verdict: **two of the five hypotheses it holds as
kind `open` are implied by the import.** `inline:SixTarget` ("row 43 (the six-target: every √3-pair and every
distance-2 pair separated at five colours; G26)"), taken by `not_colorable_five_of_forced_pairs` and
`six_le_chromaticNumber_plane_of_forced_pairs` in the binders `h3`, `h2`, each `∀ (C : (unitDistance ℂ).Coloring (Fin
5)) (x y : ℂ), dist x y = … → C x ≠ C y`; and `inline:SixTargetOneTwo` ("row 61 (the six-target, distance-set-generic:
the plane of the distances 1 and 2)"), taken by `six_le_chromaticNumber_oneTwo_of_forced_sqrt3` in `h3 : ∀ (C :
(distanceGraph ℂ {1, 2}).Coloring (Fin 5)) (x y : ℂ), dist x y = Real.sqrt 3 → C x ≠ C y` (`Instances/HexShell.lean` l.
454, read). Given `not_colorable_five` the first binders range over an empty type; the second's ranges over
five-colourings of the plane's `{1, 2}`-distance graph, each of which is a five-colouring of the plane
(`chromaticNumber_unitDistance_le_distanceGraph`, `DistanceGraph.lean` l. 82), so it is empty for the same reason, one
library lemma further. The step cannot see it: no theorem of the library states those binders, so they read as declared
hypotheses, `takes=98` unmoved.

**Checked as terms, not argued** (`data/fs132/l1/five-empty.lean`, `lake env lean`, exit 0, `five-empty.out` —
iteration files, **not** library theorems: R1 keeps every such statement out of the library at this landing):
`IsEmpty ((unitDistance ℂ).Coloring (Fin 5))`; `SixTarget`'s two binders as closed theorems, and the two consumers
applied to them, concluding `¬ (unitDistance ℂ).Colorable 5` and `6 ≤ (unitDistance ℂ).chromaticNumber`;
`¬ (distanceGraph ℂ {1, 2}).Colorable 5`, `SixTargetOneTwo`'s binder, and its consumer applied, concluding `6 ≤
(distanceGraph ℂ {1, 2}).chromaticNumber`. Each prints `[propext, Classical.choice, Quot.sound,
HadwigerNelson.Outside.OAI158.no_proper_five_coloring]`. **The control** (`five-empty-control.lean`): the same term at
six colours is refused, exit 1, "Application type mismatch … `(unitDistance ℂ).Coloring (Fin 6)` … expected
`(unitDistance ℂ).Coloring (Fin 5)`" — the import closes the five-colour binders and not the six-colour ones
(`SevenTarget`, `hexShell_plane6`).

Sent to the coordinator; **ruled by a second amendment of the brief** (on `main`; read whole by `git show`):

> **R5 — yes: the two source strings say it in words in this landing; the kinds and the counts do not move.** In
> — source: data/fs132/briefs/FS132-L1-import-land.md

> **R6 — in your record and drafts**: (i) both entries under the tooling job's list beside R1's question, as you propose —
> — source: data/fs132/briefs/FS132-L1-import-land.md

**Done under R5** — `scripts/Assumptions.lean`, five lines, each changed inside its last string literal and nowhere
else (by script: the text before the string is identical, and the old string is a prefix of the new; the before-text
is `data/fs132/l1/Assumptions-before.lean`): the four sites of `SixTarget` carry one source, character for character,
which now ends "… — given the declared outside theorem Outside.OAI158.no_proper_five_coloring this holds with nothing
to prove: its binder ranges over five-colourings of the plane, of which there are none
(Outside.OAI158.not_colorable_five); the kind stays open until the tooling job decides how such an entry is classed
(FS132-L1)"; `SixTargetOneTwo`'s the same with "five-colourings of the plane's {1, 2}-distance graph, each of them a
five-colouring of the plane (chromaticNumber_unitDistance_le_distanceGraph)". Its binder was read before the string
was touched, and is empty for the same reason (above). **Kind `open`, the references `row:43` and `row:61`, the nine
counts and the ledger's rows are as they were**: after the edit the self-test reads "all 33 checks behaved"
(`probes/assumptions-selftest-after.out`), the step exits 0 with the same nine counts, and its digest shows exactly two
`ASSUMPTION` rows reworded (`probes/assumptions-after.out`: two `+`, two `-`, the same labels, kinds and consumer
counts).

### 5.3 The axiom audit: three declared imports; its two state-reading controls brought to the new state

`./scripts/axioms.sh --self-test` with the controls **as `main` has them** (`probes/axioms-selftest-before.out`):
**exit 1 — "2 of 23 control(s) did not behave as designed"**: `baseline` and `imported_declared`, the two whose
expected counts read the library's state ("expected COUNTS imported=8 … declared=1 … library=1", "got: … imported=18 …
declared=3 library=3"; and 9 / 2 / 2 against 19 / 4 / 4). The other twenty-one behaved. **The rule, in the controls
file's own words**: "A later import, or this one's proof, moves them again — per declared import, `declared` and
`library` rise by one in both controls and `imported` by its records, the `old` digests' texts follow, and
`banner_dropped` gains `FAIL outside-banners <one of its records>` and `FAIL stale-declaration <the axiom>`". Applied
(`scripts/axioms-controls.txt`; the counts derived from the rule — two more imports, five records each — and then seen
to agree with the run):

| control | was | is |
|---|---|---|
| `baseline` | `imported=8`, `declared=1`, `library=1`; digest `old` "… the audit has 8 imported" | `imported=18`, `declared=3`, `library=3`; "… has 18 imported" |
| `imported_declared` | `imported=9`, `declared=2`, `library=2`; digest `old` "… has 9 imported" | `imported=19`, `declared=4`, `library=4`; "… has 19 imported" |
| `banner_dropped` | two expectations for Weil's bound | four more: `outside-banners not_colorable_five`, `stale-declaration no_proper_five_coloring`, `outside-banners seven_le_chromaticNumber_plane_iff`, `stale-declaration proper_to_borel_weak` |
| the file's header comment | one declared import, eight records | three, eighteen, by name |

After it (`probes/axioms-selftest-after.out`): **exit 0, "OK — every planted fault fired, and every partner passed"**
(23 controls). The audit (`probes/axioms-probe.out`, receipt `probes/axioms-probe.receipt.log`): **exit 0** — "audited:
6576 records — 6533 clean on the standard axioms, 20 axiom-free, 18 imported (resting on a declared outside theorem),
5 declared purchase(s)"; "declared imports (3): …kloosterman_bound, …no_proper_five_coloring, …proper_to_borel_weak";
"library axioms other than native auxiliaries (3): … every one declared". Against `main`'s 6,554 (6521 / 20 / 8 / 5):
**+22 records = +12 clean, +10 imported**; axiom-free and purchases unmoved.

### 5.4 The vacuity scan: one new site, `GENERIC`; the baseline's header

`./scripts/vacuity.sh` (`probes/vacuity-probe2.out`, scan `probes/vacuity-probe2.scan.log`): **exit 0, "vacuity: OK"**.

| | `main` | the joined tree, before the theorem (`vacuity-joined`) | this tree |
|---|---|---|---|
| declarations | 14807 | 14844 | **14845** |
| refutations-skipped | 215 | 215 | 215 |
| sites | 1446 | 1447 | **1447** |
| vacuous / stale / declared / witnessed | 0 / 0 / 3 / 38 | the same | the same |
| generic | 1403 | 1404 | **1404** |
| unknown | 2 | 2 | 2 |

**How the scan classes every new site**: there is one — `SITE GENERIC HadwigerNelson.Outside.OAI158.weakColoring_of_aeColouring
:: HadwigerNelson.Plane.AeColouring k`, a binder on the tracked `AeColouring` at a variable number of colours (the
caller's obligation, by the scan's law; its model in the module is `Plane.r7_aeColouring` through
`proper_to_borel_weak_model`). The two imports raise none: `no_proper_five_coloring` has no hypothesis;
`proper_to_borel_weak`'s hypothesis `ProperColoring k c` is not a tracked carrier (OUT, above), and is inhabited at
seven by `exists_properColoring_seven`. The landing's theorem has no binder. **No site reads `VACUOUS` or `UNKNOWN`
beyond the baseline's two; no entry is added.** `declarations` +38 are the module's (37 before the theorem, and the
theorem); `refutations-skipped` does not move: the two negations (`no_proper_five_coloring`, `not_colorable_five`) are
stated negations, audited, not skipped. `hexShell_plane5` reads `UNKNOWN`, held by the baseline, as before — the
finding of the first amendment.

`scripts/vacuity-baseline.txt`, the header's two count lines, from `scripts/gate_report.py header` on that scan
(`diff` of the script's output with the file's lines: none):

```
-#   declarations=14807  refutations-skipped=215  sites=1446
-#   vacuous=0 stale=0 declared=3 witnessed=38 generic=1403 unknown=2
+#   declarations=14845  refutations-skipped=215  sites=1447
+#   vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2
```

## Stage 6 — SAVED (FS132-L1): the full gate on one commit — `5df686f0`

One pass is every step in order, one at a time under the slot (`data/fs132/l1/run-gate.sh final`, after the last
landing's runner; every log under `data/fs132/l1/gate/` with its exit status on its last line;
`run-gate-final.head` records the commit and that **no tracked file was modified**; `run-pass-final.out` holds every
step's exit; 04:57:42Z–05:14:20Z). **Every step exit 0 but the one planted control that must exit 1** (the scan
difference's plants); "tracked files modified after the pass: 0". Counts below are read from the saved logs.

**Before the pass, the lint's negative control** (`data/fs132/l1/lint-plant.sh`; `lint-plant-run.out`): an unused
anonymous instance binder planted at the end of the landing's module (`theorem zz_l1_lint_plant [Nonempty ℕ] : (1 : ℕ) =
1 := rfl`; never committed), built — "474 of 474 batches, 2 module(s) rebuilt, **0 module(s) with warnings**"
(`lint-plant-build.log`: the build's own linters do not see it) — then the guarded lint: **exit 1**, "`unusedArguments`:
(2/2) Failed with 1 messages", "error: @zz_l1_lint_plant 1 unused argument" (`lint-plant.log`; `synTaut` fires on it
too, for `1 = 1` — the red that answers the plant is the first). The module restored by `git checkout` under a trap:
its digest is the one taken before the plant (`lint-plant-restore.txt`), the plant's name in the file 0 times, no
tracked file modified; the pass's build recompiled the module and `Proofs` from the restored text.

| step | result, read from its saved log (`data/fs132/l1/gate/`, tag `final`) | log |
|---|---|---|
| build | "build: OK — 474 of 474 batches, 2 module(s) rebuilt, **0 module(s) with warnings**, 8m22s" (`Outside.OAI158`, `Proofs`: the restore after the lint control); lines holding "warning" in the build log: 1, that sentence; in Lake's full log: 0 | `build-final.log`, `receipt-build-final.log` |
| `sorry` | narrow pattern (`^\s*sorry\s*$`, `:= sorry`, `by sorry`): **0** lines; `\bsorry\b`: 9, all prose — the eight `main` holds, file for file, and one in the module's docstring ("a planted `sorry` reaches the headline", l. 31) | `sorry-narrow-final.txt`, `sorry-wide-final.txt` |
| `axiom` lines in `Proofs/` | 4 line-initial: the two imports (`OAI158.lean` ll. 107, 119), `kloosterman_bound` (`WeilKloosterman.lean` l. 51), and one line of a docstring's code block (`Sat/Lrat.lean` l. 85, the print of a native auxiliary). Three axioms, as the audit counts | `axiom-lines-final.txt` |
| doubled names, **after the build and before the audit** (`--mem 16`) | "scanned 7456 modules, 1844 of them the package's (1844 source files)"; "dupnames: OK — no name is declared by two modules (23 generated on demand, listed above)" | `dupnames-final.log` |
| its self-test | "OK — all 15 controls behaved: every planted fault fired, and every partner passed." | `dupnames-selftest-final.log` |
| axioms | "audited: **6576 records — 6533 clean on the standard axioms, 20 axiom-free, 18 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "declared imports (3): …kloosterman_bound, …no_proper_five_coloring, …proper_to_borel_weak"; "library axioms other than native auxiliaries (3): … every one declared"; "axioms: OK". `CLAUDE.md` § Trust ledger flagged stale, "6521 clean → 6533, 8 imported → 18" (draft 1) | `axioms-final.log`, `receipt-axioms-final.log` |
| its self-test | "OK — every planted fault fired, and every partner passed." (23 controls; the two state-reading ones at the new state, stage 5.3) | `axioms-selftest-final.log` |
| **every record of the module filed on the one import it uses or on none** (`tools/fs132_l1_records.py`, three imports) | "main: 9744 theorems; landing: 9769; landing only: 25 = 22 hand-written + 3 generated with no record asked (`WeakColoring.eq_1`, `angularMeasure.eq_1`, `direction.eq_1`); gone: 0; records in the log: 6576"; "landing records on exactly the three: 12", "on the three and no_proper_five_coloring: 5", "on the three and proper_to_borel_weak: 5"; "whole log: records carrying kloosterman_bound: 8 (filed: 8) … no_proper_five_coloring: 5 (filed: 5) … proper_to_borel_weak: 5 (filed: 5)"; "records under IMPORTED 18; carrying two imports 0; carrying sorryAx 0"; "records: PASS" | `records-final.txt` |
| its plants | ten, one at a time, "every one of 10 fired; the unplanted log passes": a record dropped, one doubled, `sorryAx`, a clean record given the transfer, one under PURCHASED, a record on H under CLEAN, one stripped of H, **the landing's theorem filed on H for T**, a record on both imports, one of `main`'s eight stripped of Weil's bound | `records-plant-final.txt` |
| the import's block as filed, with its controls (`tools/fs132_l1_block.py`) | "records filed: 22 as filed: 22 (clean 12, on H 5, on T 5) refused: 0"; the wrong filing: refused exactly `six_le_chiM0`, `chiM0_six_or_seven`, `seven_le_chromaticNumber_plane_iff`, "CONTROL FIRED AS EXPECTED"; the planted `sorry`: refused exactly eleven, "CONTROL FIRED AS EXPECTED"; each read as a plain check exits 1; "block: PASS" | `block-final.txt`, `block-*-final.*` |
| vacuity | "scanned: **declarations=14845 refutations-skipped=215**"; "sites: **sites=1447 vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2**"; "evidence: 18 emptiness proof(s), 63 witness(es)"; the baseline's header "match (9 of 9 compared)"; "UNKNOWN …hexShell_plane5", "UNKNOWN …hexShell_plane6", held; "vacuity: OK". `CLAUDE.md` § The gate flagged stale on three counts (draft 4) | `vacuity-final.log`, `receipt-vacuity-final.log` |
| the scan against `main`'s, row for row | "main rows 1527, landing rows 1528; lost 0; added 1": "added SITE GENERIC …weakColoring_of_aeColouring :: HadwigerNelson.Plane.AeColouring k"; no evidence row added; "module Outside.OAI158: declarations 0 -> 38 (+38), refutations 0 -> 0"; "by module: declarations +38, refutations +0: equal to the scans difference"; "vacdiff: PASS" | `vacdiff-final.txt` |
| its self-test, and the difference's plants | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent."; the plants: exit 1 — COUNTER-DISAGREES, LOST, NOT NEW, FLAGGED, MODULE-SUM | `vacuity-selftest-final.log`, `vacdiff-plant-final.txt` |
| assumptions | "assumptions: OK — 3 outside theorem(s) as axioms, with 18 theorem(s) resting on them; 19 named and 16 inline hypotheses (7 outside, 23 ours, 5 open), taken by 98 statement(s) and mentioned by 1"; "assumed: **axioms=3 rests=18 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1**"; "decided: … conditions=35 fails=0"; "hints=0 silent=1 unseen=16040"; the ledger's header "match (9 of 9 compared)"; `CLAUDE.md` § Trust ledger flagged stale, "axioms 1 → 3, rests 8 → 18" (draft 3) | `assumptions-final.log`, `receipt-assumptions-final.log` |
| its self-test | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent." | `assumptions-selftest-final.log` |
| architecture | "RESULT: PASS" | `arch-final.txt` |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!"; its control red before the pass (above) | `lint-final.log`; `../lint-plant.log` |
| notes, as the last landing ran them | `tools/fs131_l5_notes.py --only-flagged`: "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", 0 CONFLICT — `main`'s count: the check reads the modules of QA4's audit, none of them this landing's; `tools/fs131_qa4_notes.py --self-test`: "OK (6 controls, 1 planted)" | `notes-l5-final.txt`, `notes-qa4-selftest-final.txt` |
| **the stored-term comparison, on the module as recompiled on this commit** (olean digest `0f3b15f3…`; before the theorem `346c6b85…`) | the release's print made again at its pin and identical to the import's; "declarations: 8 compared: 8 identical: 8 different: 0 []", "READ-BACK IDENTICAL: all 8 declarations, term for term, modulo the namespace"; "SELF-TEST OK: … 6 plants"; the Lean control "FIRED AS EXPECTED" (six different, two identical) and refused as a plain comparison; level one: no constant absent, the import's table line for line; the nine characterisations, no message; 0 files written under `~/.cache/ext-oai1`, 0 under `~/source/math`; "READ-BACK RUN gate-final: OK" | `readback-final.txt`; `../readback/*-gate-final.*` |
| every statement of the module by `#check` | the import's seventeen print line for line as its record has them (`diff`); the eighteenth: "seven_le_chromaticNumber_plane_iff : 7 ≤ (unitDistance ℂ).chromaticNumber ↔ ⨆ ε, ⨆ (_ : ε > 0), Plane.mu 6 ε < 1", with no notation `Iff (LE.le 7 …chromaticNumber) (LT.lt (iSup fun ε => iSup fun h => HadwigerNelson.Plane.mu 6 ε) 1)`; its axioms the standard three and `proper_to_borel_weak`; the ten readings of its docstring elaborate | `checks-final.out` |
| the ruled docstring edit, by text and by the kernel | text against `b71b773b`: "1 doc comment(s) changed, nothing else", "docstring of: theorem hexShell_plane5", "files=1 doc-comments-changed=1 failed=0"; the tool's self-test "OK — every planted fault fired and every partner passed"; elaborated, `Instances/HexShell` and `Outside/OAI158` against the dump taken before the edit: "before=86 after=86 (theorems before=67) missing=0 added=0 changed=0", "IDENTICAL" | `docstring-text-final.txt`, `docstring-selftest-final.txt`, `sigs-final.txt`, `docstring-elaborated-final.txt` |
| the baseline and the scan's source | "baseline entries: unchanged (2)"; the marker's string in `Instances/HexShell.lean`: 0; lines of `scripts/Vacuity.lean` from `def trackedProps` to its end that differ from `126bff4d`'s: 0 | `baseline-final.txt` |
| the three digests against the previous landing's receipts | axioms: 22 rows added — 12 CLEAN on exactly the three, 5 IMPORTED on `no_proper_five_coloring`, 5 on `proper_to_borel_weak` — none removed. vacuity: "counts: declarations 14807 → 14845, sites 1446 → 1447, generic 1403 → 1404", one row added, the `GENERIC` site. assumptions: two `AXIOM` rows and ten `RESTS` rows added, the two reworded `ASSUMPTION` rows (R5), nothing else | `digest-axioms-final.txt`, `digest-vacuity-final.txt`, `digest-assumptions-final.txt` |

**Read aloud against the informal claim.** The claim of this landing: "the library holds `6 ≤ χ(ℝ²) ≤ 7` and
`χ(ℝ²) = χ_m⁰(ℝ²)`, each kernel-checked from one declared outside theorem of `[OAIMath2026]`, each of those the
release's own statement; and the one question as a theorem." What the gate shows: two `axiom`s enter, each declared to
the audit with its key, each the release's stored term symbol for symbol on the module the gate compiled; every theorem
of the module has one record, on the standard three (twelve) or on the three and exactly one of the two (five and
five), none on both, none with `sorry` beneath it; no name is declared twice, so each printed list is the list of the
proof the kernel checked; the ten theorems that rest on an import are listed in the assumptions ledger, one row each.
`chromaticNumber_plane_six_or_seven` aloud: *colour the points of the Euclidean plane so that no two points one unit
apart share a colour; then at least six and at most seven colours are needed* — its upper half this library's own, its
lower half the import. `chromaticNumber_plane_eq_chiM0`: *the least number of colours in such a colouring is the least
number in a measurable colouring proper at almost every unit pair* — no binder, on the transfer.
`seven_le_chromaticNumber_plane_iff`: stage 4. **What the gate does not show, and the docstrings and this record say**:
that the two axioms are true (the release's proofs are not in this library; they were built, replayed and read
elsewhere, one mind each); Mathlib between the two pins below the constants the statements name; and the two findings —
an older statement emptied by the import, two "open" hypotheses implied by it — which no step of the gate reads, and
which are said in words in the gated tree by ruling.

## Drafts for the front page (FS132-L1)

*For the coordinator to file; nothing here is filed by this job. Each names its slot — the file, the section, and **the
exact words on `main` it replaces or follows**, read on the merged tree (`main` at `7eb8dbd9`), not from the import's
record — and the log line it comes from. The gated commit is `5df686f0`; its logs are `data/fs132/l1/gate/*-final.*`
(`receipt-axioms-final.log`, `receipt-vacuity-final.log`, `receipt-assumptions-final.log` are the three scans' full
outputs).*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 6521 clean and 5 declared
purchases, and 8 imported (and 20 axiom-free; 6,554 records at wave 8's first landing, FS131-L8A, 2026-10-06)" — from
`axioms-final.log`, "audited: 6576 records — 6533 clean on the standard axioms, 20 axiom-free, 18 imported (resting on a
declared outside theorem), 5 declared purchase(s)":

> the current audit reads 6533 clean and 5 declared purchases, and 18 imported (and 20 axiom-free; 6,576 records at the
> landing of FS-132's import, FS132-L1, 2026-10-07)

The 22 records the landing adds: 12 on exactly the standard three (the dictionary, the models, two instances), 5 on the
three and `no_proper_five_coloring`, 5 on the three and `proper_to_borel_weak`. 6521 + 12 = 6533; 8 + 10 = 18;
axiom-free and purchases do not move.

**2. `CLAUDE.md` § Trust ledger, the sentence naming the library's outside axioms** (the import's draft 2, at the
joined tree's counts). *Replaces* "The library declares one outside axiom, `StandingFive.kloosterman_bound` — Weil's
bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by two readers — and the eight imported records
are the theorems that rest on it;" — from `axioms-final.log`, "declared imports (3): …", "library axioms other than
native auxiliaries (3): … every one declared", and `records-final.txt`:

> The library declares three outside axioms: `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums,
> `[Weil1948]` p. 207, read against its page by two readers — with eight imported records; and, from `[OAIMath2026]`
> family 158, a Lean development built and audited here at its own pin, `Outside.OAI158.no_proper_five_coloring` — no
> map `ℂ → Fin 5` separates every unit pair — with five, and `Outside.OAI158.proper_to_borel_weak` — a proper
> `k`-colouring of the plane gives a Borel one proper at almost every unit pair — with five; no record rests on two of
> the three, and each of the two new ones is the release's stored statement term for term
> (`tools/fs132_i1_readback.py`, run again at the landing on the module as recompiled there);

The rest of the paragraph stands ("its first import, `[Falconer1981]` Lemma 2 (i), is a theorem since FS131-IF1. Rung B
holds none.").

**3. `CLAUDE.md` § Trust ledger, the nine assumption counts** (the import's draft 3, updated; and ruling R6 (ii)).
*(a) Replaces* "`axioms=1 rests=8 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — one outside theorem
declared as an axiom, with eight theorems resting on it;" — from `receipt-assumptions-final.log`, `=== TOTALS ===`:

> `axioms=3 rests=18 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared
> as axioms, with eighteen theorems resting on them;

*(b) Replaces*, in the same paragraph, "seven standing for outside theorems, twenty-three for hand results of ours and
five for open questions — taken in 98 (hypothesis, statement) pairs by 51 statements (`scripts/assumptions-ledger.txt`
lists each pair; FS131-LT5, 2026-10-06)." (R6 (ii)):

> seven standing for outside theorems, twenty-three for hand results of ours and five declared as open questions —
> taken in 98 (hypothesis, statement) pairs by 51 statements (`scripts/assumptions-ledger.txt` lists each pair;
> FS131-LT5, 2026-10-06). Of the five, three are open (the seven-target at six colours, `NoPar`, fragments at every
> radius); two — the six-target at five colours, on the plane and on its {1, 2}-distance graph (rows 43, 61) — hold
> with nothing to prove given the declared outside theorem `Outside.OAI158.no_proper_five_coloring`, their binders
> ranging over five-colourings, of which there are none (`Outside.OAI158.not_colorable_five`); their kind stays `open`
> until the tooling job decides how a declared hypothesis that a declared import implies is classed (FS132-L1).

The paragraph's last sentence (Weil's bound counted in three forms) stands; the two new imports take one form each, the
axiom. Until (a) is filed the step flags `CLAUDE.md` § Trust ledger stale (not failed): "axioms 1 → 3, rests 8 → 18".

**4. `CLAUDE.md` § The gate, the vacuity scan's two count lines.** *Replaces* "`declarations=14807
refutations-skipped=215 sites=1446`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1403 unknown=2`." — from
`vacuity-final.log`, "scanned: declarations=14845 refutations-skipped=215", "sites: sites=1447 vacuous=0 stale=0
declared=3 witnessed=38 generic=1404 unknown=2":

> `declarations=14845 refutations-skipped=215 sites=1447`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1404 unknown=2`.

Until it is filed the scan flags `CLAUDE.md` § The gate stale (not failed) on three counts: declarations, sites, generic.

**5. `CLAUDE.md` § The gate, the sentence about the baseline's two entries** (ruling R4). *Replaces* "The baseline's two
entries, `hexShell_plane5` and `hexShell_plane6`, cannot be discharged: their inhabitant *is* Hadwiger–Nelson.":

> The baseline holds two entries. `hexShell_plane6` cannot be discharged: its inhabitant *is* Hadwiger–Nelson, at six.
> `hexShell_plane5` is no longer that: given the declared outside theorem `Outside.OAI158.no_proper_five_coloring` the
> plane has no five-colouring (`Outside.OAI158.not_colorable_five`), so its hypothesis has no inhabitant and it says
> nothing beyond that import. The scan cannot see this — it reads as emptiness what the library states as `IsEmpty τ`
> or as `¬ P` of a tracked `P` — so the entry stays `UNKNOWN`; the statement's docstring and the baseline's prose say it
> in words, and whether emptiness resting on a declared import may discharge an entry is the tooling job's question.

**6. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`** — one entry after the last (`(("6304", "5"), ("6521", "5"))`):

```python
    (("6521", "5"), ("6533", "5")): "FS-132, the landing of the import of [OAIMath2026] family 158 (FS132-L1; copy data/fs132/l1/gate/receipt-axioms-final.log, gated commit 5df686f0): 6,576 records, 6,533 clean, 20 axiom-free, 18 imported, 5 purchases",
```

The previous landing's receipts, against which the three digests were taken: `data/fs131/l8a/gate/receipt-axioms-final.log`,
`receipt-vacuity-final.log`, `receipt-assumptions-final.log`.

**7. `CLAUDE.md` § The mission, row D.** *Replaces*, inside the row's second cell, "kernel-checked in its own library,
built and audited here (EXT-OAI1), read in full (EXT-OAI2), not in this library — so `χ(ℝ²) ∈ {6, 7}`. With no
hypothesis it is one question about measurable colour classes, and both of its answers decide the problem (§ The aim)":

> kernel-checked in its own library, built and audited here (EXT-OAI1), read in full (EXT-OAI2) — so `χ(ℝ²) ∈ {6, 7}`.
> **This library holds `6 ≤ χ(ℝ²) ≤ 7` on one declared outside theorem**
> (`Outside.OAI158.chromaticNumber_plane_six_or_seven`, kernel-checked from the axiom
> `Outside.OAI158.no_proper_five_coloring`, the release's stored statement term for term); what it proves with no import
> is still the classical interval `5 ≤ χ(ℝ²) ≤ 7` (row 33). With no hypothesis the problem is one question about
> measurable colour classes — in this library a theorem on the second declared outside theorem,
> `Outside.OAI158.proper_to_borel_weak`: `seven_le_chromaticNumber_plane_iff`, `7 ≤ χ(ℝ²) ⟺ lim_{ε→0} µ₆(ε) < 1` — and
> both of its answers decide the problem (§ The aim)

**8. `CLAUDE.md` § Frontier, "Where the problem stands", the first paragraph.** *(a) Replaces* "(family 158;
kernel-checked in its own library on the standard three axioms, the cone built and audited here, EXT-OAI1; its
manuscript read in full, EXT-OAI2). This repository's own kernel holds the classical interval, **5 ≤ χ(ℝ²) ≤ 7** (row
33), on the standard three axioms, its lower end through de Grey's graph (rung B).":

> (family 158; kernel-checked in its own library on the standard three axioms, the cone built and audited here,
> EXT-OAI1; its manuscript read in full, EXT-OAI2). **This library holds `6 ≤ χ(ℝ²) ≤ 7` on one declared outside
> theorem** — `Outside.OAI158.chromaticNumber_plane_six_or_seven`, kernel-checked from the axiom
> `Outside.OAI158.no_proper_five_coloring`, which is the release's stored statement term for term (FS132-L1). With no
> import this repository's kernel holds the classical interval, **5 ≤ χ(ℝ²) ≤ 7** (row 33), on the standard three
> axioms, its lower end through de Grey's graph (rung B).

*(b) Follows*, in the same paragraph, "the least number of colours in a measurable colouring proper at almost every
unit pair (`[OAIMath2026]` Thm 1.3 with row 130)":

> — in this library `χ(ℝ²) = χ_m⁰(ℝ²)` is `Outside.OAI158.chromaticNumber_plane_eq_chiM0`, kernel-checked from the
> declared outside theorem `Outside.OAI158.proper_to_borel_weak` (the release's transfer, term for term) and this
> library's own N-EASY, and row 131's criterion read for the plane itself is `seven_le_chromaticNumber_plane_iff`, on
> that import alone —

**9. `CLAUDE.md` § Frontier, the "Last filed" line** — a clause to lead it: "**the landing of FS-132's import**
(FS132-L1, 2026-10-07: `Outside/OAI158` through the gate — two declared outside theorems of `[OAIMath2026]` family 158;
the library holds `6 ≤ χ(ℝ²) ≤ 7` on the first, `χ(ℝ²) = χ_m⁰(ℝ²)` and `7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1` on the second; no
new row); before it …". And § Paths forward, "Open milestones", after "**Since 2026-10-07 the frontier stands on
`[OAIMath2026]` family 158**: `χ(ℝ²) ∈ {6, 7}` and `χ(ℝ²) = χ_m⁰(ℝ²)` with no hypothesis": "— in this library since
FS132-L1, each kernel-checked from one declared outside theorem (`Outside/OAI158`)".

**10. `LEDGER.md`.**
- **Row 33.** *Replaces* the italic sentence "*Outside this library, and audited here (`plans/EXT-OAI1-audit.md`):
  `[OAIMath2026]` family 158 proves in Lean, at v4.34.1 on the standard three axioms, that no map `ℂ → Fin 5` separates
  every unit pair, which in this row's form is `6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber` — with
  this row's upper end, `6 ≤ χ(ℝ²) ≤ 7` (`six_le_chromaticNumber_plane_of_no_proper_five`, drafted, conditional on
  their statement, added nowhere); the theorem this library holds unconditionally is still `5 ≤ χ(ℝ²) ≤ 7`.*" (the
  audit's Stage 8 sentence with the import's addition):
  > *The lower end is six by `[OAIMath2026]` family 158 (audited, `plans/EXT-OAI1-audit.md`): imported as the outside
  > theorem `Outside.OAI158.no_proper_five_coloring` (the release's stored statement, term for term:
  > `plans/FS132-I1-implementation.md`, `plans/FS132-L1-landing.md`), it gives
  > `Outside.OAI158.chromaticNumber_plane_six_or_seven : 6 ≤ χ(ℝ²) ≤ 7` on the standard three axioms and that import,
  > and `6 ≤ χ_m⁰(ℝ²) ≤ 7` (`chiM0_six_or_seven`); `chromaticNumber_plane_interval`, `5 ≤ χ(ℝ²) ≤ 7`, remains the
  > statement this library proves with no import.*
  Its address cell gains `Outside/OAI158.lean`; its milestone cell `FS-132`.
- **Row 130.** *Follows* "With no hypothesis (`[OAIMath2026]` Thm 1.3; `χ_m⁰ ≤ χ` kernel-checked there and audited
  here, EXT-OAI1): `χ(ℝ²) = χ_m⁰(ℝ²)`." (the audit's Stage 8 sentence with the import's addition):
  > *In this library the collapse needs no MR: `[OAIMath2026]`'s transfer `proper_to_borel_weak` (every `k`; audited,
  > on the standard three at Lean v4.34.1), imported as the outside theorem `Outside.OAI158.proper_to_borel_weak`,
  > gives `χ_m⁰(ℝ²) ≤ χ(ℝ²)` (`chiM0_le_chromaticNumber_plane`), so with N-EASY `χ(ℝ²) = χ_m⁰(ℝ²)` holds on the import
  > of that one theorem (`Outside.OAI158.chromaticNumber_plane_eq_chiM0`, which is wave 9's `Row130Collapse`), colour by
  > colour (`colorable_iff_nonempty_aeColouring`); `6 ≤ χ_m⁰(ℝ²)` holds on the other import (`six_le_chiM0`); the
  > release's Borel weak colourings are this library's `AeColouring`s, with no import
  > (`weakColoring_iff_unitPairsNull`); the equalities with `χ_CP` and with a field's plane in this row and row 128 are
  > untouched by it.*
- **Row 131.** *Follows* "At six, `χ_m⁰(ℝ²) ≥ 7` ⟺ `lim µ₆(ε) < 1`: `[SokolovVoronov2025]` §9's hypothesis, read
  uniformly in `ε`, is `χ_m⁰ = 7`, and a refutation needs no wild set — it is a sequence of periodic grid colourings
  with vanishing holes, the wildness only in the limit.":
  > *For the plane's chromatic number itself: `Outside.OAI158.seven_le_chromaticNumber_plane_iff : 7 ≤ χ(ℝ²) ⟺ sup_{ε >
  > 0} µ₆(ε) < 1`, kernel-checked from `Plane.seven_le_chiM0_iff` (this library's, on the standard three) and the
  > declared outside theorem `Outside.OAI158.proper_to_borel_weak` alone (FS132-L1; read aloud in its docstring).*
- **Row 43** (R6 (iii)). *Follows* "**the six-target**: χ(ℝ²) ≥ k + 1 from k-colour virtual edges at √3 AND at 2,
  neither sufficing alone on the hex-shell host (`add_one_le_chromaticNumber_plane_of_forced_pairs`; the {1, 2} host
  needs one, G26).":
  > *Since FS-132's import the target at five colours is a consequence of the declared outside theorem
  > `Outside.OAI158.no_proper_five_coloring`: the plane has no five-colouring (`Outside.OAI158.not_colorable_five`), so
  > the two hypotheses of `not_colorable_five_of_forced_pairs` and `six_le_chromaticNumber_plane_of_forced_pairs` hold
  > with nothing to prove and their conclusions are the import's own statements; on the standard three axioms alone the
  > row stands as it was, a conditional. The target at six colours (row 61) is open.*
- **Row 61** (R6 (iii)). *Follows* "and distance-set-generic, and over {1, 2} one √3 gadget suffices
  (`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`);":
  > *Since FS-132's import that statement's hypothesis holds with nothing to prove given
  > `Outside.OAI158.no_proper_five_coloring`: it ranges over five-colourings of the plane's {1, 2}-distance graph, each
  > a five-colouring of the plane (`chromaticNumber_unitDistance_le_distanceGraph`), of which there are none
  > (`Outside.OAI158.not_colorable_five`), and its conclusion `6 ≤ χ(ℝ²; {1, 2})` is a consequence of the import; the
  > colour-generic form at six colours (`seven_le_chromaticNumber_plane_of_forced_pairs`) stays open.*
- **The two theorems that take those hypotheses** (R6 (iv)), one line for wherever rows 43 and 61 or G26 cite them:
  "`not_colorable_five_of_forced_pairs` and `six_le_chromaticNumber_plane_of_forced_pairs` (`Instances/HexShell.lean`;
  'the six-colour programme's exact requirement'): given the import their hypotheses are true of an empty domain and
  their conclusions — `¬ (unitDistance ℂ).Colorable 5`, `6 ≤ (unitDistance ℂ).chromaticNumber` — are the import's own
  statements (`Outside.OAI158.not_colorable_five`, `six_le_chromaticNumber_plane`); on the standard three alone they
  are what they were, kernel-checked conditionals (as terms: `data/fs132/l1/five-empty.lean`)."

**11. `BIBLIOGRAPHY.md`, `[OAIMath2026]`, the third cell ("what of ours rests on it").** *Follows* "Nothing of ours
rests on any family but 158." (the import's draft 9, at the landing):

> Imported by FS132-I1 and landed by FS132-L1 as two declared outside theorems (`Outside/OAI158`:
> `no_proper_five_coloring`, `proper_to_borel_weak`), on which ten records of the library rest, five each; the stored
> statements compared term for term across the two pins (`plans/FS132-I1-implementation.md`; run again on the landed
> module, `plans/FS132-L1-landing.md`).

**12. `plans/EXT-OAI1-audit.md`, a dated note** (inventory item 629, ruling (e)). *Follows*, in "What was checked, and
by whom", "- the import's two statements closed by the release's theorems (`ImportReadback.lean`);":

> *Note, 2026-10-07 (filed at FS132-L1's landing): true at the release's pin, inside `import Mathlib`. The comparison
> across the two pins — the stored terms of the six copied definitions and the two statements, symbol against symbol,
> at this repository's pin under the module's own imports — is FS132-I1's (`plans/FS132-I1-implementation.md` stages
> 1–2): it found this stage's skeleton storing another proof of `FiniteDimensional ℝ ℂ` inside `WeakColoring` than the
> release's, equal by proof irrelevance and not symbol for symbol, and repaired it by one import. Run again by FS132-L1
> on the module as recompiled on the landed tree: eight of eight identical
> (`data/fs132/l1/readback/summary-gate-final.txt`).*

**13. `LEAN.md`** — the import's drafts 4 and 5, their slots checked on `main`, and three sentences this landing adds.
- § Assumptions, item 2 of "An imported theorem carries four things", *after* "(`StandingFive.kloosterman_bound`, with
  `kloostermanBound_of_ringChar_ne_two` and `kloosterman_page_of_kloostermanBound`)": "Where the source is itself Lean,
  copy its definitions, state the axiom over the copies, and compare the stored terms across the two pins — every
  constant, instance, binder and universe level — with a control that fires (`Outside.OAI158`;
  `tools/fs132_i1_readback.py`, on a print made at each pin by one dumper); the landing runs it again on the module as
  recompiled on the joined tree."
- § Searching — Lean, *a new line*: "Which instance a term is elaborated with depends on the imports, and equal text
  can store different terms: `volume : Measure ℂ` takes the proof `Complex.instFiniteDimensionalReal` of
  `FiniteDimensional ℝ ℂ` where `Mathlib.LinearAlgebra.Complex.FiniteDimensional` is imported and
  `FiniteDimensional.rclike_to_real` where it is not — equal by proof irrelevance, not symbol for symbol. A statement
  copied from another library is compared as the kernel stores it, never as text (FS132-I1)."
- § The gate, the vacuity bullet, *after* "A statement that concludes `False` is skipped as a refutation, so a marker on
  it is never read and proves nothing either way." (rulings R1, R2): "**An import can empty an older statement's
  domain, and no scan sees it.** A landing that brings an `axiom` refuting a carrier (`¬ ∃ c, …`, `¬ Colorable k`)
  reads the scan's sites and the assumptions step's declared hypotheses for that carrier: a statement whose hypothesis
  is empty only given a declared import says so in words in its docstring, naming the import and the theorem that shows
  it, and no `IsEmpty` statement or marker rests on an import until the tooling job rules how such emptiness is counted
  (`hexShell_plane5` given `Outside.OAI158.no_proper_five_coloring`, FS132-L1)."
- § The gate, the assumptions bullet, *after* "(`StandingFive.StandingFloor`, FS131-LT5)." (ruling R5): "A declared
  hypothesis that a declared import implies — its binder ranging over a domain the import empties — keeps its kind and
  says so in its source string until the tooling job classes such an entry (`inline:SixTarget`,
  `inline:SixTargetOneTwo`, FS132-L1); the step cannot find one: no theorem states the binder."
- § The gate's first paragraph: "23 planted faults" and "21 controls planted in one copy of the audit, 33 checks" stand
  (`axioms-selftest-final.log`, `assumptions-selftest-final.log`). § Assumptions' "(five do on `main`, in seven
  entries …)" stands: no hypothesis-form assumption was added.

**14. The grade** (the import's draft 10; the Proof Atlas). None of these is regraded to [kernel] without its
qualifier: `6 ≤ χ(ℝ²)` (row 33's new lower end), `6 ≤ χ_m⁰(ℝ²)`, `χ(ℝ²) = χ_m⁰(ℝ²)` (row 130's collapse) and
`7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1` (row 131 for the plane) are each **kernel-checked from one declared outside theorem** —
[kernel] over the import named beside it, the import itself [external], audited (EXT-OAI1) and read (EXT-OAI2). What is
[kernel] with no import: the dictionary between the release's definitions and this library's
(`properColoring_iff_colorable`, `weakColoring_iff_unitPairsNull`, `exists_weakColoring_iff_nonempty_aeColouring`) and
the models at seven. For the atlas: the nodes of rows 33, 130 and 131 gain an edge from `[OAIMath2026]` family 158
through `Outside/OAI158`, at that grade; row 43's and row 61's five-colour halves become consequences of the same
import; no node becomes [kernel] on the standard three.

**15. The open gate items at this landing, by name.**
1. **`hexShell_plane5`** (`Instances/HexShell.lean`): empty given `Outside.OAI158.no_proper_five_coloring`; the scan
   reads `UNKNOWN`, held by the baseline. Said in words in its docstring and in the baseline's prose (R2); no `IsEmpty`
   statement, no marker (R1).
2. **`inline:SixTarget`, `inline:SixTargetOneTwo`** (`scripts/Assumptions.lean`): declared kind `open`, implied by the
   same import; said in their source strings (R5); the front page's "five for open questions" counts them (draft 3 (b)).
3. **What the stored-term comparison does not cover**, as the import's record says: Mathlib between the tags `v4.32.0`
   and `v4.34.1` below the 83 constants the eight declarations name. Of the 83, 69 are identical at level one, 6
   identical up to universe-parameter names, 8 different — four private names of a moved file, one rename (`setOf` /
   `Set.ofPred`), two instance paths read at their first difference and not proved equal
   (`measureSpaceOfInnerProductSpace`, `Circle._proof_1`), one constant the module no longer names. What stands in for
   the rest: the two equivalences to this library's own vocabulary, kernel-checked at this pin, and nine
   characterisations that elaborate as one text at both pins. Not covered at all: the release's proofs as mathematics
   beyond one mind's reading (EXT-OAI2); the release's comparator and a second kernel (not run).
4. **The transfer is empty of content where no proper `k`-colouring exists** (`k ≤ 5`, by the other import; at six
   unknown): its consumers `nonempty_aeColouring_of_colorable`, `chiM0_le_chromaticNumber_plane`,
   `chromaticNumber_plane_eq_chiM0`, `seven_le_chromaticNumber_plane_iff` use it at every `k`; its model is at seven.
   The module's docstring says so.
5. **`Row130Collapse`** (branch `fs131-w9`, not merged) is `chromaticNumber_plane_eq_chiM0` by definition; the theorems
   of `Plane/Reduction` that assume it lose that hypothesis at that wave's join, not here (ruling 629 (c)).
6. `lean4checker` on this library was not run (a publication gate, `LEAN.md` § Trust ledger).

## For the tooling job (inventory ruling 475 (d)) — questions this landing leaves, by ruling R1 and R6 (i)

1. **Emptiness evidence resting on a declared import** (R1; the sentence sent to the coordinator: "the first emptiness
   evidence resting on a declared import rather than on the standard three — the scan does not look at axioms, so it
   would take it without saying so"). `gather` reads an unconditional `IsEmpty τ` whatever its axioms; if
   `IsEmpty ((unitDistance ℂ).Coloring (Fin 5))` were stated from `no_proper_five_coloring`, `hexShell_plane5` would
   read `VACUOUS`, or `DECLARED` under the marker, and "empty by the kernel on the standard three" and "empty given a
   declared outside theorem" would be one count. To decide: whether to allow it; if so, a verdict or a column that
   prints the two apart (the evidence row's axioms are one `collectAxioms` away), and its controls — an `IsEmpty` on a
   planted axiom must read apart from one on the standard three.
2. **A declared hypothesis that a declared import implies** (R6 (i)): what kind `inline:SixTarget` and
   `inline:SixTargetOneTwo` have now, and whether the assumptions step should find such a case. It cannot today: no
   theorem states the binder, so it reads as a declared hypothesis like any other.
3. **A check a landing that brings an `axiom` could run**: for an axiom of the shape `¬ ∃ c : X, P c`, `¬ Colorable k`
   or `IsEmpty τ`, list the scan's sites and the assumptions step's declared binders whose domains it empties. Both
   instances here were found by reading the scans' printed lists, not by a verdict.
4. **The records check knows one import** (`tools/fs131_l10b_records.py`: it refuses any record under IMPORTED but
   Weil's eight). `tools/fs132_l1_records.py` reads a table import → records and checks each record on exactly its one
   import, no leak, no record on two; it is a candidate for the standing form.
5. **`scripts/vacuity.sh --baseline` rewrites the baseline's header and drops its prose**, the ruled note on
   `hexShell_plane5` with it; the entries are what the gate reads.

## Theorems this phase proved, final

Module `Proofs/HadwigerNelson/Outside/OAI158.lean`, namespace `HadwigerNelson.Outside.OAI158`, as gated on `5df686f0`.
Axioms as the audit's saved log prints them (`data/fs132/l1/gate/receipt-axioms-final.log`, read by
`tools/fs132_l1_records.py`, `records-final.txt`); "three" is `[propext, Classical.choice, Quot.sound]`; H is the
declared outside theorem `no_proper_five_coloring`, T is `proper_to_borel_weak` — both `[OAIMath2026]` family 158,
**not proved here**: axioms, each the release's stored statement term for term.

**This job's one theorem** — kernel, on the three and T:
- **`seven_le_chromaticNumber_plane_iff : 7 ≤ (unitDistance ℂ).chromaticNumber ↔ (⨆ ε > (0 : ℝ), Plane.mu 6 ε) < 1`** —
  no hypothesis. Read against `CLAUDE.md` § The aim, item 5 ("`χ_m⁰(ℝ²) ≥ 7` iff six classes, each free of
  monochromatic pairs at distances in `[1−ε, 1+ε]`, cannot cover the plane up to holes of density tending to 0 as
  `ε → 0`", with `χ(ℝ²) = χ_m⁰(ℝ²)`): stage 4.

**The import's theorems, gated and landed by this job** (FS132-I1's; `plans/FS132-I1-implementation.md`):
- on the three alone (ten, and two instances): `properColoring_iff_colorable`, `direction_coe`, `map_coe_arcLength`,
  `map_prodMap_coe`, `weakColoring_iff_unitPairsNull`, `nonempty_aeColouring_of_weak`, `weakColoring_of_aeColouring`,
  `exists_weakColoring_iff_nonempty_aeColouring`, `exists_properColoring_seven`, `proper_to_borel_weak_model`;
  `anglePeriodPositive`, `angularMeasure.instIsProbabilityMeasure`;
- on the three and H (five): `not_colorable_five` (`¬ (unitDistance ℂ).Colorable 5`), `six_le_chromaticNumber_plane`
  (`6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber`; "`χ(ℝ²) ≥ 6`"),
  **`chromaticNumber_plane_six_or_seven`** ("`6 ≤ χ(ℝ²) ≤ 7`", row 33 with its lower end moved), `six_le_chiM0`
  ("`6 ≤ χ_m⁰(ℝ²)`"), `chiM0_six_or_seven`;
- on the three and T (four, and this job's): `nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`,
  `chiM0_le_chromaticNumber_plane` ("`χ_m⁰(ℝ²) ≤ χ(ℝ²)`"), **`chromaticNumber_plane_eq_chiM0`** ("`χ(ℝ²) = χ_m⁰(ℝ²)`,
  with no hypothesis": no binder).

No record rests on both imports; none on `sorryAx`; no `native_decide`. **Nothing here is [kernel] on the standard
three that was not before, but the dictionary and the models**: the headline statements are kernel-checked from one
declared outside theorem each (draft 14).

## Stage 7 — SAVED (FS132-L1): the landing

**`main` moved while the gate ran, twice merged before it and once after.** Before the gate: `db43b298` (merge
`cfabd587`) and `7eb8dbd9` (merge `bfa16394`), each touching `plans/` and `data/` only (`data/fs132/l1/merge-2-names.out`,
`merge-3-names.out`) — both inside the gated commit. After the gate: `main` is at `6b125da4`, nine commits past
`7eb8dbd9` (the asking lane's re-rank, two briefs, the inventory, the handoff); `git diff --name-status 7eb8dbd9
6b125da4` (`data/fs132/l1/merge-4-names.out`) lists eleven files, **every one under `plans/` or `data/`** — the filter
for anything outside `plans/`, `data/`, `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md` prints
nothing. Merged by hash; the gate is not re-run, by the brief's step 7.

**What the landed tip differs from the gated commit in** (`git diff --name-only 5df686f0 <tip>`, the filter for paths
outside `data/` and `plans/`): one file, `tools/fs132_l1_slots.py` — this job's check of the drafts' slots against the
files, written after the gate and read by no step of it. Everything else is `data/` (the gate's logs) and `plans/`
(this record; `main`'s own). `Proofs/`, `Proofs.lean`, `scripts/`, `ARCHITECTURE.md`, the lakefile and the pin are the
gated commit's, byte for byte (checked before the push, below).

**The push**: `git push origin HEAD:main` from the worktree, a fast-forward (`main`'s tip `6b125da4` is an ancestor of
the pushed commit by the merge). Its receipt — the pushed hash, `git ls-remote`, and the ancestor check — is appended
below after the push, on the branch.

**The receipt** (`data/fs132/l1/push-main.out`, `ls-remote-main.out`): `git push origin 7ea7c364…:main` — exit 0,
"`6b125da47..7ea7c364e  7ea7c364eb1e3c86bd1536de38aa751f0054e65b -> main`", a fast-forward, no force;
`git ls-remote origin refs/heads/main` reads `7ea7c364eb1e3c86bd1536de38aa751f0054e65b`. **`main` is at `7ea7c364`:
the import is landed.** Checked on that commit before the push, by hash: `git diff 5df686f0 7ea7c364 -- Proofs/
Proofs.lean scripts/ ARCHITECTURE.md lakefile.toml lake-manifest.json lean-toolchain` is empty (0 lines);
`git diff --name-only 5df686f0 7ea7c364` outside `data/` and `plans/` lists `tools/fs132_l1_slots.py` alone;
`git merge-base --is-ancestor 6b125da4 7ea7c364` holds. This receipt and the report are one commit on the branch after
the landed one (`plans/`, `data/` only): `fs132-wi1` is that one commit ahead of `main`.

**Left on the machine**: no process of this job (the slot ledger holds none; every build, scan and control ended with
its exit status in a saved log). Nothing was written under `~/source/math` or `~/.cache/ext-oai1` (`find -newer` a
marker, each comparison run: 0 files). The worktree's `.lake/build` is the gated commit's library.

## Slips, my own

1. **The comparison's runner read two prints as different on its first pass** — the slot's admission line, which the
   import's saved prints hold and mine keep in a separate file. Caught by the runner's own step line; the runner now
   takes that one line out of both sides (stage 3).
2. **A scripted edit's anchor was mistyped** (the registry paragraph, first attempt): the script's assertion refused,
   nothing was written; second attempt checked by script (the rulings' section).
3. **A comment in `data/fs132/l1/five-empty.lean` said a control had been tried before it was run.** Corrected in the
   same step: the control is its own file, run, refused as it must be (stage 5.2).
4. **The records tool's docstring first promised its plants "all at once" as well as one at a time**; only the second
   was written. The docstring was corrected before the tool's first run.
5. **The gate was launched from the runner itself, not from a snapshot copy** (`RUNNING.md` § Building: a shell script
   is never edited while it runs). Neither runner was touched while the pass ran; a later long run of mine launches
   from the copy.
6. **One foreground `sleep`** while waiting on a build, early in the job; later waits are on the log's own last line.

**Token count**: no reading of the harness's count at any stage; my own estimate at this stage is about 430k — past
the brief's guidance (350k), inside its hand-back line (500k).
