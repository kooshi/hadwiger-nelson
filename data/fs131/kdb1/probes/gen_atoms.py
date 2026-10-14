"""Write AtomProbe.lean: the DFS atom check, core only, from atoms.json. Mode 'full' or 'sub k' (fix vertices 0..k-1 out)."""
import json, sys
d = json.load(open(sys.argv[1])); out = sys.argv[2]; mode = sys.argv[3]
adj, groups, bound = d['adj'], d['groups'], d['bound']
OFF = 2**68
gl = '[' + ',\n  '.join('[' + ', '.join(str(m + 2**23 * (c + OFF)) for m, c in g) + ']' for g in groups) + ']'
body = f"""namespace KDB1A
/-- A term is `mask + 2^23 · (c + 2^68)`. -/
def addGroup (S : Nat) : List Nat → Int → Int
  | [], a => a
  | t :: l, a =>
    let m := t % 2 ^ 23
    addGroup S l (if m &&& S == m then a + ((t / 2 ^ 23 : Nat) : Int) - 2 ^ 68 else a)

/-- Every independent set `T ⊇ S` with `T ∩ [v, 23) ` decided by the recursion: `acc` is the sum of the
terms whose highest vertex is below `v`. -/
def dfs (bound : Int) : List Nat → List (List Nat) → Nat → Nat → Int → Bool
  | [], _, _, S, acc => S == 0 || decide (acc ≤ bound)
  | a :: adj, g :: gs, v, S, acc =>
    dfs bound adj gs (v + 1) S acc &&
      (a &&& S != 0 || dfs bound adj gs (v + 1) (S ||| 2 ^ v) (addGroup (S ||| 2 ^ v) g acc))
  | _, _, _, _, _ => false

def adjL : List Nat := {adj}
set_option maxRecDepth 100000 in
def groupsL : List (List Nat) := {gl}
def bound : Int := {bound}
"""
if mode == 'full':
    body += "theorem atoms_ok : dfs bound adjL groupsL 0 0 0 = true := by decide +kernel\n"
elif mode == 'eval':
    body += "#eval dfs bound adjL groupsL 0 0 0\n#eval dfs (bound - 10^13) adjL groupsL 0 0 0\n"
else:
    k = int(mode)
    # the subtree with vertices 0..k-1 all out: skip the first k vertices
    body += f"theorem atoms_sub : dfs bound (adjL.drop {k}) (groupsL.drop {k}) {k} 0 0 = true := by decide +kernel\n"
body += "end KDB1A\n"
open(out, 'w').write(body)
