# M63 phase H2 — §PA, the prior-art gate

*Run 2026-09-12 by de Bruijn, under WORKFLOW step 3a and `CLAUDE.md` G49/G50, against
`plans/M63-phaseH2-find-the-base.md` §5. Three readers: this file's author plus two delegated literature
sweeps; the advisor Poros ran the same question independently from its own side and its ledger is
`plans/POROS-2026-09-12-m63-phaseH2.md`. Every number below is marked **[measured]** (exhaustive, exact
arithmetic, this session), **[derived]** (arithmetic from a stated theorem), **[external]** (the literature's,
read as marked) or **[unverified]**.*

---

## §PA.0 — The four findings, in one page

**1. The question as §5 posed it has no answer, because the quantity is unbounded.** There is **no ceiling**
on how many module points can lie on a fixed circle. The squared radius is a relative norm,
`|p|² = N_{K(i)/K}(p₁ + i p₂)`, so the circle is a coset of the relative norm-one group of `K(i)/K`; that
group is **infinite** (Hilbert 90 over a cyclic degree-2 extension: it is `{w/w̄}`), so the circle carries
infinitely many `K`-points and any thirty of them generate a rank-≤ 8 module containing thirty circle points.
**Falsifier §8.1 does not fire: the mission is not ended by a bound.** Poros reached the same verdict by the
explicit parametrisation `w = (1+it)/(1−it)`; two routes, one answer.

**2. But the *count* has an exact closed formula, it is in print, and it was not found by looking in number
theory — it is in the quasicrystal literature.** `[BaakeGrimm2003]`, *A note on shelling*, Theorem 1 and
Corollary 1: for a planar module `O` that is the ring of integers of a field with class number one, over the
real subring `Ō`, the number of module points on the circle of squared radius `r² ∈ Ō` is

```
c(r²)  =  N · ∏             ( v_p(r²) + 1 )        =  N · Σ          χ(𝖆)
             p | r², p splits                              𝖆 | r²Ō
```

zero unless every **inert** prime divides `r²` to an even power, where `N` is the number of units of `O` on
the unit circle and `χ` is the quadratic character of `O/Ō` (+1 split, −1 inert, 0 ramified). Their Remark
after the proof extends it verbatim to "a totally complex field extension `K` of a totally real field `k`
whenever `K` has class number one" — **our case exactly**, with `k = ℚ(√3,√11)` and `K = k(i)`.
**Verified here at six independent points on our own field [measured], including the mission's own circle.**

**3. For our field `N = 12`, and the only prime that can pay is the one above 3.** `μ(K(i)) = μ₁₂`, order
**12** — not 6 — because `√3 ∈ k` puts `ζ₁₂ = (√3+i)/2` in `K` (three independent derivations: this file,
Poros, the norm-form sweep). The primes above 2 are **inert** with residue field `𝔽₄` (this is Theorem B's
own `𝔽₄`), so they contribute a factor of exactly **1** however high their exponent; the prime above 3 has
norm 9 ≡ 1 (mod 4) and **splits**, so it is the whole source of multiplicity. Hence for any module `M`

> **count = |U_M| · (v_𝔮(α_eff) + 1)**, where `U_M = {ζ ∈ μ₁₂ : ζM = M}` and `α_eff` is the squared radius
> divided by the norm of the module's scaling.

This single formula reproduces **every row of the brief's §2 table**, including two it was not fitted to:

| object | `|U_M|` | `v_𝔮(α_eff)` | formula | brief's measured value |
|---|---|---|---|---|
| `Λ_parts` at `ρ₁₅`, circle `|p|² = 4` | 6 (`ζ₆`, not `ζ₁₂`) | 4 | 6 × 5 = **30** | **30** ✓ out-of-sample |
| `Λ_parts` at the second angle, circle `α/2` | 6 | 2 | 6 × 3 = **18** | **18** ✓ out-of-sample |
| last night's base, circle `α` | 4 | — | 4 × 2 = 8 | 8 ✓ (module not a scaled ideal) |
| `(1/3)·(O_k ⊕ O_k)`, circle `α` | 4 | 2 | 4 × 3 = **12** | **12** [measured here] |
| `(1/3)·O_L`, circle `α` | 12 | 2 | 12 × 3 = **36** | **36** [measured here] |

The two out-of-sample rows are Poros's catch, not mine: the bound was derived from the arithmetic of `α` and
then found to retro-predict the brief's own 30 and 18. It could have failed and did not.

**4. Consequences the mission should act on, in order of value.**
- **`~30` on the target circle is already reachable without paying for depth: use the maximal order.**
  `(1/3)·O_L` carries **exactly 36** points on `|p|² = (7+√33)/3` [measured]. The lever is `ζ₁₂`-closure
  (`|U| = 12`), which costs no 3-adic depth — not more denominator. Note 30 itself is **impossible** on a
  `ζ₁₂`-closed module (12 ∤ 30); such a module gives 36.
- **The current target circle is the arithmetically poor choice.** `v_𝔮(α) = −2` against `v_𝔮(4) = 0` for
  the record: the target is 3-adically deficient by exactly `𝔮²`, which is the whole reason a module of
  Parts's coarseness yields 18 there where his yields 30.
