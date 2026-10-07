# FS-133 — the one-class transfer: the plan (its §G, §PA, §IQ, routes, stages)

*Ephodos, job FS133-E1 (brief `data/fs133/briefs/FS133-E1-opening-and-derivation.md`), 2026-10-07 UTC.
An opening run short and followed at once by the derivation, as the brief asks. The claim list is `data/fs133/claims.md`, fixed by the
coordinator before this launch; the stub is `plans/STUB-one-class-transfer.md`; the record is `plans/FS133-E1-derivation.md`.*

**The question, in one sentence.** Does the outside rigidity theorem (`[OAIMath2026]` family 158, Theorem 2.3; in its Lean,
`wild_fourier`), run for a single colour class, give `α₁(ℝ²) = m₁(ℝ²)` — the finitary independence ratio of the plane's unit-distance
graph equal to the supremal upper density of a measurable set with no two points at distance 1 — with no hypothesis?

## §G — the re-grokking (fresh, 2026-10-06; every entry of `.claude/skills/grokkings/SKILL.md` read by its body from inside this question)

Also read by mechanism: `LEDGER.md` row 129 whole; rows 120, 128, 130 through their theorem entries in `plans/FS103-derivation.md`
(FS103-F1, -M1b, -M-Q4, -B-AMEN, -B-CHIF, -F-FRAC, -F-DV) and through `plans/FS103-B-verification.md` §§ 2.1, 3.2 and
`plans/FS103-F-fractional-shadow.md` § 3; row 131's attainment clause (FS106-SUP); row 107 by the stub's line and G63.

**Bears** (what it says about this milestone, and the phase it changes):

- **G60** — *bears; falsifiable here.* Its body: "Given MR the cap is exact … `α₁(F²) = max(m₁(ℝ²), sup_v r_v)`", and the gap the
  literature expected "is a tight place's". At the algebraic plane there is no stable place (the rotation group is divisible, the
  reading § 2.2), so the formula with an empty supremum reads `α₁(𝒜²) = m₁(ℝ²)`. *Instruction to C133-ONE:* state it as the fractional
  local–global principle at the one field with no place, and keep the K control in view — nothing in the chain may prove
  `α₁(K²) = m₁` (it is `1/4` there): the rigidity theorem is the only step that can stop at `K`, and it does (it is a theorem about
  `ℚ̄` alone). *Registered:* G60's "given MR" on the plane's clause falls if C133-ONE lands, stays if a step fails.
- **G80** — *bears; falsifiable here.* Its last sentence: "Since row 129 MR is testable on finite graphs: a proof that `α₁(ℝ²) > m₁(ℝ²)`
  refutes it at ℚ(√635087)." If C133-ONE lands that test can never fire. *Instruction to the trace:* draft its withdrawal. The
  resource G80 names (polynomial growth by height) is not the one the release uses (divisibility); nothing else of G80 enters.
- **G81** — *bears.* "Where every place mixes, the field is the plane": this is the limit case with no place to mix. *Instruction:* say
  what stays conditional — every statement at a number field (`α₁(F²) ≤ m₁` at ℚ(√635087) needs MR(F); unconditionally only
  `α₁(F²) ≥ α₁(𝒜²)`).
- **G82** — *bears.* "A weak-* limit of near-colourings is a colouring (the circle measure is Rajchman)", and row 131's suprema
  "all attained". The unchecked step is the one-class shadow of FS106-SUP's attainment. *Instruction to C133-DENS:* no ergodic theorem
  and no pointwise action is needed — a reverse-Fatou step on window averages; state it for every window sequence, because the
  literature has three definitions of upper density (see §PA).
- **G92** — *bears (method); falsifiable here.* "A held result reaches as far as its argument, not as far as its statement." The
  release states its transfer for `k`-colourings; its argument applies the rigidity theorem to one rotation-fixed vector at a time.
  *Instruction:* before each claim, list the hypotheses the argument never consumes — for C133-DENS "for every `x`" and "`= α`"; for
  C133-ONE the sum `Σ p_i = 1`; for C133-HOM the label pattern (any set of forbidden label pairs) and the distance (any algebraic
  one). *Registered:* G92's killing test (widened forms failing on attack more often than they hold) is scored on these three.
- **G21** — *bears (method).* A zero measures its enumeration: the §PA negative carries its queries and its date in the headline;
  "answers" is said of a printed question only after its page is read (done: § PA.3); and the statement names which infimum and which
  density it bounds.
