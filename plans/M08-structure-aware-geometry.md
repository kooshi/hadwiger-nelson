# M08 — Structure-aware geometry

> **The milestone in one line.** Verify one norm per *distinct edge difference* instead of one per
> edge, and make the per-edge residue a single big-integer subtraction — so the geometry check stops
> being the term that decides whether a candidate graph can be certified at all.

The roadmap row this replaces:

> **M08** | **Structure-aware geometry.** Difference-vector certificates: verify one norm per
> *distinct edge difference* (67 for de Grey, against 7877 edges) and a subtraction per edge. | The
> same `deGrey_valid` claim at a per-edge cost that no longer carries a multiplication, and a
> projection showing the expensive term is flat in graph size. Sequenced here because it changes the
> edge list's shape and would invalidate M06's certificates.

Two of that row's three claims did not survive measurement. The expensive term is **not** flat in
graph size, and the milestone does **not** have to change the edge list's shape or invalidate
anything. § 0 has the numbers.

---

## 0. What this subplan measured, and what it overturned

All timings: **desktop**, `lake env lean` on a scratch module importing de Grey's prebuilt vertex
table and edge chunks, **CPU seconds = user + sys, minimum of three runs**, with a matching
theorem-free baseline module subtracted so every figure below is marginal. Every variant is a real
`decide +kernel`, not a projection.

### (a) The difference set is small, in every witness we hold

| witness | vertices | edges | distinct differences (signed) | up to sign | edges : differences |
|---|---|---|---|---|---|
| de Grey | 1581 | 7877 | 133 | 67 | 118 : 1 |
| Heule 510 | 510 | 2504 | 66 | 36 | 70 : 1 |
| Heule 553 | 553 | 2722 | 82 | 42 | 65 : 1 |

The spike (`plans/spike-geometry-scaling.md`) measured only de Grey. The two minimised witnesses
keep the structure: **minimisation did not scramble the difference set.** That was not obvious —
these graphs were produced by deleting vertices from a rotation-generated construction, and deletion
could in principle have left an arbitrary residue.

### (b) But the difference count is **not** flat in graph size — the roadmap's deliverable is wrong

Measured along de Grey's own construction, which builds the final graph by rotating and unioning a
base point set:

| stage | vertices | edges | distinct differences | ratio |
|---|---|---|---|---|
| `S_a` (step 2 of the construction) | 397 | 1974 | 30 | 132 : 1 |
| `S_a ∪ S_b` (step 3) | 793 | 3954 | 66 | 120 : 1 |
| `Y` (step 4) | 791 | 3938 | 66 | 119 : 1 |
| `G` — de Grey's graph (steps 5–6) | 1581 | 7877 | 133 | 118 : 1 |

**Doubling the construction doubles the difference count.** That is forced, not accidental: each
rotation maps the whole difference set to a rotated copy of itself, so `|D(V ∪ rot V)| = 2|D(V)|`
except for whatever the two copies share. What is stable is the **ratio**, at ~118 : 1 across the
construction's entire range.

So the honest statement of what this milestone buys is:

> The expensive per-norm work drops from **once per edge** to **once per 118 edges**, and the
> residual per-edge work drops by a further 18×. The cost stays linear in graph size; the constant
> falls by an order of magnitude.

`ARCHITECTURE.md` currently says "the expensive term can be made flat in graph size". That sentence
is false and this milestone deletes it.

### (c) The spike's shape buys 2.8×. A shape the spike did not consider buys 11×

The spike proposed: per edge, check `verts j - verts i = diffs.get k` — a subtraction and a
comparison in the field, no multiplication. Measured against the current check, on de Grey's first
edge chunk (179 edges):

