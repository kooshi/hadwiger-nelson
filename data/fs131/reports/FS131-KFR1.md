JOB FS131-KFR1 — DONE   harness≈490k (own≈n/a)
RESULT: planned, one mind; nothing proved (a planning job). Built: `./scripts/build.sh` under the slot green — 5 modules rebuilt (the four new and the root), its only warnings `declaration uses 'sorry'` (the two `out-of-date` lines are the up-front `--no-build` check) (`data/fs131/kfr1/build.log`, `build-full.log`)
RESULT: head statement planned — `Collapse.finIndepRatio_planeOver_eq_localRatio`: α₁(F²) = max(m₁(ℝ²), ⨆_P r_P) at every real number field, with no MR hypothesis, no R = O′ and no total reality; MR's one use is discharged by `Rigidity.mrPlus` through `Collapse.not_isSPWitness` (record § 2.1).
RESULT: beside it — B-AMEN `finIndepRatio_planeOver_eq_iSup_density`; `fractionalChromaticNumber_planeOver_eq` (χ_f(F²) = 1/α_loc); the fractional collapse (α₁(F²) = m₁, χ_f(F²) = χ_f(ℝ²) at uniformly c-thick fields with c < 1/5, and at ℚ(√635087) and de Grey's field with no hypothesis); TJ's first clause; ROUND (1/k ≤ α_loc, 1/α_loc < 5 by the triangular packing m₁ ≥ π/(8√3)); TF; a finite triangle-free unit-distance graph with χ = 6; item 1005's splits (proved, no sorry) and the model at k = 7 (ℚ(√d₇), d₇ by CRT).
RESULT: price about 2,675 lines of Lean: D1 `Collapse/Density/Defs` 405, D2 `Collapse/Density/Upper` 1,370, D4 `Plane/TriangularPacking` 250, D3 `Collapse/Density/Headline` 650; 83 leaves, all `sorry` but the two splits.
RECORD: plans/FS131-KFR1-density-plan.md   COMMITS: 20a356c9f (stage 1), 33bbc83dd (stage 2), c2d2d8fb7 (stage 3), 0bcac0a96 (passes, build, report)
INVENTORY:
- generalization — row 129's field clause holds at every real number field, unconditionally in the kernel's terms (ramified stable primes need no case: r_P ≥ 1/2 ≥ α₁(F²)) — record § 1.3 (1), § 2.3; ruled by item 1008
- generalization — the fractional collapse: under the collapse's hypothesis α₁(F²) = m₁(ℝ²) and χ_f(F²) = χ_f(ℝ²); needs only m₁ > 1/6, which disc7's interior gives — record § 1.3 (2); ruled by item 1008
- result (what the kernel can reach, not a defect of the statement) — ROUND's "never gives six" is not reachable from the kernel's m₁ ≥ 1/7 or disc7's 0.1728; the triangular packing (π/(8√3) = 0.2267) is planned — record § 1.3 (3); ruled by item 1008
- result — every use of MR in FRAC, TJ, ROUND, TF is discharged by `Rigidity.mrPlus`; R-U is not needed (MR⁺ is stated at T + A) — record § 2.1
- result — the triangle-free six-chromatic finite unit-distance graph is in reach for about 150 lines (compactness, a minimal non-5-colourable subset, √3 ∉ ℚ(√635087) via ℚ(√635087) → ℚ₁₇) — record § 2.3, § 3.3
- question for another lane — prior art for "a finite triangle-free unit-distance graph with χ = 6" and for the fractional forms: not searched by this job — record § 2.3
- stub to mint or re-aim — a pattern-law refactor of `Collapse/` (one `PatternLaw F Λ N` for colourings and independent sets) would replace D2's copies; not adopted, since `Collapse/` is draft-only here — record § 3.7
- correction owed (to the implementer, not a statement) — a spec example `localRatio ⊥ = 2⁻¹` is owed in D1 — record § 3.7
- tool defect — none; `data/fs131/kfr1/quote_check.py` and `d7_crt.py` each with a planted control that fires
HELD FOR THE COORDINATOR:
- TJ's second clause (the per-class mixing selection's density loss) is not stated; add it (about 110 lines) only on your word — record § 3.5
- `ratioAtMost_of_charBound` (private, `Rigidity/ClassRatio`) is planned to be read by `open private`; making it public is an edit to an existing module, yours to rule — record § 3.5
- item 1005's two owed items are placed in the new `Collapse/Density/Headline`, not in `Collapse/Headline` (draft-only for this job) — record § 3.5
