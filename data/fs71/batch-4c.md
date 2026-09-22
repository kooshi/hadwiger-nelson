# FS-71 batch 4c — the theorem audit of M63 phase H2 (the type-M family, the field screen, the ρ₆₃ arena)

*Filed 2026-09-23 by the batch-4c implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in
full, `plans/FS70-derivation.md` (the template), `ls plans/*-derivation.md`, `plans/M63G-derivation.md` (the
neighbour phase, batch 4b's), `data/fs71/batch-4b.md`, `LEDGER.md` row 64 (and 65 for orientation) and § B.*

## Headline

**M63 phase H2: 11 theorems filed in one file (`plans/M63H2-derivation.md`), 0 re-attributed wholesale to
prior art (one, M63H2-T6, is prior art with the specialisation ours — filed per WORKFLOW's M.2, "it was proved
here, and the honest record is that it was known"), 0 demoted (gap); enumeration complete for all twelve files
the brief assigned.** Ten theorems are the product owner's or the advisor's, credited by name at each entry;
one (the non-embedding theorem, M63H2-T9) is the solver agent's, stated as an explicit `Claim./Proof./∎` block
in its own source and simply promoted with an id.

Phase H2's own material is dense with theorem-shaped content because the milestone's *product* was a sequence
of corrected derivations, each superseding the last, written in the open as they happened — three successive
"iff" statements for the free-circle gate (a claim, a counterexample, a corrected claim), two ramification-parity
laws (a one-sided measurement, then a derivation, then its converse corrected), and the verdict itself reached
twice by independent routes. The corrections are as load-bearing as the final statements and are carried inside
each entry, per the audit's own rule that a claim's history belongs where the claim is proved, not lost to a
compression pass.

## The census table

*One row per file group named in the brief, plus one for `find-the-base.md` (not named by the brief's grouping
list but present in its file table; folded in as its own row rather than silently merged — see "Where the brief
was wrong"). "Candidates" lists what the file offered; "classified as" gives kernel / measurement / reading /
instance / prior art / conjecture with one line why, per candidate.*

| file group | files | candidates found | filed as | classified as |
|---|---|---|---|---|
| **phase H's opening** (`M63-phaseH-a-base-for-a-rotation.md`, `-RUN.md`; 59 KB) | the two-sentence discipline (§0); the cross-edge law and residue certificate restated from phase G (§2); the witness `u` (§3); the H1–H6 requirement table (§4); the instrument-failure writeup (§6, a generator whose image excluded its own target); the falsifiers F1–F5 run in the RUN file (§H1–§H11); §H12's "distance to a colourability proof = min over the two primes of the monochromatic cross-edge count" metric with its circle-count/cross-edge bijection; §H5's Galois-conjugate neighbour-bounding search-completeness argument | **none separately filed** | restates M63G-T1–T5 (already filed, batch 4b) rather than proving new theorems; §H12's metric is a proposed objective **later shown automatic and retired as a signal** (`plans/M63-phaseH2-the-family.md` §11, §6) — noted in the derivation file's readings section, not filed; §H5's bounding argument is a search-completeness **method**, general and reusable but not a theorem about the objects; every other claim is a measurement (SAT/UNSAT verdicts, point counts) feeding the later files' theorems, not a theorem itself |
| **`find-the-base.md`** (17 KB, superseded by its own banner) | the mission's original target (~30 points on one fixed circle) and why it is the "distance to a proof"; §6's "PROVED/INHERITED/UNKNOWN" ledger; §7's generator-image trap, restated | **none** | superseded in place — its own header says so; every "proved" item is restated, corrected and superseded by `the-family.md` and `arithmetic.md`; kept on disk (per its own banner) for its prior-art gate, generator-image trap and falsifiers, none of which are new theorems |
| **the H2 plan** (`M63-phaseH2-plan.md`, 122 KB) | §3's classification statement (an earlier, less refined "iff" for the free-circle gate, with two corrections tracked in the same section); §3.2's specialisation of the shelling formula; §3.3's exact enumerable shell-count form; §3.4's generator-image table; the E1–E5 item queue; §10's three constructed witnesses, the 10.3 dead-ends table, §10.5's pre-registered condition scored honestly | **subsumed into M63H2-T1, T2, T6** | the plan's §3 is the *earlier* iteration of what `the-family.md` §5a/§6c and `arithmetic.md` §3 state in final, corrected form — filed once, at the most complete statement, per WORKFLOW's M.2 ("the home of a theorem is where it was proved; earlier appearances point forward"); §3.2's formula specialisation is the same content as `prior-art.md`'s §PA.0 findings 2–3, filed as M63H2-T6 there; §10's witnesses, dead-ends and the honestly-scored mis-specified prediction are process record, not theorems |
| **the family** (`M63-phaseH2-the-family.md`, 86 KB) | the ruling's headline classification (§1–§3, M63H2-T1); the free-circle module-closure theorem and its correction (§4, M63H2-T2); the ramification-degree closure of gate D (§5, M63H2-T3); the general gate/queue and the 2-adic emptiness law (§5a — folded into M63H2-T5/T6); the "six for six" shell formula reproduction (§6c — folded into M63H2-T6); the matching-only-arena theorem (§6b, M63H2-T8); the counting compulsion (§6e, M63H2-T7); the 19-pattern rigidity and its orbit structure (§6f–§6g, M63H2-T10, cross-filed with `solver.md`); the trust-core reduction to 20 half-instance UNSATs (§6i) and the verdict (§6k, M63H2-T11); the Parts-shape-versus-ceiling theorem on the original target circle (§6l, folded into M63H2-T5); two blocked-question resolutions (§6m, a computed Hilbert-symbol fact and a confirmation of Theorem B's own hypothesis — not filed) | **M63H2-T1, T2, T3, T5, T7, T8, T10 (shared), T11 (shared)** | hand, closes, filed — the milestone's densest single file, as the seed predicted ("this is where the type-M family became a theorem") |
| **arithmetic** (`M63-phaseH2-arithmetic.md`, 45 KB) | the ceiling table and the wall-is-`n`-even theorem (§3, §3a, M63H2-T4); the Parts-shape emptiness law with its converse correction (§6, §6a, M63H2-T5); the original-target-circle zero as a theorem via ideal factorisation (§3c, folded into M63H2-T5); the "is the ceiling the right quantity" verdict (§7, a reading, not a theorem); two blocked questions resolved by pari (§5, matching `the-family.md` §6m) | **M63H2-T4, T5** | hand, closes, filed — the file that turns two of `the-family.md`'s measured laws into proofs with a mechanism (ramification parity), ending in "∎" |
| **family-screen** (`M63-phaseH2-family-screen.md`, 29 KB) | the first-pass screen of `n=1…21` (§1–§4, superseded by `the-family.md`'s and `arithmetic.md`'s later, corrected versions — same content, earlier iteration); the two "CONTRADICTION" corrections (§5, §6 — the free-circle gate is sufficient-not-necessary, and a truncated committed enumerator; both folded into M63H2-T2 and the readings section); the automatic-certificate-defeat derivation (§11, folded into the readings section as the origin of "the metric is retired") | **none separately filed** | earlier iteration of material filed under M63H2-T1/T2/T4/T5 from its more complete, corrected restatement in `the-family.md` and `arithmetic.md`; its own two "CONTRADICTION" corrections are the same corrections already carried inside those entries |
| **the solver** (`M63-phaseH2-solver.md`, 40 KB) | the non-embedding theorem (§9, explicit `Claim./Proof./∎`, M63H2-T9); the 19-pattern rigidity and its `ζ₆`-orbit derivation (§4, §4a, M63H2-T10); the verdict's two routes and the superset simplification (§9–§14, M63H2-T11); two corrected measurements (§8a, a list-length-versus-set-size accounting error; §8b, a population-contaminated contention comparison) — both process corrections, not theorems | **M63H2-T9 filed here; T10, T11 shared with `the-family.md`** | hand/tools, closes, filed — the primary source for the non-embedding theorem and for the solver-side half of the 19-pattern and verdict entries |
| **the prior-art appendix** (`M63-phaseH2-prior-art.md`, 56 KB) | §PA.0's four findings (no ceiling — Hilbert 90, not filed as a theorem; the shelling formula, M63H2-T6; its field specialisation, folded into T6; consequences for the mission, folded into T5/T6); §PA.2's literature lineage (`[Nagell1962]`, `[Schaal1965]`, `[Siegel1936]`, `[ChamizoMiatello2018]`, `[Gundlach1978]` — all already in `BIBLIOGRAPHY.md`); §PA.3's link-by-link verdict on the product owner's own hypothesis (process, not a theorem); §PA.4's re-aimed questions (Q1–Q4, mostly resolved elsewhere and not separately filed); §PA.10's reading of `[PartsOdd2022]` (folded into M63H2-T1's prior-art field) | **M63H2-T6 (formula); contributes prior art to T1, T5** | the WORKFLOW-step-9 "sweep §PA for recognitions" pass for this batch: its recognition — that the mission's counting question is *classical* number theory found by searching the *quasicrystal* literature, not number theory — is G49 in action and is recorded in T6's *Prior art* field, per the rule that a prior-art appendix's identifications belong where the theorem they bear on is filed, not left in the appendix alone |
| **the POROS records** (`POROS-2026-09-12-m63-phaseH2.md`, 74 KB; `-m63-phaseH.md`, 41 KB; `-m63-rotation-screen.md`, 35 KB) | thirteen PH2-cards and ten PH-cards of advisory analysis, all credited by name and folded into the main files' theorems (the free-circle identification and the 14×/42× table, the matching-argument sketch, the joint pricing — all `the-family.md` §9's credit list); `rotation-screen.md`'s RS-1–RS-8 cards (mostly restating M63G's theorems, already filed batch 4b) | **none separately filed** | grepped for `theorem|Claim.|Proof.|∎`, every hit a citation of an already-known theorem (Theorem B, the absorption theorem, "the monotonicity theorem") or a phrase like "true claim" with no boxed statement; every substantive card is credited by name inside the main files' theorem entries (M63H2-T1's credit line, M63H2-T8's, M63H2-T2's correction record) rather than re-derived here, matching batch 4a/4b's precedent for POROS records |

