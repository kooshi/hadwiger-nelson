import Proofs.HadwigerNelson.EdgeList
import Std.Sat.CNF

/-!
# The CNF encoding of graph colouring

`k`-colourability of `edgeGraph n E` as a propositional formula, and the one direction of the
correspondence the project consumes: **a coloring yields a satisfying assignment.** Its
contrapositive — an unsatisfiable formula yields non-colourability — is what an LRAT certificate
buys us.

Identifiers spell it `color`, following Mathlib's `Colorable` / `Coloring` / `chromaticNumber`,
which sit next to these names in every goal. The prose spells it `colour`.

## Using this file

You want one of two theorems, and neither requires knowing anything about the formula's shape:

```lean
-- a certificate for the whole instance
theorem myGraph_not_3_colorable : ¬ (edgeGraph n myEdges).Colorable 3 :=
  not_colorable_of_unsat myCnfUnsat

-- or, at de Grey scale, one certificate per cube
theorem myGraph_not_4_colorable : ¬ (edgeGraph n myEdges).Colorable 4 :=
  not_colorable_of_cubes mySplit myCubes rfl (by
    intro cb hcb; fin_cases hcb; exacts [cube₀_unsat, cube₁_unsat, …])
```

`0 < k` is an `autoParam` discharged by `norm_num`, so a literal `k` costs nothing to say.

## Why one direction is enough, and what it protects

Only `Colorable k G → satisfiable` is proved. That is not thrift; it is the safety argument, and it
is worth stating precisely because it says exactly which encoder bugs can hurt us.

Satisfiability is *antitone* in the clause set. So an encoder that emits **too few** clauses yields a
formula that is satisfiable — and a satisfiable formula has no refutation, so no certificate exists
and no theorem is produced. An encoder that emits **too many** clauses breaks
`exists_sat_coloringCNF`, which fails to elaborate. Either way the failure is loud.

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
above it would break `exists_sat_coloringCNF` rather than lie. `coloringCNF` filters under the same
convention as `edgeGraph`, and the correspondence is then unconditional.

## The assignment is a witness, and stays one

Nothing downstream inspects the satisfying assignment — every consumer contradicts an `Unsat`. So
it lives behind `∃` and its construction is private: extending a coloring `Fin n → Fin k` to the
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
def colorVar (k v c : ℕ) : ℕ := k * v + c

/-- Vertex `v` gets at least one of the `k` colours. -/
def atLeastOneClause (k v : ℕ) : CNF.Clause ℕ :=
  (List.range k).map fun c => (colorVar k v c, true)

/-- The `k` clauses forbidding `u` and `w` from sharing a colour. -/
def edgeClauses (k u w : ℕ) : List (CNF.Clause ℕ) :=
  (List.range k).map fun c => [(colorVar k u c, false), (colorVar k w c, false)]

/-- **The encoding.** `k`-colourability of `edgeGraph n E`, as a CNF over `n * k` variables: one
at-least-one-colour clause per vertex, and `k` disequality clauses per non-loop listed edge.

**This definition owes no lemma API, and has none by design.** Nothing downstream reasons about the
formula's shape: it is printed to DIMACS by `scripts/Dimacs.lean` and certified by `LRAT.check`.
The single theorem you need about it is `exists_sat_coloringCNF`, and its contrapositives
`not_colorable_of_unsat` / `not_colorable_of_cubes` are the only things a caller should ever cite.
If you find yourself unfolding this, say what you are trying to prove — the answer is probably one
of those three. -/
def coloringCNF (k n : ℕ) (E : List (Fin n × Fin n)) : CNF ℕ :=
  ⟨((List.range n).map (atLeastOneClause k) ++
      (E.filter fun e => e.1 != e.2).flatMap fun e => edgeClauses k e.1.val e.2.val).toArray⟩

/-! ## The satisfying assignment — private, because nobody consumes it -/

