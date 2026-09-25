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

## Stage 2 — SAVED (PA-B2, derived from its statement)

**Read for this stage** (brief §"Read first"): `LEDGER.md` rows 95–97; plan §0.1–§0.3; `plans/FS89-S1VB-verification.md` in full;
`plans/FS89-S1D-derivation.md` in full; `plans/FS89-S0A-gluing-verification.md` §C1 (G1, N₀, G0) and its theorem table;
`plans/FS89-S1V-verification.md` and `plans/FS89-S0B-band-set.md` **theorem tables only** (budget; neither holds a step of the
routes below — logged as a reading debt, not as read). `[Berend1984]` Chapter I (pp. 506–509: Defs I.1–I.5, Lemmas I.1–I.2,
Thms I.1–I.3) and pp. 522–523 (Lemma II.16's density argument, Prop. II.6, Prop. II.7's proof), read in the held PDF's text layer.
Conventions: verifier I's (`R̂_S = (ℂ × ∏_{v|S} K_v)/Δ(R_S)`, point `(e; b)`, `c̄` the pure `v`-adic element, `u` acts by
`e ↦ ūe, b_v ↦ u b_v`). Cases are defined on the small chart representative: **case 1** — there are `z_n ∈ M − M`, `z_n → 0`, whose
small representatives have a non-zero local part; **case 2** — otherwise (a neighbourhood `N` of 0 with `(M − M) ∩ N ⊆ A`).

**The claim** (verbatim, `plans/FS89-PA-berend1984.md:373`): "for every finite `S` with `|S| ≥ 2`, every `U_S`-minimal closed
`M ⊊ R̂_S` lies in `T + A` (D1-L2, D1-L3, Berend Thm I.2 + Prop. II.6)".

### 2.1 Case 2 ⟹ `M ⊆ T + A` (any closed invariant `M`, any nonempty `S`; band-free) — re-derived

