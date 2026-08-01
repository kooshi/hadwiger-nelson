# M11 — The search instrument

*Subplanned 2026-08-01, on the desktop (32 cores, 125 GB). The carry-forward inventory this replaces
is preserved in § 6; every item there is either scheduled below, measured out, or carried to M12.*

The hunt is M12. This milestone exists because a search that stops to build a tool is a search that
stops — and because the hunt's first question is *the wrong one* until the algebra can ask about five
colours.

---

## 0. Measurements — taken before anything was specified

Desktop, `lake env lean` on a one-declaration file, minus a 1.35 s import baseline; minimum of the
runs shown. **Wall clock, single-threaded** — everything here is one kernel reduction, so wall and
CPU coincide to within the baseline.

### (a) What it costs to touch the two modules this milestone rewrites

| change to `Gadget.lean` | what rebuilds | cost |
|---|---|---|
| a `--` line comment | **only `Gadget.lean`** | 2.7 s |
| a `/-- docstring -/` or a `/-! module doc -/` | `Gadget.lean` + all 5 dependents | 10 s wall / 18 CPU s |
| a declaration | `Gadget.lean` + all 5 dependents | 10 s wall / 18 CPU s |

| change to `Motion.lean` | what rebuilds | cost |
|---|---|---|
| anything at all | `Motion` + 5 dependents, of which `DeGrey/Rotation.lean` is 95 s | 112 s wall / 118 CPU s |

**This corrects a rule in `CLAUDE.md`, and the correction is worth more than this milestone.** The
standing rule reads: Lake's traces are content-based, so *"a **comment** in a module the certificates
import re-checks every one of them"* — the sentence that cost 28 hours at M07 and that has shaped
every module layout since. Measured three ways on `Gadget.lean` → `DeGrey/Controls.lean`:

| kind of comment | dependents rebuilt? |
|---|---|
| `-- line comment`, anywhere including inside a proof | **no** |
| `/-- docstring -/` | yes |
| `/-! module doc -/` | yes |

A `--` comment produces a **byte-identical `.olean`**, and Lake's dependent trace is taken from the
artifact, not the source. Doc comments are *stored in the environment* — they are queryable data —
so they change it. The practical consequence: **prose written for a human is free upstream of
anything, provided it is written as `--` rather than `/--`.** The module's own re-elaboration is not
free (2.7 s here), but the 27.8-hour cliff is reachable only by doc comments and declarations.
`CLAUDE.md` is corrected as part of this milestone.

### (b) The terminal check today — full enumeration of `k^m` port colourings

`decide +kernel` on `survivors = []`, worst realistic composite (every pair of ports constrained):

| colours `k` | ports `m` | patterns | net | per pattern |
|---|---|---|---|---|
| 4 | 5 | 1,024 | 0.87 s | 846 µs |
| 4 | 6 | 4,096 | 4.16 s | 1,015 µs |
| 4 | 7 | 16,384 | 18.4 s | 1,124 µs |
| 4 | 8 | 65,536 | 83.4 s | 1,272 µs |
| 5 | 6 | 15,625 | 19.2 s | 1,231 µs |
| 5 | 7 | 78,125 | 107.2 s | 1,372 µs |
| 5 | 8 | 390,625 | **dies — `maxHeartbeats` at 189 s** | — |

**Five colours and eight interface vertices does not run.** That is the milestone's premise, measured
rather than projected.

### (c) Where the time goes — and why filtering is not enough

Enumerating the patterns and doing *nothing else*:

| k | m | patterns | net | per pattern |
|---|---|---|---|---|
| 4 | 7 | 16,384 | 1.66 s | 101 µs |
| 5 | 7 | 78,125 | 8.43 s | 108 µs |

**105 µs per pattern to build it, independent of the colour count**; the remaining ~92% is the
gadgets' own work. So the obvious cheap fix — keep `allPatterns` and filter the canonical ones out of
it — recovers none of the enumeration cost, and at `k = 5, m = 10` the enumeration *alone* is
9,765,625 × 105 µs = **17 minutes before a single gadget is consulted**. The canonical patterns must
be **generated**, never filtered.

### (d) The canonical enumeration, measured — the milestone's central number

One representative per colour-partition of the ports, generated directly:

| k | m | canonical | net | per pattern | full enumeration | **speedup** |
|---|---|---|---|---|---|---|
| 5 | 7 | 855 | 1.49 s | 1,739 µs | 107.2 s (measured) | **72×** |
| 5 | 8 | 3,845 | 8.33 s | 2,166 µs | ~535 s (projected) | ~64× |
| 5 | 9 | 18,002 | 46.5 s | 2,584 µs | ~2,700 s | ~58× |
| 5 | 10 | 86,472 | 257 s | 2,977 µs | ~13,500 s | ~53× |

