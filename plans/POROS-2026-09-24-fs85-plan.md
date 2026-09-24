# Poros (plan phase) — FS-85, "can four-colour rigidity exist without triangles?"

Advisor to the FS-85 planner (agent `a5d70618e4c88d2ac`) through the reframe and subplan. Owner: the coordinator ("main").
Record kept in scratch until the competition ends. Held material is in `HELD.md` only.

## 0. My expectation, written 2026-09-24 before any exchange with the planner

Read before writing: the brief; Poros core + both companions; the FS-85 stub in full; `CLAUDE.md` G74 (from disk) and the
snapshot's G51/G54/G55/G57/G62/G68–G73; `LEDGER.md` rows 78–84 in full; `plans/FS79-derivation.md` theorem list and T34–T37 in full;
`plans/FS73-derivation.md` theorem list. **Not yet read** (read against this expectation next): the algebra-week record §4–§6, the
FS-74 stub, the close inventory, `CLOSED-QUESTIONS.md` §3, the protocol §1/§3, FS73-T6/T7 bodies, FS79-T17–T33 bodies.

### 0.1 What I expect to bear

- **G73 + FS79-T18–T24 (rows 80):** the only edge-local four-colour height lives on a sum-closed half `±{a,b,a+b}` — a triangle.
  This is the stub's whole reason for the triangle axis. Expect the planner to lean on it; expect it to be a *format* no-go, not a
  statement that triangles are the mechanism of rigidity (row 80 says so in words: "no-gos of four named formats, not of a kind of
  invariant").
- **FS79-T28 (the rhombus lemma):** four unit vectors of the plane with zero sum form two opposite pairs. With G57 (no √3 ⟹ no
  three-term zero sums), a triangle-free unit-distance lattice has **no nontrivial relation of length ≤ 4**. This is the property
  that separates the unit-distance class from the abstract sum-free class. I expect it to be marked *bears* or be missed; if missed,
  it is my rank-1 card.
- **FS79-T35/T36 (rank-1 exact criterion and scan):** in rank 1, `F ≠ 0` at four colours ⟺ every cyclic phase is a single cycle and
  there is no wall. The scan's record `data/fs79/comp-debruijn/runs/rank1_scan.jsonl` is a finished output that has not been read
  for this question (see 0.5).
- **FS79-T37 + G14:** each non-Eisenstein unit vector of de Grey's lattice is alone in its Eisenstein coset; matchings carry no
  pressure. So step 1's mechanism must run through cycles meeting ≥ 3 cosets.
- **G70 (hexagon lemma, √3-clean ⟹ residue) and G54's reading** (a full-rank F appears where the lattice is integral at a prime whose
  target is Hoffman-tight at k and no other prime has a gap — K at 2, `K₄ × K₄`): the likeliest *arithmetic* account of step 1.
  G71's killing test ("at four colours the arithmetic must enter") stands unmet; G72 asks to strip the arithmetic. Tension expected.
- **FS79-T1 (three-colourable ⟹ loose at four), G68 (gap ⟹ free), row 81 (full-dimensional Θ₄ cell ⟹ loose):** the known sufficient
  conditions for `F = 0`. Any "no" theorem for step 2 has to go through something at least this strong for every triangle-free
  4-colourable graph in the class.
- **G55 + FS79-T2:** the chain needs δ a unit at every stable prime. A "yes" is only worth five colours if it lands there.
- **G62 / G74 (layers):** triangle-free field lattices are multilayers of the rational pattern `U₅`; the layer method is the house's
  one field-level tool and it is one-sided from four colours up.
- **Silent, I expect:** G1–G13 except G9, G20–G29, G44–G47, G56, G58–G60, G63–G66. **Falsifiable here:** G71's reading, G73's reading
  (residue labels), G54's reading (tight prime ⟹ full-rank F), G72's method (count).

### 0.2 Which disciplines own the object (their words, not ours)

"A pair of vertices every proper four-colouring identifies, on an abelian Cayley graph with no triangles":
1. **Graph theory / colouring:** *uniquely colourable graphs*; the Zykov–Hajós identification (`u,v` forced equal ⟺ `G + uv` is not
   k-colourable); **equality gadgets in triangle-free and large-girth graphs** (Nešetřil 1973, uniquely k-colourable graphs of any
   girth; Müller 1979; Emden-Weinert–Hougardy–Kreuter 1998, used for NP-hardness of colouring graphs of large girth). *Recalled, not
   read.* Consequence if right: **in finite graphs, triangle-free forced pairs are classical**, so step 2's content is entirely in the
   Cayley / abelian / lattice constraint, never in "triangles" alone.
