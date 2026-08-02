# M17 — Constructing a narrow fan

*Subplanned 2026-08-02, measurements first. Supersedes the stub written at M16's close.*

> **M16 closed the narrowing route through every witness in existence**: the four five-colour fans
> in de Grey's unshrunk graph are kernel-certified non-narrow, and the shrunk witnesses carry no
> fan at all (M15). A fan confined to one spindle-able distance class — the closing move's input —
> must now be **built**. M17 is that construction hunt: a structural theorem that prunes the search
> space, an all-pivots instrument that makes every candidate a seconds-to-minutes question, and a
> measured sweep of the growth families the toolkit can express.

## 0. Measurements — taken before anything was specified

All on the desktop (32 cores, 128 GB), 2026-08-02, alongside a 6-worker `lean4checker` replay and
one idle-priority cadical — wall times below are effectively single-core and conservative.

### (a) The deletion direction is closed by a two-line argument, not a measurement

A proper colouring separating pivot `p` from partner list `Q` **restricts** to any subgraph (fewer
edges = fewer constraints) and still separates any `Q' ⊆ Q`. So *non*-confinement survives every
deletion, i.e. **deleting vertices can never create a confined fan**. The stub's direction 2
(glue-then-narrow by deletion) is refuted by proof, not by search. Equivalently, read upward:
**`Fan` is monotone along the subgraph order** — a fan in a subgraph is a fan in every supergraph
over the same vertices. Growth is the only live direction, and this becomes a kernel-checked
theorem this milestone (§2).

### (b) Fans are ubiquitous in every glued candidate — existence is free, confinement is everything

M15's identity (a five-colour fan over the widest partner list at `p` ⟺ `G − p` still refutes four
colours) means: in **any** union of two 4-refuting copies, *every* vertex carries a five-colour fan,
because deleting it leaves at least one copy intact. The hunt never tests existence again; it only
tests confinement, which is exactly what the pool sweep answers.

### (c) The doubling move is already in the toolkit, and its cost is measured

`spindle_rotation(r²)` rotates **every** point at squared distance `r²` from the pivot by exactly
one unit (`|q − ρq|² = 2r²(1 − cos θ) = 1`), so `construct.spindle(cfg, p, q)` with `q` in a class
*is* de Grey's spindle-and-rescan doubling. Doubled de Grey at pivot 630, class `r² = 5/9`:
**3,158 points, 15,818 edges (64 cross-copy), built in 76 s** (Python edge enumeration dominates),
5-colourable by cadical in **0.1 s**. Rotating about the pivot maps each of *its own* classes into
itself — pivot 630 keeps 1,340 classes while every other vertex jumps to ~2,900.

### (d) The all-pivots sweep with a global pool is cheap enough to be a per-candidate primitive

One proper 5-colouring separates class `C` at pivot `p` whenever all of `C` misses `p`'s colour —
so a **single pool serves every pivot**, not just every class. Measured full sweeps, zero deferred:

| candidate | points | pivots swept | SAT calls | wall |
|---|---|---|---|---|
| doubled de Grey (630 @ 5/9) | 3,158 | **all 3,158** | 713 | **309 s** |
| glued Heule510 pair, r²=1/3 seam | 538 | all 538 | 96 | 4 s |
| glued Heule510 pair, r²=1 seam | 674 | all 674 | 113 | 6 s |
| translation glue, overlap 214 (×2 vectors) | 806 | all 806 | 129 / 114 | 8 s each |
| orbit(Heule510, hex₁₂) | 907 | all 907 | 119 | 12 s |

M15 swept one pivot per candidate; the same budget now sweeps every pivot of a candidate with
~1.2 warm-pool calls per pivot. **No confinement anywhere above** — six full negatives, first
results of the hunt proper.

### (e) The gradient: which classes resist pool rejection

The sweep's own by-product is a tightness signal — classes needing a dedicated SAT call rather than
dying to the pool. At the four de Grey fan pivots: **`r² = 5/9` resists at all four and is
spindle-able** (`4·(5/9) − 1 = 11/9`, `√11/3` in the field), width 4 at each; `4/9` (√7/3) also
resists at 1423. Across the full doubled-graph sweep the resisting distribution is dominated by
**`r² = 1/3` (332 of 713 calls)** — spindle-able (√3/3) — then irrational classes (272), then
`r² = 3` (73). Out-of-field resisters (`√83, √67, √91, √51, √39`) are the field-growth ledger's
first entries.

