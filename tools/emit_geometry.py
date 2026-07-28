#!/usr/bin/env python3
"""Emit a self-contained Lean file that kernel-checks de Grey's geometry.

Measurement instrument for M02's representation decision: does an *indexed* vertex store survive
kernel `decide` at 1581 vertices / 7877 edges, or must the certificate carry pre-resolved endpoint
pairs (which duplicates every point ~5x)?

Deliberately imports no Mathlib: granular instances over an `Int` leaf, so the elapsed time is the
kernel's reduction cost and nothing else.

Usage:  python3 tools/emit_geometry.py {indexed|resolved|tree} [limit] > out.lean
"""
import sys, os
from fractions import Fraction as F
from math import gcd

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import degrey

PREAMBLE = r'''
/-- `K[√d]`. Granular instances: no Mathlib, so this file measures kernel reduction alone. -/
structure Adjoin (d : Nat) (K : Type) where
  re : K
  im : K
deriving DecidableEq, Inhabited

namespace Adjoin
variable {d : Nat} {K : Type}
instance [Add K] : Add (Adjoin d K) := ⟨fun x y => ⟨x.re + y.re, x.im + y.im⟩⟩
instance [Sub K] : Sub (Adjoin d K) := ⟨fun x y => ⟨x.re - y.re, x.im - y.im⟩⟩
instance [OfNat K 0] : OfNat (Adjoin d K) 0 := ⟨⟨0, 0⟩⟩

/-- Scalar multiplication by the radicand, pushed to the leaves.

Using the ring `(d : K) * z` instead costs a FULL tower multiplication by a constant that is zero
in 15 of its 16 components — it turns each level's 4 sub-multiplications into 5, so the leaf-mult
count per `Q4` product goes 4^4 = 256 → 5^4 = 625. -/
class SMulNat (K : Type) where smulNat : Nat → K → K
instance : SMulNat Int := ⟨fun n x => (n : Int) * x⟩
instance [SMulNat K] : SMulNat (Adjoin d K) :=
  ⟨fun n x => ⟨SMulNat.smulNat n x.re, SMulNat.smulNat n x.im⟩⟩

instance [Add K] [Mul K] [SMulNat K] : Mul (Adjoin d K) :=
  ⟨fun x y => ⟨x.re * y.re + SMulNat.smulNat d (x.im * y.im), x.re * y.im + x.im * y.re⟩⟩
end Adjoin

abbrev Q4 := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 Int)))

structure Pt where
  x : Q4
  y : Q4
deriving DecidableEq, Inhabited

def Pt.distSq (p q : Pt) : Q4 :=
  (p.x - q.x) * (p.x - q.x) + (p.y - q.y) * (p.y - q.y)
'''


def q4lit(co):
    """Nested-pair literal for a Q4 element, coefficients in mask order 0..15.

    Mask bit0↔√3, bit1↔√5, bit2↔√7, bit3↔√11; the tower nests √11 outermost, so a depth-first
    re-before-im flattening is exactly mask order.
    """
    def tree(lo, hi):
        if hi - lo == 1:
            v = co[lo]
            return f"({v})" if v < 0 else str(v)
        mid = (lo + hi) // 2
        return "⟨" + tree(lo, mid) + "," + tree(mid, hi) + "⟩"
    return tree(0, 16)


def ptlit(p, L):
    xs = [int(f * L) for f in p[0]]
    ys = [int(f * L) for f in p[1]]
    return "⟨" + q4lit(xs) + "," + q4lit(ys) + "⟩"


def common_denom(V):
    L = 1
    for p in V:
        for comp in p:
            for f in comp:
                L = L * f.denominator // gcd(L, f.denominator)
    return L


def main():
    variant = sys.argv[1] if len(sys.argv) > 1 else "indexed"
    limit = int(sys.argv[2]) if len(sys.argv) > 2 else 0

    _, _, _, G = degrey.build()
    E = degrey.edges(G)
    if limit:
        G = G[:limit]
        keep = set(range(limit))
        E = [(i, j) for (i, j) in E if i in keep and j in keep]
    L = common_denom(G)

    out = [PREAMBLE]
    out.append(f"\n-- de Grey: {len(G)} vertices, {len(E)} edges, denominator {L}\n")
    target = [L * L] + [0] * 15
    out.append(f"def target : Q4 := {q4lit(target)}\n")

    if variant == "resolved":
        out.append("def edgePairs : List (Pt × Pt) :=\n [")
        out.append(",\n  ".join(f"({ptlit(G[i], L)}, {ptlit(G[j], L)})" for i, j in E))
        out.append("]\n")
        out.append("def valid : Bool := edgePairs.all fun e => decide (e.1.distSq e.2 = target)\n")
    elif variant == "indexed":
        out.append("def verts : List Pt :=\n [")
        out.append(",\n  ".join(ptlit(p, L) for p in G))
        out.append("]\n")
        out.append("def edges : List (Nat × Nat) :=\n [")
        out.append(",".join(f"({i},{j})" for i, j in E))
        out.append("]\n")
        out.append("""
def valid : Bool := edges.all fun e =>
  decide ((verts.getD e.1 default).distSq (verts.getD e.2 default) = target)
""")
    elif variant == "tree":
        # Balanced binary tree keyed on the index's bits: O(log n) kernel lookup.
        out.append("""
inductive PtTree where
  | leaf : Pt → PtTree
  | node : PtTree → PtTree → PtTree
deriving Inhabited

def PtTree.get : PtTree → Nat → Nat → Pt
  | .leaf p, _, _ => p
  | .node l r, i, depth+1 => if i % 2 == 0 then l.get (i/2) depth else r.get (i/2) depth
  | .node l _, _, 0 => l.get 0 0
""")
        n = len(G)
        depth = max(1, (n - 1).bit_length())
        size = 1 << depth

        # `get` consumes the index's low bit at each level, so split even/odd to match.
        def rec(idxs):
            if len(idxs) == 1:
                p = G[idxs[0]] if idxs[0] < n else G[0]
                return ".leaf " + ptlit(p, L)
            ev = idxs[0::2]
            od = idxs[1::2]
            return "(.node " + rec(ev) + " " + rec(od) + ")"

        out.append(f"def vertTree : PtTree := {rec(list(range(size)))}\n")
        out.append("def edges : List (Nat × Nat) :=\n [")
        out.append(",".join(f"({i},{j})" for i, j in E))
        out.append("]\n")
        out.append(f"""
def valid : Bool := edges.all fun e =>
  decide ((vertTree.get e.1 {depth}).distSq (vertTree.get e.2 {depth}) = target)
""")

    out.append("\n#eval valid\n")
    out.append("set_option maxRecDepth 1000000 in\nset_option maxHeartbeats 0 in\n"
               "example : valid = true := by decide\n")
    out.append("#print axioms valid\n")
    sys.stdout.write("".join(out))


if __name__ == "__main__":
    main()
