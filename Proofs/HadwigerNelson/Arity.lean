import Proofs.HadwigerNelson.Coverage
import Proofs.HadwigerNelson.Pattern

/-!
# The arity of a colour compulsion

Four campaigns in this repository (M31, M32, M35, M41) asked "is anything forced?" of every object
it holds, and every meter read exactly zero. Every one of those meters asked about a **pair** of
vertices. This file names what they were measuring, so that the question "at what order does a
compulsion live?" can be asked at all.

## The object

Fix a graph, `k` colours, `m` vertices `S`, and a **pattern** `p` — which of the `m` positions share
a colour. `Pattern.lean` already supplies the right notion of "same pattern"
(`SamePattern a b : ∀ i j, a i = a j ↔ b i = b j`, i.e. same partition) together with a complete
enumeration of representatives, so nothing here re-invents it.

Two conditions make the notion well posed, and both are load-bearing rather than hygienic:

* **the vertices are distinct** — otherwise `S = (v, v)` with `p = (0, 1)` is unrealizable for a
  reason that has nothing to do with the graph, and *every* graph would have arity floor `2`;
* **the pattern is locally proper** — no edge inside a block — otherwise *every* graph with an edge
  would have arity floor `2`.

Bundled, those two say exactly that `S` lists `m` distinct vertices and `p` properly colours the
subgraph they induce — a `PartialColoring`. So the definitions read:

> **a compulsion is a partial colouring that does not extend**, and the **arity floor** is the least
> number of vertices you must look at before local properness stops implying global extendability.

## This is the genus of four notions already here, not a fifth

* `Forces` and `Separated` are *exactly* the two arity-`2` compulsions — `compels_two_ne` and
  `compels_two_eq`, and the constructors `Forces.compels` / `Separated.compels` are how a caller
  travels from the old vocabulary to the new one.
* `Fan` is a *disjunction* of compulsions: `Fan G k v Q` says no realizable pattern isolates `v`.
* `Compulsion.no_mono_outer_triple` (M20 — an outer 120°-triple is never monochromatic in a proper
  `3`-colouring) was an arity-`3` compulsion all along; `Instances/AritySpec.lean` records it as one.

## Two things the definition does for free

**The vacuity guard becomes a value.** At `m = 0` the empty tuple is distinct and locally proper
vacuously and `Realizes` collapses to `G.Colorable k`, so `arityFloor G k = 0 ↔ ¬ G.Colorable k`
(`arityFloor_eq_zero_iff`). The base-satisfiability guard that every instrument in `tools/` carries
by hand is, here, the number `0` — and `two_le_arityFloor` falls out of the same observation.

**The floor is at most `k`, with no hypotheses at all** (`arityFloor_le_of_degree`). A vertex with
`k` distinct neighbours makes the rainbow pattern on them unrealizable, because a realizing
colouring would use all `k` colours on the neighbourhood and leave the vertex none. So on any object
having any vertex of degree at least `k` — which is every object here — the interesting question is
never *whether* a compulsion exists but
*how far below `k`* it starts — which is what the measurement campaign of `plans/M45-arity-floor.md`
exists to pin down.

## Nothing here is tagged `@[simp]`

`Realizes` is the abstraction; both bridges (`realizes_iff_extends`, `realizes_iff_exists`) rewrite
it *toward* an implementation. That is right for `decide` and wrong for reading, and a simp set is a
destination — this one would drive every goal away from the vocabulary the file exists to name. Cite
the bridges by name, exactly as `Sat/Encoding.lean` does when it deliberately ships no
`DecidableRel (edgeGraph n E).Adj` instance.

The mathematics is elementary and no novelty is claimed for any single step; what is new is the
name, and the fact that it makes a four-campaign negative into a measurable number.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V : Type*} {G : SimpleGraph V} {k m : ℕ} {S : Fin m → V} {p : Fin m → Fin k}

/-! ## The definitions -/

/-- **`m` distinct vertices, properly coloured among themselves.** The local data whose
extendability is the whole question. Both conjuncts are load-bearing: drop the first and a repeated
vertex manufactures a compulsion, drop the second and an edge does. -/
def PartialColoring (G : SimpleGraph V) {m k : ℕ} (S : Fin m → V) (p : Fin m → Fin k) : Prop :=
  Function.Injective S ∧ ∀ i j, p i = p j → ¬ G.Adj (S i) (S j)

/-- **`p` is the pattern some proper `k`-colouring wears on `S`.** Palette-free by construction —
only which positions agree is observed, never which colours they take — which is what makes the
notion invariant under renaming (`Realizes.congr`) and what makes the search instrument's
symmetry breaking sound. -/
def Realizes (G : SimpleGraph V) (k : ℕ) {m : ℕ} (S : Fin m → V) (p : Fin m → Fin k) : Prop :=
  ∃ C : G.Coloring (Fin k), SamePattern (fun i => C (S i)) p

