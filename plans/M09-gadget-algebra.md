# M09 — Gadget algebra

*Subplanned 2026-07-31 on the desktop (32 cores, 125 GB), idle. Kernel timings are CPU seconds
(user + sys), minimum of three runs.*

**The milestone in one line.** A *gadget* is a proven constraint on how a proper colouring may colour
a designated tuple of vertices. Gadgets compose by intersection, transport along vertex maps, and
arrive from three producers — an edge, a SAT refutation, or another gadget moved by a plane isometry.
de Grey's argument becomes three gadgets and one `decide` over 64 colourings, and **his second copy
stops being data**: it is derived from the first by a rotation the kernel checks.

---

## 0. Measurements, taken before the shape was chosen

### (a) de Grey's second copy is an exact rotation of his first — and the rotation is tiny

`tools/degrey.py` builds the 1581-point graph as `dedup(Ya ++ Yb)` where `Ya` and `Yb` are one
791-point set `Y` rotated about `(−2, 0)` by `π/2 ∓ arcsin(1/8)`. So `Yb = ρ(Ya)` for the *difference*
of those two rotations:

| | |
|---|---|
| centre | `(−2, 0)` — **which is vertex 14**, the shared vertex |
| `cos` | `31/32` |
| `sin` | `−3√7/32` |
| the identity that makes it a rotation | `31² + (3√7)² = 961 + 63 = 1024 = 32²` |

Verified exactly, in `ℚ(√3,√5,√7,√11)`, over all 791 points: ρ maps copy A **bijectively onto** copy
B, **fixes vertex 14**, and sends **vertex 11 to vertex 802** — the two ends of the joining edge.
That is de Grey's construction, and it is the whole content of this milestone.

### (b) The index map is arithmetic, so nothing is emitted

Copy A is **exactly vertices 0–790** (an interval — `dedup` puts `Ya` first), and copy B is
`{14} ∪ [791, 1580]`. The index map is therefore closed-form, checked against all 791:

```
φ i = 14        if i = 14        -- the rotation centre, fixed
      791 + i   if i < 14
      790 + i   if i > 14        -- one index skipped: vertex 14 is its own image
```

**Consequences that decide the design.** "Is this vertex in copy A" is `i < 791` — an arithmetic
comparison, not a table lookup. `φ` is injective on `[0, 790]` by `omega`, not by a checked `Bool`.
And **M09 emits no data at all**: the second copy of de Grey's graph is four small numerals and a
closed form.

### (c) The kernel can afford to check the rotation — 0.105 s per vertex

A file importing `deGreyTable` and deciding `N` instances of

```
32 · (q.x − o.x) = 31 · (p.x − o.x) + 3√7 · (p.y − o.y)     (and the y row)
```

against the real table, `decide +kernel`, desktop, min of 3:

| N | CPU s | marginal |
|---|---|---|
| 0 (imports + the pair list) | 2.754 | — |
| 50 | 7.644 | 0.0978 s/vertex |
| 200 | 23.897 | 0.1057 s/vertex |

**791 vertices ⇒ ~86 CPU s.** Six `Q4` multiplications per vertex at ~0.0175 s each, consistent with
M02's 0.0438 s per two-square `distSq`.

### (d) What that 86 seconds replaces: 12.8 hours and 1,061 modules

| | half A | half B |
|---|---|---|
| segment modules | 1,222 | **1,043** |
| modules total | 1,240 | **1,061** |
| source | 222 MB | **180 MB** |
| compiled | 160 MB | **137 MB** |
| processor time (M06 § 4.6, measured) | 15.0 h | **12.8 h** |

Half B's certificate is redundant the moment the rotation is a theorem: its forcing property is half
A's, moved. **12.8 hours → 86 seconds is 536×**, and the artifact a reviewer downloads loses 180 MB.

### (e) Which modules are frozen, and what a mistake costs

Reverse-reachability over the import graph, counting the generated certificate modules downstream of
each candidate:

| module | modules downstream | certificate modules |
|---|---|---|
| `Sat/Encoding.lean` | 2450 | **2433** |
| `Certificate.lean` | 2463 | **2433** |
| `Instances/DeGrey/Table.lean`, `Edges.lean`, `Split.lean` | 2276 | **2267** |
| `Sat/Forcing.lean` | 5 | **0** |
| `Packed.lean` | 13 | **0** |

**Editing a byte of anything in the first three rows costs 27.8 hours.** Everything M09 writes is
downstream of them or new. `Sat/Forcing.lean` and `Instances/DeGrey/{Forcing,Bound,Controls}.lean`
are free to rewrite.

### (f) The rotation-built edge list is de Grey's graph, not another one

