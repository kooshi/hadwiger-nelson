# Poros — FS-81 plan-phase advisor record (four colours over real quadratic fields)

*Plan-phase advisor to the FS-81 planner (a fresh de Bruijn). Only writer: this Poros. Scratch until hand-back; the owner then moves
this file into `plans/`. Held items (candidate routes for stage C) are in a separate file, `HELD.md`, never in this one.*

**Provenance note, stated against myself.** The brief asked for the expectation to be written before any exchange with the planner.
The planner's first note (`af9f63acf7af8b2f5`, "early recognitions") arrived while I was reading, before §0 below was on disk. Every
item in §0 was formed in my reasoning before that note was opened; I mark each place where the planner reached the same point
independently ("[planner also]"), and I do not claim those as mine. Nothing in §0 was changed after reading the note except these marks.

## 0. Expectation (formed before reading the planner; written 2026-09-24)

### 0.1 What I read to form it

`CLAUDE.md` (disk; the four rewritten passages: target paragraph l.72–84, Frontier item 10, G48's falsifier line, FS-59's row), the
stub `plans/STUB-quadratic-four-colour-classification.md`, the predecessor's record `plans/POROS-2026-09-24-next-direction.md` §2–§5,
`plans/FS81-close-inventory.md`, `plans/FS73-derivation.md` T21–T45 (T38–T45 in full), `CLOSED-QUESTIONS.md` §1.7,
`data/fs61/census.md` (all 40 rows), `plans/FS79-invariant-question.md` §R-close.1–.4, `plans/SESSION-HANDOFF-2026-09-24-fs81-open.md`
§2, `plans/PROTOCOL-competitor-and-advisor.md` §1, `LEDGER.md` rows 72–74, 78–81 (headings), `plans/FS61-quadratic-census.md` (R-mod8
lines only). Two small exact computations (seconds): the representations `a² + d = N c²` for N = 2, 5, 13 over the 40 census fields,
and T41's twist parameters (α, β) over the N = 2 family to d < 1000.

### 0.2 What I expect to bear, and why

- **G61** — T4, the census, "supply decides, not congruence class", "no witness transfers between fields". The last clause was written
  before `Θ₃`; `Θ₃` reasons about lattices, not witnesses, so the clause's reason is gone. **And "never by congruence class" is under
  pressure from the census's own table** (0.5 item 1).
- **G71** — `Θ₃`, cells: points of order 3 mean affine colourings and finite-index `F`; a fat cell means infinitely many colourings.
- **G72** — its *Do* (aim a new exact procedure at the open list the same day) is this milestone; its killing test is item 1 of the
  close inventory.
- **G62, G7, FS73-T40, T45** — the multilayer factorisation `U = B·U_R`; v is the Σ = n coincidence rotation.
- **G35, G56** — the prime above 2: in `ℚ(√d, i)/ℚ(√d)` it is inert at d ≡ 3 (mod 8) and split at d ≡ 7 (mod 8). I expect this to be
  the mechanism behind the census's skew (0.5 item 1).
- **G38, `[Fischer1990]` Thm 10** — an additive four-colouring at d ≡ 3 (mod 8), none with few colours at d ≡ −1 (mod 24): the two
  halves of the family are arithmetically different objects.
- **Row 72 (the 3-adic barrier)** — its character is one of the pieces of the rational pattern's rotation set (F4); every obstruction
  needs a direction with 3 in a denominator. v_d always carries 3 (2n = (d+1)/2 ≡ 0 mod 6) [planner also].
- **G57** — no √3, no triangles: every obstruction here is odd cycles of length ≥ 5; the proof that closes L ≤ 4 for √3-fields
  (G55: the rhombus) is unavailable by construction. FS-81 is exactly the no-√3 case of G55's clause.
- **G21** — typed nulls; a null measures its lattice generator; controls at the question's scale.
- **G30** — measurement generates, derivation kills: map the family's parameter before deriving it.
- **G65, G73** — for the ℚ(√47) phase: the degree law is three-colour only; at four colours no cell-local certificate exists, so a
  four-colour refusal is a finite refusal, and a full-dimensional `Θ₄` cell makes a lattice loose.
