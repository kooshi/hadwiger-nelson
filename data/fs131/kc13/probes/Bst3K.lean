inductive T where
  | leaf (v : Nat)
  | node (l r : T)

def T.zero (d : Nat) : T := Nat.rec (motive := fun _ => T) (.leaf 0) (fun _ t => .node t t) d

def T.add (d : Nat) : T → Nat → Nat → T :=
  Nat.rec (motive := fun _ => T → Nat → Nat → T)
    (fun t _ v => T.casesOn (motive := fun _ => T) t (fun w => .leaf (Nat.add w v)) (fun l r => .node l r))
    (fun d ih t i v => T.casesOn (motive := fun _ => T) t (fun w => .leaf w)
      (fun l r => cond (Nat.beq (Nat.land (Nat.shiftRight i d) 1) 1) (.node l (ih r i v)) (.node (ih l i v) r))) d

def T.wsum : T → Nat → Nat
  | .leaf v, _ => v
  | .node l r, i => T.wsum l (2*i) + i * T.wsum r (2*i+1)

def run (n : Nat) : T → T :=
  Nat.rec (motive := fun _ => T → T) (fun t => t)
    (fun k ih t => ih (T.add 12 t (Nat.mod (Nat.mul k 7919) (2^12)) (Nat.mod k 1000))) n
set_option profiler true in
theorem t : T.wsum (run 20000 (T.zero 12)) 1 = 143519938169983132315682806 := by decide +kernel
