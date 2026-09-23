# FS-71 batch 6c — the theorem audit of FS-58, the FS-62 measurements, and the G63/G64 conversations

*Implementer's report, 2026-09-23. Milestone: FS-58 (the 3-adic barrier; four colours over real quadratic fields — rows
72–73). No-milestone material: the FS-62 measurements (`data/fs62/`, `tools/fq_chi.py`) behind G59, G63 and G64, and the
2026-09-17/18/19 conversations those grokkings record. Produced: `plans/FS58-derivation.md` (9 theorems),
`plans/FS39-derivation.md` (1 theorem, filed at G63's stub home), `plans/FS62-derivation.md` (6 theorems, filed at G64's
and G59's shared home), 16 `LEDGER.md` § B rows. No agent of any kind was started; every read and every write in this
batch is mine.*

## Headline

**FS-58 + FS-62/G63/G64: 16 theorems filed in 3 files, 0 re-attributed (2 already-correct attributions confirmed by
re-checking, not edited), 1 demoted (the S ⟺ W claim's already-recorded withdrawal, re-verified and cited); enumeration
complete.**

## Census table

| milestone / conversation | candidates found | filed as | classified as kernel / measurement / reading / instance / prior-art / conjecture |
|---|---|---|---|
| **FS-58** | the 3-adic barrier D1 (**kernel already**, row 72); the split 3-adic tower's tightness (D2, two halves — a hand estimate and a tools-grade exhaustive check); the periodic-rigidity factorisation (D3.4, corrected once, closing only half); the finite/infinite forcing dichotomy by compactness (D3.5); the direction-set quotient screen (D3.7); the distance-2-to-`3u` chaining lemma (D3.8); the pigeonhole-forcing lemma generalised from Wormald (D7); five certified `χ ≥ 4` witnesses (R-B5, tools grade — the sixth, ℚ(√11), is **kernel already**, row 73); one hand obstruction stated but not derived on disk (R-B5's `d ≡ 7 (mod 8)` remark) | **FS58-T1 – T9** (9 theorems: 7 *closes*, 1 *closes with an explicit open half* (T3), 1 *unsure* (T9)) | D1 and the `ℚ(√11)` witness classified **kernel already**, not refiled (both already carry their own kernel declarations, row 72/73); the tensor-rigidity measurement (§0 O7) and the screens-at-other-places corollary (D5) and the never-run local LP (D6) kept out of § B, filed in FS58-derivation.md's "Readings and measurements" section, the first named **FS-67**'s open target explicitly (G61(2)'s exact warning, confirmed live in this milestone's own text: row 72's "its tensor products... are rigid" states as settled what the plan itself marks "not derived") |
| **FS-62 (the measurements — `data/fs62/`, `tools/fq_chi.py`)** | `fq_chi.py`'s dimension-2/dimension-3 value-set rebuild (χ = 3,4,3,5,5 at q=3,7,9,11,19, plus two new decided values at q=5,13; the dimension-3 probe found nothing informative) | **no theorem** — every candidate here is explicitly a measurement (a general claim checked on a finite sample) or a null result about a probe's own design, never a general claim proved | filed in `plans/FS62-derivation.md`'s "Readings and measurements" section, with the dimension-3 null recorded as "a null about the probe's design, not evidence for the reading" (the record's own words) |
| **G59 (2026-09-18 conversation — `plans/STUB-six-is-not-a-value.md` §2a, `data/fs62/q19/`)** | the independence-number normalisation `c = α/q^{3/2}` and the six-colour threshold `√q/6`; the non-existence of a uniform bound closing 23 given `c(19) ≥ 0.918`; "the wall is finite" (**already filed as `FS54-T5`, batch 6b**); the U₆₄ Fourier-energy bound (**already filed as `FS54-T11`, batch 6b**); FS-65's own supporting SAT/relaxation measurements at q=19 (not this batch's object — FS-65 has not closed) | **FS62-T5, T6** (2 new theorems; 2 candidates found already filed elsewhere, not refiled — see "where the brief was wrong") | FS-65's q=19 material (`data/fs62/q19/*.md`, 622 lines total) read in full and grepped for additional theorem-shaped content beyond G59's four named clauses; one small found item (the fixed-cardinality "`f(k) ≤ N` always" monotonicity fact) explicitly left to FS-65's own eventual audit, since FS-65 is not a closed milestone and is not in the FS-71 reader list |
| **G63 (2026-09-17 conversation — `plans/STUB-plane-bridge.md` §3 D4)** | the transcendence-is-free lemma `χ(F(t)²) = χ(F²)`; the golden-ratio instance `χ(ℚ(φ)²) = 2`; the gap in Fischer's Remark 1 | **FS39-T1** (1 theorem, *closes*) | the golden-ratio instance classified as an **instance** of `FS54-T2` (the 2-adic trichotomy's ramified case), not filed separately; Fischer's Remark 1 gap classified as **prior art already correctly recorded** in `BIBLIOGRAPHY.md`'s `[Fischer1990]` row (found and attributed at FS-61's own gate, 2026-09-19 — checked here, not re-attributed) |
| **G64 (2026-09-17 to 19 conversation — `plans/STUB-six-is-not-a-value.md`, `CLAUDE.md` G64)** | S ⟹ W; the exact biconditional form of W; the S-factoring corollary (χ≤L + the window classification); the three mechanism theorems (prime power / Loeschian / sum-of-two-squares); the norm reading (explicitly not a theorem); **the demotion of the original S ⟺ W claim, already recorded in the stub's own banner, re-verified here** | **FS62-T1 – T4** (4 theorems, all *closes*) | the norm reading filed in "Readings and measurements", per G64's own explicit self-correction ("this is half numerology and is labelled so"); the demotion record filed as part of FS62-T1's entry (its own history), not as a separate demoted-theorem entry, since the withdrawn claim (S ⟺ W) was never itself proved — both original "proof lines" established only S ⟹ W, so there is nothing to demote *as a theorem*, only a claim to correct, which the stub's own banner already did on 2026-09-19 |

No milestone or conversation in this batch is an empty row: every one produced at least one theorem or a positively-recorded null.

## Progress and resume

All four objects of the batch (FS-58, the FS-62 measurements, G63, G64) are filed. Batch 6c is complete. The next reader
is **6d** (FS-61), per `plans/FS71-theorem-audit.md` §S.6's reader list — no state to resume from this batch beyond the
committed derivation files and § B rows.

## Theorems this phase proved

None — as the audit's own template expects; its products are demotions, re-attributions and an index. One finding
outside the audit's own object is worth flagging as a correction, not a theorem: **FS58-T1's one-line "Proof verdict"
gap I filled in while writing the entry** (the hand estimate D2(i)–(ii) closes; the general-level bound's own prior art
— classical stationary-phase/Kloosterman estimates — was flagged "owed" by FS-58's own plan and remains owed here, not
discharged) is a clarification of an existing entry's completeness, not new mathematics.

## Proposed edits to `CLAUDE.md`

None. Every attribution this batch checked against `CLAUDE.md`'s own text (G56/row 70's Moorhouse §7.1 credit, G63's
Fischer 1990 Theorem 6 credit, G64's own S/W framing) was found **already correct** — the corrections this batch might
otherwise have proposed were made by earlier batches (6a found the Moorhouse §7.1 gap; the owner's own 2026-09-19 pass
corrected S ⟺ W to S ⟹ W and wrote the demotion banner into `plans/STUB-six-is-not-a-value.md` directly). This batch's
one substantive finding — **G61(2)'s warning is live in row 72's own text** — is recorded as a finding in the census
table and in `plans/FS58-derivation.md`'s "Readings and measurements" section (FS58-T3's entry), not as a proposed edit:
row 72 already says "its tensor products with the residue planes at 7, 11, 19, 23 are rigid" without a qualifier, when
the underlying plan (`plans/FS58-four-colours.md` §2 D3.4) explicitly marks the general claim "not derived". Whether to
soften row 72's wording is the owner's call — flagged here rather than edited, since `LEDGER.md` § A prose is the
owner's to write, per this batch's own brief (only § B lines are named as mine to write directly).

