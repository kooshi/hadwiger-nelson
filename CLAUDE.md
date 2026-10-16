# This workspace — lean-dir

A Lean 4 proof workspace aimed at one target: **the Hadwiger–Nelson problem**. Its work runs as a pipeline (§ The pipeline): Poros asks
the question and ranks the frontier, Ephodos derives the answer, de Bruijn formalizes it in Lean — a milestone closes only when its
module passes the kernel's gate — and Keryx coordinates. **Who you are is set by how you were launched.** The top-level session is Keryx,
whose identity and workflow are the output style `.claude/output-styles/keryx.md`, which `.claude/settings.json` selects. An agent
launched from `.claude/agents/` is the identity its file names, with its lane's workflow beneath. This file is every mind's shared
context, never an identity. Everything reduces to what the kernel checked plus what we explicitly chose to trust.

**This file holds current state only, and so does every file an agent loads at launch** (Kooshi, 2026-10-03: *"any context which is
loaded every time an agent runs must only reflect the current state of affairs, and cut narration and old instances and dated edit
history."*). Every update rewrites the affected text in place: no dated amendments, no correction trails, no superseded rankings, no
milestone narratives. A corrected claim is replaced by the corrected claim (with its attribution, if it turned out to be prior art); the
story belongs in the commit message and the milestone's plan. **History is in git** (`git log -p -- CLAUDE.md`); the last version with
the full narrative is commit `fd658af`, and the text Workflow 3.1 cut is `plans/HISTORY-WORKFLOW-3.0.md`. **Size budgets: this file
under 80,000 bytes, and the grokkings file (`.claude/skills/grokkings/SKILL.md`) under 200,000** (Kooshi, 2026-09-28);
`tools/claude_md_fact_audit.py` fails when either is over. A budget is a ceiling, never a licence: one reached is met by moving what a
session does not need to a file read by address, never by trimming a rule's reasoning. **One home per fact**: numbers, certificates,
names and addresses in a row of `LEDGER.md` (read by address, never loaded); mechanism and readings in a grokking; a rule's later
instances in `plans/GROKKING-INSTANCES.md`; a retired grokking in `plans/GROKKINGS-RETIRED.md`; the Lean facts in `LEAN.md`; every other
mention points. At every filing run `tools/claude_md_fact_audit.py` with `--base <the previous filing>` (nothing lost, across every file
it joins) and `--dupes` (nothing retold). **A paragraph tagged `[PROTECTED — never compress …]` is exempt from every trim (Kooshi,
2026-09-15): the tag marks reasoning whose loss has already cost hours.**

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
  believed and falsifiable — it names its killing test); **[external]** (claimed in the literature, unchecked here); **[kernel, outside]** (kernel-checked in an outside library at its own pin, built and audited here; it enters this library as a declared outside theorem); **[method]** (a
  working rule).

## The mission

How many colours does the plane need so that no two points at distance exactly 1 share a colour?
Known since 1950 to be 4, 5, 6, or 7; de Grey (2018) ruled out 4 with a 1581-vertex unit-distance graph
that is not 4-colourable. `[OAIMath2026]` (2026) ruled out 5 (row D below).

| rung | status |
|---|---|
| **A. χ(ℝ²) ≥ 4** — the Moser spindle | ✅ kernel-checked; exercised the whole pipeline end to end |
| **B. χ(ℝ²) ≥ 5** — de Grey's graph | ✅ kernel-checked (M06–M09) on axioms exactly `[propext, Classical.choice, Quot.sound]`; our foundation, not our product. Also derived with no witness object, at [hand] (§ Where the problem stands) |
| **C. The search instrument** — shrinking, criticality, fractional bounds, fans, sweeps | ✅ built through M17, extended by every milestone since |
| **The upper end** — χ(ℝ²) ≤ 7 | ✅ kernel-checked (M36), so the repository holds **5 ≤ χ(ℝ²) ≤ 7** on the standard three axioms. Not new mathematics: it exists because the certificate machinery is the promotion path for any future periodic avoider, and a six-colour avoider IS the open upper-bound problem (five is excluded: row D) |
| **D. The answer** — χ(ℝ²) decided | open at six against seven. **`6 ≤ χ(ℝ²)`** is `[OAIMath2026]`'s — a transfer from arbitrary to measurable colourings and an obstruction to five there; kernel-checked in its own library, built and audited here (EXT-OAI1), read in full (EXT-OAI2) — so `χ(ℝ²) ∈ {6, 7}`. **This library holds `6 ≤ χ(ℝ²) ≤ 7` on one declared outside theorem** (`Outside.OAI158.chromaticNumber_plane_six_or_seven`, kernel-checked from the axiom `Outside.OAI158.no_proper_five_coloring`, the release's stored statement term for term); what it proves with no import is still the classical interval `5 ≤ χ(ℝ²) ≤ 7` (row 33). With no hypothesis the problem is one question about measurable colour classes — in this library a theorem on the standard three axioms, through `[OAIMath2026]`'s transfer `Outside.OAI158.proper_to_borel_weak`, its proof ported and checked by this kernel (FS131-LP1): `seven_le_chromaticNumber_plane_iff`, `7 ≤ χ(ℝ²) ⟺ lim_{ε→0} µ₆(ε) < 1` — and both of its answers decide the problem (§ The aim) |

### The aim

**Solve Hadwiger–Nelson outright, verify every step in Lean, then publish** (Kooshi, 2026-09-26): *"My goal is to fully solve, and then
verify in Lean, HN. Then we publish. (Anything we do must be formalized in Lean before publishing, that's the bar for AI found proofs, and I
think we can go all the way to an HN solution)"*. It replaces every earlier target (six; "no field's plane is six-chromatic"; the ladder
skipping six): *"You can remove the old goals. We blaze the trail now."*