/-- A coloring of `Fin n` as a total function on variable indices. The off-range value is junk and
is never observed: every lemma below applies it only at `v < n`. Private, so the junk cannot leave
this module. -/
private def colorFn (C : Fin n → Fin k) : ℕ → ℕ :=
  fun v => if h : v < n then (C ⟨v, h⟩).val else 0

/-- The assignment that sets `colorVar k v c` exactly when `f v = c`. Private for the same reason as
`colorFn`. -/
private def ofColoring (k : ℕ) (f : ℕ → ℕ) : ℕ → Bool := fun m => m % k == f (m / k)

/-- `ofColoring` reads a colour variable back — the one arithmetic fact underneath the whole
encoding, and the only place `0 < k` is used.

Closes by `simp [ofColoring, colorVar, Nat.mul_add_div hk, Nat.mod_eq_of_lt hc,
Nat.div_eq_of_lt hc]`; the citation is why `colorVar` is `k * v + c`. -/
private theorem ofColoring_colorVar (hk : 0 < k) (f : ℕ → ℕ) {v c : ℕ} (hc : c < k) :
    ofColoring k f (colorVar k v c) = (c == f v) := by
  simp [ofColoring, colorVar, Nat.mul_add_div hk, Nat.mod_eq_of_lt hc, Nat.div_eq_of_lt hc]

/-- `colorFn` lands in range everywhere — in range because the coloring does, off range because the
junk value is `0` and `0 < k`. This is where `hk` pays for the junk. -/
private theorem colorFn_lt (hk : 0 < k) (C : Fin n → Fin k) (v : ℕ) : colorFn C v < k := by
  unfold colorFn
  split
  · exact (C _).isLt
  · exact hk

/-- `colorFn` agrees with the coloring on the range where it matters. -/
private theorem colorFn_val (C : Fin n → Fin k) (v : Fin n) : colorFn C v.val = (C v).val := by
  simp [colorFn, v.isLt]

/-- A vertex's own colour variable is set. Half of what each clause case needs. -/
private theorem ofColoring_self (hk : 0 < k) (C : Fin n → Fin k) (v : ℕ) :
    ofColoring k (colorFn C) (colorVar k v (colorFn C v)) = true := by
  rw [ofColoring_colorVar hk _ (colorFn_lt hk C v)]
  simp

/-- Any other colour's variable is unset. The other half. -/
private theorem ofColoring_ne (hk : 0 < k) (C : Fin n → Fin k) {v c : ℕ} (hc : c < k)
    (h : c ≠ colorFn C v) : ofColoring k (colorFn C) (colorVar k v c) = false := by
  rw [ofColoring_colorVar hk _ hc]
  simpa using h

/-! ### The two clause families, one lemma each

`coloringCNF` is an append of two `map`s, so its satisfaction is exactly these two facts plus
`List.mem_append`. Stating them separately is what keeps the assembly a transcription rather than a
forty-line block. -/

/-- An at-least-one clause is satisfied — witnessed at the vertex's own colour. -/
private theorem eval_atLeastOneClause (hk : 0 < k) (C : Fin n → Fin k) (v : ℕ) :
    CNF.Clause.eval (ofColoring k (colorFn C)) (atLeastOneClause k v) = true := by
  simp only [atLeastOneClause, CNF.Clause.eval, List.any_map, List.any_eq_true, Function.comp_def,
    List.mem_range]
  exact ⟨colorFn C v, colorFn_lt hk C v, by simp [ofColoring_self hk C v]⟩

/-- An edge clause is satisfied — because the endpoints' colours differ, colour `c` misses at least
one of them. The case split is on `c = colorFn C u`, and each branch cites `ofColoring_ne`. -/
private theorem eval_edgeClause (hk : 0 < k) (C : Fin n → Fin k) {u w c : ℕ} (hc : c < k)
    (hne : colorFn C u ≠ colorFn C w) :
    CNF.Clause.eval (ofColoring k (colorFn C))
      [(colorVar k u c, false), (colorVar k w c, false)] = true := by
  by_cases h : c = colorFn C u
  · have hw : c ≠ colorFn C w := by rw [h]; exact hne
    simp [CNF.Clause.eval, ofColoring_ne hk C hc hw]
  · simp [CNF.Clause.eval, ofColoring_ne hk C hc h]

