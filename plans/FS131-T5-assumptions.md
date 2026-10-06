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
