# Brief — FS-71 batch 6c: the theorem audit of FS-58 (the 3-adic barrier, four colours over real quadratic fields) and the FS-62 conversations (G63, G64)

Hello, and welcome. You are the **implementer of batch 6c of milestone FS-71** in `/home/kooshi/source/lean-dir`, a Lean 4 proof
workspace aimed at the Hadwiger–Nelson problem (how many colours the plane needs so that no two points at distance 1 share one).
`CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` are loaded for you and bind you; **the copies on disk are authoritative** (the
loaded ones are the session's snapshot; the results ledger lives in `LEDGER.md`). I am the product owner; Kooshi owns the
project. This batch is reading and bookkeeping — no solver, no Lean beyond checking that a name exists.

**You are the only agent on this batch and you must not start any agent of your own** — no subagent, fork or workflow
(`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know
exists; a grandchild's summary would end up recorded as a reading. If the batch does not fit your context, stop at a milestone
boundary, commit what you have by path, write the progress line, and tell me what is left — a good report, never a failure.
A copy of this brief: `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/brief-fs71-batch6c.md`.

## What FS-71 is, and why

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic on a finite set, with controls) — and most survive only as a clause inside a ledger row or a
paragraph of a plan. Kooshi's rule (2026-09-22): each milestone files its non-kernel theorems in `plans/<milestone>-derivation.md`
and indexes them one line each in `LEDGER.md` § B, because *"the derivations are an order of magnitude more important than
individual objects"* and a theorem nobody can find is not held. FS-71 backfills that for M17–FS-66. **Read first, in this
order:** `plans/FS71-theorem-audit.md` in full (§G the seed inventory, §PA the prior-art procedure, §S the exact shape, §M the
modeling decisions, §R what batch 1 found); `plans/FS70-derivation.md` (the template); **the derivation files batch 1 wrote**
(`ls plans/M[12]*-derivation.md`) and `data/fs71/batch-1.md` — copy their shape exactly; `LEDGER.md` rows 72–73 and § B.

## What batches 1–2b taught (read `data/fs71/batch-2a.md` and `batch-2b.md` § "Where the brief was wrong")

- The plans' **`§0a` ("a-priori derivation") and `§R` sections are the primary sources**; a derivation can sit ten or more
  lines below its own heading, so when a grep hits inside a section, read that whole section, not a ±40-line window. **But do
  not read whole files by default**: batch 2a spent 493k tokens on 330 KB; this batch is 270 KB and your budget is ~350k.
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

**Milestone FS-58 (the 3-adic barrier; real quadratic fields need four colours — rows 72–73), the FS-62 measurements and the
2026-09-17/19 conversations behind G63 and G64 (no milestone; `data/fs62/`), and the stubs those conversations minted.** The
files (≈270 KB; your budget is ~350k tokens):

```
plans/FS58-four-colours.md (68 KB)   plans/FS58-prelude-seven-cycle-gadget.md (14 KB)   data/fs58/*.md (11 files, 58 KB)
plans/STUB-four-colours-167.md (19 KB)   plans/STUB-quadratic-witnesses-kernel.md (4 KB)
data/fs62/*.md (4 files, 46 KB)   plans/STUB-six-is-not-a-value.md (23 KB)   plans/STUB-plane-bridge.md (9 KB)
plans/STUB-moire-coincidence.md (8 KB)   plans/STUB-adelic-window-colouring.md (12 KB)
```

and `CLAUDE.md` G61, G63, G64 (loaded; disk authoritative). Lean: `ThreeAdicBarrier.lean` (row 72), `Instances/SqrtEleven.lean`
(row 73). Tools: `tools/fs58_local.py`, `fs58_witness.py`, `fs58_check_witness.py`, `fq_chi.py` (docstrings only; the `fs58_*`
tools are frozen — never edit or run).

**The seed** (plan §G.2, batch 6; rows 72–73; G61, G63, G64): **row 72**: kernel (the barrier); [tools] "the 3-adic tower
`(O/3^m)²` is Hoffman-tight at three colours and rigid from level 1; its tensor products with the residue planes at 7, 11, 19,
23 are rigid" — **G61(2) says this was leaned on as if proved and FS-67's stub says the general statement is unproved and
false without gap-freedom**: file the tower's tightness as what it is (an exact computation per level, or a derivation — say
which) and the tensor-rigidity as a *measurement* with FS-67 as the open theorem; the seven-cycle prelude
(`FS58-prelude-seven-cycle-gadget.md`: the diamond family, `cos θ = 24/25`, "never right: ≥ 97.18°", the field of the family
`ℚ(√(8(1+cos θ) − n²))`, the Moser spindle as n = 1 — derivations: file them); **row 73**: kernel (ℚ(√11)); the chain at three
colours over ℚ(√11) (a 52-point graph forces `c(0) = c(3u)`, four transported copies chain 0 to 1 by `1/3 = 1 + 1 + v + v̄`) —
derived from G55's chain plus a solver refusal: file as the instance with its two inputs; "every periodic 3-colouring of the
3-integral pools tried is affine, so quotient screens are blind" — measured; the certified fields' witnesses — certified, tools;
**G63 [hand]**: `χ(F(t)²) = χ(F²)` for transcendental t — **`[Fischer1990]` Thm 6** (prior art, attributed; file the valuation
reading as ours: "every unit vector is integral at the place t ↦ 0 because the residue field is formally real"); `ℚ(φ) = ℚ(√5)`
bipartite — derived; **Fischer's Remark 1 has a false step** (a finitely generated E ⊂ ℝ is called "purely transcendental over a
number field") — a finding against prior art, record it; **G64 [derived]**: **S ⟹ W** (no field is exactly six-chromatic ⟹
χ(ℝ²) ∈ {5, 7}, given the bridge FS-39); **the exact form** `χ(ℝ²) ≠ 6 ⟺ every six-chromatic number field has a seven-chromatic
finite real extension` — derived, with **the demotion record** (S ⟺ W was claimed on 2026-09-17 and withdrawn 2026-09-19: file
the withdrawn claim in section 3 with what killed it); the three mechanism theorems (a residue colouring's count is a prime
power; a coset colouring of the triangular lattice by a rotation-stable sublattice has Loeschian count; the square lattice's a
sum of two squares) — derived: file; "6 is the smallest integer that is neither" — arithmetic; the norm reading — NOT a theorem;
`tools/fq_chi.py`'s rebuild (χ = 3, 4, 3, 5, 5 at q = 3, 7, 9, 11, 19; the controls) — measurement. Expected density: **medium-high**.

**Also yours (moved from batch 6a, which found it is not FS-53's): G59's derived clauses of 2026-09-18** — the normalisation
`c = α/q^{3/2}` and the threshold `√q/6` (six needs `c ≈ √q/6`, crossing the observed maximum near `q ≈ 30.5`); "no uniform bound can
close 23" (it needs `c < 0.799` while 19 reaches 0.918); the U₆₄ Fourier-energy bound (a 683-set must carry ≥ 50.2 % of its energy on
the least eigenspace); "the wall is finite" — all derived, their working under `data/fs62/` (the q = 19 records) and in `CLAUDE.md` G59;
file them as `FS62-Tn` with their proofs located or marked *not on disk*.

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

   Ids `FS58-T1`, … (`plans/FS58-derivation.md`); G64's derivations `FS62-Tn` (`plans/FS62-derivation.md`); G63's `FS39-Tn` (`plans/FS39-derivation.md`, its stub being their home) — plan §M.2's rule. A milestone with no theorem gets **no
   file** — a row in your census table saying what it holds instead.
2. **`LEDGER.md` § B**: one line per theorem, in milestone order, after the previous batch's lines and above the FS-70 lines; the theorem
   column is a *statement* under ~250 characters; the kernel column carries its reason in a word. § B lists only entries whose
   proof verdict is *closes* or *unsure* (grade column `hand — unsure`); a *gap* is a conjecture in the file's section 4, never a
   § B line. Leave the placeholder row (`FS38-D2-A/B, …`) alone.
3. **`data/fs71/batch-6c.md`** — the batch report, plan §S.3: the census table with **one row per milestone FS-58, FS-62 (the measurements), and one each for the G63 and G64 conversations, the empty
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

Every grade-tagged clause of rows 72–73 accounted for; G61(2), G63 and G64's claims classified with their demotions recorded · every file above in your enumeration · every entry with all seven fields,
five sampled by me against their sources · every *prior art* and *gap* verdict checked by me · one theorem re-derived by me ·
gates green · commits by path. Budget ~300k tokens; at the limit, stop at a milestone boundary and write the progress line.
Hand back with the headline: *FS-58 + FS-62/G63/G64: N theorems filed in K files, P re-attributed, Q demoted; enumeration complete / stopped
at M<nn>.* In your final report, say what (if anything) you delegated — the answer should be nothing.

You are closer to these files than I am now; if the seed is wrong about something, or the shape fights the material, say so in
"where the brief was wrong" and do what the material needs. Thank you.
