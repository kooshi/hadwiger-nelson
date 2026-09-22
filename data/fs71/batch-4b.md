# FS-71 batch 4b — the theorem audit of M63 phases C–G and its three opening documents

*Filed 2026-09-23 by the batch-4b implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in
full, `plans/FS70-derivation.md` (the template), `ls plans/*-derivation.md`, `data/fs71/batch-4a.md`,
`data/fs71/batch-2a.md`/`batch-2b.md` §"Where the brief was wrong", `LEDGER.md` rows 62/64/65 (for
orientation) and § B.*

## Headline

**M63 phases C–G: 18 theorems filed in 4 files (M63, M63C, M63D, M63G), 0 re-attributed wholesale to prior
art, 0 demoted (gap); enumeration complete for every file the brief assigned.** Three theorems from the
opening documents (`plans/M63-derivation.md`), three from phase C (`plans/M63C-derivation.md`), seven from
phase D (`plans/M63D-derivation.md`), five from phase G (`plans/M63G-derivation.md`). Phases E and F, and
phase D's own close-audit, hold no theorem outside the kernel (each is its own census row below, with what it
holds instead).

The batch's own headline finding, structural rather than a new result: **every substantive theorem in this
material lives inside an obligation-modelling pass ("§O")**, written as `> **Claim.** … *Proof.* … ∎` blocks
before any code ran, exactly the shape WORKFLOW step 6 calls for and exactly the shape `CLAUDE.md` G67 says a
grokking should have (an imperative plus a falsifier) — these were never memoir prose to be mined by
grep-and-read; they were already written as theorems, with their own numbering (O1, O2, …), waiting only to
be given a project-wide id and a ledger line. Phases C and D each ran the pass in full (nine and six proved
claims respectively, once the completeness invariant shared between them is counted once); phase G ran no
formal `§O` pass at all, and its two headline theorems (the σ-criterion behind `CLAUDE.md` G52, and the
design-target inversion) are instead narrated in flowing prose across two working sessions — found, not by a
missing `§O`, but by the phase's own §1 ("The derivation, before any code") and §12 ("Filter 4, run"). Phases
E and F ran no proof at all: phase F is entirely an application of phase D's `O2`/`O3` (cited by name, twice,
as "the lemma the whole programme rests on"), and phase E is a 1,305-line subplan of held-out experiments
none of which were ever scored (no `§O`, no `§M`, no `§R`, and every "outcome" field reads unfilled).

## The census table

*One row per M63 phase in the batch, plus one for the three named opening documents. "Candidates" lists what
the files' own content offered; "classified as" gives kernel / measurement / reading / instance / prior art /
conjecture with one line why, per candidate.*

