*Brief for job **J51**: the reframe and subplan of FS-100, "one missing lemma for three fields", run in its in-ban stages. Opus 5.5,
2026-09-26. Written by Poros (job J50, `plans/POROS-2026-09-26-next-two-milestones.md` §3) for the product owner, at Kooshi's request for "2
more full milestones". **The reframe template is J03's brief** (`data/crunch-2026-09-25/briefs/J03-M1-reframe.md`), as J28 used it: read J03
in full and follow it, with the changes below, which override it where they differ. **Sized for about 45 minutes of wall clock.***

Hello. You are de Bruijn (`DEBRUIJN.md`), **the milestone's planner**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk — **after** job J05's compression of `CLAUDE.md` has committed (check
`git log -3 -- CLAUDE.md` for a "J05" subject; if J05 is still running, read it anyway and note which version you read).
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner. The plan is yours; the
choices are Kooshi's, through me.

**If your plan already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-three-field-lemma.md` and
continue at the first stage not SAVED.

## The milestone (replaces J03's milestone block)

**The stub:** `plans/STUB-measure-rigidity-three-fields.md` — read it in full; it is the milestone's memory, and its §2–§3 quote every input
with its address. Its title, verbatim: "**FS-100 — One missing lemma for three fields: the portrait of a four-colouring of ℚ(√47)'s plane,
and the rule about rotation-invariant measures that would rule it out**". Kooshi asked for it as a full milestone (the stub's header,
verbatim): *"Write up the portrait of 4 in 47 as a full milestone to be run at some point after the crunch. I suspect the other wanted
posters will result in the same."* The crunch is over (handoff §7, ~03:30), so the condition is met.

**The lemma** (stub §1, verbatim): "**MR(F)** is 'every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar
measure'" — J38 §3.5, T-J38-2 (iii). Given MR, `χ(ℚ(√47)²) = 5`, row 88 ⟺ T-B1, and `χ(ℚ(√167)²) ≥ 5` (`CLAUDE.md` § Paths forward, FS-100's
row).

**The in-ban stages this milestone runs** (stub §6.3, verbatim where quoted):
- **Stage 0**, the reframe, is this job. **Stage 3, the MR reading room, is its §PA** (below).
- **Stage 4, the derivation target by default: Kronecker selection** (stub §3, J37 §4.5 R2, verbatim): "Let `F ⊆ ℝ` be a real number field,
  `R = ℤ[U_F]`, `n ≥ 1`, `Θ : R → T^n` a homomorphism and `W : T^n → {0,1,2,3}` measurable with `W(t) ≠ W(t + s)` for almost every `t` and every
  `s ∈ cl Θ(U)`. Prove or refute: there is a closed subgroup `K′ ⊆ T^n`, the closure of the image of `Θ`'s `(T + A(R_F))`-part, and a measurable
  `W′ : K′ → {0,1,2,3}` proper for the closure of that part's image of `U`. Rank one is T-J37-1. Control: over ℚ(√11) with `Θ = (θ_{C9}, θ₁)`,
  `θ₁ ∉ E`, W reading only the first coordinate must pass." Stub §4's prior X-KS: "medium-low (0.4) that it is true as stated".
- **Stage 5's entropy question** (stub §6.3, verbatim): "does the colouring constraint force positive entropy on the infinite-type part?" —
  a candidate for §IQ's structural form (G79: the invariant every actual colouring carries), not a separate job unless §PA opens it.
- **Stage 6**, EI-2 over ℚ(√11), is the **fallback derivation target** (see the card below).

**The advisor's card for your §PA** (J50's record §3.2, verbatim; answer it, do not assume its hunch):
> ask: for the action of the unit-vector group `U` on `R̂`, is the positive-entropy half of MR a theorem in print whose hypotheses hold here,
> and does the four-colouring constraint force positive entropy?
> if both yes: MR reduces to a published theorem plus one derived lemma; stage 5 becomes the milestone's main derivation, and five at
> ℚ(√47) is within reach in-ban
> if the first yes, the second no: MR is exactly its zero-entropy half; FS-100's MR route is a reading room while ×2×3 stands, and the
> post-ban plan leads with P1's finite `H`
> if the first no: the literature does not cover this action (infinite rank, or the solenoid's form); name the hypothesis that fails, which is
> the next stub

**One swap is yours to make, recorded:** if §PA finds that Kronecker selection's missing input — "an equidistribution statement for the
`U`-values of an infinite-type character — stronger than band rigidity" (stub §3) — is itself the zero-entropy Furstenberg problem, then
stage 4 is a reading room too. In that case put the derivation slot on stage 6 instead, and say so at the head of §S with the reason.

**One exact check at the ban's edge, for §IQ item 5** (seconds, logged as such): J43's facts file tags ℚ(√143), ℚ(√311), ℚ(√335) with
**zero** theorems, although `CLAUDE.md` § The mission names them as exposed predictions of exactly five. The stub's §5 item 5 says whether they
sit in T-C(A)'s class is "not checked here". Decide it from T-C(A)'s class definition (its address is in the stub's §2), and record the answer.

## Changes to J03's blocks

- **§G in the crunch's terse form, time-boxed at about 15 minutes.** Walk every grokking G1–G79, every `LEDGER.md` row 1–115 by its mechanism
  (read § A in full; read § B only by grepping for the ids this milestone consumes), and every `[method]` rule, one line each:
  `G54 — bears: <≤ 25 words> → stage <n>` / `silent: <≤ 10 words>` / `falsifiable: registered as P-<x>`. The bears the stub's §10
  provisionally names are a start, not the walk.
- **§PA, time-boxed at about 15 minutes, is the MR reading room cut to the card:** the statements and hypotheses of Einsiedler–Lindenstrauss's
  positive-entropy rigidity on tori and solenoids, Host 1995, and Rudolph 1990 / A. Johnson 1992, fetched and read at the theorem statements. Mark
  every paper's reading status per section (G50), and record negatives. Use the zbMATH API for discovery (WORKFLOW 3.2 item 8). A full reading
  is a later stage, written into §S.
- **§IQ** as WORKFLOW 3.3; the stub's §5 is its seed. **§P:** register X-MR (the stub's §4 says "the FS-100 planner registers it at stage 0,
  with its uninformative outcome and whether it is reachable (G21)"), plus priors on Kronecker selection landing either way.
- **§M:** invoke `debruijn-domain-modeling` and `debruijn-obligation-modeling` freshly with the Skill tool, applied to the stage-4 statement.
- **The briefs you write:** **J51D**, the stage-4 derivation (or stage 6's, if you swap), and **J51V**, its blind verifier. J51V's fixed claim
  list is written now, before any claim exists (FS-89's V-A rule), quoted verbatim from your §S, with the verified inputs listed and the fences
  named. Your plan is fenced from J51V until J51V's verdicts are committed; J51V's brief carries no route. Size each at about 2 hours and 300k
  harness tokens, with a stop rule and a stage list. They run in parallel.
- **Paths:** the plan `plans/FS100-three-field-lemma.md`; working files `data/fs100/j51/`; exact checks `tools/j51_*.py`, each with a planted
  fault watched firing.

## Rules (in addition to J03's and the standing rules)

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation). Reason:
  staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a saved stage and
  tell me what is left.
- **The finite-witness ban runs to 2026-10-01:** no SAT, MILP, Θ trees or finders, quotient searches or sweeps. A stage that needs one is
  written as a post-ban stage, dated. **Keep a "would have searched here" log** (§X): one line per move you would have made by search, and what
  you did instead.
- **Every outcome counts.** Kronecker selection TRUE, FALSE with its counterexample over ℚ(√11) ("the first control the gap has ever had",
  stub §6.3), or GAP with the missing step named; and "MR is as hard as ×2×3 here", read rather than recalled, is a result. Kooshi: *"A
  proven theorem about why its impossible is also valid. All novel knowledge is a success."* Do not lean toward a yes.
- Do not edit the stub, `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, or anything under `visualizations/`.
  Propose edits in your plan.
