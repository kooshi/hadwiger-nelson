*Brief for job **J53**: the close-math of FS-100's in-ban round ("one missing lemma for three fields"). Opus 5.5, 2026-09-26. Written by
the product owner. **Its template is J41's brief** (`data/crunch-2026-09-25/briefs/J41-row88-close-math.md`), which rests on J23a's: read
both in full and follow them. The changes below override them where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the milestone's close planner**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner, and the choices the
templates call his come to me by your report.

**If your outputs already exist, you are resuming.** The ticks in `plans/FS100-close-inventory.md` and the `Stage n — SAVED` headings in the
plan's §R-close are your map. Check them against `git log` and continue at the first stage not SAVED.

## The milestone

**The stub** `plans/STUB-measure-rigidity-three-fields.md`; **the plan** `plans/FS100-three-field-lemma.md` (J51: §G, §PA — the MR reading
room — §IQ, §S, §P; its §M was run by J51D). The jobs, all DONE:
- **J51**, the plan; its report `data/crunch-2026-09-25/reports/J51.md`.
- **J51D**, the derivation, `plans/FS100-J51D-derivation.md` (stopped at its stop rule after stage 3; K0 not started).
- **J51V**, the blind verifier, `plans/FS100-J51V-verification.md` (every claim reached a verdict; its fallback stage 4 was not needed).

**The results, as the records state them** (read each at exact scope; this list is a pointer, never a source):
- **KS-1 (Kronecker selection, selecting onto `T + A`) FALSE**, by a counterexample over ℚ found by both minds: J51V-X1 (blind) and
  J51D-T3. J51V-X2 and J51D-T3 both extend it (every real field with a ramified stable dyadic place, i.e. `χ(F²) = 2`; J51V: the
  `k²`-colour analogue over every real field). The owner re-derived X1 by hand and re-ran `tools/j51v_cross.py` (inventory).
