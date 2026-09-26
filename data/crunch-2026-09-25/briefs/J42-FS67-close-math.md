*Brief for crunch job **J42**: FS-67's close-math. Opus 5.5, 2026-09-25. Written by the product owner. **Its template is J23a's brief**
(`data/crunch-2026-09-25/briefs/J23a-M1-close-math.md`, M1's close): read that in full and follow it. The changes below override it where
they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **FS-67's close planner**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this
brief.** I'm the product owner.

**If your outputs already exist, you are resuming.** The ticks in `plans/FS67-close-inventory.md` and the `Stage n — SAVED` headings in the
plan's §R-close are your map. Check them against `git log`, and continue at the first stage not SAVED.

## The milestone

**FS-67** (stub `plans/STUB-tight-product-colourings.md`): when `G` is `k`-gap-free or Hoffman-tight and `χ(H) > k`, must every
`k`-colouring of `G × H` be pulled back from `G`? The plan is `plans/FS67-tight-products.md`. The jobs are:
- J27, the plan (§G, §PA, §IQ, §4–§5), DONE;
- J27D, the derivation, `plans/FS67-J27D-derivation.md`, DONE;
- J27V, the blind verifier, `plans/FS67-J27V-verification.md`, DONE. **No verdict diverges.**
- J40, the close-time prior-art gate, `plans/FS67-PA-close.md`. **It is still running.** See "Prior art" below.

**The results, as the records state them** (read each at exact scope; this list is a pointer, never a source):
- **DA-1′, DA-2′, DA-3, DA-4**: TRUE, by two minds. The gap-free form fails at every `k ≥ 4`, from `[Tardif2023]` Thm 1.
- **DC-2**: TRUE at `τ_k = 1/(k−1)`, by two minds. J27V shows the constant is sharp (`H = K_k`).
- **DC-1, DD-1**: TRUE, conditional on `[GodsilEtAl2020]` [external]. Zhang's exception in DD-1 is GAP, per J27D; J27V did not verify it.
- **DB-2**: TRUE.
- **DC-3**: a table; the rows at `p = 7, 11, 31` match to every digit.
- **DB-1 and DD-2**: GAP. Both minds reached the same named step independently, and the invariants agree (`D_C = −6w₂^c`).
- **Lemma W**: the two-step winding.
- **J27V's side results:**
  - the non-zero-winding improper part of `E₃(C₅)` is 3-colourable, which retires post-ban stage PB-1 at `C₅`;
  - `UD(𝔽₉, 2)` is tight at three colours and three-coloured by a derived formula.

**Bearing on χ ≥ 6: none.** State it that way. The milestone's value is mechanism, the product question behind G61 (2) and FS-61's missing
rule, and a clean negative at `k ≥ 4`.

## Outputs (J23a's, with these paths)

- **`plans/FS67-derivation.md`**, the milestone's derivation file. Every theorem the milestone proved outside the kernel is filed there,
  with:
  - its statement;
  - its grade and verification status (one mind, or two blind derivations);
  - its address;
  - what rests on it;
  - its prior art;
  - its kernel decision.

  Run `python3 tools/fs71_ledger_b_check.py --strict` and make sure your entries parse; read its regex first. Draft the § B lines in
  §R-close.
- **The plan's §R-close.** It holds:
  - the §G re-read and forward propagation;
  - the §IQ re-read and G72's count (did the result come through the structural question: which `G` has `χ(E_k(G)) ≤ k`?);
  - the §PA sweep;
  - the predictions, scored once;
  - the verdict, in four parts;
  - the honesty tally;
  - the ban measurement: the would-have-searched lines, and the post-ban stages PB-1 and PB-2 (PB-1 retired at `C₅`).
- **The inventory:** tick every row of `plans/FS67-close-inventory.md` "done" or "declined, with the reason", reading every number from its
  source. Add the items from J27V's report and J40's report, which the clerk has not folded yet.
- **Drafts in §R-close only**, for a front-page job to apply later:
  - `LEDGER.md` rows. Number them after the last row that the row-88 close (J41) drafts in `plans/FS86-row88-rigidity.md` §R-close. If
    that close has not yet stated its last number, write "next after row 88's close" and say so in your report.
  - `CLAUDE.md` lines, at most 3,000 bytes net: FS-67's paths-forward row, any grokking the §G re-read calls for (G54 and G61 (2) are the
    candidates), and the frontier item, if any.
  - `BIBLIOGRAPHY.md` rows from J27's, J27D's and J40's proposals.
- **The stub re-aimed, as a file:** `plans/STUB-tight-product-colourings.md`. At `k ≥ 4` the answer is negative; what remains is DB-1 (`B(3)`
  generalised to gap-free) and DD-2 (a regular, spectrally fat Hedetniemi pair). Include the post-ban stage PB-2.

## Prior art

J40 is running the gate beside you, as M1's gate ran beside its close. Do your stages in this order:
1. the derivation file, with a *Prior art:* field reading "pending J40" where needed;
2. §R-close;
3. the inventory;
4. prior art last.

When `plans/FS67-PA-close.md` has J40's verdicts, copy each into its entry's *Prior art:* field, verbatim and with J40's address. Never
contact J40. If J40 has not finished when you reach this last stage, save, report, and leave those fields "pending J40". I will resume you.

## Rules (J23a's, with these paths)

- **Touch only** these paths:
  - `plans/FS67-tight-products.md` (§R-close only);
  - `plans/FS67-derivation.md`;
  - `plans/FS67-close-inventory.md`;
  - `plans/STUB-tight-product-colourings.md`;
  - `data/fs67/j42/`.

  **Never touch** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the index, the job records, J40's files, or any
  row-88, FS-84 or M1–M3 file.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **No finite-witness search** (the ban runs to 2026-10-01).
- **All novel knowledge is a success** (Kooshi): a clean negative at `k ≥ 4` is a result. State it at full strength, without inflating it.
- **Commits by explicit path**, subjects "J42: stage n". End commit messages with your harness's attribution lines. Push after each commit;
  never force-push.
- **Budget:** about 250k by the harness's count; hand back by 330k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J42.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J42 idle; report sent to the owner by SendMessage".

Thank you.
