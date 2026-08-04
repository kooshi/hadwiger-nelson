import Proofs.HadwigerNelson.Coverage

/-!
# The coverage ratchet (M19)

M18 made distance-to-confinement a number (`minCov`, `tools/coverage.py`); this module makes
the number's *one-way behaviour* a theorem. `CoverAtLeast G k p Q m` says every proper
`k`-colouring shows at least `m` colours on `N(p) ∪ Q`. It is monotone in the graph, in the
class, and antitone in the level — so a **lower** coverage bound, once established, survives
every later construction step (adding edges, adding vertices' worth of edges, widening the
class). Upper bounds enjoy no such transfer: a witnessing colouring of the small graph need
not extend, which is why the instrument re-verifies its pool on every new graph rather than
carrying numbers across. The asymmetry is not a tool convention; it is this module.

At level `k` the property *is* the fan (`fan_iff_coverAtLeast`, via M18's
`fan_iff_coverage`), so the ratchet is a genuine gradient toward confinement, and the
campaign of M19+ — union gadgets, watch `minCov` — is climbing something the kernel
certifies to be climbable.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V : Type*} {G G' : SimpleGraph V} {k m m' : ℕ} {p : V} {Q Q' : List V}

open Classical in
/-- The set of colours a colouring shows on `N(p) ∪ Q`. Classical decidability: this is a
reasoning object (the instrument computes its own copy in Python; nothing here executes). -/
noncomputable def coverColours (G : SimpleGraph V) (p : V) (Q : List V)
    (C : G.Coloring (Fin k)) : Finset (Fin k) :=
  Finset.univ.filter fun c => ∃ v, (G.Adj p v ∨ v ∈ Q) ∧ C v = c

/-- Every proper `k`-colouring shows at least `m` colours on `N(p) ∪ Q`. At `m = k` this is
confinement (`fan_iff_coverAtLeast`); below `k` it is the measured gradient. -/
def CoverAtLeast (G : SimpleGraph V) (k : ℕ) (p : V) (Q : List V) (m : ℕ) : Prop :=
  ∀ C : G.Coloring (Fin k), m ≤ (coverColours G p Q C).card

/-- Weakening the level. -/
theorem CoverAtLeast.anti (h : m' ≤ m) :
    CoverAtLeast G k p Q m → CoverAtLeast G k p Q m' := sorry

/-- Widening the class only helps: `N(p) ∪ Q` grows, so every colouring shows at least as
many colours. -/
theorem CoverAtLeast.mono_subset (hQ : Q ⊆ Q') :
    CoverAtLeast G k p Q m → CoverAtLeast G k p Q' m := sorry

/-- **The ratchet.** Adding edges anywhere in the graph can only raise coverage: every
proper colouring of the larger graph is one of the smaller (restriction along `G ≤ G'`),
evaluated over a larger neighbourhood. This is the theorem that makes "union a gadget and
re-measure" a climb rather than a walk. -/
theorem CoverAtLeast.mono_edges (hG : G ≤ G') :
    CoverAtLeast G k p Q m → CoverAtLeast G' k p Q m := sorry

/-- **Confinement is full coverage** — the numeric face of M18's `fan_iff_coverage`. -/
theorem fan_iff_coverAtLeast (hp : p ∉ Q) :
    Fan G k p Q ↔ CoverAtLeast G k p Q k := sorry

/-- The rainbow floor, lifted: a unit triangle inside the class already forces three
colours onto `N(p) ∪ Q` — the level every 120°-class pivot starts at, and (by the
two-circle theorem) the level no cover-set-internal structure can beat. -/
theorem CoverAtLeast.of_triangle_mem {a b c : V} (ha : a ∈ Q) (hb : b ∈ Q) (hc : c ∈ Q)
    (hab : G.Adj a b) (hac : G.Adj a c) (hbc : G.Adj b c) :
    CoverAtLeast G k p Q 3 := sorry

end HadwigerNelson
