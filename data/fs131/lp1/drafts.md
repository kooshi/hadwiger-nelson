
## Drafts for the front page (FS131-LP1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and **the
exact words on `main` it replaces or follows**; `data/fs131/lp1/drafts-slots.py` checks that each slot occurs exactly
once on `main` (output `drafts-slots.out`: 24 slots, each once; the control string absent). Each count names the log
line it comes from; the gated commit and its logs are in stage 7 (`data/fs131/lp1/gate/*-final.*`; the scans' full
outputs `receipt-axioms-final.log`, `receipt-vacuity-final.log`, `receipt-assumptions-final.log`). **Whose it is**: the
transfer `proper_to_borel_weak` and every ported proof are `[OAIMath2026]`'s (family 158, the release's Lean at commit
`adc7f124`); the port — the generator, the tables, the adaptations, the ruled statement changes, the read-back across
pins, the `nolint` lines — and the kernel check at this pin are this project's. Nothing here moves a value.*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 7531 clean and 5 declared
purchases, and 38 imported (and 28 axiom-free; 7,602 records at the landing of FS-131's three-and-four-colours line,
FS131-LJ1, 2026-10-14)". From `axioms-final.log`, "audited: 9024 records — 8961 clean on the standard axioms, 32
axiom-free, 26 imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 8961 clean and 5 declared purchases, and 26 imported (and 32 axiom-free; 9,024 records at the
> landing of the port of `[OAIMath2026]`'s transfer proof, FS131-LP1, 2026-10-14)

7,602 + 1,422 = 9,024 (the 31 generated modules' records, FS131-IPD1's registration); clean 7,531 + 12 (the transfer's
former consumers) + 1,418 = 8,961; axiom-free 28 + 4 = 32 (four generated records); imported 38 − 12 = 26.

**1b. The same paragraph, the declared imports.** *Replaces* "The library declares three outside axioms: … run again at
the landing on the module as recompiled there);" (the whole run of the slot) *by*

> The library declares two outside axioms: `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums,
> `[Weil1948]` p. 207, read against its page by two readers — with twenty imported records (twelve of them the
> three-colour criterion's and row 99's, FS131-LJ1); and, from `[OAIMath2026]` family 158, a Lean development built and
> audited here at its own pin, `Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair —
> with six; no record rests on both, and the second is the release's stored statement term for term
> (`tools/fs132_i1_readback.py`, run again at the landing on the module as recompiled there). The release's transfer
> `Outside.OAI158.proper_to_borel_weak` — a proper `k`-colouring of the plane gives a Borel one proper at almost every
> unit pair — is no longer an import: it is the release's theorem with its proof ported (31 modules generated whole from
> the release's files, `Outside/OAI158Basic` … `OAI158BorelTransfer`; FS131-KO1 to FS131-IPD1), every proof checked by
> this kernel at this pin on the standard three; its stored statement is the release's term for term and the deleted
> axiom's (FS131-LP1's read-back across pins; FS131-IPD1's switch), and the twelve records that rested on it are clean
> (three of them FS-131's: `χ(ℝ²) = χ_m(ℝ²)`, the Lebesgue-measurable chromatic number, in two forms and colour by
> colour, `Plane/LebesgueNumber`);

From `axioms-final.log`, "declared imports (2): HadwigerNelson.StandingFive.kloosterman_bound,
HadwigerNelson.Outside.OAI158.no_proper_five_coloring"; `records-final.txt`, "IMPORTED: 26 records, 20 on Weil's bound
alone, 6 on the five-colour theorem alone" and "the twelve records that rested on it, each under CLEAN on exactly the
three (12 of 12)".

**1c. The same paragraph, the palette lemmas.** *Replaces* "kernel-checked at this pin on the standard three, and rest
on neither declared outside theorem;" *by* "kernel-checked at this pin on the standard three, and rest on no declared
outside theorem;" (one of the two is gone).

