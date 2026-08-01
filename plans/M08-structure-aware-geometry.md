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
/-- **The whole arithmetic content of the milestone**, about integers, proved once. -/
theorem two_digit_lt {M a b : Int} (hM : 0 < M) (ha : 2 * |a| < M) (hb : 2 * |b| < M) :
    2 * |a + M * b| < M * M

theorem two_digit_inj {M a b c d : Int} (hM : 0 < M) (ha : 2 * |a| < M) (hc : 2 * |c| < M)
    (h : a + M * b = c + M * d) : a = c ∧ b = d

/-- Bits per lane. Measured, not chosen: 64 costs 28% more per edge. -/
def laneBits : ℕ := 32

/-- A type whose values are a fixed number of integer digits in base `2 ^ laneBits`. -/
class Packable (K : Type) where
  pack  : K → Int
  width : ℕ
  bounded : Int → K → Bool
  sub   : K → K → K                      -- a field, not an inherited `Sub`
  pack_sub    : ∀ x y, pack (sub x y) = pack x - pack y
  bounded_sub : ∀ b x y, bounded b x → bounded b y → bounded (2 * b) (sub x y)
  pack_le     : ∀ b x, 2 * b < 2 ^ laneBits → bounded b x →
    2 * |pack x| < 2 ^ (laneBits * width)
  pack_inj    : ∀ b x y, 2 * b < 2 ^ laneBits →
    bounded b x → bounded b y → pack x = pack y → x = y

instance instInt : Packable Int                                        -- one digit
instance instAdjoin [Packable K] : Packable (Adjoin d K)               -- two lanes
instance instPt : Packable Pt                                          -- two lanes

def Pt.normSq (v : Pt) : Q4 := FastSq.sq v.x + FastSq.sq v.y

/-- **The identity the milestone turns on**, and it is `rfl`. -/
theorem Pt.normSq_sub (p q : Pt) : (Packable.sub p q).normSq = p.distSq q := rfl
```

and the witness and its soundness:

```lean
structure DiffWitness (n : ℕ) where
  packedV : IntTable        -- same shape as the certificate's vertex table
  diffs   : PtTable
  packedD : IntTable        -- same shape as `diffs`
  keys    : List ℕ          -- one per edge, in the certificate's edge order

def DiffWitness.Certifies (w : DiffWitness n) (t : PtTable) (c : UDCert n) : Bool

/-- **Soundness.** The same `Valid = true` the old route produced, from data that costs an order of
magnitude less to verify. -/
theorem UDCert.valid_of_diffWitness (c : UDCert n) (t : PtTable) (w : DiffWitness n)
    (hverts : c.verts = t.toVerts) (h : w.Certifies t c = true) : c.Valid = true
```

The four checks are separate `def`s so each can be a separate `decide +kernel` in a separate module
when a graph is large enough to want that — the chunking story, kept available but not needed at
de Grey's size.

### 3.2 The obligation that is actually work

`pack_inj`, and it is `two_digit_inj` cited three times. At each two-lane level, from
`pack x.re + M · pack x.im = pack y.re + M · pack y.im` with the low digits inside half of `M`:

```
pack x.re − pack y.re = M · (pack y.im − pack x.im)
M divides the left side, and |left side| < M  ⇒  it is 0  ⇒  the halves agree  ⇒  recurse
```

The invariant that carries both inductions:

```
2 * |pack x| < 2 ^ (laneBits * width x)          under   2 * b < 2 ^ laneBits
```

*leaf* (`width = 1`, `pack = id`): `2|z| ≤ 2b < 2^laneBits`. ✓
*node* (`M = 2 ^ (laneBits * w)`): `2|pack| ≤ (M − 1) + M(M − 1) = M² − 1 < M²`. ✓

**Integrality is doing the work in that second line, and the first version of this plan missed it.**
`2|a| < M` over `ℤ` means `2|a| ≤ M − 1`; over `ℚ` the node step would fail and the statement would
need slack. The plan carried a `+ 2` in four places to buy that slack. It is not needed, it is gone,
and the strict form is what shipped.

**Both lemmas are proved** — during the pass, not deferred to implementation — together with the two
witnesses that break them if the digit bound is weakened from `2 * |a| < M` to `|a| < M`:
`M = 4, a = b = 3` for the first, and `3 + 4·0 = −1 + 4·1` for the second. The milestone's arithmetic
core is closed; what remains is plumbing.

### 3.3 `Proofs/HadwigerNelson/PackedDiagnose.lean` — new, downstream, never imported by a certificate

`Certifies` returns one `Bool` over four walks — 1,581 vertex/packing pairs, 133 difference/packing
pairs, 133 norm identities, and 7,877 edge/key pairs — and the kernel can only say no. The compiled
diagnostic says which:

```lean
inductive DiffFault
  | shapeMismatch  (which : String)            -- the packed table is not the point table's shape
  | vertexPack     (i : ℕ) (held wanted : Int)
  | vertexTooLarge (i : ℕ) (bound : Int)
  | diffPack       (k : ℕ) (held wanted : Int)
  | diffTooLarge   (k : ℕ) (bound : Int)
  | normWrong      (k : ℕ) (found wanted : Q4)
  | edgeMismatch   (pos : ℕ) (i j k : ℕ)       -- edge at this position does not carry this difference
  | keysLength     (edges keys : ℕ)

