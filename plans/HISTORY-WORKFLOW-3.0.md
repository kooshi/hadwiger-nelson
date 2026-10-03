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

## 2. `CLAUDE.md`, the text Workflow 3.1 replaced, by section (verbatim, at commit f550cb5f)

### the header

# This workspace — lean-dir

A Lean 4 proof workspace aimed at one target: **the Hadwiger–Nelson problem**. Its work runs as a pipeline of four identities
(§ The pipeline): Poros asks the question, Ephodos derives the answer, de Bruijn formalizes it to its Lean standard, and
Keryx coordinates. **Who you are is set by how you were launched.** The top-level session is Keryx, whose identity and workflow are the output
style `.claude/output-styles/keryx.md`, which `.claude/settings.json` selects. An agent launched from `.claude/agents/` is the
identity its file names, with its lane's workflow beneath. This file is every mind's shared context, never an identity. Everything reduces to what
the kernel checked plus what we explicitly chose to trust.

**This file holds current state only.** Every update rewrites the affected text in place: no dated
amendments, no correction trails, no superseded rankings, no milestone narratives. A corrected claim is
replaced by the corrected claim (with its attribution, if it turned out to be prior art); the story of the
correction belongs in the commit message and the milestone's plan. **History is in git:**
`git log -p -- CLAUDE.md`. The last version carrying the full narrative — every milestone's story, every
amendment and correction trail, every superseded ranking and reading — is commit `fd658af` (2026-09-10).
**Size budgets: this file under 80,000 bytes, and the grokkings file (`.claude/skills/grokkings/SKILL.md`) under 200,000** (Kooshi,
2026-09-28: *"Let's say 80kB for CLAUDE.md, and 200kB for grokkings."*). They bound what a session carries — this file every agent
loads, the grokkings every lane that reasons from them — because *"There's just too much new knowledge to carry in every session"*
(Kooshi, 2026-09-26); `tools/claude_md_fact_audit.py` fails when either is over. A ceiling reached is a ceiling that starts costing
content, and the current-state-only rule, not the byte count, is what keeps these files honest. The budget is a ceiling and never a
licence: the current-state-only rule above does the real work, and superseded text comes out whether or not there is room for it.
No-loss compression is exhausted here (the last pass, 2026-09-25, found almost nothing more that touches no reasoning), so a budget
reached is met by moving what a session does not need to a file read by address, never by trimming a rule's reasoning: a reasoning
trimmed to fit cost hours on 2026-09-15. The budgets' history is in git and, verbatim, in `plans/CLAUDE-MD-HISTORY.md`. **One home per fact** (2026-09-21): numbers, certificates, names and
addresses live in a row of `LEDGER.md` (the novel-results ledger, extracted from this file on 2026-09-22 — read by address, never
loaded), mechanism and readings in a grokking (`.claude/skills/grokkings/SKILL.md`, loaded by the lanes that reason from it), a rule's second and later instances in `plans/GROKKING-INSTANCES.md` (extracted
2026-09-26, read the same way), a retired grokking in `plans/GROKKINGS-RETIRED.md` (since
2026-09-28, read the same way), and every other mention points; at every close run
`tools/claude_md_fact_audit.py` with `--base <the previous close>` (nothing lost, across every file it joins) and `--dupes` (nothing retold). **A paragraph tagged `[PROTECTED — never compress …]` is exempt from every trim
(Kooshi, 2026-09-15): the tag marks reasoning whose loss has already cost hours; trim elsewhere.**

### the local–global conjecture, item 10's address

Its proved range is item 10's

### the local–global conjecture section, § Publication

**Publication.** **Nothing is published before it is formalized in Lean, in full, with no declared purchases** (Kooshi, 2026-09-26, § The
aim; *"no declared purchases for the final one"*); write-ups and upstreaming stay deferred until then (Kooshi, 2026-08-04: the rung-B
write-up, Mathlib contributions, exposition, and the M58–M61 sieve arc). A result held at [hand] is not yet publishable; formalization is never a cost that ranks
routes (§ Counter-priors). A finite witness for six is out as a route: *"search for a finite graph is out. It would be huge, not feasible."*
What clears the bar, once formalized:
- *definitely* — the answer, written as the derivation (the programme);
- *a result that answers a question the literature has independently and repeatedly posed*, whatever its size (`CLOSED-QUESTIONS.md`).
  Held so far, all given MR and at [hand]: `χ(ℚ(√47)²) = 5` (row 121) answers Moorhouse's named question (2010) and the existence half of
  Soifer's Open Problem 55.1 (2019), in the kernel only in row 127's conditional form; row 129 answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's
  equality question. Kooshi's earlier ruling stands as history: *"The publication rule half fires. This is 100% worthy of a writeup, but I
  want to be greedy and push to see how far we can get on our own."* The fallback write-up is FS-102 (`plans/STUB-writeup-main-clause-five.md`).
