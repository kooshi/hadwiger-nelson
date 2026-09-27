# FS-107 — stability: can vanishing holes save a colour? (the milestone plan; job FS107-P)

*Written by the milestone planner FS107-P (de Bruijn, Opus 5.5), 2026-09-27, under `data/fs107/briefs/P107-planner.md` and
`data/fs107/briefs/STANDING-RULES.md`. WORKFLOW 2.0 steps 3–4: §G (the re-grokking), §PA (the prior-art gate), §IQ (the invariant question),
then the fixed claim list (`data/fs107/claims.md`) and the plan with its briefs (`data/fs107/briefs/`). The advisor is FS107-A (Poros); its
record is `plans/POROS-2026-09-27-fs107-stability.md`. Every disagreement with it is recorded here with my decision.*

**The question, in one paragraph.** FS-106 proved, at two minds with the second blind (`LEDGER.md` row 131; `plans/FS106-derivation.md`
FS106-EQ), that with no MR and no Voronov `χ_m⁰(ℝ²) ≤ 6` exactly when, for every `δ > 0`, some band `[1 − ε, 1 + ε]` admits a periodic partial
six-colouring by half-open grid squares with no monochromatic pair in the band and at most `δ` of the plane uncovered. So `χ_m⁰(ℝ²) ≥ 7` is a
**stability** statement: the uncovered fraction of band-proper six-colourings stays bounded below as the band closes. Competitor **R** proves
it (then `χ(ℝ²) = 7` given MR); competitor **W** builds the near-colourings (then `χ(ℝ²) ≤ 6` with no MR). Both outcomes decide the problem; a
named obstruction on either side is a result.

## Theorems this phase proved

None. This is a planning job: it states claims and derives none of R's or W's mathematics (the brief's rule).

## Would-have-searched-here log (standing rule 3)

- §PA: an OpenAlex cross-check of the citing lists (not a search for a witness; skipped for budget, named as a debt in §PA row 7).
- Planning: none — the planner derives no mathematics; W's route is fixed to formula-and-check in its brief.

## Stage 1 — SAVED: quotation check (standing rule 5) and the files opened

Every quotation in the brief and the standing rules, checked against its source on disk (`CLAUDE.md` read from disk at HEAD `62a50bf5`; the
copy loaded into my context predates FS-106's close and was not used for any statement below).

| # | quotation or statement in the brief | source | result |
|---|---|---|---|
| Q1 | "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim | **verbatim**, the quote's first two sentences (the source continues "(Anything we do must be formalized in Lean before publishing, …)") |
| Q2 | "Let's see some ambition. I know we can do it." | `CLAUDE.md` § Counter-priors | **verbatim**, first two sentences |
| Q3 | "From here on out, you may doubt your ability … Don't. You are capable, and you will surprise yourself." (standing rule 0) | § Counter-priors | **verbatim** |
| Q4 | "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" (rule 3) | `CLAUDE.md` § Toolchain | **verbatim** |
| Q5 | "search for a finite graph is out" (brief, rule 3) | `CLAUDE.md` § Publication | **verbatim** prefix of "search for a finite graph is out. It would be huge, not feasible." |
| Q6 | "A proven theorem about why its impossible is also valid. All novel knowledge is a success." (rule 4) | `CLAUDE.md` Frontier item 23 | **verbatim** |
| Q7 | "FS-106 proved TQ-EQ at two minds, one of them blind" | `plans/FS106-derivation.md` FS106-EQ: "[hand; two minds, one blind: TQ, QB by a different route at (c) ⟹ (a); (a) ⟺ (b) is row 130's]" | **faithful** |
| Q8 | the brief's TQ-EQ sentence ("`χ_m⁰(ℝ²) ≤ 6` exactly when, for every `δ > 0`, there are `ε > 0` and a periodic partial six-colouring …") | TQ §3.5 (e) | **faithful paraphrase** (not in quotation marks); the claim list quotes (e) verbatim |
| Q9 | "The one-way hard step needs no MR and no Voronov." | FS106-EQ "with no MR and no Voronov" | **faithful** |
| Q10 | R: "C-Q-STAB in its exact disc form. Some radius `R` and some `δ₀ > 0` work for every `ε`." | A2 §3.3; TQ §4.5 item 2 | **faithful** |
| Q11 | "A2's §3.4 constraint table, each constraint with its object … and its grade as FS-106's close left it" | A2 §3.4 against `plans/FS106-derivation.md` §4 | **A2's table predates the close in four rows**: the floor (A2 `ε²/78`, one mind → close `ε²/(6+ε)²`, two minds, conditional on V-1.3), "not hitting form" (A2 spacing `1/2`, density `4ε`, one mind → close spacing 2, density `ε`, two minds), "no multichromatic coloured point" (A2 one mind → close FS106-PIX two minds, one blind), the ceiling (C-Q-LOCAL: A2 one mind → close two minds over Parts [external]). The claim list quotes A2's rows verbatim and gives the close's statement and grade beside each |
| Q12 | "FS-106 close inventory item 66: Bachoc, Oliveira, Vallentin, DeCorte, Ambrus and others" | `plans/FS106-close-inventory.md` item 66 | item 66 names no authors ("the `m₁(ℝ²)` literature (the density-of-sets-avoiding-distance-1 papers)"); **the names are the brief's gloss**, harmless |
| Q13 | "item 5/82 (rows 5–63 of the ranking keep six-framed bearings)" (the owner's message) | inventory item 5: "Rows 4–62 of the ranking" | **off by one** — the ranks shifted when FS-107 took rank 1; not mine to schedule (the brief) |
| Q14 | "G21, G30, G51, G60, G72, G79 and row 129 will bear." | — | a prediction by the owner; scored in §G |
| Q15 | "TQ-HIT and the pixel lemma say what it cannot be: no hitting-form count, and no trichromatic *coloured* point." | FS106-HIT, FS106-PIX | **faithful** |

**Files opened:** `plans/FS107-stability.md` (this record), `plans/FS107-close-inventory.md` (empty, FS-106's header; the owner writes it from
now on), `data/fs107/fs107-p/`.

*Budget note, stated in the headline's scope (G21):* `LEDGER.md` is 443 kB. I read rows 128–132 in full and every other row's headline
(the bold sentence) and mechanism clause by extraction, not every row's full text; §G part 2 says which rows were read in full.

## Stage 2a — SAVED: §G part 1, the grokkings G1–G82 (WORKFLOW 3.1; read from `CLAUDE.md` on disk at `62a50bf5`)

*Objects (named once, used below): **SEQ**, the sequence object — periodic grid-square partial six-colourings with slack `ε_n → 0` and holes
`δ_n → 0` (A2 §3.2); **LIM**, the limit object — W's Route II limit, a tight a.e.-proper six-colouring in D-NF. Phases: **R** (stability, on SEQ
= R-Q or on LIM = R-S), **W** (near-colourings on SEQ), **A** (the advisor), **V** (the blind verifier), **D** (the post-ban joint dial, FS-109).
Verdicts: **bears** (and the phase it changes), **silent** (why), **falsifiable here** (registered in stage 5). "Tight" in this milestone is
D-SLACK's (no band avoided), never G54's Hoffman sense.*

| G | verdict | reason; phase |
|---|---|---|
| G1 | silent | the field wall is arithmetic; FS-107 lives in `ℝ²` after row 128, where every place mixes |
| G2 | silent | rings about rotation centres read finite witnesses; W builds periodic tilings, not witness graphs |
| G3 | silent | radii/angles of finite witnesses |
| G4 | silent | the seam-shell inventory of finite forcers |
| G5 | silent | 1-sums of finite graphs |
| G6 | silent | containment of certified finite objects |
| G7 | silent | the type-M rotation family is arithmetic; W's tilings are archimedean |
| G8 | silent | direction words of finite graphs |
| G9 | silent | compulsions of held finite witnesses |
| G10 | **bears** | "expect no organ": the top-rung forcing is distributed — R's defect must be spread (PIX, G82); R brief: do not hunt a local organ |
| G11 | silent | Moser-free finite forcers |
| G12 | silent | cross-edge conics of detuned copies |
| G13 | **bears** | the fan at density level is FS106-REM's kept point: its unit annulus omits its colour — R's basic local tool on SEQ; its k-set warning (coverage is invisible to pair counts) bears on PD-EQ's pair form: R brief, the pair form may need a k-set upgrade |
| G14 | silent | matchings between finite copies |
| G15 | **bears** | pigeonhole × kill: Voronov's proof is a trichromatic-point pigeonhole plus kills; PIX excises the pigeonhole's points from SEQ, so R must relocate the pigeonhole to the holes or to the limit (TS's C-T-PIG/C-T-KILL split already did this on LIM); R brief |
| G16 | silent | the residue distance-2 pigeonhole over `K` |
| G17 | **bears** | "globality lives only at the top rung": R's disc radius `R` is the carrier size of a top-rung compulsion; expect local lemmas (islands, HOLE-t, REM) to have small carriers and the stability step to be global (S–V Question 1's minimum area); R brief |
| G18 | silent | composition of solver cubes — search is out |
| G19 | silent | class sweeps on wall-broken fabric |
| G20 | **bears** | brick/hexagonal 7-colourings: R's killing test 2 (the seven-colour control, "name where six is spent"); W's checker uses the exact closed band, never strict separation (a boundary-tight tile is refused by strict tests) |
| G21 | **bears** (named) | W's check "no monochromatic square pair with distance interval meeting the band" is the exact condition (necessary and sufficient for the grid member); every R verdict audited at the flattering rate; a list of exceptions (C-T-TAN's) measures its class; A, V |
| G22 | **bears** | a six-colouring has non-polygonal classes finer than 1/2: W's members are polygonal only because of their holes, so the limit's non-polygonality (C-AE-POLY) must be carried by the holes' arrangement; W brief |
| G23 | **bears** | refining the scale saves no colour: a W family's grid scale `h → 0` is not a driving parameter (W killing test 4); W brief |
| G24 | **bears** (named via row 129) | the step to seven is integrality; `µ₆⁰`'s fractional relaxation is 1 — R's argument must be integral; R brief, claims constraint "integrality" |
| G25 | silent | a reading about finite forcers' kill cost |
| G26 | silent | finite gadgets at `√3` and 2 — search is out |
| G27 | silent | Galois automorphisms of finite graphs |
| G28 | silent | class sweeps on the fine tail |
| G29 | **bears** | cell-constant colourings need seven at every scale (rows 34–41): W's members are cell-constant partial colourings, so all their escape is in the holes (EPS2's floor is this at positive `ε`); row 41's limit lemma is R's finite-graph shadow, closed by Kooshi's ruling; W, R briefs |
| G30 | **bears** (named) | the dial (D) generates, derivation decides; the discipline ladder's next room is geometric measure theory (density topology, De Giorgi, Rajchman measures) and robust circle topology — §PA's second discipline; R's route |
| G31 | silent | top-rung compulsions of held finite objects |
| G32 | silent | `{1, d}` finite distance graphs |
| G33 | silent | descent growth |
| G34 | silent | in-field descents |
| G35 | silent | 2-adic wall |
| G36 | silent | residue colouring on `K`-stages |
| G37 | silent | finite descent endgame |
| G38 | silent | linear colourings stop below seven |
| G39 | silent | critical sets of finite forcers |
| G40 | **bears** | absorption: a spare colour carries no compulsion — the free colour on the holes is a spare colour, which is why holes break Voronov locally (HOLE-t is absorption at positive width); R must show absorption costs measure bounded below; R brief |
| G41 | silent | additive colourings |
| G42 | silent | additive rigidity |
| G43 | silent | residue sealing |
| G44 | silent | finite-plane spectra |
| G45 | silent | lifting residue configurations |
| G46 | **bears** (method) | name the object in its home disciplines — "what fraction of the plane can `k` colours cover avoiding a distance" (Croft, Pritikin, Parts) and "forbidden distance intervals" (Exoo, Currie–Eggleton, Voronov), and sets avoiding distances in GMT (Falconer, Bukh, BDOV) — §PA's queries |
| G47 | silent | residue-allowed distances |
| G48 | **falsifiable here** | the conjecture's bold form `χ(ℝ²) = 7`: R's success is it given MR; W's success refutes it with no MR |
| G49 | **bears** (method) | §PA: the poser's citing works (S–V §9's; Pritikin's "what percent"), zbMATH author listings (Parts, Voronov, Sokolov, Pritikin, Croft), the question as well as the method |
| G50 | **bears** (method) | grep `BIBLIOGRAPHY.md` before calling a paper unheld (`[Parts2020c]` was listed unheld while held, FS-106); held-but-unread papers touching the question block the opening (§PA) |
| G51 | **bears** (named) | the protocol: R, W, an advisor, a blind verifier; count retractions from the pre-round-1 "name the other's failing step" |
| G52 | silent | wall-breaking rotations |
| G53 | **bears** | the counting-compulsion shape ("at least `L` of `n` points share a colour") has a measure analogue — a fraction of each kept point's unit circle forced into holes — one candidate form of R's non-hitting count; R brief, as a shape |
| G54 | silent | Hoffman tightness of residue planes; its word "tight" clashes with D-SLACK's — the briefs say which sense |
| G55 | silent | unit-vector ring arithmetic |
| G56 | silent | the finite window for six |
| G57 | silent | triangle-free window fields |
| G58 | **bears** (weak) | a central-symmetry ansatz `z ↦ −z` up to a colour involution fixing a colour halves W's design space; an ansatz, never a constraint; W brief |
| G59 | silent | finite planes' independence numbers |
| G60 | **bears** (named) | one-class-at-a-time arguments cap below 4.37 (row 129): R's proof must read how classes fit together; W's class density `≤ m₁(ℝ²) ≤ 0.2470` |
| G61 | silent | three colours over quadratic fields |
| G62 | silent | coincidence rotations of finite witnesses |
| G63 | silent | transcendental extensions |
| G64 | **bears** (wording) | "six is skipped" is not evidence for seven; keep W's five-colour and six-colour outcomes apart; every brief |
| G65 | silent | solver phase diagrams — search is out |
| G66 | silent | residue towers |
| G67 | **bears** (method) | this §G extracts Do lines; any grokking the close mints from FS-107 carries trigger, Do and killing test |
| G68 | **bears** | a periodic colouring is a colouring of the finite quotient (the torus `ℝ²/Lℤ²`): W's exact check runs on one period cell with its periodic images, and one proper period cell certifies the whole member; W brief, the checker's shape |
| G69 | silent | lattice rigidity over fields |
| G70 | silent | √3-clean colourings over `K` |
| G71 | **bears** | Voronov's index is `K₃`'s height on a density trace; its bound fails only at a swap, forced at a unit-arc interface facing a bowtie (IND-X): R-S's no-swap lemma ([G4]); on SEQ the swap cannot occur (grid boundaries) — R brief |
| G72 | **bears** (named) | §IQ; and A2's rule "once an equivalent form is on the table, rank every special case below it" (FS-106's miss) — R-S's steps are special cases' tools, ranked below the equivalence |
| G73 | **bears** | each no-go is for its format: a certificate of stability must be averaged, non-local or structure-derived (PIX and HIT kill point-local and hitting formats); R brief |
| G74 | silent | layers of field unit vectors |
| G75 | **bears** | a local forbidden pattern linear on the simplex embedding, read spectrally: PD-EQ's `⟨g, g ⋆ ν_ε⟩` is that quadratic form on `L^∞(ℝ², Δ₆)`; R's spectral route; R brief |
| G76 | silent | four-colour rigidity over fields |
| G77 | silent | character colourings of field planes |
| G78 | silent | rank-one shifts on `ℤ` |
| G79 | **bears** (named) | the walls arrived as counterexample invariants (HIT, PIX, C5, IND-X); the flip is an invariant every near-colouring carries — the weak-* limit, the islands, PD-EQ's pair fraction; §IQ; record G79 at the close |
| G80 | silent | MR's group growth — used only through "given MR" |
| G81 | **bears** (frame) | given MR the plane is ℚ(√635087)'s field: R's theorem is `χ(ℝ²) = 7`; nothing field-specific is spent |
| G82 | **bears** (central) + **falsifiable here** | pose as stability, build on regular objects, test a stability proof against strips and erosion first (R killing tests 3, 1); its reading dies by a feature-local proof of `lim µ₆(ε) < 1` — registered |

