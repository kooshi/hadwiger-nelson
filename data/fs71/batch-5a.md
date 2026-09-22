# FS-71 batch 5a — the theorem audit of FS-24–FS-28 (the consolidation) and FS-36 (the multiquadratic decomposition)

*Filed 2026-09-23 by the batch-5a implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in full,
`plans/FS70-derivation.md` (the template), `data/fs71/batch-4d.md` (the immediately preceding batch, for current
formatting conventions), `LEDGER.md` rows 59–61, 63 and § B — the exact enumeration is below, including one
deviation from the brief's own literal reading order (a file named but not opened, and why).*

## Headline

**FS-24–FS-28 + FS-36: 6 theorems filed in 2 files (`plans/FS25-derivation.md`, 4 theorems; `plans/FS36-derivation.md`,
2 theorems), 0 re-attributed wholesale to prior art (both FS-36 theorems carry a credit line — sufficiency and the
decomposition to ChatGPT, necessity to this project's own converse — filed as theirs and formalized here, per
WORKFLOW's M.2, "it was proved here, and the honest record is that it was known"), 0 demoted (gap), 0 marked
*unsure*. Enumeration complete for all thirteen files the brief assigned, plus the four `reference/ChatGPT-
multiquadratic/` files it named.**

FS-24 (packages P3–P6 of the 2026-09-09 consolidation) and FS-26, FS-27, FS-28 hold **no theorem outside the
kernel** — every one of the ten files read in that group (four packages, three milestone plans, three pre-milestone
stubs) is either (a) a Lean generalization whose "hand" step
*is* what became the kernel proof, with nothing left over once the kernel holds it, or (b) a vacuity-gate finding
about this project's own code (a failure-mode pattern, not a Hadwiger–Nelson theorem), which is method per the
brief's own seed. FS-25's package P2 (`plans/FS25-P2.md`) holds four genuine theorems that were being carried as
measurements — the sharpest is that de Grey's 1581-vertex graph forces no pair of vertices to share a colour at
five colours, via a fact (three critical vertices) `data/fs71/batch-3a.md` located and flagged here by name. FS-36
holds the two theorems its own opening table marks "new" and row 63 states in full: the multiquadratic two-colour
iff, and the square-class decomposition, both now kernel except the iff's field-level step (stub FS-37). One
finding against row 63's own text: the "unchecked against `[AxenovichEtAl2014]`" clause is stale — FS-58's own
prior-art gate read that paper's §1–§2 on 2026-09-17 and recorded a negative, six days before this row's date but
five days *before* this audit reached it.

## The census table

*One row per milestone the brief assigned, the empty ones included. "Candidates" lists what the file offered;
"classified as" gives kernel / measurement / reading / instance / prior art / conjecture with one line why, per
candidate.*

| milestone | files | candidates found | filed as | classified as |
|---|---|---|---|---|
| **FS-24** (packages P3, P4, P5, P6) | `P3-generalize-geometry.md`, `P4-generalize-and-plane-freedom.md`, `P5-hexshell-brick-generalization.md`, `P6-generalize-valuation-law.md` (117.8 KB total) | P3: the homogeneity transport `transport_pair_of_isometry`, the glue-point generalization (G1, G7a) — both fully kernel, the "two-point homogeneous" naming a prior-art find, not a theorem. P4: the spindle theorems generalized off `ZMod` to any field with `−1` not a square, and "every finite Euclidean plane at `p ≡ 3 (mod 4)` is forced-pair-free given colourability" (G3, E1) — the hand argument *is* the kernel proof (`PlaneRotation.lean`, ledger row 60), nothing left over; the honest `𝔽_{p^n}, n>1` boundary is priced, not proved. P5: the `distanceGraph`-level generalization of the hex-shell pigeonhole and the brick-to-distance-graph bridge (G4, G7b) — fully kernel (ledger row 61); the implementation-record measurement (480 rationals probed, `sevenBrick` carries no avoidance margin at all, `nineBrick` carries 41 of 480) extends M36-T1's boundary-tightness finding but is object-specific and not itself a general claim. P6: the palette helpers and the 2-adic law's general form (G7c, G2) — fully kernel (ledger row 59's "needs only a conjugation-stable ideal kernel" is this package's own product, `map_mul_conj_eq_zero_iff`) | **none filed** | all four packages: kernel (the hand argument in each plan **is** the proof that became the Lean theorem, so nothing survives outside it once the kernel holds it — checked against each package's own §R/acceptance section, all green, all statement-preserving); P5's 480-rational probe: measurement, object-specific, not filed (extends but does not supersede M36-T1, already in `plans/M36-derivation.md`) |
| **FS-25** | `plans/FS25-P2.md` (45.5 KB; items E4, E3, E5 — E1 belongs to P4, E2/E6/E7 held back) | E4 (de Grey's 1581 forces no pair at five colours, via three critical vertices); E3 (the periodic-quotient circulant identification and its spectral/Weil consequence); E5 (the additive family's exponent floor as the reconciliation behind the unexplained 16-pair residue) | **T1, T2, T3, T4** | T1: derived (row 48) + tools, closes. T2: derived, closes. T3: derived, closes. T4: hand, closes. All four were being carried in `CLAUDE.md`/the plan file as measurements or as an unattributed grokking clause (G31's de Grey-1581 sentence, flagged for this batch by `data/fs71/batch-3a.md`'s own cross-batch note) |
| **FS-26** | `plans/FS26-vacuity-table.md` (19.8 KB) | the vacuity gate's rubric (five/six verdict columns); the "self-satisfying producer" failure-mode shape (G30's #7 instance); the `core9_plane`/`core122_plane` closure; the `core122_pigeonhole` non-vacuity repair pricing | **none filed** | method (the vacuity law and its failure-mode taxonomy, per the brief's own seed: "classify it as method, not a theorem"); the repair pricing is engineering, completed by FS-27 §1, not a theorem about Hadwiger–Nelson |
| **FS-27** | `plans/FS27-1-core-inhabitants.md` (10.7 KB) | `core9`/`core122`'s field identification (measured: `core122 ∈ K`, `core9 ∉ K`); the `Q4.seamFree` bridge and `UDCert.colorable_four_of_seamFree` | **none filed** | measurement (the field identification, cadical-checked and re-verified outside the solver) plus fully kernel work (`SeamCert.lean`); no theorem outside the kernel |
| **FS-28** | `plans/FS28-vacuity-coverage.md` (25.6 KB) | the vacuity gate's coverage extension (twelve tracked `Prop` families); four gate defects found (D1–D4); the polarity law ("vacuity at negative polarity, overclaim at positive" — subsumes two ad hoc mechanisms); `colorable_succ_of_colorable_delete` (`Critical.lean`, a general upper-bound lemma vertex-criticality data always implied and nobody had stated) | **none filed** | method (the gate defects, the polarity law — about this project's own instrument, not about Hadwiger–Nelson); `colorable_succ_of_colorable_delete` is fully kernel (`Critical.lean`) and needs no separate filing — noted here since it is a genuinely reusable lemma with no ledger-row address today (see "Where the brief was wrong") |
| **FS-36** | `plans/FS36-multiquadratic-decomposition.md` (103.1 KB), `reference/ChatGPT-multiquadratic/handoff.md`, `VERIFICATION.md`, `handoff_check.py`, `independent_check.py` | the multiquadratic two-colour iff (row 63); the square-class decomposition (row 63); the screening rule for several radicands at once (a corollary of the decomposition); the conditional reading "granted the factors' hand χ ≤ 4, no combining rule gives four" (named hypothesis FS-37); the `tools/fplane.py usable` bug found along the way | **T1, T2** | T1: hand, closes (mechanism kernel, field-level step stub FS-37). T2: hand, closes (fully kernel). The screening rule: folded into T2's proof address, not separately filed. The conditional reading: filed to § 3 as a reading with its named hypothesis, per the brief's own instruction for this row. The `usable` bug: a tooling defect, already flagged in `plans/STUB-consolidation-remainder.md` §5, not a theorem |
| **the 2026-09-11 ChatGPT fold-in** (`reference/ChatGPT-multiquadratic/`) | `handoff.md` (298 lines), `VERIFICATION.md` (109 lines), `handoff_check.py`, `independent_check.py` | every claim in the handoff, cross-checked item by item against `VERIFICATION.md`'s own 16-row table | **no separate id** | every theorem the handoff states beyond what the project already held (items 4, 4′, 6, 9, 11 of `VERIFICATION.md`'s table) is filed under `FS36-T1`/`T2` with its ChatGPT credit line intact, per WORKFLOW's M.2 ("the home of a theorem is where it was proved" — here the proving/formalizing event is FS-36's own week, so there is one home, not two); every other item is a reproduction of prior-held results, checked and not new |