def DiffWitness.firstFault (w : DiffWitness n) (t : PtTable) (c : UDCert n) : Option DiffFault
def DiffWitness.faultReport (w : DiffWitness n) (t : PtTable) (c : UDCert n) : String
```

with **`firstFault = none ↔ Certifies = true` proved** — the tie that keeps the diagnostic from
drifting away from the checker it explains. That theorem is what makes `#eval w.faultReport t c`
more than suggestive, exactly as `badEdges_eq_nil_iff` does for the per-edge route.

**Two definitions and a theorem, not one definition.** *Alternative weighed:* make `firstFault` the
primary definition and derive `Certifies := (firstFault …).isNone`, so there is nothing to drift by
construction. *Measured and rejected:* a fault-returning per-edge walk costs **0.00180 CPU s/edge
against the `Bool` walk's 0.00155 — 16% more**, which is 1.7 s on de Grey and ~40 minutes at the
10⁷-edge scale this milestone exists for. The diagnostic runs **compiled** and is instant at any
size; the checker runs in the **kernel** and is the whole cost. Paying 16% of the kernel's budget to
make the compiled path authoritative is paying in the wrong currency, and the `↔` theorem buys the
same guarantee for nothing.

**Placement is load-bearing.** Diagnostics are written to be read and therefore rewritten; this
module is downstream of everything and imported by nothing, so rewriting a message costs one file.
That is M07's 28-hour lesson, obeyed in advance.

### 3.4 Per-witness modules

Per witness, replacing `Geom00…Geom08` and `Valid.lean` with two generated modules:

```lean
-- Instances/DeGrey/Diffs.lean   (generated: the four tables)
def deGreyDiffs : DiffWitness 1581 := { … }

-- Instances/DeGrey/Valid.lean   (generated: three lines)
/-- The witness is checked against the certificate's *own* vertices. -/
theorem deGrey_verts : deGrey.verts = deGreyTable.toVerts := rfl
theorem deGrey_certifies : deGreyDiffs.Certifies deGreyTable deGrey = true := by decide +kernel
theorem deGrey_valid : deGrey.Valid = true :=
  deGrey.valid_of_diffWitness deGreyTable deGreyDiffs deGrey_verts deGrey_certifies
```

`deGrey_valid`'s statement is unchanged, which is the whole design. The seam is **named** rather than
inlined as `rfl`: a reader of the generated file should not have to work out what an anonymous `rfl`
discharged, and it costs one line. Verified `rfl` on the real 1,581-vertex certificate, at no
measurable cost.

### 3.5 Domain pass, 2026-07-31 — the class wanted no algebra, and the witness wanted no vertices

Six representation questions went into the pass; four moved the model. Every claim below was checked
in the elaborator before it was written down.

