
/-! ## PLANTED NEGATIVE CONTROLS — appended by `scripts/vacuity.sh --self-test`.

`CLAUDE.md` § "Make the gate fail, and watch it fail" requires every check's negative control to
be run at every milestone, and twice this repository has shipped a gate that failed OPEN. Until
2026-09-09 this gate's controls could not be run at all: `isOurs` could not see declarations made
in the file being elaborated, and `lake env lean` does not apply `autoImplicit := false`, so the
first control that did run silently became a different, generic statement and returned a
clean-looking wrong answer. Both are repaired; this block is the standing consequence. -/
namespace HadwigerNelson

/-- CONTROL 1 — the `core9_plane` shape, re-planted. The library PROVES this domain empty. -/
theorem planted_vacuous_coloring (_C : (unitDistance ℂ).Coloring (Fin 4)) : (1 : ℕ) = 1 := rfl

/-- CONTROL 2 — a tracked `Prop` the library REFUTES (`pathGraph_not_additivelyRigid_three`). -/
theorem planted_vacuous_prop (_h : AdditivelyRigid pathAddr (SimpleGraph.pathGraph 3) 3) :
    (1 : ℕ) = 1 := rfl

/-- CONTROL 3 — the SAME family at an instantiation the library says nothing about. Must come
back `UNKNOWN`, never `VACUOUS`: a check that flags this is matching the family name rather than
the instance, and is worthless. This is the load-bearing half of the pair. -/
theorem planted_unknown_prop (_h : AdditivelyRigid pathAddr (SimpleGraph.pathGraph 3) 5) :
    (1 : ℕ) = 1 := rfl

/-- CONTROL 4 — the refutation path, end to end: this theorem is the evidence. -/
theorem planted_not_forces : ¬ Forces (SimpleGraph.pathGraph 3) 3 0 1 := fun h =>
  pathColoring3.valid (SimpleGraph.pathGraph_adj.mpr (Or.inl rfl)) (h pathColoring3)

/-- CONTROL 5 — and this theorem is what the evidence must kill. `VACUOUS`. -/
theorem planted_vacuous_forces (_h : Forces (SimpleGraph.pathGraph 3) 3 0 1) : (1 : ℕ) = 1 := rfl

/-- CONTROL 6 — a declaration is a CHECKED claim, not a `# noqa`. The carrier here is witnessed,
so the annotation is false and must fail as `STALE`.
VACUITY DECLARED: a false claim, planted, and the gate must refuse it. -/
theorem planted_stale (_C : (SimpleGraph.pathGraph 3).Coloring (Fin 3)) : (1 : ℕ) = 1 := rfl

/-- CONTROL 7 — a refutation. Its binder is MEANT to be empty, so it must produce no row at all;
if it does, the check is flagging theorems for their own content. -/
theorem planted_refutation (C : (unitDistance ℂ).Coloring (Fin 4)) : False :=
  (isEmpty_coloring_plane_four).false C

/-- CONTROL 8 — the FS131-T1 carrier: a structure whose emptiness is a theorem
(`IsEmpty (AeColouring 1)`). Before `AeColouring` was tracked this raised no row at all. `VACUOUS`. -/
theorem planted_vacuous_ae (_c : Plane.AeColouring 1) (x : ℂ) : x = x := rfl

/-- CONTROL 9 — the same family at a variable `k`: parametric, nothing to witness. `GENERIC`. -/
theorem planted_generic_ae {k : ℕ} (_c : Plane.AeColouring k) (x : ℂ) : x = x := rfl

/-- CONTROL 10 — the same family at an instantiation nothing refutes. `UNKNOWN`, never `VACUOUS`: the
load-bearing half of the pair. (If the library ever proves `AeColouring 3` empty, retarget this at the
least `k` still unresolved.) -/
theorem planted_unknown_ae (_c : Plane.AeColouring 3) (x : ℂ) : x = x := rfl

/-- CONTROL 11 — an `ArcMap` predicate the library REFUTES at a concrete map: one colour on the whole
plane has two interior points at distance 1. The refutation is the evidence. -/
theorem planted_not_valid :
    ¬ (Plane.ArcMap.const (k := 1) Set.univ isOpen_univ 0).Valid := fun h => by
  have h1 := h 0 (by simp) 1 (by simp) (by simp)
  exact h1 rfl

/-- CONTROL 12 — and the statement it must kill. `VACUOUS`. -/
theorem planted_vacuous_valid
    (_h : (Plane.ArcMap.const (k := 1) Set.univ isOpen_univ 0).Valid) : (1 : ℕ) = 1 := rfl

/-- CONTROL 13 — `Valid` at a variable map: `GENERIC`, the correct reading of every "let `F` be a valid map". -/
theorem planted_generic_valid {k : ℕ} (F : Plane.ArcMap k) (_h : F.Valid) : (1 : ℕ) = 1 := rfl