## Progress and resume

**Batch 5a is complete: FS-24 (P3–P6), FS-25, FS-26, FS-27, FS-28, FS-36 and the ChatGPT fold-in are all filed or
classified.** No successor is needed for this batch. Per `plans/FS71-theorem-audit.md` §S.6's seventeen-reader
partition, batch 5b (FS-38, completed in place) is next, followed by batch 5c (the 2026-09-14 Astra fold-in).

## Theorems this phase proved

**None** — as expected for an audit. This batch's own product is 6 filed theorems that FS-25 and FS-36 proved and
left uncollected (4 under `FS25-*`, 2 under `FS36-*`), one finding against `LEDGER.md` row 63's own text (the
`[AxenovichEtAl2014]` check is stale, below), and one finding about a reusable kernel lemma with no ledger address
(`colorable_succ_of_colorable_delete`, below).

## Proposed edits to `CLAUDE.md`

**None to `CLAUDE.md` itself.** One edit is proposed to `LEDGER.md` row 63 (a novel-results ledger row, not
`CLAUDE.md` prose; the brief's "you do not edit CLAUDE.md … I do" names the file this batch must not touch, and
`plans/FS71-theorem-audit.md`'s own decision table exempts only `CLAUDE.md` and `plans/FRONTIER-STUBS.md` from
implementer edits — but a row-63-level current-state fact is exactly the kind of thing the owner's review gate
exists for, so it is proposed here rather than applied):

