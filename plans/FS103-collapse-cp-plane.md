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

## Stage 2 — SAVED: §G part 2 (every row's mechanism, the method rules) and the extraction

### §G part 2a — `LEDGER.md` rows 1–127 (§ A read in full from disk; § B consulted by grep for FS100-*, M3-J21-*, T-J39-*, BC-*)

| row | verdict | reason / instruction |
|---|---|---|
| 1–7 | silent (each) | two-circle, seam, coverage, fan, class, 120°, greedy: finite-graph compulsion machinery |
| 8 | silent | de Grey's balanced 5-colouring: a finite object |
| 9–13 | silent (each) | 120° compulsion, one-pivot cap, strip automaton, extension profile, negative knowledge |
| 14–25 | silent (each) | gluing classifications, seam closures (4-chromatic in K), field-wall identity |
| 26 | silent | de Grey anatomy; its field is G43's, not this row's |
| 27–30 | silent (each) | quadrature, kill engine, stacking, mechanism hunt |
| 31 | silent | Act One carriers |
| 32 | silent | hex-shell six-programme |
| 33 | **bears** | `5 ≤ χ(ℝ²) ≤ 7` in the kernel, the upper end by a periodic seven-colouring: the frame F1 sits in; its random translation is I-CP7 |
| 34–40 | silent (each) | cell family |
| 41 | silent | limit lemma (bounded families) |
| 42 | silent | arity floor |
| 43 | **bears** (consequence) | homogeneity and the six-target: given F1, a pair of five-colour virtual edges at √3 and 2 is one more route to `χ_CP(ℝ²) ≥ 6`; no phase |
| 44 | silent | spindle theorem (finite) |
| 45 | silent | batch descent, spare colour |
| 46–51 | silent (each) | copies, M53, critical sets, absorption, additive yardstick, additive rigidity |
| 52 | **bears** | the finite-plane bound, and "de Grey's first usable prime is 131": the upper half at `F_dG` is useless (`χ(Γ₁₃₁)` large), the lower half is the question → C-dG-PL cites it |
| 53 | **bears** | the sieve's map: `F_dG` first usable 131, 479; `K(√7)` 83; K(√5) sealed at 5 → controls CTL-K7, CTL-K5; `data/fplane/map.md` is the standing map V2 may compare against *after* its own PARI list |
| 54 | silent | lifts |
| 55 | silent | residue obstruction (subsumed) |
| 56 | silent | local–global tightness (finite quotients) |
| 57 | **bears** | Theorem A's valuation form and **row 57's gap** (a number field's conjugation-fixed prime supplies the valuation subring): every "stable place" statement at `F_dG` is hand-level there → K lists it as a named hypothesis |
| 58 | silent | Moser recipe threshold |
| 59 | silent | 2-adic law over K |
| 60 | silent | plane freedom at finite primes |
| 61 | silent | statements at their proofs' level |
| 62 | silent | overcompression |
| 63 | **bears** (lightly) | the multiquadratic 2-adic splitting; `F_dG`'s decomposition; the rank-4 fields Kooshi's remark counts (§1.2) |
| 64 | **bears** | the ρ₆₃ arena is five-chromatic in 6-open `K(√7)`: a finite five in the control field CTL-K7 (not used as input) |
| 65 | silent | arena shapes |
| 66 | silent | fan gap over sealed fields; "Not claimed: anything over a 6-open field" — F1's fields are 6-open, so row 66 says nothing there |
| 67 | **bears** | the tight/slack classifier; tightness at 2 is why the dyadic place matters — at `F_dG` it is split, so absent |
| 68 | **bears** | six refused at 83 by certificate ⟹ Hoffman did not refuse six ⟹ `λ*(83) ≥ 1/5` → CTL-K7's stopping step |
| 69 | **bears** | the window: the non-6-thick odd places are among `q < 101`, the window members and their neighbours → C-S |
| 70 | **bears** | the wall at six made finite; `U₆₄`'s floor 6 → C-S's dyadic clause |
| 71 | **bears** (lightly) | fractional blow-up caps at 4.36 → E5 |
| 72–74 | silent (each) | 3-adic barrier, quadratic four-colour witnesses, census |
| 75 | **bears** | full-depth thickness: the fibre-share inequality's `|λ| ≤ 2p^{k−1}` for new levels; `χ_Bor(ℚ_p²)` → C-dG-THK "every level" |
| 76–77 | silent (each) | five over ℚ(√3,√5) by forcers; the theorem audit |
| 78 | **bears** (K) | `forces_iff_exists_finite` (de Bruijn–Erdős by `Finset.rado_selection`) is the kernel's compactness tool for `χ(ℝ²) ≤ χ_CP(ℝ²)` → K |
| 79–87 | silent (each) | three-colour criterion, four-colour no-gos, ℚ(√167) survivors, row 82's layers, census, calibration, de Grey's lattice, abstract rigidity, second moments |
| 88–91 | silent (each) | type-(B) rigidity frame, K's classification, the rigid local plane, the construction no-gos |
| 92 | **bears** | measurable windows at every real place rest on `m₁(ℝ²) ≤ 0.2470` — the four-colour real-place fact behind the `k = 4` controls (CTL-dG4, CTL-167-4) |
| 93–94 | silent (each) | dyadic towers; ℚ(√11)'s explicit colouring (but C9 is a CP-branch-(A) control at four colours, J48-C11: noted for CTL-11 if the verifiers want a live branch (A)) |
| 95–98 | **bears** | band rigidity: `T + A` is where a band character's spectrum lives, the object R-U and step 4 of T-J39-3 read → input I-RU names R-U by statement |
| 99 | silent | `L ≤ 4` |
| 100 | **bears** | Lemma C′: `R_F = O′` off a ramified stable dyadic place — MR's scope; the exception fields have `L = 2` → C-dG-PL and C-635-PL must state "outside row 100's exception", with its reason |
| 101 | **bears** (lightly) | `χ_char(F_dG²) = 22` given CLG → §IQ note (G77) |
| 102 | silent | one prime fails |
| 103 | **bears** (K) | the chain theorem in the kernel; the 8/3 route is an MR-free five at `F_dG`-type fields → CTL-dG4 has two MR-free fives (de Grey's graph; the chain given G4) |
| 104 | silent | transcendence |
| 105 | **bears** (K) | prime inversion in valuation form is in the kernel; the number-field reading is row 57's gap → K |
| 106 | silent | stripe lemma |
| 107 | **bears** | the bridge conditional on `RealAlgebraicDescent`; F1 would supersede its use for the value by attaining `χ(ℝ²)` at a named field, given MR → C-CPUP notes F1 needs no Tarski; FS-39's stub re-aim |
| 108 | silent | rank one |
| 109 | **bears** | **J21-MX, the mixing selection** — the engine of the load-bearing step; its CP form is J48-MXcp → input I-MX by statement (Borel/measurable form), and C-LB6 asks for its CP form over infinitely many places blind |
| 110 | **bears** | thick places, the reduction RED, "two real places merge", and "**with a real place and only thick finite places the question is exactly `χ_B(ℝ²) ≤ 5`**" — the Borel-window form of F1 at five, over finite `S`; its GAP-1 (measurable → everywhere proper) is item 3's question → C-FMT; Phase 3 |
| 111 | **bears** (lightly) | Q-μ/transience split: the invariant-measure half is where CP colourings come from (Følner averaging) |
| 112 | **bears** | Theorem C: "the hypothesis is exactly continuity in probability … so the colouring extends to a stationary, almost-everywhere proper random colouring of `Cay(G_S, T_S)`" — a held analogue of T-J39-3's step 5, and a format warning (a.e.-proper vs proper a.s. at each fixed edge) → C-FMT |
| 113 | silent | ℚ(√47) at four colours (moot) |
| 114–115 | **bears** (lightly) | mixing pins a product colouring (Hoffman/mixing selection in finite products) — the finite shadow of the thick deletion |
| 116 | silent | Kronecker selection |
| 117 | **bears** (method) | the precedent for counting minds: a non-blind re-derivation is listed apart → Phase 1 grading |
| 118 | **bears** | no finitely generated `Γ ⊂ U` acts irreducibly on `R̂`; EL2021 applies on the pieces under admissibility → C-MR16 |
| 119 | silent | ℚ(√167) at four, kernel |
| 120 | **bears** | MR: F1's first hypothesis; its grade and its scope (`R_F = O′`) → I-MR by statement, C-MR16 at degree 16 |
| 121 | **bears** (lightly) | the triangle-free five at ℚ(√47) via de Bruijn–Erdős: the template for C-CONS-3 |
| 122 | **bears** (lightly) | the flip's constant `Λ ≥ 0.402759 > 1/3` at every real place — why no one-sided spectral route replaces MR at five or six |
| 123 | **bears** | CLS/SPC: every stable place's ratio profile; "`χ(ℚ(√167)²) ≥ 5` by two routes (the class; every stable place 4-thick)" — **the `N_k = ∅` shape with infinitely many thick places, already exercised at `k = 4`** (J48-N4, N4cor; T-J39-4) → control CTL-167-4 |
| 124 | **bears** | SEL-k, every real number field, every `k`, given MR: a second route to T-J39-3's steps 1–5 (X22D: "SEL-5 re-derives T-J39-3's 'given MR' iff by a different route"), the thick deletion still J39's → I-SEL by statement; the load-bearing step is step 6 |
| 125 | **bears** | B-1, B-2 (`χ(F²) ≤ χ_CP(ℝ²)` for countable `F`), Lemma X21V-M (merge), the density no-go → I-CPUP, I-MERGE by statement |
| 126 | silent | TR-ROT |
| 127 | **bears** (K) | FS-101's first slot: `SpectralChain`'s named hypotheses → K extends it with T-J39-3 and thickness as named hypotheses |

### §G part 2b — the method rules (`CLAUDE.md` § Grokkings [method], § Building, § The gate, § The standard of evidence)

| rule | verdict | reason / instruction |
|---|---|---|
| G21, G30, G46, G49, G50, G51, G67, G72, G79 | bears | above |
| § Building: build only through `scripts/build.sh`; `lake env lean` is not the gate; the batch is the plan | **bears** (K only) | Phase 4 builds only through `scripts/slot.py … ./scripts/build.sh` |
| § Building: halt on any unexplained crash | bears | every brief |
| § Building: RAM is the discriminator, `scripts/slot.py` | silent | no job above 2 GiB or 2 min is planned (PARI and the spectrum are seconds) |
| § Building: checkpoint every long phase [PROTECTED] | **bears** | every phase names its checkpoint: the record's SAVED stages (§6) |
| § Building: a blocking run is presumed killable [PROTECTED] | silent | no long runs |
| § Building: kill by pid, verify by effect; pipes kill producers; never edit a running script | silent | no background jobs planned |
| § Building: generated modules and invalidation | bears (K) | the kernel slot edits no module a certificate imports |
| kernel cost model | silent | no kernel computation planned |
| § Searching: `ugrep` alternation, `^` inside patterns; a failed `exact?` is not an absence | bears (lightly) | the fence greps in the briefs use `grep -F`; K greps Mathlib by shape |
| the gate: vacuity; every structure-hypothesis ships an inhabitant | **bears** (K) | K's hypotheses are propositions (named), never structures over empty domains; the CP-colouring structure needs an inhabitant (the random hexagonal seven-colouring) |
| make the gate fail: plant faults; state the uninformative outcome and confirm it reachable | **bears** | every claim's wrong-reason TRUE and control field is this rule; each verifier's exact check (spectrum, place list) carries a plant that fires for its own reason |
| a number in a ruling carries what it measures; exactly one thing differs | **bears** | thickness numbers are `sup|ν̂|` of the standard piece at every level, never `λ_min/d` at level one: C-dG-THK states which |
| both outcomes reachable, evidence for mis-specification predates the result | **bears** | expectations §6.3 |
| measured vs derived half fail in opposite directions | silent | nothing measured |
| a caveat stepped over | **bears** | "F1 gives `χ = χ_CP`, never `χ = χ_m`": the caveat to re-read against every summary sentence |
| count free parameters; enumerate the parameter first; a positive control proves only its generator's shapes | **bears** (lightly) | the place list is enumerated over all primes below a bound, not over a candidate list; the control fields cover both outcomes (goes through / stops) |
| a true explanation stops the search | **bears** | a verifier who finds one reason a step holds (Weil) checks every gate (ramified places, dyadic places, every level) |
| standard of evidence: write for the reviewer early; order steps by marginal evidential value | **bears** | V1 derives the load-bearing step first, the instances after; V2 lists places first (a cheap falsifier), then S |
| What compute helps: re-price a kernel leaf from its first two leaves | bears (K) | Phase 4's budget is provisional until two leaves close |

### §G part 3 — the extraction: each *bears* as an instruction to a phase

| # | instruction | phase | from |
|---|---|---|---|
| X1 | F1's scope is **totally real** `F`, outside row 100's exception, with `N₆(F) = ∅`; "a real field" is a correction owed | claims; report | Q4, G1, row 100 |
| X2 | the **load-bearing step** is T-J39-3's step 6 (the thick deletion over infinitely many places, random form) at `k = 6` with `N₆ = ∅`; steps 1–5 have a third route (SEL-k, row 124) and its merge is Lemma M | claims C-LB6; Phase 1 | rows 109, 124, 125 |
| X3 | the same shape (`N_k = ∅`, infinitely many thick places) **has been exercised at `k = 4`** (ℚ(√167), J48-N4cor, row 123's second route) and its conclusion is independently known at `F_dG` (de Grey's graph) — so the verifiers' derivations must specialise to `k = 4` and agree there | controls CTL-167-4, CTL-dG4 | G55, rows 92, 123 |
| X4 | controls where the chain must **stop**: `K(√7)` at `k = 6` (83 not 6-thick), `K(√5)` at `k = 5` (11 usable), ℚ(√167) at `k = 5` (23, 43) | claims; V2 | G7, G43, rows 53, 68 |
| X5 | thickness is `sup|ν̂|` at every level (both signs), not Hoffman's sign and not the independence ratio | wrong-reason lines | G54, G66, G76 |
| X6 | the CP format and its neighbours (a.e.-proper, Borel everywhere-proper, null-vertex N′) must be told apart in every claim; item 3 (`χ_CP` vs `χ_m`, `χ_B`) states nothing as held | C-FMT; Phase 3 | rows 110, 112; G22 |
| X7 | MR at degree 16: admissibility and EF_F⁺'s growth at `F_dG`; what rests on EL2021's unread proof | C-MR16 | G80, rows 118, 120 |
| X8 | the place list is PARI-exact with residue degrees, ramified primes of `F/ℚ` included, and a plant; the spectrum at the first usable place exact, beside Weil | C-dG-PL, C-131 | G43, G44 |
| X9 | `χ(ℝ²) ≤ χ_CP(ℝ²)` uses de Bruijn–Erdős and countable restriction, not Tarski; K uses row 78's compactness | C-CPUP; K | G63, rows 78, 107 |
| X10 | S's exact form given MR is written by V2, with the non-6-thick places named (window, `U_Q`) | C-S | G56, G59, G64, rows 69, 70 |
| X11 | the prior-art gate names the object in five disciplines, pulls author listings, fetches Falconer | §PA.0 | G46, G49, G50, G22 |
| X12 | no measurement is planned that could be read as support; expectations register both outcomes | §6 | G21, G30 |

**What §G changed in the stub's plan** (WORKFLOW 3.1 item 3): (1) F1's scope narrowed to totally real fields (X1); (2) the load-bearing step
named precisely as step 6, with steps 1–5 already held by a second route (X2); (3) the stub's "no instance has exercised it" corrected: the
shape was exercised at `k = 4`, which becomes a mandatory specialisation check (X3); (4) three stopping controls added (X4) and a positive
control at `k = 4` with an independently known answer (X3); (5) Kooshi's "only 4-quadratic field" corrected, and two further collapse fields
named (§1.2); (6) the format distinctions made a claim of their own (X6).

## Stage 2 — SAVED

## Stage 3 — SAVED: §PA.0, the gate's queries (for job FS103-G, which runs them; its record becomes §PA)

*The object named in the words of the disciplines where it lives, never ours. Coined words that appear in no paper and must not be searched:
"CP colouring", "`χ_CP`", "thick place", "non-thick", "collapse", "stable place", "`N_k(F)`", "`Y_{F,k}`", "MR", "SP witness", "the wall".
Record every query with its database, its hit count and the hits opened (G49; WORKFLOW 3.2 items 1–8).*

### PA.0.1 The object, in each discipline's words

| discipline | the object, as that discipline would name it | query strings (zbMATH `ab:`/`ti:` and all-field; arXiv; Google Scholar) |
|---|---|---|
| **measurable / descriptive graph combinatorics** | the measurable (Lebesgue) chromatic number `χ_m(ℝ²)` of the unit-distance graph; Borel `χ_B(ℝ²)`; measurable colourings proper almost everywhere vs everywhere; "null-set tolerant" colourings | `"measurable chromatic number" & plane`; `"Borel chromatic number" & ("unit distance" \| "Euclidean")`; `"measurable coloring" & "distance one"`; `ti:"measurable" & ti:"chromatic" & py:1975-2026`; `"chromatic number of the plane" & measurable`; Kechris–Marks survey §§ on `ℝⁿ` distance graphs (Example 5.1 is read, M3) |
| **probability / ergodic theory** | a translation-invariant (stationary) random colouring of `ℝ²`, continuous in probability, proper at each fixed unit pair almost surely; an invariant probability measure on the space of colourings (a colouring shift of `ℝ²`); factor of IID colourings | `"invariant random coloring"`; `"stationary coloring" & "unit distance"`; `"translation-invariant" & "random coloring" & plane`; `"factor of i.i.d." & coloring & ("Euclidean" \| "ℝ^d" \| "R^n")`; `"continuous in probability" & coloring`; `"measurable modification" & "stationary process" & coloring`; `"invariant measure" & "space of colorings"` |
| **harmonic analysis of distance-avoiding sets** | sets avoiding distance 1 (`m₁(ℝ²)`), their `j`-fold unions / `j`-colourable parts (`m_j`), the measurable chromatic number via spectral/SDP bounds; correlation functions of stationary colourings | `"distance avoiding" & "chromatic"`; `"sets avoiding distance one"`; `"measurable chromatic number" & ("Fourier" \| "linear programming" \| "semidefinite")`; authors below |
| **number theory / fields** (the question's second face) | the chromatic number of `F²` for a real number field `F` (`ℚ(√3,√5,√7,√11)`; `ℚ(√d)` for large prime `d ≡ 7 (mod 8)`); "is `χ(ℝ²)` attained by the plane over one countable field?" | `"rational points" & "chromatic number" & plane`; `"number field" & "unit distance graph" & chromatic`; `"chromatic number" & ("Q^2" \| "rational plane") & "measurable"`; the Benda–Perles and Johnson lineage (`[BendaPerles2000]` Open Problem 11.6, `[Johnson2006]`) |
| **Borel / measurable Hedetniemi** (the product side, for S) | Borel or measurable colourings of products of Borel graphs; a positive special case of Kechris–Marks Problem 4.23 | `"Borel" & "Hedetniemi"`; `"measurable" & "categorical product" & coloring` |
| **set theory and choice** | `χ(ℝ²)` vs `χ_m(ℝ²)`: dependence on the axiom of choice (Shelah–Soifer) | `au:"Shelah, Saharon" & ti:"chromatic"`; `"axiom of choice" & "chromatic number of the plane"`; `"Shelah" & "Soifer" & "chromatic"` |

**Not this question's home** (recorded so it is not searched as one): aperiodic order / model sets (FS-63) — with `N_k = ∅` there is no
`p`-adic factor (the advisor's R2 correction, `plans/RERANK-2026-09-26.md` §3.1 point 2).

### PA.0.2 The question itself, in its posers' words (WORKFLOW 3.2 item 3)

1. *Is it known that the chromatic number of the plane equals its measurable chromatic number* — `χ(ℝ²) = χ_m(ℝ²)` — or that equality
   holds for stationary random colourings? Where is it stated **open** (`[Soifer2024]`'s chapter on measurability — the book is held at
   `~/source/library/` as the 2024 PDF; Shelah–Soifer 2003/2004; `[KechrisMarks2020]` Example 5.1; `[Falconer1981]`'s closing remarks)?
2. *Is `χ(ℝ²)` attained by the plane over a single countable (or finitely generated) subfield?* — the bridge's attained form (`[Madore2015]`
   ¶5.4 gives `sup`; does anyone give a named field?).
3. *Is the least `k` admitting a translation-invariant random `k`-colouring of the plane, continuous in probability and proper at each unit
   pair almost surely, known to equal `χ_m(ℝ²)`, `χ_B(ℝ²)` or `χ(ℝ²)`?* — including the "measurable version proper everywhere" question
   (Doob's measurable modification gives a measurable colouring proper for almost every pair).
4. *Consequences recorded in print of `χ = χ_m`* that would become consequences of the collapse (e.g. statements about six-chromatic
   measurable colourings, Falconer's `χ_m ≥ 5` as a lower bound on `χ`).

### PA.0.3 Posers and workers whose complete author listings are pulled (zbMATH Open API, `au:"Last, First"`, then their own vocabulary against `ab:`)

Falconer, Kenneth J.; Soifer, Alexander; Shelah, Saharon; Kechris, Alexander S.; Marks, Andrew S.; Oliveira Filho, Fernando Mário de;
Vallentin, Frank; Bachoc, Christine; DeCorte, Evan; Bukh, Boris; Matolcsi, Máté; Ambrus, Gergely; Croft, Hallard T.; Szekely, László A.
(measurable/Borel chromatic questions in the plane); Townsend, Stephen P. (`χ(ℚ²)`-type lineage, if listed); Johnson, Peter D. Jr.
(the rational-plane compendium); Madore, David A.; Moorhouse, G. Eric; Benda, Miro; Perles, Micha A.; Conley, Clinton T. and Tamuz,
Omer and Lyons, Russell (factor of IID colourings; invariant random colourings); Bowen, Lewis; Gaboriau, Damien. **Also** grep the held
Polymath16 threads and wiki (`CLAUDE.md` G49 item) for "measurable", "stationary", "random colouring", "Falconer", "Borel".

### PA.0.4 Fetches owed first

- **`[Falconer1981]`** (JCTA 31 (1981) 184–189; `BIBLIOGRAPHY.md` line 168: "not held", "second-hand") — fetch and read in full; record
  exactly what it proves, for which format (measurable classes; proper everywhere or almost everywhere), and by what mechanism.
- Shelah–Soifer (2003, JCTA; 2004) — the choice-dependence of `χ(ℝ²)`; what it says about `χ` vs `χ_m`.
- `[BachocEtAl2009]` (held? `BIBLIOGRAPHY.md` line 273), `[OliveiraVallentin2010]`, `[DeCorteOliveiraVallentin2022]` (held, statements read)
  — whether any defines a colouring number between `χ` and `χ_m`.
- The factor-of-IID / invariant random colouring literature for `ℝ^d` or its distance graphs — a listing first, then open anything in the
  neighbourhood (WORKFLOW 3.2 item 6: never an abstract).

### PA.0.5 What a hit would change

- **F1 or `χ(ℝ²) = χ_m(ℝ²)` (or `= χ_CP`) found in print** → the milestone becomes an attribution; the verifiers still run (the chain's
  inputs are this project's), and FS-102's headline changes. The gate reports it to the owner **at once** (its brief).
- **`χ_m = χ` stated open, recently** → the collapse (if verified) reduces HN, given MR, to a problem posed in print: the write-up Kooshi named.
- **A named colouring number between `χ` and `χ_m`** → claim C-FMT's comparison is with it, and Phase 3's question is re-stated in its words.

## Stage 3 — SAVED

## Stage 4 — SAVED: §IQ, the invariant question (WORKFLOW 3.3)

1. **The existence form.** Given MR, does `F_dG²` (or ℚ(√635087)²) have a `k`-colouring exactly when the plane has a stationary random
   `k`-colouring continuous in probability — so `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`? Two existence questions per `k` (a colouring of `F²`; a CP
   colouring of `UD(ℝ²)`) and an equivalence between them. This is F1.
2. **The stub's claim, tested: "the structural form is F1 itself" — it is not.** F1 is an equality of chromatic numbers; it says nothing about
   *every* colouring. Its structural form, about every solution: **what does every `R ⋊ U`-invariant random `k`-colouring of `F²` carry
   that a CP `k`-colouring of `UD(ℝ²)` also carries — and is the passage from the first to the second (averaging, selection at the thick
   places, extension to the completion, merging real places) a map from all solutions to all solutions?** In the most general class, with
   the arithmetic stripped: `G` a countable abelian group embedded densely and diagonally in `H × K`, `H` an LCA group carrying the
   question, `K = ∏_v K_v` compact with every factor mixing (`λ*_v < 1/(k−1)`, `sup_v λ*_v < 1/(k−1)`); does every invariant random
   `k`-colouring of `Cay(G, T)` whose spectral measure off `Ĥ × {0}` is carried by no Haar-singular part yield a CP `k`-colouring of
   `Cay(H, T_H)`, and does every CP colouring of `Cay(H, T_H)` restrict to one of `Cay(G, T)`? The arithmetic re-enters only through
   which places are mixing (thickness) and through MR (the Haar-singular part is empty).
3. **The invariant it forces: named.** The spectral measure (equivalently the correlation function `y ↦ P(c(0) = c(y))` under the simplex
   embedding, positive definite by Herglotz–Bochner) of the averaged colouring, and on the thick factor the **fibre colour-measure vector**
   `x ↦ (Haar{b : C(x, b) = j})_j`, whose continuity in probability is what lets the selection be CP. An *example* invariant (G79): every
   solution carries it; the counterexample invariant (an SP witness) is what MR removes.
4. **Its route: derivation only.** V1 and V2 derive the load-bearing step C-LB6 blind; the stripped form is what their derivations must
   actually prove (the arithmetic enters as inputs I-THK, I-MR). No search checks it; the exact spectrum at 131 and the PARI place list
   check derived claims' inputs.
5. **The open instances it would decide, listed for the day a procedure lands:**
   - `F_dG = ℚ(√3,√5,√7,√11)` (`N₆ = ∅`): `χ(F_dG²) = χ(ℝ²) = χ_CP(ℝ²)`, given MR;
   - ℚ(√635087), ℚ(√823415), ℚ(√1017623), ℚ(√1598231), ℚ(√1971119) (the stub's list; squarefreeness of the composite ones to be checked by
     V2 before use), and `K(√5,√7,√247)` (P103-R1);
   - `K(√7)` at `k = 5` only (`N₅ = ∅`, `N₆ ∋ 83`): `χ(K(√7)²) ≤ 5 ⟺ χ_CP(ℝ²) ≤ 5`, given MR;
   - the conjecture's bold form at `F_dG` (`L ≥ 8`): under F1 it is `χ(ℝ²) = 7`;
   - FS-49's gadget: under F1 a five-colour virtual edge at distance 2 exists in some real field iff `χ_CP(ℝ²) ≥ 6`;
   - S (G64): under F1, S ⟹ `χ(ℝ²) ≠ 6`; S's exact form is claim C-S.

*G72's count, to be scored at the close:* whether the verdicts come through the structural form (the stripped statement) or from walking
J39's steps; and G79's: example invariant (fibre measures, spectral measure) or counterexample invariant (the SP witness).

## Stage 4 — SAVED

## Stage 5 — SAVED: the fixed claim list (`data/fs103/claims.md`) and the advisor's first advice

**The list** (ids, one line each): C-F1-GEN (F1, stub's text and the proposed totally-real scope); **C-LB6** (load-bearing: T-J39-3's forward
either/or at `k = 5, 6` with `N_k = ∅`, forbidden inputs named); **C-THKDEL** (the step arithmetic-free: CP selection through a countable
product of mixing compact factors); C-EXTk (R88-TC-ext at `k` colours, `S = ∅`, jointly measurable version); C-APX (closure of `ι(U)` is the full
product of circles; `ι(R)` dense in `G_∅`); C-MERGE-n; C-CPUP; C-635-PL, C-635-THK, C-635-F1, C-635-TF; C-dG-PL, C-131, C-dG-THK, C-MR16,
C-dG-F1; C-S (R1's text, four parts); C-FMT (six parts, no assertion). Controls: CTL-167-4, CTL-dG4 (positive, answer known), CTL-K-4 (tight
boundary), CTL-K7-6, CTL-K5-5, CTL-167-5, CTL-ABS, CTL-Q2 (must stop).

**The advisor's advice (FS103-A, message of 2026-09-26, its record `plans/POROS-2026-09-26-fs103-collapse.md` at `0a0eed9c`), item by item:**

| # | advice | decision |
|---|---|---|
| 1 | state the uniform bound as one quantity (one standard `(K, ν)`, every place, every level) | **adopted**: C-635-THK, C-dG-THK are `sup_v`; C-LB6 wrong-reason (iv) |
| 2 | step 5's two approximation inputs as claims; weak approximation holds because the norm-one torus is rational | **adopted**: C-APX (a), (b), with the wrong-reason line; the reason is left to the verifiers (statements only) |
| 3 | T-J39-3 used only at `k ∈ {5, 6}`; at `k = 7`, 131 is not 7-thick | **adopted**: C-F1-GEN's first wrong-reason line |
| 4 | "`χ_CP ≤ χ_m`" has no derivation on record; a sketch gives `χ_CP = χ_m⁰` | **adopted as a claim, not as a belief**: C-FMT (a)–(f), no assertion. My own reading before the advice: a Følner limit taken pointwise need not be continuous in probability (a measurable set with ever finer structure far out), so `χ_CP ≤ χ_m` is not free; the advisor's weak-* route in `L^∞` avoids that objection. Both readings go to the verifiers only as the neutral C-FMT(c), (e). |
| 5 | S's scope: number fields only; specialisation raises χ | **adopted**: C-S (b)–(d); D-S and S_nf separated |
| 6 | the abstract control `Cay(ℝ, {±1, ±√2})`, and ℚ at `k = 2` | **adopted**: CTL-ABS, CTL-Q2 |
| 7 | a tight-boundary control: K at `k = 4` | **adopted**: CTL-K-4 |
| 8 | headline at ℚ(√635087); `F_dG` named second until FS-105 walks degree 16 | **partly adopted, one disagreement, held for the owner:** the verification order is ℚ(√635087) first (already the stub's); C-MR16 stays in V2's list as a first walk of degree 16 (one mind), because Kooshi named `F_dG` the publication instance. Whether the *headline* is `F_dG` then waits on FS-105's second mind — the owner's call. |
| 9 | fence leaks: `MEMORY.md` points every agent at the handoff; a memory file states the chain | **adopted** in both briefs (explicit override) |
| 10 | fence the proofs and J21-MX's proof until stage 3 | **adopted**; the list of fenced files is in the briefs |

The advisor's probabilities (its message): at ℚ(√635087), given MR — survives 0.85, named GAP 0.10, FALSE 0.02, in print 0.03; MR at degree 16
a gap 0.15.

## Stage 5 — SAVED

## Stage 6 — SAVED: the plan (WORKFLOW 4)

*Solver column: none. Every phase is derivation, reading, PARI of seconds, or the kernel. Staffing is the owner's: at most three agents at
once (the advisor stays through Phase 2). Every phase's checkpoint is its record's SAVED stages (standing rule 2), committed and pushed; the
resume command is "re-launch the job with the same brief; it reads `git log -- <record>` and continues at the first stage not SAVED". A kill
redoes at most the current stage.*

### 6.1 Phases

| phase | who | what | budget; stop rule | record (checkpoint) |
|---|---|---|---|---|
| 0 | this job; FS103-G; FS103-A | §G, §PA.0, §IQ, the claim list; the gate; the advisor's attack | done here; the gate's own brief | this file; `plans/FS103-G-prior-art.md`; `plans/POROS-2026-09-26-fs103-collapse.md` |
| 1a | **V1** (blind) | C-LB6 (both `k`), C-THKDEL, C-EXTk, C-APX, C-MERGE-n, C-CPUP, C-635-F1, C-635-TF, C-dG-F1's assembly; controls CTL-167-4, CTL-dG4, CTL-K-4, CTL-ABS, CTL-Q2; C-FMT (a)–(c) | 250k harness; stop at 230k, finish the current claim, save, report | `plans/FS103-V1-verification.md`; `data/fs103/fs103-v1/`; `tools/fs103_v1_*.py` |
| 1b | **V2** (blind; in parallel with V1, or after the gate frees a slot) | **C-LB6 at `k = 6` blind** (the second derivation), C-635-PL, C-635-THK, C-dG-PL, C-131, C-dG-THK, C-MR16, C-S, C-F1-GEN's scope; controls CTL-K7-6, CTL-K5-5, CTL-167-5; C-FMT (d)–(f) | 250k; the same stop rule | `plans/FS103-V2-verification.md`; `data/fs103/fs103-v2/`; `tools/fs103_v2_*.py` |
| 2 | the advisor, on the owner's relay | compare the two stage-3 records: agreements, divergences, each typed real gap or statement mismatch (≤ 12 lines) | the advisor's remaining budget | its record |
| 2′ | a third mind, only if C-LB6 diverges | the named step only, blind to both | 150k | `plans/FS103-V3-step.md` |
| 3 | one derivation job + one blind check, after Phase 1, **only if the owner wants item 3 now** (else it folds into FS-104) | where `χ_CP(ℝ²)` sits against `χ_m⁰`, `χ_m`, `χ_B`: C-FMT's verdicts, the gate's reading of `[Falconer1981]` and Shelah–Soifer, and the advisor's weak-* sketch. **Nothing there is stated as held** until two minds agree | 200k each | `plans/FS103-M-derivation.md` |
| 4 | a kernel job (FS-101 slot), **only once V1 and V2 agree on C-LB6, C-THKDEL and one instance's place claims** | the collapse over named hypotheses (6.2) | provisional 1 day; re-priced from its first two leaves (§ What compute helps) | `plans/FS103-K-kernel.md`; builds only through `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh` |
| 5 | the owner | the close, worked from `plans/FS103-close-inventory.md` | — | the plan's §R-close |

**Order inside each verifier** (standard of evidence: the cheapest decisive step first): V1 derives C-LB6 at `k = 6` and C-THKDEL before
anything else, then specialises to `k = 4` (CTL-167-4, CTL-dG4 must agree with the known answers; CTL-K-4 must stop), then the rest. V2 lists
the stable places first (a PARI falsifier in seconds), then derives C-LB6 blind, then C-MR16, then C-S.

**Grading rule** (the owner's): C-LB6 is held only if V1 and V2 derive it blind to each other and to J39's and J48's proofs; a checking reading
of an existing proof is not a second mind (row 117). Any other claim is held at the count of minds its verdicts carry.

### 6.2 The kernel slot, as a statement (Phase 4; elaborated only when Phase 4 opens)

Over named `Prop` hypotheses, never over structures with a possibly empty domain (§ The gate): (i) `MRHyp F`; (ii) `CollapseStep F k` — C-LB6's
conclusion as a proposition ("`F²` `k`-colourable → `UD(ℝ²)` CP-`k`-colourable"), the [hand] step, named; (iii) `CPColourable ℝ² k → ℝ²`
`k`-colourable, **proved** in the kernel if Mathlib's measure theory reaches it (countably many fixed edges, each null; I-CPUP's argument) with
row 78's `forces_iff_exists_finite`-style compactness for `χ(ℝ²)`, else named; (iv) `χ_CP ≤ 7` named or proved by the hexagonal colouring.
Conclusion: `χ(ℝ²) = χ(F²)` and both equal the least `k` with `CPColourable ℝ² k`, at `F = ℚ(√635087)` first. No `RealAlgebraicDescent`
(G63). The vacuity gate needs an inhabitant of the CP structure: the randomly translated seven-colouring.

### 6.3 Registered expectations (G21: both outcomes reachable; how each is read)

| # | expectation | P (mine) | reading of each outcome |
|---|---|---|---|
| E1 | C-LB6 at `k = 6`: both verifiers TRUE, blind | 0.70 | TRUE/TRUE → [hand, two blind] and F1 at ℚ(√635087) given MR. GAP at a named step 0.22 (joint measurability / the selection's format 0.08; C-APX 0.04; C-EXTk at `k` colours 0.04; other 0.06) → Phase 2′ on that step; F1 stays a candidate. FALSE 0.03 → F1 dead as stated, the counterexample names the step. MISSTATED with the result intact 0.05. |
| E2 | the place lists confirm the stub and G43 (no stable place below 103 at ℚ(√635087), below 131 at `F_dG`) | 0.95 | a stable place below either bound (0.05) → `N₆` recomputed; the instance may change |
| E3 | C-131's exact `max|λ|/132 < 1/5` | 0.99 | ≥ 1/5 would contradict Weil: a tool defect first |
| E4 | C-MR16 TRUE at one mind | 0.75 | GAP (0.25; the advisor 0.15) → `F_dG`'s F1 waits on FS-105; ℚ(√635087)'s does not |
| E5 | no bound on `χ_CP(ℝ²)` outside `[5, 7]` from this milestone | 0.97 | a bound would be FS-104's result arriving early |
| E6 | C-FMT: (a) TRUE 0.85; (c) TRUE 0.45 / GAP 0.50; (d) GAP 0.90 | — | (c) TRUE → F1 reads `χ(ℝ²) = χ_m⁰(ℝ²)` given MR (the problem it collapses to); (d) TRUE → `= χ_m`, Falconer's number |
| E7 | C-S (b)–(d): MISSTATED in some part (the "finite family" or the scope over all subfields) | 0.60 | the exact form replaces R1's text in FS-62's stub |
| E8 | C-F1-GEN: the stub's text MISSTATED (scope); the totally real scope TRUE given inputs | 0.85; 0.70 | the correction goes to `CLAUDE.md`'s rank-1 row and the stub at the close |
| E9 | the gate: F1 or `χ = χ_m` in print 0.05; `χ = χ_m` stated open in print (Soifer; Shelah–Soifer) 0.80 | — | in print → attribution; stated open → the write-up Kooshi named |
| E10 | every control behaves as the claim list states | 0.85 | a control that misbehaves (0.15) is read first as a mis-stated control (G21: which half produced it), then as a finding |

*Killing tests carried from the stub:* a step of T-J39-3's forward direction that fails with `N_k(F) = ∅` over infinitely many thick places
at `k = 6`; a stable place of `F_dG` with `λ* ≥ 1/5`; the claim in print. *Added:* a verifier's derivation that also runs on CTL-ABS.

### 6.4 Proposed edits (for the close; I edit none of these files)

1. The stub and `CLAUDE.md`'s rank-1 row: "at a real field" → "at a totally real field outside row 100's exception with `N₆ = ∅`" (Q4).
2. The stub's "no instance has exercised it": the shape (`N_k = ∅`, infinitely many thick places) was exercised at `k = 4` over ℚ(√167)
   (row 123's second route; J48-N4cor); `k = 6` is new only in its threshold.
3. The stub's and the rank-1 row's "`χ_CP ≤ χ_m`": no derivation on record; it is C-FMT (e), open unless Phase 3 or F1 supplies it.
4. `CLAUDE.md` § The mission is silent on Kooshi's "only 4-quadratic field": the record's other rank-4 fields and the second collapse field
   `K(√5,√7,√247)` (§1.2), if the owner wants them recorded.

### 6.5 Would-have-searched-here log

- None. No step of this plan would have used a finite-witness search; the stable-place lists and the spectrum at 131 are PARI and exact
  arithmetic of seconds, left to the verifiers as checks of derived claims.

## Stage 6 — SAVED
