# X30F — the front-page pass for FS-100 stage 5, wave 3 (the ×2×3 crunch), record

*de Bruijn (Opus 5.5), 2026-09-26, from 12:09 UTC. Brief `data/crunch-2026-09-26-x2x3/briefs/X30F-front-page-wave3.md` (template X10F's brief,
itself on J55's) with `STANDING-RULES.md` and the owner's launch notes (07:1x) 1–5. HEAD at launch: `7eb4398c`. No subagents; no search.*

## Theorems this phase proved

None (a front-page pass: it applies drafts, it proves nothing).

## Stage 1 — SAVED (quotation check; baselines; the owner's ruling)

**Quotation check (standing rule 5).**
- Launch note 1, "every draft is in plans/FS100-three-field-lemma.md §R-close (stage 5, wave 3), stage 4: LEDGER rows 123–125, 19 § B lines,
  corrections to rows 113/117/120/121": present, l. 1758–1964 (4.1 rows 123–125, corrections to 117, 113, 120, 121 in that order; the § B
  table has 19 lines, Q0 … B3); 4.2 `CLAUDE.md`; 4.3 `BIBLIOGRAPHY.md`; 4.4 `CLOSED-QUESTIONS.md` §1.7, §3 (two), §2.6; 4.5 the claim list; 4.6
  `FRONTIER-STUBS.md` (FS-101 new); 4.7 the FS-84 banner and FS-98's line. Matches.
- Launch note 1, "G48's stale 'ℚ(√47) first'": 4.2's G48 bullet, verbatim ("next the L = 5 fields where four is proven, ℚ(√47) first (FS-84;
  FS-81 priced it)").
- Launch note 3, "its §3.4, seven rows": `plans/FS100-X28D-derivation.md` §3.4 names "seven rows, X28D-P, S, CP1, CP2, CP3, ODD, CUBE"; the
  rows' statements and grades are its "Theorems this phase proved" table. Matches.
