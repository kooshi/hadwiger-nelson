# The Lean facts of this repository

*Read in full by both de Bruijn lanes at launch (the planner, `.claude/agents/debruijn.md`; the implementer,
`.claude/agents/debruijn-implementer.md`). Current state only: each rule's incident and its date are in git history and in
`plans/HISTORY-WORKFLOW-3.0.md`. Keryx is this file's writer; a lane drafts a change in its record.*

## The shape of the proof

The lower bound's whole argument is one reduction plus two certified computations:

```
χ(ℝ²) ≥ 5  ⟸  some finite unit-distance graph is not 4-colourable
                 ├── geometry:  every listed edge really has length 1   (exact field arithmetic)
                 └── combinatorics: the graph has no 4-colouring        (verified LRAT checker)
```

Neither computation is trusted on its own say-so. The geometry is exact: coordinates live in ℚ(√3,√5,√7,√11), represented as an
iterated quadratic extension over ℤ, so "distance = 1" is an integer identity, not a float comparison. The combinatorics goes through
a kernel-reducible LRAT checker built here (core's `Std.Tactic.BVDecide.LRAT.check` + `check_sound` cannot be kernel-evaluated:
among other causes, `Std.HashMap` reaches an `@[extern] opaque` word size). CaDiCaL is an untrusted oracle that merely proposes the
certificate. **Nothing in `tools/` is trusted**: a generator bug can only produce data Lean refuses to certify.

## Assumptions: outside theorems and our own

- **A milestone may assume the literature** (Kooshi, 2026-10-03). A published theorem whose formalization would take more than about
  an hour of agent work may enter as an `axiom`; anything less is formalized here, and when unsure, formalize. A separate planner and
  implementer may be launched to formalize an outside theorem.
- **An imported theorem carries four things**, because an axiom that misstates its paper can be inconsistent, and then every theorem
  built on it is provable, false ones included, and the kernel cannot see it:
  1. its docstring names its `BIBLIOGRAPHY.md` key, the section and the page;
  2. its Lean statement is read back against the paper's own wording, in the planner's record. State the axiom in the paper's own
     form and derive the form the library uses: the translation is then kernel-checked and the read-back is symbol against symbol
     (`StandingFive.kloosterman_bound`, with `kloostermanBound_of_ringChar_ne_two` and `kloosterman_page_of_kloostermanBound`) Where the source is itself Lean, copy its definitions, state the axiom over the copies, and compare the stored terms across the two pins — every constant, instance, binder and universe level — with a control that fires (`Outside.OAI158`; `tools/fs132_i1_readback.py`, on a print made at each pin by one dumper); the landing runs it again on the module as recompiled on the joined tree. Before blaming the pin for a stored statement that differs from its source's, ask whether each constant the source names exists at this pin under `import Mathlib` — not under the module's own imports — and, for each that does, add the Mathlib module that declares it and compare again: which instance a statement stores is chosen by the import list as well as by the pin (`Outside/OAI158Rigidity`: two import lines took the difference from 24 constants against 4 to 4 against 2); then rebuild the source's stored statement at this pin from its print and let the kernel check it equal to the declared one, so that what is left to trust is only that a Mathlib constant of one name means one thing at the two pins (`data/fs133/ia1/rebuild/Rebuild.lean`, `tools/fs133_ia1_rebuild.py`, FS133-IA1). A copy carries the source's licence in its module docstring, with the text beside it (`Outside/OAI158`, since FS124-L1).;
  3. one model of its hypotheses — a `theorem` or `example` in the same file exhibiting an object that satisfies them;
  4. a line in `ARCHITECTURE.md` § Trust, as a declared purchase.
- **An outside Lean proof may be ported instead of imported** (`Outside/OAI158Palette`, `OAI158CircleMaps` … `OAI158States`; FS132-K1, FS132-I2, landed by FS132-L2): compute the cone of the wanted statements from the source's own compiled constants at its pin, copy those declarations by line range with a generator that refuses a patch to a statement or a definition (`tools/fs132_i2_port.py`), and build. The kernel then checks every proof here and no axiom enters. A read-back across pins (`tools/fs132_i2_readback.py`) is an instrument for "this is the source's lemma", never a gate on truth, and it cannot read "term for term": the same text elaborates against another Mathlib. It reports IDENTICAL, or identical up to instance and proof arguments with the differing constants recorded, under an explicit map of Mathlib's renames between the pins; what it leaves to trust is that Mathlib's instances for one class on one type agree at each pin. The landing runs it again on the joined tree. **A port carries the source's licence**: a byte-identical copy of its text beside the modules, written and compared by the generator, each header the notice of change. **An instance the source declares on a type that is Mathlib's is scoped here**, through the generator (the keyword; an instance declared in a child namespace needs `attribute [scoped instance]` in the parent, where its uses stand) — scoping changes no stored term, so the read-back prints the same bytes.
- **A port of the release's whole proof** (`Outside/OAI158Basic` … `OAI158BorelTransfer`, FS131-KO1 to FS131-LP1) copies whole files: a cone computed from the source's compiled constants misses what a proof uses only definitionally (an `rfl` lemma a `simp` rewrites with leaves no constant in the term), so where the cone's files import nothing outside it the files are copied whole and the cone checks that nothing it names is missed. Its tables name, each entry with its reason and its mechanical check in the read-back: **renames** and **proof patches** (never in a statement or a definition); **adaptations** — a release-internal statement or definition whose Mathlib API changed between the pins (`Measure.map`, `ProbabilityMeasure.map` between v4.32.0 and v4.34.1) rewritten to name the same object by inserting a closed measurability argument, never a hypothesis or a binder, or in a definition's value the release's own instance named with the `Prop` it asks proved explicitly (`CommutingSpectral.algebra_commRing`); flagged ADAPTED, checked to differ from the source's print only by the inserted argument; **ruled statement changes** — exactly the release's own section variables as binders where the statement as written is false at this pin (`DifferenceFourier.differenceLaw_probability`), and **the cascade** of that change to every declaration whose type names the changed definition (`CosetCenter.Embedding.frequencyLaw`, `center`; a dropped `omit … in` listed), each checked by stripping exactly those binders; **`nolint`** — an environment linter silenced on one declaration, by name, in the file, with its reason class (the release's name, the release's binder, or simp's normal form of the release's lemma; `@[nolint …]` merged into an existing attribute block where there is one). Every class is refused on the target statements, on a declaration another branch holds a copy of, and on anything a statement of ours names. **Pin differences** — a Mathlib definition whose stored form changed between the pins without changing what it names (`Monoid`'s parents, `Finset.HasAntidiagonal`'s class parameter, `eLpNorm`/`MemLp`/`Lp`, `Algebra.algebraMap`'s instance path, `Polynomial.coeff`'s type, `Filter.EventuallyEqSet`) — are patched nowhere: the read-back (`tools/fs131_ipa1_readback_port.py`) has a named rule for each with planted controls (PIN-DIFFERENCE, CLASS_PARAMS, COEFF, EQSET), and a release-own constant in an instance argument is accepted only with a kernel check at this pin that the two instance terms agree by `rfl`, its non-agreeing plant refused (INSTANCE_EVIDENCE, `generator_unitary`); a target may read up to Mathlib's instances only with its stored type IDENTICAL to the axiom it replaces (TARGET_IN_LIBRARY, `Spectral.residual_fourier`) (FS131-KO1, FS131-IPA1, FS131-IPB1, FS131-IPD1, FS131-LP1).
- **Our own hand results** that a module needs before their own module lands enter as explicit hypotheses of the
  theorems that use them, never as axioms, so they disappear when discharged. **So may an outside theorem** (five do on
  `main`, in seven entries: Herglotz–Bochner in two forms, Markov–Kakutani, Artin–Lang, Voronov's Thm 1.1, and Weil's
  bound in the hypothesis forms its modules were proved over), when its statement is better carried as a named `Prop`
  than as an axiom.
- **Every assumption in hypothesis form is declared to the gate**, in `AssumptionAudit.declared` at the end of
  `scripts/Assumptions.lean`, by the landing that brings it: a named one by `.former ``Full.Name kind "source"`; one
  written out in a binder by `.site ``Theorem `binder "Label" kind "source"`, once per theorem that takes it (sites
  with one label carry one source, character for character); a former that is only a condition on a theorem's
  parameters by `.condition ``Full.Name "reason"`; a closed premise that is not an assumption by `.premise ``Theorem
  `binder "reason"`. The kind is `outside` (source: a `BIBLIOGRAPHY.md` key in brackets), `ours` (a ledger row `row N`,
  a grokking `G N`, or a derivation entry id) or `open` (those, or a stub `FS-N`); the source opens with that
  reference. The definition's docstring says whose it is in the words the gate reads — "external" or "classical" or
  its bracketed key; "[hand]", "[tools]", "[cert]" or "outside the backlog"; "open question" — or it is counted
  `SILENT`; and a former that is **not** assumed must not use the words "named hypothesis", "outside the backlog" or
  "external" in its docstring. Then `./scripts/assumptions.sh --self-test`, `./scripts/assumptions.sh`,
  `./scripts/assumptions.sh --write-ledger` (read the rows it adds: each is a statement that is now conditional), and
  the nine counts for `CLAUDE.md` § Trust ledger, which the step reads as stale — flagged, not failed — until they are
  refiled. A hand result written out in a binder over the theorem's own variables is the one thing the gate cannot find
  by itself: the landing declares it on its own word.
- **At publication** the cost of landing every assumption on the standard three axioms is measured first; Kooshi prefers the three
  axioms if it is about a week of agent work or less.

## Trust ledger

The audit's counts are recorded in `CLAUDE.md` § Trust ledger, where `scripts/gate_report.py` reads them. So are the assumptions step's nine. What it accepts:

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **explicit purchase, per use**, named in its declaration's docstring and listed in `ARCHITECTURE.md` § Trust |
| an `axiom` importing an outside theorem | **explicit purchase**, with the four items above; declared to the gate by one `AxiomAudit.declareImport` line in `scripts/Axioms.lean`'s IMPORTED section (the procedure is beside its banner), every record resting on it audited there |
| a hypothesis standing for an outside theorem, a hand result of ours or an open question | **declared**, with its kind and source, by one line of `AssumptionAudit.declared` in `scripts/Assumptions.lean`; every statement that takes it listed in `scripts/assumptions-ledger.txt` |

**The audit checks each record's axioms as a set** (`scripts/axioms.sh`): under CLEAN a subset of the standard three; under IMPORTED
the standard three and declared imports, at least one; under PURCHASED those and native axioms, at least one native. Any other axiom
fails, and so does any `axiom` the library declares that no `declareImport` names, whether or not an audited record uses it. The
receipt prints every axiom by its full name (`pp.fullNames`), and its `CLAUDE.md` sentence records three counts: clean, declared
purchases, imported.

`native_decide` trusts the compiler and this CPU rather than the kernel; soundness theorems are identical either way, only the axiom
list moves. **Grep for the right name:** at v4.32.0 `native_decide` mints a *per-declaration* axiom; `Lean.ofReduceBool` never appears
in `#print axioms`, so an audit looking only for that name passes a native purchase in silence.

