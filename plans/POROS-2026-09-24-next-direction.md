# Poros — what should the next milestone be? (advising Kooshi, 2026-09-24)

Record of Poros, advising after FS-79's close. Only writer: Poros. Brief: `next-poros/BRIEF.md`. Every file address below is relative
to `/home/kooshi/source/lean-dir` and was read from disk at `fad1c032`.

## 0. Expectation, written before reading FS-79's close (2026-09-24)

Written from the loaded `CLAUDE.md` snapshot (which predates FS-79's close: no G73, rows only to 79) and the brief's five-line
situation, before opening any FS-79 file. Its job is to make surprise measurable later.

**What I expect the next milestone should be.** Hunch: **FS-74, the algebraic explanation of `F = P = 8Λ` on de Grey's lattice** —
or something shaped like it. Reason: it is the one place in the project where *four-colour rigidity is known to exist* (a certified
fact, Hubai 2018 in ring form, row 78 in lattice form), and G71 says the three-colour mechanism does not explain it. FS-79 asked for a
four-colour invariant over a whole class and (per the brief) returned no-gos. When a class-level search for a mechanism returns
nothing, the cheapest reading is the one instance where the phenomenon is certainly present: "a result closed on the certificate with
no mechanism" is the ugliness the standard names first. Confidence low-medium; I have not read FS-74's stub or FS-79's no-gos.

**Which forks I expect to be real.**
1. **Direction of attack on the conjecture.** Every recent milestone attacks ℚ(√167) *from below* (4, then aiming at 5). The
   conjecture predicts ≥ 6 there. A lower bound of 5 is *consistent* with the conjecture; it cannot falsify it. The only result at
   ℚ(√167) that falsifies is an *upper* bound — a colouring of ℚ(√167)² with ≤ 5 colours, necessarily non-residue (every residue
   target refuses five). So "attack the belief where it is cheapest" (the target paragraph) and "prove five over ℚ(√167)" point in
   opposite directions. I expect this to be a real fork the record has not named as one (Wason: have we tried to get a "no"?).
2. **Conjecture test vs. the mission.** ℚ(√167) has no √3 and no √11 — a triangle-free field plane with no Moser spindle (G57). Five
   there is new mathematics of a kind (a Moser-free, triangle-free five-chromatic field), but it is not a rung toward χ(ℝ²) ≥ 6, which
   must live in a 6-open field such as K(√7) (G26, G48, row 66). I expect the project to have drifted from the mission's rung D toward
   the conjecture's test without saying so.
3. **Derivation vs. kernel port vs. housekeeping.** FS-75 (the three-colour criterion and χ(ℚ(√167)²) ≥ 4 in the kernel) is cheap and
   banks the best recent result; the stub table (80 rows) is stale. I expect one of these to be the honest "consolidate" option.

**Where I expect the project's own framing to be wrong.**
- (a) The direction of attack at ℚ(√167), above.
- (b) G72's count: a structural question about *every* solution is a natural generator of **no-go theorems** (it says what cannot
  certify), and a no-go is a derivation that changes no object. I expect FS-79's "results through the structural question" to be
  mostly no-gos, which the count scores as wins; if so, the killing test as written cannot distinguish the method paying from the
  method producing obituaries. Hunch, to be scored.
