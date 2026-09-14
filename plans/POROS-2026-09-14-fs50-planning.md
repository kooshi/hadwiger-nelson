# Poros — FS-50 planning pass (2026-09-14, before the planner)

*Advisor's report on the PLANNING of FS-50, "is α(UD(𝔽₈₃, 2)) ≥ 1,149?". Written for a planner with zero conversation
memory. Everything below was read against an expectation written before the reading (§1); every number I cite was
recomputed here in exact or float arithmetic from the primary records, never copied from a summary; every citation I
could not open is marked "recalled, not read". I spawned nothing, ran no solver, and used only seconds of numpy.*

**The verdict in one paragraph.** The plan as stubbed (phases B–C: cube-and-conquer over the rotation orbits, cardinality
encodings raced, proof logs, the server if needed) is aimed at the wrong proof system, and the record already shows it:
at 23 the monolith is undecided at 840 s at **every** size tried, including 140, 130 and 125, which lie *above* the ratio
bound 131.76 and are refuted on paper by one line of spectral arithmetic (`data/fs50/race23/nscale/`, the coordinator's
datum). A solver that cannot rediscover Hoffman at 529 vertices will not certify 4.2% *below* Hoffman at 6,889. The
statement "α ≤ 1,148" is a counting fact about a graph that is, at the resolution of everything measured, a
pseudo-random 84-regular Cayley graph with a Ramanujan-grade spectrum — and on such graphs the only known certificates
of independence bounds are sums-of-squares (spectral) certificates: degree 2 *is* Hoffman (1,199), and the 51-point gap
to 1,148 needs the next level. So the certificate's shape should be **an exact rational dual certificate of the
triple-level (Schrijver 2005 / Terwilliger-algebra) semidefinite bound, block-diagonalised by the point stabiliser
O(2, 83)** — 86 blocks of size ≤ 83 and about 48,000 variables at 83, a desktop job, not a server one — and the *first*
measurement of the milestone is that bound at p = 11 (an afternoon), where one number decides whether the line lives. I
give it a medium chance of reaching 1,148 at 83, a high chance that nothing resolution-based ever will, and a high
chance that α(83) is nowhere near 1,149 (registered below with its falsifier). Two reframings follow: the milestone's
durable product is *the first upper bound on α of any finite Euclidean plane below the ratio bound* (the prior-art gate
found none at any p), of which the 83 digit is one application; and "the first digit at 83" is not a choice between 6
and 7 — the same reading puts χ(UD(𝔽₈₃, 2)) at 10 or more, which changes nothing for the conjecture (it only needs
"≤ 6?") but changes how the record should speak about "the floor 6".

---

## 0. The frame, on its five axes (so it can be pushed back on)

| axis | as the stub has it | what the reading moved |
|---|---|---|
| object | an independent set of size 1,149 in a 6,889-vertex graph | a 0/1 vector forced to carry ≥ 76% of its Fourier mass on a 336-dimensional eigenspace (§3.1) — a *spectral* object |
| question | "is α ≥ 1,149?" (a bit) | "how far below the ratio bound does the truth sit, and which proof system certifies any of it?" — the bit falls out |
| discipline | SAT / cube-and-conquer (the house pipeline) | spectral graph theory and the SOS hierarchy (the Paley-clique literature); the SAT pipeline is the wrong room for this wall (§2) |
| audience | the reviewer who trusts no Python and wants LRAT | the same reviewer, better served: an exact rational SDP certificate is checkable by a 200-line exact-arithmetic script, where 20 GB of LRAT was "generated, never checked" (M63 H2) |
| product | χ ≥ 7 at 83 on the solver's word, kernel if affordable | a bound below Hoffman at 11 → 23 → 83 as a table (new at every p), with 83's digit as its application; kernel form a two-step stub, not this milestone's deliverable (§Q4) |

The product and audience lines are Kooshi's to move; §Q5 puts them to him as cards with defaults. The other three are
the frame's and I have moved them in this report.

## 1. Evidence inventory

*Expectations were written to my scratch file before each item was opened (`~/.claude/jobs/b1507518/tmp/poros-fs50/inventory.md`).*

