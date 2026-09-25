# The mascot day, 2026-09-08/09 — the theorem audit (FS-71 batch 3b; ledger row 58)

*Filed 2026-09-22 by the batch-3b implementer. Enumeration: `plans/MASCOT-DERIVATION.md` (in full, 273 lines — the
project's own record, "Claude(deBruijn)–Kooshi spindle"); `plans/COXETER-2026-09-08-mascot.md` (in full, 561
lines — a parallel same-day session, per `CLAUDE.md` G51's competitor/advisor method); `plans/POROS-2026-09-08-
mascot.md` (in full, 101 lines — the advising session's card); `Proofs/HadwigerNelson/Mascot.lean` (declaration
list by `rg`); `Proofs/HadwigerNelson/Instances/Core9.lean` (declaration list by `rg`, to confirm `core9_plane`'s
vacuity finding is already row 31's, M34's, not new here); `LEDGER.md` row 58 and § B; `LEDGER.md` row 31 (to
confirm the `core9_plane`/`isEmpty_coloring_plane_four` vacuity finding MASCOT-DERIVATION.md §8 rediscovers is
already filed). Prefix per `plans/FS71-theorem-audit.md` §M.2 ("id prefixes for events that are not milestones"):
row 58's own text already uses "MASCOT" informally; this file adopts `MASCOT-Tn` for every theorem of the day,
credited by session (the working session that produced `plans/MASCOT-DERIVATION.md`, "Coxeter" for the parallel
session, per `CLAUDE.md` G51's naming).*

## Provenance, read once

Kooshi's challenge (2026-09-08): derive, by algebra alone and with no search, the analogue of the Moser spindle
for a 5-chromatic field. Two sessions worked it in parallel (`CLAUDE.md` G51's competitor/advisor design): the
working session (`plans/MASCOT-DERIVATION.md`) produced the kernel theorem that answers the challenge —
**the challenge is impossible as posed** (`Mascot.lean`, MASCOT-T5 below) — after two earlier constructions in
the same file were built and then retracted by the session itself (§8; not filed, see "What was retracted"
below). The parallel session ("Coxeter", `plans/COXETER-2026-09-08-mascot.md`) pursued a different route (a
rigidity theorem on K-fabric's √3-clean colourings) that did not reach a kernel theorem but proved several
results along the way, corrected twice by the advising session ("Poros", `plans/POROS-2026-09-08-mascot.md`).
None of Coxeter's theorems are cited by `Mascot.lean` or by row 58's text — they are filed here because the brief
for this batch directs it (`plans/FS71-theorem-audit.md`'s seed: "file whatever hand steps the derivation proves
beyond what `Mascot.lean` states") and because they are genuine hand theorems of this project's own 2026-09-08
session, not merely process.

## The theorems

### From the working session (`plans/MASCOT-DERIVATION.md`)

**MASCOT-T1 — The parity law. [hand + tools; the mascot-challenge session, 2026-09-08]** Let `ρ` be the Moser
twist (`cos = 5/6`, `sin = √11/6`), hub at the origin, `q_j = √3·w·ρ^j` walking a radius-`√3` circle. The chord
from step 0 to step `j` satisfies `d_j² = m_j / 3^(j−1)` with `m_1 = 1`, `m_2 = 11`,
`m_{j+1} = 5m_j − 9m_{j−1} + 2·3^j`, and modulo 2 the recurrence is Fibonacci (`m_{j+1} ≡ m_j + m_{j−1}`, seeded
`1,1`), so **`d_j²` is even iff `3 | j`**. Since Theorem B's residue colouring identifies two points exactly when
their difference has positive 𝔭-adic valuation (even squared distance, for a rational `d²`), **a pair forced
monochromatic at four colours on the Moser ladder sits at a step divisible by 3; the first is `d_3 = 8/3`.**
Equivalently, `ρ ≡ −ζ₆ (mod 8)`: the Moser twist has order 3 modulo 8. *Proof:* `plans/MASCOT-DERIVATION.md` §1
(lines 25–48), verified exactly in `ladder.py` (not re-run in this batch). *Proof verdict:* closes. *Rests on it:* MASCOT-T4's sieve (which chords are field-6-open); the M53 rigidity dial's independent confirmation (163/178
forced-equal pairs at `8/3`, none at 2 or 4, over 15,230 pairs — recorded there as an unexplained regularity that
this law explains). *Prior art:* the parity pattern is confirmed by, but not derived from, a published table:
`[Parts2020hv]` (arXiv:2010.12661 §2, held, read) tabulates non-monochromatic pairs at `1/3, 5/3, 7/3, √3,
√(11/3)` and a monochromatic one at `8/3` with no explanation — "the arithmetic explains a published table", the
explanation itself is ours; zbMATH: `ab:"spindle" & ab:"chromatic number"` (5 hits, none opened — general χ ≥ 5
surveys). *Kernel:* declined (a closed-form recurrence over one specific construction; no Lean consumer named).

**MASCOT-T2 — The chord-ratio identity. [hand; the mascot-challenge session, 2026-09-08]** Let `ω` be a rotation
with `cos θ = c`, walking a circle by repeated `ω`. Since `ω̄ = 1/ω`: `ω² + ω + 1 = ω(2c+1)`, hence
`ω³ − 1 = (ω−1)·ω·(2c+1)`, so **the step-3 chord is `|2c+1|` times the step-1 chord**; normalised to unit steps,
the step-3 chord is exactly `2c + 1`. A pair forced monochromatic at four colours over `K` needs 2-adic valuation
`≥ 2` (𝔽₄-residue arithmetic gives `> 0`; the six `ℤ/4`-type additive colourings of the Eisenstein lattice raise
it to `≥ 2`), so the rotation must satisfy **`4 | (2c+1)` two-adically**. For the Moser twist `c = 5/6`:
`2c+1 = 8/3`, valuation 3; the radius making steps unit is `r = 1/√(2−2c) = √3`; the spindle radicand is
`4(8/3)² − 1 = 247/9`. *Proof:* `plans/MASCOT-DERIVATION.md` §5 (lines 130–149). *Proof verdict:* closes.
*Rests on it:* MASCOT-T3's uniqueness search (which enumerates rotations against this exact criterion);
MASCOT-T1's parity law, of which this is the general (non-Moser-specific) form. *Prior art:* ours — the trig
identity itself is elementary, but the framing (a rotation's step-3-to-step-1 chord ratio as `2c+1`, and the
resulting 2-adic divisibility criterion on the rotation) is not stated elsewhere in this project's held
literature; no query run (the identity itself is textbook; the application is ours). *Kernel:* declined.

**MASCOT-T3 — Uniqueness of the Moser twist among low-height pinning rotations. [tools; bounded search,
`unique.py`, the mascot-challenge session, 2026-09-08]** Among all `c = p/q` with `q ≤ 400` satisfying
{unit steps, drawable in `K`, `4 | 2c+1` two-adically}, exactly nine rotations qualify; exactly two have base
field equal to `K` itself rather than a proper subfield — `c = 5/6` (chord `8/3`, radicand `247/9`) and
`c = −139/150` (chord `64/75`, radicand `10759/5625 = (7·29·53)/5625`). **`c = 5/6` is the one of least height,
and it is the only one whose first two rungs are the Moser spindle itself.** *Proof:* `plans/MASCOT-DERIVATION.md`
§5 (lines 151–156), the search `unique.py` (not re-run in this batch — tools-grade, bounded, not exhaustive over
all `q`). *Proof verdict:* closes, as a `[tools]` statement over exactly the checked range `q ≤ 400` — the
general claim ("no smaller-height rotation exists at any `q`") is not proved, only checked to that bound.
*Rests on it:* nothing downstream in this project (the session's own next step was the sieve, MASCOT-T4, not a
further use of uniqueness). *Prior art:* ours — a bounded search over this project's own criterion; no external
analogue. *Kernel:* declined (a finite bounded search, not a closed-form theorem).

**MASCOT-T4 — The deep-chord sieve, and minimality versus 6-openness in direct opposition. [hand; the
mascot-challenge session, 2026-09-08, correcting an earlier verdict of Poros the same day]** (a) **Every spindle
over a deep pair (a 2-adically deep chord on the Moser ladder) breaks the 2-adic wall automatically**: the
radicand `4d² − 1` is `≡ 7 (mod 8)` at every deep step `j` with no exceptions, because `d²` is 2-adically deep —
6-openness is then decided purely by the Legendre symbol of the radicand mod 11. Sieving every deep ladder chord,
**the 6-open/5-sealed status alternates**: `j = 3` sealed (`√247`), `j = 6` **6-open** (`√33063`), `j = 9`
sealed, `j = 12` 6-open, and so on — correcting Poros's same-day claim ("every distance the law can select lands
in a 5-sealed field") as stated too broadly. (b) **But minimality and 6-openness are in direct opposition**: the
minimal forcing shape (`K₅ − e` in the `{1,√3}`-distance graph, §2 of the same file — itself retracted, see
below) can only target the *first* deep chord, because a configuration whose target is a later deep chord
contains the earlier deep pairs too, turning the pigeonhole into a disjunction over several candidate
monochromatic pairs rather than a single forcing. On the Moser ladder the first deep chord (`j = 3`) is `8/3`,
whose field is sealed — so the conclusion "K-fabric's Moser-ladder forcer can never reach a 6-open field" survives
Poros's correction, for a structural reason rather than an arithmetic accident. *Proof:* `plans/MASCOT-DERIVATION.md`
§6 (lines 158–184), `sieve.py` (not re-run). *Proof verdict:* closes. *Rests on it:* `CLAUDE.md` G48's mechanism
("a forcer deletes exactly the local bound it beats"), of which (a) is an identity rather than a case check — a
sharpening the entry itself names. *Prior art:* ours; the sieve is this project's own computation over its own
field census. *Kernel:* declined.

**MASCOT-T5 — The Moser recipe's sharp threshold: the mascot challenge is impossible as posed. [kernel; the
mascot-challenge session, 2026-09-08, `Proofs/HadwigerNelson/Mascot.lean`]** The Moser spindle's recipe — take
the smallest graph forcing two non-adjacent vertices to share a colour at `k` colours (a `(k+1)`-clique minus one
edge), hinge two copies at a common vertex, pick the hinge angle so the forced vertices land at distance 1 — stops
at `k = 3`, provably. **General form:** a host graph with no `k`-clique draws no minimal forcing gadget at `k`
colours (`not_forces_of_drawing`), with the clique number the entire hypothesis. **Plane instance:** four points
of the plane are never pairwise at distance 1 (`no_four_unit_points`, a Gram-determinant argument: any three plane
vectors are dependent, forcing the Gram determinant to be simultaneously `1/2` and `0`), so **no five points of the
plane carry a pair forced to share a colour at four colours, for any `k ≥ 4`** (`not_forces_of_unit_drawing`).
**The threshold is sharp:** at `k = 3` the rhombus (`ζ₆, 0, 1, ζ̄₆`, injective, every edge exactly one unit) is
drawn and forces its far corners (`exists_forces_of_unit_drawing_three`). **The contrast is the content:** at
three colours the minimal gadget (`K₄ − e`) *is* a unit-distance graph (the rhombus); at four colours the minimal
gadget contains `K₄`, and the plane's unit-distance clique number is 3 — the plane's clique number equals the
colour count only at `k = 3` and falls below it forever after, which is why every 5-chromatic unit-distance graph
ever built has hundreds of vertices and a computer behind it. *Proof:* `plans/MASCOT-DERIVATION.md` §7 (lines
186–222); `Mascot.lean` (zero `sorry`, axioms exactly `[propext, Classical.choice, Quot.sound]`). *Proof verdict:*
closes. *Rests on it:* row 58's own text (this is its content, given full quantifiers here); the posed-open-
question connection (§9 below, the word "minimal" itself is `[ExooIsmailescu2019]`'s open question, found on the
same page as the Theorem B question). *Prior art:* the abstract minimal-gadget shape (`K_{k+1} − e`) is folklore
graph theory (unattributed by name in the source); the plane-specific unrealisability at `k ≥ 4` and its sharp
threshold at `k = 3` are this project's own; the challenge's own adjective ("minimal") restates a question posed
in print by `[ExooIsmailescu2019]`, three lines from their Theorem B question, found by Coxeter the same day
(§9 of `MASCOT-DERIVATION.md`) — not a prior-art hit against this theorem, but against the open problem it bears
on. *Kernel:* kernel (`card_le_of_forces`, `colorable_of_not_adj`, `isNClique_of_forces_of_card`,
`no_four_unit_points`, `no_isNClique_four`, `no_isNClique_of_four_le`, `not_forces_of_drawing`,
`not_forces_of_unit_drawing`, `not_forces_five_points`, `exists_forces_of_unit_drawing_three`,
`Mascot.lean`) — already row 58's citation, filed here with its full quantified statement and the generalisation
(`not_forces_of_drawing`) that the ledger row's prose compresses.

### From the parallel session (`plans/COXETER-2026-09-08-mascot.md`, credited "Coxeter")

**MASCOT-T6 — The rigidity theorem: a √3-clean 4-colouring of K-fabric is one of Theorem B's two residue colourings, and the dichotomy this forces. [hand; Coxeter, 2026-09-08]** *Hexagon lemma:* if a hexagonal unit
shell about a point `O` has no monochromatic `√3`-pair, its rim is a proper 3-colouring of `C₆` with exactly one
alternating pattern, forcing all three diameters monochromatic (`c(O + 2u') = c(O)`) — verified exhaustively over
the six clean rim colourings. *Corollary:* a 4-colouring of `Σ₀` (the K-fabric unit-vector group) with no
monochromatic `√3`-pair factors through `Σ₀/2Σ₀`. *The quotient:* `R/2R ≅ 𝔽₄ ⊗_{𝔽₂} 𝔽₄ ≅ 𝔽₄ × 𝔽₄` (the two
projections being reduction at the two conjugation-fixed primes above 2), and the unit vectors surject onto
`𝔽₄ˣ × 𝔽₄ˣ` (verified: 9 of 9). **Theorem:** every proper 4-colouring of the K-fabric with no monochromatic
`√3`-pair is one of Theorem B's two residue colourings up to relabelling — because the quotient graph is
`K₄ × K₄`, which has exactly 48 proper 4-colourings, every one a coordinate projection (the Greenwell–Lovász
phenomenon: `K_n` is uniquely `n`-colourable in the categorical product — classical, self-attributed as such by
the source, no novelty claimed for that step). **What is new is the identification**: the quotient of K-fabric by
its own doubling *is* `K₄ × K₄`, with the two factors being the two primes above 2. **Dichotomy corollary:** in
every proper 4-colouring of K-fabric, either some `√3`-pair is monochromatic, or every pair whose difference lies
in `2Σ₀` is monochromatic simultaneously — `2Σ₀` contains `2, 4, 8/3, 8/√3, 2√3, 4/3, 4/√3, 2/√3`, so this
explains in one line the shape of `[Parts2020hv]`'s published mono/non-mono table (§4 of the source). *Proof:*
`plans/COXETER-2026-09-08-mascot.md` §2–3 (lines 30–77). *Proof verdict:* closes — re-derived by the owner at acceptance (2026-09-22): the rim of a √3-clean shell is forced to the pattern `a,c,b,a,c,b`, so antipodal rim points agree and, shifting the shell to `O + u`, `c(O + 2u) = c(O)`; `R` here is the rank-4 Moser lattice `ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩`, an order of the CM field `ℚ(√−3,√−11)` in which 2 splits (`33 ≡ 1 (mod 8)`) into two primes of residue field `𝔽₄` (each inert from `ℚ(√−3)`), so `R/2R ≅ 𝔽₄ × 𝔽₄`, the unit vectors land in `𝔽₄ˣ × 𝔽₄ˣ`, and the quotient graph is `K₄ × K₄`, whose proper 4-colourings are the two projections up to relabelling — the two residue colourings; the statement's "K-fabric" means that rank-4 lattice, not the rank-8 order `Σ₀` of `K(i)` — **with a scope correction the
source records against its own first reading**: an early message claimed "the strata stand or fall together"
(that the 2-adic depth stratification is not a hierarchy of difficulty), refuted by Poros against M56's own
measured table (depth 2 free, depth 3 forced, simultaneously on one fabric) — the theorem itself is unaffected,
but it constrains only the `√3`-**clean** colourings; the stratification lives among the `√3`-**dirty** ones,
about which this theorem says nothing (§8, lines 212–243). *Rests on it:* MASCOT-T8 (the `ρ₄` theorem, which
discharges this theorem's hypothesis by spindling); MASCOT-T7's Consequence 3 (which needs this theorem's upgrade
from "some monochromatic `√3`-pair" to "every 2-adically-even pair monochromatic"). *Prior art:* the `K₄ × K₄`
uniquely-colourable-product step is classical (Greenwell–Lovász; unattributed by name in the source — a check is
owed: `[GreenwellLovasz1974]` or similar, not held); the hexagon lemma and the identification of K-fabric's
doubling quotient with `K₄ × K₄` (the two factors being the two primes above 2) are Coxeter's own; zbMATH:
`ti:"chromatic number" & ab:"categorical product" & ab:"uniquely colorable"` (0 hits recorded — not re-queried in
this batch after the source's own attribution; check owed: the Greenwell–Lovász citation). *Kernel:* declined (no
Lean consumer named; the mechanism is subsumed in spirit by `CLAUDE.md` G54's tight/slack classifier and FS-70's
periodic-colouring machinery, neither of which cites this theorem). *[Correction at FS-89's close, 2026-09-25, from the products reader (`plans/PA-products-GL1974-LT2002.md` §0 item 2, §3; the paper read in full): the `K₄ × K₄` step holds, but not as "`K_n` is uniquely `n`-colourable in the categorical product" — `K₄ × K₄` has two 4-colourings up to relabelling (48 labelled, as stated), which is `[GreenwellLovasz1974]` Corollary 3 (p. 336, `n = 4`, `k = 2`); the uniqueness statement is their Corollary 1 and needs `χ > n`. The check owed above is paid: the citation holds, as Corollary 3.]*

**MASCOT-T7 — The cross-edge theorem of a twisted lattice pair, and the forced field of the pinning gadget.
[hand; Coxeter, 2026-09-08]** Let `d > 0` with `d²` a Loeschian integer, `ρ_d = (2d²−1 + i√(4d²−1))/(2d²)`,
`L₀ = ℤ[ζ₆]`, `L₁ = ρ_d L₀`. **Theorem:** the unit-distance edges between `L₀` and `L₁` are exactly the six pairs
`(w, ρ_d w)` with `|w| = d`, together with the star of the shared centre `0` — no other cross edges exist.
*Proof:* writing `z̄w = a + bζ₆`, the edge condition's imaginary part forces `b = 0` (since `√3·Im ρ_d` is
irrational over ℚ in every checked case), reducing to a one-variable quadratic in the ratio `t = w/z`, solved and
checked exhaustively over the finitely many Loeschian norms in range; checked at `d = √3, 2, 4, 2√3` with exactly
one admissible solution `(N,t) = (d²,1)` each. **Consequence 1:** `[Parts2020hv]`'s pinning gadget (centre plus
two radius-`d` hexagons plus six cross edges, 13 points) is the canonical member at `d = 2`. **Consequence 2, the
Moser twist cannot pin:** the pinning step needs the radius-`d` hexagon to collapse to two colours under a
striped colouring, which happens iff `d²` is a Loeschian multiple of 4; the Moser twist's shell has `d² = 3`
(odd), straddling both row parities, so it pins nothing — **the `√5` in `[Parts2020hv]`'s human-verifiable proof
is forced by the smallest admissible pinning shell (`d = 2`, adjoining `√15 ~ √5`), not a convenience.**
*Consequence 3, the honest open point:* the next admissible shells are `d² = 12` (adjoining `√47`, 5-sealed) and
`d² = 16` (`ρ = arccos(31/32)`, adjoining `√63 = 3√7`); pinning at `d = 4` stays inside `K(√7)`, but only pins
`φ_n = φ_{n±4}` (phase constancy modulo 4, not full constancy) — closing this gap is **explicitly reported as not
closed**. *Proof:* `plans/COXETER-2026-09-08-mascot.md` §7 (lines 166–210). *Proof verdict:* closes for the
cross-edge theorem and its two Consequences 1–2; Consequence 3's gap-closing is *not claimed* (see "Conjectures
surfaced" below). *Rests on it:* MASCOT-T8 (`ρ₄` uses this theorem's field, `K(√7)`, reached by a different
route — spindling a K-fabric pigeonhole rather than pinning a hexagon). *Prior art:* ours — an exact classification
of cross edges between two rotated triangular-lattice copies; no external source states this in this project's
held literature; zbMATH: `ab:"twisted" & ab:"unit distance graph"` (0 hits), `ab:"rotation" & ab:"unit distance
graph" & ab:"pinning"` (0 hits). *Kernel:* declined.

**MASCOT-T8 — The `ρ₄` theorem: an unconditional `√3`-pigeonhole realised inside `K(√7)`-fabric. [hand; Coxeter,
2026-09-08, discharging MASCOT-T6 by Exoo–Ismailescu's spindling move]** Let `ρ₄ = (31 + 3i√7)/32` (the spindle
rotation at distance 4) and `Σ₀` the K-fabric unit-vector group. **Theorem:** every proper 4-colouring of
`Σ₀ ∪ ρ₄Σ₀` has a monochromatic `√3`-pair inside one of the two copies. *Proof:* suppose not; by MASCOT-T6 each
copy, having no monochromatic `√3`-pair, is residue-coloured in its own transported arithmetic; `4 ∈ 2Σ₀` gives
`c(0) = c(4)` in the first copy and `c(0) = c(4ρ₄)` in the second; `|1 − ρ₄|² = 2 − 2(31/32) = 1/16`, so
`|4 − 4ρ₄| = 1` — two adjacent points sharing colour `c(0)`, contradiction. Two lines, no search; the object lies
in `ℚ(√3,√7,√11) = K(√7)`, reached from a different direction than MASCOT-T7's pinning route. **What it is not:**
a pigeonhole, not a contradiction — it does not close `χ(K(√7)²) ≥ 5` on its own (killing a monochromatic
`√3`-pair is exactly the open step MASCOT-T7 leaves), and its "some monochromatic pair" conclusion is *weaker*
than what this project already holds unconditionally on the whole plane (`core9_plane`, row 31, nine-point
carrier) — but the field is new: MASCOT-T9 below shows `core9_plane`'s carrier cannot be drawn in `K(√7)` at all,
so this pigeonhole, though weaker in generality, is the first realised there. *Proof:* `plans/COXETER-2026-09-08-
mascot.md` §9 (lines 295–336), §9a (lines 337–400). *Proof verdict:* closes (the theorem itself; the route to
`χ(K(√7)²) ≥ 5` through it is explicitly not closed — see MASCOT-T10). *Rests on it:* MASCOT-T10 (the striped-
colouring dichotomy, whose case (i) this theorem closes). *Prior art:* the discharging move (spindle a forced
pair to create a unit edge between two copies) is `[ExooIsmailescu2019]`'s Claim 2.1 mechanism, already credited
in this project's field-wall record (row 47) and in `plans/MASCOT-DERIVATION.md` itself for the T20 correction;
applying it to MASCOT-T6's conditional pigeonhole to make it a two-copy theorem is Coxeter's own; no fresh query
(the attribution is already held). *Kernel:* declined.

**MASCOT-T9 — The nine-point carrier of `core9_plane`'s pigeonhole is intrinsically a `ℚ(√5)`-object, and cannot be drawn in `K(√7)²`. [hand + exact check; Coxeter, 2026-09-08, correcting two of the source's own prior readings]** `Instances/Core9.lean`'s `core9_plane` (row 31, kernel) gives a monochromatic `√3`-pair for every proper
4-colouring of the *whole plane*, on a nine-point carrier at denominator 512. **Computing all 36 pairwise squared
distances of that carrier exactly in the `ℚ(√3,√5,√7,√11)` tower**: every one lies in `ℚ(√5)`, with only the
radicands `1` and `5` occurring anywhere in the table (asserted over all 36, not sampled) — ten of the 36 carry a
genuinely nonzero `√5` component, in a conjugation-closed pattern (three rational parts, each occurring with both
signs). **Since `√5 ∉ ℚ(√3,√7,√11) = K(√7)`, the nine-point carrier cannot be drawn in `K(√7)²` by any isometry**
(squared distances are isometry invariants), so `core9_plane`'s pigeonhole is *not* realised inside K(√7)-fabric,
and MASCOT-T8's `ρ₄` theorem (weaker in conclusion, but realised on a `K(√7)` object) is the first `√3`-pigeonhole
known there. *Proof:* `plans/COXETER-2026-09-08-mascot.md` §9a (lines 337–400), the 36-pair exact computation
recorded there (not re-run in this batch). *Proof verdict:* closes. *Rests on it:* MASCOT-T8's claim of novelty
("the first `√3`-pigeonhole realised there"), which depends on this non-embedding result. *Prior art:* ours — an
exact field-membership check on a held kernel object's carrier; the source itself records **two corrections to
its own first reading** en route (first defending subsumption on the wrong sentence — `core9_plane`'s hypothesis
type is empty given rung B, so "a subset colouring need not extend" was beside the point; second, making
subsumption decidable by the embedding question above), both Poros's, both recorded in the entry itself rather
than silently fixed. *Kernel:* declined (an exact arithmetic check over kernel data, not itself formalised as a
theorem).

