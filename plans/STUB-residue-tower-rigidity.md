# FS-38 — The residue tower: at which level of the prime does a sealed plane force? (STUB, 2026-09-13; minted by the Poros wall-breaking pass, `plans/POROS-2026-09-13-wall-breaking.md`)

*Read beside: `plans/M60-five-colour-residue-obstruction.md` (the origin reduction; `Forces` on a Cayley graph decided by one
table), `plans/M61-local-global-tightness.md` §S5 (G48, the mechanism this stub tries to complete), `plans/M56-arithmetic-of-
tightness.md` §R (the four-colour forcing at 2-adic depth 3 that this stub must reproduce before it may be believed),
`plans/M59-finite-plane-lift.md` and `Proofs/HadwigerNelson/Lift.lean` (the level-p² plane, used there only as an obstruction),
`plans/STUB-family-keeping-thickening.md` §H (i) (the forced-distance table at residue norm 0 — the instance test this stub's
phase C runs), `BIBLIOGRAPHY.md` `[BardestaniMallahiKarai2015]` (the local-field object).*

## 1. Mission context, in plain language

The programme reads a number field F through the residue map at a prime 𝔭 of F(i) fixed by complex conjugation. At level one
that map lands the unit-distance graph on F² in a finite object: at a prime above 2 with residue field 𝔽₄ it is the clique K₄
(Theorem B's four colours), at a prime above p ≡ 3 (mod 4) it is the finite Euclidean plane UD(𝔽_p, 2). Every bound the
programme holds is a level-one bound, and every "sealed" in the record means "sealed at level one".

The forcing the programme needs is not at level one. The four-colour forced pairs from which every 5-forcer's spindle was
built — de Grey's pair at distance 4, the antipodal pairs at 4/√3, T20's pairs at 8/3 and 8/√3 — sit at 2-adic depth: the
dial on the descent's K-fabric reads 163 of 178 pairs forced at valuation 6, 8 of 11 at 8/√3, and **zero** at valuations 2
and 4 (`data/m53/rigidity-dial-it4.json`); M56 measured the same fabric's true forced set as 171 pairs at depth 3 and none
at depth 2, and recorded no mechanism (`plans/M56-arithmetic-of-tightness.md:409-410,728-733`). At 11 and five colours the
record knows only level one, where the plane forces nothing (`finitePlane11_forces_iff`, kernel), and every five-colour
sweep ever run — on the 1581, on Heule-510/553, on the two-core union, on the ρ₆₃ arena over 1.3 billion pairs — read zero
on a *critical* 5-chromatic object, which is not where the four-colour pairs were ever found.

**The object this stub names.** For 𝔭 with residue ring O/𝔭^m, the **level-m residue plane** is the Cayley graph
P_m = Cay(O/𝔭^m, S_m), S_m the image of the norm-one group (for 𝔭 ∣ p unramified of degree one, O/𝔭^m = ℤ/p^m and
P_m = UD(ℤ/p^m, 2) = `unitQuadrance (ZMod (p ^ m))`, a type that elaborates today). The maps P_{m+1} → P_m are graph
homomorphisms (`unitQuadrance.map` along `ZMod (p^{m+1}) → ZMod (p^m)`), and their inverse limit is the unit-distance graph
of the 𝔭-adic plane — the anisotropic quadratic graph over a local field of `[BardestaniMallahiKarai2015]`. A colouring of
a level-m plane is **d-continuous** (d < m) if it is constant on the cosets of 𝔭^d/𝔭^m; the residue colouring is
1-continuous by definition.

**The question.** For (𝔭, k): what is the least level m such that every proper k-colouring of P_m is d-continuous for some
d < m — and what d? In M60's vocabulary: at level m, is the origin forced equal to 𝔭^d·v for every v? A "yes" at (11, 5)
for some m says that a fabric over a 5-sealed field, deep enough to see level m at 𝔭 ∣ 11, forces a pair at a distance d
with 11 ∣ d² — the pair G48 needs — and its spindle is a 6-forcer in a 6-open field. A "no" at every affordable m says the
residue mechanism cannot supply that pair.

## 2. What we know

| fact | trust | where |
|---|---|---|
| level one at 11 forces nothing at any colour count it admits, every p ≡ 3 (4) | kernel | `PlaneRotation.lean:184-190`, `ResidueObstruction11.lean` |
| level one at 2 over K(i) is K₄: uniquely 4-colourable | by definition of Theorem B's residue map | `FieldWall4.lean` §7–§8 |
| K-fabric at four colours: forced pairs at valuation 6 (163/178), 8/√3 (8/11), none at valuations 2, 4; F_true = 171 at depth 3, 0 at depth 2 | measured, complete sweeps | `data/m53/rigidity-dial-it4.json`; M56 §R |
| the level-p² plane's residue map and the lift obstruction | kernel | `Lift.lean:19-22,217` |
| the finite Borel chromatic number of the local plane is finite iff the form is anisotropic (−1 not a square in the completion) — the wall, on the Borel side | external, read | `BIBLIOGRAPHY.md:45` |
| the tower P_m as a colouring object: **never named or computed here** | absence, grep 2026-09-13 | `plans/`, `Proofs/` |

## 3. Derivations first (G46: the object in its discipline before any run)

**D1 — the tower and its homomorphisms, in the kernel's vocabulary.** `unitQuadrance (ZMod (p ^ m))` is the level-m plane;
`unitQuadrance.map (ZMod.castHom …)` is P_{m+1} → P_m. State d-continuity as `∀ v, Forces (P_m) k 0 (p^d • v)` through
M60's origin reduction (`forces_iff_forces_zero_sub`), so that ONE table decides it: a k-colouring of P_m that is not
periodic under some p^d·v refutes d-continuity at level m (`not_forces_zero_of_not_periodic`, kernel), and a forcing
verdict at level m is "every k-colouring is p^d-periodic" — a refusal of the Separated ask, solver-side, kernel-promotable
only through a certificate. The kernel half of a positive result is therefore the *lower* levels' refutations and the
transfer; the forcing verdict itself is solver-side unless the level is small enough to decide.

**D2 — from the tower to a fabric (the transfer).** A finite unit-distance graph in F² with coordinates integral at 𝔭 maps
homomorphically to every P_m. If every k-colouring of P_m is d-continuous, then every k-colouring of the fabric that FACTORS
through P_m identifies pairs at 𝔭-depth ≥ d — but a fabric's colourings need not factor. What the tower gives directly is
weaker and exact: the fabric's colourings restricted to the fibres. The derivation to make: under what hypothesis on the
fabric (a chunk containing a full set of representatives of P_m's vertices, joined as P_m is joined) does every k-colouring
of the fabric induce a k-colouring of P_m? Answer sketch: a chunk that contains, for every edge of P_m, a lifted unit edge
between lifts of its endpoints, with the lifts CONSISTENT (one lift per class), is an induced copy of P_m's quotient — that
is the lift question of M59 turned around, and M59's obstruction (a residue configuration lifts only if it is a shadow)
says such a chunk need not exist. So the honest transfer is compactness in the other direction: if the 𝔭-adic plane's
k-colourings are all d-continuous, then some finite chunk forces every depth-d pair it contains (the colouring space of the
local plane is compact, and "every finite chunk separates the pair" would yield a separating colouring of the whole plane).
The size of that chunk is the design number, and phase C measures it on the 2-adic bed where the answer is known to be
"about depth 3".

**D3 — the two primes are opposite at level one, and the question is whether they meet above it.** At 2 the level-one
object is a clique, so 1-continuity is trivially forced at level one and the interesting depth is where continuity FAILS
to propagate upward (M56: the additive family over-forces depth 2; the truth forces depth 3). At 11 level one is pairwise
free. If the tower at 11 never becomes continuous at five colours, the residue mechanism has no six-level; if it does at
level m, the level names the depth and therefore the SIZE of the fabric a 6-forcer over a sealed field needs.

**D4 — the prior-art gate (WORKFLOW 3a), before any run.** Search under the discipline's names: "finite Euclidean graphs
over rings ℤ/p^r" (Medrano–Myers–Stark–Terras have a rings paper — recalled, not read, not in the bibliography), "unit
distance graphs over ℤ/n", "chromatic number of Cayley graphs on ℤ/p^m × ℤ/p^m", "colourings of the p-adic plane /
quadratic graphs over local fields" (Bardestani–Mallahi-Karai's object; do they compute Borel χ for anisotropic binary forms
over ℚ_p, and is it p+1 or the level-one plane's value?). Record the result in §PA either way.

## 4. Phases

| phase | what | cost | stop rule |
|---|---|---|---|
| PA | the prior-art gate (D4) | half an hour | finds a computed value of χ for the p-adic plane → read it before building |
| A | **the 2-adic tower on the certified bed**: P_m over K(i) at four colours, m ≤ 8 (|P_m| = 4^m), by exact enumeration where small and SAT above; record, per m, the least d with every 4-colouring d-continuous | an afternoon | if no m ≤ 8 forces valuation-6 pairs while chunks do (M56), the frame is killed here and the stub closes as a negative |
| B | **the 11-adic level two at five colours**: P₂ = UD(ℤ/121, 2), 14,641 vertices, degree 132; the Separated ask at the origin for each class of 11·v under the rotation group — a SAT model is a verified non-periodic table (kernel `¬Forces`); a refusal on every class is "1-continuous at level 2", solver-side | a day | refusal on every class → phase C; a model on any class → phase B′ (level 3, 1.77 M vertices, only if affordable) or close as "not continuous at the affordable levels" |
| C | **the instance test**: B9 (i) of `plans/BACKLOG-FOR-OPUS.md` — the forced-distance table at residue norm 0 on Heule-510 ∪ its gen-1 closure and W ∪ its F₂₄₇ cross lattice, asked under the jackpot protocol; the size of the fabric that first forces, read against the level found in B | a day of CPU, existing instruments | any forced pair at 11 ∣ d² is HALT AND VERIFY (two encodings, the residue check, the spindle field computed) |
| D | the derivation of the level from the structure of P_m (the connection set S_m over ℤ/p^m: p^{m−1}(p+1) points; the quotient P_m → P_{m−1} has fibres of size p²; is the fibre graph a clique, a matching, empty?) — the shape that makes A's and B's verdicts matters of course | two days | if the fibre structure alone decides continuity, the level is a theorem and the stub's question is closed by derivation for every p |

## 5. Registered predictions

| id | prediction | falsifier |
|---|---|---|
| P1 | at 2 over K(i), four colours: some level m ≤ 8 has every 4-colouring constant on valuation-6 cosets and some 4-colouring separating a valuation-4 pair — matching `data/m53/rigidity-dial-it4.json` | the tower separating valuation-6 pairs at every m ≤ 8 |
| P2 | at 11, five colours, level 2: the first Separated ask returns a model (P₂ is not 1-continuous) — because level one is pairwise free and the fibres of P₂ → P₁ are sparse | a refusal on every class at level 2 |
| P3 | the fibre graph of P_m → P_{m−1} at 11 is empty (no unit vector is ≡ 0 mod 𝔭, since x² + y² ≡ 0 has only the zero solution mod 11 — `quadrance_eq_zero_iff`), so continuity at 11 can only come from cycles through several fibres, never from a fibre's own edges — which is why P2 is expected to hold at level 2 and the interesting question is the growth of the least d with m | a nonempty fibre graph at 11 |
| P4 | the prior-art gate finds the spectra of P_m over ℤ/p^r in the literature and no colouring value | a computed χ(P_m) in print |

## 6. Failure and jackpot clauses

**Failure at A:** the 2-adic tower never forces at any affordable level → chunk forcing is not tower-continuity; the M56 fact
belongs to another discipline (reconfiguration, FS-2); this stub closes as a clean negative and the Poros frame is killed
in its ledger. **Failure at B/B′:** no continuity at 11 up to the affordable level → the residue mechanism cannot supply the
six-level's pair through the tower; route A of `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §3 is closed *at its mechanism*, and
the bet moves toward "no six through sealed fields" — recorded as such, with the level reached. **Jackpot:** any forced
pair at 11 ∣ d² on a fabric over a sealed field (phase C) is HALT AND VERIFY: two encodings, the residue check, the spindle
radicand 4d² − 1, the spindle field's sieve (wall broken, 11 inert), then the spindled object's four-colour and
five-colour asks — a refusal of five in a 6-open field is the programme's target object and is treated as a candidate
until certified.

## 7. Bearing on 6, honestly

Medium-high as a frame, medium as work. It is the only stub that changes the programme's OBJECT (level one → the tower)
rather than adding an instance inside it; it predicts the one four-colour fact the record measured and never explained;
it is finite and cheap at 2; and at 11 it is two-sided. Its risk is the transfer (D2): continuity of the local plane's
colourings gives forcing on some finite chunk by compactness, but the chunk's size is not bounded by the argument, and a
fabric we can build may not reach it. Phase C measures that on the bed where the answer is known.

## 8. Addresses

`Proofs/HadwigerNelson/UnitQuadrance.lean` (`unitQuadrance`, `unitQuadrance.map`), `ResidueObstruction.lean` (the origin
reduction, `not_forces_zero_of_not_periodic`), `Lift.lean` (`ZMod (p ^ 2)`, `residue`), `LocalGlobal.lean`
(`quadrance_eq_zero_iff`, `addCayleyMap`, `unitQuadrance_colorable_of_quotient`), `tools/fplane.py` (the Cayley machinery,
periodic quotients), `tools/fpcompel.py` (sets / filter / augment), `data/m53/rigidity-dial-it4.json`, `data/fplane/`.
