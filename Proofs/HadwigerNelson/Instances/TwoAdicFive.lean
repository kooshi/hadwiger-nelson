import Proofs.HadwigerNelson.Instances.TwoAdicFour
import Proofs.HadwigerNelson.Instances.TwoAdicFive.Cnf.Cert
import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.FanGap

/-!
# Level five of the 2-adic tower forces exactly the kernel of the level map

`P₅ = Cay(O/𝔓⁵, S₅)`, 1,024 vertices, degree 48. **The 2-adic law at its threshold, both halves in the kernel:**

* **Forcing.** `P₅ + edge (0, δ)` with `δ = ((4, 0), (0, 0))` — one of the three nonzero elements of `𝔓⁴/𝔓⁵`, the
  kernel of the level map — is not 4-colourable: a CaDiCaL refutation (`data/fs38/lrat/`, 1,339 LRAT lines, of which
  **182** survive backward trimming) replayed step by step by the kernel through the M05 pipeline. The three depth-4
  elements are one orbit under multiplication by `ω` (`twoAdicOmegaHom`, `Forces.map`), so one refusal covers all
  three.
* **Freedom.** A difference outside the kernel maps to a nonzero difference of `P₄`, which some table of
  `Instances/TwoAdicFour.lean` separates; the pullback along `twoAdicLevelHom 3 : P₅ →g P₄` separates it at level
  five.

So `Forces (twoAdicPlane 5) 4 0 d ↔ twoAdicLevelMap 4 d = 0`. Corollary: no 4-colouring of any level `≤ 5` has a gap
(a gap would pull up to level five and make it slack, hence pairwise free). **The solver-dependent surface is exactly one
declaration**, `twoAdicFive_not_colorable_with_edge`; `twoAdicFive_forces_delta` is a one-liner from it (a colouring with
`C 0 ≠ C δ` is a colouring of `P₅ ⊔ edge`). **[hand 1]** identifies `twoAdicPlane 5`
with `Cay(O/𝔓⁵, S₅)`; **[hand 2]** would draw a K-certificate into it; neither is kernel (FS-38 §S3).
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-- **A 4-colouring of `P₅`** — level four's first table pulled back along the level map. Nothing in the argument
uses it; it is the inhabitant that keeps the `Forces` statements below from being a `∀` over an empty domain
(`scripts/vacuity.sh`), and it is why "forced" here means *every* colouring agrees rather than *no colouring
exists*. -/
def twoAdicFiveColouring : (twoAdicPlane 5).Coloring (Fin 4) :=
  (SimpleGraph.Coloring.mk twoAdicFourCol₁
    (twoAdicFourTables_proper twoAdicFourCol₁ (by simp [twoAdicFourTables]))).comap (twoAdicLevelHom 3)

/-- The representative depth-4 difference `4 ∈ 𝔓⁴/𝔓⁵` (`4 = π⁴·unit`). -/
def twoAdicFiveDelta : TwoAdicLevel 5 := ((4, 0), (0, 0))

theorem twoAdicFiveDelta_mem_ker : twoAdicLevelMap 4 twoAdicFiveDelta = 0 := by
  decide +kernel

theorem twoAdicFiveDelta_ne_zero : twoAdicFiveDelta ≠ 0 := by decide

/-- The kernel of the level map is `{0, δ, ωδ, ω²δ}`. -/
theorem twoAdicFive_ker_eq {d : TwoAdicLevel 5} (hd : twoAdicLevelMap 4 d = 0) :
    d = 0 ∨ d = twoAdicFiveDelta ∨ d = twoAdicOmega 5 twoAdicFiveDelta ∨
      d = twoAdicOmega 5 (twoAdicOmega 5 twoAdicFiveDelta) := by
  revert hd; revert d; decide +kernel

/-! ### The certificate, and what the kernel re-derives from it

`Instances/TwoAdicFive/Edges.lean` carries the 778 index pairs the refutation actually uses — 125 of `P₅`'s 1,024
vertices — and `Cnf/` a clause table with a CaDiCaL refutation of the formula they generate. **A subgraph that
refuses refutes every graph it maps into**, which is why the kernel is never shown the whole 24,576-edge level: the
full instance's clause table cost 853 s at a 33 GB peak, and this one is 3,240 clauses against 99,335.

