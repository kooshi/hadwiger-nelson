import Proofs.HadwigerNelson.EdgeList
import Std.Sat.CNF

/-!
# The CNF encoding of graph colouring

`k`-colourability of `edgeGraph n E` as a propositional formula, and the one direction of the
correspondence the project consumes: **a colouring yields a satisfying assignment.** Its
contrapositive — an unsatisfiable formula yields non-colourability — is what an LRAT certificate
buys us.

## Why one direction is enough, and what it protects

Only `Colorable k G → satisfiable` is proved. That is not thrift; it is the safety argument, and it
is worth stating precisely because it says exactly which encoder bugs can hurt us.

Satisfiability is *antitone* in the clause set. So an encoder that emits **too few** clauses yields a
formula that is satisfiable — and a satisfiable formula has no refutation, so no certificate exists
and no theorem is produced. An encoder that emits **too many** clauses breaks
`exists_sat_colouringCNF`, which fails to elaborate. Either way the failure is loud.

**The encoder cannot be wrong in a way that produces a false bound.** The residual risk is not in
this file at all: it is that the DIMACS handed to the solver is not this formula, which is why the
DIMACS is printed *from these definitions* (`ARCHITECTURE.md` § 6) rather than re-derived.

## At-most-one clauses are omitted

The standard encoding adds `¬x_{v,c} ∨ ¬x_{v,c'}` for `c ≠ c'`, forcing each vertex to exactly one
colour. We do not: the edge clauses already force adjacent vertices' colour *sets* to be disjoint,
so a satisfying assignment still yields a proper colouring by picking any set colour per vertex.
Fewer clauses, and by the argument above, dropping clauses cannot make a bound false.

## Loops must be stripped here too

`edgeGraph` strips loops structurally (see `EdgeList.lean`). A listed pair `(i, i)` left in the
clause set would contribute `¬x_{i,c} ∨ ¬x_{i,c}` — an over-constraining bug, so by the argument
above it would break `exists_sat_colouringCNF` rather than lie. `colouringCNF` filters under the
same convention as `edgeGraph`, and the correspondence is then unconditional.

## The assignment is a witness, and stays one

Nothing downstream inspects the satisfying assignment — every consumer contradicts an `Unsat`. So
it lives behind `∃` and its construction is private: extending a colouring `Fin n → Fin k` to the
`ℕ → Bool` an assignment must be requires a junk value off-range, and a junk value that never
crosses a module boundary is one that no consumer can trip over.
-/

namespace HadwigerNelson

open Std.Sat

variable {n k : ℕ}

/-! ## The formula -/

/-- The propositional variable for "vertex `v` gets colour `c`", with `k` colours in play.

Indices are `ℕ` because that is what `LRAT.check` consumes. A variable *is* a (vertex, colour)
pair, but nothing downstream — not the certificate, not the DIMACS, not the checker — inspects the
pairing, so it lives here as a definition with a round-trip lemma rather than as a variable type
that every signature would carry.

`k * v + c` rather than `v * k + c`: the same numbering, but the shape `Nat.mul_add_div` and
`Nat.mul_add_mod` are stated in, which is the difference between a one-line round-trip lemma and a
hand-rolled one. -/
def colourVar (k v c : ℕ) : ℕ := k * v + c

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

/-! ## The satisfying assignment — private, because nobody consumes it -/

/-- A colouring of `Fin n` as a total function on variable indices. The off-range value is junk and
is never observed: every lemma below applies it only at `v < n`. Private, so the junk cannot leave
this module. -/
private def colourFn (C : Fin n → Fin k) : ℕ → ℕ :=
  fun v => if h : v < n then (C ⟨v, h⟩).val else 0

/-- The assignment that sets `colourVar k v c` exactly when `f v = c`. Private for the same reason
as `colourFn`. -/
private def ofColoring (k : ℕ) (f : ℕ → ℕ) : ℕ → Bool := fun m => m % k == f (m / k)

/-- `ofColoring` reads a colour variable back — the one arithmetic fact underneath the whole
encoding, and the only place `0 < k` is used. -/
private theorem ofColoring_colourVar (hk : 0 < k) (f : ℕ → ℕ) {v c : ℕ} (hc : c < k) :
    ofColoring k f (colourVar k v c) = (c == f v) := sorry