- **G48** — "a finite refusal only confirms": a four-colour refusal at 47 meets the conjecture's prediction; a null cannot falsify.
- **G49, G50** — `[Johnson2000]`, `[Johnson2006]` unread; §1.7 names them the likeliest prior art.
- **FS-73 theorems:** T22 (criterion), T24 (density and dichotomy), T25 (ℚ(√11)'s Λ₁₀: 16 points of order 3), T26 (certificate),
  T39–T41 (the ℚ(√167) proof), T42 (relation form, small coefficients), T43 (Ld65c8ee8 empty over 11, a slack-0 point over 59 — the same
  key read over two fields).

### 0.3 Which disciplines own "for which quadratic d is this rotation polytope empty"

- **Circular colouring of distance graphs and Cayley graphs of ℤⁿ** (Zhu; Chang–Liu–Zhu; D. D.-F. Liu, *From rainbow to the lonely
  runner: a survey on coloring parameters of distance graphs*, Taiwanese J. Math. 2008 — recalled, not read). There, sup_θ min_s ‖θ(s)‖
  is κ(S), and `Θ₃ ≠ ∅` is κ(S) ≥ 1/3 attained. **Whether "χ ≤ 3 iff κ ≥ 1/3" is known for distance graphs is the first prior-art
  question**, since it is T22's rank-1 case.
- **View obstruction and the lonely runner** (Wills; Cusick; Bienia–Goddyn–Gvozdjak–Sebő–Tarsi, *Flows, view obstructions, and the
  lonely runner*, JCTB 1998 — recalled, not read): `Θ₃ = ∅` is "the slabs ‖θ(s)‖ < 1/3 cover the torus".
- **Toric arrangements** (De Concini–Procesi, Moci; Kamiya–Takemura–Terao's characteristic quasi-polynomial): `Θ₃` is a union of
  chambers of the arrangement θ(s) ∈ {1/3, 2/3} + ℤ; points of `Θ₃` on (1/q)ℤʳ are linear colourings mod q.
- **Algebraic tori over number fields** (Voskresenskii; Ono): the unit vectors of ℚ(√d)² are the ℚ-points of the norm-one torus of
  ℚ(i, √−d)/ℚ(√d); they contain the product of the rational unit vectors (ℚ(i)'s norm-one group) and the rotations with rational cosine
  (ℚ(√−d)'s norm-one group), and **the quotient is 2-torsion** (z² ∈ that product: z² = i·(a − i√d)/(a + i√d)). The layers of G62's
  factorisation are exactly this: `U_F = ⋃ b·U_ℚ`, b over ℚ(√−d)'s norm-one group times one representative per 2-torsion class, the
  classes indexed by N ∈ N(ℚ(i)^×) ∩ N(ℚ(√−d)^×) modulo squares. The type-M rotation v_d is one element of an infinite group; z is one
  2-torsion class (N = 2).
- **Genus theory / binary quadratic forms** for a² + d = N c²: at N = 2, d = −N(a + c√2), so every prime factor of d is ≡ ±1 (mod 8)
  and d ≡ 7 (mod 8) [planner also]; infinitely many representations per d (the unit 3 + 2√2) and two sign classes.
- **Pontryagin duality / Tate's thesis** for the whole-field object: characters of F² are points of (𝔸_F/F)², and by compactness
  χ(F²) ≤ 3 iff some character puts every unit vector in [1/3, 2/3] [planner also — its §IQ object; the predecessor's open question,
  close inventory item 12, at k = 3].

### 0.4 The structural form, and whether WORKFLOW 3.3 is degenerate here

The stub's structural form — "for which d, and which lattices over them, is `Θ₃` empty?" — carries a search inside it ("which
lattices"): at the lattice level it is the existence form with a certificate type attached, and **in that form 3.3 is degenerate**,
because the invariant (the slope, G71) is already known and nothing about every solution is being asked.

It stops being degenerate at the **field level**: the set of characters of F² that band every unit vector in the middle third is a
closed set invariant under rotation by unit vectors (and under ψ ↦ −ψ), it is nonempty iff F² is three-colourable, and **its
classification is unknown** — over ℚ, over the three-colourable fields d ≡ 3, 7 (mod 12), and over d ≡ 11 (mod 12), where T4 says it is
empty. A classification ("describe this set for every real quadratic F") is a question about every three-colouring of every such
plane; "for which d is it empty" is the existence form over d. The classification has a check the emptiness question lacks: at the
three-colourable fields it must reproduce Fischer's colourings. **What should replace 3.3's "find the invariant" here: "classify the
invariant set", with lattices demoted to certificates of emptiness and the three-colourable fields as the negative controls.**

### 0.5 Where I expect a plan for this to go wrong

1. **The census's open set is one half of the family, and the plan's controls are from the other half.** Of the 20 fields d ≡ 7 (mod 8)
   the census certified 13 (with 167); of the 20 fields d ≡ 3 (mod 8) it certified 2 (11 and 59). So 18 of the 25 open fields are
   d ≡ 3 (mod 8), where the N = 2 twist cannot exist, and the brief's positive controls (167, 47) are both d ≡ 7 (mod 8). A phase-0
   calibrated on 167 and 47 is calibrated on the wrong half. **The controls at the question's scale are 11 and 59.** G61's "never by
   congruence class" was written after R-mod8's strong form lost at d = 11; the weak form (a 2-adic skew) stands in the table and was
   never scored as such.
2. **The family arm and the instance arm address almost disjoint populations.** T41's shape (N = 2) exists at d ≡ 23 (mod 24) with every
   prime factor ≡ ±1 (mod 8): of the 25 open fields, only 263, 287, 383, 479 [planner also]. A family theorem in T41's shape lands at most
   those four; it cannot touch the d ≡ 3 (mod 8) half. The plan must say which arm is expected to reach that half, or register that
   neither is.
3. **T41's shape may be a finite family.** By T40's own formulas the conditions of `{1, v, z}·U_R` are μ₁ ∈ Θ_R, ν ∈ Θ_R,
   (1−i)(αμ₁ − βν) ∈ Θ_R, with Θ_R fixed and independent of d, and α = (a + (d−1)/2)/(2c), β = (d+1)/(4c); v̄ is not used. So the family
   question is a two-parameter question about one planar periodic set. The four cases close on size bounds (1/6, 13/12, 7/6), and at the
   smallest representation α, β grow like √d (47: 7/3, 2; 167: 7/2, 3; 479: 7, 20/3). I expect the shape to fail for large d unless the
   representation (a, c) is chosen to keep α, β small, and "finitely many d" to be a reachable outcome the stub did not register.
4. **Phase 0's nulls will measure the census's lattice generator** (NMAX ≤ 420, lattices built for balls). A field whose obstruction needs
   a second layer of large denominator (35 has only N = 29 at small c) is a null by construction. Nulls must be typed by the generator's
   image, and the generator checked to produce the known positive lattices (L21cc6506 at 167; the witness lattices at 11 and 59).
5. **Tree cost at the fine lattices.** L21cc6506's tree had 605,203 nodes because μ₁ sees 42² periods of Θ_R; the d ≡ 3 (mod 8) lattices
   are finer (N₁ up to 114). Price trees on 11 and 59 first; the product-structure route (T39's route 2) is the one that scales with
   layers.
6. **The ℚ(√47) four-colour phase may have no positive control.** Is any rank-4 lattice known to refuse four colours? De Grey's lattice
   is four-colourable (`F = P = 8Λ`); `L21cc6506` is loose at four. If none is known, the phase's "price" has no calibration and its null
   is uninterpretable at any budget.
7. **Frame acceptance on "family = T41 with the twist as a parameter".** The layer group is infinite (0.3); T41 is one choice of two
   layers. A family defined by one choice of layers is a generator image (G21); the family question is over which layers.

## 1. Evidence inventory

- `data/fs61/census.md`, the 40 rows by d mod 8 — read against: open fields spread evenly across the two halves — surprised: yes; 18 of 25
  open are d ≡ 3 (mod 8); certified 2/20 there against 13/20 at d ≡ 7 (mod 8)
- `data/fs61/census.md`, N₁ and N₃ columns — read against: comparable denominators across halves — surprised: yes; the open d ≡ 3 (mod 8)
  fields have N₁ from 18 to 114, the certified d ≡ 7 (mod 8) fields 8 to 36
- representations a² + d = N c², N ∈ {2, 5, 13}, the 40 fields (my computation) — read against: nothing — surprised: yes; both certified
  d ≡ 3 (mod 8) fields have a small N = 5 layer (11: 3² + 11 = 5·2²; 59: 11² + 59 = 5·6²); 35, 83, 203, 227, 323, 371 have none of N = 2, 5, 13
- `plans/FS73-derivation.md` T40–T41 — read against: T41 needs v, v̄, z — surprised: yes; `{1, v, z}` uses v only as a coordinate; the
  only d-dependent data are (α, β); `{1, v, z̄}` colours at 167, so the sign class of the representation matters
- T41's (α, β) over the N = 2 family to d < 1000 (my computation) — read against: bounded parameters — surprised: no; they grow like √d at
  the smallest representation and shrink (with growing denominators) along the unit orbit
- `CLOSED-QUESTIONS.md` §1.7 — read against: the two halves are one problem — surprised: yes; Fischer Thm 10 already separates them
  (additive four-colouring at d ≡ 3 mod 8; none with few colours at −1 mod 24), and the census's lower bounds "cut across" — at two fields
- `plans/POROS-2026-09-24-next-direction.md` §3 hunch `circular-colourings-do-not-glue` and close inventory item 12 — read against: the
  whole-field question is FS-64's — surprised: yes; at k = 3 it is FS-81's own structural form, and it is routed only to FS-64
- `plans/FS81-close-inventory.md` — read against: nothing on controls — surprised: no
- `plans/PROTOCOL-competitor-and-advisor.md` §1 — read against: the rules I work under — surprised: no

## 2. Hunch ledger

hunch: census-skew-is-2-adic
  claim: at d ≡ 3 (mod 8) (prime above 2 inert in ℚ(√d, i)/ℚ(√d)) a four-colour obstruction needs finer lattices than at d ≡ 7 (mod 8);
    the census's 2/20 against 13/20 is that, not chance
  basis: measured
  falsifier: phase 0 lands the d ≡ 3 (mod 8) open fields at the census's own depth at the same rate as the d ≡ 7 (mod 8) ones
  registered: 2026-09-24
  status: open

hunch: norm-five-layer-predicts-landing
  claim: among the open d ≡ 3 (mod 8) fields, those with a small norm-5 layer (a² + d = 5c², c ≤ 14: 131, 155, 179, 251, 419, 491) land
    first under `Θ₃`
  basis: measured
  falsifier: phase 0 lands none of those six while landing some d ≡ 3 (mod 8) field without such a layer
  registered: 2026-09-24
  status: open

hunch: t41-shape-is-finite
  claim: `{1, v_d, z}·U_R` has empty `Θ₃` for only finitely many d in the N = 2 family, for any fixed rule choosing the representation
  basis: derived
  falsifier: an explicit infinite N = 2 subfamily on which the four cases close, with the representation given by a rule
  registered: 2026-09-24
  status: open (the "derived" is a size heuristic, not a proof; I hold it as a prediction)

hunch: q47-phase-has-no-control
  claim: no rank-4 lattice is known to refuse four colours, so the ℚ(√47) phase has no positive control at its scale
  basis: prior
  falsifier: an address in the record of a rank-4 lattice certified not four-colourable
  registered: 2026-09-24
  status: killed (by: FS73-T6, supplied by the planner — `Cay(Λ_dG, U ∪ {±v})`, de Grey's lattice with the one extra non-unit
    generator v = −(4/9)(1 + √−11), refuses four colours on 2,044 points, LRAT through the frozen checker. My "de Grey's lattice is
    four-colourable" was true and beside the point: I had T6 in my index and did not connect it. No rank-4 *unit-distance* lattice graph
    is known to refuse four; the control is a rank-4 Cayley graph, which is what stage D calibrates on.)

## 3. Cards

question: are-the-controls-from-the-open-half
  evidence: `data/fs61/census.md` — certified 13/20 at d ≡ 7 (mod 8) (with 167), 2/20 at d ≡ 3 (mod 8) (11, 59); 18 of 25 open are
    d ≡ 3 (mod 8); the brief's controls 167 and 47 are both d ≡ 7 (mod 8)
  expected: controls drawn from the population the nulls will be read on
  ask: what are phase 0's positive controls at the scale of the 18 open d ≡ 3 (mod 8) fields?
  if 11 and 59 (and Ld65c8ee8): a d ≡ 3 (mod 8) null is interpretable as a statement about the field at that depth
  if 167 and 47 only: a d ≡ 3 (mod 8) null measures the calibration's half; type it so, or add the controls
  answered by: the record — the planner's phase table
  cost: one read
  rank: 1

question: is-t41-shape-finite
  evidence: `plans/FS73-derivation.md` T40–T41 — conditions on μ₁, ν, μ_z only; my (α, β) table over the N = 2 family to d < 1000
  expected: a family proof in T41's shape covers infinitely many d
  ask: is "T41's shape holds for only finitely many d" registered as reachable, and is E(α, β) mapped before stage C derives?
  if registered and mapped: stage C proves a known region; a finite map is itself a result
  if not: stage C may spend 300–400k tokens deriving a family that the map would have shown finite
  answered by: run — exact `Θ₃` on `{1, v, z}·U_R` at every realised (α, β) with c below a bound; seconds each
  cost: minutes
  hunch: finite for any fixed representation rule (t41-shape-is-finite)
  falsifier: an infinite explicit subfamily with a representation rule on which the four cases close
  rank: 2

## 4. Exchanges

1. **Planner → Poros, first note** (before my §0 was on disk): the field-level object `Θ₃(F) ⊂ Hom(R_F, ℝ/ℤ)` by T22 plus compactness,
   U-invariant, "maximal invariant subset of the band"; disciplines circular colouring and Berend's multi-invariant sets (partially
   hyperbolic here); the layer form with its guess Θ₃(ℚ) = (θ₂ + D̄(1/6)) ∪ F4 and "T41 the finite shadow of a gluing problem"; the
   parameter arithmetic (N = 2 only at 263, 287, 383, 479 among the open; general layer π(a − i√d)/(Nc), 35 has N = 29); ℚ(√47) is a
   control for the field, not for T41's shape (v_47's denominator 24 ∤ 60).
2. **Poros → planner, reply** (2026-09-24): six ranked questions — (1) controls from the wrong half (11, 59, Ld65c8ee8); G61's
   congruence clause "falsifiable here"? (2) which arm reaches d ≡ 3 (mod 8); enumerate layers, not census lattices; (3) the (α, β)
   reduction, "finite family" reachable, map E before stage C, check my reduction; (4) §IQ as a classification, not "for which d empty";
   the predecessor's hunch is FS-81's own at k = 3; (5) any rank-4 four-colour refusal as a control for the 47 phase? (6) prior art:
   Liu's survey, Zhu, Bienia et al., algebraic tori. Plus: Berend's "finite or everything" already fails at ℚ (the disc).
3. **Poros → owner**: status; three close-inventory candidates (the mod-8 skew never scored; item 12 routed also to FS-81 §IQ; the
   finite-family outcome), and the 47-phase control question.
4. **Owner → Poros**: logged as close-inventory items 17 (mod-8 skew, counts re-checked by the owner), 18 (item 12's second home, FS-81
   §IQ), 19 (finitely-many-d outcome; my reduction unchecked), 20 (stage D's positive control), 21 (my slip). HELD.md unopened until the
   final report.
5. **Planner → Poros, "attack this first"**: a hand sketch proving T4 for every d ≡ 11 (mod 12), and in general χ(F²) ≥ 4 whenever
   1/3 ∈ ℤ[U_F] and F² is non-bipartite. Steps: Θ₃(F) ≠ ∅ from T22 (⟹) + compactness; C1(5): the characters of R₅ = ℤ[i][1/5] banding
   U₅ = {iᵏwᵐ} are θ₂ + λ_e (|e| ≤ 1/6) or four order-3 characters through 𝔽₉ (from T40's list by a type-propagation argument along
   wᵐ, dual lattice (2−i)ℤ[i]); every layer θ_b ∈ Θ(U₅); 1 = n(2 − v − v̄) with 3 | n kills the order-3 layers (finite-order archimedean
   characters on R₅ are zero), then the parity layers (coefficient n(2−1−1) = 0). Also: my six questions taken (controls 11, 59,
   Ld65c8ee8; G61's clause falsifiable; layers enumerated; "finitely many d" registered; §IQ = classify Θ₃(F); no known rank-4
   four-colour refusal).
6. **Poros → planner, the attack**: no flaw found on the five named points. (1) compactness indexed by finite S, and R_F is the
   component of 0; (2) T40's list confirmed by an independent grid scan (8,185 feasible points at step 1/300 on [0,5)²: 8,181 within
   0.175 of c0, 4 isolated at c0 + (±5/6, ±5/6)); (3) dual lattice re-derived, margins wide; pieces generate R₅; (4) finite-order
   archimedean zero by 5^{−j}; (5) extension: the parity branch needs no 3 | n, and with 3 ∤ n the mixed cases close too, so at
   d ≡ 3, 7 (mod 12) every point of Θ₃(F) has only order-3 layers, θ(R_F) ⊆ (1/3)ℤ/ℤ — every three-colouring character of ℚ(√d)²,
   d ≡ 3 (mod 4), is additive mod 3; the negative control is that Fischer's Thm 9 colourings are additive mod 3 (unread by me for this).
   What it stands on: T22 (⟹) [hand]; one mind on the new steps (G51); no finite graph and no size bound; prior art urgent (Fischer 1990's
   1/k argument is the ancestor; Johnson papers). Milestone re-aim named (outcome (a) superseded; stage C → independent verification;
   phase 0 → certificates; FS-75 carries every d).
7. **Poros → owner**: the same, in the owner's terms, with the re-aim table and four close-inventory candidates.
8. **Owner → Poros**: logged items 25–27; ruling: stage C becomes independent verification (item 24), phase 0 runs as certificates and
   calibration, the ℚ(√47) phase unchanged. Asked my context use; answered ≈ 180k working context (estimate), ≈ 380k harness counter.
9. **Plan committed at 9f912adb** (`plans/FS81-quadratic-four-colours.md`, proofs in `plans/FS81-F-sketch.md`). §X's dispositions: cards
   1, 2, 4, 6 taken; card 3 agreed and registered (P0-T41-finite, 0.65; P0.2 maps the realised shapes); card 5 answered by FS73-T6; my
   compactness indexing adopted in L1's acceptance; §F.5 (my extension) recorded at its grade with both mixed cases re-derived by the
   planner. Disagreements: none. Retractions: 0 and 0.

hunch: planner-t4-argument-holds
  claim: the planner's sketch proves χ(ℚ(√d)²) ≥ 4 for every squarefree d ≡ 11 (mod 12), modulo T22 (⟹)
  basis: derived (checked step by step; C1(5)'s input list replicated numerically)
  falsifier: a gap in C1(5)'s type propagation, in the relation step, or in T22 (⟹); or a real field with 1/3 ∈ ℤ[U_F], F² non-bipartite
    and χ(F²) = 3
  registered: 2026-09-24
  status: open (confirmation needs an independent derivation — G51 — not my check)

hunch: three-colourings-of-d3mod4-are-additive
  claim: for every squarefree d ≡ 3 (mod 4), every character in Θ₃(ℚ(√d)) takes values in (1/3)ℤ/ℤ on R_F (the planner's argument
    extended to the mixed cases)
  basis: derived
  falsifier: a three-colouring of ℚ(√7)² (or ℚ(√3)²) whose character is not additive mod 3; or Fischer's Thm 9 colourings not additive
  registered: 2026-09-24
  status: open, supported (the planner re-derived both mixed cases after reading mine — not independent; its §PA.3 read of
    `[Fischer1990]` Thm 9 finds his three-colourings are homomorphisms to ℤ/3, as the claim requires; stage C's C3 is the independent check)

hunch t41-shape-is-finite — status note 2026-09-24: moot for T4 if the planner's argument holds; kept as a question about T41's shape.

## 5. Retractions and my own errors

- Retractions: Poros 0, planner 0 (G51: zero means the disagreement has not started; stage C is where it should).
- My errors, against myself:
  1. **Process slip:** §0 was not on disk before the planner's first note arrived (the provenance note; close inventory item 21).
  2. **Card 5 missed a control in the record:** I asked whether any rank-4 lattice refuses four colours and cited de Grey's lattice as
     four-colourable, without connecting FS73-T6, which I had indexed: de Grey's lattice plus ±v refuses four on 2,044 points. The
     planner supplied it. The card was still useful (it made stage D calibrate first) but its premise was half-read.
  3. **Held a route the planner was already on:** H2 (the local reading of T40's pieces) was held under the brief's rule; the planner
     reached it independently and turned it into §F within hours. Holding cost nothing here, but the rule's purpose (independent first
     routes for stage C) was moot once the planner had the route.