- **Theorem B's value is in print since 1994**, and the rule's earlier apparent firing for it (χ(K²) = 4, posed or named as open at least six
  times across fifty years, `CLOSED-QUESTIONS.md` §1.1) is withdrawn: `[Fischer1994]` (K. G. Fischer, Congressus Numerantium 104, 73–79; read
  in full 2026-09-22, every lemma verified by hand and the theorem by `tools/fischer1994_check.py` on 181,160 unit vectors) gives an additive
  4-colouring, a homomorphism to ℤ/4, of the whole plane over ℚ(√p,√q) for p ≡ 3, q ≡ 11 (mod 16), pq ≡ 1 (mod 32), and concludes
  χ(ℚ(√3,√11)²) = 4 in those words, the Moser spindle as the lower bound. The equality is his, restated in two surveys (`[Johnson2000]` p. 176, `[Johnson2006]` p. 214); the six later posers — and this project —
  missed it — G49's mechanism once more. What is ours: the kernel proof, Theorem A's metric-free form and reach (the construction `[Fischer1990]`'s; his congruence family is a proper subfamily
  of the wall-standing fields it four-colours), the 𝔽₄-valued residue colouring — a different colouring from his ℤ/4-valued one, which
  separates a distance-2 pair the residue map identifies (G41) — and every consumer built on B. **The Theorem B paper is FS-20**
  (`plans/STUB-theorem-B-writeup.md`; whether it is still worth writing is Kooshi's call).

### § Frontier, its head and the Last-updated line

## Frontier

*The current state of the art, the ledger of everything novel this project has produced (`LEDGER.md`), and the ranked
paths forward. Rewritten in place at every milestone close (WORKFLOW step 9); a milestone whose close does
not update this section is not closed. The understanding the results add up to lives in § Grokkings, under
the same rule, and both under the header's one-home-per-fact rule: "Where the problem stands" and § Paths forward orient and
point (`row 68`, `G56`) and never retell.*

*Last updated: 2026-10-03 — **FS-116, the local exclusion, closed undecided** (rows 145–148; `plans/FS116-Z1-close.md`,
`plans/FS116-Z2-close.md`): the YES needs no map, and in non-Siamese simple fragments a four-colour vertex whose ring carries no boundary arc
dies at `1 + ε`; the (Q)-free, (Q) and saturated cases left are FS-123–FS-125. **FS-121, the map step, closed undecided** (rows 142–144; `plans/FS121-Z1-close.md`): honest saturated ladders end at (Q) or (R2) arcs and never outward, honesty is free, and the open steps are curved tangent interfaces, the singular set at LAT and the top colour at six (FS-126–FS-128). Before them, **FS-114**
(rows 137–138), **FS-111** (rows 139–141), **FS-112** (rows 135–136), **FS-110** (row 134), **FS-107** (row 133) and **the reframe** (Kooshi,
2026-09-26): the aim is the answer, formalized in Lean (§ The aim). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*

### § Where the problem stands, items 1–30 (moved)

Moved verbatim to `plans/WHERE-THE-PROBLEM-STANDS.md`.

### § Where the problem stands, the prior-art position (moved)

Moved verbatim to `plans/WHERE-THE-PROBLEM-STANDS.md`.

### § The novel-results ledger

### The novel-results ledger

**Rows 1–148 live in `LEDGER.md`** (extracted 2026-09-22): one row per result, kernel-checked unless graded otherwise, with its
address in `Proofs/` or `tools/` and its milestone. **Row numbers are stable identifiers cited across `plans/` and this file: never
renumber, never reuse.** The file is not loaded here by design — results are looked up by row, understanding is reasoned from — and
it is read in full at the reframe (step 3.1) and extended at the close (step 9).

### § Paths forward, the open-milestones paragraph

**Open milestones, in order.** **None is open.** FS-116, the local exclusion (`plans/STUB-local-exclusion.md`), is **closed undecided** (rows
145–148); its successors are FS-123, the (Q)-free ring (`plans/STUB-qfree-ring.md`, opening with whether a fragment's bends keep the
class FS116-Y4-EMPTY reads), FS-124, the (Q) ring (`plans/STUB-q-ring.md`), and FS-125, the saturated class (`plans/STUB-saturated-local.md`).
FS-121, the map step (`plans/STUB-map-step.md`), **closed undecided** (rows 142–144); its successors are FS-126, curved pencils, FS-127, lateral extent, and FS-128, the six-colour rungs (the cover route parked behind FS-125's NO-SAT). **Next**, in Kooshi's order: the two closes' filing, the workflow refinement, then **FS-129, the cross-application audit** (`plans/STUB-cross-application-audit.md`; a special case, unranked), then **FS-123, the (Q)-free ring**, rank 1, opening with whether a fragment's bends keep FS116-Y4-EMPTY's class (`plans/POROS-2026-10-03-close-reread.md` § 2.5); FS-124, the (Q) ring, is the alternative; BASE-V stands beside them (row 134's base re-derived but for
Lemma 4 at cusps). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close:
`plans/FRONTIER-STUBS.md`'s closed list.

### § Paths forward, its italic head

*A summary of `plans/FRONTIER-STUBS.md`, which is authoritative (the top ten here, and a count of the rest): every row there is a full stub with its
bearing on the answer stated honestly. Kooshi picks; the default is the top.*

### § Paths forward, the table's lead-in

**Ranked stubs** (the top ten, one rank per row, each bearing stated against the answer; the cells here are short, and `plans/FRONTIER-STUBS.md` is authoritative, with the full text, the re-rank history (the last, `plans/RERANK-2026-09-27.md`) and a solver column marking what the finite-witness-free week can run):

### § Paths forward, ranks 4–73 (in plans/FRONTIER-STUBS.md)

| 4 | **FS-125 the saturated local exclusion** — `plans/STUB-saturated-local.md` | NO-SAT: no valid fragment saturated one unit inside, about a four-colour vertex, beyond an explicit radius; first FS116-S1-QF's blind second mind, then SAT-STRIP's G3, G1, G2 | route M's first half in the class its honest branch consumes, weaker than C114-LOCAL-F: with FS-126–FS-128, `χ(ℝ²) = 7` given MR; its failure is `χ(ℝ²) ≤ 6` with no MR |
| 5 | **FS-122 the forced pair** — `plans/STUB-forced-pair.md` (route R) | a close complementary pair of fat junctions in every near-colouring (A-ALL ⟺ seven); its smaller statements B-RR and a robust Lemma 6.1 count | the answer itself in route R's form, with no map NO; its smaller statements bear only through it
| 6 | **FS-128 the six-colour rungs** — `plans/STUB-top-colour.md` (FS-121's successor) | TOP₆, binding the top colour of a Grundy six-colouring — first as G13's coverage question (R2's card 4) — and NOPAR-C5, the parked cover route's NO | at six and next to the answer: given NO-SAT, TOP₆ is the answer restated (FS121-D3-EQ, one mind); NOPAR-C5 is a smaller NO at six by nature |
| 7 | **FS-126 curved pencils** — `plans/STUB-curved-pencils.md` (FS-121's successor) | can an honest saturated colouring, at any `k`, have a curved tangent-type interface? First an inhabitant at some `k ≥ 7` or an obstruction (R2's card 3); FS-115's thin pencils live here | none alone: a NO decides three of FS-121's open claims and deletes (R2) arcs from route M's maps (FS121-Z1-NOCURVED, one mind); a YES at `k ≥ 7` says the map step cannot be colour-blind |
| 8 | **FS-127 lateral extent** — `plans/STUB-lateral-extent.md` (FS-121's successor) | is the singular set of every honest saturated colouring locally finite? Open at LAT, point-like accumulation; true on grids (FACE, GRID held) | none alone: REG-J′, one of the honest route's three conditions at six; FS-120's pinch a potential refutation |
| 9 | **FS-120 the pinch at a junction** — `plans/STUB-pinch-at-junction.md` | in a measurable fall colouring, is a pinch's cascade along its ladder of unit parallels absorbed where the ladder ends? | none alone: the colour-generic finiteness rung, now FS-127's potential refutation (FS121-D4-FALL); one mind throughout
| 10 | **FS-117 route T, the count** — `plans/STUB-route-t-count.md` (FS-123's and FS-124's sibling) | the non-Siamese NO by Euler's formula: K2′, GAP-μ, COVER-3, the torus design | none alone, partial by theorem (a tile count is blind to Siamese pairs); it aims FS-123 and FS-124; its (Q)-free case turns on FS-123's first question
| 11–73 | 63 more open stubs, in rank order in `plans/FRONTIER-STUBS.md` | … | … |

### § The open structural question (moved)

Moved verbatim to `plans/WHERE-THE-PROBLEM-STANDS.md`.

### § Grokkings, the italic head

*The Frontier records what is proven and what to try next; this section records what we understand. Every entry carries a status (grades: § Notation). A reading is never silently promoted, and a **[reading]** names its killing test. Entries are
rewritten in place to current state — but **a grokking that dies is demoted with its refutation recorded, never deleted**: the entry keeps, in one or two sentences, what it wrongly claimed and what killed it. G1–G87 are stable identifiers cited across `plans/`: never renumber (the numbering order in this section is not chronological).*

*Every milestone opens with the reframe, in which the deriver walks these entries from inside its question (`.claude/agents/ephodos.md` § The opening job). The paragraph that stated it here, and the workflow grokkings the lanes' workflows now carry, are in `plans/GROKKINGS-RETIRED.md`.*

### § Grokkings, the italic foot

*The entries themselves — G1 to G87, each retired one as a titled pointer — are `.claude/skills/grokkings/SKILL.md`, which Poros,
Ephodos, the blind checker and de Bruijn load in full at launch through their agent files' `skills:` field. They moved there on
2026-09-28 at Kooshi's word, so that the coordinator and the Clerk, who do not reason from them, no longer carry them; both read an
entry there by its number. Keryx is that file's only writer, and a new grokking is filed there.*

### § The pipeline

## The pipeline

*The map every mind shares. Each role's own workflow is beneath its verbatim identity, in its own file, and loads into that mind
alone (Kooshi, 2026-09-28: "split the whole workflow into the separate agent files").*

| role | identity | its file: the identity verbatim, then the lane's workflow |
|---|---|---|
| **coordinate**, the top-level session | Keryx | `.claude/output-styles/keryx.md`, the output style `.claude/settings.json` selects |
| **ask**, scouting ahead | Poros | `.claude/agents/poros.md` |
| **derive**, blazing the trail | Ephodos | `.claude/agents/ephodos.md` |
| **verify**, a blind second mind | Ephodos | `.claude/agents/ephodos-verifier.md` |
| **formalize**, paving behind | de Bruijn | `.claude/agents/debruijn.md` |
| **file**, reading and bookkeeping, on Sonnet 5.5 | the Clerk | `.claude/agents/clerk.md`, a short identity of lean-dir's own |

The identities (the Clerk's apart) are the core skills in `.claude/skills/`, imported unchanged from `~/source/agent-forge`; `scripts/identities.py
check` holds each copy to its skill, and the four cores are hidden from the model's skill list so that no mind loads a second
identity. Every arrow between lanes passes through Keryx, and only Keryx launches agents (§ Delegation — one level deep). Every
brief carries `plans/STANDING-RULES.md`. `WORKFLOW.md`, loaded by no one, is the index for the old workflow's step numbers.

**One writer per file.** Keryx alone writes this file, `LEDGER.md`, `RUNNING.md`, `.claude/skills/grokkings/SKILL.md`, `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, `plans/GROKKINGS-RETIRED.md`,
`BIBLIOGRAPHY.md`, the close inventories, the frozen claim lists and `plans/STANDING-RULES.md`, filing the lanes' drafts verbatim.

**Never write an open milestone's verdict, route or hunch into the auto-memory**: the harness gives its index to every agent at
launch, blind ones included, and no fence closes that channel.

**Conventions.**

| what | where |
|---|---|
| a job id | `FSnnn-<letters><n>`, the letters naming the job's kind by the milestone's own choice (FS-114's: `N` the proof side, `Y` the construction side, `NB`/`YB` their blind verifiers, `CV` a composition check) |
| a brief | `data/fsNNN/briefs/<job id>-<slug>.md`, in the `keryx` skill's header form; its `identity:` field names the agent file the job is launched from |
| a report | `data/fsNNN/reports/<job id>.md`, and the same text to "main" by `SendMessage` |
| a job record | `plans/FSnn-<job>-<kind>.md` (`-proof`, `-verification`, `-construction`, `-audit`); Poros's `plans/POROS-<date>-<topic>.md` |
| a milestone's plan | `plans/FSnn-<slug>.md` |
| its claim list | `data/fsNNN/claims.md`, frozen by Keryx |
| its close inventory | `plans/FSnn-close-inventory.md` |
| its derivation file | `plans/FSnn-derivation.md` |
| a stub | `plans/STUB-<slug>.md` |
| a handoff before a compaction | `plans/SESSION-HANDOFF-<date>.md` |

**The stub rule** (Kooshi, 2026-08-09). Every future milestone on the roadmap is kept as a detailed stub in `plans/`. It holds the
full mission context in plain language and everything the deciding session knew: the observations, the registered expectations, the
failure clauses, the named deliverables (visualizers among them, where the milestone produces an explorable object), and the
provisional bearings. It is written so a fresh mind with no conversation memory can plan it with all meaning intact. Sessions die and
compaction loses nuance; the stubs are the roadmap's memory. A direction change that does not rewrite the affected stubs is not
recorded. A demoted milestone keeps its stub with a banner saying why. Poros writes a stub's question section, bearings and bearing
on the answer; Ephodos's close job writes new stubs and the bearing lines of open ones; Keryx files the banners.

### § Delegation — one level deep

## Delegation — one level deep

**No child agent spawns children of its own** (Kooshi, 2026-09-19): only the top-level session launches agents. Its reasons and
its incident are `plans/STANDING-RULES.md` rule 1, and it is enforced by the agent files' withheld tools and by
`.claude/settings.json`. Staffing — head-count, model, budget, and the crunch and competition protocols — is Kooshi's decision, and
its record is Keryx's workflow (`.claude/output-styles/keryx.md` § Staffing).

### § The standard of evidence above rung B

## The standard of evidence above rung B

χ(ℝ²) ≥ 5 is a known theorem; a reader's default is to believe it. **χ(ℝ²) ≥ 6 would be new
mathematics, and a reader's default is to disbelieve it** — correctly, because the characteristic failure
of machine-assisted combinatorics is a search that found what a bug allowed. Anything above rung B must
convince someone who trusts none of this and reads none of the Python:

- **No native evaluation in the headline.** `native_decide` trusts the compiler and one CPU. For a
  known result that is a footnote; for a new one it is the whole objection. The kernel-checkable
  route (`plans/spike-kernel-lrat.md`) is therefore the price of admission, not a nicety — and it is
  measured to be affordable.
- **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer
  re-checks. Never require them to re-run a solver, reproduce a seed, or trust `tools/`.
- **The witness must be independently re-derivable.** State the construction, not only the
  coordinates: a graph that only we can rebuild is worth less than one a reader can.
- **Read the final statement aloud against the informal claim.** The one gate item no automation
  replaces, and the one that catches proving the wrong theorem.
- **Report the hunt honestly.** "Searched X, found nothing" is a result and goes in the write-up.
- **Write the certificate for the REVIEWER early — it is an instrument, not a chore, and it tells you which of your
  evidence is load-bearing.** Measured 2026-09-12: an agent building the reviewer-facing bundle for a refutation noticed,
  only while writing it, that its 552 exhibited colourings were **not load-bearing at all** — the argument needed its
  pattern list to be a *superset* of the achievable patterns, never a set of achievable ones — which retired a third of
  its evidence and shrank the solver-dependent core from one claim about a 51,133-vertex object to **twenty claims about
  25,567-vertex halves** — a different *kind* of artifact, because twenty half-instance refutations are individually within reach of proof logging where one whole-object refutation was not. **The question that did the work is cheap and repeatable: *what must someone who trusts none of
  this actually check?*** Ask it while the evidence is still being gathered, not at the write-up, or you will pay for evidence nothing rests on. More instances: `plans/GROKKING-INSTANCES.md` § The standard of evidence.
- **Order a verification's steps by marginal evidential value, never by narrative order.** Same session, twice:
  a verification script was written so its *least* informative step ran first, leaving the checks that decided
  the question queued behind slow ones that could not.

### § What compute actually helps, its first paragraph

Ask before provisioning; measure before believing. **A kernel leaf priced after a fine obligation pass is priced high** (FS-73):
`Kempe.lean`'s 22 leaves, priced at 1½ days, closed in about 40 minutes of work, every leaf on its first or second elaboration, once
the obligation pass had named each child and its route — re-price a kernel phase from its first two leaves, never from the plan's table. Grep Mathlib by the statement's shape at the skeleton (M2's seven re-prices, and FS-75's: `plans/GROKKING-INSTANCES.md` § What compute actually helps).

### § The shape of the proof

## The shape of the proof

The shape of the proof — one reduction plus two certified computations, and why nothing in `tools/` is trusted — is the
kernel lane's: `.claude/agents/debruijn.md` § The shape of the proof.

### § Trust ledger, its pointer

What the audit accepts and what it buys — the ledger's entries, `native_decide`'s per-declaration axioms, `lean4checker` as the
publication gate — is the kernel lane's: `.claude/agents/debruijn.md` § Trust ledger.

### § Toolchain, with the search ban

## Toolchain

The Lean toolchain — elan, the pin, the Arch build environment — is the kernel lane's: `.claude/agents/debruijn.md` §
Toolchain — Lean. The rest of the toolchain — the SAT solvers, what is installed, the symmetry-breaking checklist,
Python's multiprocessing default, the two machines — is `RUNNING.md` § Toolchain (moved 2026-09-28), which every brief for a job that
runs a solver, a build or a long process names. The ban below binds every job.

**No search for a finite witness runs from 2026-09-24 to 2026-10-01** (Kooshi, at FS-81's close: *"ban SAT solvers for a week and see what we can do on algebra alone"*; its intent, *"to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time"*; the scope is the algebra-week advisor's, `plans/POROS-2026-09-24-algebra-week.md` §6.4, confirmed by Kooshi the same day). **Out:** SAT, MaxSAT and #SAT solvers, MILP/CP and local-search colourers, Θ relation trees and float Θ₄ finders, quotient-colouring searches, and lattice sweeps hunting survivors — FS-81's relation tree was no SAT solver and lost to a derived certificate exactly as SAT did. **In:** hand derivations; computer algebra and exact arithmetic (PARI, GAP, sympy); colourings given by formula; the Lean kernel; existing checkers on existing certificates; and an exact LP only when a derivation fixes its shape before it runs and its dual is read back as an identity, never as an escalating oracle. The line in one sentence: every certificate is derived and lives on the infinite object, never on a finite piece found by search. Every brief carries a **"would have searched here" log**: one line per move an agent would have made by search, and what it did instead. The solver column of `plans/FRONTIER-STUBS.md` marks which stubs the week can run.

### § The kernel's cost model

### The kernel's cost model

The kernel's cost model is the kernel lane's: `.claude/agents/debruijn.md` § The kernel's cost model.

### § Searching

### Searching

- **The regex engine.** `grep -E` on this machine is `ugrep`, and it silently under-matches alternation
  inside a repeated group: `^\s*(private |protected )*theorem` does not match `private theorem foo`. **And a `^` anywhere inside a pattern is read as an
  anchor, so `grep -c "LDL^T re-run"` returns 0 for a string present four times** (2026-09-15, FS-53 phase B: it briefly made
  the LDL verification of six certificates read as *zero blocks checked* — failing, as ever, in the direction that looks like a
  clean negative). `grep -oF` counts correctly; `rg` and `grep -P` match correctly.
- **The file selection.** `rg` respects `.gitignore`, which hides `.lake/` and `build/` (naming a hidden directory explicitly works; it is
  recursive discovery from `.` that skips it). Use `rg` for
  searching source; use `rg -uu` or `grep -rP` for any completeness question (does this artifact exist, is
  this string anywhere); never believe a count from a bare `grep -E` alternation inside a star.
- **The Lean half** (`exact?`, core's
  library) is the kernel lane's: `.claude/agents/debruijn.md` § Searching — Lean.

### § The package

## The package

The package — `proofs`, its library, the Mathlib pin, and how a dependency or a Mathlib bump is made — is the kernel lane's:
`.claude/agents/debruijn.md` § The package.

### § The gate, its pointer

The Lean gate — the build, zero `sorry`, the axiom audit, linters, spec examples, and the statement-level vacuity check — is the
kernel lane's procedure: `.claude/agents/debruijn.md` § The gate.

## 3. `plans/FRONTIER-STUBS.md`, the text Workflow 3.1 replaced (verbatim)

### § Ranked stubs: the dated re-rank paragraphs

*At FS-116's and FS-121's closes (2026-10-03; R2, `plans/POROS-2026-10-03-close-reread.md` § Draft re-rank): both closed undecided and left the
table (the closed list). **Minted:** FS-123, the (Q)-free ring (1), FS-124, the (Q) ring (2), and FS-125, the saturated local exclusion (4), at
FS-116's close; FS-128, the six-colour rungs (6), FS-126, curved pencils (7), and FS-127, lateral extent (8), at FS-121's. FS-129, the
cross-application audit, is Kooshi's special case and is not ranked: it runs after the filing and the workflow refinement. FS-116's case list leads.
Each piece is necessary for seven, and its failure is `χ(ℝ²) ≤ 6` with no MR (FS116-O1-YESLIM, held). FS-123 is first because its first question
decides the shape of the whole remaining case list. FS-104 stays 3. FS-121's successors follow route R (FS-122, 5): FS-128 is next to the answer, and
FS-126 and FS-127 are colour-generic rungs. **Demoted:** FS-115, 6 → 18 (its banner: its live bearing moved into FS-126). **Amended in place:**
FS-101, FS-104, FS-117, FS-120, FS-122; FS-41 and FS-65 (an unescaped `|` escaped). FS-122 4 → 5, FS-120 5 → 9, FS-117 7 → 10; old ranks 8–14 become
11–17, and 15–69 become 19–73.*

*At FS-114's and FS-111's closes (2026-09-28; R1, `plans/POROS-2026-09-28-close-reread.md` § Draft re-rank): both closed undecided and left the table (the closed list). **Minted:** FS-116, the local exclusion (1), and FS-117, route T's count (7), at FS-114's close; FS-121, the map step (2), FS-122, the forced pair (4), and FS-120, the pinch at a junction (5), at FS-111's; FS-118 and FS-119 unused, never reused. Route M's two halves lead as a pair — the NO (FS-116) and the map step (FS-121), each necessary for seven, jointly sufficient (FS111-C-SEVEN-M), a failure of either `χ(ℝ²) ≤ 6` with no MR; FS-116 first because it is not vacuous under seven, answers a posed question, and its first question decides whether FS-121 is needed at all. FS-104 stays 3. **Re-aimed:** FS-115, 4 → 6 (its banner). **Amended in place:** FS-101, FS-104, FS-108, FS-109, FS-113. Old ranks 5–66 become 8–69.*

*At FS-112's close (2026-09-27, FS112-X; `plans/FS112-unit-arc-half.md` §R-close 4.5; the ranking NIGHT-A's, `plans/POROS-2026-09-27-night-aim.md` §2, binding on Kooshi's deferral, `plans/FS112-close-inventory.md` items 70, 73): FS-112 closed undecided and left the table; **minted** on Kooshi's ruling (inventory item 59): FS-114, the unit-arc question (1), and FS-115, the stuck ray (4: none alone; it moves to 2 the day FS-114's plan commits to the four-colour form); FS-111 (2) re-aimed at FS-114's NO, the composition into seven a one-mind reading (FS107-MEET); FS-104 stays at 3; old ranks 4–65 become 5–66.*

*At the consolidation and library run (2026-09-27; `plans/CONSOLIDATION-2026-09-27.md`): **minted** FS-113, measure rigidity in full in Lean, at rank 8 on Kooshi's ruling (*"Yes, mint the stub (Recommended)"*), above FS-101, whose named hypothesis `hMR` it discharges; every rank from 8 on moved down one, and FS-90 joins `CLAUDE.md`'s group row. The stub files' bearings restated against the answer (BK).*

*At the ranking pass (2026-09-27, RK; `plans/RERANK-2026-09-27.md`): every bearing of ranks 4–64 restated against the answer (`CLAUDE.md` § The aim, links 1–6; § Counter-priors, rule 1), grades and soft-as-to-truth warnings kept, "none" where it is the truth. **Moved:** FS-44 15 → 6, FS-80 10 → 7, FS-101 19 → 8, FS-102 9 → 16; by insertion FS-62, FS-67, FS-59, FS-96, FS-64, FS-63, FS-49, FS-69, FS-57, FS-100; ranks 1–3 and 20–64 unchanged.*

*At FS-107's close (2026-09-27, FS107-X; `plans/FS107-stability.md` §R-close 4.4): FS-107 closed and left the table; **minted:** FS-110, the tangency seam (1; SWAP-PRICE folded in) and FS-111, the cone scale (2); FS-104, FS-109 (C-VOID folded in) and FS-108 move to 3–5; old ranks 5–63 become 6–64. Rows 6–64's six-framed bearings (FS-106 inventory items 5 and 82) were restated at the ranking pass, the paragraph above.*

*At the reframe (2026-09-26, RF1; `data/reframe-2026-09-26/rf1-record.md`): Kooshi set the aim — *"My goal is to fully solve, and then verify in Lean, HN. Then we publish."* — and adopted the owner's direction, the regularity wall, as its program (`CLAUDE.md` § The aim; `plans/STUB-regularity-wall.md`). **Minted:** FS-106 (the regular half, rank 1) and FS-107 (regularity against pathology, rank 2), the program's two milestones in its order. **Moved:** FS-104 from 1 to 3, re-aimed, not demoted: its null-set step (C-FMT (d)) is now one sub-question of FS-107, its other items stand (its banner). Every other rank moved down two (FS-62 2 → 4 … FS-5 60 → 62); no row left the table. The bearing column now reads "bearing on the answer" (`CLAUDE.md` § Counter-priors, rule 1); the rows' own bearing text is unchanged.*

*At FS-105's close (2026-09-26, FS105-X): FS-105 closed and left the table; every later rank moved up one, so FS-104 leads (the default; Kooshi's choice — FS-102, the fallback write-up, is the alternative now that MR is hardened). Re-aimed: FS-100 (MR hardened; its left items unchanged), FS-102 (MR cited as EL2021 Thm 1.3 with FS105-DED; `[11]` Prop. 6.4 first if a write-up wants the full reading).*

*At FS-103's close (2026-09-26, FS103-X): FS-103 closed and left the table; every later rank moved up one, and FS-105 (harden MR) moved above FS-104 — the owner's default on the close's held item 1 (rows 121–130 all rest on MR, and row 129 makes MR testable on finite graphs; Kooshi may reverse it; `plans/FS103-collapse-cp-plane.md` §R-close 4.9). Re-aimed: FS-104 (the measurable form; the null-set step first), FS-105 (C-MR16; row 129's finite-graph test of MR), FS-62 (S's exact form, not a finite family), FS-101 (the collapse slot), FS-102 (the lead, Kooshi's call); every row citing "FS-103's F1 (a candidate)" now cites row 128.*

*Re-ranked 2026-09-26 (job R3; Kooshi: *"I agree and approve all suggestions. Set things up, then prepare for compaction, and we'll focus on that as the milestone."*), one rank per row, renumbered from 1: R1's proposal (`plans/RERANK-2026-09-26.md` §3.1), with the advisor's order where the two disagreed (`plans/POROS-2026-09-26-rerank.md` stage 4) — FS-62 above FS-59, and FS-49 and FS-44 above FS-69 and FS-57, which the owner ruled post-ban. **Minted:** FS-103 (the collapse, rank 1 — the next milestone), FS-104 (`χ_CP(ℝ²)` at six, 2), FS-105 (harden MR, 3). **Left the table for the closed list:** FS-84 (answered, row 121) and FS-97 (absorbed and answered, row 120). **Re-aimed:** FS-59, FS-62, FS-63, FS-67, FS-80, FS-44 (each row's opening sentence; its stub's head block). The frame the bearings are stated in is FS-103's F1 — a candidate composition, not a result. The earlier paragraphs follow.*

*At the 2026-09-26 consolidation (job C3b; `data/consolidation-2026-09-26/C3b-record.md`) no rank moved: **FS-84 (4) closed**, not re-aimed (Kooshi's ruling; the closed list), its rank held; **FS-59 (1) answered at five** ([hand], through MR, row 123) **and re-aimed to six** at ℚ(√167), the rank kept (Kooshi's target); **FS-102 minted at rank 14′** (the fallback write-up of rows 120–123; the prime keeps every other rank number); FS-90 (2), FS-100 (3), FS-75 (5), FS-80 (6), FS-67 (11), FS-64 (12), FS-97 (13), FS-96 (14), FS-48 (16), FS-78 (17), FS-72 (20), FS-60 (26), FS-47 (27), FS-69 (35) and FS-62 (37) brought to rows 120–127.*

*At FS-100 stage 5 wave 3's close (2026-09-26, X30F): **FS-101 minted at rank 3′** (the kernel port of row 123; its rank is Kooshi's, the default just below FS-100, and the prime keeps every other rank number); no other rank moved: FS-100 (3), FS-59 (1), FS-98 (8), FS-48 (16) and FS-72 (20) updated from X29C's drafts, FS-84 (4) unchanged beyond its stub's answered banner.*

*At FS-100 stage 5's close (2026-09-26, X10F) no rank moved: FS-100 (rank 3) re-aimed (MR proved, row 120), FS-84 (4) answered and re-aimed (the owner's ruling), FS-59 (1), FS-98 (8) and FS-64 (12) updated, FS-97 (13) answered in its banner; the quantitative-T-C(A) candidate drafted at the close (§R-close (stage 5) 4.4) is not minted (held for Kooshi).*

*At FS-100's in-ban close and FS-75's minimal-instance close (2026-09-26, J55) no rank moved: FS-100 (rank 3) and FS-75 (5) re-aimed by their closes, FS-64 (12) and FS-60 (26) re-aimed with them; FS-84's and FS-92's provisional bearings gained FS-100's rows.*

*At the crunch's close (2026-09-26, J25) no rank moved: FS-97 is absorbed into FS-100 (owner ruling on J47's proposal) and keeps rank 13 under
its banner so the numbering stands; FS-59, FS-96 and FS-98 re-aimed (J39's R4 and R3, J38's R1); FS-100's stages 1–2 done (J48, J49).*

*FS-100 minted 2026-09-25 by crunch job J47 at rank 3 (the wanted posters' shared lemma, MR; `plans/STUB-measure-rigidity-three-fields.md`); every rank from 3 on moved down one. The re-rank paragraphs follow.*

*Re-ranked 2026-09-25 at row 88's and FS-67's closes (J44), one rank per row. **Closed as milestones:** row 88's question (`LEDGER.md` rows 111–113; row 88 itself undecided) and FS-67 (rows 114–115; its stub re-aimed and kept, now rank 10). **Minted:** FS-98 (transience over the type-(B) fields, rank 7), FS-97 (spectra reading infinitely many places, 12), FS-99 (the ℚ⁴ control, 31). **Re-aimed:** FS-84 (row 113), FS-64 (rows 111–113; stage Y2 carried), FS-90 (its (c) is stage Y1), FS-67 (its close). Every rank from 7 on moved down one, from 11 down two, from 29 down three. The earlier re-rank's paragraph follows.*

*Re-ranked 2026-09-25 at the crunch's close (M1–M3), one rank per row. **Closed:** FS-91 (rows 98, 100–102), FS-82 (row 99); **answered for falsifiers:** FS-83 (row 100; its remainder to FS-92); the closed list. **Minted:** FS-92 (character classification, rank 12), FS-93 (band rigidity from the pyjama theorem, 21), FS-94 (one-prime minimal sets, 22) at M1's close; FS-95 (rank-one walls, 7), FS-96 (windows at the non-mixing places, 11) at M3's. **Re-aimed:** FS-59, FS-64, FS-75, FS-47, FS-48, FS-46, FS-84 (M1: rows 99–101); FS-39, FS-45, FS-47, FS-87 (M2: rows 103–107); FS-76, FS-64, FS-59, FS-49, FS-69, FS-67 (M3: rows 108–110); FS-80 and FS-84 (J29). **Moved:** FS-39 from 20 to 27, below FS-68 (M2's proposal: what is left is B2, months, and a reading); FS-69 up one, beside FS-65 and FS-57 (two consumers now). The earlier re-rank's paragraph follows.*

*Re-ranked 2026-09-25 at FS-89's close, one rank per row. **FS-89 closed** (`LEDGER.md` rows 95–97; G76; the closed list), verdict Paid (theorem). **Minted:** FS-91 (band rigidity at six colours, and at one prime; rank 2). **Answered and moved below FS-84:** FS-83 (no character four-colouring of ℚ(√47)'s plane, no character five-colouring of ℚ(√167)'s; row 96). **Re-aimed:** FS-59, FS-84, FS-64 (row 96), FS-76 (character colourings cannot break inheritance over type-(B) fields), FS-90 (HD1 proved, so (a)'s certificate exists; (b) needs Heule's graph acquired first). Ranks 6 on unchanged. The earlier re-rank's paragraph follows.*

*Re-ranked 2026-09-25 at FS-86's close, one rank per row. **FS-86 closed** (`LEDGER.md` rows 88–94; G76; the closed list), verdict Paid (no-go) by ruling. **Minted:** FS-89 (the missing theorem, rank 2), FS-90 (two hours of sanctioned search, rank 3, Kooshi's grant). **Re-aimed:** FS-59, FS-83, FS-84, FS-64 (row 92 and FS86-CL1), FS-67 (Zhang answers its main case), FS-76 (row 91), FS-87 (FS-86's kernel candidates). Every rank from 3 on moved down one. The earlier re-rank's paragraph follows.*

*The 2026-09-25 crunch's work is folded in at its three closes; the closing sections "Where the 2026-09-25 work on this lives" stay as addresses in: FS-39, FS-45, FS-47, FS-48, FS-59, FS-64, FS-67, FS-75, FS-76, FS-82, FS-83, FS-84, FS-86, FS-87, FS-89, FS-91.*

### § Open milestones, the paragraph as filed at FS-116's and FS-121's closes

**None is open.** FS-116, the local exclusion (`plans/STUB-local-exclusion.md`), and FS-121, the map step (`plans/STUB-map-step.md`), are **closed undecided** (rows 145–148 and 142–144; `plans/FS116-Z1-close.md`, `plans/FS116-Z2-close.md`, `plans/FS121-Z1-close.md`), with BASE-V beside them (row 134's base re-derived but for Lemma 4 at cusps). **Next, in Kooshi's order:** the filing of both closes; the workflow refinement (with CL3's count of what the search ban cost, `plans/FS116-close-inventory.md` O7); **FS-129, the cross-application audit** (`plans/STUB-cross-application-audit.md`; a special case, not ranked); then **FS-123, the (Q)-free ring** (`plans/STUB-qfree-ring.md`), rank 1, opening with whether a fragment's bends keep the class FS116-Y4-EMPTY reads (`plans/POROS-2026-10-03-close-reread.md` § 2.5, card 1). FS-124, the (Q) ring, is the alternative, and a second slot if one is staffed. **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close: `plans/FRONTIER-STUBS.md`'s closed list.

### the file's head

(the stub rule, WORKFLOW § Plan)

### the file's head

**Maintenance (WORKFLOW step 9):** the session closing a milestone updates the
open milestones,

### the file's head

**How a milestone is chosen.** Kooshi picks; the default is the top.
