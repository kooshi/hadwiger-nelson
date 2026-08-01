# M10 — Fractional bounds

*Opened 2026-08-01. Subplan for the milestone whose roadmap entry reads: "**Fractional bounds.**
Fractional chromatic number machinery; the 383/102 record as a certified statement."*

**That entry is wrong on both halves of its target, and § 0(g) is the measurement that says so.**
383/102 is not the record and its data is not public. What this milestone certifies instead is
**χ_f(ℝ²) ≥ 65/18 ≈ 3.6111**, from a 63-vertex unit-distance graph re-derived from Fisher and
Ullman's construction — better than every *finite-graph* bound in Cranston and Rabern's 2015 paper
(their best was 1732/481 ≈ 3.6008, from a linear program with over 25,000 constraints), just under
their headline 76/21 ≈ 3.6190 which is an argument about an infinite family, and reached with **no
new certificate format at all**.

---

## 0. Measurements — taken before anything was specified

Desktop (32 cores, 125 GB), 2026-08-01. CPU seconds are user + sys, minimum of three runs.

### (a) The graphs we already have are the wrong vehicle

The uniform dual gives `χ_f(G) ≥ |V| / α(G)` for every graph. Independent sets found by a
(2,1)-swap local search; `α(heule510) < 157` proved by the bundled `cadical` in 0.1 s through a
sequential-counter encoding.

| witness | n | m | independent set found | `n/α` at best |
|---|---|---|---|---|
| Moser spindle | 7 | 11 | 2 (α = 2, exact) | **3.5000** |
| Heule 510 | 510 | 2504 | 156 | 3.2692 |
| Heule 553 | 553 | 2722 | 177 | 3.1243 |
| de Grey | 1581 | 7877 | 510 | 3.1000 |

**Every 5-chromatic witness in this repository is worse for χ_f than the 7-vertex Moser spindle.**
They are optimised for χ, which is a different objective: big and sparse is good for
non-colourability and bad for the independence ratio. Nothing in `Instances/` is the vehicle for
this milestone.

### (b) The kernel's cost per independent set

`decide +kernel` over an enumeration of independent sets carried as `(bitmask, weight)` pairs.
`import Proofs` baseline: 2.28 CPU s. A 23-vertex core-and-spindle graph with **5,290** independent
sets: 4.67 CPU s total, **2.39 CPU s net** — **≈ 0.45 ms per enumerated set**. `Nat` bitwise
operations are free beside the recursion, exactly as M05's cost model predicts.

Consequences: an *unpruned* enumeration is affordable to about 10⁵–10⁶ sets, i.e. ~30 vertices at
this density. The graphs below have ≥ 10⁹ independent sets. **Pruning is not an optimisation here;
it is the difference between viable and dead.**

### (c) The witness, re-derived

Fisher and Ullman's construction as Cranston and Rabern describe it (arXiv 1501.01647 § 2), rebuilt
from the description rather than from coordinates:

* **core** — a trapezoidal patch of the unit triangular lattice, rows of 6, 5 and 4 points: 15
  vertices;
* a **diamond** is two core vertices at distance √3 together with their two common neighbours;
* to each of the 18 diamonds, attach a **Moser spindle**: rotate the diamond about its lower vertex
  by the angle with `cos θ = 5/6`, `sin θ = √11/6`, which is exactly the angle that brings the two
  far tips to distance 1, and keep the three new points;
* join **every** pair of the resulting 63 points at distance exactly 1 — 216 edges.

Everything is exact: coordinates live in ℚ(√3, √11), a subfield of the tower `Q4 = ℚ(√3,√5,√7,√11)`
the project already carries, and **scale to integers with common denominator 12** — the same
denominator the Moser spindle already uses. The 216 edges have only **9 distinct difference
vectors**, so M08's `DiffWitness` route certifies the geometry for the price of 9 squared lengths.

The same generator at the next core down (rows 5, 4, 3 — 12 core vertices, 13 spindles, 47 points,
151 edges) is the cheap sibling used as a spec instance; it too has denominator 12 and 9 distinct
differences.

### (d) What those witnesses certify

The dual LP (maximise total vertex weight subject to every independent set weighing at most 1) was
solved by constraint generation with an **exact** separation oracle — `cadical` asked, at each
round, whether any independent set exceeds the current bound, in a weighted sequential-counter
encoding. Optima, as exact rationals:

