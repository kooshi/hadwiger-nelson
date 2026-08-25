# M51 — the descent engine: iteration 3+ at speed (pre-subplan stub)

*Stub written 2026-08-24 at the M50 close, on Kooshi's direction: "our engineering for M51
should be focused on optimizing the speed of the whole process." Per the stub rule this file
carries everything the deciding session knew, so a fresh session with zero conversation memory
can subplan it with all meaning intact. Companion files: `plans/M52-nominated-gadgets.md` (the
stall-response plan), `plans/STANDING-QUESTIONS.md` (the durable ideas ledger — READ IT, it
holds the theory this stub only references), `plans/M50-batch-descent.md` §R (the evidence).*

## Mission context, in plain language

The project's target is χ(ℝ²) ≥ 6. The kernel already holds the reduction: a finite
unit-distance graph that forces one designated pair of points to receive the SAME colour in
every proper 5-colouring closes the theorem through the spindle
(`OneDefect.not_colorable_of_forced_equal`; one non-unit edge suffices —
`add_one_le_chromaticNumber_unitDistance_of_one_defect`). Exoo–Ismailescu's 214-point graph H
forces exactly such a pair (A = index 205, B = index 206) — but 446 of its edges are "cheats"
at distance 2 rather than 1. **The descent replaces cheats with certified unit-distance halos,
one batch per iteration.** If it reaches zero cheats, χ(ℝ²) ≥ 6. Every iteration also turns the
dial μ (fewest distance-2 edges of a non-5-colourable {1,2}-graph) down, which is publishable
progress in itself at the μ ≤ 1 jackpot.

**The state at M50's close** (all certified, `build/m50-object-S29-depth2r-it2v2-depth1.json`):
the composed object has **1,008 points, 403 cheats — 43 of 446 removed** in two batch commits
(19 then 24). The batch law is proven in practice: design ONE halo against the WHOLE batch's
separating-colouring list and removals compose by construction (G33). The iteration-3 floor
(edges essential alone) is **17 of 403**; the rest of the batch structure is described in
`plans/M50-batch-descent.md` §R6.

## Why iteration 3+ is the recommended frame (the evidence)

**The core probe (M50 §R6, the close's decisive measurement): growth alone re-opens every
refuser.** Each kept refuser edge `e` was re-asked on the grown object: enumerate the
separating colourings of (object − removed − {e}) exactly (55–500 seed classes each), then ask
whether the object's OWN depth-1 partner lattice (394,604 points) kills them. Result: **five
edges FALL clean** — including M49 hold-outs — **and the six others hold ZERO provably
surviving colourings** (2,402 classes, 2,351 killed, 49 undecided at 7,200-s caps, never
folded). The same edges refused every pool of the smaller object at M49. The committed
material's own partner lattice grows faster than the rigidity it must break: **the loop is
self-accelerating at depth 1** (G33's reading; falsifiers registered there — an iteration whose
lattice kills fewer than the last, or a width-stall fraction that grows).

**The named resistance:** 277 of iteration 2's 4,945 committable colourings have WIDTH-shaped
kills — strong-rung satisfiable, capped minimizations landing at 2,551–14,960 points and still
descending. These do not block the loop (they were re-hit into kept edges), but they are the
measured signature of the regime where depth-1 points stop sufficing; M49's restricted depth-2
gadgets (87–267 points each) are the priced response.

**The intermediate deliverable, guaranteed:** the spare-colour lemma (statement and sketch in
STANDING-QUESTIONS §K1) implies the object's pure unit part must cross from 4-colourable to
not-4-colourable strictly before the descent ends — and the crossing commit mints a **new
5-chromatic unit-distance graph** of a construction genre no published witness uses
(glue-lattice-grown). The monitor is one SAT ask per commit (`tools/m50_skewscan.py --unitchi`);
it reads 4-colourable at 1,008 points. This is a certified deliverable BEFORE any 6-result.

## The speed mandate (Kooshi, 2026-08-24): the loop's cost anatomy, measured

M50's iteration 2 broke every iteration-1 cost model and forced SIX engine swaps mid-flight
(§R6 records each with its regression). M51 makes speed a design goal instead of a repair. The
measured per-phase baselines on the desktop (32 cores), and the known bottleneck in each:

| Phase | it-2 measured | bottleneck | known lever |
|---|---|---|---|
| Pool build | 922 s, SERIAL, 1.2 GB | single-threaded candidate/census loop | parallelize `_partners_about` + the annulus census; CACHE the pool to disk keyed by object fingerprint (rebuilt ≥ 4× at M50 — pure waste) |
| Enumeration | 24 min (it-1, cubes) / hours (it-2 with restarts) | cube-round stretches; restart loss | it was EXACT both times — keep; persist cube state more aggressively |
| Profile | ~4 h at 3 asks/s (45,365 classes) | the ~139k-point core SAT per ask (~5 s UNSAT; SAT-side toward caps) | incremental SAT (pysat, NOT installed — evaluate installing python-sat: edge clauses built once per worker, avail lists as assumptions; plausibly 5–20×); or drop whole-pool semantics where the design only needs killability (see below) |
| Cover (wave) | ~1–2 h | per-colouring ladder + ddmin ~1–3 min each | already 12-wide; widen; batch the ddmins |
| Shrink | ~1 h | kills-all sweeps | already screened+parallel; live-set restriction (learned at M50: shrink against the COMMIT list, not the cover list) |
| Certify | 620 s | fine | none needed |
| Floor census | 378 s | fine | none needed |
| Hard unknowns | 49 asks undecided at 2 h | genuine SAT hardness | do NOT chase with caps — the cover kills these colourings with subsets, where whole-pool SAT is not the primitive |

**The engine's home and the hardware (set 2026-08-24, Kooshi's direction at the re-read).**
The hot kernel is rewritten in **Rust**, in the sibling repository
**`~/source/descent-engine`** (origin `a git remote`; created
and pushed 2026-08-24). Sibling, not nested — nesting would stack de Bruijn's Lean identity onto
the ferrous Rust standard; there is no CLAUDE.md above `~/source/`, so the sibling receives
exactly one standard (verified). The repo carries the ferrous standard/skills/workflow (from
`another of the owner's projects`), a CLAUDE.md naming this session **product owner** (SPEC.md is the
contract; semantic questions come back here; engineering decisions belong to the repo's
engineer — an **Opus subagent** works there as the Rust engineer, per Kooshi). `SPEC.md` v0 pins
the ask semantics (the tiered `whole_feasible`, seed-projection, kill monotonicity, the
three-verdict discipline), the wire formats by example, the acceptance gate (**verdict-exact
replay of the it-2 checkpoint corpus; `unknown` may only resolve, decided verdicts may never
flip**), and the design intent (persistent incremental CaDiCaL + bitset kernels; ≥ 30× on the
it-2 profile replay as the first measured target). The Python engine stays as the decorrelated
second encoding, run on a per-iteration sample. Phase 0 owes the repo its **fixture bundle**
(it-2 stage + checkpoint + a pool export whose format is settled jointly then).

