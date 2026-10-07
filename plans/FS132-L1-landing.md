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
