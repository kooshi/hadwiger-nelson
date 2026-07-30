import Proofs.HadwigerNelson.Instances.DeGrey
import Proofs.HadwigerNelson.Sat.Encoding

/-!
M05 subplan measurement. Two numbers decide the milestone's shape:

1. **Kernel cost of building the clause database from the real CNF.** If it is cheap, `compile` stays
   inside the soundness statement and is re-reduced once per cube (96 times). If it is expensive,
   the database must be emitted as a literal and proved equal to `compile f` once — which costs
   ~56 MB of compiled module.
2. **Per-propagation-step cost with the database lookup included.** The spike measured 0.35 ms for
   the mask arithmetic alone, with no lookup in it. The kill criterion is 2 ms.

Set `N_STEPS`/`DO_COMPILE` per run; timings are taken by diffing against the zero-work variant.
-/

set_option maxRecDepth 4000000

open Std.Sat HadwigerNelson

/-- A clause as two dense bitmasks: `pos` is the set of positively-occurring variables. -/
structure MC where
  pos : Nat
  neg : Nat

/-- Trie depth: enough for 2^24 clause ids. Fuel, so the recursion is structural on `Nat`. -/
def DEPTH : Nat := 24

/-- Clause database: a binary trie keyed on the bits of the clause id. Root holds id 0; id `k+1`
descends into child `k % 2` carrying `k / 2`. Shape is independent of insertion order. -/
inductive DB where
  | nil
  | node (val : Option MC) (lo hi : DB)

def DB.get : Nat → DB → Nat → Option MC
  | 0,   _,           _     => none
  | _+1, .nil,        _     => none
  | _+1, .node v _ _, 0     => v
  | f+1, .node _ l h, (k+1) => if k % 2 == 0 then DB.get f l (k / 2) else DB.get f h (k / 2)

def DB.insert : Nat → DB → Nat → MC → DB
  | 0,   d,            _,     _ => d
  | _+1, .nil,         0,     c => .node (some c) .nil .nil
  | _+1, .node _ l h,  0,     c => .node (some c) l h
  | f+1, .nil,         (k+1), c =>
      if k % 2 == 0 then .node none (DB.insert f .nil (k / 2) c) .nil
                    else .node none .nil (DB.insert f .nil (k / 2) c)
  | f+1, .node v l h,  (k+1), c =>
      if k % 2 == 0 then .node v (DB.insert f l (k / 2) c) h
                    else .node v l (DB.insert f h (k / 2) c)

/-- A CNF clause as masks. -/
def maskOf (c : CNF.Clause Nat) : MC :=
  c.foldl (fun m (v, b) =>
    if b then { m with pos := m.pos ||| (1 <<< v) } else { m with neg := m.neg ||| (1 <<< v) })
    ⟨0, 0⟩

/-- Compile a clause list into the database at ids `i, i+1, …`, dropping tautologies. -/
def compileFrom (d : DB) (i : Nat) : List (CNF.Clause Nat) → DB
  | []      => d
  | c :: cs =>
      let m := maskOf c
      compileFrom (if m.pos &&& m.neg == 0 then d.insert DEPTH i m else d) (i + 1) cs

def compile (f : CNF Nat) : DB := compileFrom .nil 1 f.clauses.toList

/-- One propagation step's full work — the trie lookup, the two set-differences, the single-bit
test, and the assignment update — with the outcome folded into an accumulator so nothing is
skipped by lazy reduction. This is the loop whose per-step cost decides the milestone. -/
def bench (d : DB) (pos neg acc : Nat) : List Nat → Nat
  | []          => acc
  | id :: rest  =>
      match DB.get DEPTH d id with
      | none   => bench d pos neg (acc + 1) rest
      | some c =>
          let up := c.pos ^^^ (c.pos &&& neg)
          let un := c.neg ^^^ (c.neg &&& pos)
          let u  := up ||| un
          let hit := (u == 0) || (u &&& (u - 1) == 0)
          bench d (pos ||| up) (neg ||| un) (if hit then acc + 1 else acc) rest

/-- The real input formula: 4-colourability of de Grey's 1581-vertex graph.
1581 at-least-one clauses + 4 × 7877 edge clauses = 33,089 clauses over 6324 variables. -/
def cnf : CNF Nat := coloringCNF 4 1581 deGrey.edges

def hints (n : Nat) : List Nat := (List.range n).map fun i => (i * 7919 + 13) % 33089 + 1

#eval cnf.clauses.size
#eval (compile cnf).get DEPTH 5000 |>.isSome
#eval bench (compile cnf) 0 0 0 (hints 2000)
