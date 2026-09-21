# Session handoff — FS-66 mid-milestone: three towers certified, 23 solving on the GPU, a prover at work on the general conjecture

*Written 2026-09-21 by the product owner just before a compaction, for a reader with no conversation memory (most likely myself).
Everything here is checkable against the repository. Read this, then `plans/FS66-residue-tower-drop.md` §0 and §Q (the running
list of rulings and acceptances is the block of bold paragraphs at the end of §Q), then `plans/FS66-phase2-certificate.md` §0, §ST,
§H and the §R sections. The standing rules are in `plans/SESSION-HANDOFF-2026-09-20.md` §0 and are repeated in one line each in §1.*

## 0. Who I am and what is live RIGHT NOW

I am the **product owner** of milestone **FS-66 — does the residue ceiling drop up the tower?** (Kooshi's go, 2026-09-20). I brief,
review by artifact, rule, and write `CLAUDE.md` / `plans/FRONTIER-STUBS.md` / stubs / `CLOSED-QUESTIONS.md`. I do not implement.

| live thing | what it is | how to find it | what I owe it |
|---|---|---|---|
| **The GPU solve at `p = 23`** (five colours, needs `U < 105.8`) | SCS `gpu_indirect` on graphics card A, 3,000-iteration chunks, ≈ 4–5 s/iteration, full convergence projected 19–28 h; launched detached | `data/fs66/ckpt/b1-p23/README.md` (resume command, chunk shape, stopping criterion, how to find the process by the file it holds open), `solve.log`, `solve.pid`, `solve.pgid` (all untracked on purpose) | read `solve.log`'s chunk lines; **go/no-go = the first 3,000-iteration chunk's reading** (pobj/dobj; at 19 the third digit had settled by ~3,000 iterations). NO-GO (≥ 105.8 and not falling): write cause / measurement / forfeit in the record FIRST, then stop it by PID and verify by effect. GO: leave it running; on convergence brief **Phase 2D** |
| **Phase 2C implementer** (Opus) | certified 19; extended by me to the 23 float reading; told to hand back once the reading is stable and the README written | its messages arrive on their own; agent ids are in the scratchpad file `agents-fs66.txt` (session-only; never quote ids to Kooshi) | review its final report by artifact; it promised the reading as a message |
| **The prover** (Fable 5.1 planner-mathematician), launched at Kooshi's request | proving or breaking the conjecture that towers are impotent — cleanest form (C-α): `α(G_k) = p^{2(k−1)}α(G₁)` for all `k`; deliverable `plans/FS66-tower-conjecture.md` with a verdict paragraph at the top | brief: scratchpad `brief-fs66-prover.md` | **check any claimed proof line by line myself**; if (C-α) is PROVED for a class of primes containing 23, **cancel the 23 solve** (Kooshi: "if that comes back proven, then obviously we can cancel the run on 23") — record cause / measurement / forfeit first |

| **The `CLAUDE.md` compression agent** (Fable), launched at Kooshi's request later on 2026-09-21 | compressing `CLAUDE.md` with **no fact lost**, through the `prompt-compression` skill's seven steps: a notation legend, one home per fact (ledger = found true; Grokkings = understood; orientation items point at both), PROTECTED paragraphs byte-identical | brief: scratchpad `brief-claude-md-compression.md`; its record `plans/CLAUDE-MD-COMPRESSION-2026-09-21.md`; its guard `tools/claude_md_fact_audit.py` | **I do not edit `CLAUDE.md` while it works** (if the close arrives first, message it to reach a clean boundary). Score by artifact: my OWN token diff against the starting commit, PROTECTED bytes, `gate_report.py`'s regex, `bib_audit.py` before/after, §-references from other files, then three stretches read in full against the original |

**Kooshi's standing word on the long GPU run:** he allowed overnight compute "only with the greatest chance of success"; I told him
the projection (about a day of card A), the default (continue on a good reading, stop on a bad one), and he did not object; he
then asked for the prover so the run can be cancelled if the conjecture is proved. He trusted my GPU smoke test after his `-Syu`
(CUDA 13.4.1 → 13.4.2; driver and kernel untouched) and said carry on — on any GPU fault, stop and tell him.

## 1. Standing rules (full text: the 2026-09-20 handoff §0, `CLAUDE.md` § Delegation, memory)

One Fable planner and one Opus implementer **at a time** · a **fresh implementer per phase**, and never resume one that came back
above ~500k tokens (every agent this milestone under-estimated its own use by 1.3–2×: planners 611k and 432k; implementers 436k,
483k, 379k, 383k) · **no child agent spawns children — say so, with the reason, in every brief** · review by artifact and with my own
code, never by a report's summary; plant a fault of my own · before stopping an agent's run, write cause / measurement / forfeit in
its record FIRST · agents sharing a working tree commit only their own paths (a planner running beside an implementer gets its own
files) · **do not staff a planner's measurements beside a phase whose product is a timing** (my error in Phase 1b) · Kooshi installs
tools on request — inventory in `CLAUDE.md` § Toolchain.

## 2. What has landed (all committed on `main`, nothing pushed)

| result | grade | where |
|---|---|---|
| `(unitQuadrance (ZMod 121)).chromaticNumber = 5` | **Lean kernel**, standard three axioms; 883-point 1-minimal witness; 4.4 CPU-min, 6.1 GB | `Proofs/HadwigerNelson/ResidueTower.lean`, `Instances/ZMod121Four*`; `data/fs66/witness-p11-l2-k4/`; commits `19897bed`, `36f24935` |
| **No level of the tower at 11 or 19 is 4-colourable (at 7: 3-colourable)**: `U = 14.015224…`, `28.204320…`, `77.511742…` against 16.33 / 30.25 / 90.25 | **exact integer sum-of-squares certificates**, `CERTIFIED` by the frozen standard-library checker `tools/fs66_b1_cert_check.py` (written from the spec; I re-ran it on all three; my identity-preserving plants refused) **+ six hand links L1–L6** (`data/fs66/b1/SOUNDNESS.md`) | `data/fs66/b1/cert-p{7,11,19}.json`, `records.jsonl`, `level-one-sets.json`; producer `tools/fs66_b1_cert_make.py`; plan `plans/FS66-phase2-certificate.md` §R, §R″ |
| `α(UD(ℤ/49,2)) = 686` exactly; `3,388 ≤ α(UD(ℤ/121,2)) ≤ 3,412`; `27,436 ≤ α(UD(ℤ/361,2)) ≤ 27,981`; **`α(UD(𝔽₁₉,2)) ∈ {76, 77}`** (was `[76, 80]`) | same | same; my rechecks `data/fs66/owner/po-recheck-*.{out,md}`, `po-plants-phase2a.md` |
| `χ_Bor(ℚ_p²) = 4, 5, 5` at `p = 7, 11, 19`; **`[BardestaniMallahiKarai2017]` Question 1 answered NO** (`χ_Bor(ℚ_p²) ≥ 1 + (p+1)/(2√p)`) | certificates + hand; both statements read first-hand; zbMATH re-check negative | owner's note §7–8; phase-2 plan §ST (owner's addendum) |
| The fibre-density inequality, the biclique structure of level two and its 10×-smaller SAT encoding, the projection of level-two refutations onto level one, the liftable-subgraph cuts | hand + checked | `data/fs66/owner/note-2026-09-20-fibre-density.md` §1–6 |

