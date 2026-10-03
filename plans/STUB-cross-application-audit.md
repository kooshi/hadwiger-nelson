# FS-129 — the cross-application audit: where does each novel result this project holds apply to the others? (stub)

*Filed 2026-10-03 17:56 UTC by Keryx, the coordinator, at Kooshi's word, as a **special case**: it is not ranked among the stubs. It runs after the joint filing of
FS-116's and FS-121's closes and after the workflow refinement that follows them, in that order. Its question section, bearings and bearing on the
answer are Poros's to write at its opening, its plan Ephodos's; this file holds the request verbatim and the context a fresh mind needs to plan it.*

## The request (Kooshi, 2026-10-03 17:56 UTC, verbatim)

> Right after this close, we'll be refining the workflow again... then I think it might be worth an audit of all previously novel lemmas and theorems in this project, to see where they can be applied across all others, interweaving and strengthening what we have, and potentially finding new paths. File that as a special case stub for after the workflow refinements.

## What it asks, in plain language (the coordinator's reading; Poros's card replaces it)

Every result this project derived was derived for the milestone that needed it, and filed there. The audit asks the reverse question of each
one: **where else does it bear?** For every novel lemma and theorem, find the other results whose hypotheses it meets, whose steps it shortens, or
whose open steps it closes; then do three things with what is found:
- **interweave**: derive the compositions the record holds the pieces of but never wrote down;
- **strengthen**: weaken hypotheses, promote grades where a second route already exists, merge statements that are one statement;
- **find new paths**: a composition that bears on the answer becomes a stub, ranked as any other.

## What it audits (counts as of 2026-10-03 17:56 UTC; re-count at the opening)

- **`LEDGER.md`**: rows 1–141 (FS-116's and FS-121's rows join at their filing), and § B, one line per theorem proved outside the kernel (1,203
  before the two closes, 1,289 with their drafts).
- **The derivation files**, `plans/*-derivation.md` (99 files), each theorem an entry with its statement, its *not claimed* line, its grade and minds,
  and, since 2026-09-28, a "Rests on it:" paragraph — the one place the record already says what each result feeds.
- **The grokkings**, `.claude/skills/grokkings/SKILL.md` (G1–G90, and FS-116's from G91), with `plans/GROKKING-INSTANCES.md` and
  `plans/GROKKINGS-RETIRED.md`: the mechanisms, which are the natural index for "where else".
- **The kernel**: the Lean library and its trust ledger (`CLAUDE.md` § Trust ledger), where a cross-application is a lemma reused across modules.
- **`CLOSED-QUESTIONS.md`**: a result here may answer a question posed elsewhere.

## Why now: the instances that prompted it (FS-116 and FS-121, 2026-10-03)

- **A mechanism held, and not applied where it bore.** FS116-Y4 found the Γ-free four-colour vertex empty at radius 1 + ε by G83's straddle;
  round 3's construction job had stated both flank edges of the double tip and used each only against a far lens vertex, so the class was worked
  for two rounds, and checked by a blind verifier, as though inhabited (`plans/FS116-close-inventory.md` items 122, 124, 127;
  `plans/FS116-Y4-construction.md` § 3.4).
- **An identity with a closed form, asked after by name.** FS116-V6's `|a − b|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)` (V6-HUG,
  `plans/FS116-V6-verification.md` § 2.2), and Kooshi's question the same day, "where else can we use that identity?" (FS-116 item 142).
- **Three open claims that are one question.** FS-121's close found that three of its six open claims reduce to one (FS-126;
  `plans/FS121-Z1-close.md` § 2.5).
- **Two files that disagree.** What FS-112's bends leave on a ring is stated two ways in two records, and the difference decides how far a held
  result reaches (FS-116 item 136).

## Precedents (read before planning)

- **FS-71's census** (`LEDGER.md` row 77; G21): every derivation counted and graded, one entry each; it measured the corpus, it did not cross-apply it.
- **The consolidation run of 2026-09-27** (`plans/CONSOLIDATION-2026-09-27.md`): the last whole-corpus pass.
- **G49**: in-house vocabulary hid prior art; the same vocabulary can hide a result from its own neighbours, one milestone to the next.

## Scale, and what is the opening's to decide

About 1,300 theorems make about 850,000 ordered pairs, so a pairwise reading is not the method; an index is (by mechanism, by object, by
hypothesis shape). The method, the staffing (head-count and model are Kooshi's: a crunch under `plans/PROTOCOL-crunch.md` is one shape), the
stages, the registered expectations and the failure clauses are the opening's. Any derivation it produces meets the same standard as every other:
two minds, the second blind, before it is announced as held.

## Bearing on the answer

*To be written by Poros at the opening.* Provisional (the coordinator's): none by itself; through the compositions it finds, possibly any.

## Deliverables (from the request)

- For each novel lemma and theorem, where else it applies, with addresses.
- The compositions derived (interweaving), each an entry in a derivation file at its grade.
- The strengthenings (weaker hypotheses, grades promoted, merged statements), filed at their grades.
- New stubs for the new paths, ranked by Poros.
