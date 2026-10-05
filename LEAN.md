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
  2. its Lean statement is read back against the paper's own wording, in the planner's record;
  3. one model of its hypotheses — a `theorem` or `example` in the same file exhibiting an object that satisfies them;
  4. a line in `ARCHITECTURE.md` § Trust, as a declared purchase.
- **Our own hand results** that a module needs before their own module lands enter as explicit hypotheses of the theorems that use
  them, never as axioms, so they disappear when discharged.
- **At publication** the cost of landing every assumption on the standard three axioms is measured first; Kooshi prefers the three
  axioms if it is about a week of agent work or less.

## Trust ledger

The audit's counts are recorded in `CLAUDE.md` § Trust ledger, where `scripts/gate_report.py` reads them. What it accepts:

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **explicit purchase, per use**, named in its declaration's docstring and listed in `ARCHITECTURE.md` § Trust |
| an `axiom` importing an outside theorem | **explicit purchase**, with the four items above; declared to the gate by one `AxiomAudit.declareImport` line in `scripts/Axioms.lean`'s IMPORTED section (the procedure is beside its banner), every record resting on it audited there |

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

- **A failed `exact?` is not an absence.** It proves the shape you asked for was not found; vary the statement (`= true` versus
  `decide (…)`, an iff versus an implication) first. **And Mathlib is not the whole library:** `grep -rn "<name-fragment>" $(lean
  --print-prefix)/src/lean/` searches core. Grep the source before writing a proof, and before writing that something is missing. Grep
  Mathlib by the statement's shape at the skeleton.

## The package

The **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat import surface, modules under `Proofs/`),
with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib** is pinned to tag `v4.32.0`. `scripts/Axioms.lean` is the trust receipt.
The module map is `ARCHITECTURE.md`, checked against the import graph by `tools/check_architecture.py`; a new module goes into the map
in the same commit.

When adding a library or executable, changing dependencies, or bumping Mathlib, work through the **`debruijn-init`** skill, freshly
invoked. `lake update` and Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

## The gate

Elaboration is the floor: the build green, zero `sorry`, `#print axioms` clean on the public surface (`scripts/axioms.sh`), and `./scripts/axioms.sh --self-test` green (23 planted faults, each watched to fire, two of them partners that must pass), linters
silent, spec examples passing. On top of that, the statement-level gate, because a formalization that proves the *wrong* theorem is
the characteristic failure here:

- **`./scripts/vacuity.sh` and `./scripts/vacuity.sh --self-test` are green** — no theorem is a `∀` over an empty domain. Vacuity is
  undecidable, so the check **requires evidence**, as `axioms.sh` requires every purchase to be declared. **The law:** a statement is
  vacuous exactly when some `∀`-binder has an empty domain; `(C : G.Coloring α)` is the dangerous binder, a `Forces` binder is a
  possible *overclaim* instead, and a declaration concluding `False` — `False` as stated, so `P → False` is one and `¬ P` and `a ≠ b` are not: their binders are audited like any other's — is a refutation and is skipped. **Verdicts:** `WITNESSED`
  (inhabitant proved); `DECLARED` (deliberate emptiness, named with its reason in the docstring as `VACUITY DECLARED:` and printed every
  run); `VACUOUS` (undeclared emptiness) and `STALE` (claimed emptiness not proved), which fail unconditionally before the baseline;
  `GENERIC` (parametric, where **no inhabitant witness can exist** — the caller's obligation); `UNKNOWN` (counted, never silent, and the
  only thing the baseline may hold). The counts and the baseline's two entries are recorded in `CLAUDE.md` § The gate, where
  `scripts/gate_report.py` reads them; a silent change in them is this gate's own failure mode. `--self-test` plants fifty controls
  and watches each fire; the load-bearing one — the same carrier family at an instantiation nothing refutes — must read `UNKNOWN`,
  never `VACUOUS`.
- **Every gate keeps what it computed — read it before re-running one.** `build.sh`, `axioms.sh`, `vacuity.sh` and `lean4checker.sh`
  save their tool's complete output under `build/gate/<gate>/` (`latest` is the last complete run; `scripts/gate-log.sh`) and print a
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
- Every definition has a `#eval`/`example` that would fail if it drifted.
- The Moser spindle's non-3-colourability is proved **twice** — by `decide` and through the SAT bridge — so the CNF encoding is
  checked against an independent oracle.
- The final statement is read against Mathlib's `SimpleGraph.chromaticNumber` and the informal claim, out loud, before it is believed.
- Each check's negative control: break what it guards, watch it go red and name the culprit, then put it back (`RUNNING.md` § Make the
  gate fail, and watch it fail).

The InfoView is continuous testimony at zero cost — save and read the goal state after every step rather than debugging by guess.