| per-edge form | CPU s / edge | MB / edge |
|---|---|---|
| **current** — `(verts j).distSq (verts i) = denomSq` | 0.0246 | 4.55 |
| difference table, `Pt` subtract-and-compare (the spike's shape) | 0.00832 | — |
| **packed** — `packedV.get j - packedV.get i = packedD.get k` in `ℤ` | **0.00137** | **0.27** |

The spike's shape is only 3.0× cheaper per edge, because a `Pt` equality is still 32 integer
comparisons walked through a four-level structure, and *that* — not the multiplication — is what the
kernel is paying for.

The third row is the finding. Pack a point's 32 integer leaves into **one `ℤ`**, one 32-bit lane per
leaf. Packing is a *linear* map, so a difference of packed points is the packed difference
exactly, with no borrow to reason about — and the whole per-edge check becomes one big-integer
subtraction and one comparison, which M05's cost model says are free beside a single reduction step.
The measurement agrees: **0.00137 s/edge, against a bare list walk with no arithmetic at all at
0.0011 s/edge.** The per-edge arithmetic has effectively vanished; what is left is the two table
lookups and the cost of walking a list.

This is M05's own lesson — *pack many values into few big `Nat`s* — arriving in the geometry.

### (c′) Lane width is *not* free, which was the wrong instinct twice over

The kernel's cost model says a big-integer operation costs one reduction step at any width, so the
lanes could be made comfortably wide for the proof. Measured: **64-bit lanes cost 0.00176 s/edge
against 32-bit lanes' 0.00137 — 28% more.** The per-edge cost is no longer arithmetic; it is the
width of the literals being read, and that scales.

So the lanes are set at **32 bits** and the vertex bound at **2²⁹** — the narrowest the injectivity
argument is comfortable in, rather than the widest the kernel tolerates. De Grey's largest leaf is
1920, so the margin is eighteen binary orders.

*Alternative weighed: 64-bit lanes, which would let the bound be 2⁴⁰ and remove any need to think
about the margin at all. It costs 28% of the milestone's dominant term for headroom that is already
eighteen orders. Confidence: high — both numbers are measured on the same data.*

### (d) The projection for de Grey

| check | count | CPU s each | total |
|---|---|---|---|
| packed value agrees with the point, per vertex | 1581 | 0.00196 | 3.1 s |
| packed value agrees with the difference, per difference | 133 | 0.00196 | 0.3 s |
| **the norm identity, per distinct difference** | 133 | 0.0209 | 2.8 s |
| the packed check, per edge | 7877 | 0.00137 | 10.8 s |
| | | | **17.0 s** |

against the current form's 7877 × 0.0246 = **194 s**: **11.4× on processor time**.

Memory moves further. The current check needs 4.55 MB/edge, which is 35.8 GB for the whole edge list
and is exactly why de Grey's geometry is split into 45 chunks across nine modules. The packed check
needs 0.27 MB/edge — **2.1 GB for all 7877 edges, plus 0.5 GB for the 133 norms. The entire geometry
fits in one module.**

### (e) The flat vertex table is measured dead, and the reason is not the kernel

If two table lookups are the residual per-edge cost, the obvious next move is to delete the table:
pack *all* 1581 vertices into one giant `Nat` and index it by `>>>` and `&&&`, which the cost model
says are free at any width. Measured:

* **In the kernel it works perfectly.** 179 edges against a 1.6-Mbit literal cost **0.00 s** —
  the shift-and-mask lookup is genuinely free, at 1024-bit lanes, exactly as the model predicts.
* **In the elaborator it is fatal.** Merely *defining* the literal cost **59 CPU s**, and 54 s in
  hexadecimal, because Lean's numeric-literal parser folds one digit at a time and is therefore
  quadratic in digit count. At 1581 vertices the literal is 487,351 digits.

Crossover against the tree at ~43,000 edges, with the fixed cost growing quadratically in vertex
count — so the flat table is worse everywhere this project will go. **Recorded here because the
kernel-side instinct was right and the answer was still no**, which is the shape of mistake CLAUDE.md
says to expect from instincts about this kernel.

A hybrid — a tree of blocks, each block one giant `Nat` holding 64 vertices — would keep the parse
cost near-linear (25 blocks of ~20k digits, projected 2.2 s) while cutting the tree from 11 levels to
5. Projected 2× on the per-edge term. **Out of scope** (§ 7).

### (f) The invalidation worry is misplaced, and the real number is 1 hour, not 28

The roadmap sequenced this milestone late because it "would invalidate M06's certificates". Measured
against the actual import graph:

| what a milestone edits | certificate modules invalidated | cost to re-check |
|---|---|---|
| `Certificate.lean`, `EdgeList.lean`, `Field/Quadratic.lean` | 2,466 | **28.8 h processor** |
| `Instances/DeGrey/Table.lean`, `Instances/DeGrey/Edges.lean` | 2,265 | 27.8 h |
| `Instances/DeGrey/{Geom*,Valid}.lean`, `Instances/DeGrey.lean` | **0** | seconds |
| `Instances/Heule510/{Geom*,Valid}.lean`, `Heule510.lean` | 100 | ~30 min |
| `Instances/Heule553/{Geom*,Valid}.lean`, `Heule553.lean` | 101 | ~30 min |

De Grey's certificate modules reach the vertex table through `Split` → `Edges` → `Table`, and never
touch the geometry proofs at all. **His geometry can be replaced for free.** Only the two Heule
witnesses are coupled, and that coupling is an accident: `tools/emit_mask.py` was told to import the
top-level instance module, which pulls in the geometry, when all the certificate needs is the edge
list.

So the milestone's own constraint is sharp and cheap to honour:

> **Touch nothing at or above `Certificate.lean`, and nothing in `Instances/DeGrey/{Table,Edges}`.
> Every new definition goes in a new module.**

Under that constraint M08 costs one re-check of the two Heule certificate sets (~1 h), incurred once
to *break* the coupling permanently rather than to work around it.

---

## 1. The cost, and what it buys

**Compute:** ~1 h of processor time to re-check the 201 Heule certificate modules after decoupling,
plus ~1 min for all three witnesses' new geometry. Against M06's 27.8 h, this is noise — but it is
noise only because the constraint in § 0(f) is honoured, and it becomes 28 h the moment it is not.

**What it buys, in order of how much it matters:**

1. **The search instrument becomes able to certify what it finds.** This is the whole point. At the
   current 0.0246 s/edge, a 10⁶-edge candidate costs 6.8 hours of geometry and a 10⁷-edge candidate
   costs 68 hours — per candidate, before any SAT work. Under this milestone the same candidates cost
   2.3 hours and 5.4 hours. Rung C (the search instrument) and rung D (the hunt) both sit behind that
   number.
2. **The geometry stops dictating the module layout.** 45 chunks across nine modules becomes one
   module per witness, because the memory per edge falls 17×.
3. **A second, structurally different check of the same geometry.** The new route certifies each edge
   through a difference vector and a packing; the old route recomputed the distance. Keeping the old
   proof for one witness gives two independent derivations of the same `Valid`, which is worth having
   for the reason M07's cross-filing controls are worth having.

**What it does not buy:** anything for the three witnesses already certified. Their geometry is 194 s
out of a build whose combinatorics is 27.8 h — **0.2%**. Nobody should read this milestone as
speeding up the current proof. It is scaffolding for the graphs that do not exist yet.

**Kill criterion.** If the packing-injectivity proof (§ 3.2) does not close inside ~150 lines, fall
back to the spike's unpacked shape (§ 8), which is 2.8× rather than 11× and needs no injectivity
argument at all.

---

## 2. The shape

### 2.1 The claim does not change; only its proof does

`UDCert`, `UDCert.Valid`, `valid_sound`, and `add_one_le_chromaticNumber_of_valid` are untouched.
`deGrey_valid : deGrey.Valid = true` keeps its exact statement, so `Bound.lean`, `Forcing.lean`,
`Controls.lean` and every downstream theorem are untouched, and the trust surface does not move.

What changes is *how* `Valid = true` is obtained: today by deciding 7877 distance identities, after
this milestone by deciding four cheaper things and citing one soundness theorem.

This is also what makes § 0(f)'s constraint satisfiable — a new module cannot change an old module's
content, and Lake's traces are content-based.

### 2.2 The witness is data the generator emits, and nothing about it is trusted

```lean
structure DiffWitness (n : ℕ) where
  diffs   : PtTable      -- the distinct edge difference vectors, exact, one leaf each
  packedV : IntTable     -- `pack (verts i)`, one per vertex, in index order
  packedD : IntTable     -- `pack (diffs.get k)`, one per distinct difference
  keys    : List ℕ       -- one index into `diffs` per edge, in the certificate's edge order
```

Four `Bool`-valued checks, all decided by the kernel:

| check | cost | what a wrong generator produces |
|---|---|---|
| `packedV.get i = pack (verts i)`, and every leaf of `verts i` is small | O(vertices) | `false` |
| `packedD.get k = pack (diffs.get k)`, and every leaf small | O(differences) | `false` |
| `(diffs.get k).normSq = denomSq` | O(differences) | `false` |
| `packedV.get j - packedV.get i = packedD.get k`, walking `edges` and `keys` together | O(edges) | `false` |

A wrong index, a wrong difference, a wrong packing, a wrong norm, a mismatched list length: each one
makes a check `false`. **None of them can make a theorem false** — the standing arrangement.

`keys` is walked *against the certificate's own edge list*, by a two-list structural recursion whose
mismatch case is `false`. That is deliberate: a `zip` would silently truncate, and a separate length
check would be a second thing that can rot. Measured at 0.00137 s/edge, against 0.00150 for a
three-list form and 0.00184 for `List.all` over a zipped list.

### 2.3 The packing

`pack` sends a point's 32 integer leaves to one `ℤ`, lane width 2³², lane order = the tower's own
left-to-right order:

```
pack ⟨re, im⟩ = pack re + 2^(32·width re) * pack im        (at every level, including `Pt`)
pack (z : ℤ)  = z                                          (at the leaves)
```

Three properties carry the milestone, and only the third is work:

* **Linearity** — `pack (p - q) = pack p - pack q`, by construction, in `ℤ`, with no bound and no
  borrow. This is why the packing is over `ℤ` and not `ℕ`: `ℕ` subtraction truncates, and a truncated
  lane is exactly the junk-value totality this project refuses.
* **Bounding** — every leaf `|l| < 2³¹` gives `|pack x| < 2^(32·width − 1)`.
* **Injectivity on bounded points** — `pack x = pack y` with both bounded gives `x = y`.

Vertices are checked against `|l| < 2³⁰` so that differences are within `2³¹`. De Grey's largest leaf
is **1920**; the margin is 19 binary orders.

### 2.4 What the emitter must get right

`tools/` is untrusted, so a generator bug can only produce data Lean refuses. But the *contract* still
has to be written down in one place, because four artefacts have to agree: the lane width, the lane
order, the bound, and the fact that `keys` is in the certificate's edge order. That contract lives in
the new module's docstring, in the same position `Sat/Mask.lean`'s does.

### 2.5 Breaking the geometry↔certificate coupling, once

`tools/emit_mask.py --import` is changed to name the *edge list* module rather than the top-level
instance module, and `Instances/Heule510.lean` / `Heule553.lean` are split so the edge list has a
module of its own. After this, a certificate's import closure contains no geometry, and every future
geometry change is free.

This is M07's rule — *nothing that will be edited goes in a module a certificate imports* — applied
one layer out, and it is the only reason this milestone costs an hour instead of a day.

---

## 3. The statements

The skeleton: every signature and full theorem statement, `sorry` at every leaf, so the specification
elaborates before proof effort is spent.

### 3.1 `Proofs/HadwigerNelson/Packed.lean` — new, imports `Certificate`

```lean
/-- A table of integers indexed by `Nat`, the packed sibling of `PtTable`. -/
inductive IntTable where
  | leaf : Int → IntTable
  | node : Nat → IntTable → IntTable → IntTable

def IntTable.get : IntTable → Nat → Int

/-- The lane width, in bits. One lane per integer leaf of a point. -/
def laneBits : ℕ := 32

/-- Packing, at every level of the tower and at `Pt`. -/
class Packable (K : Type) where
  pack : K → Int
  width : ℕ                    -- lanes consumed
  Bnd : K → Prop               -- every leaf `|l| < 2^(laneBits - 1)`

instance : Packable Int
instance [Packable K] : Packable (Adjoin d K)
def Pt.pack (p : Pt) : Int
def Pt.Bnd (p : Pt) : Prop

/-- **Linearity** — the reason the per-edge check is a subtraction and nothing else. -/
theorem pack_sub [Packable K] (x y : K) : Packable.pack (x - y) = ...

/-- **Bounding** — a bounded value fits, with room for the `+ 2`, in its own lanes. -/
theorem pack_le (b : Int) (x : K) : 2 * b + 2 ≤ 2 ^ laneBits → bnd b x = true →
    2 * |pack x| + 2 ≤ 2 ^ (laneBits * width)

/-- **Injectivity on bounded values** — the one real obligation of this milestone. -/
theorem pack_inj (b : Int) (x y : K) : 2 * b + 2 ≤ 2 ^ laneBits →
    bnd b x = true → bnd b y = true → pack x = pack y → x = y
```

Indexed on `[CommRing K]` rather than on `[Sub K]`, following `NatScalar`'s own note in
`Field/Quadratic.lean`: a class indexed on the pieces only synthesizes where the ambient instances
are found by the route that declared it, which for a tower is never reliably true. Indexing on the
single bundled structure makes the route unique. **Discovered by trying the other way** — `Packable
Q4` failed to synthesize at every use site.

and the witness and its soundness:

```lean
structure DiffWitness (n : ℕ) where
  diffs : PtTable
  packedV : IntTable
  packedD : IntTable
  keys : List ℕ

/-- The four checks, as one `Bool` the kernel decides. -/
def DiffWitness.Check (c : UDCert n) (w : DiffWitness n) : Bool

/-- **Soundness.** A witness that checks certifies the certificate — the same `Valid = true` the
old route produced, from data that costs an order of magnitude less to verify. -/
theorem UDCert.valid_of_diffWitness (c : UDCert n) (w : DiffWitness n)
    (h : w.Check c = true) : c.Valid = true
```

The four checks are separate `def`s so each can be a separate `decide +kernel` in a separate module
when a graph is large enough to want that — the chunking story, kept available but not needed at
de Grey's size.

### 3.2 The obligation that is actually work

`pack_inj`, by structural induction up the tower. At each level, from
`pack x.re + 2^w · pack x.im = pack y.re + 2^w · pack y.im` and `|pack x.re|, |pack y.re| < 2^(w−1)`:

```
pack x.re − pack y.re = 2^w · (pack y.im − pack x.im)
|LHS| < 2^w  ⇒  both sides are 0  ⇒  re's agree and im's agree  ⇒  recurse
```

The invariant that makes both inductions close, and the one arithmetic detail worth settling in the
plan rather than discovering in a goal state:

```
2 * |pack x| + 2 ≤ 2 ^ (laneBits * width x)          under   2 * b + 2 ≤ 2 ^ laneBits
```

*leaf* (`width = 1`, `pack = id`): `2|z| + 2 ≤ 2b + 2 ≤ 2^laneBits`. ✓
*node* (`M = 2 ^ (laneBits * w)`): `2|pack| + 2 ≤ (M − 2) + M(M − 2) + 2 = M² − M ≤ M²`. ✓

The `+ 2` is load-bearing at both ends — with a bare `<` the node step fails by exactly one, and the
injectivity step needs `|pack x.re − pack y.re| ≤ M − 2 < M` to conclude that a multiple of `M` is
zero. This is the shape that survived; two nearby ones did not.

Budget: ~150 lines. Beyond that, § 8.

### 3.3 `Proofs/HadwigerNelson/PackedDiagnose.lean` — new, downstream, never imported by a certificate

`Check` returns a `Bool` and the kernel can only say no. The compiled diagnostic returns which of the
four checks failed and at which index, in the vocabulary of the person reading it:

```lean
inductive DiffFault
  | vertexPack (i : ℕ) (held wanted : Int)
  | vertexTooLarge (i : ℕ)
  | diffPack (k : ℕ) (held wanted : Int)
  | normWrong (k : ℕ) (found wanted : Q4)
  | edgeMismatch (pos : ℕ) (e : ℕ × ℕ) (k : ℕ)
  | lengthMismatch (edges keys : ℕ)

def DiffWitness.firstFault (c : UDCert n) (w : DiffWitness n) : Option DiffFault
def DiffWitness.faultReport (c : UDCert n) (w : DiffWitness n) : String
```

with `firstFault = none ↔ Check = true` proved, exactly as `badEdges_eq_nil_iff` is proved — a
diagnostic whose promise is a theorem rather than a docstring's word.

**Placement is load-bearing.** Diagnostics are written to be read and therefore rewritten; this
module is downstream of everything and imported by nothing, so rewriting it costs one file. That is
M07's 28-hour lesson, obeyed in advance.

### 3.4 Per-witness modules

Per witness, replacing `Geom00…Geom08` and `Valid.lean`:

```lean
-- Instances/DeGrey/Diffs.lean   (generated: the four tables)
def deGreyDiffs : DiffWitness 1581 := { … }

-- Instances/DeGrey/Valid.lean   (regenerated: four decides and one citation)
theorem deGrey_diffs_check : deGreyDiffs.Check deGrey = true := by decide +kernel
theorem deGrey_valid : deGrey.Valid = true :=
  deGrey.valid_of_diffWitness deGreyDiffs deGrey_diffs_check
```

`deGrey_valid`'s statement is unchanged, which is the whole design.

---

## 4. The generated data, and the emitter

`tools/emit_geometry.py` (new; `emit_cert.py` keeps emitting the vertex table and edge chunks
unchanged, because those files must not be touched) computes the difference set, assigns indices in
first-use order, packs, and emits the four tables plus the `Valid.lean` skeleton.

The contract it must honour, stated once here and once in `Packed.lean`'s docstring:

| item | value |
|---|---|
| lane width | 32 bits, one lane per integer leaf |
| lane order | the tower's own order: `re` before `im`, at every level, `x` before `y` |
| vertex bound | every leaf `|l| < 2³⁰` |
| `keys` order | the certificate's edge order, one entry per edge, no gaps |
| difference sign | signed, not up to sign — see § 6 |

`scripts/regen-check.sh` gains the new modules, so the difference tables are covered by the same
byte-for-byte reproducibility check as everything else.

---

## 5. Negative controls — every check watched to fail

Each control is a deliberate break, run, and *seen* to go red, with the mutation confirmed to have
landed before the result is believed. That last clause is not ceremony: at M07, three controls passed
because the mutation silently changed nothing.

| control | must produce |
|---|---|
| one `keys` entry pointing at the wrong difference | `Check = false`, `firstFault = edgeMismatch` at that position |
| one packed vertex off by one | `Check = false`, `firstFault = vertexPack` naming the vertex |
| one difference's norm perturbed | `Check = false`, `firstFault = normWrong` naming the difference |
| a leaf larger than the bound | `Check = false`, `firstFault = vertexTooLarge` |
| `keys` one entry short | `Check = false`, `firstFault = lengthMismatch` — **not** a silently truncated pass |
| `pack_inj`'s bound hypothesis deleted | the *proof* breaks, not the checker's answer |
| two distinct bounded points colliding under `pack` | unprovable — the adversarial member, pinned as `example : ¬ …` |

Two of these were already run during subplanning, against real de Grey data, and both went red with
the mutation verified first:

* one `keys` entry changed from `0` to `99` → *"Tactic `decide` proved that the proposition … is
  false"*;
* one packed vertex incremented by 1 in its last digit → same.

---

## 6. Measured, do not re-derive

* **Difference counts** — de Grey 133 signed / 67 unsigned; Heule 510 66/36; Heule 553 82/42. § 0(a).
* **The count is not flat in graph size** — it doubles with each rotation of the construction; the
  *ratio* is stable at ~118 : 1 across 397 → 1581 vertices. § 0(b).
* **Per-edge costs** — current 0.0246 s and 4.55 MB; spike's unpacked difference form 0.00832 s;
  packed form 0.00137 s and 0.27 MB; bare list walk 0.0011 s. § 0(c).
* **Lane width is not free** — 64-bit lanes cost 28% more per edge than 32-bit. The lanes are
  32 bits and the vertex bound 2²⁹. § 0(c′).
* **O(n) costs** — packing check 0.00196 s/vertex; norm identity 0.0209 s/difference. § 0(d).
* **The flat giant-`Nat` vertex table is dead** — free in the kernel, 54–59 CPU s to *elaborate* the
  literal, quadratic in vertex count. § 0(e).
* **The invalidation map** — de Grey's geometry is not upstream of his certificates; the Heule
  witnesses' is, and that costs ~1 h once. § 0(f).
* **Signed, not up to sign.** Halving the difference table to 67 saves 1.4 s of norm checks and costs
  a sign branch on every one of 7877 edges. Not worth it, and the signed table is simpler to emit and
  to read. *Alternative weighed: an unsigned table with a sign bit in each key. Confidence: high — the
  saving is bounded above by 1.4 s and the cost is per-edge.*

## 7. Unmeasured, ranked by what it would move

1. **Block-packed vertex table** — a tree of blocks, each block one giant `Nat` holding 64 vertices.
   Keeps literal parsing near-linear while cutting the lookup from 11 tree levels to 5. Projected
   **2× on the per-edge term**, which is 71% of the new total. Half a day. *The single highest-value
   follow-on, and the reason § 0(e) is written down rather than discarded.*
2. **Kronecker substitution for the norm checks** — evaluate the tower's leaves as a polynomial at a
   large base so that field multiplication becomes integer multiplication, then reduce. Would attack
   the 0.0209 s/difference term, which is 16% of the new total and the only remaining multiplication
   in the pipeline. Unknown difficulty; the reduction step (√3² = 3 and friends) is the unknown.
3. **Whether a *hunt* candidate's difference set behaves like these three.** Every graph measured here
   descends from one construction. A composition-search candidate (M09) might have a much larger
   difference set, and the 118 : 1 ratio is a fact about de Grey's rotations, not a law.

## 8. Fallbacks

* **If `pack_inj` will not close in ~150 lines** — drop the packing and ship the spike's unpacked
  difference form: `verts j - verts i = diffs.get k` compared as `Pt`s. 2.8× instead of 11×, no
  injectivity argument, and the module layout still collapses. Everything else in this plan stands.
* **If the difference table turns out not to help a future candidate** (§ 7.3) — the old per-edge
  route is not deleted. It stays as the fallback path and as the independent second derivation of
  de Grey's geometry.
* **If the Heule decoupling costs more than an hour** — do de Grey only, which is free, and leave the
  two Heule witnesses on the old geometry until their certificates are next regenerated for another
  reason.
