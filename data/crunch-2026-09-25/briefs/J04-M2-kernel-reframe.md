*Brief for crunch job **J04**: the reframe and subplan of milestone M2, **the kernel lane**. It covers FS-45's chain theorem, FS-39's
bridge (route C in the kernel, and the Artin–Lang repair by hand) and FS-87's stripe lemma or FS-47's prime inversion. Opus 5.5,
2026-09-25. Written by the crunch planner (`plans/CRUNCH-2026-09-25-queue.md` §2). The reframe template is J03's brief; this brief
changes what is marked.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the kernel lane's planner**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. The house rules are `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`; read all three from disk, since the
copy loaded at your start may be stale. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.**
**`data/crunch-2026-09-25/briefs/J03-M1-reframe.md` is your template for how the reframe runs**: its sections "What you are doing" and
"What to produce" apply here except where this brief says otherwise. You may read it; its milestone is not yours.

## Why a kernel lane, and why now

The ban window produced 171 hand theorems and no Lean change (`plans/FS89-rational-band-rigidity.md` §R-close.9), so grade debt is itself
a product. Kernel work is allowed under the ban as long as it needs no solver run. One Lean build takes 60 GB of the machine's 100 GB,
so the lane is serial: one kernel job at a time, each after the last.

## The three targets, as the planner and advisor scoped them

1. **FS-45** (`plans/STUB-chain-theorem.md`, read in full):
   - **the chain theorem**: a finite graph over `F` forcing two points at difference `δ` equal at `k` colours, with
     `1/δ = u₁ + ⋯ + u_m` a sum of unit vectors, refuses `k` colours on `F²` (G55);
   - its **18-vertex, 33-edge ℚ(√2,√3) instance** by `decide +kernel`;
   - `five_le_chromaticNumber_planeOver (K(√7))` stated **conditionally on G₄**, the 588-core's 8/3 forcing, as a named hypothesis.

   The advisor's finding, verbatim: "G₄ (the 588-core's 8/3 refusal) is 'one cadical refusal … (no proof log on disk)'. Its D3 needs a
   fresh LRAT, and producing one means running a solver. That is banned until 2026-10-01." So the unconditional instance is post-ban.
   Mind the gate's vacuity rule for a conditional theorem: name its inhabitant, or declare it.
2. **FS-39** (`plans/STUB-plane-bridge.md`, read in full): **route C in the kernel**, `χ(F(t)²) = χ(F²)` for transcendental `t` by the
   place `t ↦ 0`, from `normOne_subset_valuationSubring` and `colorable_unitDistance_induce_of_valuationSubring` (G63; `[Fischer1990]` Thm
   6 is the prior art). **By hand only:** the repair of Fischer's Remark 1, that `χ(ℝ²) = sup_F χ(F²)` over real number fields, via real
   places (Artin–Lang), since Mathlib holds no real algebraic geometry. Its kernel form is not priced this crunch.
3. **FS-87's stripe lemma** (`plans/STUB-de-grey-chain-kernel.md`, target 1: V2-T5, "under NT₀ every proper four-colouring of the
   triangular lattice is striped"), **or FS-47's prime inversion** (`plans/STUB-unit-vector-ring-kernel.md`: `1/p ∈ ℤ[U]` iff no
   conjugation-stable prime lies above `p`), whichever your pricing puts inside one job. The advisor's view: FS-47 "is the ring the
   character results stand on; it is the better long-run investment than FS-87 if only one fits."

**The order** is J14 (FS-45), then J15 (FS-39 route C), then J16 (the third target). J17, the Artin–Lang hand step, is a derivation and
runs beside the lane, not in it.

## What changes from the template

- **§G:** one walk, a verdict column per target (three columns). The kernel method rules carry the most weight:
  - § The kernel's cost model;
  - § What compute actually helps: "re-price a kernel phase from its first two leaves, never from the plan's table";
  - § The gate;
  - G18, G21, G30 (5)–(7).
- **§PA** is mostly the Mathlib and core search for each statement to be ported (`exact?`, Loogle, and a grep of Mathlib and
  `$(lean --print-prefix)/src/lean/`), plus the existing modules this repository holds: `Proofs/HadwigerNelson/Copy.lean`,
  `Homogeneous.lean`, `OneDefect.lean`, the `Forcer` API, and the valuation-subring lemmas. A short prior-art gate on the Artin–Lang
  repair: is `χ(ℝ²) = sup` over number fields stated and proved anywhere since 1990? Use the zbMATH API.
- **§IQ** is for FS-39's hand step only.
- **The skeleton is the plan.** For each target, write the Lean statements with `sorry` at every leaf in a scratch module. Check that it
  elaborates with `scripts/slot.py --mem 16 --cpus 4 -- lake env lean <file>`, declaring the measured peak honestly. Then price the
  target from its first two leaves' obligations, never from a table.
  - Do not run `scripts/build.sh`. That is the kernel jobs'.
  - Do not create modules under `Proofs/`. The skeletons live in `data/m2/j04/` and are handed to J14–J16.

## What to produce

- **The plan, `plans/M2-kernel-lane.md`:** §G, §PA, §IQ (FS-39's hand step), §S (J14–J17, each with its skeleton path, its price from two
  leaves, its gate line, and its stop rule), §P, §M (fresh `debruijn-domain-modeling` and `debruijn-obligation-modeling`, and
  `debruijn-experience-modeling` for the lemma API), and §X.
- **The briefs for J14, J15, J16 and J17**, from the queue file's §4.1 skeleton. **Every kernel brief carries these lines verbatim:**
  - "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, never `lake build`; iterate with
    `scripts/slot.py --mem <measured> --cpus 4 -- lake env lean <file>` (it builds nothing, and does not apply the lakefile's options:
    `autoImplicit` is off only in the real build)."
  - "On a slot refusal (exit 75), wait ten minutes and retry; never raise a cap."
  - "The gate: the build green, zero `sorry`, `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported, an
    inhabitant per structure hypothesis, a spec example per definition."
  - "Prose in any module a certificate imports is written as `--` comments."
  - "You are the only kernel job running; the owner starts the next one when you report."
- **J17's blind check:** if the Artin–Lang step fits in about 2 hours, write J17 as a derivation plus a one-stage blind check by a
  second agent (J17V), with its fixed claim list written now.

## Stages

1. The quotation check, then §G's three columns (about 150k). Save.
2. §PA and the Mathlib search (about 60k). Save.
3. The skeletons and their two-leaf prices (about 80k). Save.
4. §S, §P, §M, and the briefs (about 50k). Save and report.

- **Paths:** `data/m2/j04/`.
- **Budget:** about 350k in the harness's count. Hand back by 420k.
- **Report:** standing rule 9. RESULT carries the counts, and each target's price from two leaves.
