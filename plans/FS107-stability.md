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

- (none yet)

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
