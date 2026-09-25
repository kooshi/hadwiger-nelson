# FS-91 (crunch milestone M1) — the character local–global theorem, and band rigidity to nine colours

*The plan of milestone M1 of the 2026-09-25 crunch, opened on the stub `plans/STUB-band-rigidity-six.md` (FS-91). Written by crunch job
J03 (de Bruijn, Opus 5.5, the milestone's planner) under the brief `data/crunch-2026-09-25/briefs/J03-M1-reframe.md` and
`data/crunch-2026-09-25/briefs/STANDING-RULES.md`. WORKFLOW 2.0 steps 3–6 in one job: §G (3.1), §PA (3.2), §IQ (3.3), §S (4), §P, §M (6),
§X (the would-have-searched log). The close inventory is `plans/FS91-close-inventory.md` (the clerk opens it).*

**Fences.** This file carries routes. It is fenced from J09 (blind, stage 0) and from every verifier (J10, J11, J13) until that
verifier's verdicts are committed. §P.basis is also fenced from J08, so that J08's level-one derivation is independent of the planner's
hand check.

## Stage 1 — SAVED (the quotation check, §G.1)

### Q. The quotation check (standing rule 5): every quotation in the J03 brief against its source

| # | the brief's quotation | source | result |
|---|---|---|---|
| Q1 | "A character `k`-colouring of `F²` forces a `k`-colourable residue target" | `plans/POROS-2026-09-25-crunch-plan.md` line 39 | **verbatim** |
| Q2 | "at k = 4, 5 now, and to k ≤ 9 if PA-B3 survives its blind verifier" | same, line 39: "for `k = 4, 5` now and to `k ≤ 9` if PA-B3 holds." | **not verbatim**: "if PA-B3 holds" became "if PA-B3 survives its blind verifier". The meaning is kept and made stricter; logged as a brief slip |
| Q3 | "The product step is the Tardif reading's PA-T4, or a direct sumset argument; the archimedean circle is the new factor." | same, lines 41–42: "Its product step is the Tardif reading's PA-T4 (a four-colourable product of residue targets has a four-colourable factor), or a direct sumset argument. The archimedean circle is the new factor." | **not verbatim**: the parenthesis restating PA-T4 was dropped and two sentences joined; meaning kept |
| Q4 | "It turns rows 96–97's per-field corollaries into one class theorem." | same, line 43 | **verbatim**; the source continues "It sharpens G64: six (and any falsifier) can hide only in a non-character colouring." — carried into §IQ and J07's brief |
| Q5 | "Brief them as complete enumerations with the derivation that fixes the set, never as 'try orders until one works'." | same, line 130: "D-six's character enumeration at 23, 43 and D-one-prime's torsion lists: in by §1.7, briefed as complete enumerations fixed by a derivation, and logged." | **not verbatim, and partly not in the source**: "never as 'try orders until one works'" is not in the advisor's record; the nearest text is `STANDING-RULES.md` rule 3 ("\"Try cases until one works\" is out"). Substance agrees with both sources; logged as a brief slip (a paraphrase inside quotation marks — FS-86's hazard) |
| Q6 | the stub's question 2 figure "`α(Γ₂₃) ≤ 97` gives ratio 0.183 > 1/6" | `plans/STUB-band-rigidity-six.md` question 2; `LEDGER.md` row 75 | **agrees**: 97/529 = 0.1834 |
| Q7 | question 3's "U3 (`RS₄({p})` false at every single prime `p ≡ 1 (mod 4)`, proved at 5 only)" | the stub, question 3; `plans/FS89-derivation.md` §10 | **agrees** (unquoted in the brief) |

