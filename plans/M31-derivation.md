# M31 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-22 by the FS-71 batch-1 implementer. Enumeration: `plans/M31-minimal-five-closure.md` read in full.
Grades are `CLAUDE.md` § Notation's.*

## The theorems

**T1 — The quadrature law. [hand; the M31 implementer; confirmed at 26 exact censuses]** For seam-field material in
`K = ℚ(√3,√11)` (rank 4 over ℚ: `1, √3, √11, √33`), let `R = s·W` be a unit rotation with `s` a "seam decoration"
(`|s| = 1`, both coordinates in `K`) and `W` a word in the new-field generators `√ρ₁₅ = (√15+i)/4`,
`√ρ₆₃ = (3√7+i)/8`. For a detuned-copy point `R·(anchor+u)` and a base point `anchor+v` (`u, v` seam-field offsets
from a common rotation centre), write `z = s·u·v̄`; the unit-cross-chord condition `|u|² + |v|² − 2·Re(W·z) = 1`
splits — because `K`, `√15·K`, `√7·K`, `√105·K` are ℚ-linearly-independent radical blocks — into one equation per
block: **(1)** if `W` is an even power of `ρ₁₅` ("full spindle"), `Im(z) = 0` (`u` and the `s̄`-twisted `v` are
collinear through the anchor) and the radii `t = |u|, r = |v|` lie on the conic `t² + r² − 2·Re(W)·(±t·r) = 1`;
**(2)** if `W` is an odd power of `√ρ₁₅` ("half spindle"), `Re(z) = 0` (perpendicular through the anchor) with conic
`t² + r² ± 2·Im(W)·t·r = 1`; **(3)** likewise with `√ρ₆₃`/`√7` in place of `√ρ₁₅`/`√15`; **(4)** if `W` carries
nontrivial content in BOTH families, all four blocks vanish, forcing `u·v̄ = 0` — no genuine cross chord exists at
all (other than through the anchor itself). *Proof:* `plans/M31-minimal-five-closure.md` §0a ("The quadrature law
(a-priori derivation, to be script-verified)") — the radical-block splitting argument, worked by hand before any
census ran. *Confirmed*, not merely asserted: zero law violations across 26 exact census variants (12 hexagram
unions at truncation depth B=1, 12 at B=2, 2 pair unions), including a channel (the `ℚ(√33)`-conjugate-ring coupling)
the derivation admits but the subplan had not anticipated — `plans/M31-minimal-five-closure.md` § "The quadrature
law and the mitotic censuses", P1–P3. *Proof verdict:* closes (elementary linear algebra over four independent
radical summands; every predicted conic/collinearity/perpendicularity was found exactly on the predicted locus at
every census point). *Rests on it:* the stacking law (M32-T1, the copy↔copy analogue of this same argument); row 27's
"the mitotic hexagram is 4-chromatic" and "the 1581's gen-1 closure is 5-colourable" findings; G12; the kernel
instance `quadrature_rho15` (`Quadrature.lean`, row 28, M32), which formalises only the `W = ρ₁₅` even-word case.
*Prior art:* ours — the construction (rotated copies of a project-specific lattice in a project-specific
multiquadratic tower) has no literature analogue found; the mechanism (linear independence of nested quadratic
radicals) is textbook Galois theory, not itself a citable result. zbMATH: `ti:"unit distance graph" & ab:"rotation"`
(0 hits), `ab:"unit distance" & ab:"quadratic form" & ab:"independence"` (0 hits). Nearest held key: none on point.
*Kernel:* partial — the even-word instance at `W = ρ₁₅` is **kernel** (`quadrature_rho15`, `Quadrature.lean`, M32);
the general law across all words (odd words, `ρ₆₃` words, mixed words) was explicitly deferred to instruments-only
status at M31 ("Kernel certification of the ρ₁₅ instance is DEFERRED to M32 ... M31 stays instruments-only") and
never generalised past that one instance in any later milestone found in this audit — **stub-worthy** alongside
FS-45's chain-theorem kernel work, but not separately registered.

## Readings and measurements that were called theorems

- P4–P10 (the witness-closure growth measurements: gen-1 closure size, ring count, the frontier curve, the
  irreducibly-global finding) are [tools] measurements already correctly captured by row 26–30 and G10; not theorems.

## Conjectures surfaced, not claimed

(none)

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T1 | partial: the `W = ρ₁₅` even-word instance is kernel (`quadrature_rho15`); the general law is stub-worthy, not filed |
