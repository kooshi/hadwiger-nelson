# Brief FS131-PN1 — which of this project's findings about planes over number fields would mathematicians in the field most want to see proved in Lean: a ranking

*Written 2026-10-13 16:01 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-PN1
  identity: Poros — your agent file (`.claude/agents/poros.md`) is your identity and your lane's workflow; this is a ranking job of an unusual kind (findings ranked for publication, not stubs ranked toward the answer), so where your workflow's job 1 speaks of the frontier, read "the findings"
  role: the ask-and-rank lane at a change of direction — the project is being wound down and published, and you say which of its findings about planes over number fields mathematicians in the field would most want, each stated as the theorem a reader would look for, so that the kernel lane formalizes those first
  launch: now, on `main`; beside you a planner of the kernel lane maps what each of these findings rests on in the Lean library, on a branch of its own — you write no file it writes
  mission: § Why this job
  statements: § The request, and what it covers
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **as soon as the ranked list is saved** (the kernel planner's second phase waits on it — a few lines: the ranked findings by name, and where the list is); at once if you find a finding recorded as ours that the record itself attributes to someone else, or two records that grade one finding differently; the report goes to `data/fs131/reports/FS131-PN1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/POROS-2026-10-13-number-field-findings.md` (new)
  touches: `plans/POROS-2026-10-13-number-field-findings.md`, `data/fs131/pn1/`, `data/fs131/reports/FS131-PN1.md`; on `main`, committed by explicit path. **Not** `CLAUDE.md`, `LEDGER.md`, `CLOSED-QUESTIONS.md`, `BIBLIOGRAPHY.md`, `plans/FRONTIER-STUBS.md` or any stub: where one of them needs a change, draft the line in your record
  budget: about 350k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); you cannot read that count, so save a stage (a commit) when your criterion and expectations are written, when the candidates are listed, and when the ranking is saved; hand back before you would guess 500k

Hello. The project has turned a corner since you last ranked for it, and this job is the first step after the turn.

## Why this job

For three weeks the work has been aimed at six against seven for the real plane, and it moved no value there. Kooshi has
now decided to wind the project down and publish the whole repository. What he wants in it before that is Lean proofs of
the findings a mathematician would actually come for, and he has said where to look first (his words are quoted whole
at the head of the next section). So the question to you is his: **which findings would be most interesting to the mathematicians in the field?** The
kernel lane then formalizes in your order. A second job runs beside you — the kernel lane's planner, mapping for each
number-field result what the library already holds and what it assumes. You do not need its map and it does not need
your ranking to start; when yours is saved I pass it on, and it plans the first module.

Why you and not the planner: what a field wants is a judgment about its literature — who asked, how often, in print or
in passing, and what exactly is ours — and that is your lane's reading. A Lean engineer asked the same question ranks by
what is near in the kernel, which is the wrong order (`CLAUDE.md` § Counter-priors, rule 1: a route is never ranked by
its formalization effort; and its fourth quotation, on Lean as no cost).

One earlier word of his bears on this, and I have read it as follows; say so if the record reads otherwise to you.

> H1: (2026-10-06; FS-131 inventory item 488 — the earlier word that W1 bears on) Let's keep holding off on formalizing or pricing MR for now. That backlog is big enough that I might request community support for filling it. I'm going to wait to do that too though.
> — source: data/fs131/REQUEST-2026-10-13.md

My reading (mine, labelled): today's word lifts that hold for the number-field results themselves. It does not ask for
measure rigidity at a number field to be formalized: that enters Lean as a declared theorem of the literature,
unformalized and unpriced. So a finding that rests on it would be published as "kernel-checked, given that theorem" —
and whether a reader in the field would still want it in that form is part of what you are judging.

## The request, and what it covers

