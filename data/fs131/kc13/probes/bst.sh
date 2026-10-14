#!/bin/bash
# usage: bst.sh K DEPTH  -- K updates of a complete binary tree accumulator of 2^DEPTH leaves, keyed by position bits
K=$1; D=$2
BODY="inductive T where
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
    (fun k ih t => ih (T.add $D t ((k * 7919) % (2^$D)) ((k : Int) % 1000 - 500))) n"
printf '%s\n#eval T.wsum 1 (run %s (T.zero %s))\n' "$BODY" "$K" "$D" > /tmp/claude-1000/bst_eval.lean
T=$(lean /tmp/claude-1000/bst_eval.lean | tail -1)
printf '%s\nset_option profiler true in\ntheorem t : T.wsum 1 (run %s (T.zero %s)) = %s := by decide +kernel\n' "$BODY" "$K" "$D" "$T" > BstK.lean
echo "K=$K D=$D target=$T"
/usr/bin/time -v lean BstK.lean 2>&1 | grep -E "took|Maximum resident|Elapsed|error"
