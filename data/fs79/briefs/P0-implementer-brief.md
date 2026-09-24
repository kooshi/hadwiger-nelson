*The FS-79 phase-0 implementer brief as sent on 2026-09-23 by the product owner, with the planner's agent id replaced by `PLANNER_ID`. The spec block inside it is the planner's; the five additions are the owner's.*

Hello. You are a de Bruijn implementer (`/home/kooshi/source/lean-dir/DEBRUIJN.md` is the standard), and I'd like you to run **phase 0 of milestone FS-79**: a measurement over the plane ℚ(√167)². I'm the product owner. I coordinate and review by artifact; the phase is yours to run, and its design is the planner's.

## Read first, from disk

`/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. **Read them from disk.** Any copy in your context is a snapshot from the start of my session, and the disk copy is authoritative. `CLAUDE.md` is long; read these parts first: § Notation; G21, G41, G57, G61, G65, G68, G69, G71; § Toolchain (the symmetry-break checklist); § Building (the lock, the checkpoint rule, the kill rules). Then:
- `LEDGER.md` row 79 and `plans/FS73-derivation.md` T17–T27 and T40–T45 (ℚ(√167) at three colours: the residue-set rule, the periodic screens, `L21cc6506`);
- `data/fs73/records/phase-P2b-q167.md` (implementer C's record: the residue-set rule, the tools, and its defects list; read the defects before you reuse anything);
- `plans/STUB-invariant-question-four-colours.md` (what FS-79 is for).

## Why this phase exists

FS-73 proved χ(ℚ(√167)²) ≥ 4. The local–global conjecture predicts at least six. FS-79's main work is a derivation: an invariant every four-colouring carries. That is run later as a competition, and this phase does not touch it. This phase is a measurement that feeds it and feeds FS-59 (five over ℚ(√167)):
1. which ℚ(√167) lattices *could* need five colours, meaning no periodic four-colouring was found at the periods searched;
2. what a direct four-colour refusal would cost on the richest of them.

The second question exists because of an error of mine. I claimed in writing that such refusals are "priced out", borrowing numbers from other populations. Every lattice over ℚ(√167) has rank at most 4, and nobody has priced a four-colour refusal there. Your number replaces my claim, whichever way it goes.

## The spec

The planner (de Bruijn, FS-79's plan) wrote the spec below; it is also §S.P0 of `plans/FS79-invariant-question.md` when that commits. Run it as written, with my five additions after it. If something in it looks wrong once you are in the material, say so to me before working around it. You'll be closer to it than either of us.

```
PURPOSE. Measure, not decide: (i) which ℚ(√167) lattices could need five colours (no periodic four-colouring found at the periods searched), (ii) what a direct four-colour refusal would cost on the richest of them. Feeds §IQ item 5 and FS-59. Results go to the owner; §C is written from §IQ and is not edited from phase 0 except the instance-list slot [P0-SURVIVORS].