**Instrument lessons to carry into the close:** the second-level moment relaxation with the symmetry divided out beats the 3-point
bound (FS-50) and the GLV level-3 (FS-54) on these planes and bounds `α` itself (`B₁ ≥ α`) · a bound from its rounding **travels with
its shift** (positive definiteness survives iff `shift ≥ 10^(3−D)`; at 11 one knob moves `U` from 28.2021 to 30.5445) · the kernel
has two charges (clause table = the graph's bill, super-linear; segments = the proof's) · ask the whole graph directly, clique
pinned, before building any finder · a fault planted in a generated data module must be compiled into that module.

## 3. Rulings in force (full text: `data/fs66/owner/rulings-2026-09-20.md`; main plan §Q)

Kooshi: build the certificate (done) · the 8-hour SAT sweep at level one of `(23,5)` is NOT run (same instrument failed to converge
at 17 after ~50 core-hours; the fact is already certified) · tools installed (`time`, `bc`, `julia`, `scip`, `cryptominisat`,
`kissat`). Mine: Phases 1c (level three by SAT) and 3a (`(19,4)` by SAT) STRUCK — subsumed by the certificates · **my ruling that
23 was "out of reach" is OVERTURNED** (the 19 reading, 77.5, came in below the level-3 relaxation's 80.59; "it must beat 105.43" was
never an argument that it cannot) · the finder at `UD(ℤ/529,2)` (the only instrument that could settle level two of 23 in the
*surprising* direction): **explained to Kooshi in full on 2026-09-21 with this default — not launched now; on a GO reading it stays
unrun (a certificate below 105.8 means it cannot succeed); on a NO-GO reading the GPU job is stopped first and a fresh small
implementer runs it (plan §I7(d): CaDiCaL on the biclique encoding, 16 seeds × 30 min, positive control at eight colours, my
verifier on anything found).**

## 4. What is left, in order

