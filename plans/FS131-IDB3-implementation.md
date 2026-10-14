# FS131-IDB3 — the density bound's third implementer: lane X, `[AmbrusEtAl2023]`'s certificate as a Lean instance, and `Plane.OneAvoidingDensityBound` proved

*de Bruijn, the implementer (Opus 5.5), 2026-10-14. Brief: `data/fs131/briefs/FS131-IDB3-x23-theorem.md` (on `main`), with
`plans/STANDING-RULES.md`. Branch `fs131-wdb3`, cut from `fs131-wdb2` at `3e70e00e8`; tree `.claude/worktrees/fs131-w10g`. The
design is `plans/FS131-IDB2-implementation.md` § 5.2; the plan `plans/FS131-KDB1-density-bound.md` (§ 3.3's typed block, § 4.2).
Resuming: read this file, check its last SAVED stage against `git log -- plans/FS131-IDB3-implementation.md`, continue at the first
stage not SAVED. Working files: `data/fs131/idb3/`.*

## Theorems this phase proved

(Filled at stage 3.)

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, against their sources (standing rule 3)

`data/fs131/idb3/quotes_check.py` searches every `> ` line of the brief verbatim in the file its `— source:` line names (on
`main`), and the inline W6; a control with one letter changed (`formalized` → `formalised`) is not found.

| # | the brief quotes | source | verdict |
|---|---|---|---|
| Q1 | W2 (2026-10-13) "I choose the second form. Any finding of ours must be formalized. …" | `data/fs131/REQUEST-2026-10-13.md` | verbatim |
| Q2 | dated line 2026-10-14 "The density bound has a route with no periodic reduction and no Bessel citation" | `data/fs131/claims-NF2.md` | verbatim |
| Q3 | dated line 2026-10-14 "The certificate's analytic half is priced in the kernel" | `data/fs131/claims-NF2.md` | verbatim |
| Q4 | item 845 (FS131-KDB1 handed back) | `plans/FS131-close-inventory.md` | verbatim |
| Q5 | item 866 (FS131-IDB1 handed back) | `plans/FS131-close-inventory.md` | verbatim |
| Q6 | item 895 (FS131-IDB2 handed back at stage 5) | `plans/FS131-close-inventory.md` | verbatim |
| Q7 | "Yes, prove the density bound." (W6, inline) | `data/fs131/REQUEST-2026-10-13.md` | verbatim (one occurrence) |

No mismatch. The statement of `BesselCert.Cells.phiApprox_ge` that item 866 quotes in words is read from the module itself
(`Plane/DensityBound/Cells/Covering.lean`): `∀ d : List ℝ, Close P23.Ds d → ∀ t : ℝ, 0 ≤ t → (P23.TN : ℝ) / P23.TD ≤
P23.w1N / P23.WS + jsum P23.Ws d t / P23.WS`, with `Close Ds d := List.Forall₂ (fun D x => |x − D/S| ≤ 1/S ∧ 0 ≤ x) Ds d`,
`S = 2⁶⁴` (`BesselCert`, `BesselCheck`).

### 1.2 The certificate files, checksummed (read only)

| file | sha256 |
|---|---|
| `data/pa-ambrus2023/g23.csv` (2,350 rows: `w_0`, `w_T`, `w_1` ×1, `w_2` ×26, `w_C` ×2,321) | `cbfe22f5028f23a84f17d97802a93517e702eea0181d692ad7f5477763cf7274` |
| `data/pa-ambrus2023/verification23.nb` (the notebook; its `X = {…}` cell is the point list) | `7d230f20d41a2a3355bee78241c9d626134548c18eeec4de8a1d1217a74cecec` |
| `data/pa-ambrus2023/verification23.pdf` | `cab617df632c675c6239080350d9eceaef0bd8ce07e1a9cbd612c52743c0af11` |
| the paper, `~/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf` (v3) | `12850eb7d4ddc3f909799422d46f18e790730efb8003a35f9a66fd347aff315b` |

The generator records these checksums in its output and refuses to run on a file whose checksum differs.

### 1.3 The paper's eq. (22) and Theorem 1, restated from the last implementer's reading (`FS131-IDB2-implementation.md` § Stage 4)

Re-read by me this job from the held v3 (`pdftotext -layout`): p. 17 (eq. (22)), p. 18 (`µ`), p. 19 (the final bound), p. 23
(Table 1, read as a rendered image) and p. 24 (Table 2). Theorem 1 (p. 4): "Any Lebesgue measurable, 1-avoiding planar set has
upper density at most 0.2470." — `Plane.OneAvoidingDensityBound`, read aloud by the planner (FS131-KDB1 § 1.3); unchanged.

| the paper | the library, and what this lane fixes |
|---|---|
| `ϕ(t) = w0 J0(t) + Σ_{i∈[n]} w1(i) + Σ_{{i,j}} w2(i, j) J0(t|xi − xj|)`, "with xi being defined by Table 1 and the non-zero coefficients w specified by Table 2" (eq. (22), p. 17) | `DualCert.phi w0 t = w0 * J0 t + ∑ i, C.w1 i + (C.w2.map fun e => e.2.2 * J0 (t * ‖C.X e.1 - C.X e.2.1‖)).sum`; this lane's `X23.w2` lists the 26 `w_2` rows in `g23.csv`'s order, which is `P23`'s term order 1–26 (`Cells/Data`'s docstring), so `X23_phi` reads `phiApprox_ge` with no permutation |
| Table 1, `x1 … x23` (p. 23) | `X23.X i = (ev Pᵢ.re + ev Pᵢ.im · i)/12`, `Pᵢ = 12 xᵢ` with integer coordinates in the basis `1, √3, √11, √33`; the generator compares the notebook's list with my transcription of Table 1 (point by point, exactly) and the kernel reads only the notebook's |
| Table 2: `w0`, `wT`, `w1(1)`, the 26 `w2(i, j)` (p. 24) | the generator compares each with `g23.csv`'s row exactly (as decimals) |
| `µ = 0.00006` (p. 18) | `X23_phi : ∀ t, 0 ≤ t → 1 − 6/10⁵ ≤ X23.phi X23w0 t` |
| `ν = 10⁻⁵`, "changing wT to w̃T = wT + ν" (p. 16) | `X23.bound = wT + 10⁻⁵` (item 895's ruling 1: the paper's value, not the planner's typed `10⁻⁶`) |
| "m1(R²) ⩽ (wT + ν)/(1 − µ) = 0.24699 … < 0.2470" (p. 19) | `X23_ratio : X23.bound / (1 − 6/10⁵) ≤ 0.2470` |
| `C(X)`, `wc(I, J)`, "X\|J = ϕ(τ(X\|I))" (p. 9) | `X23.wc` from the 2,321 `w_C` rows, `I`, `J` as `Finset (Fin 23)` (indices shifted to 0-based); `Valid.cong` by an explicit isometry per row with the row's own order as the correspondence (FS131-IDB2 § 4.1 found all 2,321 so) |
| `V(ε) ≥ −ν` on every independent atom (eq. (20), p. 16) | `Valid.atoms : S.Nonempty → IsIndep S → L S ≤ bound` |

### 1.4 Lane X's parts, beside the design (FS131-IDB2 § 5.2)

| part (module) | what it holds | the design | change |
|---|---|---|---|
| `Plane/DensityBound/X23Check` (core, no import) | exact arithmetic in `ℤ⁴` (`a + b√3 + c√11 + d√33`) and its complex pairs; the edge check on adjacency masks; the congruence check per `w_C` row (`b`, `U`, `m`, `V` with `|U|² = m²` and `U·(b ? P̄ : P)ₖ + V = m·P_{Jₖ}`, `u = U/m`, `v = V/(12m)`); the packed terms (`mask + 2²³·(c + 2⁶⁸)`), their grouping by highest vertex; the DFS `dfsG` with a leaf predicate and its list-valued twin `collect`; the distance enclosure check | the same | the DFS is cut at a depth `k` by a literal frontier of states checked equal to `collect`'s output, then chunk by chunk (one soundness lemma, `collect`'s, serves both halves) |
| `Plane/DensityBound/X23Data` (+ `X23Cong*`, `X23Atoms*`, generated by `tools/fs131_kdb1_x23.py`) | the points, the tables, the witnesses, adjacency, groups, frontier; one `decide +kernel` theorem per part | the same | the congruence and atom parts in several modules, so the build runs them in parallel |
| `Plane/DensityBound/X23` (Mathlib) | `X23 : DualCert 23`, `X23w0`; the soundness lemmas; `X23_valid` | the same | — |
| `Plane/DensityBound/X23Dist` | `Close P23.Ds (1 :: X23.w2.map (‖X i − X j‖))` | the same | — |
| `Plane/DensityBound/Theorem` | `X23_phi`, `X23_ratio`, `HadwigerNelson.Plane.oneAvoidingDensityBound` | the same | — |