The realised speedup is **53–72×**, below the 91–113× the pattern counts suggest, because a canonical
pattern costs ~2× a plain one to generate. It does not matter: the number that decides the milestone
is the **interface ceiling**, and it moves from

> **7 ports without canonicalisation → 10 ports with it, at five colours.**

Ten interface vertices at 4.3 minutes, against three and three-quarter hours. Counts, for the record:

| | k=4 | | k=5 | |
|---|---|---|---|---|
| ports | `4^m` | canonical | `5^m` | canonical |
| 6 | 4,096 | 187 | 15,625 | 202 |
| 8 | 65,536 | 2,795 | 390,625 | 3,845 |
| 10 | 1,048,576 | 43,947 | 9,765,625 | 86,472 |
| 12 | 16,777,216 | 700,075 | 244,140,625 | 2,079,475 |

### (e) The brute-force ceiling, so the gadget library's route is not guessed

`decide +kernel` over every `Fin n → Fin k`: the Moser spindle's 3-colouring refutation is 2,187
colourings in 2.6 s — **1.2 ms per colouring**, the same figure as everything else the kernel folds.
Ceiling ≈ 10⁵–10⁶ colourings, i.e. **n ≈ 9 vertices at four colours**. A gadget worth having is
larger than that, so a gadget's colouring property is proved through the certificate route already
built (`Sat/MaskCheck.lean`) and never by exhaustion. The *search* over gadgets runs in Python and is
untrusted, so it is not bound by this at all.

---

## 1. What the measurements decided

### Bought

| # | Item | Why, in one line |
|---|---|---|
| **§ 0** | `Gadget` indexed by the colour count | Blocker. χ(ℝ²) ≥ 6 means refuting **five**-colourings, and every gadget declaration says 4. |
| **§ 1.1** | Canonical colour patterns, generated | (b) says 5 colours × 8 ports does not run; (d) says it runs in 8 s. |
| **§ 1.2** | `Motion` as a similarity, not a rotation-about-a-point | The present type **cannot express a translation**: its matrix has determinant `M² > 0` and a fixed point by construction. |
| **§ 1.3** | `Motion.comp` | Layered constructions compose motions; de Grey's own was derived by hand in Python. |
| **§ 1.4** | Placement by definition | Turns "one coordinate identity per placed vertex" (791 of them, 95 s, for de Grey) into **one lemma, quantified over the point**. |
| **§ 2.1** | Whole-property computation | Turns "a subgraph" into "a gadget" without a human choosing which pattern to refute. |
| **§ 2.2** | Gadget minimisation | `tools/shrink.py` retargeted from "still not 4-colourable" to "still has this port property". |
| **§ 2.3** | The isometric sub-copy scanner | Detects *how* a graph was built and hands back the motion `Motion` consumes. |

### Abandoned, with the reason