**The class carries its own subtraction.** *Choice:* `Packable` has a `sub : K → K → K` field and no
class parameter at all. *Alternative:* index it on `[CommRing K]` — the shape the skeleton shipped
with, arrived at because `pack_sub` seemed to need a `Sub` and `[Sub K]` had already failed to
synthesize for `Q4`. *Why this one:* it makes `Pt` an ordinary instance instead of a special case
handled by hand. `Pt` is two coordinates and no algebra; giving it a ring to reach its subtraction
would be a fiction, and giving it three hand-restated theorems was the fiction's cost. With `sub` in
the class, instance search has one candidate per head symbol and no side condition — and
`Packable.sub a b = a - b` on a tower level is `rfl`, so nothing downstream must choose between them.
*Confidence: high* — `rfl` verified at two levels, and `Pt.normSq_sub` is still `rfl`, which is the
identity the milestone turns on.

**The duplicated thing was the argument, not the type.** *Choice:* two integer lemmas — a two-digit
numeral fits its width, and its digits are recoverable — cited by all three instances. *Alternative:*
a `Packable.pair` combinator that builds a two-lane instance from a view, so the laws are written
once as an instance rather than once as a lemma. *Why this one:* the combinator routes every
reduction of `pack` through an instance-building `def`, in the one place the kernel actually reduces
the packing (once per vertex), and that path would have to be measured. The lemmas cost nothing at
reduction time and name the content honestly: this is positional notation, not a type constructor.
*Confidence: high.*

**The witness does not carry the vertex table.** *Choice:* `Check` takes the certificate's `PtTable`
as a parameter, shared with the `hverts` hypothesis that ties it to the certificate. *Alternative:*
a `verts : PtTable` field on `DiffWitness`, as the skeleton had it. *Why this one:* the field admits
a witness whose vertex table is not the certificate's, and — worse — `Check c w` would then take `c`
without its vertex clause ever looking at `c`. A reader of `Check c w = true` could not see that the
vertices checked were the certificate's. As a shared parameter the tie is visible in the signature.
It also avoids re-emitting the one literal that costs 28 s to elaborate. *Confidence: high.*

**`IntTable` stays a second copy of `PtTable`.** *Choice:* keep the duplicate, monomorphic, with the
reason in its docstring. *Alternative:* introduce `Table α` and use `Table Int`. *Why this one:* the
generalisation cannot collapse anything — `PtTable` lives in `Certificate.lean`, upstream of 2,466
certificate modules and 28.8 hours of kernel work, and is frozen for this milestone. So `Table α`
would leave two declarations standing and add a type parameter, which is addition wearing
subtraction's clothes. *Confidence: medium — if `Certificate.lean` is ever legitimately edited, this
is the first thing to fold in.*

**Settled without changing the model:** the bound stays a parameter of `bnd` rather than a `Subtype`
of bounded points, because only `pack_inj` consumes it and the points come from a frozen upstream
table — the placement rule says extrinsic, and the build constraint agrees. And the difference table
and its packing are *not* fused into one table of pairs even though both are newly emitted and fusing
would make their shape agreement structural: the vertex side cannot fuse, so fusing the difference
side would put two mechanisms in one file for a 0.26 s saving. One mechanism, used twice.

**One thing the pass found by elaborating rather than by thinking:** a point's packing multiplies by
`2 ^ 512`, and the *elaborator* refuses to evaluate an exponent past 256 and then dies on recursion
depth. The kernel does it in one step. Every check in this file is in that position, which is why
they all say `decide +kernel` — the project's standing rule, arriving here for a second reason.

### 3.6 Obligation pass, 2026-07-31 — the existential is right, and the `+ 2` was not

**The two digit lemmas closed here rather than in implementation**, which is the pass's main result:
§ 3.2 above is now a record of finished work, the over-hedged `+ 2` is deleted from four statements,
and the mutation audit that certifies the digit bound load-bearing is committed beside them.

**Two lemmas about one walk became one lemma.** *Choice:* `packOk_get` returns a conjunction — the
packed value agrees *and* the point is in bounds. *Alternative:* `packOk_pack` and `packOk_bnd`
separately, as the skeleton had them. *Why this one:* they are the same induction over the same pair
of tables, so two lemmas means walking the tables twice in the proofs to state what one walk in the
definition established. *Confidence: high.*