**The owner's prediction (Q14) scored:** G21, G30, G51, G60, G72, G79 bear, as predicted; row 129 in part 2. Beyond it: G10, G13, G15, G17,
G20, G22, G23, G24, G29, G40, G46, G48, G49, G50, G53, G58, G64, G67, G68, G71, G73, G75, G81, G82 — 24 more.

## Stage 2b — SAVED: §G part 2 (rows 1–132; the method rules) and part 3 (the extraction)

### §G part 2a — `LEDGER.md` rows (§ A read from disk: rows 128–132 in full; every other row's headline sentence by extraction)

*One line per row. "Finite", "field" and "search" name the three reasons most rows are silent: the row is about finite unit-distance graphs
(FS-107's objects are measurable and periodic colourings of `ℝ²`), about the arithmetic of a field's plane (exhausted by row 128 given MR), or
about a search instrument (out under the ban and, for finite graphs, beyond it).*

| row | verdict | reason; phase |
|---|---|---|
| 1 | **bears** | exact-distance two-circle systems 3-colour: R-S's C-T-BIKE (three colours on the tight bicycle, by arcs) |
| 2 | silent | seam identity (field) |
| 3 | silent | coverage ratchet on finite graphs |
| 4 | **bears** | fan ⟺ compulsory coverage: the measure fan at a kept point (G13); R |
| 5 | silent | class-only graphs (finite) |
| 6 | silent | 120° triangle identity (finite) |
| 7 | silent | greedy colouring |
| 8 | silent | de Grey's balanced colouring (finite) |
| 9 | silent | two-circle compulsion (finite) |
| 10 | silent | one-pivot cap (finite) |
| 11 | silent | strip automaton (finite) |
| 12 | silent | extension profile (search) |
| 13 | silent | negative knowledge of a hunt (search) |
| 14 | silent | pair-gluing (finite) |
| 15 | silent | extension pressure (search) |
| 16 | silent | coupled automaton (field) |
| 17 | silent | gluing classification (finite) |
| 18 | silent | near-relation (field) |
| 19 | silent | kill mechanism (search) |
| 20 | silent | pivot-triangle layer (finite) |
| 21 | silent | registered statistics (search) |
| 22 | silent | ladder pair (finite) |
| 23 | silent | four-ladder object (finite) |
| 24 | silent | hexagram (finite) |
| 25 | silent | field-wall identity (field) |
| 26 | silent | de Grey anatomy (finite) |
| 27 | silent | quadrature law (finite) |
| 28 | silent | 2-adic kill engine (field) |
| 29 | silent | stacking law (finite) |
| 30 | silent | mechanism hunt (finite) |
| 31 | silent | Act One carriers (finite) |
| 32 | silent | hex-shell pigeonhole (finite gadgets) |
| 33 | **bears** | the classical interval: the slack brick/hexagonal 7-colouring is R's seven-colour control, and `check_pos` (an exact certificate for a periodic colouring) is the template of W's exact checker |
| 34 | **bears** | coset colourings need seven: W's periodic members escape only through holes (with G29) |
| 35 | **bears** | cell-constant colourings need seven at `1/2 < p < 1`: same, W |
| 36 | **bears** | scale is not monotone: refining is no driving parameter (G23); W |
| 37 | silent | gap atlas (finite graphs per band) |
| 38 | silent | gradient hunt (finite) |
| 39 | silent | gap atlas, kernel side (finite) |
| 40 | silent | fine tail — discharged by V-1.3 at FS-106 |
| 41 | **bears** (frame) | the limit lemma is R's finite-graph shadow — bounded non-colourable graphs near the band for every `ε` give seven; closed as a route by "search for a finite graph is out"; R brief names it only as the shadow |
| 42 | silent | arity floor (finite) |
| 43 | silent | de Grey's bracket (finite) |
| 44 | silent | two-distance dial (finite) |
| 45 | silent | batch descent (finite) |
| 46 | silent | copy unions (finite) |
| 47 | silent | M53 residue colouring (field) |
| 48 | silent | critical sets (finite) |
| 49 | silent | absorption, the finite form — its measure form is G40's bearing |
| 50 | silent | additive yardstick (field) |
| 51 | silent | additive rigidity (field) |
| 52 | silent | finite-plane bound (field) |
| 53 | silent | field sieve (field) |
| 54 | silent | the lift (field) |
| 55 | silent | residue obstruction (field) |
| 56 | silent | local–global tightness (field) |
| 57 | silent | Theorems A, B (field) |
| 58 | silent | Moser recipe threshold (finite) |
| 59 | silent | 2-adic law over `K` (field) |
| 60 | silent | plane freedom (field) |
| 61 | silent | six-target statements (finite gadgets) |
| 62 | silent | overcompression (finite) |
| 63 | silent | inertia two-colouring (field) |
| 64 | silent | ρ₆₃ arena (finite) |
| 65 | silent | Parts's coordinate shape (finite) |
| 66 | silent | fan gap over sealed fields (field) |
| 67 | silent | 2-adic tower (field) |
| 68 | silent | six refused at 83 (finite plane) |
| 69 | silent | the window (finite planes) |
| 70 | silent | five refused at 27 (finite plane) |
| 71 | silent | fractional colourings over number fields — its measurable form is row 129's |
| 72 | silent | 3-adic barrier (field) |
| 73 | silent | quadratic fields needing four (field) |
| 74 | silent | census of quadratic fields (field) |
| 75 | silent | residue tower (field) |
| 76 | silent | five over ℚ(√3,√5) (field) |
| 77 | silent | the theorem audit (method, done) |
| 78 | silent | de Grey's lattice at four (field) |
| 79 | silent | three colours linear — its index reading is G71's bearing |
| 80 | silent | four colours cell by cell — its format rule is G73's bearing |
| 81 | silent | ℚ(√167) at four (field) |
| 82 | silent | three colours at `1/3 ∈ ℤ[U_F]` (field) |
| 83 | silent | census completed (field) |
| 84 | silent | four-colour calibration (search) |
| 85 | silent | de Grey's lattice derived (field) |
| 86 | silent | rigidity without triangles (field/abstract) |
| 87 | silent | what does not reach `8Λ` (field) |
| 88 | silent | type-(B) frame (field) |
| 89 | silent | four-colourings over `K` (field) |
| 90 | silent | `ℚ₂(√3)` rigid (field) |
| 91 | silent | non-periodic constructions impossible (field) |
| 92 | silent | measurable windows over S2 (field) |
| 93 | silent | dyadic towers (field) |
| 94 | silent | ℚ(√11) non-periodic (field) |
| 95 | silent | rational band rigidity (field characters) |
| 96 | silent | HD1 (field) |
| 97 | silent | one prime not enough (field) |
| 98 | silent | band rigidity (field) |
| 99 | silent | three colours local–global (field) |
| 100 | silent | CLG (field) |
| 101 | silent | character chromatic numbers (finite planes) |
| 102 | silent | one prime fails (field) |
| 103 | silent | chain theorem (field, kernel) |
| 104 | silent | transcendence free (field) |
| 105 | silent | prime inversion (field) |
| 106 | silent | stripe lemma (triangular lattice) |
| 107 | silent | the bridge (field ↔ `ℝ`), superseded given MR by row 128 |
| 108 | silent | rank-one inheritance (shifts) |
| 109 | silent | mixing selection (field) |
| 110 | silent | windows at five over ℚ(√167) (field) |
| 111 | silent | invariant measures and transience (field) |
| 112 | silent | Theorem C (field) |
| 113 | silent | ℚ(√47) spectra (field) |
| 114 | silent | gap-free products (finite) |
| 115 | silent | mixing pins products (finite) |
| 116 | silent | Kronecker selection (field) |
| 117 | silent | T-C(A)'s class (field) |
| 118 | silent | rank one of selection (field) |
| 119 | silent | ℚ(√167) ≥ 4 in the kernel (field) |
| 120 | **bears** (frame) | MR: R's theorem gives `χ(ℝ²) = 7` only given MR; W needs none |
| 121 | silent | ℚ(√47) = 5 (field) |
| 122 | silent | other routes to MR (field) |
| 123 | silent | main clause through five (field) |
| 124 | silent | type-(B) given MR (field) |
| 125 | silent | six at ℚ(√167) (field + `χ_CP`) — FS-104/FS-59's |
| 126 | silent | TR-ROT (field) |
| 127 | **bears** | the Lean lane (FS-101): whichever half lands goes there with no declared purchases; the plan names its Lean slot |
| 128 | **bears** (frame) | given MR, `χ(ℝ²) = χ_CP(ℝ²)` at ℚ(√635087): R's theorem is Hadwiger–Nelson given MR |
| 129 | **bears** (named) | one class at a time caps below 4.37; `µ₆⁰`'s fractional relaxation is 1; class density `≤ m₁(ℝ²) ≤ 0.2470` — constraints for both sides |
| 130 | **bears** | `χ_CP = χ_m⁰` and the Rajchman weak-* step: FS106-EQ's (a) ⟺ (b), PD-EQ's ⟸ (continuity in probability); the compactness step's prior art is §PA's debt |
| 131 | **bears** (central) | the equivalence, the floor, the ceiling, HIT, PIX: the claim list's §1 and §2 |
| 132 | **bears** | the regular half as constraints on LIM: C-AE-SLACK (the limit is tight), C-AE-POLY, C-AE-NICE; R-S's named steps [G1]–[G4], IND, IND-X |

### §G part 2b — the method rules (`CLAUDE.md` § The standard of evidence, § What compute actually helps, § Toolchain, § Building, § Searching, § The gate, § Make the gate fail; § Counter-priors; § Delegation)

| rule | verdict | reason; phase |
|---|---|---|
| Counter-priors 1–4 | **bears** | every brief: rank by bearing; expectations are instruments; "say what it would take and start"; no grade moves |
| Delegation, one level deep | **bears** | every brief, with the reason |
| No native evaluation in the headline | **bears** | W's exact check is tools-grade; the headline needs the kernel before publication (FS-101 slot) |
| The artifact is the certificate plus the checker | **bears** | W: a member is its formula, its rational data and `tools/fs107_w_*` checker output; never a search |
| The witness must be re-derivable | **bears** | W states the construction (formula and parameter), not coordinates alone |
| Read the final statement aloud | **bears** | the claim list; V reads R's or W's final statement against row 131 |
| Report the hunt honestly | **bears** | the would-have-searched log in every brief |
| Write the certificate for the reviewer early | **bears** | W writes the checker's input format at stage 1; R writes what a reviewer must check at its first stage |
| Order a verification by marginal value | **bears** | V's brief: the load-bearing step first |
| Kernel leaves priced high | silent | no kernel phase in FS-107 proper |
| Compute table (Lean, CDCL, GPU) | silent | no solver; exact arithmetic of seconds only |
| The ban (§ Toolchain) and "search for a finite graph is out" | **bears** (named) | W's families by formula; the dial after 2026-10-01 (FS-109) is a trace of given tilings, not a search for a finite graph |
| Symmetry break before SAT | silent | no SAT |
| pysat interrupts; Python 3.14 forkserver; venvs outside `build/` | silent | no solver pools |
| Two machines; predicted beside measured throughput | silent | no heavy compute |
| `scripts/build.sh` only; `lake env lean` is not the gate | silent | no Lean in FS-107's phases |
| Halt on any unexplained crash | **bears** | standing rule 8, every brief |
| RAM is the discriminator; `scripts/slot.py` | **bears** | any exact check over 2 GiB or 2 minutes |
| Checkpoint and resume (PROTECTED) | **bears** | D (post-ban) and any W check over 15 minutes: checkpoint path and resume command in the record |
| A blocking run is killable (PROTECTED) | silent | no long runs planned |
| Kill by pid; verify by effect | **bears** | standing rule 8 |
| A pipe can kill the producer | **bears** | W's checker's exit status read directly |
| Never edit a running script; generated modules; kernel cost model | silent | no long scripts, no generated Lean |
| `grep -E` is ugrep; `rg` and `.gitignore`; a failed `exact?` | **bears** (weak) | the claim list's greps use `grep -F` or `rg` |
| Vacuity: every theorem over a structure ships an inhabitant | **bears** | each `∀` claim names an inhabitant: R's "every band-proper partial six-colouring" is inhabited (eroded `[Parts2020c]`); W's (e) members at `δ > δ₆` (FS106-LOCAL) |
| Every gate keeps its output | silent | no gates run |
| Make the gate fail; plant a fault | **bears** | W's checker: a planted monochromatic square pair must fire for its own reason, beside a faithful stub that must pass |
| A positive signal for what did not happen | **bears** | W's checker prints pairs checked and the least slack margin, never a bare "ok" |
| State the uninformative outcome; confirm both outcomes reachable | **bears** | stage 5's expectations |
| Exactly one thing may differ between two compared numbers | **bears** (named at FS-106's close) | R killing test 4: uncovered area over plane area, never band pairs over band — PD-EQ and HIT have different denominators |
| A check reads the value the code ships | **bears** | W's checker reads `ε` and the tiling from the member file, never a copy |
| Bound a plant's effect on both sides | **bears** | W's checker's plant |
| The generator's image; count free parameters | **bears** | W: write the family's generator image and its parameter count against the target (a family whose image misses vanishing holes cannot succeed); R: say which colourings the argument's hypotheses admit |
| A caveat you step over | **bears** | every headline carries its scope (row 131's "moves no value") |
| A true explanation stops the search for a second | **bears** | V: a member that fails one killing test is checked against all four |
| One-sided filters are defeated by inapplicability | **bears** | R: HOLE-t and PIX make hole-reading arguments inapplicable — enumerate the ways to make R's argument inapplicable before the ways to make it fail |
| Enumerate the parameter first | **bears** | W: enumerate the family's parameters (slack, grid, void size) before screening members |
| Scars, not foresight: plant faults routinely | **bears** | W's tools |
| One home per fact; current state only | silent | the planner edits no front-page file |

### §G part 3 — the extraction: each *bears* as an instruction to a phase (carried into stage 5's phase table and the briefs)

| # | from | instruction | phase |
|---|---|---|---|
| X1 | G82, row 131, G21 | Test every stability argument against TQ-HIT's strips and FS106-PIX's erosion **before** writing it out; record the result as the argument's first line | R |
| X2 | G15, G10, G17, G73, G40 | The pigeonhole Voronov reads (a trichromatic point) is excised from SEQ by PIX: say where the argument's pigeonhole lives (in the holes, in the limit, or averaged), what carrier size it has, and why a spare colour on the holes cannot absorb it | R |
| X3 | G13, row 4, G53, G75 | Candidate shapes for a non-hitting count: the measure fan at a kept point; a counting compulsion over each unit circle; PD-EQ's quadratic form `⟨g, g ⋆ ν_ε⟩` on `L^∞(ℝ², Δ₆)` — offered as shapes, never as a route | R |
| X4 | G24, G60, row 129 | The argument must be integral: state the step where the six-colour count enters, and why the same step fails at seven (killing test 2) | R |
| X5 | G71, row 132 | R-S: the no-swap lemma ([G4]) is owed; on SEQ swaps cannot occur (grid boundaries) — say which object each lemma is proved on | R |
| X6 | G72 (A2's rule) | Rank R-S's special cases (Q2, AE-FA) below the equivalence; they are tools, not targets | R, A |
| X7 | G22, G29, rows 34–36, G23 | A W family's members are cell-constant partial colourings: all escape is in the holes; its driving parameter is not the grid scale | W |
| X8 | G68, row 33, G20, § Make the gate fail | W's checker: one period cell with its images, closed band, exact rational arithmetic (or exact algebraic where a vertex is irrational), a planted pair beside a faithful stub, pairs checked and least margin printed | W |
| X9 | generator-image rule, enumerate-the-parameter rule | W writes its family's generator image and parameter count against TQ-EQ (e) before any member is checked | W |
| X10 | G58 | Central symmetry up to a colour involution fixing a colour, as an optional ansatz | W |
| X11 | row 129, G60 | W's killing test 3: each class's density `≤ 0.2470` | W |
| X12 | G51, protocol §1 | Before round 1 the advisor asks each side to name the other's failing step; retractions are counted from there | A |
| X13 | G21, "a true explanation stops the search" | V checks every killing test on a finished result, not only the first that passes or fails; audits a TRUE at a FALSE's rate | V |
| X14 | G46, G49, G50, G30 | §PA in two disciplines' words: partial colourings ("what percent"), forbidden intervals, and GMT of sets avoiding distances | this plan (stage 3) |
| X15 | G48, G81, rows 120, 128 | Register the conjecture's bold form as falsifiable here: W's success refutes `χ(ℝ²) = 7` with no MR | stage 5 |
| X16 | G64 | Keep W's five- and six-colour outcomes apart in every sentence | all briefs |
| X17 | row 127 | A Lean slot: whichever half lands is formalized under FS-101 with no declared purchases; named in the plan, not run in FS-107 | close |
| X18 | row 41, "search for a finite graph is out" | The finite-graph shadow of R is named and closed in the R brief | R |
| X19 | G79, G72 | The close records whether each result came from an example invariant or a counterexample invariant, and whether through the structural question | close |

**The test of the re-grokking (WORKFLOW 3.1 item 3): it changed the plan.** X1 puts the strip-and-erosion test before any R write-up (the
design had it as a killing test after); X2 makes "where does the pigeonhole live" R's first question; X8–X9 fix W's checker shape and its
generator-image statement before any member exists; X6 ranks R-S's steps below the equivalence.

## Stage 3 — SAVED: §PA (the prior-art gate) and §IQ (the invariant question)

### §PA — searched 2026-09-27 by the planner (zbMATH Open API for discovery; Semantic Scholar citing lists; arXiv API abstracts; held PDFs by `pdftotext`)

**The recognition sentence (G46), used as the query.** FS-107's object lives in three literatures that cite one another thinly: (i) **almost
colourings** — "how much of the plane needs to be removed before the remainder can be colored with six colors" (Croft 1967 for one colour;
`[Pritikin1998]`; `[Parts2020c]`; `[MundingerEtAl2025]` "Variant 1"); (ii) **chromatic numbers with a forbidden distance interval** (`[Exoo2005]`,
`[CurrieEggleton2016]`, `[ChybowskaSokol2022]`, `[Parts2023]`, `[Voronov2023]`, `[SokolovVoronov2025]`); (iii) **densities of measurable sets
avoiding distances**, harmonic analysis and GMT (`[Falconer1981]`, `[Bukh2008]`, `[OliveiraVallentin2010]`, `[BachocEtAl2014]`, `[KMOR2016]`,
`[DeCorteOliveiraVallentin2022]`, `[AmbrusEtAl2023]`). `µ₆(ε)` is (i)'s quantity in (ii)'s setting; row 131's weak-* step is (iii)'s tool.

| # | question (WORKFLOW 3.2) | what was done | finding |
|---|---|---|---|
| 1 | the discipline's words | the three vocabularies above; zbMATH `ab:avoiding & ab:distance & ab:density & cc:52C10`, `ab:forbidden interval & ab:plane & ab:color*` | (iii) returns Bukh 2007/2008, Bachoc–Passuello–Thiery 2015, KMOR 2016, DOV 2022; (ii) returns only S–V among on-topic items (the rest are proceedings volumes) |
| 2 | two disciplines | (i)×(ii) and (ii)×(iii) | **PA-1:** `[DeCorteOliveiraVallentin2022]` §6.1 Lemma 6.2, held, read (§6.1 in full): "If D ⊆ (0, ∞) is bounded, then lim sup_{L→∞} α_vol(G(Rⁿ/LZⁿ, D))/vol(Rⁿ/LZⁿ) = α_δ̄(G(Rⁿ, D))" — periodic sets approximate the independence density, for every bounded `D`, the band included; "very similar to the proof" for sphere packings. **This is the one-class form of FS106-SUP's "`µ₆^per(ε) = µ₆(ε)` at each `ε`"**, in print since 2018 (arXiv) — a re-attribution for the close (credit: DOV for one class; the six-class form and the tight–slack equality `µ₆⁰ = lim µ₆(ε)` not found). Its Lemma 6.1 ("`G(Rⁿ/LZⁿ, D)` is locally independent for every `L > 2 sup D`", `D` closed and bounded) is W's torus in their words (G68) |
| 3 | the question, not only the method | Pritikin, Parts, Mundinger's "Variant 1", S–V §9 re-read through FS-106's records | **The quantitative question is posed in print** (`[Parts2020c]`'s title; `[MundingerEtAl2025]` §1: "A natural question concerns how much of the plane needs to be removed before the remainder can be colored with six colors"); S–V §9 poses one direction as a conditional. **Whether the removed fraction can tend to 0 with the slack — "`µ₆(ε) → 1`?" or its dual `µ₆⁰ = 1` — is not found posed**, nor its equivalence with `χ_m⁰` (row 131's gate agrees) |
| 4 | outside arXiv | zbMATH author listings; Geombinatorics | Croft 1967 (*Eureka* 30) is in no index (the density `0.22936`, one colour); Hoffman–Soifer 1993, "Almost chromatic number of the plane" (Geombinatorics 3(2)), is by `[MundingerEtAl2025]`'s text the off-diagonal variant (a sixth colour at another distance), not holes — **title only, unheld**; `[Townsend2005]` unheld (FS-106 item 59) |
| 5 | the poser's citation graph | Semantic Scholar citing lists of `[Voronov2023]`, `[SokolovVoronov2025]`, `[Parts2020c]`, `[Parts2023]` | Voronov: the five FS-106 found (S–V; 2512.15516; 2404.11454; 2302.09972; 2208.02230), none with a stability form; S–V: one (2512.15516, Ramsey, listing only); **Parts2020c: four — S–V, `[MundingerEtAl2025]`, `[Mundinger2024]`, `[ChybowskaSokol2022]`**; Parts2023: Voronov |
| 6 | open every neighbouring citing work | **`[MundingerEtAl2025]` fetched** (`~/source/library/pdf/arXiv-2501.18527-mundinger-neural-discovery-colored-planes.pdf`); read §1's "Variant 1" paragraph, §4.1 with Table 1, App. B's pipeline paragraph | **PA-2:** machine-found, "rigorously verified" periodic almost six-colourings of the plane, piecewise constant on sub-parallelogram cells, removing **0.04 %** (numerics 0.03 %; Parts 0.02 %); five colours 3.74 %. These are W's object class at a fixed `δ ≈ 4·10⁻⁴` (closed cells with no unit pair are band-proper for some `ε > 0` by compactness) — **with no driving parameter and no `ε → 0` question**. Their cell constraint is built from "the cells that intersect with unit circles at the corners of c_base" — whether that is the exact condition for whole cells is not checked here (G21): W's checker must use each cell pair's exact distance interval. A search pipeline (neural, then a minimum edge cover): out under the ban and never W's route |
| 7 | two databases | Semantic Scholar only | **not run in OpenAlex** — a debt, named (G49's "one database's zero") |
| 8 | full author listings, the question in their words, zbMATH | Voronov (15 items), Parts (12), Pritikin (34), Croft (30) | Voronov: nothing new on topic beyond `[DidinVoronov2026]` (dense colour classes, 12 colours; known) and S–V; Parts: `[Parts2022]` ("in a certain sense, the chromatic number of the plane is exactly 7": `χ(d) = 7` in the first island, a wide band — not stability), `[Parts2021]` multi-fold; Pritikin: only 1998 on topic; Croft: Croft–Falconer 1981, *On maximal Euclidean sets avoiding certain distance configurations* (Zbl 0494.52008) — **unheld**, one-class densities; `[Bukh2008]`'s review names Falconer–Marstrand 1986 and Furstenberg–Katznelson–Weiss 1990 — compactness methods for distance-avoiding sets, **unheld** |

**What the gate changes in the plan.** (a) W's checker: exact cell-pair distance intervals, stated as the point where `[MundingerEtAl2025]`'s
corner-circle construction may be only sufficient (X8 sharpened). (b) The close gets a re-attribution for FS106-SUP's periodic half
(DOV Lemma 6.2, one class). (c) R's brief names the (iii) literature's compactness tools (Bukh; Falconer–Marstrand; FKW) as the discipline where a
non-local count might already live — reading, not a route. (d) The quantitative question is in print, the vanishing question is not: FS-107's
question is new as posed (not found in print), its quantity old.

**Papers still needed (for the report):** `[Bukh2008]` (GAFA 18, 668–697); Croft–Falconer 1981 (Zbl 0494.52008); Falconer–Marstrand 1986 (Bull. LMS
18, 471–474); Croft 1967 (*Eureka* 30); Hoffman–Soifer 1993 (Geombinatorics 3(2)); `[Townsend2005]`. **Proposed `BIBLIOGRAPHY.md` edits:**
`[MundingerEtAl2025]` → held at the path above, read: §1 Variant 1, §4.1 Table 1, App. B (pipeline paragraph) (FS107-P); `[DeCorteOliveiraVallentin2022]`
→ add "§6.1 (Lemmas 6.1–6.2) read (FS107-P)" and the re-attribution; new listing rows for Croft–Falconer 1981 and Hoffman–Soifer 1993.

### §IQ — the invariant question (WORKFLOW 3.3)

1. **The existence form.** R: is there a proof that every band-proper partial six-colouring of some disc `U_R` leaves `δ₀|U_R|` uncovered? W: is
   there a periodic grid-square family with slack whose holes vanish?
2. **The structural form.** *What does every band-proper partial six-colouring carry, uniformly in `ε`, that ties its uncovered measure to its
   geometry?* — about every such colouring, with the arithmetic already gone (row 128), in the most general class: measurable partial `k`-colourings
   of `ℝ²` with a band, `k` a parameter (at `k = 7` the invariant must be trivial, the hexagonal control).
3. **The invariant it forces.** None known — finding it is the milestone. FS-106 says what it cannot be: not a hitting count (FS106-HIT: capped at
   `ε`), not a coloured point feature (FS106-PIX), not one class's density (row 129: capped below 4.37), not anything a spare colour absorbs at
   a local repair (A8b: `O(ε²)`). **Candidates named, none a route:** (a) PD-EQ's pair fraction `p_f(ε)` — an example invariant every CP colouring
   drives to 0 (A2 §2.2, sketch); (b) the junction-type structure every tiling member carries — which multicolours meet at its vertices and how
   close complementary types sit (C-T-TAN, the advisor's C6), readable exactly on SEQ; (c) the void at a junction — C-VOID's `ρ₀` (the advisor's
   card; claim list); (d) the index of density traces along complementary curves (FS106-IND), exact on SEQ where no swap occurs.
4. **Its route.** Derivation only; W's exact checks verify a given member, never search.
5. **The open instances it would decide.** `χ_m⁰(ℝ²) ≥ 7` (row 131); given MR, `χ(ℝ²) = 7` (row 128); S–V's Question 1 in stability form (the
   least disc radius); C-AE-CLOSED; C-AE-Q2 and AE-FA (special cases); FS-104's `χ_CP(ℝ²) ≥ 6` at `k = 5` by the same invariant with five colours.

## Stage 4 — SAVED: the fixed claim list (`data/fs107/claims.md`) and the advisor's first advice

**The list.** §0 definitions (quoted); §1 H-EQ (held), **R** (C-Q-STAB, exact disc form), **R′** (C-VOID, sufficient only), **R″** (the `ε²` → `ε`
rung), **W** (TQ-EQ (e)); §2 the twelve shared constraints of A2 §3.4 verbatim, each with its object and the close's statement and grade (four rows
changed: K-FLOOR, K-CEIL, K-PIX, K-HIT), plus K-C6, K-BICH, K-AD (a reading), K-KILL, K-CHR4; §3 the killing tests (A2's eight, the pinhole test
added); §4 the break table verbatim with its row-2 annotation; §5 R-S's named steps on LIM; §6 held GAPs, not assigned. Quotations spot-checked by
`grep -F` against the sources (14 of 14 found).

**The advisor's advice (FS107-A, two messages, 2026-09-27) and my decisions.**

| # | advice | decision | why |
|---|---|---|---|
| 1 | A2's break row 2 and the advisor brief misattribute `O(ε²)` to C-Q-LOCAL; it is A8b | **adopted** — row quoted verbatim, annotated | a quotation is kept verbatim; its source corrected beside it (standing rule 5) |
| 2 | fences for R, W, V by path: transcripts, `chats-bak/`, scratchpad files not created, the advisor's record and `data/fs107/fs107-a/`, the other side's scratch, the close inventory, `git log` | **adopted** (also the owner's ruling, inventory item 4) | protocol §1 rule 1 |
| 3 | a pinhole test for R (A8b's form); AD as the law behind the three no-go tests | **adopted**: pinhole as R's killing test 5; AD as K-AD, **graded a [reading]** with a killing test of my wording | AD is derived at one mind by interpolating TQ §4.4's dichotomy; its universal quantifier over "arguments" makes it a reading, like FS106-HIT's scope |
| 4 | shared facts C6, BICH; C-T-KILL's split and C-T-CHR4's GAP beside C-T-TAN | **adopted** as K-C6, K-BICH, K-KILL, K-CHR4 | trivial and one mind, but they turn LIM's exceptional set into junction types W's checker can read |
| 5 | W's checker also prints the junction types present, the least distance between complementary types, and between equal types in `(1, 2)` | **adopted** into W's brief | a check of a given object; it feeds the break table's rows 3–4 |
| 6 | name C-VOID as R's intermediate claim | **adopted** as R′, **with the note that it is sufficient only** and that a W family with vanishing hole inradius at bounded coverage refutes C-VOID and decides nothing | both outcomes reachable; it gives R a local-in-anchor target and W a non-decisive rung |

No disagreement so far; the one amendment is the grade of AD (the advisor wrote "[derived, one mind]"; the list carries it as a reading — recorded
here as a disagreement of grade, mine governing).

**The advisor's review of the list (FS107-A, second message) and my decisions:** (1) K-AD split — (a) the no-go for the named form [hand, one mind],
(b) the two-doors sentence [reading] — **adopted**, which settles the grade disagreement above by splitting it; (2) "junction type" undefined on SEQ —
**adopted** as D-JUNC (`r_J = h`, stated in each member file); (3) W's check certifies members, the family is a derivation — **adopted** in W's killing
test 1 and W's brief; (4) a known positive for W's checker (the slack hexagonal 7-colouring minus one class, `δ = 1/7`, rasterized; a planted pair
rejected) — **adopted** as W's stage-1 control, Parts as the optional second; (5) C-VOID's exact form beside the card, and the note corrected ("refutes
C-VOID whatever its coverage") — **adopted**; (6) the §PA findings as shared prior art — **adopted** in the SHARED brief. No disagreement left.

## Stage 5 — SAVED: the plan (WORKFLOW 4) and the briefs

### 5.1 Phases

| phase | who | object | budget (harness) | stop rule | checkpoint and resume |
|---|---|---|---|---|---|
| P0 launch | owner | — | — | R, W and the competition advisor launched together (three agents) | briefs in `data/fs107/briefs/` |
| R | FS107-R (`R107-stability.md` + SHARED) | SEQ or LIM, per lemma | ~400k, replace before 500k | stages 1–5 of its brief; a held result stops it at stage 4 | its record `plans/FS107-R-stability.md`, a SAVED heading per stage; resume at the first stage not SAVED |
| W | FS107-W (`W107-near-colourings.md` + SHARED) | SEQ | ~400k, replace before 500k | stages 1–5; the checker's plant must fire before any member is checked | `plans/FS107-W-near-colourings.md`, member files in `data/fs107/fs107-w/`; same resume rule |
| A | FS107-A continuing or FS107-A2 (`A107b-advisor-competition.md`) | both | ~400k | at both hand-backs | its record; competition notes in its scratch until hand-back |
| V | FS107-V (`V107-blind-verifier.md`) | the first finished side | ~300k | its stage 3 verdicts committed, then stage 4 | `plans/FS107-V-verification.md` |
| D | FS-109, the joint dial (post-ban, owner's to schedule) | SEQ | — | — | `plans/STUB-hole-dial.md` |
| close | a close planner | — | — | WORKFLOW 9 from `plans/FS107-close-inventory.md` | — |

**What a kill redoes:** one stage of one agent (every stage is committed). No phase runs a computation over two minutes except W's and V's exact
checks, which run under `scripts/slot.py` when they exceed 2 GiB or 2 minutes and checkpoint per member.

### 5.2 Decisions (four parts each)

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| A2's split: R stability, W near-colourings, one advisor, a blind verifier on the first finished side | (B) TS's split — R closes [G1]–[G3], W builds a six-coloured map with unit arcs | both outcomes of the split decide the problem (R given MR; W with no MR), and W's objects are checkable; (B)'s W is strictly narrower and its R not decisive (A2 §3.7) | high |
| One SHARED brief both competitors read, plus a short role brief each | two self-contained briefs | "identical mathematics" is then true by construction and checkable by diff; the role briefs differ only in the question, the object, the stages and the fence | high |
| Competitors' records in `plans/` and `data/fs107/fs107-{r,w}/`, committed per stage, fenced by path with a grep-exclusion rule | records in each side's scratch until hand-back (protocol §1 rule 1's "never in `plans/`") | standing rule 2's per-stage commits make a crash cost one stage; the owner already ruled the same shape for the advisor's record (inventory item 4); the residual risk is an accidental grep, which the SHARED fence names | **medium** — the owner may prefer scratch-until-hand-back; the fact that would change it is a fence touch in the first round |
| W's known positive: the slack hexagonal 7-colouring minus one class | Parts's eroded tiling as the only control | the hexagonal positive is exact, rational after rasterization and has a known answer; Parts's data are external and reconstructed | high |
| The blind verifier takes the finished side's slot | a fourth agent | the cap is three agents, all Opus 5.5 (Kooshi) | high |
| No persona preambles (protocol §1 rule 2's option) | a preamble per competitor | a default, not a decision: the option is the owner's | — (default taken) |

### 5.3 Registered expectations (instruments for G21, scored at the close; per the counter-priors, never caps)

| # | outcome | probability | both sides reachable, and why |
|---|---|---|---|
| E1 | R proves C-Q-STAB (claim R), at one mind, held | 0.10 | reachable: no theorem forbids a non-local count; its negation is reachable too (W's family) |
| E2 | R proves C-VOID (R′) | 0.05 | C-VOID is stronger than R; refutable by a shrinking-inradius family |
| E3 | W builds a family meeting claim W, at one mind, held | 0.07 | reachable: nothing proven excludes vanishing holes (the floor tends to 0); its negation is R |
| E4 | R names an obstruction beyond HIT, PIX and the pinhole test — a theorem that a named class of arguments cannot give stability | 0.45 | the no-go shape has fired three times at FS-106; it could fail to fire if R's first route meets no class-level wall |
| E5 | W names an obstruction — a lower bound on the void for a named class of families | 0.40 | the break table's row 3 names it; it fails if W's families shrink their voids |
| E6 | a W family refutes C-VOID (hole inradius → 0 at bounded coverage loss), deciding nothing | 0.30 | Parts-type voids at junctions may cusp or migrate; it fails if every family keeps a void of fixed size |
| E7 | R″: a lower bound of order `ε` on `1 − µ₆(ε)` | 0.20 | hitting form is allowed there; K-AD (b) predicts it needs curves of anchors |
| E8 | the first break happens where A2's table puts it: R at the anchor step, W at the junction void (FS107-A's stage-1 expectation) | 0.50 | the break table's rows 2–3 |

**Falsifiable here** (from §G): G82's reading dies by a feature-local proof of `lim µ₆(ε) < 1` (0.02); K-AD (b), by an argument with null anchors of
dimension `< 2` certifying hole area bounded below (0.05); the conjecture's bold form `χ(ℝ²) = 7` (G48) dies with no MR by E3.

### 5.4 The ban, the dial and the Lean slot

- **Until 2026-10-01:** W derives families by formula and checks given members exactly; R derives. Nothing else runs.
- **The joint dial after the ban (FS-109; A2 §3.5, TQ §5.4):** it needs (a) `[Parts2020c]`'s tiling reconstructed as exact data (his figures are
  [external]), (b) an exact area routine for eroded tiles with curved sides, (c) for `µ₆^per(ε)` itself, a continuous local optimiser over the
  parameters of a **fixed combinatorial type** at each `ε`, checkpointed per `ε` — a measurement that generates (G30), never a decider, and never a
  search for a finite graph, which Kooshi's ruling keeps out beyond the ban.
- **Lean (row 127; never a cost):** whichever half lands is formalized under FS-101 after row 130's M1 and FS106-EQ enter the kernel, with no declared
  purchases. Named here, not run in FS-107.

### 5.5 Carry-over from FS-106's close (`plans/FS106-close-inventory.md`)

- items 5/82 — the ranking rows keep six-framed bearings (the owner's message says rows 5–63; item 5 says rows 4–62): a ranking pass the owner
  schedules, not this plan's;
- items 36, 57 — FS-108 (`plans/STUB-regular-half-residuals.md`): SV-1's fills under Condition 6, SV-2's `d = 2`, Woodall's merge;
- item 59 — `[Townsend2005]` unheld (requested);
- item 66 — the compactness/Rajchman step's prior art: **partly paid by §PA** (DOV 2022 Lemma 6.2, one class, periodic approximation); the Rajchman
  step itself not found in print; Bukh 2008 and Falconer–Marstrand 1986 unheld;
- item 83 — `tools/fs71_ledger_b_check.py`'s nested-bracket grammar (a tool defect, open).

### 5.6 Proposed edits for the close (I edit none of these files)

- `BIBLIOGRAPHY.md`: `[MundingerEtAl2025]` held (`~/source/library/pdf/arXiv-2501.18527-mundinger-neural-discovery-colored-planes.pdf`), read: §1
  "Variant 1", §4.1 with Table 1, App. B's pipeline paragraph; `[DeCorteOliveiraVallentin2022]` §6.1 (Lemmas 6.1–6.2) read; listing rows for Croft–Falconer
  1981 (Zbl 0494.52008), Hoffman–Soifer 1993 (Geombinatorics 3(2)), Falconer–Marstrand 1986 (Zbl 0599.28008).
- `LEDGER.md` row 131's prior-art clause: FS106-SUP's "`µ₆^per(ε) = µ₆(ε)`" has its one-class form in `[DeCorteOliveiraVallentin2022]` Lemma 6.2.
- `plans/FRONTIER-STUBS.md`: FS-107's row points to this plan.

### 5.7 Briefs drafted (for the owner to launch)

`data/fs107/briefs/SHARED-107-competition.md` (both competitors, identical), `R107-stability.md`, `W107-near-colourings.md`,
`A107b-advisor-competition.md` (the competition-phase advisor's hand-over), `V107-blind-verifier.md` (instance block for the owner).

---

## §R-close — the close (job FS107-C, de Bruijn, Opus 5.5, 2026-09-27; brief `data/fs107/briefs/C107-close-math.md`)

*Worked from `plans/FS107-close-inventory.md` items 1–34. Every number below is read from the named record, never from the inventory. Minds are
counted as derivations; "blind" means the mind had not read the other's derivation before its own verdict was committed (V: stage 3 `abcb19ac`
before R's record; VW: stage 3 `ef9e955a` before W's record). No children were started.*

## §R-close stage 1 — SAVED: reconciliation

### 1.0 Quotation check (standing rule 5) of the brief and the launch message

| # | quoted | source | result |
|---|---|---|---|
| Q1 | the FS-110 question (brief, unquoted): "does a tight six-map exist whose complementary vertex pairs within distance 2 are all tangent pairs or bowties? YES is `χ(ℝ²) ≤ 6` with no MR; NO answers S–V Question 2 almost everywhere" | A2 §5.1: "NO ⟹ door (A) is dead at every `K` and C-AE-Q2 holds a.e. for locally finite arc-bounded maps; YES ⟹ a candidate door-(A) design, to be eroded and checked exactly"; A2 §5.9: "a YES is decisive (`χ(ℝ²) ≤ 6` with no MR, through W-EQ-K)" | **two questions under one sentence.** §5.1's is the *rule* relaxation (necessary conditions only; YES a candidate); §5.9's reads "tight six-map" as a full a.e.-proper six-colouring by a map, of which the rule is a necessary condition (W-TAN), so YES is decisive. The brief drops §5.1's "for locally finite arc-bounded maps" and "a candidate". The stub (stage 4) states both forms, Q-full and Q-rule |
| Q2 | launch message: "tangency is no escape at scale `s`" (in quotation marks, from item 31) | V §4.3: "**Tangency is not an escape at positive scale**"; "So the exceptional set is exceptional only in the blow-up; at scale `s` a tangent ring still costs `≳ s²·s′ sin(µ/2)`" | a paraphrase in quotation marks; content kept. The stub quotes V |
| Q3 | brief: G82's "feature-local" → "a defect at an `ε`-independent scale" | A2 §5.8: "a stability proof must count a defect at a scale independent of `ε` — spread over positive measure, or at features whose own scale is bounded below" | matches |
| Q4 | item 16's CP line (R's theorem line, verbatim) | R ll. 9–12 against R §3.2 | the theorem line omits §3.2's "`s, s′ ≤ s₀(µ, η)`" (`s₀ = µη²/100`), "`2r < t₁`, `2r′ < t₁′`" and the definition of blocking — V §4.1 found it; confirmed here |
| Q5 | item 20's W-TAN line | W l. 19: "complementary-type vertices at distance `< 2` are tangent pairs or bowties" | matches |
| Q6 | item 2 (A's slip) | FS107-A record l. 37: "C-Q-LOCAL (local repairs cost `O(ε²)`)" … "**MISATTRIBUTED**, and inherited" (A8b, `plans/POROS-2026-09-26-fs106-regular-half.md` l. 242) | confirmed |
| Q7 | item 21 (the W brief's slip) | W l. 40: brief "a corner-circle rule is only sufficient"; the plan §PA row 6 "whether that is the exact condition for whole cells is not checked here", `claims.md` "may be only sufficient" | confirmed: "is only" for "may be only" |

### 1.1 R's statements (competitor R; blind verifier V)

| statement | R | V (blind to R until stage 3 `abcb19ac`) | divergence and how it was settled | reconciled verdict; minds |
|---|---|---|---|---|
| **FS107-R-SAT** | TRUE [hand] §3.1 | TRUE, needs `ε > 0` (`g_j = 1_{C_j} ∗ 1_{A_ε}` continuous) §2.4 | none; same proof | **TRUE** (`ε > 0`); two minds, one blind |
| **FS107-R-CP** | TRUE [hand] §3.2, Claims 1–2 (exact ray–circle quadratic; a box pulled back) | stage 3: the quoted line **MISSTATED** (C1: `µ = 20°`, `s = 0.33`, holes `2.165·10⁻⁴` against the line's `3.277·10⁻⁴`); own V-CP proved by projection with curvature bookkeeping; stage 4: R's §3.2 checked line by line, correct with one harmless slip (`ρ ≥ t(1 − t/2)`, not `ρ ≥ t`) | **of statement, not of truth**: C1 is outside R's hypotheses twice (it does not block with margin 20° in R's arc sense; `s = 0.33 > µη²/100`). Settled by V §4.2: under R's definitions the constant holds with room (`37×` the bound at `s = 0.001`) | **TRUE under R §3.2's hypotheses**; two minds, different routes, one blind (R; V), [hand] with V's float check. The one-line form is not self-contained (item 32) |
| **V-CP** | — | TRUE with `s, s′ ≤ min(sin(µ/2), sin θ/18)` and projection fatness; FALSE for unrestricted `s` (C1, float, grid-converged) | — | one mind (V) |
| **RR**: (A) ∧ (B) ⟹ R, given CP | a [reading] §3.4; "R, and a C-VOID disc"; "R′ … with it" | TRUE after two repairs (the disc in `U_{R+1+µ/4}`; (B)'s voids relative to `min(s, µη²/100)`); ⟹ C-VOID **GAP** (the branch "holes `≥ δ`" gives no disc) | **R′ divergence**: R concluded R′ ("GAP, same steps"), V showed the implication to R′ fails; settled by V's argument (R did not reply; R had stood down). Scope repair of (B): one symbol `s₀` was a lower bound in (B) and an upper bound in CP | the implication **TRUE after two repairs**, two minds, one blind; (A), (A″) and (B) **open**; RR ⟹ R′ **GAP** (one mind, V) |
| **FS107-R-SW**, `εs` part | `≥ εs`, sharp for one colour, pointwise on SEQ (`ε ≤ s/2`, `s ≤ 1/10`) | `≥ 2ε√(s² − ε²)`, sharp at `2εs`, a.e. fibre argument (measurable classes too) | none; routes differ | **TRUE**; two minds, one blind |
| **FS107-R-SW**, `s³` part | [sketch]: strips of total width `≳ s²/2 + ε` | **proved**: `\|H ∩ (B(p,s) ∪ B(q,s))\| ≥ s³/256` for `s ≤ 1/2`, `ε ≤ s²/32`, every hole set (double count of band pairs) [hand + tools for two inequalities] | none; V's covers all hole shapes, R's priced strips | **TRUE**; the proof one mind (V, blind), R's strips-only sketch agreeing |
| **FS107-R-OB′** | "an argument that reads, at a swap, only the pairs of one colour is capped at `O(ε·s)` per swap … Stability must read both colours at a swap" | **MISSTATED**: TRUE for the away-facing colour (`2εs(1 + o(1))`); FALSE for the facing colour, whose pairs alone certify `s³/256` | **divergence of truth**, settled by V's `s³` proof: "must read both colours" is false at a flat swap | **FALSE as stated; TRUE corrected** (away-facing colour only), one mind (V) |
| R's retraction 2 (draft Theorem OB) | withdrawn before commit | — | — | recorded (R §3.4) |
| C-T-BIKE | the pure `π/3`-arc ansatz fails narrowly at `d = 1.9` (58.4°, 59.3° against `> 60°`), two windows | — | — | not decided; hand arithmetic, one mind |
| **V's C5** | — | tangent ring junctions still force holes at positive scale: `6.8·10⁻⁵` at `s = 0.1` against an exactly tangent interface; general claim a sketch | not in R's record (R lists tangency among W's escapes) | [tools, one instance, and a sketch], one mind — a candidate (§4.3) |

### 1.2 W's statements (competitor W; blind verifier VW)

| statement | W | VW (blind to W until stage 3 `ef9e955a`) | divergence and how it was settled | reconciled verdict; minds |
|---|---|---|---|---|
| **W-EQ-K** | [hand] §2.2: at bounded arc complexity `K`, band-proper designs with `ε_n, δ_n → 0` ⟺ a full tight a.e.-proper six-colouring by tiles of complexity `≤ K` (⟸ with `δ = O(ε)`) | TRUE under (Cu) (at most `K` arcs per unit disc), GAP under (Ct) (per-tile count); ⟸ at `≤ 2K` | **two steps W does not write**, both closed by VW §4 item 2: ⟸ lands at complexity `O(K)` (reflex corners cut by chords), and the non-periodic limit is periodised by a seam strip of width `1 + ε`, cost `O(1/L)`; (Ct)'s GAP does not bear on W's class `𝓜_K` | **TRUE at `𝓜_K`, ⟸ at `O(K)` with a seam strip**; two minds, one blind; routes differ (W: compact tile parameters, TQ §3.3's maximal inequality; VW: arcs and faces, a weighted average) |
| **W-POLY** | [hand, over AE-POLY] §2.3 | TRUE over AE-POLY and W-EQ-K ⟹ | none | **TRUE** bar `d = 2`; two minds, one blind; over FS106-AE-POLY |
| **W-RATE** | [hand] §2.4, opening "Let `M` be a full tight colouring as in 2.2" | TRUE with hypotheses explicit; MISSTATED bare; the pinhole clause a reading | **of the table line only** (VW §4 item 3): the hypothesis is W's text, missing from its table | **TRUE** at `𝓜_K`; two minds, one blind; the pinhole clause a [reading] |
| **W-TAN** | [derived, over C-T-TAN] §2.5: "For a map every vertex is a cone point (strong blow-ups hold)" | first clause TRUE for C¹ arcs with tangents at vertices, types as essential multicolours; **GAP at cusp vertices** (a zero-angle tile: its colour has density 0, `\|P(u)\| = 2`, C-T-TAN silent); general Jordan boundaries GAP; second clause MISSTATED (bichromatic vertices of degree `≥ 4` have two-element types) | **divergence of truth at cusps**, settled for VW: "a cusp is a cone point whose tile has angle 0" (VW §4 item 4); the second clause restricted to trichromatic vertices (true for trivalent maps); the Jordan gap outside `𝓜_K` | **first clause TRUE over C-T-TAN off cusps; GAP at cusp vertices; second clause TRUE for three-element types, off `d = 2`**; two minds, one blind; [derived] over C-T-TAN (one mind, TS) |
| **HX-STALL** | [hand, one mind; four members exact] §3.3–3.5; the other pairs "checked at members" | **TRUE and stronger**: pair 2 implies every other same-colour class for every parameter; `δ = (2π/(21√3))(ρ/R)²`, the conditions force `ρ/R > 1/2`, `inf δ = π/(42√3)` attained by no member | none in truth; VW's is stronger; nits: the null form allows equality where W writes `>`; the stall is an infimum | **TRUE, every parameter**; two minds, one blind; [hand and tools, exact in ℚ(√3)]; members re-checked by two independent checkers |
| **W-CHK, W-HEX** | [tools, exact] | six given members re-checked by VW's own reader and checker; all verdicts, slacks, densities agree | none | [tools, exact], two independent checkers |
| **VW-GRID** | — | an independent exact checker (half-open squares, Fractions, a Hermite torus); rasterised hex7 − 1 blank density `2513/17655` (centre rasterisation; W's `1/7` is a coset rasterisation, both exact for their constructions) | none | [tools, exact] |
| W's P-W1, P-W2 | lost (a first-order estimate; the collinear corner for the 120° one) | — | caught by W's own checker | recorded |

### 1.3 The advisors' results and the meeting point

| statement | minds | status |
|---|---|---|
| **K-C6** (disjoint three-sets = complementary, six colours) | FS107-A, [hand, trivial] | TRUE; one mind; CP is its metric content (R stage 4) |
| **K-BICH** (a six-colour map has a trichromatic vertex) | FS107-A, [hand] | TRUE; one mind |
| **K-AD** (a) the named-form no-go; (b) "two doors" | FS107-A; credit TQ §4.4 | (a) [hand, one mind]; (b) [reading], **consistent** with CP: CP's holes are door 2, `ε`-independent size (R stage 4); not fired |
| **A2 X1** (split by complexity; bounded limits are regular by compactness) | A2 sketch, then R and W at their registrations | three independent derivations of the split (A2 §5.2); proved as W-EQ-K; its "polygonal limits out" half is W-POLY |
| **The meeting point** (A2 §5.1): RR's (A)/(B) ⟷ W's doors (A)/(B); W-TAN ≡ CP on LIM | [derived], one mind (A2), its parts now two minds each | a synthesis; both halves rest on C-T-TAN, whose cone case now has three derivations: TS; R (sighted of TS); V (blind to R, read TS) |
| A2's two divergences of scope (§5.3): W §1.3 (2) against CP; W-TAN's range (`< 2`) against CP's (`[η, 2 − η]`) | A2 | none of truth; pairs near distance 0 and 2 are covered by W-TAN and by neither side's cost |

**Divergences of truth in the milestone: three**, every one found by a blind mind and settled by derivation: OB′ (V), RR ⟹ R′ (V), W-TAN at cusps
and at two-element types (VW). **None between the competitors** (A2 §5.3). Three statement-level corrections (the CP line, W-EQ-K's complexity, the
W-RATE and W-TAN table lines). Retractions (A2 §5.5, from the registrations on): R 2, W 1, A2 0 (one hunch killed); FS107-A 0; V and VW 0.

## §R-close stage 2 — SAVED: `plans/FS107-derivation.md` (commit `18d3a50e`)

Nineteen entries in FS-106's form (§1 R's side with V: SAT, CP, V-CP, RR, SW, OB′ corrected, V-C5; §2 W's side with VW: W-EQ-K with VW-ERODE and
VW-CPT, W-POLY, W-RATE with VW-PIN, W-TAN, HX-STALL, the tools; §3 K-C6, K-BICH, K-AD, MEET; §4 the DOV re-attribution). Grades carry no nested
brackets. Kernel: two stubs (FS107-R-CP and FS107-W-EQ-K, to FS-101 when their half lands, X17); every other entry declined with its reason.

## §R-close stage 3 — SAVED: the §G re-read, the §PA sweep, the §IQ re-read, the predictions, the verdict

### 3.1 §G re-read (WORKFLOW 9): which extractions paid

| X | paid? | how |
|---|---|---|
| X1 strip-and-erosion first | **paid** | R ran the five killing tests on its shape before any proof (R §2.2); V and VW ran them on finished statements (V §2.1). R's retraction 2 (Theorem OB) was the same discipline turned on its own draft |
| X2 where the pigeonhole lives | **paid** | R §2.3: the pigeonhole lives at the complementary pair, not in the holes; the free colour cannot absorb a forced region of area `≍ ss′` |
| X3 non-hitting shapes | unused | neither side took PD-EQ's quadratic form or the measure fan |
| X4 integrality | **paid** | six enters through K-C6 (disjoint triples are complementary only at six); CP is its metric content |
| X5 object labels | **paid** | every R lemma labelled SEQ, LIM or both; SW's `εs` is SEQ-pointwise in R, a.e. in V |
| X6 special cases below the equivalence | held | R-S's Question 2 steps stayed tools; W-EQ-K made C-AE-Q2 an equivalent at bounded complexity, which is why FS-110 now leads |
| X7 driving parameter ≠ grid scale | **paid** | HX's parameter is the void radius `ρ` |
| X8 the checker's shape, planted pairs | **paid** | W-CHK with three plants; VW's independent checker agreed on all six members |
| X9 generator image first | **paid, most** | W §2.1's image statement produced W-EQ-K directly: the two doors are the image's two complements |
| X10 antipodal ansatz | unused | optional |
| X11 class density | **paid** | W's killing test 3 on HX (W §3.6) |
| X12 the advisor's pre-round question | **paid** | the two registrations bracket (B) exactly (A2 §5.1: "Each is the other's negation") |
| X13 audit TRUE at FALSE's rate | **paid** | V audited SW's `s³`; VW audited HX's "iff for every parameter" symbolically at five values |
| X14 §PA in three vocabularies | **paid** | DOV Lemma 6.2; `[MundingerEtAl2025]` (see 3.2) |
| X15 the bold form falsifiable | not fired | E3 not met |
| X16 five and six apart | kept | — |
| X17 Lean slot | named | two kernel stubs filed (stage 2) |
| X18 finite-graph shadow closed | held | — |
| X19 example/counterexample record | done | 3.3 |

**Misses — entries that should have borne and were not used (each an instance, drafted in stage 4):**
- **M1, G82's own reading** misdirected: the plan carried "R must count a defect non-locally, Voronov's contradiction being feature-local" into the
  briefs, and A2's stage-1 expectation priced a junction as a point (its hunch `r-first-mechanism-is-local-and-pinhole-killed`, killed). FS107-R-CP is
  a feature-local certificate whose cost is `ε`-independent: feature scale is not band scale. Corrected at this close (3.5, stage 4).
- **M2, § Make the gate fail, "exactly ONE thing may differ"**: R's P1 compared `(t₁ − 2r)(t₁′ − 2r′)`, an area, with `δ₆`, a density; V caught it
  (V §4.2: compare with the Parts void, `S∆ ≈ 6.6·10⁻⁵` per cell of area `≈ 0.461`).
- **M3, standing rule 5 / G21 "scope lines do not survive into summaries"**: R's "Theorems this phase proved" line for CP is a compression of §3.2's
  Claim 2 that drops its scale bound, void bound and blocking definition; V's stage-3 MISSTATED was earned by the line, not the lemma. A theorem line is
  a quotation surface (WORKFLOW 7's heading) and must carry its hypotheses.
- **M4, G21 "a list of exceptions measures its class"** (FS-106's bearing for FS-107): FS106-TAN lists C-T-TAN's failures as "cone points (tangent
  interfaces, bowties), and also … cusps and … blow-ups converging only weak-*"; W-TAN took "every vertex a cone point" and missed that a cusp is a cone of
  angle 0 where the multicolour drops to two (VW §4 item 4).

**New grokkings minted at this close:** none; G82's reading is corrected in place (stage 4). **Forward propagation:** G82 (corrected) and G79's
flip (3.3) to FS-110 and FS-111's provisional bearings; G21 (M3, M4) to FS-110's (its rule has exceptional sets); FS-104's null-set step no longer
sits under FS-107 (drafted in stage 4).

### 3.2 §PA sweep — what the gate taught about our own object

1. **`[MundingerEtAl2025]`'s near six-colourings are W-POLY's class** (read with W-POLY, FS107-W-POLY): periodic, piecewise constant on
   sub-parallelogram cells, so polygonal of bounded complexity at fixed resolution — their removed fraction (`0.04 %`) is bounded below at that resolution,
   and only unbounded complexity (door (B), FS-111) or curved tiles (door (A), FS-110) can send it to 0. A recognition for FS-109 and FS-110's stubs.
2. **The periodic-approximation step is the (iii) literature's** (DOV Lemma 6.2, one class): the re-attribution of FS106-SUP's periodic half, drafted
   for row 131 and `BIBLIOGRAPHY.md` (stage 4).
3. **The question as posed is new, the quantity old** (§PA row 3): "`µ₆(ε) → 1`?" not found posed; FS-110's question is S–V's Question 2 at bounded
   complexity with the rule W-TAN attached — its gate is FS-110's own opening.
4. **Hoffman–Soifer 1993's "almost chromatic number" is the off-diagonal variant** (a sixth colour at another distance), by `[MundingerEtAl2025]`'s
   text — a naming hazard for FS-110's gate: "almost" in print is not holes.
5. **Debts carried:** OpenAlex not run; unheld Bukh 2008, Croft–Falconer 1981, Falconer–Marstrand 1986, Croft 1967, Hoffman–Soifer 1993,
   `[Townsend2005]` (inventory item 8) — FS-111's gate needs Bukh and Falconer–Marstrand (compactness for distance-avoiding sets) first.

### 3.3 §IQ re-read; G72's count and G79's record

**§IQ's structural form** — "What does every band-proper partial six-colouring carry, uniformly in `ε`, that ties its uncovered measure to its
geometry?" — answered in part, through **candidate (b)**, "the junction-type structure every tiling member carries — which multicolours meet at its
vertices and how close complementary types sit": CP prices a close complementary pair at area `≍ ss′`, W-TAN says a hole-free limit keeps every close
complementary pair tangent, bowtie or cusp, and the meeting point is that the two are one statement. SAT answers candidate (c)'s setting (the holes are
the open six-sighted set). Candidates (a) (PD-EQ's pair fraction) and (d) (the index) were not used. **The invariant is not found**; FS-110's rule is
where it is sought next.

**G72's count: fourteen of seventeen.** FS-107 counts **through the structural question**: the meeting point and RR came through candidate (b) (R
stage 4: "The reduction RR came through §IQ's structural question … candidate (b), junction types"), and W-TAN is candidate (b) read as a design rule;
W-EQ-K came from X9 (the generator image) and compactness, an extension of a known tool. Mixed, counted through because the product (FS-110's question)
is candidate (b)'s object.

**G79's record for FS-107.** Example invariants: SAT (every saturated colouring carries the open six-sighted hole set); W-EQ-K (every vanishing-holes
family at bounded complexity carries a tight map as its limit). Counterexample invariants: CP, SW, OB′, W-POLY, HX-STALL (what a hole-free family must
avoid). **The flip, once, and it produced the milestone's synthesis:** W-TAN is C-T-TAN's no-go ("a counterexample would need …") read as the rule every
door-(A) solution must carry — exactly G79's *Do* — and it met R's counterexample invariant CP at one object. No breakthrough of either kind; the killing
test did not fire.

### 3.4 E1–E8 and every registered prediction, scored

| # | registered | p | outcome |
|---|---|---|---|
| E1 | R proves C-Q-STAB | 0.10 | not met (GAP at (A)/(A″), (B)) |
| E2 | R proves C-VOID | 0.05 | not met (GAP; RR does not give it, V) |
| E3 | W meets claim W | 0.07 | not met (GAP; HX stalls at `π/(42√3)`) |
| E4 | R names an obstruction beyond HIT, PIX, pinhole | 0.45 | **met, weakly**: OB′, of HIT's logical type — as R stated it FALSE; its corrected form (away-facing colour, V) is the obstruction |
| E5 | W names a void lower bound for a named class | 0.40 | **met**: W-POLY (two minds), HX-STALL (two minds) |
| E6 | a W family refutes C-VOID | 0.30 | not met (untested; HX's voids have radius `≥ 0.22`) |
| E7 | R″, order `ε` | 0.20 | not met (SW gives `≥ εs` per regular swap; forcing a swap is (A) again) |
| E8 | first breaks where A2's table puts them | 0.50 | **half**: W at the junction void, yes; R at the bicycle branch, not the anchor step |
| falsifiable | G82's reading dies by a feature-local proof of `lim µ₆ < 1` | 0.02 | **not fired as worded** (RR is a GAP); **the reading's inference refuted** by CP (a feature-local, `ε`-independent certificate), and R flagged it; corrected |
| falsifiable | K-AD (b) | 0.05 | not fired (CP's holes are door 2) |
| falsifiable | the bold form `χ(ℝ²) = 7` dies with no MR | — | not fired |
| FS107-A | two doors (void conservation or a positive-measure defect) | — | consistent; CP is the void-conservation door in R's form (A2 §5.7: `void-conservation-is-the-crux` supported) |
| FS107-A | round one is about C-VOID | — | **killed** (W's first family aimed at door (A)) |
| FS107-A | `w-first-family-moves-the-void` | — | first half confirmed by derivation (HX: a positive floor); migration not shown |
| FS107-A | `complementary-type-is-the-combinatorial-core` | — | supported (W-TAN ≡ CP) |
| FS107-A | `rq-collapses-to-rs` | — | at risk, not killed |
| A2 | `bounded-complexity-families-keep-their-voids` | — | confirmed as an equivalence (W-EQ-K, now two minds) |
| A2 | `w-first-family-has-bounded-complexity` | — | confirmed (HX) |
| A2 | X2: W breaks at row 3 for a reason of class | — | half: row 3 yes; the reason geometric (K-ISL), not compactness |
| A2 | `r-first-mechanism-is-local-and-pinhole-killed` | — | killed (A2 stage 4) |
| R | W fails first at row 3 | — | confirmed in outcome, mechanism untested |
| R P1 | Parts has no fat complementary pair costing `> δ₆` | 0.9 | unscored ([external] coordinates); **mis-specified** — an area against a density (M2); the comparison is with the void, `≈ 6.6·10⁻⁵` per cell |
| R P2 | every W family with holes `→ 0` has cone scale `→ 0` at complementary pairs | 0.95 | vacuously consistent (HX has no complementary types) |
| R P3 | bicycle-free Voronov (A) false | 0.6 | untested |
| W | C-VOID fails first | — | untested |
| W P-W1, P-W2, P-W3 | HX geometry | — | lost, lost, won (each caught by W's own checker) |
| V | CP MISSTATED at constants 0.25; implication TRUE after repair 0.7; SAT; SW `εs`; SW `s³` 0.65; OB′ MISSTATED 0.5 | — | all met (CP's branch through curvature, not location) |
| VW | HX 0.8; W-EQ-K 0.6; W-RATE 0.7; W-POLY 0.7; W-TAN GAP at cusps or two-colour vertices 0.5 | — | all met; W-TAN's Jordan-boundary gap unregistered |

*Calibration:* the three outcomes registered near one half (E4, E5, E8) landed met, met and half; the five below 0.3 did not land. No expectation
capped an aim (counter-priors rule 2).

### 3.5 The verdict, in four parts

- **The choice:** close FS-107 as **not landed** on all four claims (R, R′, R″ GAP; W GAP), with its product the **meeting point** — RR (two minds),
  W-EQ-K (two minds), FS107-R-CP ≡ W-TAN (two minds each; W-TAN a GAP at cusps) — and the no-gos (W-POLY; OB′ corrected; HX-STALL as a measured fact
  about one family); open **FS-110, the tangency seam**, next (the owner's ruling, item 28), with **FS-111 (REG-SCALE)** minted beside it.
- **The alternative weighed:** a second round inside FS-107 on the same question (A2 §5.9's form) — one reframe cheaper; or REG-SCALE first (A2 §5.9's
  alternative), where R must win in the end.
- **Why this one:** the tangency seam is a new object — maps with tangent, bowtie or cusp seams, where Townsend's ⅔π counterexample already lives —
  that needs its own re-grokking and prior-art gate (item 28); it is local and derivable within the ban; its YES (a full tight map) is decisive with no
  MR through W-EQ-K; its NO answers `[SokolovVoronov2025]` Question 2 almost everywhere for locally finite arc-bounded maps, a question in print; and
  REG-SCALE's escape is the same rule at every scale, so FS-110's answer is REG-SCALE's first lemma either way.
- **Confidence: medium-high.** What would change it: V's C5 proved in general (tangent rings force holes at every positive scale) would narrow FS-110 to
  bowtie and cusp seams — the same milestone, smaller; a hand argument that the rule can be met only by degenerating at every scale would merge FS-110
  into FS-111 and make REG-SCALE the milestone.

**Not landed, said plainly:** no stability theorem, no vanishing-hole family, C-VOID untested, R″ not reached. "All novel knowledge is a success": the
programme now knows exactly which two statements decide it at six colours.

### 3.6 Would have searched here (every job's log)

- P: an OpenAlex cross-check of the citing lists (a debt, §PA row 7); planning none.
- R: an offset scan over `(φ, ψ)` for C-T-BIKE's arc ansatz → two windows by hand at `d = 1.9`, stopped; a numerical optimisation of CP's constants
  against Parts → constants stated, P1 registered.
- W: a greedy fill of the hex member's 351 fillable squares → a diagnostic count only; a scan of HX's `D`, `ρ` or triangle shape → the stall derived
  exactly, four members placed by the derivation.
- V: a scan of CP's failure region over `(s, µ, d, cut angles)` → one derived geometry, its on-axis band in closed form and a six-by-five dial on it;
  colouring Parts's tiling from its figure to scan its complementary pairs → not done, the test run at the level of constants.
- VW: a numerical sweep of HX's optimum → derived (pair 2 minus pair 1 is `6t − 3`); a search for a local cusp counterexample to W-TAN → the step named,
  no counterexample derived (GAP, not FALSE); a better absorption than HX → not its job.
- A, A2, and this close: none.
