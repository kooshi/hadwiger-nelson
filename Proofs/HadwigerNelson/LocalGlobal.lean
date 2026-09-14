import Proofs.HadwigerNelson.ResidueObstruction
import Mathlib.NumberTheory.LegendreSymbol.Basic

/-!
# Local–global tightness: the periodic quotient, the counting bound, and the spindle that escapes its prime

The **local bound** of a real field `F` is the least number of colours any residue colouring of `F²` uses — at
the prime above `2` (Theorem B), at `3` (Fischer), and at every usable prime `p ≡ 3 (mod 4)` the chromatic number
of the finite plane `UD(𝔽_p, 2)` (M58). The conjecture M61 studies (`plans/M61-local-global-tightness.md`) is that
`χ(F²)` IS that bound wherever the bound is at most `6`. This module holds the three pieces of kernel content the
milestone's derivations produced:

* **The periodic quotient** (§S3). A colouring of a Cayley graph `addCayley S` that is constant on the cosets of a
  subgroup is a colouring of the quotient Cayley graph: an additive hom `π` whose kernel misses `S` is a graph hom
  `addCayley S →g addCayley D` for any `D` containing the projected connection set (`addCayleyMap`), so a colouring
  of the quotient pulls back (`colorable_of_addCayleyMap`). For the finite plane the quotient along a null
  direction (`projAlong v`) is a circulant on `p` vertices, and a table on `ZMod p` that is proper along the projected
  circle is a periodic colouring of the plane (`addCayleyColoring`, `unitQuadrance_colorable_of_quotient`). At `19`
  this is a nineteen-entry certificate of `χ(UD(𝔽₁₉, 2)) ≤ 5` (`Instances/LocalGlobal19.lean`).
* **The counting bound** (§S2). A `k`-colourable finite graph has at most `k · a` vertices when every independent
  set has at most `a` (`card_le_mul_of_colorable`), so `card ≤ k · indepNum` and, in `ℕ∞`, `card ≤ χ · α` — the
  fractional face of the first digit, whose consumer is a certified refutation of an independent set (none exists
  yet; the tools' α refusals are the solver's).
* **The spindle escapes its prime** (§S5). In `ZMod p` with `p ≡ 3 (mod 4)` there are no isotropic vectors
  (`quadrance_eq_zero_iff`), so a pair whose residues coincide has a residue-`0` squared distance; and a ring hom
  into a field cannot send `d` to `0` when the source holds the spindle radicand `√(4d − 1)` up to a unit without
  making `−1` a square in the target (`isSquare_neg_one_of_spindle_radicand`). Composed with M60's transfer: **a graph
  forcing a pair equal at `k` colours, drawn in a ring that holds that pair's spindle radicand, admits no reduction to
  a plane that is forces-free at `k`** (`Forces.no_hom_of_spindle_radicand`, `Forces.isEmpty_ringHom_of_spindle_radicand` — no reduction of the coordinate
  ring `R` at `p`).
  That is the mechanism of tightness: a forcer built as "fabric forcing a pair at `k` colours + the spindle over it"
  lands in a field where the prime that sealed the fabric at `k` is no longer usable — the local bound it beats is the
  one its own construction removes.

## What a consumer may conclude, and what not