| core | points | edges | weights sum | bound `D` | certified | support |
|---|---|---|---|---|---|---|
| rows 5,4,3 | 47 | 151 | 68 | 19 | **68/19 ≈ 3.5789** | 37 |
| rows 6,5,4 | 63 | 216 | 260 | 72 | **260/72 = 65/18 ≈ 3.6111** | 53 |

Each is checked **two independent ways** that agree: `cadical` refutes "some independent set has
weight ≥ D+1", and a branch-and-bound finds the maximum weight to be exactly `D`. Zero-weight
vertices can be dropped without changing the maximum, so each witness may be trimmed to its support
with the bound intact.

| bound | source | vertices |
|---|---|---|
| 7/2 = 3.5 | Moser spindle, folklore | 7 |
| 32/9 ≈ 3.5556 | Fisher–Ullman 1992, the published record until 2015 | 57 |
| 168/47 ≈ 3.5744 | Cranston–Rabern 2015, bigger core | ~100 |
| 68/19 ≈ 3.5789 | this milestone's spec instance | 47 |
| 491/137 ≈ 3.5839 | Cranston–Rabern 2015, bigger core again | ~200 |
| 1732/481 ≈ 3.6008 | Cranston–Rabern 2015, **their best finite graph** — an LP with > 25,000 constraints | ~400 |
| **65/18 ≈ 3.6111** | **this milestone** | **63** |
| 76/21 ≈ 3.6190 | Cranston–Rabern 2015, discharging over an **infinite** family | ∞ |

The gain over Cranston and Rabern at a *fraction* of the size is not cleverness about graphs — it is
the exact separation oracle. They were bounded by having to enumerate maximal independent sets to
build the LP; asking a SAT solver "is any independent set too heavy?" needs no enumeration at all.

### (e) Vertex order is part of the certificate

Branch-and-bound over independent sets, pruning a subtree as soon as the weight already chosen plus
*all* the weight remaining cannot exceed `D`:

| witness | heaviest-weight-first order | certificate index order |
|---|---|---|
| 47 points, `D` = 19 | **38,128** nodes | 1,029,644 nodes |
| 63 points, `D` = 72 | **390,625** nodes | not measured |

**A 27× difference from the order alone**, against ≥ 10⁹ with no prune at all. At 0.45 ms per node
the headline is **~3 CPU minutes** and the spec instance ~17 CPU s — so the order is emitted *with*
the weights and is part of what the generator produces, not an implementation detail.

### (f) The prune is where a bug would hide

The prune skips a subtree on the grounds that nothing in it can exceed the bound. That is precisely
the shape of "a search that found what a bug allowed" — the failure mode `CLAUDE.md` names as
characteristic. Its soundness is therefore a proof obligation with a named negative control
(§ 4), not a comment.

### (g) The roadmap's target is stale, and its data is not public

| bound | who | form |
|---|---|---|
| 76/21 ≈ 3.6190 | Cranston–Rabern, *Combinatorica* 37 (2017) | discharging + an 8-tile lemma on the triangular lattice |
| 383/102 ≈ 3.7549 | Exoo–Ismailescu, *Geombinatorics* 26 (2017) | 73-vertex graph — **not open access, coordinates not published** |
| 3.8991 | Bellitto–Pêcher–Sédillot | measurable density, hundreds of vertices |
| 3.9898 | Parts | unpublished |
| **≥ 4** | Matolcsi–Ruzsa–Varga–Zsámboki, arXiv 2311.10069 (v2, 2025-03) | a **different invariant** (geometric fractional chromatic number) plus amenability of the plane's isometry group; 27-vertex graph |

Two conclusions. **383/102 is not the record**, so certifying it would not be certifying the state
of the art. And its 73-vertex graph is published in a journal that does not distribute data, so
"the witness must be independently re-derivable" (`CLAUDE.md`, the standard above rung B) cannot be
met for it. The current record needs measure theory and amenability — a project, not a milestone.

---

## 1. What this costs, what it buys, and what it abandons

**Costs.** One new graph-theory module with no data in it, one kernel-run search with a soundness
proof, one 63-vertex certificate through machinery that already exists (M08's geometry, M02's
tower), and a handful of spec instances. **No new CNF encoder, no new LRAT format, no new
certificate segment layout, no generated-module explosion.** The heaviest single kernel step is
projected at ~3 CPU minutes.

**Buys.**

1. **The fractional chromatic number, formalized.** Mathlib has `chromaticNumber` and has nothing
   fractional — no `FractionalColorable`, no `fractionalChromaticNumber`, in any file. This module
   is the durable contribution and it is independent of Hadwiger–Nelson.
