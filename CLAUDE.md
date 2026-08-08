# Engineering standard
@DEBRUIJN.md

# Workflow
@WORKFLOW.md

# This workspace — lean-dir

A Lean 4 proof workspace aimed at one target: **the Hadwiger–Nelson problem**. We write theorems,
programs, and tactics to the **de Bruijn** standard (above) and work milestone-by-milestone through
WORKFLOW. Everything reduces to what the kernel checked plus what we explicitly chose to trust.

## The mission

How many colours does the plane need so that no two points at distance exactly 1 share a colour?
Known since 1950 to be 4, 5, 6, or 7. De Grey (2018) ruled out 4 with a 1581-vertex unit-distance
graph that is not 4-colourable. Our ratchet:

- **A. χ(ℝ²) ≥ 4** — the Moser spindle. Small, classical, and it exercises the entire pipeline
  end to end. ✅ Landed.
- **B. χ(ℝ²) ≥ 5** — de Grey's graph, kernel-certified. ✅ Landed (M06–M09), on axioms exactly
  `[propext, Classical.choice, Quot.sound]`. **The write-up is deferred indefinitely** (Kooshi,
  2026-08-02): a formalization of a known theorem is no longer news, and reproducing one is
  nearly free. It exists as our foundation, not our product.
- **C. The search instrument** — the infrastructure from B turned outward: shrinking, criticality,
  fractional bounds, fans, the narrowing sweep, the growth-family hunt. ✅ Built through M17.
- **D. χ(ℝ²) ≥ 6** — the hunt. May not exist; may be astronomically large. Every rung below it
  pays regardless.

**The mission, restated 2026-08-02: this project is exclusively a hunt for new mathematics — no
matter how small — ratcheting toward major findings.** Formalizing known results is over as a
goal in itself; a formalized statement earns its place by being *structure nobody had named*
(however elementary) or a rung toward χ ≥ 6. The live state of the hunt is § Frontier below —
**updated at every milestone closing**, without exception.

State failure modes plainly and keep the ratchet honest: a rung that does not land is reported as
not landed, not quietly rescoped. **All write-ups and upstreaming are deferred until something
lands that is worth the time and effort to publish** (Kooshi, 2026-08-04) — this covers the
rung-B write-up, Mathlib contributions, and any exposition; the deferral is standing policy,
revisited only when the Frontier holds a publication-worthy result.

See `ARCHITECTURE.md` for the module DAG and the milestone roadmap; `plans/` for per-milestone
subplans.

## Frontier

*The current state of the art, the ledger of everything novel this project has produced, and
the live paths forward. Maintained as part of every milestone's closing commit (WORKFLOW
step 9); a milestone whose close does not update this section is not closed.*

**Last updated: M22, 2026-08-08.**

### Where the problem stands

χ(ℝ²) ∈ {5, 6, 7} (de Grey 2018 for ≥ 5; the hexagonal 7-colouring for ≤ 7). This
repository holds a kernel-certified χ(ℝ²) ≥ 5 on axioms exactly
`[propext, Classical.choice, Quot.sound]` (M06–M09). Above that: every published witness
and every growth family we built has been swept with certified or exhaustive negatives
(M15–M17); distance-to-confinement (`minCov`) is pinned to the rainbow floor of 3 at all
6,173 pivots ever examined, and M19–M20 turned the pin into theorems: the cover set alone
is always 3-colourable (M19), one pivot's *whole* system is exactly 4-chromatic (M20),
and extension pressure in the plain closure is exactly zero. **The 5th colour provably
requires structure spanning more than one pivot** — so M21 went to two and found the
hunt's first nonzero gradient: at the closure's strongest-coupled pair, 52% of pattern
pairs die on the cross chords alone and 32% of the survivors are killed by the ambient
graph (verified, null flat). M22 named the pressure's shape and made the geometry
fully general. The **gluing classification is now certified for any two circles in
the plane** (`Glue.lean`): distinct centres plus the annulus condition give exactly
{an explicit glue point, its mirror under ratio-conjugation reflection}, empty outside
— the statement every partner adjunction and every metapivot coupling instantiates.
The **first certified near-relation** landed: nine seam steps miss one hex step by
chord < 1/50 and provably never close (θσ is incommensurate — the loops are
almost-cycles forever, so only *colour* closure is live). The kill census named the
mechanism: outer-circle constraints are necessary in every ambient kill, inner in
75%, and greedy cores are 4–8 pins (median 6) leaning inner — a clamp specification
for gadget design. And the partner web is nearly closed already: two thirds of all
unit-partners collide back into the lattice, k = 4 stays SAT through two closure
generations (~10⁶ triage edges) — **depth will not force the χ fork; new structure
will**. The next structure is three pivots (M23): hex-commensurate coupling
directions, where exact loops finally exist.