**Freshness of the house rules.** `CLAUDE.md` on disk is commit `1263d964` (the 300,000-byte budget line), the same text as the copy loaded
at this job's start (its budget sentence ends "with the file at 274,995"), and the tree was clean at start; `LEDGER.md`'s last commit is
`d9f2e9a8`. `LEDGER.md` § A (rows 1–97) was read in full from disk. **§ B was read by its structure and the entries that bear (FS54-T2,
FS73-T22, T40, FS81-T1–T7, FS86-B1-LR, LP, V3, V3ram, dB-Theta, dB-Sv, dB-HDint, dB-HDcert, Cx-C14, CL1), and FS-89's block through its
derivation file, read in full**; the rest of § B (M18–FS-73's lines) was not read line by line — a budget decision recorded for the owner,
since § B indexes theorems whose mechanisms the rows already carry.

### The milestone in the theory's terms (the recognition, one paragraph; §IQ states it formally)

A **character colouring** of a real field's plane is `x ↦ ⌊kθ(x)⌋` for a band character `θ ∈ Θ_k(R_F)`. Row 95 (with the gluing) says
that at `k = 4, 5` every such `θ` is `τ + ψ`, a torsion character plus an archimedean one; a torsion character of the Dedekind ring
`R_F` (G55's prime inversion: `R_F` is the ring of elements integral at every conjugation-stable prime) factors through the finitely many
stable local rings above its order, so `θ` is **a sum of local characters, one per stable place, plus one real-linear term per real
embedding**, and the band condition becomes a statement about a **sum of value sets** on the circle, once the unit vectors are known to
be jointly dense in the local norm-one groups and the archimedean circles (weak approximation on the norm-one torus). Question 1 asks
whether such a sum inside the band forces **one** summand inside the band — then that place's target is `k`-colourable by a character,
and the conjecture holds for character colourings wherever band rigidity holds. Question 2 is that theorem's instance at six colours: a
character six-colouring of ℚ(√167)'s plane exists iff one of its level-one targets (23, 43, 59, …, the ramified 167) carries a band
six-character, a finite question per target about which traces of the circle avoid a short interval. Question 3 is the one-prime side of
the same dynamics (rank one, where row 97 already fails). Questions 4 and 5 run in stage 0 and are consumed only as named hypotheses.

### G.1 The grokkings (every entry G1–G76, fresh from disk; verdict lines per the brief's form)

*Job names: J07 (question 1, the character local–global theorem), J08 (question 2, six at the exposed fields), J12 (question 3, one
prime), J10/J11/J13 their blind verifiers; S0 = the stage-0 jobs J01 (PA-B2/B3), J02 and J09 (FS-82's `k = 3` case).*

- G1 — bears: a wall-standing field has a dyadic target of χ ≤ 4, so the character theorem at `k ≥ 4` is automatic there; content lies in wall-broken fields → J07
- G2 — silent: construction rings; no characters
- G3 — silent: radii of held witnesses
- G4 — silent: shell inventory of five-forcers
- G5 — silent: 1-sum structure of the 1581
- G6 — silent: hexagram containment
- G7 — bears: the type-M relation `1 = 2n − nv − nv̄` supplies `1/3` in FS-82's field and names ℚ(√167)'s `Σ = 42` rotation → S0 (J02/J09)
- G8 — silent: edge-direction words
- G9 — silent: compulsions of held forcers
- G10 — silent: criticality sweeps
- G11 — silent: Moser-free five-forcers
- G12 — silent: coupling conics of detuned copies
- G13 — silent: fans; a gapped character colouring's consequences are row 66's, not asked
- G14 — silent: matching cross edges
- G15 — silent: pigeonhole × kill
- G16 — silent: distance-2 pigeonhole
- G17 — silent: sub-rung carriers
- G18 — silent: no solver composition
- G19 — silent: class sweeps
- G20 — silent: brick colourings
- G21 — bears: J08's level-one list measures its reduction — state the generator's image (every additive character, `q − 1` rotation classes) and run a known positive (23's eight-colour ceiling) → J08
- G22 — silent: about colourings of ℝ², not finite targets
- G23 — silent: cell-family scale
- G24 — silent: integrality gap of cell cores
- G25 — silent: forcer recursion
- G26 — silent: six-gadget targets
- G27 — silent: Galois automorphisms of witnesses
- G28 — silent: fine-tail virtual edges
- G29 — silent: cell family closed
- G30 — bears: derivation-only milestone; failure mode 5 (every structure hypothesis ships an inhabitant) and the discipline ladder (additive combinatorics, then arithmetic of tori) → J07, §PA
- G31 — silent: pair compulsions of held objects
- G32 — silent: two-distance dial
- G33 — silent: descent batches
- G34 — silent: in-field descent
- G35 — bears: dyadic stable places split (no target), ramified (χ ≤ 2) or inert (`U_Q`); the theorem's dyadic case is this trichotomy → J07
- G36 — silent: residue colouring on descent stages
- G37 — silent: endgame shape
- G38 — bears: a torsion band character is an additive colouring into `ℤ/N`; `[Fischer1990]` Ex. 4 (no additive `k < 11` over ℚ(√167)) is a free consistency control → J08
- G39 — silent: critical-set confinement
- G40 — silent: absorption
- G41 — bears: `[Fischer1994]`'s ℤ/4 colouring of K² is a band four-character, local at one dyadic place at level 3 — the dyadic positive control → J07
- G42 — silent: additive rigidity gauge
- G43 — bears: the targets are G43's usable planes plus dyadic `U_Q`; "a composite beats its best prime only through an integrality gap" — the character theorem says characters have no such gap → J07
- G44 — bears: Kloosterman/Weil control of Γ_q's characters; the level-one six-colour question is a quadratic-character sum over a short interval, Weil-bounded for large `q` → J08
- G45 — silent: lifting residue configurations
- G46 — bears: name the objects in their disciplines — sumsets on the circle; weak approximation on norm-one tori; character sums over intervals; circular colourings of Cayley graphs → §PA, J07, J08
- G47 — silent: level-one compulsion law
- G48 — bears: the character theorem is the conjecture for character colourings (every character colouring local at one prime after peeling); registered P-CLG → J07
- G49 — bears: gate in the discipline's words at the opening and at each job's close; zbMATH author listings (Johnson, Fischer, Berend) → §PA
- G50 — bears: `[Zhu2011]` (PA-T4's input) unread; the sumset route avoids it; `[Johnson2000]`, `[Johnson2006]` unobtained → §PA
- G51 — bears: the seventh run's shape — one derivation agent plus a blind verifier on a fixed list, lemma-statement fallback → §S
- G52 — silent: σ-criterion for rotations
- G53 — silent: counting compulsion on arenas
- G54 — bears: the Hoffman ratio gives a free screen — a band `k`-character is a `k`-colouring, so a certified `α < q²/k` refuses it at once (59, 67, 79, 83 at six) → J08
- G55 — bears: prime inversion makes `R_F` the ring integral at every stable prime (Lemma R); a torsion character factors through the stable local rings → J07
- G56 — bears: the window {23, 27, 31, 43, 47}; a band six-character of Γ₂₃ or Γ₄₃ would six-colour a window member whose floor is six — the first exactly six-chromatic finite plane → J08; falsifiable: registered as P-W6
- G57 — silent: clique rule; character sums do not use triangles
- G58 — bears: every band-character colouring is antipodal (`θ(−z) = −θ(z)`, colour involution `j ↦ k−1−j`); J08's positive controls are G58 instances → J08
- G59 — bears: the fractional wall bounds character colourings too (`α ≥ q²/k` for any band `k`-character); the six-colour thresholds per member → J08
- G60 — silent: fractional lower bounds; characters are upper-bound objects
- G61 — bears: three colours break at `1/3 ∈ ℤ[U_F]`; FS-82's residual case is S0's → S0 (J02/J09), consumed as a named hypothesis
- G62 — silent: bilayer grammar; layers enter through G74
- G63 — bears: transcendence is free (`[Fischer1990]` Thm 6), so the theorem is stated for number fields and names the finitely-generated extension as FS-39's gap → J07
- G64 — bears: the theorem sharpens G64 ("six can hide only in a non-character colouring"); J08 decides character six-colourings at ℚ(√167) → J07, J08
- G65 — silent: SAT phase diagram
- G66 — bears: level collapse is the band form of the fibre-share tax; `L` with all levels allowed; FS-68 open, so the theorem's target is stated at "some level" → J07
- G67 — bears: any grokking minted at the close carries its trigger, Do and killing test → close
- G68 — silent: quotient screens for lattice compulsions
- G69 — silent: lattice four-colour rigidity
- G70 — silent: √3-clean colourings
- G71 — bears: from four colours up emptiness of `Θ_k` is one-sided — every M1 statement is about characters only; at three colours every colouring is one → J07, J08 (scope lines)
- G72 — bears: §IQ's structural form, the invariant named (the local value sets) → §IQ
- G73 — silent: cell-local certificate no-gos
- G74 — bears: the layer method and its `5^{−k}` gluing; its reading tested again at bands 1/6–1/9 by J01 → S0; falsifiable: registered as P-G74
- G75 — silent: triangles in four-colour rigidity
- G76 — bears: the frame — closed-set rigidity with the real place rotated; count primes first; one prime is not enough → J07, J12