**2. `CLAUDE.md` § The gate, the vacuity scan's counts.** *Replaces* "`declarations=16125 refutations-skipped=228
sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." From `vacuity-final.log`, "scanned:
declarations=17785 refutations-skipped=232" and "sites: sites=1454 vacuous=0 stale=0 declared=3 witnessed=38
generic=1411 unknown=2":

> `declarations=17785 refutations-skipped=232 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

Two counts move: declarations +1,660 (the port's), refutations +4 (stage 4.3 names them: the release's own steps
inside proofs by contradiction). No site is added: the scan does not track the release's structures. The baseline's
header is refiled on the branch.

**3. `CLAUDE.md` § Trust ledger, the nine counts.** *Replaces* "`axioms=3 rests=39 named=19 inline=14 outside=7
ours=21 open=5 takes=102 mentions=1` — three outside theorems declared as axioms, with thirty-nine theorems resting on
them;" *by* (from `receipt-assumptions-final.log`, its `=== TOTALS ===` line, "axioms=2 rests=27 named=19 inline=14
outside=7 ours=21 open=5 takes=102 mentions=1")

> `axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1` — two outside theorems declared
> as axioms, with twenty-seven theorems resting on them;

**3b.** *Follows* "now the theorem `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`, which rests on Weil's
bound)." *with* " One outside theorem has left the axioms since: at FS131-LP1, 2026-10-14, the transfer
`Outside.OAI158.proper_to_borel_weak`, now `[OAIMath2026]`'s theorem with its proof ported, and its twelve `RESTS` rows
with it." Two of the nine move (`axioms` 3 → 2, `rests` 39 → 27); the ledger is rewritten on the branch by the script
(`--write-ledger`: twelve rows lost, none gained, 130 rows).

**4. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after `(("7447", "5"), ("7531", "5")):`'s:

```python
    (("7531", "5"), ("8961", "5")): "FS-131, the landing of the port of [OAIMath2026]'s transfer proof — the release's theorem proper_to_borel_weak (a proper k-colouring of the plane gives a Borel one proper at almost every unit pair) with its proof ported whole, 31 generated modules, every proof checked by this kernel at v4.32.0; the axiom of that name deleted, its twelve records clean (chi(R^2) = chi_m0(R^2), 7 <= chi(R^2) iff lim mu_6 < 1, chi(R^2) = chi_m(R^2), the disc criterion's half toward seven); the mathematics [OAIMath2026]'s, the port and the kernel check ours (FS131-LP1; copy data/fs131/lp1/gate/receipt-axioms-final.log, gated commit <stage 7's hash>): 9,024 records, 8,961 clean, 32 axiom-free, 26 imported, 5 purchases",
