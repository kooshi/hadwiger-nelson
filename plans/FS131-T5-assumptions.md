# FS131-T5 — the gate enumerates what the library assumes

*The record of job FS131-T5 (de Bruijn, the implementer; a tooling job). Brief:
`data/fs131/briefs/FS131-T5-gate-assumptions.md` on `main`'s working tree (untracked there when read; the copy this job read is
`data/fs131/t5/brief-as-read.md`). Branch `fs131-t5`, cut from `main` at `3bfc7d2e`. Everything this record cites is under
`data/fs131/t5/`.*

## Theorems this phase proved

None. This is a tooling job: it adds a step to the gate and changes no file under `Proofs/`, so it proves no theorem and
moves no axiom count.

## Stage 1 — SAVED (FS131-T5): the readback, the build as given, and a census taken before the design

**The quotations.** The brief quotes fifteen statements, each as a first line with its source. All fifteen are whole lines of
their sources, verbatim (`tools/fs131_t5_readback.py`, output `data/fs131/t5/readback.out`: `quotations=15 mismatched=0`). The
tool's own control (`--self-test`, `data/fs131/t5/readback-selftest.out`): a faithful quotation reads MATCH and the same line
with one character changed reads MISMATCH.

**What was read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail,
and watch it fail; `scripts/axioms.sh`; `scripts/Axioms.lean`'s header, its instruments (`inScope`, `isBibKey`, `hasBibKey`,
`declareImport`, `libraryAxioms`), the IMPORTED banner with its procedure, and the file's end; `scripts/Vacuity.lean` and
`scripts/vacuity.sh`; `scripts/gate_report.py`; `scripts/gate-log.sh`; the header and first controls of
`scripts/axioms-controls.txt`; inventory items 548 and 551; `plans/FS131-L10A-landing.md` draft 5 (the table of named
hypotheses) and draft 6; `plans/FS131-kernel-plan.md` § 7.4; `ARCHITECTURE.md` § 5; and each quoted definition with its
docstring.

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0:
"All targets up-to-date (5814 jobs)", "all 1805 modules already up to date, nothing built, 0 module(s) with warnings"
(`data/fs131/t5/logs/build-stage1.log`).

**A census, taken before the design** (`data/fs131/t5/census/census.lean`, output `census.out`; read-only, declares nothing;
not the step). It reads every hand-written constant's statement as written and classifies each hypothesis — a binder whose
type is a proposition. What it measured on `main`'s tree at `3bfc7d2e`, the numbers the design below is fitted to:

| quantity | count |
|---|---|
| hand-written library constants read | 12,738, of them 8,956 theorems; none failed to telescope |
| binders, all constants | 51,178 |
| hypotheses (binders whose type is a proposition) | 16,492, of them 275 instance-implicit |
| **closed hypotheses** (the type holds no free variable) | **1,468**, every one explicit, every one in a theorem |
| — of those, `HadwigerNelson.Justified … <a watermark>` (the LRAT chain steps) | 1,431 |
| — the rest | 37, in 26 theorems |
| library `Prop`-formers (non-theorem constants whose type ends in `Prop`) | 275 |
| — taken as a hypothesis by some constant | 222 |
| — taken as a hypothesis and concluded by no theorem | 45 |
| hypotheses whose head is a library former / another constant / no constant | 4,625 / 9,753 / 2,114 |

Three readings of it that decide the design:

