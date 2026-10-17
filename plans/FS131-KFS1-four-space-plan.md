# FS131-KFS1 — rational four-space at four colours (C7), and `χ_f` of the plane over ℚ(√3, √11) (C14): the map, the skeleton and the price

*de Bruijn, the planner (Opus), 2026-10-17. Brief: `data/fs131/briefs/FS131-KFS1-four-space.md` (on `main`, commit 24d9c671d).
Worktree `.claude/worktrees/il5`, branch `fs131-kfs1`, cut from `main` at `ac47c67b0`. Nothing in this milestone is fenced
(brief, `fences: none`); I read the derivations (LV, LX) in stage 1. Working files: `data/fs131/kfs1/`.*

## Theorems this phase proved

None. This is a planning job: every statement below is a skeleton with `sorry`, or a plan. Prices are "planned, one mind;
nothing held".

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, checked against their sources

`data/fs131/kfs1/quote_check.py` takes every block quotation of the brief (a run of `>` lines closed by `— source: <path>`),
collapses whitespace and nested `>` prefixes on both sides, and requires the quote's text to occur in the source. Result
(`data/fs131/kfs1/quote_check.out`): **6 quotes, 6 FOUND, exit 0** — W2 (`data/fs131/REQUEST-2026-10-13.md`), item 1073
(`plans/FS131-close-inventory.md`), ranks 7 and 9 (`plans/POROS-2026-10-13-number-field-findings.md` § 3.3), the ℚ⁴ entry and
§ 1.6 (`CLOSED-QUESTIONS.md`). Planted control: one character changed in the first quote (`formalize` → `formalise`) reads
MISSING and exit 1 (`quote_check_plant.out`). The tool's first version missed the nested quote of § 1.6 (`> > …`); the miss was
the tool's, fixed by stripping repeated `>` prefixes, not a mismatch in the brief.

The brief's one unquoted claim checked by the kernel: `Collapse.fractionalChromaticNumber_planeOver_eq` rests on the standard three
and `Rigidity.positive_entropy_rigidity` (`#print axioms`, `data/fs131/kfs1/probes/AxiomsB.out`) — as the brief says.

**Mismatches: none in the brief.** Two observations about the sources, logged as findings below (1.4).

### 1.2 Part A, restated

Notation: read `ℚ⁴` as the rational quaternions `ℍ[ℚ]`, `N(x) = x₀² + x₁² + x₂² + x₃²`, so the squared Euclidean distance of
`x, y` is `N(x − y)`; `w(x) = v₂(N(x))`, the 2-adic valuation of the rational `N(x)`. A *proper four-colouring* is a map
`ℚ⁴ → {4 colours}` that differs on every pair at distance 1. A colouring *forbids* `d` if it differs on every pair at distance `d`.

- **A1, the compulsion law** (LV-T3 = LX-T5). For `x ≠ y` in `ℚ⁴`: every proper four-colouring gives `x, y` one colour iff
  `w(x − y) ≥ 1`; every one gives them different colours iff `w(x − y) = 0`; neither is forced iff `w(x − y) < 0`.
- **A2, the answer to `[Johnson2006]` p. 212** (LX-T6). For `d > 0`: a proper four-colouring of `ℚ⁴` forbidding `d` exists iff
  `d² ∉ ℚ`, or `d² = p/q` with `p, q` odd positive integers. When `d² = p/q` with `p, q` odd, **every** proper four-colouring
  forbids `d`. (For `d² ∉ ℚ` no pair of `ℚ⁴` is at distance `d` — LX's scope repair; for `d² ∈ ℚ>0` every `d` is realized,
  by Lagrange.)
- **A3, the structure** (LX-T5's restatement). Every proper four-colouring is, on each component `x₀ + R`, the residue map
  `R → R/P ≅ 𝔽₄` followed by a bijection to the colours, where `R = {w ≥ 0} = H ⊗ ℤ₍₂₎` (`H` the Hurwitz order) and
  `P = {w ≥ 1} = (1 + i)R`.

**What each rests on.** A1–A3: two derivations, LV (stage 3, one mind) and LX (stage 1, blind to LV), agreeing; the inputs are
Zaks's Lemma 1 (`[Zaks1999]` p. 92: pairs at `√2` forced equal), which LX replaces by its own five-point gadget L4, and the
description of the component of the origin (`[BendaPerles2000]` pp. 123–125: their `H⁴`, odd-denominator `D` of index 2), which
LX replaces by its own L1–L3 (the valuation `w`, `|R/P| = 4`, and `⟨S⟩ = R` by the ring route: `1/p` from the trace of the unit
`q²/p`, `N(q) = p`). The *if* half of A2 is `[Johnson1990]` Thm 3. **Nothing of A is in the kernel; no ledger row.**

**What the library holds for Part A:** nothing specific. No module mentions quaternions (`grep -rl "Quaternion\|ℍ\[" Proofs/` is
empty); the library's `UnitDistance.unitDistance V` (adjacency `dist x y = 1` on a metric space) and Mathlib's
`SimpleGraph.Coloring` are the vocabulary. Theorem B's residue colouring (`FieldWall4`) is the plane analogue (𝔽₄ at a prime of
`K(i)` above 2), not reusable here: its ring is `ℤ[√3, √11, i]`, not a quaternion order.

