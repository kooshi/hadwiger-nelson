import Proofs.HadwigerNelson.Field.Approx
import Proofs.HadwigerNelson.Certificate
import Proofs.HadwigerNelson.Critical
import Proofs.HadwigerNelson.Fan

/-! # No fan confined to one distance — the certified negative

M15 found the only five-colour fans in existence: four pivots of de Grey's unshrunk 1581-vertex
graph. The closing move needs a fan **confined to a single real distance** from its pivot
(`not_colorable_of_spindled_fan`), and M16's sweep answered that none of the four is — every one of
the 1,340 equidistance classes at every pivot is separated by an explicit proper 5-colouring, eight
colourings per pivot sufficing.

This module is the checker that turns those colourings into the kernel-checked statement

> *no list of vertices, not containing the pivot, all at one real distance from it, carries a fan,*

and the statement is about **real** distances, not their `Q4` representations — the gap between the
two is exactly what `Field/Approx.lean` closes: the certificate carries the class values sorted,
their intervals pairwise disjoint, so equal real distances force equal classes and one colouring
per class covers every equidistant partner list.

Everything the emitter writes is untrusted. The colourings, the class table, the hints and the
generator bounds are all data; `NarrowCert.check` is the single `Bool` the kernel decides, and
`NarrowCert.sound` is the once-proved bridge from that `Bool` to the headline. A wrong table makes
`check` false; it cannot make a theorem false.
-/

namespace HadwigerNelson

/-- A `bits`-wide field read out of a packed `Nat` — `unpackColor` without the colour bound, for
class ids and hints, where the range check is the consumer's lookup coming back `none`. -/
def unpackNat (bits packed i : ℕ) : ℕ := (packed >>> (bits * i)) % 2 ^ bits

/-- A signed field: the `i`-th `bits`-wide field, zig-zag decoded (`0, -1, 1, -2, 2, …`), so the
emitter packs signed tower components into one `Nat` per class value. -/
def unpackZ (bits packed i : ℕ) : ℤ :=
  let u := unpackNat bits packed i
  if u % 2 = 0 then (u / 2 : ℤ) else -((u / 2 : ℤ) + 1)

/-- A `Q4` value from sixteen zig-zag fields, component order little-endian in the tower:
field 0 is the rational part, field 1 the `√3` coefficient, field 2 the `√5` coefficient,
field 3 the `√15` coefficient, and so on up the levels — exactly the order `Adjoin`'s nested
pairs store them. One packed `Nat` per class value, following M04's rule that a `Nat` literal
costs ~2.3 KB of olean while a literal tree costs ~145 bytes per node — and, measured at M02
scale, a module of sixteen-component `Q4` literals costs seconds and gigabytes to *elaborate*
that packed numerals do not. -/
def unpackQ4 (bits packed : ℕ) : Q4 :=
  ⟨⟨⟨⟨unpackZ bits packed 0, unpackZ bits packed 1⟩,
     ⟨unpackZ bits packed 2, unpackZ bits packed 3⟩⟩,
    ⟨⟨unpackZ bits packed 4, unpackZ bits packed 5⟩,
     ⟨unpackZ bits packed 6, unpackZ bits packed 7⟩⟩⟩,
   ⟨⟨⟨unpackZ bits packed 8, unpackZ bits packed 9⟩,
     ⟨unpackZ bits packed 10, unpackZ bits packed 11⟩⟩,
    ⟨⟨unpackZ bits packed 12, unpackZ bits packed 13⟩,
     ⟨unpackZ bits packed 14, unpackZ bits packed 15⟩⟩⟩⟩

/-- **Every listed edge is bichromatic** under the packed colouring — full properness, against the
graph the fan lives on. Listed self-loops are skipped exactly as `edgeGraph` strips them. -/
def properColouring {n : ℕ} (E : List (Fin n × Fin n)) (bits k col : ℕ) : Bool :=
  E.all fun e => e.1 == e.2 || unpackColor bits k col e.1.val != unpackColor bits k col e.2.val

