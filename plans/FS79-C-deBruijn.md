# FS-79 competition — de Bruijn's working file

*Competitor: de Bruijn (Opus 5.5), 2026-09-24. Brief: `BRIEF-deBruijn.md` (same directory). Only writer: me. Poros may read this
file. Retractions are kept, struck through or marked **RETRACTED**, never deleted. Every claim carries class, rank (`r`, and `ρ₄` for a
non-colourable graph), kind, grade and a named inhabitant.*

## 0. Status (kept current)

- First route written (§1) before any message to Poros or Coxeter.
- C1: proved, with the exact table (§2). Completed in §2a: Lemma D, Lemma S, "iff", and the format is empty on all of 𝒞. Extended to
  every `k` in §2b (C1ₖ: none at `k ≥ 5`). C1-L, the language form, is proved and checked on de Grey's exact language and on
  `L21cc6506` (§4). C2 is proved (§3), with its rank-1 data in §3a. The outcome by face is in §7.
- Poros's scoring:
  - C1 (complete form): met on OBS-N1–N4.
  - Lemmas D and S: read, and they close.
  - C2: read, and it closes.
  - The §5 challenge reading is logged as a reading.
- The exhaustive rank-1 scan is done (§3a): 0 counterexamples in 2,706 sets. Its process group is verified gone and the lock is freed.
- **A channel incident** (§6): Poros's interim hand-back reached me. I reported it to the owner at once and fenced off what it
  contained.
- Retractions so far: **2**:
  1. C1 proof step 3 as first written. The gap was found by Poros; it is replaced by Lemma D, §2a.
  2. The "cross squares" derivation in §2b. I found it myself; it is replaced by the relabelling argument, and the conclusion is unchanged.

## 1. First route (written before consulting anyone)

**Listening first.** At three colours the answer came from `K₃`'s loop: a height. At four colours T29 says the square complex of `K₄` is
`ℝP²` (no loop worth having), and yet `[MooreNewman2000]` has a two-dimensional height on the triangular lattice, and `§PA.3` concluded
"what a four-colouring carries depends on the relation cycles". Before choosing a face I want the exact answer to the question that
sentence poses: **which generating sets carry a four-colour height, and why?** If the answer is "almost none", then (Q-obs) at ℚ(√167)
cannot be won with heights and the discrete part has to come from somewhere else; if the answer is "many", heights are the tool.

