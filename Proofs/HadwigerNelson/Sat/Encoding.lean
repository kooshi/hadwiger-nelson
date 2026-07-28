import Proofs.HadwigerNelson.EdgeList
import Std.Sat.CNF

/-!
# The CNF encoding of graph colouring

`k`-colourability of `edgeGraph n E` as a propositional formula, and the one direction of the
correspondence the project consumes: **a colouring yields a satisfying assignment.** Its
contrapositive — an unsatisfiable formula yields non-colourability — is what an LRAT certificate
buys us.

## Only one direction is proved, deliberately

`Colorable k G → Sat a cnf` is the whole obligation. The converse (`Sat → Colorable`) is *true*
here but never used, and proving the wrong direction is one of the named failure modes in
`ARCHITECTURE.md` § 6: a certificate proves a formula unsatisfiable, and only `Colorable → Sat`
turns that into `¬ Colorable`. Everything below is stated so the unused direction cannot be
mistaken for the needed one.

## At-most-one clauses are omitted

The standard encoding adds `¬x_{v,c} ∨ ¬x_{v,c'}` for `c ≠ c'`, forcing each vertex to exactly one
colour. We do not: the edge clauses already force adjacent vertices' colour *sets* to be disjoint,
so a satisfying assignment still yields a proper colouring by picking any set colour per vertex.
Fewer clauses, and the direction we prove is unaffected — `ofColoring` produces an assignment that
happens to be exactly-one anyway.

## Loops must be stripped here too

`edgeGraph` strips loops structurally (see `EdgeList.lean`). A listed pair `(i, i)` left in the
clause set would contribute `¬x_{i,c} ∨ ¬x_{i,c}`, making the formula unsatisfiable while the graph
stays colourable — i.e. it would make `sat_colouringCNF` **false**. `colouringCNF` therefore filters
the edge list under the same convention, and the two objects then correspond unconditionally.
-/

namespace HadwigerNelson

open Std.Sat

variable {n k : ℕ}

/-! ## Variables -/

/-- The propositional variable for "vertex `v` gets colour `c`", with `k` colours in play.

Indices are `ℕ` because that is what `LRAT.check` consumes; the bounds live in
`ofColoring_colourVar` rather than in the type, since no consumer of a CNF variable inspects
them. -/
def colourVar (k v c : ℕ) : ℕ := v * k + c

/-! ## The formula -/

/-- Vertex `v` gets at least one of the `k` colours. -/
def atLeastOneClause (k v : ℕ) : CNF.Clause ℕ :=
  (List.range k).map fun c => (colourVar k v c, true)

/-- The `k` clauses forbidding `u` and `w` from sharing a colour. -/
def edgeClauses (k u w : ℕ) : List (CNF.Clause ℕ) :=
  (List.range k).map fun c => [(colourVar k u c, false), (colourVar k w c, false)]

/-- **The encoding.** `k`-colourability of `edgeGraph n E`, as a CNF over `n * k` variables: one
at-least-one-colour clause per vertex, and `k` disequality clauses per non-loop listed edge. -/
def colouringCNF (k n : ℕ) (E : List (Fin n × Fin n)) : CNF ℕ :=
  ⟨((List.range n).map (atLeastOneClause k) ++
      (E.filter fun e => e.1 != e.2).flatMap fun e => edgeClauses k e.1.val e.2.val).toArray⟩

/-! ## The assignment a colouring induces -/

/-- A colouring of `Fin n`, extended off-range so it can index CNF variables. The extension value
is never observed: every lemma below applies it only at `v < n`. -/
def colourFn (C : Fin n → Fin k) : ℕ → ℕ := fun v => if h : v < n then (C ⟨v, h⟩).val else 0

/-- The assignment that sets `colourVar k v c` exactly when `f v = c`. -/
def ofColoring (k : ℕ) (f : ℕ → ℕ) : ℕ → Bool := fun m => m % k == f (m / k)

/-- `ofColoring` reads a colour variable back — the one arithmetic fact underneath the whole
encoding, and the only place `0 < k` is used. -/
theorem ofColoring_colourVar (hk : 0 < k) (f : ℕ → ℕ) {v c : ℕ} (hc : c < k) :
    ofColoring k f (colourVar k v c) = (c == f v) := sorry

/-- `colourFn` agrees with the colouring on the range where it matters. -/
@[simp] theorem colourFn_val (C : Fin n → Fin k) (v : Fin n) : colourFn C v.val = (C v).val := sorry

/-! ## Soundness — the only direction we prove -/

/-- **The bridge.** A proper colouring satisfies the encoding. Every later non-colourability claim
is this theorem contraposed. -/
theorem sat_colouringCNF {E : List (Fin n × Fin n)} (hk : 0 < k)
    (C : (edgeGraph n E).Coloring (Fin k)) :
    CNF.Sat (ofColoring k (colourFn ⇑C)) (colouringCNF k n E) := sorry

/-- **The consumer's form.** An unsatisfiable encoding means no `k`-colouring — what an LRAT
certificate is bought for. -/
theorem not_colorable_of_unsat {E : List (Fin n × Fin n)} (hk : 0 < k)
    (h : (colouringCNF k n E).Unsat) : ¬ (edgeGraph n E).Colorable k := sorry