| Item | Why not |
|---|---|
| A closure-under-relabelling field on `Gadget` (the inventory's § 1.1 design) | **Not needed at all** — see § 2.2 below. `sound` already quantifies over every proper colouring, and relabelling a proper colouring gives a proper colouring, so the terminal theorem gets colour symmetry for free. The inventory specified a field and seven three-line obligations; the correct design has neither. |
| Keeping `allPatterns` alongside the canonical enumeration | One enumeration, not two. Everything `allPatterns` was for, `canonPatterns` does strictly better — including the reader-facing report, which becomes one line per *class* instead of up to `k!` relabellings of one line. |
| A kernel-run **colouring** search (the analogue of M10's weighted-independence search) | Considered and rejected on (e): it would let a gadget's property be proved without a certificate. But the certificate route exists, is proved sound, and a gadget-sized refutation is a rounding error beside M07's 1.4 M steps. Building it would be a second checker to keep honest. |

### Carried to M12 unless the milestone comes in early

| Item | Why it can wait |
|---|---|
| **§ 1.5** orbit construction | Depends on § 1.4 landing first, and its saving (one certificate per orbit representative) is only collectable once a search proposes an orbit. The scale factor compounds under iteration — level `i` of an orbit needs a common denominator `M^(r-1)` and a translation scaled by `M^i` — which is real design work with no consumer yet. |
| **§ 2.5** a gadget library transcribed from the literature | The published gadgets we would transcribe (Exoo–Ismailescu, Parts) are in venues whose data we do not have, which is the same wall M10 hit with the 383/102 bound. What ships instead is the library **the instrument produces**: § 2.1 run over every construction already in this repository, emitted as data. |

---

## 2. The shape

### 2.1 The colour count becomes an index, and `Proper` loses it entirely

```
Gadget n m E p          ⟹   Gadget k n m E p
admits : (Fin m → Fin 4) → Bool  ⟹   (Fin m → Fin k) → Bool
Proper n E (f : Fin n → Fin 4)   ⟹   Proper n E (f : Fin n → α)     -- any target
```

`Proper` is `∀ i j, Adj i j → f i ≠ f j`. Nothing about that mentions how many colours exist, and
M09 established the same thing about colour symmetry: `exists_perm_comp_eq` is stated over an
arbitrary finite domain and an arbitrary target. So the colour count is an index on `Gadget` and on
nothing else.

### 2.2 Colour symmetry is already in `sound`, and the terminal theorem takes it

This is the milestone's one genuine simplification, and it deletes the design the inventory
specified.

To check only canonical patterns, the terminal theorem needs: *if some proper colouring exists, some
**canonical** pattern is admitted.* Given a proper colouring `C`, let `q = C ∘ p`, let `q'` be its
canonical representative, and let `σ` be the colour permutation with `σ ∘ q' = q`
(`exists_perm_comp_eq`, M09, unchanged). Then

```
σ⁻¹ ∘ C   is a proper colouring        -- σ⁻¹ is injective; that is all `Proper` needs
(σ⁻¹ ∘ C) ∘ p = q'                     -- by construction
g.admits q' = true                     -- g.sound, applied to that colouring
```

No new field, no obligation on any constructor, and every gadget in the repository keeps working
unchanged. The inventory's "`Gadget` gains a closure field, the seven constructors supply it" was a
design derived from the wrong end.

### 2.3 Canonical patterns

A pattern's content is the **partition** of the ports it induces; the colours are names. So the
enumeration is one representative per partition into at most `k` blocks, and the representative is
the classical one: **colours numbered in order of first occurrence** (restricted growth strings).

Generated directly, carrying "how many colours are in use so far":

```lean
def canonAux (k : ℕ) : (m : ℕ) → ℕ → List (Fin m → Fin k)
  | 0,     _ => [Fin.elim0]
  | m + 1, u => (List.finRange k).flatMap fun c =>
      if c.val ≤ u then (canonAux k m (max u (c.val + 1))).map (Fin.cons c) else []
```

The completeness statement — *the* obligation of this milestone — carries a **nodup list of the
original colours in order of first occurrence** as its context, which is exactly the data the
recursion consumes:

```lean
theorem exists_canonAux (m : ℕ) (s : List (Fin k)) (hs : s.Nodup) (q : Fin m → Fin k) :
    ∃ (s' : List (Fin k)) (q' : Fin m → Fin k),
      s'.Nodup ∧ s <+: s' ∧ (∀ i, q i ∈ s') ∧
      q' ∈ canonAux k m s.length ∧ (∀ i, (q' i).val = s'.idxOf (q i))
```

Induction on `m`, `Fin.cons`-first. If `q 0 ∈ s`, the head takes `s.idxOf (q 0)` and the context is
unchanged; if not, the head takes `s.length` and the context extends to `s ++ [q 0]`. The `Fin k`
bound on the head is `s.Nodup → s.length ≤ k`. Same-partition then falls out of nodup-ness:
`q' i = q' j ↔ s'.idxOf (q i) = s'.idxOf (q j) ↔ q i = q j`.

### 2.4 `Motion` becomes a similarity — a matrix and a translation, both cleared

The present type is `M·(image − centre) = [[a, −b], [b, a]]·(source − centre)`: determinant
`a² + b² = M² > 0` and a fixed point built in. It admits rotations about a point and nothing else.
The true shape of "a plane isometry, cleared of its denominator" is an **affine map whose linear part
is orthogonal up to scale**:

```lean
structure Motion where
  a b c d : Q4         -- the linear part  A = [[a, c], [b, d]]
  e f     : Q4         -- the translation, cleared by M
  M       : Q4
  scale   : ℕ
  scale_ne : scale ≠ 0
  sq   : M * M = (scale : Q4)
  col₁ : a * a + b * b = (scale : Q4)
  col₂ : c * c + d * d = (scale : Q4)
  orth : a * c + b * d = 0

def Maps (μ : Motion) (p q : Pt) : Bool :=
  (μ.M * q.x == μ.a * p.x + μ.c * p.y + μ.e) &&
  (μ.M * q.y == μ.b * p.x + μ.d * p.y + μ.f)
```

Three laws instead of one, and **the distance proof gets shorter, not longer**: subtracting the two
rows kills `e` and `f` exactly as it used to kill the centre, and

```
(a·u + c·v)² + (b·u + d·v)² = (a²+b²)u² + 2(ac+bd)uv + (c²+d²)v² = scale·(u² + v²)
```

is one `linear_combination` with **no case split between rotations and reflections** — the sign lives
in the data, not in the proof. What the shape buys:

| | how |
|---|---|
| rotations | `c = −b, d = a` — smart constructor `Motion.rotAbout`, so "rotation about vertex 14" is still what a reader writes |
| reflections | `c = b, d = −a` |
| translations | `a = d = M, b = c = 0` — impossible in the old type at any scale |
| composition (§ 1.3) | `A = A₂A₁`, `t = A₂t₁ + M₁t₂`, `M = M₁M₂`, `scale = scale₁·scale₂`; each law by `linear_combination` |

### 2.5 Placement stops costing one identity per vertex (§ 1.4)

de Grey's second copy costs 791 coordinate identities (95 CPU s) because his vertex table is frozen
data. When a table is *defined* as the image, the check is a lemma instead:

```lean
def Motion.hold (μ : Motion) (p : Pt) : Pt := ⟨μ.M * p.x, μ.M * p.y⟩
def Motion.step (μ : Motion) (p : Pt) : Pt :=
  ⟨μ.a * p.x + μ.c * p.y + μ.e, μ.b * p.x + μ.d * p.y + μ.f⟩

theorem Motion.maps_step (μ : Motion) (p : Pt) : μ.Maps (μ.hold p) (μ.step p) = true
```

One lemma, quantified over the point, and `UDCert.validOn_map_of_motion`'s per-edge hypothesis is
discharged for a copy of any size at **zero** cost. The `hold` is not decoration: a rotation over
`ℤ[√3,√5,√7,√11]` has no unit-norm representative (there is no division in the tower), so the source
side carries the scale factor and the certificate's denominator absorbs it.

### 2.6 The three instruments (`tools/`, untrusted)

| tool | in | out |
|---|---|---|
| `tools/profile.py` | a graph, a port tuple, a colour count | for each **canonical** pattern: SAT (a colouring achieving it) or UNSAT — the gadget's whole property |
| `tools/scan.py` | a point set | every isometry mapping a reference unit pair onto another, with how many points land back in the set — and the `Motion` fields for the best one |
| `tools/minimise.py` | a graph, a port tuple, a property | the smallest subgraph still having it (`shrink.py`'s delta-debugging, retargeted) |

`tools/coloring.py` hardcodes `K = 4` and is generalised with them. Nothing here is trusted: Lean
re-derives every claim, so a bug costs a theorem and cannot buy one.

---

## 3. The skeleton

Three modules, one new. Signatures and full statements, `sorry` at every leaf.

```
Proofs/HadwigerNelson/Pattern.lean    NEW — canonical colour patterns          (Mathlib only)
Proofs/HadwigerNelson/Gadget.lean     rewritten — indexed by the colour count
Proofs/HadwigerNelson/Motion.lean     rewritten — similarity, composition, placement
```

`Pattern.lean` depends on nothing in this project, exactly as `Fractional.lean` does — a candidate
for upstreaming, and a module whose statements must therefore read without any of this context.

### 3.1 `Pattern.lean`

```lean
def canonAux (k : ℕ) : (m : ℕ) → ℕ → List (Fin m → Fin k)
def canonPatterns (k m : ℕ) : List (Fin m → Fin k) := canonAux k m 0

theorem exists_canonAux (k m : ℕ) (s : List (Fin k)) (hs : s.Nodup) (q : Fin m → Fin k) :
    ∃ (s' : List (Fin k)) (q' : Fin m → Fin k),
      s'.Nodup ∧ s <+: s' ∧ (∀ i, q i ∈ s') ∧
      q' ∈ canonAux k m s.length ∧ ∀ i, (q' i).val = s'.idxOf (q i)

/-- **Every colouring of the ports matches a listed one, port for port.** -/
theorem exists_mem_canonPatterns {k m : ℕ} (q : Fin m → Fin k) :
    ∃ q' ∈ canonPatterns k m, ∀ i j, q' i = q' j ↔ q i = q j
```

### 3.2 `Gadget.lean`

```lean
abbrev Proper (n : ℕ) (E : List (Fin n × Fin n)) {α : Type*} (f : Fin n → α) : Prop
structure Gadget (k n m : ℕ) (E : List (Fin n × Fin n)) (p : Fin m → Fin n) where
  admits : (Fin m → Fin k) → Bool
  sound  : ∀ f : Fin n → Fin k, Proper n E f → admits (fun i => f (p i)) = true

-- unchanged in content, `k` threaded:
def inter / trivial / mono / widen / transport / edge
def pinCube / Gadget.ofUnsat

/-- The port colourings, **one per colour-partition**, this gadget has not ruled out. -/
def Gadget.survivors (g : Gadget k n m E p) : List (List (Fin k)) :=
  ((canonPatterns k m).filter g.admits).map (List.ofFn ·)

theorem not_colorable_of_gadget (g : Gadget k n m E p) (h : g.survivors = []) :
    ¬ (edgeGraph n E).Colorable k
```

### 3.3 `Motion.lean`

```lean
structure Motion                                  -- § 2.4
def Motion.Maps (μ : Motion) (p q : Pt) : Bool
theorem Motion.distSq_eq : μ.Maps p q → μ.Maps p' q' → q.distSq q' = p.distSq p'

def Motion.rotAbout / reflectIn / translate / id   -- smart constructors
def Motion.comp (μ₁ μ₂ : Motion) : Motion
theorem Motion.comp_maps : μ₁.Maps p q → μ₂.Maps q r → (μ₁.comp μ₂).Maps p r

def Motion.hold / step
theorem Motion.maps_step (μ : Motion) (p : Pt) : μ.Maps (μ.hold p) (μ.step p) = true

-- unchanged: UDCert.validOn_of_subset, validOn_congr, validOn_map_of_motion
```

---

## 3.5 The domain pass

*Run 2026-08-01 against the skeleton. It found one statement that was false, one role that had no
name, and four pieces of structure that were considered and rejected with reasons.*

### It found a false lemma, which is what the pass is for

The skeleton asserted, with a `sorry` under it:

```lean
theorem maps_step (p : Pt) : μ.Maps (μ.hold p) (μ.step p) = true
```

**It is false.** Substituting the definitions reduces it to `M · e = e`, so it holds only when the
motion has no translation or no scale factor — which is why every spec witness in the skeleton
(`pythagorean`, `flipX`, `shift`) satisfied it and de Grey's real rotation does not. Checked rather
than argued: `#eval deGreyMotion.Maps (deGreyMotion.hold ⟨1,0⟩) (deGreyMotion.step ⟨1,0⟩)` prints
`false`.

The true statement is an identity, not an application:

```lean
theorem maps_iff : μ.Maps p q = true ↔ μ.hold q = μ.step p
```

`#eval` of the right-hand side on de Grey's first vertex and its rotated partner prints `true`, as
does `Maps` itself.

### What that fixed: a motion changes the denominator, and the type now says so

A motion sends a point stored at denominator `d` to one at `d·M`, and the tower has no division, so
**the image cannot be written at `d` at all**. That single fact, split in two, is the file's new
primitive pair:

| | |
|---|---|
| `step p` | the image, at `M` times the source's denominator |
| `hold q` | the same point, re-written at `M` times the denominator |
| `Maps p q` | the frozen-data case: the image *happens* to be writable at `d`, i.e. `hold q = step p` |

Both halves scale squared distance by exactly `scale` — `distSq_hold` from `Motion.sq`,
`distSq_step` from the three similarity laws — and `distSq_eq`, which was going to be a
ten-variable polynomial argument, becomes **three lines**: both sides scale by `scale`, cancel it as
a natural number. That is the convergence signal the pass looks for.

### The role that had no name: a map that scales every squared distance

§ 1.4 asked for placement to cost nothing. It does, and the statement is not about motions:

```lean
theorem UDCert.validOn_of_scaled (c c' : UDCert n) (g : Pt → Pt) (s : Q4) (φ) (es)
    (hg : ∀ p p', (g p).distSq (g p') = s * p.distSq p')
    (hverts : ∀ v, c'.verts (φ v) = g (c.verts v))
    (hden : c'.denomSq = s * c.denomSq)
    (hv : c.ValidOn es = true) :
    c'.ValidOn (es.map fun e => (φ e.1, φ e.2)) = true
```

A certificate whose table is **defined** as the image is valid wherever the original was, with **no
`Maps` check per vertex and no arithmetic per edge** — nothing that grows with the size of the copy.
`Motion.step` is one instance, `Motion.hold` another, and their composite a third; that third is the
one to use when `scale` is not a perfect square, since then no integer denominator matches `M` alone.

The demonstration is in the file: a two-point certificate, a copy placed by the 3–4–5 rotation with
its coordinates defined as the image, and `hverts` discharged by `fun _ => rfl`.

### `Pt` is not the wrong representation

The subplan asked whether the denominator problem means `Pt` should carry its own scale. It does
not: **denomination is an operation on points (`hold`), not a property of the type.** Once that
operation exists, the denominator bookkeeping is arithmetic inside `UDCert` and `Certificate.lean` —
which sits upstream of 2,433 certificate modules, 27.8 hours — is untouched.

### Considered and rejected, with the reason each time

| Considered | Rejected because |
|---|---|
| A `Quotient` of patterns by "same partition" | A quotient is what you build to *reason* about classes; what is needed is a **section** — a computable list hitting every class once. Every function out of the quotient would owe a respects-proof, which is exactly the per-constructor obligation § 1 already deleted. |
| `Matrix (Fin 2) (Fin 2) Q4` for the linear part | `Fin` indexing on every entry access and `Finset.sum` inside `Matrix.mul`, 791 times over in de Grey's check alone. Four named fields, and the vector reading named in prose. |
| Bundling the columns and translation as three `Pt`s | The vector reading is used by the three laws and by nothing else, so it would tax every entry access to make three lines prettier. Wrong side of the placement cut. |
| A `Bool` orientation field with `c = ∓b, d = ±a` — two laws instead of three | Narrower type, and it puts the case split back into every proof. The three-law form is *wider* than "rotation or reflection" and that is safe: everything it admits preserves distance, which is the only property claimed. |
| `Monoid Motion`, so `comp` is `*` and an orbit is `μ ^ i` | One consumer — orbits — and orbits are M12. When it is wanted it is `Motion.ext` plus four `ring` identities, because `comp` is already field-wise. |
| Closing `Motion` under inverse | The three laws say `AᵀA = scale·I`; `A Aᵀ = scale·I` does not follow without `Q4` being an integral domain, which this project deliberately never proves. If M12 needs inverses the fix is three more laws, satisfied by every smart constructor. |

### Moved, and what it deletes

`samePattern` was in `Gadget.lean` and the partition relation it decides was about to be re-stated in
`Pattern.lean`. One concept, two files, no bridge — the standing seam failure. Both now live in
`Pattern.lean` as `SamePattern` (the proposition), `samePattern` (the `Bool`), a `Decidable`
instance, and `samePattern_iff`. Three call sites stop spelling out the quantifier.

### Two spec checks the pass added

* **Coverage, decided.** `∀ q : Fin 4 → Fin 5, (canonPatterns 5 4).any (samePattern · q)` by
  `decide +kernel` — all 625 patterns, checked. The skeleton pinned only *uniqueness*; nothing
  checked that no partition was skipped, which is the direction a wrong enumeration fails in.
* **Placement, demonstrated**, as above.

---

## 3.6 The obligation pass

*Run 2026-08-01 against the twelve open leaves. All twelve are closed; the statements the domain pass
derived turned out to be the statements the proofs come from, and nothing had to be strengthened.*

### The space, written out

`exists_canonAux` is one induction on the number of positions with **three** cases, and the case
table is the whole proof:

| case | what happens | closes in |
|---|---|---|
| no positions | the context is already the answer; every `∀ i : Fin 0` is vacuous | one term |
| the first position **reuses** a name | context unchanged, head takes `s.idxOf (q 0)`, and `max s.length (idx+1) = s.length` puts the tail exactly where the induction hypothesis left it | ~8 lines |
| the first position **opens a block** | context becomes `s ++ [q 0]`, head takes `s.length`, and `max s.length (s.length+1) = s.length+1` matches | ~14 lines |

Both sub-cases of the step needed one fact each, and both are in core with the shape wanted:

* `List.idxOf_append : (l₁ ++ l₂).idxOf a = if a ∈ l₁ then l₁.idxOf a else l₂.idxOf a + l₁.length` —
  it does the prefix transport in the reused case (`then`) *and* computes `(s ++ [c]).idxOf c` in the
  fresh case (`else`). One lemma, both jobs.
* `List.Nodup.length_le_card` — the `Fin k` bound. In the reused case via
  `idxOf_lt_length_of_mem`; in the fresh case from the *extended* list's nodup-ness, which the
  induction hypothesis demands anyway. **The strict `<` the subplan worried about comes for free**,
  because the proof has already built `s ++ [q 0]` before it needs the bound.

The consumer lemma is four lines, and the direction that matters — "same name implies same colour" —
is `List.idxOf_inj`, which needs only membership, not nodup-ness.

### Each conjunct audited against the proof

The subplan asked whether the coverage clause `∀ i, q i ∈ s'` was derivable. It is not, and it is
load-bearing: deleting it (replacing it with `True`) breaks `exists_mem_canonPatterns` at exactly
`List.idxOf_inj (hcov i)` — watched. `List.IsPrefix` was the right relation: transitivity is used in
the fresh case, and `obtain ⟨u, rfl⟩` is how both `idxOf` transports start.

### The terminal theorem, and where colour symmetry actually enters

```lean
obtain ⟨q', hmem, hpart⟩ := exists_mem_canonPatterns (fun i => C (p i))
obtain ⟨σ, hσ⟩          := exists_perm_comp_eq hpart      -- σ ∘ q' = C ∘ p
have hprop : Proper n E (fun v => σ.symm (C v)) := Proper.comp_injective σ.symm.injective …
```

Nine lines, and no `.symm` was missing: `SamePattern q' (C ∘ p)` with the representative *first* is
exactly the orientation `exists_perm_comp_eq` consumes. The colour symmetry is `σ.symm ∘ C` — a
different proper colouring, handed to the same `sound` field. Confirmed: replacing it with `C`
itself breaks the proof.

### The algebra, coefficients confirmed

Every `Motion` obligation closed as one `linear_combination` with the coefficients derived on paper,
first try, and `Q4`'s `ring` handles the four-level tower at this size without complaint:

| obligation | combination |
|---|---|
| `sq_norm_sim` | `u·u·col₁ + 2·u·v·orth + v·v·col₂` |
| `comp.col₁` | `a₁a₁·col₁² + 2a₁b₁·orth² + b₁b₁·col₂² + scale₂·col₁¹` |
| `comp.col₂` | the same with `c₁, d₁` for `a₁, b₁` |
| `comp.orth` | `a₁c₁·col₁² + (a₁d₁ + b₁c₁)·orth² + b₁d₁·col₂² + scale₂·orth¹` |
| `comp.sq` | `M₂M₂·sq¹ + scale₁·sq²` |
| `comp_maps` | `M₁·h'ᵣₒw + a₂·h_x + c₂·h_y` per row |
| `distSq_hold` | `((qx−qx')² + (qy−qy')²)·sq` |
| `rotAbout`/`reflectIn` `col₂` | `linear_combination rot`; their `orth` is `ring` |

`distSq_eq` is now the three-line consequence the domain pass predicted, and `Motion.lean` has no
`sorry` at all.

### Adversarial validation — three mutations, all watched red

| mutation | what went red, and where |
|---|---|
| `canonAux` opens no fresh colour (`c.val ≤ u` → `c.val < u`) | the `if_pos` step in **both** branches of `exists_canonAux`, *and* both `#guard_msgs` on the rendered enumeration — the proof and the spec catch it independently |
| the coverage conjunct replaced by `True` | `exists_mem_canonPatterns` at `List.idxOf_inj (hcov i)` |
| the terminal theorem uses `C` instead of `σ⁻¹ ∘ C` | `not_colorable_of_gadget` at the step that identifies the ports' colours with the representative |

Axioms on the three new public statements: `exists_mem_canonPatterns`, `not_colorable_of_gadget`
and `Motion.distSq_eq` on exactly `[propext, Classical.choice, Quot.sound]`;
`UDCert.validOn_of_scaled` on `[propext, Quot.sound]`. `chromaticNumber_plane_ge_five` — the
milestone-B headline, which now reaches the plane through a rewritten `Motion` and a rewritten
terminal check — is unchanged at `[propext, Classical.choice, Quot.sound]`.

---

## 4. Controls — every one to be watched go red

| # | Break this | The check that must fail, and where |
|---|---|---|
| 1 | Drop `orth : a*c + b*d = 0` from `Motion` | `distSq_eq` stops compiling. A shear preserves no distance, and the countermodel is exhibited (`example : ¬ ∀ …`). |
| 2 | Drop `col₂` | as above — a degenerate second column collapses the plane onto a line |
| 3 | Enumerate `canonAux` with `c.val ≤ u` weakened to `c.val < u` | `exists_canonAux` fails — no pattern can ever open a new colour, and the fresh-colour case has nothing to take |
| 4 | State `not_colorable_of_gadget` over `canonPatterns` **without** relabelling the colouring by `σ⁻¹` | the proof fails; and a `#eval` exhibits a gadget whose only survivor is non-canonical |
| 5 | `Gadget.edge`'s `admits` as `q i == q j` | `K₅` "proves" 4-colourable — the existing spec example goes red |
| 6 | A five-colour spec witness (`K₆`) stated at `k = 4` | the composition admits nothing for the wrong reason; the pinned `survivors` count changes |
| 7 | `profile.py` asked for a pattern it has already refuted | must report UNSAT again, not a cached SAT — the tool's own negative control |

Plus the spec witnesses, which must exist before anything is believed:

* **`K₅` is not 4-colourable and `K₆` is not 5-colourable**, both from edge gadgets alone, no
  certificate — the model that shows the algebra is non-vacuous **at the new colour count**.
* **`K₅` *is* 5-colourable and `K₆` *is* 6-colourable** — so neither statement is a constant answer.
* **A model of every `Motion` law**: the 3–4–5 rotation (already present), a reflection, a
  translation, and a composite; each carrying a stated pair of points to a stated pair.
* **The 5-cycle's canonical patterns**: `canonPatterns 5 3` pinned by `#guard_msgs`, read by hand.

---

## 5. Not in this milestone

* **§ 1.5 orbit construction** and **§ 2.5 a transcribed gadget library** — § 1, carried, with reasons.
* **The hunt itself.** M12.
* **Anything that changes a certificate.** The three witnesses' certificates are not touched;
  `Gadget`'s colour index defaults to nothing and every existing use passes `4` explicitly.

---

## 6. The inventory this replaces

*Written 2026-08-01 as the carry-forward capture; kept because § 3 below is measurement, not plan.*

### The blocker

`Proofs/HadwigerNelson/Gadget.lean` fixes the colour count at four (`admits : (Fin m → Fin 4) → Bool`,
`sound : ∀ f : Fin n → Fin 4, …`). Everything beneath it — `coloringCNF k n E`, `cubeCNF`,
`not_colorable_of_unsat`, `not_pinned`, `exists_perm_comp_eq`, and the reduction from a finite graph
to the plane — is already general in the colour count. `Gadget`, `Proper`, `samePattern`, `pinCube`,
`allPatterns` and `survivors` are not.

### What was measured on 2026-08-01, and what it killed

**The near-symmetry of Heule's witnesses is real, exact, and *not* where the forcing lives.**

| | best non-trivial isometry | covers | misses |
|---|---|---|---|
| Heule 510 | **rotation by exactly 120°** | 482 of 510 (95%) | 28 |
| Heule 553 | **rotation by exactly −60°** | 451 of 553 (82%) | 102 |
| de Grey | rotation by `arccos(31/32)` | 791 of 1581 (50%) | — |

Exact hexagonal-lattice angles, so this is construction structure, not numerical coincidence. The
hypothesis that the forcing lives in the points the symmetry misses is **false**, and the test was
decisive:

| | Heule 510 | Heule 553 |
|---|---|---|
| whole graph 4-colourable | no | no |
| the points the rotation covers, alone | **yes** | **yes** |
| the whole graph minus *the same number of random* points | **yes** | **yes** |
| deleting **one covered** point makes it colourable | **25 / 25** | **25 / 25** |
| deleting **one missed** point makes it colourable | **25 / 25** | **25 / 25** |

**These graphs are vertex-critical.** Every vertex is essential, so there is no sub-region where the
forcing lives. The missed points do have lower degree (7.0 against 9.8) and the pinned triangle is
*not* among them — but the near-symmetry is a fossil of how the graph was **built and then
minimised**, not a feature of why it forces. Consistent with M07's finding that de Grey's forcing
halves are vertex-critical. What it does buy is § 2.3: the scanner detects a construction's
generating motions from its output alone — the tool that would have found M09's saving unaided.

**Rotational symmetry carries no colouring information whatsoever.** A rotationally symmetric
unit-distance graph need not be 4-colourable, and the counterexample is one line: take any graph `G`,
rotate it 180° about a point far from it, take the union. The copies are disjoint, no cross pair is
at unit distance, the union has an exact order-2 rotational automorphism, and its chromatic number is
`χ(G)`. **Symmetrising is free**, so symmetry per se says nothing.

The useful residue, stated as the question actually worth asking: if `ρ` is an automorphism of order
`k`, a *`ρ`-invariant* colouring is a colouring of a quotient graph on `|V|/k` vertices — a `k`-fold
cheaper question. "No invariant colouring" does **not** imply "no colouring", so it can never
*reject* a candidate. It can **promote** one: a cheap test on a `k`-times-smaller graph that says
*look here first*. Worth building as a search filter, worthless as a proof step, and the distinction
must stay written down, because getting it backwards would be unsound.

### Why none of this was built during M09

`Gadget.lean` and `Motion.lean` sit upstream of **five modules and zero generated certificate
modules**. The freeze pressure that justified front-loading work in M06–M08 — where touching a byte
upstream of a certificate costs 27.8 hours — does not exist here, so there was no reason to add
anything before a use demanded it. That reasoning is now spent: this milestone *is* the demanded use.
§ 0(a) puts numbers on it: 18 CPU seconds for `Gadget.lean`, 118 for `Motion.lean`.