/-- CONTROL 14 — a declaration the AUTHOR wrote that concludes a tracked structure must still be audited:
`isGeneratedDecl` skips the machine-written API of a structure and nothing else. `UNKNOWN`. -/
def planted_ae_def (c : Plane.AeColouring 3) : Plane.AeColouring 3 := c

/-- CONTROL 15 — FS131-T2's defect: a conclusion `≠` is `… → False` under a reducing telescope, and was
read as a refutation, so the empty carrier of its binder raised no row. A stated `≠` is not `False`: audited. `VACUOUS`. -/
theorem planted_vacuous_ne (_c : Plane.AeColouring 1) (x y : ℂ) (h : x = y + 1) : x ≠ y :=
  fun hxy => by subst hxy; simpa using congrArg (fun z => z - x) h

/-- CONTROL 16 — the same with a conclusion `¬ P` written as such. `VACUOUS`. -/
theorem planted_vacuous_not (_c : Plane.AeColouring 1) (x : ℂ) : ¬ (x = x + 1) := fun h => by
  simpa using congrArg (fun z => z - x) h

/-- CONTROL 17 — the `≠` shape at a variable `k`: parametric. `GENERIC`. -/
theorem planted_generic_ne {k : ℕ} (_c : Plane.AeColouring k) (x y : ℂ) (h : x = y + 1) : x ≠ y :=
  fun hxy => by subst hxy; simpa using congrArg (fun z => z - x) h

/-- CONTROL 18 — the `¬ P` shape at a variable `k`: parametric. `GENERIC`. -/
theorem planted_generic_not {k : ℕ} (_c : Plane.AeColouring k) (x : ℂ) : ¬ (x = x + 1) := fun h => by
  simpa using congrArg (fun z => z - x) h

/-- CONTROL 19 — a refutation written `P → False` over the same empty carrier: the stated conclusion is
`False`, so it stays skipped (a genuine refutation is not audited against the emptiness it proves). No row. -/
theorem planted_arrow_false (_c : Plane.AeColouring 1) (x : ℂ) (h : x = x + 1) : False := by
  simpa using congrArg (fun z => z - x) h

/-- CONTROL 20 — the `≠` shape at an instantiation nothing refutes: `UNKNOWN`, never `VACUOUS` (load-bearing). -/
theorem planted_unknown_ne (_c : Plane.AeColouring 3) (x y : ℂ) (h : x = y + 1) : x ≠ y :=
  fun hxy => by subst hxy; simpa using congrArg (fun z => z - x) h

/-- CONTROL 21 — wave 3's `IsRingArc` (FS131-I3h): a closed refutation at a concrete map (`halfPlane2`'s ring carries
no arc of `Γ`). The evidence for CONTROL 22. -/
theorem planted_not_ringArc : ¬ Plane.halfPlane2.IsRingArc 0 0 1 0 0 := Plane.halfPlane2_not_isRingArc 0 1 0 0

/-- CONTROL 22 — the statement it must kill. `VACUOUS`. -/
theorem planted_vacuous_ringArc (_h : Plane.halfPlane2.IsRingArc 0 0 1 0 0) : (1 : ℕ) = 1 := rfl

/-- CONTROL 23 — `IsRingArc` at a variable map: `GENERIC`. -/
theorem planted_generic_ringArc {k : ℕ} (F : Plane.ArcMap k) (p : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k)
    (_h : F.IsRingArc p θ₁ θ₂ c c') : (1 : ℕ) = 1 := rfl

/-- CONTROL 24 — `IsRingArc` at a concrete instance nothing decides (`sixFrag`'s ring over `(30°, 60°)` has side colours
`0` and `3`, so this one is false, but no theorem says so). `UNKNOWN`, never `VACUOUS`: the load-bearing half. -/
theorem planted_unknown_ringArc (_h : Plane.sixFrag.IsRingArc 0 (Real.pi / 6) (Real.pi / 3) 2 4) : (1 : ℕ) = 1 := rfl

/-- CONTROL 33 — wave 3's `IsQArc`: a closed refutation (no ring arc on `halfPlane2`'s ring, so no (Q) arc). -/
theorem planted_not_qArc : ¬ Plane.halfPlane2.IsQArc 0 0 1 := fun ⟨c, c', h, _⟩ =>
  Plane.halfPlane2_not_isRingArc 0 1 c c' h

/-- CONTROL 34 — the statement it must kill. `VACUOUS`. -/
theorem planted_vacuous_qArc (_h : Plane.halfPlane2.IsQArc 0 0 1) : (1 : ℕ) = 1 := rfl

/-- CONTROL 35 — `IsQArc` at a variable map: `GENERIC`. -/
theorem planted_generic_qArc {k : ℕ} (F : Plane.ArcMap k) (p : ℂ) (θ₁ θ₂ : ℝ) (_h : F.IsQArc p θ₁ θ₂) :
    (1 : ℕ) = 1 := rfl

