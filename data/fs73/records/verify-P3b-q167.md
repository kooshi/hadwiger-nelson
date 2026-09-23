# FS-73 P3b — independent verification V2: is the ℚ(√167) lattice graph `L21cc6506` 3-colourable?

Verifier: de Bruijn (V2), 2026-09-23. Machine: desktop (16 physical cores / 32 threads, 128 GB).
Brief: the product owner's `fs73-verifier2/BRIEF.md` (scratchpad). Code: `tools/fs73v2_*.py`, all mine, written without reading
`tools/fs73_theta_*`, `data/fs73/coxeter-c3/`, `data/fs73/c3-debruijn/`, `data/fs73/records/phase-P3b-q167-theta.md`, any
`data/fs73/q167/*theta*`/`*cert*` file, `data/fs73/q167/circular.jsonl`, `coxeter-Ld14c588b-linear-3colouring.json`, or the other
implementer's scratch directory — until the verdict below was written and committed.

## 1. The criterion's ⟹ direction, re-derived (written before reading either competition proof)

**Setting.** Λ a finitely generated abelian group, S = −S ⊂ Λ finite, 0 ∉ S. Write S = {±s₁, …, ±s_m}. Θ = {θ ∈ Hom(Λ, ℝ) :
θ(s) mod 1 ∈ [1/3, 2/3] for all s ∈ S}. (The condition for −s is the condition for s, the interval being symmetric under
x ↦ 1 − x, so one representative per ± pair suffices.)

**Claim (⟹).** If Cay(Λ, S) has a proper 3-colouring c : Λ → ℤ/3, then Θ ≠ ∅.

**Proof.**
1. *Cover by the grid.* Let π : ℤ^m → Λ, e_i ↦ s_i, a homomorphism with image Λ₀ = ⟨S⟩ and kernel R (the relation lattice).
   Put c' = c ∘ π. For every y and i, c'(y + e_i) − c'(y) = c(π(y) + s_i) − c(π(y)) ≠ 0 in ℤ/3 (s_i is an edge), so it is
   1 or 2 mod 3.
2. *Forward lift, no parity needed.* Let δ(y, i) ∈ {1, 2} ⊂ ℤ be the integer representative of c'(y + e_i) − c'(y). Around any
   unit square y → y+e_i → y+e_i+e_j and y → y+e_j → y+e_i+e_j the two two-step sums δ(y,i) + δ(y+e_i, j) and
   δ(y,j) + δ(y+e_j, i) are both in {2, 3, 4} and congruent mod 3 (both ≡ c'(y+e_i+e_j) − c'(y)), hence **equal**, the range
   having length 2 < 3. So δ is a closed integer 1-form on the grid graph of ℤ^m, whose square 2-complex is simply connected;
   hence δ = dk for a height k : ℤ^m → ℤ with k(y + e_i) − k(y) = δ(y, i) ∈ {1, 2} and k ≡ c' (mod 3) (fix k(0) ≡ c'(0)).
   (Equivalently, with the ±1 lift h of the brief's sketch: h ≡ Σy_i (mod 2), and k = (h + 3Σy_i)/2 — that is the parity
   argument; the forward lift makes it unnecessary.)
3. *Winding.* For r ∈ R, c'(y + r) = c'(y) for all y, so δ(y + r, i) = δ(y, i) (δ is a function of the two colours at the
   ends). Hence w(r) := k(y + r) − k(y) does not depend on y (its increment from y to y + e_i is δ(y+r,i) − δ(y,i) = 0), is
   additive in r, and w(r) ≡ c'(y+r) − c'(y) = 0 (mod 3): w : R → 3ℤ is a homomorphism.