/-- A packed colouring that survives `properColouring` is a colouring of the edge-list graph, and
its values are readable back — the readable form is what separation arguments consume. -/
theorem exists_coloring_of_proper {n : ℕ} {E : List (Fin n × Fin n)} {bits k col : ℕ}
    (hk : 0 < k) (h : properColouring E bits k col = true) :
    ∃ C : (edgeGraph n E).Coloring (Fin k),
      ∀ v : Fin n, (C v).val = unpackColor bits k col v.val := by
  rw [properColouring, List.all_eq_true] at h
  refine ⟨SimpleGraph.Coloring.mk
    (fun v => ⟨unpackColor bits k col v.val, Nat.mod_lt _ hk⟩) ?_, fun v => rfl⟩
  intro a b hab
  rw [edgeGraph_adj] at hab
  obtain ⟨hne, hmem⟩ := hab
  have key : ∀ {i j : Fin n}, (i, j) ∈ E → i ≠ j →
      unpackColor bits k col i.val ≠ unpackColor bits k col j.val := by
    intro i j hij hne'
    have hrow := h _ hij
    simp only [Bool.or_eq_true, beq_iff_eq, bne_iff_ne, ne_eq] at hrow
    rcases hrow with hc | hc
    · exact absurd hc hne'
    · exact hc
  intro hc
  have hc' : unpackColor bits k col a.val = unpackColor bits k col b.val :=
    congrArg Fin.val hc
  rcases hmem with hij | hji
  · exact key hij hne hc'
  · exact key hji hne.symm hc'.symm

/-- **The narrow-fan certificate**: everything the emitter claims about one pivot, as data.

The class structure is three claims — every non-pivot vertex's exact squared distance to the pivot
is `classVals[classId v]` (binding), the `classVals` are pairwise-distinct reals (separation, via
`Field/Approx`), and per class one committed colouring separates the whole class from the pivot
(coverage). `hints` is per-class, not per-vertex, deliberately: a per-vertex hint would let two
same-class vertices cite different colourings, which un-proves exactly the union step the headline
needs. -/
structure NarrowCert (n : ℕ) where
  /-- The pivot the fans sit at. -/
  pivot : Fin n
  /-- The colour count the fan question is asked at. -/
  k : ℕ
  /-- Field width of one colour in a packed colouring. -/
  bits : ℕ
  /-- Field width of one class id in `classIds`. -/
  idBits : ℕ
  /-- Field width of one hint in `hints`. -/
  hintBits : ℕ
  /-- Integer intervals for the four generators, checked by `SqrtBounds.Ok`. -/
  bounds : SqrtBounds
  /-- Field width of one tower component in a packed class value. -/
  valBits : ℕ
  /-- The distinct squared distances from the pivot, ascending in real value — one zig-zag-packed
  `Nat` per value (see `unpackQ4`), the emitter's claim verified by `sepChain`. -/
  classVals : List ℕ
  /-- Packed: each vertex's index into `classVals`. -/
  classIds : ℕ
  /-- Packed: each class's index into `colourings`. -/
  hints : ℕ
  /-- The separating colourings, each `bits` per vertex. -/
  colourings : List ℕ

namespace NarrowCert

variable {n : ℕ}

/-- One vertex's obligations: its class id resolves, the resolved value **is** its exact squared
distance to the pivot, and the class's hinted colouring separates it from the pivot. -/
def checkVertex (c : NarrowCert n) (verts : Fin n → Pt) (v : Fin n) : Bool :=
  let i := unpackNat c.idBits c.classIds v.val
  match c.classVals[i]? with
  | none => false
  | some d =>
    decide ((verts v).distSq (verts c.pivot) = unpackQ4 c.valBits d) &&
    match c.colourings[unpackNat c.hintBits c.hints i]? with
    | none => false
    | some col =>
      unpackColor c.bits c.k col v.val != unpackColor c.bits c.k col c.pivot.val

