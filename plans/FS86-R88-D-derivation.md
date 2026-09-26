# Row 88's question — J28D's derivation record (crunch job J28D, de Bruijn, Opus 5.5, 2026-09-25)

*Brief: `data/crunch-2026-09-25/briefs/J28D-row88-derivation.md` (with `STANDING-RULES.md`). Plan: `plans/FS86-row88-rigidity.md` §S.0–S.2,
§M. Targets T-A, T-B1, T-B2, T-C, T-C(A), T-C′ (verbatim in §S.1 there; quoted in §1.1 below). Blind verifier J28V: not read, not messaged.
Data `data/fs86r88/j28d/`; tools `tools/crunch_j28d_*.py`. Grades are `CLAUDE.md` § Notation's.*

## Theorems this phase proved

*(one line each; filled per stage)*

- Stage 1: none (quotation check and priors).
- **T-A (i)–(vi)** — the decomposition, TRUE; (i) with `τ` read as commuting with conjugation (automatic for type (B)); (v) with the clopen correspondence proved in place. [hand] §Stage 2
- **T-A1** — `T-B1 ⟹ Q-tr ⟹ T-B2`. [hand] §Stage 2
- **T-A2** — a FALSE for T-B1 or T-B2 exhibits a non-pullback, so `F(R) = 0`. [hand] §Stage 2

## Stage 1 — SAVED (quotation check, C0, the log)

### 1.1 The quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | §S.0's six definitions and §S.1's six statements, with the controls paragraph (34 non-empty lines) | `plans/FS86-row88-rigidity.md` §S.0–S.1 | **verbatim**: `diff` of the brief's block against the plan's block is empty (the two blocks extracted by `awk`, blank lines dropped) |
| Q2 | S2's gloss "real fields with exactly one stable place whose local planes have `χ_f ≤ 4`, that place four-tight at every level" | `plans/FS86-derivation.md` Notation | **verbatim** (the source breaks the line after "stable place") |
| Q3 | J21-MX, "a compact factor with `λ* < 1/(k−1)` can be deleted from a Borel `k`-colouring of a product" (plan §0.3) | `plans/CRUNCH-2026-09-25-INDEX.md` line 560 | **verbatim**; the theorem itself read in `plans/M3-S1D-windows-five.md` §3.2 |
| Q4 | Theorem C "under H*", D's `𝒳 = T + A + Fin` | `plans/FS86-V-D-verification.md` § VD-C (2) | matches; D's proof is the spectral one with weights, **not** the continuity route of §S.2 |
| Q5 | C14 "with `[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470`", C14′ "proper off a null set" | `plans/FS86-C-Coxeter.md` Round 2 step 5; `plans/FS86-derivation.md` §9 | matches; **scope note carried forward**: C14 reads the tight place at finite level `m` only (its "Not covered (1)": infinite depth), and C14′'s format is "`W(z) ≠ W(z+τ)` whenever `z`, `z+τ` both lie in a conull `Ω`" — not the edge-a.e. format a random extension produces (used in §3) |

**One conflict in the instructions, logged:** standing rule 6 says "never push"; the brief and the launching message say "push; never
force-push". I follow the brief (the job-specific instruction, restated by the owner at launch).

### 1.2 C0 — probabilities per claim (written after reading the sources and one mental pass, before any written derivation)

| claim | TRUE | FALSE | GAP | note |
|---|---|---|---|---|
| T-A (i)–(vi) | 0.90 | 0.03 | 0.07 | (v) rests on the Furstenberg-correspondence lemma for clopen cylinders; (i) needs `τ(U) = U` |
| T-C | 0.55 | 0.05 | 0.40 | the plan's step (2)–(3) cannot use C14′ or J21-MX as black boxes (formats differ); a stationary count is needed |
| T-C(A) | 0.50 | 0.05 | 0.45 | tied to T-C's count |
| T-B1 | 0.05 | 0.01 | 0.94 | a FALSE is a non-pullback, i.e. decides row 88 "no" |
| T-B2 | 0.10 | 0.01 | 0.89 | the same: a FALSE decides row 88 "no" |

*Coherence note on the plan's §P (for the owner):* P-TB1 prices FALSE at 0.10 and P-TB2 at 0.15, while P-decide prices "row 88 decided no" at
0.02. A FALSE for either (a converging family of non-pullbacks; a sparse defect) exhibits a non-pullback four-colouring, hence `F(R) = 0` by
the frame — the two sets of numbers cannot both be right.

### 1.3 Would-have-searched-here log (running)

