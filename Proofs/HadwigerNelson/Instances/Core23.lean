import Proofs.HadwigerNelson.Instances.Core23.Edges
import Proofs.HadwigerNelson.Instances.Core23.Cnf.Cert
import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.Coset

/-!
# χ(G\*) ≥ 7 — the gap forcing's first kernel theorem (M42)

M40 measured that on the **G\* band** — triangular-lattice cell scales with
`3/16 < p² < 3/13` — the cell family's constraint graph forces SEVEN colours while its
clique number is FOUR, and the forcing shrinks to a 23-vertex 1-minimal core. This module
takes that core to the kernel:

* **`core23_not_colorable_six`** — the 23-address constraint core admits no proper
  6-colouring. The graph is derived (`Core23/Edges.lean`), the refutation is a pinned
  solver certificate replayed by the kernel (`Core23/Cnf/`), and the palette symmetry is
  closed kernel-side by the `Gadget` algebra over the core's 4-clique — the M34 pattern.
* **`core23_colorable_seven`** — the control that must go red: seven colours DO suffice
  on the core, verified edge by edge, so the refutation is about six and not about the
  graph being uncolourable outright.
* **`Coset.seven_le_card_gap`** — the plane corollary, in the cell-constant vocabulary of
  M38: any colouring of the plane constant on the nearest-point cells of the triangular
  lattice at a G\*-band scale uses at least SEVEN colours.

Why this band is the one worth a certificate: on every other window the repository holds
(`Coset.seven_labels_of_cell_constant`, `eight_…`, `twelve_…`, `seven_…_shell4`,
`seven_…_fine`) the forcing is a **clique** and the counting is free. On the G\* band the
largest clique is FOUR — `mono_pair_of_clique` and every relaxation are structurally
unavailable (M40: certified Hoffman ≈ 4.1, χ_f ≤ 48/7), and the step to seven is
integrality. This is the cell family reproducing Hadwiger–Nelson's own pathology (ω low,
every relaxation low, χ high) in an object the kernel can check whole — and the first
kernel-checked `χ ≥ ω + 3` statement of the programme.

The certificate chain is self-guarding against data drift: the CNF the solver refuted,
the clause table `core23_agrees` compares, and the geometry `edge_norms` re-derives all
reduce to the same 23 addresses and one norm filter, so a moved address or an edited
norm list fails the build — it cannot produce a false theorem.
-/

namespace HadwigerNelson

namespace Core23

-- Every decide below walks the 143-entry derived edge list (529 candidate pairs upstream).
set_option maxRecDepth 8000

/-- **The geometry, re-derived against the house norm**: every derived edge joins two
DISTINCT addresses whose offset has `Coset.hexQi`-norm 3, 4, 7 or 9 — exactly the norms
`Coset.exists_unit_pair_of_window` realizes as unit distances on the G\* band (the same
four the coset-impossibility `Coset.no_coset_seven_on_gap` sweeps). This is the bridge
from the local `qd` filter to the sweep machinery, and it is decided, not trusted. -/
theorem edge_norms : ∀ e ∈ edges, pt e.1 ≠ pt e.2 ∧
    (Coset.hexQi (pt e.2 - pt e.1) = 3 ∨ Coset.hexQi (pt e.2 - pt e.1) = 4 ∨
      Coset.hexQi (pt e.2 - pt e.1) = 7 ∨ Coset.hexQi (pt e.2 - pt e.1) = 9) := by
  decide +kernel