- Launch note 2, "the queue's 'row 71' → 'row 69' slip in … §7": X29C 4.8, item 23 ("row 71 → row 69 … the queue's text is the owner's to
  correct"). Located at stage 7.
- The brief's "Score §7 … set every wave-3 status to its final value": §7's "Queue rows (wave 3…)" table, l. 331–348.

**Baselines at `7eb4398c`** (exit statuses read directly, outputs in the scratchpad):
- `claude_md_fact_audit.py --base 7eb4398c`: exit 0, AUDIT PASSED. `--dupes`: exit 0.
- `bib_audit.py`: exit 1 — 8 arXiv ids (1006.4491, 1411.2776, 1801.07802, 1804.01369, 1909.06866, 2208.07347, 2303.01089, 2608.24503) and one
  key (`[LacaWarren2018]`) unresolved; X29C's 4.3 covers seven ids and the key; **2208.07347 is not in X29C's drafts** (checked at stage 4).
- `fs71_ledger_b_check.py --strict`: exit 1, FAIL (34) — 17 FS100 §4 ids with no § B row (the drafts fix them); 17 §4 entries lacking strict
  fields; the headers of FS100-CX (a nested `[hand, one mind, blind]` inside the grade bracket) and FS100-X22 (no grade bracket) do not parse;
  X28D's theorems are a table, so its seven § B rows would have no entry.
- `CLAUDE.md`: **291,645 bytes** before.

**The owner's ruling (asked 07:1x; answered before 07:20), verbatim:** "yes — X10F's ruling applies to plans/FS100-derivation.md §4, and it
covers the seven X28D entries too. Mechanical fixes only: field labels where the content is already stated; addresses where it is absent; prior
art "X24R: not found in print" where X24R covered the claim, "standard local algebraic number theory; no gate run" for X28D-S and X28D-CUBE,
otherwise "none recorded at the close"; fix the FS100-CX and FS100-X22 headers so they parse (title and bracket only, words unchanged). For X28D,
add §4 entries FS100-X28D-* that copy each table row's statement and grade verbatim and point to X28D's sections. No mathematics, grade or
verdict changes. Commit it as its own stage, list every entry touched, and report the strict gate's exit status as read directly."

**Would have searched here (stage 1):** none.

## Stage 2 — SAVED (`plans/FS100-derivation.md` §4: the owner's mechanical ruling)

Applied by script (the scratchpad's `fixderiv4.py`; every old string asserted to occur once; X28D's statements and grades read from its table,
never retyped). `P` below = "the plan's §R-close (stage 5, wave 3)".
- **Headers (title and bracket only):** FS100-CX — the nested "[hand, one mind, blind]" inside the grade bracket → "(hand, one mind, blind)";
  FS100-X22 — the grade bracket "[hand; the claims two blind, TR-ROT's form and X22V-T4 one mind]" added after the title, copied from X29C's
  drafted § B line. Both now parse.
- **Fields added (labels or addresses; nothing else):** Q0 (verdict P 1.1 row Q-0; prior art none recorded), FAM (verdict 1.1 rows A-1, A-2),
  K0b (verdict 1.1 row A-3; prior art none recorded), 167 (verdict 1.1 row A-4; prior art "X24R: not found in print", X24R §2.1 — X24R's
  question 1 covered five for a real field without √3), B12 (verdict 1.1 rows B-1, B-2, 1.6; prior art none recorded), B3 (verdict 1.1 row
  B-3, 1.6; rests on it FS-59's stub line, P 4.6), CLS (verdict 1.1 row CLS, 1d), COR (proof X23D §3.3, X23V §2.4, P 1.3; verdict 1.1 row COR,
  1.3, 1d), CTL (proof X23D §2.2, X23V §2.1; verdict 1.1 row CTL; rests on it and prior art none recorded), D1 (proof X23D §4.2, X23V §2.6;
  verdict 1.1 row D-1; rests on it and prior art none recorded), DLP (verdict 1.1 row CLS, 1d; rests on it FS100-CLS's dyadic level bound; prior
  art none recorded), EXC (proof X23D stage 5 item 1, X23V §2.3, X26B §2.4; verdict P 1.3, 1d; prior art none recorded), G27 (proof X23D §2.1,
  X23V §4.2; verdict P 1d; rests on it FS100-CLS's Hoffman table; prior art none recorded), GF (proof X23V §2.2; verdict 1.1 row CLS; rests on
  it FS100-DLP's scope note; prior art none recorded), Q35 (proof X23D §4.1, X23V §2.5; verdict 1.1 row Q35; prior art none recorded), SPC
  (verdict 1.1 row SPC, 1c, 1d; prior art none recorded), TCA (verdict 1.1 row A-1, 1c; prior art none recorded), CX (proof X23D §3.2 step 3′,
  X23V §2.3, X26B §3.2; verdict P 1c, 1d; prior art none recorded), X22 (verdict P 1b; rests on it FS-98's stub line; prior art row 124's
  drafted clause on `[BergelsonMoragues2021]`, otherwise none recorded).
- **Seven new entries** after FS100-X22, before §G: FS100-X28D-P, -S, -CP1, -CP2, -CP3, -ODD, -CUBE — each statement and grade verbatim from
  `plans/FS100-X28D-derivation.md`'s table, *Proof:* its address there, *Proof verdict:* "one mind (X28D); not reconciled at the close — X28D
  reported after X29C", *Rests on it:* none recorded (CP2: FS100-COR's scope note, X28D §3.3 item 1), *Prior art:* "standard local algebraic
  number theory; no gate run" (S, CUBE; the owner's ruling) or none recorded, *Kernel:* no decision recorded (the owner's).
- **Launch note 3's one sentence, FS100-COR:** "*Scope (X28D):* the complex-place case is inhabited and not reducible to totally real fields
  by monotonicity — ℚ(√23, ∛2) has `L = 5` while its totally real subfields have `L ≤ 4` (FS100-X28D-CP2) — so FS100-CX is load-bearing there."

No grade, verdict or statement changed. **Gate:** `fs71_ledger_b_check.py --strict` exit 1, FAIL (26): exactly the 26 "has no § B row" lines
(X29C's 19 and X28D's 7), which stage 3's § B lines fix.

**Would have searched here (stage 2):** none.

## Stage 3 — SAVED (`LEDGER.md`: rows 123–125, corrections to rows 113, 117, 120, 121, 26 § B lines, the claim list)

Applied by script (the scratchpad's `ledger3.py`; every replacement asserted unique; the drafted rows and § B lines read from the plan file, never
retyped; every inserted row checked at 5 unescaped pipes, every § B line at 7). Departures from "apply exactly", each named:
- **Row 123, launch note 3's one sentence** after "…the circle inside the norm-one hyperbola.": "The complex-place case is inhabited and not
  reducible to totally real fields by monotonicity: ℚ(√23, ∛2) has `L = 5` while its totally real subfields have `L ≤ 4` (X28D-CP2), so the
  complex-place step is load-bearing there." Its address column gains `plans/FS100-X28D-derivation.md` §2.3, §3.3 and `tools/x28d_check.py`.
- **Row 120:** the draft replaces the span from "**EL2021 §2 … until it is read**" to "prior-art gate on MR pending, X24R" with one text; the
  clause between them, "PE-2's shape is Johnson's nonlacunary theorem (1992, review only) transposed", is a fact the draft does not supersede,
  so it is kept between the draft's two halves (EL2021 §2's reading before it; "MR not found under its discipline's names …" after it). The
  draft's `\"` written as plain quotes.
- **Row 121:** the draft's "and `χ = 5` at …" follows a full stop in the row ("(none is exhibited). At their grades: …"); written "Also `χ = 5`
  at ℚ(√143), ℚ(√311), ℚ(√335), `χ(ℚ(√167)²) ≥ 5` (row 123), and row 88 …". The other two replacements and "Keep the existence half …"
  as drafted.
- **Rows 113, 117:** as drafted (row 117's "Not claimed" keeps its closing full stop).
- **§ B:** X29C's 19 lines with the address column in the table's convention (`` `plans/FS100-derivation.md` FS100-Q0 ``); **X28D's seven**
  (launch note 3), mapped to row 123, statements in short form from X28D's table (FS100-X28D-CUBE's full statement holds `w | v`, whose pipe
  would split the cell; the short form takes its "hence" clause), grades as stated plus "one mind", kernel "undecided (the owner's)".
- **The claim list:** X29C 4.5 appended to the **Ours** list, ending with ";" as its predecessors do.

**Gates:** `fs71_ledger_b_check.py --strict` **exit 0, PASS** (778 § B rows). `claude_md_fact_audit.py --base 7eb4398c` **exit 0, AUDIT PASSED**
(LOST 0 in every class).

**Would have searched here (stage 3):** none.
