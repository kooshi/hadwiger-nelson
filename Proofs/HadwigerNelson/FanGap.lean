import Proofs.HadwigerNelson.ResidueObstruction
import Proofs.HadwigerNelson.CoverageMono
import Proofs.HadwigerNelson.PlaneRotation

/-!
# The fan gap: a free colour at the image kills every pair compulsion through it

A proper `k`-colouring `C` of a graph `P` has a **fan gap** at `v` when some colour `γ` is absent from the closed
neighbourhood of `v` — the reconfiguration literature's "`v` is not frozen in `C`" (`[BrewsterEtAl2020]`), and the
failure of the record's coverage at level `k − 1` (`CoverAtLeast P k v [] (k − 1)`, `CoverageMono.lean`).

**The theorem (FS-38, D0.2).** Let `f : G →g P` be a graph homomorphism and `C` a colouring of `P` with a gap `γ` at
`f u`. Then `u` is forced equal to no other vertex of `G` at `k` colours: if `C ∘ f` already separates `u` from `u'`
there is nothing to do, and otherwise **repainting `u` with `γ` inside `C ∘ f`** is proper — every neighbour of `u` lands
in `N(f u)`, where `γ` is absent — and separates them. The repaint over an independent set (`pullbackRepaint`) is the
one construction; its three uses are the pair (`not_forces_of_fanGap`), the fan (`not_fan_of_fanGap`: the arity-`k`
filter, which kills a fan exactly when every partner's image avoids the gap colour) and the **double repaint**
(`not_separated_of_sharedGap`: one colour absent from both closed neighbourhoods of the images of a non-edge
makes the non-edge coincide, so it is no virtual edge).

`Slack P k` (a gapped colouring at every vertex) and `Fusable P k v w` (a colouring coinciding at the pair or sharing a
gap at it) are **hereditary under homomorphisms into `P`** and, on a Cayley graph, follow from one gap by translation. Slackness alone makes every
graph mapping into `P` free of forced pairs (`Slack.forces_iff`) — so the record's forces-freeness hypothesis on the
plane at `11` (`finitePlane_forces_iff`, by the quarter turn) is not needed where a gap exists; it stays the theorem that
covers the gapless planes (`3` at three colours, the `2`-adic `K₄` at four). With every pair of the plane fusable — a
shared gap at the edges, M60's coincidences (`separated_iff_adj_of_coincides`) elsewhere — every virtual edge of every
graph mapping into the plane is an actual edge (`separated_iff_adj_of_fusable`).

**Consumers.** `unitQuadrance R` for any ring `R` with a homomorphism to a slack `unitQuadrance S`
(`Slack.unitQuadrance_of_ringHom`: the tower `ZMod (p ^ m)`, the completions `ℤ_[p]`, ramified integer rings), and the
certificates of M04 through `UDCert.drawingHom` (`UDCert.forces_eq_of_slack`). The instances live in
`Instances/FanGap11.lean`, `Instances/FanGap19.lean`. Nothing here is about rings, fields, or finiteness; nothing here
says a unit-distance graph over a number field is such a certificate (the hand step of M58/M60, row 57's gap).
-/

namespace HadwigerNelson

open SimpleGraph

variable {V W : Type*} {G : SimpleGraph V} {P : SimpleGraph W} {k : ℕ}

/-! ### The gap -/

/-- **A fan gap**: in the proper colouring `C` of `P`, colour `γ` is absent from the closed neighbourhood of `v` —
`v` is not frozen in `C`. Two conjuncts rather than a statement about `N[v]`, so `decide` reads it as `k` lookups on
`v` plus one per neighbour. -/
def FanGap (C : P.Coloring (Fin k)) (v : W) (γ : Fin k) : Prop :=
  γ ≠ C v ∧ ∀ w, P.Adj v w → C w ≠ γ

instance [Fintype W] [DecidableRel P.Adj] (C : P.Coloring (Fin k)) (v : W) (γ : Fin k) :
    Decidable (FanGap C v γ) :=
  inferInstanceAs (Decidable (γ ≠ C v ∧ ∀ w, P.Adj v w → C w ≠ γ))

/-- **Slack**: every vertex has a colouring with a gap there. -/
def Slack (P : SimpleGraph W) (k : ℕ) : Prop :=
  ∀ v, ∃ (C : P.Coloring (Fin k)) (γ : Fin k), FanGap C v γ

/-- **A shared gap**: one colour absent from both closed neighbourhoods `N[v]`, `N[w]` in one colouring. Decided on
a table, transported along automorphisms, consumed by the double repaint and by `Fusable`. -/
def SharedGap (C : P.Coloring (Fin k)) (v w : W) (γ : Fin k) : Prop :=
  FanGap C v γ ∧ FanGap C w γ

/-- **A fusable pair**: some colouring of `P` coincides at `v, w` or shares a gap at them. The one hypothesis the
virtual-edge theorem needs, per pair; it supplies its own colouring, so the `k = 0` corner needs no extra premise. On
the plane at `11` it is assembled by cases: non-adjacent or equal pairs coincide (M60's `finitePlane11_separated_iff`),
adjacent pairs share the gap of one table transported by translation and rotation. -/
def Fusable (P : SimpleGraph W) (k : ℕ) (v w : W) : Prop :=
  ∃ C : P.Coloring (Fin k), C v = C w ∨ ∃ γ : Fin k, SharedGap C v w γ

/-- **Pairwise fusable**: every pair is. The second hereditary property (`Slack` is the first); it kills virtual
non-edges as slackness kills forced pairs. -/
def PairwiseFusable (P : SimpleGraph W) (k : ℕ) : Prop := ∀ v w, Fusable P k v w

/-- **Gaps pull back** (the brief's A′): the neighbours of `u` map into the neighbours of `f u`. -/
theorem FanGap.comap (f : G →g P) {C : P.Coloring (Fin k)} {u : V} {γ : Fin k}
    (h : FanGap C (f u) γ) : FanGap (C.comap f) u γ :=
  ⟨h.1, fun w hw => h.2 (f w) (f.map_adj hw)⟩

/-- The bridge to the record's coverage vocabulary: a gap at `v` in some colouring is exactly the failure of
`CoverAtLeast P k v [] (k − 1)` — `C v` is never on `N(v)`, so the neighbourhood shows at most `k − 1` colours, and
shows fewer iff some other colour is missing. -/
theorem exists_fanGap_iff_not_coverAtLeast (v : W) :
    (∃ (C : P.Coloring (Fin k)) (γ : Fin k), FanGap C v γ) ↔ ¬ CoverAtLeast P k v [] (k - 1) := by
  constructor
  · rintro ⟨C, γ, hγ, hgap⟩ hcov
    -- Two distinct colours exist, so `2 ≤ k`.
    have hk : 2 ≤ k := by
      have h1 : (γ : ℕ) ≠ ((C v : Fin k) : ℕ) := fun hh => hγ (Fin.ext hh)
      have := γ.isLt
      have := (C v).isLt
      omega
    -- Neither `γ` nor `C v` is shown on `N(v)`.
    have hmem : ∀ c ∈ coverColors P v [] C, ∃ w, P.Adj v w ∧ C w = c := by
      intro c hc
      simp only [coverColors, Finset.mem_filter, Finset.mem_univ, true_and,
        List.not_mem_nil, or_false] at hc
      exact hc
    have h1 : γ ∉ coverColors P v [] C := by
      intro hc
      obtain ⟨w, hw, hcw⟩ := hmem _ hc
      exact hgap w hw hcw
    have h2 : (C v : Fin k) ∉ coverColors P v [] C := by
      intro hc
      obtain ⟨w, hw, hcw⟩ := hmem _ hc
      exact C.valid hw hcw.symm
    have h3 : γ ∉ insert (C v) (coverColors P v [] C) := by
      simp only [Finset.mem_insert, not_or]
      exact ⟨hγ, h1⟩
    have hcard : (insert γ (insert (C v) (coverColors P v [] C))).card
        = (coverColors P v [] C).card + 2 := by
      rw [Finset.card_insert_of_notMem h3, Finset.card_insert_of_notMem h2]
    have hle : (insert γ (insert (C v) (coverColors P v [] C))).card ≤ k := by
      simpa [Fintype.card_fin] using Finset.card_le_univ
        (insert γ (insert (C v) (coverColors P v [] C)))
    have := hcov C
    omega
  · intro h
    simp only [CoverAtLeast, not_forall, not_le] at h
    obtain ⟨C, hC⟩ := h
    have hlt : (insert (C v) (coverColors P v [] C)).card < k := by
      have := Finset.card_insert_le (C v) (coverColors P v [] C)
      omega
    have hex : ∃ γ : Fin k, γ ∉ insert (C v) (coverColors P v [] C) := by
      by_contra hall
      push Not at hall
      have huniv : insert (C v) (coverColors P v [] C) = Finset.univ :=
        Finset.eq_univ_iff_forall.mpr hall
      rw [huniv, Finset.card_univ, Fintype.card_fin] at hlt
      omega
    obtain ⟨γ, hγ⟩ := hex
    simp only [Finset.mem_insert, not_or] at hγ
    refine ⟨C, γ, hγ.1, fun w hw hcw => hγ.2 ?_⟩
    simp only [coverColors, Finset.mem_filter, Finset.mem_univ, true_and]
    exact ⟨w, Or.inl hw, hcw⟩

/-! ### The repaint -/

open Classical in
/-- **The repaint.** The pullback `C ∘ f`, overwritten with `γ` on an independent set `U` whose images all have `γ`
absent from their open neighbourhoods — Mathlib's `Set.piecewise`. Proper: an edge inside `U` is excluded by
independence; an edge `x ~ y` with `x ∈ U`, `y ∉ U` has `f y ∈ N(f x)`, where `γ` is absent; an edge off `U` is the
homomorphism. `γ ≠ C (f u)` is NOT needed here — only for the separations that consume it. -/
noncomputable def pullbackRepaint (f : G →g P) (C : P.Coloring (Fin k)) (U : Set V) (γ : Fin k)
    (hind : G.IsIndepSet U) (hgap : ∀ u ∈ U, ∀ w, P.Adj (f u) w → C w ≠ γ) : G.Coloring (Fin k) :=
  Coloring.mk (U.piecewise (fun _ => γ) (⇑C ∘ f)) (by
    intro x y hxy
    by_cases hx : x ∈ U
    · by_cases hy : y ∈ U
      · exact absurd hxy (hind hx hy (G.ne_of_adj hxy))
      · rw [Set.piecewise_eq_of_mem _ _ _ hx, Set.piecewise_eq_of_notMem _ _ _ hy]
        exact fun heq => hgap x hx (f y) (f.map_adj hxy) heq.symm
    · by_cases hy : y ∈ U
      · rw [Set.piecewise_eq_of_notMem _ _ _ hx, Set.piecewise_eq_of_mem _ _ _ hy]
        exact fun heq => hgap y hy (f x) (f.map_adj hxy.symm) heq
      · rw [Set.piecewise_eq_of_notMem _ _ _ hx, Set.piecewise_eq_of_notMem _ _ _ hy]
        exact C.valid (f.map_adj hxy))

open Classical in
theorem pullbackRepaint_apply_of_mem (f : G →g P) (C : P.Coloring (Fin k)) (U : Set V) (γ : Fin k)
    (hind : G.IsIndepSet U) (hgap : ∀ u ∈ U, ∀ w, P.Adj (f u) w → C w ≠ γ)
    {x : V} (hx : x ∈ U) : pullbackRepaint f C U γ hind hgap x = γ := by
  show U.piecewise (fun _ => γ) (⇑C ∘ f) x = γ
  exact Set.piecewise_eq_of_mem _ _ _ hx

open Classical in
theorem pullbackRepaint_apply_of_not_mem (f : G →g P) (C : P.Coloring (Fin k)) (U : Set V) (γ : Fin k)
    (hind : G.IsIndepSet U) (hgap : ∀ u ∈ U, ∀ w, P.Adj (f u) w → C w ≠ γ)
    {x : V} (hx : x ∉ U) : pullbackRepaint f C U γ hind hgap x = C (f x) := by
  show U.piecewise (fun _ => γ) (⇑C ∘ f) x = C (f x)
  exact Set.piecewise_eq_of_notMem _ _ _ hx

/-- The singleton repaint: `C ∘ f` with `u` overwritten by a colour absent from `N(f u)`. The stepping stone for the
pair and fan theorems. -/
noncomputable def repaintAt (f : G →g P) (C : P.Coloring (Fin k)) (u : V) (γ : Fin k)
    (hgap : ∀ w, P.Adj (f u) w → C w ≠ γ) : G.Coloring (Fin k) :=
  pullbackRepaint f C {u} γ (Set.pairwise_singleton _ _) (by
    intro x hx w hw
    rw [Set.mem_singleton_iff] at hx
    subst hx
    exact hgap w hw)

@[simp]
theorem repaintAt_apply_self (f : G →g P) (C : P.Coloring (Fin k)) (u : V) (γ : Fin k)
    (hgap : ∀ w, P.Adj (f u) w → C w ≠ γ) : repaintAt f C u γ hgap u = γ :=
  pullbackRepaint_apply_of_mem _ _ _ _ _ _ rfl

theorem repaintAt_apply_of_ne (f : G →g P) (C : P.Coloring (Fin k)) (u : V) (γ : Fin k)
    (hgap : ∀ w, P.Adj (f u) w → C w ≠ γ) {x : V} (hx : x ≠ u) : repaintAt f C u γ hgap x = C (f x) :=
  pullbackRepaint_apply_of_not_mem _ _ _ _ _ _ hx

/-! ### The three uses -/

/-- **The fan-gap theorem (D0.2).** A gap at the image of `u` frees `u` from every other vertex: either `C ∘ f`
separates `u` from `u'`, or `C (f u) = C (f u')` and the repaint of `{u}` with `γ` does — `u'` keeps its pulled-back
colour `C (f u') = C (f u) ≠ γ`. No case split on whether `f u = f u'`, no hypothesis on `P` beyond the one gap. -/
theorem not_forces_of_fanGap (f : G →g P) {C : P.Coloring (Fin k)} {u u' : V} {γ : Fin k}
    (h : FanGap C (f u) γ) (hne : u ≠ u') : ¬ Forces G k u u' := by
  intro hF
  by_cases hc : C (f u) = C (f u')
  · have hrep := hF (repaintAt f C u γ h.2)
    rw [repaintAt_apply_self, repaintAt_apply_of_ne f C u γ h.2 hne.symm] at hrep
    exact h.1 (hrep.trans hc.symm)
  · exact hc (hF (C.comap f))

/-- **The arity-`k` filter (D0.3).** A fan at `p` over `Q` dies when some gapped colouring has every partner's image off
the gap colour: repaint `{p}`, and no partner shows `γ`. A class with a partner on the gap colour in every gapped
colouring survives — G15's wide pigeonholes are not touched. -/
theorem not_fan_of_fanGap (f : G →g P) {C : P.Coloring (Fin k)} {p : V} {Q : List V} {γ : Fin k}
    (h : FanGap C (f p) γ) (hQ : ∀ q ∈ Q, q ≠ p ∧ C (f q) ≠ γ) : ¬ Fan G k p Q := by
  intro hfan
  obtain ⟨q, hq, hcq⟩ := hfan (repaintAt f C p γ h.2)
  obtain ⟨hqp, hcγ⟩ := hQ q hq
  rw [repaintAt_apply_self, repaintAt_apply_of_ne f C p γ h.2 hqp] at hcq
  exact hcγ hcq.symm

/-- **The double repaint (D0.4).** One colour absent from both closed neighbourhoods of `f u` and `f u'`, and `u ≁ u'`:
repainting `{u, u'}` with `γ` is proper and makes the pair coincide, so it is no virtual edge. The case `f u = f u'` is
included (then a single gap already serves). -/
theorem not_separated_of_sharedGap (f : G →g P) {C : P.Coloring (Fin k)} {u u' : V} {γ : Fin k}
    (h : SharedGap C (f u) (f u') γ) (hadj : ¬ G.Adj u u') : ¬ Separated G k u u' := by
  intro hS
  have hind : G.IsIndepSet ({u, u'} : Set V) :=
    Set.pairwise_pair.mpr fun _ => ⟨hadj, fun ha => hadj ha.symm⟩
  have hgap : ∀ x ∈ ({u, u'} : Set V), ∀ w, P.Adj (f x) w → C w ≠ γ := by
    intro x hx w hw
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
    rcases hx with rfl | rfl
    · exact h.1.2 w hw
    · exact h.2.2 w hw
  have hco := hS (pullbackRepaint f C {u, u'} γ hind hgap)
  rw [pullbackRepaint_apply_of_mem _ _ _ _ _ _ (by simp),
    pullbackRepaint_apply_of_mem _ _ _ _ _ _ (by simp)] at hco
  exact hco rfl

/-- A fusable image and a non-edge: the pair coincides in some colouring of `G` — pull back the coincidence, or
double-repaint the shared gap. -/
theorem not_separated_of_fusable (f : G →g P) {u u' : V} (h : Fusable P k (f u) (f u'))
    (hadj : ¬ G.Adj u u') : ¬ Separated G k u u' := by
  obtain ⟨C, hc | ⟨γ, hγ⟩⟩ := h
  · exact fun hS => hS (C.comap f) hc
  · exact not_separated_of_sharedGap f hγ hadj

/-- **A fan's image is a fan** — `Forces.image`'s one-line proof, at every arity (Poros, FS-38). -/
theorem Fan.image (f : G →g P) {p : V} {Q : List V} (h : Fan G k p Q) : Fan P k (f p) (Q.map f) := by
  intro C
  obtain ⟨q, hq, hcq⟩ := h (C.comap f)
  exact ⟨f q, List.mem_map_of_mem hq, hcq⟩

/-! ### Slackness is hereditary, and it is forces-freeness -/

/-- Slackness passes from `P` to every graph with a homomorphism into `P` — no surjectivity. -/
theorem Slack.of_hom (f : G →g P) (h : Slack P k) : Slack G k := by
  intro v
  obtain ⟨C, γ, hgap⟩ := h (f v)
  exact ⟨C.comap f, γ, hgap.comap f⟩

/-- **Corollary (a) of D0.2**: a slack graph has no forced pair — forced equal is equal. The brief's Lemma B without
its first hypothesis: forces-freeness is a consequence of slackness, not a premise. -/
theorem Slack.forces_eq (h : Slack G k) {u u' : V} (hf : Forces G k u u') : u = u' := by
  by_contra hne
  obtain ⟨C, γ, hgap⟩ := h u
  exact not_forces_of_fanGap Hom.id hgap hne hf

theorem Slack.forces_iff (h : Slack G k) {u u' : V} : Forces G k u u' ↔ u = u' := by
  refine ⟨fun hf => h.forces_eq hf, ?_⟩
  rintro rfl
  exact fun _ => rfl

/-- The hom form, for the instances: a graph mapping into a slack target has no forced pair. -/
theorem Slack.forces_eq_of_hom (h : Slack P k) (f : G →g P) {u u' : V} (hf : Forces G k u u') : u = u' :=
  (Slack.of_hom f h).forces_eq hf

theorem Slack.forces_iff_of_hom (h : Slack P k) (f : G →g P) {u u' : V} : Forces G k u u' ↔ u = u' :=
  (Slack.of_hom f h).forces_iff

/-- Fusability pulls back along homomorphisms: a coincidence pulls back, and so do both gaps (`FanGap.comap`). -/
theorem Fusable.of_hom (f : G →g P) {u u' : V} (h : Fusable P k (f u) (f u')) : Fusable G k u u' := by
  obtain ⟨C, hc | ⟨γ, hγ⟩⟩ := h
  · exact ⟨C.comap f, Or.inl hc⟩
  · exact ⟨C.comap f, Or.inr ⟨γ, hγ.1.comap f, hγ.2.comap f⟩⟩

/-- A pair no colouring separates is fusable (it coincides). This is how M60's `finitePlane11_separated_iff` feeds
`Fusable` at the non-adjacent pairs. -/
theorem fusable_of_not_separated {v w : W} (h : ¬ Separated P k v w) : Fusable P k v w := by
  simp only [Separated, not_forall, not_not] at h
  obtain ⟨C, hC⟩ := h
  exact ⟨C, Or.inl hC⟩

theorem PairwiseFusable.of_hom (f : G →g P) (h : PairwiseFusable P k) : PairwiseFusable G k :=
  fun u u' => Fusable.of_hom f (h (f u) (f u'))

/-- **Virtual edges are edges (D0.4).** In a pairwise-fusable graph, a pair separated by every `k`-colouring is
adjacent. One hypothesis; it carries its own colouring, so no colourability or `k ≥ 1` premise is needed. -/
theorem PairwiseFusable.separated_iff_adj (h : PairwiseFusable G k) {u u' : V} :
    Separated G k u u' ↔ G.Adj u u' := by
  refine ⟨fun hS => ?_, Separated.of_adj⟩
  by_contra hadj
  exact not_separated_of_fusable Hom.id (h u u') hadj hS

/-- The hom form, for the instances: a graph mapping into a pairwise-fusable target has no virtual non-edge. -/
theorem PairwiseFusable.separated_iff_adj_of_hom (h : PairwiseFusable P k) (f : G →g P) {u u' : V} :
    Separated G k u u' ↔ G.Adj u u' :=
  (PairwiseFusable.of_hom f h).separated_iff_adj

/-- **No pair compulsion and colourable ⟹ arity floor at least `3`** — the general form of
`three_le_arityFloor_of_aperiodic_coincides` (`ResidueObstruction.lean`), whose proof uses only these three facts through
`le_arityFloor_iff` and `two_le_arityFloor`. Stated here rather than in `Arity.lean` (a new declaration there rebuilds
its dependents). -/
theorem three_le_arityFloor_of_forces_eq_of_separated_adj (hcol : G.Colorable k)
    (hf : ∀ u v, Forces G k u v → u = v) (hs : ∀ u v, Separated G k u v → G.Adj u v) :
    3 ≤ arityFloor G k := by
  refine le_arityFloor_iff.mpr fun m ⟨T, q, hcomp⟩ => ?_
  have h2 : (2 : ℕ∞) ≤ m := le_arityFloor_iff.mp (two_le_arityFloor hcol) m ⟨T, q, hcomp⟩
  by_contra hlt
  have hm : m = 2 := by
    have h2' : 2 ≤ m := by exact_mod_cast h2
    have h3' : m < 3 := by exact_mod_cast not_le.mp hlt
    omega
  subst hm
  have hT : Function.Injective T := hcomp.1.1
  by_cases hq : q 0 = q 1
  · obtain ⟨hne, hsep⟩ := (compels_two_eq hT hq).mp hcomp
    exact hne (hs _ _ hsep)
  · exact absurd (hT (hf _ _ ((compels_two_ne hT hq).mp hcomp))) (by decide)

/-! ### Cayley graphs: one gap is every gap -/

section Cayley

variable {A : Type*} [AddCommGroup A] {S : Set A}

/-- A gap at `v` translates to a gap at `v − t` in the translated colouring `x ↦ C (t + x)`. -/
theorem FanGap.translate {C : (addCayley S).Coloring (Fin k)} {v : A} {γ : Fin k} (h : FanGap C v γ)
    (t : A) : FanGap (C.comap (addCayleyTranslate S t)) (v - t) γ := by
  have he : t + (v - t) = v := by abel
  refine ⟨?_, ?_⟩
  · show γ ≠ C (t + (v - t))
    rw [he]
    exact h.1
  · intro w hw
    show C (t + w) ≠ γ
    refine h.2 (t + w) ?_
    have h2 := (addCayley_adj_add_iff_right (d := t)).mpr hw
    rwa [he] at h2

/-- **One gapped vertex makes a Cayley graph slack.** -/
theorem slack_addCayley_of_fanGap {C : (addCayley S).Coloring (Fin k)} {v : A} {γ : Fin k}
    (h : FanGap C v γ) : Slack (addCayley S) k := by
  intro x
  refine ⟨C.comap (addCayleyTranslate S (v - x)), γ, ?_⟩
  have ht := h.translate (v - x)
  rwa [sub_sub_cancel] at ht

end Cayley

/-- **A shared gap at one base edge, transported.** If every edge `v ~ w` is carried onto the base edge `(v₀, w₀)` by
some endomorphism `σ` (translate, then rotate), the base colouring pulls back along `σ` to a colouring with the shared
gap at `v, w` — the gap lands on `σ⁻¹(N[v₀] ∪ N[w₀]) = N[v] ∪ N[w]`. Written this way round on purpose. -/
theorem fusable_of_hom_to_base {v₀ w₀ : W} {C : P.Coloring (Fin k)} {γ : Fin k}
    (h₀ : SharedGap C v₀ w₀ γ) (hσ : ∀ v w, P.Adj v w → ∃ σ : P →g P, σ v = v₀ ∧ σ w = w₀)
    {v w : W} (hvw : P.Adj v w) : Fusable P k v w := by
  obtain ⟨σ, hv, hw⟩ := hσ v w hvw
  have h1 : FanGap C (σ v) γ := by rw [hv]; exact h₀.1
  have h2 : FanGap C (σ w) γ := by rw [hw]; exact h₀.2
  exact ⟨C.comap σ, Or.inr ⟨γ, h1.comap σ, h2.comap σ⟩⟩

/-! ### Rings and certificates -/

section Ring

variable {R T : Type*} [CommRing R] [CommRing T]

/-- The finite-plane bound's functoriality, for slackness: a ring homomorphism `R →+* T` with `T` nontrivial carries
slackness of `unitQuadrance T` back to `unitQuadrance R`. The tower `ZMod (p ^ m)` and the completion `ℤ_[p]` are
instances, not steps of an induction. -/
theorem Slack.unitQuadrance_of_ringHom [Nontrivial T] (φ : R →+* T) (h : Slack (unitQuadrance T) k) :
    Slack (unitQuadrance R) k :=
  Slack.of_hom (unitQuadrance.map φ) h

theorem PairwiseFusable.unitQuadrance_of_ringHom [Nontrivial T] (φ : R →+* T)
    (h : PairwiseFusable (unitQuadrance T) k) : PairwiseFusable (unitQuadrance R) k :=
  PairwiseFusable.of_hom (unitQuadrance.map φ) h

theorem unitQuadrance_forces_eq_of_ringHom [Nontrivial T] (φ : R →+* T) (h : Slack (unitQuadrance T) k)
    {u v : R × R} (hf : Forces (unitQuadrance R) k u v) : u = v :=
  h.forces_eq_of_hom (unitQuadrance.map φ) hf

/-- **The base-edge transport, for every ring.** An edge `v ~ w` of `unitQuadrance R` is carried onto the base edge
`((0, 0), (1, 0))` by translation by `−v` followed by rotation by the conjugate of `d = w − v` (`rotHom` by `d` sends
`(1, 0)` to `d`; its inverse sends `d` to `(1, 0)`). Nothing here is about a prime. -/
theorem unitQuadrance_exists_hom_to_base {v w : R × R} (h : (unitQuadrance R).Adj v w) :
    ∃ σ : unitQuadrance R →g unitQuadrance R, σ v = (0, 0) ∧ σ w = (1, 0) := by
  rw [unitQuadrance_adj] at h
  obtain ⟨hne, hq⟩ := h
  set d : R × R := -v + w with hd
  have hq' : d.1 ^ 2 + (-d.2) ^ 2 = 1 := by
    simp only [hd, Prod.fst_add, Prod.snd_add, Prod.fst_neg, Prod.snd_neg]
    linear_combination hq
  refine ⟨(rotHom hq').comp (addCayleyTranslate (unitCircle R) (-v)), ?_, ?_⟩
  · show rotHom hq' (-v + v) = (0, 0)
    rw [neg_add_cancel, rotHom_apply]
    simp
  · show rotHom hq' d = (1, 0)
    rw [rotHom_apply, Prod.ext_iff]
    refine ⟨?_, ?_⟩
    · show d.1 * d.1 - -d.2 * d.2 = 1
      linear_combination hq'
    · show -d.2 * d.1 + d.1 * d.2 = 0
      ring

/-- **One shared-gap table at the base edge makes every edge fusable** — the recipe for any plane, at any prime. -/
theorem unitQuadrance_fusable_of_sharedGap_base {C : (unitQuadrance R).Coloring (Fin k)} {γ : Fin k}
    (h₀ : SharedGap C (0, 0) (1, 0) γ) {v w : R × R} (hvw : (unitQuadrance R).Adj v w) :
    Fusable (unitQuadrance R) k v w :=
  fusable_of_hom_to_base h₀ (fun _ _ h => unitQuadrance_exists_hom_to_base h) hvw

variable {n : ℕ}

/-- **The certificate form of Corollary 2 (D0.5).** A `Valid` certificate with coordinates in a subring, reduced
through `φ` into a slack plane: no two of its vertices are forced equal at `k` colours — every pair, with no condition
on its distance and no "images distinct" (M60's residue law refuted only the pairs with distinct residues). -/
theorem UDCert.forces_eq_of_slack [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (h : Slack (unitQuadrance R) k) {i j : Fin n} (hf : Forces (edgeGraph n c.edges) k i j) : i = j :=
  h.forces_eq_of_hom (c.drawingHom φ hS hu hv) hf

/-- The certificate form of "virtual edges are edges". -/
theorem UDCert.separated_iff_adj_of_fusable [Nontrivial R] (c : UDCert n) {S : Subring Q4}
    (φ : S →+* R) (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (h : PairwiseFusable (unitQuadrance R) k) {i j : Fin n} :
    Separated (edgeGraph n c.edges) k i j ↔ (edgeGraph n c.edges).Adj i j :=
  h.separated_iff_adj_of_hom (c.drawingHom φ hS hu hv)

end Ring

end HadwigerNelson