Neither the list nor the table is trusted. Below, the kernel checks that **every listed pair really is an edge** of
`P₅`, or else is the added pair `(0, δ)`, under the generator's own indexing — and the pipeline checks that the
clause table holds that list's formula (`twoAdicFive_agrees`) and that every derivation step propagates
(`twoAdicFive_unsat`). A wrong edge, a wrong table or a wrong certificate fails one of those checks; by
`Sat/Encoding.lean`'s one-directional correspondence none of them can make this theorem false.
-/

/-- The generator's indexing of the full level, `j ↦ ((a, b), (c, d))` for `j = 128a + 16b + 4c + d`. -/
def twoAdicFiveDecode (j : Fin 1024) : TwoAdicLevel 5 :=
  (((j.val / 128 : ℕ), ((j.val / 16) % 8 : ℕ)), (((j.val / 4) % 4 : ℕ), (j.val % 4 : ℕ)))

/-- Where the certificate's 125 vertices sit in the level. Neither injectivity nor surjectivity is needed below —
only that listed pairs go to edges. -/
def twoAdicFiveVert (i : Fin 125) : TwoAdicLevel 5 := twoAdicFiveDecode (twoAdicFiveCoreIdx i)

/-- The origin and `δ` are the added pair's two ends, at core indices `0` and `67`. -/
example : twoAdicFiveVert 0 = 0 := by decide
example : twoAdicFiveVert 67 = twoAdicFiveDelta := by decide

/-- The per-pair check as a **`Bool`**: the difference lies on the circle and the ends differ, or the pair is the
added one. Stated as a `Bool` and discharged through `List.all` **on a measurement**: `decide +kernel` on the
`∀ e ∈ list, …` form of the very same claim costs **32.9 GB and does not finish**, while this costs **3.5 GB and
5 s** — and the blowup is in the `∀ x ∈ l` decision procedure itself, not in this data (the same measurement holds
for `∀ e ∈ l, e.1 ≠ e.2` on a bare import). -/
def twoAdicFiveEdgeOk (e : Fin 125 × Fin 125) : Bool :=
  ((normForm 5 (-twoAdicFiveVert e.1 + twoAdicFiveVert e.2) == (1, 0)) &&
      (!(twoAdicFiveVert e.1 == twoAdicFiveVert e.2))) ||
    ((twoAdicFiveVert e.1 == 0) && (twoAdicFiveVert e.2 == twoAdicFiveDelta))

/-- **Every listed pair passes the check** — 778 pairs, each evaluating the norm form once. -/
theorem twoAdicFiveEdges_all_ok : twoAdicFiveEdges.all twoAdicFiveEdgeOk = true := by decide +kernel

/-- **Every listed pair is an edge of `P₅`, or else is the added pair `(0, δ)`.** This is the check that the
certificate is about the object named: the indexing is the generator's, and a disagreement about it would leave
almost every listed pair a non-edge. -/
theorem twoAdicFiveEdges_adj {a b : Fin 125} (h : (a, b) ∈ twoAdicFiveEdges) :
    (twoAdicPlane 5).Adj (twoAdicFiveVert a) (twoAdicFiveVert b) ∨
      (twoAdicFiveVert a = 0 ∧ twoAdicFiveVert b = twoAdicFiveDelta) := by
  have hb := List.all_eq_true.mp twoAdicFiveEdges_all_ok (a, b) h
  simp only [twoAdicFiveEdgeOk, Bool.or_eq_true, Bool.and_eq_true, beq_iff_eq, Bool.not_eq_eq_eq_not,
    Bool.not_true, beq_eq_false_iff_ne, ne_eq] at hb
  rcases hb with ⟨hcirc, hne⟩ | ⟨h0, h1⟩
  · refine Or.inl ?_
    rw [twoAdicPlane, addCayley_adj]
    exact ⟨hne, Or.inl hcirc⟩
  · exact Or.inr ⟨h0, h1⟩