- **G24** — *bears.* "At five the relation inverts: row 123's five is a fractional bound rounded up". If C133-ONE lands the fractional
  number is exactly `1/m₁ ∈ [4.0487, 4.3599]` and finite graphs reach it; it says nothing at six. *Instruction:* a *not claimed* line.
- **G63** — *bears.* The bridge to the algebraic plane is Tarski's (`[BendaPerles2000]`), and Johnson's "Benda–Perles–Tarski property"
  for `χ_f` was held through it. *Instruction to C133-ONE:* prove the `𝒜²` equalities by a sandwich (an infimum over fewer graphs is
  larger), never by redrawing; say that no Tarski is used.
- **G66** — *bears, lightly.* Its chain of finitary, clopen, Borel and measurable numbers at a finite place has an archimedean twin:
  here the finitary one-class number equals the measurable one.
- **G76** — *bears.* "a transient colouring is invisible to every measure method": the transfer never reads the given object beyond
  the invariant law its orbit averages define. *Instruction to C133-INV:* the invariant law is built from maximum independent sets of
  Følner pieces, not from one global set; nothing global is needed.
- **G79** — *bears.* The example invariant: every invariant random labelling of the algebraic plane carries the conditional
  expectations of its label indicators on the continuous factor. §IQ's structural form is asked about it.
