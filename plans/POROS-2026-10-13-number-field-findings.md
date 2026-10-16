# Poros — which findings about planes over number fields the field would most want proved in Lean (job FS131-PN1, 2026-10-13)

*The asking lane's record for brief `data/fs131/briefs/FS131-PN1-number-field-ranking.md`. An unusual ranking: findings
ranked for publication, not stubs ranked toward the answer. The brief names no earlier Poros record to carry a hunch
ledger from, and the last one (`plans/POROS-2026-10-07-fs136-derived.md`) is about another object (the measurable
colourings of the real plane); its ledger is not carried here and stands where it is. Everything in this record is a
question, a reading or a ranking; this lane derives nothing and states no theorem at a grade other than the one filed.*

## Theorems this phase proved

None. This job proves no theorem.

## Stage 1 — SAVED: the readback, the frame, the criterion and the expected top five, written before the record was read

### 1.1 The readback

Quotations: **2 of 2 match** (W1 and H1 against `data/fs131/REQUEST-2026-10-13.md`; `data/fs131/pn1/quote_check.py`,
output `data/fs131/pn1/quote_check.out`, exit 0; with one character of W1 altered it exits 1 with `mismatches=1`,
`data/fs131/pn1/quote_check.fault.out`).

One small finding about the brief, of wording and not of substance: its § Why this job gives, in bold and as "his", the
question "which findings would be most interesting to the mathematicians in the field?"; W1 reads "what findings would
be most interesting to the mathematicians in the field". One word differs and nothing turns on it. The brief's pointer to
`CLAUDE.md` § Counter-priors' "fourth quotation, on Lean as no cost" resolves (the quotation beginning "Do not consider
Lean formalization a cost").

### 1.2 What I had seen when the expectations below were written

- The brief whole and `plans/STANDING-RULES.md` whole.
- `data/fs131/REQUEST-2026-10-13.md` whole (W1, H1 and the coordinator's labelled reading).
- `CLAUDE.md` and the grokkings file as loaded at launch — so every ledger row is known to me only by the sentence
  those two files give it. **Recalled from a summary, not read**: `LEDGER.md`, its claim list, `CLOSED-QUESTIONS.md`,
  `plans/WHERE-THE-PROBLEM-STANDS.md`, `BIBLIOGRAPHY.md` and the three stubs were unopened.
- The sizes of those files and the names of the earlier Poros records.

### 1.3 The frame on its five axes

| axis | as the request states it | its address |
|---|---|---|
| the object | "our interesting number field findings" | W1 |
| the question | "what findings would be most interesting to the mathematicians in the field" | W1 |
| the discipline | the problem's own literature: the chromatic number of the plane and, inside it, the planes over subfields of ℝ (Benda–Perles, Woodall, Johnson, Fischer, Zaks, Moorhouse, Madore, Soifer); the statements are algebraic number theory's | my reading; `CLAUDE.md` § Publication names the keys |
| the audience | a stranger who knows that literature and not this project, reading a public repository: "publish everything as a git repo" | W1 |
| the product | "the lean proofs for the good stuff" — an order the kernel lane formalizes in | W1 |

Two things about the frame are mine to say before any reading.

*The audience axis decides the statements.* Every working word here is coined in-house (`CLAUDE.md` § Publication, the
naming rule). A finding is ranked as the theorem a stranger would look for, so each candidate is restated without a
coined term before it is weighed; a finding that cannot be so restated is not yet a finding for that reader.

*The product axis has one question I cannot answer from what I arrived with*, and it bears on every candidate that
rests on measure rigidity. It is the first card (§ 1.6).

### 1.4 The criterion

**Who "the mathematicians in the field" are, in the order their wanting counts here.**

1. *The people who work on the chromatic number of the plane* — the readers of Soifer's book and of the Polymath16
   threads; de Grey, Heule, Exoo and Ismailescu, Parts, Voronov; and the small literature on planes over fields. W1's
   "the field" is, read literally, the field of the problem the project is named for. Their wanting counts first.
2. *Number theorists* who would read a statement of the form "the plane over `F` needs `k` colours exactly when the
   primes of `F` behave so" as a local–global theorem, and would ask at once what is proved and what is assumed.
3. *Ergodic theorists*, for whom a colouring theorem that consumes measure rigidity is a new consumer of a known
   theory — and who would ask first whether the rigidity statement consumed is one that is in print.
4. *The formalization community*, for whom the interest is the artifact: a posed question first answered in a proof
   assistant, a certificate checked by the kernel with no native evaluation, a library others can build on.

**What makes a finding one they would want, in order.**

1. **It answers a question the literature posed by name.** A numbered open problem in a book outranks a question in a
   paper's last section, which outranks a remark; posed twice independently outranks posed once; and the question must
   be found at its page, in a copy that was read.
2. **It is a classification** — an "if and only if" in the field's own arithmetic that turns a table of printed special
   cases into one theorem.
3. **A reader can check what it assumes.** A statement on the standard axioms outranks one conditional on a printed
   theorem, which outranks one conditional on a statement that is itself ours and by hand. This is not nearness to done
   in Lean: it is what the published sentence will say, and a reader discounts a conditional by how much of the
   condition is the author's own.
4. **It is ours**, by the claim list's own words, with a search behind it. A kernel proof of a printed theorem is a
   formalization product: it counts for reader 4 and is said to be that.
5. **Its method travels** — it is used again here, or its statement is in a class wider than the case it was found in.
6. **It corrects something in print.**
7. **It is a first in a proof assistant.**

**What is kept out of the order.** How near a finding is to done in Lean; how hard it was; how much the project built
on it; which of its stubs is oldest. Where I know the first, it goes in a column.

### 1.5 The expected top five, and what I expect the reading to show

Written from the launch context alone, so that the record can contradict it.

| expected rank | the finding, as I would state it today | why I expect it there | ledger rows as `CLAUDE.md` cites them |
|---|---|---|---|
| 1 | `χ(ℚ(√47)²) = 5`, as the first instance of "the plane over a real number field needs exactly five colours when …" | the one finding `CLAUDE.md` § Publication says answers a question posed independently and repeatedly (Moorhouse 2010; Soifer's Open Problem 55.1) | 121, 123, 127 |
| 2 | the three-colour theorem over every real number field, and with it the table for real quadratic fields through four colours (every squarefree `d` outside three residue classes modulo 168) | a classification with no hypothesis; it finishes what `[Fischer1990]` started for additive colourings | 82, 83, 99 |
| 3 | the upper bound as one theorem: the plane over `F` is coloured through any prime of `F(i)` fixed by complex conjugation, with the three cases above 2 | the mechanism every value rests on; I expect most of it to be prior art and the kernel proof to be the product | 52–60, 63 |
| 4 | the chain theorem, with `χ(ℚ(√2,√3)²) = 4` by an 18-vertex graph that has no Moser spindle in its field | a method that travels, already kernel-checked; its author is an outside model, which is the first objection | 103, 105 |
| 5 | the collapse: at an explicit totally real field every one of whose places mixes, the field's plane has the real plane's chromatic number | a statement a number theorist would stop at; conditional on measure rigidity | 128 |

What I expect the reading to show, each a hunch in the ledger with its falsifier:

- **E-a.** Measure rigidity at a number field is filed as this project's hand result resting on one printed theorem and
  one transferred method — not as a theorem of the literature (`CLAUDE.md` § Where the problem stands: "row 120:
  `[EinsiedlerLindenstrauss2022]` Thm 1.3 by statement, with a two-mind deduction of its Thm 1.2, and
  `[EinsiedlerFish2010]`'s method transferred, three blind derivations").
- **E-b.** `CLOSED-QUESTIONS.md` § 1 holds at least one closed question I cannot name from the launch context, and it is
  closed with no hypothesis.
- **E-c.** The claim list attributes more of expected rank 3 to earlier authors than my sentence allows.
- **E-d.** Nobody posed "which planes over number fields are three-chromatic" as a named question: its "who asked" is
  weaker than rank 1's, and its strength is criterion 2 and 3.
- **E-e.** No finding that is already kernel-checked on the standard three axioms ends in the final top three: what the
  kernel holds is the mechanism and printed theorems, and what the field wants is by hand.

### 1.6 The first card

question: is-measure-rigidity-at-a-number-field-in-print
  evidence: the brief's § Why this job, "It does not ask for measure rigidity at a number field to be formalized: that enters Lean as a declared theorem of the literature"; `CLAUDE.md` § Where the problem stands, "over MR (row 120: `[EinsiedlerLindenstrauss2022]` Thm 1.3 by statement, with a two-mind deduction of its Thm 1.2, and `[EinsiedlerFish2010]`'s method transferred, three blind derivations)"
  expected: a statement declared in Lean as an outside theorem is a printed theorem, term for term, as the three declared so far are (`CLAUDE.md` § Trust ledger: Weil's bound "read against its page by two readers"; the two of `[OAIMath2026]` "the release's stored statement term for term")
  ask: is the measure-rigidity statement the five-colour results consume printed anywhere as a theorem about the unit-vector group of a real number field, or is part of it a hand derivation of this project?
  if printed whole: the conditional findings are published "given a theorem of X, page n", the declared statement is copied from that page, and they rank by criterion 1 with a small discount
  if partly ours by hand: the Lean statement carries that part as a named hypothesis of this project and never as an outside theorem; every finding resting on it is ranked as conditional on our own unformalized claim, and the hold H1 is the reader's first objection
  answered by: record — `LEDGER.md` row 120 with its derivation entries, and the two papers' entries in `BIBLIOGRAPHY.md` with their reading status
  cost: one row, two bibliography entries, perhaps one derivation section
  hunch: partly ours by hand — the zero-entropy half is a transfer of a method, by the sentence quoted
  falsifier: a printed theorem whose hypotheses the unit-vector group of a real number field meets as stated and whose conclusion is the statement row 120 uses
  rank: 3

*(Ranked 1 when written. Answered at stage 2 — partly ours by hand, § 2.1 item 1, and the coordinator's Amendment 1 —
and re-ranked third at stage 3 so that the open cards of § 3.8 lead.)*

### 1.7 Invention signal (stage 1)

Invention signal: none seen yet; read so far are the brief, the request file and the launch context only. One whiff is
carried into the reading as the card above — the brief's "a declared theorem of the literature" beside `CLAUDE.md`'s
"method transferred, three blind derivations" for the same statement; I pick no side before row 120 is read.

## Stage 2 — SAVED: the candidates, and what the reading did to stage 1

### 2.0 Amendment 1, read

The coordinator amended the brief at 16:07 UTC while I was reading row 120: measure rigidity at a number field is this
project's own hand result, not a printed theorem. Its three quotations (the gate's receipt lines for `MR`, `PE2` and
`EFPlus`, each `kind=ours`) match their source, **3 of 3** (`data/fs131/pn1/quote_check_amendment1.py`, output
`quote_check_amendment1.out`, exit 0; with `kind=ours` altered in the first it exits 1,
`quote_check_amendment1.fault.out`). The first card (§ 1.6) had the same question open; its answer is below, from the
record, and it is the amendment's. From here on a finding that rests on measure rigidity is judged in the form the
amendment gives — *kernel-checked given one named hypothesis, which is this project's own rigidity statement, derived by
hand from a printed theorem* — and where the other form would place it differently, both places are given.

**Amendment 2 (16:12 UTC), read while this stage was being written, replaces that last sentence.** Kooshi's word, W2,
matches its source (1 of 1, checked by the same reflow as stage 1's): "I choose the second form. Any finding of ours
must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see
what it would take to formalize as well." So a finding that rests on measure rigidity is judged in its **full form —
kernel-checked given only the printed theorem of Einsiedler and Lindenstrauss, this project's two deductions
formalized** — and one order is given. The last column of § 2.3 is kept: it says which findings rest on that chain.

### 2.1 What the reading changed

Read in full: `CLOSED-QUESTIONS.md` (724 lines); `LEDGER.md` § The claim list; rows 72, 73, 75, 82, 83, 99, 100, 119,
120, 121, 123, 127, 128 whole; rows 103, 105, 107 to their prior-art clauses; rows 57 and 129 to 1,700 characters; the
first 400 characters of 49 further rows between 42 and 130 (`data/fs131/pn1/row.py` prints a row by number);
`plans/WHERE-THE-PROBLEM-STANDS.md` § The prior-art position; `plans/STUB-writeup-main-clause-five.md` whole;
`plans/STUB-main-clause-five-kernel.md` to line 60; twelve `BIBLIOGRAPHY.md` entries to 900 characters; `LEDGER.md` § B's
lines for FS-66 and for the outside model's ten statements. **Not read:** rows 1–41 and 131–167 (known by `CLAUDE.md`'s
sentence only); the derivation files; `plans/STUB-theorem-B-writeup.md`; any paper.

Against the expectations of § 1.5:

1. **E-a held, and the amendment says the same.** Row 120's prior-art clause: "the transfer to an `S`-adic solenoid or
   number field not found (four zbMATH queries; Huang 2017, Huang–Li–Shi–Xu 2023 read at §1: circle and tori only)",
   "EF_F⁺ not in print", "MR not found under its discipline's names". The claim list puts it under **Ours**: "the entropy
   split of measure rigidity for the unit-vector group and its Einsiedler–Fish transfer". What is printed is
   `[EinsiedlerLindenstrauss2022]` Thm 1.3, from which its Thm 1.2 follows by "a deduction EL2021 never writes
   (FS105-DED, two minds, one blind)", and whose "cited leafwise-measure machinery" is "unread — a reading gap, not a
   mathematical one" (row 120).
2. **E-d is killed, and it moves the order.** I expected nobody to have posed the four-colour question for real
   quadratic fields by name. Johnson posed it twice, in the two surveys of this literature, both read at the page here
   (`CLOSED-QUESTIONS.md` § 1.7): 2000, p. 176, "But the determination of χ(ℚ²(√m), 1) for m ≡ 11 mod 12 (m positive,
   square-free) is still open"; 2006, p. 214, "I think that the following is an open problem: does there exist a
   positive integer m such that χ(G(ℚ²(√m), 1)) ≥ 4? The same question with "≥" replaced by ">" is very interesting, if
   the answer is yes!". Fischer asked for the criterion in 1990 (§ 1, "whether some algebraic criterion can be found to
   determine the chromatic number of F² where F is a subfield of R, of finite degree over Q"), and it is Benda–Perles's
   Open Question (4), Johnson's Problem 4.4 and Soifer's Open Problem 11.6. So the three-colour theorem has the strongest
   "who asked" in the record *and* no hypothesis.
3. **E-b held, five times over.** Closures I could not have named from the launch context, each with no hypothesis:
   `[BardestaniMallahiKarai2017]` Question 1, "the p–adic Hadwiger-Nelson problem" (§ 1.8; no); Gibbs's `5/3` question
   on Polymath16 (§ 1.4; no, kernel-checked); Johnson 2006's question on `ℚ⁴` (§ 3; answered whole, two minds, one
   blind); `[Ellenberg2018]`'s periodicity question at three colours (§ 2.4); Johnson 2000's question on the group the
   unit vectors generate, at `n = 2` (§ 2.7).