**The direction: the regularity wall** (the owner's reading, 2026-09-26, adopted by Kooshi; each link at its grade):
1. **The plane is the measurable problem, with no hypothesis.** `χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)` — the fewest colours in a Lebesgue-measurable colouring whose unit pairs are bichromatic almost everywhere — at every number of colours (`[OAIMath2026]` Thm 1.3: measure rigidity proved at the real algebraic numbers, where no place is stable; `χ_m⁰ ≤ χ` kernel-checked in its library and audited here; `χ_CP = χ_m⁰` is row 130's). It also equals `χ(F²)` at every real number field whose stable places all mix at six colours, ℚ(√635087) and de Grey's field among them — in the kernel since FS131-ICO2, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 and, at the two fields, Weil's bound (row 128; `Collapse.chromaticNumber_planeOver_eq_plane_of_thick`). What is left is analysis in `ℝ²`.
2. **Upper bounds need no MR.** `χ(ℝ²) ≤ χ_m⁰(ℝ²)`: move a measurable colouring by a random rigid motion; each edge of a finite graph is
   bichromatic almost surely, and de Bruijn–Erdős finishes ([hand, two minds]: FS103-N's N-EASY, PA1's (E)); its argument is in print
   (`[GwynStavrianos2022]` Lemma 2, Thm 2, under an invariant mean; the Haar-average line unprinted, row 130), and choice enters at
   de Bruijn–Erdős alone (a reading, one mind; `[ShelahSoifer2003b]` p. 42 names that step).
3. **Density cannot give six.** One colour class at a time is capped below 4.37 (row 129); a proof of six must use how the classes fit
   together, never only how large each is. `[OAIMath2026]`'s six does exactly that: labels on a ring, the graph of adjacent classes, the nerve of the cover (`plans/EXT-OAI2-reading.md` § 3.4).
4. **Regular colourings need seven, verified and almost everywhere** (row 132). Closed colour classes need seven (`[Voronov2023]` Thm 1.3: six
   closed sets covering a disc of radius 3 realize the unit distance; closedness enters once, as compactness giving a band), and so does any
   colouring with slack (Thm 1.1) — proofs repaired locally, the paper an unrefereed preprint. Almost everywhere, boundaries free: slack needs
   seven; polygons and locally finite convex tilings need seven, `[SokolovVoronov2025]` repaired, its map theorem a
   GAP at the fills; nice maps need seven (`[Thomassen1999]`). Maps need six, of every kind and almost everywhere, by citation: every measurable colouring proper at almost every unit pair needs six (`[OAIMath2026]` Thm 1.4), Jordan boundaries included. This project's proof for arc maps (`[Woodall1973]`'s steps 1–6, step 6 by Townsend's lemma, FS131-E1's lemma in place of his steps 7–8) stands as a second route.
5. **So Hadwiger–Nelson is one question: can vanishing holes save the seventh colour?** `χ(ℝ²) = χ_m⁰(ℝ²) ∈ {6, 7}` (`[OAIMath2026]` Thms 1.3, 1.4), and `χ_m⁰(ℝ²) ≥ 7` iff six classes, each free of monochromatic pairs at distances in `[1−ε, 1+ε]`, cannot cover the plane up to holes of density tending to 0 as `ε → 0` (row 131; `[SokolovVoronov2025]` §9's hypothesis). A refutation needs no wild set: it is a sequence of periodic grid-square colourings, wild only in the limit, whose normal form FS-103 holds, or valid fragments on discs of every radius (row 145) — in measure, exactly: `χ(ℝ²) ≤ 6` iff every open disc has a measurable six-colouring proper at almost every unit pair, toward seven through the release's Borel transfer (row 161; [kernel] since FS124-L1, on the standard three since its proof was ported, FS131-LP1). Both answers decide the problem. *No* — Voronov's contradiction survives a free colour of vanishing density — gives `χ(ℝ²) = 7`. *Yes* — such a sequence with six colours — gives `χ(ℝ²) = 6`: the first move of the upper bound since 1950. At five the answer is in: the holes stay of density bounded below (`lim µ₅(ε) < 1`; row 131 with Thm 1.4).
6. **Its tools are Voronov's circle topology made robust, and the density topology** (approximate continuity, Lebesgue density, De Giorgi's
   structure theory for finite-perimeter classes) — the room after ergodic theory in G30's ladder. A third tool is `[OAIMath2026]`'s nerve: off a locally finite set of centres a measurable five-colouring's smoothed classes are a continuous map into the complete graph on the colours, and covering dimension forces a point with interface continua carrying Sokolov–Voronov's exclusion — no regularity of any class. At six, where no boundary is a unit arc about a ring point, the exclusions it feeds read no regularity and no normal form, and cyclic centres exist with no hypothesis (FS-132, rows 155–157, 159; [hand], one mind each); what still asks for a normal form, not yet chosen, is existence — a centre isolated among the centres, and finitely many changes of the three outside labels on a triangle centre's ring (rows 156, 158) — each false under local slack (`plans/EXT-OAI2-reading.md` § 4.3; G95). Two proof shapes are closed (row 131):
   counting holes met by circles caps at `O(ε)`, and trichromatic points vanish from partial colourings; the index of density traces fails
   where a unit-arc interface faces a bowtie (row 132). A reading, with its test: finite perimeter is Lipschitz-in-probability, the
   quantitative form of the continuity every CP colouring has. Killing test: a CP colouring whose disagreement `P(c(0) ≠ c(h))` is
   continuous but not `O(|h|)` along every optimal family.

**The program** (`plans/STUB-regularity-wall.md`): **FS-106, the regular half — closed** (rows 131–132); **FS-107, stability — closed** (row 133):
Voronov's contradiction survives a free colour if a complementary junction pair is forced at a scale bounded below, and vanishing holes at bounded
complexity are a tight six-map; **FS-110, the tangency seam — closed** (row 134: none under Condition 5); **FS-112, the unit-arc half — closed** (rows 135–136);
**FS-114, the unit-arc question — closed** (rows 137–138: one local exclusion about a four-colour vertex suffices for the NO); **FS-116, the local exclusion — closed** (rows 145–148: the Γ-free four-colour vertex dies at `1 + ε`); its successors **FS-123, the Siamese class**, **FS-124, the (Q) ring**, **FS-125, the saturated class**;
**FS-117, route T's count** (the non-Siamese part); **FS-115, the stuck ray** (the density form only); **FS-111, the cone scale and the regularity step — closed** (rows 139–141); its successors **FS-120, the pinch at a junction**, **FS-121, the map step — closed** (rows 142–144); its successors **FS-126, curved pencils**, **FS-127, lateral extent**, **FS-128, the top colour, at six**, **FS-122, the forced pair**; on `[OAIMath2026]`, **FS-132, six by the nerve**, and **FS-133, the one-class transfer — closed** (row 129; FS133-LD1); **Lean throughout** — MR in full
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
where L = 7 — the field the ρ₆₃ arena already produced a five-chromatic object in (row 64). Its proved range is `plans/WHERE-THE-PROBLEM-STANDS.md` item 10's — every `L ≤ 5`, at [hand] through MR (row 123), and in the kernel since FS131-LGT1 on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3. **Its exposed predictions:** exactly five at ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√3,√5) — **all met**, in the kernel since FS131-LGT1 on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3 (rows 120–121, 123; `Instances/SqrtFortySevenFive`, `Instances/SqrtClassValues`); and at least six at **ℚ(√167)**, proven 4 in the kernel (row 119) and ≥ 5 in the kernel since FS131-LGT1, on the two outside theorems (`SqrtClassValues.five_le_chromaticNumber_planeOver_sqrt167`; row 123), the
widest gap, at discriminant 668 (characters need eight there, row 101). Four at the census's 25 open fields, at every squarefree
d ≡ 11 (mod 12) and at ℚ(α,√7), α³ = α + 1, is met (rows 82–83, 99). At the fields where every place mixes, its prediction is the answer
itself: seven at ℚ(√635087) is `χ(ℝ²) = 7` (row 128; the equality `χ(ℚ(√635087)²) = χ(ℝ²)` in the kernel since FS131-ICO2). **A finite refusal only confirms**: a prediction falls to a colouring of the
whole plane with fewer than L colours, local at no prime (G48), so five over ℚ(√167), held at [hand] (row 123), confirmed it and could not
falsify it, and only FS-64's windowed form still aims at one (its one-character case is closed, rows 96, 101). Believing the answer is seven
is not evidence for seven; the value-skipping that motivated the belief was compatible with five until `[OAIMath2026]`; now some real number field's plane needs six (its transfer reads the colouring only on the algebraic plane), so `L(F) ≥ 6` is attained with `χ(F²) ≥ 6` somewhere, and the conjecture's open content is which fields and whether six or seven.

**The mission is exclusively a hunt for new mathematics, however small, ratcheting toward major findings**
(Kooshi, 2026-08-02). A formalized statement earns its place by being structure nobody had named, or a rung
toward the answer. State failure modes plainly: a rung that does not land is reported as not landed, never
quietly rescoped.

**The programme** (Kooshi, 2026-09-06; his words and the assessment in full are in
`plans/PROGRAMME-ALGEBRAIC-PROOF.md`): *the derivations are an order of magnitude more important than
individual objects.* The answer is published as the derivation, with any object as its example, and one account covers both bounds. The
arithmetic viewpoint — the arithmetic of small primes governs the chromatic number — carried the problem to the fields where every prime
mixes (row 128) and is exhausted there; from there the problem is archimedean and measurable, and both bounds are one question (§ The aim).

**Publication.** **Nothing is published before it is formalized in Lean, in full.** A milestone may assume the literature (Kooshi,
2026-10-03: *"for milestones, we can trust the literature"*), each import documented (`LEAN.md` § Assumptions); before publishing, the
cost of landing everything on the standard three axioms is measured, and Kooshi prefers the three axioms *"if it's just a week or so of
agentic work"*. Write-ups and upstreaming stay deferred until then (Kooshi, 2026-08-04: the rung-B write-up, Mathlib contributions,
exposition, and the M58–M61 sieve arc). A result held at [hand] is not yet publishable; formalization is never a cost that ranks routes
(§ Counter-priors). A finite witness for six is out as a route: *"search for a finite graph is out. It would be huge, not feasible."*
What clears the bar, once formalized:
- *definitely* — the answer, written as the derivation (the programme);
- *a result that answers a question the literature has independently and repeatedly posed*, whatever its size (`CLOSED-QUESTIONS.md`).
  Held so far: at [hand], given MR, `χ(ℚ(√47)²) = 5` (row 121) answers Moorhouse's named question (2010) and the existence half of
  Soifer's Open Problem 55.1 (2019), in the kernel since FS131-LGT1 with no hypothesis of ours, on two declared outside theorems (Weil's bound, `[EinsiedlerLindenstrauss2022]` Thm 1.3); with no hypothesis, row 129's plane clause (FS-133) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's equality question — formalized: in the kernel since FS133-LD1, on the standard three axioms, through `[OAIMath2026]`'s rigidity step, ported; for the plane, prior art not found in print (row 129; `plans/FS131-ER1-davies-reading.md` § Stage 7) — `[Davies2026]` Thm 1.1 proves the same equality in dimensions four and up —; the kernel proof is this project's. The fallback write-up is FS-102
  (`plans/STUB-writeup-main-clause-five.md`).
