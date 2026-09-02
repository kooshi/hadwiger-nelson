# M48 — The from-below arity question: at what order is de Grey's witness compelled?
#
# SUBPLAN, 2026-08-14. Grown from the self-contained stub of 2026-08-13/14 (§1–§3 below are the
# stub's, lightly edited); §0 and §4–§9 are the subplan proper. The stub's own reading rule stands:
#
#   [derived]     worked out on paper; true or false independent of us.
#   [measured]    an instrument produced it, with its address on disk and its machine named.
#   [registered]  a prediction with a prior, committed before the campaign runs.
#
# WORKFLOW step 3 says "where cost decides the shape, measure before specifying, not after."
# §4 is that measurement. Every phase below was priced on the desktop before it was written down,
# and two phases exist in the shape they do *because* the price came back affordable — the complete
# arity-3 sweep in particular was not obviously reachable and is.

---

## §0. REGISTRATION — committed before any campaign instrument runs

### §0a. Derivations, worked on paper first

**D1 — the target needs TWO distances, not one.** The project's grokking G26 states the reduction as
"a 6-forcer needs one gadget at √3 **or** 2". Read against the kernel object it names,
`hexShellPairs` in `Instances/HexShell.lean`, that is too weak: the list is `hexShellP3 ++
hexShellP4` — **six** pairs at √3 (the ring's 120° gaps) and **three** at distance 2 (its diameters)
— and `hexShell_plane5` is *disjunctive over both classes*. Killing all six √3 placements leaves the
three diameters standing. **χ(ℝ²) ≥ 6 needs a virtual edge at √3 AND one at distance 2.** Either
alone is a major result that halves the problem. *This is promoted to a kernel theorem in §5.*

**D2 — an arity-3 compulsion cannot be a generalized Act One, and this must be said BEFORE any hit
is interpreted.** Act One is a pigeonhole: `n` points, `k` colours, some colour class of size
`⌈n/k⌉`. To force a monochromatic *pair* at five colours needs `n ≥ 6`; the shell uses 7. To force a
monochromatic **triple** needs `⌈n/5⌉ ≥ 3`, i.e. **`n ≥ 11`**. But a point set whose mutual distances
all lie in `{1, √3, 2}` has diameter ≤ 2 and minimum distance ≥ 1, so:

* by Jung's theorem it lies in a closed disc of radius ≤ `2/√3`;
* the open discs of radius `1/2` about its points are pairwise disjoint and all lie inside a disc of
  radius `2/√3 + 1/2`;
* comparing areas, `n · (1/2)² ≤ (2/√3 + 1/2)²`, so `n ≤ 4(2/√3 + 1/2)² = 10.95…`, i.e. **`n ≤ 10`.**

Ten is less than eleven, so **no configuration in the shell's own distance vocabulary can force a
monochromatic triple at five colours.** Widening the vocabulary to diameter 3 admits up to 19 points
(same computation, `4(√3 + 1/2)² = 19.9…`) but the classes it admits — `√7` and `3` — are not
spindle-able: a spindle at distance `d` needs `4d² − 1` to be a square in the fabric's field, and
`4·7 − 1 = 27` and `4·9 − 1 = 35` are not squares. **The kill burden grows faster than the
pigeonhole.** *Registered consequence: a compulsion found at arity 3 from below is a statement about
mechanism — the order the object's rigidity lives at — and NOT a rung toward χ(ℝ²) ≥ 6. Any hit is
reported that way.*

**D3 — the ladder theorem: the arity floor is monotone under graph embeddings.** If `f : H ↪g G` is
a graph embedding (injective, preserving *and reflecting* adjacency) then every compulsion of `H`
transports to one of `G`:

* `f ∘ S` is injective, and `f` reflects adjacency, so local properness carries over;
* if some `C : G.Coloring (Fin k)` wore the pattern on `f ∘ S`, then `C ∘ f` is a proper colouring of
  `H` wearing it on `S` — contradiction.

Hence **`arityFloor G k ≤ arityFloor H k`**: growing the object can only lower the floor. This is
the arity analogue of M19's coverage ratchet, and it is what licenses the whole closure-ladder
reading in §6 — "the floor did not drop from the 1581 to its gen-1 closure" is then the statement
that an inequality is *tight*, not a coincidence of two independent measurements. *Kernel-checked in
§5.*

**D4 — the plane is homogeneous, so ONE forced pair is ALL of them.** If a finite unit-distance graph
drawn in the plane forces two of its points at distance `d > 0` to differ in every proper
5-colouring of the plane, then *every* pair at distance `d` differs. Given `x₀ ≠ y₀` with
`dist x₀ y₀ = d` and any `x, y` with `dist x y = d`, set `a = (y − x)/(y₀ − x₀)` — which has
`|a| = 1` — and `b = x − a·x₀`. Then `z ↦ a·z + b` is a distance-preserving bijection of ℂ carrying
`(x₀, y₀)` to `(x, y)`, so it is an automorphism of the unit-distance graph and the colouring pulls
back along it. *Kernel-checked in §5; it is the step that turns any future finite gadget into the
plane-wide hypothesis D1 consumes, and it is the reason the §5 layer is worth building now rather
than on the day a gadget appears.*

### §0b. The registered predictions

Sorted by provenance, this project's a-priori derivations have survived without exception and its
post-hoc inductive readings have died without exception — roughly 7-for-7 against 0-for-10, several
of the latter refuted by our own later work (grokking G30). So the predictions below are written
down *now*, with the evidence on both sides, and scored at the close whatever they do.

| # | prediction | prior | evidence FOR | evidence AGAINST |
|---|---|---|---|---|
| **P1** | The arity-2 control on the 1581 at `k = 5` reproduces zero — 0 forced pairs and 0 virtual edges over all **1,248,990** pairs, including all 3,216 at √3 and 1,092 at distance 2. | **95 %** | It is a reproduction of `build/m30-rigidity-1581-k5.json`, which is `status: done`, `unsettled: []`. | If it fails, the *instrument* is wrong and the campaign halts — this row is the calibration, not a discovery. |
| **P2** | The **complete** arity-3 sweep on the 1581 at `k = 5` — all **657,385,070** triples × all 5 patterns — returns **zero** compulsions with every sub-pair free. | **70 % zero** | The object is loose at five colours (χ = 5, so `k = 5` is its top rung); M35 measured fan rows at min-cover **2 of 5**; M30/M41 measured pairwise floppiness settled at `k = 5`; M45's arity-3 hits were on a stage **one vertex** from refusing. | The enumeration is five orders of magnitude larger than any from-below sweep ever run, and M45's lesson is that **coverage is the primary effect**; `arityFloor ≤ 5` guarantees *something* exists at arity ≤ 5. |
| **P3** | The **complete** neighbourhood arity-4 sweep — all **1,718,839** 4-subsets of vertex neighbourhoods × all 15 patterns — returns zero compulsions whose 3-subsets are free. | **60 % zero** | Same looseness argument; and the D4 mechanism at arity 5 needs *all five* colours pinned. | The neighbourhood is exactly where the guaranteed compulsion lives, so if arity 4 fires anywhere it fires here. |
| **P4** | Phase B: gen-1's own **73,256** target-class questions (52,616 at √3, 20,640 at distance 2) contain **no** virtual edge at `k = 5`. | **85 % zero** | Four campaigns flat; M31's "enrichment does not shrink the forcing" measured three times. | It is a genuinely new object with 15× the material, and it has **never been swept at all**. |
| **P5** | **The ladder is flat**: every question answered *realizable* on the 1581 is answered *realizable* on gen-1 for the same vertices. By D3 the floor can only drop; the prediction is that it does not. | **80 % flat** | G10, measured four times at `k = 4` and once at `k = 5`. | Nobody has asked it at `k = 5` *at arity 3*, and D3 says the inequality is real — a drop is possible, not merely conceivable. |
| **P6** | **The effort dial**: gen-1's per-colouring harvest cost exceeds the 1581's (0.31 CPU-s) by ≥ 10×, and at equal `H` its never-observed candidate fraction is *higher*. | **70 %** | More constraints per colouring; M41's only nonzero `k = 5` readings were both effort signals (dimers 10×, gen-2 ×300). | If the fraction comes back *lower*, the extra material is decorrelating the colouring pool rather than constraining it — which would be the first sign the closure does something structural, and is worth more than the prediction. |

### §0c. What a flat result would and would not license — written now, not at the close

This is the sentence M43 omitted and whose omission cost a grokking (G21, second instance).

**A zero at arity 3 licenses exactly:** `arityFloor(1581, k = 5) ∈ {4, 5}`, since arity 0 and 1 are
excluded by `two_le_arityFloor`, arity 2 is a settled complete zero, arity 3 is now a complete zero,
and `arityFloor_le_of_degree` caps it at 5. That is a *complete* determination up to one step, on an
object where nobody had asked at all.

**It licenses nothing about:** the plane; any other object; arity 4 outside vertex neighbourhoods
(`C(1581,4) = 259,338,410,115` — priced in §4d and explicitly OUT of scope); or whether a virtual
edge at √3 or 2 exists anywhere.

**Every negative in this milestone carries its enumeration in the headline sentence, not in a scope
line.** That is the standing rule minted at M45 and it is why `tools/arity.py` has no verdict called
"clean".

---

## §1. The project, for a reader who has never seen it

**The problem.** Colour every point of the infinite plane so that no two points exactly one unit
apart get the same colour. What is the fewest number of colours? This is the Hadwiger–Nelson
problem, open since 1950. The answer is known to be 5, 6, or 7.

**What this repository is.** A Lean 4 proof workspace. Lean is a proof assistant: you write
mathematical statements and proofs, and a small trusted program (the *kernel*) checks every step.
"Kernel-checked" below means the machine verified it from first principles, and the only things
taken on faith are three standard logical axioms everyone accepts.

**What is already kernel-checked here.** The classical interval, both ends: at least 5 colours are
needed (de Grey's 2018 result, re-verified here from a 1581-point graph) and 7 always suffice.

**The mission, and it is narrow.** This project exists *only* to find new mathematics — however
small — ratcheting toward a major finding. Formalizing known results is over as a goal. The
publication bar is exactly two events: possibly our own certified 5-chromatic object, and definitely
**χ(ℝ²) ≥ 6 or its refutation**. A rung that does not land is reported as not landed, never quietly
rescoped.

---

## §2. The target, stated exactly

**Act One is kernel-checked.** `Instances/HexShell.lean` holds `hexShell_plane5`:

> Every proper 5-colouring of the plane has two points of the same colour at distance **√3 or 2**.

Its carrier is the closed first shell of the triangular lattice — a point and its six unit
neighbours, seven points. Six colours cannot be spread over seven points without a repeat, and the
repeated pair is never a unit edge, so it lies at √3 or at 2. **Counting, not search.**

**Act Two is what is missing.** To turn Act One into `χ(ℝ²) ≥ 6` you must refute every one of the
nine placements: a finite unit-distance graph in which two points at that distance are forced to
receive **different** colours in every proper 5-colouring. Such a forced-different pair is called a
**virtual edge** — an edge the colouring theory already believes in, though no unit distance joins
the two points. Per **D1** you need one at √3 **and** one at 2; per **D4** one of each suffices for
the whole plane. Both radicands sit inside the 5-forcers' own field (`4d² − 1` is `11` at √3 and
`15` at 2), so neither is out of reach in principle.

---

## §3. What has already been measured, and why this milestone is not a re-sweep

An earlier draft of this file asserted the from-below pair question had only ever been asked forty
times. **That was wrong, and checking it before running anything is why the milestone changed.** The
true state, verified on disk:

| object | size | arity-2 sweep at `k = 5` | result | address |
|---|---|---|---|---|
| de Grey's 1581 witness | 1,581 pts / 7,877 edges | **COMPLETE and SETTLED** — 37 models, `unsettled: []` both sides, 30.2 s | 0 forced pairs, 0 virtual edges | `build/m30-rigidity-1581-k5.json` |
| twelve composed objects | up to 5,533 pts | **COMPLETE and SETTLED** — 38–110 models each | 0 and 0, every one | `build/m41-rigidity-*.json` |
| gen-1 closure | 24,065 pts / 123,134 chords | **never run** | — | — |
| gen-2 closure | 284,873 pts / 1,477,824 edges | **40 targeted asks only**, all satisfiable | no virtual edge among those 40 | `build/m41-gadget-asks.json` |

**How to read "settled".** `tools/rigidity.py` does not sample: it draws proper colourings until
every pair has been *seen* both ways, then confirms the survivors in one batch query whose UNSAT
settles all of them at once. `unsettled: []` means the candidate set emptied. On the witnesses,
**zero means zero over every pair**. That is a strong, complete negative and it is respected as one.

**So what is genuinely unasked is the ARITY.** `arityFloor_le_of_degree` (kernel, M45) says a vertex
with `k` distinct neighbours makes the all-different pattern on them unrealizable, so the floor is
at most `k` **with no hypotheses at all**. De Grey's graph has 1,557 vertices of degree ≥ 5 and two
of degree 60. *(Read the hypothesis carefully: it needs SOME vertex with `k` distinct neighbours,
not every vertex. The 1581's minimum degree is 4 and is irrelevant.)* So **a compulsion of arity ≤ 5
is guaranteed to exist, while arity 2 is settled EMPTY** — the floor is in `{3, 4, 5}` by theorem,
and nobody has ever asked which.

That is a calibrated bed of the kind grokking G30 asks for, met better here than at M45: the arity-2
answer is not merely certified, it is complete. **A zero at arity 3 is a real statement about the
mechanism; a hit is the first nonzero structural reading the from-below direction has produced.**

---

## §4. The measurements that decided this subplan's shape

*Desktop, 32 cores, 125 GB, 2026-08-14. Scratch scripts under the session scratchpad;
everything below is re-derived by the campaign driver at run time, never read from these notes.*

### §4a. The objects, with their controls

| object | n | unit edges | √3 pairs | distance-2 pairs | control |
|---|---|---|---|---|---|
| de Grey 1581 (`76b8163b27fe6f96`) | 1,581 | **7,877** | **3,216** | **1,092** | the 7,877 is the committed count, reproduced from exact field arithmetic |
| gen-1 half-spindle closure | **24,065** | **123,134** | **52,616** | **20,640** | 123,134 is M31's number; the 1581's own 7,877 edges reproduce exactly inside the sweep |

Built in 3 s; the exact three-class pair enumeration takes 93 s. Degree profile of the 1581: min 4,
median 10, **max 60 at exactly two vertices** — the two spindle centres, which is grokking G2's
ring-heart reading appearing in the degree sequence.

### §4b. The arity-3 screen is affordable, and that is the milestone's central fact

`C(1581, 3) = 657,385,070`. Asking each triple with a solver is impossible. The screen that makes it
possible is a **pair colour-agreement mask**: for `H` harvested proper colourings, `mask[u][v]` is
the `H`-bit set of colourings in which `u` and `v` share a colour. Every arity-3 pattern's
observed-set is then a boolean combination of three such masks, so *all* triples × *all* 5 patterns
are screened with bit operations alone.

| step | measurement |
|---|---|
| vacuity guard, `k = 5` | `sat` in **0.11 s** |
| harvest | **8,062** proper colourings in **88 s** on 28 workers (≈ 0.31 CPU-s each) |
| mask build, `H = 1024` | 31 s, **305 MB** (`H = 4096` ⇒ ≈ 1.3 GB, fits) |
| full `C(1581,3)` screen | **2.3 min single-core, ~8 s on 28 cores** |
| screen correctness | mask vs. direct recomputation on 200 random triples: **200/200 agree**, at two values of `H` |
| one confirm call | median **0.11 s**; 12 sampled candidates all `sat` |

**Diversity, not count, is the binding constraint** — and it was measured rather than assumed. The
harvest's 6 random unit-clause seeds give colourings too alike; raising the seed count to ~200 (with
fallback on UNSAT) roughly triples the effective independence. Never-mono fraction against `H`:

| `H` | 64 | 256 | 1024 | 2048 | 4096 |
|---|---|---|---|---|---|
| fraction never seen monochromatic | 0.4201 | 0.1585 | 0.02944 | 0.009569 | **0.001513** |
| candidates over `C(1581,3)` | 276 M | 104 M | 19.3 M | 6.3 M | **994,104** |

The decay is **accelerating, not flattening** (×0.16–0.33 per 4× `H`), so there is no visible hard
core of never-realizable triples and the screen terminates. Even at the pessimistic `H = 4096` stop,
994,104 candidates × 0.11 s ÷ 28 cores ≈ **65 minutes** — and the observe-then-confirm loop feeds
each solved candidate's colouring back into the pool, which kills survivors in bulk, so the real
cost is far below that.

### §4c. Traps found while pricing, all now planted as assertions

* **Python 3.14 defaults to `forkserver`, not `fork`.** Every `ProcessPoolExecutor` entry point needs
  a module-level function *and* an `if __name__ == "__main__":` guard, or the workers die with a
  `ConnectionResetError` that looks like a machine fault. (M45's trap in a new form.)
* **`closure.nsq` returns a `list`, not a `tuple`.** Norm constants built with `tuple(...)` compare
  unequal to every norm forever, so the √3 and distance-2 classes come back **empty and the unit
  class comes back right** — a silent half-failure that the unit-count control alone would pass. The
  campaign asserts `nsq(1+1) == FOUR` before classifying anything.
* Pattern masks must use `H` a multiple of 64, or the padding bits above `H` read as 1 under
  negation and manufacture false *observed* readings on every pattern with a disequality.

### §4d. What is out of scope, priced

`C(1581, 4) = 259,338,410,115`. Screening it needs ~60 numpy operations per triple over all fourth
vertices — about **20 hours on 28 cores for the screen alone**, before any confirm, and the
mono-4 candidate density is far higher than at arity 3. **The general arity-4 sweep is not run and
is not planned.** What *is* complete at arity 4 is the neighbourhood sweep: `Σ_v C(deg v, 4) =
1,718,839` tuples, which is the D4 mechanism's own home and is affordable. gen-2 (284,873 points,
343 s per colouring at `k = 5`) is priced for Phase B and taken only if gen-1 finishes early.

---

## §5. The kernel layer (after the domain-modeling pass, 2026-08-14)

Small, and each theorem exists because a specific reading in §6 needs it. The pass changed the shape
of all three drafts and found one live error; what follows is what it converged on.

### §5a. What the pass changed

**(i) The ladder theorem splits in two, and the half the measurement uses is the weaker one.** The
draft bundled everything into `Compels.map`. But `Compels` is a conjunction of two clauses that
travel in *opposite directions along different amounts of structure*:

* **`Realizes` is reflected by any graph homomorphism.** Given `f : G →g G'`, a proper colouring of
  `G'` wearing pattern `p` on `f ∘ S` pulls back (`Coloring.comap`) to a proper colouring of `G`
  wearing `p` on `S`. **No injectivity, no adjacency reflection.**
* **`PartialColoring` is preserved only by an embedding** — injectivity is needed to keep `f ∘ S`
  distinct, and adjacency *reflection* to carry `¬ G.Adj` up to `¬ G'.Adj`.

So `Compels` needs `↪g`, and both halves of `↪g` are consumed, at different places — neither is
spare, which is the convergence signal. And `↪g` is *exactly* "induced subgraph along `f`", which is
exactly what the measurement has: gen-1's unit edges restricted to the original 1,581 vertices
reproduce all 7,877 and no more. **Naming the weak half separately is subtraction, not addition** —
it is the statement the ladder phase actually consumes, since "realizable on gen-1" is the *stronger*
answer and implies "realizable on the 1581", so a sweep higher on the ladder subsumes one below it.

**(ii) Homogeneity needs neither a side condition nor an isometry *equivalence*.** The consumer only
ever pulls a colouring back, so a bare distance-preserving map (`Isometry g`, no surjectivity)
suffices — and `unitDistanceHom` + `Coloring.comap` is already the house idiom for exactly this
(`IndepSearch.lean:235`). Better, the `x₀ ≠ y₀` hypothesis **dissolves**: at zero distance the
hypothesis `∀ C, C x₀ ≠ C y₀` refutes itself against any colouring, and the conclusion supplies one.
The parameter `d` dissolves too — say `dist x y = dist x₀ y₀` and be done. The colour type is
generic for free.

**(iii) The target's bridge already exists — one notion over — and its twin is missing.**
`Forcer.lean` has **`Forces.comap`**: a forced-*equal* pair in a gadget is forced in every graph the
gadget maps into, `h (C.comap φ)`, one line. The forced-*different* dual — `Separated.comap` — which
is precisely what Act Two needs, **is not there.** That is the "a role unnamed" smell in its
absence-shaped form, and it settles the plan's open design question: the consumer surface is not a
new twelve-argument gadget theorem, it is *completing an existing pair*. The composition theorem
then takes **plane-wide** hypotheses, because `Separated.comap` has already done the gadget→plane
step and repeating it inside the composition would duplicate it.

The chain is four links, each one or two lines, each hypothesis exactly the previous conclusion, and
its entry point is the vocabulary `tools/arity.py` already measures:

```
Separated G 5 u v                     -- a virtual edge in a finite gadget  [what the meter reports]
  →  Separated.comap                  -- forced apart at ONE plane pair
  →  forced_pair_of_forced            -- forced apart at EVERY pair of that distance   (D4)
  →  not_colorable_five_of_forced     -- ¬ (unitDistance ℂ).Colorable 5                (D1)
  →  six_le_chromaticNumber_plane     -- χ(ℝ²) ≥ 6
```

**(iv) A live error in the existing module, found by reading it.** The docstring of
`compels_rainbow_of_neighbors` (`Arity.lean:284`) claims *"Every object it holds has minimum degree
well above its colour count."* **False** — de Grey's 1581 has minimum degree **4** against `k = 5`.
The theorem needs SOME vertex with `k` distinct neighbours (its maximum degree is 60), not every
vertex. This is the same false gloss corrected in four other files on 2026-08-13; this instance
survived because it is inside a proof-carrying module rather than a plan. Fixed as part of §6.1.

### §5b. The skeleton

**In `Proofs/HadwigerNelson/Arity.lean`** (extending M45's module; it has no dependents but
`AritySpec`, so editing it is cheap):

```lean
/-- Realizability is *reflected* by any homomorphism: pull the colouring back. -/
theorem Realizes.comap {W : Type*} {G' : SimpleGraph W} (f : G →g G')
    (h : Realizes G' k (f ∘ S) p) : Realizes G k S p := sorry

/-- Local properness is *preserved* by an embedding — injectivity and adjacency reflection. -/
theorem PartialColoring.map {W : Type*} {G' : SimpleGraph W} (f : G ↪g G')
    (h : PartialColoring G S p) : PartialColoring G' (f ∘ S) p := sorry

/-- A compulsion transports up an embedding: more material, same compulsion. -/
theorem Compels.map {W : Type*} {G' : SimpleGraph W} (f : G ↪g G')
    (h : Compels G k S p) : Compels G' k (f ∘ S) p := sorry

/-- **The ladder theorem.** Growing a graph can only lower its arity floor. -/
theorem arityFloor_le_of_embedding {W : Type*} {G' : SimpleGraph W} (f : G ↪g G') :
    arityFloor G' k ≤ arityFloor G k := sorry
```

**In `Proofs/HadwigerNelson/Fan.lean`** (the missing twin of `Forces.comap`; Fan.lean has
dependents, so this is one added declaration and its rebuild is priced):

```lean
/-- **A virtual edge speaks about every graph its gadget maps into** — the exact dual of
`Forces.comap`, and the step Act Two of the 6-programme travels. -/
theorem Separated.comap {p q : V} (h : Separated G k p q) {W : Type*} {H : SimpleGraph W}
    (φ : G →g H) (C : H.Coloring (Fin k)) : C (φ p) ≠ C (φ q) := sorry
```

**In a new `Proofs/HadwigerNelson/Homogeneous.lean`:**

```lean
/-- **The plane's isometry group is transitive on ordered pairs at a given distance.** -/
theorem exists_isometry_map_pair {x₀ y₀ x y : ℂ} (hne : x₀ ≠ y₀) (h : dist x y = dist x₀ y₀) :
    ∃ g : ℂ → ℂ, Isometry g ∧ g x₀ = x ∧ g y₀ = y := sorry

/-- **One forced pair is all of them.** No side condition: at zero distance the hypothesis
refutes itself. -/
theorem forced_pair_of_forced {α : Type*} {x₀ y₀ x y : ℂ}
    (h : ∀ C : (unitDistance ℂ).Coloring α, C x₀ ≠ C y₀) (hd : dist x y = dist x₀ y₀)
    (C : (unitDistance ℂ).Coloring α) : C x ≠ C y := sorry
```

**In `Proofs/HadwigerNelson/Instances/HexShell.lean`** (D1, the target's exact shape):

```lean
/-- **The 6-forcer's exact requirement.** Virtual edges at BOTH √3 and 2 close the problem;
`hexShell_plane5` is disjunctive, so either class alone does not. -/
theorem not_colorable_five_of_forced
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    ¬ (unitDistance ℂ).Colorable 5 := sorry

/-- The headline form, matching `add_one_le_chromaticNumber_unitDistance`'s idiom. -/
theorem six_le_chromaticNumber_of_forced (h3 …) (h2 …) :
    6 ≤ (unitDistance ℂ).chromaticNumber := sorry
```

### §5c. The spec obligations, including the adversary the seam pass produced

* **A model of the hypotheses**, so the ladder theorem is not vacuously about nothing: the M45
  5-vertex model embedded in itself-plus-an-isolated-vertex, floor still 3; and an embedding into a
  graph with an added edge where the floor genuinely **drops**, so the inequality is seen to be
  strict somewhere and is not secretly an equality.
* **The adversarial member for D1, and it is a THEOREM rather than a guard.** The seam pass asked
  whether `h3` alone could prove the conclusion. It cannot, and the reason is exhibitable: the shell
  carrier has a proper 5-colouring **whose only monochromatic pairs are diameters** — centre `3`,
  ring `0,1,2,0,1,2`, which separates all six √3 pairs while `r₀ = r₃`. Symmetrically it has one
  whose only mono pairs are √3 pairs — ring `0,1,2,3,0,1`. Both are `decide`-able:

  ```lean
  example : ∃ C : (edgeGraph 7 hexShellEdges).Coloring (Fin 5), ¬ MonoPair hexShellP3 C
  example : ∃ C : (edgeGraph 7 hexShellEdges).Coloring (Fin 5), ¬ MonoPair hexShellP4 C
  ```

  Together they say **neither distance class is forced on its own** — the sharpest possible
  statement of the D1 correction, and a pair of reds that would fire if the composition were ever
  weakened to one class.
* **The degenerate member for homogeneity**: `x₀ = y₀`, where the hypothesis is self-refuting —
  checked as an `example` so the no-side-condition design is exercised rather than assumed.

### §5d. The obligation-modeling pass (2026-08-14) — the layer is proved, and where it homes

**Every statement in §5b elaborates, and each proof is one to four lines.** They were written
against the goal state, not guessed: the whole layer landed on the first attempt bar two mechanical
slips in the isometry construction. That is the convergence signal — the proofs are transcriptions,
so the statements are right — and it means §6.1 is implementation rather than research.

**The citations, taken from the tool rather than from memory:**

| need | citation | note |
|---|---|---|
| pull a colouring back along a hom | `SimpleGraph.Coloring.comap : G'.Coloring α → (G →g G') → G.Coloring α` | **already generic in the colour type `α`** — so the arbitrary-`α` statement of `forced_pair_of_forced` is *free* and specializes at the composition site with no cast |
| an embedding reflects adjacency | `SimpleGraph.Embedding.map_adj_iff : G'.Adj (f v) (f w) ↔ G.Adj v w` | |
| an embedding is injective | `RelEmbedding.injective` | `↪g` is a `RelEmbedding`, so it is inherited |
| lower-bound a bounded infimum | `le_iInf₂` | **no trap** — M45's wrong-shape `iInf₂_le` has no dual problem here; confirmed by `exact?` |
| build / use an isometry | `Isometry.of_dist_eq`, `Isometry.dist_eq` | both are aliases of `isometry_iff_dist_eq`; a *bare* map, no equivalence needed |
| the last algebraic step | `div_mul_cancel₀` then `linear_combination` | see below |

**The two slips, and what they teach.** `sub_ne_zero.mpr (Ne.symm hne).symm` symmetrises twice back
to where it started — read the goal, not the name. And `field_simp; ring` could **not** close
`a * (y₀ − x₀) + x = y`; the honest move is to *name the key equation*
(`have hkey : a * (y₀ − x₀) = y − x := div_mul_cancel₀ _ hsub`) and finish with
`linear_combination hkey`. That is the "tactic block in place of a localized obligation" smell in
miniature, and naming the step fixed it immediately.

**The homing decision, decided by measurement rather than taste.** `Separated.comap` belongs by
*content* next to `Separated` in `Fan.lean`. But `Fan.lean` has **45 transitive dependents**,
including the heavy certificate modules, and a new *declaration* there rebuilds every one of them —
the M07 lesson that cost 28 hours of processor time. `Arity.lean` has **1**, and it already houses
`Separated.compels` and `Forces.compels` under a docstring saying that dot-notation lemmas on those
notions live here. **Content and cost agree: `Separated.comap` goes in `Arity.lean`,** with a `--`
comment in `Fan.lean` pointing at it — a `--` comment leaves the `.olean` byte-identical and so
costs no rebuild at all.

**The mutation audit, run and green.** Dropping `h2` leaves the diameter branch of
`hexShell_plane5` genuinely unreachable — so the D1 correction is load-bearing and not decoration.
Dropping `hne` from the isometry construction leaves no route, as it must (`x₀ = y₀ ≠ x = y` is a
counterexample: no map sends one point to two). Weakening `Compels.map`'s embedding to a bare
homomorphism leaves exactly the two obligations the domain pass predicted — injectivity of `f ∘ S`
and the lifting of non-adjacency — neither available from a hom. Every hypothesis is used.

### §5e. The experience-modeling pass (2026-08-14) — one lemma added, from the caller's seat

**The four-link chain fails the API-only test, and the fix is not the twelve-argument theorem.**
Written out as a stranger would have to write it, the bare chain costs four names in the right order
*plus* an inner `fun C' =>` lambda *plus* a `hxy.trans hd.symm` distance massage, **per distance
class** — and every caller writes the identical composition. That is the "every use site opens with
the same preamble" smell, whose remedy is neither a bigger theorem nor a longer chain but **naming
the repetition once**:

```lean
/-- **A gadget's virtual edge, transported to the whole plane.** -/
theorem Separated.plane {ι : Type*} {G : SimpleGraph ι} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι} {d : ℝ}
    (hd : dist (q u) (q v) = d) (hs : Separated G k u v)
    (C : (unitDistance ℂ).Coloring (Fin k)) {x y : ℂ} (hxy : dist x y = d) : C x ≠ C y
```

Both versions were elaborated and compared. The caller's whole proof becomes **two names, two
lines**:

```lean
example : 6 ≤ (unitDistance ℂ).chromaticNumber :=
  six_le_chromaticNumber_plane_of_forced_pairs
    (fun C _ _ h => Separated.plane q₃ hq₃ hd₃ hs₃ C h)
    (fun C _ _ h => Separated.plane q₂ hq₂ hd₂ hs₂ C h)
```

This does **not** re-raise the twelve-argument design the domain pass rejected: it takes six
arguments, handles *one* distance class, is called twice, and it *uses* `Separated.comap` rather
than duplicating it — which stays the general dual of `Forces.comap`. The `_plane` suffix is the
file's own established convention for "the plane corollary of" (`hexShell_pigeonhole` →
`hexShell_plane`), so the name is predicted rather than learned.

**Automation probe, run:** `exact?` reaches `Separated.comap` from the goal `C (φ u) ≠ C (φ v)` and
returns `exact Separated.comap h φ C`, exactly as it reaches the established `Forces.comap` from its
own goal. The naming convention holds and the search finds it; the calibration control (the existing
twin) was run in the same file so a miss would have been attributable.

**The direction of `arityFloor_le_of_embedding` is a real hazard and gets three defences**, because
`arityFloor G' k ≤ arityFloor G k` for `f : G ↪g G'` puts the *bigger* graph on the *left* and a
reader will write it backwards: (i) the docstring leads with the direction in words — *growing a
graph can only lower its floor* — before any symbols; (ii) a spec example where the inequality is
**strict**, so the reader sees it do work rather than suspecting a disguised equality; (iii) a
cross-reference to `Realizes.comap`, whose direction is the intuitive one (*realizable on the bigger
object implies realizable on the smaller*) and which anchors the other.

**Free pointers, costing no rebuild:** a `--` comment beside `Separated` in `Fan.lean` and beside
`Forces.comap` in `Forcer.lean` naming where the dual lives. `--` comments leave the `.olean`
byte-identical, so a reader standing at either notion learns of the other for zero build cost —
which is the only reason the 45-dependent module can be annotated at all.

---

## §5f. The instrument surface

**The screen introduces a state this repository has never had, and it must not be able to reach an
artifact.** Every earlier meter *solved* every question it asked, so every row had an outcome. The
mask screen does not: it produces *"never observed in `H` colourings, not yet given to a solver"*.
That is neither a finding nor a negative, and left unnamed it is exactly the kind of thing a summary
sentence turns into a grokking. Four structural defences:

1. **It is a distinct Python type, not a dict.** `Candidate` is a `NamedTuple` — rows are dicts, and
   a `Candidate` cannot be serialized into a rows list without an explicit `confirm()` call.
2. **It has no `verdict` and no `outcome` field**, and `arity_verdict` is never called on one.
3. **It carries its own denominator**, `harvest`: a candidate surviving 64 colourings is noise and
   one surviving 8,192 is interesting, so "never observed" is *never* readable without the number
   that qualifies it. This is the G21 rule applied at row level rather than at summary level.
4. **`record()` raises on one** — *"a screen candidate is not a result; call confirm() first"* — and
   the artifact's screen section is keyed **`unsolved_candidates`**, a name with no reading in which
   it is a finding.

**The fourth misreading — an arity-3 hit read as a rung toward χ(ℝ²) ≥ 6 — is blocked by inverting
the marking.** Rather than warning on the many rows that are *not* rungs, exactly one computed
boolean marks the few that could be: `jackpot_eligible`, `True` only when arity = 2 **and** the
pattern is the same-colour pattern **and** the class is √3 or distance 2 **and** `k = 5` **and** the
stage is a genuine unit-distance graph. It is computed in one place beside `arity_verdict`. A reader
asking "is this the big one?" then has a single field to read, true only where it can be true — and
the halt-and-verify clause of §8 becomes mechanically checkable rather than a matter of judgement.

**The negative headline is generated, not written**, and `record()` refuses a summary lacking one:

> `arity-3, all patterns: 0 compulsions in 657,385,070 questions on stage degrey-1581`
> `(1,581 vertices, 7,877 edges, fingerprint 76b8163b27fe6f96); N undecided at cap 60 s and`
> `EXCLUDED from that count; screened against 8,192 harvested colourings.`

**What the artifacts must carry so a reader who trusts nothing can recompute every denominator:**
the stage's `n`, `m_edges`, `fingerprint` **and how its edge list was derived** (the construction,
not only the totals); the enumeration rule in prose *and* as a formula *and* as the computed count,
so `C(1581,3) = 657,385,070` is checkable rather than quoted; the harvest's size, seed range and pin
count, so the pool is reproducible; each class population beside the control that validates it (the
7,877); the cap and the undecided count; and the machine name. `build/m48-arity.json` carries the
sweep axis and `build/m48-ladder.json` the object axis — never merged, because they have different
denominators.