A FREE THEOREM FIRST (G1's rule: never run a null a theorem predicts). Every three-colourable lattice is four-colourable. Of FS-61's 57 lattices at 167, 56 are three-colourable (row 79: 52 by certified periodic colourings, 3 by the 3-adic barrier, Ld14c588b by a linear form). So only L21cc6506 is open at four colours among them; no screen is run on the other 56. The live population is therefore L21cc6506 plus RICHER lattices: the saturated chain Λ_M = ℤ⟨all unit vectors of ℚ(√167)² with denominator dividing M⟩, rank ≤ 4, nested along divisibility; χ(ℚ(√167)²) = sup_M χ(Cay(Λ_M, U(Λ_M))).

STEPS, cheapest first (new tool tools/fs79_p0.py; import from tools/fs73_q167.py and tools/fs58_*, never edit the frozen files):
P0.1 Residue-set classification at FOUR colours (C's rule, row 79/T19, re-run): every antipodal residue subset of the circle mod 23 (24 points) up to rotation+reflection, and mod 43 up to 7 pairs (raise if cheap): four-colourable or not; if colourable, is some colouring GAPPED. Controls: at k=3 the port must reproduce C's table exactly (224 classes, 98 colour, 126 refuse, file data/fs73/q167/classify-23.jsonl); the full 24-point circle must refuse four (Γ₂₃ refuses five, row 71).
P0.2 Denominator sweep: for M along a chain (all M ≤ 2520 first, then multiples of 420 and 2520 up to 30,240 or the stop rule), U_M, g = |U_M|, rank, covolume, residue sets at both primes above 23 and above 43 and whether each refuses four (by P0.1), and G65's price (points at average degree 14, 18, 22, 26 by degree = g·φ(R)²). CANDIDATE := every residue set at 23 and 43 refuses four. A 3-colourable Λ_M (Θ₃ ≠ ∅ by the FS-73 tools, or any periodic 3-colouring) is dropped as four-colourable, with the reason.
P0.3 For L21cc6506 and every candidate (cheapest 10 by price if more): the periodic four-colour screens — (a) Θ₄ := {θ : θ(U) ⊆ [1/4,3/4] mod 1} nonempty ⟹ four-colourable (the ⟸ half of T22 at k=4; one-sided), exact tree; (b) residue targets at every usable q ≤ 100 not dividing M (23, 43, 59, 67, 71, 79, 83; plus 29 and 167's ramified prime as T18 used), plain and gap-aimed; (c) additive colourings into ℤ/4 and V₄ (exact linear algebra; Fischer says none on the full plane — expect none, report); (d) full quotients Λ/NΛ at admissible N up to a per-ask cap of 300 s, gap-aimed first; (e) circular forms ⌊4{φ}⌋ to N ≤ 240. Report each lattice as FOUR-COLOURABLE (rule + period group + gapped?/looseness), or SURVIVOR AT <the exact periods and screens searched> — never "none" (G21: a periodic search measures its period cap).
P0.4 Pricing only (arithmetic): each survivor's ball radius and point count at degrees 14–26; name the cheapest.
P0.5 ONE direct ask, only if the cheapest survivor's ball at degree ≥ 18 is ≤ 5·10⁶ points: build it exactly, break symmetry (ℚ(√167) is triangle-free, ω = 2 (G57), so pin one edge's two colours and add the precedence constraint on the other two — CLAUDE.md § Toolchain item 2), kissat and cadical, 1,800 s wall each, under the lock. SAT: verify the colouring on every edge and Fourier-read it for a period before any further period search (G21's method). UNSAT: extract the core, LRAT, and a NEW standalone standard-library checker (fs58_check_witness and fs73_cert_check are three-colour / de Grey-specific and frozen) with ≥ 5 planted faults, each refused by name. UNKNOWN: a typed null with the budget.
CONTROLS (both outcomes reachable): colourable — de Grey's lattice over K (tools/fs73_lattice) must be found four-colourable at N=8 and not at N=5,7 by the same quotient code; L3e1c94c6 (period 23) must be found coloured by the residue screen. Refusing — the 2,044-point graph of data/fs73/census/cert/t-16_8_8_0-R1.5/ (ball + edge {0,v}) and Heule-510 must return UNSAT through P0.5's encoder and symmetry break. Plant — a wrong square root of 167 mod 23 (a NON-square, per C's defect 2) must break the residue check.
PREDICTIONS to register in the record BEFORE any run (implementer's own, with probabilities): L21cc6506 four-colourable by a periodic colouring found in P0.3; the smallest candidate M in P0.2; whether any survivor's degree-18 ball is under 5·10⁶ points. The planner's, registered in the plan: P0-a L21cc6506 has a periodic four-colouring found by P0.3 (0.75); P0-b at least one candidate Λ_M with M ≤ 30,240 exists (0.6); P0-c the cheapest survivor's degree-18 ball exceeds 5·10⁶ points, so P0.5 is not run (0.65).
BUDGET: ≤ 350k tokens; ≤ 5 h wall; ≤ 8 core-hours solver; ≤ 32 GB per job; every job > 2 min or > 8 GB under flock on the heavy lock, setsid + pgid file.
STOP RULES: the sweep stops at M = 30,240 or when the cheapest candidate's degree-18 price passes 10⁸ points, whichever first; quotient asks 300 s each; the phase at 5 h wall.
CHECKPOINT: data/fs79/phase0/*.jsonl (append + fsync per record; every subcommand skips records already present). Resume: re-run the same subcommand (python3 tools/fs79_p0.py <sub> ...). A kill redoes at most the in-flight ask (≤ 300 s; ≤ 30 min for P0.5). Record: data/fs79/records/phase-P0.md with a heading "Theorems this phase proved".
ACCEPTANCE (what · verified how · pass): classifier port · k=3 reproduces C's table · exact match; residue plant · wrong root fires · CHECK FAILS; quotient controls · de Grey N=8 SAT, N=5,7 UNSAT · all three; refusal controls · both UNSAT via P0.5's encoder · both; every "four-colourable" row · a standalone check of its rule on every unit vector (exact) · 0 failures; every survivor row · lists its screens and periods · present; price rows · the φ(R) formula matches G65's on de Grey's lattice ball (R=1.5 → ~18.4) · within 2%.
MAY CLAIM: four-colourability (with its rule and period group; looseness only with a gapped colouring, row 66); "survivor at the periods searched"; prices; a certified refusal only with the new checker's CERTIFIED and plants refused. MAY NOT CLAIM: "no periodic colouring"; anything about forcing; χ(ℚ(√167)²) ≥ 5 from UNSAT without the checked certificate (and if it lands, it goes to the owner at once — it would be the milestone's target met by search, and G72's count must say so); any reading of survivors as "likely to need five".
```

## My five additions

1. **The lock trap FS-73 recorded.** `tools/fs73_table.py`'s quotient ask takes the heavy lock itself, through `fs73_screen.LOCK`. Wrapping it (or anything that calls it) in `flock` deadlocks: implementer C lost minutes to exactly that (FS-73 §R-close.9, and the tool's docstring). Before wrapping any imported function in the lock, check whether it locks internally. If it does, call it bare, and it waits on the lock itself.
2. **Decide each lattice's actual residue sets directly when P0.1's table does not cover them.** A rich Λ_M can reduce to far more than 7 pairs mod 43. Then build that Cayley graph on 𝔽_{43²} (1,849 vertices) and ask four-colourability directly, with the edge pin and precedence break, rather than stretching the table. Record which way each verdict was reached.
3. **An integrality control.** 23 and 43 are usable primes of ℚ(√167), so no unit vector should have either in its denominator (the p-integrality of unit vectors at stable primes; `[Fischer1990b]`, G55's prime inversion). Assert this on every U_M you build: a failure means the unit-vector enumeration or the reduction is wrong, never that the theorem is. It also tells you that M divisible by 23 or 43 adds nothing to the sweep.
4. **FS-73's files are read-only for you.** Import from any `tools/fs73_*.py` and read `data/fs73/`, but edit none of them; they back row 79's records. The frozen ones are listed below, and the rest are to be treated the same way. New code goes in `tools/fs79_p0.py`, and new data under `data/fs79/`.
5. **If P0.5 runs and returns UNSAT,** I'll plant one fault of my own in your new checker at acceptance, beside your five (FS-73's lesson 7: an owner-planted fault in every checker). Write the checker so that a planted certificate can be handed to it by path.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision (three agents at most, and this phase is the third), and I can only review work I know about. If the work outgrows your context, stop at a clean boundary, persist what you have (the checkpoints and the record), and tell me what is left. That is a good report, not a failure.
- **One heavy job at a time**, across all agents on the machine: any solver, search or numerical job expected to run over ~2 minutes or use over ~8 GB, and any `./scripts/build.sh`. Take the shared lock: `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <command>` (subject to addition 1). For a long run, use `setsid` and write the pgid to a file. The reason: the desktop (16 physical cores, 128 GB) has no headroom for two, and concurrent jobs have taken it down.
- **Runs over ~15 minutes checkpoint and resume exactly** (the PROTECTED paragraph in `CLAUDE.md` § Building). Kill by pid or process group and verify by effect: the process absent from `ps`, the output file static, the lock free. Never kill through a pattern that can match your own shell (`pkill -f` has killed agents' own shells here many times). A killed `flock` wrapper can orphan a child that keeps the lock, so kill the group. **On any unexplained crash of any process, halt and tell me**; don't diagnose or retry past it.
- **Symmetry is broken before any SAT ask** (`CLAUDE.md` § Toolchain), and an UNKNOWN from an unbroken encoding is never reported as a fact about the graph.
- **Commits by explicit path.** Before `git add` on any file another agent might touch, run `git diff -- <path>` and confirm every hunk is yours. Never push, never amend, and end commit messages with the attribution lines your harness supplies. Report each commit's exact hash; I check every hash against `git log`.
- **Frozen tools**, never edited: `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees; `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`; `data/fs73/coxeter-c3/certcheck.py`.
- **Don't edit `plans/FS79-invariant-question.md`**: the planner is its only writer. For a question about the spec's intent, message the planner (agent id `PLANNER_ID`, SendMessage with `to` set to it), and copy me on any answer that changes what you run. Don't edit `CLAUDE.md`, `LEDGER.md` or `plans/FRONTIER-STUBS.md` either.
- **The close inventory** (`plans/FS79-close-inventory.md`) is mine to write. When something comes up that the close must not lose (a result, a defect in a tool, an error of anyone's, mine included, a file that must move out of `/tmp`), send it to me and I'll log it the same turn.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-phase0/`. Please don't list or read the other agents' directories beside it, and don't open `~/source/lean-dir-owner/`: the owner's held material for the later competition lives there.
- **Budget: about 350k tokens** (the spec's). Past about 500k, Kooshi's rule is that I replace rather than reuse an agent.
- To reach me: SendMessage with `to: "main"`. **Send me the first finding early:** L21cc6506's verdict, or the sweep's first candidate, whichever comes first. And if a certified refusal lands, send it at once.

## What I'll check at hand-back

The spec's acceptance table, row by row, re-run by me where it is cheap. Beyond that:
- the predictions registered in the record before the first run, with timestamps;
- every survivor row naming its screens and periods;
- the heading "Theorems this phase proved";
- the commits (exact hashes);
- approximate token usage;
- anything you think the spec or I got wrong.

Thank you. It's a measurement that decides how the rest of the milestone reads, and I'm glad to hand it to someone careful.
