*Brief for job **FS106-C**: the close of FS-106, the regular half (WORKFLOW step 9): its mathematics and its drafts. Opus 5.5, 2026-09-27.
Written by the product owner. Its template is FS-105's close brief (`data/fs105/briefs/C105-close-math.md`); follow that brief's form wherever
this one is silent. **Sized for about 250k tokens by the harness's count. Your own count runs at 55–70 % of the harness's, so hand back when
your own count reaches about 200k.** A front-page job (FS106-X) applies your drafts afterwards.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the close planner, in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is part
of this brief; read rule 0 first.** Read from disk:
- `CLAUDE.md`'s header rules, § The aim and § Counter-priors;
- `WORKFLOW.md` step 9, in full;
- `LEDGER.md` rows 40 and 120–130, with their § B lines.

**If `plans/FS106-regular-half.md` already has a section "§R-close", you are resuming.**

## What you work from

- **`plans/FS106-close-inventory.md`** (items 1 onward). Tick each item "done", or "declined" with the reason; you may edit its status
  column. Read every number from the item's source, never from the inventory.
- **The reports in `data/fs106/reports/`** and the records they name. Read each record's "Theorems this phase proved" first.
  - Wave 1 (sighted, one continuing record): `plans/FS106-V-verification.md`, with FS106-V, § Continuation — FS106-V2 and § Continuation —
    FS106-V3.
  - Wave 1 (blind): `plans/FS106-VB-verification.md`.
  - Wave 2 (derivations): `plans/FS106-TS-derivation.md` (structural) and `plans/FS106-TQ-derivation.md` (quantitative).
  - Wave 3 (blind second minds): `plans/FS106-SB-verification.md` on TS and `plans/FS106-QB-verification.md` on TQ.