- (stage 1) Would have sampled colourings of lattice balls over ℚ(√59) agreeing with a pullback on a patch, to price T-B1 and T-B2. Not done
  (ban); both are posed as derivations in §4.

## Stage 2 — SAVED (T-A)

*Setting:* `F` as in T-A (the frame holds: `F(R) ∈ {0, P(R)}`, `P(R) = R ∩ 𝔓⁴`, every periodic four-colouring a pullback); `ρ₄ : R → O/𝔓⁴`
the reduction, onto (Lemma R (b); for ℚ(√59) also VD-1); `S₄ = U mod 𝔓⁴ = T mod 𝔓⁴` (`U` dense in `T`). Translation `(t·c)(z) = c(z − t)`.

**Verdict: T-A (i)–(vi) TRUE [hand], with one scope repair in (i).**

**(i) — TRUE, given `τ(U) = U` for every `τ` in the group (automatic for type (B)).** *Finite:* `γ ↦ γ∘ρ₄` is a bijection from the
proper four-colourings of `P₄` onto Pull (`ρ₄` onto), so `|Pull| = 1,179,936` (row 67). *In `X₄`:* `ρ₄(U) ⊆ S₄ ∌ 0`, so every edge maps to an
edge. *Closed:* finite in a Hausdorff space. *Translations:* `t·(γ∘ρ₄) = γ(· − ρ₄t)∘ρ₄`. *Rotations:* `u ∈ U` is a unit at `𝔓` and `uT = T`,
so `x ↦ ρ₄(u)x` is an automorphism of `P₄`. *`τ`:* the action `(g·c)(z) = c(g⁻¹z)` preserves `X₄` only if `g` maps edges to edges, i.e.
`τ(U) = U`. "Preserving `R`" does not obviously give this: `τ(U)` is the norm-one group for `τcτ⁻¹`, equal to `U` when `τ` commutes with `c`.
**Repair (scope):** read `Aff_F`'s `τ` as ranging over automorphisms of `F(i)` commuting with complex conjugation (equivalently, preserving
`U`). For type (B), `Gal(F(i)/ℚ) ≅ V₄` is abelian, so nothing is lost. Such a `τ` maps stable primes to stable primes and tight ones to
tight ones, so it fixes the unique tight `𝔓`, extends continuously to `O`, induces an automorphism of `O/𝔓⁴` preserving `S₄`, and maps
Pull to Pull.

**(ii) — TRUE.** *Subgroup:* `μ{c(0) = c(δ₁)} = 1` and, by invariance, `μ{c(δ₁) = c(δ₁+δ₂)} = μ{c(0) = c(δ₂)} = 1`; so
`δ₁ + δ₂ ∈ F_μ`; `−δ` by invariance. *`U`-stable:* for `u ∈ U` and translation-invariant `ν`, `μ := (u⁻¹)_*ν` is translation-invariant
(`t·(u⁻¹·c) = u⁻¹·((ut)·c)`), and `μ{c(0) = c(δ)} = ν{c′(0) = c′(uδ)}`; so `δ ∈ F_μ ⟹ uδ ∈ F_μ`. Hence an ideal (`R = ℤ[U]`) — §M.1's
point that `Aff_F`-invariance of `μ` is not needed is right. *`F ⊆ F_μ`:* a forced difference holds for every colouring. *`F_μ ⊆ P`:* the
uniform measure on the finite translation orbit of a periodic colouring is invariant and charges each point. *Dichotomy:* if `F_μ ≠ 0` it has
finite index (V2), so every invariant `μ` is a.s. `F_μ`-periodic (countably many `δ`), hence a.s. a pullback (frame); pullbacks identify
exactly `R ∩ 𝔓⁴` (`P₄` is pairwise free, row 67), so `F_μ ⊇ R ∩ 𝔓⁴ = P(R)`, and `F_μ = P(R)`.

**(iii) — TRUE.** ⟹ is (ii)'s dichotomy step. ⟸: every invariant `μ` carried by Pull gives `μ{c(0) = c(δ)} = 1` for `δ ∈ R ∩ 𝔓⁴ ∋ 4`.

**(iv) — TRUE.** ⟹: `F(R) ≠ 0` gives `F(R) = P(R)`, so every colouring is `R ∩ 𝔓⁴`-periodic, hence a pullback: `X₄ = Pull`, and Q-μ holds and
Q-tr is vacuous. ⟸: if `F(R) = 0` then `(0, 4)` is not forced, so some `c` has `c(0) ≠ c(4)`, and `c ∉ Pull`; by Q-tr `c` is not transient, so
some invariant measure on its orbit closure is not carried by Pull, against Q-μ. So **Q-μ ∧ Q-tr ⟺ `X₄ = Pull` ⟺ `F(R) ≠ 0`.**

