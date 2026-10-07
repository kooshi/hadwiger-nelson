# FS-44 — The fifth colour: what replaces residue rigidity for five-colourings over a 6-open field (STUB, 2026-09-13; minted by Kooshi in the FS-38 fork session)

> Closed as a direction, 2026-10-07: a CP five-colouring of the plane does not exist (`[OAIMath2026]` Thm 1.4 with row 130).

**At the 2026-09-26 re-rank (job R3; `plans/RERANK-2026-09-26.md` § Application — R3): rank 40 → 13 in `plans/FRONTIER-STUBS.md`.** **Re-aimed:** given MR, a five-colouring of `K(√7)²` exists iff `UD(ℝ²)` has a CP one (R1's walk, from T-J39-3), so its question becomes the shape of a CP five-colouring of the plane — FS-104's mirror. derived frame (the upper side of rung D); low as work. Provisional bearings add: FS-103 (the collapse — F1, a candidate composition, not a result), FS-104 (`χ_CP(ℝ²)` at six), FS-105 (harden MR).

*Read beside: `plans/FS38-residue-tower.md` §S2 D0.6 (over a sealed field the mechanism's second act cannot exist; over a 6-open
field no residue instrument sees anything), `plans/M56-arithmetic-of-tightness.md` §R1 (the four-colour colouring space of
K-fabric: residue-rigid at 2-adic depth ≥ 3, the additive family, the 16-pair non-additive residue), `plans/STUB-kempe-classes.md`
(FS-2, which this stub re-aims at K(√7)), `CLAUDE.md` G36 (the residue colouring is the canonical separating colouring), G41–G42
(additive colourings and additive rigidity), G53 (the counting compulsion), `plans/STUB-arena-slack-census.md` (FS-43, whose
frozen set is this stub's input).*

## 1. Mission context, in plain language

Every step of the ladder so far had a canonical colouring to be rigid around. Over ℚ(√3) at three colours it is the residue
colouring at 3 (the plane `UD(𝔽₃) = K₃ □ K₃`, whose three-colourings are Latin squares, all frozen); over `K = ℚ(√3,√11)` at four
colours it is Theorem B's residue colouring at 2 (the clique `K₄`, uniquely colourable), and M56 measured how deep K-fabric's
four-colourings are forced to agree with it (every pair at 2-adic depth ≥ 3, 171 of them, forced; none at depth ≤ 2). The forced
pairs that built every 5-chromatic graph are that rigidity, read off at distance 8/3, 8/√3, 4 and 4/√3. **Over a 6-open field
such as `K(√7)` there is no canonical five-colouring at all**: no residue plane is five-colourable (that is what 6-open means), and
no additive five-colouring exists either (Fischer's 1/k obstruction, `[Fischer1990]` Thm 10(ii): no additive `k`-colouring,
`k ≤ 10`, of a wall-broken plane). So every five-colouring of fabric over `K(√7)` is non-arithmetic, and FS-38 has just proved
that the one mechanism for the next rung — a forced pair over a field sealed one colour below — has no instance at 5 → 6. If a
six-chromatic unit-distance graph exists, its five-colour compulsions come from somewhere the record has never looked: **the
structure of the five-colourings themselves.** This stub asks what that structure is.

**The handle the record already holds.** A five-colouring `C` of a K-fabric `X` (four-colourable by the residue colouring `r`)
determines an independent set `S = C⁻¹(4)`, the *fifth-colour set*, and a four-colouring `C|_{X ∖ S}` of the rest. M56's rigidity
says four-colourings of deep K-fabric agree with `r` (up to palette) on pairs at depth ≥ 3; with `S` removed the fabric is thinner
and the rigidity weaker, but it does not vanish. On the arena (base `B` plus its rotated copy `RB`), a five-colouring is a pair
`(f, g)` of base colourings (G46, G53), each with its own fifth-colour set `S_f, S_g ⊆ V(B)`, and the 66 cross edges are relations
between `S_f`, `S_g` and the residue classes. G53's counting compulsion — `B(f)` and `B(g)` disjoint on the circle — is the first
theorem about those sets. **The conjecture this stub tests:** the five-colourings of thick fabric over `K(√7)` are "a residue
four-colouring of each K-piece plus a fifth-colour set", the fifth-colour sets are constrained by the √7-cross edges, and the
constraints have an algebra (which residue classes `S` may meet, at which depths) that plays the role residue rigidity played
at 4 — so that a frozen vertex, and then a forced pair, is a statement about where the fifth colour is *not allowed to be*.

## 2. What we know

| fact | trust | where |
|---|---|---|
| four-colourings of K-fabric: residue-rigid at depth ≥ 3; `F_true = 171 ⊆ F_K = 187 ⊆ F_add = 2,513` | measured, complete on U (1,953 points) | M56 §R1; `data/m53/rigidity-dial-it4.json` |
| no additive five-colouring of any wall-broken plane | prior art, hand | `[Fischer1990]` Thm 10(ii); G41 |
| the arena's five-colourings are pairs `(f, g)`; `B(f) ∩ B(g) = ∅` on the circle; `L/count = 1/3` | derived; one provisional measurement | G53 |
| every unit-distance object held is Kempe-open by orders of magnitude (gauge γ ≫ 0) | measured | M57 §R, H4 §15 |
| no residue target for five-colourings over `K(√7)` | definition of 6-open; FS-38 D0.6 | G43; `plans/FS38-residue-tower.md` |
| the frozen set `Φ` of the arena and of its thickenings | **FS-43's deliverable, not yet measured** | `plans/STUB-arena-slack-census.md` |

## 3. Derivations first (G46: name the object in its discipline)

**D1 — the fifth-colour set as a defect.** For a K-fabric `X` with residue colouring `r : X → 𝔽₄` and a five-colouring `C`,
define `S(C) = C⁻¹(c₄)` for the colour `c₄` least used, and ask: on `X ∖ S(C)`, at which 2-adic depth does `C` agree with `r`
(M56's dial, with `S` deleted)? Prediction: the depth-3 rigidity survives deletion of any `S` that meets each residue class in a
"small" set; the derivation to make is the dependence of the surviving forced set on `S` (the M56 machinery, `tools/additive.py`
and the rigidity dial, with a deletion argument). **D2 — the cross-edge relations.** For the arena, write the 66 constraints as
relations between `(r∘f-pattern, S_f)` and `(r∘g-pattern, S_g)`: the diagonal edges `(v, Rv)` say `f(v) ≠ g(v)`, the off-diagonal
`f(i) ≠ g(j)`; with `f, g` residue-like off `S_f, S_g`, this is a finite system on the circle and the 36 off-diagonal vertices —
G53's counting compulsion generalised from `B(f) ∩ B(g) = ∅` to the full pattern algebra. Enumerate it: which `(S_f ∩ circle,
S_g ∩ circle)` are admissible? **D3 — Kempe moves as the reconfiguration of `S`.** A Kempe swap of two colours moves the fifth-colour
set; FS-2's `kempe` instrument (M56) computes the reconfiguration graph. A frozen vertex is fixed under single-vertex recolouring;
a forced pair is constant across the whole reconfiguration space; the prior art is the reconfiguration literature (Cereceda–van den
Heuvel–Johnson 2008 and its successors; frozen colourings; Mohar's Kempe equivalence `[Mohar2006]`) — run the prior-art gate under
"reconfiguration of colourings of Cayley graphs", "frozen colourings", "colourings with one exceptional class / defective
colourings", and "chromatic number of a graph minus an independent set". **D4 — the design reading.** If D2 yields a rule "the
fifth colour must meet residue class `c` at depth `d` on the circle", then a fabric whose cross-edge web forbids that is not
five-colourable — G53's `2L > count` is the first such rule; the general rule is the algebraic object this stub is looking for, and
it is what a six-forcer over `K(√7)` would be built from.

## 4. Phases

| phase | what | cost | stop rule |
|---|---|---|---|
| PA | the prior-art gate under D3's names, two disciplines (reconfiguration; Cayley-graph colourings), before any run | half a day | anything found on frozen colourings of Cayley graphs or defect colourings of lattices is read before D1 |
| A | the fifth-colour census on the arena: regenerate a few hundred five-colourings (the interface encoder; the explicit construction; FS-43's models), compute `S_f, S_g`, their residue-class pattern and 2-adic depth profile, and the surviving four-colour forced set on `B ∖ S_f` (M56's dial) | a day | a record of the distribution of `S` by residue class and depth; "S meets every class" or "S avoids class c" is the first structural fact |
| B | D2 on the circle: enumerate admissible `(S_f, S_g)` circle patterns against the 66 constraints, and compare with the 19 circle patterns and 552 interface patterns the H2 certificate lists | a day | the pattern algebra written as a finite table; G53's `L` recomputed from it as a control |
| C | D3: the reconfiguration graph of the arena's five-colourings at the interface (Kempe moves restricted to the 163 interface vertices), components, frozen vertices, against FS-43's `Φ` | a day | agreement with `Φ` is the control; a frozen vertex not in `Φ` is a defect in one of the two instruments |
| D | derivation: the surviving-rigidity law of D1 on the bed U (M56's object, 1,953 points) with deletions of prescribed `S` — the four-colour law with an exceptional set | a day, capped | derived / not derived, stalls at … |

## 5. Registered predictions

| id | prediction | falsifier |
|---|---|---|
| P1 | on the arena, `S_f` never meets the circle in more than `count − 2L` points (G53's bound is tight) | a colouring with a larger fifth-colour set on the circle |
| P2 | the four-colour rigidity of `B ∖ S_f` at depth 3 survives for every measured `S_f` (at least 90% of the 171 depth-3 forced pairs stay forced after deletion) | a colouring whose fifth-colour set destroys depth-3 forcing — then the fifth colour is where the rigidity goes, which is itself the structural fact |
| P3 (hunch) | the admissible circle patterns of D2 form a lattice-like family described by residue classes at depth ≤ 2, not a random list | a pattern family with no residue description |

## 6. Failure and jackpot clauses

Failure: the fifth-colour sets show no residue structure at any depth and the reconfiguration graph is connected with no frozen
vertex — then five-colourings of `K(√7)`-fabric are unconstrained by the arithmetic that built the ladder, and the honest reading
is toward five for that field (the falsifier of the local–global conjecture would be a five-colouring of `K(√7)²`; this stub does
not produce one, but it would say where to look: a rule for the fifth colour that extends to the whole plane). Jackpot: a rule of
D4 that a finite cross-edge web can violate — then a fabric violating it is not five-colourable, and it is a six-chromatic
unit-distance graph over a 6-open field: HALT AND VERIFY, two encodings, the derivation written before the object is believed.

## 7. Bearing on 6, honestly

Medium-high as a frame — it is the only candidate for the algebra the 5 → 6 rung needs now that the residue mechanism is closed by
theorem — and low as work until D1 or D2 produces a statement; until then it is a reading room with one measurement (phase A) that
is cheap. It subsumes FS-2 (Kempe classes) for the field that matters.

*At FS-116's close (2026-10-03, FS116-Z2):* FS116-O1-YESLIM (held) at `k = 5`: valid five-coloured fragments on discs of every radius give
`χ_m⁰(ℝ²) ≤ 5`, hence `χ(ℝ²) = 5` with no MR — so a construction for this stub's YES need be neither a map of the plane nor periodic, only fragments on
growing discs.

## 8. Addresses

`tools/additive.py` (M56's dial and `kempe`), `tools/rigidity.py`, `tools/arena_sweep.py`, the H2 interface encoder;
`data/m53/rigidity-dial-it4.json`, `data/m62/m63-phaseH2-rho63-certificate.json`; `Proofs/HadwigerNelson/Additive.lean`,
`AdditiveRigid.lean`, `FanGap.lean`; records to `data/fs41/` with a README row per file.
