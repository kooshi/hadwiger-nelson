# FS-71 batch 6a — the theorem audit of FS-50 and FS-53

*Implementer's report, 2026-09-23. Milestones: FS-50 (six colours refused at 83 by exact certificate — row 68) and FS-53
(the window for six — row 69), with G56–G59's derived clauses named in the brief. Produced: `plans/FS50-derivation.md`
(6 theorems), `plans/FS53-derivation.md` (4 theorems), 10 `LEDGER.md` § B rows, one `BIBLIOGRAPHY.md` row
(`[GarciaMarcoKnauer2024]`). No agent of any kind was started; every read and every write in this batch is mine.*

## Census table

| milestone | candidates found | filed as | classified as kernel/measurement/reading/instance/prior-art/conjecture |
|---|---|---|---|
| **FS-50** | the soundness identity (§1–§3 of the reviewer-facing derivation); the always-achievable multiplier construction (§5); the circulant/Fourier block reformation (§7); the reflection-symmetry real-block reduction (`data/fs50/README.md`); the commutant's block-size computation (two independent derivations, `STUB-independence-threshold.md` §M1.3 and the advisor's Q1); the consequence `L(K(√7))=7` | **FS50-T1 – T6** (6 theorems, all *closes*) | none demoted; two measurements/readings kept out of § B (the `ϑ=ϑ′=` Hoffman confirmation — prior art `[Schrijver1979]`/`[Lovasz1979]`, a measured instance; the autocorrelation LP transplant — partly prior art (`[KMOR2016]`, Székely, `[AmbrusEtAl2023]`), an instrument not a standalone theorem); one method rule (the rounding mechanism) |
| **FS-53** | the divisibility theorem for Hoffman-tightness (the advisor, 2026-09-15); G57's `ω`-split/field-exclusion coincidence; G58's derived half (`τ` must fix a colour); "27 is the unique non-prime window member" plus its reciprocity-exclusion completion | **FS53-T1 – T4** (4 theorems, all *closes*) | none demoted; three readings kept out of § B (`χ = ⌈q²/α⌉`, explicitly registered as an open hunch and never promoted; the bias-corrected growth law, scored LOST at the close; the tightness-calibration extrapolation, explicitly non-linear and unclaimed); G58 itself (the antipodal conjecture, existence-flavoured) stays a reading, not re-filed as a conjecture since it was never claimed as a theorem |

Neither milestone is an empty row: both produced theorems outside the kernel.

## Progress and resume

Both milestones of the batch are filed. Batch 6a is complete. The next reader is **6b** (FS-54, FS-56), per
`plans/FS71-theorem-audit.md` §S.6's reader list — no state to resume from this batch beyond the committed derivation
files and § B rows.

## Theorems this phase proved

None — as `plans/FS71-theorem-audit.md` §R's own template expects, the audit's products are demotions, re-attributions and
an index. The one new finding this phase made **outside the audit's own object** — the `GarciaMarcoKnauer` (the old yearless key) miscitation in
G58 (arXiv:2303.06262 is `[CervantesKrebs2023]`'s paper; the real García-Marco–Knauer paper on this subject is
arXiv:2405.19543) — is a bibliographic correction, not a mathematical theorem, and is filed as such (§ "Proposed edits").

## Proposed edits to CLAUDE.md

