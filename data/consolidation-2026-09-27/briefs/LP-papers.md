*Brief for job **LP**: the papers — full reads of the four unread papers the project's claims wait on, folded in. Opus 5.5, 2026-09-27. Written by
the product owner. **Sized for about 350k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back with your work saved
when your own count reaches about 220k.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/consolidation-2026-09-27/briefs/STANDING-RULES.md` is part of
this brief; read it first, rule 0 first.** Then read from disk: `plans/CONSOLIDATION-2026-09-27.md` (the run, and Kooshi's words for it); `CLAUDE.md`
§ The aim, § Counter-priors, § Where the problem stands (items 14 and 31), § The prior-art position, and G49, G50; `CLOSED-QUESTIONS.md` in full;
`LEDGER.md` § The claim list and rows 52–57, 63, 73, 79, 82–83, 99, 119–123, 132; `BIBLIOGRAPHY.md` § R and the entries named below.

## Why this job exists

Kooshi, 2026-09-27: *"The goal of the run will be all of the low urgency items, and full reads of any important papers we haven't read yet,
folding in their info."* The journal's archive became accessible, and four papers our claims have waited on are now held:

| key | what our claims owe it | where it is |
|---|---|---|
| `[Johnson2006]` | `CLAUDE.md` item 14: *"nothing is claimed new while `[Johnson2000]` and `[Johnson2006]` are unread"*; rows 121 and 123 say "not found", never "first", while it is unread; it blocks FS-20 (the Theorem B paper, open item R2) and any novelty claim for the multiquadratic two-colour criterion (G38; row 63) | `~/source/library/pdf/johnson-2006-coloring-rational-points-forbid-distance-one-geombinatorics-16-1-209-218.pdf` — six sheets, journal pp. 208–219 |
| `[Johnson2000]` | the status report on Benda–Perles's problems; its zbMATH review lists as open *"determine the chromatic number of `(X, 1)` when `X` is a finite algebraic extension of `ℚ²`"*; it gates `CLOSED-QUESTIONS.md` §1.7 and §2.6 | `~/source/library/geombinatorics/geombinatorics-v09-n4-2000-04.pdf`, pp. 170–179 |
| `[BendaPerles2000]` | Open Problem 11.6 as `[Soifer2024]` reports it; its problem (4) (asked, per the bibliography, as χ of any algebraic extension of `ℚ²`); FS-20's open item R3 (quote the problem from the source) | `~/source/library/geombinatorics/geombinatorics-v09-n3-2000-01.pdf`, pp. 110–126 (Johnson's introduction pp. 110–112); also held as `~/source/library/pdf/BendaPerles2000-colorings-of-metric-spaces-geombinatorics-9-3-113-126.pdf` |
| `[Townsend2005]` | FS-108's two remaining items (`plans/STUB-regular-half-residuals.md`; `CLAUDE.md` § Paths forward, rank 5: *"three of five items answered at FS-110 (row 134); left: Townsend's (c) in full; `[Townsend2005]`"*); row 132's map-six clause rests on the 1979 manuscript and `[Woodall1973]`, each repairing the other | `~/source/library/geombinatorics/geombinatorics-v14-n4-2005-04.pdf`, pp. 184–193 |

All four are image scans (standing rule 9): find each paper's sheets by rendering at low resolution first, then read at 150 dpi or more.

## The task, in stages (save after each)

1. **Johnson 2006 in full.** Every statement verbatim with its page. Then, for each claim of ours it touches — rows 52–57 (the residue method,
   Theorems A and B), 63 (two colours), 73, 79, 82–83 (three and four colours over real quadratic fields, T4), 99, 119–123, and G38's two-colour
   criterion — say plainly which of three it is: **pre-empted** (the attribution moves; give the words), **partly** (say which part), or **not
   found in it**. Log every value or table it prints for a plane `ℚ(√m)²` or any field plane. Mine its reference list into `BIBLIOGRAPHY.md` the
   same stage (each reference an entry or an existing entry's update; titles seen only in the list are marked as such).
2. **Johnson 2000 and Benda–Perles 2000 in full**, Johnson's introduction included. The exact wording of every open problem either poses, and
   for each: does a row of ours answer it, in whole or in part, at what grade? Draft `CLOSED-QUESTIONS.md` rows for those that do (its §1–§3 form),
   and write them in. Mine both reference lists.
3. **Townsend 2005 in full, compared** with `[Townsend1979ms]` (`~/source/library/pdf/townsend-colouring-plane-no-monochrome-units-author-manuscript-1979-posted-2024.pdf`)
   and `[Soifer2024]` ch. 25 (pp. 253–266 of the book in `~/source/library/`). Is the printed text the manuscript's? Does its simplification (c)
   close the gap FS106-V3 found (`plans/FS106-V-verification.md` § Continuation — FS106-V3, and FS106-TW in `plans/FS106-derivation.md`)? If it
   argues (c) differently, check the argument at [hand, one mind] and say so. Then update FS-108's stub and draft the ranking-row change.
4. **The references that could pre-empt.** From the reference lists mined in stages 1–2, fetch (through the wrapper, standing rule 8) and read any
   Geombinatorics paper whose title or Johnson's description suggests a field-plane value, a residue or additive colouring, or a result on `ℚ(√m)²`,
   until your budget line; list the rest as ranked debts.
5. **Fold in, and report.** `BIBLIOGRAPHY.md`: every entry you touched, with read status per section, § R and § R.6 updated (the Geombinatorics
   rows now "held"). `LEDGER.md` § The claim list and the novelty sentences of affected rows: attributions moved or "not found in `[Johnson2006]`,
   `[Johnson2000]`" written in. Draft for the owner, in your record, every `CLAUDE.md` change owed (item 14's clause; § The prior-art position; any
   row pointer; the Publication paragraph's FS-102 line if its "`[Johnson2000]`, `[Johnson2006]` first" is now met), each with its byte cost.
   Then run `python3 tools/bib_audit.py` and `python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>`, each exit status read
   directly.

Also, as part of stage 5: `plans/FS110-tangency-seam.md` §R-close 4.3's BIBLIOGRAPHY drafts, and FS-106's and FS-107's (their §R-close), were
applied by the front-page jobs; check each draft against `BIBLIOGRAPHY.md` and apply any that was not, citing the draft's address.

## Rules

- **Touch only:** `BIBLIOGRAPHY.md` (the entries of the papers you read or mine, § R, § B rows for new library files — never the section the walk
  job LW adds, "§ G"), `CLOSED-QUESTIONS.md`, `LEDGER.md` (§ The claim list and the prior-art or novelty sentences of rows you name in your record;
  never § B, which the bookkeeping job owns), `plans/STUB-regular-half-residuals.md`, `~/source/library/notes/` (a reading note per paper), and
  `data/consolidation-2026-09-27/lp/`. Everything else by draft in your record.
- **Record:** `data/consolidation-2026-09-27/lp/record.md`, with a heading "Theorems this phase proved" (a [hand] check of Townsend's (c) is one).
- **Hold anything answer-moving at one mind** and say so: this job moves attributions, not the answer.
- Commits by explicit path, subjects "LP: stage n". Never amend; push after each; never force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Report** to `data/consolidation-2026-09-27/reports/LP.md`, committed, and by SendMessage to `"main"`, with: each paper's verdict on our claims
  (pre-empted / partly / not found), the CLOSED-QUESTIONS rows written, Townsend 2005's verdict on (c), the debts left, the `CLAUDE.md` drafts
  with byte costs, and each gate's result. Your final turn's text: "LP idle; report sent to the owner by SendMessage".

Thank you.
