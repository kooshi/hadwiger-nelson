# FS-71 batch 6b — the theorem audit of FS-54 and FS-56

*Implementer's report, 2026-09-23. Milestones: FS-54 (five refused at 27; the 2-adic trichotomy; the wall made finite and
fractional — row 70) and FS-56 (ℚ(√167); the fractional blow-up over fields; χ_f(K²) = 4 — row 71), with G54, G56, G59 and
G60's clauses named in the brief. Produced: `plans/FS54-derivation.md` (11 theorems), `plans/FS56-derivation.md` (7
theorems), 18 `LEDGER.md` § B rows. No agent of any kind was started; every read and every write in this batch is mine.*

## Headline

**FS-54 + FS-56: 18 theorems filed in 2 files, 1 attribution correction found (the odd-degree corollary is
`[Moorhouse2010]` §7.1, proposed to CLAUDE.md and LEDGER.md row 70), 0 demoted (gap); enumeration complete.**

## Census table

| milestone | candidates found | filed as | classified as kernel/measurement/reading/instance/prior-art/conjecture |
|---|---|---|---|
| **FS-54** | the L3 certificate's soundness argument (F1–F7, Y1–Y4, the identity `(★)`); the 2-adic trichotomy plus the odd-degree corollary; the general `UD(𝔽_{3^f},2)` structure (collinear triangles, `λ≡1 mod 3`, `λ_min=−8` at 27); the degree-≥6 field theorem; `W_f` (χ_f=n/α, no rounding, CRT-product closure, credited GPT Astra); `U₃₂`'s rigidity (44 hyperplanes, credited GPT Astra); the inert-tower `λ_min/d` invariance (credited GPT Astra, partly MMST1998); the conditional derivation "if W and the conjecture, χ(ℚ(√167)²)≥6"; the symmetric-search reduction (Cauchy's theorem); the `U₆₄` period-obstruction bound (≤512, independently reproved by GPT Astra as R2.4); the `U₆₄` Fourier-energy stability bound (≥50.2%) | **FS54-T1 – T11** (11 theorems, all *closes*) | none demoted; several readings/measurements kept out of § B (the "117 is a strong attractor" reading; the exhaustive subspace-periodic search's own scope limit; the ratio-bound "integrality gift" comparative observation; the χ=⌈n/α⌉ rounding assertion, explicitly flagged as unproved by GPT Astra's own correction; the §D4-at-47 pricing estimate); the "five errors" (`reference/wall-at-six/responses/2026-09-16-poros-fractional-wall.md` § "Corrections that matter") recorded as demotions of *our own text*, not filed as theorems — three already self-corrected within FS-54's own session, one (item 3) a mis-transcription with no project claim at fault |
| **FS-56** | congruences-are-isometries (B1); the field-internal blow-up (B2, MRVZ Thm 1 transcribed); `χ_f(K²)=4` and the 1/4 independence ratio (B3, re-verified by our own checker); the class-sum certificate's weak duality lemma; the fractional-route cap (`χ_f(F²) ≤ min(4.36, usable-place χ_f)`); the DuczVarga2026 consistency check (B4); the checker's three soundness obligations (grouping, branch-and-bound, multiquadratic arithmetic) | **FS56-T1 – T7** (7 theorems, all *closes*) | none demoted; several readings kept out of § B (the ratio-bound reading R-C, explicitly self-labelled `[reading]` with its own killing test, minted as FS-58 R1; the local character-mean table, explicitly readings; the small-height `ℚ(√167)²` computations, negative evidence behind a design decision, not a general claim); Q1 (χ_gf>3 over ℚ(√167)) explicitly **not landed** — recorded as an open question carried to FS-58, never claimed |

Neither milestone is an empty row: both produced theorems outside the kernel.

## Progress and resume

Both milestones of the batch are filed. Batch 6b is complete. The next reader is **6c** (FS-58, FS-62/G63/G64), per
`plans/FS71-theorem-audit.md` §S.6's reader list — no state to resume from this batch beyond the committed derivation
files and § B rows.

## Theorems this phase proved

None — as `plans/FS71-theorem-audit.md` §R's own template expects; the audit's products are demotions, re-attributions and
an index. The one finding outside the audit's own object — the Moorhouse2010 §7.1 attribution for the odd-degree
corollary, already present in `BIBLIOGRAPHY.md`'s own row but absent from `CLAUDE.md` G56 and `LEDGER.md` row 70's text —
is a bibliographic correction, not a mathematical theorem, filed below.

## Proposed edits to `CLAUDE.md`

| # | exact current sentence | proposed sentence | reason |
|---|---|---|---|
| 1 | (G56, § Grokkings, line 891) `"and **every field of odd degree is 2-colourable** (some prime above 2 has odd local degree, so i is not in that completion and it ramifies; the reciprocity form, and the wall as a ramification set, are in G35)."` | `"and **every field of odd degree is 2-colourable** (some prime above 2 has odd local degree, so i is not in that completion and it ramifies; the reciprocity form, and the wall as a ramification set, are in G35 — the sharp odd-degree statement itself is `[Moorhouse2010]` §7.1, found by that paper's own `BIBLIOGRAPHY.md` row and not previously credited here)."` | **found at this gate, per `plans/FS71-theorem-audit.md` §PA.2's own instruction**: `BIBLIOGRAPHY.md`'s `[Moorhouse2010]` row already states, and has stated since an earlier read, "§7.1: odd-degree number fields have χ(K²) = 2, by a residue colouring at a prime above 2 through the trace of `𝔽_{2^f}`" — the exact odd-degree ⟹ 2-colourable fact G56 states with no citation. `plans/FS71-theorem-audit.md` §PA.2 flagged this explicitly: "row 70's '[proof] every odd-degree real field is 2-colourable' and G56 must cite Moorhouse §7.1 (batch 6 files it; the owner edits G56 at the close)" |

## Proposed edit to `LEDGER.md` row 70 (parallel to the `CLAUDE.md` edit; the owner applies both together)

| exact current text | proposed text | reason |
|---|---|---|
| `"...inert gives U_Q — **every odd-degree real field is 2-colourable**; U_Q is 4-colourable for Q ≤ 32..."` | `"...inert gives U_Q — **every odd-degree real field is 2-colourable** (`[Moorhouse2010]` §7.1); U_Q is 4-colourable for Q ≤ 32..."` | same as above — row 70's own text states this fact with no citation, and `BIBLIOGRAPHY.md`'s held row already supplies one. I did not apply this myself: row 70 is `LEDGER.md` § A prose (current-state-only, curated), which I treat like `CLAUDE.md` rather than editing directly, since only § B lines are named as mine to write directly in the brief |

No other correction is proposed: every other clause of row 70, row 71, G54, G56, G59 and G60's text was checked against
its source file (`plans/FS54-twenty-seven.md`, `plans/FS54-L3-certificate-soundness.md`,
`reference/wall-at-six/responses/`, `plans/FS56-field-blowup.md`, `plans/FS56-quadratic-167.md`) and found to state
exactly what the source supports.

## Where the brief was wrong

1. **The brief's phrase "27 explained: every edge in exactly one collinear triangle, λ = 3m − 14; |Aut| = 122,472 —
   derived/computed: classify" undersold the generality actually proved.** `plans/FS54-twenty-seven.md` §1.1–1.2 states
   and proves the collinear-triangle decomposition and the `λ ≡ 1 (mod 3)` congruence **for every `q = 3^f` with `f`
   odd**, not only at `q = 27` — 27 is the *instance* the milestone builds on, but the argument is general (filed as
   FS54-T3, general in `f`, tested at `f=3`). A reader following the brief's literal wording might file only the
   `q = 27` numbers; the underlying theorem is stronger and is filed as such.
2. **The brief's seed line for row 70 lists "L3 certificate soundness (FS54-L3-certificate-soundness.md) — hand
   theorems" as a single item; it is one theorem (the soundness chain culminating in `s ≤ N`), not several**, once the
   supporting facts (F1–F7, Y1–Y4) are read as *lemmas within one proof* rather than independent claims — unlike FS-50's
   comparable soundness page, which batch 6a correctly split into five materially distinct theorems (soundness,
   always-achievable multiplier construction, block reformation, real-block reduction, commutant block sizes), FS-54's
   page has only one end-to-end argument with no separately reusable sub-result — filed as one theorem, FS54-T1.
3. **The brief did not mention the `U₆₄` period-obstruction bound or the Fourier-energy stability bound** (found in
   `data/fs54/char2/README.md`, dated within FS-54's own 2026-09-16 session, predating the outside review) as separate
   candidates — the brief's seed text for row 70 only names "U₆₄ probed: |Aut| exact, ϑ′=Hoffman=768, KaMIS 512..." as
   a `[exact]/[found]/[proof]` bundle in FS54-twenty-seven.md's closing table, without flagging that two of those bundled
   claims are independently provable theorems (one proved twice, once by us and once by GPT Astra). Filed as FS54-T10 and
   FS54-T11 per the audit's own rule (a milestone's ledger row is the seed; the files are read for what the row compressed
   away, `plans/FS71-theorem-audit.md` §S.4).
4. **The brief did not name the symmetric-search reduction lemma** (Cauchy's theorem applied to prime-order stabiliser
   classes, `plans/FS54-twenty-seven.md` §M/§O) as a candidate. It is a genuine, self-contained hand theorem underlying
   FS-54's own D2 search design and is filed (FS54-T9), on the same judgment batch 6a applied to FS53-T1 (an elementary
   but genuinely useful fact, not separately searched in the literature for the same reason FS53-T1 was not).
