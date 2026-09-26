*Brief for job **J52**: the reframe and subplan of a kernel milestone, FS-75's minimal instance — `χ(ℚ(√167)²) ≥ 4` in the kernel. Opus 5.5,
2026-09-26. Written by Poros (job J50, `plans/POROS-2026-09-26-next-two-milestones.md` §3) for the product owner, at Kooshi's request for "2
more full milestones". **The reframe template is J03's brief** (`data/crunch-2026-09-25/briefs/J03-M1-reframe.md`), as J28 used it: read J03
in full and follow it, with the changes below, which override it where they differ. **Sized for about 45 minutes of wall clock.***

Hello. You are de Bruijn (`DEBRUIJN.md`), **the milestone's planner**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk — **after** job J05's compression of `CLAUDE.md` has committed (check
`git log -3 -- CLAUDE.md` for a "J05" subject; if J05 is still running, read it anyway and note which version you read).
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner. The plan is yours; the
choices are Kooshi's, through me.

**If your plan already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS75-kernel-167.md` and continue at
the first stage not SAVED.

## The milestone (replaces J03's milestone block)

**The stub:** `plans/STUB-three-colour-criterion-kernel.md` — read it in full. Its current aim, verbatim (line 3): "**Re-aimed at FS-91's
close.** The kernel target is S1 over every real number field (J02-T2's chain: J02-L1, L2, L3, L4(a) and a finite sumset) and no mixing
(FS91-J09-J4, J09's proposal); every leaf is finite algebra plus one character-sum bound (Weil above 243, exact below), with FS81-T2 and
FS73-T22's ⟹ as the named hand inputs." Everything there rests on the criterion's ⟹ direction, and the stub orders the work "**The smallest
instance first**".

**This milestone is that smallest instance.** Its target, verbatim from the stub's shape, item 4: "**Compose:** `Θ₃(S) = ∅` ⟹ `addCayley S`
not 3-colourable ⟹ `3 < χ(ℚ(√167)²)`, stated as `four_le_chromaticNumber_planeOver_sqrt167`, standard three axioms, no native purchase."
Its three leaves are the stub's shape items 1–3 (read them in full):
1. **the criterion's ⟹ direction** — and, verbatim, "**Only the relation form is needed downstream** (T42): if `θ ∈ Θ₃` then
   `x_j = frac θ(u_j) ∈ [1/3, 2/3]` and `r·x ∈ ℤ` for every relation `r` — one line, and the certificate uses that direction alone";
2. **the certificate** — for T41's 36 vectors, verbatim: "`{1, v, z}·U_R` have `Θ₃ = ∅` by a 1,050-leaf certificate (5.7 KB,
   `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`) and a half-page hand proof (four inequality cases)"; choose between a kernel checker in
   the house pattern and the four-case proof stated directly;
3. **the lattice in the plane**, each listed vector checked by `decide` in ℤ.

**Why this instance** (J50's record §1.2): J43's facts file shows **no field-level lower bound at either exposed field of the conjecture in
the kernel**. ℚ(√167) is its widest gap (predicted at least six, proven four). Leaf 1 is also reusable for every `Θ₃` certificate the project
holds, including ℚ(√47)'s 2,997-node tree, which is this milestone's second instance if time allows.

**A route sketch for leaf 1, offered as a hypothesis** (J50's hunch `leaf-one-is-elementary`: one mind, unchecked — price it, do not trust it):
- Lift the colouring along the grid `ℕ^m → Λ` of the listed generators to a height `H` with steps in `{1, 2}`. It is built along monotone
  paths; path-independence comes from the square argument, where the two-step sums lie in `{2, 3, 4}` and agree mod 3.
- A step depends only on the image in `Λ`. So for a relation `r = r⁺ − r⁻`, the winding `H(y + r) − H(y)` is constant in `y`, and it lies in `3ℤ`.
- Box averages of the steps lie in `[1, 2]^m` and satisfy `Σ r_j L_N(e_j) = w(r) + O(|r|²/N)`.
- Bolzano–Weierstrass in `[1, 2]^m` (`IsCompact.tendsto_subseq`) gives `x = L/3` with `x_j ∈ [1/3, 2/3]` and `r·x ∈ ℤ`.
- It needs no descent to `Λ` and no function-space compactness.

**The advisor's card for your obligation pass** (J50's record §3.2, verbatim):
> ask: after the obligation pass, what do the relation-form criterion's first two leaves cost in the kernel?
> if under about three hours in total: FS-75's minimal instance runs, with ℚ(√47) next
> if over: FS-87's targets 2–3 run in the kernel slot instead, and leaf 1's price is FS-75's finding

**The swap is yours to make, recorded at the head of §S with its price.** The fallback milestone, verbatim from
`plans/STUB-de-grey-chain-kernel.md` line 3: "**Next:** target 2, dB9's V1; then target 3, the checker for Parts's nine trees — price both
from target 1's rate" (target 1, the stripe lemma, took "17 minutes against a 4–6 hour price"). If you swap, plan FS-87's targets 2–3 in
this job instead, with the same stages.

## Changes to J03's blocks

- **This is a kernel milestone, so there is no §IQ** (WORKFLOW 3.3 excludes a kernel port). Its sections are §G, §PA, §S (the skeleton and
  the leaves), §P, §M and §X.
- **§G in the crunch's terse form, time-boxed at about 15 minutes.** Walk every grokking G1–G79, every `LEDGER.md` row 1–115 by its mechanism
  (read § A in full; read § B only by grepping for FS73-T22, T39, T41, T42 and FS81-T1–T5), and every `[method]` rule — § Building, § The
  kernel's cost model and § The gate matter most here. One line each: `G71 — bears: <≤ 25 words> → leaf <n>` / `silent: <≤ 10 words>` /
  `falsifiable: registered as P-<x>`.
- **§PA, about 5 minutes:** what Mathlib and core already hold for each leaf. Use `exact?`, Loogle, and `grep -rn` over Mathlib and
  `$(lean --print-prefix)/src/lean/`. Cover `IsCompact.tendsto_subseq`, the house `addCayley` and `planeOver` API, `UDCert`, and
  `NarrowCert.check`'s pattern. Also give the criterion's attribution: Chandgotia's height functions (`CLAUDE.md` § Frontier, "Not ours").
- **§S, the skeleton — WORKFLOW step 4:** every signature and full theorem statement, with `sorry` at every leaf, in a new module. Place it
  per `ARCHITECTURE.md` and have it elaborate with `lake env lean <file>`. That command builds nothing; it is not the gate. Add a sanity
  `example` per definition, and one concrete inhabitant of the criterion's hypothesis: a proper three-colouring of some small `addCayley`.
  Then run the obligation pass and **price leaf 1's first two children**.
- **§M:** invoke `debruijn-domain-modeling`, then `debruijn-obligation-modeling`, then `debruijn-experience-modeling` freshly with the Skill
  tool (the criterion is a reusable API, so experience runs last).
- **The brief you write:** **J52K**, the kernel implementer, in the house form of the M2 kernel briefs
  (`data/crunch-2026-09-25/briefs/J14-M2-chain-kernel.md`, `J16-M2-prime-inversion-kernel.md`). Size it at about 2–2.5 hours and 300k harness
  tokens, with this stop rule: **re-price from the first two leaves actually closed** (`CLAUDE.md` § What compute actually helps), and report
  if the total is heading past three hours. Builds use exactly
  `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`. Never run `lake build`, bare or named. The gate is WORKFLOW
  step 8, with `./scripts/vacuity.sh` and `./scripts/axioms.sh`.
- **Paths:** the plan `plans/FS75-kernel-167.md`; working files `data/fs75/j52/`; any exact check `tools/j52_*.py`, with a planted fault
  watched firing. Frozen and read-only: `tools/fs73*check*.py`, `tools/fs73v2_check.py`, `data/fs73/`.

## Rules (in addition to J03's and the standing rules)

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation). Reason:
  staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a saved stage and
  tell me what is left.
- **The finite-witness ban runs to 2026-10-01:** no SAT, MILP, Θ trees or finders, quotient searches or sweeps. Checking the existing
  certificate is in; producing a new one by search is out. **Keep a "would have searched here" log** (§X): one line per move you would have
  made by search, and what you did instead.
- **Every outcome counts.** The theorem in the kernel; the swap to FS-87 with leaf 1's price as the finding; or a leaf that fails with the
  missing step named — each is a result. Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a
  success."* Do not lean toward a yes.
- Do not edit the stubs, `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, anything under `visualizations/`, or any
  frozen tool. Propose edits in your plan.