```

**4b. The same file's table of superseded counts.** Every token the drafts retire, in that table's form, each with its
value as the reason: `"7531"` (8961 clean); `"7,602"` and `"7602"` (9,024 records); `"38 imported"` (26 imported);
`"28 axiom-free"` (32); `"declarations=16125"`, `"16125"`, `"refutations-skipped=228"` and `"declarations=16125
refutations-skipped=228 sites=1454"` (17785, 232); `"axioms=3 rests=39"`, `"rests=39"` (27) and `"axioms=3 rests=39
named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1"` (the new nine); `"three outside theorems declared as
axioms"` (two); `"thirty-nine theorems resting"` (twenty-seven); `"three outside axioms"` (two). The reason for each:
"superseded gate count, refiled at FS131-LP1's landing from data/fs131/lp1/gate/receipt-axioms-final.log (the vacuity
count from receipt-vacuity-final.log, the assumption counts from receipt-assumptions-final.log); the old count stays in
data/fs131/lj1/gate/ and in GATE_CHANGES". **The next landing's previous receipts are
`data/fs131/lp1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**5. `CLAUDE.md` § The mission, row D.** *Replaces* "in this library a theorem on the second declared outside theorem,
`Outside.OAI158.proper_to_borel_weak`:" *by* "in this library a theorem on the standard three axioms, through
`[OAIMath2026]`'s transfer `Outside.OAI158.proper_to_borel_weak`, its proof ported and checked by this kernel
(FS131-LP1):". (The row's "This library holds `6 ≤ χ(ℝ²) ≤ 7` on one declared outside theorem" stands: that one is
`no_proper_five_coloring`.)

**6. `CLAUDE.md` § Where the problem stands, the measurable number.** *Replaces* "kernel-checked from the declared
outside theorem `Outside.OAI158.proper_to_borel_weak` (the release's transfer, term for term) and this library's own
N-EASY, and row 131's criterion read for the plane itself is `seven_le_chromaticNumber_plane_iff`, on that import
alone —" *by* "kernel-checked on the standard three axioms from `Outside.OAI158.proper_to_borel_weak` — the release's
transfer, its proof ported and checked by this kernel, its stored statement the release's term for term (FS131-LP1) —
and this library's own N-EASY, and row 131's criterion read for the plane itself is
`seven_le_chromaticNumber_plane_iff`, on the standard three —".

**7. The same paragraph, the Lebesgue number.** *Replaces* "so `χ(ℝ²) = χ_m(ℝ²)` on the declared outside theorem
`Outside.OAI158.proper_to_borel_weak` (`Plane.chromaticNumber_plane_eq_chiLebesgue`; through the gate, FS131-LC1)"
*by* "so `χ(ℝ²) = χ_m(ℝ²)` on the standard three axioms (`Plane.chromaticNumber_plane_eq_chiLebesgue`; through the
gate, FS131-LC1; the transfer ported, FS131-LP1)".

**8. The same paragraph, the discs.** *Replaces* "*such a disc gives seven* is the contrapositive of `radius_down` and
rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`. So an exclusion on a disc reaches seven
only through the transfer," *by* "*such a disc gives seven* is the contrapositive of `radius_down` and rests on the
standard three axioms, through the release's transfer `Outside.OAI158.proper_to_borel_weak`, ported (FS131-LP1). So an
exclusion on a disc reaches seven only through the transfer — `[OAIMath2026]`'s theorem —,".

**9. § Frontier, Open milestones, FS-124's disc criterion.** *Replaces* "the half toward six on the standard three
axioms and the half toward seven on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`;" *by* "both
halves on the standard three axioms, the half toward seven through `[OAIMath2026]`'s transfer
`Outside.OAI158.proper_to_borel_weak`, ported (FS131-LP1);".

**10a. § The aim, item 5.** *Replaces* "toward seven over the outside theorem on Borel transfer (row 161; [kernel] since
FS124-L1)" *by* "toward seven through the release's Borel transfer (row 161; [kernel] since FS124-L1, on the standard
three since its proof was ported, FS131-LP1)".

**10b. § Where the problem stands, item 31.** *Replaces* "the direction toward seven over the outside theorem on Borel
transfer (row 161, [kernel] since FS124-L1)" *by* "the direction toward seven through the release's Borel transfer (row
161, [kernel] since FS124-L1, on the standard three since FS131-LP1)".

**11. § Frontier, Open milestones, the frontier's ground.** *Replaces* "in this library since FS132-L1, each
kernel-checked from one declared outside theorem (`Outside/OAI158`)." *by* "in this library since FS132-L1 — the first
kernel-checked from one declared outside theorem (`Outside.OAI158.no_proper_five_coloring`), the second on the standard
three axioms since the transfer's proof was ported (FS131-LP1)."

**12. § Frontier, Last filed.** *Replaces* "Last filed: **the landing of FS-131's three-and-four-colours line**
(FS131-LJ1, 2026-10-14:" *by* "Last filed: **the landing of the port of `[OAIMath2026]`'s transfer proof** (FS131-LP1,
2026-10-14: the release's `proper_to_borel_weak` a theorem of this library, its proof ported whole — 31 generated
modules, 1,422 records on the standard three; the axiom deleted, the library's outside axioms three → two; `χ(ℝ²) =
χ_m⁰(ℝ²)`, `7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1`, `χ(ℝ²) = χ_m(ℝ²)` and the disc criterion's half toward seven on the standard
three; the stored statement the release's term for term; other people's mathematics, ported; no value moved); before
it **the landing of FS-131's three-and-four-colours line** (FS131-LJ1, 2026-10-14:". The later clause of the same line,
FS131-LC1's "on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`", is history true at that landing;
it may stay.