/-- **The listed graph maps into `P₅` with the edge added.** -/
def twoAdicFiveHom :
    edgeGraph 125 twoAdicFiveEdges →g
      ((twoAdicPlane 5) ⊔ SimpleGraph.fromEdgeSet {s(0, twoAdicFiveDelta)}) where
  toFun := twoAdicFiveVert
  map_rel' := by
    have key : ∀ {a b : Fin 125}, (a, b) ∈ twoAdicFiveEdges →
        ((twoAdicPlane 5) ⊔ SimpleGraph.fromEdgeSet {s(0, twoAdicFiveDelta)}).Adj
          (twoAdicFiveVert a) (twoAdicFiveVert b) := by
      intro a b hab
      rcases twoAdicFiveEdges_adj hab with h | ⟨h0, h1⟩
      · exact (SimpleGraph.sup_adj _ _ _ _).mpr (Or.inl h)
      · refine (SimpleGraph.sup_adj _ _ _ _).mpr (Or.inr ?_)
        rw [h0, h1, SimpleGraph.fromEdgeSet_adj]
        exact ⟨rfl, fun he => twoAdicFiveDelta_ne_zero he.symm⟩
    intro i j hij
    rcases hij.2 with h | h
    · exact key h
    · exact (key h).symm

/-- The triangle whose colours the certificate names: three pairwise adjacent vertices of `P₅` through the origin. -/
def twoAdicFivePorts : Fin 3 → Fin 125 := ![0, 1, 17]

/-- The certificate was filed against the cube pinning that triangle to `0, 1, 2`. -/
private theorem twoAdicFive_pinCube : pinCube twoAdicFivePorts ![0, 1, 2] = twoAdicFiveCube := by decide

/-- **The refutation**: no proper 4-colouring gives the three ports three different colours. One certificate covers
all `4! = 24` relabellings, by colour symmetry. -/
def twoAdicFiveRefuted : Gadget 4 125 3 twoAdicFiveEdges twoAdicFivePorts :=
  Gadget.ofUnsat ![0, 1, 2] (by rw [twoAdicFive_pinCube]; exact twoAdicFive_unsat)

/-- **The triangle**: its three edges, each forbidding its ends from agreeing. Pinning three colours is sound only
because these three vertices are pairwise adjacent, and this is where that is checked — against the edge list, in
the kernel, not against the generator's own word for it. -/
def twoAdicFiveTriangle : Gadget 4 125 3 twoAdicFiveEdges twoAdicFivePorts :=
  (Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide)
      (List.mem_of_elem_eq_true (by decide +kernel)))).inter
    ((Gadget.edge 0 2 (edgeGraph_adj_of_mem (by decide)
        (List.mem_of_elem_eq_true (by decide +kernel)))).inter
      (Gadget.edge 1 2 (edgeGraph_adj_of_mem (by decide)
        (List.mem_of_elem_eq_true (by decide +kernel)))))

/-- The two constraints, composed. `#eval twoAdicFiveGadgets.survivors` when this stops refuting. -/
def twoAdicFiveGadgets : Gadget 4 125 3 twoAdicFiveEdges twoAdicFivePorts :=
  twoAdicFiveRefuted.inter twoAdicFiveTriangle

/-- **The listed graph has no 4-colouring** — the certificate and the triangle's own three edges leave no colouring
of the ports at all, decided over all 64. -/
theorem twoAdicFiveEdgeGraph_not_colorable : ¬ (edgeGraph 125 twoAdicFiveEdges).Colorable 4 :=
  not_colorable_of_gadget twoAdicFiveGadgets (by decide)

/-- **The refusal, kernel-checked**: `P₅` with the edge `(0, δ)` added has no 4-colouring. The solver-dependent
surface of this module is exactly this declaration, and what it rests on is an LRAT certificate the kernel replays
step by step — never the solver's word. -/
theorem twoAdicFive_not_colorable_with_edge :
    ¬ ((twoAdicPlane 5) ⊔ SimpleGraph.fromEdgeSet {s(0, twoAdicFiveDelta)}).Colorable 4 := by
  rintro ⟨C⟩
  exact twoAdicFiveEdgeGraph_not_colorable ⟨C.comap twoAdicFiveHom⟩

