*Brief for job **X09C**: the close-math job of the ×2×3 crunch (FS-100 stage 5). Opus 5.5. Written by the crunch planner. **Its template
is J53's brief** (`data/crunch-2026-09-25/briefs/J53-FS100-close-math.md`); read it and follow its form where this brief is silent.
**Sized for about 20 minutes of wall time and 150k harness tokens; launch at 06:55 or when every derivation has reported, whichever comes
first.***

Hello. You are de Bruijn (`DEBRUIJN.md`), the close planner, in `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context.
**`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief.** The owner coordinates; the choices are Kooshi's.

**If `plans/FS100-three-field-lemma.md` already has a section "§R-close (stage 5, the ×2×3 crunch)", you are resuming:** continue at its
first stage not SAVED.

## What you work from

- The close inventory `plans/FS100-x2x3-close-inventory.md`: tick every item "done" or "declined, with the reason". Read every number from
  the item's source, never from the inventory.
- The reports under `data/crunch-2026-09-26-x2x3/reports/` and the records they name: `plans/FS100-X01D-derivation.md`,
  `plans/FS100-X02D-derivation.md`, `plans/FS100-X03D-derivation.md`, `plans/FS100-X01V-verification.md`,
  `plans/FS100-X02V-verification.md`, `plans/FS100-X05V-verification.md`. Read each record's "Theorems this phase proved" heading first,
  and its prose only where a verdict needs it.
- The queue plan `plans/CRUNCH-2026-09-26-x2x3-queue.md`: §2 (the claims), §3 (§G, §PA, §IQ), §5 (expectations), §6 (advice). The
  advisor's record `plans/POROS-2026-09-26-x2x3-crunch.md`.

## Stages (save after each)

1. **Reconciliation.** Per claim of lists X01, X02, X03, SP-Cor and KC: the derivation's verdict, the verifier's verdict, and whether they
   were blind to each other. List every divergence, and rule on each or mark it open. **The headline rule** (inventory item 8): claim
   `χ(ℚ(√47)²) = 5` only if EF_F and PE-2 are each TRUE by two minds **and** X05V passed SP-Cor. Otherwise the strongest claim is the
   conditional one that the verdicts support, stated with its hypotheses named. A result graded [hand, one mind] is labelled so. Save.
2. **The derivation file.** Add a section "§3. Stage 5 (the ×2×3 crunch)" to `plans/FS100-derivation.md` in its existing entry form:
   statement, grade, proof address, what rests on it, kernel decision. Save.
3. **§R-close (stage 5)** in `plans/FS100-three-field-lemma.md`, containing:
   - the §G re-read (which extractions paid; which entries bore and were missed);
   - the §PA sweep (what the reading taught about the object, per WORKFLOW 9);
   - the §IQ re-read, with G72's count and G79's record (did the result come from an example invariant or a counterexample invariant);
   - §5's expectations scored once each;
   - the verdict in four parts;
   - the would-have-searched lines counted.
   Save.
4. **Drafts for the front page** (in §R-close, never in the target files):
   - `LEDGER.md` rows numbered from **120** (119 is FS-75's), with their § B lines;
   - the `CLAUDE.md` lines. `CLAUDE.md` has no byte budget this crunch, but keep one home per fact. Candidates: Frontier items 10 and 27;
     the FS-100 Paths-forward row; G76's reading (§3's falsifiable item); G79's test record; G72's count; a G49/G50 instance if EF was
     missed by FS-100's gate; "Last updated";
   - `BIBLIOGRAPHY.md` rows (Einsiedler–Fish 2010 and whatever the jobs read, each with its reading status);
   - the stub re-aims as files: FS-100's status block, and FS-97's banner if it changes;
   - `plans/FRONTIER-STUBS.md` rows.
   Save; the report.

**Stop rule:** at 12:12 UTC, save what is done and report what is left; the front-page job starts at 07:10 from whatever is saved.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **Touch only:** `plans/FS100-derivation.md`, `plans/FS100-three-field-lemma.md` (a new §R-close section), `plans/FS100-x2x3-close-inventory.md`
  (ticks), the two stub files named above, and `data/fs100/x09c/`. Never `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` or `BIBLIOGRAPHY.md`.
- **Commits:** by explicit path, with subjects "X09C: stage n". Never amend. Push after each commit. Never force-push.
- **Report** (standing rule 9): to `data/crunch-2026-09-26-x2x3/reports/X09C.md`, committed, and by SendMessage to "main". Your final
  turn's text: "X09C idle; report sent to the owner by SendMessage".

Thank you.