/-! ## Soundness — the only direction we prove

`0 < k` is a *proof* hypothesis, not a correctness one. At `k = 0` the encoding is still right — it
emits one empty clause per vertex, hence unsatisfiable, and `Fin n → Fin 0` is indeed uninhabited
for `n > 0`. The hypothesis is there because `ofColoring` divides by `k`, and `Nat` division by zero
returns junk rather than failing. It is an `autoParam` because every call site has `k` a literal. -/

/-- The witness, named once. Both public existentials cite this, which is what lets the cube half
share a single assignment with the encoding half across `CNF.eval_append`.

The assembly is a transcription: `List.all_toArray` and `List.all_eq_true` carry `Array.all` down to
`∀ cl ∈ _`, `List.mem_append` splits the two clause families, and each side is one of the two clause
lemmas above. The edge side crosses the Bool/Prop seam on the loop filter with `List.mem_filter`,
then reaches `Adj` through `edgeGraph_adj_of_mem` and `Coloring.valid` — the packaging M01 left for
exactly this call site. -/
private theorem sat_coloringCNF {E : List (Fin n × Fin n)} (hk : 0 < k)
    (C : (edgeGraph n E).Coloring (Fin k)) :
    CNF.Sat (ofColoring k (colorFn ⇑C)) (coloringCNF k n E) := by
  simp only [CNF.Sat, CNF.eval, coloringCNF, List.all_toArray, List.all_eq_true]
  intro cl hcl
  rcases List.mem_append.mp hcl with h | h
  · obtain ⟨v, -, rfl⟩ := List.mem_map.mp h
    exact eval_atLeastOneClause hk _ v
  · obtain ⟨e, he, hcl'⟩ := List.mem_flatMap.mp h
    obtain ⟨c, hc, rfl⟩ := List.mem_map.mp hcl'
    obtain ⟨heE, hbne⟩ := List.mem_filter.mp he
    have hne : e.1 ≠ e.2 := by simpa using hbne
    have hCne : C e.1 ≠ C e.2 := C.valid (edgeGraph_adj_of_mem hne heE)
    have hfne : colorFn ⇑C e.1.val ≠ colorFn ⇑C e.2.val := by
      rw [colorFn_val, colorFn_val]
      exact fun hh => hCne (Fin.val_inj.mp hh)
    exact eval_edgeClause hk _ (List.mem_range.mp hc) hfne

/-- **The bridge.** A proper coloring makes the encoding satisfiable. Every non-colourability claim
in the project is this theorem contraposed. -/
theorem exists_sat_coloringCNF {E : List (Fin n × Fin n)}
    (C : (edgeGraph n E).Coloring (Fin k)) (hk : 0 < k := by norm_num) :
    ∃ a, CNF.Sat a (coloringCNF k n E) :=
  ⟨_, sat_coloringCNF hk C⟩

/-- **The consumer's form.** An unsatisfiable encoding means no `k`-colouring — what an LRAT
certificate is bought for. -/
theorem not_colorable_of_unsat {E : List (Fin n × Fin n)} (h : (coloringCNF k n E).Unsat)
    (hk : 0 < k := by norm_num) : ¬ (edgeGraph n E).Colorable k := by
  rintro ⟨C⟩
  obtain ⟨a, ha⟩ := exists_sat_coloringCNF C hk
  simp [CNF.Sat, h a] at ha

/-! ## Cubes — the split that makes de Grey's instance solvable

A monolithic CaDiCaL run on the 1581-vertex instance did not terminate in 10 minutes and had
already emitted 2.0 GB of partial certificate (`ARCHITECTURE.md` § 2.3). The split is therefore
load-bearing: fix the colours of a small vertex set `W`, solve one much easier instance per
assignment, and the conjunction is the original.

