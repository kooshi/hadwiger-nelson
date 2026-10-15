#!/bin/bash
# component costs at p=11 and p=19: K table, phase 1, an all-skip segment (p=11)
set -u
D=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/data/fs131/kc13
export LEAN_PATH=$D/lean:$D/p19:$(lean --print-libdir)
cd $D/cut
for P in 11 19; do
cat > Fp$P.lean <<EOT
import Cert$P
open HadwigerNelson.FibreCert
def hk : Nat := (ktable cert$P).foldl (fun a e => Nat.add a (e.2.foldl (fun b x => Nat.add b (Nat.add x.1 x.2)) 0)) 0
def hp : Nat := (OT.toList (phase1 cert$P).1).foldl (fun a r => Nat.add a (Nat.add r.2.2.1 r.2.2.2)) 0
#eval (hk % 1000007, hp % 1000007, segCheck cert$P 77)
EOT
v=$(lean Fp$P.lean | tr -d '()'); echo "p=$P eval $v"
IFS=', ' read k ph sk <<< "$v"
for t in "hk % 1000007 = $k" "hp % 1000007 = $ph" "segCheck cert$P 77 = $sk"; do
  head -5 Fp$P.lean > T.lean; echo "theorem t : $t := by decide +kernel" >> T.lean
  echo "== p=$P $t"
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 12 --cpus 1 --wait 3600 --name kc13-cut -- /usr/bin/time -f "%e s wall, %M KB peak" timeout 1800 lean T.lean 2>&1 | grep -v "slot: waiting" | tail -2
done
done