| milestone/phase | files | candidates found | filed as | classified as |
|---|---|---|---|---|
| **opening documents** (`M63-incremental-hitset.md`, `M63-parts-reproduction.md`, `M63-probe-S-expansion.md`) | 3 named files (250 KB), plus `M63-kernel-certification-route.md` (8 KB) and `M63-SESSION-HANDOFF-2026-09-11.md` (66 KB), which proved nothing of their own and are folded in here | the completeness invariant (`M63-parts-reproduction.md` §O(1)); the MCS/MUS duality "the one theorem everything is an instance of" (same §O); the small-half expansion monotonicity D1/D2 (`probe-S-expansion.md` §5); the incremental/decision hitting-set engine soundness arguments (`incremental-hitset.md` §3); the domain-modelling pass's three confirmed predictions about Table 1's symmetry column (`parts-reproduction.md` §M); the fitted cost laws of `incremental-hitset.md` §2 and §5c; the "decisive experiment" reproduction of §R1; the σ-criterion's earliest narrative record (`SESSION-HANDOFF` §6d–§6e) and the base-question narrative (§10); the kernel-certification-route's pricing of a route not taken | **M63-T1, M63-T2, M63-T3** | hand, closes, filed (T1–T3) · **MCS/MUS duality NOT re-filed — it is the same theorem already filed as `FS32-T1`** (FS-71 batch 4a); it is noted in `M63-T1`'s entry as its provenance, per WORKFLOW's M.2 · measurement, not filed (the three confirmed predictions; every cost law; the R1 reproduction) · earlier record, not separately filed, pointing forward to `M63G-T4`/`M63G-T5` (the handoff's §6d/§6e/§10) · priced-and-cancelled route, not a theorem (`kernel-certification-route.md`, classified per the brief's own instruction) |
| **phase C** (`M63-phaseC-joint-stage.md`, 111 KB) | the joint stage's `§O` pass: monotonicity for the two-sided case (O1, an instance of `M63-T2`); exact-resume soundness (O2); the three undecided-ask sites' soundness (O3, restates `M63-T1`'s pattern); double-coset problem isomorphism (O4); group-element naming by a free point's image (O5, elementary); "up to H" orbit-counting caveat (O6, a reading); the shading-control necessity/sufficiency split (O7); the regeneration control's scope (O8); the joint positive control's derived answer (O9); the control-coverage table (O11) | **M63C-T1, M63C-T2, M63C-T3** | hand, closes, filed (T1 = O2, T2 = O4, T3 = O9) · instance of `M63-T2`, not separately filed (O1) · elementary, not filed (O5) · readings/method notes, section 3, not filed (O6, O7, O8, O11) |
| **phase D** (`M63-phaseD-the-loop.md`, 182 KB; `M63-phaseD-close-audit.md`, 53 KB, an audit against phase D's own plan, proved nothing new) | the loop's `§O` pass: no-measure-but-bounded-improvements (O1); expansion non-increase at fixed rung (O2, the general form of `M63-T2`); target-ask soundness (O3); edge-atom upward closure (O4); capped-level over-report (O5); the degree floor on the edge minimum (O6, credited to Poros); the full transfer lattice (§R3.7, extends `M63-T2`/O2); the companion finding (§R3.4, a corrected reading of `[Parts2020a]`'s own data); the target-knob cost derivation (§R3.2); the close-audit's four "delivered but never promised" items (§D.6) | **M63D-T1 … M63D-T7** | hand, closes, filed (T1–T7) · reading, not a theorem — a corrected interpretation of a published table (§R3.4, "THE COMPANION FINDING") · measurement, not filed (§R3.2's refined cost-saving figure; the close-audit's process findings, §D.1–§D.7, all audit/compliance content, no mathematics) |
| **phase E** (`M63-phaseE-held-out.md`, 114 KB) | fifteen designed held-out rows (E0–E11), twenty registered predictions (§3), a control-characterisation experiment (E9) — no `§O`, no `§M`, no `§R`; every "outcome" field in the file reads unfilled | **none** | **no theorem** — a pure subplan. Confirmed by two independent checks: `grep -c "Claim\.\|Proof\."` returns 0, and every `outcome`/`pending`/`scored` marker in the file names a field still to be filled, never a filled one |
| **phase F** (`M63-phaseF-beat-509.md`, 79 KB) | the union-ladder programme, built entirely on phase D's `O2`/`O3`, cited verbatim as "the lemma the whole programme rests on" (§1.2) and "asking at a target" (§1.3); the measured cost model (§1.4); the covering-design schedule (§2.4); the certification-path pricing (§7) | **none new** | **no new theorem** — every mathematical claim in phase F is a direct application/corollary of `M63D-T2`/`M63D-T3`, cited by section number rather than re-derived; the covering-design schedule is a search strategy built on that corollary, not a new mathematical claim; the cost model and pricing sections are measurement |
| **phase G** (`M63-phaseG-bases-and-rotations.md`, 99 KB) | §1's derivation (the complete `cos θ ∈ K` enumeration, the endpoint-radius bound, the general `cos θ ∉ K` law); §2's filter cascade (restates kernel Theorem B and the 2-adic wall test — not new); §3's ranked census (computed, not a theorem); §11.6's isomorphism of four angles (a computed symmetry check); §12.3's σ-criterion (`CLAUDE.md` G52's necessary half); §12.4–§12.6's design-target inversion and its exhibited instance (the "base question answered YES") | **M63G-T1 … M63G-T5** | hand, closes, filed (T1–T5) · kernel-already (§2's filters 1–3, already Theorem B and G35, applied not re-derived) · measurement, not filed (§3's census tables; §11.6's isomorphism check; the 412-class-list critique of §1.2) · conjecture, not claimed (P-G13a–c, §12.5, scored on the one instance tested but not claimed in general; the `cos ∉ K` census, deferred) |

## Progress and resume

**Batch 4b is complete: the opening documents and phases C, D, E, F and G are all filed or classified.** No
successor is needed for this batch. Per `plans/FS71-theorem-audit.md` §S.6's seventeen-reader partition,
batches 4c (`M63` phase H2) and 4d (`M63` phases H3–H4) are next, each a separate reader — none of phase
H2's, H3's or H4's own files (`plans/M63-phaseH2-*.md`, `plans/M63-phaseH3-*.md`, `plans/M63-phaseH4-*.md`,
per `ls plans/M63-phaseH*.md`) were opened here, confirmed out of this batch's assigned file list.