5. **The brief's phrase "the five errors the outside readers found in our text" is exactly the five items** in
   `reference/wall-at-six/responses/2026-09-16-poros-fractional-wall.md` § "Corrections that matter to the dispatch" —
   confirmed by reading both response files in full; `plans/FS54-twenty-seven.md` §R's verdict table (R1.a–g, R2.1–2.7)
   has more rows (12), but only five of them are corrections of *our own claims* (the rest are confirmations of claims we
   never doubted, or findings about the literature, such as the `[Tardif2023]` re-keying). Recorded as such under
   "Corrections to our own claims" in `plans/FS54-derivation.md`.
6. **`reference/wall-at-six/WALL-AT-SIX.md` itself (58 KB, "the text sent to outside advisors") was not read in full.**
   It is the *question* document; every claim it makes is checked, clause by clause, against the two response files in
   `plans/FS54-twenty-seven.md` §R's own verdict table, and the actual mathematical content (the proofs) lives in the
   responses, not in the question document. Reading the two responses in full (716 lines together) and cross-checking
   against §R's table gave complete coverage of what changed; the 58 KB of the original document would have been mostly
   redundant with what its own project record already summarises. Flagged explicitly here per the enumeration discipline.
7. **Otherwise the seed was accurate.** Every candidate named in `plans/FS71-theorem-audit.md` §G.2's batch-6 target line
   for rows 70–71 was found and filed, or classified with a reason (G59's normalisation and Fourier-energy-at-64 material,
   named in the seed alongside W_f, is **not** in either FS-54 file — confirmed absent by grep, consistent with batch
   6a's finding that G59 dates to 2026-09-18, two days after FS-54's close, and belongs to a different, still-unlocated
   session; not filed here for the same reason batch 6a declined it).