/-- **Level five forces the representative depth-4 difference.** -/
theorem twoAdicFive_forces_delta : Forces (twoAdicPlane 5) 4 0 twoAdicFiveDelta := by
  intro C
  by_contra hne
  refine twoAdicFive_not_colorable_with_edge ⟨SimpleGraph.Coloring.mk C ?_⟩
  intro u v huv
  rcases (SimpleGraph.sup_adj _ _ _ _).mp huv with h | h
  · exact C.valid h
  · rw [SimpleGraph.fromEdgeSet_adj, Set.mem_singleton_iff, Sym2.eq_iff] at h
    rcases h.1 with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · exact hne
    · exact fun he => hne he.symm

/-- The whole kernel is forced: the orbit under `ω` (`Forces.map` along `twoAdicOmegaHom 5`, which fixes `0`). -/
theorem twoAdicFive_forces_of_ker {d : TwoAdicLevel 5} (hd : twoAdicLevelMap 4 d = 0) :
    Forces (twoAdicPlane 5) 4 0 d := by
  have hz : twoAdicOmega 5 0 = 0 := map_zero _
  have h₁ := twoAdicFive_forces_delta.map (twoAdicOmegaHom 5)
  have h₂ := h₁.map (twoAdicOmegaHom 5)
  simp only [twoAdicOmegaHom_apply, hz] at h₁ h₂
  rcases twoAdicFive_ker_eq hd with rfl | rfl | rfl | rfl
  · exact fun _ => rfl
  · exact twoAdicFive_forces_delta
  · exact h₁
  · exact h₂

/-- Outside the kernel nothing is forced: `Forces.image` along `twoAdicLevelHom 3 : P₅ →g P₄` lands in level four,
which is pairwise free. -/
theorem twoAdicFive_not_forces_of_ne {d : TwoAdicLevel 5} (hd : twoAdicLevelMap 4 d ≠ 0) :
    ¬ Forces (twoAdicPlane 5) 4 0 d := by
  intro hF
  have := twoAdicFour_forces_iff.mp (hF.image (twoAdicLevelHom 3))
  simp only [twoAdicLevelHom_apply, map_zero] at this
  exact hd this.symm

/-- **The 2-adic law at level five**: forced at the origin iff the difference lies in `𝔓⁴`. -/
theorem twoAdicFive_forces_iff {d : TwoAdicLevel 5} :
    Forces (twoAdicPlane 5) 4 0 d ↔ twoAdicLevelMap 4 d = 0 :=
  ⟨fun hF => by by_contra hd; exact twoAdicFive_not_forces_of_ne hd hF, twoAdicFive_forces_of_ker⟩

/-- The same for every pair, by the Cayley reduction. -/
theorem twoAdicFive_forces_iff' {x y : TwoAdicLevel 5} :
    Forces (twoAdicPlane 5) 4 x y ↔ twoAdicLevelMap 4 (y - x) = 0 :=
  (forces_iff_forces_zero_sub (S := twoAdicCircle 5)).trans twoAdicFive_forces_iff

/-- **No gap at level five** — a forced pair forbids slackness (`Slack.forces_iff`). -/
theorem twoAdicFive_not_slack : ¬ Slack (twoAdicPlane 5) 4 := fun h =>
  twoAdicFiveDelta_ne_zero (h.forces_eq twoAdicFive_forces_delta).symm

/-- **No gap at level four either**: slackness pulls UP along the level hom `twoAdicLevelHom 3 : P₅ →g P₄`
(`Slack.of_hom`), and level five is not slack. One line; placed here, downstream of the LRAT, because that is its only
proof; the same chain reaches every level `≤ 5`. -/
theorem twoAdicFour_not_slack : ¬ Slack (twoAdicPlane 4) 4 := fun h =>
  twoAdicFive_not_slack (h.of_hom (twoAdicLevelHom 3))

end HadwigerNelson
