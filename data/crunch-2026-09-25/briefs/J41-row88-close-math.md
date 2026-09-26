*Brief for crunch job **J41**: the close-math of the milestone "row 88's question" (FS-86's open question). Opus 5.5, 2026-09-25. Written
by the product owner. **Its template is J23a's brief** (`data/crunch-2026-09-25/briefs/J23a-M1-close-math.md`, M1's close): read that in
full and follow it. The changes below override it where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the milestone's close planner**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your outputs already exist, you are resuming.** The ticks in `plans/FS86-row88-close-inventory.md` and the `Stage n — SAVED` headings
in the plan's §R-close are your map. Check them against `git log` and continue at the first stage not SAVED.

## The milestone

**The question** (`LEDGER.md` row 88): over the type-(B) fields ℚ(√59), ℚ(√83) and ℚ(√131), is `(0, 4)` forced? Equivalently, is every
four-colouring of the plane a pullback from the tight dyadic place? The plan is `plans/FS86-row88-rigidity.md`. The jobs, all DONE:
- J28, the plan (§G, §PA, §IQ, §S, §P);
- J28D, the derivation, `plans/FS86-R88-D-derivation.md`;
- J28V, the blind verifier, `plans/FS86-R88-V-verification.md`. Its §Stage 5 holds the divergence table and says whether the routes are
  independent.
- J35, the close-time prior-art gate, `plans/FS86-row88-PA-close.md`.

**The results, as the records state them** (read each at exact scope; this list is a pointer, never a source):
- **T-A** (the decomposition, (i)–(vi)): TRUE. Both minds agree. There is one scope repair: `τ` commutes with conjugation.
- **T-C** (Theorem C, over the whole class S2 in J28D's statement): TRUE, by two derivations blind to each other with independent routes
  over common inputs.
- **T-C(A)** (over ℚ(√47)): TRUE on the same footing. Note the asymmetry J28V records at a split dyadic place.
- **T-B1, T-B2**: GAP in both records, at the same named steps. The partial results are proved.
- **T-C′**: the remainder, named, with no truth claim.
- **J28V-6, J28V-7**, and the lemma statements.

The common inputs are C14.1–C14.3, `[AmbrusEtAl2023]` (whose certificate J26 re-checked with our own tool: `plans/PA-ambrus2023-audit.md`),
FS-66's certificates, Lemmas D and P, FS38-D2-A/B, V3ram and VC-C2. The grade line of each result names them.

**J35's attributions (apply them at the entries):**
- J28V-7 is in print: Levitz–Mott 1972 Thm 2.3.
- The engine of T-A (v) is Bergelson–Moragues 2021 Thm 2.3 + Prop 2.7.
- "Transient" is "the measure centre lies in Pull" (Chen–Dai 2017 L1.2).
- C14.2 (c) is `[BardestaniMallahiKarai2017]` §3.2 in window form. Write that correction into the *Prior art:* field of that entry in
  `plans/FS86-derivation.md`, and change nothing else there.

The main question stays **undecided**. What the milestone produced:
- the decomposition;
- the measure theorem on finitely supported spectra;
- its ℚ(√47) form, which bears on FS-84;
- two gaps pinned at named steps.

## Outputs (J23a's, with these paths)

- **`plans/R88-derivation.md`**, the milestone's derivation file (the home `R88`, like `R52`, `R57`, `R59`). Every theorem the milestone
  proved outside the kernel is filed there, with:
  - its statement;
  - its grade and verification status (one mind, or two blind derivations);
  - its address;
  - what rests on it;
  - its prior art (J35's verdicts);
  - its kernel decision.

  Run `python3 tools/fs71_ledger_b_check.py --strict` and make sure your entries parse (read its regex first). The § B lines are drafted
  in §R-close, not written into `LEDGER.md`.
- **The plan's §R-close.** It covers:
  - the §G re-read, including the forward propagation of any new grokking to the open stubs it bears on;
  - the §IQ re-read and G72's count: did the result come through the structural question?
  - the §PA sweep for recognitions that belong in the Grokkings;
  - predictions scored, once each;
  - the verdict, ruled in four parts;
  - the honesty tally: slips and retractions;
  - the ban measurement: every would-have-searched line, and the post-ban stages Y1 and Y2, held for Kooshi.
- **The inventory:** every row of `plans/FS86-row88-close-inventory.md` is ticked "done" or "declined, with the reason". Read every number
  from its source. Its header notes that J28's report promised 45 lines and held 41; check the report and the plan for any missing items.
- **Drafts in §R-close only** (a front-page job applies them later):
  - `LEDGER.md` rows numbered from **111**. A second close, FS-67's, will number after yours, so state your last number.
  - The `CLAUDE.md` lines, at most 4,000 bytes net: G76 (its reading and killing test after T-C), item 24, and item 10 (T-C(A) at ℚ(√47)).
  - `BIBLIOGRAPHY.md` rows: J35's nine proposals and two corrections (J35 §6.5).
- **Stub re-aims and new stubs, as files:**
  - T-C′, the spectra that read infinitely many places;
  - T-B1's ultrametric step in expansive-subdynamics terms (J35 §6.7; a reading);
  - FS-84, re-aimed by T-C(A);
  - FS-64 and FS-90 (Y1, Y2).

  **A Poros session is examining the infinitely-many-primes finding right now** (J36, `plans/POROS-2026-09-25-infinitely-many-primes.md`
  once it commits). Mint the T-C′ stub from the records, without waiting. If J36's record exists when you write the stub, cite it; never
  copy its recommendations as settled.

## Rules (J23a's, with these paths)

- **Touch only:**
  - `plans/FS86-row88-rigidity.md` (§R-close only);
  - `plans/R88-derivation.md`;
  - `plans/FS86-row88-close-inventory.md` (ticks);
  - new stub files and the re-aimed stubs named above;
  - the one *Prior art:* field in `plans/FS86-derivation.md`;
  - `data/fs86r88/j41/`.

  **Never touch** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the index, the job records, or any FS-67, FS-84 or
  M1–M3 file other than the stubs named.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left; a successor is expected if needed.
- **No finite-witness search** (the ban runs to 2026-10-01).
- **All novel knowledge is a success** (Kooshi): an undecided question with two gaps pinned is a result. Do not inflate it, and do not
  apologise for it.
- **Commits by explicit path**, subjects "J41: stage n". End commit messages with your harness's attribution lines. Push after each commit;
  never force-push.
- **Budget:** about 300k by the harness's count; hand back by 380k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J41.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J41 idle; report sent to the owner by SendMessage".

Thank you.
