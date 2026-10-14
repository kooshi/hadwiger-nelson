inductive T where
  | leaf (v : Int)
  | node (l r : T)

def T.zero : Nat → T
  | 0 => .leaf 0
  | d+1 => .node (T.zero d) (T.zero d)

-- add v at position i (bits of i, most significant first, depth d)
def T.add : Nat → T → Nat → Int → T
  | 0, .leaf w, _, v => .leaf (w + v)
  | d+1, .node l r, i, v => if (i >>> d) % 2 == 0 then .node (T.add d l i v) r else .node l (T.add d r i v)
  | _, t, _, _ => t

def T.sum : T → Int
  | .leaf v => v
  | .node l r => T.sum l + T.sum r

def T.wsum : Nat → T → Int
  | _, .leaf v => v
  | i, .node l r => T.wsum (2*i) l + (i : Int) * T.wsum (2*i+1) r

def run (n : Nat) : T → T :=
  Nat.rec (motive := fun _ => T → T) (fun t => t)
    (fun k ih t => ih (T.add 12 t ((k * 7919) % (2^12)) ((k : Int) % 1000 - 500))) n
set_option profiler true in
theorem t : T.wsum 1 (run 20000 (T.zero 12)) = -107901629547822269547367694 := by decide +kernel
