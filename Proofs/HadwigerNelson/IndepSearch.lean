import Proofs.HadwigerNelson.EdgeList
import Proofs.HadwigerNelson.Fractional

/-!
# A kernel-run search for a heavy independent set

`Fractional.lean` reduces a lower bound on `χ_f` to one finite claim: **no independent set of this
graph weighs more than `D`**. This module is how the kernel decides that claim, and the soundness
proof that makes a `true` answer mean it.

## Why a search and not an enumeration

A 63-vertex unit-distance graph has more than `10⁹` independent sets, and the kernel costs about
0.45 ms each. What makes the claim decidable is the **prune**: at every step, if the weight already
chosen plus *all* the weight still available cannot pass `D`, the entire subtree is safe and is not
entered. Measured on the witness this project ships, that is 390,625 visited nodes instead of `10⁹`
— and it is where a bug would hide, which is why `noHeavy_sound` carries the prune's own hypothesis
and why weakening it makes this file stop compiling.

The vertex order matters and is therefore part of the certificate, not an implementation detail:
heaviest-weight-first was measured at 38,128 nodes against 1,029,644 for the certificate's index
order on the same graph.

## Using this file

* `noHeavy` — the `Bool` the kernel decides. `noHeavy_sound` is its whole meaning.
* `mkSlots` — the search's view of a graph, in a chosen vertex order.
* `nbrMask` — a vertex's neighbours as bits.

`Instances/CoreSpindle/Diagnose.lean` holds `findHeavy`, which answers what a `false` was about.
-/

namespace HadwigerNelson

open SimpleGraph Finset
open scoped ENNReal

variable {n : ℕ}

/-! ## Neighbours as bits -/

/-- The neighbours of `v` in the graph presented by `E`, as the bits of a natural number.

The fidelity that matters runs **one way**: `nbrMask_and_two_pow_eq_zero` says a set bit is a listed
pair. Nothing claims the converse, and nothing needs it — a mask that *misses* an edge only makes
the search explore sets that are not independent, so it answers `false` more often and never
wrongly; a mask that *invents* one would skip a genuine independent set, and that is what the lemma
forbids. -/
def nbrMask (E : List (Fin n × Fin n)) (v : Fin n) : ℕ :=
  E.foldr (fun e m =>
    (if e.2 = v then 2 ^ e.1.val else 0) ||| (if e.1 = v then 2 ^ e.2.val else 0) ||| m) 0

/-- A set bit of `nbrMask E v` names a vertex listed as a partner of `v`. -/
theorem nbrMask_testBit (E : List (Fin n × Fin n)) {v : Fin n} {i : ℕ}
    (h : (nbrMask E v).testBit i = true) :
    ∃ u : Fin n, u.val = i ∧ ((u, v) ∈ E ∨ (v, u) ∈ E) := by
  induction E with
  | nil => simp [nbrMask] at h
  | cons e rest ih =>
      simp only [nbrMask, List.foldr_cons, Nat.testBit_or, Bool.or_eq_true] at h
      rcases h with (h | h) | h
      · split at h
        · rename_i he
          have hb : (2 ^ e.1.val).testBit i = true := h
          have : e.1.val = i := by simpa [Nat.testBit_two_pow] using hb
          exact ⟨e.1, this, Or.inl (by simp [← he])⟩
        · simp at h
      · split at h
        · rename_i he
          have hb : (2 ^ e.2.val).testBit i = true := h
          have : e.2.val = i := by simpa [Nat.testBit_two_pow] using hb
          exact ⟨e.2, this, Or.inr (by simp [← he])⟩
        · simp at h
      · obtain ⟨u, hu, hmem⟩ := ih h
        exact ⟨u, hu, hmem.imp (List.mem_cons_of_mem _) (List.mem_cons_of_mem _)⟩

/-- **Mask fidelity.** A non-neighbour's bit is clear.

