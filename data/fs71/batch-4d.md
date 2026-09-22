# FS-71 batch 4d — the theorem audit of M63 phases H3 and H4 (dropping the shape; family-keeping, the free
census, the sweep, reducing the platform)

*Filed 2026-09-23 by the batch-4d implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in
full, `plans/FS70-derivation.md` (the template), `ls plans/*-derivation.md`, `plans/M63H2-derivation.md` (the
neighbour phase, batch 4c's), `data/fs71/batch-4c.md`, `LEDGER.md` row 65 (and 64 for orientation) and § B.*

## Headline

**M63 phases H3–H4: 13 theorems filed in 2 files (`plans/M63H3-derivation.md`, 9 theorems;
`plans/M63H4-derivation.md`, 4 theorems), 0 re-attributed wholesale to prior art (three are prior art with a
recognition or application ours — `M63H3-T7`'s coincidence-rotation identity, `M63H4-T3`'s D-reducibility
recognition — filed per WORKFLOW's M.2, "it was proved here, and the honest record is that it was known"),
0 demoted (gap); one theorem (`M63H3-T8`, G62's periodicity/`Σ7` corollary) filed *unsure* — no written proof
was found on disk, only an assertion in `CLAUDE.md` itself. Enumeration complete for all eleven file groups
the brief assigned.**

Phase H3's own material (`crossedges.md` §12 especially) is the densest, most formally written source this
audit has met — an explicit `Setting → Lemma → Proposition → Theorem` numbering with `∎`-terminated proofs,
written by the cross-edge engineer in the register a Lean formalisation could start from. Phase H4's material
splits between one genuine completion of row 64 (the `≤ 5` half of `χ(ρ₆₃ arena) = 5`, established twice by
independent constructions, neither previously filed) and a rich recognition of `Absorb.lean`'s absorption as
classical four-colour-theorem reducibility (Steinberger 2010, Appel–Haken, Borodin, Erdős–Rubin–Taylor) whose
main theorems are the classical literature's, with the recognition and its unit-distance-graph application
ours.

## The census table

*One row per file group named in the brief, the empty ones included. "Candidates" lists what the file
offered; "classified as" gives kernel / measurement / reading / instance / prior art / conjecture with one
line why, per candidate.*

| file group | files | candidates found | filed as | classified as |
|---|---|---|---|---|
| **`M63-phaseH3-drop-the-shape.md`** (the stub, 170 lines, banner "SUPERSEDED … RUN AND CLOSED") | the mission brief, the registered-prediction shape, the trap list (§4), the acceptance criteria (§7) | **none** | not filed — the stub's own banner says the object is dead and points at `plans/M63-phaseH3-plan.md` for the verdict; every "PROVED" item it lists (§3) is the phase-H2 material already filed batch 4c, restated here as background, never re-derived | measurement/process record; its own two flattering-direction errors (a doubling wrongly credited to `n=2`, "7.1×" read as a linear ratio when it is a squared one) are corrections already carried by the banner, not separate findings |
| **`M63-phaseH3-plan.md`** (1,149 lines, the product owner's working record) | every registered prediction P-H3-1…5, P-XE-1…4 and its scoring; the endpoint-bound derivation (§8, duplicate of `module.md` §5b); the monotonicity theorem (§8); the corollary on the circle's position (§8); the two-case classification narrative (§9, duplicate of `crossedges.md` §12.5); the shape-trade measurement (§8); the propagation audit (§10); the mechanism narrative for the free-circle kill (§13, duplicate of `solver.md` §4a); the close (§16) | **`M63H3-T3`, `M63H3-T4` (both filed from their primary sources, `module.md` and `solver.md`, not repeated here per WORKFLOW's M.2)** | the plan file is the phase's narrative spine — every theorem in it restates and is superseded by a cleaner statement in the dedicated engineering file (`crossedges.md`'s §12 numbered Lemma/Proposition/Theorem block, `module.md`'s §5b, `solver.md`'s §2c/§4a); filed once, at the most complete address, per batch 4c's own precedent (M63H2-T1–T5's plan-file duplicates) |
| **`M63-phaseH3-crossedges.md`** (957 lines, cross-edge engineer) | §12.1–§12.4 (the split lemma, line-structure lemma, closed-form proposition, endpoint-bound corollary — `M63H3-T1`); §12.5 (the two-case theorem — `M63H3-T2`); §12.7 (two out-of-sample landings, evidence for T2, not separately filed); §1c/§1d (the base-free counting law and 2-adic budget criterion, folded into T1's "rests on it"); §7/§8/§9/§11/§14 (the same content in narrative form, superseded by §12's formal statement) | **`M63H3-T1`, `M63H3-T2`** | hand, closes, filed — an explicit `Lemma`/`Proposition`/`Theorem`/`∎` block, the cleanest source in the batch |
| **`M63-phaseH3-module.md`** (616 lines, arithmetic engineer) | §3a–§3e (the `ζ₆`-stability/closure/ring/generation analysis — `M63H3-T5`); §5b (the endpoint-bound-does-not-govern-the-base derivation, the monotonicity theorem, the circle-position corollary — `M63H3-T3`); §5c (the conjugate-condition cost, a measurement, not filed); §5d (the radius-5 conflation correction, process record) | **`M63H3-T5`, `M63H3-T3`** | hand + tools, closes, filed |
| **`M63-phaseH3-solver.md`** (568 lines, solver engineer) | §2a–§2c (the interface reduction and its radius-independence theorem, folded into `M63H3-T4`'s proof address); §3/§3a (the local-freedom product, its one-sidedness, the kill-test framing — `M63H3-T9`); §4/§4a/§4b (the `n=4` control, the free-circle-kill theorem, the additive-pair route screen — `M63H3-T4`); §5 (the produced-or-inherited field argument, an instance of `M63H2-T9`, not separately filed); §6, §9 (discrepancy reconciliations, process record) | **`M63H3-T4`, `M63H3-T9`** | hand/tools, closes, filed |
| **`M63-phaseH3-prior-art.md`** (606 lines, de Bruijn, the prior-art gate) | §PA.0 item 5 (the Hasse-local-norms re-derivation of the `n=2` emptiness — `M63H3-T6`); §PA.4(b) (the `w̄/w = −ρ_n` coincidence-rotation identity — `M63H3-T7`, G62's core); §PA.0 items 1–4, §PA.1–§PA.3 (the negative on coincidence-site-module literature, the "dropping the shape is adjoining `i`" attribution, prior-art bookkeeping — all readings/attributions, not theorems); §PA.4(c),(d) (bibliography corrections to `[PleasantsBaakeRoth1996]`'s row, not theorems) | **`M63H3-T6`, `M63H3-T7`** | hand, closes, filed; the rest is prior-art bookkeeping, correctly not theorems |
| **`POROS-2026-09-12-m63-phaseH3.md`** (1,088 lines, the advisor) | seven retractions, four of them the product owner's own, scored against P-H3-1…5 in `plan.md` §4; the 16,309-point count and 24-monochromatic-edge measurements that `module.md` and `crossedges.md` independently re-derived and confirmed | **none separately filed** | every substantive measurement is credited by name inside `M63H3-T1`, `T3`, `T5`'s entries (via the source files that confirm the advisor's numbers) rather than re-derived here, matching batch 4a/4b/4c's precedent for POROS records; grepped for `theorem\|claim\.\|proof\.\|∎`, every hit either a citation of material filed elsewhere or a scored prediction |
| **`M63-phaseH4-familykeeping.md`** (566 lines) | §R1–R4 (the "family-keeping" enumeration, 96 additive homomorphisms — a computed fact, not filed separately, since it is the basis of `M63H4-T1`); §R6 (the explicit, solver-free 5-colouring — `M63H4-T1`); §15's `γ̄` scaling (measurement, corrected once in the source itself, not filed) | **`M63H4-T1`** | tools, closes, filed — the primary and cleaner of two independent constructions of the same fact |
| **`M63-phaseH4-freecensus.md`** (505 lines, reduction engineer) | §2 (the superset-neutrality theorem — `M63H4-T2`); §10.1–§10.2 (the D-reducibility recognition, the singleton two-line theorem, the Borodin/Erdős–Rubin–Taylor boundary applied — `M63H4-T3`); §10.2(c),(d) (the exact ≤27-vertex non-existence closure — `M63H4-T4`); §10.3 (the C-reducibility/planarity finding, folded into `M63H4-T3`'s prior-art field); §1, §3, §4 (the free-deletion census result and its cost measurements, not theorems) | **`M63H4-T2`, `M63H4-T3`, `M63H4-T4`** | hand + tools, closes, filed — the primary source for phase H4's richest material |
| **`M63-phaseH4-reduce-the-platform.md`** (872 lines, product owner) | §10 (a shorter restatement of `freecensus.md` §10, superseded by that fuller source — not separately filed); §15 (the family-keeping/gauge narrative, restating `familykeeping.md`, plus the `γ̄ ~ n^0.485` measurement — not a theorem in the source, not filed); §16 (a restatement of `sweep.md`'s verdict, not separately filed) | **none separately filed (all restated at their primary sources)** | the phase's own working diary — every dated section restates and is superseded by the dedicated engineering file it points at (`freecensus.md`, `familykeeping.md`, `sweep.md`), per WORKFLOW's M.2 |
| **`M63-phaseH4-sweep.md`** (674 lines) | §2.1 (the critical-vertex screen, already kernel — row 48/G31, not refiled); §4 (a second, independent `χ(arena)=5` witness by repair, cross-referenced inside `M63H4-T1`'s entry as a control, not separately filed); §8/§8.1 (the compulsion sweep's "0 forced pairs, 0 virtual edges" — G31's own extension, a measurement, not a theorem) | **none separately filed (cross-referenced inside `M63H4-T1`, and noted as a G31 measurement)** | tools/measured — the sweep's whole product is a certified-zero measurement, consistent with G31's already-filed grokking status |

## Progress and resume

**Batch 4d is complete: all eleven file groups the brief assigned are filed or classified.** No successor is
needed for this batch. Per `plans/FS71-theorem-audit.md` §S.6's seventeen-reader partition, batch 5a
(FS-24–FS-28, FS-36, the ChatGPT fold-in) is next.

## Theorems this phase proved

**None** — as expected for an audit. This batch's own product is 13 filed theorems that M63 phases H3 and H4
proved and left unindexed (9 under `M63H3-*`, 4 under `M63H4-*`), one caveat added retroactively to an
already-filed batch-4c entry (`M63H2-T2`, below), and one finding against `LEDGER.md` row 64's own address
list (noted, not corrected — outside this batch's writ).

## Proposed edits to `CLAUDE.md`

**One, refining G62's citation to separate what §PA.4 proves from what is the owner's own later synthesis.**

**The exact current sentence:** *"(Derived at M63 phase H3 and left in `plans/M63-phaseH3-prior-art.md`
§PA.4; promoted here 2026-09-17.)"*

**Proposed sentence:** *"(The core identity `w̄/w = −ρ_n` derived at M63 phase H3, `plans/
M63-phaseH3-prior-art.md` §PA.4(b) — filed `M63H3-T7`, `plans/M63H3-derivation.md`. The commensurate ⟹
periodic ⟹ bounded corollary and the `Σ7` instance of `Instances/Seven.lean`'s colouring are not written out
as a derivation anywhere in the phase H3 record — they appear only as this grokking's own prose, promoted
2026-09-17 — and are filed `M63H3-T8`, verdict *unsure*, pending the owner's re-derivation.)"*

**The reason.** FS-71's per-theorem procedure requires a proof address that points at a proof, never at an
assertion (`plans/FS71-theorem-audit.md` §M.3). Reading `plans/M63-phaseH3-prior-art.md` §PA.4 closely: it
proves `w̄/w = −ρ_n` symbolically (item b) and reads three other prior-art findings (a, c, d) about the
literature's coverage of the family, but it contains **no written argument** that a commensurate twist is
periodic and its chromatic number bounded by a finite quotient's, and **no computation** of the `Σ7`
identification of `Instances/Seven.lean`'s colouring — both appear for the first time, as assertions, in
`CLAUDE.md` G62 itself. The commensurate/bounded step is plausible and probably closes in a paragraph (it is
the same shape as row 56's finite-plane bound and G68's fan-gap closure, both kernel, applied to a
coincidence sublattice instead of a residue ideal), and the `Σ7` fact follows directly from
`Instances/Seven.lean`'s own kernel docstring (the `τ = −3+ζ₆`, norm-7 ideal) reread in the crystallography
vocabulary — but "probably closes" is exactly the case FS-71 files as *unsure*, not *closes*, per batch 2a's
own precedent ("`unsure` is the right verdict when the chain is not written down"). This is a precision edit,
not a retraction: nothing in G62's current text is false, and the core identity (the entry's load-bearing
claim, cited throughout the file) is unaffected. Left to Kooshi to apply, per the batch rule that the owner
edits `CLAUDE.md`.

## Where the brief was wrong

- **Mostly right on scope and density, and the seed's item list for row 65 (i)–(vi) matched what the material
  actually contains, item for item** — every one of the six numbered items in the brief's seed (the endpoint
  bound, monotone growth, the circle-position corollary and the free-circle theorem's unmet hypothesis, the
  two-case classification, the conjugate-condition cost, the one-sided kill test) corresponds to exactly one
  filed theorem or measurement here, with no orphans on either side.
- **G62's material was harder to trace than the seed suggested.** The seed's phrasing — *"file both"* for the
  core identity and the commensurate/bounded chain, as if both were in `plans/M63-phaseH3-prior-art.md` §PA.4
  — undercounts the gap: only the core identity is actually derived there. This is not a brief error so much
  as a compression the brief itself flagged as a risk (§G's own note that a re-grokking's output can "measure
  its own reading" if untested), and it is exactly the kind of finding FS-71 exists to surface — filed as
  `M63H3-T8`, verdict *unsure*, and proposed as a `CLAUDE.md` precision edit above.
- **`LEDGER.md` row 64 (M63 phase H2, not this batch's own row) cites `plans/M63-phaseH4-reduce-the-platform.md`
  as one of its addresses but not `plans/M63-phaseH4-familykeeping.md` or `plans/M63-phaseH4-sweep.md`, even
  though its own text — "the upper half an explicit colouring verified proper on all 544,530 edges" — is
  established in those two files, not in phase H2's own record or in `reduce-the-platform.md`.** Two
  independent constructions of `χ(ρ₆₃ arena) ≤ 5` exist (`familykeeping.md` §R6's clean additive homomorphism,
  and `sweep.md` §4's repaired-4-colouring construction), and row 64 currently names neither address. This is
  a finding, not a correction — `LEDGER.md` row prose is outside this batch's writ (the brief scopes my
  `LEDGER.md` edits to § B only) — so it is recorded here for the owner's attention at the next close, per
  the "one home per fact" discipline: `M63H4-T1` is now that fact's home and its own entry names both source
  files.
- **The seed's phrase "H4's 'reduce the platform' and 'family-keeping' derivations, if any" undersold the
  material — there ARE derivations, and the richest one (D-reducibility, `M63H4-T3`/`T4`) sits in
  `freecensus.md`, a file the seed did not name as a candidate for new theorems at all** (its seed entry for
  row 65 names only "the sweep" and "reduce-the-platform" for H4, `plans/FS71-theorem-audit.md` §G.2 batch 4).
  Found by the grep discipline (§S.4) landing inside `plans/M63-phaseH4-reduce-the-platform.md` §10 (a
  three-paragraph restatement that names `freecensus.md` as its own primary record), then reading that whole
  file — the same lesson batches 4a–4c each recorded independently on different files.

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `plans/M63H2-derivation.md`
(read before and after this batch's one edit to it), `data/fs71/batch-4c.md` (for format and precedent),
`LEDGER.md` row 64 and row 65 (for orientation) and § B (read before and after insertion);
`plans/M63-phaseH3-drop-the-shape.md` (171 lines, in full); `plans/M63-phaseH3-plan.md` (1,149 lines, in full,
across four reads); `plans/M63-phaseH3-crossedges.md` (957 lines: §0–§11 read in full for narrative context,
§12.1–§12.7 read in full and closely for the formal theorem block, §13–§14 skimmed for headings, no
theorem-shaped content beyond what §12 already states, confirmed by the grep pattern below); `plans/
M63-phaseH3-module.md` (616 lines, in full); `plans/M63-phaseH3-solver.md` (568 lines: §0–§4b read in full,
§5–§9 read in full for the field argument, discrepancy reconciliations and the close); `plans/
M63-phaseH3-prior-art.md` (606 lines: the header, §PA.0 in full — the four numbered findings including the
`w̄/w=−ρ_n` identity and the Hasse-local-norms re-derivation — §PA.1, §PA.2's verdict section and three
findings, §PA.4 in full including the coincidence-rotation and bibliography-correction material; §PA.5–§PA.10
read for headings and the query log, confirmed process record by the pattern below); `plans/
M63-phaseH4-familykeeping.md` (566 lines, in full); `plans/M63-phaseH4-freecensus.md` (505 lines, in full);
`plans/M63-phaseH4-reduce-the-platform.md` (872 lines, in full).

**Files read by section, after a `grep -n -iE
"theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|
we prove|proof:|proof\.|QED|∎|iff |if and only if|exactly when|for every|for all|conjecture|not claimed"` pass,
every hit's neighbourhood read, every `## §` heading read for the surrounding section:** `plans/
M63-phaseH4-sweep.md` (674 lines; §0–§2 read in full, 1–165; §4, §5 read in full, 204–377; §8, §8.1 read in
full, 584–674; §3, §6, §7, §9–§13 skimmed by heading — cost-model corrections and instrument documentation,
confirmed process record by the grep pattern above returning only citations of material already read).

**Files grepped only, cross-checked against the main phase files, not read in full** (per batch 4a/4b/4c's
precedent for POROS records): `plans/POROS-2026-09-12-m63-phaseH3.md` — `grep -n -iE
"theorem|claim\.|proof\.|∎"` and `grep -n "^### PH3"` for its card headings; every hit either a citation of an
already-known theorem, a scored prediction against `plan.md` §4's table, or a measurement independently
re-derived in `module.md`/`crossedges.md`; cross-checked against `plan.md` §4's explicit scoring table, which
names every retraction and confirms none introduces an unfiled theorem of its own.

**Files skipped, and why:** `plans/M63-phaseH2-*.md`, `plans/M63-phaseH-a-base-for-a-rotation*.md` and their
POROS companions — explicitly out of this batch's scope (batch 4c, already filed and accepted); `plans/
M63-phaseC/D/G-*.md` and `M63-derivation.md` — batches 4b's and orientation-only; `data/m62/*.json`,
`data/m63/*.json` — provenance/record files, not proofs, per every prior batch's repeated finding; no tool
was run, no solver, no `lake build`, no `lake env lean`. Ten zbMATH `curl` calls were run via `curl -sG`
directly (the brief's own recipe, byte-identical), with two additional queries run to confirm hit counts for
theorems the brief's seed did not separately name (`M63H3-T6`, `M63H4-T4`); every query and its hit count is
recorded verbatim inside the entry it supports.

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly, and every gate
(`tools/fs71_ledger_b_check.py`, `tools/fs71_ledger_b_check.py --strict`, `tools/claude_md_fact_audit.py --base
012bb48e`, `tools/claude_md_fact_audit.py --dupes`, `tools/check_architecture.py`, `tools/bib_audit.py`) was
run directly, in that order, before this report was written.
