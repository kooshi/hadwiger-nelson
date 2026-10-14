#!/bin/bash
# usage: bst2.sh K DEPTH  -- tree accumulator written with recursors and cond (no brecOn, no Decidable)
K=$1; D=$2
BODY="inductive T where
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
    (fun k ih t => ih (T.add $D t ((k * 7919) % (2^$D)) ((k : Int) % 1000 - 500))) n"
printf '%s\n#eval T.wsum (run %s (T.zero %s)) 1\n' "$BODY" "$K" "$D" > /tmp/claude-1000/bst2_eval.lean
T=$(lean /tmp/claude-1000/bst2_eval.lean | tail -1)
printf '%s\nset_option profiler true in\ntheorem t : T.wsum (run %s (T.zero %s)) 1 = %s := by decide +kernel\n' "$BODY" "$K" "$D" "$T" > Bst2K.lean
echo "K=$K D=$D target=$T"
/usr/bin/time -v lean Bst2K.lean 2>&1 | grep -E "took|Maximum resident|Elapsed|error"
