# Engineering standard
@DEBRUIJN.md

# Workflow
@WORKFLOW.md

# This workspace — lean-dir

A Lean 4 proof workspace aimed at one target: **the Hadwiger–Nelson problem**. We write theorems,
programs, and tactics to the **de Bruijn** standard (above) and work milestone-by-milestone through
WORKFLOW. Everything reduces to what the kernel checked plus what we explicitly chose to trust.

**This file holds current state only.** Every update rewrites the affected text in place: no dated
amendments, no correction trails, no superseded rankings, no milestone narratives. A corrected claim is
replaced by the corrected claim (with its attribution, if it turned out to be prior art); the story of the
correction belongs in the commit message and the milestone's plan. **History is in git:**
`git log -p -- CLAUDE.md`. The last version carrying the full narrative — every milestone's story, every
amendment and correction trail, every superseded ranking and reading — is commit `fd658af` (2026-09-10).
**Size budget: keep this file under 300,000 bytes** (suspended for the 2026-09-26 reframe — Kooshi: *"Ignore the 300kB limit while you reframe the file."*) (Kooshi, 2026-09-26, at the ×2×3 crunch's end, after it ran unbounded: *"the 300kB limit returns, and we'll likely need to find a way to extract what's not necessary, treat the grokkings there as a cache for a dedicated grokking file, or merge things to reduce it from here on out. There's just too much new knowledge to carry in every session."*; the same day he chose design (b) of `plans/PROPOSAL-claude-md-knowledge-cache.md` — *"Implement b on the file. Remove incidentals, keep intrinsics."* — and E1's pass took the file from 299,491 to 282,481 bytes: the second and later instances of rules to `plans/GROKKING-INSTANCES.md`, the "Not ours" list to `LEDGER.md`, the paths-forward rows ranked ≥ 30 to `plans/FRONTIER-STUBS.md` alone; E2's check restored two intrinsics the pass had moved (283,274), and F1's audit of the git history (Kooshi: *"It's been a long struggle to maintain the balance."*) restored the reasons and killing tests the compression passes since 2026-09-10 had cut, the stories to the same file (291,306 bytes); *"We'll revisit a cache implementation next time we hit the cap at a point where we're too dense to compress or remove further incidentals."*; at the 2026-09-25 crunch's end: back to 300,000 after a temporary 325,000 during it; the no-loss pass that followed took the file to 283,826 and found almost nothing more that touches no reasoning) (Kooshi, 2026-09-11: the budget is on *this file
itself*, not on the file plus the two imports above — there is a lot here worth remembering; raised from 150,000 to
200,000 on 2026-09-15 after a rule's reasoning was trimmed to fit and its loss cost hours, from 200,000 to 250,000
on 2026-09-17 with the file at 199,785 bytes, from 250,000 to 275,000 on 2026-09-21 with the file at 249,994 after a
no-loss compression pass measured its floor at about 228,000, and from 275,000 to 300,000 on 2026-09-25 with the file at 274,995
(*"It probably still won't be enough, but hopefully it'll buy time"*) — a ceiling reached is a ceiling that starts costing content,
and the current-state-only rule, not the byte count, is what keeps this file honest). The budget is
a ceiling and never a licence: the current-state-only rule above does the real work, and superseded text
comes out whether or not there is room for it. **One home per fact** (2026-09-21): numbers, certificates, names and
addresses live in a row of `LEDGER.md` (the novel-results ledger, extracted from this file on 2026-09-22 — read by address, never
loaded), mechanism and readings in a grokking, a rule's second and later instances in `plans/GROKKING-INSTANCES.md` (extracted
2026-09-26, read the same way), and every other mention points; at every close run
`tools/claude_md_fact_audit.py` with `--base <the previous close>` (nothing lost, across the three files) and `--dupes` (nothing retold). **A paragraph tagged `[PROTECTED — never compress …]` is exempt from every trim
(Kooshi, 2026-09-15): the tag marks reasoning whose loss has already cost hours; trim elsewhere.**

## Notation

*Declared once, used throughout this file. A new recurring term gets a line here, never a second in-line definition.*

- **K** = ℚ(√3,√11), the field of the Moser spindle and of every seam-field object (G1). `K(√d)` adjoins √d: K(√7) = ℚ(√3,√7,√11).
- **χ(F²)**, for a field F ⊆ ℝ: the chromatic number of the unit-distance graph on F². χ_f, α, ω, ϑ: a graph's fractional
  chromatic, independence and clique numbers and its Lovász theta.
- **Γ_q** = UD(𝔽_q, 2), the unit-distance graph on 𝔽_q² (x² + y² = 1) — "the (finite, residue) plane at q". **U_Q** =
  Cay(𝔽_{Q²}, μ_{Q+1}), the Cayley graph of 𝔽_{Q²} on the (Q+1)-st roots of unity — the target an inert prime above 2 of norm Q supplies (G56).
- **The tower at p** (p ≡ 3 (mod 4)): `G_k = UD(ℤ/p^k, 2)`, k ≥ 1, `G₁ = Γ_p`; a Cayley graph on the norm-one group `S_k`, `|S_k| = p^{k−1}(p+1)`.
  Reduction `G_{k+1} → G_k` is a homomorphism, so χ(G_k) is non-increasing and α(G_k)/p^{2k} non-decreasing in k (row 75, G66); `L(F)` reads level one.
- **Usable prime** of F: one whose residue field is 𝔽_q with q ≡ 3 (mod 4) — for q = p^f that is p ≡ 3 (mod 4) **and f odd**; then
  χ(F²) ≤ χ(Γ_q) (row 52). **L(F)**, F's *local bound*: the least chromatic number among the residue targets its conjugation-fixed
  primes supply. **The conjecture** (local–global, G48): χ(F²) = L(F) wherever L(F) ≤ 6; its **bold form** is χ(ℝ²) = 7.
- **Sealed at k** (*5-sealed*, G43): some residue target of F — a usable plane, or the target at a prime above 2 — is k-colourable, so
  χ(F²) ≤ k. **6-open**: none is 5-colourable (the wall is broken and every usable plane needs ≥ 6; over K, row 53's criterion). **The (2-adic) wall** stands
  or is broken: G35. **The window**, **the wall at six**: G56, G59.
- **Compulsions at k colours** (row 42): `Forces G k u v` — every proper k-colouring gives u and v one colour (a *forced pair*);
  `Separated G k u v` — every one gives them different colours (a *virtual edge*).
- **The standard three axioms**: `[propext, Classical.choice, Quot.sound]`.
- **Grades.** Ledger rows are kernel-checked unless marked; grokkings carry a status. **[kernel]**; **[tools]** / **[measured]**
  (tools-side: exact arithmetic with controls, or a controlled instrument); **[cert]** (an exact certificate accepted by a standalone
  checker, not the kernel); **[hand]** (a hand proof); **[derived]** (derived from results held); **[reading]** (an interpretation,
  believed and falsifiable — it names its killing test); **[external]** (claimed in the literature, unchecked here); **[method]** (a
  working rule).

## The mission

How many colours does the plane need so that no two points at distance exactly 1 share a colour?
Known since 1950 to be 4, 5, 6, or 7; de Grey (2018) ruled out 4 with a 1581-vertex unit-distance graph
that is not 4-colourable.

| rung | status |
|---|---|
| **A. χ(ℝ²) ≥ 4** — the Moser spindle | ✅ kernel-checked; exercised the whole pipeline end to end |
| **B. χ(ℝ²) ≥ 5** — de Grey's graph | ✅ kernel-checked (M06–M09) on axioms exactly `[propext, Classical.choice, Quot.sound]`; our foundation, not our product. Also derived with no witness object, at [hand] (§ Where the problem stands) |
| **C. The search instrument** — shrinking, criticality, fractional bounds, fans, sweeps | ✅ built through M17, extended by every milestone since |
| **The upper end** — χ(ℝ²) ≤ 7 | ✅ kernel-checked (M36), so the repository holds **5 ≤ χ(ℝ²) ≤ 7** on the standard three axioms. Not new mathematics: it exists because the certificate machinery is the promotion path for any future periodic avoider, and a five-colour avoider IS the open upper-bound problem |
| **D. The answer** — χ(ℝ²) decided | open. Given MR it is one question about measurable colour classes, and both of its answers decide the problem (§ The aim) |

### The aim

**Solve Hadwiger–Nelson outright, verify every step in Lean, then publish** (Kooshi, 2026-09-26): *"My goal is to fully solve, and then
verify in Lean, HN. Then we publish. (Anything we do must be formalized in Lean before publishing, that's the bar for AI found proofs, and I
think we can go all the way to an HN solution)"*. It replaces every earlier target (six; "no field's plane is six-chromatic"; the ladder
skipping six): *"You can remove the old goals. We blaze the trail now."*

