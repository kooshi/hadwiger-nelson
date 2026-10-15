import ListLit
def sumS : List Nat → Nat → Nat
  | [], acc => acc
  | x :: r, acc => sumS r (Nat.add acc (Nat.mod x 1000003))
def sumR (l : List Nat) : Nat → Nat :=
  List.rec (motive := fun _ => Nat → Nat) (fun acc => acc) (fun x _ ih acc => ih (Nat.add acc (Nat.mod x 1000003))) l
#eval sumS xs 0
#eval sumR xs 0
