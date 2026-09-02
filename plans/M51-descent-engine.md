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
surviving colourings** (2,402 list lines = 1,755 distinct classes — the §R-INC4 recount,
2026-08-26; killed/undecided in line units, class-level undecided ≤ 49; at 7,200-s caps, never
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

**The core-probe recount (the riding bookkeeping item, done 2026-08-26):** all eleven
`build/m50-S-coreprobe-*.jsonl` lists deduplicated by 214-prefix — **2,402 lines = 1,755
distinct classes** (per-file duplication 16.5–35.6 %, mean 26.9 %; the total matching the
recorded "2,402 classes" exactly confirms that number was a line count). Class-level
consequences: the zero-provable-survivor verdict is unaffected (a duplicate class killed
twice is killed) and the "49 undecided" becomes an upper bound at class level (an undecided
line whose duplicate was killed is a killed class). Frontier row 45 and §R0a's citation
carry the correction inline. Per file: 0-20 348/288 · 115-212 134/97 · 118-212 118/96 ·
126-203 139/116 · 206-210 290/212 · 206-211 351/232 · 4-205 317/204 · 43-205 500/354 ·
58-213 65/50 · 71-107 85/68 · 98-213 55/38.

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

## §R-E2. Engine swap E2 — strong rung before the peel (2026-08-25, from WO-1's tier census)

The WO-1 planning session measured the reference's own tier anatomy by driving `peel_np` /
`_greedy_extend` / `feasible` through a shim over the exported it-2 npz (the semantics measured
are the reference's, not a re-reading): **~87 % of kills die on the strong rung (0.44–0.47 s),
which reads the UNPEELED masks — yet the peel (0.80–0.97 s) ran first and its output was
consumed only by tier 4.** The finding (Ferrous, F4 of `descent-engine`
`plans/WO-1-pool-and-ask-subplan.md`) was verified independently against the source here before
any change: `whole_feasible` hands `feasible(strong, av, hav)` and `_greedy_extend(av, hav)` the
original masks; only the full-core solve reads `alive`.

**The swap:** tier order 0 → strong → peel → greedy → full. Verdict-neutral by mutual
exclusivity (peel-to-empty ⟹ the whole pool colourable ⟹ every subset colourable ⟹ the strong
rung cannot kill), plus one improvement: a strong-rung kill now returns the **strong set**
(~1.5 k points) as the kill core instead of the peeled core (~140 k) — a proven kill set and a
far better ddmin seed for the design path (which had not yet run for it-3, so no existing rows
move). Also in the same commit: `save_pool` sorts `nbrs_seed`/`nbrs_halo` explicitly (the two
CSR families previously sorted only by inheritance — Ferrous's DEFERRED D13; existing caches
pass the loader's sortedness refusal, so this is future-proofing, not a repair).

**Regression gate (`$CLAUDE_JOB_DIR/tmp/gate_e2.py`):** the it-2 fixture (cached pool
0395d666c3eb9b3d), ALL 46 `survives` lines + 200 random `killed` lines (seed 51), swapped
engine vs the it-2 checkpoint; a decided–decided disagreement fails. **GATE GREEN: 246/246
exact agreement, 0 fresh unknowns, 0 decided–decided mismatches** (2026-08-25 ~13:50Z, ~25 min
on 28 workers). The it-3 profile was stopped at 10,768/46,350 checkpointed verdicts for the
swap and RELAUNCHED on the new engine (resume-exact, confirmed: "resumed 10768/46350 from
checkpoint"). Also this session: **the memory sweep Kooshi observed is characterized**
(`build/m51-mem.log`) — hard-ask clusters, not a leak: ~325 verdicts/min at 31–90 GB used,
then a cluster put all 30 workers into simultaneous tier-4 solves (throughput 13/min, peak
118.6 GB used / 10.2 GB available, swap +0.9 GB, self-recovered). Contingency knob added
dormant: `MECH_WORKERS` env override in `tools/mechanism.py`, default unchanged. WO-1 planning
is APPROVED and closed (descent-engine e754029, SPEC v0.4 = 3133be99dcdd84f7…); the strong-set
kill-core refinement is filed there as DEFERRED D14 for WO-5.

## §R-INC5. Incident 5 — a worker segfault hung the shrink, and 19 hours had no checkpoint
(2026-08-26)

At 13:32:28Z shrink worker 3342611 died of a **general protection fault in libpython3.14**
(`coredumpctl`: SIGSEGV; the machine's known hardware fault — the standing HALT rule fired
and Kooshi rebooted). The mp.Pool forked a replacement, but the dead worker's in-flight task
was lost, so the parent hung forever in `px.map` — CPU silent, every process asleep; found by
Kooshi noticing the silence. The exposure: `_shrink_halo` kept its state ONLY in the parent's
memory and saved only on completion, so the shrink's 19 h (halo ~2,000+ → 780, chunk-1 round)
is LOST; the cover state (`m50-cover-…-it2v2-depth1.json`, per-wave checkpointed) survived
intact. **CORRECTION 2026-08-26 (found by the WO-5 planning session reading the artifact —
not by me): the cover ended `covered 3390/3440, queue 0, STALL 50` (log line 85; the state
file holds `stall len 50`). My "3,440/3,440, zero stalls" record conflated queue 0 with
stall 0, written mid-incident and never re-verified. The 50 stalls are the width-shaped
deferrals (kill exists only in the oversized whole rung, no ddmin-able rung), and
`run_commit` (batchkill.py:1696) REFUSES on a nonempty stall list — so even a finished
shrink of this halo was never committable. The binding constraint of iteration 3 is the
50 stalls, not the halo's tail; WO-5's 50,000-point ladder cap targets them directly
(its P7 registers "more than half fall" as deciding it-3 committability).** **Consequences adopted: (a) the standing
checkpoint rule** (CLAUDE.md § Toolchain: every phase > ~15 min checkpoints at acceptance
points and resumes exactly; the audit question "if this dies now, what does the relaunch
redo?" answers in the subplan); **(b) the design phase moves to the Rust engine** (Kooshi's
direction at the restart: "use Rust for the descent") — WO-3 issued as the descent design
phase (cover + shrink) with checkpoint-per-acceptance a named acceptance clause; **(c) the
sequencing GAIN from the crash**: the residue re-ask runs FIRST now (the box is free and the
design must redo anyway), so if any of the 164 unknowns resolve, the hitting set re-runs on
merged verdicts and the design targets a possibly WIDER batch than commit-10.

## §S-CONT. SESSION STATE FOR CONTINUATION (2026-08-25, written at Kooshi's compaction call)

**Read this first in a fresh session.** WORKFLOW position: M51 step 7 (implementation). Phases
0k / 0a / 1w are CLOSED in §R above (kernel sitting landed + audited 539 clean; pool cache =
fixture format live; widening closed by measurement). Incident 4 (§R-INC4) is fixed, recorded,
and its Frontier correction committed. **Iteration 3's enumeration is DONE AND EXACT:
|S| = 46,350 distinct classes** (`build/m50-S-S29-depth2r-it2v2-depth1-it2v2.jsonl`, stage fp
a03ba8aefd06422d, every leaf closed by UNSAT; the fixed+swapped engine finished in 31 min what
the broken one churned overnight; the swap's control reproduced the seed's 51,350 exactly
first — both transcripts live back to back in `build/m51-enum-it3-v2.log`, so READ THE END, a
mid-file tail cost this session a false alarm).

**STATE AS OF 2026-08-26 ~02:45Z (updated at Kooshi's second compaction warning).**
**Profile: COMPLETE — 46,186 killed / 0 provable survivors / 164 unknown of 46,350**
(checkpoint `build/m50-profile-ck-S29-depth2r-it2v2-depth1-it2v2-depth1.jsonl`, 46,351 rows,
complete; ran on the E2-swapped engine at ~189 verdicts/min vs 98 pre-swap; the 164 unknowns
are 900-s full-core caps and are WO-2's named campaign deliverable — resolves come back as
checkpoint-JOINable sidecar rows, `unknown` → decided being the one legal revision, and every
`killed` can shrink the floor retroactively via a hitting-set re-run).
**Hitting: DONE — 164 survivors over 14 cheats → keep 7, COMMIT 10 of 17** (jackpot clause
did not fire; `build/m50-hitting-S29-depth2r-it2v2-depth1-it2v2.json` holds keep/commit).
**Design: KILLED BY INCIDENT 5 (§R-INC5)** — the 19-h shrink is lost; the COVER STATE IS
SAFE (`build/m50-cover-S29-depth2r-it2v2-depth1-it2v2-depth1.json`: 1,542-point pre-shrink
halo, **covered 3,390/3,440 with 50 STALLED classes** — see the §R-INC5 correction: my
earlier "3,440/3,440, zero stalls" was wrong, the stalls block `run_commit` outright, and
resolving them — not finishing the shrink — is iteration 3's binding constraint). Machine
rebooted 2026-08-26 ~14:14Z. NEAR-OOM RECORD stands: **it-4 profile launches use `MECH_WORKERS=26`**.

**The re-planned it-3 chain (tag `S29-depth2r-it2v2-depth1-it2v2`), per Kooshi at the
restart ("checkpoint everything long-running — standing rule; use Rust for the descent"):**


**STATE 2026-08-31 04:30Z — BACK ON THE DESKTOP (32 cores, 125 GB), written at Kooshi's
"collect ourselves, document, compact" call. Read this block first.** The desktop's hardware fault is
PROVISIONALLY REPAIRED. Both repos are clean
and pushed (lean-dir `506f674`, descent-engine `df0e279`). No process survived the laptop shutdown;
everything below resumes from checkpoints.

*What is on disk, mid-flight:* (1) **the it-4 enumeration** of the vdel28 object (batch 85 = 46 live
removed + 39 floor; block = 186 live seed vertices; stage `aca1b124b999f44c`, order
`2ec30bde119b5d6d`) stopped at round 16 — 246 cubes, 39 open leaves, 27,109 distinct classes after
7.4 laptop-hours; the cube manifest (`build/m50-S-…-vdel28-it2v2-cubes/`) resumes by default —
**same command, more workers**. (2) WO-10's leftover A1c shrink (`descent-engine/scratch/wo10/
acceptance/a1c/`, resumable by `scratch/wo10/a1c.sh`) — an acceptance row, not campaign state;
resume only if idle cores allow. (3) WO-7 built to its A2 boundary (`8dfbe88`), WO-10 built to its
SPEC boundary (`5223314`, 227 controls); **SPEC v0.8 lands with WO-7's A2, v0.9 after it with
WO-10's live A2**. (4) WO-11 (D44, the held leaf) stubbed (`df0e279`), not planned.

*THE DESKTOP PLAN, in order — every long step checkpointed, one heavy job at a time:*
0. **Pre-flight, first thing:** `cd ~/source/descent-engine/scratch/memcheck && ./memcheck 28 2 60`
   (rebuild with `rustc -O -o memcheck memcheck.rs` if the binary is stale) — one hour, the
   campaign's own footprint; **any event ⟹ HALT and report**. Ledger the result.
1. **Enumeration resume:** `MECH_WORKERS=26 nohup python3 -u tools/batchkill.py --enumerate --object
   S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28 > build/m51-enum-it4.log 2>&1 &` (resumes the
   cubes; READ THE END of the log; the assembled list is `build/m50-S-…-vdel28-it2v2.jsonl`; expect
   |S| well above it-3's 46,350).
2. **WO-7 A2 (a fresh GO session, one WO):** `descent-engine/plans/WO-7-outcome.md` §7's command
   against that list at `--threads 8` (D44 means it is effectively single-core; that is the
   measurement WO-11 needs) — EQUAL ⟹ that session applies SPEC v0.8 (nine literal blocks, WO-7
   subplan §14). Then WO-11's planning session can start (CPU-light, tree free).
3. **Pool + profile:** build/cache the depth-1 pool of vdel28 through the campaign (the pool export
   `build/m51-pool-c62ecd80a01087ca-depth1.{json,npz}` must carry `object.fingerprint =
   c62ecd80a01087ca`); then the Rust profile — `descent replay --manifest … --edges
   build/m51-edges-…-vdel28.json --object build/m50-object-…-vdel28.json --classes build/m50-S-…
   -vdel28-it2v2.jsonl --out build/m51-profile-it4-rust --threads N` (WO-10 outcome §11.2; the
   engine's memory model prices a complete-tier worker at ~7.8 GiB → N ≈ 14 here; it narrows or
   refuses and names the count). **This run IS WO-10's live A2** — its refusal legs and the
   duplicate-class meter's "keyed on 186 live columns" line are what a follow-up session scores,
   then applies SPEC v0.9.
4. **Hitting set** on the merged verdicts (`--hitting`; unknowns never folded), then `tools/
   export_sublist.py` for the committable sub-list.
5. **Design:** `descent design --manifest … --edges … --object … --classes build/m51-Scommit-…
   -vdel28-it2v2.jsonl --out build/m51-design-it4-rust --ladder-cap 50000 --threads 26` — and
   NOTE the record correction: it-3's zero stalls came from adopting the Python cover's 1,542 points;
   at it-4 there is no Python cover, so expect stalls of the 3,408/32 kind. **On the desktop the
   whole-pool pass is affordable (~8.6 GiB a worker → ≤ 12 workers): run WITHOUT `--no-whole-pass`
   so decision 29's whole-pool kills can dissolve them.** Shrink follows inside the same command
   (checkpoint per acceptance; kill-9 resume is an acceptance clause).
6. **Commit** with the patched batchkill (`--commit --pool depth1 --object …-vdel28`: checkpointed
   parallel lookup, lazy geometry, ~30 min) — refused ⟹ INVESTIGATE never retry; success ⟹ the
   new object, columns (`m50_skewscan.py --unitchi` — 4 → 5 is HALT-AND-CERTIFY; `--recurse`;
   `tools/field_census.py`; `--scan` on the it-4 lists), then **it-5**. Seed-vertex deletion is
   monotone and exhausted on this object; re-run `--vertex-census --seed-only` only after a halo
   commit adds material (new material can make a seed vertex deletable again — that is the one
   case the monotonicity argument does not cover).
Jackpot clause verbatim: any μ ≤ 1 at five colours is HALT AND VERIFY.

*Amendment 2026-08-31 (after compaction):* step 0 SKIPPED on Kooshi's call (his check is the
more dedicated probe); step 1 launched 26 workers from the cube manifest (246 cubes / 39 open / 27,977
classes read back). **Kooshi's scheduling direction, now standing (memory `wo-chain-pipelining`):** subplan
separable, benchmark-free WOs in PARALLEL on git worktrees, and PIPELINE the next WO's planning against the
current WO's frozen plan while it is implemented. First application: **WO-11's planning session is running
NOW in the worktree `~/source/descent-engine-wo11` (branch `wo11-plan` from `df0e279`)**, not waiting for the
two A2s — the main tree stays free for WO-7's A2 session; the planner takes A0 (the per-leaf census, P10) on
the seed and it-3 stages at ≤ 4 threads beside the enumeration and drafts SPEC **v0.10** against the v0.8/v0.9
drafts. On its freeze: I rule, merge `wo11-plan` into main (fast-forward or merge commit, my push), and a
fresh implementation session follows once v0.9 has landed. WO-9 (minimum halo, design crate — disjoint from
WO-11's enum crate) is the next parallel-planning candidate if Kooshi wants a second planner.

*Registered 2026-08-31 (Kooshi: "performance increased when loading only physical cores … this desktop only
has 16 real cores"):* the record holds two numbers, neither a clean SMT measurement — WO-5b §8.2 (laptop,
11 workers on 6 physical cores, asks 3–5× slower, but that chain was the speculative shrink's restarts) and
M50 swap 5 (desktop, 30 workers ≈ 16 effective cores, asks/s saturated — neutral, not harmful). For the
enumeration the worker count barely matters structurally (300-s stretches per open cube per round; 39 open
cubes → 2 waves at any W ∈ [20, 39], 3 at 16; oversubscription slows each stretch's yield without wasting
CPU), so the run is NOT restarted. **The clean measurement, to run in the gap between the enumeration's end
and the pool build (≈ 3 min, box otherwise idle):** K ∈ {16, 26, 32} copies of `cadical -t 60` on one
captured in-flight cube instance (`p cnf 9310 86821`, saved from `/tmp/tmpw780xn0v.cnf` to the session
scratchpad as `it4-cube-sample.cnf`; copy it to `build/m51-smt-sample.cnf`), aggregate `c conflicts:` per
second across the copies. **Prediction (prior median 1.15, range 0.9–1.3):** conflicts/s at 32 copies ÷ at
16 copies. **Decision rule:** ratio < 1.0 ⟹ every solver phase runs at 16 (enumeration `MECH_WORKERS`,
profile/design `--threads`); ratio ≥ 1.1 ⟹ keep oversubscribing; between ⟹ 16 on memory-tight phases
(profile), oversubscribe elsewhere. Result to be ledgered here with the conditions.
**RESULT (2026-08-31 02:40Z, box idle except the WO-9 planner at ≤ 4 threads; each copy one deterministic
154,747-conflict SAT solve of the captured instance):** 1 copy 24,078 conflicts/s; 16 copies 18,886/s each
(0.78× solo — memory-bound already at the physical core count: 11.96 solo-cores of 16), aggregate 287,938/s; 26
copies 11,268/s each, aggregate 303,887/s; 32 copies 9,756/s each, aggregate 311,957/s. **Ratio 32/16 = 1.083** —
inside the registered range, below the prior. Rule applied: **16 threads on the memory-tight profile; 26–32 on
bulk conflict-capped phases (+5–8 %); anything WALL-capped at 16**, since per-ask latency is 2.5× worse at 32.
Kooshi's recollection was right about per-solver speed and the loss is larger than the SMT gain suggests; the
aggregate still favours oversubscription slightly. (The in-run 16→28 arm on the enumeration was confounded by the
tree exhausting during the window and is not read.)

*2026-08-31 00:52Z — WO-7 A2 opened EARLY, by a refusal.* The Rust enumerator, run by me on the identical it-4
stage (batch 85, stage/order fingerprints EQUAL to the Python manifest: `aca1b124b999f44c` / `2ec30bde119b5d6d`) to
get |S| in minutes (76 classes/s on ~1 core against Python's 5.2/s on 26 workers), **REFUSED at the first 60-s
stretch boundary** — `point 186 is in the class key and outside this colouring of 186 points` — the `block` guard
WO-7 wrote firing on a cube RE-ISSUE with key-length digits where a full colouring belongs (invisible on prefix
blocks, caught on the gathered one). Fail-closed, as designed; A1's fixture never re-issued a cube on a non-prefix
block. A fresh WO-7 A2 session owns main now: diagnose → fix (one code path) + failing-first control → run to
`exact` (its count is the Python ETA) → compare command written as an addendum; **v0.8 applies only on an actual
EQUAL** against the Python list when it lands. Bundle: `build/m51-enum-it4-rust/` (read-only evidence). A first
launch with an EMPTY `--floor` (the census row's `floor` is a count; the list is `essential_alone`) built the
46-edge stage and was killed on its first log line — the stage fingerprint is the check that caught it.

*2026-08-31 01:35Z — WO-11 FROZEN (`242113e`, branch `wo11-plan`, worktree; 617k tokens, 1h43m; gate
re-executed by me: 227/227).* The planner overturned the stub's diagnosis with a measurement: **the tree is grown
BLIND** — `split_vertex` falls back to the first unpinned vertex of the descending-degree order when no class
exists yet, and first-occurrence palette breaking pins exactly that vertex to colour 0, so four of five children
are empty by construction (order[0..2] pinned still leaves 100 % of it-3's 46,350 classes in one cell; the
mechanism retrodicts WO-6's leaf sizes exactly on both stages). D44's held leaf is why the collapse is permanent,
not why it starts. **P10 is FLAT** (first-100 vs last-100 solve medians 0.9–1.5×; per-leaf ≤ 1.2×) — blocking
clauses cost nothing; **a task boundary costs ~1 s** (median first solve of an issue 901 ms vs 1.08 ms after; D45
priced it 28 ms — 30× low). Design: never grow blind (a 64-class census is enough FOR THE LOOP), class-counted
recall (linear), `--split-at` keeps two jobs, reactor untouched; predicted **8.8× at 8 workers on it-3**, seed
stage predicted SLOWER (0.8× at 4 workers, reported at face value). SPEC amendments drafted as **v0.10**, held
behind v0.8/v0.9. Adversarial review: 16 findings, all accepted, one a G21 instance in a G21-quoting document
(a sweep stopped at 32 splits called a plateau a cap). Rulings (sent to the planner for §18): decision 1 (paired
wall-clock ratio, not CPU/wall; floor 6 — the frozen §15 text says /5 while the report and §9 say 6: reconciled
to 6) APPROVED; decision 7 (blind first split at the TAIL of the order, guarded to fire only while no class is
held) APPROVED with one extra A2 arm (the same run with it off, so the guess gets its measurement); the seed
arm reported without a threshold APPROVED; the eight skim decisions APPROVED. Sequencing: WO-11's implementation
branches from main AFTER the WO-7 A2 fix lands (both edit `descent-enum/src/run.rs`), and v0.10 waits for v0.8
(WO-7 A2 EQUAL) then v0.9 (WO-10 live A2).
*Planner closed at `5223be4` (rulings in §18 verbatim; A2d = the blind-off arm with P12's prior 1.31×; §2.7
persists the fifteen-run inventory with load conditions and one killed run named). Worktree kept for the
implementer.*

*2026-08-31 02:05Z — THE IT-4 STAGE IS AN ORDER OF MAGNITUDE BIGGER THAN ANY BEFORE IT.* WO-7's A2 session
confirmed the refusal (INC-2: the blocking clause built in two index spaces — the worker's rebuild AND the
verifier, the second found by V3's `CONTRADICTION` after the first fix; one `ClassKey::blocking_clause` now,
width-checked, 227 → 233 controls, `1d8df44..32e12a8`), then ran the stage: **≥ 758,948 separating colourings
and rising at ~900/s on 4 threads** (it-2 45,365 · it-3 46,350 · seed 51,350; batch 85 vs it-3's 60 ⇒ ≈ 1.11×
per added cheat). The Python enumeration (69,368 classes in 2.4 h, 3.7 s/class) could never finish and was
STOPPED (cubes checkpointed). The Rust continuation runs at `--threads 16` (same `--out`, resumes;
`scratch/wo7-acceptance/it4-exact/`, `--max-classes 20000000`); the 16→28-thread restart is the SMT A/B on the
real workload. **The plan's cost model is broken at this |S|**: the profile/hitting/design chain was priced at
~5×10⁴ classes. **DECISION FOR KOOSHI, prepared from the finished list by `tools/subbatch.py`:** (A) full batch —
profile ~10⁶ classes (solver tail scales; days) vs (B) a SUB-BATCH — put floor edges back until |S'| is tractable
(the WO-8 filter: classes proper on the put-back edges, no solving; fewer cheats removed this iteration, hours
instead of days; the compounding lattice may cheapen the rest later, G33). WO-7's A2 EQUAL is likewise only
feasible on a sub-batch both enumerators can finish. The A2 session's memcheck at its footprint: 291 rounds,
0 faults, ≈ 2.3 TiB — the session's pre-flight, after the fact.
**EXACT (02:29Z): |S| = 2,588,314** (V1/V2/V3 verified, 3,249 leaves, 310,549 solves; kept as
`build/m51-S-…-vdel28-full85-rust.jsonl`, 4.8 GB). Sub-batch curve (`tools/subbatch.py`,
`build/m51-subbatch-it4-curve.txt`): two edges at vertex 206 carry 69 % of the count; k = 10 put-backs → 49,780;
**k = 11 → 37,316 (28 cheats removed)** ← the campaign's default; k = 20 → 3,186 (the WO-7 A2 fixture: both
enumerators finish it in minutes). Floor files `build/m51-floor-it4-{sub28,sub19}.txt`; `batchkill.py --enumerate
--floor-file` (subset-asserted) added for the Python side.
**Both sub-batch stages enumerated fresh and EXACT (02:55Z):** sub19 (batch 65, stage `a922c570172f7bd6`) =
**3,186**; sub28 (batch 74, stage `67670282647d53b6`) = **37,316** — each equal to the filter's prediction from the
full list, two independent code paths agreeing (the filter never solves; the enumerator never reads the full
list). **The campaign's it-4 list is `build/m51-S-…-vdel28-sub28-rust.jsonl`** (28 floor cheats spent: the 39
minus `build/m51-putback-it4-sub28.txt`). **The Python sub19 enumeration finished EXACT: 3,186 classes in 1,514 s at 16 workers, stage `a922c570172f7bd6` — the
same stage fingerprint and count as the engine's fresh run.** The sub28 Rust list was ADOPTED as the campaign's
`m50-S-…-vdel28-it2v2.jsonl` by `tools/adopt_rust_list.py` (stage fingerprint re-derived in Python from the object
and the header's batch; batch = 46 removed + 28 floor ⊆ census floor; the engine's exact/V1–V3 claim read; EVERY
line re-validated in Python — width, palette, proper on unit ∪ remaining cheats, forced pair separated; a planted
corrupted line refused; enumeration row recorded with `source.engine = descent enumerate`). **WO-7 A2 GO session
spawned on main (02:59Z)**: `--compare` on the sub19 fixture; EQUAL ⟹ SPEC v0.8 in WO-10 §11.1's block order with
the `removed_dead` correction. `batchkill.py --pool-only` added; the vdel28 depth-1 pool build is running.
**WO-7 A2 CLOSED EQUAL (03:20Z)** on the sub19 fixture — `ours 3186 · theirs 3186 · only ours 0 · only theirs 0`,
`inspect` deriving both fingerprints first, plus a decorrelated Python cross-check whose two plants go opposite
ways (a live-column mutation → NOT EQUAL; a deleted-column mutation → EQUAL, the dialect's own claim demonstrated
from outside). **SPEC v0.8 applied** (`e33f1e5`, nine blocks in the ruled order, `removed_dead` scoped to "derivable
given the object file, checked by design"); engine main pushed at `ca7489f`. The session's honest scope line: the
sub-batch is not weaker on what A2 tests (the gather, the wire field, the oracle) but is on exposure (3,186 classes
against 2,588,314; a defect firing below ~1/1000 would not show) — the full stage rests on V1∧V2∧V3 alone.

*2026-08-31 03:20Z — WO-9 FROZEN (`70a1154`, `wo9-plan` worktree) with a NEGATIVE verdict, by theorem:* a
criticality witness (a surviving colouring of halo ∖ {v}) is downward-closed, so every halo that is a SUBSET of the
current one keeps every witnessed point; **845 of it-3's 854 halo points are witnessed ⟹ any point-removing pass
saves ≤ 9 (1.05 %)**. The halo is not redundant (zero points serve one class; median 280 classes per point);
switching among the 21,868 recorded in-halo kill sets saves nothing and a from-scratch greedy lands at 1,694; **four
classes cover the whole halo and one (class 2387) needs 844 of 854** — the width-shaped kill of G33, seen from the
halo's side (to read against the 277/32 width stalls: possibly the same object twice). What survives of the stub:
1-minimal ≠ minimum, and the shrink's DELETION ORDER is the only live lever — a `--point-order` knob ships, the
iteration-3 order experiment (~14 h) is filed for a quiet desktop slot. Rulings: all approved; v0.11 after v0.10;
implementation small (design crate), scheduled for a quiet slot.
*Planner closed at `c0a5a50` (rulings §17; D56–D60 filed; the A2 "before" binary is the post-v0.8 merge base).*

*2026-08-31 03:40Z — Kooshi's direction, recorded:* (1) "update the descent algorithm document with everything
you've discovered or improved upon" — `plans/DESCENT-ALGORITHM.md` revised (`10d666b`: 0′ vertex deletion, 1′ the
class-count law and the sub-batch with its costs stated, the minimum-halo theorem and the width regime, adoption by
re-derivation, the engine's findings, the state table, and § The loop as a product); (2) **the 128-core server
(1.5 TB, confirmed) gets ONE BINARY running the whole loop unattended until a stated wall** —
`descent-engine/plans/WO-12-loop-binary.md` (stub: halt clauses, the phase coverage table Rust/Python/to-build, the
three rules, the order of work: WO-11 → v0.9/v0.10 → WO-9 → pool → floor/vertex → hitting → certify → driver).
His question — "I wonder what we lose out on" with the sub-batch — is answered in DESCENT-ALGORITHM 1′ (five
items: fewer cheats per iteration; the deferred edges are the width-shaped ones we would pay for anyway; soundness
and within-iteration composition intact; the joint-design interaction of all 39 removals is the genuine unmeasured
loss; class count is a proxy for dial progress).
*Addendum (Kooshi, minutes later): the server is DUAL-SOCKET — the loop binary must be NUMA-aware; recorded as a
requirement in the WO-12 stub (per-node pools, first-touch after pinning, per-node export replicas, `numastat` as
a column, per-node pre-flight; one reactor per node as the candidate shape) and in DESCENT-ALGORITHM § The loop.*

*2026-08-31 04:50Z — WO-11 IMPLEMENTED to its A2 boundary* (`wo11-plan` `7e9008a`, worktree; merge of main
`fc6fc73` carrying WO-7a; controls 233 → 244, twelve plants red; A1 EQUAL on five tree shapes (9–405 leaves), the
first informed split taking the globally best column 35/35 times; the seed's `--split-at never` arm beats
everything with zero empty leaves; P11 met, P3 met, P4 missed by two with a named cause, P8 missed; D44 CLOSED,
D45 corrected 30× (1.36 s median first solve), D57–D60 filed). Rulings: owner-side REFUSALS for the two
scheduler invariants (a refused enumeration costs a rerun; a wrong list a day), the `DESCENT_BLIND_SPLIT=off`
test-only knob, and `--max-classes` as a documented per-visit budget — all approved. **A2 session running now in
the worktree** (box quiet: one serial pool build + its timing probe) — the four paired arms; the unpaired 4.9×
against a floor of six is flagged as a live question, miss-with-anatomy preferred to a turned knob. v0.10 held.
**A2 RAN (quiet box, one binary, four commanded arms + four supplementary): MISSED — 2.32× at eight workers
against a floor of 6** (base 166.9 s unsplit one worker; wide 71.9 s). The anatomy is the result: ceiling 23.4×
(tree fine), wall = solver work ÷ 7.8 busy workers to three digits (schedule fine), and the loss is **3.57× more
solver WORK in the split tree** — 31 % cold starts (99 issues × 1.74 s) and 69 % a 2.47× per-class cost inside
pinned cubes (D61), monotone in cube count and already 2.29× at two workers, so not concurrency. The plan's 8.8×
rested on one coefficient measured under load 14.7 with tracing, with the wrong SIGN (split per-class cost was
taken as cheaper than unsplit; on a quiet box it is 2.47× dearer) — G21 in the engine's currency: *a coefficient
carried into a model is a measurement and inherits every condition of its run*. A2d (blind-tail split off) read
0.936×, so §15 decision 7 reopened by its own rule and closed the other way: **blind split OFF by default**
(`DESCENT_BLIND_SPLIT=on` the opt-in; the default pinned by a unit test). `--split-at 2000` is the measured
optimum. **WO-11 LANDS as built** (merge `5e1a88d`, 244 controls held on main, pushed): correctness EQUAL on
twelve arms, 2.32× the old binary's one core; the seed stage slower at 1–4 workers as predicted (0.58/0.76×),
1.22× at eight. D44 closed, D45 corrected 30×, D57–D61 filed. **WO-13 stub** filed on main: D45 + D61 as one
mechanism — pins baked into a rebuilt solver instead of ASSUMED on a long-lived one (CaDiCaL assumptions keep
learned clauses valid across cubes); measurement first, the target re-derived from 8 ÷ amplification.

*2026-08-31 08:10Z — THE PROFILE'S TAIL, and two experiments registered before their results are read.* The pool
export landed (vectorized build 5,523 s; **1,469,696 points**, 3.7× it-3; 11.4 M pool–pool unit edges; 1,464,545 of
the points have exactly two object neighbours — the pool's killing power is pool–pool cooperation, the width
regime). The Rust profile (WO-10's live A2) refused 16 workers by its memory model (118.8 GiB vs 94.3; 7.4 GiB per
complete solver over 43.5 M clauses) and named 12 — the designed narrowing, exercised for real. At 12 workers:
**26,857 of 37,316 classes answered in 1.5 h, ALL killed, 0 survive, 0 unknown** — but the sweep runs in index
order and the tail (≥ ~27,000, plus runs near 21–25 k) is complete-solver territory: 42 core solves so far at
0–1,758 s each, in index RUNS of consecutive classes; the last half hour answered 18 classes. A linear read is a
day or more; **stopped at the checkpoint** (append-only; resumes). Registered, with priors, BEFORE reading:
**(E1) locality ordering** (Kooshi: "assemble the graph in memory such that cache-level groups primarily contain
unit-distance material" — and, on the first two candidates, "not a space-filling curve … prioritize the unit
edges, greedily seed groups with high-connectivity points"): the same 207 classes (7 complete solves of 117–319 s
+ the 200 slowest rung refutations) on the raw export, RCM (`tools/pool_rcm.py`; median index gap between unit
neighbours 429 k → 255 k), Morton (→ 207 k), and **greedy unit-edge groups** (`tools/pool_cluster.py`: seed =
highest-degree unassigned point, grow by edges INTO the group to a block of 4,096; scored by the internal-edge
fraction per block size — the currency that matches the idea); verdicts must be identical (the control); paired
per-class solve times. Priors: RCM/Morton 1.0–1.2× (median 1.1), greedy 1.1–1.5× (median 1.25); < 1.05 ⟹ filed with
the number; ≥ 1.3 ⟹ a stage-assembly permutation in the engine (WO-12's pool phase), export order untouched.
**(E2) restricted pools as a POOL CHOICE for the profile** (`tools/pool_restrict.py`): the 42 known core-solve
classes re-asked on `strong3` (≥ 3 object neighbours: 5,151 points), `mixed16` (or pool-degree ≥ 16: 109,654) and
`pdeg12` (or ≥ 12: 285,973); a smaller pool is conservative (`survives` more likely; kills transfer by
monotonicity). Priors: strong3 kills ≤ 20 %; mixed16 ≥ 60 % at ≥ 5× speed; pdeg12 ≥ 85 % at ≥ 3×. Rule: a pool
killing ≥ 90 % of the core classes at ≥ 3× profiles the tail first (acknowledged pool choice), its survivors
re-asked on the full pool; otherwise the tail runs on the full pool (server-scale work, WO-12's case).

*2026-08-31 08:45Z — the two heavy cheats, identified (Kooshi: "those two points sound like χ = 6 coming into
view … what distance are they at?").* They are `206–210` and `206–211`, both distance-2 cheats, and **206 is the
forced pair's endpoint** (the pair is 205–206 at distance 5). 210, 211 sit at (−0.577, 0.915) and (−0.577, 2.915)
against 206 at (1.155, 1.915): `210–206–211` is an **equilateral triangle of side 2**, with each side's midpoint an
object point (unit-spaced collinear triples — the seed's 2-spindle geometry), unit degrees 18/14/15, three live
cheats each. Of the full stage's 2,588,314 separating colourings, 39.6 % are mono on 206–211, 34.1 % on 206–210,
69 % on at least one: the colourings that separate the forced pair overwhelmingly want the forced endpoint to share
a colour with one of its two distance-2 partners. Replacing these two by unit material would force the endpoint
apart from both at distance 2 in every 5-colouring — a virtual edge at distance 2 at the forced pair itself, which
is the shape the jackpot takes. The greedy put-back deferred exactly these (the widest kills). **Viewer built:**
`tools/descent-viz.html` (spliced by `tools/descentviz_refresh.py --object … --putback …`): points by kind and
provenance depth, unit edges, live/floor/put-back/removed cheats, the forced pair, per-vertex neighbourhoods with
rings at 1/√3/2, pan/zoom; refreshed on the current object (it-3 + deletion) and re-run after each commit.
**Published as an artifact for remote viewing: https://claude.ai/code/artifact/d35ad805-f5dd-483a-a03d-6160704ae6cf** —
after each commit: `descentviz_refresh.py` → `descentviz_artifact.py <out>` → republish with the Artifact tool to
that URL (`url=`), label = the object. The artifact copy carries the instrument's tokens (IBM Plex Sans/Mono,
ground `#0f1114`, selection amber) and is produced from `tools/descent-viz-artifact.tmpl.html`, never hand-edited.

*2026-08-31 09:40Z — E2 READ; E1's grouping rebuilt fast.* **E2 (restricted pools, the 42 core classes):** `strong3`
(5,151 points) kills 0 of 42 — all `core-coloured` in 11 s (prediction met); `mixed16` (109,654) kills 26 with 16
UNDECIDED at the conflict budget in 27,993 s — MISSED, and in the informative direction: a pool too small makes the
refutation HARDER, not easier; **`pdeg12` (285,973 = 19 % of the pool: ≥ 3 object neighbours or pool-degree ≥ 12)
kills 42 of 42 in 6,582 s against 20,609 s on the full pool — 3.13×, 100 % agreement — the registered rule is met**:
the tail (10,459 classes, `build/m51-tail-rows-it4.txt`) is profiled on `pdeg12` first as an ACKNOWLEDGED POOL
CHOICE (its smaller solver admits more workers; kills transfer by monotonicity), and its survivors/unknowns are
re-asked on the full pool. **E1:** the greedy heap grouping was killed after 1.5 h with no output (Kooshi: "it won't
amortize"); `tools/pool_groups.py` replaces it — capped two-level multi-source-BFS cells on the unit graph, sized
from sysfs (L2 512 KB, L3 32 MB at an assumed 1 KiB per point → cells of ~512 / ~32,768 points), 25 s, approximate
and machine-dependent by design. The metric says how much any grouping can buy here: the internal-edge fraction
rises from 0.000 / 0.021 (raw, L2 / L3 blocks) to **0.056 / 0.198** — four fifths of the unit edges still cross an
L3-sized block. The unit-distance graph on 1.47 M dense points is well-mixed (a point's ~8 unit neighbours sit on a
circle through ~280 k other points); grouping bounds the spread, it cannot localize it. The reset A/B
(`--solver-reset`, so per-class times are a function of the export alone — the first pass showed the SAME class
varying 0.02–1.9× with the worker's solver history) runs raw → RCM → Morton → groups; the tail on pdeg12 follows.
**E1 raw arm under `--solver-reset` (09:55Z): 3,073 s wall for the same 207 classes that took 1,361 s with solver
reuse** — the seven core solves from cold read 596 / 722 / 49 / 1,086 / 272 / 609 / 1,209 s against 596 / 2.8 / 46 /
89 / 271 / 401 / 107 s warm. So learned-clause reuse across asks is worth **2.3× on this sample and up to 250× on a
single hard ask** (WO-2 measured 2.59× on slack instances) — the biggest single lever measured today on the tail,
and the reason a worker's solver must NOT be rebuilt per ask (WO-13's mechanism applies to the profile as much as
to the enumerator). The RCM/Morton arms refused at the npz (an int64 `halo_seed_indptr` where the layout requires
u64 — my export copied a cast; fixed, regenerated, dtype-checked on all four exports) and are queued after the
tail; the groups arm is running; the tail on `pdeg12` follows it.
**E1 CLOSED (10:45Z), honestly inconclusive:** groups vs raw, paired under `--solver-reset`, verdicts identical —
totals 4,541 → 2,966 s (1.53×) on the seven core solves but per-class ratios scatter **0.20–3.87×** (geo-mean
1.14×): permuting the variables changes the SEARCH TRAJECTORY, and at n = 7 that variance dwarfs any locality
effect; the 200 rung refutations read 0.78× (slower). Prior was 1.1–1.5×; the measured geo-mean sits in it and the
noise swallows it — **filed as inconclusive-leaning-positive**, the RCM/Morton arms cancelled (1.7 h to measure the
same noise while the campaign chain waits). The definitive test is the server's, or WO-13's long-lived-solver
regime where layout interacts with a persistent clause database. Kooshi's question is answered by the METRIC: the
unit graph is well-mixed (0.198 internal at L3 blocks is the ceiling grouping reaches here), so cache grouping is a
bounded, cheap (25 s) stage pass, not a multiplier.

*2026-08-31 11:20Z — THE SEED'S CRYSTAL ANATOMY (Kooshi, from the visualizer: "most of the cheats are subgraphs of
dodecahedral lattices … multiple offset crystals, not rotated relative to each other"; measured exactly).* The seed
has NINE edge-direction classes (unit and cheat edges alike): two triangular-lattice families at **13.2213° and
46.7787°** — a mirror pair about 30°, and the angle between them is **33.5573° = arccos(5/6) = the MOSER TWIST**
(`FieldWall.lean`'s ρ = (5 + i√11)/6: the Exoo–Ismailescu seed is two crystal families related by the classical
4-forcing rotation, in the seam field — consistent with M49's seam-pool successes) — plus a sparse **axis family**
at {30°, 90°, 150°}. Each family decomposes into ~19 translated cosets (his "offset crystals, not rotated" — exact
within a family; ACROSS families the relation is the twist/mirror). Together the two families' six-plus-six
directions are the twelve-fold star his eye read as dodecahedral. Cheat census: 161 intra-coset + 160 cross-coset
in family A, 11 in B, **12 on the axis**. The axis family is the INTERFACE, and it is the descent's own story told
in geometry: three side-2 equilateral triangles (22-112-134, 56-78-168, **206-210-211**) and three DIAMETERS
through the origin (21-38, 77-94, 133-150 — the hex-shell diameter genre at the seed's own centre; midpoints at 0,
±(1/(2√3), 1/2), ∓1/√3 — the seam radius), plus 210-211. **Ten of the twelve are already removed** — M49/M50 ate
the interface first without knowing it — **and the only two standing are the heavy pair 206-210/206-211 at the
forced endpoint.** No single global mirror maps the seed to itself (0 of 214); the interface is locally mirrored
at several centres. Reading, falsifiable: the descent's endgame is the interface's last two edges, and the width
of their kills is the width of the twist interface itself.

*2026-08-31 12:05Z — THE HALO'S RING SYSTEM (Kooshi's second visualizer observation: "two incredibly distinct
rings … order 0.2 … the outer rings just touch each other, like electron shells"; census + PSLQ).* The halo-to-seed
distance census below 0.5 is pure spikes, and every major spike is **ℚ(√33), in √3-ladders**: r² = (6−√33)/3
(r = 0.2918, n = 1,782) with its ÷3 partner (r = 0.1685, n = 1,374); (9−√33)/18 (r = 0.4253, n = 1,487);
**(7−√33)/6 (r = 0.4574, n = 1,401) — literally the M33 3-cover-core shell radius** — with its ÷3 partner
(r = 0.2641). The rings sit on 213 of 214 seed vertices and halo points ring EACH OTHER (5,059 pairs at 0.2918).
The touching he saw is algebraic too: the nearest halo–halo spike is 0.0492 (n = 1,072), d² = (23 − 4√33)/9, with
its √3-partner 0.0851 = √3·0.0492; then (29 − 5√33)/18 and (75 − 13√33)/18; only a 30-pair family at 0.0362 lies
beyond the √3/√11/√33 field (deeper provenance). **Reading: G4's seam shell vocabulary is not a property of the
witnesses but of unit-glue closure over seam-field material — the descent's halo reproduces the same ℚ(√33) shell
system around every vertex, √3-laddered, shells touching at fixed algebraic gaps.** The two heavy interface edges,
the seam radius at the interface midpoints, and now the M33 shell radius in the halo: the E–I object and the
de Grey fabric are speaking one shell language.

**STATE 2026-09-01 02:30Z — PRE-COMPACTION CHECKPOINT (desktop). Read this block first; the day's findings are
the dated amendments above it.** WHERE THE CHAIN IS: it-4 runs on the k = 11 SUB-BATCH (28 floor cheats spent;
list `build/m50-S-…-vdel28-it2v2.jsonl` = 37,316 classes, adopted). Profile: full pool (`build/m51-profile-it4-rust/`,
26,857 answered, all killed) + the tail on `pdeg12` (`build/m51-profile-it4-pdeg12/`: 10,047 killed, 58 unknown,
354 never reached — STOPPED at 9.8 h; the 28 workers sat in 2 M-conflict asks). **Even with all 412 treated as
unknown, the hitting set keeps only FOUR cheats [(4,159),(25,52),(29,159),(194,203)] → 24 of 28 commit.**
THE STEPS, in order, every one resumable:
(b) `descent replay --manifest build/m51-pool-c62ecd80a01087ca-depth1-pdeg12.json <E> --threads 28 --out
    build/m51-profile-it4-pdeg12b --rows build/m51-tail2-rows-it4.txt --wall 300s` (the 354 unreached, wall-capped
    so nothing sits in the queue; a wall unknown is reported under its own name) — RUNNING in a chain with (c);
(c) all unknowns from both pdeg12 checkpoints → `build/m51-unknown-rows-it4.txt`; `descent replay --manifest
    build/m51-pool-c62ecd80a01087ca-depth1.json <E> --threads 12 --out build/m51-profile-it4-full2 --rows that
    --wall 900s` (the full pool, bounded); `<E>` = `--edges build/m51-edges-…-vdel28.json --object
    build/m50-object-…-vdel28.json --classes build/m50-S-…-vdel28-it2v2.jsonl --no-color`;
(d) ADOPT: `tools/adopt_rust_profile.py --object …-vdel28 --out build/m51-profile-it4-rust --merge-tail
    build/m51-profile-it4-pdeg12 [--merge-tail …-pdeg12b] [--merge-full build/m51-profile-it4-full2]` — the tool
    currently takes ONE --merge-tail and REFUSES missing rows: extend it to several tail dirs + a full-pool
    re-ask dir (full-pool verdicts adopted as-is; restricted-pool kills only; anything else unknown; never fold);
(e) `python3 tools/batchkill.py --hitting --deepest S29-…-vdel28-it2v2-depth1 --object …-vdel28` → keep/commit;
    `python3 tools/export_sublist.py S29-…-vdel28 S29-…-vdel28-it2v2` → `build/m51-Scommit-…jsonl` (check the name
    it writes); (f) DESIGN: `descent design --manifest <full pool> <E with --classes = the Scommit list> --out
    build/m51-design-it4-rust --ladder-cap 50000 --threads 26` WITHOUT `--no-whole-pass` (desktop affords
    ~8.6 GiB/worker); stalls expected (3,408/32 kind); shrink inside; resumable; (g) COMMIT: `batchkill.py --commit
    --pool depth1 --object …-vdel28` (checkpointed lookup; refused ⟹ INVESTIGATE never retry) → new object →
    viewer republish (`descentviz_refresh.py` → `descentviz_artifact.py` → Artifact url=…d35ad805…) → columns
    (`--unitchi` 4→5 = HALT-AND-CERTIFY; `--recurse`; `field_census.py`; `--scan`) → the 11 put-back + kept cheats
    return in it-5's floor; (h) WO-10's v0.9 session (the live A2 = this profile: the 16→12 refusal leg, the block
    line; then v0.10; WO-9 impl in a quiet slot). Rules unchanged: 16 threads on memory-tight/wall-capped phases;
    one heavy job; segfault ⟹ HALT; every long phase checkpoints.

**STATE 2026-08-28 11:30 UTC (LAPTOP) — the it-3 shrink is DONE, the commit triple is RUNNING
and is NOT resumable; the after-commit plan is saved here.** The Rust shrink finished cleanly
at 00:41 UTC 2026-08-28: halo 907 → **854** (97 critical witnessed, 9 kept-undecided at
budget, 0 stalls), verify 3,440/3,440 refuted, 0 undecided, `commit_ready` true (fields read,
not the headline); halo.json copied over `build/m50-cover-S29-depth2r-it2v2-depth1-it2v2-depth1.json`
(pool fp 5481c3fae64e770d = the Python original's). **Commit triple launched 00:43Z as pid in
`build/m51-commit-it3.pid`, log `build/m51-commit-it3.log`** — at 10.5 h it is still in stage 1
(the Python lookup re-check: `avail_masks` per colouring is pure Python over all 394,604 pool
points, then `feasible` builds a CNF over 854 + 794 old-halo variables and runs cadical per
colouring, 3,440 times, serial, `cap=1800` each). **INCIDENT (mine): `run_commit`/`certify`
keep no checkpoint — a single in-memory Python phase — and I launched it on the strength of
M50's 620-s desktop measurement (it-2's population: a 690-point object's pool, 24 cheats), which
did not transfer to it-3's (394,604-point pool, 854-point halo, laptop). The standing audit
question ("if this dies now, what does the relaunch redo?") was not asked at launch — a G21/G30
instance in my own hands. If it dies it is redone from the start.** FIX BEFORE IT-4's COMMIT:
per-stage checkpoints in `run_commit` (a per-colouring lookup verdict jsonl, resumable; then
one-hot / 3-bit / geometry each written on completion) and the lookup on `avail_np` +
`mechanism.pmap` (the profile path's vectorized twin, batchkill.py:375/1066) with the planted
control (a halo missing one critical point must be REFUSED). A read-only cost probe of one
colouring runs beside it (`build/m51-commit-it3-probe.log`) for the ETA. **RESOLVED 2026-08-28 11:40Z:** the probes
proved the old process was in `certify`'s eager sympy `intersect` loop over every deep halo point —
dead work (deep edges are certified at 250 digits from provenance; sympy is read only for depth-≤1
endpoints) whose nested-radical `expand` costs minutes per generation-3/4 point; both whole-object
asks are cadical SUBPROCESSES with caps, and no child ever appeared. **Patched (`9bbcff9`):** lazy
exact resolve; `lookup_recheck` parallel + checkpointed (`build/m51-commit-lookup-{tag}-{pool}.json`,
keyed by pool fp / halo hash / batch / keep / list size / object fp, replayed loudly on a matching
relaunch, survivors named); `geometry_only` for controls; `tools/commit_controls.py` all red/green
(four reds on a halo minus a critical point, replay/no-replay, lazy-exact green, bogus census pair
refused at 250 digits — the first RED-2, a float nudge, did NOT fire and was the wrong red: the
certificate is provenance-based and floats only find the census). The lookup stage standalone:
3,440/3,440 killed in 530 s at 8 workers. Old process KILLED at 10.9 h (log kept as
`m51-commit-it3-ATTEMPT1-killed.log`); **commit relaunched** on the patched code: checkpoint
replayed, 854 points built (check OK), 6,624 halo edges verified {exact 32, numeric-250 6,592} in
6 s, now in the one-hot ask (cap 3,600 s) then the 3-bit (cap 7,200 s) — pid in
`build/m51-commit-it3.pid`, watcher attached. **IT-3 COMMITTED 12:13Z (1,963 s): one-hot UNSAT, 3-bit UNSAT** —
object `S29-depth2r-it2v2-depth1-it2v2-depth1`: **1,862 points, 13,037 unit edges, 393 cheats**
(446 → 393; fingerprint `5380f9de38619905`, bare `3f1ac84c01ca4eec`; the first `fingerprint_bare`
carrier). Columns: **χ(unit) SAT in 0.1 s — still 4-colourable, no crossing**; the floor census
(`--recurse`, 393 asks, cap 240, now checkpointed per verdict, `4b48079`) running at 8 workers
(~80 s/ask, first 16 all deletable-alone); the field census (`tools/field_census.py`, new)
running; `--scan` waits for it-4's lists. NEW INSTRUMENT for plan (b): `run_vertex_census`
(`--vertex-census --label L [--seed-only] [--cap]`, checkpointed) — launches when the recurse
frees the cores, seed vertices first. The WO-6 implementation session is GONE (no reachable
agents) — its seed-scale GO needs a FRESH ferrous-engineer session from
`descent-engine/plans/WO-6-outcome.md` when the box is free. **13:20Z: floor census DONE — FLOOR 20 of 393, 0 unknown**
(3,858 s at 8 workers, 77.5 s median; floors 29 → 36 → 17 → 20 — the seven keeps all
essential-alone plus thirteen others; context-dependence again). **Field census DONE**: 1,648
committed points — 376 by construction, 1,121 in-catalogue numerically (61-value seed-pair
catalogue), 151 new-root on 8 distinct values. **Vertex census (seed-only, 212 asks) LAUNCHED
13:21Z**, checkpoint `build/m51-vcensus-…-seed.jsonl`, pid in `build/m51-vcensus-it3-seed.pid`. **13:42Z: SEED VERTEX CENSUS DONE — 37 of 212 seed vertices deletable ALONE, 0 unknown**
(1,234 s, 46 s median), carrying 124 cheats singly-counted; 175 essential alone. Composition
(`tools/vertex_delete.py`): all 37 at once is **SAT** (12 s) — they do not compose wholesale —
greedy sequential by cheats carried running (pid `build/m51-vdelete-it3.pid`, checkpoint
`build/m51-vdelete-{label}.jsonl`), then one-hot + 3-bit confirm. The object file is NOT
rewritten by it: a vertex-deleted object needs the model change (an `Obj.deleted` set: edges at
deleted vertices dropped, seed projection over LIVE seed vertices only, pool parents exclude
them, export sidecar and fingerprints aware) — the next engineering item if the composition pays. **IT PAID (15:26Z): 28 seed vertices deleted TOGETHER — cheats 393 → 298 (95 freed),
unit edges 13,037 → 12,735, CONFIRMED one-hot UNSAT + 3-bit UNSAT** (greedy by cheats carried;
9 refused in context; the confirm took 3,876 s, the 3-bit most of it). Deleted:
[49,172,51,15,17,73,91,92,100,106,108,122,143,147,148,156,185,191,202,192,204,13,32,68,124,145,188,207].
The set is MAXIMAL for this order (essential-alone is monotone under further deletion: object − D − v
⊆ object − v has the same separating colouring), not necessarily maximum — a second order is a cheap
measurement (D-item). **Three halo iterations: 53 cheats for 1,648 points; one deletion pass: 95
cheats for zero.** The descent's next move is therefore the VERTEX-DELETED OBJECT MODEL (below),
then it-4 from the 298-cheat object.

**SUBPLAN AMENDMENT (2026-08-28, WORKFLOW step 3 within step 7 — the descent gains a second move):
the vertex-deleted object.** *Statement.* A committed object O with live cheat set C and a set D of
vertices such that O − D (every unit edge and every cheat at D dropped) still forces A = B is a
{1,2}-forcer with |C − C(D)| cheats: μ descends by DELETION, at zero geometry. Deletions compose
only sequentially and only weaken the graph, so essential-alone is monotone (O − D − v ⊆ O − v) and
a greedy pass yields a MAXIMAL set for its order. *Model, index-preserving.* `Obj.deleted : set[int]`;
a deleted vertex keeps its index and its point (it may be the glue PARENT of existing halo points —
provenance, `check`, `mp_values`, `certify` resolve through it unchanged) but is EDGELESS:
`unit_edges()` drops edges touching it; `cheats` (now a property over `_cheats_all`) drops cheats
touching it; `A, B ∉ deleted` asserted; the object JSON carries `"deleted"` and `load_object`
applies it BEFORE verifying the fingerprint (edges determine the fingerprint; the deleted list is
verified as the set of edgeless seed indices). *Consumers.* (1) the seed projection blocks on LIVE
seed vertices only — `block_on = [v < 214 : v ∉ deleted]` at the enumerate call site and in
`enumerate_seps`; the header's `block_on` count and `order_fingerprint` change with it (the stage
identity moves, correctly); a deleted vertex's digit in a colouring string is free and ignored by
every consumer that indexes through neighbour lists. (2) the pool: `pool_depth1` builds glue points
about LIVE pairs only, and `Pool.nbrs` (hence `nbrs_seed`/`nbrs_halo`) exclude deleted vertices —
asserted at construction; the excluded-coordinate set keeps the deleted vertex's location (re-adding
it is un-deleting, a different move). (3) `halo_structure`, `avail_*`, `feasible`, `certify`: unchanged
— they read the filtered edge lists. (4) exports: `export_edges.py` adds `deleted` and `seed_live`;
the Rust engine's seed dialect (`--width 214`) blocks on the first 214 indices and must learn the
live block from the sidecar before it enumerates a deleted-vertex stage — a SPEC amendment (WO-7
candidate) filed AFTER WO-6's session releases the tree; it-4 enumerates with Python cubes if the
engine is not ready. *The commit.* `commit_deletions(label, deleted, new_label)`: load, apply,
`check()`, counts must equal the vertex-deletion row's (unit 12,735 / cheats 298), then the two
encodings re-run on the built object (one-hot cap 3,600, 3-bit cap 7,200 — the triple's solver
half; its geometry half is vacuous, no point added), then the object JSON with `deleted` written and
a `deletion-commit` row recorded. *Controls, seen red first.* (a) `deleted ∋ A` refused on load;
(b) save → load roundtrip fingerprint-equal; (c) reduced counts = the independent vertex_delete row;
(d) a pool built on the reduced object has no deleted parent or neighbour (assert) and a hand-planted
deleted parent is refused; (e) `enumerate_seps` header on the reduced object reports `block_on = 186`;
(f) the one-hot on the reduced object is UNSAT and, planted red, becomes SAT when one accepted
vertex's cheats are ALSO deleted from a refused vertex… (simpler red: deleting a refused vertex, 154,
on top of D is SAT — the census row already says so; re-asked as the control). *Cost.* the
implementation is ~150 lines over four sites; the commit's 3-bit is ~1 h on the laptop.
*Naming.* the reduced object is `S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28`; its iteration list
`m50-S-…-vdel28-it2v2.jsonl` by the existing `_ctx` convention. **LANDED 16:40Z (`3a43f96`): the model, the deletion commit,
`tools/deletion_controls.py` (ten guards red/green in 148 s: counts = the composition row 12,735 /
298; forced pair refused; roundtrip fingerprint `d6460615c957e19f`; tampered deleted list and A-in-
file refused on load; a pool on a deleted object has no deleted parent/neighbour, planted one
refused; live block 186; D + refused 154 → SAT, D alone → UNSAT), `commit_controls` regression
green. DELETION COMMIT RUNNING** (pid `build/m51-vdel-commit-it3.pid`; one-hot then 3-bit on the built
object → `m50-object-…-vdel28.json`). **CRITICAL PATH for it-4: WO-7 — the Rust engine's seed
dialect must block on `seed_live` from the sidecar (the `order_fingerprint` now hashes the LIVE
block, so the engine refuses a deleted-vertex stage fail-closed until it learns it); file it when
the WO-6 session releases the tree; `fingerprint_bare` now also moves with deletions (no longer the
pure point-set identity — a SPEC note).** Deletion is MONOTONE, so the seed move is exhausted for
this order on the reduced object; the only remaining seed-level lever is a different greedy ORDER
(measurement running: cheats-ascending, no confirm). **Result (16:08Z): the ascending order deletes 30 vertices and frees
the SAME 95 cheats (393 → 298) — a different maximal set (symmetric difference 8 vertices), the
identical value. Two orders agree on 95; not a maximum proof (a random order is a cheap D-item).
The descending-order commit (28 vertices, 12,735 unit edges) stands as vdel28.** A random order (seed 1) frees **93** (28 vertices) — so the value IS order-dependent; 95 is the best of three orders and the descending commit stands; an exact maximum over the 37 candidates is a D-item worth at most a few cheats. **DELETION COMMITTED 16:51Z (4,481 s):
`m50-object-S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28.json` — n 1,862, live seed 186, unit 12,735,
cheats 298, one-hot UNSAT + 3-bit UNSAT on the built object. χ(unit) still 4 by monotonicity. THE
DIAL: 446 → 393 (three halo turns) → 298 (one deletion pass). **IT-4 OPENED** on vdel28: floor
census running (`--recurse`, 298 asks, checkpointed); sidecar exported for WO-7's A2.** **19:00Z: IT-4 FLOOR = 39 of 298, 0 unknown** — the first census with capped asks (31 at 240 s,
all UNSAT at 1,200 s; median 183 s vs 77 s on the it-3 object: deletion traded slack for cheats and
the forcing margin is thinner). Floors 29 → 36 → 17 → 20 → 39. Stage batch 46 live removed + 39
floor = 85; **enumeration running** (Python cubes, `block_on` = the 186 live seed vertices; the
list `m50-S-…-vdel28-it2v2.jsonl` is WO-7's A2 input). **[19:10Z] WO-7 BUILT to the A2 boundary and pushed (`8dfbe88`)**: the projection is a
set of columns; 187 → 208 controls, each new one seen red under a planted regression (the plant
harness itself found two defects — controls journalling to a fixed temp path, and `rsync -a`
restoring mtimes so cargo reused a stale crate — both recorded, not smoothed); A0 refuses on the
order fingerprint against the real vdel28 sidecar (a two-implementation cross-check); A1 EQUAL on
both WO-6 stages (the it-3 orbit line now says 214, not 400); D48 filed. **A2 = a fresh GO session
running `WO-7-outcome.md` §7's command against the it-4 list once the enumeration lands; EQUAL ⟹
SPEC v0.8 applied by that session.** The halo-point (non-seed) deletion census — the cost
measurement — is deferred (~1,648 asks at ~200 s each: a day of laptop cores). *Note to the reader:
the dated blocks in this STATE paragraph are in insertion order, not clock order — read the
timestamps.* **[19:40Z] Kooshi's pick for the idle cores: WO-10** — the ask phases on a vertex-deleted
object (`descent replay`'s duplicate-prefix control degrades silently — D47; `design` swept for
`seed_n`-prefix assumptions; a fail-closed refusal where today there is silence; the it-4 memory
question priced: a whole-pool worker would be ~12 GB on the 1.3 M-point pool, two per laptop) —
stub `93a1a2b` pushed, planning session running; **D44 (the held-leaf collapse) is the work order
after**; the older WO-7 minimum-halo stub is renumbered WO-9 (`cfe40ba`). **[22:40Z] WO-10 IMPLEMENTED to its SPEC boundary and pushed (`5223314`)**: 208 → 227 controls
(19 new, each seen red under 17 planted regressions), gate green; A0 (the meter's silence on a
planted duplicate pair) demonstrated on the old binary; A1a/A1b exact; A1d `halo.json` and
`design.jsonl` BYTE-IDENTICAL across binaries; A2 on the real vdel28 object incl. the
`removed_dead` check agreeing at 7; D51 discharged (every memory "GB" was a GiB — labels fixed,
numbers unchanged); D50/D52/D53/D54 filed. SPEC v0.9 HELD until v0.8 lands (WO-7's A2). **RECORD
CORRECTION (WO-10 finding 3, REVIEW-METHOD item 6 fired on our own artifact): the it-3 design's
"3,440 killed / 0 stalled" was the product of FIFTEEN invocations plus the 1,542 Python-cover halo
points adopted through `--candidates-from`; a single fresh invocation of the same code on the same
stage settles at 3,408 killed / 32 stalled (23 no-rung kills, 9 conflict-budget). The commit was
carried by the certify (lookup re-check + two UNSATs on the built object), so nothing is unsound —
but "zero stalls" above is a RECIPE number, not a code number, and the Python cover's halo was
load-bearing in reaching it. The stalls at it-3 were dissolved by adoption, not by decision 29 alone.** **17:05Z: WO-6 ACCEPTED** — both class sets EQUAL (seed 51,350 in 63 s / 344 MiB; it-3
46,350 in 256 s / 491 MiB, `--threads 8`), P1–P5 met, SPEC v0.7 (`d37736a3…`) applied, 187/187
self-test re-run by me, pushed (`864979c`); FINDING: the cube tree collapsed to ONE held leaf holding
all 46,350 classes, so eight threads did one core's work — D44's own trigger fired (a separate WO).
**WO-7 stub filed + pushed (`04e1271`)** — the deleted-vertex dialect (live seed block = the key, the
blocking clauses, the order fingerprint, the width; fail-closed refusal as control A0; acceptance
A2 on the vdel28 it-4 stage against the Python-cube list) — **planning session RUNNING** (separate
implementation session after the freeze).

**Iteration 3's cost anatomy (measured from the Rust journal, 2026-08-28):** 85 halo points per
cheat (it-1: 25, it-2: 13 — the width regime arriving). Of the 845 witnessed-critical points,
**657 are witnessed ONLY by the 50 formerly-stalled classes** (188 by the other 3,390; a
witness is the first class found surviving without the point, so 188 is a floor for a
3,390-class halo, not its value); **one class, t = 2387, witnesses 414 points alone**; the 50
had cover-time kill sets min 211 / median ~300 (others median 146, min 1) — no small kill
exists for them. The Python shrink that died (§R-INC5) was at 780 with the chunk-1 round unrun
and covered 3,390 classes only. Dropping one batch edge does NOT dissolve the expensive
classes: 2387 and the other top witnesses each separate 9 of the 10 batch edges (t = 2387
separates every edge but (98,213)), so they need killing under any batch keeping any of those nine.

**AFTER THE COMMIT LANDS (Kooshi's question 2026-08-28, "what about shrinking the entire
graph?") — the plan, in order:** (a) the commit's outcome: refused ⟹ INVESTIGATE, never
retry; success ⟹ new object JSON (~1,862 points, 10 cheats removed → ~393 remaining), records
committed, per-commit columns (`tools/m50_skewscan.py --unitchi`: χ(unit) 4 → 5 ⟹
HALT-AND-CERTIFY; `--recurse`; `--scan`; field census). (b) **WHOLE-OBJECT SHRINK PROBE** — a
single-vertex-deletion census on the committed object (the `--recurse` shape over VERTICES: one
whole-object ask per vertex v ∉ {A, B}, object − v with the committed removals and A ≠ B; UNSAT
⟹ v deletable alone), **seed vertices first (214 asks, ~1–2 h laptop)** because a deletable
seed vertex takes every remaining cheat at it with it — μ descent by DELETION, cheaper than any
halo — then the full object overnight as the COST measurement (pool ~ n²: 394,604 at 1,008 →
~1.35 M at 1,862). Delete old-halo points only on a cost decision (G33: the committed lattice is
the kill mechanism). Deletions compose sequentially like kills — the census gives candidates,
the commit is greedy with re-verify (the triple). Engineering: the class machinery projects on
the seed's 214 vertices (`block_on 214`); deleting seed vertices needs a re-index. M49's
"vertex-minimal is 3× worse for LRAT size" is about the kernel certificate, not the descent.
MUST checkpoint per verdict (standing rule) — a jsonl of (vertex, verdict, seconds), resumable.
(c) then §S-CONT steps (4)–(8): WO-6 seed-scale GO (one heavy job at a time), it-4 with the fixed
resumable commit, the residue overnight, the weekend desktop hardware check.

**STATE 2026-08-27 (laptop — ONE active machine at a time; the desktop had a hardware fault at the time,
§R-INC6, fix attempt at the weekend; the laptop is 6 physical / 12 logical cores, 31 GB, no known
fault):** the it-3 DESIGN is running on the Rust engine (`descent-engine` WO-5 landed + WO-5b —
`build/m51-design-it3-rust/design.jsonl`, resumable by the identical command; committable list
exported by `tools/export_sublist.py` → `build/m51-Scommit-S29-depth2r-it2v2-depth1-it2v2.jsonl`,
3,440 classes). **COVER DONE: 3,440/3,440 killed, ZERO stalls** — the Python engine's 50 stalls
all fell to whole-pool solver cores (decision 29; P7 met 50/50; cover 8 m 36 s at 11 workers);
union 4,209 points → shrink running at the shipped default (`--trials 1 --threads 5`; speculation
across trials LOSES, measured A/B), halo 2,126 at last report, ~6–7 h floor on the laptop; WO-5c
(D34) PAUSED — no gain in the worklist's head, tail A/B later, fresh session. **Evening state:**
WO-5d LANDED (reported-versus-checked: `commit-ready` one derived verdict; replayed witnesses
audited on resume and REFUSED with a `sed` repair line on fault; stranded-trial leak fixed;
I5 check; 156 controls) and WO-6 LANDED TO ITS BOUNDARY (the Rust enumerator: all seven
campaign fingerprints DERIVED from the object-edges sidecar `build/m51-edges-<label>.json`
(`tools/export_edges.py`), bit-compatibility with `_brk_full` a startup refusal; 187
controls; the seed 51,350 / it-3 46,350 class-set-equality acceptance WAITS for the box).
Shrink at 16:57: halo 967 (from 4,209), 1,450 tried, 426 critical, 0 undecided. Three
Python defects found by WO-6's planner fixed (990b661: `_solve` raises on a crashed solver;
`enumerate_seps` defines `blk`; `twodist.fingerprint` docstring). Protocol hardened twice
today (one WO per session; one writer per tree — descent-engine CLAUDE.md). **COMMIT
PROCEDURE (revised):** after the shrink exits, re-run the IDENTICAL design command on the
NEW binary (resumes a finished journal: audits every witness, re-verifies with the honest
`is_clean`, rewrites the report) → read `design.json` `commit_ready` + `verified` myself →
copy `<out>/halo.json` over the cover path → `--commit` (certify decides) → then the WO-6
go. **POST-TRANSPORT (2026-08-27 evening, laptop): the shrink is RELAUNCHED on the identical
command with the WO-5d+WO-6 binary (pid in `build/m51-design-it3-rust.pid`; journal 386,292
records intact, 0 torn; the resume audits every `keeps` witness — a REFUSED line names a
`sed` repair; PID watcher attached).** **ON THE SHRINK'S EXIT — the procedure, in order:** (1)
read `build/m51-design-it3-rust/design.json`: `commit_ready` must be true AND the
verification's `undecided` must be 0 — trust NO headline, read the fields; (2) `cp
build/m51-design-it3-rust/halo.json build/m50-cover-S29-depth2r-it2v2-depth1-it2v2-depth1.json`
(the Python original is backed up as `…PYTHON-ORIGINAL-50stalls.json`); (3) `python3 -u
tools/batchkill.py --commit --pool depth1 --object S29-depth2r-it2v2-depth1` — the TRIPLE
(lookup re-check on all 3,440 + one-hot UNSAT + 3-bit UNSAT + exact geometry); refused ⟹
INVESTIGATE, never retry; success ⟹ new object JSON (~53 of 446 cheats removed, the first
`fingerprint_bare` carrier), commit the artifacts' records; (4) send the WO-6 implementation
session its GO for the two class-set-equality runs (seed 51,350 = `build/m50-S29.jsonl`;
it-3 46,350), then apply SPEC v0.7 from WO-6 subplan §14 on acceptance; (5) per-commit
columns (`tools/m50_skewscan.py --unitchi` — χ(unit) 4→5 crossing ⟹ HALT-AND-CERTIFY;
`--recurse`; `--scan`; field census); (6) it-4: enumerate with the Rust enumerator once
accepted (else Python cubes), profile on the Rust replay at ≤ 5 laptop workers; (7) the
residue (164 unknowns) overnight at 4 laptop workers when the box is otherwise idle; (8)
weekend: back to the desktop, a hardware check, remount, `descent-engine/scratch/memcheck` probe
before any heavy load there. Next: shrink finishes → `verify` → copy
`<out>/halo.json` over `build/m50-cover-S29-depth2r-it2v2-depth1-it2v2-depth1.json` (Python
original backed up as `.PYTHON-ORIGINAL-50stalls.json`) → `python3 -u tools/batchkill.py --commit
--pool depth1 --object S29-depth2r-it2v2-depth1` (the triple; refused ⟹ INVESTIGATE) → columns
→ it-4. The residue (164 unknowns) is BLOCKED on trusted hardware for long solves and DEMOTED
to overnight filler (4 laptop workers, ~16 h, resumable) — it can only widen the batch. Kernel:
K4 landed (`EntropyFloor.lean`, elaborates; build.sh gate + axiom audit await a quiet box).
1. **RESIDUE FIRST — LAUNCHED 2026-08-26 14:20Z** (28 workers, out `build/m51-residue-it3/`,
   log `build/m51-residue-it3.log`, ledger row in `build/m51-jobs.txt`): the WO-2 engine
   re-asks the 164 unknowns — command and preflight in `descent-engine/plans/WO-2-outcome.md`
   open item 1 (sidecar JOINable rows out; this supersedes the WO-2 paragraph's
   after-the-commit schedule below — the incident-5 redo made residue-first strictly better). Merge into the it-3 checkpoint (verdict join;
   `unknown` → decided only), then **re-run `--hitting`** on merged verdicts — resolves can
   WIDEN the commit batch past 10 and/or drop keep below 7. If the batch changes, the cover
   redoes against the new S_commit (it converged in ~1 h last time); if not, the saved cover
   state stands.
2. **WO-5 (Rust descent design phase) is the shrink's new home** — subplan FROZEN at
   descent-engine `9ac56af` (2026-08-26, after TWO adversarial rounds: 18+13 findings,
   3 design-class, all resolved — reviews in `descent-engine/scratch/reviews/`; SPEC bumped
   to v0.6 = `8616f342…` with the six amendments applied; pushed `3e9e37e`), implementation
   session RUNNING under the box constraint (no real-stage runs until the residue frees the
   cores). Key design rulings: reading A of the presence encoding (old halo unconditional, no
   presence literal); EVERY ladder rung truncated to `--ladder-cap`; **a whole-pool refutation
   is a KILL with a solver core, not a stall** (decision 29 — the Python engine's 50 "stalls"
   were `core_alive` at ~344k points, never a refutation core, so the Rust second pass may
   dissolve iteration 3's binding constraint outright) (cover + shrink with
   checkpoint-per-acceptance as an ACCEPTANCE CLAUSE;
   the Rust shrink's output halo is verified independently by the Python lookup before any
   commit — soundness by the certify, not by replay-exactness). Python fallback if WO-3
   slips: add per-acceptance `_save` inside `_shrink_halo` (5 lines) and relaunch.
3. Commit unchanged: `python3 -u tools/batchkill.py --commit --pool depth1 --object
   S29-depth2r-it2v2-depth1` (the TRIPLE; refused ⟹ INVESTIGATE). Success ⟹ ~53+/446
   removed, new object JSON = first `fingerprint_bare` carrier.
4. Per-commit columns as before (χ(unit) crossing ⟹ HALT-AND-CERTIFY; `--recurse`;
   `--scan`; field census); then it-4 (enumerate → profile at MECH_WORKERS=26 → …).
**The paper-grade algorithm statement now exists: `plans/DESCENT-ALGORITHM.md`** (the loop,
the soundness architecture, the tightrope sizing principle credited to Kooshi, the descent
table) — keep its state table current at each iteration close.

**WO-1 IS LANDED AND ACCEPTED (2026-08-25, both phases, same day).** The phase-boundary
protocol ran end to end: planning session (subplan approved at descent-engine `e754029`; three
SPEC-changing findings F1/F3/F6-precursor, the tier census, the propagation tier F5, and F4 —
the peel/strong-rung order costing the campaign ~2.5×, applied here as swap E2, §R-E2), then a
FRESH implementation session from the durable record alone: **gate green 76/76 controls
(verified independently by me), the full 45,365-line it-2 replay with ZERO decided–decided
disagreements, coverage 40.8 % with the propagation tier / 3.3 % without, prefix-group control
0 disagreements, difftest 1,000 comparisons 0 contradictions with a planted red** (commits
`2b528bd` + `fc86dd9`, pushed; acceptance evidence in `scratch/results/wo1-acceptance.json`).
**SPEC is v0.4.1**: v0.4 = amendments A1 (class width = object width, seed-prefix ask,
block_on optional), A2 (strong rung = OBJECT-neighbours ≥ 3), A3 (tier 0b propagation,
domains discarded), A4 (tier numbers are names, order free and reported); v0.4.1 = F6 ruled —
`fingerprint_bare` (the point-set identity) joins the object JSON (writer updated here,
`04dbaaf`), restoring the object↔pool-export cryptographic bind for every future object.
**WO-2 LANDED AND ACCEPTED 2026-08-26 (both protocol phases + three adversarial rounds —
nineteen planning findings; the record froze at descent-engine `fc8d85d`, SPEC v0.5 =
`12e33135…`).** Implementation: gate green 103 controls (verified independently), **it-2
soundness 45,262/45,262 decided rows matched, zero contradictions, coverage clause MET at
the 2,000,000-conflict default** (failed first at 700,000 — 9 of the 11 exhausted rows were
SURVIVORS: witness costs 226 s median vs refutation 0.8 s — 281×, the survivors bind every
budget); learned-clause **reuse measured 2.59×** against the registered 1.5× line (ships;
`--solver-reset` a flag); one real bug found and fixed mid-acceptance (a resume < 32 rows ran
single-threaded while printing the requested worker count — would have made the residue run
6-wide instead of 30). **The residue re-ask is BUILT, NOT LAUNCHED — schedule: after the
it-3 commit lands → quiet-box window (Rust timing run + the 46-survivor budget sweep,
~30 min) → residue overnight at 28 workers (preflight refuses 30 at 94.3 GB), UNLESS
Kooshi's courier-RAM answer arrives and is large (164 workers want ~550 GB — memory, not
cores, caps it there). Output = sidecar checkpoint-JOINable rows; merge, then re-run
`--hitting` on joined verdicts; may resolve ZERO (measured: no cheap lever exists) and that
outcome is a hardness measurement, floor 7 by evidence.** WO-3 (scale driver) next on the
Rust side; the WO-3 planning brief must carry `plans/REVIEW-METHOD.md` (the five review
conditions + the adversarial-repeat instruction). Spawn hygiene: absolute paths; the
peer-delegation skill governs every message.

**Engine-repo state:** WO-0 ACCEPTED (`f82d7df`), SPEC v0.3.1 (canonical `stage_fp` =
`stage_fp_key` in batchkill.py — pinned example: key('7f7aa18bcce0b917', [(4,205),(0,20)],
'5481c3fae64e770d', '0395d666c3eb9b3d') = 2d481257dbf61751); the enumerator is WO-2 scope
(§R-rust; acceptance = class-set equality vs the seed 51,350 + a completed stage; `_brk_full`
bit-compatibility is the load-bearing export); cas-rs audition scoped to the exact-geometry WO.

**Riding items not yet done:** K4 entropy-floor sitting; the Parts-{1,φ} skewscan replication
(registered, NOT launched); `--status` next-command upgrade; core-probe distinct-class recount
(bookkeeping, §R-INC4); predictions P1-P8 scored at close.

## §R-INC6. The residue's three deaths (2026-08-26)

The it-3 residue re-ask (`descent replay --reask-unknown`, 28 workers) died three times in one day
with zero verdicts landed: SIGSEGV at 3 h 05 m, SIGSEGV (`at 10`) at 15 min, and glibc `double
free or corruption (out)` at 13.5 min. I read the third
as SOFTWARE (heap corruption signature) and filed INC-1 in descent-engine as an
engine-bug investigation. **The investigation session refuted that with a decorrelated
experiment**: a probe sharing no code with the engine, run at the residue's own footprint (28 × 2 GiB), caught a hardware fault twice. **Kooshi's hardware call stands.** Record corrections: my INC-1 text claimed WO-2's acceptance ran "30
threads for hours" — its long sweeps ran at 6 threads / ≤ 6.2 GB, so the residue was the engine's
first run at 9× its proven footprint, not 2.25×. Consequences for the campaign are in CLAUDE.md
§ Toolchain (certified results immune; uncertified long-solve negatives carry exposure; D33).
Residue: BLOCKED on hardware — options ranked for Kooshi: a hardware check then fix; the laptop at 4–5
workers (~13–16 h, decorrelated machine); the courier. WO-5 real-stage acceptance shares the
constraint. Investigation commits pushed (descent-engine `4428a07`); gate green 140/140.

*2026-09-01 03:20Z–04:00Z — Q8: KOOSHI'S DUPLICATE-AND-DETUNE IDEA PRODUCED A NEW 5-CHROMATIC UNIT-DISTANCE
GRAPH WITHIN MINUTES OF BEING STATED (verified at the tools level; kernel certificate pending).* His idea
(`plans/STANDING-QUESTIONS.md` Q8/Q9): apply the χ = 5 constructions' trick — duplicate the object and detune
the copy (Heule: rotation about the middle pivot; de Grey: nearer a mirror) — to the descended object, to
manufacture the χ(unit-part) 4 → 5 crossing rather than wait for it. Sharpened before running: the lock angle
is DERIVED, sin(θ/2) = 1/(2d) for a pair distance d (the spindle theorem), so the candidate angles are the
spindle angles of the crystal's own distances — and the E–I forced pair's own d = 5 gives 4d² − 1 = 99 = 9·11,
in ℚ(√11): their spindle never left the seam tower. **The probe** (`tools/copy_probe.py`, registered
predictions P-Q8a/b, P-Q9): U = the unit part of the it-4 object (1,834 live points, 12,735 unit edges,
4-colourable in 0.1 s); for T ∈ {the mirror across 205–206; rotations about 205, 206, v0 by the spindle angles
of d ∈ {5, 2, √3, √7, 4}, both signs}: U ∪ T(U) asked at k = 4. **Result: the rotation by the d = 2 angle
28.955° (cos 7/8, sin √15/8 — the ρ₁₅ detune, one field up) about 206 (both signs, 34 cross chords) and about
v0 (both signs, 58) is UNSAT at four colours; every other transform — the mirror (1,730 chords), d = 5 (~70),
√3 (up to 3,080), √7, 4, and d = 2 about 205 (15) — is SAT.** Verified: all 34 cross chords of the about-206
union unit to 250 digits (`tools/copy_exact.py`, worst 4.4e-251; the copy of 206 fuses to 206 exactly); UNSAT
in three encodings (one-hot + degree breaking 6.8 s; one-hot without breaking; 2-bit; `tools/copy_verify.py`,
260 s). So **U ∪ R(U), 3,695 points, 25,486 unit edges, is a 5-chromatic unit-distance graph** — glue-lattice-
grown from the Exoo–Ismailescu seed plus ONE ρ₁₅ spindle copy, no published witness's genre; T7's halt-and-
certify event, reached by construction. **Mechanism, first reading:** only 4 of the 34 chords are individually
load-bearing — (225 → copy of 423), (243 → 424), (423 → 225), (424 → 243): two pairs of depth-1 glue points
{225, 423} and {243, 424} at distance exactly 1/√3 (the two-circle INNER radius) from each other, at radii
1.3696 / 1.9470 from 206, each pair's copy landing at unit distance from its partner; 225–243 and 423–424 at
√3. NOT a single-pair spindle: the complete k = 4 forced-equal sweep of U alone (`rigidity.Rigidity`, 142 calls,
1,573 s) finds **137 forced-equal pairs at four colours — 131 at d = 8/3 (4d² − 1 = 247/9) and 6 at 8/√3
(253/3), all halo-touching, both radicands outside every owned field, none at distance 2, none touching 206 or
v0** — so P-Q8a is refuted in substance (U is 4-rigid, at distances nobody can spindle) and the lock is a
compound compulsion; the vertex core (`tools/copy_core.py`, running) names it. Kooshi's follow-up question —
which cheats does the union make redundant? — is running as (i) the floor census on X ∪ R(U) over the 39 floor
cheats (`tools/copy_floor.py`: all-cheats control UNSAT, the JACKPOT ask with zero cheats SAT — no χ ≥ 6; first
16 floor cheats all still essential) and (ii) the delta-debugging cull over all 298 cheats with no halo, on X and
on X ∪ R(U) (`tools/copy_cull.py`) — the size difference is the free dial reading. **Certification path (the
HALT-AND-CERTIFY clause):** vertex core → field inventory of the load-bearing halo radicands (depth-1 glue
points adjoin one root each; P5's catalogue) → exact geometry in the iterated tower → the M42 LRAT template at
k = 4. Adopting X ∪ R(U) as the descent object needs a provenance dialect for rotated copies (`Obj` + the Rust
reader, D38) — a WO. Ledger: `build/m51-jobs.txt` 03:1xZ–03:5xZ; artifacts `build/m51-copy*`.*

*2026-09-01 04:00Z–05:20Z — Q8, the measurements that followed (all recorded in `build/m51-jobs.txt` as they
landed).* **Centres:** the same angle about the four load-bearing halo points (Kooshi's autocomplete's suggestion)
locks with MORE chords (48–52); about every live seed vertex, **360 of 380 asks lock** (`tools/copy_centres.py`,
0 unknown, 1,349 s); the ten non-locking centres (both signs) are seed 79, 127, 129, 130, 174, 190, 199, 203,
**205** (the forced pair's other endpoint, degree 8), 208 — mostly low-degree or peripheral. The halo-centre
sweep (1,620 points, 3,240 asks) runs behind. **Controls (`tools/copy_controls.py`):** the angle perturbed by
±0.3°, ±1°, +5° → the 18 angle-independent chords only (206's unit neighbours) and SAT; the Moser angle with
hundreds–thousands of chords SAT on every object; the seed's unit part alone, it-1 (690), it-2 (1,008): SAT at
the ρ₁₅ angle; **it-3 before deletion (1,862): UNSAT** — the lock arrived with iteration 3's halo (glue points
of glue points = seam-field material at depth 2 from the seed): G16's depth switch, under de Grey's own rotation
2·arcsin(1/4). **The origin copy verified to the same standard** (58 chords unit to 250 digits, three
encodings) with NO single load-bearing chord (0 of 58 — multiple disjoint routes). **Kooshi's cheat question:**
floor census on X ∪ R₂₀₆(U): 0 of 39 floor cheats redundant alone (36 essential, 3 unknown at 600 s:
(118,212), (126,203), (132,134)); cheat-endpoint census: plain object 184/184 seed vertices needed (0 deletable —
the 28 deletable ones are already gone), copied object 30 needed + 2 unknown so far, 0 deletable; the composed
four-copy union (both signs about 206 and v0: 9,194 points, 63,770 unit edges, 189 chords): k = 4 UNSAT 15 s,
k = 5 all-cheats control UNSAT 539 s, **zero-cheat (jackpot) ask UNKNOWN at 1,800 s** where the single copy's
took 116 s to find a separating colouring — re-asked with a 4-h cap; a cap is not a verdict. The delta-debugging
cull over all 298 cheats with NO halo: plain object 298 → 230 at 47 asks (82 min, running); with the copy, the
large-chunk asks hit the 300-s cap (relaunched at 900 s with per-ask logging, resumed from state). The vertex
core of the 206 union: 3,695 → 1,023 at 896 asks (80 min, running; certificate-only, does not touch the
object). **Order of work agreed with Kooshi (04:30Z):** finish it-4 as designed (the lock is monotone under
added material, so nothing is thrown away), THEN the composed object (it-4's commit + every locking copy) gets
the full count — cull, endpoint census, floor — against the plain it-4 object as control; it-5 starts from the
stronger object; adopting copies as object material is a provenance-dialect work order (Python `Obj` + the Rust
readers, D38). His words: "I doubt we'll get to zero, or even 1 cheat through this alone, but if we toss all of
these successful rotations together along with it-4's outputs, I'm very curious how many cheat vertices we can
shrink away or edges we can eliminate."*

*2026-09-02 05:35Z — ITERATION 4 COMMITTED.* Profile adopted (37,316 classes: 37,174 killed, 0 survive,
142 unknown never folded); hitting set kept 3, committed 25; the Rust design produced a **119-point
1-minimal halo with zero stalls** (cover 986 s, shrink 17 h, verify 233 s — it-3's halo was 854 points
for 19 cheats: the engine's shrink plus the richer object cut the per-cheat cost ~7×); certify: lookup
20,758/20,758 killed (3,512 s, checkpointed — the incident-5 fix paying), 1,061 halo edges verified
(3 exact, 1,058 at 250 digits), one-hot UNSAT, 3-bit UNSAT at 8,228 s after the hard 7,200-s cap was
made configurable (CERTIFY_ONEHOT_CAP/CERTIFY_REENCODE_CAP, `ab7747e` — the first run returned
CANDIDATE honestly and wrote nothing). **Object `…-vdel28-it2v2-depth1`: 1,981 points, 273 cheats.
The dial: 446 → 273.** Cull incidents the same night, both caught by controls and ledgered: the v2
copy-cull's wall caps burned 737 s median on unknowns (v3 = group-MUS on incremental solvers,
`copy_cull3.py`, planted self-test green); v3's first FINAL row claimed "unknown 0" while its own pass
log showed 144 erased-not-reprobed unknowns (the reset-order bug, `f87df83`) — the sound half (kept 184
forcing on the plain object, one-shot control UNSAT) stands; both culls relaunched fixed at 3M/30M
conflict budgets. Next: columns on the new object (χ(unit) monitor = halt clause), it-5 floor, the
composed-object cull (the new object + every locking copy) against the plain new object as control.*