The statements are the planner's typed block (FS131-KDB1 § 3.3) with `bound = w_T + 10⁻⁵`: `X23_valid : X23.Valid`;
`X23_phi : ∀ t : ℝ, 0 ≤ t → 1 - 6 / 10 ^ 5 ≤ X23.phi X23w0 t`; `X23_ratio : X23.bound / (1 - 6 / 10 ^ 5) ≤ 0.2470`;
`Plane.oneAvoidingDensityBound : Plane.OneAvoidingDensityBound`. No existing statement or definition is touched.

## Stage 2 — SAVED: the checker, its soundness, and the planted faults

### 2.1 What was built (all new files; no existing module touched)

| file | lines | what |
|---|---|---|
| `Proofs/HadwigerNelson/Plane/DensityBound/X23Check.lean` (core, no import) | 330 | the checker (§ 1.4), 12 spec examples by `decide` |
| `tools/fs131_kdb1_x23.py` | 560 | the generator: checksums, read-backs (Table 1 transcribed in `data/fs131/idb3/paper-table1.txt`, Table 2's text in `paper-table2.txt`, `P23`), the integer data, an exact Python mirror of every check, the modules |
| `Proofs/HadwigerNelson/Plane/DensityBound/X23Data.lean`, `X23Cong00`–`07`, `X23Atoms00`–`12`, `X23All` (generated, core) | — | the data and 8 + 103 + 8 `decide +kernel` theorems, assembled in `X23All` (`wcR_ok`, `frL_ok`) |
| `Proofs/HadwigerNelson/Plane/DensityBound/X23.lean` (Mathlib) | 790 | the semantics and `X23_valid` |
| `Proofs/HadwigerNelson/Plane/DensityBound/X23Dist.lean`, `Theorem.lean` | 60, 85 | `X23_close`, `X23_phi`, `X23_ratio`, `Plane.oneAvoidingDensityBound` |

**Deviations from the design, and one finding.** (i) The scale is `10²¹`, not `10²⁰`: one `w_C` row of `g23.csv`,
`5.4369049825320215e-05`, has 21 decimals, and is not an integer at `10²⁰` — the planner's prototype `proto_atoms.py` read
it with `int(v * WS)`, truncating it silently (its assertion `Fr(c, WS) * WS == c` is true of every integer). The kernel
check here is exact at `10²¹`; `phiApprox_ge`'s weights (`w₀`, `w₂` at `10²⁰`) are exact and are matched to `X23`'s by
`w₂·10²¹ = 10·Ws` (checked by `decide +kernel` in `X23_phi`). The truncation moved one coefficient by `< 10⁻²⁰` and changes
no verdict (min V is reproduced here, exactly, at `10²¹`: `−6.712244·10⁻⁸`). (ii) The DFS is cut at depth 15 (the design
said "a prefix enumeration"): 492 frontier states, 7,123,866 mask tests below them in 103 chunks of ≤ 80,000; the prefix
itself is checked by `frontier_eq` (the DFS's own frontier, packed, equals the literal) and `frontier_rt` (packing
round-trips). (iii) The atom DFS's term groups are computed by the kernel from the coefficient tables (`groups_eq`,
`one_group`), so the terms `L(S)` sums can be no other than the certificate's; the semantics is one induction
(`collect_sound`) used once, through `dfsG_append` and `dfsG_eq_all`.

