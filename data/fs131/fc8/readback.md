# FS131-FC8 stage 1 — the readback

Every quotation of the brief was checked against its source (the four handoffs, the two inventory items 948 and 951, the pr1-drafts copy) by reading
the source lines: `plans/SESSION-HANDOFF-2026-10-16.md` § 4 item 3; `plans/SESSION-HANDOFF-2026-10-15.md` § 6 ("The second filing", nine bullets);
`plans/SESSION-HANDOFF-2026-10-14.md` § 6 first bullet; `plans/SESSION-HANDOFF-2026-10-13.md` § 7 first bullet; items 948 and 951 of
`plans/FS131-close-inventory.md` (9,411 lines). All quotations match. The four lists as read:

- **List 3 (2026-10-16 § 4)**: the 2026-10-15 § 6, less the first pass's bibliography drafts (filed, item 961) and the README's gated-commit hash (`752b11569`).
- **List 2 (2026-10-15 § 6)**: ledger notes rows 120/121/123/127/128; the `[Davies2026]` corrections (948); PR1's D1–D8 (951); PS2's bibliography D1–D5 (955);
  `ARCHITECTURE.md` § 5 counts; the `LEAN.md` lines of the older handoff's § 6; prices (M13, dyadic certificates, IKC4, the search's estimate, F2's design);
  EN1-UQ4's grade line; the README hash.
- **List 1 (2026-10-14 § 6)**: the older § 7 list; `LEAN.md` lines of 35 named records; bibliography lines (EL2022, OAIMath2026, Rudin1962, AmbrusEtAl2023 with p. 18's
  sign of J0′, KMOR2016, Schur1912, and KR1/K12A/KC13's); corrections (EXT-OAI1-audit; `scripts/Vacuity.lean` l. 561; density bound price 818/823; M13 848/893/905;
  K2 886; F2 902; J26/J49 note 845; KDB1 truncation 911; IDB1 heading 895; J45 erratum 873; FS-133 predictions; the `--dupes` +1 run).
- **List 0 (2026-10-13 § 7)**: the direction change; claim-list 'Not ours' (640); rows 52, 57, 121, 127 (643); row 128's prior art, CLOSED-QUESTIONS § 1.7 and § 3, the
  write-up stub's banner (644, 655); row 121's source cell and two errata (651); FALC-RED (684); `[Davies2026]` read in full (655); the axiom-binders rule (659 (a)) and the
  implementers' lines; FS-136's record note; the asking lane's re-rank draft.

**Findings on the brief and its sources (not mismatches of quotation):**
1. Item 961 of this repository's inventory says only "The first cleaning pass's bibliography drafts were filed"; commit `228e3a3a4`'s message says "D1, D2, D4, D5 filed". The PS2 record is not in this repository; D3's words and whether it was filed are unknown here (row BIB-PS2).
2. The 2026-10-14 handoff says "the older handoff's § 7 list" (the 2026-10-13 § 7) and the 2026-10-15 one says "the older handoff's § 6" (the 2026-10-14 § 6): read as the brief reads them.
3. PN1's draft for the claim list's "Not ours" phrase ends "(GPT Astra, G55; `LEDGER.md` § B, ASTRA-2026-09-14-T2 to T5)" while PN1's own quoted index lines are T3 and T4 (row CL-notours).
4. `CLAUDE.md` is 79,235 bytes as the brief says.