**The engineer's launch shape (decided 2026-08-24, after two probe campaigns; Kooshi's "test
the claude code process route / find the one-session trick"):** the engineer runs as the
**in-session custom agent type `ferrous-engineer`** (`.claude/agents/ferrous-engineer.md` in
THIS repo: Opus frontmatter — lands on the 1M-context variant — with the Ferrous identity and a
context-quarantine paragraph as its SYSTEM prompt; the six ferrous skills symlinked into
`.claude/skills/` so the Skill tool can invoke them — both probe-verified end to end, including
a live ferrous-skill invocation from inside the agent). Known cost, measured: the lean-dir
claudeMd (~25–30k tokens) is STILL injected into custom agents (the docs claim otherwise —
measurement wins); on Opus-1M it is affordable and the quarantine held in the probe. Permission:
subagents inherit the PARENT session's mode (frontmatter permissionMode is ignored) — i.e. the
engineer works at this session's own independence level, no separate grant. Control loop:
task notifications, SendMessage resume with context intact, TaskStop; mid-run message delivery
is documented but unverified here. **Fallback, also fully tested:** the headless CLI route
(`cd descent-engine && echo "<order>" | claude -p --model opus --resume <session-id>`) — clean
context (Ferrous only, zero bleed), same-session continuity, clean permission denials; gotchas:
the resume prompt must arrive via STDIN (positional errors on 2.1.238), and headless defaults to
MANUAL permissions (pass `--permission-mode` explicitly). Headless `-p` workers register for
cross-session SendMessage (docs), so the fallback is steerable too if ever needed. Subagent cwd
inherits the parent shell's momentary cwd — the agent def mandates absolute paths for exactly
this reason.

**The server, and the courier model (Kooshi, 2026-08-24):** the big box (192–256 cores — count
uncertain) is available but **not for at least a month, and never interactively** — he starts
jobs and brings results back. So server work must ship as a **self-contained deliverable**: one
static binary + fixtures + a run script, fully checkpointed/resumable, unattended to completion,
results packed as a single bundle. This is written into the engine's CLAUDE.md as a standing
deployment constraint from milestone one. Consequence for planning: iterations 3+ run on the
desktop; the server is the home for a LATER wide sweep (e.g. the widened-batch enumeration +
profile), designed for but not blocked on.

