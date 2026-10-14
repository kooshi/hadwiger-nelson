"""Append probe data to a copy of CellProbe.lean: cells [i0, i1) of plan800.json, entry states from the plan."""
import json, sys
from fractions import Fraction as Fr
sys.path.insert(0, '/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/proto')
import proto_chain as PC
i0, i1, out, mode = int(sys.argv[1]), int(sys.argv[2]), sys.argv[3], sys.argv[4]
plan = json.load(open('/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/proto/plan800.json'))
cells = plan['cells'][i0:i1]
WS = 10**20
Ws = [int(w * WS) for w in PC.W]
assert all(Fr(x, WS) == w for x, w in zip(Ws, PC.W))
w1N = int(PC.w1 * WS); assert Fr(w1N, WS) == PC.w1
Ds = PC.Dt
sts = cells[0][4]
cl = []
for c in cells:
    t0, w = Fr(c[0]), Fr(c[1])
    cl.append(f"({int(t0 * 2**20)}, {int(w * 2**20)}, {c[2]})")
sumW = sum(abs(x) for x in Ws)
body = open('/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g/data/fs131/kdb1/probes/CellProbe.lean').read()
body += f"""
namespace KDB1
def Ws : List Int := [{', '.join(map(str, Ws))}]
def Ds : List Int := [{', '.join(map(str, Ds))}]
def sts0 : List St := [{', '.join(f'⟨{a}, {b}, {r}⟩' for a, b, r in sts)}]
def cells0 : List (Int × Int × Nat) := [{', '.join(cl)}]
def etaOf (t1 : Int) : Int := cdiv ({sumW} * t1) (2 ^ TB)
def run0 : Option (List St) := cellsOk {WS} {w1N} 99994 100000 Ws Ds etaOf sts0 cells0
end KDB1
"""
if mode == 'eval':
    body += "\n#eval (KDB1.run0.map fun l => l.map fun s => (s.m0, s.m1, s.r)).isSome\n"
    body += "#eval (KDB1.run0.map fun l => (l.head!.m0, l.head!.r))\n"
else:
    body += "\nset_option maxRecDepth 100000 in\ntheorem KDB1.run0_ok : KDB1.run0.isSome = true := by decide +kernel\n"
open(out, 'w').write(body)
print("cells", len(cells), "from t", cells[0][0], "to", Fr(cells[-1][0]) + Fr(cells[-1][1]))
