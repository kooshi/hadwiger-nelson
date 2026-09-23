# FS-73 P3b — ℚ(√167)'s last surviving lattice `L21cc6506`: is its rotation set Θ empty?

Implementer E (de Bruijn), 2026-09-23. Brief: the product owner's `fs73-implE/BRIEF.md` (scratchpad). One bounded item.

**The question.** `L21cc6506` is the lattice `{(a,b,c,e) ∈ ℤ⁴ : c ≡ b, e ≡ a (mod 2)}` read as points
`((a+b√167)/420, (c+e√167)/420)` of ℚ(√167)² (FS-61 key `420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`), with its 60 unit vectors `U`.
By H-i / dB-T0 (`plans/FS73-C3-Coxeter.md` §3, `plans/FS73-C3-deBruijn.md` §2 C1), its unit-distance graph is 3-colourable iff
`Θ = {θ ∈ Hom(span U, ℝ) : θ(u) mod 1 ∈ [1/3, 2/3] for every u ∈ U}` is nonempty. Empty Θ ⟹ χ(ℚ(√167)²) ≥ 4.

## 1. Prediction (registered before any computation on this lattice)

**Predicted: Θ nonempty (the lattice is 3-colourable), confidence 60 %.**

- *For nonempty.* 55 of FS-61's 57 lattices at 167 have periodic 3-colourings (P2b), and the other survivor `Ld14c588b`
  survived the finite screens only because its colourings have period index 1,080, beyond the screens' `N`. The likeliest
  reason a lattice survives those screens is a long period, not emptiness. G61(4): refusal tracks unit-vector supply —
  108 refuses at d = 11, 20–36 colour at 167 — and 60 is between.
- *For empty.* Coxeter's first-cell search found `Ld14c588b`'s cell in about 60 s; on this lattice it walked 528,876 nodes
  in 880 s with no cell. A depth-first first-cell search that runs long without a leaf is weak evidence that cells are rare
  or absent. That is why the confidence is only 60 %.
- *Both outcomes are reachable by the method* (§3): an exact branch-and-bound over the torus `ℝ⁴/ℤ⁴` is a finite tree (every
  node's range for the next unit vector is bounded, and its depth is `|U|/2`); it ends either with a leaf — a nonempty cell, from
  which a vertex gives an exact rational θ — or with every branch closed by an exact Farkas vector, which is an emptiness
  certificate. **The uninformative outcome is "undecided at the cap"**, and it is reachable too: it is where Coxeter stopped.