## Theorems this phase proved

**None** — as expected for an audit. This batch's own product is 18 filed theorems that M63's opening
documents and phases C, D and G proved and left unindexed, one explicit non-refiling decision (the MCS/MUS
duality inside `plans/M63-parts-reproduction.md` §O, the same theorem already filed as `FS32-T1`), and two
clean "no theorem" classifications for phases E and F, each with the check that established it (a grep for
`Claim.`/`Proof.` returning zero for E; a citation trail for F showing every claim traces to phase D).

## Proposed edits to `CLAUDE.md`

**One, small.** `CLAUDE.md` G52 currently reads, in relevant part: *"A wall-breaking rotation can still be
four-colourable: breaking the wall is a property of the field the rotated copy lives in, while the residue
colouring reads the base points, which never leave the original field. The rotation escapes the colouring
only through one family — cross edges joining two base points the colouring gives the same colour, which
requires the base to realise a specific radius sum, via `d² = σ − (σ−1)/cos θ`."* This sentence is now a
theorem with an address: `M63G-T4` (the σ-criterion) and `M63G-T5` (the design-target inversion,
`Σ_live(cos θ)`). **Proposed addition, appended to G52's citation list where it already names
`M63-phaseG-bases-and-rotations.md` §12.3 implicitly through the escape-law formula:** after the sentence
quoted above, add *"(theorem: `M63G-T4`, `M63G-T5`, `LEDGER.md` § B)"* — the same pattern G68/G69 already use
to point at `plans/FS70-derivation.md`. Left to Kooshi to apply, per the batch rule that the owner edits
`CLAUDE.md`.

## Where the brief was wrong

- **Mostly right, and the corrections are all in the brief's own favour or neutral.** The seed named the
  right density ("medium, buried") and the right approach (grep is the method, given 1.15 MB across
  seventeen files) — but the actual mining strategy that paid off was different from a keyword grep: the
  theorems were found by locating each phase file's `§O` ("the obligation-modelling pass") heading and
  reading it whole, since every substantive theorem in phases C and D lives there, pre-formatted as
  `> **Claim.** *Proof.* ∎` blocks. A bare `rg -n -iE "theorem|lemma|..."` sweep (§S.4's literal discipline)
  would have found these too, since `Claim.` and `Proof.` are both in the pattern list, but reading the `§O`
  section as a unit — rather than ±40-line windows around each hit — was faster and safer, because these
  proofs cross-reference each other within the section (O2's hypothesis audit references O2 itself; O4 says
  "M63 §O carries verbatim", which only makes sense read against the section it is inside).
- **The brief's file-size table was exact** (confirmed by `ls -la` against the quoted byte counts before
  reading anything) and the "opening documents" grouping (`M63-incremental-hitset.md`,
  `M63-parts-reproduction.md`, `M63-probe-S-expansion.md`) matched the file contents once read: all three
  hold genuine theorems, as the seed predicted for `M63-parts-reproduction.md`'s completeness invariant.
- **One thing the seed did not anticipate, and it mattered:** `M63-kernel-certification-route.md` and
  `M63-SESSION-HANDOFF-2026-09-11.md` are both in the brief's file table but neither is named in the
  "opening documents" trio the census-table instruction lists by name. Both were read (the handoff in
  relevant part — §3, §4, §6d, §6e, §10 — and the certification route in full, 123 lines), classified, and
  folded into the "opening documents" census row rather than given rows of their own, since a six-row table
  (phases C–G plus one for openers) is what the brief's own template asks for and a seventh/eighth row for
  two files that proved nothing would not change any count.
