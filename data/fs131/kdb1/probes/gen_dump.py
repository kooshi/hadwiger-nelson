"""Write a Lean file whose #eval dumps the Lean-computed entry states of every cell of plan800.json (JSON lines)."""
import json, sys
from fractions import Fraction as Fr
sys.path.insert(0, '/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/proto')
import proto_chain as PC
out = sys.argv[1]
plan = json.load(open('/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/proto/plan800.json'))
cells = plan['cells']
WS = 10**20
Ws = [int(w * WS) for w in PC.W]
w1N = int(PC.w1 * WS)
sumW = sum(abs(x) for x in Ws)
cl = ', '.join(f"({int(Fr(c[0]) * 2**20)}, {int(Fr(c[1]) * 2**20)}, {c[2]})" for c in cells)
body = open('/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/probes/CellProbe.lean').read()
body += f"""
namespace KDB1
def Ws : List Int := [{', '.join(map(str, Ws))}]
def Ds : List Int := [{', '.join(map(str, PC.Dt))}]
def etaOf (t1 : Int) : Int := cdiv ({sumW} * t1) (2 ^ TB)
def allCells : List (Int × Int × Nat) := [{cl}]
def stStr (l : List St) : String := "[" ++ ", ".intercalate (l.map fun s => s!"[{{s.m0}}, {{s.m1}}, {{s.r}}]") ++ "]"
def dump : IO Unit := do
  let mut sts : List St := Ws.map fun _ => ⟨S, 0, 0⟩
  let mut i := 0
  for (t0, w, N) in allCells do
    IO.println s!"{{i}} {{stStr sts}}"
    match cellOk {WS} {w1N} 99994 100000 Ws Ds sts t0 w N (etaOf (t0 + w)) with
    | some s => sts := s
    | none => IO.println s!"FAIL {{i}}"; return
    i := i + 1
  IO.println s!"{{i}} {{stStr sts}}"
end KDB1
#eval KDB1.dump
"""
open(out, 'w').write(body)
