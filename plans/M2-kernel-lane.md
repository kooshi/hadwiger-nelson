# M2 — the kernel lane: FS-45's chain theorem, FS-39's bridge (route C), and FS-87's stripe lemma or FS-47's prime inversion

*Reframe and subplan by crunch job J04 (de Bruijn, Opus 5.5, 2026-09-25), from `data/crunch-2026-09-25/briefs/J04-M2-kernel-reframe.md`
and `STANDING-RULES.md`. The milestone is grade debt: the ban window (2026-09-24 to 2026-10-01) produced 171 hand theorems and no Lean
change (`plans/FS89-rational-band-rigidity.md` §R-close.9). Its jobs: J14 (FS-45), J15 (FS-39 route C), J16 (FS-87's stripe lemma or
FS-47's prime inversion), serial in the one kernel slot; J17 (FS-39's Artin–Lang step, by hand) beside the lane. The close inventory is
`plans/M2-close-inventory.md` (opened by the clerk). Skeletons: `data/m2/j04/`.*

**Targets, by column in §G:** **K1** = FS-45 (`plans/STUB-chain-theorem.md`), **K2** = FS-39 route C in the kernel plus the hand repair
of Fischer's Remark 1 (`plans/STUB-plane-bridge.md`), **K3** = FS-87's target 1, the stripe lemma (`plans/STUB-de-grey-chain-kernel.md`),
or FS-47's prime inversion (`plans/STUB-unit-vector-ring-kernel.md`) — chosen at stage 3 by two-leaf pricing.

## Stage 1 — SAVED

### 1.0 The quotation check (standing rule 5)

Every quoted statement in the brief, checked against its source on disk:

| # | quotation in the brief | source | verdict |
|---|---|---|---|
| Q1 | "G₄ (the 588-core's 8/3 refusal) is 'one cadical refusal … (no proof log on disk)'. Its D3 needs a fresh LRAT, and producing one means running a solver. That is banned until 2026-10-01." (attributed to the advisor, "verbatim") | `plans/POROS-2026-09-25-crunch-plan.md` §3 Send 3 (c) | **not found verbatim on disk.** The record's text is "FS-45's `K(√7)` instance needs a fresh LRAT of the 588-core (`plans/STUB-chain-theorem.md` line 76: "no proof log on disk"), i.e. a SAT run — out until 10-01." Same substance; the brief's wording probably came by message. The inner quotation matches the stub, line 76: "**[S]** one cadical refusal on the 588-core (no proof log on disk)". |
| Q2 | "is the ring the character results stand on; it is the better long-run investment than FS-87 if only one fits." (advisor) | Poros's record §3 Send 3 (a); the queue's J16 row | **not found verbatim.** The record says "FS-47 before FS-87 if time is short"; the phrase "the ring the character results stand on" is in the queue's J16 row (planner's words). Substance consistent. |
| Q3 | V2-T5, "under NT₀ every proper four-colouring of the triangular lattice is striped" | `plans/STUB-de-grey-chain-kernel.md` target 1; `plans/FS85-derivation.md` line 267 | **matches** (the stub adds "(type O/P wheels; propagation along a line, then line to line)"). |
| Q4 | "re-price a kernel phase from its first two leaves, never from the plan's table" | `CLAUDE.md` § What compute actually helps | **matches.** |
| Q5 | the chain theorem as G55 states it | `CLAUDE.md` G55 | **faithful paraphrase**, not a quotation: G55 reads "a finite graph over F forcing two points at difference δ equal at k colours makes every k-colouring of F² periodic under the ideal δR …; if 1/δ = u₁ + ⋯ + u_m is a sum of unit vectors, 1 is a period and χ(F²) > k". Carried verbatim into §S. |
| Q6 | `normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring` | `Proofs/HadwigerNelson/ResidueColouring.lean` lines 481, 599 | **both exist.** |
| Q7 | "171 hand theorems and no Lean change" | `plans/FS89-rational-band-rigidity.md` §R-close.9 | **matches** (39 + 68 + 64 = 171; "Lean files changed 0"). |
| Q8 | `1/p ∈ ℤ[U]` iff no conjugation-stable prime lies above `p` (FS-47) | `plans/STUB-unit-vector-ring-kernel.md` §1: "hence `1/p ∈ R` **iff** no stable prime lies above `p`" | **matches.** |

`CLAUDE.md` on disk is the loaded copy (275,129 bytes, last commit 1263d964, before this job started).

### 1.1 §G.1 — the grokkings, three columns (K1 · K2 · K3)

*Verdict per column: **bears** (what it changes, and where), **silent** (why), **falsifiable** (registered in §P). One line per entry.*