| # | exact current sentence | proposed sentence | reason |
|---|---|---|---|
| 1 | (G58, § Grokkings) `"and the abelian-Cayley colouring literature (\`GarciaMarcoKnauer (yearless, old)\`, arXiv:2303.06262) works on χ, not on invariance;"` | `"and the abelian-Cayley colouring literature (\`[GarciaMarcoKnauer2024]\`, arXiv:2405.19543) works on χ, not on invariance;"` | **miscitation, found and verified live** (`arxiv.org/abs/2303.06262` is Cervantes–Krebs's *Chromatic numbers of Cayley graphs of abelian groups: a matrix method*, already held as `[CervantesKrebs2023]`; the actual García-Marco–Knauer paper on Cayley-graph colouring is *Coloring minimal Cayley graphs*, arXiv:2405.19543, verified via `arxiv.org/abs/2405.19543`). The bibliography key also needs the year suffix `2024` to match this project's naming convention and to be visible to `tools/bib_audit.py`'s citation regex (`\[([A-Z][A-Za-z]+\d{4}[a-z]?)\]`) — `GarciaMarcoKnauer` (the old yearless key) with no digits is invisible to that regex, which is *why* the miscitation passed every prior `bib_audit.py` run silently: the tool never saw the citation at all. `BIBLIOGRAPHY.md` § A now carries the corrected entry, listing only |

No other correction is proposed: every other clause of G56, G57, G58 and row 68/row 69's ledger text was checked against
its source file and found to state exactly what the source supports.

## Where the brief was wrong

1. **G59 is not derivable from any FS-50 or FS-53 file, and does not belong in this batch.** The brief's seed text (plan
   §G.2, row 69) asks for "G59: the normalisation `c = α/q^{3/2}` and the threshold `√q/6`… the Fourier-energy bound at
   64… 'the wall is finite' (a derived corollary of the certificates)" to be filed here. None of these numbers, this
   normalisation, or the `U₆₄` Fourier-energy argument appear anywhere in `plans/STUB-sixth-colour.md`,
   `plans/POROS-2026-09-15-fs53-planning.md`, or any `data/fs53/*.md` file — I grepped for `c(19)`, the specific `c`
   values (`0.756`, `0.767`, `0.918`, …), `√q/6`, `50.2`, and "Fourier energy" across the whole batch's file list and found
   nothing. `data/fs53/CLOSE.md` (2026-09-16) explicitly lists FS-53's own grokkings as **"G56, G57, G58"** — three, not
   four — confirming G59 was minted later. A targeted search located "the wall is finite and fractional" in
   `plans/FS54-twenty-seven.md` and `plans/SESSION-HANDOFF-2026-09-16-fs54.md` (FS-54's own material, batch 6b's), and
   `CLAUDE.md`'s own G59 text carries an internal date, **"2026-09-18"**, for its normalisation half — two days after
   FS-54's close and outside any milestone this batch's brief names. G59 belongs to whichever batch covers that
   2026-09-18 session (possibly FS-57, `plans/STUB-fractional-wall.md`, still an open, never-run stub per
   `CLAUDE.md`'s ranked-stubs table — so G59's material may in fact have no plan file at all, the same situation the
   brief itself flags for G63/G64 under `plans/FS62-derivation.md`). I have filed nothing under G59's name; a later
   batch should locate the actual 2026-09-18 session record (not found under `plans/` or `data/` by the searches run
   here) before filing it.
2. **The field-naming table in `data/fs53/window.md`** ("What each member would buy: the field it hands us") is presented
   in the CURRENT file as post-FS-54-correction content (`ℚ(√167)`, `ℚ(√4703)`, etc.), with FS-53's own original attempt
   (`ℚ(√2,√31)` etc.) explicitly marked superseded in the same file ("Correction record (FS-54)"). Since `window.md` is a
   current-state-only record like `CLAUDE.md`, reading it naively would credit the corrected table to FS-53; I have not
   filed the field-naming table as an FS-53 theorem (it is FS-54's, batch 6b's), and FS53-T4 only covers what is
   genuinely FS-53's own finding (27's unique-non-prime status and its reciprocity-exclusion line) — the brief's phrasing
   ("'27 is the unique non-prime member' — derived") matches this cleanly, but the surrounding field-table context in the
   same brief paragraph is partly about FS-54 material and should not be read as assigning that table to this batch.
3. **The brief's row-68 seed correctly anticipated the theorem count and shape** (soundness, block-diagonalisation,
   ϑ=Hoffman as a measurement, the rounding mechanism as method, the L(K(√7))=7 consequence) — no correction needed there,
   though the actual soundness/block machinery split naturally into five hand theorems (T1–T5) rather than one, once the
   underlying files (`plans/FS50-certificate-soundness.md`'s seven sections, the STUB's §S4 D8/D8′, the README's "real
   block form" section) were read as proofs rather than summarised from the ledger row alone — each is a materially
   distinct claim with its own proof and its own reachable negative control, and FS-38's precedent (seven related
   theorems D1/D2-A/D2-B/L1-L3/D3 under one milestone) is the model followed.

## The enumeration

