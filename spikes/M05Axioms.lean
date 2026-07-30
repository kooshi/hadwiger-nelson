import Proofs.HadwigerNelson.Sat.MaskCheck
open HadwigerNelson

/-! The M05 skeleton's terminal test in miniature, as named declarations so `#print axioms` can
audit them. `Sat/MaskCheck.lean`'s spec section proves the same thing as an anonymous `example`. -/

private def L2 : Layout := { field := 8, lits := 2, perChunk := 2 }
private def fldOf (v : Nat) (s : Bool) : Nat := (if s then 2 * v else 2 * v + 1) + 1
private def packOf (xs : List Nat) : Nat := xs.foldr (fun x acc => x ||| (acc <<< 8)) 0
private def tbl : ClauseTable :=
  .node 2 (.node 1 (.leaf (packOf [fldOf 0 true, fldOf 1 true, fldOf 0 true, fldOf 1 false]))
                   (.leaf (packOf [fldOf 0 false, fldOf 1 true, fldOf 0 false, fldOf 1 false])))
          (.leaf (packOf [fldOf 0 true, 0, fldOf 0 false, 0]))
private def cert : List Nat := [packOf [9, 4, 0, 1, 4, 2, 3, 5, 4, 5]]

theorem mini_check : maskCheck L2 tbl 4 cert = true := by decide +kernel

#print axioms mini_check
