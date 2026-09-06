import Proofs.HadwigerNelson.SpareColour
import Mathlib.Combinatorics.Pigeonhole

set_option autoImplicit false

/-! # The entropy floor — a colourable graph has exponentially many colourings one colour up

If `G` on `n` vertices is `k`-colourable then it has at least `2 ^ ⌈n / k⌉` proper
`(k + 1)`-colourings: fix a `k`-colouring, let `F` be its largest class (`|F| ≥ ⌈n / k⌉` by
pigeonhole), and send each subset `S ⊆ F` to the colouring that recolours `S` to the spare colour
`Fin.last k`. Every subset of a colour class is independent, so the recolouring is proper
(`spareRecolor_valid`), and `S` is recoverable as the preimage of the spare colour, so the map is
injective — `2 ^ |F|` distinct colourings.

Minted at M51 (K4 of `plans/STANDING-QUESTIONS.md`), as the generator screen for 5-tight fabric:
a region whose 5-colouring count falls below the floor is not 4-colourable. **Scope, learned at
the M50 adversarial pass: the contrapositive is about the SAME graph** — counting one graph's
colourings says nothing about its unit part (the seed has 35 classes up to palette and a
4-chromatic unit part). The statement is phrased over `Fintype.card (G.Coloring (Fin (k + 1)))`,
raw colourings with no palette quotient; dividing by `(k + 1)!` is the consumer's business.
-/

namespace HadwigerNelson

open Finset

variable {V : Type*} [Fintype V] [DecidableEq V] {G : SimpleGraph V} {k : ℕ}

/-- Recolour the points of `S` to the spare colour `Fin.last k`; everything else lifts along
`Fin.castSucc`. (The raw function of `SpareColour.lean`, restated here because that file keeps it
private; the consolidation waits for a quiet build.) -/
def spareOn (C : G.Coloring (Fin k)) (S : Finset V) : V → Fin (k + 1) :=
  fun v => if v ∈ S then Fin.last k else (C v).castSucc

omit [Fintype V] in
theorem spareOn_valid (C : G.Coloring (Fin k)) (S : Finset V)
    (hS : ∀ {v w : V}, v ∈ S → w ∈ S → ¬ G.Adj v w) :
    ∀ {v w : V}, G.Adj v w → spareOn C S v ≠ spareOn C S w := by
  intro v w hvw
  unfold spareOn
  by_cases hv : v ∈ S <;> by_cases hw : w ∈ S
  · exact absurd hvw (hS hv hw)
  · rw [if_pos hv, if_neg hw]
    exact ((C w).castSucc_lt_last).ne'
  · rw [if_neg hv, if_pos hw]
    exact ((C v).castSucc_lt_last).ne
  · rw [if_neg hv, if_neg hw]
    exact fun h => C.valid hvw (Fin.castSucc_injective k h)

/-- The subsets of one colour class of `C`, each sent to the colouring that wears the spare colour
exactly on that subset. -/
def spareColorings (C : G.Coloring (Fin k)) (y : Fin k) (S : Finset V)
    (hS : S ⊆ univ.filter (fun v => C v = y)) : G.Coloring (Fin (k + 1)) :=
  SimpleGraph.Coloring.mk (spareOn C S) (spareOn_valid C S (fun hv hw hadj =>
    C.valid hadj (((mem_filter.1 (hS hv)).2).trans ((mem_filter.1 (hS hw)).2).symm)))

/-- The spare colour marks exactly the recoloured subset. -/
theorem spareColorings_eq_last_iff (C : G.Coloring (Fin k)) (y : Fin k) (S : Finset V)
    (hS : S ⊆ univ.filter (fun v => C v = y)) (v : V) :
    spareColorings C y S hS v = Fin.last k ↔ v ∈ S := by
  show spareOn C S v = Fin.last k ↔ v ∈ S
  unfold spareOn
  by_cases hv : v ∈ S
  · simp [hv]
  · simp only [hv, if_false, iff_false]
    exact ((C v).castSucc_lt_last).ne

/-- **The entropy floor.** A `k`-colourable graph on a finite vertex type with `k * n ≤ |V|` has at
least `2 ^ n` proper `(k + 1)`-colourings. The hypothesis `0 < k` is exact: at `k = 0` the graph
is empty, `k * n ≤ |V|` holds for every `n`, and there is exactly one `1`-colouring. -/
theorem two_pow_le_card_coloring (hG : G.Colorable k) (hk : 0 < k) (n : ℕ)
    (hn : k * n ≤ Fintype.card V) :
    2 ^ n ≤ Fintype.card (G.Coloring (Fin (k + 1))) := by
  obtain ⟨C⟩ := hG
  haveI : Nonempty (Fin k) := ⟨⟨0, hk⟩⟩
  obtain ⟨y, hy⟩ := Fintype.exists_le_card_fiber_of_mul_le_card (f := C) (n := n)
    (by simpa [Fintype.card_fin] using hn)
  set F : Finset V := univ.filter (fun v => C v = y) with hF
  let f : F.powerset → G.Coloring (Fin (k + 1)) :=
    fun S => spareColorings C y S.1 (mem_powerset.1 S.2)
  have hf : Function.Injective f := by
    intro S T h
    apply Subtype.ext
    ext v
    rw [← spareColorings_eq_last_iff C y S.1 (mem_powerset.1 S.2) v,
      ← spareColorings_eq_last_iff C y T.1 (mem_powerset.1 T.2) v]
    exact ⟨fun hv => (DFunLike.congr_fun h v) ▸ hv, fun hv => (DFunLike.congr_fun h v).symm ▸ hv⟩
  calc 2 ^ n ≤ 2 ^ F.card := Nat.pow_le_pow_right (by norm_num) hy
    _ = F.powerset.card := (card_powerset F).symm
    _ = Fintype.card F.powerset := (Fintype.card_coe _).symm
    _ ≤ Fintype.card (G.Coloring (Fin (k + 1))) := Fintype.card_le_of_injective f hf

/-- **The generator screen** (K4's consumer): fewer than `2 ^ n` proper `(k + 1)`-colourings with
`k * n ≤ |V|` means the graph is NOT `k`-colourable — for the SAME graph; never for a subgraph. -/
theorem not_colorable_of_card_coloring_lt (hk : 0 < k) (n : ℕ) (hn : k * n ≤ Fintype.card V)
    (hlt : Fintype.card (G.Coloring (Fin (k + 1))) < 2 ^ n) :
    ¬ G.Colorable k :=
  fun hG => absurd (two_pow_le_card_coloring hG hk n hn) (not_le.2 hlt)

/-- Spec: the edgeless graph on two vertices is `1`-colourable, so it has at least `2 ^ 1`
two-colourings (it has four). -/
example : 2 ^ 1 ≤ Fintype.card ((⊥ : SimpleGraph (Fin 2)).Coloring (Fin 2)) :=
  two_pow_le_card_coloring ⟨SimpleGraph.Coloring.mk (fun _ => (0 : Fin 1)) (fun h => by simp at h)⟩
    (by norm_num) 1 (by simp)

/-- Red control for the `0 < k` hypothesis: at `k = 0` the graph is empty and has exactly ONE
`1`-colouring, so `2 ^ 1 ≤ card` is false there — the theorem's hypothesis is what excludes it. -/
example : Fintype.card ((⊥ : SimpleGraph (Fin 0)).Coloring (Fin 1)) = 1 :=
  Fintype.card_eq_one_iff.2 ⟨SimpleGraph.Coloring.mk (fun _ => 0) (fun h => by simp at h),
    fun y => DFunLike.ext _ _ (fun v => v.elim0)⟩

end HadwigerNelson
