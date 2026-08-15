import Proofs.HadwigerNelson.Certificate

/-!
# Class-distance certification (M34)

`UDCert.Valid` certifies unit distances — the `r = 1` case of a general fact a pigeonhole
statement needs: that its listed pattern pairs really sit at the class distance. `PairsAt`
is that check at any squared distance `r`, decided by the same exact `Q4` arithmetic, and
`pairsAt_sound` is its bridge into real geometry: `dist … = √r`.

Lives in its own module — `Certificate.lean` is imported by every certificate table, and a
declaration edit there is a decision about hours of rebuild (the M11 trace rule).
-/

namespace HadwigerNelson

variable {n : ℕ}

/-- Every listed pair's stored squared distance is `r · denom²` — `UDCert.ValidOn` at class
distance `√r` instead of `1`. A decidable integer identity; a wrong pair cannot pass. -/
def UDCert.PairsAt (c : UDCert n) (ps : List (Fin n × Fin n)) (r : ℤ) : Bool :=
  ps.all fun p =>
    decide ((c.verts p.1).distSq (c.verts p.2) = ((r * (c.denom * c.denom) : ℤ) : Q4))

/-- The `Prop` reading of `PairsAt` — the bridge out of `Bool`, so downstream proofs never
destructure a `List.all`. -/
theorem UDCert.pairsAt_iff (c : UDCert n) (ps : List (Fin n × Fin n)) (r : ℤ) :
    c.PairsAt ps r = true ↔
      ∀ p ∈ ps, (c.verts p.1).distSq (c.verts p.2) = ((r * (c.denom * c.denom) : ℤ) : Q4) := by
  simp [PairsAt]

/-- **The geometric bridge at class distance.** An exact identity `distSq = r · D²` in `Q4`
says the plane points are exactly `√r` apart. The `r = 1` case is `dist_toPlane_eq_one`; no
nonnegativity hypothesis is needed — the conclusion rewrites through `normSq`, which carries
its own. -/
theorem dist_toPlane_eq_sqrt {p q : Pt} {D r : ℤ} (hD : D ≠ 0)
    (h : p.distSq q = ((r * (D * D) : ℤ) : Q4)) :
    dist (p.toPlane D) (q.toPlane D) = Real.sqrt (r : ℝ) := by
  have hD' : (D : ℝ) ≠ 0 := Int.cast_ne_zero.mpr hD
  have hev : (Q4.eval p.x - Q4.eval q.x) ^ 2 + (Q4.eval p.y - Q4.eval q.y) ^ 2 =
      (r : ℝ) * ((D : ℝ) * D) := by
    rw [← eval_distSq, h, map_intCast]; push_cast; ring
  have hnorm : Complex.normSq (p.toPlane D - q.toPlane D) = (r : ℝ) := by
    simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Pt.toPlane]
    field_simp
    linear_combination hev
  rw [Complex.dist_eq, Complex.norm_def, hnorm]

/-- **Soundness.** A passing `PairsAt` certifies every listed pair as a real `√r` distance in
the plane — the hypothesis the plane-level pigeonhole corollaries consume. -/
theorem UDCert.pairsAt_sound (c : UDCert n) (hd : c.denom ≠ 0) {ps : List (Fin n × Fin n)}
    {r : ℤ} (hv : c.PairsAt ps r = true) :
    ∀ p ∈ ps, dist (c.point p.1) (c.point p.2) = Real.sqrt (r : ℝ) :=
  fun p hp => dist_toPlane_eq_sqrt hd ((c.pairsAt_iff ps r).mp hv p hp)