**13. `ARCHITECTURE.md` § Trust, Imported outside theorems.** The row whose head is "| `Outside.OAI158.proper_to_borel_weak`
(`Outside/OAI158`) | `[OAIMath2026]` family 158, `lean/OAI/Geometry/PlaneColoring/BorelTransfer.lean` lines 436–437 at
commit `adc7f124`" *removed*; and "Three at present." *replaced by* "Two at present. The third, `Outside.OAI158.proper_to_borel_weak`
(`[OAIMath2026]` family 158), is no longer a purchase: the release's theorem, its proof ported whole into
`Outside/OAI158Basic` … `OAI158BorelTransfer` (FS131-KO1 to FS131-IPD1; the switch deleted the axiom) and its twelve
records clean since FS131-LP1."

**14. `LEAN.md`** — the port's classes, from the four records (the plan's F1 and F2, FS131-IPA1's, FS131-IPB1's,
FS131-IPD1's (a)–(d), and this job's).
- *(a) § Assumptions, following* "scoping changes no stored term, so the read-back prints the same bytes.":
  *"**A port of the release's whole proof** (`Outside/OAI158Basic` … `OAI158BorelTransfer`, FS131-KO1 to FS131-LP1)
  copies whole files: a cone computed from the source's compiled constants misses what a proof uses only definitionally
  (an `rfl` lemma a `simp` rewrites with leaves no constant in the term), so where the cone's files import nothing outside
  it the files are copied whole and the cone checks that nothing it names is missed. Its tables name, each entry with its
  reason and its mechanical check in the read-back: **renames** and **proof patches** (never in a statement or a
  definition); **adaptations** — a release-internal statement or definition whose Mathlib API changed between the pins
  (`Measure.map`, `ProbabilityMeasure.map` between v4.32.0 and v4.34.1) rewritten to name the same object by inserting a
  closed measurability argument, never a hypothesis or a binder, or in a definition's value the release's own instance
  named with the `Prop` it asks proved explicitly (`CommutingSpectral.algebra_commRing`); flagged ADAPTED, checked to
  differ from the source's print only by the inserted argument; **ruled statement changes** — exactly the release's own
  section variables as binders where the statement as written is false at this pin
  (`DifferenceFourier.differenceLaw_probability`), and **the cascade** of that change to every declaration whose type
  names the changed definition (`CosetCenter.Embedding.frequencyLaw`, `center`; a dropped `omit … in` listed), each
  checked by stripping exactly those binders; **`nolint`** — an environment linter silenced on one declaration, by name,
  in the file, with its reason class (the release's name, the release's binder, or simp's normal form of the release's
  lemma; `@[nolint …]` merged into an existing attribute block where there is one). Every class is refused on the
  target statements, on a declaration another branch holds a copy of, and on anything a statement of ours names. **Pin
  differences** — a Mathlib definition whose stored form changed between the pins without changing what it names
  (`Monoid`'s parents, `Finset.HasAntidiagonal`'s class parameter, `eLpNorm`/`MemLp`/`Lp`, `Algebra.algebraMap`'s
  instance path, `Polynomial.coeff`'s type, `Filter.EventuallyEqSet`) — are patched nowhere: the read-back
  (`tools/fs131_ipa1_readback_port.py`) has a named rule for each with planted controls (PIN-DIFFERENCE, CLASS_PARAMS,
  COEFF, EQSET), and a release-own constant in an instance argument is accepted only with a kernel check at this pin
  that the two instance terms agree by `rfl`, its non-agreeing plant refused (INSTANCE_EVIDENCE, `generator_unitary`);
  a target may read up to Mathlib's instances only with its stored type IDENTICAL to the axiom it replaces
  (TARGET_IN_LIBRARY, `Spectral.residual_fourier`) (FS131-KO1, FS131-IPA1, FS131-IPB1, FS131-IPD1, FS131-LP1)."*
- *(b) § Searching — Lean, following* "(`data/fs131/kj1/copy_build.sh`, FS131-KJ1; inventory item 694's condition).":
  - *"Between Mathlib `v4.32.0` and `v4.34.1` `Measure.map` changed: at `v4.32.0` the push-forward by a map that is not
    almost-everywhere measurable is `0`, at `v4.34.1` a measure of the same mass; and `ProbabilityMeasure.map (ν) {f}
    (f_aemble : AEMeasurable f ν)` there takes only `(f)`. A text written at the later pin names the same object here as
    `ν.map (f := g) h` and `⟨μ.map g, isProbabilityMeasure_map h⟩` (FS131-KO1)."*
  - *"Importing `Mathlib.Order.CompletePartialOrder` reroutes the `SupSet` of a `⨆` in a complete lattice through
    `CompletePartialOrder.toSupSet`: four stored statements of this library moved, instance arguments only, when a
    module saw it; a port leaves it out of its imports (FS131-IE1, FS131-KO1)."*
  - *"`convert h using 1` can leave two goals at the pin where the source's pin left one; run the source's closing
    tactic with `all_goals` (FS132-I2, FS131-KO1). `isAlgebraic_natCast` is `isAlgebraic_nat` at the pin."*
  - *"`#eval` holds what it prints in a captured stdout and emits it at the end, so a dump of hundreds of MB never
    finishes: re-point stdout at a file for the loop (`IO.setStdout (IO.FS.Stream.ofHandle h)`;
    `data/fs131/ipd1/readback/laneD/ReleaseDumpFile.lean`). A definition's value printed as a tree can be millions of
    nodes (`LabelModel.representation`: 5.5 million) (FS131-IPD1)."*
  - *"A private declaration of another module is nameable in a `section` that opens it with Batteries' `open private
    <name> from <module>`; `#print axioms` then prints its full private name (`scripts/Axioms.lean`'s port block;
    FS131-IPD1)."*
  - *"A declaration takes one attribute block: `@[a]` on one line and `@[b]` before the keyword on the next does not
    parse; merge (`@[nolint simpNF, simp]`). `@[nolint <linter>]` attaches to an anonymous instance, and the linter's name
    must be declared where the attribute is elaborated (`data/fs131/lp1/nolint/probes/attrs.lean`; FS131-LP1)."*
