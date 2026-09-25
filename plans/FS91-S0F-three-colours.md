# FS-91 stage 0, job J02 — three colours obey the local–global conjecture over every real number field (derivation record)

*Crunch job J02, 2026-09-25; de Bruijn (Opus 5.5), the derivation agent. Brief:
`data/crunch-2026-09-25/briefs/J02-three-colours-stage0.md` with `data/crunch-2026-09-25/briefs/STANDING-RULES.md`. The blind
derivation J09 (`plans/FS91-S0FV-three-colours-blind.md`) and `plans/FS91-close-inventory.md` are fenced: not read, not messaged.*

**Notation** is `CLAUDE.md` § Notation's and `plans/FS89-derivation.md`'s: `F ⊆ ℝ` a field, `L = F(i)`, `c` complex conjugation on `L`,
`U = U_F = {z ∈ L : z c(z) = 1}` (the unit vectors of `F²`, with `F² ≅ L` by `(x, y) ↦ x + iy`), `R = R_F = ℤ[U]` (the additive span
of `U`), `Θ₃(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ [1/3, 2/3]}`. A **stable** prime is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`.

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

Each quotation in the brief against its source, read from disk this stage.

| # | the brief's quotation | source | verdict |
|---|---|---|---|
| Q1 | "The sum of several local parts is the one step to check; it is a sumset question, not a search." | `plans/POROS-2026-09-25-crunch-plan.md` §1.2, F1, fifth sub-bullet | **verbatim** |
| Q2 | the sketch block, "F1 sharpened after reading FS89-derivation CL2 and S0A-3 … Johnson papers, which are not held." | the advisor's second message ("Send 2"); committed only as a summary in `plans/POROS-2026-09-25-crunch-plan.md` §3, Send 2 | **matches the summary** in every checkable point (CL2 "for every `F ⊆ ℝ`"; S0A-3's `\|α\| ≤ 1/12`; Cayley parametrisation and weak approximation; the three named checks; 0.75). The verbatim text exists only in the brief, so the block is taken as the advisor's words on the planner's authority |
| Q3 | "CL2 is stated for every subfield F ⊆ ℝ: Θ₄(R_F) ⊆ T₁₆₈ + A." | `plans/FS89-derivation.md` FS89-CL2's title: "For every subfield `F ⊆ ℝ`: `Θ₄(R_F) ⊆ T₁₆₈ + A` and `Θ₅(R_F) ⊆ T + A`" | **correct** (the five-band half omitted, not needed) |
| Q4 | "(b) order 3 with \|α\| ≤ 1/12 (S0A-3 gives the same bound)" | S0A-3 (`plans/FS89-derivation.md`): "an order-3 part (with `\|α\| ≤ 1/12`)" — **at band `[1/4, 3/4]`** | **correct as a quotation of S0A-3; not C1(5)'s bound.** At band `[1/3, 2/3]`, C1(5) (`plans/FS81-derivation.md` T3) lists the order-3 type as the four characters `X₃` **with no archimedean part**: they take the values 1/3 and 2/3 exactly on `U₅`, so `α = 0`. The sketch's bound is true (weaker) and harmless |
| Q5 | "(a) parity plus an archimedean part of norm at most 1/6" | FS81-T3: "`{θ₂ + λ_e : \|e\| ≤ 1/6} ∪ X₃`" | **correct** |
| Q6 | "FS73-T22 gives θ ∈ Θ₃(R_F)" | FS73-T22 is stated for finitely generated `Λ` (`plans/FS73-derivation.md` T21–T22 setting); the passage to `R_F` is FS81-T2 (compactness, "with no finite generation of `ℤ[U_F]`") | **correct with FS81-T2 as the conduit** (the sketch names T22 only) |
| Q7 | row 95: "every four-colour band character of every real field's unit-vector ring is torsion plus archimedean" (the brief's paraphrase, "Why now") | `LEDGER.md` row 95: "by the gluing the same holds for every real field (`Θ₄(R_F) ⊆ T₁₆₈ + A`, `Θ₅(R_F) ⊆ T + A` for every `F ⊆ ℝ`)" | **faithful** |
| Q8 | "3 inert in the cubic and split in ℚ(√7); the prime above 7 of residue field `𝔽₇`, stable in `F(i)`" (S3) | FS-82 stub, "First instance" and "Why it is an exposed test" | **faithful**; re-derived in stage 3 |
| Q9 | S2's "the FS-45 stub's Theorem 2.1" for the two-colour case | the two-colour classification is GPT Astra's Theorem 2.1 (`reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` §2), carried in G55 and row 63; FS-45's stub is the chain theorem's kernel home | **address to check at stage 3**; the theorem itself is Astra's Thm 2.1 |

### 1.2 C0 — predictions

**Honesty note:** these were written after reading every source in the brief's list **and** after a route to S1 had formed in thought
(the finite ring `R/6R`, Astra's Teichmüller subring and Hilbert-90 lift, applied to the torsion character `τ` of FS81-T4). They are not
blind priors; they measure confidence in a route already seen, before any line of it was written down or checked.

| item | claim | P(true as the brief states it) | the reason |
|---|---|---|---|
| **S1** | every real number field: `χ(F²) ≤ 3 ⟹ L(F) ≤ 3` | **0.85** | a complete route is in view that needs neither row 95 nor Lemma R; the risk is a slip in the finite-ring step |
| **S2** | the conjecture's `L ≤ 4` clause for every real number field | **0.83** | S1 plus three known directions (row 52, Astra Thm 2.1) |
| **S3** | `Θ₃(ℤ[U_F]) = ∅`, `χ(F²) = 4` at `ℚ(α, √7)` | **0.83** | S1 plus arithmetic the stub already did; PARI to re-check |
| step 1 | T22 gives `θ ∈ Θ₃(R_F)` | 0.97 | FS81-T2 |
| step 2 | type (a) ⟹ bipartite | 0.9 for a point **all of whose** unit vectors are of type (a); **0.3** that the sketch covers a point with both types | type is per layer, not global; nothing in the sketch rules out a mixture |
| step 3 | type (b): `τ` factors through `R_F/3R_F` = "the product over the stable 𝔭 \| 3, collapsed to level one by the band" | **0.4** provable from held inputs in general | `R/3R ≅ ∏ O_𝔓/3O_𝔓` is Lemma R's consequence (b), whose scope is `L/ℚ` Galois (FS86-B1-LR) — **the first instance `L = ℚ(α, √7, i)` is not Galois over ℚ**; and at a ramified 3 `R/3R` has nilpotents the band must collapse |
| step 4 | Cayley + weak approximation: `U_F` jointly dense in the local circles and "the archimedean circle" | 0.95 for weak approximation; 0.9 that "the archimedean circle" (singular) is a wording slip | a field with complex places has non-compact archimedean factors `ℂ^×`; and density in local circles becomes surjectivity onto `R/NR` only through Lemma R |
| step 5 | the sumset step | 0.6 as stated | it assumes a global type (b) |
| step 6 | an additive 3-colouring of `Γ_{3^f}` forces `f = 1` | 0.95 | Weil (Hoffman) for `q ≥ 27`; exact at 27 by tool |

**Registered outcome:** S1 TRUE by a route that repairs steps 2–5 (0.85); GAP left open (0.12); FALSE (0.03).

### 1.3 Would-have-searched-here log

- Stage 2: would have built a finite configuration of unit vectors over `ℚ(α, √7)` and run a `Θ₃` relation tree on it (the FS-82 stub's route 3); instead derived S1 for every real number field, which gives S3 as a corollary.
- Stage 2: would have searched `𝔽₇₂₉` for a hyperplane missing `μ₂₈` with a solver; instead, a complete exact enumeration of all 728 functionals (and all 59,048 at `q = 243`). This is **at the ban's edge**: a finite set whose extent the derivation fixed first. It is a control only; the proof is Weil's bound, L4(a).
- Stage 3: would have searched for a finite configuration `{vᵏ}·U₅` over `ℚ(α, √7)` with empty `Θ₃` (FS81-T5's shape; the FS-82 stub's route 3); instead read `χ ≥ 4` off J02-T2 and the prime data at 2 and 3 (PARI, exact, seconds). No finite witness is exhibited.

## Stage 2 — SAVED: S1 derived

### 2.0 Verdict

**S1 is TRUE** [hand]: for every real number field `F`, `χ(F²) ≤ 3 ⟹ L(F) ≤ 3`; indeed `χ(F²) ≤ 3` holds iff `F` has a stable prime
above 3 with residue field `𝔽₃`, or a stable prime above 2 ramified in `L/F` (J02-T2 below). **The sketch as written has a GAP at steps
2–5**, repaired here, not left open:
- it treats the layer *type* as global, while a type is a property of one unit vector (one layer), and it never excludes a point of
  `Θ₃` whose unit vectors carry both types;
- its step 3 identifies `R/3R` with "the product over the stable 𝔭 | 3". That is Lemma R's consequence (b) (FS86-B1-LR), whose scope
  is `L/ℚ` Galois with no stable prime ramified in `L/F`. **The first instance `L = ℚ(α, √7, i)` is outside it** (`ℚ(α)` has discriminant
  −23, so it is not Galois).

The repair uses **neither row 95 nor Lemma R nor the archimedean part**. FS-81's torsion character `τ` (T4) is already a point of `Θ₃`.
The sumset is then done in the finite ring `R/6R`, through a Teichmüller subring and a Hilbert-90 lift of unit vectors (Astra's §3.3
construction, run at 2 and 3 at once). That lift is weak approximation at finite level, and it is what couples the dyadic and 3-adic
parts.

### 2.1 Inputs, with their grades

| input | statement used | grade | address |
|---|---|---|---|
| I1 | for every `F ⊆ ℝ`, `χ(F²) ≤ 3 ⟹ Θ₃(R_F) ≠ ∅` | hand, two derivations (rests on FS73-T22 ⟹, three derivations) | FS81-T2 |
| I2 | C1(5): the rotation set of `U₅` at band `[1/3, 2/3]` is `{θ₂ + λ_e : \|e\| ≤ 1/6} ∪ X₃` | hand + tools exact | FS81-T3 |
| I3 | `τ(x) = lim_k θ(25^{−k}x)` is a character `R_F → (1/6)ℤ/ℤ`, equal to 1/2 on parity-type units and to 1/3 or 2/3 on order-3 units | hand, two derivations | FS81-T4 |
| I4 | Lemma 1.1: a maximal ideal `𝔪 ∋ p` of `R` is `R ∩ 𝔓` for a **stable** prime `𝔓` of `L` above `p`, and `R ⊆ O_𝔓` | hand (GPT Astra); read and re-derived here | `reference/ChatGPT-local-global-tightness-conjecture/local-global-further-results.md` §1 |
| I5 | Astra §3.1–3.3 (stated there for `p = 3`, `√3 ∈ F`): `R/pR` is finite of dimension ≤ `[L:ℚ]`; its reduced quotient's factors are the full residue fields at stable primes; a Teichmüller subring `T ⊂ R/pR` and a Hilbert-90 lift | hand (Astra); **generalised here** to every `p` and to `R/6R` (J02-L2, J02-L3), re-derived line by line | same file §3.1–3.3 |
| I6 | Weil: `\|Σ_{t ∈ μ_{q+1}} ψ(Tr(at))\| ≤ 2√q` on `𝔽_{q²}` | external (Kloosterman sums; G44) | checked exactly at `q = 27, 243`: `tools/crunch_j02_additive_check.py` |
| I7 | `χ(Γ₃) = 3`; a stable prime ramified in `L/F` gives a two-colourable target | known (G56; G56's trichotomy) | G56 |

### 2.2 J02-L1 — torsion extraction: `Θ₃(R_F) ≠ ∅ ⟹ Θ₃(R_F) ∩ T₆ ≠ ∅` [hand; a composition of FS81-T3 and T4]

*Statement.* For every subfield `F ⊆ ℝ`: if `θ ∈ Θ₃(R_F)`, then `τ(x) := lim_k θ(25^{−k}x)` is a character of `R_F` with `6τ = 0` and
`τ(U_F) ⊆ {1/3, 1/2, 2/3}`, so `τ ∈ Θ₃(R_F)`.

*Proof.* This is FS81-T4's `τ`, written out. For `b ∈ U`, `y ↦ θ(by)` on `R₅ = ℤ[i][1/5]` lies in C1(5)'s set (FS81-T1 with
`φ = y ↦ by`). At `y = 25^{−k}`:
- `θ₂(25^{−k}) = θ₂(1) = 1/2`, since `25^{−k} ≡ 1` modulo `(1 + i)`;
- `λ_e(25^{−k}) = Re(ē)/25^k → 0`;
- `χ(25^{−k}) = χ(1)` for `χ ∈ X₃`, since `25 ≡ 1 (mod 3)`.

So for `x = Σ ε_j u_j` the limit exists and equals `Σ ε_j τ(u_j)`, with `τ(u) = 1/2` on a parity-type `u` and `τ(u) = χ_u(1) ∈ {1/3, 2/3}`
on an order-3 `u` (`X₃`'s characters are non-zero at 1). The limit depends only on `x` and is additive. ∎

*Remarks.*
1. The archimedean part is never used, and no gluing to a global archimedean functional is needed. The torsion part is **already** in
   the band, because at band 1/3 an order-3 layer has no archimedean part at all: `X₃`'s values on `U₅` are exactly 1/3 and 2/3.
2. **A second route**, not needed and not claimed: `Θ₃ ⊆ Θ₄ ⊆ T₁₆₈ + A` (FS89-CL2), then FS89-S0A-7's archimedean averaging. That entry's
   density step is written for `T(ℝ)²`, the totally real case. For a field with complex places (such as `ℚ(α, √7)`, with two real and two
   complex places), the archimedean norm-one torus at a complex place is `ℂ^×`, which is not compact. There one first shows the
   functional vanishes on those components: `Re(cz) + Re(c′/z)` is bounded on `ℂ^×` only if `c = c′ = 0`.

### 2.3 J02-L2 — the finite quotients `R/pR` [hand; Astra's Lemma 1.1 and §3.1–3.2, extended from `p = 3` to every prime]

*Statement.* Let `F` be a real number field, `n = [L : ℚ]`, `p` a prime, `A_p = R/pR`.
- (a) `A_p` is a finite `𝔽_p`-algebra with `dim A_p ≤ n`, and `c` induces a ring involution on it.
- (b) Every maximal ideal `𝔪 ∋ p` of `R` equals `R ∩ 𝔓` for a stable prime `𝔓 | p` of `L`, and `c(𝔪) = 𝔪`. So `c` acts on the field
  `k_𝔪 = R/𝔪 ⊆ κ_𝔓`.
- (c) If `𝔓` is unramified in `L/F` (always, for odd `p`), then `k_𝔪 = κ_𝔓 = 𝔽_{q²}` and `c` acts as its non-trivial involution, with
  fixed field `κ_𝔭 = 𝔽_q`, where `𝔭 = 𝔓 ∩ F`. The norm-one group `𝒩(k_𝔪) = {s : s·c(s) = 1}` is `μ_{q+1}`.
- (d) If `𝔓` is ramified in `L/F` (so `p = 2`), then `c` acts trivially on `k_𝔪` and `𝒩(k_𝔪) = {1}`.

*Proof.*
- (a) Any `n + 1` elements of `R ⊂ L` satisfy a primitive integer relation, which stays non-trivial mod `p`. `c(R) = R` because
  `c(U) = U`.
- (b) This is Lemma 1.1.
  - `B′ = R·O_L` is a finite `R`-module, hence integral over `R`; by lying-over some prime `𝔫` of `B′` lies over `𝔪`.
  - `B′_𝔫` contains the discrete valuation ring `(O_L)_𝔓`, where `𝔓 = 𝔫 ∩ O_L`, and it is not `L`. So `B′_𝔫 = O_𝔓` and `𝔪 = R ∩ 𝔓O_𝔓`.
  - `𝔓` is stable: otherwise pick `a ∈ 𝔓 ∖ c(𝔓)`. Then `a/c(a) ∈ U` has positive `𝔓`-valuation, so its inverse, also in `U ⊂ R ⊂ O_𝔓`,
    has negative valuation, a contradiction.
  - Finally `c(𝔪) = R ∩ c(𝔓) = 𝔪`.
- (c) `𝔓` is stable and unramified, so it is inert over `𝔭` and `c` generates `Gal(κ_𝔓/κ_𝔭)`.
  - Every `s ∈ μ_{q+1}` is `b/σ(b)` for some `b ∈ κ_𝔓^×` (finite-field Hilbert 90).
  - Lift `b` to `a ∈ O_L ∖ 𝔓`. Then `a/c(a) ∈ U` reduces to `s`, so `k_𝔪 ⊇ 𝔽_p[μ_{q+1}]`.
  - That ring is all of `𝔽_{q²}`, because the order of `p` modulo `q + 1 = p^f + 1` is exactly `2f`: for `j ≤ f`, `0 < p^j − 1 < p^f + 1`;
    for `f < j < 2f`, `p^j ≡ −p^{j−f}` and `0 < p^{j−f} + 1 < p^f + 1`.
- (d) Ramification in `L/F` makes the residue extension trivial, so `c` fixes `κ_𝔓 ⊇ k_𝔪`. In characteristic 2, `s² = 1` forces `s = 1`. ∎

### 2.4 J02-L3 — the Teichmüller section and the joint lift [hand; Astra §3.3, run on `R/6R`]

*Statement.* Let `F` be a real number field.
- For `p ∈ {2, 3}`, let `T_p = {a^{p^M} : a ∈ A_p}`, where `M` is divisible by every `[k_𝔪 : 𝔽_p]` and `p^M` exceeds the nilpotency index
  of `A_p`'s nilradical `J_p`.
- Then `T_p` is a `c`-stable subring of `A_p` with the same 1, and `T_p ≅ A_p/J_p ≅ ∏_{𝔪 ∋ p} k_𝔪` compatibly with `c`.
- Put `T = T₃ × T₂ ⊂ A₃ × A₂ = R/6R` (CRT) and `𝒩(T) = {s ∈ T : s·c(s) = 1} = ∏_𝔪 𝒩(k_𝔪)`.
- **Every `s ∈ 𝒩(T)` is the image of a unit vector `u ∈ U`.** In particular the image of `U` in `R/6R` contains the product set
  `𝒩(T₃) × 𝒩(T₂)`.

*Proof.*
1. **`T_p` is a subring isomorphic to the reduced quotient.** Frobenius is a ring endomorphism, so `T_p` is a subring, containing
   `1 = 1^{p^M}`. The map `T_p → A_p/J_p` is onto: `ā = ā^{p^M}` in each factor. It is injective: `a^{p^M} ∈ J_p` makes `a` nilpotent,
   and then `a^{p^M} = 0`. `c` commutes with Frobenius.
2. **Each factor splits `s` by Hilbert 90.** For `s ∈ 𝒩(T)`, write `s = (s_𝔪)`. Each `s_𝔪` is `b_𝔪/c(b_𝔪)` with `b_𝔪 ∈ k_𝔪^×`: by finite
   Hilbert 90 when `c` is non-trivial on `k_𝔪`, and with `b_𝔪 = 1` when it is trivial, since then `s_𝔪 = 1` by L2(d). (`c` is never
   trivial in characteristic 3, by L2(c).)
3. **Lift `b` to a unit vector.** Put `b = (b_𝔪) ∈ T^×`. Lift it to some `a ∈ R`, so `a ≠ 0`, and set `u = a/c(a)`. Then `u·c(u) = 1`, so
   `u ∈ U`. The identity `u·c(a) = a` holds in `R` and reduces mod `6R` to `[u]·c(b) = b`. Since `c(b) ∈ T^×` is a unit of `R/6R`,
   `[u] = b/c(b) = s`. ∎

*What it replaces.* The sketch's step 4 (the Cayley parametrisation plus weak approximation) is the same idea at the level of
completions. At that level it reaches `R/6R` only through Lemma R's `R/NR ≅ ∏ O_𝔓/N`. L3 needs no identification of `R/6R` with a local
product: it works inside whatever finite ring `R/6R` is, nilpotents and all, and it reads only the reduced part.

### 2.5 J02-L4 — norm-one functionals [hand + external Weil; exact at `q = 27, 243` and `Q ≤ 32`]

- **(a)** For `q = 3^f`, `f` odd, an additive `λ : 𝔽_{q²} → (1/3)ℤ/ℤ` with `λ(t) ≠ 0` for every `t ∈ μ_{q+1}` exists iff `q = 3`.
  - `q = 3`: `λ(x + yi) = (x + y)/3` works on `μ₄ = {±1, ±i}`.
  - `q ≥ 27`: every such `λ` is `x ↦ Tr_{𝔽_{q²}/𝔽₃}(ax)/3` (the trace form is non-degenerate). With `S(a) = Σ_{t ∈ μ_{q+1}} ω^{Tr(at)}`
    (real, since `−1 ∈ μ`), the zero count is `Z(a) = (q + 1 + 2S(a))/3 ≥ (q + 1 − 4√q)/3`, which is positive once `q + 1 > 4√q`, that
    is `q ≥ 14`.
  - Equivalently, an additive three-colouring of `Γ_q` is a three-colouring, and Hoffman with Weil gives `χ(Γ_q) ≥ 1 + (q+1)/(2√q) > 3`
    for `q ≥ 14` (G44; G56's floor 6 at 27).
  - *Exact:* every one of the 728 functionals at `q = 27` vanishes somewhere on `μ₂₈` (min 4 zeros), and every one of the 59,048 at
    `q = 243` somewhere on `μ₂₄₄` (min 62). The identity `3Z = q + 1 + 2S` and `|S| ≤ 2√q` hold at every `a`, and the `q = 3` control
    finds its colouring (`data/fs91/j02/additive-check.txt`).
- **(b)** For `Q = 2^f`, no additive `λ : 𝔽_{Q²} → (1/2)ℤ/ℤ` is 1/2 on all of `μ_{Q+1}`. The reason: `Σ_{t ∈ μ_{Q+1}} t = 0`, so
  `0 = λ(0) = (Q + 1)/2 = 1/2`, since `Q + 1` is odd. *Exact:* `Q = 2, …, 32`.
- **Tool.** `tools/crunch_j02_additive_check.py`, 0.6 s. Plants `notsubgroup` (the subgroup check fires) and `badtrace` (the "trace lies
  in `𝔽_p`" check fires) each exit 1 for their own reason (`data/fs91/j02/additive-check-plants.txt`).

### 2.6 J02-T1 — the torsion local–global theorem at three colours [hand]

*Statement.* Let `F` be a real number field. **A character `τ` of `R_F` with `6τ = 0` and `τ(U_F) ⊆ [1/3, 2/3]` exists iff `F` has a
stable prime above 3 whose residue field is `𝔽₃`, or a stable prime above 2 ramified in `F(i)/F`.**

*Proof of ⟸.*
- An `𝔽₃` prime 𝔓: take `λ ∘ (R → κ_𝔓 = 𝔽₉)`, with `λ` from L4(a) at `q = 3`. Unit vectors land in `μ₄`.
- A ramified stable dyadic prime: take `x ↦ ½·tr(x mod 𝔓)` with `tr` a functional equal to 1 at 1 (Moorhouse §7.1's trace). Unit
  vectors land on 1 by L2(d).

*Proof of ⟹.*
1. **Split `τ` into its dyadic and 3-adic parts.** Since `τ(U) ⊆ [1/3, 2/3] ∩ (1/6)ℤ/ℤ = {1/3, 1/2, 2/3}`, put `τ₂ = 3τ` and `τ₃ = −2τ`.
   Then `τ = τ₂ + τ₃`; `τ₂` kills `2R` and `τ₃` kills `3R`. On a unit vector, `τ(u) = 1/2, 1/3, 2/3` gives
   `(τ₂(u), τ₃(u)) = (1/2, 0), (0, 1/3), (0, 2/3)`. Call these three pairs *allowed*. `(0, 0)` and `(1/2, ±1/3)` never occur on `U`.
2. **Read both parts on one unit vector.** Under `R/6R = A₃ × A₂`, `τ₃` is a function on `A₃` and `τ₂` on `A₂`. By L3, for **every**
   `s₃ ∈ 𝒩(T₃)` and **every** `s₂ ∈ 𝒩(T₂)` there is `u ∈ U` with `[u] = (s₃, s₂)`. So `(τ₂(s₂), τ₃(s₃))` is allowed for all such pairs.
   Both sets are non-empty: they contain 1, or 0 when the ring is 0.
3. **Two cases, from one `s₂`.**
   - If `τ₂(s₂) = 0`, then every `s₃` has `τ₃(s₃) ≠ 0`, and then every `s₂′` has `τ₂(s₂′) = 0`. This is case (i).
   - If `τ₂(s₂) = 1/2`, then every `s₃` has `τ₃(s₃) = 0`, and every `s₂′` has `τ₂(s₂′) = 1/2`. This is case (ii).
4. **Case (i): `τ₃(𝒩(T₃)) ⊆ {1/3, 2/3}`.**
   - `A₃ ≠ 0`: otherwise `𝒩(T₃) = {0}` and `τ₃(0) = 0`.
   - On `T₃ ≅ ∏_𝔪 k_𝔪`, `τ₃ = Σ_𝔪 λ_𝔪`, where `λ_𝔪` is additive on `k_𝔪 = 𝔽_{q_𝔪²}`. Put `C_𝔪 = λ_𝔪(μ_{q_𝔪+1})`, symmetric
     because `−1 ∈ μ`. So each `C_𝔪` is `{0}` or contains `{1/3, 2/3}`.
   - **The sumset step.** `Σ_𝔪 C_𝔪 = τ₃(𝒩(T₃))` avoids 0. If every `C_𝔪 = {0}`, the sum is `{0}`. If two are not `{0}`, their sum
     `{1/3, 2/3} + {1/3, 2/3}` is all of `𝔽₃`, and so is the total. So exactly one `C_{𝔪₀}` is not `{0}`, and it avoids 0: `λ_{𝔪₀}` is
     non-zero on all of `μ_{q+1}`.
   - By L4(a), `q = 3`. By L2(c), `𝔭₀ = 𝔓₀ ∩ F` is a stable prime above 3 with residue field `𝔽₃`.
5. **Case (ii): `τ₂ ≡ 1/2` on `𝒩(T₂)`.**
   - `A₂ ≠ 0` for the same reason: if `1/2 ∈ R`, i.e. the wall is broken, this case cannot occur.
   - On `T₂ ≅ ∏ k_𝔪`, `τ₂ = Σ λ_𝔪`. Varying one coordinate at a time shows each `λ_𝔪` is a constant `c_𝔪` on `𝒩(k_𝔪)`, with
     `Σ c_𝔪 = 1/2`.
   - At an unramified (inert) `𝔪`, L4(b) forces `c_𝔪 = 0`: `(Q+1)c_𝔪 = λ_𝔪(Σμ) = 0` with `Q + 1` odd.
   - So some `𝔪` has `c_𝔪 = 1/2`, and it is ramified: by L2(d), a stable dyadic prime ramified in `L/F`. ∎

*Remarks.*
1. Non-bipartiteness is never used. The theorem also re-proves the ⟸ half of Astra's Thm 2.1 at the level of torsion characters.
2. **Mixed types are real, and harmless.** Nothing above shows that all unit vectors of a point share one type. The point is that the
   types cannot be mixed **across the Teichmüller norm-one set `𝒩(T₃) × 𝒩(T₂)`**, which L3 makes a product. That product is exactly the
   sketch's missing "sum of several local parts", done jointly at 2 and 3.
3. **`L(F)` also has a closed form at three colours:** `L(F) ≤ 3` iff one of the two prime types exists. ⟸ is `χ(Γ₃) = 3` and a matching
   target. ⟹ goes through J02-T2 below, since `χ(F²) ≤ L(F)` (row 52).

### 2.7 J02-T2 = S1 [hand; a composition]

*Statement.* For every real number field `F`, the following are equivalent:
- (1) `χ(F²) ≤ 3`;
- (2) `Θ₃(R_F) ≠ ∅`;
- (3) `Θ₃(R_F)` has a point of order dividing 6;
- (4) `F` has a stable prime above 3 with residue field `𝔽₃`, or a stable prime above 2 ramified in `F(i)/F`;
- (5) `L(F) ≤ 3`.

In particular **`χ(F²) ≤ 3 ⟹ L(F) ≤ 3` (S1)**.

*Proof.* The chain runs (1) ⟹ (2) ⟹ (3) ⟹ (4) ⟹ (5) ⟹ (1), with (2) ⟹ (1) also direct:
- (1) ⟹ (2) is FS81-T2.
- (2) ⟹ (3) is J02-L1.
- (3) ⟹ (4) is J02-T1.
- (4) ⟹ (5): `χ(Γ₃) = 3`, and the ramified dyadic target is a matching.
- (5) ⟹ (1) is the residue bound (row 52). It can also be read directly: a target colouring pulls back to a colouring of `R`, which
  extends to `L` coset by coset.
- (2) ⟹ (1) directly: `x ↦ ⌊3θ̃(x)⌋` for any extension `θ̃` of `θ` to `L`. ∎

### 2.8 The advisor's three checks, and the sumset

| check | verdict | where |
|---|---|---|
| **the band collapse at a ramified prime above 3** | **not needed.** At a prime `𝔭 \| 3` with `e(𝔭\|3) > 1`, `A₃` has nilpotents, and "collapse to level one" would be a statement about `τ₃` on `J₃`. The repaired route never reads `J₃`: it evaluates `τ₃` only on `𝒩(T₃)`, whose preimages are unit vectors (L3). Whether `τ₃` vanishes on `J₃` is **not decided here** and not needed | L3, T1 step 4 |
| **C1(5)'s type bound through CL2's gluing to `R_F`** | **not needed**: CL2 is not used. The torsion part is extracted by FS81-T4's limit, which already lies in `Θ₃` (L1). The type bound needed is C1(5)'s own: `α = 0` on an order-3 layer at band 1/3, sharper than the sketch's `\|α\| ≤ 1/12` (S0A-3's band-1/4 value). If one insists on CL2 (L1's remark 2), S0A-7's density step must be repaired at complex places (`ℂ^×` is not compact). **`ℚ(α, √7)` has complex places**: `ℚ(α)` has one real embedding | L1 |
| **the parity-type step when `1/2 ∉ R_F`** | **closed**: the parity type on the dyadic norm-one set forces a stable dyadic prime **ramified** in `L/F` (L(F) = 2). An inert stable dyadic prime cannot carry it (`Σμ_{Q+1} = 0` with `Q + 1` odd). When `1/2 ∈ R_F`, `A₂ = 0` and the case is empty | T1 step 5; L4(b) |
| **the sumset (several stable primes above 3, with the archimedean part)** | **closed, and the archimedean part never enters** (τ is torsion). Several stable primes above 3: the symmetric sets `C_𝔪 ⊆ 𝔽₃` add to all of `𝔽₃` as soon as two are non-zero, so exactly one prime carries the colouring. The dyadic part is coupled jointly through L3 | T1 steps 2–4 |

### 2.9 The sketch, step by step

| step | verdict | note |
|---|---|---|
| 1 | TRUE | via FS81-T2 (T22 plus compactness) |
| 2 | TRUE for a point whose unit vectors are **all** of type (a); **GAP** as a case of a dichotomy, since a type is per layer | repaired by T1 steps 2–3 (the product set `𝒩(T₃) × 𝒩(T₂)`) |
| 3 | **GAP as stated**: "`R/3R` = the product over stable 𝔭 \| 3" is Lemma R(b), unproved outside `L/ℚ` Galois; the "collapse" at ramified 3 is unproved | replaced by L2 + L3 (reduced part only), which need no Galois hypothesis |
| 4 | TRUE (weak approximation for the rational torus), with a wording slip: the archimedean factor is a product of circles and, at complex places, of `ℂ^×`s | replaced by L3's finite-level lift, which is what the sumset actually needs |
| 5 | TRUE inside the sketch's global-type-(b) world; GAP outside it (a unit vector with `τ₃(u) = 0` may be of type (a)) | T1's joint form |
| 6 | TRUE | L4(a); exact at 27, 243 |
| 7 | TRUE | J02-T2; S2 and S3 at stage 3 |

### 2.10 Hypotheses used; finite degree; other subfields of ℝ

- **Uses `[F : ℚ] < ∞`** in two places: L2(a) (`R/pR` finite, `dim ≤ [L:ℚ]`, which the Teichmüller construction needs) and Lemma 1.1
  (`O_L` a finite `ℤ`-module, for integrality of `R·O_L`). L1, FS81-T2 and FS81-T4 hold for every `F ⊆ ℝ`.
- **No other hypothesis:**
  - no Galois condition on `L/ℚ`;
  - nothing about ramification of 3 in `F`;
  - no `√3`;
  - no non-bipartiteness;
  - no condition at 2 (the wall may stand or be broken; stable dyadic primes may be inert or ramified).
- **Every subfield of ℝ.** For arbitrary `F ⊆ ℝ`, `L(F)` is not defined here, and S1 does not extend as a statement about `L(F)`. It
  transfers in the only available form: `χ(F²) ≤ 3 ⟹ L(E) ≤ 3` for every number field `E ⊆ F`, since `χ(E²) ≤ χ(F²)`.
  - For algebraic `F`, the good primes of the finite subfields form an inverse system of non-empty finite sets. A stable `𝔽₃` prime
    restricts to a stable `𝔽₃` prime, and a stable ramified dyadic prime to a stable dyadic one that is ramified or inert. So a
    compatible choice exists by König's lemma — but the dyadic restriction step makes this **not** a clean statement. **Not claimed.**
  - For transcendental `F`, `[Fischer1990]` Thm 6 (G63) handles only purely transcendental extensions; FS-39's gap stands.

## Stage 3 — SAVED: S2 and S3

*Q9 of §1.1 resolved: `plans/STUB-chain-theorem.md` (FS-45) lists "Theorem 2.1 (`χ = 2 ⟺ L = 2`, all real number fields) | hand, GPT
Astra; read here | §2". The brief's address is correct; the theorem is Astra's.*

### 3.1 S2 — the conjecture's `L ≤ 4` clause for every real number field [hand; a composition]

*Statement (J02-T3).* For every real number field `F` with `L(F) ≤ 4`, `χ(F²) = L(F)`.

*Inputs.*
- **(U)** `χ(F²) ≤ L(F)`: the residue bound, row 52 [hand + tools], through Theorem A (row 57) and G56's dyadic trichotomy. Prior art
  `[Moorhouse2010]` §8.2 and §10.3, `[Madore2015]` Cor. 3.4. The field-level step is proved by hand (row 57's "not proved" is the
  kernel form).
- **(T2)** `χ(F²) = 2 ⟺ L(F) = 2`: GPT Astra's Thm 2.1 [hand; read here] (G55, row 63). **A second derivation of its ⟹**, through this
  record's L3:
  - a bipartite `F²` has the walk-parity character `π` with `π(U) = 1/2` and `2π = 0` (Astra's `φ`);
  - J02-T1 step 5 applies verbatim to `π` in place of `τ₂`, and finds a stable dyadic prime ramified in `L/F`, so `L(F) = 2`.
  - Astra's route applies Lemma 1.1 to `ker φ`; this one goes through the Teichmüller set. They share Lemma 1.1.
- **(S1)** J02-T2.

*Proof, by the value of `L(F)`.*
- **`L = 2`:** `χ ≤ 2` by (U), and `χ ≥ 2` since there is an edge.
- **`L = 3`:** `χ ≤ 3` by (U), and `χ ≠ 2` by (T2).
- **`L = 4`:** `χ ≤ 4` by (U), and `χ ≤ 3` would give `L ≤ 3` by S1. ∎

*What each clause rests on.*

| L | upper | lower | new here |
|---|---|---|---|
| 2 | (U) | an edge | — |
| 3 | (U) | Astra Thm 2.1 (or this record's second derivation) | — |
| 4 | (U) | **S1** | **yes: the clause was proved before only for fields containing √3 (Astra Thm 3.1) and for real quadratic fields (row 82 with `[Fischer1990]` Thms 8–10)** |

**Consequence for the frontier.** With the wall standing, `L(F)` is a finite rule read off the conjugation-fixed primes (G59). The
conjecture's testable range below the problem itself is now `L = 5` alone:
- outside multiquadratic `F ⊇ K`: ℚ(√47), ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3, √5);
- and `L = 6`, which is empty if the wall holds.

The FS-82 stub's question is closed, and so is the "`L ≤ 4` for real quadratic fields / with √3" caveat in G55, G74 and row 82.

### 3.2 S3 — `ℚ(α, √7)`, `α³ = α + 1` [hand + tools exact (PARI)]

*The arithmetic, by hand first, then in PARI* (`tools/crunch_j02_field.py`, output `data/fs91/j02/field-check.txt`).
- **At 3.**
  - `x³ − x − 1` has no root mod 3 (its values at 0, 1, 2 are 2, 2, 2), and `3 ∤ disc = −23`. So 3 is inert in `ℚ(α)`, with residue
    field `𝔽₂₇`.
  - `(7/3) = 1`, so 3 splits in ℚ(√7).
  - So `F ⊗ ℚ₃ = ℚ_{27} × ℚ_{27}`: **two primes, `e = 1`, `f = 3`, residue field `𝔽₂₇`**.
  - `27 ≡ 3 (mod 4)`, so both are inert in `L`, hence stable, with target `Γ₂₇`. **Neither has residue field `𝔽₃`.** PARI: both
    `e = 1`, `f = 3`, inert in `L`.
- **At 2.**
  - `x³ + x + 1` is irreducible over `𝔽₂`, so 2 is inert in `ℚ(α)`.
  - `7 ≡ −1 (mod 8)` and `−7 ≡ 1 (mod 8)` is a square in `ℚ₂`, so `ℚ₂(√7) = ℚ₂(i)`.
  - So `F ⊗ ℚ₂ = ℚ_8(i)`: **one prime, `e = 2`, `f = 3`, and `i` lies in its completion, so it splits in `L`**. No stable dyadic prime:
    the wall is broken and there is no dyadic target. PARI: `e = 2`, `f = 3`, split.
- **At 7.**
  - `x³ − x − 1 ≡ (x − 5)(x² + 5x + 3) (mod 7)`. The quadratic has discriminant `13 ≡ 6`, a non-square, and `7 ∤ −23`. So `7 = 𝔭₁𝔭₂`
    in `ℚ(α)`, with `f = 1, 2`.
  - 7 ramifies in ℚ(√7). So `F` has a prime with `e = 2`, `f = 1` (residue field `𝔽₇`, inert in `L` because `7 ≡ 3 (mod 4)`: stable,
    target `Γ₇`), and one with `e = 2`, `f = 2` (`𝔽₄₉ ∋ √−1`: split). PARI agrees.
- **Signature `[2, 2]`**: two real places and two complex ones (`ℚ(α)` has one real embedding).
- **Plants.**
  - `x³ − 2` for the cubic: 3 is totally ramified, residue `𝔽₃`, and "no stable `𝔽₃` prime above 3" fires.
  - `√11` for `√7`: `ℚ₂(√11) = ℚ₂(√3)`, and the dyadic prime is inert in `L`, so "no stable dyadic prime" fires.
  - Each also trips a second assertion: `cubic2` loses the `𝔽₇` prime, and `sqrt11` has a split prime above 3. Each fires its own
    target assertion (`data/fs91/j02/field-check-plants.txt`).

*Statement (J02-C1).* For `F = ℚ(α, √7)`: `Θ₃(ℤ[U_F]) = ∅`, `χ(F²) = 4` and `L(F) = 4`.

*Proof.*
- By the arithmetic, `F` has no stable prime above 3 with residue field `𝔽₃` and no stable prime above 2. So J02-T2 (4) fails.
- By J02-T2, (2) and (1) fail: `Θ₃(R_F) = ∅` and `χ(F²) ≥ 4`.
- The stable `𝔽₇` prime gives `χ(F²) ≤ χ(Γ₇) = 4` (row 52; `χ(Γ₇) = 4` is `[Moorhouse2010]` Table 6.1).
- `L(F) = 4`: `≤ 4` from the same prime, and `≥ 4` because J02-T2's (5) ⟺ (4) forbids `L ≤ 3`. ∎

*Remarks.*
1. **The conjecture's prediction at `L = 4` is met**, and the falsifier the FS-82 stub named (a non-additive three-colouring local at no
   prime) **does not exist.** The reason is now structural: every point of `Θ₃` has a torsion part in `Θ₃` (J02-L1), and a torsion
   point is local at one prime (J02-T1).
2. **What made this field look hard is not where the proof works.** The stub expected a three-colouring here to be "non-additive — a
   field-level slope with real (archimedean) parts". J02-L1 shows the archimedean part of a three-colour slope can always be dropped:
   the torsion part is itself a slope. So at three colours "additive" and "any" coincide **for existence**. (Not for the colourings
   themselves: FS81-T6's additivity of every slope is a stronger, per-point statement, left open here outside `d ≡ 3, 7 (mod 12)`.)
3. **Uses `√7` only through the arithmetic at 2, 3, 7.** No layer relation of the field and no finite configuration is used. The FS-82
   stub's route 3 (a finite `Θ₃`-empty configuration) was not run (logged below). It would give a finite witness of `χ ≥ 4`, which
   compactness guarantees exists and nothing here exhibits.

## Stage 4 — SAVED: the claim list, prior-art debts, C0 scored

### 4.1 The fixed claim list

`data/fs91/j02/lemma-statements.md` holds every lemma this record proves, stated verbatim with no proof, for J09's second phase: J02-L1,
L2, L3, L4, T1, T2 (= S1), C2, T3 (= S2), C1 (= S3), and the second derivation of Astra's Thm 2.1 ⟹.

**J02-C2 (additive colourings) [hand; a corollary of J02-T1].** For every real number field `F`:
- `F²` has an additive 3-colouring in `[Fischer1990]`'s sense (a homomorphism `R_F → ℤ/3` non-zero on `U_F`) iff `F` has a stable prime
  above 3 with residue field `𝔽₃`;
- `F²` has an additive 2-colouring iff `F` has a stable prime above 2 ramified in `F(i)/F`.

*Proof.*
- **Three colours, ⟹.** Put `τ = v/3`. Then `τ₂ = 3τ = 0` on all of `R`, so T1's case (ii) is impossible and case (i) gives the `𝔽₃`
  prime.
- **Two colours, ⟹.** Put `τ = v/2`. Then `τ₃ = −2τ = 0`, so T1's case (i) is impossible and case (ii) gives the ramified dyadic prime.
- **Both ⟸.** T1's ⟸ constructions are homomorphisms to `ℤ/3` and to `ℤ/2`. ∎

This generalises `[Fischer1990]` Thm 9, which covers quadratic fields at `N ≢ 2 (mod 3)`, to every real number field. It also gives
Fischer's Thm 1(iii) (2-colourable iff a ring homomorphism `C₀ → ℤ/2`) the local form Astra's Thm 2.1 gave it.

### 4.2 Prior-art debts

- **`[Fischer1990]`** (held, `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`). Its numbered statements (Thms 1, 3, 4, 7, 8, 9,
  10) and §1 were read this stage, in the text layer.
  - It has **no general criterion for additive three-colourability** of `F²` over a number field. Thm 9 is the quadratic case, and
    Thm 10 is the quadratic case at `N ≡ 3 (mod 8)` and `N ≡ −1 (mod 24)`.
  - Its §1 poses the general question verbatim: *"This still begs the general question, however, whether some algebraic criterion can be
    found to determine the chromatic number of F² where F is a subfield of R, of finite degree over Q."* J02-T2 and T3 answer it at
    `χ ≤ 3` and at `L ≤ 4`: **a candidate for `CLOSED-QUESTIONS.md`**, for the front-page lane to judge.
  - The proofs of Thms 1–10 were not re-read.
- **`[Johnson2000]`, `[Johnson2006]`**: not held, not read. Row 82's standing debt carries over. **Nothing here is claimed new or first**
  while they are unread.
- **Not run:**
  - a zbMATH gate for the general statement (queries in the discipline's words — "additive coloring", "unit distance graph", "number
    field", "chromatic number three");
  - the citing works of `[Fischer1990]`.

  Both are owed before any claim of novelty.
- **Credit.** J02-L2 and L3 are GPT Astra's Lemma 1.1 and §3.1–3.3, extended from `p = 3` and `√3 ∈ F` to every prime and to `R/6R`.
  The Teichmüller subring and the Hilbert-90 lift are his. **The composition with FS-81's torsion character, and the joint 2-and-3 lift
  that couples the parity type to the order-3 type, are this record's.**

### 4.3 C0 scored

| item | C0 | outcome |
|---|---|---|
| S1 | 0.85 | **TRUE** (J02-T2) |
| S2 | 0.83 | **TRUE** (J02-T3) |
| S3 | 0.83 | **TRUE** (J02-C1) |
| step 2 (a mixture covered by the sketch: 0.3) | — | not covered; repaired |
| step 3 (provable as stated from held inputs: 0.4) | — | not proved as stated; bypassed, not needed |
| step 4 ("the archimedean circle" a wording slip: 0.9) | — | confirmed: `ℚ(α, √7)` has two complex places |
| step 5 (as stated: 0.6) | — | GAP outside the global-type world; repaired |
| registered outcome "S1 TRUE by a route repairing steps 2–5" (0.85) | — | **occurred** |

The C0 was written after the route had formed (§1.2's honesty note), so its calibration value is low.

### 4.4 Audit of the result (standing rule 4: a liked result audited as hard as a disliked one)

**The load-bearing inputs, weakest first.**
1. **FS81-T3's cell list** (C1(5), hand + tools exact; FS73-T40's list reproduced on a second code path). A missing cell at band 1/3
   would break J02-L1. Its two-derivation grade stands.
2. **FS81-T4's limit** (hand, two derivations). Re-read here step by step (§2.2).
3. **Astra's Lemma 1.1** (hand, one mind before this record). Re-derived here line by line (§2.3 (b)).
4. **Weil**, external. Checked exactly at the two smallest cases, 27 and 243.

**Where a defect would hide.**
- The only step without a precedent is T1's step 2: the product set `𝒩(T₃) × 𝒩(T₂)` inside the image of `U`. It rests on L3's lift,
  whose one non-trivial line is `[u] = b/c(b)`, from `u·c(a) = a` reduced mod `6R`. `b` and `c(b)` are units of `T`, hence of `R/6R`
  (same 1).
- **What a wrong-reason pass would look like:** a factor `k_𝔪` of `T₂` with trivial involution but no ramified prime behind it. L2(d)'s
  contrapositive (c) excludes it: an unramified stable `𝔓` gives a non-trivial involution on all of `κ_𝔓 = k_𝔪`.

**Grade.** One mind (J02) until J09's blind derivation lands. Stated as **[hand]**; row 82's grade ("two independent derivations")
needs J09.

### 4.5 Proposed edits (for the front-page lane; not made here)

- **`LEDGER.md`, a new row:** "Three colours obey the local–global conjecture over every real number field" — J02-T1, T2, T3, C1, C2;
  grade [hand], one mind until J09. Include "Not claimed: new (Johnson unread); a finite witness at `ℚ(α, √7)`; anything at four colours."
- **`CLAUDE.md` § Frontier:**
  - "The target" (2): the proved range becomes "L ≤ 4 for every real number field".
  - Items 10 and 14 are updated; `ℚ(α, √7)` leaves the exposed predictions (met).
- **`CLAUDE.md` grokkings:**
  - G55's "without √3 the half it lacked is row 82 …" sentence gains the general form.
  - G74's "the residual three-colour case … (FS-82)" is closed.
  - G48's falsifier list drops `ℚ(α, √7)`.
  - A possible new *Do* for G74 or G55: **at three colours, the torsion part of a slope is a slope, so decide three colours by
    additive colourings, i.e. by the primes above 2 and 3.**
- **Stubs:**
  - FS-82's stub gets a CLOSED banner (J02-C1).
  - FS-75 (the three-colour criterion in the kernel) may be re-aimed: J02-T2's chain is L1 (T4), L2 (Lemma 1.1), L3 and a finite sumset,
    and every leaf is finite algebra except FS81-T2's compactness and T22.
  - FS-91/M1 (F2, the character local–global theorem at `k = 4, 5`): J02-L3's Teichmüller lift couples the **reduced** parts of `R/NR`
    at any squarefree `N`. At four colours the dyadic part has order up to 8 (S0A-3), so the non-reduced level at 2 is where it would
    need more.

### Theorems this phase proved

| id | statement (short; verbatim forms in `data/fs91/j02/lemma-statements.md`) | grade | address |
|---|---|---|---|
| J02-L1 | torsion extraction: `Θ₃(R_F) ≠ ∅ ⟹ Θ₃(R_F) ∩ T₆ ≠ ∅`, every `F ⊆ ℝ` | hand (composition of FS81-T3, T4) | §2.2 |
| J02-L2 | `R/pR` finite, its maximal ideals stable, full residue fields at unramified stable primes, every `p` | hand (Astra Lemma 1.1, §3.1–3.2, extended) | §2.3 |
| J02-L3 | Teichmüller section of `R/6R` and the joint Hilbert-90 lift: `𝒩(T₃) × 𝒩(T₂) ⊆ image of U` | hand (Astra §3.3, extended) | §2.4 |
| J02-L4 | norm-one functionals: (a) three-colouring at `3^f` iff `f = 1`; (b) none at `2^f` | hand + external (Weil) + tools exact (27, 243, `Q ≤ 32`) | §2.5; `tools/crunch_j02_additive_check.py` |
| J02-T1 | torsion three-colour band characters exist iff a stable `𝔽₃` prime or a stable ramified dyadic prime | hand | §2.6 |
| J02-T2 | **S1**: `χ(F²) ≤ 3 ⟺ Θ₃ ≠ ∅ ⟺ Θ₃ ∩ T₆ ≠ ∅ ⟺` (the two prime types) `⟺ L(F) ≤ 3`, every real number field | hand (composition) | §2.7 |
| J02-T3 | **S2**: `χ(F²) = L(F)` whenever `L(F) ≤ 4`, every real number field | hand (composition) | §3.1 |
| J02-C1 | **S3**: `ℚ(α, √7)`: `Θ₃ = ∅`, `χ = L = 4` | hand + tools exact (PARI) | §3.2; `tools/crunch_j02_field.py` |
| J02-C2 | additive 3-colourings iff a stable `𝔽₃` prime; additive 2-colourings iff a stable ramified dyadic prime | hand (corollary of T1) | §4.1 |
| J02-A2.1′ | second derivation of Astra Thm 2.1 ⟹ via L3 | hand | §3.1 |
