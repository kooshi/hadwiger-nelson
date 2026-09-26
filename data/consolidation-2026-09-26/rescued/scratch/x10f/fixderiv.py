import sys
P = "plans/FS100-derivation.md"
t = open(P, encoding="utf-8").read()
RC = "the plan's §R-close (stage 5)"
NONE = "none recorded at the close; the X24R gate is running."
edits = [
# 1. Q47: keys out of the grade bracket, into the prior-art field; verdict and rests-on labelled
("`χ ≤ 5` row 52 at 11 (`47 ≡ 5² (mod 11)`), prior art `[Moorhouse2010]`, `[Madore2015]`. The consequences",
 "`χ ≤ 5` row 52 at 11 (`47 ≡ 5² (mod 11)`), prior art. The consequences"),
("*Proof:* the ladder, the plan's §R-close stage 1, 1.2 (L1–L6), no link broken. *Tools:*",
 f"*Proof:* the ladder, the plan's §R-close stage 1, 1.2 (L1–L6). *Proof verdict:* no link broken ({RC} 1.2, 1b). *Tools:*"),
("none exhibited); Exoo–Ismailescu's smallest-subfield question in part (ℚ(√47) is the first real quadratic field needing five). *Prior art:* **a\ngate on the value is owed**",
 f"none exhibited); Exoo–Ismailescu's smallest-subfield question in part (ℚ(√47) is the first real quadratic field needing five). *Rests on it:* {RC}\n1b (\"What the headline answers\") and 4.4 (FS-84, FS-59). *Prior art:* the upper bound `χ ≤ 5` is `[Moorhouse2010]`, `[Madore2015]` (row 52); **a\ngate on the value is owed**"),
# 2. HX1
("*Rests on it:* nothing in the chain (the advisor's stage-0 irreducibility remark). *Prior art:* `[LevitzMott1972]` Thm 2.3",
 f"*Proof:* X02D §2.1 (X02D-HX1); X02V §2.1 (X02V-1); X01V's held proof (the close inventory, item 18). *Proof verdict:* TRUE by all three ({RC} 1.1,\nrow HX-1). *Rests on it:* nothing in the chain (the advisor's stage-0 irreducibility remark). *Prior art:* `[LevitzMott1972]` Thm 2.3"),
# 3. MR
("*Proof:* X01D §4.1, §4.3; X01V §2.4, §4.3; X02V §3.2; X12B §3.2. MR uses neither R-U nor `m(E) = 0`. *Rests on it:* FS100-Q47;",
 f"*Proof:* X01D §4.1, §4.3; X01V §2.4, §4.3; X02V §3.2; X12B §3.2. MR uses neither R-U nor `m(E) = 0`. *Proof verdict:* {RC} 1.1, row EF-MR,\nand 1.2, link L3. *Rests on it:* FS100-Q47;"),
# 4. PE1
("*Proof:* X02D §2.2; X02V §2.2 (Lemma TI by Krull dimension one). *Tools:* `tools/x02d_pe1_counterexample.py`",
 f"*Proof:* X02D §2.2; X02V §2.2 (Lemma TI by Krull dimension one). *Proof verdict:* {RC} 1.1, row PE-1. *Tools:* `tools/x02d_pe1_counterexample.py`"),
# 5. EFZ
("integer). *Rests on it:* SP-Cor's P4;",
 f"integer). *Proof verdict:* valid on the close's check ({RC} 1b, \"Lemma Z's `α/ᾱ`\"). *Rests on it:* SP-Cor's P4;"),
# 6. EFG
("*Tools:* `tools/x01d_unit_check.py`, `tools/x01v_entropy_check.py` (Sturm count;",
 f"*Proof:* X01D §2.1 (EF-G); X01V §2.2 (X01V-T1–T3); X12B §2.5 (X12B-G). *Proof verdict:* {RC} 1.1, row EF-G. *Tools:* `tools/x01d_unit_check.py`,\n`tools/x01v_entropy_check.py` (Sturm count;"),
# 7. EFX
("*Rests on it:* FS100-CE1's refutation of (H). *Kernel:* declined.",
 f"*Proof:* X01D §2.2 (EF-X); X01V §2.1 (X01V-T4). *Proof verdict:* {RC} 1.1, row EF-X. *Rests on it:* FS100-CE1's refutation of (H).\n*Prior art:* {NONE} *Kernel:* declined."),
# 8. CE1
("*Correction owed:* X02V §3.2's \"MR … is no harder than that classical open question\" — (HF) is false, not open. *Kernel:* declined.",
 f"*Proof:* X02D §4.1 (X02D-HF), §4.2 (X02D-LT); X02V §2.4 (X02V-5). *Proof verdict:* {RC} 1.1, row CE-1. *Rests on it:* {RC} 3.2 item 5.\n*Prior art:* {NONE}\n*Correction owed:* X02V §3.2's \"MR … is no harder than that classical open question\" — (HF) is false, not open. *Kernel:* declined."),
# 9. FR1
("(= X03D-FR1; X02V-6.) [hand; two blind]** *Kernel:* declined (one line each way).",
 f"(= X03D-FR1; X02V-6.) [hand; two blind]**\n*Proof:* X03D §2.1 (X03D-FR1); X02V §2.5 (X02V-6). *Proof verdict:* {RC} 1.1, row FR-1. *Rests on it:* {RC} 3.2 item 4. *Prior art:* {NONE}\n*Kernel:* declined (one line each way)."),
# 10. ED1
("(= X03D-ED1, ED1-R; X02V-7.) [hand; two blind]** *Kernel:* declined.",
 f"(= X03D-ED1, ED1-R; X02V-7.) [hand; two blind]**\n*Proof:* X03D §2.2 (X03D-ED1, ED1-R); X02V §2.6 (X02V-7). *Proof verdict:* {RC} 1.1, row ED-1. *Rests on it:* none recorded; the ladder\n({RC} 1.2) does not use it. *Prior art:* the ED gate not run (the close inventory, item 90). *Kernel:* declined."),
# 11. ED2
("line blind to its five largest primes, a plant that fires by `0.24·10⁻³`); `tools/x13r_check.py`. *Rests on it:* nothing in the chain — it",
 f"line blind to its five largest primes, a plant that fires by `0.24·10⁻³`); `tools/x13r_check.py`. *Proof:* X03D §4.1–4.3 (X03D-ED2), §4.4 (X03D-Z,\nX03D-ED1′). *Proof verdict:* X03D-ED2 and X03D-Z VALID on X13R's reading (`plans/FS100-X13R-check.md`; {RC} 1b). *Prior art:* the ED gate\nnot run (the close inventory, item 90). *Rests on it:* nothing in the chain — it"),
# 12. FLK
("(= X03D-FL-K, FL-1a; X05V-4.) [hand; two blind]** *Kernel:* declined.",
 f"(= X03D-FL-K, FL-1a; X05V-4.) [hand; two blind]**\n*Proof:* X03D §3.2 (X03D-FL-K, FL-1a); X05V §3.1 (X05V-4). *Proof verdict:* {RC} 1.1, rows FL-1, FL-2 (their GAP is FS100-FLH's step). *Rests on it:*\nFS100-FLH; {RC} 3.3 (G79's record). *Prior art:* {NONE} *Kernel:* declined."),
# 13. SPEC
("*Tools:* `tools/x03d_factor_minima.py`; `tools/x05v_checks.py` checks 2b, 3, 4. *Kernel:* declined.",
 f"*Proof:* X03D §3.3 (X03D-SPEC); X05V §3.1 (X05V-6). *Proof verdict:* {RC} 1.1, row FL-1 (\"one step, two wordings\"). *Tools:*\n`tools/x03d_factor_minima.py`; `tools/x05v_checks.py` checks 2b, 3, 4. *Rests on it:* FS100-FLH. *Prior art:* {NONE} *Kernel:* declined."),
# 14. FLH
("*Rests on it:* the stub QTCA_κ (held for Kooshi: drafted, not minted). *Kernel:* declined.",
 f"*Proof:* X03D §3.4 (X03D-FL-H), §3.5 (X03D-FL-12, FL-Q); X05V §3.1 (X05V-5), §3.2 (X05V-7, 8). *Proof verdict:* {RC} 1.1, rows FL-1, FL-2.\n*Rests on it:* the stub QTCA_κ (held for Kooshi: drafted, not minted). *Prior art:* {NONE} *Kernel:* declined."),
]
for old, new in edits:
    n = t.count(old)
    if n != 1:
        sys.exit(f"STOP: {n} occurrences of: {old[:80]}")
    t = t.replace(old, new)
open(P, "w", encoding="utf-8").write(t)
print("applied", len(edits))
