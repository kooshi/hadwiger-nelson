# FS-71 batch 5c — the theorem audit of the 2026-09-14 advisor fold-in (GPT Astra's theorems) and the 2026-09-13 Poros wall-breaking record

*Filed 2026-09-23 by the batch-5c implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow spawned —
see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in full (§G.1's G55 row and
§G.2's batch-5 seed especially, §M.1–M.6, §S.1–S.6), `plans/FS70-derivation.md` (the template), `ls plans/*-derivation.md`
(the existing derivation files), `data/fs71/batch-5b.md` (the immediately preceding batch, format precedent), `LEDGER.md`
rows 47, 57, 63 and § B — the exact enumeration is below.*

## Headline

**The 2026-09-14 fold-in: 10 theorems filed in 1 new file (`plans/ASTRA-2026-09-14-derivation.md`), 2 re-attributed
partly to prior art (T2 to `[Fischer1990b]`'s special cases, already recorded before this batch; T3's mechanism to
`[Fischer1990]` Thm 1 — a new finding of this batch, not caught by `VERIFICATION.md`'s own 2026-09-14 read), 0 demoted
(gap) — every one of the ten closes, three of them (T7, T8, T9) explicitly conditional on `G₄`, an existing,
already-credited measurement (Jannis Harder's construction genre, Polymath16 2018) that this batch does not re-file.
`plans/POROS-2026-09-13-wall-breaking.md` (the earlier Poros record, distinct from FS-38's implementation session)
holds no theorem of its own — a reframing document whose every verdict line points at FS-38's later close, already
filed at batch 5b. Enumeration complete for every file the brief named.**

## The census table

| milestone/event | files | candidates found | filed as | classified as |
|---|---|---|---|---|
| **the 2026-09-14 advisor fold-in** (no ledger row of its own — lives in `CLAUDE.md` G55, item 10 of "Where the problem stands", stubs FS-45–FS-48) | `reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` (357 lines, read in full), `VERIFICATION.md` (53 lines, read in full), `six-colour-research-directions.md` (154 lines, read in full), both verifier scripts (headers read, not re-run) | Lemma 1.1; Theorem 1.2 (prime inversion); Theorem 2.1 (χ=2 ⟺ L=2); Theorem 3.1 (χ=3 for √3∈F); Theorem 4.1 (the chain theorem); the 18-vertex ℚ(√2,√3) instance; Theorem 6.1 (conditional on G₄); Corollary 6.2 (conditional on G₄, T7); the eight-copy K(√7) witness (conditional on G₄); the distance-2 host sentence; a proposed six-colouring of UD(𝔽₈₃) (§2 of the research-directions note, not a theorem — duplicates FS-40) | **ASTRA-2026-09-14-T1 through T10** | T1–T6, T10: hand or derived or tools, closes, unconditional. T7, T8, T9: hand (+tools for T9's identity), closes, explicitly conditional on `G₄` (an existing FS-45/FS-47-tracked dependency, not a new claim). The §2 six-colouring proposal: not a theorem, filed under "Readings and measurements that were called theorems" |
| **the 2026-09-13 Poros wall-breaking record** (`plans/POROS-2026-09-13-wall-breaking.md`) | the file itself, 268 lines, read in full | a situation survey, an evidence inventory (14 items), four hunch cards, one question-card ledger (four cards), a ruling | **none filed** | not a theorem-producing document — every "verdict" line in it is a retroactive pointer, added at FS-38's 2026-09-13 close, to a theorem FS-38 itself proved and that FS-71 batch 5b already filed (`plans/FS38-derivation.md`). Grepped throughout for the standard theorem-pattern list (`theorem\|lemma\|proposition\|corollary\|by hand\|\[hand\]\|\[derived\]\|\[cert\]\|\[proof\]\|we prove\|proof:\|QED\|∎\|iff\|if and only if\|exactly when`); every hit is either a citation of an already-filed result or one of the four hunch/question cards' own verdict lines, none of which states a new proof of its own |

## Progress and resume

**Batch 5c is complete: the 2026-09-14 advisor fold-in and the 2026-09-13 Poros wall-breaking record are both fully
audited.** No successor is needed for this batch. Per `plans/FS71-theorem-audit.md` §S.6's seventeen-reader partition,
batch 6a (FS-50, FS-53) is next.

## Theorems this phase proved

**None** — as expected for an audit. This batch's own product is 10 filed theorems that `local-global-further-results.md`
and `six-colour-research-directions.md` had already stated and proved (or, for T7–T9, stated as conditional), indexed for
the first time under `LEDGER.md` § B and given ids, prior-art verdicts and kernel decisions. No new mathematics — the
closest thing to a finding is the two prior-art re-attributions below, which are checks, not proofs.

## Proposed edits to `CLAUDE.md`

**None proposed.** Every grade tag G55 already carries in `CLAUDE.md` (`[hand]`, credited to GPT Astra, with the
conditionality on `G₄` already stated in the prose — "conditional on the reported forcer" and similar phrasing appears
throughout G55's own text) matches what this batch found on reading the source files: ten sound hand/derived/tools
theorems, three of them conditional, none demoted. Unlike batches 1, 4b and 5b, this batch found no grade-tag
imprecision in `CLAUDE.md` itself to correct — the imprecision this batch did find (T3's relationship to `[Fischer1990]`
Theorem 1) is a bibliography-row-level nuance, not a `CLAUDE.md` sentence, and is recorded directly in
`BIBLIOGRAPHY.md`'s `[Fischer1990]` row (a bibliography edit is within this batch's own remit per the brief's item 4,
unlike `CLAUDE.md` edits).

## Stub lines

**None added.** Every kernel decision above (T1–T10, all "stub") points at a named `D`-item that already exists inside
FS-45 (`plans/STUB-chain-theorem.md`, D1–D3), FS-46 (`plans/STUB-three-colour-classification.md`, D1–D2), FS-47
(`plans/STUB-unit-vector-ring-kernel.md`, D2–D6) or FS-49 (`plans/STUB-distance-two-gadget.md`, its consumer
`six_le_chromaticNumber_plane_of_separated_two`) — because those four stubs were minted on 2026-09-14 specifically to
hold GPT Astra's theorems as kernel targets (`plans/SESSION-HANDOFF-2026-09-14.md` §1 item 2), the "kernel target" work
was already done at minting time, matching batch 5b's precedent for FS-38's D2-A/D2-B/L1 landing in the pre-existing
FS-41/FS-42 with no new heading needed. No new `plans/STUB-*.md` was required.

## Where the brief was wrong

- **The brief's shape held; two things needed a judgement call it did not fully specify.** First, the brief lists G55's
  theorems as a flowing paragraph (nine clauses joined by semicolons) rather than a numbered list, and folding G54's two
  forward-pointed items ("batch 6 files those; note them as forward pointers only") out left exactly ten distinct
  provable statements to file, matching the ten rows `VERIFICATION.md`'s own table already scores — this batch used
  that table's own numbering (1–10, its row 10 being the §2 six-colouring proposal, correctly not a theorem) as the
  checklist rather than re-deriving a count from the prose, which the brief's "every theorem G55 names accounted for"
  acceptance item implicitly asks for. Second, the brief names Lemma 1.1 only inside the parenthetical explaining
  Theorem 1.2's "by lying-over" clause, not as a numbered item of its own; this batch filed it as its own entry (T1)
  because it is a materially separate mathematical statement with its own zbMATH-checkable content, matching the
  precedent of `plans/M56-derivation.md`'s L1–L8 (each of *its* supporting lemmas got its own id) rather than folding it
  silently into T2's proof.
- **A real header-formatting bug was caught and fixed mid-batch, not by the brief's warning alone.** The brief's "What
  batches 1–2b taught" section warns that the checker's entry header must sit on one physical line with no literal `]`
  inside the grade bracket, and that batch 4a lost five entries silently to this. This batch's first draft violated the
  *field-marker* form of the same bug in two places the checker's own header-parsing regex does not catch (because a
  Python character-class exclusion `[^\]]` matches across a line break, so a header like `**T4 — … [hand; …\ntheorems]**`
  parses successfully even though its grade bracket wraps a line) — the checker instead failed on the *field markers*
  `*Proof verdict:*` and `*Rests on it:*` being split across a line break inside two entry bodies (T5, T7), which are
  matched by literal substring search and have no such tolerance. `python3 tools/fs71_ledger_b_check.py --strict` caught
  both immediately (`entry ASTRA-2026-09-14-T5 lacks *Proof verdict:*`, `entry ASTRA-2026-09-14-T7 lacks *Rests on it:*`)
  plus the genuine bracket bug in T9 (a nested `[C]` inside its grade text, which does break the header regex and drew
  the checker's own near-miss warning). The repair, applied to the whole file rather than patched line by line: every
  entry is now written as one unbroken physical line (no manual mid-paragraph line wraps at all), matching
  `plans/FS70-derivation.md`'s and `plans/M31-derivation.md`'s own convention exactly — a convention this brief's "What
  batches taught" section names for the *header* but which, read narrowly, could be mistaken for a header-only rule; it
  is safest applied to the whole entry.
- **`G₄`'s own status needed one extra hop the brief's seed did not spell out, though it correctly flagged it as a
  dependency to name.** The brief's seed says to file T7–T9 "conditional on Harder's/M56's forced pair with the
  hypothesis named" — it does not say whether `G₄` itself should get its own § B line inside this file. Checked against
  `plans/M53-derivation.md` T14 (the *spindled* K(√247) witness, which explicitly separates "the forced pair itself" —
  credited to Harder — from "the spindle-to-witness construction", M53's own) and `plans/M56-derivation.md` (the sweep
  that produced the 588-vertex core, already an M56/batch-3b matter): `G₄` — the raw, unspindled 588-vertex core's
  forcing of the 8/3 pair — is not independently filed as its own theorem anywhere in the record found (M53-T14 is
  about the spindled object; M56's derivation file does not carry a separate entry for the sweep's 163-of-178 result as
  a standalone claim). This batch does not file `G₄` itself (it belongs to M53/M56, batches 3a/3b, already accepted,
  and inventing a new entry for another batch's unfiled measurement would be scope creep); it is named, with its exact
  address and grade, in T7–T9's own text and in a dedicated "Conjectures surfaced, not claimed" bullet, so a reader
  of `ASTRA-2026-09-14-T7` knows exactly what remains open without this batch overreaching into batch 3a/3b's territory.

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md` (439 lines, entirely — §G.1's G55 row, §G.2's batch-5 seed
paragraph for rows 61/63/66/67, §M.1–M.6, §S.1–S.6, §R's existing rows through batch 5b); `plans/FS70-derivation.md`
(131 lines, the template); `data/fs71/batch-5b.md` (the immediately preceding batch, for current formatting
conventions, the census-table shape, and the "where the brief was wrong" precedent for header-parsing bugs);
`reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` (357 lines, the ten theorems'
statements and proofs); `reference/ChatGPT-local-global-tightness-conjecture/VERIFICATION.md` (53 lines, the owner's
2026-09-14 read and the ten-row scoring table this batch used as its checklist); `reference/ChatGPT-local-global-tightness-conjecture/six-colour-research-directions.md`
(154 lines, both proposed routes, only §1 yielding a theorem); `plans/STUB-chain-theorem.md` (FS-45, 152 lines, in full
— the D1–D5 kernel-target map used to assign T5/T6/T9/T10's kernel decisions); `plans/STUB-unit-vector-ring-kernel.md`
(FS-47, 128 lines, in full — the D1–D6 map used for T1/T2/T3/T7/T8); `plans/STUB-three-colour-classification.md`
(FS-46, 140 lines, in full — T4's kernel decision and the El-Zahar–Sauer/prime-power-floor pricing); `plans/STUB-biquadratic-table.md`
(FS-48, 113 lines, in full — checked for a separate GPT-Astra-credited theorem beyond T4/T6; found none, the `ℚ(√3,√5)`
six-vector identity there is attributed to neither GPT Astra nor a dated advisor session and is out of this batch's
scope); `plans/POROS-2026-09-13-wall-breaking.md` (268 lines, in full); `plans/SESSION-HANDOFF-2026-09-14.md` (90 lines,
in full — the day's own summary, cross-checked against this batch's ten-theorem count and stub assignments, which
match exactly); `plans/M56-derivation.md` (its header's enumeration note and its "Conjectures surfaced, not claimed"
section, confirming L7's forward pointer to this file and that it was not separately filed there); `plans/M53-derivation.md`
T14 (confirming the K(√247) *witness* is filed separately from the raw `G₄` forcer, which this batch's T7–T9 correctly
treat as an external, unfiled dependency); `LEDGER.md` rows 47, 57, 63 (read from disk, matching the loaded
`CLAUDE.md`/`LEDGER.md` snapshot) and § B in full, before and after insertion; `BIBLIOGRAPHY.md` rows for
`[Fischer1990]`, `[Fischer1990b]`, `[ElZaharSauer1985]`, `[ExooIsmailescu2019]` (each read in full via `grep -n`,
confirming existing citation status, read status and — for `[Fischer1990]` — the finding recorded in this batch's
prior-art re-attribution).

**Files read in part / headers only, per the brief's "no solver" instruction:** `verify_local_global_extensions.py`
(207 lines; opening docstring and the arithmetic setup read, the exact checks it runs already fully described in
`VERIFICATION.md` row-by-row — not re-executed); `independent_check.py` (131 lines; same treatment — its distinguishing
feature, the reachable negative control on edge-criticality, is quoted directly from `VERIFICATION.md` §1, not
independently re-derived from the source); `example_qsqrt2_qsqrt3.json` (not opened — its content, 18 vertices/33
edges/25-critical/the four-colouring, is fully described in prose in both `local-global-further-results.md` §5 and
`VERIFICATION.md` row 6, and this batch is bookkeeping, not re-verification, per the brief's opening line "This batch
is reading and bookkeeping — no solver, no Lean beyond checking that a name exists").

**Files skipped entirely, and why:** `data/m53/forced-spindle-core-8over3.json` and `data/m53/forced-spindle-full-8oversqrt3.json`
— not read (their content, the 588-vertex core and the 8/3 forcing, is already fully described in `plans/M53-derivation.md`
T14 and `CLAUDE.md` G55, and this batch's job is to record `G₄`'s *status* — tools grade, no proof log, cross-referenced
— not to re-verify it, which belongs to FS-45's phase C); `Proofs/HadwigerNelson/*.lean` beyond confirming no cited Lean
declaration in this batch's entries needed an `rg` existence check (none of T1–T10 cites an existing Lean declaration
by name — every kernel decision is "stub", pointing at a not-yet-built target in FS-45/46/47/49 — so no `rg` check was
needed here, unlike batches that cite already-kernel declarations); `docs/local-global-tightness.md` (the original
write-up sent to the advisor, referenced by the stubs but not itself a source of GPT Astra's theorems — the advisor's
*response* is what this batch audits); `data/fs45/`, `data/fs46/`, `data/fs47/`, `data/fs48/`, `data/fs49/` — none
exist yet (these stubs are unopened milestones; `ls` confirms no such directories, consistent with "stub" kernel
decisions throughout). No `lake build`, no `lake env lean`, no solver, no subagent.

**zbMATH queries run** (all `curl -sG 'https://api.zbmath.org/v1/document/_search'`, recorded verbatim with hit counts
inside the entries they support): `ab:"unit vector" & ab:"lying-over"` (0), `ti:"chromatic number" & ab:"stable prime" &
ab:"conjugation"` (0), `ti:"chromatic number" & ab:"bipartite" & ab:"number field"` (0), `ab:"ring homomorphism" &
ab:"chromatic number" & ab:"unit distance"` (0), `ab:"categorical product" & ab:"chromatic number" & ab:"finite field"`
(0), `ti:"chromatic number" & ab:"Hedetniemi" & ab:"quadratic"` (0), `ab:"unit distance graph" & ab:"forced" &
ab:"period"` (0), `ab:"sum of unit vectors" & ab:"chromatic"` (0), `ab:"virtual edge" & ab:"unit distance" &
ab:"chromatic"` (0), `ab:"two-distance graph" & ab:"chromatic number" & ab:"six"` (0), `au:"El-Zahar" & ti:"chromatic
number"` (2, correctly identifying `[ElZaharSauer1985]` = `0575.05028` against a second, unrelated El-Zahar–Sauer
paper `0708.05045`), plus two positive controls confirming the query mechanism finds known matches rather than being
silently broken: `ti:"chromatic number" & ab:"additive" & ab:"coloring" & py:1985-2000` (1 hit, `[Fischer1994]`, the
brief's own worked example) and `au:"Fischer, Klaus G." & ab:"chromatic"` (2 hits, `[Fischer1990]` and `[Fischer1994]`,
confirming no third Fischer paper is indexed under that author-plus-keyword combination and that `[Fischer1990b]`'s
absence from it is an indexing artefact of its abstract text, not a missed paper — it was already found and read via
title search in 2026-09-16, per `BIBLIOGRAPHY.md`).

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly via `curl`, and every gate
(`tools/fs71_ledger_b_check.py --strict`, `tools/claude_md_fact_audit.py --base a32fc65d`, `tools/claude_md_fact_audit.py --dupes`,
`tools/check_architecture.py`, `tools/bib_audit.py`) was run directly, in that order, before this report was written.
No tool script was modified.
