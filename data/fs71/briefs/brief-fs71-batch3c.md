# Brief — FS-71 batch 3c: the theorem audit of milestones M58–M61 (the field sieve, the lift, the residue obstruction, local–global tightness)

Hello, and welcome. You are the **implementer of batch 3c of milestone FS-71** in `/home/kooshi/source/lean-dir`, a Lean 4 proof
workspace aimed at the Hadwiger–Nelson problem (how many colours the plane needs so that no two points at distance 1 share one).
`CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` are loaded for you and bind you; **the copies on disk are authoritative** (the
loaded ones are the session's snapshot; the results ledger lives in `LEDGER.md`). I am the product owner; Kooshi owns the
project. This batch is reading and bookkeeping — no solver, no Lean beyond checking that a name exists.

**You are the only agent on this batch and you must not start any agent of your own** — no subagent, fork or workflow
(`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and I can only review work I know
exists; a grandchild's summary would end up recorded as a reading. If the batch does not fit your context, stop at a milestone
boundary, commit what you have by path, write the progress line, and tell me what is left — a good report, never a failure.
A copy of this brief: `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/brief-fs71-batch3c.md`.

## What FS-71 is, and why

Every milestone since M17 has proved things outside the Lean kernel — by hand, by derivation from results already held, or at
tools grade (exact arithmetic on a finite set, with controls) — and most survive only as a clause inside a ledger row or a
paragraph of a plan. Kooshi's rule (2026-09-22): each milestone files its non-kernel theorems in `plans/<milestone>-derivation.md`
and indexes them one line each in `LEDGER.md` § B, because *"the derivations are an order of magnitude more important than
individual objects"* and a theorem nobody can find is not held. FS-71 backfills that for M17–FS-66. **Read first, in this
order:** `plans/FS71-theorem-audit.md` in full (§G the seed inventory, §PA the prior-art procedure, §S the exact shape, §M the
modeling decisions, §R what batch 1 found); `plans/FS70-derivation.md` (the template); **the derivation files batch 1 wrote**
(`ls plans/M[12]*-derivation.md`) and `data/fs71/batch-1.md` — copy their shape exactly; `LEDGER.md` rows 52–56, 59, 60 and § B.

## What batches 1–2b taught (read `data/fs71/batch-2a.md` and `batch-2b.md` § "Where the brief was wrong")

- The plans' **`§0a` ("a-priori derivation") and `§R` sections are the primary sources**; a derivation can sit ten or more
  lines below its own heading, so when a grep hits inside a section, read that whole section, not a ±40-line window. **But do
  not read whole files by default**: batch 2a spent 493k tokens on 330 KB; this batch is 310 KB and your budget is ~350k.
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

## Your batch

**Milestones M58–M61 (ledger rows 52–56, 59, 60) and the 2026-09-06 field-plane analysis.** (Batches 3a and 3b, separate
readers, took M53–M57 with the field-wall file, the Mascot derivation and row 57's consolidation.) The files, under `plans/`
(≈310 KB — grep, and read the sections hits land in; plan §S.4; your budget is ~350k tokens):

```
70017 M58-field-sieve.md               74260 M59-finite-plane-lift.md       61407 M60-five-colour-residue-obstruction.md
83709 M61-local-global-tightness.md    15175 POROS-2026-09-10-b-closure-equality.md
```

plus `reference/Chat-analysis/` (`analysis.txt`, `VERIFICATION.md`, `usable.py`, `fplane.py`, `d11_five_colouring.txt` — the
2026-09-06 analysis behind row 52; read `analysis.txt` and `VERIFICATION.md`). Records: `data/fplane/map.md` and `README.md`
(the standing field-plane map). Tools whose docstrings may hold a derivation: `tools/fplane.py`, `fplift.py`, `fpcompel.py`
(spot-check; do not run). Lean modules named in the rows are under `Proofs/HadwigerNelson/` (`UnitQuadrance.lean`,
`Instances/FinitePlane11.lean` row 53; `Lift.lean` row 54; `ResidueObstruction.lean` row 55; `LocalGlobal.lean`,
`PlaneRotation.lean` rows 56, 60; `ValuationLaw.lean` row 59); `rg -n "<name>" Proofs/` checks a declaration exists (**never
`lake build`**).

**The seed** (plan §G.2, batch 3): **row 52 [hand + tools]** (2026-09-06: **the finite-plane bound with the odd-residue-degree
condition** — a field with a prime above p ≡ 3 (mod 4) of ODD residue degree, equivalently residue field 𝔽_q with q ≡ 3 (mod 4),
has χ(F²) ≤ χ(Γ_q); prior art `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]` Thms 17–19, `[Madore2015]` Cor. 3.4 — file the
statement as proved *here* and mark what is theirs; the sealed lists and "de Grey's first usable prime is 131" — computed; "a
larger field can LOSE a prime its subfield had" — a derivation about residue degree: file it); **row 53** (M58: kernel
`unitQuadrance`, `unitQuadrance.map`, `chromaticNumber_finitePlane11`, `chromaticNumber_heule510`; **[derived] Kloosterman
eigenvalues make every plane at p ≡ 3 (mod 4) from 59 up refuse five** (G44 — from `[MMST1998]`'s spectrum plus the ratio
bound: file the derivation with its inputs named; the "from 103, six" companion), "over K, 6-open ⟺ wall broken ∧ 11 inert" —
derived; **`[Vinh2006]` restates the spectral bound without a factor 2, which our kernel value at 19 contradicts** — a finding
against prior art: record it in the entry and in the bibliography row if not already there); **row 54** (M59: kernel
`add_one_le_chromaticNumber_plane_of_lift`, `stressPairing_eq_zero_of_lift`; **G45's derivations** — "a 6-critical subgraph
carries ≥ |V|/2 + 3 stress conditions", "a rigid framework's lift is unique and algebraic", "a field's sealing prime is never its
lifting prime (11 ramifies in ℚ(√11))" — hand or derived? file each; [tools] the hub scan — measured); **row 55** (M60: kernel
`Forces.image`, the distance law, the 5/3 answer — kernel; anything hand in the plan about the √7-free tower); **row 56** (M61:
kernel `addCayleyMap`, `card_le_chromaticNumber_mul_indepNum`, `Forces.isEmpty_ringHom_of_spindle_radicand`; **[tools] ϑ = Hoffman
at eleven primes** — measured, not a theorem (say so); "no rotationally symmetric 5-colouring of Γ₂₃" — solver; **prior art**
`addCayleyMap` is `[Moorhouse2010]` §4.2 and the periodic quotient `[CervantesKrebs2023]` — already attributed; **the mechanism
G48 calls "the tightness mechanism"** — "the forcer deletes exactly the local bound it beats" (the spindle identity
√(4d² − 1) ≡ √−1 (mod 𝔭) when 𝔭 ∣ d²) — is it wholly kernel (`Forces.isEmpty_ringHom_of_spindle_radicand`) or does M61's plan
carry a hand step? file accordingly); **rows 59–60** (2026-09-09: `ValuationLaw.lean`, `PlaneRotation.lean` — kernel; row 60's
"prime fields only; the virtual-edge half is proved only at 11" — scope, not a gap; row 59's "each distance in `[Parts2020a]`
Table 1 is barred from the other column (two rows' √ unverified against the PDF)" — a [tools] check with an owed verification:
record it); **G37's radical list** ("over K the 6-open single radicals are the odd squarefree d ≡ 5, 7 (mod 8) that are
non-residues mod 11: 7, 13, 79, 127, …", and the `3d ≡ 7 (mod 8)` reconciliation with G35's square-class test) if M58 is
where it was derived (batch 3a looks in M53); **G43's "Moorhouse §9's bar on a composite ideal rests on Hedetniemi's
conjecture, refuted by `[Shitov2019]`"** — a reading of prior art, not a theorem (classify). The seed is a floor, not the
census. Expected density: **high** — M58–M61 are the finite-plane machinery's birth.

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

   Ids `M58-T1`, … (file `plans/M58-derivation.md`, always that name for that prefix); row 52's 2026-09-06 analysis is `R52-Tn` (`plans/R52-derivation.md`) and rows 59–60's consolidation `R59-Tn`/`R60-Tn` if anything outside the kernel is there — plan §M.2's prefix rule for events that are not milestones. A milestone with no theorem gets **no
   file** — a row in your census table saying what it holds instead.
2. **`LEDGER.md` § B**: one line per theorem, in milestone order, after batch 3b's lines and above the FS-70 lines; the theorem
   column is a *statement* under ~250 characters; the kernel column carries its reason in a word. § B lists only entries whose
   proof verdict is *closes* or *unsure* (grade column `hand — unsure`); a *gap* is a conjecture in the file's section 4, never a
   § B line. Leave the placeholder row (`FS38-D2-A/B, …`) alone.
3. **`data/fs71/batch-3c.md`** — the batch report, plan §S.3: the census table with **one row per milestone M58–M61, plus one for the 2026-09-06 analysis (row 52) and one for the 2026-09-09 consolidation (rows 59–60), the empty
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

Every grade-tagged clause of rows 52–56, 59, 60 accounted for · every file above in your enumeration · every entry with all seven fields,
five sampled by me against their sources · every *prior art* and *gap* verdict checked by me · one theorem re-derived by me ·
gates green · commits by path. Budget ~300k tokens; at the limit, stop at a milestone boundary and write the progress line.
Hand back with the headline: *M58–M61 + row 52: N theorems filed in K files, P re-attributed, Q demoted; enumeration complete / stopped
at M<nn>.* In your final report, say what (if anything) you delegated — the answer should be nothing.

You are closer to these files than I am now; if the seed is wrong about something, or the shape fights the material, say so in
"where the brief was wrong" and do what the material needs. Thank you.
