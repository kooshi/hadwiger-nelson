# Brief — FS-71 batch 5b: the theorem audit of FS-38 (the residue tower) — completing its derivation file

Hello, and welcome. You are the **implementer of batch 5b of milestone FS-71** in `/home/kooshi/source/lean-dir`, a Lean 4 proof
workspace aimed at the Hadwiger–Nelson problem (how many colours the plane needs so that no two points at distance 1 share one).
`CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` are loaded for you and bind you; **the copies on disk are authoritative** (the
loaded ones are the session's snapshot; the results ledger lives in `LEDGER.md`). I am the product owner; Kooshi owns the
project. This batch is reading and bookkeeping — no solver, no Lean beyond checking that a name exists.

**You are the only agent on this batch and you must not start any agent of your own** — no subagent, fork or workflow
(`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know
exists; a grandchild's summary would end up recorded as a reading. If the batch does not fit your context, stop at a milestone
boundary, commit what you have by path, write the progress line, and tell me what is left — a good report, never a failure.
A copy of this brief: `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/brief-fs71-batch5b.md`.

## What FS-71 is, and why

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic on a finite set, with controls) — and most survive only as a clause inside a ledger row or a
paragraph of a plan. Kooshi's rule (2026-09-22): each milestone files its non-kernel theorems in `plans/<milestone>-derivation.md`
and indexes them one line each in `LEDGER.md` § B, because *"the derivations are an order of magnitude more important than
individual objects"* and a theorem nobody can find is not held. FS-71 backfills that for M17–FS-66. **Read first, in this
order:** `plans/FS71-theorem-audit.md` in full (§G the seed inventory, §PA the prior-art procedure, §S the exact shape, §M the
modeling decisions, §R what batch 1 found); `plans/FS70-derivation.md` (the template); **the derivation files batch 1 wrote**
(`ls plans/M[12]*-derivation.md`) and `data/fs71/batch-1.md` — copy their shape exactly; `LEDGER.md` rows 66–67 and § B.

## What batches 1–2b taught (read `data/fs71/batch-2a.md` and `batch-2b.md` § "Where the brief was wrong")

- The plans' **`§0a` ("a-priori derivation") and `§R` sections are the primary sources**; a derivation can sit ten or more
  lines below its own heading, so when a grep hits inside a section, read that whole section, not a ±40-line window. **But do
  not read whole files by default**: batch 2a spent 493k tokens on 330 KB; this batch is 390 KB and your budget is ~350k.
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

**Milestone FS-38 (the residue tower — ledger rows 66 and 67) — completing, not rewriting, `plans/FS38-derivation.md`.**
(Batch 5a takes FS-24–FS-36; 5c the 2026-09-14 GPT Astra fold-in.) The files, under `plans/` (≈390 KB — grep, and read the
sections hits land in; plan §S.4; your budget is ~350k tokens):

```
 43120 FS38-derivation.md   (READ IN FULL — the existing derivation narrative you complete)
147823 FS38-residue-tower.md   25262 FS38-tower-records.md
 81883 POROS-2026-09-13-fs38-implementation.md   45878 POROS-2026-09-13-fs38-subplan.md
  7306 STUB-forces-of-tight.md   6182 STUB-tight-quotients.md   9265 STUB-first-digit-83.md
  8417 SESSION-HANDOFF-2026-09-13-fs38.md   11903 SESSION-HANDOFF-2026-09-13.md
```

Records: `data/fs38/README.md` (the 18 records under `data/fs38/` are provenance). Lean modules: `FanGap.lean`,
`Instances/FanGap11.lean`, `Instances/FanGap19.lean` (row 66); `TwoAdicTower.lean`, `Instances/TwoAdicFour.lean`,
`Instances/TwoAdicFive.lean` (row 67); `rg -n "<name>" Proofs/` checks a declaration exists (**never `lake build`**).

**The shape here is different — plan §M.3 and the stub's rule: FS-38 already named its theorems, so its derivation file is
COMPLETED, not rewritten.** `plans/FS38-derivation.md` is a 43 KB narrative (D-1 to D-4; Theorem D2-A, Theorem D2-B, Lemmas
1–3, a "Derived" statement in D-1 and one in D-3, the corollaries). Add **a new top section "The theorems (FS-71 index)"**
immediately after the status line, holding one entry per theorem in the plan §S.1 skeleton, whose *Proof:* field points INTO
the narrative below (`§D-2(c) Lemma 2`), with ids `FS38-D2-A`, `FS38-D2-B`, `FS38-L1`, `FS38-L2`, `FS38-L3`, `FS38-D1`, `FS38-D3`
(the narrative's own names, kept); leave the narrative untouched. **The seed** (plan §G.2, batch 5; rows 66–67): row 66 is
kernel throughout — nothing to file but the hand step it names ("the field-level hand step of M58/M60, row 57's gap" — not
claimed; point at R57's named gap); **row 67 [hand]**: **Theorem D2-A** (a k-tight Cayley graph's k-colourings are balanced,
gap-free and periodic under `H_min` — **balance and gap-freedom are Blokhuis–Brouwer–Haemers 2007 Prop. 2.3, cited through
`[AbiadEtAl2025]`; the periodicity is ours** — the entry's prior-art field must carry that split); **Theorem D2-B** (propagation
for all m ≥ 5: every 4-colouring of `P_m` is pulled back from `P₄`); **Lemma 1** (tightness propagates up), **Lemma 2** (the
primitive-character bound), **Lemma 3** (the arithmetic fact — the lattice certificate with elementary divisors 1, 2, 4, 4; "computed
per level and certified globally"); **the D-1 derived statement** (at level 2 every 4-colouring is periodic under a depth-0 or
depth-1 period); **the D-3 derived statement** (the tower propagation of "no gap at level one"?) — read D-3 for what it
actually proves and file that; "`Cay(O/𝔓^m, S_m)` is [hand], three independent constructions agreeing" — a hand identification:
file it; the classifier's Weil consequence ("no usable prime above 3 in the committed table is tight for any k ≤ 7; p = 31
misses 4-tightness by 4.4·10⁻⁵") — derived: file it; the 3-adic control ("every 3-colouring of `UD(ℤ/9,2)` is 3-periodic, no
solver") — an exact computation; **D-4** ("why 11 is slack: a uniformly gapped 5-colouring?" — "not derived, stalls at …") — a
conjecture/open item, section 4. The POROS records credit "Poros" by name. Also: `FS38-derivation.md`'s own section
"Bibliography entries the close must add" — check each was added (`bib_audit`). Expected density: **high, already named** —
your work is the index and the prior-art split, not discovery.

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

   Ids: the narrative's own names, `FS38-D2-A`, `FS38-D2-B`, `FS38-L1`…`FS38-L3`, `FS38-D1`, `FS38-D3` (the file is `plans/FS38-derivation.md`, completed in place; the checker accepts `**FS38-D2-A — …**` and bare `**D2-A — …**` alike, and the id `D2-A` must appear exactly as in § B). **Remove the placeholder row** `FS38-D2-A/B, FS66-W/E/T, …` from § B when you insert FS-38's lines (batch 6 files FS-66's). A milestone with no theorem gets **no
   file** — a row in your census table saying what it holds instead.
2. **`LEDGER.md` § B**: one line per theorem, in milestone order, after the previous batch's lines and above the FS-70 lines; the theorem
   column is a *statement* under ~250 characters; the kernel column carries its reason in a word. § B lists only entries whose
   proof verdict is *closes* or *unsure* (grade column `hand — unsure`); a *gap* is a conjecture in the file's section 4, never a
   § B line. Leave the placeholder row (`FS38-D2-A/B, …`) alone.
3. **`data/fs71/batch-5b.md`** — the batch report, plan §S.3: the census table with **one row for FS-38 (and one line per theorem indexed), the empty
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

Every named theorem of `FS38-derivation.md` indexed with the seven fields; row 67's [hand] clauses accounted for; D2-A's prior-art split recorded · every file above in your enumeration · every entry with all seven fields,
five sampled by me against their sources · every *prior art* and *gap* verdict checked by me · one theorem re-derived by me ·
gates green · commits by path. Budget ~300k tokens; at the limit, stop at a milestone boundary and write the progress line.
Hand back with the headline: *FS-38: N theorems indexed in K files, P re-attributed, Q demoted; enumeration complete / stopped
at M<nn>.* In your final report, say what (if anything) you delegated — the answer should be nothing.

You are closer to these files than I am now; if the seed is wrong about something, or the shape fights the material, say so in
"where the brief was wrong" and do what the material needs. Thank you.