/-- CONTROL 36 — `IsQArc` at a concrete instance nothing decides (true, as it happens, but proved nowhere
unconditionally). `UNKNOWN`. -/
theorem planted_unknown_qArc (_h : Plane.sixFrag.IsQArc 0 (Real.pi / 6) (Real.pi / 3)) : (1 : ℕ) = 1 := rfl

/-- CONTROL 25 — wave 3's `IsChangePoint`: a closed refutation (`r(90°) = i` is off `halfPlane2`'s `Γ`). -/
theorem planted_not_changePoint : ¬ Plane.halfPlane2.IsChangePoint 0 (Real.pi / 2) 0 1 := by
  rintro ⟨hΓ, -⟩
  have := Plane.halfPlane2_im_eq_zero_of_mem_Γ hΓ
  simp [Plane.ringPt, Plane.e_eq] at this

/-- CONTROL 26 — the statement it must kill. `VACUOUS`. -/
theorem planted_vacuous_changePoint (_h : Plane.halfPlane2.IsChangePoint 0 (Real.pi / 2) 0 1) : (1 : ℕ) = 1 := rfl

/-- CONTROL 27 — `IsChangePoint` at a variable map: `GENERIC`. -/
theorem planted_generic_changePoint {k : ℕ} (F : Plane.ArcMap k) (p : ℂ) (ψ : ℝ) (X X' : Fin k)
    (_h : F.IsChangePoint p ψ X X') : (1 : ℕ) = 1 := rfl

/-- CONTROL 28 — `IsChangePoint` at a concrete instance nothing decides. `UNKNOWN`. -/
theorem planted_unknown_changePoint (_h : Plane.sixFrag.IsChangePoint 0 (Real.pi / 4) 0 1) : (1 : ℕ) = 1 := rfl

/-- CONTROL 29 — wave 3's `IsHub`: a closed refutation (no change point at `r(90°)`). -/
theorem planted_not_hub : ¬ Plane.halfPlane2.IsHub 0 (Real.pi / 2) := by
  rintro ⟨⟨X, X', hΓ, -⟩, -⟩
  have := Plane.halfPlane2_im_eq_zero_of_mem_Γ hΓ
  simp [Plane.ringPt, Plane.e_eq] at this

/-- CONTROL 30 — the statement it must kill. `VACUOUS`. -/
theorem planted_vacuous_hub (_h : Plane.halfPlane2.IsHub 0 (Real.pi / 2)) : (1 : ℕ) = 1 := rfl

/-- CONTROL 31 — `IsHub` at a variable map: `GENERIC`. -/
theorem planted_generic_hub {k : ℕ} (F : Plane.ArcMap k) (p : ℂ) (ψ : ℝ) (_h : F.IsHub p ψ) : (1 : ℕ) = 1 := rfl

/-- CONTROL 32 — `IsHub` at a concrete instance nothing decides. `UNKNOWN`. -/
theorem planted_unknown_hub (_h : Plane.sixFrag.IsHub 0 (Real.pi / 4)) : (1 : ℕ) = 1 := rfl

/-- CONTROL 33 — wave 2's `CPColouring` at `1` colour: emptiness by an `instance` (the adversary). `VACUOUS`. -/
theorem planted_vacuous_cp (_c : Plane.CPColouring 1) (x : ℂ) : x = x := rfl

/-- CONTROL 34 — `CPColouring k` at a variable `k`: `GENERIC`. -/
theorem planted_generic_cp {k : ℕ} (_c : Plane.CPColouring k) (x : ℂ) : x = x := rfl

/-- CONTROL 35 — `CPColouring` at a `k` nothing refutes. `UNKNOWN`, never `VACUOUS`: the load-bearing half. -/
theorem planted_unknown_cp (_c : Plane.CPColouring 3) (x : ℂ) : x = x := rfl

/-- CONTROL 36 — wave 2's `SemiconcaveWith` at the instance `not_semiconcaveWith_one_lowerArc` refutes. `VACUOUS`. -/
theorem planted_vacuous_semiconcave
    (_h : Plane.SemiconcaveWith 1 (fun s : ℝ => 1 - Real.sqrt (1 - s ^ 2)) (Set.Ioo (1 / 10) (1 / 5))) : (1 : ℕ) = 1 := rfl

/-- CONTROL 37 — `SemiconcaveWith` at variable arguments: `GENERIC`. -/
theorem planted_generic_semiconcave {K : ℝ} {u : ℝ → ℝ} {J : Set ℝ} (_h : Plane.SemiconcaveWith K u J) : (1 : ℕ) = 1 := rfl

/-- CONTROL 38 — `SemiconcaveWith` at a concrete instance nothing decides (true, `0 ≤ 0`, but no theorem says so). `UNKNOWN`. -/
theorem planted_unknown_semiconcave (_h : Plane.SemiconcaveWith 0 (fun _ : ℝ => (0 : ℝ)) Set.univ) : (1 : ℕ) = 1 := rfl

end HadwigerNelson
