import Proofs.HadwigerNelson.Rigidity.Pieces
import Proofs.HadwigerNelson.Rigidity.Duality
import Proofs.HadwigerNelson.Rigidity.DualConnected

-- FS131-KPD1 probe 2 (the experience pass at the consumer boundary): the three things `Rigidity/Pieces` leaves 8 and 9 read,
-- applied at the consumer's own types (`PieceDual M`) by `exact`, with no unfolding written by the consumer.

open HadwigerNelson HadwigerNelson.Rigidity

variable (M : Type) [AddCommGroup M] [Countable M]

-- leaf 9 (`isTotallyIrreducible_pieceAction`), the branch `N = 0`
example (Y : AddSubgroup (PieceDual M)) (hY : IsClosed (Y : Set (PieceDual M)))
    (h : dualCoannihilator (AddSubgroup.toSubgroup' Y) = ⊥) : Y = ⊤ :=
  eq_top_of_isClosed_of_dualCoannihilator_eq_bot' Y hY h

-- leaf 9, the branch `N ≠ 0`: `Y ⊆ N^⊥`, and `N^⊥` finite
example (Y : AddSubgroup (PieceDual M)) :
    AddSubgroup.toSubgroup' Y ≤ dualAnnihilator (dualCoannihilator (AddSubgroup.toSubgroup' Y)) :=
  le_dualAnnihilator_dualCoannihilator _
example (N : AddSubgroup M) [Finite (M ⧸ N)] : (dualAnnihilator N : Set (AddChar M Circle)).Finite :=
  finite_dualAnnihilator N

-- leaf 8 (`isSolenoid_pieceDual`), `dual_embeds`'s first map: continuous characters of `M̂` into `M`, injective
example : ∃ f : PontryaginDual (Multiplicative (PieceDual M)) →* Multiplicative M, Function.Injective f :=
  ⟨(additiveDualDualEquiv M).symm.toMonoidHom, (additiveDualDualEquiv M).symm.injective⟩

-- leaf 8, `connectedSpace`
example [IsAddTorsionFree M] : ConnectedSpace (PieceDual M) := connectedSpace_dual