**Every pointwise lemma holds at every index, in range or out, and none of them says so as a
hypothesis.** That is a dividend of `packOk` demanding matching shapes: `PtTable.get` and
`IntTable.get` are total and truncate out of range, and two tables of the same shape truncate
*identically*, following the same path for any index whatever. So no range hypothesis appears
anywhere in this milestone — which was not designed for and is worth stating, because the obvious
alternative (`∀ i < n`) would have threaded a bound through every lemma and every use.

**The existential in `edgesOk_mem` is the right strength, not a weakening.** *Choice:* "every edge is
paired with *some* key whose packed difference is its endpoints'". *Alternative:* carry the key list
position, so each edge is tied to its own key. *Why this one:* the key is an intermediary — it is
used only to reach `w.diffs.get k`, and `normsOk_get` holds at *every* index, so the argument never
needs to know which key an edge got. Threading positions would add an index to an induction with no
use for one. *Confidence: high — the composition in § 3.2 goes through with the existential and gains
nothing from the stronger form.*

**One named joint per step.** `edge_distSq` is extracted as its own lemma, stated over raw `Nat`
indices and a bare table with no certificate in sight, because none of its content is about
certificates: packed difference matches checked difference → linearity → injectivity → the norm.
Soundness above it is then four lines — unpack, take an edge, get its key, apply — and `hverts`
enters exactly once, on the first line, to rewrite `c.verts e` into `t.get e.val`.

### 3.7 Experience pass, 2026-07-31 — the contract becomes a number, and one name was lying

**The emitter contract is pinned as a single integer.** *Choice:* `Packed.lean` carries a fixture —
the packing of the point whose thirty-two digits are `1 … 32` in lane order — as a `#guard` against a
301-digit constant, and `tools/emit_geometry.py` asserts the same constant before emitting anything.
*Alternative:* the prose table of five conventions the module docstring already had. *Why this one:*
a generator author cannot silently disagree with a number. Lane width, lane order inside the tower,
and `x`-before-`y` are all three fixed by that one value, and a mismatch shows up before any data is
written rather than as `Certifies = false` over 7,877 edges. *Confidence: high — the fixture already
did its job during the pass: Lean's four-layer instance chain and an independent Python computation
produced the same 301 digits, which is the first evidence that the lane convention in the plan is the
one the class actually implements.*

**One name was lying, and the name is the statement.** `two_digit_le` concludes with `<`. Renamed
`two_digit_lt`. Also renamed: `bnd` → `bounded` (an abbreviation nobody has to expand), and
`DiffWitness.Check` → `DiffWitness.Certifies`, which says what it decides — the call site now reads
`deGreyDiffs.Certifies deGreyTable deGrey`. `edge_distSq` → `distSq_eq_of_packed`, so the name says
it is an equation and says what discharges it.

**The generated file names its own seam** rather than passing an anonymous `rfl`. One extra line per
witness, and a reader never has to reconstruct what was assumed.

**Settled without changing anything:** `Packable`, `pack`, `width`, `sub`, `DiffWitness`, `IntTable`,
`laneBits`, `vertexBound`, and `valid_of_diffWitness` all stand — the last because it is the name
`valid_of_chunks` teaches a reader to predict.

---

## 4. The generated data, and the emitter

`tools/emit_geometry.py` (new; `emit_cert.py` keeps emitting the vertex table and edge chunks
unchanged, because those files must not be touched) computes the difference set, assigns indices in
first-use order, packs, and emits the four tables plus the `Valid.lean` skeleton.

Six conventions have to be agreed between a Python file and a Lean file that never read each other.
Any one of them wrong makes `Certifies` **`false`** — never a wrong theorem, but also never an
obvious diagnosis. So each is either **checked and named** or **pinned by a fixture**, and none is
left to prose alone:

| convention | how it is enforced |
|---|---|
| lane width — 32 bits, one lane per integer leaf | the ruler fixture below |
| lane order — `re` before `im` at every tower level, `x` before `y` in a point | the ruler fixture below |
| difference orientation — `verts e.1 − verts e.2` | checked; `edgeMismatch` names the position |
| vertex bound — every leaf `|l| ≤ 2²⁹` | checked; `vertexTooLarge` names the vertex |
| `packedV` has the vertex table's tree shape | checked; `shapeMismatch` says which table |
| `keys` in edge order, one per edge, no gaps | checked; `edgeMismatch` / `keysLength` |
| difference sign — signed, not up to sign | § 6 |

