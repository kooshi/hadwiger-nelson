# RK report — the ranking pass, 2026-09-27

**What this job was.** The project keeps a ranked list of 64 possible next pieces of work ("stubs"), each with a line saying how it bears on
the answer. The authoritative list is `plans/FRONTIER-STUBS.md`; `CLAUDE.md` § Paths forward mirrors its top 29. Until today, rows 4–64 still
stated their bearing against the old target, "six colours". Since 2026-09-26 the aim is the answer itself: decide how many colours the plane
needs (5, 6 or 7), then check every step in Lean. The direction toward it is "the regularity wall" (`CLAUDE.md` § The aim, links 1–6). This
job restated all 61 bearings against that aim, moved the rows whose honest bearing changed, and mirrored the result. Ranks 1–3 were not
touched (Kooshi approved them this morning).

**Commits:** `34b96b56` (RK: stage 1, the data and the script), `c3374191` (RK: stage 2, the list and the record), `48fa9614` (RK: stage 3,
the mirror, the audit lines, the check), each pushed; this report is stage 4. **The record:** `plans/RERANK-2026-09-27.md` (every bearing
before and after, the moves, the stub files owed, the gates).

## The moves (4 explicit; 10 rows shifted by insertion; ranks 1–3 and 20–64 unchanged)

| stub | was → now | reason, one line |
|---|---|---|
| FS-44, the shape of a five-colouring of the plane | 15 → 6 | ledger row 131 now states its question exactly, and a *yes* decides the answer (exactly five colours) with no extra hypothesis; it is the other side of rank 3's question |
| FS-80, averaged certificates at five colours | 10 → 7 | the one row on the kind of proof a lower bound of six must be (how colour classes fit together, not how big each is); the field-level rows it sat below reach the answer only through the plane |
| FS-101, the Lean port of the measure-rigidity chain | 19 → 8 | the one row that puts link 1 (the reduction of the plane to a measurable question, given measure rigidity) into Lean; any lower bound above five proved that way needs it, and the aim counts formalization as part of the answer |
| FS-102, the fallback write-up | 9 → 16 | its bearing on the answer is none, and the 2026-09-26 rule "nothing is published before it is formalized in Lean in full" puts it behind its own formalization |

Shifted down by insertion only: FS-62, FS-67, FS-59, FS-96, FS-64, FS-63, FS-49 (three places each) and FS-69, FS-57, FS-100 (one place).

**What the rewritten bearings say, in short:** the plane-level rows (FS-109, FS-108, FS-44, FS-80) bear directly; the Lean rows bear on
the formalization only when the answer goes through measure rigidity; every row about a particular number field (ℚ(√167) and its cluster)
reaches the answer only through the plane, because a lower bound at a field is one on the plane but an upper bound at a field is not, and
given measure rigidity the plane is attained at fields where every prime mixes (ledger row 128); most rows from 17 on are "none on the
answer", with their own value (field-level, mechanism, trust, a question posed in print) kept beside it. Every grade and every
soft-as-to-truth warning was kept.

## Byte counts

`CLAUDE.md`: **299,438 before, 295,695 after** (−3,743 bytes; budget 300,000). Only § Paths forward changed (16,503 → 12,760): ranks 4–29
shortened to a short question and bearing each, pointing at `plans/FRONTIER-STUBS.md` for the full text; ranks 1–3, the grouped row 30–64,
every protected paragraph and every other section byte-identical.

## Gates (each exit status read directly)