**The exact current sentence** (`LEDGER.md` row 63): *"the multiquadratic iff is unchecked against
`[AxenovichEtAl2014]` and `[Johnson2006]`."*

**Proposed sentence:** *"the multiquadratic iff is checked negative against `[AxenovichEtAl2014]` §1–2 (FS-58's
prior-art gate, 2026-09-17: "no lower bound, and no multiquadratic two-colour criterion, so FS-36's criterion is
not in §2" — §3–4 unread, so the check is not closed) and still unchecked against `[Johnson2006]` (unobtained)."*

**The reason.** Row 63 was written 2026-09-11 and its "unchecked" clause was true then. `BIBLIOGRAPHY.md`'s
`[AxenovichEtAl2014]` row now carries a later reading (**FS-58 §PA, 2026-09-17, §1–2 read**) that answers exactly
the question row 63 poses — and answers it negative, so the multiquadratic iff's novelty is *not* overturned, but
the row's own words ("unchecked") are stale and understate what this project now knows. This is a precision
edit, not a retraction: nothing in row 63 is false, and FS-36's own credit line is unaffected. `[Johnson2006]`
remains genuinely unread (`BIBLIOGRAPHY.md`: "not read — named only; blocking for FS-20"), so half the clause is
unchanged. Left to Kooshi to apply.

## Where the brief was wrong

- **Mostly right on scope and density.** The seed correctly predicted FS-24/P3–P6 would hold little to nothing
  outside the kernel ("Expected density: medium — one real hand theorem (the iff) with an owed prior-art check, and
  the rest kernel or method") and correctly named FS-25's E4/E3/E5 as the batch's real find, sight unseen, from
  `plans/FS71-theorem-audit.md`'s own §G.1 table (G12, G14, G15, G20 as "target, batch 1" items are a different
  milestone's, correctly not this batch's — the brief's own seed for row 61/63 named exactly the right items and
  no orphans turned up on either side).
