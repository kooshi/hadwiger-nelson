*Brief for job **FS110-C**: the close of FS-110, "the tangency seam" (WORKFLOW step 9), covering its mathematics
and its drafts. Opus 5.5, 2026-09-27. Written by the product owner. Its template is FS-107's close brief (`data/fs107/briefs/C107-close-math.md`):
follow that brief's form wherever this one is silent. **Sized for about 250k harness tokens. Your own count runs at 55–70 % of it, so hand back
when your own count reaches about 200k.** A front-page job (FS110-X) applies your drafts afterwards.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the close planner, in `/home/kooshi/source/lean-dir`. **`data/fs110/briefs/STANDING-RULES.md` is part
of this brief; read rule 0 first.** Read these from disk:
- `CLAUDE.md`'s header rules, § The aim and § Counter-priors, and G82;
- `WORKFLOW.md` step 9 in full;
- `LEDGER.md` rows 131–133 with their § B lines.

**If `plans/FS110-tangency-seam.md` already has a section "§R-close", you are resuming.**

## What you work from

- **`plans/FS110-close-inventory.md`.** Tick each item "done", or "declined" with the reason; you may edit its status column only. Read every
  number from the item's source, never from the inventory.
- **The reports in `data/fs110/reports/` and the records they name.** Read each record's "Theorems this phase proved" first, section by section.
  - The proof side: `plans/FS110-N-proof.md` (FS110-N, then its continuation sections for N2 and N3).
  - The construction side: `plans/FS110-Y-construction.md` (FS110-Y, then its continuation sections for Y2 and Y3).
  - The blind verifiers: `plans/FS110-NB-verification.md` and `plans/FS110-YB-verification.md`, plus any round-3 verifier's record.
  - The prior-art check: `plans/FS110-PA-prior-art.md`.
  - The advisors: `plans/POROS-2026-09-27-fs110-tangency-seam.md` (planning) and `plans/POROS-2026-09-27-fs110-competition.md` (A2 through A5).
- **The plan and the claims:** the plan `plans/FS110-tangency-seam.md` (§G, §PA, §IQ, E1–E13), and `data/fs110/claims.md`, including §7 (W-3) and
  §7.1.

## The headline rules

- **Grades come from the minds that actually derived.** A lemma a blind verifier confirmed is two minds, one blind; one it did not reach stays at one
  mind. Name every open step.
