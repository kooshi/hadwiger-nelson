# M63 phase G — the derivation file: theorems from the bases-and-rotations plan (FS-71 batch 4b)

*Filed 2026-09-23 by the batch-4b implementer (FS-71, the theorem audit). Home for theorems proved in `plans/
M63-phaseG-bases-and-rotations.md`, the source of `CLAUDE.md` G52's "necessary half" and G46's
"read the construction's own data layout" instance. No ledger row of M63's own covers phase G (rows 64–65 are
phases H2/H3). `T4` and `T5` below are the theorem behind G52; the "even-`t` automatic defeat" and
"`|p|² = n` free iff `n = k²·m`" clauses of G52, and G53's counting compulsion, are phase H2 material and are
out of this batch's scope (batch 4c). Ids `M63G-T1`…*

## The theorems

**M63G-T1 — Every rotation with `cos θ ∈ K` carrying a cross edge is realised by a collinear pair, and this is a complete enumeration over the base's lines. [hand; the phase-G implementer, 2026-09-11]** Identify the
plane with `K(i)`, `K = ℚ(√3,√11)`. For `u, v ∈ K²` and a rotation `ρ = c + is` of modulus 1 with `c ∈ K`,
`s ∉ K`: `|u − ρv|² = 1 ⟺ Re(ρ·conj(u)v) = k`, `k = (|u|² + |v|² − 1)/2 ∈ K`; writing `conj(u)v = p + iq`
with `p, q ∈ K`, the identity splits over the `K`-basis `{1, s}` into `q = 0` (collinearity with the centre)
and `c·p = k`. **Therefore the rotations with `cos θ ∈ K` carrying any cross edge on a given base are exactly
`cos θ = k/p` over collinear pairs `(u, v)`, `p = Re(conj(u)v) = ±√(|u|²|v|²)`, `k = (|u|² + |v|² − 1)/2`** —
an enumeration over the base's **lines** (`O(Σ_lines n_L²)`), not over point pairs, in exact `K`-arithmetic
with no squareness test and no float in any verdict. *Proof:* `plans/M63-phaseG-bases-and-rotations.md` §1.1.
**Calibration, exact:** on `[Parts2020a]`'s lattice the diagonal family at `|u|² = 4` returns `cos = 7/8`
(`ρ₁₅`), and his auxiliary family (product `(8/3)²`) returns the same angle — his two "kinds" are two
collinear families at one angle, and the derivation recovers both from one formula; the diagonal sub-case
`v = u` gives `cos = 1 − 1/(2|u|²)`, `[Polymath16wikiMain]`'s `ω_t` (attributed, §PA2 of the same file, G7).
**Independently re-derived**, from the radius spectrum rather than the line structure, by the advisor Poros
(§11.1 of the same file) — the two agree digit for digit on every shared quantity, including the
decomposition of `ρ₁₅`'s 126 committed cross edges — and checked a third way by a 1,706,239-ordered-pair
exact float-propose/exact-dispose sweep for the two wall-breaking classes reached (§12.3). *Proof verdict:*
closes. *Rests on it:* the whole filter cascade of §2 (filters 1–3 are theorems built on this enumeration);
`M63G-T4`, `M63G-T5`. *Prior art:* the diagonal sub-case is `[Polymath16wikiMain]`'s `ω_t` family (attributed
in the source, already `BIBLIOGRAPHY.md`); the general collinear-pair enumeration (off-diagonal, two
radii) appears to be ours; nearest held: `[Polymath16wikiMain]`; zbMATH: `ab:"unit distance" & ab:"lattice" &
ab:"rotation"` (0 hits), `ab:"coincidence site lattice" & ab:"colouring"` (0 hits — the crystallography
identification is G62's, a separate finding). *Kernel:* declined — a field-arithmetic classification used as
a search filter; would need `K`'s explicit basis machinery already in `Instances/`, not built for this.

**M63G-T2 — The endpoint-radius bound `1/|sin θ|`, and its non-existence when `cos θ ∉ K`. [hand; the
phase-G implementer, 2026-09-11]** For a collinear cross pair at radii `t, s` on one ray through the centre,
`1 = t² + s² − 2ts·cos θ`; this quadratic form is positive definite (`|cos θ| < 1`), its solution set (in
`s`, for fixed `t`) is an ellipse, and a real solution exists only for `t ≤ 1/|sin θ|`. *Proof:* `plans/
M63-phaseG-bases-and-rotations.md` §1.3. At `ρ₁₅` (`cos = 7/8`) this gives `8/√15 ≈ 2.0656`, reproducing M62
§R22's independently measured bound and its consequence (126 cross edges at radius 2.00 and at radius 2.44,
unchanged). **For `cos θ ∉ K`** the angle between `u` and `ρv` is not fixed by a `K`-rational relation — only
`||u| − |v|| ≤ 1` is forced — so **no endpoint-radius bound of this form exists**, which is the stated reason
to screen the `cos θ ∈ K` family first (an arena at such a rotation cannot be sized by this argument at all).
*Proof verdict:* closes. *Rests on it:* every census's radius choice (2.00, 2.44) as a size that provably
captures every collinear pair up to the bound; `M63G-T5`'s "un-eliminated, not alive" scoping (a base
realising a live radius sum need not be inside a *fixed* radius, but any rotation this bound applies to has
its live material provably bounded). *Prior art:* elementary Euclidean geometry (an ellipse's real-solution
condition); ours as applied to this construction. *Kernel:* declined.

