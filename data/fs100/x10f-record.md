# X10F — the front-page pass for FS-100 stage 5 (the ×2×3 crunch), record

*de Bruijn (Opus 5.5), 2026-09-26, from 11:25 UTC. Brief `data/crunch-2026-09-26-x2x3/briefs/X10F-front-page.md` with
`STANDING-RULES.md` and its template J55's brief; the owner's launch notes (06:3x). HEAD at launch: `447741b5`. No subagents; no search.*

## Theorems this phase proved

None (a front-page pass: it applies drafts, it proves nothing).

## Stage 1 — SAVED (quotation check; baselines)

**Quotation check (standing rule 5).**
- The brief's "the header line recording the temporary suspension was written by the clerk's K0 job": `CLAUDE.md` l. 19 reads
  "**Size budget: none during the 2026-09-26 ×2×3 crunch** (Kooshi: *"CLAUDE.md unbounded temporarily so we don't need to compress on the
  fly"*)", commit `3418e6d0`, which is K0's text word for word (`briefs/K0-clerk-budget-line.md`). Left as it is.
- "X09C's drafts in `plans/FS100-three-field-lemma.md` §R-close (stage 5)": present at l. 1062–1444, stages 1, 1b, 2, 3, 4 SAVED; drafts in
  stage 4 (4.1 rows 120–122, the row 118 correction, 16 § B lines; 4.2 `CLAUDE.md` lines; 4.3 `BIBLIOGRAPHY.md` rows; 4.4 `FRONTIER-STUBS.md`
  rows; 4.5 stub files written). Launch note 1's list matches.
- Queue §5's ten items (`plans/CRUNCH-2026-09-26-x2x3-queue.md` l. 198–215) against X09C's §R-close 3.4: the ten outcome texts and P values
  quoted there match §5 verbatim.
- Launch note 3's file moves: close inventory items 20–21 (`plans/FS100-x2x3-close-inventory.md` l. 28–29) — item 20 "the close moves
  Einsiedler–Fish 2010 into ~/source/library/pdf/, removes both copies with git rm"; matches. The PDF is EF 2010 (its `ef.txt` title:
  "RIGIDITY OF MEASURES INVARIANT UNDER THE ACTION OF A MULTIPLICATIVE SEMIGROUP OF POLYNOMIAL GROWTH ON T", arXiv:0804.3586v2); the second PDF
  is byte-identical to the library's EL2021 (md5 `1a32060a…` both).

**Baselines at `447741b5`** (exit statuses read directly):
- `claude_md_fact_audit.py --base 447741b5`: exit 0, AUDIT PASSED. `--dupes`: 7 runs, 492 bytes.
- `bib_audit.py`: exit 1 — 4 arXiv ids (0804.3586, 1606.06078, 1908.02611, math/0402165) and 5 keys (`[EinsiedlerFish2010]`, `[Huang2017]`,
  `[HuangLiShiXu2023]`, `[Lindenstrauss2004]`, `[Sataev1975]`) cited by the crunch's records and not in `BIBLIOGRAPHY.md`: X09C's 4.3 drafts
  cover all nine.
- `fs71_ledger_b_check.py --strict`: exit 1, FAIL (28) — 15 FS100 ids with no § B row (the drafts fix them); **13 X09C §3 entries lacking
  strict fields** (CE1, ED1, ED2, EFG, EFX, EFZ, FLH, FLK, FR1, HX1, MR, PE1, SPEC) in `plans/FS100-derivation.md`, outside my touch list; and
  **FS100-Q47's header does not parse** (its grade bracket holds `` `[Moorhouse2010]` ``), so its drafted § B line will FAIL as "row has no
  derivation entry". Asked the owner by SendMessage (06:3x); default: apply every § B line as drafted, report the 14 as owed to the derivation file.
- `CLAUDE.md`: **287,240 bytes** before.

**Would have searched here (stage 1):** none.

## Stage 2 — SAVED (the derivation file's mechanical fixes, authorized by the owner 06:3x)