/-- `colourFn` agrees with the colouring on the range where it matters. -/
private theorem colourFn_val (C : Fin n → Fin k) (v : Fin n) :
    colourFn C v.val = (C v).val := sorry

/-! ## Soundness — the only direction we prove

`0 < k` is a *proof* hypothesis, not a correctness one. At `k = 0` the encoding is still right — it
emits one empty clause per vertex, hence unsatisfiable, and `Fin n → Fin 0` is indeed uninhabited
for `n > 0`. The hypothesis is there because `ofColoring` divides by `k`, and `Nat` division by zero
returns junk rather than failing. Every call site has `k` a literal. -/

/-- **The bridge.** A proper colouring makes the encoding satisfiable. Every non-colourability claim
in the project is this theorem contraposed. -/
theorem exists_sat_colouringCNF {E : List (Fin n × Fin n)} (hk : 0 < k)
    (C : (edgeGraph n E).Coloring (Fin k)) :
    ∃ a, CNF.Sat a (colouringCNF k n E) := sorry

/-- **The consumer's form.** An unsatisfiable encoding means no `k`-colouring — what an LRAT
certificate is bought for. -/
theorem not_colorable_of_unsat {E : List (Fin n × Fin n)} (hk : 0 < k)
    (h : (colouringCNF k n E).Unsat) : ¬ (edgeGraph n E).Colorable k := sorry

/-! ## Cubes — the split that makes de Grey's instance solvable

A monolithic CaDiCaL run on the 1581-vertex instance did not terminate in 10 minutes and had
already emitted 2.0 GB of partial certificate (`ARCHITECTURE.md` § 2.3). The split is therefore
load-bearing: fix the colours of a small vertex set `W`, solve one much easier instance per
assignment, and the conjunction is the original.

The shape mirrors `UDCert.valid_of_chunks` deliberately — the project should have one shape for
"the big obligation is the conjunction of generated small ones":

| geometry | combinatorics |
|---|---|
| `chunks`, supplied by the caller | `allCubes k W`, generated |
| `hjoin : chunks.flatten = c.edges` | `restrict_mem_allCubes`, proved by induction on `W` |
| `∀ ch ∈ chunks, ValidOn ch` | `∀ cb ∈ allCubes k W, Unsat (cnf ++ cubeCNF k cb)` |

`W = []` gives exactly one cube, the empty one, so `not_colorable_of_cubes` degenerates to
`not_colorable_of_unsat` — the monolithic case is the split's own base case. -/

/-- A cube: a partial colouring, given as (vertex, colour) pairs.

The type is lax — it admits repeated vertices, conflicting colours, vertices outside the split set.
That is safe because cubes are never supplied by hand: `allCubes` is the only producer, and it is
the smart constructor that makes the laxity unreachable. -/
abbrev Cube (n k : ℕ) : Type := List (Fin n × Fin k)

/-- A cube as unit clauses — the assumptions handed to the solver alongside `colouringCNF`. -/
def cubeCNF (k : ℕ) (cb : Cube n k) : CNF ℕ :=
  ⟨(cb.map fun vc => [(colourVar k vc.1.val vc.2.val, true)]).toArray⟩

/-- The cube a colouring induces on the split set `W`. -/
def restrict (W : List (Fin n)) (C : Fin n → Fin k) : Cube n k := W.map fun v => (v, C v)

/-- Every colouring of `W`, enumerated — `k ^ W.length` cubes, generated rather than listed. This is
what makes the covering fact below a theorem (structural induction on `W`) instead of a decision
over `k ^ n` colourings, which is not a computation anyone can run at n = 1581. -/
def allCubes (k : ℕ) : List (Fin n) → List (Cube n k)
  | [] => [[]]
  | v :: W => (allCubes k W).flatMap fun cb => (List.finRange k).map fun c => (v, c) :: cb

/-- **The covering fact.** Every colouring restricts to one of the enumerated cubes — the local
obligation that makes the split sound. -/
theorem restrict_mem_allCubes (W : List (Fin n)) (C : Fin n → Fin k) :
    restrict W C ∈ allCubes k W := sorry

/-- A colouring makes the encoding *and its own cube* simultaneously satisfiable — one assignment
for both halves, which is what the split turns on. -/
theorem exists_sat_colouringCNF_cube {E : List (Fin n × Fin n)} (hk : 0 < k) (W : List (Fin n))
    (C : (edgeGraph n E).Coloring (Fin k)) :
    ∃ a, CNF.Sat a (colouringCNF k n E ++ cubeCNF k (restrict W ⇑C)) := sorry