/-- The six edges among the four ports: the pinned 4-clique, as gadgets. At `ω = 4` this
is the largest palette lever the graph owns — and the whole point of the theorem is that
it is three colours short of what the graph forces. -/
def portsClique : Gadget 6 23 4 edges ports :=
  (Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide) (by decide +kernel))).inter <|
    (Gadget.edge 0 2 (edgeGraph_adj_of_mem (by decide) (by decide +kernel))).inter <|
      (Gadget.edge 0 3 (edgeGraph_adj_of_mem (by decide) (by decide +kernel))).inter <|
        (Gadget.edge 1 2 (edgeGraph_adj_of_mem (by decide) (by decide +kernel))).inter <|
          (Gadget.edge 1 3 (edgeGraph_adj_of_mem (by decide) (by decide +kernel))).inter
            (Gadget.edge 2 3 (edgeGraph_adj_of_mem (by decide) (by decide +kernel)))

/-- **The solver's half**: with the clique's colours named, the formula is unsatisfiable.
The one leaf that needs a certificate; `core23_unsat` is its kernel replay. -/
theorem pinned_unsat :
    (coloringCNF 6 23 edges ++ cubeCNF 6 23 (pinCube ports ![0, 1, 2, 3])).Unsat := by
  have h : core23Cnf = coloringCNF 6 23 edges ++ cubeCNF 6 23 (pinCube ports ![0, 1, 2, 3]) := by
    simp only [core23Cnf, ports, pinCube]
    rfl
  exact h ▸ core23_unsat

/-- The gadgets composed: the certificate kills the all-distinct port pattern, the clique's
own edges kill the fourteen patterns with a repeat. -/
def gadgets : Gadget 6 23 4 edges ports :=
  (Gadget.ofUnsat ![0, 1, 2, 3] pinned_unsat).inter portsClique

/-! ### The control that must go red: seven colours DO suffice on the core -/

/-- A solver-found 7-colouring of the core, as a table over `ℕ` (`Fin` numeral matches
need Mathlib's match support; the catch-all is outside `colour`'s domain). Untrusted:
`colour_proper` verifies it edge by edge. -/
def colourN : Nat → Nat
  | 0  => 0 | 1  => 1 | 2  => 0 | 3  => 1 | 4  => 1 | 5  => 2 | 6  => 2 | 7  => 2
  | 8  => 3 | 9  => 3 | 10 => 4 | 11 => 2 | 12 => 5 | 13 => 3 | 14 => 4 | 15 => 0
  | 16 => 4 | 17 => 5 | 18 => 5 | 19 => 6 | 20 => 0 | 21 => 1 | 22 => 1 | _  => 0

/-- The colouring at the index type `Coloring` wants. -/
def colour (v : Fin 23) : Fin 7 := ⟨colourN v.val % 7, Nat.mod_lt _ (by decide)⟩

/-- **Seven colours are used** — so the control below really is about seven, not a
narrower colouring wearing a wider type. -/
example : (List.range 23).any (fun v => decide (colourN v = 6)) = true := by decide

/-- **The colouring is proper**, checked edge by edge in the kernel. -/
theorem colour_proper : edges.all (fun e => decide (colour e.1 ≠ colour e.2)) = true := by
  decide +kernel

end Core23

-- The `fail` branch is unreachable *when the gadgets refute*, which is when the linter runs.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **The G\* core admits no proper 6-colouring.** 23 vertices, 143 derived edges,
clique number four — and no 6-colouring. Kernel-checked through the same route as every
witness here: a solver certificate re-checked by `Sat/MaskCheck.lean`, CaDiCaL trusted
for nothing, palette symmetry closed by the `Gadget` algebra. -/
theorem core23_not_colorable_six :
    ¬ (edgeGraph 23 Core23.edges).Colorable 6 :=
  not_colorable_of_gadget Core23.gadgets (by
    first
      | decide +kernel
      | fail "Core23.gadgets admits a port colouring, so the core is not refuted. What \
              survives is `Core23.gadgets.survivors` — one entry per colour-partition of \
              the four ports, each a list of (vertex, colour) pins. Print it with, inside \
              `namespace HadwigerNelson`,  #eval Core23.gadgets.survivors")

