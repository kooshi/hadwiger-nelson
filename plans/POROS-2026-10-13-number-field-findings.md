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
  rank: 1

### 1.7 Invention signal (stage 1)

Invention signal: none seen yet; read so far are the brief, the request file and the launch context only. One whiff is
carried into the reading as the card above — the brief's "a declared theorem of the literature" beside `CLAUDE.md`'s
"method transferred, three blind derivations" for the same statement; I pick no side before row 120 is read.

## Evidence inventory

*Seen versus read: an item is read only against an expectation written before the reading. Stage 1 lists the items and
their expectations; the later stages fill the last column.*

- The brief `data/fs131/briefs/FS131-PN1-number-field-ranking.md` and its two quotations — read against: both quotations match their source to the character — surprised: no; 2 of 2, and one word of an unmarked paraphrase differs (§ 1.1)
- `data/fs131/REQUEST-2026-10-13.md` — read against: W1 asks for an order of formalization by interest to the field and says nothing about measure rigidity — surprised: no
- `LEDGER.md` § The claim list — read against: Theorem B's value is Fischer's; the residue bound has several independent earlier authors; the three-colour theorem and the five-colour clause are listed as ours — surprised: unread
- `LEDGER.md` row 120, measure rigidity at a number field — read against: E-a, a hand result of this project resting on one printed theorem by statement and one transferred method — surprised: unread
- `LEDGER.md` rows 121, 123, 127, the five-colour clause and its kernel form — read against: five at ℚ(√47) is by hand given measure rigidity; the kernel holds the upper bound and a conditional form over named hypotheses — surprised: unread
- `LEDGER.md` rows 82, 83, 99, three colours — read against: by hand, two independent derivations, no hypothesis; nothing of the theorem itself in the kernel beyond the barrier and one field — surprised: unread
- `LEDGER.md` rows 52–63, 72–73, 103–107, 119, the kernel's number-field holdings — read against: all on the standard three axioms; the bridge alone conditional on a named true proposition — surprised: unread
- `LEDGER.md` rows 66–71, 75, the finite planes and towers — read against: certificates checked by standalone checkers, some in the kernel; values at 3, 7, 11, 19 and bounds elsewhere — surprised: unread
- `LEDGER.md` rows 96–102, 110–118, 124, 128–130, characters, fractional and the collapse — read against: by hand given measure rigidity or given band rigidity; one or two minds — surprised: unread
- `CLOSED-QUESTIONS.md` §§ 1–4 — read against: E-b, § 1 holds a closure I cannot name; § 4 says a closed question is not thereby a paper — surprised: unread
- `plans/WHERE-THE-PROBLEM-STANDS.md` items 1–30 and § The prior-art position — read against: the items match the grokkings' account; the prior-art section names the seven earlier routes to the residue bound — surprised: unread
- `plans/STUB-writeup-main-clause-five.md`, `plans/STUB-main-clause-five-kernel.md`, `plans/STUB-theorem-B-writeup.md` — read against: each frames its paper by what the project built, and at least one framing reads wrongly for a stranger now that `χ(ℝ²) ≥ 6` is in print — surprised: unread
- `BIBLIOGRAPHY.md` entries for the works that posed the questions (Moorhouse, Soifer, Johnson, Fischer, Benda–Perles, Madore) and § E — read against: each posing is recorded with a page and a reading status; at least one is "abstract only" — surprised: unread

## Hunch ledger

hunch: measure-rigidity-at-a-number-field-is-partly-ours
  claim: the measure-rigidity statement the five-colour results consume is filed as a hand result of this project resting on one printed theorem by statement and one transferred method, and is printed whole nowhere
  basis: read
  falsifier: `LEDGER.md` row 120 or a `BIBLIOGRAPHY.md` entry naming a printed theorem whose statement is the one consumed
  registered: 2026-10-13
  status: open

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
  status: open

hunch: nothing-in-the-kernel-is-in-the-top-three
  claim: no finding already kernel-checked on the standard three axioms ends in the final top three
  basis: prior
  falsifier: a final top-three finding whose stated theorem is a kernel row with no hypothesis
  registered: 2026-10-13
  status: open
