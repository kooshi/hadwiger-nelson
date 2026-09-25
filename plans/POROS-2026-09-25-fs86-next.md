# Poros — after FS-86: what next? (2026-09-25)

Advisor's record. Brief: `data/fs86/briefs/N-next-step-advisor-brief.md` (commit b674c39e). Kooshi's question: *"the missing
theorem, 2 hours of sanctioned search time, or something else."* The decision is his; this record recommends.

## §0 My expectation, written before reading the close's pricing

**What I had read when I wrote this:** the brief; my identity files; and the `CLAUDE.md` I was loaded with. That copy is the
snapshot from *before* FS-86's close: it has FS-86 as "next" and rows only to 87. I had not yet opened FS-86's rows 88–94, its
plan, the stubs for FS-89 and FS-90, or the re-ranked table.

**E1 — The best next step, as I expect it.** Kooshi should not spend the week on FS-89 as a milestone with a landing target.
From its one-line description (measure rigidity for the unit-vector action on the dual of `R`, with isometric archimedean
directions), my prior says it is a Furstenberg ×2×3-type rigidity statement: invariant measures on a solenoid under a
higher-rank abelian action. That family is open in general. Rudolph and Johnson need positive entropy; Einsiedler, Katok and
Lindenstrauss need entropy too. "Isometric archimedean directions" suggests that exactly the entropy that such theorems feed on
is absent at the real place. So I expect FS-89 to be either (i) a famous open problem in disguise, or (ii) reachable only
because some hypothesis specific to this action holds, for instance a large rank or a place with hyperbolic directions. The first
move is to find out which, by a **reading**, not a derivation week. My expected best plan: a short reading-and-reduction step
on FS-89 (is it Furstenberg's conjecture, or does a known theorem apply?), then the two sanctioned hours on the single
candidate whose outcome is decisive in both directions. If no candidate is two-sided, I expect to recommend spending the two
hours on nothing, or on a confirmation that a derived claim needs.

**E2 — What a search buys that a derivation cannot, and the reverse.**
- *A search buys:* existence facts about finite objects. A refusal of a finite graph is a certificate, and so is a colouring of
  a finite quotient. That is exactly how a forced pair is **confirmed** (a finite forcing subgraph), and how a four-colourability
  question is **refuted**. Both halves are semi-decidable only one way. A search cannot prove looseness, periodicity or
  non-rigidity of an infinite lattice: those need a colouring given by formula, or a derivation.
- *A derivation buys:* statements about every solution on the infinite object, mechanisms and no-gos. It cannot supply the
  finite witness a claim of the form "this forces" eventually needs for kernel-grade evidence (Heule-style T721, a certified
  forcing graph).
- So the two hours are worth most where a derivation has **already predicted** a finite object, and the search only has to
  exhibit it. They are worth least on an open-ended hunt.

**E3 — Where FS-86 points for six and seven (as I expect it, from the snapshot).** The fields FS-86 studied, ℚ(√59) and
ℚ(√83), are triangle-free, and their only four-colour target is the inert dyadic `K₄`. The fields where the conjecture is exposed
are also triangle-free: ℚ(√47) (L = 5) and ℚ(√167) (L ≥ 6). Every route this project has to "five over a triangle-free field"
goes through a four-colour **compulsion** that the chain theorem (G55) can close. So I expect FS-86's result to be a no-go or a
conditional that reaches those fields:
- if triangle-free rigidity at four colours needs the missing theorem, the chain route to five over ℚ(√47) and ℚ(√167) waits
  on it as well;
- the week's real bearing on six and seven is then **indirect**. It tells us whether the conjecture's five-clause predictions
  (ℚ(√47)) can ever be confirmed by chains, or only by something non-local such as FS-83's layer method or FS-80's window LP.

I do not expect FS-86 to bear on the window members or on K(√7) directly.

**E4 — On the close planner's lean (b before a, c the only one on six).** Before reading it, I expect the following:
- A Heule-graph audit is a **check of an existing certificate**. It runs on an existing checker, so it may not need the
  sanctioned exception at all. It is not a search.
- A semi-decidable certificate hunt (HD1-cert) cannot refute, so a timeout teaches nothing. That makes it the classic G21
  one-sided instrument, and a poor use of scarce search time unless the derivation predicts that it succeeds quickly.
- I expect to disagree with the order if (b) turns out to be a checker run that needs no exception.

**Hunches registered now** (scored in §7):

hunch: fs89-is-furstenberg-shaped
  claim: FS-89's missing theorem is, or implies, an open case of Furstenberg-type ×p×q measure rigidity (zero entropy at the archimedean place), so it cannot land in a week
  basis: prior
  falsifier: the stub or the derivation file shows the action has a hyperbolic place or positive entropy supplied by the colouring, so a published theorem (Einsiedler–Lindenstrauss, Rudolph–Johnson, Berend) applies directly
  registered: 2026-09-25
  status: open

hunch: heule-audit-needs-no-exception
  claim: the (b) candidate, auditing Heule's T721 graph, is a checker run on an existing certificate and fits the week's rules without the sanctioned two hours
  basis: prior
  falsifier: the FS-90 stub shows (b) requires a SAT refutation or a solver re-run to produce the certificate
  registered: 2026-09-25
  status: open

hunch: two-hours-best-unspent-or-confirmatory
  claim: no candidate in FS-90 is decisive in both directions within two hours, so the best use is a derived-claim confirmation or deferral until the ban lapses on 2026-10-01
  basis: prior
  falsifier: a candidate whose both outcomes (refusal and colouring) are certificates and whose priced cost fits in two hours with margin
  registered: 2026-09-25
  status: open

## §1 Evidence inventory (read against the expectation above)

- `plans/FS86-dyadic-rigidity.md` §R-close, the close — read against: a verdict, a G72 count and the search log read on Kooshi's question — surprised: no. It rules Paid (no-go), G72 five of five, and 34 search-log lines with 0 searches run. The friction is concentrated where the question really is a finite witness.
- `plans/STUB-isometric-measure-rigidity.md` (FS-89) — read against: E1, a Furstenberg-type rigidity statement — surprised: yes. **HD1 as stated is about points**: every band character is torsion. The band set `Θ₄(R)` is closed and invariant under multiplication by unit vectors (FS86-dB-HDcert's ⟸ uses exactly that invariance). So HD1 is a statement about **orbit closures**, which is Furstenberg–Berend *topological* rigidity (closed invariant sets; Furstenberg's ×2×3 case is a theorem with no entropy hypothesis). The record files it under *measure* rigidity (Rudolph, Einsiedler–Lindenstrauss), where zero entropy is exactly the open case. See §3, card 1.
- `plans/FS86-derivation.md` §4 and §11 (HD1, HDcert, HDfin, C15) — read against: why measures enter — surprised: yes (partly). C15 settles the *algebraic* invariant measures and so reads "what remains is non-algebraic measures". But a non-torsion band point has an orbit closure `X ⊂ Θ₄`, and X avoids the torsion points, because each pullback point is isolated in `Θ₄` (HDcert's ⟹ proof). A classification of the **minimal closed invariant sets** would therefore suffice as well as a measure classification. The measure frame is one sufficient route, not the only one.
- `LEDGER.md` rows 88–94 — read against: E3 (a no-go or conditional reaching ℚ(√47), ℚ(√167)) — surprised: yes — E3 was met more sharply than I expected. Row 92's type-(A) corollary (FS86-CL1, one mind): **no measurable window four-colouring of ℚ(√47)'s or ℚ(√167)'s plane exists at all**. So FS-83's layer method and FS-64's windows at four colours can never falsify the conjecture's five-clause at ℚ(√47). The row also says why five colours are untouched: Croft's `m₁ ≥ 0.229 > 1/5` at the real place.
- `plans/STUB-sanctioned-search-fs86.md` (FS-90) — read against: E4 — surprised: yes, twice. (i) **(b) is not a checker run.** T721 is "not held", and its audit needs the graph fetched from outside, followed by a SAT refutation with LRAT; that needs the exception. My hunch `heule-audit-needs-no-exception` is killed. (ii) **(b) is the only two-sided candidate**: UNSAT with LRAT means the pair is forced, and a colouring that separates the pair refutes Heule's claim. Both outcomes are certificates, on a fixed 721-vertex instance. Its one unpriced step is *getting the graph*.
- `plans/FS86-C-deBruijn.md` §7.5 (the primary behind G76) — read against: a measure-rigidity statement, as G76 and the stub say — surprised: yes — **the summary drifted from its primary.** De Bruijn's own words ask for "an `S`-adic Berend-type theorem with an isometric archimedean centre: **closed `U_F`-invariant subsets of `R̂`** are contained in `T + A`, or contain a leaf segment in a split direction". That is a **topological** statement. Coxeter's C15 reading is the measure one. The close merged the two under "measure rigidity" (G76, the FS-89 title, §11, rank-2 row). The topological problem is the cheaper one: Furstenberg's closed-set ×2×3 theorem (1967) is proved with no entropy hypothesis, while the measure version is the famous open conjecture. *Recalled, not read here:* Furstenberg 1967 is not a `BIBLIOGRAPHY.md` entry at all.
- `BIBLIOGRAPHY.md` `[Berend1983]`/`[Berend1984]` row — read against: unread, as the stub says — surprised: yes. The row already states Berend's theorem as a statement about **closed invariant sets**, and FS-81's note that "rigidity can hold only modulo the isometric places". So the project had the topological reading on file at FS-81 and lost it by FS-86's close. Berend 1984 is not held; 1983 has only its review read.
- `plans/FS86-dyadic-rigidity.md` §S.5, the fallback (FS-83 at `k = 4`: the rational pattern's band set at [1/4, 3/4], then gluing across layers) — read against: run and killed — surprised: yes — **it never ran.** Coxeter's C14 "killed it before it runs", but only as a *constructor of a "no"* (a non-periodic colouring reading finitely many places). **The same computation, used for the other side, is G74's proof pattern for HD1**, and nobody asked what else it answers. That is an instrument retired after one question (§3, card 1).
- `plans/FS86-close-inventory.md` items 69–74 — read against: the close's rulings — surprised: yes (one item). Item 70 names the audit of `[AmbrusEtAl2023]`'s bound `m₁(ℝ²) ≤ 0.2470` as a post-close item. It is allowed during the ban, but it is a job of unknown size: no code or certificate is held. Row 92, and so CL1's reach to ℚ(√47) and ℚ(√167), rests on that bound at every real place.
- `plans/POROS-2026-09-24-algebra-week.md` §6 — read against: the last advisor's frame — surprised: no. Its §6.6(1) point is the week's cut: "a finite witness against a certificate on the infinite object". FS-86 produced the second kind, as it predicted.
- `CLAUDE.md` § Paths forward, ranks 1–29 (from disk) — read against: FS-89 and FS-90 at 2 and 3 — surprised: no. The bearings column for FS-83 says "live at `k = 5` and for characters of infinite type (FS-89)". That is the link card 1 makes concrete.
- `BIBLIOGRAPHY.md` `[Heule2021]` row; a repository-wide `rg -uu` for T721 — read against: T721 held somewhere — surprised: yes — **nothing is held.** The source paper is "journal archive; loan", and even "if it is the paper that holds it (unchecked)". FS-90's "(b): minutes once the graph is held" omits the acquisition step.

## §2 The survey, on five axes

- **Goal (Kooshi):** seven; the conjecture attacked where it is cheapest; "all novel knowledge is a success".
- **Object:** after FS-86, the one open object is **HD1**: is every band character of `R = ℤ[U_F]` torsion? More generally, it is the band set `Θ_k` of a field's unit-vector group, at infinite type.
- **The ask, as posed:** the record asks "prove measure rigidity with isometric archimedean directions". The primary (de Bruijn §7.5) asks for a closed-set statement.
- **Discipline:** the record names ergodic theory (Einsiedler–Lindenstrauss). The object belongs as much to **topological dynamics** (Furstenberg 1967, Berend 1983–84). It also belongs to **this project's own layer method** (G74, FS-81), which proved a band-set rigidity with an isometric archimedean centre at three colours.
- **Product:** the close priced FS-89 as "reading-room research, low confidence". That price follows from the measure framing.

## §3 Cards

question: is-the-missing-theorem-a-rational-layer-statement
  evidence: `plans/FS86-C-deBruijn.md` §7.5 asks for closed invariant sets, not measures. G74 (`CLAUDE.md`) proved a band-set classification at three colours by one exact layer classification (FS81 C1(5)) plus gluing, with "`5^{−k}` in every layer" doing the work. FS-86 §S.5's four-colour layer computation never ran.
  expected: FS-89 needs an unpublished measure-rigidity theorem on `R̂(F)`, field by field, at low odds (the stub's §Bearing)
  ask: Does HD1 follow from a statement about the rational unit circle alone, with every four-colour band character of `ℤ[U_ℚ]` torsion plus archimedean, by G74's `5^{−k}` gluing?
  if yes, and the rational statement holds: HD1 is proved for every type-(B) field in one page. The same gluing kills every character four-colouring of ℚ(√47)'s plane and, at band 1/5, of ℚ(√167)'s, which is the conjecture's character falsifier at both exposed fields (§4, option A′).
  if yes, but the rational statement fails: FS-89 becomes a field-free problem over ℚ(i), and its counterexample is the explicit obstruction. It is also the only candidate seed for a character colouring of an exposed field. Either way the milestone's object changes from `R̂(F)` to one solenoid.
  if the gluing fails: FS-89 stays as the stub states it; drop to option C (FS-87 kernel work) and keep the reading step only
  answered by: derivation — the gluing (below) by a derivation agent, checked blind; then the single-prime band set at [1/4, 3/4] exactly (FS-86 §S.5 called it "a fixed 2-D set, derived shape, in scope")
  cost: the gluing, a day with its blind check; the single-prime set, one to two days; the all-primes statement, open
  hunch: the gluing is sound, but a single prime is not enough at four colours: its band set holds a Cantor-like family of non-torsion points, so the rational statement needs Berend's rank condition (many primes)
  falsifier: the exact band set of `ℤ[U₅]` at [1/4, 3/4] contains only torsion-plus-archimedean points, as FS81 C1(5) found at three colours
  rank: 1

question: what-should-the-two-sanctioned-hours-buy
  evidence: `plans/STUB-sanctioned-search-fs86.md`. (a) is semi-decidable, so a timeout is silent. (b) is two-sided, but T721 is not held (`BIBLIOGRAPHY.md` `[Heule2021]`: "loan", source "unchecked"). (c) cannot be refuted by any finite search, and row 84 prices triangle-free four-colour refusals at ≥ 1,284× the control's points.
  expected: the close's order, (b) then (a)
  ask: Should the two hours go to the one candidate whose every outcome is a certificate, T721's audit, and only if the graph can be fetched rather than borrowed?
  if the graph is fetchable: run (b) — about an hour, two-sided; it upgrades row 93 and FS86-CL3 from external to certified; no bearing on six
  if the graph needs a loan: bank the hours until 2026-10-01; do not run (a) or (c) in them
  answered by: Kooshi
  cost: one quick check of whether Heule's files are public, then about an hour
  rank: 2

**The gluing, stated so a derivation agent can check it** (hypothetical mood: my sketch, one mind, not verified; it is G74's own
argument at four colours):
- **Setup.** `U_ℚ ⊂ U_F` for every real `F`, since rational unit vectors lie in every field. `ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (mod 4)]`, and it
  contains `1/5`. For every `b ∈ U_F`, the layer `b·ℤ[U_ℚ]` lies in `R`, and the layers cover `U_F`. For `θ ∈ Θ₄(R)`, its restriction
  `θ_b(y) := θ(by)` lies in `Θ₄(ℤ[U_ℚ])`.
- **Hypothesis (the rational statement).** `Θ₄(ℤ[U_ℚ]) ⊆ T_N + A`: torsion of order dividing a fixed `N`, plus archimedean.
- **The step.** Then `ψ := Nθ` equals `L_b` modulo 1 on each layer, with `L_b` real-linear. Suppose two decompositions of one `z ∈ R`
  differ by `D`. Scaling by `5^{−k}` stays inside every layer and gives `5^{−k}D ∈ ℤ` for every `k`, so `D = 0`. Hence `ψ` is one
  ℚ-linear functional on `F(i)`, which extends to `F(i) ⊗ ℝ`: `ψ ∈ A`. So `θ ∈ T + A` (uniqueness: an archimedean torsion character is 0).
- **Conclusion.** FS86-dB-Theta (a band character in `T + A` on a type-(B) plane is a pullback) gives HD1.
- **The same step elsewhere.** At ℚ(√47) (every factor's ratio below 1/4, CL1's input), a `T + A` band character is a circular colouring
  of ratio 4 of a product with `χ_f > 4` (Zhu, as in Poros (competition)'s H-36(a)), so `Θ₄(ℚ(√47)) = ∅`. At band 1/5 over ℚ(√167)
  (five refused at 23 at every level, `α(Γ₂₃) ≤ 97`, ratio 0.183), the same argument would need the rational statement at [1/5, 4/5].

**Why one prime is probably not enough at four colours** (a heuristic count; checked by no computation):
- In `ℤ[U₅]` the unit group is `⟨i⟩ × ⟨ρ⟩` with `ρ = (2+i)/(2−i)`. That is rank one: Berend's rank condition fails, and each `ρ`
  expands exactly one 5-adic place.
- On a character supported at that place, each new 5-adic digit (five choices) must keep two independent constraints, `θ(ρⁿ)` and
  `θ(iρⁿ)`, inside a band of width `1 − 2/k`.
- The expected number of surviving digits is `5·(1/3)² ≈ 0.56 < 1` at three colours (consistent with C1(5): no survivors), but
  `5·(1/2)² = 1.25 > 1` at four colours and `5·(3/5)² = 1.8` at five. So a branching family of survivors is likely at four colours.
- If so, the rational statement must use many primes at once. Each other prime's `ρ_q` acts at 5 as a 5-adic unit, an isometry with
  dense residues, which is exactly the lever of Furstenberg's and Berend's closed-set proofs. De Bruijn's obstruction (a unit that
  controls one place has poles elsewhere) reappears as the poles of `ρ_q` at the primes above `q`.
- The rational setting is still the cleanest one available: every `ρ_q` has **one** pole.

## §4 The options, evaluated (odds are mine, prior-grade unless marked)

| option | what it decides (scope, grade) | cost | needs the two hours? | odds of landing this week | bearing on χ ≥ 6 / the conjecture | what a "no" or null teaches |
|---|---|---|---|---|---|---|
| **A. FS-89 as stubbed**: read Berend 1984 and Einsiedler–Lindenstrauss, then attempt measure rigidity with an isometric centre | HD1 for type-(B) fields (hand) | one derivation agent + a blind verifier, the rest of the week; two papers not held | no | HD1: ~0.05 | none on six; HD1 alone leaves `F(R)` open | "the literature does not reach it" — the stub's current state, nearly free of news |
| **A′. FS-89 re-posed** (card 1): the gluing lemma, then the single-prime band set at [1/4, 3/4], then the all-primes rational statement by a closed-set (Furstenberg–Berend) argument | HD1 for **every** type-(B) field, and `Θ₄(ℚ(√47)) = ∅`, from one field-free statement (hand, two derivations) | same staff; Stage 0 (gluing + single prime) is one to two days | no, unless Kooshi rules Stage 0's exact band-set computation a Θ tree (then it is the best use of the hours) | gluing sound ~0.75; single prime already enough ~0.2; HD1 by 10-01 ~0.2–0.25; a clean field-free re-posing with its obstruction named ~0.7 | **the only option that bears on the conjecture**: it decides the character falsifiers at both exposed fields (ℚ(√47) at four, ℚ(√167) at five). None on six directly | a counterexample to the rational statement is an explicit infinite-type band character. That is the obstruction made concrete, and the only candidate seed for a falsifier at ℚ(√47) |
| **B. FS-90 (a)**: HD1-cert's `Θ₄` tree on `Λ₅₁₀` | HD1 true (cert), or nothing | 2 h, plus a positive-spanning check first (D's D3) | yes | closes in 2 h ~0.15 (FS-81's tree left a smaller three-colour instance undecided at 312 s; G21: a relation tree is a weak finder of isolated points) | none on six | **nothing**: semi-decidable, and a timeout is silent. If A′ lands, B is moot |
| **C. FS-90 (b)**: audit Heule's T721 | whether `(0, 2)` is forced in ℚ(√2,√3)² (cert: UNSAT with LRAT through the Lean kernel's core route, or a colouring) | **the graph first**: not held, source unchecked. Fetchable: ~1 h. A loan: days | yes (a SAT refutation) | fetchable ~0.5 (unknown); given the graph, done in 2 h ~0.85 | none on six or the conjecture; upgrades row 93 and FS86-CL3 from external to certified | a separating colouring would refute a published claim (unlikely, and newsworthy); UNSAT confirms |
| **D. FS-90 (c)**: a triangle-free forcer of `(0, 4)` inside `ℚ₂(√3)` | a yes answers Soifer 55.1 | open-ended | yes | in 2 h ~0.01 (row 84 prices triangle-free four-colour refusals at ≥ 1,284× the control; G65's four-colour band) | through Soifer only | **nothing**: no finite search refutes `4 ∈ F_tf` |
| **E. FS-90 (d)**: `Λ₅₁₀`'s route 4; 29's certificate | lattice bookkeeping for "rich" | minutes | yes | ~0.95 | none | little |
| **F. FS-87**: kernel targets (W1 `ℤ[T] = O`, Theorem A by W's route, row 89, C12.1, then the stripe lemma) | kernel grade for hand results | a Lean agent; leaves have priced high (§ What compute helps) | no | steady progress ~0.9 | none | — |
| **G. FS-88**: Mixon's literal ring `ℤ[ζ₆, ω₃]` | a question posed in print | a derivation agent; Hubai's comments first | no | ~0.3 | none | where the field-level result (row 89) stops reaching the ring |
| **H. A reading pause**: Berend 1983–84, Furstenberg 1967 (not even a bibliography row), Einsiedler–Lindenstrauss, Soifer's 55.1 wording | prior-art debts | hours | no | high | indirect | — ; better done **inside** A′ as its §PA |
| **I. Item 70**: audit `m₁(ℝ²) ≤ 0.2470` (`[AmbrusEtAl2023]`) | row 92's grade, and so CL1's reach to ℚ(√47) and ℚ(√167) | unknown: no code or certificate held | no (an existing checker on an existing certificate), if their files are public | unknown | protects the one FS-86 result that touches the exposed fields | — |

**The close's FS-90 pricing, checked against the records.**
- (a): "unpriced" is right, and the stub is honest that a timeout means nothing.
- (b): "minutes once the graph is held" is **conditional on an acquisition the records do not price**. `[Heule2021]` is "journal archive; loan", and whether it holds T721 is "unchecked". The certificate path is also longer than "minutes": `cake_lpr` and `drat-trim` are not installed, so "a verified checker" means the Lean kernel's core route, about an hour.
- (c): correctly marked least likely.
- The recommended order, (b) then (a), puts a certain confirmation first and a silent instrument second. Neither changes a move this week.

## §5 The recommendation for Kooshi

**Rank 1 — open FS-89 in its re-posed form (A′), as a derivation milestone, with the full reframe (WORKFLOW 3.1–3.3).**
- **The choice:** a milestone whose first stage checks one page of algebra. The claim is that HD1, for every type-(B) field, follows
  from a statement about the **rational** unit circle alone, by the same `5^{−k}` gluing that proved FS-81's three-colour theorem. The
  stage then decides whether one prime (5) suffices, exactly as at three colours, or whether many primes are needed.
- **Alternative weighed:** FS-89 as stubbed (A), a literature reading on measure rigidity, then an attempt.
- **Why A′ wins:**
  - A's "low confidence" is the price of the *measure* framing. The primary asks for a *closed-set* theorem, which is the tractable
    Furstenberg–Berend kind.
  - A′'s first stage is cheap and decisive either way. One branch proves HD1 outright. The other turns FS-89 into a field-free
    problem with an explicit obstruction.
  - A′ is the only option this week that bears on the conjecture. The same statement at bands 1/4 and 1/5 decides whether any
    single character can colour ℚ(√47)'s plane with four colours, or ℚ(√167)'s with five. That is the conjecture's one solver-free
    falsifier instrument (FS-83), at both of its exposed fields.
- **Confidence:** medium. **The one fact that would change it:** the blind check of the gluing step failing. Then A′ collapses to A, and
  I would recommend C plus FS-87 for the rest of the week, with FS-89 kept as a reading. If instead the single-prime band set comes
  out torsion-plus-archimedean, confidence goes to high: HD1 lands.
- **Staffing (Kooshi's call):** a derivation agent and a blind verifier, within the three-agent cap. The owner's plan-phase reframe
  should treat card 1 as input, not as settled: the gluing is one mind's sketch.

**Rank 2 — the two sanctioned hours: T721's audit (C), only if Heule's graph can be fetched rather than borrowed; otherwise bank them
until 2026-10-01.**
- **What runs:**
  1. Fetch the graph.
  2. Check in exact ℚ(√2,√3) arithmetic that every edge has length 1 and that the named pair is at distance 2.
  3. CaDiCaL on "four colours with the pair separated".
  4. Extract the core from the LRAT and check it in the Lean kernel by the route in `Instances/TwoAdicFive/Edges.lean`.
- **Outputs:** UNSAT and a kernel-checked core (row 93's input becomes certified), or a colouring that separates the pair (a published
  claim refuted).
- **What certifies the output:** the kernel, or the colouring itself.
- **What a timeout would mean:** only that 721 vertices were unexpectedly hard. That is a measurement of the encoding (§ Toolchain,
  symmetry breaking), never a fact about the graph.
- **Alternative weighed:** (a) HD1-cert. It is silent on failure, and A′ may make it moot.
- **The exception to this rank:** if Kooshi rules that A′ Stage 0's exact computation of the single-prime band set is a Θ tree under
  the ban, the two hours go **there**. It is the only search in view where one outcome is a proof and the other re-aims the week.
- **Confidence:** high that (a) and (c) should not get the hours. Medium on (b) versus banking; it turns on whether the graph is public.

**Rank 3 — after 2026-10-01:** run (a) only if A′ has not decided HD1, and (c) only with a price in G65's four-colour band. FS-87's leaves
are the filler whenever an agent slot is free.

**Default (if Kooshi says nothing):** the owner opens FS-89 in its re-posed form (A′) with its reframe, and the two hours stay unspent.
The grant is Kooshi's.

## §6 Six and seven, honestly (E3 answered)

- **What FS-86 did to the exposed fields.** It pushed the conjecture's exposed fields onto one question: colourings of **infinite type**.
  - Row 92 with CL1 killed every measurable window four-colouring of ℚ(√47)'s and ℚ(√167)'s planes over finitely many places.
  - Five colours at ℚ(√167) are untouched, because the real place's `m₁ > 1/5`.
  - The conjecture's only solver-free falsifier instrument, a single character colouring the whole plane (FS-83), now lives exactly in
    HD1's gap.
- **What that gives the missing theorem.** Re-posed (A′), it is the one piece of mathematics that bears on the conjecture this week. It
  either closes the character falsifiers at both exposed fields, or produces the first infinite-type band character: a concrete seed
  for a four-colouring of ℚ(√47)'s plane local at no prime.
- **What it does not give.** Closing the characters does not prove `χ(ℚ(√47)²) = 5`, because non-character colourings remain. No option
  on the table bears on six directly, and none on seven.
- **What search buys.** E2 held. A search buys a finite witness where a derivation has already named the object. A′ Stage 0 is where
  such an object would first be named.

## §7 Hunch ledger (the §0 hunches scored; new ones registered)

hunch: fs89-is-furstenberg-shaped
  claim: FS-89's missing theorem is, or implies, an open case of Furstenberg-type ×p×q measure rigidity (zero entropy at the archimedean place), so it cannot land in a week
  basis: prior
  falsifier: the stub or the derivation file shows the action has a hyperbolic place or positive entropy supplied by the colouring, so a published theorem (Einsiedler–Lindenstrauss, Rudolph–Johnson, Berend) applies directly
  registered: 2026-09-25
  status: killed (by: `plans/FS86-C-deBruijn.md` §7.5 — the Furstenberg shape held, but the needed statement is about closed invariant sets, the proved kind, and not about measures; "cannot land in a week" rested on the measure reading)

hunch: heule-audit-needs-no-exception
  claim: the (b) candidate, auditing Heule's T721 graph, is a checker run on an existing certificate and fits the week's rules without the sanctioned two hours
  basis: prior
  falsifier: the FS-90 stub shows (b) requires a SAT refutation or a solver re-run to produce the certificate
  registered: 2026-09-25
  status: killed (by: `plans/STUB-sanctioned-search-fs86.md` row (b) — CaDiCaL plus a verified checker; and `BIBLIOGRAPHY.md` `[Heule2021]` — the graph is not held)

hunch: two-hours-best-unspent-or-confirmatory
  claim: no candidate in FS-90 is decisive in both directions within two hours, so the best use is a derived-claim confirmation or deferral until the ban lapses on 2026-10-01
  basis: prior
  falsifier: a candidate whose both outcomes (refusal and colouring) are certificates and whose priced cost fits in two hours with margin
  registered: 2026-09-25
  status: killed (by: FS-90 row (b), two-sided on a fixed 721-vertex instance — in letter; in spirit it stands, since (b) changes no move this week and is conditional on acquiring the graph)

hunch: measure-framing-is-a-summary-drift
  claim: G76, the FS-89 title and §11 call the missing theorem "measure rigidity", while the primary asks for a closed-set theorem
  basis: read
  falsifier: de Bruijn §7.5 or Coxeter's C15 stating that the closed-set form is insufficient for HD1
  registered: 2026-09-25
  status: confirmed (by: `plans/FS86-C-deBruijn.md` §7.5, "closed `U_F`-invariant subsets of `R̂` are contained in `T + A`, or contain a leaf segment"; `plans/FS86-derivation.md` FS86-Cx-C15 is the measure reading)

hunch: gluing-reduces-hd1-to-the-rational-circle
  claim: for every type-(B) field, HD1 follows from `Θ₄(ℤ[U_ℚ]) ⊆ T_N + A` by G74's `5^{−k}` gluing and FS86-dB-Theta; and `Θ₄(ℚ(√47)) = ∅` follows the same way
  basis: derived
  falsifier: a blind verifier exhibits a band character of `R` whose every layer restriction is torsion-plus-archimedean but which is not, or finds FS86-dB-Theta needs more than `T + A`
  registered: 2026-09-25
  status: open

hunch: one-prime-is-not-enough-at-four-colours
  claim: the four-colour band set of `ℤ[U₅]` at [1/4, 3/4] contains a branching family of points that are not torsion-plus-archimedean, unlike C1(5) at three colours
  basis: analogy
  falsifier: the exact band set of `ℤ[U₅]` at [1/4, 3/4] is torsion-plus-archimedean only
  registered: 2026-09-25
  status: open

## §8 Honesty record

- **Searches run:** none. **Computations run:** none; the heuristic in §3 is arithmetic on the page.
- **"Would have searched here":** once. I would have enumerated the first few 5-adic digit levels of the single-prime band set to test
  `one-prime-is-not-enough-at-four-colours`. I left it as a registered hunch for A′'s Stage 0.
- **Read versus recalled:**
  - Read: the primaries at the addresses above.
  - Recalled, not read here: Furstenberg 1967's closed-set theorem, Berend's three conditions (the bibliography row states them), and
    Zhu's `χ_c ≥ χ_f` (used in the record's H-36(a)).
- **Frame risk:** card 1 is a construction, in the hypothetical mood. The trickster's edge applies: it could be talking past a real
  wall, namely de Bruijn's obstruction of poles elsewhere, which may simply reappear in the rational setting (§3 says where). The
  gluing is the checkable part, and it should be checked before anything is built on it.
