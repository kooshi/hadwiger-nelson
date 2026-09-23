# Brief — FS-71 batch 5a: the theorem audit of FS-24–FS-28 (the consolidation) and FS-36 (the multiquadratic two-colour theorem)

Hello, and welcome. You are the **implementer of batch 5a of milestone FS-71** in `/home/kooshi/source/lean-dir`, a Lean 4 proof
workspace aimed at the Hadwiger–Nelson problem (how many colours the plane needs so that no two points at distance 1 share one).
`CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` are loaded for you and bind you; **the copies on disk are authoritative** (the
loaded ones are the session's snapshot; the results ledger lives in `LEDGER.md`). I am the product owner; Kooshi owns the
project. This batch is reading and bookkeeping — no solver, no Lean beyond checking that a name exists.

**You are the only agent on this batch and you must not start any agent of your own** — no subagent, fork or workflow
(`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know
exists; a grandchild's summary would end up recorded as a reading. If the batch does not fit your context, stop at a milestone
boundary, commit what you have by path, write the progress line, and tell me what is left — a good report, never a failure.
A copy of this brief: `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/brief-fs71-batch5a.md`.

## What FS-71 is, and why

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic on a finite set, with controls) — and most survive only as a clause inside a ledger row or a
paragraph of a plan. Kooshi's rule (2026-09-22): each milestone files its non-kernel theorems in `plans/<milestone>-derivation.md`
and indexes them one line each in `LEDGER.md` § B, because *"the derivations are an order of magnitude more important than
individual objects"* and a theorem nobody can find is not held. FS-71 backfills that for M17–FS-66. **Read first, in this
order:** `plans/FS71-theorem-audit.md` in full (§G the seed inventory, §PA the prior-art procedure, §S the exact shape, §M the
modeling decisions, §R what batch 1 found); `plans/FS70-derivation.md` (the template); **the derivation files batch 1 wrote**
(`ls plans/M[12]*-derivation.md`) and `data/fs71/batch-1.md` — copy their shape exactly; `LEDGER.md` rows 59–61, 63 and § B.

## What batches 1–2b taught (read `data/fs71/batch-2a.md` and `batch-2b.md` § "Where the brief was wrong")

- The plans' **`§0a` ("a-priori derivation") and `§R` sections are the primary sources**; a derivation can sit ten or more
  lines below its own heading, so when a grep hits inside a section, read that whole section, not a ±40-line window. **But do
  not read whole files by default**: batch 2a spent 493k tokens on 330 KB; this batch is 370 KB and your budget is ~350k.
- Hand sketches often became kernel theorems a milestone later — when a candidate looks hand-grade, `rg` the Lean modules for
  it before filing; "kernel already (`decl`, module)" is a classification, not a miss.
- A statement's *scope* is part of the statement (batch 1's M18-T1 said "odd cycles" where the argument proves "regular
  polygons"). Write the quantifier you can defend.
- **`unsure` is the right verdict when the chain is not written down** — batch 2a's M37-T1 was marked *unsure* because only a
  one-line conclusion existed; the owner's re-derivation found the chain does not close and demoted it. That is the audit
  working. Do not talk yourself into "closes" from a conclusion sentence.
- A milestone file with no `§R` section and no ledger row is a stub that never ran — one census row, no file (batches 1 and
  2a met six of these).
- Batch 2b found two kernel modules (`SpareColour.lean`, `EntropyFloor.lean`) that no ledger row or grokking named: when a
  plan sketches a lemma, `rg` the module names in `Proofs/HadwigerNelson/` and `ARCHITECTURE.md`'s module table before
  grading it hand — the kernel may already hold it.

- **The checker's entry header must sit on ONE physical line** (`**<id> — <title>. [<grade>]**`) and the grade bracket must
  contain no literal `]` (write a citation as `Parts2020a` without its brackets inside the grade); a field marker
  (`*Proof verdict:*`) must not be split across a wrapped line. Batch 4a lost five entries silently to these; the checker now
  prints `warn: … header starts like an entry but did not parse` — a batch hands back with zero such warnings on its files.

## Your batch

**Milestones FS-24–FS-28 (the consolidation: statements at their proofs' level, vacuity, core inhabitants — ledger row 61) and
FS-36 (the multiquadratic decomposition and the two-colour theorem — row 63), with the 2026-09-11 ChatGPT fold-in behind row
63.** (Batches 5b and 5c, separate readers, take FS-38 and the 2026-09-14 GPT Astra fold-in.) The files, under `plans/` (≈370 KB
— grep, and read the sections hits land in; plan §S.4; your budget is ~350k tokens):

```
 45550 FS25-P2.md                        19842 FS26-vacuity-table.md            10658 FS27-1-core-inhabitants.md
 25566 FS28-vacuity-coverage.md          33910 P3-generalize-geometry.md        22509 P4-generalize-and-plane-freedom.md
 35013 P5-hexshell-brick-generalization.md 26320 P6-generalize-valuation-law.md 103119 FS36-multiquadratic-decomposition.md
  9076 STUB-vacuity-and-record-integrity.md 12981 STUB-vacuity-coverage.md       8622 STUB-consolidation-remainder.md
  4571 STUB-field-level-criteria.md
```

plus `reference/ChatGPT-multiquadratic/` (`handoff.md`, `VERIFICATION.md`, `independent_check.py`, `handoff_check.py` — the
2026-09-11 outside advice behind row 63; credit "ChatGPT (OpenAI, with Kooshi, 2026-09-11)" as row 63 does). Lean modules named in
the rows: `Instances/HexShell.lean`, `BrickDistance.lean` (row 61); `TwoColourResidue.lean`, `SquareClass.lean`,
`Instances/CompositumFive.lean` (row 63); `ValuationLaw.lean`, `PlaneRotation.lean` (rows 59–60, P4/P6's kernel products);
`rg -n "<name>" Proofs/` checks a declaration exists (**never `lake build`**).

**The seed** (plan §G.2, batch 5): **row 61** (FS-24 — kernel throughout: the six-target colour-generic and distance-set-generic,
`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`, the brick certificate over `distanceGraph`; the P3–P6 generalisation phases —
which statements were generalised, and whether any hand step was needed to say *why* the generalisation holds — e.g. P4's
plane freedom over any field where −1 is not a square, P6's valuation law "the general form needs only a conjugation-stable
ideal kernel": file any hand derivation the phases record beyond what the kernel states); **FS-25–FS-28** are method (the
vacuity gate, its law, its counts) — expected to hold no theorem, but the vacuity *law* ("a statement is vacuous exactly when
some ∀-binder has an empty domain … a declaration concluding False is a refutation") is a stated principle: classify it as
method, not a theorem; **row 63 [hand]** (FS-36): **the multiquadratic two-colour iff** — for real multiquadratic F, χ(F²) = 2 iff no
odd square class is ≡ 3 (mod 4) (hand; the mechanism kernel, `colorable_two_unitDistance_induce_of_valuationSubring`, "its
plane and valuation forms have no instance over a real field yet") — file it; **the row itself says the iff is unchecked against
`[AxenovichEtAl2014]` and `[Johnson2006]`** — run that check: both are in `BIBLIOGRAPHY.md` (read status?); if held, read the
relevant statements; if not, the verdict is *check owed* and a § R request; **the square-class decomposition** (a square-class
group holding [2] is the sum of two pieces whose 2-adic images avoid [−1], so every real multiquadratic field lies, once √2 is
adjoined, in the compositum of two fields passing the four-colour test — `fieldOfRadicands_le_sup`, kernel; the decomposition
is ChatGPT's — credit it, and file the hand statement with its verification `independent_check.py`); "**granted the factors'
hand χ ≤ 4**, no combining rule for test-passing fields gives four" — a *conditional*: file the kernel instance
(`five_le_chromaticNumber_planeOver_fourteen_sup_seventy`) as kernel and the conditional reading as a reading with its named
hypothesis (FS-37); "χ(F²) = 2 iff L(F) = 2 for every real number field" — GPT Astra's (batch 5c files it; point forward). Also
`P6-generalize-valuation-law.md` may carry the derivation of the valuation law's general form (row 59: "needs only a
conjugation-stable ideal kernel, `map_mul_conj_eq_zero_iff`") — kernel; classify. Expected density: **medium** — one real
hand theorem (the iff) with an owed prior-art check, and the rest kernel or method.

## What you produce

1. **`plans/<milestone>-derivation.md`** for every milestone of the batch that proved at least one theorem outside the kernel —
   the shape of `plans/FS70-derivation.md` and of batch 1's files, six sections, and this entry skeleton verbatim (the checker
   reads the five italic labels):

   ```
   **M<nn>-T<n> — <title>. [<hand | derived (rows …) | tools | cert>; <who proved it>]** <the statement, quantifiers explicit,
   hypotheses named; a [tools] statement quantifies over exactly the set checked>. *Proof:* <file §section — a proof, not an
   assertion; or "not on disk — looked in …">. *Proof verdict:* <closes | gap: <the step> | unsure — owner to re-derive>.
   *Rests on it:* <rows, grokkings, stubs, later ids>. *Prior art:* <ours | prior art `[key]` §n | partly: … | check owed:
   `[key]`> — nearest held `[key]`; zbMATH: `<query 1>` (<hits>), `<query 2>` (<hits>). *Kernel:* <kernel (`decl`, module) |
   stub (<which>) | declined — <reason> | priced — <cost>>.
   ```

   Ids `FS24-T1`, `FS36-T1`, … (files `plans/FS24-derivation.md`, `plans/FS36-derivation.md`, always that name for that prefix); the ChatGPT fold-in's own theorems, if any beyond FS-36's, are `CHATGPT-2026-09-11-Tn` (`plans/CHATGPT-2026-09-11-derivation.md`) — plan §M.2's prefix rule. A milestone with no theorem gets **no
   file** — a row in your census table saying what it holds instead.
2. **`LEDGER.md` § B**: one line per theorem, in milestone order, after the previous batch's lines and above the FS-70 lines; the theorem
   column is a *statement* under ~250 characters; the kernel column carries its reason in a word. § B lists only entries whose
   proof verdict is *closes* or *unsure* (grade column `hand — unsure`); a *gap* is a conjecture in the file's section 4, never a
   § B line. Leave the placeholder row (`FS38-D2-A/B, …`) alone.
3. **`data/fs71/batch-5a.md`** — the batch report, plan §S.3: the census table with **one row per milestone FS-24 (with P3–P6), FS-25, FS-26, FS-27, FS-28, FS-36, and one for the 2026-09-11 ChatGPT fold-in, the empty
   ones included**; the progress/resume line; the heading **"Theorems this phase proved"** (expected empty — say so); proposed
   edits to `CLAUDE.md` (exact current sentence → proposed sentence, with the reason — you do not edit `CLAUDE.md` or
   `plans/FRONTIER-STUBS.md`; I do); where the brief was wrong; the enumeration (files read in full; files grepped, with the
   patterns; files skipped and why).
4. Bibliography rows touched (a new paper → an entry marked *listing only*; a theorem found to be prior art → the held paper's
   row gains "what of ours rests on it"), `tools/bib_audit.py` green. Stub lines for *stub* kernel decisions go into the stub
   file they belong to under a heading "Kernel targets from FS-71", or a new `plans/STUB-*.md` if none fits.

## How to work each theorem (plan §PA.1 and §M — the parts that matter most)

- **Kind before grade.** Is it a theorem at all? A *measurement* (a general claim checked on a sample), a *reading*, an *instance
  of a held theorem* (name it), a *method rule*, or *kernel already* (the row's) — each goes to the file's section 3 (or the
  census table), never to § B. A `[tools]` theorem's statement quantifies over exactly what was checked; the general claim is a
  separate reading.
- **The proof address points at a proof, never at an assertion.** If the only places the theorem appears state it, write *not on
  disk — looked in …* and *proof verdict: unsure*; do not repair or invent a proof — every derivation is mine, and *unsure* is
  the right word for "I could not find or follow it". Re-read the proof you do find against its objects (G21): a hypothesis
  narrower than the statement, or a proof only for the instance at hand (G30 #6), goes in the entry.
- **Prior art, in the discipline's words** (G46, G49): restate the theorem as a graph theorist, a number theorist or a geometer
  would — *Cayley graph*, *unit-distance graph*, *fractional chromatic number*, *lattice coset colouring* — never in this
  project's coined words (`BIBLIOGRAPHY.md` § E is the translation table). The held bibliography first (§ A and § B — name the
  nearest held paper whether or not it has the theorem; an unread section is a *check owed*, not a zero). Then zbMATH Open, two
  queries in two disciplines' vocabulary, recorded verbatim with hit counts:
  `curl -sG 'https://api.zbmath.org/v1/document/_search' --data-urlencode 'search_string=ab:"unit distance" & ab:"coloring"' --data-urlencode 'results_per_page=50'`
  (`ab:`, `ti:`, `au:"Last, First"`, `py:1985-2000`, `cc:05C15`, joined by `&`/`|`; `result` empty and `status.nr_total_results`
  null on no match; a hit's review text is in the JSON and `editorial_contributions` says review or author's summary — record
  which).
- **Kernel decision**: *kernel* (declaration and module, checked with `rg`), *stub* (which; add the line), *declined* with the
  reason, or *priced*. "Rests on it" decides between declined and stub.
- **Read the final statement aloud** against the sentence in the row or grokking it came from; a mismatch is a finding.

## Gates and commits

After each milestone filed: `python3 tools/fs71_ledger_b_check.py` (zero warnings on your own `M<nn>` prefixes; the FS-70
warnings and the placeholder are known), `python3 tools/claude_md_fact_audit.py --base <the commit you started from>`,
`python3 tools/check_architecture.py`, and `python3 tools/bib_audit.py` if you touched the bibliography. **Commit after each
milestone, by explicit path**, never `git add -A`, never push, never amend; trailer `Co-Authored-By: Claude Sonnet 5
<noreply@anthropic.com>`. Before staging `LEDGER.md` or `BIBLIOGRAPHY.md`, `git diff -- <path>` and confirm every hunk is yours.

## Acceptance (plan §S.5)

Every grade-tagged clause of rows 61 and 63 accounted for, and the `[AxenovichEtAl2014]`/`[Johnson2006]` check run or filed as owed · every file above in your enumeration · every entry with all seven fields,
five sampled by me against their sources · every *prior art* and *gap* verdict checked by me · one theorem re-derived by me ·
gates green · commits by path. Budget ~300k tokens; at the limit, stop at a milestone boundary and write the progress line.
Hand back with the headline: *FS-24–FS-28 + FS-36: N theorems filed in K files, P re-attributed, Q demoted; enumeration complete / stopped
at M<nn>.* In your final report, say what (if anything) you delegated — the answer should be nothing.

You are closer to these files than I am now; if the seed is wrong about something, or the shape fights the material, say so in
"where the brief was wrong" and do what the material needs. Thank you.