- **`n = 2` — the product owner's suspicion is not explained by counting, and the arithmetic says it is a
  live member nobody has looked at.** Its circle is `|p|² = 2`, and 2 is a **unit** at the prime above 3, so
  its count equals the record's exactly: **60 points on `(1/3)·O_L`, against 36 for the current target**
  [measured, both]. Its radicand is `4n−1 = 7`, so it lands in `K(√7)` — which `CLAUDE.md` **G43 lists as
  6-open**, where the record's own `√15` gives `K(√5)`, which G43 says is **5-sealed**. **It was never in
  phase G's census** (§PA.4 Q4: resolved, with the mechanism), so nobody looked — which is not the same as
  it working. **Two things keep it second rather than first**, both from Poros: its circle is not *free* —
  the radius is `√2`, not a rational integer, so it is not a shell of the unit-distance lattice, where
  `n = 16` is the smallest member that is free **and** 6-open; and its arena is thin (endpoint bound
  `4/√7 = 1.5119`, inside which Parts's lattice holds 499 points). `ρ₆₃` (`n = 16`) therefore takes the
  solver slot first on value of information — its answer re-ranks `n = 2` and not conversely — and `n = 2`
  needs design rather than a solver, so the two do not contend.

---

## §PA.1 — The object, named in each discipline's vocabulary (gate Q1)

Never searched in this project's words. The translations used:

| this project | the discipline's name | discipline |
|---|---|---|
| points of a module on one circle | **central shelling function** `c(r²)`; **shelling numbers** | aperiodic order / mathematical crystallography |
| the same count | **representation number of a binary quadratic form**; `r(λ)` / `f(ξ,𝖆)`; **A-number** representations | quadratic forms, algebraic number theory |
| the same count | number of solutions of a **relative norm equation** `z·z̄ = α` | computational number theory |
| "can a module put 30 points on this circle" | representation by the **norm form of a CM extension** | Diophantine equations (norm form equations) |
| a base and a rotated copy of itself | **coincidence site lattice / coincidence site module**, index `Σ(R)` | crystallography |
| the rotation family `cos θ = 1 − 1/(2n)` | `[Polymath16wiki]`'s `ω_t` (already recorded, phase G §PA2) | the Polymath16 corpus |

---

## §PA.2 — The original question: answered, and the answer retires the framing

**Stated in the literature's words: "how many representations does a totally positive element of a totally
real field have as a sum of two squares, over a module?"**

**The finiteness is completely classified, in 1962.** `[Nagell1962]` Theorem 7: there are infinitely many
representations of every representable number in every algebraic field **except** `ℚ(i)` and the **totally
real** fields. His Theorem 4 is our case — a totally real base gives finitely many — and the proof is the
archimedean bound, i.e. compactness of the norm-one torus in elementary dress. He also proves exactly one
representation of 1, of every representable prime, and of every representable unit, over a totally real base.
So the count over a **fixed** module is finite and classically known to be so; what is unbounded is the count
**over all modules**, and that is finding 1 of §PA.0.

**The exact count is `[BaakeGrimm2003]` Theorem 1 / Corollary 1 + the Remark** (finding 2). This is the
formula the product owner's hypothesis reached for, and it exists — but in *Discrete & Computational
Geometry* via quasicrystal physics, in a literature that cites neither the Hadwiger–Nelson corpus nor the
totally-real quadratic-forms corpus. **This is G49's failure mode exactly, and the gate caught it.**

**The square-lattice case is Fermat/Jacobi**: `r₂(n) = 4·∏(v_p+1)` over `p ≡ 1 (mod 4)`, zero unless every
`p ≡ 3 (mod 4)` occurs to even order. Baake–Grimm did not invent a mechanism; they generalised this from
`ℤ[i]` to `ℤ[ζ_n]`, and their Remark generalises it to any class-number-one CM field. Worth saying because
it means the formula is as solid as Fermat.

**The averages line is deep, real, and about a different quantity.** `[Schaal1965]` — whose title *is* our
question — proves a **mean value**, not an exact count: for an ideal `𝖆` of a totally real `K` of degree `n`,
`Σ_{ξ ∈ 𝖆², 0<ξ^(h)<x_h} f(ξ,𝖆) = (π^n/(d·N(𝖆)²))·x₁···x_n + O((x₁···x_n)^{n/(n+1)+δ})`, where
`f(ξ,𝖆) = #{(μ,ν) ∈ 𝖆² : ξ = μ²+ν²}` is literally the mission's quantity and `𝖆` **may be fractional**.
Dividing by the number of candidate radii gives **mean occupancy `π^n/√|d_K| = π⁴/132 ≈ 0.738`, independent
of `𝖆`** [derived from his main term]. So refining a module does **not** raise the mean — it adds circles.
**30 is a ~40× fluctuation above the mean, not a typical value**, and "maximise the circle count" means
"hunt a large divisor-function fluctuation", which is what finding 3 makes precise. Lineage of the question:
Siegel 1923 → `[Siegel1936]` → Schaal 1962 → `[Schaal1965]` → Rausch 1988 → `[ChamizoMiatello2018]`.

**A negative that matters, and it is instructive:** `[ChamizoMiatello2018]` §7 computes individual values of
this function by **brute-force box enumeration** with a symmetry reduction, remarking that it "is essentially
a divisor function in `O[i]`" and "seems hard to implement in an efficient way". A 2018 research paper on
exactly this function does not have a closed formula to hand and does not act as though one exists — which
is how a formula sitting in a 2003 crystallography paper stays invisible to the field that needs it.

**The analytic reason the naive divisor-sum fails at `k = 2`**, which is the cleanest citation in the whole
sweep: `[Gundlach1978]` states its own scope as holding "at least for `2 | k`, `k > 2`" — **`k = 2` is
excluded**, because there is no weight-one Hilbert Eisenstein series to supply the divisor-function main
term. Siegel–Weil averages theta series **over a genus**; an individual class is not an Eisenstein series.
That is the literature's explanation of §PA.3's measured refutation.

---

## §PA.3 — Verdict on the product owner's hypothesis, link by link

His three unverified links, adjudicated. **Two confirmed, one refuted, and the refutation is the useful one.**

### Link 2 — "is `α` a norm at all?" **CONFIRMED, two independent ways.** No fault in the framing.

`α = (7+√33)/3` is a relative norm from `K(i)`, so the circle is non-empty and a "not a norm" answer — which
would have meant the field or the form was wrong — does not arise.
- **Constructively** [measured]: the brief's witness re-derived independently, by hand and again in sympy.
  With `a = 1/3`, `b = √3/2 + √11/6`, `u = (a−b, a+b)`, so `|u|² = 2a² + 2b²` and
  `b² = 3/4 + 11/36 + √33/6 = 19/18 + √33/6`, giving `|u|² = 2/9 + 19/9 + √33/3 = (7+√33)/3`. ✓
- **Structurally, independent of any witness** [derived]: `α` is totally positive (`(7−√33)/3 = 0.41848…`),
  and by Hasse–Minkowski `α` is a sum of two squares in `k` iff it is a local norm everywhere; the only
  anisotropic places in its support are the two primes above 2, which are inert, where the condition is
  `v_𝔭(α)` even — and `v_{𝔭₁}(α) = 6`, `v_{𝔭₂}(α) = 2`. ✓
- Note `α` is **not an algebraic integer**: `minpoly(α) = 9x² − 42x + 16`, ℚ-norm 16/9, trace 14/3
  [measured]. The denominator 3 is not incidental — it *is* the `𝔮`-deficiency of finding 4.

### Link 1 — "is the norm-one unit group exactly `⟨ζ₆⟩`?" **CONFIRMED in substance, and the group is twice as big.**

The correct statement: `K(i)` is a **CM field**, so for a norm-one unit `z` every archimedean absolute value
is 1, and **Kronecker (1857)** gives `z ∈ μ(K(i))`. And `μ(K(i)) = μ₁₂`, order **12**: `μ_n ⊆ K(i)` needs
`ℚ(ζ_n) ⊆ K(i)`, hence `(ℤ/n)*` elementary 2-abelian, hence `n | 24`; `n = 8, 24` need `√2`, absent from the
square-class group `⟨−1,3,11⟩`; `n = 12` is present as `ζ₁₂ = (√3+i)/2`. Three independent derivations agree.

**The load-bearing correction: the multiplier is not `|μ(K(i))|` but the stabiliser
`U_M = {ζ ∈ μ₁₂ : ζM = M}`.** It is 12 for the maximal order, 6 for a `ζ₆`-closed module such as
`Λ_parts`, and **4 for the coordinate module `O_k ⊕ i·O_k`** (since `√3/2 ∉ O_k`, so `ζ₁₂ ∉ O_k[i]`). His
`⟨ζ₆⟩` is right for the modules the mission actually holds and wrong for the ambient field. A consumer that
divides a count by 12 when the module is the coordinate lattice is making a factor-of-three error.
**Attribution for the orbit structure:** `[FiekerJurkPohst1997]` states it — solutions computed "up to units
of relative norm 1", i.e. "nonassociate" — with Lemma 4.1 supplying the explicit fundamental box.
**Do not cite "Washington, Lemma 1.6"** for Kronecker's theorem: the sweep could not verify that lemma number
against the book and flagged it rather than pass it on. Cite Kronecker, or check the physical copy.

### Link 3 — "does a non-maximal module preserve the ideal-theoretic count?" **REFUTED, measured.**

This is the one that bites, and it is the reason the gate earned its time. Over the module `O_k ⊕ i·O_k`,
exhaustive counts in exact arithmetic with every solution re-verified by exact re-substitution [measured]:

| `ξ` | 1 | 2 | 3 | 4 | 5 | 6 | 9 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|
| count | 4 | 4 | 4 | **12** | 8 | 4 | 4 | 4 | **36** |

The divisor formula predicts **36** at `ξ = 3` (three divisors at the split prime above 3, each `χ = +1`).
**Measured: 4.** And the count over 4 is **not multiplicative** across the coprime parts 3 and 4:
`f(4)/4 = 3`, `f(3)/4 = 1`, `f(12)/4 = 9`, and `3 × 1 ≠ 9`. No ideal-divisor count can do that.

**The resolution, and it is not that the formula is wrong.** `O_k ⊕ i·O_k` is a **non-maximal order**:
`O_L ⊋ O_k[i]`, and I computed `O_L` explicitly (§PA.7). Re-running the identical test **on the maximal
order** gives the formula back exactly, at every point [measured]:

| `ξ` | 1 | 2 | 3 | 4 | `9α` (the mission's circle) | `9·2` (`n=2`) | `9·4` (the record) |
|---|---|---|---|---|---|---|---|
| Baake–Grimm predicts | 12 | 12 | 36 | 12 | **36** | 60 | 60 |
| measured over `O_L` | 12 | 12 | 36 | 12 | **36** | **60** | **60** |

**So: the formula is exact on the maximal order and false on the sub-order, and the mission's modules are
sub-orders.** What survives for an arbitrary module is the **upper bound** `count ≤ |U_M| · ∏_{split}(v+1)`,
never violated across all thirteen counts measured and **tight at `ξ = 4, 12, 36`**. Poros has recorded the
consequence that actually bites the phase: **a divisor formula predicting circle counts errs in the
optimistic direction**, so a plan that prices a candidate module from the formula rather than by exhaustive
count will promise points it does not have. `[BaakeGrimm2003]`'s own §0.1.5 warning is the same shape — they
show the norm-only shortcut first fails at `m = 169`, where three ideals of the same norm have shell numbers
36, 48, 36. **The count is a function of the ideal, not of the radius's rational norm.**

---

## §PA.4 — The re-aimed questions (product owner, mid-gate)

### Q1 — Is `cos θ = (2n−1)/(2n)` a known coincidence-rotation family, with tabulated indices?

**The room is confirmed as the right one, and the family's home lattice is not the hexagonal one.**
`ρ_n = ((2n−1) + i√(4n−1))/(2n)` has `|ρ_n|² = 1`, so it is a norm-one element of `ℚ(√−(4n−1))`, and by
Hilbert 90 it is `ᾱ/α` for `α ∈ ℚ(√−(4n−1))` — explicitly `α = (1 + i√(4n−1))/2` gives `−ρ̄_n` [derived].
So **`ρ_n` is a coincidence rotation of the imaginary quadratic order `ℤ[(1+i√(4n−1))/2]`, not of the
hexagonal lattice** — Poros's caution was right and now has a reason: a coincidence rotation of `ℤ[ζ₆]` must
lie in `ℚ(ζ₆) = ℚ(√−3)`, and `ρ₁₅ ∈ ℚ(√−15)` does not. `[PleasantsBaakeRoth1996]` classifies all planar
coincidence isometries for `N < 46` by exactly this reduction — "the multiplier ring … is the ring of
rational integers in the generic case, and **an order in an imaginary quadratic field** otherwise", with
Dirichlet-series generating functions for the counts by index **[external, from the search listing and the
survey's description — the paper itself is NOT read]**.

**Not settled: whether this family appears as a named sequence with tabulated `Σ`.** I did not reach the
paper's tables. **The family is, however, already prior art in this project's own records** — phase G §PA2
marks `cos = 1 − 1/(2|u|²)` as `[Polymath16wiki]`'s `ω_t`, and phase G line 125 records `[PartsOdd2022]`
using `arccos(31/32)`, which is `ρ₆₃` at `n = 16`. So the *angle family* is in print; the claim that matters
is about the *construction*, which is Q3.

### Q2 — Lattice points on circles: the classical extremal results

**[external, read as marked by the delegated reader.]** The square-lattice maximum is unbounded but
sub-polynomial, governed by the divisor bound (`d(n) = O(n^ε)`, and `d(n) > n^{(1−o(1))log2/loglog n}`
infinitely often) — Rudnick's open-problems notes, read §1.1–1.2. **Schinzel's theorem** (a circle through
exactly `n` lattice points) and **Kulikowski** (higher dimensions) are about choosing the *circle*, not the
lattice. **Cilleruelo–Córdoba** price "many points" against "how closely they may cluster" — at most `l`
points on an arc of length `≤ √2·m^{1/4 − 1/(8⌊l/2⌋+4)}`, and `O(log m)` points on an arc of length `m^{1/4}`
— with the **Cilleruelo–Granville** conjecture that arcs of length `R^{1−δ}` hold `O_δ(1)` points.

**The explicit negative, and it was the highest-value ask: no statement anywhere relating the number of
points on one circle to the lattice's determinant or covolume.** Searched under nine phrasings across three
databases by two readers. In every source the module is the **maximal** one and the question is "as a
function of `r²`, for fixed `O`". `[BaakeZeiner2017]` — the field's own authoritative survey — studies
submodules intensely (similar submodules, coincidence site modules, Bravais classes as ideal classes,
Dirichlet series counting them by index) but **never for their shell occupancy**. The trade-off is not stated
as a theorem, and **not stated as an open problem either**.

**And the reason it is not stated is that it is the wrong shape, which corrects the brief's own framing.**
The ceiling `N·∏(v+1)` is computed on the smallest `O_L`-module containing yours and is **covolume-free**.
Coarsening can only lose points. So "how fine must the module be" is the wrong question; the right one is
*"which submodule retains the most of an already-enumerated finite point set?"* — a hitting problem over an
enumerated shell, which is the shape of this project's own ledger row 62. That reframing is the delegated
reader's, and it is the most useful structural remark in the sweep.

### Q3 — Has anyone in print built a base-plus-rotated-copy graph at another rotation?

**The primary source says no, in its own words, and it is already in our bibliography.** `[Parts2020a]`:
**"Working constructions of type M with other rotations are not known yet"** — one of the two open questions
that entry records verbatim. Nothing in this gate's searches contradicts it. What I could not do is search
the Polymath16 corpus and the crystallography literature exhaustively for a construction rather than an
angle; `[PartsOdd2022]`'s `arccos(31/32)` is a construction on the hexagonal lattice for the **odd-distance**
problem, a different question, and I did not open it. **Recorded as: unrefuted, not confirmed.**

### Q4 — Why does nobody use `n = 2`, `ρ₂ = (3+i√7)/4`, radius `√2`?

**Not because of the count, and the arithmetic says it is the strongest member in sight.** Three facts:
1. `r² = 2` is a **unit at the prime above 3**, exactly like the record's `r² = 4`, so its circle count is
   **identical to the record's**: 60 on `(1/3)·O_L`, against 36 for the current target [measured, all three].
2. Its radicand is `4n−1 = 7`, so its arena adjoins `√7` and lands in `K(√7)` — **6-open** by `CLAUDE.md`
   G43 and G37 (7 ≡ 7 mod 8 breaks the 2-adic wall, and 7 is a non-residue mod 11, so 11 is inert). The
   record's `√15` gives `K(√5)`, which G43 says is **5-sealed**. `n = 16` (`√63 = 3√7`) shares the field and
   is already one of G8's four generators.
3. Its radius `√2 ≈ 1.414` is **smaller** than the record's 2, and the brief's §6 endpoint bound says radius
   is pure cost.

**So the honest answer to "if any paper explains why `(3+i√7)/4` is useless, that ends a line of work" is:
no paper does, and this gate's arithmetic says it is not useless.** I found no citation ending that line and
no reason to expect one.

**The registered prediction, and it RESOLVED in the informative direction** (Poros, from
`data/m62/m63-phaseG-screen-r2.44.json`, 2026-09-12). I registered: *if `n = 2` was in phase G's
eleven-rotation census this is a reproduction; if it was not, the census's generator image excluded it.*
`n = 2` needs `cos θ = ±3/4`; the eleven census cosines are `−7/8` and ten values in `ℚ(√33)`, and **`±3/4`
is not among them.** Exactly **one** of the eleven is in the family at all, and it is the record. So this is
a finding and not a reproduction.

**The mechanism of the omission is worth more than the omission, and it is §7's trap in a new form.** The
census was *enumerated on Parts's lattice*, and that lattice has **0 of 3,433 points** on `|p|² = 2`
[Poros, measured]. A rotation whose circle is empty over the enumerating base yields no equal-radius kind
there and never becomes a candidate. **So the one member of the family whose field is 6-open was excluded by
the base the list was computed on.** FS-30 already records that the rotation list "was computed on the wrong
base"; there the base-dependence *mis-counted* a rotation, here it **omitted** one — and an omission leaves
no row for anyone to audit, which is strictly worse. **The durable rule for the next census: enumerate the
parameter first — `cos θ = (2n−1)/(2n)` is one integer — and screen bases against it second, never the
reverse.**

**Scope, so this is not oversold.** Absence from the census means **nobody looked**, not that it works.
`n = 2`'s live risk is unchanged and it is thinness: its endpoint bound is `4/√7 = 1.5119`, inside which
Parts's lattice holds only 499 points, so the whole cross-edge-bearing arena is ~1,000 vertices against a
509-vertex record that was *reduced* from a 3,433-point base [Poros, measured]. And the ordering against
`ρ₆₃` (`n = 16`) is on value of information rather than cost: **`ρ₆₃`'s solver answer re-ranks `n = 2`, and
`n = 2`'s does not re-rank `ρ₆₃`**, so `ρ₆₃` takes the solver slot first; `n = 2` is second and needs design
rather than a solver, so the two do not contend.

---

## §PA.5 — Every search, in the exact words it was run

**Mine (Claude WebSearch, US index).** A negative here is a finding about where the unworked ground is.

| # | query as run | outcome |
|---|---|---|
| 1 | `representation numbers of a quadratic form over a totally real number field theta series Hilbert modular form` | partial — Hilbert modular machinery, half-integral weight, no `k = 2` |
| 2 | `number of elements of given relative norm in a quadratic extension of a number field counting formula` | hit — the classical `\|O*\|·Σ_{c\|n}(D/c)` shape, absolute case only |
| 3 | `sums of two squares in a real quadratic field number of representations formula Hecke character` | **hit** — Chamizo–Miatello |
| 4 | `"sum of two squares" totally real field theta series weight one Hilbert modular Eisenstein series divisor sum` | partial — Eisenstein coefficients are divisor sums, no `k = 2` |
| 5 | `Schaal "expression of a number as the sum of two squares in totally real algebraic number fields" 1965 Proceedings American Mathematical Society` | **major hit** — the question's title, 1965, pre-arXiv |
| 6 | `maximum number of lattice points on one circle lattice of given determinant extremal shell count bound` | **negative** — only the `ℤ²` divisor picture; nothing on determinant |
| 7 | `exact formula number of representations by binary quadratic form over ring of integers of a number field ideal divisor sum class number` | partial — the ideal-factorisation mechanism as folklore; Gauss composition over number fields |
| 8 | `unit distance graph coordinates quadratic field how many points on a circle same radius count rotation Moser lattice` | **negative** — the count does not appear in the unit-distance literature |
| 9 | `Nowak "summation formula in algebraic number fields and applications" 1990 Journal of Number Theory sum of two squares representation` | partial — an analytic summation formula (Piltz divisor problem), not an exact count; ScienceDirect blocked |
| 10 | `binary quadratic form representation numbers not determined by local densities genus class number Siegel-Weil exception weight one theta series` | **hit on the mechanism** — Siegel–Weil averages over a *genus*; an individual class is not an Eisenstein series |
| 11 | `coincidence site lattice module rotated copy unit distance graph construction chromatic number plane rotation other than known angle` | **negative on the join** — CSL and unit-distance colouring are studied separately, never together |
| 12 | `coincidence rotations imaginary quadratic ring coincidence index Sigma planar lattice Baake Pleasants tabulated cos theta rational` | **hit** — Pleasants–Baake–Roth 1996; the multiplier ring is an order in an imaginary quadratic field |

**Scriptable databases, mine.** Crossref `query.bibliographic` found Schaal's DOI where OpenAlex's free-text
`search=` returned the R manual, a graphene review and cluster algebras — **OpenAlex's relevance search is
unusable for a long mathematical phrase; only `filter=title.search:` behaves.** Recorded so nobody repeats it.

**Two-database cross-check (gate Q7), and it fired in the opposite direction from the precedent.** Citing
works of `[Schaal1965]`: **OpenAlex 4, Semantic Scholar 120.** I opened the S2 list: it contains
*p*-Bessel functions, watermarking capacity, contagion maps on tori and 3-D-printed foams. **S2's count is
reference-matching pollution; OpenAlex's 4 is the trustworthy figure, and only one of the four
(`[ChamizoMiatello2018]`) is about this function.** The precedent in G50 was S2 carrying the informative
extras; here the bigger number is the wrong one — which is only knowable by opening the list rather than
comparing counts. Both delegated readers reproduced this cross-check independently and reached the same
verdict. Separately, the shelling reader found forward citations of `[BaakeGrimm2003]` at **OpenAlex 14,
Semantic Scholar 7, neither a subset of the other**.

**Citation graph of the paper that posed the question (gate Q5).** `[Schaal1965]`'s own references are
Behnke 1923, Hecke 1917 and 1918, Schaal 1962, `[Siegel1936]`, and Siegel, *Additive Theorie der Zahlkörper
II* (Math. Ann. 88, 1923) — so the question's lineage runs Siegel 1923 → 1936 → Schaal → Rausch →
Chamizo–Miatello, four citing works in total. **It is a small, nearly closed citation graph, and it does not
touch the crystallography lineage that has the formula.** That disconnection is the finding.

**Delegated sweep A — norm form equations and relative norm equations** (15 WebSearch queries and ~20
database queries, all listed in the returned report; full text retained in this session's record). Its
verdict: **the aim was off by one discipline.** The relative norm form of a CM extension has only **two**
linear factors and its stabiliser is anisotropic hence compact, so the Schmidt/Győry/Evertse
decomposable-form machinery — built for the hard cases with *infinite* unit stabilisers — classifies our case
as the boundary case where its own non-degeneracy condition is vacuous. `[Evertse1995]`'s remark after (1.17)
names our configuration verbatim: "`K` is totally real, `J` is a totally complex quadratic extension of `K`
and none of the prime ideals in `S` splits". **Do not cite the Subspace Theorem for this.**

**Delegated sweep B — shelling numbers and coincidence site modules** (11 WebSearch, 10 OpenAlex, 4 Semantic
Scholar, 4 zbMATH, 1 arXiv-API query, all listed in the returned report). This is the sweep that found
`[BaakeGrimm2003]`. Its own recorded waste, worth keeping: **OpenAlex `title.search:shelling` is dominated by
nuclear physics, core-shell nanoparticles and nut shells.**

**Outside arXiv (gate Q4): four of the load-bearing works are pre-arXiv or non-arXiv** — Schaal 1965 (PAMS),
Siegel 1936 (TAMS), Nagell 1962 (Arkiv för Matematik, via Project Euclid), Baake–Grimm 2003 (DCG), plus
Rudnick's course notes and Cilleruelo's personal page. The gate's insistence on looking outside arXiv is
what produced the two decisive citations.

---

## §PA.6 — What I actually read

Read status per work is in `BIBLIOGRAPHY.md`; the load-bearing reads are:
- `[Schaal1965]` — **read essentially in full** (introduction and the theorem statement verbatim, Lemma 1,
  the conclusion at (11), the reference list). Fetched from AMS with a browser user-agent after a 403.
- `[ChamizoMiatello2018]` — **read**: §1 introduction, the definition (1.4), Lemma 3.1 with the trivial
  bound `r(λ) = O(n^{1+ε})`, §7 Appendix in full (their brute-force method and the order-8 symmetry
  reduction `r(λ) = 8(M₁+M₂+M₃+M₄) + 2(M₁*+M₂*)`), reference list.
- `[BaakeGrimm2003]` — **read by the delegated reader**: abstract, §1, §2 "Central shelling" in full
  (Theorem 1 with proof, the Remark, Fact 1, Corollary 1), the cut-and-project definitions, the 46-item
  bibliography; averaged-shelling sections skimmed. **I have not personally opened this paper** — flagged,
  and the top item in §PA.9.
- `[Nagell1962]` — **read in full by the delegated reader** (12 pages, all seven theorems, §6, references).
- `[Gundlach1978]`, `[Evertse1995]`, `[FiekerJurkPohst1997]`, `[Cohen2000]`, `[BaakeZeiner2017]` — read to
  the extent stated in each bibliography row; none characterised from an abstract alone (gate Q6).

---

## §PA.7 — Controls, and what each would have caught

Every number in §PA.0 and §PA.3 rests on machinery built this session, so it needs its own controls.

- **The integral basis was verified, not assumed.** `O_k = ℤ⟨1, √3, (1+√33)/2, (√3+√11)/2⟩`, whose basis
  discriminant computes to **exactly 17424 = 132²**, matching `disc(K)` from the conductor–discriminant
  formula `12·44·33`. A wrong basis would have silently undercounted; this catches it.
- **`O_L` was computed as a ring, not a ℤ-span, and the difference was caught by a control.** My first
  attempt took the ℤ-span of `ℤ⁸` plus the integral halves and produced discriminant `4857532416`, i.e.
  `16 × disc(L)` — index 4 off. Closing under multiplication gives discriminant **exactly
  `303595776 = 2⁸3⁴11⁴`**, matching the conductor–discriminant prediction, with every basis element verified
  an algebraic integer. **The check that fired was comparing against an independently predicted
  discriminant**; without it the "maximal order" counts would have been sub-order counts and every headline
  number in §PA.0 would have been too small.
- **Every solution was re-verified by exact re-substitution, and the listing was inspected.** At `ξ = 12`
  the enumerator returned 36; I could only find 20 by hand, and rather than trust the machine I printed all
  36 and re-checked each. The 16 I had missed are the half-integer ones such as
  `μ = (1+√33)/2, ν = (√3−√11)/2`, where `(17+√33)/2 + (7−√33)/2 = 12`. **An over-count here would have
  flattered the mission** — a bigger circle count makes the objective look nearer — which is exactly the
  bias `CLAUDE.md` G21 says to expect, so it was checked before it was believed, not after.
- **The float is never the decision.** Floats propose candidate square roots and a sign pattern; every
  acceptance is an exact equality of `Fraction` tuples in the field.
- **A disagreement between two readers was settled by measurement, not by argument.** The shelling reader
  concluded the primes above 2 **ramify** in `K(i)/K`; I concluded they are **inert** with residue field
  `𝔽₄`. My reason: `K_𝔭 ≅ ℚ₂(√3)`, and `ℚ₂(√3)(i) = ℚ₂(√3,√−3)` with `√−3` generating the **unramified**
  quadratic extension of `ℚ₂` (since `−3 ≡ 5 mod 8`), so the residue field doubles to `𝔽₄`. This matches
  Theorem B's own `𝔽₄` independently. The measurement that settles it: **`ξ = 3` returns 36 over `O_L`**,
  which requires the prime above 3 to split *and* the 2-part to contribute exactly 1 — consistent with
  either reading at `ξ = 3`, but the whole six-point table is consistent only with the formula as applied
  with inert 2-primes. Recorded as: **inert, with the ramified reading rejected**; the two readings coincide
  on every *rational* `ξ` (2-adic exponents are always even there), so the distinguishing tests are at
  non-rational radii, which is where the mission lives.
- **Generator-image check, as §7 of the brief requires.** My counts come from **one family** — scalar
  multiples `c·(O_k ⊕ O_k)` and `c·O_L`. **That family cannot express `Λ_parts`**: it returns 60 on
  `|p|² = 4` where his lattice returns 30, because his is a `ζ₆`-only sub-module of index 2 in the relevant
  `O_L`-ideal. So my numbers are **calibration points and ceilings, never a census of what modules can do**.
  The upper bound `|U_M|·∏(v+1)` is the family-free statement: it applies to any module via the
  `O_L`-ideal it generates. **I state this because a zero or a ceiling from a restricted generator is the
  single error this milestone has already made twice.**
- **The out-of-sample check** (Poros's catch): the bound was derived from `α`'s arithmetic and the maximal
  order, then found to retro-predict the brief's own **30** and **18**, neither fitted. Both outcomes were
  reachable — a module of Parts's coarseness could have come out at any of 6, 12, 18, 24, 30 — so the
  agreement is evidence rather than a formality.
- **Not controlled:** `h(K(i)) = 1`, the hypothesis of Baake–Grimm's Theorem 1. I did not compute the class
  number of the degree-8 CM field. The formula's agreement at six points is evidence for it, not a proof,
  and a failure would appear as a count *below* the formula, i.e. in the pessimistic direction.

---

## §PA.8 — Negatives and named blockers

**Recorded negatives** (the gate's own request):
- No bound, formula or open problem relating **shell size to covolume**, anywhere, under nine phrasings in
  three databases by two readers. Not a theorem, not a conjecture, not posed.
- No planar-module shelling result over a **non-cyclotomic** field in print. `[BaakeZeiner2017]`'s
  Remark 7.12 is a complete inventory of the shelling literature as of 2017 — four items, all cyclotomic
  planar or icosahedral in 3- and 4-space. **Our case falls in Baake–Grimm's Remark and in nobody's paper.**
- The count does not appear in the **unit-distance / Hadwiger–Nelson** literature at all (search 8).
- **No stated open problem that this project is about to answer** in any of the three rooms.
- **CSL theory and unit-distance colouring are never joined** in any source found (search 11).

**Named blockers, with what was tried** — a named blocker is actionable where a silent gap is not:
- **Nagell, *Nova Acta Reg. Soc. Sci. Upsaliensis* Ser. IV vol. 15 no. 11 (Uppsala 1953), 77 pp.**, "On the
  representations of integers as the sum of two integral squares in algebraic, mainly quadratic fields" —
  **not on OpenAlex, not on arXiv, not findable online.** His 1962 paper corrects and extends its Theorems
  16, 17, 21 and 29–31, and 77 pages on exactly this problem is the likeliest home of an explicit count
  predating everything above. **Top library request.**
- **Simon 2002**, *Math. Comp.* 71, 1287–1305, "Solving norm equations in relative number fields using
  S-units" — not obtained; the paper Cohen's chapter follows and the best candidate for a published
  structural statement of the complete solution set. **Second.** (Also: **not indexed in OpenAlex.**)
- **`[PleasantsBaakeRoth1996]`** — the tables that would answer Q1 were not reached.
- **Moody–Weiss 1994**, "On shelling E8 quasicrystals", *J. Number Theory* 47, 405–412 — the one published
  shelling proof over a **non-cyclotomic** base (the icosian ring over `ℚ(√5)`); the likeliest transferable
  technique. Not read at all.
- Publisher blocks encountered: **ScienceDirect** and **link.springer.com** (paywall stubs),
  **zbmath.org** behind Cloudflare (its API works but exposed no review text), **HathiTrust** holds *Arkiv
  för Matematik* only as a search-only volume, **Semantic Scholar** rate-limits after ~2 calls.
  **Working routes, worth recording:** AMS PDFs 403 on WebFetch but succeed under `curl` with a browser
  user-agent; **Project Euclid direct `.pdf` URLs are free for old *Arkiv för Matematik*** while its listing
  pages return a JavaScript shell; `rd.springer.com` gives landing pages with reference lists; Crossref
  `query.bibliographic` beats OpenAlex free-text for locating an old paper by title.

**A tooling request, with the measurement that justifies it** (`CLAUDE.md` § Whose work this is):
there is **no `pari`/`gp`, Sage or Magma on this machine** — I checked — which is why the ideal arithmetic,
the integral bases and both orders were built by hand this session. Installing PARI/GP buys three specific
things, not convenience: (i) `rnfisnorm`/`bnfisnorm` decides "is this element a relative norm" directly —
Poros needed exactly that routine and hand-wrote a square-root-in-`K` with eight controls, and it still
leaves open *is `101 − 11√33` a sum of two squares in `K`*, which decides whether the antipodal circle is
non-empty at all; (ii) `bnfinit` settles `h(K(i)) = 1`, the one uncontrolled hypothesis in §PA.7;
(iii) ideal factorisation would replace every `v_𝔭` in this document with a machine check.

---

## §PA.9 — What I could not settle, ranked

1. **Open `[BaakeGrimm2003]` personally** and read Theorem 1, Corollary 1 and the Remark at the source. The
   formula is load-bearing for four findings and I have it through one reader. `arXiv:math/0203025`.
2. **`h(K(i))` for `K(i) = ℚ(√3,√11,i)` — the hypothesis of `[BaakeGrimm2003]`'s Remark, and NEITHER READER
   CHECKED IT.** Flagged by Poros as this suite's own named smell: a theorem invoked with its hypotheses
   unchecked. **Bound the exposure exactly, because it is smaller than it looks:** the four numbers this
   gate hands the mission — 36 on the target circle, 60 at `n = 2`, 60 at the record's circle, 12 on the
   coordinate module — are **exhaustive measurements, not formula predictions**, so they stand whatever the
   class number is. What needs `h = 1` is using the formula **predictively** on a module nobody has counted,
   which is exactly what §PA.3 already says not to do. If `h ≠ 1` the failure shows as counts *below* the
   formula. Minkowski's bound for this field is ≈ 110, so the check is not a hand computation — it is one
   `bnfinit` call, and another entry in §PA.8's install case.
3. **`[PleasantsBaakeRoth1996]`'s tables** — whether `cos θ = 1 − 1/(2n)` is a named coincidence-rotation
   sequence with tabulated indices.
4. **Nagell 1953** (ILL) and **Simon 2002**.
5. **Which quadratic extensions arise from coincidence rotations** — the product owner's own addition, and
   directly load-bearing via the radicands `4n−1 ∈ {3, 7, 11, 15, …}`. Not searched; it is the natural
   next query in room 1 and I ran out of gate.

*Resolved during the gate, so not on this list: whether `n = 2` was in phase G's census (§PA.4 Q4 — it was
not, and the reason is recorded there).*

**Two sentences the brief asks to be carried into every report, and they still hold.** The new rotation is
**un-eliminated, not alive** — nothing here shows it produces anything. And **silence is not evidence**: the
four-colour filter fires one way only, and so does a literature negative.

**Received from Poros and passed on as its findings, not verified by me.**

- **The classification of the family, in the form that survived three attempts** — carry this one and not its
  predecessors: **the circle is *free* iff `n = t²` for an integer `t`** (the radius is then a rational
  integer, i.e. a shell of the unit-distance lattice itself, which is why the record's `n = 4` sits on
  `|p|² = 4`); **the field is 6-open iff `n` is even and the squarefree part of `4n−1` is a non-residue
  mod 11**; **the two conditions are independent**, and `n = 16` is the smallest meeting both. The 6-open
  members at `n ≤ 31` are **2, 10, 16, 20, 22, 24**. Poros's two earlier statements — "`n = 16` is the
  unique 6-open member at radius ≤ 8", then the repair to "radius ≤ 4" — were **both wrong, from one cause:
  it swept only Loeschian `n`, which silently excluded five of the six.** Recorded because that is the
  **third** instance in this milestone of a conclusion inheriting its generator's image, after §7's family
  and phase G's census (§PA.4 Q4) — and the cure was the same each time: state the generator's image before
  believing anything quantified over it.
- **G43's silence on a ramified 11 is a routine case, not an edge case:** 11 divides the radicand at
  `n = 3, 14, 25` — three of the first thirty-one — so the grokking's rule (6-open ⟺ wall broken ∧ 11 inert)
  has no verdict for about a tenth of the family. Worth closing in `CLAUDE.md` rather than leaving as a
  guess in a table.
- **No phase G, H or H2 document states the field the new rotation's arena lives in.** It is
  `K(√(202 − 22√33))`, with 97 recurring three times. Had `sin θ` been in `K`, the whole arena would be
  four-coloured by `chromaticNumber_seamPlane` and **the mission would be over by a theorem already in this
  repository** — which is why the sentence should not live in one agent's context.