- (c) The "cheapest exposed prediction" may not be cheap: four at ℚ(√167) took two milestones and an accident; five may be priced like
  a five-forcer (G25's grade). "Cheapest" was a statement about the *prediction's* exposure, not about the *cost of testing it*.

## 1. The survey (the frame on five axes, from the record)

- **The goal, in the principal's words.** "Gunning for 7 … I'd be equally happy to be proven wrong" (`CLAUDE.md` § The mission);
  "the derivations are an order of magnitude more important than individual objects" and "an object is finished when its derivation
  is" (`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §1, §6); "a belief held is a belief to be attacked where it is cheapest" (§ The mission (2)).
- **Object.** ℚ(√167)'s rank-4 unit-vector lattices at four colours (FS-59 rank 1, FS-80 rank 3).
- **Question.** "Does ℚ(√167)² need five?" — an existence question, from below.
- **Discipline.** Symbolic dynamics / hom-shifts (G72, G73), after FS-79 found the topological engine empty at four colours.
- **Audience.** Internal (the stub table, the close), and — never yet fired — the publication bar's third category: "a result that
  answers a question the literature has independently and repeatedly posed" (`CLAUDE.md` § Publication).
- **Product.** A certificate of five over ℚ(√167), or a certificate format.

## 2. Evidence inventory

- `CLAUDE.md` § The mission, the target paragraph — read against: ℚ(√167) named as the one cheap exposed prediction — surprised: yes; "the conjecture has one cheap exposed prediction left and it is ℚ(√167)" omits four real quadratic fields where it predicts exactly five with a one-colour gap (item below)
- `CLAUDE.md` Frontier item 10 (line 187) — read against: the proved-range summary is current — surprised: yes; "four or five for ℚ(√47) — are met" is stale: FS-66 settled `L(ℚ(√47)) = 5` at every tower level and `CLOSED-QUESTIONS.md` §1.7 says the conjecture "predicts 5", so the prediction is five and the bracket `4 ≤ χ ≤ 5` does not meet it
- `CLOSED-QUESTIONS.md` §1.7 — read against: quadratic fields as a finished census — surprised: yes; Moorhouse 2010 asks by name "What about χ(ℚ(√47)²)?"; "no real quadratic field is known to need five"; brackets `[4, 5]` at 47, 143, 311, 335; 26 of 40 fields open; `[Johnson2006]`, `[Johnson2000]` unread and named "the likeliest places for a contrary claim"
- `data/fs61/census.md` rows for 35, 83, 107, 131, 155, 179, 203, 215, 227, 251, 263 — read against: the census's nulls have been revisited with FS-73's exact three-colour procedure — surprised: yes; every null is still typed at FS-61's ball tiers ("asked: 1 of 5 Open lattices, no refusal", "by budget: 7 Open lattices, none askable"), and nothing in `data/fs73`, `plans/FS73*`, `plans/FS79*` touches another census field
- `plans/FS73-rigidity-dichotomy.md` §R-close.4 — read against: G71 forwarded to the open-instance list — surprised: yes; G71 went to FS-60 (kernel), FS-48, FS-46, FS-67, FS-59, FS-72, none of which runs `Θ₃` on the census's open lattices
- `plans/FS73-derivation.md` T39–T41, T45 — read against: `L21cc6506`'s obstruction is specific to 167 — surprised: yes; the obstruction is 36 vectors `{1, v, z}·U_R` with a half-page four-case proof; `v = v₄₂` is G7's type-M rotation, which every ℚ(√d) with `d ≡ 3 (mod 4)` carries at `n = (d+1)/4`; the visible 167-specific ingredient is `z = (1+i)(15 − i√167)/28`, which needs `d = 2m² − a²`; ℚ(√47) has the same shape (`v₁₂ = (23 + i√47)/24`, `z = (1+i)(5 − i√47)/12`) and is already certified `χ ≥ 4`, a positive control
- `CLAUDE.md` G61 — read against: T4 ("every d ≡ 11 mod 12 needs four") has a route — surprised: yes; G61 says "no proof and no route to one — no witness transfers between fields", written before `Θ₃` existed and never revisited; `Θ₃` is a statement about a lattice, not a witness, so the reason given no longer applies
- `plans/FS79-invariant-question.md` §R-close.3 and G72's first count — read against: no-gos credited as the method's wins — surprised: no; P-G72 (0.8, "if anything lands, it comes through the structural question") "won" on the four no-gos, and the prose concedes "it did not produce the positive, and the target is where it was"
- `CLAUDE.md` G73 — read against: the four-colour certificate question is closed for cell-local formats — surprised: no; and from five colours up `KG(k, 2)` is connected, so the topological engine that paid at three colours (G72's move 2) is empty in the whole range the mission lives in
- `plans/STUB-four-colours-167.md` §0 and §1 — read against: FS-59 is two-sided — surprised: yes; at minting (§1) it was ("a proof that three suffices kills the conjecture's main clause outright … run it to find out which"); after row 79 every route in §0 (steps 1–7) is a lower-bound route, and the stub's bearing still says "the falsification target"
- `plans/STUB-four-colours-167.md` §0 prices — read against: a five-refusal is priced — surprised: yes; "the four-colour hardness band is unmeasured"; the only prices are three-colour-law balls, 1.38·10⁸ to 1.57·10¹¹ points
- `plans/STUB-window-frequency-certificate.md` (FS-80) — read against: a concrete certificate route to five — surprised: no; its own mission names size as the obstacle and rates it speculative, "none directly" on six
- `plans/STUB-algebraic-explanation.md` (FS-74) — read against: my expectation that it is the next milestone — surprised: yes; its re-aim says the rigidity is "a many-layer effect", and lead 1 is a human proof of a structure Hubai found by computer — a five-forcer-grade proof, not a cheap derivation
- `plans/STUB-five-colour-rigidity-table.md` (FS-78) — read against: rung D has a cheap screen — surprised: no; "screens, minutes each", unrun, rank 5
- `plans/STUB-adelic-window-colouring.md` (FS-64) §3a — read against: an upper-bound instrument exists at ℚ(√167) — surprised: no; the only one, speculative, with its success condition named (a strict Hedetniemi inequality for a compact abelian factor)
- `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §5 — read against: the programme's order of work is current — surprised: yes; its routes are closed (FS-11's lift by G45, FS-6 by row 66) and it has not been rewritten since 2026-09-07; its rule 6 ("an object is finished when its derivation is") applies to FS-73's `Θ₃` certificate and nobody has invoked it there
- `plans/FRONTIER-STUBS.md` / `CLAUDE.md` § Paths forward — read against: a ranked table — surprised: yes; the rank column repeats (2 ×4, 3 ×6, 4 ×4, 5 ×3, 6 ×2, 8 ×3), so the table no longer orders anything below rank 1
- `CLAUDE.md` notation and G56 on ℚ(√167) — read against: my hunch that ℚ(√167) is off rung D — surprised: yes; ℚ(√167) is 6-open (wall broken, usable planes 23, 43, 59 all refuse five), the smallest-discriminant 6-open real field, and every lattice over it has rank ≤ 4, so the conjecture predicts a six-chromatic unit-distance graph inside a Cayley graph of ℤ⁴ there — the cheapest possible arena for χ(ℝ²) ≥ 6 by rank
- `plans/FS79-invariant-question.md` §R-close.5 — read against: every prediction scored — surprised: yes; P-G54 (Γ₂₃ slack at four colours, 0.8) is unscored because phase 0's step 0 was never reported — a character sum, seconds
- zbMATH Open API, 2026-09-24: `ab:"unit distance" & ab:"quadratic field"` 0; `ab:"chromatic number" & ab:"real quadratic"` 0; `ab:"circular chromatic number" & ab:"unit distance"` 2 — read against: nothing new — surprised: yes; one hit, *Circular coloring the plane* (2007), is not in `BIBLIOGRAPHY.md`, and `Θ_k` points are circular colourings
- `plans/PROTOCOL-competitor-and-advisor.md` budget anchors — read against: cost anchors exist — surprised: no; competitors 360–552k tokens, advisors 220–480k

## 3. Hunch ledger

hunch: next-is-the-rigid-instance
  claim: the next milestone should study the one lattice where four-colour rigidity is certified (de Grey's, `F = P = 8Λ`), i.e. FS-74
  basis: prior
  falsifier: FS-74's stub or FS-79's record shows the 8Λ mechanism already explained, or a cheaper derivation-for-a-class sits unclaimed in the record
  registered: 2026-09-24
  status: killed (by: `plans/FS73-derivation.md` T41 — FS-73's own certificate has a half-page proof whose generalisation to a class is unclaimed and far cheaper; and FS-74's re-aim makes its lead 1 a human proof of a computer-found structure)

hunch: attack-from-below-cannot-falsify
  claim: every live route at ℚ(√167) is a lower-bound route; none can falsify the conjecture there, and the record does not say so
  basis: derived
  falsifier: a stub or plan in the record that aims at a ≤5-colouring of ℚ(√167)² and names it as the falsification route
  registered: 2026-09-24
  status: confirmed (by: `plans/STUB-four-colours-167.md` §0 steps 1–7, all lower-bound; its bearing still "the falsification target"; FS-64 is the one ceiling instrument, rank "2" among four rank-2 rows, and says "confidence low")

hunch: g72-count-scores-no-gos-as-wins
  claim: FS-79's G72 count credits no-go theorems to the structural question, so the killing test cannot detect ceremony
  basis: prior
  falsifier: FS-79's §R-close separates no-gos from constructive results in the count, or the structural question produced a positive
  registered: 2026-09-24
  status: confirmed (by: registered replication — the claim was registered in §0 before FS-79's close was opened, then checked against two passages written by others: G72's "First count" and §R-close.5, where P-G72 "won" on the no-gos; the prose of §R-close.3 separates them, the killing test does not)

hunch: drift-from-rung-D
  claim: the last three milestones advanced the conjecture's test, not χ(ℝ²) ≥ 6, and no stub near the top aims at a 6-open field
  basis: read
  falsifier: a top-five stub whose object is a 6-open field at five or six colours
  registered: 2026-09-24
  status: killed (by: ℚ(√167) is itself 6-open — G56, § Notation — with rank ≤ 4 lattices, so FS-59 is rung-D work in the smallest arena; the unrun rung-D screen is FS-78, rank 5)

hunch: census-theta3-lands
  claim: FS-73's exact three-colour procedure, run on the census's open lattices, lands at least half of the 25 open real quadratic fields
  basis: analogy
  falsifier: fewer than 5 of the 25 fields land at the census's own lattice depth
  registered: 2026-09-24
  status: open

hunch: t41-is-a-family
  claim: T41's four-case proof uses 167 only through the twist parameters, so the same shape refuses three colours over an infinite explicit family of real quadratic fields
  basis: prior
  falsifier: ℚ(√47)'s shape `{1, v₁₂, z}·U_R` (its `z = (1+i)(5 − i√47)/12`) has a non-empty `Θ₃`, or the four cases need a congruence 167 alone satisfies
  registered: 2026-09-24
  status: open

hunch: q47-cheaper-at-five
  claim: a four-colour refusal on a rank-4 lattice is cheaper over ℚ(√47) than over ℚ(√167)
  basis: analogy
  falsifier: FS-79's phase-0 screen run at d = 47 leaves no survivor at the chain depth where 167 left seven, or its survivors' refusals price above 167's
  registered: 2026-09-24
  status: open

hunch: circular-colourings-do-not-glue
  claim: a character of ℤ[U] that puts every unit vector of a whole field in `[1/k, 1 − 1/k]` has finite image on U, so a lattice's `Θ_k` point is a lattice artifact and circular colourings of a field plane are additive ones
  basis: prior
  falsifier: an explicit character with a non-trivial component at a split prime that bands U on a lattice chain with unbounded split denominators
  registered: 2026-09-24
  status: open (my sketch breaks at the S-unit step; recorded as a question for FS-64, not a claim)

## 4. Cards

question: is-the-census-decided-by-theta3
  evidence: `data/fs61/census.md` — 25 fields open, each with 3–16 "Open lattices" typed at ball tiers; `plans/FS73-derivation.md` T39–T41 — `Θ₃` decided ℚ(√167) at 60 vectors where 10⁸-point balls failed; `plans/FS73-rigidity-dichotomy.md` §R-close.4 — the procedure never pointed at the census
  expected: G72's *Do* ("point a new exact decision procedure at the open-instance list the same day") would have aimed it at the census on 2026-09-23
  ask: does the exact three-colour criterion decide the 25 census fields the balls could not, and is T41's 36-vector obstruction a family that proves T4?
  if many land and the obstruction is a family: T4 as a theorem for an infinite class — every real quadratic field with L ≤ 4 has χ = L, and a question posed in print is answered
  if few land: the census's nulls are about lattice depth, not the instrument; go deeper in the chain, or T4 needs a new idea and the cost is then known
  if the obstruction is not a family: the proof names exactly which arithmetic of 167 it used, and the next field's obstacle
  answered by: run — `Θ₃` trees on each field's open lattices, and a derivation of T41 with the twist as a parameter, ℚ(√47) as the control
  cost: one implementer, about 250k tokens and a day or two on the desktop; one derivation agent, about 300–400k
  hunch: at least half land — the census's nulls are mostly "over cap" or "asked, no refusal", the situation `Θ₃` was built for
  falsifier: fewer than 5 of 25 land at the census's own depth
  rank: 1

question: where-is-the-four-colour-wall-cheapest
  evidence: `plans/STUB-four-colours-167.md` §0 — "the four-colour hardness band is unmeasured"; `CLOSED-QUESTIONS.md` §1.7 — `L(ℚ(√47)) = 5` at every level, Moorhouse's question by name; `plans/FS73-derivation.md` T26 — 47's three-colour tree 2,997 nodes against 605,203 at 167
  expected: five at ℚ(√167) is the cheapest place to push the conjecture from below
  ask: is a four-colour refusal on a rank-4 lattice cheaper over ℚ(√47), where the conjecture predicts exactly five, than over ℚ(√167), where five confirms nothing?
  if cheaper at 47: the first real quadratic field needing five, the conjecture's five-clause met outside its proved classes, Moorhouse answered — and the price anchors 167
  if every lattice at 47 stays loose: the conjecture is under pressure where it predicts exactly (a G48 falsifier field), and five at 167 inherits the warning
  answered by: run — FS-79's phase-0 four-colour screen on ℚ(√47)'s chain, then one refusal ask on its densest survivor with the four-colour band measured on the known controls
  cost: one implementer, about 300k tokens; compute unknown until the band is measured
  hunch: cheaper at 47, by the three-colour analogy
  falsifier: 47's screen leaves no survivor where 167 left seven, or its refusals price higher
  rank: 2

question: prove-test-or-use
  evidence: `CLAUDE.md` § The mission (2) — "a belief held is a belief to be attacked where it is cheapest"; the programme's rule 6; the four stubs above
  expected: Kooshi wants the conjecture used to hunt six
  ask: should the next milestone prove the conjecture further, test it where it predicts exactly, or use it to hunt six at ℚ(√167)?
  if prove: card 1 (T4), with card 2's screen as its last phase
  if test: card 2 as the milestone, ℚ(√47) then 143, 311, 335
  if use: FS-59 at ℚ(√167), with card 2's calibration as its phase 0 and FS-80 as the certificate route
  answered by: Kooshi
  cost: one answer
  rank: 3

## 5. The recommendation for Kooshi (sent to the owner by SendMessage, 2026-09-24)

**Answer.** Make the next milestone the four-colour classification of real quadratic fields. Point the exact three-colour procedure
that proved χ(ℚ(√167)²) ≥ 4 at the 25 real quadratic fields the census left open, and ask whether the half-page proof at ℚ(√167) is
really a proof for a whole family of fields. Confidence medium. It is cheap, very likely to land something, a derivation for a class,
and an answer to a question asked in print. Five over ℚ(√167) should wait until the cost of refusing four colours on a rank-4 lattice
has been measured, and ℚ(√47) is the cheaper place to measure it.

**What I expected, and what reading changed.** Before reading FS-79's close I wrote that the next milestone should be FS-74 (why every
four-colouring of de Grey's lattice repeats with period 8Λ). Reading killed that: FS-73's own certificate has a half-page proof
(FS73-T41) that nobody has tried to generalise, which is cheaper and likelier than a human proof of a structure Hubai found by
computer. I also expected that the ℚ(√167) work had drifted away from χ(ℝ²) ≥ 6. That was wrong. ℚ(√167) is 6-open (no residue plane
can five-colour it), it is the smallest such real field, and every lattice over it has rank at most 4. So the conjecture predicts a
six-chromatic unit-distance graph inside a Cayley graph of ℤ⁴ there, the cheapest arena for six by rank. The record never says this in
those words, and it is the real long-run case for ℚ(√167).

**Candidates, ranked.**

1. **Every real quadratic field that can need four colours does (the census conjecture T4, G61), decided by the exact three-colour
   procedure.**
   - *Question.* The census (FS-61) proved four colours for 15 of the 40 fields ℚ(√d), d ≡ 11 (mod 12), below 500, the only real
     quadratic fields that can need four. For the other 25 it recorded nulls at its ball tiers. FS-73 then built an exact procedure:
     a lattice cannot be three-coloured exactly when its rotation set Θ₃ is empty. Does that procedure decide the 25 open fields? And
     is the 36-vector obstruction at ℚ(√167) a family?
   - *Why now.* The procedure landed on 2026-09-23 and was pointed at one field. G72's own rule is to point a new exact procedure at
     the open-instance list the same day, and the census's 25 fields are that list; nothing in FS-73's or FS-79's files touches another
     census field. G61 still says T4 has no route because "no witness transfers between fields". That was written before Θ₃ existed,
     and Θ₃ is a statement about a lattice, not a witness. T41 visibly uses 167 in one place only. The first twist, v = (83 + i√167)/84,
     is G7's type-M rotation, which every ℚ(√d) with d ≡ 3 (mod 4) carries. The second, z = (1+i)(15 − i√167)/28, exists because
     15² + 167 = 2·14². ℚ(√47) has the same three-layer shape, with twists (23 + i√47)/24 and (1+i)(5 − i√47)/12, and it is already
     certified to need four, so it is a ready positive control.
   - *What it buys.* On χ ≥ 6, nothing directly. On the conjecture: if T4 lands for a family, the proved range grows to "χ = L for
     every real quadratic field with L ≤ 4" (for the family), the first proof of the four-colour clause for an infinite class of fields not containing √3 (ℚ(√11) and nine others are single instances today).
     On the programme: it is rule 6 ("an object is finished when its derivation is") applied to FS-73's certificate. On publication:
     Moorhouse asked in 2010 "how much can the chromatic number grow for quadratic extensions … what about χ(ℚ(√47)²)?", Benda–Perles's
     Open Problem 11.6 asks for these values, and Fischer asked in 1990 for an algebraic criterion. Four colours for an infinite family
     answers a question posed repeatedly in print, the third publication category, which has never fired.
   - *Cost.* One implementer running Θ₃ trees on each field's open lattices: about 250k tokens and one to two desktop days (FS-73's
     tree at ℚ(√167) had 605,203 nodes; the 36-vector certificate has 1,050 leaves). One derivation agent for the family question:
     about 300–400k tokens. No competition unless the family question stalls.
   - *Wrong choice if* fewer than 5 of the 25 fields land at the census's own lattice depth (then the nulls are about how deep the chain
     goes, not about the instrument) and T41's four cases need a congruence only 167 satisfies. Owed before any claim: `[Johnson2006]`
     and `[Johnson2000]`, which `CLOSED-QUESTIONS.md` §1.7 names as the likeliest place for prior art on these planes, are unread.

2. **Five colours where the conjecture predicts exactly five: ℚ(√47), then ℚ(√143), ℚ(√311), ℚ(√335).**
   - *Question.* Is refusing four colours on a rank-4 lattice cheaper over ℚ(√47) than over ℚ(√167)?
   - *Why now.* FS-79 showed that no certificate read one cell at a time can refuse four colours, so five over any quadratic field is
     again a finite refusal, or FS-80's untested averaged certificate. The cost of a four-colour refusal has never been measured: FS-59
     §0 says "the four-colour hardness band is unmeasured", and the quoted prices (10⁸ to 10¹¹ points) are balls aimed by the
     three-colour degree law. ℚ(√47) is the place to measure it. Five is the conjecture's exact prediction there (L(ℚ(√47)) = 5 at every
     tower level, FS-66), the upper bound 5 is already in hand, Moorhouse named the field, and its unit vectors are much denser (its
     three-colour tree had 2,997 nodes against 605,203 at ℚ(√167)).
   - *What it buys.* The first real quadratic field known to need five; the conjecture's five-clause met outside its proved classes;
     and the measured price that says what five over ℚ(√167) will cost. If every lattice over ℚ(√47) stays four-colourable, the
     conjecture is under pressure where it is exact: ℚ(√47) breaks the 2-adic wall and is sealed at five by 11, G48's named falsifier
     shape.
   - *Cost.* FS-79's phase-0 screen re-run at d = 47 (one implementer, about 300k tokens; the tools exist), then one refusal ask on the
     densest survivor. The solver cost is unknown until measured, which is the point.
   - *Wrong choice if* the screen at 47 leaves no survivor at the depth where ℚ(√167) left seven, or its refusals cost more than 167's.
     It can stand as the last phase of candidate 1.

3. **FS-74: why every four-colouring of de Grey's lattice repeats with period 8Λ.**
   - *Question.* A readable proof that the pair (0, v) is forced, in place of the 2,044-point solver refusal; lead 1 proves on the
     lattice Hubai's 2018 description (two-colour stripes on the Eisenstein sublattice, plus one chirality).
   - *Why now.* It is the only known four-colour rigidity on a lattice, and five-colour rigidity in a 6-open field is what any chaining
     route to six needs (FS-78, FS-49). FS-79 sharpened it: the rigidity is not an edge-local height and must read windows wider than
     one square.
   - *What it buys.* Nothing on six directly; high on the programme: a forcer-grade certificate replaced by its reason, and the template
     for rigidity one colour up.
   - *Cost.* A derivation competition: from the anchors, about 1.2–1.5 million tokens (two competitors at 360–550k, an advisor at
     300–480k) and several days.
   - *Wrong choice if*, after the first round, neither competitor has a proof that every four-colouring restricts to stripes; from there
     it is a search for a structure Hubai already found by search.

4. **FS-59 and FS-80: five over ℚ(√167) directly.**
   - *Question.* Does some lattice over ℚ(√167) refuse four colours: by the owed screens on the seven survivors (quotients at N ≥ 16, a
     second Θ₄ finder), or by a window-frequency certificate kept small by the symmetry?
   - *Why now.* The survivors exist and the screens are cheap.
   - *What it buys.* A rung toward six in the smallest 6-open arena. For the conjecture a five here confirms nothing: the prediction is at
     least six, so only a six, or a colouring with five or fewer, says anything.
   - *Cost.* The screens are hours; FS-80 is a speculative competition, about 1.2 million tokens, and its own stub rates it low.
   - *Wrong choice if* a second finder shows the seven survivors loose (nothing left at the computed depth), or FS-80 meets its size no-go.
     The cheap screens (FS-59 steps 1–3) can run as idle compute beside anything else.

**The question behind the question.**
- *Is five over ℚ(√167) the right next target?* For testing the conjecture, no. Five there is consistent with the prediction (at least
  six) and cannot falsify it. FS-59 was two-sided when minted (a proof of three would have killed the conjecture's main clause), stopped
  being two-sided when four was proved, and still calls itself "the falsification target"; every route it now lists is a lower-bound
  route. A falsification at ℚ(√167) needs a colouring of the whole plane with five or fewer colours that comes from no single prime, and
  the only instrument in the record that could produce one is FS-64 (the adelic window colouring), which its own stub rates low.
- *Is ℚ(√167) the right field?* For five, ℚ(√47) is better on every axis I can check. For six, ℚ(√167) is right, and the record should
  say why: smallest 6-open field, lattices of rank at most 4.
- *Is G72 paying?* It paid once, at three colours, because the three-colour target's universal cover is a line, which gives a height.
  G73 proves that engine empty at four colours, and it is emptier at five and above. In FS-79 the structural question produced four
  no-go theorems and nothing that moved a target; the one instance result came from an exact computation. The count scored the no-gos
  as a win (P-G72, 0.8, "won"). I would change G72's killing test to count results that moved a target separately from no-gos; by that
  count the method is one for two. The next structural question should be posed where the invariant is known to exist: "for which
  fields ℚ(√d) is Θ₃ empty?" is G72's structural form over the class of fields, with the three-colour engine that works.
- *Derivation or something else?* A mix: an exact computation (Θ₃ on the census) aimed at a class derivation (T41 as a family).
- *Gaps in the stub table.* No stub proves T4 or runs Θ₃ on the census. No stub aims at five over the fields where five is predicted
  exactly. The programme statement's order of work (`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §5) is closed out (the lift by G45, the
  six-level design target by row 66) and has not been rewritten since 2026-09-07. The stub table's rank column repeats (rank 2 four
  times, 3 six times, 4 four times, 8 three times), so below rank 1 it no longer orders anything.