/-- **The control that must go red: seven colours suffice on the core.** Without it, a
"six" that was silently a "five" — or a derived edge list that had accidentally become
uncolourable at every count — would read exactly like a success. Together with
`core23_not_colorable_six` this pins χ(core) = 7 exactly, two colours above any clique
argument's ceiling here. -/
theorem core23_colorable_seven :
    (edgeGraph 23 Core23.edges).Colorable 7 :=
  ⟨SimpleGraph.Coloring.mk Core23.colour fun {v w} h => by
    have hall := List.all_eq_true.mp Core23.colour_proper
    rcases h.2 with hm | hm
    · exact of_decide_eq_true (hall _ hm)
    · exact (of_decide_eq_true (hall _ hm)).symm⟩

namespace Coset

variable {p : ℝ} {rnd : ℂ → ℤ × ℤ}

/-- **Seven colours on the G\* band, without a clique** (`3/16 < p² < 3/13`): any
colouring of the plane constant on the nearest-point cells of the triangular lattice at
a G\*-band scale uses at least SEVEN colours — while the constraint graph's clique number
there is FOUR, so no seven-point rainbow exists and the count routes through the
23-address core's refutation instead of through pairwise-distinct labels.

The fourth member of the window family (`seven_le_card_of_cell_constant`,
`twelve_le_card_of_cell_constant`, `seven_le_card_shell4`) and the one that needed a
certificate: M40's gap law (`ω = 4`, `χ = 7`, the step to seven carried by integrality),
kernel side. With `no_coset_seven_on_gap` the band's story is complete: seven colours
are forced, and no lattice-coset scheme can deliver them. -/
theorem seven_le_card_gap {A : Type*} [Fintype A] (hp : 3 / 16 < p ^ 2)
    (hp1 : p ^ 2 < 3 / 13) (hppos : 0 < p)
    (hrnd : ∀ (x : ℂ) (v : ℤ × ℤ), dist x (latt p (rnd x)) ≤ dist x (latt p v))
    (col : (ℤ × ℤ) → A)
    (hproper : ∀ x y : ℂ, dist x y = 1 → col (rnd x) ≠ col (rnd y)) :
    7 ≤ Fintype.card A := by
  by_contra hcard
  have hle : Fintype.card A ≤ 6 := by omega
  have hp1' : p < 1 := by nlinarith
  -- every derived edge of the core is realized as a unit pair between its two cells,
  -- so the cell labels are proper on the core's constraint graph
  have hedge : ∀ e ∈ Core23.edges, col (Core23.pt e.1) ≠ col (Core23.pt e.2) := by
    intro e he hc
    obtain ⟨hne, hQ⟩ := Core23.edge_norms e he
    obtain ⟨x, y, hxy, hx, hy⟩ := exists_unit_pair_of_window (u := Core23.pt e.1)
      (v := Core23.pt e.2) hppos hp1' hrnd hne
      (by rcases hQ with h | h | h | h <;> rw [h] <;> push_cast <;> nlinarith)
      (by rcases hQ with h | h | h | h <;> rw [h] <;> push_cast <;> nlinarith)
    exact hproper x y hxy (by rw [hx, hy]; exact hc)
  -- at most six labels means a 6-colouring of the core, which the certificate refuses
  have e6 := Fintype.equivFin A
  have hvalid : ∀ {i j : Fin 23}, (edgeGraph 23 Core23.edges).Adj i j →
      Fin.castLE hle (e6 (col (Core23.pt i))) ≠ Fin.castLE hle (e6 (col (Core23.pt j))) := by
    rintro i j ⟨hne', hm | hm⟩ hcc
    · exact hedge _ hm (e6.injective (Fin.castLE_injective hle hcc))
    · exact hedge _ hm (e6.injective (Fin.castLE_injective hle hcc)).symm
  exact core23_not_colorable_six
    ⟨SimpleGraph.Coloring.mk (fun i => Fin.castLE hle (e6 (col (Core23.pt i)))) hvalid⟩

end Coset

end HadwigerNelson