The owner's ruling (verbatim): "You may edit plans/FS100-derivation.md §3 for mechanical fixes only: (1) move `[Moorhouse2010]` and
`[Madore2015]` out of FS100-Q47's grade bracket into its prior-art field; (2) add the missing field labels (*Proof:*, *Proof verdict:*,
*Rests on it:*, *Prior art:*) where the entry already states the content; (3) where a field's content is absent, write the address of the
record that holds it … or, for prior art with none recorded, "none recorded at the close; the X24R gate is running". Invent no mathematics and
change no grade or verdict."

**Entries touched (14)**, each by exact replacement (script: the scratchpad's `fixderiv.py`; every old string asserted to occur once):
- **FS100-Q47**: the two keys moved from the grade bracket to *Prior art:* ("the upper bound `χ ≤ 5` is `[Moorhouse2010]`, `[Madore2015]` (row
  52)"); "no link broken" relabelled *Proof verdict:*; *Rests on it:* → the plan's §R-close (stage 5) 1b and 4.4. The header now parses.
- **FS100-HX1**: *Proof:* X02D §2.1, X02V §2.1, X01V's held proof (inventory 18); *Proof verdict:* "TRUE by all three" (§R-close 1.1, row HX-1).
- **FS100-MR**, **FS100-PE1**, **FS100-EFG**, **FS100-EFX**, **FS100-CE1**, **FS100-FR1**, **FS100-ED1**, **FS100-FLK**, **FS100-SPEC**,
  **FS100-FLH**: *Proof verdict:* as an address into §R-close (stage 5) 1.1's reconciliation row (1.2's link L3 for MR); *Proof:* where missing,
  the records' section addresses from their "Theorems this phase proved" tables (X01D §2.1–2.2; X01V §2.1–2.2; X12B §2.5; X02D §4.1–4.2; X02V
  §2.4–2.6; X03D §2.1–2.2, §3.2–3.5; X05V §3.1–3.2); *Rests on it:* where missing, an address (§R-close 3.2 items 4–5, 3.3) or "none recorded;
  the ladder (§R-close 1.2) does not use it" (ED1), or FS100-FLH (FLK, SPEC); *Prior art:* "none recorded at the close; the X24R gate is
  running." (EFX, CE1, FR1, FLK, SPEC, FLH) or "the ED gate not run (the close inventory, item 90)" (ED1).
- **FS100-EFZ**: *Proof verdict:* "valid on the close's check (§R-close (stage 5) 1b, Lemma Z)".
- **FS100-ED2**: *Proof:* X03D §4.1–4.4; *Proof verdict:* "X03D-ED2 and X03D-Z VALID on X13R's reading"; *Prior art:* the ED gate not run
  (inventory 90).

No grade, verdict or statement changed. **Gate:** `fs71_ledger_b_check.py --strict` exit 1, FAIL (16): only the 16 "has no § B row" lines left
(FS100-Q47 now among them, its header parsing), which stage 3's § B lines fix. `bib_audit.py` unchanged by this stage (the two keys stay in the file).

**Would have searched here (stage 2):** none.

## Stage 3 — SAVED (`LEDGER.md`: rows 120–122, row 118 corrected, 16 § B lines)

Applied from X09C's §R-close (stage 5) 4.1 by script (the scratchpad's `ledger.py`, every replacement asserted unique; the drafted lines read
from the plan file, never retyped). Departures from "apply exactly", each mechanical and named:
- **Row 120 and § B FS100-EFG**: the code span `` `h_m(u) = Σ_v log⁺|u|_v` `` holds two unescaped `|`, which split a table cell (the defect
  J55 corrected in eight lines); escaped as `\|`. Every inserted line was checked to have exactly 5 (row) or 7 (§ B) unescaped pipes.
- **Launch note 2 (novelty pending)**: row 120's *Prior art* gains "prior-art gate on MR pending, X24R"; row 121's "— owed before any novelty or
  publication claim" gains "; prior-art gate pending, X24R". Neither row claims a result as new; both now name the gate that decides it.