---

## §6. The phases, in order

**§6.0 — registration.** This file, committed before any campaign instrument runs.

**§6.1 — the kernel layer of §5**, with its spec examples and the gate. Lands first: D3 is what the
ladder phase's reading rests on, and a measurement whose interpretation is not yet a theorem is how
G28 happened.

**§6.2 — the census.** Per object, exact populations of every class the campaign asks about, with
the unit-edge control on each. These are the denominators every negative is reported against.

**§6.3 — Phase A: the COMPLETE arity-3 sweep on the 1581 at `k = 5`.**
1. vacuity guard;
2. arity-2 reproduction control over all 1,248,990 pairs (P1);
3. harvest to `H` a multiple of 64, growing until the candidate set is affordable, recording the
   decay curve — the curve is itself reportable and is the evidence that the screen terminated;
4. mask screen over all 657,385,070 triples × 5 patterns, with the local-properness filter applied
   per pattern;
5. observe-then-confirm on the survivors, feeding each solved colouring back into the pool;
6. for every compulsion: the complete 2-subset sweep on the **same stage** before any `minimal_arity`
   claim, then a second and third encoding.

**§6.4 — Phase A2: the COMPLETE neighbourhood arity-4 sweep** — all 1,718,839 4-subsets of vertex
neighbourhoods × 15 patterns, same pipeline. This is the D4 mechanism's own home and it brackets the
floor from the side the general sweep cannot reach.

