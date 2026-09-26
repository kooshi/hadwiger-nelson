# FS-103 — the collapse: plan (job FS103-P)

*de Bruijn (Opus 5.5), 2026-09-26, milestone planner. Brief `data/fs103/briefs/P103-planner.md`, with `data/fs103/briefs/STANDING-RULES.md`
as part of it. Advisor: Poros (job FS103-A, agent `a3b6c6fddab9cf53b`). Prior-art reader: job FS103-G (record `plans/FS103-G-prior-art.md`,
which becomes §PA). Stub: `plans/STUB-collapse-cp-plane.md`. **Nothing in this plan is a result.** The question is a candidate composition
that two minds reached blind to each other and nobody has derived; this plan fixes its claims and the verification that will decide them.
Grades are `CLAUDE.md` § Notation's. The blind verifiers read `data/fs103/claims.md` and nothing else of this file.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| P103-R1 | For a totally real `E ⊇ F_dG = ℚ(√3,√5,√7,√11)`, every usable prime of `E` lies over a usable prime of `F_dG` (residue degree is multiplicative, and odd over odd), so `E` has no usable prime below 131 and its wall is broken | [derived, one mind; not load-bearing, not in the claim list] | §1.2 |

## Stage 1 — SAVED: quotation check, Kooshi's observation, §G part 1 (G1–G80)

### 1.1 Quotation check (standing rule 5)