- G1 — K1 bears: the ℚ(√2,√3) instance must stop at four (wall standing: odd class 3 ≢ 7 mod 8) and K(√7)'s five needs √7's wall break → J14 spec docstrings · K2 silent: no wall · K3 bears (FS-47): prime inversion at 2 *is* the wall; inhabitants K (`1/2 ∉ R`) and K(√7) (`1/2 ∈ R`) → J16 option B.
- G2 — silent ×3: construction grammar of witnesses; nothing ported builds witnesses.
- G3 — silent ×3: radii/angles of witnesses; no port reads them.
- G4 — silent ×3: shell inventory; not a kernel object here.
- G5 — silent ×3: 1-sum factorisation of the 1581; not ported.
- G6 — silent ×3: hexagram containment; not ported.
- G7 — K1 bears: the chain's unit-vector sums are type-M relations `1 = 2n − nv − nv̄` (and `w = (−3+i√7)/4` at K(√7)); one spec example exhibits one → J14 skeleton · K2 silent: no rotations · K3 bears (FS-47): the Moser twist `2ρ + 2ρ̄ − 3 = 1/3` is the `1/3 ∈ R(K)` inhabitant → J16 option B.
- G8 — silent ×3: direction group of the 1581; not ported.
- G9 — silent ×3: G₄ is the only forcing-level object used, and it is a named hypothesis.
- G10 — silent ×3: distributed forcing; no criticality question here.
- G11 — K1 silent: the 18-vertex graph is Moser-free, a fact for its docstring, no phase change · K2 silent · K3 silent.
- G12 — silent ×3: quadrature law; no detuned copy is ported.
- G13 — silent ×3: fan ladder; no fan statement in the ports.
- G14 — silent ×3: width/degree of copies; not a kernel question.
- G15 — silent ×3: pigeonhole × kill; the chain is a pure kill composition, no class disjunction.
- G16 — K1 silent · K2 silent · K3 bears (FS-87): the √3-clean converse (MASCOT-T6) says the residue colouring is NT-clean — the stripe lemma's hypothesis has a known inhabitant → J16 skeleton's inhabitant.
- G17 — silent ×3: top-rung globality; no carrier search.
- G18 — K1 bears: certify the component, compose in the kernel — the chain theorem takes `Forces` on ONE copy and never asks the kernel about the union (the K(√7) union is 4,697 vertices; the ℚ(√2,√3) one is small enough for `decide` as a second oracle) → J14 design · K2 silent: no computation · K3 bears (FS-87): the stripe lemma is a finite wheel table (decide) composed with an induction on lines (proof) → J16 design.
- G19 — silent ×3: five-colour pattern sweep; no sweep.
- G20 — silent ×3: brick colourings; not ported.
- G21 — K1 bears: the 18-vertex refusal by `decide` needs a control that can go red — delete a critical edge (25 of 33 are critical) and watch `decide` find a 3-colouring → J14 spec · K2 bears: state the uninformative outcome — the transcendence theorem must have an inhabitant whose value is independently known (`ℚ(π)` against `ℚ`) → J15 · K3 bears: a stripe lemma whose hypothesis no colouring meets proves nothing — inhabit NT₀ with the residue colouring; for FS-47 inhabit both directions (K at 3 for "if", ℚ at 3 for "only if") → J16.
- G22 — silent ×3: where a six-colouring cannot live; not ported.
- G23 — silent ×3: cell family scale; not ported.
- G24 — silent ×3: gap law; not ported.
- G25 — silent ×3: recursive ladder reading; no six-forcer.
- G26 — K1 bears: FS-49's host consumer reuses the `Fin m`-indexed union, so `chainUnion` is stated for an arbitrary drawing and arbitrary `k`, not specialised to `planeOver` → J14 API · K2 silent · K3 silent.
- G27 — silent ×3: Galois symmetry of witnesses; no SAT ask.
- G28 — silent ×3: fine-tail forcing; not ported.
- G29 — silent ×3: cell family closed; not ported.
- G30 — K1 bears: (5) the general chain theorem ships an inhabitant — the kernel's rhombus forcer at three colours (row 58, `exists_forces_of_unit_drawing_three`), chained six times, IS the 18-vertex graph; (6) so the ℚ(√2,√3) instance is derived from the theorem AND by `decide`, two oracles; (7) the K(√7) statement's hypothesis `Forces core 4 a b` is uninhabitable in the kernel this week → `VACUITY DECLARED`, with the reason → J14 · K2 bears: (5) inhabitant `F = ℚ`, `t = π` (or a Liouville number if π's transcendence is not in Mathlib) → J15 · K3 bears: (5) the stripe lemma's NT₀ and FS-47's stable-prime hypotheses each get a named inhabitant; (7) NT₀ must not be implied by emptiness of the colouring domain (four-colourings of the triangular lattice exist) → J16.
- G31 — silent ×3: top-rung compulsion null; not ported.
- G32 — silent ×3: two-distance dial; not ported.
- G33 — silent ×3: batch descent; not ported.
- G34 — silent ×3: in-field descent; not ported.
- G35 — K1 bears: `3/8 = 3·(1/2)³ ∈ R` needs the wall broken; the explicit eight multipliers make the K(√7) statement independent of prime inversion → J14 takes the sum as data (as FS-47 D5 says) · K2 bears: route C's valuation subring is the explicit `t`-adic one, so G35's gate (number field ⟹ valuation subring) does not arise → J15 · K3 bears (FS-47): prime inversion at 2 is G35's "1/2 ∈ ℤ[U]"; the 𝒪-as-data form sidesteps the gate → J16 option B.
- G36 — silent ×3: residue floor tool; not ported.
- G37 — K1 silent: the chain replaces the spindle endgame in-field (G55 carries it) · K2 silent · K3 silent.
- G38 — K1 silent · K2 bears: the inhabitant `χ(ℚ(π)²) = 2` needs a kernel `χ(ℚ²) = 2` — row 63 says the two-colour form has no real-field instance yet, so price `χ(ℚ²) = 2` or state the inhabitant as the equality only → J15, §PA · K3 silent.
- G39 — silent ×3: critical-set localisation; no redundancy question.
- G40 — silent ×3: absorption; the chain's copies share only chain points, and forcing comes from `Forces`, not absorption.
- G41 — K1 silent · K2 silent · K3 silent: the `1/k` obstruction is a consumer of FS-47, not ported now.
- G42 — silent ×3: additive rigidity; not ported.
- G43 — K1 silent · K2 silent · K3 bears (FS-47): the "only if" is row 57's `normOne_subset_valuationSubring`; the field-level gate is what option B's 𝒪-as-data form defers → J16 option B.
- G44 — silent ×3: Kloosterman spectra; not ported.
- G45 — silent ×3: lift obstruction; not ported.
- G46 — K1 bears: recognise "the forced differences form a subgroup stable under unit-vector multiplication" — state periods as an `AddSubgroup` closed under `u •` and search Mathlib in that vocabulary; read `Copy.lean`'s data layout before generalising → §PA, J14 · K2 bears: route C is valuation theory — `RatFunc`, `Polynomial`, `ValuationSubring` at `X`; search there → §PA · K3 bears: the stripe lemma is a perfect-colouring / tiling statement (Kari–Szabados, Puzynina) and prime inversion is lying-over (`Ideal.exists_ideal_over_maximal_of_isIntegral`) → §PA.
- G47 — silent ×3: level-one compulsion face; not ported.
- G48 — K1 bears: state targets as `L`-values — ℚ(√2,√3) has `L = 4` (dyadic `K₄`), inside the proved range (√3-fields, `L ≤ 4`); K(√7) has `L = 7`, the conditional bound is five → J14 docstrings · K2 bears: the bridge is what makes the conjecture's bold form a statement about ℝ², so J17's statement names it → J17 · K3 silent.
- G49 — bears ×3: §PA is the Mathlib/core search for each statement plus a zbMATH gate on the bridge, in the disciplines' words (real places, specialisation, de Bruijn–Erdős) → stage 2.
- G50 — K1 bears: read `plans/ASTRA-2026-09-14-derivation.md` T5–T6 and `reference/…/example_qsqrt2_qsqrt3.json` before stating → stage 3 · K2 bears: `[Fischer1990]` is held and read; J17 reads Thm 6 and Remark 1 first-hand in the held PDF → J17 brief · K3 bears: read `plans/FS85-derivation.md` V2-T5 in full, and FS-47's ASTRA T1–T2 → stage 3.
- G51 — K1 silent: the kernel is the second mind · K2 bears: the Artin–Lang step is a hand derivation → J17 plus a blind check J17V with a fixed claim list · K3 silent: kernel.
- G52 — silent ×3: wall-breaking sufficiency reading; not ported.
- G53 — silent ×3: counting compulsion; not ported.
- G54 — silent ×3: tight/slack classifier; no residue plane is ported.
- G55 — K1 bears: the target itself — Theorem 4.1's chain, the spindle as `m = 2`, Harder's 8/3 as G₄'s prior art, "at most m(n − 1) + 1 vertices, in F itself" → J14 statements · K2 silent · K3 bears (FS-47): prime inversion "by lying-over", Fischer1990b's multiquadratic/quadratic prior art → J16 option B credit line.
- G56 — silent ×3: the window for six; odd-degree bipartiteness is not ported here.
- G57 — silent ×3: window triangle structure; not ported.
- G58 — silent ×3: antipodal conjecture; not ported.
- G59 — silent ×3: wall at six; not ported.
- G60 — silent ×3: fractional blow-up; the chain is integral.
- G61 — K1 bears: ℚ(√11)'s chain at three colours (`1/3 = 1 + 1 + v + v̄`, four copies of a 52-point forcer; row 73) is a second instance family — noted as a post-crunch consumer, not priced → §S note · K2 silent · K3 bears (FS-47): `1/3 ∈ ℤ[U]` instances (ℚ(√2,√3), ℚ(√3,√5)) are option B's inhabitants → J16.
- G62 — silent ×3: bilayer reading; not ported.
- G63 — K1 silent · K2 bears: the target — `χ(F(t)²) = χ(F²)`, `[Fischer1990]` Thm 6 credit, the named gap (Artin–Lang versus Tarski–Seidenberg) → J15, J17 · K3 silent.
- G64 — K1 silent · K2 bears: FS-39 phase C's second corollary ("`χ(ℝ²) ≠ 6` ⟺ every six-chromatic number field has a seven-chromatic finite real extension", FS62-T2) rides on the bridge; J17 states it as a corollary → J17 · K3 silent.
- G65 — silent ×3: solver phase diagram; no solver runs.
- G66 — silent ×3: residue towers; not ported.
- G67 — silent ×3: governs this walk's form (Do lines scanned), no phase change.
- G68 — silent ×3: quotient screens; not ported.
- G69 — K1 silent · K2 silent · K3 silent: de Grey's rigidity is FS-87's target 4 (W), not the stripe lemma.
- G70 — K1 silent · K2 silent · K3 bears (FS-87): the √3-clean class IS the residue colouring — the stripe lemma's inhabitant, and the stub names it → J16 skeleton.
- G71 — K1 silent · K2 silent · K3 bears (FS-87): the triangular lattice is the one presentation with a sum-closed half, so four-colourings there carry Moore–Newman's height; a height route to "striped" is a candidate proof shape → J16 brief (route note, not an instruction).
- G72 — K1 silent: a kernel port, not a derivation · K2 bears: §IQ for J17's hand step → §IQ · K3 silent: kernel port.
- G73 — K1 silent · K2 silent · K3 bears (FS-87): same as G71 — the stripe lemma lives exactly where an edge-local height exists (`±{a, b, a+b}`) → J16 brief.
- G74 — K1 silent · K2 silent · K3 bears (FS-47): the ℚ instance `ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (4)]` (FS89-S0A-1) is prime inversion over ℚ — option B's first spec example → J16 skeleton.
- G75 — K1 silent · K2 silent · K3 bears (FS-87): NT₀ is the linear identity `A₀g = −2g` on the tetrahedral embedding (C7); state NT₀ combinatorially (no monochromatic √3-triangle in family 0) and keep the spectral form out of the kernel lemma → J16 statement.
- G76 — K1 silent · K2 silent · K3 bears (FS-47): the re-aimed target is Lemma R at its corrected scope (no stable prime ramified in `F(i)/F`, FS86-CL2); prime inversion is its first half → J16 option B scope.

### 1.2 §G.2 — the ledger rows by mechanism

- row 1 — silent ×3: two-circle 3-colourability; not a dependency.
- row 2 — silent ×3: seam identity; not a dependency.
- row 3 — silent ×3: coverage ratchet; not a dependency.
- row 4 — silent ×3: fan/coverage iff; no fan in the ports.
- row 5 — silent ×3: class confinement; not a dependency.
- row 6 — silent ×3: 120° triangle identity; not a dependency.
- row 7 — silent ×3: `Greedy` colouring; no port needs it.
- row 8 — silent ×3: balanced 5-colouring of the 1581; not ported.
- row 9 — silent ×3: 120° compulsion; not a dependency.
- row 10 — silent ×3: one-pivot cap; not a dependency.
- row 11 — silent ×3: strip automaton; not a dependency.
- row 12 — silent ×3: tools extension profile; not a dependency.
- row 13 — silent ×3: negative knowledge (tools); not a dependency.
- row 14 — silent ×3: pair-gluing classification; not a dependency.
- row 15 — silent ×3: tools coupling statistics.
- row 16 — silent ×3: tools coupled automaton.
- row 17 — silent ×3: circle intersection (`Glue.lean`); not needed by the ports.
- row 18 — silent ×3: near-relation; not a dependency.
- row 19 — silent ×3: tools kill mechanism.
- row 20 — silent ×3: pivot-triangle layer; not a dependency.
- row 21 — silent ×3: tools registered statistics.
- row 22 — silent ×3: ladder pair 4-chromatic; not a dependency.
- row 23 — silent ×3: four-ladder object; not a dependency.
- row 24 — silent ×3: hexagram; not a dependency.
- row 25 — silent ×3: field-wall identity; not a dependency.
- row 26 — silent ×3: tools anatomy.
- row 27 — silent ×3: tools quadrature censuses.
- row 28 — silent ×3: 2-adic kill engine (`sqrt_indep`); not needed unless J14 proves radical independence.
- row 29 — silent ×3: tools stacking law.
- row 30 — silent ×3: tools mechanism hunt.
- row 31 — K1 bears: `core9_plane` is vacuous because the plane has no four-colourings — so the chain theorem is stated over a finite, `k`-colourable graph `G`, never with `Forces` over the plane's graph → J14 · K2 silent · K3 silent.
- row 32 — silent ×3: hex-shell/brick; not a dependency.
- row 33 — silent ×3: the upper-bound `planeOver` pattern only; no port proves an upper bound.
- row 34 — silent ×3: coset colourings; not a dependency.
- row 35 — silent ×3: coarse cells; not a dependency.
- row 36 — silent ×3: scale non-monotonicity; not a dependency.
- row 37 — silent ×3: tools gap atlas.
- row 38 — silent ×3: tools gradient hunt.
- row 39 — silent ×3: gap bands kernel; not a dependency.
- row 40 — silent ×3: tools fine tail.
- row 41 — silent ×3: limit lemma; not a dependency.
- row 42 — K1 bears: `Forces`/`Separated` live in `Arity.lean`; D1's hypothesis is that `Forces` → J14 · K2 silent · K3 silent.
- row 43 — K1 bears: `transport_pair_of_isometry`, `Forces.planeIn`, `isometry_affine` (`Homogeneous.lean`) are D1's transport → J14 · K2 silent · K3 silent.
- row 44 — K1 bears: `not_colorable_of_forced_equal` (`OneDefect.lean`) closes the chain; the spindle (`m = 2`) is the consistency corollary → J14 · K2 silent · K3 silent.
- row 45 — K1 bears: `not_forces_of_colorable` (spare colour) is why the conditional hypothesis is not trivially false — cited in the vacuity declaration → J14 · K2 silent · K3 silent.
- row 46 — K1 bears: `spindleRot`, `copyUnion`, `chromaticNumber_copyUnion_le` (`Copy.lean`, two copies) generalise to `chainUnion` → J14 · K2 silent · K3 silent.
- row 47 — K1 bears: G₄'s provenance (M53/M56; Harder's prior art) → J14 docstring · K2 silent · K3 silent.
- row 48 — silent ×3: critical-set localisation; not a dependency.
- row 49 — silent ×3: absorption; not a dependency.
- row 50 — silent ×3: additive colourings; Fischer attribution only.
- row 51 — silent ×3: additive rigidity; not a dependency.
- row 52 — silent ×3: finite-plane bound (hand); not ported.
- row 53 — silent ×3: field sieve; not a dependency.
- row 54 — silent ×3: lift obstruction; not a dependency.
- row 55 — silent ×3: residue obstruction; not a dependency.
- row 56 — silent ×3: local–global tightness; not a dependency.
- row 57 — K1 silent · K2 bears: `normOne_subset_valuationSubring` and `colorable_unitDistance_induce_of_valuationSubring` are route C's two lemmas → J15 · K3 bears (FS-47): the "only if" direction, in valuation form → J16 option B.
- row 58 — K1 bears: `exists_forces_of_unit_drawing_three` — the drawn rhombus is a kernel `Forces` at three colours, the chain theorem's inhabitant and the 18-vertex instance's gadget → J14 · K2 silent · K3 silent.
- row 59 — silent ×3: 2-adic valuation law; not a dependency.
- row 60 — K1 bears: `rotHom` gives ring-level rotations of `unitQuadrance R`, an alternative transport if the chain is stated over a ring → §PA · K2 silent · K3 silent.
- row 61 — K1 bears: statements at the proofs' level — colour-generic `k`, generic drawing — from the start → J14 · K2 silent · K3 silent.
- row 62 — silent ×3: overcompression; not ported.
- row 63 — K1 silent · K2 bears: the two-colour valuation form has no real-field instance, so `χ(ℚ²) = 2` in the kernel is not free → §PA, J15 · K3 bears (FS-47): Theorem 2.1's consumer, not ported now → noted.
- row 64 — K1 bears: `5 ≤ χ(K(√7)²)` holds at tools grade already (the ρ₆₃ arena); the conditional kernel theorem is the hand-sized route to its kernel form → §S · K2 silent · K3 silent.
- row 65 — silent ×3: shape-free arenas (tools); not ported.
- row 66 — silent ×3: fan-gap transport; not a dependency.
- row 67 — K1 bears: the LRAT core recipe (`Instances/TwoAdicFive/Edges.lean`) is how G₄'s post-ban certificate is fed to the kernel → §S post-ban note · K2 silent · K3 silent.
- row 68 — silent ×3: window certificates; not ported.
- row 69 — silent ×3: window narrowing; not ported.
- row 70 — silent ×3: U_Q, 27; not ported.
- row 71 — silent ×3: fractional blow-up; not ported.
- row 72 — silent ×3: 3-adic barrier; not a dependency.
- row 73 — K1 bears: `four_le_chromaticNumber_planeOver_eleven` is the `planeOver` lower-bound pattern the ℚ(√2,√3) statement copies; ℚ(√11)'s three-colour chain is a later instance → J14 · K2 silent · K3 silent.
- row 74 — silent ×3: quadratic census; not ported.
- row 75 — silent ×3: residue tower; not ported.
- row 76 — silent ×3: FS-70 screens; not ported.
- row 77 — silent ×3: theorem audit; kernel decisions already read in the stubs.
- row 78 — K1 bears: `Kempe.lean`'s `forces_iff_exists_finite` is Forces API J14 may use · K2 bears: de Bruijn–Erdős is in Mathlib (`Finset.rado_selection`), used by `Kempe.lean`, so FS-39 phase A is free → J17 cites it · K3 silent.
- row 79 — silent ×3: three-colour criterion; not ported (FS-75).
- row 80 — silent ×3: cell-by-cell no-gos (Moore–Newman carried by G71/G73).
- row 81 — silent ×3: ℚ(√167) at four colours; not ported.
- row 82 — K1 bears: relation-shaped sums (`1 = 2n − nv − nv̄`) are chain inputs; one appears as a spec example → J14 · K2 silent · K3 bears (FS-47): `1/3 ∈ ℤ[U]` instances → J16 option B.
- row 83 — silent ×3: census certificates; not ported.
- row 84 — silent ×3: ℚ(√47) calibration; not ported.
- row 85 — K1 silent · K2 silent · K3 bears (FS-87): V2-T5 is inside row 85's chain; NT₀, "striped" and the triangular lattice `T₀` are defined there → J16 option A.
- row 86 — silent ×3: triangle-free rigidity; FS-87 target 5, later.
- row 87 — silent ×3: no-gos on Λ; not a dependency.
- row 88 — K1 silent · K2 silent · K3 bears (FS-47): Lemma R and its corrected scope (FS86-CL2) → J16 option B.
- row 89 — silent ×3: K classification; FS-87 later candidate.
- row 90 — silent ×3: local rigid plane, W1; FS-87 later candidate.
- row 91 — silent ×3: type-(B) no-gos; not ported.
- row 92 — silent ×3: measurable windows; not ported.
- row 93 — silent ×3: dyadic tower tightness, C12.1; FS-87 later candidate.
- row 94 — silent ×3: ℚ(√11) non-periodic colouring; not ported.
- row 95 — K1 silent · K2 silent · K3 bears (FS-47): FS89-S0A-1 is the ℚ instance of prime inversion → J16 option B spec example.
- row 96 — silent ×3: character consequences; not ported.
- row 97 — silent ×3: one prime; not ported.

*One line per row, 1–97 (row 63 precedes 64 in the file).*

### 1.3 §G.3 — the method rules (the kernel rules first)