**`lean4checker` is a publication gate, not a milestone gate** (Kooshi, 2026-08-02): the build-time kernel is the trust anchor; the
independent replay is single-threaded and RAM-heavy, so it runs once, on hardware other than the desktop, before any external claim of
new mathematics. It cannot re-check a purchase (a purchase is an axiom, and every kernel accepts axioms), so "replayed through an
independent kernel" covers the kernel-checked part only.

## Toolchain

Managed by **elan** and pinned by `lean-toolchain` (`leanprover/lean4:v4.32.0`); the toolchain and the Mathlib pin move as one unit.
If `lean` / `lake` are missing, run `./install-toolchain.sh`.

**The Arch build environment, required before building.** The toolchain's bundled `clang` is broken against Arch's system LLVM, so any
native or C compile fails unless the system clang is used with the toolchain's bundled `libc++`. `source scripts/dev-env.sh` (it sets
`LEAN_CC`, `LIBRARY_PATH` and `LEAN_ABORT_ON_PANIC`; the installer wires it into `~/.profile`, and Claude's shell gets it through
`.claude/settings.local.json`).

## Building

**Always build through `./scripts/build.sh`, under `scripts/slot.py` — never `lake build`, bare *or named*.** Lake 5.0.0 has no `-j`
and sizes its job pool from the machine; data modules here peak at about 9 GB each and certificate segments at 3.4 GB + 0.81 GB per
chunk, so an unrestricted build asks for hundreds of gigabytes, and a *named* target silently queues every missing or stale dependency
into the same pool. `scripts/build.sh` builds every module in dependency order (`scripts/build_order.py`), leaves first, in explicitly
named batches (`BATCH`, default 10), each under a `systemd-run` memory cap (`MEMMAX`, default 100G); `--plan` prints the batches and
builds nothing. It first asks Lake once, under the same cap, whether any module is out of date (`lake build --no-build`, about 2 s
against about 3 min for the walk); only exit 0 skips the walk.

**`lake env lean <file>` is fine for iteration — it builds nothing — and it is not the same check.** It does not apply the lakefile's
options, so `autoImplicit := false` is not in force: a stray identifier is silently auto-bound and the file elaborates clean, then
fails the real build. Never conclude from it that a module is green.

**The batch is the plan; the cap is a backstop.** Lean `mmap`s its `.olean` files, so at the limit the kernel reclaims their page cache
and must read it back — with `MemorySwapMax=0` that is an I/O thrash, not a clean kill. Before raising `BATCH`, measure a module's peak
and choose the width from `available_memory / peak`:

```bash
ps -C lean -o rss= --no-headers | awk '{s+=$1} END {print s/1048576 " GB"}'
```

**Generated modules and invalidation.** For work split across independent modules the wall clock depends only on the job count, so
smaller pieces are free concurrency. Lake takes a module's own trace from its source and its dependents' traces from the resulting
`.olean` (doc comments are queryable data and therefore part of the artifact; `--` comments are not; ignoring this once cost 28
processor-hours):

| edit to an upstream module | that module | its dependents |
|---|---|---|
| a `-- line comment`, anywhere, including inside a proof | re-elaborates | **not rebuilt** — the `.olean` is byte-identical |
| a `/-- docstring -/` or a `/-! module doc -/` | re-elaborates | **rebuilt** — doc strings are environment data |
| a declaration, or any change to one | re-elaborates | rebuilt |