**M63G-T3 — The general cross-edge law for `cos θ ∉ K`. [hand; the phase-G implementer, 2026-09-11, "derived
here and worth implementing"]** With `ρ ∈ K(i, √D)` written `ρ = (c₁ + c₂√D) + i(s₁ + s₂√D)`,
`c₁,c₂,s₁,s₂ ∈ K`, the identity `Re(ρ(p+iq)) = k` splits over `{1, √D}` into two `K`-linear conditions on a
pair `(u,v)` with `w = conj(u)v = p+iq`, `ab = |w|²`, `D = ab − k²`: `c₁p − s₁q = k` and `c₂p − s₂q = 0`,
where `ρ = (k + i√D)/w` gives `c₁ = kp/ab`, `c₂ = q/ab`, `s₁ = −kq/ab`, `s₂ = p/ab`. The collinear law
(`M63G-T1`) is exactly the degenerate case `c₂ = 0, s₁ = 0` (forcing `q = 0`, `c₁p = k`). *Proof:* `plans/
M63-phaseG-bases-and-rotations.md` §1.4 — two linear equations, direct algebra. **Implementation hazard
named in the source:** `√D` is defined only up to sign and `K`-scaling, so the pair `(c₂, s₂)` must be
normalised against a canonical square-class representative of `D` before use as a dictionary key, or one
angle splits into many; the fix is to require the record's own rotation to appear exactly once in the
resulting census. *Proof verdict:* closes (algebra checked; not implemented as code in this file — the plan
records it as "worth implementing", deferred pending a nonempty `cos ∉ K` census, per its own §11.3/§D4
decision). *Rests on it:* nothing yet in this project (deferred); would generalise the whole filter cascade
of §2 beyond the `cos θ ∈ K` family. *Prior art:* ours; the two-radical splitting technique is standard
algebraic-number-theory bookkeeping, not itself a citable theorem. *Kernel:* declined.

**M63G-T4 — The σ-criterion: a one-sided residue elimination for type-M arenas, base-free and radius-free.
[hand; the coordinator/planner and the phase-G engineer jointly, 2026-09-12, credited "the coordinator's
correction" in the source]** Let `F` have a conjugation-fixed prime `𝔭` above 2 with residue field `𝔽₄`
(so Theorem B's residue colouring applies), and let `ρ` be a rotation with `cos θ ∈ F`, `sin θ ∉ F`. For a
collinear cross pair at squared radii `a, b` (`M63G-T1`'s family), write `σ = a + b`; then
`d² = |u−v|² = σ − (σ−1)/cos θ`, and the pair is `φ`-monochromatic (invisible to the residue colouring)
exactly when `v_𝔭(d²) > 0`. **If every radius sum `σ` realised by a collinear pair of the base satisfies
`v_𝔭(σ − (σ−1)/cos θ) = 0`, the type-M arena `L ∪ ρS` is four-colourable — for every base drawn in `F²`, at
every radius.** *Proof:* the formula for `d²` follows by substituting `p = k/cos θ` (from `M63G-T1`) into
`d² = |u|² + |v|² − 2Re(conj(u)v) = a + b − 2p`; the "base-free, radius-free" scope follows because `d²`
depends only on `σ` (not on which points of the base, or which radius, realise it) and the residue colouring
`φ` is Theorem B's colouring of the whole plane `F²`, defined independently of the arena. `plans/
M63-phaseG-bases-and-rotations.md` §12.3, "The filter this produced, and what it is worth". **It is
one-sided**: firing proves four-colourable; silence proves nothing (an un-eliminated rotation is not thereby
shown alive). Checked against four independently-computed cases (`ρ₁₅`'s equal-radius kind `σ=8` gives
`d²=0`; its auxiliary kind `σ=17/3` gives `d²=1/3`, a `𝔭`-adic unit; the centre family `σ=1` gives `d²=1` for
every rotation; a `−7/8` "antipodal" relabelling of the record gives `d²=16`), and it is silent on `ρ₁₅` at
both primes, which is forced (that arena is genuinely 5-chromatic) and is the criterion's own positive
control. **An independent cross-edge-law recount** (§12.3, "checked independently") re-derives the same `d²`
formula from the `K[x]/(x²−D)` expansion, never forming `conj(u)v` or testing collinearity, and shows the
radical coefficient is `2[u_xv_y − u_yv_x]` with `cos θ` cancelling out — so "the radical part vanishes" is
collinearity with the centre for every rotation at once, a structural identity rather than an assumption.
*Proof verdict:* closes. *Rests on it:* `CLAUDE.md` G52's necessary half (stated in the grokking in these
exact terms); `M63G-T5`; the elimination of the new rotation examined in §12 as an instance ("What actually
killed the new rotation" — but see `M63G-T5` for the sharper reading that the killing is `parts_lattice`'s,
not the angle's). *Prior art:* this project's own extension of Theorem B (`chromaticNumber_seamPlane`,
kernel, row 57) to a two-copy construction; the mechanism ("one colouring lays on both halves because the
rotated copy carries the same index set and internal edges", G46) is a reading of the construction's own data
layout, not a citable external result; nearest held: none specific to this construction; zbMATH:
`ab:"unit distance" & ab:"lattice" & ab:"rotation"` (0 hits). *Kernel:* declined — rests on Theorem B (kernel,
row 57) but the arena-level argument (that a cross edge is the only way the colouring can fail) is not
itself formalised.

**M63G-T5 — The design-target inversion: which radius sums keep a rotation alive, and the mechanism behind "wall-breaking is necessary, not sufficient". [hand; the phase-G implementer with the advisor's card RS-7, 2026-09-12]** Given `cos θ` alone (before any base exists), define
`Σ_live(cos θ) = { σ : v_𝔭(σ − (σ−1)/cos θ) > 0 at BOTH primes above 2 }` (both, since one free prime already
kills the family under `M63G-T4`); each live `σ` names the radius pair a base must contain outright, `a, b`
the roots of `x² − σx + ((σ−1)/(2cos θ))²`. **So a base is alive for a rotation only if it realises a live
`σ` at both primes above 2 — necessary, not sufficient.** Equivalently, reading from a point of squared norm
`n` rather than from `σ`: a ray through a `K`-point of squared norm `n` carries a cross edge at this rotation
iff `1/n − sin²θ` is a square in `K`. *Proof:* algebra on `M63G-T4`'s `d²` formula (`v_𝔭(d²) =
2v_𝔭(1−λ) − v_𝔭((1−λ)² + 2λ(1−cos θ))` under the substitution `a = 1/(λ² − 2cos θ·λ + 1)`, `λ` the ratio of
the two collinear radii); `plans/M63-phaseG-bases-and-rotations.md` §12.4–§12.6. **Exhibited on a real
instance, both halves of the question answered:** for a new candidate rotation, `[Parts2020a]`'s own lattice
(`parts_lattice`) realises **no** live radius sum (verified two ways — a direct integer-system search over
`S = a²+33b²+3c²+11d², P = ab+cd`, returning 30 solutions for the record's own rotation and 0 for the new
one; and the endpoint-bound/disk-cut check) — so **the rotation is un-eliminated by `M63G-T4` only because
`parts_lattice` is missing one point, not because it lacks the arithmetic**; a `K²`-point of squared norm
`(7+√33)/3` realising the equal-radius live family was then exhibited explicitly (radius ≈ 2.061113, all
four Galois conjugates of the radius positive) and checked by the independent `K[x]/(x²−D)` expansion. **The
mechanism this names**: breaking the 2-adic wall (G1/G35) is a statement about the field `K(√(sin²θ))` the
*rotated* copy lives in, while the residue colouring reads only the *base* points, which stay in `K`
regardless of the rotation; a wall-breaking rotation's arena escapes the base's own four-colouring only if
its cross edges actually realise a live `σ` — so **wall-breaking is necessary for an arena to be
5-chromatic and visibly not sufficient; the live-`σ`/equal-radius family is the mechanism that makes it
sufficient when it is.** *Proof verdict:* closes (both the necessary-condition theorem and its instantiation
on this rotation; the general question "which fields/rotations have Q1 and Q2 both YES" is registered as
predictions P-G13a–c, not claimed in general). *Rests on it:* `CLAUDE.md` G52 in full (the grokking's
"necessary and visibly not sufficient" sentence is this theorem, word for word); the design-target reframing
that replaces "a day of design per angle" (§4.2 row 4) with a microseconds-cost arithmetic condition; a
grokking candidate the source itself flags ("deserves a grokking at the milestone's close" — G52 is that
grokking). *Prior art:* ours; no external source is cited for this specific mechanism. *Kernel:* declined.

## Readings and measurements that were called theorems

- **The census tables of §3** (26 candidate angles down to 6 survivors on `[Parts2020a]`'s lattice at radius
  2.44, filter by filter) are computed facts about one base, not general claims — the *filters themselves*
  (filters 1–3 of §2, restated: Theorem B, the 2-adic wall test, the ≥2-radius-kinds test) are already-held
  theorems (`chromaticNumber_seamPlane`, G35) applied as a cascade, not new theorems minted here.
- **§11.6's "the six wall-breaking rows are two rotations"** and the isomorphism of the four angles of one
  class (P-G12f) are a computed symmetry finding (an explicit permutation check) about one census's reporting
  units, not filed as a separate theorem — it is bookkeeping downstream of `M63G-T1`'s enumeration.
- **The 412-persisted-class list's four gaps** (§1.2: keyed on square class rather than angle; enumerates
  unrealised pairs; only 150 of 412 on disk; computed on the wrong base) are a critique of an earlier
  artifact (`data/m62/rotations-moser-r2.05.json`, M62's), not a theorem.

## Conjectures surfaced, not claimed

- **P-G13a–c** (§12.5): whether Q1 (arithmetic: live `λ` exist) and Q2 (realisability: a live `a` is a
  genuine squared norm, on a lattice this project already builds) are generically YES for a "generic" new
  rotation. Answered YES/YES/YES-no-existing-lattice on the one instance tested (`M63G-T5`); not claimed in
  general.
- **The general question of §1.4** (whether the `cos ∉ K` family ever carries two kinds at one angle) is
  explicitly deferred, gated on a future census (P-G6), never claimed.

## Prior art re-attributed

None; `[Polymath16wikiMain]` was already correctly attributed in the source for the diagonal sub-case of
`M63G-T1` and is already in `BIBLIOGRAPHY.md`.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M63G-T1 | declined — field-arithmetic classification, not built in Lean's `Instances/` machinery |
| M63G-T2 | declined — elementary geometry |
| M63G-T3 | declined — not implemented even as code; algebra only |
| M63G-T4 | declined — rests on kernel Theorem B but the arena-level argument is not formalised |
| M63G-T5 | declined |
