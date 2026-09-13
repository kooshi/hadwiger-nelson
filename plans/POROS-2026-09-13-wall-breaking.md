# Poros, 2026-09-13 — the wall-breaking ceremony on the six-question

*Written by a Poros pass with the whole record in context (the review of Opus 5's branch the same morning; four
readers on the frontier set, the literature, the six-question from below, and the case for five). Poros finds the
question; it does not answer the problem. Everything below is addressed: to the record, to a run, to a derivation,
or to Kooshi. The ruling at the end is a recommendation in four parts with its default; the domain (de Bruijn, the
kernel) decides the findings.*

## The situation survey on arrival

**The goal in the principal's words.** "Finding anything useful to get to 6 chromatic … or disproving it if we're
at that point" (Kooshi, 2026-09-13). Standing: "the derivations are an order of magnitude more important than
individual objects … I believe we can provide the algebraic proof of the Hadwiger–Nelson problem in its entirety"
(`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §1, 2026-09-06).

**The record by provenance.** Kernel: 846 declarations clean on the standard three axioms, five declared purchases,
gate green at 4833a2f. The field programme M58–M61 (`CLAUDE.md` § Frontier, rows 52–56): the finite-plane bound,
the sieve, the lift obstruction, the residue obstruction, the tightness mechanism (G48). Opus 5's week (rows 57–65):
Theorems A and B in the kernel; the mascot bound; the 2-adic law; plane freedom; FS-36; M62–M64 and M63 phases
C–H4, the last still open. Measured nulls: every five-colour pair sweep ever run (§ inventory below).

**The instruments and their nulls.** The pair-compulsion sweep (`Rigidity`, `arena_sweep.py`) — null on every
5-chromatic object; the class-avoidance sweep at five colours (M35) — null on every object; the residue filter (M60)
— silent on 6-open fields by construction; the Kempe gauge γ (M57/H4) — never zero on any unit-distance object.

**The frame on its five axes, each with its address.**

| axis | the frame's commitment | address |
|---|---|---|
| object | a finite unit-distance graph over a number field F, read through the residue map at ONE prime: the wall at 2 (Theorem B), the *level-one* finite plane UD(𝔽_p, 2) at a usable p | `CLAUDE.md` § Frontier M58 ("`finitePlane p := unitQuadrance (ZMod p)`"), G43, G44 |
| question | "does any 5-sealed field carry a pair forced EQUAL at five colours (necessarily at 11 ∣ d²)?" — the 6-level of local–global tightness reduced to one question | `plans/M61-local-global-tightness.md` §S5 line ~401; G48 |
| discipline | algebraic number theory and finite-field geometry: residue maps, Cayley graphs of 𝔽_p², Kloosterman sums, first-order rigidity | G46, G44, G45 |
| audience | the project's own record (Frontier, grokkings); the stranger only through FS-20, unwritten | `plans/STUB-theorem-B-writeup.md` |
| product | "a 6-chromatic unit-distance graph as the first instance of a mechanism, and the paper is the mechanism" | `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §1; `CLAUDE.md` § The mission |

## Evidence inventory

Each item read against an expectation written before the reading; the address is where the reading happened.

- `plans/M63-phaseH4-sweep.md` §0 and §3.2, the ρ₆₃ arena's five-colour pair sweep — read against: a 5-chromatic object in a 6-open field, free of the residue bar, should show at least one compulsion if the frame's mechanism is live — surprised: yes; 0 forced pairs of 1,307,266,278 and 0 virtual edges of 1,306,721,748, the survivor set a superset of the truth by exhibited colourings, and the same null on de Grey's 1581 (`plans/M48-from-below-arity.md`, 6-open field, complete to arity 3)
- `plans/M56-arithmetic-of-tightness.md` §R lines 409–410 and 728–733, the four-colour rigidity of K-fabric — read against: the four-colour forcing that produced every 5-forcer's spindle pair should have a stated mechanism — surprised: yes; the record has F_true = 171 pairs forced at 2-adic depth 3, none at depth 2, "measured" only, no derivation of why depth 3
- `data/m53/rigidity-dial-it4.json` (`eq_confirmed: 171`, classes by 2-adic valuation; the zero rows at valuations 2 and 4 "a theorem", `plans/FIELD-WALL-SESSION-HANDOFF.md:38`) — read against: forced-equal pairs at four colours should sit at high 𝔭-adic valuation, since the residue colouring identifies exactly those — surprised: no; 163 of 178 at valuation 6, 8 of 11 at 8/√3, 0 at valuations 2 and 4
- `Proofs/HadwigerNelson/Lift.lean:19-22` and `:217`, the level-p² plane `ZMod (p ^ 2)` — read against: the level-two residue plane should appear only as the lift obstruction — surprised: no, and that is the finding: the tower UD(O/𝔭^m, 2) for m ≥ 2 has never been named as a COLOURING object anywhere in `plans/` or `Proofs/` (grep 2026-09-13: zero hits)
- `Proofs/HadwigerNelson/Instances/ResidueObstruction11.lean` and `plans/M60-five-colour-residue-obstruction.md` §R1, plane freedom at 11 — read against: the level-one plane at 11 should carry no pair compulsion — surprised: no; `finitePlane11_forces_iff : ↔ u = v` (kernel)
- The 2-adic level-one plane — read against: at 2 the residue "plane" of Theorem B is `𝔽₄` with the norm-one units as connection set, i.e. `K₄`, uniquely 4-colourable — surprised: yes, at the CONTRAST: the level-one object at 2 is pairwise RIGID (a clique) where the level-one object at 11 is pairwise FREE (M60); the two primes the frame treats alike are opposite at level one
- `data/fplane/chi-p23-k5.json`, `chi-p31-k5.json`, `chi-p43-k5.json`, `chi-p47-k5.json` — read against: the conjecture's first digit should have a verdict at the smallest undecided prime — surprised: no; all four `chi: None`, "UNDECIDED … 4 h (one cadical via pysat)", and the literature reader confirms nobody has computed them (`BIBLIOGRAPHY.md:41,46`; Moorhouse's table stops at 17)
- `plans/FRONTIER-STUBS.md` lines 38–111 and `CLAUDE.md` lines 171–191, the two rankings — read against: one order — surprised: yes; the stubs file's re-rank block says FS-6 first, its numeric column says FS-20 first, and `CLAUDE.md`'s table says FS-20 first while its prose says "the live continuation is FS-6"
- `plans/STUB-family-keeping-thickening.md` §H lines 130–135 (the FS-6 handoff I wrote on 2026-09-08) and `plans/BACKLOG-FOR-OPUS.md` B9 — read against: FS-6's "central computation" (pullback-rigidity at 11 on Heule-510 and its closure; the forced-distance table at residue norm 0) should have been built — surprised: yes; B9 was never built (`plans/FRONTIER-STUBS.md:22-24` lists the unbuilt B-items; no `pullback-*.json` under `data/`), so the one measurement FS-6 was re-aimed around has never been made
- `CLOSED-QUESTIONS.md` §1.4 and `plans/STUB-family-keeping-thickening.md` § PRIOR ART — read against: the design target should have literature — surprised: no; Polymath16 posed the forced pair at 5/3 spindled for six on 2018-05-02 and never answered; M60's residue law is the negative answer over sealed fields
- `Proofs/` and Mathlib, searched for de Bruijn–Erdős and for "every finite unit-distance graph has an algebraic drawing" — read against: the bridge from χ(F²) over number fields to χ(ℝ²) should be a cited theorem — surprised: yes; neither statement exists in `Proofs/`, neither is cited to a source, and both carry the whole T2 → χ(ℝ²) chain (`plans/M61-local-global-tightness.md:67-68`, `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4 first line)
- `BIBLIOGRAPHY.md:45`, `[BardestaniMallahiKarai2015]` — read against: the discipline that owns "the unit-distance graph over a local field" should be named in the record — surprised: no; it is there, on the Borel side ("finite Borel chromatic number iff the form is anisotropic"), and the record already reads its hinge as the wall — but its object, the plane over the COMPLETION K_𝔭, has never been used here as the object whose colourings are asked about
- `plans/M63-phaseH4-reduce-the-platform.md` §15–§16 (the gauge and G31's extension) — read against: a null over 1.3 billion pairs should come with a mechanism — surprised: yes; the explanations offered are readings ("the emptiness is not a field effect", "compulsion budget 66 of 544,530"), and G52/G53 explain the whole-object refutation, not pairwise floppiness
- `plans/STUB-first-digit-23.md` §3 D1–D2 — read against: a priced route — surprised: no; cube-and-conquer priced at hours per cube, the α instance the one route whose refusal certifies χ ≥ 6 at 23
- `plans/M63-phaseH4-sweep.md` arity-3 remainder ("337 candidates standing", 163 of 51,133 vertices swept) — read against: a partial sweep should say it is partial — surprised: no; it does. Standing finding, unread further: the 337 candidates' list has not been examined by anyone

## The anomaly hunt's residue

Three surprises survive verification, and they push on three different axes.

1. **Object.** The frame reads a field through its residue planes at *level one*. The measured four-colour forcing that every 5-forcer was built from lives at 𝔭-adic *depth three* (M56, M53), and the level-one objects at the two primes are opposite in kind — a clique at 2, a pairwise-free plane at 11. The tower of residue planes UD(O/𝔭^m, 2), m ≥ 2, is the object the evidence keeps pointing at, and it has never been named.
2. **Question.** "Does any 5-sealed field carry a forced pair?" has been asked of critical 5-chromatic *objects*, and answered zero. The four-colour precedent was not found that way: the 791-forcer's pairs and T20's 8/3 pairs were read off *deep 4-colourable fabric* by a valuation dial, not off a critical object. The question asked and the question answered differ.
3. **Product / audience.** The chain from "χ(F²) = min(7, L(F)) for every F" to "χ(ℝ²) = 7" rests on two classical facts the repository neither states nor cites. For a stranger the programme's headline conjecture is not yet connected to the plane.

## The commitments, given or chosen

| commitment | given / chosen | receipt or chooser | the wall stands on it? |
|---|---|---|---|
| Theorem B: no five-colour compulsion inside K | given | `FieldWall4.lean:1187-1195` (kernel) | no — it is why the descent halted, not why 6-open objects read zero |
| the residue law over a sealed field (forced ⟹ 11 ∣ d², virtual ⟹ d² ≡ 1) | given | `ResidueObstruction11.lean`, G47 | no — silent in 6-open fields |
| plane freedom at level one, every p ≡ 3 (4) | given | `PlaneRotation.lean:184-190` | partly — it says level one forces nothing; it says nothing about level m |
| the mascot bound, the critical-set bound, absorption | given | rows 58, 48, 49 | no — all inert on ρ₆₃ (§16 of the H4 plan) |
| **the prime is read at level one** ("usable prime", "the plane at p", "5-sealed") | **chosen** | the vocabulary of M58, chosen because level one is where the bound lives; nobody chose it for the forcing | **yes** |
| **the compulsion sought is pairwise (arity 2)** | chosen, with a reason | the spindle theorem consumes `Forces` (`OneDefect.lean`); but the 5-forcers' own Act One is a class pigeonhole and G53 names a counting compulsion | yes, for the sweeps; not for the mechanism |
| **the object asked is a critical 5-chromatic graph** | chosen | availability: the witnesses and one purpose-built arena; the 4-colour precedent read deep 4-colourable fabric | yes |
| the bridge fields → ℝ² | chosen (asserted, not received) | prose in `M61…:67-68`, `PROGRAMME…` §4 | yes, for the product claim |

Given bricks only would make the wall the world's; there are three chosen bricks, and the anomaly's addresses point
at the first: every failed attempt held "level one" fixed, and the one place four-colour forcing was ever measured is
three levels down.

## Said for a stranger (the reframe's first artifact)

*For a reader in algebraic number theory who knows the Hadwiger–Nelson problem and not this project.* Let F be a real
number field, 𝔭 a prime of F(i) fixed by complex conjugation, with residue field 𝔽_q, q ≡ 3 (mod 4) or q = 4. The
unit-distance graph on F² reduces along O_{F(i),𝔭} → O/𝔭^m to the Cayley graph P_m = Cay(O/𝔭^m, S_m), S_m the image of
the norm-one group. P₁ is UD(𝔽_q, 2) (or K₄ when q = 4); the maps P_{m+1} → P_m are graph homomorphisms; the inverse
limit is the unit-distance graph of the 𝔭-adic plane (Bardestani–Mallahi-Karai's quadratic graph over a local field,
anisotropic case, finite chromatic number). **A colouring of the local plane is *m-continuous* if it factors through
P_m.** The question: *for which (𝔭, k) is every proper k-colouring of the local plane m-continuous for some m, and what
is the least such m?* At (𝔭 ∣ 2 in ℚ(√3,√11), k = 4) the record's measurements say m ≈ 3 in the lattice's own depth
units (every 4-colouring of a large chunk agrees with the residue colouring on pairs at valuation 6, not at 4 or 2).
At (𝔭 ∣ 11, k = 5) nothing is known beyond m = 1, where the answer is "none is forced" (plane freedom). If some
m-continuity holds at 11 for k = 5, a large enough fabric over a 5-sealed field forces a pair at a distance d with
11 ∣ d² — the pair the six-level of local–global tightness needs — and the spindle over it is a 6-chromatic
unit-distance graph in a 6-open field. If no m-continuity holds at 11 for k = 5, the residue mechanism cannot produce
that pair, and the only known route to six through sealed fields is closed at its mechanism.

The stranger's words that the room did not have: *level*, *continuity of a colouring*, *the tower*. Prior art to check
before building: Medrano–Myers–Stark–Terras on finite Euclidean graphs over rings ℤ/p^r (spectra; recalled, not read,
not in `BIBLIOGRAPHY.md`); `[BardestaniMallahiKarai2015]` for the local-field object (held, read on the Borel side).

## The candidate frames (the hunch ledger)

hunch: forcing-lives-at-a-level-of-the-prime
  claim: every k-colouring of a deep-enough chunk of a 𝔭-sealed plane agrees with a colouring of P_m for the least m at which P_m's k-colourings are all constant on 𝔭^{m'}-cosets for some m' < m; the four-colour forcing of K-fabric at valuation 6 is the instance at 𝔭 ∣ 2
  basis: measured
  falsifier: the 2-adic tower P_m over K(i) at four colours admits, at every m ≤ 8, a 4-colouring separating some pair of valuation 6 — then chunk forcing at valuation 6 is not tower-continuity and the frame is wrong on the calibrated bed
  registered: 2026-09-13
  status: open

hunch: the-two-primes-differ-at-level-one-and-agree-higher
  claim: P₁ is a clique at 2 and pairwise free at 11, but for k = 5 some level m ≥ 2 at 11 has every 5-colouring of P_m constant on 𝔭-cosets
  basis: analogy
  falsifier: a verified 5-colouring of P₂ = UD(ℤ/121, 2) separating the origin from some 11·v (a Separated model at the origin, self-certifying) — and the same at P₃ if P₂ separates
  registered: 2026-09-13
  status: open

hunch: the-sweeps-asked-the-wrong-object
  claim: a five-colour forced pair over a sealed field, if it exists, appears in deep 5-colourable fabric (the 11-adic analogue of the valuation dial), not in a critical 5-chromatic object; the four measured nulls are consistent with the frame and do not bear on it
  basis: analogy
  falsifier: a 5-colourable fabric over Heule's field whose 5-colourings, at every depth reachable, separate every pair with 11 ∣ d² — measured by the forced-distance table FS-6 §H (i) asked for and nobody built
  registered: 2026-09-13
  status: open

hunch: the-arena-null-is-thinness
  claim: ρ₆₃ and the 1581 read zero at arity 2 because both are near-critical (degree ~21 and ~10; "the object is thin", commit 217c0cb), and a compulsion at five colours needs density the way the 4-colour kills needed depth
  basis: analogy
  falsifier: a dense 5-colourable object in a 6-open field (degree ≫ 21, depth ≥ 2 at some usable prime of a subfield) that still reads zero over a complete pair sweep
  registered: 2026-09-13
  status: open

hunch: the-bridge-is-classical-and-unstated
  claim: χ(ℝ²) = sup_F χ(F²) over real number fields, by de Bruijn–Erdős (finite subgraphs) plus the fact that the unit-edge variety of a finite graph is defined over ℚ and a real point yields a real-algebraic point (real closed fields; Tarski)
  basis: prior
  falsifier: a finite unit-distance graph in ℝ² with no drawing over any number field — impossible if the transfer principle applies, so the falsifier is a gap in the transfer argument found when it is written for the kernel
  registered: 2026-09-13
  status: open

## Reading the wall

Where the work stops: at arity 2, on critical objects, at level one. What every attempt held fixed: the level. The
exact value: the 2-adic forcing at valuation 6 and not 4 — a boundary in the 𝔭-adic tower, i.e. the instrument
(the residue map at level one) speaking. The theorem invoked for the impasse — "the sealing plane has no pair
compulsion" (M60) — is a theorem about P₁; its hypothesis is "level one", and the situation above level one is not
covered. The dual: a 6-forcer over a sealed field is a colouring of the 𝔭-adic plane that is *not* 1-continuous but
*is* m-continuous — the two-sided statement in which "rigid at 11" and "free at 11" are the two answers.

**The test of the adopted frame (the tower).** *Consequence:* the four-colour forcing at valuation 6 and the null at
level one at 11 are both matters of course if continuity sets in at a level, and at different levels for different
primes. *Conservation:* every kernel theorem is a statement about level one or about the whole plane, and stands.
*Prediction:* at 2, P_m over K(i) at four colours forces valuation-6 pairs and not valuation-4 pairs from some m ≤ 8
— a finite computation nobody has run; at 11, P₂ at five colours either separates the origin from every 11·v or
forces some — a 14,641-vertex Cayley SAT with one disequality, self-certifying when SAT. *Compression:* "sealed at
level one, forcing at level three" is shorter than the frame plus the readings G31-ext, G52, G53 and "the object is
thin". *Cost:* no pivot — the kernel object already exists (`unitQuadrance (ZMod (p ^ 2))` elaborates today;
`unitQuadrance.map` along `ZMod (p²) → ZMod p` is M58's functoriality), and the instruments are M60/M61's.

## The question cards

question: at-which-level-of-the-prime-does-a-sealed-plane-force
  evidence: `plans/M56-arithmetic-of-tightness.md:409-410,728-733` (F_true = 171 at 2-adic depth 3, 0 at depth 2, mechanism unstated); `data/m53/rigidity-dial-it4.json` (163/178 at valuation 6, 0 at 2 and 4); `Lift.lean:19-22` (level p² used only as an obstruction); `finitePlane11_forces_iff` (level one at 11 forces nothing)
  expected: the frame reads a prime at level one, so forcing should either be absent (11) or total (2, a clique); instead it sets in at a definite depth at 2 and is unmeasured above level one at 11
  ask: for the tower P_m = Cay(O/𝔭^m, S_m), what is the least level m at which every k-colouring is constant on 𝔭^{m'}-cosets — at 2 with k = 4 first, then at 11 with k = 5?
  if at 2 the tower forces valuation-6 pairs from some m and not valuation-4 pairs: the frame is confirmed on the certified bed, the M56 measurement has its mechanism, and the 11-adic computation is the six-level's decisive test
  if at 2 the tower never forces at any m ≤ 8: chunk forcing is not tower-continuity; kill the frame, and the M56 fact needs another discipline (reconfiguration / Kempe, FS-2)
  if at 11 with k = 5 some level forces 𝔭-cosets: a deep-enough fabric over a 5-sealed field carries a forced pair at 11 ∣ d², G48's spindle lands a 6-forcer in a 6-open field, and the milestone is its construction with a size estimate from the level
  if at 11 with k = 5 no level up to the affordable bound forces: the residue mechanism cannot produce the six-level's pair; route A closes at its mechanism and the honest bet moves toward "no six through sealed fields"
  answered by: run — the 2-adic tower at four colours by exact enumeration and SAT (|P_m| = 4^m, m ≤ 8), then the 11-adic P₂ at five colours as one Separated ask at the origin per coset class (M60's origin reduction; a SAT model is a verified table, kernel-consumable through `not_forces_zero_of_not_periodic`)
  cost: an afternoon for the 2-adic tower (thousands of vertices); a day for P₂ at 11 (14,641 vertices, degree 132, Cayley symmetry); P₃ at 11 (1.77 M vertices) only if P₂ forces
  hunch: continuity sets in — at 2 by level 3 in the lattice's depth units, and at 11 at level 2 or 3 for five colours; basis analogy from the clique at level one
  falsifier: a verified 5-colouring of UD(ℤ/121, 2) separating the origin from some 11·v
  rank: 1

question: was-the-forced-pair-ever-sought-where-the-four-colour-one-was-found
  evidence: `plans/STUB-family-keeping-thickening.md:130-135` §H (i): the forced-distance table at residue norm 0 on Heule-510, its closure, W and its cross lattice — never built (`plans/BACKLOG-FOR-OPUS.md` B9 unbuilt; no `pullback-*.json` in `data/`); every five-colour sweep in the record ran on critical objects (`plans/M63-phaseH4-sweep.md` §0; M48; M54 §R)
  expected: the six-level's pair would be sought on 5-colourable fabric over a sealed field at pairs with 11 ∣ d², as the four-colour pairs were read off 4-colourable fabric at valuation ≥ 4
  ask: over Heule's field, on the deepest 5-colourable fabric we hold, is any pair with 11 ∣ d² forced equal by every 5-colouring, and at which 11-adic depth do the first such pairs appear?
  if some pair is forced: FS-6's mechanism has its first instance; spindle it (√(4d² − 1)) and the field is 6-open by construction — halt and verify
  if none at every depth the fabric reaches: the depth is the variable, and the rank-1 card's tower says whether any depth suffices before more fabric is grown
  answered by: run — `fpcompel.py filter --pairs` at residue norm 0 on Heule-510 ∪ gen-1 (M59's hub scan as the enumerator), then forced-equal asks under the jackpot protocol; the measurement B9 (i) specified
  cost: a day of CPU on the existing instruments; nothing new to build
  rank: 2

question: is-the-programme-connected-to-the-plane
  evidence: `plans/M61-local-global-tightness.md:67-68` ("since de Grey's field has L = 8, [T2] is equivalent to χ(ℝ²) = 7"); `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4 line 1 ("de Bruijn–Erdős: χ(ℝ²) is the supremum of χ(F²) over such F"); grep of `Proofs/` for de Bruijn–Erdős and for an algebraic-drawing lemma: none
  expected: a two-line classical bridge, cited or in the kernel
  ask: is χ(ℝ²) = sup over real number fields F of χ(F²) a theorem this repository can state and prove, so that every field-level result bears on the plane?
  if yes, in the kernel: T1/T2 and every field value become statements about ℝ²; the paper (FS-20) has its bridge; the 6-forcer route needs no separate plane argument
  if the transfer step fails on writing: the field programme bounds only its fields, and every "χ(ℝ²)" sentence in the record after M58 is rewritten as a field statement
  answered by: derivation — de Bruijn–Erdős (finite subgraphs; Mathlib has compactness of colourings? check `SimpleGraph.Colorable` and `Finset` API) plus the real-closed-field transfer for the unit-edge variety; one or two days of kernel work
  cost: one to two days; no compute
  rank: 3

question: is-any-finite-plane-exactly-six
  evidence: `data/fplane/chi-p23-k5.json` … `chi-p47-k5.json` (`chi: None`, four solver-hours each); `BIBLIOGRAPHY.md:41,46` (no literature value above 19); `plans/STUB-first-digit-23.md` §3 D2 (the α route: refusing an independent set of 106 certifies χ ≥ 6 at 23 modulo the solver)
  expected: the conjecture's own first digit decided at the smallest undecided prime before the conjecture is argued from
  ask: is UD(𝔽₂₃, 2) five-colourable — by cube-and-conquer on the independence instance (α ≥ 106?) or on one hexagon's colourings?
  if five-colourable: 23 is 5-sealing like 11 and 19; the "never 6" reading of T1 gains a fourth instance and the disproof-side bet gains
  if it refuses: the first finite plane exactly 6-chromatic exists at 23 (its upper bound 8 by a periodic colouring), and T1 names by congruences the fields hosting a 6-chromatic unit-distance graph — a target computed, not searched
  answered by: run — the priced FS-17 routes, a desktop-day each; the α route's refusal is kernel-consumable through `card_le_mul_of_colorable`
  cost: one to two desktop-days per route
  rank: 4

## The ruling (a recommendation, in four parts, with its default)

**The choice.** Open the next milestone on the rank-1 card: **the residue tower** — mint it as FS-38
(`plans/STUB-residue-tower-rigidity.md`) and run it derivation-first on the certified 2-adic bed before the 11-adic
test. Its stop rule is written into the stub: the 2-adic tower must reproduce M56's depth-3 fact before any 11-adic
run; the 11-adic P₂ ask is one day; P₃ only on a forcing verdict at P₂.

**The alternative weighed.** FS-6 as ranked (grow rigidity in de Grey's or Parts's lattice and sweep), or FS-17 first
(decide the first digit at 23). FS-6 buys a fifth null of the same genre unless its central computation (B9) is run;
FS-17 buys one digit of the conjecture at a solver-day per route and does not touch the mechanism.

**Why this one.** It is the only move that changes the frame's object rather than adding an instance inside it; it
predicts the one four-colour fact the record measured and never explained; it is finite, exact and cheap at 2; and at
11 it is two-sided — either answer changes the next move (a construction with a size estimate, or the closing of route
A at its mechanism). G46's rule applied: the object named in its own discipline (Cayley graphs over O/𝔭^m; the
quadratic graph over a local field) brings that discipline's theorems and its prior art with it.