**§6.5 — Phase B: the ladder.**
1. build gen-1, with the 7,877-edge control;
2. re-ask the 1581's **own** questions on the enriched stage — the same vertex pairs and triples,
   more material. By D3 the floor can only drop, so this is a dial with a theorem behind it (P5);
3. sweep gen-1's own target classes: 52,616 pairs at √3 and 20,640 at distance 2 (P4);
4. gen-2 only if 1–3 finish early, and reported with its bound stated.

**§6.6 — controls, every one seen to fail before its results are believed.**
* the vacuity guard on every stage before any compulsion claim;
* a **planted virtual edge** (add an edge between a free pair, confirm the meter fires) and a
  **planted innocent pair**;
* the M45 near-miss control: an arity-3 reading whose sub-pair explains it is **not** a find;
* the mask screen cross-checked against direct recomputation on a random sample at every `H` used;
* the arity-2 reproduction of `build/m30-rigidity-1581-k5.json` (P1) — if this disagrees, halt.

**§6.7 — the verdict, written either way, with the enumeration in the headline.**

---

## §7. Instruments

* **`tools/arity.py`** (M45) — the arity meter. `realize(stage, k, tup, blocks, cap, enc)` with
  `enc ∈ {free-fwd, free-rev, pinned}` three *sound* encodings that `Arity.realizes_iff_extends`
  proves ask the same question; `partitions(m, k)`; `arity_verdict`, the **one** place a verdict is
  computed, which structurally refuses to produce one without the evidence that would qualify it.
  **`python3 tools/arity.py --self-test` must be green before anything runs.**
  *M48 adds:* the mask screen (`agreement_masks`, `screen3`, `screen_neighbourhoods`) and the
  observe-then-confirm loop, each with its own planted control.