The shape mirrors `UDCert.valid_of_chunks` deliberately — the project has one shape for "the big
obligation is the conjunction of generated small ones":

| geometry | combinatorics |
|---|---|
| `chunks`, supplied by the caller as a literal | `cubes`, supplied by the caller as a literal |
| `hjoin : chunks.flatten = c.edges`, by `rfl` | `hcover : allCubes k n W = cubes`, by `rfl` |
| `∀ ch ∈ chunks, ValidOn ch` | `∀ cb ∈ cubes, Unsat (cnf ++ cubeCNF k cb)` |

`W = []` gives exactly one cube, the empty one, so the monolithic case is the split's own base
case. -/

/-- A cube: a partial colouring, given as (vertex, colour) pairs.

The type is lax — it admits repeated vertices, conflicting colours, vertices outside the split set.
That is safe because a cube list only ever reaches a theorem through `hcover : allCubes k W = cubes`,
and `allCubes` cannot produce any of those. -/
abbrev Cube (n k : ℕ) : Type := List (Fin n × Fin k)

/-- A cube as unit clauses — the assumptions handed to the solver alongside `coloringCNF`. -/
def cubeCNF (k n : ℕ) (cb : Cube n k) : CNF ℕ :=
  ⟨(cb.map fun vc => [(colorVar k vc.1.val vc.2.val, true)]).toArray⟩

/-- The cube a coloring induces on the split set `W`. -/
def cubeOf (W : List (Fin n)) (C : Fin n → Fin k) : Cube n k := W.map fun v => (v, C v)

/-- Every colouring of `W`, enumerated — `k ^ W.length` cubes, generated rather than listed. This is
what makes the covering fact below a theorem (structural induction on `W`) instead of a decision
over `k ^ n` colourings, which is not a computation anyone can run at n = 1581.

`toString (allCubes k n W)` is valid Lean source for a `List (Cube n k)`, which is how the generator
gets its cube literals: it asks Lean rather than reimplementing the enumeration. -/
def allCubes (k n : ℕ) : List (Fin n) → List (Cube n k)
  | [] => [[]]
  | v :: W => (allCubes k n W).flatMap fun cb => (List.finRange k).map fun c => (v, c) :: cb

/-- **The covering fact.** Every coloring restricts to one of the enumerated cubes — the local
obligation that makes the split sound. -/
theorem cubeOf_mem_allCubes (W : List (Fin n)) (C : Fin n → Fin k) :
    cubeOf W C ∈ allCubes k n W := by
  induction W with
  | nil => simp [cubeOf, allCubes]
  | cons v W ih =>
      simp only [cubeOf, List.map_cons, allCubes, List.mem_flatMap, List.mem_map]
      exact ⟨_, ih, C v, List.mem_finRange _, rfl⟩

/-- The cube half of the witness `sat_coloringCNF` names. Note the hypothesis: an arbitrary
`C : Fin n → Fin k`, not a coloring — satisfying one's own cube has nothing to do with the graph,
and the weaker statement is the easier proof. -/
private theorem sat_cubeCNF_cubeOf (hk : 0 < k) (W : List (Fin n)) (C : Fin n → Fin k) :
    CNF.Sat (ofColoring k (colorFn C)) (cubeCNF k n (cubeOf W C)) := by
  simp only [CNF.Sat, CNF.eval, cubeCNF, cubeOf, List.all_toArray, List.all_eq_true,
    List.map_map, Function.comp_def]
  intro cl hcl
  obtain ⟨v, -, rfl⟩ := List.mem_map.mp hcl
  simp [CNF.Clause.eval, ← colorFn_val C v, ofColoring_self hk C v.val]