- **Commits by explicit path** (`git add <new file>`, then `git commit <paths> -m …`), subjects "J52: stage n"; never amend; **push after
  each commit; never force-push.**
- **Budget:** about 250k by the harness's count; hand back by 350k.

## Stages (about 45 minutes in all)

1. Quotation check of this brief against its sources, then the reading (about 10 minutes): the stub; `plans/FS73-derivation.md` T22, T39,
   T41, T42; `data/fs73/records/verify-P3b-q167.md` §1–2; the certificate's format. Save.
2. §G (about 15 minutes). Save.
3. §PA and the skeleton elaborating, with the obligation pass and leaf 1's price — the card answered, and the swap decided (about 15 minutes).
   Save.
4. §P, §M, §X and the brief J52K (about 5–10 minutes). Save and report. If time runs out, write J52K's brief before §M, and say that §M is
   left.

## Report

The fixed form (standing rule 9), to `data/crunch-2026-09-25/reports/J52.md`, committed, and by SendMessage `to: "main"`. Its RESULT line
carries the counts (grokkings, rows, rules walked; bears / silent / falsifiable), leaf 1's price, the swap decision (FS-75 or FS-87) and the
kernel target's statement verbatim from the skeleton. List the bears as INVENTORY lines (`bears — G<n>: <what it changes> — §G.1`) and J52K
as a SPAWN line with its brief file. Keep your turn's final text content-free: "J52 idle; report sent to the owner by SendMessage".

Thank you.
