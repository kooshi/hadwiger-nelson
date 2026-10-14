"""Append per-cell independent checks (literal entry and exit states) for cells [i0, i1) to CellProbe.lean."""
import json, sys
from fractions import Fraction as Fr
sys.path.insert(0, '/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/proto')
import proto_chain as PC
i0, i1, out = int(sys.argv[1]), int(sys.argv[2]), sys.argv[3]
plan = json.load(open('/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/proto/plan800.json'))
cells = plan['cells']
dump = {}
for ln in open(sys.argv[4]):
    k, v = ln.split(' ', 1)
    dump[int(k)] = json.loads(v)
WS = 10**20
Ws = [int(w * WS) for w in PC.W]
w1N = int(PC.w1 * WS)
sumW = sum(abs(x) for x in Ws)
def stl(sts): return '[' + ', '.join(f'⟨{a}, {b}, {r}⟩' for a, b, r in sts) + ']'
body = open('/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/probes/CellProbe.lean').read()
body += f"""
namespace KDB1
def Ws : List Int := [{', '.join(map(str, Ws))}]
def Ds : List Int := [{', '.join(map(str, PC.Dt))}]
def etaOf (t1 : Int) : Int := cdiv ({sumW} * t1) (2 ^ TB)
/-- One cell, checked from literal entry states against literal exit states (`m` equal, `r` dominated). -/
def cellCheck (sts : List St) (t0 w : Int) (N : Nat) (sts' : List St) : Bool :=
  match cellOk {WS} {w1N} 99994 100000 Ws Ds sts t0 w N (etaOf (t0 + w)) with
  | some s => (s.zip sts').all (fun p => p.1.m0 == p.2.m0 && p.1.m1 == p.2.m1 && decide (p.1.r ≤ p.2.r))
              && s.length == sts'.length
  | none => false
"""
for i in range(i0, i1):
    t0, w, N = Fr(cells[i][0]), Fr(cells[i][1]), cells[i][2]
    nxt = dump[i + 1]
    body += f"""
theorem cell_{i} : cellCheck {stl(dump[i])} {int(t0 * 2**20)} {int(w * 2**20)} {N}
    {stl(nxt)} = true := by decide +kernel
"""
body += "end KDB1\n"
open(out, 'w').write(body)
print(i1 - i0, "cells, N:", [cells[i][2] for i in range(i0, i1)])