* **`tools/m48.py`** — the campaign driver, writing **`build/m48-arity.json`** (the sweep axis) and
  **`build/m48-ladder.json`** (the object axis). *M45 ran its campaign from scratch scripts and left
  no artifact under `build/`; that is not repeated.*
* **`tools/rigidity.py`** — the arity-2 lattice whose observe-then-confirm design this generalizes.
* **`tools/closure.py`** — the closure generations, quadrature law enforced at find time.
* **`tools/anatomy.py`** — `build_addresses()`, the committed 1581 with its 7,877-edge control.
* **The symmetry-breaking fact that makes any of this affordable:** pinning a pattern *without naming
  colours* keeps the query palette-invariant, which makes first-occurrence palette-symmetry breaking
  sound on top of it — worth >8,000× at six colours. **Re-measure at five; do not assume it.**

---

## §8. Discipline and failure clauses

* `unknown at cap` is **never** a verdict. Record it as undecided with its cap, exclude it from every
  summary, and *say so in the summary*.
* Every claim double-encoded or theorem-closed.
* Every meter run on a planted positive **and** a planted negative before its results are believed.
* An arity-`m` reading is **not** an arity-`m` finding until every lower-arity sub-tuple has been
  swept on the *same stage* and found free.
* Rows from different stages are about different graphs; `stage.fingerprint` makes "same object?" a
  comparison rather than a judgement.