**The structural speed question the subplan must answer first:** the profile's whole-pool
semantics ("does the ENTIRE pool kill this colouring") is the completeness question, needed for
the hitting set — but the cover only needs *a* kill per colouring. M50 already tiered this
(strong-rung UNSAT ⟹ killed, by kill-monotonicity; greedy extension ⟹ survives). The subplan
should consider inverting the pipeline: run the COVER first with cheap rungs, and whole-pool
profile ONLY the colourings the cover cannot kill cheaply — the expensive completeness question
asked exactly where it decides something (the hitting set's survivor list). Expected effect:
the 4-h profile collapses to minutes of cover plus a small residue of genuine asks.

**Engineering rules banked from the six swaps** (each learned at measured cost): thread pools
serialize on the GIL unless the work is subprocess-dominated — fork process pools after warming
caches; checkpoint every verdict (restarts and engine swaps become free, and the checkpoint IS
the regression set); `np.add.at` and per-round `np.repeat` are the slow scatter — cached rows +
`bincount`; rungs sorted smallest-first with fall-through, never break, on an oversized kill;
an `Undecided` is a third verdict everywhere and never folds; verdict messages must name the
cause that actually fired (incident 3); stage batches ACCUMULATE (incident 2); kill the process
GROUP (`setsid` + `kill -- -PID`); ONE heavy job at a time; on any segfault HALT and report.

## The shape of the milestone

1. **Phase 0 — the engine pass**: the speed levers above, each behind the standing regression
   (the profile checkpoint files + `--self-test` + the M49 reproduction controls). Decide the
   pysat question with a measurement, not a preference. Pool caching keyed by fingerprint.
2. **Phase 1 — iteration 3 at depth 1**: enumerate the 17-floor stage (seed-blocked), profile
   (or cover-first, per phase 0's decision), hit, design, certify, recurse. The core probe
   predicts most of the floor falls. Standing per-commit columns: χ(unit part), the floor
   census, the polarization table (`tools/m50_skewscan.py --scan`), the P5-style field census.
3. **Phase 2 — iterate until the depth-1 well runs dry** (the loop is cheap once phase 0
   lands); each iteration's numbers go in §R as they close.
4. **Phase 3 — the depth-2 escalation** for whatever resists: the restricted depth-2 pool
   (M49's machinery, M50's engines), priced by the width-stalls.
5. **Throughout**: the jackpot clause VERBATIM — any μ ≤ 1 at five colours is HALT AND VERIFY;
   any χ(unit) = 5 crossing is HALT, certify the minted witness, and report before continuing.

## Registered expectations (priors for the subplan to sharpen)

* E1: after phase 0, one full depth-1 iteration completes in ≤ half a desktop-day (prior 0.6).
* E2: iteration 3 removes ≥ 10 of the 17 floor edges in one commit (prior 0.6 — the probe's
  falls, discounted for composition effects).
* E3: the width-stall fraction grows across iterations (the G33 falsifier watched as a dial,
  prior 0.5 — either way it is the recursion's cost curve, G25).
* E4: χ(unit) crosses to 5 within the milestone (prior 0.3 — genuinely open; the crossing is a
  halt-and-certify event, not a background statistic).

## Failure clauses

Stall (no committable batch at depth 1 and depth 2 unaffordable): the milestone closes with the
measured cost curve as the finding and `plans/M52-nominated-gadgets.md` becomes the recommended
next — its calibration corpus and diet meter are already built. Engine regression (any swap
whose regression set disagrees): revert first, diagnose second. The 49 hard unknowns are NOT a
debt of this milestone; they die by subset kills or not at all.

---

# SUBPLAN (2026-08-24, on Kooshi's go; WORKFLOW step 3)

## §B. Decisions settled at subplanning

**B1. Two tracks in parallel; the descent never waits for engineering.** Track A (campaign,
Python): iteration 3 launches on the proven M50 pipeline as soon as its pool builds. Track B
(engineering, Rust): the `ferrous-engineer` agent builds the engine through work orders WO-0…WO-3
with per-order acceptance; the Rust engine takes over at the first iteration AFTER it replays the
fixture corpus verdict-exact. Alternative: the stub's original ordering (engine pass first, then
iterate) — rejected because the core probe says iteration 3 is high-yield NOW, the engineer's
compile cycles and the desktop's SAT hours barely contend, and iteration 3's run produces the
freshest fixtures for the engine's own acceptance. Confidence high.

**B2. Pool cache = fixture format = courier data, ONE artifact.** `batchkill.py` gains pool
save/load: a JSON manifest (object fingerprint, pool params, counts, fingerprint) plus npz CSR
arrays (`nbrs_seed`, `adj`, `nbrs_halo`, halo structure, coordinates, provenance). It serves as
(i) the cache that kills the 922-s serial rebuilds (keyed by object fingerprint — the stub's
"rebuilt ≥ 4× at M50, pure waste"), (ii) the fixture the Rust engine loads (npz is
Rust-readable), (iii) the data half of any courier bundle. Alternative: separate cache and export
formats — rejected: two formats are two bug surfaces and a drift pair. Confidence high.

**B3. Iteration 3 runs the EXISTING profile-then-cover pipeline; the cover-first inversion lands
in Rust only (WO-3),** gated by an equivalence regression on the it-2 corpus (final verdict sets
must match; only the work distribution may differ — sound because a cover kill is a whole-pool
kill by monotonicity, and the residue's whole-pool ask is exactly the old profile semantics).
Alternative: implement the inversion in Python too — rejected: double-implementing the trickiest
orchestration for at most one iteration's win. Confidence medium-high; flips if iteration 3's
profile projects past two days, in which case the Python inversion is reconsidered.

**B4. Batch width becomes a measured decision (re-read item 2).** Before iteration 3's design
phase: enumerate |S| for the floor-17 batch AND for floor+k widened batches (k ∈ {5, 10}, the
extra cheats chosen ascending by the §Sⁱᵛ floor-edge cost column). Commit width chosen from the
measured |S| growth and profile cost; P5-width registered below. The enumeration reuses the cube
engine; the sub-batch filter argument (M50 §Bʺ) makes the widest list serve every narrower batch.

**B5. Kernel sitting (phase 0k): new leaf `Proofs/HadwigerNelson/SpareColour.lean`** — K1 both
polarities with both contrapositives (§C), K3 as a consumer-shaped restatement (expected to be
mostly `Forces.comap`; verify before writing new machinery), K4 the entropy floor as a STRETCH
(statement in the skeleton; lands if the sitting allows, else carried to M52 explicitly, never
silently). Alternative: extend `Arity.lean`/`Fan.lean` — rejected: the M11 rebuild-cascade lesson;
a new leaf file costs nothing downstream. Confidence high.

**B6. The distance-to-crossing gauge (re-read item 5).** Per commit, alongside the χ(unit) SAT
ask: an estimate of the unit part's 4-colouring count (exact via the cube enumerator on the unit
graph if it completes in minutes, else a labelled sample estimate). The monitor stops being
binary; K1's contrapositive is the theorem behind the crossing event.

**B7. The cost-curve dial (re-read item 1).** Standing per-iteration columns in §R: pool size and
build time, |S|, per-phase wall clock, removals per commit, floor after, width-stall count and
fraction, the gauge, the polarization table, the field census — plus one extrapolation line
(next iteration's projected pool and |S|). The speed mandate is audited against this table.

**B8. Curiosity probes housed (re-read items 4, 6).** At iteration 3's first stall batch: the
width-stall ddmin OVERLAP census (do the stalls share kill mass? — if yes, one fat shared halo
beats the depth-2 escalation) and the SMOOTHNESS probe (compression/periodicity of width-shaped
colourings vs point-killable ones — if width colourings are smooth, they are the finite shadows
of the closure object, joining K2/Q3). The P5 60-vs-59 radicand reconciliation is a sitting. The
Parts-{1,φ} skewscan replication launches as a background job early in phase 1 (registered at
M50; M51's cover design consumes no nominated-distance reading, so nothing here waits on it).

**B9. The engineer's work-order ladder (product-owner side).**
* **WO-0 — scaffold**: `ferrous-init`, crate layout, jsonl/npz readers, `--self-test` skeleton;
  doubles as the live test of mid-run messaging. Accept on the ferrous gate.
* **WO-1 — the ask kernel**: masks/peel/greedy/tier logic + subset `feasible`, SIMD-first per
  SPEC §5; accept on verdict-exact replay of the it-2 checkpoint corpus at ≥ 30× (P3-rust).
* **WO-2 — incremental SAT**: vendored CaDiCaL via the incremental interface; accept on the same
  corpus, measured speedup reported honestly either way.
* **WO-3 — drivers**: profile sweep with checkpoint/resume, cover ladder + ddmin, the cover-first
  inversion (B3's regression), courier packaging. Accept on an end-to-end shadow run of one real
  iteration agreeing with the Python engine's commit decision.
SPEC.md is amended per order; semantic questions come back here; the engineer never blocks
Track A.

**B10. Server scope.** Not on M51's critical path (≥ 1 month out). WO-3's courier packaging is
designed for it; the nominated first server job is the widened-batch enumeration + profile.

## §C. The kernel skeleton (phase 0k; exact names verified against Fan/Forcer/Arity)

```lean
/-- **The spare-colour lemma, forced-equal polarity.** A `k`-colourable graph forces no pair
equal at `k+1` colours: lift the colouring along `Fin.castSucc` and recolour ONE endpoint to the
spare colour `Fin.last k` (proper: every neighbour wears a lifted colour). -/
theorem not_forces_of_colorable (hG : G.Colorable k) {p q : V} (hpq : p ≠ q) :
    ¬ Forces G (k + 1) p q := sorry

/-- Forced-distinct polarity: recolour BOTH endpoints to the spare colour — proper exactly
because they are non-adjacent, which is the load-bearing hypothesis. -/
theorem not_separated_of_colorable (hG : G.Colorable k) {p q : V} (hadj : ¬ G.Adj p q) :
    ¬ Separated G (k + 1) p q := sorry

/-- **The phase monitor's theorem** (contrapositive): a graph forcing a pair equal at `k+1`
colours is not `k`-colourable — at `k = 4`, the descent's carrier at μ = 0 is a 5-chromatic
unit-distance graph, so the χ(unit) monitor crosses no later than the final commit. -/
theorem not_colorable_of_forces (h : Forces G (k + 1) p q) (hpq : p ≠ q) :
    ¬ G.Colorable k := sorry

/-- **The gadget hard floor** (contrapositive): a virtual-edge carrier at `k+1` colours is not
`k`-colourable — every forced-distinct gadget at five colours is itself ≥ 5-chromatic. -/
theorem not_colorable_of_separated (h : Separated G (k + 1) p q) (hadj : ¬ G.Adj p q) :
    ¬ G.Colorable k := sorry
```

Spec examples: the bottom graph on two vertices (`⊥ : SimpleGraph (Fin 2)`, 1-colourable) has
neither compulsion at two colours. **The red (mutation audit): `K₂` is 2-colourable and
`Separated K₂ 3 0 1` HOLDS** (adjacent pairs are separated by properness itself) — dropping
`hadj` must break `not_separated_of_colorable`, and dropping `hpq` must break the Forces half
(at `p = q`, `Forces` is trivially true). K4 stretch statement (exact `Fintype` phrasing settled
at the sitting): a `k`-colourable graph on `n` vertices has ≥ `2^⌈n/k⌉` proper
`(k+1)`-colourings, by the subsets-of-the-largest-class injection.

## §0. Registered predictions (before any campaign instrument runs)

Verdict vocabulary as M50; removals need the triple; **jackpot clause verbatim: any μ ≤ 1 at
five colours is χ(ℝ²) ≥ 6 — HALT, re-derive independently, re-refute in a second encoding,
report before interpreting. Any χ(unit) = 5 crossing: HALT, certify the minted witness, report.**

* **P1-it3**: iteration 3's first commit removes ≥ 10 of the 17 floor edges. Prior 0.6.
* **P2-speed**: with the pool cache alone, iteration 3 closes in ≤ 1 desktop-day (prior 0.7);
  after Rust acceptance, one full depth-1 iteration ≤ 2 h (prior 0.6).
* **P3-rust**: WO-1 replays the it-2 corpus verdict-exact at ≥ 30× the Python ask kernel.
  Prior 0.6. Failure clause: the measured ratio is reported and WO-2's incrementality becomes
  the load-bearing bet.
* **P4-inv**: the inverted pipeline reproduces it-2's final verdicts exactly with ≥ 5× fewer
  whole-pool solver calls. Prior 0.7.
* **P5-width**: |S| for floor+10-cheapest ≤ 3× the floor-only |S|. Prior 0.5, genuinely open —
  this measurement alone decides the commit width.
* **P6-stalls**: the width-stall fraction at iteration 3 exceeds iteration 2's 5.6 % (the G33
  falsifier dial; either direction is the recursion's cost curve). Prior 0.5.
* **P7-gauge**: the unit part's 4-colouring count strictly decreases at every iteration-3+
  commit. Prior 0.55.
* **P8-crossing**: χ(unit) crosses to 5 within M51. Prior 0.3.

## §1. Phases (each closes with its numbers in §R before the next starts)

| # | phase | deliverable | control |
|---|---|---|---|
| 0k | kernel sitting | `SpareColour.lean`: K1 ×2 + contrapositives (+K3 check, K4 stretch), standard three axioms | the K₂ red; both mutation audits |
| 0a | pool cache/fixture (Python) | save/load + exporter; it-2 fixture bundle | fingerprint round-trip; rebuilt-pool equality |
| 0b | WO-0 (engineer, parallel) | scaffold + readers + gate | ferrous gate; mid-run messaging verified |
| 1w | width measurement | \|S\| at floor / +5 / +10; commit width chosen | sub-batch filters reproduce |
| 1 | iteration 3 (Python) | commit(s) + §B7 columns; stall probes (§B8) on first stall batch | M50 controls verbatim; always-run-the-ask |
| 2 | iterations 4+ | engine handover on WO acceptance; iterate while depth 1 pays | verdict-exact regression per swap |
| 3 | depth-2 escalation | restricted depth-2 pool for resisters | M49 gadget-cost controls |
| R | close | §R, Frontier ledger row + G-entries, report, memory | |

## §2. Discipline and practical notes

M50 §3 verbatim (double-encoding or kernel for every claim; `unknown` never folded; triple for
removals; segfault HALT; one heavy job at a time; waiters anchored; every pool a named CHOICE).
Plus M51's own: the Rust engine is untrusted like all of `tools/` — its verdicts enter rows only
through the same certification asks; every engine handover carries the verdict-exact regression;
engineer reports land in the M51 job record with their acceptance verdicts. Desktop scheduling:
the profile/cover own the box; cargo builds ride along; big Rust replay benchmarks run between
campaign phases. Costs tracked per work order (Opus engineer turns are billed).

## §Bʹ. The domain-modeling pass (2026-08-24, fresh invocation) — what it changed

1. **SpareColour.lean converges to four declarations with an asymmetric hypothesis map, and the
   asymmetry is derived, not chosen.** Primary pair in the repo's own vocabulary:
   `not_forces_of_colorable (hG : G.Colorable k) (hpq : p ≠ q) : ¬ Forces G (k+1) p q` and
   `not_separated_of_colorable (hG : G.Colorable k) (hadj : ¬ G.Adj p q) : ¬ Separated G (k+1) p q`
   — the Separated half needs NO `p ≠ q` (at `p = q` it already fails whenever any colouring
   exists), the Forces half genuinely does (at `p = q` it is trivially true). Contrapositives
   DOT-NAMED for their consumers: **`Forces.not_colorable`** (the phase monitor reads
   `h.not_colorable`) and **`Separated.not_colorable_of_not_adj`** (the gadget hard floor). The
   `k+1` carrier is minimal and complete (`Colorable.mono` subsumes more spare colours). K4 keeps
   a floor-division exponent (`2 ^ (n / k)`) deliberately — the consumer needs "astronomical",
   not sharpness. NO arity generalization (the independent-set variant is speculative structure;
   pair scope is the stated scope). New leaf file importing `Fan`/`Forcer` — imports are free,
   additions to those files are not (M11).
2. **A stage is a derivation KEY, not a blob.** The object is the only primary datum; the pool
   and the list are memoized values of deterministic functions of it. Fixture manifest therefore
   carries: the derivation key (object fingerprint, batch, pool params), each component's
   fingerprint, a combined **`stage_fp`**, and a **`schema_version`**. Checkpoint headers cite
   `stage_fp` (header v2, superset of the current `# |S| pool_fp`). The Rust engine REFUSES on
   any fingerprint mismatch — incident 2's whole class (mix-and-matched stage components)
   designed out at the format level, parse-don't-validate at the engine boundary.
3. **Drift prevention between the two engines is the corpus, versioned.** Both engines are
   readers/writers of the SAME files; the regression corpus is append-only (every campaign run's
   checkpoints join it); any semantic change bumps `schema_version` and replays the corpus.
   SPEC.md §6 to be amended with the manifest fields (a product-owner edit, WO-0 timeframe).
4. **The batch-widening order is intrinsically justified, and gets a free calibration.** The
   floor-edge cost column (mono-mass × |S|) is the first-order predictor of the |S|-growth from
   adding that edge to the batch — "cheapest first" IS greedy list-growth minimization. Phase 1w
   additionally reports measured Δ|S| per widening step against the column's prediction (free via
   nested sub-batch filters) — a G30-grade calibration of the proxy before anything leans on it.

## §Bʺ. The obligation-modeling pass (2026-08-24, fresh invocation) — proofs walked, invariants partitioned

1. **The four SpareColour proofs derive from two constructions and two library facts.** Both
   halves: lift along `Fin.castSucc ∘ C`, `Function.update` at one endpoint (Forces) or both
   (Separated) to `Fin.last k`; properness is a four-case split closed by "update misses other
   points" + "`castSucc ≠ last`" (exact Mathlib names queried at implementation, never recalled).
   The hypothesis map is confirmed by the proofs: `p ≠ q` is consumed at exactly one point (the
   update at `q` missing `p`), `¬Adj p q` at exactly one (the `v = p, w = q` properness case),
   and the Separated half's `p = q` case closes by substitution BEFORE any construction — no
   `hpq` owed, as §Bʹ derived. Contrapositives are one-line `mt`. **K3 downgraded to
   mint-if-free**: expected to be one `Forces.comap` application along an inclusion hom; if not
   literally one line, dropped (it licenses nothing the certification asks don't carry). **K4
   walked, stretch confirmed**: fiber-pigeonhole lemma (Loogle first), colour-class independence,
   set-recolouring injectivity via the `last`-preimage recovery; the `k = 0` corner is vacuous or
   empty-`V` and handled by one case; 40–60 lines, attempted only after K1 lands.
2. **The inversion's equivalence claim is over the verdict partial order, not verdict equality.**
   Caps make unknowns run-variant, so the provable regression gate is: with `unknown < killed`
   and `unknown < survives` (decided verdicts incomparable), the inverted pipeline's verdicts are
   **pointwise ≥** the it-2 profile's; any decided↔decided flip is a stop-the-line bug; unknown
   deltas are counted and reported, never folded. P4-inv's acceptance is restated in these terms
   (and the same order defines WO-1/WO-2 acceptance). The equivalence argument: a cover kill is a
   whole-pool kill by monotonicity; the residue's whole-pool ask is the profile's own function;
   hence hitting-set inputs (whole-pool survivors) are preserved.
3. **The widened-batch filter argument survives verbatim** — M50 §Bʺ's one-per-orbit proof used
   only `B ⊆ B′` and palette invariance, never floor membership. Caution promoted to a control:
   the breaking order pins to the WIDEST enumerated stage; every narrower filter inherits it, and
   the nested counts (plus the known 684/1,010/51,350 reproductions) are the green controls.
   Stage discipline verbatim from incident 2: stage = object − removed − batch, fingerprint
   checked against a hand computation before any profile.
4. **What the Rust regression cannot certify, with named mitigations.** Replay certifies
   exercised paths only. Non-coverage: SIMD remainder lanes, CSR padding, stage shapes outside
   the corpus, resume paths. Mitigations, each a WO acceptance item: a brute-force exhaustive
   list-colouring checker for ≤ 20-point stages inside `--self-test` (decorrelated by
   construction); differential fuzzing Python-vs-Rust on random small stages (the two-encoding
   discipline mechanized); the M50 planted controls ported (monotonicity probe, fake kill,
   fingerprint-mismatch refusal); crash-resume equivalence tests in WO-3. The load-bearing safety
   property is structural and stated once: **engine verdicts never enter certified rows — the
   certification ask is the soundness boundary — so an engine bug costs time, never truth.**
5. **Partition.** PROVE (kernel): K1's four; K4 stretch. PROVE (prose + regression): inversion
   equivalence (item 2), filter widening (item 3). TEST: stage_fp refusal (planted mismatch red
   in both engines), the gauge column (labelled exact/sampled), nested-filter reproductions.
   ASSUME (named): CaDiCaL as untrusted oracle (backed by certification asks); float geometry at
   engine level (backed by exact certify).

## §Bʹʹʹ. The experience-modeling pass (2026-08-24, fresh invocation) — the surfaces

1. **Lemma API corrections.** Contrapositives named symmetrically: **`Forces.not_colorable`** /
   **`Separated.not_colorable`** (hypotheses in signatures, not names; dot-resolution
   disambiguates). Spec examples pin the two things a caller actually does: a literal
   instantiation (`Forces G 5 → ¬Colorable 4`, testing `k+1 =?= 5` unification), and the K₂ RED
   as a POSITIVE example — `Separated K₂ 3 0 1` holds by properness alone — teaching why `¬Adj`
   is load-bearing. Docstrings carry the consumer sentences (phase monitor; M52's gadget floor).
2. **The resuming-session surface, structural.** `--status` prints: object + fingerprint,
   iteration, phase position, running jobs, THE NEXT COMMAND. Every background launch appends
   its command line + log path to `build/m51-jobs.txt` (append-only). The §B7 columns are one
   machine artifact (`build/m51-columns.json`) plus a rendered §R row per iteration. All three
   are phase-0a scope in `batchkill.py`.
3. **The work-order surface.** WOs live in the ENGINE repo as `plans/WO-*.md` (the ferrous
   workflow's native milestone shape). Each carries: deliverable; SPEC version pinned by git
   hash; acceptance tests WITH data addresses; interface freezes (product owner's); the
   engineer's explicit decision space; report-back = ferrous house format + a machine-greppable
   `ACCEPTANCE: pass|fail` line + measured numbers. SPEC is edited only by the product owner;
   amendment requests ride the engineer's reports.
4. **Kooshi's surface.** One dashboard row per iteration (removals, cheats left, floor, |S|,
   wall, width-stall %, gauge, χ(unit)); crossing/jackpot/hard-stall are HALT-AND-REPORT events,
   never columns; the explorer artifact gains an M51 pane at close.

---

# §R. Results (filled as phases close)

## §R0. Phase 0k — the kernel sitting (2026-08-24, LANDED first sitting)

`Proofs/HadwigerNelson/SpareColour.lean` (new leaf, imports `Fan`): **`not_forces_of_colorable`**,
**`not_separated_of_colorable`**, **`Forces.not_colorable`** (the phase monitor's theorem),
**`Separated.not_colorable`** (the gadget hard floor) — the §Bʺ-walked proofs transcribed
(spareRecolor via a set-parametrized if-then-else, the four-case properness split, the two
library facts `castSucc_lt_last` + update-misses). Spec examples: the ⊥-graph pair, the K₂
POSITIVE red (`Separated ⊤ 3 0 1` by properness), both literal-unification pins (`Forces G 5 →
¬Colorable 4` through `k+1 =?= 5`, both namespaces). **The red seen red**: applying the
forced-distinct lemma to K₂'s adjacent pair fails exactly at the `¬Adj` obligation (`⊢ False`).
Full build green through `scripts/build.sh`; audit lines added (axioms run chained behind the
pool build, log `build/m51-pool-audit.log`). **K3 verdict: already held** — `Forces.mono` ("more
edges only force more") and `Forces.comap` are in `Forcer.lean`; the set-level absorbing
statement is one comap-along-inclusion application; nothing minted. **K4: deferred to a later
sitting** within M51 (stretch as registered).

## §R1w. The widening decision — CLOSED BY MEASUREMENT, widening deferred (2026-08-24)

Both candidate orderings for widening extras died on contact with the data, before any
enumeration was spent:

* **The cost-column proxy is INAPPLICABLE to non-floor cheats** — a cheat still present as an
  edge has zero mono-mass on any separating list (the colourings are proper on it), so §Sⁱᵛ 2f's
  column prices only floor edges. §B4's "floor + k cheapest" carried this wrong presupposition;
  caught here, before the instrument ran (G21's genre, applied to our own subplan).
* **The historical-essentiality candidates are EMPTY**: M49's 29 lower-bound edges = 22 removed
  + 7 in the current floor + 0 elsewhere. Every edge that was ever essential-alone is already
  handled.

**Verdict: iteration 3's batch is the floor-17, and P5-width's premise is dissolved** (recorded,
not rescoped — its registered form assumed orderable extras). One structural fact banked for any
future widening: **profile verdicts depend only on (pool, class)** — cheat edges constrain the
class enumeration, never the pool ask — so a widened batch's marginal profile cost is exactly
its NEW classes, and verdicts transfer across batches by class string. Widening re-opens if a
principled order emerges (e.g. the hitting set's near-miss columns, post-Rust cheap |S|).

## §R0a. Phase 0a — the pool cache (2026-08-24, LANDED)

`save_pool`/`load_pool`/`_pool_fp` in `tools/batchkill.py`: npz CSR + JSON manifest,
`schema_version` 1, REFUSAL on schema/object-fingerprint/recomputed-pool-fingerprint mismatch
(incident 2's class designed out); `_build_pool` is cache-through (depth2r caches its depth1
substrate too). Self-test extended: cache round-trip exact (fp, nbrs, adj, prov) + the planted
object-fingerprint mismatch SEEN RED — `--self-test` PASS end to end. The jobs ledger
`build/m51-jobs.txt` is live (§Bʹʹʹ item 2; `--status` upgrade pending). Iteration 3 launched:
the floor-17 enumeration (stage = object − 43 removed − floor-17, the incident-2 assert green)
runs under setsid, log `build/m51-enum-it3.log`; the current object's depth-1 pool is being
built ONCE into the cache behind it.

## §R-INC4. Incident 4 — phantom duplicate classes from resumed-cube blocking (2026-08-25)

**Found by reading the enumeration worker while designing a utilization fix** (Kooshi's "we're
not at fully concurrent utilization" — the diagnosis pass found the bug before the swap).
**Mechanism:** on every round, a resumed cube rebuilt its blocking clauses over ALL object
columns (`range(obj.n)`) while fresh finds blocked over the seed projection (`blk`) — so a
resumed cube could re-find an already-found CLASS wearing different halo colours, once per
round, forever. Iteration 1 was immune (seed object: the projections coincide); every
blocked-on enumeration since was affected. **Measured scope:** the it-2 v2 list = 45,365 lines
but **24,810 distinct classes** (45 % duplicates); the it-3 first run = 141,313 lines, **82 %
phantom** (~25k real classes — the "3× bigger list" reading is retracted); the core-probe
per-edge lists inflated 25–35 % (e.g. (43,205): 500 lines / 354 distinct).

**Soundness analysis, stated precisely:** weak blocking finds MORE, never less — so every
distinct-class SET is still COMPLETE and EXACT; only multiplicities are wrong. The certified
commits never consumed any list (the certification ask quantifies over all colourings) and
STAND. The it-2 hitting/cover decisions are per-line with duplicate lines carrying identical
mono patterns and verdicts — decisions unchanged, work inflated ~1.8× (part of the it-2
profile's measured slowness). Corrections are bookkeeping, not re-runs: it-2 |S| reads
"45,365 lines / 24,810 distinct classes, set exact"; the core-probe class counts shrink
proportionally with verdict structure unchanged ("zero provable survivors" survives verbatim).

**The fix + the swap (E1), landed together with separated regressions:** `_enum_work` blocks
rebuilds over `blk` (in-stretch and rebuild blocking are now the same clause); assembly dedupes
by class projection (historical phantom lines dropped and counted in the row; a cross-cube
class duplicate is a partition violation and REFUSES); round progress reports DISTINCT classes.
Swap E1: one forked process per open cube per round, replacing the GIL-bound thread pool
(measured first: load 6 on 32 cores, 5 solver forks alive, parent at 100 % of one core).
**Control:** the swapped engine must reproduce the seed's |S₂₉| = 51,350 exactly in a fresh
scratch dir before it-3 resumes (chained: control red ⟹ no relaunch). G21/G30 filing at close:
"45,365 seed-classes, exact" was a headline whose count measured the enumerator's blocking
scope — the class-set half was exact, the count half was the instrument.

## §R-rust. The Rust scope after incident 4 (2026-08-25, Kooshi's utilization question)

The enumerator joins the Rust engine's scope as **WO-2's second consumer**: the same persistent
incremental-SAT machinery serves both the ask residue and enumeration — solver held in memory
per cube, blocking clauses added through the incremental API (no CNF rewrite, no fork, no
re-parse, learned clauses persisting), where the Python engine pays a file rewrite plus a
process fork per colouring even after swap E1. Acceptance: reproduce the seed's 51,350 and a
completed it-3 stage class-for-class (set equality), with the breaking order and pin scheme
exported in the fixture (bit-compatibility of `_brk_full` is the load-bearing detail). WO-1
(the ask kernel) stays first — its fixture is complete today and the profile is each
iteration's next bottleneck once enumeration lands. **cas-rs
(https://github.com/electrifypro/cas-rs, Kooshi's pointer, 2026-08-25): auditioned where a CAS
belongs** — the exact-geometry work order (the certify phase's 45 s/edge sympy nested-radical
wall and the numeric-250 label debt), benchmarked by the engineer against the bespoke
quadratic-tower-arithmetic alternative on real provenance chains; it is not a candidate for the
enumeration, whose costs are SAT- and orchestration-shaped.
