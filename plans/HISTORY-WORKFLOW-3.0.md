# History: text cut from the always-loaded files by Workflow 3.1

*Workflow 3.1 (Kooshi, 2026-10-03, `plans/WORKFLOW3-lane-edits-proposed.md` § Kooshi's ruling and § Kooshi's decisions) cut narration,
incident stories and dated edit history from every file an agent loads at launch: "any context which is loaded every time an agent runs
must only reflect the current state of affairs, and cut narration and old instances and dated edit history." Nothing was lost: the text
cut from `CLAUDE.md` and from the Lean facts (which came from `CLAUDE.md`) is below, verbatim, read by address and loaded by no one, and
`tools/claude_md_fact_audit.py` checks that every fact token it held is still here or in its new home. The Workflow 3.0 text of the lane
files (`.claude/agents/*.md`, `.claude/output-styles/keryx.md`) and of `plans/STANDING-RULES.md` is in git at commit f550cb5f.*

## 1. The Lean facts, as `.claude/agents/debruijn.md` carried them under Workflow 3.0 (now `LEAN.md`, current state only)


*Moved verbatim from `CLAUDE.md` on 2026-09-28 (Workflow 3.0), where each heading keeps a one-line pointer here. They bind this lane
alone; every one was bought with an incident.*

### The shape of the proof

The whole argument is one reduction plus two certified computations:

```
χ(ℝ²) ≥ 5  ⟸  some finite unit-distance graph is not 4-colourable
                 ├── geometry:  every listed edge really has length 1   (exact field arithmetic)
                 └── combinatorics: the graph has no 4-colouring        (verified LRAT checker)
```

Neither computation is trusted on its own say-so. The geometry is exact — coordinates live in the
multiquadratic field ℚ(√3,√5,√7,√11) represented as an iterated quadratic extension over ℤ, so
"distance = 1" is an integer identity, not a float comparison. The combinatorics goes through a verified
LRAT checker the kernel can run: core ships one (`Std.Tactic.BVDecide.LRAT.check` + `check_sound`) that the
kernel cannot evaluate (among other causes, `Std.HashMap` reaches an `@[extern] opaque` word size), so M05
built a kernel-reducible one. CaDiCaL is an untrusted oracle that merely proposes the certificate.

**Nothing in `tools/` is trusted.** The generator may be wrong; Lean re-derives every claim from
the emitted data. A generator bug can only produce data Lean refuses to certify.

### Trust ledger

The audit's counts are recorded in `CLAUDE.md` § Trust ledger, where `scripts/gate_report.py` reads them. What it accepts:

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **explicit purchase, per use, recorded here** |

`native_decide` trusts the compiler and this CPU rather than the kernel. Where a `Bool` cannot be
kernel-reduced we may buy it — but the purchase is named in the docstring of the declaration that makes
it, and listed in `ARCHITECTURE.md` § Trust. Soundness theorems are identical either way; only the axiom
list moves.

**Grep for the right name.** At v4.32.0 `native_decide` mints a *per-declaration* axiom;
`Lean.ofReduceBool` never appears in `#print axioms`. An audit looking only for that name passes a
native purchase in silence.

**`lean4checker` is a publication gate, not a milestone gate** (Kooshi, 2026-08-02): the build-time kernel is the trust
anchor; the independent replay is single-threaded and RAM-heavy, so run it once, on hardware other than the desktop, before
any external claim of new mathematics — never as routine. It cannot re-check a native purchase (a purchase is an axiom, and
every kernel accepts axioms), so "replayed through an independent kernel" covers the kernel-checked part only.

### Toolchain — Lean

Managed by **elan** and pinned by `lean-toolchain` (`leanprover/lean4:v4.32.0`); the toolchain and the
Mathlib pin move as one unit. If `lean` / `lake` are missing, run `./install-toolchain.sh`.

**Arch build env — required before building.** The toolchain's bundled `clang` is broken against Arch's
system LLVM, so any native/C compile fails unless you use the system clang plus the toolchain's bundled
`libc++`. `source scripts/dev-env.sh` in your shell (it sets `LEAN_CC`, `LIBRARY_PATH` and
`LEAN_ABORT_ON_PANIC`; the installer wires it into `~/.profile`, and Claude's own shell gets it via
`.claude/settings.local.json`).

### Building Lean

**ALWAYS build through `./scripts/build.sh` — never `lake build`, bare *or named*. No exceptions.** Lake 5.0.0 has no `-j`
and sizes its job pool from the machine; data modules here peak at ~9 GB each and certificate segments at 3.4 GB + 0.81 GB
per chunk, so an unrestricted build asks for hundreds of gigabytes (it took the desktop down twice on 2026-07-30), and a
*named* target silently queues every missing or stale dependency into the same pool (on 2026-08-02 a one-module build queued
four 22 GB certificate rebuilds behind a 20 GB cap, the OOM killer ate them twice, and a grep-piped invocation read as a
pass; the loophole cost hours). `scripts/build.sh` builds every module in dependency order (`scripts/build_order.py`), leaves
first, in explicitly named batches (`BATCH`, default 10), each under a `systemd-run` memory cap (`MEMMAX`, default 100G);
`--plan` prints the batches and builds nothing. It first asks Lake once, under the same cap, whether any module is out of
date (`lake build --no-build`, about 2 s against about 3 min for the walk); only exit 0 skips the walk, so the check can cost
time but never skip a build.