2. **χ_f(ℝ²) ≥ 65/18**, kernel-checked, zero native purchases.
3. **A third, independent proof of χ(ℝ²) ≥ 4**, through χ_f ≤ χ — which is also the non-vacuity
   check on the whole fractional stack.
4. **A weighted-independence search** the hunt can reuse: `Gadget.survivors` scores a composition by
   how many port colourings survive; this scores a graph by how heavy an independent set it admits.

**Abandons, with the measurement that killed each.**

| abandoned | why |
|---|---|
| Certifying 383/102 | § 0(g): not the record, data not public, not re-derivable |
| Any existing witness as the vehicle | § 0(a): all three are worse than the 7-vertex spindle |
| Unpruned enumeration | § 0(b): ≥ 10⁹ independent sets at 47 vertices |
| A SAT/LRAT route for weighted independence | § 0(e): the pruned search is 390,625 nodes ≈ 3 CPU min, so a new CNF encoder plus a certificate format would be bought for nothing |
| A clique-cover certificate | **derived, not measured**: a unit-distance graph in the plane has no K₄, so every clique has ≤ 3 vertices and a clique-cover dual can never prove more than 3 |
| Cranston–Rabern's 76/21 | needs their 8-tile lemma about maximal independent sets in the triangular lattice — a substantial formalization on its own; § 6 |

---

## 2. The shape

```
χ_f(ℝ²) ≥ 65/18
   │
   └── χ_f is monotone under graph homomorphism, and the 63 points map into the plane
         │
         └── χ_f(G) ≥ (Σ_v w v) / D   for the 63-vertex graph G
               ├── geometry:  every listed edge is exactly 1 long        (M08 DiffWitness, 9 differences)
               └── weights:   every independent set weighs at most D=72  (kernel-run pruned search)
```

The middle step is one elementary double-counting argument and it is the heart of the milestone:

> Let `f` be a `b`-fold `n`-colouring. For each colour `c`, the set `S_c = {v : c ∈ f v}` is
> independent, so `Σ_{v ∈ S_c} w v ≤ D`. Summing over the `n` colours counts each vertex `|f v| ≥ b`
> times, so `b · Σ_v w v ≤ n · D`, i.e. `(Σ_v w v)/D ≤ n/b`.

No LP duality, no Farkas, no attainment of an infimum — just `Finset.sum_comm`.

---

## 3. Skeleton

### 3.1 `Proofs/HadwigerNelson/Fractional.lean` — the machinery, no data

```lean
/-- A `b`-fold `n`-colouring: each vertex gets at least `b` of the `n` colours, and adjacent
vertices share none. `b ≤ card` rather than `= card` because it is the weaker hypothesis, so the
theorems that consume it are stronger, and shrinking a colour set preserves everything. -/
def FractionalColorable (G : SimpleGraph V) (b n : ℕ) : Prop :=
  ∃ f : V → Finset (Fin n), (∀ v, b ≤ (f v).card) ∧ ∀ v w, G.Adj v w → Disjoint (f v) (f w)

/-- The fractional chromatic number: the infimum of `n/b` over `b`-fold `n`-colourings.
`ℝ≥0∞` and `⨅` for the same reason `SimpleGraph.chromaticNumber` is `ℕ∞` — a graph with no
fractional colouring at all gets `⊤` rather than a junk `0`. -/
noncomputable def fractionalChromaticNumber (G : SimpleGraph V) : ℝ≥0∞ :=
  ⨅ p ∈ {p : ℕ × ℕ | 0 < p.2 ∧ G.FractionalColorable p.2 p.1}, (p.1 : ℝ≥0∞) / (p.2 : ℝ≥0∞)

theorem le_fractionalChromaticNumber {r : ℝ≥0∞}
    (h : ∀ b n : ℕ, 0 < b → G.FractionalColorable b n → r * b ≤ n) :
    r ≤ G.fractionalChromaticNumber := sorry

theorem fractionalChromaticNumber_le {b n : ℕ} (hb : 0 < b) (h : G.FractionalColorable b n) :
    G.fractionalChromaticNumber ≤ (n : ℝ≥0∞) / b := sorry

/-- Pull a fractional colouring back along a homomorphism — the same shape as `Colorable.comp`. -/
theorem FractionalColorable.comp {H : SimpleGraph W} (φ : G →g H) {b n : ℕ}
    (h : H.FractionalColorable b n) : G.FractionalColorable b n := sorry

theorem fractionalChromaticNumber_mono_of_hom {H : SimpleGraph W} (φ : G →g H) :
    G.fractionalChromaticNumber ≤ H.fractionalChromaticNumber := sorry

/-- An ordinary colouring is a 1-fold colouring. The bridge that makes a fractional lower bound
a chromatic lower bound. -/
theorem fractionalChromaticNumber_le_chromaticNumber :
    G.fractionalChromaticNumber ≤ (G.chromaticNumber : ℝ≥0∞) := sorry

/-- **The certificate theorem.** Weights on the vertices, no independent set heavier than `D`,
and the ratio is a lower bound. One double-counting argument; this is the milestone's centre. -/
theorem le_fractionalChromaticNumber_of_weights [Fintype V] [DecidableEq V]
    (w : V → ℕ) (D : ℕ) (hD : 0 < D)
    (h : ∀ I : Finset V, G.IsIndepSet (I : Set V) → ∑ v ∈ I, w v ≤ D) :
    ((∑ v, w v : ℕ) : ℝ≥0∞) / D ≤ G.fractionalChromaticNumber := sorry

/-- The uniform case, `w ≡ 1`: `|V| / α`. What the Moser spindle uses. -/
theorem le_fractionalChromaticNumber_of_indepNum [Fintype V] [DecidableEq V] {a : ℕ} (ha : 0 < a)
    (h : ∀ I : Finset V, G.IsIndepSet (I : Set V) → I.card ≤ a) :
    ((Fintype.card V : ℕ) : ℝ≥0∞) / a ≤ G.fractionalChromaticNumber := sorry
```

