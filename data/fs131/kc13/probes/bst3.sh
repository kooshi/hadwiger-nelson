#!/bin/bash
# usage: bst3.sh K DEPTH  -- tree accumulator, recursors + cond + direct Nat ops, Nat values
K=$1; D=$2
BODY="inductive T where
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
    (fun k ih t => ih (T.add $D t (Nat.mod (Nat.mul k 7919) (2^$D)) (Nat.mod k 1000))) n"
printf '%s\n#eval T.wsum (run %s (T.zero %s)) 1\n' "$BODY" "$K" "$D" > /tmp/claude-1000/bst3_eval.lean
T=$(lean /tmp/claude-1000/bst3_eval.lean | tail -1)
printf '%s\nset_option profiler true in\ntheorem t : T.wsum (run %s (T.zero %s)) 1 = %s := by decide +kernel\n' "$BODY" "$K" "$D" "$T" > Bst3K.lean
echo "K=$K D=$D target=$T"
/usr/bin/time -v lean Bst3K.lean 2>&1 | grep -E "took|Maximum resident|Elapsed|error"
