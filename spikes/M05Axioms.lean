import Proofs.HadwigerNelson.Sat.MaskCheck
open HadwigerNelson

/-! The M05 skeleton's terminal test in miniature, as named declarations so `#print axioms` can
audit them. `Sat/MaskCheck.lean`'s spec section proves the same things as anonymous `example`s. -/

private def fldOf (v : Nat) (s : Bool) : Nat := (if s then 2 * v else 2 * v + 1) + 1
private def packOf (xs : List Nat) : Nat := xs.foldr (fun x acc => x ||| (acc <<< 8)) 0

private def tbl : ClauseTable :=
  { field := 8, lits := 2, perChunk := 2
    chunks :=
      .node 2
        (.node 1 (.leaf (packOf [fldOf 0 true, fldOf 1 true, fldOf 0 true, fldOf 1 false]))
                 (.leaf (packOf [fldOf 0 false, fldOf 1 true, fldOf 0 false, fldOf 1 false])))
        (.leaf (packOf [fldOf 0 true, 0, fldOf 0 false, 0])) }

private def f4 : Std.Sat.CNF Nat :=
  ⟨#[[(0, true), (1, true)], [(0, true), (1, false)],
     [(0, false), (1, true)], [(0, false), (1, false)]]⟩

private def cert : List Nat := [packOf [9, 4, 0, 1, 4, 2, 3, 5, 4, 5]]

/-- The emitted table really holds the formula — the trust boundary, run by the kernel. -/
theorem mini_agrees : tbl.agreesWithCNF f4 = true := by decide +kernel

/-- The certificate checks — a genuine three-step refutation, run by the kernel. -/
theorem mini_check : maskCheck tbl 8 4 cert = true := by decide +kernel

#print axioms mini_agrees
#print axioms mini_check