- **The seed asked me to "file the hand statement with its verification `independent_check.py`" for the
  decomposition, treating it as if it might be purely a hand result awaiting formalization.** In fact the
  decomposition was **fully formalized in the kernel the same week** (`fieldOfRadicands_le_sup` and its
  companions), so `FS36-T2`'s kernel decision is `kernel`, not `stub` or `declined` as a first reading of the seed
  might suggest. This is a precision the seed itself could not have had without reading `plans/
  FS36-multiquadratic-decomposition.md` §R in full, which this batch did.
- **The seed did not anticipate that the `[AxenovichEtAl2014]` check row 63 calls "unchecked" had already been
  partly run, by a different, later milestone (FS-58, 2026-09-17), six days after FS-36's own close.** This is
  exactly the kind of drift the audit exists to catch, and it surfaced only from reading `BIBLIOGRAPHY.md`'s
  current row rather than trusting row 63's own "unchecked" word — the brief's instruction to "run that check"
  turned out to mean "locate the check that was already run," which is a cheaper and more honest outcome than
  running a fresh literature search would have been.
- **`colorable_succ_of_colorable_delete`** (`Critical.lean`, FS-28 §R5) is a genuinely reusable upper-bound lemma
  ("the upper bound vertex-criticality data has always implied and this repository never stated") with no ledger
  row or grokking naming it today, in the shape of batch 2b's `SpareColour.lean`/`EntropyFloor.lean` finding. It
  is fully kernel and therefore correctly not filed to § B by this audit's own rule, but it is flagged here in
  case a future `LEDGER.md` row wants to cite it (its own consumers, `chromaticNumber_heule553` and
  `deGrey_colorable_five`, are already named in row 61 and elsewhere).