- **Theorem B's value is `[Fischer1994]`'s**: χ(ℚ(√3,√11)²) = 4, by an additive 4-colouring, a homomorphism to ℤ/4 (K. G. Fischer,
  Congressus Numerantium 104, 73–79), restated in `[Johnson2000]` p. 176 and `[Johnson2006]` p. 214 (`CLOSED-QUESTIONS.md` §1.1). What is
  ours: the kernel proof, Theorem A's metric-free form and reach, the 𝔽₄-valued residue colouring — a different colouring from his
  ℤ/4-valued one (G41) — and every consumer built on B (row 57). **The Theorem B paper is FS-20** (`plans/STUB-theorem-B-writeup.md`;
  whether it is still worth writing is Kooshi's call).
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

*The current state of the art, the ledger of everything novel this project has produced (`LEDGER.md`), and the ranked paths forward,
rewritten in place at every filing; a milestone whose filing does not update this section has not moved state. The understanding the
results add up to lives in § Grokkings; both point (`row 68`, `G56`) and never retell.*

*Last updated: 2026-10-13 — **Workflow 3.1**: a milestone moves Not started → Opened → Derived → Closed, and is Closed only when its Lean
module passes the gate; milestones closed before it keep the word, and their hand results are the Lean backlog. Last filed: **five colours by field and by class** (FS131-KCS1, FS131-ICS1, 2026-10-16: four modules through the gate on `960882257` — for squarefree `m`, `χ(ℚ(√m)²) ≥ 5` exactly when `m ≡ 47, 143, 167 (mod 168)`; `χ = L = 5` at each such squarefree `d` that is a square modulo 11 or 19; `L(F) ≥ 5` exactly when no conjugation-fixed prime of `F(i)` is on an arithmetic list (CLS in full), and the two readings of `L` agree through five; `χ(ℚ(√23, ∛2)²) = 5`, a field with a complex place; stated in `plans/KERNEL-HOLDS.md`; no value of `χ(ℝ²)` moved); before it, **three colours on abelian Cayley graphs** (FS131-KTC1, FS131-ICT1, FS131-ICT2, FS131-ICT3), **the p-adic plane** (FS131-KPA1, FS131-IQP1, FS131-IQP3), **the collapse** (FS131-KCL1, FS131-ICO1, FS131-ICO2) and every earlier filing, newest first: `plans/FILINGS.md`. Earlier closes: `plans/FRONTIER-STUBS.md`'s
closed list, and git.*

### Where the problem stands

**The problem.** χ(ℝ²) ∈ {6, 7}: `6 ≤ χ(ℝ²)` is `[OAIMath2026]`'s (family 158; kernel-checked in its own library on the standard three axioms, the cone built and audited here, EXT-OAI1; its manuscript read in full, EXT-OAI2). **This library holds `6 ≤ χ(ℝ²) ≤ 7` on one declared outside theorem** — `Outside.OAI158.chromaticNumber_plane_six_or_seven`, kernel-checked from the axiom `Outside.OAI158.no_proper_five_coloring`, which is the release's stored statement term for term (FS132-L1). With no import this repository's kernel holds the classical interval, **5 ≤ χ(ℝ²) ≤ 7** (row 33), on the standard three axioms, its lower end through de Grey's graph (rung B). **The lower end now also follows algebraically, with no
witness object:** a subfield's plane is a subgraph of ℝ²'s, so `χ(ℚ(√47)²) = 5` (row 121) gives χ(ℝ²) ≥ 5 — in the kernel since FS131-LGT1, with no hypothesis, on two declared outside theorems: `[EinsiedlerLindenstrauss2022]` Thm 1.3 (`Rigidity.positive_entropy_rigidity`) and Weil's bound (`StandingFive.kloosterman_bound`); the rest of the route — measure rigidity as the chain uses it (row 120's deduction), the count, SP-Cor, T-C(A) — is kernel-checked (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`; rows 120, 121, 127). Kooshi's reading (2026-09-26): "We have now reduced hadwiger-nelson to 5,6,7
*algebraically* rather than by a witness object. That is far more valuable than de Grey's 2018 graph IMHO." **The plane's number is a measurable one with no hypothesis, and a field's**: `χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²)`, the least number of colours in a measurable colouring proper at almost every unit pair (`[OAIMath2026]` Thm 1.3 with row 130) — in this library `χ(ℝ²) = χ_m⁰(ℝ²)` is `Outside.OAI158.chromaticNumber_plane_eq_chiM0`, kernel-checked on the standard three axioms from `Outside.OAI158.proper_to_borel_weak` — the release's transfer, its proof ported and checked by this kernel, its stored statement the release's term for term (FS131-LP1) — and this library's own N-EASY, and row 131's criterion read for the plane itself is `seven_le_chromaticNumber_plane_iff`, on the standard three —, and it is `χ(ℚ(√635087)²)` with no hypothesis (`Collapse.chromaticNumber_planeOver_sqrt635087`, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 and Weil's bound; row 128, in the kernel since FS131-ICO2). Falconer's everywhere-proper Lebesgue-measurable `χ_m` is the same number, by other people's mathematics composed: `Plane.chiM0_eq_chiLebesgue` (`[Davies2026]` Lemma B.1, p. 44, formalized here with its printed proof, with the density-point step the library held; no import), so `χ(ℝ²) = χ_m(ℝ²)` on the standard three axioms (`Plane.chromaticNumber_plane_eq_chiLebesgue`; through the gate, FS131-LC1; the transfer ported, FS131-LP1), and by Thm 1.4 `χ_m(ℝ²) ≥ 6`; the Borel number `χ_B` (`Plane.chiM`) is not decided against it (`Plane.chiLebesgue_le_chiM` is all that is held). On discs (`Plane/RadiusOutside`): `seven_le_chromaticNumber_plane_iff_exists_ball` — `7 ≤ χ(ℝ²)` exactly when some open disc about the origin has no weak measurable six-colouring — and `colorable_iff_forall_ball` at every `k`. *Seven gives such a disc* is the contrapositive of `radius_up` (`exists_radius_of_not_colorable`) and rests on the standard three axioms; *such a disc gives seven* is the contrapositive of `radius_down` and rests on the standard three axioms, through the release's transfer `Outside.OAI158.proper_to_borel_weak`, ported (FS131-LP1). So an exclusion on a disc reaches seven only through the transfer — `[OAIMath2026]`'s theorem —, and weak six-colourings of every disc reach six with no import.

**What the kernel holds, beyond the interval** is `plans/KERNEL-HOLDS.md` (current state, read by address; each clause with its Lean names, axioms and attributions). In short: χ(ℚ²) = 2 and χ(ℚ(√11)²) = 4; the residue upper half `χ(F²) ≤ L(F)` at every real number field; three and four colours over real number fields — the table for `ℚ(√m)` through four and the three-colour criterion (rows 82, 99); the plane's density equality `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` and `m₁(ℝ²) ≤ 0.2470` (rows 129, FS-133); the main clause through five, `χ(F²) = L(F)` whenever `L(F) ≤ 5`, with `χ(ℚ(√47)²) = 5` and its sister values (rows 120–123, 127); the collapse, `χ(F²) = χ(ℝ²)` at uniformly thick fields, ℚ(√635087) and de Grey's field (row 128); the p-adic plane, the posers' question on the Borel chromatic number of `ℚ_p²` answered no and its values at 3, 7, 11, 19 and 23 (row 75); three colours on abelian Cayley graphs — 3-colourable exactly when a character puts every step in `[1/3, 2/3]`, periodically so over a finitely generated group with finitely many steps, periodic colourings dense, so `P = F` at three colours (row 79); Theorems A and B and the finite-plane machinery (rows 52–60); the compulsion toolkit, the Kempe layer and the kernel lane's chain and bridge (rows 42–51, 78, 103–107); FS-75's `χ(ℚ(√167)²) ≥ 4` (row 119); the seam-field closures, pigeonhole carriers and cell family (rows 1–41). Also χ(Heule-510) = χ(Heule-553) = 5 and χ(de Grey's 1581) ≤ 5.

**What the hunt has established.** Items 1–30 — the arithmetic era: the 4/5 wall, the field sieve and the finite planes, the
local–global conjecture's proved range, measure rigidity and the collapse — are `plans/WHERE-THE-PROBLEM-STANDS.md`, numbered as cited
across `plans/` and read by address; § Grokkings' theory in one paragraph summarizes them. Item 31 is the frontier:

31. **The regularity wall, verified; the question is stability; at bounded complexity, one four-colour vertex** (§ The aim; rows 131–167; FS-117,
   FS-120, FS-122–FS-128, FS-130, FS-134, FS-135). Regular classes need seven almost everywhere — slack, polygons, convex tilings, nice maps — and maps six; closed
   classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded complexity that is whether a tight six-map
   exists (row 133): under Condition 5 none does (row 134); with unit arcs every one has a vertex of at least four colours (rows 135, 137), so one
   exclusion at an explicit radius, above `φ²/√2`, about such a vertex suffices for the NO; where the count gives six room the configurations die at
   `√3` or `1 + ε` but for named cases, and both printed positives are part of no such map (rows 136, 138). FS-116 and FS-129 (rows 145–150, 153):
   valid fragments on discs of every radius give `χ(ℝ²) ≤ 6` with no MR, so that exclusion decides both ways; in the non-Siamese class, simple or not,
   a four-colour vertex whose ring carries no (Q) arc dies at `1 + ε` (row 149: FS-112's bends, run on a whole-tile restriction of radius at most `√3`,
   keep the class and leave only (Q) arcs); the ring's change points off (Q) arcs are four-colour vertices, and two of them 60° apart whose far germs
   lie off (Q) arcs share no sole tip and no sole outer colour (row 150); in the non-Siamese simple class DISC-F follows from the exclusion (row 153);
   open: (Q) rings (SEMI-PAR3, the disk's corner, crossed reciprocity, the recurrence, FS114-K1's residues), five- and six-colour vertices, the
   saturated cross on rings with (Q) arcs, Siamese fragments. The doors are two routes, not halves (row 139, two minds): seven is the NO's hole bound
   made uniform in the complexity bound, so FS-114's NO reaches it only through the map step — or through route R's forced pair, where the NO is idle —
   and each is the answer restated; route M's rungs hold down to the pinch at a junction (rows 140–141; FS-120–FS-122). On route M's map step (rows
   142–144), at every `k`: honest saturated ladders end inward at (Q) or (R2) arcs and never outward, periodic classes have only segments and (Q) arcs,
   and honesty is free; what is open is curved tangent interfaces (one question for three claims), the singular set at lateral extent, and the top
   colour at six, the last the answer restated given a NO; at five, given REG-J′₅, the honest existence form of C-SAT-T is equivalent to
   `χ_m⁰(ℝ²) ≥ 6` (row 154). FS-104's routes (b) and (c) are narrowed from the arithmetic era: a slack residue target kills linear identities and
   confines Falconer fans, and route (b)'s literal reading is empty (rows 151–152). Bearing on the answer: the value moved from outside — `χ(ℝ²) ∈ {6, 7}`, `[OAIMath2026]` — and five is closed at every regularity; this project moved none. For measurable colourings with no map (FS-132; rows 155–160; [hand], one mind each, kernel pending): cyclic centres exist in every closed disc of radius above 1 at every number of colours; at a point where four labels meet in a witnessed cycle the palettes cannot almost everywhere hold an outside label — rows 148–149's exclusion with no Siamese clause; two triangle points on disjoint triples less than 2 apart force an edge set onto a unit circle about their common unit point; the alternating ring is excluded in step form, and a turning ring in step form with witnesses near the centre places a four-label point whose own unit circle runs along two unit arcs. Each stops at one object, a boundary that is a unit arc about a ring point, which nothing here excludes, builds or bounds; none produces a point with such data in an arbitrary colouring. At the unit arc itself (FS-124; rows 161–164; fourteen of its thirty entries [kernel], the rest [hand], one mind each): `χ(ℝ²) ≤ 6` exactly when every open disc has a measurable six-colouring proper at almost every unit pair, the direction toward seven through the release's Borel transfer (row 161, [kernel] since FS124-L1, on the standard three since FS131-LP1); one tight pair forces nothing beyond its first step (row 162; the lemma on an open piece and what it gives at a tight pair's centre and beside its far end [kernel] since FS124-L2, the nothing-beyond by hand); two three-piece points less than 2 apart on disjoint triples force a piece of one of them inside and another outside the unit circle about each common unit point — of both where both are full, at a point of exactly four labels, and one member pays alone only where two of its pieces meet at it only (row 163; [kernel] since FS124-L2 on pieces, for full members, at four labels and for the lone member; for sector points through a three-arcs lemma proved here); FS-112's strip is closed at a point of its top edge against every weak six-colouring keeping six of its pieces (row 164). A statement that reads pieces at named points does cross the unit arc; none gives a colouring a piece. At a point with pieced points on its unit circle (FS-136; rows 165–167; [hand] or computed exactly, one mind each, kernel pending): almost every point near it has a label that is pure, on that point's side, at each of them that carries it, so of two such points whose labels are all six one has a label wholly inside and another wholly outside the unit circle about each common unit point (row 165); the strip, the disk, the flower and the bowtie fragment each stop at such a point, and each stop is excluded for the weak six-colourings that keep the corner patterns of named tiles at its two vertices (row 167); run forward, a corner with one label left has it, a seed of points with three or four labels forces corners at isolated points and never a region — every closure computed stalls within two steps — and a point carrying five labels forces the sixth on a one-sided collar of each arc of its unit circle along which none of the five is pure on that side (row 166). Each starts from regions or corners somebody keeps; none excludes a colouring of a disc. What is open is this item's question at six; of door (A)'s local statement the (Q)-free half is closed in the non-Siamese class, and what is left is a case list — the (Q) rings
   and many-colour vertices, open as FS-124 left them, with what a five-label point's collars force (FS-137, FS-136's successor, unranked), a centre that is not a triangle (FS-122, FS-130), a point with data in every colouring (FS-127, FS-128), the seed's remainder (FS-135), and in the map class the Siamese (Q)-free ring (FS-123, after FS-134) and the saturated class (FS-125).

**The prior-art position**: what is ours, and every attribution, verbatim, is `LEDGER.md` § The claim list — read it before calling
anything ours. The field-plane-to-finite-plane reduction's seven independent lineages are `plans/WHERE-THE-PROBLEM-STANDS.md` § The
prior-art position.

### The novel-results ledger

**Rows 1–167 live in `LEDGER.md`**: one row per result, kernel-checked unless graded otherwise, with its address in `Proofs/` or
`tools/` and its milestone. **Row numbers are stable identifiers cited across `plans/` and this file: never renumber, never reuse.** The
file is not loaded here by design — results are looked up by row, understanding is reasoned from. Its § B indexes the theorems proved
outside the kernel through FS-116 and FS-121; from Workflow 3.1 on, a milestone's derivation file (`plans/FSnn-derivation.md`) is its
theorem record, and no line per theorem goes to § B.

### Paths forward, ranked

*A summary of `plans/FRONTIER-STUBS.md`, which is authoritative: the top three here, the rest there. Poros ranks, choosing the next
milestone; Kooshi may override.*

**Open milestones.** **FS-129, the cross-application audit**, is Derived (`plans/FS129-derivation.md`, 44 entries; rows 149–154; the index corrected and given its where-else column, `data/fs129/index/`); it is
Closed when its compositions pass the Lean gate, in the Lean backlog's session. **Since 2026-10-07 the frontier stands on `[OAIMath2026]` family 158**: `χ(ℝ²) ∈ {6, 7}` and `χ(ℝ²) = χ_m⁰(ℝ²)` with no hypothesis — in this library since FS132-L1 — the first kernel-checked from one declared outside theorem (`Outside.OAI158.no_proper_five_coloring`), the second on the standard three axioms since the transfer's proof was ported (FS131-LP1). **Closed 2026-10-14: FS-133, the one-class transfer** (`plans/FRONTIER-STUBS.md` § Open milestones, in order). **Derived 2026-10-07: FS-132, six by the nerve** (`plans/FS132-derivation.md`, 57 entries: 47 derived, 10 stalls and gaps; [hand], one mind each, the day's search [cert] in its finite family; rows 155–160; stub `plans/STUB-six-by-the-nerve.md`): what a point with data on its unit circle is forced to carry, for every measurable colouring proper at almost every unit pair, with no map — by Kooshi's word (2026-10-07) that is what it delivers, and whether every such colouring has such a point is FS-127's and FS-128's. Its Lean phase's first theorem is through the gate (FS132-L2, 2026-10-07): the first night's exclusion for a Borel colouring of the whole plane — the orbit form `SixRing.no_outside_orbit_points`, `no_outside_orbit` and the ring form `not_ae_outside_points`, `not_ae_outside` (row 155) — kernel-checked on the standard three axioms, with no import and no assumption, over the release's palette lemmas ported with their proofs (`Outside/OAI158Palette` … `OAI158States`; what the module rests on is formalized with it, his word of the same day). The statement on an open set and the clause on an extracted centre stay [hand]. The milestone is Closed when the rest of its module passes the gate: the index lemmas and the centres are skeletons on branch `fs132-wk1`. **Derived 2026-10-07: FS-124, the unit arc** (`plans/FS124-derivation.md`, 30 entries: 29 derived, 1 refuted; [hand], one mind each; rows 161–164; stub `plans/STUB-q-ring.md`; Kooshi's choice): what a boundary along a unit circle about a point one unit away forces in a measurable colouring proper at almost every unit pair that has the pieces concerned — and whether any has them is not its claim. Its first Lean module, the disc criterion, is through the gate (FS124-L1, 2026-10-07; `Plane/WeakColouringOn`, `Plane/Radius`, `Plane/RadiusOutside`, 57 theorems): `7 ≤ χ(ℝ²)` exactly when some open disc has no weak measurable six-colouring (`Plane.seven_le_chromaticNumber_plane_iff_exists_ball`), both halves on the standard three axioms, the half toward seven through `[OAIMath2026]`'s transfer `Outside.OAI158.proper_to_borel_weak`, ported (FS131-LP1); its second is through the gate (FS124-L2, 2026-10-07; `Plane/CircleCrossing`, `OnePiece`, `ThreePiece`, `ClosePair`, `ClosePairWitness`, `ClosePairModel`, `ThreeArcs`, `SectorPoint`; 340 theorems, each on the standard three axioms or fewer, none on an outside theorem and none taking an assumption): what an open piece of one label forces one unit away (`Plane.shadow_open`, `piece_type`, `centre_half`, `tight_centre`, `tight_straddle`), and what a close complementary pair forces at a common unit point (`closePair_forced_pieces`, `closePair_lone`, `closePair_both_separate`, `closePair_four`; `closePair_both_saved` for arc-edged decompositions and `closePair_both_saved_of_isSector` in the claim list's words), the hypotheses inhabited by colourings given by formula on three small discs and the number six shown needed by a control at seven. **The Lean phase is complete for every statement a planner planned** — fourteen of the milestone's thirty entries are kernel theorems; the other sixteen have no kernel job, need a held object's tiles, or are readings, and five of them were handed to the kernel lane and are planned by nobody (C124-ANTIPODE, C124-SECOND, C124-SIX, C124-HALF, C124-FORCED's second sentence). The milestone stays Derived on that. Its eight cases passed to its successor and are open. **Derived 2026-10-07: FS-136, the point across** (`plans/FS136-derivation.md`, 21 entries, each derived; [hand] or computed exactly over named corners, one mind each; rows 165–167; stub `plans/STUB-covering-pairs.md`): what the regions at the points one unit from a point force there, in a measurable colouring proper at almost every unit pair that has those regions — the table, the two counts, the four held stops by two vertex figures, the forward step with its closure, the collar — and whether any colouring has them is not its claim. Nothing of it is in the kernel: its planner (FS136-K1) is launched, blind, on seven statements — the head statement, the count for two members and for one, the two lemmas on corners, the forward step and the collar, the first four a few lines each over `ae_onSide_of_label`, which is a kernel theorem of FS-124's second module (`Plane/ClosePair`, through the gate since FS124-L2); the closure and the exclusions go only with a consumer. Closed when its module passes the gate. Its successor, **FS-137, collars** (`plans/STUB-collars.md`), is minted, unranked. FS-134, the exclusion back to maps, is a short job, unranked. **The Lean backlog (FS-131**, `plans/STUB-lean-backlog.md`; its input `plans/LEAN-BACKLOG.md`**)** stays paused at Kooshi's word (2026-10-07) and restarts on his word; what a milestone's Lean module rests on is formalized in that milestone's own Lean phase. **M63**
stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it.

**Ranked stubs** (the top three; each bearing stated against the answer):

| rank | stub | the question | bearing on the answer |
|---|---|---|---|
| 1 | **FS-136 the point across** — `plans/STUB-covering-pairs.md` (Derived 2026-10-07; kernel pending; the asking lane re-ranks at its next job) | run forward, how far do the regions at two pieced points whose labels are all six force a weak six-colouring — to a corner with no label, a corner with a choice, or round a ring? Answered on every seed tried: a stall at a choice within two steps. Every held stop is such a pair's second common unit point and is closed by the two vertex figures | the local half of both roads from a two-point seed: an empty corner would be an exclusion for colourings with the seed (seven only with a seed for every colouring); a closure is corners at points, never a fragment; a stall is a design's free choices; its successor **FS-137 collars** (`plans/STUB-collars.md`) — what a five-label point's collars force — sits unranked below the ranked rows until the asking lane ranks it |
| 2 | **FS-135 the seed remainder** — `plans/STUB-seed-remainder.md` | does a point with data on its unit circle and no tight pair at its ring points exist — far witnesses, and rings whose germs are only measurable? | the step from "every colouring has a seed" to FS-124's object; its four-cycle half is held (C132-M-EXCL); nothing toward six |
| 3 | **FS-127 lateral extent** — `plans/STUB-lateral-extent.md` | does every measurable six-colouring have a point with usable data in every disc of radius above 1 — for all colourings, or for honest ones? | the existence step of every road to seven through a point; stalled three times in FS-132 and left there by Kooshi's word; nothing toward six — the seed every statement of FS-124 begins with "if" about |
| 4–72 | 69 more open stubs, in rank order in `plans/FRONTIER-STUBS.md` | … | … |

**Closed as directions** (reasons in the grokkings): a five-colouring of ℚ(√167)'s plane from `UD(ℤ/529, 2)`, at any level (row 75); the six-level design target over a sealed field (FS-6) and
the residue-allowed distances (FS-16), both dead by theorem (row 66, G48); the cell family, in both directions
(G29); extracting a gadget from an existing witness (G31); many spindles over one fabric (G40); designing in a
finite plane and lifting (G45); an in-field descent (G34); reaching Parts's record by pure reduction (row 62;
`plans/FS32-smus-reduction.md` §R3).

### The open structural question

Is a pigeonhole necessary for a 6-forcer? `plans/WHERE-THE-PROBLEM-STANDS.md` § The open structural question.

## Grokkings — the working theory of Hadwiger–Nelson

*The Frontier records what is proven and what to try next; this section records what we understand. Every entry carries a status
(grades: § Notation). A reading is never silently promoted, and a **[reading]** names its killing test. Entries are rewritten in place to
current state — but **a grokking that dies is demoted with its refutation recorded, never deleted**: the entry keeps, in one or two
sentences, what it wrongly claimed and what killed it. Grokking numbers are stable identifiers cited across `plans/`: never renumber.
Every milestone opens with the reframe, in which the deriver walks these entries from inside its question (`.claude/agents/ephodos.md`
§ The opening job).*

**The theory in one paragraph.** The 4/5 wall is arithmetic: over K a residue colouring at a prime of K(i) above 2 four-colours K²
(Theorem B, row 57; G1, G35). A real number field's residue targets bound its plane, χ(F²) ≤ L(F) (row 52, G64; [kernel] since FS131-LU1, `UpperHalf.chromaticNumber_planeOver_le_localBound`; the bound is prior art, the kernel proof ours), and through five the bound is exact: χ(F²) = L(F) whenever L(F) ≤ 5 (row 99 below five — through four [kernel] since FS131-LJ1 on Weil's bound, `ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four`; at five by measure rigidity for the unit-vector group, with no witness graph: rows 120, 123, G80; [kernel] since FS131-LGT1 on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3, `Rigidity.min_localBound_five_le_chromaticNumber`). So, given MR, F² needs five exactly when F has no usable prime with residue
field 𝔽₃ or 𝔽₇ and no prime above 2 ramified in F(i) or inert there of norm at most 32 (row 123). Past five the residue method runs
out: over a field Γ₁₁ seals at five, a five-colour forced pair is one point and a virtual edge a unit edge (row 66), so the spindle's
design for six has no instance there (G48), and L(F) = 6 needs one of six finite targets — Γ_q at q ∈ {23, 27, 31, 43, 47}, or U₆₄ — to
be six-chromatic, none decided (G56, G59). Where every stable place of a totally real field mixes at six colours, as at ℚ(√635087), the
arithmetic is exhausted: χ(ℝ²) = χ_m⁰(ℝ²) (`[OAIMath2026]`), and χ(F²) = χ(ℝ²), the least k with a measurable k-colouring proper at almost every unit pair
(rows 128, 130, G81; the field equality [kernel] since FS131-ICO2, on `[EinsiedlerLindenstrauss2022]` Thm 1.3), and χ(ℝ²) ≤ χ_m⁰(ℝ²) needs no MR (row 130). No argument that bounds one colour class at a time gives six:
row 123's five is ⌈1/α_loc⌉, one densest class's bound, and 1/α_loc ≤ 4.36 (row 129, G60; [hand]). What is left, with no MR, is a
stability question (row 131, G82; [hand]): χ_m⁰(ℝ²) ≥ 7 iff six classes free of monochromatic pairs at distances in [1 − ε, 1 + ε]
cannot cover the plane up to holes whose density tends to 0; a refutation is a sequence of periodic grid colourings, wild only in the
limit, and gives χ(ℝ²) ≤ 6. Colourings with slack, polygonal ones and nice maps need seven almost everywhere, maps six (row 132;
[hand], printed proofs repaired). At bounded complexity vanishing holes are a tight six-map (row 133); with no unit arcs none exists
(row 134), and with them every one has a vertex of at least four colours, so the map NO follows from one exclusion about such a vertex
at an explicit radius uniform in the complexity (row 137, G83), and a tile count reaches only its non-Siamese part (G86; all [hand]); such a
vertex whose ring carries no boundary arc dies at `1 + ε` in the non-Siamese simple class (row 148, G91; [hand], two minds), and one whose ring carries
no (Q) arc in the non-Siamese class, simple or not (row 149; [hand], one mind).
Seven, χ_m⁰(ℝ²) ≥ 7, is the NO's hole bound made uniform in the complexity bound (row 139): it follows from the NO once the tight limit is made a map
(route M, the map step), or from a forced complementary junction pair at every complexity with its cone scale bounded below (route R),
and each route's third statement is the answer restated. Route M's regularity is contact: a saturated class is carved by unit circles
about its own points, and off a locally finite singular set its interfaces are segments and arcs of integer radius, that finiteness
open (rows 140–141, G84, G85; [hand]); FS-121 located the open part — curved tangent interfaces, lateral extent and the top colour at six (rows 142–144, G88–G90). This project has moved no value; `[OAIMath2026]` has: every measurable colouring proper at almost every unit pair needs six, and `χ(ℝ²) = χ_m⁰(ℝ²)` with no hypothesis, so χ(ℝ²) ∈ {6, 7} and the stability question at six is the whole problem.

*The entries themselves, each retired one as a titled pointer, are `.claude/skills/grokkings/SKILL.md`, which Poros and Ephodos load
in full at launch; every other mind reads an entry there by its number. Keryx is that file's only writer, and a new grokking is filed
there.*

## The pipeline

*The map every mind shares (Workflow 3.1, Kooshi, 2026-10-03). Each role's own workflow is beneath its verbatim identity, in its own
file, and loads into that mind alone.*

| role | identity | model | its file |
|---|---|---|---|
| **coordinate**, the top-level session | Keryx | Opus | `.claude/output-styles/keryx.md`, the output style `.claude/settings.json` selects |
| **ask and rank** | Poros | Opus | `.claude/agents/poros.md` |
| **derive** | Ephodos | Opus | `.claude/agents/ephodos.md` |
| **plan the kernel module** | de Bruijn | Opus | `.claude/agents/debruijn.md` |
| **implement it** | de Bruijn | Opus 5.5 | `.claude/agents/debruijn-implementer.md` |
| **search**, once a day | the Searcher | Opus | `.claude/agents/searcher.md` |
| **file**: reading and bookkeeping | the Clerk | Sonnet 5.5 | `.claude/agents/clerk.md` |

**The kernel is the second check**: a blind second mind (`.claude/agents/ephodos-verifier.md`) is not in the standard loop, and runs
only on Kooshi's word. **A milestone's states**: *Not started* (a stub) → *Opened* (the opening job) → *Derived* (the record job filed;
its results usable by later milestones, assumed until their module lands) → *Closed* (its Lean module passes the gate). Milestones
closed before Workflow 3.1 keep the word; their hand results are the Lean backlog.

The identities (the Clerk's and the Searcher's apart) are core skills in `.claude/skills/`, imported unchanged from
`~/source/agent-forge`; `scripts/identities.py check` holds each copy to its skill, and the four cores are hidden from the model's skill
list so that no mind loads a second identity. Every arrow between lanes passes through Keryx, and only Keryx launches agents
(§ Delegation — one level deep). Every brief carries `plans/STANDING-RULES.md`. `WORKFLOW.md`, loaded by no one, maps the old workflows'
step numbers.

**One writer per file.** Keryx alone writes this file, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, `.claude/skills/grokkings/SKILL.md`,
`plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`, `plans/GROKKINGS-RETIRED.md`, `plans/SEARCH-QUEUE.md`, `BIBLIOGRAPHY.md`, the
inventories, the claim lists and `plans/STANDING-RULES.md`, filing the lanes' drafts verbatim.

**Never write an open milestone's verdict, route or hunch into the auto-memory**: the harness gives its index to every agent at launch.

**Conventions.**

| what | where |
|---|---|
| a job id | `FSnnn-<letters><n>`, the letters naming the job's kind by the milestone's own choice |
| a brief | `data/fsNNN/briefs/<job id>-<slug>.md`, in the `keryx` skill's header form; its `identity:` field names the agent file |
| a report | `data/fsNNN/reports/<job id>.md`, and the same text as the job's hand-back |
| a job record | `plans/FSnn-<job>-<kind>.md`; de Bruijn's plan `plans/FSnn-kernel-plan.md`; Poros's `plans/POROS-<date>-<topic>.md`; the Searcher's `plans/SEARCH-<date>.md` |
| a milestone's plan | `plans/FSnn-<slug>.md` |
| its claim list | `data/fsNNN/claims.md`, fixed by Keryx |
| its inventory | `plans/FSnn-close-inventory.md` |
| its derivation file | `plans/FSnn-derivation.md` |
| a stub | `plans/STUB-<slug>.md` |
| a handoff before a compaction | `plans/SESSION-HANDOFF-<date>.md` |

**The stub rule** (Kooshi, 2026-08-09). Every future milestone on the roadmap is kept as a detailed stub in `plans/`. It holds the full
mission context in plain language and everything the deciding session knew: the observations, the registered expectations, the failure
clauses, the named deliverables (visualizers among them, where the milestone produces an explorable object), and the provisional
bearings, written so a fresh mind with no conversation memory can plan it with all meaning intact: the stubs are the roadmap's memory. A
direction change that does not rewrite the affected stubs is not recorded. A demoted milestone keeps its stub with a banner saying why.
Poros writes a stub's question section, bearings and bearing on the answer; Ephodos's record job writes new stubs and the bearing lines
of open ones; Keryx files the banners.

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

**No child agent spawns children of its own** (Kooshi, 2026-09-19): only the top-level session launches agents. Its reasons are
`plans/STANDING-RULES.md` rule 1; it is enforced by the agent files' withheld tools and by `.claude/settings.json`. Staffing —
head-count, model, budget, and the crunch and competition protocols — is Kooshi's decision, recorded in Keryx's workflow
(`.claude/output-styles/keryx.md` § Staffing).

## The standard of evidence above rung B

χ(ℝ²) ≥ 5 is a known theorem; a reader's default is to believe it. χ(ℝ²) ≥ 6 is `[OAIMath2026]`'s (2026), kernel-checked in its own library and audited here. **Anything this project adds above rung B — seven, a six-colouring, a field's value — would be new mathematics, and a reader's default is to disbelieve it** — correctly, because the characteristic failure of machine-assisted combinatorics is a search that found what a bug
allowed. Anything above rung B must convince someone who trusts none of this and reads none of the Python:

- **No native evaluation in the headline.** `native_decide` trusts the compiler and one CPU; for a new result that is the whole
  objection. The kernel-checkable route (`plans/spike-kernel-lrat.md`) is the price of admission, and it is measured to be affordable.
- **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer re-checks; never require them to
  re-run a solver, reproduce a seed, or trust `tools/`.
- **The witness must be independently re-derivable.** State the construction, not only the coordinates.
- **Read the final statement aloud against the informal claim.** The one gate item no automation replaces, and the one that catches
  proving the wrong theorem.
- **Report the hunt honestly.** "Searched X, found nothing" is a result and goes in the write-up.
- **Ask, while the evidence is still being gathered, what someone who trusts none of this must actually check.** Writing the reviewer's
  certificate early shows which evidence is load-bearing: once it retired a third of a refutation's evidence, and turned one
  whole-object solver claim into twenty half-instance claims within reach of proof logging. More instances:
  `plans/GROKKING-INSTANCES.md` § The standard of evidence.
- **Order a verification's steps by marginal evidential value, never by narrative order**: the checks that decide the question run
  before the slow ones that cannot.

## What compute actually helps

Ask before provisioning; measure before believing. Re-price a kernel phase from its first two leaves, never from a plan's table, and
grep Mathlib by the statement's shape at the skeleton (`LEAN.md`; instances: `plans/GROKKING-INSTANCES.md` § What compute actually
helps).

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

One reduction plus two certified computations, and why nothing in `tools/` is trusted: `LEAN.md` § The shape of the proof.

## Trust ledger

Audited at every milestone with `#print axioms` (`scripts/Axioms.lean`, run by `scripts/axioms.sh`, which checks each record's axioms
as a set); the current audit reads 10914 clean and 5 declared purchases, and 99 imported (and 574 axiom-free; 11,592 records at FS131-ICS1, five colours by field and by class, 2026-10-16), each purchase listed in `ARCHITECTURE.md` § Trust; an imported record rests on a
declared outside theorem (`LEAN.md` § Trust ledger). The library declares three outside axioms: `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by two readers — with eighty imported records (twelve of them the three-colour criterion's and row 99's, FS131-LJ1; twenty-six the five-colour chain's, FS131-LGT1; two the main clause's through five as one theorem, FS131-IL5; ten the collapse's, FS131-ICO2: the thickness of ℚ(√635087) and de Grey's field, the two instances, the per-place form, the six-or-seven corollary, and D-E2's `Rigidity.norm_charSum_le_weil`; six the p-adic plane's, FS131-IQP3: the bound at `κ = 2√p` `PadicPlane.charSum_unitCircle_ge_weil` and `towerRatio_weil`, the posers' question answered — `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`, `not_exists_bound_borelChromaticNumber_padicPlane` — and `borelChromaticNumber_padicPlane_three`; sixteen five colours by field and by class's, FS131-ICS1: CLS in full — `Rigidity.five_le_localBound_iff` over the arithmetic list `Rigidity.IsFourColourPlace`, its per-place forms, T-C(A)'s and the all-levels reading's — and `L(ℚ(√23, ∛2)) = 5` with its lower half, nine of them on Weil's bound alone; the other seven on E–L too); from `[OAIMath2026]` family 158, a Lean development built and audited here at its own pin, `Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — with seven (the seventh the collapse's `Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven`); and `Rigidity.positive_entropy_rigidity` — Einsiedler and Lindenstrauss's positive-entropy rigidity for `ℤ^d`-actions on solenoids, `[EinsiedlerLindenstrauss2022]` Thm 1.3, read back clause by clause in `plans/FS131-KN7-chain-next.md` § 3.3 — with thirty-four, twenty-one of which rest on Weil's bound too (the five-colour chain's headline `Rigidity.min_localBound_five_le_chromaticNumber`, `χ(ℚ(√47)²) = 5` and M15's other values, `χ(F²) = L(F)` at `L(F) ≤ 5` with its `min` form, `Rigidity/MainClauseFive`, and the collapse at ℚ(√635087) and de Grey's field, its per-place form and its six-or-seven corollary, `Collapse/Headline`, and FS131-ICS1's seven: the quadratic dichotomy `SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff` with its local form, the family's `χ = 5` and `L = 5`, `χ(ℚ(√23, ∛2)²) = 5`, `L(ℚ(√23)) = 4`, and the two readings of `L` agreeing through five; the collapse's general form `Collapse.chromaticNumber_planeOver_eq_plane_of_thick` rests on it alone); one record rests on the five-colour theorem and another import, the collapse's six-or-seven corollary, on all three, and the second is the release's stored statement term for term (`tools/fs132_i1_readback.py`, run again at the landing on the module as recompiled there). Three results of `[OAIMath2026]` family 158 enter as ported proofs, not imports — the transfer `Outside.OAI158.proper_to_borel_weak`, the rigidity step `Outside.OAI158.Spectral.residual_fourier` and the four palette lemmas FS-132's first theorem stands on — each checked by this kernel at this pin on the standard three (`LEAN.md` § Trust ledger, Ported outside proofs, with the licence kept beside them). Rung B holds none.

**What the library assumes, in both forms** (`scripts/assumptions.sh`, whose digest reads these counts and fails if
they are absent): `axioms=3 rests=128 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2` — three outside theorems declared as axioms, with one hundred and twenty-eight (axiom, theorem) rows resting on them, one hundred and six theorems, twenty of them on two and one on three; thirty-three hypotheses, nineteen named and fourteen written out in a binder — seven standing for outside theorems, twenty-one for hand results of ours and five declared as open questions — taken in 109 (hypothesis, statement) pairs by 56 statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5, 2026-10-06; two hand results have left the list since. At FS131-LU1, 2026-10-13: the upper half `χ(F²) ≤ L(F)`, now the theorem `UpperHalf.chromaticNumber_planeOver_le_localBound`. At FS131-LJ1, 2026-10-14: row 99's lower half through four, `hRow99`, now the theorem `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`, which rests on Weil's bound). One outside theorem has left the axioms since: at FS131-LP1, 2026-10-14, the transfer `Outside.OAI158.proper_to_borel_weak`, now `[OAIMath2026]`'s theorem with its proof ported, and its twelve `RESTS` rows with it. Of the five, three are open (the seven-target at six colours, `NoPar`, fragments at every radius); two — the six-target at five colours, on the plane and on its {1, 2}-distance graph (rows 43, 61) — hold with nothing to prove given the declared outside theorem `Outside.OAI158.no_proper_five_coloring`, their binders ranging over five-colourings, of which there are none (`Outside.OAI158.not_colorable_five`); their kind stays `open` until the tooling job decides how a declared hypothesis that a declared import implies is classed (FS132-L1). Weil's bound is counted in each form it takes — the axiom, the named hypothesis `KloostermanBound`, and that
hypothesis written out at a family of fields: one outside theorem, three entries.

