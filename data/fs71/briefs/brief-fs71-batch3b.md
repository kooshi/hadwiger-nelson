# Brief — FS-71 batch 3b: the theorem audit of milestones M56–M57, the Mascot derivation, and the 2026-09-08 consolidation

Hello, and welcome. You are the **implementer of batch 3b of milestone FS-71** in `/home/kooshi/source/lean-dir`, a Lean 4 proof
workspace aimed at the Hadwiger–Nelson problem (how many colours the plane needs so that no two points at distance 1 share one).
`CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` are loaded for you and bind you; **the copies on disk are authoritative** (the
loaded ones are the session's snapshot; the results ledger lives in `LEDGER.md`). I am the product owner; Kooshi owns the
project. This batch is reading and bookkeeping — no solver, no Lean beyond checking that a name exists.

**You are the only agent on this batch and you must not start any agent of your own** — no subagent, fork or workflow
(`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know
exists; a grandchild's summary would end up recorded as a reading. If the batch does not fit your context, stop at a milestone
boundary, commit what you have by path, write the progress line, and tell me what is left — a good report, never a failure.
A copy of this brief: `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/brief-fs71-batch3b.md`.

## What FS-71 is, and why

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic on a finite set, with controls) — and most survive only as a clause inside a ledger row or a
paragraph of a plan. Kooshi's rule (2026-09-22): each milestone files its non-kernel theorems in `plans/<milestone>-derivation.md`
and indexes them one line each in `LEDGER.md` § B, because *"the derivations are an order of magnitude more important than
individual objects"* and a theorem nobody can find is not held. FS-71 backfills that for M17–FS-66. **Read first, in this
order:** `plans/FS71-theorem-audit.md` in full (§G the seed inventory, §PA the prior-art procedure, §S the exact shape, §M the
modeling decisions, §R what batch 1 found); `plans/FS70-derivation.md` (the template); **the derivation files batch 1 wrote**
(`ls plans/M[12]*-derivation.md`) and `data/fs71/batch-1.md` — copy their shape exactly; `LEDGER.md` rows 50, 51, 57, 58 and § B.

## What batches 1–3a taught (read `data/fs71/batch-3a.md` § "Where the brief was wrong" and its notes for batch 3b)

- The plans' **`§0a` ("a-priori derivation") and `§R` sections are the primary sources**; a derivation can sit ten or more
  lines below its own heading, so when a grep hits inside a section, read that whole section, not a ±40-line window. **But do
  not read whole files by default**: batch 2a spent 493k tokens on 330 KB; this batch is 340 KB and your budget is ~350k.
- Hand sketches often became kernel theorems a milestone later — when a candidate looks hand-grade, `rg` the Lean modules for
  it before filing; "kernel already (`decl`, module)" is a classification, not a miss.
- A statement's *scope* is part of the statement (batch 1's M18-T1 said "odd cycles" where the argument proves "regular
  polygons"). Write the quantifier you can defend.
- **`unsure` is the right verdict when the chain is not written down** — batch 2a's M37-T1 was marked *unsure* because only a
  one-line conclusion existed; the owner's re-derivation found the chain does not close and demoted it. That is the audit
  working. Do not talk yourself into "closes" from a conclusion sentence.
- A milestone file with no `§R` section and no ledger row is a stub that never ran — one census row, no file (batches 1 and
  2a met six of these).
- Batch 3a filed Theorem A and Theorem B's *hand* proofs (2026-09-05, `FIELD-WALL-THEOREM.md`) as M53-T1 and M53-T3 with
  the kernel event named; **do not file them again under a second id** — row 57's non-kernel clauses are what you file (the
  field-level gap, the ℚ⁴ instance). Batch 3a also flagged that a record the plan text does not name may still exist under
  `data/m5x/` — look there before writing *not on disk*.
- Batch 2b found two kernel modules (`SpareColour.lean`, `EntropyFloor.lean`) that no ledger row or grokking named: when a
  plan sketches a lemma, `rg` the module names in `Proofs/HadwigerNelson/` and `ARCHITECTURE.md`'s module table before
  grading it hand — the kernel may already hold it.

## Your batch

**Milestones M56–M57 (ledger rows 50–51), the consolidation of 2026-09-08/09 (rows 57's non-kernel clauses and 58), and the
five-chromatic-objects note.** (Batch 3a, a separate reader, took M53–M55 and `FIELD-WALL-THEOREM.md`; batch 3c takes M58–M61.)
The files, under `plans/` (≈340 KB — grep, and read the sections hits land in; plan §S.4; your budget is ~350k tokens):

```
93778 M56-arithmetic-of-tightness.md   93604 M57-additive-rigidity.md      19225 MASCOT-DERIVATION.md
54827 A1-theorem-A-kernel.md           13377 STUB-theorem-A-kernel.md      40538 COXETER-2026-09-08-mascot.md
 7634 POROS-2026-09-08-mascot.md       15393 Q8-FIVE-CHROMATIC-OBJECTS.md
```

Records: `data/m56/README.md`, `data/m57/README.md`. Tools whose docstrings may hold a derivation: `tools/additive.py`,
`additive_rigid.py`, `quaternion_q4_check.py` (spot-check; do not run). Lean modules named in the rows are under
`Proofs/HadwigerNelson/` (`Additive.lean` row 50, `AdditiveRigid.lean` row 51, `Mascot.lean` row 58, `ResidueColouring.lean`
and `FieldWall4.lean` row 57); `rg -n "<name>" Proofs/` checks a declaration exists (**never `lake build`**).

**The seed** (plan §G.2, batch 3): **row 50** (M56, `Additive.lean` kernel — `additiveColoring`, `not_forces_of_addMonoidHom`,
`addMonoidHom_apply_eq_of_sub_eq_nsmul`; "the additive spindle theorem (its chord lies in 4Λ)" — kernel or hand?; [tools]
Exoo–Ismailescu's G's colouring space is exactly its additive family (measured); **prior art** the framework and the 1/k
obstruction are `[Fischer1990]` Thm 10(ii) and his Example 4 — already attributed in the row); **M56's own arithmetic —
`plans/M56-arithmetic-of-tightness.md` states lemmas L1–L7** on the unit-vector ring Σ₀ and the 2-adic wall: file each with its
status — proved there, or conjectured there (L7, "1/p ∈ Σ₀ iff no conjugation-fixed prime of F(i) lies above p", was a
*conjecture* in M56; G55 records who proved it and when — the home of a theorem is where it was proved (plan §M.2), so M56's file
lists it under *conjectures surfaced* with a forward pointer, not as M56's theorem); and run each lemma's prior-art check
against the held `[Fischer1990b]` (read 2026-09-16; its bibliography row names Thms 1–5) — the plan's §PA.2 owes this check;
G38's linear-method thresholds ("2, 3 or 4 colours and then nothing below 7") if M56 is where they were derived; **row 51** (M57,
`AdditiveRigid.lean` kernel — `AdditivelyRigid`, `forces_of_additivelyRigid`, `six_le_chromaticNumber_plane_of_additivelyRigid`;
**G42's gauge characterisation** "rigidity needs every two-colour Kempe subgraph of every admissible hom connected (gauge
γ = Σ(components − 1))" — kernel, derived or hand?; [tools] only Exoo–Ismailescu's G is rigid and only with its cheats — measured);
**row 57's non-kernel clauses**: "**Not proved:** that a number field with a conjugation-fixed prime supplies the valuation
subring with residue field of size N(𝔭)" — the field-level gap (`A1-theorem-A-kernel.md`, `STUB-theorem-A-kernel.md`): file it as
the named gap, not a theorem; "**A's reach is not limited to the plane** … `χ(ℚ⁴) ≤ 4` by the Hurwitz order [tools, exact; the
mathematics is prior art, `[BendaPerles2000]`]" — an *instance* of Theorem A (kernel) computed at tools grade: classify as instance
with the theorem it instantiates, and record `[Madore2015]` Remark 3.5's scope claim it corrects; **row 58** (`Mascot.lean`
kernel; `plans/MASCOT-DERIVATION.md` — the hand derivation behind the kernel theorem, and the two POROS/COXETER records of that
day: file whatever hand steps the derivation proves beyond what `Mascot.lean` states); **`plans/Q8-FIVE-CHROMATIC-OBJECTS.md`**:
batch 2b filed `M51-T1` — the witness `U ∪ R₂₀₆(U)` (3,695 points, 25,486 unit edges), 5-chromatic at tools grade, in no ledger
row — from M51's session log without opening this file; **reconcile**: read Q8, confirm or correct M51-T1's numbers and its
verification (three encodings? exact geometry at what precision?), and if Q8 holds further objects with their own verifications,
file them as `Q8-Tn` (`plans/Q8-derivation.md`) or fold them into M51-T1's entry — say which and why. The seed is a floor, not the
census. Expected density: **high** (M56 is where the project's number theory began).

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

   Ids `M56-T1`, … (file `plans/M56-derivation.md`, always that name for that prefix); the Mascot derivation's are `MASCOT-Tn` (`plans/MASCOT-derivation.md`); row 57's consolidation items are `R57-Tn` (`plans/R57-derivation.md`) — plan §M.2's prefix rule for events that are not milestones. A milestone with no theorem gets **no
   file** — a row in your census table saying what it holds instead.
2. **`LEDGER.md` § B**: one line per theorem, in milestone order, after batch 3a's lines and above the FS-70 lines; the theorem
   column is a *statement* under ~250 characters; the kernel column carries its reason in a word. § B lists only entries whose
   proof verdict is *closes* or *unsure* (grade column `hand — unsure`); a *gap* is a conjecture in the file's section 4, never a
   § B line. Leave the placeholder row (`FS38-D2-A/B, …`) alone.
3. **`data/fs71/batch-3b.md`** — the batch report, plan §S.3: the census table with **one row per milestone M56, M57, plus one each for `MASCOT-DERIVATION.md`, the row-57 consolidation and `Q8-FIVE-CHROMATIC-OBJECTS.md`, the empty
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

Every grade-tagged clause of rows 50, 51, 57, 58 accounted for, and every lemma L1–L7 of M56 · every file above in your enumeration · every entry with all seven fields,
five sampled by me against their sources · every *prior art* and *gap* verdict checked by me · one theorem re-derived by me ·
gates green · commits by path. Budget ~300k tokens; at the limit, stop at a milestone boundary and write the progress line.
Hand back with the headline: *M56–M57 + Mascot + row 57: N theorems filed in K files, P re-attributed, Q demoted; enumeration complete / stopped
at M<nn>.* In your final report, say what (if anything) you delegated — the answer should be nothing.

You are closer to these files than I am now; if the seed is wrong about something, or the shape fights the material, say so in
"where the brief was wrong" and do what the material needs. Thank you.
