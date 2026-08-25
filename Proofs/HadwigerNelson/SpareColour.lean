import Proofs.HadwigerNelson.Fan

/-! # The spare-colour lemma — no pair compulsion below the chromatic number

A `k`-colourable graph admits no pair compulsion of either polarity at `k + 1` colours: lift a
`k`-colouring along `Fin.castSucc` and recolour one endpoint to the spare colour `Fin.last k` to
kill a forced-equal pair, or both endpoints to kill a forced-distinct pair (proper exactly when
the endpoints are non-adjacent — the load-bearing hypothesis, see the `K₂` example below).

Minted at M51 (adopted at the M50 close, `plans/M50-batch-descent.md` §Sⁱᵛ-adv) for three
consumers:

* **The phase monitor** (`Forces.not_colorable`): the descent's carrier at μ = 0 — a pure
  unit-distance graph forcing its pair equal at five colours — is not 4-colourable, so the
  campaign's χ(unit-part) column must cross 4 → 5 no later than the final commit, and the
  crossing commit mints a new 5-chromatic unit-distance witness.
* **The gadget hard floor** (`Separated.not_colorable`): every virtual-edge gadget at five
  colours is itself a ≥ 5-chromatic unit-distance graph — the floor under any gadget hunt
  (`plans/M52-nominated-gadgets.md`), G25's "each level's kill is the previous level's forcer"
  at the pair level.
* **The retro-explanation**: every pair-meter zero ever measured on 4-colourable material at
  five colours (M31's flat table, M32's stacks, the hexagram chunks) was a theorem, never a
  finding. Scope: pair level only — class pigeonholes are untouched by the spare colour.

The hypothesis asymmetry is derived, not chosen: the forced-equal half needs `p ≠ q` (at `p = q`
the compulsion is trivially true), while the forced-distinct half needs no such hypothesis (at
`p = q` it already fails whenever any colouring exists) and needs non-adjacency instead.
-/

namespace HadwigerNelson

variable {V : Type*} {G : SimpleGraph V} {k : ℕ} {p q : V}

/-- Lift a colouring along `Fin.castSucc` and recolour the points of `S` to the spare colour
`Fin.last k`. Proper whenever `S` is an independent set — used here at `S = {p}` and at
`S = {p, q}` with `p, q` non-adjacent. -/
private def spareRecolor (C : G.Coloring (Fin k)) (S : Set V) [DecidablePred (· ∈ S)] :
    V → Fin (k + 1) :=
  fun v => if v ∈ S then Fin.last k else (C v).castSucc

private theorem spareRecolor_valid (C : G.Coloring (Fin k)) (S : Set V)
    [DecidablePred (· ∈ S)] (hS : ∀ {v w : V}, v ∈ S → w ∈ S → ¬ G.Adj v w) :
    ∀ {v w : V}, G.Adj v w → spareRecolor C S v ≠ spareRecolor C S w := by
  intro v w hvw
  unfold spareRecolor
  by_cases hv : v ∈ S <;> by_cases hw : w ∈ S
  · exact absurd hvw (hS hv hw)
  · rw [if_pos hv, if_neg hw]
    exact ((C w).castSucc_lt_last).ne'
  · rw [if_neg hv, if_pos hw]
    exact ((C v).castSucc_lt_last).ne
  · rw [if_neg hv, if_neg hw]
    exact fun h => C.valid hvw (Fin.castSucc_injective k h)

/-- **The spare-colour lemma, forced-equal polarity.** A `k`-colourable graph forces no pair
equal at `k + 1` colours: recolour one endpoint to the spare colour. -/
theorem not_forces_of_colorable (hG : G.Colorable k) (hpq : p ≠ q) :
    ¬ Forces G (k + 1) p q := by
  obtain ⟨C⟩ := hG
  intro h
  classical
  have hval : ∀ {v w : V}, G.Adj v w → spareRecolor C {p} v ≠ spareRecolor C {p} w :=
    spareRecolor_valid C {p} (by
      intro v w hv hw hvw
      rw [Set.mem_singleton_iff] at hv hw
      subst hv; subst hw
      exact G.irrefl hvw)
  have h2 : spareRecolor C {p} p = spareRecolor C {p} q :=
    h (SimpleGraph.Coloring.mk _ hval)
  have hp' : spareRecolor C {p} p = Fin.last k := by simp [spareRecolor]
  have hq' : spareRecolor C {p} q = (C q).castSucc := by simp [spareRecolor, hpq.symm]
  rw [hp', hq'] at h2
  exact ((C q).castSucc_lt_last).ne' h2