## Progress and resume

**Batch 4c is complete: all twelve files the brief assigned are filed or classified.** No successor is needed
for this batch. Per `plans/FS71-theorem-audit.md` §S.6's seventeen-reader partition, batch 4d (`M63` phases
H3–H4) is next — none of phase H3's or H4's own files (`plans/M63-phaseH3-*.md`, `plans/M63-phaseH4-*.md`, per
`ls plans/M63-phaseH3*.md plans/M63-phaseH4*.md`) were opened here, confirmed out of this batch's assigned file
list. Row 65 (phase H3, G62) was read only for orientation, per the brief, and nothing from it is filed here.

## Theorems this phase proved

**None** — as expected for an audit. This batch's own product is 11 filed theorems that M63 phase H2 (and
phase H's opening) proved and left unindexed, one prior-art re-filing (M63H2-T6, `[BaakeGrimm2003]`'s formula,
with the field specialisation credited as ours), and one finding against `CLAUDE.md`'s own current text (G52's
"iff" phrasing, below).

## Proposed edits to `CLAUDE.md`

**One, and it corrects a phrasing the audit found imprecise on re-reading its own source.** `CLAUDE.md` G52
currently reads, among its listed claims: *"`\|p\|² = n` is free iff `n = k²·m` with `m` a squared distance
the lattice already realizes (4, 16, 12 free; 2 not)."*