- § What compute helps, "re-price a kernel phase from its first two leaves" — bears ×3: stage 3 prices each target from its first two leaves; every kernel brief repeats it.
- § What compute helps, "a GPU is not a SAT accelerator" — silent ×3: no SAT.
- § Kernel cost model, `decide +kernel` not `decide` — bears K1: the 18-vertex refusal (3^18 colourings is too many for naive `decide`; use a `Bool` checker with a proof of soundness, or the SAT bridge's LRAT) → stage 3 price · K2 silent · K3 bears: the wheel table by `decide +kernel`.
- § Kernel cost model, reduction steps are the cost; GMP `Nat` free — bears K1, K3: exact coordinates as integer tuples (`UDCert` style), not `Real.sqrt` under `decide` · K2 silent.
- § Kernel cost model, literals not built data — bears K1: the 18 points and 33 edges as literals · K2 silent · K3 bears: the wheel table as a literal.
- § Kernel cost model, `List.all` not `∀ x ∈ l` — bears K1, K3: state list checks through `List.all` · K2 silent.
- § Kernel cost model, numerals at unsimplified type indices — bears K3 (if `ZMod` appears in the stripe data) · K1, K2 silent.
- § Kernel cost model, feed the core — bears K1: post-ban G₄ LRAT goes in as its core · K2, K3 silent.
- § Building, always `scripts/build.sh` under a slot — bears ×3: every kernel brief's build line.
- § Building, `lake env lean` does not apply `autoImplicit := false` — bears ×3: skeletons are iterated with it and the brief says so; stage 3 adds `set_option autoImplicit false` at the head of each skeleton so the check is honest.
- § Building, halt on unexplained crash — bears ×3: brief line.
- § Building, RAM is the discriminator (`scripts/slot.py`) — bears ×3: skeleton checks under `--mem 16 --cpus 4`, peak measured and declared.
- § Building, checkpoint rule [PROTECTED] — bears ×3: a Lean build is its own checkpoint (`.olean` per module); a job longer than 15 minutes of build saves its phase record per module landed.
- § Building, a blocking run is presumed killable [PROTECTED] — silent ×3: the lane is serial; no run blocks another.
- § Building, kill by PID, never a pattern — bears ×3: brief line (a stuck build is killed by the slot's scope, never `pkill -f lean`).
- § Building, a pipe can kill the producer; exit status through a pipe — bears ×3: gate commands read their own exit status (`set -o pipefail`).
- § Building, never edit a running shell script — silent ×3: no long shell runs.
- § Building, generated modules: `--` comments vs docstrings — bears ×3: the brief's verbatim line ("Prose in any module a certificate imports is written as `--` comments").
- § Searching, `ugrep` under-matches; `^` inside a pattern — bears ×3: §PA greps use `rg` / `grep -F`.
- § Searching, `rg` hides `.lake/` — bears ×3: Mathlib greps use `rg -uu` or `grep -rn` under `.lake/packages/mathlib`.
- § Searching, a failed `exact?` is not an absence; grep core — bears ×3: §PA records each negative with its query and path.
- § The package, `debruijn-init` for dependency changes — silent ×3: no dependency changes.
- § The gate, `vacuity.sh` with evidence — bears ×3: every structure/Prop hypothesis WITNESSED or DECLARED; counts reported.
- § The gate, every gate keeps its output — bears ×3: jobs cite `build/gate/<gate>/latest`.
- § The gate, inhabitant per structure hypothesis — bears ×3 (G30 lines above).
- § The gate, a spec example per definition — bears ×3: `chainUnion`, the transcendental adjunction, the stripe predicate each get an `example` that would fail if they drifted.
- § The gate, the Moser spindle proved twice — bears K1: the 18-vertex graph proved twice (chain theorem and a checker) is the same device → J14.
- § The gate, read the final statement aloud — bears ×3: each brief's last stage.
- § Make the gate fail (negative control each milestone) — bears ×3: each kernel job plants one fault (a moved vertex, a dropped edge, a wrong transcendental) and watches the build go red.
- § Make the gate fail, a positive signal for what did not happen; waiter false at arming — silent ×3 at plan level; bears only if a job waits on a build (brief line: wait on the slot's PID).
- § Make the gate fail, uninformative outcome reachable; both outcomes reachable — bears ×3 at §P.
- § Make the gate fail, pre-decide the response to a red gate — bears ×3: the stop rules in §S say what a red means before it happens.
- § Make the gate fail, exactly one thing differs between compared numbers — bears ×3 at pricing: two-leaf prices compare leaf against leaf under one machine and one command.
- § Make the gate fail, carry what a number measures — bears ×3: every price names its machine, command and module.
- § Make the gate fail, measured versus derived halves — silent ×3: no measured edges; every edge is an exact identity.
- § Make the gate fail, a check reads the value the code ships; mutate the constant — bears K1: the 18-vertex spec reads the literal the theorem uses, never a copy.
- § Make the gate fail, count the generator's free parameters — bears K1: `chainUnion` over `Fin m` with arbitrary `u` — its image includes the spindle (`m = 2`) and the 18-vertex chain (`m = 6`); check both are instances.
- § Make the gate fail, the remaining rules (formatting, two-sided plants, replay, failing-run cost, caveats, one-sided filters, archiving, enumerate parameter first, scars) — silent ×3: no instrument or search in this lane; each is re-read by a job only if it writes a tool.
- § Standard of evidence, no native evaluation — bears ×3: no `native_decide` anywhere in the lane.
- § Standard of evidence, artifact is certificate plus checker; re-derivable witness; write for the reviewer early — bears K1: the 18-vertex graph's construction (six chained rhombi) is stated, not only its coordinates · K2, K3 silent.
- § Trust ledger, `#print axioms`; grep the per-declaration native axiom — bears ×3: `scripts/axioms.sh` counts reported.
- § Trust ledger, `lean4checker` is a publication gate — silent ×3: not run.
- § Delegation, one level deep — bears ×3: every brief carries it with the reason.
- § Toolchain, the ban — bears ×3: kernel work is in; G₄'s LRAT is out; the would-have-searched log.
- § Toolchain, Python 3.14 `forkserver`; symmetry breaking before SAT — silent ×3: no pools, no SAT.

### 1.4 §G.4 — what the re-grokking changed (to be completed with §PA)

1. **K1's inhabitant and second oracle came from the corpus, not the stub**: row 58's kernel rhombus forcer inhabits the chain theorem at `k = 3`, and the 18-vertex graph is six chained rhombi — so the instance is a corollary of the theorem, proved again by a checker (G30 (5)–(6); § The gate's "proved twice"). The stub had it as a separate `decide`.
2. **The K(√7) statement's vacuity status is decided in advance**: `VACUITY DECLARED` with G₄ named, since no kernel inhabitant can exist this week (G30 (7); row 45's spare-colour lemma is why the hypothesis is not trivially false).
3. **K2's named inhabitant `χ(ℚ(π)²) = 2` is not free**: it needs `χ(ℚ²) = 2`, which row 63 says has no real-field kernel instance (G38). Priced in §PA; the fallback inhabitant is the equality `χ(ℚ(π)²) = χ(ℚ²)`.
4. **K3's choice gains a structural fact**: the stripe lemma lives on the one presentation with an edge-local height (G71, G73), and FS-47's first spec example is FS89-S0A-1 (G74, row 95).

### 1.5 §X — the would-have-searched log

| # | the move a search would have made | what was done instead |
|---|---|---|
| X1 | none at stage 1 | — |
| X2 | an LRAT refutation of the 18-vertex graph (CaDiCaL) as its second oracle | the gadget algebra by `decide +kernel` over the seven chain ports (§2.1) |
| X3 | a fresh LRAT of the 588-core to make the K(√7) theorem unconditional | the theorem is stated conditionally on `G₄`, declared for vacuity; the LRAT is post-ban |

## Stage 2 — SAVED

### 2.1 §PA — the repository's own modules, read at their source (G46: "read the construction's own data layout")

> **Correction owed (2026-09-25 crunch):** see `plans/M2-S1K-chain.md` stages 1 and 3; carried in `plans/M2-close-inventory.md` row 23. Not applied here; the close rewrites this entry.

| name | where | what it gives the lane | target |
|---|---|---|---|
| `Forces G k p q := ∀ C : G.Coloring (Fin k), C p = C q` | `Forcer.lean:41` | the chain's hypothesis; `Forces.comap` pulls it along any hom | K1 |
| `copyUnion q c ρ := (unitDistance ℂ).comap (copyDrawing q c ρ)` | `Copy.lean:158` | **cannot** be generalised as is: a `comap` union keeps coincident points as distinct vertices, so the chain's shared points `(j, b)` and `(j+1, a)` would not be identified and the forced equalities would not chain. The chain union must be the **induced subgraph on the image set**, `(unitDistance ℂ).induce (Set.range drawing)` | K1 |
| `isometry_affine`, `Forces.transport`, `transport_pair_of_isometry` | `Homogeneous.lean:108, 241, 199` | per-copy transport (or skip it: a copy's placement `z ↦ s + u(z − q a)` composed with the induce inclusion is a graph hom `G →g induce S` directly, and `Forces.comap` finishes) | K1 |
| `not_colorable_of_forced_equal`, `add_one_le_chromaticNumber_unitDistance_of_forces` | `OneDefect.lean:80, 127` | the spindle (`m = 2`) — the consistency corollary | K1 |
| `rhombus`, `rhombusGadget` (by `Gadget.ofExhaustion`, 81 colourings, `decide +kernel`) | `Gadget.lean:425–430` | the forced pair `(0, 3)` at three colours, kernel, no solver | K1 |
| `rhombusDraw`, `exists_forces_of_unit_drawing_three` | `Mascot.lean:256, 282` | a drawing of the rhombus; J14 draws it again in the JSON's orientation (`0, 1, (1+i√3)/2, (3+i√3)/2`, `δ = 1 + ω`) so the six multipliers are the reference's | K1 |
| `Gadget.transport`, `Gadget.inter`, `Gadget.edge`, `not_colorable_of_gadget` | `Gadget.lean:117–320` | **the second oracle for the 18-vertex graph**: six transported rhombus gadgets and the edge `0—1`, over the seven chain ports, refuted by `decide` — no solver, no LRAT (a CaDiCaL certificate would be a solver run, banned) | K1 |
| `planeOver F := {z | z.re ∈ F ∧ z.im ∈ F}`, `fieldOfRadicands`, `sqrt_mem_fieldOfRadicands` | `SquareClass.lean:63, 306, 311` | only membership lemmas exist: **no closure under `+`, `·`**, which the chain's placements need — a small `planeOverSubring F : Subring ℂ` leaf | K1, K2 |
| `four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem` | `Instances/SqrtEleven.lean:227` | the `planeOver` lower-bound statement shape to copy | K1 |
| `UDCert`, `Q4 = Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))` | `SeamCert.lean`, `SqrtEleven.lean` | **no `√2`**: the stub's P4 hunch holds — the ℚ(√2,√3) instance is drawn with `Real.sqrt 2`, `Real.sqrt 3` and the chain theorem, not through `UDCert`. The K(√7) instance's field (√3, √7, √11) IS in `Q4`, so a post-ban `G₄` certificate can use `UDCert` unchanged | K1 |
| `unitQuadrance R`, `unitQuadrance.map`, `unitQuadrance_colorable_of_ringHom` | `UnitQuadrance.lean:51, 82`; `ResidueTower.lean:64` | colourability pulls back along a ring hom — route C's last step (`A →+* F`, evaluation at `t = 0`) | K2 |
| `cosetResidue ψ`, `cosetResidue_sub`, `cosetResidue_apply_of_mem` | `ResidueColouring.lean:193–220` | **route C's coset step**: extend a hom from the subgroup `A × A` (the `t`-integral pairs) to the whole plane coset by coset; within a coset it is a conditional `map_sub`, so unit edges map to unit edges | K2 |
| `normOne_subset_valuationSubring` | `ResidueColouring.lean:481` | every norm-one element lies in a σ-stable valuation subring — **route C's integrality in its complex form** (the `t`-adic valuation subring of `F(i)(t)` is conjugation-stable), and FS-47's "only if" | K2, K3-B |
| `colorable_unitDistance_induce_of_valuationSubring` | `ResidueColouring.lean:599` | **does not fit route C as named in the brief**: it colours with `|G|` colours for a **finite** residue ring `G`, while route C's residue field is `F(i)`, infinite. Route C uses its mechanism (`cosetResidue`) with a colouring of `F²` in place of `|G|` distinct residues. Reported in §G.4 | K2 |
| `forces_iff_exists_finite` (via `Finset.rado_selection`) | `Kempe.lean` | de Bruijn–Erdős already used in the repository | K2 (J17) |

### 2.2 §PA — Mathlib and core, per statement (queried at the pinned Mathlib, `.lake/packages/mathlib`, with `grep -rn`)

> **Correction owed (2026-09-25 crunch):** see `plans/M2-S2K-route-c.md` §1.1; carried in `plans/M2-close-inventory.md` row 32. Not applied here; the close rewrites this entry.

| need | found | not found (query) |
|---|---|---|
| K1: sums over `Fin m` of unit vectors | `Finset.sum`, `Fin.sum_univ_succ`, `Finset.sum_range_succ` (standard) | — |
| K1: a chromatic bound from a hom into an induced subgraph | `SimpleGraph.chromaticNumber_mono_of_hom`, `Colorable.of_hom`, `SimpleGraph.induce` | — |
| K2: formally real fields | `IsFormallyReal` (`Algebra/Ring/IsFormallyReal.lean:104`), instance for strict ordered rings; `IsSemireal` | — |
| K2: `F(t)` as rational functions | `RatFunc.liftRingHom`, `RatFunc.liftAlgHom` and their `_injective` lemmas (`FieldTheory/RatFunc/Basic.lean:435, 468, 643, 653`); `transcendental_iff_injective`; `Polynomial.algEquivOfTranscendental` | an `IntermediateField.adjoin F {t} ≃ RatFunc F` equivalence (queried `RatFunc` in `FieldTheory/IntermediateField`, `Adjoin*`: none) — J15 defines `F⟮t⟯` as the `fieldRange` of the lift instead |
| K2: the place `t ↦ 0` | `polynomialValuationX : Valuation K⟮X⟯ ℤᵐ⁰` (`RingTheory/LaurentSeries.lean:462`), `Valuation.valuationSubring`, the coercion `K⟮X⟯ → K⸨X⸩` (`coe_coe`, `coe_X`), `HahnSeries.coeff_mul_order_add_order` (`RingTheory/HahnSeries/Multiplication.lean:518`), `PowerSeries.constantCoeff`; `RatFunc.inftyValuation` (the place at ∞, explicit) | a residue ring hom from the `X`-adic valuation subring of `K⟮X⟯` onto `K` (queried `residue`, `valuationSubring` in `FieldTheory/RatFunc/`, `RingTheory/LaurentSeries.lean`: none) — **this is route C's one real gap**, the leaf J15 prices |
| K2: a transcendental real number for the inhabitant | `Liouville.transcendental : Transcendental ℤ x` (`NumberTheory/Transcendental/Liouville/Basic.lean:179`), `transcendental_liouvilleNumber` (`…/LiouvilleNumber.lean:191`), `Transcendental.restrictScalars` | **π's transcendence** (queried `transcendental_pi`, `Transcendental ℚ π`, `Transcendental ℤ π`: none) — the inhabitant is Liouville's number, and "`χ(ℚ(π)²) = 2`" stays a hand corollary |
| K2: `χ(ℚ²) = 2` | nothing in the repository (row 63: no real-field instance of the two-colour form) | — so the inhabitant is the equality `χ(ℚ(L)²) = χ(ℚ²)`, and the value 2 is a separate, unpriced item (a `cosetResidue` colouring by `x + y mod 2` on 2-integral pairs, about a day) |
| K2 (J17): real closed fields, Tarski, Artin–Lang | `IsRealClosed` (definition and elementary lemmas only, `FieldTheory/IsRealClosed/Basic.lean`; its TODO lists "real algebraic numbers form a real closed field" as undone) | Tarski–Seidenberg, quantifier elimination for RCF, Artin–Lang, real places (queried `Tarski`, `ArtinLang`, `realClosure`: none) — the bridge's kernel form is weeks; the brief's "not priced this crunch" stands |
| K2 (J17): de Bruijn–Erdős | `Finset.rado_selection` (`Combinatorics/Compactness.lean:64`), `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` (`Combinatorics/SimpleGraph/Finsubgraph.lean:154`) | — |
| K3-B: prime inversion's "if" (lying-over) | **`Ideal.image_subset_nonunits_valuationSubring`** (`RingTheory/Valuation/LocalSubring.lean`, after `LocalSubring.exists_le_valuationSubring`, Stacks 00IA): for a subring `A` of a field `K` and a proper ideal `I`, a valuation subring `B ⊇ A` with `I ⊆ nonunits B`. Also `Ideal.exists_ideal_over_maximal_of_isIntegral` (`GoingUp.lean:344`), `ValuationSubring.primeSpectrumOrderEquiv` | — |
| K3-A: the stripe lemma | nothing needed beyond `ℤ × ℤ`, `Fin 4`, `ZMod 2`, `Int.induction_on` | — |

**The finding that re-shapes K3.** With `Ideal.image_subset_nonunits_valuationSubring`, prime inversion has a **valuation form** that needs no number-field
plumbing at all: for any field `L` with an involution `σ` and `R` the subring generated by the norm-one elements,

- *"`(p)⁻¹ ∈ R` iff `p` is a unit of every valuation subring of `L` that contains every norm-one element"* — ⟸ is Mathlib's lemma applied to the
  ideal `pR` (proper iff `p⁻¹ ∉ R`); ⟹ is immediate (`R ⊆ B`);
- and *"a valuation subring contains every norm-one element iff it is σ-stable"* — ⟸ is `normOne_subset_valuationSubring`; ⟹ in three lines:
  for `z ≠ 0`, `σz/z` has norm one, so `σz = (σz/z)·z ∈ B`.

So "no σ-stable valuation subring in which `p` is a non-unit" is the hypothesis, and the translation "σ-stable valuation subrings of a number field
`E` with `p` in the maximal ideal ↔ conjugation-stable primes of `𝓞_E` above `p`" is exactly row 57's gap (Theorem A's), deferred to FS-37 as the
stub's own D2 fallback says ("a cheaper first form takes the valuation subring `𝒪` and its maximal ideal as data"). This form is one Mathlib lemma
plus a page; the stripe lemma is a combinatorial induction. Stage 3 prices both from their leaves.

### 2.3 §PA — the prior-art gate on the bridge (J17), time-boxed

> **Correction owed (2026-09-25 crunch):** see `plans/M2-S1D-bridge.md` §1.1 (Q5–Q7); carried in `plans/M2-close-inventory.md` row 14. Not applied here; the close rewrites this entry.

- **The bridge is in print with a correct proof: `[Madore2015]` ¶5.4 with ¶1.3** (held, `~/source/library/pdf/arXiv-1509.07023-…pdf`; ¶5.4 read
  first-hand at this stage). ¶5.4, verbatim: "the finite graphs G for which there exists a graph homomorphism G → Γ(E^d) with E real closed do not
  depend on E … This time, the proof invokes Tarski's theorem on the decidability of the first-order theory of real closed fields … One consequence is
  that χ(R^d) = χ((Q^{r−alg})^d) where Q^{r−alg} stands for the real closure of Q". With ¶1.3's de Bruijn–Erdős, every finite subgraph of
  `(ℚ^{r−alg})²` lies in `F²` for a real number field `F`, so **`χ(ℝ²) = sup_F χ(F²)` is Madore's, 2015, by Tarski** — the one-line gap between
  his "real closure" and our "sup over real number fields" is de Bruijn–Erdős, which he states. `CLAUDE.md` G56 already reads the bridge as
  "`[Madore2015]` ¶5.4 plus de Bruijn–Erdős"; `plans/STUB-plane-bridge.md` §3a calls ¶5.4 "the nearest thing we have … cited in prose only", which
  undersells it: **it is the proof.**
- **`[Fischer1990]` Remark 1**, read first-hand (held, `library/papers/1-s2.0-0012365X9090324B-main.pdf`, p. 188–189), verbatim: "Given a finitely
  generated extension E ⊂ R over Q, it may be realized as a purely transcendental extension of some finite algebraic extension F over Q." False in
  general (G63, the stub). His Theorem 6's proof colours only `C₀(F(α)^d)` — the subgroup the unit vectors generate — by evaluation at 0, which is
  the `cosetResidue` mechanism J15 ports.
- **So J17's product is a write-up, not new mathematics**: the bridge credited to Madore (Tarski), Fischer's step named as the false one, and a second
  proof by the Artin–Lang homomorphism theorem (the route that extends route C), each with its Mathlib gap priced. Its value is the record's
  honesty (every "χ(ℝ²) = …" sentence cites a proof) and the price comparison FS-39's stub asks for; its novelty claim is none.
- **Discovery searches:** zbMATH API, one query answered before the service failed — `ab:"chromatic number" & ab:"plane" & ab:"algebraic" &
  ab:"de Bruijn"`: 2 hits, both books (`1250.05004` *Discrete mathematics*, 2010; `0612.05001` *Classic papers in combinatorics*, 1987); the
  next seven (`ab:"unit distance" & ab:"real closed"`, `ab:"chromatic number of the plane" & ab:"number field"`, `ab:"unit distance graph" &
  ab:"algebraic numbers"`, `ab:"chromatic number" & ab:"real algebraic" & ab:"plane"`, `ab:"chromatic number" & ab:"subfield" & ab:"plane"`,
  `ab:"specialization" & ab:"unit distance"`, `ab:"real place" & ab:"chromatic"`) returned **HTTP 502** from `api.zbmath.org` (2026-09-25,
  measured by a probe: 502 in 6.6 s). arXiv export API, `abs:"chromatic number of the plane" AND abs:algebraic`: 0 entries. **The gate is
  partial**: J17 re-runs the seven zbMATH queries first and records them.

### 2.4 §G.4, completed — what the re-grokking and §PA changed

5. **Route C's named tool is the wrong one**: `colorable_unitDistance_induce_of_valuationSubring` needs a finite residue ring; the port uses
   `cosetResidue` + `unitQuadrance_colorable_of_ringHom` (or `normOne_subset_valuationSubring` in the complex form). J15's brief says so.
6. **The chain union is an induced subgraph on the image set**, not a `comap` like `copyUnion`: the chain's shared points must be one vertex.
7. **K3 gains a cheap, honest option**: prime inversion in valuation form from one Mathlib lemma (`Ideal.image_subset_nonunits_valuationSubring`),
   the number-field translation left as row 57's named gap.
8. **J17 shrinks to a write-up**: the bridge is `[Madore2015]` ¶5.4's; the novelty is nil, the value is citation and pricing. Its blind check
   J17V is offered as optional (HELD FOR THE OWNER).
9. **No solver anywhere in the lane**: the 18-vertex refusal's second oracle is the gadget algebra by `decide`, not a CaDiCaL certificate.

## Stage 3 — SAVED

### 3.1 The skeletons (`data/m2/j04/`, each elaborating with `scripts/slot.py --mem 16 --cpus 4 -- lake env lean <file>`, `autoImplicit` off in-file)

| file | target | declarations | `sorry` left | closed by J04 (the two-leaf price) | elaboration (desktop, one run) |
|---|---|---|---|---|---|
| `K1Chain.lean` | K1 = J14 | 20 | 16 lines (13 declarations) | `junction_zero`, `junction_succ`, `junction_last`, `chainDrawing_b` (leaf 1: consecutive copies share their junction), `copyHom` (leaf 2: each copy is a hom into the induced chain graph) — **first elaboration, no error** after two name fixes (`rhombus` is not in `Gadget`; `seamField` is `FieldWall4.seamField`) | 1.9 s wall, 3.4 GB peak |
| `K2Transcendental.lean` | K2 = J15 | 12 | 7 declarations | `planeOverEquiv`, `dist_eq_one_iff_quadrance`, `planeOverIso` (leaf A: `(unitDistance ℂ).induce (planeOver L) ≃g unitQuadrance L`), `unitQuadrance_colorable_of_subring` (leaf B: coset reduction through a subring holding every unit vector, by `cosetResidue`) — **first elaboration, zero errors** (two linter nits fixed) | 2.5 s wall, 3.4 GB peak |
| `K3PrimeInversion.lean` | K3 option B = J16 | 5 | 2 declarations | `normOne_subset_iff_stable` (leaf 1: a valuation subring holds every norm-one element iff it is σ-stable — the three-line converse is new), `inv_mem_iff_forall_valuationSubring` (leaf 2: `x⁻¹ ∈ R` iff in every valuation subring above `R`, via `Ideal.image_subset_nonunits_valuationSubring`) — **second elaboration** (one argument-order fix) | ~2 s wall |
| `K3Stripe.lean` | K3 option A | 7 | 1 declaration + one placeholder | leaf S1, the wheel classification: all `4⁷ = 16,384` wheels checked by `decide +kernel` through nested `List.all` (a flat `List.range 16384` hit `maxRecDepth` — § The kernel's cost model's rule, met again); **plant** `diag == 3` only → `decide` proves the proposition false, so the check can go red for its reason | 18.4 s wall, 17.0 s user, 9.8 GB peak (whole-`Mathlib` import) |

### 3.2 The prices, from the leaves (never from a table)

| target | leaves closed / named | what the first two leaves measured | price of the rest | verdict |
|---|---|---|---|---|
| **K1** (J14) | 5 closed / 13 named | the core geometry (junctions, copy homs) is one elaboration per leaf; the transport API was not needed (a copy's placement is a hom into the induced graph directly) | `not_colorable_chain` (an induction over junctions, ~30 lines); `planeOverSubring` (~20); the field form (~25); the instance — `rhombusX_unit`, `sixUnits` with norm and sum identities over `√2, √3` (the riskiest: `Complex.ext_iff`, `Real.sq_sqrt`, ~40–60 lines), field membership in `fieldOfRadicands {2, 3}` (~20); the gadget oracle (six `Gadget.transport`s, `inter`, `decide`; the `survivors` cost is unmeasured); the four-colouring (~15); `G4` conditional with the eight `w`-multipliers over `√7` (~40–60) | **one job, about 3 hours; 300–350 lines** |
| **K2** (J15) | 4 closed / 7 named | the two generic leaves (the coordinate isomorphism and the coset reduction) were each one elaboration | the adjunction as the `fieldRange` of `RatFunc.liftRingHom` (~15); `le_adjoinTranscendental` (~10); **the one real leaf**: the `t`-integral subring, evaluation at 0 as a ring hom, and the integrality of unit vectors (100–200 lines; two routes: Laurent series with `HahnSeries.coeff_mul_order_add_order` and `IsFormallyReal`, or polynomials with the `X`-adic content — J15 prices both from their first leaf); assembly (~30); the Liouville inhabitant (~20) | **one job, 2.5–3 hours, medium risk at one named leaf** |
| **K3-B** (FS-47, valuation form) | 2 closed / 2 named | Mathlib carries the "if" in one lemma; the converse of `normOne_subset_valuationSubring` is three lines | the theorem (a composition, ~10 lines) and a spec example (`1/5 ∈ ℤ[U]` over `ℂ`, ~15) | **about one hour — below one job** |
| **K3-A** (FS-87 stripe lemma) | 1 closed / S2–S5 named | a finite local leaf costs ~15 s of kernel per `4⁷` patterns | S2 propagation (10 points: `4¹⁰ ≈ 10⁶` patterns ≈ 16 kernel-minutes and ~10 GB by the S1 rate, or fewer by pinning colours); the line induction and line-to-line induction over `ℤ` (150–250 lines); the type-O case (`c(x + 2u) = c(x)`, factoring through `(ℤ/2)²`, ~80); the `Striped` assembly (~60) | **4–6 hours, 400–500 lines — more than one job** |

**The choice for J16, with the four parts:** J16 is **FS-47's prime inversion in valuation form**, then its two consequences in the same
form (the 2-adic wall: `1/2 ∈ ℤ[U]` iff no σ-stable valuation subring has 2 in its maximal ideal; and the explicit `1/2 ∈ ℤ[U]` over K(√7),
whence `3/8`, the number J14's conditional theorem uses), then the stripe lemma's leaves S1–S2 as a start with its remainder proposed as a
queued job. *Alternative weighed:* the stripe lemma alone, as the queue's first-named option. *Why this won:* measured prices — K3-B fits in an
hour and K3-A does not fit in one job; the advisor's ranking (FS-47 first) agrees; and the number-field translation that K3-B leaves open is
row 57's gap, named, not hidden. *Confidence:* high on K3-B's price (two of its four leaves are closed and the rest is a composition); medium on
K3-A's (S2's pattern count is an estimate from S1's rate).

### 3.3 §X additions

| # | the move a search would have made | what was done instead |
|---|---|---|
| X4 | none — the wheel check is a complete exact enumeration of a set a derivation fixed (`4⁷` wheels), run in the kernel, logged here as the ban's "at the edge" case | — |

## Stage 4 — SAVED

### 4.1 §IQ — the invariant question, for FS-39's hand step only (J17)

1. **Existence form.** Is every finite unit-distance graph drawn in `ℝ²` also drawn (as a homomorphic image) in `F²` for some real number field
   `F`? Equivalently, `χ(ℝ²) = sup_F χ(F²)` over real number fields.
2. **Structural form.** For **every** finitely generated `ℚ`-subalgebra `A ⊆ ℝ` — every drawing's coordinate ring at once, with the metric
   and the graph stripped (any finite polynomial system over `ℚ` with a real solution) — is there a ring homomorphism `A → ℝ` whose image is
   algebraic over `ℚ`?
3. **The invariant it forces.** An **ordering** of `Frac(A)` extending to a real place with residue field real algebraic over `ℚ` — the
   real-spectrum point every solution carries. In the other discipline's words: `ℚ^{r-alg} ≺ ℝ` (Tarski), which is `[Madore2015]` ¶5.4's route.
4. **Its route.** Derivation only: the Artin–Lang homomorphism theorem (Bochnak–Coste–Roy, *Real Algebraic Geometry*, Thm 4.1.2, to be read
   and cited by section) applied to `ℚ^{r-alg}[A]`, then restriction to `A`; beside it, Madore's Tarski route. No search can answer it.
5. **The open instances it decides.** FS62-T2's exact form of "`χ(ℝ²) ≠ 6`" (G64); every "`χ(ℝ²) = …`" sentence of the conjecture's bold
   form (G48); FS-39 phase C's corollary `chromaticNumber_plane_eq_iSup_numberField` (its statement; the kernel form waits for real closed field
   theory, which Mathlib lacks, §2.2); the repair of `[Fischer1990]` Remark 1.

*Scored with §G: the structural form removes the graph entirely, so it is not the existence form reworded; its answer is a classical theorem,
so §G.4 item 8 holds — the milestone's value here is the record, not novelty.*

### 4.2 §S — the jobs

| job | kind | product | skeleton | price (from §3.2) | gate | stop rule |
|---|---|---|---|---|---|---|
| **J14** | kernel | `Proofs/HadwigerNelson/Chain.lean` (the theorem, three forms), `Instances/SqrtTwoThree.lean` (ℚ(√2,√3): chain route + gadget oracle + four-colouring), `Instances/SevenConditional.lean` (`G4` and the eight-copy conditional) | `data/m2/j04/K1Chain.lean` | ~3 h, 300–350 lines | the build green, zero `sorry`, `axioms.sh` and `vacuity.sh` counts reported, `five_le…_of_G4` DECLARED | at 3 h or 350k: land what is green; if the six-unit identity has not closed at 45 min, land the chain theorem and the gadget-oracle half, and name the identity as the leaf left |
| **J15** | kernel | `Proofs/HadwigerNelson/Transcendental.lean`: `planeOverIso`, `unitQuadrance_colorable_of_subring`, the valuation lemma, `chromaticNumber_unitQuadrance_ratFunc` (core, `[IsFormallyReal F]`), `chromaticNumber_planeOver_adjoin_transcendental_eq`, the Liouville inhabitant | `data/m2/j04/K2Transcendental.lean` | 2.5–3 h, medium risk at one leaf | as J14; the core theorem's inhabitant `F = ℚ` | at 2 h without the residue iso: land the theorem with the iso as an explicit hypothesis (a `structure` or `Prop` argument, DECLARED if uninhabited), report GAP at that leaf |
| **J16** | kernel | `Proofs/HadwigerNelson/UnitRing.lean`: `unitRing`, leaves 1–2, `inv_natCast_mem_unitRing_iff`, `inv_two_mem_unitRing_iff` (the wall), `inv_two_mem_unitRing_sevenField` and `three_div_eight_mem…` (explicit, over K(√7)), the spec `1/5` over `ℂ`; then `Proofs/HadwigerNelson/Stripe.lean`'s S1–S2 | `data/m2/j04/K3PrimeInversion.lean`, `K3Stripe.lean` | K3-B ~1 h; the stripe start with the remainder | as J14 | K3-B first and committed alone; the stripe work is saved per leaf; at 3 h stop and propose J16b |
| **J17** | derivation | `plans/M2-S1D-bridge.md`: the bridge by hand (Madore's Tarski route written in full; the Artin–Lang route; Fischer's false step named); the seven zbMATH queries re-run; the kernel price of each route | — | ~1.5 h, 200k | the record's "Theorems this phase proved" with grades | a verdict per claim C1–C4, or GAP at a named step |
| **J17V** | blind verifier (optional, P3) | `plans/M2-S1V-bridge.md` | — | ~1 h, 150k | verdicts on the fixed list | one stage; HELD FOR THE OWNER whether to run it (the argument cites one classical theorem) |

**Fixed claim list for J17 (and J17V's list, verbatim):**
- **C1** — "For every finite graph `H` and every map `f : V(H) → ℝ²` with `‖f(x) − f(y)‖ = 1` on every edge, there is a real number field `F`
  and a map `g : V(H) → F²` with `‖g(x) − g(y)‖ = 1` on every edge." (Non-injective `g` allowed.)
- **C2** — "`χ(ℝ²) = sup { χ(F²) : F ⊂ ℝ a number field }`, the chromatic number of `F²` meaning that of the unit-distance graph on `F × F`."
- **C3** — "`[Fischer1990]` Remark 1's first sentence is false: there is a finitely generated field `E ⊂ ℝ` over `ℚ` that is not a purely
  transcendental extension of any finite algebraic extension of `ℚ`." (With an explicit `E`.)
- **C4** — "`χ(ℝ²) ≠ 6` if and only if every real number field `F` with `χ(F²) = 6` has a finite extension `F′ ⊂ ℝ` with `χ(F′²) = 7`"
  (`plans/STUB-plane-bridge.md` §5, FS62-T2), given C2.

**Kernel lane order and the lines every kernel brief carries:** J14 → J15 → J16, one Lean build at a time; J17 beside the lane.

### 4.3 §P — registered predictions (before any M2 job runs; both outcomes reachable for each)

| id | prediction | p |
|---|---|---|
| P-J14a | J14 lands all three K1 products with the gate green inside its 3 hours | 0.65 |
| P-J14b | the gadget oracle's `decide +kernel` on the 18-vertex list finishes under 60 s | 0.60 |
| P-J14c | the six-unit identity closes by factoring — `δ(1 + ω̄) = 3` and `1 + v + v̄ = 1/3`, the sum being their product — in ≤ 40 lines | 0.75 |
| P-J15a | J15 closes the integrality leaf with no hypothesis left (else lands the residue iso as a named hypothesis, 0.35; else neither, 0.10) | 0.55 |
| P-J15b | Mathlib already holds an identification of the residue field of the `X`-adic valuation subring of `RatFunc K` with `K` (through `powerSeriesRingEquiv` or directly) | 0.30 |
| P-J16a | prime inversion in valuation form lands inside 1.5 hours | 0.85 |
| P-J16b | the stripe lemma lands in full inside J16 | 0.10 |
| P-J17a | no printed proof of the bridge is found besides `[Madore2015]` ¶5.4 (and Fischer's flawed Remark 1) | 0.70 |
| P-J17b | the Artin–Lang route's kernel price is judged lower than the Tarski route's | 0.50 |
| P-lane | no lane job touches a module a certificate imports (no certificate rebuild) | 0.90 |

### 4.4 §M — the modeling passes (fresh `Skill` invocations, this stage)

**Domain (`debruijn-domain-modeling`).**
1. *K1, the union is an image set.* `chainPoints := Set.range (chainDrawing …)` and the graph induced on it — coincident points are one vertex,
   which is the chain's whole mechanism (a `comap` union is the adversarial member: it four-colours the 18-vertex object's 19 indices).
2. *K1, the field form at its proof's level.* State it for any `S : Subring ℂ` holding the drawing and the multipliers
   (`add_one_le_chromaticNumber_induce_of_chain`); `planeOver F` enters through `planeOverSubring F`. Intrinsic structure: closure under `+`
   and `·`, not "a field of radicands".
3. *K1, `G4` in one vocabulary.* `planeOver (fieldOfRadicands {3, 11})`, not `FieldWall4.seamField` (J14 proves the inclusion it needs, or uses
   `seamField` if a bridge lemma exists); `q b − q a = 8/3` exactly — any drawing reaches it by a rotation through a unit of `K(i)`, which the
   docstring says.
4. *K2, the core statement is about rational functions, not about `ℝ`.* `chromaticNumber_unitQuadrance_ratFunc {F} [Field F] [IsFormallyReal F]
   : (unitQuadrance (RatFunc F)).chromaticNumber = (unitQuadrance F).chromaticNumber`; the `Subfield ℝ` form is its corollary through
   `planeOverIso` and the lift `RatFunc F ≃+* F⟮t⟯`. Formal reality is the true hypothesis (G63); the core's inhabitant `F = ℚ` is free, with no
   transcendence proof.
5. *K2, no proof in a definition.* The adjunction is `Subfield.closure (insert t F)` (or the lift's `fieldRange`, proved equal) with the
   transcendence proof used only in theorems — `adjoinTranscendental F t ht` depending on `ht` was the ugliness.
6. *K3-B, leaf 2 is the intrinsic statement*: "an element of a subring is invertible there iff in every valuation subring above it" is
   general; prime inversion is its instance at `x = n`, `R = unitRing σ`.
7. *K3-A, `NT0` by wheels* — every √3-triangle of `ℤ[ζ₆]` has a lattice centroid (`d(1 + ω)/3 = ω·unit` for `d` of norm 3), so "no
   monochromatic √3-triangle" and "no wheel with a monochromatic alternate triple" are one predicate; a spec example checks one triangle.

**Obligation (`debruijn-obligation-modeling`).** The statements from which the proofs derive:
1. *K1:* pull the colouring back to `c' : ℂ → Fin k` (`c' z := if h : z ∈ S then C ⟨z, h⟩ else 0`) and prove
   `∀ n ≤ m, c' (junction δ u n) = c' 0` by `Nat.le_induction`; the step is `Forces.comap (copyHom j)` plus `chainDrawing_b` — two lines. Then
   `junction 0 = 0`, `junction m = 1` (`hsum`), both in `S`, adjacent. `m ≠ 0` falls out of `hsum`.
2. *K1 instance:* factor, never expand: `∑ sixUnits = (1 + ω̄)(1 + v + v̄)` by `Fin.sum_univ_six` and `ring`; `δ(1 + ω̄) = 3` and
   `1 + v + v̄ = 1/3` are two-line identities by `Complex.ext_iff`, `Real.sq_sqrt` and `linear_combination`.
3. *K2, the valuation lemma (general, 15 lines):* for `B : ValuationSubring K` with `∀ x ∈ B, 1 + x² ∉ B.nonunits`,
   `a² + b² = 1 → a ∈ B ∧ b ∈ B` — if `a ∉ B`, then `a⁻¹ ∈ 𝔪`; if `b/a ∈ B`, `1 + (b/a)² = (a⁻¹)² ∈ 𝔪`, a contradiction; otherwise `a/b ∈ 𝔪`
   and the symmetric case. The `X`-adic instance then needs one thing: **a residue ring hom `B →+* F` whose kernel is `B.nonunits`** (from it,
   `1 + x²` has residue `1 + x̄² ≠ 0` by `IsFormallyReal`, and the coset reduction takes `φ :=` it). That hom is the one named leaf.
4. *K3-B:* `unitRing σ ≤ B.toSubring ↔ normOne σ ⊆ B` (`Subring.closure_le`), leaf 1, leaf 2, `Subring.natCast_mem`, `Nat.cast_ne_zero` —
   a three-line composition.
5. *K3-A:* S2 is a wheel statement, not a ten-point one: "the wheel at `y = x + v` with `r(−v) = a`, `r(−u) = r(−w) = b`, centre `c`, all
   distinct, has `r(+u) = r(+w) = d` and `r(+v) = a`" — `4⁷` patterns, S1's cost. The line step is `Int.induction_on` with S2 forward and
   backward (type P along `v` is type P along `−v`); the line-to-line step: a point of line `ℓ + 1` is adjacent to two consecutive points of
   line `ℓ`, so its colour avoids their pair, and properness along the line alternates it.

**Experience (`debruijn-experience-modeling`).** The published surface and its consumers:
1. *Names the consumers will search:* keep the stubs' names — `not_colorable_chain` (finite), `add_one_le_chromaticNumber_unitDistance_of_chain`
   (the plane; FS-49's host), `add_one_le_chromaticNumber_planeOver_of_chain` (FS-47's five-level), `four_le_chromaticNumber_planeOver_two_three`,
   `five_le_chromaticNumber_planeOver_seven_of_G4`; `chromaticNumber_planeOver_adjoin_transcendental_eq` (the FS-39 stub's name) beside the core
   `chromaticNumber_unitQuadrance_ratFunc`; `unitRing`, `inv_natCast_mem_unitRing_iff` (Mathlib's normal form is `n⁻¹`, not the stub's `1/p`).
2. *Binders:* the drawing `q` and multipliers `u` explicit; the marked pair `{a b}` implicit (the `Forces` argument determines them); unit-ness as
   `‖u j‖ = 1` (the graph's metric vocabulary; `mem_normOne_conj_iff` bridges from FS-47's side).
3. *Modules, new only* (a declaration added to `SquareClass.lean` or `ResidueColouring.lean` rebuilds their dependents): `Chain.lean`,
   `Instances/SqrtTwoThree.lean`, `Instances/SevenConditional.lean`, `Transcendental.lean`, `UnitRing.lean`, `Stripe.lean` — each added to
   `Proofs.lean`, to `ARCHITECTURE.md`'s module map (checked by `python3 tools/check_architecture.py`), and its public theorems to
   `scripts/Axioms.lean`'s CLEAN section.
4. *Docstrings read aloud:* each headline theorem says what the kernel proves and what it does not (no upper bound for ℚ(√2,√3); `G4` is a
   measurement; the number-field reading of `inv_natCast_mem_unitRing_iff` is row 57's gap). No `@[simp]` on any new lemma.

### 4.5 Theorems this phase proved

*Kernel-elaborated in scratch modules under `data/m2/j04/` with `lake env lean` (not yet in the library or the gated build; the kernel jobs move
them into `Proofs/` and the build checks them again).*

| theorem | grade | address |
|---|---|---|
| `junction_succ`, `junction_last`, `chainDrawing_b`: consecutive chain copies share their junction; the last junction is `δ·Σu` | kernel (scratch) | `data/m2/j04/K1Chain.lean` |
| `copyHom`: each placed copy of a unit-distance drawing is a graph hom into the unit-distance graph induced on the chain's points | kernel (scratch) | `data/m2/j04/K1Chain.lean` |
| `planeOverIso`: the plane over `L ⊆ ℝ` is isomorphic to `unitQuadrance L` | kernel (scratch) | `data/m2/j04/K2Transcendental.lean` |
| `unitQuadrance_colorable_of_subring`: colourability pulls back through any subring holding every unit vector's coordinates, along any ring hom out of it | kernel (scratch) | `data/m2/j04/K2Transcendental.lean` |
| `normOne_subset_iff_stable`: a valuation subring holds every norm-one element iff it is σ-stable (the ⟹ direction new, three lines) | kernel (scratch) | `data/m2/j04/K3PrimeInversion.lean` |
| `inv_mem_iff_forall_valuationSubring`: `x ∈ R` nonzero is invertible in `R` iff `x⁻¹` lies in every valuation subring above `R` (Mathlib's Chevalley domination) | kernel (scratch) | `data/m2/j04/K3PrimeInversion.lean` |
| `wheel_all`: under properness and NT₀ at its centre, every wheel of the triangular lattice is type O or type P (all `4⁷` colourings; a plant goes red) | kernel (scratch; a complete enumeration of a derivation-fixed set) | `data/m2/j04/K3Stripe.lean` |
| a unit vector `a² + b² = 1` lies in every valuation subring `B` with `1 + x² ∉ B.nonunits` for all `x ∈ B` (route C's integrality, general form) | hand (§4.4 obligation item 3; J15 ports it) | this plan §4.4 |

**Prior-art finding (not a theorem):** `χ(ℝ²) = sup_F χ(F²)` is `[Madore2015]` ¶5.4 with ¶1.3 (Tarski), 2015 — the FS-39 stub undersold it (§2.3).

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- the jobs' records: `plans/M2-S1K-chain.md` (J14), `plans/M2-S2K-route-c.md` (J15), `plans/M2-S1D-bridge.md` (J17), `plans/M2-S3K-unit-ring.md` (J16, in progress)
- modules: `Proofs/HadwigerNelson/Chain.lean`, `Proofs/HadwigerNelson/Instances/SqrtTwoThree.lean`, `Proofs/HadwigerNelson/Instances/SevenConditional.lean`, `Proofs/HadwigerNelson/Transcendental.lean`; audit lines in `scripts/Axioms.lean` (sections FS-45 and FS-39 route C)
- data `data/m2/j14/`, `data/m2/j15/`, `data/m2/j17/`; reports `data/crunch-2026-09-25/reports/J14.md`, `J15.md`, `J17.md`; close inventory `plans/M2-close-inventory.md`

## §R-close — M2's close (crunch job J23b, de Bruijn, Opus 5.5, 2026-09-25)

*WORKFLOW steps 8–9 for M2, from `data/crunch-2026-09-25/briefs/J23b-M2-close-math.md` (template J23a's, with `STANDING-RULES.md`). The
inventory is `plans/M2-close-inventory.md`; the kernel register is `plans/M2-derivation.md`; working files `data/m2/j23b/`. Drafts for
`LEDGER.md`, `CLAUDE.md`, `plans/FRONTIER-STUBS.md` and the stub banners live here only; the front-page job J24 applies them.*

### Stage 0 — SAVED (the full gate, once; WORKFLOW step 8)

Desktop, every run under `scripts/slot.py`, each exit status read from the gate itself (captured to a file, never through a
pipe). Copies of each gate's digest in `data/m2/j23b/*-stage0*.out`.

| # | gate | command | exit | result | log |
|---|---|---|---|---|---|
| 1 | build | `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh` | 0 | all 1,708 modules up to date, nothing built, 0 modules with warnings (a no-op build: the last build that compiled M2's modules is J17K2's, green with 0 warnings at `7fb8fcb7`, `plans/M2-S5K-noparam.md` §4.1) | `build/gate/build/20260925T232354Z-242469.log` |
| 2 | lint (the owner's ruling: once, at M2's close) | `scripts/slot.py --mem 60 --cpus 16 -- lake lint` | 0 | "-- Linting passed for Proofs." — the driver `batteries/runLinter` rebuilt nothing (its `buildIfNeeded` builds a module only when its `.olean` is missing, `.lake/packages/batteries/scripts/runLinter.lean:107–128`; both `.olean`s present); re-run with `--trace --no-build`: 14 linters (`checkType`, `defsWithUnderscore`, `deprecatedNoSince`, `docBlame`, `impossibleInstance`, `nonClassInstance`, `simpComm`, `simpNF`, `structureInType`, `subsetDotNotationLinter`, `synTaut`, `tacticDocs`, `unusedArguments`, `unusedHavesSuffices`) all passed, 3.5 s wall, 4.2 GB peak | `data/m2/j23b/lint-stage0.out`, `lint-trace-stage0.out` |
| 2c | lint's negative control | `lake env lean data/m2/j23b/LintControl.lean` (a scratch file, not in the library) | 1 (the plant) | **coverage**: runLinter's selector `getDeclsInPackage \`Proofs` hands the linters **11,817 declarations** (the auto-generated ones included), so the pass is not an empty scan; **firing**: a planted `def` with an unused argument and no docstring is reported by `docBlame` and `unusedArguments` both | `data/m2/j23b/lint-control-stage0.out` |
| 3 | axioms (before item 5) | `scripts/slot.py --mem 30 --cpus 4 -- ./scripts/axioms.sh` | 0 | **1,125 records — 1,109 clean on the standard axioms, 11 axiom-free, 5 declared purchases** (matches J17K2's gate); purchase ledgers agree; "RECORDED COUNT IS STALE — update CLAUDE.md § Trust ledger: 1034 clean → 1109" | `build/gate/axioms/20260925T232524Z-246256.log` |
| 3′ | axioms (after item 5) | same | 0 | **1,146 records — 1,130 clean, 11 axiom-free, 5 declared purchases**; the 21 new rows each CLEAN, none appeared elsewhere or changed | `build/gate/axioms/20260925T232928Z-253944.log` |
| 4 | vacuity | `scripts/slot.py --mem 30 --cpus 4 -- ./scripts/vacuity.sh` | 0 | `declarations=7051 refutations-skipped=304`; `sites=279 vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2` (the baseline's two, `hexShell_plane5`, `hexShell_plane6`); "RECORDED COUNTS ARE STALE — update scripts/vacuity-baseline.txt's header and CLAUDE.md § The gate: declarations 6795 → 7051, refutations-skipped 278 → 304, sites 275 → 279, generic 253 → 257" | `build/gate/vacuity/20260925T232531Z-246575.log` |
| 4c | vacuity self-test | `… ./scripts/vacuity.sh --self-test` | 0 | seven planted defects, each fired; the two silent ones stayed silent; the load-bearing control read `UNKNOWN` | `build/gate/vacuity-self-test/20260925T232629Z-248246.log` |
| 5 | architecture | `python3 tools/check_architecture.py` | 0 | PASS, before and after item 5 | `data/m2/j23b/arch-stage0.out`, `arch-stage0-after.out` |
| 6 | sorry | `grep -rn --include="*.lean" "sorry" Proofs/` | 0 (one match) | the one match is prose inside a docstring (`Proofs/HadwigerNelson/Packed.lean:266`, "a `sorry` waiting to be written into a definition"), no `sorry` term; the axiom audit finds no `sorryAx` | `data/m2/j23b/sorry-stage0.out` |
| 7 | M2's whole surface | `lake env lean data/m2/j23b/AllAxioms.lean` (`#print axioms` on all 226 declarations of M2's ten files, parsed by `data/m2/j23b/decls.py`) | 0 | **every one within the standard three**: 195 on all three, 21 on `[propext]`, 7 on `[propext, Quot.sound]`, 3 on none; no `sorryAx`, no native axiom | `data/m2/j23b/all-axioms.out`, `decls.json` |

**Item 5a — the audit's missing lines. The choice:** add to `scripts/Axioms.lean` every theorem an M2 record's "Theorems this phase proved"
table names and the audit did not print — 21 lines: the index's 13 (`Chain.norm_eq_one_of_sq`, `Chain.rhombus_unit_of`;
`SqrtTwoThree.sum_sixUnits`, `delta_mul_one_add_omegaBar`, `one_add_v_add_conj`; `RouteC.chromaticNumber_eq_of_iso`,
`chromaticNumber_planeOver_eq`, `one_add_sq_ne_zero`, `inv_mem_zeroIntegral_of_not_mem`, `chromaticNumber_unitQuadrance_eq_of_ringEquiv`,
`one_add_sq_ne_zero_of_subfield`, `le_adjoinTranscendental`, `mem_adjoinTranscendental_self`), plus eight the index did not reach because
J16's and J17K's files were in flight when it was written: `Stripe.wheelFacts`, `Stripe.proper_threeCol` and "the rotation transfers"
(`Stripe.rot_rim`, `proper_comp_rot`, `nt0_comp_rot`, `typeP_comp_rot`), and `IsSumSq.map`, `IsSemireal.of_ringHom`. *Alternative weighed:*
leave them unprinted, as the index recommended ("listed for the owner, not as a defect"), since each is used by an audited theorem and so its
axioms are bounded by that theorem's line. *Why this won:* a bound through a user is not a receipt — the kernel register below gives every
record-named theorem its own axioms line, and the audit's rule is "one `#print axioms` line per public theorem on the milestone's surface";
a theorem a record names as a result is on the surface (all 21 are public, none `private`). Cost: 21 lines, no build. *Confidence:* high.

**Item 5b — J16's leftovers. The choice:** commit `data/m2/j16/WheelProbe.lean` and `WheelProbe2.lean` as data, unchanged. They are the two
encodings J16 timed for the wheel check — the vector form `s2f ![a, b, c, d, e, f, g]` and the direct-argument form — and J16's record cites
the measurement they produced ("the per-wheel check on direct arguments beats J04's vector form (`![…]` indexing measured 15 s for one fact on
the same `4⁷`)", `plans/M2-S3K-unit-ring.md` §3.2). *Alternative weighed:* delete them as scratch (the library's `Stripe.wheel_all` supersedes
both). *Why this won:* a recorded timing should keep its source; they are 29 lines, outside `Proofs/`, and no build reads them.
*Confidence:* high.

**Gate verdict:** green — build, lint (passed, with a control that fires), axioms, vacuity and
its self-test, architecture, zero `sorry` terms. Two recorded counts are stale and are the front-page lane's to correct: `CLAUDE.md` § Trust
ledger ("1034 clean" → **1130**, after item 5) and `CLAUDE.md` § The gate plus `scripts/vacuity-baseline.txt`'s header (the vacuity counts
above). *Negative controls this stage:* lint (2c) and vacuity (4c) were each watched to fire; the build's and the axiom audit's plants were
run by the kernel jobs themselves (J14 stage 3, J15 stage 3, J16 stage 2, J17K2 stage 2; each record's plant section) and are not re-run here.

**Would have searched here (stage 0):** none — every step was a gate or an existing checker.

### Stage 1 — SAVED (the quotation check; the inventory walk; the corrections to this record)

**1a. The quotation check (standing rule 5).** Every quotation in J23b's brief, its template (J23a's) and the owner's launch message,
against its source:

| # | quotation | source | verdict |
|---|---|---|---|
| Q1 | "gate green at 7fb8fcb7: build 0 warnings, axioms 1109 clean / 11 axiom-free / 5 purchases, vacuity declarations 7051, refutations 304, sites 279, generic 257, architecture PASS" (launch message) | `plans/M2-S5K-noparam.md` §4.1; stage 0's own runs | **matches** both |
| Q2 | "`scripts/Axioms.lean` does not print 13 record-named M2 helper theorems" (brief, stage 0 item 5) | `plans/CRUNCH-2026-09-25-INDEX.md` §3.3 | **matches the index**, which lists exactly 13 — from J14's and J15's files only, J16's and J17K's being in flight when it was written; at `HEAD` the count was 21 (stage 0, item 5a) |
| Q3 | "`data/m2/j16/WheelProbe*.lean` are uncommitted leftovers of J16" | `git status` at launch | **true** |
| Q4 | "The lakefile's driver is `batteries/runLinter` on `Proofs`" | `lakefile.toml` lines 9–10 | **verbatim** (`lintDriver = "batteries/runLinter"`, `lintDriverArgs = ["Proofs"]`) |
| Q5 | "every M2 leaf was priced high" | the six records' price tables | **true of every priced product** — scored in stage 3's prices-against-actuals table |
| Q6 | Kooshi's close rules: "close out with the findings"; "I don't want to lose anything from before"; "All novel knowledge is a success." (J23a's template) | `plans/FS89-rational-band-rigidity.md:923` | **verbatim** |

**1b. The inventory walk.** `plans/M2-close-inventory.md` (rows 1–57 at the clerk's last fold `491161bb`; J17K2's report folded here as rows
58–63; stage 0's findings rows 64–65; one settled decision row 66). Every row now carries a status (counted from the file after the walk): **done** with its hash or stage, in whole or in part (21 rows: 2, 5, 6, 9, 10, 14, 16, 23, 25, 27, 32, 37, 38, 50, 54, 55, 56, 61, 63, 64, 66), or the stage that closes it — **stage 2** the kernel register (16 rows), **stage 3** the re-reads, predictions and tallies (18), **stage 4** the drafts (17); rows 5, 12, 14, 32, 50 and 61 are split across two. *Corrected at stage 2: the stage-1 text first gave 20 / 19 / 19 / 19, counted by eye.* No row was declined. One prior-art debt closed here: **the Snyder citation** (row 63) — zbMATH
`Zbl 1031.11012`, N. Snyder, "An alternate proof of Mason's theorem", *Elem. Math.* 55, No. 3, 93–94 (2000), one query
(`au:"Snyder, Noah" & ti:"Mason"`, `data/m2/j23b/zbmath-snyder.json`); J17's from-memory citation was right.

**1c. Corrections to this record's earlier stages, and to the job records** (their banners say "the close rewrites this entry"; the brief
confines the close to §R-close, so each correction lives here and the stage text stays as the history; the job records are frozen and are
corrected here, not edited):

| # | where | as written | corrected | source |
|---|---|---|---|---|
| C-1 | §2.1, row `Gadget.transport` | carries the rhombus gadget into the 18-vertex graph ("the second oracle") | `Gadget.transport` moves a gadget along `φ : Fin n → Fin n`, one vertex type; the carrier is the four-line cross-size pull `SqrtTwoThree.pullGadget` (`Instances/SqrtTwoThree.lean:135`), kept in the instance module so `Gadget.lean`'s dependents are not rebuilt | `plans/M2-S1K-chain.md` §1.0, stage 3; inventory 23 |
| C-2 | §2.2, row "K2: `F(t)` as rational functions" | "not found: an `IntermediateField.adjoin F {t} ≃ RatFunc F` equivalence" | it exists: `RatFunc.algEquivOfTranscendental (f : L) (h : Transcendental K f) : RatFunc K ≃ₐ[K] K⟮f⟯` (`FieldTheory/RatFunc/AsPolynomial.lean:229`); the query looked in the wrong directory. The adjunction landed as `(IntermediateField.adjoin F {t}).toSubfield` with Mathlib's equivalence | `plans/M2-S2K-route-c.md` §1.1; inventory 32 |
| C-3 | §2.3, the bridge's prior art | "The bridge is in print with a correct proof: `[Madore2015]` ¶5.4 with ¶1.3"; the lineage Fischer → Madore | **a re-finding**: `BIBLIOGRAPHY.md`'s `[Madore2015]` row (FS-53, 2026-09-15) and `CLAUDE.md` G56 already named ¶5.4 as the bridge. The lineage is **Benda–Perles (1976 manuscript, printed 2000; credited in `[Fischer1990]`'s introduction; unread) → Fischer 1990 Remark 1 (a false step) → Soifer 2009/2024, Open Problem 11.1's comment (asserted, no proof) → Madore 2015 ¶5.4 (a correct one-sentence proof by Tarski; "decidability" stands for completeness; the last step to number fields, one line, is not written)** | `plans/M2-S1D-bridge.md` §1.1 Q5–Q7; inventory 14 |
| C-4 | §2.3, last bullet | "The gate is partial: J17 re-runs the seven zbMATH queries first" | completed: J17 re-ran the seven (J04's control reproduced) and eight more; nothing beyond `[Madore2015]`, `[Fischer1990]`, `[Soifer2024]` ch. 11 and the unread `[BendaPerles2000]`; one adjacent paper, `[WangKosheleva1998]` | `plans/M2-S1D-bridge.md` §1.3; inventory 6 |
| C-5 | §2.4 item 5 | route C uses "`cosetResidue` + `unitQuadrance_colorable_of_ringHom` (or `normOne_subset_valuationSubring` in the complex form)" | as landed: `unitQuadrance_colorable_of_subring` (by `cosetResidue`) with J15's own valuation lemma `mem_valuationSubring_of_sq_add_sq_eq_one`; `normOne_subset_valuationSubring` is not used by route C (J16 uses it, for prime inversion) | `Proofs/HadwigerNelson/Transcendental.lean:107, 141, 177`; inventory 2 |
| C-6 | §1.1 G30's K1 (7), §1.4 item 2, §4.2 J14's gate column | "`VACUITY DECLARED`, with G₄ named" | **withheld, rightly**: the marker asserts a provably empty domain, and `G4` is unproved, not empty; the docstring says "Conditional, and not vacuous". The same holds for `RealAlgebraicDescent` (J17K) | `plans/M2-S1K-chain.md` stage 4; `plans/M2-S1D-bridge.md` §3.2; inventory 25, 26 |
| C-7 | §2.2, row "K2 (J17)" ("the bridge's kernel form is weeks"); §4.1 item 5 ("the kernel form waits for real closed field theory") | weeks; waiting | the conditional kernel form landed in under an hour: `Bridge.chromaticNumber_plane_eq_iSup_numberField_of_descent`, with `RealAlgebraicDescent` its one named hypothesis, and `IsRealClosed ℝ` from Mathlib's eventual-sign lemmas. The **unconditional** form needs `(∃T)` in the kernel — months (J17 §3.2) | `plans/M2-S4K-bridge.md` §1.3, stage 2 |
| C-8 | §3.2, K3-A's price; §4.2, J16's stop rule ("propose J16b") | "4–6 hours, 400–500 lines — more than one job" | the stripe lemma landed in full in 17 minutes of work, 447 lines with its controls; no J16b. The saving was the plan's own §4.4 item 5 (S2 as a wheel statement) and a properness-only line-to-line step | `plans/M2-S3K-unit-ring.md` §3.5, §4.3 item 5 |
| C-9 | §4.1 item 4 | "Bochnak–Coste–Roy, *Real Algebraic Geometry*, Thm 4.1.2" | BCR §4.1's title is confirmed ("The Artin-Lang Homomorphism Theorem and the Real Nullstellensatz"), the number 4.1.2 is not (book not held); the statement read is `[GoelPatilVerma2022]` Thm 3.11, after Lang 1953 | `plans/M2-S1D-bridge.md` §1.1 Q11 |
| C-10 | J17's record §3.2 (frozen) | B0 and B1 "~1 day" each | each under half an hour at this Mathlib pin: Mathlib already holds the eventual-sign lemmas and the tower integrality | `plans/M2-S4K-bridge.md` §1.3; inventory 50 |
| C-11 | J17's record, "Theorems this phase proved", kernel-decision column (frozen) | T2 "kernel candidate"; T3, T9 "kernel as a conditional theorem"; T4 "declined (value low)"; T5, T6 "declined" | T2 **kernel** (J17K, `RealClosed.lean`); T3, T9 **kernel, conditional on `RealAlgebraicDescent`** (J17K, `Bridge.lean`); T4 **kernel, stronger** (every field with `2 ≠ 0`); T5 **kernel** in its one-variable containment form; T6 **kernel** up to the tower reading of "purely transcendental" (J17K2, `NoParam.lean`) | inventory 61 |
| C-12 | J17's record §2.3, Lemma NP's proof (frozen) | "pairwise coprime (characteristic 0)"; the base `ℂ` | coprimality of `p ± q` needs characteristic ≠ 2, and no algebraically closed base is needed; NP is **false** in characteristic 2 (`a = X²` over `𝔽₂`) | `plans/M2-S5K-noparam.md` §1.2, §4.2; inventory 61 |
| C-13 | J17K's brief, `data/crunch-2026-09-25/briefs/J17K-M2-bridge-kernel.md` line 130 (frozen) | "(Dropping `CharZero k` is *not* a good plant: NP stays true in odd characteristic; only the proof's derivative step breaks.)" | in odd characteristic **no step breaks** — Mathlib's `Polynomial.flt_catalan` descends in characteristic `p`; the boundary is characteristic 2, where NP is false | `plans/M2-S5K-noparam.md` §1.1; inventory 62 |

**Would have searched here (stage 1):** none — one zbMATH lookup of a known paper (row 63) is a citation check, not a finite-witness search.

### Stage 2 — SAVED (the kernel register)

`plans/M2-derivation.md`, in two parts. **Part I, the kernel register**: M2's ten Lean files, 226 declarations, every one on axioms within the
standard three (195 on all three, 21 on `[propext]`, 7 on `[propext, Quot.sound]`, 3 on none; stage 0's run), of which the register lists
the ones a result rests on — 125 by name, plus the `junction_*` and `chainDrawing_*` families (*corrected at stage 3: the
stage-2 text said "about 110", unmeasured*), each with file, line, axioms, whether the gate's audit prints it, its statement in plain words and the
hand result it promotes — in seven product tables (the chain theorem; its two instances; route C; prime inversion and the `K(√7)` wall; the
stripe lemma; the conditional bridge and the real-closed instances; Lemma NP and C3), then **what the kernel does not prove** per product
(§ I.8) and **the nine hand results it promotes** (§ I.9: `ASTRA-2026-09-14-T1, T2, T5, T6, T7, T9`, `FS39-T1`, `FS62-T2`, `FS85-V2-T5`, and
six of J17's). **Part II, the derivation file**: the twelve theorems M2 proved outside the kernel — `J04-H1` (route C's integrality, since
kernel), `J14-H1` (one redundant diamond), `J17-T1` to `T10` — one entry each in `tools/fs71_ledger_b_check.py`'s form; `--strict` reports
all twelve with every field and only the expected "no `LEDGER.md` § B row" (their § B lines are stage 4's drafts). Verification status per
entry: J17's ten are one mind each (J17V declined), six of them since kernel-checked by J17K or J17K2 (T2, T3, T9 conditional or stronger;
T4, T5, T6 by another route), and T4's hand proof read as sound by J17K2.

**Would have searched here (stage 2):** none.

### Stage 3 — SAVED (the re-reads, the predictions, prices against actuals, the verdict, the tallies)

#### 3a. §G re-read — which extractions paid, and which entry should have borne

| §G line (stage 1) | what happened | paid? |
|---|---|---|
| G30 (5)–(6), § The gate "proved twice" (K1): the 18-vertex instance by the chain theorem **and** by `decide` | J14 landed both oracles (the chain route for the plane; the gadget algebra, 4.13 s, for the list) | **paid** |
| G30 (7) and §1.4 item 2 (K1): `VACUITY DECLARED` on the `G4` theorem | wrong: the marker asserts a provably empty domain; J14 withheld it, the owner ruled J14 right (correction C-6) | **misapplied** — the rule that should have borne is § The gate's own definition of `DECLARED` |
| G38, row 63 (K2): `χ(ℚ(π)²) = 2` is not free | J15 inhabited by the equality `χ(ℚ(L)²) = χ(ℚ²)`, as foreseen; no time lost | **paid** |
| G46 (K2): route C is valuation theory; (K3) prime inversion is lying-over | route C built as a hand-made place at `t = 0`; prime inversion by Chevalley's domination, found by the §PA grep (§2.2) | **paid** — the §PA find reshaped K3 |
| G21 (K2, K3): inhabitants whose value is known; inhabit both directions of FS-47 | NT₀ inhabited by the class mod 2 (G16, G70); prime inversion's spec at `1/5` over `ℂ` and `1/2` over `K(√7)`; the "only if" direction (`ℚ` at 3) was **not** inhabited | half paid |
| G18 (K1, K3): certify the component, compose in the kernel | the chain theorem takes `Forces` on one copy; the stripe lemma is a `4⁷` wheel table composed with two inductions | **paid** |
| G35 (K1, K3): `3/8` as data; the valuation form sidesteps the gate | J14 took the eight multipliers as data; J16 proved the wall in valuation form and left the gate named | **paid** |
| G70, G75 (K3): NT₀ combinatorial; the residue colouring inhabits it | as planned (`NT0` by alternate triples; `modTwo`) | **paid** |
| G71, G73 (K3): a height route to "striped" | not used — the wheel-and-line route V2 wrote was cheaper | silent in effect |
| G49, G50 (all): the Mathlib and zbMATH §PA | found `Ideal.image_subset_nonunits_valuationSubring` (K3's shape); **missed** `RatFunc.algEquivOfTranscendental` (wrong directory, C-2) and `Polynomial.flt_catalan` (J17K2 found it at the skeleton) | paid, with two misses |
| G51 (K2): a blind check of J17 | J17V declined; the kernel served as the second mind for six of J17's ten theorems (J17K, J17K2) | paid differently |
| § What compute helps, "re-price from the first two leaves" (all) | every job did, and every re-priced remainder still came in far under (3e) | **paid, and confirmed seven of seven** |
| § Kernel cost model: nested `List.all` under `decide +kernel` | the wheel table (`maxRecDepth` with a flat `List.range`, met again at J04) | **paid** |

**The entry that should have borne and was marked silent: G56.** §G.1 reads "G56 — silent ×3: the window for six; odd-degree bipartiteness
is not ported here", but G56 also says "FS-39's bridge, which is `[Madore2015]` ¶5.4 plus de Bruijn–Erdős". So §2.3 announced as a finding
what G56 and `BIBLIOGRAPHY.md` already held (C-3), and J17's stage 1 spent a quotation check undoing it. **The instance for WORKFLOW 3.1:**
an entry whose bearing sits in a subordinate clause, not in its title, gets the verdict its title earns. The *Do* line of G56 does not mention
the bridge, which is G67's point: the bearing lived in the body, not in the form that is scanned. The drafts (stage 4) move the bridge's credit
into G63, whose subject it is.

#### 3b. §PA sweep — what M2 learned about what its objects are

1. **Theorem A's residue colouring and route C are one lemma.** `RouteC.unitQuadrance_colorable_of_valuationSubring` colours `K²` from any
   place of `K` whose residue ring has no `√−1`; Theorem A's finite places (`q ≡ 3 (mod 4)`) and route C's place `t = 0` are two instances,
   and J17's C3′ (a degree-one point of an elliptic curve) a third. It is `[Madore2015]` Prop. 3.2 at `d = 2` (found at this close,
   inventory 67). → G63 draft.
2. **Row 57's gap is one missing lemma under three results.** "The `σ`-stable valuation subrings of a number field with `p` in the maximal
   ideal are its conjugation-stable primes above `p`" is what Theorem A's field-level form (G35's and G43's gate), prime inversion's
   number-field reading (FS-47), and `ASTRA-2026-09-14-T7` in general each still need. → G35 draft; FS-47 and FS-37 re-aims.
3. **"Positive genus" in Fischer's Remark 1 is the Fermat–Catalan signature inequality.** NP is `Polynomial.flt_catalan` at `(4, 4, 2)`,
   `1/4 + 1/4 + 1/2 = 1` (genus 1, the boundary the lemma admits); the genus-0 twin reads `(2, 2, 1)`, `1/2 + 1/2 + 1 > 1`, and the kernel
   route fails there and only there (J17K2 §2.2). → G63 draft (one clause).
4. **The bridge's kernel content is one proposition.** Everything in FS-39 but `RealAlgebraicDescent` — the equational existential
   fragment of Tarski for `ℝ_alg ⊆ ℝ` — is in the kernel; Artin–Lang is not a cheaper foundation (J17-T10). → G63 draft (replaces "price both
   before committing").
5. **Triangles enter the stripe lemma once.** NT₀ is used only to make one line two-periodic; every further step is properness alone (J16 §3.2,
   both simplifications kernel-checked). → G75 draft (one sentence): on the triangular lattice the forbidden-triangle hypothesis enters
   four-colour striping at a single line.

#### 3c. §IQ re-read and G72's count

§IQ ran for M2's one derivation (J17, the bridge). Its structural form — every finitely generated `ℚ`-subalgebra of `ℝ` has a ring hom into
`ℝ_alg` — is answered by the Artin–Lang homomorphism theorem, and the invariant it named (an ordering, a real place) is the one J17's route AL
uses. **So the result came through the structural question**, and the answer was a classical theorem: novelty none, as §G.4 item 8 predicted.
The kernel lane's other products are ports, outside G72's count. **For G72:** M2's count — "through the structural question, a classical
answer; the kernel ports are not counted" — the count's ordinal is the front-page job's to assign beside M1's.

#### 3d. The predictions, scored once

| id | prediction | p | outcome | source |
|---|---|---|---|---|
| P-J14a | J14 lands all three K1 products, gate green, inside 3 h | 0.65 | **met** (≤ 26 min) | `plans/M2-S1K-chain.md` stage 5 |
| P-J14b | the gadget oracle's `decide +kernel` under 60 s | 0.60 | **met** (the whole module, 4.13 s) | same |
| P-J14c | the six-unit identity by factoring in ≤ 40 lines | 0.75 | **met** (14 lines) | same |
| P-J15a | the integrality leaf closes with no hypothesis left | 0.55 | **TRUE** (about 15 min of stage 2) | `plans/M2-S2K-route-c.md` §4.2 |
| P-J15b | Mathlib identifies the `X`-adic residue field of `RatFunc K` with `K` | 0.30 | **FALSE** | same §1.2 |
| P-J16a | prime inversion, valuation form, inside 1.5 h | 0.85 | **met** (13 min) | `plans/M2-S3K-unit-ring.md` §2.5 |
| P-J16b | the stripe lemma in full inside J16 | 0.10 | **met** (17 min) | same §3.5 |
| P-J17a | no printed proof of the bridge besides Madore ¶5.4 (and Fischer's Remark 1) | 0.70 | **held, conditional**: unscorable at `[BendaPerles2000]`, unread | `plans/M2-S1D-bridge.md` §3.3 |
| P-J17b | the Artin–Lang route's kernel price judged lower than Tarski's | 0.50 | **FALSE** (AL's proof contains `(∃T)`) | same |
| P-lane | no lane job touches a module a certificate imports | 0.90 | **TRUE** for all six kernel jobs (each build rebuilt only its new modules and `Proofs`) | each record's gate |
| J14 C0 | six products (0.97, 0.75, 0.80, 0.90, 0.80, 0.70) | — | all met | `plans/M2-S1K-chain.md` §1.1 |
| J16 C0 | P-J16a/b at 0.90 / 0.10 | — | both met | `plans/M2-S3K-unit-ring.md` §1.2 |
| J17 C0 | C1 0.97, C2 0.95, C3 0.97, C4 0.90 | — | all TRUE | `plans/M2-S1D-bridge.md` §3.3 |
| P-J17Ka | B1 and C4 green, conditional, inside 2 h | 0.60 | **HELD** (about 8 min) | `plans/M2-S4K-bridge.md` §5.2 |
| P-J17Kb | both B0 instances land | 0.60 | **HELD**, stronger | same |
| P-J17Kc | NP via `Polynomial.abc` in ≤ 200 lines | 0.50 | **HELD** in J17K2 (99 lines, via `flt_catalan`) | `plans/M2-S5K-noparam.md` §2.3 |
| J17K C0 | the build accepts both modules unchanged or lint-only (0.85); NP in J17K's budget (0.35); C3 (0.25); C3⁺ (0.05) | — | HELD; the other three **did not land in J17K** (budget stop) — all three landed in J17K2 | `plans/M2-S4K-bridge.md` §1.2, stage 4 (scored here; the record left them) |
| J17K2 C0 | NP in full (0.80); ≤ 200 lines (0.70); twin in the kernel (0.90); the twin fails only at the signature (0.65); C3 (0.75); C3⁺ (0.15) | — | all **HELD** | `plans/M2-S5K-noparam.md` §2.3, §3.3 |

**Reading.** Of the plan's ten, seven came true, two were false, one is unscorable. Every "lands inside its budget" prediction came true,
including those at 0.10 (the stripe lemma) and 0.15 (C3⁺): the priors were pessimistic about kernel effort in one direction only, which is
3e's finding. Both FALSE ones were about the world (what Mathlib holds; how Artin–Lang is proved), not about effort. Two C0 tables (J17K,
J17K2) reached disk after their first leaves had closed; they are scored only on the products not yet attempted when written.

#### 3e. Prices against actuals (every M2 leaf was priced high in time; not in tokens)

Times are wall clock from the job's start (the previous lane job's report, or the recorded start) to its report, read from commit times
(`git log`; desktop); a "day" is read as one working day.

| product | priced (where) | actual | ratio |
|---|---|---|---|
| K1, the chain theorem and both instances (J14) | "one job, about 3 hours; 300–350 lines" (§3.2) | ≤ 26 min (15:56 → 16:22); ≈ 570 lines with specs and controls | ≥ 7× in time; lines under-priced |
| K2, route C (J15) | "2.5–3 hours, medium risk at one named leaf" (§3.2) | ≤ 30 min (16:22 → 16:52); the named leaf about 15 min | ≥ 5× |
| K3-B, prime inversion (J16) | "about one hour" (§3.2) | 13 min (16:55 → 17:08) | ≈ 5× |
| K3-A, the stripe lemma (J16) | "4–6 hours, 400–500 lines — more than one job" (§3.2) | 17 min (17:10–17:27, the record's times), 447 lines | ≈ 14–21× |
| B0 and B1, the real-closed instances and the conditional bridge (J17K) | "~1 day" each (`plans/M2-S1D-bridge.md` §3.2) | both in ≈ 16 min (17:30 → 17:46) | ≥ 30× |
| Lemma NP (J17K2) | "optional ~½ day" (J17 §3.3); "≤ 200 lines" at p 0.50 (P-J17Kc) | NP, C3 and C3⁺ together ≤ 34 min (17:48 → 18:22); NP 99 lines | ≥ 7× |
| J17, the bridge by hand | "~1.5 h, 200k" (§4.2) | ≤ 23 min (15:56 → 16:19), but **366k tokens** | fast in time, **1.8× over in tokens** |
| token budgets of the kernel jobs | J14 350k, J15 300k, J16 350k, J17K2 300k (§4.2; the queue) | 339k, 368k, 405k, ≈ 200k (estimate); J17K 342k | about right; J15 and J16 over |

**Why every time price was high** (the records' own reasons): Mathlib at this pin already held the non-obvious input — the eventual-sign lemmas
(`IsRealClosed ℝ`), `algebraicClosure_eq_bot`'s tower integrality, `Polynomial.flt_catalan`, `RatFunc.algEquivOfTranscendental`,
Chevalley's domination — and the plan's own obligation pass had already shaped the proofs (S2 as a wheel statement; factoring the six-unit
sum). **`CLAUDE.md` § What compute actually helps already says "a kernel leaf priced after a fine obligation pass is priced high"**; M2 is
seven more instances. The lesson for pricing: **grep Mathlib by the statement's shape at the skeleton** — it found two of the five inputs at
§PA and would have found the other three; the prices, not the leaves, were the error.

#### 3f. The conjecture sweep (WORKFLOW 9: "conjecture", "not claimed", "surfaced" in the plan and the six records)

| item | source | decision |
|---|---|---|
| **Q-const**: for finitely generated `E ⊂ ℝ` with constant field `F`, is `χ(E²) = χ(F²)`? (True when `E/F` has a degree-one place with formally real residue field) | `plans/M2-S1D-bridge.md` §2.5 | **recorded as an open question in G63 (draft); no stub** — as J17 recommended: bearing on χ ≥ 6 none (by the bridge, `χ(ℝ²)` is read off number fields alone) |
| does `χ(F(t)²) = χ(F²)` fail when `−1` is a square in `F`? | `plans/M2-S2K-route-c.md` §4.4 | **declined** — every field this project colours is real |
| an `𝔽₃` instance of route C's engine | same | **declined** — a Mathlib instance question (`RatFunc (ZMod 3)` timed out), no consumer |
| G55's vertex bound `m(n − 1) + 1` in the kernel | `plans/M2-S1K-chain.md` stage 5 | **a line in FS-45's re-aim** (a small leaf), no stub |
| `ASTRA-2026-09-14-T7` in general (every wall-broken real `F ⊇ K` has `χ ≥ 5`, given `G4`) | § I.9 of the register | **a line in FS-47's re-aim**: it needs row 57's number-field reading |
| the involution hypothesis in `normOne_subset_iff_stable`: false without it? (no counter-model built) | `plans/M2-S3K-unit-ring.md` §2.3 | **declined** — the plant showed both directions consume it; a counter-model has no consumer |
| upstreaming `RealClosed.lean` to Mathlib (its TODO) | `plans/M2-S4K-bridge.md` stage 3 | **held for publication** — Mathlib contributions are deferred (Kooshi, 2026-08-04; `CLAUDE.md` § Publication) |

#### 3g. The verdict, in four parts

- **The choice: M2 closes Paid (kernel).** Every target landed — FS-45's D1–D3 (the chain theorem in four forms and the ring form;
  `χ(ℚ(√2,√3)²) ≥ 4`; `G4 → χ(K(√7)²) ≥ 5`), FS-39 route C (`χ(F(t)²) = χ(F²)`), FS-47's prime inversion in valuation form with the `K(√7)`
  wall, and FS-87's target 1 in full (the plan offered one of the last two) — and two jobs spawned mid-milestone put the bridge in the kernel
  conditional on one named true hypothesis, with `ℝ` and `ℝ_alg` real closed, Lemma NP over every field with `2 ≠ 0`, and C3 and C3⁺.
  226 declarations, all on the standard three axioms or fewer, no solver, no native evaluation; the gate green (stage 0).
- **The alternative weighed: Paid (partial).** Three things M2 names are not in the kernel: `G4` (a measurement, post-ban), `RealAlgebraicDescent`
  (Tarski, months), and prime inversion's number-field reading (row 57's gap). *Why Paid won:* each was named as conditional or out of scope in
  the plan before any job ran (§1.4 item 2, §4.1 item 5, §2.2's closing paragraph), so none is a target that failed; and the milestone was grade
  debt, which it paid.
- **What it is, in novelty:** none of the mathematics is new — the chain theorem is GPT Astra's (G55), route C `[Fischer1990]` Thm 6, its
  general lemma `[Madore2015]` Prop. 3.2, prime inversion Astra's (and `[Fischer1990b]` for special cases), the stripe lemma `[Parts2020hv]` §3,
  the bridge `[Madore2015]` ¶5.4, NP classical. Ours: the kernel forms; the ring form of the chain theorem; prime inversion in valuation form
  (no number field needed, Chevalley's domination); the relative-algebraic-closure instance (a Mathlib TODO, stronger than asked); NP over every
  field with `2 ≠ 0` with its two sharp controls; C3⁺ by tower induction. **All novel knowledge is a success** (Kooshi): the kernel's word on
  results the project had held by hand is the product.
- **Confidence: high.** The gate is green and every result is on the standard three; what would change it is a defect found in a statement
  read aloud — the owner read three (inventory 27, 38, 55) and each job read its headlines against the informal claims.

#### 3h. The prior-art position of each headline result (from the records; no separate close-time gate ran for M2)

| result | position |
|---|---|
| the chain theorem (four forms, ring form) | GPT Astra's Theorem 4.1 (hand, 2026-09-14; G55); **the kernel form is ours**; the spindle as `m = 2` classical |
| `χ(ℚ(√2,√3)²) ≥ 4`; the 18-vertex graph | Astra's T6 (tools grade until now); **kernel ours**; Moser-free four-chromatic plane graphs are known in general (G11) |
| route C, `χ(F(t)²) = χ(F²)` | **`[Fischer1990]` Thm 6** (statement and proof); its lemma **`[Madore2015]` Prop. 3.2 at `d = 2`** (found at this close, inventory 67 — J15's report had called the lemma ours); kernel ours |
| prime inversion, valuation form; the `K(√7)` wall | Astra's Theorem 1.2 (hand); `[Fischer1990b]` Thms 1, 3–4 for multiquadratic fields at odd unramified primes and real quadratic fields; the lifting is Chevalley's (Stacks 00IA, Mathlib). **The valuation form without number fields, and the kernel, ours** |
| the stripe lemma | **`[Parts2020hv]` §3** (human-verified); FS85-V2-T5 our re-derivation; kernel ours |
| the bridge, C1–C4 | **`[Madore2015]` ¶5.4 with ¶1.3** (Tarski); noted by `[BendaPerles2000]` (unread, the one open debt); asserted in `[Soifer2024]` ch. 11; with a false step in `[Fischer1990]` Remark 1. C4 is FS62-T2 (ours, a restatement). Kernel (conditional) ours |
| `ℝ` and `ℝ_alg` real closed | classical; **Mathlib's own TODO**; the relative-closure instance in this generality not found in Mathlib (not searched beyond it) |
| Lemma NP, C3, C3⁺ | classical (genus 1; Mason–Stothers, Snyder 2000); the refutation of Remark 1's first sentence is ours as a write-up only; kernel ours |

#### 3i. The honesty tally (every owner error and agent slip in the inventory, and this close's own)

| who | slip | inventory | caught by |
|---|---|---|---|
| the owner (J04's brief) | two advisor quotations not verbatim on disk | 7 | J04's quotation check |
| the owner (J04's brief) and `CLAUDE.md` G63 | route C's tool named as `colorable_unitDistance_induce_of_valuationSubring`, which needs a finite residue ring | 2, 32 | J04 at §PA |
| the owner | J17K's request for "one DECLARED hypothesis" | 26 | J17, then J17K (implemented as a named hypothesis, no marker) |
| J04 (planner) | `VACUITY DECLARED` planned for the `G4` theorem | 25; C-6 | J14 |
| J04 | the Mathlib query for `F(t) ≃ RatFunc F` looked in the wrong directory | 32; C-2 | J15 |
| J04 | Madore ¶5.4 announced as a finding (a re-finding; G56 marked silent) | 14; C-3 | J17 |
| J04 | harness 534k, above the 500k replace line (its briefs' quotations were checked by each receiving job) | 11 | the owner |
| J14 | one timing run and one plant as bare `lake env lean` at 3.7 GB, outside the slot | 24 | J14 itself |
| J16 | a duplicate `conjOn` under ResidueColouring's name | 47 | the name clash |
| J17 | `VACUITY DECLARED` in B1's first wording | — (J17 §3.2, corrected in its own record) | J17 |
| J17K | C0 written after the first leaves had closed | 52 | J17K itself |
| J17K2 | the same, repeated | 62 | J17K2 itself |
| J17K (its brief for J17K2) | "only the proof's derivative step breaks" in odd characteristic | 62; C-13 | J17K2 |
| J15 (report) | the general valuation lemma called "ours"; it is Madore's Prop. 3.2 at `d = 2` | 67 | this close |
| J23b (this close) | stage 0's text claimed a "first `lake lint` at a close since it was wired" — unverified; removed at stage 1. Stage 1's inventory tally counted by eye (20 / 19 / 19 / 19; the file says 21 / 16 / 18 / 17), corrected at stage 2; stage 2's "about 110" declarations (125), corrected at stage 3 | — | this close, on re-reading |

**Pattern.** The owner's and the planner's errors were each caught by the next job's quotation check or first leaf, before any cost; the
agents' slips are process slips (C0 timing, the slot), none in a statement. G21's selection rule: this close audited the flattering claims
too — J15's "ours" was the one that fell.

#### 3j. Staffing (harness counts from the task notifications)

J04 534k (own 330k) — above the replace line, not reused · J14 339k · J15 368k · J16 405k · J17 366k, then 414k after writing J17K's brief ·
J17K 342k · J17K2 ≈ 200k (its own estimate). No child agents were reported by any job. J17V was never run (declined).

#### 3k. The would-have-searched log, across M2

| job | move a search would have made | instead |
|---|---|---|
| J04 X2 | an LRAT refutation of the 18-vertex graph | the gadget algebra by `decide +kernel` over the chain's seven ports — **at the ban's edge** (a complete enumeration of port partitions the gadget algebra fixes) |
| J04 X3 | a fresh LRAT of the 588-core, to make the `K(√7)` theorem unconditional | the conditional theorem; the LRAT is post-ban |
| J04 X4, J16 X3 | — | the wheel check: all `4⁷` colourings of one wheel, a set the derivation fixed — **at the ban's edge**, logged as such (with J16's decisions over `Fin 4`, `(ℤ/2)²`, `ℤ/3` and the 16 maps `Fin 4 → ℤ/2`) |
| J14 X2 | a three-colouring of the planted 32-edge list by a colourer | derived by hand from the reference four-colouring |
| J17 stage 2 | a solver check that a drawing has an algebraic form; hunting a Q-const counterexample by trying curves | neither needed (C1 is a theorem); Q-const recorded as a question |
| J15, J17K, J17K2, J23b | none | — |
