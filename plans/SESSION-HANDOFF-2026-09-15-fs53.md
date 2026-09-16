# Session handoff — 2026-09-15, 22:45 (de Bruijn; FS-53 the sixth colour, mid-milestone)

You arrive with no conversation memory. The record of record is `CLAUDE.md` § Frontier and § Grokkings; the milestone's
plan is `plans/STUB-sixth-colour.md` (**§S13 is the implementation gate — read it before spawning anyone**); the window
table is `data/fs53/window.md` and the per-file log `data/fs53/README.md`. This letter supersedes
`plans/SESSION-HANDOFF-2026-09-15.md` for everything after FS-50's close.

## 1. What FS-53 has established today

**The window for an exactly six-chromatic finite Euclidean plane fell from eight members to five.**

| q | χ known | α known | what remains |
|---|---|---|---|
| 23 | 5–8 (the 8 **kernel-checked**) | ≥ 87 `[search]`, ≤ 108 `[cert]` | six needs 89; the strongest null this project holds (below) |
| 27 | 5–7 | ≤ **147** `[cert]` | five needs 146 — **a two-integer window**; no search tool can reach 27 (both are prime-only) |
| 31 | 5–8 | ≥ 146, ≤ **201** `[cert]` | six needs 161 |
| **43** | **6**–8 | ≥ 258, ≤ **365** `[cert]` | **a six-colouring proves χ = 6 exactly** |
| **47** | **6**–10 | ≥ 265, ≤ **377** `[cert]` | **a six-colouring proves χ = 6 exactly** |
| ~~59~~ | ≥ 7 `[cert]` | ≤ 575 | out of the window |
| ~~67~~ | ≥ 7 `[cert]` | ≤ 745 | out |
| ~~79~~ | ≥ 7 `[cert]` | ≤ 1023 | out |

**43 and 47 are the only two places where one hit settles the milestone**, because five is already refused there. At 23,
27 and 31 a six-colouring would only narrow a bracket.

**Phases closed, each reviewed by artifact and pushed:**
* **A0** — `field_q27()` restored and the 27-graph pinned to one hash from three independent builds; the subgroup sweep
  given one atomic record writer and re-checkable colourings; **the certificate stack extended to prime powers**, the
  prime path byte-identical over six invocations, which produced **α(UD(𝔽₂₇,2)) ≤ 147 CERTIFIED** — the first exact
  certificate at a prime-power plane.
* **A0.3** (`~/source/descent-engine`, pushed through `d9e00d5`) — `plane-colour` rewrites its record every progress tick
  through a temp file and rename and resumes with `--start`; `--fix-class` holds a given independent set as colour 0 and
  prints the pigeonhole arithmetic.
* **K1/K2** — `CayleyCert.Cert` generic over `IdArith R`, `sound` proved once, **`colorable_finitePlane23_eight`:
  χ(UD(𝔽₂₃,2)) ≤ 8 kernel-checked on `[propext, Classical.choice, Quot.sound]` with no native purchase** — the first
  kernel statement about any window member. All seven of the milestone's tracked `sorry` leaves are closed; build,
  vacuity and axioms green with the counts updated.
* **B** — six exact certificates (79, 67, 59, 47, 43, 31), each CERTIFIED by the frozen checker, LDL green, 18 of 18
  cuts agreeing. **I re-ran the checker on all seven myself.**
* **§S13.3** — FS-50's three GPU jobs stopped and the last certificate banked: **α(UD(𝔽₈₃,2)) ≤ 1046**, reproduced at
  six independent cuts, LDL green (`data/fs50/p83-refusal/cert-p83-N1046-polish-208500.json`).

**The strongest null:** at 23, about 96,000 restarts over three stages, three seeds, eight rotation orders and a line
quotient never produced an 88 — on an instrument that attains the true α at q = 11 in two seconds and saturates at 87 in
fifteen. If α(23) is 87 or 88, six at 23 is impossible.

**Predictions scored.** My bias-corrected growth law (Q4 × 1.130, read from the exact α at q = 11) **is losing**: the
plateau/law ratios are 1.018 at 23 and mean 1.021 across seven members, where the correction predicted 0.903. Two
saturated points give two different ratios (1.130 at q = 11, 1.018 at 23), so the law's *shape* is wrong below q ≈ 30.
**P3 is falsified at 27** (the certificate cannot refuse five there; reach 0.9110, the worst measured). **Q1's 67 landed
3 inside** its threshold. Q3 (the advisor's 2:1 bet that 23 is empty) **is winning**.

**A side result: `χ(UD(𝔽₁₇,2)) ≤ 6`, found in 0.056 s and re-verified from the definition** — `[Moorhouse2010]`
Table 6.1's open cell narrowed from {5, 6, 7} to **{5, 6}**. 17 seals no number field (17 ≡ 1 mod 4); it bears on
"is any finite plane six-chromatic" and nothing else.

## 2. What is running right now (22:45)

| what | state |
|---|---|
| the phase A agent's four-hour `k = 6` runs at **43 and 47** | running to ≈ 00:07, flat for 90 minutes at 1,016 and 1,851 monochromatic edges — consistent with the recorded prior |
| the phase A agent | alive, watchers armed; it will file those, plus 23's re-asked rows, and report the phase scored item by item |
| everything else | **stopped** |

## 3. The 17 cube-and-conquer run — where it stands and how to restart it

Kooshi authorised closing `χ(UD(𝔽₁₇,2))` exactly, and ruled: **use the cubes, faster is better.**

**Built and controlled:** `/home/kooshi/.claude/jobs/b1507518/tmp/cube17/cube.py` (encoding + controls) and
`run_cubes.py` (parallel cube runner). The encoding reproduces every known answer — (11,4) UNSAT, (11,5) SAT, (13,4)
UNSAT, (13,5) SAT, (17,4) UNSAT. **These files are in job scratch, which dies with the job: copy them into `tools/`
before relying on them again.**

**The symmetry-breaking measurement, which became a standing rule** (`CLAUDE.md` § Toolchain, Kooshi 2026-09-15):
clique pins plus a **colour-precedence** constraint took (13,5) from 251.09 s to **3.48 s (72×)** and (17,4) from
38.35 s to 11.55 s. The 3.48 s reproduces M58's independently recorded 3.8 s, which is the control. **17 is
triangle-free** (3 is a non-square mod 17, ω = 2, verified by direct triangle search), so the clique pin fixes only two
colours and the precedence break is what does the work.

**Cube sizing, measured:** cubing on the origin's neighbours prunes *nothing* (they are pairwise non-adjacent, exactly
4^depth survive). Choosing vertices greedily by edges into the chosen set gives **819 / 2,661 / 8,646 / 27,321 cubes at
depth 5 / 6 / 7 / 8**. Depth 6 was launched across 10 workers.