## Where the brief was wrong

1. **The U₆₄ Fourier-energy bound and "the wall is finite" are already filed, by batch 6b, before G59's 2026-09-18 date
   even makes sense as their source.** The brief's seed line read: *"the U₆₄ Fourier-energy bound (a 683-set must carry
   ≥ 50.2% of its energy on the least eigenspace)... 'the wall is finite'... all derived, their working under
   `data/fs62/`... file them as FS62-Tn."* Checking `plans/FS54-derivation.md` (filed 2026-09-16, batch 6b) found both
   already present verbatim: `FS54-T11` is exactly the Fourier-energy bound (a 683-point set must carry ≥ 50.2% of its
   Fourier energy on the `λ=−15` characters), and `FS54-T5` is exactly `W_f`, the fractional wall with no rounding and
   its CRT-product closure — "the wall is finite" is `W_f`'s own consequence, stated in `FS54-T5`'s own words. **G59's
   text (2026-09-18) restates both; it does not re-derive them** — G59 is a reading session that draws consequences from
   already-proved theorems (the normalisation `c = α/q^{3/2}`, genuinely new, is built *on top of* `W_f`, which is why
   `FS62-T5`'s proof cites `FS54-T5`'s `χ_f = n/α` fact rather than re-deriving it). Filing them a second time under
   `FS62-Tn` would violate the one-home-per-fact rule the audit itself exists to enforce; not done. This is recorded
   explicitly in the census table and in `plans/FS62-derivation.md`'s "Readings and measurements" section.