/-- **Soundness at a perfect square, without the root.** When the class distance is a natural
number `m` — distance `2` is `PairsAt … (2 * 2)`, distance `5` is `PairsAt … (5 * 5)` — the
conclusion is `dist = m` directly. Every caller of `pairsAt_sound` at `r = 4` had been rewriting
`Real.sqrt 4 = 2` by hand (`Instances/HexShell.lean`, `Instances/Core122.lean`); this is that
rewrite, once. -/
theorem UDCert.pairsAt_sound_sq (c : UDCert n) (hd : c.denom ≠ 0) {ps : List (Fin n × Fin n)}
    {m : ℕ} (hv : c.PairsAt ps (m * m) = true) :
    ∀ p ∈ ps, dist (c.point p.1) (c.point p.2) = m := by
  intro p hp
  have h := c.pairsAt_sound hd hv p hp
  rwa [show (((m : ℤ) * (m : ℤ) : ℤ) : ℝ) = (m : ℝ) ^ 2 by push_cast; ring,
    Real.sqrt_sq (Nat.cast_nonneg m)] at h

/-- **A two-distance certificate is a realization at distances in `D`.** The unit edges (`Valid`)
and the class pairs (`PairsAt … r`) together realize the augmented edge list `c.edges ++ ps` in
any `D` containing `1` and `√r` — stated on adjacency, which is exactly the hypothesis
`Forces.planeIn`, `Separated.planeIn` and `distanceGraphHom` take, so no caller repeats the
append split. -/
theorem UDCert.adj_dist_mem (c : UDCert n) (hd : c.denom ≠ 0) (hv : c.Valid = true)
    {ps : List (Fin n × Fin n)} {r : ℤ} (hp : c.PairsAt ps r = true) {D : Set ℝ}
    (h1 : (1 : ℝ) ∈ D) (hr : Real.sqrt (r : ℝ) ∈ D) :
    ∀ i j, (edgeGraph n (c.edges ++ ps)).Adj i j → dist (c.point i) (c.point j) ∈ D := by
  have hunit := c.valid_sound hd hv
  have hcls := c.pairsAt_sound hd hp
  rintro i j ⟨-, hij | hji⟩
  · rcases List.mem_append.mp hij with h | h
    · exact (hunit (i, j) h : dist (c.point i) (c.point j) = 1) ▸ h1
    · exact (hcls (i, j) h : dist (c.point i) (c.point j) = _) ▸ hr
  · rw [dist_comm]
    rcases List.mem_append.mp hji with h | h
    · exact (hunit (j, i) h : dist (c.point j) (c.point i) = 1) ▸ h1
    · exact (hcls (j, i) h : dist (c.point j) (c.point i) = _) ▸ hr

/-! ## Specification

`ValidOn` is the `r = 1` face of `PairsAt`; the spec pins the agreement on the smallest
honest certificate, then checks a genuine `r ≠ 1` distance and the refusal on a wrong `r`. -/

section Spec

/-- `(0,0)` and `(2,0)` at scale `1`: squared distance `4`. -/
private def twoApart : UDCert 2 where
  verts := ![⟨0, 0⟩, ⟨2, 0⟩]
  edges := []
  denom := 1

example : twoApart.PairsAt [(0, 1)] 4 = true := by decide
example : twoApart.PairsAt [(0, 1)] 1 = false := by decide

/-- Non-vacuity all the way through: `PairsAt … 4` really does yield `dist = √4 = 2` in `ℂ`. -/
example : dist (twoApart.point 0) (twoApart.point 1) = 2 := by
  have h := twoApart.pairsAt_sound (by decide) (ps := [(0, 1)]) (r := 4) (by decide)
    (0, 1) (List.mem_singleton_self _)
  rwa [show Real.sqrt ((4 : ℤ) : ℝ) = 2 by
    rw [show ((4 : ℤ) : ℝ) = (2 : ℝ) ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]] at h

/-- The same, through `pairsAt_sound_sq` — no root to rewrite. -/
example : dist (twoApart.point 0) (twoApart.point 1) = 2 :=
  twoApart.pairsAt_sound_sq (by decide) (ps := [(0, 1)]) (m := 2) (by decide)
    (0, 1) (List.mem_singleton_self _)

end Spec

end HadwigerNelson