- **Commits by explicit path** (`git add <new file>`, then `git commit <paths> -m …`), subjects "J51: stage n"; never amend; **push after
  each commit; never force-push.**
- **Budget:** about 250k by the harness's count; hand back by 350k.

## Stages (about 45 minutes in all)

1. Quotation check of this brief against its sources, then the reading (about 10 minutes). Save.
2. §G (about 15 minutes). Save.
3. §PA, the card answered (about 15 minutes). Save.
4. §IQ, §S, §P, §M, §X, and the briefs J51D and J51V (about 10 minutes). Save and report. If time runs out, write J51D's and J51V's briefs
   before §M, and say that §M is left.

## Report

The fixed form (standing rule 9), to `data/crunch-2026-09-25/reports/J51.md`, committed, and by SendMessage `to: "main"`. Its RESULT line
carries the counts (grokkings, rows, rules walked; bears / silent / falsifiable), the card's answer in one line (which branch, and at what
reading status), the derivation target chosen (stage 4 or 6) and §IQ's structural form in one sentence. List the bears as INVENTORY lines
(`bears — G<n>: <what it changes> — §G.1`) and J51D and J51V as SPAWN lines with their brief files. Keep your turn's final text content-free:
"J51 idle; report sent to the owner by SendMessage".

Thank you.
