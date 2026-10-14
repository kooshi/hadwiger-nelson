inductive T where
  | leaf (v : Int)
  | node (l r : T)

def T.zero (d : Nat) : T := Nat.rec (motive := fun _ => T) (.leaf 0) (fun _ t => .node t t) d

-- add v at position i (bit d-1 first)
def T.add (d : Nat) : T → Nat → Int → T :=
  Nat.rec (motive := fun _ => T → Nat → Int → T)
    (fun t _ v => T.casesOn (motive := fun _ => T) t (fun w => .leaf (w + v)) (fun l r => .node l r))
    (fun d ih t i v => T.casesOn (motive := fun _ => T) t (fun w => .leaf w)
      (fun l r => cond (Nat.beq ((i >>> d) % 2) 1) (.node l (ih r i v)) (.node (ih l i v) r))) d

def T.wsum : T → Nat → Int
  | .leaf v, _ => v
  | .node l r, i => T.wsum l (2*i) + (i : Int) * T.wsum r (2*i+1)

def run (n : Nat) : T → T :=
  Nat.rec (motive := fun _ => T → T) (fun t => t)
    (fun k ih t => ih (T.add 12 t ((k * 7919) % (2^12)) ((k : Int) % 1000 - 500))) n
set_option profiler true in
theorem t : T.wsum (run 20000 (T.zero 12)) 1 = -107901629547822269547367694 := by decide +kernel
