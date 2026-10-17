JOB FS131-FPA2 — DONE   harness≈(not shown to me)
RESULT: PAS2's ruled drafts filed verbatim and the owed bibliography pass done; `tools/bib_audit.py` now reads "UNLOGGED PRIOR ART: 1" (was 11), the one left being `[Johnson2011]`, a wrong key quoted inside `plans/FS131-close-inventory.md` (Keryx's file, item 1080) — see HELD. `--self-test`: 3 controls, ALL FIRED.
RECORD: data/fs131/reports/FS131-FPA2.md (this file); script `data/fs131/fpa2/file.py`, outputs `run.out`, `audit.out`, `selftest.out` beside it.   COMMITS: see the hand-back line below.

SCRIPT. `python3 data/fs131/fpa2/file.py --plant` changes the first part-1 slot by a character: FAIL ("slot occurs 0 times"), exit 1, nothing written (git status clean). The real run: every part-1 slot found exactly once (whitespace-insensitive), every part-2 prefix found exactly once, then all files written; exit 0.

PART 1 (all from `plans/FS131-PAS2-prior-art.md`; line numbers after filing)
- § 4.4 item 1 -> `CLOSED-QUESTIONS.md` l. 272, appended after "none addresses a field plane." in the same paragraph.
- § 4.4 item 2 -> `LEDGER.md` l. 115 (row 71), inserted after "...`[CranstonRabern2015]`'s first question (`CLOSED-QUESTIONS.md` §1.6);".
- § 4.4 item 3 -> `BIBLIOGRAPHY.md`: `[Ducz2026]` l. 195, `[MatolcsiEtAl2025]` l. 196, `[DuczVarga2026]` l. 197 (appended after each row's last cell text); the Jungić listing row l. 736 in § C's "Swept and closed" table (see below).
- § 2.4 item 4 -> `[Johnson2010]` status appended, l. 241; `[BauJohnsonNoble2021]` § A l. 214 (copy cell replaced by the draft's "held: ..." text; the draft's status appended to the read cell) and its § C row l. 795 marked "**superseded by the § A row**"; `[Zaks1989]` § C l. 780, the draft's status appended to the row's status cell; new rows `[JohnsonVoloshin2007]` l. 412 and `[KubickiLehelMorayne2002]` l. 413 (§ A, end of table); the seven listing rows (Cibulka ... Noble 2012) at l. 729 ff., each "**Searched, title or review only** (FS131-PAS2): not held; no bearing ...".
- Not filed, as ruled: § 2.4 items 1-3, C14's novelty line, anything in § 3.2.

PART 2
1. `[Davidson2026]`: the § C row's path `pdf/Davidson2026-coloring-monomial-cayley-graphs-one-parameter.pdf` exists (ls); no edit. A second file, `pdf/arXiv-2610.09474-davidson-monomial-cayley-graphs-one-parameter.pdf` (modified 2026-10-16 21:03), is byte-identical to it (`cmp` exit 0).
2. `[deGrey2026]`, `[Haugstrup2026]`: new § A rows l. 414, 415 (end of § A), from the § R.4 rows' own cells (work = their citation plus zbMATH number; "rests on it" = the `CLOSED-QUESTIONS.md` § 3 entries and README § 5 line that cite them, then the R.4 row's own "why" text; copy = `library/geombinatorics/geombinatorics-v35-n3-2026-01.pdf` with pages 111-118 / 102-110 as PAS1 § 3.4 item 4 gave them; read = the R.4 status cell, unchanged). R.4 rows 8 and 9 deleted, others not renumbered. (The R.4 identifiers cell's "found by..." narrative was not carried over.)
3. `[Shimura1964]`: § D has no rule for a key both requested and cited (grep of § D); done as the brief says: R.4 #17 (l. 67) now reads `` `[Shimura1964]` `` (plain), the § A row l. 363 is the one definition.
4. § B: seven rows added after the `[LiSu2026]` row (l. 654; new rows l. 655-661): BauJohnsonNoble2021, MinacNguyenTan2026, Davidson2026 (the arXiv-named file), EnamiMatsushita2026, BarroeroFreiTichy2011, Schinzel1969, Nagell1969; status copied from each key's § A row (Davidson: from its § C row). The Li-Su file already had a row.
5. Unlogged: the six PAS1 arXiv ids and arXiv:2602.17943 each got a § C "Swept and closed" row (l. 737 ff.; what PAS1 § 2.2/§ 3.2 say, "Abstract only ... Not held"; Istrate-Zara per PAS2 § 2.3, "no bearing"); `[Neukirch1999]` a § A row l. 416 ("not held; cited by the planner, not read here"); `[JohnsonVoloshin2007]` and `[KubickiLehelMorayne2002]` are the part-1 rows.

CHECKS: `python3 tools/bib_audit.py` -> exit 1 only because of "UNLOGGED PRIOR ART: 1" (`[Johnson2011]`, first seen in plans/FS131-close-inventory.md); arXiv ids not in the bibliography: 0. `--self-test` exit 0, "3 controls, ALL FIRED". `ls` of every new row's library path: exit 0 (all exist). Not run: no Lean, no fact audit (not asked).

INVENTORY:
- correction owed — `plans/FS131-close-inventory.md` item 1080 still quotes the wrong key `[Johnson2011]` (Keryx's file; `bib_audit` flags it) — plans/FS131-close-inventory.md l. 9514.
- prior-art debt — Didin-Voronov 2026, `[Davies2026]`'s conditional `chi(R^3) >= 7`, C133-CHIF in print, `[KubickiLehelMorayne2002]` unread — item 1080, unchanged by this job.

HELD FOR THE COORDINATOR
- CHECK: the draft sends the new `[JohnsonVoloshin2007]` / `[KubickiLehelMorayne2002]` rows to "§ C, beside the consolidation run's reference-list rows", but those § C tables have two cells and the drafts have five (key | work | role | copy | status), the shape of § A; I filed them at the end of § A. Move them if you meant § C.
- CHECK: `[BauJohnsonNoble2021]` § A read cell now holds both "read (2026-09-09): abstract, §1, §2; the main theorem's proof not read" and the draft's "read: abstract, § 1, Thm 3.3 with proof, § 4, references"; I appended and rewrote neither. Whether Thm 3.3 is "the main theorem" is not stated in either; the same joined text is in the § B row.
- CHECK: the draft's `[Zaks1989]` "status" went into the § C row's status cell as an append, so that cell reads "Reviewer's text only ... not held" and then "abstract read (University of Haifa research portal...)".
- CHECK: the PAS1 record gives no titles for arXiv:1502.00965 (Godsil-Rooney), 2512.05302 (Krebs-Pan-Prakash) or 2606.23762 (Tung); their rows say "title not in the record". `[Neukirch1999]`'s title is likewise in no record (author and year from the key; Madore's excerpt cites "Neukirch 1999, theorem 13.4").
- CHECK: `[deGrey2026]` § A row's "pages 111-118" and the Haugstrup row's "102-110" are from PAS1 § 3.4 item 4 and the old R.4 cell; I did not open the issue file to confirm them.
- CHECK: no § B rows for the geombinatorics issue files that hold `[JohnsonVoloshin2007]` (v17 n2) and the 2026 issue (v35 n3): the brief's item 4 covered `pdf/` only, and `geombinatorics/` has its own catalogue.
- CHECK: duplicate Davidson PDF (above): two names, one content; only the arXiv-named one has a § B row.
- The § R.4 italic note "Left this table on ..." was not edited to mention items 8 and 9 (not drafted).
