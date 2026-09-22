# M32 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-22 by the FS-71 batch-1 implementer. Enumeration: `plans/M32-certified-five.md` read in full.
Grades are `CLAUDE.md` § Notation's.*

## The theorems

**T1 — The stacking law. [hand; the M32 implementer; confirmed by census]** For a stack `H ∪ R₁·H ∪ R₂·H` of
seam-field material (`Rᵢ = sᵢWᵢ` about anchors `aᵢ`, in M31-T1's vocabulary): **(a)** *same anchor* (`a₁ = a₂`): the
pair `(R₁H, R₂H)` is isometric to `(H, R₁⁻¹R₂·H)`, so copy↔copy coupling is exactly M31-T1's single-word law at the
relative word `R₁⁻¹R₂` — same-anchor stacks are thin by the same mechanism, however many copies are stacked.
**(b)** *different anchors, same rotation* (`a₁ ≠ a₂`, `R₁ = R₂ = sW`): writing `A = a₁ − a₂`, `w = u − v`,
`ζ = s·w·Ā`, the cross-coupling equation splits, as in M31-T1, into a collinearity condition (`Im(ζ) = 0`, a pin on
the DIFFERENCE of the two offsets, not on either point alone) and a quadratic in `|w|` with at most two roots per ray
sign. In particular `w = 0` is a root iff `|A| = 1`, giving a translation matching of size `|H ∩ (H + A)|` — O(n)
coupling, realised exactly at the unit-separated anchor pairs this project's fabric naturally supplies (e.g. the M23
triangle's pivots); at separation `|A|² = 1/3` the quadratic's discriminant carries `√59 ∉ K`, so the channel is
empty at that separation. *Proof:* `plans/M32-certified-five.md` §0a ("The stacking law (a-priori derivation; the
copy↔copy analogue of M31's law)"), cases 1–2. *Confirmed*: Q3 (same-anchor thin at every probed instance, χ = 4
throughout — the chirality pair's copy↔copy channel exactly zero); Q4 (the unit-separation translation matching
exists exactly as predicted, 132 chords, and the `1/√3` channel is exactly empty as derived) —
`plans/M32-certified-five.md` §0g and §R. *Proof verdict:* closes for cases (a) and (b) as stated: every point
prediction of the a-priori algebra was confirmed exactly by the census, including the sign of the discriminant at
the sterile separation. *Rests on it:* the "mechanism, named" reading recorded alongside it in the plan — that a
perfect matching (1-regular coupling) "carries no colour pressure", even composed into forced-rainbow triangles — is
a SEPARATE, weaker claim (see § below, not filed here). G14. *Prior art:* ours. zbMATH:
`ab:"perfect matching" & ab:"rotated copy" & ab:"chromatic"` (0 hits); `ab:"unit distance" & ab:"quadratic form" &
ab:"independence"` (0 hits, shared with M31-T1). No held key on point. *Kernel:* declined — instruments-only by
design ("the derivation stands informally in §0a ... no Lean obligations this milestone"); no later milestone found
in this audit formalised it.

## Readings and measurements that were called theorems

- **"Width without degree does not force"** (G14's second half): the empirical null that the unit-separation
  translation matching, and the composed 26-triangle forced-rainbow web spanning three detuned copies, carry zero
  colour pressure at every probed scale — zero forced pairs, zero virtual edges, zero coverage movement, across
  46 + 94 + 100 SAT calls, all `χ = 4` (`plans/M32-certified-five.md` §0g addendum, §R). This is a measured null with
  a plausibility gloss ("a perfect matching is 1-regular, carries no colour pressure"), **not** a proof that no
  1-regular coupling can ever force a compulsion — the general claim quantifies over an infinite family of possible
  stacks and only a finite, though sizeable, sample was probed. Recorded here, not in § B.

## Conjectures surfaced, not claimed

(none)

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T1 | declined — instruments-only, never formalised |
