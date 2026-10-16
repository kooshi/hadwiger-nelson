JOB FS131-FPA1 — DONE with six items held (CHECK lines below)   harness≈60k (own≈40k)
RESULT: the ruled drafts of `plans/FS131-PAS1-prior-art.md` §§ 2.4 (items 1–5), 3.4 item 4, 4.4 items 2 and 4, 5.4 item 3, 6.4 item 3 are filed, verbatim, except the held parts listed under HELD. No mathematics, no grade changed. The script (`data/fs131/fpa1/file.py`) extracts every slot and replacement from the record by script, finds each slot exactly once (whitespace-insensitive), writes nothing unless all match. Plant (slot of row 79 changed by one character) failed loud, exit 1, nothing written; the real run exit 0, 14 edit steps. The first real run left a stray blank line before the new rows in § A; the script's insertion was corrected and the file regenerated on a clean tree: the final file equals the hand-fixed one (diff against it was empty).
RECORD: data/fs131/fpa1/file.py (no separate record; the report is this file)   COMMITS: see the branch fs131-fpa1 (the last commit)
FILED (item — slot — line in file after filing):
- 2.4-1 `LEDGER.md` row 79, "Prior art for the widening …" sentence replaced — LEDGER.md:124
- 2.4-2 `README.md` three-colour section, Prior art bullet — README.md:292
- 2.4-3 `RESULTS.md` § 10 Whose bullet — RESULTS.md:207
- 2.4-4 `CLOSED-QUESTIONS.md` § 2.4, inserted after "stays [hand]." — CLOSED-QUESTIONS.md:501
- 2.4-5 `BIBLIOGRAPHY.md`: [KrebsSankar2024] citation, role, reading status — :316; [EnamiMatsushita2026] new — :406; [Payan1992] — :746
- 3.4-4 `BIBLIOGRAPHY.md` [deGrey2026] status — :54; [Haugstrup2026] status — :55 (the copy parts held, see HELD)
- 4.4-2 `plans/FS100-derivation.md`, erratum paragraph after the FS100-CLS paragraph, original left standing — :289
- 4.4-4 `BIBLIOGRAPHY.md` [Moorhouse2010]: "§ 8 re-read in full, FS131-PAS1" added to the reading column (the row keeps per-section dates) — :116
- 5.4-3 `BIBLIOGRAPHY.md`: new [MinacNguyenTan2026] — :407; new [BarroeroFreiTichy2011] — :408; [Shimura1964] § A row reading status — :365
- 6.4-3 `BIBLIOGRAPHY.md`: new [Nagell1969] — :409; [Nagell1951] — :410; [Bauer1916] — :411; [Schinzel1969] — :412
New rows are at the end of § A, in § A's five-column form, the key written `**[Key]**` (the draft's `**`[Key]`**` backticks dropped to match every other row).
CHECKS:
- `python3 tools/bib_audit.py`: exit 1, last line "UNLOGGED PRIOR ART: 6" (on main before this filing: 16, among them [Nagell1969] and [Schinzel1969], now logged). The 6 left are arXiv ids first seen in the record itself, not in any draft I filed: 1502.00965, 2303.06267, 2312.06898, 2512.05302, 2606.23762, 2607.26942. "bracketed keys cited but neither defined nor aliased: 0".
- Library paths of the new rows: `ls` found arXiv-2610.21940…, arXiv-2607.00404…, arXiv-1102.0120…, nagell-1969-…, schinzel-1969-… in `~/source/library/pdf/`, and `~/source/library/geombinatorics/geombinatorics-v35-n3-2026-01.pdf`.
- The privacy guard ran through the commit hook (see the commit).
HELD FOR THE COORDINATOR:
- CHECK: **[Davidson2026] new row not filed** — 2.4 item 5 asks for a new row, but the key already has a row in § C (BIBLIOGRAPHY.md:~987, "Read: the abstract, the introduction's statement of results, Conjectures 4.3 and 4.7, Corollary 4.6 and § 5's programme", held as `pdf/Davidson2026-coloring-monomial-cayley-graphs-one-parameter.pdf`). The draft's row says copy `library/pdf/arXiv-2610.09474-davidson-…pdf` and "read: abstract, § 1, § 2.1–2.2". Two rows for one key and two different copy paths and read statuses: filed neither over the other. The library holds `arXiv-2610.09474-davidson-monomial-cayley-graphs-one-parameter.pdf`.
- CHECK: **[deGrey2026] / [Haugstrup2026] "copy column"** — the rows are in § R.4 (columns #, work, identifiers, why, status) which has no copy column; I replaced only the status cells (the old status text of [deGrey2026], "author's summary read … not held, the paper unread", is replaced as drafted). The "held: `library/geombinatorics/geombinatorics-v35-n3-2026-01.pdf`, pp. 111–118" and "held: same issue, pp. 102–110" were not placed. Both rows still sit in § R.4 ("paywall") though the paper is held.
- CHECK: **[Shimura1964] merge** — 5.4 item 3 asks that the two rows (R.4 #17 at :69 and § A at :365) be merged; I changed only the § A row's reading status to the drafted text and did not merge (which row survives, and R.4's numbering, are Keryx's). The R.4 row still reads "not held".
- CHECK: **[KrebsSankar2024] citation** — "update the citation to J. Combin. Theory Ser. B 179 (2026) 205–218": I kept the arXiv id and appended the journal after a semicolon; replace it if you meant the journal alone. Role sentence appended after a semicolon at the end of the role cell.
- CHECK: **[Payan1992]** — the drafted words appended after a semicolon to the row's last cell (the row has two cells, no separate read column).
- CHECK: **§ B (the held-file table)** — the five newly cited held files ([EnamiMatsushita2026], [MinacNguyenTan2026], [BarroeroFreiTichy2011], [Nagell1969], [Schinzel1969]) have no row in § B, and § D rule 0b says § A and § B must agree; the drafts name none. Not added.
- Mentions of held drafts in filed items: the filed 2.4-5 [KrebsSankar2024] role and the FS100 erratum refer to row 123's prior-art field "now" saying what 4.4 item 1 drafts; that item (row 123) is held, so the erratum points at text not yet filed. 6.4-3's [Nagell1969] row mentions FS131-KRU1's route E (the held 6.4 item 1's landing).
INVENTORY:
- slip — the first run of the script left a blank line inside § A's table before the new rows; the script was corrected and rerun clean — data/fs131/fpa1/file.py
- prior-art debt — arXiv ids cited in the record and not in the bibliography (6, listed above) — tools/bib_audit.py output
- statement defect — none