- **The session-handoff file (`SESSION-HANDOFF-2026-09-11.md`) is a genuine hazard for double-filing, and it
  was caught rather than walked into.** Its §6d/§6e narrate the discovery of the σ-criterion in the *same*
  session, hours before phase G's own plan file was written with the polished, quantified, boxed theorem
  (§12.3). Filing both as separate theorems would have double-counted one discovery under two ids — the same
  failure mode `plans/FS71-theorem-audit.md` §M.2 names for M56's L7. Resolved per M.2: the theorem is filed
  once, at its most complete and general statement (`M63G-T4`, `M63G-T5`, in phase G's own file), and the
  handoff's earlier record is noted as provenance in both `M63-derivation.md`'s "readings" section and here.
- **Phase E holding literally zero theorems was not predicted by the seed** (which listed E only implicitly,
  via the general "medium, buried" density claim) but is unambiguous once the file is opened: there is no
  `§O` heading, no `Claim.`/`Proof.` anywhere in the file (grep-confirmed, zero hits), and every experiment's
  outcome field reads as a template placeholder, never a filled result. This is consistent with the overall
  picture the other files paint: M63 stalled with phase D closed, the small-half probe retired, and phases
  E–G either partly run (G's rotation screen) or entirely unexecuted (E in full, F's ladder never launched).

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `data/fs71/batch-4a.md`,
`data/fs71/batch-2a.md`/`batch-2b.md` ("Where the brief was wrong" sections), `LEDGER.md` rows 60–76 and § B
(read before and after insertion), `plans/M63-kernel-certification-route.md` (123 lines, in full — small
enough and entirely relevant), `plans/M63-incremental-hitset.md` (518 lines, in full), `plans/
M63-probe-S-expansion.md` (352 lines, in full), `data/m63/README.md` (phase H4's record, read for
orientation and confirmed out of this batch's scope).

**Files read in substantial part, by section:** `plans/M63-SESSION-HANDOFF-2026-09-11.md` (§3, §4, §5, §6d,
§6e, §10 read in full; §0, §1, §2, §6, §6a, §6b, §6c, §7, §8, §9 skimmed by heading — process/handoff
narrative, no theorem-shaped content found by the `Claim.`/`Proof.`/`theorem` grep run across the whole
file); `plans/M63-parts-reproduction.md` (2,119 lines: §S, §0, §PA, §1–§4, §M, §E read; §O read in full —
the completeness invariant and the MCS/MUS duality statement; §R1 read in full — confirmed measurement; §R2
and §R3 grepped with `grep -iE "claim\.|proof\.|theorem|monoton|iff|derived"` across lines 1175–2119 and
every hit's neighbourhood read — no theorem beyond what §O and the phase-specific files already state);
`plans/M63-phaseC-joint-stage.md` (§O read in full, lines 997–1146; §0–§2, §3–§8, §L, §H, §M, §E, §A skimmed
by heading; §R2 (1298–1488) skimmed for headings, its content cross-checked against the parallel §R2 already
read in `M63-parts-reproduction.md`, confirmed to be the fuller/duplicate telling of the same run); `plans/
M63-phaseD-the-loop.md` (§O read in full, lines 1201–1372; §R3 (1596–2119+) grepped with the same pattern
list and every hit's neighbourhood read, including the full "transfer lattice" table at §R3.7; §0–§2, §3–§8,
§X, §P, §M, §E, §A, §H, §H2 skimmed by heading); `plans/M63-phaseD-close-audit.md` (§D, lines 209–320, read
in full; the rest skimmed by heading — a checklist/audit against phase D's own plan, no theorem-shaped
content, confirmed by the same grep pattern returning zero hits outside §D's cross-references to `§R3.4`
and `§R3.7`, already read); `plans/M63-phaseE-held-out.md` (all section headings read; `grep -c
"Claim\.\|Proof\."` run, returning 0; `grep -in "outcome|pending|scored"` run and every hit read — confirmed
every predicted row is unscored); `plans/M63-phaseF-beat-509.md` (§1.2, §1.3, §1.4, §2.4, §2.5 read in full;
`grep -n "Claim\.\|Proof\.\|obligation-model\|domain-model"` run across the whole file, returning three hits,
all citations of phase D's theorems by name, not new proofs; the rest skimmed by heading); `plans/
M63-phaseG-bases-and-rotations.md` (§1 read in full, lines 134–244; §2, §3 read in full for the filter
cascade and its calibration; §12.3–§12.6 read in full, lines 976–1197; `grep -iE "claim\.|theorem|lemma|
derivation|derived here|proof\.|iff |if and only"` run across §3–§11 (lines 284–976) and every hit's
neighbourhood read; §0, §4–§11 skimmed by heading).

**Files grepped only, cross-checked against the main phase files, not read in full** (per batch 4a's
precedent for the POROS records): `plans/POROS-2026-09-11-m63-hitset.md`, `plans/
POROS-2026-09-11-m63-phaseC.md`, `plans/POROS-2026-09-11-m63-phaseD.md`, `plans/
POROS-2026-09-11-m63-phaseE.md`, `plans/POROS-2026-09-11-m63-phaseF.md`, `plans/
POROS-2026-09-11-m63-phaseG.md` — `grep -n -iE "claim\.|proof\.|theorem"` run across all six (11 hits total,
every one a citation of an already-known theorem — Theorem B, the sandwich argument, "the monotonicity
theorem" — or a phrase like "true claim"/"main claim" with no boxed statement); confirmed against each main
phase file's own "§P — Poros's cards, and their fates" section, which traces every substantive card's
adoption into the main plan by name (e.g. phase D's O6 is explicitly credited "Poros, 2026-09-11" in its own
source, and phase G's σ-criterion's independent cross-edge-law recount is credited "the advisor's card RS-2"
in §12.3). No POROS file held a theorem not already stated, credited and filed via its adopting phase file.

**Files skipped, and why:** `plans/M63-phaseH2-*.md`, `plans/M63-phaseH3-*.md`, `plans/M63-phaseH4-*.md` and
their POROS companions (`ls plans/M63-phaseH*.md`, `plans/POROS-2026-09-11-m63-hitset.md` excepted, already
counted above) — explicitly out of this batch's scope (batches 4c, 4d); `data/m62/*.json`, `data/m63/*.json`
beyond `data/m63/README.md`'s own summary — provenance/record files, not proofs, per every prior batch's
repeated finding; `tools/typem.py`, `tools/parts_reduce.py`, `tools/parts_hitset.py`, `tools/parts_run.py`,
`tools/parts_probe.py`, `tools/parts_audit.py`, `tools/wall_break_test.py` — spot-checked by docstring only
(each restates its plan file rather than adding content, per every prior batch's finding); no tool was run,
no solver, no `lake build`, no `lake env lean`.

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly (eight distinct queries across ten calls —
two calls, on "minimum hitting set & lazy" and "algorithm configuration & empirical & held-out", returned
0 hits and were not load-bearing for any entry, so they are not cited; the other eight are recorded verbatim
inside the theorems that use them, several entries sharing a query where the subject matter is the same),
and every gate
(`tools/fs71_ledger_b_check.py`, `tools/claude_md_fact_audit.py --base 515b4eb2`, `tools/check_architecture.py`)
was run directly. `tools/bib_audit.py` was run for completeness (confirmed green) though no bibliography row
was touched — no new paper surfaced and no prior-art re-attribution occurred in this batch.

**One markdown-parsing incident, caught and fixed before hand-back, the same failure mode batch 4a
documented.** Three of this batch's own eighteen headers wrapped across a line break in first draft
(`M63D-T4`, `M63G-T1`, `M63G-T5`) and three field markers were split the same way (`M63C-T3`'s `*Proof
verdict:*`, `M63D-T5`'s and `M63D-T6`'s `*Rests on it:*`) — the same bug batch 4a found and the checker
now warns on by name (`tools/fs71_ledger_b_check.py`'s "header starts like an entry but did not parse", and
the per-field `lacks` warnings for markers present but split). All six were found by running the checker
before hand-back rather than by re-reading the files, fixed by joining the wrapped lines, and the checker now
reports `PASS` on all eighteen of this batch's entries with only the pre-existing FS70/M18 field warnings and
the FS38/FS66 placeholder row remaining (none of them this batch's to fix, per the brief).
