# FS-86: four-colour rigidity over ℚ(√59) and ℚ(√83). The plan

*Opened 2026-09-24/25 by the stage-A planner (de Bruijn, Opus 5.5), advised by a plan-phase Poros. WORKFLOW 2.0 steps 3–5:
§0 the milestone after the reframe; §G the re-grokking; §PA the prior-art gate; §IQ the invariant question; §S the subplan (with "rich"
defined in §S.1); §B stage B's brief slots; §C the competition's brief text; §P predictions and verdicts; §M the modeling decision; §X the
planner's search log; §Y the exchange with the advisor. The stub is `plans/STUB-dyadic-rigidity-triangle-free.md`; the close inventory is
`plans/FS86-close-inventory.md` (the coordinator's). It runs in the finite-witness-free week to 2026-10-01 (`CLAUDE.md` § Toolchain). The
planner's spec checks are in `data/fs86/stageA/` (exact unless marked float; each seconds).*

## §0. The milestone after the reframe (read this first)

1. **ℚ(√59)'s dyadic local plane is row 67's tower, which is solved.** `59·3 = 177 ≡ 1 (mod 8)`, so `ℚ₂(√59) = ℚ₂(√3)` and
   `ℚ₂(√59, i) = ℚ₂(ζ₁₂)`: the local extension with its conjugation is exactly FS-38's `O = ℤ₂[ω][√3]`, `𝔓² = (2)`. The same holds for
   every `d ≡ 3 (mod 8)` (83, 131; and each dyadic place of K). [exact, two independent checks: the planner (the congruence), Poros (PARI:
   one prime above 2, `e = f = 2`, `issquare(3d + O(2^10))`).] So the full local tower's elementary-divisor certificate (FS38-L3: `𝔓⁴ ⊆ M`,
   `𝔓³ ⊄ M`), its tightness at every level (FS38-L1, D2-A) and its colouring space (FS38-D2-B: every four-colouring of `P_m`, `m ≥ 5`, is
   pulled back from `P₄`; `Forces ⟺ 𝔓⁴`; kernel at levels 4–5, row 67) are theorems already. **The stub's routes 1–2 on the full local
   plane are done.** What its routes 1–2 can still ask is about a lattice's *image*: a lattice has finitely many unit vectors, so its
   quotient `Q_m = Cay(Λ/(Λ ∩ 𝔓^m), U mod 𝔓^m)` is a spanning subgraph of `P_m` and stops being `P_m` once `|S_m| = 3·2^{m−1}` exceeds the
   residues `U` reaches. Contrast with de Grey's lattice: it spans `E = ℚ(√−3,√−11)`, whose completions at 2 are the *unramified*
   `ℚ₂(ζ₃)`; a rank-4 lattice over ℚ(√59) spans `F(i)`, whose completion is the whole ramified `ℚ₂(ζ₁₂)`. The two share only level one, `K₄`.
2. **Free, by row 67's own transfer clause:** every lattice or field plane over ℚ(√59) maps homomorphically into every `P_m`, and `P₄`'s
   colourings separate every difference outside `𝔓⁴`, so **`F ⊆ P ⊆ (Λ ∩ 𝔓⁴)`**. A forced difference, if any, has dyadic depth ≥ 4.
3. **At the field level the milestone's question is binary, and its weak form is essentially free (Poros's frame item FR-1, adopted; §Y).**
   Write `R = ℤ[U_F]`, the ring the unit vectors of `F(i)` generate; the unit-distance graph on `F²` is a disjoint union of copies of
   `Cay(R, U_F)` (FS79-T6's form). [hand, Poros, one mind; the planner checked the argument, not blind — **stage B derives it blind**]
   - (i) `F(R) = ⋃ F(Λ)` over finitely generated sublattices (forcing is monotone upward; `forces_iff_exists_finite`, row 78, kernel), while
     `P(Λ) ⊆ P(R) ∩ Λ`: on a lattice, `F` is the field's `F` restricted, and `P` is a different, lower question.
   - (ii) `F(R)` is an ideal of `R` (G55's transport `z ↦ t + u(z − a)`), and a nonzero ideal of `R` has finite index (it holds a nonzero
     integer `c`, and `R/cR` is finite because `1/p ∈ R` at every non-stable `p` and `R` is `p`-integral of rank ≤ 4 at every stable `p`). So
     **`F(R) ∈ {0, P(R)}`**: either some four-colouring of `Cay(R, U_F)` is not periodic, or every one is. **Scope, stated once** (Poros):
     `F(i) ≅ ℚ⁴` is divisible, so no four-colouring of `F²` is periodic under a finite-index subgroup of `F(i)`; "periodic" and "local at 2" are
     meant **per `R`-coset** (FS79-T6's components, each coloured independently, so pairs in different cosets are free). The global form is
     "every four-colouring of `F²` is `F(R)`-invariant"; `F(F²) = {(y, y′) : same `R`-coset, y − y′ ∈ F(R)}`.
   - (iii) `P(R) = R ∩ 𝔓⁴` for ℚ(√59): a periodic colouring factors through a finite quotient of `R`, which is a product of stable local
     planes (`1/p ∈ R` at non-stable `p`); by weak approximation for the norm-one torus, `U_F` fills the product of local unit groups, so the
     quotient graph is the categorical product `P_m × H`, `H` the product of the odd stable towers' levels; every factor of `H` has `α/n < 1/4`
     at every level (11 and 23 by row 75; the split stable primes by G54's constant ratio; **the ramified 59 by Poros's fibre argument**, ratio
     ≤ max(0.199, 2/62)); so `[Zhang2012]` Thm 1.8(i) (MIS-normality, held, read) makes every colour class a pullback from `P_m`, and row 67
     finishes. **So the stub's "Yes, `P₄ ≠ 0`" is free at the field level** (G21's trap: registered in §P as a free outcome, not an informative
     one), and **the milestone's question is `F(R)`: is every four-colouring of the plane over ℚ(√59) periodic — equivalently, local at the
     dyadic place, pulled back from `P₄`?** Yes is Soifer-strength (FS85-dB4: a finite triangle-free subgraph forces a pair, then the generic
     chain). No is a non-periodic four-colouring of a four-chromatic field plane.
4. **A known positive at the field level — and it is itself a new classification — and a known negative.** Row 85: `F(Λ_dG) = 8Λ`, and
   forcing is monotone upward (the component of 0 in `Cay(Λ, U)` is `span U ⊆ R_K`), so `F(R_K) ⊇ 8Λ ≠ 0`; by (ii) every four-colouring of
   each `R_K`-coset is periodic. **At K there are two dyadic places with equal independence ratio 1/4**, which is `[Zhang2012]`'s case (ii), so
   MIS-normality does not choose between them; **tightness does** (Poros): the categorical product `P_m × P′_m` of two four-tight graphs is
   four-tight with least eigenspace exactly the pure characters `χ ⊗ 1`, `1 ⊗ χ′`, so dB6's `{0,1}`-valued `G(X) + H(Y)` splitting and the
   owner's union step put every class at one prime; the odd part at K (11, then nothing below 83; G44) has `α/n < 1/4` and Zhang (i) handles
   it. **Result: `F(R_K) = R_K ∩ 𝔓⁴ ∩ 𝔓′⁴ = 4R_K`, and every four-colouring of every `R_K`-coset is a pullback from `P₄` at one of K's two
   dyadic places** — a classification of every four-colouring of `K²`, beyond anything the record holds over K. Check that could have failed
   and did not (Poros): `4, 8/3, 8/9, 16/3` and row 78's `v` lie in `4R_K` (`1/3 ∈ R_K`); `2P ∉ 4R_K`, and Fischer's ℤ/4 colouring separates
   `(0, 2P)` (G41). On `Λ_dG` itself `4R_K ∩ Λ = 4Λ ⊋ 8Λ = F(Λ)`: the field forces more than the lattice (`F(Λ) ⊆ F(R) ∩ Λ`). [hand, Poros; the
   planner's first four-line version missed the equal-ratio step; **needs its own two derivations and prior-art check — B1**; logged for the
   close as a candidate theorem, not a control only.] Negative: ℚ(√11) (`d ≡ 3 mod 8` too, the same dyadic tower) has a usable 7 whose `Γ₇` has
   `α/n > 1/4`, so MIS-normality pulls back from `Γ₇` instead and `Γ₇`'s gap frees every pair: `F(R_{ℚ(√11)}) = 0` (row 66, recovered by the
   same theorem). **ℚ(√59) sits between: one copy of K's dyadic tower, no triangles, no gapped stable plane.**
5. **Stripped of arithmetic the question is already answered** (FR-2): dB2 is a triangle-free Cayley graph of ℤ whose four-colourings all
   factor through `Cay(ℤ/4, D mod 4) = K₄`, tight. So the most general class where the question is open keeps the rotation structure: **the
   ring `R = ℤ[U_F]` with `U_F` the full norm-one group of `F(i)`**, which is what buys (ii). §IQ poses it there.
6. **The stub's arithmetic, corrected** (exact, `data/fs86/stageA/`): the stable odd primes of ℚ(√59) are **11, 23, 31, 43, 47, …** and the
   **ramified 59** (inert in `F(i)/F`); 19 is inert in ℚ(√59) (`q = 361 ≡ 1 mod 4`), not usable — H5 and the stub listed "11, 19, 23". For 83:
   19, 43, 47, …, ramified 83 (11 not usable). For 131: 19, 23, 31, 47, …, ramified 131. H5 did not consider the ramified prime, which at
   ℚ(√167) alone coloured 36 lattices with gaps (row 81).
7. **"Rich" is defined in §S.1**, with a named instance **`Λ₅₁₀`** (the saturated chain at `M = 2·3·5·17`, 324 unit vectors, `Λ₅₁₀ ⊗ ℤ₂ =
   O_𝔓`, `1/3, 1/5, 1/17 ∈ Λ₅₁₀`) and a named non-example `Λ₂₇₃₀` (its image at the ramified 59 is 44 of 60 points, not refused by Hoffman).