/-! ## Cubes — the split that makes de Grey's instance solvable

A monolithic CaDiCaL run on the 1581-vertex instance did not terminate in 10 minutes and had
already emitted 2.0 GB of partial certificate (`ARCHITECTURE.md` § 2.3). The split is therefore
load-bearing: fix the colours of a small vertex set `W`, solve one much easier instance per
assignment, and the conjunction is the original.

The shape mirrors `UDCert.valid_of_chunks` exactly — an enumeration (`allCubes`), a covering lemma
proved once by induction (`restrict_mem_allCubes`), and a call site that discharges
`∀ cb ∈ allCubes k W` by `fin_cases`. -/

/-- A cube: a partial colouring, given as (vertex, colour) pairs. -/
abbrev Cube (n k : ℕ) : Type := List (Fin n × Fin k)

/-- A cube as unit clauses — the assumptions handed to the solver alongside `colouringCNF`. -/
def cubeCNF (k : ℕ) (cb : Cube n k) : CNF ℕ :=
  ⟨(cb.map fun vc => [(colourVar k vc.1.val vc.2.val, true)]).toArray⟩

/-- The cube a colouring induces on the split set `W`. -/
def restrict (W : List (Fin n)) (C : Fin n → Fin k) : Cube n k := W.map fun v => (v, C v)

/-- Every colouring of `W`, enumerated. `k ^ W.length` cubes, generated rather than listed, so the
covering fact below is a theorem instead of a `decide` over `k ^ n` colourings. -/
def allCubes (k : ℕ) : List (Fin n) → List (Cube n k)
  | [] => [[]]
  | v :: W => (allCubes k W).flatMap fun cb => (List.finRange k).map fun c => (v, c) :: cb

/-- **The covering fact.** Every colouring restricts to one of the enumerated cubes — the local
obligation that makes the split sound. -/
theorem restrict_mem_allCubes (W : List (Fin n)) (C : Fin n → Fin k) :
    restrict W C ∈ allCubes k W := sorry

/-- A colouring satisfies the cube it induces. -/
theorem sat_cubeCNF_restrict (hk : 0 < k) (W : List (Fin n)) (C : Fin n → Fin k) :
    CNF.Sat (ofColoring k (colourFn C)) (cubeCNF k (restrict W C)) := sorry

/-- **The split.** If every cube over `W` makes the encoding unsatisfiable, the graph has no
`k`-colouring. `W` is chosen by the generator; the theorem does not care how. -/
theorem not_colorable_of_cubes {E : List (Fin n × Fin n)} (hk : 0 < k) (W : List (Fin n))
    (h : ∀ cb ∈ allCubes k W, (colouringCNF k n E ++ cubeCNF k cb).Unsat) :
    ¬ (edgeGraph n E).Colorable k := sorry

/-! ## The independent route: deciding colourability directly

At calibration scale the whole question is decidable by brute force — `k ^ n` colourings — which is
how the spindle gets a second, SAT-free proof of the same fact. Hopeless past ~10 vertices, and
that is the point: it is the oracle the encoder is checked against. -/

/-- `Colorable` in the shape a decision procedure can run: a bare function with a disequality
condition, no bundled `Coloring`. -/
theorem colorable_iff_exists {G : SimpleGraph (Fin n)} :
    G.Colorable k ↔ ∃ f : Fin n → Fin k, ∀ i j, G.Adj i j → f i ≠ f j := sorry

/-- Non-colourability of an edge-list graph, phrased over the list and closed by `decide`. The
right-hand side mentions no `Adj` and no `SimpleGraph`, so the kernel sees only `Fin` arithmetic
and list membership. -/
theorem not_colorable_edgeGraph_iff {E : List (Fin n × Fin n)} :
    ¬ (edgeGraph n E).Colorable k ↔
      ∀ f : Fin n → Fin k, ∃ e ∈ E, e.1 ≠ e.2 ∧ f e.1 = f e.2 := sorry

/-! ## Spec checks

Every theorem above would hold vacuously of an encoder that emitted nothing, and unsatisfiably of
one that emitted a contradiction. These pin the shape of the actual output and run on every build;
the two-sided check against a real colouring lives in `Instances/SpindleBound.lean`, where a real
graph is in scope. -/

section Spec

-- Variable indexing: vertex 2, colour 1, three colours.
#guard colourVar 3 2 1 = 7

-- Loops are stripped: two at-least-one clauses and nothing else. Were the self-loop to survive it
-- would contribute `¬x ∨ ¬x` and make every formula unsatisfiable.
#guard (colouringCNF 3 2 [(0, 0)]).clauses.size = 2

-- A genuine edge contributes exactly `k` clauses.
#guard (colouringCNF 3 2 [(0, 1)]).clauses.size = 5

-- The cube enumeration has size `k ^ |W|`.
#guard (allCubes 3 (n := 2) [0, 1]).length = 9

end Spec

end HadwigerNelson