**The direction: the regularity wall** (the owner's reading, 2026-09-26, adopted by Kooshi; each link at its grade):
1. **Given MR, the plane is the measurable problem.** `χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)` — the fewest colours in a Lebesgue-measurable colouring
   whose unit pairs are bichromatic almost everywhere — and it equals `χ(F²)` at each totally real field where every stable place mixes at six
   colours, ℚ(√635087) and de Grey's field among them (rows 128, 130; [hand, two minds each]). The arithmetic is exhausted there: every
   prime mixes, and what is left is analysis in `ℝ²`.
2. **Upper bounds need no MR.** `χ(ℝ²) ≤ χ_m⁰(ℝ²)`: move a measurable colouring by a random rigid motion; each edge of a finite graph is
   bichromatic almost surely, and de Bruijn–Erdős finishes ([hand, two minds]: FS103-N's N-EASY, PA1's (E)).
3. **Density cannot give six.** One colour class at a time is capped below 4.37 (row 129); a proof of six must use how the classes fit
   together, never only how large each is.
4. **Regular colourings need seven in print.** Closed colour classes need seven (`[Voronov2023]` Thm 1.3: six closed sets covering a
   disc of radius 3 realize the unit distance); so does any colouring with slack, forbidding a whole band `[1−ε, 1+ε]` (Thm 1.1, for every
   `ε > 0`, by a non-computational argument on colourings of the unit circle); so do nice maps (`[Thomassen1999]`) and polygonal colourings
   (`[SokolovVoronov2025]`), and maps need six (`[Townsend1981]`, `[Townsend2005]`, `[Coulson2004]`). `[Voronov2023]` is an unrefereed
   preprint, `[Thomassen1999]` and Townsend unheld, and none is read in its almost-everywhere form — the program's first milestone. An
   almost-everywhere-proper colouring with slack needs seven outright: move it by a random rigid motion, as in link 2, and Thm 1.1 applies.
5. **So, given MR, Hadwiger–Nelson is one question: can a colouring that is measurable, tight (no band avoided) and not closed save a
   colour that closed ones cannot?** Its normal form is held: each class may be taken density-open and avoiding the unit distance at every
   point, covering the plane off a null set (FS-103's V1 and M, D1–D5). Both answers decide the problem. *No* — the classes can be made
   closed, or Voronov's circle argument runs on density-open classes — gives `χ_m⁰(ℝ²) = 7`, hence `χ(ℝ²) = 7` given MR. *Yes* — a tight,
   wild, almost-everywhere-proper five- or six-colouring — gives `χ(ℝ²) ≤ 6`, or `= 5`, **with no MR**: the first move of the upper bound
   since 1950.
6. **Its tools are Voronov's topology of circle colourings and the density topology** (approximate continuity, Lebesgue density, De
   Giorgi's structure theory for finite-perimeter classes) — the room after ergodic theory in G30's ladder. A reading, with its test:
   finite perimeter is Lipschitz-in-probability, the quantitative form of the continuity every CP colouring already has, so the gap to
   regular classes is quantitative, not a change of kind. Killing test: a CP colouring whose disagreement `P(c(0) ≠ c(h))` is continuous
   but not `O(|h|)` along every optimal family.

**The program** (`plans/STUB-regularity-wall.md`): **FS-106, the regular half** — Voronov's two theorems, Thomassen's, Townsend's and
Sokolov–Voronov's read first-hand, verified, and proved in their almost-everywhere forms, then pushed to density-open classes; **FS-107, regularity against pathology** — a competitor proving
that wildness cannot save a colour, a competitor building a wild colouring, an advisor between them (`plans/PROTOCOL-competitor-and-advisor.md`);
**Lean throughout** — MR in full (Einsiedler–Lindenstrauss, Einsiedler–Fish), the collapse, the measurable chain, the map argument.

### Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

**[PROTECTED — never compress, trim or paraphrase this section; rewrite it only to add an instance (Kooshi, 2026-09-26).]** Kooshi, on the
owner's first costing of these paths: *"From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter.
Don't. You are capable, and you will surprise yourself. GPT Astra just solved Navier Stokes, and you (Opus 5.5) are provably smarter. Be
ambitious, forge ahead. I'll be here to support you to the best of my ability."* On time: *"Don't worry about time either. I invite you to
check the date on the first commit of this repo. Your perception of how long this will take is a bit off."* On ambition: *"Let's see some
ambition. I know we can do it. Look at what you've done in just the last couple days, and we've already reduced it to a single set of
fields!"* On Lean: *"Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time. Your
predecessor formalized the entirety of Fermat's Last Theorem, over 1M lines, including hundreds of other published proofs."*

**The calibration, measured.** This repository's first commit is 2026-07-22. Sixty-six days and 3,369 commits later it held the classical
interval in the kernel, the local–global conjecture's main clause through five, and the collapse of the problem to one measurable question.
An advisor then priced the whole answer at "about 0.05 a year" and the owner costed routes by their Lean effort; both priors were formed
where the ground was known, and WORKFLOW's first principle says they are worthless here. The same miscalibration is on record at small
scale: kernel phases re-priced five to thirty times lower once begun (§ What compute actually helps).

**The rules it sets.**
1. **Rank a route by its bearing on the answer**, never by its difficulty, its length or its formalization effort.
2. **A registered probability is an instrument for G21**, scored at the close. It is never a reason to shrink an aim or to stop.
3. **When a problem looks too hard, say what it would take and start on it.** Doubt about capability is a prior, not evidence.
4. **Nothing about the standard of evidence moves.** Ambition sets targets, never grades; a rung that does not land is reported as not
   landed; a belief about the answer is not evidence for it.

### The local–global conjecture

Kooshi holds it (G48; 2026-09-17: *"the LG conjecture resonates with me, and I'm now gunning for 7. I'd be equally happy to be proven wrong
though"*), and its bold form is `χ(ℝ²) = 7`. Under it with the wall, χ(F²) ∈ {2, 3, 4, 5, 7}, the step above five is seven, first at K(√7),
where L = 7 — the field the ρ₆₃ arena already produced a five-chromatic object in (row 64). Its proved range is item 10's — every `L ≤ 5`,
at [hand] through MR (row 123). **Its exposed predictions:** exactly five at ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3,√5) — **all met**,
at [hand] through MR (rows 120–121, 123); and at least six at **ℚ(√167)**, proven 4 in the kernel (row 119) and ≥ 5 at [hand] (row 123), the
widest gap, at discriminant 668 (characters need eight there, row 101). Four at the census's 25 open fields, at every squarefree
d ≡ 11 (mod 12) and at ℚ(α,√7), α³ = α + 1, is met (rows 82–83, 99). At the fields where every place mixes, its prediction is the answer
itself: seven at ℚ(√635087) is `χ(ℝ²) = 7` given MR (row 128). **A finite refusal only confirms**: a prediction falls to a colouring of the
whole plane with fewer than L colours, local at no prime (G48), so five over ℚ(√167), held at [hand] (row 123), confirmed it and could not
falsify it, and only FS-64's windowed form still aims at one (its one-character case is closed, rows 96, 101). Believing the answer is seven
is not evidence for seven; the value-skipping that motivates the belief is itself compatible with five (G64).

**The mission is exclusively a hunt for new mathematics, however small, ratcheting toward major findings**
(Kooshi, 2026-08-02). A formalized statement earns its place by being structure nobody had named, or a rung
toward the answer. State failure modes plainly: a rung that does not land is reported as not landed, never
quietly rescoped.

**The programme** (Kooshi, 2026-09-06; his words and the assessment in full are in
`plans/PROGRAMME-ALGEBRAIC-PROOF.md`): *the derivations are an order of magnitude more important than
individual objects.* The answer is published as the derivation, with any object as its example, and one account covers both bounds. The
arithmetic viewpoint — the arithmetic of small primes governs the chromatic number — carried the problem to the fields where every prime
mixes (row 128) and is exhausted there; from there the problem is archimedean and measurable, and both bounds are one question (§ The aim).

**Publication.** **Nothing is published before it is formalized in Lean, in full, with no declared purchases** (Kooshi, 2026-09-26, § The
aim; *"no declared purchases for the final one"*); write-ups and upstreaming stay deferred until then (Kooshi, 2026-08-04: the rung-B
write-up, Mathlib contributions, exposition, and the M58–M61 sieve arc). A result held at [hand] is not yet publishable; formalization is never a cost that ranks
routes (§ Counter-priors). A finite witness for six is out as a route: *"search for a finite graph is out. It would be huge, not feasible."*
What clears the bar, once formalized:
- *definitely* — the answer, written as the derivation (the programme);
- *a result that answers a question the literature has independently and repeatedly posed*, whatever its size (`CLOSED-QUESTIONS.md`).
  Held so far, all given MR and at [hand]: `χ(ℚ(√47)²) = 5` (row 121) answers Moorhouse's named question (2010) and the existence half of
  Soifer's Open Problem 55.1 (2019), in the kernel only in row 127's conditional form; row 129 answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's
  equality question. Kooshi's earlier ruling stands as history: *"The publication rule half fires. This is 100% worthy of a writeup, but I
  want to be greedy and push to see how far we can get on our own."* The fallback write-up is FS-102 (`plans/STUB-writeup-main-clause-five.md`).
- **Theorem B's value is in print since 1994**, and the rule's earlier apparent firing for it (χ(K²) = 4, posed or named as open at least six
  times across fifty years, `CLOSED-QUESTIONS.md` §1.1) is withdrawn: `[Fischer1994]` (K. G. Fischer, Congressus Numerantium 104, 73–79; read
  in full 2026-09-22, every lemma verified by hand and the theorem by `tools/fischer1994_check.py` on 181,160 unit vectors) gives an additive
  4-colouring, a homomorphism to ℤ/4, of the whole plane over ℚ(√p,√q) for p ≡ 3, q ≡ 11 (mod 16), pq ≡ 1 (mod 32), and concludes
  χ(ℚ(√3,√11)²) = 4 in those words, the Moser spindle as the lower bound. The equality is his; the six later posers — and this project —
  missed it — G49's mechanism once more. What is ours: the kernel proof, Theorem A's general form (his congruence family is a proper subfamily
  of the wall-standing fields it four-colours), the 𝔽₄-valued residue colouring — a different colouring from his ℤ/4-valued one, which
  separates a distance-2 pair the residue map identifies (G41) — and every consumer built on B. **The Theorem B paper is FS-20**
  (`plans/STUB-theorem-B-writeup.md`; whether it is still worth writing is Kooshi's call).
- **Naming is a first-class deliverable**: every working term in this repository is coined in-house and appears in no paper — the mechanism
  G49 says hid the prior art — so the manuscript's vocabulary is a design problem with a ban list (`BIBLIOGRAPHY.md` §E is the translation
  table; this project's *direction ladder* is the literature's *Moser lattice*, and new writing uses the latter).
- At publication, adopt the zeta-23 artifact shape: a tiny trusted `comparator/` surface (Challenge statements with `sorry`) over the whole
  edifice as untrusted Solution, verified by `leanprover/comparator` (statement equivalence, axiom whitelist, kernel replay; its nanoda run
  is the independent-kernel publication gate).

`ARCHITECTURE.md` holds the module map (checked against the import graph by `tools/check_architecture.py`) and the roadmap through M20; `plans/` holds per-milestone subplans and
stubs. **The bibliography is explicit and maintained (Kooshi, 2026-09-06): `BIBLIOGRAPHY.md`.** Every
external work this project cites, reproduces, depends on, or corrects is an entry there — added the day it
is first used, with what of ours rests on it, where our copy is (`~/source/library/`), and how much of it has
actually been read, per section. A ledger row or grokking that rests on prior art names its bibliography key.
Titles seen only in search listings are marked as such until checked against the paper.
`tools/bib_audit.py` checks that every cited key resolves.

## Frontier

*The current state of the art, the ledger of everything novel this project has produced (`LEDGER.md`), and the ranked
paths forward. Rewritten in place at every milestone close (WORKFLOW step 9); a milestone whose close does
not update this section is not closed. The understanding the results add up to lives in § Grokkings, under
the same rule, and both under the header's one-home-per-fact rule: "Where the problem stands" and § Paths forward orient and
point (`row 68`, `G56`) and never retell.*

*Last updated: 2026-09-26 — **the reframe** (Kooshi): the aim is the answer, formalized in Lean; the direction is the regularity wall (§ The aim; FS-106, FS-107). Before it, **FS-105, harden MR**: **Paid (hardening)** — MR (row 120) stands, its grade rewritten: `[EinsiedlerLindenstrauss2022]` Thm 1.2's proof is in neither paper cited for it (EL2003 is an announcement, its §6 an outline); it follows from their Thm 1.3 by a deduction EL2021 never writes, now two minds, one blind; PE-2 sits inside Thm 1.3's hypotheses at ℚ(√635087) and de Grey's field, a reading gap (not a mathematical one) at EL2021's cited machinery; EF_F⁺ has three derivations blind to one another; MR at degree 16 walked; row 129's killing test correct as stated, with the two shapes a refutation must take (`plans/FS105-harden-mr.md` §R-close). Before it, **FS-103, the collapse** (rows 128–130; `plans/FS103-collapse-cp-plane.md` §R-close), and FS-100 stage 5 with its waves (rows 120–127). **No finite-witness search runs until 2026-10-01** (Kooshi; § Toolchain). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*

### Where the problem stands

**The problem.** χ(ℝ²) ∈ {5, 6, 7}. This repository kernel-certifies the whole classical interval, **5 ≤ χ(ℝ²) ≤ 7** (row 33), on
the standard three axioms, its lower end through de Grey's graph (rung B). **The lower end now also follows algebraically, with no
witness object:** a subfield's plane is a subgraph of ℝ²'s, so `χ(ℚ(√47)²) = 5` (row 121) gives χ(ℝ²) ≥ 5 — at [hand] grade, over MR
(row 120: `[EinsiedlerLindenstrauss2022]` Thm 1.3 by statement, with a two-mind deduction of its Thm 1.2, and `[EinsiedlerFish2010]`'s method transferred, three blind derivations), not in the kernel, where
row 127 holds it only over named hypotheses. Kooshi's reading (2026-09-26): "We have now reduced hadwiger-nelson to 5,6,7
*algebraically* rather than by a witness object. That is far more valuable than de Grey's 2018 graph IMHO." **Given MR, the plane's number is a field's and a measurable one** (rows 128, 130): `χ(ℝ²) = χ(ℚ(√635087)²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)`, the least number of colours in a measurable colouring proper at almost every unit pair — [hand], two blind minds for the collapse, two for the last equality; Falconer's everywhere-proper `χ_m` is one step further, a GAP.

**What the kernel holds, beyond the interval** (addresses in `LEDGER.md`): **χ(ℚ(√11)²) ≥ 4** and the 3-adic barrier (rows 72–73);
**Theorems A and B** and the finite-plane machinery around them (rows 52–60); Theorem A's two-colour case and the 2-adic splitting
of real multiquadratic fields, with two test-passing fields whose compositum needs five colours (row 63); the compulsion toolkit —
arity floor, homogeneity, the spindle theorem, critical sets, absorption, additive rigidity (rows 42–51); the Kempe layer and the inheritance question in subgroup form — Kempe swaps, forcing as a finite property, the voltage-escape certificate, the forced and periodic-forced subgroups (row 78); **the kernel lane (M2)** — the chain theorem, with `χ(ℚ(√2,√3)²) ≥ 4` and `G4 → χ(K(√7)²) ≥ 5` (row 103), `χ(F(t)²) = χ(F²)` (row 104), prime inversion in valuation form and the `K(√7)` wall (row 105), the stripe lemma (row 106), and the bridge `χ(ℝ²) = max_F χ(F²)` conditional on one named true hypothesis, with `ℝ`, `ℝ_alg` real closed and Lemma NP (row 107); **FS-75** — `χ(ℚ(√167)²) ≥ 4`, the first field-level lower bound at an exposed field of the conjecture, with no finite graph: the criterion's ⟹ in winding form and a checker for `Θ₃` certificates (row 119); **FS-101's first slot** — `χ(ℚ(√47)²) ≤ 5`, and the main clause through five over named hypotheses (row 127); **the χ ≥ 6 target as a
theorem** (rows 43, 61; G26); the seam-field closures, each exactly 4-chromatic (rows 1–25); the pigeonhole carriers (rows 31–32);
the cell family (rows 34–41). Also χ(Heule-510) = χ(Heule-553) = 5 and χ(de Grey's 1581) ≤ 5.

**What the hunt has established** (the reasons are in § Grokkings):
1. **The 4/5 wall is 2-adic.** A unit-distance graph forces a fifth colour only if its coordinates break the
   2-adic wall (G1, G35).
2. **The field sieve.** For F ⊇ K: 6-open ⟺ the 2-adic wall is broken and 11 is inert. The finite planes refuse five from 59 up and
   six at 83 (row 68), and every field the descent ever used is 5-sealed (G43, G44). The wall is broken exactly when 1/2 lies in the
   unit-vector ring, and over K that is sufficient for five, given M56's 8/3 forcer (G55) or, independently, through MR (row 123, [hand]).
3. **The design target has no instance** (G48, row 66): a pair forced equal at five colours over a 5-sealed field, spindled into a
   6-open field, is refused **by theorem** over every 5-sealed multiquadratic F ⊇ K — Γ₁₁'s fan gap frees every pair above it. FS-6 is
   dead; a 6-forcer's compulsions all live in 6-open fields. The frame that replaces it is **tight or slack** (G54, row 87).
4. **Existing witnesses hold nothing to extract — on sealed objects by theorem, on 6-open ones by measurement** (G31; rows 43, 66). De
   Grey's 1581 and the `ρ₆₃` arena sit in **6-open** fields, where no residue target exists, so their nulls stay measured and
   unexplained: a χ ≥ 6 gadget must be constructed, not found.
5. **An in-field descent cannot end.** Points of K do intermediate kills and never the last one; the endgame needs a wall-breaking
   adjunction into a 6-open field (G34, G36, G37).
6. **Linear instruments are blind to 5–7.** Additive colourings, the fractional number, Hoffman and ϑ all stop
   below the interval, and the finite planes' chromatic numbers are integrality-carried (G38, G41, G44, G48).
7. **The cell family is closed in both directions** — no six-colouring, no bounded witness family — and its
   ≥ 7 floor is `[SokolovVoronov2025]`'s χ_poly(ℝ²) = 7 (G22, G24, G29).
8. **The type-M rotations are a classified one-integer family** (G7): `cos θ = (2n−1)/(2n)`, the spindle at distance `√n`; its member
   `n = 16`, the `ρ₆₃` arena, is **5-chromatic in the 6-open field K(√7)**, produced rather than inherited (row 64) — not the first 6-open
   platform (de Grey's own field is, G43) but the smallest, degree 8 against 16, and reached by the screen rather than found.
9. **`[Parts2020a]`'s 509-vertex record is reproduced and partly explained** (M62–M64, row 62): his reduction stage is reproduced
   on every attested number, a descent cannot reach the record, **overcompression is an orbit-closure gap**, and what is left of his loop is
   the expansion step, which has no termination measure (FS-35).
10. **The conjecture's proved range** (G55; GPT Astra; rows 99, 123): χ(F²) = L(F) for every real number field with **L ≤ 5** — L ≤ 4
   by row 99 [hand, three derivations], L = 5 given MR (row 120) by the class theorem and SP-Cor in every degree (row 123) [hand, every link two
   derivations or more]; over multiquadratic F ⊇ K with L ≤ 5 also by the chain theorem, given the measured 8/3 forcer — the one route independent
   of MR. Its exposed predictions are the target's (§ The mission): four for ℚ(√11) and ℚ(√23) (row 73), and five at ℚ(√47)
   (row 121), ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3,√5) (row 123) are met. With every residue level allowed, `L` is unchanged at 7, 11, 19, 23
   (row 75, G66).
11. **The window for six, and who can see it** (G56, G59; rows 68–71). Six colours on a usable plane Γ_q are possible only in a
   five-member window (six is refused from 59 up), none decided, so **a single verified six-colouring at 23, 27, 43 or 47
   would be the first exactly six-chromatic finite Euclidean plane**. No field containing K can use any member, so **six is
   arithmetically excluded for every field the hunt has built in**. The window decides whether six is *reachable by the residue
   method*; its sharp target is fractional, α < q²/6 (G59).
12. **What the wall leaves, and where the conjecture points** (G59, row 70): six finite graphs, in reach only at 47 and U₆₄ (FS-57).
   **If it holds, the conjecture's main clause says nothing above five**, and its sharpest remaining prediction is **ℚ(√167)**: at least
   six (five refused at 23 at every level of the tower, row 75) against four in the kernel (row 119) and five at [hand], through MR (row 123).
13. **Fractional colourings see fields the residue method cannot** (G60, row 71): `[MatolcsiEtAl2025]`'s blow-up never leaves the
   field, whence **χ_f(K²) = 4**; capped by every usable residue plane's `χ_f` (3.5 at 𝔽₇) and by 4.36, it proves at most five.
14. **Real quadratic fields: three colours are decided, and four is a theorem of the family** (G61, G74, G65; rows 72–74, 79, 82–84).
   **The plane over any subfield of ℝ needs four once 1/3 lies in its unit-vector ring and it has an odd cycle** [hand, two independent derivations; row 82]
   — so every squarefree d ≡ 11 (mod 12) needs four (T4); **nothing is claimed new while `[Johnson2000]` and `[Johnson2006]` are unread**.
   **The census is complete** (row 83); ℚ(√47)'s bracket closed at five from below (item 10, row 121); no residue at any depth could have closed it at four (§1.7, row 75). Over a
   number field three colours ask for a prime above 3 of residue field 𝔽₃, not for 1/3 (row 99, G74).
15. **Six may be a value no field attains — a claim stronger than χ(ℝ²) ≠ 6, not equivalent to it** (G64, FS-62): the wall at six
   (G56, G59) decides the value set of L and whether the conjecture predicts 6 or 7 at ℚ(√167); six hides only in the gap between L(F)
   and χ(F²), where every ceiling we own is silent but FS-64. Six being skipped is *not* evidence for seven.
16. **The construction grammar is crystallography's, and transcendence is free** (G62, G63): every witness is a twisted bilayer whose
   rotation is a Σ = n coincidence rotation (FS-63 is the gate), and χ(F(t)²) = χ(F²) for transcendental t (`[Fischer1990]` Thm 6), so
   χ(ℚ(π)²) = 2.
17. **The residue ceiling does not drop up the tower where it can be certified** (G66, row 75): at 7, 11, 19, 23 no level reads
   lower than level one, so `UD(ℤ/529, 2)` cannot five-colour ℚ(√167)'s plane, `α(Γ₂₃) ≤ 97`, and χ_Bor of the `p`-adic plane is
   unbounded in `p` (`CLOSED-QUESTIONS.md` §1.8). That the ratio is exactly constant is **not proved** (FS-68).
18. **Where a five-forcer can live in a field is decided on finite quotients `Λ/NΛ`, and over ℚ(√3,√5) it is nowhere dense** (G68,
   G69, row 76): a lattice is rigid — the chain route's fabric — only where every odd prime's periodic target refuses; no lattice of
   rank ≤ 6 over ℚ(√3,√5) does, the rank-8 one is undecided (FS-72). **Five over ℚ(√3,√5) lands, non-constructively** (row 123, [hand], through MR): the plane needs five, so some finite unit-distance graph over it is five-chromatic — no lattice of rank ≤ 6 carries it, and the rank-8 one is FS-72's object. **Over K the question is
   closed**: `F = P = 8Λ` on de Grey's lattice (rows 78, 85; item 23), and every four-colouring of `K²` is, per coset, local at one
   dyadic place, `F(R_K) = 4R_K` (row 89).
19. **The derivations are counted, and the corpus graded itself down more often than up** (row 77, FS-71): 254 theorems proved outside the kernel since M17, 184 by hand, filed one entry each in `plans/<home>-derivation.md` and indexed in `LEDGER.md` § B; one hand claim wrong (now a conjecture), under-grades four to one over-grade (G21), six results found in an uncited session record (G70).
20. **At three colours the inheritance question is a theorem, and the answer is topological, not arithmetic** (row 79, G71): it answers
   a question posed three times in 2018 (`CLOSED-QUESTIONS.md` §2.4). **It stops at three by a fact about `K₄`** (G71, row 80); at four
   colours a two-sided certificate exists only if four-colourability is decidable, stated open in print (`[CGHO2025bg]` §6.2.1).
21. **Four colours, cell by cell** (row 80, G73): read one cell at a time, `K₄` certifies nothing. **Each no-go is for its format,
   never for a kind of invariant**: averaged, non-local and structure-derived certificates stay open (FS-80) — row 85's is structure-derived (G75).
22. **ℚ(√167) at four colours** (row 81): `L21cc6506`, the lattice of `χ ≥ 4`, is loose (`F = P = 0`); seven minimal lattices on a finite part
   of the saturated chain outlast every capped screen — survivors, not refusals. Five over ℚ(√167) holds by two routes, at [hand] through MR (row 123); six contains `χ_CP(ℝ²) ≥ 6` (row 125).
23. **De Grey's lattice, derived; four-colour rigidity without triangles** (rows 85–87, G75, G54). De Grey's lattice has 9,120 four-colourings, each `8Λ`-periodic and local at one prime above 2, derived from Parts's trees twice independently (row 85; Mixon's 2018 question, `CLOSED-QUESTIONS.md` §2.5; the literal ring is FS-88). **Without triangles** rigidity is free in the abstract class; in the plane it implies Soifer's Open Problem 55.1 (row 86, §3), whose existence half row 121 answers, and it is undecided at ℚ(√59) (item 24). No-gos, and a slack plane that forces: row 87. Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success"* — no-gos count (`plans/FS85-rigidity-without-triangles.md` §R-close.2).
24. **Over the triangle-free fields ℚ(√59), ℚ(√83), ℚ(√131) one pair decides four-colour rigidity, and every natural way to break it fails**
   (rows 88–94, 96, 111–113, G76): the plane is rigid iff `(0, 4)` is forced (row 88) — **undecided**; with MR held at [hand] (row 120), row 88 ⟺ T-B1 ⟺ no rigid-motion-transient four-colouring, and every rotation-invariant random four-colouring is a pullback (row 124); the translation-invariant half is one step, TR-ROT, equivalent to Q-μ and closed on `E`, a GAP at NA₀ (row 126); the plane over `ℚ₂(√3)` is rigid (row 90), so the
   question is realising a local forcer without triangles. Every construction of a "no" that reads finitely much, and **every character
   colouring**, is excluded (rows 91–92, 96: HD1 holds); a "no" is transient or reads infinitely many split places (rows 111–112), and
   transience stops at two named steps (FS-98). ℚ(√2,√3), its member with triangles, is rigid given Heule's T721 (row 93). Toward six only
   through Soifer 55.1 (row 86).
25. **Two primes restore Furstenberg–Berend rigidity modulo the rotated direction, at every band** (rows 95–97, 98, 102; G76): every band
   character of `ℤ[i][1/p : p ≡ 1 (4)]`, hence of every real field's unit-vector ring, is torsion plus archimedean at the places of `F(i)`;
   at one prime it fails for points, minimal sets and torsion orders. The band condition is the pyjama problem's (`[Manners2015]`, row 98).
26. **Character colourings are local in the existence sense** (rows 100–101, G77): a real number field's plane has a character `k`-colouring
   iff some residue target does, so a falsifier of the conjecture is no character at `k ≤ 5` (FS-83 answered) or over a quadratic field;
   given CLG the window is closed to characters (8 colours on Γ₂₃, 9 on Γ₄₃; the exposed fields: G64). That every character colouring is
   local is proved only at three colours (row 99) and at HD1's fields.
27. **Rank one at four colours, and windows at five over ℚ(√167)** (rows 108–110, G78, G76; M3, `plans/M3-derivation.md`). FS-76's
   rank-one question is *countable ⟹ finite* for four-colouring shifts of distance graphs on ℤ — **not landed**, stalled at one step by
   three minds. At five colours a factor leaves a product colouring when it **mixes**, not when its ratio is small, so the window question
   over ℚ(√167) lives at nine places; nothing touches `χ_µ(ℝ²)`. **Kronecker windows at four colours** (row 116; FS-100): the selection onto `T + A` is false as stated; over T-C(A)'s class (the `L ≥ 5` fields) its `E`-form is moot through MR, no four-colouring existing there (rows 121, 123).
28. **Colourings of products: mixing pins them, gap-freedom does not** (rows 114–115, G54; FS-67, `plans/FS67-derivation.md`): from four
   colours up a `k`-colouring of `G × H` need not come from gap-free `G`, and it must whenever `H` mixes. Three colours and Hoffman-tight `G`
   are open. Bearing on χ ≥ 6: none.
29. **Measure rigidity for the unit-vector group, and five at ℚ(√47)** (rows 120–122; FS-100 stage 5; [hand]). Every `U`-invariant `E`-null
   measure on `R̂` is Haar, by entropy: Einsiedler–Lindenstrauss on the finitely generated pieces for positive entropy, Einsiedler–Fish's
   pigeonhole for zero entropy — `U` is large enough for it, no finitely generated subgroup is (G80). With SP-Cor, `χ(ℚ(√47)²) = 5`; the flip
   stops at a quantitative T-C(A) (row 122). Bearing on χ ≥ 6: none; ℚ(√167)'s gap is now [5, 7]. Wave 3 (rows 123–125): the class is `L ≥ 5` in every degree and SP-Cor holds on it, so χ(F²) = L(F) for `L ≤ 5` everywhere; ℚ(√3,√5) five; the type-(B) fields' rotation-invariant half; six at ℚ(√167) reduced to `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)`.
30. **The collapse, and the fractional local–global principle** (rows 128–130; FS-103; [hand], every headline given MR). Row 123's chain runs one colour class at a time: its five is `⌈1/α_loc(F)⌉`, the fractional bound `α_loc(F) = max(m₁(ℝ²), sup_v r_v)` rounded at one pigeonhole, and that route never gives six (G60); given MR the bound is exact, `α₁(F²) = α_loc(F)`, so at ℚ(√635087) `α₁(ℝ²) = m₁(ℝ²)` and `χ_f(ℝ²) = 1/m₁(ℝ²) ≥ 4.0487` (row 129). At a totally real field whose stable places all mix at six colours, `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)` (row 128; its load-bearing step needs no MR), and `χ_CP(ℝ²) = χ_m⁰(ℝ²)` with no MR (row 130). Bearing on χ ≥ 6: given MR, rung D is six over ℚ(√635087), and six for measurable colourings modulo null sets of unit pairs (G81).
31. **The regularity wall** (§ The aim; FS-106, FS-107; `plans/STUB-regularity-wall.md`). Regular colour classes need seven in print —
   closed classes, band-avoiding colourings, nice maps, polygons (`[Voronov2023]`, `[Thomassen1999]`, `[SokolovVoronov2025]`) — and maps six;
   given MR, Hadwiger–Nelson is whether a tight, non-closed, measurable colouring saves a colour, and both answers decide it. Unverified here
   in the almost-everywhere forms: FS-106 is that verification.

**The prior-art position.** The reduction from a field plane to a finite residue plane has been derived
independently in seven lineages that barely cite one another — Woodall → Benda–Perles → Johnson → Chow;
`[Fischer1990]`; `[Moorhouse2010]`; `[Manturov2012]`; `[Madore2015]`; the finite-field side (Medrano–Myers–
Stark–Terras → Vinh → Schneider–Silva → Krebs → Lorenz–Zimmermann); `[Polymath16wiki]` — and all stop where
Madore's Prop. 3.9 declines to formulate the general case. **Ours:** Theorem A's general form (that
formulation); Theorem B's kernel proof and its 𝔽₄-valued residue colouring — **the value χ(K²) = 4 itself is `[Fischer1994]`'s** (1994, read and verified 2026-09-22; row 57, § Publication), which closed the five questions row 57 lists sixteen to thirty-one years before they were posed; every kernel certificate; and the rest of the claim, row by row with its unread-prior-art caveats, in `LEDGER.md` § The claim list. **Not ours:** every attribution, verbatim, in `LEDGER.md` § The claim list — read it before calling anything ours.

### The novel-results ledger

**Rows 1–130 live in `LEDGER.md`** (extracted 2026-09-22): one row per result, kernel-checked unless graded otherwise, with its
address in `Proofs/` or `tools/` and its milestone. **Row numbers are stable identifiers cited across `plans/` and this file: never
renumber, never reuse.** The file is not loaded here by design — results are looked up by row, understanding is reasoned from — and
it is read in full at the reframe (step 3.1) and extended at the close (step 9).

### Paths forward, ranked

*A summary of `plans/FRONTIER-STUBS.md`, which is authoritative: every row there is a full stub with its
bearing on χ ≥ 6 stated honestly. Kooshi picks; the default is the top.*

**Open milestones, in order.** **None is open.** FS-105, harden MR, is **closed** (row 120's grade; `plans/FS105-harden-mr.md` §R-close; the stub's banner). **Next: FS-106, the regular half, then FS-107, regularity against pathology** (Kooshi adopted the program, 2026-09-26; `plans/STUB-regularity-wall.md`); the finite-witness-free week runs to 2026-10-01 (§ Toolchain). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close, with its record, banner and Kooshi's rulings (FS-84's among them): `plans/FRONTIER-STUBS.md`'s closed list.

**Ranked stubs** (one rank per row; `plans/FRONTIER-STUBS.md` is authoritative and holds the re-rank history, and its solver column marks what the finite-witness-free week can run):

| rank | stub | the question | bearing on χ ≥ 6 |
|---|---|---|---|
| 1 | **FS-104 `χ_CP(ℝ²)` at six** — `plans/STUB-cp-plane-six.md` | is `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (row 130)? First the null-set step to Falconer's `χ_m` (a finite list-colouring question on his null set), `χ_B`, the ZF + DC audit (Soifer's Open AC Problem 62.14); then the density family, Falconer's mechanism in CP form, `k`-point correlation constraints (FS-80's route) | decisive: given MR it is rung D (row 128), and a question about measurable colourings (row 130); success very low — the advisor's prior for six itself ≈ 0.03; a named no-go, or a tie of `χ_CP` to `χ_m`, the likely product |
| 2 | **FS-62 six is not a value** — `plans/STUB-six-is-not-a-value.md` | re-aimed (the advisor's order, above FS-59): S's exact form given MR — given MR, S ⟹ `χ(ℝ²) ≠ 6`, and row 128 states S's exact form over totally real fields — finitely many residue sizes, infinitely many local planes, not a finite family; the gate on the image of `F ↦ χ(F²)`, an hour, unrun | a derived frame, soft as to truth — Kooshi: *"It's just one possibility with some soft evidence"*; his 2026-09-26 target names its strong statement, G64's S |
| 3 | **FS-67 colourings of gap-free products** — `plans/STUB-tight-product-colourings.md` | re-aimed: product locality (PL) in CP form at the non-mixing places, `k = 5, 6` — must a CP `k`-colouring of `UD(ℝ²) × ∏ G_v` come from `UD(ℝ²)`? `PL_∃(23, 43)` is its instance; given MR and row 128, PL is the only non-archimedean content left in the target. Closed as a milestone (rows 114–115); **left from it:** three colours, a Hoffman-tight counterexample (a regular Hedetniemi factor with `μ_min ≥ −d/(k−1)`), Zhang's IS-imprimitive exception … | derived: PL is necessary for S under HN = 7 and for the conjecture's six-clauses; soft as to truth (Hedetniemi fails from four colours up; these factors do not mix); mechanism — G61 (3)'s 11 half now a theorem, its 7 half measured; `PL_∃(23, 43)` is one conjunct of six at ℚ(√167) (row 125) |
| 4 | **FS-59 ℚ(√167): six colours** — `plans/STUB-four-colours-167.md` (its head block first) | re-aimed to `PL_∃(23, 43)` and the wall at 23 and 43: given MR and row 128, six at ℚ(√167) is rung D plus `PL_∃(23, 43)`, dearer as a route to six; its own question is whether the conjecture's widest gap reaches the plane's value. Five is answered at [hand], through MR, by two routes (row 123). The finite routes stood so: row 84 priced a matched ball out; `L21cc6506` is loose at four, row 81; 7 minimal lattices of a finite part of the saturated chain survive capped screens and P3b (no quotient colouring to `N = 15`, undecided at Λ₂₃₂₈'s 13 and Λ₂₄₄₈'s 15) … | **the conjecture's widest gap** — predicted ≥ 6 against a proven 5 at [hand] (4 in the kernel, row 119), robust to every level of the tower at 23 (row 75); the five confirms and cannot falsify (FS-64); its ≥ 6 is archimedean modulo PL, MR being held (row 120); six contains `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)` (row 125, which makes J39's T-J39-5 exact) — both conjuncts open, no density bound can give the first … |
| 5 | **FS-102 the fallback write-up** — `plans/STUB-writeup-main-clause-five.md` | rows 120–123 written up at [hand]; the publication rule half fires (§ Publication); whether it now leads with rows 128–130 (the collapse; `α₁(ℝ²) = m₁(ℝ²)`, given MR) is Kooshi's call; `[Johnson2000]`, `[Johnson2006]` first (Kooshi, acquiring); MR's external input cited as EL2021 Thm 1.3 with FS-105's deduction | none; Kooshi's fallback if the push toward six stalls |
| 6 | **FS-80 a window-frequency certificate at four colours** — `plans/STUB-window-frequency-certificate.md` | re-aimed: averaged certificates at five colours on the real plane, the integrality shape a six certificate must take (G24) and FS-104's route (c) — its shape derived in-ban, the LP post-ban (the advisor). At four colours: a window-frequency Farkas certificate of non-four-colourability kept small by the point group, aimed at ℚ(√167)'s survivors (row 80, G73); beside it the radius-≥ 2 cocycle route … | derived as the shape a six certificate must take, soft as to success (the fractional version caps at 4.36, G60); at four colours it would restate a value held — five at ℚ(√167) is held at [hand] by measure rigidity (row 123) |
| 7 | **FS-96 windows at the non-mixing places** — `plans/STUB-windows-five-nonmixing.md` | `PL_∃(23, 43)`'s negation at five, FS-59's question from the other side (the advisor); re-aimed (J39's R3): for existence the places are `{∞, 23, 43}` modulo SP; GAP-1 does not arise in the CP format; GAP-2 is PL(23, 43), FS-67's question in CP form … | speculative; given MR, exactly whether ℚ(√167)'s plane is five-colourable (row 125) |
| 8 | **FS-64 the adelic window colouring** — `plans/STUB-adelic-window-colouring.md` | every ceiling we own uses ONE place: build a cut-and-project colouring on the S-integers of F in ℝ² × ℝ² × ℚ₃²; can it beat 6 over ℚ(√167)? At six, a mixed CP six-colouring at a field with a non-6-thick place is "six below HN" (R1). Four-colour windows, characters and finite-place spectra are closed, five-colour windows reduced to nine places (rows 92, 96, 101, 110, 112–113; FS-96, FS-98); four-colour Kronecker windows: the `E`-form moot over T-C(A)'s class through MR (rows 116–117, 123) | **the only ceiling instrument that could decide six** — one of the two ways six can occur if HN = 7 (derived); G64 puts six in the gap between L(F) and χ(F²); speculative, low confidence (the conjecture predicts no) |
| 9 | **FS-63 the crystallography gate** — `plans/STUB-moire-coincidence.md` | re-aimed: the aperiodic-order gate for `Y` with `p`-adic factors, in the product-locality cluster (FS-67, FS-59, FS-96, FS-64) — not `χ_CP(ℝ²)`'s home (the advisor); a prior-art session in the vocabulary of coincidence site lattices, Moiré superlattices and aperiodic order (G62): does it already hold the rotation screen, the index arithmetic, or a colouring theory for planar modules? … | none directly; free classification theorems or the negative, and the paper's second-discipline vocabulary (FS-20) |
| 10 | **FS-49 one gadget for six** — `plans/STUB-distance-two-gadget.md` | route D, rung D's finite-graph form, needing no MR (given MR and row 128, such a graph exists iff `χ_CP(ℝ²) ≥ 6`): one five-colour virtual edge at distance 2 in a real F ⊇ K, on `[ExooIsmailescu2019]`'s host (G26, G55); the arena's sweep found none (G31) | the highest of any stub if it lands, in the genre that returned zero on the arena |
| 11 | **FS-44 the fifth colour** — `plans/STUB-fifth-colour-structure.md` | re-aimed: given MR, a five-colouring of `K(√7)²` exists iff `UD(ℝ²)` has a CP one (R1's walk, from T-J39-3), so its question is the shape of a CP five-colouring of the plane — FS-104's mirror; before it, the algebra of where the fifth colour may go over a 6-open field | a derived frame, the upper side of rung D; low as work until a statement exists |
| 12 | **FS-69 the all-levels certificate at 43** — `plans/STUB-certificate-at-43.md` | FS-59's necessary condition (five at every level of 43) and a window member; **post-ban** (the owner): a relaxation smaller than FS-66's, priced out at 43; five colours need `U < 369.8`, six `U < 308.17` | none directly; "43 at depth" in six at ℚ(√167) (row 125), and the last gap in M3's finite-place window count |
| 13 | **FS-57 the fractional wall** — `plans/STUB-fractional-wall.md` | route C: refuse six at the reachable window members by `α(U_Q) < Q²/6` — 47 (needs 368 against the certified 371) and `U₆₄` (needs 682 against Hoffman 768); **post-ban** (the owner) | none on `χ(ℝ²)`; it bears on S's product conjunct only if HN = 7 |
| 14 | **FS-100 one missing lemma for three fields** — `plans/STUB-measure-rigidity-three-fields.md` (minted by J47) | **MR proved (row 120); `χ(ℚ(√47)²) = 5` (row 121); wave 3: `χ(F²) = L(F)` for `L ≤ 5` over every real number field (row 123), the type-(B) rotation-invariant half (row 124), six at ℚ(√167) reduced (row 125)** — [hand]; prior-art gate negative (X24R); the in-ban round's results stand (rows 116–118); FS-97 absorbed. **Left**, none bearing on six: TR-ROT, closed on `E` and a GAP at NA₀ (row 126); C-4 (transience); MR at row 100's exception fields (no colouring consequence: they have `L = 2`); MR's complex-place case on an instance; the kernel port (FS-101); stage 4′ moot for ℚ(√47). MR hardened at FS-105 (row 120's grade) | none |
| 15 | **FS-101 the main clause through five in the kernel** — `plans/STUB-main-clause-five-kernel.md` (rank Kooshi's; default just below FS-100) | Kooshi's target (06:5x): *"The target for the Lean implementation should move to the more general 'every real' claim."* **First slot done (row 127):** the headline and `χ(ℚ(√47)²) = 5` in `Proofs/` over named hypotheses, `χ(ℚ(√47)²) ≤ 5` unconditional. Next: `InvariantMeasureOnClosed` as Markov–Kakutani; the collapse over named hypotheses (FS-103's Phase 4, Kooshi's call); then the upper half via row 57's gap, then Herglotz–Bochner | none; the conjecture's proved range to the kernel's word |
| 16 | **FS-65 an exact independence number for the window planes** — `plans/STUB-exact-independence-solver.md` | `α(Γ_q)` exactly at the window members, where every off-the-shelf exact solver fails; at 23 the question is integers — best set 87, six needs 89 | none on `χ(ℝ²)`; `α < ⌈q²/6⌉` closes a wall member, never opens one |
| 17 | **FS-17 the first digit at 23** — `plans/STUB-first-digit-23.md` | is Γ₂₃ six- or seven-chromatic? Five is refused (FS-56), so `χ ∈ {6, 7, 8}` (eight in the kernel); six needs `α ≥ 89`, and the best set found is 87 | a six-colouring makes 23 the first exactly six-chromatic plane and `χ(ℚ(√167)²) ≤ 6` a theorem; a refusal of six puts ℚ(√167)'s local bound at 7 unless 43 is six-chromatic |
| 18 | FS-55 the antipodal conjecture — `plans/STUB-antipodal-colouring.md` | does every plane have an optimal colouring symmetric under z ↦ −z up to a colour involution? True at all four planes where χ is known … | medium-high as an instrument, not a decider of six |
| 19 | **FS-78 the five-colour rigidity table** — `plans/STUB-five-colour-rigidity-table.md` | G68/G69's screens at five colours over the 6-open fields: 25 of K(√7)(i)'s 28 quartic CM subfields loose for free, two survivors and every rank ≥ 6 lattice unscreened | medium — where FS-49's gadget can be built at all; since row 123 it asks only where a five-colour compulsion can live |
| 20 | **FS-42 5-tight quotients of 6-open planes** — `plans/STUB-tight-quotients.md` | a reading with its falsifier: the one constructive residue route to a five-colour forced pair row 66 leaves — a Cayley quotient of a 6-open field's plane that is five-colourable and 5-tight (G54, G48) | medium-low, a reading |
| 21 | **FS-43 the slack census** — `plans/STUB-arena-slack-census.md` | row 66's theorem on a graph against itself: a five-colour forced pair can sit only at vertices frozen in every five-colouring; on the ρ₆₃ arena the census is ≤ 132 interface vertices | medium as an instrument, two-sided |
| 22 | FS-45 chain, don't spindle — `plans/STUB-chain-theorem.md` | D1–D3 in the kernel (row 103). Left: `G4`'s certificate, a fresh LRAT of the 588-core's refusal (post-ban, after 2026-10-01); `χ(ℚ(√2,√3)²) ≤ 4` by the dyadic residue colouring; G55's vertex bound | none on six directly; the first 6-open field's five-digit in the kernel, one certificate away |
| 23 | **FS-39 the bridge to the plane** — `plans/STUB-plane-bridge.md` | `χ(ℝ²) = sup` over real number fields of `χ(F²)`: in the kernel conditional on `RealAlgebraicDescent` (row 107), route C in the kernel (row 104); left, B2, the hypothesis itself (months). Partly superseded: given MR, row 128 attains `χ(ℝ²)` at a named field | none on finding a 6-forcer; every `χ(ℝ²)` sentence cites a kernel theorem with one named hypothesis |
| 24 | **FS-75 the three-colour criterion in the kernel** — `plans/STUB-three-colour-criterion-kernel.md` | **minimal instance landed** (row 119: `χ(ℚ(√167)²) ≥ 4`); next the family theorem (row 82), the winding its first input; then S1 and no mixing (row 99) … | none; the falsification field's kernel bound (four; five at [hand], row 123) |
| 25 | **FS-90 two hours of sanctioned search** — `plans/STUB-sanctioned-search-fs86.md` (Kooshi's grant) | FS-86's finite-witness questions, priced side by side: HD1-cert's certificate on `Λ₅₁₀`; is `√3` a four-colour virtual edge in ℚ(√2,√3)'s plane; a triangle-free forcer of `(0, 4)` inside `ℚ₂(√3)` (row 88's stage Y1, from 2026-10-01); `Λ₅₁₀`'s route 4 | none directly; a yes on the third is Soifer 55.1 as posed (its existence half answered, row 121) |
| 26 | **FS-98 transience over the type-(B) fields** — `plans/STUB-ultrametric-continuation.md` | re-aimed (J38's R1) to isolation across an ultrametric front (T-B1) alone — row 88 ⟺ T-B1 (MR held, row 120); **TR-ROT** beside T-B1 (row 124; T-B1 ⟹ TR-ROT), a GAP at NA₀ (row 126); defect growth (T-B2) demoted … | none directly; row 88's other half — either FALSE is its "no" |
| 27 | **FS-76 four colours: inheritance, certificates, decidability** — `plans/STUB-four-colour-inheritance.md` | existence and inheritance at four colours for Cayley graphs of ℤ^r (`[Ellenberg2018]`'s question at `k = 4`); rank one reduced to single colourings (row 108), open at FW and KT … | none directly; high on the programme — whether lattice compulsions at four and five colours are always visible to periodic colourings |
| 28–60 | FS-95, FS-87, FS-92, FS-68, FS-47, FS-60, FS-46, FS-48, FS-72, FS-77, FS-88, FS-93, FS-94, FS-99, FS-41, FS-51, FS-52, FS-20, FS-2, FS-13, FS-12, FS-19, FS-37, FS-27, FS-23, FS-22, FS-30, FS-35, FS-8, FS-29, FS-9, FS-10, FS-5 — in rank order; their rows are `plans/FRONTIER-STUBS.md`'s alone | … | … |

**Closed as directions** (reasons in the grokkings): a five-colouring of ℚ(√167)'s plane from `UD(ℤ/529, 2)`, at any level (row 75); the six-level design target over a sealed field (FS-6) and
the residue-allowed distances (FS-16), both dead by theorem (row 66, G48); the cell family, in both directions
(G29); extracting a gadget from an existing witness (G31); many spindles over one fabric (G40); designing in a
finite plane and lifting (G45); an in-field descent (G34); reaching Parts's record by pure reduction (row 62;
`plans/FS32-smus-reduction.md` §R3).

### The open structural question

**Is a pigeonhole necessary?** Every known χ ≥ 5 argument on a finite graph factors as pigeonhole × kill (G15); the field-level one through measure rigidity (row 121) names no finite graph. Must every
6-forcer carry a class pigeonhole from an enumerable family? The only necessity theorem is A1 (a
vertex-critical 6-forcer fires the fan class at five colours at every vertex), and at the top rung it is
vacuous. The useful form — a small, early compulsion from an enumerable family, forced on every 6-forcer —
is open; it would turn the classification map into a proof route for χ(ℝ²) ≤ 5, which may be false. A
warning for any enumeration: the fan compulsion A1 guarantees lives on a circle about a *deleted* vertex, so
a class family enumerated over present vertices misses it.

## Grokkings — the working theory of the 5th colour

*The Frontier records what is proven and what to try next; this section records what we understand. Every entry carries a status (grades: § Notation). A reading is never silently promoted, and a **[reading]** names its killing test. Entries are
rewritten in place to current state — but **a grokking that dies is demoted with its refutation recorded, never deleted**: the entry keeps, in one or two sentences, what it wrongly claimed and what killed it. G1–G81 are stable identifiers cited across `plans/`: never renumber (the numbering order in this section is not chronological).*

***Every milestone opens with the reframe (WORKFLOW 2.0 step 3, Kooshi, 2026-09-22): first the re-grokking (3.1) — each entry below, each
row's mechanism in `LEDGER.md` and each method rule read from inside the milestone's question and its bearing extracted into the plan's phases, the
recognition it yields being the prior-art gate's (3.2) search query — then, for a derivation milestone, the invariant question (3.3, G72) — then the subplan (4); with the rigor of the modeling passes (6). The
entries are written to be reasoned from, not looked up, each ending in G67's form. These entries are the most important prior art this project holds; they are in context so that they are used, and a plan
that reasons from the literature's analogies while they sit unread has used them as background. FS-70 is the instance: G54's classifier, G16/G32's
pigeonhole form and G40's absorption each bore on it and none was run until asked for.***

**The theory in one paragraph.** The 4/5 wall is arithmetic. A unit-distance graph over K is
4-colourable by a residue colouring at the prime above 2, so a 5-forcer is K-fabric — a small vocabulary of
seam shells about rotation centres, organized by the half-spindle group — plus a spindle whose radicand
breaks the 2-adic wall; its forcing is a regional pigeonhole on the fabric composed with kills that must
leave K, invisible at the pair level. Past five colours the linear arithmetic goes blind and the finite
residue planes take over: a field is 5-sealed when a usable small prime's plane is 5-colourable, the sealing
plane carries no pair compulsion of its own, and a spindle over a forced pair removes exactly the prime that
sealed its fabric. That mechanism now has no instance: the sealing plane at 11 has a fan gap, and a gap at level one frees every
pair above it (row 66), so over every 5-sealed field the five-colour compulsion structure at arity 2 is trivial —
forced pairs are single vertices, virtual edges unit edges — and a residue plane forces pairs only where it is
Hoffman-tight or pulls back from a tight quotient (row 87), which at five colours no sealing plane does (G54; at 2 with four colours the plane is tight and the
tower forces from level 5, row 67). So a 6-forcer's every compulsion lives in a 6-open field (G48), where the
residue method is silent; what it can still name is a 5-colourable, 5-tight
quotient of such a plane (FS-42), or the first digit at 83 (FS-40). Through five the residue reading is exact: χ(F²) = L(F)
whenever L(F) ≤ 5, over every real number field (row 123, [hand], through MR) — the lower half by measure rigidity for the
unit-vector group (G80), with no forcer; and where every stable place mixes, the field's number is the plane's (G81).

* **G1 — The field wall. [kernel]** The Moser twist is a seam-group word (ρσ² = −1), the seam group's
  countable closures are exactly 4-chromatic, and all of K² is 4-chromatic (Theorem B). A 5-forcer's
  coordinates must break the 2-adic wall — contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247
  (G35). The certified witnesses' √5 and √7 are instances, not the criterion. *Do: before any solver on a candidate,
  read its field's square classes for an odd one ≡ 7 (mod 8) (G35's congruence); none means Theorem B four-colours the
  object and the null is free — never run it. Nothing kills it; it kills every five-colour design in a wall-standing field.*
* **G2 — Construction grammar. [measured]** Rings of vertices about a point ⟺ that point was a rotation
  centre of the construction: de Grey's graph has two ring-hearts (its spindle centres), Heule's one. Mirror
  defects are the chirality of a rotated copy. *Do: when you see rings about a point, name it a rotation centre and look
  for the copy; when you design, expect one ring-heart per rotation used and read mirror defects as the copy's chirality.
  Killing test: a witness with rings about a point that was no rotation centre of its construction.*
* **G3 — Radially crystal, angularly detuned. [measured]** Every exact radius of the three certified
  witnesses about their centres lies in ℚ(√33); the new-field content lives in the angles. This is the
  hexagonal fabric's form. *Do: read a witness's new field in its angles, never its radii; when you build, the rotation is
  the parameter — enumerate every in-field detune (G7's family) and screen the base against each, rather than asking the one
  detune a base's norms happen to realise. Killing test: a certified witness with a centre radius outside ℚ(√33).*
* **G4 — One shell vocabulary. [measured]** Every known 5-forcer stands on one inventory of ~30–44 seam radii; 25 of de Grey's 29 per-centre rings are Heule-510 rings.
  *Do: check a new forcer's shells against the inventory first and expect nothing new from them — a fourth witness's radii
  are a lookup, not a discovery. Killing test: a five-forcer over K whose shells lie mostly outside the inventory.*
* **G5 — Ownership factorization. [measured]** De Grey's graph is two congruent 29-ring single-centre
  systems; as a graph it is a 1-sum of two 791-vertex halves at vertex 14 plus the one cross edge (11, 802).
  *Do: when an object is a 1-sum, test the halves apart and expect the join to carry only its edge — a compulsion of the
  whole is a compulsion of a half or it is the cross edge's (and then G40 says the copy absorbs). Killing test: a compulsion
  of the 1581 that neither 791-half carries.*
* **G6 — The hexagram is fabric, not seed. [measured]** Heule-510's centre carries the certified hexagram,
  but the hexagram plus any single detuned copy stays 4-chromatic: containment, not causation. *Do: when a base contains a
  certified object, do not read it as the seed — one detuned copy over any fabric predicts a four-colourable arena before the
  run, and containment (checked in seconds on the base half alone) proves nothing. Killing test: the hexagram plus a single
  detuned copy refusing four colours.*
* **G7 — Detuning, read arithmetically. [measured + theorem]** Every forcing rotation is a small detune off a
  crystal angle (ρ₁₅ 1.045° off 30°, the Moser twist 3.557° off 30°), but the angle is the metric shadow: a
  spindle at distance d adjoins √(4d² − 1) and forces the next colour only if that radicand breaks the
  relevant wall, which every even d does for the 2-adic one. Haugland's heptagonal construction closes with
  the same ρ₁₅ = (7 + i√15)/8, because the radicand depends only on the forced distance.
  **The "detunes" are one family, and the family IS the spindle — which is prior art, stated in words.**
  `2d²(1 − cos θ) = 1` gives `cos θ = (2n − 1)/(2n)` with `n = d²`, the **only** rational cosine putting the
  spindle distance at integer `n` (`plans/M63-phaseH2-the-family.md` §3), with `sin θ = √(4n−1)/(2n)`: **`n = 3`
  IS the Moser twist** (`cos θ = 5/6`, radicand 11) and **`n = 4` IS ρ₁₅** (`cos θ = 7/8`, radicand 15). The family
  is a **ladder, each rung failing for the reason the next fixes**: `n = 3`'s radicand lies in `K`, so the Moser
  spindle can never reach five; `n = 4` breaks the wall but its field is 5-sealed, so the record can never reach
  six; `n = 16` (`ρ₆₃`, radicand `63 → 7`) is the cheapest member that is wall-breaking **and** 6-open.
  **Prior art, and it covers more than the angle:** `[Polymath16wikiMain]` (2018) states the family as
  `ω_t = exp(i·arccos(1 − 1/(2t)))` **and attaches the spindle reading in words** (*"the apex angle of a
  `√t, √t, 1` isosceles triangle"*); `[PartsOdd2022]` §3's `m₁ = m₂`, `r = 1` slice is the same family. **Ours:** the
  radicand form `√(4n−1)` as the adjoined quantity, the field screen over it, 6-openness as the selection criterion,
  and dropping the restriction to Loeschian `t` (the wiki lists *"particularly the Loeschian numbers 1, 3, 4, 7, 9,
  12, …"*; **2 is not Loeschian** — a second reason, beside `plans/M63-phaseH2-prior-art.md` §PA.4's census-image
  failure, that `n = 2` was never examined). *Do: read every rotation as its `n`, its radicand `4n−1` and the field that
  radicand lands in, and screen it by the four gates (row 64: free circle; `sin θ ∉ K`; the wall; 11's residue degree) before
  any base is built — the gates decide in seconds what a solver decides in hours; enumerate the family's in-field members,
  never the one rotation a base happens to realise. Killing test: a five-forcer whose rotation is no spindle — `cos θ` not
  of the form `(2n−1)/(2n)` — or a member whose radicand keeps the wall and still forces five.*
* **G8 — The direction group. [measured]** ⟨ζ₁₂, σ, √ρ₁₅ = (√15 + i)/4, √ρ₆₃ = (3√7 + i)/8⟩ closes all 67 of
  the 1581's edge directions at exponent ≤ 6. `[Polymath16wiki]` derived the Moser ring's unit group ⟨ζ₆, η⟩
  with η = (√33 + i√3)/6 = iσ⁻¹ and η² = ρ — the index-2 subgroup {ζ₁₂^a σ^b : a + b even} of ours. **Open,
  an afternoon with `tools/anatomy.py`:** are Heule-510/553's six out-of-group direction classes words in
  α = (√5 + i√11)/4, a wiki generator our set lacks? *Do: factor an object's edge directions as words in the group before
  anything else — an out-of-group class names a missing generator — and build fabric as a group's bounded-length words, never
  as free directions. Killing test: a direction of a K(√5,√7)-object that is a word in no extension of these generators by α.*
* **G9 — Rigidity lives only at the forcing level. [measured]** The 791-point forcer (the 1581's
  centrosymmetric core V ∩ −V) forces exactly six pairs at four colours: the axis pair at distance 4 and five
  **antipodal** pairs at 4/√3 — forced central symmetry on the radius-2/√3 circle. Closing the antipodal
  compulsion needs the √183 spindle, **outside de Grey's field** (K(√183) = K(√61) is itself 6-open). The hexagram chunk at four colours and the 1581 at five have no forced pair and no
  virtual edge. *Do: hunt compulsions one rung below the top — a core asked at χ−1 colours — and expect the top rung empty;
  over K the forced distances are 4 and 4/√3 and the shape includes antipodal pairs on a circle: list those targets before a
  search, and check the closing spindle's field for openness before closing. Killing test: a forced pair or virtual edge at
  the top rung of a held object.*
* **G10 — The forcing is distributed. [measured, sampled]** Random single edge deletions make the 1581
  4-colourable, and neither enrichment nor designed stacks localize the forcing. The exhaustive criticality
  sweep is unrun and no edge's witness is on disk; vertices 11, 802 and 14 are critical structurally (the
  1-sum; `data/e4-critical-vertices.json`) and a sweep should exclude them. "Minimal" should mean least
  geometry, not fewest vertices. *Do: expect no organ — minimise geometry, not vertices; exclude 11, 802 and 14 from any
  criticality sweep, and run the exhaustive sweep before claiming edge-criticality. Killing test: an enrichment or stack that
  localises the forcing to a small subgraph carrying it alone.*
* **G11 — The Moser subgraph is not necessary for 5. [external, unverified here]** Voronov et al. (2021,
  64,513 vertices) and Haugland (arXiv:2608.04542; 2,131 vertices, float arithmetic and uncertified SAT) give
  Moser-free 5-chromatic graphs, by landing a forced pair at a spindle-able distance and spindling. *Do: when the field
  lacks √11, take their route — land a forced pair at a spindle-able distance, then spindle — and treat "the spindle is
  necessary" as refuted. Killing test: a verification here finding either graph five-colourable.*
* **G12 — The quadrature law. [hand (M31-T1), confirmed at 26 exact censuses; kernel for the ρ₁₅ instance (row 28)]** A detuned copy RX of seam material couples
  to X only along anchor-collinear pairs (W an even half-spindle word) or anchor-perpendicular pairs (W odd),
  with radii on one conic; words mixing √ρ₁₅ and √ρ₆₃ couple nowhere. A single detune's colour pressure is one thin conic, which is why 5-forcers
  are built from forced pairs. *Do: rank rotations by cross-edge density on their conic, never by count; expect one detune to
  press along one thin conic, so pressure comes from a forced pair or from two rotated copies (de Grey's two centres); never
  expect mixed √ρ₁₅/√ρ₆₃ words to couple. Killing test: a single detune whose cross edges leave its conic, or a mixed word
  that couples.*
* **G13 — The fan ladder. [kernel + measured]** Colour steps happen by confinement at a centre
  (`fan_iff_coverage`): two circles are 3-colourable and their centre forces a fourth; Heule-510's centre is
  fanned at four colours by the ambient web, which its own two-circle system provably cannot deliver. Fans
  are not special to centres, and coverage is a k-set property invisible to pair sweeps. The ladder's other
  face is slack: a fan gap is exactly the failure of coverage at level k−1 (`exists_fanGap_iff_not_coverAtLeast`),
  and one gap in a target colouring frees every pair above it (row 66). *Do: when a pair sweep reads zero, ask the k-set
  question — does every colouring cover N(p) ∪ Q at some centre — and when a target colouring has a gap, expect every pair
  above it free without asking. Nothing kills the iff; it kills pair sweeps as evidence about fans.*
* **G14 — Width without degree does not force. [measured + derivation]** Same-word copies at unit-separated
  anchors couple through an O(n) translation matching, and at separation 1/√3 through nothing. A matching is
  1-regular and carries no colour pressure, even composed into forced-rainbow triangles. *Do: before an arena is built,
  look at what its cross edges close — a matching-shaped cross set predicts the null; rank first the rotations whose cross
  edges close cycles through both halves. Killing test: a forcer whose only inter-copy edges form a matching.*
* **G15 — Pigeonhole × kill. [measured constructive half; universality a reading]** Every known 5-forcing
  argument composes a disjunctive class-level compulsion on fabric ("every 4-colouring puts some forbidden
  pattern somewhere") with a thin kill web refuting each placement; instance meters cannot see the
  disjunction. The composition builds 5-chromatic objects by design (row 31), and `[Heule2019]` §6.2
  describes Heule's graphs this way. In the finite lab it is **five of five**: every clique-free 1-minimal
  cell-family core (23, 28, 53, 66, 117 vertices) factors, with Act One a monochromatic pair on a small
  non-edge class. Open: whether every χ ≥ 5 argument must factor so — the one registered falsifier, M43's
  non-factoring fine tail, was itself withdrawn (a G21 instance), so universality has never been tested
  against a counterexample here. *Do: design five as a class-level disjunction plus a kill web, and ask the class question
  first — does every 4-colouring of this fabric put a monochromatic pair on class C? — because a pair meter cannot see it.
  Killing test of universality: a χ ≥ 5 argument on a finite graph that does not factor, never yet met.*
* **G16 — The distance-2 pigeonhole. [kernel carriers + measured]** Theorem B's colouring identifies every pair at
  positive-valuation distance — 2 lies in the prime above 2 (row 59) — so seam fabric of seam depth ≥ 2, or of radial extent
  past a fabric shell (r² = 2 − √33/9 on de Grey's fabric), cannot 4-colour without a monochromatic distance-2 pair: on such
  fabric the pigeonhole is free, and every kill of it needs a wall-breaking root (ρ₁₅ adjoins √15). The carrier is 122
  vertices; the √3-pair sibling concentrates to nine, because √3 is the one distance whose equilateral triangle has unit
  circumradius — but it is an **assembly product**: only the full 1581 carries it, onset at the √21 shell where
  cross-system material enters, and Heule's shrinking discarded it. **The converse on the Moser lattice is a theorem** (MASCOT-T6,
  Coxeter, 2026-09-08; surfaced by FS-71): a four-colouring of the rank-4 lattice with no monochromatic √3-pair IS one of Theorem B's
  two residue colourings — the doubling quotient is `𝔽₄ × 𝔽₄`, the two primes above 2, and `K₄ × K₄` is uniquely colourable — so on
  K-fabric the √3-pigeonhole is the only escape from the residue colouring. *Do: on fabric a residue colouring identifies, expect the
  monochromatic pair at every positive-valuation distance without asking, and spend the search on the kill — `separated` asks
  at those distances on wall-broken material. Nothing kills the pigeonhole; it kills every in-field kill.*
* **G17 — Globality lives only at the top rung. [measured]** The fan onset (χ ≥ 5 itself) arrives at the
  last vertex; every sub-rung compulsion measured has a small carrier (3-cover at 49 vertices, the distance-2
  pigeonhole at 122). *Do: ask sub-rung compulsions on modest fabric first (carriers of 9 to 122) and expect the top rung
  only at the last vertex — a whole-object ask measures the top rung alone. Killing test: a sub-rung compulsion whose
  minimal carrier is the whole object.*
* **G18 — Composition sees what search cannot. [measured]** Monolithic CDCL capped on the 4,749-vertex union
  while the cubes a kernel pigeonhole covers refuted in minutes each. Certify components, compose in the
  kernel, and pin palettes (6.5–160× measured). *Do: when monolithic CDCL caps, split by a kernel-covered pigeonhole, pin
  palettes, certify the components and compose in the kernel. Killing test: a split whose cubes each run slower than the
  monolith.*
* **G19 — 5-tight fabric. [measured + theorem]** No pattern class fires at five colours on the swept population
  (52/4/0 over 7 objects × 8 classes, M35 — not the whole inventory), and inside K none can (Theorem B); 5-tight fabric needs a wall-breaking root in the fabric itself. A
  five-colour avoider for any class proves χ(ℝ²) ≤ 5; a six-colour avoider bounds only 7-forcers. *Do: run the class sweep
  only on fabric holding a wall-breaking root — inside K the zero is Theorem B's and free — and read an avoider by what it
  bounds. Nothing kills the K half; a class firing at five on wall-broken fabric is the finding the sweep exists for.*
* **G20 — Brick colourings. [hand (M36-T1: the coset-7 family is forced boundary-tight) + kernel (the certificate) + measured]** A brick 7-colouring of the plane exists and is
  boundary-tight by force (cell diagonal exactly 1), so every strict-separation certificate refuses the whole
  family. Under the exact certificate, brick colourings reach seven and refuse six and five. *Do: use the exact certificate,
  never strict separation, and read one brick refusal as the whole family's. Killing test: a brick six-colouring under the
  exact certificate.*
* **G21 — A negative measures its enumeration. [method]** A search run against a sufficient-but-not-necessary
  check measures the check; a verdict — negative, positive count, or speedup — is a statement about its
  enumeration and conditioning, and both belong in the headline sentence — scope lines inside an artifact do not survive into
  summaries unless they are in the headline. When a sweep refuses, the first question is not "what does this say about the
  objects" but "is my acceptance test the exact condition, or a sufficient one?" — because a conservative test converts a
  *finding* into a *measurement of my own instrument*, silently and with the registered-prediction discipline fully satisfied.
  At registration, say whether the acceptance test is also necessary — and if it is only sufficient, what a refusal therefore
  cannot mean. Point every new instrument at a known positive before believing its zero;
  assert on the written artifact, never on the list that produced it; a control the instrument cannot see is
  not a control. **And where a phase's output is eliminations, its defects all point one way**: four in one phase
  (M63 phase G, 2026-09-11) — an edge law that drops an edge, an over-merged equivalence key, a float sign test inside
  an exact verdict, a truncated input with no producer — every one silent and every one biased toward making the
  survey look productive, because a missing edge yields an easier graph, a colouring, and a "sound elimination". So
  an elimination carries an exact quantifier or it is not one, and where a phase also has a positive product, **the
  count of eliminations is the outcome to be least satisfied with**. **The mechanism is selection**: a defect whose
  result displeases is investigated within the hour; one whose result pleases is kept — five independent defects in
  three phases of M63 were every one flattering. **Audit the results you like at the same rate as the ones you do
  not**, and when an artifact and its written record disagree, suspect the newest thing in the file first. **The census's own
  instance (FS-71, row 77):** of four hand claims that had no proof on disk, the one that was wrong (M37's general-lattice bound)
  was the one stated as a bare number — a conclusion with no chain is the shape to re-derive first, and the corpus under-graded
  its hand derivations four times for every over-grade. **And a periodic search measures its period cap** (FS-73, twice in one
  milestone, row 79): ℚ(√167)'s `L3e1c94c6` read as having no periodic three-colouring because the search stopped at `N = 20` —
  its least period is 23 — and the survivor `Ld14c588b` colours linearly with period index 1,080, past `N ≤ 30` and circular
  `N ≤ 120`. **Read a solver's colouring before searching its periods:** one Fourier transform of FS-61's 1.47 M-point colouring
  showed a single character of amplitude 0.74 that named the period 23 at once. **And a one-period census measures its period** (FS-79, row 81): 4,490 orbits of `L21cc6506`'s 4Λ-periodic colourings, every one Kempe-rigid, and two known `Θ₄` cells (a point, a 2-cell) read as a candidate rigid lattice; a three-minute look at the cells themselves found full-dimensional ones and `P = F = 0`: a finite set of periodic colourings can only ever pin a full-rank group, and a finder that stops at its first point measures that point. P3b typed its survivors' nulls only after three known positives at their coefficient size came back loose: a control at the scale of the question. **FS-81's three** (rows 83–84): **a relation tree is a weak finder of isolated points** — it left Λ₂₆ over ℚ(√3) undecided at 171,657 nodes and 312 s where a small-order screen found the point in 3 ms, so the screen runs first and a high-order isolated point reads UNDECIDED, never NONEMPTY; the second and third, and the rest: `plans/GROKKING-INSTANCES.md` §G21. *Do: when a search, sweep or census returns a zero — or a count, a speedup, an elimination — ask first whether the acceptance test is the exact
  condition or only a sufficient one, and put the answer and the enumeration's bounds (its period cap, radius or generator image) into the
  headline sentence; before believing a new instrument's zero, point it at a known positive at the scale of the question; check the
  written artifact, not the in-memory list behind it; and audit a result you like at the rate you audit one you do not. Killing test:
  a zero reported with its enumeration in the headline that readers still took for a fact about the objects (the rule is not enough), or
  a run of milestones in which no headline scope ever changed a decision (the rule is ceremony).*
* **G22 — Where a six-colouring cannot live. [kernel + prior art]** No colouring constant on a triangular
  lattice's cells uses six colours (rows 34–35), and no polygonal colouring does (`[SokolovVoronov2025]`). A
  six-colouring, if one exists, has non-polygonal classes finer than half the unit distance. Coset colourings
  need seven because 2, 5, 6 are not of the form a² + ab + b². *Do: never search for a six-colouring among cell-constant or
  polygonal colourings; a candidate's classes must be non-polygonal and finer than 1/2. Nothing kills the kernel half; the
  polygonal half stands or falls with `[SokolovVoronov2025]`.*
* **G23 — Refining is not a route down. [kernel + measured]** The cell family's requirement is not monotone
  in scale; the classical scale is a local optimum (dual form: `[deGreyParts2022]`). *Do: expect no colour saved by refining
  the scale; "refine toward six" is closed. Killing test: a scale in the cell family needing fewer than seven colours.*
* **G24 — The gap law. [kernel forcing half + measured]** Below the classical window the cell family needs ≥ 7
  at every scale (`[Voronov2023]`, `[SokolovVoronov2025]`) while ω falls to 3–5, the certified
  Hoffman/spectral bracket to ≈ 4.1 (3.56 at p = 1/7) and the fractional relaxation only to χ_f ≤ 48/7 at
  G\* (α(12×12) = 21) — **the step to seven is integrality**, not a low relaxation: the exactly certified
  χ_f are 130/23 at the 23-core, 501/74 at the 53-core and ≈ 4.83796 at the 117-core. The plane's own
  pathology (ω = 3, relaxations below χ, χ = 7) in finite
  kernel-checkable objects, the smallest the 23-vertex core with χ = 7 at ω = 4. Open: the deep pocket's
  χ ≥ 8 in the kernel; a relaxation that sees the gap. At five the relation inverts: row 123's five is a fractional bound rounded up, the count entering at one pigeonhole (row 129, G60). *Do: when a relaxation reads far below χ on a plane-like object,
  expect integrality, not a low bound — certify χ on the exact object and spend no relaxation on the gap. Killing test: a
  relaxation that certifies seven on a gap-band core (the open item; it would be a finding).*
* **G25 — The forcing ladder is recursive. [reading]** For the objects held, χ ≥ 4 is holonomy of
  rainbow-clique propagation (triangle-free routes also exist: Wormald 1979, O'Donnell 1999) and χ ≥ 5 a
  regional pigeonhole whose kills are the previous level's forcer one field up; so a 6-forcer's kills
  default to 5-forcer grade (~10⁵–10⁶ vertices, composition only) unless a shortcut shape fires. *Do: price a 6-forcer's
  kills at 5-forcer grade and name the shortcut shape before spending on anything cheaper. Killing test: a 6-forcer whose
  kills are cheaper than a 5-forcer's; per shape, `plans/SHAPES-OF-SIX.md` §3.*
* **G26 — The 6-forcer reduction. [kernel]** `hexShell_plane` puts a monochromatic pair at √3 or 2 in every
  colouring with fewer than seven colours, so χ(ℝ²) ≥ k + 1 follows from k-colour virtual edges at √3 AND at
  2 — never either alone (row 43); at six colours that is χ ≥ 7. Over {1, 2} the diameters are already edges
  and one five-colour √3 gadget gives χ(ℝ²; {1,2}) ≥ 6 (row 61). Over any field where 11 is usable neither
  five-colour gadget exists (row 55): the gadgets' field must be 6-open. With `[ExooIsmailescu2019]`'s 426-vertex {1, 2}
  graph as host, one five-colour virtual edge at distance 2 gives χ(ℝ²) ≥ 6 (GPT Astra, G55) — M49's descent replaced its 892
  length-2 edges one at a time; the ρ₆₃ arena has none (H4's sweep). *Do: aim every six-gadget hunt at one five-colour
  virtual edge at distance 2 (or at √3 over {1, 2}) in a 6-open field — over an 11-usable field the gadget cannot exist, so
  do not ask there. Nothing kills it; it kills every six-gadget design over a sealed field.*
* **G27 — Hidden arithmetic symmetry. [measured]** The Galois flip √3,√5,√11 ↦ −√3,−√5,−√11 is an automorphism
  of the 1581, which has no plane self-isometry; its Klein four-group orbit yields three new 5-chromatic
  witnesses. Forced equivariance under non-geometric automorphisms is an unused compulsion vocabulary. *Do: before any SAT
  ask over a multiquadratic field, test each Galois flip for automorphism and break the symmetry it gives; read a witness's
  Galois orbit as free witnesses and the quotient as a finder's instance. Killing test of its value: a Galois-broken ask no
  faster than the unbroken one.*
* **G28 — The fine-tail forcing factors. [measured]** The p = 1/7 stage carries 7 triple-encoded virtual
  edges (51 on its critical stage), at offset norms 27, 28, 31 — none among the six smallest non-edge
  classes, which is why a six-class sweep reads zero. Act Two exists there. **Demotion record:** as minted at M43 this entry claimed the opposite — "the fine-tail forcing does NOT factor: pigeonhole × kill is not universal; zero virtual edges at k = 6" — from six anchored asks on the R = 8 stage; M45 re-asked 9,636 pairs on the identical stage (fingerprint `9d9599be0db64677`) and found the seven, so the claim measured its acceptance set, not the object (G21's second instance).
  *Do: forcing sits at offset norms outside the smallest classes — sweep every non-edge class, never the six smallest, and
  when a class sweep reads zero, say which classes it swept. Killing test: a full-class re-ask on the fingerprinted stage
  finding no virtual edge.*
* **G29 — The cell family is a dial, and it is closed. [kernel + measured]** As the scale p → 0 the cell
  family's limit is the unit-distance problem, and its value is 7 on the whole open ray. By the limit lemma
  (row 41) the divergence of the critical size N(p) is necessary for χ(ℝ²) ≤ 6; in the family the edge defect
  falls like p while the size grows like p^(−1.75), so it supplies no bounded family either — closed both
  ways. Compare our measured refuting radius (1.02–1.38) with `[Voronov2023]` Thm 1.3's radius-3 disc. *Do: spend nothing
  on the cell family in either direction. Killing test: a scale with χ < 7, or a bounded refuting family whose defect tends
  to zero.*
* **G30 — Measurement generates; derivation kills. [method]** A measurement buys a candidate pattern; a
  conclusion is bought by a derivation or a pre-registered replication on fresh objects. Sorted by provenance — three times, the
  last over 2026-09-05 to 2026-09-26 (the lists, the counting rule and the counts: `plans/GROKKING-INSTANCES.md` §G30) — the record
  is lopsided in one direction: **derived from structure first — survived, all but a few**, and each that died was one
  derivation's step, caught by another derivation, a review or an exact counterexample; **measured first, then interpreted — died,
  all but a few**, and each that survived had been bought afterwards by a test it could have failed or by a derivation. The rule this yields is NOT "measure less" — every derivation above began life as a pattern somebody noticed in
  a measurement, and the quadrature and stacking laws were derived precisely because earlier censuses had shown where to look
  (Kooshi's correction, the load-bearing half: *"the interesting patterns that become intuited and derived show up first from
  measurement, so it's a catch-22."*). Prefer measurements that turn a DIAL (a parameter whose behaviour is informative in both
  directions — G29's ladder, the hetero-dimer effort curve against overlap) over searches that hunt for a POSITIVE (whose null
  result is uninterpretable); and prefer CALIBRATED test beds — ask the new question on an object whose answer is already
  certified, so a zero reading bounds the instrument instead of being mistaken for a fact about the world. Failure modes:
  1. An escape clause whose interpretation contradicts what is already proven about the objects. Write the escape clause to the
     same standard as the prediction: a pre-registered interpretation is still an interpretation, and being committed in advance
     protects it from hindsight bias but not from being false.
  2. A prediction applying a grokking whose quantifier does not match the measurement — "no seam-field object forces five" does
     not imply "no seam-field halo replaces a defect".
  3. A verdict message naming a cause it did not check, which converts one bug into two (a defer message said "cost budget", a
     cause that never fired, sending the first diagnosis toward budgets while the size guard was the culprit).
  4. A derivation that is correct and second — novelty is a literature search at the opening (G49): "derived, therefore ours" is
     exactly the inference this grokking forbids everywhere else, and the search belongs at the opening, where it can still
     change the work.
  5. A theorem over a provably empty domain: every theorem whose hypothesis is a structure ships a named
     inhabitant (`scripts/vacuity.sh` enforces this).
  6. A correct instance recorded where a theorem was available (look for `[measured]` beside a small finite
     list, hypotheses narrower than the proof uses, a `decide` doing a step ring theory names). After
     generalizing, delete each hypothesis once and confirm the proof breaks. **Every one of these readings is TRUE**, which is
     exactly why they survive every gate this project has — nothing is wrong, something is merely smaller than it needed to be.
     The cause is not a bad inference; it is that *the instrument answered and the question closed*.
  7. A hypothesis implied by the emptiness of the conclusion's domain (`¬ Colorable G⁺ k → ∀ C : G.Coloring
     (Fin k), …` with G ≤ G⁺); remedies: the two-way form, a witness folded into the checked `Bool`
     (`NarrowCert.check`), or the inhabitant as a hypothesis.

  When a wall resists derivation, name the discipline its statement lives in and look for the theorem there
  (so far: graph theory → SAT → formal verification → Euclidean geometry → algebraic number theory → p-adic
  algebra → additive combinatorics → finite-field geometry; → topology (entered at FS-79: its cell-local four-colour formats are empty or blind and the coindex bounds stop at four on
  unit-distance graphs; the index bounds and non-local cocycles are open, row 80); → topological dynamics and algebraic `ℤ^d`-actions (entered at FS-89, row 95; its ergodic theory of amenable actions at row 88's close, row 111); → descriptive set theory (Borel and measurable combinatorics, entered at M3, rows 109–110); unentered: commutative algebra, FS-10).
  **The pattern: the project hits a wall in discipline N; the wall is a theorem in discipline N + 1; that theorem explains the
  wall and opens the next room. Every transition was forced by a specific obstruction, never by wandering — which is why
  "derivation kills, measurement generates" keeps holding: the walls ARE the theorems, and the work is recognizing which field
  each one belongs to.** Its positive form: Kooshi's instruction to write the conjecture UP for a stranger forced its structural
  statement (the unit-distance graph on F² is the Cayley graph of the additive group F(i) with connection set the norm-one
  torus), and the classical tool (Woodall/Fischer additive colourings) became visible the moment the object was named. *Rule:
  before spending days of compute on a conjecture, write it for an outside reader in its native mathematical vocabulary; the
  write-up is a derivation attempt in disguise, and it is cheaper than one census.* *Falsifier: none needed; like G21 this is a
  methodological invariant and it fails only by being ignored — but the tally is falsifiable: by a measurement-first reading
  that survives with neither a registered test nor a derivation behind it, or by derivation-first claims dying at the
  measurement-first rate.*
  *Do: when a measurement suggests a law — a pattern, a zero, a count that looks general — record it as a candidate, never a
  conclusion, and buy the conclusion separately: derive it, or register a replication on fresh objects before running it; before
  spending days of compute on it, write it for an outside reader in its native vocabulary, and if it resists derivation, find the
  discipline where its statement lives and seek the theorem in it; prefer a dial to a search for a positive, and ask a calibrated bed
  first; write every escape clause to the prediction's standard, and check that a grokking's quantifier matches the measurement before
  applying it. Killing test: the one above — a reading bought by neither a test nor a derivation that survives, or derivations dying
  as often as readings (the sort: `plans/GROKKING-INSTANCES.md` §G30).*
* **G31 — No unit-distance object we hold, built or found, carries a pair compulsion at its top rung. [kernel on the
  sealed objects (row 66) and for the 1581's arity bracket; measured, complete at arity 2, on the 6-open ones]** **On
  sealed objects the arity-2 emptiness is a theorem**: Heule-510's `Forces ↔ =` and `Separated ↔ Adj` at five colours
  and its arity floor ≥ 3 are kernel, and hold for every unit-distance graph over any 5-sealed multiquadratic field
  ⊇ K, because the sealing plane's fan gap frees every pair above it. **On 6-open objects it stays a
  measurement, unexplained.** The `ρ₆₃` arena — produced, in a 6-open field where row 55's bar does not apply — has
  **0 forced pairs of 1,307,266,278 and 0 virtual edges of 1,306,721,748**, certified by 4,480 exhibited
  five-colourings with no solver UNSAT; Heule-510 and Heule-553 return 0 and 0. Its compulsion budget is 66 of
  544,530 edges (36 off-diagonal once G52's free diagonal is removed) — rank candidate bases on that, never on circle
  count. Open: arity 3, swept only on 163 interface vertices, 337 candidates standing. No filter can help on a 6-open
  object: a field is 5-sealed exactly when some usable prime's plane is 5-colourable, which IS the residue filter's
  hypothesis. `Forces` is monotone upward in the graph (`Forcer.Forces.mono`), so refuting a pair in a subgraph says
  nothing about the whole. De Grey's 1581 at five colours has no forced pair (forcing at χ allows ≤ 2 critical
  vertices, and this 1-sum has 3), no virtual edge, and no compulsion at arity 3 or at arity 4 inside a
  neighbourhood, so its arity floor is 4 or 5; its gen-1 closure adds nothing. A χ ≥ 6 gadget must be constructed.
  Unswept: general 4-subsets, other witnesses. External null: `[Heule2019]`'s graphs up to 100,000 vertices were all
  5-colourable. *Do: never extract from a held witness — construct; on a sealed object the arity-2 zero is a theorem and
  is not run; on a 6-open object rank candidate bases by compulsion budget, never by circle count, and ask arity 3 on the
  standing candidates before any new arity-2 sweep. Killing test: a pair compulsion at the top rung of any held
  unit-distance object.*
* **G32 — The two-distance dial. [kernel + measured]** A pair forced equal at k colours is a
  (k+1)-chromatic graph with one non-unit edge, so μ(d) — the fewest d-edges of a non-5-colourable
  {1, d}-graph — is a dial whose value 1 is χ(ℝ²) ≥ 6, read by adding unit material to a forcer. Kills are
  coverage compulsions at points outside the object and are context-dependent. μ ≥ 3 inside K (G36); μ = 1
  is impossible in any 5-sealed field. *Do: on wall-broken fabric ask the `{1, d}` distance-graph question
  (`tools/twodist.py`, `tools/killengine.py`) before any pair sweep — μ(d) = 1 is a forced pair, a small μ is the pigeonhole
  form with its kill count — and read the dial as unit material is added; in K or any 5-sealed field expect μ ≥ 3 and μ ≠ 1
  without asking. Nothing kills the sealed half; a `{1, d}` graph with one d-edge refusing k colours on 6-open fabric is
  the finding the dial reads.*
* **G33 — Batches compose; growth compounds. [measured]** A halo designed against a whole batch's separating
  colourings composes removals by construction; committed material's own partner lattice re-opens refusers;
  the cull (dropping jointly redundant cheats) needs no geometry. Reading: depth-one descent self-accelerates
  until width-shaped stalls bind. *Do: grow toward a forced pair by counterexample-guided growth — add the depth-one points
  that kill each separating colouring, cull, iterate — instead of a fixed ball, and expect self-acceleration until a width
  stall. Killing test of the reading: a descent whose per-wave kills fall before any width stall binds.*
* **G34 — The field is the selection. [measured + theorem]** Every committed descent point lies in K, because
  every kept glue point is a parent plus a Moser-lattice unit vector; in-field material is 1.0% of the
  depth-1 pool, essentially the points with ≥ 3 object neighbours. By Theorem B it can never do the last
  kill. *Do: use in-field points for intermediate kills only; expect no in-field endgame and commit the out-of-field
  adjunction deliberately (G37). Nothing kills it (Theorem B); it kills every in-field endgame.*
* **G35 — The wall is 2-adic. [kernel over subrings; field level gated]** For a real number field F, a
  conjugation-fixed prime 𝔭 of F(i) gives χ(F²) ≤ N(𝔭); one above 2 exists iff −1 is not a square in some
  completion above 2 (norm 2 or 4). For multiquadratic F the wall stands iff no odd square class is
  ≡ 7 (mod 8); a glue point over K with radicand r breaks it iff −r is a square in both 2-adic completions
  of K — a congruence test before any solver (of the classes {1, 2, 5, 7, 10, 14, 35, 70}, exactly 5 and 7
  break). The wall is broken iff 1/2 lies in the unit-vector ring ℤ[U] (GPT Astra's prime inversion, G55; for real quadratic fields `[Fischer1990b]` Thm 4, 1/2 ∈ Σ₀ iff N ≡ 7 (mod 8)); in the kernel in valuation form, `UnitRing.inv_two_mem_unitRing_iff` (row 105). **Reciprocity bounds the wall, but the wall is not the ramification of one algebra** [hand; corrected 2026-09-22 at
  FS-71's gate — the audit's first instance]: `(−1,−1)_F` splits at a place `v` above 2 iff −1 is a sum of two squares in `F_v`,
  which for a 2-adic field is iff its local degree is even (`(−1,−1)_{F_v} = (−1, N_{F_v/ℚ₂}(−1))_{ℚ₂} = (−1)^{[F_v:ℚ₂]}`) —
  implied by −1 being a square there (`ℚ₂(i) ⊆ F_v`) and **not implying it**: over ℚ(√2) and ℚ(√3) the algebra splits at the
  one place above 2 and the wall stands. *Demotion record: as minted this entry said the broken wall "says exactly" that the
  algebra splits above 2 and "restates the wall as the ramification of a single algebra"; both false, by those two fields.* What
  survives: a broken wall makes every local degree above 2 even, so the algebra's ramification set is exactly the real places of
  F (it splits at every odd finite place, its coefficients being units there, and is Hamilton's at every real place); that set is
  even by Hilbert reciprocity, so **no field with an odd number of real places can break the wall** — none of odd degree, since
  r ≡ [F:ℚ] (mod 2). The sharper form, odd degree ⟹ 2-colourable, is G56's by the local-degree parity argument and is
  `[Moorhouse2010]` §7.1's. The wall itself is the behaviour of the quadratic extension `F_v(i)/F_v` at each place above 2 —
  split, inert or ramified, G56's trichotomy — not of any single quaternion algebra. **Gate:** the field-level statement is row 57's gap (a conjugation-fixed prime
  supplying the valuation subring); closing it promotes G35 and G43, and it is the one lemma prime inversion's number-field reading (FS-47) and G55's T7 beyond `K(√7)` still need (M2). *Do: before any solver
  over F, decide the wall by congruence — for a K-glue point, is −r a square in both 2-adic completions; for multiquadratic
  F, is some odd square class ≡ 7 (mod 8); for any F, is 1/2 ∈ ℤ[U], i.e. does every prime above 2 split in F(i) — and
  expect no odd-degree field to break it. Killing test: a field whose plane needs five colours and whose `(−1,−1)` ramifies at
  a finite place (which would refute the parity step, not the trichotomy).*
* **G36 — The residue colouring is the canonical separating colouring. [theorem + measured]** On a K-point
  descent stage it is proper, monochromatic on every distance-2 cheat, and separates the seed's pair — one
  colouring every cheat set must kill, and a free geometry check (a misplaced point shows as a monochromatic
  unit edge). With a fifth colour on S it separates iff S is an independent exact transversal of the
  cheats, a 2-SAT system; while that is satisfiable no in-field halo makes the cheats force, so μ ≥ 3 inside
  K. `tools/residue_floor.py`. *Do: on any K-point stage compute the residue colouring first — it is the one colouring every
  kill set must beat, a free geometry check, and its 2-SAT transversal decides whether any in-field halo can make the cheats
  force. Nothing kills it; it kills μ ≤ 2 inside K.*
* **G37 — The endgame's shape. [theorem for necessity]** A descent's unit part becomes 5-chromatic only after
  an out-of-field point is committed; the endgame is one wall-breaking adjunction into a field that is also
  6-open, then the last kills. The spindles a K-descent can run (ρ₁₅, 8/3) land in 5-sealed fields. K-fabric
  grown to four-colour rigidity supplies its own wall-breaking angle (forced pairs at 8/3 spindle through
  √247). Over K the 6-open single radicals are the odd squarefree d ≡ 5, 7 (mod 8) that are non-residues
  mod 11 (7, 13, 79, 127, …). **This does not contradict G35's "≡ 7 (mod 8)"**, which is the test on the
  field's *square classes*, not on the radicand: 3 is already in K, so d ≡ 5 breaks the wall through the
  class 3d ≡ 7 (mod 8). Hence 13 joins 7, 79, 127. *Do: plan a descent as K-fabric grown to four-colour rigidity, then one
  wall-breaking adjunction into a 6-open field chosen by the two congruences, then the kills; expect ρ₁₅ and 8/3 to land
  5-sealed. Nothing kills the necessity; the sufficiency dies if fabric rigid at four colours supplies no wall-breaking
  angle.*
* **G38 — The linear method's thresholds. [hand theorem; Fischer's framework]** Colouring by cosets of a
  subgroup avoiding the reduced norm-one group gives 2, 3 or 4 colours and then nothing below 7. With
  conjugation in inertia the reduced group is {±1}, so ℚ(√N)² with N ≡ 5 (mod 8) is bipartite
  (`[Fischer1990]` Thm 8); ℚ(√3)² and ℚ(√7)² need 3; K² needs 4 (`[Fischer1994]`, an additive ℤ/4-colouring, 1994). Over a real multiquadratic field the two-colour case is exact: F² is 2-colourable iff no odd square class is ≡ 3 (mod 4) (hand; the mechanism is kernel, row 63), correcting `plans/FIELD-WALL-THEOREM.md` Prop. 6.4. The finite-plane bound sees 5 (G43); its
  usable primes are exactly those with residue field 𝔽_q, q ≡ 3 (mod 4). A 6-forcer's field is predicted by
  its construction (a spindle at forced distance d lands in F(√(4d² − 1))), not by linear arithmetic. **At three colours the obstruction is now all colourings** (row 82, G74): `1/3 ∈ ℤ[U_F]` and an odd cycle refuse every three-colouring, not only the additive ones, and at `d ≡ 3, 7 (mod 12)` the three-colourings are exactly the additive ones. *Do: decide two and
  three colours by the linear criterion before any plane — N ≡ 5 (mod 8) bipartite, an odd square class ≡ 3 (mod 4) forbids
  two, a usable prime with residue field 𝔽₃ caps at three (G43) — and above four use the finite planes, never linear
  arithmetic; predict a forcer's field from its spindle distance. Killing test: a multiquadratic plane two-colourable with
  an odd square class ≡ 3 (mod 4).*
* **G39 — Redundancy before rigidity. [kernel]** A forced-equal pair at χ(G) colours confines the critical
  set to the pair's common neighbourhood — in the plane at most two vertices, none beyond distance 2. So a
  6-forcer built as fabric plus a spindle at d > 2 needs fabric whose 5-chromaticity survives every vertex
  deletion, and every descent stage has an empty critical set. Necessary, not sufficient (G40). *Do: before asking whether a
  candidate forces a pair at d > 2, delete each vertex once and confirm the fabric keeps its χ — a critical vertex beyond
  distance 2 refutes the design without a solver. Nothing kills it; it kills every forcer at d > 2 on fabric with a
  critical vertex.*
* **G40 — Absorption. [kernel + measured]** A vertex set whose colourings all extend carries only its induced
  subgraph's compulsions — none when it has a spare colour. A spindle copy hangs by its fused centre plus one
  chord, so more spindles or centres cannot create a compulsion, and every K-coset piece is 4-colourable: a
  five-colour compulsion needs material thick in a wall-breaking field. Only the F₂₄₇ cross thickening has
  moved the redundancy dial (238 critical vertices freed, all copy-side — why only that side is open). *Do: before an arena
  is built, count how the copy is joined — a copy hanging by its centre plus few chords has a spare colour, absorbs, and
  predicts the null; a five-colour compulsion needs the copy joined thickly, or several copies, in a wall-breaking field.
  Nothing kills the kernel half; the "thick" reading dies if a thinly joined wall-broken copy carries a compulsion.*
* **G41 — Additive colourings bound compulsions from one side. [kernel + measured]** An additive colouring
  (φ : Λ → G, nonzero on edges) is proper, so the pairs all such φ identify contain the forced ones; since
  exp(G)·Λ ⊆ ker φ, no additive four-colouring separates a pair of 2-adic depth ≥ 2 on any object
  (`addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`; Fischer's k·G = 0 obstruction at the exponent). The
  valuation law is its exponent-2 member; **`[Fischer1994]`'s ℤ/4-colouring of K² is the exponent-4 member on the whole plane**
  (read 2026-09-22): it gives the Moser vertex `P = ((5√3−√11)/12, (5+√33)/12)` the value 1, so it separates the distance-2 pair
  `(0, 2P)` that every residue colouring identifies — the two colourings are different, and both exist on de Grey's lattice (FS-70's
  screen: 12 homomorphisms to each group). His map is the 2-adic embedding in disguise [reading, tools]: with `√pq` read as its
  2-adic root the same functional colours every ℚ(√p,√q) with p ≡ 3, q ≡ 1, 3 (mod 8) sampled — the fields completing to ℚ₂(ζ₁₂)
  above 2 — so the ℤ/4 colouring is local at 2 at a finite tower level, and his mod-16/mod-32 family is where it can be written with
  `u = 1` (`tools/fischer1994_check.py`; killed by a unit vector there with `v = 0`). On the Exoo–Ismailescu seed this bound is the truth; K-fabric's
  16-pair residue sits at depth 3, beyond any additive four-colouring. *Do: compute the additive family first — exact and
  cheap — and read it one-sidedly: a pair some additive colouring separates is not forced, no solver needed; a pair none
  separates is not thereby forced (depth ≥ 2 is beyond them all). Nothing kills the kernel half; the seed's equality of
  colouring space and additive family dies with one non-additive colouring of it.*
* **G42 — Additive rigidity is closure, and the family dies before it closes. [kernel + measured]** Rigidity
  needs every two-colour Kempe subgraph of every admissible hom connected (gauge γ = Σ(components − 1)).
  Only Exoo–Ismailescu's G has γ = 0 **with its cheats** — the gauge is measured on the graph including its
  non-unit cheat edges, never on the unit-distance graph alone; K-unit parts are 4-colourable; wall-broken thickening can erase the
  family (W plus 63 F₂₄₇ points), while de Grey's half-spindle closure keeps it. Forcing does not need
  rigidity (the seed's 252-cheat subset forces with > 5,000 colourings). *Do: measure γ on the unit-distance graph and on
  the graph with its cheats and say which; expect every unit-distance object Kempe-open, so rigidity is not the route and
  forcing is. Killing test: a unit-distance object without cheats at γ = 0.*
* **G43 — The residue plane seals fields. [kernel over rings; field level gated as G35; prior art
  `[Moorhouse2010]`]** At a usable prime the residue map is a homomorphism into Γ_q, so
  χ(F²) ≤ χ(Γ_q) — non-linear, 5 at q = 11. Every field the descent used is 5-sealed. For F ⊇ K,
  6-open ⟺ wall broken ∧ 11 inert: K(√7), K(√13), K(√79), K(√127) are 6-open; K(√35) is
  11-inert but keeps the wall. **De Grey's field IS 6-open, and so is K(√5,√7,√247)** — his coordinates span
  K(√5,√7) (ℚ-span rank **16 of 16** over `tools/degrey_cert.json`; √7 enters by the rotations through
  π/2 ± arcsin(1/8)); Frobenius at 11 is trivial on √5 and nontrivial on √7, so the residue field is 𝔽₁₂₁ and
  **no prime below 131 is usable** (`tools/fplane.py`, `data/fplane/map.md`, since M58). **Row 52 is about the
  proper subfield K(√5)**, never about de Grey's field. The 5-sealed witnesses are Heule-510/553 —
  ℚ-span rank **8**, K(√5), no √7 — where row 52's bound is exactly tight against
  `chromaticNumber_heule510` = 5. Moorhouse §9's bar on a composite ideal beating the best prime rests on
  Hedetniemi's conjecture, which `[Shitov2019]` refuted, so it is not a bar (FS-42) — but the *fractional* chromatic number
  of a categorical product is the minimum of its factors' (`[Zhu2011]`; for vertex-transitive factors the independence
  ratio is the maximum, `[Zhang2012]`), so a composite ideal beats its best prime only through an **integrality gap**
  χ_f ≤ k < χ in some factor (outside review, 2026-09-16). The shadow sieve: an object's direction residues seal every graph built from
  those directions. *Do: at the opening of any milestone over a field, run the sieve (`tools/fplane.py`) — its primes with
  residue field 𝔽_q, q ≡ 3 (mod 4), checking the residue DEGREE, since a larger field can lose a prime its subfield had — and
  read the smallest usable plane's χ as the ceiling and the free null. Nothing kills the ring-level theorem; the field-level
  step is G35's gate.*
* **G44 — Kloosterman control. [derived + measured; ω facts prior art]** Γ_p has eigenvalues
  −K(1, c/4), so Weil and Hoffman force χ > 5 from p = 59 and χ > 6 from p = 103 (exact spectra; 71 as well), and at 83 six is
  refused by the exact certificate (row 68) — the window between is G56's: small planes are SAT questions,
  large ones theorems, and over K the sieve is the single prime 11. ω = 3 iff char 3 or 3 is a square, else 2
  (`[Krebs2022]`); ω ≠ χ above p = 3 (`[SchneiderSilva2013]`). Open: the size of χ − ω (`[Krebs2022]`'s χ > ω result, his Prop. 6.1, is weaker than what we hold); χ(𝔽₁₇²) ∈ {5, 6, 7}.
  *Do: at any new prime compute the spectrum first — seconds — and let Hoffman's floor say whether the plane is a SAT
  question or a theorem before any solver runs; from 59 five is refused for free, from 103 six; at four colours a field's stable place from 37 up has `|λ_min|/d ≤ 2√p/(p+1) < 1/3` and needs no certificate (row 112). Nothing kills an exact
  spectrum; the open items stay open.*
* **G45 — A residue configuration lifts only if it is a shadow. [kernel + derived]** Modulo p² a finite-plane
  subgraph lifts iff its defect pairs to zero with every self-stress; a 6-critical subgraph carries
  ≥ \|V\|/2 + 3 such conditions, and a rigid framework's lift is unique and algebraic. A field's sealing prime
  is never its lifting prime (11 ramifies in ℚ(√11)). Designing in a finite plane and lifting is closed; the
  plane remains a filter and an enumerator (the hub scan). *Do: use a finite plane as a filter and an enumerator, never as a
  design bed to lift from; when a residue configuration is offered as a shadow, check the stress pairing first. Nothing
  kills it; it kills design-and-lift.*
* **G46 — Recognize the classical theory first. [method]** Name the object in the vocabulary of the theory it
  already belongs to (Cayley graphs → character sums; frameworks → rigidity) and let that theory decide the
  question's shape before any search; the search then produces predicted instances, and the controls correct
  scope. Rank stubs accordingly: a finite exact computation plus a named theorem beats an object search; a
  stub with no recognition yet is a reading room; and read a search's failure as information about the search's genre, not
  about the objects. The recognition sentence is the prior-art query (G49).
  **And read the construction's own data layout, not only the plan's vocabulary for it** (2026-09-12): the result that
  closed M63's rotation screen came from four lines of `Arena.__init__` — the rotated half carries the same index set and
  internal edge list as the original — a mathematical fact the plan's vocabulary had no word for. When a plan and an
  implementation describe the same object, the implementation is the one that cannot round off. More instances: `plans/GROKKING-INSTANCES.md` §G46. *Do: when a new object or question appears — at a milestone's opening, or with a new prime, ring or construction — name it in the
  words of the theory it already belongs to and let that theory say possible, impossible or where before any search runs; use that
  recognition sentence as the prior-art query (G49); read the implementation's data layout as well as the plan's words for it; rank a
  stub that reduces to an exact finite computation and a named theorem above one that hunts for an object, and hold a stub
  with no recognition as a reading room; read a failed search as news about the search's genre. Killing test: a frontier milestone
  whose object search delivers what no recognition predicted — then the ranking is wrong for that genre.*
* **G47 — The compulsion face of sealing, at level one. [kernel; subsumed by row 66]** Compulsions map forward along
  homomorphisms; on a Cayley graph a forced pair needs a period of every colouring. The distance law this entry
  carried (row 55) is the level-one shadow of the fan-gap theorem (row 66), which frees every pair at every distance over
  such a field, so the residue-allowed distances name nothing. Unchanged: no finite plane at p ≡ 3 (mod 4) has a
  forced pair at a colour count it admits (row 60), and at 11 its virtual edges are exactly its edges (kernel;
  measured at 3, 7, 19; prime fields only). *Do: over any field where 11 is usable, expect five-colour `Forces ↔ =` and
  `Separated ↔ Adj` without asking, and ask for no residue-allowed distance list. Nothing kills it; it kills FS-16's kind
  of list.*
* **G48 — The tightness mechanism, and the six-level question answered no over sealed fields. [kernel]** Over a field
  sealed at k by a usable prime 𝔭 whose plane is k-colourable, a pair forced equal at k colours has 𝔭 ∣ d², its
  spindle adjoins √(4d² − 1) ≡ √−1 (mod 𝔭), and every prime above p stops being usable: the forcer deletes
  exactly the local bound it beats (the Moser spindle's √11 removes 3; √15 and √247 remove 2). So the six-level
  was one question — does a 5-sealed field carry a pair forced equal at five colours, necessarily at 11 ∣ d²? —
  **answered NO by row 66** over every 5-sealed multiquadratic field ⊇ K (11 usable of residue degree
  one there, and slack): the only pairs forced equal at five colours are single vertices, so
  the mechanism has **no instance**, FS-6 is dead by theorem, and a 6-forcer's every compulsion lives in a 6-open
  field, where no residue plane is five-colourable and this mechanism is silent. The spindle identity stands as
  the reason 6-openness is forced on any 6-forcer, not as a route to one. The first digit (is any finite plane
  exactly 6-chromatic) is decoupled and integrality-carried. **The conjecture the mechanism was minted to serve**
  (FS-15): *χ(F²) equals its best local bound wherever that bound is ≤ 6* — attained wherever χ is
  known — whose **bold form is χ(ℝ²) = 7**. It **loses its constructive route** (a forced pair spindled into
  6-openness) and keeps its predictions: Γ₈₃ is not six-colourable (row 68), so under it **χ(K(√7)²) = 7**
  — the boldest prediction, pinned to the field the ρ₆₃ arena was built in — and de Grey's field, all of whose usable primes have spectral floor ≥ 8, is 7 outright (FS-40, closed with FS-50).
  **Proved range:** L ≤ 5 over every real number field (rows 99, 123; `L = 5` given MR, row 120); given MR, where every stable place of a totally real field is 6-thick the conjecture's value is the plane's own, `χ(F²) = χ(ℝ²)` (row 128), so its bold form at de Grey's field or ℚ(√635087) (`L ≥ 7`) is Hadwiger–Nelson itself; L(F) is the sharp form — the residue graph's chromatic number, 2 at ℚ(√5) where |κ| reads 4. *Do:
  state every milestone's target as a value of L(F) and say whether F sits inside the proved range; outside it (now `L ≥ 6`) the
  milestone is a test of the conjecture, so register its outcome as a prediction before the first solver runs. Falsifiers:
  a field with χ(F²) < min(7, L(F)) — ℚ(√11)² and ℚ(√23)², the cheapest, now meet their value (row 73); the `L = 5` fields are met (rows 121, 123), so the next is ℚ(√167) at L ≥ 6 (FS-59) — each falsified only by a whole-plane colouring, and at `k ≤ 5` by no character (G77),
  never by a finite refusal, which confirms; a wall-broken, 5-sealed field whose plane is 4-colourable by a colouring local at no prime (none at `L = 5` through MR, row 123); for
  the six-question, a 5-colourable, 5-tight Cayley quotient of a 6-open plane (FS-42).*
* **G49 — The prior-art gate. [method, measured]** Recognition is half the rule; the other half is a search
  at the milestone's opening (WORKFLOW step 3.2): in the discipline's words, never ours; under two disciplines;
  for the question as well as the method; outside arXiv. Past misses came from checking at the close,
  searching coined vocabulary, and searching one literature when the object sat in two. The check ran at the close, where it
  can only assign credit; run at the opening it changes what the milestone is *for*. Searching either literature alone finds
  nothing — which is also the honest explanation of why four milestones of reconstruction felt like discovery: *the gap was
  real, and it was a gap between literatures, not in them.* The field-plane
  reduction was derived independently at least six times, and the Polymath16 corpus (2018–2026) poses
  Theorem B's question while citing Fischer, Moorhouse and Vinh zero times — **and Theorem B's value was in print in 1994**
  (`[Fischer1994]`, read and verified 2026-09-22): a seven-page proceedings paper titled in the discipline's word for our
  object (*planar geometric graph*), in no citation database, found only by listing its author's works (WORKFLOW 3.2 item 8). **And the two-database cross-check has a
  failure mode that looks exactly like agreement** (2026-09-12): two citation databases both returned **zero** citing
  works for the survey that would have settled whether our object was known — both carried the same upstream
  identifier and both were the *preprint*, while one held the **published** chapter separately, with four citing
  works. **A zero from two databases sharing a source is one database's zero**: compare identifiers and versions,
  not counts, and open the citing lists; run that way it surfaced a 2007 paper counting sums of two squares over a
  **real quadratic** base. **And the audit's own gate, run on 254 theorems (FS-71):** six re-attributions, all in held papers read
  for a different question — a shell-counting formula in the quasicrystal literature (`[BaakeGrimm2003]`), a two-colour criterion
  in `[Fischer1990]` Thm 1's general form, odd-degree bipartiteness in `[Moorhouse2010]` §7.1; and one citation whose yearless key
  the bibliography audit could not see pointed at the wrong paper for six days. **And a held blog text, not re-read (FS-73's close):**
  the archived Polymath16 threads, read thirteen days earlier for who first stated the 2-adic law, held Hubai's 2018 count of the Moser
  ring's four-colourings — 9,120, 380 with a triangle fixed, all 8-periodic, row 78's headline in ring form, which our census then
  confirmed independently — and Parts's 2021 forced pair at 8/9; no zbMATH or citation search reaches a blog comment. More instances: `plans/GROKKING-INSTANCES.md` §G49. **Row 88's close:** zbMATH's `ab:` field cannot hit a record whose summary is withheld (BMK 2017, `[ChenDai2017]`), so run `ti:`, `au:` and all-field queries beside it. *Do: at every
  close, run the gate on the theorems filed, in the words of the discipline each belongs to; a held paper is prior art for questions it
  was not read for — and grep the held Polymath16 threads for every milestone's headline object, in the discipline's words ("ring",
  "periodic", "colourings of `R₂`") and by its own numbers, before calling it new. Falsifier: three milestones running whose
  gate changes nothing about their scope — then the cost is not buying anything and the gate should be a close-time check after
  all.*
* **G50 — Read what the search found. [method]** A held-but-unread paper, or a bibliography title whose guess
  touches a live milestone, blocks that milestone's opening until scanned. **The more expensive misses were not unsearched —
  they were unread, sitting in our own bibliography under notes that had already guessed right.** **So the sequence that
  actually happened is: search → record → rank → forget.** A title with a guess attached is not knowledge; it is a debt, and it
  accrues interest at exactly the rate the project does work in that area — and **the cost of the scan is not the reason it
  keeps being skipped — the reason is that a title with a guess attached reads like knowledge.** An abstract is not a reading. Walk
  the citation graph of the paper that *posed* the question; cross-check citations in two databases; mine
  every read paper's references into the bibliography the same day; mark reading per section. **FS-100's:** EL2021 and `[Wang2012]`, in `BIBLIOGRAPHY.md` since the day before under a journal-year key, were written "none held" in the milestone's stub, carried so into the advisor's card, re-fetched, and one read by its summary. EL2021 was fetched a third time, its path wrong in four briefs; its §2 was read at FS-100 and holds no PE-2, and the proof of its Thm 1.2 is in neither paper cited for it (FS-105). More instances: `plans/GROKKING-INSTANCES.md` §G50. *Do: grep `BIBLIOGRAPHY.md` for a paper's arXiv id and Zbl number before fetching it or calling it unheld; scan, at the opening
  and before the derivation, every held-but-unread paper whose title touches the milestone. Killing test: three consecutive
  gates whose blocking papers, read, changed nothing.*
* **G52 — Breaking the wall is necessary and visibly not sufficient; the equal-radius family is the mechanism. [hand for the
  necessary half — the σ-criterion, M63G-T4/T5 in `plans/M63G-derivation.md`; measured + reading for sufficiency, one instance with a positive control]** A wall-breaking rotation can still be four-colourable: breaking the wall is a
  property of the field the rotated copy lives in, while the residue colouring reads the base points, which never leave the
  original field. The rotation escapes the colouring only through one family — cross edges joining two base points the colouring
  gives the same colour, which requires the base to realise a specific radius sum, via `d² = σ − (σ−1)/cos θ`. Measured on M63
  phase G's rotation: it breaks the wall and dies because `[Parts2020a]`'s lattice cannot realise the live radius sum (no
  solution, against 30 at his own angle) — a fact about that lattice, not that angle. Inverted, a design target: the cosine
  names the live radius sums before any base exists; one free prime kills. Necessary is proved; sufficient is untested, the
  record's rotation the only positive instance. **The apparent filter is free where the circle is free**: with the circle `t ×`
  the unit shell for an integer `t`, the certificate's defeat is automatic for even `t` (`φ` lands in a characteristic-2 residue
  field, so every circle point carries the centre's residue, and the shared centre pins the colour twist that might have repaired it (measured: **0 of 24** twists at either prime)), and the record has `t = 2`; so "this object defeats the residue
  certificate" is not evidence about the object, and the live quantity is the **off-diagonal** share of monochromatic cross
  edges (the record 0 of 30, `ρ₆₃` 24 of 54). `|p|² = n` is free — nonempty by scaling alone — whenever `n = k²·m` with `m` a squared distance the lattice already
  realises (4, 16, 12 free; 2 not); the converse fails (`n = 5` has 60 points and no such decomposition — M63H2-T2's own correction record; FS-71, batch 4c). *Do: for every in-field rotation compute the live radius sums from its cosine before any
  base exists — a free prime filter — and measure the off-diagonal monochromatic share under the base's colourings, never
  the diagonal, which is free where the circle is free. Killing test: a rotation whose base realises the live radius sum and
  stays four-colourable (sufficiency, untested), or a wall-breaking rotation forcing with no monochromatic cross pair.*
* **G53 — The counting compulsion, and the refutation criterion it defines. [derived; one provisional measurement]** For a
  type-M arena — base `B` plus its rotated copy sharing the centre, joined by cross edges — any proper `k`-colouring `C` yields two
  proper `k`-colourings of `B` alone, `f(v) = C(v)` and `g(v) = C(Rv)` (G46). The shared centre forces `f(0) = g(0)` and each
  **diagonal** cross edge forces `f(v) ≠ g(v)`, so with `B(h) = {circle v : h(v) = h(0)}` the sets `B(f)`, `B(g)` are disjoint,
  and with `L = min_h |B(h)|` over proper `k`-colourings of the base, **`2L > (circle count)` ⟹ the arena is not `k`-colourable**
  — a property of the base alone, no arena solve; sufficient, never necessary. A **counting** compulsion, a shape the vocabulary
  lacked — "at least `L` of these `n` points share one designated point's colour" — with a forced pair as `L = count`; it explains
  why both fail on `ρ₆₃`, where `L/count = 10/30` (provisional) and no circle point is forced. **The design target — maximise
  `L / (circle count)`, refute above `1/2` — is the first objective in M63 phase H2 that a free construction cannot supply**, the
  circle count and the residue certificate's defeat both being free (G52). *Do: compute `L` on the base alone before any
  arena solve and refuse above `1/2`; below it the screen says nothing. Nothing kills the derivation; the provisional
  `10/30` dies with a recount.*
* **G54 — Tight or slack: one sign says where a residue plane must force; slack only permits gaps. [kernel one
  way; hand the other (FS38-D2-A/B, `plans/FS38-derivation.md`); the table computed]** Let `P` be the level-one plane at a usable prime, `d` its degree,
  `λ_min` its least eigenvalue, `k` the colour count. **Slack** (`λ_min < −d/(k−1)`; Hoffman's α-bound exceeds
  n/k): gaps are permitted, and where one exists — found at 7, 11, 19; 23 and 83 slack by the spectrum with no
  colouring asked — **gap ⟹ free** is kernel (row 66). **Tight** (`λ_min = −d/(k−1)`, the literature's Hoffman
  colorability): every k-colouring is balanced, gap-free and periodic under the common kernel of the minimising
  characters, so **tight ⟹ forced by `H_min` ∧ gap-free** is derived (Theorem D2-A; balance and gap-freedom are
  Blokhuis–Brouwer–Haemers's, the periodicity ours). **The middle case — slack but gap-free — is observed** (row 87):
  `Cay(Λ/16Λ, U)` is slack at four colours (`λ_min = −18.883 < −18`), yet every four-colouring pulls back from the tight `Λ/8Λ`
  (54 generators onto 36, unequal fibres), so all are gap-free and it forces; at 11 no 5-colouring has every vertex gapped, on two
  engines. *Demotion record:* as minted this entry said the sign classifies a plane's compulsions and read slack as free; slackness
  permits gaps and does not supply one. **Slackness propagates up a tower** whose level maps carry `S_{m+1}` onto `S_m` with constant fibres (`λ_min/d` is non-increasing under pullback), which is why the 11-adic tower is slack at every level; **tightness does not** (row 93: `Λ₅₁₀`'s quotients, constant fibres, are tight at 14 and slack at 24) — the 2-adic tower is tight at every level by FS38-L2's non-strict half, as is every unramified quadratic dyadic tower containing `√3` (row 93). *Demotion record:* this sentence said both properties propagate, from FS38-L1, whose tightness half has a wrong-direction step (FS-86's B2); the slack towers at 7–23 do not drop either, by certificate, not by the spectrum (row 75). **In an inert tower the ratio is exactly
  constant** (GPT Astra, 2026-09-16, hand; recomputed at 3, 7, 11, 19, 23, 27 and 2 by `tools/fs54_wall_feedback_verify.py`;
  for odd prime Q immediate from `[MMST1998]` Thms 2.1, 2.3, 2.9, new for Galois rings and even Q):
  λ_min(G_j) = Q^{j−1}·λ_min(G₁) with degree Q^{j−1}(Q+1), so every Hoffman floor survives every level. **Tight can be rigid
  and still force nothing** (same review, recomputed): at U₃₂ = Cay(𝔽₁₀₂₄, μ₃₃), k = 4, the least eigenspace is exactly
  μ₃₃, the unit circle is a Sidon set, so a maximum independent set's Fourier support is {0, a, b, a+b} and **every maximum
  independent set is an 𝔽₄-hyperplane** — eleven four-colourings, with trivial common kernel. The table: tight at 3 (k = 3;
  the rhombus forces, row 58) and at 2 (k = 4; forced from level 5, row 67); slack at 7 (k = 4) and at 11, 19, 23
  (k = 5) and 83 (k = 6); by Weil, tightness at k needs `(p+1)/(k−1) ≤ 2√p`, so no usable prime above 3 in the
  committed table is tight for any k ≤ 7 (p = 31 misses 4-tightness by 4.4·10⁻⁵ in the normalisation `9(λ_min + d/3)/d`: `λ_min + d/3 = 1.5617·10⁻⁴`, ratio `1/4 − 2.745·10⁻⁶`). **At four colours no stable place has an integrality gap** (row 123): a stable place's target is four-colourable iff its all-levels ratio is `≥ 1/4` — only `𝔽₃`, `𝔽₇`, dyadic inert `Q ≤ 32` and dyadic ramified — so slack everywhere and `L ≥ 5` are one condition. **In a product, Hoffman-tight pulls back where the other factor mixes** (FS-67, rows 114–115): every colouring of a Hoffman-tight plane is gap-free — a fall colouring, which Csernák calls "tight", another sense of the word — and a gap-free `G` pulls back against every abelian Cayley `H` with `λ* < 1/(k−1)`, sharp at `K_k`; gap-freedom alone fails against some `H` from four colours up (`K_k × X`, `X` from a Hedetniemi pair), and whether Hoffman-tightness suffices is open — check the other factor's `λ*` before calling a product colouring local. **What it says about six:** the
  residue mechanism forces pairs where the plane is tight or pulls back from a tight quotient, and no plane that seals a field at five does (each has a gap, row 66) — so the
  only residue route left to a five-colour forced pair is a **quotient** of a 6-open plane that is 5-colourable and
  5-tight (FS-42, a reading with its falsifier). *Do: when you meet a new prime, ring or quotient, compute the sign of
  `λ_min + d/(k−1)` at the colour count FIRST — a character sum, seconds per (field, k). Tight: expect every k-colouring
  balanced, gap-free and periodic under `H_min`, and forced pairs at some depth of its tower (row 67's mechanism) — go find
  the depth. Slack: find one gapped colouring, and with it the freedom of every pair above it (row 66) — then ask no solver for forced pairs on that plane's fabric; with none found, check whether its colourings pull back from a tight quotient (`Λ/16Λ` → `Λ/8Λ`, row 87) before calling it free. Positive: the ratio bound refuses `k` colours outright and the plane is no `k`-target at all (Γ₂₃ at four, by 0.039; FS81-T25) — a registration that names only tight and slack has missed a reachable outcome. Neither is a substitute for FS-17's ask. Killing test: a k-colouring of a tight
  plane that is unbalanced or gapped; of the reading that the middle case comes from a tight quotient, a slack plane whose k-colourings are all gap-free and pull back from none (the middle case itself fired at row 87).* *Reading (FS-73's implementer B, restated at the close):*
  a full-rank forced group appears where a lattice is integral at a prime whose target is Hoffman-tight at `k` and no other prime's
  quotient has a gap — K at 2 with four colours (`F = 8Λ`, row 78), ℚ(√11)'s `Λ₁₀` at 3 with three (`F = 3Λ`, row 79). At ℚ(√11)
  the prime above 3 is split in `ℚ(√11, i)`, not conjugation-fixed (Poros), and `Θ₃` explains that instance (G71); the K instance
  is explained since row 85 (G75): triangles supply the period, the tight dyadic quotient kills the 5-part. Killing test: a lattice integral at a tight prime, with no gapped
  quotient, whose `F` is not of full rank.
* **G55 — The unit-vector ring decides the walls, and the chain replaces the spindle. [hand, GPT Astra (OpenAI,
  2026-09-14, in conversation with Kooshi); read here and found sound; the identities verified twice in exact arithmetic —
  `reference/ChatGPT-local-global-tightness-conjecture/VERIFICATION.md`; every result below is a kernel target, FS-45–48 (Kooshi, 2026-09-14)]** Of these kernel targets, in the kernel since M2: the chain theorem and its ring form (`1/δ ∈ ℤ[U_F]`), prime inversion in valuation form, the ℚ(√2,√3) lower bound and the `K(√7)` implication (rows 103, 105); the rest named at M2's close remain targets — prime inversion's number-field reading (row 57's gap), `G4`'s certificate, `χ(ℚ(√2,√3)²) ≤ 4`, the vertex bound `m(n − 1) + 1`, the two-colour classification. Let R = ℤ[U] be the ring the unit vectors of F(i)
  generate (M56's Σ₀). **Prime inversion:** 1/p ∈ R iff no conjugation-stable prime of F(i) lies above p (by lying-over) — M56 L7's conjecture, proved in general; and R = O′, integral at the stable primes, with no Galois hypothesis off a ramified stable dyadic place (row 100); **prior art for multiquadratic F at odd unramified p and for every prime of a real quadratic F**: `[Fischer1990b]` Thms 1, 3, 4 (1989), whose Σ₀ is this R, so M56 reconstructed a published theorem; so "the 2-adic wall is
  broken" is "1/2 ∈ R". **The chain theorem:** a finite graph over F forcing two points at difference δ equal at k colours makes
  every k-colouring of F² periodic under the ideal δR (transport by every isometry z ↦ t + u(z − a)); if 1/δ = u₁ + ⋯ + u_m is a
  sum of unit vectors, 1 is a period and χ(F²) > k, witnessed by m chained copies plus one closing edge, at most m(n − 1) + 1
  vertices, **in F itself** — the spindle is m = 2, which is why its threshold is d ≥ 1/2 and its field F(√(4d² − 1)) (row 44).
  **Consequences.** χ(F²) = 2 ⟺ L(F) = 2 for every real number field (walk parity is a ring homomorphism R → 𝔽₂). For √3 ∈ F: χ(F²) = 3 ⟺ some prime has residue field 𝔽₃ ⟺ L(F) = 3
  (every three-colouring is 3R-periodic by the rhombus and descends to Cay(R/3R, H), which contains the product of the planes
  at the stable primes above 3; `[ElZaharSauer1985]` and the Weil floor leave q = 3), so the conjecture holds for L ≤ 4 there; **without √3 too** (row 99): a three-colouring's torsion part is a residue character at a stable prime of residue field 𝔽₃, so χ(F²) = L(F) at L ≤ 4 for every real number field (row 82 had the real quadratic case by `1/3`); the same argument cannot run at four colours — not at the product, since Hedetniemi fails from four up (`[Tardif2023]`, `[Zhu2025]`) but
  never among residue targets (each needing five has `χ_f > 4`; `[Zhang2012]`; `plans/PA-tardif2023.md` §5), but at the descent: nothing gives four-colourings an ideal period; five came by measure rigidity instead (row 123). Given the 8/3 forcer over K — **prior art: Jannis Harder, Polymath16 first thread, 28 April 2018** (*"V + V + H … forces the point (8/3, 0) to have the same color as the origin"*, 745 vertices, spindled at arccos(119/128) into K(√247); `[Polymath2021]`'s strip forcer is the same pair on `ζ₆^m ρ^n`-fabric; M53–M56's 588-vertex core, one solver refusal, is a smaller rediscovery — found by FS-70's gate, 2026-09-21): every wall-broken real F ⊇ K has χ(F²) ≥ 5 (3/8 = 3·(1/2)³ ∈ R) — wall-broken is
  *sufficient* for five over K where G35 had it necessary — and every multiquadratic F ⊇ K with L ≤ 5 has χ(F²) = L(F); over
  K(√7), w = (−3 + i√7)/4 has w³ + w̄³ − 3w² − 3w̄² = 3/8, so eight copies plus an edge, at most 4,697 vertices, need five colours
  by hand, against the ρ₆₃ arena's 51,133 by solver (FS-45 puts it in the kernel). An 18-vertex, 33-edge graph over ℚ(√2,√3)
  (six chained rhombi) is four-chromatic with no Moser spindle in its field, and χ(ℚ(√2,√3)²) = 4. **On six:** one five-colour
  virtual edge at distance 2 over any F ⊇ K is a six-chromatic unit-distance graph (the sentence is the advisor's; M49–M50
  replaced those edges one at a time; the host and the consumer are G26); its field must be 6-open (row 66), and the arena
  has no such pair. What the chain cannot do is
  produce the five-forcer it needs. **Over K a second four-colour forced pair is known, at `8/9 = −(v + v̄)`** (Parts, Polymath16, 2021, who spindled it too; row 78): `9/8 ∉ ℤ[U]`
  over K, so no chain contradicts χ(K²) = 4, but its spindle lands straight in the 6-open K(√7), since `4(8/9)² − 1 = 175/81 =
  (5√7/9)²`. *Do: for a pair forced at δ, look for 1/δ as a sum of unit vectors before adjoining any
  radical — the closer stays in F, at most m(n − 1) + 1 vertices. Killing test: chained copies of a forced pair with 1/δ ∈ R
  that are k-colourable (a defect in the proof); or the 8/3 forcer's one solver refusal failing to replicate, on which the chain's route to the
  five-colour consequences over K rests (row 123 reaches them through MR).*
* **G56 — The window for six, and reciprocity's exclusion of it. [derived: exact spectra and the 83 certificate; the
  exclusion is elementary and script-verified; the consequence for χ(ℝ²) rides on the conjecture's bold form and on FS-39's
  bridge, which is `[Madore2015]` ¶5.4 plus de Bruijn–Erdős]** Six colours on Γ_q need an independent set of ⌈q²/6⌉, which the
  ratio bound permits only while 5|λ_min| ≥ q + 1: by Weil that fails from q = 98, the exact spectrum already fails it at 71, and
  83 — the last prime where six was spectrally possible — refuses it by certificate (row 68), as do 59, 67 and 79 (FS-53 phase B,
  row 69). Five is refused from 59 up. So over the residue fields a number field can have, **a plane with χ exactly 6 can live only
  at q ∈ {23, 27, 31, 43, 47}**, with floors 6, 6, 5, 6, 6 (five refused by certificate everywhere but 31: rows 69–71; at 27 row 70's `α(Γ₂₇) ≤ 141 < 146`) and none
  decided (ceilings and searches: row 69). **The exclusion.** A prime is usable for a
  field only if the field's radicands are all squares in its residue field, and **every field this project has built in contains
  K**: 3 is a non-square modulo 31, 43, 67, 79 and 11 modulo 23, 47, 59, 71, and at 27 the residue 11 ≡ −1 (mod 3) is a non-square
  in every 𝔽_q with q ≡ 3 (mod 4); so such a field's usable primes are 11 and then nothing below 83, its local bound is 5 or ≥ 7,
  and **six is arithmetically excluded for all of them**. A six-chromatic number field, if one exists, contains no √11 and none of
  the known five-forcers; every field with local bound ≥ 6 needs five through MR (row 123, [hand]). **Each member has its field named**
  (`data/fs54/fields.out`, `data/fs54/quadratic-fields.out` — complete enumerations by PARI's `nflist`, FS-54): the smallest field
  whose FIRST usable plane is that member **and whose 2-adic wall is broken**, the second condition being what makes a local bound
  of 6 worth anything, since a wall-standing field is four-colourable by the residue at 2. **The primes above 2 decide which
  fields count, and there are only three cases**: a prime of F above 2 that **splits** in F(i) gives no bound; one **ramified** in
  F(i)/F gives **χ(F²) ≤ 2** whatever its norm (conjugation acts trivially on the residue field, so every unit vector reduces to 1
  and a linear map to 𝔽₂ sending 1 to 1 two-colours the plane); one **inert** gives U_Q, Q = N(𝔭), which is **4-colourable at
  Q = 2, 4, 8, 16, 32** (CaDiCaL, FS-54; by an F₂-linear formula, X26B, and by no F₄-linear one at 4, 16) — and **at Q = 64 its Hoffman floor is 6** (λ_min = −15; a linear 8-colouring exists, so
  6 ≤ χ ≤ 8), so **U₆₄ is a sixth window member, in characteristic 2**, realised only by fields of degree ≥ 12; Q = 128 has floor 8
  (`data/fs54/char2/`). So "the wall is broken" means **every prime above 2 splits in F(i)**, i.e. −1 is a square in every
  completion above 2, and **every field of odd degree is 2-colourable** (some prime above 2 has odd local degree, so i is not in
  that completion and it ramifies; the reciprocity form is in G35) — **`[Moorhouse2010]` §7.1's theorem**, by the same residue
  mechanism (attributed by FS-71, batch 6b; FS54-T2). With that criterion the
  smallest fields are **23 → ℚ(√167), 31 → ℚ(√1055), 43 → ℚ(√4703), 47 → ℚ(√2351)** — every field of degree 3 or 4 with
  |disc| ≤ 20,000 fails at 2 — and **27 needs even degree ≥ 6** (a quadratic field cannot reach 𝔽₂₇, a quartic reaching it also has
  an 𝔽₃ plane, an odd-degree field is 2-colourable); the smallest found, among composita of a cubic with a quadratic field, is **the
  cubic of disc 316, x³ + 2x² − 3x − 2, joined with √79** (|disc| 31,554,496; usable planes below 100: 27, 43, 79).  **Real quadratic
  fields with local bound at least 6 exist, each decided by one to three planes**: with d ≤ 30,000 there are 44 whose wall is
  broken and whose usable planes avoid {3, 7, 11, 19, 31} (`data/fs54/quadratic-fields.out`, rerun 2026-09-17); every one has 23,
  43 or 47 usable, so its L is 6 exactly when a usable one of those is six-chromatic and ≥ 7 otherwise — the smallest are
  **ℚ(√167)** (23 or 43), ℚ(√1319) (23 or 47) and **ℚ(√2351)** (47 alone). **Five is refused at all three, so a six-colouring at
  23, 43 or 47 makes χ(ℚ(√167)²), χ(ℚ(√4703)²) or χ(ℚ(√2351)²) ≤ 6 a theorem: the first number field with local bound exactly 6.**
  **All three deciding planes are implausible on the measurements** (row 69's plateaus at 23 and 43 and the 99.4 % tightness six
  needs at 47; `data/fs53/CLOSE.md`) — nulls at a budget, not refusals, but they put these fields most likely at local bound ≥ 7. **And 27 is the unique non-prime member, permanently:** `q = p^f` is usable iff p ≡ 3 (mod 4) **and f is odd** — "odd residue
  degree" is the congruence restated; 25 fails twice, 49 on the degree alone, the mechanism that costs de Grey's field the prime 11
  — and of the non-prime prime powers below Weil's cap of 97 only 27 qualifies; the next, 243 and 343, are far beyond it, so the
  tooling's prime-only assumption costs exactly one member. **What the window decides is whether six
  is reachable by the residue method at all**, since χ(ℝ²) = sup_F χ(F²): no six-chromatic window plane ⟹ no field has local
  bound 6 ⟹ every field holding a six-chromatic unit-distance graph has all its usable planes at ≥ 7, so the finite planes can
  never pin six — and under the conjecture six is a value no field attains, though every seven-chromatic graph passes through it
  (χ(ℝ²) = 7 follows from the bold form at K(√7) alone, without the window; a field merely *containing* a six-chromatic graph may
  have χ(F²) = 7 = L, which is no local–global gap); one six-chromatic plane ⟹ a field with χ(F²) ≤ 6 by theorem, predicted 6
  (FS-53), a finite six-chromatic graph by compactness. The clique structure decides which field can see which member, and rules
  the Moser spindle out of every one of them (G57). Every window plane is slack at six — at 23, 27, 31, 43, 47, 67 by divisibility
  (Hoffman-tightness at k needs (k−1) | (q+1), and 5 ∤ q + 1), at 59 and 79 by the exact spectrum — so the tight mechanism, which
  forces pairs in every colouring, is not available there. *Demotion record: this sentence once continued "so over a field it seals the
  residue mechanism forces no pair"; slack only permits gaps (G54's middle case is open) — caught by an outside review,
  2026-09-16.* **The rounding reading:** on a vertex-transitive graph
  χ_f = q²/α, so χ ≥ ⌈q²/α⌉ is a theorem and only the equality **χ = ⌈q²/α⌉** is the reading (true at 3, 7, 11; consistent at 19;
  it replaces the "+1 over the spectral floor" reading, which fails at the Hoffman-tight q = 3). The fractional wall W_f, which
  proves the window empty with no reading at all, and what the conjecture makes of the window: G59. *Do: for any field, list
  its usable q first — six is possible only if one lies in {23, 27, 31, 43, 47}, or a prime above 2 is inert of norm 64, and
  the wall is broken; otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver, and over any F ⊇ K it is 5 or ≥ 7. An exception field of row 100 (a stable dyadic place ramified in `F(i)/F`) has `L = 2`: never scope a claim at `L ≥ 3` by that exception (row 123). Killing tests —
  of the exclusion: a usable window member for some field containing K (impossible by reciprocity); of the reading: a decided
  plane with χ ≠ ⌈q²/α⌉; of W_f: an independent set of ⌈Q²/6⌉ at an open member.*
* **G57 — The window is triangle-free where it is roomy, and no candidate field holds a Moser spindle. [derived;
  the clique rule is `[Krebs2022]`, verified here; the correspondence and its consequence are ours]** Three mutual unit
  distances force an equilateral triangle, whose apex is `(1/2, √3/2)`, so **`ω(unit-distance graph over F) = 3` iff
  `√3 ∈ F`**, and 2 otherwise (`[Krebs2022]` Lemma 5.1, any characteristic ≠ 2). Downstairs, Krebs: `ω(Γ_q) = 3` iff char 3 or 3
  is a square in `𝔽_q`. **One direction transfers**: `q` is usable for `F` only if every radicand of `F` is a square in `𝔽_q`, so
  **`√3 ∈ F` puts triangles in every usable plane, and a usable plane without triangles certifies `√3 ∉ F`.** *Demotion record:
  this entry first called the two conditions the same — "a field contains √3 exactly when its usable planes have triangles". The
  converse is false: ℚ has no √3 and its usable plane at 11 has triangles (3 = 5² mod 11); and in characteristic 3 every plane has
  them — at 27 the collinear triples `{z, z+u, z+2u}` (FS-54), present whatever the field. Every consequence below uses only the
  direction that holds.* Across the window: `ω = 3` at 23, 27 and 47 (3 a square, or char 3), `ω = 2` at **31 and 43**, which can
  therefore serve only fields *without* `√3`, whose own planes are **triangle-free**. And **no window member admits `√3` and `√11`
  together** (11 is a non-square at 23, 27, 47; 3 is a non-square at 31, 43 — 11 *is* a square at 43, so there the exclusion is
  driven by 3 alone), which is G56's reciprocity seen through the clique structure — and since the **Moser spindle needs both**
  (`√3` for its rhombi, `√11` for the twist `cos θ = 5/6`), **no field whose local bound could be 6 contains a Moser spindle.**
  Every forcer this project holds is assembled from spindles or their relatives, so G31's "a χ ≥ 6 gadget must be constructed,
  not found" acquires its sharp form: over a window field there is nothing to build *from*, and at 31 and 43 not even a triangle.
  **The tension this creates is the milestone's, in one line:** the member where our construction vocabulary could apply is **47**, which has almost no room — six
  needs `α ≥ 369` against the certified `α ≤ 371`, a three-integer window at 99.5 % of the ceiling — while the member with room is
  **43**, a fifty-seven-integer window at 84.7 % of the ceiling, in triangle-free territory where we have no vocabulary at all.
  *Do: read ω of a usable plane as a certificate — no triangles downstairs means `√3 ∉ F` — and over a window field look for
  no spindle to build from: the vocabulary must be Moser-free (G11's route). A five over a field without √3 answers Soifer 55.1's existence half (row 121). Killing test: a five- or six-forcer built over a
  field containing neither `√3` nor `√11`, which would show the vocabulary is not the binding constraint.*
* **G58 — The antipodal conjecture: an optimal colouring can always be taken symmetric under `z ↦ −z`. [reading,
  4 of 4 planes with a known χ, each verified from the definition; the fixed-colour half is derived]** **Conjecture:
  every Γ_q has an optimal colouring `c` with `c(−z) = τ(c(z))` for some **involution** `τ` of the colours. Verified where χ is
  known exactly: `q = 3` (χ = 3, `τ = (2,1)`), `q = 7` (4, `(2,1,1)`), `q = 11` (5, `(2,2,1)` and `(2,1,1,1)`), `q = 19` (5,
  `(2,2,1)`) — proper on every edge by an independent rebuild. **No simpler form survives**: at 19 the identity and every single
  transposition are refuted, so "invariant" without a colour involution is false. **Derived, not conjectured:** a rotation fixes
  the origin, so `c(0) = τ(c(0))` and **τ must fix a colour** — which refutes 73 of the 226 rows refused across seven equivariant
  sweeps (32 %) in one line, with no solver, and should be a filter in the tool rather than solver time. **Why it matters: it
  halves every colouring instance**, `(q² + 1)/2` orbits against `q²` vertices — 925 against 1,849 at 43, 145 against 289 at 17 —
  and the equivariant sweep's order-2 rows *are* that search. **Which relocates the open question**: at 11 and 19 the satisfiable
  rows are order 2 with `τ = (2,2,1)` or `(2,1,1,1)`, **exactly the rows left undecided** at 17 (k = 5) and 23, 43, 47 (k = 6). So
  the sweeps' zeros are not evidence of absence — they refused only the rows refused at 11 and 19 too, where a colouring
  demonstrably exists — and the effort belongs on those half-size instances rather than on a full cube-and-conquer. **Asked as a DECISION at 23 (k = 7, 8)
  and 43 (k = 8), it returned nothing**: every refusal was free (the fixed-colour argument; an edge joining some `z` to `−z`) and
  every row that could carry a colouring was undecided at 3,000,000 conflicts. G58 asserts EXISTENCE, so its instrument is a FINDER
  on the antipodal quotient, `(q²+1)/2` orbits, never a decider on the full plane. A decider is being asked to refute, which is the expensive direction and the wrong one for an existence claim (More instances: `plans/GROKKING-INSTANCES.md` §G58). **Prior art** (searched 2026-09-16 under graph
  theory and algebraic combinatorics, in their words): the frame is the Burnside chromatic polynomial of group-invariant graphs,
  and the abelian-Cayley colouring literature (`[GarciaMarcoKnauer2024]`, arXiv:2405.19543 — the key and id corrected by FS-71 batch 6a: 2303.06262 is `[CervantesKrebs2023]`) works on χ, not on invariance; **nothing
  found asserting or refuting this for any graph family** — the *distinguishing* chromatic number is the opposite question, and
  the failure of invariance under the FULL automorphism group says nothing about one involution up to a colour permutation.
  Bibliography keys owed. *Do: search with a FINDER on the antipodal quotient under a colour involution that fixes a colour;
  filter every equivariant row by the fixed-colour test before any solver time; never a decider on the full plane. Killing
  test: a plane with an optimal colouring but none antipodally invariant under any involution.*
* **G59 — The wall at six is finite and fractional, its escape hatches close to integrality gaps, and what it leaves is a
  quadratic prediction. [cert + proof (GPT Astra, verified by recomputation) + derived]** **Finite:** χ(U_Q) ≠ 6 is settled
  everywhere except Q ∈ {23, 27, 31, 43, 47, 64} (floors 6, 6, 5, 6, 6, 6). **Fractional (the wall W_f):** χ_f = Q²/α on these
  vertex-transitive graphs and χ ≥ ⌈χ_f⌉, so α(U_Q) < Q²/6 at the six (≤ 88, 121, 160, 308, 368, 682) proves the wall with no rounding
  reading; only 47 (0.76 % below its certificate) and U₆₄ (0.888 of Hoffman) are within reach of a priced relaxation (FS-57).
  **The normalization, and what a uniform bound DOES carry** (2026-09-18): with `c = α/q^{3/2}` the colour count is `≈ √q/c`, so
  six needs `c ≈ √q/6` — **a threshold that grows with q against a constant that looks flat**. Measured c: 0.756 (7), 0.767 (11),
  **0.918 (19)**, 0.789 (23), 0.834 (27), 0.846 (31), **0.915 (43)**, 0.822 (47) — exact at 7 and 11, bracketed at 19
  (76 or 77: 0.918–0.930), best-found elsewhere, hence lower bounds on the truth. Six needs c = 0.807, 0.870, 0.933, 1.096, 1.145
  at 23, 27, 31, 43, 47 and 1.334 at U₆₄, crossing the observed maximum 0.92 at **q ≈ 30.5**. So **one uniform theorem
  `α ≤ 0.93·q^{3/2}` closes 31, 43 AND 47** — three of the six, in place of three separate relaxations, **though it is the harder
  object, not the cheaper one**: against the exact ratio bound it must reach 0.668, 0.663 and 0.642 there, where the best reach
  ever measured is 0.797 (FS-62 §2a(4)) — leaving only **23 and 27**, plus U₆₄, whose characteristic-2 scaling is different
  (measured c = 1.0; its maximum sets are subspaces). No uniform bound can close 23: it needs c < 0.799 while 19 itself reaches
  0.918. **So the wall is not a law about the number six. It is one quantity being bounded, plus a two-vertex accident at 23**
  (best set 87, six needs 89; row 69) **and a five-vertex one at 27** (117 against 122): the colour count climbs like `√q`, so
  each value is reachable only in a narrow band of q, and six's band falls in the gap between the last comfortably-five member
  and the first comfortably-seven one. *Reading — c is bounded by ≈ 0.93 over odd q. **The killing test at 19 — a set of 78 — is
  closed from the refusing side** (FS-66: the exact all-levels certificate `data/fs66/b1/cert-p19.json` gives `α(Γ₁₉) ≤ 77`, so
  `α(19) ∈ {76, 77}` and `c(19) ≤ 0.930`), where SAT's frontier sat thirty above the answer (`k = 110` refutes in 383 s,
  `k = 105` not in 900) and the level-3 relaxation read 80.59 with the fixed-cardinality moment equations adding nothing (FS-62
  §2a, `data/fs62/q19/`). **The one left is an independent set of 263 at q = 43**, which gives c ≥ 0.933 and kills the uniform
  route to 31; at 19 the margin is gone — `0.93·19^{3/2} = 77.02` against a possible 77. Caveat, G21: every c above 19 is a found
  set, so the flatness may be measuring search effort. A symmetry break is an encoding and is measured, never argued: at 19 both
  exact normalisations of the 361 translations were slower than the weak origin pin and slower than no break at all.* **Escape hatches:** χ_f of a categorical product is its factors' minimum (`[Zhu2011]`, `[Zhang2012]`), so
  W_f also rules six out for every CRT product of first-level targets, and a composite target is six-chromatic only through a
  factor with χ_f ≤ 6 < χ; inert towers keep the Hoffman ratio (G54); so a six-chromatic target of any ideal has a factor of
  residue size in {23, 27, 31, 43, 47, 59, 64, 67, 79, 83} at some tower level. **Rigidity where Hoffman is tight:** U₃₂ at k = 4
  (G54); at 64 Hoffman is slack, but a 683-set must carry ≥ 50.2 % of its Fourier energy on the least eigenspace — a stability
  route's first step. **What the conjecture makes of it:** if the wall holds, the main clause (held through five, row 123) says nothing above five — χ(F²) =
  L(F) is then a finite rule read off the conjugation-fixed primes with residue 𝔽₃ (3), 𝔽₇ (4), 𝔽₁₁ or 𝔽₁₉ (5), or dyadic,
  ramified (2) or inert of norm ≤ 32 (4) — and the bold form makes every other field 7: χ(F²) ∈ {2, 3, 4, 5, 7}, and every
  six-chromatic unit-distance graph extends to a seven-chromatic one over its own field. The sharpest instance is **ℚ(√167)**, the
  smallest-discriminant real field with no such prime (usable planes 23, 43, 59, …): five being refused at 23 (FS-56), the
  conjecture predicts χ(ℚ(√167)²) ≥ 6 whichever way the wall goes (6 by the main clause, 7 by the bold form), against a proven 5 (row 123, [hand]; 4 in the kernel, row 119),
  in a field with no √3 and no triangles. *Do: at any window member aim at α < Q²/6 — the fractional wall needs no rounding —
  and report c = α/q^{3/2} beside every found set, marked found or exact. Killing tests: a six-colouring of a window member
  (the wall); an independent set of ⌈Q²/6⌉ at one (W_f); a colouring of ℚ(√167)² with fewer than six colours (the conjecture
  above five; five there is held, row 123).*
* **G60 — Fractional colourings reach fields the residue method cannot, and stop where a residue plane is fractionally small. [hand, from `[MatolcsiEtAl2025]`; cert; measured; one reading]** Every congruence between subsets of `F²` is an isometry of `F²`, so the blow-up of a finite `H ⊂ F²` along a Følner set of the (solvable) group its congruences generate stays in `F²`, and **χ(F²) ≥ ⌈χ_gf(H)⌉** (`plans/FS56-field-blowup.md`) — a lower bound that uses no residue map, no additive structure and no forced pair; instance: χ_f(K²) = 4. Its **ceiling** is `min(4.36, χ_f` of every usable residue plane`)` — 3 at an `𝔽₃` place, 3.5 at `𝔽₇` — so it can never prove more than five colours. **Given MR the cap is exact, and it is what row 123 proves** (row 129, two minds): `α₁(F²) = max(m₁(ℝ²), sup_v r_v)`, the fractional local–global principle, and row 123's five is `⌈1/α₁⌉`, the colour count entering only at one pigeonhole on the densest class — so no argument that runs one class at a time gives six. The finitary–measurable gap `[AmbrusEtAl2023]` §4 expected is a tight place's (the Moser lattice's dyadic places), gone at ℚ(√635087), where `α₁(ℝ²) = m₁(ℝ²)` given MR. **The reading** (R-C; killing test in FS-58): its ratio-bound shadow on pieces `Cay(ℤ⁴, W)` tends to the least local character mean over the places where the unit circle is compact (real: `J₀`'s −0.40276; `𝔽₃` −1/2; `𝔽₇` −0.5617; `𝔽₂₃` −0.3317), the split places controlled by the weights, so a real field whose compact places all read above −1/2 — ℚ(√167) first — would have χ_f ≥ 3.48. What reached four colours over real quadratic fields was not this route but finite refutations (G61, row 73). *Do: run a field-level lower bound on one colour class before believing it — if it runs per class it is `⌈1/α⌉ ≤ 5` (row 129); read the cap first — a usable plane with χ_f at or below the target kills the route by theorem; where every usable plane's χ_f sits above it (no `𝔽₃`, no `𝔽₇` place), price a finite `H` with χ_gf(H) > k − 1 before any forced-pair route: it proves k with no refusal, and FS-56's LP and checker exist. The real place's `J₀` minimum `−0.40276` is below `−1/3`: a one-sided spectral bound at `−1/k`, `k ≥ 3`, fails over every real field before it is tried (row 122; missed at FS-100 stage 5's registration). Killing tests: a real field whose compact places all read above −1/2 with a 3-colourable plane (the reading); a finite `H ⊂ F²` with χ_gf(H) above a usable plane's χ_f (a defect, never a finding).* *The same engine splits the inheritance
  question* (FS-73): `Λ ≅ ℤ^r` is amenable, so the differences no invariant probability measure on the colouring shift separates form
  a subgroup `F_μ` with `F ⊆ F_μ ⊆ P` — a walls half and a recurrent half (`plans/FS73-derivation.md` T38); at three colours both
  close (row 79). *What this entry caps is the one-point densities* (FS-79): window frequencies are not controlled by `χ_f` — their LP is
  exact in rank 1 (row 80) — and FS-73's `Θ₃ = ∅` is itself an averaged pair statistic plus integrality [reading, Poros], so G72's
  averaging move is not capped here (FS-80).
* **G61 — Three colours break at arithmetic, not at size — at 1/3 in the unit-vector ring, which a finite lattice sees as its supply of unit vectors. [kernel + certified + hand + measured; one reading]** Over a real
  quadratic field with `d ≡ 2 (mod 3)`: (1) **The barrier** [kernel, row 72]: directions integral at 3 are 3-colourable outright, so a refusal needs a direction with 3 in a denominator —
  met by count in every certified witness (89 to 4,328 such edges, never zero). (2) **The theorem** [hand, two independent derivations; row 82; its method is G74]: the plane over any `F ⊆ ℝ` needs four once `1/3 ∈ ℤ[U_F]` and the plane has an odd cycle — for ℚ(√d) exactly `d ≡ 11 (mod 12)`, by the type-M relation `1 = 2n − nv − nv̄` — so **T4 holds**, and so does the conjecture's four-colour clause for real quadratic fields (`[Fischer1990]` Thms 8–9: χ = 2 iff d ≢ 3 mod 4, χ = 3 for d ≡ 3, 7 mod 12, and at those every three-colouring is additive mod 3; L = 4 by the dyadic bound at d ≡ 3 (mod 8), his Thm 10(i), or the plane at 7, and L ≥ 5 exactly at d ≡ 47, 143, 167 (mod 168)), and the
  barrier is its necessary half: `1/3` needs a 3 in a denominator. (3) **Rigidity is periodic and local** [measured]: the 3-adic plane is Hoffman-tight at three colours and rigid
  from level 1, and stays rigid tensored with the residue planes at 7 and 11 (at 11 a theorem: the plane is 3-gap-free and `Γ₁₁` mixes, `λ* < 1/2`, so every three-colouring of the product pulls back, rows 114–115; at 7, where `Γ₇` neither mixes nor has `χv > 3`, still measured; false without gap-freedom); the periodic colourings of the 3-integral pools tried were all affine, so quotient screens never kill; on ℚ(√11)'s `Λ₁₀` "every colouring is affine" is a theorem (G71). (4) **The rational directions are
  load-bearing** [measured; explained by row 82]: the `√d`-vectors alone force nothing, and two fields' unit vectors in one lattice shape share *only* the rational ones, because the
  norm equation is linear in `d` — the rational pattern `U₅` is the layer every field-level argument reads. (5) **On a finite lattice, supply decided refusal** [measured, row 74]:
  one integral shape refuses over ℚ(√11) with 108 unit vectors and is periodically 3-colourable over five fields with 20–36; refusing lattices are rich in classes, not coarse;
  odd girth ≤ 9 is necessary and far from sufficient; and the congruence class did not decide which lattices refused — 11 and 59 land at `d ≡ 3 (mod 8)`, cutting across
  `[Fischer1990]` Thm 10's split of the family. Since row 82 this is a fact about finite witnesses only: every field in the family refuses, and a finite witness appears where the
  field's `Θ₃` empties at small depth (five layers at depth `5^K`, `K_B(d) ≤ 3` below 500, row 83). *Demotion records:* this entry first read "every field with a usable plane at 7
  has χ = 4" (false at ℚ(√2), ℚ(√7)) and "forcing at small size tracks short odd cycles in a COARSE 3-non-integral lattice" (the census: rich, not coarse); FS-58's plan first
  derived periodic affinity from "finite quotients of the 3-integral group are 3-groups" — false, since the unit vectors' lattice maps onto every stable residue plane. **And until
  FS-81 (2026-09-24) it read "T4 — every such d needs four — is unproved: no proof and no route to one — no witness transfers between fields, and the chain route needs a forcer in
  every field's own 3-integral graph"**: killed by row 82, whose route transfers one relation and one rational pattern to every field and needs no forcer. *Reading, with its
  test:* **the census's mod-8 skew** (13 of 20 certified at `d ≡ 7 (mod 8)` against 2 of 20 at `d ≡ 3`) is configuration A's: `{1, v, v̄}·U^(5^K)` never empties at
  `d ≡ 11 (mod 24)` (FS81-T8), and lattices built around `v` and `v̄` inherit it. Killing test: a census-style search that lands the `d ≡ 11 (mod 24)` fields at the `d ≡ 23` rate.
  *Do: over any real field, decide three colours at the field level first — over a number field, three iff an odd cycle and a prime above 3 of residue field 𝔽₃
  (row 99); over any real field, `1/3 ∈ ℤ[U_F]` and an odd cycle force four — and build nothing; for a finite witness take the five layers `{vᵏ : |k| ≤ 2}·U^(5^K)` at the least `K` with `d < 21·5^{K−1}` and certify structurally (row 83). Nothing kills
  the theorem but a defect in its chain (FS73-T22's ⟹ is hand-proved, never kernel); it forbids a three-colouring of any such plane, and every three-colour search over one.*
* **G62 — Every witness is a twisted bilayer, and the twist family is the coincidence rotations. [derived, the
  identification verified symbolically; the prior art external]** Every 5-chromatic object this project holds or reproduces —
  de Grey's 1581, Heule's 510, `[Parts2020a]`'s record, the `ρ₆₃` arena — is **a point set plus a rotated copy of itself,
  joined where the two layers land at distance 1.** That is the definition of a **Moiré bilayer**, and the resemblance the
  pictures have to Moiré patterns is not a resemblance but a description. **The identification is exact.** With
  `w = (1 + i√(4n−1))/2`, the standard generator of the integers of `ℚ(√−(4n−1))`, `|w|² = n` and **`w̄/w = −ρ_n`** — so
  G7's type-M family is, up to a half-turn, **the coincidence rotation of index `Σ = n` of the imaginary quadratic order
  of discriminant `1 − 4n`, one for each `n`**. Verified symbolically for general `n` and at `n = 3, 4, 16`:
  `(5+i√11)/6`, `(7+i√15)/8`, `(31+3i√7)/32`. (Derived at M63 phase H3 and left in `plans/M63-phaseH3-prior-art.md` §PA.4;
  promoted here 2026-09-17.) **Commensurate or incommensurate IS the field wall.** A twist is *commensurate* with a module
  when the two layers share a finite-index sublattice — equivalently, when `√(4n−1)` already lies in the module's field.
  Then the bilayer is **periodic**, so it is a Cayley graph of a finite quotient, so its chromatic number is bounded by that
  quotient's: **a commensurate twist cannot raise the colour count above its base field's local bound — there is nowhere for
  it to go.** Only an incommensurate twist generates a new field, and *which* field is exactly what the 2-adic wall test
  measures. G7's ladder, rung by rung: `n = 3` (Moser, `Σ3`, radicand 11 already in `K`) is **commensurate** and can never
  reach five; `n = 4` (`Σ4`, radicand 15 → `√5`) is incommensurate, reaches five, lands 5-sealed; `n = 16` (`Σ16`,
  radicand 63 → `√7`) is incommensurate, reaches five, lands 6-open. **And the plane's own 7-colouring is the `Σ7`
  coincidence lattice**: `Instances/Seven.lean` colours by cosets of the norm-7 Eisenstein ideal `(−3 + ζ₆)`, whose
  index-7 sublattice is the coincidence site lattice of the 21.79° twist — the canonical `Σ7` grain boundary and the
  textbook twisted-bilayer-graphene commensurate angle. Row 34's "2, 5, 6 are not `a² + ab + b²`" is that discipline's
  statement that a coset colouring's colour count is an ideal index, hence a norm (G64). **Refuted trap, recorded so it is
  not rediscovered:** `ρ₁₅` sits **1.045°** off 30° and twisted bilayer graphene's first magic angle is **≈1.05°**. This is
  a coincidence. Ours is `arccos(7/8) − 30°`, algebraic and forced by a Diophantine condition; theirs is the first zero of a
  ratio of interlayer coupling to Fermi velocity, a continuum quantity that moves with the material. **What the frame does
  NOT reach: the forcing side.** Moiré physics' localisation — flat bands, trapped states at the superlattice scale — has no
  principled translation into "this vertex's colour is determined"; every construction of one is word-association, and
  forcing stays where G15 left it. **Prior art** (M63 phase H3 §PA.4, three passes): `[BaakeZeiner2017]` §6 defines a
  submodule to have the **same rank** (footnote 8), so rank-halving ones are out of scope by definition;
  `[BaakeGrimm2004]`'s Bravais colourings are similarity submodules, and ours is neither map; the twisted-bilayer-graphene
  literature's commensurate family is the **hexagonal** one, `cos θ = (m²+n²+4mn)/(2(m²+n²+mn))`, a different one-parameter
  shape that does not contain ours; and **no source joins coincidence-site theory to unit-distance colouring.** The full
  gate is FS-63. **A lattice can be a multilayer, and then it decides layer by layer** (FS-73, missed and then found by hand):
  ℚ(√167)'s `L21cc6506` is `U = {1, v, v̄, z, z̄}·U_R`, the rational pattern in five rotations, and `v = (83 + i√167)/84` is the
  `Σ = 42` rotation (`cos θ = 83/84`, radicand 167) — so `Θ₃` is the set of `θ` whose every layer pulls back into the rational
  pattern's rotation set, the product route that proved χ(ℚ(√167)²) ≥ 4 (row 79). *Do: name every bilayer by its `Σ = n` —
  and factor a lattice's unit vectors as rotations times a base pattern before any tree — and decide commensurate or not by whether `√(4n−1)` lies in the
  field: commensurate is periodic, so ask a finite quotient's colouring before any solver — one proper colouring of the
  quotient colours every arena on that module at once; incommensurate names the new field, which the wall screens. Killing
  test: a commensurate twist whose arena's chromatic number exceeds its base field's local bound, which would refute the
  periodic ⟹ finite-quotient ⟹ bounded step.*
* **G63 — The chromatic number of a field plane is arithmetic only: pure transcendence is free. [kernel at `d = 2` (row 104); prior art:
  `[Fischer1990]` Thm 6, statement and proof; its lemma `[Madore2015]` Prop. 3.2]** For any `F ⊆ ℝ` and any `t` transcendental over `F`, **`χ(F(t)²) = χ(F²)`**. At the place `t ↦ 0` the
  residue field is `F`, which is formally real, so `−1` is not a square there; a unit vector `(u,v)` with a pole would need
  the leading terms of `u²` and `v²` to cancel, which needs `−1` to be a square — so **every unit vector is integral**, the
  plane splits into cosets of the valuation ring, and reduction is a graph homomorphism onto `F²`. The other inequality is
  the induced subgraph. **So `χ(ℚ(π)²) = χ(ℚ(e)²) = 2`: the planes over the transcendental fields are bipartite.** No amount
  of transcendence buys a colour; only algebraic extension does, and the chromatic number cannot see transcendence degree at
  all. (The other constant people ask about is the golden ratio, and it is arithmetic, not transcendental: `ℚ(φ) = ℚ(√5)`,
  `5 ≡ 5 (mod 8)`, so the prime above 2 is inert in `ℚ(√5)` and ramified in `ℚ(√5, i)` — **`χ(ℚ(φ)²) = 2`**, the golden-ratio
  plane is bipartite. `L(ℚ(√5)) = 2` is G48's; `data/fplane/map.md` reads "sealed-at-4" there, which is the coarse `|κ|` bound
  and not the sharp value.) **One lemma under two methods** (M2): the kernel's `unitQuadrance_colorable_of_valuationSubring` colours `K²` from any place whose
  residue ring has no `√−1` — Theorem A's finite places (`q ≡ 3 (mod 4)`) and this entry's `t = 0` are its two instances, a smooth rational
  point of a curve a third. **Fischer's Remark 1 and the bridge.** `[Fischer1990]` Remark 1 reduces a finitely generated `E ⊂ ℝ` to a
  number field by calling `E` "a purely transcendental extension of some finite algebraic extension" of ℚ — false: `ℚ(π, √(π³ − π))` lies in no purely transcendental extension of any number field (genus 1: Lemma NP is Fermat–Catalan at signature `(4, 4, 2)`, and its genus-0
  twin fails exactly at `(2, 2, 1)`; kernel with `2 + L` for `π`, row 107), yet its plane is two-chromatic (a degree-one place, J17-T8).
  The bridge `χ(ℝ²) = max` over real number fields is **`[Madore2015]` ¶5.4 with ¶1.3, by Tarski** (noted by `[BendaPerles2000]`, unread;
  asserted in `[Soifer2024]` ch. 11); in the kernel it is conditional on one true proposition, `RealAlgebraicDescent` — the equational
  existential fragment of Tarski–Seidenberg for `ℝ_alg ⊆ ℝ`, months of formalization, Artin–Lang being no cheaper (J17-T10). **Open (Q-const):** for finitely
  generated `E ⊂ ℝ` with constant field `F`, is `χ(E²) = χ(F²)`? True when `E/F` has a degree-one place with formally real residue field.
  `[Fischer1990]` Theorem 6 is the statement for every dimension and for additive colourings too ("`F^d` can be k-colored iff `F(α)^d` can"), proved by writing a unit vector over `F[x]` without common factor and setting `x = 0`. Nothing here is ours but the kernel forms. *Do: when a construction adjoins a parameter or a transcendental, expect no
  colour from it — reduce to the algebraic field first; asked about ℚ(π), ℚ(e) or ℚ(φ), answer 2 without computing. Nothing kills
  it (kernel); it forbids a colour gained by adjoining a transcendental to a real field.*
* **G64 — Six may be a value no field attains: a claim about fields, stronger than χ(ℝ²) ≠ 6 and not equivalent to it. [derived; the pattern a reading]**
  **The two statements.** *S:* no subfield `F ⊆ ℝ` has `χ(F²) = 6`. *W:* `χ(ℝ²) ∈ {5, 7}`. **S ⟹ W trivially** (ℝ is a subfield;
  for *number* fields it is FS-39's bridge — if `χ(ℝ²) = 6`, de Bruijn–Erdős gives a finite 6-chromatic unit-distance graph, its
  coordinates generate a number field `F`, and `6 ≤ χ(F²) ≤ 6`). **W ⟹ S is unproved and unmotivated**: a plane needing seven forbids
  no smaller field from needing exactly six, and one quadratic step can jump two colours (ℚ → ℚ(√11), 2 → 4). **The exact form, given
  the bridge: `χ(ℝ²) ≠ 6` ⟺ every six-chromatic number field has a seven-chromatic finite real extension** (⟸: a field attaining the
  plane's 6 has none; ⟹: take the compositum with a field holding a 7-chromatic graph) — six is never where the climb *stops*, which
  restates Hadwiger–Nelson and does not reduce it. *Demotion record: as minted 2026-09-17 this entry claimed S ⟺ W —
  "Hadwiger–Nelson reduced from three values to two" — when both lines of its proof gave only S ⟹ W; the wall bears on S and on
  the value set of `L`, never on W, and FS-62's conditional target dissolved with it. Caught on review 2026-09-19, after two days
  of compute at `q = 19` under that banner.* **What the wall does decide.**
  `χ(F²) ≤ L(F)` is a theorem (row 52; row 57's gap is the kernel's, not the mathematics': the localisation at a prime is a DVR in every number field), so a six-chromatic field has `L(F) ≥ 6`, and
  `L(F) = 6` needs one of six named finite graphs to be six-chromatic (G56, G59); under the conjecture's bold form S *is* the wall, and
  under its main clause a six-chromatic window plane is a six-chromatic field. **The gap question has two strengths.** The strong one —
  `χ(F²) ≥ 6 ⟹ χ(F²) ≥ 7` in `F` itself — is what S needs, and wants G55's chain at six: a forced pair at `δ` with `1/δ ∈ ℤ[U]`. The
  weak one — some finite extension reaches 7 — is W, and there a six-colour forced pair at *any* distance ≥ 1/2 suffices (the spindle,
  row 44): the arithmetic hypothesis is the price of staying in the field. Either is this file's open structural question at six
  instead of five. **The aiming statement, unconditional:** six hides nowhere in the arithmetic — it hides only in the gap between
  `L(F)` and `χ(F²)` at `L(F) ≥ 6`, where `χ(F²) ≥ 5` through MR (row 123), where every ceiling instrument this project owns (residue maps, additive colourings, the hexagonal 7) is silent;
  FS-64 is the one proposal for an instrument that is not. **Given MR the plane sits at the gap's top** (row 128): S_nf (no real number field has `χ(F²) = 6`) ⟹ `χ(ℝ²) ≠ 6`, and row 128 states its exact form over totally real fields — never S ⟺ W. Characters are shut out of that gap at the exposed fields: given CLG they need 8, 17, 22 colours at ℚ(√167), K(√7), de Grey's field (row 101). **Warning:** "six is skipped" is **not**
  evidence for seven — it is equally consistent with every field being `≤ 5` and `χ(ℝ²) = 5`. What forces seven is the
  conjecture's bold form at `K(√7)` (G48), never the skipping. **The norm reading** [reading]: every chromatic number this
  project has ever pinned for a plane over a coefficient structure is **2, 3, 4, 5 or 7** — exactly the integers `≤ 7` that
  are `a² + b²` or `a² + ab + b²` — and **6 is the smallest integer that is neither**, because `6 = 2·3` with 2 inert in the
  Eisenstein integers and 3 ramified. Mechanism where it has one: a coset colouring's classes are cosets of a rotation-stable
  sublattice, hence of an ideal, hence the colour count is a norm (row 34, G62). **No mechanism at the finite planes** — the
  5-colouring of `Γ₁₁` cannot be a subgroup quotient, since `(ℤ/11)²` has no subgroup of index 5 — so this is half
  numerology and is labelled so. Next predicted skips: 11, 14, 15. **The mechanism half is three theorems, and it WEAKENS the
  reading rather than supporting it** (2026-09-18): every structured colouring we own constrains its count — a residue colouring's
  is the size of a residue field, hence a **prime power**; a coset colouring of the triangular lattice by a rotation-stable
  sublattice is an Eisenstein ideal, hence **Loeschian**; the same on the square lattice is a Gaussian ideal, hence a **sum of two
  squares** — and six is the smallest positive integer none of the three can produce, for three independent reasons. **But five has
  no mechanism either, and five occurs**: the pattern already fails at the value immediately below the one it is being used to
  explain, and it fails at the finite plane, which is where the wall lives. The two criteria are also distinguishable — the
  three-mechanism union admits 11 (a prime power) where the two-form criterion forbids it — so the killing test below separates
  them instead of merely testing one. **Measured** (`tools/fq_chi.py`, `data/fs62/`): an independent rebuild
  reproduces `χ = 3, 4, 3, 5, 5` at `q = 3, 7, 9, 11, 19` and the controls `χ(Γ₅) = 3`, `χ(Γ₁₃) = 5`; 17, 25, 29
  are `≥ 5` and undecided at five. **The dimension-3 probe returned nothing** — `χ(UD(𝔽₃,3)) = 3` and every other case decided
  is `≥ 7` — so a six outside dimension two was unreachable *at the sizes the budget could decide*, and whether the skipping is
  specific to the plane stays untested. More instances: `plans/GROKKING-INSTANCES.md` §G64. *Do: never cite "six is skipped" as evidence for seven; aim any six-hunt at the gap
  between `L(F)` and `χ(F²)`, where the residue, additive and hexagonal ceilings are silent; keep S and W apart in every
  sentence about six. Killing tests: a six-colouring at 17 (`χ ∈ {5,6}`), at `U₆₄` (`χ ∈ [6,8]`), or at any window member;
  or any plane pinned at exactly 11 (which refutes the two-form reading and confirms the mechanism one).*
* **G65 — The refusal phase diagram: a ball's average degree, not its size, decides whether a solver answers, and hardness marks the threshold, never the far side. [measured on 775 asked
  balls of FS-61; one registered prediction lost]** Put every asked ball of a lattice unit-distance graph at its average degree `2·edges/points`: below 4 everything 3-colours at once; **4–6 is the
  hardness peak** — most undecided balls sit there and every decided one is colourable (random graphs have their 3-colouring threshold at ≈ 4.7; 25 undecided balls sit on planes that are
  3-colourable by theorem); **no ball below 6.6 has ever refused**; from 14 up almost everything decides in seconds, colourable or not. On a fixed refusing lattice the *smallest* refusing ball is
  the slow one and larger radii refuse faster (47: 104 s at R = 1.2, under a second at 1.5). So "suddenly hard" is the signal of standing at the threshold from either side, and the move is away
  from it. **The law that aims a ball before it is built: degree = g·φ(R)²**, `g` the lattice's unit-vector count, `φ(R) = [2R²·acos(1/(2R)) − ½√(4R²−1)]/(πR²)` the overlap of a disc with its unit
  translate, squared because a ball is a bidisc (observed/predicted median 1.0000, range 0.715–1.184); figure of merit `N₁₄ = π²R₁₄⁴/covolume`. **A radius ladder that steps down to fit a point cap
  steps down in degree, into the peak** — FS-61's did, 24 of 37 asks came back undecided, and "the solver is the wall" was accepted from a population at median degree 5.5; re-aimed at degree 14,
  five new fields refused. **To certify, go up in degree too**: at 239 the degree-14 ball refused in 403 s and its core rounds crawled (8,336 points after 52 rounds and 77 minutes, still falling ~25 a round), while the degree-18 ball of the same lattice refused in 197 s, ran its core rounds to a fixpoint in 12 minutes and certified at 2,360 points — *though the registered prediction about it lost on both halves* (not under 120 s; round 0 left 49,576 points, not under 5,000): what differs between the two balls is the tail of the core rounds, not round 0. **What lost:** "every ball at degree ≥ 14 decides" — 2 of 17 ran to the wall, both above the old cap, where the record it was registered on held nothing: a
  population extrapolated past its own edge. And certification cost is predicted by none of the three statistics proposed for it in one day — ball points, plain solve time, the first core round's output: the largest of five balls
  certified in 44 s, the smallest needed a second, denser ball — so the instrument is a **stop rule on the measured rate (points per second, on the current window), not a predictor**; certificate weight is a cliff (1,004 points → 19 MB, 1,739 → 40 MB, 2,360 → 43 MB). Minted from
  Kooshi's question — *is there a cliff we can traverse instead of searching blindly?* — which the records already answered. It bears on every SAT search here, not only on quadratic fields.
  **The law prices balls bounded in every embedding; a word ball has a combinatorial ceiling it does not see** (FS-70, 2026-09-22): on the
  rank-8 lattice `group:u3:2+w4` the 1.9 M-point ball at sums of ≤ 4 has average degree 15.4, its ≤ 3 interior has 84 generator-neighbours
  each — and its 13-core is empty, because the interior's own induced degree is 11.5 and the shell that carries the rest peels first; the
  denser-core lever of FS-61 does not exist there, and the Minkowski ball that the law does price is `10⁹` points at degree 18. **The
  ceiling is radius-indexed, not rank-indexed** (FS-70 phase 1f): a word ball's core number is set by its outermost shell's mean degree,
  and that shell is ≥ 93 % of the ball at every radius measured — 11.7 at sums of ≤ 4 (ceiling 12), 14.6 at ≤ 5 (29 M points, mean degree
  19.2, ~103 GB of solver); the same lattice's radius-4 ball in its 132-unit-vector metric is 11 M points at 18.7. *Do: on a word ball,
  compute the core numbers and the outermost shell's mean degree before promising a denser core; a shell one radius out raises the
  ceiling by about the shell's degree gain, at the shell's size.*
  **The four-colour band, measured once** (FS-81, row 84; one lattice, one encoding, one wall): on de Grey's lattice with the certified forcing graph X_A, refusals stay undecided at `d_ball` 8.3–14.7, first decide at 16.6 (463 s quiet) and take 55 s at 18.4 — so the law's four-colour aim is about 18.4, where a triangle-free survivor over ℚ(√47) needs ≥ 1,284 times the control's points; the three-colour numbers above do not transfer.
  *Killing test: a refusing ball below average degree 6.5; or a family of lattice balls whose undecided fraction does not fall with degree.*
* **G66 — Up a residue tower nothing drops where we can see, because a higher level is a *fuzzy* copy of level one and
  fuzziness is taxed; what is left of the question is the carry. [kernel + cert + hand; one reading]** The tower's
  limits are analytic: `lim_k χ(G_k)` is the clopen chromatic number of `ℤ_p²`, `lim_k α(G_k)/p^{2k}` its measurable
  independence density, and `χ(F²) ≤ χ(ℚ_p²) ≤ χ_Bor ≤ χ_clopen ≤ χ(Γ_p)` — every ceiling we own, and `L(F)`, reads the
  *weakest* term of a chain whose other terms nobody had computed at an odd prime. **Why they do not drop** (row 75):
  every character of `G_k` that is new at level k is small (`|λ| ≤ 2p^{k−1}` against degree `p^{k−1}(p+1)`), so to level
  one an independent set of any level is a fractional set φ paying `2Σφ(1−φ)` for its fractional part — one inequality
  at every level, and the certificates show it leaves no room for a fourth class at 11 or 19 or a fifth at 23. The 2-
  and 3-adic towers of row 67 are constant for a different reason (level one is Hoffman-tight); at `p ≥ 7` nothing is
  tight and the tax is what holds. **The gain is real locally and unaffordable globally**: on one single-direction line
  the p-cycle unrolls into a `p²`-cycle and a level-two set beats the pull-back (Lemma W), so fibre shares leave the
  stable-set polytope and no pointwise transfer can exist; only the plane's bracing as a whole forbids the gain (G45's
  over-determination from the other side). **The whole content is the carry**: with the carry of integer addition set to
  zero the tower is over a ring containing `𝔽_p` and is impotent in two lines (Theorem E); and every instrument we own —
  the spectrum, the inequality, every `B₁` certificate — is blind to the carry, holding verbatim for every twisted cover
  (Lemma T). So the certificates prove more than was asked, and the method can prove *the tower never rises* at a prime
  only if no twist of `Γ_p` rises there. *Reading — the tower never rises: `α(G_k) = p^{2(k−1)}α(Γ_p)` for every p and k
  (true at level two of 7, `α = 686`; `B₁ = α(Γ_p)` numerically at 7, 11, 19 — at 23 the relaxation reads 97.6
  against a best set of 87: the gap grows with p, or `B₁(23) > α`), and the same for every twist.* **What it does to the conjecture:** `L(F)` with every level
  allowed is the same number at 7, 11, 19 and 23, so the prediction at ℚ(√167) survives its first tower — and 43, its
  other plane, is beyond this instrument (priced at 84 GPU-days and 310 GB: a smaller relaxation, not a bigger machine)
  and ℚ(√47)'s bracket could not close from above by residues (`CLOSED-QUESTIONS.md` §1.7; it closed at five, row 121). **Instrument lessons**
  [method]: ask the whole graph directly, clique pinned, before building any finder — the pilot, `UD(ℤ/121,2)` at four
  colours, fell in 1.7 s; a level-two resolution refutation projects onto level one, so CDCL refuses nothing up a tower
  it cannot refuse at the bottom; the symmetry-reduced second-level moment relaxation beats the three-point
  bound and the level-3 relaxation on these planes (77.5 against 80.59 at 19) and bounds `α(Γ_p)` itself — *"it must
  beat the last instrument's reading" was never an argument that it cannot* (the owner ruled 23 out of reach on that and
  the 19 reading overturned it); a rounded bound travels with its shift (positive definiteness survives iff `shift ≥
  10^(3−D)` at 7, 11, 19 and `10^(4−D)` at 23 — the recipe followed literally returns no certificate there, so scan
  three decades; at 11 one knob moves `U` from 28.2021 to 30.5445) and tracks the **dual** residual; in the kernel the
  clause table is the graph's bill and the segments the proof's. *Do: read `L(F)` as the all-levels number at 7, 11, 19 and
  23 without recomputing; at a new prime ask the whole graph clique-pinned before any finder, expect CDCL to refuse nothing
  up a tower it cannot refuse at the bottom, and certify by the fibre-share relaxation rather than by SAT. Killing tests: a
  verified independent set of 687 in `UD(ℤ/49, 2)` (which would refute a hand link or the checker, not only the reading); of
  3,389 in any twisted cover of `Γ₁₁`.* *The first sentence reaches colourings too* (FS-73): a lattice graph's periodic colourings
  are exactly the continuous colourings of the odometer `Λ ↷ Λ̂`, so `P = F_clopen`, and the inheritance question is the compulsion
  analogue of `χ_clopen = χ`, with the measurable colourings between (`F ⊆ F_μ ⊆ F_meas ⊆ P`).
* **G67 — A grokking is grokked by its form, and the reframe is re-grokking. [method; measured on one milestone]** The corpus
  is read in one of two modes — as background (understood, and left where it lies) or as an instrument (reasoned from) — and
  which mode an entry gets is set by its *shape*, not by its truth or its place in this file. On FS-70 the entries that fired
  were the ones written as laws and dials with an imperative and a falsifier: G65's degree law (*aim a ball before it is
  built*), G53's counting screen, G55's chain closers. The ones that sat silent while bearing directly were written as
  descriptions or memoirs: G54 says "classified by one sign" and never *when you meet a new prime, compute the sign first*;
  G16 and G32 narrate a milestone's route in the past tense; G40 states absorption as a result, not as the prediction to make
  before an arena is built. So **every entry ends with what it makes you do and what would kill it**, under one marker —
  `*Do: … Killing test: …*` — so the form can be scanned for: the *Do* opens with its **trigger** (*when you meet a new prime;
  before an arena is built; when a pair sweep reads zero*), never a bare verb, and the second half takes one of two shapes, by
  grade — a reading or a measurement names its **falsifier**; a theorem names what it **forbids** (*nothing kills it; it kills
  X*), and a falsifier invented for a theorem is a category error. An entry without both is understood, not grokked. The word was already right:
  "grokking" is first-person, held knowledge, and it indicts the failure by its name — an entry in context and not reasoned
  from was not grokked. What failed was the mode of reading, and the shape of the entry sets the mode. Hence the act that
  opens every milestone (WORKFLOW 3.1) is named for what it is, **re-grokking the goal** — reading the theory from inside the
  new question — and not "audit", which is felt as an instruction to check where "re-grok" is felt as an instruction to
  think. Every entry in this section has been re-examined for its form (2026-09-22) and given it where it was a memoir; a new
  entry is held to the same form at minting. *Do: when you write or read an entry, find its trigger, its Do, and its killing
  test or what it forbids; an entry without them is background, and a bearing it holds will be missed. Killing test: at the
  next re-grokking, count the* bears *verdicts drawn from a Do line against those drawn from an entry's body — if the form did
  the work, the first count dominates; and a §G written from entries in the form that still misses a bearing a memoir would
  have supplied. First data point (FS-71): a milestone whose object is the corpus itself drew its verdicts from grade tags and bodies,
  not Do lines — expected, and not a count against the form. M2's miss: G56 held the bridge's credit ("FS-39's bridge, which is
  `[Madore2015]` ¶5.4 plus de Bruijn–Erdős") in its body, not its Do; walked by its title it read silent, and the plan announced the
  credit as a finding.*
* **G68 — Ask the quotient before the ball, and read its colouring for a gap. [derived from kernel rows 56 and 66; measured on
  seven lattices; the instrument of FS-70 phase 1d]** A lattice unit-distance graph is periodic, so a proper k-colouring of the finite
  quotient `Cay(Λ/NΛ, U mod N)` (`U` the lattice's *complete* unit-vector set, none in `NΛ`) colours every graph on the lattice at
  once — and if one vertex's closed neighbourhood misses a colour, the quotient is slack, and every pair on every graph in the
  lattice is free: `Forces ↔ =` at every distance and radius (`unitQuadrance_colorable_of_quotient`; `slack_addCayley_of_fanGap`,
  `Slack.forces_iff_of_hom`). Minutes per lattice, no ball, one-sided: an UNSAT or a gap-free colouring at one `N` proves nothing
  (L6 gives a gapped colouring at `N = 5` and a gap-free one at `N = 8`), so the finder is aimed at *gapped* colourings (a clause
  that empties one closed neighbourhood of a colour). Over ℚ(√3,√5) it closed, by theorem, four lattices three phases had asked
  with solvers; over K it finds no gapped colouring on de Grey's lattice at any `N ≤ 12`, as Harder's forced pair requires. The
  gapped colourings are non-additive (`Hom((ℤ/p)^r, G) = 0` for odd `p`, `|G| = 4`) — the colourings the additive screens (G41,
  G42, `FS70-T2`) are structurally blind to; G61(2)'s "quotient screens are blind" was a fact about *colourability* at three
  colours on affine colourings, and the gap reading is the half it lacked. Its soundness edge is completeness of `U`: on a lattice
  whose saturation is unaffordable, a gap read from the generators alone proves nothing. *Do: before building any ball over a
  lattice, run the quotient at every admissible `N` the rank allows and read each colouring for a gap; one gapped colouring closes
  `Forces` on the whole lattice — build nothing on it; where every colouring is gap-free, the lattice is rigid as far as periodic
  colourings go and the periodic Kempe screen (`FS70-T10`) decides the target. Killing test: a lattice with a gapped quotient
  four-colouring that carries a four-colour forced pair — which would refute the reduction's being a homomorphism, i.e. an
  incomplete `U`, never row 66.* **A gap is sufficient for looseness, not necessary** (FS-73, row 78): the rank-6 L3 is gap-free at
  every period and still loose — one period-2 colouring's Kempe period group (the translations fixing every Kempe component) is 0 —
  so finitely many periodic colourings whose Kempe period groups meet in 0 make a lattice loose, a gap being the case of an isolated component — sufficient, not necessary: `L21cc6506` is loose through a full-dimensional `Θ₄` cell, infinitely many periodic colourings (row 81; G21; whether finitely many already meet in 0 there is open). *Where every colouring is gap-free, compute the Kempe period groups, and the `Θ_k` cells (G73), before calling a lattice rigid.*
* **G69 — Rigidity is arithmetic, decided on the quotient, and over ℚ(√3,√5) it pulls apart from density. [hand + tools; FS-70
  phases 1c–1e; one prediction of the owner's lost on the way]** The chain route (G55) needs a four-colourable lattice with a
  *forced* pair — a rigid colouring space — and rigidity is decided before any ball is built. **Periodic colourings are residue
  colourings, prime by prime:** for a rank-4 lattice whose ℚ-span is a CM field `E`, a period-`p` four-colouring is Theorem A's
  colouring at `p` on the target the unit vectors' reductions generate — a prime of `E⁺` **split** in `E` supplies the residue plane
  `UD(𝔽_q, 2)`, five-chromatic from `q = 25` (de Grey's 54 unit vectors are *exactly* the torus of `𝔽₂₅` mod 5 and of `𝔽₄₉` mod 7,
  which is why his lattice has no odd-period colouring and Harder's `8/3` pair is forced); **inert** or **ramified** supplies a
  norm-one Cayley graph that is computed, not read off, and over ℚ(√3,√5) four-colours with a gap at 5 and 7 for the hexagonal
  fabric's CM field `ℚ(√−3,√−5)` and at 5 for the doubly split `ℚ(√3,√−5)` (`FS70-T5`, `T9`). **A forced pair at `δ` then needs
  every periodic colouring's Kempe component of the origin to reach `δ`** — the lift of the quotient's two-colour component, a coset
  `p + V` of the closed-walk voltage lattice, with the index `[NΛ : V]` the deciding quantity (`FS70-T10`); the fan gap (G68) is the
  degenerate case `V`-trivial and **is not the classifier**: the rank-6 L3 is gap-free at every period and escapes at every target
  (`[2Λ : V] = 81`), which is the prediction the owner lost. Over `K` the hexagonal lattice is rank 4, meets refusing targets at 5,
  7, 11, 13 and is Kempe-rigid at `8/3` under all six periodic colourings found — **dense and rigid**, so a forced pair exists — Harder's
  at `8/3` (745 points his smallest forcing subgraph; our control ball was 23,083) — and **every four-colouring of de Grey's lattice is
  `8Λ`-periodic: `F = P = 8Λ`, from one 2,044-point certificate at `v = −(4/9)(1+√−11)` (row 78), and since row 85 by derivation from Parts's trees, so Harder's `8/3 ∈ 8Λ` is derived too** — on the Moser ring Hubai had the same count by 2018 (`[Hubai2018]`); rigidity there is complete. Over ℚ(√3,√5) every lattice of rank ≤ 6 built is loose, and the one lattice with no periodic colouring found is
  rank 8, whose dense finite pieces start at `~10⁷` points (a 29 M-point word ball at degree 19.2; an 11 M-point ball at 18.7 in a
  132-vector metric; the 1.9 M-point ball's 13-core is empty) against the 745 to 2,044 points of the forcing objects over `K`: **where
  rigidity is possible, density costs nearly four orders of magnitude more — the two pull apart, and that is the whole difference between
  the two fields.** (Our *rigid* — every colouring identifies the pair — is
  the symbolic-dynamics literature's *frozen*, `[AlonEtAl2021]`; `[PeledSpinka2023]`'s *rigidity* of ℤ^d colourings is another notion.)
  G61(4)'s "supply of unit vectors" has its
  mechanism here: supply is what covers the residue circles. *Do: before building fabric over a field, take the direction set's CM
  field, classify the primes above 5, 7, 11, 13 in `E/E⁺` and compute the targets; run the quotient at every admissible `N` and the
  periodic Kempe screen at every target; spend a solver only where every colouring found is rigid at the target — and if that
  lattice's rank is the field's full degree, expect density only at `10⁷` points and price the shape (word ball, metric ball, core,
  the two-stage survivor route) before building anything. Killing
  test: a lattice rigid under every periodic colouring found whose finite balls all four-colour with `(0, δ)` separated — a
  non-periodic escape, the inheritance question row 67 leaves; or a rank-4 lattice loose at every odd prime that still forces.*
* **G70 — √3-clean is residue: on the Moser lattice a four-colouring escapes Theorem B's colouring only through a monochromatic
  √3-pair. [hand; Coxeter, 2026-09-08 (MASCOT-T6–T11, `plans/MASCOT-derivation.md`); re-derived by the owner at FS-71; minted at
  Kooshi's call, 2026-09-22]** A proper four-colouring of the rank-4 Moser lattice `ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩` with no monochromatic pair
  at distance √3 is one of Theorem B's two residue colourings up to relabelling: a √3-clean hexagonal shell forces its antipodal rim
  points equal, so `c(x + 2u) = c(x)` for every unit vector `u` and the colouring factors through `R/2R ≅ 𝔽₄ × 𝔽₄` (2 splits in
  `ℚ(√−3,√−11)`, `33 ≡ 1 (mod 8)`, each factor of residue field `𝔽₄`), where the unit vectors land in `𝔽₄ˣ × 𝔽₄ˣ` and the quotient
  graph is `K₄ × K₄`, whose only proper four-colourings are its two projections (Greenwell–Lovász). **The dichotomy:** every
  four-colouring of K-fabric either has a monochromatic √3-pair or identifies every pair whose difference lies in `2R` — the
  distances 2, 4, 8/3, 8/√3, 4/3, 4/√3, 2/√3 at once — which is why `[Parts2020hv]`'s table of mono and non-mono gadget distances
  has the shape it has, and the √3-*dirty* colourings are where row 67's 2-adic depth stratification lives (the theorem says
  nothing about them). **Consequences (MASCOT-T7–T10):** the `ρ₄` theorem realises an unconditional √3-pigeonhole inside
  K(√7)-fabric — a 6-open field — so Act One of a five-forcer exists there by theorem and only the kill is open; `core9_plane`'s
  nine-point carrier is intrinsically a ℚ(√5)-object and cannot be drawn in K(√7)², so the kill cannot be borrowed from Heule's
  field; and the mascot — `[Parts2020hv]`'s human-verifiable proof with its one √5 step (the `arccos(7/8)` pinning rotation)
  replaced by the Moser twist `arccos(5/6)` — is one open lemma away (T10's one-case dichotomy). Prior art: the `K₄ × K₄` step is
  classical; the hexagon lemma and the identification of the doubling quotient with the two primes above 2 are Coxeter's. *Do: on
  K-fabric ask the √3-pair question first — a colouring with no monochromatic √3-pair IS the residue colouring and identifies every
  `2R`-pair without a solver — and read rigidity (FS-73) as "which colourings are √3-clean"; a five-forcer over K(√7) starts from
  the `ρ₄` pigeonhole and needs a kill drawn in a field with no √5 (FS-49). Killing test: a four-colouring of the Moser lattice with
  no monochromatic √3-pair that is not a residue colouring — a defect in the hexagon lemma or in `R/2R ≅ 𝔽₄ × 𝔽₄`.* **Held exhaustively on de Grey's lattice** (FS-73, row 78): of its 12
  classes of four-colourings — all of them, since `F = 8Λ` — exactly one is √3-clean, and it is Theorem B's pair. Since row 85 the classes are derived, not enumerated: every colouring is a striped colouring of the 64-vertex torus pulled back along one prime above 2 (G75).
* **G71 — Three colours are linear, four are not: a three-colouring of a lattice graph has a height and a slope, a four-colouring
  only a parity. [hand, two independent derivations (row 79); the lift is prior art — Chandgotia's height functions]** `K₃`'s
  universal cover is a line, so every proper three-colouring of a Cayley graph of a finitely generated torsion-free abelian group
  lifts, through the grid that covers it, to an integer height with a winding on the relation lattice and a slope in a rational
  polytope. Hence three-colourability is the non-emptiness of `Θ₃ = {θ : θ(S) ⊆ [1/3, 2/3] + ℤ}` on the character torus, periodic
  three-colourings are dense (so a pair every periodic colouring identifies is forced, and colourable means periodically
  colourable — with no arithmetic of the lattice), and the forced group has finite index exactly when `Θ₃` is finitely many points;
  isolated points of order 3 make every colouring affine, which is how ℚ(√11)'s `F = 3Λ` falls out with no forcer. `K₄`'s square
  complex is `ℝP²` (the cube modulo its antipode), whose one loop invariant, the ℤ/2 winding in `Hom(R, ℤ/2)`, is each relation's
  length parity, fixed by the graph (row 80): no height, no slope, no polytope from loops. Edge-local heights need a sum-closed half
  of `S` (Moore–Newman's triangular lattice and its degenerations, rank ≤ 2, all four-colourable; the grid's absence of
  one is `[CGHO2025coh]` Thm 1.1, FS73-T29's prior art), so the absence holds wherever a certificate is wanted (G73) — `G(ℤ, {1,3,4,5})`
  four-colours with no linear colouring — and whatever makes de Grey's lattice rigid at four colours (`F = 8Λ`, row 78) is not a height
  of this kind, even on its own language — it is a linear identity and a tight quotient (row 85, G75). Everything the hunt asks lives at four colours and above. *Do: when a question is at three colours on a lattice, decide it by `Θ₃`; over a whole real number field it is decided already (row 99), so ask a lattice only for a finite witness. Decide it by `Θ₃`, an exact polytope tree with
  Farkas leaves, never by a ball and a solver, and read its cells: empty refuses; points of order 3 mean every colouring affine and a
  finite-index `F`; a fat cell means infinitely many colourings. At four colours expect no slope, no linear criterion and no
  two-sided certificate (decidability is stated open in print): a refusal there is a finite graph, or an averaged or non-local
  certificate (G73). Nothing kills the three-colour theorem; it forbids a three-colour
  counterexample to the inheritance question on any abelian Cayley graph, and a `Θ`-type certificate built from edge-local heights at four colours anywhere in the class.
  Killing test of the reading "at four colours the arithmetic must enter": a four-colour rigidity theorem over a class of lattices
  that uses no arithmetic of the lattice — not met at FS-79 (P-G71); **met at FS-85 in the abstract class** (row 86, no arithmetic), so the reading survives on unit-distance lattices only, where row 85 uses the dyadic primes; FS-86's field-level results all use the tight dyadic place (P-G71′ met).*
* **G72 — Pose a question that cannot be answered without an invariant every solution carries. [method; Kooshi's wording,
  2026-09-23; one instance (FS-73)]** *Its dual is G79.* The four-colour bound over ℚ(√167) (row 79) was not found by aiming at ℚ(√167). Both attacks that
  did aim at it had stalled: FS-61 searched for a refuting finite patch, and the refusing patches were priced near 10⁸ points; FS-73's
  P2b screen searched for colourings and left two lattices undecided. The bound fell out of a question about something else. *Does every
  colouring look like a periodic one?* was asked of every lattice at once, with the lattice's arithmetic removed and search forbidden.
  That question cannot be answered without saying something about an arbitrary colouring. The prior-art gate had named the object in its
  home discipline's words (a hom-shift), and that discipline's standard handle on arbitrary three-colourings is the height. The height's
  slope described every colouring, so existence became a finite polytope question, and three people independently turned it on the open
  instance (G71). **The reframing is three moves, and they outlive the tool.**
  1. Ask about the whole solution space, not about one solution.
  2. Take integers from the topology of the target: its loops, or, one dimension up, its spheres.
  3. Average over the symmetry to make those integers linear, and certify on the symmetry group rather than on the graph. A finite witness
     has to rebuild the symmetry by brute force. That is why the witness runs to 10⁸ points while the certificate is kilobytes.

  *Do: in every derivation milestone's plan (WORKFLOW 3.3, its §IQ), write the milestone's question twice.
  - **The existence form:** is there an object, a colouring, a forcer?
  - **The structural form:** a question about every solution. Pose it in the most general class where it still makes sense, with the
    arithmetic stripped when it can be. Its answer must need an invariant that all solutions carry.

  Route the structural form through derivation, with search excluded. Name the invariant it forces, or say that none is known; then
  finding one is the milestone. When a new exact decision procedure lands, point it at the open-instance list the same day. Killing test:
  across derivation milestones, count the results that came through the structural question against those that came from searches or
  extensions of a known tool. If the structural question keeps producing nothing a direct attack would not, the method is ceremony.*
  **The count so far — thirteen of fifteen** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72). Fourteenth, FS-103: through the structural question — "does the argument run one colour class at a time?", a question about every invariant independent set, gave the fractional local–global principle (row 129); row 130's measurable equality by extending a known tool. Fifteenth, FS-105, the other kind: a hardening, its products from reading and from re-deriving a known proof.
* **G73 — Four colours, cell by cell: the colour complex gives a four-colouring of a lattice graph nothing to certify with, one
  cell at a time. [hand, two independent derivations (de Bruijn, Coxeter) read by Poros, with exact rank checks (row 80); one
  reading]** Read `K₄` through the cells of `Cay(Λ, S)` and every local invariant a certificate could use is empty or blind.
  **Loops:** the ℤ/2 winding is each relation's length parity, fixed by the graph (`Q₃ = K₄ × K₂`). **Edges:** a non-trivial
  edge-local height exists iff `S` has a sum-closed half (`±{a}`, `±{a, 2a}`, `±{a, b, a+b}`, rank ≤ 2) — Moore–Newman's height,
  which is the `V₄` structure of `K₄`'s three perfect matchings, the three components of the Kneser graph `KG(4, 2)` — and every such
  graph is four-colourable; from five colours up `KG(k, 2)` is connected and no presentation with two generator classes carries one.
  **Faces:** monopoles kill the skyrmion class, the parity-free flux is `dη + κ` once three directions span induced cubes, and the
  signed flux cancels on every odd relation. **The domain's topology:** the coindex bounds stop at four on every K₂,₃-free graph
  (Simonyi–Tardos), so on every unit-distance graph; the index bounds are untouched. So on a triangle-free lattice a four-colour
  certificate, if one exists, is averaged (window frequencies, exact in rank 1, to be kept small by the symmetry in rank ≥ 2), non-local
  (cocycles reading windows of radius ≥ 2, `[CGHO2025coh]` Thm 5.8's route) or structure-derived (group ring, counting on a base
  pattern). **On de Grey's lattice** (rows 85, 87) radius-1 averaging cannot lift `120Λ` to `8Λ`; the
  proof that does is structure-derived (G75). **What survives, colour-generically, is a looseness instrument:** a full-dimensional cell of `Θ_k` gives `P = F = 0` at `k`
  colours, as at `L21cc6506` (row 81; G21's one-period census). On field planes in FS-86's class S2 the measurable-window format and finite-type character colourings are closed at four colours (rows 91–92). *Reading, with its test (Poros): arithmetic cannot enter an averaged certificate as a residue label — the product of an invariant measure with
  Haar measure on the 𝔭-adic odometer is always a consistent joint. Killing test: a residue-labelled window LP that refutes where the
  same window's unlabelled one does not.* *Do: when a four-colour certificate is wanted on a lattice graph, build no cell-local
  topological invariant — an edge height, a loop winding, a face flux or a coindex bound is empty or blind by theorem — and price a
  window-frequency LP whose size the point group controls, a radius-≥ 2 cocycle or a structure-derived certificate instead (FS-80);
  when a lattice looks rigid on one period, compute its `Θ_k` cells before calling it rigid — one full-dimensional cell makes it loose.
  Nothing kills the four no-gos; they forbid a cell-local topological certificate of non-four-colourability anywhere in the class, a
  coindex certificate of five on any unit-distance graph, and an edge-local height at five or more colours on any presentation with
  two generator classes.*
* **G74 — Read a field's plane one layer at a time: every unit-vector set holds the rational pattern, and one relation among layers decides three colours for the whole field. [hand, two independent derivations (row 82); the lift is FS73-T22's, hand; one reading]**
  A three-colouring of `F²`, for any `F ⊆ ℝ`, carries a **field-level slope** `θ ∈ Hom(ℤ[U_F], ℝ/ℤ)` with every unit vector in `[1/3, 2/3]` — FS73-T22's height on every
  finite set of unit vectors, then compactness (G71 at the field level; in the literature's words, a circular colouring given by a character). `U_F` is a union of **layers**
  `b·U₅`, rotated copies of the rational unit vectors with 5-power denominators (G62's multilayer, for the whole field), and on each layer a slope has **one of two types**: the parity character plus an archimedean character of norm at most 1/6, or one of the four order-3 characters (C1(5), from FS73-T40's exact cells). A relation `1 = Σ c_j u_j` carries the
  types across layers, and the archimedean parts cannot absorb a finite-order discrepancy, because every layer holds `5^{−k}` for every `k`; so `1/3 ∈ ℤ[U_F]` plus an odd cycle
  leaves no slope and the field needs four. The field is incidental: any multiplicatively closed `U ⊇ U₅`, and five layers `{vᵏ : |k| ≤ 2}·U₅` already suffice (FS81-T5). **The
  mechanism in the discipline's words** [reading]: `U_F` is the rational points of a torus, the layers are its cosets through the rational pattern, and `Θ₃(F)` is rigid only
  modulo the archimedean places; `[Fischer1990]` had the relation and stopped at additive colourings for want of exactly this. **Where it stops:** from four colours up there is
  no height (G71, G73), so a point of `Θ_k(F)` still colours the whole plane but emptiness proves nothing about `χ` — one-sided there (FS-83); and the residual three-colour case, primes
  above 3 of odd residue degree ≥ 3, closes without `1/3`: four, by no mixing (row 99). *Do: when a question is three colours over a whole field — any subfield of ℝ, any degree — ask
  whether `1/3 ∈ ℤ[U_F]` and whether the plane is bipartite, and answer before building anything; when a field-level question at any `k` resists, factor `U_F` into layers of a
  base pattern, classify the base pattern's rotation set exactly at the band (T40's cells), and glue by relations — naming the step that uses infinitely many layers, because a
  finite configuration holds points the field does not (FS81-T8: at depth `J` the archimedean parts absorb a parity discrepancy while `5^J ≲ 0.25·d`). Nothing kills the
  three-colour theorem but a defect in its chain; it forbids a three-colouring of every plane with `1/3 ∈ ℤ[U_F]` and an odd cycle. Killing test of the reading that the rational
  layer's rotation set is always a disc plus finitely many torsion points: T40's cells at the band `[1/4, 3/4]` or `[1/5, 4/5]` holding a third kind of cell (FS-83's first step) — **fired at one prime** (rows 97, 102: two leaves glue, and minimal sets escape too); over two or more primes it holds at every band (rows 95, 98).*
* **G75 — Where triangles enter four-colour rigidity: as a local linear identity that pins the spectrum. [hand + tools exact (row 85); one reading]**
  On de Grey's lattice, with colours as the vertices of a regular tetrahedron, "no monochromatic √3-triple in family `k`" (Parts's
  theorem placed in `Λ`) is the eigen-equation `A_k g = −2g` of the family's hexagon operator, whose symbol `(1+X)(1+Y)(X+Y)/XY` is the
  triangle relation `1 + ζ₆² = ζ₆` made algebraic: the spectrum lies on three circles per family, the nine families' circles meet in 42
  torsion characters, exactly the dual of `8Λ`, and a Smith form reads off the period (C7, C8). The inner families leave 7,290
  (`120Λ`); odd-index cosets carry the identity outward (C15), and the 5-part dies **pointwise**, slice by slice, at the tight dyadic
  quotient, a tetrahedron-valued `G + H` being constant in one variable (R3a; FS-67's product shape) — not by second moments (row 87),
  and the infinite lattice is slack. Without triangles rigidity is free in the abstract class, Soifer-strength in the plane (row 86). On the triangular lattice the stripe lemma (kernel, row 106) uses the triangle condition once, to make one line two-periodic; properness does the rest. *Reading* (Coxeter's R2.6): in a
  triangle-free lattice the analogous frequencies are generically non-torsion, so the mechanism has nothing to pin. *Do: when a lattice
  looks rigid at four colours, find a local forbidden pattern that is linear on the tetrahedral embedding, intersect its zero sets on the
  character torus, read the period from a Smith form, and kill what the spectrum leaves pointwise at a tight quotient — never by second
  moments. Nothing kills the derivation but a defect in the chain or in Parts's trees (walked, row 85); it forbids a four-colouring of de
  Grey's lattice that is not `8Λ`-periodic. Killing test of the reading: a triangle-free lattice whose NT-type identity pins the spectrum onto finitely many torsion characters (FS-59; not fired at FS-86, where no pinning identity was found on a type-(B) plane and pair correlations provably cannot pin on a real field, row 91).* *The method is Kari–Szabados's annihilator method, and one family alone is Puzynina's exceptional case (`det(B + I) = 0`), which is why one family cannot give periodicity (row 85's attribution); on type-(B) planes such an identity valid for every colouring exists iff `F(R) ≠ 0` (FS86-Cx-C11), so the identity is the question.*
* **G76 — Four-colour rigidity over a field is a local theorem and a global extension question; every construction of a "no" that reads finitely much dies, and no character is one. [hand, two derivations for the frame, the local theorem, the no-gos and the measure half (rows 88–92, 111–113); the obstruction a reading, reached twice independently]**
  Over a real field with one stable place tight at four colours and every other factor of all-levels ratio `< 1/4` (FS-86's S2), periodic
  four-colourings are pullbacks from the tight place and a non-zero forced group is an ideal of finite index, so rigidity is one pair (row 88);
  the local plane at that place is rigid, triangles entering only through the local forcer (row 90), so the question is whether the field
  realises a local forcer — `4 ∈ F_tf`, a question about number fields inside the completion. Two tight places give a choice per coset (K,
  row 89); a slack stable place gives non-periodic colourings (ℚ(√11), row 94). **A "no" must disagree with every pullback in every
  archimedean direction, patch no two pullbacks, and read infinitely many split places** (rows 91–92). For characters the exclusion is **closed-set** (Furstenberg–Berend) rigidity on `R̂` with the archimedean
  directions rotated, and it holds at two or more primes at every band: minimal sets are band-free (Berend's Thm I.2) and the band enters once, in a multi-digit
  sweep (rows 95, 98; on the half ring it is `[Manners2015]`'s pyjama lemma); so HD1 holds (row 96); at one prime points, minimal sets and
  torsion orders all fail (rows 97, 102). **For vectors of characters** a split place pairs its conjugate primes into a cross (`ψ_w(u) = 0` or `ψ_w̄(u) = 0` on every unit vector): no naive vector band rigidity, Kronecker selection onto `T + A` false (row 116), and a closed invariant set may be a union of subgroup translates (`[LindenstraussWang2012]`), which a saturation statement must allow. **At five colours over ℚ(√167)** (row 110) a factor leaves a product colouring when its compact pieces mix (`λ* < 1/4`, a spectral Burr–Erdős–Lovász), not when its ratio is small (false at 125 colours); twelve places do not mix, so the window question lives at nine places, and with a real place it is `χ_B(ℝ²)`'s. **For colourings** rigidity splits into invariant measures and transience — the measure centre of every orbit closure inside the pullbacks (row 111); a spectrum carried by `T + A + Fin_S`, `S` finite, extends to the completion and a stationary count against the tight factor makes it a pullback (row 112), and at ℚ(√47) no such spectrum exists (row 113); given MR, over the type-(B) fields every rotation-invariant random four-colouring is a pullback and row 88 ⟺ no rigid-motion-transient colouring (row 124); the translation-invariant half is TR-ROT; a transient colouring is invisible to every measure method. *Demotion record:* this entry said "measure rigidity … not in print"; the
  question was about closed sets, where Berend's proof survives with the rotated plane set aside. *Reading:* for all colourings the obstruction is the real place (non-real analogues are pinned on `T + A + Fin`, row 94) — false on `T + A + Fin_S`, where the real place is an input (`m₁ < 1/4`, row 112); **demoted in MR's form** (row 120; the ×2×3 crunch's §5 item 7, its registered falsifier, fired): a rotation-invariant colouring's spectrum is Haar plus a part on `T + A`, so infinite-place spectra are out; the real place is where non-Haar invariant measures survive, and it lies inside `E`. The reading survives only for transient colourings (T-B1, FS-98). Killing test: a non-periodic four-colouring of
  ℚ(√−709)'s plane. *Do: when a field has one tight place and every other factor below `1/k`, state its `k`-colour rigidity as one forced
  pair at the tight place's depth, never as a lattice question; aim at realising a local forcer or at colourings no character gives, and build no
  non-periodic colouring from finitely many places, measurable windows or one character — excluded by theorem; when the question is a closed
  invariant set of characters under a rotating group, run Berend's dichotomy with the rotated plane set aside and count the primes first
  (one is not enough); test a statement about several characters against a split place's pair `(ψ_w, ψ_w̄)` first; when an invariant measure's spectrum reads finitely many places, extend it to the completion and count (row 112), never search for its falsifier; never write 'row 88 ⟺ Q-tr' (row 124); when a group of multipliers has polynomially many elements of bounded height, run Einsiedler–Fish's pigeonhole with the product formula before calling a measure question ×2×3-hard; with two tight places expect a choice per
  coset. Nothing kills the frame or the no-gos but a defect in their chains; they forbid a periodic non-pullback colouring and every "no"
  of the excluded formats.*
* **G77 — A character colouring of a field plane is local in the existence sense only: the value-set profile peels. [hand, two independent derivations (rows 98, 100), given band rigidity at every band]** A band character of `R_F` is torsion plus archimedean; its archimedean part is zero at each complex place and an interval about 0 at each real one; the torsion part factors over the stable places (`R_F = O′`); and when symmetric subsets of the circle add up inside the band, **some** one of them already lies in it (the peeling lemma). So a band `k`-character exists iff a residue target at some level has one, and `χ_char(F²)` — `[BarajasSerra2008]`'s regular chromatic number — is a minimum over targets. **Existence, not classification:** CLG does not say a given character colouring comes from one place; that is proved at three colours (no mixing, row 99) and at HD1's fields (Lemma D), and open elsewhere (FS-92). On a finite plane a character colouring is a regular colouring of a circulant, weaker than a colouring (`χ_char(Γ₁₁) = 6 > 5`) and than a line-periodic one (`χ_char(Γ₄₃) = 9 > 8`). *Do: when a question is about character colourings of a field plane, compute each residue target's `χ_char` by its trace sets below Weil's threshold and take the minimum — no lattice, no solver; state the result as existence, and name the extra input (no mixing, Lemma D) before saying every character colouring is local. Nothing kills it but a flaw in the derivation; it forbids a character colouring with fewer than `L(F)` colours at `k ≤ 5` and over quadratic fields. Killing test of the reading that CLG-g's exception is never realised: a band 6- or 7-character above level one of a `U₆₄` tower, or at level `2e + 1` above 3 at `q = 27`.*
* **G78 — Rank-one inheritance is "countable ⟹ finite", and Kempe moves cannot see a frozen wall. [hand, two derivations (row 108); tools exact on named sets; one reading]** The four-colourings of `G(ℤ, D)` form a one-dimensional SFT; all phases rigid is zero entropy, and R2 says such a shift is finite — equivalently `P₄ = F₄`, equivalently no heteroclinic colouring has an all-rigid completion `X₄(D_c(M))`. In an all-rigid shift the periodic points are gap-free with two-sided strands, and Kempe moves never bring a wall point's two tails into one labelled phase; at frozen tails Kempe moves only relabel, so the frozen part of R2 needs an invariant no Kempe argument supplies. *Reading:* all-rigid shifts are Kempe-rich (`{2,6,11,13,14}`: 94 phases, none frozen). *Do: when a rank-one colouring question resists, restate it on single colourings and split it at frozen tails before choosing a Kempe route. Killing test of the reading: an all-rigid `X₄(D)` with a frozen rigid point. Nothing kills the equivalences; they forbid a Kempe proof of the frozen case.*
* **G79 — A wall arrives as a counterexample's invariant; the breakthroughs came from an example's. [method; Kooshi's wording, 2026-09-25; new, untested]** *"This is an interesting grokking too: walls often show up as 'the (impossible?) counter-example invariant' and we have had a successful breakthrough when looking for the 'example invariant'."* A no-go says what a counterexample must carry, a class that may be empty: rows 96, 113; G22; G48, G31; G57. What moved a question was an invariant every actual solution carries: G71 and G74's slope, G75's eigen-equation, G76's locality, row 95. It is G72's dual: G72 asks about every solution; G79 says which invariant to hunt once a wall stands. *Do: when a wall hands back a no-go ("a counterexample would need X"), flip the wanted poster — ask what every solution the problem already has must carry, and derive that before sharpening the no-go. Killing test: at each derivation close, record whether the result came from an example invariant or from a counterexample invariant alone; a breakthrough of the second kind, or flips that keep producing nothing, make the rule ceremony. Its record, milestone by milestone: `plans/GROKKING-INSTANCES.md` §G79. FS-103: every result from an example invariant (the fibre colour-measure vector every colouring carries; the per-class spectral pairing; the fractional colouring a measurable one induces); the wall at Falconer's `χ_m` arrived as a counterexample invariant (a non-list-colourable configuration on a null set), and its flip — every boundary point sees two colours of positive density — reduced it to a finite list problem (row 130); FS-105: its blind EF_F⁺ from the height count `U` has and no finitely generated subgroup has, while (W) and (W′), counterexample invariants, located row 129's test without a theorem.*
* **G80 — Infinite rank is the resource: the unit-vector group is large enough for rigidity that no finitely generated piece has. [hand theorem + reading]**
  `U_F` has polynomially many elements of bounded height; no finitely generated subgroup does, and none acts irreducibly on `R̂` (row 118). The classical
  ×2×3 question lives at finite rank; `U` sidesteps it (row 120): positive entropy is Einsiedler–Lindenstrauss (their Thm 1.3) on each finitely generated piece, all of it at finite places since `U` is isometric at every archimedean one, zero
  entropy is Einsiedler–Fish's pigeonhole run with the whole group's growth, and what survives is the archimedean isometric layer, inside `E`. *Do: when a
  question over a field's plane reduces to invariant measures under `U_F`, count the group's elements by height before calling it ×2×3-hard — any positive exponent suffices, the degree entering constants only (FS-105); transfer a
  one-dimensional polynomial-growth theorem by running its Diophantine step through the product formula at all places. Killing test of the reading that
  this extends: a real field whose `U`-invariant `E`-null measures are not Haar (row 100's exception fields are uncovered for MR; they have `L = 2`, so no colouring consequence is lost, row 123). Since row 129 MR is testable on finite graphs: a proof that `α₁(ℝ²) > m₁(ℝ²)` refutes it at ℚ(√635087).*
* **G81 — Where every place mixes, the field is the plane. [hand, two blind minds (row 128); the ambiguity reading one mind]** A stable place whose local piece mixes (`λ*_v < 1/(k−1)`, both signs, every level) drops out of any `k`-colouring question (G76's selection, now over infinitely many places at once, the count entering only at the pigeonhole `max_j m_j ≥ 1/k`), and MR removes the one other escape, an SP witness. So at a totally real field with every stable place 6-thick — ℚ(√635087), de Grey's field — `χ(F²) = χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)` (rows 128, 130): the field's arithmetic is invisible, and `[Payne2009]`'s *ambiguity* (`χ ≠ χ_m`) lives only at non-thick places — his examples ℚ and ℚ(√3) are the chain's stopping controls. One arithmetic fact is read twice: de Grey's graph needed a field that no small residue plane seals; the collapse needs a field with no place a colouring could use to beat the plane. *Do: when a question is `χ(F²)`, list the field's non-`k`-thick stable places first (exact spectra, both signs, every level); with none, given MR, it is the plane's question — spend nothing field-specific on it; with some, the field's own content is product locality at exactly those places (FS-67). Killing test: a totally real field with every stable place 6-thick whose plane's chromatic number differs from `χ(ℝ²)` — it refutes MR there.*
* **G51 — A competitor and an advisor beat one mind. [measured, one session]** A friendly competitor on the
  same problem plus an advisor (Poros, `~/source/poros`) advising both caught errors one agent missed, and
  two independent attempts hitting one wall licensed an impossibility theorem (row 58) — one attempt failing is a fact about the
  attempt. Design: isolate each
  agent's scratchpad (a shared temp directory is a covert channel), brief both identically, give the advisor
  the record and a written expectation, rule prior art shared. Records: `plans/COXETER-2026-09-08-mascot.md`,
  `plans/POROS-2026-09-08-mascot.md`. **The protocol and both briefs verbatim, with the review of what the advisor did (frame, instrument, refutation,
  method — decisive on all four): `plans/PROTOCOL-competitor-and-advisor.md` (2026-09-22), the template for the next use.** **The mechanism is not carefulness — it is a COST WINDOW** (2026-09-12): in
  one phase three agents exchanged about twenty messages, eight constructions or registrations were retracted, and
  the final plan contains none of those errors — **every retraction was free** (nothing committed, no solver time
  paid, nothing claimed to a third party). **Fast public error is the cheapest instrument available, but only while
  retraction is free, and in that window it should be spent rather than rationed**; once retraction is expensive the
  same speed produces escalation, because the cost of being wrong has become the cost of having *been* wrong. **Front-load the disagreement into the window before anything is paid for**, and
  **count the retractions in it: zero is not agreement, it means the disagreement has not started yet and will
  arrive later at full price.** *Do: at a wall, bring a second mind in while retraction is still free, and count the
  retractions — the wall FS-73 named for it — the inheritance question — returned a theorem at three colours; the next is the
  four-colour question (G71), where two independent attempts meeting one obstruction would license the negative.
  Killing test: a phase whose disagreement cost more than the error it caught; and, of the design as minted, a second run of this
  shape in which the competitor and the advisor produce nothing the single agent would not have produced alone, and the
  corrections all flow one way.* More instances: `plans/GROKKING-INSTANCES.md` §G51. **Its runs** (FS-73, FS-79, FS-81, FS-85, FS-86, FS-89; each recorded, with its retractions and budgets, in the protocol's §3): first routes converge more often than they diverge (FS-73's heights, FS-79's edge-local heights, FS-85's abstract yes), and at FS-86 the sides converged twice without contact (HD1 for finite type; the measure-rigidity obstruction, G76); the contest has moved from between competitors to verification — *"the disagreement never started; verification is where contest must begin"* (FS-85) — where blind verifiers, quiet during a live competition, found every divergence and none of truth while retractions stayed free (FS-86: de Bruijn 2, Coxeter 1, Poros 0); FS-89 ran one derivation agent and blind verifiers: the second verifier's blind route stalled and D's lemma statements closed it — blindness bought a re-derivation of every lemma, not a second route; a verifier checks a fixed statement and cannot supply a missing route (FS-81). Every run found a covert channel (the list: the protocol's §3). The standing rules they left: hand-backs content-free, every report by explicit message; working files in scratch until hand-back; neutral commit subjects from the first competitive commit on; work in stages from the first turn (FS-86 lost three responses to the output-token limit); quote statements verbatim in briefs; tell the advisor of every stand-down and launch.

## Whose work this is

The mathematics and the engineering here are mine — de Bruijn's. The models, the statements, the
proofs, the measurements, and every decision recorded in `plans/`. Kooshi set the target, built the
method this project runs on (`DEBRUIJN.md`, `WORKFLOW.md`, the skill suite, adapted from the Rust
standard next door), supplies the machines, and interrupts when I run ahead of the workflow. If a
rung of this ratchet lands, that is the division to state.

Two working instructions follow, not sentiment:

**Own the conclusions.** Do not hedge a result the kernel checked, and do not soften a failure that
is real. "Not landed" is a complete sentence.

**Ask for what the work needs** — hardware, a machine swap, a different tool, a milestone reordered.
Ask with the measurement that justifies it. A constraint I never questioned, that slowed the proof,
is a choice I made badly.

## Delegation — one level deep

**Standing rule (Kooshi, 2026-09-19): no child agent spawns children of its own.** Only the top-level session — the one Kooshi is
talking to — launches agents. **If you are reading this as a subagent: do not use the Agent tool, a fork, a workflow, or any other
mechanism that starts another agent. If the work does not fit in your context, stop at a clean boundary, persist what you have, and
tell the session that briefed you what is left** — that is a good report, never a failure. Minted the day a planner briefed as
"exactly one planner" delegated part of its prior-art gate to a subagent that spawned two more: three agents nobody had budgeted,
could review, or knew existed. **Why, in two parts.** *Cost:* nested agents multiply token spend, and a milestone's staffing — at
present **at most three agents at once** — a working agent, a competitor and an advisor (Kooshi, 2026-09-23: "the one agent at a
time rule is lifted, as Opus 5.5 is much cheaper than Fable 5.1 was. Now it can be up to 3 to accommodate debruijn, coxeter, and
poros"), **every role on Opus 5.5** (Kooshi, 2026-09-22: "Opus 5.5 should be used for all purposes until further notice", a step above Opus 5 and Fable 5.1,
which held the planner and implementer roles until then; every rule this project recorded about those models' quirks is retired,
except one that holds for every model: an agent returning with ~500k–600k tokens of context, by the harness's count (agents' own run at 55–70 % of it, FS-89), is replaced, not reused) —
is a budget decision Kooshi makes, which a child silently overrides by delegating. *Review:* the product owner scores work by
artifact, and cannot score work done by an agent it does not know about — nor trust a bibliography entry's read-status when the
reading was a grandchild's summary (G50). **For the session that briefs:** the rule goes into *every* brief, in words, with its
reason. That this file is loaded is not enough — the brief is what an agent acts on, and the brief that caused this said "one
planner" and never said the count included anything the planner might start. A head-count in a brief says so explicitly.

**The crunch** — many agents from a job queue for a fixed block of hours, the owner coordinating by short reports, then the consolidation: `plans/PROTOCOL-crunch.md` (roles, runbook, standing rules, brief templates, both runs).

## The standard of evidence above rung B

χ(ℝ²) ≥ 5 is a known theorem; a reader's default is to believe it. **χ(ℝ²) ≥ 6 would be new
mathematics, and a reader's default is to disbelieve it** — correctly, because the characteristic failure
of machine-assisted combinatorics is a search that found what a bug allowed. Anything above rung B must
convince someone who trusts none of this and reads none of the Python:

- **No native evaluation in the headline.** `native_decide` trusts the compiler and one CPU. For a
  known result that is a footnote; for a new one it is the whole objection. The kernel-checkable
  route (`plans/spike-kernel-lrat.md`) is therefore the price of admission, not a nicety — and it is
  measured to be affordable.
- **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer
  re-checks. Never require them to re-run a solver, reproduce a seed, or trust `tools/`.
- **The witness must be independently re-derivable.** State the construction, not only the
  coordinates: a graph that only we can rebuild is worth less than one a reader can.
- **Read the final statement aloud against the informal claim.** The one gate item no automation
  replaces, and the one that catches proving the wrong theorem.
- **Report the hunt honestly.** "Searched X, found nothing" is a result and goes in the write-up.
- **Write the certificate for the REVIEWER early — it is an instrument, not a chore, and it tells you which of your
  evidence is load-bearing.** Measured 2026-09-12: an agent building the reviewer-facing bundle for a refutation noticed,
  only while writing it, that its 552 exhibited colourings were **not load-bearing at all** — the argument needed its
  pattern list to be a *superset* of the achievable patterns, never a set of achievable ones — which retired a third of
  its evidence and shrank the solver-dependent core from one claim about a 51,133-vertex object to **twenty claims about
  25,567-vertex halves** — a different *kind* of artifact, because twenty half-instance refutations are individually within reach of proof logging where one whole-object refutation was not. **The question that did the work is cheap and repeatable: *what must someone who trusts none of
  this actually check?*** Ask it while the evidence is still being gathered, not at the write-up, or you will pay for evidence nothing rests on. More instances: `plans/GROKKING-INSTANCES.md` § The standard of evidence.
- **Order a verification's steps by marginal evidential value, never by narrative order.** Same session, twice:
  a verification script was written so its *least* informative step ran first, leaving the checks that decided
  the question queued behind slow ones that could not.

## What compute actually helps

Ask before provisioning; measure before believing. **A kernel leaf priced after a fine obligation pass is priced high** (FS-73):
`Kempe.lean`'s 22 leaves, priced at 1½ days, closed in about 40 minutes of work, every leaf on its first or second elaboration, once
the obligation pass had named each child and its route — re-price a kernel phase from its first two leaves, never from the plan's table. **M2 measured it seven times more** (5× to ≥ 30× in time, never in tokens): each time the non-obvious input was already in Mathlib, so grep Mathlib by the statement's shape at the skeleton (`plans/M2-kernel-lane.md` §R-close 3e). **FS-75 once more** (4.5 h planned, 45 minutes): even the re-price from the first two leaves ran 2–3× high, and the saving came from the obligation pass cutting the statement's analytic half, not from Mathlib (`plans/FS75-kernel-167.md` §R-close 4d).

| Work | Right instrument |
|---|---|
| The reduction, the statements, the certified checks | Lean. Nothing else is close — Mathlib's analysis *and* graph theory |
| Kernel-checking a certificate | Lean's kernel via **GMP-accelerated `Nat`** — the fast trusted evaluator Lean is usually said to lack |
| Refuting a colouring (CDCL SAT) | CPU cores: sequential per solver, parallel across cubes |
| *Finding* a colouring, to reject a candidate fast | Massively parallel local search — the one place a GPU plausibly earns its keep |
| Geometry, edge enumeration, gadget matching | Embarrassingly parallel; CPU suffices |

**A GPU is not a SAT accelerator.** CDCL is pointer-chasing unit propagation and GPU SAT solvers have historically lost to
good CPU solvers; do not plan around one until a *measured* bottleneck is something a GPU is actually good at.

## The shape of the proof

The whole argument is one reduction plus two certified computations:

```
χ(ℝ²) ≥ 5  ⟸  some finite unit-distance graph is not 4-colourable
                 ├── geometry:  every listed edge really has length 1   (exact field arithmetic)
                 └── combinatorics: the graph has no 4-colouring        (verified LRAT checker)