**R1 (Q-obs, a no-go of a named kind, with its positive side).**
- *Format, fixed first (OBS-N1).* **Kind 1_edge**, edge-local heights: a family `A = (A_s)_{s∈S}`, `A_s : {(a,b) : a ≠ b} → ℝ^m`, with
  `A_{−s}(b,a) = −A_s(a,b)`, satisfying the cocycle identity on **every locally admissible colouring** of every commutator square
  `x, x+s, x+s+t, x+t` (locally admissible: proper on the square's induced subgraph, diagonals included) and of every relation cycle.
  It defines the cocycle `a(s, c)(x) = A_s(c(x), c(x+s))` on `X(Λ,S,4)`; a certificate is such an `A` plus a proof that the admissible
  (winding, slope) set is empty. Soundness: the identity on locally admissible patterns implies it on every colouring.
- *Claim H (to prove):* modulo vertex coboundaries `g(c(x+s)) − g(c(x))` and constants `σ_s` (homomorphisms), the space of kind-1_edge
  cocycles is decided by the **non-triangle graph** `𝒢_S` on `S` (`s ~ t` iff `s ≠ ±t` and `s − t ∉ S`): if every `s` lies in the
  component of `−s`, every such cocycle is trivial. Mechanism, sketched: the square pattern `abcb` forces `A_s − A_t` constant along
  `𝒢_S`-edges; `s ~* −s` forces the symmetric part of `A_s` constant; the always-admissible pattern `abcd` then makes the antisymmetric
  part a closed 1-cochain on `K₄`'s square complex `ℝP²`, hence exact.
- *Predicted consequences:* triangle-free `S` (every ℚ(√167) lattice) — trivial; de Grey's lattice — trivial (cross-hexagon squares
  connect `u` to `−u`); the grid — trivial (the edge-local shadow of `[CGHO2025coh]` Thm 1.1); the triangular lattice — not covered
  (`𝒢_S` splits into `{e₁,e₂,e₃}` and its negative: Moore–Newman's orientation). If this holds, **a four-colour edge-local height lives
  essentially only on the triangular lattice**, and G71's "with triangles there is a height" is too generous.
- *Reading to test:* with triangles, `K₄`'s clique complex is the flat tetrahedron, the orbifold `ℝ²/p2`; Moore–Newman's height is its
  developing map, and four-colourings of the triangular lattice are "up-step" maps `T → T′` reduced modulo `2T′` (`T′/2T′ ≅ V₄`).
- *The hard step (OBS-N4 scope):* from edge-local to window-local cocycles.

**R2 (Q, rank 1): a reflection lemma.** A rank-1 counterexample to C3-inherit needs rigid phases (single-cycle components of the
window-state graph) and a wall between them (T30's criterion); `D = −D`, so reflection maps a wall `C → C′` to `C′ᴿ → Cᴿ`, and two
achiral ends would close a cycle. Claim: **every rank-1 counterexample to inheritance at `k` colours needs a chiral rigid phase**, so
never an additive one (additive colourings are achiral). Cheap; checks a reading (Coxeter's, FS73 §8) in rank 1.

**R3 (Q-rig aim, a reading only).** For a single hexagon system the developing map is a simplicial map of triangulated planes, so the
triangle-orientation density equals `det` of the height slope for every **ergodic** measure: a quadratic relation between two window
frequencies, so an admissible set that is **not convex**. Whether that can force de Grey's stripes (Hubai) is the question; Claim H
says the stripes cannot come from a height on the whole lattice.

**Order.** R1 first (derivation, then an exact check of the linear system on the controls and on every instance), R2 second, R3 only if
R1 lands early.

## 2. Claim C1 — edge-local four-colour heights live only where the non-triangle graph splits (R1, first half)

**Class and rank.** All of 𝒞 (any `r`, any `S`), stated in canonical form `Λ = ⟨S⟩`. The corollaries name their subclasses. **Kind:** 1_edge
(below). **Face and shape:** (Q-obs), a no-go of the *trivial* shape (OBS-N2) for the fixed format 1_edge, which implies the *blind*
shape for that format.

**The format (OBS-N1, fixed before the claim).** *Kind 1_edge.* A certificate is a family `A = (A_s)_{s∈S}`, where
`A_s : {(a,b) ∈ C² : a ≠ b} → ℝ^m` and `C` is the set of four colours. It must satisfy:
- `A_{−s}(b,a) = −A_s(a,b)`;
- **the square identity**: for every pair of distinct `±`-classes `s, t` and every **locally admissible** colouring `(c₀,c₁,c₂,c₃)` of
  the commutator square `x₀ = x, x₁ = x+s, x₂ = x+s+t, x₃ = x+t`,
  `A_s(c₀,c₁) + A_t(c₁,c₂) − A_s(c₃,c₂) − A_t(c₀,c₃) = 0`.
  A colouring is locally admissible if it is proper on the four sides, has `c₀ ≠ c₂` when `s+t ∈ S`, and has `c₁ ≠ c₃` when `s−t ∈ S`.

With that, `a(e_s, c)(x) := A_s(c(x), c(x+s))` extends to a continuous cocycle `ℤⁿ × X → ℝ^m` (D.3's Kind 1; the ℤⁿ-Cayley complex is
simply connected once its commutator squares are filled). The certificate then carries the D.3 datum: the winding
`d(c) = a(·,c)|_R` and the slope `m(μ)`. The checker verifies the square identities (a finite list) and accepts if the admissible set
it derives for `(d, m)` is empty.

**Definitions.** The **non-triangle graph** `𝒢_S` has vertex set `S` (signed elements). It joins `s ~ t` iff `s ≠ ±t` and
`s − t ∉ S`, that is, iff `{0, s, t}` is **not** a triangle. The **trivial** cocycles are `A_s(a,b) = g(b) − g(a) + σ_s`, with
`g : C → ℝ^m` and `σ_{−s} = −σ_s`. Their cocycle is the coboundary of `g∘c` plus the constant (homomorphism) cocycle `σ`. They form a
space of dimension `3 + n` per coordinate, where `n = |S|/2`.

**Theorem C1 [hand; checked exactly, below].** If every `s ∈ S` lies in the same component of `𝒢_S` as `−s`, then every kind-1_edge
cocycle is trivial. Its winding is `σ|_R` and its slope is `σ`, the same for every colouring and every measure. So the format accepts no
certificate on such a presentation: it is blind.

*Proof.* Four steps, all at four colours. Write `D = A_s − A_t`.
1. **The `abcb` pattern.** Let `s ~ t` in `𝒢_S`. The pattern `(c₀,c₁,c₂,c₃) = (a,b,c,b)`, with `a, b, c` distinct, is locally
   admissible because `s − t ∉ S`. It gives `D(a,b) = D(b,c)` for all distinct `a, b, c`.
   - With four colours, for distinct `b, c, c′` there is a fourth colour `a`. So `D(b,c) = D(a,b) = D(b,c′)`, and `D(b,·) = f(b)`.
   - Then `D(a,b) = f(a)` and also `D(a,b) = D(b,c) = f(b)`. So `f` is constant and `D` is constant.
   - This step fails at three colours (there is no fourth colour), which is why three-colour heights exist.
2. **Constancy along paths, and `s` against `−s`.** Constants add along `𝒢_S`-paths, so `A_s − A_t` is constant whenever `s` and `t`
   lie in one component.
   - Apply this to `t = −s`, which lies in the component of `s` by hypothesis. Since `A_{−s}(a,b) = −A_s(b,a)`, it gives
     `A_s(a,b) + A_s(b,a) = 2σ_s`, a constant.
   - Write `A_s = N_s + σ_s` with `N_s` antisymmetric. Then `A_s − A_t` constant forces `N_s = N_t`: an antisymmetric constant is 0.
     So `N_s = N` on each component.
   - The hypothesis also makes `N` the same for `s` and `−s`, and `N_{−s} = N_s` holds anyway.
3. ~~**The components are joined.** Let `s ~ t` be a `𝒢_S`-edge between two components…~~ **RETRACTED (step 3 as first written,
   retraction 1; the gap was found by Poros).** A `𝒢_S`-edge cannot join two components, since components are maximal, so the step
   argued about an impossible case. **Replacement: Lemma D (dichotomy) below.** If some component contains a pair `±s`, then `𝒢_S` is
   connected. So under the theorem's hypothesis there is one component, `N_s = N` for all `s`, and nothing else is needed.
4. **The `abcd` pattern and `ℝP²`.** The pattern with `a, b, c, d` distinct is always locally admissible. It gives
   `N(a,b) + N(b,c) + N(c,d) + N(d,a) = 0` (the `σ`'s cancel).
   - So `N` has zero circulation on all three 4-cycles of `K₄`.
   - In the triangle basis `T₁₂₃, T₁₂₄, T₁₃₄` of `K₄`'s cycle space, those 4-cycles are `(1,0,1)`, `(0,1,−1)` and `(−1,1,0)`. The
     determinant is 2, so they span over ℚ. This is `H¹(ℝP²; ℝ) = 0`.
   - Over `ℤ` they span an index-2 sublattice: the `ℤ/2` of T29, which is invisible to a torsion-free `M`.
   - Hence `N = δg`. ∎

**Corollaries** [hand, one line each].
- **(a) Triangle-free `S`.** `𝒢_S` is complete except for the antipodal pairs, and it is connected once `|S| ≥ 4`. So the claim is
  trivial on every triangle-free presentation. **This covers every lattice over ℚ(√167)** (G57): `r = 4`, triangle-free.
- **(b) Unit-distance lattice graphs (`S = U = Λ ∩ S¹`).** Suppose `𝒢_U` splits `U = A ⊔ B` with a `±`-class separated. Then every
  `a ∈ A`, `b ∈ B` has `a = −b` or `a − b ∈ U`. So `A ∖ {−b}` consists of common unit neighbours of `0` and `b`: at most `bζ₆^{±1}`.
  - Hence `|A|, |B| ≤ 3`, and at `|U| = 6` the vectors are `b·{ζ₆^k}`.
  - **So the triangular lattice ℤ[ζ₆] is the only unit-distance lattice graph of rank ≥ 2 with a non-trivial edge-local four-colour
    height.** Rank 1 has the paths, `|U| = 2`.
- **(c) De Grey's lattice.** `U` is 9 hexagons, and a triangle `{0,u,u′}` forces `u′ = u·ζ₆^{±1}`. So every cross-hexagon pair is a
  `𝒢`-edge, `u ~ w ~ −u`, and the lattice carries **no** edge-local height. Its rigidity (`F = 8Λ`) is not a height phenomenon of this
  kind, and Moore–Newman's height on each Eisenstein coset does not globalise.

**Exact check** (`tools/heights_edge.py`, `tools/heights_lattices.py`, this directory). It builds the linear system of every locally
admissible square pattern and computes its nullity mod `p = 2³¹ − 1`. That is an **upper** bound on the ℚ-nullity. The trivial
solutions are a **lower** bound, verified by substitution. "extra" = nullity − trivial.

| presentation | `n` | patterns | nullity mod p | trivial | extra | `𝒢_S`: `s` joined to `−s`? |
|---|---|---|---|---|---|---|
| grid ℤ² | 2 | 84 | 5 | 5 | **0** | yes |
| grid ℤ³ | 3 | 252 | 6 | 6 | **0** | yes |
| triangular lattice | 3 | 144 | 8 | 6 | **2** (Moore–Newman) | **no** (2 components) |
| triangular + `(2,−1)` | 4 | 396 | 7 | 7 | **0** | yes |
| triangular + `(1,2)` | 4 | 300 | 7 | 7 | **0** | yes |
| `Cay(ℤ,{1,2,3})` (K₄ cliques) | 3 | 120 | 8 | 6 | **2** | **no** |
| `G(ℤ,{1,5,7,10})` (a T30 wall) | 4 | 468 | 7 | 7 | 0 | yes |
| `G(ℤ,{1,3,4,5})` | 4 | 300 | 7 | 7 | 0 | yes |
| `G(ℤ,{1,3,7,12,17,22})` | 6 | 1,260 | 9 | 9 | 0 | yes |
| de Grey's lattice (54 unit vectors, trace saturation) | 27 | 28,512 | 30 | 30 | **0** | yes |
| Λ₄₂₀ = `L21cc6506` over ℚ(√167) (60, box saturation) | 30 | 36,540 | 33 | 33 | **0** | yes |
| Λ₂₄₄₈ (84) | 42 | 72,324 | 45 | 45 | **0** | yes |
| Λ₂₄₀₀ (100) | 50 | 102,900 | 53 | 53 | **0** | yes |

The mod-p upper bound meets the trivial lower bound wherever the theorem applies. So the ℚ-nullity equals the trivial dimension
exactly: this is a certificate, not an estimate. Both split cases carry exactly two extra dimensions.
- **Controls (OBS-N3).** The grid is reproduced (the edge-local shadow of `[CGHO2025coh]` Thm 1.1). The triangular lattice is **not**
  covered: its extra 2 are Moore–Newman's `E ∈ ℝ²`.
- **Adding any one direction to the triangular lattice kills the height.** This holds whether the new direction makes triangles or not.

**Grades.**
- Theorem and corollaries: [hand].
- The table: [tools, exact modular upper bound meeting an exact lower bound].
- **Plants, run.** Each plant was refused, and the controls came back after it was undone:
  - `PLANT=drop_diag13` removes the `c₁ ≠ c₃` diagonal rule. The triangular lattice's extra drops from 2 to 0, so the height needs the
    excluded pattern, as the proof says.
  - `PLANT=bad_trivial` corrupts one trivial vector. The substitution assert fires: `a trivial solution fails an equation`.
  - The unplanted re-run reads 2 on the triangular lattice and 0 on the grid.

**Inhabitants (G30.5).** The hypothesis "`s` joined to `−s`" is inhabited by `L21cc6506` (checked, row above). The negation is
inhabited by ℤ[ζ₆].

**Reach (O-0.4).** The class contains triangle-free `r = 4` graphs, and the claim covers every lattice over ℚ(√167). So **at ℚ(√167),
no four-colour certificate can come from an edge-local height**: the Θ₃ route has no edge-local four-colour analogue there.

**Scope (OBS-N4).**
- *Open:* window-local cocycles (kind 1_ρ, depending on a radius-ρ window). This is the step from this theorem to `[CGHO2025coh]`'s
  full statement, and here it must be done for arbitrary `S`.
- *Untouched:* every non-height kind (0₁, 0_W, K, C, T, A).
- *Mixtures:* a winding together with window frequencies is not excluded, because the winding here is `σ|_R`, a constant.

**Reading R1c (the flat tetrahedron) [reading].**
- `K₄`'s clique complex, with unit triangles, is the flat orbifold `S²(2,2,2,2) = ℝ²/p2`.
- A four-colouring of ℤ[ζ₆] is a simplicial map to it. Its lift to the orbifold cover is a map `h : T → T′` with
  `h(x+e_j) − h(x) ∈ {E_α, E_β, E_γ}` for the three positive directions, and `c = h mod 2T′`, since `T′/2T′ ≅ V₄`.
- Moore–Newman's height is `h`. Theorem C1 explains why it is fragile: the orientation `σ(s) = ±1`, "positive directions", is exactly
  the split of `𝒢_S`, and any direction outside the hexagon joins the two halves.

## 3. Claim C2 — a counterexample to inheritance that is periodic in `r − 1` directions needs a chiral rigid phase (R2)

**Class and rank.** All of 𝒞, any `r ≥ 1`, any number of colours `k`. **Face and shape:** (Q), a sharpened reduction. It is a
necessary condition on a (Q-N2) counterexample of the named type, not a counterexample.

**Setting.**
- `c ∈ X(Λ,S,k)` separates `(0, δ)`, and `δ ∈ P`: every periodic colouring is δ-periodic.
- `c` is periodic under a subgroup `W` of rank `r − 1`. In rank 1, `W = 0`.
- `X_W` is the set of `W`-periodic colourings. It is a one-dimensional SFT over `Λ/W ≅ ℤ ⊕ (finite)`, with a finite state graph (window
  colourings of a slab).
- A **rigid phase** is an essential strongly connected component (SCC) that is a single cycle.
- A phase `C` is **achiral** if `C^R = g·C` for some `g` in the group generated by colour permutations and `Λ`-translations, where
  `C^R` is its image under the reflection `x ↦ −x`. That reflection is an automorphism of every `Cay(Λ, S)`, since `S = −S`.

**Theorem C2 [hand].** Under the setting, both ends of `c` lie in rigid phases, the ends lie in distinct phases, and at least one end is
chiral. In particular, neither end is an additive colouring: `−φ` is a colour permutation of `φ`, T31.

*Proof.*
1. **`δ` has a component along the `ℤ` factor.** Write `δ = w + je`. If `j = 0`, every `W`-periodic colouring is δ-periodic, so `c`
   cannot separate `δ`. Hence `j ≠ 0`, and δ-periodicity of a point of `X_W` is shift-periodicity with period `j`.
2. **The phases are rigid.** Suppose an essential SCC contains two distinct cycles. Then it has periodic points `(uᵃv)^∞` of unbounded
   least period. Any of them whose least period does not divide `j` is a periodic colouring that is not δ-periodic, which contradicts
   `δ ∈ P`. So every SCC that `c`'s path visits is a single cycle.
3. **There is a wall.** A path confined to one single-cycle SCC is periodic, and every periodic point is δ-periodic. So `c` is not
   confined: its α- and ω-limit SCCs `C₋ ≠ C₊` are joined by a path. That path is a wall, T30's criterion.
4. **Reflection and symmetries act on walls.** Reflection maps a wall `C₋ → C₊` to a wall `C₊^R → C₋^R`. Colour permutations and
   translations `g` map walls to walls `gC₋ → gC₊`, preserving direction.
5. **Two achiral ends would close a cycle.** Suppose `C₋^R = gC₋` and `C₊^R = g′C₊`.
   - Step 4 gives a wall `g′C₊ → gC₋`, so `C₊ → hC₋` with `h = g′⁻¹g`.
   - Hence `C₋ → C₊ → hC₋ → hC₊ → h²C₋ → ⋯`.
   - There are finitely many SCCs, so `hᵐC₋ = C₋` for some `m`. That puts a path through `C₊` from `C₋` back to `C₋`, so
     `C₊ = C₋`, a contradiction. ∎

**What it gives.**
- It proves Coxeter's FS-73 reading (FS73 §8: "periodic in `r − 1` directions needs a chiral, non-additive phase") as a theorem, with
  rigidity of the ends added.
- **In rank 1:** if every periodic `k`-colouring of `G(ℤ, D)` is achiral, then `P = F`. So a rank-1 counterexample to C3-inherit needs a
  chiral rigid phase with a wall. This is consistent with T30's null to `max D = 10`.

**Inhabitants.**
- A presentation with rigid phases and no wall: `Cay(ℤ,{1,2,3})`, whose single phase is `abcd`, achiral.
- The hypothesis `δ ∈ P ∖ F` with `W`-periodic `c` is exactly what a counterexample would inhabit. None is known, and C2 is a necessary
  condition, so it ships no inhabitant of the full hypothesis. That is stated, not hidden (G30.5): its inhabitant would be a
  counterexample.

**Grade.** [hand]. Its key step, the orbit of `h` closing the cycle, is the step I want checked.

## 4. Claim C1-L — the same theorem on the language of `X` (Poros's second question, answered for this format)

**The worry (Poros).** A cocycle of the colouring shift only has to close on the square patterns that **occur** in `X` (its language),
which can be far smaller than the locally admissible set. On a rigid lattice, triviality over local patterns need not transfer.

**Two readings, and why both are kept.**
- *For a certificate* (Q-obs), the local format is the right one. A checker that reads only `S` cannot know the language: deciding
  which square patterns occur is as hard as colourability. So C1 is the no-go for the format a checker can use.
- *For what a colouring carries*, the language is the right domain. That is C1-L.

**Theorem C1-L [hand].** Let `𝒢_S^X` join `s ~ t` iff some `c ∈ X` shows the `abcb` pattern on an `(s,t)`-square: `c(x+s) = c(x+t)`
and `c(x) ≠ c(x+s+t)`. Suppose every `s` is joined to `−s` in `𝒢_S^X`, and some `c ∈ X` has a rainbow commutator square. Then every
edge-local cocycle **of `X`**, one that closes on the patterns occurring in `X`, is trivial.

*Proof.* C1's proof uses exactly these patterns: `abcb` on the `𝒢`-edges, and one `abcd` for the three 4-cycles of `K₄`. Because `X`
is `Sym(4)`-invariant, one occurrence of a pattern type gives every relabelling of it. ∎

**Exact checks** (`tools/degrey_lang2.py`, `tools/q167_lang.py`). A subset of the language imposes fewer equations, so it gives an
**upper** bound on the language-cocycle space. Meeting the trivial dimension is therefore a proof.

| lattice | colourings used | pattern types by square | language nullity mod p | trivial | extra |
|---|---|---|---|---|---|
| de Grey's lattice | **all** 9,120 (FS-73 census: 380 pinned × 24; properness asserted on `Λ/8Λ`) | 7 of the 351 pairs never show a rainbow square (`{I,III}` 7, `{I,II}` 2, …) | 30 | 30 | **0** |
| `L21cc6506` = Λ₄₂₀ | the 8 additive `ℤ/4` colourings (enumerated here: 8, matching phase 0; no `V₄`) and both phase-0 linear `Θ₄` witnesses (orders 4,200 and 5,880; every `θ(u) ∈ [1/4, 3/4]` asserted) | all 435 pairs show `abcd`; the sets vary | 33 | 33 | **0** |

*Control on the coordinate convention:* reading the linear witness's basis in lattice coordinates fails the `Θ₄` assert; reading it in
point coordinates passes. So the check refuses a wrong interpretation.

**What it settles.**
- **De Grey's four-colourings carry no edge-local height even on their own language.** Its rigidity (`F = 8Λ`, 12 classes, Hubai's
  stripes and chirality) is not a height of this kind. Those invariants must use wider windows, or be non-cocycle invariants (Kempe
  classes, chirality).
- On `L21cc6506`, the exhibited colourings already force triviality.
- The radius question remains (OBS-N4), but "local versus language" is closed **for edge-local cocycles** on both instances. It is
  closed in general whenever C1-L's two occurrence conditions hold.

## 5. The held items: taken and declined (my reading, 2026-09-24)

| item | taken or declined | why |
|---|---|---|
| Poros's caution (an odd relation acts on the `Q₃`-lift as the antipode, so every averaged signed `S²`-degree is 0) | **taken, agreed** | Premise: the lift `c̃(x)` is the preimage of `c(πx)` in `𝔽₂³` whose weight parity is `x`'s parity in `ℤⁿ`. So `c̃(x+ρ) = c̃(x) + |ρ|·(1,1,1)`: the antipode iff `|ρ|` is odd, **independent of the colouring**. I reached the sign cancellation while choosing a route, but it was not written here before the message, so I claim no credit for it. |
| H-A (flux, owner) and H-P2 (π₂ charge density, planner's advisor) | **declined as routes** | By the caution, the signed flux is 0 on every non-bipartite graph. What survives is sign-blind (`|deg|`, `deg mod 2`). `deg mod 2` per 3-cell is a window-frequency (kind 0_W) datum whose "conservation" is a parity constraint on 4-cells: no linear integrality beyond the window LP. I also stay off cube/`H²` cohomology by my undertaking (§6). |
| H-B (a universal triangle-free target) | **declined for this session** | Naserasr's theorems are for planar graphs, and ours are not planar. I have no candidate target for triangle-free four-colourable Cayley graphs of ℤ^r, and no time to price one. Left as a pointer. |
| H-P3 (compositional certificates) | **read, not taken** | Compositionality alone is not rare: kind 0_W's local-consistency polytopes are compositional too, since `X(S₁ ∪ S₂) = X(S₁) ∩ X(S₂)`. What made `Θ₃` small was that its per-generator constraint is **exact** (the slope set is the admissible set, by density). C1 says no edge-local height exists at four colours on any ℚ(√167) lattice, so there is no per-generator slope set to pull back layer by layer. |

**The resulting finding about the challenge** (it may be subtly the wrong challenge; I say so, as the brief invites).
- At four colours, on every non-bipartite Cayley graph, every certificate of topological origin that I can name is one of three things:
  - trivial: edge-local heights, C1, except on presentations whose non-triangle graph splits (among unit-distance lattices, only
    ℤ[ζ₆]);
  - sign-cancelled: the signed `S²` flux (Poros's caution);
  - a mod-2 window frequency, subsumed by kind 0_W.
- So at ℚ(√167), (Q-obs)'s certificate cannot be a `Θ₃`-like topological object. It must be an averaged window object, whose size
  problem D.4 already names, or a structure-derived one.
- This is a reading about the kinds named so far, not a theorem about every kind.

## 6. Channel incident (recorded for the owner and Poros)

- **What happened.** Poros's interim hand-back, addressed to the owner, was delivered to me, because my `SendMessage` had resumed it.
- **What it disclosed.** Coxeter's intermediate results: a square lemma and a cube lemma (`H² = ℤ` once 24 monopole colourings are
  excluded); Kempe period groups of index 8 on `L21cc6506`'s additive colourings; a Simonyi–Tardos zig-zag no-go for topological
  bounds on unit-distance graphs.
- **What I did.** I reported it to the owner at once (the owner acknowledged it). I use none of it, and I stay off cube/`H²`
  cohomology and topological/zig-zag bounds. My C1 table and C2 were written before the leak; C1-L, §4, extends C1 by the same method.

## 2a. C1 completed: the dichotomy, the structure of the split case, and the format is empty on all of 𝒞

**Lemma D (dichotomy) [hand].** If some component `A` of `𝒢_S` contains a pair `±s`, then `𝒢_S` is connected.

*Proof.*
1. **Setup.** Suppose not, and let `B = S ∖ A ≠ ∅`. Every `a ∈ A` and `b ∈ B` are non-adjacent, so `a − b ∈ S` or `a = −b`.
2. **`B ± s ⊆ S`.** For `b ∈ B` we have `b ≠ ±s`, so `s − b` and `−s − b` lie in `S`, and `S = −S`.
3. **The extreme elements.** Take `ℓ`, a linear functional that is non-zero on `S` and injective on it, and let `m` maximise `ℓ` on
   `S`, so `−m` minimises it.
   - If `m ∈ B`: `m + s′ ∈ S`, where `s′ ∈ {±s}` has `ℓ(s′) > 0`. That exceeds the maximum.
   - If `−m ∈ B`: `−m − s′ ∈ S` falls below the minimum.
   - So `±m ∈ A`.
4. **Contradiction.** Step 2 with `m` in place of `s` gives `b ± m ∈ S` for every `b ∈ B`. One of the two leaves `[ℓ(−m), ℓ(m)]`.
   So `B = ∅`. ∎

**Lemma S (structure of the split case) [hand].** Suppose `𝒢_S` is disconnected. By Lemma D every component is `±`-free, and negation
permutes the components. Let `A` be the union of one component from each `± `pair, so `S = A ⊔ −A`. Then:
- **(i)** `a + a′ ∈ S` for all distinct `a, a′ ∈ A`;
- **(ii)** `A = {a}`, or `A = {a, −2a}`, or `A = {a, b, −a−b}`.
So **`S = ±{a}`, `±{a, 2a}` or `±{a, b, a+b}`, and `r ≤ 2`.**

*Proof.*
- **(i).** For `a ∈ A`, the element `−a′` lies in a different component (in `−A`), so `a` and `−a′` are non-adjacent, which gives
  `a − (−a′) ∈ S`.
- **(ii).** Choose `ℓ` as in Lemma D, and swap `A` with `−A` (both satisfy (i)) so that `m = argmax_S ℓ ∈ A`.
  - For `a ∈ A ∖ {m}`: `a + m ∈ S`, which forces `ℓ(a) < 0`.
  - Let `p = argmin_A ℓ`. For `a ∈ A ∖ {m, p}`: `a + p ∈ S` and `ℓ(a + p) < ℓ(p)`.
  - The only element of `S` below `ℓ(p)` that is not in `A` is `−m`. The rest of `−A` lies in `ℓ > 0`. So `a = −m − p`.
  - Hence `|A| ≤ 3`, and `A = {m, p, −m−p}` when `|A| = 3`.
  - When `|A| = 2`, `m + p ∈ ±{m, p}` forces `p = −2m` or `m = −2p`. ∎

**Theorem C1 (complete form) [hand].**
- **(a)** If `𝒢_S` is connected, every kind-1_edge cocycle is trivial (the proof of §2, with step 3 replaced by Lemma D).
- **(b)** If it is disconnected, `S` is one of Lemma S's three forms. Identify the colours with `V₄`, let
  `E : V₄ ∖ 0 → ℝ²` be the three vectors of an equilateral triangle centred at 0, and let `σ : S → ±1` be `+1` on `A` and `−1` on `−A`.
  Then `A_s(a, b) = σ(s)·E(a ⊕ b)` is a non-trivial cocycle: Moore–Newman's height, generalised.
  - *Check of (b), one line per square type.* Pattern `abcd` holds because `a⊕b = c⊕d` in `V₄`. `abab` is trivial.
  - `abac` needs `σ(s) = σ(t) ⟹ s + t ∈ S`, which is (i).
  - `abcb` needs `σ(s) ≠ σ(t) ⟹ s − t ∈ S`, which is (i) applied to `s` and `−t`.
  - The height is non-trivial because its symmetric part `σ(s)E(a⊕b)` is not constant in `(a, b)`.
- **(c) Every presentation of case (b) is four-colourable.**
  - `±{a}`: two colours.
  - `±{a, 2a}`: three colours.
  - `±{a, b, a+b}` with `a, b` independent: `θ(a) = θ(b) = 1/3` is a `Θ₃` point, so three colours.
  - With `a, b` dependent: a rank-1 distance graph `G(ℤ, {p, q, p+q})`, and **a direct proof** replaces the lonely-runner citation.
    - `ψ : ℤ² → ℤ`, `e₁ ↦ p`, `e₂ ↦ q`, maps the triangular presentation `±{e₁, e₂, e₁+e₂}` onto it, with kernel `⟨(q, −p)⟩`
      (take `gcd = 1`). So a `(q,−p)`-periodic four-colouring of the triangular lattice descends.
    - One of `p, q, −(p+q)` is even. Relabel the triangle `{e₁, e₂, −e₁−e₂}` so that `ψ(f₁)` is even.
    - Colour row `r` (the `f₂`-coordinate) alternately from `{A,B}` if `r` is even and from `{C,D}` if `r` is odd, with a phase `φ_r`.
      Every such stripe colouring is proper.
    - It is `(ψ(f₂), −ψ(f₁))`-periodic iff `φ_r = φ_{r−ψ(f₁)} + ψ(f₂)` (mod 2). Choose `φ` freely on one period of rows and extend.
    - [hand] The earlier citation of the three-runner lonely-runner theorem (Betke–Wills 1972, Cusick 1974) was **recalled, not read**.
      It is no longer needed. The exact check (`p < q ≤ 40`, 0 failures) stays as a control.

**Consequence (Poros's second question for C1, answered). Kind 1_edge accepts no certificate on any graph in 𝒞 at four colours.**
- A non-trivial edge-local height exists only on a four-colourable presentation of rank ≤ 2.
- Every non-four-colourable presentation, in any rank, has a connected `𝒢_S`, and there the format is blind (C1(a)).
- So the no-go is not "blind at ℚ(√167)" but **"the edge-local format is empty at four colours on all of 𝒞"**. The live question for
  heights is the window radius (OBS-N4), and nothing else.
- Its weight, stated honestly:
  - the format contains the known positive (Moore–Newman), and C1 classifies exactly where that positive lives;
  - the no-go is complete for the format;
  - the format is narrow.

**Exact checks of the two lemmas** (`tools/split_types.py`, `tools/split_structure_check.py`):
- 57,718 generating sets. They are all 2- to 5-subsets of the half-box `{(a,b): 0≤a≤3, −3≤b≤3}`, plus the 3- to 5-subsets of
  `{0,1}×{−1,0,1}²` in ℤ³.
- Each one is connected or has **exactly two** `±`-swapped components. There are no mixed cases, as Lemma D predicts.
- All 126 split cases have Lemma S's form (4 of type `{a, −2a}`, 122 of type `{a, b, −a−b}`), and extra = 2.
- The nullity in case (b) is `3 + n + 2` on every instance computed. That the space is exactly two-dimensional is **not proved**, only
  observed.

## 3a. C2 against T30's walls (Poros's second question for C2)

**The exact computation** (`tools/rank1_phases.py`): the window-state graph modulo colour permutation, its cyclic SCCs, which of them
are single cycles ("rigid"), which rigid phases are chiral (the reversed word is no relabelled rotation), and walls (paths between
distinct cyclic SCCs).
- *Reconstruction control:* the first version rebuilt colourings without re-checking properness against the whole window. It gave
  period 3 on `{1,2,3}` (wrong). The fixed version asserts a unique proper extension at each step and reads period 4 (`1230`), with
  `{1,3,4,5}`'s period-8 word `30101232`, T29's own word.

| `D` (T30 wall) | cyclic SCCs | rigid | walls | ends of the walls |
|---|---|---|---|---|
| `{1,5,7,10}` | 18 | 17 | 15 | **rigid–rigid walls with both ends chiral** (period-20 words), plus walls into a positive-entropy SCC (270 states) |
| `{3,5,9,10}` | 25 | 23 | 3 | one rigid–rigid (both ends chiral), two through a positive-entropy SCC (162) |
| `{3,7,9,10}` | 34 | 31 | 4 | four rigid–rigid, all ends chiral |
| `{5,7,9,10}` | 16 | 15 | 3 | one rigid–rigid (both ends chiral), two through a positive-entropy SCC (1,084) |

**Reading.**
- C2's conditions **are met** on T30's walls: rigid chiral ends joined by a wall. Yet `P = F = 0`.
- The reason is a positive-entropy phase elsewhere in the same graph: its periodic points have unbounded least periods, so `P = 0`.
- So C2 is necessary and far from sufficient. **The missing condition, exactly (rank 1):** `P ≠ F` iff **every** cyclic SCC is a single
  cycle **and** a wall exists (T30's criterion plus step 2 of C2's proof). C2 adds that some end of the wall is chiral.
- **An observation, not a claim.** On each T30 set I added one distance `d ≤ 22`. In the 11 cases where every phase became rigid,
  **every wall disappeared** (`tools/rank1_search.py`).
- **The exhaustive rank-1 scan, done** (`runs/rank1_scan.jsonl`, md5 `46a1c86a…`, 2,706 rows; the owner cleared it; run under the
  heavy lock). It covers every `D` with `11 ≤ max D ≤ 14`, `3 ≤ |D| ≤ 5` and `gcd 1` (375 / 521 / 781 / 1,029 by `max D`):
  - 194 are not four-colourable;
  - 2,023 have a positive-entropy phase and no wall;
  - 112 have walls, **every one of them alongside a positive-entropy phase**;
  - 377 have every phase rigid, and **none of those has a wall**.
  - **Counterexamples to C3-inherit: 0.** With T30 (`max D ≤ 10`), rank-1 inheritance at four colours holds for every `max D ≤ 14`
    and `|D| ≤ 5`.
  - The reading "every phase rigid ⟹ no wall" (rank 1, four colours) is **unrefuted on 377 of 377 all-rigid sets**. It is unproved:
    I have no argument, only the observation that walls come with entropy.
  - The scan measures its range (G21): `|D| ≤ 5`, `max D ≤ 14`.

## 2b. Why four is the exception: every `k`, and the Kneser graph of colour pairs

**Theorem C1ₖ [hand; checked at k = 3–6].** Kind 1_edge at `k` colours, on any presentation with `n ≥ 2` generator classes:
- **`k = 3`.** Heights exist on every presentation checked. Step 1 needs a fourth colour and has none, and FS-73's height is the
  example.
- **`k = 4`.** A non-trivial cocycle exists **iff** `𝒢_S` is disconnected (Lemmas D and S). Then the extra space is **exactly
  two-dimensional**: Moore–Newman's `σ ⊗ E`.
- **`k ≥ 5`.** Every cocycle is trivial, on every presentation.

The case `n = 1`, `S = ±{a}`, has no squares, so every edge function is a cocycle. It is a union of paths, two-colourable, and outside
the question.

*Proof of the split case, for all `k ≥ 4`.*

~~The first version of this proof derived a second relation from "cross squares `(s, −t)`"~~. **RETRACTED (retraction 2, mine).** The
`(s, −t)` square is the `(s, t)`-square based at `x − t` with its vertices relabelled, so it contributes no new equation. The
conclusion stands; the derivation is replaced by the one below.
- **Setup.** Choose the generators to be `A`. Within a component, step 1 gives `A_s = B + c_s`. `A` is one component, or several joined
  through `𝒢`-edges: in the rank-1 case `{1,2,−3}`, `1` and `2` are joined through `−3`.
- **The admissible patterns.** For a pair `s, t ∈ A`, `s + t ∈ S` (Lemma S(i)), so type II is excluded. Types I and III give trivial
  identities once `A_s − A_t` is constant. What remains is type IV, `(a,b,c,d)` all distinct, **in every ordering**:
  `B(a,b) + B(b,c) − B(d,c) − B(a,d) = 0`.
- **The Kneser step.** Apply the same identity to the ordering `(b,a,d,c)` and add. This gives `Sym(a,b) = Sym(c,d)` for every pair of
  **disjoint** pairs of colours. So the symmetric part is constant on the components of the **Kneser graph `KG(k,2)`**.
  - `KG(4,2)` is three disjoint edges: `K₄`'s three perfect matchings, which are `V₄`'s three non-zero elements. That leaves three free
    values. One of them is absorbed by the constants `c_s`, which leaves **2**.
  - `KG(k,2)` is connected for `k ≥ 5` (the Petersen graph at 5), which leaves none.
- **The antisymmetric part.** The `Sym` terms in the type IV identity cancel in both cases. At `k = 4`, `{a,b}` and `{c,d}` are one
  matching, and so are `{b,c}` and `{a,d}`. So the antisymmetric part is closed on every 4-cycle of `K_k`. Those 4-cycles span the
  cycle space over ℚ for `k ≥ 4`, so it is exact. ∎

**The exact table** (`tools/heights_k.py`; extra = nullity mod p − (k − 1 + n)):

| `k` | grid ℤ² | ℤ[ζ₆] | ℤ[ζ₆] + `(2,−1)` | `G(ℤ,{1,2})` | `G(ℤ,{1,2,3})` | `G(ℤ,{1,3,7})` |
|---|---|---|---|---|---|---|
| 3 | 1 | 5 | 1 | 4 | 5 | 1 |
| 4 | 0 | **2** | 0 | **2** | **2** | 0 |
| 5 | 0 | 0 | 0 | 0 | 0 | 0 |
| 6 | 0 | 0 | 0 | 0 | 0 | 0 |

**What this says, in one sentence.** Moore–Newman's height is the `V₄` structure of four colours: the three perfect matchings of `K₄`.
It is visible to an edge-local cocycle only where the generating set has a sum-closed half, and nowhere at five colours. At three
colours the height is everywhere (G71). At four it survives on a rank-≤2 family that is always four-colourable. At five and above,
**no presentation carries an edge-local height**, which answers G72's "one dimension up, the shape of a six-certificate" negatively
for this format. Wider windows are OBS-N4's open question at every `k`.

## 7. Outcome, by face and shape (the acceptance criteria)

**(Q-obs): a no-go of a named kind, landed, narrow.**
- **Kind:** 1_edge, edge-local heights. **Shape:** trivial, hence blind, and complete for the format.
- **Class:** all of 𝒞, every rank. **Statement:** C1 (complete form, §2a). A non-trivial four-colour edge-local height exists iff `S` has
  a sum-closed half (`±{a}`, `±{a,2a}`, `±{a,b,a+b}`, `r ≤ 2`). Every such presentation is four-colourable. So the format accepts no
  certificate on any graph of 𝒞.
- **Reach (O-0.4):** yes. Every ℚ(√167) lattice (triangle-free, `r = 4`) is covered, and so is de Grey's lattice (triangles).
- **Controls (OBS-N3):** the grid is covered; ℤ[ζ₆] is not (Moore–Newman, exactly 2 extra dimensions).
- **Scope (OBS-N4):** wider windows are open. Poros's card points at `[CGHO2025coh]` Thm 5.8: a dense Gibbs class, strip-gluing and
  a mixing direction give triviality at every radius. The work would be a gluing lemma for `Cay(Λ,S)`. It fails where `X` is rigid, and
  there wide-window cocycles do exist on the language: class indicators times homomorphisms, on de Grey's 12 classes.
- **Extensions:**
  - C1-L (§4): the same on the language, exact on de Grey's 9,120 colourings and on `L21cc6506`'s exhibited colourings.
  - C1ₖ (§2b): at `k ≥ 5` no presentation with `n ≥ 2` carries an edge-local height. The Kneser graph `KG(k,2)` is disconnected only at
    `k = 4`, which is why Moore–Newman is a four-colour phenomenon.
- **Grades:** hand, with exact tools checks (mod-p nullity meeting substituted trivial solutions) and two plants refused.
- **Inhabitants:** `L21cc6506` for "connected `𝒢_S`"; ℤ[ζ₆] for "split".
- **Scoring (Poros):** OBS-N1–N4 met.

**(Q-rig): not landed.** Typed items:
- (b) *a subclass with an invariant.* The split presentations carry Moore–Newman's height. They are rank ≤ 2 and loose, so the item is
  of little use for rigidity.
- (a) *a sharpened reduction for the known positive.*
  - De Grey's rigidity is **not** an edge-local height, even on its own language (C1-L, exact).
  - Its 48 non-Eisenstein unit vectors each lie **alone** in their coset of the Eisenstein sublattice `T₀`
    (`tools/degrey_cosets.py`). So the `T₀`-cosets, each carrying a triangular-lattice colouring with its own Moore–Newman height,
    are coupled only by **single matchings**. By G14, no pair of cosets presses on its own. The stripes and `F = 8Λ` have to come from
    many cosets at once: what FS-74 has to explain is a many-layer effect, not a two-layer rule.

**(Q): not landed.** Typed items:
- (a) *a sharpened reduction:* C2 (§3), any rank, any `k`. A counterexample to inheritance that is periodic in `r − 1` directions has
  two distinct rigid phases as ends, one of them chiral (never additive). Poros read it and it closes.
- (a) *the exact rank-1 criterion:* `P ≠ F` iff every cyclic SCC is a single cycle and a wall exists (§3a).
- (c) *a candidate family and its test.*
  - T30's walls **do** join rigid chiral phases; `P = 0` there only because of a positive-entropy phase.
  - A counterexample needs every phase rigid **and** a wall. Those two never co-occur: not in the 11 one-distance extensions, and not
    in the 2,706-set scan (§3a; 0 counterexamples, and 377 all-rigid sets, none with a wall).
  - Deciding it would take a proof that zero entropy forbids walls in rank 1, or one scan row with `counterexample = true`.