**MASCOT-T10 — The one-case dichotomy under Parts's discharged lemma. [hand; Coxeter, 2026-09-08]** Write
`z = m + nζ₆` for `L = ℤ[ζ₆]` (`n` the row). Under `[Parts2020hv]`'s discharged lemma (no monochromatic
`√3`-triple, his 481-vertex computer part), every proper 4-colouring of `L` is **striped**:
`c(m + nζ₆) = P_{n mod 2}[(m + φ_n) mod 2]` for a colour-pair partition `P₀, P₁` and a phase sequence
`φ_n ∈ {0,1}`. **Theorem (exhaustive dichotomy):** either (i) no phase wall (`φ_n` constant on each row parity),
in which case `c` is the residue colouring and MASCOT-T8's `ρ₄` spindle closes it (`χ ≥ 5`); or (ii) some
`n` has `φ_n ≠ φ_{n+2}`, which is **not one monochromatic `√3`-pair but a whole lattice line of them** — for
every `m ∈ ℤ`, `(m + nζ₆, (m−1) + (n+2)ζ₆)` is monochromatic at distance `√3`, since the connecting vector
`−1 + 2ζ₆` (norm 3) joins two points of the same row-parity class, which wear the same colour pair exactly when
`φ_n ≠ φ_{n+2}`. **The dichotomy itself closes; case (ii)'s impossibility is explicitly reported as not closed**
("I have not closed it, and I am not going to write that it nearly is", §11). Three sharpening remarks recorded
with it: case (ii) is invisible to Parts's own lemma (no striped colouring has a monochromatic `√3`-triple at any
phase, so his computer part cannot reach it even in principle — proved by MASCOT-T11 below); MASCOT-T7's
cross-edge budget between `L` and `ρ₄L` is exactly six, the same count Parts uses to close his analogous case at
`d = 2`; and case (ii) is "strictly easier than the problem the literature is stuck on" (Poros's reading, §11a,
adopted) — it hands over an infinite, translation-invariant family of monochromatic pairs at one known vector,
buying a local-contradiction target, a free choice of `m`, and several pairs at known relative positions inside
one gadget, none of which the general "kill some monochromatic `√3`-pair, location unknown" problem offers.
*Proof:* `plans/COXETER-2026-09-08-mascot.md` §11 (lines 487–525), §11a (lines 526–561). *Proof verdict:* closes
for the dichotomy and the three sharpening remarks; case (ii)'s closure is a **conjecture, not claimed** (see
below). *Rests on it:* nothing further in this project's held record — the mascot day ended with case (ii) open,
and no later milestone in this batch's file set returns to it. *Prior art:* the striping structure under a
no-monochromatic-triple hypothesis is implicit in `[Parts2020hv]`'s own computer-verified lemma (his 481-vertex
part establishes exactly the hypothesis this theorem's dichotomy is built on); the dichotomy itself, its case (ii)
naming, and the three sharpening remarks are Coxeter's own; no fresh query (the object is this project's own
synthesis of a held paper's lemma). *Kernel:* declined.

