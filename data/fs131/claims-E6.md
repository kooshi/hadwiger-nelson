# FS131-E6 — the claim list: SHAVE's residual case (F6)

*Fixed by Keryx, 2026-10-05, before the job launches. Statements copied by script from the files named; no grade, no prior, no route.*

## ShaveAvailable (`Plane/ValidMap/Basic`, on `main`)

```lean
/-- **SHAVE is available at `v`** (FS110-N4-SHAVE): some horn, with flank colours `g` above and `h` below, splits along an arc
tangent to its axis, of a curvature `σ` between its bounding curvatures, into a lower part clear for `h` and an upper part
clear for `g` — so its tip may be recoloured by its two flanks. -/
def ShaveAvailable (v : ℂ) : Prop :=
  ∃ c g h α κ₁ κ₂ σ, F.IsHorn v α κ₁ κ₂ c ∧ F.IsFlankAbove v α κ₂ g ∧ F.IsFlankBelow v α κ₁ h ∧ κ₁ ≤ σ ∧ σ ≤ κ₂ ∧
    ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z)
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean`*

## exists_shave (`Plane/ValidMap/Contact`, on `main`)

```lean
/-- **FS110-N4-SHAVE**, the move: where SHAVE is available at `v` for a colour `c` with `n ≥ 1` sectors, recolouring the horn's
tip gives a valid map, agreeing with `F` off a small disc about `v` and creating no unit arc (Condition 5 kept when `F` has it),
in which `c` has `n − 1` sectors at `v`, no colour is added at `v`, and the new points on the disc's rim carry at most three
colours. Unit arcs are allowed (FS112-WALK, row 7: the split circle has curvature `σ ∈ [κ₁, κ₂] ⊆ [−1, 1]`, and `σ = ±1` puts it on
the horn's own bounding arc); the curvature bounds are what keeps the move from creating a unit arc. -/
theorem exists_shave (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    (hclear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z)) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`*

## IsModification (`Plane/ValidMap/Chain`, on `fs131-w5c`)

```lean
structure IsModification (M : ArcMap k) : Prop where
  /-- The same domain. -/
  dom_eq : M.dom = F.dom
  /-- No unit arc created. -/
  ringArcsWithin : M.RingArcsWithin F
  /-- A point of at least four colours in `M` carries them in `F`. -/
  coloursAt_subset : ∀ x, 4 ≤ (M.coloursAt x).ncard → M.coloursAt x ⊆ F.coloursAt x
```
*source: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`*

## exists_terminal (`Plane/ValidMap/Terminal`, on `fs131-w5c`)

```lean
/-- **FS112-N2-TERM**: every valid six-coloured map of the plane has a valid modification `M*` (the same domain, no unit arc created,
four-colour points' colours kept) which is a terminal valid map (`IsTerminalMap`: no MERGE, MERGE-RAY or SHAVE anywhere, every unit
arc (Q) or (R2)), in which (clause 2) every vertex — a point of at least three colours or with a repeated colour — is cubic
trichromatic, carries at least four colours (an NB4P exception), or is stuck; and (clause 3) every vertex stuck along `e α` lies on a
stuck run that is not bi-infinite, each finite end (the last chain vertex) within distance `1` of a point of a (Q) or (R2) arc or of a
point of at least four colours, and every horn bound `±1` at a vertex of the run, along `±e α`, a (Q) or (R2) arc. "One-sided infinite
chains are a GAP" is a not-claimed clause: nothing is stated about them. Inhabitant of the hypotheses: none at six colours is known
(a valid six-map of the plane is FS-114's open question); the statement's class at seven colours is inhabited by `sevenBrickMap`. -/
theorem exists_terminal {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ M : ArcMap 6, F.IsModification M ∧ M.IsTerminalMap ∧
      (∀ x ∈ M.dom, 3 ≤ (M.coloursAt x).ncard ∨ M.HasRepeatedColour x →
        M.IsCubicTrichromatic x ∨ 4 ≤ (M.coloursAt x).ncard ∨ M.IsStuck x) ∧
      ∀ v α, M.StuckAlong v α → (M.coloursAt v).ncard ≤ 3 →
        M.stuckRun v α ≠ univ ∧
        (∀ j ∈ M.stuckRun v α, (j + 1 ∉ M.stuckRun v α ∨ j - 1 ∉ M.stuckRun v α) →
          ∃ z, dist z (v + (j : ℂ) * e (α + π / 2)) ≤ 1 ∧ (M.OnQR2Arc z ∨ 4 ≤ (M.coloursAt z).ncard)) ∧
        ∀ j ∈ M.stuckRun v α, M.HornBoundsQR (v + (j : ℂ) * e (α + π / 2)) α ∧
          M.HornBoundsQR (v + (j : ℂ) * e (α + π / 2)) (α + π) := by
```
*source: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`*
## The question

> **Q — F6, SHAVE's residual case.** Can a valid map (in `exists_terminal`'s setting, or one reached from it by the moves W-MERGE, MERGE-RAY, SHAVE and the whole-arc bends) have a vertex `v` where `ShaveAvailable v` holds through a lone horn — its colour has a single sector at `v`, so `horn_bounds_of_noMerge` gives no curvature bound — whose only admissible split is `σ = ±1` with `κ₁ < σ < κ₂`, so that every shave there adds an arc of `ω(v ± n)` inside the horn, a unit arc `IsModification` forbids? Answer with a derivation that it cannot occur (in the setting where it would be met), a configuration exhibited exactly, or, if it can occur, what N4-TERM's route does there (another move, a repaired procedure, or a defect in `exists_terminal` as stated, with the smallest repair).

*Not claimed*: anything about vertices where the horn's colour has two or more sectors (bounded by `horn_bounds_of_noMerge`), or about splits strictly inside `[−1, 1]` (FS112-WALK row 7).