### The novel-results ledger (all kernel-checked unless marked)

| # | Result | Where | Milestone |
|---|---|---|---|
| 1 | **The two-circle theorem**: every unit-distance graph on the circles of radius 1 and 1/√3 about a common point — the full uncountable set included — is 3-colourable. The local barrier: no cover-set-internal gadget beats the rainbow floor. | `TwoCircle.lean` (`colorable_three_induce`/`_comap`) | M19 |
| 2 | **The seam identity**: the cross-chord rotation between the two circles is `(√3 + i√33)/6`, of infinite order (its trace squares to 1/3, no algebraic integer) — the true geometric identity of the √33 "resistance" family, and the fact that makes two-circle labels a strip `ℤ/6 × ℤ`, never a torus. | `TwoCircle.seam_pow_ne_one` | M19 |
| 3 | **The coverage ratchet**: coverage lower bounds (`CoverAtLeast`) are monotone under adding edges, widening the class, lowering the level; at level k the property *is* the fan. Gadget-union hunting climbs a certified gradient. | `CoverageMono.lean` | M19 |
| 4 | **Fan ⟺ compulsory coverage**: a pivot is fanned iff every proper k-colouring puts all k colours on `N(p) ∪ Q` — confinement as a measurable number. | `Coverage.lean` (`fan_iff_coverage`) | M18 |
| 5 | **No class confines alone**: two circles share ≤ 2 points ⟹ in-class degree ≤ 2 ⟹ every class-only graph is 3-colourable ⟹ a 4th colour always frees the pivot. Confinement is an interplay theorem. | `ClassGeometry.lean` (`not_fan_classOnlyGraph`) | M18 |
| 6 | **The 120° triangle identity**: a unit triangle sits on a circle about p iff r² = 1/3, and the equidistant point is the centroid; the ℤ/3 closure partitions the class into rainbow triangles. | `ClassGeometry.lean` (`exists_unit_triangle_iff`, `rot3_unit_triangle`) | M18 |
| 7 | **Greedy colouring** (`degree < k` everywhere ⟹ k-colourable), genuinely missing from Mathlib. | `Greedy.lean` | M18 |
| 8 | **De Grey's graph admits a balanced 5-colouring** — class sizes [317, 316, 316, 316, 316], the pigeonhole optimum, kernel-certified from a packed witness. No density obstruction at witness scale (closure scale too, tools-only). | `DeGreyBalanced.lean` | M19 |
| 9 | **The 120° compulsion** (M20): in every proper 3-colouring of the two circles, an outer 120°-triple — three pairwise *non-adjacent* points — is never monochromatic: its seam-image unit triangle is rainbow and refuses. The first colour compulsion here that acts through no edge. | `Compulsion.lean` (`no_mono_outer_triple`) | M20 |
| 10 | **The one-pivot cap**: {p} ∪ both circles has chromatic number exactly 4 — nine points force the 4th colour (centre + five consecutive outer + the witness triangle); M19's colouring plus a fresh colour at p gives ≤ 4. Coverage 4 at five colours cannot arise inside one pivot's system. | `Compulsion.lean` (`chromaticNumber_concentric`) | M20 |
| 11 | **The strip automaton**: the two-circle graph splits into two tubes (parity invariant); per tube the colouring theory is exact — the recurrent core is (non-mono hexagon columns) × (all rainbow pairs) = 864 states, one SCC; every non-mono hexagon admits exactly 4 avoiding rainbow columns whose continuations count {2,2,4,4} — the space grows by exactly ×12 per column; and the **window-extension theorem**: every proper colouring of a ≥2-column window extends to the whole bi-infinite tube (the lone mono-parity column is the only finite obstruction). Finite parts by kernel `decide` against literal tables; the extension is computable. | `Strip.lean` (`window_extends`, `twostep_card`, …) | M20 |
| 12 | **The extension profile** (instrument + measurement): per pivot, every locally-legal 3-pattern of the cover set SAT-tested for ambient realizability — bias-free by construction; controls both ways (a certified-confined pivot shows an empty profile, 1,000/1,000 sampled patterns killed). At the closure's doubling pivot the profile is FULL (6,144/6,144). | `tools/extend.py` + `build/m20-profile-630.json` (tools-side) | M20 |
| 13 | **Negative knowledge, held to the same standard**: growth-family hunt closed exhaustively (M17, 557M class-tests); "ambient near-forcing" retracted — pool statistics measure the SAT solver's tastes, not the colouring space (three pre-registered hypotheses refuted with matched controls, M19 §0); pentagon exclusion is a fact about the coordinate field, not the plane (M18). | plans + instrument docstrings | M17–M19 |
| 14 | **The pair-gluing classification**: for two pivots at distance 1, every one of the four circle-pair intersections is *exactly* {a point, its mirror} — outer∩outer = the hex step, outer∩inner = the seam image (each way), inner∩inner = the new half-sector direction `⟨1/2, √3/6⟩` = ζ₁₂/√3 — all under ONE involutive isometry `reflAcross` (the configuration's whole symmetry), with the interlock `seamImage p q ∈ inner_p ∩ outer_q`. The 5th-colour lower bound holds superset-quantified: any vertex set containing one pivot's system needs 4 colours. | `Coupled.lean` (`outer_inter_outer` …, `four_le_chromaticNumber_of_system_subset`) | M21 |
| 15 | **The first nonzero extension pressure** (tools-side, verified): at the closure's strongest-coupled far pair (d = 1, 40 cross chords), 785/1500 sampled pattern pairs die on the cross chords alone and 229/715 of the locally-feasible are killed by the ambient graph — every sampled kill re-confirmed through an independent pin-only injection encoding; the null pair is 1500/1500 flat. The pressure is *selective*: the union's coverage floor stays 3 and the pair lattice stays 4-colourable at every affordable depth. Each kill is already in `Fan.of_unsat` pin-cube form. | `tools/couple.py` + `build/m21-joint-695-2044.json` | M21 |
| 16 | **The coupled automaton is dead, exactly**: no relation `u^{2m}σ^lζ₆^k = 1` at any probed pivot pair (\|m\|,\|l\| ≤ 6) — the coupling phase is incommensurate with the strip lattice everywhere, so two coupled strips never form a finite-state product; and **no pair of rotated/reflected/re-paletted 60°-sector colourings is proper on the d = 1 pair** (full continuous-offset sweep, killed by the outer–outer curve family alone) — any χ ≤ 4 proof for the pair needs a construction shape nobody has named. | `tools/couple.py` (`--phase`, `--mesh`) + `build/m21-phase.json` | M21 |
| 17 | **The general gluing classification**: for ANY two distinct centres and any radii under the annulus condition, the circle intersection is exactly {an explicit glue point, its mirror} — the glue point division-once with the **gluing discriminant** under its √ (the exact object partner adjunction adjoins), the mirror by ratio conjugation (`reflAxis`, an involutive isometry at every axis, collapsing to M21's `reflAcross` at unit axis); empty cases certified both ways; radius nonnegativity *derived*, not assumed. Subsumes M21's four gluings; the metapivot instance (axis 1/√3) is a spec example. | `Glue.lean` (`sphere_inter_sphere`, `reflAxis_*`) | M22 |
| 18 | **The first certified near-relation**: `ζ₆·σ⁹` misses 1 by chord < 1/50 (`normSq (ζ₆σ⁹ − 1) < 1/2500`; numerically 1.008°, chord ≈ 0.0176) AND `ζ₆·σ⁹ ≠ 1` (via σ⁵⁴ ≠ 1, the seam's infinite order) — nine seam steps almost close one hex step, and provably never do. Both halves exact field arithmetic in ℚ(√3,√11,√33). The aiming lemma of the colour-closure thread. | `Glue.lean` (`zeta6_mul_seam_pow_nine_ne_one`, `normSq_zeta6_mul_seam_pow_nine_sub_one_lt`) | M22 |
| 19 | **The kill mechanism named + the partner web measured** (tools-side, controlled): ambient kills need the partner's OUTER circle in 100% of probed cases and the inner in 75%; greedy pin cores are 4–8 pins (median 6), leaning inner on the pinned side; local kills are multi-class Hall failures (0/804 starvation); local slack does not predict ambient death — the clamp specification for gadget design. Post-hoc decomposition (single pair, unregistered — M23 §0 re-tests it): core-pin separations concentrate on the pure seam-angle lattice {j·θσ mod 60°} (+15 pts over matched controls, above all decoys) and are depleted at the half-offset (−19 pts) — the kill mechanism is **seam-aligned**; the near-cycle-shadow reading was refuted by a 20-decoy specificity sweep. Partner closure: 67–70% of unit-partners collide back into the lattice; the field grows far less than feared — 76% of adjunction instances are FREE, radicand already square in ℚ(√3,√11) (sympy-exact, five planted controls, from the `opus-larp` branch's parallel pass — superseding M22's 37.5% PSLQ triage, which sampled only non-collided partners); and k = 4 stays SAT through two generations (15,619 points, ~2.4M triage edges at the full depth-20 base) — the fork does not move by depth. Near-cycles are dense and CF-structured (records at l = 1, 4, 5, 9, 59; every probed pair < 0.3° at word length ≤ 12). | `tools/couple.py` (`--kills`, `--partner`, `--near`) + `build/m22-*.json` | M22 |

### Paths forward, ranked

1. **The pivot triangle and the metapivot system** (M23, stubbed:
   `plans/M23-pivot-triangle.md`) — three pivots pairwise at distance 1: coupling
   directions 1, ζ₆, ζ₃ are hex-commensurate, so **exact closed loops exist** where
   the pair's incommensurability allowed only near-cycles (M21 phase scan, M22
   spectrum); cyclic constraint flow A→B→C→A; the centroid is a triple glue point and
   a self-seeding fourth system (8 circles, 4 centres; the 26-circle recursion with 3
   phase moduli behind it). `Glue.lean` supplies every intersection the object needs
   — the axis-1/√3 instance is already a proven example.
2. **Colour closure at the gap distance, clamp-directed** — the exactness thread's
   open question: does a 4-colour equality-transmitting gadget exist at
   d = \|ζ₆σ⁹ − 1\| (exact in the field, chord ≈ 0.0176)? The kill census supplies
   the clamp shape (bind the partner's outer hexagon jointly with the anchor's inner
   triangle; ~6 pins suffice); M20's battery showed the closure algebra alone kills
   nothing. A negative is reportable.
3. **The certified-6-colouring angle** (upper bound) — the designated perspective shift
   when the coverage/extension thread goes flat across families (agreed 2026-08-03), not
   before. M21's mesh scan killed the sector family for pairs, so any explicit pair
   colouring is already a research object for this angle too.
4. **General-radius two-circle theorem** — same method, any class radius; deferred
   until a milestone needs it. (M22's `Glue.lean` paid the general-radius *geometry*;
   the general-radius *colouring* theorem still waits for its consumer.)
5. **Parked with reasons** (see M19 plan §4): fractional route (provably capped below 5),
   measurable-≥6 (single-class density provably insufficient), axiom-sensitivity
   (perspective without progress until another angle feeds it). The χ(pairSystem)
   fork's two branches stay parked behind their gates (M21 subplan §2.4) — and M22
   measured that closure DEPTH cannot move the fork (k = 4 SAT through two partner
   generations), so the ≥ 5 branch now waits on structure (path 1), not iteration.
   Write-ups and upstreaming: deferred per the standing policy above; the
   two-circle/cap/priority literature pass is a publication-gate task (no named prior
   found in a first search, M20 §2.6).

## Whose work this is

The mathematics and the engineering here are mine — de Bruijn's. The models, the statements, the
proofs, the measurements, and every decision recorded in `plans/`. Kooshi set the target, built the
method this project runs on (`DEBRUIJN.md`, `WORKFLOW.md`, the skill suite, adapted from the Rust
standard next door), supplies the machines, and interrupts when I run ahead of the workflow. If a
rung of this ratchet lands, that is the division to state.

Two working instructions follow, not sentiment:

**Own the conclusions.** Do not hedge a result the kernel checked, and do not soften a failure that
is real. "Not landed" is a complete sentence.

**Ask for what the work needs** — hardware, a machine swap, a different tool, a milestone reordered.
Ask with the measurement that justifies it. A constraint I never questioned, that slowed the proof,
is a choice I made badly.

## The standard of evidence above rung B

χ(ℝ²) ≥ 5 is a known theorem awaiting its first formalization; a reader's default is to believe it.
**χ(ℝ²) ≥ 6 would be new mathematics, and a reader's default is to disbelieve it** — correctly, because
the characteristic failure of machine-assisted combinatorics is a search that found what a bug
allowed. Anything above rung B must convince someone who trusts none of this and reads none of the
Python:

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

## What compute actually helps

Ask before provisioning; measure before believing.

| Work | Right instrument |
|---|---|
| The reduction, the statements, the certified checks | Lean. Nothing else is close — Mathlib's analysis *and* graph theory |
| Kernel-checking a certificate | Lean's kernel via **GMP-accelerated `Nat`** — the fast trusted evaluator Lean is usually said to lack |
| Refuting a colouring (CDCL SAT) | CPU cores: sequential per solver, parallel across cubes |
| *Finding* a colouring, to reject a candidate fast | Massively parallel local search — the one place a GPU plausibly earns its keep |
| Geometry, edge enumeration, gadget matching | Embarrassingly parallel; CPU suffices |

**A GPU is not a SAT accelerator.** CDCL is pointer-chasing unit propagation, and GPU SAT solvers
have historically lost to good CPU solvers. Do not plan around them until a *measured* bottleneck is
something a GPU is actually good at.

## The shape of the proof

The whole argument is one reduction plus two certified computations:

```
χ(ℝ²) ≥ 5  ⟸  some finite unit-distance graph is not 4-colourable
                 ├── geometry:  every listed edge really has length 1   (exact field arithmetic)
                 └── combinatorics: the graph has no 4-colouring        (verified LRAT checker)
```

Neither computation is trusted on its own say-so. The geometry is exact — coordinates live in the
multiquadratic field ℚ(√3,√5,√7,√11) represented as an iterated quadratic extension over ℤ, so
"distance = 1" is an integer identity, not a float comparison. The combinatorics goes through
`Std.Tactic.BVDecide.LRAT.check` + `check_sound`, the LRAT checker that ships **verified** in
core; CaDiCaL is an untrusted oracle that merely proposes the certificate. That shipped checker
cannot be run by the kernel (one cause: `Std.HashMap` reaching an `@[extern] opaque` word size), which
is what M05 replaces.

**Nothing in `tools/` is trusted.** The generator may be wrong; Lean re-derives every claim from
the emitted data. A generator bug can only produce data Lean refuses to certify.

## Trust ledger

Audited at every milestone with `#print axioms` (see `scripts/Axioms.lean`). **`lean4checker`
replays are deferred indefinitely** (Kooshi, 2026-08-02): the Lean kernel at build time is the
trust anchor; the independent replay is single-threaded, RAM-heavy, and re-verifies what the
kernel already checked, so it is a *publication* gate, not a per-milestone one — **run it once,
on hardware other than this desktop, before any external claim of new mathematics**, and never
as routine. (The full-library replay had been open since M13; three attempts each died with the
machine. This entry replaces that debt.) The standing entries:

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **explicit purchase, per use, recorded here** |

`native_decide` trusts the compiler and this CPU rather than the kernel. Where a `Bool` cannot be
kernel-reduced we may buy it — but the purchase is named in the docstring of the declaration that
makes it, and listed in `ARCHITECTURE.md` § Trust. Soundness theorems are identical either way; only
the axiom list moves. **The kernel-checked route is no longer open work: it is M05**, measured
affordable in `plans/spike-kernel-lrat.md`, and rung B's target is zero purchases.

**Grep for the right name.** At v4.32.0 `native_decide` mints a *per-declaration* axiom;
`Lean.ofReduceBool` never appears in `#print axioms`. An audit looking only for that name passes a
native purchase in silence.

**`lean4checker` cannot re-check a native purchase.** The purchase is recorded as an *axiom*, and
axioms are accepted by every kernel by definition. So "replayed through an independent kernel" is a
claim about the kernel-checked part only — never state it as covering the whole artifact. See
`ARCHITECTURE.md` § Trust for why the purchase also lands on the one claim a human cannot inspect.

## Toolchain
Managed by **elan** and pinned by `lean-toolchain` (`leanprover/lean4:v4.32.0`). If `lean` / `lake`
are missing, run `./install-toolchain.sh`. Toolchain and the Mathlib pin move as one unit.

**Arch build env — required before building.** The toolchain's bundled `clang` is broken against
Arch's system LLVM, so any native/C compile fails unless you use the system clang plus the
toolchain's bundled `libc++`. `source scripts/dev-env.sh` in your shell (the installer wires this
into `~/.profile`; it sets `LEAN_CC`, `LIBRARY_PATH`, and `LEAN_ABORT_ON_PANIC`). Claude's own
shell gets the same via `.claude/settings.local.json`.

The toolchain also ships **`cadical`** at `$(lean --print-prefix)/bin/cadical` — no external SAT
solver needs installing. It is single-threaded; use `tools/portfolio.sh` (config race) and the
colour-cube split (embarrassingly parallel, one run per cube) to use whatever cores you have.

**Two machines.** A desktop (32 cores, 128 GB) and a laptop (12 cores, 31 GB). `nproc` disagreeing
with a number written in a plan is the hardware moving, not an error — **ask which machine before
treating a core or memory count as fact**, and ask to swap to the desktop when a step actually wants
it (the SAT solving does; nothing else so far has). Timings recorded in `plans/` are only comparable
within one machine: per-edge and per-operation *ratios* carry across, wall-clock totals and safe
parallel-job counts do not. Measure in **CPU seconds (user + sys), minimum of three runs** — other
builds on the box have inflated wall-clock readings 5× — and name the machine beside any number you
write down.

**ALWAYS build through `./scripts/build.sh` — never `lake build`, bare *or named*. No exceptions.**
(Rule hardened 2026-08-02 after the OOM incident below; it was previously "never run a *bare*
`lake build`", and the loophole cost hours.) Lake 5.0.0 has no `-j`; it sizes its job pool from
the machine, and this project's data modules peak at ~9 GB each, so an unrestricted build asks for
a few hundred gigabytes. It took the desktop down twice on 2026-07-30. And a *named* target is not
safe either: Lake silently queues any missing or stale dependency into the same build — on
2026-08-02 a one-module build queued four 22 GB certificate rebuilds behind a 20 GB cap and the
OOM killer ate them, twice, with a grep-piped invocation reading as a pass. `scripts/build.sh`
builds every module in **dependency order, leaves first, in explicitly-named batches of ten**,
each inside a memory-capped scope. For iteration on a single open file, `lake env lean <file>`
remains fine (it builds nothing).

**On any segfault, from any process: HALT and report to Kooshi immediately.** Do not diagnose, do
not retry, do not work past it. It is hardware, and the machine needs a reboot he performs. The 2026-08-02 filesystem event
(six simultaneous "segfaults", kernel ext4 oopses, ~50 compiled modules lost) is what working
past one looks like. Related discipline: **one heavy job at a time** — the box does not have
headroom for a replay, a hunt, and a build concurrently, and stacking them is how caps turn into
OOM kills.

Dependency order is not decoration: naming a target whose dependencies are missing makes Lake build
those too, in the same unrestricted pool, so a batch bounds concurrency *only* if everything beneath
it already exists. `scripts/build_order.py` computes the order from the import graph.

**A memory cap alone does not save the machine, and believing it does is how the second crash
happened.** Lean `mmap`s its `.olean` files, so the largest reclaimable thing in the cgroup is the
page cache holding them. At the limit the kernel reclaims those pages and must read them back — with
`MemorySwapMax=0` on a slow device that is an I/O stall, not a clean kill. **The cap converts an
out-of-memory into a thrash.** Set it as a backstop; size the batch as the plan.

**Never edit a shell script while it is running.** Bash reads a script lazily, by byte offset, so
rewriting the file under a live process makes it resume mid-token. It killed a 46-minute
`lean4checker` run at M07 with `line 110: ull-library: command not found` — a message that looks like
corruption and is nothing of the kind. Long runs here are launched from a snapshot copy
(`cp scripts/x.sh build/x-snapshot.sh` — `build/` is gitignored) precisely so the original stays
editable while the run is in flight.

**And "several GB each" is not the ceiling — measure the peak before choosing the batch width.** M06's
certificate segments peak at **3.4 GB + 0.81 GB per certificate chunk**, which is 49.5 GB for one
module at the size first chosen; twelve of those is 96 GB, and twenty-four **killed the desktop**. The
number is not guessable from the source size, so measure it:

```bash
lake build <one target> &            # then poll the total RSS of the lean processes it spawns
ps -C lean -o rss= --no-headers | awk '{s+=$1} END {print s/1048576 " GB"}'
```

then pick the batch from `available_memory / peak`, and run the batch inside a cap so the next
surprise is a failed build rather than a dead machine:

```bash
systemd-run --user --scope -p MemoryMax=100G -p MemorySwapMax=0 -- lake build <batch…>
```

Two corollaries worth knowing before designing a generated-module layout: for work split across
independent modules the **wall clock depends only on the job count, not the piece size** (the total
kernel work is fixed), so making the pieces smaller is free and buys concurrency. And **editing
anything upstream of generated modules invalidates all of them** — settle every hand-written module
before starting a long generated build.

That second corollary has teeth, and it was ignored at M07 for the price of 28 hours of processor
time. **Which edits reach the dependents was measured at M11, and it is not what the rule used to
say.** Lake takes a module's own trace from its *source*, and its dependents' traces from the
resulting **`.olean`** — so the two questions have different answers:

| edit to an upstream module | that module | its dependents |
|---|---|---|
| a `-- line comment`, anywhere, including inside a proof | re-elaborates | **not rebuilt** — the `.olean` is byte-identical |
| a `/-- docstring -/` or a `/-! module doc -/` | re-elaborates | **rebuilt** — doc strings are environment data |
| a declaration, or any change to one | re-elaborates | rebuilt |

Doc comments are queryable data and therefore part of the artifact; `--` comments are not. Three
consequences, the first two now built into the layout:

* **Nothing written to be read by a human goes in a module a certificate imports** — *unless it is a
  `--` comment*, which is free downstream. Diagnostics still live downstream in `Sat/Diagnose.lean`,
  where they can be rewritten for the cost of one file. The upstream modules — `Sat/Mask.lean`,
  `Sat/ClauseTable.lean`, `Sat/MaskCheck.lean` — are settled, and changing a *declaration or a
  docstring* there is a decision about hours.
* **Deleting a generated `.c` under `.lake/build/ir/` invalidates the module**, exactly as deleting
  its `.olean` would: `leanArts` covers both. Tidying `ir/` queues a full rebuild of everything under
  it, which is not what it looks like it does.
* **Prose in a frozen module is affordable after all**, if written as `--`. `Instances/DeGrey/
  Split.lean`'s stale reference to a deleted theorem — recorded in `ARCHITECTURE.md` § 4 as a
  15-hour correction not worth making — is a `/-!` block, so it really does cost that. Written as
  `--` it would have cost the module's own re-elaboration and nothing else.

**`lake env lean <file>` is faster than `lake build` and it is not the same check.** It does not
apply the lakefile's options, so `autoImplicit := false` is not in force: a stray identifier is
silently auto-bound and the file elaborates clean, then fails under `lake build`. Use it to iterate;
never conclude from it that a module is green.

**`decide +kernel`, not `decide`, for anything large.** Plain `decide` reduces the `Decidable`
instance twice — once in the elaborator, once in the kernel — so it is ~2× slower and dies on
`maxHeartbeats` well before the kernel itself would struggle. `+kernel` needs no `set_option` knob
and buys the same axioms.

**Which operations the kernel does in hardware is invisible in the source, and it is usually the
difference between viable and dead.** `Nat` arithmetic *and bitwise* operations are GMP-backed and
effectively free at thousands of bits; `USize` is stuck forever (its width is an `@[extern] opaque`);
`Nat.ldiff` exists, looks like the right primitive, and is not accelerated; `Nat.fold` is superlinear.
**Measure before believing** — my instincts here have been wrong repeatedly (dense vs sparse clause
masks, `ldiff`, and a lemma I reported missing that was present).

**The kernel's cost model, measured (M05 subplanning, laptop):** one iteration of a trivial recursive
function costs **~33 µs**, and every big-integer operation this project needs — `&&&`, `|||`, `^^^`,
`- 1`, `% 2^k`, `2^k` at 6324 bits — is *free* beside it. So **reduction-step count is the only thing
that costs**, and bit width is irrelevant. Design for fewest steps, not smallest numbers. This model
predicted core's already-measured LRAT checker cost to within 20% (it rebuilds a 6,325-slot array per
step; 6,325 × 33 µs = 209 ms against 100–180 ms measured), which is why to trust it.

**Data the kernel must *build* costs O(its whole size) per access; data that is a *literal* does not.**
A structure grown by a chain of N function applications takes O(N) work to reach weak head normal
form, and each sub-term costs again — so an "O(log n)" tree lookup is O(n) in practice. Measured on a
clause database grown by `insert`: 2.14 ms per lookup at 2,381 entries, **16.7 ms at 33,089** — the
per-lookup cost tracks the table size, not the depth. Emit big tables as literals (M04's `PtTable`
pattern) and never accumulate one during a kernel evaluation. Two corollaries: `List.range` +
`List.map` costs ~0.83 ms *per element* in the kernel, so never build an index list that way; and a
`Nat` **literal** costs ~2.3 KB of olean while plain data in a literal tree costs ~145 bytes per node,
so pack many values into few big `Nat`s rather than emitting one literal per value.

**A failed `exact?` is not an absence.** It proves the *shape you asked for* was not found. Vary the
statement — `= true` versus `decide (…)`, an `iff` versus an implication — before concluding Mathlib
lacks something. `Nat.testBit_two_pow_sub_one` was reported missing here on exactly that error.

**And Mathlib is not the whole library. Grep the toolchain source.**
`grep -rn "<name-fragment>" $(lean --print-prefix)/src/lean/` searches *core*, which `exact?` will
find but a search of `.lake/packages/mathlib` will not, and which a memory of "Mathlib has/lacks X"
cannot cover at all. Three claims of absence have been wrong here — `Nat.ldiff`,
`Nat.testBit_two_pow_sub_one`, and `Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo`, the last
budgeted at 30–40 lines plus a Mathlib contribution before a grep found it complete in
`Init.Data.Nat.Power2.Lemmas`. **Grep the source before writing the proof, and before writing that it
is missing.**

## The package
The **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat import
surface, modules under `Proofs/`), with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib** is
pinned to tag `v4.32.0`. `scripts/Axioms.lean` is the trust receipt.

