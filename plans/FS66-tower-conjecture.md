# FS-66 — the conjecture that the residue towers are impotent: statements, prior art, routes, verdict

*Planner-mathematician's note, 2026-09-21. One author, no delegates. Light CPU only; nothing here touched the GPU, the solve at
23 or `data/fs66/ckpt/`. Tools: `tools/fs66_conj_*.py`; outputs: `data/fs66/conjecture/`. Status words: **[proved]** = a hand
proof written out below, line by line, with a falsifier that was run; **[cited]** = someone else's theorem, with how much of it
was read; **[measured]**; **[reading]** = believed, falsifiable, its killing test named.*

## 0. Verdict

**NOT PROVED — and the run at 23 should be left to finish.** No form of the conjecture is proved for any class of primes
containing 23, and I found no route that could deliver one without a computation at least as heavy as the one already running.
What *is* established, beyond what I was handed: **(i)** the exact logical position of the three forms — the run at 23 needs
(C-m) at `(23, 5)`, which follows from **either** (C-α) **or** (C-χ) at 23, and both (C-χ) and (C-m) are already theorems
(on the certificates' word) at **every** prime `p ≡ 3 (mod 4)` below 23, by three unrelated mechanisms (§1.4); **(ii)** the
**weighted form of (C-α) is false** at every `p` (Lemma W, §3.1): the fibre shares of a level-two independent set need not lie
in the stable-set polytope of level one, so *no* local rounding or transfer argument (route (a)) can exist — a proof has to be
global; **(iii)** **the equal-characteristic towers are impotent by a two-line proof** (Theorem E, §3.2), so the whole content
of the conjecture is one cohomology class — the Witt-vector carry — and **every spectral fact we own, the fibre-density
inequality and therefore every `B₁` certificate, is blind to that class** (Lemma T): they hold verbatim for every twisted cover
of level one; **(iv)** the liftable-subgraph route is exactly the statement *"the finite subgraphs of the `p`-adic plane have
fractional chromatic number up to `p²/α(G₁)`"*, the owner's suspected converse is **not** what the exactness theorem in print
gives (§2, §3.4), and **at 23 that route needs a finite graph with fractional chromatic number above 5.03 drawn with unit
distances in `ℚ₂₃²`, which cannot lie in any real field (the real plane caps at 4.36) and of which no example is known**.
**The sharpest obstruction, in one sentence:** any proof of (C-m) at `(23, 5)` is either *relative* — (C-α) or (C-χ) at 23,
for which the only mechanisms in sight are an exact-face certificate (strictly harder than the running solve) or a finite
23-adic witness nobody has — or *absolute*, in which case it contains a proof that `α(UD(𝔽₂₃,2)) < 105.8`, a fact known only
through a level-3 semidefinite certificate with 0.4 to spare. **For a proof to exist one of three things would have to be
true** (§5): a *global* exchange argument that prices the single-direction-line gains of Lemma W against `α(G₁)` without
knowing `α(G₁)`; fractional local–global tightness for one arithmetic graph whose best place is `p`; or exactness of a fixed
finite level of the moment hierarchy on these planes. None is in reach today. **Do not cancel the run.**

---

## 1. The statements, and what implies what

`p ≡ 3 (mod 4)` prime; `R_k = ℤ/p^k`; `G_k = UD(R_k, 2) = Cay(R_k², S_k)`, `S_k = {a² + b² = 1}`, `|S_k| = p^{k−1}(p+1)`;
`α_k = α(G_k)`, `n_k = p^{2k}`. `𝔊 = UD(ℤ_p, 2) = Cay(ℤ_p², S_∞)`, `S_∞` the norm-one group of `ℤ_p[i]`, compact,
`S_∞ = μ_{p+1} × U`, `U = {u ≡ 1 (mod p)} ≅ ℤ_p`. Reduction `G_k → G_{k−1}` is a homomorphism (the first plan's §S2; `[Madore2015]`
Prop. 3.8).

### 1.1 The three forms

* **(C-α)** `α_k = p^{2(k−1)} α₁` for all `k`.
* **(C-χ)** `χ(G_k) = χ(G₁)` for all `k`.
* **(C-m)** for every `m` with `m·α₁ < p²`: no `G_k` is `m`-colourable.

### 1.2 The chain, and the equivalents of (C-α) [proved; each step is two lines]

> `α₁/p² = α₁/n₁ ≤ α₂/n₂ ≤ α₃/n₃ ≤ … ↗ m₁(ℤ_p²) ≤ 1/χ_f^{fin}(𝔊)`.  (★)

* `α_k/n_k` is non-decreasing: pull an independent set back along `G_{k+1} → G_k`.
* Its limit is `m₁(ℤ_p²) := sup {Haar measure of a measurable independent set of 𝔊}` — first plan §S2 (Lebesgue density one way,
  pull-back the other). Checked again; it stands.
* `χ_f^{fin}(𝔊) := sup {χ_f(K) : K a finite subgraph of 𝔊}`. For finite `K ⊂ 𝔊`, weights `w` on `V(K)` and measurable independent
  `I`: `∫ Σ_{x∈K} w_x 1_I(x+t) dt = w(K)·μ(I)`, and for almost every `t` the set `{x ∈ K : x + t ∈ I}` is independent in `K` (for each
  edge `xy` of `K` the bad `t` lie in a translate of `I ∩ (I + (x−y))`, which is null), so `μ(I) ≤ α_w(K)/w(K)`; optimise over `w`.
* All `G_k` are vertex-transitive, so `χ_f(G_k) = n_k/α_k`.

Hence **(C-α) ⟺ `χ_f(G_k) = χ_f(G₁)` for all `k` ⟺ `m₁(ℤ_p²) = α₁/p²`** (a monotone sequence with that limit and that first term is
constant), and **`χ_f^{fin}(𝔊) = χ_f(G₁)` ⟹ (C-α)** — the liftable-subgraph form, in its sharp shape (weighted, and with `K` *any*
finite subgraph of `𝔊`, its residues not required distinct). **The converse is not proved and is not in print** (§2.2, §3.4).

### 1.3 Implications [proved]

* **(C-α) ⟹ (C-m):** an `m`-colouring of `G_k` has a class of size `≥ n_k/m > p^{2(k−1)}α₁ = α_k`.
* **(C-χ) ⟹ (C-m):** `χ(G_k) = χ(G₁) ≥ ⌈p²/α₁⌉ > m`.
* **(C-α) ∧ [`χ(G₁) = ⌈p²/α₁⌉`] ⟹ (C-χ).** Without the bracket neither of (C-α), (C-χ) implies the other: (C-α) fixes `χ_f` only,
  and (C-χ) allows `α_k/n_k` to creep up inside the same integer ceiling.
* **What the run at 23 needs is (C-m) at `(p, m) = (23, 5)`.** With row 71's `α₁(23) ≤ 105` (`5·105 < 529`) it follows from
  (C-α) at 23 **or** from (C-χ) at 23 (`χ(G₁(23)) ≥ 6` by the same certificate). The run itself attacks neither: it bounds
  `B₁(23)` (§3.3), which is a third sufficient condition.

### 1.4 Where each form stands today

| `p` | (C-α) | (C-χ) and (C-m) | mechanism |
|---|---|---|---|
| 3 | **theorem, all `k`** | **theorem** | level one is Hoffman-tight and the Hoffman ratio is constant up the tower (G54, row 72): `α_k ≤ n_k/3` |
| 7 | **level two only** (`α₂ = 686`, certificate); all `k` up to `⌊14.0152·49^{k−1}⌋` | **theorem** (`χ(G_k) = 4`) | twice over: `3·14.0152 < 49` (certificate), and independently the 189-point graph over `ℚ(√11) ⊂ ℚ₇` (row 74) is a finite 4-chromatic subgraph of `𝔊` |
| 11 | open (`3388 ≤ α₂ ≤ 3412`) | **theorem** (`χ(G_k) = 5`) | `4·28.2043 < 121` (certificate) |
| 19 | open (`α₁ ∈ {76, 77}`) | **theorem** (`χ(G_k) = 5`) | `4·77.5117 < 361` (certificate) |
| 23 | open | open — the run | — |
| ≥ 59 | open | five (and from 83/103 six) refused at every level | the constant Hoffman ratio (G54) |

"Theorem" above means: on the word of `tools/fs66_b1_cert_check.py` plus the hand links of `data/fs66/b1/SOUNDNESS.md`; nothing
is kernel. **So (C-χ) and (C-m) hold at every prime `p ≡ 3 (mod 4)` below 23, by three different mechanisms** (Hoffman tightness; a
finite 7-adic witness; `B₁` certificates) — which is itself evidence about the shape of the problem: there is no uniform
mechanism in hand, only per-prime facts.

---

## 2. §PA — the prior-art gate (about an hour; zbMATH Open API + arXiv; the first plan's §PA is not repeated)

**Verdict: the theorem is not in print, under any of the names below. Two theorems in print bear on the *shape* of a proof;
both are recorded with exactly what was read.** Queries (each a negative measures its words, G21):

| discipline's words | query (zbMATH `_search`) | result |
|---|---|---|
| independence ratio of covers / lifts / voltage graphs | `ab:"independence ratio" & (cover* \| lift* \| voltage)`; `ab:"independence number" & ("random lift*" \| "covering graph*" \| "voltage graph*" \| "regular cover*")` | 3 + 5 hits; only Amit–Linial–Matoušek 2002 (random lifts; already in the first plan, review only). **Nothing on algebraic covers keeping or raising the ratio** |
| fractional chromatic number / independence ratio of Cayley graphs under quotients | `(ab:"fractional chromatic number" \| "independence ratio") & ab:"Cayley graph*" & (abelian \| quotient* \| homomorph*)` | 4 hits: Hahn–Tardif's survey `[HahnTardif1997]` (the no-homomorphism lemma and the core of a vertex-transitive graph — used in §3.4, §3.6; **recalled, not re-read**), Brown–Nowakowski–Rall (ultimate categorical independence ratio — products, not covers), Collins, Godsil–Royle |
| measurable chromatic number / independence density | `ab:"measurable chromatic number" \| "measurable independence" \| "independence density"` | 24 hits — the `m₁(ℝⁿ)` line (Bachoc–Nebe–Oliveira–Vallentin, Oliveira–Vallentin, Bachoc–Passuello–Thiery, Ambrus et al. via our shelf), descriptive combinatorics (Conley–Miller, Bernshteyn, Weilacher). **None on a totally disconnected group** |
| the same on compact / profinite / `p`-adic groups | `(compact group* \| profinite \| compact abelian) & (independence ratio \| independent set* \| chromatic number) & (Cayley \| measurable \| Haar)`; `(p-adic \| profinite \| local field*) & (distance-avoiding \| independence ratio \| independent set*) & (measur* \| density)` | 4 irrelevant; 1 = `[BardestaniMallahiKarai2020]` (held, read by the first planner: nothing on the anisotropic case) |
| exactness of `m₁`-type programmes | author listing of DeCorte; arXiv:1804.09099 fetched and read in part | §2.1 |
| fractional chromatic number of the plane | `ab:"fractional chromatic number" & (plane \| "unit distance")` | 14 hits, all on our shelf or known (`[MatolcsiEtAl2025]`, `[DuczVarga2026]`, Cranston–Rabern, Bellitto–Pêcher–Sédillot, Grytczuk et al.) |

Not searched: MathSciNet; anything in Russian beyond zbMATH; the citing lists of `[DeCorteOliveiraVallentin2022]` (owed if §3.4
is ever pursued).

### 2.1 `[DeCorteOliveiraVallentin2022]` — *Complete positivity and distance-avoiding sets* (Math. Program. 191 (2022); arXiv:1804.09099). **Read first-hand today: Definition 2.1, Theorem 2.2, Theorem 5.1 and the paragraph after it, the opening of §7 and Theorem 7.1. Not read: every proof, §§3–4, §6, §§8–10.**

* Def. 2.1: a topological graph is *locally independent* if every compact independent set lies in an open independent set;
  Thm 2.2: metrizable vertex set + closed edge set ⟹ locally independent.
* **Thm 5.1** (verbatim): *"Let `G = (V, E)` be a locally independent graph where `V` is a compact Hausdorff space, `Γ ⊆ Aut(G)` be a
  compact group that acts continuously and transitively on `V`, and `ω` be a multiple of the pushforward of the Haar measure on
  `Γ`. If `Γ` is metrizable via a bi-invariant density metric for the Haar measure, then `ϑ(G, C(V)) = α_ω(G)`."* **Thm 7.1**: the
  same with the Boolean-quadric cone `BQC(V)` (kernels all of whose finite principal submatrices lie in the Boolean-quadric
  cone) in place of the completely positive cone `C(V)`.
* **It applies to `𝔊`** [my check of the hypotheses, hand]: `V = Γ = ℤ_p²` acting on itself by translation; `S_∞` is compact so
  the edge set is closed and `𝔊` is locally independent by Thm 2.2; the `p`-adic ultrametric is translation-invariant, hence
  bi-invariant on an abelian group, and it is a density metric (Lebesgue's density theorem for Haar measure on `ℤ_p^n`, by the
  martingale of the coset partitions). **So `m₁(ℤ_p²) = ϑ(𝔊, BQC)`: the measurable independence density of the `p`-adic plane is
  the value of a convex programme over positive-type functions `f` on `ℤ_p²` with `f = 0` on `S_∞` whose restrictions to every
  finite point set are Boolean-quadric.**
* **What this is not:** it is *not* the statement that finite **subgraphs** suffice. For a finite `U ⊂ ℤ_p²` with `H = 𝔊[U]`, the
  `BQC(U)` constraint together with positive type implies `δ ≤ α(H)/|U|` (the diagonal is constant, `Σ_{x,y∈U} f(x−y) ≥ |U|²·δ`
  by positivity of `f̂`, and a Boolean-quadric matrix vanishing on the edges is a non-negative combination of `1_J 1_Jᵀ` over
  independent `J`), but the programme also constrains the off-diagonal correlations, which no subgraph inequality sees. So the
  owner's suspected converse — (C-α) ⟹ `χ_f^{fin}(𝔊) = χ_f(G₁)` — **is not given by this theorem**; its real-plane analogue,
  whether `χ_f(ℝ²) = 1/m₁(ℝ²)`, is to my knowledge open (**not checked in the literature today**).
* **What it does give:** the dual of that programme is where a proof of (C-α) lives if one exists, and the `B₁` certificates
  are feasible points of relaxations of exactly that dual (§3.3).

### 2.2 `[ConleyKechris2013]`, `[Bernshteyn2022]` — summaries only, statements recalled, **neither read**

Conley–Kechris (Groups Geom. Dyn. 7): the measurable independence number of a free measure-preserving action is an invariant
of its weak-equivalence class, and all free actions of an amenable group are weakly equivalent; so for a finitely generated
`Λ ⊂ ℤ_p[i]` and finite symmetric `W ⊂ Λ ∩ S_∞`, the measurable independence ratio of the `W`-edges on `ℤ_p²` equals the upper
density `ᾱ(Cay(Λ, W))` of independent sets of a Cayley graph of `ℤ^r`. Bernshteyn (Ann. H. Lebesgue 5): for shift Schreier
graphs the Borel fractional chromatic number is the reciprocal of the measurable independence number. **Used only in §3.4's
reformulation, and only as orientation — nothing proved here rests on either.**

---

## 3. The routes

### 3.1 Route (a) — a transfer that turns a level-`k` independent set into a distribution on level-one independent sets. **DIES HERE BECAUSE the weighted form is false (Lemma W).**

The natural target: for `I` independent in `G_k` with fibre shares `φ_I ∈ [0,1]^{V(G₁)}`, show `φ_I ∈ STAB(G₁)` (the convex hull of
indicators of independent sets, closed downward); then `Σφ_I ≤ α₁`. Equivalently: a random independent set `T` of `G₁` with
`P(x ∈ T) ≥ φ_I(x)`.

> **Lemma W [proved; falsifier `tools/fs66_conj_line.py`, run at 3, 7, 11, 19, `data/fs66/conjecture/line.out`].** Let
> `I = {(a, b) ∈ R₂² : b ≡ 0 (mod p), a even as an integer in [0, p² − 3]}`. Then `I` is independent in `G₂`, its fibre shares are
> supported on the line `ℓ = {(j, 0)}` of `G₁`, which is an induced `p`-cycle, and `Σ_ℓ φ_I = (p² − 1)/(2p) > (p − 1)/2 = α(G₁[ℓ])`.
> So `φ_I ∉ STAB(G₁)`, and `max_I w·φ_I > α_w(G₁)` for `w = 1_ℓ`: **the weighted analogue of (C-α) fails, by `(p−1)/(2p)`, at every `p`.**

*Proof.* A unit vector `(s, t)` of `R₂` with `t ≡ 0 (mod p)` has `s² ≡ 1 (mod p²)`, so `s = ±1`. Two points of `I` differ by
`(Δa, Δb)` with `Δb ≡ 0 (mod p)`, so they are adjacent only if `Δa ≡ ±1 (mod p²)`; all `a` are even integers in `[0, p²−3]`, and the
only wrap, `p² − 1 ↔ 0`, is excluded. `|I| = p(p²−1)/2`; shares `|I|/p²`. The line: `j(1,0) ∈ S₁` iff `j = ±1`. ∎

*What it means.* In the coordinate `ν` of the first plan's §S1 the single-direction lines of `G₁` — the `p(p+1)/2` cycles
`x + 𝔽_p·s̄`, which partition the edges — unroll at level two into `p²`-cycles (holonomy 1), and an odd cycle `p` times longer
has a larger independence ratio. **The same thing happens to the cover `C_{p²} → C_p` of vertex-transitive graphs, where the
ratio does rise — so (C-α) is not a formal consequence of "regular cover of a vertex-transitive graph"; it asserts that on
these planes the line gains can never be afforded globally** (the owner's note §4 priced the pure-line family: 16–27 against
28 at 11). Any proof must therefore compare `Σφ_I` with the *number* `α(G₁)` — a quantity nobody can compute for `p ≥ 23` — and
not with a local structure. That is why route (a), in every pointwise or local form, is closed: any scheme that returns a
random independent set `T` of `G₁` with `P(x ∈ T) ≥ φ_I(x)` for every `x` is refuted by Lemma W on a line. A scheme that only keeps
the *mean* (`E|T| ≥ Σφ_I`) is not refuted — but it must put points of `T` where `φ_I` is zero, to repay what the lines gained, and
that is the global exchange argument of §5 (1), not a transfer.

**The section bound that does survive [proved].** Write a section as `f(x) = x̃ + p·g(x)`, `g : 𝔽_p² → 𝔽_p²` arbitrary. The edge
`(x, x+s̄)` is *kept* by `f` (i.e. `f(x+s̄) − f(x) ∈ S₂`) iff `⟨g(x+s̄) − g(x), s̄⟩ = −γ₀(x, s̄)`, one affine condition, where `γ₀` is
the carry of `x ↦ x̃` (§3.2). Let `K_g` be the spanning subgraph of kept edges. For `u ∈ 𝔽_p²` the set `{x : f(x) + pu ∈ I}` is
independent in `K_g`, and averaging over `u` gives `Σφ_I ≤ α(K_g)`. So **`α₂ ≤ p²·min_g α(K_g)`**, and every `K_g` omits at least
one edge of every single-direction cycle. The linear part of the conditions is the rigidity matrix of `G₁` over `𝔽_p`, so a
generic `K_g` has about `2p² − 3` edges of `p²(p+1)/2`. **Measured** (`tools/fs66_conj_edgecrit.py`, exact MILP): at 7,
`α(G₁ − e) = 14` (no edge is `α`-critical), but six random one-edge-per-cycle deletions gave `α = 15, 16, 16, 16, 16, 16`. Whether
*some* choice of one edge per cycle keeps `α = 14` is the necessary condition for this bound ever to be tight at 7;
`tools/fs66_conj_transversal.py` (exact, no-good cuts) was started on it — **its state at the time of writing is in §4** — and
for triangle-free `K` with `e ≤ 2·49 − 3 = 95` Shearer's bound already forces `α(K) ≥ 15`, so at 7 a tight `K_g` would have to be
massively over-braced *and* consistent with the carry: a shadow of an arithmetic configuration (§3.4), not a generic lift.

### 3.2 A new frame — twisted covers; the equal-characteristic theorem; spectral methods are twist-blind

**Definition.** For `γ : {oriented edges of G₁} → 𝔽_p` with `γ(x+s̄, −s̄) = −γ(x, s̄)`, let `G₂^γ` have vertices `(x, u) ∈ 𝔽_p² × 𝔽_p²` and
`(x, u) ~ (x + s̄, v)` iff `⟨v − u, s̄⟩ = γ(x, s̄)`. Changing the section by `g` replaces `γ` by `γ + ⟨δg, s̄⟩`, so up to isomorphism
`G₂^γ` depends on the class of `γ` in the cokernel of the rigidity map of `G₁` over `𝔽_p` — the dual of the space of
self-stresses (dimension `≥ p²(p−3)/2 + 3`, and every single-direction line is a self-stress). **`G₂ = G₂^{γ₀}` with `γ₀` the
carry of integer (Witt-vector) addition** — asserted entry by entry against a direct construction of `UD(ℤ/p², 2)` at 3 and 7
(`tools/fs66_conj_twist.py`). `γ = 0` is `UD(𝔽_p[ε]/ε², 2)`.

> **Theorem E (equal characteristic) [proved].** Let `A` be a local ring with maximal ideal `𝔪` and residue field `𝔽_q`
> (any `q`), **containing a subring that maps isomorphically onto `𝔽_q`** (e.g. `𝔽_q[[t]]/t^k`). Then for every `k`,
> `UD(A/𝔪^k, 2)` and `UD(𝔽_q, 2)` are homomorphically equivalent; hence `χ`, `χ_f` and the independence ratio are constant up the
> tower: (C-α), (C-χ), (C-m) all hold. **Corollary:** if `O` is the ring of integers of a finite extension of `ℚ_p` with
> ramification index `e ≥ 2` and residue field `𝔽_q`, then `O/π^k ≅ 𝔽_q[ε]/ε^k` for `k ≤ e` (`p ∈ π^e O`), so **the first `e` levels of
> the tower of a ramified place are impotent.**

*Proof.* The inclusion `𝔽_q ⊂ A/𝔪^k` is a ring map, so it carries `a² + b² = 1` to itself and is a graph homomorphism
`UD(𝔽_q) → UD(A/𝔪^k)`; reduction goes back. Homomorphically equivalent graphs share `χ` and `χ_f`; both are vertex-transitive,
so the ratio is `1/χ_f`. For the corollary, `O/π^k` has characteristic `p` when `k ≤ e`, and a complete local `𝔽_p`-algebra with
residue field `𝔽_q` contains a coefficient field (here finite: Teichmüller). ∎ *Falsifier:* the zero-twist row of
`data/fs66/conjecture/twist-p*.out` (the graph built is `p(p+1)`-regular with level-one spectrum `p·λ₁`); the statement itself
is a subring argument.

**So the entire content of the conjecture is the one class `[γ₀]` — the carry — and the question is whether that twist can
raise the independence number above the untwisted value `p²α₁`.**

> **Lemma T (twist-blindness) [proved; falsifier `tools/fs66_conj_twist.py`: the carry twist, the zero twist and 5 + 3 random
> twists at `p = 3, 7`, all off-level-one spectra inside `[−2p, 2p]`, the carry twist reading `−13.9712 = −c(7)·7` as in the
> owner's note §1].** For **every** `γ`, the adjacency operator of `G₂^γ` preserves the fibre-constant functions (acting there
> as `p·A₁`) and their orthogonal complement, and on the complement its spectrum lies in `[−2p, 2p]`. Consequently the
> fibre-density inequality `⟨φ, A₁φ⟩ ≤ 2Σφ(1−φ)`, the bound `α(G₂^γ) ≤ p²·B₁(p)`, and **every `B₁` certificate** hold for every
> twisted cover of `G₁`, not only for `G₂`.

*Proof.* Decompose a function on `G₂^γ` along the characters `u ↦ ψ(⟨u*, u⟩)` of the fibre, `ψ(t) = e^{2πit/p}`. For `u* ≠ 0`
and `g(x, u) = ψ(⟨u*, u⟩)h(x)`, the contribution of the edge direction `s̄` to `(Ag)(x, u)` is a sum of `ψ(⟨u*, v⟩)` over the line
`{v : ⟨v − u, s̄⟩ = γ}` times `h(x + s̄)`; it vanishes unless `u*` is orthogonal to the line's direction `i·s̄`, i.e. `u* = r·s̄`, and
then equals `p·ψ(r(⟨u, s̄⟩ + γ(x, s̄)))·h(x+s̄)`. `u*` determines `±s̄` (if it is of that form at all), so on the `u*`-isotypic part
`A` is either `0` or `p` times a **magnetic adjacency operator on the disjoint `p`-cycles `x + 𝔽_p s̄`** (unimodular phases), whose
eigenvalues are `2cos(·)`. ∎

*What it means.* (1) The `B₁` certificates at 7, 11, 19 prove more than was claimed: **no twisted cover of those planes rises
above `14.0152·49`, `28.2043·121`, `77.5117·361`** — in particular `α(G₂^γ(7)) = 686` for every `γ`. (2) **No instrument we own
can see the arithmetic of the carry.** If at some prime *some* twist of `G₁(p)` raises `α`, then `B₁(p) > α₁(p)` and the `B₁`
method cannot prove (C-α) there, even if (C-α) is true for the carry twist. (3) A twist *can* raise `α` on a sub-structure
(Lemma W is the twist of one line), so "no twist of `G₁` ever rises" is a statement about `G₁` as a whole. *[reading]* **It is
true: `α(G₂^γ) = p²α₁` for every `γ` and every `p`.** *Killing test: one twist at 11 with a verified independent set of 3,389
points* (`α(G₂^γ(11)) ≤ 3,412` leaves room; not run — a finder on 14,641 vertices against a plateau is a night, not minutes).

### 3.3 Route (b) — a structural reason for `B₁(p) = α(G₁(p))`. **DIES HERE BECAUSE the bare equality is a numerical fact about each plane and not a structural one; the form with cuts is a per-prime exactness question with no uniform handle.**

* *The bare `B₁` exceeds `α` on any graph with a maximum independent set `J` and an outside vertex `v` having exactly one
  neighbour in `J`* [proved]: put `φ = t` on `J ∪ {v}`, `t = (α+1)/(α+2)`; then `⟨φ, Aφ⟩ = 2t² = 2t(1−t)(α+1)` and
  `Σφ = α + 1/(α+2)`. So bare `B₁(p) = α₁(p)` **requires** every maximum independent set of `G₁(p)` to 2-dominate its complement.
  At 7 the certificate proves they do (`14.0152 < 14 + 1/16`); at 11 it does not decide it (`28.2043 > 28 + 1/30`), and the
  only evidence is the local search's 28.0000. Nothing makes this true for all `p`.
* *At 11 the bare optimum is a tie by coincidence* (owner's note §6: `25 + 3/2 + 3/2 = 28` at `c = 2`): a plane with three
  far-apart triangles beside a 24-set would have bare `B₁ > α`. The valid cuts (edges, triangles, liftable cycles) remove these,
  which is why the registered quantity is `B₁` with cuts.
* *With all liftable cuts*, the question "is `B₁^{lift}(p) = α₁(p)`" is: does the first non-trivial level of the dual of §2.1's
  programme, restricted to fibre shares, close the gap. By Lemma T a yes would prove the twist-free statement of §3.2 (3). I
  found no argument; and **a uniform argument would have to produce, from a fractional `φ`, an independent set of `G₁(p)` of
  size `≥ Σφ`, for planes whose `α` is unknown** — the rounding that the inequality itself supplies (sample `x` with probability
  `φ_x`, delete an endpoint of each surviving edge) gives only `α₁ ≥ Σφ − ½⟨φ, Aφ⟩ ≥ Σφ²`.

### 3.4 Route (c) — finite liftable subgraphs of ratio `α₁/p²`. **NOT CLOSED at 7; DIES at 23 BECAUSE the witness it needs is beyond anything known.**

* **Exact form** (§1.2): (C-α) at `p` ⟸ `χ_f^{fin}(𝔊) = p²/α₁`. Every finite `K ⊂ 𝔊` lies in a coset of a finitely generated
  `Λ = ⟨W⟩_ℤ ≅ ℤ^r`, `W ⊂ S_∞` finite symmetric, so `χ_f^{fin}(𝔊) = sup_W χ_f(Cay(Λ, W))`, and `1/χ_f(Cay(ℤ^r, W))` is the supremum of
  the independence ratios of its **finite quotients** (periodise a large box). One family of quotients is the tower
  (`Λ/(Λ ∩ p^k)`); the others are reductions at *other* places. So:

  > **(C-α) at `p` follows from fractional local–global tightness** — `χ_f(Cay(Λ, W)) = min over its residue targets` — **for one
  > arithmetic graph whose best target is `G₁(p)`.** That is this project's conjecture G48 in fractional form, at one field.

* **Examples that fail, and why** [proved, short]: `Λ = ℤ[ζ_{p+1}]`, `W = μ_{p+1}` (the Teichmüller points) — at 7 `W` is `±` a
  `ℤ`-basis, the graph is bipartite; at 11 it is a product of two triangular lattices, `χ_f = 3 < 4.32`. `Λ = ℤ[√D]`, `W` = the
  norm-one units (`(D/p) = −1`; all levels of the tower are quotients of this one graph when the fundamental unit generates
  `S_k`): **always bipartite** — `a² − Db² = 1` forces `a + Db` odd, the place above 2. `ℤ[(1+√5)/2]` escapes 2 (`𝔽₄`, four
  colours) but reduces to `G₁(3)`, `χ_f ≤ 3`. **In each case another place undercuts `p`; a witness must live in an order all of
  whose other stable places have `χ_f ≥ p²/α₁(p)`.**
* **At 7** the target is `7/2`, and candidates exist: fields `F ⊂ ℚ₇` in which 3 is not usable and 2 gives `𝔽₄`, e.g.
  `ℚ(√11)` (`L = 4` through 2 and 7; `χ_f(ℚ(√11)²) ≤ 7/2`). The 189-point certified core there is 1-minimal and sparse (452 edges),
  so its `χ_f` is near 3, not `7/2` (not computed to the digit — my first `χ_f` tool, plain constraint generation, stalled on
  degeneracy and I did not spend the budget on a better one); **the question is whether the 45,521-point piece it was cut from,
  or a thicker one, reaches `7/2`**. *[reading]* **`χ_f(ℚ(√11)²) = 7/2`.** *Killing test, and it is the cheapest honest experiment
  this note leaves: a weighted independence-ratio upper bound on the saturated `ℚ(√11)` lattice pieces of FS-61 (the machinery of
  FS-56 §fractional, pointed at `ℚ₇`-embeddable fields). A value of `7/2` proves (C-α) at 7 for all `k`, with no certificate;
  a plateau below it says nothing (G21).*
* **`G₁` itself can never be the witness** [proved at 7 and 11]: a homomorphism `G₁ → 𝔊` composed with reduction is an
  endomorphism of `G₁`; the core of a vertex-transitive graph is vertex-transitive and its order divides `p²`
  (`[HahnTardif1997]`; recalled, not re-read). Order `p` needs `p | α₁`: false at 11; at 7 it would be a triangle-free graph on 7 vertices with
  `α = 2`, impossible since `R(3,3) = 6`. So `G₁(7)`, `G₁(11)` are cores, the endomorphism is an automorphism, and the map would be
  a section up to symmetry — which the single-direction cycles forbid.
* **At 23: `p²/α₁ ≥ 529/105 > 5.03`.** A finite subgraph of `ℚ₂₃²` with fractional chromatic number above 5.03 **cannot lie in a
  field with a real place compatible with the conjugation** (it would be a real unit-distance graph, and `χ_f(ℝ²) ≤ 1/m₁(ℝ²) ≤
  4.36`), so it must be built over a field like `ℚ(√−7) ⊂ ℚ₂₃` with an indefinite-norm torus. **No such object is known, here or
  in print; producing one is at least as hard as anything this project has failed to find.** Route (c) cannot cancel the run.

### 3.5 Route (d) — the exact face at 7 as a model case. **OPEN, per-prime, and harder than a strict certificate.**

The tightened relaxation reads `14.0000` at 7 (float) and `28.04` at 11. What I can say: (1) *what makes 7 special* — `G₁(7)` has
a **linear** homomorphism onto the circular clique `K_{7/2}` (`(x, y) ↦ 2x + 3y`: the eight unit vectors `(±1,0), (0,±1), (±2,±2)`
map into `{±2, ±3}`; checked by hand), so its maximum independent sets are the 14-point unions of two adjacent parallel lines
of a non-square direction, `χ_c = χ_f = 7/2`, and the optimum is a highly symmetric face; at 11, `121/28` is not of that kind
(`11 ∤ 28`: no circulant core, no linear circular colouring), and I expect exactness at a fixed level to fail there as it
measurably does. (2) *What an exact-face certificate at 7 would prove:* `B₁^{cuts}(7) = 14` exactly ⟹ **(C-α) at 7 for every
`k`, and by Lemma T for every twist — `m₁(ℤ₇²) = 2/7`, the first exact measurable independence density of a `p`-adic plane.**
(3) *Why it does not help 23:* an exact face needs the dual to be rounded **on** the boundary of the cone (facial reduction,
rational reconstruction of a rank-deficient Gram matrix), where the shipped producer needs strict positive definiteness; and it
needs `α₁` known exactly, which at 23 it is not (`87 … 105`). So (d) is a candidate small theorem at 7, never a shortcut at 23.
A by-hand proof at 7 through the seven columns of `2x + 3y` (Kneser-type expansion between columns `j` and `j ± 2, j ± 3`) was
tried and **dies because** the cyclic sum of the column inequalities has slack `3N` at the extremal configuration — the
constraints along the two 7-cycles of `K_{7/2}` must be combined non-linearly, and I did not find how.

### 3.6 Route (e) — the counterexample hunt. **Nothing cheap is left to hunt.**

* `p = 3`, any level: **moot** — (C-α) is a theorem there (§1.4), for every twist (Lemma T + Hoffman: `81/(1 + 12/6) = 27`).
* `p = 7`, level two: closed by the certificate (`α₂ = 686`, for every twist). Level three: `33,614 ≤ α₃ ≤ 33,650`; a rise of at
  most 36 points in 117,649, behind a pulled-back optimum that no single-vertex move leaves (first plan §I6). Not run.
* `p = 11`, level two: `3,388 ≤ α₂ ≤ 3,412`; the honest cheap target if anyone wants one. Not run: FS-62's experience at 19
  (521,874 restarts to plateau at the true value on 361 vertices) prices a meaningful null on 14,641 vertices well beyond
  "minutes on a few cores", and a null would measure the finder (G21).
* **What I ran instead are falsifiers of the lemmas above** (§4), which is where an error of mine could hide.

---

## 4. Falsifiers and measurements run (all CPU, seconds to minutes; commands in each tool's docstring)

| claim | tool → output | result |
|---|---|---|
| Lemma W: the line set is independent in `UD(ℤ/p²,2)`, shares sum to `(p²−1)/(2p)` on an induced `p`-cycle | `fs66_conj_line.py` → `line.out` | holds at 3, 7, 11, 19 (exact integers, every unit vector checked) |
| the carry twist **is** `UD(ℤ/p², 2)`; Lemma T's spectral window | `fs66_conj_twist.py` → `twist-p3.out`, `twist-p7.out` | adjacency matrices equal entry by entry at 3 and 7; off-level-one spectrum in `[−2p, 2p]` for the carry, zero and 8 random twists; carry twist at 7 reads `−13.9712` (the note's `c = 1.995891`), zero twist `[−12.61, 14]` |
| `α(G₁ − e)`, random one-edge-per-line deletions | `fs66_conj_edgecrit.py` | 7: `14`; then `16, 15, 16, 16, 16, 16` |
| does any one-edge-per-line deletion keep `α(G₁(7)) = 14`? | `fs66_conj_transversal.py` → `transversal-p7.out` | **undecided at the time of writing** — the exact no-good-cut search had added ≈ 750 cuts (each a 15- or 16-set with 2–8 induced edges) without finding a transversal or proving there is none; the file holds the log. A FOUND is only a necessary condition for §3.1's section bound to be tight; an INFEASIBLE closes that sub-route at 7 by theorem |
| `χ_f` by plain constraint generation | `fs66_conj_chif.py` | **instrument failed** (degenerate LP on a vertex-transitive graph: no convergence in 2 min at 7). Kept only because its `plane`/`witness` loaders are reused; do not trust it as a `χ_f` oracle |

---

## 5. What would have to be true for a proof to exist

1. **A global exchange argument.** By Lemma W the fibre shares leave `STAB(G₁)`; by §3.1 the full fibres `X₁` of `I` are
   independent in `G₁` and have no neighbour among the partial fibres `X_f` (a full fibre occupies every line, so every line of a
   neighbouring fibre is blocked), so `α₁ ≥ |X₁| + α(G₁[X_f])`, and (C-α) at level two says: *the excess `Σ_{X_f} φ − α(G₁[X_f])` that lines can buy is always repaid by vertices that `N[X_f]` excludes from a
   maximum independent set of `G₁`.* A proof has to know something about **all** maximum independent sets of `G₁(p)` — for
   planes where not even their size is known. I regard this as the true difficulty, and as the same difficulty as the
   Paley-graph-type problem of `α(UD(𝔽_p, 2))` itself.
2. **Fractional local–global tightness at one field per prime** (§3.4). At 7 it is testable this month; at 23 it needs an
   object nobody has.
3. **Exactness of a fixed finite level of the hierarchy of §2.1's dual on these planes.** True at 3 (level one: Hoffman),
   numerically true at 7 (level two with cuts), numerically false at 11 at that level. No pattern to prove.

## 6. What I would do with another day; and proposals (I edited none of the protected files)

1. **The killing test of §3.4 at 7**: a weighted-ratio bound on FS-61's saturated `ℚ(√11)` / `ℚ(√23)` / `ℚ(√71)` lattice pieces.
   `7/2` there is a theorem — *the 7-adic tower never rises* — with a human-checkable witness instead of a Gram matrix.
2. **The exact-face certificate at 7** (§3.5) if (1) plateaus: facial reduction on blocks of size ≤ 27.
3. **Twists as an instrument** (§3.2): the zero twist is a *control with a known answer* (`α = p²α₁` by Theorem E) for every
   finder and every relaxation pointed at level two — FS-66 has had no positive control of that kind. And one random-twist
   finder run at 11 is the killing test of the twist-free reading.
4. **Proposed text changes, for the owner:** (a) `CLAUDE.md` G54/G45 or a new grokking — *the tower's content is the carry
   class; equal-characteristic towers and the first `e` levels of ramified places are impotent by a subring; every spectral
   instrument and every `B₁` certificate is twist-blind; the weighted form of the conjecture is false.* (b) The first plan's §S5
   "Conjecture, NOT claimed" line should cite Lemma W as the reason no local proof exists. (c) `data/fs66/b1/SOUNDNESS.md` §ST
   may state its conclusions for every twisted cover (Lemma T) — a free strengthening. (d) FS-39/FS-64 readers: §2.1's
   observation that `[DeCorteOliveiraVallentin2022]` Thm 5.1/7.1 applies verbatim to `ℤ_p²` is the exactness theorem the brief
   asked about; it is exactness of the completely-positive programme, **not** of finite subgraphs.

## 7. Decisions that were mine (choice · alternative · why · confidence)

| choice | alternative weighed | why | confidence |
|---|---|---|---|
| Spend the compute on falsifiers of my own lemmas, not on a finder at `(11, 2)` or `(7, 3)` | a local-search hunt for 3,389 / 33,615 | a null there measures the finder (FS-62 at 19); an error in Lemma W or T would have poisoned the verdict | high |
| Report NOT PROVED rather than PARTIAL | call Theorem E + Lemmas W, T a partial proof | none of them proves any case of (C-α), (C-χ) or (C-m) that was open; they locate the difficulty | high |
| Did not re-derive the fibre-density inequality or the certificates' soundness | audit `SOUNDNESS.md` L1–L6 line by line | the brief said not to; Lemma T re-proves the one link I lean on (the spectral window) in greater generality, with its own falsifier | medium-high — I did not re-check the rounding or the checker |
| Left the `χ_f` of the `ℚ(√11)` pieces uncomputed | build a column-generation `χ_f` solver with symmetry | it is a day's instrument, not an hour's; it is item 1 of §6 | medium — if a cheap exact `χ_f` instrument already exists in `tools/` (FS-56), this was an hour I should have found |