### 3.2 `Proofs/HadwigerNelson/IndepSearch.lean` — the kernel-run bounded search

The vertices arrive **in the certificate's own order**, each carrying its own bit, its neighbour
mask, its weight, and the total weight of everything after it — so the prune is one comparison and
no list is re-traversed.

```lean
/-- One vertex of the search: `(selfBit, neighbourMask, weight, weightOfTheRest)`. -/
abbrev Slot := ℕ × ℕ × ℕ × ℕ

/-- `noHeavy D rest allowed wt` — every independent set that extends the current selection by
vertices drawn from `rest` and still `allowed` weighs at most `D`.

The first branch is the **prune**: if everything left cannot lift `wt` past `D`, the whole subtree
is safe and is not entered. It is what turns ≥ 10⁹ sets into 38,128 nodes, and its soundness is
`noHeavy_sound`'s only interesting case. -/
def noHeavy (D : ℕ) : List Slot → ℕ → ℕ → Bool
  | [], _, wt => wt ≤ D
  | (bit, nb, wv, restW) :: rest, allowed, wt =>
      if wt + wv + restW ≤ D then true
      else noHeavy D rest allowed wt &&
        (bit &&& allowed == 0 || noHeavy D rest (allowed &&& ~~~nb) (wt + wv))

/-- **Soundness.** A `true` answer means what it says, for every independent set. -/
theorem noHeavy_sound (D : ℕ) (slots : List Slot) (hwf : WellFormed n slots)
    (h : noHeavy D slots (allOnes n) 0 = true)
    (I : Finset (Fin n)) (hI : (edgeGraph n E).IsIndepSet (I : Set (Fin n))) :
    ∑ v ∈ I, w v ≤ D := sorry

/-- The certificate a generator emits, and the one `Bool` the kernel decides. -/
structure WeightCert (n : ℕ) where
  slots : List Slot
  bound : ℕ
  deriving Repr

def WeightCert.Check (c : WeightCert n) (E : List (Fin n × Fin n)) (w : Fin n → ℕ) : Bool := sorry
theorem WeightCert.sound : c.Check E w = true → ∀ I, IsIndepSet I → ∑ v ∈ I, w v ≤ c.bound := sorry
```

### 3.3 `Proofs/HadwigerNelson/Instances/CoreSpindle.lean` — the 63 vertices

Emitted by `tools/corespindle.py` (untrusted, like every generator here): the vertex table in the
`Q4` tower with denominator 12, the 216 edges, the 9 difference vectors for the M08 geometry route,
the 63 weights, the heaviest-first slot order, and `bound := 72`.