- *(c) § Building, following* "and the manifest is then what shows that no copied file has been rewritten.": *"A module
  whose upstream must change before it can elaborate (a port whose name an upstream axiom holds) is elaborated in a
  symbolic copy of the compiled library (`cp -as` of `.lake/build/lib/lean/Proofs`), each module compiled there written
  over its link after the link is removed, and the copied-from `.olean`s checked unchanged by hash
  (`data/fs131/ipd1/farm2-run.sh`, FS131-IPD1; `data/fs131/lp1/advalue-run.sh`, FS131-LP1)."*
- *(d) § The gate, following* "an unused anonymous instance binder is, and the build's own linters do not warn about
  it.": *"A port's own text meets the linters as the source wrote it: 25 findings in the release's family 158 (its
  names with underscores, its unused binders, one `@[simp]` lemma simp rewrites) are silenced in the file by the
  generator's `nolint` table, each by name with its reason class, and the lint's planted control is run again outside
  the port after (FS131-LP1). A read-back across pins whose prints run to gigabytes is read block by block, never whole
  (`ruled_compare_stream`, within 8 GiB where the whole read took 20), its equivalence with the whole read shown on
  every small label and its self-test planted into the stream; a planted control whose failure cannot be reached on a
  label (a rule idle there) is reported UNREACHABLE with the count that shows it, never counted as passing
  (FS131-LP1)."*