4. *Mean slope.* For v ∈ ℤ^m put D(y, v) = k(y + v) − k(y). By step 3, D(y + r, v) = D(y, v), so D(·, v) is a function on
   Λ₀ = ℤ^m/R; it is bounded (|D| ≤ 2Σ|v_i|), satisfies the cocycle law D(y, v + v') = D(y, v) + D(y + v, v'), D(y, e_i) ∈
   {1, 2}, and D(y, r) = w(r). Λ₀ is a finitely generated abelian group, hence amenable: take Følner sets F_N ⊂ Λ₀ (boxes in
   a decomposition Λ₀ ≅ ℤ^n ⊕ torsion) and ψ_N(v) = mean over x ∈ F_N of D(x, v). Then ψ_N(e_i) ∈ [1, 2], ψ_N(r) = w(r)
   exactly, and |ψ_N(v + v') − ψ_N(v) − ψ_N(v')| ≤ 2(Σ|v'_i|)·|F_N Δ (F_N + π(v))|/|F_N| → 0. The vectors (ψ_N(e_i))_i lie in
   the compact box [1, 2]^m; take a convergent subsequence and let ψ be the linear map ℤ^m → ℝ with ψ(e_i) = lim ψ_N(e_i).
   Near-additivity gives ψ_N(v) → ψ(v) for every v, so **ψ(r) = w(r) on R and ψ(e_i) ∈ [1, 2]**.
5. *Descend to Λ.* Put φ̃ = ψ/3 : ℤ^m → ℝ. It is integer-valued on R (w(r) ∈ 3ℤ) and φ̃(e_i) ∈ [1/3, 2/3].
   **Here torsion-freeness is used:** Λ₀ ⊆ Λ torsion-free ⟹ ℤ^m/R ≅ Λ₀ is free ⟹ R is a direct summand of ℤ^m ⟹ the
   homomorphism φ̃|_R : R → ℤ extends to η : ℤ^m → ℤ. Then φ = φ̃ − η vanishes on R, so φ = θ₀ ∘ π for a unique
   θ₀ ∈ Hom(Λ₀, ℝ), and θ₀(s_i) = φ(e_i) ≡ φ̃(e_i) ∈ [1/3, 2/3] (mod 1).
6. *Extend.* ℝ is divisible, so θ₀ extends to θ ∈ Hom(Λ, ℝ) (for Λ ≅ ℤ^r: Hom(Λ₀, ℝ) = Hom(Λ₀ ⊗ ℚ, ℝ) and Λ₀ ⊗ ℚ is a
   subspace of Λ ⊗ ℚ). θ ∈ Θ. ∎

**What the statement needs, and whether the lattice supplies it.**
- *0 ∉ S* (no loop): a unit vector is nonzero. Supplied.
- *S finite*: used in step 4 (the box [1,2]^m is compact, ℤ^m finitely generated). U is finite (the norm equation bounds every
  coordinate). Supplied.
- *Torsion-free*: used in step 5, and it is essential — on Λ = ℤ/3 with S = {±1} the triangle is 3-colourable but
  Hom(ℤ/3, ℝ) = 0 and θ(1) = 0 ∉ [1/3, 2/3]. Our Λ is a subgroup of ℤ⁴. Supplied.
- *S generating*: **not needed** for ⟹ (step 6 extends from ⟨S⟩); needed only to identify the graph with one component. So the
  graph may be taken as Cay(span U, U) or Cay(key lattice, U); the second is a disjoint union of copies of the first, and Θ is the
  same set of linear functionals θ on ℝ⁴ either way (θ is determined by its values on U, which spans ℚ⁴).
- *S = −S*: harmless (the graph is undirected by definition; one representative per pair).
- *The subgraph step*: (a, b, c, e) ↦ ((a + b√167)/420, (c + e√167)/420) is injective (√167 ∉ ℚ) and additive, and the
  image of u is at distance 1 from 0 iff a² + 167b² + c² + 167e² = 420² and ab + ce = 0 (the rational and √167 parts of
  |x|² = 1). So Cay(Λ, U) with U = all lattice vectors satisfying both equations is the induced subgraph of the unit-distance
  graph of ℚ(√167)² on the image of Λ, and χ(ℚ(√167)²) ≥ χ(Cay(Λ, U)).

**The converse (⟸), for the controls.** Given θ ∈ Θ, c(x) = ⌊3θ(x)⌋ mod 3 is proper: for s ∈ S, 3θ(s) ∈ [1, 2] + 3ℤ, and
⌊a + t⌋ − ⌊a⌋ ∈ {1, 2} for t ∈ [1, 2], so c(x + s) − c(x) ∈ {1, 2} (mod 3).

**Consequence used below.** Θ = ∅ ⟹ Cay(Λ, U) is not 3-colourable ⟹ χ(ℚ(√167)²) ≥ 4.

(The first search plan, written here before any measurement, branched on θ over a fundamental domain of Hom(Λ, ℤ). §2 says why
I replaced it before running it.)

## 2. How I decide Θ: the relation form (no frame, no fundamental domain)

My first plan was to branch on θ itself over a fundamental domain of Hom(Λ, ℤ). I measured it and dropped it before running it.
- No four unit vectors form a ℤ-basis of span U. The smallest index of a 4-subset is 34,650, and in that best frame the other
  vectors have coordinates up to ~1,164 in absolute sum.
- All 34,650 cubes of that frame survive the interval test.
- The torus is large: covol(Λ) = 16·167/420⁴ ≈ 8.59·10⁻⁸ in the Minkowski embedding, the census's own figure. So Hom(Λ, ℝ/ℤ)
  has volume ≈ 1.16·10⁷ against |u| = √2.

**Lemma (relation form).** Let U⁺ = {u₁, …, u_N} hold one vector of each ± pair, B = [1/3, 2/3]^N, and let R = {r ∈ ℤ^N :
Σ r_j u_j = 0} be the relation lattice.
- (a) If θ ∈ Θ, then x_j := θ(u_j) − ⌊θ(u_j)⌋ lies in B, and r·x ∈ ℤ for every r ∈ R.
  Proof: r·x = θ(Σ r_j u_j) − Σ r_j⌊θ(u_j)⌋ = 0 − (an integer).
- (b) Conversely, suppose x ∈ B and r·x ∈ ℤ for every r in a basis of R. The quotient ℤ^N/R ≅ span U is free, so R is a direct
  summand, and x ↦ (r ↦ −r·x) extends to some n ∈ ℤ^N with r·(x + n) = 0 on R. Then x + n ∈ R^⊥, which is the image of
  θ ↦ (θ(u_j))_j. So x + n = (θ(u_j))_j for some θ ∈ Θ.

So Θ = ∅ iff no x ∈ B is integral on R. By (a) alone, it is enough to exhibit *any* finite set of relations with no common
integral point in B. That is the only direction the emptiness certificate uses.

**The certificate** is a tree.
- *Branch node.* It names a relation r (checked: Σ r_j u_j = 0) and an integer range lo..hi. Its children carry, in order,
  r·x ≤ lo − 1; r·x = k for each k = lo..hi; and r·x ≥ hi + 1. Every integer value of r·x falls in exactly one child.
- *Leaf.* It gives rational multipliers λ on its path's constraints: λ ≥ 0 on inequalities, and any sign on equalities. The
  combination w·x ≤ ρ must satisfy min_B w·x = Σ_j min(w_j/3, 2w_j/3) > ρ, strictly.
- *Soundness.* Any x from (a) follows one root-to-leaf path and satisfies every constraint on it. It would therefore satisfy
  w·x ≤ ρ < min_B w·x. That is impossible, so no such x exists and Θ = ∅.
- *Where the constraints come from.* The checker derives every constraint from (r, lo, hi) itself. The certificate cannot state
  a constraint.

**Soundness does not depend on U being complete.** Suppose the certificate lists only a subset S of the unit vectors. Then
Θ(S) = ∅ still gives: Cay(span S, ±S) is not 3-colourable (§1, ⟹), and that graph is a subgraph of the plane's graph. The checker
also runs its own exhaustive enumeration and reports whether the listed set is all of U, so that the graph can be *named* as
L21cc6506's graph.

**Tools** (floats only propose; nothing float-valued reaches the checker):
- `tools/fs73v2_units.py` enumerates every integer solution of the two norm equations exhaustively, then computes the Hermite
  forms and the index of the key lattice.
- `tools/fs73v2_xbb.py` is the finder. It takes an LLL-reduced basis of R proposed by PARI's `matkerint` and verified exactly,
  plus every closed walk of length ≤ 6 (meet in the middle, verified). It runs depth-first branch and bound: an elastic LP from
  scipy's HiGHS proposes Farkas multipliers, and each leaf is rationalised and checked exactly by the same criterion the checker
  uses before it is written. When the LP point is integral on a basis of R, the finder rationalises it (with an exact repair if
  needed), checks it exactly, and converts it to θ through PARI's `matsolvemod`. Every θ-coordinate is checked exactly.
- `tools/fs73v2_check.py` is the standalone checker.
  - It uses only Fraction and int, and imports nothing from the repository.
  - It re-enumerates U from the key itself and checks every unit vector and every relation.
  - It walks the tree with an explicit stack, and derives every constraint from (r, lo, hi).
  - It gunzips a `.json.gz` certificate itself.
  - `--self-test` plants faults in copies of a real certificate. Each plant must fail *for its own stated reason*. A plant that
    fails for any other reason stops the test.

## 3. The unit vectors, enumerated from the key alone

| lattice | d | D | integer solutions in ℤ⁴ | of them in the key lattice | U = −U | rank of span U | [key : span U] | [ℤ⁴ : key] |
|---|---|---|---|---|---|---|---|---|
| L21cc6506 (the claim) | 167 | 420 | 60 | **60** | yes | 4 | **1** | 4 |
| Ld65c8ee8 (control) | 11 | 30 | 108 | 108 | yes | 4 | 1 | 4 |
| Ld14c588b (control) | 167 | 348 | 44 | 44 | yes | 4 | 1 | 4 |

- The counts match the brief (60, 108, 44).
- span U *is* the key lattice, so Cay(span U, U) and Cay(key lattice, U) are the same graph.
- Every solution in ℤ⁴ already lies in the key lattice. Mod 4, a unit vector's odd coordinates are {a, e}, {b, c}, all four, or
  none (a² + 3b² + c² + 3e² ≡ 0 and ab + ce ≡ 0 mod 2), which is exactly c ≡ b, e ≡ a (mod 2).
- No four unit vectors form a ℤ-basis of span U, for any of the three lattices.
- L21cc6506's 30 pairs are the 6 rational pairs {(1, 0), (0, 1), (3/5, ±4/5), (4/5, ±3/5)} and 24 pairs involving √167.
- Its shortest closed walks have length 6 (twenty relations of ℓ₁ = 6). It has no walk of length ≤ 5, and its shortest odd
  relations in the reduced basis have ℓ₁ = 9.
- The d = 11 control, by contrast, has 5-cycles (1,345 relations of length ≤ 6).

## 4. Controls, through my own code, both directions, before the claim

| control | expected | finder | checker (standalone) |
|---|---|---|---|
| Ld65c8ee8, d = 11, 108 units (FS-61's solver refused it) | Θ empty | EMPTY: 14,478 nodes, 9,652 leaves, 29 s wall | **PASS EMPTY**, 9,652 leaves, 1,345 relations, units complete (108); self-test 9/9 plants fail for their own reason |
| Ld14c588b, d = 167, 44 units (known 3-colourable) | Θ nonempty | NONEMPTY after 1,189 nodes, 2 s: θ = (−59516/783, 898727/600300, 55315/1044, 27001/18009) in (a, b, c, e)-dual coordinates | **PASS NONEMPTY**: θ(u) mod 1 ∈ [1/3, 2/3] for all 44 unit vectors (own enumeration) |
| the ⟸ direction on the same θ | proper colouring | — | colouring ⌊3θ(x)⌋ mod 3 on the word ball of radius 3 (15,225 points, 42,636 edges): **0 monochromatic edges**, 3 colours used (`scratchpad/ballcolour.py`) |
| **known-positive plant**: a fake EMPTY certificate for the colourable Ld14c588b (finder in `--cover-through-points` mode: it covers the whole torus and writes a bogus leaf in each of the 176 regions that hold a genuine point of Θ) | must be REJECTED | "EMPTY", 15,692 nodes | **FAIL** (exit 1): "leaf not refuted" |

The known-positive plant is the one that matters most. The checker was handed a complete, well-formed EMPTY tree for a lattice
where Θ is provably nonempty, and it refused it. Every non-bogus leaf of that tree had passed the finder's exact gate.

The planted faults of `--self-test` were run on both EMPTY certificates, and each failed with its expected message:
- a unit vector moved off the circle;
- one relation coefficient perturbed;
- every multiplier of a leaf zeroed (w = 0, ρ = 0);
- every multiplier of a leaf negated (always invalid: min_B(−w) ≤ −min_B(w) < −ρ);
- a middle child dropped;
- a range shifted with its child dropped;
- a negative multiplier on an inequality;
- a touching leaf (min_B w·x = ρ exactly, which must be rejected because the test is strict);
- a branch on an unknown relation.

**A plant I retracted, recorded under G21's rule.** The first self-test included "scale one multiplier by 3" and "drop one
multiplier". On L21cc6506 the scaled plant *passed*. The mutated leaf was still a valid refutation: scaling one multiplier of a
Farkas combination with slack can keep it valid. The plant's failure mode was not reachable, so it tested nothing. I replaced
both with the zeroed and negated plants above, which are invalid by construction.

## 5. Verdict on L21cc6506: Θ is EMPTY, certified exactly. The claim holds.

| run | relations the tree may branch on | finder | standalone checker |
|---|---|---|---|
| main | the 26 of the reduced basis of R, plus the 20 closed walks of length 6 (39 after removing duplicates) | EMPTY: 45,516 nodes, 30,344 leaves, 75,860 LPs, 0 failed Farkas roundings, 79 s wall | **PASS EMPTY**: 30,344 leaves refuted, 39 relations verified, units the complete set (60 vectors); self-test 9/9 |
| structurally different rerun | the 26 basis relations only | EMPTY: 51,597 nodes, 34,398 leaves, 91 s wall | **PASS EMPTY**: 34,398 leaves, 26 relations |

**The certificates.** Both are in `data/fs73/verify-v2/`:
- `L21cc6506-empty.json.gz`, sha256 `9f7b54509aba202fb6d3ce08d5bbe07596c00e8439bceb8197abe5da2e98ace3`, 149 KB;
- `L21cc6506-empty-basisonly.json.gz`.

The controls are beside them: `Ld65c8ee8-empty.json.gz` and `Ld14c588b-point.json`.

**Re-check.** `python3 tools/fs73v2_check.py data/fs73/verify-v2/L21cc6506-empty.json.gz` takes 4 s and 60 MB. It needs no solver,
no PARI and no scipy.

**What it proves.** Cay(L21cc6506, U) is not 3-colourable. This rests on two things:
- the checker's exact verification, and
- the ⟹ direction of §1, which I re-derived above and did not take from either competition proof.

Its vertices are the points ((a + b√167)/420, (c + e√167)/420) of the key lattice, and its edges join points at distance exactly 1.
It is an induced subgraph of the unit-distance graph of ℚ(√167)². Hence **χ(ℚ(√167)²) ≥ 4**, where only 3 was proven before.

**What it does not give.**
- It gives no *finite* non-3-colourable graph explicitly. Compactness says one exists (de Bruijn–Erdős), but the certificate
  is a statement about a periodic infinite graph.
- The mean-slope step of §1 is not constructive, so a finite witness would need a separate construction (§8).

**Where I looked for an error, and what I found there.**
- *U incomplete or wrong.* The enumeration is exhaustive in both the finder's helper and, independently, the checker. Both give
  60. And soundness does not need completeness (§2).
- *A relation that is not one.* Every relation is checked in ℤ⁴ by the checker.
- *Float leakage.* No float reaches the checker. The known-positive plant shows the checker rejects a well-formed EMPTY tree for
  a lattice where Θ is nonempty.
- *A coverage gap in the branching.* The children cover ℤ by construction (≤ lo − 1, each k, ≥ hi + 1). The checker derives the
  constraints, and a dropped child is caught (plant).
- *Closed versus open interval.* The criterion's interval is closed, [1/3, 2/3], and so is the box B. A leaf needs a strict
  min_B > ρ, and the touching plant is rejected.
- *The ⟹ direction's hypotheses.* Torsion-free, finite and loop-free are all met (§1). Generation is not needed.
- *The integer lift.* Two quantities play different roles, and I checked that neither is mistaken for the other.
  - x_u = θ(u) − ⌊θ(u)⌋ is the representative in [0, 1). Its membership in [1/3, 2/3] is exactly "θ(u) mod 1 ∈ [1/3, 2/3]".
  - r·x ∈ ℤ needs only Σ r_u u = 0.

## 6. Theorems this phase proved

| # | statement | grade | where the proof lives |
|---|---|---|---|
| V2-T1 | (⟹ of the circular criterion) Λ torsion-free abelian, S = −S ⊂ Λ finite, 0 ∉ S: if Cay(Λ, S) is 3-colourable, some θ ∈ Hom(Λ, ℝ) has θ(s) mod 1 ∈ [1/3, 2/3] on S. It uses the forward {1, 2} lift, which needs no parity step. Generation is not needed; torsion-freeness is (ℤ/3 is the counterexample) | [hand], an independent re-derivation of the competition's criterion (attribution: FS-73 C3) | §1 |
| V2-T2 | (relation form) Θ ≠ ∅ ⟺ some x ∈ [1/3, 2/3]^N has r·x ∈ ℤ for every r in the relation lattice. ⟹ holds for any set of relations; ⟸ holds for a basis | [hand] | §2 |
| V2-T3 | Cay(L21cc6506, U) is not 3-colourable. Hence **χ(ℚ(√167)²) ≥ 4** | [cert]: the exact certificate `data/fs73/verify-v2/L21cc6506-empty.json.gz`, accepted by `tools/fs73v2_check.py`, with V2-T1 and V2-T2 | §5 |
| V2-T4 | Ld65c8ee8 (d = 11) has Θ = ∅; Ld14c588b (d = 167) has Θ ∋ θ = (−59516/783, 898727/600300, 55315/1044, 27001/18009), so ⌊3θ⌋ mod 3 3-colours it | [cert] | §4 |
| V2-T5 | For key D\|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2, every integer unit vector already lies in the key lattice. The unit vectors of L21cc6506 span the key lattice itself. No four of them form a basis, and the minimum index of four is 34,650 | [tools] + [hand] (the mod-4 parity argument) | §3 |

**Kernel decision.** V2-T3 is a finite certificate: 30,344 leaves, each a rational linear inequality over a box, plus 39 integer
relations. Its checker is ~150 lines of Fraction arithmetic. It is a natural kernel target:
- a `Bool` checker over ℚ, with a soundness theorem;
- V2-T2(a) and V2-T1 in Lean.

V2-T1 is the costly piece: amenability / Følner averaging, or an LP-duality replacement. This is flagged as a stub candidate for
the owner, not minted here.

## 7. After the verdict (committed at 7931a25e): comparison with implementer E and the competition proofs

I read `data/fs73/records/phase-P3b-q167-theta.md`, `plans/FS73-C3-Coxeter.md` §3 and `plans/FS73-C3-deBruijn.md` §2 C1 only
after that commit.

- **The verdicts agree.** E has Θ = ∅ by two routes: a θ-space tree of 605,203 nodes (7.7 MB gzipped), and a product-structure
  certificate (106 KB). My tree is a third, independent route. It uses different variables (relation values, not θ), a different
  root (the box [1/3, 2/3]^30, not a fundamental domain), different code, and a different checker.
  - My relation-form tree is **20× fewer nodes** than E's route 1, and 149 KB gzipped against 7.7 MB. It needs none of the
    lattice's structure.
  - E's §4 found that coordinates up to about 6,000 wreck a float MIP. My formulation never has that problem: every
    coefficient is a small relation entry (|r_j| ≤ 3), and the box is the unit-scale cube.
- **The ⟹ proofs agree in substance.** Coxeter's H-i and de Bruijn C1 lift to ±1 steps, use parity to make w − 3Σρ even, and
  extend by Hahn–Banach, with Poros's invariant mean as the second route. Mine lifts forward to {1, 2} steps, so no parity step
  is needed, and extends by the invariant mean. Both need torsion-freeness at the same place: R is a direct summand.
- **E's attack list, item by item.**
  1. *H-i "only if".* I re-derived it independently (§1). I found no gap. Generation is not needed.
  2. *R3, the completeness of Θ_R.* I checked it independently with `tools/fs73v2_thetaR.py`. It enumerates exactly every
     vertex of every cell of the 2-D arrangement in a window covering a period, and groups them by cell. Result: **modulo 5ℤ²
     there is exactly one 12-vertex cell centred at (5/2, 5/2), whose vertices are D0's 12, and four single-point cells at
     (5/2 ± 5/6, 5/2 ± 5/6).** That is P3b-T3 exactly, with no degenerate piece missed. (The argument: every cell is a closed
     convex polygon bounded by the ±1 and ±i strips, so it is the hull of its vertices, and every vertex is an intersection
     of two boundary lines.)
  3. *The enumeration of U.* My two loops (`fs73v2_units.py`, and the checker's own) are a fifth and sixth; both give 60.
- **E's structure, re-checked independently.**
  - U = {1, v, v̄, z, z̄}·U_R as a set equality: `tools/fs73v2_b5.py`, in exact field arithmetic over ℚ(√167)(i).
  - E's rotation formulas, derived by hand. Put m_b = θ(b) + iθ(ib). Then m_{cb} = c̄·m_b for c ∈ ℚ(i). With i√167 = 84v − 83
    this gives z = (1+i)(7/2 − 3v) and z̄ = (1−i)(3v − 17/7), hence μ_z = (1−i)((7/2)μ₁ − 3ν), μ_z̄ = (1+i)(3ν − (17/7)μ₁) and
    μ_v̄ = (83/42)μ₁ − ν. All three match §3 of E's record.

## 8. The extra question: a short, hand-checkable argument

**Yes, there is one. It is E's P3b-T4, and I have checked it line by line.** My machine runs independently locate it as the
*minimal* obstruction.

**The obstruction is exactly the product {1, v, z}·U_R.**
- I ran my finder on every sub-configuration b·U_R with b ranging over the 3-subsets of B5 = {1, v, v̄, z, z̄} (all ten), and on
  four of the 2-subsets.
- **Exactly two are empty:** {1, v, z}·U_R and its complex conjugate {1, v̄, z̄}·U_R. Each has an exact certificate of 1,050
  leaves (`data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`, 5.7 KB), and the checker passes it. All other twelve are
  nonempty, each with an exactly checked θ.
- This matches E's control, in which v̄ and z̄ alone give nonempty sets.
- A greedy deletion over the 18 pairs of {1, v, z}·U_R finds that **every pair is necessary**: removing any one makes Θ
  nonempty. So no sub-configuration of it with fewer unit vectors refutes 3-colouring.

**The hand argument.** It is P3b-T4, which I verified step by step.
- θ ∈ Θ(b·U_R) iff μ_b ∈ Θ_R. So the three conditions read:
  - μ₁ = c0 + 5k + δ₁,
  - ν = c0 + δ₂,
  - (1−i)((7/2)μ₁ − 3ν) ∈ Θ_R,
  with δ₁, δ₂ ∈ D0 ∪ F4, and D0 contained in the square |δ_x|, |δ_y| ≤ 1/6.
- Reduced mod 5ℤ[i], the third condition becomes η := (1−i)((7/2)δ₁ − 3δ₂) ∈ (5/2)·(i or 1) + (D0 ∪ F4), according to the
  parity of k₁ + k₂. The four cases then close by coordinate bounds:
  - **Both δ in D0.** |η_coord| ≤ 13/6 < 7/3, so no D0 target is reachable. An F4 target forces a = (1+i)η/2 to have a
    coordinate ±5/4 > 13/12.
  - **δ₂ in F4.** 3(1−i)δ₂ ≡ 0, so |η| ≤ 7/6 < 5/3.
  - **δ₁ in F4.** (7/2)(1−i)δ₁ ≡ (5/6)σ, and hitting a target needs (1−i)δ₂ = (−5/18, ∓5/18), so |δ₂| has a coordinate
    5/18 > 1/6.
  - **Both in F4.** η ≡ (5/6)σ, whose coordinates lie in {0, ±5/6}, and none of the targets has those.

I found no error. A half-page proof of χ(ℚ(√167)²) ≥ 4 therefore exists, modulo the criterion's ⟹ direction:
- the 36 unit vectors {1, v, z}·U_R;
- Θ_R's shape, which is a 2-D computation checkable by hand from the six strip families;
- four inequality cases.

**What I did not find.**
- A finite non-3-colourable subgraph. Neither certificate yields one directly, and I did not run the optional SAT search on a
  word ball.
- Any simplification below 36 vectors inside this family. Minimality under deletion is proved above; other families of
  sub-configurations were not searched.

## 9. Theorems this phase proved (continued from §6)

| # | statement | grade | where |
|---|---|---|---|
| V2-T6 | Θ({1, v, z}·U_R) = ∅, and the same for its conjugate {1, v̄, z̄}·U_R. The other 12 sub-configurations b·U_R tested (every 3-subset and four 2-subsets of B5) are nonempty | [cert] (empty: checked certificate; nonempty: exactly checked θ) | §8 |
| V2-T7 | {1, v, z}·U_R is minimal: deleting any one of its 18 ± pairs makes Θ nonempty | [tools] (finder verdicts; each NONEMPTY carries an exactly checked θ) | §8, `scratchpad/greedy.py` |
| V2-T8 | Θ_R = (5/2, 5/2) + (D0 ∪ F4) + 5ℤ², with exactly one 12-vertex cell and four single-point cells per period. This confirms E's P3b-T3 | [tools] exact + [hand] (the cell argument) | §7, `tools/fs73v2_thetaR.py` |
| V2-T9 | E's P3b-T4 hand proof, checked line by line, together with the rotation formulas μ_z, μ_z̄, μ_v̄ re-derived from m_{cb} = c̄·m_b | [hand], second reading | §7–§8 |
