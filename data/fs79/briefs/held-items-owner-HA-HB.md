# FS-79: the owner's two held items (for the advisor only)

*Written by the product owner on 2026-09-23, the day FS-79 was minted, in conversation with Kooshi.*

**Handling (FS-73's ruling R1, unchanged):**
- The advisor offers both items to both competitors identically, at the same moment, and only after each has written its own
  first route.
- They are the owner's guesses, not results, and the least-tested ideas in the milestone. Say so when offering them.
- They live outside the repository on purpose: competitors read the repository, and the design's value is two independent
  openings.

## H-A: the dimension shift, a four-colour "flux"

- **The three-colour mechanism** (G71): three colours form a triangle, which is a loop. A colouring unwinds along the loop's
  cover (a line) to an integer height. Its winding on relation cycles is an integer; averaged, it is a slope with ±1 bounds.
  Emptiness of the slope polytope refuses the colouring.
- **At four colours:** the colours' clique complex is the surface of a tetrahedron, a 2-sphere. Loops give only ℤ/2, which is
  Coxeter's no-go (K₄'s square complex is ℝP²). But the sphere has its own integer: **the degree** with which a closed *surface*
  wraps it.
- **So the candidate invariant lives one dimension up.**
  - On a lattice, two commuting relation cycles span a torus in the square complex of the grid that covers the Cayley graph.
  - A four-colouring maps that torus to the sphere, so it has a degree, bilinear and antisymmetric in the pair of relations.
  - Averaging over translations would give a real 2-form, a "flux", with local bounds from the per-square contributions.
  - If no flux satisfies them, the lattice is not four-colourable.
- **The known snag.** A square coloured with all four colours bounds two different discs on the sphere (triangles abc + acd, or
  abd + bcd), and they differ by the whole sphere. So the degree needs a filling convention, and a convention creates point
  "charges": 3-cubes whose boundary has non-zero degree. What survives is a flux with sources, a conservation law with charges.
- **Disciplines that own this shape:**
  - statistical mechanics: Coulomb phases, emergent gauge fields, height and flux mappings of constrained configurations
    (Baxter; Moore–Newman on four-colourings of the triangular lattice);
  - algebraic topology: Lovász's topological method, box complexes, Hom complexes.
- **First cheap test:** a small graph known to need five colours (a five-chromatic distance graph on ℤ, or a circulant). Does
  the flux obstruction see it?
- **Killing test:** the flux is forced to zero for every four-colouring of every abelian Cayley graph, which would make it
  vacuous.
- **Beyond:** at five colours the complex is a 3-sphere, so the same shift one dimension further up is the shape of a
  six-colour certificate.

## H-B: change the target, keep the dimension

- **The three-colour win** came from the target (a triangle) having an infinite cover.
- **ℚ(√167)'s unit-distance graphs have no triangles** (no √3; G57). For triangle-free graphs, four-colourability can be
  equivalent to mapping into some other triangle-free target.
  - Example of the phenomenon, cited from memory and **unchecked**: every triangle-free planar graph maps to the 16-vertex
    Clebsch graph (Naserasr, JCTB 2007).
- If our class (triangle-free four-colourable Cayley graphs of ℤ^r, or the ℚ(√167) lattices) has a universal target whose
  loops or spheres do unwind, heights come back at four colours.
- **Discipline:** homomorphism duality and universal targets (Nešetřil–Tardif; Häggkvist–Hell).
- **First cheap test:** a literature check. Is there a finite universal triangle-free target for triangle-free four-colourable
  graphs of bounded or Cayley type?
- **Killing test:** a proof that no finite universal target exists for the class.

## Owner's check of H-B's citation (2026-09-23, zbMATH Open API; inventory item 7)

- **Existence:** R. Naserasr, *Homomorphisms and edge-colourings of planar graphs*, J. Combin. Theory Ser. B 97 (2007) 394–400,
  Zbl 1116.05032. Read: the zbMATH **review** only. The review states Naserasr's conjecture (planar graphs of odd girth 2k+1 map to
  the Cayley graph C(ℤ₂^{2k+1}, S_{2k+1}), S = vectors with two cyclically consecutive 1s) and its equivalence with Seymour's
  edge-colouring conjecture for planar (2k+1)-graphs. The Clebsch case (k = 2: C(ℤ₂⁵, S₅) is the Clebsch graph, and odd girth ≥ 5
  means triangle-free) is the one the literature cites as proved there; the review does not state it in words.
- **Minimality:** R. Naserasr (and coauthors per the paper; zbMATH lists one author), *Mapping planar graphs into projective cubes*,
  J. Graph Theory 74 (2013) 249–259, Zbl 1276.05035. Read: the **author's summary** only (a claim, not a reading): "the Clebsch graph
  … is the smallest triangle-free graph to which every triangle-free planar graph admits a homomorphism".
- **Verdict:** the citation is right in substance (existence 2007, minimality 2013). **Caveat for H-B:** both theorems are about
  PLANAR graphs; our lattice graphs are not planar, so this is an instance of the phenomenon (a triangle-free universal target for a
  triangle-free class), not a tool. Note also that the target is itself a Cayley graph of an elementary abelian 2-group (a projective
  cube), which bears on "does the target's topology unwind".
- Bibliography entries for both go in when the held items are released (after the competition), not before: adding them now would
  put H-B's content in the repository.
