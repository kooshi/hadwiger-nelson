import Proofs.HadwigerNelson.Outside.OAI158
import Proofs.HadwigerNelson.Instances.HexShell
open HadwigerNelson HadwigerNelson.Outside.OAI158
-- FS132-L1: the CONTROL for five-empty.lean — the same term at six colours. It must be refused: the import closes the
-- five-colour binders and not the six-colour ones (`SevenTarget`, `hexShell_plane6`).
theorem l1_control_sevenTarget_h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 6)) (x y : ℂ), dist x y = Real.sqrt 3 → C x ≠ C y :=
  fun C => (not_colorable_five ⟨C⟩).elim