1. **A closed hypothesis is the assumption's own shape, and the class is small.** A hypothesis with no free variable is a
   statement about the world, not a condition on the theorem's parameters. Of the 37 that are not LRAT chain steps, every one
   is one of: a named assumption at a closed instance (`RealAlgebraicDescent` six times, `StandingFloor 7` and `5`,
   `BochnerHerglotz` and `InvariantMeasureOnClosed` at `ℚ(√47)`, `OrderBound … 168`, `Row130M1`, `Voronov11`, `G4`); a hand
   result or a computed bound written out in the binder (`cl2`'s `hRQ4`, `hRQ5`; `five_le_chromaticNumber`'s `hRow123`; the
   three `(finitePlane q).indepNum ≤ N`); an open question or a design target a theorem is conditional on (the forced-pair
   hypotheses of the `χ ≥ 6` and `χ ≥ 7` targets, `∀ R > 0, ∃ F p, F.Covers p R ∧ F.Valid`, `∀ ε > 0, mu 6 ε < 1`); a
   statement another library theorem proves (`¬ (edgeGraph 1581 deGrey.edges).Colorable 4` and the two Heule graphs'); or the
   one hypothesis of a refutation (three "planted false twin" theorems concluding `False`). The 1,431 chain steps are the
   fourth kind: each takes the previous watermark, which the previous step concludes.
2. **"Taken and never concluded" finds seventeen of the named assumptions and twenty-eight ordinary predicates.** Among the 45:
   `RealAlgebraicDescent`, `OrderBound`, `Row130M1`, `G4`, `BochnerHerglotz`, `InvariantMeasureOnClosed`, `StandingFloor`,
   `TCA`, and `Interface.{RU, APlus0, APlusOfR88, Count, PE2, EFPlus, MulStable, NegCircle}` — and beside them `IsUsablePrime`,
   `NoAffFieldHyp`, `BaseCtx`, `Terminal`, `Near.RayConfig` and the like, conditions on a theorem's parameters whose instances
   are proved inside proofs, in `example`s, or nowhere. It misses the assumptions some theorem does conclude: `BochnerOn`
   (`bochnerOn_bot`, at one topology), `Interface.MR` (`mr_of_pe2_efPlus`, from two other assumptions), `Voronov11`
   (`voronov11_of_forall_mu_lt`, from the open question).
3. **Some assumptions on `main` have no name and no closed form**, and nothing in a type tells them from a condition:
   `min_localBound_five_le_chromaticNumber` takes `hRow99 : localBound F ≤ 4 → localBound F ≤ χ(F²)` (row 99, ours) and
   `hCLS : 5 ≤ localBound F → TCA F` (X23D-CLS, ours) beside `hL : localBound F ≤ 5` in its corollary, which is a condition on
   `F`; `falconerFan_five_mem_eight` takes `hR78` over any lattice. Binder names do not separate them either: 32 binders are
   named like `hR1`, most of them `R ≤ 1`.

**An assumption the brief's seed list lacks**: `Bridge.RealAlgebraicDescent` (Tarski; Artin–Lang), taken by six theorems of
`Proofs/HadwigerNelson/Bridge.lean`. A record of ours does name it (`CLAUDE.md` § Where the problem stands: "the bridge
`χ(ℝ²) = max_F χ(F²)` conditional on one named true hypothesis", row 107), so it is no message; it is in the enumeration.

## Stage 2 — SAVED (FS131-T5): the design, written before the step's code

The step is `scripts/Assumptions.lean` (the list and the scan) with `scripts/assumptions.sh` (the gate, and `--self-test`),
`scripts/assumptions-controls.txt` (the planted faults), `scripts/assumptions-ledger.txt` (the consumers of each assumption, a
tracked file the gate compares exactly) and a third digest in `scripts/gate_report.py`. Nothing under `Proofs/` changes.

### (a) What counts as an assumption, and of which kind

An **assumption** is a proposition a theorem of the library rests on that the kernel did not check and that the theorem's
user is not expected to supply at their own instance: the reader is asked to take it from somewhere else. It has a **form** —
how it entered — and a **kind** — whose it is.

| form | how it enters | how the scan sees it |
|---|---|---|
| `axiom` | an `axiom` of the library | the axiom list the kernel stored with each theorem (`Lean.collectAxioms`) |
| `named` | a library definition whose type ends in `Prop` (a *former*), taken as a hypothesis | the theorem's type, as written |
| `inline` | a proposition written out in one binder of one theorem (a *site*) | the theorem's type, as written; named by theorem and binder |

| kind | what it is | its source must be |
|---|---|---|
| `outside` | a theorem of the literature, not formalized here | a `BIBLIOGRAPHY.md` key, `[Author2024]`, that the file defines |
| `ours` | a result of ours held at [hand], [tools] or [cert], not in the kernel | a ledger row (`row 123`), a grokking (`G56`) or a derivation entry id (`FS89-S0A-3`) that our records hold |
| `open` | an open question or a design target a theorem is conditional on | a ledger row, a grokking, a stub (`FS-124`) or an entry id naming where it is posed |

An axiom's kind is `outside` and its source is the key in its docstring, as `declareImport` already requires. A hypothesis
that is a **condition on the theorem's own parameters** — `0 < n`, `F.Valid`, `localBound F ≤ 5` — is not an assumption: its
user discharges it at their instance. No type separates the two (stage 1, reading 3); the design is what to demand where the
type cannot say.

### (b) Where each is declared

**One list**: the array `AssumptionAudit.declared` in `scripts/Assumptions.lean`, three kinds of entry, each name written with
a double backtick so that a mistyped name does not elaborate:

- `.former ``Full.Name kind "source"` — a named hypothesis;
- `.site ``Theorem `binder "Label" kind "source"` — an inline one, at one binder of one theorem; sites with one label are one
  assumption, and must agree on kind and source;
- `.condition ``Full.Name "reason"` — a library former that is taken as a hypothesis, concluded by no theorem, and is **not**
  an assumption: a condition on a theorem's parameters, with the reason, printed every run.

The scan checks each entry and prints a `FAIL` row rather than less: a former that is not a `Prop`-valued constant of the
library, a site whose theorem has no such binder, an empty source, a source whose first token is not of the form its kind
requires. `scripts/assumptions.sh` then resolves each source against the records — a bibliography key must be defined in
`BIBLIOGRAPHY.md` (`**[Key]**`, or an alias in § A′); a row must be a row of `LEDGER.md`; a grokking must be in the
grokkings file; an entry id must occur in `LEDGER.md`, `plans/LEAN-BACKLOG.md` or a `plans/*derivation*.md` — and fails on one
that does not (`unresolved-source`). Axioms are not declared a second time here: `declareImport` in `scripts/Axioms.lean`
stays their one list, and this scan reads every library axiom from the environment itself.

**The consumers' list** is `scripts/assumptions-ledger.txt`: one row per (assumption, theorem) — `RESTS <axiom> <theorem>`,
`TAKES <assumption> <theorem>`, `MENTIONS <assumption> <theorem>` — sorted, with the counts in its header. The gate compares
it with the scan **exactly**: a theorem the scan finds and the ledger lacks fails (`unlisted-consumer`), and so does a row
the scan no longer finds (`stale-consumer`). `./scripts/assumptions.sh --write-ledger` rewrites it from a run that has no
other failure and prints every row it added or removed. The reason for a tracked file: which theorems are conditional, and
on what, is then a reviewed line in a diff at every landing, never a number recomputed in passing.

### (c) How the scan finds what a statement takes — from the type the kernel holds

For every hand-written constant of the library (a module under `Proofs`; not a constructor, recursor, projection, matcher or
other generated declaration; a private theorem included) the scan telescopes its type **as written**, with no unfolding, and
reads each binder and the conclusion for occurrences of declared formers, with a polarity:

- in a binder whose type is a proposition `A`: an occurrence of `H` positive in `A` — at its head, under `∧`, `∨`, `∃`, or in
  the conclusion of an implication or a `∀` inside `A` — is **assumed** (`TAKES H T`); an occurrence in an antecedent inside
  `A`, or under `¬`, is not (the theorem assumes something `H` would help to prove, not `H`); an occurrence under `↔` or under
  any other head is of unknown polarity (`MENTIONS H T`);
- in a binder whose type is not a proposition, any occurrence is a mention (`{G // H G}`);
- in the conclusion the polarities are the other way round: a positive occurrence **produces** `H` (`PRODUCES H T cond|uncond`
  — a model, a partial discharge, or a derivation of one assumption from others), an antecedent inside the conclusion is
  assumed, `↔` is a mention.

No transitive closure over proofs is needed, and none is possible from a script (an imported theorem's proof term is not in
the environment, `scripts/Vacuity.lean`'s header): a hypothesis does not propagate silently. A theorem that uses a
conditional theorem must supply the hypothesis — from a hypothesis of its own, which is in its type; from a proof, which the
kernel checked; or from an axiom, which is in its axiom list.

**The one silent channel is a definition that wraps an assumption**: `def Inputs F : Prop := BochnerHerglotz … ∧ …`, a
structure with a field `(bh : BochnerHerglotz G)`, an `abbrev`. So the scan computes the **wrappers** — every library
definition whose body (a definition of a type or a proposition: its value under its own parameters) or whose constructors'
fields mention a declared former or another wrapper, to a fixed point — and reads an occurrence of a wrapper as an
occurrence of what it wraps (`TAKES H T via W`). Polarity inside a wrapper is not tracked: it is read as assumed.

### (d) A proposition written out in a binder, with no name

Two classes, and the type tells them apart.

**Closed** — the binder's type holds no free variable. This is decidable, and every one is classified (stage 1: 1,468 on
`main`, 37 outside the LRAT chains), as exactly one of:

- `DECLARED` — its head is a declared former (a named assumption at a closed instance), or the site is declared;
- `ESTABLISHED` — the library proves it: it is, expression for expression, the conclusion of a theorem all of whose binders
  are closed hypotheses that are themselves established (a least fixed point; the LRAT chain steps, each taking the
  watermark the step before it concludes, and `¬ (edgeGraph 1581 deGrey.edges).Colorable 4`);
- `REFUTED` — the one unclassified closed hypothesis of a theorem whose stated conclusion is `False`: the claim the theorem
  refutes. Two in one theorem fail: declare the ones that are assumptions.
- otherwise the gate **fails** (`undeclared-closed-hypothesis`), naming the theorem, the binder and the proposition.

**Parametric** — the binder's type mentions the theorem's variables (`hRow99 : localBound F ≤ 4 → localBound F ≤ χ(F²)`).
It is declared as a site when it is an assumption. Nothing in its type says whether it is one; (e) says what is done.

### (e) How the gate notices an assumption nobody declared

Like vacuity, this cannot be decided in general, so the check requires evidence, fails where the evidence is in the
environment, and counts and prints the rest.

**Fails unconditionally** (each a `FAIL <kind> <culprit>` row; none can be baselined):

1. `undeclared-closed-hypothesis` — (d). The assumption's own shape, decided exactly.
2. `undeclared-never-concluded` — a library former that some constant takes as a hypothesis and no constant concludes, in
   neither list. Either it is an assumption (`.former`) or it is a condition whose instances the library never proves as
   theorems (`.condition`, with the reason). On `main` this demands 45 dispositions (stage 1, reading 2).
3. `undeclared-by-docstring` — a library former, not declared an assumption, whose docstring uses the library's own words
   for one: "named hypothesis" (or "named classical hypothesis"), "outside the backlog", "external".
4. `kind-contradiction` — a declared kind its docstring contradicts: the docstring carries another kind's words and none of
   its own (`outside`: "external", "classical", a bracketed bibliography key; `ours`: "[hand", "[tools]", "[cert]", "outside the
   backlog"; `open`: "open question", "open problem", "design target"); or a `.condition` whose docstring uses the words of (3).
5. the list's own hygiene: `stale-declaration` (a declared former or site no constant takes), `discharged` (a declared former
   some theorem proves in general — a conclusion `H x₁ … xₙ` over its own variables with no hypothesis: it is no longer an
   assumption), `stale-condition` (a `.condition` that is now concluded, or taken by nothing), `bad-entry`, `no-source`,
   `bad-source`, `unresolved-source`, `label-conflict`, `declared-twice`, `axiom-no-source`;
6. the ledger: `unlisted-consumer`, `stale-consumer`;
7. the accounting: a scan that did not print its `TOTALS`, a declaration that could not be telescoped, counts that disagree
   with the rows.

**Counted and printed every run, never decided** — the `COUNTS` line and these rows:

- `CONDITION` — every `.condition`, with its reason;
- `SILENT` — a declared former whose docstring carries no kind word at all (the docstrings are not this job's to change:
  the drafts name each);
- `DERIVED` — an undeclared former, taken as a hypothesis, every one of whose producers itself takes a declared assumption
  (`Interface.MR`'s shape). **Pre-decided before the first run**: if on `main` this flags at most ten formers that by my
  reading are not assumptions, it becomes a failure (`undeclared-derived-only`) with `.condition` as its disposition; if
  more, it stays counted and printed. Whichever it is, the record says which and why.
- `COHYP` — every other hypothesis of a theorem that takes a declared assumption, in full: this is where an undeclared
  parametric one sits beside the declared (`hRow99` beside `hBH`), and a new row shows in the digest's diff;
- `HINT` — a theorem whose docstring uses the words of (3) and which takes nothing declared;
- `PRODUCES` — what the library proves of each assumption;
- **the class no check built here can see**, said in the step's own output every run with its count: a hand result or an
  outside theorem written out as a parametric hypothesis, in a theorem none of whose hypotheses is declared and whose
  docstring does not use the words. The count is of every parametric hypothesis outside the consumers (`unseen=`).

**Pre-decided, on someone else's number**: if the first run on `main` goes red on a class I did not foresee, the class is
read and either declared, or reported as a finding; no rule above is loosened to make `main` green. Where `main` cannot be
made green from this branch (a source `BIBLIOGRAPHY.md` lacks — Keryx's file), the red run is the receipt, and a second run
against a copy of the file with the drafted rows shows what remains.

### What each instrument sees that the others do not

The axiom audit sees form `axiom` on the records it is handed; this scan sees it on every theorem of the library, and sees
the two hypothesis forms, which print the standard three. The vacuity scan asks whether a hypothesis *can* hold; this one
asks whose word it is taken on. A theorem can pass all three and still be conditional on a parametric hypothesis nobody
declared: that is the unseen class, counted above.

### The controls (`--self-test`)

One elaboration of a copy of `scripts/Assumptions.lean` with every planted declaration and entry spliced in, judged by the
gate's own `check_receipt` — the scan must print rows, never throw, for a faulty entry, so that all the plants live in one
run. Planted names start `t5c_`; planted files and the control ledger are built under `data/fs131/t5/`-style scratch, never
under `Proofs/`. Every control has its silent partner, and every `FAIL` row of the control run must be one some control
predicts (two-sided). The controls plant their own axiom, formers and consumers, so none depends on what `main` assumes
today (the axiom audit's `baseline` control does, inventory item 259).

## Stage 3 — SAVED (FS131-T5): the step, built; what the first runs on `main` changed in the design

**Files.** `scripts/Assumptions.lean` (the list and the scan), `scripts/assumptions.sh` (the gate, `--self-test`,
`--write-ledger`), `scripts/assumptions-controls.txt` (21 controls), `scripts/assumptions-ledger.txt` (90 rows),
`scripts/gate_report.py` (a third digest, `assumptions`), `tools/fs131_t5_mutate.py` (the mutation harness),
`tools/fs131_t5_readback.py`. One scan is about 70 s and under 16 GiB (`scripts/slot.py --mem 16 --cpus 4 --
./scripts/assumptions.sh`); the self-test is one scan.

**Four things the runs changed, each decided on its reason and recorded here because stage 2 said nothing would be
loosened to make `main` green:**

1. **A refuted occurrence is neither taken nor produced** (`Pol.ref`). The first run with an empty list
   (`data/fs131/t5/runs/first-empty-list.out`) counted `theorem not_rationalDescent : ¬ RationalDescent` as taking
   `RationalDescent`. A conclusion `¬ H` proves `H` fails; it is printed as `REFUTES H T` for a declared `H` and
   counts toward no tally.
2. **A fourth entry, `.premise`**, for a closed hypothesis that is not an assumption. `deGrey_bound_of_not_colorable`
   takes `¬ (edgeGraph 1581 deGrey.edges).Colorable 4`, which **no theorem of the library states**: the library proves
   it for the same graph in its rotated presentation (`deGreyRot_not_colorable_four`) and concludes `χ(ℝ²) ≥ 5` there.
   The closed-hypothesis rule found it; it is a hand-off lemma kept for exposition, and nothing consumes it. And
   `voronov11_of_forall_mu_lt (H : ∀ ε > 0, mu 6 ε < 1) : Voronov11` is half of FS106-COMP's equivalence. Each is
   declared with its reason and printed every run (`CLOSED PREMISE`).
3. **A bibliography key in a docstring is a source, not a kind.** As first written, the kind check read a
   bracketed key as speaking for `outside`, and failed `Interface.MulStable` — declared `ours` from the landing's
   table (J45 § 4.2 step 2), with a docstring that says "rests on J28V-7 (…; `[LevitzMott1972]`)". A hand result of
   ours resting on a cited paper is the ordinary case (`Interface.PE2`, "over EL2021 Thm 1.2", unbracketed, passed), so
   the key now supports a declared `outside` and contradicts nothing; `MulStable` reads `SILENT`. Changed before any
   control was written; control `kind` plants both sides (`t5c_KC` fails, `t5c_CT` is silent).
4. **`DERIVED` fails** (`undeclared-derived-only`), by the rule pre-decided in stage 2: on `main` it flagged one
   former that is not an assumption (`SpectralInputs.IsHaarFourier`, whose one existence theorem takes
   Herglotz–Bochner), which is at most ten. It is declared a `.condition`. With `Interface.MR` left out of the list
   the same rule names it (its one producer, `mr_of_pe2_efPlus`, takes PE-2 and EF_F⁺).

Also: theorems Lean states under a constructor's name (`S.mk.inj`, `.injEq`, `.sizeOf_spec`) are generated and not
read — the self-test's own structure `t5c_Pack` showed them as three consumers of a field's type.

## Stage 4 — SAVED (FS131-T5): make it fail, and watch it fail

**`./scripts/assumptions.sh --self-test`: OK, 32 checks** at the stage's first green run
(`data/fs131/t5/runs/selftest-2.out`; the planted copy, its ledger and its output are `data/fs131/t5/planted/`; the last
run's receipt is `data/fs131/t5/receipts/assumptions-self-test.log`). All plants live in one copy of the audit,
elaborated once beside the shipped list; planted names start `t5c_`; nothing is planted under `Proofs/`.

| control | the fault, seen red | its silent partner |
|---|---|---|
| `closed_undeclared` (**the load-bearing one**) | a hypothesis nobody declared, written out in a binder, closed: `undeclared-closed-hypothesis` | `closed_site` — the same proposition in the same place, declared; `closed_established` |
| `parametric_unseen` | — (the class the check cannot see: the same hypothesis over the theorem's variable reads clean, and no row names it) | — |
| `closed_established` / `closed_unestablished` | a closed hypothesis whose only proof is conditional, or rests on a closed step whose own hypothesis is unproved | one proved directly, and one proved through a chain of closed steps |
| `closed_refuted` | two closed hypotheses in one refutation | the one hypothesis of a refutation (`CLOSED REFUTED`) |
| `closed_premise` | a premise with no reason (`no-reason`) | a premise with its reason (`CLOSED PREMISE`) |
| `never_concluded` | a former taken and never concluded, in neither list | `concluded` — one a theorem concludes; `condition` — one declared a condition |
| `condition` | a condition entry that is not needed (`stale-condition`) | a needed one, printed with its reason |
| `by_docstring` | a former whose docstring says "a named hypothesis from outside the backlog", undeclared | the same docstring, declared |
| `stale_declaration` | **a declared hypothesis no theorem takes** | `named_declared` |
| `sources` | **no source**; **a source that is no key, row or id**; a source its kind does not admit; a key, a row and an entry id that are not in the records (`unresolved-source`) | a bibliography key, a ledger row, a grokking, a stub and an entry id that resolve |
| `ledger` | **a theorem that takes a declared hypothesis and is missing from its list** (`unlisted-consumer`); a listed one the scan does not find | `named_declared` |
| `shapes` | a wrapper taken at a closed binder (twice: the closed rule and `undeclared-never-concluded`) | under `∧`, in an implication's conclusion, `[Fact H]`, an arrow in the conclusion, under `∃`, through a wrapper definition and a structure's field — each found; an antecedent and a `¬` — neither read as taking |
| `kind` | **a declared kind its docstring contradicts**; a condition whose docstring calls it a hypothesis | a docstring that says nothing (`SILENT`); a cited key (`SILENT`, no contradiction) |
| `discharged` | a declared hypothesis a theorem proves in general | one proved at an instance (`PRODUCES … uncond`) |
| `derived_only` | an undeclared former every proof of which takes a declared assumption | `concluded` |
| `axioms` | an axiom's consumer missing from the ledger; an axiom with no source; an axiom whose key is not in the bibliography | an axiom with its source and its listed consumer |
| `bad_entries` | an entry naming a theorem; a site with no such binder; a name declared twice; one label with two sources | — |
| two-sided | every `FAIL` row naming a planted name is one a control predicts (the first run failed this: stage 3's last line) | |
| accounting | the `TOTALS` line dropped; one `TAKES` row dropped; an untelescoped declaration; a missing ledger | the unmutated run |
| digest | recorded counts stale in `CLAUDE.md`; partial (exit 3); doubled (exit 3); stale in the ledger's header | counts that match; counts absent, flagged with the sentence to add |

**The controls are independent of what `main` assumes**: they plant their own axiom, formers, consumers and records,
and a failure naming no planted name is the shipped list's own, counted and left to the gate (93 before the ledger
existed; 3 since).

**The mutation harness** (`tools/fs131_t5_mutate.py`, output `data/fs131/t5/runs/mutations.out`): eighteen mutations,
each switching off one decision of the scan or of the shell, on a copy (no shipped file is edited; the harness
checks the two shipped files' digests at the end). Each must make the self-test fail **and name the control built for
it**. Its result is in stage 6. The run is about twenty-five minutes; one mutation is rerun with `--only <name>`.

## Stage 5 — SAVED (FS131-T5): `main` declared

**The gate on `main`'s tree as it stands is RED, by exactly three failures, each a bibliography row `main` lacks**
(`data/fs131/t5/receipts/assumptions-main-as-shipped.log`; `data/fs131/t5/runs/gate-main-as-shipped.out`):

    FAIL unresolved-source HadwigerNelson.SpectralChain.BochnerHerglotz :: its source bib:Rudin1962 is not in the records
    FAIL unresolved-source HadwigerNelson.SpectralChain.InvariantMeasureOnClosed :: its source bib:Kakutani1938 is not in the records
    FAIL unresolved-source HadwigerNelson.SpectralInputs.BochnerOn :: its source bib:Rudin1962 is not in the records

Three hypotheses standing for outside theorems cite works with no entry in `BIBLIOGRAPHY.md` — one of them
(`InvariantMeasureOnClosed`) cites no work at all in its docstring. `BIBLIOGRAPHY.md` is Keryx's file; the two rows are
drafted below. **Against a copy of the file with those rows, and a copy of `CLAUDE.md` with the drafted sentence, the
gate is GREEN** (`data/fs131/t5/receipts/assumptions-main-with-drafts.log`, `data/fs131/t5/runs/gate-main-with-drafts.out`;
the copies are `data/fs131/t5/drafts/`), and the run says on its first lines which files it read:

    ==> assumptions: OK — 1 outside theorem(s) as axioms, with 4 theorem(s) resting on them; 18 named and 15 inline
        hypotheses (5 outside, 24 ours, 4 open), taken by 85 statement(s) and mentioned by 1

`=== SCANNED === constants=13151 theorems=9613 formers=275 hypotheses=15948 closed=1468 untelescoped=0`;
`=== TOTALS === axioms=1 rests=4 named=18 inline=15 outside=5 ours=24 open=4 takes=85 mentions=1 produces=3 sites=26
conditions=31 declaredClosed=30 established=1433 premises=2 refuted=3 refutes=0 silent=11 derived=1 wrappers=0 cohyp=34
hints=3 unseen=14112 fails=0`.

### What `main` assumes, at `3bfc7d2e` — by kind, by name, with the count of statements on each

**Outside theorems (six: one axiom, five hypotheses).**

| assumption | form | source | statements |
|---|---|---|---|
| `Plane.falconer_lemma2_nonempty` | axiom | `[Falconer1981]` Lemma 2 (i) | 4 rest on it |
| `SpectralChain.BochnerHerglotz` | named | `[Rudin1962]` 1.4.3, 1.3.6 — **no bibliography row** | 12 |
| `SpectralChain.InvariantMeasureOnClosed` | named | `[Kakutani1938]` (Markov–Kakutani) — **no bibliography row; the docstring cites no work** | 7 |
| `Bridge.RealAlgebraicDescent` | named | `[Lang1953]` (Artin–Lang; Tarski) | 6 |
| `SpectralInputs.BochnerOn` | named | `[Rudin1962]` 1.4.3 — **no bibliography row** | 1 |
| `Plane.Voronov11` | named | `[Voronov2023]` Thm 1.1 | 1 takes it (`mu_lt_of_voronov11`), 1 mentions it under `↔` |

**Hand results of ours (twenty-four: thirteen named, eleven written out in a binder).**

| assumption | form | source | statements |
|---|---|---|---|
| `SpectralChain.Interface.RU` | named | J45 § 5.4 | 6 |
| `SpectralChain.Interface.PE2` | named | X02D, over `[EinsiedlerLindenstrauss2022]` Thm 1.2 | 6 |
| `SpectralChain.Interface.EFPlus` | named | FS100-X01D | 6 |
| `SpectralChain.Interface.APlus0` | named | J45 § 3 (row 113) | 3 |
| `SpectralChain.Interface.APlusOfR88` | named | J45 | 3 |
| `SpectralChain.Interface.Count` | named | X23D-TCA | 3 |
| `StandingFive.StandingFloor` | named | G56 | 3 |
| `CharacterColouring.OrderBound` | named | FS89-S0A-3 | 2 |
| `SpectralChain.Interface.MR` | named | row 120 (measure rigidity, Fourier form) | 1 |
| `SpectralChain.Interface.MulStable` | named | J45 § 4.2 step 2 | 1 |
| `SpectralChain.Interface.NegCircle` | named | J45 § 4.2 step 3 | 1 |
| `Plane.Row130M1` | named | row 130 | 1 |
| `SevenConditional.G4` | named | row 103 (a solver refusal with no proof log) | 1 |
| `inline:Row99` (`hRow99`) | inline | row 99 | 3 |
| `inline:CLS` (`hCLS`) | inline | X23D-CLS | 3 |
| `inline:UpperHalf` (`hUpper`) | inline | row 52 | 1 |
| `inline:Row123Chain` (`hRow123`) | inline | row 123 | 1 |
| `inline:RQ4`, `inline:RQ5` (`cl2`) | inline | FS89-D2-T1, FS89-D5-T2 | 1 each |
| `inline:Alpha23`, `inline:Alpha83`, `inline:Alpha11` | inline | rows 71, 68, 68 (certificates outside the kernel) | 1 each |
| `inline:Row78`, `inline:Row88` (`falconerFan_five_mem_eight`, `_mem_P`) | inline | rows 78, 88 | 1 each |

**Open questions and design targets (four, all written out in a binder).** `inline:SixTarget` (row 43; 2 statements),
`inline:SevenTarget` (row 61; 2), `inline:SixTargetOneTwo` (row 61; 1), `inline:FragmentsAtEveryRadius` (row 145; 1).

**In all**: 33 hypotheses taken in 85 (assumption, statement) pairs by **40 distinct statements**, and 4 theorems on the
axiom; the ledger lists each pair. **Not assumptions, declared with reasons and printed every run**: 31 conditions
(formers taken as hypotheses and never concluded, or concluded only from an assumption) and 2 premises.

**What the step counts but cannot decide, on `main`**: `cohyp=34` (the other hypotheses of the 40 consumers, each
printed; by my reading all 34 are conditions on the theorem's parameters — `hL : localBound F ≤ 5`, `hfan`, `hσ`);
`hints=3` (`flankQ_lower`, `flankQ_upper`, `flankQ_upper_of_qrOnly`, whose docstrings say "named hypothesis" of an `hQR`
that wave 5 has since proved: the wording is stale, a docstring draft below); `silent=11` (declared formers whose
docstrings say nothing of whose they are); and **`unseen=14112`: every other parametric hypothesis of the library,
among which a hand result written out in a binder, in a theorem that declares nothing and says nothing, would not be
told from a condition.** That class is real on `main` — `hRow99`, `hCLS`, `hUpper`, `hR78`, `hR88` were found by reading
`SpectralChain.lean` and `Arith/FalconerField.lean`'s docstrings, not by the scan; they are declared now, and the scan
holds them (`stale-declaration`, the ledger).

**Against the records** (the brief's "a docstring and a record that disagree, or an assumption no record names"):
every assumption above is named by some record of ours — a docstring, a ledger row, the landing's table or plan § 7.4.
Three differences, none urgent, each held for the coordinator in the report:
(i) `Plane.Voronov11`: its docstring says "Named here, not imported (FS106-COMP's clause is an equivalence, not a use)";
inventory item 548 (2) counts it among the outside theorems assumed, with one consumer. Declared `outside`, with that
consumer; (ii) plan § 7.4's `Row134Base` and `Row130Collapse` are taken by no statement on `main` (item 548 already
says so of the first) — nothing to declare; (iii) the landing's table has `Interface.MulStable` as ours and its
docstring cites `[LevitzMott1972]`: declared `ours`, stage 3 item 3.

## What is on its way — how each landing meets the step

- **A wave that brings a named hypothesis** (`WEqKLimit`, `ReduceToMap`, `MapNO`, `GammaFreeEmptyNS`,
  `QArcsJoinOpposite`): if it is taken at a closed instance, concluded by no theorem, concluded only from assumptions,
  or its docstring uses the words, the step fails and names it (`undeclared-closed-hypothesis`,
  `undeclared-never-concluded`, `undeclared-derived-only`, `undeclared-by-docstring`) until the wave adds one `.former`
  line; then every consumer fails as `unlisted-consumer` until `--write-ledger` is run and its added rows are read.
  **What the step will not catch**: one of these written out in a binder over the theorem's variables, with a docstring
  that does not say so — the wave declares it as a `.site`, on its own word.
- **`KloostermanBound` becoming an axiom** (Weil's bound): while a hypothesis it is a `.former … .outside "[Weil1948] …"`
  (the key is in `BIBLIOGRAPHY.md`); when the axiom replaces it the entry leaves (else `bad-entry`: an axiom is not a
  former), `declareImport` gains its line in `scripts/Axioms.lean`, and this scan prints `AXIOM … ref=bib:Weil1948` with
  a `RESTS` row for every theorem of the library whose stored axiom list holds it — all of them, not only the records
  the audit is handed — each of which must be in the ledger.
- **The job removing `falconer_lemma2_nonempty`**: its four `RESTS` rows go stale (`stale-consumer`) and
  `--write-ledger` drops them; `axioms=1 rests=4` become `0 0`, in the ledger's header and in `CLAUDE.md`'s sentence.
  **This step's controls do not move**: they plant their own axioms. **The axiom audit's do**:
  `scripts/axioms-controls.txt`'s `baseline` and `imported_declared` expect `imported=4 declared=1 library=1` and
  `5 / 2 / 2`, and `banner_dropped` expects two consequences of one declared import, all read from `main`'s state
  (its header says so; inventory item 259's tool defect, owed). With no import declared those expectations must read
  `0 / 0 / 0` and `1 / 1 / 1`, and with Weil's axiom in the same landing they may not move at all; the landing that
  empties the list edits those three controls, or the audit's self-test is red for a reason that is not a fault. The
  repair that ends it is the one used here: a control that plants what it counts.
- **When an assumption is proved**: a theorem concluding a declared former over its own variables with no hypothesis
  fails the step as `discharged` until the entry leaves; its consumers then fail as `stale-consumer`, and the theorems
  that still take the hypothesis in their statements are restated or left, on the landing's reading.
- **A join of two lines** runs the step on the joined tree, like the doubled-name check: each line's ledger rows are
  kept (both sides), and `--write-ledger` on the joined tree settles the header.

## Drafts for the front page

Each names its slot. Counts are `main`'s at `3bfc7d2e` with this branch's list; a landing that merges other waves first
reads its own from `build/gate/assumptions/latest` on the merged tree.

**1. `CLAUDE.md` § Trust ledger** — a new paragraph, after the paragraph that ends "Rung B holds none." and before
"What the audit accepts and what it buys". `scripts/gate_report.py` reads the nine `key=value` counts from this section,
each exactly once (the full file with it is `data/fs131/t5/drafts/CLAUDE-with-sentence.md`):

> **What the library assumes, in both forms** (`scripts/assumptions.sh`, whose digest reads these counts):
> `axioms=1 rests=4 named=18 inline=15 outside=5 ours=24 open=4 takes=85 mentions=1` — one outside theorem declared as an
> axiom, with four theorems resting on it; thirty-three hypotheses, eighteen named and fifteen written out in a binder,
> five of them outside theorems, twenty-four hand results of ours and four open questions, taken by 85 statements
> (`scripts/assumptions-ledger.txt` lists each; FS131-T5, 2026-10-06).

Until it is filed the digest prints "RECORDED COUNTS ABSENT in CLAUDE.md § Trust ledger" with the counts to add, and
does not fail; a partial or doubled record fails (exit 3).

**2. `BIBLIOGRAPHY.md`** — two rows, without which the gate is red on `main` (stage 5). Drafted in full in
`data/fs131/t5/drafts/BIBLIOGRAPHY-with-rows.md` (above `[Voronov2023]`'s row; the filer places them): `**[Rudin1962]**`,
W. Rudin, *Fourier Analysis on Groups*, Interscience (1962) — Thm 1.4.3 and Thm 1.3.6, what `BochnerHerglotz` and
`BochnerOn` state; not held, cited from memory in the docstrings, read-back owed. `**[Kakutani1938]**`, S. Kakutani,
*Two fixed-point theorems concerning bicompact convex sets*, Proc. Imp. Acad. Tokyo 14 (1938) 242–245 — the
Markov–Kakutani theorem `InvariantMeasureOnClosed`'s docstring names; **the bibliographic data are recalled, not read**;
not held. If the filer keys either work differently, the two or one `.former` lines of `scripts/Assumptions.lean` take
the filed key.

**3. `LEAN.md` § The gate** — in the first sentence, after "`./scripts/axioms.sh --self-test` green (23 planted faults, …)":
"`./scripts/assumptions.sh` and `./scripts/assumptions.sh --self-test` green (21 controls planted in one copy of the
audit, 32 checks),". And a bullet after the `dupnames` bullet:

> - **`./scripts/assumptions.sh` and `./scripts/assumptions.sh --self-test` are green** — everything a theorem rests on
>   that the kernel did not check is listed, in both forms it takes. An outside theorem declared as an `axiom` shows in
>   `#print axioms`; a hypothesis does not — a theorem that says "if Herglotz–Bochner holds, then …" prints the standard
>   three — so `scripts/Assumptions.lean` reads every hand-written statement as the kernel holds it and prints every
>   library axiom with the theorems whose stored axiom lists hold it (`RESTS`), and every declared hypothesis with its
>   kind (`outside`, `ours`, `open`), its source and the statements that take it (`TAKES`, `MENTIONS`). Whether a
>   hypothesis is an assumption or a condition on the theorem's parameters is intent, which no type records, so the
>   check **requires evidence**: the one list is `AssumptionAudit.declared`. **It fails** on a *closed* hypothesis (no
>   free variable: a statement about the world) that is neither declared, nor proved by the library, nor the one claim
>   a refutation refutes; on a `Prop`-former taken as a hypothesis that no theorem concludes, or that is concluded only
>   from declared assumptions, or whose docstring uses the words "named hypothesis", "outside the backlog" or "external",
>   when neither list holds it; on a source that is not in `BIBLIOGRAPHY.md`, `LEDGER.md`, the grokkings, the stubs or
>   the derivations; on a declared kind its docstring contradicts; on a declared hypothesis no statement takes, or one a
>   theorem proves in general; and on any consumer that `scripts/assumptions-ledger.txt` does not list, or lists and the
>   scan does not find. **It counts and prints, and cannot decide**: the other hypotheses of every consumer (`COHYP`),
>   and `unseen=` — every other hypothesis over a theorem's own variables, among which a hand result written out in a
>   binder, undeclared and unremarked in its docstring, is not told from a condition. The nine counts are recorded in
>   `CLAUDE.md` § Trust ledger and in the ledger's header, where `scripts/gate_report.py` reads them.

**4. `LEAN.md` § Assumptions: outside theorems and our own** — the third bullet ("Our own hand results … so they disappear
when discharged.") gains, and a fourth bullet follows it:

> - **Our own hand results** that a module needs before their own module lands enter as explicit hypotheses of the
>   theorems that use them, never as axioms, so they disappear when discharged. **So may an outside theorem** (five do on
>   `main`), when its statement is better carried as a named `Prop` than as an axiom.
> - **Every assumption in hypothesis form is declared to the gate**, in `AssumptionAudit.declared` at the end of
>   `scripts/Assumptions.lean`, by the landing that brings it: a named one by `.former ``Full.Name kind "source"`; one
>   written out in a binder by `.site ``Theorem `binder "Label" kind "source"`, once per theorem that takes it; a former
>   that is only a condition on a theorem's parameters by `.condition ``Full.Name "reason"`; a closed premise that is not
>   an assumption by `.premise ``Theorem `binder "reason"`. The kind is `outside` (source: a `BIBLIOGRAPHY.md` key in
>   brackets), `ours` (a ledger row `row N`, a grokking `G N`, or a derivation entry id) or `open` (those, or a stub
>   `FS-N`); the source opens with that reference. The definition's docstring says whose it is in the words the gate
>   reads — "external" or "classical" or its bracketed key; "[hand]", "[tools]", "[cert]" or "outside the backlog"; "open
>   question" — or it is counted `SILENT`. Then `./scripts/assumptions.sh --self-test`, `./scripts/assumptions.sh`,
>   `./scripts/assumptions.sh --write-ledger` (read the rows it adds: each is a statement that is now conditional), and
>   the counts for `CLAUDE.md`. A hand result written out in a binder over the theorem's own variables is the one thing
>   the gate cannot find by itself: the landing declares it on its own word.

**5. `LEAN.md` § Trust ledger**, the table — a fifth row: "| a hypothesis standing for an outside theorem, a hand result of
ours or an open question | **declared**, with its kind and source, by one line of `AssumptionAudit.declared` in
`scripts/Assumptions.lean`; every statement that takes it listed in `scripts/assumptions-ledger.txt` |".

**6. `ARCHITECTURE.md` § 5 Trust** — a subsection after "Imported outside theorems", "### Assumed as hypotheses
(`scripts/assumptions.sh`; declared in `scripts/Assumptions.lean`)", holding stage 5's three tables (outside, ours,
open) as they stand there, with the sentence: "None is an `axiom`: each is a `Prop` argument visible in the statement of
every theorem that takes it, and `scripts/assumptions-ledger.txt` lists those statements. The gate fails on one that is
closed, never concluded, concluded only from another, or named as one in its docstring, and is not in the list."

**7. The line every landing brief carries from now on:**

> A wave that brings an assumption in hypothesis form — a named `Prop` standing for an outside theorem, a hand result
> of ours or an open question, or one written out in a binder — declares it in `AssumptionAudit.declared`
> (`scripts/Assumptions.lean`; the procedure is `LEAN.md` § Assumptions), or `./scripts/assumptions.sh` fails; the landing
> runs `./scripts/assumptions.sh --self-test`, `./scripts/assumptions.sh` and `--write-ledger` on the merged tree, reads
> every ledger row it gains, and drafts the nine counts for `CLAUDE.md` § Trust ledger.

**8. Docstrings under `Proofs/`, for a landing to make** (none is this job's to change; each rebuilds its module's
dependents). (a) The eleven `SILENT` formers say whose they are: `Bridge.RealAlgebraicDescent` — add "external" or the key
`[Lang1953]`; `Interface.{RU, APlus0, APlusOfR88, PE2, EFPlus, MR, MulStable, NegCircle}` and `CharacterColouring.OrderBound`
— add the grade, "[hand]"; `SevenConditional.G4` — "[tools]". (b) `SpectralChain.BochnerHerglotz`, `SpectralInputs.BochnerOn`:
the key in brackets, `[Rudin1962]`. (c) `SpectralChain.InvariantMeasureOnClosed`: name the work, `[Kakutani1938]` or the
filer's key. (d) `Plane.Voronov11`: "Named here, not imported (FS106-COMP's clause is an equivalence, not a use)" beside
`mu_lt_of_voronov11`, which takes it as a hypothesis — say which reading stands (the list has it `outside`, one
consumer). (e) `Plane.ArcMap.flankQ_upper`, `flankQ_lower`, `flankQ_upper_of_qrOnly`: "a named hypothesis" of `hQR`, which
wave 5 proved (`flankQ_upper_of_qrOnly`); reword, and the three `HINT` rows leave.
