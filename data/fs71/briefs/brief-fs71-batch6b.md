# Brief — FS-71 batch 6b: the theorem audit of FS-54 and FS-56 (the 2-adic trichotomy, the fractional wall, the field blow-up)

Hello, and welcome. You are the **implementer of batch 6b of milestone FS-71** in `/home/kooshi/source/lean-dir`, a Lean 4 proof
workspace aimed at the Hadwiger–Nelson problem (how many colours the plane needs so that no two points at distance 1 share one).
`CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` are loaded for you and bind you; **the copies on disk are authoritative** (the
loaded ones are the session's snapshot; the results ledger lives in `LEDGER.md`). I am the product owner; Kooshi owns the
project. This batch is reading and bookkeeping — no solver, no Lean beyond checking that a name exists.

**You are the only agent on this batch and you must not start any agent of your own** — no subagent, fork or workflow
(`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know
exists; a grandchild's summary would end up recorded as a reading. If the batch does not fit your context, stop at a milestone
boundary, commit what you have by path, write the progress line, and tell me what is left — a good report, never a failure.
A copy of this brief: `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/brief-fs71-batch6b.md`.

## What FS-71 is, and why

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic on a finite set, with controls) — and most survive only as a clause inside a ledger row or a
paragraph of a plan. Kooshi's rule (2026-09-22): each milestone files its non-kernel theorems in `plans/<milestone>-derivation.md`
and indexes them one line each in `LEDGER.md` § B, because *"the derivations are an order of magnitude more important than
individual objects"* and a theorem nobody can find is not held. FS-71 backfills that for M17–FS-66. **Read first, in this
order:** `plans/FS71-theorem-audit.md` in full (§G the seed inventory, §PA the prior-art procedure, §S the exact shape, §M the
modeling decisions, §R what batch 1 found); `plans/FS70-derivation.md` (the template); **the derivation files batch 1 wrote**
(`ls plans/M[12]*-derivation.md`) and `data/fs71/batch-1.md` — copy their shape exactly; `LEDGER.md` rows 70–71 and § B.

## What batches 1–2b taught (read `data/fs71/batch-2a.md` and `batch-2b.md` § "Where the brief was wrong")

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
- Batch 2b found two kernel modules (`SpareColour.lean`, `EntropyFloor.lean`) that no ledger row or grokking named: when a
  plan sketches a lemma, `rg` the module names in `Proofs/HadwigerNelson/` and `ARCHITECTURE.md`'s module table before
  grading it hand — the kernel may already hold it.

- **The checker's entry header must sit on ONE physical line** (`**<id> — <title>. [<grade>]**`) and the grade bracket must
  contain no literal `]` (write a citation as `Parts2020a` without its brackets inside the grade); a field marker
  (`*Proof verdict:*`) must not be split across a wrapped line. Batch 4a lost five entries silently to these; the checker now
  prints `warn: … header starts like an entry but did not parse` — a batch hands back with zero such warnings on its files.

## Your batch

**Milestones FS-54 (five refused at 27; the 2-adic trichotomy; the wall made finite and fractional — row 70) and FS-56
(ℚ(√167); the fractional blow-up over fields; χ_f(K²) = 4 — row 71).** The files (≈340 KB — grep; read the soundness and the
verdict sections in full; your budget is ~350k tokens):

```
plans/FS54-twenty-seven.md (54 KB)   plans/FS54-L3-certificate-soundness.md (18 KB — READ IN FULL)   plans/FS54-D4-pricing.md (30 KB)
plans/STUB-twenty-seven.md (15 KB)   data/fs54/*.md (7 files, 45 KB)   plans/SESSION-HANDOFF-2026-09-16-fs54.md (4 KB)
reference/wall-at-six/WALL-AT-SIX.md (58 KB — the text sent to outside advisors)   reference/wall-at-six/responses/ (46 KB — GPT
Astra's and a second reader's responses; credit by name as row 70 does)
plans/FS56-quadratic-167.md (41 KB)   plans/FS56-field-blowup.md (9 KB — READ IN FULL)   plans/STUB-quadratic-167.md (12 KB)
data/fs56/*.md (4 KB)   plans/SESSION-HANDOFF-2026-09-16-fs56.md (4 KB)
```

Tools: `tools/fs54_l3_cert_check.py`, `fs54_wall_feedback_verify.py`, `fs56_gf_check.py` (docstrings only).

**The seed** (plan §G.2, batch 6; rows 70–71; G54, G56, G59, G60): **row 70 [proof]**: **the 2-adic trichotomy** — a prime of F
above 2 split in F(i) bounds nothing; ramified gives χ(F²) ≤ 2 at any norm (conjugation in inertia, every unit vector reduces to
1, a linear map to 𝔽₂); inert gives U_Q — and **every odd-degree real field is 2-colourable** (some prime above 2 has odd local
degree): file each clause; **the odd-degree statement's prior art is `[Moorhouse2010]` §7.1** (the bibliography row says so — the
entry must attribute it, and row 70/G56 currently do not); **[proof, GPT Astra, verified by recomputation]**: `α < Q²/6` at the
six open targets proves the wall and closes CRT products (`[Zhang2012]`, `[Zhu2011]` — prior art for the product facts);
U₃₂'s maximum independent sets are exactly its 44 𝔽₄-hyperplanes; **inert towers keep `λ_min/d`** — `λ_min(G_j) = Q^{j−1}·λ_min(G₁)`
("from `[MMST1998]` Thms 2.1, 2.3, 2.9 for odd primes; new for Galois rings and even Q") — credit GPT Astra (2026-09-16) with the
prior-art split; **[derived]** "if the wall holds, χ(F²) ∈ {2, 3, 4, 5, 7} and χ(ℚ(√167)²) ≥ 6" — derived under the conjecture:
file as conditional; the L3 certificate's soundness (`FS54-L3-certificate-soundness.md`) — hand theorems; "27 explained" (every
edge in exactly one collinear triangle, `(w+1)²` in characteristic 3; λ = 3m − 14; |Aut| = 122,472) — derived/computed: classify;
the five errors the outside readers found in our text (`FS54-twenty-seven.md` §R's verdict table) — record each as a
demotion where a claim of ours was withdrawn; **row 71 [hand]**: **every congruence between subsets of F² is an isometry of F²,
so `[MatolcsiEtAl2025]`'s blow-up never leaves F: χ(F²) ≥ ⌈χ_gf(H)⌉** (`FS56-field-blowup.md`) — file with its proof; **χ_f(K²) = 4**
[hand + cert] with their G27 and Theorem B; the route's cap (min of 4.36 and every usable plane's χ_f) — derived; G60's ratio-bound
shadow — a reading, not filed. Expected density: **high**.

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

   Ids `FS54-T1`, `FS56-T1`, … (files `plans/FS54-derivation.md`, `plans/FS56-derivation.md`); the outside readers' theorems, credited by name, go in FS-54's file with the credit in the grade bracket. A milestone with no theorem gets **no
   file** — a row in your census table saying what it holds instead.
2. **`LEDGER.md` § B**: one line per theorem, in milestone order, after the previous batch's lines and above the FS-70 lines; the theorem
   column is a *statement* under ~250 characters; the kernel column carries its reason in a word. § B lists only entries whose
   proof verdict is *closes* or *unsure* (grade column `hand — unsure`); a *gap* is a conjecture in the file's section 4, never a
   § B line. Leave the placeholder row (`FS38-D2-A/B, …`) alone.
3. **`data/fs71/batch-6b.md`** — the batch report, plan §S.3: the census table with **one row per milestone FS-54, FS-56, and one for the wall-at-six outside review, the empty
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

Every grade-tagged clause of rows 70–71 accounted for; the odd-degree theorem attributed to `[Moorhouse2010]` §7.1 · every file above in your enumeration · every entry with all seven fields,
five sampled by me against their sources · every *prior art* and *gap* verdict checked by me · one theorem re-derived by me ·
gates green · commits by path. Budget ~300k tokens; at the limit, stop at a milestone boundary and write the progress line.
Hand back with the headline: *FS-54 + FS-56: N theorems filed in K files, P re-attributed, Q demoted; enumeration complete / stopped
at M<nn>.* In your final report, say what (if anything) you delegated — the answer should be nothing.

You are closer to these files than I am now; if the seed is wrong about something, or the shape fights the material, say so in
"where the brief was wrong" and do what the material needs. Thank you.