/-- **A partial colouring that does not extend.** -/
def Compels (G : SimpleGraph V) (k : ℕ) {m : ℕ} (S : Fin m → V) (p : Fin m → Fin k) : Prop :=
  PartialColoring G S p ∧ ¬ Realizes G k S p

/-- **How many vertices you must look at before local properness stops implying global
extendability.** `⊤` when nothing is ever compelled.

`ℕ∞` rather than `ℕ`, mirroring `SimpleGraph.chromaticNumber`, because `Nat.sInf ∅ = 0` would
collide with a genuine `m = 0` — and `m = 0` is genuine: it is exactly non-colourability
(`arityFloor_eq_zero_iff`). -/
noncomputable def arityFloor (G : SimpleGraph V) (k : ℕ) : ℕ∞ :=
  ⨅ m ∈ {m : ℕ | ∃ (S : Fin m → V) (p : Fin m → Fin k), Compels G k S p}, (m : ℕ∞)

/-! ## The reasoning surface -/

/-- `SamePattern` on two positions has content only at the one index pair. The workhorse behind
every arity-`2` statement below, kept here rather than added to `Pattern.lean`, which sits upstream
of five certificate modules where a new declaration would cost a full rebuild. -/
theorem samePattern_two {a b : Fin 2 → Fin k} :
    SamePattern a b ↔ (a 0 = a 1 ↔ b 0 = b 1) := by
  constructor
  · intro h; exact h 0 1
  · intro h i j
    fin_cases i <;> fin_cases j <;> simp_all [eq_comm]

/-- A realizing colouring witnesses local properness — so `Compels` picks out exactly the gap
between "locally consistent" and "globally realizable". -/
theorem Realizes.partialColoring (hS : Function.Injective S) (h : Realizes G k S p) :
    PartialColoring G S p := by
  obtain ⟨C, hC⟩ := h
  refine ⟨hS, fun i j hij hadj => ?_⟩
  exact C.valid hadj ((hC i j).mpr hij)

/-- **A pattern is really a partition.** Renaming the pattern's colours changes nothing, which is
what makes `Pattern.canonPatterns` a *complete* enumeration for a search over patterns. -/
theorem Realizes.congr {p' : Fin m → Fin k} (h : SamePattern p p') :
    Realizes G k S p ↔ Realizes G k S p' :=
  ⟨fun ⟨C, hC⟩ => ⟨C, fun i j => (hC i j).trans (h i j)⟩,
   fun ⟨C, hC⟩ => ⟨C, fun i j => (hC i j).trans (h i j).symm⟩⟩

/-- **The palette-free question and the naive one are the same question.**