* **Every negative carries its enumeration in the headline sentence.**

**HALT AND VERIFY.** Per **D2** an arity-3 or arity-4 compulsion is *not* a jackpot and does not fire
this clause. The clause fires on one thing: **a pair at √3 or 2 compelled apart at five colours on a
genuine unit-distance graph — that is χ(ℝ²) ≥ 6.** Stop. Then, in order: (1) confirm the stage is
5-colourable, or the reading is vacuous; (2) re-derive the object's vertices and edges independently,
from the construction rather than from a stored file — the M06-era `degrey_graph.json` and the
standing loader use **different vertex orders**, which once explained a wrong verdict; (3) confirm
the two points are at distance exactly √3 or exactly 2 in **exact field arithmetic**, never floating
point; (4) re-run in all three encodings with generous caps; (5) confirm the pair is realizable as
*distinct*, or the reading is degenerate; (6) report to Kooshi **before** attempting kernel
promotion. Only then the composition, priced as an M06-scale certificate effort before anything is
promised.

---

## §9. Practical notes

* **Machines.** Desktop (32 cores, 125 GB) and laptop (12 cores, 31 GB). This
  wants the desktop. Record CPU seconds, minimum of three runs, with the machine named.
* **Building Lean.** *Always* `./scripts/build.sh`, never `lake build` — bare **or named**.
  `lake env lean <file>` is fine for iterating on one file but does **not** apply the project's
  options, so never conclude a module is green from it.
