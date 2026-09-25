# FS-91 stage 0 — blind verification of PA-B2 and PA-B3 (band rigidity from four/five colours to nine)

*Crunch job J01 (2026-09-25), de Bruijn, Opus 5.5, as a **blind verifier**. Brief:
`data/crunch-2026-09-25/briefs/J01-band-to-nine-verifier.md` with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. This record is
the job's only output besides `tools/crunch_j01_*.py` and `data/fs91/j01/`. Objects are FS-89's §0.1
(`plans/FS89-rational-band-rigidity.md`): `R_S = ℤ[i][1/p : p ∈ S]`, `U_S = ⟨i⟩ × ⟨w_p⟩`, `B_k = [1/k, 1 − 1/k]`,
`Θ_k(R_S) = {θ ∈ R̂_S : θ(U_S) ⊆ B_k}`, `A = {λ_e : x ↦ Re(ē x)}`, `T` = torsion characters, `Q = R_all`.*

**Fence kept until the verdicts are committed** (brief, "What you must not open"): `plans/FS89-PA-berend1984.md` §5 and §9;
`plans/FS89-derivation.md` §10 and the proof lines of its PA-B2/PA-B3 entries; `plans/STUB-band-rigidity-six.md`;
`plans/FRONTIER-STUBS.md` row 2; `plans/FS89-close-inventory.md` items 41 and 47; `plans/POROS-2026-09-25-crunch-plan.md`; every other
crunch brief and record. (The loaded `CLAUDE.md` carries FS-91's one-line § Paths-forward row — "Lemma SW and VB1 re-read there; the
parity line lands in `Θ₃`, which is rigid" — which I could not avoid seeing; it is logged here as a contamination, one line, naming
which steps to re-read but not their proofs.)

## Stage 1 — SAVED

### C0. The brief's quotations, checked against their sources (standing rule 5)

Checked with `grep -noF` printing only the matched string, so the fenced text around each match was not read.

| # | quotation in the brief | where it actually is, verbatim | verdict |
|---|---|---|---|
| Q1 | PA-B2: "for every finite `S` with `|S| ≥ 2`, every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A` (D1-L2, D1-L3, Berend Thm I.2 + Prop. II.6)", attributed to "`plans/FS89-derivation.md`, its entry's statement" | the statement through "lies in `T + A`" is verbatim at `plans/FS89-derivation.md:343`; **the parenthesis is not there** (that line continues "(case 2 by D1-L2; case 1 gives …", i.e. its proof). The whole quotation, parenthesis included, is verbatim at `plans/FS89-PA-berend1984.md:373` (the reader's "Theorems this phase proved" table). | **statement verbatim; address slip** (the parenthesis's source is the Berend reader's table, not the derivation file). Harmless: the brief says the parenthesis names inputs, not the statement. |
| Q2 | "So `MS_k(S)` holds at every band `k`." | `plans/FS89-derivation.md:343` has "So `MS_k(S)` holds at every band `k`, a…"; `plans/FS89-PA-berend1984.md:270` has "So `MS_k(S)` holds at every band `k` an…". | **truncated**: the brief ends the sentence with a period where both sources continue it. The continuation is fenced and was not read; whether it narrows the claim is checked in stage 4. I verify the words as quoted. |
| Q3 | PA-B3: "(candidate) `RS_k(S)` for `k < 2·min S`, `|S| ≥ 2`; `RQ_k` for `k ≤ 9` (PA-B2 with VB1–VB4)", attributed to "`plans/FS89-derivation.md`, its table row" | verbatim at `plans/FS89-PA-berend1984.md:374`; `grep -F '\`RQ_k\` for \`k ≤ 9\`'` finds **nothing** in `plans/FS89-derivation.md` (its PA-B3 lives in the fenced §10 as "the close planner's reading", line 358, in other words). | **verbatim; address slip** (the row is the Berend reader's, not the derivation file's). |
| Q4 | "at `S = {5, 13}`, **`RQ_k` for every `k ≤ 9`** (and `RS₅(S)` without `5 ∈ S`)" | verbatim across `plans/FS89-PA-berend1984.md:274–275` (line 274 ends "… VB3–VB4 carry it to `Q`: at", line 275 begins "`S = {5, 13}`, **`RQ_k` …"), in the fenced §5. | **verbatim** (spans a line break). |
| Q5 | FS-89 objects and statements `RS_k`, `MS_k`, `RQ_k` (brief: "The objects are FS-89's §0.1") | `plans/FS89-rational-band-rigidity.md` §0.1–§0.2, read in full. | consistent. Note: §0.2 defines `RS_k(S)` as "`Θ_k(R_S) ⊆ T + A`" with "`T` of any order prime to `S`", and `MS_k(S)` as "every `U_S`-minimal closed subset of `Θ_k(R_S)` lies in `T + A`". |
| Q6 | Ledger row 95's summary as the brief gives it ("at four and five colours every band character of `Q` … is a torsion character plus an archimedean one") | `LEDGER.md:118` (row 95). | consistent. Row 95's own "Not claimed" includes "bands narrower than 1/5 (the route's band steps are Lemma SW and the parity line; six is unchecked, …)". |

### C1. Priors, before any derivation (registered; scored in stage 4)

The route I expect, from row 95 only: Berend's dichotomy at `|S| ≥ 2` (archimedean-small differences ⇒ meets `T + A`, D1-L2; else
`M − M` everything, D1-L3); a band step turning "`M − M` everything" into a contradiction or a corner; a point step (VB1) pinning an orbit
closure that meets `T + A`; layering to `Q` (D2-L1, VB3, VB4). The `k`-dependence I expect to find: the band steps (Lemma SW's sweep,
the parity/corner line), possibly the point step if it isolates leaves by margins.

| claim | prior TRUE | prior GAP | prior FALSE | reason |
|---|---|---|---|---|
| PA-B2 (minimal sets, band-free, `|S| ≥ 2`) | 0.55 | 0.30 | 0.15 | Berend-type conclusions usually need every direction expanded; the rotated archimedean plane is exactly what his theorems exempt, so the transfer of Thm I.2 + Prop. II.6 is where a gap would sit. A FALSE needs a non-`T + A` minimal set, e.g. a minimal set whose archimedean part is not a union of circles — I know none. |
| "So `MS_k(S)` at every band `k`" | 0.55 | 0.30 | 0.15 | follows from PA-B2 at once (a band set is a proper closed invariant set, `0 ∉ Θ_k`); stands or falls with PA-B2. |
| `RS_k({5,13})` / `RQ_k`, `k = 6` | 0.45 | 0.40 | 0.15 | the step from minimal sets to points is where one prime failed (row 97); `k = 6` is the first band where the parity line leaves the four-colour picture. |
| `k = 7` | 0.40 | 0.42 | 0.18 | |
| `k = 8` | 0.38 | 0.42 | 0.20 | |
| `k = 9` | 0.35 | 0.43 | 0.22 | `k < 2·5` is exactly the edge of a sweep of step `1/5` against an excluded arc of width `2/k`; an edge case is where an off-by-one lives. |
| layering/gluing (VB3, VB4, D2-L1) `k`-free | 0.75 | — | 0.25 (uses `k`) | the gluing reads torsion orders and weak approximation; a margin could enter through the order bound. |

## Would-have-searched-here log

| stage | move a search would have made | what I did instead |
|---|---|---|
| 1 | — | — |

## Theorems this phase proved

*(filled as stages land)*