```

Neither computation is trusted on its own say-so. The geometry is exact — coordinates live in the
multiquadratic field ℚ(√3,√5,√7,√11) represented as an iterated quadratic extension over ℤ, so
"distance = 1" is an integer identity, not a float comparison. The combinatorics goes through a verified
LRAT checker the kernel can run: core ships one (`Std.Tactic.BVDecide.LRAT.check` + `check_sound`) that the
kernel cannot evaluate (among other causes, `Std.HashMap` reaches an `@[extern] opaque` word size), so M05
built a kernel-reducible one. CaDiCaL is an untrusted oracle that merely proposes the certificate.

**Nothing in `tools/` is trusted.** The generator may be wrong; Lean re-derives every claim from
the emitted data. A generator bug can only produce data Lean refuses to certify.

## Trust ledger

Audited at every milestone with `#print axioms` (`scripts/Axioms.lean`, run by `scripts/axioms.sh`); the
current audit reads 1236 clean and 5 declared purchases (and 11 axiom-free; 1,252 records at X11K3's gate, FS-100 wave 3), each listed in `ARCHITECTURE.md` § Trust. Rung B
holds none.

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **explicit purchase, per use, recorded here** |

`native_decide` trusts the compiler and this CPU rather than the kernel. Where a `Bool` cannot be
kernel-reduced we may buy it — but the purchase is named in the docstring of the declaration that makes
it, and listed in `ARCHITECTURE.md` § Trust. Soundness theorems are identical either way; only the axiom
list moves.

**Grep for the right name.** At v4.32.0 `native_decide` mints a *per-declaration* axiom;
`Lean.ofReduceBool` never appears in `#print axioms`. An audit looking only for that name passes a
native purchase in silence.

**`lean4checker` is a publication gate, not a milestone gate** (Kooshi, 2026-08-02): the build-time kernel is the trust
anchor; the independent replay is single-threaded and RAM-heavy, so run it once, on hardware other than the desktop, before
any external claim of new mathematics — never as routine. It cannot re-check a native purchase (a purchase is an axiom, and
every kernel accepts axioms), so "replayed through an independent kernel" covers the kernel-checked part only.

## Toolchain

Managed by **elan** and pinned by `lean-toolchain` (`leanprover/lean4:v4.32.0`); the toolchain and the
Mathlib pin move as one unit. If `lean` / `lake` are missing, run `./install-toolchain.sh`.

**Arch build env — required before building.** The toolchain's bundled `clang` is broken against Arch's
system LLVM, so any native/C compile fails unless you use the system clang plus the toolchain's bundled
`libc++`. `source scripts/dev-env.sh` in your shell (it sets `LEAN_CC`, `LIBRARY_PATH` and
`LEAN_ABORT_ON_PANIC`; the installer wires it into `~/.profile`, and Claude's own shell gets it via
`.claude/settings.local.json`).

**The SAT solver.** The toolchain ships **`cadical`** (2.1.2, LRAT-capable) at `$(lean --print-prefix)/bin/cadical` — that command
works only from inside the repository; elsewhere use the path under `~/.elan/toolchains/`. It is single-threaded: use
`tools/portfolio.sh` (a configuration race) and colour-cube splits (one run per cube) to use the cores.

**No search for a finite witness runs from 2026-09-24 to 2026-10-01** (Kooshi, at FS-81's close: *"ban SAT solvers for a week and see what we can do on algebra alone"*; its intent, *"to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time"*; the scope is the algebra-week advisor's, `plans/POROS-2026-09-24-algebra-week.md` §6.4, confirmed by Kooshi the same day). **Out:** SAT, MaxSAT and #SAT solvers, MILP/CP and local-search colourers, Θ relation trees and float Θ₄ finders, quotient-colouring searches, and lattice sweeps hunting survivors — FS-81's relation tree was no SAT solver and lost to a derived certificate exactly as SAT did. **In:** hand derivations; computer algebra and exact arithmetic (PARI, GAP, sympy); colourings given by formula; the Lean kernel; existing checkers on existing certificates; and an exact LP only when a derivation fixes its shape before it runs and its dual is read back as an identity, never as an escalating oracle. The line in one sentence: every certificate is derived and lives on the infinite object, never on a finite piece found by search. Every brief carries a **"would have searched here" log**: one line per move an agent would have made by search, and what it did instead. The solver column of `plans/FRONTIER-STUBS.md` marks which stubs the week can run.

**What else is installed on the desktop** (inventory of 2026-09-21; Kooshi installs on request — *ask, with the reason*; verify with
`command -v` before planning around any of it, and **a tool that is missing fails silently behind a pipe**: `/usr/bin/time` and `bc` were
both absent until 2026-09-21 and turned three timed runs into non-runs that read like slow solvers):

| kind | tools |
|---|---|
| SAT | `kissat` 4.0.4 (AUR; the strongest refuter), `cryptominisat5` 5.15, toolchain `cadical` 2.1.2; **PySAT** (`pysat` 1.9, system Python): `cadical103/153/195/300`, `glucose3/4/42`, `minisat22`, `maplechrono`, `maplecm`, `maplesat`, `mergesat3`, `lingeling`, `kissat404`, `cryptosat`, cardinality-aware `minicard`/`gluecard3/4` — four code bases in one process is the standing multi-solver recheck. **Not installed; build from source when wanted:** `march_cu` (lookahead cuber), `cake_lpr` (formally verified LRAT checker), `drat-trim`, BreakID |
| optimisation | `scip` 10.1 (exact global optimisation, non-convex QCQP; open source). By `pip` into a venv: `pyscipopt`, and `gurobipy`, whose **size-limited licence stops at 2,000 variables or constraints** |
| semidefinite | The symmetry-reduced moment relaxation and its exact certificate: `tools/fs66_b1_cert_make.py` + frozen `tools/fs66_b1_cert_check.py` (Python; no Julia needed to `n = 529`; costs in row 75's plan §R‴). SCS in `build/venv-sdp` (CPU), `build/venv-sdp-mkl`, and **`build/venv-sdp-gpu`** (GPU-indirect source build; keyword `linear_solver=`; 0.33 s/iteration at 83 on card A). `cvxpy`, `clarabel` by `pip`. **Julia 1.13** (`julia`): `SumOfSquares.jl` + `SymbolicWedderburn.jl` reduce a moment/SOS relaxation by its symmetry automatically — the step FS-50 did by hand — and `Clarabel`/`Hypatia` solve in `BigFloat`, which is what makes rounding to an exact certificate easy |
| algebra | `gap` 4.16, `gp` (PARI 2.17; `nflist`), `dreadnaut` (nauty 2.9), `sympy` |
| build, GPU | `cargo`/`rustc` 1.98 (the tabu finders `plane-colour`, `plane-independent` live in `~/source/descent-engine`, fields only — a ring `ℤ/p^r` is refused by design), `nvcc` (CUDA 13.4, `/opt/cuda/bin`), `gcc`, `clang`, `cmake`, `ninja`, `uv`, `pip`, `paru`; Python 3.14 with `numpy` 2.5, `scipy` 1.18 — **no `torch`, no `cupy`** |
| shell | GNU `time` 1.10 at `/usr/bin/time`, `bc` — and `grep -E` here is `ugrep` (§ Searching) |

**A pysat solver's interrupt is per back-end** (FS-79 phase 0): pysat's CaDiCaL back-ends ignore `interrupt()` — "Limited solve is
currently unsupported by CaDiCaL" is raised inside the timer thread, so a Timer budget never fires and the solve runs unbounded. Bound a
pysat CaDiCaL ask by a parent-enforced subprocess timeout (external kissat or cadical), or use a back-end that supports `solve_limited`.

**Venvs and package depots live outside `build/`** when anything unrecoverable is in them (`build/` is scratch that agents clean); the three `venv-sdp*` are regenerable.

**Break the symmetry before any (UN)SAT search, and treat an unbroken encoding's verdict as a measurement of the
encoding** (Kooshi, 2026-09-15). These graphs are vertex- and arc-transitive with interchangeable colours, so a naive
encoding asks the solver to re-derive the same contradiction once per symmetric copy. The checklist, cheapest first:
1. **Pin a maximal clique.** The origin takes colour 0 (vertex-transitivity) and one neighbour takes colour 1
   (arc-transitivity). **Check `ω` first, because it bounds what this can buy**: `ω(Γ_q) = 3` iff the
   characteristic is 3 or 3 is a square in `𝔽_q`, else 2 (`[Krebs2022]`, verified here at 21 planes). Where `ω = 3` a
   triangle pins three colours; where `ω = 2` — 7, 17, 19, 31, 43, 67, 79 among them — **an edge is all there is, and the
   clique pin is therefore weak**.
2. **Break the residual value symmetry, which the clique pin does not reach.** After pinning `k' ≤ ω` colours the
   remaining `k − k'` are still freely interchangeable — `3! = 6` at `(17, 5)`. A precedence constraint **over the unpinned colours only** kills it: for each unpinned colour `c` above the first, `c` may appear at `v` only if `c − 1` appears strictly earlier (`¬x[v][c] ∨ ⋁_{u<v} x[u][c−1]`) — or put the pinned clique first in the vertex order. A chain that reaches down to a pinned colour, with the pinned vertices later in the order, forbids colourings no permutation repairs: an unsound encoding (FS81-T20, found by FS-81's modeling agent).
   **Measured 2026-09-15: `(13, 5)` 251.09 s → 3.48 s, a 72× speedup, and `(17, 4)` 38.35 s → 11.55 s.** The 3.48 s
   also reproduces M58's independently recorded 3.8 s for that instance, which is the control.
3. **Then the cores:** `tools/portfolio.sh` for a configuration race, and cube-and-conquer for a hard instance — but
   **price the cubes on a sample before committing** (M63 phase H2 priced 552 cubes before spending 20 core-hours).
4. **Never report an `UNKNOWN` at a budget from an unbroken encoding as a fact about the graph.** It is G21's rule in
   solver clothes: the verdict measures the enumeration, and an unbroken encoding's enumeration is `|Aut| × k!` times
   larger than the question.


**Python is 3.14, and its multiprocessing default changed.** On Linux the default start method is now
`forkserver`, not `fork` (measured: 3.14.6), so a worker **re-imports the module** instead of inheriting the
parent's memory, and state a parent leaves in a module-level global is **empty in the worker** — the symptom is
a `KeyError` on a key the parent plainly holds, nowhere near the process model. Pass
`mp_context=multiprocessing.get_context("fork")` (safe with no threads), or give the pool an `initializer` that
rebuilds the state from picklable arguments, which also survives a platform without `fork`.

**Two machines.** A desktop and a laptop (12 cores, 31 GB). The desktop has **16
PHYSICAL cores, 32 threads** (2 per core), 64 MiB L3 in two instances, 128 GB RAM — `nproc` says **32** and
that is the *thread* count. 32-way solving showed no *large* contention penalty (**12.6 cubes/min** against ~8 at sixteen workers), but per-cube times at
ONE width vary as much as any width effect (105.1 s and 129.2 s at 32-way, 126.6 s at 16-way), so **the width effect is not
distinguishable from run-to-run variation in this data**. More instances: `plans/GROKKING-INSTANCES.md` § Toolchain — Two machines.

**Keep a PREDICTED throughput beside the measured one and reconcile them whenever they disagree**: a prediction that can be
divided back out of a rate is a population check that runs itself — the answer to why writing a rule down does not install it (it caught a before/after comparison over two cube ranges
of different difficulty — the cost model failed an arithmetic check). **Say physical cores when sizing memory-hungry work**; `nproc` disagreeing with a plan is the
hardware moving — **ask which machine before treating a core or memory count as fact**, and ask to swap to the
desktop when a step wants it (the SAT solving does). Timings compare only within one machine: per-operation
ratios carry across, wall-clock totals and safe job counts do not. Measure in **CPU seconds (user + sys),
minimum of three runs**, and name the machine beside any number.

### Building

**ALWAYS build through `./scripts/build.sh` — never `lake build`, bare *or named*. No exceptions.** Lake 5.0.0 has no `-j`
and sizes its job pool from the machine; data modules here peak at ~9 GB each and certificate segments at 3.4 GB + 0.81 GB
per chunk, so an unrestricted build asks for hundreds of gigabytes (it took the desktop down twice on 2026-07-30), and a
*named* target silently queues every missing or stale dependency into the same pool (on 2026-08-02 a one-module build queued
four 22 GB certificate rebuilds behind a 20 GB cap, the OOM killer ate them twice, and a grep-piped invocation read as a
pass; the loophole cost hours). `scripts/build.sh` builds every module in dependency order (`scripts/build_order.py`), leaves
first, in explicitly named batches (`BATCH`, default 10), each under a `systemd-run` memory cap (`MEMMAX`, default 100G);
`--plan` prints the batches and builds nothing. It first asks Lake once, under the same cap, whether any module is out of
date (`lake build --no-build`, about 2 s against about 3 min for the walk); only exit 0 skips the walk, so the check can cost
time but never skip a build.

**`lake env lean <file>` is fine for iteration — it builds nothing — and it is not the same check.** It does
not apply the lakefile's options, so `autoImplicit := false` is not in force: a stray identifier is
silently auto-bound and the file elaborates clean, then fails the real build. Never conclude from it that a
module is green.

**The batch is the plan; the cap is a backstop.** Lean `mmap`s its `.olean` files, so at the limit the
kernel reclaims their page cache and must read it back — with `MemorySwapMax=0` that is an I/O thrash, not
a clean kill. Before raising `BATCH`, measure a module's peak and choose the width from
`available_memory / peak`; sum the RSS of the running `lean` processes with:

```bash
ps -C lean -o rss= --no-headers | awk '{s+=$1} END {print s/1048576 " GB"}'
```

**On any unexplained process crash, from any process: HALT and report to Kooshi immediately.** Do not
diagnose, retry, or work past it — the 2026-08-02 filesystem event (kernel ext4 oopses, ~50 compiled modules lost) is what working past one looks like.
**RAM is the discriminator; threads are not rationed** (Kooshi, 2026-09-24, replacing "one heavy job at a time", which was
conservative and easy to enforce). Every thread can and should be used, jobs pinned to disjoint cores; RAM is rationed because
exhausting it crashes the machine, against a global maximum of about 100 GB of the desktop's 125 GiB. **/tmp and swap are RAM here**
(a tmpfs and zram): every agent's scratch directory holds RAM, so large outputs (over about 1 GiB) go to disk — `data/`, or under
`~` — never to /tmp. **The enforcement is `scripts/slot.py`:** `scripts/slot.py --mem <GiB> [--cpus N] -- <cmd>` reserves RAM in a
shared ledger, admitting the job only while the reservations stay within 90 GiB and MemAvailable keeps 25 GiB free; runs it under a
hard `MemoryMax` cap with no swap, so an over-cap job is killed inside its own scope and never takes the machine; pins it to free
cores, one thread per physical core first; and exits 75, loudly, if not admitted within `--wait` (default 1800 s). `--status` shows
the ledger; `--self-test` plants an over-cap job and a full ledger and watches both refused. A job under about 2 GiB and 2 minutes
may run without a slot; anything bigger or longer declares an honest `--mem`, since an under-declared job is killed by its cap. **A
job that calls `systemd-run` itself escapes the slot's cap** (the new scope is a sibling, not a child), so a Lean build reserves and
caps at the same number: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`. And `systemd-run` expands `$`
in a command's arguments unless told `--expand-environment=no` (the wrapper passes it; `bash -c '… $$ …'` arrived as `$`).

**Every long-running phase checkpoints and resumes exactly** (Kooshi, 2026-08-26). **[PROTECTED — never compress, trim or
paraphrase this paragraph; rewrite it only to add an instance (Kooshi, 2026-09-15).]** A run expected to exceed ~15 minutes
persists its progress at natural acceptance points (a verdict, a wave, an accepted deletion, a solver's iterate) and resumes
from that state after a kill; a long phase whose state lives only in a process's memory is a **bug, not a style choice** —
on this hardware it is a bet against a demonstrated crash rate. The audit question at every phase design: *if this process
dies at any instant, what does the relaunch redo?* — and the answer is written in the subplan, beside the checkpoint's path
and the **resume command**, never discovered at the loss; a checkpoint nobody knows how to resume from is a file, not a
recovery. The instances, each a clause of the rule:
1. **The incident that minted it.** M51's iteration-3 halo shrink ran 19 hours with its state only in the parent (the cover
   checkpointed per wave; the shrink saved only on completion); one worker died, the pool's `map` hung forever, and the
   whole shrink was lost (M51 §R-INC5).
2. **The checkpoint must not live where another agent is told to clean.** `build/` is regenerable scratch, and an agent
   tidying up after itself deleted a tree under it on 2026-09-11 while a live job's only resume file sat in a sibling
   directory (`build/m63d2/ckpt-hismove/`). Recoverable state one cleanup away from unrecoverable is not recoverable:
   checkpoints live outside the scratch tree.
3. **A wall is not a checkpoint, and a tool that cannot be interrupted is not a tool for a long run** (2026-09-15, FS-50).
   Three semidefinite solves at 83 — 7.5 h, 4 h, and an implementer's 3 h 51 m — ran under `timeout` walls with the
   solver's iterate in memory only, because the solver's off-the-shelf interface neither checkpoints nor resumes; the walls
   fired or were about to, and **killing a `timeout` wrapper to lift its wall kills the child too** (GNU timeout 9.11 arms
   `PR_SET_PDEATHSIG`; tested on `sleep`), so all three were lost with nothing on disk. The rule was in this file
   the whole time; the runs were launched without asking its question. The repair: drive the solver through its own API in
   warm-started chunks, the iterate saved after every chunk and one residual line per chunk (`tools/fplane_sdp_scs.py`),
   never under a wall — and a process-model claim is tested on `sleep` before it is acted on or sent to anyone.

**A run that blocks something is presumed killable** (Kooshi, 2026-09-12). **[PROTECTED — never compress, trim or
paraphrase this paragraph; rewrite it only to add an instance (Kooshi, 2026-09-15).]** When a live job stands in the way
of anything — an edit to a module it imports, a core another task needs, a fix it would invalidate — weigh
**the value of the run against the value of what it blocks, and the default is to kill the run.** The burden
of proof is on keeping it, never on stopping it. Because every long run checkpoints (above), **the cost of
being wrong is the time to redo, never the result** — so weigh the cost of being wrong, not the hours
already spent. Three shapes met in one night, each of which looked like a reason to wait and was not:
- **The run is blocking its own replacement.** Two reductions spent hours on an operation a new engine did
  186× faster, and `tools/` could not be edited while they held it open — so "wait for them to finish" made
  the slow path self-perpetuating. Look for that circularity by name: *is the thing I am waiting on the
  thing preventing the fix?* **Second instance, 2026-09-15 (FS-50), and this rule was on this page in full when it
  happened:** four single-threaded semidefinite solves at 83, 3.4 s per iteration and a day to convergence, were kept
  running while the timing of their replacement ran niced beside them — a threaded and a GPU linear-system backend of the
  same solver, selectable the whole time by one keyword (`linear_solver=`) that had been misread the day before as
  "unavailable in this wheel" because the wrong keyword was tried — and the product owner wrote "nothing else is runnable
  until the measurements land". **Measuring the replacement is not a precondition for stopping the run**: with
  checkpoints the redo is minutes on the fast path, so the runs are killed at their next checkpoint and relaunched on
  whatever the measurement names; the two with no checkpoint on disk yet forfeited about 1,800 and 550 iterations of a
  reading the surviving run's chunk lines already gave. The shape to recognise: *the measurement I am waiting on is the
  measurement of the thing that replaces what I am protecting.*
- **The run is producing records under code you are about to fix.** Finishing banks results from the broken
  version and forces the redo anyway — and those records are the ones a later reader trusts.
- **The fix makes the redo cheaper than the run being protected.** Then waiting costs twice.

Two obligations when you do it. **Capture the run's state into the record before signalling** — a verdict
written only at `finish()` is lost, and the log is not the record. And **name what the kill forfeits, out
loud**: one such kill cost a registered out-of-sample prediction, and a forfeited instrument must not
disappear quietly merely because the decision was otherwise right.

**Kill by PID or process group, never by matching a command line.** `pkill -f <pattern>` matches the shell that runs it
and every other process whose command line mentions the pattern — including another agent's monitor. Sixth recorded
instance 2026-09-13 (FS-38 phase T): it killed the engineer's own level-7 run at 11,000 of 16,383 asks and the advisor's
watcher in the same second. `setsid` the job, write its pgid to a file, signal that. **And the pid you hold may not be
the process you mean** (2026-09-15, FS-53 A0.3): `nohup <binary> … &` followed by `$!` reports an intermediate **shell**
in this harness, not the binary — reproduced deliberately on `sleep`, where `$!` read 3469129 and the binary was its
child 3469131. Killing that pid leaves the binary running, re-parented, still writing its `--out`; the engineer found it
only because `git status` showed a **committed** artifact modified after the commit. **A kill is verified by what stopped
changing, never by the exit status of the kill**: after signalling, confirm by effect — no process of that name in `ps`,
and the file's digest identical across ten seconds. **Seventh and eighth instances, 2026-09-16, both in one night and the second while writing up the first.**
(a) **A pgid read from `ps` at launch was not the group the work ran in.** A cube sweep was launched under
`setsid`; `ps` showed its pool at pgid `4088996`, that number went into the pgid file, and `kill -- -4088996`
followed by a count of processes *in that group* reported **"survivors: 0"**. The sweep in fact ran in group
`4131612` and kept going for **six more hours**, discovered only when a later `ps` showed nine live workers.
**The verification tested the wrong proposition**: group membership, not whether the work stopped. (b), the eighth: `plans/GROKKING-INSTANCES.md` § Building. **The rule in one line: verify a kill against the thing you wanted stopped — the named
pid absent from `ps`, and the artifact it was writing static across ten seconds — never against group
membership, and never through a pattern that can match the killing shell.** Both checks are two commands
and both would have fired here. **A hand-rolled scan of `/proc/*/cmdline` is `pkill -f` in a
different costume** (2026-09-15, FS-53 phase B): an agent stopping one solve matched its own pattern in the command line
of the shell running the scan and killed its own process group. Nothing was lost — the certificate was already filed —
but the repair is the one to copy: find a process by the **inode of the log file it holds open**, which cannot match a
command line. **Ninth instance, 2026-09-23 (FS-73): a lock wrapper is a parent like any other.** A `flock` wrapper believed to be
still waiting was killed and reported stopped — but it had already started its child, which inherited the lock's descriptor and
ran an obsolete search orphaned, holding the machine's one heavy lock for about 17 minutes while every queued job waited; found
by a `ps` sorted by CPU. Kill the process group, and verify against the work: the child absent from `ps` and the lock free.

**A pipe can kill the producer, and `| tail` can hide that it did.** Same session: a mutation harness run as
`./plant.sh … | head -6` died of `SIGPIPE` when `head` closed the pipe — **before its `git checkout` restore** — leaving
a planted fault in the tree, and the verification that should have caught it was `cargo nextest run | tail -2`, whose
exit status is `tail`'s and therefore always zero. The plant reached a commit. Two rules, both already here in other
costumes: a command whose *cleanup* matters is never piped into `head`, and a gate's exit status is read from the gate,
never through a pipeline (`set -o pipefail`, or capture to a file and read it).

**Never edit a shell script while it is running.** Bash reads a script lazily, by byte offset, so a live process resumes
mid-token — it killed a 46-minute `lean4checker` run at M07 with `line 110: ull-library: command not found`, a message that
looks like corruption and is nothing of the kind. Launch long runs from a snapshot copy (`cp scripts/x.sh
build/x-snapshot.sh`; `build/` is gitignored).

**Generated modules and invalidation.** For work split across independent modules the wall clock depends only on the
job count, not the piece size, so smaller pieces are free concurrency. Lake takes a module's own trace from its source and
its dependents' traces from the resulting `.olean` (measured at M11 — not what the rule used to say, and ignoring the
corollary cost 28 hours of processor time at M07; doc comments are queryable data and therefore part of the artifact,
`--` comments are not):

| edit to an upstream module | that module | its dependents |
|---|---|---|
| a `-- line comment`, anywhere, including inside a proof | re-elaborates | **not rebuilt** — the `.olean` is byte-identical |
| a `/-- docstring -/` or a `/-! module doc -/` | re-elaborates | **rebuilt** — doc strings are environment data |
| a declaration, or any change to one | re-elaborates | rebuilt |

So: prose in a module a certificate imports is written as `--` comments or not at all; diagnostics live
downstream in `Sat/Diagnose.lean`; `Sat/Mask.lean`, `Sat/ClauseTable.lean` and `Sat/MaskCheck.lean` are
settled, and changing a declaration or docstring there is a decision about hours; deleting a generated `.c`
under `.lake/build/ir/` invalidates its module exactly as deleting the `.olean` would. Settle every
hand-written module before starting a long generated build.

### The kernel's cost model

- **`decide +kernel`, not `decide`, for anything large.** Plain `decide` reduces the `Decidable` instance
  twice — in the elaborator and in the kernel — so it is ~2× slower and dies on `maxHeartbeats` first;
  `+kernel` needs no knob and buys the same axioms.
- **Reduction-step count is the only thing that costs** (measured: ~33 µs per iteration of a trivial
  recursive function). This model predicted core's already-measured LRAT checker cost to within 20% (it rebuilds a 6,325-slot
  array per step; 6,325 × 33 µs = 209 ms against 100–180 ms measured), which is why to trust it. GMP-backed `Nat` arithmetic *and bitwise* operations are free at thousands of bits;
  `USize` is stuck (its width is an `@[extern] opaque`); `Nat.ldiff` is not accelerated; `Nat.fold` is
  superlinear. Which operations are hardware-backed is invisible in the source — measure before believing.
- **Data the kernel must *build* costs O(its whole size) per access; a *literal* does not.** A structure
  grown by N applications costs O(N) to reach weak head normal form (a lookup in a table grown by `insert`
  went from 2.14 ms at 2,381 entries to 16.7 ms at 33,089). Emit big tables as literals (M04's `PtTable`
  pattern), never accumulate one during a kernel evaluation, and never build an index list with
  `List.range` + `List.map` (~0.83 ms per element). **The figure is for `range` + `map`, and does not transfer to a
  bare `List.range` re-evaluated in a loop** (measured 2026-09-15, FS-53 K1): a `check` that rebuilt `List.range 529`
  once per circle point — 12,696 nodes, ~10 s by that figure — cost **4.19 s against 4.17 s** for the hoisted form,
  inside run-to-run noise, because the kernel's cache absorbs the repeat. The hoisted shape was kept anyway (it is the
  honest one and costs nothing), and the docstring that had asserted the order mattered was rewritten: **a rule you are
  obeying is still a claim, and it is measured before it is written down.** A `Nat` literal costs ~2.3 KB of olean against ~145
  bytes per plain literal node, so pack many values into few big `Nat`s.
- **A `∀ x ∈ l, P x` under `decide` costs an order of magnitude more than the same check as a `Bool`.** Measured
  (FS-38 K3): `∀ e ∈ (778 pairs), e.1 ≠ e.2` on a bare import cost 31.9 GB and timed out; `l.all f = true` on the real
  predicate cost 3.5 GB and 5 s. State list checks through `List.all` and recover the per-element form with
  `List.all_eq_true`.
- **A numeral at an unsimplified type index is paid per numeral, at elaboration, even in a definition with no
  proof.** A 48-point literal at `ZMod (2 ^ ((5 + 1) / 2))` cost 32.9 GB and a timeout; the same points at `ZMod 8` cost
  2.5 GB, and then a defeq wall on every access. Carry no literal at such a type; evaluate the form per element.
- **Feed the kernel the refutation's core, never the whole instance.** A certificate's clause table costs
  `agreesWithCNF` over the entire formula: 853 s at 33 GB for a 1,024-vertex instance whose proof reached 125 vertices;
  the core, extracted from the LRAT by backward reachability from the empty clause (861 of 99,335 clauses), proves the
  identical statement in 5.9 s (recipe: `Instances/TwoAdicFive/Edges.lean`).

### Searching

- **The regex engine.** `grep -E` on this machine is `ugrep`, and it silently under-matches alternation
  inside a repeated group: `^\s*(private |protected )*theorem` does not match `private theorem foo`. **And a `^` anywhere inside a pattern is read as an
  anchor, so `grep -c "LDL^T re-run"` returns 0 for a string present four times** (2026-09-15, FS-53 phase B: it briefly made
  the LDL verification of six certificates read as *zero blocks checked* — failing, as ever, in the direction that looks like a
  clean negative). `grep -oF` counts correctly; `rg` and `grep -P` match correctly.
- **The file selection.** `rg` respects `.gitignore`, which hides `.lake/` and `build/` (naming a hidden directory explicitly works; it is
  recursive discovery from `.` that skips it). Use `rg` for
  searching source; use `rg -uu` or `grep -rP` for any completeness question (does this artifact exist, is
  this string anywhere); never believe a count from a bare `grep -E` alternation inside a star.
- **A failed `exact?` is not an absence.** It proves the shape you asked for was not found; vary the
  statement (`= true` versus `decide (…)`, an iff versus an implication) first — `Nat.testBit_two_pow_sub_one` was reported
  missing here on exactly that error. **And Mathlib is not the
  whole library:** `grep -rn "<name-fragment>" $(lean --print-prefix)/src/lean/` searches core. Grep the
  source before writing a proof, and before writing that something is missing. More instances: `plans/GROKKING-INSTANCES.md` § Searching.

## The package

The **`proofs`** package (`lakefile.toml`): library **`Proofs`** (`Proofs.lean` is the flat import
surface, modules under `Proofs/`), with `autoImplicit`/`relaxedAutoImplicit` off. **Mathlib** is
pinned to tag `v4.32.0`. `scripts/Axioms.lean` is the trust receipt.

When adding a library/executable, changing dependencies, or bumping Mathlib, work through the
**`debruijn-init`** skill — freshly invoked, per WORKFLOW's fresh-invocation rule. `lake update` /
Mathlib bumps go alone in a labeled commit (they move the ground under every proof).

## The gate

Elaboration is the floor of the test suite: the build green, zero `sorry`, `#print axioms` clean on the
public surface, linters silent, spec examples passing. On top of that, this project's statement-level gate,
because a formalization that proves the *wrong* theorem is the characteristic failure here:

- **`./scripts/vacuity.sh` and `./scripts/vacuity.sh --self-test` are green** — no theorem is a `∀` over an
  empty domain. Vacuity is undecidable, so the check **requires evidence**, as `axioms.sh` requires every
  purchase to be declared. **The law:** a statement is vacuous exactly when some `∀`-binder has an empty
  domain; `(C : G.Coloring α)` is the dangerous binder, a `Forces` binder is a possible *overclaim* instead
  (FS-29), and a declaration concluding `False` is a refutation and is skipped — its binders are meant to be unsatisfiable, and flagging one
  is flagging a theorem for its own content. **Verdicts:** `WITNESSED`
  (inhabitant proved); `DECLARED` (deliberate emptiness, named with its reason in the docstring as
  `VACUITY DECLARED:` and printed every run); `VACUOUS` (undeclared emptiness) and `STALE` (claimed emptiness
  not proved, which is what makes the annotation a checked claim rather than a `# noqa`), which fail unconditionally before the baseline; `GENERIC` (parametric, where **no inhabitant witness can exist** — the caller's
  obligation); `UNKNOWN` (counted, never silent, and the only thing the baseline may hold). **Counts** — a
  silent change in them is this gate's own failure mode (declarations are the library's; the audit's own are not counted): `declarations=7438 refutations-skipped=313
  sites=279`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2`. The baseline's two entries,
  `hexShell_plane5` and `hexShell_plane6`, cannot be discharged: their inhabitant *is* Hadwiger–Nelson.
  `--self-test` plants seven controls and watches each fire; the load-bearing one — the same carrier family
  at an instantiation nothing refutes — must read `UNKNOWN`, never `VACUOUS`, since a check that flags it is matching the family name rather than the
  instance and is worthless. More instances: `plans/GROKKING-INSTANCES.md` § The gate.
- **Every gate keeps what it computed — read it before re-running one.** `build.sh`, `axioms.sh`,
  `vacuity.sh` and `lean4checker.sh` save their tool's complete output under `build/gate/<gate>/` (`latest`
  is the last complete run; `scripts/gate-log.sh`) and print a digest: every count, whether the counts
  recorded in this file still match, every flagged or declared row in full, and every row that changed
  since the previous run (`scripts/gate_report.py`). The vacuity log holds every site with the evidence
  that decided it. `regen-check.sh` keeps each step's log in its scratch directory.
- **Every theorem whose hypothesis is a structure** (a colouring, an embedding, a certificate, a
  homomorphism) **ships a named inhabitant** in the same file, or a one-line note naming the theorem that
  supplies one.
- Every definition has a `#eval`/`example` that would fail if it drifted.
- The Moser spindle's non-3-colourability is proved **twice** — by `decide` and through the SAT bridge —
  so the CNF encoding is checked against an independent oracle.
- The final statement is read against Mathlib's `SimpleGraph.chromaticNumber` and the informal claim, out
  loud, before it is believed.

The InfoView is continuous testimony at zero cost — save and read the goal state after every step rather
than debugging by guess.

### Make the gate fail, and watch it fail

**Run every check's negative control at every milestone.** Break the thing it guards on purpose, confirm it
goes red and names the culprit, then put it back. A check is not known to work until it has been seen to
fail.

Every check that has failed here failed the same way: **it reported nothing when it could not run** — a
comparison of two purchase ledgers never actually performed; an audit that aborted under `set -e` with no output
and read as a pass through a pipe; a mutation rig that re-read a stale file and scored it as a pass; negative
controls the instrument could not see. A trust receipt that fails open is worse than none, because it is
believed. So make a check's failure path louder than its success path, never let a shell pipeline swallow an
exit status the gate depends on, and give every discriminating claim a partner that goes red — a certificate
filed against the wrong problem, a vertex moved off the unit circle, a satisfiable formula handed to the checker.

**The unifying rule, from nine instruments that broke inside one phase** (M63 phase C, 2026-09-11; eight
failed by silence, one by false alarm): **every check needs a positive signal for the thing that did not
happen.** A wall that could not fire, an exception swallowed in a timer thread, a control asking the same
question twice, a pid file catching a wrapper twice, a silent forty-minute search, a control announcing a
refutation from an index mismatch, a trust receipt returning a benign verdict while checking nothing, a `grep`
that killed its own shell, a four-hour deadline armed as an exit-waiter — each quiet exactly when it had
something to report, because each reacted to an event instead of asserting an absence, and **an exit-waiter can
tell you a thing has ended, never that it is late.**

**A waiter whose success condition is a file that a GOOD outcome prevents from existing** (2026-09-12). A
sweep dumped its residual-candidate file only when the survivor list was non-empty; the count reached zero, the
file never appeared, and every waiter on it read like a hung run. Its sibling monitor had the same defect in the
other costume — a `pgrep -f` liveness check that matched its own command line, so the process-gone branch could
never fire. **Arm a waiter on a file the SUCCESS path always writes**, even if that file says "nothing found".

**And a waiter's condition must be FALSE at the moment you arm it — check that, not just the condition** (2026-09-15,
FS-53 K1). A wait-for-the-build loop watching for a line beginning `==> build:` fired **immediately**, printing
"BUILD FINISHED" at batch 140 of 172, because `scripts/build.sh` prints exactly that as its *first* output. A waiter
whose condition already holds at launch cannot tell you anything, and **it fails in the direction that looks like
success** — the implementer caught it only because the rebuilt-module count came back zero. One line before arming:
evaluate the condition and assert it is false. **Second instance, 2026-09-17, and the mechanism is different: the condition was
vacuous, not already-satisfied.** A waiter armed as `until ! pgrep -u $USER -x python3 -f "valueset.py 3"` fired in the same second,
because `-x` matches the process **name** exactly and, combined with `-f`, matched nothing at all — so "the job is gone" was true at
arming while the job had six minutes left. **A predicate that can never match reads exactly like a predicate that is satisfied**, and
both fail toward "done". The one-line guard covers both: before arming, evaluate the condition and assert it is false — here that
printed `pid=` empty, which is the tell. The repair used the PID directly (`while kill -0 <pid>`), which cannot be vacuous.
**Third instance, same session, and it is `pgrep -f` self-match wearing a waiter's costume:** `while pgrep -u $USER -f "fq_chi\.py
[23] "; do sleep 15; done` can **never** exit, because the shell running the loop carries that pattern in its own command line and
so matches itself forever. The self-match rule's eight recorded instances (§ Building; the eighth in `plans/GROKKING-INSTANCES.md`) are all *kills*; in a waiter's **condition**
the same bug fails in the opposite direction — not a wrong process killed, but a wait that never ends and looks exactly like a job
that never finished. **So the rule is not "don't pkill -f", it is "never let a pattern that can match the matching shell decide
anything"** — a kill, a wait, or a liveness check. PIDs cannot self-match; patterns always can. **Fourth instance (FS-79 phase 0): a waiter on the log of a chain
that had already been killed and replaced** — its condition could never become true, and it was found only at the phase's end. Arm a
waiter on the live job's pid, and re-arm it whenever the job it watches is replaced.

**And the rule the one above does not reach: state the uninformative outcome and confirm it is REACHABLE,
before believing a control's pass or proposing a discriminator.** "Break it and watch it go red" assumes the
break can fire. Twice in one evening it could not (M63 phase E, 2026-09-11), the same error with opposite
signs: a planted fault that could never fire (a target loosened in the direction the search ignores) and a
discriminator that could never discriminate (two attributions it could not separate). Both passed review; both
were found by opening the module. **A control whose failure mode is unreachable has not been tested by
passing** — it is indistinguishable from one that works. The paired form, measured the same evening: seven
errors between two readers, four the engineer's and three the advisor's, every one found by reading code rather
than by arguing, because each asked the right question of the other's instrument and never of their own.

**Pre-decide how you will respond to your own gate failing — before it fails, on someone else's number.**
Measured 2026-09-11: an engineer's pre-registered comparator went red on its own integration, and the honest
diagnosis was exactly the one a motivated person would reach for. It did not widen the comparator, because it
had already reasoned one commit earlier, on a different planted fault, that **a check you tune until it agrees
with you has stopped being a check** — sequencing, not virtue, and cheap: settle the policy while the number
under dispute is not yours.

**And when you replace a broad instrument with a sharp one, you lose coverage you were not measuring.** A
whole-run wall-clock test was traded for a six-point component measurement that established a cost law's
*shape* by construction — strictly better on what it measures, and blind to any cost outside the component. A
second cost of the same shape, hiding in a progress log, was invisible to the sharp instrument and would have
been caught by the weak one. **State what the old instrument saw that the new one does not, at the moment you
swap them.**

**And when you put a measured number into a decision, carry what it MEASURES, never just its value.** Three
rulings in one night rested on a number measuring something adjacent: a per-*ask solve* rate used as a
per-*candidate* cost (wrong by 30×); a contended-wall timing used as a quiet-CPU cost (1.59×); a mid-window ratio
used as a completed-window one (16× against 7×). None was a wrong measurement, which is why none looked wrong.
**A number in a ruling travels with its units, its conditions and its population, or the ruling is about
something else**; the repair is to re-derive the decision from the corrected figure out loud, because a ruling that survives its bad evidence needs new grounds, not a quiet pass.

**And the sharp, checkable form of that rule, extracted 2026-09-12 after the same error's FOURTH instance in
one milestone: when two numbers are compared, exactly ONE thing may differ between them.** A brief claimed a new
rotation gave *"twice the record's circle count and twice its unit-neighbour count"* — the doubling came from
dropping a coordinate restriction, and the unit shell does not depend on the rotation at all; a product owner
scored an off-diagonal raw count against `24/54`, a share of the monochromatic cross edges under one colouring — a
different denominator. **Both differed in two things and credited one, and the other thing was the change being
advocated, so the error flattered the work.** The check costs seconds: **write both numbers as fractions with the
denominators spelled out in words.** None of the four instances was a wrong measurement — each was a right
measurement of a different quantity, which is why none looked wrong to its author.

**The same rule has a second half, and its author broke it within two hours of writing it down.** Having
recorded *"state the uninformative outcome and confirm it is reachable"*, the product owner registered a
prediction (`P-Y1`, 2026-09-12) whose **informative** outcome was unreachable: a ratio band of 30–70% on a
quantity ~90% of which is produced in the *other* phase on byte-identical code, so a ratio near 1 was forced.
**Confirm that BOTH outcomes are reachable — the one that would teach you nothing and the one you predict.** A prediction whose target region the apparatus cannot enter is not a prediction, it is a formality that will read as a finding when it fails. And
the test of whether "mis-specified" is a diagnosis or an escape: **the evidence for the mis-specification must
predate the result** (here the 90% split was in the run's own numbers before the prediction). **The rule is
symmetric: a control going RED is not evidence either, until you can name what a wrong-reason red would look
like** — it is an unexplained failure that happens to agree with you. Three plants in one night fired for the wrong reason, one on an out-of-range index that died before
reaching the guard it was written to test. The repair is a **pair**: the stub that must fail beside a faithful
stub that must pass, so the refusal is seen to come from the cause and not the scaffolding.

**A measured half and a derived half fail in OPPOSITE directions, and one rule cannot cover both.** Where a
graph's edges are *measured* — a float proposes, exact arithmetic decides — the only possible error is a
**missed** edge, which makes colouring easier, so **a refusal is robust and a colourable verdict is suspect**.
Where edges are *derived from a law*, the error is an **invented** edge, which makes refusals faster and cheaper
and looks exactly like success — so there **a refusal is the suspect verdict.** M63 phase G, 2026-09-12: a
ruling "believe a refusal immediately" from the measured half was applied to an arena whose novelty lived in the
derived half. **Before trusting either verdict, ask which half of the object produced it**; being built by the
law is the reason the law needs checking, not the reason it does not.

**A check must read the value the code SHIPS, never a copy of it.** A control certifying the safety margin of
a float gate asserted against a hardcoded `1e-7` rather than the gate's own default, so it would have kept
certifying that margin after someone made the real default lossy — **a check reporting about code that is not
the code that runs.** It now reads the default out of the signature, and every derived quantity with it.

**And the failure path's FORMATTING is part of the check.** The same control's message rendered a failing
ratio of 0.60 as `1×` — a display rounding turning a red into something that reads like a pass. **A check's
output is the check**, and the last transformation before a human sees it is inside the trust boundary.

**Bound a plant's effect on BOTH sides, and the control reports for free when it has gone blind.** A control
that can say *"I can no longer tell"* beats one that can only pass or fail, because that third state is where this file's oldest failure mode hides — but the mechanism, not the outcome,
is what reproduces. Assert the two-sided form:

```
0 < (guarded_result − planted_result) < threshold
```

The lower bound fails when the plant has stopped firing; the upper when it fires too much. Measured 2026-09-12:
under a mutation that made the shipped value identical to the planted one, the difference collapsed to zero
and the lower bound caught it, where the one-sided `planted < guarded` would have gone silent about having
lost its power to discriminate.

**To compare POLICIES, replay them over a recorded decision sequence rather than re-running** (2026-09-12). A batch-size
lever estimated at ~2.9× measured **2.31×** when every policy was replayed over one pilot's own accept/reject log — one run,
one population, one thing differing — with the control that the replay reproduces the original run's exact cost; re-running
would have compared two populations and one policy at once. More instances: `plans/GROKKING-INSTANCES.md` § Make the gate fail.

**A cost measured on a FAILING run understates a succeeding one — and the tell is that the cheap steps are the failures**
(2026-09-12). A reduction walk was costed at **24% expensive probes** from a sample already fallen into the cheap satisfiable
regime, where each step answers in a millisecond because the object has stopped refusing; on a walk actually progressing it is
**~75%**.

> **A successful walk is the expensive walk.**

It inverts the intuition that a run going well is a run going fast, and it is how a pilot's cost model
understates the real thing by 3×. **Before costing an iterative process from a sample, check which
regime the sample's CHEAP steps were in**, because the cheap ones are the population that will not be there
when it works.

**A caveat you write and then step over is WORSE than one you never wrote** (2026-09-12). An advisor wrote *"this exhausts
the additive twist family, not the twist family"* and, in the same report, *"the 72 off-diagonal edges are measurably
load-bearing"* — the qualifier dropped, the headline amplified twice, a dead object kept alive a day. **The caveat is what
made the headline look audited**: after writing a scope qualifier, re-read the summary sentence against it.

**And the cheapest generator-image check there is: count your generator's free parameters against the
problem's.** A search ran over `{(C, π∘C)}` — one free parameter — where the solution space `{(f, g)}` has two; the image was
a measure-zero slice and the answer lived outside it, with the positive control passing. A parameter count is seconds and
catches the whole class.

**A TRUE explanation that fully accounts for the observation will stop you looking for a second one — and the second one may
be the one about your own apparatus** (2026-09-12). An engineer tested a theorem out of sample at `n = 3`, where its load-bearing
hypothesis `√(4n−1) ∉ K` fails by definition of the field (`4n−1 = 11`): the prediction was void, not met, and two laws "agreed
300 of 300" because both were inapplicable. Its first account — a mis-filed fact — was wrong in the flattering direction — a confession can flatter, because *"I filed it under the wrong heading"* is tidier and more forgivable than what actually happened: `n = 3`
fails **two** gates, and a true, sufficient-sounding reason for the first (*"this member can never reach five colours"*) made the
member look **safe to compute on** — dead as an object, free as a test case — so it never asked whether a second gate also
failed. The first failure was about the member; the second was about its own instrument.

**The habit, and it is cheap: a candidate that fails one gate must be checked against ALL of them before
being used as a test case, precisely because the first failure makes it feel already understood.** And
re-read every hypothesis against the test instance immediately before believing an out-of-sample result,
which is exactly when the result is most wanted and least examined.

**And a mutation harness must verify its own RESTORE** (2026-09-12). One broke *itself* through CPython's bytecode cache,
whose identity for a source file is `(size, mtime in whole seconds)`: a same-size mutation written inside one second left the
interpreter executing mutated bytecode against a restored source — every plant "passing" while the arithmetic under test was
wrong. What caught it was the harness **re-running its controls after the restore and asserting the guarded state comes
back**. Restore, then re-verify, and treat a same-size edit inside one second as the case your caching cannot see.

**And mutate the CONSTANT, not only the logic.** Mutating a function's *default value* rather than its *body*
is what exposed a control asserting against a hardcoded copy of that value; nothing about reading the control
would have shown it. The cheap half of the lesson, and the one that finds checks pointed at the wrong code.

**Archiving a checker can break it in exactly the way it was built to detect.** A committed equivalence harness reconstructs its
"before" tree from git and imports a module by name — so the reconstructed module binds to **today's** copy of its dependency if
that reaches `sys.modules` first, and the comparison silently becomes one tree against itself **while printing ALL MATCH**. Assert
the provenance of every module a reconstruction loads, and **provoke that assertion** — pre-load the wrong version deliberately
and confirm the harness refuses. **The sharp form: a check that loads two versions of something and identifies them BY NAME** —
module caches, class registries, singletons, environment lookups, anything with a global namespace. Its finder declined the
credit: it had been forced to reason about module identity hours earlier, on a task that loaded two copies in one process —
**an instance found by prior context is not evidence that a rule reproduces**, which is the argument *for* writing it down: it
does not reproduce from care, only from the negative control being mandatory.

**Enumerate the PARAMETER first and screen the objects against it second, never the reverse** (2026-09-12). A census of
rotations was enumerated *over a base*, so a rotation whose circle is empty over that base never became a candidate — **no row
to audit**, a family of 6-open rotations unrecorded while the headline read "none". **An omission is worse than a miscount**: a
miscount is a wrong number in a row you can check. Sibling defect: an enumerator whose cut is one-sided
on a dense set has no well-defined answer, so its `span` parameter *is* the answer — the tell is totals that never converge
while the quantity of interest does. **When a generator takes a parameter, report the quantity at two values of it before
believing either.**

**A positive control proves an instrument finds things OF THE SHAPE ITS GENERATOR CAN REPRESENT, and says
nothing about shapes it excludes.** A sweep of 781,284 candidates returned a decisive zero for a new parameter and nine hits
for the known one, its positive control passing — the known witness *was* expressible in the generator's restricted shape and
the new one was not. **Before believing any zero over a family, write down the generator's image and check the target is
inside it.**

**Do not mistake a one-sided filter for an inverted monotonicity** (an advisor's correction of the product owner who wrote it).
Once a base contains the witness, growing it cannot recover the four-colouring (more material adds colour differences, and the certificate needs a value outside them) — adding material makes a graph harder to colour
and a *sufficient condition for colourability* harder to fire: one statement, seen directly and through a one-sided filter;
nothing is inverted. An agent told to expect an inversion hunts one and misses what is unusual: the filter can be defeated by
**breaking its applicability rather than its conclusion**, and a `not-applicable` on the same footing as a silence is a pass nobody
earned. **Whenever a one-sided filter judges something you are building, enumerate the ways to make
it inapplicable before the ways to make it fail.**

**And the honest account of where these rules come from: they are scars, not foresight.** The engineer whose control
docstring already said *"a control that passes without its failure mode being reachable has not been tested by passing"* had
written a control that could not fire earlier the same evening, and noticed only when it tried to plant a fault in it. **The
habit that produces the principle is planting faults routinely, not reasoning about controls carefully.** Reasoning finds the controls you thought about; planting finds the ones you did not.