**`lake env lean <file>` is fine for iteration — it builds nothing — and it is not the same check.** It does
not apply the lakefile's options, so `autoImplicit := false` is not in force: a stray identifier is
silently auto-bound and the file elaborates clean, then fails the real build. Never conclude from it that a
module is green.

**The batch is the plan; the cap is a backstop.** Lean `mmap`s its `.olean` files, so at the limit the
kernel reclaims their page cache and must read it back — with `MemorySwapMax=0` that is an I/O thrash, not
a clean kill. Before raising `BATCH`, measure a module's peak and choose the width from
`available_memory / peak`; sum the RSS of the running `lean` processes with:

```bash
ps -C lean -o rss= --no-headers | awk '{s+=$1} END {print s/1048576 " GB"}'
```

**Generated modules and invalidation.** For work split across independent modules the wall clock depends only on the
job count, not the piece size, so smaller pieces are free concurrency. Lake takes a module's own trace from its source and
its dependents' traces from the resulting `.olean` (measured at M11 — not what the rule used to say, and ignoring the
corollary cost 28 hours of processor time at M07; doc comments are queryable data and therefore part of the artifact,
`--` comments are not):

| edit to an upstream module | that module | its dependents |
|---|---|---|
| a `-- line comment`, anywhere, including inside a proof | re-elaborates | **not rebuilt** — the `.olean` is byte-identical |
| a `/-- docstring -/` or a `/-! module doc -/` | re-elaborates | **rebuilt** — doc strings are environment data |
| a declaration, or any change to one | re-elaborates | rebuilt |

So: prose in a module a certificate imports is written as `--` comments or not at all; diagnostics live
downstream in `Sat/Diagnose.lean`; `Sat/Mask.lean`, `Sat/ClauseTable.lean` and `Sat/MaskCheck.lean` are
settled, and changing a declaration or docstring there is a decision about hours; deleting a generated `.c`
under `.lake/build/ir/` invalidates its module exactly as deleting the `.olean` would. Settle every
hand-written module before starting a long generated build.

### The kernel's cost model

- **`decide +kernel`, not `decide`, for anything large.** Plain `decide` reduces the `Decidable` instance
  twice — in the elaborator and in the kernel — so it is ~2× slower and dies on `maxHeartbeats` first;
  `+kernel` needs no knob and buys the same axioms.
- **Reduction-step count is the only thing that costs** (measured: ~33 µs per iteration of a trivial
  recursive function). This model predicted core's already-measured LRAT checker cost to within 20% (it rebuilds a 6,325-slot
  array per step; 6,325 × 33 µs = 209 ms against 100–180 ms measured), which is why to trust it. GMP-backed `Nat` arithmetic *and bitwise* operations are free at thousands of bits;
  `USize` is stuck (its width is an `@[extern] opaque`); `Nat.ldiff` is not accelerated; `Nat.fold` is
  superlinear. Which operations are hardware-backed is invisible in the source — measure before believing.
- **Data the kernel must *build* costs O(its whole size) per access; a *literal* does not.** A structure
  grown by N applications costs O(N) to reach weak head normal form (a lookup in a table grown by `insert`
  went from 2.14 ms at 2,381 entries to 16.7 ms at 33,089). Emit big tables as literals (M04's `PtTable`
  pattern), never accumulate one during a kernel evaluation, and never build an index list with
  `List.range` + `List.map` (~0.83 ms per element). **The figure is for `range` + `map`, and does not transfer to a
  bare `List.range` re-evaluated in a loop** (measured 2026-09-15, FS-53 K1): a `check` that rebuilt `List.range 529`
  once per circle point — 12,696 nodes, ~10 s by that figure — cost **4.19 s against 4.17 s** for the hoisted form,
  inside run-to-run noise, because the kernel's cache absorbs the repeat. The hoisted shape was kept anyway (it is the
  honest one and costs nothing), and the docstring that had asserted the order mattered was rewritten: **a rule you are
  obeying is still a claim, and it is measured before it is written down.** A `Nat` literal costs ~2.3 KB of olean against ~145
  bytes per plain literal node, so pack many values into few big `Nat`s.
- **A `∀ x ∈ l, P x` under `decide` costs an order of magnitude more than the same check as a `Bool`.** Measured
  (FS-38 K3): `∀ e ∈ (778 pairs), e.1 ≠ e.2` on a bare import cost 31.9 GB and timed out; `l.all f = true` on the real
  predicate cost 3.5 GB and 5 s. State list checks through `List.all` and recover the per-element form with
  `List.all_eq_true`.
