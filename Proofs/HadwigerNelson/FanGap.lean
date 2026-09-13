import Proofs.HadwigerNelson.ResidueObstruction
import Proofs.HadwigerNelson.CoverageMono

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

/-- **Gaps pull back** (the brief's A′): the neighbours of `u` map into the neighbours of `f u`. -/
theorem FanGap.comap (f : G →g P) {C : P.Coloring (Fin k)} {u : V} {γ : Fin k}
    (h : FanGap C (f u) γ) : FanGap (C.comap f) u γ := by
  sorry

/-- The bridge to the record's coverage vocabulary: a gap at `v` in some colouring is exactly the failure of
`CoverAtLeast P k v [] (k − 1)` — `C v` is never on `N(v)`, so the neighbourhood shows at most `k − 1` colours, and
shows fewer iff some other colour is missing. -/
theorem exists_fanGap_iff_not_coverAtLeast (v : W) :
    (∃ (C : P.Coloring (Fin k)) (γ : Fin k), FanGap C v γ) ↔ ¬ CoverAtLeast P k v [] (k - 1) := by
  sorry

/-! ### The repaint -/

open Classical in
/-- **The repaint.** The pullback `C ∘ f`, overwritten with `γ` on an independent set `U` whose images all have `γ`
absent from their open neighbourhoods — Mathlib's `Set.piecewise`. Proper: an edge inside `U` is excluded by
independence; an edge `x ~ y` with `x ∈ U`, `y ∉ U` has `f y ∈ N(f x)`, where `γ` is absent; an edge off `U` is the
homomorphism. `γ ≠ C (f u)` is NOT needed here — only for the separations that consume it. -/
noncomputable def pullbackRepaint (f : G →g P) (C : P.Coloring (Fin k)) (U : Set V) (γ : Fin k)
    (hind : G.IsIndepSet U) (hgap : ∀ u ∈ U, ∀ w, P.Adj (f u) w → C w ≠ γ) : G.Coloring (Fin k) :=
  Coloring.mk (U.piecewise (fun _ => γ) (⇑C ∘ f)) (by
    sorry)

theorem pullbackRepaint_apply_of_mem (f : G →g P) (C : P.Coloring (Fin k)) (U : Set V) (γ : Fin k)
    (hind : G.IsIndepSet U) (hgap : ∀ u ∈ U, ∀ w, P.Adj (f u) w → C w ≠ γ)
    {x : V} (hx : x ∈ U) : pullbackRepaint f C U γ hind hgap x = γ := by
  sorry

theorem pullbackRepaint_apply_of_not_mem (f : G →g P) (C : P.Coloring (Fin k)) (U : Set V) (γ : Fin k)
    (hind : G.IsIndepSet U) (hgap : ∀ u ∈ U, ∀ w, P.Adj (f u) w → C w ≠ γ)
    {x : V} (hx : x ∉ U) : pullbackRepaint f C U γ hind hgap x = C (f x) := by
  sorry

/-! ### The three uses -/

/-- **The fan-gap theorem (D0.2).** A gap at the image of `u` frees `u` from every other vertex: either `C ∘ f`
separates `u` from `u'`, or `C (f u) = C (f u')` and the repaint of `{u}` with `γ` does — `u'` keeps its pulled-back
colour `C (f u') = C (f u) ≠ γ`. No case split on whether `f u = f u'`, no hypothesis on `P` beyond the one gap. -/
theorem not_forces_of_fanGap (f : G →g P) {C : P.Coloring (Fin k)} {u u' : V} {γ : Fin k}
    (h : FanGap C (f u) γ) (hne : u ≠ u') : ¬ Forces G k u u' := by
  sorry

/-- **The arity-`k` filter (D0.3).** A fan at `p` over `Q` dies when some gapped colouring has every partner's image off
the gap colour: repaint `{p}`, and no partner shows `γ`. A class with a partner on the gap colour in every gapped
colouring survives — G15's wide pigeonholes are not touched. -/
theorem not_fan_of_fanGap (f : G →g P) {C : P.Coloring (Fin k)} {p : V} {Q : List V} {γ : Fin k}
    (h : FanGap C (f p) γ) (hQ : ∀ q ∈ Q, q ≠ p ∧ C (f q) ≠ γ) : ¬ Fan G k p Q := by
  sorry

/-- **The double repaint (D0.4).** One colour absent from both closed neighbourhoods of `f u` and `f u'`, and `u ≁ u'`:
repainting `{u, u'}` with `γ` is proper and makes the pair coincide, so it is no virtual edge. The case `f u = f u'` is
included (then a single gap already serves). -/
theorem not_separated_of_sharedGap (f : G →g P) {C : P.Coloring (Fin k)} {u u' : V} {γ : Fin k}
    (h : SharedGap C (f u) (f u') γ) (hadj : ¬ G.Adj u u') : ¬ Separated G k u u' := by
  sorry

/-- A fusable image and a non-edge: the pair coincides in some colouring of `G` — pull back the coincidence, or
double-repaint the shared gap. -/
theorem not_separated_of_fusable (f : G →g P) {u u' : V} (h : Fusable P k (f u) (f u'))
    (hadj : ¬ G.Adj u u') : ¬ Separated G k u u' := by
  sorry

/-- **A fan's image is a fan** — `Forces.image`'s one-line proof, at every arity (Poros, FS-38). -/
theorem Fan.image (f : G →g P) {p : V} {Q : List V} (h : Fan G k p Q) : Fan P k (f p) (Q.map f) := by
  sorry

/-! ### Slackness is hereditary, and it is forces-freeness -/

/-- Slackness passes from `P` to every graph with a homomorphism into `P` — no surjectivity. -/
theorem Slack.of_hom (f : G →g P) (h : Slack P k) : Slack G k := by
  sorry

/-- **Corollary (a) of D0.2**: over a slack target, forced equal is equal. The brief's Lemma B without its first
hypothesis — forces-freeness of `P` is a consequence of its slackness, not a premise. -/
theorem Slack.forces_eq (h : Slack P k) (f : G →g P) {u u' : V} (hf : Forces G k u u') : u = u' := by
  sorry

theorem Slack.forces_iff (h : Slack P k) (f : G →g P) {u u' : V} : Forces G k u u' ↔ u = u' := by
  sorry

/-- A slack graph is itself forces-free (`f = id`). -/
theorem Slack.self_forces_iff (h : Slack P k) {x y : W} : Forces P k x y ↔ x = y := by
  sorry

/-- Fusability pulls back along homomorphisms: a coincidence pulls back, and so do both gaps (`FanGap.comap`). -/
theorem Fusable.of_hom (f : G →g P) {u u' : V} (h : Fusable P k (f u) (f u')) : Fusable G k u u' := by
  sorry

/-- A pair no colouring separates is fusable (it coincides). This is how M60's `finitePlane11_separated_iff` feeds
`Fusable` at the non-adjacent pairs. -/
theorem fusable_of_not_separated {v w : W} (h : ¬ Separated P k v w) : Fusable P k v w := by
  sorry

/-- **Virtual edges are edges (D0.4).** Over a target every pair of which is fusable, for every graph mapping into it a
pair separated by every `k`-colouring is adjacent. One hypothesis; it carries its own colouring, so no colourability or
`k ≥ 1` premise is needed. -/
theorem separated_iff_adj_of_fusable (h : ∀ v w, Fusable P k v w) (f : G →g P) {u u' : V} :
    Separated G k u u' ↔ G.Adj u u' := by
  sorry

/-! ### Cayley graphs: one gap is every gap -/

section Cayley

variable {A : Type*} [AddCommGroup A] {S : Set A}

/-- A gap at `v` translates to a gap at `v − t` in the translated colouring `x ↦ C (t + x)`. -/
theorem FanGap.translate {C : (addCayley S).Coloring (Fin k)} {v : A} {γ : Fin k} (h : FanGap C v γ)
    (t : A) : FanGap (C.comap (addCayleyTranslate S t)) (v - t) γ := by
  sorry

/-- **One gapped vertex makes a Cayley graph slack.** -/
theorem slack_addCayley_of_fanGap {C : (addCayley S).Coloring (Fin k)} {v : A} {γ : Fin k}
    (h : FanGap C v γ) : Slack (addCayley S) k := by
  sorry

end Cayley

/-- **A shared gap at one base edge, transported.** If every edge `v ~ w` is carried onto the base edge `(v₀, w₀)` by
some endomorphism `σ` (translate, then rotate), the base colouring pulls back along `σ` to a colouring with the shared
gap at `v, w` — the gap lands on `σ⁻¹(N[v₀] ∪ N[w₀]) = N[v] ∪ N[w]`. Written this way round on purpose. -/
theorem fusable_of_hom_to_base {v₀ w₀ : W} {C : P.Coloring (Fin k)} {γ : Fin k}
    (h₀ : SharedGap C v₀ w₀ γ) (hσ : ∀ v w, P.Adj v w → ∃ σ : P →g P, σ v = v₀ ∧ σ w = w₀)
    {v w : W} (hvw : P.Adj v w) : Fusable P k v w := by
  sorry

/-! ### Rings and certificates -/

section Ring

variable {R T : Type*} [CommRing R] [CommRing T]

/-- The finite-plane bound's functoriality, for slackness: a ring homomorphism `R →+* T` with `T` nontrivial carries
slackness of `unitQuadrance T` back to `unitQuadrance R`. The tower `ZMod (p ^ m)` and the completion `ℤ_[p]` are
instances, not steps of an induction. -/
theorem Slack.unitQuadrance_of_ringHom [Nontrivial T] (φ : R →+* T) (h : Slack (unitQuadrance T) k) :
    Slack (unitQuadrance R) k :=
  Slack.of_hom (unitQuadrance.map φ) h

theorem fusable_unitQuadrance_of_ringHom [Nontrivial T] (φ : R →+* T)
    (h : ∀ v w, Fusable (unitQuadrance T) k v w) (u v : R × R) : Fusable (unitQuadrance R) k u v :=
  Fusable.of_hom (unitQuadrance.map φ) (h _ _)

theorem unitQuadrance_forces_eq_of_ringHom [Nontrivial T] (φ : R →+* T) (h : Slack (unitQuadrance T) k)
    {u v : R × R} (hf : Forces (unitQuadrance R) k u v) : u = v :=
  Slack.forces_eq h (unitQuadrance.map φ) hf

variable {n : ℕ}

/-- **The certificate form of Corollary 2 (D0.5).** A `Valid` certificate with coordinates in a subring, reduced
through `φ` into a slack plane: no two of its vertices are forced equal at `k` colours — every pair, with no condition
on its distance and no "images distinct" (M60's residue law refuted only the pairs with distinct residues). -/
theorem UDCert.forces_eq_of_slack [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (h : Slack (unitQuadrance R) k) {i j : Fin n} (hf : Forces (edgeGraph n c.edges) k i j) : i = j :=
  Slack.forces_eq h (c.drawingHom φ hS hu hv) hf

/-- The certificate form of "virtual edges are edges". -/
theorem UDCert.separated_iff_adj_of_fusable [Nontrivial R] (c : UDCert n) {S : Subring Q4}
    (φ : S →+* R) (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (h : ∀ v w, Fusable (unitQuadrance R) k v w) {i j : Fin n} :
    Separated (edgeGraph n c.edges) k i j ↔ (edgeGraph n c.edges).Adj i j :=
  HadwigerNelson.separated_iff_adj_of_fusable h (c.drawingHom φ hS hu hv)

end Ring

end HadwigerNelson
