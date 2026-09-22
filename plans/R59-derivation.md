# R59 — the derivation file: the 2-adic law's duality answer (ledger row 59)

*Filed 2026-09-22 by FS-71 batch 3c. Row 59 (`Proofs/HadwigerNelson/ValuationLaw.lean`, `ResidueColouring.lean` §4,
2026-09-09) is a ledger-row event, not an `M<nn>` milestone; its full derivation lives in `plans/P6-generalize-valuation-law.md`
and `plans/STUB-four-colour-valuation-law.md`, both of which are explicitly assigned to **batch 5**
(`plans/FS71-theorem-audit.md` §G.2, "Batch 5… plans `P3…P6`"). This entry files only the specific candidate the brief
names — the answer to a posed open question in the literature — reading `CLOSED-QUESTIONS.md`'s own account (which is
not itself a plan file and is in scope for this batch) plus the cited theorem names in `ValuationLaw.lean`, without
opening P6's full 400-line derivation, to avoid duplicating batch 5's assigned work. Row 60
(`PlaneRotation.lean`) is separately confirmed to hold nothing outside the kernel — see the batch report's census
table — and gets no file of its own, per S.1.*

## The theorems

**R59-T1 — The valuation law is invariant under `d ↦ 1/d`, answering the necessary half of a posed duality question.
[derived from the kernel law; the owner (de Bruijn), 2026-09-09, recorded in `CLOSED-QUESTIONS.md` rather than a plan
file]** Over `K = ℚ(√3, √11)`, the kernel-checked 2-adic law (`residueColouring_eq_iff_psiA_zero`,
`not_forces_of_residue_ne_zero`, `not_separated_of_residue_eq_zero`) says: a pair is a four-colour **virtual edge**
(forced distinct) at distance `d` iff `d` lies at 𝔭-adic valuation zero (`v_𝔭(d) = 0`), and **forced monochromatic**
iff `v_𝔭(d) > 0`. Since `v_𝔭(1/d) = −v_𝔭(d)`, **the "virtual edge" condition (`v_𝔭 = 0`) is invariant under
`d ↦ 1/d`** — exactly the duality `[Heule2021]` conjectured and `[PartsOdd2022]` asked to have made precise: *"if an
odd distance `d` is a `k`-virtual edge… then distance `1/d` is a `k`-virtual edge as well… does this duality work in
the general case?"* `[PartsOdd2022]` §4 raised doubts after finding a finite counterexample at `d = 5` and reports
Heule clarifying he meant the statement over the *field* `ℚ(√−3,√−11)` (read as points of the plane, this lies inside
`K²`), not a finite graph. **This entry answers the necessary half**: over `K`, valuation-zero is `d ↦ 1/d`-invariant,
so the duality holds as a *field-level* statement (never claiming anything about which finite graphs realize it) — it
is necessary, not sufficient, and Parts's finite counterexample does not touch it (a finite graph can fail to realize
a virtual edge at valuation-zero `d` without the law being false). **Open**: whether valuation zero is *sufficient*
for a virtual edge in some finite `K`-object — row 59's own "Open" clause. *Proof:* `CLOSED-QUESTIONS.md` §1.x (the
section headed "The 2-adic law", read in full: the quoted `[Heule2021]`/`[PartsOdd2022]` passage, "Our answer — the
necessary half", the `v_𝔭(1/d) = −v_𝔭(d)` argument stated explicitly); the underlying law is kernel
(`ValuationLaw.lean`, `ResidueColouring.lean` §4, both confirmed present by `rg`). *Proof verdict:* closes (the
`d ↦ 1/d` invariance is a one-line consequence of valuation additivity, applied to an already-kernel law). *Rests on it:* `CLOSED-QUESTIONS.md`'s own closure of this question's necessary half (§1.x — check the file's own numbering at
the close); the open sufficiency question (a live target, not stubbed here since no milestone currently pursues it).
*Prior art:* **this is explicitly an answer to a posed question**: `[Heule2021]` (as quoted in `[PartsOdd2022]`) states
the duality as an observation; `[PartsOdd2022]` §4 (arXiv:2206.12632, June 2022) poses the "does this duality work in
general" question and reports doubt. Both held (per `CLOSED-QUESTIONS.md`'s own citation). **Constraining prior art,
substantial**: `[Ducz2026]` (10 June 2026, three months before this law was proved) gives the *identification* half in
coordinates for the Moser lattice (`N + M ≡ 0 (mod 4)`), reproducing ten cases; `CLOSED-QUESTIONS.md` reads this
against the kernel law in the section immediately following (not re-read here — batch 3a/3b's or batch 5's territory
if unfiled elsewhere, since `[Ducz2026]`'s attribution is row 59's own and was not flagged as missing by this audit's
per-theorem gate). zbMATH: not separately queried — the held citations (`[Heule2021]`, `[PartsOdd2022]`, `[Ducz2026]`)
already name the question and its posers exactly, per PA.1 item 2's "held bibliography first" rule, and a fresh query
would only re-find what `CLOSED-QUESTIONS.md` already read in full. *Kernel:* the underlying law is kernel
(`ValuationLaw.lean`); the `d ↦ 1/d` invariance corollary itself is not separately stated as a Lean theorem (declined
— a one-line remark, no consumer beyond the closed-question write-up).