| # | quotation in my brief | source | result |
|---|---|---|---|
| Q1 | *"We now have a real foundation to reach for 6 (or prove that no field is 6 colorable, which would be fascinating) and potentially answer the HN problem definitively."* | `CLAUDE.md` § The mission | **matches** |
| Q2 | *"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup."* | `CLAUDE.md` § Publication; the stub | **matches** |
| Q3 | *"The other agent is still running, the you are go for the collapse milestone. Interestingly, it's the only 4-quadratic field we've seen, and the same as the home field of de Grey's 2018 graph iirc."* | the owner's relay, "just now" | **not checkable** (no written source); its content is checked in §1.2 |
| Q4 | the question: "Given MR … and T-J39-3, at a real field `F` with no non-thick stable place, is `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`?" | the stub, § The question | **matches the stub — and the stub overreaches its own input**: T-J39-3 is stated "every `k`, every **totally real** `F`" and its proof says "*Not claimed:* anything at a complex place of a non-totally-real `F`" (`plans/POROS-2026-09-25-wanted-poster-167.md` §3.2). F1 is scoped here to **totally real** `F` (claim F1-GEN); both instances are totally real. **Correction owed** to the stub's and `CLAUDE.md`'s "a real field". |
| Q5 | T-J39-3, *"Let `N_k(F)` be the finite set … **So, given MR(F): `F²` is `k`-colourable iff `Y_{F,k}` has a CP `k`-colouring.**"* | wanted-poster §3.2 | **matches**; the ellipsis elides the either/or ((A) a CP colouring of `Y`, (B) an SP witness), which the claim list quotes in full |
| Q6 | `k`-thick, *"A place is **5-thick** if its local graph contains a compact open subgroup `K` and a probability `ν` on `T_v ∩ K` with `λ* = sup_{ξ≠0}|ν̂(ξ)| < 1/4`"* | `plans/M3-derivation.md` line 39 (the header's definitions, not the M3-J21-TH entry the stub names) | **matches the text; the address is the header.** A second definition is in play: J39's gloss, "the place's compact local piece has mixing constant `λ* < 1/(k−1)`", made exact by FS100-BC §1.2 (Haar on `T_w`, every level). M3's is existential over `(K, ν)`, BC's is the standard piece; standard-thick ⟹ M3-thick. The claim list quotes both and says which each claim uses. |
| Q7 | row 120's grade, *"[hand; PE-2 two derivations blind … MR a composition, three minds]"* | `LEDGER.md` row 120 | **matches** |
| Q8 | `χ_CP` verbatim, *"a random map `c : G → [k]` … No joint measurability is part of the definition. `χ_CP(ℝ²)`: the least `k` for which `UD(ℝ²)` carries one."* | `plans/FS100-BC-verification.md` lines 68–71 | **matches**; it is J48's reading of J39's gloss ("a translation-invariant random colouring, continuous in probability, proper almost surely at each fixed edge", wanted-poster §3 notation); both go in the claim list |
| Q9 | *"`χ(F²) ≤ χ_CP(ℝ²)` for every countable `F ⊆ ℝ`"*, "X21V B-2 (i) re-derived with no input" | `LEDGER.md` row 125; `plans/FS100-X21V-verification.md` §2.8 | **matches** |
| Q10 | "`2√131/132 = 0.1734`"; "`2√103/104 = 0.1952`" | the stub; arithmetic | **matches** (`0.173424…`, `0.195170…`) |
| Q11 | "a checking reading of an existing proof is not a second mind, row 117's precedent" | `LEDGER.md` row 117's grade | **matches in substance**: row 117 lists J51V's re-derivation "(not blind)" apart from its two blind derivations |
| Q12 | "'It' … is de Grey's field ℚ(√3,√5,√7,√11)" | `CLAUDE.md` G43 ("his coordinates span K(√5,√7)") | **matches** (`K(√5,√7) = ℚ(√3,√5,√7,√11)`) |

### 1.2 Kooshi's observation, against the record (G43, rows 52, 53, 63)

- *"the same as the home field of de Grey's 2018 graph"* — **confirmed.** G43: de Grey's coordinates span `K(√5,√7)`, ℚ-span rank 16 of 16
  over `tools/degrey_cert.json`; `√7` enters through the rotations by `π/2 ± arcsin(1/8)`; no prime below 131 is usable (row 52: "de Grey's
  first usable prime is 131"; row 53: "first usable primes 131, 479").
- *"the only 4-quadratic field we've seen"* — **not as stated.** The record holds other multiquadratic fields of rank 4: `K(√5,√247) =
  ℚ(√3,√5,√11,√247)` (rows 52–53, sealed at five by 11) and row 63's `ℚ(√2,√3,√11,√35)` and `ℚ(√3,√10,√11,√35)`; and one of rank 5,
  `K(√5,√7,√247)` (row 53, 6-open). **What is true, and what the milestone needs:** `F_dG` is the only field in the record with no stable
  place below 131, i.e. the only one with `N₆ = ∅` on the record's lists; and every totally real field containing it inherits that (P103-R1:
  a usable prime of `E` has odd residue degree over `p ≡ 3 (mod 4)`, and so does the prime of `F_dG` below it; the wall stays broken because a
  prime of `F_dG` above 2 that splits in `F_dG(i)` stays split upstairs). So `K(√5,√7,√247)` is a second collapse field, and ℚ(√635087) a
  third, of degree 2.
- **Why it matters here:** the collapse needs a field with no place a CP colouring could use to beat the plane; de Grey's graph needed a field
  where no small residue plane could seal it. They are one arithmetic fact read twice: no usable prime below 131.

### §G — the re-grokking (WORKFLOW 3.1), part 1: G1–G80

*One line each: **bears** (what it says about this milestone, and the phase it changes), **silent** (why), **falsifiable here** (register it).
"V1", "V2" are the two blind verifiers; "C-…" are claim ids of `data/fs103/claims.md`; "K" the kernel slot; "PA" the gate.*

| G | verdict | reason, and the instruction it becomes |
|---|---|---|
| G1 | **bears** | `F_dG` breaks the 2-adic wall (√5, √7), so every dyadic place splits in `F(i)`: no dyadic stable place, `R = O′` (row 100), and no dyadic factor in `N_k`. → C-dG-PL must list the places above 2 as split, with the reason. |
| G2 | silent | no construction is built |
| G3 | silent | no witness's radii or angles are read |
| G4 | silent | no shell inventory used |
| G5 | silent | the 1581 enters only through its field |
| G6 | silent | no base and detune |
| G7 | **bears** | `K(√7)` (the `n = 16` field) is the control where the chain must stop at six: usable primes 83 and ≥ 103, and 83 is not 6-thick (row 68: six at 83 needed a certificate, so Hoffman's ratio is ≥ 1/6, i.e. `|λ_min|/d ≥ 1/5`), while `2√83/84 = 0.217 < 1/4` makes it 5-thick. → control CTL-K7 in the claim list: the collapse holds at `k = 5` and stops at "N₆ = ∅" at `k = 6`. |
| G8 | silent | no edge directions |
| G9 | silent | no compulsion asked |
| G10 | silent | no criticality |
| G11 | silent | external witnesses; F1 is witness-free |
| G12 | silent | no detuned copies |
| G13 | silent | fans are finite-graph compulsions |
| G14 | silent | no arena |
| G15 | **bears** | § The open structural question: if F1 holds, rung D ⟺ `χ_CP(ℝ²) ≥ 6`, a statement naming no finite graph and no pigeonhole. → §IQ records it; no phase. |
| G16 | silent | no fabric |
| G17 | silent | no sub-rung compulsion |
| G18 | silent | no search to compose |
| G19 | silent | no pattern-class sweep |
| G20 | **bears** | the chain's top, `χ_CP(ℝ²) ≤ 7`, is a randomly translated classical seven-colouring (FS100-BC §2.10); brick/hexagonal colourings are boundary-tight (G20), so properness at each fixed unit pair must be checked a.s., not everywhere. → input I-CP7 carries that caution. |
| G21 | **bears; falsifiable here** | F1 was liked by two minds: audit it at the rate of a disliked one. Each claim says whether its test is exact or sufficient (Weil is sufficient for thickness; "not thick" means "not removable by J21-MX on the standard piece", M3-J21-UNIF's scope). Killing test of the rule here: the verifiers return TRUE with no divergence that the wrong-reason columns would have caught. → every claim carries a wrong-reason-TRUE line. |
| G22 | **bears** | a six-colouring (or a CP five-colouring) of the plane has non-polygonal classes; polygonal colourings are Borel. → PA query: the polygonal and Borel chromatic numbers beside `χ_CP` (`[SokolovVoronov2025]`). |
| G23 | silent | cell scales |
| G24 | **bears** | integrality, not a relaxation, carries the step to seven: no density or fractional bound decides `χ_CP(ℝ²)` at six (X21D-Y: `j = 1` dead by Croft). → expectation E5: this milestone proves no bound on `χ_CP(ℝ²)`. |
| G25 | silent | forcing ladder of finite objects |
| G26 | **bears** (consequence) | given F1, a five-colour virtual edge at distance 2 on `[ExooIsmailescu2019]`'s host exists iff `χ_CP(ℝ²) ≥ 6` (FS-49's existence statement). → §IQ open instances; no phase. |
| G27 | silent | Galois automorphisms of `F_dG²` preserve unit distance; nothing turns on it |
| G28 | silent | fine-tail cell stage |
| G29 | silent | cell family closed |
| G30 | **bears** | a derivation-first candidate, but no derivation exists yet: its conclusion is bought only by the verifiers' derivations; the one computation (the spectrum at 131) is a control, not evidence. → the plan runs no measurement that could be read as support. |
| G31 | silent | no held object's compulsions |
| G32 | silent | two-distance dial |
| G33 | silent | descents |
| G34 | silent | in-field descents |
| G35 | **bears** | the wall and row 57's gap: the field-level reading (a conjugation-fixed prime supplies the valuation subring; R = O′ as primes) is hand-proved for number fields, not in the kernel. → K names row 57's gap and Lemma C′ as hypotheses; C-dG-PL states the dyadic trichotomy verdict. |
| G36 | silent | residue colouring on descents |
| G37 | silent | descent endgame |
| G38 | silent | linear thresholds below five |
| G39 | silent | critical sets |
| G40 | silent | absorption |
| G41 | silent | additive colourings |
| G42 | silent | Kempe gauge |
| G43 | **bears** | the sieve and the residue-DEGREE trap: `F_dG` loses 11 (residue degree 2 there) and its first usable prime is 131 (row 52), then 479 (row 53). → V2's PARI list must read residue degrees at every prime of `F_dG` above `p ≡ 3 (mod 4)` below a stated bound, ramified primes of `F/ℚ` (3, 5, 7, 11) included; control CTL-K5: `K(√5)` (Heule's field), where 11 is usable and not 6-thick, so the chain stops. |
| G44 | **bears** | Γ_q's eigenvalues are Kloosterman sums, exact in seconds; Weil gives `λ* ≤ 2√q/(q+1)` at level one. → C-131: the exact nontrivial spectrum of the level-one piece at the first usable place of `F_dG`, `max|λ|/d` against Weil's `0.1734`, a control. |
| G45 | silent | lifts |
| G46 | **bears** | name `χ_CP(ℝ²)` in its disciplines before any derivation (stationary random colourings; measurable/Borel chromatic number; factor-of-IID). → §PA.0. |
| G47 | silent | subsumed compulsion law |
| G48 | **bears** | at `F_dG`, `L ≥ 8` (G48: every usable prime's spectral floor ≥ 8), so the conjecture's bold form predicts `χ(F_dG²) = 7`; F1 makes that prediction equivalent to `χ(ℝ²) = 7`. F1 cannot falsify the conjecture. → §IQ; "what it does" states it without claiming it. |
| G49 | **bears** | the gate runs in the disciplines' words, pulls posers' author listings, and grep the held Polymath16 threads for "measurable" and "stationary". → §PA.0. |
| G50 | **bears** | `[Falconer1981]` is "not held, second-hand" (`BIBLIOGRAPHY.md` line 168) — the reading debt is the gate's first fetch; MR's EL2021 §§2–9 unread (FS-105's). → PA; C-MR16 says what rests on the unread proof. |
| G51 | **bears; falsifiable here** | two blind verifiers plus an advisor who never contacts them; count retractions in the free window; hand-backs content-free; neutral commit subjects. Killing test: the two verifiers produce nothing a single agent would not. → Phase 1 design and the briefs. |
| G52 | silent | rotation arenas |
| G53 | silent | counting compulsion on arenas |
| G54 | **bears** | thickness is not the Hoffman sign: `λ* = sup_{ξ≠0}|ν̂(ξ)|` takes both signs, so a place can be slack and not thick (23 at five: slack, `λ* = 0.3317 ≥ 1/4`). → wrong-reason line in C-dG-THK: a check on `λ_min` alone. |
| G55 | **bears** | `R_F = O′` and prime inversion (`1/2 ∈ ℤ[U]` at `F_dG`); and a lower bound at five with no MR: de Grey's graph lies in `F_dG²` (G43), so `χ(F_dG²) ≥ 5` is kernel-held (rung B). → control CTL-dG4: at `k = 4`, `N₄(F_dG) = ∅` and the chain's conclusion (no four-colouring) is independently known. |
| G56 | **bears** | the places that can be non-6-thick are few: by Weil every usable `q ≥ 101` is 6-thick (`2√101/102 = 0.197`), so non-6-thick odd places lie below 101 (the window and its neighbours), plus dyadic `U_Q` of small norm. → V2's S-form claim C-S; §IQ open instances. |
| G57 | **bears** | ℚ(√635087) has no √3: its plane is triangle-free. Given F1 and rung D, a triangle-free six-chromatic unit-distance graph would exist (de Bruijn–Erdős in ℚ(√635087)²). → consequence C-CONS-3 (derived; the verifiers check it as a consequence, not an input). |
| G58 | silent | antipodal colourings of finite planes |
| G59 | **bears** | the wall at six and S's product conjunct: given MR, S's exact form (V2's role). → C-S. |
| G60 | **bears** | the real place's `J₀` minimum (`−0.40276 < −1/3`) and `m₁ ≥ 0.2293 > 1/5` (Croft): one-point densities cannot refuse a CP five-colouring; the fractional cap 4.36. → expectation E5; FS-104's domain. |
| G61 | silent | three colours |
| G62 | silent | bilayers |
| G63 | **bears** | the bridge `χ(ℝ²) = max_F χ(F²)` is Madore/Tarski and in the kernel only given `RealAlgebraicDescent` (row 107); F1's chain uses de Bruijn–Erdős plus countable restriction instead, and would attain the maximum at a named field. → K: the kernel slot uses `forces_iff_exists_finite`-style compactness (row 78), never `RealAlgebraicDescent`; C-CPUP states that. |
| G64 | **bears** | keep S and W apart: F1 gives S ⟹ `χ(ℝ²) ≠ 6`, never the converse; "six is skipped" is not evidence for seven. → C-S's wording; the report's "what it does". |
| G65 | silent | no SAT |
| G66 | **bears** | thickness is full depth: new-level characters obey `|λ| ≤ 2p^{k−1}`, ratio `2/(q+1)` (row 75), carried to ramified towers by Lemma P. → C-dG-THK says "every level", with the ramified-over-ℚ places included. |
| G67 | **bears** | each claim is written with its trigger and killing test (wrong-reason TRUE; control field and stopping step). → claim-list format. |
| G68 | silent | lattice quotients |
| G69 | silent | lattice rigidity |
| G70 | silent | √3-clean colourings |
| G71 | silent | three-colour heights |
| G72 | **bears; falsifiable here** | §IQ: test the stub's "the structural form is F1 itself". Killing-test count recorded at the close. |
| G73 | silent | cell-local certificates |
| G74 | silent | layers at three colours |
| G75 | silent | spectral pinning on a lattice |
| G76 | **bears** | a factor leaves a product colouring when it **mixes** (`λ* < 1/(k−1)`), not when its ratio is small (row 109: false at 125 colours); "with a real place it is `χ_B(ℝ²)`'s". → wrong-reason line in C-LB6: deleting a place by ratio instead of `λ*`. |
| G77 | **bears** (lightly) | given CLG, character colourings of `F_dG²` need 22 colours (row 101): any five- or six-colouring of `F_dG²` is no character colouring, so F1's CP colourings are not spectral-on-`T` objects. → §IQ note. |
| G78 | silent | rank one |
| G79 | **bears** | the load-bearing step is an example-invariant argument (the `R ⋊ U`-averaged spectral measure every colouring carries); record which kind produced each verdict. → §IQ; close. |
| G80 | **bears; falsifiable here** | MR at degree 16 has never been exercised: EF_F⁺'s pigeonhole needs the unit vectors' polynomial growth by height (at degree `n`, `U_ℚ` alone gives `c·M^{1/n}`), and PE-2 applies EL2021 Thm 1.2 only under admissibility. Killing test of G80's reading: a gap at either step at `F_dG`. → C-MR16. |

## Stage 1 — SAVED