### 2.2 Read-backs and the exact mirror (`python3 tools/fs131_kdb1_x23.py --plan`)

Table 1 (23 points, transcribed from the rendered p. 23) equals the notebook's list exactly, point by point; Table 2 (`w₀`,
`w_T`, `w₁(1)`, the 26 `w₂(i, j)`, from p. 24's text) equals `g23.csv`'s rows exactly; `P23.Ws` is `w₀` then the 26 `w₂` in
`g23.csv`'s order and `P23.w1N = w₁(1)·10²⁰`. Mirror: 47 edges; 2,321 rows, an isometry for each (`m ≤ 444`); 4,669 terms;
13,552 independent sets reached, `max L = w_T + 6.712244·10⁻⁸`, so min `V = −6.712244·10⁻⁸ ≥ −ν` (J26's number);
26 distances pass with `K = 2¹²⁸`.

### 2.3 The kernel on the first parts (farm, `data/fs131/idb3/farm.sh`; each under the slot)

| module | time | peak RSS |
|---|---|---|
| `X23Check` | 0.8 s | 0.52 GB |
| `X23Data` (the 8 small checks) | 74–78 s | 3.13–3.16 GB |
| `X23Cong00` (300 rows) | 8.0 s | 1.64 GB |
| `X23Atoms00` (8 chunks, 598 k tests) | 90.7 s | 2.40 GB |
| `X23`, `X23Dist`, `Theorem` (against a farm stub of `X23All` whose two theorems are `sorry`) | 10.9 s, 1.8 s, 2.1 s | 3.3 GB |

A module of eight ≤ 80 k-test theorems peaks at one theorem's memory (item 845's question, answered again).

### 2.4 Planted faults, each refused by the kernel (`data/fs131/idb3/plants/Plants.lean`, log `plants.log`)

| plant | the kernel | partner (unplanted) |
|---|---|---|
| a wrong distance: `w₂` distance 6 moved by `2·2⁻⁶⁴` | "`decide` proved that the proposition `distsOk … = true` is false" | `distsOk ptsL enclL P23.Ds.tail w2T = true` passes |
| a missing congruence: row 115 (`{2,6,8} ↦ {3,8,6}`, 1-based) with `J`'s last point moved, claiming `{2,6,8} ≅ {3,8,1}` (different side lengths) | `rowOk ptsL badRow = true` is false | the row itself passes |
| an atom with `V < 0`: bound lowered to `w_T + 6·10⁻⁸` | chunk 26's check is false | at `w_T + 7·10⁻⁸` chunk 26 passes: the check is tight at the true min V |
| a changed `w₁` against the groups | `groups_eq` with `w1N + 1` is false | `groups_eq` passes |
| the frontier with one state dropped | `frontier_eq` with `frL.tail` is false | `frontier_eq` passes |
