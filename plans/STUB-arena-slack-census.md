# FS-43 — The slack census: where, if anywhere, can a five-colour compulsion live in the ρ₆₃ arena and its thickenings? (STUB, 2026-09-13; minted by Kooshi in the FS-38 fork session, from the fan-gap theorem of `plans/FS38-residue-tower.md` §S2)

*Read beside: `plans/FS38-residue-tower.md` §S2 (D0.2, the fan-gap theorem; D0.3, the arity-k filter), `plans/M63-phaseH4-sweep.md`
(the 1.3-billion-pair null this stub explains or fails to), `plans/M63-phaseH2-plan.md` and `data/m62/m63-phaseH2-rho63-certificate.json`
(the arena as a pair `(f, g)` of base colourings with 30 diagonal and 36 off-diagonal cross constraints), `CLAUDE.md` G13 (the fan
ladder: coverage is a k-set property invisible to pair sweeps), G40 (absorption: a 4-colourable piece carries no compulsion of its
own), G53 (the counting compulsion on the circle).*

## 1. Mission context, in plain language

FS-38's fan-gap theorem, run on a graph against itself, says: **a vertex that has a free colour in some proper `k`-colouring is
forced to agree with no other vertex at `k` colours.** ("Free colour at `v` in `C`": a colour other than `C v` that appears on no
neighbour of `v`; the reconfiguration literature's "`v` is not frozen in `C`".) So a forced pair at five colours can only sit at two
vertices that are **frozen in every five-colouring**. That is a coverage property (G13: every five-colouring puts all four other
colours on `N(v)`), and the record has always said coverage is invisible to pair sweeps. The ρ₆₃ arena's 1.3-billion-pair sweep
(M63 phase H4) read zero forced pairs and zero virtual edges over 4,480 exhibited five-colourings; the record explains that zero
by readings only (G31's extension, "the object is thin", G52, G53). This stub replaces the readings with a census: **which vertices
of the arena are frozen in every five-colouring, and which have a free colour in some?** Every vertex of the second kind is free of
forcing by theorem, so the sweep's zero over those pairs was a matter of course, and the first kind, if nonempty, is the only
place a compulsion could ever have lived.

**The derivation that makes the census small.** The arena is a base `B` (25,567 points of `K² = ℚ(√3,√11)²`, four-colourable by
Theorem B's residue colouring) together with its rotated copy `RB`, sharing the centre, joined by **66** cross edges (30 diagonal
`(v, Rv)` on the circle `|p|² = 16`, 36 off-diagonal; row 64, G31's "compulsion budget 66 of 544,530"). A vertex of `B` not
incident to a cross edge has all its neighbours in `B`. Take any five-colouring of the arena of the form `(f, g)` with `f` a
**four**-colouring of `B` (colours 0–3) and `g` a five-colouring of `RB` compatible with `f` across the 66 cross edges: then every
vertex of `B` off the cross edges sees at most three colours besides its own and has colour 4 free — it is not frozen. The same
with the roles of the halves exchanged. So **if one compatible pair `(f, g)` with `f` a four-colouring exists, every vertex not
incident to a cross edge is slack by derivation**, and the census reduces to the at most **132** cross-edge endpoints (30 + 36
pairs, fewer after overlaps). Whether such a pair exists is one SAT ask on the interface instance the H2 certificate already
defines (`reduction`: "arena colourable iff two base colourings `f, g` with `f(centre) = g(centre)`, `f(v) ≠ g(v)` on the 30 diagonal
points, `f(i) ≠ g(j)` on the 36 off-diagonal pairs"), with `f` restricted to four colours and `g` allowed five.

## 2. What we know

| fact | trust | where |
|---|---|---|
| a free colour at `v` in some `k`-colouring ⟹ `v` forced to nothing (`not_forces_of_fanGap` with `f = id`) | **kernel** (row 66; FS-38 closed 2026-09-13) | `Proofs/HadwigerNelson/FanGap.lean` |
| the arena: 51,133 vertices, 544,530 edges, χ = 5 exactly; 66 cross edges; base four-colourable in 0.35 s | solver-only (χ ≥ 5), verified colouring (χ ≤ 5) | row 64; `plans/M63-phaseH4-reduce-the-platform.md` §R |
| 0 forced pairs of 1,307,266,278; 0 virtual edges of 1,306,721,748; 4,480 exhibited colourings, each verified | measured, complete; **the colourings were never committed** (`data/m63/README.md` "not recorded here") | `plans/M63-phaseH4-sweep.md` §8; `data/m63/m63-phaseH4-rho63-sweep.json` |
| an explicit five-colouring of the arena, constructed in 0.7 s and verified on every edge | verified | `plans/M63-phaseH4-reduce-the-platform.md` line ~843; `data/m63/m63-phaseH4-rho63-k5.json` |
| arity 3: 337 candidates standing on 163 interface vertices, unswept beyond | partial | `plans/M63-phaseH4-sweep.md` |
| the interface reduction: arena colourings = compatible pairs `(f, g)` | derivation, kernel-free | `data/m62/m63-phaseH2-rho63-certificate.json` |

## 3. Derivations first

**D1 (slack ⟹ free, on the object itself).** FS-38's D0.2 with `G = P` and `f = id`. Nothing to add; the kernel form ships with
FS-38. **D2 (the cross-edge reduction above).** Write it out with the exact vertex sets: `X_B` = base endpoints of cross edges,
`X_R` = copy endpoints; claim: if a compatible `(f, g)` with `f` four-coloured exists, then `V(B) ∖ X_B` is slack; symmetrically
with `g` four-coloured. Proof: a vertex `v ∈ V(B) ∖ X_B` has `N(v) ⊆ V(B)`, so `C(N(v)) ⊆ {0,1,2,3} ∖ {C v}` has at most three
colours and `4` is free. ∎ **D3 (what a frozen vertex needs).** A vertex frozen in every five-colouring has, in every colouring, all
four other colours on its neighbourhood: for the cross-edge endpoints this means the colouring must place the fifth colour among
their neighbours in every colouring — a property of the 66-edge interface, not of the halves. **D4 (the counting compulsion
reread).** G53's `B(f), B(g)` disjoint on the 30 circle points is a statement about the diagonal endpoints exactly; a frozen
diagonal endpoint `v` needs `f(N_B(v)) ∪ {g(Rv)}` to be all four other colours — read G53's `L/count = 1/3` against this.

## 4. Phases

| phase | what | cost | stop rule / acceptance |
|---|---|---|---|
| A | the one ask: a compatible `(f, g)` with `f ∈ {0,1,2,3}^B` (and its mirror); verify proper on all 544,530 edges; record | minutes | if none exists in either polarity, D2 does not apply and every vertex goes to phase B |
| B | the census on `X_B ∪ X_R` (≤ 132 vertices; ≤ 22 orbits under the arena's ζ₆ and half-turn symmetry — quotient first): per vertex `v`, one SAT ask "a proper five-colouring in which `v`'s neighbourhood misses a colour ≠ `C v`", on the interface instance; a model is verified on every edge and is the record; a refusal is re-asked on a second solver and recorded as "frozen (solver)"; the planted control: pin a colour on every neighbour of a slack vertex and confirm the ask flips | an hour | the frozen set `Φ` of the arena, with a trust word per vertex; `Φ = ∅` explains the null in full |
| C | the arity-3 remainder read through D0.3: each of the 337 standing candidates dies if some gapped colouring has all its partners off the gap colour — decide from the phase-B models before any solver | an hour | the 337 reduced to the survivors, if any |
| D | **the slack dial on thick K(√7)-fabric**: close the arena under the direction group ⟨ζ₁₂, σ, √ρ₆₃⟩ (G8) to depth two in the √ρ₆₃ directions, so cross edges are everywhere rather than at 66 places; at each thickness (three points on the dial), the frozen set by the phase-B ask restricted to one fundamental domain; forced-pair asks **only among frozen pairs** | a day; checkpoint per thickness under `data/fs40/ckpt/`, resume command in the README | the first thickness with `Φ ≠ ∅` is the first fabric over a 6-open field with a frozen vertex; forced-pair asks there are the jackpot protocol below |

## 5. Registered predictions (both outcomes reachable)

| id | prediction | if it holds | if it fails |
|---|---|---|---|
| P1 | phase A's `(f, g)` exists in both polarities | every non-interface vertex slack by D2; census = interface only | the null needs the full census (phase B on all 51,133 vertices, by orbit) |
| P2 | `Φ = ∅` on the arena: every cross-edge endpoint has a free colour in some colouring | the 1.3-billion-pair null is a theorem-grade matter of course; "the object is thin" becomes "every vertex is slack" | a nonempty `Φ` is the first frozen material in a 6-open field; the sweep's zero over `Φ × V` was then a genuine measurement, and the pairs inside `Φ` are re-asked with two encodings |
| P3 (hunch) | thickening to depth two produces frozen vertices | the slack dial is the instrument the six-hunt lacked: forcing asks restricted to `Φ` | no frozen vertex at any affordable thickness: evidence that five-colourings of K(√7)-fabric stay floppy everywhere — the disproof side's first structural datum |

## 6. Failure and jackpot clauses

Failure: P2 fails and the frozen pairs, re-asked, are all separated — then the arena carries frozen vertices with no forced pair,
and the next question is D3's (what the interface forces at frozen vertices), which is FS-44's. Jackpot: a forced pair among
frozen vertices of thick K(√7)-fabric is HALT AND VERIFY (two encodings, the residue check that no residue target exists, the
spindle radicand `4d² − 1` and its field, which stays 6-open by inheritance), then the spindled object's five-colour ask: a refusal
in a 6-open field is the programme's target object, a candidate until certified.

## 7. Bearing on 6, honestly

Medium as an instrument, low as a result: it measures the necessary condition for forcing (frozenness) instead of forcing itself,
at a cost of hours instead of the 1.3 billion asks of phase H4, and it either explains the arena's null by theorem or hands the
hunt its first frozen material. Its two-sided reading (P3) is the first structural datum on the case for five.

## 8. Addresses

`Proofs/HadwigerNelson/FanGap.lean` (`FanGap`, `not_forces_of_fanGap`, `not_fan_of_fanGap`); `tools/arena_sweep.py` and the H2
interface encoder (`plans/M63-phaseH2-solver.md`); `data/m62/m63-phaseH2-rho63-certificate.json`; `data/m63/m63-phaseH4-rho63-k5.json`;
`plans/M63-phaseH4-sweep.md` §8 (the null); records to `data/fs40/` with a README row per file.