**(v) — TRUE, given the correspondence lemma (standard; proof included).** *Lemma CL (clopen correspondence):* for a countable abelian group
`R` acting on a compact space, a point `c`, and a clopen `C`, with `V = {t : t·c ∈ C}`: `d*(V) = max{μ(C) : μ` invariant on `O(c)‾}`, where
`d*(V) = lim_n sup_t |V ∩ (F_n + t)|/|F_n|` for a Følner sequence `(F_n)` (the limit exists and is independent of the sequence). *Proof:*
≥ — given `μ` with `μ(C) = a` and finite `F`, `∫ |F|⁻¹Σ_{g∈F} 1_C(g·x) dμ = a`, so some `x ∈ supp μ ⊆ O(c)‾` has average `≥ a`; that set of
`x` is clopen, so some `t·c` lies in it: `|V ∩ (F + t)| ≥ a|F|`. ≤ — pick `t_n` attaining the sup on `F_n`; the averages
`|F_n|⁻¹Σ_{g∈F_n} δ_{(g+t_n)·c}` are asymptotically invariant; a weak-* limit is invariant, lives on `O(c)‾`, and gives `C` the limit value
(`C` clopen). ∎ *Then:* `C_B = {x : x|_B ∉ Pull|_B}` is clopen, and `X₄ ∖ Pull = ⋃_B C_B` over an exhaustion (a colouring all of whose
finite restrictions are pullback restrictions is a pullback: Pull is finite, so one `p` agrees on a cofinal family of `B`). So `μ` is
carried by Pull iff `μ(C_B) = 0` for every `B`, and transience of `c` is `d*{t : (t·c)|_B ∉ Pull|_B} = 0` for every `B`, by Lemma CL.

**(vi) — TRUE.** If `c ∉ Pull` is transient, `O(c)‾` carries an invariant measure (amenability), carried by Pull, so some `p ∈ Pull ∩ O(c)‾`;
`p` isolated means `{p}` is open, so `t·c = p` for some `t`, and `c = (−t)·p ∈ Pull` — a contradiction. So Q-tr. Then (ii)–(iv): `F_μ ≠ 0 ⟹`
Q-μ `⟹ F(R) ≠ 0 ⟹ F = P = F_μ`; `F_μ = 0 ⟹ F ⊆ F_μ = 0`. ∎

**Two consequences recorded (hand, from the above):**
- **T-A1 (the hierarchy).** `T-B1 ⟹ Q-tr ⟹ T-B2`. The first is (vi). For the second: if `D = {c ≠ p}` has `d*(D) = 0`, every invariant
  measure on the orbit closure of the pair `(c, p)` in `X₄ × Pull` is carried by the diagonal (`λ{x(z) ≠ q(z)} ≤ d*(D) = 0` for each `z`), and
  invariant measures on `O(c)‾` lift to it, so `c ∈ Pull` or `c` is transient; under Q-tr, `c = p′ ∈ Pull`, and `{p′ ≠ p}` is a union of
  cosets of the finite-index `R ∩ 𝔓⁴`, so `d* > 0` unless `p′ = p`.
- **T-A2 (FALSE decides the question).** A FALSE for T-B1 (non-pullbacks converging to `p`: a converging sequence in the finite Pull is
  eventually constant) or for T-B2 (a sparse defect: `c ∈ Pull` would make `D` a union of `R ∩ 𝔓⁴`-cosets) exhibits a colouring outside
  Pull, so `F(R) = 0`. This is the coherence note of §1.2.

**Controls (P-controls) read against T-A.** *ℚ(√11):* outside T-A's hypotheses — the frame's "every periodic colouring a pullback" fails
(periodic non-pullbacks exist there, FS86-VX-11 and `Γ₇`); C9's `⌊4(θ + s)⌋`, `s` uniform, is an invariant measure not carried by Pull
(non-periodic for every `s`), so Q-μ fails there, as the plan says. *K:* two tight places; with Pull read as the union of the two places'
pullbacks, `X₄ = Pull` per coset (VK), and both halves hold. *ℚ(√2,√3):* in S2 (frame argued, row 93) and rigid given T721, so `X₄ = Pull`.
**P-controls met.**

### Would-have-searched-here log (stage 2)
- None: T-A is soft dynamics.