So: prose in a module a certificate imports is written as `--` comments or not at all; diagnostics live downstream in
`Sat/Diagnose.lean`; `Sat/Mask.lean`, `Sat/ClauseTable.lean` and `Sat/MaskCheck.lean` are settled, and changing a declaration or
docstring there is a decision about hours; deleting a generated `.c` under `.lake/build/ir/` invalidates its module exactly as deleting
the `.olean` would. Settle every hand-written module before starting a long generated build.
- A worktree's copied `.lake/build` can be behind its branch — FS124-K1's first build rebuilt 136 modules in 20 minutes; `lake build --no-build` under the cap says so in two seconds. (FS124-K1).
- **On the laptop** (12 cores, 31 GB; `SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`): a build that recompiles 117 modules of `Plane/` and `Outside/` at `BATCH=2` is 47 m 22 s, about half of it the walk (Lake started 947 times); its largest compiler is 5.5 GiB resident (`Plane/CoverExamples`, 134 s) and its largest batch 8.0 GiB. With a known small stale set, `BATCH=10` starts Lake 201 times: a walk that rebuilds two modules is 5 m 33 s to 6 m 11 s. Every whole-library gate step — the audit, the two scans, the doubled names, the lint, their self-tests — is one `lean` process of 4.4 to 5.1 GiB resident, of which the kernel charges the step's scope 0.5 to 1.3 GiB when the `.olean` pages are already cached; the audit is 8 s, each scan about two minutes, each self-test two to three. A scope's `memory.peak` is not what a step costs cold: plan a cap from the largest process's resident set (`data/fs131/lc1/in-scope.sh` records both) (FS131-LC1).
- **After a merge that brings another landing's docstring edits, the modules they made stale need not be recompiled where a tree holds that landing's gated build**: copy its `.lake/build` in by checksum (`rsync -a --checksum`, no `--delete`), then `./scripts/build.sh` — Lake decides by the hash of a module's source and of its imports' compiled files, never by where or when it was compiled, and recompiles what this tree changed (FS131-LU1: 117 modules stale after the merge, 4 recompiled, 5 m 34 s against 47 m). A module that imports an edited docstring recompiles to the same `.olean` bytes — only its `.trace` moves (113 of 114 dependents, by checksum). Take the checksum listing before and after the copy, and a manifest of every `.olean`'s hash and time once it is in (`data/fs131/lu1/compiled_unchanged.py`): the source tree can be moved and built in under you (it was, four minutes later, for the next job), and the manifest is then what shows that no copied file has been rewritten.
- A module whose upstream must change before it can elaborate (a port whose name an upstream axiom holds) is elaborated in a symbolic copy of the compiled library (`cp -as` of `.lake/build/lib/lean/Proofs`), each module compiled there written over its link after the link is removed, and the copied-from `.olean`s checked unchanged by hash (`data/fs131/ipd1/farm2-run.sh`, FS131-IPD1; `data/fs131/lp1/advalue-run.sh`, FS131-LP1).
- `decide +kernel` modules in one batch share no memory: eight `Plane/DensityBound/Cells/PartNN` (about 2 GB each) are OOM-killed in a 10 GiB scope (exit 143, `Terminated`, the user journal's `oom-kill`), and two FS131-IKC4 check modules (5.4–7.3 GiB each) in one 10 GiB scope likewise; a rebuild of either needs `BATCH=3` (cells) or `BATCH=2` at `MEMMAX=16G` (the checks) (FS131-LCH1).
- A lint control planted in a leaf module (one only the root imports: `Rigidity/CertLinkModels`) costs a two-module rebuild: 7 m 17 s at `BATCH=8` on the laptop, all but 3 s of it the walk (FS131-LGT1).

## The kernel's cost model

- **`decide +kernel`, not `decide`, for anything large.** Plain `decide` reduces the `Decidable` instance twice — in the elaborator and
  in the kernel — so it is about 2× slower and dies on `maxHeartbeats` first; `+kernel` needs no knob and buys the same axioms.
- **Reduction-step count is the only thing that costs**, about 33 µs per iteration of a trivial recursive function; the model predicted
  core's LRAT checker cost within 20 %. GMP-backed `Nat` arithmetic *and bitwise* operations are free at thousands of bits; `USize` is
  stuck (its width is an `@[extern] opaque`); `Nat.ldiff` is not accelerated; `Nat.fold` is superlinear. Which operations are
  hardware-backed is invisible in the source — measure before believing.
- **Data the kernel must *build* costs O(its whole size) per access; a *literal* does not.** A lookup in a table grown by `insert` went
  from 2.14 ms at 2,381 entries to 16.7 ms at 33,089. Emit big tables as literals (M04's `PtTable` pattern), never accumulate one during
  a kernel evaluation, and never build an index list with `List.range` + `List.map` (about 0.83 ms per element). That figure does not
  transfer to a bare `List.range` re-evaluated in a loop, which the kernel's cache absorbs; hoisting it is still the honest shape. A
  rule you are obeying is still a claim, and it is measured before it is written down. A `Nat` literal costs about 2.3 KB of olean
  against about 145 bytes per plain literal node, so pack many values into few big `Nat`s.
- **A closed `Nat` term rewritten by a lemma stated at other instances than its own is evaluated by the kernel.** `0 + S` with `S` a
  closed sum of 16,383 register states, rewritten by Mathlib's `zero_add`: elaboration succeeds, the kernel runs 173 s to
  `deterministic timeout`, and passes 8 GiB in 27 s; with one variable free in `S`, or with core's `Nat.zero_add` on the closed term,
  2 s (`data/fs131/i10e/lean/closed-term/`). State the lemma that does the algebra with the term's parameters free and instantiate it
  last (`Floor128.pass_class`, `class_le`); a `(kernel) deterministic timeout` is a memory event too, so bisect one under a slot.
  (Measured by FS131-I10E; the mechanism is its reading, one mind, not checked against the kernel's source.)
- **A `∀ x ∈ l, P x` under `decide` costs an order of magnitude more than the same check as a `Bool`** (31.9 GB and a timeout against
  3.5 GB and 5 s on 778 pairs). State list checks through `List.all` and recover the per-element form with `List.all_eq_true`.
- A chained kernel computation whose state is passed on as computed terms re-pays them: 21 cells of the `J₀` covering took 21.8 s per cell chained and 1.5 s per cell when each cell was checked from literal entry states to literal exit states (`data/fs131/kdb1/probes/`). Check a long chain link by link, the states as literals produced by the evaluator (FS131-KDB1).
- A kernel DFS of mask tests costs about 100 µs and 15 KB of cache per test: 96 k tests 15 s and 2.2 GB, 664 k tests past 8 GiB in 51 s. Split such a check into theorems of at most about 100 k tests (FS131-KDB1).
- A certificate's checker in a core-only module, its soundness in a second, and the generated modules importing only the first: the 46 cell modules of the `J₀` covering then load no Mathlib (1.95 GB resident against 4.60 GB with Mathlib, the same module) and outlive every edit to the Bessel proofs (`Plane/DensityBound/BesselCheck`, `BesselCert`, `Cells/*`; FS131-IDB1). A module of 18–29 `decide +kernel` theorems peaks at about one theorem's memory (1.6–2.4 GB).
- A DFS of mask tests over packed terms (`mask + 2²³·(c + 2⁷⁰)`) costs about 140 µs per test in the kernel: `[AmbrusEtAl2023]`'s atom check, 7.12 M tests below a depth-15 frontier of 492 states, is 103 theorems of at most 80,000 tests, about 11 s and at most 2.4 GB each; a module of eight peaks at one theorem's memory. The frontier is checked once against the DFS's own prefix (`collect … = frL`), so the chunks need no completeness argument of their own (`Plane/DensityBound/X23Data`, FS131-IDB3).
- A congruence row checked as an explicit isometry in `ℤ[√3, √11]` is about 27 ms: 300 rows of up to 8 points in 8 s and 1.6 GB (`X23Cong00`, FS131-IDB3).
- Read a certificate's decimals at the scale that makes every one exact, and assert it in the generator: `g23.csv` holds one coefficient with 21 decimals (`5.4369049825320215e-05`), so `10²⁰` is not exact and `int(v·10²⁰)` truncates it in silence (FS131-KDB1's `proto_atoms.py` did; the check `Fr(c, WS)·WS == c` it carried is true of every integer). Lane X is exact at `10²¹` (FS131-IDB3).
- **A numeral at an unsimplified type index is paid per numeral, at elaboration, even in a definition with no proof.** A 48-point
  literal at `ZMod (2 ^ ((5 + 1) / 2))` cost 32.9 GB and a timeout; at `ZMod 8`, 2.5 GB and then a defeq wall on every access. Carry
  no literal at such a type; evaluate the form per element.
- **Feed the kernel the refutation's core, never the whole instance.** A certificate's clause table costs `agreesWithCNF` over the
  entire formula: 853 s at 33 GB for a 1,024-vertex instance whose proof reached 125 vertices; the core, extracted from the LRAT by
  backward reachability from the empty clause (861 of 99,335 clauses), proves the identical statement in 5.9 s (recipe:
  `Instances/TwoAdicFive/Edges.lean`).
- **A kernel leaf priced from a plan's table is priced high**: re-price a kernel phase from its first two leaves.

## Searching — Lean

- Never name a namespace `HadwigerNelson.X` after a Mathlib root namespace a module opens (`Topology`, `Set`, `Real`, `Complex`, `Filter`, `Metric`, …): inside `namespace HadwigerNelson…`, `open X` then opens `HadwigerNelson.X` instead of Mathlib's `X`, silently (measured at v4.32.0: `data/fs131/leb/NamespaceShadow.lean`). None exists today.
- At the pin `push_neg` is deprecated; write `push Not`.
- `nlinarith` exhausts its heartbeats in a large context even when the certificate is small, and one declaration shares one heartbeat budget: state each
  inequality as a small real-variable lemma carrying only its own hypotheses, then apply it (FS131-I4h, five leaves).
- `T ⁻¹' A ∆ A` parses as `T ⁻¹' (A ∆ A)`: write `(T ⁻¹' A) ∆ A`. `s ∆ t` on sets needs `open scoped symmDiff` (FS131-I10A, -I10B).
- At the pin `add_le_add_left h a : b + a ≤ c + a` and `add_le_add_right h a : a + b ≤ a + c` (and `mul_le_mul_left/right` alike): the name
  says which side varies. `#check` before use (FS131-I10B).
- `ENNReal`: `ENNReal.one_half_lt_one` is stated at `2⁻¹`, not `1 / 2` (`ENNReal.half_lt_self` gives `a / 2 < a`);
  there is no `ENNReal.div_eq_iff` — `ENNReal.eq_div_iff : b = c / a ↔ a * b = c`. `Measure.exists_mem_of_measure_ne_zero_of_ae`
  is under `Measure`. `Measure.addHaar_sphere` asks `Nontrivial E`; `addHaar_sphere_of_ne_zero` does not. A `rw` with
  `Measure.addHaar_closedBall'` takes the first closed ball about `0` in the goal, `closedBall 0 1` included: name the radius.
  An intermediate value on a convex set needs no path: `(convex_closedBall c r).isPreconnected.intermediate_value` (FS131-IF1).
- A `rfl` for `((Subring.inclusion h a : unitRing F) : ℂ) = a` at the concrete pair `unitRing ⊥ ≤ unitRing F` is accepted by the elaborator
  and times out in the kernel, which compares the two subtypes and descends into `F =?= ⊥`. Stated generically in the two subrings
  (`coe_inclusion_subring`) it is checked once with variables (FS131-K10).
- The reflection `z ↦ g − z` preserves an invariant measure: `MeasureTheory.Measure.measurePreserving_sub_left` (the name is under
  `Measure`, not under `MeasureTheory`). With a translation it bounds a half-disc or a strip without rotating the plane: an open
  half of a disc and its mirror image are disjoint (FS131-I6A, `volume_halfPlane_inter_closedBall_le`).
- For sets, `s ≤ᵐ[μ] t` is `∀ᵐ z, z ∈ s → z ∈ t`: prove it with `filter_upwards […] with z … hz`, or from an inclusion as
  `Eventually.of_forall fun z hz => h hz`; `Eventually.of_forall h` with `h : s ⊆ t` does not elaborate, and
  `HasSubset.Subset.eventuallyLE` is deprecated at the pin (FS131-I6A).
- At the pin Mathlib holds two ramification APIs. The number-field lemmas — `Ideal.sum_ramification_inertia` (`Σ e·f = [L:K]` over
  `IsDedekindDomain.primesOverFinset`), `Ideal.absNorm_eq_pow_inertiaDeg'`, `Ideal.IsDedekindDomain.ramificationIdx'_eq_multiplicity` —
  are stated for the primed `Ideal.ramificationIdx'` / `Ideal.inertiaDeg'` (`Mathlib/NumberTheory/RamificationInertia/`), over
  `Ideal.span {((p : ℕ) : ℤ)}`; the unprimed names are a newer definition in `Mathlib/RingTheory/RamificationInertia/` with a
  different statement of the sum (FS131-I10C).
- `simp` does not rewrite the coercion of a numeral out of a subfield, `((3 : ↥S) : K)`; `map_ofNat S.subtype 3` and `norm_cast` do.
  Dot notation on a `local notation` (`twoZ.inertiaDeg' P`) is an unknown identifier: make the object an `abbrev`. And
  `lake env lean` does not report a missing docstring on a public `def` (the lakefile's linter options are not in force); the
  build does (FS131-I10C).

- **A failed `exact?` is not an absence.** It proves the shape you asked for was not found; vary the statement (`= true` versus
  `decide (…)`, an iff versus an implication) first. **And Mathlib is not the whole library:** `grep -rn "<name-fragment>" $(lean
  --print-prefix)/src/lean/` searches core. Grep the source before writing a proof, and before writing that something is missing. Grep
  Mathlib by the statement's shape at the skeleton.
- **Never state one lemma under one name in two modules that do not import each other** — on two branches least of all. It is not
  a loud failure at the join: the two theorems merge in silence and the axiom audit then reads one copy while the kernel holds the
  other (§ The gate, `scripts/dupnames.sh`). A line that needs another line's lemma before they meet takes it as a hypothesis, or
  states it under a name of its own and says so in its report; the join then makes one declaration.
- **A section `variable` enters a theorem only if the theorem's statement mentions it** (at the pin; the proof body cannot pull it in).
  A skeleton leaf whose statement does not name a hypothesis-carrying variable is stated without it: `Plane/RouteT/Count` held four
  such leaves — each false of a one-face torus, each a `sorry` from which the next leaves were to be proved (FS131-I7A, inventory
  item 556). `include C in` above the theorem adds the binder and leaves the text unchanged; `omit [...] in` drops instance binders a
  proved theorem does not read (with a `sorry` body the `unusedSectionVars` linter stays quiet). **Read a leaf as the kernel has it —
  `#check` — never as the file prints it; a statement check that compares text passes this whole class.** `data/fs131/l10b/kernel-sigs.lean` with
  `tools/fs131_l10b_kernelsig.py` is that reading for a list of modules: the binders of each stored type against the file's own
  signature and every `variable` in scope (FS131-L10B).
- Which instance a term is elaborated with depends on the imports, and equal text can store different terms: `volume : Measure ℂ` takes the proof `Complex.instFiniteDimensionalReal` of `FiniteDimensional ℝ ℂ` where `Mathlib.LinearAlgebra.Complex.FiniteDimensional` is imported and `FiniteDimensional.rclike_to_real` where it is not — equal by proof irrelevance, not symbol for symbol. A statement copied from another library is compared as the kernel stores it, never as text (FS132-I1).
- Between Mathlib `v4.32.0` and `v4.34.1`: `Set.restrict` became `Set.domRestrict` (2026-07-19), `setOf` became `Set.ofPred` (2026-07-09; the set-builder notation elaborates to the pin's name, so two prints of one text differ by it), `s ≤ᵐ[μ] t` on sets became `Filter.EventuallySubset` (2026-08-14; here it is `Filter.EventuallyLE` at `Prop`), and core's `if_neg` became `ite_eq_right` (2026-07-21). A text written at the later pin needs the earlier names here (FS132-I2).
- `K.2 : 0 ≤ K.val` for `K : ℝ≥0` is not the atom `(K : ℝ)` to `linarith`/`nlinarith` at the pin; `K.coe_nonneg` is.
- `lean -o` writes no `.olean` when the file has an error, and a `LEAN_PATH` entry holding a `Proofs/` directory hides every later entry's `Proofs`: a scratch farm is a symlink copy of the build's library with the modules under work written over it (`data/fs132/i2/lean1.sh`).
- Positivity of the measure of a set that need not be measurable goes through sections: `Measure.measure_ae_null_of_prod_null` asks no measurability, so a null set has almost every section null, and one positive section on a set of positive measure refutes it (`SixRing.volume_pattern_pos`, FS132-I3).
- `vol F ≤ K · vol (g '' F)` on the line for a map that shrinks no distance on `F` by more than `K`, with no measurability of `F`, `g` or the image: `AntilipschitzWith.le_hausdorffMeasure_image` for `F.restrict g`, `Isometry.hausdorffMeasure_image` for the coercion, `hausdorffMeasure_real` (import `Mathlib.MeasureTheory.Measure.Hausdorff`; `SixRing.volume_le_mul_volume_image`, FS132-I3).
- A `ring` that cannot close a goal and whose fallback `ring_nf` does prints `Try this: ring_nf` as information, with no file position in `lake env lean`'s plain output: `lake env lean --json` gives the line. And `ext` on a continuous linear map out of a product applies `prod_ext` and binds no vector: write `ContinuousLinearMap.ext fun v => _` (FS132-I3).
- A null set pulls back to a null set under a measure-preserving map with no measurability of the set (`MeasureTheory.Measure.QuasiMeasurePreserving.preimage_null`), and `∀ᵐ` and `μ s = 0` are about outer measure: a statement about 'almost every' needs a measurability hypothesis only where Fubini is read backwards (slices to product). `MeasurePreserving.skew_product` has its base in the first factor; conjugate by `Measure.measurePreserving_swap` for the second (FS124-K1).
- `tauto` exhausts its heartbeats in a context holding long implications it does not need (two pulled-back `HubColours` statements): write the case split (`SixRing.no_double_change`, FS132-I4).
- `rw [Measure.ae_prod_iff_ae_ae h]` finds no pattern in a goal that `filter_upwards` has beta-reduced; apply it as `refine (Measure.ae_prod_iff_ae_ae (p := fun w => …) h).mpr ?_` with the predicate written out. A section of a measurable set of triples is `measurable_prodMk_left hmeas` (FS132-I4, `unitPair_chart_ae`).
- A map from a set of the line into a metric space that is `K`-antilipschitz there pulls sets of one-dimensional Hausdorff measure zero back to Lebesgue-null sets (`SixRing.volume_preimage_inter_le_hausdorff`); with `abs_dist_sub_le` it replaces an inverse function theorem wherever a point is known to move away from a fixed centre at a definite rate. Shears of `ℝ × (ℝ × ℝ)` are `MeasurePreserving.skew_product` between two swaps (`SixRing.shear_measurePreserving`); a statement almost everywhere on the line pulls back to triples by `QuasiMeasurePreserving.prod_of_right` (FS132-I4).
- A `scoped instance` declared inside `namespace A.B` is found in `A.B` and under `open A.B`, **not** in `A`: `attribute [scoped instance] B.instName` inside `namespace A` adds `A`'s scope. An anonymous scoped instance keeps the name the unscoped one has, and `private scoped instance` parses (measured at the pin: `data/fs132/l2/probes/scoped-probe.lean`; on a built module, `scoped-built.lean`; FS132-L2).
- `sphere 0 1 + W` and `IsOpen.add_left` need `open scoped Pointwise` at the declaration (FS124-K2).
- A `#check` under `import Mathlib` shows that a name exists at the pin, not that a module can see it: check a route's names under the module's own imports. `rotation` (`Mathlib.Analysis.Complex.Isometry`) is outside `Plane/AeColouring`'s closure; multiplication by a unit complex number is a real-linear isometry with no new import as `⟨(LinearEquiv.smulOfUnit (Units.mk0 a ha)).restrictScalars ℝ, _⟩`, and `LinearIsometryEquiv.measurePreserving` is in the closure (FS124-I1).
- `Complex.finrank_real_complex` is in `Mathlib.LinearAlgebra.Complex.FiniteDimensional`, which `Plane/Basic` does not import; without it `finrank ℝ ℂ = 2` is `Module.finrank_eq_card_basis Complex.basisOneI` with `Fintype.card_fin`. In a module whose statements name `volume : Measure ℂ` the import is not a free edit: it changes the instance the statement stores (the line above on imports) (FS124-I2).
- An implementer shows it changed no statement from the kernel's side: print every constant of its modules' compiled data (kind, name, stored type, a definition's value) from the build as given — **before the first rebuild replaces the `.olean`s** — print again after, and compare, with a planted difference that must be reported; an `example` is not stored, so its head is compared as text against the base commit (`data/fs124/i2/lean/StatementDump.lean`, `data/fs124/i2/statement_diff.py`) (FS124-I2).
- At the pin 'null exactly when almost every point is off it' is `measure_eq_zero_iff_ae_notMem` (FS124-I2).
- `decide +revert` reverts every hypothesis in scope and asks the whole context to be decidable; for a fact about `k : Fin 3` state it closed (`∀ k : Fin 3, k = 0 ∨ k = 1 ∨ k = 2 := by decide`) and apply it (FS124-I3).
- At the pin `zero_le` takes its argument implicitly (`zero_le _` is 'function expected'); `nonpos_iff_eq_zero` turns `μ s ≤ 0` into `μ s = 0`. `Set.diff_self` is deprecated for `Set.sdiff_self` (FS124-I3).
- `IsPreconnected.union x ⟨…⟩ ⟨…⟩ hs ht` with the two memberships as anonymous constructors does not elaborate ('the expected type of this term could not be determined'): state each membership as a `have` with its set, and build a union's membership with `mem_union_left`/`mem_union_right`, not `Or.inl` (FS124-I3).
- A line of the plane given by its equation is null: `volume_setOf_re_im_eq : a ≠ 0 ∨ b ≠ 0 → volume {z : ℂ | a * z.re + b * z.im = c} = 0` (`Plane/ThreePiece`), by `Measure.addHaar_submodule` on the kernel of the form and a translation; a set cut out of a disc by finitely many strict linear inequalities leaves a null remainder this way (FS124-I3).
- An injective path on a circle from `x` contains an arc of the circle from `x` with no monotonicity argument: the argument of `(γ u − w)/(x − w)` is continuous while it stays in `Complex.slitPlane`, and `intermediate_value_uIcc` gives every angle between `0` and its value at a later point; a path on `unitInterval` is carried to the line by `Set.projIcc` (`ThreePiece.hasUnitArcFrom_of_arc_subset_sphere`) (FS124-I3).
- A definition that holds proofs as fields moves its stored value when a field is proved: an implementer's statement check compares its data fields in place of its value, and a reader of `example` heads blanks block comments and docstrings first — a docstring line beginning with the word `example` was counted as one (`data/fs124/i3/lean/StatementDump.lean`, `data/fs124/i3/statement_diff.py`) (FS124-I3).
- A lemma stated on a term built with proof arguments (`D.transport T hT f hf hx hU hc`) cannot be applied with those arguments left to unification: proofs unify by proof irrelevance and assign nothing ('don't know how to synthesize placeholder'). State it for any object whose data fields are the images (`hp : ∀ i, D'.piece i = T '' D.piece i`) and discharge the hypothesis by `rfl` (`ThreePiece.separatesAt_iff_of_image`, FS124-I4).
- `linarith` multiplies out products of atoms (its preprocessing is polynomial arithmetic over monomials): a nonlinear inequality whose certificate is a few products of hypotheses is closed at once by stating each product as a `have` (`mul_pos`, `mul_nonneg`) and `linarith only […]`, where one `nlinarith` per case exhausts its heartbeats (`split_outer_gt`, FS124-I4).
- At the pin `Set.image_diff` is deprecated: `Set.image_sdiff`. A definition living downstream of where its models can be built is met by a theorem upstream whose conclusion is the definition's body written out, and `exact` in the downstream proof (`ThreePiece.ArcCut.sector` for `ThreePiece.IsSector`, FS124-I4).
- `isPreconnected_Icc` and `isCompact_Icc` hold for `unitInterval` by instance; the closed disc is unicoherent (`isPreconnected_inter_of_union_eq_closedBall`, `Plane/ThreeArcs`); a cyclic order of points on a circle is carried by one rotation lemma (`RimOrder.rotate`), not by index arithmetic in `Fin n` (FS124-K3).
- A filled skeleton's statements are compared with the skeleton's as the elaborator stores them: elaborate both with one footer that prints every declaration's type and its hash, and require each line of the skeleton's print in the module's (`data/fs124/i5/statements.sh`; its control adds a hypothesis in a copy and is named). A structure's `Prop` fields are theorems in that print: count the written theorems from the source (FS124-I5).
- A module elaborates under `lake env lean` in seconds where a build walks nine minutes: later leaves are written against a copy under `data/` while a build walks, never in the module the walk will read; the copy goes over the module between builds (FS124-I5).
- A landing shows from the kernel's side that it changed no statement with one dump of every constant of its modules (stored type, a definition's stored value) made before the first build that recompiles them and one after the last (`data/fs124/l2/StatementDump.lean`, `tools/fs124_l2_statements.py`); a module the join had already recompiled is compared with its maker's last dump, and a module from another branch with a dump made in that branch's worktree (FS124-L2).
- A colouring that must *extend* a given one on a set comes from `Finset.rado_selection` read at singletons (`χ x = g t x` with `x ∈ t`), with no gadget; `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` cannot carry a precolouring (`exists_proper_ae_eq_of_proper_on_conull`, FS131-KC1).
- `Besicovitch.ae_tendsto_measure_inter_div μ s` asks no measurability of `s`, and `ae_imp_of_ae_restrict` turns it into `∀ᵐ x ∂μ, x ∈ s → …` with none either: almost every point is a density-one point of its fibre for **any** map with countably many values (`ae_hasDensityOneAt_fibre`). Density one is closed under intersection only with a null-measurable set (`MeasureTheory.measure_union_add_inter₀`; `HasDensityOneAt.inter`) (FS131-KC1).
- `Measurable f` for `f : ℂ → Fin k` is Borel measurability (`Complex.measurableSpace := borel ℂ`); 'Lebesgue measurable' is `NullMeasurable f volume` — equivalently every fibre a `NullMeasurableSet` (`Plane.nullMeasurable_iff_forall_fibre`), equivalently `AEMeasurable f volume` (`NullMeasurable.aemeasurable`, `AEMeasurable.nullMeasurable`). A docstring that says Lebesgue over `Measurable` names another number wherever the colouring must be proper at every pair (`Plane.chiM` is `χ_B`) (FS131-KC1).
- A landing that edits docstrings only shows it twice: in text, the file with every block comment removed is the same (`data/fs131/lc1/code_only_diff.py`, with a planted code character), and from the kernel's side by the dump of the edited modules made before the build and after it. A docstring edit in a module the import's module reads (`Plane/AeColouring` is under `Outside/OAI158` and the nine ported modules) recompiles them: both stored-term comparisons with the release are run again (FS131-LC1).
- Mathlib at the pin holds the localization of a Dedekind domain at a prime as a valuation subring of its fraction field, with its `IsLocalization` and `Ring.KrullDimLE 1` instances: `IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime` (`Mathlib/RingTheory/DedekindDomain/AdicValuation.lean`); a valuation subring above it other than `⊤` is it (`ValuationSubring.eq_of_le_of_ne_top`). `Arith/PlaceHom`'s two localization lemmas predate the reading (FS131-KN2).
- A field generated by algebraic elements maps to any field in which their minimal polynomials split: `IntermediateField.nonempty_algHom_adjoin_of_splits`; at the pin `Polynomial.Splits` is a predicate on one polynomial (`(p.map f).Splits`), and `Polynomial.splits_of_splits_of_dvd`, `Polynomial.splits_X_sub_C` are deprecated for `Polynomial.Splits.of_dvd`, `Polynomial.Splits.X_sub_C` (FS131-KN2).
- A maximal ideal with `p` elements in its quotient is the kernel of a ring homomorphism to `ZMod p` (`ZMod.ringHom_surjective`, `RingHom.ker_isMaximal_of_surjective`, `RingHom.quotientKerEquivOfSurjective`): no ring of integers need be computed to exhibit a degree-one prime (`QuadraticPrime.isMaximal_ker_and_card`; FS131-KN2).
- The coercion `𝓞 K → K` is `RingOfIntegers.val`, an `abbrev` for `algebraMap (𝓞 K) K`: `rw [map_mul]`, `rw [map_one]` do not fire on `↑(a * b)`, `↑1` (the head symbol is `val`); `simp` does, `RingOfIntegers.coe_injective` gives a goal stated with `algebraMap` where they fire, and a term `(map_mul (algebraMap _ _) a b).symm` is accepted for `↑a * ↑b = ↑(a * b)`. `RingOfIntegers.coe_eq_zero_iff` is injectivity at `0` (FS131-IU1).
- A footer that prints stored types gives two texts for one statement when the two copies are elaborated at two paths: an instance binder's stored name carries the file's module name (`inst._@.<module>.<n>._hygCtx._hyg.6`). Elaborate the skeleton and the candidate at one path in turn (`data/fs131/iu1/statements.sh`); and a private declaration's stored name (`_private.<module>.0.<name>`) is `Name.isInternalDetail`, so a reader that skips internal names skips the private helpers — list them through `privateToUserName?` (FS131-IU1).
- In a subfield of `ℂ` whose carrier is a set of the library (`fieldI F`, carrier `planeOver F`), `simp` rewrites `(⟨↑x, _⟩ - ⟨↑y, _⟩ : fieldI F)` for `x y : planeOver F` to the coercion of `x - y` and then cannot use a hypothesis about `↑x - ↑y`; state the fact in `ℂ` and close with `Subtype.ext` (`UpperHalf.sub_mul_conj_eq_one`; FS131-IU1).
- `(conjOn hL).restrict A.toSubring A.toSubring hσ` has type `↥A.toSubring →+* ↥A.toSubring`; an `algebraMap R ↥A` applied under it is then asked for `Algebra R ↥A.toSubring`, which Mathlib's `valuationSubringAtPrime` does not declare. Name the map by a `let` ascribed `A →+* A` (`UpperHalf.residue_conj`; FS131-IU1).
- `rw [h] at hx` where `hx : ↑x ∈ S` and `x : ↥S` fails with "motive is not type correct"; read an equation of subfields at a point: `(SetLike.ext_iff.1 h (x : ℝ)).1 x.2` (FS131-IQ1).
- `rw [map_one]` (and `map_mul`, `map_add`) does not see `((1 : 𝓞 K) : K)`: the coercion is the abbreviation `RingOfIntegers.val`; `show … (algebraMap (𝓞 K) K 1) …` first, or use `simp` (FS131-IQ1).
- A quadratic extension `K₀(π)` given only by `Subfield.closure (↑K₀ ∪ {π}) = ⊤` gets its coordinates from `Subfield.closure_induction` with no subfield built, and `choose` turns existence into the two coordinate functions (`QuadraticPrime.exists_coords`, private; FS131-IQ1).
- The `p`-adic valuation of a natural number divisible by `p` exactly once is `1` by `Padic.valuation_natCast` and `padicValNat_dvd_iff_le`; parity arguments on `ℚ_p` go through `Padic.valuation_mul`, `Padic.valuation_pow`, `Padic.norm_le_one_iff_val_nonneg` and `omega` (FS131-IQ1).
- `rw [Subfield.bot_eq_of_charZero] at hx` fails with "motive is not type correct" when `hx` speaks of an element whose type mentions `⊥` (`x : 𝓞 (fieldI ⊥)`): state "an element of `⊥ : Subfield ℝ` is a rational" for a real number once (`∀ r : ℝ, r ∈ (⊥ : Subfield ℝ) → ∃ q : ℚ, (q : ℝ) = r`) and apply it (FS131-IV1).
- `simp` does not reduce `((2 : 𝓞 K) : K)` read in `ℂ` through a subfield's coercion (the line of FS131-I10C, one coercion further): `rw [two_mul]` before taking coordinates, or state the fact without the numeral (`x + conjO x = m + m`) and finish in the commutative ring with `linear_combination` (`UpperHalf.exists_stablePrime_rat`; FS131-IV1).
- `Complex.isIntegral_int_I` is not a name at the pin; `IsIntegral.of_pow (n := 2) (by norm_num) (by rw [Complex.I_sq]; exact isIntegral_one.neg)`. A rational that is integral over `ℤ` in `ℂ` is an integer by `isIntegral_algebraMap_iff` and `IsIntegrallyClosed.isIntegral_iff`; trace, norm and `(z̄ − z)·i` are `Complex.add_conj`, `Complex.mul_conj`, `Complex.sub_conj` (FS131-IV1).
- `omega` takes a square as an atom: a parity contradiction such as `(2m+1)² + (2k)² = 4n` closes with one `ring` identity stated as a `have` and `omega` (FS131-IV1).
- `tools/check_architecture.py` fails on a row's imports cell and on module coverage; a misnamed identifier in a row's description is listed under `[3]` and does not fail (FS131-IV1, two plants on copies).
- `simp [f]` or `simp only [f]` on a definition `f` of an **upstream** module makes Lean generate `f.eq_1` in the module that asks; if a sibling module asked first, the library then holds two copies — a `GENERATED` row of `scripts/dupnames.sh`, not a failure, and a row the landing has to read. Read the definition by unfolding instead (`change <its body> at h`, or `change` before a `simp` that no longer names `f`), or give `f` its equation as a stated lemma where it is defined. A dump of the compiled module shows it — a constant under no declaration of the file — and no check of the source does: FS131-IC1's first build held `ThreeColour.relMap.eq_1` and `ThreeColour.minRise.eq_1`, which `ThetaCert` already held (`data/fs131/ic1/statement_diff.py`'s `FOREIGN` list; `data/fs131/ic1/probes/OnDemand.lean`) (FS131-IC1).
- Induction on `ℤ` from a base point is `Int.inductionOn'` (cases `zero`, `succ`, `pred`; `pred` gives `k - 1`, and `sub_add_cancel` returns to `k`); there is no `Int.induction_on'` at the pin (FS131-IT1).
- `linear_combination` over `ℂ` does not know `Complex.I ^ 2 = -1`: add `c * Complex.I_sq` with the coefficient the failed `ring` goal shows (FS131-IT1, `exists_orbit`).
- After `nsmul_eq_mul` in a subring, `simp` with `Nat.cast_ofNat` turns `((25 : ℕ) : ↥S)` into the numeral `(25 : ↥S)`, whose coercion nothing then moves; keep the cast: `simp only [Subring.coe_mul, Subring.coe_natCast]`, then `push_cast` (FS131-IT1; the line above on numerals out of a subfield).
- An orbit `wᵐ b` in a subring of a field is cheapest as a `zpow` in the field, with membership per `m` (`zpow_add_one₀`, `zpow_sub_one₀`, `norm_zpow`), not as a unit of the subring (FS131-IT1).
- A module structure introduced by `letI : Module (ZMod p) M := AddCommGroup.zmodModule h` makes instance search for `Module.Free (ZMod p) M` and `Module.Finite (ZMod p) M` fail as "typeclass instance problem is stuck, it is often due to metavariables" (the printed problem holds none); with `haveI` the same line elaborates. Use `haveI` unless a proof must unfold the action; a lemma that takes its instances by unification is not affected (`data/fs131/in1/probes/rank.lean`; FS131-IN1).
- `ConstantInfo.value?` is `none` for a theorem at the pin: a tool that walks proofs reads `.thmInfo v => v.value` (`data/fs131/in1/lean/AxiomsCore.lean`, which names the leaf each `sorryAx` comes from; its first version found no source for any, and the check was red until it did) (FS131-IN1).
- A worktree cut for one module of a line may hold no `.olean` of the line's upstream modules: `lake env lean` then stops at the first import. Without a build: real copies of the import closure's `.olean`s from the tree that built the skeleton, the modules whose source differs recompiled into the copy from this tree's source with `lean -o`, and `lean` run with that directory in front of Lake's path with the tree's own library taken out (`data/fs131/in1/farm.sh`, `lean1.sh`) (FS131-IN1).
- At the pin: `Pi.ringHom` is deprecated for `RingHom.pi`; a sum minus one term is `Finset.sum_eq_sum_sdiff_singleton_add`; `AddSubmonoidClass.coe_finset_sum` is deprecated for `AddSubmonoidClass.coe_finsetSum`; `Cardinal.nat_lt_aleph0` for `Cardinal.natCast_lt_aleph0`. A finite ring's residue fields: `IsArtinianRing.quotNilradicalEquivPi` is an `A`-algebra equivalence, so `e (mk a) = fun I => mk a` is `e.commutes a`. "Finite rank over `ℤ`, so `M/NM` is finite" has no single lemma: at a prime `rank_le` over `ZMod p` with `LinearIndependent.iff_fractionRing ℤ ℚ`, and `Submodule.finite_quotient_smul` for a product (FS131-IN1).
- A statement printed by a footer on a copy and the same statement dumped from the compiled module differ only in binder names minted in the file (`inst._@.<module>.<n>._hygCtx._hyg.<k>`): rewrite the file's own module names and no other — a hygienic name minted in Mathlib (`x._@.Mathlib.Data.FunLike.Basic…`) is the same from every path — and compare Lean's hash unrewritten; with the rewrite off the differences must be exactly the statements it touches (`data/fs131/id1/statements_built.py`; FS131-ID1).
- An exhaustion over residues is priced by its modulus before its instrument: `8⁵·2` tuples of `ℕ` arithmetic under `decide +kernel` are 10.6 s and 5.1 GB; a square modulo 8 is read from the residue modulo 4, and the same statement over `4⁵·2` tuples is under a second (`Arith/DyadicQuadratic.shapeCheck`; `data/fs131/id1/probes/decide_cost.lean`; FS131-ID1).
- `omega` reads `Int.natAbs`: after `rw [Int.natAbs_mul]` the term `Int.natAbs 2 * N.natAbs` is a product of two atoms to it; state `(2 * N).natAbs = 2 * N.natAbs` as a `have` and rewrite with that (FS131-ID1).
- A functional that must not vanish on the norm-one elements of a nine-element field with conjugation needs no coordinates: `x ↦ −(x + x̄) + ι(x − x̄)` (`ι² = −1`) is fixed by conjugation, and a zero `u` of norm one has `u² = −ι`, so `u⁴ = −1` against `u·ū = u⁴ = 1` — three `linear_combination`s (`ThreeFourColours.nine_functional_ne_zero`, FS131-KJ1).
- The size of a residue field at a prime over 2 comes from the absolute norm with no order described: `Ideal.absNorm_span_natCast`, `Ideal.absNorm_dvd_absNorm_of_le` and `(1 + i)² = 2i` give `|𝓞 ⧸ P|² ∣ 2^[K:ℚ]` (`exists_stablePrime_card_four_sqrt`, FS131-KJ1).
- A queued build has read nothing: while `build.sh`'s log is empty the module it compiles last can still be replaced and committed; once its first line is printed, later text goes to a copy under `data/` (FS131-KJ1).
- A join of branches whose library differs from a gated tree in a few modules need not recompile the rest: `rsync -a --checksum --delete` of the gated tree's `.lake/build`, a second dry run that itemizes nothing, and Lake's trace check (`data/fs131/kj1/copy_build.sh`, FS131-KJ1; inventory item 694's condition).
- Between Mathlib `v4.32.0` and `v4.34.1` `Measure.map` changed: at `v4.32.0` the push-forward by a map that is not almost-everywhere measurable is `0`, at `v4.34.1` a measure of the same mass; and `ProbabilityMeasure.map (ν) {f} (f_aemble : AEMeasurable f ν)` there takes only `(f)`. A text written at the later pin names the same object here as `ν.map (f := g) h` and `⟨μ.map g, isProbabilityMeasure_map h⟩` (FS131-KO1).
- Importing `Mathlib.Order.CompletePartialOrder` reroutes the `SupSet` of a `⨆` in a complete lattice through `CompletePartialOrder.toSupSet`: four stored statements of this library moved, instance arguments only, when a module saw it; a port leaves it out of its imports (FS131-IE1, FS131-KO1).
- `convert h using 1` can leave two goals at the pin where the source's pin left one; run the source's closing tactic with `all_goals` (FS132-I2, FS131-KO1). `isAlgebraic_natCast` is `isAlgebraic_nat` at the pin.
- `#eval` holds what it prints in a captured stdout and emits it at the end, so a dump of hundreds of MB never finishes: re-point stdout at a file for the loop (`IO.setStdout (IO.FS.Stream.ofHandle h)`; `data/fs131/ipd1/readback/laneD/ReleaseDumpFile.lean`). A definition's value printed as a tree can be millions of nodes (`LabelModel.representation`: 5.5 million) (FS131-IPD1).
- A private declaration of another module is nameable in a `section` that opens it with Batteries' `open private <name> from <module>`; `#print axioms` then prints its full private name (`scripts/Axioms.lean`'s port block; FS131-IPD1).
- A declaration takes one attribute block: `@[a]` on one line and `@[b]` before the keyword on the next does not parse; merge (`@[nolint simpNF, simp]`). `@[nolint <linter>]` attaches to an anonymous instance, and the linter's name must be declared where the attribute is elaborated (`data/fs131/lp1/nolint/probes/attrs.lean`; FS131-LP1).
- Between Mathlib `v4.32.0` and `v4.34.1`, further: `Isometry.lipschitz` became `Isometry.lipschitzWith` (2026-08-16), `isAlgebraic_rat` became `isAlgebraic_ratCast` (2026-07-14), and `summable_norm_of_tsum_eLpNorm_ne_top` lost its measurability hypothesis (here it is asked: `fun n => Lp.aestronglyMeasurable (g n)`). `∫ (↑(f x) : ℂ)` is `integral_complex_ofReal`; `integral_ofReal` is stated for the `RCLike` coercion and does not rewrite it (FS133-IA1).
- A cone computed for part of a release file can name a generated proof of a declaration outside it: the release's elaborator shares `X._proof_n` between declarations of one file (`LabelModel.projected._proof_1 : IsTopologicalAddGroup ℂ` in four declarations of `BorelTransfer.lean`). Print its stored statement at the source's pin before deciding; a proof of a Mathlib proposition needs no port (FS133-IA1).
- At the pin the kernel is called synchronously by `Environment.addDeclCore env 0 decl none` (its check on by default); there is no `Environment.addDecl`. `ConstantInfo.value!` panics on a theorem at v4.34.1: read a value by cases (FS133-IA1).
- On the regular representation `(U z f) x = f (x + z)`, the rotations that satisfy `W k ∘ U z = U (k z) ∘ W k` act by the inverse on the points, `(W k f) x = f (k⁻¹ x)`; on a plane system, where `τ z ∘ ρ u = ρ u ∘ τ (u z)`, the Koopman operators compose with `τ z` and `ρ u` themselves (FS133-IA1).
- Weak limits of probabilities need no metrizability of `ProbabilityMeasure X`: Mathlib's Portmanteau lemmas (`ProbabilityMeasure.limsup_measure_closed_le_of_tendsto`, `…tendsto_measure_of_null_frontier_of_tendsto'` with `IsClopen.frontier_eq`) and `ProbabilityMeasure.tendsto_iff_forall_integral_tendsto` are stated for any filter, so a cluster point is taken along `Ultrafilter.of atTop` by `isCompact_univ.ultrafilter_le_nhds`, and a closed class of probabilities is shown closed by `isClosed_iff_forall_filter`. `CompactSpace (ProbabilityMeasure X)` needs `Mathlib.MeasureTheory.Measure.Prokhorov` (FS133-IB1).
- A common fixed point of commuting continuous maps of a compact space on a closed class of probabilities, with no Markov–Kakutani: one map by Cesàro averages (`OneClass.exists_fixed_of_average`, private), then `IsCompact.inter_iInter_nonempty` over the closed sets of fixed probabilities, the finite case by induction on the `Finset` (FS133-IB1).
- A Følner sequence of any countable commutative group by polynomial growth: the images of the boxes `[0, N]^Z` have at most `(N + 1)^#Z` points, so some step grows by at most `1 + ε` (`tendsto_pow_const_div_const_pow_of_one_lt`); no basis (`OneClass.exists_foelner_finset`, FS133-IB1).
- `measurable_pi_apply g (measurableSet_singleton true)` does not elaborate against `MeasurableSet {I | I g = true}`, nor `IsClosed.preimage` against a set-builder: the elaborator does not unify a preimage with a `setOf`. State it as `show MeasurableSet ((fun I => I g) ⁻¹' {true}) from …` (FS133-IB1).
- A section's `variable [MeasurableSpace Ω]` enters every theorem whose statement names `Ω`, though the definition the statement is about does not take it; with a `sorry` body the `unusedSectionVars` linter is silent and with a proof it warns, so a skeleton can carry an unread instance binder that only its proof shows (`Plane.sectionDensity_univ`; `omit … in`, FS133-IB1).
- `obtain ⟨…⟩ := f ?_ … ?_` lost its `?_` goals here (the next bullet read 'no goals'); `suffices` the destructured form, then `refine f ?_ … ?_`, keeps them in order. `integral_indicator_one` is not in the closure of `Mathlib.MeasureTheory.Integral.Bochner.Basic`; `integral_eq_lintegral_pos_part_sub_lintegral_neg_part` is. At the pin `lintegral_finset_sum`, `integral_finset_sum_measure` and `Measure.coe_finset_sum` are deprecated for `lintegral_finsetSum`, `integral_finsetSum_measure`, `Measure.coe_finsetSum` (FS133-IB1).
- A point mass on `E → Bool` sees single labellings only when the index set is countable: `ae_dirac_eq` asks `MeasurableSingletonClass`, which `Pi.instMeasurableSingletonClass` gives from `Countable E`; with an uncountable index set a product-measurable set depends on countably many coordinates and `{I | ∃ z, I z = true}` has point-mass one at the empty labelling. `Countable` of the algebraic numbers with no `Mathlib.Algebra.AlgebraicCard`: `ℚ[X]` injects into `List ℚ` by the first `natDegree + 1` coefficients, and each algebraic number is in `p.rootSet ℂ` for a nonzero `p` (`Polynomial.rootSet_finite`, `Polynomial.mem_rootSet`; `OneClass.countable_algPlane`, FS133-IB2).
- `fun J => G.IsIndepSet (J : Set E)` as a `Finset.filter` predicate on `S.powerset` elaborates `J : Set E` from the ascription and the filter then fails ('expected `Finset (Set E)`'): annotate the binder, `fun J : Finset E => …` (FS133-IB2).
- An implementer's working module that imports a module it has just changed cannot be elaborated by `lake env lean` until the build recompiles the import; a farm (a symlink copy of the tree's `.lake/build/lib/lean`, the changed module compiled with `lean -o` over its removed symlink) elaborates it in seconds with the build's own library untouched (`data/fs133/ib2/farm1.sh`, FS133-IB2).
- A module that opens `SimpleGraph` reads `ball` as `SimpleGraph.ball`: write `Metric.ball` there (the error is a type mismatch at the centre, 'expected `SimpleGraph ?`') (FS133-ICD1).
- A private lemma whose statement filters a `Finset` by an undecidable predicate needs `open Classical in` above it; a proof that calls it after `classical` elaborates the same instance (FS133-ICD1).
- Core's names for `a % b + a / b * b = a` are `Int.emod_add_ediv_mul` and `Int.mul_ediv_add_emod`; there is no `Int.emod_add_ediv` or `Int.ediv_add_emod` at the pin (FS133-ICD1).
- `Plane.muPer`'s definition records a grid side and a period with no relation between them; the construction of `eventually_le_muPer` has the pixel `1/M` dividing the period `ℓ + 2`. A consumer that counts translates of a periodic grid union reruns the construction (`OneClass.exists_fold_cover`) (FS133-ICD1).
- The brick seven-colouring `sevenBrick.color` is Borel and proper at every pair: a table read at two floors of affine functions (`Int.measurable_floor`, `measurable_of_countable` on `ℤ × ℤ`, `Brick.avoids` at `q = 1`); `Plane.r7Col` is proper only almost everywhere (FS133-ICD1, `exists_admissible_colourPattern_seven`).
- A function from `ℂ` to a finite type is Borel with no case analysis when it factors through a measurable map into `Λ → Bool`: `measurable_pi_iff`, `measurable_to_bool` for each coordinate, then `measurable_of_finite` for the function out of `Λ → Bool` (`OneClass.exists_measurable_admissibleAe`, its choice of a label by `Exists.choose`) (FS133-IPQ1).
- Positivity of a product measure from its slices in the second factor, with no measurability: `(Measure.measurePreserving_swap).quasiMeasurePreserving.preimage_null` pulls a null set of `ℂ × ℝ` back to `ℝ × ℂ`, and `Measure.measure_ae_null_of_prod_null` reads its sections (`OneClass` Pair's `prod_pairs_ne_zero`) (FS133-IPQ1).
- `IsClosed.preimage` with a continuous map into `Λ × Λ` built inline by `(continuous_apply x).prodMk …` fails to unify the product's topology when `Λ`'s topology is a `letI`; name the map with its type ascribed (`Continuous (fun m : E → Λ => ((m x, m y) : Λ × Λ))`) and apply that (FS133-IPQ1).
- A join that brings a port can turn a simp argument of a proof that stays unused: the port's `@[simp]` lemmas enter every module downstream of it, and a fact a proof gave `simp` by hand is found by `simp` itself — the build's `unusedSimpArgs` warning, which the gate's zero-warning line reads. `simp?` on a copy names the lemmas that took over (`Spectral.kCoeff_inv`, `kCoeff_ne_zero`, `Outside/OAI158Basic`; `residual_fourier_model`, FS133-LD1).
- Across a join that deletes copies and reads a port's declarations, a statement dump made per module loses the moved constants: dump the old modules' every constant before the merge and, after it, the same names found where they are now declared (`env.getModuleIdxFor?`), then compare by name with the moves, the axiom proved and the instance-only values ruled (`data/fs133/ld1/lean/StatementDump.lean`, `tools/fs133_ld1_moved.py`, FS133-LD1). A statement with two instance binders prints both `inst`; a dropped one is named by its occurrence (`inst#2`).
- A structure taken as a hypothesis whose only model is the projection of a child structure's model (`(isInvariantLaw_dirac G).toIsShiftInvariantLaw`) reads `undeclared-never-concluded` to the assumptions step: no declaration concludes it as stated. Declare it a `.condition` with that model in its reason (`OneClass.IsShiftInvariantLaw`, FS133-LD1).
- A list literal of 4,669 `(Nat × Int)` pairs with negative entries exhausts 200,000 heartbeats in elaboration and, with the limit off, `maxRecDepth` after 110 s; the same data as 4,669 packed `Nat`s (`mask + 2²³·(c + 2⁶⁸)`) under `set_option maxRecDepth 100000` elaborates in about 5 s (FS131-KDB1).
- Mathlib's `Real.circleAverage f c R` (`Mathlib/MeasureTheory/Integral/CircleAverage.lean`) carries constants, monotonicity, `|·|`, sums and `circleAverage_eq_integral_add`; defined through it, `|J₀| ≤ 1` is 14 lines. Mathlib has no Bessel function (FS131-KDB1).
- The micro sign `µ` (U+00B5) is not an identifier character ("expected token"); Greek `μ` (U+03BC) is (FS131-KDB1).
- Gaussian regularization on the Fourier side needs no Gaussian normalization: `Real.tendsto_integral_gaussian_smul'` (the peak-function limit), carried to `∫ e^{−‖ξ‖²/a + 2πi⟨z,ξ⟩} 𝓕f(ξ)` by `VectorFourier.integral_fourierIntegral_smul_eq_flip` and `fourier_gaussian_innerProductSpace'` as in Mathlib's own inversion proof, then dominated by `|Φ(z)| ≤ Φ(0)` for a nonnegative weight (`Plane/DensityBound/Autocorr`, FS131-IDB2).
- A `2π`-periodic `g : ℝ → ℝ≥0∞` has `∫⁻ θ in Ioc 0 (2π), g (θ + α) = ∫⁻ θ in Ioc 0 (2π), g θ` with no finiteness: `AddCircle.lintegral_preimage` for `g` and for `g (· + α)` (each the lift by `Function.Periodic.lift`), then `lintegral_add_left_eq_self` on `AddCircle (2π)`, whose `MeasureSpace` needs `Fact (0 < 2π)` in scope (`Pattern.lintegral_Ioc_shift`, private; FS131-IDB2).
- `- c⁻¹ * ‖w‖ ^ 2` with `c : ℝ` elaborates in `ℂ` as `-↑(c⁻¹) * …`, and `Real.tendsto_integral_gaussian_smul` states `(π * c)` as one real coerced where the primed lemma states `(π * c : ℂ)`: Mathlib's closing `congr` for one does not close the other — rewrite `Complex.ofReal_inv`, `div_inv_eq_mul` and the exponent by `ring` (FS131-IDB2).
- `simp` turns `MeasurableSet {p | True ↔ f p ∈ E}` into `Measurable fun p => f p ∈ E` (`measurableSet_setOf`): state the set as `f ⁻¹' E` by `ext; simp` and rewrite before using `hE.preimage`. `two_mul` in a `simp` set rewrites every `2 * π` to `π + π`; close such goals by `ring` instead (FS131-IDB2).
- `Nat.testBit_lor`, `Nat.testBit_land` are Mathlib's (`Mathlib/Data/Nat/Bitwise`), outside a module that imports only analysis; core's `Nat.testBit_or`, `Nat.testBit_and`, `Nat.testBit_xor`, `Nat.testBit_two_pow`, `Nat.testBit_shiftRight` and `Nat.zero_testBit` are in scope everywhere. `List.getD_map`, `List.getD_eq_getElem` and `List.sum_map_neg` are not in that closure either: `List.getD_eq_getElem?_getD` with `List.getElem?_map` is (FS131-IDB3).
- `simp` rewrites `1 &&& U = 1` to `U % 2 = 1` before a hypothesis stated about the first form can fire: close such case splits with `rw [if_pos h, if_pos (this.2 h)]`, not `simp [h]`. A `set U := maskOf S` hides `maskOf S` from a lemma stated at it: instantiate the lemma as a `have` at `U` and give that to `simp` (FS131-IDB3).
- `induction` on a `List.Forall₂ R (f x) (g x)` fails ("index in target's type is not a variable"): state what is needed for arbitrary lists as a lemma (`X23Check.forall₂_exists_left`, `_right`) and apply it (FS131-IDB3).
- In a core-only checker, `Bool.rec` in a `def` is refused by the code generator; `bif … then … else …` (`cond`) is what the kernel and the compiler both take (FS131-IDB3).
- A join with no conflict in git can still declare one name twice: two lines that each define `Plane.mOne`, in modules that do not import each other, merge in silence, every module compiles, and only the root fails, after the whole walk (`environment already contains 'HadwigerNelson.Plane.mOne'`); `scripts/dupnames.sh` cannot run until the root builds. Before a join's first build, list every constant of the incoming modules and of the other line's library and intersect them by name (`data/fs131/ldb1/lean/MainNames.lean`, `collisions.out`; FS131-LDB1).
- An import added at a join moves stored types downstream by instance alone: `Plane/OneClass/Defs` brings the port's `CommCStarAlgebra ℂ` into `Plane/DensityBound/Window`'s closure, and two of its theorems then store `NormedCommRing ℂ` through `CommCStarAlgebra.toNormedCommRing` (three places each). Rebuild the old type from the new by replacing that one instance term (`Expr.replace`), check its hash against the dump made before, and have the kernel accept `Eq.refl new : old = new` with `Environment.addDeclCore`, a mismatched pair refused (`data/fs131/ldb1/lean/InstanceCheck.lean`; FS131-LDB1).
- An audit block is checked for coverage as well as for its records' axioms: follow every constant the records' stored types and values name, within the landed modules, and require each public constant to be a record or reached (`data/fs131/ldb1/lean/Coverage.lean`: 723 records reach the other 1,767 of 2,490 public constants); its control removes one implementer's records and must see each reported — removing by name prefix missed one (`dists_ok`) that reached 36 others (FS131-LDB1).
- A former whose docstring calls it a named hypothesis, or external, fails the assumptions step as undeclared once a theorem proves it (`undeclared-by-docstring`): the landing that proves it rewords the docstring, and its closed takers then read `CLOSED ESTABLISHED` (`Plane.OneAvoidingDensityBound`, FS131-LDB1).
- A generator with no `--check` mode is checked by rewriting its modules in place and requiring `git status` clean (`tools/fs131_idb1_cells.py chain`, `modules`; `tools/fs131_kdb1_x23.py --write`: the covering's 48 modules and the certificate's 23 byte for byte; FS131-LDB1).
- `Expr.hash` reads no binder name: a non-dependent binder a landing drops is checked by putting it back with `mkArrow` inside `forallBoundedTelescope` and comparing the hash with the type dumped before (the headline's `362919061`, equal; a `True` in its place differs) (`data/fs131/lch1/lean/ReAdd.lean`; FS131-LCH1).
- Making a private declaration public renames every internal constant under it (`avgMeasure._proof_1`), and every stored value that names one moves: a comparison renames back by prefix (`Name.replacePrefix`), not by the declaration's name alone (FS131-LCH1).
- A corollary of a theorem cannot live in a module the theorem's module imports: check the direction before placing it (`Plane/DensityBound/Window` imports `Plane/OneAvoidingDensity`; FS131-LCH1's `Plane/MOneBound`).
- `set X := <a type> with h` re-states every hypothesis whose type mentions it. A Finset over the old type stays as `s✝`, and a later `Fintype.card` is then elaborated at another instance than an earlier term's. Write a type out where hypotheses mention it (`CertLink.card_le_of_fibreShareBound`, FS131-IKL1).
- An induction hypothesis applied to a proof about a set that is defeq but differently named (`levelSet P m` against `normOneSet P m`) builds its `Finset` on the other name, and `linarith` reads two atoms. Ascribe the `have` in the goal's words (`have hih : ‖∑ t ∈ hfin'.toFinset, ψ' t‖ ≤ … := ih hfin' ψ' hnew`) (FS131-IKL1).
- `rw [pow_succ]` in a goal that mentions an ideal power `P.P ^ (n + 1)` inside a quotient type rewrites that too, and fails with "motive is not type correct": name the base, `pow_succ (Q : ℝ) n` (FS131-IKL1).
- A scratch check of a module that another job owns compiles a copy *as that module*: `lean -R <root>` on `<root>/Proofs/…/X.lean`, into a farm (a symlink copy of the compiled library). Every constant the copy stores is then compared with the real module's dump, since hygienic and private names carry the module name (`data/fs131/ikl1/farm.sh`, `tools/fs131_ikl1_scratch.py`, `tools/fs131_ikl1_statements.py`; FS131-IKL1).
- An audit block for a landing is generated from the kernel's print of every record of the landed modules (`data/fs131/lgt1/lean/AxiomsAll.lean`, `tools/fs131_lgt1_audit_block.py`), less the records already filed, and the lines' own drafts are a cross-check, not the source: at the five-colour chain's landing they named 1,204 of the 1,439 records; the other 235 — helpers, certificate data, and 27 definitions of a `main` module no landing had listed — were found only by the print (FS131-LGT1).
- A declared `.condition` goes stale when a landing brings a theorem that concludes it (`stale-condition`, 'the entry is not needed'): retire the entry (`SpectralChain.TCA`, `IsTraceSpectral`, `SpectralInputs.IsHaarFourier`, `IsSpectralMeasureOf`, FS131-LGT1).
- The audit's self-test reads the library's state in two controls (`baseline`, `imported_declared`: the imported count, the declared imports): a landing that declares an import or adds imported records turns it red until the controls are moved by `scripts/axioms-controls.txt`'s own rule — FS131-LCH1's join declared `positive_entropy_rigidity` and the self-test was not run on it; run it before the full pass (FS131-LGT1).
- In the assumptions step's digest, lines `- FAIL …` under 'changes since the previous complete run' are rows that have gone, not failures: read the count from the step's own `FAIL — n check(s)` line (FS131-LGT1).

## The package

The **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat import surface, modules under `Proofs/`),
with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib** is pinned to tag `v4.32.0`. `scripts/Axioms.lean` is the trust receipt.
The module map is `ARCHITECTURE.md`, checked against the import graph by `tools/check_architecture.py`; a new module goes into the map
in the same commit.

When adding a library or executable, changing dependencies, or bumping Mathlib, work through the **`debruijn-init`** skill, freshly
invoked. `lake update` and Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

## The gate

Elaboration is the floor: the build green, zero `sorry`, `#print axioms` clean on the public surface (`scripts/axioms.sh`), no name declared by two modules (`scripts/dupnames.sh`, run before the audit, whose prints are faithful only then), and `./scripts/axioms.sh --self-test` green (23 planted faults, each watched to fire, two of them partners that must pass), `./scripts/assumptions.sh` and `./scripts/assumptions.sh --self-test` green (21
controls planted in one copy of the audit, 33 checks), linters
silent, spec examples passing. On top of that, the statement-level gate, because a formalization that proves the *wrong* theorem is
the characteristic failure here:

- **`./scripts/vacuity.sh` and `./scripts/vacuity.sh --self-test` are green** — no theorem is a `∀` over an empty domain. Vacuity is
  undecidable, so the check **requires evidence**, as `axioms.sh` requires every purchase to be declared. **The law:** a statement is
  vacuous exactly when some `∀`-binder has an empty domain; `(C : G.Coloring α)` is the dangerous binder, a `Forces` binder is a
  possible *overclaim* instead, and a declaration concluding `False` — `False` as stated, so `P → False` is one and `¬ P` and `a ≠ b` are not: their binders are audited like any other's — is a refutation and is skipped. **Verdicts:** `WITNESSED`
  (inhabitant proved); `DECLARED` (deliberate emptiness, named with its reason in the docstring as `VACUITY DECLARED:` and printed every
  run); `VACUOUS` (undeclared emptiness) and `STALE` (claimed emptiness not proved), which fail unconditionally before the baseline;
  `GENERIC` (parametric, where **no inhabitant witness can exist** — the caller's obligation); `UNKNOWN` (counted, never silent, and the
  only thing the baseline may hold). **The marker is for a declaration one of whose binders has a provably empty carrier**; the scan reads it binder by binder, and on
  a binder whose carrier is not empty it reads `STALE` and fails. A route lemma whose hypotheses are *jointly* unsatisfiable — each
  satisfiable alone — does not carry it: its docstring says the joint vacuity in words and names the theorem that derives `False`
  from its exact hypotheses (`v6_hubs` with `v6_hubs_vacuous`, FS131-L8A). A statement that concludes `False` is skipped as a
  refutation, so a marker on it is never read and proves nothing either way. **An import can empty an older statement's domain, and no scan sees it.** A landing that brings an `axiom` refuting a carrier (`¬ ∃ c, …`, `¬ Colorable k`) reads the scan's sites and the assumptions step's declared hypotheses for that carrier: a statement whose hypothesis is empty only given a declared import says so in words in its docstring, naming the import and the theorem that shows it, and no `IsEmpty` statement or marker rests on an import until the tooling job rules how such emptiness is counted (`hexShell_plane5` given `Outside.OAI158.no_proper_five_coloring`, FS132-L1). **The scan is silent on a module whose colourings are maps under a predicate it does not track** (`WeakColoring k c`, `ProperColoring k c`): the landing of FS-132's first theorem added 447 declarations and no site. Silence is not evidence; the landing names, for each structure of hypotheses, its model and whether the kernel holds it (FS132-L2, its record's stage 7). A landing whose modules are consumed through a predicate on maps (`IsWeakColouringOn U c`) names in the same way the parameter at which each hypothesis is inhabited, open, and empty given an import (FS124-L1, its record's stage 6: seven, six, five). The count `refutations-skipped` holds statements that refute nothing: a conclusion that is an inclusion in a complement (`⊆ (closedBall q 1)ᶜ`) is read through to `→ False` and the declaration skipped (`CircleSide.ball_antipode_subset_outside`, FS124-L2); a landing reads each skipped declaration of its modules. A module that takes the library's tracked carrier is not silent: the binder `(a : AeColouring k)` reads `GENERIC` (six sites in `Plane/LebesgueNumber`), which is the scan saying the parameter is the caller's; the landing says by hand at which `k` the carrier is inhabited, empty given an import, and open (FS131-LC1, its record's stage 5: seven and nine; five and below; six). A module whose theorems range over number-theoretic structures (a usable prime, a conjugation-fixed prime) and whose one colourability hypothesis is `Colorable k` of a finite graph adds declarations and **no site**: the scan is silent on it, and the landing names each structure's kernel model and says whether it is a library theorem or a term (FS131-LU1, its record's stage 5: `ℚ(√11)` at 7; the prime of `ℚ(i)` above 2, the one inhabitant of the two-colour theorems' hypothesis). The counts and the baseline's two entries are recorded in `CLAUDE.md` § The gate, where
  `scripts/gate_report.py` reads them; a silent change in them is this gate's own failure mode. `--self-test` plants sixty-five controls
  and watches each fire; the load-bearing one — the same carrier family at an instantiation nothing refutes — must read `UNKNOWN`,
  never `VACUOUS`.
- **The environment linters** are `lake lint --no-build -- --no-build --trace` under the slot (about 5 s, 4.8 GB): Lake's
  `--no-build` exits instead of rebuilding the driver, the driver's exits instead of building the library, and `--trace` prints
  one verdict per linter. Green is exit 0, `-- Linting passed for Proofs.`, and every linter `(2/2) Passed!`. An unused argument
  named with an underscore, or referenced by `have _ := h`, is not reported; an unused anonymous instance binder is, and the
  build's own linters do not warn about it.
- A port's own text meets the linters as the source wrote it: 25 findings in the release's family 158 (its names with underscores, its unused binders, one `@[simp]` lemma simp rewrites) are silenced in the file by the generator's `nolint` table, each by name with its reason class, and the lint's planted control is run again outside the port after (FS131-LP1). A read-back across pins whose prints run to gigabytes is read block by block, never whole (`ruled_compare_stream`, within 8 GiB where the whole read took 20), its equivalence with the whole read shown on every small label and its self-test planted into the stream; a planted control whose failure cannot be reached on a label (a rule idle there) is reported UNREACHABLE with the count that shows it, never counted as passing (FS131-LP1).
- **Every gate keeps what it computed — read it before re-running one.** `build.sh`, `axioms.sh`, `vacuity.sh` and `lean4checker.sh`
  save their tool's complete output under `build/gate/<gate>/` (`latest` is the last complete run; `scripts/gate-log.sh`) — a run that failed on a planted fault is a complete run: after a control planted in a gate's own input (the wrong filing in `scripts/Axioms.lean`), `latest` is the planted run until the gate is run again, and a tool reading it reads the plant (FS124-L1: `tools/fs124_l1_records.py` refused that log, as it should) and print a
  digest: every count, whether the counts recorded in `CLAUDE.md` still match, every flagged or declared row in full, and every row
  that changed since the previous run (`scripts/gate_report.py`). `regen-check.sh` keeps each step's log in its scratch directory.
- **Every theorem whose hypothesis is a structure** (a colouring, an embedding, a certificate, a homomorphism) **ships a named
  inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a
  Prop-valued hypothesis of a theorem concluding `False` is skipped by the vacuity scan, so a degenerate model where a clause is vacuous
  (a one-colour map for a condition on points of two or more colours) proves nothing — such a hypothesis can be unsatisfiable on every
  real instance and the gate stays green. **The inhabitant satisfies every hypothesis the theorem does not refute, at once, at a parameter the refutation leaves alive** — for a
  refutation at `k ≤ 5` colours, a model at `k = 7` on a plane map; a model of one hypothesis on an object where another fails (a disc for
  a theorem about plane maps) is not a model of the theorem. Where none is expected (a step inside a proof by contradiction), the docstring
  says so with the theorem that refutes the configuration.
  **A note names an object only for the hypotheses that object satisfies**: 'inhabitant of the hypotheses' is a claim and is
  checked like one — a fragment that does not cover the unit disc about its vertex is no model of a theorem assuming `F.Covers v 1` (FS131-QA4:
  seventeen notes named `bowtie` there). **Where the hypotheses' satisfiability is the open question at the stated parameter** (a valid six-map of the
  plane; a stuck vertex in a terminal plane map), the docstring says so, names the question, and names an object satisfying the local hypotheses at
  once together with the hypothesis it fails.
- Every definition has a `#eval`/`example` that would fail if it drifted.
- **`./scripts/dupnames.sh` and `./scripts/dupnames.sh --self-test` are green** — no name is declared by two modules. Two modules,
  neither importing the other, that each declare a theorem of one name and type build in silence: at import Lean accepts the second
  constant when both are theorems of one type (up to bound-variable names), a theorem and an axiom of one type, or two axioms of one
  proposition (`Lean/Environment.lean`, `subsumesInfo`, v4.32.0), and refuses only otherwise (two definitions, even identical; types
  that differ). The build sees a doubled name only when one module is upstream of the other — and not even then for an anonymous
  instance, which gets a fresh name. **Measured** (`data/fs131/t4/experiment-table.md`): the environment then holds the proof of the
  module imported **last**, and `#print axioms` reads the axiom list stored by the module imported **first**
  (`Lean/Util/CollectAxioms.lean`: one list per declaration, written with each `.olean`) — never the same copy. So the axiom audit
  can print a record clean while the proof the environment holds rests on `sorry`, on an axiom or on a native purchase, and an
  `axiom` shadowed by a theorem of its name is absent from `libraryAxioms`. The print of an imported theorem is the list stored when
  its own module was compiled, whatever else is imported. No statement gains a proof it lacks — a clean list belongs to a copy that
  is a clean proof of the same type (an argument, one mind; no experiment can show it) — what is lost is the audit's faithfulness to
  the proof the environment holds. With no name declared twice, every module saw one copy of each name, so each stored list is the
  list of the proof the kernel checked. The scan reads each module's own compiled constants (`scripts/DupNames.lean`), so it sees
  what no scan of the source can: a `Prop`-valued instance is a theorem to the kernel, and two siblings' `instance : C T` merge in
  silence under one generated name. One class is counted and listed without failing: theorems Lean generates on demand in whichever
  module asks (`f.eq_1`, `f.congr_simp`; reserved names, which no author can declare) — failing only if their copies' axioms differ.
  `--self-test` plants fifteen controls in a scratch library (`scripts/dupnames-controls.txt`). **A join of two lines runs it on the
  joined tree, before the axiom audit**: the join makes the doubled name, and neither line's own gate can see it.
- **`./scripts/assumptions.sh` and `./scripts/assumptions.sh --self-test` are green** — everything a theorem rests on
  that the kernel did not check is listed, in both forms it takes. An outside theorem declared as an `axiom` shows in
  `#print axioms`; a hypothesis does not — a theorem that says "if Herglotz–Bochner holds, then …" prints the standard
  three — so `scripts/Assumptions.lean` reads every hand-written statement as the kernel holds it and prints every
  library axiom with the theorems whose stored axiom lists hold it (`RESTS`), and every declared hypothesis with its
  kind (`outside`, `ours`, `open`), its source and the statements that take it (`TAKES`, `MENTIONS`). Whether a
  hypothesis is an assumption or a condition on the theorem's parameters is intent, which no type records, so the
  check **requires evidence**: the one list is `AssumptionAudit.declared`. **It fails** on a *closed* hypothesis (no
  free variable: a statement about the world) that is neither declared, nor proved by the library, nor the one claim
  a refutation refutes — a closed family `∀ F, … → H F` of a declared `H` included: the binder is declared as a site;
  on a `Prop`-former taken as a hypothesis that no theorem concludes, or that is concluded only from declared
  assumptions, or whose docstring uses the words "named hypothesis", "outside the backlog" or "external", when neither
  list holds it; on a source that is not in `BIBLIOGRAPHY.md`, `LEDGER.md`, the grokkings, the stubs or the
  derivations; on a declared kind its docstring contradicts; on a declared hypothesis no statement takes, or — **a named hypothesis only** — one a theorem proves over its own variables (`FAIL discharged`); **an assumption written out in a binder and declared by `.site` is retired, as it is declared, on the landing's own word**: the step compares no binder's type with any theorem's conclusion, so it passes with a discharged entry left in (`hUpper` of `SpectralChain.chromaticNumber_eq_localBound`, proved by `UpperHalf.chromaticNumber_planeOver_le_localBound` and retired by FS131-LU1 — its record's stage 4 has the receipt); on any consumer that `scripts/assumptions-ledger.txt` does not list, or lists
  and the scan does not find; and **when the nine counts are absent from `CLAUDE.md` § Trust ledger** (a recorded count
  whose deletion passes is no record; counts that have drifted are flagged, not failed). **It counts and prints, and
  cannot decide**: the other hypotheses of every consumer (`COHYP`), and `unseen=` — every other hypothesis over a
  theorem's own variables, among which a hand result written out in a binder, undeclared and unremarked in its
  docstring, is not told from a condition. **A former proved at the instances where it is taken closed** (not over its
  own variables) is not reported: its entry leaves on the landing's reading, its docstring is reworded to say over what
  it is proved, and its closed takers then read `ESTABLISHED` (`StandingFive.StandingFloor`, FS131-LT5). A declared hypothesis that a declared import implies — its binder ranging over a domain the import empties — keeps its kind and says so in its source string until the tooling job classes such an entry (`inline:SixTarget`, `inline:SixTargetOneTwo`, FS132-L1); the step cannot find one: no theorem states the binder. The nine counts
  are recorded in `CLAUDE.md` § Trust ledger and in the ledger's header, where `scripts/gate_report.py` reads them. A structure of hypotheses that no library theorem concludes fails as `undeclared-never-concluded` even when every use is a condition on the theorem's own variables: the module ships a theorem concluding it at its model, or the landing declares a `.condition` and says that no declaration exhibits one (`Plane.IsTriod`, `Plane.IsTriodCut`, FS124-L2).
- The Moser spindle's non-3-colourability is proved **twice** — by `decide` and through the SAT bridge — so the CNF encoding is
  checked against an independent oracle.
- The final statement is read against Mathlib's `SimpleGraph.chromaticNumber` and the informal claim, out loud, before it is believed.
- Each check's negative control: break what it guards, watch it go red and name the culprit, then put it back (`RUNNING.md` § Make the
  gate fail, and watch it fail).

The InfoView is continuous testimony at zero cost — save and read the goal state after every step rather than debugging by guess.
