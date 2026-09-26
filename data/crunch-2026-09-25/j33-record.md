# J33 — record (format and field fixes for `tools/fs71_ledger_b_check.py --strict`)

*Bookkeeping job, crunch 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J33-derivation-format-fixes.md`.*

## Item 1 — unparseable ids, fixed

**FS91-derivation.md** (9 unparseable ids/headers):
- `FS91-J02-A2.1′` → respelled **`FS91-J02-A21p`** (dot + prime not ASCII; the checker's id regex is `[A-Za-z0-9][A-Za-z0-9-]*?`).
  Original spelling kept in the entry's own text and in the "who found what" list (line 25).
- `FS91-J07-8` and `FS91-J11-W3`: not an id problem — each header's grade bracket contained a literal `]` before its own
  closing `]**` (`ℤ[i]/3⁴` in J07-8; `[of band 5]` in J11-W3), which the checker's grade regex (`[^\]]*`) cannot skip over. Fixed by
  moving the offending clause out of the grade bracket (J07-8) or converting the inner brackets to parens (J11-W3); content unchanged.
- `FS91-J12-A1, J12-A2, J12-A3`; `J12-B1..B4`; `J12-CL, J12-CL′`; `J12-H, J12-W, J12-Ω`; `J12-C1, J12-C2`; `J13-T6, J13-L1`: six
  **grouped headers** (comma-separated ids before the em-dash, which the id regex cannot parse at all — invisible, not even a
  near-miss). Each split to one canonical id (the first) with the others named in the title as `(= J12-A2, J12-A3)`, matching the
  convention `LEDGER.md` § B already uses for these six rows (one row each, citing the group). Two of the six also had an internal
  `]` in the grade (A1/A2/A3's `ℤ[i]` quotes from J13's phase-2 read; T6/L1's `[ρ₁, 1/4]`), fixed the same way as J07-8.

**M3-derivation.md** (4 unparseable ids/headers):
- `M3-J18-KE⟹` → respelled **`M3-J18-KEimplies`**; `M3-J19-AF✗` → respelled **`M3-J19-AFx`** (⟹, ✗ not ASCII). Original spellings
  kept in each entry's own text and in the "who found what" list (lines 21–22).
- `M3-J19-ENDS` and `M3-J21-NG2`: same "`]` inside the grade bracket" mechanism as FS91-J07-8/J11-W3 (`[a − m, b + m]` in ENDS;
  `[Zhu2021]`/`[Zhu2025]`'s citation brackets in NG2). Fixed by relocating the clause out of the grade bracket.

No id required respelling beyond ASCII substitution of the offending characters (`.`, `′` → dropped/`p`; `⟹` → `implies`; `✗` → `x`).
**J24: the three respelled ids that `LEDGER.md` § B still cites under their old spelling** (confirmed by `tools/fs71_ledger_b_check.py
--strict`, the only remaining FAILs):
- `FS91-J02-A2.1′` → `FS91-J02-A21p`
- `M3-J18-KE⟹` → `M3-J18-KEimplies`
- `M3-J19-AF✗` → `M3-J19-AFx`

## Item 2 — missing fields, filled

FS91: 20 entries (the brief's count) plus 2 more exposed by the header fixes above (`FS91-J02-A21p`, `FS91-J11-W3`) = 22 fields sets
filled, plus the 6 split entries above each given all 5 fields at creation. M3: 40 entries (the brief's count) plus `M3-J19-ENDS` and
`M3-J18-KEimplies`, `M3-J19-AFx` given full fields at creation.

**Two of the "missing" fields were not missing — they were split across a hard line-wrap in the middle of the marker itself**
(`*Prior\nart:*`, `*Rests on\nit:*`): `FS91-J02-L2`'s *Rests on it:*, `FS91-J09-J4-A`'s *Prior art:*, and (found while re-checking
after the header fixes shifted entry boundaries) `FS91-J01-8`... — no, on inspection only the two above were pre-existing wraps;
five more line-wraps of the same kind were found and fixed while confirming no *new* wrap was introduced by header-boundary shifts
(`FS91-J02-L2`, `FS91-J09-J4-A`, `FS91-J11-T12` [via J07-8's own body, absorbed before the fix], `FS91-J12-ONEa`, `FS91-J13-T5` —
see the wrap-detection script's output in the session transcript; net: 5 wrap fixes in FS91, 0 in M3).

**Content rule followed:** every added field is drawn either from the entry's own header/grade-bracket text (most *Proof:* and
*Proof verdict:* fields — the derivation records and sections were already named there, just not under the right marker) or from
the record file(s) the entry cites. Where a record states no prior art, the field reads `not stated in the record (<address>)`, or —
for FS91 §6 and M3 §1–§6 — the **section-level or plan-level blanket prior-art note** the file itself already carries (FS91 §6's
"pending the close gate… not found as stated (J23p result 6)"; M3's plan `plans/M3-exotic-colourings.md` §R-close rows "next" (Q1)
and "next+2" (Q2)). No field states a specific claim not already in the entry, its bracket, or the record/plan it cites; where none
of those had anything, the field says so in those words. Grades, statements and verdicts (the substantive claims) were not touched.

## Item 3 — M2 kernel-lane fields

Nine `*Kernel:*` fields updated to M2's kernel register (`plans/M2-derivation.md` §I.9, cross-checked against §I.1–§I.7 for exact
declaration names and files), in the four files M2 named: `plans/ASTRA-2026-09-14-derivation.md` (T1, T2, T5, T6, T7, T9),
`plans/FS39-derivation.md` (T1), `plans/FS62-derivation.md` (T2), `plans/FS85-derivation.md` (V2-T5). Text follows
`plans/M2-kernel-lane.md` §4b's drafted column, expanded with each declaration's file path from the register.

## Item 4 — FS86-derivation.md C14/CL1 grade

Applied `plans/PA-ambrus2023-audit.md` §4.4's proposed text to `FS86-Cx-C14`'s and `FS86-CL1`'s grade brackets: "not re-checked
here" → "its certificate re-checked here — J26, `plans/PA-ambrus2023-audit.md`: exact on the finite obligations, double precision
on the Bessel obligation with Lipschitz constants derived here; the authors' Mathematica notebook not run, and its
similarity-for-congruence and Lipschitz gaps shown harmless". CL1's grade bracket did not literally carry "not re-checked here" (it
only named the external input); the same clause was added there since §4.4 names CL1 explicitly as a target of the same upgrade.
Only the two named entries in `plans/FS86-derivation.md` were touched — not `LEDGER.md` row 92, not `LEDGER.md` § B's line (J24's).

## Checker's final output

`python3 tools/fs71_ledger_b_check.py --strict` → **FAIL (6)**, all six the expected § B / entry-id mismatches from the three
respellings above (each id appears exactly once in the wrong direction — the entry under the new spelling, the § B row under the
old). No other FAIL, no other warn. Full output filed at the end of this record's session; `census: 675 theorems in 62 derivation
files` (up from 662 before this job — FS91 73 [+9], M3 46 [+4]; M2/ASTRA/FS39/FS62/FS85/FS86 unchanged in count, only their
`*Kernel:*` or grade text changed).