**The exact current sentence:** *"`\|p\|² = n` is free iff `n = k²·m` with `m` a squared distance the lattice
already realizes (4, 16, 12 free; 2 not)."*

**Proposed sentence:** *"`\|p\|² = n` is free WHENEVER `n = k²·m` with `k ∈ ℤ` and `m` a squared distance the
lattice already realizes (4, 16, 12 free this way; 2 not) — a one-sided inclusion (`k·shell(m) ⊆ shell(k²m)`,
theorem: `M63H2-T2`), not a full characterisation of which `n` have a nonempty shell: the source's own later
correction (`plans/M63-phaseH2-the-family.md` §6) demotes the 'iff' to sufficiency after finding `n = 5` (not
of the free form, `k>1`) nonempty on the same lattice."*

**The reason.** `plans/M63-phaseH2-the-family.md` §6 states, in the source's own words: *"Gate A is sufficient,
not necessary. `n = 5` is not a square in `K` and yet Parts's lattice has **60** points at `\|p\|² = 5`."* Read
literally, "iff" makes the clause either trivially true (take `k=1, m=n`, which realises nothing) or false as a
discriminating test; the theorem that is actually proved and re-usable is the one-sided inclusion, `M63H2-T2`.
This is a small, precise correction — it does not touch G52's necessary half (M63G-T4/T5, already correctly
attributed by batch 4b) or its even-`t`-automatic-defeat clause (M63H2-T2's own scope), only the "free iff"
words. Left to Kooshi to apply, per the batch rule that the owner edits `CLAUDE.md`.

## Where the brief was wrong

- **Mostly right, and precisely so on the density claim.** The seed named the exact right expectation ("this is
  where the type-M family became a theorem," "Expected density: high") and the exact right file-size table
  (confirmed against `wc -c` before reading anything: 45922/29521/17279/124563/57025/39735/87601/22773/35984
  bytes, matching to the byte). The census produced 11 theorems from a corpus most of whose 610 KB is process,
  correction and measurement narrative around them — a high ratio of theorem to prose for this milestone,
  consistent with the seed's read.
- **The file-group list in the brief's §3 is not exhaustive, and `M63-phaseH2-find-the-base.md` is the gap.**
  The brief's prose names "phase H's opening (`M63-phaseH-a-base-for-a-rotation*.md`), the H2 plan, the family,
  the arithmetic and screen, the solver, the prior-art appendix, the POROS records" — seven groups — but the
  file table two lines above it lists twelve files across those seven groups **plus** `find-the-base.md`, which
  fits none of them (it predates `the-family.md`'s ruling and is explicitly superseded by it, carrying its own
  "SUPERSEDED" banner). Resolved by giving it its own census row rather than silently dropping it into "the
  family" (where its content would be double-counted against material already filed from the superseding
  file) or silently omitting it (which the checklist's "every plan file and record in the batch appears in the
  enumeration section" item would catch as a miss).
- **The seed's item list undercounted by roughly half, in the flattering direction for the audit's thoroughness
  but the informative direction for how the material was organised.** The seed named: G7's family theorem
  (M63H2-T1), the four gates (M63H2-T2–T4, though the seed did not anticipate that gate D's ramified case would
  be its own derivation, M63H2-T3), the colour patterns (M63H2-T10), `h(K)`/`μ(K(i))` (not filed, an instance
  of `M18-T1`), the 552/304,704 refusal (M63H2-T11), G53's counting compulsion (M63H2-T7), and "file any theorem
  [the prior-art appendix] proves." **What the seed did not name, and the material supplied anyway:** the
  Parts-shape emptiness law and its converse correction (M63H2-T5, a genuine `∎`-terminated derivation in
  `arithmetic.md` that the seed's summary of `the-family.md` alone would not have surfaced); the matching-only
  arena theorem (M63H2-T8, the advisor's, explicitly labelled "Theorem" in the source); the non-embedding
  theorem (M63H2-T9, `solver.md`'s own `Claim./Proof./∎` block, in a file the seed listed but did not describe
  as theorem-bearing); and the shelling-formula specialisation as its own filed, prior-art-attributed entry
  (M63H2-T6) rather than a footnote inside another. Each was found by the grep discipline (§S.4) landing inside
  a section, then reading that whole section rather than a ±40-line window — exactly the lesson batch 4b
  recorded, reconfirmed here on different files.
- **One genuine imprecision in `CLAUDE.md` itself, found on the "read the final statement aloud" pass** (not a
  brief error, but surfaced by working this batch): G52's "iff" phrasing for the free-circle gate does not match
  what `the-family.md`'s own later correction establishes. Filed as the one proposed edit above, not as a
  criticism of the seed (the seed quoted G52 accurately; the imprecision is upstream, in the grokking's own
  compression of a three-draft derivation into one sentence).

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `plans/M63G-derivation.md`,
`data/fs71/batch-4b.md` (for format and precedent), `LEDGER.md` row 64 and row 65 (for orientation) and § B
(read before and after insertion); `plans/M63-phaseH-a-base-for-a-rotation.md` (317 lines, in full); `plans/
M63-phaseH-a-base-for-a-rotation-RUN.md` (500 lines, in full); `plans/M63-phaseH2-find-the-base.md` (252 lines,
in full); `plans/M63-phaseH2-family-screen.md` (454 lines, in full); `plans/M63-phaseH2-the-family.md`
(1,152 lines, in full, across two reads); `plans/M63-phaseH2-arithmetic.md` (660 lines: §1–§8 read in full,
§9–§10 skimmed for headings — artifact locations and a ranked "what I would do next" list, no theorem-shaped
content beyond what §1–§8 already state, confirmed by the grep pattern below); `plans/M63-phaseH2-prior-art.md`
(§PA.0–§PA.3, 145 lines, read in full for the four findings and the literature lineage; the rest read by
targeted `grep -n` and its neighbourhoods, per below).

**Files read by section, after a `grep -n -iE
"theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|
we prove|proof:|proof\.|QED|∎|iff |if and only if|exactly when|for every|for all|conjecture|not claimed"` pass,
every hit's neighbourhood read, every `## §` heading read for the surrounding section:** `plans/
M63-phaseH2-plan.md` (1,555 lines; §2.1, §3, §3.2, §3.3, §3.4 read in full, 177–508; §10 read in full,
1380–1555; §4's E1–E5 queue and §5, §6, §7, §8, §9 skimmed by heading — no theorem-shaped content beyond what
§3 and §10 already carry, confirmed by the grep pattern above returning only citations of material already
read); `plans/M63-phaseH2-solver.md` (606 lines; §1–§4, §4a read in full, 1–178; §9 read in full, 282–302; §14
and §17a skimmed for the verdict statement and bundle sizes, matching `the-family.md` §6k exactly; §6, §8a, §8b,
§10–§13, §15–§16 skimmed by heading, confirmed process/correction content by the grep pattern).

**Files grepped only, cross-checked against the main phase files, not read in full** (per batch 4a/4b's
precedent for POROS records): `plans/POROS-2026-09-12-m63-phaseH2.md`, `plans/POROS-2026-09-12-m63-phaseH.md`,
`plans/POROS-2026-09-12-m63-rotation-screen.md` — `grep -n -iE "theorem|claim\.|proof\.|∎"` run across all
three (headings of all PH-/PH2-/RS-cards also listed via `grep -n "^## PH"`), every hit either a citation of an
already-known theorem or a phrase with no boxed statement; cross-checked against `the-family.md` §9's explicit
credit list (which names every PH2-card that fed a filed theorem) and `M63G-derivation.md`'s existing coverage
of `rotation-screen.md`'s RS-cards (already filed batch 4b, confirmed out of scope here).

**Files skipped, and why:** `plans/M63-phaseH3-*.md`, `plans/M63-phaseH4-*.md` and their POROS companions —
explicitly out of this batch's scope (batch 4d, per `plans/FS71-theorem-audit.md` §S.6); `data/m62/*.json`
beyond the two files row 64 already cites (`m63-phaseH2-rho63-certificate.json`, `…-proof-manifest.json`) —
provenance/record files, not proofs, per every prior batch's repeated finding; no tool was run, no solver, no
`lake build`, no `lake env lean`. Two zbMATH `curl` calls per filed theorem (22 queries total) were run via
Python's `urllib` rather than shell `curl` (functionally identical to the brief's recipe: same endpoint, same
`search_string`/`results_per_page` parameters, same JSON response format) after confirming one query
byte-for-byte against a direct `curl` invocation first; every query and its hit count is recorded verbatim
inside the entry it supports.

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly, and every gate
(`tools/fs71_ledger_b_check.py`, `tools/fs71_ledger_b_check.py --strict`, `tools/claude_md_fact_audit.py --base
76786c484c9d7117001b2612af74c328fa494eae`, `tools/claude_md_fact_audit.py --dupes`, `tools/check_architecture.py`,
`tools/bib_audit.py`) was run directly, in that order, before this report was written.