**15. `BIBLIOGRAPHY.md`, `[OAIMath2026]`'s row.**
- *(a) What rests on it, replaces* "Imported by FS132-I1 and landed by FS132-L1 as two declared outside theorems
  (`Outside/OAI158`: `no_proper_five_coloring`, `proper_to_borel_weak`), on which ten records of the library rest, five
  each;" *by* "Imported by FS132-I1 and landed by FS132-L1 as two declared outside theorems (`Outside/OAI158`); one
  remains, `no_proper_five_coloring`, with six records; the other, the transfer `proper_to_borel_weak`, is the release's
  theorem with its proof ported since FS131-IPD1's switch and FS131-LP1's landing, and its twelve records are clean;".
- *(b) Its reading, replaces* "rest on the imported `proper_to_borel_weak`, `Plane.radius_five` on the imported
  `no_proper_five_coloring`; nine and six records of the audit rest on the two." *by* "go through the transfer
  `proper_to_borel_weak`, `Plane.radius_five` on the imported `no_proper_five_coloring`. **The transfer's proof, ported
  whole** (FS131-KO1 to FS131-LP1): 31 files of `lean/OAI/Geometry/PlaneColoring/` and `lean/OAI/Analysis/PlaneSpectrum/`
  at commit `adc7f124` — 1,299 source declarations, 12,005 lines of declarations (15,964 with scaffolding) — generated
  into `Outside/OAI158Basic` … `OAI158BorelTransfer` by `tools/fs131_ko1_port.py`, every proof checked by this kernel at
  v4.32.0, each module's header the notice of change and the licence beside them. Read for the port: every copied
  declaration as text (by the generator), the stored statements against the release's across the pins (the read-backs
  of FS131-IPA1, FS131-IPB1, FS131-IPD1, and lane D's at FS131-LP1: READBACK OK, 524 constants), the transfer's
  statement by eye term for term (FS131-LP1 stage 5); the proofs compiled, not read."

## Open gate items at this landing

*Each named, with what would close it; none of them is a red check of this gate.*

1. **The density equality's join** (plan § 4.5, steps 1–9). Step 0 is FS131-IPD1's (54 IDENTICAL, 3 up to proof
   arguments, ruled). On `fs133-wb1`, `Spectral.residual_fourier` is still an axiom; this landing's evidence that the
   ported theorem's stored type is that axiom's (stage 2's IN-LIBRARY receipt) is what the join reads. Owed to that
   landing.
2. **`lean4checker`** (the publication gate, `LEAN.md` § Trust ledger) has not been run over the port's 31 modules.
3. **The comparator's whole-print path** (`ruled_compare`, `self_test`) is kept as the streaming reader's oracle and as
   `--self-test-inmemory`. On lane D it needs 20 GiB; nothing calls it there.
4. **Lane D's prints are not committed** (1.42 and 1.45 GB). `data/fs131/lp1/dump-laneD.sh` reproduces them, and their
   sha256 are in `prints.sha256`. The tree has them now, and the hand-back deletes them.
5. **ADAPTED_VALUE accepts a value that differs only in instance arguments.** That is its ruling: such a value reads
   UP-TO-INSTANCES, and the record of instance constants is what refuses a new constant there (stage 2.6). A rule that
   compared the full value would need a new ruling.
6. **The generator's textual statement guard** (item 763's tool defect) still stands. The read-back across pins is the
   per-module gate for it, and it reads OK.
7. **`scripts/Vacuity.lean` line 561** (inside FS132-L1's history paragraph) still says "the imported
   `proper_to_borel_weak`". That is history, and the file is not this brief's.
8. **Owed elsewhere, from item 759:** the correction to `plans/EXT-OAI1-audit.md` § The pieces to adopt ("about 16,600
   lines" → 12,005 lines of declarations, 15,964 with scaffolding). Item 758 asked whether the trial's generated
   copies under `data/fs131/ko1/trial/generated/` stay; they are untouched here.
9. **`hexShell_plane5`'s classing** (the tooling job's question since FS132-L1) is unchanged by this landing.