- **The advisors' records:** `plans/POROS-2026-09-26-fs106-regular-half.md` (FS106-A, wave 1's comparison) and
  `plans/POROS-2026-09-27-fs106-close-and-fs107.md` (FS106-A2: the comparison of waves 2 and 3, the scoring, FS-107's design).
- **The plan** `plans/FS106-regular-half.md` (§G, §PA, §IQ, §5.3's E1–E12) and the claim list `data/fs106/claims.md`.

## The headline rules

- **Grades come from the minds that actually derived.** A result derived by a deriver and confirmed by a blind second mind is two minds, one
  blind. A result the blind mind did not reach stays one mind.
  - TQ-EQ is the flattering one (G21). Grade it exactly as QB and A2 leave it.
  - Name every open step: SV-2's `d = 2` edge case; SV-1's fill step (Prop. 19); Townsend's Thm 5 at (c) and Woodall's fill for it; C-AE-Q2's
    [G1]–[G3].
- **Propose the new ledger rows** (the next free number is 131; rows are never renumbered). Say for each result whether it earns its own row
  or a § B line. My expectation, which you may overrule with a reason:
  - one row for **the stability form**: TQ-EQ, TQ-SUP, TQ-EPS2 and TQ-HIT, and A2's PD-EQ if it is confirmed;
  - one row for **the regular classes almost everywhere**: C-AE-SLACK, C-AE-POLY, C-AE-CONV, C-AE-NICE, C-AE-CLOSED's equivalence, and maps
    needing six (Townsend's manuscript with Woodall's step), each with its grade and open step;
  - § B lines for the corrections to print (Voronov's repairs, Sokolov–Voronov's, Townsend's) and for the lemmas (TS-U, TS-L1, TS-C, TS-C′,
    TS-T, lemma (L), C5, the diameter lemma).
- **Row 40's correction** (items 25 and 28): its condition is `[Voronov2023]` Thm 1.3 alone.
- **Draft the `CLAUDE.md` corrections**, each in current-state wording:
  - **§ The aim, link 4:** `[Townsend1981]` prints no proof. The map-six proof is Townsend's manuscript (the published `[Townsend2005]` is
    unheld), repaired by Woodall's step. S–V's polygon theorem stands repaired except at `d = 2`. Their map theorem is a GAP at the fills.
    Voronov's theorems hold after local repairs, and the paper is still an unrefereed preprint. Thomassen holds almost everywhere.
  - **§ The aim, links 5 and 6 and the program paragraph:** rewrite them in TQ-EQ's terms if QB confirms it. A2 proposes this, with a rename
    of FS-107 (item 62). **The rename and the reframe of link 5 are the owner's decision.** Draft both versions, the renamed one and the
    current name with link 5 sharpened, and state your recommendation.
  - **"Where the problem stands", item 31;** "Last updated"; "Open milestones"; the paths-forward rows 1–3.
- **The FS-107 stub:** draft its re-aim from A2's §3. Add the stubs to mint (items 36, 52, 57) as `plans/FRONTIER-STUBS.md` rows and stub
  files; your drafts go in §R-close, and the stub files you may write directly.
- **Instances and records:**
  - the G51 run (`plans/PROTOCOL-competitor-and-advisor.md` §3's form);
  - G72's count and G79's record, for FS-106;
  - the agents' token misreport (items 48, 54: three of three agents that night), as an instance under § Delegation's replacement rule;
  - the quotation slips (items 38, 40), as a standing-rule-5 instance.

## Stages (save after each)

1. **Reconciliation.** Every claim in `data/fs106/claims.md` and every new lemma, with its verdict, its minds and their blindness, and every
   divergence and how it was settled. Save.
2. **`plans/FS106-derivation.md`** (new), in `plans/FS105-derivation.md`'s entry form. Save.
3. **§R-close in `plans/FS106-regular-half.md`:**
   - the §G re-read;
   - the §PA sweep for recognitions (what did we learn about the object?);
   - the §IQ re-read, with G72's count and G79's record;
   - §5.3's E1–E12 scored;
   - the verdict in four parts;
   - the would-have-searched lines.

   Save.
4. **Drafts in §R-close, never in the target files:**
   - the `LEDGER.md` rows and § B lines;
   - the `CLAUDE.md` lines;
   - `BIBLIOGRAPHY.md`: V3's rows (item 56), Townsend's manuscript as its own key, `[BendaPerles2000]` and `[Parts2020c]` held,
     Ambrosio–Caselles–Masnou–Morel 2001 and Parts 2022 unheld;
   - `CLOSED-QUESTIONS.md`: say whether anything here answers a posed question (S–V's §9 hypothesis, S–V's Question 2, Benda–Perles's
     problem (4)), and do not stretch;
   - the `plans/FRONTIER-STUBS.md` rows (FS-106 to the closed list);
   - the GROKKING-INSTANCES entries;
   - `data/fs106/claims.md`'s corrections (item 50), as an appended section you may write directly.

   **The budget:** `CLAUDE.md` is at 304,245 bytes. Its 300,000 limit was suspended only for the 2026-09-26 reframe, and it returns at this
   close. Draft so that the front page can bring the file under 300,000 without cutting an intrinsic. Where a new line can point to a ledger row
   instead of retelling it, make it point. Save, then write the report.

## Rules

- **Touch only:** `plans/FS106-derivation.md`, `plans/FS106-regular-half.md` (§R-close), `plans/FS106-close-inventory.md` (status cells),
  `plans/STUB-regularity-wall.md`, new stub files, `data/fs106/claims.md` (the appended section), and `data/fs106/fs106-c/`. Never touch the
  front files, the protocols or the instances file; the front-page job writes those.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Commits:** by explicit path, with subjects "FS106-C: stage n". Never amend. Push; never force-push.
- **Report** (standing rule 9) to `data/fs106/reports/FS106-C.md`, committed, and by SendMessage to "main". Your final turn's text: "FS106-C idle;
  report sent to the owner by SendMessage".

Thank you.