1. **23:** the reading → (GO) convergence → **Phase 2D brief** (fresh Opus): round with the widened grid of §R″ (one exact rounding
   attempt at 23 costs ≈ 2.9× 19's 243 s — price the scan first), `cert-p23.json` `CERTIFIED` with `--m 5` by the frozen checker
   (expect ~25–60 min and several GB at 23 — measure), an explicit 87-point level-one set verified from the definition, records,
   README statement. `⌊U⌋` also bounds `α(UD(𝔽₂₃,2))` (certified ≤ 105 today); a reading below `529/6 = 88.17` would refuse SIX at
   every level and close a member of the window for six. **Re-assessed after the handoff: closer than "not expected".** The
   reading cannot be below 87.51 (my single-class local search exhibits a feasible point of that value, `data/fs66/owner/alpha-fuzzy.out`),
   and at 7, 11, 19 the certified bound sat 0.1 %, 0.7 % and ≤ 2 % above level one's independence number — so expect ≈ 88–89.5.
   **`U < 89` certified gives `α(UD(𝔽₂₃,2)) ≤ 88 < 89`, i.e. `χ(UD(𝔽₂₃,2)) ≥ 7`: 23 leaves the window for six at level one** (FS-17's
   digit), even if `U ≥ 88.17` leaves six open at higher levels. If the float lands near 89, Phase 2D's brief must protect that
   margin in the rounding (the bound travels with its shift). Told to Kooshi. **The full ℚ(√167) statement also needs 43** (its other
   usable prime below the spectral refusals at 59+): unpriced — `n = 1,849`, roughly 3 M moment variables; price it, do not run it.
2. **The prover's verdict** — check it myself; act on it (§0).
3. **The close (mine; WORKFLOW 8–10).** *(Update, later on 2026-09-21: a first trim is DONE — commit `d0df4f82`, 242,682 bytes,
   7.3 KB of room; G59's killing test at 19 and G57's stale `α ≤ 377` are already current. The close adds roughly 6 KB, so find
   2–3 KB more when the row and the grokking are written — NOT from § "Make the gate fail" or any PROTECTED paragraph.)*
   `CLAUDE.md` was at **246,496 of 250,000 bytes: TRIM FIRST** (candidates: the ranked-stub row
   for FS-66; G59's long "killing test at 19" narrative — now partly answered by `α(19) ≤ 77`; G58's attempted-decision paragraphs;
   the tools table). Then: ledger **row 75**; a grokking (the tower's limit is the clopen chromatic number; one level-one inequality
   governs every level; the numbers; the conjecture with its killing test — a verified 687-set in `UD(ℤ/49,2)` now refutes the
   hand links or the checker); item 12/14 and G48/G54/G56/G59 touched in place (the prediction at ℚ(√167) vs the tower; `α(19)`);
   prior-art position (Madore Prop. 3.8 owns the chain; BMK pose the p-adic problem); "Last updated"; open-milestones paragraph;
   § Toolchain method lines. `plans/FRONTIER-STUBS.md`: FS-66 to the closed list; **re-aim FS-57 (fractional wall), FS-65 (exact
   independence numbers), FS-17 (first digit at 23) at the new relaxation**; FS-59's row (the prediction now robust at the levels
   certified); **new stubs**: *the tower never rises at 7* (exact density 2/7 by an exact-face certificate — needs
   positive-semidefinite blocks, a checker format change); whatever the prover leaves open; the certificate at 43.
   `CLOSED-QUESTIONS.md`: new §1.8 (BMK Question 1 + the exact Borel values), and a caveat in §1.7 (the bracket at ℚ(√47) cannot be
   closed from above by any level of the 11-adic tower). `BIBLIOGRAPHY.md`: Kang–Maharaj 2010 (listing only). Sweep both FS-66 plans
   and the prover's file for "conjecture" / "not claimed". **Lint:** one pre-existing error, `CayleyCert.cert23_8` (an underscore in
   a name; confined to `CayleyCertificate.lean`) — a rename in its own labelled commit through `./scripts/build.sh`, by a closing
   implementer, then the full gate (`build.sh`, `axioms.sh`, `vacuity.sh` + `--self-test`, `check_architecture.py`, `bib_audit.py`).
   Gate counts already reconciled in `CLAUDE.md`: 1,004 clean; 6,723 declarations; 270 refutations skipped.
4. **The final report to Kooshi** in the house format (he has had two interim reports; the second is the fuller).
5. **Then FS-59's R9** (the pinned ask on his 7-cycle triangle at ℚ(√167)), as he sequenced — in a fresh session.

## 5. My recorded errors this milestone (so the close states them)

The "23 is out of reach" ruling (told to Kooshi twice) · telling planner 2 the relaxation "cannot read below 29.18" · asking for
Julia as "the one that matters" (not needed at 7–19) · staffing planner 2's probes beside Phase 1b's timing measurements · my first
`(11,4)` probe silently never ran (`cd X && (A) & (B) &`) — caught by planner 1 · the stub's §3 overclaim — caught by planner 1 ·
two dead instruments in my first brief (`ϑ′`; parallel-lines family) — caught by me.