`Realizes` asks whether *some* colouring induces the partition `p`; this says that is equivalent to
some colouring taking exactly the values `p`. The content is that a global palette permutation is
free, and the consequence is practical: a search instrument may pin the pattern colour-freely (which
admits symmetry breaking, worth a measured factor of >8,000 at six colours) or pin the colours
literally, and the two are then provably the same query rather than two encodings hoped to agree. -/
theorem realizes_iff_extends :
    Realizes G k S p ↔ ∃ C : G.Coloring (Fin k), ∀ i, C (S i) = p i := by
  classical
  refine ⟨fun ⟨C, hC⟩ => ?_, fun ⟨C, hC⟩ => ⟨C, fun i j => by simp [hC]⟩⟩
  -- the two images are equinumerous by `SamePattern`; transport that to a permutation of `Fin k`
  let P : Fin k → Prop := fun c => ∃ i, (C (S i) : Fin k) = c
  let Q : Fin k → Prop := fun c => ∃ i, p i = c
  let g : {c // P c} → {c // Q c} := fun c => ⟨p c.2.choose, c.2.choose, rfl⟩
  have hinj : Function.Injective g := by
    rintro ⟨c₁, h₁⟩ ⟨c₂, h₂⟩ he
    have hpe : p h₁.choose = p h₂.choose := congrArg Subtype.val he
    have hce : (C (S h₁.choose) : Fin k) = C (S h₂.choose) := (hC _ _).mpr hpe
    apply Subtype.ext
    show c₁ = c₂
    rw [← h₁.choose_spec, ← h₂.choose_spec]
    exact hce
  have hsurj : Function.Surjective g := by
    rintro ⟨d, i, hi⟩
    have hmem : P (C (S i)) := ⟨i, rfl⟩
    refine ⟨⟨C (S i), hmem⟩, Subtype.ext ?_⟩
    show p hmem.choose = d
    rw [← hi]
    exact (hC hmem.choose i).mp hmem.choose_spec
  let e : {c // P c} ≃ {c // Q c} := Equiv.ofBijective g ⟨hinj, hsurj⟩
  refine ⟨Coloring.mk (fun v => e.extendSubtype (C v)) fun {u v} hadj heq =>
      C.valid hadj (e.extendSubtype.injective heq), fun i => ?_⟩
  have hmem : P (C (S i)) := ⟨i, rfl⟩
  show e.extendSubtype (C (S i)) = p i
  rw [Equiv.extendSubtype_apply_of_mem e _ hmem]
  show p hmem.choose = p i
  exact (hC hmem.choose i).mp hmem.choose_spec

/-- The bridge to a decidable statement over an explicit edge list: colourings become functions, so
`decide +kernel` can close a concrete instance. Deliberately not `@[simp]` — see the module
docstring. -/
theorem realizes_iff_exists {n : ℕ} {H : SimpleGraph (Fin n)} {S : Fin m → Fin n}
    {p : Fin m → Fin k} :
    Realizes H k S p ↔ ∃ f : Fin n → Fin k, (∀ i j, H.Adj i j → f i ≠ f j) ∧ ∀ i, f (S i) = p i := by
  rw [realizes_iff_extends]
  exact ⟨fun ⟨C, hC⟩ => ⟨C, fun _ _ h => C.valid h, hC⟩,
         fun ⟨f, hf, hC⟩ => ⟨Coloring.mk f fun {i j} h => hf i j h, hC⟩⟩

/-! ## Arity two is exactly `Separated` and `Forces` -/

/-- **The "same colour" pattern on a pair is compelled against exactly when the pair is a virtual
edge**: non-adjacent, yet separated by every proper colouring. -/
theorem compels_two_eq {S : Fin 2 → V} {p : Fin 2 → Fin k} (hS : Function.Injective S)
    (hp : p 0 = p 1) :
    Compels G k S p ↔ ¬ G.Adj (S 0) (S 1) ∧ Separated G k (S 0) (S 1) := by
  constructor
  · rintro ⟨⟨-, hadm⟩, hnr⟩
    refine ⟨hadm 0 1 hp, fun C hCeq => hnr ⟨C, samePattern_two.mpr ⟨fun _ => hp, fun _ => hCeq⟩⟩⟩
  · rintro ⟨hne, hsep⟩
    refine ⟨⟨hS, fun i j hij hadj => ?_⟩, fun ⟨C, hC⟩ => hsep C (samePattern_two.mp hC |>.mpr hp)⟩
    fin_cases i <;> fin_cases j <;> simp_all [G.adj_comm]

/-- **The "different colours" pattern on a pair is compelled against exactly when the pair is
forced**: every proper colouring paints the two alike. No adjacency condition appears, because the
local-properness clause is vacuous once the two positions sit in different blocks. -/
theorem compels_two_ne {S : Fin 2 → V} {p : Fin 2 → Fin k} (hS : Function.Injective S)
    (hp : p 0 ≠ p 1) :
    Compels G k S p ↔ Forces G k (S 0) (S 1) := by
  constructor
  · rintro ⟨-, hnr⟩ C
    by_contra hne
    exact hnr ⟨C, samePattern_two.mpr ⟨fun h => absurd h hne, fun h => absurd h hp⟩⟩
  · intro hf
    refine ⟨⟨hS, fun i j hij hadj => ?_⟩, fun ⟨C, hC⟩ => hp (samePattern_two.mp hC |>.mp (hf C))⟩
    fin_cases i <;> fin_cases j <;> simp_all [G.adj_comm]

/-- A virtual edge, in the new vocabulary. Dot notation because this is the direction a caller
travels: the repository's certificates *produce* `Separated`, and what one then wants is the arity
statement. -/
theorem Separated.compels {S : Fin 2 → V} (hS : Function.Injective S)
    (hne : ¬ G.Adj (S 0) (S 1)) (h : Separated G k (S 0) (S 1)) (c : Fin k) :
    Compels G k S (Function.const _ c) :=
  (compels_two_eq hS rfl).mpr ⟨hne, h⟩

/-- A forced pair, in the new vocabulary. -/
theorem Forces.compels {S : Fin 2 → V} (hS : Function.Injective S)
    (h : Forces G k (S 0) (S 1)) {c d : Fin k} (hcd : c ≠ d) :
    Compels G k S ![c, d] :=
  (compels_two_ne hS (by simpa using hcd)).mpr h

/-! ## The floor -/

/-- A compulsion is an upper bound on the floor. -/
theorem arityFloor_le_of_compels (h : Compels G k S p) : arityFloor G k ≤ (m : ℕ∞) :=
  iInf_le_of_le m (iInf_le_of_le ⟨S, p, h⟩ le_rfl)

/-- The lower-bound form, mirroring `SimpleGraph.le_chromaticNumber_iff_colorable` so the name is
predictable. This is what an "arity `n` and below is flat" measurement instantiates. -/
theorem le_arityFloor_iff {n : ℕ∞} :
    n ≤ arityFloor G k ↔
      ∀ m, (∃ (S : Fin m → V) (p : Fin m → Fin k), Compels G k S p) → n ≤ (m : ℕ∞) := by
  simp [arityFloor]

/-- **The vacuity guard, as a value.** A graph with no proper `k`-colouring makes every pattern
unrealizable, so "everything is compelled" — and the floor reports it as `0` rather than letting a
caller mistake it for structure. -/
theorem arityFloor_eq_zero_iff : arityFloor G k = 0 ↔ ¬ G.Colorable k := by
  constructor
  · intro h hcol
    have h1 : (1 : ℕ∞) ≤ arityFloor G k := by
      refine le_arityFloor_iff.mpr fun n ⟨T, q, hc⟩ => ?_
      rcases Nat.eq_zero_or_pos n with rfl | hn
      · exact absurd ⟨hcol.some, fun i => i.elim0⟩ hc.2
      · exact_mod_cast hn
    rw [h] at h1
    exact absurd h1 (by simp)
  · intro hnc
    refine le_antisymm ?_ (by simp)
    have hc : Compels G k (fun i : Fin 0 => i.elim0) (fun i : Fin 0 => i.elim0) := by
      refine ⟨⟨fun a => a.elim0, fun i => i.elim0⟩, fun h => hnc ⟨h.choose⟩⟩
    simpa using arityFloor_le_of_compels hc

/-- Below the floor there is nothing to see: a colourable graph has no compulsion on zero or one
vertex, because `SamePattern` is vacuous there. -/
theorem two_le_arityFloor (h : G.Colorable k) : 2 ≤ arityFloor G k := by
  refine le_arityFloor_iff.mpr fun n ⟨T, q, hc⟩ => ?_
  by_contra hlt
  have hn : n < 2 := by exact_mod_cast not_le.mp hlt
  refine hc.2 ⟨h.some, fun i j => ?_⟩
  have hij : i = j := Fin.ext (by have := i.isLt; have := j.isLt; omega)
  subst hij
  simp

/-! ## The two bracket theorems -/

/-- **The fan bracket.** If every proper colouring puts all `k` colours on `S`, then any locally
proper pattern that does *not* use `k` blocks is compelled — so a fanned set of size `m` whose
induced subgraph is `(k−1)`-colourable pins `arityFloor ≤ m`.

This is `Coverage.fan_iff_coverage`'s right-hand side read one order up, and it is why the arity
floor is bounded by the size of a minimal fanned set rather than by the whole object. -/
theorem compels_of_fan (hfan : ∀ C : G.Coloring (Fin k), ∀ c : Fin k, ∃ i, C (S i) = c)
    (hpc : PartialColoring G S p) (hp : ¬ Function.Surjective p) : Compels G k S p := by
  refine ⟨hpc, fun h => hp fun c => ?_⟩
  obtain ⟨C, hC⟩ := realizes_iff_extends.mp h
  obtain ⟨i, hi⟩ := hfan C c
  exact ⟨i, by rw [← hC i, hi]⟩

/-- **The arity floor is at most `k`, with no hypotheses at all.**

`k` distinct neighbours of a vertex can never be rainbow: a colouring realizing that pattern makes
`i ↦ C (S i)` an injection of `Fin k` into itself, hence a surjection, so some neighbour already
wears the vertex's own colour.

The consequence for this repository is the reason the file exists. The hypothesis asks only that
*some* vertex have `k` distinct neighbours — not every vertex, and not a bound on the minimum
degree. De Grey's 1581-vertex witness has minimum degree `4` against `k = 5`, which is irrelevant;
what matters is that its two spindle centres have degree `60`. So a compulsion of arity `≤ k` is
*guaranteed* on it, and four campaigns of pair meters reading zero measured an arity, not an
absence. -/
theorem compels_rainbow_of_neighbors {v : V} (T : Fin k → V) (hN : ∀ i, G.Adj v (T i))
    (hinj : Function.Injective T) : Compels G k T id := by
  refine ⟨⟨hinj, fun i j hij hadj => ?_⟩, fun ⟨C, hC⟩ => ?_⟩
  · rw [show i = j from hij] at hadj; exact G.irrefl hadj
  · have hcinj : Function.Injective fun i => C (T i) := fun i j h => (hC i j).mp h
    obtain ⟨i, hi⟩ := (Finite.injective_iff_surjective.mp hcinj) (C v)
    exact C.valid (hN i) hi.symm

/-- The floor form of the previous theorem. -/
theorem arityFloor_le_of_degree {v : V} (T : Fin k → V) (hN : ∀ i, G.Adj v (T i))
    (hinj : Function.Injective T) : arityFloor G k ≤ (k : ℕ∞) :=
  arityFloor_le_of_compels (compels_rainbow_of_neighbors T hN hinj)

/-! ## How a compulsion travels between graphs

`Compels` is a conjunction whose two clauses move in *opposite* directions along *different* amounts
of structure, and separating them is the point of this section rather than an accident of it.
`Realizes` is reflected by any homomorphism — pull the colouring back and nothing else is needed.
`PartialColoring` is preserved only by an embedding, which is where injectivity and adjacency
*reflection* are spent. So the conjunction needs `↪g`, and both halves of `↪g` are consumed. -/

section Transport

variable {W : Type*} {G' : SimpleGraph W}

/-- **Realizability is reflected by any homomorphism**: a colouring of the larger graph pulls back
along `f` to one of the smaller wearing the same pattern.

This is the direction a *ladder* measurement travels. Asking a pattern on a bigger object is the
stronger question, so a "still realizable" answer upstairs implies the same answer downstairs, and a
sweep higher on a closure ladder subsumes one below it. No injectivity and no adjacency reflection
are needed — a bare `→g` suffices, which is why this is stated apart from `Compels.map`. -/
theorem Realizes.comap (f : G →g G') (h : Realizes G' k (f ∘ S) p) : Realizes G k S p :=
  ⟨h.choose.comap f, h.choose_spec⟩

/-- **Local properness is preserved by an embedding.** Injectivity keeps `f ∘ S` distinct;
adjacency *reflection* (`Embedding.map_adj_iff`) is what carries a non-edge upward. A bare
homomorphism gives neither, and with only a homomorphism the statement is false. -/
theorem PartialColoring.map (f : G ↪g G') (h : PartialColoring G S p) :
    PartialColoring G' (f ∘ S) p :=
  ⟨(RelEmbedding.injective f).comp h.1,
   fun i j hij hadj => h.2 i j hij (f.map_adj_iff.mp hadj)⟩

/-- **A compulsion transports up an embedding**: more material around it, same compulsion. -/
theorem Compels.map (f : G ↪g G') (h : Compels G k S p) : Compels G' k (f ∘ S) p :=
  ⟨h.1.map f, fun hr => h.2 (hr.comap f.toHom)⟩

/-- **The ladder theorem: growing a graph can only *lower* its arity floor, never raise it.**

Read the direction off the statement carefully — the *bigger* graph `G'` is on the **left**. An
embedding `G ↪g G'` presents `G` as an induced subgraph of `G'`, and every compulsion of `G` is
still one in `G'`, so `G'` can only compel sooner. The intuitive companion is `Realizes.comap`,
which says the same thing from the other side: what is still realizable in the bigger graph was
realizable in the smaller.

This is what makes a closure-ladder measurement mean something. "The floor did not drop from the
witness to its closure" is then the statement that an inequality is *tight*, rather than two
unrelated numbers that happened to agree. -/
theorem arityFloor_le_of_embedding (f : G ↪g G') : arityFloor G' k ≤ arityFloor G k :=
  le_iInf₂ fun _ ⟨_, _, hc⟩ => arityFloor_le_of_compels (hc.map f)

/-- **A virtual edge speaks about every graph its gadget maps into** — the exact dual of
`Forcer.Forces.comap`, and the step Act Two of the six-colour programme travels: a finite gadget
that separates a pair separates that pair's image in any ambient graph it is drawn inside.

Housed here rather than beside `Separated` in `Fan.lean` for two reasons that agree. By content,
this file already collects the dot-notation lemmas by which `Separated` and `Forces` travel
(`Separated.compels`, `Forces.compels`). By cost, `Fan.lean` carries 45 transitive dependents,
including the certificate modules, and a new *declaration* there rebuilds every one of them. -/
theorem Separated.comap {u v : V} (h : Separated G k u v) {X : Type*} {H : SimpleGraph X}
    (φ : G →g H) (C : H.Coloring (Fin k)) : C (φ u) ≠ C (φ v) :=
  h (C.comap φ)

end Transport

end HadwigerNelson
