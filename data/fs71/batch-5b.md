# FS-71 batch 5b — the theorem audit of FS-38 (the residue tower)

*Filed 2026-09-23 by the batch-5b implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in full
(§M.3 and §S.1 especially), `plans/FS70-derivation.md` (the template), `ls plans/*-derivation.md` (the existing
derivation files), `data/fs71/batch-5a.md` (the immediately preceding batch, format precedent), `LEDGER.md` rows
66–67 and § B — the exact enumeration is below.*

## Headline

**FS-38: 7 theorems indexed in 1 file (`plans/FS38-derivation.md`, completed in place, not rewritten), 0
re-attributed wholesale to prior art (one theorem, FS38-D2-A, carries a recorded split — its balance/gap-freedom
clauses are `[AbiadEtAl2025]`/Blokhuis–Brouwer–Haemers 2007, its periodicity clause ours), 0 demoted (gap), 0
marked *unsure*. Enumeration complete for the assigned file (`plans/FS38-derivation.md`, read in full) plus a
grep-discipline pass over the batch's other six files (394 KB) confirming nothing outside it is a separate,
un-filed theorem.**

Row 66 (the fan-gap theorem and its arity-2 compulsion structure over sealed fields) is **kernel throughout** and
holds nothing to file here: the one hand step its own text flags — "the field-level hand step of M58/M60, row
57's gap" — is not claimed by row 66 and was already filed as a conjecture, pointing at stub FS-47, under
`plans/R57-derivation.md` by an earlier batch (3b); it is not re-filed. Row 67 (the 2-adic tower's stabilisation
at level 4) is where every theorem of this batch lives: FS38-D2-A (Hoffman-tight Cayley graphs force balanced,
gap-free, `H_min`-periodic colourings — the general mechanism), FS38-D2-B (the 2-adic instance: every 4-colouring
of the tower `P_m`, `m ≥ 5`, is pulled back from level 4), FS38-L1–L3 (the three lemmas the induction needs —
propagation, the primitive-character bound, the elementary-divisor certificate), FS38-D1 (the period-set
structure at levels 2–4, hand at level 2, tools-side census at 3–4), and FS38-D3 (the tight/slack classifier
generalised off the 2-adic case, with the Weil-cutoff closure and the 3-adic control folded in as the brief
directed — neither got a separate id). D-4 (the maximum-gap question at 11) is filed as a conjecture, not a
theorem, per the brief's own instruction. Two stubs already existed and needed no minting: FS-41
(`forces_of_tight`, `plans/STUB-forces-of-tight.md`) is where D2-A, D2-B, and L1 land; FS-42 (`plans/
STUB-tight-quotients.md`, 5-tight quotients of 6-open planes) is a consumer of D2-A/D3, not a kernel target for
any entry here.

## The census table

*One row per milestone the brief assigned, plus one line per theorem indexed, per the brief's shape for this
batch (only one milestone, FS-38, is in it).*