### (f) Family inventories — the hunt space is enumerable and affordable

* **Fan-pivot doublings**: exactly **7 spindle-able classes per fan pivot** (identical lists at
  630/633 — the halves are congruent): r² = 5/9, 4/9, 1, 1/3, 16/9, 7/3, 11/9 with widths
  4, 4, 4, 3, 2, 2, 2. Family = 4 × 7 = **28 candidates** ≈ 28 × (76 s build + ~5 min sweep) ≈ 3 h
  sequential, embarrassingly parallel.
* **Translation glues**: best self-overlap of Heule510 is **214 of 510 points** (→ 806-pt
  candidates); of de Grey **224 of 1,581** (→ 2,938-pt candidates, 6 vectors at the top count).
* **Orbits**: Heule510 is already nearly hexagonally symmetric — orbit(H510, hex₁₂) is only 907
  points, not 6,120.
* **Iterated doubling**: a doubled graph re-doubled at its sharpest resisting class is ~6,300 pts,
  sweep ~20 min — affordable at a handful.

### (g) The all-pivots known-hit expectation (control spec) — measurement in flight

The single-pivot known-hit control (M16): de Grey's 397-point four-colour configuration, origin,
exactly one confined class, r² = 4, width 6. The all-pivots expectation (how many *other* pivots of
that configuration carry four-colour confined fans) is still computing at this writing — confined
fans are common at four colours and each costs its own UNSAT. The control constant is pinned from
that run's output during implementation; the credibility rule it serves is M13's: **a search that
cannot re-find the rung below is not credible for the rung above.**

### (h) Standing constraints (carried once more)

Refutation cost is non-monotone in size (M07); five colours is trivial to satisfy and brutal to
refute (M12); a genuine hit's UNSAT is hours (M15: 1.7–1.9 h per fan confirmation at 1,581 pts) —
so the sweep's budget triage (DEFERRED, never folded) is what keeps a slow UNSAT from being
mistaken for a separation. `tools/` stays untrusted throughout: a hit becomes a claim only through
the kernel.

## 1. What the milestone is

Three deliverables, in dependency order:

1. **The pruning corollaries, kernel-checked** — no deletion from a candidate whose classes are
   all separated can ever produce a confined fan, stated in the tool's own vocabulary. (The core
   monotonicity `Fan.mono` turned out to be *already in the library* — M15 shipped it — found by
   the elaborator saying "already declared" after this plan's first draft listed it as the main
   theorem. Fourth entry in the claims-of-absence ledger.) Closes stub direction 2 permanently and
   licenses the hunt to spend its whole budget on growth.
2. **The rescan instrument** — `tools/rescan.py`: the all-pivots global-pool sweep as a
   per-candidate primitive with M16's triage discipline (DEFERRED never folded; self-auditing
   category line; NO VERDICT on any deferral), plus the candidate generators (doubling at a class,
   translation glue at a vector, orbit) and a hunt driver that logs every candidate examined to a
   JSONL ledger — the "searched X" artifact the write-up quotes.
3. **The hunt, run and reported honestly** — families H1–H5 of §3, with the stopping rule stated
   up front. "Searched X, found nothing" is a result; a hit branches to §4.

## 2. The shape — Lean

New module `Proofs/HadwigerNelson/FanMono.lean` (imports `Fan`; nothing imports it but
`Proofs.lean`). **Deliberately not in `Fan.lean`**: that module sits upstream of the four Narrow*
kernel certificates (~127 s each) and the Critical chain, and a new declaration there re-checks
them all for zero mathematical gain.