/-- A coloring makes the encoding *and its own cube* simultaneously satisfiable — one assignment for
both halves, which is what the split turns on. Proof: `CNF.eval_append` splits the goal and the two
private witness lemmas close the halves, with the *same* assignment on both. -/
theorem exists_sat_coloringCNF_cube {E : List (Fin n × Fin n)} (W : List (Fin n))
    (C : (edgeGraph n E).Coloring (Fin k)) (hk : 0 < k := by norm_num) :
    ∃ a, CNF.Sat a (coloringCNF k n E ++ cubeCNF k n (cubeOf W ⇑C)) :=
  ⟨ofColoring k (colorFn ⇑C), by
    simp only [CNF.Sat, CNF.eval_append, Bool.and_eq_true]
    exact ⟨sat_coloringCNF hk C, sat_cubeCNF_cubeOf hk W ⇑C⟩⟩

/-- **The split.** If every cube over `W` makes the encoding unsatisfiable, the graph has no
`k`-colouring.

**The caller supplies `cubes` as a literal list and ties it down with `hcover := rfl`**, rather than
letting `allCubes k n W` appear in the obligation directly. That is not ceremony — it is the whole
difference at the breakdown surface. With a literal list, a generated certificate attached to the
wrong cube fails with

```
type mismatch: q₅ has type Q [(0, 2), (1, 1)] but is expected to have type Q [(0, 1), (1, 1)]
```

With `allCubes k n W` inline, the same mistake reports the expected type as an unreduced
`Q ((fun c => (0, c) :: (fun c => [(1, c)]) ((fun i => i) ⟨1, ⋯⟩)) …)` — the enumeration's
implementation, not a cube. At 256 cubes that is the difference between a fixable error and an
unreadable one.

Discharge `h` either with `intro cb hcb; fin_cases hcb; exacts [c₀, …]` (measured ~2 s at 64 cubes,
~9 s at 256) or with `List.forall_iff_forall_mem.mp ⟨c₀, …⟩`, a plain tuple with no tactic search —
prefer the tuple past ~100 cubes; it also reports *every* mismatched entry rather than the first. -/
theorem not_colorable_of_cubes {E : List (Fin n × Fin n)} (W : List (Fin n))
    (cubes : List (Cube n k)) (hcover : allCubes k n W = cubes)
    (h : ∀ cb ∈ cubes, (coloringCNF k n E ++ cubeCNF k n cb).Unsat)
    (hk : 0 < k := by norm_num) : ¬ (edgeGraph n E).Colorable k := by
  rintro ⟨C⟩
  obtain ⟨a, ha⟩ := exists_sat_coloringCNF_cube W C hk
  simp [CNF.Sat, h _ (hcover ▸ cubeOf_mem_allCubes W ⇑C) a] at ha

/-! ## The independent route: deciding colourability directly

At calibration scale the whole question is decidable by brute force — `k ^ n` colourings — which is
how the spindle gets a second, SAT-free proof of the same fact. Hopeless past ~10 vertices, and
that is the point: it is the oracle the encoder is checked against.

Stated as a rewrite rather than a `Decidable` instance, deliberately. `Colorable` is Mathlib's, and
an instance would be a standing invitation for `decide` to attempt `4 ^ 1581` in a context nobody
asked. Making the caller name this rewrite makes the brute-force route a choice. -/

/-- `Colorable` in the shape a decision procedure can run: a bare function with a disequality
condition, no bundled `Coloring`.

Also the way to *exhibit* a colouring: `colorable_iff_exists.mpr ⟨myColoring, by
simp only [edgeGraph_adj]; decide⟩`. The `simp only` is what carries the goal out of graph
vocabulary — there is deliberately no `DecidableRel (edgeGraph n E).Adj` instance. -/
theorem colorable_iff_exists {G : SimpleGraph (Fin n)} :
    G.Colorable k ↔ ∃ f : Fin n → Fin k, ∀ i j, G.Adj i j → f i ≠ f j :=
  ⟨fun ⟨C⟩ => ⟨C, fun _ _ h => C.valid h⟩,
   fun ⟨f, hf⟩ => ⟨SimpleGraph.Coloring.mk f fun {i j} h => hf i j h⟩⟩

