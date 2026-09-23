# Brief — FS-71 batch 5c: the theorem audit of the 2026-09-14 advisor fold-in (GPT Astra's theorems: the chain, prime inversion, the two- and three-colour classifications)

Hello, and welcome. You are the **implementer of batch 5c of milestone FS-71** in `/home/kooshi/source/lean-dir`, a Lean 4 proof
workspace aimed at the Hadwiger–Nelson problem (how many colours the plane needs so that no two points at distance 1 share one).
`CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` are loaded for you and bind you; **the copies on disk are authoritative** (the
loaded ones are the session's snapshot; the results ledger lives in `LEDGER.md`). I am the product owner; Kooshi owns the
project. This batch is reading and bookkeeping — no solver, no Lean beyond checking that a name exists.

**You are the only agent on this batch and you must not start any agent of your own** — no subagent, fork or workflow
(`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know
exists; a grandchild's summary would end up recorded as a reading. If the batch does not fit your context, stop at a milestone
boundary, commit what you have by path, write the progress line, and tell me what is left — a good report, never a failure.
A copy of this brief: `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/brief-fs71-batch5c.md`.

## What FS-71 is, and why

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic on a finite set, with controls) — and most survive only as a clause inside a ledger row or a
paragraph of a plan. Kooshi's rule (2026-09-22): each milestone files its non-kernel theorems in `plans/<milestone>-derivation.md`
and indexes them one line each in `LEDGER.md` § B, because *"the derivations are an order of magnitude more important than
individual objects"* and a theorem nobody can find is not held. FS-71 backfills that for M17–FS-66. **Read first, in this
order:** `plans/FS71-theorem-audit.md` in full (§G the seed inventory, §PA the prior-art procedure, §S the exact shape, §M the
modeling decisions, §R what batch 1 found); `plans/FS70-derivation.md` (the template); **the derivation files batch 1 wrote**
(`ls plans/M[12]*-derivation.md`) and `data/fs71/batch-1.md` — copy their shape exactly; `LEDGER.md` rows 47, 57, 63 (for the pointers to G55) and § B.

## What batches 1–2b taught (read `data/fs71/batch-2a.md` and `batch-2b.md` § "Where the brief was wrong")

- The plans' **`§0a` ("a-priori derivation") and `§R` sections are the primary sources**; a derivation can sit ten or more
  lines below its own heading, so when a grep hits inside a section, read that whole section, not a ±40-line window. **But do
  not read whole files by default**: batch 2a spent 493k tokens on 330 KB; this batch is 150 KB and your budget is ~350k.
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

**The 2026-09-14 advisor fold-in — GPT Astra's theorems (`CLAUDE.md` G55; item 10 of "Where the problem stands"), read here
and found sound, credited by the rule "anything the advisor proved that we had not is credited GPT Astra" (Kooshi).** (Batches
5a and 5b take FS-24–FS-36 and FS-38.) This event is not a milestone and has no ledger row of its own — its theorems live in
`CLAUDE.md` G55, in the stubs FS-45–FS-48 that hold them as kernel targets, and in the verification record. The files (≈150 KB —
read `local-global-further-results.md` and `VERIFICATION.md` in full; your budget is ~350k tokens):

```
reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md   (19 KB — the advisor's text)
reference/ChatGPT-local-global-tightness-conjecture/VERIFICATION.md                  (11 KB — the owner's reading and checks)
reference/ChatGPT-local-global-tightness-conjecture/verify_local_global_extensions.py (7 KB)
reference/ChatGPT-local-global-tightness-conjecture/six-colour-research-directions.md (9 KB)
plans/STUB-chain-theorem.md (16 KB, FS-45)   plans/STUB-unit-vector-ring-kernel.md (12 KB, FS-47)
plans/STUB-three-colour-classification.md (15 KB, FS-46)   plans/STUB-biquadratic-table.md (10 KB, FS-48)
plans/POROS-2026-09-13-wall-breaking.md (32 KB)   plans/SESSION-HANDOFF-2026-09-14.md (8 KB)
```

and `CLAUDE.md` G55 itself (loaded; the disk copy is authoritative). **The seed** (plan §G.2, batch 5; G55): **the chain
theorem** (a finite graph over F forcing two points at difference δ equal at k colours makes every k-colouring of F² periodic
under δR, R = ℤ[U]; if 1/δ is a sum of m unit vectors then χ(F²) > k, witnessed by m chained copies plus one closing edge, at
most m(n−1)+1 vertices, in F itself — the spindle is m = 2); **prime inversion** (1/p ∈ R iff no conjugation-stable prime of F(i)
lies above p, by lying-over — **M56's L7 conjecture; prior art `[Fischer1990b]` Thms 1, 3, 4 for multiquadratic F at odd unramified
p and for every prime of a real quadratic F** — the entry's prior-art field carries exactly that split); **χ(F²) = 2 ⟺ L(F) = 2** for
every real number field (walk parity is a ring homomorphism R → 𝔽₂); **for √3 ∈ F, χ(F²) = 3 ⟺ some prime has residue field 𝔽₃
⟺ L(F) = 3** (every three-colouring is 3R-periodic by the rhombus and descends to Cay(R/3R, H); `[ElZaharSauer1985]` and the
Weil floor leave q = 3); **the consequences given the 8/3 forcer** (every wall-broken real F ⊇ K has χ(F²) ≥ 5, since 3/8 ∈ R;
every multiquadratic F ⊇ K with L ≤ 5 has χ = L; over K(√7) eight copies plus an edge, ≤ 4,697 vertices, need five — conditional
on Harder's/M56's forced pair: file as conditional with the hypothesis named); **the 18-vertex, 33-edge graph over ℚ(√2,√3)** is
four-chromatic with no Moser spindle, and χ(ℚ(√2,√3)²) = 4; **one five-colour virtual edge at distance 2 over any F ⊇ K is a
six-chromatic unit-distance graph** (with `[ExooIsmailescu2019]`'s 426-vertex host — G26); G54's "in an inert tower the ratio
λ_min/d is exactly constant" and "U₃₂'s maximum independent sets are the 𝔽₄-hyperplanes" are ALSO GPT Astra's (2026-09-16,
FS-54's review) — batch 6 files those; note them as forward pointers only. For each: the statement with quantifiers, grade
`[hand; GPT Astra (OpenAI), 2026-09-14; read and verified here — VERIFICATION.md]`, the proof's address in the advisor's text, the
owner's verification (which identities were re-checked in exact arithmetic), the prior-art split, and the kernel decision —
**every one is already a kernel target in FS-45–FS-48** (Kooshi, 2026-09-14): say which stub holds it. `POROS-2026-09-13-wall-breaking.md`
is an earlier advisor record on the wall — read it for any theorem it proves (credit "Poros"). Expected density: **high and
already named** — this batch is credit and indexing, and its prior-art field is the one that matters most (G49 measured that
several of these were `[Fischer1990b]`'s).

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

   Ids `ASTRA-2026-09-14-T1`, … (file `plans/ASTRA-2026-09-14-derivation.md`, always that name for that prefix — plan §M.2's rule for an event that is not a milestone); the POROS record's, if any, `POROS-2026-09-13-Tn` (`plans/POROS-2026-09-13-derivation.md`). A milestone with no theorem gets **no
   file** — a row in your census table saying what it holds instead.
2. **`LEDGER.md` § B**: one line per theorem, in milestone order, after the previous batch's lines and above the FS-70 lines; the theorem
   column is a *statement* under ~250 characters; the kernel column carries its reason in a word. § B lists only entries whose
   proof verdict is *closes* or *unsure* (grade column `hand — unsure`); a *gap* is a conjecture in the file's section 4, never a
   § B line. Leave the placeholder row (`FS38-D2-A/B, …`) alone.
3. **`data/fs71/batch-5c.md`** — the batch report, plan §S.3: the census table with **one row for the fold-in (one line per theorem) and one for the POROS wall-breaking record, the empty
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

Every theorem G55 names accounted for, each with its prior-art split and its FS-45–48 stub named · every file above in your enumeration · every entry with all seven fields,
five sampled by me against their sources · every *prior art* and *gap* verdict checked by me · one theorem re-derived by me ·
gates green · commits by path. Budget ~300k tokens; at the limit, stop at a milestone boundary and write the progress line.
Hand back with the headline: *the 2026-09-14 fold-in: N theorems filed in K files, P re-attributed, Q demoted; enumeration complete / stopped
at M<nn>.* In your final report, say what (if anything) you delegated — the answer should be nothing.

You are closer to these files than I am now; if the seed is wrong about something, or the shape fights the material, say so in
"where the brief was wrong" and do what the material needs. Thank you.