`deGreyHalfAEdges ++ deGreyHalfAEdges.map φ̂ ++ [(11, 802)]` has 7877 edges and **the same edge set as
`deGrey.edges` up to orientation**, with 133 distinct differences — the same count M08 measured. Half
A alone has 66; half B alone has 66; the joining edge is the 133rd.

### (g) Two routes for the transported geometry, and why the derived one wins

| | route α: re-certify | route β: derive from the rotation |
|---|---|---|
| what runs | M08's emitter on the new 7877-edge list | 791 rotation identities + half A's existing validity |
| kernel cost | ~56 CPU s | ~86 CPU s |
| new generated modules | 2 (a `Diffs` and a `Valid`, ~10 MB) | **0** |
| what the artifact claims | "these 7877 pairs are one unit apart" | "copy B is congruent to copy A, by *this* rotation" |

β costs 30 seconds more and deletes two generated modules. It is also the only one of the two that is
an *instrument*: at M11 a gadget placed by a proved isometry needs no geometry re-check at all, and
that is the operation the hunt is made of. **Route β.**

---

## 1. What this costs, what it buys, and when to abandon it

**Cost.** ~86 CPU s of new kernel work, no new generated data, one new hand-written module for the
algebra and one for plane motions, and rewrites of six small modules.

**Buys.**
1. **12.8 hours and 1,061 modules deleted**, and de Grey's second copy derived rather than asserted.
2. **One composition theorem in place of two ad-hoc ones.** `not_colorable_of_forcing` (de Grey's
   two-copy shape) and `not_colorable_of_triangle_pinned` (Heule's monolithic shape) become the same
   theorem applied to different gadget lists.
3. **Colour symmetry at any number of ports.** `exists_normalized` (2 ports) and `exists_normalized₃`
   (3 ports) are two copies of one lemma; M09 states it once, for any port count — the form M11 needs.
4. **The search instrument.** A gadget is a `Bool` on port colourings plus a proof; a search over
   gadget placements never runs SAT on the composite.

**Abandon criteria.**
* The general colour-symmetry lemma (`exists_perm_comp_eq`) needs a permutation-extension argument.
  If Mathlib has no `Equiv.extendSubtype`-shaped lemma and hand-rolling it exceeds ~150 lines,
  **fall back** to keeping the 2- and 3-port special cases and stating the general one as carried
  forward. The rest of the milestone does not depend on it.
* If `decide` cannot reduce `∀ q : Fin 3 → Fin 4, (g.inter h).admits q = false` through a structure
  with a `Prop` field, **fall back** to composing the `admits` functions directly and keeping
  soundness extrinsic.
* If half A's certificate turns out to depend on half B's in any way not visible in the import graph,
  stop and report — deleting it would be unsound and the whole milestone rests on it not being so.

---

## 2. The shape

```
                       Gadget n m E p                  a Bool on port colourings, plus its proof
                     ╱      │       ╲
        Gadget.edge   Gadget.ofUnsat   Gadget.transport      the three producers
        (an edge)     (a refutation)   (a vertex map)
                            │                │
                    exists_perm_comp_eq   RotOk + distSq_of_rotOk
                    (colour symmetry)     (a plane isometry)
                     ╲      │       ╱
                       Gadget.inter                     composition
                            │
                    not_colorable_of_gadget             "admits nothing" ⇒ no 4-colouring
```

**No glued-graph type**, following M06's finding: gadgets live over a common ambient vertex set and a
common edge list, and a gadget proved on a sub-edge-list is weakened to the ambient by `Gadget.mono`.
Building a composite *graph* would index data no consumer inspects.

**de Grey, assembled:** ports `![14, 11, 802]`; gadget A from half A's certificate (`q 0 = q 1`),
gadget B from gadget A moved by φ (`q 0 = q 2`), gadget C from the joining edge (`q 1 ≠ q 2`); their
intersection admits nothing, by `decide` over 64 colourings.

**Heule 510 and 553, assembled:** ports `![u, v, w]`; one gadget from the certificate (`q 0, q 1, q 2`
not all distinct), three edge gadgets from the triangle; intersection empty, same `decide`.

---

## 3. The skeleton

### 3.1 `Proofs/HadwigerNelson/Gadget.lean` — the algebra

```lean
structure Gadget (n m : ℕ) (E : List (Fin n × Fin n)) (p : Fin m → Fin n) where
  admits : (Fin m → Fin 4) → Bool
  sound : ∀ f : Fin n → Fin 4, (∀ i j, (edgeGraph n E).Adj i j → f i ≠ f j) →
    admits (fun k => f (p k)) = true

def Gadget.inter (g h : Gadget n m E p) : Gadget n m E p
def Gadget.mono (hsub : E' ⊆ E) (g : Gadget n m E' p) : Gadget n m E p
def Gadget.widen (ι : Fin m → Fin m') (hp : p = p' ∘ ι) (g : Gadget n m E p) : Gadget n m' E p'
def Gadget.transport (φ : Fin n → Fin n)
    (hφ : ∀ e ∈ E', (edgeGraph n E).Adj (φ e.1) (φ e.2)) (g : Gadget n m E' p) :
    Gadget n m E (fun k => φ (p k))
def Gadget.edge (h : (edgeGraph n E).Adj i j) : Gadget n 2 E ![i, j]

theorem not_colorable_of_gadget (g : Gadget n m E p) (h : ∀ q, g.admits q = false) :
    ¬ (edgeGraph n E).Colorable 4

def samePattern (a b : Fin m → Fin 4) : Bool := decide (∀ i j, a i = a j ↔ b i = b j)
theorem exists_perm_comp_eq {a b : Fin m → Fin 4} (h : ∀ i j, a i = a j ↔ b i = b j) :
    ∃ σ : Equiv.Perm (Fin 4), ∀ k, σ (a k) = b k
def pinCube (p : Fin m → Fin n) (q : Fin m → Fin 4) : Cube n 4
def Gadget.ofUnsat (q₀ : Fin m → Fin 4)
    (h : (coloringCNF 4 n E ++ cubeCNF 4 n (pinCube p q₀)).Unsat) : Gadget n m E p
```

**The one hard obligation is `exists_perm_comp_eq`** — every other proof above is three lines. It is
the general form of `exists_normalized` and `exists_normalized₃`, and it is what makes one certificate
cover all 24 colour relabellings at any port count.

### 3.2 `Proofs/HadwigerNelson/Motion.lean` — exact plane isometries

```lean
class NatCancel (K : Type*) [CommRing K] : Prop where
  cancel : ∀ {c : ℕ}, c ≠ 0 → ∀ {x y : K}, (c : K) * x = (c : K) * y → x = y
instance : NatCancel ℤ
instance [CommRing K] [NatScalar K] [NatCancel K] : NatCancel (Adjoin d K)

def RotOk (a b M : Q4) (o p q : Pt) : Bool
theorem distSq_of_rotOk (hab : a * a + b * b = M * M)
    (h : RotOk a b M o p q = true) (h' : RotOk a b M o p' q' = true) :
    M * M * q.distSq q' = M * M * p.distSq p'
theorem distSq_eq_of_rotOk {c : ℕ} (hc : c ≠ 0) (hM : M * M = (c : Q4))
    (hab : a * a + b * b = M * M)
    (h : RotOk a b M o p q = true) (h' : RotOk a b M o p' q' = true) :
    q.distSq q' = p.distSq p'
```

`Q4` is **not** known to be an integral domain here, and proving it is the number theory
`ARCHITECTURE.md` § 2.1 deliberately deletes. So the scale factor `M²` cannot be cancelled as a ring
element — it is cancelled as a **natural number**, which is true of the tower for the cheap reason
that its leaves are `ℤ` and every operation is componentwise.

### 3.3 `Instances/DeGrey/{Rotation,Rotated}.lean` — de Grey's second copy, derived

**Two modules, and the split is deliberate.** `Rotation.lean` holds the constants, the index map and
the two expensive kernel checks: **95 CPU s, measured, and settled** — nothing in it will be edited
again. `Rotated.lean` holds everything derived from them and costs **5.4 CPU s** to re-elaborate.
Lake's traces are content-based, so without the split every word changed while proving
`deGreyRot_valid` would re-run the 791 rotation identities. Same discipline as `Sat/Diagnose.lean`
(M07) and `PackedDiagnose.lean` (M08).

```lean
def deGreyRotA : Q4       -- 31
def deGreyRotB : Q4       -- −3√7
def deGreyRotM : Q4       -- 32
def deGreyRotCentre : Pt  -- (−1536, 0), i.e. (−2, 0) at scale 768
def deGreyPhi (i : Fin 1581) : Fin 1581   -- the closed form of § 0(b)

theorem deGreyRot_id : deGreyRotA * deGreyRotA + deGreyRotB * deGreyRotB
    = deGreyRotM * deGreyRotM                                          -- 961 + 63 = 1024
theorem deGrey_rotation :                                              -- ~86 CPU s
    ((List.range 791).all fun i =>
      RotOk deGreyRotA deGreyRotB deGreyRotM deGreyRotCentre
        (deGreyTable.get i) (deGreyTable.get (deGreyPhi ⟨i, _⟩).val)) = true
theorem deGreyHalfA_in_copy :                                          -- endpoints below 791
    (deGreyHalfAEdges.all fun e => e.1.val < 791 && e.2.val < 791) = true

def deGreyRot : UDCert 1581                                            -- A ++ A.map φ̂ ++ cross
theorem deGreyRot_valid : deGreyRot.Valid = true
theorem deGreyRot_adj_map : ∀ e ∈ deGreyHalfAEdges,
    (edgeGraph 1581 deGreyRot.edges).Adj (deGreyPhi e.1) (deGreyPhi e.2)
```

`deGreyRot_valid` decomposes over the three segments: half A and the joining edge come from
`deGrey_valid` (both are segments of `deGrey.edges`), and **the middle segment is derived** —
`distSq_eq_of_rotOk` carries each half-A edge's exact unit length onto its rotated image.

### 3.4 The call sites

```lean
-- Instances/DeGrey/Bound.lean
def deGreyPorts : Fin 3 → Fin 1581 := ![14, 11, 802]
def deGreyGadgetA : Gadget 1581 3 deGreyRot.edges deGreyPorts   -- half A's certificate
def deGreyGadgetB : Gadget 1581 3 deGreyRot.edges deGreyPorts   -- gadget A, rotated
def deGreyGadgetC : Gadget 1581 3 deGreyRot.edges deGreyPorts   -- the joining edge
theorem deGreyRot_not_colorable_four : ¬ (edgeGraph 1581 deGreyRot.edges).Colorable 4 :=
  not_colorable_of_gadget (deGreyGadgetA.inter (deGreyGadgetB.inter deGreyGadgetC)) (by decide)
theorem chromaticNumber_plane_ge_five : 5 ≤ (unitDistance _).chromaticNumber
```

Heule's two `Bound.lean` modules take the same shape with a triangle in place of the rotation.

### 3.5 The specification, validated at subplan time

Every claim below is a `decide +kernel` or a `#guard` that **has been run**, before any proof effort
was spent — which is the point of writing the skeleton first.

| Claim | Result |
|---|---|
| `31² + (3√7)² = 32²` in `ℚ(√3,√5,√7,√11)` | ✅ |
| the 791 rotation identities against the real vertex table | ✅ **93.6 + 6.3 CPU s** |
| every half-A edge endpoint below 791 | ✅ |
| no half-A edge is a loop | ✅ |
| `φ 14 = 14`, `φ 11 = 802` | ✅ |
| `φ` injective on `[0, 791)`, landing in `{14} ∪ [791, 1580]` | ✅ |
| the `3–4–5` rotation is a model of `RotOk`'s hypotheses | ✅ `by decide` |

So the milestone's central factual claim — **de Grey's second copy is the rotation of his first** —
is a theorem before implementation starts. What remains is proof, not discovery.

---

## 4. Negative controls — every one committed and watched to fail

| The check | Break it by | Expected |
|---|---|---|
| the rotation | changing `deGreyRotA` from 31 to 30 | `deGrey_rotation` false; `31² + 63 ≠ 30² + 63` |
| the rotation's centre | moving `deGreyRotCentre` off `(−2, 0)` | `deGrey_rotation` false |
| the isometry hypothesis | a map with `a² + b² ≠ M²` | a *countermodel*: two points whose images are at a different distance |
| the port images | `φ 11 = 802` replaced by 803 | the joining-edge gadget no longer contradicts |
| composition exhaustiveness | dropping gadget C | `decide` over the 64 colourings goes false |
| colour symmetry needs injectivity | already covered — `not_valid_comp_of_not_injective` | kept |
| cross-filing | half A's table against half B's formula | kept; `halfBCnf` survives half B's deletion |

The last row matters: `deGreyHalfBEdges` lives in the **frozen** `Edges.lean`, so `halfBCnf` can be
rebuilt without half B's 1,061 modules and the cross-filing control survives. The *reverse* control
(`halfB_table_refuses_halfA_cnf`) dies with the table and is replaced by the rotation controls above.

---

## 5. What is deliberately not in this milestone

* **A gadget *library*** — spindles, the H/J/K/L layers of de Grey's own hierarchy. M09 builds the
  algebra and demonstrates it on the constructions already in the repository. → M11.
* **Placement search.** Enumerating isometries that put gadgets in contradictory positions. → M11.
* **Vertex tables built *by* rotation**, so a placed copy costs zero checks rather than one per
  vertex. de Grey's table is frozen data upstream of 2,267 certificate modules, so his copy is
  *checked* against the rotation rather than *defined* by it. → M11, where the tables are new.
* **de Grey's full construction** (`S → Sₐ → S_b → Y → G`, the 397-vertex layer, the H/J/K/L chain).
  Only his **last** step — the two rotated copies — is re-derived here. Stated plainly: this
  milestone derives one rotation, not the whole paper.