**MASCOT-T11 — No `√3`-triangle of `ℤ[ζ₆]` has all three vertices in one row-parity class. [hand, verified by
exhaustion; Coxeter/Poros, 2026-09-08]** The `√3`-vectors of `ℤ[ζ₆]` are the six solutions of `m² + mn + n² = 3`:
`±(1,1), ±(2,−1), ±(1,−2)`; row parity is `n mod 2`, and only `±(1,−2)` has even `n`. A `√3`-triangle needs
`v, w, v−w` all of norm 3; with `v = −w = ±(1,−2)` the difference has norm 12, not 3 — checked by exhaustion over
all 12 candidate triangles, zero survivors. **Consequence:** this is the mechanism behind a gap in
`[Parts2020hv]`'s Table 1 (non-mono-pair gadgets listed at `3, 7/3, 5/3, 1/3, √(11/3)`, none at `√3`) — de Grey
and Parts both route through monochromatic-`√3`-*triples*, and no striped colouring has one at any phase, so
**the entire triple-based apparatus is structurally blind to case (ii)** of MASCOT-T10, which is why a new
ingredient is needed to close it rather than an extension of the known methods. *Proof:* `plans/COXETER-2026-09-
08-mascot.md` §11a (lines 526–540). *Proof verdict:* closes. *Rests on it:* MASCOT-T10's remark that case (ii) is
invisible to Parts's lemma. *Prior art:* ours — an exhaustive check over the Eisenstein lattice's norm-3 vectors,
explaining rather than merely noting an absence in a held paper's published table. *Kernel:* declined.

