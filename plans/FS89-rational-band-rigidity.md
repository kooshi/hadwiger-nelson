# FS-89 — rational band rigidity: is every four-colour band character of the rational unit circle torsion plus archimedean?

*The subplan of milestone FS-89 (WORKFLOW 2.0 steps 3–5), written 2026-09-25 by the Stage-1 planner (de Bruijn, Opus 5.5) from the
owner's brief `data/fs89/briefs/S1-planner-brief.md` (commit 0523899f). Inputs: the next-step advisor's record
(`plans/POROS-2026-09-25-fs86-next.md` §3–§5), the stub (`plans/STUB-isometric-measure-rigidity.md`), Stage 0's two records
(`plans/FS89-S0A-gluing-verification.md`, `plans/FS89-S0B-band-set.md`), FS-86's close and derivation file, FS-81's derivation file,
`CLAUDE.md` and `LEDGER.md` from disk (CLAUDE.md at 052707ac, byte-identical to the planner's loaded copy). The close inventory is the
owner's (`plans/FS89-close-inventory.md`). The planner is this file's only writer until Stage 1 launches; after that each agent writes
only its own record.*

**Order of sections:** §0 the milestone after the reframe (read first) · §G re-grokking · §PA prior-art gate · §IQ invariant question ·
§S the subplan (stages, phases, the exact computation, the killing test, the fallback) · §C the two briefs' text · §P predictions ·
§M modeling passes · §X the planner's would-have-searched log · phase records.

## §0. The milestone after the reframe (read this first)

### 0.1 Objects, fixed once

- `ℤ[i]`; for a set `S` of rational primes `p ≡ 1 (mod 4)`, `R_S := ℤ[i][1/p : p ∈ S]`. For `p = π_p π̄_p`, `w_p := π_p/π̄_p`
  (`w₅ = (3+4i)/5`, `π₅ = 2+i`; `w₁₃ = (5+12i)/13`, `π₁₃ = 3+2i`). `U_S := ⟨i⟩ × ⟨w_p : p ∈ S⟩`, the unit vectors of `ℚ(i)` whose
  denominators lie over `S` (S0A-1's Hilbert-90 step, per prime). `ℤ[U_S] = R_S`.
- `Q := R_{all} = ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (mod 4)]` (S0A-1). It is 5-divisible; its non-split places (the ramified `(1+i)` and the
  inert `q ≡ 3 (mod 4)`) are never inverted.
- The band `B_k := [1/k, 1 − 1/k] ⊂ ℝ/ℤ`; `Θ_k(R_S) := {θ ∈ Hom(R_S, ℝ/ℤ) : θ(U_S) ⊆ B_k}`, a closed subset of the compact dual
  `R̂_S` (a 2-dimensional solenoid; connected, since `R_S` is torsion-free).
- `A` (archimedean): `λ_e(x) = Re(ē x) mod 1`, `e ∈ ℂ`. `T`: torsion characters (order prime to `S`, since `R_S` is `S`-divisible).
  `T_N`: those killed by `N`.
- **The action.** `U_S` acts on `R̂_S` by `θ ↦ θ∘u`; `Θ_k(R_S)` is closed and invariant under it, under complex conjugation and under
  `θ ↦ −θ`. Evaluation: `θ(u) = (θ∘u)(1)`, so `Θ_k` is the set of characters whose whole orbit stays in the closed set
  `{φ : φ(1) ∈ B_k}` — **Furstenberg's shape**: an orbit avoiding a fixed open set (§PA).
- **Leaves** (S0B-T2, stated there at `S = {5}`): for torsion `τ`, `τ + λ_d ∈ Θ_k` iff `|d| ≤ r_τ`, the **margin** (the least distance from
  a value of `τ` on the unit vectors to the edge of the band). So `𝓛_k(R_S) := Θ_k(R_S) ∩ (T + A)` is a union of discs `τ + D(r_τ)`.

### 0.2 The statements, sharp

| id | statement | ring, band, scope | status (grade, address) |
|---|---|---|---|
| **RQ₄** | `Θ₄(Q) ⊆ T + A` | `Q` with every split prime inverted; `[1/4, 3/4]` | **open — the milestone's target** |
| RQ₅ | `Θ₅(Q) ⊆ T + A` | `Q`; `[1/5, 4/5]` | open; implies RQ₄ (`Θ₄ ⊆ Θ₅`) (S0A C3) |
| RS_k(S) | `Θ_k(R_S) ⊆ T + A` | `R_S`, `S` finite; `T` of any order prime to `S` | `RS₃({5})` true (FS81-T3); `RS₄({5})` **false** (S0B-T3, T4); `|S| ≥ 2` open |
| MS_k(S) | every `U_S`-minimal closed subset of `Θ_k(R_S)` lies in `T + A` | as RS | open at every `S`; the planner's name for Berend's MT property modulo the isometric direction (§PA) |
| N₀ | `Θ₄(Q) ∩ (T + A) ⊆ T₁₆₈ + A`, the torsion part pure of one type (2-part of order ∣ 8, order 3, or order 7) | `Q`, `[1/4, 3/4]` | hand, one mind (S0A-3) |
| EQ | RQ_k ⟺ `Θ_k(R_F) ⊆ T + A` for every subfield `F ⊆ ℝ` | every band | hand, one mind (S0A-10) |
| C-HD1 | RQ₄ ⟹ HD1 (`Θ₄(R_F) ⊆ T`) for ℚ(√59), ℚ(√83), ℚ(√131) | | hand, at FS86-dB-Theta's grade (S0A-6) |
| C-47 | RQ₄ ⟹ `Θ₄(R_{ℚ(√47)}) = ∅` | | hand, given Lemma R and Weil (S0A-8) |
| C-167 | RQ₅ ⟹ `Θ₅(R_{ℚ(√167)}) = ∅` | | hand + cert (S0A-9) |
| FT | every finite-type band character of `Q` is in `T + A`, at bands 1/4 and 1/5; **a counterexample to RQ must read infinitely many split places** | | hand (S0A-11 = FS86-dB-Sv at `F = ℚ`) |

**Scope, stated once, and not to be widened in any brief.** RQ is about **character** colourings only. A proof of RQ₄ excludes every
colouring of the form `x ↦ ⌊4θ(x)⌋` as a falsifier of the conjecture at ℚ(√47) (C-47); it says nothing about `χ(ℚ(√47)²)` itself, and
nothing about non-character colourings (G71: at four colours emptiness of `Θ₄` is one-sided). A counterexample to RQ₄ is a band
character of `Q`; it is a **seed** of a falsifier at ℚ(√47), not a falsifier: a character of `Q` is not a character of `R_{ℚ(√47)}`.

### 0.3 Consequences restated here that are NOT verified (the verifier's to check; owner's lesson, inventory item 15)

- **U1 (the layering lemma, the planner's):** "if `RS₄(S)` holds for every finite `S ⊇ S₀` (some fixed `S₀`), then RQ₄ holds." Reason
  offered: restrictions to `R_S` of a band character of `Q` are band characters; the archimedean parts agree by 5-divisibility (S0A-2's
  `T ∩ A = 0`); what is left is a character of `Q` that is torsion on every `R_S`, and a Lemma-N₀-type weak-approximation argument should
  bound its order. **The last step is the unverified one**: torsion on every `R_S` does not obviously mean torsion on `Q`. Not usable as
  a step until V checks it.
- **U2 (the explicit list, the planner's reading of N₀ + S0B-T2):** "`Θ₄(Q) ∩ (T + A)` is exactly the finite union of leaf discs over
  the band torsion characters of `Q/168Q`, with margins `1/4` (parity), `1/12` (the order-3 types), `1/28` (the order-7 types) and `0`
  (the order-4 and order-8 types)." So **RQ₄ is the statement `Θ₄(Q) = 𝓛₄(Q)`, an explicit compact set.** The type list is S0A-3's; the
  margins at `Q` (whose unit circle is dense at every non-split place) are the planner's transfer of S0B's table (whose ring was
  `R₅`) and are not checked.
- **U3 (the planner's):** "`RS₄({p})` fails for every single prime `p ≡ 1 (mod 4)`, by S0B's lens (the parity and order-3 discs meet,
  `√2/6 < 1/4`, independently of `p`)." Only `p = 5` is proved (S0B-T3).
- **U4 (S0B §6's reading):** "13 kills the infinitely-switching family", so `RS₄({5, 13})` might hold. One mind, a reading.
- **U5 (the advisor's, S0A D8):** "one prime is not enough even with no 5-adic points: torsion orders are unbounded at one prime." Two
  minds' reading (S0A, S0B), unproved; S0B-L4's list (145 characters of 12 orders below 130) is a finite measurement.

### 0.4 What the reframe changed (the headline; details in §G.6 and §IQ)

1. **The target has a home, and the home names the obstruction exactly.** Furstenberg's closed-set theorem (×2×3) and Berend's
   generalisations (tori 1983, compact abelian groups 1984, minimal sets 1984) require every eigen-direction to be expanded by some
   element. At the archimedean place every unit vector is a rotation, and **Berend's own Lemma 3.1 (Minimal sets on tori, 1984; read in
   full at this gate) shows that such a direction always carries non-torsion minimal circles** — precisely our archimedean leaves
   `τ + {λ_e : |e| = r}`. So the right statement is **Berend's rigidity modulo the isometric direction**: minimal sets inside `T + A`
   (MS), then every band point (RS/RQ). Berend's sufficiency proof (Prop. 4.1) has a two-case structure whose second case uses an
   element contracting the whole weakly-contracting subspace strictly; with isometric directions it yields instead "periodic modulo the
   archimedean leaf", i.e. `T + A`. **That is a route, not a proof**, and it is the first item in D's Stage 1a (§S.2).
2. **Minimal sets and points are different questions, and Stage 0's counterexample lives between them.** S0B's heteroclinic `θ*` is not
   minimal: its orbit closure contains two leaves. A Berend-type argument naturally reaches minimal sets; excluding heteroclinic and
   switching points is a separate step (S0B-T6 did the rational part at 13). The plan splits RS into MS plus "no connection between
   leaves".
3. **The first question is rank two** (`S = {5, 13}`), the smallest case where Furstenberg's multi-parameter condition holds; the
   all-primes statement RQ₄ is the second, with weak approximation (N₀'s tool) as its extra lever, joined to rank two by U1.
4. **The torsion-order question at one prime is demoted**: over `Q` the order bound is automatic (N₀), so U5 bears only on the form of
   finite-rank statements. It becomes an optional side question with its prior art named (§PA: dilates of small multiplicative subgroups
   avoiding an arc; gcd bounds for two multipliers).
5. **The vocabulary for the briefs**: algebraic `ℤ^r`-action on a solenoid, non-expansive (the characteristic variety meets the unit
   torus at the archimedean place), homoclinic/heteroclinic points (Lind–Schmidt), orbit closures and minimal sets (Berend), and the
   adelic form (Haynes–Munday). A counterexample-side analogue exists in print: Maucourant (Annals 2010) builds non-homogeneous orbit
   closures for diagonal toral endomorphisms when a rank-one factor is present — "a proper closed invariant set is not necessarily a
   subset of a finite union of rational affine tori" (reviewer's review).

## §G. The re-grokking (WORKFLOW 3.1)

*Walked with `CLAUDE.md` (052707ac) and `LEDGER.md` open, entry by entry, rows individually (FS-86's close logged its block walk of
the rows as a defect; not repeated). Verdicts: **B** bears (where it lands), **S** silent (why), **F** falsifiable here (registered in
§P). Landing codes: →0 §0; →IQ; →D the derivation agent's brief; →V the verifier's brief; →S.n a phase; →P; →R the close.*

### G.1 The grokkings

| id | v | reason, and where it lands |
|---|---|---|
| G1 | S | the 4/5 wall is a statement about real fields; `Q` is field-free, and the wall enters only through the consumers C-HD1 (wall standing) and C-47 (wall broken), already derived at S0A |
| G2 | S | construction grammar of built witnesses; nothing is built |
| G3 | S | witness radii |
| G4 | S | five-forcer shell inventory |
| G5 | S | the 1581's 1-sum |
| G6 | S | hexagram as fabric |
| G7 | B | a real field's unit vectors are layers `b·U_ℚ` rotated by the type-M `v_n` (radicand `4n−1`); the consumers' layers (ℚ(√59): `n = 15`) are these; the rational rotations `w_p` are the family's split-prime analogues. →D (vocabulary of layers) |
| G8 | S | K's direction group |
| G9 | S | forced pairs over K at dyadic depth |
| G10 | S | sampled criticality |
| G11 | S | Moser-free forcers; nothing forced here |
| G12 | S | one detune's conic |
| G13 | S | fan gaps free pairs; no pair question at the character level |
| G14 | S | matchings |
| G15 | S | pigeonhole × kill is about finite forcers |
| G16 | S | distance-2 pigeonhole over K |
| G17 | S | carrier sizes of sub-rung compulsions |
| G18 | S | composition of solver runs; no solver |
| G19 | S | five-tight fabric |
| G20 | S | brick colourings |
| G21 | B | (i) **a finite configuration measures its depth** (FS81-T8): any finite-window count (§S.4's 2-D window) reads its depth, so its killing test compares growth rates against a control at the same depth, never a count against zero; (ii) a positive control proves only shapes the generator represents: the window's generator must be able to express a 2-D switching array before its zero means anything; (iii) FS-86's instance: **quote statements verbatim in briefs** (§C does); (iv) audit the results you like: a proof of RQ₄ gets the same blind check as a counterexample. →S.4, C, P |
| G22 | S | six-colourings of the plane |
| G23 | S | cell-family scale |
| G24 | S | integrality gap of the cell family |
| G25 | S | recursive forcing ladder |
| G26 | S | the 6-forcer reduction |
| G27 | B | hidden symmetry: `Θ_k` is invariant under complex conjugation (`b₊ ↔ b₋`, S0B §6), negation and the `U`-action; a brief should hand D this symmetry group so every classification is up to it. →D |
| G28 | S | fine-tail forcing |
| G29 | S | cell family closed |
| G30 | B | derivation kills: every theorem ships an inhabitant (MS/RS hypotheses at `|S| ≥ 2` are inhabited: `S = {5, 13}`); failure mode 6 (an instance recorded where a theorem is available: state RS for every `S` with `|S| ≥ 2`, `{5, 13}` as the instance); **the discipline ladder: this milestone enters topological dynamics (Furstenberg–Berend) and algebraic `ℤ^d`-actions (Schmidt)**, unentered so far. →PA, D |
| G31 | S | no held witness is mined |
| G32 | S | two-distance dial |
| G33 | S | batch descent |
| G34 | S | in-field descent |
| G35 | B | `Q` never inverts 2 (ramified in `ℤ[i]`), so the dyadic place is stable and carries the 2-power torsion of N₀ (order ∣ 8); the wall reading does not enter. →0 |
| G36 | S | residue floor over K |
| G37 | S | the endgame of a descent |
| G38 | B | the torsion part of any leaf is an additive (coset) colouring, and the additive family's counts (2, 3, 4, then nothing below 7) are the leaf types' orders (2, 4, 8, 3, 7) with archimedean slack; RQ₄ says the band set is the additive family thickened by its margins. →0 (U2), D |
| G39 | S | critical sets |
| G40 | S | absorption |
| G41 | B | the known band points are the positive controls of any classification: parity, `(x+y)/4`, `(3x+2y)/8` (the 2-adic analogue of Fischer's ℤ/4 map, local at 2), the order-3 and order-7 characters; every claimed classification must contain each, and a claimed counterexample must be checked not to be one of them in disguise (N₀'s purity). →V (V-A2), D |
| G42 | S | additive rigidity gauge |
| G43 | S | residue planes seal fields: used by the consumers C-47, C-167 (derived at S0A), not by RQ |
| G44 | B | Weil/Kloosterman: `Tr(at)/q` on `μ_{q+1}` is equidistributed, the tool behind N₀'s level collapse and the five-band finiteness of `N`; any D argument about torsion at inert places reuses it. →D |
| G45 | S | residue lifting |
| G46 | B | recognise the classical theory first: the object is a closed invariant subset of a solenoid under an algebraic `ℤ^r`-action with an isometric (non-expansive) archimedean direction; **and read the construction's own data layout**: S0B's orbit model (`tools/fs89_s0b_orbits.py`) is the layout D should extend to rank two. →PA, IQ, D |
| G47 | S | residue compulsions at level one |
| G48 | B | the conjecture: C-47 and C-167 exclude character falsifiers; they never confirm χ; a finite refusal only confirms. **Register honestly: an RQ theorem is not "χ(ℚ(√47)²) = 5".** →0, P |
| G49 | B | the gate itself; the zbMATH author listing (Berend: 149 entries) and the discipline's words found the minimal-sets paper and the adelic paper (§PA). →PA |
| G50 | B | read what the search found: Berend 1984 (ETDS, minimal sets) read in full; TAMS 1983/1984 not fetchable by script (debt recorded, §PA.3); D reads Berend's Prop. 4.1 before deriving. →PA, D |
| G51 | B | Kooshi's shape (one agent + blind verifier) is G51's "verification is where contest must begin"; its standing rules go into both briefs: content-free hand-backs, working files in scratch until a claim is saved, neutral commit subjects, work in stages, statements quoted verbatim, the owner tells each agent of the other's stand-down. →S.2, C |
| G52 | S | wall-breaking sufficiency for rotations |
| G53 | S | counting compulsion |
| G54 | B | `Q` has no tight place, which is why RQ's conclusion is `T + A` and not torsion; tightness enters only in the consumers (dB-Theta at the dyadic place). →0 |
| G55 | B | prime inversion at `F = ℚ`: `Q` inverts exactly the split primes (S0A-1 is G55's instance); the chain theorem is silent. →0 |
| G56 | B | the parity leaf is G56's ramified-2 two-colouring of the rational plane (Woodall), the largest leaf (margin 1/4); S0B's lens is the order-3 leaves sitting inside it. →0, D |
| G57 | S | window planes' cliques; consumers only |
| G58 | S | antipodal conjecture |
| G59 | S | the wall at six; the five-band consumer's certificates (23, 43) are already cited by S0A-9 |
| G60 | B | the invariant-measure engine is the **measure** side; this milestone is the **closed-set** side (inventory item 4): minimal sets and orbit closures, not measures, are the objects. →IQ, D (vocabulary) |
| G61 | B | "the rational directions are load-bearing": RQ is exactly the rational layer at four colours, and the three-colour theorem read it at one prime; the four-colour layer needs every prime (S0A-12). →0 |
| G62 | B | multilayer: `U_F` is a union of layers `b·U_ℚ`; the gluing (S0A-2) reads each layer on its rational line. →0 |
| G63 | S | transcendence |
| G64 | B | a character colouring is one instrument in the gap between `L(F)` and `χ(F²)`; RQ₅ would close the character part of that gap at ℚ(√167) at five colours, nothing more. →P |
| G65 | S | solver phase diagram; no solver runs |
| G66 | B | the odometer frame: torsion characters are the periodic colourings of character type, `T + A` their archimedean thickening; the "carry" warning (instruments blind to the carry) applies to any argument that works level by level at an inert place. →IQ |
| G67 | B | the close owes G76 a rewrite in closed-set language with its *Do* and killing test, and any new grokking in that form. →R |
| G68 | S | quotient colourings of lattices |
| G69 | S | lattice rigidity by quotients |
| G70 | S | √3-clean colourings on the Moser lattice |
| G71 | B | at four colours there is no height, so RQ is about character colourings only and its emptiness-type consequences are one-sided (§0.2's scope line). →0, P |
| G72 | B | the invariant question (§IQ); G72's count is scored at the close. →IQ, R |
| G73 | B | a proof of RQ₄ would be a structure-derived certificate in G73's sense (a classification of every band character), not an averaged one; Poros's reading that "arithmetic cannot enter an averaged certificate as a residue label" is not tested here. →IQ |
| G74 | **F — fired at Stage 0** | the precedent: classify the rational layer at the band, glue by relations. Its reading "the rational layer's rotation set is always a disc plus finitely many torsion points", killing test "T40's cells at `[1/4, 3/4]` holding a third kind of cell", **fired at one prime** (S0B: heteroclinic and Cantor families). At the full rational ring the reading is RQ₄ itself. →P, R (G74's reading owes a demotion record at the close) |
| G75 | B | Coxeter's R2.6 reading (triangle-free frequencies generically non-torsion) concerns lattice frequencies; the rational plane is triangle-free, and RQ₄ true would be a triangle-free rigidity of the character spectrum **modulo the archimedean part**. Registered as a side reading in §P, not as a test of R2.6. →P |
| G76 | B, F | the obstruction (both FS-86 competitors, independently), to be rewritten in closed-set language (inventory item 4); "a no must read infinitely many split places" is FT; its reading "the obstruction is the real place" gets evidence from the **mechanism** of any counterexample: S0B's lens is exactly the real place's discs overlapping. →0, IQ, P, R |

### G.2 The ledger rows (mechanism, one line each)

| # | v | reason |
|---|---|---|
| 1 | S | two-circle 3-colourability: rings about a pivot |
| 2 | S | seam rotation σ over K |
| 3 | S | coverage monotonicity |
| 4 | S | fan ⟺ coverage |
| 5 | S | class confinement |
| 6 | S | 120° triangle identity |
| 7 | S | greedy colouring |
| 8 | S | balanced 5-colouring of the 1581 |
| 9 | S | 120° compulsion on two circles |
| 10 | S | one-pivot cap |
| 11 | S | strip automaton |
| 12 | S | extension profile (tools) |
| 13 | S | negative knowledge of M17–M19 |
| 14 | S | pair-gluing classification |
| 15 | S | extension pressure (tools) |
| 16 | S | coupled automaton dead |
| 17 | S | circle intersections |
| 18 | S | a near-relation in the seam group |
| 19 | S | kill mechanism, partner webs |
| 20 | S | pivot-triangle layer |
| 21 | S | coupling statistics |
| 22 | S | matched ladder pair, 4-chromatic |
| 23 | S | four-ladder object |
| 24 | S | hexagram |
| 25 | S | field-wall identity ρσ² = −1 |
| 26 | S | de Grey anatomy |
| 27 | S | quadrature law (tools) |
| 28 | S | 2-adic kill engine |
| 29 | S | stacking law |
| 30 | S | mechanism hunt |
| 31 | S | Act One carriers |
| 32 | S | hex-shell pigeonhole, bricks |
| 33 | S | the classical interval |
| 34 | S | coset chromatic number 7 |
| 35 | S | coarse cells |
| 36 | S | scale non-monotone |
| 37 | S | gap atlas (tools) |
| 38 | S | gradient hunt; Galois automorphisms (G27 carries the lesson) |
| 39 | S | gap atlas, kernel |
| 40 | S | fine tail |
| 41 | S | limit lemma |
| 42 | S | arity floor |
| 43 | S | de Grey bracketed; the six-target |
| 44 | S | two-distance dial, spindle theorem |
| 45 | S | batch descent |
| 46 | S | copy unions |
| 47 | S | M53's residue obstruction over K |
| 48 | S | critical-set localisation |
| 49 | S | absorption |
| 50 | B | the additive yardstick: every torsion leaf is an additive colouring; the additive family is the positive-control list for any classification of `Θ₄(Q)` (G41). →V |
| 51 | S | additive rigidity gauge |
| 52 | S | the finite-plane bound; used by consumers only |
| 53 | B | Kloosterman eigenvalues / Weil at `p ≡ 3 (4)`: the tool for level collapse at inert places (G44). →D |
| 54 | S | lifts modulo p² |
| 55 | S | residue obstruction for pairs |
| 56 | S | local–global tightness; `addCayleyMap` |
| 57 | B | Theorem A: a character to a finite group, nonzero on the unit vectors, colours the plane; every torsion band character is a Theorem-A colouring through a finite quotient of `Q`. →0 |
| 58 | S | Moser recipe threshold |
| 59 | S | the 2-adic law of compulsions over K |
| 60 | B | plane freedom: rotation by a circle point is an automorphism; this is the `U`-action on `R̂` that makes `Θ` invariant. →0 |
| 61 | S | statements at proof level (six-target) |
| 62 | S | overcompression |
| 63 | B | two colours from inertia: the parity leaf is the rational plane's ramified-2 two-colouring. →0 |
| 64 | S | ρ₆₃ arena |
| 65 | S | dropping Parts's coordinate shape |
| 66 | S | fan gap, sealed fields |
| 67 | S | the 2-adic tower of K(i); consumers only (dB-Theta) |
| 68 | S | six refused at 83 |
| 69 | S | the window for six |
| 70 | S | five refused at 27 |
| 71 | S | fractional colourings of fields (the measure side, G60) |
| 72 | S | 3-adic barrier over ℚ(√d) |
| 73 | S | ℚ(√11), ℚ(√23) need four |
| 74 | S | the census of real quadratic fields |
| 75 | S | the tower does not drop at 7–23; the consumers need level one only (S0A-9) |
| 76 | S | ℚ(√3,√5) lattices |
| 77 | B | the theorem audit's rule: every phase record carries "Theorems this phase proved". →C |
| 78 | S | de Grey's lattice `F = P = 8Λ` |
| 79 | B | three colours are linear: `Θ₃` criterion (FS73-T22), density of periodic colourings, `F` of finite index iff every cell is a point; the band-set framework this milestone lives in. →0, D |
| 80 | B | four colours have no height and no linear criterion: RQ is about characters only (G71). →0 |
| 81 | S | `L21cc6506` loose (ℚ(√167) at four colours); a lattice statement, not a ring statement |
| 82 | B | T4 by the layer relation: the gluing precedent (a finite-order layer character glued through `5^{−k}`). →0, D |
| 83 | S | census certificates |
| 84 | B | ℚ(√47)'s four-colour bracket and priced refusal: C-47 is the character-level exclusion this milestone can add there; its scope stays characters. →0, P |
| 85 | S | de Grey's lattice derived (annihilator method); a lattice periodicity theorem, not a ring one |
| 86 | S | triangle-free abstract rigidity, Soifer 55.1; RQ does not cross to the plane (only a "yes" to a forced pair would) |
| 87 | S | what does not reach 8Λ |
| 88 | B | the type-(B) frame: `F(R) ∈ {0, P(R)}`; C-HD1's consumer. →0 |
| 89 | S | K's classification (two tight places) |
| 90 | S | the local plane over ℚ₂(√3) is rigid; consumers only |
| 91 | B | the no-go family on type-(B) planes; HD1 ⟺ a finite certificate (dB-HDcert); finite-type characters are pullbacks (dB-HDfin). The post-ban route if Stage 1 stalls. →S.6 |
| 92 | B | measurable windows over finitely many places cannot colour type-(B) planes non-periodically; CL1 at 47, 167; "a no must read infinitely many places" (FT's field form). →0 |
| 93 | S | dyadic towers containing √3 |
| 94 | B | ℚ(√11)'s explicit non-periodic colouring `(2x+3y)/7 + ℓ` is the order-7 leaf of `𝓛₄(Q)` pulled to a field with a stable 7; Theorem C (averaged rigidity on `T + A + Fin` for non-real analogues). →0 (U2's positive control), IQ |

### G.3 The method rules (§ Grokkings [method], § Toolchain, § Building, § The gate, the standard of evidence, § Delegation)

| rule | v | reason |
|---|---|---|
| the finite-witness-free week (to 2026-10-01) | B | no SAT, finders, Θ trees, quotient searches, sweeps; §S.4's 2-D window is admitted only as an exact computation whose shape a derivation fixes first, bounded in hours (the brief; item 2's ruling). →S.4, C |
| the "would have searched here" log | B | in both briefs and §X |
| no child spawns children | B | in both briefs, with its reason |
| staffing: at most three agents | B | Stage 1 fills two slots (D, V); the planner's slot frees at hand-back |
| replace an agent above ~500k tokens | B | budgets in §S.3 set below it |
| work in stages (FS-86 lost three responses to the output-token limit) | B | both briefs; each stage ends in a saved file |
| quote statements verbatim in briefs (G21, FS-86) | B | §C quotes §0.2's statements |
| the checkpointing rule [PROTECTED] | B | every phase names its checkpoint (its record file, saved per section) and its resume command (§S.3); the 2-D window checkpoints per depth |
| a blocking run is presumed killable [PROTECTED] | B | the 2-D window is the only run; it is killable at any depth boundary (§S.4) |
| kill by PID or process group, verify by effect | B | the 2-D window's launch line (§S.4) |
| `scripts/slot.py` for jobs over ~2 GiB or ~2 min; /tmp is RAM | B | the 2-D window runs under a slot, output to `data/fs89/s1d/` |
| never `lake build`; `./scripts/build.sh` under a slot | S | Stage 1 writes no Lean |
| symmetry-break before any SAT | S | no SAT |
| Python 3.14 forkserver default | B | if the 2-D window tool uses a pool, pass the fork context (§S.4) |
| never edit a running shell script; pipes and exit statuses | B | the window's driver is Python; its exit status read directly, never through a pipe |
| frozen tools (FS-58/61/66/73 checkers) | B | not touched; `tools/fs89_s0b_*.py` may be imported, never edited |
| negative controls: watch every check fail | B | the 2-D window carries a planted fault and two positive controls (§S.4); D's exact band checks carry an out-of-lens plant as S0B's did |
| state the uninformative outcome and confirm both outcomes reachable | B | §P lists the uninformative outcome and checks each outcome's reachability |
| one thing differs between two compared numbers | B | the window's growth is compared to the 1-D count at the same depth and to the three-colour 2-D control at the same depth |
| a positive control proves only the generator's shapes | B | the 2-D window's generator must represent a switching array (its 1-D slice reproduces S0B's switching prefixes) before its count is read |
| a caveat you write and step over | B | §0.2's scope line is quoted into both briefs and into §P's outcome rows |
| measured vs derived halves fail in opposite directions | B | a claimed counterexample array is derived (the suspect verdict is its existence); a claimed proof's suspect step is where it uses density |
| the standard of evidence above rung B | S | nothing here is a claim of `χ ≥ 6` |
| commits by explicit path; never amend; don't push | B | both briefs |
| G21 selection: audit the results you like | B | V checks a proof of RQ₄ with the same blindness as a counterexample |
| G30 failure modes 5–7 | B | every theorem ships an inhabitant; `|S| ≥ 2` inhabited at `{5, 13}` |
| G46 recognise the classical theory | B | §PA |
| G49 / G50 prior-art gate; read what the search found | B | §PA |
| G67 grokking form | B | any grokking minted at the close carries *Do* and a killing test |
| G72 invariant question | B | §IQ |
| the kernel's cost model; searching (`ugrep`); what compute helps | S | no Lean, no large search |
| two machines; name the machine beside a number | B | the window's timings name the desktop |

### G.4 The nearest derivations, individually

| id | v | reason, and where it lands |
|---|---|---|
| S0A-1 (G0: `Q = ℤ[i][1/p : p ≡ 1 (4)]`, layers, restriction) | B | the ring and the restriction map every stage uses. →0 |
| S0A-2 (G1, the gluing, every band, any `F ⊆ ℝ`) | B | reduces every field statement to RQ; its proof reads only `ℤ[1/5]` per layer. →0 |
| S0A-3 (Lemma N₀, `N = 168`) | B | makes the torsion order automatic over `Q` and supplies the leaf list (U2). One mind: V re-derives it blind as part of V-A2. →V |
| S0A-4 (level collapse at stable places) | B | the weak-approximation mechanism D's all-primes route reuses (C3's natural attack). →D |
| S0A-5 (no unbounded layer orders; the 3-adic adversary fails) | B | the model for how a would-be counterexample dies: a coset sweep leaves the band. →D |
| S0A-6 (C-HD1) | B | consumer; its grade is FS86-dB-Theta's. →0 |
| S0A-7 (archimedean averaging over a real number field) | S | a consumer-side step (C-167) |
| S0A-8 (C-47, general form) | B | consumer. →0, P |
| S0A-9 (C-167) | B | consumer; RQ₅'s reason to exist. →0, P |
| S0A-10 (EQ) | B | RQ is the uniform statement; no easier field to try first. →IQ |
| S0A-11 (FT) | B | a counterexample reads infinitely many split places; so any counterexample to RS at finite `S` is not yet one to RQ (the extension question, §S.5). →0, D |
| S0A-12 (one-prime `T + A` cannot bound `N`) | B | why RS at finite `S` allows torsion of any order prime to `S`, and why U1 is needed. →0 |
| S0A-13 (Weil check to 83) | S | numerical support of C-47 |
| S0A reading (infinitely many torsion types at one prime) | B | U5; demoted to a side question (§0.4 item 4). →S.2 (optional D-3) |
| S0B-T1 (the orbit model, `e_{m+1} − w̄e_m ∈ π⁻¹ℤ[i]`) | B | the layout to extend to rank two: arrays `e_m`, `m ∈ ℤ^S`, one step rule per prime. V-A4 derives the rank-two form blind; it fixes the 2-D window's shape. →V, S.4 |
| S0B-T2 (leaves, margins, `T + A` = diagonal-rational 5-adic data) | B | the criterion "`T + A` ⟺ the split data are one global element"; its rank-`r` form is part of V-A4. →0, V |
| S0B-T3 (the heteroclinic `θ*`) | B | the object any rank-two argument must kill (U3/U4); D's first test case. →D |
| S0B-T4 (forward/backward leaves differ ⟹ not `T + A`) | B | the proof pattern for "not `T + A`" in any counterexample. →D |
| S0B-T5 (the switching family, Cantor fibre) | B | the object S0B-T6 does not reach; U4's subject; its extension to rank two is D-1b's question. →D |
| S0B-T6 (13 kills rational heteroclinics prime to 13) | B, F | one mind, derived; V re-derives it blind (V-A3); a failure would re-open the rational heteroclinics at rank two. →V, P |
| S0B-C1 (positive control on two code paths) | B | the 2-D window's controls copy it (three colours stays at 5 pieces). →S.4 |
| S0B-L4 (145 torsion characters, 12 orders below 130) | B | U5's evidence; at the ban's edge (inventory item 17); not extended by this plan. →X |
| FS86-dB-Theta (T + A band characters on type-(B) planes are pullbacks) | B | the last step of C-HD1. →0 |
| FS86-Cx-C10 = dB-HDfin (HD1 for finite type) | B | FT's field form; the finite-type case is closed everywhere. →0 |
| FS86-dB-Sv (split part of a `T + A + Fin` band character is zero) | B | S0A-11's source; the sweep argument D reuses. →D |
| FS86-dB-HDint (split parts defined only modulo global elements; some character has no finitely-split representative) | B | the reason RQ's counterexamples are subtle: "reads infinitely many split places" is intrinsic, not a representative's artefact. →D, IQ |
| FS86-dB-HDcert (HD1 ⟺ a finite exact certificate) | B | the post-ban alternative route to C-HD1's conclusion; semi-decidable. →S.6 |
| FS86-Cx-C15 (algebraic invariant sets/measures in `Θ₄` are torsion) | B | the homogeneous (algebraic) part is handled; RQ concerns non-algebraic closed sets. At `Q` the analogue should read "a `U`-invariant coset of a closed subgroup inside `Θ₄` lies in `T + A`". →D |
| FS86-Cx-C14 (measurable windows over finitely many places are pullbacks) | S | a no-go about windows at finitely many places; FT is its character analogue |
| FS86-CL1 (type-(A) corollary) | B | C-47's measurable-window neighbour; C-47 excludes characters over infinitely many places, CL1 windows over finitely many. →P |
| FS81-T3 = C1(5) (`Θ(U₅)` at three colours: parity disc ∪ `X₃`) | B | RS₃({5}); the positive control of every model (S0B-C1). →S.4 |
| FS81-T4 (layer torsion `τ = lim θ(25^{−k}·)`) | B | the ancestor of S0A-2's limit lift. →0 |
| FS81-T5 (five layers suffice; `1/3 ∈ ℤ[U]` refuses three) | S | three-colour field theorem; the four-colour analogue is C-47, conditional on RQ₄ |
| FS81-T8 (the finite threshold; configuration A nonempty at `d ≡ 11 (mod 24)`) | B | "a finite configuration measures its depth" (G21): the 2-D window's reading must not confuse depth with rigidity. →S.4 |

### G.5 `LEDGER.md` § B and the other derivation files, by block (bearing lines individually)

| block | v | reason; bearing entries named individually |
|---|---|---|
| M18–M64 (and M63's sub-phases), R52–R59, Q8, MASCOT | S | constructions, compulsions and arenas over K and its extensions; no character-classification content. Checked for a torus or orbit-closure statement: none |
| ASTRA (2026-09-14): prime inversion, the chain theorem, the two- and three-colour classifications | B | prime inversion at `F = ℚ` is S0A-1; the three-colour classification's rhombus step does not transfer (no √3 in ℚ). →0 |
| FS-25, FS-32, FS-36, FS-39, FS-50, FS-53, FS-54, FS-62 | S | wall certificates, reduction duality, plane bridge; FS54-T11 (Fourier energy on the least eigenspace) is a finite-plane statement |
| FS-38 (D2-A tightness, L1, L2) | S | tightness at a dyadic place; `Q` has none (G54) |
| FS-56 (the blow-up, geometric fractional colourings) | S | measure/fractional side (G60) |
| FS-58, FS-61 (3-adic barrier, census) | S | three-colour lattice work |
| FS-66 (fibre-share inequality; Theorem E, "the carry") | B | FS66-E: a tower over a ring containing its residue field is impotent — the warning that arguments blind to the carry prove too much; any level-by-level argument D makes at an inert place must say where the carry enters. →D |
| FS-70 (quotients, Kempe screens) | S | lattice rigidity by quotients |
| FS-73 | B | **T22** (`Θ₃` criterion), **T23–T24** (tight directions affine; density of periodic colourings), **T38** (`F ⊆ F_μ ⊆ F_meas ⊆ F_clopen = P`: the Furstenberg correspondence and the odometer), **T40** (the rational pattern's cells at three colours) — the framework and the three-colour precedent. →0, IQ, D |
| FS-79 | B | **T10** (circular forms `⌊4{φ}⌋` are `Θ₄` points: a band character *is* a circular four-colouring), **T33, T38, T44** (full-dimensional `Θ₄` cells give looseness; a lattice statement), **T39** (a rational `Θ` point separates by a periodic colouring). The circular-colouring vocabulary for §PA. →PA |
| FS-81 | B | T1 (pull-back lemma: restrictions are band characters), T2 (inverse limit), T3, T4, T5, T8 (§G.4). →0 |
| FS-85 | S | de Grey's lattice: annihilators, stripes, tight quotient; lattice periodicity |
| FS-86 | B | B1-LR (Lemma R), LP (Lemma P), dB-Theta, Cx-C11 (annihilator ideal ⟺ `F ≠ 0`), dB-HDint, dB-HDfin, dB-Sv, dB-HDcert, Cx-C15, Cx-C9, dB-C (Theorem C on `T + A + Fin`) — §G.4. →0, D |
| FS-89 Stage 0 (S0A-1–13, S0B-T1–T6, C1, L4) | B | §G.4, individually |

### G.6 What the re-grokking changed in the plan

- **Added:** MS (minimal sets) as a separate statement and D's Stage 1a first item (G46, G60, §PA's Berend Lemma 3.1 and Prop. 4.1).
- **Added:** V's fixed list V-A (U1, U2 with N₀, S0B-T6, the rank-two orbit model) before any of D's claims exist (G51, G21, S0A-3 and
  S0B-T6 being one mind each).
- **Ordered:** rank two before all primes (G30's discipline ladder: Furstenberg's multi-parameter condition first), with U1 as the join.
- **Demoted:** the torsion-order question at one prime to an optional side question (N₀ makes it irrelevant to RQ).
- **Constrained:** the 2-D window's reading (G21, FS81-T8): growth compared at equal depth to the 1-D count and to the three-colour 2-D
  control, never a count against zero; the generator's image checked against a switching array first.
- **Registered:** G74's reading as fired at one prime (a demotion owed at the close); G76's reading tested by the mechanism of any
  counterexample; G48's and G71's scope lines in every outcome row.
- **Nothing in the corpus bears on the Furstenberg step itself**: no grokking or row holds a closed-set rigidity argument. That absence
  is what §PA fills and what D's first stage is for.

## §PA. The prior-art gate (WORKFLOW 3.2)

### PA.1 The object named in its disciplines' words

1. **Topological dynamics (Furstenberg–Berend):** `Θ_k(R_S)` is a closed subset of the compact abelian group `R̂_S` (a 2-dimensional
   `S`-adic solenoid), invariant under a commutative group of automorphisms (multiplication by `U_S ≅ ⟨i⟩ × ℤ^{|S|}`); it is the set of
   points whose orbit avoids the open set `{φ : φ(1) ∈ (−1/k, 1/k)}`. Furstenberg's ×2×3 theorem is the case of the circle with the
   semigroup `⟨2, 3⟩`: an orbit that avoids an open set is finite (torsion). Berend's conditions: irreducibility, **hyperbolicity** (every
   common eigen-direction expanded by some element) and **multi-parameter** (two rationally independent elements). Ours fails
   hyperbolicity at the archimedean place only.
2. **Algebraic `ℤ^d`-actions (Schmidt's school):** `R̂_S` is the dual of the module `R_S` over the Laurent ring in `|S| + 1` variables
   (`x_p ↦ w_p`, `y ↦ i`); the action is **non-expansive**, because the characteristic variety meets the unit torus (at the complex
   place every `|w_p| = 1`). S0B's `θ*` is a **heteroclinic point** in Lind–Schmidt's sense (asymptotic to one leaf forward, another
   backward).
3. **Circular colourings / character sums (graph theory, G74):** a point of `Θ_k` is a circular `k`-colouring of the rational
   unit-distance graph on `R_S` given by a character (FS79-T10); the question is the classification of such colourings.
4. **Harmonic analysis:** `Θ_k` is a Bohr-type set of characters (every `u ∈ U` sent into an arc); FHK 2025's "sets of Bohr recurrence" for
   non-lacunary semigroups are the complementary (return-near-zero) shape.
5. **Number theory (side question U5):** band torsion characters of order `N` at one prime are dilates of the small subgroup
   `⟨i, w₅⟩ mod N` avoiding an arc; the two-prime analogue needs `w₅` and `w₁₃` of small order simultaneously (gcd bounds for two
   multiplicatively independent numbers).

### PA.2 Queries (zbMATH Open API unless marked; hit counts as returned; review vs author summary marked)

| # | query | hits | what it returned (review = a reviewer's review; summary = an author's summary, a claim) |
|---|---|---|---|
| 1 | `au:"Berend, Daniel"` (item 8: the full author listing) | 149 | 0532.10028 *Multi-invariant sets on tori* (1983, review); 0523.22004 *… on compact Abelian groups* (1984, no text); **0563.58020 *Minimal sets on tori* (ETDS 1984, review)**; 0623.10038 *Dense (mod 1) dilated semigroups of algebraic numbers* (JNT 1987, review: a p-adic analogue included); 0579.22008 *Ergodic semigroups of epimorphisms* (1985); 0721.11025 *IP-sets on the circle*; 0728.11037 Berend–Peres |
| 2 | `ti:"Disjointness in ergodic theory"` | 2 | 0146.28502 Furstenberg 1967 (review) |
| 3 | `ab:"multi-invariant"` | 3 | none relevant |
| 4 | `ab:"Furstenberg" & ab:"solenoid"` | 1 | **1280.54023 Haynes–Munday 2013** (review) |
| 5 | `ab:"Furstenberg" & ab:"S-adic"` | 1 | an `S`-adic subshift paper (a different "S-adic"); irrelevant |
| 6 | `ab:"Furstenberg" & ab:"invariant" & ab:"closed" & ab:"hyperbolic"` | 3 | Berend ETDS 1984; Kalinin–Spatzier 2005 (measurable); a surface-group paper |
| 7 | `ab:"Berend" & ab:"hyperbolic"` | 1 | irrelevant |
| 8 | `ab:"Furstenberg" & ab:"adeles"` | 0 | — |
| 9 | `ab:"homoclinic" & ab:"algebraic" & ab:"action"` | 16 | Lind–Schmidt, JAMS 1999 (review); Lind–Schmidt–Verbitskiy, ETDS 2013 (review); Einsiedler–Schmidt 2002, rank one (review); Einsiedler–Lind–Miles–Ward 2001, expansive subdynamics (review); Chung–Li 2015 |
| 10 | `ab:"homoclinic" & ab:"algebraic" & ab:"non-expansive"` | 1 | Bowen–Li 2012 (summary); marginal |
| 11 | `ab:"Furstenberg" & ab:"compact group" & ab:"minimal set"` | 0 | — |
| 12 | `ab:"Furstenberg" & ab:"isometric"` | 22 | structure theory of distal/isometric extensions; nothing on invariant sets of automorphism groups |
| 13 | `ab:"circular chromatic number" & ab:"unit distance"` | 2 | **1140.05303 DeVos et al., *Circular coloring the plane*, SIAM J. DM 2007** (summary: χ_c(ℝ²) ≥ 4) |
| 14 | `ab:"circular chromatic" & ab:"plane"` | 12 | DeVos et al.; a survey; plane-width papers; Naserasr–Pujol–Wang 2026 (winding number) |
| 15 | `ab:"unit distance graph" & ab:"rational" & ab:"character"` | 0 | — |
| 16 | `ab:"unit distance" & ab:"circular coloring"` | 0 | — |
| 17 | `ab:"multiplicative subgroup" & ab:"interval" & ab:"finite field"` | 2 | Shparlinski 2016, small gaps in multiplicative subgroups (review) |
| 18 | `ab:"greatest common divisor" & ab:"multiplicatively independent"`; `ti:"upper bound for the G.C.D."` | 5; 2 | **Bugeaud–Corvaja–Zannier 2003** (review: `gcd(aⁿ−1, bⁿ−1) ≤ exp(εn)`); Levin 2019; Corvaja–Zannier 2008 |
| 19 | `ab:"lacunary" & ab:"Bohr" & ab:"set"` | 3 | Frantzikinakis–Host–Kra 2025, Bohr recurrence of non-lacunary semigroups (review) |
| 20 | `ab:"Pythagorean" & ab:"character" & ab:"dense"` | 0 | — |
| 21 | `ab:"rational points" & ab:"unit circle" & ab:"invariant"` | 1 | O'Dorney 2023, Diophantine approximation on conics (review); not this question |
| 22 | `ab:"norm one" & ab:"solenoid"` | 0 | — |
| 23 | `ab:"Furstenberg" & ab:"number field" & ab:"topological"` | 0 | — |
| 24 | OpenAlex: works citing Berend 1984 (TAMS) | 42 | Einsiedler–Lindenstrauss 2003, 2021; Haynes–Munday 2013; Gorodnik–Kadyrov 2012; Urban 2007, 2008, 2014 (S-adic duals); Miles 2008 (homoclinic points of non-expansive automorphisms); Clark–Fokkink 2004; Einsiedler–Schmidt 2002; Han Yu 2020; Wang 2013 (nilmanifolds); Bourgain–Furman–Lindenstrauss 2010 (non-abelian) |
| 25 | OpenAlex: works citing Berend ETDS 1984 | 17 | Katok–Spatzier 1996; **Maucourant 2010 (Annals)**; Starkov 1999 (minimal sets of algebraic actions on a torus); Kalinin–Katok 2002; Lindenstrauss 2005 survey; Gorodnik–Kadyrov 2012 |
| 26 | titles opened by query (zbMATH `ti:`; arXiv API for the abstract where zbMATH withholds it) | — | Haynes–Munday (review; arXiv 1303.1661); Gorodnik–Kadyrov (summary withheld; arXiv 1109.0183 abstract); Einsiedler–Lindenstrauss ETDS 2022 (summary withheld; arXiv 2101.11120 abstract: measure rigidity assuming positive entropy); Maucourant 2010 (review); Starkov 1999, Urban 2014 (withheld; not opened) |

### PA.3 What the gate found, and what was read

- **Berend, *Minimal sets on tori* (ETDS 4 (1984) 499–507) — read in full** (open access at Cambridge; held now,
  `~/source/library/pdf/Berend1984-minimal-sets-on-tori.pdf`). Theorem 2.1: for a commutative semigroup of epimorphisms of `T^r`,
  "every minimal set consists of torsion elements" (MT) ⟺ ergodic and every minimal set finite ⟺ ergodic and every minimal set of
  Hausdorff dimension 0 ⟺ **hyperbolic and multi-parameter**. **Lemma 3.1** (necessity of hyperbolicity): if the eigenvalues on a
  common eigenvector `v` all have modulus 1, the projection of the ellipse `{αv + ᾱv̄ : |α| = ρ}` is a closed invariant **minimal**
  set of dimension 1 — our archimedean leaf circles, so MT fails whenever an isometric direction exists, and the correct statement is
  "modulo the isometric direction". **Lemma 3.3** (necessity of multi-parameter): a one-parameter semigroup has minimal sets of positive
  Hausdorff dimension (shift-minimal sets pushed into the torus) — the rank-one phenomenon S0B met. **Prop. 4.1** (sufficiency, totally
  irreducible case): for a non-torsion minimal `M`, `M − M` is closed, invariant, with `0` non-isolated; either small differences have
  components in the expanding subspace, and then `M − M` is everything (contradicting Furstenberg's Prop. IV.1: `M − M` is proper), or
  near `0` all differences lie in the weakly contracting subspace, and an element contracting it strictly produces a periodic point, hence
  torsion. **Lemma 4.1**: MT passes to and from a closed invariant subgroup and its quotient. Remark 2.1 treats arbitrary endomorphisms.
  **For us:** the weakly contracting subspace contains the archimedean plane, which nothing contracts; the second case then gives
  "periodic modulo the archimedean leaf". Whether that yields `T + A` in a solenoid, and whether case 1 survives when "everything"
  is replaced by "leaves the band", is D's Stage 1a question (§S.2). The planner has not checked either step.
- **Berend 1983 (TAMS 280) and 1984 (TAMS 286) — not read; debt recorded.** zbMATH's review of 1983 read (the ID theorem, conditions
  (1)–(3), as the bibliography row already states); 1984 has no review. **Route attempted 2026-09-25:** `ams.org` returns a Cloudflare
  challenge on the issue page and HTTP 403 on the direct PDF (`/journals/tran/1983-280-02/S0002-9947-1983-0716835-6/…pdf`); OpenAlex
  marks both closed; DOIs 10.1090/s0002-9947-1983-0716835-6 and 10.1090/s0002-9947-1984-0760973-x. **Reason the debt does not block
  Stage 1:** Haynes–Munday's introduction states Berend 1984's adelic theorem's hypothesis ("elements whose absolute values are greater
  than one, in all completions of `ℚ` (Archimedean and non-Archimedean)"), and the minimal-sets paper, read in full, carries the method
  (it cites 1983 for Prop. 4.1's case 1, "§4 of [1], from (4.1) on"). **Case 1 of Prop. 4.1 is exactly the step D needs from 1983 §4**,
  so the debt bears on D-1a: a browser save of 1983 §4 is the owner's to request (AMS back files are usually readable in a browser).
- **Furstenberg 1967 — not held.** Springer paywall (`rd.springer.com` returned an HTML page, not a PDF); zbMATH 0146.28502 (review)
  located. Berend's minimal-sets paper states the four-way equivalence it proves for the circle (Prop. III.1, Th. III.2, Prop. IV.2,
  Th. IV.1), which is what this plan uses. New bibliography entry `[Furstenberg1967]` (inventory item 4).
- **Haynes–Munday 2013 (NYJM 19) — §1–§2 read** (arXiv 1303.1661, held): orbits in `𝔸/ℚ` under a semigroup `Σ(γ, δ)` (`γ ∈ ℚ`,
  `δ ∈ ℤ` independent) of a point with irrational real coordinate are dense; the dichotomy finite/dense fails for two generators (their
  §4). Their lever is the **archimedean** coordinate, which our action rotates: the opposite regime.
- **Maucourant 2010 (Annals) — review read:** non-homogeneous orbit closures of (non-full) diagonal groups for `n ≥ 6`, and the same idea
  gives "nonhomogeneous" orbits of diagonal toral endomorphisms: "a proper closed invariant set is not necessarily a subset of a finite
  union of rational affine tori." The obstruction named: factor actions that behave like one parameter. **The counterexample side's
  analogue**: an RS counterexample at rank two would have to exploit such a factor; the archimedean rotation is the candidate.
- **Einsiedler–Lindenstrauss — settled as not the nearest closed-set theorem.** Their tori-and-solenoids paper (ETDS 2022, arXiv
  2101.11120; abstract read) is measure rigidity under positive entropy; the nearest closed-set theorems are Berend's (1983, 1984,
  ETDS 1984). The measure line is not this question (inventory item 4).
- **Lind–Schmidt 1999 and Einsiedler–Schmidt 2002 (reviews):** homoclinic points of algebraic `ℤ^d`-actions; the vocabulary for
  heteroclinic characters and non-expansive actions. Not read beyond reviews; not load-bearing.
- **The question (item 3):** no one found classifying closed sets of characters of `ℤ[i][1/S]` that put the unit circle into an arc, or
  asking for circular colourings of rational unit-distance graphs by characters (queries 13–16, 20–22). The nearest posed question is
  DeVos et al. 2007, the circular chromatic number of the plane (≥ 4), which our band characters instantiate on field planes.
- **Side question U5:** Shparlinski 2016 and Bugeaud–Corvaja–Zannier 2003 name the tools (small multiplicative subgroups against
  intervals; gcd bounds for two multipliers). Reviews only.

**The eight questions, answered:** (1) named in four disciplines' words (PA.1); (2) searched under topological dynamics, algebraic
`ℤ^d`-actions, graph colouring and number theory; (3) the question searched (no poser found outside this project); (4) outside arXiv:
zbMATH, OpenAlex, Cambridge Core, AMS (blocked), Springer (blocked); personal pages not searched (budget; logged in §X); (5) the
question's poser is this project (FS-86's records); the method's posers' citation graphs walked: Berend 1984 TAMS (42) and ETDS (17)
in full by title; Furstenberg 1967's 1,011 citing works not walked (the closed-set line runs through Berend's citers); (6) every
neighbourhood title opened to its review or abstract, Berend ETDS read in full, Haynes–Munday §1–§2; (7) two databases: zbMATH (reviews,
no citations) against OpenAlex (citations); Semantic Scholar not queried; (8) Berend's full listing pulled (149); Furstenberg's listing
not pulled (the 1967 paper located directly).

### PA.4 Carried into §IQ and the briefs

- **The structural form is Berend's MT property modulo the isometric direction** (§IQ item 2), and the invariant it forces is the
  orbit closure's position relative to the leaves (§IQ item 3).
- **D's brief** carries: Berend ETDS Prop. 4.1's two-case structure as the first route, stated as a route to test, not a proof; Lemma 3.1
  as the reason the conclusion is `T + A` and not `T`; Lemma 3.3 as the rank-one phenomenon; Maucourant's mechanism as the shape of a
  counterexample; the heteroclinic vocabulary; the debt of Berend 1983 §4 (case 1).
- **V's brief** carries none of the routes (blindness), only the statements and the vocabulary list.
- FS-73's lesson (the gate's key idea left out of the competition brief) is honoured: the Berend material goes into D's brief in full.

## §IQ. The invariant question (WORKFLOW 3.3)

1. **The existence form.** Is there a character `θ` of `ℤ[i][1/p : p ≡ 1 (4)]` with `θ(u) ∈ [1/4, 3/4]` for every rational unit vector
   `u`, which is not a torsion character plus an archimedean one? (Equivalently, by EQ: is there such a character on some real field's
   unit-vector ring?)
2. **The structural form.** *Classify every closed subset of `R̂_S` invariant under `U_S` that avoids a nonempty open set, for every set
   `S` of split primes, finite or not — in the most general class where it makes sense: a compact abelian group with a commutative group
   of automorphisms that is multi-parameter and expanding in every non-archimedean direction, and isometric in the archimedean ones.*
   The arithmetic is stripped to three data: the rank of the acting group, which directions it expands, and which it rotates. The two
   rungs, each about **every** point and **every** orbit closure:
   - (IQ-a) every minimal set lies in a torsion translate of the isometric leaf (Berend's MT modulo the isometric direction);
   - (IQ-b) every orbit closure that avoids a nonempty open set lies in finitely many such translates (Berend's ID modulo the isometric
     direction), which at the band is RS / RQ.
   Rank one is the known failure of both (Berend's Lemma 3.3; S0B-T3–T5). The question is whether rank two (or all primes, with weak
   approximation) restores them, and if not, which invariant a counterexample carries.
3. **The invariant it forces.** For a band point, the **leaf itinerary**: in S0B's orbit model extended to rank `r`, a point is an array
   `(e_m)_{m ∈ ℤ^r}` in the band square with one step rule per prime, and each `e_m` either lies in exactly one leaf disc, in an overlap
   of discs (the lens), or in none; `T + A` is exactly "one leaf everywhere". The invariant every solution carries is therefore its **wall
   set** — the directions and sites where the itinerary changes leaf — and the adelic form of the same thing is the split data's
   discrepancy from a global element (S0B-T2: `T + A` ⟺ the split components are the images of one element of `ℚ(i)`, modulo the global
   ambiguity of FS86-dB-HDint). Berend's proof supplies a second invariant, `M − M` near `0` (which directions small differences of an
   orbit closure occupy). **Named, but not known to force the answer**: finding the argument that makes the wall set empty, or the array
   that keeps it non-empty in rank two, is the milestone.
4. **Its route.** Derivation only (D, then V blind). The one exact computation admitted (§S.4, the rank-two window) can refute the reading
   U4 or support it; it never proves IQ-b, since a finite window measures its depth (G21).
5. **The open instances it would decide.** RQ₄ (and with it C-HD1 for ℚ(√59), ℚ(√83), ℚ(√131), C-47 for ℚ(√47)); RQ₅ (C-167 for
   ℚ(√167)); RS₄({5, 13}); U3 at every single prime; the G76 reading "the obstruction is the real place"; the non-real Theorem-C analogues
   (`ℚ(√−709)`, FS86-dB-C) through the same statement with no isometric direction, where Berend's theorem applies as printed — **a control
   to aim a new procedure at the day it lands**: if the argument D finds needs the isometric direction only to produce `A`, it should
   reproduce Berend's MT verbatim when there is no such direction.

**Is the question already answered?** Not found in print (§PA.3): Berend's theorems exclude isometric directions by hypothesis, and the
closed-set literature that relaxes hyperbolicity found here is about density of orbits under expanding archimedean coordinates
(Haynes–Munday) or constructs counterexamples when a one-parameter factor is present (Maucourant). No two-line argument is known to the
planner. The milestone is not re-aimed.

## §S. The subplan (WORKFLOW 4)

### S.1 Staffing and the verifier's shape (Kooshi's ruling: one derivation agent plus a blind verifier)

- **D**, the derivation agent (de Bruijn, Opus 5.5): owns the questions D-0 to D-3 below; record `plans/FS89-S1D-derivation.md`.
- **V**, the blind verifier (Opus 5.5; the owner names the persona): owns V-A (fixed now) and V-B (D's saved claims, as statements);
  record `plans/FS89-S1V-verification.md`.
- **The decision: V starts at launch on a fixed list of hinge statements (V-A), then verifies D's saved claims blind (V-B).**
  - *Alternative weighed:* (a) V idle until D saves a first claim, then checks claims only (FS-86's W, X, C, D); (b) V derives the
    target RQ₄ blind in parallel with D.
  - *Why this one:* (a) wastes V's first day, while four inputs every route stands on are one mind each (N₀, S0B-T6, U1, the rank-two
    orbit model); V-A doubles them before D leans on them. (b) is a competition under another name, which Kooshi did not choose, and it
    would leave D's claims unchecked.
  - *Confidence:* medium-high. What would change it: V-A finishing within hours, in which case V's idle time before D's first claim is
    the cost of (a) anyway.
- **Blindness, mechanically.** V never opens `plans/FS89-S1D-*`, `data/fs89/s1d/`, `tools/fs89_s1d_*`, or D's scratch; V never runs
  `git log -p` or `git show` on D's commits. D's claims reach V only as statements, copied verbatim by the owner. **Both agents use
  neutral commit subjects** ("FS-89 S1D: record, section n"; "FS-89 S1V: record, section n") because the harness shows every agent the last
  five commit subjects at start-up (G51's covert channel). V may read D's record only after V's verdict on that claim is committed, to
  write a divergence table (S0A's C2 pattern).

### S.2 The stages and their questions

**Stage 1a (launch → 2026-09-27).**

| id | owner | question (quoted into the briefs verbatim) | output |
|---|---|---|---|
| D-0 | D | Read `[Berend1984min]` in full (held), Haynes–Munday §1, S0B's record and `tools/fs89_s0b_orbits.py`; write the rank-two orbit model (arrays `e_m`, `m ∈ ℤ²`, one step rule per prime, the gluing across both directions). ≤ 40k tokens. | record §1 |
| **D-1a** | D | "Is every `U_S`-minimal closed subset of `Θ₄(R_S)` contained in `T + A`, for every finite `S` with `|S| ≥ 2` (first `S = {5, 13}`)? Prove it — the route to test first is Berend's Prop. 4.1 with the archimedean plane in place of the strictly contracted subspace — or name the step that fails and why." | a saved claim (proved, or refuted by a minimal set outside `T + A`), or a named failing step |
| **D-1b** | D | "At `S = {5, 13}`: is there a band character of `R_S` whose orbit closure meets two different leaves (a heteroclinic or switching character)? Either exclude every such character, or exhibit one with exact band checks on a window and a proof that it persists (S0B-T3–T5's standard)." | a saved claim: `RS₄({5, 13})` proved (with D-1a), refuted, or reduced to a named lemma |
| V-A1 | V | U1 (§0.3), quoted: derive or refute. | verdict + derivation |
| V-A2 | V | N₀ (S0A-3) re-derived blind, and U2: "`Θ₄(Q) ∩ (T + A)` is exactly the finite union of leaf discs over the band torsion characters of `Q/168Q`, with margins 1/4, 1/12, 1/28 and 0 as listed"; list the torsion characters up to the symmetries (`U`-action, conjugation, negation), each with its margin. | verdict + the explicit list |
| V-A3 | V | S0B-T6, quoted: re-derive blind. | verdict |
| V-A4 | V | "Derive the rank-`r` orbit model: `Θ_β(U_S)` for `|S| = r` as arrays `(e_m)_{m ∈ ℤ^r}` in `Q_β` with one step rule per prime; state the gluing condition across directions, and the criterion for `T + A` (the rank-`r` form of S0B-T2)." | verdict + model (fixes §S.4's shape) |

**Stage 1b (→ 2026-09-29).** D's next question depends on Stage 1a (D decides, with the reason logged; the owner may redirect):
- *If `RS₄({5, 13})` is proved:* **D-2**, RQ₄: through U1 if V proved it, or directly (weak approximation, S0A-4's mechanism); then how
  far the argument reaches toward RQ₅.
- *If `RS₄({5, 13})` is refuted:* **D-C**, the extension question: "does the rank-two counterexample extend to a band character of `Q`
  (adding split primes one at a time, with compactness), or does some prime kill it as 13 killed the rational heteroclinics?" A
  counterexample to RQ₄ must read infinitely many split places (FT).
- *If D-1 ends in a named obstruction:* **D-2** anyway: weak approximation is a lever rank two lacks, and RQ₄ may be the easier statement.
- **V-B:** each claim D saves, verified blind from its statement.

**Stage 1c (→ 2026-09-30).** Final records; each "Theorems this phase proved" table; V's divergence table on every claim whose verdict is
committed. The close (the owner's close planner) follows on 2026-10-01.

**Optional side question D-3** (only if D-1 lands early, or as D's own break; it does not bear on RQ, since N₀ bounds the order over `Q`):
U5 at one prime — "are there band torsion characters of `R₅` of unbounded order?" (a prime `𝔭` where `⟨i, w₅⟩ mod 𝔭` is small and some
dilate avoids `(−1/4, 1/4)`; tools: Shparlinski 2016, Bugeaud–Corvaja–Zannier 2003). No enumeration beyond S0B-L4's `N ≤ 130` without
Kooshi's ruling (inventory item 17).

### S.3 Every phase's budget, stop rule, checkpoint, kill cost and acceptance

| phase | budget | stop rule | checkpoint / resume | a kill redoes | acceptance |
|---|---|---|---|---|---|
| D-0 | ≤ 40k tokens | model written and its 1-D slice checked against S0B-T1 | record §1 saved; resume: a fresh D reads the brief and the record, continues at the first unsaved section | the unsaved section | model stated; its `S = {5}` slice equals S0B-T1 |
| D-1a | ≤ 150k tokens | a claim at exact scope, proved or refuted; or a named failing step with its reason | record, saved per section | the unsaved section | statement quoted; proof or counterexample; inhabitant named (`S = {5, 13}`); grade |
| D-1b | ≤ 120k tokens | as D-1a; a counterexample carries exact window checks and a persistence proof | as D-1a | as D-1a | as D-1a, plus planted out-of-lens controls failing where predicted |
| D-2 / D-C | ≤ 150k tokens | as D-1a | as D-1a | as D-1a | as D-1a |
| D total | ≤ 420k tokens | hand back at the budget with the record saved | — | — | "Theorems this phase proved" table complete |
| V-A1–A4 | ≤ 150k tokens | a verdict per statement (TRUE / FALSE / GAP, with the derivation) | V's record, saved per statement; resume as above | the unsaved statement | every statement quoted verbatim, verdict, derivation, grade |
| V-B | ≤ 200k tokens | a verdict per claim received | as above | as above | as above; divergence table after each verdict is committed |
| §S.4 window | ≤ 3 h CPU at `K = 2`; `K ≥ 3` not without Kooshi | the pre-registered reading decided, or the time cap | per-`K` result files in `data/fs89/s1d/`; resume: rerun at the next `K` | the running `K` | controls pass (below); the reading's two outcomes both stated before the run |

### S.4 The one exact computation: the rank-two window (priced; optional; gated)

- **What it is.** S0B's orbit model at `S = {5, 13}`: arrays `e_{m,n}` in `Q_{1/4}` on the window `|m|, |n| ≤ K`, with both step rules;
  equivalently the characters of `5^{−K}13^{−K}ℤ[i]` with the band on the window's unit vectors. It counts connected pieces, point
  pieces, and pieces meeting no leaf disc's finite-level shadow.
- **Its shape is fixed by derivation first**: V-A4's model and D's D-0 model must agree before it runs (G21: the instrument's image must
  be derived, not assumed).
- **Why it is in scope:** the same kind as S0B's allowed computation (inventory item 2): an exact enumeration of one fixed set per `K`,
  no witness sought, bounded in hours. It is S0B §6's named killing test for U4.
- **Price.** `K = 1`: minutes (the window's group has index `65²` over `ℤ[i]`, 36 unit vectors). `K = 2`: unknown; priced from `K = 1`'s
  piece count and time before launch, capped at 3 hours under `scripts/slot.py --mem 16 --cpus 8`. `K ≥ 3`: not without Kooshi.
- **Controls, all at the same `K`:** (i) three colours: the count must equal the value D derives before the run from `RS₃({5})`
  (FS81-T3 glued through the 13-layers gives `Θ₃(R_{65}) ⊆ T₆ + A`; the window may still carry finite-level pieces that die deeper,
  so the predicted count is derived, not assumed to be 5 — at rank one it was 5 at every depth);
  (ii) the `n = 0` slice reproduces S0B's 1-D counts (29 at depth 1); (iii) a planted fault (the 13-step lattice `π̄₁₃⁻¹ℤ[i]` in place
  of `π₁₃⁻¹ℤ[i]`) must go red; (iv) the generator must be able to represent a rank-one switching array (S0B's prefixes embed in the
  `n = 0` slice).
- **The reading, pre-registered by D before the run**, with both outcomes stated and checked reachable: the number of pieces meeting no
  leaf shadow, as a function of `K`, against the 1-D count at the same depth. G21: a finite window measures its depth, so no count is
  read against zero.
- **Process rules:** `setsid`, pgid to a file, kill by pgid, verify by the result file's digest; output to `data/fs89/s1d/`, never `/tmp`;
  a Python pool passes `mp_context=get_context("fork")`.

### S.5 The killing tests (dated; each checked able to fire)

- **KT-1 (the plan's reading: "rank two restores rigidity", U4 extended).** Fires if, by **2026-09-29**, D or V exhibits a band character
  of `R_{65}` not in `T + A`: an explicit array or adelic formula, exact band checks on `|m|, |n| ≤ 25`, and a hand proof that it persists
  (S0B-T3–T5's standard). **Can fire:** the checking pattern exists (`tools/fs89_s0b_heteroclinic.py` checks S0B-T3 exactly), and S0B
  fired the rank-one analogue within a day; the §S.4 window can also exhibit surviving non-leaf pieces.
- **KT-2 (the route's reading: "Berend's Prop. 4.1 goes through modulo the isometric direction").** Fires if D names, by **2026-09-27**,
  a step of Prop. 4.1 (case 1 or case 2) that fails at the band with an explicit reason. **Can fire:** D-1a's stop rule requires either a
  proof or a named step.
- **What changes on 2026-10-01**, when the ban ends unless Kooshi extends it: HD1-cert's `Θ` tree on `Λ₅₁₀` (FS-90 (a)), the window at
  `K ≥ 3`, and finite-witness searches for a rank-two array become admissible with Kooshi's go; FS-90's T721 audit becomes runnable.
  **Nothing in Stage 1 depends on the ban lifting.**

### S.6 The fallback (sketched well enough to brief from)

- **F1 — the all-primes route by weak approximation** (D-2 as a fallback, if rank two stalls). The norm-one torus is ℚ-rational, so
  `U_ℚ` is dense in `S¹ × ∏_{v ∈ S′} T(ℚ_v)` for every finite `S′` (N₀'s tool). To make a band character leave the band, sweep one
  split place `v` by `u = w_p^k x`, with `x` prescribing `u_v` modulo `p^j`; each such `u` has poles at auxiliary split places whose
  contributions the adversary controls (S0A C3). **The question to hand D:** "is there a family of admissible sweeps whose auxiliary
  contributions are small outside a set that cannot carry the whole band — an averaging over the auxiliary primes that the adversary
  cannot defeat — or does the adversary's control of infinitely many places produce a counterexample by a diagonal construction?"
- **F2 — if the milestone stalls entirely:** the record states exactly what a Berend-type proof needs at the band (the case-1 analogue),
  the invariant a counterexample must carry (§IQ item 3), and which rung failed; FS-89's stub is re-aimed at that statement; the rest of
  the week goes to FS-87's kernel leaves (the advisor's filler), and after 2026-10-01 to FS-90 (a), HD1-cert, with Kooshi's go.

### S.7 Records every phase writes

- D: `plans/FS89-S1D-derivation.md` (C0 predictions before any derivation; one section per question; "Theorems this phase proved";
  the would-have-searched log). Working files stay in D's scratch until a claim is saved. Tools `tools/fs89_s1d_*.py`, data
  `data/fs89/s1d/`.
- V: `plans/FS89-S1V-verification.md` (C0 predictions; one section per statement or claim, each quoted verbatim; the divergence table
  after each committed verdict; "Theorems this phase proved"; the log). Tools `tools/fs89_s1v_*.py`, data `data/fs89/s1v/`.
- Every record: grades per `CLAUDE.md` § Notation; each result at its exact scope.

## §C. The two briefs' text (ready to paste; the owner adds the persona line, the scratch path and the date)

### C.1 The derivation agent's brief (D)

> Hello. You are this project's derivation agent for milestone FS-89, Stage 1, in the Lean 4 Hadwiger–Nelson workspace
> `/home/kooshi/source/lean-dir`. Your identity and standard are `DEBRUIJN.md`; the house rules are `CLAUDE.md` and `WORKFLOW.md`. Read
> all three from disk: any copy in your context is a snapshot. I'm the product owner; I coordinate and review by artifact. The plan is
> `plans/FS89-rational-band-rigidity.md`; read §0, §PA and §IQ first, then §S. One blind verifier works beside you on the same statements;
> there is no competition and no advisor.
>
> **The question.** Let `Q = ℤ[i][1/p : p ≡ 1 (mod 4)]`, the ring the rational unit vectors generate, and for a finite set `S` of such
> primes let `R_S = ℤ[i][1/p : p ∈ S]` with unit vectors `U_S = ⟨i⟩ × ⟨w_p : p ∈ S⟩`, `w_p = π_p/π̄_p`. A **band character** at four
> colours is a character `θ` with `θ(u) ∈ [1/4, 3/4]` for every unit vector `u`. The target, quoted from the plan's §0.2:
> "**RQ₄**: `Θ₄(Q) ⊆ T + A`" (torsion characters plus archimedean ones `x ↦ Re(ē x) mod 1`). It is equivalent to the same statement over
> every subfield of ℝ (S0A-10), and it would give HD1 for ℚ(√59), ℚ(√83), ℚ(√131) and exclude every character four-colouring of
> ℚ(√47)'s plane (S0A-6, S0A-8). At one prime it is false: `Θ₄(ℤ[i][1/5])` contains heteroclinic and switching characters that are
> not `T + A` (S0B-T3–T5).
>
> **Your questions, in order** (quoted from §S.2; you may re-order with a logged reason, and I may redirect after Stage 1a):
> - **D-0.** "Read `[Berend1984min]` in full (held), Haynes–Munday §1, S0B's record and `tools/fs89_s0b_orbits.py`; write the rank-two
>   orbit model (arrays `e_m`, `m ∈ ℤ²`, one step rule per prime, the gluing across both directions)."
> - **D-1a.** "Is every `U_S`-minimal closed subset of `Θ₄(R_S)` contained in `T + A`, for every finite `S` with `|S| ≥ 2` (first
>   `S = {5, 13}`)? Prove it — the route to test first is Berend's Prop. 4.1 with the archimedean plane in place of the strictly
>   contracted subspace — or name the step that fails and why."
> - **D-1b.** "At `S = {5, 13}`: is there a band character of `R_S` whose orbit closure meets two different leaves (a heteroclinic or
>   switching character)? Either exclude every such character, or exhibit one with exact band checks on a window and a proof that it
>   persists (S0B-T3–T5's standard)."
> - **Then (Stage 1b)**, depending on the outcome: **D-2** (RQ₄ over all primes, using weak approximation of the rational circle — the
>   lever rank two lacks — and U1 only if the verifier has proved it), or **D-C** ("does the rank-two counterexample extend to a band
>   character of `Q`, adding split primes one at a time with compactness, or does some prime kill it as 13 killed the rational
>   heteroclinics?"). A counterexample to RQ₄ must read infinitely many split places (S0A-11).
> - **Optional D-3**, only if D-1 lands early: are there band torsion characters of `ℤ[i][1/5]` of unbounded order? No enumeration beyond
>   S0B's `N ≤ 130`.
>
> **The mathematics you stand on, with addresses.**
> - Stage 0: `plans/FS89-S0A-gluing-verification.md` (the gluing S0A-2; Lemma N₀ S0A-3, `N = 168` automatic over `Q`; level collapse
>   S0A-4; finite type S0A-11; one prime cannot bound `N` S0A-12; C3's "natural attack" by weak approximation) and
>   `plans/FS89-S0B-band-set.md` (the orbit model S0B-T1; leaves and margins S0B-T2; `θ*` S0B-T3; "not `T + A`" S0B-T4; the switching
>   family S0B-T5; 13 kills rational heteroclinics S0B-T6, one mind; the reading U4 and its killing test in §6).
> - FS-86: `plans/FS86-derivation.md` §4 (dB-Theta, dB-HDfin = Cx-C10, dB-Sv, dB-HDint, dB-HDcert, Cx-C15) and §9 (C14, CL1).
> - The three-colour precedent: `plans/FS81-derivation.md` T3 (= C1(5)), T4, T5, T8; `CLAUDE.md` G74.
> - **The literature the gate found (plan §PA.3), which is the key idea, handed to you in full:** Berend, *Minimal sets on tori* (ETDS 1984;
>   `~/source/library/pdf/Berend1984-minimal-sets-on-tori.pdf`). Thm 2.1: all minimal sets are torsion iff the semigroup is hyperbolic
>   and multi-parameter. **Lemma 3.1**: an isometric common eigen-direction carries non-torsion minimal circles (our archimedean leaves),
>   so the statement to aim at is "modulo the isometric direction", which is why the target says `T + A` and not `T`. **Lemma 3.3**: rank
>   one has positive-dimensional minimal sets (the phenomenon S0B met). **Prop. 4.1**: for a non-torsion minimal `M`, `M − M` is closed,
>   invariant, `0` non-isolated; case 1 (small differences with expanding components) forces `M − M` to be everything, contradicting
>   Furstenberg's Prop. IV.1; case 2 (small differences in the weakly contracting subspace) uses an element contracting it strictly to
>   produce a periodic point. With the archimedean plane in that subspace, case 2 plausibly gives "periodic modulo the archimedean leaf";
>   **case 1 at the band, not the whole group, is untested, and its source (Berend 1983 §4) is not held** (AMS blocks scripted fetches;
>   the owner has asked). Haynes–Munday (arXiv 1303.1661, held): Berend's adelic hypothesis is expansion in every completion,
>   archimedean included — the one our norm-one action fails. Maucourant (Annals 2010, review only): non-homogeneous orbit closures
>   arise when a factor behaves like one parameter — the shape a rank-two counterexample would take. Vocabulary: algebraic `ℤ^d`-action,
>   non-expansive, heteroclinic point (Lind–Schmidt).
> - The symmetries of `Θ₄`: the `U`-action, complex conjugation (`b₊ ↔ b₋`), negation. The known band points (positive controls for any
>   classification): parity (margin 1/4), `(x+y)/4` and `(3x+2y)/8` (margin 0), the order-3 characters (1/12), the order-7 character
>   `(2x+3y)/7` (1/28).
> - **What the plan's re-grokking hands you** (§G, each entry's *Do*): the objects are closed sets and minimal sets, not invariant
>   measures (G60); at an inert place use Weil's equidistribution of `Tr(at)/q` on `μ_{q+1}` (G44), and in any level-by-level argument
>   there say where the carry enters (G66, FS66-E: arguments blind to the carry prove too much); the algebraic case — a `U`-invariant
>   coset of a closed subgroup inside `Θ₄` — is FS86-Cx-C15's, so your question is the non-algebraic closed sets; split components are
>   defined only modulo global elements (FS86-dB-HDint), so state any counterexample intrinsically; a would-be counterexample usually dies
>   by a coset sweep leaving the band (S0A-5, S0A-11); the consumer fields' unit vectors are layers `b·U_ℚ` rotated by the type-M `v_n`
>   (G7, G62); a finite window measures its depth, so no window count is read against zero (G21, FS81-T8); state every theorem for every
>   `S` it covers, with `{5, 13}` as its inhabitant (G30).
> - **Not verified, do not lean on them until the verifier has** (plan §0.3): U1 (the layering lemma), U2 (the explicit leaf list), U3,
>   U4, U5. S0A-3 and S0B-T6 are one mind each; the verifier is re-deriving them.
>
> **Scope, quoted from §0.2:** "RQ is about **character** colourings only. A proof of RQ₄ excludes every colouring of the form
> `x ↦ ⌊4θ(x)⌋` as a falsifier of the conjecture at ℚ(√47) (C-47); it says nothing about `χ(ℚ(√47)²)` itself … A counterexample to RQ₄
> is a band character of `Q`; it is a **seed** of a falsifier at ℚ(√47), not a falsifier."
>
> **Every outcome counts.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* A
> proof, a counterexample, a sharp statement of which rank suffices, and a named failing step are all results. **Do not lean toward a
> yes**: this project's recorded failure mode is that defects which flatter the work survive and defects which displease are found
> within the hour (G21). Audit a proof you like at the rate you would audit a counterexample you dislike.
>
> **Stop rules** (§S.3). Stop a question at a saved claim at exact scope (proved or refuted), or at a named failing step with its reason.
> Budgets: D-0 ≤ 40k tokens, D-1a ≤ 150k, D-1b ≤ 120k, D-2/D-C ≤ 150k, total ≤ 420k; at the total, hand back with the record saved.
> KT-2: if Berend's route breaks, name the step by 2026-09-27.
>
> **The one computation you may run** (§S.4): the rank-two window at `S = {5, 13}`, only after the verifier's V-A4 model and your D-0
> model agree, with its reading pre-registered (both outcomes stated and checked reachable), its four controls, `K = 1` then `K = 2`
> capped at 3 hours under `scripts/slot.py --mem 16 --cpus 8 -- …`, output to `data/fs89/s1d/`, never `/tmp`. `K ≥ 3` is Kooshi's.
>
> **The finite-witness-free week** runs to 2026-10-01 (`CLAUDE.md` § Toolchain): no SAT, MILP, finders, `Θ` relation trees, quotient
> searches or sweeps. Exact arithmetic that checks a derived claim is fine (S0B's heteroclinic checks are the model). Keep a **"would
> have searched here" log** in your record: one line per move you would have made by search, and what you did instead.
>
> **Records.** `plans/FS89-S1D-derivation.md`: C0 predictions before any derivation (a probability for each question's answer), one
> section per question, the log, and a heading **"Theorems this phase proved"** (one line per theorem, grade, address). Working files stay
> in your scratch directory until a claim is saved. Tools `tools/fs89_s1d_*.py` (you may import `tools/fs89_s0b_*.py`; never edit them or
> any frozen tool: `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`, `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`,
> `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`, `data/fs73/coxeter-c3/certcheck.py`).
>
> **Blindness.** The verifier must not see your routes. Commit subjects stay neutral ("FS-89 S1D: record, section n"): the harness shows
> every agent the last five commit subjects. Send each saved claim to me as a statement; I forward it verbatim. Don't open the verifier's
> record (`plans/FS89-S1V-verification.md`) until I tell you its verdict on your claim is committed.
>
> **Work in stages**: keep each response short and save your record after every section. At FS-86 an agent lost three responses to the
> output-token limit, and a lost response is unrecoverable.
>
> **No subagents.** Do not use the Agent tool, a fork, a workflow or anything that starts another agent. Staffing is Kooshi's budget
> decision (three agents at most, and two are running), and I can only review work I know about. If the work outgrows your context,
> stop at a clean boundary, save, and tell me what is left — that is a good report.
>
> **Resources and commits.** Any job over about 2 GiB or 2 minutes runs under `scripts/slot.py`; /tmp is RAM. Never run `lake build`.
> Commit by explicit path after `git diff -- <path>`; never amend; don't push; report each commit's hash. End commit messages with the
> attribution lines your harness supplies.
>
> **Reports** go to me by SendMessage (`to: "main"`) at each saved claim and at hand-back (claims at exact scope and grade, commit hashes,
> tokens used, anything for the close inventory). Keep your turn's final text content-free: "D idle; report sent to the owner by
> SendMessage". Thank you.

### C.2 The blind verifier's brief (V)

> Hello. You are the blind verifier for milestone FS-89, Stage 1, in the Lean 4 Hadwiger–Nelson workspace
> `/home/kooshi/source/lean-dir`. Your standard is `DEBRUIJN.md`; the house rules are `CLAUDE.md` and `WORKFLOW.md`, all read from disk.
> I'm the product owner. One derivation agent works on the milestone's questions; you check statements **blind**: you derive or refute
> each from its statement alone, never from anyone's route.
>
> **What you may read:** the plan `plans/FS89-rational-band-rigidity.md` §0.1–§0.3, §PA.1–PA.2 and §IQ (not §0.4, §PA.3–PA.4, §S or §C.1,
> which name the route the derivation agent is asked to test first: your derivations should not start from it);
> Stage 0's records `plans/FS89-S0A-gluing-verification.md` and `plans/FS89-S0B-band-set.md`; `plans/FS86-derivation.md`;
> `plans/FS81-derivation.md`; `CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`; any held paper. **What you must not read:**
> `plans/FS89-S1D-*`, `data/fs89/s1d/`, `tools/fs89_s1d_*`, the derivation agent's scratch, and `git log -p` / `git show` of its commits,
> until I tell you your verdict on the claim in question is committed; then you may read its route to write a divergence table.
>
> **The objects** (quoted from the plan's §0.1): "`Q := R_{all} = ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (mod 4)]`"; "`R_S := ℤ[i][1/p : p ∈ S]`";
> "`U_S := ⟨i⟩ × ⟨w_p : p ∈ S⟩`"; "`Θ_k(R_S) := {θ ∈ Hom(R_S, ℝ/ℤ) : θ(U_S) ⊆ B_k}`", `B_k = [1/k, 1 − 1/k]`; `T` torsion characters, `A`
> archimedean characters `x ↦ Re(ē x) mod 1`; leaves `τ + D(r_τ)` with margin `r_τ`.
>
> **Your fixed list (V-A), from launch** — each quoted verbatim from the plan (§0.3, §S.2):
> - **V-A1** (U1): "if `RS₄(S)` holds for every finite `S ⊇ S₀` (some fixed `S₀`), then RQ₄ holds." Derive or refute; if the last step
>   (a character of `Q` torsion on every `R_S` is torsion, or at least in `T + A`, given the band) fails, say exactly how.
> - **V-A2** (N₀ and U2): re-derive S0A-3 ("`Θ₄(ℤ[U_ℚ]) ∩ (T + A) ⊆ T_{168} + A`; the torsion part is a 2-part of order ∣ 8, or an order-3
>   part, or an order-7 part, and each occurs") blind, then decide U2: "`Θ₄(Q) ∩ (T + A)` is exactly the finite union of leaf discs over
>   the band torsion characters of `Q/168Q`, with margins `1/4` (parity), `1/12` (the order-3 types), `1/28` (the order-7 types) and `0`
>   (the order-4 and order-8 types)." List the band torsion characters up to the symmetries (the `U`-action, conjugation, negation), each
>   with its margin.
> - **V-A3** (S0B-T6): "a second prime (13) kills every rational heteroclinic whose torsion difference is prime to 13" — in S0B §6's full
>   form. Re-derive blind.
> - **V-A4:** "Derive the rank-`r` orbit model: `Θ_β(U_S)` for `|S| = r` as arrays `(e_m)_{m ∈ ℤ^r}` in `Q_β` with one step rule per
>   prime; state the gluing condition across directions, and the criterion for `T + A` (the rank-`r` form of S0B-T2)."
>
> **Then (V-B):** each claim the derivation agent saves reaches you from me as a statement, verbatim. Give it a verdict — TRUE, FALSE, or
> GAP (true as far as you can derive, with the missing step named) — with your own derivation and its grade. A consequence of the form
> "X, hence Y" is two claims; check both.
>
> **Every verdict counts, and none is preferred.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge
> is a success."* Do not lean toward a yes: a verifier that confirms what it is handed is this project's recorded failure mode (G21), and
> FS-86's blind verifiers found every divergence the milestone had. Check a proof you like as hard as a counterexample you dislike.
>
> **Stop rules and budget:** one verdict per statement or claim; V-A within about 150k tokens, V-B within about 200k; hand back with the
> record saved if you reach 400k.
>
> **Records.** `plans/FS89-S1V-verification.md`: C0 predictions (a probability per statement, before any derivation), one section per
> statement quoted verbatim, the divergence table after each committed verdict, a **"would have searched here" log**, and a heading
> **"Theorems this phase proved"**. Tools `tools/fs89_s1v_*.py`, data `data/fs89/s1v/`. Exact arithmetic that checks a derived claim is
> fine; no search for a finite witness runs before 2026-10-01 (no SAT, MILP, finders, `Θ` trees, quotient searches, sweeps).
>
> **Neutral commit subjects** ("FS-89 S1V: record, section n"): the harness shows every agent the last five subjects. **Work in stages**:
> short responses, the record saved after every section (at FS-86 an agent lost three responses to the output-token limit). **No
> subagents**: staffing is Kooshi's budget decision and I can only review work I know about; if the work outgrows your context, stop at a
> clean boundary and tell me what is left. Jobs over about 2 GiB or 2 minutes run under `scripts/slot.py`; /tmp is RAM; never `lake
> build`. Commit by explicit path after `git diff -- <path>`; never amend; don't push; report each hash. Frozen tools are never edited:
> `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`, `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`,
> `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`, `data/fs73/coxeter-c3/certcheck.py`; `tools/fs89_s0b_*.py` may be imported.
>
> **Reports** by SendMessage to `"main"` at each verdict and at hand-back; your turn's final text stays content-free: "V idle; report
> sent to the owner by SendMessage". Thank you.

## §P. Registered predictions and verdicts (before any Stage-1 run)

*Probabilities are the planner's priors, written after Stage 0 and the gate, before any Stage-1 derivation. Verdict labels score only the
experiment (Kooshi: no-gos count). FS-86's close asked the next verdict table to name both sides' formats in the no-go row; done below.*

### P.1 The milestone's outcomes (exclusive: the highest rung reached; they sum to 1)

| id | outcome | p | verdict | what it gives, at its scope |
|---|---|---|---|---|
| O1 | RQ₄ proved, D's derivation and V's blind one agreeing | 0.10 | **Paid (theorem)** | C-HD1 (HD1 for ℚ(√59), ℚ(√83), ℚ(√131)) at dB-Theta's grade; C-47 (no character four-colouring of ℚ(√47)'s plane). **Not** `χ(ℚ(√47)²) = 5` |
| O2 | `RS₄(S)` proved for every `|S| ≥ 2` (or at `{5, 13}`), RQ₄ not reached | 0.12 | **Paid (rank theorem)** | rank two restores rigidity modulo the isometric direction; RQ₄ reduced to U1 or to the all-primes step |
| O3 | `RS₄({5, 13})` refuted by an explicit band character of `R_{65}` outside `T + A`, its extension to `Q` open | 0.15 | **Paid (no-go of the rank-two statement)** | rank two is not enough; the counterexample's mechanism named (G76's reading tested) |
| O4 | RQ₄ refuted: an explicit band character of `Q` outside `T + A` (necessarily of infinite type) | 0.04 | **Paid (counterexample)** | the obstruction made concrete; a **seed**, not a falsifier, at ℚ(√47) |
| O5 | partial: MS at rank ≥ 2 proved, or U1 proved, or a named failing step of Berend's route with its reason, or a general no-heteroclinic theorem — without deciding RS or RQ | 0.39 | **Draw (frame, or no-go of a route)**. The no-go row's formats, both sides: *proof side* — "Berend's case 1 (or 2) fails at the band because …"; *counterexample side* — "no band character of `R_S` of format X (rational heteroclinic, finite switching, finitely many split places) exists" | the structure of the problem, stated for a successor |
| O6 | nothing beyond Stage 0's restatement | 0.20 | **Null (uninformative)** | reachable: D stalls on D-1a and D-1b without a named step. Recorded as such, never rescoped |

**Reachability, checked:** O1 and O2 need proofs (reachable in principle; no statement is known false); O3 and O4 are checkable by exact
arithmetic on windows plus a persistence derivation, exactly as S0B-T3–T5 were at rank one within a day; O5 is forced by the stop rules
(a named step is an allowed stop); O6 is reachable if both D-1 questions end at the budget without a named step.

### P.2 Side predictions

| id | statement | p | scored by |
|---|---|---|---|
| P-U1 | V finds U1 true | 0.75 | V-A1 |
| P-N0 | V re-derives N₀ blind | 0.90 | V-A2 |
| P-U2 | V confirms U2's list and margins | 0.85 | V-A2 |
| P-T6 | V confirms S0B-T6 | 0.80 | V-A3 |
| P-A4 | V's rank-two orbit model agrees with D's D-0 model | 0.85 | V-A4 vs D-0 |
| P-MS | MS₄({5, 13}) is true (not "proved this week") | 0.70 | any proof or counterexample, whenever |
| P-MS-wk | MS₄({5, 13}) proved this week | 0.35 | D-1a + V-B |
| P-RS2 | `RS₄({5, 13})` is true | 0.50 | D-1b, or later |
| P-RQ4 | RQ₄ is true | 0.60 | the milestone, or later |
| P-U3 | `RS₄({p})` fails at every single prime | 0.85 | not a Stage-1 question; registered |
| P-G76 | any counterexample found uses the archimedean discs' overlap (the lens) as its mechanism | 0.80 | the counterexample's proof |
| P-win | if the §S.4 window runs: its non-leaf pieces grow strictly slower than the 1-D count at the same depth | 0.55 | the window; the uninformative outcome (both dominated by finite-level pieces) is reachable and is registered as uninformative |
| P-KT1 | KT-1 fires by 2026-09-29 | 0.15 | §S.5 |
| P-KT2 | KT-2 fires by 2026-09-27 | 0.40 | §S.5 |
| P-G75 | RQ₄ true, read as a triangle-free spectral rigidity modulo the archimedean part (G75's side reading; not a test of R2.6) | 0.60 | = P-RQ4 |
| P-log | each agent logs at least one "would have searched here" line | 0.80 | the records |

## §M. The modeling passes (WORKFLOW 6)

- **Domain (always): folded here, light.** Stage 1 writes no Lean; its "types" are the statements' objects — `Θ_k` as a closed invariant
  subset of a solenoid, `T + A` and its leaves, the ring family `R_S` — and §0.1–§0.2 fixes them, with the ring, band and scope of every
  statement. A separate pass would re-derive §0; the owner may order one. *Alternative weighed:* a fresh `debruijn-domain-modeling`
  invocation and commit before launch. *Why folded:* the pass's subject (representations that elaborate) is absent; the brief permits
  folding. *Confidence:* medium; what would change it: FS-89 adding a kernel phase (FS-87-style), which then needs the full pass.
- **Obligation: applies, to D's derivations.** The planner's light decomposition is §S.2 (MS first, then connections between leaves,
  then all primes, with U1 as the join); D invokes `debruijn-obligation-modeling` fresh at D-0 on D-1a and D-1b, and again whenever a
  proof resists three attempts (DEBRUIJN's error reflexes).
- **Experience: does not apply** (no consumer surface: no lemma API, no tool output others consume beyond the §S.4 window's result files,
  whose format D states in its record).

## §X. The planner's "would have searched here" log

- Would have run the rank-two window at `K = 1, 2` now, to see whether 13 kills the switching family; instead priced and gated it behind
  two derivations of its shape (§S.4).
- Would have enumerated the band torsion characters of `Q/168Q` by machine to confirm U2's margins; instead stated U2 as unverified and
  gave it to V (a hand list from N₀'s types; the planner checked the five margins by hand on the residue circles: 1/4, 0, 0, 1/12, 1/28).
- Would have filtered Furstenberg 1967's 1,011 citing works by keyword; instead walked Berend's citers (42 and 17) by title, where the
  closed-set line runs.
- Would have extended S0B's torsion list past `N = 130` to test U5; did not (inventory item 17 is Kooshi's).
- Not searched (budget, not a search ban): authors' personal pages for Berend 1983/1984; Semantic Scholar's citation lists.

## Phase records

### The planner — Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| P-R1 | `Θ₃(R_{65}) ⊆ T₆ + A`: FS81-T3 on each layer `w₁₃ⁿ·ℤ[i][1/5]` glued through 5-divisibility as in S0A-2 (the three-colour control of §S.4) | derived, one mind (the planner), unverified; D re-derives it before using it as a control | §S.4 (i) |
| — | Everything else in this plan is a statement, a reading or a recognition: U1–U5 (§0.3) are unverified; the identification of Berend's Lemma 3.1 circles with the archimedean leaves is a reading (§PA.3) | — | — |

### Stage 1a–1c

*The records are `plans/FS89-S1D-derivation.md` and `plans/FS89-S1V-verification.md`, each with its own "Theorems this phase proved".*