`u ≠ v` is load-bearing: `edgeGraph` strips loops, so a self-pair `(v, v)` left in the list would
set `v`'s own bit in `v`'s mask without making `v` adjacent to itself. -/
theorem nbrMask_and_two_pow_eq_zero (E : List (Fin n × Fin n)) {u v : Fin n}
    (hne : u ≠ v) (h : ¬ (edgeGraph n E).Adj u v) : nbrMask E v &&& 2 ^ u.val = 0 := by
  refine Nat.eq_of_testBit_eq fun i => ?_
  simp only [Nat.testBit_and, Nat.testBit_two_pow, Nat.zero_testBit, Bool.and_eq_false_iff]
  by_cases hi : u.val = i
  · subst hi
    left
    rcases Bool.eq_false_or_eq_true ((nbrMask E v).testBit u.val) with hb | hb
    · exact absurd (by
        obtain ⟨u', hu', hmem⟩ := nbrMask_testBit E hb
        have hu'' : u' = u := Fin.ext hu'
        rw [hu''] at hmem
        exact (⟨hne, hmem⟩ : (edgeGraph n E).Adj u v)) h
    · exact hb
  · right; simp [hi]

/-! ## The search -/

/-- The search's view of a graph: one triple per visit, in the given vertex order, each holding
**that vertex's bit, its neighbour mask, and its weight**. -/
def mkSlots (E : List (Fin n × Fin n)) (w : Fin n → ℕ) (order : List (Fin n)) :
    List (ℕ × ℕ × ℕ) :=
  order.map fun v => (2 ^ v.val, nbrMask E v, w v)

/-- **`true` only if no independent set weighs more than `D`.**

`chosen` is the bits of the vertices taken so far, `wt` their weight, and `rem` an over-estimate of
the weight still available. The first disjunct is the **prune**: when `wt + rem ≤ D` nothing in the
subtree can pass `D`, so it is not entered.

`noHeavy_sound` is the entire meaning of a `true`. **The converse is not claimed**: a `false` says
the search met something heavy *or* that the masks under-report the graph — see `findHeavy` in
`Instances/CoreSpindle/Diagnose.lean` for which. -/
def noHeavy (D : ℕ) : List (ℕ × ℕ × ℕ) → ℕ → ℕ → ℕ → Bool
  | [], _, wt, _ => wt ≤ D
  | (bit, nbr, wv) :: rest, chosen, wt, rem =>
      wt + rem ≤ D ||
        (noHeavy D rest chosen wt (rem - wv) &&
          (nbr &&& chosen != 0 || noHeavy D rest (chosen ||| bit) (wt + wv) (rem - wv)))

/-- A `Finset` of vertices weighs no more than any list containing all of them. What the prune
consumes. -/
theorem sum_le_list_sum_of_mem (w : Fin n → ℕ) :
    ∀ (l : List (Fin n)) (I : Finset (Fin n)), (∀ v ∈ I, v ∈ l) → ∑ v ∈ I, w v ≤ (l.map w).sum
  | [], I, hsub => by
      have : I = ∅ := Finset.eq_empty_of_forall_notMem fun v hv => by simpa using hsub v hv
      simp [this]
  | u :: rest, I, hsub => by
      have hI : ∑ v ∈ I.erase u, w v ≤ (rest.map w).sum :=
        sum_le_list_sum_of_mem w rest (I.erase u) fun v hv =>
          (List.mem_cons.mp (hsub v (Finset.mem_of_mem_erase hv))).resolve_left
            (Finset.ne_of_mem_erase hv)
      by_cases hu : u ∈ I
      · rw [← Finset.add_sum_erase I w hu]; simpa using Nat.add_le_add_left hI (w u)
      · rw [Finset.erase_eq_of_notMem hu] at hI
        simp only [List.map_cons, List.sum_cons]
        omega

