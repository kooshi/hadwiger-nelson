# FS-101 — the local–global conjecture's main clause through five, in the kernel (stub)

*Minted 2026-09-26 by crunch job X29C (the close planner of the ×2×3 crunch's wave 3), at the owner's instruction, which relays Kooshi
verbatim: "The target for the Lean implementation should move to the more general "every real" claim." Solver column: **none** (a kernel
port of derived statements; no finite-witness search at any stage). Read first: `plans/FS100-K-kernel-47.md` (X11K's dependency map §1.3–§1.4,
its price table §Stage 5, and X11K2's re-aim §X11K2 Stage 1R), `plans/FS100-derivation.md` §4 (FS100-COR and its inputs), and the plan's
§R-close (stage 5, wave 3) 1.3–1.5 for the grade by field class.*

**The target** (FS100-COR; `LEDGER.md` row 123, drafted): for every real number field `F`, `min(L(F), 5) ≤ χ(F²)`; with the upper half,
`χ(F²) = L(F)` whenever `L(F) ≤ 5`; `χ(ℚ(√47)²) = 5` and `χ(ℚ(√3,√5)²) = 5` as corollaries.

**Status: first slot done (X11K3, 2026-09-26; `LEDGER.md` row 127; record `plans/FS100-K-kernel-47.md` §X11K3; report
`data/crunch-2026-09-26-x2x3/reports/X11K3.md`).** Route steps 1–2's gate and `posDef_corr` are done: `SpectralChain.min_localBound_five_le_chromaticNumber`
(`min(L(F), 5) ≤ χ(F²)`, every real number field) and `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain` are in `Proofs/`, standard
three axioms, conditional only on named hypotheses (`BochnerHerglotz`, `InvariantMeasureOnClosed`, and the chain's [hand] lemmas as named
propositions); `χ(ℚ(√47)²) ≤ 5` is unconditional; `posDef_corr` is proved; the skeleton is retired. L1 is now the named classical input
`InvariantMeasureOnClosed` (its repair, a countability hypothesis proved over number fields, is in the kernel record only — owner's ruling).
**Next:** `InvariantMeasureOnClosed` as Markov–Kakutani (~100–200k), then the upper half `hUpper` via row 57's gap (~40–80k), then
Herglotz–Bochner (weeks); step 4 below stands.

**Where it stands at minting** (X11K2's report, `data/crunch-2026-09-26-x2x3/reports/X11K2.md`; record `plans/FS100-K-kernel-47.md` §X11K2):
- `χ(ℚ(√47)²) ≤ 5` is **unconditional and sorry-free** in the skeleton (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`, an elementary
  11-adic descent, no valuation subring; standard three axioms), **not yet gated into `Proofs/`** — X11K3 was gating it at minting.
- The headline `X11K.min_localBound_five_le_chromaticNumber` is **stated** with `L(F)` through Mathlib's number-field API (`fieldI F`,
  `StablePrime F`, `levelTarget P m`, `localBound F`, `TCA F`; `data/fs100/x11k/skeleton/Sqrt47.lean` Part G) and **its composition proved over
  named inputs**: Herglotz–Bochner (`hBH`), the count split by whether `F` is totally real (`hTR`, `hCX` — the complex place by FS100-CX), A⁺ from
  R88-TCA (`hAP`), R-U (`hRU`), MR in the class (`hMR`), CLS's ⟸ (`hCLS`), row 99 (`hRow99`); the staging form `..._of_totallyReal`; the equality
  form with `hUpper` named. Two `sorry` leaves remain (L1, `posDef_corr`).
- **Caveat carried from X11K2:** `levelTarget` uses the norm-one elements of `𝓞/P^m`; the derivation's `S_m` is the image of `U`. They agree by
  smoothness of the norm-one torus — [hand], not in the kernel.

**The route, leaf-first** (X11K's and X11K2's prices, re-price from the first two leaves, `CLAUDE.md` § What compute actually helps):
1. **The gate:** move `SqrtFortySeven` and the sorry-free Part L/G declarations into `Proofs/` (one build under `scripts/build.sh`, ~25k).
2. `posDef_corr` (~10–15k); then L1, `exists_invariantColouring` (Markov–Kakutani twice, not in Mathlib; ~100–200k).
3. **The upper half** `hUpper`: row 52's residue bound through the stable prime's valuation subring — exactly row 57's "Not proved" clause (the
   number-field supply of the valuation subring), a formalization gap and not a mathematical one (~40–80k).
4. **Which inputs to build and which to keep as interfaces** — Kooshi's call: R-U, A⁺, N1/N2 (months: the adelic dual), R88-TCA (row 112's inputs),
   CLS's finite parts (the Hoffman table, Weil's threshold, the `q`-list), and MR, whose inputs (Kolmogorov–Sinai entropy, SMB, EL2021 Thm 1.2) are
   formalization projects of their own.
5. The corollaries: `NumberField` for ℚ(√47) (~5k) and `5 ≤ localBound` there (CTL at ℚ(√47): every stable prime of `𝓞(ℚ(√47, i))` and its
   target — weeks); the same for ℚ(√3,√5).

**Bearing on χ ≥ 6:** none. It puts the conjecture's proved range (G48) on the kernel's word, one named interface at a time.

**Provisional bearings** (WORKFLOW 3.1 item 5): G48 (the proved range is the target), G55 (the chain theorem's ring form, row 103, a kernel
precedent), G63 (the valuation-subring lemma's two instances), G64 (row 57's gap is the kernel's), G54 and G56 (CLS's table), G67, G72 (a kernel
port has no §IQ), § What compute actually helps (grep Mathlib by the statement's shape at the skeleton; M2's and FS-75's re-price rule).
