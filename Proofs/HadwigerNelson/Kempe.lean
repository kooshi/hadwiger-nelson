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
* **The hypothesis H1 and its equivalence with Kempe rigidity** (`PeriodicForces`,
  `not_periodicForces_of_voltageEscape`): if every periodic colouring identifies `0` and `δ`, no voltage
  certificate escapes at `δ`. The swap is re-periodised through a finite-index subgroup that contains `V` and
  misses the escape (residual finiteness of finitely generated abelian groups; Poros, 2026-09-23).
* **The question itself** (`InheritanceQuestion`): a `Prop`, stated and never claimed.
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

theorem kempeSwap_apply_of_mem (C : G.Coloring (Fin k)) {a b : Fin k} {K : Set V} (hK : KempeClosed C a b K)
    {v : V} (hv : v ∈ K) : kempeSwap C a b K hK v = Equiv.swap a b (C v) := by
  sorry

theorem kempeSwap_apply_of_not_mem (C : G.Coloring (Fin k)) {a b : Fin k} {K : Set V} (hK : KempeClosed C a b K)
    {v : V} (hv : v ∉ K) : kempeSwap C a b K hK v = C v := by
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

/-- **The lift is Kempe-closed for the pulled-back colouring.** -/
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
`φ z = b`, `φ w = −b`. A target in the kernel of `φ` outside `R_b` escapes. To be derived from
`not_forces_of_voltageEscape` with `Q0 = {0, b}`, `V = R_b`. -/
theorem not_forces_of_additiveKempe {Γ : Type*} [AddCommGroup Γ] [Fintype Γ] (hk : Fintype.card Γ = k)
    (φ : A →+ Γ) (hφ : ∀ s ∈ S, φ s ≠ 0) (hSneg : ∀ s ∈ S, -s ∈ S) {b : Γ} (hb : b ≠ 0) {δ : A}
    (hδ0 : φ δ = 0)
    (hδ : δ ∉ AddSubgroup.closure {x | ∃ z ∈ S, ∃ w ∈ S, φ z = b ∧ φ w = -b ∧ x = z + w}) :
    ¬ Forces (addCayley S) k 0 δ := by
  sorry

end Voltage

/-! ### The inheritance question: its hypothesis H1, and H1 ⟺ Kempe rigidity -/

section Inheritance

variable {A : Type*} [AddCommGroup A] {k : ℕ}

/-- A colouring of `addCayley S` is **periodic under `W`** when every translation by `W` preserves it. -/
def IsPeriodicUnder {S : Set A} (C : (addCayley S).Coloring (Fin k)) (W : AddSubgroup A) : Prop :=
  ∀ w ∈ W, ∀ x, C (x + w) = C x

/-- **H1 (FS-73 §0):** every periodic `k`-colouring (periodic under some finite-index subgroup) identifies `0` and
`δ`. On a lattice with no periodic colouring it holds vacuously. That is why `InheritanceQuestion` carries the
existence of one as a hypothesis (reduction R2). -/
def PeriodicForces (S : Set A) (k : ℕ) (δ : A) : Prop :=
  ∀ W : AddSubgroup A, W.FiniteIndex → ∀ C : (addCayley S).Coloring (Fin k), IsPeriodicUnder C W → C 0 = C δ

/-- **H1 implies Kempe rigidity (H2), contrapositive form** (Poros, 2026-09-23). An escape certificate at a period
of finite index gives a *periodic* separating colouring. `NΛ` permutes the Kempe components of the `NΛ`-periodic
pull-back, and a finitely generated abelian group is residually finite, so some finite-index `W′` with
`V ⊆ W′ ⊆ ker π` misses the escape. Swapping on `lift + W′` is then `W′`-periodic. -/
theorem not_periodicForces_of_voltageEscape [AddGroup.FG A] {B : Type*} [AddCommGroup B] {π : A →+ B}
    {S : Set A} {D : Set B} (e : VoltageEscape π S D k) (hS : ∀ s ∈ S, π s ≠ 0) (hD : ∀ s ∈ S, π s ∈ D)
    (hfin : π.ker.FiniteIndex) {δ : A} (hδ : δ ∉ e.lift) : ¬ PeriodicForces S k δ := by
  sorry

/-- **C3-inherit, stated and never claimed** — the question the FS-73 competition works: on a Cayley graph of an
abelian group, if some periodic `k`-colouring exists and every periodic `k`-colouring identifies `0` and `δ`, are
`0` and `δ` forced? By `forces_iff_exists_finite` the conclusion is "some finite piece forces the pair". The
existence hypothesis excludes the vacuous case, which is its own question (C3-aper, `[AbrishamiEtAl2025]`
Problem 4.6 restricted to Cayley graphs of `ℤ^r`). -/
def InheritanceQuestion (S : Set A) (k : ℕ) (δ : A) : Prop :=
  (∃ W : AddSubgroup A, W.FiniteIndex ∧ ∃ C : (addCayley S).Coloring (Fin k), IsPeriodicUnder C W) →
    PeriodicForces S k δ → Forces (addCayley S) k 0 δ

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

end HadwigerNelson