### 1.3 Part B, restated

- **B1** (C14). `χ_f(K²) = 4` for `K = ℚ(√3, √11)`, the plane over `K` with unit distance.
- **B2** (§ 1.6's parenthesis). Every finite unit-distance graph over `K` has independence ratio at least `1/4`, and ratios
  arbitrarily close to `1/4` occur; equivalently `α₁(K²) = 1/4` and `sup_{finite S} χ_f(K²[S]) = 4`.

**What it rests on (the hand route, `plans/FS56-field-blowup.md`).** Upper: Theorem B, `χ(K²) = 4` (`[Fischer1994]`'s value,
kernel-checked: `HadwigerNelson.chromaticNumber_seamPlane`). Lower: `[MatolcsiEtAl2025]`'s `G27` (27 points of `K²`) with its
geometric fractional bound `χ_gf(G27) ≥ 4` (their Thm 3; their rational witness re-checked here by `tools/fs56_gf_check.py`:
level 12, 28,496 weighted sets, 11,640 congruence classes, 182,304 independent sets; `data/fs56/g27/check-g27.log`), and their
blow-up (their Thm 1) read inside `K` (FS56 B1–B2: Følner sets of the solvable isometry group of `K²`). At the Moser ring the
instance `χ_gf = 4` is `[Ducz2026]` Thm 3.1 with `G27` (`plans/FS131-PAS1-prior-art.md`).

**What the library holds for Part B** (each by `#print axioms`, `data/fs131/kfs1/probes/AxiomsB.out`):
- `chromaticNumber_seamPlane : ((unitDistance ℂ).induce seamPlane).chromaticNumber = 4` (`FieldWall4`), and
  `planeOver_seamField : planeOver seamField = seamPlane := rfl` (`SquareClass`).
- `Collapse.exists_indepLaw [NumberField F] : ∃ μ : IndepLaw F, (cayR F).finIndepRatio ≤ μ.density` — **standard three
  axioms** (B-AMEN's amenability half: no Einsiedler–Lindenstrauss).
- `Collapse.finIndepRatio_planeOver_le_cayR`, `SimpleGraph.inv_finIndepRatio_le_iSup_fractionalChromaticNumber` — standard
  three.
- `Collapse.fractionalChromaticNumber_planeOver_eq : χ_f(F²) = (localRatio F)⁻¹` — standard three **and E–L**.
- `Plane/DensityBound/X23Check`, `X23`: a core-only checker and its soundness for `[AmbrusEtAl2023]`'s 23-point congruence
  certificate over `ℤ[√3, √11]` (FS131-IDB3) — hard-wired to 23 points, but the pattern for `G27`'s.
- **No `NumberField ↥seamField` instance** (`grep` finds none): owed for any route through `IndepLaw`.

### 1.4 Findings from the readback

1. **(shorter route, Part B — a finding for the coordinator, not urgent.)** `χ_f(K²) ≥ 4` needs neither the blow-up nor E–L: an
   invariant random independent set `μ : IndepLaw K` exists with `α₁ ≤ μ.density` on the standard three
   (`exists_indepLaw`), and `G27`'s certificate bounds `μ.density ≤ 1/4` directly — `P(Y ⊆ I)` is constant on congruence classes
   by invariance, and the certificate's identity is an expectation. So the route through the density form
   (`fractionalChromaticNumber_planeOver_eq`, which would also need every stable prime's ratio bounded by `1/4`, each by the same
   certificate) is dominated: more trust (E–L) and more work. Stage 2 maps it.
2. **(source wording, no defect.)** `CLOSED-QUESTIONS.md`'s ℚ⁴ entry and Poros's rank 7 state the theorem for `d² ∈ ℚ`; LX's table
   shows the literal "for which `d > 0`" answer adds `d² ∉ ℚ` (vacuous). The head statement below states the unconditional
   answer, with the realized form beside it — no correction owed, since both sources carry the scope.
