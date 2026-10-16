# FS131-IQP1 — the p-adic plane in the kernel: the skeleton's leaves proved, the build and the gate

*de Bruijn, the kernel lane's implementer. Brief `data/fs131/briefs/FS131-IQP1-padic.md` (on `main`; a copy is
`data/fs131/iqp1/brief-copy.md`). Worktree `.claude/worktrees/il5`, branch `fs131-kpa1`, from `8f5f0e3fd`. The plan is
`plans/FS131-KPA1-padic-plan.md`. No fence. Started 2026-10-16.*

## Theorems this phase proved

None yet (stage 1 is the readback).

## Stage 1 — SAVED: the readback

### 1.1 The quotations

Five quotations in the brief, each checked mechanically against its named source with line breaks folded, by the
planner's checker run unchanged (`tools/fs131_kpa1_quotes.py data/fs131/iqp1/brief-copy.md --root .`, output
`data/fs131/iqp1/quotes.out`): **all five verbatim** — W2 in `data/fs131/REQUEST-2026-10-13.md`; inventory items 997 and
999 in `plans/FS131-close-inventory.md` (this worktree's copy, merged from `main` at `8f5f0e3fd`); the four head
statements and the six value statements in `Proofs/HadwigerNelson/PadicPlane/Values.lean`. The checker's planted control
(one character of the first quotation changed) is refused, exit 1 (`data/fs131/iqp1/quotes-plant.out`).

### 1.2 The targets

Every `sorry` of `PadicPlane/{Basic, Measure, Upper, Tower, Values}` (38 leaves, the plan's § 3.3), proved without a
change to any stored statement, with three exceptions the ruling of inventory item 999 (2) makes: the leaves at 23 that
need a certificate nobody has yet leave the landing's modules, their statements and plans kept below (§ 1.4). The head
statements are the four of the brief's § The statements (`le_borelChromaticNumber_of_charSum`,
`one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane`,
`not_exists_bound_borelChromaticNumber_padicPlane`) and the values at 3, 7, 11, 19, with `≤ 8` at 23. T0 goes by route A
(public pieces; no edit to `Rigidity/ClassRatio.lean`; ruling (1) of item 999). The certificate at 7 (leaf C7) is three
new modules `Arith/FibreCert7`, `FibreCert7Check`, `FibreCert7Bound`, generated from FS-66's `cert-p7.json` by the
library's generator, as the plan measured.

### 1.3 The order of work

The plan's (§ 3.3), with the price re-measured on the first two leaves of each kind: Tower T1–T3 (the number-field
bridge); Basic B1–B3; Tower T4, T5, T6, T0; Measure M1–M10; Upper U1–U3; the certificate C7; Values. A saved stage after
each module.

### 1.4 The leaves at 23

Item 999's ruling (2) names `six_le_borelChromaticNumber_padicPlane_twentyThree`. Two more skeleton statements rest on the
same missing certificate: `fibreShareBound_twentyThree` (C23 itself) and
`unitQuadrance_zmod_twentyThree_pow_not_colorable_five` (it needs `5·U/529 < 1`, so `U < 105.8`). Neither held bound
reaches them: Weil's ratio at 23 is `2√23/(24 + 2√23) = 0.2855…` and `5 · 0.2855 = 1.43 > 1`; the `κ` form at
`κ = −λ_min(Γ₂₃) ≈ 7.97` gives `5κ/(24 + κ) = 1.25 > 1`. Told to the coordinator by message at stage 1 (2026-10-16): the
three leave the landing's modules together, their statements kept here verbatim, and the held lower bound at 23 is
`4 ≤ χ_Bor(ℚ₂₃²)` (`le_borelChromaticNumber_padicPlane 23`: `⌈1 + 24/(2√23)⌉ = ⌈3.502…⌉ = 4`).

### 1.5 The stored statements before the first proof

`data/fs131/iqp1/lean/StatementDump.lean` — FS131-ICO1's dumper (read in that job's worktree, not written there) with
this job's five modules — run against the compiled skeleton before any rebuild (`lake build --no-build Proofs` first:
"All targets up-to-date", `data/fs131/iqp1/uptodate0.log`; no file of `Proofs/` differs between the planner's last
commit `621ccacc4` and `8f5f0e3fd`): `data/fs131/iqp1/statements-before.txt`, 65 constants (Basic 11, Measure 19,
Upper 5, Tower 9, Values 21). The gate compares the built modules' dump against it.

### 1.6 The coordinator's answer (inventory item 1002)

All three leaves at 23 leave the landing's modules, statements and plans kept here; `four_le_borelChromaticNumber_padicPlane_twentyThree`
is added beside `…_twentyThree_le_eight`; optionally `5 ≤` by the `κ` form if the character-sum bound at 23 is a cheap
finite check. **It is held already:** `CircleCos.circleCos_ge` (public, `Arith/CircleCos`, `check23` by `decide +kernel`)
bounds every non-trivial cosine sum over the circle of `𝔽₂₃²` below by `−κ'·24` with `κ' < 1/3`, so `κ = 24κ' < 8` and
`⌈1 + 24/κ⌉ ≥ 5`. What it costs is the translation from `AddChar (ZMod p × ZMod p) ℂ` to the cosines (about 50 lines);
decided at the Values stage, recorded there.
