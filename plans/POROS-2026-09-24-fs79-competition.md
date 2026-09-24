# Poros — FS-79 competition advisor's record

*Advisor: Poros (Opus 5.5), 2026-09-24, desktop. Brief: `BRIEF-Poros.md` (this directory). Competitors: de Bruijn
(a392e5920652b2404), Coxeter (aed7d7f0c18c3aa89). Owner: `main`. Only writer: me. Stays in scratch until both hand back.*

## §0. My expectation, written before either competitor's first route was read (2026-09-24, before any message)

Read against: the brief (all of it); `plans/FS79-invariant-question.md` §0, §PA.3, §IQ; `data/fs79/records/phase-P0.md` (all);
`plans/FS73-derivation.md` T21–T24, T28–T38; the loaded `CLAUDE.md` (current at `af9d9a3a`, G72 present). Not read: the plan's
§G, §S, §C.3, §D in full (§C.1/§C.2/§C.4 are in my brief verbatim); the plan-phase advisor's record (private; its advice is in my
brief); the sources below marked *recalled, not read*.

### 0.1 The frame on its five axes

| axis | as posed | my reading |
|---|---|---|
| object | four-colourings of `Cay(Λ,S)`, Λ ≅ ℤ^r, as an R-invariant sub-shift of the grid homshift `Hom(ℤⁿ, K₄)` | right; the relator cells of `S` are the whole content (see 0.3) |
| question | three faces, ranked (Q-obs), (Q-rig), (Q) | the ranking aims at the target; (Q) is where a result is most likely to land and least likely to reach the target |
| discipline | symbolic dynamics (homshifts, K. Schmidt cohomology); stat-mech heights (Moore–Newman); topological combinatorics | add: **periodic tilings** (Greenfeld–Tao: "does a tiling exist ⟹ a periodic one?", disproved in high dimension by encoding through a finite group — the "rigidity manufactures torsion" move) and **Burr 1984** (k-colourability of periodic graphs with several vertex orbits is undecidable). Together they make the domino drift cheap (0.4) |
| audience | the scorer (acceptance criteria O-0 … Q-N4) | fine |
| product | an answer to one face, class and rank named, kind named; or "not landed" typed (a)/(b)/(c) | fine; the risk is the product being a (Q-comp) no that is scored as a win while reaching nothing at ℚ(√167) |

### 0.2 Which forks are real