- **The headline, as round 4 left it** (FS110-A6's § A6-2.1; state it with the grade the verifiers leave it at): *"Under Condition 5, no locally
  finite map whose boundaries are segments and circular arcs, none of radius 1, carries an a.e.-proper six-colouring."* **Polarity:** S–V
  Question 2 asks "Is it true that 7 colors are needed …?", so its Condition-5 half is answered **YES**. N4, its report and some owner text say "NO";
  correct every such place (inventory item 97). The chain behind it:
  - NB-4 and NB-5;
  - W-MERGE, which is Woodall's step 3 almost everywhere;
  - N4's cone removal: SHAVE, RAY, STUCK, PROP, FIN, TERM and CONE;
  - the base, S–V Cor. 1 almost everywhere with no `d = 2` exception (CB and CD, both blind);
  - **the base at cusp sectors**, which FS110-CC is checking. A doubly shadowed single horn survives every operation (A6-C2, exact), so the base must
    cover cubic vertices with a cusp sector.

  **Its grade is one mind until FS110-NB4 (blind on N4's chain) and FS110-CC report.** Read their reports, and grade the headline exactly as they
  leave it.
  - If either finds a GAP, the headline is a reduction to that step, and says so.
  - Card A6-C1 asks whether "at bounded `K`" can be dropped (nothing in N4, CB or CD uses `K`). Take NB4's answer.
- **The reconciliation includes the round-4 verifiers:** compare FS110-NB4 with N4, and FS110-YB4 with Y4. No advisor did this, because FS110-A6
  handed back first. Include every divergence and the final count of minds.
- **Row 132's correction:** FS106-SV2, FS106-AE-POLY and FS106-AE-CONV lose their `d = 2` exception. FS110-CB and FS110-CD, both blind and by
  different routes, give S–V Cor. 1 with no `d = 2` exception, and CD's Theorem D2 closes FS106-SV2's edge case for same- and disjoint-multicolour
  pairs. **FS106-SV2's weakest link**, the sketch of the Lemma 3 repair, is now CB's full derivation. Draft row 132's new text.
- **Propose ledger rows.** The next free number is 134; rows are never renumbered. My expectation, which you may overrule with a reason:
  - one row for the Condition-5 closure and its reduction to W-3, containing NB-4, NB-5, N2-RING, N2-SWAP, N2-TRANS, N2-FLIP, N-X, Y2-W4, YB-V5X
    and C-CUSP-K, each at its grade;
  - § B lines for the fragments (S1, T2, BB, MX, exact, two checkers), the local calculus, and everything else.
- **Prior art (FS110-PA):**
  - Condition 5 without Condition 6 is unsettled, unstated and unasked in print.
  - S–V Lemma 2 is NB-4's four-colour half.
  - Soifer 2024 ch. 25 reprints Townsend's step (c) with its gap.

  Say whether anything answers a posed question (`CLOSED-QUESTIONS.md`), and do not stretch.
- **The next stubs:** the unit-arc branch ((S1), T2, NB-4's exception, A4-SIX-ARCS) and W-3 itself, if round 3 leaves it open. Place both with FS-111,
  and name the stub each goes into or the new stub each needs.
- **The protocol:** FS-110's run record (§3's form), with its retractions, the three rounds, the advisor successions, and the routing effect (a side's
  message resumes an advisor and takes its hand-back; inventory items 31 and 37). Draft the protocol amendment: no agent messages another after its
  own hand-back.
- **Instances:**
  - G51's run;
  - G72's count and G79's record for FS-110;
  - the owner's quotation slips (items 2, 23, 46, 63), including line-range cuts in quoted blocks — twice, a new failure shape;
  - the fence listings.

## Stages (save after each)

1. **Reconciliation:** every claim and lemma, with its verdict, its minds and their blindness, every divergence and how it was settled. Save.
2. **`plans/FS110-derivation.md`** (new), in `plans/FS107-derivation.md`'s entry form. Save. The ledger checker
   `tools/fs71_ledger_b_check.py` skips three header shapes silently (FS-106 item 83; FS-107 item 39), so every header must:
   - use an ASCII id;
   - put no parenthetical before the dash;
   - nest no brackets inside a grade.

   Run the checker's `--strict` on your draft before you save.
3. **§R-close** in `plans/FS110-tangency-seam.md`. Save. It covers:
   - the §G re-read;
   - the §PA sweep;
   - the §IQ re-read, with G72's count and G79's record;
   - E1–E8 scored, together with every competitor's and advisor's registered prediction;
   - the verdict, in four parts;
   - the would-have-searched lines.
4. **Drafts in §R-close, never in the target files.** Save, then write the report. The drafts:
   - the `LEDGER.md` rows and § B lines;
   - the `CLAUDE.md` lines, namely:
     - "Last updated";
     - "Open milestones";
     - the paths-forward rows, with FS-110 closed and its successor stubs ranked;
     - "Where the problem stands", item 31;
     - G82;
     - any correction owed;
   - `BIBLIOGRAPHY.md`: FS110-PA's four proposed edits, Soifer 2024 ch. 25, `[Woodall1973]` §3's reading status (read by NB3 and Y4), the unheld
     titles of inventory item 8, and the two citations that now fail `tools/bib_audit.py`: arXiv:1305.5229 (in `data/fs110/reports/FS110-P.md`) and
     `[MartiniMontejanoOliveros2019]` (in `plans/FS110-tangency-seam.md`);
   - `plans/FRONTIER-STUBS.md`: FS-110 to the closed list, and the new or re-aimed stubs ranked;
   - the GROKKING-INSTANCES entries;
   - the protocol amendment;
   - the claim-list corrections (items 21, 26), as an appended section of `data/fs110/claims.md`, which you may write directly.

   **The budget:** `CLAUDE.md` is at 295,695 bytes after the ranking pass, against its 300,000 limit. Every new line must be paid for: point to ledger rows instead
   of retelling them, and move later instances out. Draft so that the front page lands under the limit without cutting an intrinsic.

## Rules

- **Touch only:** `plans/FS110-derivation.md`, `plans/FS110-tangency-seam.md` (§R-close only), `plans/FS110-close-inventory.md` (status cells only),
  `plans/STUB-tangency-seam.md`, new or re-aimed stub files, `data/fs110/claims.md` (the appended section), and `data/fs110/fs110-c/`. Never
  touch the front files, the protocols or the instances file.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Commits:** by explicit path, with subjects "FS110-C: stage n". Never amend. Push after each; never force-push.
- **Report** (standing rule 9) to `data/fs110/reports/FS110-C.md`, committed, and by SendMessage to "main". Your final turn's text: "FS110-C idle;
  report sent to the owner by SendMessage".

Thank you.