```lean
def coreSpindle : UDCert 63 := sorry
theorem coreSpindle_valid : coreSpindle.Valid = true := sorry      -- DiffWitness, 9 differences
def coreSpindleWeights : Fin 63 → ℕ := sorry
def coreSpindleCert : WeightCert 63 := sorry
theorem coreSpindle_noHeavy : coreSpindleCert.Check coreSpindle.edges coreSpindleWeights = true := by
  decide +kernel                                                    -- 390,625 nodes, ~3 CPU min
```

### 3.4 `Proofs/HadwigerNelson/Instances/CoreSpindle/Bound.lean` — the headline

```lean
/-- **χ_f(ℝ²) ≥ 65/18.** The plane's fractional chromatic number is at least 3.6111…, from 63
points whose pairwise unit distances are exact identities in ℚ(√3,√5,√7,√11) and 63 integer weights
no independent set can push past 72. -/
theorem fractionalChromaticNumber_plane_ge :
    (260 : ℝ≥0∞) / 72 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).fractionalChromaticNumber := sorry

/-- **χ(ℝ²) ≥ 4, a third time** — through the fractional bound alone, sharing no certificate with
either of M03's two routes. Also the non-vacuity check: a fractional bound that implied nothing
about χ would mean the definitions had drifted. -/
theorem four_le_chromaticNumber_plane_fractional :
    (4 : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := sorry
```

### 3.5 Spec — validated before any proof effort

| what | check | why this one |
|---|---|---|
| the definition is inhabited | a 1-fold 3-colouring of the triangle | a `∀` over an empty domain proves everything |
| the definition is **not** the ordinary chromatic number | `fractionalChromaticNumber (edgeGraph 5 C₅) = 5/2` — both directions: `≥` from `n/α = 5/2`, `≤` from an explicit 2-fold 5-colouring | **a non-integer value is the discriminating test.** If the definition had collapsed to `χ` this reads 3 |
| the certificate theorem fires end to end | the Moser spindle: α = 2, 7/2 ≤ χ_f, 18 independent sets, `decide` | the small instance the big one is a scaled copy of |
| the search agrees with the graph | `#eval` the maximum independent weight and read **72** | the certificate is tight; a slack answer means the wrong graph |

---

## 4. Controls — each one watched to fail

| control | what it breaks | must report |
|---|---|---|
| move one vertex off its unit circle | geometry | `coreSpindle_valid` false, `badEdges` names the edge |
| lower the bound to 71 | the search | `noHeavy` false — the maximum really is 72 |
| raise a weight by 1 | the search | `noHeavy` false |
| delete an edge from the certificate | the search | `noHeavy` false: the graph got easier, an independent set got heavier |
| **delete the prune's guard** (`if … then true` → `if … then false`) | nothing — it must still be *sound*, only slower | the soundness proof still goes through; this is the direction that cannot be allowed to fail silently |
| **weaken the prune to `wt ≤ D`** (dropping the remaining weight) | soundness | `noHeavy_sound` must **stop compiling**. A prune that skips a subtree it has not bounded is exactly the bug class this milestone is exposed to |
| a graph that is 3-colourable | the whole chain | `χ_f ≤ 3 < 65/18`, so the certificate must be refused |

---

## 5. Not in this milestone

* **Cranston–Rabern's 76/21.** Needs their lemma that every maximal independent set in the
  triangular lattice induces a tiling by 8 shapes. A milestone of its own.
* **The current record (≥ 4).** Needs the geometric fractional chromatic number and amenability of
  the plane's isometry group.
* **Upper bounds on χ_f.** `χ_f(ℝ²) ≤ 4.3599` is a genuinely different argument and this project
  has never needed an upper bound on anything.
* **Bigger cores.** § 0(d)–(e) show the bound creeping and the cost climbing together: 3.5789 at 47
  points and 38 thousand nodes, 3.6111 at 63 points and 391 thousand. One more core step is a
  measurement, not a promise.

## 6. Carried forward

Recorded here so nothing is discovered mid-hunt; not scheduled.

1. **Bigger cores.** The same generator at a larger core. The measured growth is ~10× nodes per core
   step against ~+0.03 in the bound, so the next step costs ~30 CPU minutes for ~3.63 — still under
   76/21, and the point at which the tile argument becomes the cheaper route.
2. **The tile lemma**, for 76/21.
3. **The weighted-independence search as a search instrument** — `noHeavy` answers "how heavy an
   independent set does this graph admit", which is the objective a χ_f-directed search descends.
   Belongs in M11's inventory.
4. **`Fractional.lean` toward Mathlib.** It depends on nothing in this project.