- **G87** — *bears; checked, no signal.* The published expectation `α₁(ℝ²) ≠ m₁(ℝ²)` (`[AmbrusEtAl2023]` § 4; `[MatolcsiEtAl2025]`
  § 2) against this claim is not two truths: the expectation was conditional on a conjecture disproved in print
  (`[DuczVarga2026]`), and row 129 already located its source (the Moser lattice's dyadic places).

**Silent:** G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12, G13, G14, G15, G16, G17, G18, G19, G20, G22, G23, G25, G26, G27, G28,
G29, G31, G32, G33, G34, G35, G36, G37, G38, G39, G40, G41, G42, G43, G44, G45, G48, G52, G53, G54, G55, G56, G57, G58, G59, G61,
G62, G64, G65, G68, G69, G70, G71, G73, G74, G75, G77, G78, G83, G84, G85, G86, G88, G89, G90, G91; and the retired pointers G30,
G46, G47, G49, G50, G51, G67, G72 (carried by this lane's workflow).

**What the re-grokking changed in the plan.** (i) C133-DENS is derived for every window sequence and with "for almost every `x`,
`≥ α`" (G82, G92), not as posed. (ii) C133-ONE's `𝒜²` clauses go by sandwich, and two relay-results the stub did not list are
derived first because the `χ_f` clauses rest on them at one mind: the periodisation lemma and FS103-B-CHIF (G63, G21). (iii) The K
control is registered against the chain (G60). (iv) C133-HOM is attempted at the class its argument carries — pair constraints at
algebraic distances (G92). (v) Two drafts are owed at the trace: G60's and G80's sentences.

## §PA — the prior-art gate (opening pass, 2026-10-07 03:00–03:20 UTC; a second pass is owed before the report)

**PA.1 The object in its disciplines' words.** *Discrete geometry / extremal combinatorics:* "fractional chromatic number of the
plane", "finitary fractional chromatic number `χ_f,0`", "independence ratio of unit-distance graphs", Erdős's `f(n)`, "density of
1-avoiding (distance-avoiding) sets", "measurable independence ratio `m₁(ℝ²)`", "Hall ratio". *Descriptive combinatorics / ergodic
theory:* "measurable independence number of a group action", "Borel fractional chromatic number", "invariant random independent
set", "factor of iid". (`BIBLIOGRAPHY.md` § E holds no coined name of ours for these objects; row 129's `α_loc` is ours and is not
searched.)

**PA.2 What was searched, with hits** (scripts and raw answers: `data/fs133/pa/arxiv_query.py`, `ax-*.xml`,
`arxiv-2026-10-07-opening.out`).

| # | where | query | hits; newest; verdict |
|---|---|---|---|
| a1 | arXiv API, newest first | `all:"fractional chromatic number" AND all:plane` | 6; newest 2026-06-26 (`[DuczVarga2026]`); all held |
| a2 | arXiv | `all:avoiding AND all:"unit distance" AND all:density` | 8; newest 2024-08-19; none on the equality |
| a3 | arXiv | `all:"independence ratio" AND all:"unit-distance"` | 2: `[DuczVarga2026]`, `[MatolcsiEtAl2025]` |
| a4 | arXiv | `all:"1-avoiding"` | 59, permutation patterns dominate; none dated after 2026-08-31 on this |
| a5 | arXiv | `all:"Hadwiger-Nelson"` | 29; newest 2026-09-28 (2609.36220, typical norms — abstract read: not this) |
| a6 | arXiv | `all:"chromatic number of the plane"` | 23; newest 2026-06-26 |
| a7 | arXiv | `all:"measurable chromatic number"` | 12; newest 2026-06-15 (tropical norm) |
| a8 | arXiv | `all:"unit-distance graph" AND all:measurable` | 3; none |
| a9 | arXiv | `all:"Borel fractional"` | 3: 2105.11557 (Bernshteyn — abstract read, see PA.4), 2501.07352 (matchings) |
| a10 | arXiv | `all:"fractional chromatic number" AND all:measurable` | 9; newest 2026-05-27 (2605.28709, double cap — abstract read: sphere, not this) |
| a11 | arXiv | `all:"five-colorable" OR all:"five-colourable"` | 76; none on the plane after 2026-10-01 |
| a12 | arXiv | `all:finitary AND all:"chromatic number" AND all:plane` | 1: `[MatolcsiEtAl2025]` |
| a13 | arXiv | `all:"distance-avoiding" AND all:density` | 4; newest 2026-09-28 (2609.34845, Bekker's thesis — abstract read: SDP hierarchies converging to the *measurable* density; not the finitary ratio) |
| a14 | arXiv | `all:"unit distance" AND all:invariant AND all:"independent set"` | 0 |
| a15 | arXiv | `ti:plane AND ti:colorable` | 67; none |
| w1 | web (extended) | "fractional chromatic number of the plane" / "finitary independence ratio" / "density of 1-avoiding sets" with the release's title, October 2026 | the held papers only |
| w2 | web | the release's title with "fractional" / "m_1" / "independence ratio" | the held papers only |
| z | zbMATH Open API | (eight queries prepared) | **not run: the API answered 503 at 03:02 UTC (next day)**; owed at the second pass |

**Headline, with its enumeration (G21):** in fifteen arXiv queries (API, newest first, read on 2026-10-07 03:03 UTC), two web
searches, and the two files this repository keeps, **no statement of `α₁(ℝ²) = m₁(ℝ²)` or of `χ_f,0(ℝ²) = χ_f(ℝ²)` without
hypothesis was found, and no arXiv listing in these vocabularies is dated after 2026-09-28.** Not searched: zbMATH (down), MathOverflow
and blogs, the release's other 371 families beyond the stub's headline grep. A listing is not a reading; the three abstracts read
are marked.

**PA.3 The printed questions, each read at its page by this job** (2026-10-06):

- `[MatolcsiEtAl2025]` pp. 4–5 (`pdf/arXiv-2311.10069.pdf`, text layer): `χ_f(ℝ²)` is the infimum of weights of fractional colourings
  "such that `γ(I) > 0` occurs for finitely many independent sets `I` only, and `Σ_{x∈I} γ(I) ≥ 1` for each `x ∈ ℝ²`"; "We define the
  finitary fractional chromatic number of the plane as χf,0 (R2 ) := sup{χf (G) : G ⊆ R2 , G is finite}. It is clear that
  χf,0 (R2 ) ≤ χf (R2 ), but it is not known whether equality holds."; "the finitary independence ratio of the plane as α1 (R2 ) =
  inf{α1 (G) : G ⊆ R2 , G is finite}"; `m₁(X) = sup_A λ(A)/λ(X)` over measurable 1-avoiding `A ⊆ X` and "m1 (R2 ) = inf X m1 (X)",
  with "An equivalent definition of m1 (R2 ) is given in [1] as the maximal upper density of a measurable 1-avoiding subset of R2."
- `[DuczVarga2026]` pp. 1–4 (text layer): "Let f (n) be the largest integer such that every set of n points in the plane contains
  f (n) points no two of which are at distance 1. Equivalently, f (n) is the minimum possible independence number of a unit-distance
  graph arising from n points in the plane."; "Let m1 (R2 ) denote the supremum of the upper densities of measurable sets A ⊆ R2
  containing no two points at distance 1."; "Conjecture 1. f (n)/n = m1 (R2 ) + o(1) and in particular that m1 (R2 ) = δCroft ."; § 3:
  "a unit-distance graph means a finite point configuration in the plane together with the graph whose edges join pairs of points at
  distance 1". **So `inf_n f(n)/n` is exactly MRVZ's `α₁(ℝ²)`, the infimum the argument bounds: the stub's second falsifier does not
  fire.**
- `[Johnson1996fcn]` pp. 102–106 (page images): Question 1, "If χ_f(G) < ∞, is it necessarily the case that χ_f(G) = sup[χ_f(H): H
  is a finite subgraph of G]? … If the answer is "no", then what about the case G = ℝ²?"; Question 2 (is the supremum a maximum —
  "Intuition screams, "No!""); Question 3, "Does χ_f have what might be called the Benda-Perles-Tarski property, that χ_f(ℝ²) =
  χ_f(𝒜²), where 𝒜² represents the unit distance graph on the field of algebraic complex numbers?"; Question 5 (Fisher–Ullman's
  assertion that "a measurable, periodic independent set of ℝ² with density ρ generates a sequence of fractional colorings of ℝ² the
  sum of whose weights converge to 1/ρ" — "we need to ask if that assertion at the end of [7] is true, and to ask for a proof"); the
  Proposition (p. 102) and its proof (p. 106): the weighting and the multicolouring definitions agree for infinite graphs when either
  is finite, by truncating to finitely many sets — so his `χ_f(ℝ²)` is MRVZ's.
