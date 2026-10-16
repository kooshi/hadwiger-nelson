# FS131-PR1's corrections owed, drafted — copied verbatim from its record

*Copied 2026-10-16 03:53 UTC by Keryx from `plans/FS131-PR1-readme.md` on the branch `fs131-pr1` (its head `8b63d9a51` in the repository's history before publication; the branch and the record are not in this repository's history), lines 116–169: its § Stage 2's last two subsections, unchanged. The record's other sections concern the public pages' first drafts, which are in `README.md` and `ROADMAP.md`.*

### Disagreements and stale text found (the print wins on the page; each is a correction owed, drafted below)

1. **`[Davies2026]` on the density equality** — `CLAUDE.md` l. 158 and l. 196, `plans/FRONTIER-STUBS.md` l. 28 and
   `plans/STUB-one-class-transfer.md` l. 3 say the statement is "not new" and that the paper "names the plane as its aim"; row 129 says
   "the equalities not found", and ER1 § Stage 7 says the density equality at `d = 2` "is not singled out anywhere". Ruled (1) above.
2. **`BIBLIOGRAPHY.md` l. 978** still says "A full reading is owed before rows 121–123 or 128 are announced"; the reading is done
   (FS131-ER1). Ruled (2). ER1 § 9.2's drafts for that cell and for rows 121, 123, 128, 129's prior-art clauses are unfiled
   (`grep -c -F "Davies2026" LEDGER.md` is 1, row 130's Lemma B.1).
3. **Row 123's "Not claimed"** still lists "a kernel proof (row 127 holds the composition over named hypotheses; FS-101)", while the same
   row's grade says "[kernel] since FS131-LGT1 for the main clause …" and the print shows `Rigidity.min_localBound_five_le_chromaticNumber`
   with no hypothesis (p.240).
4. **Row 120's grade** is "[hand; …]" with no kernel note; `CLAUDE.md` § Where the problem stands says "measure rigidity as the chain
   uses it (row 120's deduction) … is kernel-checked", and the gate record's draft 22 says "its deduction from Thm 1.3 is kernel-checked
   inside the chain (no stored theorem by the row's name; the filer words it)" (`plans/FS131-LGT1-gate.md` l. 490). The library holds
   `Rigidity.mrPlus (F) : MRPlus F` for every real number field (`Rigidity/ZeroEntropyClosed.lean` l. 49; its docstring: "derived for the
   fields with no ramified stable dyadic place; here … proved from PE-2 and EF_F⁺") and `Rigidity.haar_or_zero_entropy` (the paper's
   Thm 1.2, on EL). The filer's words were not filed.
5. **The ledger's grades lag the Lean backlog's landed waves by design** (the stub: "rows regraded to [kernel] as their modules land";
   "`LEDGER.md` rows regraded … at the close"). Example: row 131 is graded "[hand; …]" with no kernel note, while `Plane/Slack.lean` holds
   `muZero_eq_one_iff_tendsto`, `tendsto_muTile`, `tendsto_muPer`, `forall_mu_six_lt_one_iff` and the plane's instance is
   `Outside.OAI158.seven_le_chromaticNumber_plane_iff` (Std3, p.43). Of the 205 backlog entries to formalize
   (`data/fs131/k1/dispositions.csv`), the planned modules of waves 1–5, 8, 10 and wave 6's first half exist on `main` (151 entries);
   those of wave 6's second half (`Plane/Saturated/Fragment`, `Ladder`: 23), wave 7 (`Plane/FourColour/Bowtie`, `Pinwheel`, `Plane/RouteT`:
   20) and wave 9 (`Plane/Classes`, `Plane/Reduction`: 11) do not — they are on branches (`plans/FS131-close-inventory.md` l. 6755, 7253,
   7758, 7885, 8511). A module's existence is my proxy, not a per-entry check; the roadmap says so.
6. **`ARCHITECTURE.md` § 5, "Assumed as hypotheses"**, says "102 pairs, 52 statements"; the gate reads `takes=108` and `CLAUDE.md` § Trust
   ledger says 108 pairs by 55 statements.

### Corrections owed, drafted (Keryx files)

- **D1. `CLAUDE.md` l. 158.** *Replaces* "the statement is not new (`[Davies2026]`, in dimension four and up, names the plane as its aim), the
  kernel proof is this project's." *with:* "for the plane, prior art not found in print (row 129; `plans/FS131-ER1-davies-reading.md`
  § Stage 7) — `[Davies2026]` Thm 1.1 proves the same equality in dimensions four and up —; the kernel proof is this project's."
- **D2. `CLAUDE.md` l. 196.** *Replaces* "that the result is new (`[Davies2026]`)." *with:* "that the result is new (for the plane, not found
  in print, row 129; `[Davies2026]` Thm 1.1 proves it in dimensions four and up)."
- **D3. `plans/FRONTIER-STUBS.md` l. 28.** *Replaces* "Not new: `[Davies2026]` proves the same sentence in dimension four and up and names the
  plane as its aim; the kernel proof is this project's." *with:* "For the plane, prior art not found in print (row 129; FS131-ER1 § Stage 7);
  `[Davies2026]` Thm 1.1 proves the same sentence in dimensions four and up; the kernel proof is this project's."
- **D4. `plans/STUB-one-class-transfer.md` l. 3.** *Replaces* "Prior art: the statement is not new — `[Davies2026]` (8 October 2026) proves it
  in dimension four and up and names the plane as its aim (`plans/FS131-ER1-davies-reading.md`)." *with:* "Prior art: for the plane, not
  found in print — `[Davies2026]` (8 October 2026) proves it in dimensions four and up, and does not single out the plane's density equality
  (`plans/FS131-ER1-davies-reading.md` § Stage 7)."
- **D5. `BIBLIOGRAPHY.md` l. 978, `[Davies2026]`'s second cell**: file `plans/FS131-ER1-davies-reading.md` § 9.2's first draft as written
  (it replaces the cell from "**Read: the abstract, …**" through "A full reading is owed before rows 121–123 or 128 are announced."). And
  § 9.2's drafts for rows 121, 123, 128, 129 (their prior-art "Follows" lines), unfiled since 2026-10-13.
- **D6. `LEDGER.md` row 123, "Not claimed".** *Replaces* "a kernel proof (row 127 holds the composition over named hypotheses; FS-101)"
  *with:* "`χ(F²) = L(F)` at `L(F) ≤ 5` as one stored theorem (the main clause with the upper half; not stored, `ROADMAP.md`)".
- **D7. `LEDGER.md` row 120, its grade.** *Follows* the grade's closing "]" — the filer's wording, owed since the chain's landing; a proposal:
  "**[kernel] since FS131-LGT1 inside the chain**, on `[EinsiedlerLindenstrauss2022]` Thm 1.3 (`Rigidity.positive_entropy_rigidity`):
  MR⁺(F) for every real number field (`Rigidity.mrPlus`), from PE-2 (`Rigidity.entropySplit`, through the paper's Thm 1.2,
  `Rigidity.haar_or_zero_entropy`) and EF_F⁺ (`Rigidity.zeroEntropyCarried`); no theorem stores MR(F) in this row's words."
  (`zeroEntropyCarried` is named in `mrPlus`'s proof, `Rigidity/ZeroEntropyClosed.lean` l. 50.)
- **D8. `ARCHITECTURE.md` § 5, "Assumed as hypotheses".** *Replaces* "102 pairs, 52 statements" *with:* "108 pairs, 55 statements".