/-- **The spare-colour lemma, forced-distinct polarity.** A `k`-colourable graph forces no
non-adjacent pair distinct at `k + 1` colours: recolour both endpoints to the spare colour —
proper exactly because they are non-adjacent. No `p ≠ q` hypothesis: at `p = q` the compulsion
already fails whenever any colouring exists. -/
theorem not_separated_of_colorable (hG : G.Colorable k) (hadj : ¬ G.Adj p q) :
    ¬ Separated G (k + 1) p q := by
  obtain ⟨C⟩ := hG
  intro h
  classical
  have hval : ∀ {v w : V}, G.Adj v w → spareRecolor C {p, q} v ≠ spareRecolor C {p, q} w :=
    spareRecolor_valid C {p, q} (by
      intro v w hv hw hvw
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hv hw
      rcases hv with rfl | rfl <;> rcases hw with rfl | rfl
      · exact G.irrefl hvw
      · exact hadj hvw
      · exact hadj hvw.symm
      · exact G.irrefl hvw)
  have hp' : spareRecolor C {p, q} p = Fin.last k := by simp [spareRecolor]
  have hq' : spareRecolor C {p, q} q = Fin.last k := by simp [spareRecolor]
  exact h (SimpleGraph.Coloring.mk _ hval) (by
    show spareRecolor C {p, q} p = spareRecolor C {p, q} q
    rw [hp', hq'])

/-- **The phase monitor's theorem.** A graph forcing a pair equal at `k + 1` colours is not
`k`-colourable — at `k = 4`: the descent's carrier at μ = 0 is a 5-chromatic unit-distance
graph, so the χ(unit-part) monitor crosses no later than the final commit, and the crossing
commit mints a new witness. -/
theorem Forces.not_colorable (h : Forces G (k + 1) p q) (hpq : p ≠ q) : ¬ G.Colorable k :=
  fun hG => not_forces_of_colorable hG hpq h

/-- **The gadget hard floor.** A graph forcing a non-adjacent pair distinct at `k + 1` colours
is not `k`-colourable — every virtual-edge gadget at five colours is itself ≥ 5-chromatic. -/
theorem Separated.not_colorable (h : Separated G (k + 1) p q) (hadj : ¬ G.Adj p q) :
    ¬ G.Colorable k :=
  fun hG => not_separated_of_colorable hG hadj h

/-! ## Spec examples

The empty graph on two points is 1-colourable, so it compels nothing at two colours; the
literal-instantiation examples pin the `k + 1 =?= 5` unification a caller relies on; and the
`K₂` example is the mutation audit's red stated positively — an ADJACENT pair is separated by
properness itself, which is exactly why `Separated.not_colorable` must demand non-adjacency
(dropping `hadj` would prove `K₂` not-2-colourable, which is false). -/

private def botColoring : (⊥ : SimpleGraph (Fin 2)).Coloring (Fin 1) :=
  SimpleGraph.Coloring.mk (fun _ => 0) (fun h => h.elim)

example : ¬ Forces (⊥ : SimpleGraph (Fin 2)) 2 0 1 :=
  not_forces_of_colorable ⟨botColoring⟩ (by decide)

example : ¬ Separated (⊥ : SimpleGraph (Fin 2)) 2 0 1 :=
  not_separated_of_colorable ⟨botColoring⟩ (by simp)

/-- The red, positive form: `K₂`'s adjacent pair IS separated at any colour count — properness
itself separates neighbours — so the non-adjacency hypothesis of `Separated.not_colorable` is
load-bearing (`K₂` is 2-colourable, and dropping `hadj` would refute that). -/
example : Separated (⊤ : SimpleGraph (Fin 2)) 3 0 1 :=
  fun C => C.valid (by simp)

/-- The literal-unification pin: a caller holding `Forces G 5 p q` closes `¬ Colorable 4`
through `k + 1 =?= 5` without annotation. -/
example (h : Forces G 5 p q) (hpq : p ≠ q) : ¬ G.Colorable 4 := h.not_colorable hpq

example (h : Separated G 5 p q) (hadj : ¬ G.Adj p q) : ¬ G.Colorable 4 :=
  h.not_colorable hadj

end HadwigerNelson