- **KS-2 TRUE** (both; J51D-T1 in an arithmetic-free form). **KS-3 FALSE** (both; J51D-T2's conjugate-pair dichotomy over every real field).
- **KS-4, KS-5 TRUE** (both), **and uninformative**: J51D §2.5 shows neither control could fail — a control of the wrong shape (G21).
- **KS-C TRUE as an implication** (both); at ℚ(√47), given T-C(A), KS-1 ⟺ the E-form ⟺ KS-C's conclusion (J51V-EQ, J51D §3.3).
- **The corrected statement** (selection onto `E = T + A + Fin_S`; J51D's KS-1_E / KS-sat_E): **GAP** at J51D-R's named density step.
- **Rank one:** J51V-N1 (KS-1 at `n = 1` TRUE over every real field, given row 98); J51D-T4 and T5 (KS-3 at `n = 1`: TRUE inside E, TRUE
  at ℚ, GAP off E for general F).
- **K0** (J45's A⁺ and SP-Cor over every field in T-C(A)'s class): TRUE with a scope note, **one mind** (J51V-K0), and its class-membership
  sub-verdict is not blind (J51V's fence breach, inventory).
- **J51-T1** (real quadratic ℚ(√d) in T-C(A)'s class ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L ≥ 5`): one mind + tools exact, and J51V's partly
  blind check. **J51-T2** (EL2021's Thm 1.2 never applies to finitely generated `Γ ⊂ U` on `R̂`): one mind. **J51-T3**: superseded by
  J51D-T1 (KS-2).
- **The MR reading room** (plan §PA.3): the card's branch "first yes, second no": MR is its zero-entropy half plus the owed lemma PE-lim.

## Reconciliation first (your stage 1, before any filing)

Write the divergence table from the two records, one row per claim and per extension: verdict, route, scope, and whether the routes are
independent. Three items need an explicit ruling in it, each with its reason:
1. **Rank one.** Are J51V-N1 and J51D's rank-one GAP about the same statement? (The owner's reading: N1 is KS-1 at `n = 1` — a proper `W`
   forces `0 ∉ cl θ(U)`, so `θ` is a band character and row 98 puts it in `T + A` — while J51D's GAP is KS-3 at `n = 1`, density of
   `cl θ(U)`, a different statement. Check this; do not adopt it.)
2. **KS-1's independence.** J51V was blind. J51D's C0 (committed 2654b675, 23:59:22) put KS-1 FALSE at 0.80 and its domain pass flagged
   `T + A` as the wrong target (aa12db5e) before the owner's commit 3648d3a5 (00:01:16) put the word "counterexample" into a commit subject
   J51D could read; J51D's stage 2 committed at 00:03:57. Grade KS-1 FALSE accordingly, and say so in the entry.
3. **K0.** Carry out a one-step check of J51V-K0 yourself (not blind: read J51V's proof and J45's §5.4, and check that every step J45 used
   at ℚ(√47) holds at ℚ(√143), ℚ(√311), ℚ(√335) given T-C(A) there at `S = ∅`, and that T-C(A) holds there at `S = ∅`). Grade it "hand, one
   mind (J51V) + one-step check (J53)", the house form of FS67-CL.

## A close-time prior-art gate, time-boxed at about 20 minutes (your stage 2)

For the theorems you file — above all the counterexample, the conjugate-pair dichotomy and J51-T1 — in their disciplines' words (G49, WORKFLOW
3.2): measurable colourings and Borel chromatic numbers of Cayley graphs on compact abelian groups; Kronecker factors and discrete spectrum;
cross-shaped closed subsets of tori; the class-number arithmetic of ℚ(√d) at `d ≡ 47, 143, 167 (mod 168)`. zbMATH API for discovery (item 8).
Record each negative. Mark reading status per section (G50). Add Lindenstrauss–Wang 2012 and Z. Wang 2012 to the reading list only if the
gate shows they bear on a filed theorem; otherwise they stay the next FS-100 slot's debts.

## Outputs (J41's, with these paths)

- **`plans/FS100-derivation.md`**, home `FS100`: every theorem the round proved outside the kernel, in the entry form
  `tools/fs71_ledger_b_check.py` parses (read its `ENTRY_RE` first), with statement, grade and verification status, address, what rests on
  it, prior art (your gate), kernel decision. Run `python3 tools/fs71_ledger_b_check.py --strict` and read its exit status directly.
- **The plan's §R-close** (J41's list): the §G re-read and forward propagation; the §IQ re-read and G72's count (did the result come
  through the structural question?); the §PA sweep for recognitions that belong in the Grokkings (candidates: J51D-T2's dichotomy — a unit
  vector is integral at one of two conjugate split places — and J51V's co-normal-product reading); predictions scored once each (X-KS,
  P-sat, P-sat1, P-K0, P-EL, P-ent, X-MR, both C0 tables); the verdict in four parts; the honesty tally (slips, retractions, the owner's two
  errors in the inventory); the ban measurement (every would-have-searched line).
- **The inventory:** every row of `plans/FS100-close-inventory.md` ticked "done" or "declined, with the reason"; read every number from its
  source; add anything the records hold that it lacks (J51D's report came after the inventory's last row).
- **Drafts in §R-close only** (a front-page job applies them):
  - `LEDGER.md` rows numbered from **116**. FS-75's close numbers after yours, so state your last number.
  - `LEDGER.md` § B lines for every entry you file.
  - `CLAUDE.md` lines, **at most 3,000 bytes net** (the file stands at 283,904 against 300,000, and FS-75's close follows): candidates are
    item 10 (ℚ(√143), ℚ(√311), ℚ(√335) in T-C(A)'s class), item 24 or 27 (Kronecker selection refuted as stated; the E-form open), G76, G21's
    instance list (FS-100's controls of the wrong shape), and FS-100's Paths-forward row. Row 98's "Not claimed" (J51V-X2 (c)) is a LEDGER
    draft.
  - `BIBLIOGRAPHY.md` rows for every work the plan and the gate read or named, with per-section reading status (EL2021, EL2003, Host 1995,
    Rudolph 1990, A. Johnson 1992, Bekka–Francini 2022, Lindenstrauss–Wang 2012, Z. Wang 2012, and any the gate adds).
- **Stub re-aims, as files:** FS-100's stub (stage 4 → the E-form at ℚ(√47), J51D-R's density step; K0's status; the §2.3 cell and §5 item 5
  corrections both records name; PE-lim as stage 5's derivation; P1 leading the post-ban plan) and FS-64's (Kronecker selection with T-C(A)
  in the corrected E-form). Mint a new stub only for a question neither stub can hold, and record every decline.
- **One file move:** copy `data/fs100/j51/el2021.pdf` to `~/source/library/` (the house copy; check the directory's naming first) and
  `git rm` it from the repository in the same commit; the bibliography draft names the new address.

## Rules

- **Touch only:** `plans/FS100-three-field-lemma.md` (§R-close only); `plans/FS100-derivation.md`; `plans/FS100-close-inventory.md` (ticks
  and added rows); `plans/STUB-measure-rigidity-three-fields.md`; `plans/STUB-adelic-window-colouring.md`; `data/fs100/j53/`;
  `data/fs100/j51/el2021.pdf` (the move); `~/source/library/` (one file). **Never touch** `CLAUDE.md`, `LEDGER.md`,
  `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the job records, anything under `visualizations/`, or any FS-75 file.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left; a successor is expected if needed.
- **No finite-witness search** (the ban runs to 2026-10-01); keep the "would have searched here" log.
- **All novel knowledge is a success** (Kooshi): a lemma refuted as stated by two minds, with its corrected form pinned at a named step, is a
  result. Do not inflate it, and do not apologise for it.
- **Commits by explicit path**, subjects "J53: stage n"; never amend. End commit messages with your harness's attribution lines. Push after
  each commit (on a ref-lock race, `sleep 4` and retry); never force-push.
- **Budget:** about 300k by the harness's count; hand back by 380k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J53.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J53 idle; report sent to the owner by SendMessage".

Thank you.