**The ruler fixture.** `Packed.lean` pins the packing of the point whose thirty-two digits are
`1, 2, …, 32` in lane order, as a `#guard` against a 301-digit constant; `tools/emit_geometry.py`
asserts the same constant before it emits anything. A generator that disagrees with this file about
lane width, lane order, or coordinate order fails *there*, on one point, rather than as a `false`
over 7,877 edges.

It has already earned its place: Lean's four-layer instance chain and an independent Python
computation produced the same 301 digits, which is the first evidence that the lane convention
written in this plan is the one the class actually implements.

`scripts/regen-check.sh` gains the new modules, so the difference tables are covered by the same
byte-for-byte reproducibility check as everything else.

---

## 4.5 What implementation cost, and what it corrected — 2026-07-31

Measured on the **desktop**, CPU seconds = user + sys, whole modules through `lake build`.

### The headline: 4.4×, not the projected 11.4×

| de Grey's geometry — 1581 vertices, 7877 edges | CPU s | modules |
|---|---|---|
| the per-edge route (`Geom00…Geom08`) | **246.2** | 9 |
| the difference witness — `Diffs.lean`, elaborating the data | 21.2 | 1 |
| the difference witness — `Valid.lean`, the four kernel walks | 34.7 | 1 |
| **new total** | **55.9** | **2** |

Peak memory 8.1 GB in a single module, against a per-edge route that needed the edge list split 45
ways because one `List.all` over 7877 edges would have wanted 35.8 GB.

### Where the projection went wrong, and it is the same lesson twice

**The projection counted kernel reduction and nothing else.** Two costs it therefore missed, each
about a third of the shortfall:

* **Elaborating the witness costs 21.2 s**, because a packed vertex is a ~310-digit integer literal
  where the per-edge route's literals were small. § 0(e) had already measured this in the extreme —
  one 487,351-digit literal costing 59 s — and drew the narrow conclusion "the flat table is dead"
  instead of the general one: **packing moves cost out of the kernel and into the elaborator.** It is
  still a good trade, since the elaborator pays once per module and the kernel pays per edge, but it
  is a trade and the plan booked only one side of it.
* **The bound check costs 10.3 s of the 28.9 s of kernel work** — 32 integer comparisons per vertex,
  0.00655 s each against the 0.00196 the plan projected for the packing alone. The plan projected the
  packing check by measuring a packing check; the shipped one also checks that every leaf is inside
  `vertexBound`, which is the hypothesis `pack_inj` consumes, and nobody costed it.

### The kernel walks, attributed

| walk | count | CPU s | per unit |
|---|---|---|---|
| vertex packing and bound | 1581 | 10.35 | 0.00655 |
| difference packing, bound, and the 133 squared lengths | 133 + 133 | 3.45 | — |
| the per-edge check | 7877 | 15.09 | 0.00192 |

The per-edge figure is 40% above § 0(c)'s 0.00137 because `deGrey.edges` is not a literal list — it
is three parts appended, each a concatenation of chunks — so the kernel builds the list as it walks
it. That shape is fixed by M06's decomposition and is not worth changing for 4 seconds.

### The bound check is irreducible, and two guesses about it were wrong

A hand-written control, on de Grey's real vertex table:

| what it does | CPU s | per vertex |
|---|---|---|
| pack only, literal lane multipliers, no class | 3.00 | 0.0019 |
| pack only, through the `Packable` instance chain | — | — |
| pack **and bound-check**, hand-written | 10.33 | **0.00653** |
| pack **and bound-check**, through the class (shipped) | 10.35 | **0.00655** |

