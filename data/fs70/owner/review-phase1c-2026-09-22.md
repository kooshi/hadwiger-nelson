# FS-70 — the owner's review of phase 1c (the in-field rotation sweep), 2026-09-22

*Scored by artifact against `data/fs70/records/phase-1c.md` (commits `2675c893`, `98118d2b`, `df548537`, `7770b301`). Implementer:
Opus 5, ≈600k tokens. Every check below is my own code or hand, none shared with `tools/fs70_*`.*

## 1. Verdict: ACCEPTED as a phase; the milestone stays open (phase 1d next)

| what | how I checked | result |
|---|---|---|
| **The theorem** (record §3): every unit vector of the CM field `E₀ = ℚ(√−3,√−5)` is a 2-unit, so every commensurate rotation's arena is four-coloured by the residue map at any radius | by hand, before reading §3b: 2 is inert in ℚ(√−3) (−3 ≡ 5 mod 8) and ramified in ℚ(√−5) and ℚ(√15), so `E₀` has one prime above 2 with `e = f = 2`; over its real subfield ℚ(√15) (one prime, `e = 2, f = 1`) that prime is inert, and complex conjugation — the nontrivial automorphism of `E₀/ℚ(√15)` — fixes it; `ψψ̄ = 1` gives `2v(ψ) = 0`. The arena of `ψ ∈ E₀` lies in the 2-integral lattice `Λ + ψΛ ⊂ E₀`, every edge difference is a 𝔭-unit with nonzero residue in `𝔽₄`, and reduction is a proper additive four-colouring (Theorem A). Also: `E₀ ⊗ ℚ₂ = ℚ₂(√−3, √−5)`, one prime — consistent with the PARI log | **sound**, and it is the additive screen (`ψ`) seen through G62: commensurate ⟹ periodic ⟹ 2-unit here. Its scope is the record's §9(v): a base whose ℚ-span is `E₀` |
| **Cross-edge counts of the top three live rotations and the control** (`po_rot_cross.py`, mine: the base word ball built in exact arithmetic over ℚ(√3,√5), rotated exactly, pairs proposed on a float annulus with the cell range derived from the tolerance, decided exactly) | ρ₁₅ at sums of ≤ 4; then ranks 1, 2, 3 | **138 pairs, 78 = 30 + 48** (ρ₁₅); **144 pairs, 84 = 0 + 84**; **132 pairs, 72 = 12 + 60**; **120 pairs, 60 = 0 + 60** — integer for integer with §4c |
| **One arena's complete edge set and its committed colouring** (`po_verify_arena.py`, mine: the whole 54,433-point arena's unit-distance graph re-derived from the point set alone, compared with the file's edge list; the colouring checked on MY edges; a plant drops one of my edges) | rank 2's arena, `k4-psi--11_0_0_0_0_0_0_3_16` | **352,320 edges, equal to the file's, 0 missing, 0 extra; 4 colours, 0 monochromatic edges under my derivation; the plant reads "extra-in-file 1" and exits 1** — the record's §6c-bis scope limit (only ρ₁₅'s arena had a second edge derivation) is now closed for one more arena by an independent route |
| The k = 5 pass (record §5b, filled at handback: ranks 1–2 SAT at 699 s and 710 s; ranks 3–5 running under pgid `443653` with a marker) | the ledger rows; `ps`; the marker | within budget; left to finish. §5b's remaining rows are read from `data/fs70/asks.jsonl` when they land (below, §4) |
| The record's own defects (the grid join's straddling loss, 6 of 42,660 at `ψ = ζ₆`; the refusal detector matching its own explanatory line; the unchecked merge; the contended timing read as a per-call cost; the `--sat` prediction lost) | read against the artifacts and the plants log | each recorded with its direction and its plant; **the straddling defect flattered the null and was found by a control written for another purpose — G21's rule at its sharpest, and the implementer said so** |

## 2. What phase 1c established

1. **The rotation list is complete for denominator ≤ 42 and for every class the `(z + s)/w` generator reached above it: 3,499
   classes, every count exact.** The brief's enumeration bounded the joining vector, not the rotation (ρ₁₅'s 138 pairs use
   joining vectors of denominator up to 144) — the implementer's correction, and the right one.
2. **The literature's method — base plus one rotated copy — cannot refuse four colours on the CM base over ℚ(√3,√5) at the
   sizes asked, and the reason is arithmetic**: the rotations with coupling (2,712 cross edges down to 492 at rank 20) are all
   commensurate and dead by theorem; the wall-breaking ones couple at ≤ 84 and colour in seconds; the cross-edge set did not
   grow from sums of ≤ 4 to ≤ 5 at either rank measured.
3. **ρ₁₅ is rank 6 among the live rotations, and only one class of 3,499 is type-M.** The field screen (G7, row 64) sees a
   thin slice of the field's rotations.
4. **G53's counting compulsion is absent (`L = 0`) at all three live rotations with a diagonal circle.**

## 3. What it means for the plan, and the two conjectures

The arena route over this field is now closed for one rotated copy of the CM base. It is **not** closed for: two rotated
copies (de Grey's two centres — G12), translated copies (Harder's `V + V + H` is a Minkowski sum, not a rotation), a base
outside `E₀` (the record's §9(v)), or a lattice with a wall-breaker in the base (L6). Phase 1d computes the theory that says
where forcing can exist at all (the split-prime tower) and builds the missing positive control; phase 1e asks the shapes.

The record's two conjectures (§9) are stub candidates for the close: **(1)** commensurate ⟹ 2-unit holds for any CM field
whose prime above 2 is not split over its real subfield, and fails where it is split — a `nflist` sweep tells whether the
base's field was lucky or forced; **(2)** a twisted bilayer's cross-edge set is fixed by the rotation alone and does not grow
with the base — measured at two ranks and on ρ₁₅'s circle at four radii; if a theorem, growing a base never buys compulsion
over this field. Neither is claimed.

## 4. The k = 5 pass (filled in when the run ends)

*(rows appended below by the owner from `data/fs70/asks.jsonl`; verified by `po_verify_arena.py` where affordable)*

## 5. Owner errors this milestone (running list)

1–6 as in `plans/SESSION-HANDOFF-2026-09-22-fs70-mid.md` §2. **7.** The phase-1c brief's rotation enumeration bounded the wrong
object (the joining vector) — caught by the implementer against ρ₁₅'s known anatomy. **8.** The brief said "top twenty"; the
top twenty of the whole list were all dead by theorem, and the sentence a reader needs is about the top of the live list.

## 6. Files

`po_rot_cross.py` (cross edges of a rotation on the CM base, ~5.5 min per rotation at sums of ≤ 4), `po_verify_arena.py`
(an arena's full edge set and colouring, ~4 min at 54k points), this note.