- **A numeral at an unsimplified type index is paid per numeral, at elaboration, even in a definition with no
  proof.** A 48-point literal at `ZMod (2 ^ ((5 + 1) / 2))` cost 32.9 GB and a timeout; the same points at `ZMod 8` cost
  2.5 GB, and then a defeq wall on every access. Carry no literal at such a type; evaluate the form per element.
- **Feed the kernel the refutation's core, never the whole instance.** A certificate's clause table costs
  `agreesWithCNF` over the entire formula: 853 s at 33 GB for a 1,024-vertex instance whose proof reached 125 vertices;
  the core, extracted from the LRAT by backward reachability from the empty clause (861 of 99,335 clauses), proves the
  identical statement in 5.9 s (recipe: `Instances/TwoAdicFive/Edges.lean`).

### Searching — Lean

- **A failed `exact?` is not an absence.** It proves the shape you asked for was not found; vary the
  statement (`= true` versus `decide (…)`, an iff versus an implication) first — `Nat.testBit_two_pow_sub_one` was reported
  missing here on exactly that error. **And Mathlib is not the
  whole library:** `grep -rn "<name-fragment>" $(lean --print-prefix)/src/lean/` searches core. Grep the
  source before writing a proof, and before writing that something is missing. More instances: `plans/GROKKING-INSTANCES.md` § Searching.

### The package

The **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat import
surface, modules under `Proofs/`), with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib** is
pinned to tag `v4.32.0`. `scripts/Axioms.lean` is the trust receipt.

When adding a library/executable, changing dependencies, or bumping Mathlib, work through the
**`debruijn-init`** skill — freshly invoked, per the fresh-invocation rule (§ Your loop, step 6). `lake update` /
Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

### The gate

Elaboration is the floor of the test suite: the build green, zero `sorry`, `#print axioms` clean on the
public surface, linters silent, spec examples passing. On top of that, this project's statement-level gate,
because a formalization that proves the *wrong* theorem is the characteristic failure here:

- **`./scripts/vacuity.sh` and `./scripts/vacuity.sh --self-test` are green** — no theorem is a `∀` over an
  empty domain. Vacuity is undecidable, so the check **requires evidence**, as `axioms.sh` requires every
  purchase to be declared. **The law:** a statement is vacuous exactly when some `∀`-binder has an empty
  domain; `(C : G.Coloring α)` is the dangerous binder, a `Forces` binder is a possible *overclaim* instead
  (FS-29), and a declaration concluding `False` is a refutation and is skipped — its binders are meant to be unsatisfiable, and flagging one
  is flagging a theorem for its own content. **Verdicts:** `WITNESSED`
  (inhabitant proved); `DECLARED` (deliberate emptiness, named with its reason in the docstring as
  `VACUITY DECLARED:` and printed every run); `VACUOUS` (undeclared emptiness) and `STALE` (claimed emptiness
  not proved, which is what makes the annotation a checked claim rather than a `# noqa`), which fail unconditionally before the baseline; `GENERIC` (parametric, where **no inhabitant witness can exist** — the caller's
  obligation); `UNKNOWN` (counted, never silent, and the only thing the baseline may hold). **Counts** — a
  silent change in them is this gate's own failure mode; they, and the baseline's two entries, are recorded in `CLAUDE.md` § The gate,
  where `scripts/gate_report.py` reads them.
  `--self-test` plants seven controls and watches each fire; the load-bearing one — the same carrier family
  at an instantiation nothing refutes — must read `UNKNOWN`, never `VACUOUS`, since a check that flags it is matching the family name rather than the
  instance and is worthless. More instances: `plans/GROKKING-INSTANCES.md` § The gate.
- **Every gate keeps what it computed — read it before re-running one.** `build.sh`, `axioms.sh`,
  `vacuity.sh` and `lean4checker.sh` save their tool's complete output under `build/gate/<gate>/` (`latest`
  is the last complete run; `scripts/gate-log.sh`) and print a digest: every count, whether the counts
  recorded in `CLAUDE.md` still match, every flagged or declared row in full, and every row that changed
  since the previous run (`scripts/gate_report.py`). The vacuity log holds every site with the evidence
  that decided it. `regen-check.sh` keeps each step's log in its scratch directory.
- **Every theorem whose hypothesis is a structure** (a colouring, an embedding, a certificate, a
  homomorphism) **ships a named inhabitant** in the same file, or a one-line note naming the theorem that
  supplies one.
- Every definition has a `#eval`/`example` that would fail if it drifted.
- The Moser spindle's non-3-colourability is proved **twice** — by `decide` and through the SAT bridge —
  so the CNF encoding is checked against an independent oracle.
- The final statement is read against Mathlib's `SimpleGraph.chromaticNumber` and the informal claim, out
  loud, before it is believed.

The InfoView is continuous testimony at zero cost — save and read the goal state after every step rather
than debugging by guess.