**The instance chain costs nothing** — 0.00653 against 0.00655 — so the class the domain pass argued
for is free at reduction time, and the "pin the definitions" restructuring the plan held in reserve
would have bought exactly zero. **The absolute value is not the problem either**: replacing
`|z| ≤ b` with `-b ≤ z ∧ z ≤ b` bought 10%, not the order of magnitude a lattice-routed `abs` would
have implied. What remains is 32 integer comparisons walked through a five-level structure, which is
what a per-leaf claim costs.

*Recorded because both guesses were mine, both were plausible, and both were wrong. The measurement
took four minutes and would have taken half a day to act on unmeasured.*

### One decision implementation forced

**The certificate modules now import the edge list, not the instance's aggregate module.** *Choice:*
`tools/emit_mask.py` emits `import …Instances.Heule510.Edges` plus `Sat.Encoding`, where it used to
emit `import …Instances.Heule510`. *Alternative:* leave the coupling and re-check 201 certificate
modules every time the geometry changes. *Why this one:* the aggregate module imports the geometry,
so a certificate that imports it re-checks whenever the geometry does — which at de Grey's scale is
28 hours. Paid once, here, and never again. *Confidence: high — it is the same rule M07 wrote into
`Sat/Diagnose.lean`, applied one layer out.*

### Two things that went wrong

**`lake env lean` is not the gate, and it looked like it.** `PackedDiagnose.lean` elaborated clean
under `lake env lean` and failed under `lake build` on an unknown identifier `n` — because
`lake env lean` does not apply the lakefile's `autoImplicit := false`, so it silently auto-bound a
variable the real build rejects. Every iteration in this milestone used `lake env lean` for speed.
It is a faster check, not a weaker gate that looks like the gate; the rule is now in `CLAUDE.md`.

**A negative control was testing the wrong thing.** The control meant to exercise "an edge whose key
names the wrong difference" put a *non-unit* difference in the table, so the norms walk caught it
first and the edge walk was never reached. Fixed by making the wrong difference one unit long. The
control now goes red for the reason it claims to.

---

## 4.6 What landed — 2026-07-31, 21:0x

**All three witnesses re-certified through the difference witness.** `deGrey_valid`,
`heule510_valid` and `heule553_valid` are unchanged in statement; only the route beneath them moved,
so `Bound.lean`, `Forcing.lean`, `Split.lean` and every theorem downstream were untouched.

| | before | after |
|---|---|---|
| de Grey's geometry | 246.2 CPU s, 9 modules | **55.9 CPU s, 2 modules** |
| memory per edge | 4.55 MB | **0.27 MB** |
| squared lengths verified | 7,877 | **133** |
| de Grey's 2,265 certificate modules | — | **not re-checked** |

**The gate, 2026-07-31.** `./scripts/build.sh` green — 259 batches, 0 retries, 0 warnings. Zero
`sorry` across the library. `axioms.sh` OK: 81 clean, 5 declared purchases, all of them M03's
Moser-spindle native evaluation — **M08 adds none**. `chromaticNumber_plane_ge_five`, `_510` and
`_553` all depend on axioms exactly `[propext, Classical.choice, Quot.sound]`, as do `deGrey_valid`
and `UDCert.valid_of_diffWitness`. `lake lint` passed. `scripts/regen-check.sh` OK, now covering the
difference witnesses and de Grey's geometry as well.

**The invalidation constraint held.** After the whole milestone, de Grey's certificate segment
`.olean`s still carry yesterday's timestamps: the 27.8 hours were not re-spent. Only the two Heule
certificate sets re-checked, once, to break their geometry coupling permanently — and that took 21
minutes of wall clock, not the hour the plan budgeted.

### One decision the failure path forced

**The check is a named `Bool`, and its failure carries a directive rather than a term.** *Choice:*
the generated `Valid.lean` defines `deGreyCertified : Bool` and proves it with
`first | decide +kernel | fail "…run #eval …faultReport…"`. *Alternative:* a plain
`decide +kernel` on the inline proposition, as every other check in this repository is written.
*Why this one:* measured on a deliberately broken witness, the plain form produces

```
error: [Error pretty printing: maximum recursion depth has been reached
```

and nothing else — the delaborator cannot render a proposition mentioning a 169 KB literal, so the
one message a person meets on the one day it matters says nothing at all. Naming the `Bool` was not
enough on its own; the `fail` branch is what replaces the wall with an instruction. *Confidence:
high — both forms were run against the same broken witness.*