8. **The shape.** Stage A (this plan). **Stage B**, one agent, one day: a blind second derivation of item 3 and the lattice profile of
   `Λ₅₁₀` (routes 1–2 on the lattice). **Stage C**, the competition (Kooshi's ruling), on the field question `F(R)` and its structural form.
   **V**, a blind verifier for any claimed yes or no. **E**, the close by 2026-10-01. Route 4 (composite quotients) is **moot at the field
   level** by item 3(iii) and becomes a lattice-level item after the week (§S.2).

## §G. The re-grokking (WORKFLOW 3.1)

*Walked with `CLAUDE.md` (from disk at `b5e458bb`), `LEDGER.md`, `plans/FS85-derivation.md`, `plans/FS38-derivation.md`,
`plans/FS79-derivation.md` and `plans/FS81-derivation.md` open. Verdicts: **B** bears (with where it lands), **S** silent (why), **F**
falsifiable here (registered in §P). Landing codes: →0 §0; →S.1 rich; →B stage B; →C the competition text; →T the trivial list (§S.4);
→IQ; →P.*

### G.1 The grokkings

| id | v | reason, and where it lands |
|---|---|---|
| G1 | B | `d ≡ 3 (mod 8)`: no odd square class ≡ 7, the wall stands, Theorem A four-colours the plane at the dyadic prime; the dyadic target is the whole four-colour story. →0 |
| G2 | S | construction grammar of built objects; nothing is built |
| G3 | S | witness radii |
| G4 | S | five-forcer shell inventory |
| G5 | S | the 1581's 1-sum |
| G6 | S | the hexagram as fabric |
| G7 | B | ℚ(√59)'s unit vectors are layers of `U₅` rotated by the type-M `v₁₅ = (29 + i√59)/30` (`n = 15`, radicand 59): the true denominator 30 in `U_M` is that rotation. →C (vocabulary) |
| G8 | S | K's direction group; no √3, √11 here |
| G9 | B | every four-colour forced pair known sits at positive dyadic depth (4, 4/√3 over K); item 2 makes depth ≥ 4 a theorem here. →0, P-depth |
| G10 | S | sampled criticality; no search |
| G11 | B | Moser-free five-forcers go "forced pair, then spindle"; a yes here goes "forced pair, then generic chain" (dB4) out of the field. →0 |
| G12 | S | one detune's conic; no arena |
| G13 | B | a fan gap frees every pair: `F ≠ 0` ⟹ every four-colouring gap-free. →T |
| G14 | S | matchings; no arena |
| G15 | B | a yes is a finite gadget (`forces_iff_exists_finite`); its shape is pigeonhole × kill. →IQ |
| G16 | B | the residue colouring identifies every pair at positive valuation; here the level-one `K₄` colouring identifies `R ∩ 𝔓`, and item 2 sharpens to `𝔓⁴`. →T |
| G17 | S | top-rung globality; no search |
| G18 | S | composition of certificates; no solver |
| G19 | S | five-colour class sweeps |
| G20 | S | brick colourings |
| G21 | B | (method) the free field-level `P ≠ 0` is G21's trap (§0.3); the record's triangle-free null measured only enumerated fields (H5's frame); the planner's Hoffman numbers are float, aiming only. →P, X |
| G22 | S | six-colourings |
| G23 | S | cell family |
| G24 | S | cell family's integrality gap |
| G25 | S | six-forcer kills |
| G26 | S | six-gadgets |
| G27 | B | the Galois flip `√59 ↦ −√59` is an automorphism of the field plane (not an isometry); `F(R)` is flip-stable — a free symmetry of the colouring space. →C |
| G28 | S | fine-tail forcing |
| G29 | S | cell family closed |
| G30 | B | (method) mode 5: "rich" ships an inhabitant (`Λ₅₁₀`); mode 7: a yes stated on a class must not be implied by an empty domain. →S.1 |
| G31 | B | ask one rung below the top: FS-86 asks four colours in a four-chromatic field, the rung where rigidity has been seen. →0 |
| G32 | B | a four-colour forced pair is a `{1, δ}`-graph with one δ-edge refusing four: the finite form of a yes. →IQ |
| G33 | S | batch descent |
| G34 | S | in-field descent |
| G35 | B | the wall stands; `1/2 ∉ R`; the dyadic place is stable (inert in `F(i)/F`), G56's trichotomy case "inert". →0 |
| G36 | B | the residue colouring is the canonical separating colouring; `P₄`'s tables are its depth-4 refinement. →T |
| G37 | S | five-colour endgame |
| G38 | B | the linear method at `d ≡ 3 mod 8` gives four via the dyadic bound (`[Fischer1990]` Thm 10(i)); additive colourings are the positive control. →C |
| G39 | B | a pair forced at χ colours confines the critical set to two vertices within distance 2 (row 48): any finite yes-gadget has redundancy. →T |
| G40 | B | absorption: thinly joined material carries no compulsion; predicts that a sparse `Q_m` (past saturation) frees pairs. →B, P-slack |
| G41 | B | additive colourings bound `F` from one side: `F ⊆ ⋂ ker φ`; the dyadic residue map `R → 𝔽₄` is additive. →T, C |
| G42 | S | additive rigidity |
| G43 | B | the sieve at ℚ(√59): stable odd 11, 23, 31, 43, 47, ramified 59 (19 not); residue degree checked. →0 item 6 |
| G44 | B | Γ_p from 59 up refuses five; the full ramified 59 circle's Hoffman ratio is 0.199 < 1/4. →S.1 |
| G45 | S | design-and-lift |
| G46 | B | (method) recognise the classical theory: the tetrahedral embedding is a vector 4-colouring (§PA.3). →PA, IQ |
| G47 | B | compulsions map forward along homomorphisms; plane freedom at stable odd primes. →0 item 3 |
| G48 | B | L(ℚ(√59)) = 4 = χ; FS-86 is the conjecture's *colouring-level* form, "is every optimal colouring local at a place achieving L" — the question G48 names for FS-64/66/67. →0, IQ |
| G49 | B | (method) the gate: author listings, zbMATH, the question searched. →PA |
| G50 | B | (method) held-and-unread: `[Zhang2012]`'s MIS-normal half never cited (Poros); Soifer ch. 55; GRR held now. →PA |
| G51 | B | (method) competition plus advisor; verification is where contest begins (rule 11). →S.2 |
| G52 | S | equal-radius family of arenas |
| G53 | S | counting compulsion for arenas |
| G54 | B, F | the tight dyadic target; its middle case (row 87); its killing test can fire on `Q_m` (a slack level whose colourings are all gap-free and pull back from no tight quotient). →B, P-slack |
| G55 | B | prime inversion (1/p ∈ R at 3, 5, 7, 13, 17, 19, 29, …); the transport makes `F(R)` an ideal (§0.3 (ii)); never chainable in `F` (FS79-T2). →0 |
| G56 | B | the primes above 2: inert, `U₂ = K₄`; four-colourable, tight. →0 |
| G57 | B | √59 has no √3: the plane is triangle-free; its target `K₄` is not (H4: the triangle sits in the quotient). →C |
| G58 | S | antipodal finder |
| G59 | B | α/n of the stable planes and `[Zhang2012]`: §0.3 (iii)'s hypothesis `α/n < 1/4` at every level. →0, B |
| G60 | B | `F ⊆ F_μ ⊆ P`; strengths of a yes; the fractional cap here is `χ_f(K₄) = 4`. →T, C |
| G61 | B | 1/3 ∈ R and an odd cycle: χ ≥ 4 (row 82); 3-integral lattices are three-colourable (row 72). →S.1 |
| G62 | B | lattices are multilayers of `U₅`; commensurate twists are periodic. →C |
| G63 | S | transcendence |
| G64 | S | six as a value |
| G65 | S | ball hardness; no balls this week |
| G66 | B | `P = F_clopen`; the odd towers (row 75); the chain `F ⊆ F_μ ⊆ F_meas ⊆ P`; at the field level the profinite completion is the product of local planes (§0.3 (iii)'s frame). →0, T |
| G67 | B | (method) the close writes any new grokking in *Do / Killing test* form. →E |
| G68 | B | the quotient screen and its soundness edge (complete `U`: the saturated chain gives it); banned this week. →S.1, S.2 |
| G69 | B | rigidity decided prime by prime on quotients; "dense and rigid" over K. →S.1 |
| G70 | S | √3-clean dichotomy: no √3-pairs here |
| G71 | B, F | no height at four colours; its reading "at four colours the arithmetic must enter" survives only on unit-distance lattices — FS-86 tests it again. →P-G71′ |
| G72 | B | (method) §IQ. →IQ |
| G73 | B | the four no-gos by format; the open formats (averaged, non-local, structure-derived); a full-dimensional `Θ_k` cell gives `P = F = 0`. →C, T |
| G74 | B | the field-level layer method: every `U_F` is layers of `U₅`, and a point of `Θ₄(F)` colours the whole plane (from four colours up emptiness is one-sided). →IQ item 5 (FS-83 is an open instance) |
| G75 | B, F | NT pins de Grey's spectrum; its killing test (a triangle-free identity pinning the spectrum onto torsion) is this milestone's yes; R2.6 predicts no. →IQ, P-G75 |

### G.2 The ledger rows (mechanism, one line each)

| # | v | reason |
|---|---|---|
| 1–6 | S | two-circle, seam, coverage, fan ⟺ coverage, class confinement, 120° triangle: rings about a pivot, not lattice rigidity |
| 7 | S | greedy colouring |
| 8 | S | a balanced 5-colouring |
| 9–11 | S | three-colour compulsions on two circles; strip automaton |
| 12–13 | S | tools-side extension profiles; negative knowledge of M17–M19 |
| 14–21 | S | gluing, partner webs, coupled automaton: K-fabric construction |
| 22–25 | S | the ladder closures of K and the Moser twist as a seam word |
| 26 | B | the 791-core's six forced pairs at four colours: triangle-full, 2-adic (G9) |
| 27–30 | S | quadrature, kill engine, stacking, mechanism hunt |
| 31 | S | Act One carriers (√3, 2 pigeonholes) — no √3 distance here |
| 32 | S | hex-shell pigeonhole (needs √3) |
| 33 | S | the classical interval |
| 34–41 | S | the cell family and the limit lemma |
| 42 | B | `Forces`, arity floor: the vocabulary of a yes |
| 43 | B | transport of pairs by isometries: the ideal property (§0.3 (ii)) |
| 44 | B | the spindle theorem and the two-distance dial: dB4's chain rests on it |
| 45 | B | the spare-colour lemma: three-colourable ⟹ no four-colour compulsion (FS79-T1) |
| 46–47 | S | copy unions; M53's descent |
| 48 | B | critical-set localisation of a forced pair (→T) |
| 49 | B | absorption (G40) |
| 50 | B | the additive yardstick (G41) |
| 51 | S | additive rigidity |
| 52 | B | the finite-plane bound and residue degree (§0 item 6) |
| 53 | B | the sieve (`unitQuadrance.map`) |
| 54 | S | lifts |
| 55 | B | `Forces.image`: compulsions map forward |
| 56 | B | `addCayleyMap`, colourability of quotients |
| 57 | B | Theorem A: the dyadic `K₄` colouring of ℚ(√59) is its instance (`colorable_of_residue`) |
| 58 | B | no minimal forcing gadget at `k ≥ 4` in the plane: any yes-gadget is non-minimal (→T) |
| 59 | B | the 2-adic law over K; here item 2 is its sharper analogue (depth ≥ 4) |
| 60 | B | plane freedom at `p ≡ 3 (mod 4)` where the plane is k-colourable (vacuous at four for Γ₁₁) |
| 61–62 | S | statement levels; overcompression |
| 63 | B | two colours from a ramified dyadic prime: the case G56 separates from ours (inert) |
| 64–65 | S | type-M arenas |
| 66 | B | the fan gap and `Slack.forces_iff_of_hom`: the "no" consumers; ℚ(√11)'s field-level `F = 0` |
| 67 | B | **the local tower of ℚ(√59), solved** (§0.1) |
| 68–70 | S | six at 83; the window; five at 27 |
| 71 | B | fractional lower bounds via the blow-up; the cap here is `χ_f(K₄) = 4` |
| 72 | B | the 3-adic barrier: rich lattices need `1/3` (§S.1) |
| 73 | B | ℚ(√11) needs four; its plane at 7 is the loose control |
| 74 | B | the census: supply of unit vectors decides finite refusal |
| 75 | B | the odd towers at 11, 23 all levels: §0.3 (iii)'s hypothesis |
| 76 | B | G68/G69 on ℚ(√3,√5): rigidity decided on quotients; the pull-apart of density and rigidity |
| 77 | B | (method) the theorem audit's filing rule |
| 78 | B | `F = P = 8Λ` by certificate; the Kempe kernel layer (`forces_iff_exists_finite`); FS-73's table, `K\|Q(sqrt11,i)\|D36` loose at `N = 5` |
| 79 | B | three colours are linear; `Θ₃`; `F` finite index ⟺ `Θ₃` finitely many points |
| 80 | B | four-colour no-gos by format; rank-1 criterion |
| 81 | B | `L21cc6506` loose; the saturated chain; the ramified prime colours lattices |
| 82 | B | χ ≥ 4 for every `d ≡ 11 (mod 12)`: ℚ(√59), ℚ(√83), ℚ(√131) are four-chromatic |
| 83 | B | the census's five-layer witnesses (ℚ(√59), ℚ(√83), ℚ(√131) among the 40) |
| 84 | B | the four-colour band on de Grey's lattice; ℚ(√47)'s price (context for route 4 after the week) |
| 85 | B | the known positive: `F = P = 8Λ` derived; NT + tight quotient |
| 86 | B | the calibration: a yes in `𝒰^tf` is Soifer 55.1; dB2 answers the stripped class |
| 87 | B | the no-gos on `Λ` (second moments, C14); G54's middle case (L16) |

### G.3 The method rules (§ Grokkings [method], § Toolchain, § Building, § The gate, the standard of evidence)

| rule | v | reason |
|---|---|---|
| the finite-witness-free week | B | routes 1–3 in; route 4 and every colouring search out; stage B's spectra are exact computer algebra with shapes fixed by §0.1. →S.2, X |
| "would have searched here" log | B | every brief; §X |
| no child spawns children | B | every brief, with the reason |
| three agents at once, Opus 5.5, replace at ~500k | B | §S.2's staffing |
| checkpoint and resume (PROTECTED) | B | every phase names its resume; stage B's computations are minutes, the working file is the checkpoint |
| a blocking run is killable (PROTECTED) | S | no long runs planned |
| kill by pid / waiter rules / `pkill -f` | S | no background jobs planned; stated in briefs as standing |
| `scripts/slot.py`, RAM rule, /tmp is RAM | B | any job over 2 GiB or 2 min; stage B's `Q_m` spectra at `m ≤ 12` (≤ 16.8 M characters × 324 generators, numpy) fit under 4 GiB — slot it |
| never `lake build` | S | no Lean this milestone |
| break symmetry before (UN)SAT | S | no SAT |
| G21's family: a negative measures its enumeration; audit what you like | B | the float Hoffman numbers; the saturation depth measured on one lattice |
| two numbers, one difference | B | `Q_m` versus `P_m` compared at one level, one generator set |
| a measured half and a derived half fail in opposite directions | B | stage B's spectra are derived-shape: an invented generator makes a refusal look cheap — check `U mod 𝔓^m` against `S_m` membership exactly |
| positive control for every instrument | B | B2's spectrum code must reproduce row 67's table (`λ_min(P_m) = −2^{m−1}`, 45 minimisers at level 4) on the full `S_m` before any `Q_m` |
| state the uninformative outcome and confirm it is reachable | B | §P |
| one step of every key claim checked by the owner | B | §S.2's acceptance |
| verification is where contest begins | B | V during round 2 |

### G.4 The nearest derivations, individually

| entry | v | reason |
|---|---|---|
| FS85-A1, A2 | S | η in `Λ`; the wiki's identities (K only) |
| FS85-A3 | B | the rank-1 range measured nothing; a triangle-free yes lives far out (dB2) — G21. →P |
| FS85-T0 | B | transfer checks measure membership, not logic (V6): any held tool carried to ℚ(√59) gets its logic re-walked. →C |
| FS85-dB1 | B | the embedding lemma: arithmetic-free rigidity is free, so the class must keep the rotation structure (§0.5) |
| FS85-dB2 | B | the stripped class answered yes (FR-2). →IQ |
| FS85-dB3 | S | circulants (Klotz–Sander 3.6) |
| FS85-dB4 | B | the calibration: `F(R) ≠ 0` for a type-(B) field ⟹ Soifer 55.1 |
| FS85-C4 | S | stripes need Eisenstein cosets |
| FS85-dB5 | B | the infinite lattice need not be Hoffman-tight even when a quotient is; the analogue on `Λ₅₁₀` is B2's limit sign |
| FS85-dB6 | B | Hoffman's equality case splits a colouring across primes: §0.4's one-prime step at K |
| FS85-dB7 | S | chirality at K's two primes (one prime here) |
| FS85-dB8 | S | Lemma S on the 64-vertex torus (needs `T₀`) |
| FS85-C5 | S | pair-linearity on `Λ_dG` |
| FS85-C6 | B | two striped families do not couple: coupling needs enough families — the triangle-free analogue is an open instance |
| FS85-dB9, dB10, dB11 | S | stripe coupling on K's Eisenstein cosets |
| FS85-V6 | B | a published proof transferred by membership did not close: re-walk every held proof used (→C) |
| FS85-V7 | S | stripe route to `1680Λ` |
| FS85-V8, IA1–IA4 | B | audit a computer-found published input as a fixed certificate (rule 11): if any route here uses a computer-found input, audit it |
| FS85-V2-T1 | B | an input's scope is its linear transports only: scope every statement at its exact object |
| FS85-C7 | B | **the mechanism with triangles**: NT ⟺ `A_k g = −2g`; the symbol's factorisation is the triangle relation. FS-86 asks for its triangle-free analogue. →IQ |
| FS85-C8 | B | the zero sets meet in 42 torsion characters (the dual of `8Λ`): what a pinning identity must achieve |
| FS85-C9 | B | Theorem R: colourings = `c₀ ∘ ρ_ε`, local at one prime — the shape a yes over ℚ(√59) would take (pullback from `P₄`) |
| FS85-V2-T5 | S | the stripe lemma (needs `T₀`) |
| FS85-C10 | S | `120Λ` from five families |
| FS85-C11 | B | a family can be indispensable: a triangle-free yes may need many layers |
| FS85-C13 | S | the patchwork |
| FS85-C14 | B | second moments do not pin the spectrum on `Λ_dG`: a radius-1 averaged certificate is not enough there — a named no-go format to respect (→T) |
| FS85-C15 | B | carrying an identity outward through odd-index cosets: a template for any identity found on part of `U_F` |
| FS85-R3a | B | the 5-part dies pointwise at the tight dyadic quotient — the product shape of §0.3 (iii) in its K form |
| FS85-R3b | B | the known positive (row 85) |
| FS85-V2-T8 | B | scope: a result on `Cay(R, U_F)` is a result on the plane; one on `Λ₅₁₀` is not |
| FS85-L16 | B | a slack level can force (the middle case): B2 must not read slack as free |
| FS38-D2-A | B | tight ⟹ balanced, gap-free, `H_min`-periodic: the engine of §0.1 and of B2 where `Q_m` is tight |
| FS38-D2-B | B | the full tower's colourings are `P₄`'s: §0.1–0.3 |
| FS79-T2 | B | a forced δ is never chainable inside `F` (positive valuation at the stable dyadic prime): the yes leaves the field (dB4) |

### G.5 `LEDGER.md` § B and the other derivation files, by block

| block | v | bearing lines |
|---|---|---|
| FS38 (D1, L1–L3, D3) | B | L1 (tightness propagates up a level map with constant fibres) is exactly what fails on `Q_m` past saturation: B2 must say where; L3's certificate is the full tower's, not the lattice's |
| FS70 T1–T11 | B | T10 (Kempe voltage escape) and T6 (gap on a quotient) are the lattice-level "no" instruments; T2 additive Kempe — lattice-level, after the week |
| FS73 T1–T45 | B | T22 (height lift), T24 (dichotomy at three colours), T36 (`F = ⋂ Per(c)` finite-quotient form), T38 (the odometer: `P = F_clopen`); T14's fixed-prime gap lemma; T18 (3-integral lattices) |
| FS79 T1–T49 | B | T1, T2, T6, T9 (the saturated chain), T12 (integrality at stable primes), T39 (full-dimensional `Θ_k` cell ⟹ loose), T21–T30 (four-colour format no-gos), T35 (rank-1 criterion) |
| FS81 T1–T25 | B | T1–T7 (row 82's layer method: slope types, gluing across layers — the three-colour model of the field-level question), T8 (depth thresholds of finite configurations), T25 (Hoffman refuses a target outright) |
| FS85 | — | walked individually in G.4 |
| FS58, FS61, FS66 | B | FS66's fibre-share lemma (row 75) and Poros's ramified form (§0.3 (iii)); the rest silent (three-colour census machinery) |
| M-era and FS-38-and-earlier others | S | K-fabric, five-colour descents and cell families: no bearing on a four-colour question over a triangle-free field |

### G.6 What the re-grokking changed in the plan

1. Routes 1–2 on the full tower are **done** (row 67): stage B asks only the lattice's image (§0.1).
2. The weak form is **free** at the field level (G55, G66, G59 + `[Zhang2012]`; Poros's FR-1): registered as a free outcome; the question becomes
   `F(R)`, and the competition is posed on the field plane, not on a lattice.
3. **"Rich" gains the ramified prime** (G43, row 81) and loses a wrong prime (19); `Λ₂₇₃₀` is the definition's non-example.
4. The class is re-aimed by dB1/dB2 to keep the rotation structure (§IQ).
5. B2 carries a positive control (row 67's table) and a "slack, undecided" outcome (G54's middle case, L16).
6. The fallback is not FS-67: its four-colour form is `[Zhang2012]` Thm 1.8(i) for vertex-transitive factors (§S.5) — a re-aim to propose
   for FS-67 at the close.

## §PA. The prior-art gate (WORKFLOW 3.2)

### PA.1 The object named in its disciplines' words

- **Algebraic graph theory:** the four-colourings of a Cayley graph with a Hoffman-tight finite quotient; *Hoffman colourings*
  (`[AbiadEtAl2025]`); **vector colourings and least-eigenvalue frameworks** (the tetrahedral embedding of a four-colouring *is* a vector
  4-colouring: `p_iᵀp_i = 3`, `p_iᵀp_j = −1` on edges); *uniquely vector colourable* graphs.
- **Graph homomorphisms / products:** colourings of a categorical product pulled back from a factor; MIS-normality (`[Zhang2012]`); uniquely
  colourable graphs (Greenwell–Lovász; `[KlotzSander2017]`).
- **Symbolic dynamics:** frozen `K₄`-hom-shifts on a non-finitely-generated abelian group; periodicity of every configuration.
- **Discrete geometry / number fields:** the plane over a real quadratic field (Benda–Perles, Johnson, Fischer); triangle-free unit-distance
  graphs (Exoo–Ismailescu 2016, O'Donnell, Soifer ch. 55).
- **The question:** "is every optimal colouring of the plane over `F` local at one place" — the colouring-level form of the local–global
  conjecture (G48).

### PA.2 Queries (zbMATH Open API unless marked; hit counts as returned; review vs author summary marked)

| # | query | hits | what came back |
|---|---|---|---|
| 1 | `ti:"chromatic problems and prizes"` | 0 | `[Soi46]` is not indexed under its title |
| 2 | `au:"Soifer, Alexander" & py:2018-2026` | 18 | two open-problem notes (2024, Geombinatorics 34(1) 30–36, no review; 2025, 34(3) 113–115, **review**: two-distance and ℝⁿ conjectures, nothing triangle-free); no 2019 "prizes" item |
| 3 | `au:"Soifer, Alexander" & py:2019` | 2 | a Grünbaum obituary; *Chromatic number of the plane, breakthroughs and aspirations in six essays*, Congr. Numer. 234 (2019) 9–38 (no review) — probably overlaps `[Soi46]`, unread |
| 4 | `ab:"triangle-free" & ab:"unit distance"` | 3 | Exoo–Ismailescu 2016 (review); `[CostaSilvaFilho2026]` (summary); EuroComb 2013 |
| 5 | `ti:"triangle-free" & ti:"unit-distance"` | 4 | + O'Donnell 1995 (40-vertex 4-chromatic); `[deGrey2026]` (summary) |
| 6 | `ab:"triangle-free" & ab:"5-chromatic"` | 2 | Goedgebeur 2020, Avis 1979: abstract graphs, no geometry |
| 7 | `ab:"4-chromatic" & ab:"triangle-free" & ab:"unit distance"` | 2 | Exoo–Ismailescu 2016; `[CostaSilvaFilho2026]` |
| 8 | `ab:"girth" & ab:"unit distance" & ab:"chromatic"` | 7 | de Grey 2026, Exoo–Ismailescu, O'Donnell 2000 I–II, Raigorodskii 2014; nothing on forced pairs |
| 9 | `ab:"uniquely colorable" & ab:"Cayley"` | 2 | `[KlotzSander2017]`, `[Basic2026]` (held) |
| 10 | `ab:"uniquely colorable" & ab:"triangle-free"` | 2 | Nešetřil 1973 (none circulant) |
| 11 | `ab:"Hoffman colorable"` | 2 | `[AbiadEtAl2025]` (held); De Bruyn–van Veluw 2026 (arXiv:2603.03859, abstract read: smallest eigenvalue ≥ −2 classification; does not bear) |
| 12 | `ab:"uniquely" & ab:"colorable" & ab:"eigenvalue"` | 2 | **Godsil–Roberson–Rooney 2017** (summary) — the find, PA.3 |
| 13 | `au:"Roberson, David E." & ab:"vector coloring"` | 2 | GRR 2019 (EJC 79); **GRRŠV 2020** (Math. Program. 182) |
| 14 | `ab:"uniquely vector colorable"`, `ab:"least eigenvalue framework"` | 1, 1 | GRR 2017 |
| 15 | `ab:"frozen" & ab:"coloring"` | 13 | random CSP, reconfiguration (`[BrewsterEtAl2020]`, frozen H-colourings); no lattice periodicity |
| 16 | `ab:"hom-shift"` | 1 | Gangloff–Hellouin–Oprocha 2026 (block gluing; held as arXiv) |
| 17 | `ab:"Hedetniemi" & ab:"uniquely colorable"` | 1 | Chartrand–Geller 1969 (planar); nothing |
| 18 | `ab:"unit distance" & ab:"quadratic field"`; `ab:"chromatic number" & ab:"real quadratic"`; `ab:"unit distance" & ab:"number field" & ab:"chromatic"` | 0, 0, 0 | the question is not asked in these words anywhere zbMATH indexes |
| 19 | `ab:"distance graph" & ab:"forced" & ab:"coloring"`; `ab:"unit distance graph" & ab:"forced"` | 0, 0 | — |
| 20 | `ab:"2-adic" & ab:"chromatic number"`; `ab:"Euclidean graph" & ab:"finite ring" & ab:"chromatic"` | 0, 0 | — |
| 21 | OpenAlex `search=chromatic problems and prizes soifer` | 5 | no match for `[Soi46]`; `[Soifer2024]` (10 citing) |
| 22 | arXiv API, 2607.19995 and 2603.03859 abstracts | — | read (below) |

### PA.3 What the gate found

1. **The vector-colouring handle on "every optimal colouring"** (GRR 2017, arXiv:1512.04972, read: abstract, §4.3, Thm 4.9 with proof;
   GRRŠV 2020, arXiv:1801.08243, read: abstract, Def. 1.1, the statements (A′)/(B′), Cor. 4.4). **Thm 4.9:** for a 1-walk-regular graph every
   optimal vector colouring has Gram `(n/d)(PPᵀ + PRPᵀ)` with `P` the least-eigenvalue framework — so every optimal vector colouring lives in
   the least eigenspace. A Hoffman-tight four-colouring's tetrahedral embedding is an optimal vector colouring, so this is **FS38-D2-A(ii) in
   vector-colouring words**, on the 1-walk-regular intersection (an attribution note for the close: D2-A called (ii)–(iii) ours).
   **GRRŠV 2020:** `χ_v(G × H) = min(χ_v(G), χ_v(H))`, with a necessary and sufficient condition for every optimal vector colouring of `G × H`
   to come from the factors (Cor. 4.4: `G` uniquely vector colourable, `H` connected, `χ_v(G) < χ_v(H)` ⟹ `G × H` uniquely vector colourable) —
   the vector form of §0.3 (iii)'s product step and of R3a. **For FS-86 it names the invariant a pinning identity would be** (§IQ item 3):
   a four-colouring is pinned when its tetrahedral embedding is forced into the least eigenspace of something — `NT_k` did it with the
   hexagon operator (C7); tightness does it on a finite quotient (D2-A); the question is what does it on `Cay(R, U_F)` without triangles.
2. **`[Zhang2012]` Thm 1.8(i), the MIS-normal half** (held, read in full; verified here against the PDF): strict ratio inequality and `H`
   connected ⟹ every maximum independent set of `G × H` is a preimage from `G`. Cited in this project only for its α half until Poros's FR-1.
   It answers FS-67's four-colour form for vertex-transitive factors (a re-aim to propose at the close).
3. **Soifer's posing** (`[Soifer2024]` ch. 55, read in full, one page): Problems 55.1 and 55.2 posed in `[Soi46]` = Soifer, *Chromatic
   problems and prizes*, Geombinatorics XXVIII(4) (2019) 206–210; motivation: the 17-vertex triangle-free four-chromatic UDG
   (Exoo–Ismailescu) as a small building block. `[Soi46]` is **not held and not indexed** (queries 1–3, 21); its citation graph is unreachable
   by zbMATH and OpenAlex (Geombinatorics). **Debt, recorded**: obtaining it is Kooshi's call (the owner's inventory item 5).
4. **`[deGrey2026]`** (summary read, zbMATH): a 61-vertex, girth-4, five-chromatic UDG in ℝ³; he speculates no six-chromatic girth-4 case in
   ℝ³. **`[Haugstrup2026]`** (summary only): ℝ³, K₄-free, six-chromatic. Neither is planar, neither states a forced pair; both remain read by
   summary only (**debt carried**, not held; nothing here rests on them).
5. **Heule's T721** (read through `[Soifer2024]` ch. 54): 721 vertices in `ℚ(√2,√3)²`, a distance-2 pair monochromatic in every
   four-colouring — a triangle-full four-colour forced pair at positive dyadic depth (G9's pattern); the graph is not held. Not a counterexample.
6. **`[CostaSilvaFilho2026]`** (abstract read): the smallest triangle-free four-chromatic UDG (EI17) has coordinates in a non-solvable degree-20
   field; EI19's base lies in `ℚ(√2,√5,√7)`. Context: small triangle-free four-chromatic UDGs do not live in real quadratic fields.
7. **Nothing found** stating a four-colour forced pair in any triangle-free unit-distance graph, a periodicity theorem for colourings of a
   field plane, or the colouring-level local–global question. The negative is a finding about where the unworked ground is (queries 18–20).

### PA.4 Carried into §IQ and §C

Items 1–2 go into §C as shared prior art (the vector-colouring language and `[Zhang2012]`'s MIS-normality); item 1's "what a pinning
identity is" goes into §IQ item 3 as the planner's hypothesis, kept out of §C's challenge text. Items 3–5 go into §C as the calibration.
Bibliography: `[GodsilRobersonRooney2017]`, `[GodsilEtAl2020]` and `[Soifer2019]` added today; `[Zhang2012]`'s row gains its Thm 1.8(i).

## §IQ. The invariant question (WORKFLOW 3.3)

1. **The existence form.** Is there a finite triangle-free unit-distance graph over ℚ(√59) with a four-colour forced pair? Equivalently
   (FS85-dB4's ⟸ direction applied inside the field, and `forces_iff_exists_finite`): is `F(R) ≠ 0`?
2. **The structural form, about every four-colouring.**
   - **(S1) The field plane.** For `F = ℚ(√59)` (and 83, 131): classify every proper four-colouring of `Cay(R, U_F)`, `R = ℤ[U_F]`. By §0.3,
     either every one is local at the dyadic place (pulled back from `P₄` along `R → O/𝔓⁴`) or some one is not periodic; name the invariant that
     decides which.
   - **(S2) The class.** The most general class in which S1 is still open keeps the rotation structure (dB2 answers the stripped class):
     **field planes `Cay(R_F, U_F)` of real fields `F` with exactly one stable place whose local planes have `χ_f ≤ 4`, that place Hoffman-tight
     at every level** (Poros's sharp form of §0.3 (iii)'s hypotheses) — exactly the fields whose periodic four-colourings are local at one
     place. ℚ(√11) is not in it (its 7 has `χ_f(Γ₇) < 4`); K has two such places (answered, §0.4); at ℚ(√47) and ℚ(√167) (type A) every stable
     place has `χ_f > 4`, so no finite quotient four-colours and every four-colouring, if one exists, is non-periodic. ℚ(√59), ℚ(√83),
     ℚ(√131), ℚ(√227), ℚ(√251) are its triangle-free real quadratic members (`d ≡ 11 mod 24`, 7 not stable; each ramified tower checked as in
     §0.3). **Question:** in this class, is `F(R) ≠ 0` (every four-colouring of every coset local at the tight place)? Is the answer decided by
     triangles?
   - **Strengths** (G60, G66): `F ⊆ F_μ ⊆ F_meas ⊆ P`; at the field level `P` is known (§0.3), so a "no" is a single non-periodic colouring, and
     a "yes" must be proved at `F`.
3. **The invariant it forces.** *The planner's hypothesis, not a prescription (§C points the competitors to items 1, 2, 4, 5 only):* a
   four-colouring as a tetrahedron-valued function `g` (a vector 4-colouring, §PA.3 item 1). Over K, `NT_k` put `g` in the `−2`-eigenspace of the
   hexagon operators, pinning its spectrum to 42 torsion characters (C7–C8); on a tight finite quotient, Hoffman's equality puts `g` in the least
   eigenspace (D2-A; GRR Thm 4.9). On `Cay(R, U_F)` without triangles the candidate invariant is **an operator `A`, built from `U_F`, for which
   every four-colouring's `g` is an eigenvector (or lies in a named spectral subspace)**; the three formats G73 leaves open (averaged, non-local,
   structure-derived) are the places to look; C14 excludes second moments on de Grey's lattice. **None known**, and finding one, or proving
   none exists in a named format, is the milestone.
4. **The route.** Derivation only. An exact computation may check a derived claim (a membership, an exact rank, a character sum, a spectrum
   of a fixed finite quotient). No colouring, graph or lattice search answers S1 or S2 this week.
5. **The open instances it would decide.**
   - `F(R)` for ℚ(√59), ℚ(√83), ℚ(√131) (type B) — and the conjecture's colouring-level form at L = 4.
   - Soifer 55.1 in the plane, by dB4, on a yes.
   - FS-83 at `k = 4` (a point of `Θ₄(F)` with a non-zero archimedean part colours `F²` non-periodically; G74) — the same `F(R)` question
     from the "no" side.
   - Type (A): ℚ(√47), ℚ(√167) (no dyadic target; FS-84, FS-59): a class-level "no" that does not use the tight place covers them.
   - `P(Λ₅₁₀)` and every lattice over a type-(B) field (a "no" at `F(R)` gives `F(Λ) = 0` for all).
   - G75's killing test and Coxeter's R2.6 reading.

## §S. The subplan (WORKFLOW 4)

### S.1 "Rich", defined

For `F = ℚ(√d)`, `d ∈ {59, 83, 131}`, and `M ≥ 1`: `U_M = {((a + b√d)/M, (c + e√d)/M) : a² + db² + c² + de² = M², ab + ce = 0}`, the
**saturated chain** `Λ_M = ℤ⟨U_M⟩`, with `U(Λ_M) = U_M` (FS79-T9's argument). `Λ_M` is **rich** if:
- **(R1)** rank 4 (it spans `F(i)`);
- **(R2)** `1/p ∈ Λ_M` at every prime `p` below which some prime of `F` has a three-colourable plane `UD(𝔽_q, 2)` — for `d = 59`: `p = 3`
  (`q = 9`; row 72's barrier) and `p = 5` (`q = 5`; `χ(Γ₅) = 3`) — **necessary**: a `p`-integral lattice there maps into a three-chromatic
  plane, so it is three-colourable and loose at four (FS79-T1);
- **(R3)** `Λ_M ⊗ ℤ₂ = O_𝔓` (index 1 at 2: the lattice maps onto every `O/𝔓^m`);
- **(R4)** at every prime `𝔭` of `F` of norm `≤ B` at which `Λ_M` is integral, the level-one image target `Cay(image, U mod 𝔭)` has **no
  four-colouring by theorem**: the full plane when the image is the whole circle and the plane's χ is known, or Hoffman's ratio `< 1/4` by an
  exact spectrum.

**The named instance, `Λ₅₁₀`** (`d = 59`, `M = 510 = 2·3·5·17`): 324 unit vectors, true denominators with primes 2, 3, 5, 17; rank 4 [exact];
covolume `3⁻⁴5⁻⁴17⁻⁴` in the `O`-basis `{1, i, ω, iω}`, `ω = (1 + i√59)/2`, so (R3) holds and `1/3, 1/5, 1/17 ∈ Λ₅₁₀` [exact]; (R4) with
`B = 59`: full circles at 11 (Γ₁₁, χ = 5, kernel), 23, 29 (UD(𝔽₂₉,2), χ ≥ 5 measured, G64), 31, 41, 43, 47, 53 and the ramified 59 (Hoffman
0.199); full circle at 7 (`q = 49`, Hoffman 0.195); partial at 13 and 19 (`q = 169, 361`; Hoffman 0.168, 0.155) [**float, aiming only**;
B3 certifies exactly]. **The non-example, `Λ₂₇₃₀`** (`M = 2·3·5·7·13`, 324 unit vectors): covers every split stable circle but only 44 of 60
points at the ramified 59, Hoffman 0.320 there — not refused; the definition exists to exclude it. `Λ₄₆₄₁₀` (2,916 unit vectors) covers 59 in
full. **What rich does not certify:** higher tower levels at integral primes; composite quotients; the 2-power quotients `Q_m` past the
saturation depth; non-periodic colourings. At the field level (`R`) all but the last are settled by §0.3.

### S.2 Stages, the three-agent cap, and 2026-10-01

| stage | agents (≤ 3 at once) | dates (target) | what |
|---|---|---|---|
| A | planner + plan-phase Poros | 09-24/25 | this plan; both stand down; the held file goes to the competition advisor |
| B | one agent (a fresh de Bruijn, V2 pattern) | 09-25 | **B1** a blind second derivation of §0.3 (ii)–(iii) and §0.4's K corollary; **B2** routes 1–2 on `Λ₅₁₀`; **B3** exact certificates for S.1 (R4) at `B = 59` |
| C | two competitors + one competition advisor | 09-26 → 09-29 | the field question (§C); round 1 to the killing test (09-27 18:00 or both reports), round 2 to 09-29 18:00 |
| V | one blind verifier per claimed yes or no | during round 2 (the advisor stands down for it, as FS-85) or 09-29/30 | a yes needs two derivations and a blind verifier before a row; a no needs a blind verifier |
| E | a fresh close planner | 10-01 | WORKFLOW 9 from the inventory |

**Decision: where routes 1–2 sit.**
- *The choice:* a one-agent stage B before the competition, its output given identically to both competitors.
- *Alternative weighed:* inside the challenge, both competitors computing the lattice profile (a built-in duplicate).
- *Why B won:* after §0.1 the routes are fixed exact computations with no competing routes, so a competition only duplicates them; the
  competition is re-aimed at `F(R)`, where the lattice profile is data, not the question; and B1 is the blind second derivation the owner
  requires before §0.3's registrations stand — a verifier task, which a competition cannot do. It also keeps the competitors' start identical.
- *Confidence: medium* — if B1 finds a defect in §0.3, the challenge statement changes, and C starts a day late.

**Decision: one challenge.** Routes 1–2 are B; route 3 is C; the challenge is the field question S1 with its class S2, either order.

**2026-10-01.** At the field level route 4 is moot (§0.3 (iii): every periodic colouring of `R` is a pullback from `P_m`, composite
quotients included). At the lattice level (`P(Λ₅₁₀)`) it is a quotient screen, a separate item after the week: the close mints or folds it
(the stub for FS-86's lattice form, or FS-76). If Kooshi extends the ban, nothing here changes. FS-86 closes by 10-01 either way.

### S.3 Every phase's budget, stop rule, checkpoint, kill cost and acceptance

| phase | budget | stop rule | checkpoint and resume | a kill redoes | acceptance checklist |
|---|---|---|---|---|---|
| B | 300k tokens; computations ≤ 10 min each under `scripts/slot.py --mem 8 --cpus 8` | B1 verdicts on (ii), (iii), §0.4 and the ramified lemma, and B2 through the level where `U mod 𝔓^m` is injective, or 2026-09-25 22:00 | the working file `plans/FS86-B-profile.md` in its own scratch until hand-back, saved after every result; its §"state" is the resume point | the computation or lemma in flight | C0 predictions committed before reading Poros's §0.3 sketch; B1 derived before reading it; positive control: row 67's table reproduced on the full `S_m` before any `Q_m`; every number exact or labelled float; "Theorems this phase proved"; search log |
| C round 1 (each) | 250k working | the killing-test report, 09-27 18:00 or both reports | working file in own scratch, saved after every result, "Theorems this phase proved" current | the derivation in flight | first route written before the held items; every claim graded and scoped (field, class, lattice); T applied to any necessary condition |
| C round 2 (each) | to 400k (replace at 500k at the round boundary) | 09-29 18:00 or both hand back | as round 1 | as round 1 | as round 1, plus every theorem stated at its exact object |
| C advisor | 400k | stood down when advising ends, or for V | its record in own scratch, hand-off section current | the advice in flight | expectation written first; the killing-test adjudication in writing; retractions counted; asymmetric cards logged |
| V (per claim) | 350k | a verdict on every lemma, or 200k with none (stall criterion) | the verifier's record | the lemma in flight | C0 before reading; derivation before the sketch; divergences listed; any computer-found input audited as a certificate |
| E | 350k | inventory ticked | the inventory | the item in flight | WORKFLOW 9, G72's count, the search-log count, `CLAUDE.md` compressed to budget |

### S.4 The killing test (dated, checked to be able to fire), and the trivial list T

**At the end of round 1 (09-27 18:00, or both round-1 reports, whichever first) the advisor adjudicates in writing.** It **passes** if at
least one competitor has, advisor-checked:
- **(K1)** a proved necessary condition X for `F(R) ≠ 0` in the class S2 (or on `Cay(R, U_F)` for ℚ(√59)), **not implied by T**, and shown
  to fail or hold on a named member where every item of T holds or is undecided;
- **(K2)** a proved `F(R) = 0` for a type-(B) field, or `F(Λ) = 0` on a named rich lattice, by derivation not reducing to G68 (a gapped
  colouring found by search), FS79-T39 (a `Θ_k` cell found by a finder) or FS79-T1;
- **(K3)** a proved no-go of a named format of pinning identity on type-(B) planes, the format pinned by the advisor **before** the proof is
  read, and not implied by rows 80 and 87;
- **(K4)** a proved `F(R) ≠ 0` (a yes), at `F` itself, with its inhabitant.

**Otherwise it fires**: stand the competition down and run the fallback (§S.5).

**It can fire:** §0.3 has already taken the free structure (the weak form, the dichotomy), so a round of restatements meets none of K1–K4;
FS-79's round 1 produced no-gos of formats already recorded, which K3 now excludes. **It can pass:** K3 is a day's derivation (FS-79's were),
and K1 has the rich dyadic structure of §0.1 to work with. **The evidence is reachable by the date:** the two round-1 reports.

**T, the trivial conditions** (necessary for `F(R) ≠ 0`, each a theorem; K1 conditions implied by them do not count): (1) χ = 4 exactly; (2)
every four-colouring gap-free (G13, row 66); (3) no stable place with a gapped four-colourable tower (row 66); (4) `F ⊆ R ∩ 𝔓⁴` (§0.2);
(5) `F ∈ {0, P(R)}` and `P(R) = R ∩ 𝔓⁴` (§0.3); (6) `F ⊆ ⋂ ker φ` over additive four-colourings (G41); (7) no full-dimensional `Θ₄` cell of
any finitely generated sublattice (FS79-T39); (8) every four-colouring frozen (no finite Kempe component); (9) zero entropy along `F`; (10)
`F ⊆ F_μ ⊆ P`; (11) a forced δ is never chainable in `F` (FS79-T2); (12) a yes-gadget is non-minimal (row 58) with at most two critical
vertices within distance 2 of the pair (row 48); (13) second moments alone do not pin (C14, on `Λ_dG`; a K1 must not reduce to it).

### S.5 The fallback (sketch, enough to brief from): FS-83 at `k = 4` on type-(B) fields

**Why not FS-67:** its four-colour form ("every four-colouring of `G × H`, `G` tight, pulled back from `G`?") is `[Zhang2012]` Thm 1.8(i) for
vertex-transitive factors with a strict ratio inequality — answered in print. **The fallback:** `plans/STUB-layer-method-five-colours.md` at
`k = 4` for ℚ(√59): does `Θ₄(F) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U_F) ⊆ [1/4, 3/4] + ℤ}` hold a point with non-zero archimedean part? Hour one: the
rational pattern's rotation set at the band `[1/4, 3/4]` (FS73-T40-style exact cells; a fixed 2-D set, derived shape, in scope). Its killing
test: a cell that is neither torsion nor archimedean. Then the gluing across layers (FS81-T2–T5 with the relations of ℚ(√59), `1/3 ∈ R`,
`1/2 ∉ R`). By §0.3 (ii) a point with non-zero archimedean part gives `F(R) = 0` at once. Staff: one derivation agent (300k) and a blind
verifier (400k). Slots: FS81-T1–T8, FS73-T40, G71, G73, G74, the ban and the log. Predictions P-W1/P-W2 carried from FS-85's §S.5.

### S.6 Records every phase writes

Every record carries **"Theorems this phase proved"** (each theorem one line, grade, where its proof lives) and the **"would have
searched here" log**. Working files live in the agent's own scratch until hand-back; the owner moves them into `plans/`.

## §B. Stage B's brief slots (for the owner's brief)

- **B1, blind (V2 pattern).** Receive the *statements* of §0.3 (i)–(iii), §0.4 and the ramified lemma (Poros's, in §0.3 (iii)), not their
  sketches; commit C0 predictions; derive each; only then read §0.3's sketch and Poros's record; list divergences. Also for `d = 83, 131`
  (their stable odd places: 19, 43, 47, … and the ramified 83; 19, 23, 31, 47, … and the ramified 131). The owner registers nothing on the
  `{0, P}` dichotomy until B1 agrees.
- **B2, routes 1–2 on `Λ₅₁₀`.** Positive control first: row 67's spectrum table on the full `S_m`, levels 1–8. Then: `U mod 𝔓^m` against
  `S_m` for each `m` (the saturation depth `m* = max{m : U ↠ S_m}`); `Q_m`'s spectrum, the sign of `λ_min + d_m/3`, and `H_min` where tight, for
  `m` up to the level where `U mod 𝔓^m` is injective; the lattice analogue of FS38-L3 (`M_Λ = ℤ-span{t − 1 : t ∈ U, t ≡ 1 mod 𝔓}` and its
  2-adic elementary divisors relative to `Λ ∩ 𝔓^j`); where a level turns slack, say so and stop — **"slack, undecided" is a registered outcome**,
  and a slack level is never read as free (L16). No colouring is searched; a colouring given by formula (a pullback from `P₄`, an additive map)
  may be exhibited and checked.
- **B3.** Exact versions of §S.1 (R4)'s Hoffman numbers at `B = 59` (cyclotomic arithmetic, or rigorous interval bounds on the character sums).
- The ban, the search log, no subagents (with the reason), Kooshi's "all novel knowledge is a success" with the instruction not to lean toward
  a yes, content-free hand-backs, commits by explicit path, no `git log`/inventory reading until hand-back.

## §C. The competition's brief text (ready to paste; identical for both competitors except the name and an optional persona preamble)

*Slots filled per `plans/PROTOCOL-competitor-and-advisor.md` §4; the owner adds agent ids, scratch paths and personas, and appends stage B's
results as a dated addendum identically to both.*

```
You are **<Coxeter | de Bruijn>**, and you have a genuine, friendly competitor, **<de Bruijn | Coxeter>**, working the same problem
independently. Kooshi (the human whose project this is) set it up this way on purpose: two independent shots at a derivation are better than
one, and it should be fun. Neither of you grades the other. The product owner coordinates; an advisor, **Poros**, advises you both.

Read `/home/kooshi/source/lean-dir/CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` from disk first; they bind you. Then read this milestone's plan,
`plans/FS86-dyadic-rigidity.md`: §0, §IQ items 1, 2, 4 and 5, §S.1 and §S.4. §IQ item 3 is the planner's hypothesis, not a prescription;
ignore it if you like. Do not read `git log`, the close inventory, `data/fs86/` beyond `data/fs86/stageA/` and stage B's addendum, or the
other competitor's files, until you hand back.

**Kooshi on outcomes (2026-09-24):** "A proven theorem about why its impossible is also valid. All novel knowledge is a success." A proved
"no" — a non-periodic four-colouring, or a no-go of a named format — counts exactly as a proved "yes" does. **Do not lean toward a yes**: a yes
here would answer Soifer's Open Problem 55.1, and the prior against it is strong; the project's characteristic failure (G21) is a search or an
argument that finds what it hoped to find.

## The mathematics you are standing on (with addresses)

1. **The field.** `F = ℚ(√59)`: four-chromatic (`LEDGER.md` row 82: `1/3 ∈ ℤ[U_F]` and an odd cycle; `59 ≡ 11 mod 12`), no unit triangles
   (√3 ∉ F; G57). Its unit-distance graph is a disjoint union of copies of `Cay(R, U_F)`, `R = ℤ[U_F]` (FS79-T6's form). Stable primes (a
   prime of `F(i)` fixed by conjugation): the dyadic one (inert in `F(i)/F`, residue `𝔽₄`), and at odd `p` exactly 11, 23, 31, 43, 47, … and the
   ramified 59; every other prime has `1/p ∈ R` (G55, prime inversion). Siblings: ℚ(√83), ℚ(√131) (plan §0 item 6).
2. **Its dyadic local plane is row 67's tower** (plan §0.1): `ℚ₂(√59) = ℚ₂(√3)`, `ℚ₂(√59, i) = ℚ₂(ζ₁₂)`, `O = ℤ₂[ω][√3]`. `P_m = Cay(O/𝔓^m, S_m)`
   is four-tight at every level; every four-colouring of `P_m`, `m ≥ 5`, is pulled back from `P₄`; `Forces ⟺ 𝔓⁴` (`LEDGER.md` row 67;
   `plans/FS38-derivation.md` D2-A, D2-B, L1–L3; kernel at levels 4–5). Level one is `K₄ = Cay(𝔽₄, μ₃)`.
3. **What is free** (plan §0.2–0.3; the second derivation is stage B's, addendum attached): `F ⊆ P ⊆ R ∩ 𝔓⁴`; `F(R)` is an ideal of `R`, so
   `F(R) ∈ {0, P(R)}`; and `P(R) = R ∩ 𝔓⁴` (every periodic four-colouring of the plane is a pullback from `P₄`), by weak approximation,
   `[Zhang2012]` Thm 1.8(i) (MIS-normality of `G × H` for vertex-transitive factors with a strict ratio inequality and `H` connected; held,
   `~/source/library/pdf/arXiv-1007.0797-zhang-independent-sets-direct-products.pdf`) and the odd towers' `α/n < 1/4` at every level (row 75;
   G54; the ramified 59 by a fibre argument in the plan). **So the weak question (`P ≠ 0`) is answered at the field level, and the question is `F`.**
4. **The known positive, with triangles** (`LEDGER.md` rows 78, 85; `plans/FS85-derivation.md` C7, C8, C9, R3a, R3b): on de Grey's lattice
   over K every four-colouring is `8Λ`-periodic and local at one prime above 2. The mechanism: colours as the vertices of a regular tetrahedron,
   "no monochromatic √3-triple" is the eigen-equation `A_k g = −2g` of a hexagon operator whose symbol factors by `1 + ζ₆² = ζ₆`; the families'
   zero sets meet in 42 torsion characters; a tight dyadic quotient kills what remains pointwise. At the field level (plan §0.4, Poros's
   derivation, checked blind in stage B) it gives `F(R_K) = 4R_K`: every four-colouring of every `R_K`-coset is a pullback from `P₄` at one of
   K's two dyadic places (equal ratios there, so tightness of the product, not MIS-normality, picks the place). G75 states the mechanism and its
   killing test.
5. **The known negatives.** ℚ(√11) has the same dyadic tower but a usable 7 whose plane has gapped four-colourings, so `F = 0` there (row 66;
   `Slack.forces_iff_of_hom`). FS-73's `K|Q(sqrt11,i)|D36` is loose by a gap at `N = 5` (5-integral, not rich). ℚ(√167)'s `L21cc6506` is loose
   at four colours by a full-dimensional `Θ₄` cell (row 81; FS79-T39). **Stripped of arithmetic the question is already yes**: FS85-dB2, a
   triangle-free `G(ℤ, D)` whose four-colourings all factor through `K₄` (row 86) — so the class must keep the rotation structure (plan §IQ S2).
6. **The calibration** (FS85-dB4, row 86; `CLOSED-QUESTIONS.md` §3; `[Soifer2024]` ch. 55, Problems 55.1–55.2, posed in Soifer's 2019
   *Chromatic problems and prizes*): a finite triangle-free unit-distance graph with a four-colour forced pair exists iff a triangle-free
   five-chromatic one does. Inside `F` a forced pair is never chainable (FS79-T2), so the five-chromatic graph leaves the field.
7. **What does not work, already proved** (rows 80, 87): cell-local formats (edge heights, loop winding, face fluxes, coindex bounds) certify
   nothing at four colours; second moments do not pin the spectrum on de Grey's lattice (C14); a slack quotient can still force (L16).
8. **Prior art the gate found, shared** (plan §PA.3): the tetrahedral embedding of a four-colouring is a **vector 4-colouring**; the
   algebraic-graph-theory handle on "every optimal colouring" is the least-eigenvalue framework and unique vector colourability —
   Godsil–Roberson–Rooney, DCG 58 (2017) Thm 4.9, and Godsil–Roberson–Rooney–Šámal–Varvitsiotis, Math. Program. 182 (2020) (vector colourings
   of categorical products); both held in `~/source/library/pdf/` (arXiv-1512.04972, arXiv-1801.08243). Nothing in print states a four-colour
   forced pair in a triangle-free unit-distance graph, or periodicity of every colouring of a field plane.
9. **Records to use, not re-derive:** the saturated chain and the named rich lattice `Λ₅₁₀` (plan §S.1; `data/fs86/stageA/`); FS-81's layer
   method (`plans/FS81-derivation.md` T1–T8; G74); `forces_iff_exists_finite` and the Kempe layer (row 78, `Kempe.lean`, kernel).
   **Transfer rule** (FS85-V6): a held proof used on a new object is re-walked for its logic, not only checked for membership.

## The challenge (one challenge; choose your order)

**S1.** For `F = ℚ(√59)`: is every proper four-colouring of `Cay(R, U_F)` periodic — equivalently, local at the dyadic place, a pullback from
`P₄` (`F(R) = R ∩ 𝔓⁴`) — or is some four-colouring not periodic (`F(R) = 0`)? Prove either, or classify the four-colourings by an invariant
every one carries.
**S2.** The same question for every field plane in the class "four-colour periodic structure local at one Hoffman-tight place, no triangles"
(plan §IQ S2): does the answer depend on triangles, and what, if anything, replaces them — a local linear identity on the tetrahedral
embedding that pins the spectrum (G75's killing test), or a proof that no identity of a named format can?

**Scope rule.** `F(i)` is divisible, so "periodic" and "local at 2" are per `R`-coset (plan §0.3 (ii)). State every result at its object: the field plane (`R`), the class, or a lattice (`Λ₅₁₀`: `F(Λ) ⊆ F(R) ∩ Λ`, and `P(Λ)` is a
different, lower question). A result on a lattice is not a result on the plane. **Strengths:** a yes must be proved at `F` itself, with its
inhabitant; a no is one non-periodic colouring (or a proof that one exists).
**What each outcome looks like:** a yes is a finite triangle-free subgraph of `Cay(R, U_F)` forcing a pair (at dyadic depth ≥ 4), and answers
Soifer 55.1 (it then needs two derivations and a blind verifier); a no is an explicit or proved-to-exist non-periodic four-colouring (for
instance one not local at 2); a no-go is a theorem that a named format of pinning identity cannot exist on these planes; a class theorem
decides S2.
**The killing test** (plan §S.4, with its trivial list T) is adjudicated by Poros at the end of round 1.

## The ban, and the search log

No search for a finite witness until 2026-10-01 (`CLAUDE.md` § Toolchain): no SAT/MaxSAT/#SAT, MILP/CP, local-search colourers, Θ relation
trees or float Θ finders, quotient-colouring searches, lattice sweeps. In: hand derivation; exact computer algebra (PARI, GAP, sympy);
colourings given by formula; the Lean kernel; existing checkers; an exact LP only when a derivation fixes its shape and its dual is read back
as an identity. Keep a **"would have searched here" log**: one line per move you would have made by search, and what you did instead.

## The competition, and the protocol

Teasing hints only, to your competitor by SendMessage — movement, never the mechanism or a coordinate. Poros advises you both identically and
carries nothing between you. Prior art is shared. Your working file lives in your own scratch directory until you hand back; never open the
other side's. Every report to the owner goes by SendMessage to "main"; every hand-back is exactly "<name> idle; no content in this hand-back;
my reports go to the owner by SendMessage". Count your retractions. **Do not spawn subagents, forks or workflows**: delegation here is one
level deep (`CLAUDE.md` § Delegation), because staffing is Kooshi's budget decision and the owner can only review work it knows about; if the
work outgrows your context, stop at a clean boundary, persist, and say what is left. Heavy jobs (over 2 GiB or 2 minutes) go through
`scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`; /tmp is RAM, so large files go to disk. Frozen tools are never edited.

## What is yours to decide

Everything about the mathematics: the order of S1 and S2, the field, the formats, how much of the record to trust. If the challenge as posed is
subtly the wrong challenge, say so — that is a finding, not a refusal. Two standing obligations: the prior-art gate (name the object in its
discipline's words and search that; the plan's §PA is where it stands) and honest reporting (a line that does not land is reported as not
landing). Take your time; a clean two-page argument beats a big object.
```

### C.2 The advisor's slots (protocol §5)

```
## The situation
[§C "The mathematics you are standing on", items 1–9, verbatim, with stage B's addendum]

## The challenge
[§C "The challenge", verbatim]

## Your specific duties this run, beyond the template
1. Adjudicate the killing test (plan §S.4) in writing at the end of round 1: K1–K4, each with the check you ran; police T, and name the item
   a rejected condition reduces to; for K3, pin the format in writing before reading the proof.
2. Police scope: field plane, class, or lattice; a lattice result is never scored as a field result; a yes at `F` only.
3. Police the free outcome: `P(R) ≠ 0` is known (plan §0.3); a result that restates it is not progress on S1.
4. Police transfer: forcing is monotone upward; a held proof used on ℚ(√59) is re-walked for its logic (FS85-V6).
5. The plan-phase advisor's held items (labels in its hand-off; contents in its HELD file only) go to both competitors at the same moment,
   after both first routes are written (ruling R1 at FS-73). Frame-level items may go to both earlier, at once (protocol rule 6).
6. Count retractions, yours included; log asymmetric cards where both read them at hand-back.
7. Any claimed yes or no: tell the owner at once, so a blind verifier can be launched while round 2 runs (protocol rule 11).
```

## §P. Registered predictions and verdicts (before any run)

| id | prediction | p | the uninformative outcome, and whether it is reachable |
|---|---|---|---|
| P-free | `P(R) ≠ 0` at the field level holds (stage B confirms §0.3 (iii) blind) | 0.85 | **a free outcome, not informative** (G21): registered so it cannot be scored as a result about F |
| P-dich | B1 confirms `F(R) ∈ {0, P(R)}` for ℚ(√59) | 0.90 | a defect found: reachable |
| P-K | the §0.4 corollary (every four-colouring of `K²` local at one dyadic place) confirmed by B1 | 0.80 | reachable both ways |
| P-sat | `Λ₅₁₀`'s saturation depth `m* ≥ 5` (`U ↠ S_5`, 48 residues) | 0.55 | `m* ≤ 4`: reachable |
| P-slack | some `Q_m` of `Λ₅₁₀` is slack at four colours by the level where `U` is injective | 0.80 | every level tight: reachable (then `P(Λ₅₁₀)` is pinned at the 2-power level) |
| P-undec | at least one slack level of `Λ₅₁₀` stays "slack, undecided" this week | 0.70 | decided by derivation at every slack level: reachable |
| P-yes | `F(R) ≠ 0` proved for a type-(B) field by the close, two derivations and a blind verifier | 0.02 | not proved: reachable. *The prior's strength, after §PA read `[deGrey2026]`'s summary:* triangle-free five-chromatic UDGs exist in ℝ³ (61 vertices), so no dimension-free obstruction to a yes exists; in the plane 55.1 has stood since 2019 with nothing in print toward it, and a yes here would be a forcer in a four-chromatic field, which no field outside K has shown. Strong, not overwhelming |
| P-no | `F(R) = 0` proved for a type-(B) field by the close | 0.20 | not proved: reachable |
| P-nogo | a proved no-go of a named pinning-identity format on type-(B) planes, not implied by rows 80, 87 | 0.35 | none: reachable |
| P-K-fires | the killing test fires | 0.35 | reachable both ways (§S.4) |
| P-G75 | a triangle-free identity pinning the spectrum onto torsion is found (G75's killing test fires) | 0.05 | not found: reachable |
| P-G71′ | any landed result on S1 uses the dyadic place essentially (G71's reading survives) | 0.75 | a landed arithmetic-free proof on a field plane: reachable only if S1 lands |
| P-83 | whatever lands for 59 lands for 83 and 131 by the same argument | 0.80 | a result special to 59: reachable |
| P-log | the planner's log ≥ 3 lines; each competitor's ≥ 2 by round 1 | 0.70 | zero lines: reachable |

**Verdicts, covering every reachable outcome** (they score only the experiment — whether algebra decides four-colour rigidity in a
triangle-free field; every proved new theorem is a success of the milestone whatever its verdict):

| verdict | outcome | registered p |
|---|---|---|
| **Paid (yes)** | `F(R) ≠ 0` for a type-(B) field at two derivations and a blind verifier (Soifer 55.1) | 0.02 |
| **Paid (no)** | `F(R) = 0` for a type-(B) field, verified blind; or a class theorem deciding S2 with a no. **A restricted negative:** it says no finite triangle-free unit-distance graph *over that field* forces a pair; it does **not** answer Soifer 55.1 (the asymmetry: only a yes crosses to the plane, by dB4) | 0.18 |
| **Paid (no-go)** | a verified no-go of a named pinning format on type-(B) planes, or a K1 necessary condition shown to fail on a named member, with nothing decided at `F` | 0.25 |
| **Draw (frame)** | only §0.3's frame verified (the free `P`, the dichotomy, the K corollary), possibly with lattice results | 0.25 |
| **Draw (lattice)** | only `Λ₅₁₀`'s profile or `P(Λ)` facts beyond the frame (including "slack, undecided") | 0.10 |
| **Draw (K)** | a result about K only (ruling 1 of FS-85, carried) | 0.05 |
| **Null** | nothing beyond stage A | 0.15 |

A result for ℚ(√83) or ℚ(√131) alone scores as for ℚ(√59) (the class is type B). A result on type (A) fields alone scores Paid (no) or
Paid (no-go) only if it is a class theorem whose class contains ℚ(√59); otherwise Draw (frame). **Changed from the stub:** the stub's "Yes,
`P₄ ≠ 0`" is moved from an informative outcome to a free one (P-free), and its "No — the tower forces nothing on some rich lattice" is split
into a lattice outcome (Draw (lattice)) and a field outcome (Paid (no)), because the full tower's forcing is row 67's and the lattice's tower is
a finiteness artefact (Poros's FR-1).

## §M. The modeling passes (WORKFLOW 6)

- **Domain pass, folded here** (no Lean this milestone; the objects are pinned in §0 and §S.1): `R = ℤ[U_F]`; `F(R)`, `P(R)`, `P_m`, `Q_m`,
  `m*`; "local at the dyadic place" = pulled back along `R → O/𝔓⁴`; "rich" (S.1); type (B) (§IQ S2); the tetrahedral embedding as a vector
  4-colouring (§PA.3).
- **Obligation pass: declined as a stage.** The proofs are the competitors'; a planner's decomposition would be a head start. Each agent runs
  `debruijn-obligation-modeling` on its own route if a proof resists.
- **Experience pass: not applicable** (no consumer surface).
- **Kernel:** none planned; any landed theorem gets a kernel decision at the close.

## §X. The planner's "would have searched here" log

1. **Would have screened the saturated chain over ℚ(√59) for survivors** (quotient colourings at small `N`, as FS-79 did at 167). Instead
   defined "rich" by arithmetic that certifies by theorem (§S.1) and named `Λ₅₁₀`; the colourability of anything was not asked.
2. **Would have asked a solver for a gapped four-colouring of `Λ₂₇₃₀`'s image at the ramified 59** (Hoffman does not refuse it). Instead
   recorded it as the definition's non-example and moved to `Λ₅₁₀`, whose image is the full circle.
3. **Would have computed `Λ₅₁₀`'s dyadic saturation depth and `Q_m` spectra** — exact computer algebra, in scope, but route 1–2's content;
   left to stage B so that the competitors and the plan start from the same point.
4. **Borderline, logged:** four float Hoffman ratios per lattice at primes ≤ 59 (§S.1), over three chosen lattices, to pick a named instance —
   a spectrum of fixed targets, not a colouring search; B3 makes them exact.

## §Y. The exchange with the plan-phase Poros, and its dispositions

| # | the advisor's point | disposition |
|---|---|---|
| 1 | a second exact check of the row-67 identification (PARI) | **adopted**: §0.1, two independent checks |
| FR-1 | the field plane against a lattice: `F(R) = ⋃ F(Λ)`, `F(R)` an ideal so `F(R) ∈ {0, P(R)}`, and `P(R) = R ∩ 𝔓⁴` by `[Zhang2012]` MIS-normality; the stub's weak yes is free | **adopted**; it re-aims the milestone (§0.3, §IQ, §C, §P). Credit Poros. Not yet blind-derived: stage B1 |
| FR-1′ | the ramified tower at 59 closes by a fibre argument (ratio ≤ max(0.199, 2/62)) | **adopted**; checked by the planner at the argument level, not blind; B1 |
| FR-2 | pose the challenge on the field plane; the stripped class is already yes (dB2), so the class must keep the rotation structure | **adopted**: §C S1–S2, §IQ S2 |
| FR-3 | the arithmetic (19, the ramified 59) | the planner's own; agreed |
| (a) | silent entries that bear: G55's transport, G66's profinite frame, G43/G59 and `[Zhang2012]`'s MIS half, G48 with FS-64/66/67, G41's additive control, G74/FS-83, G54's killing test on `Q_m`, G21, G71, G73, row 75, dB2 | **adopted**; all marked B in §G |
| caution 1 | route 1's falsifier cannot fire on the full tower; on `Λ₅₁₀` only past saturation | **adopted**: §0.1, §B B2 |
| caution 2 | "slack, undecided" must be a registered outcome with a verdict | **adopted**: P-undec, Draw (lattice) |
| owner's condition (via Poros) | registrations on the dichotomy and the product pull-back stand only after a second derivation | **adopted**: B1 is blind; P-free, P-dich conditional on it |
| K | the planner's K corollary misses a step: two dyadic places with equal ratio is Zhang's case (ii); tightness of `P_m × P′_m` (pure least eigenspace) picks the place; `F(R_K) = 4R_K`, a classification of every four-colouring of `K²`, needing its own two derivations and prior-art check | **adopted** (§0.4); the planner's four-line version counted as a planner slip, not a retraction (never sent as a claim to a third party); B1 derives it blind; the owner should log it as a candidate theorem |
| scope | `F(i)` is divisible: "periodic" is per `R`-coset; globally "`F(R)`-invariant" | **adopted**: §0.3 (ii), §C scope rule |
| 3(a) | the class stated sharply: one stable place with `χ_f ≤ 4`, Hoffman-tight at every level; at ℚ(√47), ℚ(√167) no finite quotient four-colours | **adopted**: §IQ S2 |
| 3(b) | the verdicts' asymmetry: `F(R) = 0` over ℚ(√59) is a restricted negative and does not answer Soifer 55.1 | **adopted**: Paid (no)'s row |
| 3(c) | register the prior's strength after reading `[deGrey2026]` | **adopted**: P-yes's note (summary only — the paper is not held) |

Retractions in stage A: **planner 0, advisor 0**. By G51 the disagreement has not started (two convergences, no retraction); the advisor asked
that FR-1 be attacked in the blind B1, not here. The advisor stood down at about 381k tokens (harness counter) after its frame items; its
held items (if any beyond FS-85's file) are in its record, for the competition advisor.

## Phase records

### Stage A — Theorems this phase proved

- **FS86-A1.** For `d ≡ 3 (mod 8)`, `ℚ₂(√d) = ℚ₂(√3)` and `ℚ₂(√d, i) = ℚ₂(ζ₁₂)`; so the dyadic local plane of ℚ(√59), ℚ(√83), ℚ(√131) is
  `LEDGER.md` row 67's `P_m`. [exact; the planner (`3d ≡ 1 mod 8`); Poros (PARI) independently.] Rests on it: §0.1–0.3.
- **FS86-A2.** Stable primes of ℚ(√59) below 60: 2 (inert in `F(i)/F`), 11, 23, 31, 43, 47, 59 (ramified); of ℚ(√83): 2, 19, 43, 47; of
  ℚ(√131): 2, 19, 23, 31, 47. [exact, `data/fs86/stageA/spec_checks.py`.] Corrects the stub's and H5's "11, 19, 23" at 59.
- **FS86-A3.** `Λ₅₁₀` over ℚ(√59): 324 unit vectors, rank 4, covolume `3⁻⁴5⁻⁴17⁻⁴` in the `O`-basis, `Λ₅₁₀ ⊗ ℤ₂ = O_𝔓`, `1/3, 1/5, 1/17 ∈
  Λ₅₁₀`; its images at every prime of norm ≤ 59 listed in §S.1. [exact, except the Hoffman ratios: float.] `Λ₂₇₃₀`'s image at 59 is 44 of 60
  points. [exact] (`index.py`, `profile.py`, `inert.py`, `cover59.py`, two unit-vector enumerators cross-checked at `M = 30, 210, 2730`.)
- **FS86-A4.** A 3-integral or 5-integral lattice over ℚ(√59) is three-colourable (it maps into `UD(𝔽₉, 2)` or `UD(𝔽₅, 2)`, both
  three-chromatic), so loose at four (FS79-T1). [hand, the planner, from row 72 and G64's `χ(Γ₅) = 3`.]

Stated, not proved here: §0.3 (Poros's, stage B1); §0.4 (the planner's corollary, stage B1).
