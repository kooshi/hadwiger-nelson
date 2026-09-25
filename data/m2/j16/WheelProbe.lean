import Mathlib.Data.Fin.Basic
import Mathlib.Data.List.FinRange
import Mathlib.Data.Fin.VecNotation

set_option autoImplicit false

/-- S2f as a Bool on one wheel (w 0 the centre, w (i+1) rim point i). -/
def s2f (w : Fin 7 → Fin 4) : Bool :=
  let r := fun i : Fin 6 => w i.succ
  let proper := (List.finRange 6).all (fun i => w 0 != r i) &&
    (List.finRange 6).all (fun i => r i != r (i + 1))
  let nt := !(r 0 == r 2 && r 2 == r 4) && !(r 1 == r 3 && r 3 == r 5)
  !(proper && nt && r 2 == r 4) || (r 0 == r 3 && r 1 == r 5)

set_option maxRecDepth 4000 in
theorem s2f_all :
    (List.finRange 4).all (fun a => (List.finRange 4).all fun b => (List.finRange 4).all fun c =>
      (List.finRange 4).all fun d => (List.finRange 4).all fun e => (List.finRange 4).all fun f =>
      (List.finRange 4).all fun g => s2f ![a, b, c, d, e, f, g]) = true := by
  decide +kernel