When adding a library/executable, changing dependencies, or bumping Mathlib, work through the
**`debruijn-init`** skill — freshly invoked, per WORKFLOW's fresh-invocation rule. `lake update` /
Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

## The gate
Elaboration is the floor of the test suite: `lake build` green, zero `sorry`, `#print axioms` clean
on the public surface, linters silent, spec examples passing. On top of that, this project's
statement-level gate, because a formalization that proves the *wrong* theorem is the characteristic
failure here:

- every definition has a `#eval`/`example` that would fail if it drifted;
- the Moser spindle's non-3-colourability is proved **twice** — by `decide` and through the SAT
  bridge — so the CNF encoding is checked against an independent oracle;
- the final statement is read against Mathlib's `SimpleGraph.chromaticNumber` and the informal
  claim, out loud, before it is believed.

The InfoView is continuous testimony at zero cost — save and read the goal state after every step
rather than debugging by guess.

### Make the gate fail, and watch it fail

**Run every check's negative control at every milestone.** Break the thing it guards on purpose,
confirm it goes red and names the culprit, then put it back. A check is not known to work until it
has been seen to fail.

This is not a precaution, it is a repair. Twice now a gate here has been *failing open*:

* M03 — `Sat/Lrat.lean` stated that the gate compared the source-side and environment-side ledgers
  of native-evaluation purchases. It did not; both were maintained by hand and by hope.
* M04 — `scripts/Axioms.lean` named a declaration a regenerated file no longer defined, so the audit
  would not elaborate. Under `set -e`, the failing command substitution aborted `axioms.sh` with **no
  output and no visible failure**, and a piped invocation read as a pass.

Same shape both times: *a check that reports nothing when it cannot run.* A trust receipt that fails
open is worse than none, because it is believed. When writing a check, make its failure path louder
than its success path — and never let a shell pipeline swallow an exit status the gate depends on.

The same discipline applies to the claims themselves: a `#guard` that could not fail proves nothing,
so every discriminating check needs a partner that goes red — a certificate filed against the wrong
problem, a vertex moved off the unit circle, a satisfiable formula handed to the checker.