**Read in full:** `plans/FS50-certificate-soundness.md` (233 lines); `plans/FS50-prior-art.md` (107 lines);
`plans/STUB-independence-threshold.md` (567 lines); `plans/POROS-2026-09-14-fs50-planning.md` (438 lines);
`plans/POROS-2026-09-15-fs53-planning.md` (438 lines); `data/fs53/window.md` (211 lines); `data/fs53/CLOSE.md` (86 lines);
`data/fs53/g58/README.md` (65 lines); `Proofs/HadwigerNelson/Instances/IndependenceThreshold.lean` (through the three
consumer theorems); `Proofs/HadwigerNelson/CayleyCertificate.lean` (header, cost-model comments and every `theorem`/
`lemma` signature — confirmed all kernel, row 69's own line, nothing hand hiding there).

**Read at length, not cover to cover:** `data/fs50/README.md` (521 lines; §§1–100 and 195–340 read closely for the
certificate mechanism and the real-block-form derivation, the remainder — mostly SCS/backend timing logs and rounding
trajectories — scanned for the theorem/derivation pattern set and found to hold nothing further); `data/fs53/README.md`
(363 lines; read in full per the brief, structured as run-records rather than derivations — no additional theorem
candidates beyond what §§ above capture); `plans/STUB-sixth-colour.md` (1,202 lines; §S4 "Derivations that fix the
shape" at lines 435–498 and the G57 material at lines 640–730 read closely; the remainder covered by
`rg -n -i` for `theorem|lemma|proposition|corollary|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|
iff|if and only if|exactly when|conjecture|not claimed`, every hit's neighbourhood opened).

**Grepped (pattern above) and read at every hit's neighbourhood, no theorem-shaped content found beyond what the theorems
above already cite:** `data/fs53/PHASE-A0.md`, `PHASE-A.md`, `PHASE-B.md`, `PHASE-K1K2.md`;
`plans/SESSION-HANDOFF-2026-09-15-fs53.md`, `plans/SESSION-HANDOFF-2026-09-15.md`.

**Docstrings only, per the brief:** `tools/fplane_cert_check.py`, `tools/fplane_cert_round.py`,
`tools/fplane_sdp_blocks.py`, `tools/fplane_sat_cube.py` (the last carries no FS-50/FS-53 mathematical content — a
generic cube-and-conquer SAT harness, its docstring's claims already covered by `CLAUDE.md`'s standing symmetry-breaking
rule, not this milestone's).

**Skipped, with reason:** the `data/fs50/{ckpt,maxsat,nscale,race19,race23,wo18}/` and `data/fs53/{ckpt,controls,g58,
ledag,runs}/` subdirectories' individual JSON/log files — these are raw run records the README/window/CLOSE files above
already summarise with their theorem-relevant content extracted; opening them adds provenance, not mathematics, and the
brief's own budget note (~350k tokens against a 550 KB assignment) argues against reading raw JSON. `Proofs/HadwigerNelson/LocalGlobal.lean`
was grepped (not read in full) for the three kernel lemma names cited in FS50-T1's rests-on-it chain, all confirmed present
and kernel.

## Web lookups (for the bibliography finding)

`arxiv.org/abs/2303.06262` (confirms Cervantes–Krebs) and `arxiv.org/abs/2405.19543` (confirms García-Marco–Knauer,
*Coloring minimal Cayley graphs*) — both fetched live 2026-09-23 to resolve the G58 miscitation; a `WebSearch` for
"Garcia-Marco Knauer chromatic number Cayley graph abelian group arxiv" located the candidate before the fetch confirmed
it.

## Gates run

`python3 tools/fs71_ledger_b_check.py` — PASS, 197 rows, 0 placeholders, both files' entries parse cleanly (one header-wrap
defect in the first draft of FS53-T2, caught and fixed before this report — the grade bracket's nested `[Krebs2022]`/
`[Vinh2008]` citations were stripped of their own brackets per the checker's known pitfall, and the header was joined onto
one physical line). `python3 tools/claude_md_fact_audit.py --base 76094e8d3bda85deae54e38f58af10bafa947fa3` — AUDIT PASSED
(0 failures; the only delta is `LEDGER.md` § B's +2,850 bytes, the ten new rows). `python3 tools/check_architecture.py` —
RESULT: PASS (pre-existing warnings only, none touching this batch's files). `python3 tools/bib_audit.py` — every arXiv id
and bracketed key resolves, including the new `[GarciaMarcoKnauer2024]`.

## Acceptance checklist (self-scored; the owner scores independently per §S.5)

- Every grade-tagged clause of rows 68–69 accounted for: yes (census table above; G56/G57/G58 filed, G59 explicitly
  declined with the reason).
- Every file in the brief's enumeration appears in "The enumeration" above: yes.
- Every filed entry has all seven fields (id/title/grade, statement, Proof, Proof verdict, Rests on it, Prior art,
  Kernel): yes, checker-verified (no "lacks" warnings on any `FS50-T*` or `FS53-T*` entry).
- Bibliography keys added: `[GarciaMarcoKnauer2024]`, listing only.
- Commits: one per milestone-file plus the shared-file commits, by explicit path (see the commit log).