The instruction was then checked the way `exact?`'s "Try this:" is checked: **what it prints must
elaborate.** The first version did not — it named `heule510Diffs.faultReport …` without saying that
the reader needs `import Proofs.HadwigerNelson.PackedDiagnose` and `namespace HadwigerNelson`, and
pasted verbatim it fails on an unknown identifier. The message now carries its context, and running
it verbatim on the broken witness prints

```
"vertex 0: the packed table does not hold this point's packing — regenerate, or check the lane
 convention against the ruler constant in Packed.lean"
```

which names the exact vertex that was broken.

---

## 5. Negative controls — every check watched to fail

Each control is a deliberate break, run, and *seen* to go red, with the mutation confirmed to have
landed before the result is believed. That last clause is not ceremony: at M07, three controls passed
because the mutation silently changed nothing.

| control | must produce |
|---|---|
| one `keys` entry pointing at the wrong difference | `Certifies = false`, `firstFault = edgeMismatch` at that position |
| one packed vertex off by one | `Certifies = false`, `firstFault = vertexPack` naming the vertex |
| one difference's norm perturbed | `Certifies = false`, `firstFault = normWrong` naming the difference |
| a leaf larger than the bound | `Certifies = false`, `firstFault = vertexTooLarge` |
| the packed table reshaped | `Certifies = false`, `firstFault = shapeMismatch` |
| `keys` one entry short | `Certifies = false`, `firstFault = keysLength` — **not** a silently truncated pass |
| the ruler fixture packed `y` before `x` | the `#guard` fails, in `Packed.lean`, before any data is emitted |
| **run:** one byte of a packed vertex changed | ✅ build fails with the directive; `regen-check` reports `Diffs.lean differs in content`; the mutation was `cmp`-verified to be exactly one byte *before* either result was believed |
| **run:** the directive followed verbatim | ✅ prints `"vertex 0: the packed table does not hold this point's packing…"` — the vertex that was broken |
| `two_digit_lt` / `two_digit_inj` with the digit bound weakened | **already run** — the two counterexamples are committed beside the lemmas |
| `pack_inj`'s bound hypothesis deleted | the *proof* breaks, not the checker's answer |
| two distinct bounded points colliding under `pack` | unprovable — the adversarial member, pinned as `example : ¬ …` |

**`#guard_msgs` pins the rendered report, not just the API behind it** — one per fault constructor,
on the two-point fixture. What a person reads when a certificate fails is the *text*; leaving it out
of the tests means the one surface that matters at the moment of failure is the one nothing guards.
That is M07's practice, and `Certificate.lean` already does it for `badEdges`.

Three of these were already run during subplanning, against real de Grey data, and each went red with
the mutation verified to have landed first:

* one `keys` entry changed from `0` to `99` → *"Tactic `decide` proved that the proposition … is
  false"*;
* one packed vertex incremented by 1 in its last digit → same;
* both digit lemmas with `2 * |a| < M` weakened to `|a| < M` → concrete counterexamples at `M = 4`,
  now committed as `#guard`s beside the lemmas they protect.

---

## 6. Measured, do not re-derive

* **Difference counts** — de Grey 133 signed / 67 unsigned; Heule 510 66/36; Heule 553 82/42. § 0(a).
* **The count is not flat in graph size** — it doubles with each rotation of the construction; the
  *ratio* is stable at ~118 : 1 across 397 → 1581 vertices. § 0(b).
* **Per-edge costs** — current 0.0246 s and 4.55 MB; spike's unpacked difference form 0.00832 s;
  packed form 0.00137 s and 0.27 MB; bare list walk 0.0011 s. § 0(c).
* **Lane width is not free** — 64-bit lanes cost 28% more per edge than 32-bit. The lanes are
  32 bits and the vertex bound 2²⁹. § 0(c′).
* **A fault-returning checker costs 16% per edge** over a `Bool` one (0.00180 against 0.00155), so
  the diagnostic stays a second, compiled definition tied by a proved `↔` rather than becoming the
  checker itself. § 3.3.
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
