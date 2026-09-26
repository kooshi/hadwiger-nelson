# FS103-V1 — blind verification of FS-103's claim list (the collapse)

*Job FS103-V1 (Coxeter, verifier), Opus 5.5, 2026-09-26. Brief `data/fs103/briefs/V1-collapse-verifier.md`; standing rules
`data/fs103/briefs/STANDING-RULES.md`; the fixed list `data/fs103/claims.md`. Blind: nothing on the brief's fence list (nor the owner's two
additions of 2026-09-26: `plans/FS103-F-*.md`, `data/fs103/fs103-f/`, `tools/fs103_f_*`, `data/fs103/briefs/F103-*.md`, commit bodies "FS103-F…")
opened before stage 3's commit.*

## Theorems this phase proved

*(filled at stage 3; one line each, grade, address)*

## Stage 1 — SAVED (quotation check, C0, wrong-reason lines and controls)

### 1.1 Quotation check of `data/fs103/claims.md` (standing rule 5)

| item | source | result |
|---|---|---|
| D-RUL, D-STAB, D-GV, D-THK (c), D-CP (b), D-SP, D-NY's `UD(ℝ²)` gloss, the spectral-measure gloss in D-TAE | `plans/FS100-BC-verification.md` §1.2 | fenced — deferred to stage 4 |
| D-THK (a), D-M's quoted `χ_µ` gloss | `plans/M3-derivation.md` header | fenced — deferred to stage 4 |
| D-THK (b), D-NY, D-CP (a), C-LB's quoted clause | wanted-poster §3, §3.2 | fenced — deferred to stage 4 |
| D-USE (both clauses) | `CLAUDE.md` § Notation | **verbatim** |
| D-TAE (first sentence) | `plans/R88-derivation.md` l. 21–23 | **verbatim** |
| D-MR | `LEDGER.md` row 120 | **verbatim** |
| D-S | `CLAUDE.md` G64 | **verbatim** |
| `F_dG` gloss ("span K(√5,√7)") | `CLAUDE.md` G43 | **verbatim** |
| I-MR's grade bracket | row 120 | **verbatim** |
| FS100-PE2, FS100-EFP (I-MR's components) | `plans/FS100-derivation.md` l. 189, 160 | **verbatim** (the list quotes the statement clauses only; the `; equivalently …` / `; hence EF_F` tails are omitted, not altered) |
| I-C′ | row 100 | **verbatim** |
| I-RU | `plans/FS84-SI-D-derivation.md` §4.1 | **verbatim**; its stage-4 verdict line scopes it "for every real number field, every finite `S`" (not quoted in the list; recorded here because C-LB needs that scope) |
| I-SEL | row 124 | **verbatim** |
| I-EXT4 | `plans/R88-derivation.md` l. 114 (R88-TC-ext) | **verbatim** |
| I-MX | sealed | deferred to stage 4 |
| I-MERGE, I-CP57's upper bound | `plans/FS100-X21V-verification.md` | fenced — deferred to stage 4 (row 125, open, restates I-MERGE: "`G × G` is CP-`k`-colourable iff `G` is" — consistent) |
| I-CPUP | row 125 | **verbatim** |
| I-CP57 lower half (`m₁(ℝ²) ≤ 0.246989`) | row 92 | the number verbatim |
| I-WEIL's X26B-L1 quote | row 123 | **verbatim** |
| C-dG-PL's quotes "no prime below 131 is usable"; "first usable primes 131, 479" | `CLAUDE.md` G43; row 53 | **verbatim** (the second is row 53's, not 52's) |
| C-F1-GEN, C-635-PL, C-dG-F1, C-CPM | `plans/STUB-collapse-cp-plane.md` | fenced — deferred to stage 4 |
| C-S | `plans/RERANK-2026-09-26.md` §1.1 | fenced — deferred to stage 4 |

**One note on the list itself:** `plans/FS100-derivation.md` l. 277 (open) carries two constants I use as controls: "`λ*(Γ₁₁) = 0.476413`,
`λ*(Γ₁₉) = 0.380486 > 1/3`"; row 110 carries "59 has ratio `0.199119854095` exactly".

### 1.2 C0 — each claim in my words, my wrong-reason line, my control

| claim | in my words | wrong-reason pass would look like | my control |
|---|---|---|---|
| **C-LB** | For totally real `F` with `R = O′` and every stable place `k`-thick: a proper `k`-colouring of `F²` yields either a CP `k`-colouring of the real plane's unit-distance graph, or a rotation-invariant, `E`-null, positive finite measure on `R̂` whose pairing with evaluation at 1 is negative. | (i) treating the spectral projection onto `T + A` as simplex-valued without proving it is a conditional expectation (the bound `≥ −1/(k−1)` then has no reason); (ii) transferring properness from `U` to the closed edge set without `U`'s density in it; (iii) (B)'s `τ(E) = 0` asserted without R-U; (iv) a selection over the compact places that would still run with a non-thick place present, or reads only level one; (v) using MR where the claim has none. | **Known answers at `k = 4`, fixed before deriving** (from `LEDGER.md`): (K1) ℚ(√167) — `N₄ = ∅` (first stable place 23, row 115: `Γ_p` has `λ* < 1/3` "from 23"), so the chain with MR and `χ_CP ≥ 5` must give `χ ≥ 5`: row 123 / FS100-167's second route. (K2) ℚ(√11) — `χ = 4` (row 73) with the stable 7 (`Γ₇`, not 4-thick): the chain must **not** refute four colours; it must stop at the selection over `G₇`, and its (A) must then be `UD(ℝ²) × G₇`, which does carry a CP 4-colouring. Secondary: ℚ(√47) (`χ = 5`, row 121) with `N₄ = {11}` (`λ*(Γ₁₁) = 0.476`). **Arithmetic-free control of the selection step:** `K_{k+1} × K_k` is `k`-colourable while `K_{k+1}` is not; `K_k` has `λ* = 1/(k−1)` exactly, so a selection lemma must fail at equality — strictness must be used. |
| **C-CPUP** | The plane's chromatic number is at most the CP one, and a subfield's is at most the plane's. | restricting a CP colouring to all of `ℝ²` (uncountably many edges; "a.s. proper at each edge" does not give one proper realisation). | the argument must pass through a countable `F` and de Bruijn–Erdős; a proof with no countability step is the wrong one. |
| **C-635-PL** | 635087 is a prime `≡ 7 (mod 8)`; every prime `≡ 3 (mod 4)` below 103 is inert in ℚ(√635087); the stable places are those above split or ramified primes `≡ 3 (mod 4)`. | checking inertia by Kronecker symbol only, never the dyadic place or the ramified place; a script whose plant cannot fire. | the same script on ℚ(√167) must return first stable place 23 and dyadic split; plant: replace 635087 by a number `≡ 3 (mod 8)` (dyadic place then stable) and a number with an early split prime. |
| **C-635-THK** | Every stable place of ℚ(√635087) has full-depth mixing constant `< 1/5`. | Weil at level one only (higher levels, the ramified place's `e = 2` tower, and dyadic places forgotten). | my level-one spectrum code must reproduce `λ*(Γ₁₁) = 0.476413`, `λ*(Γ₁₉) = 0.380486`, `λ*(Γ₅₉) = 0.199119854095`. |
| **C-635-F1** | Given MR at ℚ(√635087): its plane, the real plane and the CP plane have one chromatic number. | applying C-LB at `k = 6` only, never at `k = χ(F²)` (which may be 5); or equality with `χ(ℝ²)` with no C-CPUP. | ℚ(√167): the same assembly must stop (`N₆ ∋ 23, 43`, so C-LB's hypothesis fails at `k = 6`; row 125 keeps the factors `G₂₃ × G₄₃`). |
| **C-635-TF** | ℚ(√635087)'s plane has no unit triangle; with C-635-F1 and `χ(ℝ²) ≥ 6` a finite triangle-free unit-distance graph of chromatic number ≥ 6 exists. | "no √3" asserted without the `ζ₆ ∈ L` step; the finite graph asserted without de Bruijn–Erdős. | ℚ(√3,√5): `√3 ∈ F`, triangles present, the argument must refuse to call it triangle-free. |
| **C-dG-F1** | Given MR at `F_dG` and its place list: `χ(ℝ²) = χ_CP(ℝ²) = χ(F_dG²)`. | de Grey's `χ ≥ 5` read as thickness; 11's residue degree 2 missed; dyadic places not classified. | Heule's field K(√5): sealed at 5 by `Γ₁₁` (`λ* = 0.476 ≥ 1/5`, not 6-thick) — the assembly must stop there. |
| **C-S** | (a) S rules out a six-chromatic plane; (b) over totally real number fields, given MR, "no field is six" ⟺ `χ_CP = 5` or (`χ_CP = 7` and no field with a non-6-thick place is exactly six); (c) is the residual family finite; (d) what is missing beyond. | (a) treated as needing C-dG-F1 (for subfields of ℝ it is trivial — ℝ is one; the number-field form is what needs it); (c) counting residue fields and calling that counting local planes. | (c): ℚ₂₃ and ℚ₂₃(√23) both give stable places with residue field `𝔽₂₃`, different towers. |
| **C-FMT, C-CPM** | Format comparisons between CP, measurable-a.e., measurable and Borel chromatic numbers. | a Følner-limit construction assumed to keep continuity in probability. | a measurable colouring whose local `L¹` modulus of continuity degrades at infinity: its box averages need not converge to a process continuous in probability. |

### 1.3 Would-have-searched-here log

*(none yet)*