4. **E-c held.** The upper bound is other people's in all its parts: "the finite-plane bound and χ(𝔽₁₁²) = 5
   (Moorhouse, Manturov, Madore)", "the two-colour mechanism over fields (Woodall, Fischer, Moorhouse, Madore; …)",
   "Theorem A's coset construction out of the unit-vector subgroup (`[Fischer1990]` Thm 1(i); …)", "the value χ(K²) = 4
   … (`[Fischer1994]` …)" (claim list, Not ours). Ours there is the kernel proof. Expected rank 3 falls out of the top
   as a finding and stays as what the first findings stand on.
5. **Not expected at all: the framing of `plans/STUB-writeup-main-clause-five.md` has aged.** Its fifth theorem is "the
   corollary Kooshi's reading names: `χ(ℝ²) ≥ 5` with no witness object", and its banner asks whether to lead with the
   collapse `χ(ℝ²) = χ_m⁰(ℝ²)` given measure rigidity. Since `[OAIMath2026]` both are in print in a stronger form with no
   hypothesis (`χ(ℝ²) ≥ 6`; the equality outright — row 128: "independent, and theirs is the theorem"). What that release
   does not touch is the value of any number field's plane. The stub's lasting content is its theorems 2 and 3.
6. **One attribution reads two ways in the claim list** (sent to the coordinator at once, as the brief asks). Ours:
   "three colours over every real number field" (rows 99–102). Not ours: "the two- and three-colour classifications (GPT
   Astra, G55)". `LEDGER.md` § B resolves it: ASTRA-2026-09-14-T3 is "`χ(F²) = 2` iff `L(F) = 2`, for every real number
   field `F`"; ASTRA-2026-09-14-T4 is "for `√3 ∈ F`, `χ(F²) = 3` iff some prime of `F` has residue field `𝔽₃` iff
   `L(F) = 3`". So the two-colour classification is the outside model's whole, the three-colour one its only where
   `√3 ∈ F`, and rows 82 and 99 are this project's. **Draft line for the coordinator** (`LEDGER.md` § The claim list,
   Not ours; it replaces "the chain theorem, prime inversion in its general form (every number field, every prime) and
   the two- and three-colour classifications (GPT Astra, G55)"): *the chain theorem, prime inversion in its general form
   (every number field, every prime), the two-colour classification over every real number field and the three-colour
   one over fields containing √3 (GPT Astra, G55; `LEDGER.md` § B, ASTRA-2026-09-14-T2 to T5)*.

### 2.2 The line around "number-field findings"

**Inside:** the chromatic number of the plane over a real number field, by value and by family; the finite residue
planes and their towers; the conjecture that the value is read off the primes, with its proved range; the fractional
and the character versions over a field; the `p`-adic and Borel statements; the measure-rigidity statement the
five-colour results consume; the theorems on Cayley graphs of lattices that the field results are proved through; and
**one thing the brief's list does not name — the rational points of four-space** (Johnson 2006's question), because it
is the same literature, the same readers and the same mechanism (a residue colouring at the prime above 2).

**Outside, named apart in § 3.6 if they belong:** the real plane's measurable colourings (rows 130–167); the closures of
the hexagonal fabric (rows 1–25), the cell family (rows 34–41), the classical interval (row 33) and the witness
reductions (rows 62, 64–65), which are about finite graphs or tilings and not about a field.

### 2.3 The candidates

Grades and mind counts are quoted from the rows; "ours" and "prior art" from `LEDGER.md` § The claim list unless a row
is named. **MR** in the last column means: conditional on measure rigidity at the field, this project's own hand
result (row 120).

