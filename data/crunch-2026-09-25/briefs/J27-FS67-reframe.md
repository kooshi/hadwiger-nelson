*Brief for crunch job **J27**: the reframe and subplan of FS-67, "k-colourings of a tight graph times a non-k-colourable one: do they
all come from the tight factor?" Opus 5.5, 2026-09-25. Written by the product owner per `plans/CRUNCH-2026-09-25-queue.md` §4.2.
**The reframe template is J03's brief** (`data/crunch-2026-09-25/briefs/J03-M1-reframe.md`): read it in full and follow it, with the
changes below, which override it where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **FS-67's planner**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read
`CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the
product owner.

**If your plan already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS67-tight-products.md` and
continue at the first stage not SAVED.

## The milestone (replaces J03's milestone block)

**FS-67**, stub `plans/STUB-tight-product-colourings.md` — read it in full (its banners from FS-86's and FS-89's closes, and the
"Where the 2026-09-25 work on this lives" block). The queue states what is left: "the product question's remainder after the
Greenwell–Lovász reading: the equal-ratio case with an IS-imprimitive factor, and the gap `χ_f(H) ≤ k < χ(H)`". The readings that
narrowed it: `plans/PA-products-GL1974-LT2002.md` (PA-P1 to PA-P5), `plans/PA-tardif2023.md` §5.4 (PA-T6, the exponential-graph form).
**And today's work that bears on it** (read the statements at exact scope; the index `plans/CRUNCH-2026-09-25-INDEX.md` points to each):
- M3's **J21-MX** (mixing selection: a Cayley factor whose non-trivial spectrum is below `1/(k−1)` can be deleted from any `k`-colouring of
  a product, Borel and measurable forms) — `plans/M3-S1D-windows-five.md` §3.2, blind-checked (`plans/M3-S1V-windows-five.md`), prior art
  `plans/M3-PA-mixing.md` (its threshold is Pak–Vilenchik 2013 Thm 3 for a complete first factor; its complete-graph case is Burr–Erdős–
  Lovász; `[GodsilEtAl2020]` Cor. 4.4);
- M3's **NG1/NG2** (the cylinder lemma false in two readings; ratio alone cannot carry the product step, by Shitov/Zhu at 125 colours);
- `[TardifWrochna2019]` Thm 2 (the Moser spindle is strongly multiplicative), found by J23cpa;
- M3's close re-aimed this stub (`plans/M3-exotic-colourings.md` §R-close R4.S) — read its re-aim.

**Change J03's other blocks accordingly:** one milestone, one verdict column; the §PA disciplines are graph products and Hedetniemi-type
questions, strongly multiplicative graphs, MIS-normality, spectral (Hoffman-tight) colourings — searched in those words, with the zbMATH API;
§IQ per WORKFLOW 3.3 (the structural form about every `k`-colouring of `G × H`); the briefs you write are the derivation's and its blind
verifier's fixed claim list (before any claim exists); the paths `plans/FS67-tight-products.md`, `data/fs67/j27/`, `tools/crunch_j27_*`.
Register priors before any derivation.

## Rules (in addition to J03's)

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **The finite-witness ban** runs to 2026-10-01; a stage that needs a search is written as a dated post-ban stage.
- Every outcome counts; a counterexample to "every colouring comes from the tight factor" is as valuable as a proof. Do not lean toward a
  yes.
- Do not edit the index, M1–M3 files, FS-84's or row 88's files, or the four front-page files (a front-page job is running).
- **Commits by explicit path**, subjects "J27: stage n"; push; never force-push.
- **Budget:** about 350k by the harness's count; hand back by 420k.
- **Report** in the fixed ≤ 12-line form to `data/crunch-2026-09-25/reports/J27.md`, committed, and by SendMessage `to: "main"`, with the
  jobs it proposes as Q-lines plus their brief files. Keep your turn's final text content-free: "J27 idle; report sent to the owner by
  SendMessage".

Thank you.
