import Proofs.HadwigerNelson.FanGap
import Proofs.HadwigerNelson.LocalGlobal
import Proofs.HadwigerNelson.Palette
import Mathlib.Combinatorics.SimpleGraph.Finsubgraph
import Mathlib.GroupTheory.Index

/-!
# Kempe chains, periodic colourings, and where a forced pair can live (FS-73 skeleton)

**Status: skeleton (FS-73, 2026-09-23).** Every statement below is a leaf of `plans/FS73-rigidity-dichotomy.md` §K;
`sorry` marks the ones not yet proved. Nothing downstream imports this module.

The FS-70 screens (`plans/FS70-derivation.md` T2, T6, T10) close `Forces` on a whole lattice from one periodic
colouring. This file states them in the kernel's words, together with three facts that sharpen FS-73's
inheritance question (C3):

* **Kempe swaps** (`KempeClosed`, `kempeSwap`, `not_forces_of_kempeClosed`): swapping two colours on a set closed in
  their two-colour subgraph is proper, and it separates a member from a non-member. No group, no metric.
* **The voltage certificate** (`VoltageEscape`, T10's sound direction): a colouring table on a quotient `B` of `A`,
  the component `Q0` of `0` in its two-colour quotient graph, spanning-tree voltages `p`, and a subgroup `V`
  holding every fundamental-cycle voltage. The lift `{y | π y ∈ Q0 ∧ y − p (π y) ∈ V}` is Kempe-closed for the
  pulled-back colouring, so every `δ` outside it escapes: `¬ Forces (addCayley S) k 0 δ`. Only the escape direction
  is stated. A "rigid" verdict proves nothing and has no kernel consumer.
* **The fan-gap closure** (`forces_iff_of_quotient_fanGap`, T6): one gapped quotient colouring frees every pair on
  every graph mapping into the lattice graph. Two lines over `FanGap.lean`.
* **Compactness** (`forces_iff_exists_finite`): a pair is forced in a graph iff it is forced in some finite
  induced subgraph, by Mathlib's `nonempty_hom_of_forall_finite_subgraph_hom` applied to the graph plus the edge
  `uv`. So "some finite ball forces `(0, δ)`" is the same statement as "the infinite lattice graph forces it"
  (FS-73 §G, reduction R1).
* **The normal form** (`periods`, `IsPeriodic`, `forcedSubgroup`, `periodicForcedSubgroup`): the forced vectors form
  a subgroup `F`, the common periods of every colouring. The vectors every periodic colouring identifies (H1) form a
  subgroup `P`, the common periods of the periodic ones. `F ≤ P` holds by definition. A colouring is periodic when its
  period group has finite index.
* **R3, the escape direction** (`notMem_periodicForcedSubgroup_of_voltageEscape`): an escape certificate at a
  finite-index period puts `δ` outside `P`. The swap is re-periodised through a finite-index subgroup that contains
  `V` and misses the escape (residual finiteness of finitely generated abelian groups; Poros, 2026-09-23).
* **The question itself** (`InheritanceQuestion`): `P ≤ F` once a periodic colouring exists, stated as a `Prop` and
  never claimed. `inheritanceQuestion_iff` restates it as `P = F`.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### Kempe swaps on any graph -/

section Kempe

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-- **A set closed in the `(a, b)`-two-colour subgraph of `C`**: every member wears `a` or `b`, and every neighbour
of a member wearing `a` or `b` is a member. A union of `(a, b)`-Kempe components. -/
def KempeClosed (C : G.Coloring (Fin k)) (a b : Fin k) (K : Set V) : Prop :=
  (∀ v ∈ K, C v = a ∨ C v = b) ∧ ∀ v ∈ K, ∀ w, G.Adj v w → (C w = a ∨ C w = b) → w ∈ K

/-- The empty set is Kempe-closed: the named inhabitant. -/
theorem kempeClosed_empty (C : G.Coloring (Fin k)) (a b : Fin k) : KempeClosed C a b ∅ :=
  ⟨fun _ h => h.elim, fun _ h => h.elim⟩

/-- The whole two-colour subgraph is Kempe-closed: the inhabitant a swap of every `a`/`b` vertex uses. -/
theorem kempeClosed_twoColour (C : G.Coloring (Fin k)) (a b : Fin k) :
    KempeClosed C a b {v | C v = a ∨ C v = b} :=
  ⟨fun _ h => h, fun _ _ _ _ hw => hw⟩

/-- **The Kempe swap**: exchange `a` and `b` on `K`, leave every other vertex alone. -/
noncomputable def kempeSwap (C : G.Coloring (Fin k)) (a b : Fin k) (K : Set V) (hK : KempeClosed C a b K) :
    G.Coloring (Fin k) := by
  classical
  exact Coloring.mk (fun v => if v ∈ K then Equiv.swap a b (C v) else C v) (by sorry)

/-- The swap exchanges `a` and `b` on members of `K`. -/
@[simp] theorem kempeSwap_apply_of_mem (C : G.Coloring (Fin k)) {a b : Fin k} {K : Set V} (hK : KempeClosed C a b K)
    {v : V} (hv : v ∈ K) : kempeSwap C a b K hK v = Equiv.swap a b (C v) := by
  sorry

/-- The swap fixes every non-member of `K`. -/
@[simp] theorem kempeSwap_apply_of_notMem (C : G.Coloring (Fin k)) {a b : Fin k} {K : Set V} (hK : KempeClosed C a b K)
    {v : V} (hv : v ∉ K) : kempeSwap C a b K hK v = C v := by
  sorry

/-- **The swap separates a member from a non-member of the same colour.** This is the one computation behind both
`not_forces_of_kempeClosed` and R3: `u ∈ K` moves to `swap (C u) ≠ C u`, and `v ∉ K` stays put. -/
theorem kempeSwap_ne_of_mem_of_notMem (C : G.Coloring (Fin k)) {a b : Fin k} (hab : a ≠ b) {K : Set V}
    (hK : KempeClosed C a b K) {u v : V} (hu : u ∈ K) (hv : v ∉ K) (huv : C u = C v) :
    kempeSwap C a b K hK u ≠ kempeSwap C a b K hK v := by
  sorry

/-- **A Kempe-closed set that holds `u` and misses `v` refutes `Forces`.** If `C` already separates the pair
there is nothing to do; otherwise the swap moves `u` off the common colour and leaves `v` on it. -/
theorem not_forces_of_kempeClosed (C : G.Coloring (Fin k)) {a b : Fin k} (hab : a ≠ b) {K : Set V}
    (hK : KempeClosed C a b K) {u v : V} (hu : u ∈ K) (hv : v ∉ K) : ¬ Forces G k u v := by
  sorry

end Kempe

/-! ### Compactness: a forced pair is forced by a finite piece -/

section Compactness

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-- **De Bruijn–Erdős for a separated pair**, the statement R1's forward direction derives from. If every finite set
of vertices carries a function to `Fin k` that is proper on the edges inside it and separates `u` from `v`, some proper
colouring of `G` separates them. The proof is Mathlib's `Finset.rado_selection` with `g s` the given function, read at
`s = {x, y}` (an edge) and at `s = {u, v}`. -/
theorem exists_coloring_ne_of_forall_finset {u v : V}
    (h : ∀ s : Finset V, ∃ f : V → Fin k, (∀ x ∈ s, ∀ y ∈ s, G.Adj x y → f x ≠ f y) ∧ f u ≠ f v) :
    ∃ C : G.Coloring (Fin k), C u ≠ C v := by
  sorry

/-- **R1 (compactness).** A pair is forced at `k` colours in `G` iff it is forced in some finite induced subgraph
holding it. The backward direction is `Forces.comap` along the induced embedding. The forward direction is
Mathlib's `nonempty_hom_of_forall_finite_subgraph_hom` applied to `G ⊔ edge u v`, whose `k`-colourings are exactly the
colourings of `G` that separate the pair. -/
theorem forces_iff_exists_finite {u v : V} :
    Forces G k u v ↔
      ∃ (s : Set V) (_ : s.Finite) (hu : u ∈ s) (hv : v ∈ s), Forces (G.induce s) k ⟨u, hu⟩ ⟨v, hv⟩ := by
  sorry

end Compactness

/-! ### Cayley graphs of abelian groups: the voltage certificate (T10) and the fan-gap closure (T6) -/

section Voltage

variable {A B : Type*} [AddCommGroup A] [AddCommGroup B] {k : ℕ}

/-- **T10's data, read as a certificate of an escape.** `π : A →+ B` is the period map, `tab` a proper colouring of
the quotient Cayley graph `addCayley D`, and `a ≠ b` two colours. `Q0` is closed under the quotient's
`a`/`b`-coloured steps `x ↦ x ± π s` and holds `0`. The voltages `p` pick a lift in each class of `Q0`, and `V`
(inside the kernel of `π`) holds every fundamental-cycle voltage `p x + t − p (x + π t)`, for `t = ±s`. `V` need not
be the span of the voltages: any larger subgroup in the kernel gives a larger Kempe-closed set, and the escape
stays sound. -/
structure VoltageEscape (π : A →+ B) (S : Set A) (D : Set B) (k : ℕ) where
  /-- The quotient colouring, a table on `B`. -/
  tab : B → Fin k
  /-- The table is proper along the quotient connection set `D`. -/
  proper : ∀ d ∈ D, ∀ x, tab (x + d) ≠ tab x
  /-- The origin's colour. -/
  a : Fin k
  /-- The second colour of the Kempe pair. -/
  b : Fin k
  /-- The pair is a pair. -/
  hab : a ≠ b
  /-- The component of `0` in the quotient's `a`/`b` subgraph (any closed superset of it is sound). -/
  Q0 : Set B
  /-- Spanning-tree voltages: one lattice point in each class of `Q0`. -/
  p : B → A
  /-- A subgroup of the kernel holding every fundamental-cycle voltage. -/
  V : AddSubgroup A
  /-- The origin's class is in the component. -/
  zero_mem : (0 : B) ∈ Q0
  /-- The origin's voltage lies in `V`, so the origin lies in the lift. -/
  p_zero : p 0 ∈ V
  /-- Each voltage lies in its class. -/
  p_class : ∀ x ∈ Q0, π (p x) = x
  /-- `V` lies in the kernel of the period map. -/
  V_ker : ∀ v ∈ V, π v = 0
  /-- Every class of the component wears `a` or `b`. -/
  colour : ∀ x ∈ Q0, tab x = a ∨ tab x = b
  /-- The component is closed under the `a`/`b`-coloured quotient steps. -/
  closed : ∀ x ∈ Q0, ∀ s ∈ S, ∀ t ∈ ({s, -s} : Set A),
    (tab (x + π t) = a ∨ tab (x + π t) = b) → x + π t ∈ Q0
  /-- Every fundamental-cycle voltage lies in `V`. -/
  voltage : ∀ x ∈ Q0, ∀ s ∈ S, ∀ t ∈ ({s, -s} : Set A),
    (tab (x + π t) = a ∨ tab (x + π t) = b) → p x + t - p (x + π t) ∈ V

variable {π : A →+ B} {S : Set A} {D : Set B}

/-- The lift of the certificate's component: the `(a, b)`-Kempe component of the origin in the infinite graph
contains this set when `V` is exactly the voltage span (T10), and it is always Kempe-closed. -/
def VoltageEscape.lift (e : VoltageEscape π S D k) : Set A :=
  {y | π y ∈ e.Q0 ∧ y - e.p (π y) ∈ e.V}

theorem VoltageEscape.zero_mem_lift (e : VoltageEscape π S D k) : (0 : A) ∈ e.lift := by
  sorry

/-- **The certificate is monotone in `V`.** Any subgroup of the kernel that contains `V` is again a valid `V`, and it
gives a larger lift. This is R3's engine: enlarge `V` to a finite-index subgroup that misses the escape. -/
def VoltageEscape.enlarge (e : VoltageEscape π S D k) (W : AddSubgroup A) (hVW : e.V ≤ W)
    (hW : ∀ w ∈ W, π w = 0) : VoltageEscape π S D k :=
  { e with
    V := W
    p_zero := hVW e.p_zero
    V_ker := hW
    voltage := fun x hx s hs t ht hc => hVW (e.voltage x hx s hs t ht hc) }

/-- **The lift is a union of `V`-cosets**: translation by `V` preserves it, since `V` lies in the kernel of `π`. -/
theorem VoltageEscape.add_mem_lift_iff (e : VoltageEscape π S D k) {w : A} (hw : w ∈ e.V) {y : A} :
    y + w ∈ e.lift ↔ y ∈ e.lift := by
  sorry

/-- **The lift is Kempe-closed for the pulled-back colouring.** Adjacency in `addCayley S` is a step `y ↦ y + t`,
`t = ±s` (Mathlib's `addCayley_adj'`). The step's image is closed in `Q0` by `closed`, and the voltage identity
`(y + t) − p (π y + π t) = (y − p (π y)) + (p (π y) + t − p (π y + π t))` puts it in `V` by `voltage`. -/
theorem VoltageEscape.kempeClosed (e : VoltageEscape π S D k) (hS : ∀ s ∈ S, π s ≠ 0) (hD : ∀ s ∈ S, π s ∈ D) :
    KempeClosed ((addCayleyColoring e.tab e.proper).comap (addCayleyMap π hS hD)) e.a e.b e.lift := by
  sorry

/-- **T10's escape (the periodic Kempe screen, sound direction).** A target outside the lift is forced equal to the
origin by no graph on `A` at any radius: `¬ Forces (addCayley S) k 0 δ`. -/
theorem not_forces_of_voltageEscape (e : VoltageEscape π S D k) (hS : ∀ s ∈ S, π s ≠ 0)
    (hD : ∀ s ∈ S, π s ∈ D) {δ : A} (hδ : δ ∉ e.lift) : ¬ Forces (addCayley S) k 0 δ :=
  not_forces_of_kempeClosed _ e.hab (e.kempeClosed hS hD) e.zero_mem_lift hδ

/-- **T6, the fan-gap closure.** One gapped colouring of the quotient frees every pair on every graph with a
homomorphism into the lattice graph: `slack_addCayley_of_fanGap` makes the quotient slack, `Slack.of_hom` carries
that back along `addCayleyMap`, and `Slack.forces_iff_of_hom` consumes it. -/
theorem forces_iff_of_quotient_fanGap (hS : ∀ s ∈ S, π s ≠ 0) (hD : ∀ s ∈ S, π s ∈ D)
    {C : (addCayley D).Coloring (Fin k)} {v : B} {γ : Fin k} (hgap : FanGap C v γ)
    {W : Type*} {H : SimpleGraph W} (f : H →g addCayley S) {u u' : W} : Forces H k u u' ↔ u = u' :=
  Slack.forces_iff_of_hom (Slack.of_hom (addCayleyMap π hS hD) (slack_addCayley_of_fanGap hgap)) f

/-- **T2, the additive Kempe screen**: the case `π = φ`, an additive colouring into a group of order `k`, where
the colour-`0` part of the `(0, b)`-Kempe component of the origin is the subgroup `R_b` of pair sums `z + w`,
`φ z = b`, `φ w = −b`. Any target outside `R_b` escapes. `R_b` lies in the kernel of `φ`, so a target off the kernel
is covered, and there `φ` itself separates the pair. The modeling stage dropped the old hypothesis `φ δ = 0`, which
the proof never needed (G30 mode 6). The proof splits on `φ δ = 0`.
- Off the kernel, the additive colouring separates the pair.
- On the kernel, apply `not_forces_of_kempeClosed` with the choice-free Kempe-closed set
  `{y | φ y = 0 ∧ y ∈ R_b} ∪ {y | φ y = b ∧ ∃ z ∈ S, φ z = b ∧ y − z ∈ R_b}`. Unlike a `VoltageEscape` certificate, this
  set needs no chosen voltage `p b`, and no case split on whether `b` is hit. -/
theorem not_forces_of_additiveKempe {Γ : Type*} [AddCommGroup Γ] [Fintype Γ] (hk : Fintype.card Γ = k)
    (φ : A →+ Γ) (hφ : ∀ s ∈ S, φ s ≠ 0) (hSneg : ∀ s ∈ S, -s ∈ S) {b : Γ} (hb : b ≠ 0) {δ : A}
    (hδ : δ ∉ AddSubgroup.closure {x | ∃ z ∈ S, ∃ w ∈ S, φ z = b ∧ φ w = -b ∧ x = z + w}) :
    ¬ Forces (addCayley S) k 0 δ := by
  sorry

end Voltage

/-! ### The normal form: the forced group `F`, the H1 group `P`, and the question `P ≤ F` -/

section Inheritance

variable {A : Type*} [AddCommGroup A] {S : Set A} {k : ℕ}

/-- **The period group of a colouring**: the translations `d` with `C (x + d) = C x` for every `x`, that is
`Function.Periodic C d`, the predicate `not_forces_zero_of_not_periodic` consumes. -/
def periods (C : (addCayley S).Coloring (Fin k)) : AddSubgroup A where
  carrier := {d | Function.Periodic C d}
  add_mem' h₁ h₂ := h₁.add_period h₂
  zero_mem' := Function.periodic_with_period_zero _
  neg_mem' h := h.neg

/-- Membership in the period group is `Function.Periodic`, by definition. -/
@[simp] theorem mem_periods {C : (addCayley S).Coloring (Fin k)} {d : A} :
    d ∈ periods C ↔ Function.Periodic C d := Iff.rfl

/-- A colouring is **periodic** when its period group has finite index. Equivalently, some finite-index subgroup
`W` has `W ≤ periods C`, since a supergroup of a finite-index subgroup has finite index
(`AddSubgroup.finiteIndex_of_le`). -/
def IsPeriodic (C : (addCayley S).Coloring (Fin k)) : Prop :=
  (periods C).FiniteIndex

/-- **The forced group `F`** (FS-73 §0, "The normal form"): the common periods of every proper `k`-colouring.
`mem_forcedSubgroup` identifies membership with `Forces (addCayley S) k 0 δ`, so the forced vectors are closed under
sums and negatives, with no argument beyond the definition. -/
def forcedSubgroup (S : Set A) (k : ℕ) : AddSubgroup A :=
  ⨅ C : (addCayley S).Coloring (Fin k), periods C

/-- **The H1 group `P`**: the common periods of every *periodic* proper `k`-colouring. When no periodic colouring
exists it is `⊤`. That is reduction R2's vacuous case, visible in the definition, and it is why `InheritanceQuestion`
carries the existence of one as a hypothesis. -/
def periodicForcedSubgroup (S : Set A) (k : ℕ) : AddSubgroup A :=
  ⨅ (C : (addCayley S).Coloring (Fin k)) (_ : IsPeriodic C), periods C

/-- Membership in the forced group is a forced pair at the origin. -/
theorem mem_forcedSubgroup {δ : A} : δ ∈ forcedSubgroup S k ↔ Forces (addCayley S) k 0 δ := by
  sorry

/-- **H1, pointwise**: membership in the H1 group says every periodic colouring identifies `0` and `δ`. The backward
direction translates each periodic colouring, which stays periodic with the same periods. -/
theorem mem_periodicForcedSubgroup {δ : A} :
    δ ∈ periodicForcedSubgroup S k ↔ ∀ C : (addCayley S).Coloring (Fin k), IsPeriodic C → C 0 = C δ := by
  sorry

/-- A translate of a colouring has at least the same periods, so translation preserves periodicity. This is the
backward direction of `mem_periodicForcedSubgroup`. -/
theorem periods_le_periods_comap_translate (C : (addCayley S).Coloring (Fin k)) (x : A) :
    periods C ≤ periods (C.comap (addCayleyTranslate S x)) := by
  sorry

/-- **A pulled-back quotient colouring is periodic under the kernel of the period map.** It is shared by R3 and by the
spec example on the path `ℤ`. -/
theorem ker_le_periods_comap {B : Type*} [AddCommGroup B] {π : A →+ B} {D : Set B} (tab : B → Fin k)
    (h : ∀ d ∈ D, ∀ x, tab (x + d) ≠ tab x) (hS : ∀ s ∈ S, π s ≠ 0) (hD : ∀ s ∈ S, π s ∈ D) :
    π.ker ≤ periods ((addCayleyColoring tab h).comap (addCayleyMap π hS hD)) := by
  sorry

/-- **A pulled-back quotient colouring is periodic** when the period map's kernel has finite index. This is the
colouring every `VoltageEscape` and every FS-70 quotient screen talks about. -/
theorem isPeriodic_comap {B : Type*} [AddCommGroup B] {π : A →+ B} {D : Set B} (tab : B → Fin k)
    (h : ∀ d ∈ D, ∀ x, tab (x + d) ≠ tab x) (hS : ∀ s ∈ S, π s ≠ 0) (hD : ∀ s ∈ S, π s ∈ D)
    (hfin : π.ker.FiniteIndex) : IsPeriodic ((addCayleyColoring tab h).comap (addCayleyMap π hS hD)) := by
  haveI := hfin
  exact AddSubgroup.finiteIndex_of_le (ker_le_periods_comap tab h hS hD)

/-- **A swap on a `w`-invariant set preserves the period `w`.** This is how R3's swapped colouring stays periodic. -/
theorem periodic_kempeSwap {C : (addCayley S).Coloring (Fin k)} {a b : Fin k} {K : Set A}
    (hK : KempeClosed C a b K) {w : A} (hC : Function.Periodic C w) (hKw : ∀ x, x + w ∈ K ↔ x ∈ K) :
    Function.Periodic (kempeSwap C a b K hK) w := by
  sorry

/-- **Residual finiteness, in the form R3 consumes.** In a finitely generated abelian group, a vector `e` outside `V`
is missed by some finite-index `W` between `V` and any finite-index `H ⊇ V`. Mathlib has the class
`AddGroup.ResiduallyFinite` and `exists_finiteIndexNormalSubgroup_notMem`, but at this pin it has no instance for
finitely generated abelian groups. The route is to apply the class to `A ⧸ V`, with the instance built from
`AddCommGroup.equiv_free_prod_directSum_zmod` (`ℤ` and finite groups are residually finite; products preserve it).
Then take `W = (pull-back of the missing subgroup) ⊓ H`. -/
theorem exists_finiteIndex_between_notMem [AddGroup.FG A] {V H : AddSubgroup A} (hVH : V ≤ H)
    (hH : H.FiniteIndex) {e : A} (he : e ∉ V) :
    ∃ W : AddSubgroup A, V ≤ W ∧ W ≤ H ∧ W.FiniteIndex ∧ e ∉ W := by
  sorry

/-- **One periodic separator refutes H1**: the statement R3 and every tools-side escape derive from. -/
theorem notMem_periodicForcedSubgroup_of_ne {C : (addCayley S).Coloring (Fin k)} (hC : IsPeriodic C) {δ : A}
    (h : C 0 ≠ C δ) : δ ∉ periodicForcedSubgroup S k :=
  fun hδ => h (mem_periodicForcedSubgroup.mp hδ C hC)

/-- `F ≤ P`: a period of every colouring is a period of every periodic one. -/
theorem forcedSubgroup_le_periodicForcedSubgroup : forcedSubgroup S k ≤ periodicForcedSubgroup S k :=
  le_iInf₂ fun C _ => iInf_le _ C

/-- **R3, the escape direction** (Poros, 2026-09-23). An escape certificate at a period of finite index puts `δ`
outside the H1 group: some *periodic* colouring separates `0` and `δ`. `V` may be enlarged to any `W′` with
`V ≤ W′ ≤ ker π`, and the certificate stays valid (see `VoltageEscape`). Since `ker π / V` is a finitely generated
abelian group, some finite-index `W′` of that kind misses `δ − p (π δ)`. Swapping on the enlarged lift is then
`W′`-periodic. So a single period-`N` certificate tests H1 at every period `W′ ⊇ V`. -/
theorem notMem_periodicForcedSubgroup_of_voltageEscape [AddGroup.FG A] {B : Type*} [AddCommGroup B] {π : A →+ B}
    {D : Set B} (e : VoltageEscape π S D k) (hS : ∀ s ∈ S, π s ≠ 0) (hD : ∀ s ∈ S, π s ∈ D)
    (hfin : π.ker.FiniteIndex) {δ : A} (hδ : δ ∉ e.lift) : δ ∉ periodicForcedSubgroup S k := by
  sorry

/-- **C3-inherit, stated and never claimed**: the question the FS-73 competition works, in its normal form. On a
Cayley graph of an abelian group that has some periodic proper `k`-colouring, is every common period of the periodic
colourings a common period of all colourings, `P ≤ F`? Per target the question is `δ ∈ P → δ ∈ F`, and
`mem_forcedSubgroup` turns the conclusion into "`(0, δ)` is forced", or, by `forces_iff_exists_finite`, "some finite
piece forces it". The existence hypothesis excludes the vacuous case, `P = ⊤`, which is its own question: C3-aper,
`[AbrishamiEtAl2025]` Problem 4.6 restricted to Cayley graphs of `ℤ^r`. -/
def InheritanceQuestion (S : Set A) (k : ℕ) : Prop :=
  (∃ C : (addCayley S).Coloring (Fin k), IsPeriodic C) → periodicForcedSubgroup S k ≤ forcedSubgroup S k

/-- C3-inherit is the equality of the two groups, `P = F`, once a periodic colouring exists. -/
theorem inheritanceQuestion_iff :
    InheritanceQuestion S k ↔
      ((∃ C : (addCayley S).Coloring (Fin k), IsPeriodic C) → periodicForcedSubgroup S k = forcedSubgroup S k) :=
  ⟨fun h hex => le_antisymm (h hex) forcedSubgroup_le_periodicForcedSubgroup, fun h hex => (h hex).le⟩

end Inheritance

/-! ### Named inhabitant of `VoltageEscape`, and the spec examples -/

/-- **The degenerate escape on `ℤ`, colour 2 a gap.** `π : ℤ → ZMod 2`, the quotient colouring `0 ↦ 0, 1 ↦ 1` in
`Fin 3`, `a = 0`, `b = 2`. No `b`-coloured class exists, so `Q0 = {0}`, the lift is `{0}`, and `δ = 2` escapes. This is
the fan-gap case of T10, and it is the certificate's named inhabitant. -/
def voltageEscapeZ : VoltageEscape (Int.castAddHom (ZMod 2)) ({1, -1} : Set ℤ) ({1} : Set (ZMod 2)) 3 where
  tab x := if x = 0 then 0 else 1
  proper := by sorry
  a := 0
  b := 2
  hab := by decide
  Q0 := {0}
  p _ := 0
  V := ⊥
  zero_mem := rfl
  p_zero := by simp
  p_class := by sorry
  V_ker := by sorry
  colour := by sorry
  closed := by sorry
  voltage := by sorry

/-- The inhabitant's escape is real: `2` lies outside its lift, and `¬ Forces (addCayley {1, -1}) 3 0 2` follows —
a fact the path graph `ℤ` with three colours makes plain. -/
example : (2 : ℤ) ∉ voltageEscapeZ.lift := by
  sorry

-- Spec check on the certificate's projection, one line.
example : voltageEscapeZ.a = 0 := rfl

/-- The model of `InheritanceQuestion`'s hypothesis: the path graph `ℤ` has a periodic `2`-colouring (parity, period
group `2ℤ`). Without an inhabitant, the question's premise could be empty, which is G30's failure mode 7. -/
example : ∃ C : (addCayley ({1, -1} : Set ℤ)).Coloring (Fin 2), IsPeriodic C := by
  sorry

/-- The forced group is neither `⊥` nor `⊤` on the smallest instance: every `2`-colouring of the path graph `ℤ`
alternates, so `2` is forced, while the edge `1` never is. On this toy `P = F = 2ℤ`, and C3-inherit holds. -/
example : (2 : ℤ) ∈ forcedSubgroup ({1, -1} : Set ℤ) 2 ∧ (1 : ℤ) ∉ forcedSubgroup ({1, -1} : Set ℤ) 2 := by
  sorry

end HadwigerNelson