## The enumeration

**Read in full:** `plans/FS54-twenty-seven.md` (535 lines); `plans/FS54-L3-certificate-soundness.md` (229 lines);
`reference/wall-at-six/responses/2026-09-16-algebraic-mechanisms.md` (551 lines); `reference/wall-at-six/responses/2026-09-16-poros-fractional-wall.md`
(165 lines); `data/fs54/README.md` (short); `data/fs54/char2/README.md` (32 lines); `data/fs54/d4/README.md` (short);
`plans/FS56-field-blowup.md` (98 lines); `plans/FS56-quadratic-167.md` (400 lines); `data/fs56/README.md`,
`data/fs56/q0/RESUME.md` (short).

**Read closely (specific sections), not cover to cover:** `plans/FS54-D4-pricing.md` (301 lines: §§1–3, the earlier draft
of the L3 soundness argument now superseded by the soundness page — read to confirm it is the same theorem in an earlier
form, not a distinct one; the rest of the file — §§4–7, the pricing and sizing measurements at 47 — grepped and confirmed
measurement-only, no additional theorem-shaped content).

**Grepped (the §S.4 pattern:
`theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|we prove|proof:|
QED|∎|iff|if and only if|exactly when|for every|for all|conjecture|not claimed`), every hit's neighbourhood read, no
additional theorem-shaped content found beyond what the theorems above already cite:** `plans/STUB-twenty-seven.md`
(confirmed superseded by `plans/FS54-twenty-seven.md` §4 — every candidate line traced to content already filed or
already classified); `plans/STUB-quadratic-167.md` (confirmed superseded by `plans/FS56-quadratic-167.md` §3–§5);
`data/fs54/environment.md`, `data/fs54/symmetric/RESUME.md`, `data/fs54/ladder/RESUME.md`, `data/fs54/d4/runs/RESUME.md`
(run records only); `plans/SESSION-HANDOFF-2026-09-16-fs54.md`, `plans/SESSION-HANDOFF-2026-09-16-fs56.md` (session
handoff notes, confirming rather than adding to the material above).

