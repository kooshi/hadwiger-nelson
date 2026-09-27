*Brief for job **LV**: a second reading of the papers job's attribution moves, before any reaches `CLAUDE.md`. Opus 5.5, 2026-09-27. Written by
the product owner. **Sized for about 300k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back with your work saved
when your own count reaches about 180k.** The last two jobs overran their lines; check your own count at every stage boundary.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/consolidation-2026-09-27/briefs/STANDING-RULES.md` is part of
this brief; read it first, rule 0 first.** Then read from disk `plans/CONSOLIDATION-2026-09-27.md`, `CLAUDE.md` § The prior-art position, § Where the
problem stands items 14 and 16, and G49, G56, G63; `LEDGER.md` rows 52–57, 73, 100, 107, 121, 129 and § The claim list.

## Why this job exists

Job LP read `[Johnson2006]`, `[Johnson2000]`, `[BendaPerles2000]` (with Johnson's introduction), `[Townsend2005]` and two Johnson papers on the
fractional chromatic number, and moved credit in `CLOSED-QUESTIONS.md`, `LEDGER.md` and `BIBLIOGRAPHY.md` at one mind (its report:
`data/consolidation-2026-09-27/reports/LP.md`; record `data/consolidation-2026-09-27/lp/record.md`, commits 5cb2bdd5 … b1b09356). None moves the answer,
but several change what this project will call its own when it publishes, and seven drafts would carry them into `CLAUDE.md`. The run's rule for
this: one reader is not enough before a claim of ours is given away or kept. The walk job's second reading changed two of its first reader's
verdicts; expect the same here.

## The task, in stages (save after each)

1. **Read the sources first**, before LP's words on them: for each claim below, the pages named, from the held files (image scans — standing rule 9;
   `~/source/library/geombinatorics/geombinatorics-v09-n3-2000-01.pdf`, `…-v09-n4-2000-04.pdf`, `…-v14-n4-2005-04.pdf`,
   `~/source/library/pdf/johnson-2006-coloring-rational-points-forbid-distance-one-geombinatorics-16-1-209-218.pdf`, and the two Fischer 1990 papers — `[Fischer1990]`, *Additive k-colorable
   extensions of the rational plane*, at `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`, and `[Fischer1990b]`, *The connected
   components of the graph `Q(√N₁, …, √N_d)²`*, at `~/source/library/pdf/fischer-1990-connected-components-Q-sqrtN1-sqrtNd-congr-numer-72-pp213-221.pdf`
   — confirm which one holds the Thm 1(i) LP cites).
   - **P1, Theorem A.** LP: its construction — a homomorphism out of the unit-vector subgroup, copied coset by coset — is `[Fischer1990]`
     Thm 1(i), and `[Johnson2006]` p. 213 states it for every `G(S, D)`; what stays ours is "the metric-free statement and the kernel proof". State
     Theorem A exactly as the ledger does (rows 52–57), then say what the print holds, word for word, and what is left ours.
   - **P2, the bridge.** LP: `χ(ℝ²) = sup` over number fields (by Tarski) is Benda–Perles's, pp. 117–118; `[Madore2015]` ¶5.4 restates it; and
     the unit-vector ring of ℚ, `ℤ[i][1/p : p ≡ 1 (4)]`, is theirs, p. 120. Check against row 107, G56 and G63.
   - **P3, the posed questions.** `[Johnson2000]` p. 176 and `[Johnson2006]` p. 214, verbatim; do rows 73 and 121 answer them, and at what
     grades? Check `CLOSED-QUESTIONS.md` §1.1, §1.2, §1.7, §2.3, §2.6, §2.7, §2.8 and §3 as LP left them, row by row, against the sources and
     against the ledger rows they cite; for §2.8, S–V Question 2's quotation against the held `[SokolovVoronov2025]` and its polarity against row 134.
   - **P4, Fischer 1994 cited.** Both surveys restate `χ(K²) = 4` from `[Fischer1994]`: check, since it makes `WORKFLOW.md` 3.2 item 8's "nothing
     cites it" false.
   - **P5, Townsend.** The 2005 paper is the 1979 manuscript word for word: spot-check simplification (c) and two other passages; and
     `[Soifer2024]` ch. 25 is Townsend's 2007 exposition, not a reprint.
   - **P6, LP's derived claims, one mind each:** the fractional Benda–Perles–Tarski property given MR [derived]; §2.7's disconnectedness
     [derived]. Check each at [hand] or say where it fails.
2. **Verdicts and corrections.** For each of P1–P6: agree, or differ with the source's words. Where you differ, correct LP's edit in place in
   `CLOSED-QUESTIONS.md`, `LEDGER.md` (claim list and novelty sentences only) or `BIBLIOGRAPHY.md` (LP's entries only), and log each correction in
   your record with the old and new text. Then check LP's seven `CLAUDE.md` drafts (its record, stage 5: D-1 … D-7) and its `WORKFLOW.md`, G49-
   instance and FS-20 drafts against your verdicts, and hand the owner the corrected set, each with its byte cost.
3. **Zaks 1999** (LP's debt 1; Geombinatorics IX(2), held — find it with `ls ~/source/library/geombinatorics/`): read it in full. LP's note is
   that it is `ℚ⁴`'s version of row 59's valuation law; say whether it pre-empts anything of ours, and add its entry.
4. **Gates and report.** `python3 tools/bib_audit.py` and `python3 tools/claude_md_fact_audit.py --base 2d229561`, each exit status read directly.

## Rules

- **Touch only:** `CLOSED-QUESTIONS.md`; `LEDGER.md` (§ The claim list and the prior-art or novelty sentences of rows LP touched — never § B);
  `BIBLIOGRAPHY.md` (LP's entries and a new entry for Zaks 1999 — never § G, which job LW2 is writing; commit it promptly after each edit, since two
  jobs write the file); `plans/STUB-regular-half-residuals.md`; and `data/consolidation-2026-09-27/lv/`. Everything else by draft in your record.
- **Record:** `data/consolidation-2026-09-27/lv/record.md`, with a heading "Theorems this phase proved".
- Commits by explicit path, subjects "LV: stage n". Never amend; push after each; never force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Report** to `data/consolidation-2026-09-27/reports/LV.md`, committed, and by SendMessage to `"main"`, with each verdict, every correction made,
  the corrected `CLAUDE.md` drafts with byte costs, Zaks's verdict, and each gate's result. Your final turn's text: "LV idle; report sent to the
  owner by SendMessage".

Thank you.