The quotient theorems are about Cayley graphs and additive homs; the plane instance needs the projection to miss the
circle (a null direction), decided per prime, and gives an UPPER bound only. The counting bound is unconditional. The
radicand lemma is ring-level: the field-level statement ("every prime of `F(√(4d² − 1))` above `p` has even residue
degree") is a hand argument (`plans/M61-local-global-tightness.md` §S5), exactly as M58's integrality is.
`Forces.no_hom_of_spindle_radicand` takes the plane's forces-freeness as a hypothesis — a theorem at `11`
(`finitePlane11_forces_iff`), a two-table witness at `3` (`Instances/LocalGlobal19.lean`), measured at `7` and `19` — and
that hypothesis can only hold when the plane is `k`-colourable (a plane refusing `k` colours forces every pair vacuously).
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The circle and the quadrance, named -/

section Named

variable (R : Type*) [CommRing R]

/-- The unit circle of `R²`: the connection set `unitQuadrance R` is `addCayley` of. Reducible, so M58's inline
`v.1 ^ 2 + v.2 ^ 2 = 1` and this spelling never disagree. -/
abbrev unitCircle : Set (R × R) := {v | v.1 ^ 2 + v.2 ^ 2 = 1}

variable {R}

/-- The quadrance of a vector: Wildberger's squared length, `w.1 ^ 2 + w.2 ^ 2`. Reducible. -/
abbrev quadrance (w : R × R) : R := w.1 ^ 2 + w.2 ^ 2

theorem unitQuadrance_eq_addCayley : unitQuadrance R = addCayley (unitCircle R) := rfl

theorem mem_unitCircle {v : R × R} : v ∈ unitCircle R ↔ quadrance v = 1 := Iff.rfl

end Named

/-! ### The periodic quotient of a Cayley graph -/

section Quotient

variable {A B : Type*} [AddGroup A] [AddGroup B] {k : ℕ}

/-- **An additive hom whose kernel misses the connection set is a Cayley-graph homomorphism** onto any set holding the
projected connection set. Adjacent vertices differ by an element of `S`, whose image is nonzero and lies in `D`. -/
def addCayleyMap (π : A →+ B) {S : Set A} {D : Set B} (hS : ∀ s ∈ S, π s ≠ 0) (hD : ∀ s ∈ S, π s ∈ D) :
    addCayley S →g addCayley D where
  toFun := π
  map_rel' {a b} h := by
    rw [addCayley_adj] at h ⊢
    obtain ⟨-, h | h⟩ := h
    · refine ⟨fun heq => hS _ h ?_, Or.inl ?_⟩
      · rw [map_add, map_neg, heq, neg_add_cancel]
      · rw [← map_neg, ← map_add]; exact hD _ h
    · refine ⟨fun heq => hS _ h ?_, Or.inr ?_⟩
      · rw [map_add, map_neg, heq, neg_add_cancel]
      · rw [← map_neg, ← map_add]; exact hD _ h

@[simp] theorem addCayleyMap_apply (π : A →+ B) {S : Set A} {D : Set B} (hS : ∀ s ∈ S, π s ≠ 0)
    (hD : ∀ s ∈ S, π s ∈ D) (a : A) : addCayleyMap π hS hD a = π a := rfl

/-- **A colouring of the quotient is a colouring of the graph** — a periodic colouring, in the quotient's words. -/
theorem colorable_of_addCayleyMap (π : A →+ B) {S : Set A} {D : Set B} (hS : ∀ s ∈ S, π s ≠ 0)
    (hD : ∀ s ∈ S, π s ∈ D) (h : (addCayley D).Colorable k) : (addCayley S).Colorable k :=
  h.of_hom (addCayleyMap π hS hD)

/-- **A table proper along the connection set is a colouring of the Cayley graph.** The hypothesis is the decidable
one a finite instance checks — no coincidence `tab (x + d) = tab x` at any `d ∈ D` (M60's `CoincidesAtNonedges`
demands the coincidence at every non-edge; properness forbids it at every edge). -/
def addCayleyColoring {D : Set B} (tab : B → Fin k) (h : ∀ d ∈ D, ∀ x, tab (x + d) ≠ tab x) :
    (addCayley D).Coloring (Fin k) :=
  Coloring.mk tab fun {u v} hadj => by
    rw [addCayley_adj] at hadj
    obtain ⟨-, hd | hd⟩ := hadj
    · have := h _ hd u
      rw [add_neg_cancel_left] at this
      exact this.symm
    · have := h _ hd v
      rwa [add_neg_cancel_left] at this

/-- The pulled-back colouring is periodic at every element of the kernel — the periodic colourings of M60's
`Aperiodic` vocabulary are exactly these. -/
theorem periodic_comp_of_mem_ker (π : A →+ B) (tab : B → Fin k) {d : A} (hd : π d = 0) :
    Function.Periodic (fun a => tab (π a)) d :=
  fun a => by simp only [map_add, hd, add_zero]

end Quotient

section Family

variable {A : Type*} [AddCommGroup A] {k : ℕ}

/-- `Function.Periodic` computes on a finite domain. (M60's `Aperiodic` instance unfolds the same quantifier by hand;
with this instance `decide` reaches `Periodic` goals directly.) -/
instance decidablePeriodic {α β : Type*} [Fintype α] [Add α] [DecidableEq β] (f : α → β) (c : α) :
    Decidable (Function.Periodic f c) :=
  inferInstanceAs (Decidable (∀ x, f (x + c) = f x))

/-- **Colourings with no common nonzero period refute every forced pair** — M60's `forces_iff_eq_of_aperiodic`
is the case of one colouring; here each nonzero `d` may be refuted by a different one. -/
theorem Forces.eq_of_forall_exists_not_periodic {S : Set A}
    (h : ∀ d : A, d ≠ 0 → ∃ c : (addCayley S).Coloring (Fin k), ¬ Function.Periodic c d) {x y : A}
    (hf : Forces (addCayley S) k x y) : x = y := by
  by_contra hne
  obtain ⟨c, hc⟩ := h (y - x) (sub_ne_zero.mpr (Ne.symm hne))
  exact not_forces_zero_of_not_periodic c hc (forces_iff_forces_zero_sub.mp hf)

end Family

/-! ### The plane's periodic colourings -/

section Plane

variable {R : Type*} [CommRing R] {k : ℕ}

/-- **The projection along a direction `v`**: `w ↦ v.1·w.2 − v.2·w.1`, the 2-D determinant, whose kernel is the line
through `v`. When the line is null (misses the unit circle) it is the periodic quotient's projection. -/
def projAlong (v : R × R) : R × R →+ R where
  toFun w := v.1 * w.2 - v.2 * w.1
  map_zero' := by simp
  map_add' u w := by simp only [Prod.fst_add, Prod.snd_add]; ring

@[simp] theorem projAlong_apply (v w : R × R) : projAlong v w = v.1 * w.2 - v.2 * w.1 := rfl

/-- The direction itself lies in the kernel. -/
theorem projAlong_self (v : R × R) : projAlong v v = 0 := by simp [mul_comm]

/-- **The plane is `k`-colourable as soon as its quotient along a null direction is.** The circle must miss the
kernel (`hS`) and project into `D` (`hD`); a table on the quotient proper along `D` then colours the plane, with the
kernel's elements as periods. -/
theorem unitQuadrance_colorable_of_quotient (π : R × R →+ R) {D : Set R} (hS : ∀ s ∈ unitCircle R, π s ≠ 0)
    (hD : ∀ s ∈ unitCircle R, π s ∈ D) (tab : R → Fin k) (h : ∀ d ∈ D, ∀ x, tab (x + d) ≠ tab x) :
    (unitQuadrance R).Colorable k :=
  show (addCayley (unitCircle R)).Colorable k from
    colorable_of_addCayleyMap π hS hD ⟨addCayleyColoring tab h⟩

end Plane

/-! ### The counting bound -/

section Counting

variable {V : Type*} {G : SimpleGraph V} {k a : ℕ}

/-- **A `k`-colourable finite graph has at most `k · a` vertices when no independent set exceeds `a`**: the colour
classes partition the vertices into `k` independent sets. -/
theorem card_le_mul_of_colorable [Fintype V] (hα : ∀ s : Finset V, G.IsIndepSet (s : Set V) → s.card ≤ a)
    (h : G.Colorable k) : Fintype.card V ≤ k * a := by
  obtain ⟨C⟩ := h
  calc Fintype.card V = ∑ c : Fin k, (Finset.univ.filter fun v => C v = c).card := by
        rw [← Finset.card_univ, Finset.card_eq_sum_card_fiberwise (fun v _ => Finset.mem_univ (C v))]
    _ ≤ ∑ _c : Fin k, a := Finset.sum_le_sum fun c _ => hα _ fun u hu v hv _ hadj => by
        rw [Finset.mem_coe, Finset.mem_filter] at hu hv
        exact C.valid hadj (hu.2.trans hv.2.symm)
    _ = k * a := by simp [Finset.sum_const, Finset.card_univ]

/-- The bound at `a = indepNum`. -/
theorem card_le_mul_indepNum_of_colorable [Fintype V] (h : G.Colorable k) :
    Fintype.card V ≤ k * G.indepNum :=
  card_le_mul_of_colorable (fun _ hs => hs.card_le_indepNum) h

/-- The contrapositive — the consumer of a certified refutation of an independent set. -/
theorem not_colorable_of_mul_lt [Fintype V] (hα : ∀ s : Finset V, G.IsIndepSet (s : Set V) → s.card ≤ a)
    (h : k * a < Fintype.card V) : ¬ G.Colorable k :=
  fun hc => absurd (card_le_mul_of_colorable hα hc) (not_le.mpr h)

/-- **From a bound on the independence number to a lower bound on the chromatic number.** If no
independent set of a finite graph exceeds `a` points and `k · a` is fewer than the vertices, then `k`
colours do not suffice and `χ(G) ≥ k + 1`. This is the consumer of an independence-number
certificate: `not_colorable_of_mul_lt` supplies the refusal, `IsIndepSet.card_le_indepNum` turns the
`indepNum` bound into the per-finset bound it wants, and
`add_one_le_chromaticNumber_iff_not_colorable` does the `ℕ∞` arithmetic once.

`data/fs50/cert-p11-N29.json` with `tools/fplane_cert_check.py` is the shape of certificate that
discharges `h` outside the kernel; `Instances/IndependenceThreshold.lean` names the two instances
FS-50 is after. -/
theorem add_one_le_chromaticNumber_of_indepNum_le [Fintype V] (h : G.indepNum ≤ a)
    (hk : k * a < Fintype.card V) : ((k + 1 : ℕ) : ℕ∞) ≤ G.chromaticNumber :=
  add_one_le_chromaticNumber_iff_not_colorable.mpr
    (not_colorable_of_mul_lt (fun _s hs => hs.card_le_indepNum.trans h) hk)

/-- **The fractional face: `card ≤ χ · α`**, in `ℕ∞`. -/
theorem card_le_chromaticNumber_mul_indepNum [Fintype V] :
    (Fintype.card V : ℕ∞) ≤ G.chromaticNumber * G.indepNum := by
  have hne : G.chromaticNumber ≠ ⊤ := chromaticNumber_ne_top_iff_exists.mpr ⟨_, G.colorable_of_fintype⟩
  calc (Fintype.card V : ℕ∞) ≤ ((ENat.toNat G.chromaticNumber * G.indepNum : ℕ) : ℕ∞) := by
        exact_mod_cast card_le_mul_indepNum_of_colorable G.colorable_chromaticNumber_of_fintype
    _ = G.chromaticNumber * G.indepNum := by rw [Nat.cast_mul, ENat.coe_toNat_eq_self.mpr hne]

end Counting

/-! ### No isotropic vectors, and the spindle radicand -/

section Spindle

variable {p : ℕ} [Fact p.Prime]

-- G3 (FS-24, 2026-09-09). The theorems of this section were stated at `ZMod p` under `p % 4 = 3`,
-- and their proofs use that congruence for exactly one thing: to know `-1` is not a square. Each now
-- has a field-level form taking that as its hypothesis, with the `ZMod` statement kept verbatim as a
-- one-line corollary, so no caller and no ledger citation moves. `isSquare_neg_one_of_spindle_radicand`
-- was already stated over an arbitrary field; the wrapper immediately below it was what threw the
-- generality away. What this buys: the planes over fields with `p^n` elements -- `unitQuadrance` has
-- been ring-generic since M58 -- become expressible here, and that is the odd-degree face of the sieve
-- (M61's `UD(F_27, 2)`, Haugland's cubic field).

/-- **No isotropic vectors over a field where `-1` is not a square**: `a² + b² = 0` forces `a = b = 0`,
because otherwise `(a/b)² = -1`. -/
theorem sq_add_sq_eq_zero_iff_of_not_isSquare_neg_one {K : Type*} [Field K] (hK : ¬ IsSquare (-1 : K))
    {a b : K} : a ^ 2 + b ^ 2 = 0 ↔ a = 0 ∧ b = 0 := by
  constructor
  · intro h
    by_cases hb : b = 0
    · subst hb
      exact ⟨by simpa using h, rfl⟩
    · exact absurd ⟨a / b, by field_simp; linear_combination -h⟩ hK
  · rintro ⟨rfl, rfl⟩
    simp

/-- The same, for a vector of the plane over such a field. -/
theorem quadrance_eq_zero_iff_of_not_isSquare_neg_one {K : Type*} [Field K] (hK : ¬ IsSquare (-1 : K))
    {w : K × K} : quadrance w = 0 ↔ w = 0 := by
  show w.1 ^ 2 + w.2 ^ 2 = 0 ↔ w = 0
  rw [sq_add_sq_eq_zero_iff_of_not_isSquare_neg_one hK, Prod.ext_iff]
  exact Iff.rfl

/-- `p ≡ 3 (mod 4)` is one way to discharge the field hypothesis, through
`ZMod.exists_sq_eq_neg_one_iff`. -/
theorem not_isSquare_neg_one_zmod (hp : p % 4 = 3) : ¬ IsSquare (-1 : ZMod p) :=
  fun h => ZMod.exists_sq_eq_neg_one_iff.mp h hp

/-- **No isotropic vectors modulo a prime `≡ 3 (mod 4)`**: `a² + b² = 0` forces `a = b = 0`, because
otherwise `(a/b)² = −1` and `−1` is not a square (`ZMod.exists_sq_eq_neg_one_iff`). -/
theorem sq_add_sq_eq_zero_iff (hp : p % 4 = 3) {a b : ZMod p} : a ^ 2 + b ^ 2 = 0 ↔ a = 0 ∧ b = 0 :=
  sq_add_sq_eq_zero_iff_of_not_isSquare_neg_one (not_isSquare_neg_one_zmod hp)

/-- The same, for a vector of the plane. -/
theorem quadrance_eq_zero_iff (hp : p % 4 = 3) {w : ZMod p × ZMod p} : quadrance w = 0 ↔ w = 0 :=
  quadrance_eq_zero_iff_of_not_isSquare_neg_one (not_isSquare_neg_one_zmod hp)

/-- **The spindle radicand forces `√−1` into the target.** If `R` holds `x, e` with `x² = (4d − 1)·e²` — the radicand
of the spindle over a pair at squared distance `d`, up to the unit `e` — then a ring hom `φ` into a field that sends
`d` to `0` and keeps `e` nonzero makes `−1` a square: `φ(x/e)² = −1`. -/
theorem isSquare_neg_one_of_spindle_radicand {R K : Type*} [CommRing R] [Field K] (φ : R →+* K) {x d e : R}
    (hx : x ^ 2 = (4 * d - 1) * e ^ 2) (hd : φ d = 0) (he : φ e ≠ 0) : IsSquare (-1 : K) := by
  have h1 : φ x ^ 2 = -(φ e ^ 2) := by
    have := congrArg φ hx
    simp only [map_pow, map_mul, map_sub, map_one, hd] at this
    rw [this]; ring
  exact ⟨φ x / φ e, by rw [← sq, div_pow, h1, neg_div, div_self (pow_ne_zero 2 he)]⟩

/-- **The spindle radicand kills every field in which `-1` is not a square** — no such ring hom exists. -/
theorem no_ringHom_of_spindle_radicand_of_not_isSquare_neg_one {R K : Type*} [CommRing R] [Field K]
    (hK : ¬ IsSquare (-1 : K)) (φ : R →+* K) {x d e : R}
    (hx : x ^ 2 = (4 * d - 1) * e ^ 2) (hd : φ d = 0) (he : φ e ≠ 0) : False :=
  hK (isSquare_neg_one_of_spindle_radicand φ hx hd he)

/-- **The spindle radicand kills the prime**: at `p ≡ 3 (mod 4)` no such hom exists. -/
theorem no_ringHom_of_spindle_radicand {R : Type*} [CommRing R] (hp : p % 4 = 3) (φ : R →+* ZMod p) {x d e : R}
    (hx : x ^ 2 = (4 * d - 1) * e ^ 2) (hd : φ d = 0) (he : φ e ≠ 0) : False :=
  no_ringHom_of_spindle_radicand_of_not_isSquare_neg_one (not_isSquare_neg_one_zmod hp) φ hx hd he

/-- **A reduction that identifies two drawn points kills their squared distance.** A drawing `g` into `R` composed with
`φ` is a drawing into `S`; if that drawing sends `u` and `v` to one point, `φ` sends the quadrance of `g u − g v` to
`0`. -/
theorem quadrance_sub_eq_zero_of_map_eq {V R S : Type*} {G : SimpleGraph V} [CommRing R] [CommRing S] [Nontrivial S]
    (g : G →g unitQuadrance R) (φ : R →+* S) {u v : V}
    (h : (unitQuadrance.map φ).comp g u = (unitQuadrance.map φ).comp g v) : φ (quadrance (g u - g v)) = 0 := by
  have h1 : φ (g u).1 = φ (g v).1 := congrArg Prod.fst h
  have h2 : φ (g u).2 = φ (g v).2 := congrArg Prod.snd h
  simp [quadrance, h1, h2]

/-- **A forced pair's spindle escapes every plane that is forces-free at that many colours**, over any field
in which `-1` is not a square. `G` is drawn in `R` by `g`; the pair `u, v` is forced equal at `k` colours; the
plane `unitQuadrance K` is `k`-forces-free; then no ring hom `φ : R →+* K` can exist once `R` holds the pair's
spindle radicand — along `φ` the pair's residues coincide (`Forces.image` + forces-freeness), so `φ` kills the
squared distance, which the radicand lemma forbids. -/
theorem Forces.no_hom_of_spindle_radicand_of_not_isSquare_neg_one {V R K : Type*} {G : SimpleGraph V} [CommRing R]
    [Field K] {k : ℕ} (hK : ¬ IsSquare (-1 : K))
    (hfree : ∀ u v : K × K, Forces (unitQuadrance K) k u v → u = v)
    (g : G →g unitQuadrance R) (φ : R →+* K) {u v : V} (h : Forces G k u v) {x e : R}
    (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : φ e ≠ 0) : False :=
  have hf := h.image ((unitQuadrance.map φ).comp g)
  no_ringHom_of_spindle_radicand_of_not_isSquare_neg_one hK φ hx
    (quadrance_sub_eq_zero_of_map_eq g φ (hfree _ _ hf)) he

/-- The `ZMod` instance: at `p ≡ 3 (mod 4)`, against the finite plane `UD(ZMod p)`. -/
theorem Forces.no_hom_of_spindle_radicand {V R : Type*} {G : SimpleGraph V} [CommRing R] {k : ℕ} (hp : p % 4 = 3)
    (hfree : ∀ u v : ZMod p × ZMod p, Forces (finitePlane p) k u v → u = v)
    (g : G →g unitQuadrance R) (φ : R →+* ZMod p) {u v : V} (h : Forces G k u v) {x e : R}
    (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : φ e ≠ 0) : False :=
  Forces.no_hom_of_spindle_radicand_of_not_isSquare_neg_one (not_isSquare_neg_one_zmod hp) hfree g φ h hx he

/-- The consumer's shape over a field: with `e` a unit of `R`, **no ring hom from `R` — the coordinate ring
holding the radicand — to `K` exists at all**. -/
theorem Forces.isEmpty_ringHom_of_spindle_radicand_of_not_isSquare_neg_one {V R K : Type*} {G : SimpleGraph V}
    [CommRing R] [Field K] {k : ℕ} (hK : ¬ IsSquare (-1 : K))
    (hfree : ∀ u v : K × K, Forces (unitQuadrance K) k u v → u = v)
    (g : G →g unitQuadrance R) {u v : V} (h : Forces G k u v) {x e : R}
    (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : IsUnit e) : IsEmpty (R →+* K) :=
  ⟨fun φ => Forces.no_hom_of_spindle_radicand_of_not_isSquare_neg_one hK hfree g φ h hx (he.map φ).ne_zero⟩

/-- The consumer's shape: with `e` a unit of `R`, **no ring hom from `R` — the coordinate ring holding the radicand — to
`ZMod p` exists at all**. (That every prime of the FIELD above `p` then has even residue degree is the hand argument of
`plans/M61-local-global-tightness.md` §S5, not stated here.) -/
theorem Forces.isEmpty_ringHom_of_spindle_radicand {V R : Type*} {G : SimpleGraph V} [CommRing R] {k : ℕ}
    (hp : p % 4 = 3) (hfree : ∀ u v : ZMod p × ZMod p, Forces (finitePlane p) k u v → u = v)
    (g : G →g unitQuadrance R) {u v : V} (h : Forces G k u v) {x e : R}
    (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : IsUnit e) : IsEmpty (R →+* ZMod p) :=
  ⟨fun φ => Forces.no_hom_of_spindle_radicand hp hfree g φ h hx (he.map φ).ne_zero⟩

end Spindle

/-! ### Spec: the radicand lemma on the towers -/

instance : Fact (Nat.Prime 11) := ⟨by decide⟩

-- The Moser spindle's radicand: `11 = 4·3 − 1` for the rhombus's `√3`-pair. No hom `ℤ[√11] → ZMod 3`.
example : IsEmpty (Adjoin 11 ℤ →+* ZMod 3) :=
  ⟨fun φ => no_ringHom_of_spindle_radicand (by decide) φ (x := ⟨0, 1⟩) (d := 3) (e := 1) (by decide)
    (by rw [map_ofNat]; decide) (by rw [map_one]; exact one_ne_zero)⟩

-- The 6-level's radicand over a 5-sealed field: `43 = 4·11 − 1` for a forced `√11`-pair. No hom `ℤ[√43] → ZMod 11`.
example : IsEmpty (Adjoin 43 ℤ →+* ZMod 11) :=
  ⟨fun φ => no_ringHom_of_spindle_radicand (by decide) φ (x := ⟨0, 1⟩) (d := 11) (e := 1) (by decide)
    (by rw [map_ofNat]; decide) (by rw [map_one]; exact one_ne_zero)⟩

-- Positive controls: `√3 ↦ 5` reduces `ℤ[√3]` at `11` (`25 ≡ 3`), and `√11 ↦ 0` reduces `ℤ[√11]` at `11` — sending
-- the radicand's `d` to `0` alone is no obstruction; the spindle's `4d − 1 ≡ −1` is.
example : Adjoin 3 ℤ →+* ZMod 11 := Adjoin.lift (Int.castRingHom (ZMod 11)) 5 (by decide)
example : Adjoin 11 ℤ →+* ZMod 11 := Adjoin.lift (Int.castRingHom (ZMod 11)) 0 (by decide)

-- Red for the quotient: at `7` the direction `(1, 1)` is NOT null (`2 = 3²`), so `projAlong (1, 1)` kills a circle point
-- and `unitQuadrance_colorable_of_quotient` has no `hS` to take — a colouring constant on that line's cosets is improper.
example : ¬ ∀ s ∈ unitCircle (ZMod 7), projAlong ((1 : ZMod 7), (1 : ZMod 7)) s ≠ 0 := by decide

-- Reds for `p ≡ 3 (mod 4)`: at `5` the vector `(1, 2)` is isotropic, and `ℤ[√19] → ZMod 5` exists although `19 = 4·5 − 1`
-- (`√19 ↦ 2`): without the congruence neither the isotropy lemma nor the radicand lemma holds.
example : (1 : ZMod 5) ^ 2 + 2 ^ 2 = 0 := by decide
example : Adjoin 19 ℤ →+* ZMod 5 := Adjoin.lift (Int.castRingHom (ZMod 5)) 2 (by decide)

end HadwigerNelson