* **On any crash, from any process: HALT and report to the user immediately.** It is hardware.
* **`pkill -f <pattern>` kills your own shell.** Use a bracketed regex (`pgrep -f "m4[8]\.py"`).
* **One heavy job at a time.**
* **Artifacts.** One JSON per axis, schema-tagged, with the reading rule *in the schema string* and
  the bound direction *in the field name*.

---

## §R. Results

*Written at the close, 2026-08-14. Desktop (32 cores, 125 GB) throughout. Every number
below is on disk at the address given; every negative carries its enumeration in its own sentence,
per §0c.*

### §R0. The one-line verdict

**`arityFloor(1581, k = 5) ∈ {4, 5}` exactly, and every arity-5 compulsion that
`arityFloor_le_of_degree` constructs on it is 1-minimal.** The floor is real — a theorem guarantees
*something* is compelled at arity ≤ 5 — and three complete sweeps now say it is not at 2, not at 3,
and not at 4 inside a vertex neighbourhood. Nobody had asked; the answer is a complete determination
up to one step. On fifteen times the material it is the same answer, and by the ladder theorem that
is an inequality measured tight rather than an absence.

**What it means, and it is a closed door rather than an open one.** The compulsion structure of a
certified 5-chromatic witness, at its own top rung, is *exactly the trivial one* — the fan a vertex's
degree forces, and nothing beneath it. There is no small forced pattern hiding in de Grey's graph
waiting to be extracted as a χ ≥ 6 gadget. G9's pairwise floppiness was not a peculiarity of arity
2; it runs all the way up to the arity at which a counting argument compels structure to exist. So
the gadget must be **constructed**, not **found**, and the ranked paths in `CLAUDE.md` now put
construction first for the first time (grokking **G31**).

