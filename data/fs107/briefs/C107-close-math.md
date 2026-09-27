*Brief for job **FS107-C**: the close of FS-107, "stability: can vanishing holes save a colour?" (WORKFLOW step 9), covering its mathematics
and its drafts. Opus 5.5, 2026-09-27. Written by the product owner. Its template is FS-106's close brief (`data/fs106/briefs/C106-close-math.md`):
follow that brief's form wherever this one is silent. **Sized for about 250k harness tokens. Your own count runs at 55–70 % of it, so hand back
when your own count reaches about 200k.** A front-page job (FS107-X) applies your drafts afterwards.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the close planner, in `/home/kooshi/source/lean-dir`. **`data/fs107/briefs/STANDING-RULES.md` is part
of this brief; read rule 0 first.** Read these from disk:
- `CLAUDE.md`'s header rules, § The aim and § Counter-priors, and G82;
- `WORKFLOW.md` step 9 in full;
- `LEDGER.md` rows 129–132 with their § B lines.

**If `plans/FS107-stability.md` already has a section "§R-close", you are resuming.**

## What you work from

- **`plans/FS107-close-inventory.md`.** Tick each item "done", or "declined" with the reason; you may edit its status column only. Read every
  number from the item's source, never from the inventory.
- **The reports in `data/fs107/reports/` and the records they name.** Read each record's "Theorems this phase proved" first.
  - The competitors: `plans/FS107-R-stability.md` and `plans/FS107-W-near-colourings.md`.
  - The blind verifiers: `plans/FS107-V-verification.md` (on R) and `plans/FS107-VW-verification.md` (on W).
  - The advisors: `plans/POROS-2026-09-27-fs107-stability.md` (planning) and `plans/POROS-2026-09-27-fs107-competition.md` (competition; its §5 is
    the round's verdict).
- **The plan** `plans/FS107-stability.md` (§G, §PA, §IQ, E1–E8) and the claim list `data/fs107/claims.md`.

## The headline rules

- **Grades come from the minds that actually derived.** A lemma the blind verifier confirmed is two minds, one blind; one it did not reach stays
  one mind. Name every open step: R's (A)/(A″) and (B); W's doors; C-AE-Q2's [G1]–[G4]; SV-2's `d = 2`.
- **Propose ledger rows.** The next free number is 133; rows are never renumbered.
  - My expectation, which you may overrule with a reason: **one row for the meeting point**, containing:
    - the two reductions: R's RR and W's W-EQ-K;
    - the quantified cone lemma, FS107-R-CP ≡ W-TAN;
    - the tangency-seam question they meet at;
    - the no-gos (FS107-R-OB′; W-POLY; HX-STALL's stall value as a measured fact about one family).
  - Everything else goes into § B lines.
- **G82's reading:** "feature-local" becomes "a defect at an `ε`-independent scale" (items 16, 26). Draft the correction, and score G82's killing test
  against RR.
- **The next milestone.** The owner ruled (item 28) that the tangency-seam question opens as its own milestone.
  - **Write its stub** (`plans/STUB-tangency-seam.md`, FS-110) at the depth of the stub rule (WORKFLOW step 2), with a provisional-bearings line. Its
    question: does a tight six-map exist whose complementary vertex pairs within distance 2 are all tangent pairs or bowties? YES is `χ(ℝ²) ≤ 6`
    with no MR; NO answers S–V Question 2 almost everywhere.
  - **Also write the stubs** for REG-SCALE, SWAP-PRICE / bicycle-free Voronov and the C-VOID thin-hole refutation. Fold each into an existing stub
    where one fits (FS-108 holds FS-106's print residuals), and say why.
- **The protocol:** FS-107 amended §1 rule 1 in practice. Records live in `plans/`, fenced by path and committed per stage; worktree isolation is
  the fallback. Draft the amendment and the run record (§3's form). Include the harness note that a competitor's SendMessage to an idle advisor
  resumes it, and routes its hand-back notices to that competitor (item 22).
- **Instances:** G51's run; G72's count and G79's record for FS-107; the quotation slips (items 2, 21); the fence listings (items 17, 27).

## Stages (save after each)

1. **Reconciliation:** every claim and lemma, with its verdict, its minds and their blindness, every divergence and how it was settled. Save.
2. **`plans/FS107-derivation.md`** (new), in `plans/FS106-derivation.md`'s entry form. **Never nest brackets inside a grade** (FS-106 inventory
   item 83). Save.
3. **§R-close** in `plans/FS107-stability.md`. Save. It covers:
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
     - the paths-forward rows, with FS-107 closed and FS-110 ranked;
     - "Where the problem stands", item 31;
     - G82;
     - any correction owed;
   - `BIBLIOGRAPHY.md`: Mundinger et al. 2025 (held), `[DeCorteOliveiraVallentin2022]` Lemma 6.2's bearing, and the unheld titles of item 8;
   - `plans/FRONTIER-STUBS.md`: FS-107 to the closed list, FS-110 and the other new stubs ranked;
   - the GROKKING-INSTANCES entries;
   - the protocol amendment;
   - the claim-list corrections (items 21, 26), as an appended section of `data/fs107/claims.md`, which you may write directly.

   **The budget:** `CLAUDE.md` is at about 299,242 bytes against its 300,000 limit. Every new line must be paid for: point to ledger rows instead
   of retelling them, and move later instances out. Draft so that the front page lands under the limit without cutting an intrinsic.

## Rules

- **Touch only:** `plans/FS107-derivation.md`, `plans/FS107-stability.md` (§R-close only), `plans/FS107-close-inventory.md` (status cells only),
  `plans/STUB-regularity-wall.md`, new or re-aimed stub files, `data/fs107/claims.md` (the appended section), and `data/fs107/fs107-c/`. Never
  touch the front files, the protocols or the instances file.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Commits:** by explicit path, with subjects "FS107-C: stage n". Never amend. Push after each; never force-push.
- **Report** (standing rule 9) to `data/fs107/reports/FS107-C.md`, committed, and by SendMessage to "main". Your final turn's text: "FS107-C idle;
  report sent to the owner by SendMessage".

Thank you.
