/-!
# `core23` — the G\* gap core: 23 lattice addresses and their constraint graph

M40's structure hunt found that on the **G\* band** — triangular-lattice cell scales
`p` with `3/16 < p² < 3/13` — the constraint graph of the cell family (join two lattice
addresses when their cells contain a pair of plane points one unit apart) forces SEVEN
colours while its clique number is only FOUR. The forcing has a 23-vertex 1-minimal
carrier, found by SAT shrinking with per-member necessity witnesses
(`build/m40-chiomega.json`, `cores[0]`; the M40 census instrument is `tools/celllat.py`).

This module holds the carrier's **data**: the 23 addresses, and the constraint edges
**derived from them by one definition** — pairs whose address difference has hexagonal
norm in `{3, 4, 7, 9}`, the G\* band's constraint set (its rational threshold table is
M40 §0a; the same four norms drive `Coset.no_coset_seven_on_gap`). The edge list is
computed, never transcribed, so a transcription bug in 143 pairs is not a failure mode
this module can have: the addresses plus the one-line norm test are the whole input, and
everything downstream — the CNF the solver refuted, the clause table the kernel checks,
the plane corollary's geometry — is re-derived from them inside Lean.

No imports: everything here is core Lean (`Fin`, `List`, `Int`), so the certificate
modules under `Core23/Cnf/` sit downstream of nothing editable except this file and the
settled `Sat/` layer.
-/

namespace HadwigerNelson

namespace Core23

-- The derived edge list is 143 entries computed from 529 candidate pairs, and every guard
-- below walks it; the default elaborator recursion budget is what runs out first.
set_option maxRecDepth 8000

/-- The address table over `ℕ`, because core Lean's match compiler cannot close a
`Fin 23` numeral match without Mathlib. The catch-all is outside `pt`'s domain and
unreachable through it. -/
def ptN : Nat → Int × Int
  | 0  => (-2, 0)  | 1  => (-2, 2)  | 2  => (-1, 0)  | 3  => (-1, 1)
  | 4  => (-1, 2)  | 5  => (-1, 3)  | 6  => (0, -2)  | 7  => (0, -1)
  | 8  => (0, 0)   | 9  => (0, 1)   | 10 => (0, 2)   | 11 => (1, -2)
  | 12 => (1, -1)  | 13 => (1, 0)   | 14 => (1, 1)   | 15 => (1, 2)
  | 16 => (2, -3)  | 17 => (2, -2)  | 18 => (2, -1)  | 19 => (2, 0)
  | 20 => (2, 1)   | 21 => (3, -2)  | 22 => (3, -1)  | _  => (0, 0)

/-- The 23 lattice addresses of the G\* core, in the artifact's order
(`build/m40-chiomega.json`, `cores[0]`). Coordinates are Eisenstein: address `(a, b)`
is the lattice point `p·(a + b·ζ₆)`. -/
def pt (i : Fin 23) : Int × Int := ptN i.val

/-- The integral hexagonal norm of the offset from `u` to `v`:
`Q(v−u) = (v−u).1² + (v−u).1·(v−u).2 + (v−u).2²`. Componentwise so this module needs no
imports; the assembly (`Instances/Core23.lean`) pins its agreement with `Coset.hexQi`
by `decide`. -/
def qd (u v : Int × Int) : Int :=
  (v.1 - u.1) ^ 2 + (v.1 - u.1) * (v.2 - u.2) + (v.2 - u.2) ^ 2

/-- The G\* band's constraint norms: on `3/16 < p² < 3/13` two cells hold a unit pair
exactly when their address offset has norm 3, 4, 7 or 9. -/
def norms : List Int := [3, 4, 7, 9]

/-- **The constraint graph's edges, derived.** All pairs `(i, j)` with `i < j` whose
address difference has norm in `{3, 4, 7, 9}`. This is the definition of the G\* band's
constraint graph restricted to the core — the list is computed from `pt` and `qd`, so
the graph the certificate refutes is the constraint graph *by construction*. -/
def edges : List (Fin 23 × Fin 23) :=
  (List.finRange 23).flatMap fun i =>
    ((List.finRange 23).filter fun j => decide (i < j) && norms.contains (qd (pt i) (pt j))).map
      fun j => (i, j)

/-- The derived edge count, pinned: 143 (the M40 census's count for this core). -/
example : edges.length = 143 := by decide

/-- Every edge is `i < j` — the orientation invariant the CNF layer and the assembly's
completeness decide both rely on. -/
example : edges.all (fun e => decide (e.1 < e.2)) = true := by decide

/-- The four ports: a 4-clique of the core (`ω = 4` — the graph's largest, which is the
whole point: seven is forced two colours above any clique bound). Pinning its colours is
the palette-symmetry lever the certificate uses. -/
def ports : Fin 4 → Fin 23
  | 0 => 0 | 1 => 1 | 2 => 7 | 3 => 9

/-- The ports really are pairwise adjacent (all six pairs are derived edges). -/
example :
    [((0 : Fin 23), (1 : Fin 23)), (0, 7), (0, 9), (1, 7), (1, 9), (7, 9)].all
      (fun e => edges.contains e) = true := by decide

end Core23

end HadwigerNelson