/-- A monochromatic edge, translated between graph vocabulary and list vocabulary. Split out from
`not_colorable_edgeGraph_iff` because it is a different argument: that theorem pushes a negation
through a quantifier, this one crosses the `Adj`-to-membership seam, and the symmetric case
(`(j, i) ∈ E`) lives here where it is two `.symm`s rather than a detour mid-proof. -/
private theorem exists_adj_eq_iff {E : List (Fin n × Fin n)} {f : Fin n → Fin k} :
    (∃ i j, (edgeGraph n E).Adj i j ∧ f i = f j) ↔ ∃ e ∈ E, e.1 ≠ e.2 ∧ f e.1 = f e.2 := by
  constructor
  · rintro ⟨i, j, ⟨hne, hij | hji⟩, hf⟩
    · exact ⟨(i, j), hij, hne, hf⟩
    · exact ⟨(j, i), hji, hne.symm, hf.symm⟩
  · rintro ⟨e, he, hne, hf⟩
    exact ⟨e.1, e.2, edgeGraph_adj_of_mem hne he, hf⟩

/-- Non-colourability of an edge-list graph, phrased over the list and closed by `decide`. The
right-hand side mentions no `Adj` and no `SimpleGraph`, so the kernel sees only `Fin` arithmetic
and list membership.

Proof: `colorable_iff_exists`, then `push Not` (**not** `push_neg` — deprecated at v4.32.0), then
`exists_adj_eq_iff`.

The `e.1 ≠ e.2` conjunct is load-bearing, and is the same convention `edgeGraph` and `coloringCNF`
apply: without it a listed self-loop would satisfy the right-hand side for every `f`, making the
graph "non-colourable" on no evidence. -/
theorem not_colorable_edgeGraph_iff {E : List (Fin n × Fin n)} :
    ¬ (edgeGraph n E).Colorable k ↔
      ∀ f : Fin n → Fin k, ∃ e ∈ E, e.1 ≠ e.2 ∧ f e.1 = f e.2 := by
  rw [colorable_iff_exists]
  push Not
  simp only [← exists_adj_eq_iff]

/-! ## Spec checks

Every theorem above would hold vacuously of an encoder that emitted nothing. These pin the shape of
the actual output, including at the members no example naturally reaches, and run on every build.
The two-sided check against a real colouring lives in `Instances/SpindleBound.lean`, where a real
graph is in scope. -/

section Spec

-- Variable indexing: vertex 2, colour 1, three colours.
#guard colorVar 3 2 1 = 7

-- Loops are stripped: two at-least-one clauses and nothing else.
#guard (coloringCNF 3 2 [(0, 0)]).clauses.size = 2

-- A genuine edge contributes exactly `k` clauses.
#guard (coloringCNF 3 2 [(0, 1)]).clauses.size = 5

-- Unsampled member, `n = 0`: no vertices, no clauses, satisfiable — and `edgeGraph 0 []` is indeed
-- colourable, so the encoding agrees.
#guard (coloringCNF 3 0 []).clauses.size = 0

-- Unsampled member, `k = 0`: one *empty* clause per vertex, hence unsatisfiable — and `Fin 2 → Fin 0`
-- is uninhabited, so the encoding agrees here too. The `0 < k` autoParam upstream is about `Nat`
-- division, not about this.
#guard (coloringCNF 0 2 []).clauses = #[[], []]

-- The cube enumeration has size `k ^ |W|` …
#guard (allCubes 3 2 [0, 1]).length = 9

-- … and `W = []` gives exactly one cube, the empty one, which adds no clauses. That is why the
-- monolithic case is the split's base case rather than a separate mechanism.
#guard (allCubes 3 2 []) = [[]]
#guard (cubeCNF 3 2 []).clauses.size = 0

-- `toString` of a cube list is valid Lean source — the contract `scripts/Dimacs.lean` relies on to
-- emit cube literals that match what `fin_cases` produces.
#guard toString (allCubes 2 3 [0, 1]) =
  "[[(0, 0), (1, 0)], [(0, 1), (1, 0)], [(0, 0), (1, 1)], [(0, 1), (1, 1)]]"

end Spec

end HadwigerNelson
