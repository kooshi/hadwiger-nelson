JOB FS131-IKC3 — STAGE 4 SAVED   harness≈not readable from inside the job (own≈350k, an estimate)

RESULT:
- TRUE [kernel]: `HadwigerNelson.FibreCert.cert11_ok : certOK cert11 = true` (`Arith/FibreCert11Bound`), axioms
  `[propext, Quot.sound]`. Read against: FS-66's p = 11 certificate (`data/fs66/b1/cert-p11.json`) passes the
  strengthened checker. It is put together from ten `decide +kernel` declarations, each in its own module and each
  `[propext]`: eight identity segments (`cert11_seg0` … `seg7`), the shape (`cert11_global`) and positive
  definiteness (`cert11_psd`). The assembly evaluates nothing.
- TRUE [kernel]: `HadwigerNelson.FibreCertSound.sum_le_eleven`, on the standard three. Read against: every
  φ : (ℤ/11)² → [0, 1] with q(φ) = 2Σφ(1−φ) − ΣΣ_{s∈S} φ_x φ_{x+s} ≥ 0 has
  Σφ ≤ 28204320001863099628721379861820 / 10^30 = 28.2043…. This is FS-66's L4 at p = 11, from `sum_le_of_certOK`.
- TRUE [kernel]: `HadwigerNelson.FibreCertSound.card_le_eleven`, on the standard three. Read against: an independent
  set of Cay((ℤ/11)², {a² + b² = 1}) has at most that many points (U/(121·L) = 0.2331…; the comparison with 1/4 is
  K5's job, not done here).
- TRUE [kernel]: `HadwigerNelson.FibreCertSound.model_eleven`, on the standard three: the hypotheses of both bounds
  hold together (φ = 0; I = {0}).
- No conclusion weakened. The stored statements of `FibreCert`, `FibreCert3` and `FibreCertSound` (791 constants) are
  byte-identical before and after, dumped from the built tree. The checker `tools/fs131_ikc1_statements.py` passes,
  and its planted control fires. `certOK` is unchanged.
- F2 at p = 19: NOT BUILT; `cert19_ok` not reached.
  - Measured: the PSD-per-block cut needs no change to the checker. One 183×183 block takes 45–62 s and 5.3–5.9 GB.
  - Written as probes outside the library, each refusing a planted fault in the kernel:
    - (b) the K table as a checked literal: 10 s and 2.8 GB per five maps, after a 100 s parse of the 17.4 MB literal.
      Its soundness lemma `ktable_eq_of_chk` is proved in the probe, on `[propext, Quot.sound]`.
    - (c) phase 1 cut by orbit range: four pieces at p = 11, each 22–26 s and 3.4–3.7 GB. Their bound shares add up
      exactly to phase 1's bound.
  - GAP at (d), the scatter by position (per-segment op lists, `opAt`, a cover from `segOf` plus counts). It is
    designed (record § 3.3), not written.

RECORD: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-IKC3-implementation.md (branch `fs131-wc16`, not pushed)
COMMITS: 4580ee273 (stage 1), b54109532 (stage 2, K1), 99b3fcfaf (stage 3, F2 probes and design), afd160bbd (stage 4), and the report's commit

INVENTORY:
- result — K1 measured, per declaration (record § 2.2).
  - The build ran under the slot (`MEMMAX=10G BATCH=8`). The data module took 29 s.
  - The segments took 27–56 s each, the shape 43 s, the PSD check 44 s, at most 6.82 GiB per declaration; 394 s in all.
  - `BATCH=1` was not needed. The final build is OK, 0 modules with warnings, and the lint passes — record § 2.3, § Stage 4.
- result — the ten check modules import each other in a chain (record § 2.1).
  - Why: `build_order.py` cuts batches from one level of the import graph, so ten heavy modules that import only the
    data would compile side by side under one 10 GB cap.
  - Chained, each heavy module is the only module in its batch that needs compiling.
- result — the size of the p = 19 data in this encoding (record § 3.2, § Stage 4).
  - It is 96.0 MB of text: PSD witnesses and R 51.3 MB, `orows` 23.3, `keys` 14.1, ops 5.1, rows 2.1. F2's K table
    adds 17.4 MB.
  - As one `def` it stops at the default 200,000 heartbeats after 3 min 14 s. With the limit lifted it elaborates in
    10 min 36 s at 1.51 GB.
- correction owed — F2's price is about 40–50 minutes of kernel CPU in 45–60 declarations, against the planner's 30
  (record § 3.4).
  - PSD alone is 15–20 min: a block measures 45–62 s, against the planner's 15–25 s.
  - Code: about 300 checker lines, 350 converter lines and 800–1,100 proof lines. On top of that, `cert3` and `cert11`
    have to be regenerated in the new form.
- correction owed — F2 changes `Cert` and `certOK`. So the p = 11 modules landed here have to be regenerated (one
  converter run and about 10 min of build) when F2 is wired in (record § 3.3).
- generalization — a PSD witness scale of 2^40 instead of 2^120 changes only the converter (record § 3.1, § Stage 4).
  - The converter's model finds all 22 blocks at p = 11 and all 38 at p = 19 still diagonally dominant.
  - The kernel accepted one such p = 19 block in 45 s against 62 s.
  - It halves the witness text (about −25 MB at p = 19).
- tool defect — `tools/fs131_ikc1_gen.py` (FS131-IKC1's tool; not edited here) writes `<out>.summary.json` next to its
  output, so inside `Proofs/` when the output is a library module.
  - The untracked `Proofs/HadwigerNelson/Arith/FibreCert3.lean.summary.json` comes from this.
  - I moved mine to `data/fs131/ikc3/gen/`.
- slip — my own: one waiter was armed on `==> build:`, which `build.sh` prints first, so it fired at once. I saw it
  immediately and acted on nothing (record § Stage 4).
- question for another lane — none. Search request — none: Searcher row 24, a smaller relaxation at 19, would spare F2
  and is already queued.

HELD FOR THE COORDINATOR:
- Whether about 110 MB of generated p = 19 text goes into git. Ways to reduce it:
  - the 2^40 witness: −25 MB, converter only;
  - denser slot keys: −13.6 MB, but this reopens `dec_bag`/`fKey_eq`;
  - splitting into per-block modules: no reduction, but parallel elaboration.
- F2's next step. The choice is between:
  - one implementer for (b)–(d), wiring them in and proving them (the design and prices are in record § 3.3–3.4,
    probes (b) and (c) are ready to move in, and `ktable_eq_of_chk` is written);
  - or waiting for Searcher row 24.
- The chained check modules: keep them as a pattern for heavy certificate modules, or give `build.sh` a per-module
  batch option.
- About 335 MB of regenerable, untracked probe data under `data/fs131/ikc3/` (`Cert19*.lean`, `KT*.lean`, `B1*.lean`).
  The sha256 manifest is committed in `generated-sha256.txt`. Keep or delete.