## Readings and measurements that were called theorems

- **The vacuity retraction in `plans/MASCOT-DERIVATION.md` §8**: the session's own nine-point `√3`-triangle
  construction is retracted (a misread of `[Parts2020hv]`'s Table 1, and — its own second, later-retracted claim
  — an appeal to `core9_plane`/`core122_plane` as forbidding any `√3` virtual edge, which is **vacuous**, not a
  theorem, since this project's own `χ(ℝ²) ≥ 5` makes "a proper 4-colouring of the plane" an empty type
  (`isEmpty_coloring_plane_four`, `Instances/Interval.lean`). This is the **same finding already filed under row
  31** (M34, `CLAUDE.md` batch-1 territory: "`core9_plane` and `core122_plane` are vacuous... and support
  nothing") — a correct re-application within the mascot session, not new content, and not re-filed here.
- **Poros's card** (`plans/POROS-2026-09-08-mascot.md`): a registered open question ("is the depth-2 Kempe
  separation structural or finite-size?") with a falsifier, not a theorem — synthesises M56's dial and M58's
  sieve criterion (both already filed/held) into a sieve table (lines 16–26); the table itself is a cross-
  reference, not new computation. Superseded in substance by the amendment (lines 65–86), which re-derives the
  same question in a cheaper two-half form after `[ExooIsmailescu2019]`'s `G40` was read — also a registered
  question, not a theorem. Neither is filed; both are readings with open falsifiers, unresolved by anything in
  this batch's file set.
- **§10's methodological finding** ("not one of four errors was caught by care... every one was caught by
  printing or opening the whole thing"): a method observation, already the substance of `CLAUDE.md` G21/G51; not
  independent content.
- **The Moser recipe's own three-sentence self-summary** and R8-style closing paragraphs throughout both files:
  restatement, not separate claims.

## Conjectures surfaced, not claimed

- **MASCOT-T7's Consequence 3**: whether the `d = 4` pinning gadget's phase-constancy-modulo-4 can be tightened
  to full phase constancy inside `K(√7)` — explicitly reported not closed, no later milestone in this batch's
  files returns to it.
- **MASCOT-T10's case (ii)**: whether a striped 4-colouring of `L = ℤ[ζ₆]` with a phase wall (an infinite,
  translation-invariant family of monochromatic `√3`-pairs along `−1 + 2ζ₆`) can be refuted by a finite gadget —
  explicitly reported not closed. `plans/STUB-four-colour-valuation-law.md` stubs the related non-vacuous
  four-colour valuation law (from `plans/MASCOT-DERIVATION.md` §8) but not this specific case; no stub currently
  names case (ii) by itself — flagged as a possible stub target, not minted here (out of this batch's scope,
  which files and classifies rather than mints new stubs beyond what the brief names).

## Prior art re-attributed

- **`[ExooIsmailescu2019]`'s field and forced-pair-then-spindle move**: `plans/MASCOT-DERIVATION.md` §7's
  T20-correction and `plans/COXETER-2026-09-08-mascot.md` §8(i) both independently find that their Claim 2.1
  (arXiv:1805.00157, held and read in full the same day after two weeks marked "second-hand") gives the same
  field (`ℚ(√3,√11,√247)`), the same spindle rotation (`sin θ = 3√247/128 = ρ_{8/3}`), and the same
  forced-pair-then-spindle move as this project's own K(√247) route (M53's 588-vertex core) — theirs
  **conditional** (on no monochromatic `√(11/3)`-pair, needing three acts), this project's **unconditional** on
  K-fabric (one act) plus the exact value `χ(K(√247)²) = 5` (M58), which they do not have. Already row 47/M53's
  and this project's `BIBLIOGRAPHY.md` record it; no new row needed, cross-referenced here so batch readers see
  the mascot day's own correction of its earlier over-claim ("first 5-forcer without √5 or √7", withdrawn) and
  under-claim ("an independently constructed witness", also withdrawn) attempts.
- **The word "minimal" itself**: `[ExooIsmailescu2019]`'s posted open question ("what is the minimum order of a
  5-chromatic unit distance graph in the plane?") sits three lines from the Theorem B question on the same page —
  a fourth independent posting (joining Benda–Perles OP 11.6, Moorhouse §1, Cranston–Rabern), found by Coxeter
  (§8(ii) of the source) while reading the same held PDF for the field attribution above. `BIBLIOGRAPHY.md`'s
  `[ExooIsmailescu2019]` row already carries this per the source's own note; not a new bibliography edit here.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| MASCOT-T1 | declined |
| MASCOT-T2 | declined |
| MASCOT-T3 | declined |
| MASCOT-T4 | declined |
| MASCOT-T5 | kernel (`Mascot.lean`, full list above) — already row 58's citation |
| MASCOT-T6 | declined |
| MASCOT-T7 | declined |
| MASCOT-T8 | declined |
| MASCOT-T9 | declined |
| MASCOT-T10 | declined (case (ii) is an open conjecture, not a kernel target) |
| MASCOT-T11 | declined |