| id | the finding, in the literature's words | rows; entry | grade and minds, as filed | ours (verbatim) | prior art (verbatim) | rests on |
|---|---|---|---|---|---|---|
| C1 | the plane over `ℚ(√m)` needs at least four colours for every squarefree `m ≡ 11 (mod 12)`; with the printed values, three-colourability of every real quadratic plane is decided | 73, 82, 83, 74; `plans/FS81-derivation.md` T1–T7 | row 82 "[hand, two independent derivations]"; row 73, `m = 11`: "[kernel, standard three axioms, 32.8 CPU s; general form for any real field holding √11]"; row 83 "[cert + hand]", all forty `m < 500` | "the passage from additive to all three-colourings at the field level and the census's structural certificates (rows 82–83; not found in print — `[Johnson2000]` p. 176 poses the family as open and `[Johnson2006]` p. 214 asks whether any `m` needs four, both read 2026-09-27)"; "the 3-adic barrier and the four-colour lower bounds for real quadratic fields (rows 72–73)" | "the unit argument and the 1/k obstruction, with the type-M relation at N ≡ −1 (mod 24) that row 82 uses (Fischer, 1990, additive colourings only)"; the values 2 and 3 and every upper bound (`CLOSED-QUESTIONS.md` § 1.7: "Only the lower bounds are ours") | nothing |
| C2 | for every real number field `F`: the plane over `F` is three-colourable exactly when a residue plane at one of its primes is; a non-bipartite one is three-chromatic iff some prime above 3 has residue field `𝔽₃`; and the value is the least residue value whenever that is at most 4 | 99; `plans/FS91-derivation.md` FS91-J02-T2, J02-T3, J09-J4 | "[hand (+ Weil, tools exact); S1 three derivations (J02, J09, J09v), S2 and the torsion theorem two, S3 three, no mixing two independent (J09; J09v blind, a different route)]" | "three colours over every real number field" (rows 99–102) | "the two- and three-colour classifications (GPT Astra, G55)" — by § B, two colours over every real number field and three where `√3 ∈ F`; "generalising `[Fischer1990]` Thm 9" (row 99) | nothing (Weil's bound, already a declared outside theorem) |
| C3 | `χ(ℚ(√47)²) = 5`; five at every real quadratic field whose least residue value is 5; for every real number field the value is the least residue value whenever that is at most 5 | 121, 123, 127; `plans/FS100-derivation.md` FS100-Q47, FS100-COR | row 121 "[hand; the headline rule met (every half two blind minds, SP-Cor checked blind): MR row 120's grade; …]"; row 123 "[hand + tools exact; MR row 120's grade (EL2021 Thm 1.2 external; derived for every real number field, its complex-place case never exercised on an instance); CLS three derivations …]"; row 127 "[kernel; standard three axioms, no native purchase; the lower halves conditional on named propositions, not vacuous domains]" | "the entropy split of measure rigidity for the unit-vector group and its Einsiedler–Fish transfer, and `χ(ℚ(√47)²) = 5` (rows 120–122)"; "the class theorem and SP-Cor in every degree, so the local–global conjecture's main clause through five over every real number field, `χ(ℚ(√3,√5)²) = 5`, … — not found in print (X24R; …)" | "the finite-plane bound and χ(𝔽₁₁²) = 5 (Moorhouse, Manturov, Madore)"; "the zero-entropy pigeonhole … (`[EinsiedlerFish2010]`, after Sataev 1975) and the positive-entropy dichotomy for totally irreducible solenoid actions (`[EinsiedlerLindenstrauss2022]` Thm 1.2, EL2003)" | **MR** |
| C4 | measure rigidity for the group of norm-one elements of `F(i)` acting on the dual of the ring they generate: an invariant measure null on the continuous characters is Haar | 120; `plans/FS100-derivation.md` FS100-EFP, EFZ, PE2, MR; `plans/FS105-derivation.md` | "[hand; PE-2 two derivations blind to each other (X02D, X02V), applying EL2021 Thm 1.2 by statement …; EF_F⁺ three derivations blind to one another … and a checking reading …; MR a composition, three minds; at degree 16 one checking walk (FS105-W)]" | "the entropy split of measure rigidity for the unit-vector group and its Einsiedler–Fish transfer" | as C3's second quotation; "the extremal-trace name for MR's finitely generated case, the generalized Furstenberg conjecture (`[LacaWarren2018]`, open)" | `[EinsiedlerLindenstrauss2022]` Thm 1.3 by statement |
| C5 | the Borel chromatic number of the `p`-adic plane is unbounded in `p ≡ 3 (mod 4)`: `χ_Bor(ℚ_p²) ≥ 1 + (p+1)/(2√p)`; and `χ_Bor(ℚ₇²) = 4`, `χ_Bor(ℚ₁₁²) = χ_Bor(ℚ₁₉²) = 5`, `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8` | 75; `plans/FS66-derivation.md` T7, T8, L1–L6 | § B: FS66-T7 "hand"; row 75 "[hand]" (the fibre-share inequality), "[cert]" (the four certificates, "each `CERTIFIED` by a frozen standard-library checker written from the specification"); `χ(UD(ℤ/121, 2)) = 5` "[kernel]"; no mind count filed | "the fibre-share inequality and the all-levels certificates, with the answer to the `p`-adic Hadwiger–Nelson question (row 75)" | "the tower chain (`[Madore2015]` Prop. 3.8) and the `p`-adic question (his ¶1.5; `[BardestaniMallahiKarai2017]`)"; "the measurable Hoffman bound (`[BachocEtAl2014]`)" | Weil's bound and the measurable ratio bound, both printed |
| C6 | a Cayley graph of a finitely generated torsion-free abelian group is three-colourable iff it has a periodic three-colouring iff some character sends every generator into `[1/3, 2/3]`; periodic three-colourings are dense | 79, 119; `plans/FS73-derivation.md` T21–T30, T39–T45; `plans/FS75-derivation.md` | row 79 "[hand; two independent derivations — …"; row 119, the forward half in winding form with a certificate checker and `χ(ℚ(√167)²) ≥ 4`: "[kernel; standard three axioms, no native purchase]" | "the three-colour criterion, density and dichotomy for abelian Cayley graphs and the `Θ` certificate (rows 78–79)"; "the winding form of the three-colour criterion's ⟹ as a `Θ₃` certificate's semantics, and the certificate's kernel checker (row 119; as far as the gate reached; its ingredients are in print)" | "the periodic-colouring question (`[Ellenberg2018]`; Gibbs and Mixon on Polymath16, 2018); the height lift behind the three-colour theorem (Chandgotia's height functions for four-cycle-free targets)" | nothing |
| C7 | a four-colouring of the rational points of four-space can forbid the distances 1 and `d` together exactly when `d² = p/q` with `p`, `q` odd (for `d` realised there) | no row of its own (noted in row 59); `data/consolidation-2026-09-27/lv/record.md` LV-T3; blind `data/consolidation-2026-09-27/lx/record.md` | "[derived, two minds, one blind]" (`CLOSED-QUESTIONS.md` § 3) | not in the claim list | `CLOSED-QUESTIONS.md` § 3: "the *if* half is `[Johnson1990]` Thm 3 (LX), the *only if* the half p. 212 calls open"; Zaks's Lemma 1 (`[Zaks1999]` p. 92) | `[Zaks1999]` Lemma 1, printed |
| C8 | the ring generated by the norm-one elements of `F(i)` is the ring of elements integral at every prime fixed by complex conjugation; `1/p` lies in it iff no such prime lies above `p`; the unit-distance graph on `F²` has infinitely many components | 100 (Lemma C′), 105; `plans/FS91-derivation.md` § 2, § 4 | row 100 "[hand (+ tools exact); two independent derivations …]", Lemma C′ "three derivations"; row 105 "[kernel]" in valuation form | "prime inversion in valuation form, with no number field (row 105)" | "prime inversion in its general form (every number field, every prime) … (GPT Astra, G55)"; "the unit-vector ring's prime inversion for multiquadratic fields at odd unramified primes, … the ring in closed form for real quadratic fields, and 1/2 ∈ Σ₀ iff N ≡ 7 (mod 8) (`[Fischer1990b]`, 1989, read 2026-09-16)"; `CLOSED-QUESTIONS.md` § 2.7: "the general form of Lemma C′ not found in print (FS-91's gate), `[Shimura1964]` undecided" | nothing |
| C9 | the chain theorem: a pair forced equal at difference `δ` with `1/δ` a sum of unit vectors refuses `k` colours inside the field; `χ(ℚ(√2,√3)²) ≥ 4` by an 18-vertex graph with no Moser spindle in its field | 103 | "[kernel; the `K(√7)` bound conditional on `G4`, a measurement]" | row 103: "the kernel forms ours" | "the chain theorem … (GPT Astra, G55)"; row 103: "GPT Astra's (`ASTRA-2026-09-14-T5`, `T6`, `T9`; G55)" | nothing |
| C10 | the plane over `ℚ(√3,√11)` is four-chromatic, by a colouring through the residue field `𝔽₄` at a prime above 2; and the general residue colouring of a graph drawn in an abelian group | 57 | kernel (`chromaticNumber_seamPlane`, `colorable_of_residue`) | `plans/WHERE-THE-PROBLEM-STANDS.md`: "Theorem A's kernel proof (its statement merges those two); Theorem B's kernel proof and its 𝔽₄-valued residue colouring" | "the value χ(K²) = 4 and the additive ℤ/4-colouring of the plane over his congruence family of biquadratic fields (`[Fischer1994]`, § Publication; restated in `[Johnson2000]` p. 176 and `[Johnson2006]` p. 214)"; "Theorem A's coset construction out of the unit-vector subgroup (`[Fischer1990]` Thm 1(i); …)" | nothing |
| C11 | the upper bound: a prime of `F` with residue field of `q ≡ 3 (mod 4)` elements gives `χ(F²) ≤ χ(𝔽_q²)`; the cases above 2; `χ(𝔽₁₁²) = 5` | 52, 53, 56, 63 | row 52 "[hand + tools]"; rows 53, 56, 63 kernel over rings and valuation subrings; row 57: "**Not proved:** that a number field with a conjugation-fixed prime supplies the valuation subring with residue field of size N(𝔭)" | "the sieve; the lift theory" | "the finite-plane bound and χ(𝔽₁₁²) = 5 (Moorhouse, Manturov, Madore)"; "the two-colour mechanism over fields (Woodall, Fischer, Moorhouse, Madore; …)"; "the multiquadratic decomposition (ChatGPT, credited in row 63)" | nothing |
| C12 | `χ(F(t)²) = χ(F²)` for `t` transcendental; the planes over `ℚ(π)`, `ℚ(e)` are bipartite | 104 | "[kernel]" | the kernel form | "transcendence is free (`[Fischer1990]` Thm 6) and its lemma, integrality at a place whose residue field has no `√−1` (`[Madore2015]` Prop. 3.2)" | nothing |
| C13 | `χ(ℝ²)` is the maximum of `χ(F²)` over real number fields; and a counterexample to the first sentence of `[Fischer1990]` Remark 1 (`ℚ(π, √(π³ − π))` lies in no purely transcendental extension of a number field) | 107 | "[kernel; C1, C2, C4 conditional on `RealAlgebraicDescent`, a proposition, not a vacuous domain]"; the counterexample kernel | the kernel forms; the counterexample (row 107: "`[Fischer1990]` Remark 1's first sentence refuted (C3, C3⁺)") | "the bridge `χ(ℝ²) = sup_F χ(F²)` (`[BendaPerles2000]` pp. 117–118, 1976, …)" | Tarski or Artin–Lang, printed, as a named hypothesis |
| C14 | the fractional chromatic number of the plane over `ℚ(√3,√11)` is exactly 4 | 71; `plans/FS56-field-blowup.md` | hand (`CLOSED-QUESTIONS.md` § 1.6: "Proof: `plans/FS56-field-blowup.md` (hand). **Not kernel-checked** beyond Theorem B") | "the field-internal reading of the fractional blow-up and `χ_f(K²) = 4` (row 71)" | "the geometric fractional chromatic number, the blow-up and `G27` (`[AmbrusEtAl2023]`, `[MatolcsiEtAl2025]`)" | their Theorem 1 and their graph, printed |
| C15 | over `ℚ(√3,√11)` a pair of points forced to one colour by every four-colouring lies at a distance of positive valuation at the prime above 2, and a pair forced apart at valuation zero | 59 | kernel | "the compulsion transfer and distance law" | "the observed 2-adic compulsion pattern and its coordinate form (Heule, Parts, Dúcz)" | nothing |
| C16 | over a field with a prime of residue field `𝔽₁₁`, no two distinct points of any unit-distance graph are forced to one colour by every five-colouring, and only unit edges are forced apart (so `5/3` is not forced, Gibbs's question) | 55, 66 | kernel (for the certificates of the kernel's field tower; Heule's 510-vertex graph outright) | "the fan-gap transport and its compulsion consumers (row 66)" | `CLOSED-QUESTIONS.md` § 1.4: "The premise … is `[Fischer1990]`'s `k·G = 0` obstruction at `k = 5`. The distance law is ours (ledger row 55)" | nothing |
| C17 | the plane over a real multiquadratic field is bipartite iff no odd square class is `≡ 3 (mod 4)` | 63; `CLOSED-QUESTIONS.md` § 2.3 | "as a hand theorem with its mechanism in the kernel"; row 63: the valuation forms "have **no instance over a real field yet**" | § 2.3: "What is new, if anything, is the multiquadratic iff" | "the two-colour mechanism over fields (…)"; "the multiquadratic decomposition (ChatGPT, credited in row 63)"; the two-colour classification over every real number field (GPT Astra) contains it | nothing |
| C18 | every proper four-colouring of the lattice of de Grey's graph is periodic under 8 times the lattice; there are 9,120 | 78, 85; `plans/FS85-derivation.md` FS85-R3b, V2-T8 | § 2.5: "two independent derivations"; "by hand and exact computation from Parts's no-monochromatic-√3-triple trees"; "**Not kernel-checked**" | "`F = P = 8Λ` on de Grey's lattice by derivation and the audit of its input" | "the Moser ring's 9,120 four-colourings, all 8-periodic (Hubai, Polymath16, 2018); the no-monochromatic-√3-triple trees and the stripe lemma (`[Parts2020hv]`, §3)" | `[Parts2020hv]`'s trees, walked as a certificate |
| C19 | every four-colouring of the plane over `ℚ(√3,√11)` is, on each component, pulled back from one finite graph at one of the two primes above 2; the plane over `ℚ₂(√3)` is rigid at four colours | 89, 90, 88 | row 89 "[hand + cert + external, two derivations …"; rows 88, 90 hand | "the type-(B) frame, the classification of `K²`'s four-colourings, the rigid local plane and the no-go family on type-(B) planes (rows 88–94)" | "the forced pair at 8/3 (Harder, Polymath16, 2018)" | row 89: "given one non-zero forced difference" |
| C20 | the finite Euclidean planes: no `𝔽_q²`, `q ≡ 3 (mod 4)`, is exactly six-chromatic outside `q ∈ {23, 27, 31, 43, 47}`; six refused at 59, 67, 79, 83 and five at 23, 27, 43 by exact certificates; `χ(UD(ℤ/121, 2)) = 5` | 53, 68, 69, 70, 71, 75 | "[cert]", "[exact-rational]"; `ℤ/121` "[kernel]"; `χ(𝔽₁₃²) = 5` measured with "**No record of the measurement** … on disk" (§ 1.5) | "the fibre-share inequality and the all-levels certificates" | "ω and ω ≠ χ on finite planes (Vinh, Krebs, Schneider–Silva)"; "the ratio bound …"; `[Moorhouse2010]` Table 6.1 | Weil's bound; certificates accepted by standalone checkers |
| C21 | character colourings: the plane over `F` has a character `k`-colouring iff some residue plane has one; band characters of the ring of rational norm-one elements at two or more primes are torsion plus archimedean | 95–98, 100–102 | row 100 "[hand (+ tools exact); two independent derivations …]" "at existence scope" | "rational band rigidity at two or more primes, at every band, and its field consequences (rows 95–97, 98)"; "the class theorem for character colourings, the character chromatic numbers" | "band rigidity on `ℤ[i][1/P₅, 1/P₁₃]` (`[Manners2015]` Lemma 5.3), the regular chromatic number (`[BarajasSerra2008]`)" | nothing |
| C22 | at an explicit totally real field every one of whose places mixes (`ℚ(√635087)`), the plane has the real plane's chromatic number | 128 | "[hand + tools exact; the load-bearing step two derivations blind to each other … MR row 120's grade; …]" | row 128: "the field equality and the selection over stable places not found in print" | row 128: "the plane equality is in print outright in `[OAIMath2026]` family 158 … independent, and theirs is the theorem" | **MR** |
| C23 | the independence ratio of the plane over `F` is the larger of the real plane's and the best residue plane's | 129 (field clause) | "[hand + tools exact; FRAC, TJ, ROUND, DV, TF, 47 two derivations …" | row 129 | `[OAIMath2026]` Thm 2.3 for the plane clause | **MR** |
| C24 | the kernel's theory of forced pairs: the spindle theorem (a pair forced equal at any distance `≥ 1/2` refuses the colour count), critical sets, absorption, additive rigidity, freedom of finite planes | 42–51, 58, 60, 61 | kernel | "the compulsion transfer and distance law; the tightness mechanism"; "plane freedom at every prime p ≡ 3 (mod 4)" | — | nothing |
| C25 | no-gos and reductions at four colours on lattices: no cell-local certificate; rank one reduced; triangle-free rigidity in the abstract class equivalent in the plane to Soifer's Open Problem 55.1 | 80, 86, 108 | hand, two derivations (rows 80, 86) | "the classification of four-colour edge-local heights over every generating set, the four no-gos by format …"; "the triangle-free abstract rigidity and its Soifer calibration" | "the four-colour grid's cohomological triviality (`[CGHO2025coh]`), the triangular lattice's four-colour height (`[MooreNewman2000]`), the Zig-zag Theorem (`[SimonyiTardos2006]`)" | nothing |
| C26 | products: from a Borel `k`-colouring of `X × Cay(K, T)` with a mixing compact factor one reads a colouring of `X`; when every colouring of `G × H` comes from `G` | 109, 114–115 | hand | "the mixing selection"; "the product criterion `χ(E_k(G)) ≤ k` for gap-free `G` …" | "the mixing selection's complete-graph case (Burr–Erdős–Lovász, `[Tardif2008]` Thm 3.2) …" | nothing |

## Stage 3 — SAVED: the ranking

### 3.1 What decided the order

Two things that were not in the record when the brief was written.

**Kooshi's word W2** (Amendment 2): a finding resting on measure rigidity is judged kernel-checked given only the
printed theorem of Einsiedler and Lindenstrauss. Under Amendment 1's form the five-colour theorem would have ranked
below the three-colour one, because its published sentence would have been conditional on a claim of ours; under W2 it
is conditional on a refereed theorem, which is how the field cites.

**The search of today** (`data/fs131/pn1/arxiv-2026-10-13.md`: the queries, two abstracts verbatim, the passages
quoted below with their extraction lines). Two papers posted last week, neither in `BIBLIOGRAPHY.md`, both in this
project's exact territory:

- **James Davies, *Measurable obstructions for unmeasurable colourings*, arXiv:2610.12301, 8 October 2026.** Its
  Theorem 1.1: `χ(ℚ^d) = χ(ℝ^d) = χ^(m)(ℝ^d)` for `d ⩾ 5`, and the same for the independence densities; in dimension
  four "there exists some positive integer n such that χ(R⁴) = χ(Q(√n)⁴)". Then, of the plane (extraction ll. 249–259;
  the radicals restored from the layout): "In the plane we suspect that a more complicated extension of Q² might be
  required. Nevertheless, the problem of determining the chromatic number of Q(√n)² has been well studied [32, 39, 49,
  56]. In particular, it is known that Q(√n)² is four-colourable for n ≢ 47, 143, 167 (mod 168). **It would be
  particularly interesting to determine if the remaining cases are six-colourable and if any of them contain a five
  chromatic unit distance graph.**" (emphasis mine). His [32], [39], [49], [56] are Fischer 1990, Johnson, Moorhouse 2010 and Payne.
  That is the five-colour theorem's question, posed by name five days ago by a specialist who cites this literature
  and holds no answer; and his residue classes are row 117's exactly.
- **Jonathan Davidson, *Coloring Monomial Cayley Graphs: The One-Parameter Case*, arXiv:2610.09474, 7 October 2026.**
  Cayley graphs on `ℤ[α]` with steps `±α^k`, `|α| = 1`; colourings from additive characters whose values on the steps
  keep away from zero (his figure's "shaded band is [1/3, 2/3]"); lower bounds from finite subgraphs by a solver. It
  cites Polymath16 and Cervantes–Krebs and none of Fischer, Johnson, Moorhouse, Madore or Ellenberg. It asks "Can two
  parameters already force five colors?" and "how few parameters suffice to attain the chromatic number of the plane,
  and which relations make them do so?" (ll. 2064, 2081–2082). It has the character test as a sufficient one; row 79
  is its converse at three colours.

Both raise the interest of what is ranked below, and both put a date on it.

### 3.2 The order

Ranked by interest to the field, by § 1.4's criterion. **The last two columns are kept out of the order**: which
findings rest on the measure-rigidity chain (so the kernel lane sees what its first member unlocks), and what the
record says the kernel holds today.

| rank | id | the finding | rests on the chain | the kernel today, as the record states it |
|---|---|---|---|---|
| 1 | C3 | five colours: `χ(ℚ(√47)²) = 5`, and the plane over a real number field has the least residue value whenever that is at most 5 | **yes** | the composition, over named hypotheses; `χ(ℚ(√47)²) ≤ 5` with none (row 127) |
| 2 | C1 + C2 | three and four colours with no hypothesis: four for every `ℚ(√m)`, `m ≡ 11 (mod 12)`; the three-colour criterion over every real number field | no | `m = 11` (row 73); the forward half of the three-colour criterion and `ℚ(√167)` (row 119) |
| 3 | C22 + C23 | the plane over a number field against the real plane: `χ(ℚ(√635087)²) = χ(ℝ²)`; the independence ratio of `F²` | **yes** | nothing; a statement over named hypotheses is drafted (`plans/STUB-main-clause-five-kernel.md`, banner) |
| 4 | C5 | the `p`-adic Hadwiger–Nelson problem: no | no | `χ(UD(ℤ/121, 2)) = 5` (row 75) |
| 5 | C6 | a Cayley graph of a lattice is three-colourable iff a character puts its generators in `[1/3, 2/3]` | no | the forward half, in winding form, with a certificate checker (row 119) |
| 6 | C4 | measure rigidity for the norm-one group of `F(i)` | it is the chain | a named hypothesis (`MR`, `PE2`, `EFPlus`) |
| 7 | C7 | four-colourings of `ℚ⁴` forbidding two distances | no | nothing |
| 8 | C8 | the ring the unit vectors of `F²` generate | no | prime inversion in valuation form (row 105) |
| 9 | C14 | `χ_f(ℚ(√3,√11)²) = 4` | no | the upper bound (row 57) |
| 10 | C10, C16, C9, C13 | what is already kernel-checked and a reader will look for: the plane over `ℚ(√3,√11)` is four-chromatic (the value Fischer's); no pair is forced at five colours over a field with a prime of residue field `𝔽₁₁` (Gibbs's question); the chain theorem (the outside model's); the counterexample to Fischer's Remark 1 | no | done |
| 11–18 | C18, C20, C21, C17, C19, C12, C15, C24–C26 | periodicity on de Grey's lattice; the finite planes' window; character colourings; the rest | no | mixed; C12, C15, C24 done |

### 3.3 The first ten, each as the theorem a reader would look for

No coined term is used undefined. In every statement `F` is a subfield of `ℝ`, `F²` carries the graph joining points
at Euclidean distance 1, and a *unit vector* is an element `z` of `F(i)` with `z z̄ = 1`.

**Rank 1 — C3. Five colours.**
- *The theorem.* (Given the printed theorem of Einsiedler and Lindenstrauss.) The unit-distance graph on `ℚ(√47)²` has chromatic number 5. For a real quadratic field `ℚ(√n)`,
  `n` squarefree, the plane needs at least five colours exactly when `n ≡ 47, 143, 167 (mod 168)`. For every real
  number field `F`: let `L(F)` be the least chromatic number among the finite graphs `Cay(𝒪/𝔓^m, image of the unit
  vectors)`, `𝔓` a prime of `F(i)` fixed by complex conjugation, `m ⩾ 1`; then `χ(F²) ⩽ L(F)`, and `χ(F²) ⩾ min(L(F),
  5)`. Corollary: a finite triangle-free five-chromatic unit-distance graph exists in the plane (none is exhibited).
  The definition of `L(F)` here is my reading of the kernel's `localBound` (every level `m`, the image of the unit
  vectors); the planner fixes it from FS100-COR, where the record notes one hand step between two forms of it
  (`plans/STUB-main-clause-five-kernel.md`, "Caveat carried from X11K2").
- *Entry.* `plans/FS100-derivation.md` FS100-Q47 and FS100-COR (with CLS, SPC, TCA); `plans/FS84-SI-D-derivation.md`
  (J45's lemmas); `plans/R88-derivation.md` R88-TCA. Kernel names: `SpectralChain.min_localBound_five_le_chromaticNumber`,
  `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain`.
- *Who asked.* `[Davies2026]` (the passage of § 3.1; read today in the PDF's text extraction at that passage, its
  abstract and Theorem 1.1 — the other 45 pages unread); `[Johnson2006]` p. 214, the ">" question, "very interesting,
  if the answer is yes!" (read in full 2026-09-27); `[Moorhouse2010slides]`, "What about χ(Q(√47)²)?" (the quoted
  slides read in the text layer; the rest of the deck not); `[ExooIsmailescu2019]`, concluding section, "what is the
  smallest subfield of E2 that requires 5 colors?" (its reading status not looked up today); `[Soifer2024]` p. 699,
  Open Problem 55.1, in its existence half only ("the text confirmed in the held PDF by the owner"); `[Fischer1990]`
  § 1 (held and read).
- *What it rests on.* By hand (rows 121, 123 at the grades of § 2.3); the composition kernel-checked over named
  hypotheses (row 127). Full form, by W2: conditional on `[EinsiedlerLindenstrauss2022]`'s theorem alone — and on
  three printed classical inputs the gate already classes as outside (Bochner on a locally compact abelian group;
  Markov–Kakutani; Weil's bound). It also uses the all-levels certificates at 11 and 19, accepted by a standalone
  checker and not by the kernel (row 123: "FS-66's certificates at 11 and 19 re-run CERTIFIED").
- *The first objection.* "Given what, exactly?" — which printed statement is declared is the first card (§ 3.8). Then:
  no graph is exhibited, and Soifer's problem says "Construct"; the measure-rigidity step's "complex-place case [was]
  never exercised on an instance" (row 123); `L(F)` must be defined in the statement, as above, or the theorem reads
  as a tautology; the upper bound is Moorhouse's, Manturov's and Madore's and is in the kernel at `ℚ(√47)` only.

**Rank 2 — C1 + C2. Three and four colours, with no hypothesis.** One family; the head statement is the table.
- *The theorem.* (a) For every squarefree `m ≡ 11 (mod 12)`, `χ(ℚ(√m)²) ⩾ 4`. So, with the printed values:
  `χ(ℚ(√m)²) = 2` for `m ≢ 3 (mod 4)`; `3` for `m ≡ 3, 7 (mod 12)`; `4` for `m ≡ 11 (mod 12)` outside the classes
  `47, 143, 167 (mod 168)`; and at least 4 in those. (b) For every real number field `F` whose plane is not bipartite:
  `χ(F²) = 3` iff some prime of `F` above 3 has residue field `𝔽₃`. (c) For any subfield `F` of `ℝ`: if `1/3` is an
  integer combination of unit vectors and `F²` has an odd cycle, then `χ(F²) ⩾ 4`.
- *Entry.* (a), (c): `plans/FS81-derivation.md` T1–T7. (b): `plans/FS91-derivation.md` FS91-J02-T2, J02-T3, J09-J4.
- *Who asked.* `[Johnson2000]` p. 176 and `[Johnson2006]` p. 214 (the two passages of § 2.1; both read in full
  2026-09-27); `[Fischer1990]` § 1; `[BendaPerles2000]` p. 126, Open Question (4), which is `[Johnson2000]`'s Problem
  4.4 and `[Soifer2024]`'s Open Problem 11.6 ("each read in the source 2026-09-27"). `[Davies2026]` states the upper
  bound for these planes as what "is known"; the exact value is this finding.
- *What it rests on.* By hand: row 82 "two independent derivations", row 99 "S1 three derivations". Kernel-checked
  already: `m = 11` on the standard three axioms (row 73) — which alone answers Johnson 2006's "does there exist" —
  and the forward half of the three-colour criterion (row 119). Conditional on nothing unprinted: row 99's route uses
  Weil's bound, row 82's uses none.
- *The first objection.* Attribution: the two-colour classification over every real number field and the
  three-colour one where `√3 ∈ F` are the outside model's (§ 2.1 item 6); the relation at `m ≡ 23 (mod 24)` and the
  values 2 and 3 are Fischer's and Johnson's; every upper bound is prior art — and at the level of a field the kernel
  does not hold it (row 57: "**Not proved:** that a number field with a conjugation-fixed prime supplies the valuation
  subring …"), so an "=" in the Lean statement needs that gap closed. Scope: (b) is for number fields; row 99 records
  where a wider reading fails.

**Rank 3 — C22 + C23. A number field's plane against the real plane.**
- *The theorem.* (Given the same printed theorem.) Let `F` be a totally real number field such that at every prime of `F(i)` fixed by complex
  conjugation the finite graphs above have all non-trivial normalised eigenvalues below `1/5` in absolute value.
  Then `χ(F²) = χ(ℝ²)`. This holds for `ℚ(√635087)` and for `ℚ(√3,√5,√7,√11)`, the field of de Grey's graph. With
  `[OAIMath2026]`: `χ(ℚ(√635087)²) ∈ {6, 7}`, and since that plane has no unit triangle, a finite triangle-free
  six-chromatic unit-distance graph exists. Density form: for a real number field `F`, the finitary independence
  ratio of `F²` (row 129's `α₁(F²)`; its definition to be taken from the entry) is the larger of `m₁(ℝ²)` and the best
  all-levels independence ratio among the finite graphs at its primes.
- *Entry.* `plans/FS103-derivation.md` § 1 (FS103-LB, SEL, F1, 635, 635TF, DG; FRAC, TJ, ROUND).
- *Who would care.* `[Davies2026]`: his Theorem 1.1 is this statement for `ℚ^d`, `d ⩾ 5`, and for a quadratic
  extension in dimension four; of the plane he writes "we cannot reduce colouring R^d to colouring Q^d for d = 2, 3, 4"
  and "we suspect that a more complicated extension of Q² might be required". `[BendaPerles2000]` pp. 117–118 (the
  maximum is attained at some number field; none was named); `[Payne2009]`.
- *What it rests on.* By hand (row 128: "the load-bearing step two derivations blind to each other"; measure
  rigidity at degree 16 "one checking walk"). Conditional on the chain; "∈ {6, 7}" on `[OAIMath2026]`'s theorem,
  already a declared outside theorem here.
- *The first objection.* An expert suspects the opposite (the second card, § 3.8). The plane equality
  `χ(ℝ²) = χ_m⁰(ℝ²)` is `[OAIMath2026]`'s — "independent, and theirs is the theorem" (row 128) — so ours is the field
  half only. The eigenvalue condition is over infinitely many primes: the statement must say how it is verified.

**Rank 4 — C5. The `p`-adic Hadwiger–Nelson problem.**
- *The theorem.* For every prime `p ≡ 3 (mod 4)` the Borel chromatic number of the graph on `ℚ_p²` joining `x`, `y`
  with `(x₁ − y₁)² + (x₂ − y₂)² = 1` is at least `1 + (p + 1)/(2√p)`; so it is not bounded in `p`. It is 4 at
  `p = 7`, 5 at `p = 11` and `p = 19`, and between 6 and 8 at `p = 23`.
- *Entry.* `plans/FS66-derivation.md` T7 (the bound); T8 and L1–L6 (the values).
- *Who asked.* `[BardestaniMallahiKarai2017]`, Question 1, Israel J. Math. 217 ("read first-hand, §1–§2", arXiv v4
  p. 2): "Is it true that there exists a universal constant B (independent of p) such that χ_Bor(QG_{𝒬_p}) ≤ B …?";
  `[Madore2015]` ¶1.5 for the plain number, which this does not touch.
- *What it rests on.* By hand; **no second derivation is filed** for T7. Conditional on two printed theorems: the
  measurable ratio bound as the posers' own Theorem 2.5 states it, and Weil's bound. The values: exact certificates
  accepted by a standalone checker, joined to the statement by six hand links; the upper halves prior art.
- *The first objection.* "Why did the posers not see it?" — the statement must show the one new step, the bound at
  levels two and above. And the plain chromatic number is untouched: the Lean statement must say Borel.

**Rank 5 — C6. Three-colourings of lattice Cayley graphs.**
- *The theorem.* Let `A` be a finitely generated torsion-free abelian group and `S = −S ⊂ A ∖ {0}` finite. Then
  `Cay(A, S)` is three-colourable iff some homomorphism `θ : A → ℝ/ℤ` has `θ(S) ⊆ [1/3, 2/3]`, iff it has a
  three-colouring periodic under a subgroup of finite index; and the periodic three-colourings are dense among all.
- *Entry.* `plans/FS73-derivation.md` T22–T24 (with T21–T30, T39–T45); the kernel form `ThreeColour.lean`,
  `ThetaCert.lean`.
- *Who asked.* `[Ellenberg2018]`, MathOverflow 304715 (read in full through the API; not held, so paraphrased in
  the record); Gibbs and Mixon on Polymath16 (held); `[CGHO2025bg]` Question 6.2 (read at § 1 and § 6.2). And as of
  last week a consumer: `[Davidson2026]` tests colourability by such characters and has no converse.
- *What it rests on.* By hand, "two independent derivations" (row 79). Nothing unprinted.
- *The first objection.* Ellenberg asked for every `k`; this is `k = 3`, and at four the record has only no-gos. The
  height lift is Chandgotia's, and "density at the **standard** generators is expected folklore … and not claimed".

**Rank 6 — C4. Measure rigidity for the norm-one group.** *The theorem*, as row 120 states it: "for every real number
field `F` with `R_F = O′` …, every `U_F`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of
Haar measure". I have not opened the entry, so the set `E` is not defined here: **the reader's statement must be
fixed from `plans/FS100-derivation.md` FS100-MR, not from this line.** *Entry:* FS100-PE2, FS100-EFP, FS100-MR;
`plans/FS105-derivation.md` FS105-DED. *Who would care:* ergodic theorists; nobody posed it. Its nearest in print are
`[LacaWarren2018]`'s conjecture (the finitely generated case, open) and `[OAIMath2026]` Thm 2.3 (the divisible case).
*Rests on:* `[EinsiedlerLindenstrauss2022]` by statement. *The first objection:* a reader will take it for a claim
about ×2×3; the statement must show that the group is infinitely generated and that this is what is used (row 120:
"MR was never the classical finitely generated question").

**Rank 7 — C7. Rational four-space.** *The theorem:* for `d > 0` with `d² ∈ ℚ`, a proper four-colouring of the
unit-distance graph on `ℚ⁴` with no monochromatic pair at distance `d` exists iff `d² = p/q` with `p`, `q` odd.
*Entry:* `data/consolidation-2026-09-27/lv/record.md` LV-T3. *Who asked:* `[Johnson2006]` p. 212, "I believe the
following is still open". *Rests on:* "[derived, two minds, one blind]"; `[Zaks1999]` Lemma 1 (read in full).
*The first objection:* it has no ledger row, no claim-list line and no gate — "nothing after 2006 searched". **Novelty
unchecked.** `[Davies2026]`'s "χ(Q⁴) = 4 …, so the restriction d ⩾ 5 … is necessary" makes it timely.

**Rank 8 — C8. The ring of unit vectors.** *The theorem:* for a real number field `F` in which no prime above 2
fixed by conjugation ramifies in `F(i)`, the additive group generated by the unit vectors is the ring of elements of
`F(i)` integral at every prime fixed by conjugation; in every case the unit-distance graph on `F²` has infinitely
many components. *Entry:* row 100's Lemma C′ (`plans/FS91-derivation.md` § 2; its entry id not looked up). *Who
asked:* `[Johnson2000]` § 5, p. 177. *Rests on:* by hand, three derivations; nothing unprinted. *The first objection:*
prime inversion in general is the outside model's, the quadratic and multiquadratic cases `[Fischer1990b]`'s, and
"`[Shimura1964]` undecided" — **novelty unchecked** where a number theorist would look first.

C8 is in the kernel (FS131-IRU1): Lemma C′ as typed and its odd form; the components clause at every real number field, which is equivalent there to the existence of a stable prime, and that existence is classical (`[Nagell1969]` Thm 3) and kernel-checked with no Chebotarev.

**Rank 9 — C14.** *The theorem:* the fractional chromatic number of the plane over `ℚ(√3,√11)` is 4. *Entry:*
`plans/FS56-field-blowup.md`. *Who asked:* `[CranstonRabern2015]`, concluding section. *Rests on:* by hand; the lower
bound is `[MatolcsiEtAl2025]`'s graph and theorem, the upper Fischer's value. *The first objection:* "Almost all of it
is theirs" (`CLOSED-QUESTIONS.md` § 1.6); ours is one observation.

**Rank 10 — what is already kernel-checked.** C10 (`chromaticNumber_seamPlane`): asked six times in print after
Fischer had answered it; the Lean statement's docstring must give the value to `[Fischer1994]`. C16
(`UDCert.forces_eq_11`): Gibbs's question, answered no at every distance. C9 (row 103): the outside model's theorem.
C13 (row 107): a correction to `[Fischer1990]` Remark 1. Nothing for the kernel lane to do but check the attributions.

### 3.4 Prior art, honestly, for the first five

| rank | the search behind "not found in print" | its age | today's search |
|---|---|---|---|
| 1 | X24R (row 121): "zbMATH listings of twelve posers and fifteen abstract queries, arXiv with a positive control, the Polymath16 threads held and live to 2026-09-24, `[Soifer2024]` chs. 11 and 55"; the two Johnson surveys read | 2026-09-26, 27 | the arXiv listing to 2026-10-08; `[Davies2026]` poses it as open on 2026-10-08. **Still "not found", and now with a competitor in sight** |
| 2 | FS-58, FS-61, FS-81 § PA.4 and FS-91's close gate (zbMATH, OpenAlex, arXiv, the Polymath16 archive; citation walks of four papers); the two Johnson surveys read. Row 99: "no mixing in the literature's words is unsearched" | 2026-09-19 to 27 | the same listing: nothing; `[Davies2026]` lists only the upper bound; `[Davidson2026]` has no result on a field's plane |
| 3 | FS103-G (row 128): "the posers' zbMATH listings, 39 queries, web, two citation walks" | 2026-09-26 | **changed**: `[Davies2026]` Theorem 1.1 is in print for `d ⩾ 4`; the plane is what he says he cannot do. The kind of statement is no longer new; the plane over a number field is not found |
| 4 | FS-66's gate (`CLOSED-QUESTIONS.md` § 1.8): the posers' full zbMATH listings, four abstract queries, a walk of the citing lists; "Not searched: MathSciNet; Russian-language literature" | 2026-09-20 | one web search and the arXiv listing: nothing |
| 5 | FS-79's gate (§ 2.4): the MathOverflow thread, two papers at named sections, four authors' zbMATH listings; "**Not read:** the rest of the two CGHO papers' reference lists, and the homshift literature on non-standard generating sets" | 2026-09-23 | `[Davidson2026]` read at its introduction, conjectures and last section: the sufficient half only. The circular-colouring literature (his [25], [28]) not searched for the converse — **owed** |

Ranks 7 and 8 are marked novelty unchecked in § 3.3. None of this is "first"; each is "not found in print".

### 3.5 The recommendation

**The choice.** The kernel lane takes **rank 2 first**, stated as the table for real quadratic fields through four
with the three-colour criterion for number fields beside it; then **rank 1 with rank 6 inside it** — the chain above
the three-colour theorem, and the two deductions under measure rigidity; then **rank 4**, which depends on neither.

**An alternative weighed.** Rank 1 first, because it is the most wanted and Davies posed it last week.

**Why this one won.** Rank 1 cannot be stated in the form W2 asks for without rank 2: row 127 names "row 99" among
the hypotheses of the kernel's five-colour statement, and the equality needs the field-level upper bound that row 57
calls not proved. So the first leaves are the same on either road, and taking them as rank 2 closes a question posed
twice by name with no assumption at the first gate — where the alternative's first gate would be a conditional. This
is an order by what rests on what, not by what is near.

**Confidence.** About 0.75. The fact that would change it: the kernel planner's map showing that row 82's route to
the quadratic table (no Weil, no number-field machinery) and row 99's route to the criterion share little — then
which of the two is the head statement becomes a real choice, and I would take the table, because it is what Johnson
asked for. And if Kooshi wants priority on five ahead of a first unconditional close, the alternative is his.

**If he says nothing:** rank 2, then rank 1 with rank 6, then rank 4.

### 3.6 Named apart: the real plane

Unranked against the above, as the brief asks; one line each.

- **FS-133 (row 129's plane clause): `ᾱ(ℝ²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁(ℝ²)`, with no hypothesis, over
  `[OAIMath2026]`'s rigidity theorem** — "[hand], one mind"; it answers `[DuczVarga2026]` Conjecture 1's first
  clause, `[MatolcsiEtAl2025]` § 2 and Johnson's Problems of 1996 and 2000 (`CLOSED-QUESTIONS.md` § 3), and it is the
  plane case of the density half of `[Davies2026]`'s Theorem 1.1, whose abstract hopes to reach "d = 3 or possibly
  even … d = 2". **It is the one finding in the repository with a visible clock**, and by criterion 1 it would stand
  beside rank 1. Kooshi asked about number fields; he should hear this.
- The disc criterion (row 161): already kernel-checked.

### 3.7 Which of the stubs' framings to keep

- `plans/STUB-writeup-main-clause-five.md`. **Keep** its theorems 2 and 3 and measure rigidity as their engine.
  **Reads wrongly now:** theorem 5, "`χ(ℝ²) ≥ 5` with no witness object", and the banner's lead with the collapse to
  a measurable number — each is in print, stronger and with no hypothesis, since `[OAIMath2026]`; and the frame "this
  project's local–global conjecture, proved through five", which a stranger reads as a conjecture of ours confirmed
  by us. The frame a reader has this week is `[Davies2026]`'s sentence: the chromatic number of `ℚ(√n)²`.
- `plans/STUB-main-clause-five-kernel.md`. **Keep.** Its "Next" list is in the order of its prices (Markov–Kakutani,
  the upper half, Herglotz–Bochner); by W2 the order is the upper half and row 99 first.
- `plans/STUB-theorem-B-writeup.md`. Not read today. By `CLOSED-QUESTIONS.md` §§ 1.1–1.2 its headline value and its
  general form are both in print; what is left is a kernel proof and a second colouring.

### 3.8 Cards

The stage-1 card is answered (§ 2.1 item 1) and is re-ranked third so that the open ones lead.

question: which-printed-statement-is-declared
  evidence: the gate's receipt, quoted in Amendment 1 — `MR … (… over [EinsiedlerLindenstrauss2022] Thm 1.3 by statement)` and `PE2 … (PE-2, over [EinsiedlerLindenstrauss2022] Thm 1.2; blind X02V)`; `LEDGER.md` row 120, "applying EL2021 Thm 1.2 by statement — … it rests on EL2021 Thm 1.3 (external, published) and a deduction EL2021 never writes (FS105-DED, two minds, one blind)"; W2, "Any finding of ours must be formalized"
  expected: the printed base of the chain is one statement, named the same way in every record
  ask: is Einsiedler–Lindenstrauss's Theorem 1.2, stated in their paper with its deduction from Theorem 1.3 left unwritten, a printed theorem to declare — or is that deduction ours to formalize, with Theorem 1.3 the one declared?
  if Theorem 1.2 is declared: it is copied from its page and read back by two readers, as Weil's bound was; FS105-DED stays out of Lean; the published sentence is "given Theorem 1.2"
  if Theorem 1.3 is declared: FS105-DED is a third deduction of ours to formalize under W2, the chain is longer by it, and the published sentence names the theorem the paper proves
  answered by: Kooshi — it is the edge of his rule; the kernel planner can say what each costs
  cost: one message; the page of the paper is held
  rank: 1

question: does-a-quadratic-field-suffice-in-the-plane
  evidence: `[Davies2026]`, extraction ll. 247–252, "in the four dimensional case the proof of Theorem 1.1 shows that there exists some positive integer n such that χ(R⁴) = χ(Q(√n)⁴). We conjecture that this also holds in the three dimensional case. In the plane we suspect that a more complicated extension of Q² might be required."; `LEDGER.md` row 128, "For every totally real number field `F` whose stable places are all 6-thick …, `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)`; instances ℚ(√635087) …"
  expected: a specialist who has just proved the statement in dimension four would expect it of the plane too, or would name what stops it
  ask: what in Davies's proof makes a quadratic extension enough in dimension four, and does its failure in dimension two bear on a real quadratic field with no obstructing prime, or only on his method?
  if it is a property a real quadratic field cannot have in the plane: row 128's instance at ℚ(√635087), and measure rigidity at degree 2 under it, has a defect to find before a line of it is formalized
  if it is his method's reach only: row 128 answers his sentence, and rank 3's statement is written against it
  answered by: derivation — Ephodos, from §§ 1 and 4–6 of the paper against FS103-LB and FS100-EFP
  cost: some fifteen pages of one paper and two held entries
  hunch: his method's reach — his proof counts lattice points on spheres, and the plane's circle has too few over ℚ, which is G80's point about why the whole unit-vector group is needed
  falsifier: a step of his that fails for every real quadratic field in dimension two for a reason that is not about lattice-point counts
  rank: 2

### 3.9 Invention signal

Invention signal: **one whiff, written as the second card above and reported as an `invention signal` item.** The two
sides, each in its own words with its address: `[Davies2026]` (arXiv:2610.12301, introduction; extraction ll.
249–252), "In the plane we suspect that a more complicated extension of Q² might be required"; `LEDGER.md` row 128,
"For every totally real number field `F` whose stable places are all 6-thick …, `χ(F²) = χ(ℝ²) = χ_CP(ℝ²)`; instances
ℚ(√635087) (… MR at degree 2)". One is a suspicion and the other a hand result given measure rigidity; they cannot
both be right, and I do not say which. The premise they may share — what a field must supply for its points to stand
for the plane's — is the card's question. Read for this job: `CLOSED-QUESTIONS.md` whole, the claim list, thirteen
ledger rows whole, and the two new papers at the passages listed. No other collision seen; the claim list's two-way
attribution (§ 2.1 item 6) is a wording defect its own index resolves, not a signal.

### 3.10 Draft lines for files this lane does not write

1. `LEDGER.md` § The claim list, Not ours — the line of § 2.1 item 6.
2. `BIBLIOGRAPHY.md`, two new rows. **[Davies2026]** J. Davies, *Measurable obstructions for unmeasurable colourings*,
   arXiv:2610.12301 (v1, 8 October 2026), 47 pp. — read: the abstract, Theorem 1.1 and the introduction's passages on
   rational points and `ℚ(√n)²` (2026-10-13, from a text extraction; FS131-PN1); the proofs unread. Poses rows 121–123's
   question; its Theorem 1.1 is row 128's kind of statement in dimension at least four. Library name:
   `pdf/Davies2026-measurable-obstructions-unmeasurable-colourings.pdf` (fetched, not filed).
   **[Davidson2026]** J. Davidson, *Coloring Monomial Cayley Graphs: The One-Parameter Case*, arXiv:2610.09474 (v1,
   7 October 2026), 50 pp. — read: the abstract, the introduction's statement of results, Conjectures 4.3 and 4.7,
   Corollary 4.6 and § 5's programme (same day, same way); the proofs unread. A consumer of row 79. Library name:
   `pdf/Davidson2026-coloring-monomial-cayley-graphs-one-parameter.pdf` (fetched, not filed).
3. `CLOSED-QUESTIONS.md` § 1.7, a fourth posing after Moorhouse's: *`[Davies2026]`, introduction (arXiv:2610.12301,
   8 October 2026): "it is known that Q(√n)² is four-colourable for n ≢ 47, 143, 167 (mod 168). It would be
   particularly interesting to determine if the remaining cases are six-colourable and if any of them contain a five
   chromatic unit distance graph."* And § 3's entry on `ℚ⁴` belongs in § 1 or § 2: it is answered, not adjacent.
4. `LEDGER.md` row 128, prior-art clause, to follow "theirs is the theorem": *in dimensions at least four the field
   equality is `[Davies2026]` Theorem 1.1 (`χ(ℚ^d) = χ(ℝ^d)` for `d ⩾ 5`; a quadratic extension at `d = 4`), which
   names the plane as beyond its method.*
5. `LEDGER.md`: C7 has no row. If it is formalized it needs one, with a gate behind it.

## Evidence inventory

*Seen versus read: an item is read only against an expectation written before the reading. Stage 1 lists the items and
their expectations; the later stages fill the last column.*

- The brief `data/fs131/briefs/FS131-PN1-number-field-ranking.md` and its two quotations — read against: both quotations match their source to the character — surprised: no; 2 of 2, and one word of an unmarked paraphrase differs (§ 1.1)
- `data/fs131/REQUEST-2026-10-13.md` — read against: W1 asks for an order of formalization by interest to the field and says nothing about measure rigidity — surprised: no
- `LEDGER.md` § The claim list — read against: Theorem B's value is Fischer's; the residue bound has several independent earlier authors; the three-colour theorem and the five-colour clause are listed as ours — surprised: yes; all three hold, and one more thing I did not expect: the same paragraph lists "three colours over every real number field" under Ours and "the two- and three-colour classifications (GPT Astra, G55)" under Not ours (§ 2.1 item 6); and measure rigidity itself is under Ours
- `LEDGER.md` row 120, measure rigidity at a number field — read against: E-a, a hand result of this project resting on one printed theorem by statement and one transferred method — surprised: no; as expected, and one degree weaker than expected — the printed theorem used (Thm 1.2) follows from the paper's Thm 1.3 by "a deduction EL2021 never writes (FS105-DED, two minds, one blind)"
- `LEDGER.md` rows 121, 123, 127, the five-colour clause and its kernel form — read against: five at ℚ(√47) is by hand given measure rigidity; the kernel holds the upper bound and a conditional form over named hypotheses — surprised: yes; the kernel's conditional form names not one hypothesis but the whole chain — "row 123's count, A⁺ from R88-TCA, R-U, MR in the class as PE-2 and EF_F⁺, CLS, row 99" and the upper half (row 127) — so row 99, the three-colour theorem, is a named hypothesis of the five-colour one
- `LEDGER.md` rows 82, 83, 99, three colours — read against: by hand, two independent derivations, no hypothesis; nothing of the theorem itself in the kernel beyond the barrier and one field — surprised: yes; row 82 is wider than a number-field theorem ("The field is incidental": any multiplicatively closed set of unit vectors holding the rational pattern), and Johnson posed its family as open by name, twice (§ 2.1 item 2)
- `LEDGER.md` rows 52–63, 72–73, 103–107, 119, the kernel's number-field holdings — read against: all on the standard three axioms; the bridge alone conditional on a named true proposition — surprised: no for rows 72, 73, 103, 105, 107, 119 (read to their prior-art clauses); rows 52–63 read at their heads only, row 57 to 1,700 characters — its "Not proved" clause is the gap every field-level upper bound in the kernel waits on
- `LEDGER.md` rows 66–71, 75, the finite planes and towers — read against: certificates checked by standalone checkers, some in the kernel; values at 3, 7, 11, 19 and bounds elsewhere — surprised: yes at row 75, read whole: it answers a question posed by name in print (`[BardestaniMallahiKarai2017]` Question 1) with no hypothesis; rows 66–71 read at their heads only
- `LEDGER.md` rows 96–102, 110–118, 124, 128–130, characters, fractional and the collapse — read against: by hand given measure rigidity or given band rigidity; one or two minds — surprised: no for rows 100 and 128 (read whole) and 129 (to 1,700 characters); the others read at their heads only, and counted as seen
- `CLOSED-QUESTIONS.md` §§ 1–4 — read against: E-b, § 1 holds a closure I cannot name; § 4 says a closed question is not thereby a paper — surprised: yes; five closures I could not name, each with no hypothesis (§ 2.1 item 3), and § 3 holds a sixth thing, Johnson 2006's question on `ℚ⁴`, answered whole and filed under "adjacent and open"
- `plans/WHERE-THE-PROBLEM-STANDS.md` items 1–30 and § The prior-art position — read against: the items match the grokkings' account; the prior-art section names the seven earlier routes to the residue bound — surprised: no for § The prior-art position (read whole); items 1–30 not read, known by the grokkings' account only
- `plans/STUB-writeup-main-clause-five.md`, `plans/STUB-main-clause-five-kernel.md`, `plans/STUB-theorem-B-writeup.md` — read against: each frames its paper by what the project built, and at least one framing reads wrongly for a stranger now that `χ(ℝ²) ≥ 6` is in print — surprised: no for the write-up stub (read whole; § 2.1 item 5) and the kernel stub (to line 60); `plans/STUB-theorem-B-writeup.md` unread, and nothing in the ranking turns on it
- The arXiv listing of the 40 most recent papers on the chromatic number of the plane, to 2026-10-08 (`data/fs131/pn1/arxiv-2026-10-13.md`) — read against: nothing posted since the gates of 2026-09-26 and 27 touches the first five findings — surprised: yes; two papers of last week do, neither in the bibliography
- `[Davies2026]`, arXiv:2610.12301: abstract, Theorem 1.1 and the introduction's passages on rational points and on `ℚ(√n)²` — read against: a transfer theorem for high dimensions with nothing about a number field's plane — surprised: yes; it poses the five-colour theorem's question by name ("if any of them contain a five chromatic unit distance graph") and suspects the opposite of row 128 for the plane
- `[Davidson2026]`, arXiv:2610.09474: abstract, statement of results, Conjectures 4.3 and 4.7, § 5 — read against: it holds the three-colour criterion by characters in both directions, which would be prior art for row 79 — surprised: yes, the other way; it has the sufficient half only, credits it to the multiplier method, and cites none of the literature on planes over fields
- `BIBLIOGRAPHY.md` entries for the works that posed the questions (Moorhouse, Soifer, Johnson, Fischer, Benda–Perles, Madore) and § E — read against: each posing is recorded with a page and a reading status; at least one is "abstract only" — surprised: yes; each posing was read at its page in a held copy (Johnson 2000 and 2006 and Benda–Perles in full, 2026-09-27; Bardestani–Mallahi-Karai §1–§2 first-hand), the weakest being Moorhouse's slides ("the quoted slides read in the text layer …; the rest of the deck not read"); § E not read

## Hunch ledger

*Scored in the open at the close of stage 3. Of the seven registered at stage 1: the one read from a source is
confirmed by its address; of the six from prior belief, two are killed (nobody-posed-three-colours-by-name;
nothing-in-the-kernel-is-in-the-top-three) and four were borne out by the reading or by the final order —
root-47-is-first (rank 1, and only because of W2: under Amendment 1's form it would have been third),
three-colours-is-second (rank 2), a-closure-i-cannot-name (five of them, § 2.1 item 3), the-claim-list-narrows-the-upper-bound
(§ 2.1 item 4). By this ledger's rule a hunch from prior belief is not promoted by the reading that tests it, so those
four stay `open` below and are not counted as confirmed. Two more are registered at stage 3.*

hunch: measure-rigidity-at-a-number-field-is-partly-ours
  claim: the measure-rigidity statement the five-colour results consume is filed as a hand result of this project resting on one printed theorem by statement and one transferred method, and is printed whole nowhere
  basis: read
  falsifier: `LEDGER.md` row 120 or a `BIBLIOGRAPHY.md` entry naming a printed theorem whose statement is the one consumed
  registered: 2026-10-13
  status: confirmed (by: `LEDGER.md` row 120, l. 165, prior-art clause — "EF_F⁺ not in print", "MR not found under its discipline's names"; the claim list, l. 27, Ours; `data/fs124/l2/gate/receipt-assumptions-final.log`, `kind=ours` three times)

hunch: root-47-is-first
  claim: by the criterion of § 1.4, applied after the reading, `χ(ℚ(√47)²) = 5` with the five-colour clause is the finding the field would most want
  basis: prior
  falsifier: the final ranking, argued from the record, puts another finding first
  registered: 2026-10-13
  status: open

hunch: three-colours-is-second
  claim: the three-colour theorem over every real number field ranks second, on criteria 2 and 3
  basis: prior
  falsifier: the final ranking puts it first, or below third
  registered: 2026-10-13
  status: open

hunch: a-closure-i-cannot-name
  claim: `CLOSED-QUESTIONS.md` § 1 holds a question closed with no hypothesis that the launch context does not name
  basis: prior
  falsifier: every § 1 entry is one I listed in § 1.5 or is conditional
  registered: 2026-10-13
  status: open

hunch: the-claim-list-narrows-the-upper-bound
  claim: the claim list gives the residue upper bound and most of the cases above 2 to earlier authors, leaving the kernel proof and a general form as ours
  basis: prior
  falsifier: the claim list lists the general upper bound as ours without an earlier author
  registered: 2026-10-13
  status: open

hunch: nobody-posed-three-colours-by-name
  claim: no work in the bibliography poses "which planes over number fields are three-chromatic" as a named open question
  basis: prior
  falsifier: a page in `CLOSED-QUESTIONS.md` or the bibliography where it is posed
  registered: 2026-10-13
  status: killed (by: `CLOSED-QUESTIONS.md` § 1.7 — `[Johnson2000]` p. 176 poses the family `m ≡ 11 mod 12` as "still open" and `[Johnson2006]` p. 214 asks whether any `m` needs four; what the miss cost: stage 1 gave the three-colour theorem a weak "who asked", and it has the strongest unconditional one in the record)

hunch: nothing-in-the-kernel-is-in-the-top-three
  claim: no finding already kernel-checked on the standard three axioms ends in the final top three
  basis: prior
  falsifier: a final top-three finding whose stated theorem is a kernel row with no hypothesis
  registered: 2026-10-13
  status: killed (by: `LEDGER.md` row 73 — `four_le_chromaticNumber_planeOver_eleven`, on the standard three axioms, is rank 2's first member and by itself answers `[Johnson2006]` p. 214's "does there exist"; the family's theorem is by hand, so the hunch was half right and is scored as wrong)

hunch: his-suspicion-is-his-methods-reach
  claim: `[Davies2026]`'s "In the plane we suspect that a more complicated extension of Q² might be required" states what his lattice-point method reaches, and names no obstruction to a real quadratic field with no obstructing prime
  basis: prior
  falsifier: a step of his proof that fails for every real quadratic field in dimension two for a reason other than a count of lattice points on spheres
  registered: 2026-10-13
  status: open

hunch: row-79-is-the-converse-davidson-lacks
  claim: by row 79 and compactness, a monomial Cayley graph on any set of unit parameters is three-colourable exactly when a character puts every step in `[1/3, 2/3]`, so `[Davidson2026]`'s Conjecture 4.3 is a statement about such characters and nothing else
  basis: derived
  falsifier: a three-colourable Cayley graph of a countable torsion-free abelian group with no such character, or a step of the compactness passage that needs the generating set finite
  registered: 2026-10-13
  status: open