/-- The induction `noHeavy_sound` runs. Generalised over the mask, the weight so far and the
remaining budget — and over nothing else: the vertices already chosen enter only through
"is this candidate compatible", which is a statement about the mask alone. -/
private theorem noHeavy_sound_aux (E : List (Fin n × Fin n)) (w : Fin n → ℕ) (D : ℕ) :
    ∀ (order : List (Fin n)) (chosen wt rem : ℕ),
      noHeavy D (mkSlots E w order) chosen wt rem = true →
      (order.map w).sum ≤ rem →
      ∀ I : Finset (Fin n),
        (∀ v ∈ I, v ∈ order) →
        (edgeGraph n E).IsIndepSet (I : Set (Fin n)) →
        (∀ v ∈ I, nbrMask E v &&& chosen = 0) →
        wt + ∑ v ∈ I, w v ≤ D := by
  intro order
  induction order with
  | nil =>
      intro chosen wt rem hrun _ I hsub _ _
      simp only [mkSlots, List.map_nil, noHeavy, decide_eq_true_eq] at hrun
      have : I = ∅ := Finset.eq_empty_of_forall_notMem fun v hv => by simpa using hsub v hv
      simp [this, hrun]
  | cons u rest ih =>
      intro chosen wt rem hrun hrem I hsub hind hcompat
      simp only [mkSlots, List.map_cons, noHeavy, Bool.or_eq_true, decide_eq_true_eq,
        Bool.and_eq_true, bne_iff_ne, ne_eq] at hrun
      simp only [List.map_cons, List.sum_cons] at hrem
      rcases hrun with hprune | ⟨hA, hBr⟩
      · -- PRUNE: all the weight still available cannot lift `wt` past `D`.
        have := sum_le_list_sum_of_mem w (u :: rest) I hsub
        simp only [List.map_cons, List.sum_cons] at this
        omega
      · by_cases hu : u ∈ I
        · -- TAKE `u`: it is compatible, so the blocked branch is not the one that ran.
          have hcu : nbrMask E u &&& chosen = 0 := hcompat u hu
          have hB : noHeavy D (mkSlots E w rest) (chosen ||| 2 ^ u.val) (wt + w u)
              (rem - w u) = true := hBr.resolve_left (by simp [hcu])
          have hIe : ∀ v ∈ I.erase u, v ∈ rest := fun v hv =>
            (List.mem_cons.mp (hsub v (Finset.mem_of_mem_erase hv))).resolve_left
              (Finset.ne_of_mem_erase hv)
          have hindE : (edgeGraph n E).IsIndepSet ((I.erase u : Finset (Fin n)) : Set (Fin n)) :=
            hind.mono (Finset.coe_subset.mpr (Finset.erase_subset u I))
          have hcompatE : ∀ v ∈ I.erase u, nbrMask E v &&& (chosen ||| 2 ^ u.val) = 0 := by
            intro v hv
            have hvI : v ∈ I := Finset.mem_of_mem_erase hv
            have hvu : v ≠ u := Finset.ne_of_mem_erase hv
            have hadj : ¬ (edgeGraph n E).Adj u v :=
              hind (by simpa using hu) (by simpa using hvI) (Ne.symm hvu)
            rw [Nat.and_or_distrib_left, hcompat v hvI,
              nbrMask_and_two_pow_eq_zero E (Ne.symm hvu) hadj, Nat.or_zero]
          have := ih (chosen ||| 2 ^ u.val) (wt + w u) (rem - w u) hB (by omega) (I.erase u)
            hIe hindE hcompatE
          rw [← Finset.add_sum_erase I w hu]
          omega
        · -- SKIP `u`.
          exact ih chosen wt (rem - w u) hA (by omega) I
            (fun v hv => (List.mem_cons.mp (hsub v hv)).resolve_left (fun h => hu (h ▸ hv)))
            hind hcompat

/-- **Soundness.** A `true` answer means what it says, for every independent set of the graph.