**Docstrings only, per the brief:** `tools/fs54_l3_cert_check.py`, `tools/fs54_wall_feedback_verify.py`,
`tools/fs56_gf_check.py` — each read for its stated claim and soundness boundary (used to corroborate FS54-T1's and
FS56-T7's statements), not for its implementation.

**Skipped, with reason:** `reference/wall-at-six/WALL-AT-SIX.md` (58 KB) — per "Where the brief was wrong" item 6 above,
its content is fully covered by the two response files plus `plans/FS54-twenty-seven.md` §R's own clause-by-clause
verdict table checking it against them; `reference/wall-at-six/responses/verify_dyadic_norm_graphs.py` (163 lines) —
the response's own reproducible-check appendix, referenced but not independently re-run (no solver in this batch, per
the brief); `data/fs54/{char2-residue.out, cert-q*-l3-N*.json, d4/ckpt/, d4/q47/, kamis-smoke/, periodic-alpha-q27.json,
structure.out, quadratic-fields.out, fields.out, wall-feedback/}` — raw run outputs and certificate files, whose
theorem-relevant content is already extracted and cited by the README/derivation files above; `data/fs56/{g27/,
local-ratios.out, q0/, q1/}` — same rationale, raw certificate/search outputs.

## Web lookups (prior-art gate)

zbMATH Open API queries, each run and recorded with its hit count in the individual theorem entries:
`ab:"semidefinite" & ab:"independence number" & ab:"finite field"` (0), `ti:"chromatic number" & ab:"real quadratic
field"` (0), `ab:"fractional chromatic number" & ab:"unit distance graph"` (4), `ab:"Cayley graph" & ab:"norm one" &
ab:"finite field" & ab:"chromatic"` (0), `ti:"Hoffman bound" & ab:"tower" & ab:"eigenvalue"` (0), `ab:"unit circle" &
ab:"finite field" & ab:"Sidon"` (0), `ab:"norm one" & ab:"finite field" & ab:"hyperplane"` (0), `ti:"chromatic number of
the plane" & py:2020-2026` (10, all this project's own known neighbours), `ab:"Paley graph" & ab:"level 3" &
ab:"semidefinite"` (0), `ab:"quadrance" & ab:"finite field"` (4, this project's own held Krebs2022/Moorhouse2010-adjacent
neighbourhood). No new paper was found by any of these queries; `BIBLIOGRAPHY.md` was not touched (no new listing-only
row was warranted — every citation used in this batch's entries was already held).

## Gates run

`python3 tools/fs71_ledger_b_check.py` — RESULT: PASS (215 theorems in 48 derivation files, 215 § B rows, 0 placeholders;
the only warnings are the pre-existing FS-70 and M18-T1 ones the brief names as known). `python3
tools/claude_md_fact_audit.py --base 4a82e10bbdb54d92d10d43cc4e7faba1a1dded53` — AUDIT PASSED (0 failures; the only delta
is `LEDGER.md` § B's +4,999 bytes, the eighteen new rows). `python3 tools/check_architecture.py` — RESULT: PASS
(pre-existing warnings only, none touching this batch's files). `python3 tools/bib_audit.py` — every arXiv id and
bracketed key resolves; no bibliography row was added or changed by this batch.

## Acceptance checklist (self-scored; the owner scores independently per §S.5)

- Every grade-tagged clause of rows 70–71 accounted for: yes (census table above; the odd-degree/Moorhouse attribution
  proposed to both `CLAUDE.md` and `LEDGER.md`; G59's material explicitly declined with the reason, confirming batch 6a's
  finding).
- Every file in the brief's enumeration appears in "The enumeration" above: yes.
- Every filed entry has all seven fields (id/title/grade, statement, Proof, Proof verdict, Rests on it, Prior art,
  Kernel): yes, checker-verified (`tools/fs71_ledger_b_check.py` prints no "lacks" warning on any `FS54-T*`/`FS56-T*`
  entry — two header-wrap defects and two mislabelled `*Proof.*`/`*Proof:*` markers were caught and fixed before this
  report by running the checker against a first draft).
- Bibliography keys added: none (every citation used was already held).
- Commits: one per milestone-file plus the shared-file commits, by explicit path (see the commit log).

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read directly
by this agent, and both derivation files, both sets of `LEDGER.md` § B rows and this report were written directly by
this agent.
