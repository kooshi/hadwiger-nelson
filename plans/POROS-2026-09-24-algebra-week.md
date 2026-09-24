# Poros — where an algebra-only week should go (2026-09-24)

Advisor: Poros (Opus 5.5), briefed by the product owner. The question is Kooshi's: after FS-81 closes, no SAT solver for one
week; what should the week be spent on, and how will he know afterwards whether it paid. Sole writer of this file: Poros.

## 0. Expectation, written before reading FS-81's results in detail

Conditions of this writing: I have read the brief, my own standard, and the `CLAUDE.md` snapshot loaded into my context (Frontier
current to FS-79's close and FS-81's choice). I have **seen, not read**, three FS-81 commit subjects in the git status: "all 40
squarefree d ≡ 11 (mod 12) below 500 certified to need four colours; 25 open fields by structural certificates"; "127 lattices at
d = 47 — 102 four-colourable, 25 survivors, the cheapest minimal survivor needs 5.1e7 points"; "the R = 1.4 ball of de Grey's
lattice (30,181 points) plus the edge {0, v} refuses four colours". So the expectation below is not blind to those three lines.

**E1. What the week should aim at.** A derivation, not a certificate: the explanation of a phenomenon the project already holds
by certificate and cannot explain. The strongest candidate I expect from the snapshot is FS-74 (why every four-colouring of de
Grey's lattice is 8Λ-periodic) — it is the one place where four-colour rigidity is *known* to exist and is unexplained, and four
colours is where G71/G73 say the project has no invariant. Second: an algebraic *colouring* construction on the upper side (a
four- or five-colouring of a whole field plane that is local at no prime — FS-64's adelic window colouring, or a non-residue
colouring over ℚ(√167)), because it is the one direction in which a success would falsify the conjecture, and colourings of a
whole plane are constructions, not searches. Third: T4 (every d ≡ 11 mod 12 needs four) as a family theorem, if FS-81's
"structural certificates" have a uniform shape.

**E2. The forks I expect to be real.** (a) Explain a held rigidity (FS-74) versus build a new certificate format at four colours
(FS-80, window frequencies — an LP, so the ban's scope decides whether it is even eligible). (b) Lower side versus upper side: a
proof that some field needs five, against a construction that some field needs fewer than the conjecture predicts. (c) New
mathematics versus kernel ports (FS-45/47/60/75): a kernel port is SAT-free and would make the week look productive while testing
nothing about Kooshi's hypothesis.

**E3. Where I expect the premise to be wrong.**
- *"Never succeeded at a priced attempt outside extensions of K"* — I expect this to be **false at three colours**: FS-58 and FS-61
  refused three colours by SAT over ℚ(√11) and a dozen other real quadratic fields, none of which contains K. I expect it to be
  **true at four colours** (proving χ ≥ 5) outside K's extensions: FS-70 (ℚ(√3,√5)), FS-59/79 (ℚ(√167)), and FS-81's stage D at
  ℚ(√47) all failed to refuse four.
- *"Triangle-free fields make SAT infeasible"* — I expect the **mechanism to be misattributed**: FS-70's failure was over
  ℚ(√3,√5), which contains √3 and so has triangles; the record's own explanation there (G69) is that rigidity and density pull
  apart, not triangle-freeness. I expect the better mechanism to be G72's move 3: a finite refutation must rebuild the lattice's
  symmetry by brute force, and its size explodes wherever the field supplies no small rigid gadget — which triangle-freeness is one
  cause of, not the cause.
- *The frame itself*: I expect the real cut to be **search versus certificate-on-the-symmetry-group**, not SAT versus algebra. The
  record already contains a natural experiment — at three colours FS-73's `Θ₃` (an exact polytope procedure) proved
  χ(ℚ(√167)²) ≥ 4 where FS-61's SAT balls had failed, and FS-81 phase 0 apparently closed 25 fields SAT had left as nulls. So the
  experiment Kooshi proposes has partly been run already, at three colours, and it came out for algebra. The live question is
  whether the same move exists at four colours, where G71/G73 say the loop/edge/face invariants are empty.
- *The risk to the experiment*: a week with SAT banned can still be spent on other searches (MILP, local search, LP feasibility
  hunts) and learn nothing about Kooshi's hypothesis; or on kernel ports and bookkeeping and look productive. I expect the ban's
  informative line to be "no search for a finite witness or colouring", not "no SAT binary".

## 1. The survey (the frame on five axes, from the record)

- **The goal, in the principal's words.** Kooshi, 2026-09-24 (`plans/FS81-close-inventory.md` item 82): *"we have never actually
  succeeded at any 'priced attempt', not since the days where we were working in extensions of K … I think the triangle free fields
  make SAT infeasible … ban SAT solvers for a week and see what we can do on algebra alone."* Standing goals: seven, with the
  local–global conjecture held and "equally happy to be proven wrong" (`CLAUDE.md` § The mission); "the derivations are an order of
  magnitude more important than individual objects" (`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §1).
- **Object.** As Kooshi states it: the instrument (SAT). As the record shows it: four-colour questions over fields whose unit-distance
  graphs have no triangles (no √3), above all ℚ(√47) (exactly five predicted) and ℚ(√167) (at least six predicted).
- **Question.** "What can algebra alone do in a week?" An instrument question, not yet a mathematical one.
- **Discipline.** The last three milestones moved from SAT to symbolic dynamics and character theory (G71–G73, FS-81's layer method).
- **Audience.** Kooshi, deciding one week's work; and, unnoticed until now, a posed open problem (§2, item 12).
- **Product.** Undefined: the brief asks me to define "paid" (§6.4).

## 2. Evidence inventory

- `plans/FS81-derivation.md` T1–T8 — read against: FS-81 landed per-field certificates and perhaps a family — surprised: yes; T5 proves χ(ℚ(√d)²) ≥ 4 for **every** squarefree d ≡ 11 (mod 12) at [hand, two independent derivations], plus a new field ℚ(√2,√7), and T7 decides three-colourability of every real quadratic plane; the milestone's instance question was answered by a field-level derivation, not by the per-field runs
- `data/fs81/records/phase-P0.md` §6 — read against: `Θ₃` trees (an exact search) decide the 25 open fields — surprised: yes; the relation tree was **priced out** (ℚ(√35): UNDECIDED at 835,827 nodes in 30 min), and a certificate derived from T8's mechanism decided each field in about a second; the search that lost here was not SAT, it was a branch-and-bound tree
- `data/fs81/records/phase-D.md` D1, D2 — read against: ℚ(√47) at four colours is expensive but priceable — surprised: yes; the price cannot even be formed: the cheapest minimal survivor Λ₂₄₀ needs ≈ 5.1·10⁷ points at the refusal degree d* = 18.41, **1,284 times** de Grey's lattice's refusing ball (39,829), and every ball small enough to build sits in the undecided band (d_ball 8.3–14.7)
- `data/fs81/records/phase-D.md` D0b item 3 — read against: pins are a constant factor — surprised: no; the triangle pin is worth 5.4× at the refusal threshold and ℚ(√47) (ω = 2) cannot use it
- `data/fs81/records/phase-D.md` D0a/D2 covolumes — read against: the gap is proof-system hardness — surprised: yes; the gap is the object's size: covolume ≈ 1.25·10⁻³ (de Grey's lattice) against 2.27·10⁻⁷ (Λ₂₄₀ over ℚ(√47)) and 8.6·10⁻⁸ (L21cc6506 over ℚ(√167)); a perfect solver would face the same ball
- `CLAUDE.md` Frontier items 14, 18, 22 and `CLOSED-QUESTIONS.md` §3 — read against: every four-colour refusal or forced pair the project owns lies in a field containing K — surprised: no; the fields known here to need five are all of degree 8 and contain K; FS-70 (ℚ(√3,√5)), FS-59/79 (ℚ(√167)) and FS-81 D (ℚ(√47)) did not land
- `data/fs61/census.md` via Frontier item 14 and G65 — read against: SAT failed in triangle-free fields — surprised: yes; **at three colours SAT succeeded there**: 15 real quadratic fields (none contains √3) refused three colours, up to 2,360 points, five of them after FS-61's priced re-aim at degree 14
- `BIBLIOGRAPHY.md` `[Voronov2021]`, `[Soifer2024]` ch. 54 as relayed — read against: no SAT success at four colours outside K anywhere — surprised: yes; Voronov et al.'s 64,513-vertex and Heule's 1,441-vertex five-chromatic graphs lie in ℚ(√2,√3,√5)² (no √11), and Heule's T721 is a four-colour forced pair in ℚ(√2,√3)², all SAT-found; every one contains √3
- FS-70 record via G69 — read against: triangles are the whole mechanism — surprised: yes; ℚ(√3,√5) has triangles and failed too (rigidity and density pull apart: its one candidate lattice is dense only from ~10⁷ points)
- `CLAUDE.md` G13, G57, G70, G73 — read against: the local four-colour gadgets are field-agnostic — surprised: yes; every small gadget in the vocabulary uses a unit triangle: the spindle and rhombus (G57), the hexagon lemma (G70), and the only edge-local four-colour height (G73: it lives only on sum-closed halves of S, i.e. on triangles); a triangle-free field supplies none of them
- `plans/STUB-algebraic-explanation.md` (FS-74) — read against: de Grey's rigidity is field-agnostic — surprised: yes; Hubai's description runs through the Eisenstein sublattice (the triangular lattice) and its Moore–Newman height, coupled across 48 cosets
- Soifer, *The New Mathematical Coloring Book* (2024), ch. 55 (held; extracted with `pdftotext`, lines 29935–29960) — read against: Kooshi's wall is the project's private difficulty — surprised: yes; **Open Problem 55.1 (Soifer 2019): "Construct a triangle-free 5-chromatic unit-distance graph"** (and 55.2, the smallest one); ch. 55 is one page after ch. 54, which FS-70 read in full; `grep` finds "55.1" nowhere in the repository's markdown, and `CLOSED-QUESTIONS.md` §3 does not list it
- `~/source/library/notes/polymath16-threads-1-18-text.txt` — read against: the triangle-free question is quiet — surprised: yes; Voronov (Polymath16, July 2021, as quoted in `plans/FS58-four-colours.md`): "Without triangles, of course, it must be computationally very hard"; Haugstrup (Dec 2025) restates Soifer's question as open; de Grey (Dec 2025) found a 61-vertex triangle-free five-chromatic UDG in ℝ³ only; Haugstrup's "pseudo-edge" constructions give triangle-free forcing in ℝ⁴
- zbMATH Open API, 2026-09-24: `ab:"triangle-free" & ab:"unit distance" & py:2015-2026` (2 hits), `ab:"triangle-free" & ti:"5-chromatic"` (2, abstract graphs, 1979/1989), `ti:"triangle-free" & ti:"unit distance"` (4) — read against: someone has a planar triangle-free five-chromatic UDG — surprised: no; nothing in the plane; the 2026 hit is de Grey's ℝ³ graph, not in `BIBLIOGRAPHY.md` (a negative scoped to these words, G21)
- `plans/FS81-quadratic-four-colours.md` §IQ item 5 and close inventory items 12, 18 — read against: the k = 4, 5 character question is unowned — surprised: no; it is named as FS-81's close stub ("circular colourings do not glue"), with FS-81's layer method as its first tool
- `plans/FS79-invariant-question.md` §R-close.3 — read against: G72 has produced a four-colour positive — surprised: no; four no-gos and one looseness result, "the target is where it was"
- `plans/POROS-2026-09-24-next-direction.md` hunches — read against: this morning's hunches are scored — surprised: no; census-theta3-lands confirmed (25 of 25, by the five-layer certificate rather than the census's lattices); t41-is-a-family killed as stated (T41's shape is non-empty at 47, PL-3, DB-4) and superseded by T5; q47-cheaper-at-five not scorable as matched (47's 5.1·10⁷ is at degree 18.41, 167's 1.38·10⁸ at degree 14); circular-colourings-do-not-glue open (candidate C2 below)
- `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4 — read against: the programme names an upper-bound derivation target — surprised: no; "every colouring we can construct is local at one prime" is its stated upper-bound question, and C2 is its first theorem-sized piece

## 3. Hunch ledger

hunch: premise-holds-at-four-not-three
  claim: Kooshi's two claims hold for four-colour attempts (proving five) in fields without √3 and fail at three colours
  basis: read
  falsifier: a project SAT refusal of four colours, or a four-colour forced pair, over a field without √3
  registered: 2026-09-24
  status: confirmed (by: `CLOSED-QUESTIONS.md` §3, every field known here to need five contains K; FS-61's census, fifteen triangle-free three-colour refusals; FS-81 phase-D D2, the 1,284× size ratio)

hunch: the-wall-is-a-posed-problem
  claim: Kooshi's triangle-free four-colour wall is Soifer's Open Problem 55.1, and the record does not know it
  basis: read
  falsifier: a file in the repository citing Soifer's 55.1 or the 2019 problem paper
  registered: 2026-09-24
  status: confirmed (by: Soifer 2024 ch. 55; `grep -rn "55\.1"` over the repository's markdown finds only an unrelated percentage)

hunch: character-colourings-are-local
  claim: no character of ℤ[U_F] puts U_F in [1/4, 3/4] when 1/2, 1/3 ∈ ℤ[U_F] and F² is not bipartite, so ℚ(√47)² has no character four-colouring
  basis: analogy
  falsifier: a point of the four-colour rational layer Θ₄(U₅) with a non-torsion, non-archimedean part, or an explicit banding character over ℚ(√47)
  registered: 2026-09-24
  status: open

hunch: triangle-free-rigidity-exists
  claim: some Cayley graph of ℤ^r whose connection set has no three elements summing to zero has a non-zero forced group at four colours
  basis: prior
  falsifier: a proof that every four-colourable triangle-free Cay(ℤ^r, S) has F = 0 at four colours
  registered: 2026-09-24
  status: open

hunch: the-ban-bites-on-the-default
  claim: the stub table's default next steps at four colours would use SAT, so the ban constrains the week rather than relabelling it
  basis: read
  falsifier: FS-59's next steps list no solver ask
  registered: 2026-09-24
  status: confirmed (by: `CLAUDE.md` § Paths forward, FS-59's row: quotients at N ≥ 16 and residue asks are SAT asks)

## 4. Kooshi's premise, checked against the record

| claim | scope where it holds | scope where it fails | what would refute it |
|---|---|---|---|
| "We have never succeeded at a priced attempt outside extensions of K" | **Four colours** (proving a field needs five, or finding a four-colour forced pair): every such result the project owns lives in a field containing K = ℚ(√3,√11) (`CLOSED-QUESTIONS.md` §3: the fields known here to need five are all of degree 8 and contain K). The three attempts outside K did not land: ℚ(√3,√5) (FS-70), ℚ(√167) (FS-59/79), ℚ(√47) (FS-81 stage D, whose price could not even be formed) | **Three colours**: fifteen real quadratic fields, none containing √3, were refused by SAT (FS-58, FS-61), five of them after a priced re-aim at average degree 14 (G65). **The literature at four colours**: Voronov et al.'s and Heule's five-chromatic graphs lie in ℚ(√2,√3,√5)², outside K's extensions, found by SAT | a SAT refusal of four colours, or a four-colour forced pair, by this project over a field not containing K. The literature already shows one exists when √3 is present (ℚ(√2,√3)'s forced pair, Heule's T721) |
| "Triangle-free fields make SAT infeasible" | **Four colours**: no one, here or in print, has a four-colour refusal or forced pair over a field without √3 (Soifer's Open Problem 55.1 asks for exactly this, 2019; still open in the plane per Polymath16, Dec 2025, and zbMATH) | **Three colours**: triangle-free fields were refused by SAT at up to 2,360 points. **The mechanism**: ℚ(√3,√5) has triangles and still failed; so triangles are necessary for every small four-colour compulsion known, not sufficient | a four-colour refusal or forced pair over a triangle-free field at a size a solver can hold (≲ 10⁵ points), found by anyone |

**What the record says the mechanism is** (more precise than "SAT is infeasible"):
1. **The obstruction is the size of the object, not the solver.** Over ℚ(√47) the lattice of unit vectors is about 5,500 times finer
   (covolume 2.27·10⁻⁷ against de Grey's 1.25·10⁻³), so a ball dense enough to refuse four colours has ≈ 5.1·10⁷ points against de
   Grey's 39,829. A perfect solver faces the same ball. This is G61's "supply of unit vectors", measured at four colours.
2. **Every small four-colour gadget uses a unit triangle.** The spindle and rhombus (G57), the hexagon lemma (G70), the only edge-local
   four-colour height (G73: Moore–Newman's, which lives only where the connection set holds some a, b, a+b), and the Eisenstein stripes
   behind de Grey's rigidity (FS-74's Hubai description). A field without √3 has none of them, and loses the triangle pin besides
   (5.4× at the threshold, stage D).
3. **What has worked in these fields is a certificate on the infinite object**, never a finite witness: `Θ₃` (FS-73), the five-layer
   structural certificate that beat the relation-tree search 1 s to "undecided after 30 min" (FS-81 phase 0), the residue-tower
   certificates (FS-66), and T5, which settled the whole family by derivation.

**So the premise is right where Kooshi aims it (four colours, no √3) and wrong at three colours, and the instrument is not the
culprit.** The honest restatement: *outside K, at four colours, finite witnesses are the wrong object, whoever searches for them.* The
ban's real content is therefore "for a week, every certificate must live on the infinite object", and the week pays only if it finds
such a certificate at four colours, where G71 and G73 say none of the local formats exists.

## 5. Cards

question: experiment-or-production
  evidence: `plans/FS81-close-inventory.md` item 82 (Kooshi's ban and its motive, four-colour failures outside K);
    `plans/FS81-derivation.md` T5, T7 (algebra already decides three colours); `CLAUDE.md` G71, G73 (no local invariant at four colours)
  expected: Kooshi wants the ban to test whether algebra reaches where SAT failed
  ask: is the week an experiment (can algebra reach four colours in triangle-free fields?) or production (bank what algebra already reaches)?
  if experiment: rank 1 (C1) is the body of the week, rank 2 (C2) its first day, rank 3 (C3) the fallback when C1's killing test fires
  if production: C2 then C3, both near-certain; the week then tests nothing about SAT, and says so in its close
  answered by: Kooshi
  cost: one answer
  hunch: experiment — his words are "see what we can do on algebra alone", and the failures he names are all at four colours
  falsifier: Kooshi says the week is for banking results
  rank: 1

question: does-rigidity-need-triangles
  evidence: `CLAUDE.md` G73 (edge-local four-colour heights exist only on sum-closed halves of S); `plans/STUB-algebraic-explanation.md`
    (de Grey's rigidity runs through the Eisenstein sublattice); ℚ(√11)'s `Λ₁₀` is triangle-free and rigid at three colours (row 79)
  expected: four-colour rigidity has a triangle-free instance somewhere, as three-colour rigidity does
  ask: can a Cayley graph of ℤ^r with no three connection vectors summing to zero have a non-zero forced group at four colours?
  if no (a theorem): G55's chain route is dead in every triangle-free field; five over ℚ(√47) needs a refusal with no compulsion, and Kooshi's hunch is a theorem about the mathematics
  if yes (an instance): the question becomes arithmetic (which triangle-free fields realise it), and one realisation in a wall-broken field proves five by the chain theorem
  answered by: derivation
  cost: first a reading of de Grey's mechanism (FS-74's lead 1), then the triangle-free question; a competition, 3–5 days
  hunch: yes somewhere in the abstract class, since three-colour rigidity exists without triangles
  falsifier: a proof that every four-colourable triangle-free Cay(ℤ^r, S) has F = 0 at four colours
  rank: 2

question: are-character-colourings-local
  evidence: `plans/FS81-quadratic-four-colours.md` §IQ item 5; close inventory items 12, 18; `plans/FS81-derivation.md` T3–T4 (the layer method)
  expected: a character four-colouring of ℚ(√47)² does not exist
  ask: which real fields F have a character θ of ℤ[U_F] with θ(U_F) in [1/k, 1 − 1/k], at k = 4 and k = 5?
  if none at ℚ(√47) (k = 4) and ℚ(√167) (k = 5): the only non-residue colouring mechanism anyone has cannot falsify the conjecture there, and the programme's upper-bound question gets its first theorem
  if one exists: χ(ℚ(√47)²) ≤ 4 or χ(ℚ(√167)²) ≤ 5, and the conjecture falls at its cheapest exact prediction
  answered by: derivation
  cost: an hour for the four-colour rational layer (an exact computation), then 1–2 days of derivation and blind verification
  hunch: none, when 1/2 and 1/3 both lie in ℤ[U_F] (FS-81's L4′ with 6 in place of 3)
  falsifier: a cell of the four-colour rational layer that is neither torsion nor archimedean
  rank: 3

## 6. The recommendation for Kooshi

### 6.1 In brief

Spend the week at **four colours**, where your premise lives, on the one question whose answer decides whether algebra can get there
at all: **can four-colour rigidity exist without triangles?** Open it with a one-day, near-certain piece of algebra one colour above
FS-81 (can the plane over ℚ(√47) be four-coloured by a character?), and keep the three-colour classification as the fallback. Judge
the week only on four-colour results: algebra already won at three colours, so a three-colour result would show nothing new about SAT.

Confidence: medium. It would drop to low if the one-hour check in C2 shows the four-colour rational layer has cells FS-81's method
cannot handle. It would rise if the first round of C1 proves Hubai's stripes on de Grey's lattice.

### 6.2 What reading changed against my expectation (§0)

- **E1 held in shape, changed in aim.** I expected FS-74 (de Grey's 8Λ) to be the target. It is now the *entrance* to a sharper
  question: the rigidity runs through the Eisenstein sublattice, which is to say through triangles, and "does rigidity need
  triangles?" is exactly your premise, stated as mathematics.
- **E3 held.** The premise is false at three colours, true at four colours without √3, and the instrument is not the culprit.
- **Not expected:** your wall is a published open problem. Soifer's Open Problem 55.1 (2019) asks for a triangle-free five-chromatic
  unit-distance graph in the plane. It is in a book this project holds, one page after a chapter it read in full, and nowhere in
  the record.
- **Not expected:** FS-81's own decisive win over search was not over SAT. It was a derived certificate beating a branch-and-bound
  tree: one second per field against "undecided after 30 minutes".

### 6.3 Candidates, ranked

**Rank 1 — C1. Can four-colour rigidity exist without triangles?**
- *The question.* Every four-colour "forced pair" (two points that get the same colour in every four-colouring) known anywhere uses
  a triangle. Examples: de Grey's lattice (period 8Λ) over K, and Heule's forced pair at distance 2 over ℚ(√2,√3).
  - Step 1: prove *why* de Grey's lattice is rigid. The lead is Hubai's 2018 description: two-colour stripes on the Eisenstein
    sublattice plus one chirality. Record exactly where the triangles enter.
  - Step 2: ask the general question. Can a Cayley graph of ℤ^r whose connection set has no three vectors summing to zero have a
    forced pair at four colours?
  - Controls on hand: ℚ(√11)'s lattice is triangle-free and rigid at three colours (row 79). De Grey's lattice is rigid at four
    colours with triangles (row 78).
- *Why algebra, not a solver.* It is a question about every four-colouring of an infinite graph. The finite witnesses in these
  fields are measured at about 5·10⁷ points (FS-81 stage D), and the certificate being explained is a SAT refusal. Replacing that
  refusal by a derivation is the ban's hypothesis in its sharpest form.
- *What it buys.*
  - **If no** (a theorem): the chain route (G55) is dead in every triangle-free field. Five over ℚ(√47) would then need a refusal
    with no forced pair anywhere inside it. Your hunch becomes a theorem about the mathematics, not about the solver.
  - **If yes**: the question becomes arithmetic (which fields can realise it). One realisation in a field where 1/2 is a sum of unit
    vectors (a "wall-broken" field) proves five by the chain theorem. That would answer Soifer 55.1, Exoo–Ismailescu's "smallest
    field that needs five" (the answer would have degree 2, the least possible) and Moorhouse's "what about ℚ(√47)?" at once.
  - **For six**: it is the template. Six at ℚ(√167), which has no triangles and where the conjecture predicts at least six, needs a
    five-colour forced pair, and G73 says the local formats are emptier at five colours.
- *Cost.* A competition (two competitors and an advisor, the project's standing design). About 1.0–1.6 million tokens over 3–5 days,
  from the record's anchors: competitors 360–552k tokens each, advisors 220–480k.
- *Killing test (wrong choice).* After the first round (about day 2), neither competitor has proved that every four-colouring of de
  Grey's lattice restricts to stripes, and neither has stated with a proof what a triangle-free rigidity would require. Then there is
  no attack yet: stop, and move to C3.

**Rank 2 — C2. Can the plane over ℚ(√47) be four-coloured by a character, or the plane over ℚ(√167) five-coloured?**
- *The question.* A "character colouring" colours each point by where one additive character puts it on the circle (FS-81's
  Θ-sets, one colour up).
  - Which real fields have a character that puts every unit vector in the band [1/k, 1 − 1/k], at k = 4 and at k = 5?
  - At ℚ(√47) with k = 4, or at ℚ(√167) with k = 5, a **yes** colours the whole plane with fewer colours than the conjecture
    predicts, and by no single prime. That refutes the conjecture at its cheapest exact prediction.
  - A **no** closes the only non-residue colouring mechanism anyone has.
- *Why algebra.* FS-81's layer method (T3–T4) should carry over with one new finite computation: the rational layer's cells at
  k = 4 and 5. At k = 3 that computation took 0.1 s. It replaces the capped float Θ₄ searches that FS-79 and FS-81 ran lattice by
  lattice.
- *What it buys.*
  - For the conjecture: it decides the only falsification route short of FS-64.
  - For the programme: a first theorem on the upper-bound question ("every colouring we can construct is local at one prime"). This
    is item 12 of the close inventory and the stub FS-81's plan names for its close.
  - For six: nothing directly.
- *Cost.* One hour for the rational-layer check, then 1–2 days for one derivation agent and one blind verifier: about 0.6–0.9 million
  tokens. The anchor: FS-81's blind verifier used about 520k tokens in a day for six statements.
- *It may be a paragraph.* If the four-colour rational layer is only torsion points plus small archimedean discs, the theorem is
  FS-81's L4′ with 6 in place of 3 (1/2 and 1/3 both lie in the unit-vector ring of ℚ(√47) and of ℚ(√167)). Price that in the first
  hour, before assigning a milestone.
- *Killing test.* The rational layer at k = 4 has a cell that is neither torsion nor archimedean. Then the layer method does not
  transfer, and the candidate stops at that computation.
- *How it counts for the experiment.* Only the full classification counts as a result: a character k-colouring exists exactly when an
  additive one does. A bare "none at ℚ(√47)" is a no-go.

**Rank 3 — C3. Finish the three-colour classification of every real number field (the fallback, and the production option).**
- *The question.* FS-81's T7 leaves one case open: fields in which every prime above 3 of odd residue degree has degree at least 3.
  The first instance is ℚ(α, √7) with α³ = α + 1. Can such a plane be three-coloured?
  - **No** (predicted): with G55, F-T4 and T7, every real number field whose local bound L is at least 4 needs four colours. The
    conjecture then holds at L ≤ 4 for every real number field, which answers Fischer's 1990 request for an algebraic criterion at
    three colours.
  - **Yes**: the conjecture falls at its four-colour level, in a place nobody has looked.
- *Why algebra.* FS-81's L1–L4 carry over; the new step is a Hilbert-90 argument at a residue field of 27 elements, which T7 already
  names.
- *What it buys.* A class theorem and a publication-grade answer, subject to the unread Johnson papers. Nothing for six, and nothing
  about SAT: it would have used no solver anyway.
- *Cost.* 0.6–0.9 million tokens, 2–3 days. T7 is one mind's derivation and wants its second reading first.
- *Killing test.* The unit-vector relations in the residual case do not force the layer types to agree. T6 needed a parity condition
  on the relation, and if none exists here the case splits and outgrows its value.

**Considered, not ranked.**
- *FS-80, the window-frequency LP (the averaged route).* The only lower-side format G73 leaves besides C1's. It is eligible only under
  the derived-shape rule in §6.4, it is speculative by its own stub, and Polymath16 observed in 2018 that relaxations run low on
  triangle-free graphs. Rank 4 if you want a second lower-side attempt.
- *G60's fractional route at ℚ(√47).* The cap (4.32) leaves room, but Hoffman-type shadows read about 3.5, and triangle-free
  unit-distance graphs typically have fractional chromatic number below 3.
- *Kernel ports (FS-75, FS-45, FS-60).* Valuable and SAT-free, but ceremony for this experiment: they test nothing.
- *FS-64, the adelic colouring.* No attack yet; C2 is its first tool.

### 6.4 The scope of the ban (where the experiment stays informative)

| instrument | in the ban's spirit? | why |
|---|---|---|
| SAT, MaxSAT, #SAT (kissat, CaDiCaL, pysat back-ends) | **out** | your ban |
| other searches for a finite witness or a colouring: MILP or CP colouring searches, local-search colourers (the tabu finders), the Θ relation trees, float Θ₄ finders, quotient-colouring searches, lattice sweeps hunting survivors | **out** | the same instrument class: an answer found on a finite instance, not derived. FS-81's relation tree is not SAT and lost to a derived certificate exactly as SAT did. Banning only the SAT binary lets the habit continue under another name |
| exact LPs that produce checkable certificates | **in, if the LP's shape is fixed by a derivation before it runs** (its enumeration and expected certificate are derived first, like FS-81's structural certificate) and its dual is read back as an identity; **out as an escalating oracle** (bigger windows until it says infeasible) | a derived LP is a calculator; an escalating LP is a search |
| computer algebra (PARI, GAP, sympy, exact arithmetic): prime decompositions, character sums, spectra, exact ranks, the rational layer's cell list | **in** | it calculates a determined quantity and hunts nothing |
| colourings built by formula (residue, additive, character) | **in** | constructions, not searches |
| existing checkers on existing certificates; the Lean kernel | **in** | checking finds nothing new |
| FS-81's own solver jobs | finish or stop at FS-81's close, as you ruled | the ban starts at the close |

The line in one sentence: **for a week, every certificate must be derived, and must live on the infinite object** (a field, a lattice,
a character set), never on a finite piece found by search.

### 6.5 How you will know whether it paid (the experiment's own killing test)

- **Baseline, the week before (2026-09-17 → 09-24), with SAT allowed.**
  - At four colours outside K: no result that moved a target. FS-70 did not land. FS-79 produced four no-go theorems and one
    looseness result (from an exact computation, not SAT). FS-81's stage D could not form a price.
  - At three colours, algebra already dominated: T4 for the whole family, χ(ℚ(√167)²) ≥ 4, the three-colour theorem, and 25 fields
    by derived certificates. SAT contributed FS-58's and FS-61's fields and, over K, the 8Λ certificate.
- **What counts as a result.**
  - A proved statement at four or more colours about *every* colouring (or every character colouring) of a lattice graph or field
    plane, at two independent derivations or better.
  - A new bound on χ for a named field.
  - A posed question answered: Soifer 55.1, Exoo–Ismailescu's smallest field, or Moorhouse's ℚ(√47).
- **What counts as ceremony.** Kernel ports of held results; re-derivations; no-go theorems for formats nobody proposed to use;
  bookkeeping; any finite search under another name.
- **The instrument that makes the week readable: a "would have used SAT here" log.** Every time an agent's default next move would
  have been a solver ask, it writes one line: the ask, and what it did instead. At the close, count the lines and read what replaced
  them. Zero lines means the ban constrained nothing, and the week is silent about SAT whatever it produced.
- **Verdicts, registered before the week starts.**
  - *Paid*: at least one four-colour result of the first kind, outside K.
  - *Draw*: only three-colour results. Algebra paid where it already had, and the week taught nothing about SAT.
  - *Null*: nothing at four colours. This is weak evidence against algebra (FS-73 and FS-79 had already found no four-colour
    invariant). It is no evidence for SAT, which was not going to succeed there either.
- **Predictions to register now** (scored at the week's close):

  | id | prediction | probability |
  |---|---|---|
  | P-W1 | C2's check finds only torsion-plus-archimedean cells at k = 4 | 0.75 |
  | P-W2 | C2 proves "no character four-colouring of ℚ(√47)²" at two derivations within two days | 0.65 |
  | P-W3 | C1's first round proves Hubai's stripes on de Grey's lattice | 0.35 |
  | P-W4 | the week proves some triangle-free field needs five colours | 0.05 |
  | P-W5 | the week produces at least one four-colour result of the first kind | 0.55 |

### 6.6 The question behind the question

1. **SAT against algebra is the wrong cut. The real cut is a finite witness against a certificate on the infinite object** (§4).
   - Everything that worked outside K was the second kind.
   - Everything that failed at four colours was the first kind.
   - The ban is worth running because it forces the second kind. It should be judged on that, not on the absence of a binary.
2. **Your wall is Soifer's Open Problem 55.1, and the conjecture predicts its answer.**
   - The conjecture says χ(ℚ(√47)²) = 5. By compactness that means a triangle-free five-chromatic unit-distance graph exists in the
     plane.
   - Soifer posed the problem in 2019, arguing that a triangle-free five-chromatic graph might even come out *smaller* than the
     general record; none has been found in the plane since. Voronov wrote on Polymath16 in 2021 that "without triangles … it must
     be computationally very hard". In December 2025 de Grey could build one only in three dimensions.
   - This is the third publication category in its strongest form. It is also a warning: the world has not found this object either.
3. **A week is short for five, so judge it on a nearer object.**
   - G71 and G73 have already shown that no local certificate format (heights, windings, face fluxes, coindex bounds) can work at
     four colours.
   - The chance the week proves five in a triangle-free field is small (P-W4, 0.05). A null on *five* would be uninformative.
   - Judge the week on the four-colour *structure* question instead (C1's step 2).
4. **Where the conjecture is cheapest to attack has moved.** The lower side has no engine at four colours. The one place a derivation
   can touch ℚ(√47) at four colours this week is the upper side (C2): "attack a belief where it is cheapest" now points there.
5. **On six, honestly:** none of the candidates buys six directly. C1 is the template for it: a five-colour forced pair in a 6-open
   field with no triangles, of which ℚ(√167) is the smallest.

### 6.7 Unread or surprising in the record

1. **Soifer's Open Problems 55.1–55.2** (2019; `[Soifer2024]` ch. 55; problem paper "[Soi46]"). They are not in
   `CLOSED-QUESTIONS.md` §3, and the bibliography's reading list for the book skips chapter 55.
2. **de Grey, "A 5-chromatic, triangle-free unit-distance graph in ℝ³ with 61 vertices"** (Geombinatorics, 2026; in zbMATH), and
   **Haugstrup's "pseudo-edge" constructions in ℝ⁴** (Polymath16, December 2025–February 2026). They are the only triangle-free
   five-forcing mechanisms known, and both use spheres small enough that unit triangles cannot exist. Neither is in the bibliography.
   Read them for C1.
3. **Heule's T721**: a four-colour forced pair over ℚ(√2,√3), known only as relayed by Soifer. It is the second known rigid instance,
   the one C1 can compare against. The paper is not held.
4. **Unscored or unrun.**
   - P-D0: the one-hour re-asks at radius 1.3 are running.
   - T8's reading that configuration A explains the census's mod-8 skew: its killing test was never run.
   - FS-81's lead that the T41 shape empties at level 1 only at d ≡ 23 (mod 48).
5. **This morning's advisor's hunches**, scored in §2. One, "circular colourings do not glue", is C2.
6. **The Johnson papers** remain a debt before any T4 or C3 claim.

### 6.8 The one question for you

**Is the week an experiment (can algebra reach four colours where SAT could not?) or a production week (bank what algebra already
reaches)?**
- *Recommendation:* the experiment. C2 on day 1: one agent, with the one-hour check first. C1 as the week's body: the competition from
  day 2, within the three-agent cap. C3 only if C1's killing test fires.
- *Alternative weighed:* production, meaning C2 then C3. Both are near-certain, and C3 is publication-grade. But the week would
  then contain nothing SAT would have been used for, so it could not tell you anything about your premise.
- *Why the experiment wins:* your words are "see what we can do on algebra alone", and every failure you named is at four colours.
- *Confidence:* medium. The fact that would change it: if you mainly want the week to produce publishable theorems, production wins.
- *Default if you say nothing:* the stub table's top after FS-81's close, FS-59 (five over ℚ(√167)). Its next steps are SAT asks, so
  under the ban it would stall. The default should be replaced before the ban starts.