| gate | result |
|---|---|
| `tools/claude_md_fact_audit.py --base 24974367` (the launch HEAD) | **PASS**. 14 tokens left `CLAUDE.md` with the shortened cells; each is an external-home line (not an ALLOW line) verified on every run to be in `plans/FRONTIER-STUBS.md`, reason: "the paths-forward row of FS-nn (rank r before RK), shortened in CLAUDE.md at the ranking pass; its row in plans/FRONTIER-STUBS.md is authoritative and keeps it". The tokens: `J47`, `116–118`, `4′` (FS-100); `Y1`, `HD1-cert's` (FS-90); `(3)'s`, `μ_min` (FS-67); `06:5x` (FS-101); `10⁻⁴` (FS-109); `112–113`, `116–117` (FS-64); `PL(23` (FS-96); `R1's` (FS-44); `T-J39-5` (FS-59) |
| `--dupes` | **10** repeated runs, the same 10 as before (limit 10) |
| `tools/bib_audit.py` | **FAIL, not from this job**: two items cited by FS-110's files are not yet in the bibliography — `arXiv:1305.5229` (`data/fs110/reports/FS110-P.md`) and `[MartiniMontejanoOliveros2019]` (`plans/FS110-tangency-seam.md`, commit `da30b513`). Every key this job cites resolves. Owed to FS-110's close |
| `tools/check_architecture.py` | **PASS** |
| the mirror check I wrote, `data/rerank-2026-09-27/rk_mirror_check.py` | **PASS** (one row per rank 1–29 with the same stub as the list; the grouped row 30–64 in rank order); `--self-test` **PASS** (a faithful copy passes; six planted faults each fire and name the culprit). Run against the launch HEAD it **fails**, correctly: the old mirror labelled two pairs of rows with one rank each (21, 21 and 25, 25), fixed here |

## Stub files owed a later pass (not rewritten, per the brief)

Headed "Bearing on χ ≥ 6" (or "on χ(ℝ²) ≥ 6"): `plans/STUB-tight-product-colourings.md`, `STUB-writeup-main-clause-five.md`,
`STUB-window-frequency-certificate.md`, `STUB-certificate-at-43.md`, `STUB-measure-rigidity-three-fields.md`,
`STUB-five-colour-rigidity-table.md`, `STUB-three-colour-criterion-kernel.md`, `STUB-four-colour-inheritance.md`, `STUB-de-grey-chain-kernel.md`,
`STUB-tower-never-rises.md`, `STUB-last-lattice.md`, `STUB-kr6.md`, `STUB-literal-ring-mixon.md`, `STUB-padic-distance-classification.md`,
`STUB-field-level-criteria.md`, `STUB-expansion-measure.md`. A paragraph opening "Bearing on χ ≥ 6": `STUB-four-colours-167.md`,
`STUB-adelic-window-colouring.md`, `STUB-fractional-wall.md`, `STUB-main-clause-five-kernel.md`, `STUB-character-classification.md`,
`STUB-quadratic-witnesses-kernel.md`, `STUB-pyjama-gluing.md`, `STUB-one-prime-minimal-sets.md`, `STUB-theorem-B-writeup.md`,
`STUB-consolidation-remainder.md`, `STUB-vacuity-coverage.md` (and the first file above). The scan read only lines opening with "Bearing".

## Decisions I settled (each is Kooshi's to reverse)

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| FS-44 up to 6 | leave it at 15 ("low as work until a statement exists") | the statement now exists (row 131 at five colours), and its *yes* is the answer | medium — if Kooshi reads it as a sub-question of rank 3, it folds there |
| FS-101 up to 8 | keep it at 19 beside FS-100 | formalization is part of the aim, and this is the only row carrying link 1 into Lean | medium — if the Lean lane should wait until the direction picks its route, it goes back down |
| FS-102 down to 16 | keep it at 9 as the named fallback | bearing none, and the publication rule defers it | medium — it is Kooshi's fallback, his call |
| Keep the ℚ(√167) cluster (FS-62, FS-59, …) together at 9–15 | demote it below the "none" rows | a six there still narrows the answer by a value; minimal churn | medium |
| Keep FS-49 (a finite six-chromatic graph) in place | demote it under Kooshi's "a finite witness for six is out as a route" | ranked by bearing (a lower bound of six with no extra hypothesis); the ruling is quoted in the cell | medium |
| Leave ranks 1–3's mirrored cells unshortened | shorten them too for bytes | approved this morning; the file shrank enough without them | high |

**Noted for the owner, not decided:** no row carries measure rigidity *in full* in Lean, the first item of the aim's Lean program (FS-101
keeps it as a named hypothesis) — a stub for it is Kooshi's call; and text outside this job's scope is still framed on six: `CLAUDE.md`
§ Where the problem stands items 28–30 ("Bearing on χ ≥ 6"), and `plans/FRONTIER-STUBS.md`'s open-milestones column and ranking-rule sentence.

**If you do nothing:** the new order stands, and FS-110's close edits both files on top of it.