**Already present, cited not restated**: `Fan.mono` (graph order, M15), `Fan.widen` (partner
list), `edgeGraph_adj_mono` (edge-list order), `delete_edgeGraph` (vertex deletion = list
filtering, M15's Critical), `fan_univ_iff` (the deletion identity).

**The domain pass sharpened the inventory.** The genuinely missing *structure* is one bridge —
`edgeGraph_mono : E₁ ⊆ E₂ → edgeGraph n E₁ ≤ edgeGraph n E₂` (only the `Adj`-level form exists) —
and both corollaries are one-line compositions over it. The pass also renamed them: the skeleton's
`of_sublist` misstated its own hypothesis (`⊆` is `List.Subset`, membership; `List.Sublist` is a
different relation, and the name is the statement):

```lean
theorem edgeGraph_mono (hE : E₁ ⊆ E₂) : edgeGraph n E₁ ≤ edgeGraph n E₂

/-- Edge-list form: more listed edges, wider partner list — still a fan. -/
theorem Fan.of_subset (hE : E' ⊆ E) (hQ : Q' ⊆ Q)
    (h : Fan (edgeGraph n E') k p Q') : Fan (edgeGraph n E) k p Q

/-- **Deletion can never create a fan** — a separating colouring restricts to every
sub-candidate; vertex deletion is the instance E' = E.filter (edges avoiding it). -/
theorem not_fan_of_subset (hE : E' ⊆ E) (hQ : Q' ⊆ Q) :
    ¬ Fan (edgeGraph n E) k p Q → ¬ Fan (edgeGraph n E') k p Q'
```

plus spec examples on the path-in-triangle instance (the fan that lifts; the separation that
survives deletion; the separation *exhibited*, not assumed — a `∀` over an empty domain proves
nothing). Final names are the experience pass's to confirm.

## 2.5 The shape — tools (domain pass)

**The recipe algebra is the tool's core datatype.** Walking H1–H5 as data collapsed them: H2's
vertex-glue *is* H1's doubling (`spindle(cfg, seam, member)` — the rotation depends only on the
class's r², not on which member), and H3's translation glue is `union ∘ translate`. Every
candidate in every family is a tree over **five constructors**:

    recipe ::= base(name) | double(recipe, pivot_key, r²) | translate(recipe, vec)
             | orbit(recipe, group) | union(recipe, recipe)

— exactly `construct.py`'s existing move calculus. One small interpreter maps a recipe to its
point set; the JSONL ledger stores the *recipe* beside the result, so every candidate examined is
independently re-derivable (the witness-independence principle landing as a datatype, not prose).
Pivots inside recipes are named by exact coordinate key, never by index — indices do not survive
`dedup`, a lesson `construct.index_of` already carries.

**Two seams the measurement scripts sidestepped, now in the sweep's spec:**

* **The bare graph is solved first.** If a candidate is already 5-UNSAT, every class would read
  "confined" — garbage. The opening solve seeds the pool on SAT; on UNSAT the candidate is a
  screaming χ≥6-candidate verdict of its own kind (not a fan question); on unknown, NO VERDICT.
* **Distinct-point guard.** A duplicated plane point puts a distance-0 "partner" in a class and
  the joined graph would force apart two names for one point. Recipe ops dedup by construction;
  the sweep still asserts key-distinctness before believing anything.

**Settled here**: `narrow.sweep_pivot` grows an optional shared-pool parameter (rescan must not
reimplement the class walk — one source of truth for the triage discipline); no symmetry-orbit
collapse of pivots (alternative: sweep one pivot per orbit via `Fan.map`'s licence — rejected
because full sweeps measure 309 s worst-case and symmetry detection is new code in a load-bearing
triage layer; revisit only if candidates grow past ~10k points).

## 3. The hunt — families, order, stopping rule

Ranked by measured signal; each candidate = build + full all-pivots sweep at five colours, budget
300 s per solve, everything logged to the ledger:

* **H1 — fan-pivot doublings** (28): every spindle-able class at 630/633/1420/1423. The 5/9 and
  4/9 doublings first (the resisting classes); the class inventory is §0(f)'s.
* **H2 — the remaining M15 glued pairs** (H510 seams 5/9, 7/3, 3, 4; H553's spindle-able seams),
  all pivots — M15 only ever swept the seam.
* **H3 — translation glues**: top-6 overlap vectors for H510×H510, H553×H553, de Grey×de Grey.
* **H4 — orbits**: orbit(H553, hex₁₂); orbit(H510, hex₁₂) re-centred at a handful of alternative
  vertices (translate before orbiting — seed-placement freedom).
* **H5 — second generation** (budget: 6 candidates): re-double the once-doubled graphs at their
  sharpest resisting spindle-able class — the `r² = 1/3` signal of §0(e) — and double at one
  non-fan pivot with maximal cross-edge count, as a control on the fan-pivot prior.

**Stopping rule**: H1–H4 exhausted and H5's budget spent, or a confined fan found, whichever is
first. Estimated ≤ 1 desktop-day sequential, a few hours parallel. Every candidate's line goes in
the ledger either way.

**Field-growth ledger**: every resisting class whose spindle needs a root outside
ℚ(√3,√5,√7,√11) is recorded with its `missing_root` price; the aggregated histogram goes in the
report (§0(e) already shows √83/√67/√91/√51/√39).

## 4. The hit branch — scoped, not presumed

A confined class in the ledger is **triaged, not believed**: re-solve at unbounded budget, confirm
UNSAT, then the claim's route is exactly M16's: geometry certificate for the candidate (its coordinates
are already exact field values by construction), LRAT certificate for the joined-graph refutation,
kernel-checked through the M05/M06 pipeline, `Fan.of_unsat`, and — at width ≤ 2 — the closing move
`not_colorable_of_spindled_fan` toward a χ ≥ 6 witness graph; at width > 2, the spindle-and-rescan
iterate with the new graph re-entering H1. **The LRAT certificate of a five-colour UNSAT at 3,000+
points is of unmeasured size and is its own milestone**: a hit therefore lands in *this* milestone
as a verified-by-tool, triaged finding plus a subplan stub for its certification — it does not
silently balloon M17.

## 5. PROVE / TEST / ASSUME

| claim | status |
|---|---|
| Fan monotonicity; deletion never creates confinement | **PROVE** (kernel, this milestone) |
| the sweep's categories partition the classes; DEFERRED never folded; NO VERDICT on deferral | **TEST** (self-audit line + never-answering-oracle control, per candidate) |
| the instrument re-finds de Grey's four-colour fan, all-pivots | **TEST** (known-hit control, expectation pinned by §0(g)'s run) |
| a SAT model really separates (proper + separating) | **TEST** (asserted against the committed edge list on every model) |
| an UNSAT answer from cadical | **ASSUME for triage only** — never a claim; a hit is certified through the kernel before anything is stated |
| candidate geometry is exact | by construction in the field; re-derived in Lean only at a hit |

## 6. Settled decisions

| choice | alternative | why | confidence |
|---|---|---|---|
| Monotonicity lives in new `FanMono.lean`, not `Fan.lean` | its API home beside `Fan.widen` | a declaration in `Fan.lean` re-kernel-checks four Narrow certificates + the Critical chain for zero gain; `--` pointer in `Fan.lean` is free | high |
| Hunt = growth families only | keep a deletion arm | §0(a): deletion provably cannot create confinement | high (it is a theorem) |
| Global pool across pivots (not per-pivot pools) | M16's per-pivot sweep looped | measured 3,158 pivots in 309 s; per-pivot would re-solve the same separations thousands of times | high |
| Budget triage carried unchanged from M16 | trust fast UNSATs | a slow UNSAT mistaken for separation is a lost hit; a fast "unknown" folded into confinement is a false claim | high |
| A hit certifies through M16's route in a *new* subplan | certify inside M17 | LRAT size at 5 colours/3k+ pts unmeasured; scope honesty | high |
| H5 budget = 6 second-generation candidates | unbounded iteration | the iterate multiplies cost ×4 per generation; 6 covers both signals (sharpest class, cross-edge control) within the day budget | medium — a near-miss (a DEFERRED that later confirms UNSAT-hard) would justify extending |

## 7. Gate additions

* `FanMono` on the axiom audit surface; zero purchases expected.
* `rescan.py --self-test` added to `scripts/regen-check.sh` beside `narrow.py --self-test`.
* Negative controls watched red: the oracle control, the category-leak audit, the known-hit
  all-pivots control, and one Lean control (a `Fan.mono` misuse that must not elaborate).
* Carried debts, reported not absorbed: the **full-library `lean4checker` replay** relaunched
  2026-08-02 08:32 after the previous run's six workers all segfaulted at ~04:00 and the machine
  rebooted (environment event, not kernel rejections — a two-module replay passes clean post-reboot);
  and the **full-fan UNSAT control** relaunched at idle priority through the fan encoding
  (`build/fullfan-m17.log`), still belt-and-braces (the known-hit control covers the code path).
