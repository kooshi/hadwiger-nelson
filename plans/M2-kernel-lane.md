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