- **§ B address column**: the drafts' bare ids ("FS100-EFZ") written in the table's convention, "`plans/FS100-derivation.md` FS100-EFZ" (the
  draft's own header names that file as the address).
- **Row 118**: the drafted replacement ends at "an owed lemma PE-lim"; the original's parenthetical "(from finitely generated `Γ` to `U`)",
  which glosses PE-lim, is kept beside PE-lim inside the new dash clause rather than left trailing after "Einsiedler–Fish". The scope sentence
  ("never applies on `R̂` itself; on the pieces `M̂` it applies exactly under admissibility (row 120)") and "**Not claimed:** PE-lim; MR" → deleted
  applied as drafted.
- § B lines appended after FS-75's (row order: 119, then 120–122).

**Gates:** `fs71_ledger_b_check.py --strict` **exit 0, PASS** (752 § B rows). `claude_md_fact_audit.py --base 447741b5` exit 0, AUDIT PASSED
(LOST 0 in every class).

**Left (no draft):** a line for `LEDGER.md` § The claim list — X09C drafted none; under launch note 2 any such line would read "prior-art gate
pending, X24R".

**Would have searched here (stage 3):** none.

## Stage 4 — SAVED (`BIBLIOGRAPHY.md`; the file moves of inventory items 20–21)

**File moves** (launch note 3): Einsiedler–Fish 2010 copied to
`~/source/library/pdf/EinsiedlerFish2010-rigidity-measures-multiplicative-semigroup-polynomial-growth.pdf` (the library's `<Key>-<title-words>.pdf`
convention, as its neighbours `EinsiedlerLindenstrauss2022-…`, `Berend1983-…`), md5 `fdb1e267…` identical to the source; then `git rm` of both
`data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf` and `…/el2021-2101.11120.pdf` (the latter md5 `1a32060a…`, identical to the
library's EL2021) in this stage's one commit. `ef.txt` left.

**`BIBLIOGRAPHY.md`** (X09C 4.3): § A — `[EinsiedlerFish2010]` new (read in full; the library address); `[EinsiedlerLindenstrauss2022]` amended
(Thm 1.2 on `M̂` under admissibility, row 120; §1 in full by X02D, pp. 1–3 by X02V; **§2 unread — a prior-art debt on PE-2**; §§3–9 unread;
its role column's superseded "its Thm 1.3 is the in-print positive-entropy statement that can [reading, one mind; J51 §PA.3]" replaced, as row
118 now says). § B (the library table) — the EF row added, the EL row's status brought into agreement with § A (rule 0b). § C —
`[BekkaFrancini2022]` amended (Thm 1.1, Remark 1.2 (iii)–(iv) read by X03D; its hypothesis fails for `R ⋊ U`); new `[Huang2017]`,
`[HuangLiShiXu2023]`, `[Sataev1975]`, `[Lindenstrauss2004]`, and one row `[LindWard1988]` / `[ChothiEverestWard1997]` (the draft named them
without keys; keys minted in the Rudolph/Johnson/Host row's combined form).

**Gate:** `bib_audit.py` **exit 0** — 0 arXiv ids and 0 keys unresolved (from 4 and 5 at launch).

**Left:** Bekka–Francini's PDF (`data/fs100/x03d/bekka-francini-2002.07497.pdf`) and the Huang PDFs (`data/fs100/x01d/`) stay in the repository —
launch note 3 named only the EF move; the rows say "held in the repository".

**Would have searched here (stage 4):** none.

## Stage 5 — SAVED (`CLAUDE.md`: X09C's 4.2 lines)

Applied by script (the scratchpad's `claude.py`, every replacement asserted unique). **Bytes: 287,240 → 291,645** (no budget during the crunch;
nothing compressed). Applied: the Last-updated line (FS-100 stage 5 first, "[hand], prior-art gate pending (X24R)"; the 2026-09-25 crunch, the
in-ban round and FS-75 after it); § The mission (2) (exposed predictions: ℚ(√47) met, the K0 fields met at K0's grade, ℚ(√3,√5) open — its
"four proven" keeps the original's citation "rows 73–74, G55"; ℚ(√167) "proven 4 in the kernel (row 119) and ≥ 5 at K0's grade (row 121)"; the
testable range at L = 5 "ℚ(√3,√5) and FS-48's table"); § Publication, the candidate line after "**It has not fired.**" with launch note 2's
"(pending, X24R)" (the default "It has not fired" stands); items 10, 12, 24, 27; new item 29; the prior-art position's "Not ours" (EF 2010, EL
Thm 1.2); Paths forward (FS-84 answered and re-aimed per the owner's ruling — launch note 4 — with the re-aim's text in rank 4's row and a
pointer in "Open milestones", which removed the one new duplicate run `--dupes` found; "Closed most recently" leads with FS-100 stage 5; rows
1 FS-59, 3 FS-100, 4 FS-84, 8 FS-98, 12 FS-64, 13 FS-97); G48's proved range; G50's instance; G57's and G60's *Do* lines; G72's count (twelve of
thirteen) and its thirteenth record; G76's reading demoted in MR's form (the claim kept, its refutation recorded, per the header's demotion rule)
and its *Do*; G79's record; **G80** minted after G79; "G1–G80"; the ledger pointer "Rows 1–122".

**Reviewed ALLOW lines** (added to `tools/claude_md_fact_audit.py`'s ALLOW table, in the J44/J55 precedent's form — the brief's gate names
ALLOW lines, though the tool is not in its touch list; named here for the owner): `"G1–G79"` (the stable-identifier range, extended to G1–G80
when G80 was minted) and `"1–119"` (the ledger pointer's range, extended to 1–122; the 1–115 precedent).

**Gates:** `claude_md_fact_audit.py --base 447741b5` **exit 0, AUDIT PASSED** (LOST 0 in every class after the two allowances; dangling
pointers none; 80 grokkings). `--dupes`: **7** runs, 492 bytes (the launch baseline).

**Left (no draft, or beyond the drafts):** G48's *Falsifiers* sentence still reads "next the L = 5 fields where four is proven, ℚ(√47) first
(FS-84; FS-81 priced it)" — stale since row 121, not drafted; the owner's call whether to rewrite it.

**Would have searched here (stage 5):** none.

## Stage 6 — SAVED (`plans/FRONTIER-STUBS.md`: X09C's 4.4 rows, following the re-aimed stub files)

Applied by script (the scratchpad's `fs.py`, every replacement asserted unique), each row following its stub file's current text
(`plans/STUB-measure-rigidity-three-fields.md`'s stage-5 status block; `plans/STUB-infinite-place-spectra.md`'s banner): the open-milestones
paragraph (FS-84 answered and re-aimed — launch note 4, the owner's ruling, Kooshi may close it instead; FS-100 stage 5 CLOSED, Paid
(theorem), [hand], prior-art gate pending X24R); a ranked-stubs note for this close (no rank moved; the QTCA candidate not minted, held); rank 1
FS-59 (≥ 5 at K0's grade; six waits on T-J39-5; its bearing "proven 4 (in the kernel, row 119)"); rank 3 FS-100 (stage 5's result and what is
left); rank 4 FS-84 (answered; S2 onward re-aimed); rank 8 FS-98 ("row 88 ⟺ T-B1 (MR held, row 120)"); rank 12 FS-64 (moot at ℚ(√47)); rank 13
FS-97 (answered, per its banner); the closed list gains FS-100 stage 5 above the in-ban round. FS-100's rank stays 3 (the draft's "below FS-59"
holds already). **Gate:** `bib_audit.py` exit 0.

**Left:** the FS-84 banner on `plans/STUB-five-colours-47.md` — X09C 4.4 says "the front page writes it" but gives no text, and the file is
outside my brief's touch list; `CLOSED-QUESTIONS.md` entries (§1.7, §3) for Moorhouse's question and Soifer 55.1 — held for Kooshi by X09C, in
no lane's touch list; under launch note 2 they would read "prior-art gate pending, X24R".

**Would have searched here (stage 6):** none.
