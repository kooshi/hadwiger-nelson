# Phase H4 — the compulsion sweep on `ρ₆₃`. Filter derivations, pricing, controls, verdict.

*Opened 2026-09-12 at the product owner's direction: run on our own five-chromatic object the
instrument that emptied de Grey's, and decide first whether the arithmetic filter offered to make it
affordable is even valid.*

**The object.** The `ρ₆₃` arena of M63 phase H2 (ledger row 64): **51,133 vertices, 544,530 edges**, a
Moser-lattice disk in `K = ℚ(√3,√11)` together with its image under `ρ₆₃ = (31 + 3i√7)/32` about the
shared centre, all unit edges included. It lives in `L = ℚ(√3,√7,√11)`, a **6-open** field. Rebuilt
here from `build/m63-phaseH2-artifacts/solver-h2/edges.txt` (the phase H2 record's own independent
rebuild, which agreed with the screening agent's CNF on all 544,530 edges, 0 either way).

---

## §0 — Answers, before the reasoning

| question | answer |
|---|---|
| does the residue / valuation filter apply? | **No — and not by accident.** Its hypothesis is the exact negation of 6-openness. Two independent reasons, §1. |
| does the base–base rescue work? | **No.** `Forces` is monotone the wrong way; §1.3. |
| does the critical-vertex screen apply? | **Yes as a theorem, but it cannot fire here**, and the reason is the thing that makes this object better than de Grey's. §2. |
| what does the sweep actually cost? | **Minutes, not 363 hours.** The cost model behind the filter proposal counts one solver call per pair; the project's own instrument has never worked that way. §3. |
| the arena at five colours | non-vacuous: **χ(arena) = 5 exactly**, with a constructed, verified witness. §4. |
| **the verdict** | **nothing, in either polarity.** 0 forced pairs over all 1,307,266,278 pairs; 0 virtual edges over all 1,306,721,748 non-adjacent pairs; certified by 4,480 exhibited, individually verified proper 5-colourings. **§8.** |
| arity 3 | swept on the 163 interface vertices only: 3,502,728 admissible questions, **337 candidates left and not settled**. §11. |

---

## §1 — The residue filter: the derivation, and why it does not apply

### 1.1 What the filter is

Ledger row 59 (`ValuationLaw.lean`, `ResidueColouring.lean` §4). Over `K = ℚ(√3,√11)` the residue
colouring `φ` at the prime `𝔭 | 2` is a **proper 4-colouring of the whole K-plane** (Theorem B), and it
identifies two K-points exactly when their distance lies in `𝔭`. So inside a graph drawn in `K²`:

* `φ(i) ≠ φ(j)` ⟹ `φ` is a proper colouring separating them ⟹ **not forced** (`not_forces_of_residue_ne_zero`);
* `φ(i) = φ(j)` ⟹ **not a virtual edge** (`not_separated_of_residue_eq_zero`).

Ledger row 55 is the five-colour sibling: over a field with a **usable prime** `𝔭` — residue field `𝔽_q`
with `q ≡ 3 (mod 4)` — **whose plane is 5-colourable**, a five-colour forced pair needs `q ∣ d²` and a
five-colour virtual edge needs `d² ≡ 1 (mod q)`.

Note the direction of the colour count, because it is the one place the filter is generous: a proper
4-colouring **is** a proper 5-colouring, so a refutation at four colours refutes at five for free. The
colour count is not what breaks.

### 1.2 Reason one — the field has no sealing prime, and that is what 6-open MEANS

`L = ℚ(√3,√7,√11)` is multiquadratic, so `L/ℚ` is abelian of exponent 2 and every Frobenius has order
1 or 2. A residue field `𝔽_q` with `q = p^f` and `q ≡ 3 (mod 4)` forces `f` odd, hence `f = 1` (an
`f = 2` residue field has `q = p² ≡ 1 (mod 8)`). **So "odd residue degree" and "residue degree one"
coincide over `L`, and `tools/fplane.py usable` enumerates the whole supply.** Measured:

```
Q(√3, √7, √11): usable primes below 600: [83, 131, 167, 227, 479, 503, 563]
Q(√3, √11)    : usable primes below 600: [11, 83, 107, 131, ...]        <- control, 11 present
Q(√3, √5, √11): usable primes below 200: [11, 131]                      <- control, Heule's field
```

At every one of them the plane refuses five colours:

* `q = 83`: exact Kloosterman spectrum, `λ_min = −17.7087`, Hoffman floor `χ ≥ 5.743` ⟹ **χ ≥ 6**
  (`tools/fplane.py spectral --p 83`, written to `data/fplane/spectral-p83.json`);
* `q ≥ 99`: Weil alone. `|λ_min| ≤ 2√q` and degree `q + 1` give `χ ≥ 1 + (q+1)/(2√q) ≥ 6` as soon as
  `q − 10√q + 1 ≥ 0`, i.e. `q ≥ 98.0`. Every usable prime of `L` other than 83 exceeds that.

So no usable prime of `L` has a 5-colourable plane, and row 55's hypothesis is **nowhere satisfiable**
over this field. The transfer is vacuous — the same way it is vacuous over de Grey's field at 131,
which M60 §S3 already flagged.

> **This is not bad luck about one object. A field is 5-sealed exactly when some usable prime's plane
> is 5-colourable, and that is exactly row 55's hypothesis. "6-open" and "residue-filterable at five
> colours" are complementary by definition.** Every future χ ≥ 6 candidate is un-filterable this way,
> necessarily, and a sweep that needed this filter to be affordable would never be affordable on any
> object worth sweeping.

### 1.3 Reason two — the colouring is not proper on the arena, and the base–base rescue fails at the same step

Independently of §1.2, row 59's own four-colour law needs `φ` to be a **proper colouring of the graph
being swept**. `φ` is proper on unit-distance graphs drawn in `K²`. The arena is not one: the rotated
half lies in `L²`, and `L` is **wall-broken** — that is what `√7` does (G35: an odd square class
`≡ 7 (mod 8)`) — so there is no conjugation-fixed prime above 2 in `L(i)` with a residue field of size
four, and `φ` has no proper extension to the `L`-plane. A colouring that is not proper on `G` refutes
nothing about `G`.

**The base–base asymmetry does not rescue it, and the step it fails at is worth naming.** The base
half `B` lies in `K²`, so `φ|B` is a proper 4-colouring of `G[B]` and settles every pair inside
`G[B]`. But `Forces` is **monotone upward in the graph** (`Forcer.Forces.mono`): adding vertices and
edges can only create compulsions, never destroy them. `¬ Forces G[B] 4 i j` therefore says nothing
about `¬ Forces G 5 i j`. Refuting a pair in `G` requires a proper colouring **of `G`**, and
`φ|B` is not the restriction of one unless it extends across the coupling.

**The repair, and why it is worthless even if it works.** One could ask a solver whether some proper
5-colouring of `G` restricts to `φ` on `B`; if so, every base–base pair with `φ(i) ≠ φ(j)` dies at
once. That is **one SAT call** — and so is producing any other proper 5-colouring of `G`, which does
exactly the same job. The residue colouring's only distinctive value would be that its separations
have a closed arithmetic description, which matters for a theorem and not for a sweep.

### 1.4 The other filters this project holds, priced honestly

| filter | applies? | what it gives here |
|---|---|---|
| the spare-colour lemma, row 45 — `(k−1)`-colourable ⟹ no pair compulsion at `k` | **yes, and it is total on the base half** | `G[B]` is 4-colourable (Theorem B), so `G[B]` carries **no compulsion at five colours in either polarity**. Consequence worth stating: **every compulsion the arena has is manufactured by the 66 genuine cross edges.** It does not transfer to `G` — same monotonicity as §1.3 — so it prunes no pair of the sweep |
| `criticalSet_eq_empty_of_forces_of_two_lt_dist`, row 48 | yes, but only once a critical vertex is exhibited | with ≥ 1 critical vertex, every forced pair sits at distance ≤ 2 and both endpoints lie in that vertex's neighbourhood — at most `C(60,2) = 1,770` pairs. Conditional on §2 firing, which it does not |
| G39, critical set ⊆ `N(p) ∩ N(q)` | same | same |
| row 55's residue-allowed distances (FS-16) | **no** | it is row 55, and row 55 has no usable prime here |

---

## §2 — The critical-vertex screen: it is the right screen, and it cannot fire on this object

### 2.1 The theorem, stated exactly

`CriticalSet G k = {c | (G.deleteIncidenceSet c).Colorable k}` — the vertices whose deletion drops the
chromatic number. With `χ(G) = 5`, so `k = 4`:

* `encard_criticalSet_le_two_of_forces` — an injective unit-distance drawing with a pair forced equal
  at five colours has **at most two** critical vertices. **Three critical vertices ⟹ no forced pair
  anywhere in the graph.**
* `criticalSet_subset_union_neighborSet_of_separated` — a virtual edge `(p,q)` confines the critical
  set to `N(p) ∪ N(q)`. Three critical vertices **pairwise at distance > 2** therefore refute every
  virtual edge too: two of the three lie in one neighbourhood by pigeonhole, so they are at distance
  ≤ 2 through its centre.

Both polarities, from one measurement, for all 1.31 billion pairs at once. It is the cheapest
instrument this project owns — **when it fires.**

### 2.2 It is exactly what emptied de Grey's object

`data/e4-critical-vertices.json` holds three 4-colourings certifying that vertices **11, 802 and 14**
of the 1581 are critical. De Grey's graph is a **1-sum**: two 791-vertex halves joined at vertex 14
plus the single cross edge `(11, 802)`. Delete any one of those three and the coupling is gone. The
arity-2 forced-equal sweep of the 1581 was re-measuring a theorem.

### 2.3 On `ρ₆₃` the same screen is structurally inert, and the measurement says why

Measured exactly from `build/m63-phaseH2-artifacts/solver-h2/coupling.json`:

| | de Grey 1581 | `ρ₆₃` arena |
|---|---|---|
| coupling between the two halves | **1 shared vertex + 1 edge** | **1 shared vertex (the centre) + 66 edges** |
| interface vertices | 3 | **132** carrying the 66 genuine cross edges (66 base-side, 66 copy-side, all distinct); **163** touching a cross edge of any kind, once the centre star and the duplicate-of-a-base-edge crossings are counted — that wider 163 is the set the arity-3 sweep and the colour-promotion step use |
| **maximum cross-degree of any vertex** | ~the whole coupling | **1** — every one of the 132 carries exactly one cross edge |
| critical vertices | 3, and they kill forcing by theorem | none expected: no vertex carries more than 1/66 of the coupling |

Deleting any single vertex of the arena removes **at most one** of the 66 genuine cross edges. Phase
H2's own discrimination ladder — `18,432 → 6,144 → 4,224 → 2,688 → 768 → 0` admissible interface
pattern pairs as the constraints are applied — shows the last constraints each cutting by about
threefold, so one constraint short of the full set is nowhere near admissibility.

**What is measured rather than argued.** Phase H4's reduction walk deleted vertices cumulatively and
accepted 29 in ascending index order; acceptance means the refutation survived, and since
`G − v_i ⊇ G − {v_0,…,v_29}`, each of those 29 vertices is **individually non-critical**. That is
**29 of 51,133**, and it is the only measured evidence. *No solver hours were bought to certify the
null, and none should be: an UNSAT certification of non-criticality costs a full arena refutation per
vertex, and 0 critical vertices teaches nothing anyway — the theorem is satisfied vacuously by an
empty critical set.*

> **The screen that emptied de Grey's graph is inert here precisely because this object is better
> built.** His forcing hangs on a cut vertex; ours is distributed over 66 edges. That is a compliment
> to the object and a genuine loss of a cheap instrument, and both halves should be said.

---

## §3 — The pricing, and the cost model that was wrong

### 3.1 The 363-hour figure counts the wrong thing

> *"1.31 billion pairs, about 1,046×. At a millisecond per pair that is 363 hours."*

That is one solver call per pair. **The project's own instrument has never worked that way.**
`tools/rigidity.py` — the engine that produced the 1581's recorded null — draws proper colourings and
refutes pairs in **bulk**: a pair is dead the moment one exhibited colouring answers the other way.
`build/m30-rigidity-1581-k5.json`: **37 models, 37 solver calls, 30.2 s** for all 1,248,990 pairs.
`tools/m48.py` is the same shape at arity 3: 3,286,925,350 questions, **263** ever reached a solver.

The cost is **O(models drawn) solver calls plus O(survivors) solver calls**, and the number of models
is governed by how fast the survivor set collapses — not by the pair count. This is the same error
§8 of `plans/M63-phaseH4-reduce-the-platform.md` already corrected once, in the same milestone
("the cost wall was never there"), and it is the eighth instance of a misused number here.

### 3.2 What actually scales with 51,133, and what it costs

`rigidity.py`'s **bookkeeping** is what does not survive the size: `ne_candidates` is a Python double
loop over `C(51133,2) = 1.31e9`, re-run per settle round, and `observe()` inserts every within-class
pair into a Python set (~2.6e8 inserts per model). So the engine idea transfers and the data
structure does not.

`tools/arena_sweep.py` (new, this phase) keeps the same idea over a **packed bit matrix**:
`n × ⌈n/8⌉` uint8 = **327 MB** at this size, one `|=` per colour class per model. Measured cost per
model at `n = 51,133`: fractions of a second. The forced-pair side is a signature bucket, O(n) per
model.

**The soundness property that makes this legitimate, stated once:** a pair is refuted by exhibiting a
proper colouring, and every colouring is re-verified edge by edge before use. A refutation is
therefore correct **whatever produced the colouring** — the generator's coverage affects only how
many pairs are left over. The survivor set is always a **superset** of the true compulsion set, so
**no positive can escape it**. This is the same superset logic phase H2's refutation runs on, and it
is why a zero here is certified by witnesses rather than by absence.

---

## §4 — The arena is 5-colourable, so the sweep is not vacuous

`Forces G 5 p q` is vacuously true for every pair if `G` has no proper 5-colouring — G30's failure
mode 7, and the reason `tools/m48.py` refuses to run without a base row (`STAGE NOT 5-COLOURABLE —
every reading below would be vacuous`). Phase H2 established `χ ≥ 5`; **nothing on record established
`≤ 5`.**

**CaDiCaL could not find one**: a monolithic 5-colouring solve on the arena was still running at
300 s, twice (once with shuffling, once without). Finding a colouring is local search's job, not
CDCL's — exactly what `CLAUDE.md` § What compute actually helps says.

**Constructed instead, in 0.7 s** (`build5.py`): take a proper 4-colouring `f` of the base with the
centre pinned to colour 0 — it exists by Theorem B and the solver returns it in 0.70 s — give copy
vertex `ρv` the colour `f(v) + 1`, and repair. **Two** cross edges clashed; both repaired; **0
improper edges** on all 544,530. Class sizes `[6379, 12773, 12801, 12791, 6389]`.

> **χ(`ρ₆₃` arena) = 5 exactly.** `≥ 5` is phase H2; `≤ 5` is this witness. The sweep at five colours
> is a question about a non-empty colouring space.

*(The other outcome was worth naming in advance and is why the check was run first: had the arena
refused five colours, that would have been `χ(ℝ²) ≥ 6`.)*

---

## §5 — Controls, and what each was seen to do

Everything below ran **before** any number about the arena was believed.

### 5.1 The instrument's own self-test — 8 checks, `python3 tools/arena_sweep.py --self-test`

| check | what it plants |
|---|---|
| `K₅ − e` at k=4 | the forced pair `(0,1)` must come back, and **only** it. It does |
| `K₅ − e` at k=4, virtual-edge side | 0 — the uninformative outcome, confirmed reachable |
| an **improper** colouring | must be REFUSED, not absorbed. It is |
| an **out-of-range** colour | REFUSED. This mutates the *constant*, not the logic |
| the in-range **twin** of that colouring | must be **ACCEPTED** — the paired faithful stub, so a reader can see the refusal above came from the range check and not from the scaffolding |
| a triangle at k=3 | 0 and 0 — the uninformative outcome fires |
| a path at k=2 | forced candidates `== [(0,2)]` |
| the packed counter vs brute force on a random graph | `16 == 16` |

### 5.2 The project's own instrument, my invocation — the known null

```
python3 tools/rigidity.py --graph tools/degrey_cert.json --k 5
  -> done; models 37, calls 37; forced-equal 0 confirmed / 0 unsettled; virtual edges 0 / 0
```
Identical to `build/m30-rigidity-1581-k5.json`. Saved as
`build/m63-phaseH4-sweep/control-rigidity-1581-k5.json`.

### 5.3 The **positive** control — the 791-vertex forcer at four colours

`build/m30-rigidity-forcer791.json` records exactly six forced pairs (G9: the axis pair at distance 4
and five antipodal pairs at `4/√3`). My instrument, a different engine on a different data structure:

```
models=20 forced-cand=11 | models=40 -> 10 | models=60 -> 6 | models=80 -> 6
[(6,306), (44,272), (78,269), (137,171), (148,249), (182,217)]
```

**Exactly the recorded six, identical pairs.** Two-sided: it converged (11 → 6, so it is not simply
reporting its input) and it stopped at 6 (so it is not driving everything to zero).

### 5.4 The **null** control — de Grey's 1581 at five colours, my instrument

```
models=20 forced=0 sep=14,609 | 40 -> 0, 214 | 60 -> 0, 2 | 120 -> 0, 0 | 140 -> 0, 0
```
**0 forced pairs and 0 virtual edges over all 1,248,990 pairs, 11.2 s.** Matches the record.

### 5.5 One control that failed, and how

My CaDiCaL wrapper spelled the wall-clock limit `--walltimelimit=`, which CaDiCaL rejects with exit
code 1; the wrapper read every non-10/20 exit as `"unknown"`, so **a bad command line was reported as
an undecided solve** — this project's oldest failure mode, a check reporting nothing when it cannot
run. Caught because the 791 control returned *no model at all* on a graph that solves in 0.25 s.
Fixed to `-t <sec>`, and the failure path made loud: any exit code outside `{0, 10, 20}` now raises.
Verified the guard fires (a deliberate bad flag gives rc=1).


---

## §6 — The sweep as it actually ran, and the three generator faults it exposed

### 6.1 The generator, and why it is not a solver

`tools/arena_sweep.py` consumes verified proper 5-colourings; `run_arena2.py` (scratch) produces
them. Each **model** is `(f, g, π)`: `f` a proper 4-colouring of the base, `g` another, `π` a random
injection `{0,1,2,3} → {0,…,4}`; base `i` takes `f(i)`, copy `ρv` takes `π(g(v))`, the 11–39 cross
clashes are repaired on the copy side, and then a **random maximal independent set in each half is
repainted with that half's spare colour**. Pool: **240 base 4-colourings**, each verified proper
against all 272,232 base edges before use; models cycle the pool with fresh `g`, `π` and independent
sets. Cost: **≈0.14 s per model**, no solver in the loop after the pool is built.

The pool cost 240 CaDiCaL calls at ~0.7 s each. **A first attempt used a 200-pin random ladder for
diversity and cost 26 CPU-seconds per accepted colouring instead of 0.70** — it was paying for UNSAT
at the top of the ladder. Killed and replaced by random vertex relabelling (which re-orders every
decision CaDiCaL makes) with an 8-pin ladder; the pool is checkpointed to
`ckpt/basepool.jsonl` outside `build/`, so the kill cost nothing.

### 6.2 Three faults, each found by a number that did not move

Every one of these looked like a fact about the object and was a fact about my generator. They are
listed because the pattern is the milestone's own G21: **a survivor count that plateaus is measuring
the generator's image, not the graph.**

| # | symptom | cause | the one-variable fix and its effect |
|---|---|---|---|
| 1 | forced-pair candidates **plateaued at 139,551** from model 40 to model 240 | base vertices never wore the fifth colour, so any pair that is a **virtual edge of the base at four colours** survived for free | repaint a colour-class subset with the spare colour: **139,551 → 99**, same pool, same 240 models, same recipe |
| 2 | virtual-edge candidates **plateaued at 22.3 M** | the repaint took a subset of **one colour class**, so two vertices `f` already separates could never meet on the spare colour | repaint a random **maximal independent set** instead, which mixes classes: **22,380,083 → 999,152**, and still falling rather than flat |
| 3 | the surviving **99** sat *entirely* on the 163 cross-incident vertices | I had excluded exactly those from repainting, to make it clash-free by construction | include them and undo any clash by reverting the promoted endpoint (which can only restore an already-proper colouring): **99 → 0** |

**And one fault that was not what it looked like.** Repainting first made the repair fail at
high-degree vertices and discarded **215 of 240 models**; I read that as promotion breaking
properness. Measured on four models: promotion adds **exactly 0** clashes (11/17/39/11 before,
identical after). It was an **ordering** failure — repainting filled the copy's palette so the repair
had no free colour left. Repair first, repaint second: **0 discarded.** The measurement said what no
amount of reasoning about the mechanism did.

### 6.3 The control this null most needed: the edge list is complete

**A missing unit edge makes the graph easier to colour, which produces more refutations, which
reads as a cleaner null.** That is this milestone's own measured-half/derived-half caution in its
exact form, and it is the direction in which everything below is fragile. So the edge list was
checked for completeness **independently of its producer**: coordinates rebuilt from
`graph.json`'s integer lattice vectors through `recon.py`'s own map
`(a,b,c,d) ↦ ((a + b√33)/12, (c√3 + d√11)/12)`, the copy placed by `ρ₆₃ = (31 + 3i√7)/32`, and every
pair within distance `1 + 10⁻⁶` enumerated with a KD-tree.

| tolerance on `\|d² − 1\|` | unit pairs found | missing from the list | extra in the list |
|---|---|---|---|
| 1e-13 … **1e-07** | **544,530** | **0** | **0** |
| 5e-07 | 544,566 | 36 | 0 |
| 1e-06 | 544,590 | 60 | 0 |

**Six decades of tolerance return exactly the committed edge set, both ways.** The 544,530 real
edges sit at `|d² − 1| ≤ 3.0e-15`; the nearest non-edge is at **1.1e-07**, seven to eight orders of
magnitude away. The 60 that appear only at 1e-06 are **near-misses, and all 60 are base–copy**,
which is where they belong: the rotation is irrational over `K`, so the copy nearly lands on the base
lattice without ever landing on it. (That near-miss band is G7's detuning in raw numerical form.)

### 6.4 The arena's whole compulsion budget is 66 edges — verified

The base half is 4-colourable (Theorem B), the copy is an isometric image of it, and they share only
the centre plus 126 cross edges of which **66 are genuine** (30 diagonal, 36 off-diagonal; the other
60 are the centre star and duplicates of base edges). Delete those 66 and colour the copy by
`f ∘ ρ⁻¹`:

```
arena 544,530 edges -> 544,464 after deleting the 66 named by the coupling record
f on base, f o rho^-1 on copy : 0 improper edges   -> 4-COLOURABLE
the SAME colouring on the FULL arena: 54 improper edges   <- paired faithful-stub control
```

So by the spare-colour lemma, **`G` minus 66 of its 544,530 edges has no compulsion at five colours
at any arity, in either polarity.** Everything the sweep below is looking for has to be manufactured
by those 66 edges, acting on 163 vertices. That is the number to hold on to.

---

## §7 — Predictions, scored

Registered in `build/m63-phaseH4-sweep/PREDICTIONS-registered.md` before any arena number was read.

| # | prediction | outcome |
|---|---|---|
| **P-SW-1** | no forced pair at five colours; candidates reach 0 within 200 models | **MET, but not as predicted.** The count reached 0 at 240 models only after the generator's third fault was fixed; under the generator as first written it plateaued at 139,551 and would never have reached 0. The prediction was right about the object and wrong about the instrument, and the instrument is what the 200 was a number about |
| **P-SW-2** | virtual-edge candidates reach 0 at ≤ 250 models, from a 0.79/model rate transferred off the 1581 | **NOT MET, by 18×.** Zero was reached at **4,480 models**. The transferred rate was the error: the measured per-model survival factor on this object is ~0.993, not 0.79 |
| **P-SW-3** | the critical-vertex screen cannot fire; max cross-degree is small | **MET on the structure, not measured on the solver, exactly as registered.** Every one of the 132 interface vertices carries **exactly one** cross edge (max cross-degree 1 over all 51,133). No solver hours were bought; the measured non-criticality remains phase H4's 29 of 51,133 |

**P-SW-2's failure is the useful one and it has a name.** I took a per-model survival factor
measured on a 1,581-vertex object and used it as a per-model factor for a 51,133-vertex one. That is
this milestone's standing error — *a number in a ruling travels with its units, its conditions and
its population* — in its eighth instance. The two rates differ because the **colouring generators
differ**: the 1581's models come from a solver exploring the whole colouring space, this object's
from a structured family whose diversity is bought at three named places. A rate is a property of
the instrument at least as much as of the object.

### 6.5 The bookkeeping audited at full scale, not only on the toy

The self-test checks the packed counter against brute force on a 40-vertex graph. At `n = 51,133`
the packing, the padding bits and the adjacency mask all do real work, so the same comparison was
run there: 120 models kept in full, then **4,000 random pairs** compared between the bit matrix and
a direct scan of the raw colour vectors.

```
audit: 4000 random pairs, 0 mismatches between the bit matrix and a direct scan
  ever-same 3986, ever-different 4000        <- the sample is not degenerate
  counts: forced-cand 0, sep-cand 3,263,208
  planted bit flip at (17,4321): the direct-scan comparison catches it: True
  planted bit flip: the SYMMETRY assertion fires  (must, and does)
  restored: sep-cand 3,263,208               <- paired faithful stub, exactly the value above
```

A single corrupted bit is caught **twice** — by the direct comparison and, unplanned, by the
`tot % 2 == 0` symmetry assertion inside the counter, which fired on the first run of this audit
before I had reordered the output. Restoring the bit returns the identical count.

### 6.6 What the sweep was shooting at, and why the stakes were maximal

Not "a step toward χ ≥ 6". **A single forced pair would have been the whole thing.** The chain is
three theorems this repository already holds, with no arithmetic side condition:

1. `Forces.planeIn` (`Homogeneous.lean`) — a pair forced equal at `k` colours in **any** finite
   unit-distance graph, at distance `d`, forces **every** plane pair at distance `d`, by placing an
   isometric copy of the gadget.
2. `not_colorable_of_forced_equal` (`OneDefect.lean`) — if every plane pair at some `d ≥ 1/2` is
   forced equal at `k` colours, the plane is not `k`-colourable. (The two legs of a `d`–`d`–`1`
   triangle are forced equal and its unit side is an edge. The Moser spindle is `k = 3`, `d = √3`.)
3. Hence a forced pair at five colours, at any distance `≥ 1/2`, anywhere in this arena, is
   **χ(ℝ²) ≥ 6**.

Ledger row 55's arithmetic bar on five-colour forced pairs (`11 ∣ d²`) is the bar that would
normally make this hopeless — and it **does not apply here**, because `L` is 6-open (§1.2). This is
the first sweep this project has run where a five-colour forced pair is arithmetically permitted at
every distance.

On the virtual-edge side the target is row 43 / G26: five-colour gadgets at `√3` **and** at 2 give
χ(ℝ²) ≥ 6. Exact census of where such a gadget could sit, from the lattice shells (controls: the
unit shell has 30 vectors and reproduces all 272,232 base unit edges; the cross law reproduces all
126 cross edges):

| distance | pairs in the base half |
|---|---|
| 1 (edges) | 272,232 |
| **√3** | **285,276** (`\|shell(3)\| = 42`) |
| **2** | **181,281** (`\|shell(4)\| = 30`) |

The copy carries the isometric image of every one of those. A base–copy pair at any *rational*
squared distance needs the two points **collinear with the centre** (the `√7` component must
vanish) — the same condition the cross-edge law uses. All of them are inside the sweep regardless,
which quantifies over every pair.


---

## §9 — What the result changes

### 9.1 De Grey's null was never about his field, and now it is not about his construction either

G31 says de Grey's 1581 holds nothing at arity 2 or 3. G43 already withdrew the arithmetic
explanation: **his field `ℚ(√3,√5,√7,√11)` is itself 6-open**, so row 55's bar never applied to him
either. What was left was the possibility that the emptiness was a property of *his* construction —
a shrunk object, inherited rather than produced, with three critical vertices and a 1-sum.

This object is the opposite in every one of those respects: **purpose-built, half the field degree
(8 against 16), refusal produced rather than inherited, no 1-sum, no cheap critical vertex, a
coupling spread over 66 edges instead of one.** It is equally empty at arity 2.

> **Two independently built five-chromatic objects, in 6-open fields, share the same arity-2 null.
> The emptiness is not a property of de Grey's graph.**

### 9.2 The design number this hands over: a "base plus one rotated copy" has a compulsion budget of
### its cross-edge count, and 66 is not enough

§6.4 is the sharp form: **deleting 66 of 544,530 edges four-colours the arena**, so by the
spare-colour lemma everything the sweep hunts must be manufactured by those 66 edges on 163
vertices. That is a very thin instrument to expect a pair compulsion from, and the sweep says it is
too thin.

**This is a design criterion, and it is not the one the family screen has been optimising.** The
type-M screen (`plans/M63-phaseH2-the-family.md`) ranks members by radicand, wall-breaking and
6-openness, and phase H3's "drop the shape" argues for `n = 2` on **circle count and unit-neighbour
count**. Those are the right instincts and this measurement sharpens them into a number: what a
type-M arena can compel is bounded by the size of its **genuine** coupling — the cross edges that
are neither the centre star nor duplicates of base edges. `ρ₆₃` has 66 of them (30 diagonal, 36
off-diagonal), and G52's sharpening already said the diagonal 30 are the *free* part. **So the live
quantity is the off-diagonal count, and this object has 36.**

### 9.3 It does not touch FS-6, and saying why matters

FS-6 / G48 wants a pair forced equal at five colours **over a 5-SEALED field** at a distance with
`11 ∣ d²`, then spindled — the spindle removes the sealing prime and lands in a 6-open field by
construction. This object is *already* in a 6-open field: it is the **destination** of that
mechanism, not its source. A forced pair here would have skipped the mechanism entirely and been
χ ≥ 6 outright (§6.6). Its absence says nothing about whether a 5-sealed field carries one.


---

## §10 — The one thing I would most want checked by someone else

**Not the null. The edge list underneath it.**

§6.3 is the control I most believe in and the one whose failure would be invisible: a missing unit
edge makes the graph easier to colour, produces more refutations, and reads as a *cleaner* null. I
checked it — six decades of tolerance return exactly 544,530 edges, 0 missing and 0 extra, with the
nearest non-edge seven orders of magnitude away — **but I checked it in floating point**, against
coordinates I rebuilt from `graph.json`'s integer lattice vectors through a map I read out of
`recon.py`. Two things could still be wrong and would not show:

1. **The coordinate map.** If `(a,b,c,d) ↦ ((a + b√33)/12, (c√3 + d√11)/12)` is not the map that
   produced the committed edge list, then my geometry and my edge list are two views of *different*
   objects that happen to agree — the module-identity failure this repository already has a rule
   about. The evidence against that is strong (all 544,530 listed edges land at `|d²−1| ≤ 3e-15`,
   and the independent lattice-shell recount reproduced 272,232 base unit edges and 126 cross edges
   exactly), but it is agreement, not provenance.
2. **The exactness of the cross edges.** Base–base unit pairs are decided by an integer identity in
   the shell recount, so those are exact. The 126 cross edges were re-derived here only through
   `typem.CrossLaw`, i.e. through the same library phase H2 used. An independent exact re-derivation
   of the cross edges — `q = 0` and `cos θ · p = k` in `K`, from the coordinates, by someone else's
   code — is the check I would buy.

Second choice, and it is the reusable half: **the equivalence in §1.2 — "6-open" and
"residue-filterable at five colours" are complementary by definition.** It rests on (i) a
multiquadratic field's Frobenius having order ≤ 2, so odd residue degree means degree one; (ii)
`fplane.py usable` enumerating that supply completely; (iii) every usable prime of
`ℚ(√3,√7,√11)` having a plane that refuses five colours — 83 by exact Kloosterman spectrum, the rest
by Weil. If that is right it is a permanent structural fact about this hunt, not a fact about this
object, and it deserves a second reader.


---

## §11 — Arity 3, and the honest scope of it

**The restriction is a choice, not a derivation.** The full arity-3 space is
`C(51133,3) ≈ 2.2 × 10¹³` triples, and the bit-matrix trick does not extend (`tools/m48.py`'s mask
engine allocates `n × n × H/64`, which is ~21 GB at `n = 51,133` and the minimum legal harvest, and
its `screen3` indexes `M[u,v]` directly). So the sweep was pointed at the **163 interface
vertices** — every vertex incident to a cross edge — on the reasoning of §6.4 that all of this
object's coupling lives there.

That reasoning **supports the choice and does not license it**: §6.4 says the arena *minus 66
edges* has no compulsion, not that the arena's compulsions have endpoints on those edges. A
three-vertex compulsion could sit anywhere. What was swept is **3,502,728 admissible questions**
(plus 40,077 skipped as inadmissible — a pattern putting one colour on two adjacent vertices), which
is about `1.6 × 10⁻⁷` of the arity-3 space.

Collapse on that set, same generator:

| models | candidates remaining |
|---|---|
| 640 | 10,626 |
| 3,000 | 1,784 |
| **12,000** | **337** |

It is falling and it has not reached zero. **Unlike the arity-2 side, this is NOT settled.** The 337
survivors sit on 124 of the 163 interface vertices and are almost all of two pattern classes:
**232 all-same** and **103 all-distinct**, with 2 of the mixed kind. Decay is roughly `models^-0.85`,
so more sampling is the wrong instrument — reaching zero that way would take on the order of 10⁵
models.

**One thing about them is worth stating, and it follows from the arity-2 result.** `tools/arity.py`
carries an `explained_by_subtuple` verdict for a triple whose pattern is unrealizable only because
one of its *pairs* is. **Here that verdict is unreachable**: arity 2 is completely empty in both
polarities, so every pair pattern is realized. **Any arity-3 compulsion on this object would
therefore be irreducible** — a genuine three-vertex object, not a pair compulsion in disguise. That
raises the value of settling these 337 and lowers the chance that they are real.

The right next move is **targeted realisation**, not more models: a candidate pattern on three
interface vertices is realised by pinning those three colours inside the two base 4-colourings that
build a model — two solves with at most three unit clauses each. That converts a sampling question
into a construction question, at a few seconds per candidate rather than hours of sampling. Not run
here; it is the first item of any continuation.


---

## §12 — Instruments, and where everything lives

| what | where |
|---|---|
| the sweep engine, with `--self-test` | `tools/arena_sweep.py` (new this phase) |
| the model generator and drivers | scratch, `/home/kooshi/.claude/jobs/d4cccfde/tmp/sweep/` — `run_arena2.py`, `arity3.py`, `audit.py`, `target.py`, `coords.py`, `sat.py` |
| the base-colouring pool (the expensive part) | `…/sweep/ckpt/basepool.jsonl` — **outside `build/`**, per the standing rule |
| results, controls, predictions | `build/m63-phaseH4-sweep/` with its own `README.md` and the resume commands |
| the arena itself | rebuilt from `build/m63-phaseH2-artifacts/solver-h2/edges.txt` (do not delete that tree) |

**Resume:** `cd …/sweep && python3 -u run_arena2.py <MODELS> 1 <tag>` — the pool is reused
automatically, so a kill costs only the sweep, never the solver time.

**Machine discipline.** One core for the sweep at a time; the desktop's load stayed at 2–4 of 32
threads throughout. Two self-inflicted incidents, both the documented one: `kill -TERM -<pgid>` and
`pgrep -f run_arena.py` each matched **my own wrapper shell** and killed it (`CLAUDE.md`'s
`pkill -f` hazard, in two different spellings). Orphaned solver children were then cleaned by PID.
Nothing unexplained; nothing lost, because the pool is checkpointed.

---

## §8 — THE VERDICT: the `ρ₆₃` arena holds nothing at arity 2, in either polarity

**Population: every pair of the 51,133 vertices. Nothing sampled, nothing restricted.**

| | population | candidates surviving | certified by |
|---|---|---|---|
| **forced pairs** (`Forces G 5 p q`) | **1,307,266,278** — every pair | **0**, from model 80 onward | 4,480 exhibited proper 5-colourings, each verified edge by edge, at least one separating each pair |
| **virtual edges** (`Separated G 5 p q`) | **1,306,721,748** — every non-adjacent pair | **0**, reached at model 4,480 | the same 4,480 colourings, at least one uniting each pair |
| adjacent pairs | 544,530 | excluded — an edge is separated trivially | — |

Collapse, both sides, one run:

| models | forced-pair candidates | virtual-edge candidates |
|---|---|---|
| 20 | 1,448 | 54,696,530 |
| 40 | 42 | 16,261,458 |
| 60 | 1 | 8,050,691 |
| **80** | **0** | 5,563,333 |
| 200 | 0 | 1,386,411 |
| 1,000 | 0 | 7,828 |
| 2,000 | 0 | 107 |
| 4,460 | 0 | 1 |
| **4,480** | **0** | **0** |

**The null is constructive, not an absence.** Every one of the 1.31 billion pairs is refuted by an
exhibited colouring that a reader can re-verify against the edge list; nothing here rests on a
solver's UNSAT, and no pair was ever handed to a solver. A compulsion could not have hidden from
this: the survivor set is a superset of the truth by construction, so a positive would have had to
appear in it.

### The cost, against the estimate that motivated the arithmetic filter

| | |
|---|---|
| the estimate that made a raw sweep look unaffordable | **363 hours** (one solver call per pair) |
| what it actually cost | **240 solver calls** for the base pool (~8 minutes across 14 cores) plus **1,212 seconds** of single-core sweeping |
| total | **about half an hour**, on one to fourteen cores of a 32-thread desktop |

**The filter was never needed, and the reason the estimate was wrong is the same reason it was wrong
in §2 of this milestone's own reduction plan** — a per-pair unit price on a quantity that is not
paid per pair.

### χ of the object, settled in passing

`χ(ρ₆₃ arena) = 5` exactly: `≥ 5` is phase H2's refutation, `≤ 5` is the constructed witness of §4.
Nothing on record had established the upper half.


---

## §13 — What to do next, ranked

1. **Settle the 337 arity-3 interface candidates by targeted realisation** (§11). Hours, not days,
   and the arity-2 null makes every one of them irreducible if real.
2. **Take the design number to phase H3.** §9.2: a type-M arena's compulsion budget is its
   **genuine** cross-edge count, and the live part of that is the **off-diagonal** share (G52's
   sharpening already retired the diagonal 30 as free). `ρ₆₃` has 36 off-diagonal cross edges and
   compels nothing at arity 2. Rank candidate bases by that number, not by circle count.
3. **Point the sweep at the other objects.** The instrument now takes any `{n, edges}` graph and
   costs minutes. Heule-510/553, the M53 witnesses in `K(√247)` and `K(√23)`, and phase H3's
   shape-free arena have never been swept at five colours. Heule's field is **5-sealed**, so those
   are the ones where FS-6 / G48 actually wants a forced pair — and where row 55 says it must sit at
   `11 ∣ d²`, a filter that *does* apply there.
4. **Do not sweep another 6-open object expecting a compulsion** until something changes about the
   construction. Two purpose-different objects in 6-open fields now hold nothing at arity 2.

---

## §8.1 — Four objects, both sealing statuses, the same null

The instrument now takes any `{n, edges}` graph and costs seconds on a small one, so three more
objects were swept while the arena's long run finished. Record: `build/m63-phaseH4-sweep/four-objects-k5.json`.

| object | field | sealing | pairs | models | forced | virtual edges |
|---|---|---|---|---|---|---|
| de Grey 1581 | `ℚ(√3,√5,√7,√11)` | **6-open** | 1,248,990 | 140 | 0 | 0 |
| **`ρ₆₃` arena** | `ℚ(√3,√7,√11)` | **6-open** | **1,307,266,278** | 4,480 | **0** | **0** |
| **Heule 510** | `ℚ(√3,√5,√11)` | **5-SEALED** | 129,795 | 200 | **0** | **0** (4.9 s) |
| **Heule 553** | `ℚ(√3,√5,√11)` | **5-SEALED** | 152,628 | 200 | **0** | **0** (5.4 s) |

> **The emptiness is not about the field.** Four five-chromatic unit-distance objects, two in 6-open
> fields and two in a 5-sealed one, built by three different people for three different reasons —
> and not one of them carries a pair compulsion at five colours in either direction.

**The two Heule objects are the ones that matter for FS-6, and they are the new information.**
G48's mechanism asks for a pair forced equal at five colours **over a 5-sealed field**, at `11 ∣ d²`,
to be spindled into a 6-open one. `ℚ(√3,√5,√11)` is 5-sealed (11 is usable there and
`χ(UD(𝔽₁₁,2)) = 5`), and row 55's arithmetic bar therefore *does* apply — it says such a pair must
sit at `11 ∣ d²`. **The best five-chromatic objects known in that field have no such pair at any
distance.** That is a measured fact about FS-6's source side, and it was five seconds of work.