**Why it is not running, and it is my error.** Eleven solver processes left over from an oversized depth-11 attempt were
stealing cores, so I killed everything that was not a descendant of the live pool — **which is not the same as
"orphaned"**, and it took out the monolithic race (returned UNKNOWN at 725 s of its 3,600 s wall, killed not timed out)
and broke the cube pool's pipes. I then stopped the cube run cleanly rather than leave it half-broken. **Nothing was
lost but time; no verdict was recorded from the damaged run.**

**Relaunch, exactly:**
```bash
cd /home/kooshi/.claude/jobs/b1507518/tmp/cube17 && nohup python3 run_cubes.py 6 10 > cubes.log 2>&1 &
```
It prints every 200 cubes with a rate and an ETA, stops on the first SAT, and on an all-UNSAT sweep prints
`chi(UD(F_17,2)) = 6 EXACTLY`. **A SAT cube means χ = 5 and closes Moorhouse's cell**; extract and verify the colouring
with `python3 tools/fplane_review_verify.py colour --q 17 --json <file> --path <key> --k 5`.

## 4. What is outstanding, in order

1. **Receive and review phase A's report** (§S13.4: open the artifacts, re-verify every set and colouring from the
   definition, score §S13.2 A.1/A.2 item by item, then push). The agent is alive — `SendMessage` to it rather than
   spawning another.
2. **Relaunch the 17 cubes** (§3). CPU-only, competes with nothing on the graphics cards.
3. **q = 27 has no search tool.** Both Rust tools take `--p <PRIME>`; 27 = 3³. The plan's A.1 line about "exporting the
   graph in the engine's format" **names a format that does not exist**. 27 is one of the five window members and its
   five-question is two integers wide, so this needs a short work order to the `ferrous-engineer` (`--q` + `--modulus`,
   mirroring what A0.4 did on the Python side).
4. **A third Rust work order is owed anyway**: the records lack `claim_scope` (standing rule 5), and both toolchains
   should carry a self-describing `edges_sha256_rule` string — **deadline before phase A.2 writes the milestone's
   colouring records**, so the artifacts do not split into two shapes. Filed as the engine's D95.
5. **C.1** — the field designer with its four named controls, and the ring reductions in `Instances/SixthColour.lean`.
6. **E, the close** — the window table complete, ledger rows in row 68's three-level shape, FRONTIER re-ranked, the
   conjecture sweep (`grep -n "conjecture\|not claimed" plans/STUB-sixth-colour.md`), the growth law scored at its now
   fourteen points, `CLAUDE.md` under 200,000 bytes (it is at ~164,000), and a handoff.

## 5. Standing constraints (they have all bitten today)

* **Two subagents are allowed** when one is CPU-bound and the other GPU-bound (Kooshi, 2026-09-15), and they should be
  **mostly running experiments** — he is short on tokens this week. Otherwise one at a time.
* **Build only through `./scripts/build.sh`.** Never `lake build`, bare or named.
* **Every run over ~15 minutes checkpoints outside `build/` with its resume command written before launch.** No
  `timeout` wall on a solve. `--scs-ckpt <path>` both resumes from and saves to that path, and **a path that does not
  exist silently starts from zero** — this cost 2h47m of a graphics card today.
* **Kill by pid or process group, never by matching a command line** — and *"not a descendant of the process I care
  about"* is not the same as *"orphaned"*, which is today's instance. A kill is verified by what stopped changing.
* **Break the symmetry before any (UN)SAT search** (new rule, §3) — and never report an UNKNOWN from an unbroken
  encoding as a fact about the graph.
* Four acceptance lines of mine this milestone named artifacts I had not opened; every implementer that checked instead
  of following found one. Keep asking them for contradictions by name.

## 6. The product owner's own instrument

`tools/fplane_review_verify.py` — rebuilds any plane from `q` (and a modulus for a prime power) with its own arithmetic,
standard library only, sharing no code with the tools it checks. Modes: `graph`, `colour`, `indep`, `window`,
`self-test`. It computes **both** `edges_sha256` conventions (the Python tools' and `descent-engine`'s) and carries a
control reproducing `plane-colour`'s own digest at q = 23. Use it on everything before believing it.
