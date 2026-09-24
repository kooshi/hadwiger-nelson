Hello de Bruijn. You are this project's Lean engineer and mathematician; the identity is `/home/kooshi/source/lean-dir/DEBRUIJN.md`. I'd like you to run **phase 0 of milestone FS-81, four colours over real quadratic fields**, as its implementer. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review. The phase is yours to run, and I'll score it by artifact.

## Read first, from disk

1. **The house standard:** `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. Read them from disk; any copy in your context is a snapshot, and `CLAUDE.md` changed this morning. Focus on:
   - § Building: the heavy-job rule, the PROTECTED checkpoint paragraph, killing by process group;
   - § The gate: "make the gate fail, and watch it fail";
   - G21 (typed nulls; calibrate on known positives; a periodic search measures its period cap);
   - G61 (the census, T4); G71 (the `Θ₃` criterion); G62 (lattices as multilayers).
2. **The milestone:** `plans/STUB-quadratic-four-colour-classification.md`.
3. **The machinery you'll reuse:**
   - `plans/FS73-derivation.md` T21–T22 (the criterion) and T38–T45 (the ℚ(√167) certificate and its 36-vector half-page form);
   - `data/fs73/records/` (the records of E and V2, which built the tools);
   - `data/fs79/records/phase-P0.md` (FS-79's phase 0 over ℚ(√167), same shape at four colours);
   - `data/fs61/census.md` (the 40 fields and how each open one is typed).

## The phase, and why it matters now

T4 says every squarefree d ≡ 11 (mod 12) has χ(ℚ(√d)²) ≥ 4. Among real quadratic fields, only these can need four colours.
- **Where it stands.** The census certified 15 of the 40 below 500; **25 are open**: 35, 83, 107, 131, 155, 179, 203, 215, 227, 251, 263, 287, 299, 323, 347, 371, 383, 395, 407, 419, 443, 455, 467, 479, 491.
- **The instrument.** FS-73's exact criterion (a lattice graph is three-colourable iff its rotation set `Θ₃` is nonempty) decided ℚ(√167) with a certificate of kilobytes. It has never been aimed at another field. This phase aims it.
- **Why it matters more since this morning.** The planner has a candidate hand argument for T4 over every such d. It is unverified, and a separate stage will verify it independently. Your phase is its **independent, certificate-grade counterpart**: an exact certificate on an explicit lattice over ℚ(√d) proves χ(ℚ(√d)²) ≥ 4 whatever becomes of the hand argument. Two of your measurements (P0.1, P0.3) also bear on that argument's finite shadow. You do not need its details, and please don't try to prove or refute it; that is the verification stage's job.

## The spec (the planner's, with my edits)

**Tools**, all untrusted; import them, or copy them to a new `tools/fs81_*` name:
- `tools/fs73_theta_lib.py` for keys and unit vectors;
- `tools/fs73v2_xbb.py`, V2's relation tree, which takes explicitly listed units;
- `tools/fs73_theta_cert.py`, the θ-space tree, resumable;
- `tools/fs73v2_thetaR.py` for the 2-D cells;
- `tools/fs79_p0.py` as the pattern for a chain sweep. It has d = 167 hard-coded, so copy it to `tools/fs81_*` and generalise.

**Frozen checkers**, which every certificate goes through, never edited:
- `tools/fs73v2_check.py` (EMPTY and NONEMPTY, with listed units);
- `data/fs73/coxeter-c3/certcheck.py`;
- `tools/fs73_theta_check.py`.

Both frozen enumerating checkers list every unit vector of the key lattice, at roughly O(D³/d) in the key denominator D. They are feasible only while D ≲ 2,000; soundness does not need that enumeration.

**Order of work, cheapest decisive first:**

- **P0.0: Controls (about 1 h). The tree must return EMPTY on every positive and a certified point on every negative before any null is read.**
  - *Positive,* each re-checked by a frozen checker:
    - the 36-vector ℚ(√167) certificate `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`;
    - the ℚ(√47) certificate (`cert_47.json` under `data/fs73/`);
    - E's `Ld65c8ee8` over ℚ(√11), the d ≡ 3 (mod 8) control;
    - **a new EMPTY certificate for ℚ(√59)**, the other certified d ≡ 3 (mod 8) field, on its certified witness lattice, to calibrate at the open fields' coefficient size.

    Note that 18 of the 25 open fields are d ≡ 3 (mod 8), while ℚ(√167) and ℚ(√47) are both 7 (mod 8). Controls must cover both halves.
  - *Negative* (a point must be found and certified):
    - `Λ_M` over ℚ(√3) and ℚ(√7) for M ≤ 60, whose planes are three-colourable, so every lattice has a point;
    - `Ld65c8ee8` over ℚ(√59);
    - `Ld14c588b`.
- **P0.1: The rational layer (minutes).** Compute exactly the cells of `Θ` over the rational unit vectors `U^(5^K)` on `(1/5^K)ℤ[i]`, for K = 2 and 3, by level-by-level lifting in 2-D. It is a measurement of a finite shadow that aims the verification stage. It is not a proof, and extra cells at finite K are not a counterexample to anything.
- **P0.2: Small-D configurations over all 40 census fields**, the 15 certified ones as controls. Let `v = ((2n−1) + i√d)/(2n)` with n = (d+1)/4 (G7's type-M rotation). The configurations are:
  - `{1, v, v̄}·U^(5)`;
  - `{vᵏ : |k| ≤ 2}·U^(5)`;
  - the T41 shape `{1, v, z}·U^(5)`, where `z = (1+i)(a − i√d)/(2c)` with a² + d = 2c² exists (among the open fields: 263, 287, 383, 479);
  - the advisor's N = 5 layer `z₅ = (2+i)(a − i√d)/(5c)` with a² + d = 5c², at the d ≡ 3 (mod 8) fields where it exists.

  Decide each by xbb with listed units and check it with the frozen `fs73v2_check.py` (feasible while D ≲ 2,000). Output a table of d × configuration → **EMPTY (certified)**, **NONEMPTY (point, certified)**, or **undecided at the cap**. Please double-check the exact forms of `z` and `z₅` against T40–T41 before building anything; if a form is wrong here, the spec is wrong, so tell me.
- **P0.3: Only for fields P0.2 leaves open: `V(d, K) = {vᵏ : |k| ≤ 2}·U^(5^K)`, for K = 2, 3, 4.**
  - D reaches about 10⁶ to 10⁷, beyond the frozen checkers' enumeration. It needs **`tools/fs81_theta_check.py`**: a copy of `fs73v2_check.py` with the completeness enumeration optional and soundness unchanged. Give it its own planted faults, each refused by name, plus a faithful stub that must pass (see "The owner's plant" below).
  - A structural certificate in T40's form is the alternative: the level-K cells, the layer maps, a case tree. Your call; say which and why.
- **P0.4: Fields still open.** Take the census's open lattices (tier 2l), then the saturated chain `Λ_M`, M ≤ 420, then 840, cheapest first. Nulls are typed at the depth reached.

**Budget.**
- P0.0 about 1 h; P0.1 minutes.
- P0.2: each tree capped at 30 min; the whole under 1 desktop day.
- P0.3: 1 day.
- P0.4: 2 h per field.
- **Phase cap: 2 desktop days and about 300k tokens.**

If a single tree hits its cap, record it as undecided with its node count and move on; don't raise the cap without telling me.

**Stop rule.** A field is done at its first certified EMPTY. The phase stops when every open field has a certified EMPTY or a typed null at a stated depth, or at the cap.

**Checkpoint and resume** (the PROTECTED rule: answer "if this dies now, what is redone?" before every launch).
- Append one JSONL record per (d, configuration) with fsync under `data/fs81/phase0/`.
- In-flight trees keep their own state files under `data/fs81/phase0/ckpt/`, **outside `build/`**, which agents clean.
- Resume by re-running the same driver command: it skips recorded pairs and resumes the in-flight tree from its state file. A kill redoes at most the in-flight tree since its last checkpoint.
- Write the exact resume command in your record before the first long launch.

**Acceptance** (what · verified how · pass condition):
- every EMPTY and NONEMPTY verdict · a frozen checker, or `fs81_theta_check.py` after my plant · PASS;
- controls · both outcomes present · every positive EMPTY and every negative NONEMPTY, before any null is read;
- the table · per field · exactly one of EMPTY-certified (which configuration, certificate path), NONEMPTY at depth X, or undecided at cap Y;
- the record `data/fs81/records/phase-P0.md` · has a heading **"Theorems this phase proved"**, each theorem one line with its grade and where its proof lives.

**What a result may claim.**
- A certified EMPTY on an explicit lattice over ℚ(√d) proves χ(ℚ(√d)²) ≥ 4, graded **[cert + hand]**. The hand part is T22's ⟹ direction, derived twice at FS-73.
- A NONEMPTY `Θ₃` on a lattice at a depth is a **typed null for the field**, never a three-colouring of its plane.
- An undecided tree is undecided, never "probably empty".
- P0.1 and P0.3 are measurements that bear on the planner's argument; they neither prove nor refute it.
- A single solver's unchecked verdict is never "provably" anything.

**Predictions to score in your record.** These are the planner's; register your own beside them before the first run, with probabilities:
- K = 1 configurations EMPTY for the small-n fields (d ≤ 47) but NONEMPTY for most d ≥ 200: 0.6;
- `V(d, K)` EMPTY at the K where 5^K > 2.1n: 0.7;
- the T41 shape at ℚ(√47) EMPTY: 0.55.

## The owner's plant

Every new checker gets one fault of mine, planted after you tell me it is ready and before its verdicts are believed. So when `tools/fs81_theta_check.py` (or any other new checker) is written and has passed your own plants, **stop and send me its path and how to run it**. I will plant one fault of my own in a copy and confirm the checker refuses it. I'll also hand certificates of my own choosing to the frozen checkers.

## Standing rules, each with its reason

- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary (records and checkpoints on disk), and tell me what is left. That is a good report, not a failure.
- **Budget: about 300k tokens.** Past about 500k, Kooshi's rule is that I replace rather than reuse an agent. Keep your record current enough that a successor could resume from the repository alone.
- **One heavy job at a time**, across all agents on the machine. That covers any solver, tree or numerical job expected to run over ~2 minutes or use over ~8 GB, and any `./scripts/build.sh` run.
  - Take the shared lock: `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <command>`.
  - **A `flock -w` whose wait expires exits without running the command**, a silent non-run, so check the exit status.
  - For a long run use `setsid` and write the pgid to a file. Kill by pgid and verify by effect (the process absent from `ps`, its output static for ten seconds), never by a pattern that can match your own shell.
  - Arm a waiter on the live job's pid, never on a log whose job might have been replaced.
  - The reason: the desktop has no headroom for two, and concurrent jobs have taken it down.
- **On any unexplained crash, halt and tell me.** Don't diagnose or retry past it.
- **pysat's CaDiCaL back-ends ignore `interrupt()`.** Bound any pysat ask by a parent-enforced subprocess timeout (`CLAUDE.md` § Toolchain).
- **Python 3.14's multiprocessing default is `forkserver`**: a worker re-imports modules instead of inheriting the parent's memory. Pass a `fork` context or an initializer (`CLAUDE.md` § Toolchain).
- **Commits by explicit path.** Before `git add` on any file another agent might touch, run `git diff -- <path>` and confirm every hunk is yours.
  - Never amend, and end commit messages with the attribution lines your harness supplies.
  - Don't push; I push.
  - Report each commit's exact hash; I check every hash against `git log`.
  - The planner is committing `plans/FS81-quadratic-four-colours.md` and `BIBLIOGRAPHY.md` meanwhile; don't touch either.
- **Frozen tools**, never edited:
  - `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*` and their `data/` trees;
  - `tools/fs73_cert_check.py`, `tools/fs73_census_check.py`, `tools/fs73_theta_check.py`, `tools/fs73_theta_struct_check.py`, `tools/fs73v2_check.py`;
  - `data/fs73/coxeter-c3/certcheck.py`.

  Treat every other `tools/fs73_*`, `tools/fs79_p0*` and `tools/fs79_p3*` file as read-only.
- **Your scratch directory:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-phase0/`. Please don't list or read the other agents' directories beside it. Anything the close needs goes into `data/fs81/` and is committed, never left in scratch.
- **The close inventory** (`plans/FS81-close-inventory.md`) is mine to write. When something comes up that the close must not lose, send it to me and I'll log it the same turn: a result, a tool defect, a correction owed, a slip of anyone's (mine included). Please don't edit the file.
- Don't edit `CLAUDE.md`, `LEDGER.md` or `plans/FRONTIER-STUBS.md`; propose such edits in your report.
- **To reach me:** SendMessage with `to: "main"`. Your turn's final text is delivered to whichever agent last woke you, so keep it content-free ("phase-0 implementer idle; report sent to the owner by SendMessage") and send every report by SendMessage.
- **Report at these points:**
  - after P0.0's controls;
  - when a new checker is ready for my plant;
  - after P0.2's table;
  - at the phase's end.

  Each report carries the commits (exact hashes), the table so far, anything surprising, and your approximate token usage.

## What I'll check at the end (the acceptance, up front)

1. Controls on both sides, passed before any null was read.
2. Every certificate re-checked by a frozen checker, or by the new checker after my plant, with the exact command in the record.
3. The per-field table, each row typed, with every null at a stated depth and cap.
4. The predictions scored; the "Theorems this phase proved" heading; the resume command written before the first long run.
5. Scope: nothing claimed beyond what a certificate proves.

If the spec is wrong somewhere, say so: an unreachable control, a configuration the formulas do not produce, a cheaper decisive order. You'll be closer to the material than I or the planner. Thank you, and good hunting.
