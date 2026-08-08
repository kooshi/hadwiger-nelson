# M22 — Partner closure and the shape of the pressure (stub)

*Stubbed at M21's close (2026-08-08). M21 measured the first nonzero extension pressure
this project has ever seen (52% of pattern pairs killed locally, 32% of the survivors
killed ambiently at the strongest-coupled pivot pair, every kill verified through an
independent encoding) and proved the pair's fork-independent geometry in Lean
(`Coupled.lean`: the reflection package, the interlock, the four gluing
classifications, the superset lower bound). The χ of the d = 1 pair system is carried
open in both directions, each with a reopening gate (M21 subplan §2.4). This stub
collects the carry-forward, ranked.*

## Candidate threads, ranked at M21 close

1. **The partner-closed sample** — the named enrichment that forces the χ fork: adjoin
   cross-chord partners to the pair lattice, one √-extension per generation (partners
   generically leave ℚ(√3,√11); the growth of the coordinate field is the honest cost
   meter). Gate it reopens: UNSAT at k = 4 on a partner-closed sample would be a
   two-point continuum χ ≥ 5 candidate — re-verify, shrink, kernel route immediately.
   SAT at every affordable closure depth keeps the two-pivot cap conjecture alive on
   measured ground. The promoted instrument's `--pair` builder is the seed; the
   partner-adjunction move is new code.
2. **The kill-structure census** — WHICH pattern pairs die (the shape of the 229
   ambient kills + 785 local kills at (695,2044)): by cross-chord incidence profile, by
   π_a/π_b class shapes, by whether the killing core is the compulsion triangle. The
   verified kills are already in `Fan.of_unsat` pin-cube form; naming their structure
   is the cheapest route to a *mechanism* — and a mechanism is what a gadget design
   needs (M20's battery said closure-flavoured gadgets clamp too narrowly).
3. **Kernel certification of the kills** — if any claim comes to rest on the kill set,
   each is one LRAT certificate away from the kernel (the profile IS the cube split).
   Deferred until a claim needs it; the instrument records exact pins per kill.
4. **Non-sector construction search** — the ≤ 4 branch's gate: the mesh scan killed
   every sector pair, so a χ ≤ 4 proof for the pair needs a colouring shape nobody has
   named. The strip's window-extension freedom (M20) is the one known source of
   non-sector colourings; the probe's k = 4 model corpus is the evidence base to mine.
5. **General-radius two-circle theorem** — unchanged from the Frontier's parked list;
   M21's cross-chord classification did not force it (the d = 1 gluings needed only the
   strip operators). Trigger stays: a milestone that needs an off-{1, 1/√3} class.

## Horizon beyond M22: the pivot triangle (Kooshi, 2026-08-08)

Three pivots pairwise at distance 1 — a unit triangle of systems. Not an M22 thread
(M22's kill mechanism and near-relation spectrum should aim it first), but the named
successor candidate, because it adds exactly what the pair lacks: (a) *cyclic*
constraint flow A→B→C→A; (b) placed at 0, 1, ζ₆ the three coupling directions are
1, ζ₆, ζ₃ — hex-commensurate, so exact closed loops exist that the pair's
incommensurability forbade; (c) the circumcentre sits at distance 1/√3 from all three
pivots — ON all three inner circles, the first triple glue point, and by M18's identity
the pivots are a rainbow unit triangle in its 1/3-class — a self-seeding fourth system;
(d) the configuration's symmetry is dihedral (rot3 about the centroid + reflections),
the triangle's `reflAcross`. `Coupled.lean` transfers wholesale: the gluing
classification instantiates on each side, and the superset-quantified lower bound
already proves χ ≥ 4 for the triangle system with zero new Lean.

Sharpened (Kooshi + de Bruijn, 2026-08-08): the full object is an **8-circle,
4-centre system** — the triangle's six circles plus the centroid-metapivot's two, both
of which already thread named points: its inner circle passes through the three pivots
(M18 identity), its outer circle through the six 120°-partners `rot3^±1 · c` about
each pivot (the 120° chord of a 1/√3-circle is exactly 1). The pivot/metapivot
relation is a duality — the metapivot of {c, rot3 p c, rot3² p c} is p itself — so
the cascade is closed along same-circle triangles and generates new pivots only
through cross-system unit triangles. The metapivot couples at axis 1/√3, which FIRES
the general-radius classification trigger (Frontier path 4): `re_of_norms` /
`im_sq_of_norm` are already radius-general; only `unit_frame` and the reflection
package assume a unit axis. The centroid is the hunt's first simultaneous
centre-and-point: one vertex on three inner circles, unit-adjacent to its six
120°-partners, and the centre of its own 4-chromatic system.

Recursive (Kooshi, 2026-08-08): three 8-circle systems on a unit metapivot triangle +
the new centroid = 26 circles generically (8·3 + 2), but the six metapivot circles +
the new two form ANOTHER 8-circle system — a three-layer role-overlapping incidence
structure (9 + 3 + 1 centres), duality running through every rung. Each pivot triangle
carries a free rotational phase about its metapivot: the recursion is a 3-moduli
family, and tuning a phase until a cross-copy pair lands exactly unit apart is the
spindle move (`construct.spindle`, field criterion in `field.py`) — a structured
witness factory, same two radii at every level (unit-distance rigidity densifies,
never shrinks).

## What M21 hands over

* `Proofs/HadwigerNelson/Coupled.lean` — the pair's certified geometry: `reflAcross`
  (the one symmetry), the interlock, the four two-point gluing classifications, and
  `four_le_chromaticNumber_of_system_subset` (the superset-quantified lower bound; the
  pairSystem corollary is premise-free).
* `tools/couple.py` — the promoted suite (census / phase / joint+verifier / pair /
  mesh / floor / self-test), wired FAIL-loud into `scripts/regen-check.sh`. The joint
  verifier runs inside `--joint`, never separately. Honesty notes in the docstring
  bound what the sampled instruments claim.
* `build/m21-*.json` — the §0 triage artifacts (untrusted; census and phase reproduce
  deterministically; the pair lattice reproduces up to a documented +20-point constant
  seed difference from its session-mortal ancestor).
* The negative knowledge, kernel-checked where it could be: no coupled-automaton
  quotient (incommensurability, exact); no sector mesh at d = 1 (tools-side, full
  sweep); no floor raise from coupling (forbid-last-t, both pairs).
