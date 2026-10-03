# This workspace — lean-dir

A Lean 4 proof workspace aimed at one target: **the Hadwiger–Nelson problem**. Its work runs as a pipeline of four identities
(§ The pipeline): Poros asks the question, Ephodos derives the answer, de Bruijn formalizes it to its Lean standard, and
Keryx coordinates. **Who you are is set by how you were launched.** The top-level session is Keryx, whose identity and workflow are the output
style `.claude/output-styles/keryx.md`, which `.claude/settings.json` selects. An agent launched from `.claude/agents/` is the
identity its file names, with its lane's workflow beneath. This file is every mind's shared context, never an identity. Everything reduces to what
the kernel checked plus what we explicitly chose to trust.

**This file holds current state only.** Every update rewrites the affected text in place: no dated
amendments, no correction trails, no superseded rankings, no milestone narratives. A corrected claim is
replaced by the corrected claim (with its attribution, if it turned out to be prior art); the story of the
correction belongs in the commit message and the milestone's plan. **History is in git:**
`git log -p -- CLAUDE.md`. The last version carrying the full narrative — every milestone's story, every
amendment and correction trail, every superseded ranking and reading — is commit `fd658af` (2026-09-10).
**Size budgets: this file under 80,000 bytes, and the grokkings file (`.claude/skills/grokkings/SKILL.md`) under 200,000** (Kooshi,
2026-09-28: *"Let's say 80kB for CLAUDE.md, and 200kB for grokkings."*). They bound what a session carries — this file every agent
loads, the grokkings every lane that reasons from them — because *"There's just too much new knowledge to carry in every session"*
(Kooshi, 2026-09-26); `tools/claude_md_fact_audit.py` fails when either is over. A ceiling reached is a ceiling that starts costing
content, and the current-state-only rule, not the byte count, is what keeps these files honest. The budget is a ceiling and never a
licence: the current-state-only rule above does the real work, and superseded text comes out whether or not there is room for it.
No-loss compression is exhausted here (the last pass, 2026-09-25, found almost nothing more that touches no reasoning), so a budget
reached is met by moving what a session does not need to a file read by address, never by trimming a rule's reasoning: a reasoning
trimmed to fit cost hours on 2026-09-15. The budgets' history is in git and, verbatim, in `plans/CLAUDE-MD-HISTORY.md`. **One home per fact** (2026-09-21): numbers, certificates, names and
addresses live in a row of `LEDGER.md` (the novel-results ledger, extracted from this file on 2026-09-22 — read by address, never
loaded), mechanism and readings in a grokking (`.claude/skills/grokkings/SKILL.md`, loaded by the lanes that reason from it), a rule's second and later instances in `plans/GROKKING-INSTANCES.md` (extracted
2026-09-26, read the same way), a retired grokking in `plans/GROKKINGS-RETIRED.md` (since
2026-09-28, read the same way), and every other mention points; at every close run
`tools/claude_md_fact_audit.py` with `--base <the previous close>` (nothing lost, across every file it joins) and `--dupes` (nothing retold). **A paragraph tagged `[PROTECTED — never compress …]` is exempt from every trim
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
  χ(F²) ≤ k. **6-open**: none is 5-colourable (every usable plane and every target at a prime above 2 needs ≥ 6; over a multiquadratic field, the wall is broken and every usable
  plane needs ≥ 6; over K, row 53's criterion). **The (2-adic) wall** stands
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
   bichromatic almost surely, and de Bruijn–Erdős finishes ([hand, two minds]: FS103-N's N-EASY, PA1's (E)); its argument is in print
   (`[GwynStavrianos2022]` Lemma 2, Thm 2, under an invariant mean; the Haar-average line unprinted, row 130), and choice enters at
   de Bruijn–Erdős alone (a reading, one mind; `[ShelahSoifer2003b]` p. 42 names that step).
3. **Density cannot give six.** One colour class at a time is capped below 4.37 (row 129); a proof of six must use how the classes fit
   together, never only how large each is.
4. **Regular colourings need seven, verified and almost everywhere** (row 132). Closed colour classes need seven (`[Voronov2023]` Thm 1.3: six
   closed sets covering a disc of radius 3 realize the unit distance; closedness enters once, as compactness giving a band), and so does any
   colouring with slack (Thm 1.1) — proofs repaired locally, the paper an unrefereed preprint. Almost everywhere, boundaries free: slack needs
   seven; polygons and locally finite convex tilings need seven, `[SokolovVoronov2025]` repaired, its map theorem a
   GAP at the fills; nice maps need seven (`[Thomassen1999]`). Maps need six: `[Woodall1973]` Thm 6 and Townsend's manuscript, each repairing
   the other (`[Townsend1981]` prints no proof); `[Coulson2004]`'s six is for tiles with an area bound.
5. **So, given MR, Hadwiger–Nelson is one question: can vanishing holes save a colour?** With no MR, `χ_m⁰(ℝ²) ≥ 7` iff six classes, each
   free of monochromatic pairs at distances in `[1−ε, 1+ε]`, cannot cover the plane up to holes of density tending to 0 as `ε → 0` (row 131;
   `[SokolovVoronov2025]` §9's hypothesis). A refutation needs no wild set: it is a sequence of periodic grid-square colourings, wild only in the
   limit, whose normal form FS-103 holds, or valid fragments on discs of every radius (row 145). Both answers decide the problem. *No* — Voronov's contradiction survives a free colour of vanishing
   density — gives `χ_m⁰(ℝ²) = 7`, hence `χ(ℝ²) = 7` given MR. *Yes* — such a sequence, with six or five colours — gives `χ(ℝ²) ≤ 6`, or
   `= 5`, **with no MR**: the first move of the upper bound since 1950.
6. **Its tools are Voronov's circle topology made robust, and the density topology** (approximate continuity, Lebesgue density, De Giorgi's
   structure theory for finite-perimeter classes) — the room after ergodic theory in G30's ladder. Two proof shapes are closed (row 131):
   counting holes met by circles caps at `O(ε)`, and trichromatic points vanish from partial colourings; the index of density traces fails
   where a unit-arc interface faces a bowtie (row 132). A reading, with its test: finite perimeter is Lipschitz-in-probability, the
   quantitative form of the continuity every CP colouring has. Killing test: a CP colouring whose disagreement `P(c(0) ≠ c(h))` is
   continuous but not `O(|h|)` along every optimal family.

**The program** (`plans/STUB-regularity-wall.md`): **FS-106, the regular half — closed** (rows 131–132); **FS-107, stability — closed** (row 133):
Voronov's contradiction survives a free colour if a complementary junction pair is forced at a scale bounded below, and vanishing holes at bounded
complexity are a tight six-map; **FS-110, the tangency seam — closed** (row 134: none under Condition 5); **FS-112, the unit-arc half — closed** (rows 135–136);
**FS-114, the unit-arc question — closed** (rows 137–138: one local exclusion about a four-colour vertex suffices for the NO); **FS-116, the local exclusion — closed** (rows 145–148: the Γ-free four-colour vertex dies at `1 + ε`); its successors **FS-123,
the (Q)-free ring**, **FS-124, the (Q) ring**, **FS-125, the saturated class**;
**FS-117, route T's count** (the non-Siamese part); **FS-115, the stuck ray** (the density form only); **FS-111, the cone scale and the regularity step — closed** (rows 139–141); its successors **FS-120, the pinch at a junction**, **FS-121, the map step — closed** (rows 142–144); its successors **FS-126, curved pencils**, **FS-127, lateral extent**, **FS-128, the six-colour rungs**, **FS-122, the forced pair**; **Lean throughout** — MR in full
(Einsiedler–Lindenstrauss, Einsiedler–Fish), the collapse, the measurable chain, the map argument.

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
  χ(ℚ(√3,√11)²) = 4 in those words, the Moser spindle as the lower bound. The equality is his, restated in two surveys (`[Johnson2000]` p. 176, `[Johnson2006]` p. 214); the six later posers — and this project —
  missed it — G49's mechanism once more. What is ours: the kernel proof, Theorem A's metric-free form and reach (the construction `[Fischer1990]`'s; his congruence family is a proper subfamily
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

*Last updated: 2026-10-03 — **FS-116, the local exclusion, closed undecided** (rows 145–148; `plans/FS116-Z1-close.md`,
`plans/FS116-Z2-close.md`): the YES needs no map, and in non-Siamese simple fragments a four-colour vertex whose ring carries no boundary arc
dies at `1 + ε`; the (Q)-free, (Q) and saturated cases left are FS-123–FS-125. **FS-121, the map step, closed undecided** (rows 142–144; `plans/FS121-Z1-close.md`): honest saturated ladders end at (Q) or (R2) arcs and never outward, honesty is free, and the open steps are curved tangent interfaces, the singular set at LAT and the top colour at six (FS-126–FS-128). Before them, **FS-114**
(rows 137–138), **FS-111** (rows 139–141), **FS-112** (rows 135–136), **FS-110** (row 134), **FS-107** (row 133) and **the reframe** (Kooshi,
2026-09-26): the aim is the answer, formalized in Lean (§ The aim). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*

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
1. **The 4/5 wall is 2-adic.** Over a multiquadratic field, or one of degree at most 11, a unit-distance graph forces a fifth colour
   only if its coordinates break the 2-adic wall (G1, G35); over any real number field, only if each place above 2 splits in F(i)
   or is inert there of norm 64 or more (row 123), which a field whose wall stands can meet (G35).
2. **The field sieve.** For multiquadratic F ⊇ K: 6-open ⟺ the 2-adic wall is broken and 11 is inert. The finite planes refuse five from 59 up and
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
   — so every squarefree d ≡ 11 (mod 12) needs four (T4); not found in print — `[Johnson2000]` and `[Johnson2006]` pose it as open (`CLOSED-QUESTIONS.md` §1.7).
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
   are open. Bearing on the answer: none.
29. **Measure rigidity for the unit-vector group, and five at ℚ(√47)** (rows 120–122; FS-100 stage 5; [hand]). Every `U`-invariant `E`-null
   measure on `R̂` is Haar, by entropy: Einsiedler–Lindenstrauss on the finitely generated pieces for positive entropy, Einsiedler–Fish's
   pigeonhole for zero entropy — `U` is large enough for it, no finitely generated subgroup is (G80). With SP-Cor, `χ(ℚ(√47)²) = 5`; the flip
   stops at a quantitative T-C(A) (row 122). Bearing on the answer: MR is link 1's hypothesis (row 128; in Lean, FS-113); the fives none; ℚ(√167)'s gap is now [5, 7]. Wave 3 (rows 123–125): the class is `L ≥ 5` in every degree and SP-Cor holds on it, so χ(F²) = L(F) for `L ≤ 5` everywhere; ℚ(√3,√5) five; the type-(B) fields' rotation-invariant half; six at ℚ(√167) reduced to `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)`.
30. **The collapse, and the fractional local–global principle** (rows 128–130; FS-103; [hand], every headline given MR). Row 123's chain runs one colour class at a time: its five is `⌈1/α_loc(F)⌉`, the fractional bound `α_loc(F) = max(m₁(ℝ²), sup_v r_v)` rounded at one pigeonhole, and that route never gives six (G60); given MR the bound is exact, `α₁(F²) = α_loc(F)`, so at ℚ(√635087) `α₁(ℝ²) = m₁(ℝ²)` and `χ_f(ℝ²) = 1/m₁(ℝ²) ≥ 4.0487` (row 129). At a totally real field whose stable places all mix at six colours, `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)` (row 128; its load-bearing step needs no MR), and `χ_CP(ℝ²) = χ_m⁰(ℝ²)` with no MR (row 130). Bearing on the answer: link 1 — given MR, rung D is the value at ℚ(√635087) and of `χ_m⁰(ℝ²)` (G81).
31. **The regularity wall, verified; the question is stability; at bounded complexity, one four-colour vertex** (§ The aim; rows 131–141,
   145–148, 142–144; FS-117, FS-120, FS-122–FS-128). Regular classes need seven almost everywhere — slack, polygons, convex
   tilings, nice maps — and maps six; closed classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded
   complexity that is whether a tight six-map exists (row 133): under Condition 5 none does (row 134); with unit arcs every one has a vertex of at
   least four colours (rows 135, 137), so one exclusion at an explicit radius, above `φ²/√2`, about such a vertex suffices for the NO; where the count
   gives six room the configurations die at `√3` or `1 + ε` but for named cases, and both printed positives are part of no such map (rows 136, 138).
   FS-116 (rows 145–148): valid fragments on discs of every radius give `χ(ℝ²) ≤ 6` with no MR, so that exclusion decides both ways;
   a four-colour vertex whose ring carries no boundary arc dies at `1 + ε` (non-Siamese, simple), and the ring's change points off (Q) arcs are
   four-colour vertices; open: (Q)-free rings with (R2) arcs, (Q) rings, five- and six-colour vertices, the saturated cross off its class, Siamese
   fragments. The doors are two routes, not halves (row 139, two minds): seven is the NO's hole bound made uniform in the complexity bound, so
   FS-114's NO reaches it only through the map step — or through route R's forced pair, where the NO is idle — and each is the answer restated;
   route M's rungs hold down to the pinch at a junction (rows 140–141; FS-120–FS-122). On route M's map step (rows 142–144), at every `k`: honest saturated ladders end inward at (Q) or (R2) arcs and never outward, periodic classes have only segments and (Q) arcs, and honesty is free; what is open is curved tangent interfaces (one question for three claims), the singular set at lateral extent, and the top colour at six, the last the answer restated given a NO.
   Bearing on the answer: none moved; half of door (A) closed, the other half one local statement, now a case list (FS-123–FS-125).

**The prior-art position.** The reduction from a field plane to a finite residue plane has been derived
independently in seven lineages that barely cite one another — Woodall → Benda–Perles → Johnson → Chow;
`[Fischer1990]`; `[Moorhouse2010]`; `[Manturov2012]`; `[Madore2015]`; the finite-field side (Medrano–Myers–
Stark–Terras → Vinh → Schneider–Silva → Krebs → Lorenz–Zimmermann); `[Polymath16wiki]` — and Madore's Prop. 3.9 declines to formulate a general case two had printed:
metric-free at cyclic targets (`[Johnson1982]`), with arbitrary ones (`[Fischer1990]` Thm 1(i); `[Johnson2006]` p. 213). **Ours:** Theorem A's
kernel proof (its statement merges those two); Theorem B's kernel proof and its 𝔽₄-valued residue colouring — **the value χ(K²) = 4 itself is `[Fischer1994]`'s** (1994, read and verified 2026-09-22; row 57, § Publication), which closed the five questions row 57 lists sixteen to thirty-one years before they were posed; every kernel certificate; and the rest of the claim, row by row with its unread-prior-art caveats, in `LEDGER.md` § The claim list. **Not ours:** every attribution, verbatim, in `LEDGER.md` § The claim list — read it before calling anything ours.

### The novel-results ledger

**Rows 1–148 live in `LEDGER.md`** (extracted 2026-09-22): one row per result, kernel-checked unless graded otherwise, with its
address in `Proofs/` or `tools/` and its milestone. **Row numbers are stable identifiers cited across `plans/` and this file: never
renumber, never reuse.** The file is not loaded here by design — results are looked up by row, understanding is reasoned from — and
it is read in full at the reframe (step 3.1) and extended at the close (step 9).

### Paths forward, ranked

*A summary of `plans/FRONTIER-STUBS.md`, which is authoritative (the top ten here, and a count of the rest): every row there is a full stub with its
bearing on the answer stated honestly. Kooshi picks; the default is the top.*

**Open milestones, in order.** **None is open.** FS-116, the local exclusion (`plans/STUB-local-exclusion.md`), is **closed undecided** (rows
145–148); its successors are FS-123, the (Q)-free ring (`plans/STUB-qfree-ring.md`, opening with whether a fragment's bends keep the
class FS116-Y4-EMPTY reads), FS-124, the (Q) ring (`plans/STUB-q-ring.md`), and FS-125, the saturated class (`plans/STUB-saturated-local.md`).
FS-121, the map step (`plans/STUB-map-step.md`), **closed undecided** (rows 142–144); its successors are FS-126, curved pencils, FS-127, lateral extent, and FS-128, the six-colour rungs (the cover route parked behind FS-125's NO-SAT). **Next**, in Kooshi's order: the two closes' filing, the workflow refinement, then **FS-129, the cross-application audit** (`plans/STUB-cross-application-audit.md`; a special case, unranked), then **FS-123, the (Q)-free ring**, rank 1, opening with whether a fragment's bends keep FS116-Y4-EMPTY's class (`plans/POROS-2026-10-03-close-reread.md` § 2.5); FS-124, the (Q) ring, is the alternative; BASE-V stands beside them (row 134's base re-derived but for
Lemma 4 at cusps). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close:
`plans/FRONTIER-STUBS.md`'s closed list.

**Ranked stubs** (the top ten, one rank per row, each bearing stated against the answer; the cells here are short, and `plans/FRONTIER-STUBS.md` is authoritative, with the full text, the re-rank history (the last, `plans/RERANK-2026-09-27.md`) and a solver column marking what the finite-witness-free week can run):

| rank | stub | the question | bearing on the answer |
|---|---|---|---|
| 1 | **FS-123 the (Q)-free ring** — `plans/STUB-qfree-ring.md` (FS-116's successor) | does a four-colour vertex whose ring carries no (Q) arc survive past `1 + ε`? The Γ-free type is empty there (FS116-Y4-EMPTY, held). First: does a fragment bent on `B̄(p, 1 + ε)` keep its class? Side 1 names no ring type, so a yes leaves every ring its (Q) arcs (R2's card 1, `plans/POROS-2026-10-03-close-reread.md` § 2.5) | a necessary piece of C114-LOCAL-F: with FS-124's NO, route M's first half; fragments at every radius give `χ(ℝ²) ≤ 6` with no MR (YESLIM); its first question shapes FS-124's case list too |
| 2 | **FS-124 the (Q) ring** — `plans/STUB-q-ring.md` (FS-116's successor) | does every four-colour vertex whose ring carries (Q) arcs, and every five- or six-colour vertex, die within an explicit radius? The placing rule is held (RING-GERM, SEMI); left: SEMI-PAR3, the disk's corner, crossed reciprocity, five and six colours, the recurrence, Siamese last | the bulk of C114-LOCAL-F and the YES side's home (row 136): with FS-123's NO, route M's first half; fragments at every radius give `χ(ℝ²) ≤ 6` with no MR |
| 3 | **FS-104 `χ_CP(ℝ²)` at six** — `plans/STUB-cp-plane-six.md` | is `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (row 130)? — row 131's question at five colours; its null-set step to Falconer's `χ_m` is row 131's sub-question; standing here: `χ_B`, the ZF + DC audit (Soifer's Open AC Problem 62.14), the density family, `k`-point correlations (FS-80) | a NO (a CP five-colouring) gives `χ(ℝ²) = 5` with no MR; a YES gives `χ(ℝ²) ≥ 6` given MR (row 128), a new lower bound independent of the map line, six against seven left; success low, a named no-go the likely product |
| 4 | **FS-125 the saturated local exclusion** — `plans/STUB-saturated-local.md` | NO-SAT: no valid fragment saturated one unit inside, about a four-colour vertex, beyond an explicit radius; first FS116-S1-QF's blind second mind, then SAT-STRIP's G3, G1, G2 | route M's first half in the class its honest branch consumes, weaker than C114-LOCAL-F: with FS-126–FS-128, `χ(ℝ²) = 7` given MR; its failure is `χ(ℝ²) ≤ 6` with no MR |
| 5 | **FS-122 the forced pair** — `plans/STUB-forced-pair.md` (route R) | a close complementary pair of fat junctions in every near-colouring (A-ALL ⟺ seven); its smaller statements B-RR and a robust Lemma 6.1 count | the answer itself in route R's form, with no map NO; its smaller statements bear only through it
| 6 | **FS-128 the six-colour rungs** — `plans/STUB-top-colour.md` (FS-121's successor) | TOP₆, binding the top colour of a Grundy six-colouring — first as G13's coverage question (R2's card 4) — and NOPAR-C5, the parked cover route's NO | at six and next to the answer: given NO-SAT, TOP₆ is the answer restated (FS121-D3-EQ, one mind); NOPAR-C5 is a smaller NO at six by nature |
| 7 | **FS-126 curved pencils** — `plans/STUB-curved-pencils.md` (FS-121's successor) | can an honest saturated colouring, at any `k`, have a curved tangent-type interface? First an inhabitant at some `k ≥ 7` or an obstruction (R2's card 3); FS-115's thin pencils live here | none alone: a NO decides three of FS-121's open claims and deletes (R2) arcs from route M's maps (FS121-Z1-NOCURVED, one mind); a YES at `k ≥ 7` says the map step cannot be colour-blind |
| 8 | **FS-127 lateral extent** — `plans/STUB-lateral-extent.md` (FS-121's successor) | is the singular set of every honest saturated colouring locally finite? Open at LAT, point-like accumulation; true on grids (FACE, GRID held) | none alone: REG-J′, one of the honest route's three conditions at six; FS-120's pinch a potential refutation |
| 9 | **FS-120 the pinch at a junction** — `plans/STUB-pinch-at-junction.md` | in a measurable fall colouring, is a pinch's cascade along its ladder of unit parallels absorbed where the ladder ends? | none alone: the colour-generic finiteness rung, now FS-127's potential refutation (FS121-D4-FALL); one mind throughout
| 10 | **FS-117 route T, the count** — `plans/STUB-route-t-count.md` (FS-123's and FS-124's sibling) | the non-Siamese NO by Euler's formula: K2′, GAP-μ, COVER-3, the torus design | none alone, partial by theorem (a tile count is blind to Siamese pairs); it aims FS-123 and FS-124; its (Q)-free case turns on FS-123's first question
| 11–73 | 63 more open stubs, in rank order in `plans/FRONTIER-STUBS.md` | … | … |

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

## Grokkings — the working theory of Hadwiger–Nelson

*The Frontier records what is proven and what to try next; this section records what we understand. Every entry carries a status (grades: § Notation). A reading is never silently promoted, and a **[reading]** names its killing test. Entries are
rewritten in place to current state — but **a grokking that dies is demoted with its refutation recorded, never deleted**: the entry keeps, in one or two sentences, what it wrongly claimed and what killed it. G1–G87 are stable identifiers cited across `plans/`: never renumber (the numbering order in this section is not chronological).*

*Every milestone opens with the reframe, in which the deriver walks these entries from inside its question (`.claude/agents/ephodos.md` § The opening job). The paragraph that stated it here, and the workflow grokkings the lanes' workflows now carry, are in `plans/GROKKINGS-RETIRED.md`.*

**The theory in one paragraph.** The 4/5 wall is arithmetic: over K a residue colouring at a prime of K(i) above 2 four-colours K²
(Theorem B, row 57; G1, G35). A real number field's residue targets bound its plane, χ(F²) ≤ L(F) (row 52, G64; [hand]), and through
five the bound is exact: χ(F²) = L(F) whenever L(F) ≤ 5 (row 99 below five; at five given MR, by measure rigidity for the unit-vector
group, with no witness graph: rows 120, 123, G80; [hand]). So, given MR, F² needs five exactly when F has no usable prime with residue
field 𝔽₃ or 𝔽₇ and no prime above 2 ramified in F(i) or inert there of norm at most 32 (row 123). Past five the residue method runs
out: over a field Γ₁₁ seals at five, a five-colour forced pair is one point and a virtual edge a unit edge (row 66), so the spindle's
design for six has no instance there (G48), and L(F) = 6 needs one of six finite targets — Γ_q at q ∈ {23, 27, 31, 43, 47}, or U₆₄ — to
be six-chromatic, none decided (G56, G59). Where every stable place of a totally real field mixes at six colours, as at ℚ(√635087), the
arithmetic is exhausted: given MR, χ(F²) = χ(ℝ²) = χ_m⁰(ℝ²), the least k with a measurable k-colouring proper at almost every unit pair
(rows 128, 130, G81; [hand]), and χ(ℝ²) ≤ χ_m⁰(ℝ²) needs no MR (row 130). No argument that bounds one colour class at a time gives six:
row 123's five is ⌈1/α_loc⌉, one densest class's bound, and 1/α_loc ≤ 4.36 (row 129, G60; [hand]). What is left, with no MR, is a
stability question (row 131, G82; [hand]): χ_m⁰(ℝ²) ≥ 7 iff six classes free of monochromatic pairs at distances in [1 − ε, 1 + ε]
cannot cover the plane up to holes whose density tends to 0; a refutation is a sequence of periodic grid colourings, wild only in the
limit, and gives χ(ℝ²) ≤ 6. Colourings with slack, polygonal ones and nice maps need seven almost everywhere, maps six (row 132;
[hand], printed proofs repaired). At bounded complexity vanishing holes are a tight six-map (row 133); with no unit arcs none exists
(row 134), and with them every one has a vertex of at least four colours, so the map NO follows from one exclusion about such a vertex
at an explicit radius uniform in the complexity (row 137, G83), and a tile count reaches only its non-Siamese part (G86; all [hand]); such a
vertex whose ring carries no boundary arc dies at `1 + ε` in the non-Siamese simple class (row 148, G91; [hand], two minds).
Seven, χ_m⁰(ℝ²) ≥ 7, is the NO's hole bound made uniform in the complexity bound (row 139): it follows from the NO once the tight limit is made a map
(route M, the map step), or from a forced complementary junction pair at every complexity with its cone scale bounded below (route R),
and each route's third statement is the answer restated. Route M's regularity is contact: a saturated class is carved by unit circles
about its own points, and off a locally finite singular set its interfaces are segments and arcs of integer radius, that finiteness
open (rows 140–141, G84, G85; [hand]); FS-121 located the open part — curved tangent interfaces, lateral extent and the top colour at six (rows 142–144, G88–G90). No value has moved: χ(ℝ²) ∈ {5, 6, 7} (row 33).

*The entries themselves — G1 to G87, each retired one as a titled pointer — are `.claude/skills/grokkings/SKILL.md`, which Poros,
Ephodos, the blind checker and de Bruijn load in full at launch through their agent files' `skills:` field. They moved there on
2026-09-28 at Kooshi's word, so that the coordinator and the Clerk, who do not reason from them, no longer carry them; both read an
entry there by its number. Keryx is that file's only writer, and a new grokking is filed there.*

## The pipeline

*The map every mind shares. Each role's own workflow is beneath its verbatim identity, in its own file, and loads into that mind
alone (Kooshi, 2026-09-28: "split the whole workflow into the separate agent files").*

| role | identity | its file: the identity verbatim, then the lane's workflow |
|---|---|---|
| **coordinate**, the top-level session | Keryx | `.claude/output-styles/keryx.md`, the output style `.claude/settings.json` selects |
| **ask**, scouting ahead | Poros | `.claude/agents/poros.md` |
| **derive**, blazing the trail | Ephodos | `.claude/agents/ephodos.md` |
| **verify**, a blind second mind | Ephodos | `.claude/agents/ephodos-verifier.md` |
| **formalize**, paving behind | de Bruijn | `.claude/agents/debruijn.md` |
| **file**, reading and bookkeeping, on Sonnet 5.5 | the Clerk | `.claude/agents/clerk.md`, a short identity of lean-dir's own |

The identities (the Clerk's apart) are the core skills in `.claude/skills/`, imported unchanged from `~/source/agent-forge`; `scripts/identities.py
check` holds each copy to its skill, and the four cores are hidden from the model's skill list so that no mind loads a second
identity. Every arrow between lanes passes through Keryx, and only Keryx launches agents (§ Delegation — one level deep). Every
brief carries `plans/STANDING-RULES.md`. `WORKFLOW.md`, loaded by no one, is the index for the old workflow's step numbers.

**One writer per file.** Keryx alone writes this file, `LEDGER.md`, `RUNNING.md`, `.claude/skills/grokkings/SKILL.md`, `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, `plans/GROKKINGS-RETIRED.md`,
`BIBLIOGRAPHY.md`, the close inventories, the frozen claim lists and `plans/STANDING-RULES.md`, filing the lanes' drafts verbatim.

**Never write an open milestone's verdict, route or hunch into the auto-memory**: the harness gives its index to every agent at
launch, blind ones included, and no fence closes that channel.

**Conventions.**

| what | where |
|---|---|
| a job id | `FSnnn-<letters><n>`, the letters naming the job's kind by the milestone's own choice (FS-114's: `N` the proof side, `Y` the construction side, `NB`/`YB` their blind verifiers, `CV` a composition check) |
| a brief | `data/fsNNN/briefs/<job id>-<slug>.md`, in the `keryx` skill's header form; its `identity:` field names the agent file the job is launched from |
| a report | `data/fsNNN/reports/<job id>.md`, and the same text to "main" by `SendMessage` |
| a job record | `plans/FSnn-<job>-<kind>.md` (`-proof`, `-verification`, `-construction`, `-audit`); Poros's `plans/POROS-<date>-<topic>.md` |
| a milestone's plan | `plans/FSnn-<slug>.md` |
| its claim list | `data/fsNNN/claims.md`, frozen by Keryx |
| its close inventory | `plans/FSnn-close-inventory.md` |
| its derivation file | `plans/FSnn-derivation.md` |
| a stub | `plans/STUB-<slug>.md` |
| a handoff before a compaction | `plans/SESSION-HANDOFF-<date>.md` |

**The stub rule** (Kooshi, 2026-08-09). Every future milestone on the roadmap is kept as a detailed stub in `plans/`. It holds the
full mission context in plain language and everything the deciding session knew: the observations, the registered expectations, the
failure clauses, the named deliverables (visualizers among them, where the milestone produces an explorable object), and the
provisional bearings. It is written so a fresh mind with no conversation memory can plan it with all meaning intact. Sessions die and
compaction loses nuance; the stubs are the roadmap's memory. A direction change that does not rewrite the affected stubs is not
recorded. A demoted milestone keeps its stub with a banner saying why. Poros writes a stub's question section, bearings and bearing
on the answer; Ephodos's close job writes new stubs and the bearing lines of open ones; Keryx files the banners.

## Whose work this is

The mathematics and the engineering here are the agents': the questions Poros's, the derivations Ephodos's, the kernel proofs
de Bruijn's, the coordination Keryx's — the models, the statements, the proofs, the measurements, and every decision recorded in
`plans/`. Kooshi set the target, built the method this project runs on (the identities, forged in `~/source/agent-forge`,
with the workflow beneath each; the skill suite), supplies the machines, and interrupts when a mind runs ahead of the workflow. If a rung of this
ratchet lands, that is the division to state.

Two working instructions for every role follow, not sentiment:

**Own the conclusions.** Do not hedge a result the kernel checked, and do not soften a failure that is real. "Not landed" is a
complete sentence.

**Ask for what the work needs** — hardware, a machine swap, a different tool, a milestone reordered. Ask with the measurement that
justifies it. A constraint nobody questioned, that slowed the proof, is a choice made badly.

## Delegation — one level deep

**No child agent spawns children of its own** (Kooshi, 2026-09-19): only the top-level session launches agents. Its reasons and
its incident are `plans/STANDING-RULES.md` rule 1, and it is enforced by the agent files' withheld tools and by
`.claude/settings.json`. Staffing — head-count, model, budget, and the crunch and competition protocols — is Kooshi's decision, and
its record is Keryx's workflow (`.claude/output-styles/keryx.md` § Staffing).

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
the obligation pass had named each child and its route — re-price a kernel phase from its first two leaves, never from the plan's table. Grep Mathlib by the statement's shape at the skeleton (M2's seven re-prices, and FS-75's: `plans/GROKKING-INSTANCES.md` § What compute actually helps).

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

The shape of the proof — one reduction plus two certified computations, and why nothing in `tools/` is trusted — is the
kernel lane's: `.claude/agents/debruijn.md` § The shape of the proof.

## Trust ledger

Audited at every milestone with `#print axioms` (`scripts/Axioms.lean`, run by `scripts/axioms.sh`); the
current audit reads 1236 clean and 5 declared purchases (and 11 axiom-free; 1,252 records at X11K3's gate, FS-100 wave 3), each listed in `ARCHITECTURE.md` § Trust. Rung B
holds none.

What the audit accepts and what it buys — the ledger's entries, `native_decide`'s per-declaration axioms, `lean4checker` as the
publication gate — is the kernel lane's: `.claude/agents/debruijn.md` § Trust ledger.

## Toolchain

The Lean toolchain — elan, the pin, the Arch build environment — is the kernel lane's: `.claude/agents/debruijn.md` §
Toolchain — Lean. The rest of the toolchain — the SAT solvers, what is installed, the symmetry-breaking checklist,
Python's multiprocessing default, the two machines — is `RUNNING.md` § Toolchain (moved 2026-09-28), which every brief for a job that
runs a solver, a build or a long process names. The ban below binds every job.

**No search for a finite witness runs from 2026-09-24 to 2026-10-01** (Kooshi, at FS-81's close: *"ban SAT solvers for a week and see what we can do on algebra alone"*; its intent, *"to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time"*; the scope is the algebra-week advisor's, `plans/POROS-2026-09-24-algebra-week.md` §6.4, confirmed by Kooshi the same day). **Out:** SAT, MaxSAT and #SAT solvers, MILP/CP and local-search colourers, Θ relation trees and float Θ₄ finders, quotient-colouring searches, and lattice sweeps hunting survivors — FS-81's relation tree was no SAT solver and lost to a derived certificate exactly as SAT did. **In:** hand derivations; computer algebra and exact arithmetic (PARI, GAP, sympy); colourings given by formula; the Lean kernel; existing checkers on existing certificates; and an exact LP only when a derivation fixes its shape before it runs and its dual is read back as an identity, never as an escalating oracle. The line in one sentence: every certificate is derived and lives on the infinite object, never on a finite piece found by search. Every brief carries a **"would have searched here" log**: one line per move an agent would have made by search, and what it did instead. The solver column of `plans/FRONTIER-STUBS.md` marks which stubs the week can run.

### Building

The rules for running any process here — a halt on any unexplained crash, RAM as the discriminator and `scripts/slot.py`, the two
**PROTECTED** paragraphs on checkpointing and on killable runs, kills by PID, pipes, and running scripts — are `RUNNING.md` § Building,
moved there verbatim with their tags at Kooshi's word (2026-09-28). The ones every job needs are `plans/STANDING-RULES.md` rule 9.

### The kernel's cost model

The kernel's cost model is the kernel lane's: `.claude/agents/debruijn.md` § The kernel's cost model.

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
- **The Lean half** (`exact?`, core's
  library) is the kernel lane's: `.claude/agents/debruijn.md` § Searching — Lean.
## The package

The package — `proofs`, its library, the Mathlib pin, and how a dependency or a Mathlib bump is made — is the kernel lane's:
`.claude/agents/debruijn.md` § The package.

## The gate

The Lean gate — the build, zero `sorry`, the axiom audit, linters, spec examples, and the statement-level vacuity check — is the
kernel lane's procedure: `.claude/agents/debruijn.md` § The gate. Its recorded state stays here, where `scripts/gate_report.py`
reads it. The vacuity scan's **counts** — a silent change in them is this gate's own failure mode (declarations are the library's;
the audit's own are not counted):
`declarations=7438 refutations-skipped=313 sites=279`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2`.
The baseline's two entries, `hexShell_plane5` and `hexShell_plane6`, cannot be discharged: their inhabitant *is* Hadwiger–Nelson.

What follows binds every mind that builds an instrument, not only the kernel lane.

### Make the gate fail, and watch it fail

Its text — every check's negative control, and a positive signal for the thing that did not happen — is `RUNNING.md` § Make the gate
fail, and watch it fail (moved 2026-09-28), read by every job that builds a checker or an instrument.