- `plans/STUB-independence-threshold.md` — read against: phases PA–F, P1–P5 both-reachable, the ladder 28 / ≥76 / ≥87 / ≥597 against thresholds 25 / 73 / 106 / 1,149 — surprised: yes; "every relaxation is blind" (§1) covers only pair-scheme relaxations (Schrijver 1979), not the triple level; and "19% loose at 11" is stated as a constant while the four ratios α/Hoffman it quotes — 0.81, ≥0.76, ≥0.66, ≥0.50 — are a curve falling with p
- `plans/FS50-prior-art.md` — read against: Schrijver 1979 named; the real-plane LP lineage named; no pricing of Schrijver 2005 / the Terwilliger algebra; the LP fades 12% → 0.2% — surprised: yes, on two counts: the triple-level bound is absent from both the search and the verdicts, and the fade is reported as a measurement with a reading ("the extremal g concentrates where no small graph constrains it") where a mechanism is derivable (§3.3)
- `data/fs50/README.md`, `data/fs50/lp-attribution.json` — read against: one row per file; which graph bites where — surprised: yes; the attribution table carries a law nobody wrote down: a graph's rows bite only when its own independence ratio α_V/|V| sits within ≈ 0.06 of the plane's Hoffman ratio (spindle 2/7 = 0.2857 against 0.2855 at 11 → 12%; triangle 1/3 against 0.2855 / 0.249 / 0.174 → 7.5% / 3.8% / 0.2%; rhombus 1/2, wheel 3/7, circle 1/2: never)
- `data/fplane/README.md` (the FS-40 sections), `alpha-p{11,19,23}.json` — read against: the census's open rows are the low-order fixed-colour τ's; α(11) = 28 by a solver refusal — surprised: no
- `~/source/descent-engine/plans/WO-18-outcome.md` and `data/fs50/wo18/*.json` — read against: 505 = 6·84+1, 589 = 14·42+1, 533 = 19·28+1, 595 = 99·6+1, 581 = 7·83; chain 597; plane 574 @600 s; a rate reconciliation that balances — surprised: yes, once the sets themselves were opened (§3.1): the 597-set puts 1.7% of its Fourier mass on the λ_min eigenspace (uniform would be 1.2%) — a random-like object — where the exact optimum at 11 puts 70% there and the 87-set at 23 puts 51%
- `data/fs50/race23/SUMMARY.json` (+ `nscale`, the coordinator's datum), `race19/SUMMARY.json`, `tools/fs50_race.py` — read against: cube c = origin + a point of class c pinned, classes 1..c−1 excluded; cliff between classes 10 and 12 at 23, 6 and 8 at 19 — surprised: yes; recomputed, the cliff is one number: cadical refutes when the residual density it must certify is ≥ ≈ 0.41 (23: cube 10 needs 0.394 → unknown, cube 11 needs 0.433 → 132 s; 19: cube 6 needs 0.341 → unknown, cube 8 needs 0.417 → 28 s) and the monolith at N = 140 needs 0.276 → unknown; the whole plane at 83 needs 0.167 — so no cube of the min-class tree reaches the solver's regime before ≈ 46 of 81 classes are excluded, and those 46 cubes are each the monolith
- `data/fs50/maxsat/SUMMARY.json` — read against: RC2 stalls above the ratio bound — surprised: no, and the mechanism is nameable: core-guided lower bounds are clique-cover-shaped, and with ω = 3 (3 is a square mod 83, `[Krebs2022]`) every clique-based bound is ≥ n/ω = 2,296 at 83 — above Hoffman by a factor two
- `plans/M63-phaseH2-solver.md` §10, §14a, §17 — read against: the certificate shape FS-50 would reuse — surprised: no; the record itself says the logs were never checked and prices kernel promotion at ~600,000 LRAT lines per cube as declined (row 40)
- the spectrum of UD(𝔽₈₃, 2), recomputed here from character sums — read against: λ_min = −17.71, Weil −18.22 — surprised: yes, in the ordering: λ_min = −17.709, then −16.695, −16.26, −14.23, −13.35; the plane's λ_min sits *inside* the Ramanujan bound 2√83 = 18.22, i.e. spectrally the plane is as random as a regular graph can be
- the absent (`data/fs50/`, `data/fplane/`, the two plans): a computed value of the triple-level bound at any p; a Fourier profile of any found set; a random-graph baseline beside the greedy 358 — read against: a record that has priced every relaxation would hold the first, a record that has read its own sets would hold the second, a record calling the ratio bound "19% loose" would hold the third — surprised: yes; none of the three exists (the greedy 358 is exactly the random greedy (ln d/d)·n = 363), and these three absences are where this report's content comes from
- the conditions of the last reading: every summary in `data/fs50/README.md` and the stub was written on 2026-09-14 by the same mind that ran the day's runs, at the end of a long day — read against: the calibration at 23 should sit at the same relative position to Hoffman as the ask at 83 — surprised: yes in one place: the 23 calibration was run at the *five-colour* threshold 106 (80% of Hoffman), which is FS-17's question and not a like-for-like calibration of 83's ask (95.8% of Hoffman); the `nscale` datum then made the distinction moot for SAT (undecided at every N), and it survives as the calibration rule for the SDP (§Q1: the fraction of the Hoffman-to-truth gap closed, not the threshold)

## 2. Said for a stranger (the object in the discipline that owns it)

*For a spectral graph theorist who has never seen this repository.* Let G be the Cayley graph on the abelian group
𝔽_p² (p = 83) whose connection set is the unit circle {u : u·u = 1}, an algebraic curve with p + 1 = 84 points; G is
84-regular on 6,889 vertices, its eigenvalues are the Kloosterman-type character sums over the circle, so λ_min = −17.71
lies inside the Ramanujan value 2√(d − 1) = 18.22, and Lovász's ϑ equals the Hoffman ratio bound 1,199.46 because G is
edge-transitive (`[Lovasz1979]` Thm 9; `[Schrijver1979]` says no relaxation over the pair scheme does better). We want to
certify α(G) ≤ 1,148, i.e. 4.2% below ϑ — equivalently χ_f(G) > 6, since for a vertex-transitive graph χ_f = n/α.

Three facts the stranger's field already holds (the first two derived here from the record, the third recalled):

1. **The graph behaves like a random regular graph wherever we have looked.** The greedy independent set is 358, the
   random-regular greedy value (ln d / d)·n is 363; the found ratio α/ϑ climbs the ladder 0.81 / ≥0.76 / ≥0.66 / ≥0.50 at
   d = 12 / 20 / 24 / 84, and the random-regular prediction ln d / √d is 0.72 / 0.67 / 0.62 / 0.48 — tracking, a little
   above (the Cayley structure's contribution). Frieze–Łuczak's asymptotic α(G_{n,d}) ≈ (2n/d)(ln d − ln ln d + 1 − ln 2)
   gives 533 at d = 84; the first-moment ceiling (2 ln d / d)·n gives 727; the found 597 sits between them. *Recalled,
   not read:* Frieze–Łuczak 1992 for the formula; the greedy value is folklore.
2. **The proof systems and where each stops.** Clique-based reasoning (core-guided MaxSAT, clique cuts in an LP or MIP,
   Krebs's n/ω) is capped at n/ω = 2,296 because ω = 3. Resolution over a cardinality circuit cannot reproduce ϑ at all
   (the `nscale` datum; the k-clique regular-resolution lower bounds of Atserias–Bonacina–de Rezende–Lauria–Nordström–
   Razborov say why on pseudo-random graphs — *recalled, not read*). Degree-2 sums-of-squares certifies exactly ϑ = 1,199.
   The gap to 1,148 needs degree ≥ 3, i.e. the triple-level relaxation (Schrijver 2005's bound in the Terwilliger algebra
   of the point stabiliser; Gvozdenović–Laurent 2008's block-diagonalised hierarchy — *recalled, not read*).
3. **The nearest studied cousin is the Paley graph**, a Cayley graph on 𝔽_p with a pseudo-random spectrum where ϑ = √p is
   far above the truth; there, the degree-4 SOS bound improves on ϑ by a constant factor at small p (Kunisky–Yu 2023;
   Gvozdenović–Laurent numerics — *recalled, not read*), and Barak et al.'s planted-clique lower bound says low-degree SOS
   never beats √n by more than constants on random graphs. Our ask is a constant-factor improvement of 4.2%: inside what
   the cousin's literature reports, and far from decided by it.

**The wall, in the stranger's words:** "certify a constant-factor improvement over ϑ on a pseudo-random Cayley graph."
It has a door (the triple-level SDP) and a known price, and it is not a SAT problem.

## 3. The surprises, verified, each with its address

### 3.1 The extremal sets change kind between 23 and 83 — the anomaly with an address

Write 1_S = (|S|/n)·1 + f. For an *independent* S the identity f ᵀAf = −d|S|²/n forces the mass-weighted mean eigenvalue
of f to be −(d s/n)/(1 − s/n), a function of size alone (my script reproduces it to three decimals on all three sets, a
self-check of the instrument). What is *not* forced is where the mass sits. Measured on the primary records:

| set | size | s/ϑ | mass on the λ_min class | on the bottom four classes | mean eigenvalue |
|---|---|---|---|---|---|
| α(11) = 28 (`race23/ctrl-p11-28.json`) | 28 | 0.81 | **70%** | 90% | −3.61 |
| the 87-set at 23 (`alpha-p23-ge87.json`) | 87 | 0.66 | **51%** | 67% | −4.72 |
| the chain set at 83 (`wo18/p83-chain.json`) | 597 | 0.50 | **1.7%** | 2.4% | −7.97 |
| rot-6 (`p83-rot6`) / rot-42 (`p83-rot42`, exact) | 595 / 589 | | 1.7% / 0.3% | 2.2% / 21% | −7.94 / −7.85 |
| rot-3 / rot-4 / rot-2 / the plane 574 / the line 581 | 543 / 541 / 566 / 574 / 581 | | 30% / 19% / 16% / 16% / 10% | 49% / 30% / 30% / 31% / 26% | |
| **a 1,149-set, forced** | 1,149 | 0.958 | — | **≥ 76%** | −16.82 |

Uniform mass would be 1.2% per class at 83. So: at 11 and 23 the best sets are near-Hoffman objects — half or more of
their mass on the single bottom eigenspace — while at 83 every large set found is random-like, and the sets *with*
Hoffman-like concentration (rot-3 at 30%) are the *smaller* ones. A 1,149-set, if it exists, must have ≥ 76% of its mass
on the four bottom classes (eigenvalues −17.71, −16.70, −16.26, −14.23; a 336-dimensional space of plane waves whose
wavevectors lie on four circles), a regime no search has visited. Two readings, both registered below with falsifiers:
either the search finds random-like sets because that is all there is (the truth is ≈ 600–750 and P1 is high), or the
extremal sets at 83 are Hoffman-like and the local search never enters that basin. The cheap dial that separates them
is **spectral seeding** (§Q3).

### 3.2 The solver's reach is a residual-density threshold, not a cube count

`tools/fs50_race.py`'s cube c pins the origin and one point of class c and excludes classes 1..c−1. The residual the
solver must fill is the plane minus the origin's unit circle, minus the pinned point's, minus the excluded circles; the
density it must certify impossible is (N − 2)/residual. Recomputed: at 19 (N = 77) cube 6 needs 0.341 (unknown at
840 s) and cube 8 needs 0.417 (28 s); at 23 (N = 106) cube 10 needs 0.394 (unknown), cube 11 needs 0.433 (132 s), cube 12
needs 0.481 (12 s); the monolith at N = 140 needs 0.276 (unknown). **One threshold, ≈ 0.41, at both primes.** At 83 the
whole plane needs 0.167, and the min-class tree reaches 0.41 only after ≈ 46 of the 81 classes are excluded — the 46
cubes below are each the monolith. This is why "the orbit split alone does not tame the low classes" and why no deeper
split of the same kind will: a cube is a partial assignment, and to lift the residual density from 0.167 to 0.41 with
"in" decisions (each removes ≤ 85 vertices) needs ≈ 46 of them per cube, whose "out" siblings remove one vertex each —
the tree does not close. Registered as a hunch with its falsifier (a monolith refutation at needed density < 0.3 in under
an hour would kill it).

### 3.3 Why the local LP fades — a mechanism, with a falsifier

The LP's subgraph rows (`[KMOR2016]` Lemma 3.2(2)) are autocorrelation constraints at every translate; their averaged
form is the density bound δ ≤ α_V/|V|. The attribution table says a graph's rows bite only when α_V/|V| is within
≈ 0.06 of the plane's Hoffman ratio ϑ/n: the spindle (2/7 = 0.2857) bites 12% at 11, where ϑ/n = 0.2855, and not at 83,
where ϑ/n = 0.174; the triangle (1/3) bites 7.5% / 3.8% / 0.2% as ϑ/n falls 0.2855 / 0.249 / 0.174; the rhombus,
wheel and circle (ratios ≥ 0.43) never. Now ϑ/n ≈ 2/√p falls with p, while every finite unit-distance graph *of the real
plane* has α_V/|V| ≥ 0.2293 (Croft's 1-avoiding set has that density and a random placement of it over V is an
independent set of expected size 0.2293|V| — *recalled, not read:* Croft 1967, Hochberg–O'Donnell). So **at 83 no
real-plane graph can be within 0.055 of the Hoffman ratio and none can bite**; a row that bit would have to come from a
subgraph that is *not* a real unit-distance graph, i.e. one that sees the torus's wrap-around — a global object, which
is the whole problem again at a smaller size. The prior-art gate's "one untried lever" (the radius-2 ball, ≈ 3,500
points, α_V by SAT) is exactly that: an instance of the question at half size, in the same proof-system trap (§3.2).
Decline it in writing. *Falsifier for the mechanism:* a real-plane-embeddable subgraph whose rows move the bound at 83.

### 3.4 Smaller things, each settled

- **The colourer's classes at 97.9% of ϑ with 5 same-class neighbours per vertex** — not an anomaly: a random class of
  density 0.167 would have 14 same-class neighbours; the colourer halves that and then meets §3.1's wall. Expected.
- **Symmetric sets beat the free search at 83 and lose at 23** — the engineer's own reading is right: the widening
  per-thread spread (10 → 75 points over a run) says the free search at 83 has not converged; at 23 it has. A property of
  the search, not the object. It does mean the 0.50 rung of the ladder is a floor on the search's power, not on α.
- **6,889 = 6·1,148 + 1** — a coincidence I checked for meaning: a six-colouring whose classes are permuted cyclically by
  an order-6 rotation would have each class a transversal of the 1,148 orbits — but the rotation fixes the origin, whose
  class it cannot move, so no such colouring exists trivially. Those are the census's 22 "τ with no fixed colour" rows.
  Explained, nothing to chase.
- **MaxSAT's `cores_extracted 0`** — a bookkeeping miss, already noted in the record.

---

## Q1. The certificate's shape

**Recommendation.** Retire cube-and-conquer over cardinality CNF as the certificate route at both primes, and make the
certificate an **exact rational dual certificate of the triple-level semidefinite bound** — Schrijver's 2005 bound
(the matrices Y = (1/|S|)Σ_{z∈S} 1_{S−z}1_{S−z}ᵀ ⪰ 0 and M₁ − Y ⪰ 0, with M₁ the pair-autocorrelation matrix, plus the
S₃ identities among triple counts and the zeros on unit pairs), averaged over the automorphism group so that it lives in
the commutant of the point stabiliser O(2, p). Sizes, by Burnside on ordered pairs of points: **671 / 3,439 / 6,095 /
285,935** orbit variables at p = 11 / 19 / 23 / 83 before the S₃ identities (≈ 111 / 573 / 1,015 / 47,655 after), in blocks
of size p (once), (p−1)/2 (twice) and p − 1 ((p−1)/2 − 1 times) — at 83: one 83×83, two 41×41, forty-one 82×82, doubled for the
second matrix. At 11, 19 and 23 this is seconds with any SDP solver; at 83 it is ≈ 48k variables and 86 blocks ≤ 83 — a
first-order solver (SCS) in memory trivially, or an interior-point solver with an 18 GB dense Schur complement: hours on
the desktop, no server.

*Alternatives weighed.* (a) Cube-and-conquer with a deeper split (the stub's B–C): dead by §3.2 and the `nscale` datum —
no cube of any assignment-shaped tree reaches the solver's regime before it is the monolith. (b) Branch-and-bound with a
spectral bounding function: the root bound is 1,199; an "in" decision lowers it by ≈ 15, an "out" decision by ≈ 0.17, so
closing 51 points needs a chain of ≈ 300 "out" decisions whose residual graphs have lost the symmetry that makes any
spectral bound computable at 6,800 vertices; and branching on whole circles (which keeps O(2)) only reproduces the
min-class cubes with a ϑ bound that refutes cubes ≥ 5 and leaves cubes 1–4 as the monolith. (c) Pseudo-Boolean / cutting
planes (RoundingSat): not installed; the clique-cover cap n/ω = 2,296 says the LP world starts a factor two above
Hoffman, and CP lower bounds for clique on random graphs are known (recalled). A one-hour falsifier if the planner wants
it: RoundingSat on `race23/nscale`'s N = 140 instance — a refutation there would reopen (c). (d) The Delsarte LP with
integrality of the inner distribution (an 81-variable integer program): ten minutes as a control on "blind", expected to
move nothing.

*Why the SDP wins.* It is the only instrument whose bounding power comes from the same place the truth's distance from
1,149 does — the spectrum — and it is the one thing on the list with a *finite, priced* certificate: a list of rationals a
stranger checks by exact linear algebra.

*Confidence.* High that no resolution-based shape reaches (the datum plus §3.2). **Medium** that the triple level drops
below 1,149 at 83 — the Paley analogy says constant-factor gains at this level are normal, §3.1 says a 1,149-set is
forced into a Fourier-sparse regime where triple correlations are highly constrained, and neither is a derivation. The
one fact that would change it: the value at 11.

**Measure first, and the numbers that change the shape.** The triple-level bound at 11 (target: the exact α = 28; the
local LP's best 30.39; Hoffman 34.55):
- **< 29**: the SDP decides 11 exactly — go straight to 23 and 83, and write the exact-certificate phase into the plan.
- **29 to 30.39**: it beats the local LP — go to 23; read the fraction of the gap closed (next bullet) before 83.
- **≥ 30.39**: the triple level is no better than local rows at 11; the line is dead, and the honest sentence for the
  milestone is that the first digit at 83 is beyond every certificate instrument this project can name — record it and
  close, rather than spend a server-day returning "unknown".

Then at 23 (threshold 106, Hoffman 131.76, truth ≥ 87): read **the fraction of the Hoffman-to-truth gap closed**, not
the threshold. That is the like-for-like calibration, and it runs the other way from the stub's intuition: 11 needs 84%
of its gap closed to be decided (34.55 → < 29), 23 needs ≈ 67% (→ < 106), and **83 needs only ≈ 9–12%** (1,199 → 1,148
against a truth of ≈ 600–750), because at 83 the truth sits a factor two below Hoffman. A weak instrument at 11 can still
be decisive at 83; a bound at 23 of, say, 115 would not decide FS-17 but would predict 83 comfortably.

*Default if nothing is done:* phases B and C run as stubbed, return "unknown" at both primes, and the failure clause fires
after a server-day.

**Is the refutation beyond resolution altogether?** Measured: yes at 23 for every N tried down to sizes the spectral
argument refutes on paper. Theory (recalled): pigeonhole-shaped statements have exponential resolution proofs, and
k-clique on pseudo-random graphs has n^{Ω(k)} regular-resolution lower bounds; the natural proof of "α ≤ ϑ" is a
degree-2 sum of squares, which no resolution- or cutting-planes-based solver simulates. The proof system that carries it
is Positivstellensatz / SOS; its certificate is a PSD Gram matrix, and the practical proof checker is exact rational
linear algebra, not an LRAT replayer.

## Q2. Is the relaxation route closed?

**Not closed — one relaxation is untested, and it is the right one.** What is closed, with reasons: every relaxation over
the *pair* scheme (Schrijver 1979, measured: ϑ = ϑ′ = Hoffman); the local-subgraph LP at 83 (§3.3, a mechanism, not just
a measurement); the radius-2 ball as a subgraph (the same problem at half size, §3.3); the Delsarte ILP (a ten-minute
control, expected null). What is open: the triple-level bound of Q1, which is *global* (it constrains the bispectrum of
S, not any local patch), sits between ϑ′ and Lasserre level 2, and has never been computed for any finite plane. Its
real-plane analogue — Ambrus–Matolcsi's triple correlations — moved the density bound 0.2685 → 0.2544 (5%) on top of the
subgraph LP; the finite plane at 83 needs 4.2% below a bound the local rows cannot touch. Lasserre level 2 proper
(moment matrix on pairs) is n² ≈ 47 M rows and out of reach; the Schrijver level is the tractable one.

*Alternative weighed:* decline all relaxations in writing and go to search. *Why not:* the search has no certificate to
offer (Q1), and the SDP calibration at 11 costs an afternoon. *Confidence:* high that this is the right thing to price;
medium that it reaches. *Default:* if unpriced, the plan carries "every relaxation is blind" into the record as a
theorem, which it is not — it is a theorem about pair schemes and a measurement about local rows.

**Engineering notes for the planner** (so the price is honest): no SDP solver is installed (cvxpy, scs, cvxopt, mosek,
picos all absent; numpy/scipy/sympy/pysat present) — `pip install cvxpy` with SCS or Clarabel is minutes and suffices for
11/19/23; at 83 a first-order solve is fine for a float value and an interior-point solver (SDPA/CSDP via pip or conda,
dense Schur ≈ 18 GB) for a tight one. The exact certificate step (Peyrl–Parrilo rounding, then rational LDLᵀ of the
blocks) needs the blocks over ℚ(ζ₈₄)⁺ (degree 12) or, grouping Galois-conjugate irreps, over ℚ with blocks up to 82·12 =
984 — hours in pari/sympy, and it should run only once a float value clears 1,149 by a margin. Two controls are
load-bearing and must be built before any number is believed: (i) every verified set (28 at 11, 87 at 23, 597 at 83) is
*feasible* for the SDP — an invented or mis-signed constraint would lower the bound, which is the flattering direction
(G21); (ii) a planted α (a subgraph constraint with a wrong α_V) moves the bound, two-sided. A run at 83 exceeds fifteen
minutes and checkpoints under the house rule.

## Q3. The predictions

**P1 (α < 1,149): raise to high, and register a sharper prediction beside it.** The stub's basis — "19% loose at 11" — is
the weakest form of the evidence. The stronger form: (a) the ratio α/ϑ falls with d like ln d/√d (§2, item 1; predicted
0.48 at 83, measured ≥ 0.50); (b) the random-regular value is 533–727 and the found 597 sits inside it; (c) the greedy is
the random greedy to 1.4%; (d) λ_min is inside the Ramanujan bound. Registered below: **α(UD(𝔽₈₃, 2)) ≤ 750**, falsified
by a verified set of 751. That is a prediction the finding side can attack cheaply and the SDP can corroborate (a bound
near 1,100 would say nothing; the SDP is not expected to reach 750).

**The other side, argued honestly.** If a 1,149-set exists, §3.1 says what it looks like: ≥ 76% of its centred mass on
the 336-dimensional span of plane waves with wavevectors on the four bottom circles — a Fourier-sparse, "quasi-crystal"
object. The symmetric quotients are exactly the Fourier-sparse ansatz with a *symmetric* support (a rotation-invariant
set has its mass on rotation-orbits of characters): the line quotient is one wavevector, rot-84 the whole circle, rot-6 a
six-orbit — and every one of them caps at 505–595. A 1,149-set would be a generic, non-symmetric combination of the same
plane waves, which no instrument run so far can produce: the local search inserts and evicts vertices at random, and the
census enumerates symmetric supports. **The cheap test that finds or excludes it before any certificate: spectral
seeding** — take the 84 characters of the λ_min class (or the 336 of the bottom four), draw a random real combination,
threshold it at its top 1,149 (and at 700) values, count conflicts, and run the engineer's tabu from that seed against
random seeds, ten runs each; an hour of engineer time on the existing tool (`--start` takes a set). Both outcomes are
reachable and both move the plan: a plateau above ≈ 700 says the search was the bottleneck and the Cayley structure lifts
α well above random (P1 weakens, the SDP calibration is re-read against the new floor); a plateau at ≈ 600 says the
near-Hoffman basin is barren (P1 strengthens to very high). The exclusion side of the same structure is the SDP: the
triple constraints are strongest exactly on Fourier-concentrated sets.

**P2** met, both outcomes were reachable. **P3** (the 23 certificate by cube-and-conquer in a desktop-day): its
falsifying outcome has effectively arrived (§3.2 and the datum) — retire it with that reason. **P4** (83 needs the
server): both outcomes are unreachable for the instrument it names; retire it and replace with "the triple-level bound
at 83 is a desktop job (< 24 h, < 32 GB)", falsified by a run that needs more. **P5** (α(23) < 106): keep; the SDP at 23
may decide it, and it is FS-17's digit. **The stub's failure clause** should move *before* the server: the stop rule is
the number at 11, not a server-day of "unknown".

## Q4. The kernel form

**The LRAT route is closed by the datum, not by price.** There is no CDCL refutation to log at 23, let alone 83; and if
one existed its core would be the whole graph (the statement is global), so the K3 recipe — a 778-edge core in 5.9 s —
does not transfer: the H2 logs were 600k lines per cube for a 25k-vertex object and were never checked; row 40 declined
800k per cube. Do not promise `seven_le_chromaticNumber_finitePlane83` from LRAT.

**The SDP certificate's kernel form is real but two steps away, and neither step is this milestone's.** Step one is the
*level-one* certificate — an exact rational dual of Delsarte's LP, i.e. a radial function φ on 𝔽₈₃² with φ(0) = 1, φ ≤ 0
off the origin and the unit circle, and φ positive definite; then |S| ≤ 1/φ̂(0) for every independent S by one
double-counting. Positive-definiteness over ℚ is the obstacle: the characters live in ℚ(ζ₈₃), so the check is a PSD
condition on ℚ-blocks of size p − 1 grouped by Galois orbits — which is exactly FS-41's "Hoffman's equality case in
Fourier form", and it would put **χ(UD(𝔽₈₃, 2)) ≥ 6 in the kernel**, which is not there now (the floor 6 is float-derived,
row 53). Step two lifts the same machinery to the triple level (the dihedral block-diagonalisation over ℚ(ζ₈₄)⁺ and
86 rational LDLᵀ's ≤ 984×984) — a milestone of its own; one cheap trick worth a line in its stub: a Gram check Q = BᵀB
can be run as n² big-integer multiplications by Kronecker packing, which the kernel's GMP-backed `Nat` does in O(1)
reduction steps each.

**What a reviewer who trusts none of our Python must check, in the SDP shape:** (i) that a list of rationals — 86 block
matrices and ≈ 48k linear identities — satisfies the identities and that each block is PSD, by an independent
exact-arithmetic program of a few hundred lines (as `wo18-recheck.py` is for sets): no solver trusted, no float anywhere;
(ii) a one-page derivation that the identities and PSD-ness imply |S| ≤ N for every independent S (Schrijver 2005 §2
transplanted to a Cayley graph on 𝔽_p² with its point stabiliser) — hand-checkable; (iii) the kernel row 56
(`card_le_mul_of_colorable`) for the step from α to χ. That trust surface is smaller than any LRAT bundle this project has
produced and smaller than the H2 artifact by three orders of magnitude, which is the audience argument for the shape.

## Q5. Anomalies and reframings

**Anomalies:** §3.1 (the kind of extremal set flips between 23 and 83 — the one with an address and a dial), §3.2 (the
cliff is a residual-density threshold ≈ 0.41), §3.3 (the LP bite is ratio proximity, and real-plane graphs cannot bite at
83), §3.4 (the rest, explained).

**Reframing 1 — the product (Kooshi's call, card below).** The stub's product is one bit at 83. The prior-art gate's own
finding is that *no upper bound on α of any finite Euclidean plane other than the ratio bound exists in the literature, at
any p*. A computed triple-level bound at 11 (against the exact 28), 19, 23 and 83, with exact rational certificates at
the small primes, is a table nobody has — and it is a by-product of the calibration the certificate route needs anyway.
If 83 does not reach 1,148, the milestone still lands that; if it does, the digit is its headline row. Stated as the
product, the same work cannot fail to produce a result, which is the shape the ledger prefers.

**Reframing 2 — the fractional frame.** α ≥ 1,149 ⟺ χ_f(UD(𝔽₈₃, 2)) ≤ 6889/1149 = 5.996. The milestone asks whether the
finite plane at 83 is *fractionally* below six. That is the frame in which ϑ-type bounds are the native instrument, and
it connects the finite plane to the real-plane numbers the bibliography already holds: χ_f(ℝ²) ∈ [4.0486, 4.36]
(`[AmbrusEtAl2023]`; Croft / Hochberg–O'Donnell, recalled). It also explains §3.3 in one sentence: the finite plane at 83
is forced by its spectrum to have χ_f ≥ 5.74 > 4.36, so it contains subgraphs no real unit-distance graph can be, and only
those can certify anything.

**Reframing 3 — the digit is not "6 or 7".** If α(83) ≈ 600–750 (the registered hunch), then χ(UD(𝔽₈₃, 2)) ≥ ⌈6889/750⌉ =
10, and the "floor 6" is a Hoffman artefact that undercounts large planes by a factor ≈ √d / ln d. For the conjecture this
changes nothing — G48 only asks "≤ 6 or not", and 7 is the cap — but it changes how the record should speak: "the plane at
83 has floor 6" reads as "≈ 6" and is probably off by four; and G44's "small planes are SAT questions, large ones theorems"
has a middle the ladder now measures (11: exact; 19, 23: open at the five-colour threshold; 83: probably far above every
threshold). A sharper hypothesis for the record, with a falsifier: **for p ≡ 3 (mod 4), α(UD(𝔽_p,2))/ϑ ≈ ln(p+1)/√(p+1)
within a factor 1.3** — falsified by any certified α or verified set outside that band (at 83: outside 460–830).

---

## Cards, ranked

question: does-the-triple-level-bound-bite-at-11
  evidence: `data/fs50/lp-attribution.json` — Delsarte 34.55, the best local LP 30.39, exact α = 28 (`alpha-p11.json`); `race23/nscale` — CDCL undecided at 23 at every N down to 110; no record anywhere of the Schrijver-2005 / Terwilliger bound at any p
  expected: the triple level improves on the pair level by a constant factor on pseudo-random Cayley graphs (the Paley cousin, recalled), so at 11 it should land between 28 and 30.39
  ask: what is the Schrijver triple-level SDP bound on UD(𝔽₁₁, 2), with the verified 28-set feasible and a planted α moving it two-sided?
  if below 29: the instrument decides 11 exactly; run 23 and 83 next, and write the exact-certificate phase and the kernel stub (Q4) into the plan
  if between 29 and 30.39: it beats every local row; run 23, read the fraction of the gap closed, then 83
  if at or above 30.39: the triple level is no lever; close the certificate side honestly ("beyond every instrument this project can name") and spend nothing on the server
  answered by: run — an afternoon of Python (cvxpy + SCS, to be installed), 671 orbit variables, blocks of size ≤ 11, seconds of solve
  cost: an afternoon, plus the two controls
  hunch: between 28.5 and 30 — the exact set at 11 is Hoffman-like (70% of its mass on λ_min), the regime where triple constraints are strongest
  falsifier: a value ≥ 30.39 with both controls green
  rank: 1

question: is-the-near-hoffman-basin-empty-at-83
  evidence: `data/fs50/wo18/p83-chain.json` (597 points: 1.7% of Fourier mass on the λ_min class, uniform would be 1.2%), `data/fs50/alpha-p23-ge87.json` (87 points: 51%), `data/fs50/race23/ctrl-p11-28.json` (28 points: 70%), §3.1's table over the 15 `wo18/p83-*.json` records; a 1,149-set is forced to ≥ 76% on the bottom four classes
  expected: if the truth at 83 is random-like (≈ 600–750), seeds drawn from the bottom eigenspace plateau no higher than random seeds; if Hoffman-like extremal sets exist, they plateau markedly higher
  ask: does the engineer's tabu search, seeded from thresholded random elements of the λ_min eigenspace (and of the bottom four classes), plateau above the 597 that random seeds reach?
  if it plateaus at about 600: the basin is barren; P1 goes to very high and the hunch "α ≤ 750" stands; the SDP is read against a truth of ≈ 600
  if it plateaus well above 700: the search was the bottleneck; the Cayley structure lifts α above random; re-read the ladder's ratios and the SDP calibration against the new floor, and the finding side gets a real instrument
  answered by: run — the Rust engineer, `plane-independent --start` with generated seeds, ten runs per seed family, two hours
  cost: an hour of engineering, two hours of desktop time
  hunch: about 600 — every large set found at 83 is random-like, and the Hoffman-like ones found are the small ones
  falsifier: a verified set above 700 from a spectral seed
  rank: 2

question: is-the-bit-the-product
  evidence: the stub's §7 "none directly; medium-high on the conjecture"; `plans/FS50-prior-art.md` §2 "not found under any name: any upper bound other than the ratio bound, at any q"; the same computation that certifies 83 produces bounds at 11, 19, 23 for free
  expected: the milestone is written so that only the 83 bit counts and a miss is a failure clause
  ask: is the product the one bit at 83, or the first table of certified bounds on α below the ratio bound for finite Euclidean planes, with the 83 digit as its application?
  if the table: the plan's acceptance is the bound at each prime with an exact certificate at the small ones; 83 is the headline if it lands and a row if it does not; the failure clause is rewritten
  if the bit: the plan stays aimed at 83 and the table is a by-product recorded in the ledger row
  answered by: Kooshi
  cost: one decision
  rank: 3

## Hunch ledger

hunch: alpha-83-is-random-like
  claim: α(UD(𝔽₈₃, 2)) ≤ 750 — the truth sits at 0.5–0.63 of the ratio bound, as a random 84-regular graph's would (Frieze–Łuczak 533, first-moment 727, both recalled), lifted a little by the Cayley structure; the measured support is the greedy 358 against the random greedy 363, the ladder's ratios 0.81/0.76/0.66/0.50 against ln d/√d = 0.72/0.67/0.62/0.48, and λ_min inside the Ramanujan bound
  basis: measured
  falsifier: a verified independent set of 751 or more
  registered: 2026-09-14
  status: open

hunch: the-triple-level-bound-drops-below-1149-at-83
  claim: the Schrijver-2005 SDP bound in the Terwilliger algebra of O(2, 83) is below 1,149 — by analogy with the constant-factor gains of degree-4 SOS over ϑ on Paley graphs (recalled), and because a pseudo-set of size ≥ 1,149 must be Fourier-concentrated, where triple constraints are strongest (derived)
  basis: analogy
  falsifier: the computed value at 83 ≥ 1,149 with the feasibility and planted-α controls green
  registered: 2026-09-14
  status: open

hunch: cdcl-needs-residual-density-above-0.4
  claim: cadical on the cardinality CNF refutes "α ≥ N" only when (N − pins)/|residual| ≥ ≈ 0.41, at 19 and 23 alike, so no assignment-shaped cube tree reaches at 83 (needed 0.167)
  basis: measured
  falsifier: a monolith or cube refutation in under an hour at a needed residual density below 0.30
  registered: 2026-09-14
  status: open

hunch: local-rows-bite-only-by-ratio-proximity
  claim: a subgraph's LP rows move the bound only when α_V/|V| is within ≈ 0.06 of the plane's Hoffman ratio; since real unit-distance graphs have α_V/|V| ≥ 0.2293 (Croft, recalled) and the ratio at 83 is 0.174, no real-plane graph bites at 83 and the local LP route is closed by mechanism
  basis: measured
  falsifier: a real-plane-embeddable subgraph whose rows move the bound at 83 by more than the triangle's 0.2%
  registered: 2026-09-14
  status: open

hunch: extremal-sets-are-hoffman-like-only-at-small-p
  claim: at 11 and 23 the largest independent sets carry ≥ 50% of their Fourier mass on the λ_min eigenspace; at 83 the largest do not, and the Hoffman-like ones are smaller
  basis: measured
  falsifier: a set at 83 larger than 597 with ≥ 30% of its mass on the λ_min class
  registered: 2026-09-14
  status: open

## Traps I see for the planner

1. **A flattering SDP.** In a relaxation a *missing* constraint raises the bound (safe) and an *invented* or mis-signed
   one lowers it (the direction that pleases). The verified-set feasibility control is therefore the load-bearing one,
   and it must be seen to fail (plant a wrong sign). Do not read a float value that clears 1,149 by less than the
   solver's tolerance as anything; the exact rational certificate is the verdict.
2. **The calibration inversion.** Deciding 11 needs 84% of its gap closed; 83 needs ≈ 10%. A modest number at 11 is not a
   reason to stop, and a decisive one at 11 is not a guarantee; the fraction of the gap is the reading, and the gap at
   83 is estimated from a hunch, so carry that dependence in the plan's sentence.
3. **The server reflex.** P4 was written for the wrong instrument. No SAT run at 83 before the SDP number at 11 exists; a
   server-day of "unknown" is the failure clause arriving at full price.
4. **The S₃ identities and the stabiliser.** The triple orbits identify under permuting the three points of a triple as
   well as under O(2); getting the identifications wrong is invisible in a float value. The p = 11 exact α is the
   control that catches it (the bound must be ≥ 28 and the 28-set feasible).
5. **Checkpointing an SDP.** A solve at 83 exceeds fifteen minutes; interior-point solvers do not resume. Write the
   iterate to disk or accept the redo, and say which in the subplan.
6. **Reading a symmetric optimum as an object property.** 505 / 589 / 533 are exact *within their classes*; they say
   nothing about sets with less symmetry, and §3.1 says the large sets at 83 are the unsymmetric, random-like ones.
7. **The language of "floor 6".** Reframing 3: the record's floor is a Hoffman artefact; if the plan cites it as the
   plane's approximate value, a reader will take α ≈ 1,149 as plausible when everything measured says half that.
8. **"Every relaxation is blind" written as a theorem.** It is Schrijver's theorem for pair schemes and a measurement for
   local rows; the triple level is neither, and the sentence should be narrowed in the stub whatever the SDP says.

## What I did not do, and why

- No SDP was solved: no solver is installed and the box stays quiet; the sizes above are Burnside counts and the block
  structure is the dihedral representation theory, both checked by hand and by the orbit count (285,935 = Σ multiplicity²).
- Citations marked *recalled, not read* (Frieze–Łuczak; Atserias et al.; Gvozdenović–Laurent; Kunisky–Yu; Barak et al.;
  Croft; Schrijver 2005; Pudlák) are held claims about what those papers contain; the prior-art step of the subplan
  should open Schrijver 2005 and Gvozdenović–Laurent 2008 before the SDP is written — they contain the block
  diagonalisation the implementation needs, and the second may contain a Paley table that calibrates the hunch.
- The Delsarte ILP and the RoundingSat falsifier are ten-minute and one-hour items I priced and did not run.

*Scratch: `~/.claude/jobs/b1507518/tmp/poros-fs50/` (the pre-reading expectations and the numpy scripts' outputs).*
