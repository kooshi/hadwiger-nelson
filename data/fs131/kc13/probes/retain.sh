#!/bin/bash
# usage: retain.sh K   -- kernel accumulation of K shifted values into a 4000-slot (1 Mbit) Nat
K=$1
BODY='def loopBig (n : Nat) : Nat → Nat :=
  Nat.rec (motive := fun _ => Nat → Nat) (fun acc => acc)
    (fun k ih acc => ih (acc + ((k % 1000 + 1) <<< (256 * ((k * 7919) % 4000))))) n'
printf '%s\n#eval (loopBig %s (1 <<< (256*4000))) %% 1000007\n' "$BODY" "$K" > /tmp/claude-1000/rk_eval.lean
T=$(lean /tmp/claude-1000/rk_eval.lean | tail -1)
printf '%s\nset_option profiler true in\ntheorem t : (loopBig %s (1 <<< (256*4000))) %% 1000007 = %s := by decide +kernel\n' "$BODY" "$K" "$T" > RetainK.lean
echo "K=$K target=$T"
/usr/bin/time -v lean RetainK.lean 2>&1 | grep -E "took|Maximum resident|Elapsed|error"