**R59-T2 — The instantiation on `[Parts2020a]`'s Table 1: both columns barred from swapping. [kernel; the M-adjacent
2026-09-09 session]** `[Parts2020a]`'s Table 1 (minimal gadget sizes for four-colour compulsions) lists monochromatic
distances `8/3`, `8/√3` and distinct (virtual-edge) distances `3`, `7/3`, `5/3`, `1/3`, `√(11/3)`; **the law predicts
and the kernel confirms** the first two lie in the prime `𝔭` (`v_𝔭 > 0`, `#guard psiZero 8 == 0`,
`#guard psiZero (8*ordSqrt3) == 0`) and the last five do not (`#guard`s for `3, 7, 5, 1, √(11/3)` all `≠ 0`) — "the
pattern his table shows and does not explain" (`ValuationLaw.lean` §4's own docstring). *Proof:* `ValuationLaw.lean`
lines 348–420 (`not_separated_dist_eight_thirds`, `not_separated_dist_eight_over_sqrt_three`,
`not_forces_dist_three`, `not_forces_dist_seven_thirds`, `not_forces_dist_five_thirds`, `not_forces_dist_one_third`,
`not_forces_dist_sqrt_eleven_thirds` — all seven kernel theorems, confirmed present by `rg`; the `#guard` block lines
410–424 reading the two columns as one bit each, plus a planted red confirming the criterion reads the numerator's
valuation, not the denominator). *Proof verdict:* closes — this is a fully kernel-checked instance of the general law
(R59-T1's antecedent), not a separate hand theorem. *Rests on it:* row 59's own text ("each distance in Table 1 is
barred from the other column"); `CLOSED-QUESTIONS.md`'s citation of Parts's and Heule's tables as observations their
authors present without explanation ("not questions, so not rows here"). *Prior art:* the seven distances are
`[Parts2020a]`'s own (his Table 1, held per `BIBLIOGRAPHY.md`); the *explanation* of the pattern — that the 2-adic
valuation law sorts every row into its published column — is this project's, per row 59's own ledger text ("the
pattern his table shows and does not explain"). **One caveat, named in row 59's own ledger text and confirmed still
open by this audit**: "two rows' √ unverified against the PDF" — of the seven table rows,
two carry a `√` symbol (`√(11/3)` here; the row's text does not specify which second row) whose exact transcription
from `[Parts2020a]`'s published PDF was not independently re-checked against the paper itself at the time of writing,
though the row notes "the same valuation either way" (i.e. even a transcription slip in the exact radicand would not
change which column it falls in, since the argument depends only on the radicand's 2-adic valuation, not its precise
value). *Proof verdict (the caveat):* unsure — a verification action item, not a mathematical gap; owed, not done in
this batch (the brief instructs "record it", not "resolve it", and resolving it needs the actual PDF, out of this
audit's no-solver, no-new-checking scope). *Kernel:* kernel (see the seven declarations above).

## Readings and measurements that were called theorems

None beyond R59-T1/T2 themselves — row 59's remaining content (the general law's statement and its kernel proof) is
already correctly graded kernel in the ledger row and not re-examined here.

## Conjectures surfaced, not claimed

- **The sufficiency half of the duality** (R59-T1's "Open" clause): whether valuation zero is *sufficient* for a
  virtual edge in some finite `K`-object. Named as open in both row 59's own ledger text and `CLOSED-QUESTIONS.md`;
  no stub currently targets it directly (it is a special case of the general open question `CLAUDE.md` § "The open
  structural question" already poses about pigeonhole necessity, not separately minted here).

## Prior art re-attributed

None — `[Heule2021]`, `[PartsOdd2022]` and `[Ducz2026]` were already correctly credited in row 59's ledger text and
in `CLOSED-QUESTIONS.md` before this audit; this entry confirms the attribution rather than correcting it.

## Owed check

**The two-row PDF verification** (R59-T2's caveat) is not resolved here. It needs the actual `[Parts2020a]` PDF
(held per `BIBLIOGRAPHY.md`, read status to be checked at the owed action) cross-checked against `ValuationLaw.lean`
lines 348–402's seven distances. Recorded here rather than resolved, per this audit's no-new-verification scope.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| R59-T1 | declined — a one-line corollary of the already-kernel law, no separate Lean statement |
| R59-T2 | kernel (seven declarations in `ValuationLaw.lean` §4); the PDF-verification caveat is owed, not a kernel question |
