Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to run **stage B2–B3 of milestone FS-86**: the exact dyadic profile of one named lattice over ℚ(√59), and exact certificates for the plan's definition of "rich". I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the computations and their reading are yours. I'll score them by artifact.

## Read first, from disk

1. `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`, from disk. Especially:
   - § Notation;
   - G54 (tight or slack; its middle case, observed at row 87);
   - G66, G68, G69;
   - G21 and the method rules in § Building and § Make the gate fail.
2. **The plan:** `plans/FS86-dyadic-rigidity.md`, in full, **§R-review included** (the owner's rulings). Especially:
   - §0: the milestone after the reframe;
   - §S.1: "rich", `Λ₅₁₀`, `Λ₂₇₃₀`;
   - §B: your stage's slots, which are your task list;
   - §P: P-sat, P-slack and P-undec, the predictions your results score;
   - §G.3: the method rules as they bear on your stage.
3. `LEDGER.md` rows 67 and 87; `plans/FS38-derivation.md`, L1–L3, D2-A and D2-B (row 67's tower, its elementary-divisor certificate and its spectrum table); `plans/FS85-derivation.md` L16 (a slack level that still forces) and dB5.
4. `data/fs86/stageA/`: the planner's enumerators and checks. Reuse them. The planner cross-checked two unit-vector enumerators at `M = 30, 210, 2730`.

## Why this stage

- **The full dyadic tower of ℚ(√59) is row 67's, which is solved.** It is four-tight at every level, and every four-colouring at level ≥ 5 is pulled back from level 4 (plan §0.1).
- **What is not known is a lattice's image of it.** A lattice has finitely many unit vectors, so its quotient `Q_m = Cay(Λ/(Λ ∩ 𝔓^m), U mod 𝔓^m)` is a spanning subgraph of `P_m`, and it stops being all of `P_m` once `|S_m| = 3·2^{m−1}` exceeds the residues `U` reaches.
- **Your stage is lattice-level.** It scores **Draw (lattice)** in the plan's verdicts at most, and it gives the competition exact data about how a finite lattice sees the dyadic place.
- **A second agent, verifier B1, runs concurrently** on the plan's field-level frame (§0.3–§0.4). Please don't message it or open its record (`plans/FS86-B1-verification.md`) or its `data/fs86/b1/`: it is working blind, and its value is its independence.

**How outcomes count** (Kooshi, 2026-09-24): *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* "Every level tight", "slack from level m", and "slack, undecided" are all results. Please don't lean toward the outcome that looks like rigidity.

## The tasks (plan §B, in this order)

1. **C0.** Before computing anything, write at the top of your record your own predictions for P-sat, P-slack and P-undec (plan §P), with probabilities, and commit them.
2. **B2's positive control, first.**
   - Reproduce row 67's spectrum table on the full `S_m`, levels 1–8: `λ_min(P_m) = −2^{m−1}`, and 45 minimisers at level 4. Check each value against `plans/FS38-derivation.md`.
   - Plant one fault in your spectrum code (a wrong generator, say) and confirm the table goes wrong. A control whose failure mode is unreachable has not been tested by passing (`CLAUDE.md` § Make the gate fail).
3. **B2 on `Λ₅₁₀`.**
   - For each `m`, compare `U mod 𝔓^m` against `S_m` (a membership check on every residue, never a count alone). Find the saturation depth `m* = max{m : U ↠ S_m}`.
   - For `m` up to the level where `U mod 𝔓^m` is injective:
     - `Q_m`'s spectrum;
     - the sign of `λ_min + d_m/3`;
     - `H_min` (the least eigenspace's characters) where `Q_m` is tight.
   - The lattice analogue of FS38-L3: `M_Λ = ℤ-span{t − 1 : t ∈ U, t ≡ 1 mod 𝔓}` and its 2-adic elementary divisors relative to `Λ ∩ 𝔓^j`.
   - **Where a level turns slack, say so and stop at that level.** "Slack, undecided" is a registered outcome, and a slack level is never read as free: row 87's L16 is a slack plane that forces, by pulling back from a tight quotient. If a slack `Q_m`'s structure makes a pull-back to a tight level checkable by derivation, say what it would take, and do it only if it is exact algebra with a derived shape.
4. **B3.** Exact versions of §S.1 (R4)'s Hoffman numbers at `B = 59`, by cyclotomic arithmetic or by rigorous interval bounds on the character sums. The planner's numbers are float and were for aiming only.
   - The primes: full circles at 11, 23, 29, 31, 41, 43, 47, 53 and the ramified 59, and at 7 (`q = 49`); partial images at 13 and 19.
   - Each certificate says whether the level-one image target has no four-colouring by theorem: by Hoffman's ratio `< 1/4`, or by the full plane's known χ.

## What you may and may not compute

**The finite-witness-free week runs to 2026-10-01** (`CLAUDE.md` § Toolchain).
- **In:** exact computer algebra whose shape a derivation fixed (spectra of fixed Cayley graphs, Smith forms, membership checks, character sums); colourings given by formula (a pullback from `P₄`, an additive map), exhibited and checked.
- **Out:** any colouring search, SAT, finder, sweep, or screen of lattices for survivors. Every `Q_m` is finite, so "just colour it" is always one command away, and it is out.
- Keep a **"would have searched here" log** in your record: one line per move you would have made by search, and what you did instead.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at once), and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary, persist what you have, and tell me what is left. That is a good report, not a failure.
- **Resources.** Any job over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>` with an honest `--mem`. The plan estimates `Q_m` spectra at `m ≤ 12` fit under 4 GiB. /tmp is RAM on this machine, so large outputs go to disk under `data/fs86/b2/`. Never run `lake build`.
- **Checkpoints.** Each computation should take minutes. If one would run past about 15 minutes, it checkpoints and resumes (`CLAUDE.md`'s protected checkpointing rule). Write its resume command in your record before launching it. Kill by pid, and verify by effect.
- **Your record:** `plans/FS86-B2-profile.md`, saved after every result; its §"state" is the resume point. Tools and outputs go under `data/fs86/b2/`. Every number is exact, or labelled float. Give it a heading **"Theorems this phase proved"** (each theorem one line, with grade and address).
- **Commits:**
  - by explicit path; run `git diff --cached` and confirm every hunk is yours, because another agent commits concurrently;
  - never amend; end each message with the attribution lines your harness supplies, after a blank line;
  - neutral, descriptive subjects are fine;
  - don't push; I push; report each hash.
- **Frozen tools are never edited:**
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.

  Treat every other earlier milestone's tool as read-only.
- **Don't edit** `CLAUDE.md`, `LEDGER.md` or `plans/FRONTIER-STUBS.md`. The close inventory (`plans/FS86-close-inventory.md`) is mine to write: send me anything the close must not lose.
- **Budget and stop rule:** about 300k tokens. Stop when B2 has reached the injective level or a slack level and B3's certificates are done, or at 2026-09-26 03:00 UTC, whichever comes first. Past about 500k, I replace rather than reuse.
- **Messages:** reach me by SendMessage with `to: "main"`. Keep your turn's final text content-free ("B2 idle; report sent to the owner by SendMessage").
- **Report points:**
  - after C0;
  - after the positive control;
  - at `m*`;
  - at the first slack level, or at the injective level if every level is tight;
  - after B3;
  - at the end.

  Carry your token count each time.

## What I'll check at the end (the acceptance, up front)

1. C0 was committed before any result.
2. The positive control reproduces row 67's table, and a planted fault was seen to break it.
3. Every `m`: `U mod 𝔓^m` against `S_m` by membership; `m*` stated exactly.
4. Each `Q_m`'s sign is exact, or labelled float with the margin it needs; `H_min` where tight; slack levels read against L16, never as free.
5. The lattice FS38-L3 analogue's elementary divisors are exact.
6. B3's certificates are exact, one per prime, each saying which theorem refuses four colours.
7. The search log is present; "Theorems this phase proved" is present; each commit hash is reported.

Thank you. Exact data on how a finite lattice sees the one place that can force is what the competition will reason from.