/-- **The whole certificate, one `Bool`**: generator bounds check, class values are separated
reals, at least one colouring exists (the empty-`Q` case needs the graph colourable), every
colouring is proper, and every non-pivot vertex passes `checkVertex`. -/
def check (c : NarrowCert n) (verts : Fin n → Pt) (E : List (Fin n × Fin n)) : Bool :=
  c.bounds.Ok &&
  sepChain c.bounds (c.classVals.map (unpackQ4 c.valBits)) &&
  !c.colourings.isEmpty &&
  c.colourings.all (properColouring E c.bits c.k) &&
  (List.finRange n).all fun v => v == c.pivot || c.checkVertex verts v

/-- Equal real distances to the pivot force equal exact squared distances — `eval_distSq` run
backward through `dist`. The only step that touches `ℝ`'s geometry, isolated here. -/
theorem eval_distSq_eq_of_dist_eq {D : ℤ} (hD : D ≠ 0) {p q q' : Pt}
    (h : dist (q.toPlane D) (p.toPlane D) = dist (q'.toPlane D) (p.toPlane D)) :
    Q4.eval (q.distSq p) = Q4.eval (q'.distSq p) := by
  have hD' : ((D : ℤ) : ℝ) ≠ 0 := Int.cast_ne_zero.mpr hD
  have key : ∀ z : Pt,
      Q4.eval (z.distSq p) = Complex.normSq (z.toPlane D - p.toPlane D) * (D : ℝ) ^ 2 := by
    intro z
    rw [eval_distSq]
    simp only [Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Pt.toPlane]
    field_simp
  have hnorm : Complex.normSq (q.toPlane D - p.toPlane D)
      = Complex.normSq (q'.toPlane D - p.toPlane D) := by
    have e : Real.sqrt (Complex.normSq (q.toPlane D - p.toPlane D))
        = Real.sqrt (Complex.normSq (q'.toPlane D - p.toPlane D)) := by
      rw [← Complex.norm_def, ← Complex.norm_def, ← Complex.dist_eq, ← Complex.dist_eq]
      exact h
    calc Complex.normSq (q.toPlane D - p.toPlane D)
        = Real.sqrt (Complex.normSq (q.toPlane D - p.toPlane D)) ^ 2 := by
          rw [Real.sq_sqrt (Complex.normSq_nonneg _)]
      _ = Real.sqrt (Complex.normSq (q'.toPlane D - p.toPlane D)) ^ 2 := by rw [e]
      _ = Complex.normSq (q'.toPlane D - p.toPlane D) := Real.sq_sqrt (Complex.normSq_nonneg _)
  rw [key q, key q', hnorm]

/-- What one passed vertex check yields, in the form the soundness proof consumes: the packed
class value its id resolves to, the exact-distance binding, and the hinted colouring with its
separation fact. Private because it is match plumbing, not mathematics. -/
private theorem checkVertex_spec {c : NarrowCert n} {verts : Fin n → Pt} {v : Fin n}
    (h : c.checkVertex verts v = true) :
    ∃ pk col,
      c.classVals[unpackNat c.idBits c.classIds v.val]? = some pk ∧
      (verts v).distSq (verts c.pivot) = unpackQ4 c.valBits pk ∧
      c.colourings[unpackNat c.hintBits c.hints (unpackNat c.idBits c.classIds v.val)]?
        = some col ∧
      unpackColor c.bits c.k col v.val ≠ unpackColor c.bits c.k col c.pivot.val := by
  rw [checkVertex] at h
  split at h
  case _ => simp at h
  case _ pk hpk =>
    rw [Bool.and_eq_true] at h
    obtain ⟨hd, h⟩ := h
    split at h
    case _ => simp at h
    case _ col hcol =>
      exact ⟨pk, col, hpk, by simpa using hd, hcol, by simpa using h⟩

/-- **Soundness.** A checked certificate refutes every fan over an equidistant partner list:
for every real `r`, no list of vertices avoiding the pivot and all at distance `r` from it is a
fan at the pivot.

The proof's shape: an empty `Q` is refuted by any committed colouring; a nonempty `Q` picks
`q₀ ∈ Q`, every `q ∈ Q` shares `q₀`'s real distance, `eval_distSq_eq_of_dist_eq` and
`index_eq_of_eval_eq` force `classId q = classId q₀`, and the class's hinted colouring separates
all of `Q` at once. -/
theorem sound (c : NarrowCert n) {verts : Fin n → Pt} {E : List (Fin n × Fin n)} {D : ℤ}
    (hchk : c.check verts E = true) (hD : D ≠ 0 := by decide) (hk : 0 < c.k := by decide) :
    ∀ (r : ℝ) (Q : List (Fin n)), c.pivot ∉ Q →
      (∀ q ∈ Q, dist ((verts q).toPlane D) ((verts c.pivot).toPlane D) = r) →
      ¬ Fan (edgeGraph n E) c.k c.pivot Q := by
  intro r Q hpQ hdist
  rw [check] at hchk
  simp only [Bool.and_eq_true] at hchk
  obtain ⟨⟨⟨⟨hOk, hsep⟩, hnonempty⟩, hproper⟩, hall⟩ := hchk
  rw [List.all_eq_true] at hall
  have hCV : ∀ v : Fin n, v ≠ c.pivot → c.checkVertex verts v = true := by
    intro v hv
    have hrow := hall v (List.mem_finRange v)
    simpa [Bool.or_eq_true, beq_iff_eq, hv] using hrow
  cases Q with
  | nil =>
    obtain ⟨col, hcol⟩ : ∃ col, col ∈ c.colourings := by
      cases hc : c.colourings with
      | nil => rw [hc] at hnonempty; simp at hnonempty
      | cons a t => exact ⟨a, List.mem_cons_self⟩
    obtain ⟨C, -⟩ := exists_coloring_of_proper hk (List.all_eq_true.mp hproper col hcol)
    intro hFan
    obtain ⟨q, hq, -⟩ := hFan C
    simp at hq
  | cons q₀ Q' =>
    have hq₀ : q₀ ∈ q₀ :: Q' := List.mem_cons_self
    have hq₀p : q₀ ≠ c.pivot := fun h => hpQ (h ▸ hq₀)
    obtain ⟨pk₀, col, hpk₀, hd₀, hcol₀, -⟩ := checkVertex_spec (hCV q₀ hq₀p)
    -- every partner lands in q₀'s class, because its real distance is q₀'s
    have hsame : ∀ q ∈ q₀ :: Q',
        unpackNat c.idBits c.classIds q.val = unpackNat c.idBits c.classIds q₀.val := by
      intro q hq
      have hqp : q ≠ c.pivot := fun h => hpQ (h ▸ hq)
      obtain ⟨pk, -, hpk, hd, -, -⟩ := checkVertex_spec (hCV q hqp)
      have hev : Q4.eval ((verts q).distSq (verts c.pivot))
          = Q4.eval ((verts q₀).distSq (verts c.pivot)) :=
        eval_distSq_eq_of_dist_eq hD ((hdist q hq).trans (hdist q₀ hq₀).symm)
      rw [hd, hd₀] at hev
      exact index_eq_of_eval_eq hOk hsep
        (by rw [List.getElem?_map, hpk]; rfl)
        (by rw [List.getElem?_map, hpk₀]; rfl) hev
    have hcolmem : col ∈ c.colourings := by
      obtain ⟨hlt, hget⟩ := List.getElem?_eq_some_iff.mp hcol₀
      exact hget ▸ List.getElem_mem hlt
    obtain ⟨C, hCval⟩ := exists_coloring_of_proper hk (List.all_eq_true.mp hproper col hcolmem)
    intro hFan
    obtain ⟨q, hq, hCq⟩ := hFan C
    have hqp : q ≠ c.pivot := fun h => hpQ (h ▸ hq)
    obtain ⟨pk, col', -, -, hcol', hsep'⟩ := checkVertex_spec (hCV q hqp)
    rw [hsame q hq, hcol₀] at hcol'
    obtain rfl : col = col' := Option.some_inj.mp hcol'
    have hvals : unpackColor c.bits c.k col c.pivot.val = unpackColor c.bits c.k col q.val := by
      have h1 := hCval c.pivot
      have h2 := hCval q
      rw [← h1, ← h2]
      exact congrArg Fin.val hCq
    exact hsep' hvals.symm

end NarrowCert

/-! ## Specification — the smallest instance that discriminates

Three collinear points at denominator 1: `p = (0,0)` the pivot, `(1,0)` adjacent to it, `(2,0)`
not. Two classes (`distSq 1` and `4`), one 3-colouring separating both, and mutations of every
datum the checker must refuse. -/

private def specVerts : Fin 3 → Pt := ![⟨0, 0⟩, ⟨1, 0⟩, ⟨2, 0⟩]

private def specEdges : List (Fin 3 × Fin 3) := [(0, 1)]

/-- Colours `0, 1, 1` for vertices `0, 1, 2`, packed 2 bits each. -/
private def specColouring : ℕ := 0 + 1 * 4 + 1 * 16

private def specCert : NarrowCert 3 where
  pivot := 0
  k := 3
  bits := 2
  idBits := 1
  hintBits := 1
  bounds := .coarse
  valBits := 8
  -- zig-zag packed: `2` decodes to the rational value 1, `8` to 4
  classVals := [2, 8]
  -- vertex 0 (pivot, unread) ↦ 0, vertex 1 ↦ class 0, vertex 2 ↦ class 1
  classIds := 0 + 0 * 2 + 1 * 4
  -- both classes point at colouring 0
  hints := 0
  colourings := [specColouring]

#guard specCert.check specVerts specEdges
-- The decoder reads the packed values back as the tower values they claim to be.
#guard unpackQ4 8 2 = (1 : Q4)
#guard unpackQ4 8 8 = (4 : Q4)
#guard unpackZ 8 3 0 = (-2 : ℤ)

-- The discriminating partners, one per datum:
-- an improper colouring (vertex 1 recoloured to the pivot's colour) is refused...
#guard !((({ specCert with colourings := [0 + 0 * 4 + 1 * 16] } : NarrowCert 3)).check
  specVerts specEdges)
-- ...an empty colouring list is refused — the empty-partner-list case of the headline needs the
-- graph colourable, and nothing else in the certificate witnesses it...
#guard !((({ specCert with colourings := [] } : NarrowCert 3)).check specVerts specEdges)
-- ...class values out of real order are refused...
#guard !((({ specCert with classVals := [8, 2] } : NarrowCert 3)).check specVerts specEdges)
-- ...a class id binding a vertex to the wrong value is refused...
#guard !((({ specCert with classIds := 0 + 1 * 2 + 1 * 4 } : NarrowCert 3)).check
  specVerts specEdges)
-- ...a hint out of range is refused...
#guard !((({ specCert with hints := 1 + 1 * 2 } : NarrowCert 3)).check specVerts specEdges)
-- ...and a colouring that fails to separate a class is caught by the vertex walk: recolour
-- vertex 2 to the pivot's colour — still proper (2 is isolated), refused by `checkVertex`.
#guard !((({ specCert with colourings := [0 + 1 * 4 + 0 * 16] } : NarrowCert 3)).check
  specVerts specEdges)

/-- The specification's payoff, exactly as a generated module will consume it — one argument, the
kernel-decided certificate check; the denominator and colour-count side conditions discharge as
`autoParam`s because every call site would have written the same two `by decide`s. No equidistant
partner list is a fan at the pivot, at any real distance. -/
example :
    ∀ (r : ℝ) (Q : List (Fin 3)), (0 : Fin 3) ∉ Q →
      (∀ q ∈ Q, dist ((specVerts q).toPlane 1) ((specVerts 0).toPlane 1) = r) →
      ¬ Fan (edgeGraph 3 specEdges) 3 0 Q :=
  specCert.sound (by decide +kernel)

end HadwigerNelson