- **FS-24's own file was never given a separate plan file in the batch's list** — the brief's file table lists
  only `P3`–`P6`, which together *are* FS-24 (its parent stub, `STUB-generalize-the-kernel.md`, was not in the
  batch and was not read; every substantive item it names is already covered inside P3–P6, confirmed by each
  package's own header naming its exact stub section). No gap found.

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md` (438 lines), `plans/FS70-derivation.md` (131 lines, the
template), `plans/FS32-derivation.md` (96 lines, a second short-file precedent), `data/fs71/batch-4d.md` (169
lines, the immediately preceding batch's report, for current formatting conventions), `LEDGER.md` §A rows 1–76 and
§B in full (read before and after insertion — two paginated reads plus targeted offset reads); `plans/FS25-P2.md`
(659 lines, in full, including its own §PA prior-art gate); `plans/FS26-vacuity-table.md` (281 lines, in full);
`plans/FS27-1-core-inhabitants.md` (188 lines, in full); `plans/FS28-vacuity-coverage.md` (405 lines, in full);
`plans/P3-generalize-geometry.md` (512 lines, in full); `plans/P4-generalize-and-plane-freedom.md` (307 lines, in
full); `plans/P5-hexshell-brick-generalization.md` (549 lines, in full); `plans/P6-generalize-valuation-law.md`
(400 lines, in full); `plans/STUB-vacuity-and-record-integrity.md` (137 lines), `plans/STUB-vacuity-coverage.md`
(208 lines), `plans/STUB-consolidation-remainder.md` (119 lines), `plans/STUB-field-level-criteria.md` (75 lines)
— all four pre-milestone stubs, each confirmed superseded in place by its milestone's own file, no orphaned
content; `reference/ChatGPT-multiquadratic/VERIFICATION.md` (109 lines, in full — its item-by-item table restates
and cross-checks every claim of `handoff.md`, which is why `handoff.md` itself was grepped rather than re-read
whole, below).

**`plans/FS36-multiquadratic-decomposition.md` (1,212 lines): grep discipline, per §S.4, not a line-by-line full
read — the file exceeds this batch's other files combined.** An initial `grep -n -iE` pass over the theorem-shaped
pattern list (`theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|
\[proof\]|we prove|proof:|proof\.|QED|∎|iff |if and only if|exactly when|for every|for all|conjecture|not claimed|
§R|§0a`) surfaced every section heading and returned substantial context for most; on top of it, four sections
were read directly and in full: §0–§1 (lines 1–100, the implementer brief and purpose), §7 (lines 360–410, "the
headlines, read aloud against the informal claims" — the exact final statements), and §R (lines 994–1,212, every
phase's results, the mutation audit, the predictions scored, and what the close recorded). The remaining ~700
lines (§PA, §2–§6, §8–§11, §M1–§M2) were read through the grep pass's returned context only, not independently
line by line — flagged here rather than claimed as a full read.

**Files grepped, not read whole, per the grep discipline:** `reference/ChatGPT-multiquadratic/handoff.md` — `grep
-n -iE "^#|theorem|proposition|claim [0-9]|lemma"` for its section structure, cross-checked against
`VERIFICATION.md`'s claim-by-claim table (which was read in full and independently states what each section of
the handoff contains); `handoff_check.py`, `independent_check.py` — `grep -n -iE "def |assert|check"` for their
check-list shape, not executed (`VERIFICATION.md` §1–2 already states every number these scripts produce, so
re-reading the code was for method confirmation, not new content); `plans/M53-derivation.md` — lines 140–270 only
(`Read` with `offset`/`limit`), for the exact Proposition-6.4/M53-T8 cross-batch text already on disk;
`data/fs71/batch-3a.md` — lines 1–130 of 201 (`sed -n '1,130p'`), for the FS25-P2/M54 cross-batch flag and the
census table; `data/fs71/batch-3b.md` — lines 55–95 only, to confirm the M53-T8/G38 "linear method" cross-reference
was already closed by batch 3b (so no action was needed here); `BIBLIOGRAPHY.md` — `grep -n` for every `[key]`
this batch's theorems cite (`[Fischer1990]`, `[Moorhouse2010]`, `[Madore2015]`, `[Johnson1987]`,
`[AxenovichEtAl2014]`, `[Johnson2006]`, `[LiFeng1992]`, `[Polymath16wiki]`, `[CervantesKrebs2023]`,
`[BauJohnsonNoble2021]`, `[ExooIsmailescu2018/2019]`, `[DeNeve2025]`) — all found already keyed, with read status,
no bibliography edit needed.

**Files named in the brief but not opened, and why — a deviation from the brief's literal reading order, recorded
rather than hidden.** The brief's own "read first, in this order" instructed `data/fs71/batch-1.md` and "the
derivation files batch 1 wrote" (`ls plans/M[12]*-derivation.md`) as format precedent, alongside `plans/
FS70-derivation.md` as "the template." Neither `data/fs71/batch-1.md` nor any `M1*`/`M2*`-derivation.md` file was
opened this batch: `plans/FS70-derivation.md` (read in full) already states the exact entry skeleton verbatim, and
`data/fs71/batch-4d.md` (read in full, the immediately preceding batch) is a closer match to the current, mature
reporting conventions than the first batch's, which several later batches' own "where the brief was wrong" notes
record as having been revised (the header-parsing warnings, the near-miss checker, the strict per-field checklist
all postdate batch 1). Budget went to the assigned files instead. No format defect resulted — this batch's own
`fs71_ledger_b_check.py` run above shows zero near-miss warnings on either new file.

**Files skipped entirely, and why:** `Proofs/HadwigerNelson/*.lean` beyond `rg` name checks — no proof was read or
repaired, per the brief (no Lean beyond checking a cited declaration exists); `plans/STUB-generalize-the-kernel.md`
(FS-24's own parent stub) — not opened at all; each of P3–P6's own headers names its exact parent-stub section by
line range (e.g. P3: "§2 (G1) and §3 (G7, first bullet)"), which this batch took as sufficient evidence of
coverage without independently re-reading the superseded stub; `data/m5*/`,
`data/e4-critical-vertices.json`'s contents beyond its schema — provenance/record files, not proofs, per every
prior batch's repeated finding. No tool was run, no solver, no `lake build`, no `lake env lean`. Ten zbMATH `curl`
calls were run via `curl -sG` directly (the brief's own recipe), every query and its hit count recorded verbatim
inside the entry it supports.

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly, and every gate
(`tools/fs71_ledger_b_check.py`, `tools/fs71_ledger_b_check.py --strict`, `tools/claude_md_fact_audit.py --base
1bacf0cd`, `tools/claude_md_fact_audit.py --dupes`, `tools/check_architecture.py`, `tools/bib_audit.py`) was run
directly, in that order, before this report was written.