- `[Johnson2000surprises]` p. 143 (page image): "Problems 3, 4, and 5. Is it true that χ_f(ℝ², 1) = sup[χ_f(H); H is a finite
  subgraph of (ℝ², 1)]? Is χ_f(ℝ², 1) = χ_f(𝒜², 1), where 𝒜² is the "algebraic plane", the field of algebraic complex numbers? …".

**PA.4 The neighbouring discipline's theorems (recognition's material).**
- *Borel fractional colourings:* A. Bernshteyn, *Borel fractional colorings of Schreier graphs*, arXiv:2105.11557 (**abstract only**):
  for the Schreier graph of the free part of a Bernoulli shift of a countable group with a finite connection set, "the Borel
  fractional chromatic number of G is equal to 1 over the measurable independence number of G". This is the locally finite twin of
  `χ_f(ℝ²) = 1/m₁(ℝ²)`'s measurable half (FS103-B-CHIF), not of `α₁ = m₁`.
- *Measurable independence numbers of amenable actions:* C. Conley, A. Kechris, Groups Geom. Dyn. 7 (2013) 127–180 (**recalled and
  seen in a search digest, not read**): for a bipartite Cayley graph the measurable independence numbers of free actions fill
  `[α, 1/2]` with `α = 1/2` exactly when the group is amenable. The locally finite twin of `α₁ = m₁`; there the proof is a Rokhlin
  tiling. In the plane no tiling can do it: a maximum independent set of a finite configuration is not a measurable set, and the
  discrete group of the plane is not the group whose Følner sets are discs — which is where the rigidity theorem enters.
- *Attainment of `m₁`:* DeCorte–de Oliveira Filho–Vallentin, arXiv:1804.09099 (held; **only p. 23 and § 6's first paragraph read
  here**): the completely positive formulation attains the measurable independence number on compact spaces "if ϑ(G, C(V)) has an
  optimal solution"; their upper density is `sup_p limsup_T vol(X ∩ (p + [−T,T]ⁿ))/vol[−T,T]ⁿ`. Whether attainment in `ℝⁿ` is printed
  there is **owed**; this project holds it as FS106-SUP (row 131, [hand, two minds]).

**PA.5 Held and unread papers whose titles touch the milestone.** None found unread: `[MatolcsiEtAl2025]`, `[DuczVarga2026]`,
`[AmbrusEtAl2023]`, `[Johnson1996fcn]`, `[Johnson2000surprises]`, `[KMOR2016]` are read (`BIBLIOGRAPHY.md`); the release's
manuscript §§ 2–4 were read in full by EXT-OAI2 and its § 4 (316 lines) re-read whole by this job.

## §IQ — the invariant question (G72)