The two obligations on the certificate are one `decide` each: the order reaches every vertex, and
`rem` is at least the total weight the order carries. Duplicates in the order are harmless — a
vertex offered twice can only be counted twice, which makes the search more conservative. -/
theorem noHeavy_sound (E : List (Fin n × Fin n)) (w : Fin n → ℕ) (D rem : ℕ)
    (order : List (Fin n)) (hcover : ∀ v : Fin n, v ∈ order)
    (hrem : (order.map w).sum ≤ rem)
    (h : noHeavy D (mkSlots E w order) 0 0 rem = true)
    (I : Finset (Fin n)) (hI : (edgeGraph n E).IsIndepSet (I : Set (Fin n))) :
    ∑ v ∈ I, w v ≤ D := by
  simpa using noHeavy_sound_aux E w D order 0 0 rem h hrem I (fun v _ => hcover v) hI
    (fun v _ => Nat.and_zero _)

/-- **The bound, assembled.** Exact geometry is not this module's business; this is the step from
"the search says so" to a lower bound on the graph's fractional chromatic number. -/
theorem le_fractionalChromaticNumber_of_noHeavy (E : List (Fin n × Fin n)) (w : Fin n → ℕ)
    {S T D rem : ℕ} (order : List (Fin n)) (hD : 0 < D)
    (hcover : ∀ v : Fin n, v ∈ order) (hrem : (order.map w).sum ≤ rem)
    (hST : S * D ≤ T * ∑ v, w v)
    (h : noHeavy D (mkSlots E w order) 0 0 rem = true) :
    (S : ℝ≥0∞) / T ≤ (edgeGraph n E).fractionalChromaticNumber :=
  le_fractionalChromaticNumber_of_weights w hD hST
    (noHeavy_sound E w D rem order hcover hrem h)

/-! ## Out to the plane

The same two steps `UnitDistance.lean` takes for the ordinary chromatic number, for the fractional
one: a drawing with unit-length edges is a homomorphism, and the model of the plane does not
matter. -/

variable {V W : Type*}

/-- The fractional chromatic number does not see which model of the plane we chose — so the
construction may live in `ℂ`, where rotation is multiplication, and the headline in
`EuclideanSpace ℝ (Fin 2)`, where a reader expects it. -/
theorem fractionalChromaticNumber_unitDistance_congr [MetricSpace V] [MetricSpace W] (e : V ≃ᵢ W) :
    (unitDistance V).fractionalChromaticNumber = (unitDistance W).fractionalChromaticNumber := by
  refine le_antisymm ?_ ?_
  · exact fractionalChromaticNumber_mono_of_hom
      (unitDistanceHom _ e fun i j h => by rw [e.dist_eq]; exact unitDistance_adj.mp h)
  · exact fractionalChromaticNumber_mono_of_hom
      (unitDistanceHom _ e.symm fun i j h => by rw [e.symm.dist_eq]; exact unitDistance_adj.mp h)

/-- **The reduction, fractional.** A finite graph drawn in a metric space with unit-length edges
pushes its fractional lower bound up to the space's unit-distance graph. The hypothesis is exactly
what an exact-arithmetic edge check produces. -/
theorem le_fractionalChromaticNumber_unitDistance_edgeList [MetricSpace V] {S T : ℕ}
    (E : List (Fin n × Fin n)) (p : Fin n → V) (hp : ∀ e ∈ E, dist (p e.1) (p e.2) = 1)
    (h : (S : ℝ≥0∞) / T ≤ (edgeGraph n E).fractionalChromaticNumber) :
    (S : ℝ≥0∞) / T ≤ (unitDistance V).fractionalChromaticNumber := by
  refine h.trans (fractionalChromaticNumber_mono_of_hom (unitDistanceHom _ p ?_))
  rintro i j ⟨-, hij | hji⟩
  · exact hp (i, j) hij
  · rw [dist_comm]; exact hp (j, i) hji

end HadwigerNelson