**Confidence.** Medium. The one fact that would change it: the 2-adic tower failing to force valuation-6 pairs at any
affordable level — then continuity is not the mechanism and the frame is killed on the bed, at a cost of an afternoon.

**The default.** If Kooshi says nothing, the next session opens FS-38 as a milestone per WORKFLOW step 3, runs the
prior-art gate (MMST on rings; Bardestani–Mallahi-Karai's local-field object; "colourings of Cayley graphs on ℤ/p^m")
in its first half-hour, and runs card 2 (B9 (i)) in the background as the cheapest instance test. Card 3 (the bridge)
is kernel work for a slack day and is not blocking. Card 4 (FS-17) stays priced.

## The honest disproof branch

**What would make χ(ℝ²) = 5 the better bet.** Not the sweeps' nulls — those are consistent with the frame (card 1's
third hunch). Two readings would: (a) the 11-adic tower never forcing at five colours at any affordable level AND the
2-adic tower reproducing the 4-colour forcing — then the sealed-field mechanism is dead by its own discipline and
the six-level has no arithmetic route left; (b) every finite plane at 23, 31, 43, 47 five-colourable — then under T1
no field plane is exactly 6-chromatic, and Hadwiger–Nelson is 5 or 7, with 7 requiring a mechanism nobody holds.
Neither is a proof of χ ≤ 5; the record names no route to that (`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4: "the sieve
is structurally one-sided"), and FS-9/FS-10 remain reading rooms. **The cheapest test that moves the bet either way
is card 1 at 11, one day; the cheapest test of the first digit is card 4, a desktop-day.** If both come back on the
"five" side, the next Poros pass is on the upper bound, whose object the record has not yet named for a stranger.

## Corrections to the readers and to the parent, with addresses

- The parent's brief called the transfer step "real-closed-field transfer"; the record has no such sentence
  (`PROGRAMME…` §4 says only "de Bruijn–Erdős"), so card 3 is the first place it is written down — a hunch with basis
  prior, not a fact of the record.
- The six-question reader listed the two-core union as "5-sealed, K-descent"; its field is K(√247) after the
  spindle (`plans/M54-five-colour-dial.md` §R), 5-sealed by M58 — the label is right, the field name was missing.
- The frontier reader's "FS-6 hands its question to FS-2": correct as the stub's §7 reads; this pass says the
  hand-off skipped the measurement §H (i) specified, which is card 2.

## What this pass held back, and why

- No milestone is opened and nothing is committed: the ruling is Kooshi's to accept.
- The kernel shape of the tower (the level-m plane as `unitQuadrance (ZMod (p ^ m))`, the coset-constancy statement
  in M60's `Forces` vocabulary) is left to de Bruijn's subplan; Poros does not state theorems in the kernel's
  vocabulary.
- The arity-3 remainder (337 candidates on ρ₆₃) is left as a standing finding; nothing in the frame says arity 3 is
  where the answer is, and finishing it buys a fifth null.
- No opinion is offered on χ(ℝ²); the two ledgers above hold the bets, and every one has a falsifier and a date.