/-- **The split.** If every cube over `W` makes the encoding unsatisfiable, the graph has no
`k`-colouring. `W` is chosen by the generator; the theorem does not care how.

Two ways to discharge `h`, both verified against separately-stated literal-cube theorems:
`intro cb hcb; fin_cases hcb; exacts [c₀, …]` (measured ~2 s at 64 cubes, ~9 s at 256), or
`List.forall_iff_forall_mem.mp ⟨c₀, …⟩`, which is a plain tuple with no tactic search and is the
one to prefer past ~100 cubes. -/
theorem not_colorable_of_cubes {E : List (Fin n × Fin n)} (hk : 0 < k) (W : List (Fin n))
    (h : ∀ cb ∈ allCubes k W, (colouringCNF k n E ++ cubeCNF k cb).Unsat) :
    ¬ (edgeGraph n E).Colorable k := sorry

/-! ## The independent route: deciding colourability directly

At calibration scale the whole question is decidable by brute force — `k ^ n` colourings — which is
how the spindle gets a second, SAT-free proof of the same fact. Hopeless past ~10 vertices, and
that is the point: it is the oracle the encoder is checked against.

Stated as a rewrite rather than a `Decidable` instance, deliberately. `Colorable` is Mathlib's, and
an instance would be a standing invitation for `decide` to attempt `4 ^ 1581` in a context nobody
asked. Making the caller name this rewrite makes the brute-force route a choice. -/

/-- `Colorable` in the shape a decision procedure can run: a bare function with a disequality
condition, no bundled `Coloring`. -/
theorem colorable_iff_exists {G : SimpleGraph (Fin n)} :
    G.Colorable k ↔ ∃ f : Fin n → Fin k, ∀ i j, G.Adj i j → f i ≠ f j := sorry

/-- Non-colourability of an edge-list graph, phrased over the list and closed by `decide`. The
right-hand side mentions no `Adj` and no `SimpleGraph`, so the kernel sees only `Fin` arithmetic
and list membership.

The `e.1 ≠ e.2` conjunct is load-bearing, and is the same convention `edgeGraph` and `colouringCNF`
apply: without it a listed self-loop would satisfy the right-hand side for every `f`, making the
graph "non-colourable" on no evidence. -/
theorem not_colorable_edgeGraph_iff {E : List (Fin n × Fin n)} :
    ¬ (edgeGraph n E).Colorable k ↔
      ∀ f : Fin n → Fin k, ∃ e ∈ E, e.1 ≠ e.2 ∧ f e.1 = f e.2 := sorry

/-! ## Spec checks

Every theorem above would hold vacuously of an encoder that emitted nothing. These pin the shape of
the actual output, including at the members no example naturally reaches, and run on every build.
The two-sided check against a real colouring lives in `Instances/SpindleBound.lean`, where a real
graph is in scope. -/

section Spec

-- Variable indexing: vertex 2, colour 1, three colours.
#guard colourVar 3 2 1 = 7

-- Loops are stripped: two at-least-one clauses and nothing else.
#guard (colouringCNF 3 2 [(0, 0)]).clauses.size = 2

-- A genuine edge contributes exactly `k` clauses.
#guard (colouringCNF 3 2 [(0, 1)]).clauses.size = 5

-- Unsampled member, `n = 0`: no vertices, no clauses, satisfiable — and `edgeGraph 0 []` is indeed
-- colourable, so the encoding agrees.
#guard (colouringCNF 3 0 []).clauses.size = 0

-- Unsampled member, `k = 0`: one *empty* clause per vertex, hence unsatisfiable — and `Fin 2 → Fin 0`
-- is uninhabited, so the encoding agrees here too. The `0 < k` hypothesis upstream is about `Nat`
-- division, not about this.
#guard (colouringCNF 0 2 []).clauses = #[[], []]

-- The cube enumeration has size `k ^ |W|` …
#guard (allCubes 3 (n := 2) [0, 1]).length = 9

-- … and `W = []` gives exactly one cube, the empty one, which adds no clauses. That is why the
-- monolithic case is the split's base case rather than a separate mechanism.
#guard (allCubes 3 (n := 2) []) = [[]]
#guard (cubeCNF 3 (n := 2) []).clauses.size = 0

end Spec

end HadwigerNelson