### §R1. The kernel layer (§6.1) — landed, and it corrected the record

Three things, on axioms exactly `[propext, Classical.choice, Quot.sound]`, gate green (build OK,
zero `sorry`, 511 declarations audited clean plus the five declared `native_decide` purchases,
`lake lint` silent, spec examples passing).

**The ladder theorem** (`Arity.lean` §Transport). `arityFloor_le_of_embedding : (f : G ↪g G') →
arityFloor G' k ≤ arityFloor G k` — the **bigger** graph on the **left**, which is the one thing
about it a reader can get backwards, so `AritySpec` exercises both directions: a compulsion
surviving into more material, and a case where the inequality is strict (a triangle compels nothing
at three colours, floor `⊤`, while the `K₄` containing it is not 3-colourable at all, floor `0`).
Carried by three transport lemmas that turned out to want three different hypotheses —
`Realizes.comap` needs only a homomorphism, `PartialColoring.map` and `Compels.map` need the
embedding's *reflection* of adjacency — which is exactly what makes the induced-subgraph hypothesis
load-bearing rather than decorative.

**The plane's homogeneity** (`Homogeneous.lean`). `exists_isometry_map_pair` builds `z ↦ az + b`
with `a = (y − x)/(y₀ − x₀)`, and `forced_pair_of_forced` / `Separated.plane` turn one forced pair
at a distance into *every* pair at that distance. No `x₀ ≠ y₀` side condition: at zero distance the
hypothesis refutes itself, and `AritySpec` exercises that degenerate branch rather than trusting it.
This is the lemma any future gadget crosses on its way from a finite graph to the plane.

**The correction to this project's own record** (`Instances/HexShell.lean`). The Frontier had
carried, since 2026-08-14, the reading that χ(ℝ²) ≥ 6 needs "one gadget at √3 **or** 2". It is now
a theorem that this is too weak: `hexShellPairs` is six √3-pairs *plus* three diameters and
`hexShell_plane5` is disjunctive over both, so `six_le_chromaticNumber_plane_of_forced_pairs`
demands a virtual edge at √3 **and** one at distance 2. Proved from both sides — two explicit proper
5-colourings of the seven-point carrier, one separating all six √3-pairs, one separating all three
diameters — so *neither class alone is forced*, and the conjunction is not an artifact of how the
statement was phrased. Either half alone would still be a major result and would halve the problem.

### §R2. Phase A — the complete arity-3 sweep (§6.3)

`build/m48-arity.json`, phase `arity3-complete`. Stage: de Grey's 1581, fingerprint
`76b8163b27fe6f96`, 7,877 unit edges re-derived by exact field arithmetic.

| ask | enumeration | result |
|---|---|---|
| arity 2 (the P1 reproduction control) | all **1,248,990** pairs, both patterns | **0 candidates** — every pair observed *both* ways in 4,096 harvested colourings, so there was nothing even to confirm |
| **arity 3, complete** | **657,385,070** triples × 5 patterns = **3,286,925,350** questions | **0 compelled, 0 undecided at cap** |

Decay curve, which is the evidence the screen terminated rather than an aside: 1,023,629 candidates
out of 3.29 billion questions survived the mask screen (46 s); fresh colourings cut that to **279**;
263 were handed to a solver and every one came back satisfiable. 904.7 s end to end.

**P1 met** (prior 95 %). **P2 met** (prior 70 % zero).

### §R3. Phase A2 — the complete neighbourhood arity-4 sweep (§6.4)

`build/m48-arity.json`, phase `arity4-neighbourhoods`. **0 compulsions in 25,782,585 questions** —
1,718,839 deduplicated 4-subsets of vertex neighbourhoods × 15 patterns, 659 solved, 0 undecided,
691.9 s. Explicitly **not** covered, and named in the artifact: general 4-subsets, `C(1581,4) =
259,338,410,115`, priced in §4d and out of scope.

**P3 met** (prior 60 % zero).

**The corollary that was not registered and is the better half of this phase.** Every arity-5
compulsion `arityFloor_le_of_degree` constructs sits on five distinct neighbours of one vertex, and
every 4-subset of a vertex neighbourhood has now been swept clean at all fifteen patterns.
Deleting any single vertex from such a compulsion therefore leaves a *realizable* pattern — so those
compulsions are **1-minimal**. That is M45's designed-but-unrun fan-shrink bracket, delivered as a
consequence of a sweep that was aimed elsewhere.

### §R4. Phase B — the ladder (§6.5)

`build/m48-ladder.json`, phase `ladder-gen1`. Stage: the gen-1 half-spindle closure, **24,065
vertices, 123,134 unit chords**, fingerprint `06ac45c2842a4978`, built by
`closure.close_gen(1581, both spindle centres, GEN1_GENS)`. Two controls before any reading: the
123,134-chord count reproduces M31's, and **the 1581's induced edge count inside the closure is
exactly 7,877** — which is not bookkeeping but the *hypothesis of the ladder theorem*, since
`↪g` demands adjacency be reflected as well as preserved. Vacuity guard `sat`, so nothing below is
vacuous.

| ask | enumeration | result |
|---|---|---|
| gen-1's own target classes (P4) | all **73,256** pairs — 52,616 at exactly √3, 20,640 at exactly 2, by exact field arithmetic | **0 candidates**, hence 0 compelled, 0 undecided. Every one of those pairs was observed sharing a colour in the harvested pool, so the meter never even reached a solver. |
| **the ladder proper** (P5) | the witness's **own** 657,385,070 triples × 5 patterns = **3,286,925,350** questions, re-asked on the 24,065-vertex stage | **0 compelled, 0 undecided at cap 300 s** |

Decay on the ladder ask: 3,066,206 candidates survived the mask screen (14 s), then five rounds of
fresh colourings cut it **3,066,206 → 129,244 → 18,588 → 3,986 → 1,072 → 384**, and all 384 went to
a solver — 332 solved directly, the rest killed by models found along the way. 5,257.6 s end to end
on 28 workers, 11,264 colourings drawn.