1. **Existence form** (the stub's card, verbatim): "**Is there a Lebesgue-measurable set in the plane, with no two points at distance
   exactly 1, whose upper density is at least `α(G)/|G|` for every finite unit-distance graph `G`?**"
2. **Structural form** (verbatim): "**For which constraints on labelings of the algebraic plane, invariant under its rigid motions,
   does a solution exist if and only if a measurable solution exists almost everywhere?**"
3. **The invariant it forces.** For an `E ⋊ K`-invariant random labelling, the vector `(p_i) = (𝔼(f_i ∣ 𝓕_c))` of conditional
   expectations of the label indicators on the continuous factor (the manuscript's Lemma 4.1) — a stationary, `L²`-continuous field
   of probability vectors on `ℝ²`. A constraint transfers iff it is a property of that field.
4. **Its route.** Derivation only. No computation answers it; controls check derived shapes.
5. **Open instances it would decide.** `[DuczVarga2026]` Conjecture 1's first clause; `[MatolcsiEtAl2025]` § 2's equality;
   `[Johnson1996fcn]` Questions 1 (for `ℝ²`) and 3; circular, `b`-fold and `H`-colourings of the plane against their measurable
   forms.

**Is the structural form the existence form reworded?** No. The existence form asks for one set; the structural form quantifies
over constraint systems, and its answer ("pair constraints" or more) is a statement about the transfer, of which the existence form
is the instance "one label, forbidden to itself at distance 1". Nothing for the asking lane.

## The plan proper

**Routes.** One route per claim, all derivation.
- *C133-DENS:* window averages of `1_{H>0} ≥ H`, Tonelli, reverse Fatou. Failure clause: if a pointwise action were needed, the
  step would stall at "the field is only an `L²`-class at almost every `x`" — it is not needed.
- *C133-INV:* Følner averages of maximum independent sets in the countable abelian group `E`, a weak limit, then a fixed point of
  the rotations (Markov–Kakutani, or a second Følner average). Failure clause: none foreseen.
- *C133-ONE:* (i) the relay-results — the easy half `m₁ ≤ α₁`, the periodisation lemma, FS103-B-CHIF re-derived; (ii) F3–F9 for one
  field, each step read for `Σ p_i = 1`; (iii) the sandwich for `𝒜²`; (iv) Fekete for `f(n)`. Failure clause: if a step of F3–F9
  uses the partition, the claim stalls there and row 129 keeps "given MR".
- *C133-HOM:* cross terms by polarisation (the rigidity theorem applied to the complex combinations `b_i + b_j`, `b_i + i·b_j`),
  then the support selection and a density-point converse. Failure clause: if a complex combination's spectral measure were not
  rotation-invariant, the cross terms would stall and C133-HOM becomes a stub.

**Registered predictions** (each decides what runs next; scored in the record's last stage). These were written after a first
pass through the routes in my head, so they are not blind to the routes; they are blind to the written derivations.
- P-DENS (0.97): derived as posed, and more widely. *Decides:* whether anything else runs (the stub: "everything else waits on it").
- P-INV (0.95): derived. *Decides:* whether C133-ONE can start from an invariant law of density `≥ α₁(𝒜²)`.
- P-ONE (0.90): derived, reading the rigidity theorem itself. *Decides:* the trace (row 129, G60, G80) and the import's third
  theorem.
- P-HOM (0.85): derived, both directions. *Decides:* whether C133-HOM closes here or becomes a stub.
- P-K (0.95): the chain run at `K = ℚ(√3,√11)` stops exactly at the rigidity theorem and nowhere else. *Decides:* whether C133-ONE's
  `uses only:` line is honest.

**Stages** (each saved in the record and committed before the next; no run is long; a kill redoes at most the stage in hand).

| stage | content | checkpoint | budget |
|---|---|---|---|
| 1 | readback, definitions at their pages, this plan | `plans/FS133-E1-derivation.md` § Stage 1; this file | done at commit |
| 2 | recognition (`ephodos-recognition`, fresh) on the four claims | § Stage 2 | short |
| 3 | C133-DENS; the verdict to the coordinator by message | § Stage 3 | short |
| 4 | C133-INV | § Stage 4 | short |
| 5 | C133-ONE with its relay-results | § Stage 5 | the longest |
| 6 | C133-HOM | § Stage 6 | short |
| 7 | the trace (row 129, G60, G80, `CLOSED-QUESTIONS.md`), the Lean reads, §PA's second pass, predictions scored, the report | § Stage 7; `data/fs133/reports/FS133-E1.md` | short |

Resume: read the record's last SAVED stage against `git log -- plans/FS133-E1-derivation.md` and continue at the next.