> W1: (2026-10-13) Ok, we're resumed […] on the laptop instead of the desktop. Hopefully that doesn't hinder us to much. I'd like to continue with the lean backlog, specifically targeting our interesting number field findings. We're going to wind this project down and publish everything as a git repo (after some cleanup and sanitization, especially moving the transcript backups out of git history). But, to do that, we need the lean proofs for the good stuff. Have a planner determine what findings would be most interesting to the mathematicians in the field, and then let's start formalizing those.
> — source: data/fs131/REQUEST-2026-10-13.md

**"Our interesting number field findings"** — read widely, and draw the line yourself: the chromatic number of the plane
over a real number field, value by value and family by family; the finite residue planes and towers that bound it; the
local–global conjecture, its proved range and its exposed predictions; the fractional and character versions; the
`p`-adic and Borel statements that came out of the same machinery; the structure theory in the kernel that the field
results stand on (compulsions, the two theorems on residue colourings, the chain theorem, the bridge). Where the record
is:

- `CLOSED-QUESTIONS.md` — questions the literature posed and this project answered, with who posed each and where
  (§ 1 closed, § 2 answered in one direction or with a caveat that must travel, § 3 adjacent and open, § 4 on why
  that file is not a publication plan);
- `LEDGER.md` — one row per result with its grade and address; **its § The claim list is what is ours and every
  attribution, verbatim: read it before calling anything ours** (one value here is K. G. Fischer's of 1994, and the
  project's vocabulary once hid that);
- `plans/WHERE-THE-PROBLEM-STANDS.md` — items 1–30, the arithmetic era in order, and § The prior-art position;
- `CLAUDE.md` § The local–global conjecture and § Publication (the three kinds of thing that clear the bar, and the
  naming rule: every working term here is coined in-house, and `BIBLIOGRAPHY.md` § E is the translation table);
- `BIBLIOGRAPHY.md` — each cited work with how much of it has been read;
- the stubs that were written for exactly this: `plans/STUB-writeup-main-clause-five.md`,
  `plans/STUB-theorem-B-writeup.md`, `plans/STUB-main-clause-five-kernel.md`.

**Not covered, but name them apart if they belong:** results about the real plane's measurable colourings (the last
three weeks' milestones). If one or two of those would plainly rank among the first things a reader wants, list them in
a short section of their own, unranked against the rest, with one line each — Kooshi asked about number fields, and he
should hear it if the best thing in the repository is elsewhere.

## Done means

1. **Before you read the record** (a saved stage): your criterion for "interesting to the mathematicians in the field" —
   which fields and which readers (the people who work on the chromatic number of the plane; number theorists; ergodic
   theorists; the formalization community), what makes a finding one they would want (a posed question answered; a
   named conjecture's case; a method that travels; a first of its kind in a proof assistant), in an order — and your
   expectation of the top five, written down so that the reading can surprise you.
2. **The candidates** (a saved stage): every finding inside the line you drew, each with its ledger row, its grade and
   mind count as filed, and — verbatim from the claim list — what of it is ours and what is prior art.
3. **The ranking**: the candidates in order of interest to the field, by your criterion. For each of the first ten or
   so:
   - the finding as the theorem a reader would look for, in the literature's words (no coined term undefined), precise
     enough that I can fix a claim list from the derivation entry it points to — give that entry's address;
   - who asked or would care, with the bibliography key and the page or section, and whether our copy was read there;
   - what it rests on, as the record states it: already kernel-checked (name the row), kernel-checked over named
     hypotheses, or by hand; and whether its publishable form is conditional on measure rigidity at a number field, on
     another theorem of the literature, or on nothing;
   - what a careful reader would object to first (an attribution, a hypothesis, a statement that sounds larger than its
     entry), so that the Lean statement answers it.
   Rank by interest. Do not rank by how near a finding is to done in Lean; say that in a column if you know it, and
   keep it out of the order.
4. **Prior art, honestly**: for each of the first five, what search stands behind "nobody has this" and how old it is.
   A new search is yours to run where the order turns on it; say what you searched and where. A finding whose novelty
   is unchecked is marked so — it may still be formalized, and it will not be announced as new.
5. **A recommendation**: which finding the kernel lane should take first and why, and which two follow. One paragraph.
6. Then the short message to me, and the hand-back in the standing rules' form.

## What is yours to decide

The criterion and the line around "number-field findings"; the order; whether a finding is better offered as one theorem
or as a family; which of the project's own stubs' framings to keep and which read wrongly now. If you think the most
valuable thing to formalize first is not a number-field finding at all, say it and argue it — that is advice Kooshi
would want, and the ranking he asked for still gets written.

Not yours here: a derivation, a Lean statement, a new stub, or the re-rank of the frontier (its draft from the last
milestone is unfiled and waits; this job is not it).

## The machine

This session is on the laptop, away from the remote: **commit by explicit path and do not push** — the server is
unreachable, and a failed push is not an error to fix. Web searches work.
`/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/pn1/`.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).

## Amendment 1 (2026-10-13 16:07 UTC) — a premise of this brief was wrong: measure rigidity at a number field is this project's own hand result, not a printed theorem

The kernel planner working beside you checked my reading against the record and corrected it; I have checked its
correction against the gate's receipt. In § Why this job I wrote that measure rigidity at a number field "enters Lean
as a declared theorem of the literature". It cannot: it is not in the literature.

The gate's own record of the three hypotheses, each of kind "ours":

> ASSUMPTION HadwigerNelson.SpectralChain.Interface.MR form=named kind=ours ref=row:120 consumers=1 :: row 120 (measure rigidity for the unit-vector group, in Fourier form; over [EinsiedlerLindenstrauss2022] Thm 1.3 by statement)
> — source: data/fs124/l2/gate/receipt-assumptions-final.log

> ASSUMPTION HadwigerNelson.SpectralChain.Interface.PE2 form=named kind=ours ref=entry:X02D consumers=6 :: X02D (PE-2, over [EinsiedlerLindenstrauss2022] Thm 1.2; blind X02V)
> — source: data/fs124/l2/gate/receipt-assumptions-final.log

> ASSUMPTION HadwigerNelson.SpectralChain.Interface.EFPlus form=named kind=ours ref=entry:FS100-X01D consumers=6 :: FS100-X01D line 194 (EF_F⁺; second derivation X12B)
> — source: data/fs124/l2/gate/receipt-assumptions-final.log

and the ledger's row on measure rigidity says in its prior-art clause that the statement at a number field was not found
in print. What is printed is a theorem about actions on solenoids (the bibliography's key EinsiedlerLindenstrauss2022,
Thms 1.2 and 1.3); the step from it to the unit-vector group of a number field is two deductions of this project's.

**What changes for your ranking.** A finding that rests on it would not be published as "kernel-checked, given a
theorem of the literature". Unless Kooshi decides to have the project's own deduction formalized — which he has held,
and which is his to decide — its publishable form is: **kernel-checked given one named hypothesis, which is this
project's own rigidity statement, derived by hand from a printed theorem and labelled as that.** Judge each such
finding's interest to the field in that form, and say in its entry which form you judged. If the difference between
the two forms changes a finding's place in the order, give both places: that is exactly what Kooshi needs in order to
decide about the hold.

Nothing else in the brief changes. You start no agents of your own (standing rule 1: delegation is one level deep,
because the coordinator can only review work it knows exists).

## Amendment 2 (2026-10-13 16:12 UTC) — Kooshi has chosen: every finding of ours is formalized, the two deductions under measure rigidity included

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

**What changes for your ranking.** Judge each finding that rests on measure rigidity at a number field in its full
form: kernel-checked given only the printed theorem of Einsiedler and Lindenstrauss, with this project's own
deductions formalized. Amendment 1's request for two places per finding is withdrawn — he has decided, so one order is
enough; keep the column that says which findings rest on that chain, because it tells the kernel lane what the first
of them unlocks for the rest. Nothing else changes. You start no agents of your own (standing rule 1: delegation is one
level deep, because the coordinator can only review work it knows exists).