2. **The brief's phrase "G64's derivations `FS62-Tn`... G63's `FS39-Tn`" undersold how entangled the two conversations
   are.** G63 (`plans/STUB-plane-bridge.md` §3 D4, 2026-09-17) and G64 (`plans/STUB-six-is-not-a-value.md`, 2026-09-17 to
   19) are separate stubs with separate content, but G59's material (2026-09-18) sits **inside** the G64 stub file
   (`plans/STUB-six-is-not-a-value.md` §2a), not in a document of its own — the brief's "also yours" section already
   flagged this ("file them as `FS62-Tn`"), so no re-scoping was needed, but it is worth recording explicitly that
   `plans/FS62-derivation.md` therefore holds two conversations' theorems (G64's and G59's) under one file, which is the
   brief's own instruction, not a deviation from it.
3. **A candidate the brief did not name, found by the grep discipline: `data/fs62/q19/fixedk/README.md`'s
   `f(k) ≤ N` always** ("adding constraints cannot raise a maximum"). A genuine, trivially-true LP-monotonicity fact
   used inside FS-65's own certificate instrument. **Not filed** — it belongs to FS-65's own eventual theorem audit
   (FS-65 has not closed, is absent from the FS-71 reader list `plans/FS71-theorem-audit.md` §S.6, and its `q=19`
   material sits in `data/fs62/` only as supporting evidence for G59, per this batch's own brief scope, "the FS-62
   measurements ... and the stubs those conversations minted").
4. **Otherwise the seed was accurate.** Every candidate named in the brief's §G.2-equivalent seed line for rows 72–73
   and for G59/G63/G64 was found and filed, or classified with a reason. The brief's own file-size estimates matched
   what was on disk (`data/fs58/*.md`: 11 files as stated; `data/fs62/*.md`: 4 files as stated).

## The enumeration

**Read in full:** `plans/FS58-four-colours.md` (624 lines); `plans/FS58-prelude-seven-cycle-gadget.md` (158 lines);
`data/fs58/README.md`, `data/fs58/chain-11/README.md`, `data/fs58/search-167/README.md`, `data/fs58/search-23/README.md`,
`data/fs58/witness-11/README.md`, `data/fs58/witness-191/README.md`, `data/fs58/witness-23/README.md`,
`data/fs58/witness-23/minimal/README.md`, `data/fs58/witness-47/README.md`, `data/fs58/witness-71/README.md`,
`data/fs58/witness-95/README.md` (all 11 files named in the brief, 58 KB total); `plans/STUB-plane-bridge.md` (107
lines); `plans/STUB-six-is-not-a-value.md` (251 lines, including its 2026-09-19 demotion banner and §2a's 2026-09-18
addition); `data/fs62/README.md` (89 lines); `data/fs62/q19/README.md` (280 lines); `data/fs62/q19/HANDOFF.md` (112
lines); `data/fs62/q19/fixedk/README.md` (230 lines); `plans/STUB-quadratic-witnesses-kernel.md` (54 lines, the kernel
target for FS58-T8).

**Read closely (top-level declaration names, `rg "^theorem\|^def"`, not the proofs):**
`Proofs/HadwigerNelson/ThreeAdicBarrier.lean` (confirms `colorable_three_integralDirectionPlane`, row 72's kernel decl);
`Proofs/HadwigerNelson/Instances/SqrtEleven.lean` (confirms `four_le_chromaticNumber_planeOver_eleven` and
`four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem`, row 73's kernel decls). `BIBLIOGRAPHY.md`'s `[Fischer1990]` row
read in full to confirm its existing Theorem 6 / Remark 1 attribution (found already correct, per "where the brief was
wrong" item above's companion note on G63). Mathlib's `.lake/packages/mathlib/Mathlib/Combinatorics/Compactness.lean`
grepped for a `SimpleGraph.Colorable`-specific compactness wrapper (none found — `Finset.rado_selection` and
`Set.Finite.rado_selection` supply the general de Bruijn–Erdős machinery the docstring cites; no direct graph-colouring
wrapper), confirming FS58-T4's kernel-decision field.

**Grepped (the §S.4 pattern), no additional theorem-shaped content found beyond what is filed:**
`plans/STUB-moire-coincidence.md`, `plans/STUB-adelic-window-colouring.md`, `plans/STUB-quadratic-witnesses-kernel.md`
(read in full as a kernel target, above), `plans/STUB-four-colours-167.md` — all four are forward-looking design stubs
for still-open milestones (FS-59, FS-60, FS-63, FS-64); none has proved anything outside the kernel, each grepped with
the §S.4 pattern and every hit's neighbourhood read, none theorem-shaped.

**Docstrings only, per the brief (frozen tools; not run):** `tools/fs58_local.py`, `tools/fs58_witness.py`,
`tools/fs58_check_witness.py`, `tools/fq_chi.py`.

**Skipped, with reason:** none of the assigned files were skipped; every file in the brief's list appears above.

## Web lookups (prior-art gate)

zbMATH Open API queries, each run and recorded with its hit count in the individual theorem entries (`plans/FS58-derivation.md`,
`plans/FS39-derivation.md`, `plans/FS62-derivation.md`): `ab:"Kloosterman sum" & ab:"prime power" & ab:"modulus"` (0),
`ti:"tightness" & ab:"Hoffman bound" & ab:"Cayley graph"` (0), `ab:"compactness" & ab:"chromatic number" & ab:"infinite
graph"` (1, an Oberwolfach report, not a citable source), `ab:"de Bruijn" & ab:"Erdos" & ab:"colouring theorem"` (0),
`ab:"multiplicativity" & ab:"chromatic number" & ab:"tensor product"` (0), `ab:"Hedetniemi" & ab:"three colourable"` (0),
`ab:"odd cycle" & ab:"pigeonhole" & ab:"unit distance"` (0), `au:"Wormald" & ti:"colouring"` (2, both on random-regular-
graph colouring, unrelated), `ab:"quotient" & ab:"Cayley graph" & ab:"colouring" & ab:"lift"` (0), `ab:"finite Euclidean
graph" & ab:"real quadratic field"` (0), `ti:"Salie sum" | ti:"Salié sum"` (3, classical exponential-sum papers,
confirming the classical material exists and was not read here), `au:"Salie" & ab:"exponential sum"` (0), `ab:"independence
number" & ab:"Paley graph" & ab:"upper bound"` (1, unrelated), `ti:"value set" & ab:"chromatic number" & ab:"field"` (0),
`ab:"sum of two squares" & ab:"ideal norm" & ab:"colouring"` (0), `ti:"Loeschian" & ab:"norm"` (0), `ab:"chromatic gap" &
ab:"graph family"` (0), `ab:"norm form" & ab:"quadratic order" & ab:"colouring"` (0). No new paper was found by any of
these queries bearing on this batch's theorems; `BIBLIOGRAPHY.md` was not touched (every citation used — `[Fischer1990]`,
`[Moorhouse2010]`, `[Krebs2022]`, `[Wormald1979]` — was already held, and both attributions this batch checked were
already correctly recorded).

## Gates run

`python3 tools/fs71_ledger_b_check.py` (non-strict, the batch's pass bar) — RESULT: PASS (231 theorems in 51 derivation
files, 231 § B rows, 0 placeholders; the only warnings, under `--strict`, are the pre-existing FS-70 and M18-T1 ones the
brief names as known — zero warnings on any `FS58-*`, `FS39-*` or `FS62-*` prefix, confirmed by explicit grep). Every
near-miss header warning found while drafting (three wrapped titles, one split field marker, one `*Proof address:*`
typo used instead of the required `*Proof:*`, repeated six times) was caught by the checker and fixed before this
report — none remain. `python3 tools/claude_md_fact_audit.py --base 29bc38d349571ee33b9210e4ebf542f4fc742f3f` — AUDIT
PASSED (0 failures; every delta accounted for by the recorded allowances, none new). `python3
tools/claude_md_fact_audit.py --dupes` — 15 repeated runs, 1,009 bytes, **identical to the pre-batch baseline** (measured
by running the same check on a stash of the pre-batch tree): this batch introduced **one** new 10-word duplicate on first
draft (FS62-T3's statement verbatim-quoting G64's own sentence in `CLAUDE.md`) and it was caught and reworded before this
report — the final dupes count matches the baseline exactly, zero new duplication. `python3 tools/check_architecture.py`
— RESULT: PASS (the same pre-existing warnings as batch 6b's run, none touching this batch's files). `python3
tools/bib_audit.py` — run as a sanity check though not required (no bibliography row was touched): every arXiv id and
bracketed key resolves.

## Acceptance checklist (self-scored; the owner scores independently per §S.5)

- Every grade-tagged clause of rows 72–73 accounted for: yes (census table above; D1 and the ℚ(√11) witness correctly
  classified "kernel already" rather than refiled; the `[tools]` tensor-rigidity clause explicitly demoted to a
  measurement with FS-67 named as the open theorem, per G61(2)'s instruction).
- G61(2), G63 and G64's claims classified with their demotions recorded: yes — G61(2)'s tensor-rigidity warning is
  live and cited against row 72's own text (a finding, recorded, no edit proposed pending the owner); G63's Fischer
  1990 Theorem 6 attribution and the Remark 1 gap were both already correctly recorded in `BIBLIOGRAPHY.md`, checked
  and confirmed rather than re-attributed; G64's S ⟺ W → S ⟹ W demotion, already recorded in the stub's own banner
  (2026-09-19), is re-verified here and its history filed inside `FS62-T1`'s entry.
- Every file in the brief's enumeration appears in "The enumeration" above: yes.
- Every filed entry has all seven fields (id/title/grade, statement, Proof, Proof verdict, Rests on it, Prior art,
  Kernel): yes, checker-verified (`tools/fs71_ledger_b_check.py --strict` prints no "lacks" warning on any `FS58-*`,
  `FS39-*` or `FS62-*` entry).
- Bibliography keys added: none (every citation used was already held; both attributions checked were already
  correctly recorded, so no edit was needed).
- Commits: one per file group, by explicit path (see the commit log below).

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read directly
by this agent, and all three derivation files, all sixteen `LEDGER.md` § B rows, and this report were written directly
by this agent.
