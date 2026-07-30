#!/usr/bin/env python3
"""Emit a Lean file holding a literal pivot-split tree of big `Nat` chunks, plus a kernel
benchmark of the real inner loop: chunk lookup -> clause reconstruction -> propagation.

This is the M05 shape under test: the clause database as a LITERAL (so the kernel indexes it
instead of re-deriving it), packed into few big `Nat`s (so the olean does not pay ~2.3 KB per
`Nat` literal 37,000 times over)."""
import sys
sys.set_int_max_str_digits(200000)

NVARS = 6324
NCLAUSES = int(sys.argv[4]) if len(sys.argv) > 4 else 37000
LITS = 8            # literals per clause slot (input clauses are 2-4; learned ones are longer)
FIELD = 24          # bits per packed literal field
SLOT = (LITS + 1) * FIELD   # + terminator
CHUNKBITS = int(sys.argv[3]) if len(sys.argv) > 3 else 50000
PERBLOCK = max(1, CHUNKBITS // SLOT)
NBLOCKS = (NCLAUSES + PERBLOCK - 1) // PERBLOCK
STEPS = int(sys.argv[1]) if len(sys.argv) > 1 else 2000
MODE = sys.argv[2] if len(sys.argv) > 2 else "full"

def zig(v, sign):      # variable v, sign True=positive; field 0 is the terminator
    return ((v << 1) | (0 if sign else 1)) + 1

blocks = []
for b in range(NBLOCKS):
    w = 0
    for s in range(PERBLOCK):
        cid = b * PERBLOCK + s
        slot = 0
        for k in range(LITS):
            v = (cid * 7919 + k * 104729) % NVARS
            slot |= zig(v, (cid + k) % 3 != 0) << (k * FIELD)
        w |= slot << (s * SLOT)
    blocks.append(w)

def tree(lo, hi):
    if hi - lo == 1:
        return f"CT.leaf {blocks[lo]}"
    mid = (lo + hi) // 2
    return f"CT.node {mid - lo} ({tree(lo, mid)}) ({tree(mid, hi)})"

idlit = "[" + ", ".join(str((i*7919+13) % NCLAUSES) for i in range(STEPS)) + "]"
print(f"""-- generated: {NBLOCKS} chunks x {PERBLOCK} clauses x {SLOT} bits = {NCLAUSES} clauses
set_option maxRecDepth 4000000

inductive CT where
  | leaf : Nat → CT
  | node : Nat → CT → CT → CT

/-- M04's pivot-split lookup, over big `Nat` chunks instead of points. -/
def CT.get : CT → Nat → Nat
  | .leaf w, _ => w
  | .node m l r, i => if i < m then l.get i else r.get (i - m)

def SLOT : Nat := {SLOT}
def FIELD : Nat := {FIELD}
def PERBLOCK : Nat := {PERBLOCK}
def LITS : Nat := {LITS}

/-- The packed slot for clause `id`: descend the literal tree, then one shift and one mask. -/
def slotOf (t : CT) (id : Nat) : Nat :=
  ((t.get (id / PERBLOCK)) >>> ((id % PERBLOCK) * SLOT)) % (2 ^ SLOT)

/-- Rebuild a clause's two dense bitmasks from its packed literal fields. Structural on a fuel
equal to the slot's literal capacity; a zero field terminates. -/
def masksOf : Nat → Nat → Nat → Nat → Nat × Nat
  | 0,   _, p, n => (p, n)
  | f+1, w, p, n =>
      let fld := w % (2 ^ FIELD)
      if fld == 0 then (p, n)
      else
        let e := fld - 1
        if e % 2 == 0 then masksOf f (w >>> FIELD) (p ||| (1 <<< (e / 2))) n
        else masksOf f (w >>> FIELD) p (n ||| (1 <<< (e / 2)))

/-- The real inner loop: lookup, reconstruct, set-difference, single-bit test, update. -/
def bench (t : CT) (pos neg acc : Nat) : List Nat → Nat
  | []         => acc
  | id :: rest =>
      let (cp, cn) := masksOf LITS (slotOf t id) 0 0
      let up := cp ^^^ (cp &&& neg)
      let un := cn ^^^ (cn &&& pos)
      let u  := up ||| un
      let hit := (u == 0) || (u &&& (u - 1) == 0)
      bench t (pos ||| up) (neg ||| un) (if hit then acc + 1 else acc) rest

/-- Lookup and reconstruction only, no propagation arithmetic — isolates the table cost. -/
def benchLookup (t : CT) (acc : Nat) : List Nat → Nat
  | []         => acc
  | id :: rest =>
      let (cp, cn) := masksOf LITS (slotOf t id) 0 0
      benchLookup t (acc + cp % 2 + cn % 2) rest

def ids : List Nat := (List.range {STEPS}).map fun i => (i * 7919 + 13) % {NCLAUSES}
def idsLit : List Nat := {idlit}

def table : CT := {tree(0, NBLOCKS)}
""")

if MODE == "full":
    print("theorem bm : bench table 0 0 0 ids ≠ 999999999 := by decide +kernel")
elif MODE == "lookup":
    print("theorem bm : benchLookup table 0 ids ≠ 999999999 := by decide +kernel")
elif MODE == "listonly":
    print("theorem bm : ids.foldl (fun a i => a + i % 2) 0 ≠ 999999999 := by decide +kernel")
elif MODE == "litlist":
    print("theorem bm : benchLookup table 0 idsLit ≠ 999999999 := by decide +kernel")
elif MODE == "descent":
    print("theorem bm : (List.range 2000).foldl (fun a i => a + (table.get ((i * 7919 + 13) % %d / PERBLOCK)) %% 2) 0 ≠ 999999999 := by decide +kernel" % NCLAUSES)
elif MODE == "root":
    print("theorem bm : (table.get 0) % 2 = 1 := by decide +kernel")