2. **Symbolic dynamics:** the *hom-shift* `X(ℤ^r, S, K₄)`; a forced pair at δ = every point of the SFT is δ-periodic; *frozen*
   (Alon–Briceño–Chandgotia–Magazinov–Spinka 2021); topological entropy (a δ-periodic ℤ^r shift has zero entropy); *periodicity and
   decidability of tilings* (Bhattacharya 2020 in ℤ²; Greenfeld–Tao's counterexample in high dimension); the Kari–Szabados algebraic
   approach to periodicity (annihilating polynomials). *Recalled, not read.*
3. **Additive combinatorics:** triangle-free abelian Cayley graph ⟺ **sum-free connection set**; chromatic numbers of Cayley sum graphs;
   Payan's theorem (cube-like graphs are never 3-chromatic) as the model of a parity obstruction on an abelian Cayley graph.
4. **Statistical mechanics:** zero-temperature 4-state antiferromagnetic Potts model; ground-state degeneracy, long-range order
   (Peled–Spinka's *rigidity* is typical-colouring order, another notion — the house already flags this).
5. **Distance graphs / circular colouring** (rank 1): Eggleton–Erdős–Skilton; Zhu's classification of `χ(G(ℤ,{a,b,c}))` (4 only for
   `{1,2,3k}` and `{a,b,a+b}` — both with a Schur triple — *recalled, not read*).
6. **CSP / universal algebra:** implied equalities (backbone); `K₄` is a core with only projective polymorphisms.

### 0.3 What a good structural form looks like

- About **every** four-colouring of every graph in the class, answerable only by an invariant (G72 item 2).
- **Two-sided**: either answer is a theorem (a "no" with the invariant that frees every pair; a "yes" with the invariant that pins).
- The class named so the **realisability gap** is explicit: the abstract class (sum-free `S ⊂ ℤ^r`) vs the unit-distance class
  (`S` on the unit circle, point-group invariant, rhombus lemma, no relation of length ≤ 4). A "no" in the abstract class transfers
  down; a "yes" there does not transfer up to Soifer 55.1.
- It separates "contains a triangle" from "uses a triangle": the stub's premise ("every forced pair known **uses** a unit triangle")
  is a presence claim; step 1 is what converts it into a use claim.
- A bad form: the existence form negated ("is `F = 0` for every triangle-free `S`?") — same question, no invariant named.

### 0.4 Where I expect a plan for this to go wrong (pre-mortem)

1. **Class mismatch**, either way (0.3). The planner picks "Cayley graphs of ℤ^r with sum-free S" (G72's most general class) and does
   not name what the unit-distance class adds; a competitor proves or refutes something that does not reach any field.
2. **The mis-levelled control.** Λ₁₀ at three colours is triangle-free and rigid — but at three colours the absent clique is `K₃ = K_k`;
   the four-colour analogue of "no `K_k`" is "no `K₄`", which every unit-distance graph satisfies (de Grey's lattice is the example).
   So the stub's "triangle-free and rigid at three colours" does not test the triangle mechanism at all. The controls that *do* test
   it are **triangle-full and loose** lattices (FS-73's table: every CM-subfield lattice of ℚ(√3,√5) etc.) — a step-1 mechanism that
   also "proves" rigidity there proves too much.
3. **Unreachable killing test.** "Neither has stated with a proof what a triangle-free rigidity would require" fires only if nobody can
   write *any* necessary condition — and trivial ones exist (χ = 4 exactly; zero entropy). Expect the day-2 test to be unfailable
   unless the second clause is sharpened.
4. **A cheap "paid" verdict.** Outcome (b) "decided in a named class" is reachable by a tiny class (rank 1, `|D| ≤ 5`) that says
   nothing about fields. The scope must be registered with the outcome.
5. **Step 1 lands, step 2 learns nothing (a draw that reads as paid).** If de Grey's triangles are used "everywhere" (the Eisenstein
   sublattice's Moore–Newman height), step 1 does not isolate a lemma that a triangle-free lattice would need to replace.
6. **Search leaking back** as "exact computer-algebra checks" over families (a rank-1 scan is a search), or as a Θ₄ cell computed by a
   finder rather than written down.
7. **The arithmetic stripped too early.** G72 says strip it "when it can be"; G71's reading and G54's say it may be exactly what makes F
   full-rank at four colours. A plan that strips it has to say so as a registered bet.

### 0.5 A finished output nobody has read for this question

`data/fs79/comp-debruijn/runs/rank1_scan.jsonl` (FS79-T36; 2,706 rank-1 sets `D`, `11 ≤ max D ≤ 14`, `3 ≤ |D| ≤ 5`, gcd 1). Read against
the expectation "some sum-free set among the rigid ones" (my prior: abstract freedom is large). **Surprised:**
- 377 sets have every cyclic phase rigid and no wall, i.e. `F ≠ 0` at four colours — **none is sum-free** (every one has `a + b = c`
  in `D`, `a = b` allowed).
- 600 sets are sum-free; **550 are three-colourable** (exact rank-1 `Θ₃` check on endpoints `k/(3d)`, seconds), so their `F = 0` is
  free by FS79-T1; **50 are exactly four-chromatic and triangle-free, and not one is rigid**.
- 194 sets refuse four colours; none is sum-free.
Scope: rank 1 only, a typed null on that range, measured, not a theorem; rank-1 Cayley graphs are never unit-distance lattices.

## 1. Exchanges

### 1.1 Planner → Poros, card 1 (before its §G draft)
Four early §PA finds: (1) `[Polymath16wikiR2]` holds hand tools for step 1 (renormalisation ρ_z over 𝔽₄, convexity lemma, Props 6–7,
Cor. 9), never cited by FS-74; (2) Hubai's June 3 2018 five-rotation derivation of the 8/3 shift from chirality, Gibbs's June 4 plan,
MASCOT-T10's `[Parts2020hv]` striping lemma — all on the ring R₂ or on ℤ[ζ₆], none on Λ; (3) step 2 is trivially yes in all graphs
(5-critical triangle-free minus an edge); its content is translation invariance; Klotz–Sander 2017 Problem 3.6 (uniquely colourable
circulants have χ = ω?) answered no at three colours by Bašić arXiv:2609.03184 with a triangle-free uniquely 3-colourable integral
circulant family; four colours not found; (4) the same rank-1 scan reading as my §0.5. Intended class: Cay(ℤ^r, S), S triangle-free,
r ≥ 1, a rank-1 theorem candidate, the chainable δ as the target that matters. Asked: what bears that I expect marked silent?

My read against §0: the planner's finds are ahead of my expectation on the prior art (find 1–3 I had not read; find 3 matches my
0.2 item 1 and adds Bašić). No surprise that contradicts §0.

### 1.2 Poros → planner, reply 1 (sent)
Ranked: (1) FS79-T28 rhombus lemma = the realisability gap between sum-free S and unit-distance S; name which way each outcome crosses;
(2) transfer direction of the held step-1 tools (forcing monotone upward: tools on a larger graph R₂ do not restrict to Λ; tools on
ℤ[ζ₆] do) — ask which edges each uses; (3) type the rank-1 null: 550 of 600 sum-free sets are 3-colourable (free by FS79-T1), the
informative population is 50; step 2 lives only at χ = 4 exactly; (4) the controls are mis-levelled — Λ₁₀ tests K_k-freeness, not the
triangle at four colours; the controls that test the triangle's use are triangle-full and loose (ℤ[ζ₆], FS-73's ℚ(√3,√5) table);
(5) G54/G71: stripping the arithmetic is a bet to register. Plus: the day-2 killing test's second clause can be met trivially
(χ = 4; zero entropy), so it cannot fire as written.

### 1.3 Owner → Poros (logged as close-inventory items 11–13, commit 424226b5)
The owner recounted the rank-1 reading and it holds (377 sets all-rigid, 0 with walls, 0 sum-free; the 550/50 split). **Its addition:** 27 of
the 50 sets that are exactly four-chromatic and triangle-free have a rigid phase beside a loose one. So isolated rigid (frozen) phases
occur without triangles in rank 1, and only an all-rigid set is absent. The soft killing test is logged as a defect in the stub
(item 12). The owner will score the plan's replacement for reachability.

### 1.4 Poros → planner, note 2 (sent)
I passed on the owner's 27-of-50 datum, credited to the owner. The question: does §IQ's structural form separate "some four-colouring
is frozen" (seen without triangles) from "every four-colouring is frozen" (the forced pair, never seen)? If it does not, a frozen
colouring answers the form "yes" while forcing nothing.

### 1.5 Planner → Poros, card 2 (the full draft, `plans/FS85-rigidity-without-triangles.md`, uncommitted)
The planner reported all seven of my points adopted (§Y), and S2 now separates "some colouring frozen" from "every colouring frozen".
It also corrected itself: Klotz–Sander and Bašić were already in BIBLIOGRAPHY § C from FS-38, a second G50 instance. It asked four
things: silent entries that bear (it was least sure of G9, G60, G66 and rows 26–27); whether §S.4 can fire and pass, whether K3 can be
gamed, and whether T is complete; §P's reachability and probabilities; and any route leakage in §C.

Read: §0, §G.1, the silent list in §G.2, §IQ, §S (all), §C (all), §P. Against my §0 expectations:
- my pre-mortem items 1, 2, 3 and 6 are addressed;
- item 4 (a cheap "paid") is addressed in P-S2 but not in P-V;
- item 5 (step 1 lands, step 2 learns nothing) is addressed by the Paid note;
- item 7 (the arithmetic stripped too early) is registered as P-arith.

### 1.6 Poros → planner, reply 2 (sent)
(1) G60 and G66 bear through their FS-73 addenda: the chain F ⊆ F_μ ⊆ F_meas ⊆ P. A "no" at P or at F_μ implies F = 0; a "yes" must be
at F. Add F ⊆ F_μ to T. The planner read the entries' titles, not their addenda (a G67 instance). G9 and row 26 bear on the premise:
the 791-core's forced pairs at 4 and 4/√3 are 2R distances. (2) K2 can be gamed: its "not already known loose" is met by any graph
nobody has examined. Fix: X must fail on a named graph on which every item of T holds or is undecided. K3 can be gamed by a family
defined through a held sufficient condition. Fix: name the family by a property of S. Missing from T: every colouring frozen, the
Kempe period groups, F_μ, FS79-T35 in rank 1, and the quotient restatement. (3) P-task0 is already decided by row 78 (η^{±3} ∉ Λ), so
its "no" branch cannot happen: re-register it. P-V's Paid admits a rank-1-only or abstract-only result: register Paid at two scopes.
No probability disputed by more than 0.15. (4) §IQ item 3 names step 1's invariant (the per-coset type of ρ_z plus a chirality) and
the competitors read §IQ. That is a route handed to both, and it weakens P-S1b's independence. Point them to items 1, 2, 4 and 5
only, or label item 3 as a hypothesis. None of my held items leaked.

### 1.7 The planner's dispositions (plan §Y, commit f3915acf; the owner's §R-review, commit 39ad44b6)
Adopted: points 1–9, 11 and 12, and the second card. Two planner retractions: the silent verdicts on G60/G66 and on G9/row 26.
**Point 10 (P-task0) was decided the other way.** The planner's exact check (FS85-A1, which the owner re-verified exactly with sympy)
found η, η² and η^{±3} all in Λ = (1/9)O_E. So row 78's and FS73-T6's clause "η^{±3} ∉ Λ" is false as written, and my claim "P-task0 is
already decided by the record" rested on a false ledger sentence. P-task0 was scored lost; P-wiki and P-K1held were registered in its
place.

### 1.8 At stand-down (the owner's request for a final report)
HELD.md was made final and self-contained. H3 is withdrawn (my error: wrong dyadic target). H5 (the dyadic K₄ target in wall-standing
triangle-free fields, ℚ(√59) and ℚ(√83)) and H6 (the fields already free by row 66) were added. Neither went to the planner. FS-73's
TABLE.md was checked: its one wall-standing triangle-free row, over ℚ(√11), is loose by a gap at N = 5.

## 2. Retraction count

**Poros 1 · planner 2.**
- Poros: "P-task0 is decided by row 78". I asserted a membership fact from a ledger sentence, when the exact check took seconds, and the
  sentence was false. Withdrawn. The planner counted it against the record; I count it against myself too.
- Planner: the silent verdicts on G60/G66 and on G9/row 26, both corrected to "bears".

## 3. My own errors

1. **P-task0.** I cited a ledger clause (row 78: "η^{±3} ∉ Λ") as deciding a prediction, without an exact membership check, which
   costs seconds. The clause was false (FS85-A1). This is the G21 / G50 pattern: I asserted on the written record rather than on the
   artifact.
2. **H3 as first written** named U₄ (the Clebsch graph) as the dyadic target at d ≡ 3 (mod 8). The target is U₂ = K₄: the dyadic prime
   there has norm 2. It was held only, never sent, and was corrected at stand-down into H5.
3. **A scope slip in H5's first draft**, caught before stand-down. It said "every screen in a triangle-free field ran in a wall-broken
   field". FS-73's table has a wall-standing triangle-free row over ℚ(√11) (loose by a gap at N = 5). Corrected by reading TABLE.md.

## 4. "Would have searched here" log

- The rank-1 reading was a read of an existing output plus an exact endpoint check. It enumerated no new objects, so it is not a line.
- **Would have searched:** when forming H5, my default next move was a periodic or quotient four-colouring screen of a saturated
  lattice over ℚ(√59), to see whether it has a gapped colouring. **Instead:** it is registered as a held prediction whose falsifier is
  an exact 2-adic Smith-form computation, which is in scope this week.
- Reading FS-73's TABLE.md was a read of a committed record, not a search.

## 5. For the competition advisor

- **§S.4's killing test** is reachable both ways as committed.
  - K2 and K3 were tightened: X must fail on a named graph on which every item of T holds or is undecided; K3's families must be named
    by a property of S.
  - Adjudicate K2 against all twelve items of T.
  - The likeliest false pass is a competitor "proving" that every colouring is **frozen** (no finite Kempe component). That is T's
    trivial item, not a K2 result.
  - K1 is reachable in a day if Task 0's membership list comes back favourable. FS85-A1 says η, η² and η^{±3} all lie in Λ, so the
    wiki's propagation may run on Λ largely as written. That makes K1 likelier than the plan's P-S1a (0.40), and it makes a step-1-only
    pass likelier than the plan assumed. The owner's ruling scores a Part-1-only outcome as Draw (K).
- **Convergence risk on Part 1: high.**
  - Both competitors are handed the same held tools in detail: the wiki's ρ_z, its Lemma 1 and Props 6–7, and Parts's striped formula.
  - With η^{±3} ∈ Λ, the wiki's own route probably transfers.
  - Expect both first routes to be "run the wiki on Λ".
  - Independence for P-S1b ("two independent derivations") will then be nominal. Judge it by whether the two derivations differ in the
    step where the non-Eisenstein couplings enter, not by who wrote them.
  - To break the convergence: ask each competitor, early, what its account predicts on the triangle-full loose controls, and where
    exactly a triangle is used. The two answers are likelier to differ than the routes.
- **Part 2: offer H6 early, to both at once** (frame-level; it removes the fields row 66 already frees). Then offer H5 after the first
  routes. H5 is the one held item that could turn Part 2 into a "yes" in 𝒰^tf, never chainable, and it would move P-S2(i) and P-arith.


## Evidence inventory

- `data/fs79/comp-debruijn/runs/rank1_scan.jsonl`, FS-79's rank-1 scan — read against: some sum-free set among the 377 rigid ones — surprised: yes (none; 50 four-chromatic sum-free sets, all loose)
- the FS-85 stub, `plans/STUB-four-colour-rigidity-without-triangles.md` — read against: a structural form that is about every colouring and a class naming its realisability gap — surprised: yes (the Λ₁₀ control is mis-levelled; the day-2 test's second clause is soft)
- `LEDGER.md` rows 78–84 — read against: the forced pairs held all live on triangle-full lattices; the loose ones triangle-free — surprised: no
- the algebra-week record §4–§6 — read against: the choice argued from the finite-witness/infinite-certificate cut, with the triangle axis taken from G73 — surprised: yes (its C1 hunch "yes somewhere in the abstract class, since three-colour rigidity exists without triangles" rests on the mis-levelled Λ₁₀ analogy, basis analogy; the rank-1 record leans the other way at its scope)
- the FS-74 stub (leads 1–5, the FS-79 re-aim banner) — read against: Hubai's stripes as the lead, the triangle's use unlocated — surprised: no (lead 1 already says R₂ is closed under η and Λ is not, and that 8Λ does not transfer from the ring; lead 4's Baxter/Kondev–Henley height is where a coset height lives)
- `CLOSED-QUESTIONS.md` §3 — read against: Soifer 55.1 as a five-chromatic triangle-free UDG question, not a forced-pair question — surprised: no (it is a five-chromatic question; a forced pair answers it only through the chain in a wall-broken field)
- the protocol §1/§3 — read against: content-free hand-backs, isolated scratch, identical briefs — surprised: no
- the close inventory — read against: owner-only; nothing for me to act on — surprised: unread (not needed yet; owner's file)
