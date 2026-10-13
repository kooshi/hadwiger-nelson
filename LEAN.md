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
     (`StandingFive.kloosterman_bound`, with `kloostermanBound_of_ringChar_ne_two` and `kloosterman_page_of_kloostermanBound`) Where the source is itself Lean, copy its definitions, state the axiom over the copies, and compare the stored terms across the two pins — every constant, instance, binder and universe level — with a control that fires (`Outside.OAI158`; `tools/fs132_i1_readback.py`, on a print made at each pin by one dumper); the landing runs it again on the module as recompiled on the joined tree. A copy carries the source's licence in its module docstring, with the text beside it (`Outside/OAI158`, since FS124-L1).;
  3. one model of its hypotheses — a `theorem` or `example` in the same file exhibiting an object that satisfies them;
  4. a line in `ARCHITECTURE.md` § Trust, as a declared purchase.
- **An outside Lean proof may be ported instead of imported** (`Outside/OAI158Palette`, `OAI158CircleMaps` … `OAI158States`; FS132-K1, FS132-I2, landed by FS132-L2): compute the cone of the wanted statements from the source's own compiled constants at its pin, copy those declarations by line range with a generator that refuses a patch to a statement or a definition (`tools/fs132_i2_port.py`), and build. The kernel then checks every proof here and no axiom enters. A read-back across pins (`tools/fs132_i2_readback.py`) is an instrument for "this is the source's lemma", never a gate on truth, and it cannot read "term for term": the same text elaborates against another Mathlib. It reports IDENTICAL, or identical up to instance and proof arguments with the differing constants recorded, under an explicit map of Mathlib's renames between the pins; what it leaves to trust is that Mathlib's instances for one class on one type agree at each pin. The landing runs it again on the joined tree. **A port carries the source's licence**: a byte-identical copy of its text beside the modules, written and compared by the generator, each header the notice of change. **An instance the source declares on a type that is Mathlib's is scoped here**, through the generator (the keyword; an instance declared in a child namespace needs `attribute [scoped instance]` in the parent, where its uses stand) — scoping changes no stored term, so the read-back prints the same bytes.
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
  refutation, so a marker on it is never read and proves nothing either way. **An import can empty an older statement's domain, and no scan sees it.** A landing that brings an `axiom` refuting a carrier (`¬ ∃ c, …`, `¬ Colorable k`) reads the scan's sites and the assumptions step's declared hypotheses for that carrier: a statement whose hypothesis is empty only given a declared import says so in words in its docstring, naming the import and the theorem that shows it, and no `IsEmpty` statement or marker rests on an import until the tooling job rules how such emptiness is counted (`hexShell_plane5` given `Outside.OAI158.no_proper_five_coloring`, FS132-L1). **The scan is silent on a module whose colourings are maps under a predicate it does not track** (`WeakColoring k c`, `ProperColoring k c`): the landing of FS-132's first theorem added 447 declarations and no site. Silence is not evidence; the landing names, for each structure of hypotheses, its model and whether the kernel holds it (FS132-L2, its record's stage 7). A landing whose modules are consumed through a predicate on maps (`IsWeakColouringOn U c`) names in the same way the parameter at which each hypothesis is inhabited, open, and empty given an import (FS124-L1, its record's stage 6: seven, six, five). The count `refutations-skipped` holds statements that refute nothing: a conclusion that is an inclusion in a complement (`⊆ (closedBall q 1)ᶜ`) is read through to `→ False` and the declaration skipped (`CircleSide.ball_antipode_subset_outside`, FS124-L2); a landing reads each skipped declaration of its modules. The counts and the baseline's two entries are recorded in `CLAUDE.md` § The gate, where
  `scripts/gate_report.py` reads them; a silent change in them is this gate's own failure mode. `--self-test` plants sixty-five controls
  and watches each fire; the load-bearing one — the same carrier family at an instantiation nothing refutes — must read `UNKNOWN`,
  never `VACUOUS`.
- **The environment linters** are `lake lint --no-build -- --no-build --trace` under the slot (about 5 s, 4.8 GB): Lake's
  `--no-build` exits instead of rebuilding the driver, the driver's exits instead of building the library, and `--trace` prints
  one verdict per linter. Green is exit 0, `-- Linting passed for Proofs.`, and every linter `(2/2) Passed!`. An unused argument
  named with an underscore, or referenced by `have _ := h`, is not reported; an unused anonymous instance binder is, and the
  build's own linters do not warn about it.
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
  derivations; on a declared kind its docstring contradicts; on a declared hypothesis no statement takes, or one a
  theorem proves over its own variables; on any consumer that `scripts/assumptions-ledger.txt` does not list, or lists
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