| milestone | files | candidates found | filed as | classified as |
|---|---|---|---|---|
| **FS-38** (row 66) | kernel modules only (`FanGap.lean`, `Instances/FanGap11.lean`, `Instances/FanGap19.lean`) | the fan-gap theorem and its corollaries (`not_forces_of_fanGap`, `not_fan_of_fanGap`, `not_separated_of_sharedGap`, `Slack.forces_iff`, `PairwiseFusable.separated_iff_adj`, the `_of_hom` and `_of_ringHom` transports, `slack_addCayley_of_fanGap`, `exists_fanGap_iff_not_coverAtLeast`); the field-level hand step it explicitly does not claim | **none filed** | all kernel (row 66's own text: "**Not claimed:** the field-level hand step of M58/M60 (row 57's gap)" — that gap is already filed at `plans/R57-derivation.md`, pointing at stub FS-47; not re-filed by this batch) |
| **FS-38** (row 67, `plans/FS38-derivation.md`) | the file itself (43 KB → 61 KB after this batch's index), read in full; six sibling files (394 KB) grepped — see the enumeration | D-1's level-2/level-3–4 period-set structure; Theorem D2-A (Hoffman-tight ⟹ balanced, gap-free, `H_min`-periodic); Theorem D2-B (the 2-adic tower's `m ≥ 5` propagation); Lemma 1 (tightness propagates up); Lemma 2 (the primitive-character bound); Lemma 3 (the elementary-divisor certificate, re-verified on a second code path); the ring identification `twoAdicPlane m ≅ Cay(O/𝔓^m,S_m)` (folded into D2-B, per the brief); the tight/slack classifier and its Weil-cutoff closure and 3-adic control (folded into D3, per the brief); D-4's uniform-gap question | **FS38-D1, FS38-D2-A, FS38-D2-B, FS38-L1, FS38-L2, FS38-L3, FS38-D3** | D1: hand + tools, closes. D2-A: hand, closes, **prior-art split recorded** (balance/gap-freedom = `[AbiadEtAl2025]`/Blokhuis–Brouwer–Haemers; periodicity = ours). D2-B: hand, closes (base cases m=4,5 independently kernel already). L1: hand, closes. L2: hand, closes. L3: hand + tools, closes (re-verified on a second code path). D3: derived, closes (folds in the Weil cutoff and the 3-adic control, credited to "T and Poros" per the narrative's own words). D-4: **conjecture, section 4, not filed to § B** — "not needed for any theorem" per the file's own words |

## Progress and resume

**Batch 5b is complete: FS-38 (rows 66 and 67) is fully indexed.** No successor is needed for this batch. Per
`plans/FS71-theorem-audit.md` §S.6's seventeen-reader partition, batch 5c (the 2026-09-14 Astra fold-in) is next.

## Theorems this phase proved

**None** — as expected for an audit. This batch's own product is 7 filed theorems that FS-38's own narrative had
already named and proved, indexed for the first time under `LEDGER.md` § B and given ids, prior-art verdicts and
kernel decisions. No new mathematics.

## Proposed edits to `CLAUDE.md`

One edit is proposed, a grade-tag correction of the kind earlier batches made for G12, G20 and G52 (§R rows 1
and 4b): `CLAUDE.md`'s G54 entry currently reads

**The exact current sentence** (`CLAUDE.md`, the G54 entry's header): *"Tight or slack: a residue plane's
compulsions at k colours are classified by one sign. [kernel one way; derived the other; the table computed]"*

**Proposed sentence:** *"Tight or slack: a residue plane's compulsions at k colours are classified by one sign.
[kernel one way; hand the other (Theorem D2-A, FS-38, `plans/FS38-derivation.md`); the table computed]"*

**The reason.** `LEDGER.md` row 67 already grades the mechanism precisely: *"Derived [hand, `plans/
FS38-derivation.md` D-2, Theorems D2-A/B]"* — the "derived" there is prose ("what row 67 derives"), and the
bracketed grade tag inside it is `[hand]`, matching `CLAUDE.md` § Notation's own vocabulary (**[hand]** a hand
proof; **[derived]** derived from results already held). Theorem D2-A is proved fresh from an external theorem
(Hoffman's ratio bound, unpublished, traced by `[Haemers2021]` to Delsarte/Seidel) plus Fourier inversion on a
finite abelian group (Mathlib machinery, not a held project result) — it is not a combination of results this
project already holds, so "derived" in G54's grade-tag sense is imprecise; "hand" is the word row 67, the
narrative itself, and this batch's own filed entry (FS38-D2-A) all use. This is a precision edit, matching the
pattern of the three grade-tag corrections batches 1 and 4b already made (G12, G20, G52) — not a retraction:
nothing in G54's content is false, its *bracket* just uses the coarser of two adjacent grade words. Left to
Kooshi to apply.

## Where the brief was wrong

- **Mostly right, and the "completed in place" shape held exactly as described.** The brief's instruction to add
  one new top section, "The theorems (FS-71 index)," holding seven entries with the narrative's own names as ids,
  and to leave the narrative untouched, matched the file precisely — `plans/FS38-derivation.md` already had
  D-1 through D-4 with Theorem D2-A, Theorem D2-B, and Lemmas 1–3 named exactly as the brief said, and the git
  diff for this batch's edit to that file is a pure 248-line insertion (`git diff --stat` confirms `1 file
  changed, 248 insertions(+)`, no deletions) with the new section landing between the status-line blockquote and
  `## 0. Inputs`, exactly where the brief pointed.
- **The brief's list of items to "file" mixed two different instructions, and the seven-id constraint forced a
  reading of it.** The brief named seven theorems with ids and then, in the same sentence, also asked to "file"
  the ring identification (`Cay(O/𝔓^m, S_m)` ≅ `twoAdicPlane m`), "the classifier's Weil consequence," and "the
  3-adic control" — three more items with no id of their own. Read literally against "with ids [the seven]," a
  literal eighth/ninth/tenth id would have violated the brief's own instruction; the resolution taken (documented
  in this file's opening note) folds the ring identification into FS38-D2-B (whose statement is about exactly
  that object) and the Weil consequence plus the 3-adic control into FS38-D3 (whose statement already covers the
  general classifier those two are instances of). This is not a deviation from the brief's content — every fact
  it named is indexed and pointed at a proof — only from a literal id-per-fact reading that the brief's own
  "with ids [seven]" clause ruled out.
- **`data/fs38/README.md`'s "field-level hand step" cross-check needed one extra hop the brief did not flag.**
  The brief said "point at R57's named gap" for row 66's one hand step; confirming that this gap was in fact
  already filed (not merely mentioned) meant reading `plans/R57-derivation.md`'s own "Conjectures surfaced, not
  claimed" section, which the brief's file list for this batch did not include (it belongs to batch 3b's
  enumeration). Read anyway, since row 66's own text names it explicitly; it confirmed the gap is filed at stub
  FS-47 with no § B line (correctly — "no proof exists yet to index," per that file's own words), so this
  batch's census table can say "already filed" rather than merely "not claimed."
- **The `plans/STUB-first-digit-83.md` (FS-40) file the brief listed among the batch's addresses turned out to be
  a sibling stub, not a source of FS-38 theorems.** It is the "is `UD(𝔽₈₃,2)` six-colourable?" question, minted at
  the FS-38 close from the advisor's question cards, and it cites FS-38's slackness finding at 83 (D-3's table)
  but proves nothing itself — grepped for theorem-shaped patterns and found none beyond restating D-3's own
  numbers. No content moved from it into this batch's filing.

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md` (438 lines, entirely, including §G.1's G54 row and §G.2's
batch-5 seed for rows 66–67, §M.1–M.6, §S.1–S.6, §R's existing rows); `plans/FS70-derivation.md` (131 lines, the
template, entry shape and section conventions); `data/fs71/batch-5a.md` (185 lines, the immediately preceding
batch, for current formatting conventions and the census-table/enumeration-section shape); `plans/
FS38-derivation.md` (469 lines before this batch's edit, the file this batch completes — every section, D-1
through D-4, the kernel skeleton, the bibliography-entries note, the retractions record); `LEDGER.md` rows 66–67
(read as printed in this session's loaded `CLAUDE.md`/`LEDGER.md` snapshot, then re-read from disk via `sed`
before any edit, per the disk-is-authoritative rule) and § B in full, before and after insertion; `plans/
STUB-forces-of-tight.md` (90 lines, the FS-41 stub — its "Derivations first" section is the kernel-skeleton
target for D2-A/D2-B/L1); `plans/STUB-tight-quotients.md` (78 lines, the FS-42 stub — confirmed it is a
*consumer* of D2-A/D3, not a kernel-decision target for any entry here); `plans/R57-derivation.md` (read for the
row-66 cross-check above, confirming the field-level gap's home); `data/fs38/README.md` (confirmed row 66's
supporting records are all kernel-provenance, no theorem-shaped content); `BIBLIOGRAPHY.md` rows for
`[Hoffman1970]`, `[Lovasz1979]`, `[Delsarte1973]`, `[GodsilMeagher2016]`, `[Haemers2021]`, `[AbiadEtAl2025]`,
`[MMST1998]`, `[Weil1948]` (confirmed all eight are already keyed and read, per FS38-derivation.md's own
"Bibliography entries the close must add" note — no new bibliography edit was needed, every entry it names was
already added at the FS-38 close).

**Files grepped, not read whole, per the grep discipline (S.4):** `plans/FS38-residue-tower.md` (1,238 lines,
147.8 KB) — `grep -n "^## \|^### "` for its section structure (confirming it ends at §R2, no §R3/§R4 that might
hold un-indexed phase-D content) and a full read of §PA (lines 143–162, the prior-art gate table this batch's
zbMATH queries supplement rather than duplicate); `plans/FS38-tower-records.md` (25.3 KB) — `grep -n -iE
"theorem|lemma|proposition|corollary|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|we prove|not claimed|
conjecture"` (four hits, all casual references to "the milestone's theorem" i.e. row 66/67 themselves, nothing
new); `plans/POROS-2026-09-13-fs38-implementation.md` (81.9 KB) and `plans/POROS-2026-09-13-fs38-subplan.md`
(45.9 KB) — section-header grep (`grep -n "^# \|^## "`) confirming both are advisory review/audit notes (evidence
inventories, corrections requested, retractions counted) with no `**Theorem`/`**Lemma` headers of their own; their
substantive contributions (the second-code-path re-verification of Lemma 3, the Weil-cutoff closure) are already
credited inside `plans/FS38-derivation.md`'s own text ("on the advisor's audit ask," "by T and Poros") and are
not a second, separate source; `plans/SESSION-HANDOFF-2026-09-13-fs38.md` (8.4 KB) and `plans/
SESSION-HANDOFF-2026-09-13.md` (11.9 KB) — full-text grep for the same pattern list, confirming both restate
row-66/67 conclusions already captured (including the exact "What is NOT claimed" sentence this batch's opening
note quotes) with nothing additional to file; `plans/STUB-first-digit-83.md` (9.3 KB, ~40 lines read directly plus
the same grep pass) — confirmed a sibling stub with no FS-38 theorem content of its own (see "Where the brief was
wrong").

**Files skipped entirely, and why:** `Proofs/HadwigerNelson/*.lean` beyond `rg` declaration-existence checks — no
proof was read or repaired, per the brief; every cited name (`twoAdicFour_forces_iff`, `twoAdicFive_forces_iff`,
`twoAdicFive_not_colorable_with_edge`, `twoAdicFive_not_slack`, `twoAdicFour_not_slack`,
`twoAdicPlane_one_no_fanGap`, and Mathlib's `addCayley`) was checked to resolve with `rg`, not read for a proof;
`data/fs38/` beyond its `README.md` — provenance/record files, not proofs, per every prior batch's repeated
finding; `build/fs38-d/` — gitignored scratch, not on disk. No `lake build`, no `lake env lean`, no solver. Ten
zbMATH `curl` calls were run directly (the brief's own recipe: `curl -sG 'https://api.zbmath.org/v1/document/
_search' --data-urlencode 'search_string=...'`), every query and its hit count recorded verbatim inside the entry
it supports, plus two positive-control queries (`ti:"finite Euclidean graphs over rings"`, `au:"Blokhuis, A." &
ab:"coclique"`) confirming the zero-hit queries are genuine negatives and not a broken query string.

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly, and every gate
(`tools/fs71_ledger_b_check.py`, `tools/fs71_ledger_b_check.py --strict`, `tools/claude_md_fact_audit.py --base
c7f92455`, `tools/claude_md_fact_audit.py --dupes`, `tools/check_architecture.py`, `tools/bib_audit.py`) was run
directly, in that order, before this report was written. One small addition to `tools/claude_md_fact_audit.py`'s
own `ALLOW` table was made (two entries, crediting this batch, recording why the § B placeholder row's tokens
were allowed to vanish) — the same mechanism three earlier FS-71 batches used for their own grade-tag and count
corrections; no other tool or script was touched.