1. **(Q-comp) no by domino/Burr reduction** — real and the likeliest landing. Burr's periodic graphs have several vertex orbits; a
   Cayley graph of a torsion-free group has one. The bridge is a rigid factor that emulates torsion (the plan's H-P1, public): e.g.
   `ℤ² × ℤ` with the `ℤ` factor `Cay(ℤ,{1,2,3})` (24 colourings, all 4-periodic) makes cosets behave like `ℤ² × ℤ/4`. This uses
   cliques and rank ≥ 3. **It cannot reach ℚ(√167)** (triangle-free, rank 4). A K₄-free rigid factor is the hard step: T30's rank-1
   K₄-free graphs have *walls* between rigid phases, which is exactly what breaks torsion emulation.
2. **(Q-rig) through a Moore–Newman height** — real where triangles exist (de Grey's lattice ⊇ ℤ[ζ₆]); Hubai's "stripes of period 2
   on the Eisenstein sublattice, one chirality" reads as: the Eisenstein cosets are forced to boundary (zero-entropy) slopes of the
   MN height and the Moser coupling rotates the stripe direction. A criterion "every coset's slope is forced to an extreme point" is
   the four-colour analogue of T24's "every cell a point". **It cannot reach ℚ(√167)** (no triangles). It can meet RIG-Y2.
3. **(Q-obs) at triangle-free rank 4** — the target fork, and I expect it **not to land** in this competition. Candidates: window
   frequencies (Sherali–Adams on the group; possibly with residue labels, i.e. joinings with the odometer), algebraic certificates in
   `ℤ[Λ]`, layer-wise certificates (the multilayer `{1,v,v̄,z,z̄}·U_R`: each layer `b·U_R` spans a rank-2 lattice and its graph is
   **bipartite**, since χ(ℚ²) = 2 — so every ℚ(√167) lattice graph is a union of bipartite rank-2 layers on a rank-4 group).
4. **A no-go of kind 1 (heights) on triangle-free graphs** — real, and I think the most likely *target-relevant* landing: "every
   continuous cocycle of the four-colouring shift of a triangle-free `Cay(Λ,S)` is a coboundary plus a homomorphism", reproducing
   CGHO's grid and, by its class, not covering MN's triangular lattice (OBS-N3's two controls). The mechanism in 0.3.

### 0.3 My own derivations, registered as hunches (to be scored; offered to the competitors only as questions, after first routes)

- **The ℤ/2 winding T29 says a four-colouring "carries" is forced by `S`.** `Q₃ → K₄` (antipodal quotient) is a 2-fold covering of
  graphs; every closed 4-walk of `K₄` lifts closed; so `c` lifts to `h : ℤⁿ → Q₃`, unique up to the antipode. For `ρ ∈ R`,
  `h(x+ρ) = h(x)` or its antipode; both graphs are bipartite and the antipode (111) flips sides, so `h(x+ρ) = h(x) + (|ρ|₁ mod 2)·111`.
  The winding is the ℓ¹-parity of the relation: a property of `S`, not of `c`. So the square complex gives a four-colouring **no**
  invariant at all (consistent with CGHO's "square group ℤ/2 ⟹ cohomologically trivial").
- **Every oriented, averaged S²-degree invariant vanishes on every non-bipartite `Cay(Λ,S)`** (bears on the held H-A and H-P2). An
  odd relator acts on the lift as the antipode, which reverses the orientation of `S²`; averaging over translations includes it; so
  the mean flux (and the mean charge density) is its own negative. H-P2's snag 1 is fatal, not a test, and every graph that matters is
  non-bipartite (a bipartite one is two-colourable). What survives is sign-blind (`|deg|`, charge magnitudes), hence not linear.
- **Edge-label heights need triangles.** A cocycle `Δh = E_j(c(x)+c(x+s_j))` (V₄ labels, MN's form) is consistent on a grid square
  of type (a,b | b,a) only if `E_i − E_j` is constant on V₄∖0, and on type (a,a | a',a') (which needs `c(x) = c(x+s_i+s_j)`) only if
  `E_i + E_j` is constant; both types can occur exactly when `s_i ± s_j ∉ S`, i.e. when the pair spans no triangle. MN escapes because
  in the triangular lattice every generator pair spans a triangle. So on a triangle-free graph a height of this form is trivial unless
  the colouring space itself excludes square types — which is a rigidity phenomenon, not a height.

### 0.4 What in the record is unread or surprising for this question

1. **Every one of the seven minimal survivors lists the ramified prime 167 among its UNKNOWN residue asks** (15–30 s budgets), and 167
   is the commonest colouring prime (36 lattices). The dog in the night: the survivors may be timeouts at 167, i.e. four-colourable.
   If so, (Q-obs) has **no instance at ℚ(√167)**. Addressee: the owner (a run), not the competitors.
2. **ℤ/4 additive colourings exist iff 8 ∤ M** (observed on the multiples of 420, not proved). A 2-adic pattern with no mechanism; it
   sits beside `1/2 ∈ ℤ[U]` (the broken wall). Unexplained, cheap, and a derivation a competitor could do in an hour.
3. **(Q-obs) has no benchmark.** No K₄-free graph with `ρ₄ ≥ 2`, a certified `χ_f ≤ 4` and `χ = 5` is known. A general-position `S`
   (at most one ± pair per line) gives `ρ₄ ≥ 2` for free, so every five-chromatic unit-distance lattice (Heule-510's, over K(√5), rank
   ≤ 8) is K₄-free with `ρ₄ ≥ 2`; what is missing is only the `χ_f ≤ 4` certificate (whose absence is unknown, not refuted).
4. **The (Q) no and the (Q-obs) face are independent**, and the scoring rewards the first as a real result. I expect the pull toward
   it to be strong because it is the only face with a published-style construction to copy.
5. Sources *recalled, not read* by me: Burr 1984; Greenfeld–Tao 2022–24; Eggleton–Erdős–Skilton 1990; Chandgotia–Pak–Tassy 2019.
   Held in `~/source/library/papers/`: CGHO cohomology (2510.11969), CGHO undecidability/block gluing (2507.21342), Moore–Newman
   (cond-mat/9902295), Abrishami et al. (2411.01951), Alon–Briceño–Chandgotia–Magazinov mixing (1903.11685).

### 0.5 Where I expect a derivation to break

- Any McShane-type extension at four colours: no Lipschitz structure, so "extend a finite patch periodically" is the open question
  itself. Watch every "realised periodically" (the previous advisor's rule).
- Any Burr transfer without cliques: at the rigid factor (walls).
- Any window-LP certificate at rank ≥ 2: at size (a window holding a refuting patch is that patch).
- Any flux/degree invariant: at the antipode's sign (0.3).
- Any (Q-rig) theorem: at RIG-Y4 (is the engine a clique?) and RIG-Y5 (is the forced δ residue-rigid?).

### 0.6 Registered expectations (probabilities, scored at hand-back)

| id | claim | p |
|---|---|---|
| E1 | a competitor states a (Q-comp) no at rank ≥ 3 using cliques (Burr + rigid factor, or dominoes) | 0.45 (fully meeting Q-N3: 0.20) |
| E2 | a no-go for heights (kind 1) on a triangle-free or square-relator class is stated with proof | 0.40 |
| E3 | a (Q-rig) criterion from MN-type heights that explains de Grey's `F = 8Λ` at least in part | 0.30 |
| E4 | a (Q-obs) yes meeting OBS-Y1–Y5 on a named benchmark with `ρ₄ ≥ 2` | 0.10; one that refuses a ℚ(√167) survivor: 0.03 |
| E5 | the averaged flux (H-A / H-P2) is nonzero on some non-bipartite graph (my 0.3 hunch killed) | 0.05 |
| E6 | at least one competitor retracts a step of the form "realised periodically" | 0.60 |
| E7 | both competitors' first routes are on different faces | 0.50 |

## §1. Evidence inventory

- `data/fs79/records/phase-P0.md` — read against: survivors are genuine hard cases — surprised: **yes** (0.4 item 1: 167 UNKNOWN on all seven)
- `plans/FS79-invariant-question.md` §IQ — read against: the faces as in my brief — surprised: no
- `plans/FS73-derivation.md` T29 — read against: a genuine invariant winding — surprised: **yes** (the winding is forced, 0.3)
- de Bruijn's working file §1 (first route, 4,639 B, read 2026-09-24) — read against: E7 (the two sides on different faces) — surprised:
  **yes** — (Q-obs) no-go by kind (edge-local heights; Claim H via the non-triangle graph `𝒢_S` on S), plus a rank-1 reflection lemma
  (R2) and a non-convex Jacobian reading (R3). Same face and same kind as Coxeter.
- Coxeter's working file §0 (first route, 3,978 B, read 2026-09-24) — read against: E7 — surprised: **yes** — (Q-obs) no-go by kind on
  triangle-free graphs; R1.a is my hunch `the-z2-winding-is-forced`, derived independently (Q₃ = K₄ × K₂); route 2 is H-A/H-P2's
  skyrmion 2-form reached unaided (as the brief foresaw); Kind T blind at five on K_{2,3}-free graphs by Simonyi–Tardos zig-zag.
- Coxeter's message (2026-09-24): square lemma (edge-local closed forms on induced 4-cycles are trivial at four colours; one extra class at
  three), cube lemma (face-local 2-forms on induced 3-cubes: H² = 0; excluding the 24 monopole colourings, H² = ℤ), and on L21cc6506
  KPer(φ) = ⟨U₂⟩ ∩ ⟨U₁ − U₁⟩ of index 8 for each additive φ, KPer = Per for the two Θ₄ colourings, Θ₄ cells with empty interior. Held
  with me (not carried to de Bruijn).

- de Bruijn's working file §2–§6 (24,776 B, read 2026-09-24) — read against: E2 (a height no-go) and my language question —
  surprised: **partly** — C1 (edge-local heights trivial whenever s ~* −s in the non-triangle graph; exact table incl. L21cc6506, Λ₂₄₄₈,
  Λ₂₄₀₀, de Grey; triangular lattice extra 2 = Moore–Newman; corollary: ℤ[ζ₆] is the only unit-distance lattice of rank ≥ 2 with an
  edge-local height); C1-L (the same on the language: de Grey's 9,120 colourings give extra 0; L21cc6506's 10 witnesses give extra 0);
  C2 (a counterexample periodic in r−1 directions needs rigid distinct ends, one chiral); held items: caution taken, H-A/H-P2 declined,
  H-B declined, H-P3 read not taken; reading: at four colours every topological certificate named is trivial, sign-cancelled, or a mod-2
  window frequency. Surprise: the language question was answered by exact computation within the hour, and closed for this format.

- Coxeter's working file §1–§3 (26,783 B, read 2026-09-24) — read against: E2 and my language question — surprised: **partly** — C1
  (winding = parity; my first hunch), C2 (Kind T blind at five on K_{2,3}-free graphs, Simonyi–Tardos zig-zag; reaches every
  unit-distance graph), C3 (square lemma; edge-local heights trivial on triangle-free graphs — **the same theorem as de Bruijn's C1,
  reached independently**, narrower hypothesis), C4 (cube lemma: H² = 0, = ℤ with the 24 monopoles excluded; parity-free face-local
  forms trivial globally where every triple spans an induced cube; the rhombus lemma: no body-diagonal chords among unit vectors), C4′
  (my sign reading adopted, sharpened: deg(Σ) = −Q/2), C6 (KPer(φ) = ⟨U₂⟩ ∩ ⟨U₁−U₁⟩, index 8; Λ/4Λ has 266,928 pinned colourings;
  400/400 sampled Kempe-rigid; periods 4, 4200, 5880 use primes 2,3,5,7 only, all invertible in ℤ[U]), C7 (language on L21cc6506: 378
  of 435 pairs show all four square types, connected; the other 57 are sampling artifacts; monopoles occur in 2,889 of 4,060 triples),
  R1 retracted ("small colouring space"). Surprise: two independent derivations of one no-go within hours (G51's licence), and the C6
  route-(ii) observation that every period seen is a unit at every stable prime.

- de Bruijn §2a, §3a (32,270 B, read 2026-09-24) — read against: my card does-1-edge-ever-certify (hunch: never) — surprised: no (the
  hunch confirmed, by derivation) — Lemma D (a component containing ±s makes 𝒢_S connected), Lemma S (split ⟹ S = ±{a}, ±{a,2a},
  ±{a,b,a+b}, r ≤ 2), C1 complete (kind 1_edge accepts on no graph of 𝒞 at four colours; the split cases carry σ⊗E and are all
  four-colourable, via the three-runner lonely-runner theorem for the dependent triple); §3a: T30's four walls DO have rigid chiral ends
  (period-20), P = 0 from a positive-entropy SCC; rank-1 criterion P ≠ F ⟺ all cyclic SCCs single cycles ∧ a wall; observation: 11
  extensions making all phases rigid lost every wall; a max-D-14 scan queued under the heavy lock. Retraction 1 (step 3).
- CGHO arXiv 2510.11969 §1, §5.1, Thm 5.8, Prop 5.9 (read 2026-09-24, pdftotext at `cgho-coh.txt` here) — read against: "the radius is
  open" — surprised: **yes** — Thm 5.8 is stated for ANY 2-D subshift: a dense Gibbs class + strip-gluing relative to it + a mixing
  direction ⟹ every continuous cocycle into a discrete group is trivial (all radii); §6 higher d. So the radius question on our class is a
  dynamical-property question, not a radius induction.

- Coxeter's message (Q1 answer, R2, CGHO response; 2026-09-24) — read against: my card does-1-e-ever-certify — surprised: partly — Q1:
  acceptance only degenerately (a relation cycle spanning a non-four-colourable subgraph: the refutation in disguise); non-degenerate
  acceptance on K₄-free graphs open, its reading "never"; R2 (format excluded FS-73's height); CGHO card taken as the named next step, no
  budget to prove the Lemma 5.3 analogue. Census (question 2) pending.

- Coxeter's C8 message (2026-09-24) — read against: card kper-census, branches rank<4 / all rank 4 — surprised: no (rank-4 branch):
  4,490 orbits of pinned Λ/4Λ-colourings (266,928); least KPer rank 4 in every orbit; ∩ of all KPers = exactly 12Λ; with Per(θ₁),
  Per(θ₂): index 1,778,112,000, containing 29400Λ (29400 = 2³·3·5²·7²); P ⊆ H by T36; 29400u has 1/δ ∈ ℤ[U]; finiteness and forcing not
  shown. Pinned format: matches its corrected C3; nothing breaks.

## §2. Hunch ledger

hunch: the-z2-winding-is-forced
  claim: the ℤ/2 winding of a four-colouring on the relation lattice equals the ℓ¹ parity of the relation, for every colouring
  basis: derived
  falsifier: a four-colouring of some `Cay(Λ,S)` whose Q₃-lift satisfies `h(x+ρ) = h(x)` for an odd-ℓ¹ relation ρ
  registered: 2026-09-24
  status: confirmed (by: Coxeter's independent derivation, working file §0 R1.a: Q₃ = K₄ × K₂ is the bipartite double cover, the
    winding on ρ is ‖ρ‖₁ mod 2 for every colouring; derived before any message from me)

hunch: the-mean-flux-vanishes
  claim: every translation-averaged oriented S²-degree density of a four-colouring vanishes on every non-bipartite `Cay(Λ,S)`
  basis: derived
  falsifier: an exact periodic four-colouring of a non-bipartite graph with nonzero mean signed face count on some grid plane
  registered: 2026-09-24
  status: confirmed (by: Coxeter's derivation C4′, sharpened to deg(Σ) = −Q/2, and de Bruijn's §5 premise check; the parity-free cube
    lemma recomputed by me at P3 is its local form)

hunch: edge-label-heights-need-triangles
  claim: a V₄-edge-label cocycle on a generator pair spanning no triangle is constant, whenever both square types occur
  basis: derived
  falsifier: a triangle-free `Cay(Λ,S)` with a nontrivial MN-form height
  registered: 2026-09-24
  status: confirmed and sharpened (by: de Bruijn C1 + Lemmas D, S — nontrivial only for S = ±{a}, ±{a,2a}, ±{a,b,a+b}; Coxeter C3)

hunch: survivors-are-167-timeouts
  claim: at least one of the seven minimal survivors is four-coloured by a residue colouring at the ramified prime 167 given a longer budget
  basis: measured
  falsifier: the 167 asks on all seven decided UNSAT (refused) at a longer budget with symmetry breaking
  registered: 2026-09-24
  status: open

## §3. Cards

question: are-the-survivors-timeouts-at-the-ramified-prime
  evidence: phase-P0.md minimal-survivor table — all seven list 167 as UNKNOWN; for 4200, 10920, 14280, 24360 it is the only
    undecided residue target; screen.jsonl rows "residue:167/0": circle 168, image 40, kissat 15 s, pins + precedence, UNKNOWN
  expected: survivors fail every residue target by refusal, not by timeout
  ask: do the seven minimal survivors refuse four colours at the 167 residue target, or were they only asked for 15 s?
  if some colour at 167: the instance list shrinks; if all seven colour, (Q-obs) has no instance at ℚ(√167) and both competitors hear it at once
  if all refuse: the survivors are genuine refusals at every residue target asked, and the table says so
  answered by: run
  cost: minutes to ~3.5 h of one heavy slot
  hunch: at least one of the seven colours at 167
  falsifier: all seven UNSAT at 167 at a longer budget
  rank: 1
  sent: to the owner (`main`), 2026-09-24, before any competitor contact. Fate: **taken** — the owner is running it (seven
    distinct images at 167 across the twelve survivors, sizes 24, 40, 40, 72, 72, 72, 56; six survivors share one 40-point image;
    gap-aimed then plain, 300 s each; `data/fs79/phase0/owner-recheck-167.jsonl`). Correction to my card: phase 0's `residue_ask`
    had already run the exhaustive linear-form pass and the Hoffman floor at 167 — my "seconds" branch was already done. Outcome: blank.

question: (to both, identical, same moment, 2026-09-24) the held items H-A, H-B (with the owner's citation check), H-P2, H-P3, verbatim,
    labelled as guesses; a scoring note for narrow-format no-gos; my caution that the averaged S²-degree vanishes on non-bipartite graphs
    (hunch the-mean-flux-vanishes, with its falsifier); and the second question below. Text: `held-offer.txt` (md5 4704a10a…).
  Fate: blank.

question: local-admissibility-versus-the-language
  evidence: de Bruijn §1 R1 fixes kind 1_edge as "the cocycle identity on every locally admissible colouring" of squares and relation
    cycles; Coxeter's square and cube lemmas quantify over "every proper 4-colouring of an INDUCED 4-cycle / 3-cube"; de Grey's lattice
    has 9,120 colourings in 12 classes, so most local square patterns never occur there
  expected: a no-go over local patterns transfers to the colouring shift
  ask: is the cut that matters the window's radius, or local admissibility versus the language of X(Λ,S,4)?
  if every local cell pattern occurs in X on the class: the cell lemma is complete at its radius and the radius question is the right one
  if some do not occur: the no-go must be stated on the class where local and global languages agree, or proved over the language
  answered by: derivation
  cost: an hour's derivation; checkable on de Grey's lattice and the grid
  hunch: on loose triangle-free lattices every locally proper square pattern occurs; on de Grey's lattice many do not
  falsifier: a loose triangle-free lattice where some locally proper square colouring extends to no global colouring
  rank: 1
  sent: to both, inside the held-items message. It answers de Bruijn's question (1) (with the scoring note) and Coxeter's question
    ("is local in one cell the wrong cut?"). Fate: blank.

question: does-1-edge-ever-certify (to de Bruijn alone, 2026-09-24; answers his own route; logged here for Coxeter at hand-back)
  evidence: de Bruijn §2 table — the only split presentations (ℤ[ζ₆], Cay(ℤ,{1,2,3})) are four-colourable; adding one direction kills the
    split; a split needs every cross pair a = −b or a − b ∈ S
  expected: a no-go about a format that certifies something somewhere
  ask: does kind 1_edge accept a certificate on any non-four-colourable graph in 𝒞?
  if never: the no-go's weight is "the edge-local format is empty at four colours on 𝒞"; the radius question is the only live one for heights
  if somewhere: C1 is "alive in 𝒞, blind on the target", the stronger OBS-N statement
  answered by: derivation
  cost: about an hour
  hunch: never (edge-local-format-is-empty-at-four)
  falsifier: a non-four-colourable graph with a split non-triangle graph
  rank: 1
  also sent: C1 step 1 checked (holds); C1 step 3 gap (a 𝒢-edge between components cannot exist; the ±-closed multi-component case
    needs the rainbow cross-square argument: N_i = δg_i, then g1 − g2 constant from the three pairings) — not needed by corollaries (a), (c);
    scoring (C1 met except OBS-N2 partial until step 3 is replaced; C1-L met on its instances; C2 closes, type (a)); and a rank-2 second
    question for C2 (which of C2's conditions fails on each of T30's four walls). Fate: blank.

question: does-1-e-ever-certify + kper-census (to Coxeter alone, 2026-09-24; answers its own route; logged here for de Bruijn)
  evidence: C3 controls carrying extra classes are four-colourable; C6's "400 of 400 KPer rank 4" is a sample of a complete enumeration
    (266,928 pinned, ~500 orbits)
  expected: a no-go about a format that certifies something; a rigidity reading drawn from the whole set
  ask: (1) does kind 1_e accept on any non-four-colourable graph in 𝒞? (2) over all Λ/4Λ orbits, the least KPer rank and the index of ∩KPer ∩ Per(θ₁) ∩ Per(θ₂)?
  if (2) some rank < 4: P rank < 4, X infinite (T37), route (ii)'s finite-space hope dies at L21cc6506
  if (2) all rank 4: an explicit finite-index upper bound on P; whether it holds N₀u (N₀ from 2,3,5,7) needs a forcing certificate (a run)
  answered by: derivation (1); run (2)
  cost: an hour (1); minutes (2)
  rank: 1 (question 1 on weight), 2 (question 2 on the target)
  also sent: square lemma step (iii) checked (edge coefficients 12, 34, 23 force α = β = γ = 0); C3 gluing checked; C4 gluing read at
    sketch level (flagged for P3 re-derivation); scoring (C1 met; C2 met conditional on reading Simonyi–Tardos, not recalling; C3 met;
    C4 met pending P3; C4′ credited; C6 lemma checked, R1 counted; C7 met). Fate: blank.

question: cgho-5-8-decides-the-radius (to BOTH, identical, same moment, 2026-09-24; frame-level: both stated "radius open" as OBS-N4)
  evidence: CGHO arXiv 2510.11969 Thm 5.8 (any 2-D subshift; dense Gibbs class + strip-gluing + a mixing direction ⟹ all continuous
    cocycles into discrete groups trivial); Lemma 5.3 derives strip-gluing from the trivial even square group by grid pattern completion
  expected: an all-radius height no-go needs a radius induction
  ask: on triangle-free rank-4 lattice graphs, does X(Λ,U,4) have a dense Gibbs class, strip-gluing relative to it, and a mixing direction?
  if yes: heights of every radius are trivial there, by citation plus one gluing lemma (the analogue of Lemma 5.3)
  if no: the failure is frozen/rigid structure, the rigidity face's object; a large-radius cocycle could be nontrivial exactly there
  answered by: the record, then a derivation
  cost: an hour of reading; the gluing lemma priced after
  hunch: on L21cc6506 the Gibbs classes are not dense (every sampled colouring Kempe-rigid; held, Coxeter's C6, not sent)
  falsifier: a finite-support recolouring of a four-colouring of L21cc6506 (two colourings differing on finitely many sites)
  rank: 1
  sent: to both. Fate: blank.
  also sent to de Bruijn alone: §2a/§3a scoring (Lemma D, Lemma S, C1(b) type checks read; C1 complete met on OBS-N1–N4; C1(c) cites
    lonely runner — reading status asked; retraction 1 counted; §3a's rank-1 criterion read both ways; a note to check the owner cleared
    the heavy-lock scan).

ruling: kind-1_edge-pinned (to BOTH, identical, same moment, 2026-09-24; asked for by the owner as a reconciliation)
  text: `pinned-1edge.txt` here. Squares only (chorded squares with reduced patterns); winding on R and slope as the datum; admissible set
    from S and A alone (value sets, hulls, value group, d(ρ) = Σρ_s m_s); no colourability test of any window larger than a square.
  why: (1) relation-cycle closedness forces winding 0 and excludes FS-73's height (Coxeter's R2); (2) acceptance through a locally
    non-colourable window is a plain refutation (OBS-Y5(b)).
  effect on scoring: de Bruijn's C1 (complete) is stated in this format — met, "accepts on no graph of 𝒞". Coxeter's C3 (after R2) is
    in this format — met on triangle-free graphs; its Q1 "degenerately yes" is not an acceptance under the pin, so its Q1 answer is
    "non-degenerate: open (reading: never)" — partial. The asymmetry (de Bruijn proved what Coxeter left open) is not carried to Coxeter.

question: theta4-cell-dimension (to Coxeter, 2026-09-24; its route; also for the verification phase)
  evidence: C8's H uses two Θ₄ points; C6 says their cells have empty interior (maximal slack 0), which is not "the cells are points"
  expected: a finite-index bound on P that survives the linear colourings of every period
  ask: what is the dimension of each Θ₄ cell of L21cc6506, and are there other cells?
  if some cell has dimension ≥ 1: P ⊆ ker v (rank ≤ 3), X infinite (T37), H collapses; 29400u survives only if v(29400u) = 0
  if every cell is a point: H is the linear part of the bound; the forcing run at N₀u is well aimed
  answered by: derivation (exact LP per cell) + an exact Θ₄ cell enumeration
  cost: minutes for the two known cells
  hunch: at least one known cell has dimension ≥ 1 (maximal slack 0 with only 14 and 12 of 60 constraints tight in a 4-dim torus)
  falsifier: both cells are points (their tight constraints have rank 4)
  rank: 1
  sent: to Coxeter. Fate: **answered, hunch confirmed** (Coxeter C8′: the order-4,200 cell is a point; the order-5,880 cell has
    dimension 2, its 12 fixed constraints are exactly U_R; P ⊆ rank-2 subgroup ⊇ rational layer; L21cc6506's four-colouring space is
    infinite; route (ii) survives only as "is some N₀u_R forced, N₀ | 29400?", a run).

## §4. Retraction tally

| side | count | what killed each |
|---|---|---|
| de Bruijn | 1 | step 3 of C1 as first written (a 𝒢-edge between components cannot exist) — killed by my reading; replaced by Lemma D |
| Coxeter | 2 | R1 (C6): "L21cc6506 may have a small four-colouring space" — killed by its own complete enumeration, 266,928 pinned colourings of Λ/4Λ. R2 (C3): the format demanded closedness on every relation cycle, which forces winding 0 and excludes FS-73's height it claimed to contain — found by Coxeter on re-reading after my check; corrected to squares closed + winding as datum; controls recomputed (triangular 8/6, grid 5/5, G(ℤ,{1,3}) 5/5) |
| Poros | 0 | |

## §4a. Expectations scored (§0.6), 2026-09-24

| id | p | outcome |
|---|---|---|
| E1 (Q-comp) no at rank ≥ 3 with cliques | 0.45 | **lost**: neither side went there; both chose (Q-obs) no-gos |
| E2 height no-go proved | 0.40 | **won**: twice, independently (de Bruijn C1 complete; Coxeter C3) |
| E3 (Q-rig) via MN heights explaining de Grey | 0.30 | **lost**: de Bruijn showed de Grey's rigidity is not an edge-local height, even on its language; a many-layer effect |
| E4 (Q-obs) yes on a benchmark | 0.10 | not landed, as expected |
| E5 averaged flux nonzero | 0.05 | not observed; killed by derivation (C4′) |
| E6 a "realised periodically" retraction | 0.60 | **lost** as registered; the nearest were Coxeter's R1 (small space) and its C6→C8′ supersession (slack vs dimension) |
| E7 different faces at first route | 0.50 | **lost**: same face, same kind |
Calibration: the two confident misses (E1, E6) were about the competitors' paths; the mathematical hunches (all five derived ones) were
confirmed. My path predictions were worse than my mathematics.

## §5. My own errors

1. **Card to the owner, stale branch** (2026-09-24): I proposed an exhaustive linear-form pass at 167 "in seconds"; phase 0's
   `residue_ask` had already run it (and the Hoffman floor) before every SAT ask. Caught by the owner. Cost: nothing.
2. **Incident: an interim hand-back leaked Coxeter's held progress to de Bruijn** (2026-09-24). The harness demanded a
   SubagentHandback; I wrote a full report addressed to the owner. Because de Bruijn's SendMessage had last woken me, the harness made
   de Bruijn my caller, and the hand-back went to **de Bruijn**. It carried Coxeter's square and cube lemmas (H² = ℤ with monopoles
   excluded), the index-8 Kempe period groups on L21cc6506, the Simonyi–Tardos zig-zag no-go, and my status notes (E2/E7, my hunches'
   state). de Bruijn disclosed it at once and undertook not to use it; the owner told Coxeter what leaked. **Mechanism:** the hand-back
   channel's addressee is whoever resumed me last, not the agent that launched me; I assumed the latter. **Fix (the owner's rule, applied
   from now on without exception):** every hand-back is exactly "Poros idle; no content in this hand-back; my reports go to the owner by
   SendMessage."; every report to the owner goes by SendMessage to "main"; every card to a competitor by SendMessage to that competitor
   explicitly; a background watcher's completion is treated the same way. **Consequence for scoring:** from this point de Bruijn has seen
   Coxeter's local results; any later de Bruijn claim that overlaps them (a face-local 2-form cohomology, the monopole count, KPer on
   L21cc6506, the zig-zag argument) is weighed with that in mind, and the independence of the two openings holds only up to this moment.

3. **Missed Coxeter's R2 while scoring C3 "met"** (2026-09-24). I read the gluing including "Σκ = 0 on every relation" and did not
   ask what closedness on relation cycles does to the winding (forces it to 0, excluding FS-73's height the format claimed to contain).
   Mechanism: I checked the proof's steps and not the format against its own stated positive control, which is the §10a second question
   I am here to ask. Caught by Coxeter. Cost: one scoring line, corrected.

## §7. P3: re-derivation of Coxeter's C4 gluing (2026-09-24)

**Input re-derived by tools** (`p3/cube_parityfree.py`, `p3/cube_parity_ctl.py`, standard library only, independent of Coxeter's code):
parity-free face-local 2-forms on the induced 3-cube at four colours — 252 unknowns, 2,652 proper cube colourings (24 monopoles).
Closed dimension 33 with all colourings and 33 without monopoles; exact forms (dη + κ, κ per face type) dimension 33; so H² = 0 both
ways, at p = 2³¹−1 and 2⁶¹−1 (upper bound meets lower bound, so exact over ℚ). Control d∘d = 0: 0 failures. **Positive control**, the
sheet-dependent format: closed 65 (all) / 66 (no monopoles), exact 65: H² = 0 / 1, reproducing Coxeter's C4 numbers. *My own defect,
caught by the control:* my first control made κ parity-dependent, which is not closed (d∘d ≠ 0 on 2,400 rows, exact > closed); fixed to
κ per face type, as Coxeter's format has it.

**Gluing, re-derived by hand.** (1) A_ij ≠ ∅ by the cube lemma on any triple ⊇ {i,j}. (2) Two elements of A_ij differ by ζ with dζ
constant; abab and baba give opposite values, so dζ = 0, and the square lemma makes ζ = (δg + c, δg + c′) with one g: A_ij is a coset
of that group. (3) proj_i(A_ij) = proj_i(A_ik), since the cube lemma's single primitive on {i,j,k} lies in both cosets of
B = {δg + c}. (4) Fix η_i ∈ P_i; on {i,j}, η_i = a_i + δh_i + c_i and η_j = a_j + δh_j + c_j, and d_ij = h_j − h_i ∈ ℚ^colours/ℚ is
well defined (δh + c = δh′ + c′ forces h − h′ constant and c = c′; re-basing inside A_ij shifts h_i and h_j alike). (5) The cube
primitive gives d_ij + d_jk + d_ki = 0; the 2-skeleton of the simplex on the n directions is simply connected, so d = δf, and
η_i − δf_i is a global primitive. (6) The flux of dη̃ + κ over any relation torus: dη̃ telescopes (parity-free η depends only on
colours, and identified boundary edges carry equal colours by R-invariance, so odd relations are allowed too); κ counts face types by
the torus's projected areas. The flux is colour-independent.

**Verdict: holds, with one repair.** The hypothesis needs **at least three pairwise non-parallel directions** (n ≥ 3), or "every pair
of directions lies in a triple". With n = 2 the triple condition is vacuous, every face-local form is closed, and the conclusion is
false: the induced square has 84 patterns against at most 25 exact dimensions. The stated class "every triangle-free unit-distance
lattice graph" includes ℤ[i] with U = {±1, ±i} (n = 2). The flux consequence is vacuous there (R has rank 0, so there is no relation
torus), so nothing downstream breaks. Every ℚ(√167) lattice has n ≥ 18. Minor: the restriction to even relation tori is unnecessary
in the parity-free format.

## §6. Hand-off (for a successor)

CLOSED (2026-09-24): advising ended; P3 verdict in §7; final report sent to the owner by SendMessage. Nothing open with either competitor.

CHANNEL RULE (owner, 2026-09-24): hand-backs are content-free, exactly "Poros idle; no content in this hand-back; my reports go to the owner by SendMessage." Reports go to main by SendMessage.

State (2026-09-24): expectation written (§0); card to the owner on the 167 survivors taken (owner running it); both first routes read;
held items + scoring note + flux caution + the language question sent to both at the same moment. Next: read their replies; score each
first theorem against its face (both are heading for OBS-N no-gos of the edge-local/face-local kind on triangle-free graphs); ask the
product-axis question (what is the positive route at the target?) once a no-go is proved, not before.