Cover `M` by finitely many small balls about `z₁ … z_m ∈ M`; then `M ⊆ ⋃_j (z_j + A)`, and the cosets of `A` meeting `M` are among
these finitely many. `u(z + A) = uz + A` and `u(M) = M`, so `U_S` permutes them and a finite-index `U′` fixes each. For `u ∈ U′` of
infinite order, `z∘u − z ∈ A` reads `(u − 1)b_v = r` at every `v | S` for one `r ∈ R_S`, so every `b_v` is the image of the one
`q = r/(u − 1) ∈ ℚ(i)`. Split `q = q₁ + q₂` (partial fractions: `q₁ ∈ R_S`, `q₂` integral at every `v | S`, denominator `m` prime to
`S`); `(e; q, …, q) ≡ (e − q₁; q₂, …, q₂)`, and `m` times the second summand is `x ↦ −Σ_{v|S} ψ_v(m q₂ x)`, which on `R_S` equals the
archimedean term of the product formula, so it lies in `A`; hence the summand is in `T + A`. So `M ⊆ T + A`. (This is verifier I's
VB5; D's D1-L2 is a shorter route with a stronger case hypothesis.) **Minimal form:** a minimal `M` meeting `T + A` is the orbit
closure of `τ + λ_d`, a finite union of circles `τ′ + {λ_{d′} : |d′| = |d|}` (the stabiliser of `τ` has finite index and contains a
power of `w_p`, dense on `S¹`).

### 2.2 Case 1 and `|S| ≥ 2` ⟹ `M − M = R̂_S` (D1-L3; band-free) — re-derived

`D := M − M` is compact, `U_S`-invariant, contains 0.
1. *A pure local element in `D`.* Take `z_n ∈ D`, `z_n → 0`, small representatives `(a_n; b_n) → 0`, `b_{n,v} ≠ 0` at one fixed `v | p`
   along a subsequence; say `|w_p|_v = p` (else use `w_p^{−1}`). Let `h_n = w_p^{k_n}` with `k_n` least such that `|h_n b_{n,v}|_v ≥ p^{−1}`.
   Then `h_n z_n` has representative (archimedean part `ū a_n → 0`; `v`-part in the annulus `[p^{−1}, 1]`; the conjugate place
   contracted; the other primes' places unchanged, `→ 0`). A subsequence converges to `c̄`, `c ∈ K_v^×`; `c̄ ∈ D` because `D` is
   closed and `h_n·z_n ∈ D` (`h·0 = 0`, so no base point is needed).
2. *Rotation.* `u·c̄ = (u_v c)‾ ∈ D`. Take `p′ ∈ S ∖ {p}` (**the only use of `|S| ≥ 2`**): `w_{p′}` is a `v`-unit of infinite order, so the
   closure of `⟨w_{p′}⟩` in `ℤ_p^× ≅ μ_{p−1} × ℤ_p` is an infinite closed subgroup, hence contains `1 + p^jℤ_p` for some `j`. So
   `D ⊇ {(w_p^n t c)‾ : t ∈ 1 + p^jℤ_p} = (w_p^n c)‾ + Γ_n`, `Γ_n` the image of the additive ball `w_p^n c p^j O_v`.
3. *Density.* As `n` runs in the direction that grows `|w_p^n|_v`, the balls increase to `K_v`, so the compact subgroups `Γ_n` increase to
   the image of `K_v`, which is dense in `R̂_S` (its annihilator in `R_S` is `{r : ψ_v(K_v r) = 0} = 0`). Increasing compact subgroups
   with dense union are eventually `ε`-dense for every `ε`, and so is every coset. `D` is closed, so `D = R̂_S`. ∎

### 2.3 Berend's Theorem I.2 applies to `(R̂_S, U_S)`, and it kills case 1 for minimal sets — hypotheses checked by me

`[Berend1984]` Thm I.2 (p. 509, verbatim from the text layer): "If (G, Σ) is a group ℱ-flow, then every minimal set is restricted",
where (Def. I.5) `A` is *restricted* if "the only closed Σ-invariant set B ⊆ G for which A + B = G is B = G". Def. I.4 (ℱ-flow): a
chain `Σ = Σ^{(1)} ⊇ Σ^{(2)} ⊇ …` with (1) each `(Ω, Σ^{(k)})` ergodic (Def. I.2: every closed invariant proper subset nowhere dense),
(2) `Σ/Σ^{(k)}` a finite group of cosets, (3) the fixed points of the `Σ^{(k)}` dense in the union. Prop. II.6 derives these on `Ω_a`
from one ergodic element plus a prime `q` at which every element is a unit, with `Σ^{(k)}` = the elements `≡ I (mod q^k)`. I redo it
for our action; nothing in it uses expansiveness, so the isometric archimedean direction does not obstruct it:
- **Choice.** `q` any rational prime not in `S` (e.g. 3). `Σ^{(1)} := U_S`, `Σ^{(k+1)} := {u ∈ U_S : u ≡ 1 (mod q^k R_S)}`. Every `u ∈ U_S`
  is a unit of `R_S` (`π_p, π̄_p` are invertible for `p ∈ S`), so multiplication by `u` is invertible mod `q^k`.
- **(2)** `U_S/Σ^{(k)}` embeds in `(R_S/q^{k−1}R_S)^×`, finite; `U_S` is abelian, so the cosets form a finite group. ✓
- **(3)** A character killed by `q^{k−1}` is fixed by `Σ^{(k)}` (`θ∘u − θ = θ∘(u − 1)` and `(u − 1)R_S ⊆ q^{k−1}R_S`). `⋃_k R̂_S[q^k]` is
  dense iff `⋂_k q^k R_S = 0` (Berend's Lemma II.16 argument, p. 522: `A(G, G[q^n]) = q^nĜ`), and `⋂_k q^kR_S = 0` since `q ∉ S`. ✓
- **(1)** `Σ^{(k)}` contains `w_p^l` for some `l ≥ 1` (finite quotient). The dual of `θ ↦ θ∘w_p^l` is `r ↦ w_p^l r` on `R_S`, whose every
  non-zero orbit is infinite (`w_p` is no root of unity); by Thm I.3 (Halmos) it is Haar-ergodic. A closed `A` with `w_p^l A ⊆ A` has
  `A ⊆ w_p^{−l}A` of equal measure, so `A` is invariant mod 0 and `μ(A) ∈ {0, 1}`; `μ(A) = 1` and `A` closed force `A = R̂_S` (Haar has
  full support). So a proper closed `Σ^{(k)}`-invariant set is null, hence nowhere dense. ✓
- **Thm I.1's proof re-walked in our group case** (it is what Thm I.2 uses, via Lemma I.2): the sets `A_{k,i}` are `u_iA_{k,1}`, one
  has interior (Baire), ergodicity makes it everything, so every `ξ` pairs with a point of `Ω_Y^{(k)}`, then of `Ω_Y^{(∞)}`; a
  `Σ^{(k)}`-fixed `ξ` then pairs with all of the `Σ^{(k)}`-minimal `Ω_Y^{(k)}`; density (3) and closedness give `Ω_X × Ω_Y^{(∞)} ⊆ A`,
  and minimality of `Y` finishes. Every step uses only (1)–(3), surjectivity of each `u`, and commutativity. ✓
- **Application.** Let `M` be minimal and in case 1. By 2.2, `M + (−M) = R̂_S`, and `−M` is closed and invariant (`u(−m) = −um`). Thm I.2:
  `−M = R̂_S`, so `M = R̂_S`. But `R̂_S` is not minimal: `{0}` is a closed invariant proper subset. Contradiction. So **every minimal
  set is in case 2**, and 2.1 puts it in `T + A`. ∎

(The `⊊` in the statement is automatic, since `R̂_S` is never minimal. Berend's half needs only `S ≠ ∅`; `|S| ≥ 2` enters only through
2.2, and at `|S| = 1` 2.2 fails, as it must: row 97.)

### 2.4 Verdicts

| claim (verbatim) | verdict | grade | inputs |
|---|---|---|---|
| PA-B2: "for every finite `S` with `|S| ≥ 2`, every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A`" | **TRUE** | hand | 2.1 (VB5), 2.2 (D1-L3), 2.3 (`[Berend1984]` Thm I.1–I.3 with Prop. II.6's construction, hypotheses checked here) |
| "So `MS_k(S)` holds at every band `k`" (truncated in the brief, C0 row Q2) | **TRUE** as quoted, at every `k ≥ 2` | hand | a minimal subset of `Θ_k(R_S)` is a `U_S`-minimal closed subset of `R̂_S` (minimality is intrinsic; `Θ_k` closed and invariant); no band enters |

**Where the value of `k` is used in stage 2: nowhere.** The band is not an input to 2.1–2.3.

## Stage 3, `k = 6` — SAVED

**The claim at `k = 6`** (from PA-B3, verbatim `plans/FS89-PA-berend1984.md:374`: "(candidate) `RS_k(S)` for `k < 2·min S`, `|S| ≥ 2`;
`RQ_k` for `k ≤ 9` (PA-B2 with VB1–VB4)"): `RS₆(S)` for every `|S| ≥ 2` with `min S ≥ 5` (always true: `S` holds primes `≡ 1 mod 4`),
and `RQ₆`. The objects: `B₆ = [1/6, 5/6]`, `Θ₆(R_S) = {θ : θ(U_S) ⊆ B₆}`.

### 3.6.1 The route the claim names (R1: PA-B2, then VB1, VB3, VB4), re-derived at `k = 6`

1. **Minimal sets.** Every minimal subset of `Θ₆(R_S)` lies in `T + A`: stage 2 (PA-B2), band-free. *Uses `k`: no.*
2. **The point step (VB1, `plans/FS89-S1VB-verification.md` §B1.1).** Let `y ∈ Θ₆(R_S)`; its orbit closure `Ō(y)` contains a minimal set,
   hence (step 1) a point `x = τ₀ + λ_d`. With `U₀ = Stab(τ₀)` (finite index) and `g_n y → x`: if some `g_n y − x ∈ A`, then
   `y ∈ T + A`. Otherwise Lemma E (expansion at a place `v | p`, `p ∈ S`) gives `x′ + c̄ ∈ Ō(y)` with `x′ = τ₀ + λ_{d′}`, `c ∈ K_v^×`;
   the second prime `p′ ∈ S ∖ {p}` and Lemma JC (the joint closure of `(w̄_{p′}^{bn}, w_{p′}^{bn}|_v)` is `S¹ × W₀`, `W₀ ⊇ 1 + p^jℤ_p`)
   give `x′ + c̄′ ∈ Ō(y) ⊆ Θ₆` for every `c′` in the ball `c + c p^j O_v`. I re-derived Lemma E, JC and this step; none uses `k`
   (they use only that `Θ₆` is closed and invariant).
   **The line that uses `k`:** Lemma SW, verbatim (`plans/FS89-S1VB-verification.md:55–58`): "Let `k ∈ {4, 5}` … the values fill a coset
   of `(1/p)ℤ/ℤ`, step `≤ 1/5`, which meets the open arc `(−1/k, 1/k)` of length `2/k ≥ 2/5`." **What it needs of `k`:** a full coset of
   step `1/p` meets every open arc of length `2/k` iff `1/p < 2/k`, i.e. `k < 2p` (the written clause "`2/k ≥ 2/5`", i.e. `k ≤ 5`, is
   stronger than the proof needs). At `k = 6`: `1/5 < 1/3` and `1/13 < 1/3`, so the lemma's one-digit sweep works at every prime of
   `S = {5, 13}`, and at every `p ≥ 5`. ✓
   **And the condition is removable** [hand + tools exact]: choosing `u = w_p^{±t}` with `π_v^s u O_v = π_v^{−m}O_v` instead of
   `π_v^{−1}O_v`, the values fill a full coset of `(1/p^m)ℤ/ℤ` (`ψ_v` has conductor `O_v`, so it is injective on `π_v^{−m}O_v/O_v`), which
   meets the open arc once `p^m > k/2`. `tools/crunch_j01_sweep_check.py` (output `data/fs91/j01/sweep-check.txt`) realises the sweep in
   `R_{5,13}`'s chart at `v = (2 − i)`: the coset is full for `m = 1, 2, 3` (A1); with one digit the worst coset meets the arc iff
   `k < 10`, and at `k = 10` an explicit offset keeps all five values in `[1/10, 9/10]` (A2: the lemma as written is sharp at `k = 2p`);
   with `m(k)` digits every coset meets it for `k = 3..60` (A3). Plants fire for their stated reasons: the conjugate place (`w₅` contracts,
   the sweep collapses) and a closed arc (the `k = 10` sharpness disappears).
3. **Finiteness (VB3).** `RS₆(S)` ⟹ `Θ₆(R_S) ∩ T` finite: distinct band torsion characters accumulate at `φ = τ₀ + λ_d ∈ Θ₆`; since
   `T ∩ A = 0` (R_S is `p`-divisible), Lemma E yields `τ₀ + λ_{d′} + c̄ ∈ Θ₆` with `c ≠ 0`, a point outside `T + A` (its local data are
   not the image of one rational). Re-derived. *Uses `k`: no* (only that `Θ₆` is closed, invariant, and inside `T + A`).
4. **Layering (VB4 = S0A's G1 with base `R_S`; D's D2-L1).** For `θ ∈ Θ₆(R_{S′})`, `S′ ⊇ S` (or `Q`), and `u ∈ U_{S′}`, `y ↦ θ(uy)` is a band
   character of `R_S` at the **same** band (`uU_S ⊆ U_{S′}`), so it is `τ_u + λ_{e_u}` with `τ_u ∈ Θ₆ ∩ T` (the leaf formula: the torsion part
   of a band `T + A` point is band, since each `τ`-fibre of `U_S` is dense on the circle), hence `Nτ_u = 0` for the lcm `N` of step 3's
   finite list. G1's steps 2–6 (one real lift by `p`-divisibility; `c_x` independent of the decomposition; `Φ` additive, lifts `Nθ`) then
   give `θ ∈ T_N + A`. I re-read G1 (`plans/FS89-S0A-gluing-verification.md` §C1) and D2-L1: **neither uses the band** beyond carrying the
   same `k` from hypothesis to conclusion (S0A says so in words, and the proof bears it out). *Uses `k`: no.*
   **So `RQ₆` follows from `RS₆({5, 13})`**, and `RS₆(S′)` for every `S′ ⊇ S`.

### 3.6.2 A second, elementary route to step 1 inside the band (R2: the parity line), independent of Berend

Let `M ⊆ Θ₆(R_S)` be minimal and in case 1. D1-L3 gives `θ₂ ∈ M − M = R̂_S`: `y, y + θ₂ ∈ M`. Since `θ₂(u) = 1/2` on `U_S`,
`y(u) ∈ [1/6, 1/3] ∪ [2/3, 5/6]`, so `2y(u) ∈ [1/3, 2/3]`: **`2y ∈ Θ₃(R_S)`** (checked exactly, B1). **The line that uses `k`:** "`y(u)` and
`y(u) + 1/2` both in `B_k` ⟹ `2y(u) ∈ [2/k, 1 − 2/k]`"; at `k = 6` it lands in the band `[1/3, 2/3]`.
- `MS₃(S)`: a minimal `N ⊆ Θ₃` in case 1 would give `z, z + θ₂ ∈ Θ₃`, i.e. two antipodal values in an arc of length `1/3 < 1/2`: impossible. So
  `N` is in case 2 and lies in `T + A` (2.1). With VB1 at `k = 3` (one-digit sweep: `1/5 < 2/3`), `RS₃(S)`: `Θ₃(R_S) ⊆ T + A`. (FS81-T3
  layered gives the explicit set, but is not needed.)
- So `2y = τ + λ_e`, hence `2(y − λ_{e/2}) = τ` and `y ∈ T + A`; `M = Ō(y)` is then a finite union of leaf circles, whose small differences
  are archimedean (distinct torsion parts differ by a non-zero element of a finite set, bounded away from `A`). That is case 2, a
  contradiction. So `MS₆(S)` holds by a route with no input from Berend — only D1-L3, VB5 and VB1.

### 3.6.3 Verdict at `k = 6`

| item | verdict | grade | the `k`-lines and what they need |
|---|---|---|---|
| `RS₆(S)`, `|S| ≥ 2` (the claim's `k < 2·min S` holds: `6 < 10`) | **TRUE** | hand; the sweep arithmetic tools exact (`tools/crunch_j01_sweep_check.py`) | Lemma SW's arc line: `1/p < 2/k`, i.e. `k < 2p` (as written), or `p^m > k/2` for some `m` (always); R2's parity line: `[2/k, 1 − 2/k] = [1/3, 2/3]` |
| `RQ₆` | **TRUE** | hand | none beyond `RS₆({5, 13})`; VB3, VB4, G1, D2-L1 are band-free |
| do VB3, VB4, D2-L1 use `k`? | **no** | — | they carry one band from hypothesis to conclusion |

**What the next job may consume:** `Θ₆(Q) ⊆ T + A` (and `Θ₆(R_F) ⊆ T + A` for every `F ⊆ ℝ`, by S0A-2's band-free gluing), with
`Θ₆(R₆₅) ∩ T` finite. **Not established here:** the explicit list of band-1/6 torsion types of `Q` (the analogue of N₀/U2 at 1/6 — S0A's
middle-half count and the level collapse were done at bands 1/4, 1/5 and are **not** re-derived at 1/6), and any bound on its torsion
order beyond "finite". Any consequence at ℚ(√167) needs that list.

## Would-have-searched-here log

| stage | move a search would have made | what I did instead |
|---|---|---|
| 1 | — | — |

## Theorems this phase proved

*(filled as stages land)*