**Unread or surprising for this choice.**
1. The census's 25 open fields have never met Θ₃.
2. Stale claims: Frontier item 10 says "four or five for ℚ(√47)" is met, but FS-66 settled L(ℚ(√47)) = 5 at every level, so the
   prediction is five and the bracket 4 ≤ χ ≤ 5 does not meet it. The target paragraph's "one cheap exposed prediction left … ℚ(√167)"
   leaves out ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3,√5), where the conjecture predicts exactly five against a proven four. G48's
   falsifier list ("so next ℚ(√167)") skips ℚ(√47) the same way.
3. P-G54 (Γ₂₃ slack at four colours, 0.8) is unscored because FS-79 phase 0's step 0 was never reported; a character sum, seconds.
4. `[Johnson2006]`, `[Johnson2000]`: unread, owed before any T4 claim.
5. A zbMATH hit not in `BIBLIOGRAPHY.md`: *Circular coloring the plane* (2007), from `ab:"circular chromatic number" & ab:"unit distance"`.
   Every Θ_k point is a circular colouring, so it bears on FS-80 and FS-64. Recalled, not read. (Also run, zero hits:
   `ab:"unit distance" & ab:"quadratic field"`, `ab:"chromatic number" & ab:"real quadratic"`.)
6. A question I could not settle, handed to FS-64: can one character of the unit-vector ring put every unit vector of a whole field in
   the band [1/k, 1 − 1/k]? By compactness this holds exactly when every lattice in the field's chain has a Θ_k point, so a yes at k = 5
   over ℚ(√167) would falsify the conjecture. My guess is that such a character must have finite image on the unit vectors, so it
   reduces to Fischer's additive colourings, which need at least 11 colours at ℚ(√167); then the seven survivors are exactly where
   circular colourings are predicted to die. My sketch breaks at one step, so this is a question, not a claim.

**The one question for Kooshi.** Should the next milestone *prove* the conjecture further where it can be proved (T4 over real quadratic
fields), *test* it where it predicts exactly (five at ℚ(√47)), or *use* it to hunt six at ℚ(√167)?
- *Recommendation:* prove first. Candidate 1, with candidate 2's ℚ(√47) screen as its last phase, which yields the measured price that
  decides when five over ℚ(√167) is worth starting.
- *Alternative weighed:* FS-59/FS-80 at ℚ(√167) now. Higher ceiling (the smallest arena for six), but every certificate format FS-79
  examined is empty and the finite route's cost is unmeasured, so it would start blind.
- *Why prove wins:* roughly two to four times cheaper in tokens, very likely to land something, a derivation for a class, and the one
  result in reach that meets the publication bar.
- *Confidence:* medium. It changes if the first day of Θ₃ runs lands fewer than 5 of the 25 fields and T41 turns out specific to 167;
  then candidate 2 becomes the whole milestone.
- *Default if Kooshi says nothing:* the stub table's top, FS-59 (five over ℚ(√167)), which is candidate 4 here.