**P4 met** (prior 85 % zero). **P5 met** (prior 80 % flat).

**What the flatness means here, precisely.** `arityFloor_le_of_embedding` says the floor can only
**drop** along this embedding — so a flat reading is not "nothing happened", it is *an inequality
measured tight at arity 3*. Fifteen times the material, drawn from the same half-spindle group that
generates the witness, compels nothing on the witness's own triples that the witness did not already
compel. That is the fifth independent measurement of G10's irreducible globality and the first at
arity 3.

**Reproducibility, unplanned but worth recording.** This phase ran twice — once before the machine's
hardware fault and once after a reboot — and the two runs agree exactly where they overlap: 6.05 vs
6.04 CPU-seconds per harvested colouring, the same 3,066,206 screen survivors, the same
3,066,206 → 129,244 first filter, and the same 0 candidates over 73,256 target-class pairs. The
second and third filter rounds differ by four candidates (18,592 vs 18,588), which is the SAT
solver's own nondeterminism under a wall-clock cap and cannot change a verdict: the filter only
decides what gets *solved*, never what gets *concluded*.

### §R5. The engine, because the enumeration is the milestone

3.29 billion questions is five orders of magnitude past any from-below sweep this project had run,
and it is a 46-second bit operation for one reason: **pair colour-agreement masks.** `M[u, v]` is
the bitmask of harvested colourings in which `u` and `v` share a colour, and *every* arity-`m`
pattern's observed set is a boolean combination of the `C(m,2)` masks on its tuple — so "was this
pattern ever worn?" is an AND of three 4,096-bit words, not a scan. On top of that,
**observe-then-confirm**: one harvested colouring exhibits a realized pattern for every tuple in the
graph simultaneously, so a solver is needed only for patterns nothing wore, and every satisfying
model found during confirmation goes back into the pool and kills more candidates.

### §R6. Instrument findings, including two that would have manufactured a false negative

* **`harvest` re-seeded from zero on every call.** The "filter against fresh colourings" stage was
  re-testing the *same* colourings and killed exactly nothing (1,023,629 → 1,023,629), and the
  loop's `if before == len(cands): break` then abandoned the rest — a false negative produced
  entirely by the instrument. With genuinely fresh seeds the same filter cuts 1,023,629 → **279**.
  `seed0` is now a parameter and its docstring says why it exists.
* **The planted norm-constant assertion fired for real**, in the direction not expected: the closure
  builder returns coordinate lists where the witness builder returns tuples, and a tuple norm
  constant compares unequal to every norm forever. Left alone it would have reported the √3 and
  distance-2 classes **empty** while the unit-edge control still passed.
* `locally_proper` rebuilt a 7,877-element adjacency set per call — invisible at pair scale, the
  entire runtime at 25.8 million pattern checks.
* Python 3.14 defaults to the `forkserver` start method, which surfaces as a `ConnectionResetError`
  that reads like a machine fault rather than a configuration one.

### §R7. Crash resumption, added mid-milestone and controlled

Phase B was interrupted by the machine's intermittent hardware fault (three unexplained
process deaths — two in the SAT solver, one in Python — reported to Kooshi, not worked past,
machine rebooted). Two mechanisms
were added so a multi-hour phase survives the next one: a **colouring pool cache** keyed by stage
fingerprint (harvesting dominates, measured at 6.05 CPU-seconds per colouring on the 24,065-vertex
stage) and a **solver checkpoint** holding the questions not yet asked alongside the answers already
obtained. Neither changes a question asked or an answer recorded. Both are controlled (P10, in
`tools/m48.py --self-test`): the control run is on the five-vertex graph whose arity-3 compulsion is
a *kernel theorem*, so the expected answer is not the instrument's own opinion; a mid-run crash is
planted and the resumed run is checked to report the identical compulsions and to ask each question
exactly once; and a checkpoint carrying a foreign stage fingerprint is refused.

### §R8. Scoring the registered predictions

| # | prior | outcome | measurement |
|---|---|---|---|
| **P1** | 95 % | **MET** | 0 candidates over all 1,248,990 pairs; every pair observed both ways, reproducing `build/m30-rigidity-1581-k5.json` |
| **P2** | 70 % zero | **MET** | 0 compulsions in 3,286,925,350 questions, 0 undecided |
| **P3** | 60 % zero | **MET** | 0 compulsions in 25,782,585 questions, 0 undecided |
| **P4** | 85 % zero | **MET**, twice | 0 candidates over 73,256 target-class pairs, on two independent runs |
| **P5** | 80 % flat | **MET** | 0 compulsions when the witness's own 3,286,925,350 questions are re-asked on the 24,065-vertex closure |
| **P6** first half | 70 % | **MET** | 6.04 CPU-s per colouring on gen-1 against 0.31 on the 1581 — **19.5×**, against a registered ≥ 10× |
| **P6** second half | 70 % | **MISSED**, and the miss is *provably* not about the objects | witness pool leaves **20,220,080** never observed at `H = 1024`; the closure's, restricted to the same vertices, leaves **3,066,206** — 6.6× *fewer*, the opposite of the prediction |

**P6's second half is the interesting row, and its registered gloss was wrong a priori.** The
registration said a *lower* closure fraction "would be the first sign the closure does something
structural." It cannot be. The 1581 is an **induced** subgraph of gen-1 — checked, 7,877 edges
reproduced — so every proper colouring of gen-1, restricted to the witness's vertices, *is* a proper
colouring of the witness. The closure's achievable pattern set on those vertices is therefore a
**subset** of the witness's own, and can never be larger. Yet the closure's pool of 1,024 colourings
exhibits some 17 million triple-patterns that the witness's own pool of 1,024 never wore — every one
of them achievable on the witness, by that same restriction. **So the gap is a measurement of the
sampler, not of either object**: harvesting on the witness alone, CaDiCaL lands in a narrower region
of a space it is demonstrably able to reach.

This is the M19 lesson again — *pool statistics measure the SAT solver's tastes, not the colouring
space* — arriving in a milestone that had registered a structural reading for it in advance. Nothing
downstream depends on it: the pool is a *screen*, and everything it fails to kill is handed to a
solver, so a narrow sampler costs solver calls and can never produce a false compulsion. The one
practical question it raises is answered against itself: the closure's colourings are ~6.6× more
informative each but cost 19.5× more, so restricting a bigger object's colourings is a **worse**
sampler per CPU-second, not a better one, and the instrument is left as it is.

Recorded in `build/m48-ladder.json`, phase `decay-comparison`, reproducible as
`python3 tools/m48.py --decay 1024`. Its headline names the pool as the subject, and its `caveat`
field states the sampler confound in the artifact rather than only here.

### §R9. What this licenses, and what it does not

Exactly as written in §0c before any instrument ran. **Licensed:** `arityFloor(1581, k = 5) ∈
{4, 5}`, and the 1-minimality corollary of §R3. **Not licensed:** anything about the plane, any
other object, arity 4 outside vertex neighbourhoods, or whether a virtual edge at √3 or 2 exists
anywhere. The HALT AND VERIFY clause did not fire, because nothing it watches for occurred.