What the audit accepts and what it buys — the ledger's entries, `native_decide`'s per-declaration axioms, an imported theorem's four
items, `lean4checker` as the publication gate — is `LEAN.md` § Trust ledger.

## Toolchain

The Lean toolchain — elan, the pin, the Arch build environment — is `LEAN.md` § Toolchain. The rest — the SAT solvers, what is
installed, the symmetry-breaking checklist, Python's multiprocessing default, the two machines — is `RUNNING.md` § Toolchain, which every
brief for a job that runs a solver, a build or a long process names.

**Search runs once a day, by the Searcher, outside the milestone loop** (Kooshi, 2026-10-03: *"once per day, outside of the milestone
loop, one (new) specialized agent should be responsible for curating search tasks which are likely to return a valuable result within a
reasonable amount of time, and it is responsible for utilizing all cores effectively, and limiting memory usage through the tool. de
Bruijn and Ephodos continue without search."*). **Search, which no other job runs:** SAT, MaxSAT and #SAT solvers, MILP/CP and
local-search colourers, Θ relation trees and float Θ₄ finders, quotient-colouring searches, and lattice sweeps hunting survivors.
**What every job may use:** hand derivations; computer algebra and exact arithmetic (PARI, GAP, sympy); colourings given by formula; the
Lean kernel; existing checkers on existing certificates; and an exact LP only when a derivation fixes its shape before it runs and its
dual is read back as an identity, never as an escalating oracle. Every certificate a job relies on is derived and lives on the infinite
object, or is a search's certificate checked by its checker. A step a search could decide is a `search request` in the job's report,
queued in `plans/SEARCH-QUEUE.md` (`.claude/agents/searcher.md`).

### Building

The rules for running any process here — a halt on any unexplained crash, RAM as the discriminator and `scripts/slot.py`, the two
**PROTECTED** paragraphs on checkpointing and on killable runs, kills by PID, pipes, and running scripts — are `RUNNING.md` § Building,
moved there verbatim with their tags at Kooshi's word (2026-09-28). The ones every job needs are `plans/STANDING-RULES.md` rule 9.

### The kernel's cost model

`LEAN.md` § The kernel's cost model.

### Searching

- **The regex engine.** `grep -E` on this machine is `ugrep`, and it silently under-matches alternation inside a repeated group:
  `^\s*(private |protected )*theorem` does not match `private theorem foo`. **And a `^` anywhere inside a pattern is read as an anchor,
  so `grep -c "LDL^T re-run"` returns 0 for a string present four times** — failing, as ever, in the direction that looks like a clean
  negative. `grep -oF` counts correctly; `rg` and `grep -P` match correctly.
- **The file selection.** `rg` respects `.gitignore`, which hides `.lake/` and `build/` (naming a hidden directory explicitly works; it
  is recursive discovery from `.` that skips it). Use `rg` for searching source; use `rg -uu` or `grep -rP` for any completeness question
  (does this artifact exist, is this string anywhere); never believe a count from a bare `grep -E` alternation inside a star.
- **The Lean half** (`exact?`, core's library): `LEAN.md` § Searching — Lean.

## The package

The `proofs` package, its library, the Mathlib pin, and how a dependency or a Mathlib bump is made: `LEAN.md` § The package.

## The gate

The Lean gate — the build, zero `sorry`, the axiom audit, linters, spec examples, and the statement-level vacuity check — is
`LEAN.md` § The gate. Its recorded state stays here, where `scripts/gate_report.py`
reads it. The vacuity scan's **counts** — a silent change in them is this gate's own failure mode (declarations are the library's;
the audit's own are not counted):
`declarations=22566 refutations-skipped=243 sites=1465`, `vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2`.
The baseline holds two entries. `hexShell_plane6` cannot be discharged: its inhabitant *is* Hadwiger–Nelson, at six. `hexShell_plane5` is no longer that: given the declared outside theorem `Outside.OAI158.no_proper_five_coloring` the plane has no five-colouring (`Outside.OAI158.not_colorable_five`), so its hypothesis has no inhabitant and it says nothing beyond that import. The scan cannot see this — it reads as emptiness what the library states as `IsEmpty τ` or as `¬ P` of a tracked `P` — so the entry stays `UNKNOWN`; the statement's docstring and the baseline's prose say it in words, and whether emptiness resting on a declared import may discharge an entry is the tooling job's question.

What follows binds every mind that builds an instrument, not only the kernel lane.

### Make the gate fail, and watch it fail

Its text — every check's negative control, and a positive signal for the thing that did not happen — is `RUNNING.md` § Make the gate
fail, and watch it fail (moved 2026-09-28), read by every job that builds a checker or an instrument.
