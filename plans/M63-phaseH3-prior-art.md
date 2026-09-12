# M63 phase H3 — §PA, the prior-art gate

*Run 2026-09-12 by de Bruijn under WORKFLOW step 3a and `CLAUDE.md` G49/G50, against
`plans/M63-phaseH3-drop-the-shape.md` §7, which scopes it: phase H2's gate is complete and its verdict
stands (the angle family is `[PartsOdd2022]` §3's `m₁ = m₂`, `r = 1` slice; ours is the characterisation,
the field screen and unit distance), and **this gate covers only what is new in phase H3 — dropping
Parts's coordinate shape** — "in the vocabulary of coincidence site modules and of representation by norm
forms". Three readers: this file's author plus two delegated sweeps. Every claim is marked **[derived]**
(arithmetic from a stated theorem), **[verified here]** (symbolic computation, this session),
**[external]** (the literature's, read as marked) or **[unverified]**.*

---

## §PA.0 — The verdict in one page

**1. The move is not new as an idea. It was proposed publicly at the start of Polymath16, on 19 April 2018,
and abandoned unimplemented.** Gil Kalai asked for "an extension of the integers by certain square roots"
as a vertex set; Lior Silberman answered with two readings, the second of which is phase H3 verbatim:

> "2. Replace `ℤ` with the ring of integers of a number field (say `ℤ[√3,√5,√11] = ⊕_{d|3·5·11} ℤ√d`),
> **that is take points each of whose coordinates is a point in the field.** Now there are two problems:
> first, there may be multiple ways to embed the ring in the real numbers … Second, the image is dense in
> the real numbers. **It is therefore not obvious how to make the graph finite.** You can try to take a big
> box in the coordinates above, but the problem is that some directions are longer than the others. My
> guess is therefore to first embed `O_K` in `K ⊗ ℝ` as a lattice and then take a big box … and finally
> project on one of the coordinates. **I'll try implementing this later.**"
> — Lior Silberman, Polymath16 first thread, 19 April 2018 [external, read at the source]

Kalai's own simpler version, a few hours later (Silberman 1:53 am, Kalai 5:21 am): *"all points of the form `(a + b√3, c + d√3)` where
`a,b,c,d` are integers smaller than `m`. (and similarly when you add additional roots)."*

**He never returned to it.** Silberman posts seven comments in the eighteen threads (15, 19 and 20 April
2018) and none is a follow-up; no result from this line appears anywhere in the 1,689,442 characters of the
corpus, 2018–2026 [verified here, exhaustive grep with positive controls]. **So the vertex set is prior
art as a proposal and unworked as a construction**, and the two obstacles Silberman names are exactly the
two the phase brief budgets for — his "multiple ways to embed" is our four-conjugate disk cut (§3 of the
brief), and his "not obvious how to make the graph finite" is the cut itself.

**2. The reframing that should govern the phase, and it is the corpus's own notation, not ours.** Parts's
two coordinate-slot conditions are not a coordinate convention. They say exactly:

> **the point lies in the quartic CM field `M = ℚ(√−3, √−11)`**, whose maximal real subfield is `ℚ(√33)`
> and whose ℚ-basis is `{1, √33, √−3, √−11}` — the field of the Moser lattice.

[verified here, symbolically: `i√3 = √−3`, `i√11 = √−11`, `√33 = −√−3·√−11`, and `ζ₆, ω₃, ζ₆ω₃ ∈ M` with
ℚ-span exactly `M`; `[M:ℚ] = 4`.] Equivalently, Parts's shape is the fixed set of the antiholomorphic
involution `z ↦ σ(z̄)` for the Galois automorphism `σ : √3 ↦ −√3, √11 ↦ −√11`.

**And that is how the Polymath16 corpus already writes the same ring.** David Speyer, 25 April 2018:
*"I want to color the ring `R` of numbers of the form `(a + b√−3 + c√−11 + d√33)/(2·3^k)` where `(a,b,c,d)`
are integers with `a+b+c+d` even"* — **the identical basis** [external, read at the source]. So the
restatement is a translation into the community's own existing notation, **not a discovery**; that it was
invisible here is a vocabulary failure of exactly the kind G49 names, and it is recorded as such.

In that language phase H3's move is: **from a rank-4 planar ℤ-module whose field is the quartic CM field
`ℚ(√−3,√−11)`, to a rank-8 planar ℤ-module whose field is the octic CM field `L = ℚ(√3,√11,i) = K(i)` —
the field plane over `K = ℚ(√3,√11)`.** `M ⊂ L` with index 2, and `L = M(√3) = M(i)`: **dropping the shape
is adjoining the quarter turn.** `ζ₁₂ = (√3+i)/2 ∈ L` and `ζ₁₂ ∉ M`, so no module in `M` can be
`ζ₁₂`-closed and a module in `L` can — which is the arithmetic content of phase H2's measured stabiliser
`|U_M| ∈ {4, 6, 12}` and of the brief's 30 → 60 doubling. [derived]

**3. The object `L` is also already named in this corpus, twice, and its chromatic number is the question
this project answered.** `[Madore2015]`'s `4 ≤ χ(K²) ≤ 5`, Dustin Mixon's and Dan Ismailescu's 2 May 2018
postings asking for `χ(ℚ[√3,√11] × ℚ[√3,√11])`, and Theorem B — all about `L`. So **the base module of
phase H3 is the field plane whose chromatic number this repository proved to be 4.** That is not an
obstruction (the record's base is 4-colourable too), but it means the base contributes no colour pressure
of its own and every claim must come from the rotated copy.

**4. What survives as new, stated so it cannot be oversold.** Not the vertex set, not the field, not the
angle family, not the counting formula. What is unworked:
- **the combination** — a full field-plane module as the *base of a base-plus-rotated-copy construction*
  at a classified rotation. Kalai and Silberman proposed a distance-`T` graph on a box, with no rotated
  copy; every type-M construction in print uses a generated rotation ring;
- **the finiteness cut** — an exact four-conjugate disk cut in place of Silberman's lattice-reduction-
  and-project, which is a different and (for our purpose) better answer to the obstacle he named;
- **the field screen over the family**, which phase H2 already owns.

**4a. The crystallography room's verdict, and it is the cleanest negative in the gate.** The object phase
H3 is *dropping* — a submodule of a planar module that **halves the rank and lowers the rotation
symmetry** — is excluded from that literature **by definition, not by oversight**: `[BaakeZeiner2017]` §6
defines a submodule of a planar module to be of the **same rank** (footnote 8 says the general notion "is
not needed in our context"), and `[BaakeGrimm2004]` Definition 1 admits only **similarity** submodules
(`z ↦ az`, `z ↦ az̄`) as colouring classes, all symmetry-**preserving**. Four arXiv full-text queries aimed
at the object return **zero documents** each. **But the room is not empty of us:** `[BaakeGrimm2003]`'s
Remark gives the shelling count for **any** class-number-one CM field with the prefactor equal to the
module's roots of unity on the unit circle — so the brief's 30 → 60 doubling is *predicted by a 2003
theorem*, subject to a real gap (the Remark is for the **maximal order**, and our module contains
`ω₃ = (5+√−11)/6`, not an algebraic integer). And the rotation family is, under translation, classical:
with `w = (1+i√(4n−1))/2`, **`w̄/w = −ρ_n`** exactly [verified here], so `ρ_n` is up to a half-turn the
**index-`Σ = n` coincidence rotation of the imaginary quadratic order of discriminant `1 − 4n`.** §PA.4.

**5. One derivation the gate produced that the phase should carry.** The brief's *"circle points under
Parts's shape at `n = 2`: 0"* is **a theorem about the whole field `M`, not a count on his lattice**:
`|p|² = 2` for `p = u + v√−3 ∈ M` means `u² + 3v² = 2` over `ℚ(√33)`, i.e. `2` is a relative norm from
`M/ℚ(√33)`; `33 ≡ 1 (mod 8)` so `2` splits in `ℚ(√33)` with each completion `ℚ₂`, and `−3 ≡ 5 (mod 8)`
makes `ℚ₂(√−3)` the **unramified** quadratic extension, whose norms have even valuation — while
`v₂(2) = 1`. So `2` is not even a local norm, hence not a global one, and **the circle is empty over all of
`M` at every denominator.** [derived] This **re-derives phase H2's own Fact 2**
(`plans/M63-phaseH2-arithmetic.md` §3b, "`v₂(d²n)` has the same parity as `v₂(n)` for every `d`") by an
independent route — Hasse local norms rather than Baake–Grimm's inert-prime criterion — so it is a free
positive control on both, not a new result. Two routes, one answer.

---

## §PA.1 — The object, named in each discipline's vocabulary (gate Q1)

Never searched in this project's words. The translations used, and the two new rows this gate adds:

| this project | the discipline's name | discipline |
|---|---|---|
| Parts's coordinate shape | **the quartic CM field `ℚ(√−3,√−11)`**; in the Polymath16 corpus, Speyer's basis `(a + b√−3 + c√−11 + d√33)/(2·3^k)` | algebraic number theory / the corpus itself |
| dropping the shape | passing to the **octic CM field `K(i)`**, i.e. the **field plane** over `K = ℚ(√3,√11)` | algebraic number theory |
| the same, structurally | a **planar ℤ-module of rank 8**, dense in the plane; as a `ℤ[ζ₁₂]`-module it has **rank 2** — a module with 12-fold symmetry of non-standard rank | aperiodic order / mathematical crystallography |
| Parts's module, same terms | a planar `ℤ[ζ₆]`-module of **rank 2**, i.e. 6-fold symmetric of rank 4 | aperiodic order |
| points of a module on one circle | **central shelling function** `c(r²)` | aperiodic order (phase H2's row, unchanged) |
| a base and a rotated copy | **coincidence site module**, index `Σ(R)` — **retired for the rotation question by phase H2 §PA.11** and still retired here | crystallography |

---

## §PA.2 — Front 3, the Hadwiger–Nelson literature: the ground is NOT taken, and the sharper form matters

*Delegated sweep (18 queries; the Polymath16 wiki recovered through the Wayback Machine with `curl`, since
both `michaelnielsen.org` and `asone.ai` are now dead for it). Its query table and read-depth log are in
the sweep's returned report; the load-bearing items are reproduced here with their quotations.*

### The verdict

**Nobody has built a unit-distance graph whose vertex set is the full fractional module of a number field
inside a disc.** The constructive literature is **unanimously generative**, with no exception among the six
papers checked:

| author | vertex set | read |
|---|---|---|
| de Grey (arXiv:1804.02385) | a star of unit vectors, then a radius-trimmed Minkowski sum, then rotated copies merged | vertex-set passages in context |
| Heule (arXiv:1805.12181) | `V₃₁ = {θ₁^j θ₃^k (1,0)}`, `V₁₅₁ = trim(V₃₁ ⊕ V₃₁, 1)`, `V₁₉₃₉ = V₃₁ ⊕ V₁₅₁`, then `∪ θ₄(V₁₉₃₉)` | §4.1–4.3 in full |
| Parts (arXiv:2010.12665, the 509) | `B = ⊕ⁿ Hᵐ` — Minkowski powers of the 7-vertex hexagonal wheel under rotations by `η` | §2, §4 in full |
| Exoo–Ismailescu (arXiv:1805.00157) | explicit point lists plus a rotated copy — *stated as living in* `ℚ[√3,√11]²`, but enumerated generatively | claims and conclusion |
| Voronov–Neopryatnaya–Dergachev (arXiv:2106.11824) | `M₁` = origin plus points on the unit circle, `M_s` iterated Minkowski sums with clipping, `W = M_s ∪ ψM_s` | §5, §6 in full |
| Haugland (arXiv:2608.04542) | "the lattice generated by `{u_j}_{0≤j<84}`" | construction section |

**But "nobody did it" is the weak form. The sharp form is that the full module is present in Polymath16,
named and studied — as an INFINITE object approached by colouring theory, never truncated to a disc and
handed to a solver.** Philip Gibbs's wiki page writes the module out in coordinates:

> `R̄₂ = { (a + ib√3 + ic√11 + d√33)/(4·3^k) : a,b,c,d,k ∈ ℤ, a ≡ b ≡ c ≡ d (mod 2),`
> `a + b + c − d ≡ 0 (mod 4), k ≥ 0 }` [external, read at the source via Wayback]

and also writes the degree-8 `R̄₃` in explicit slots. The page's stated goal is the opposite of ours —
*"to establish the chromatic number of rings that contain graphs known to be of interest"* — by the
three-step recipe (ring hom onto a finite ring, image of the unit-modulus elements, colour the finite
ring), which is Theorem A's mechanism applied to prove a whole infinite ring `k`-colourable.
**There is no instance anywhere of "enumerate every element of the module with `|z| ≤ r` and test that
finite graph".** Gibbs, thread 6, says why in one sentence: *"the ring can be thought of as a (dense)
lattice in 4D … it is `R₁ × R₁` … **This is not the entire ring `R₂` but it is a substantial part of it.**"*
Density made it an object for structural arguments; **that a denominator-bounded slice is finite inside a
disc, and therefore enumerable, appears never to have been noticed.**

### Three findings this hands the phase directly

**(a) The brief's §6 step 1 is closed by citation, and our derivation is confirmed by an independent 2018
source.** The brief calls Parts's two congruences *"asserted only by a docstring"* and makes verifying them
the cheap first step. **They are Gibbs's wiki conditions for membership of the ring `R̄₂`, exactly** — so
group-closure holds by construction because they are *ring* conditions. Verified here by relabelling the
slots (wiki `(1, i√3, i√11, √33) = (a,b,c,d)`; ours `(1, √33, i√3, i√11) = (a,b,c,d)`, so `a'=a, b'=d,
c'=b, d'=c`): the wiki's `a+b+c−d ≡ 0 (mod 4)` **is** `tools/typem.py`'s `a − b + c + d ∈ 4ℤ`, and the
wiki's `a ≡ b ≡ c ≡ d (mod 2)` **is** the `ζ₆`-stable form that M62 §R19 had to *derive* because
`[Parts2020a]` §5.6 states the weaker representative condition `a,b,c,d ∈ |2ℤ|`. [verified here] **The
wiki states the stable form directly, in 2018.** Step 1 should now be run as a *control* against a known
answer, not as an open question.

**(b) The nearest published statement of this phase's question is OPEN, on the main wiki page.** Under
"Further questions": *"If we view the plane as the complex plane, **what is the smallest ring that admits
a 5-chromatic single-distance graph?** Every single-distance graph in the Eisenstein integers and Gaussian
integers is 2-chromatic. David Speyer suggests looking at `ℤ[(1+√−71)/2]` next."* A "single-distance graph
**in** a ring" is precisely the full-module framing, and the question is posed and never answered. It is a
candidate row for `CLOSED-QUESTIONS.md` if this phase or FS-6 ever answers it — **not** a claim that we
have. Alongside it, Exoo–Ismailescu's own closing question, already ledger row 57: *"what is the smallest
subfield of `E²` that requires 5 colors?"*

**(c) The closest thing to a reported negative is Heule's, and it is about a different operation.**
`[Heule2019]` §4.3: *"We focussed on adding points that are further away than 2 from the origin in order to
remove more inner vertices. **Adding points from the field `ℚ[√3,√11]` may allow reducing the large part,
but none of the experiments were successful.**"* Read in context this is *minimisation of an existing
5-chromatic graph* by Minkowski sums of `θ₄(S₁₉₉)` with itself, still generated — **not** a search for
refusal in a larger ambient set. Recorded as the nearest miss, explicitly **not** as a negative on H3.

### A prior-art item needing the product owner's ruling

The wiki's main page states the rotation family more explicitly than our records credit:

> "the complex numbers of unit modulus `ω_t := exp(i·arccos(1 − 1/(2t)))` for various natural numbers `t`,
> particularly the Loeschian numbers `1,3,4,7,9,12,…`. **These numbers arise naturally as the apex angle of
> a `√t, √t, 1` isosceles triangle**, and the distances `√t` are the distances that arise in the triangular
> lattice." [external]

`1 − 1/(2t) = (2t−1)/(2t)`. The *angle formula* is already recorded as prior art (phase G §PA2;
`BIBLIOGRAPHY.md` §E, with the note that their index is the **squared** distance) — so the identification
`t = d²` is in our records too. **What is new to our records is that the wiki attaches the spindle reading
in words** ("the apex angle of a `√t, √t, 1` isosceles triangle"), which is G7's "the detunes *are* the
spindle" in one clause, in 2018. Also new to our records: the wiki gives de Grey's 20,425-vertex graph `N`
as living in `ℤ[ω₁, ω₃, ω₄, ω₁₆]`, and **`ω₁₆ = exp(i·arccos(31/32))` is `ρ₆₃`** — so phase H2's rotation
is a recorded generator of de Grey's own ring, not merely "already a G8 generator". **Ruling needed on
whether G7 and ledger row 64 overstate.** What still looks unclaimed after this: the radicand form
`sin θ = √(4t−1)/(2t)`, the field screen over it, the 6-openness test, and **dropping the restriction to
Loeschian `t`** — the wiki's own list is Loeschian, and `t = 2` is not Loeschian, which is a second
mechanism (beside phase H2 §PA.4's census-image failure) for why `n = 2` was never looked at.

---

## §PA.3 — Front 2, representation by norm forms: covered by phase H2, with one new sub-question and one trap

**Verdict: nothing new on this front, and that is a finding rather than a gap.** Phase H2's gate did this
room thoroughly and its four load-bearing citations answer H3's counting questions unchanged, because the
counting formula is stated for **any** class-number-one CM field and does not care which of `M` or `L` it is
applied to:

- the exact count — `[BaakeGrimm2003]` Theorem 1 / Corollary 1 **and its Remark**, which is what covers a
  non-cyclotomic CM field;
- its failure on a non-maximal order, measured in H2 §PA.3, with the surviving upper bound
  `count ≤ |U_M| · ∏_{split}(v+1)` — **and `|U_M|`, the order of the group of roots of unity stabilising
  the module, is exactly where Parts's shape lives**: 6 for a `ζ₆`-closed module in `M`, up to 12 for a
  `ζ₁₂`-closed one in `L`, 4 for the plain coordinate module `O_K ⊕ i·O_K`. The brief's 30 → 60 doubling
  is this factor and nothing else [derived];
- the finiteness — `[Nagell1962]` Theorem 4;
- the mean value — `[Schaal1965]`, whose `f(ξ, 𝖆)` is defined for a **fractional** ideal, so it already
  ranges over the denominator-12 modules H3 uses.

**The one sub-question H3 raises that H2 did not:** the count over an **index-2 submodule cut out by a
Galois condition** — `M`-points inside the `L`-module. Phase H2 recorded the general negative that covers
it: no statement anywhere relates shell occupancy to a submodule's index or covolume, searched under nine
phrasings in three databases by two readers, and `[BaakeZeiner2017]` studies submodules intensely but never
their shell occupancy. That negative was **re-aimed and re-run in this gate's crystallography sweep**
(§PA.4), because a Galois-stable submodule is a sharper object than "a submodule of index `n`".

**The trap, recorded so nobody spends a day on it.** Searching *"lattices from biquadratic fields"* returns
a large and active literature — algebraic lattices, ideal lattices, Arakelov-modular lattices (e.g.
arXiv:2509.04591, arXiv:1609.03134) — which constructs lattices in `ℝⁿ` from ℤ-modules in a degree-`n`
field via the **canonical embedding** `K → ℝ^{r₁} × ℂ^{r₂}`, giving a **discrete** rank-`n` lattice. **Ours
is a single complex place**, `K → ℂ`, giving a **dense** rank-`n` module in `ℝ²`. Those are different
objects and the literature does not transfer. The room for a dense planar module is aperiodic order, which
is why phase H2 found the formula there. [verified here, by inspecting the abstracts and construction
sections of the two arXiv items named]

**Marginal, checked and dismissed:** *Lattice approach to plane colorings*, S. Heinäsmäki, arXiv:1908.03880
— the title is a near-perfect false positive for this gate. Opened: it is a **condensed-matter spin model**
(`cond-mat.stat-mech`) approximating plane colourings by minimum-energy configurations of a multicomponent
spin system; no number field, no module, no unit-distance graph. **Not relevant.** [read: abstract and
classification]

---

## §PA.4 — Front 1, coincidence site modules: the ground is not taken, and it is bordered on one side

*Delegated sweep (14 queries; arXiv's full-text search UI, since `export.arxiv.org` HTTP-429'd on every
attempt). It fetched and read four papers phase H2 could not reach.*

### The negative, and it is the strong kind — an exclusion by definition, not by oversight

**`[BaakeZeiner2017]` §6, read in full at the source:** *"We call a ℤ-module `M′ ⊆ M` a **(full) submodule**
of `M` if `M′` and `M` have the **same rank**"*, with **footnote 8**: *"More generally, one calls any
ℤ-module `M′ ⊆ M` a submodule of `M` regardless of its rank, but we do not need this more general notion in
our context."* **A rank-4 subset of a rank-8 planar module has infinite index and is explicitly outside
that entire framework.** So the object phase H3 is dropping — Parts's shape, a rank-halving submodule — is
not merely unstudied there; it is defined out of scope on the survey's second page of §6. [external]

**`[BaakeGrimm2004]` Definition 1, read in full:** a *Bravais colouring* of a planar module is a partition
whose distinguished class is a **similarity submodule** — an image under `z ↦ az` or `z ↦ az̄`. **Our
Galois-twisted reality condition `σ(z̄) = z` is neither map**, and it **lowers** the module's symmetry
(12-fold to 6-fold), whereas the whole Bravais-colouring programme is about colourings *compatible with*
the full symmetry group. **The literature classifies symmetry-preserving, equal-rank submodules and has no
vocabulary for a symmetry-lowering, rank-halving one.** [external]

**Confirming the rest of the negative:** arXiv full-text search returns **four documents ever** for
"planar modules N-fold symmetry" (three are Baake's, one is unrelated semiconductor physics), and **zero**
for "quasicrystal CM field module plane", "module with 12-fold symmetry rank 8" and "Galois stable
submodule quasicrystal". **Nothing has appeared since 2017.** No result anywhere relates a submodule's
index or covolume to its shell occupancy — phase H2's negative, re-aimed at a Galois-stable submodule and
re-run, stands. And **no source joins coincidence-site theory to unit-distance colouring** (three passes,
two of them the search engine's own refinements).

### The border: two things that ARE claimed, one of them correcting our own records

**(a) The shelling law for a general CM field is in print, and it predicts the 30 → 60 doubling.**
`[BaakeGrimm2003]`'s Remark after Theorem 1, now read at the source by this gate's sweep (phase H2 had it
through one reader only, its §PA.9 item 1): *"It is clear that Theorem 1 can be generalised to the
situation that `K` is a totally complex field extension of a totally real field `k` whenever `K` has class
number one … the prefactor in Eq. (5) has to be replaced by **the number of elements in the unit group of
`O` that lie on the unit circle**."* That prefactor is the module's roots of unity, so **6-fold → 12-fold
doubles every shell count** — the brief's 30 → 60, as a theorem rather than a measurement. **Two caveats
are the whole gap, and they matter:** the Remark is stated for `O` the **maximal order**, and our
`M`-module contains `ω₃ = (5+√−11)/6`, **which is not an algebraic integer**, so the object is not `O_M`
and the Remark does not literally cover it. This is the same sub-order gap phase H2 measured (its §PA.3
link 3, where the formula is exact on `O_L` and false on `O_k ⊕ i·O_k`), and it means the doubling is
**predicted, not proved, for the modules H3 will actually build.**

**(b) The rotation family is, under translation, a classical coincidence rotation — and the index is `n`.**
Set `w = (1 + i√(4n−1))/2`, the standard generator of the ring of integers of `ℚ(√−(4n−1))` for
`4n−1 ≡ 3 (mod 4)`. Then `|w|² = n` and

> **`w̄/w = −ρ_n`** exactly. [verified here symbolically for general `n`, and at `n = 2, 3, 4, 16`:
> `−3/4 − i√7/4`, `−5/6 − i√11/6`, `−7/8 − i√15/8`, `−31/32 − 3i√7/32`.]

Since `−1` is a coincidence rotation of index 1, **`ρ_n` is, up to a half-turn, the coincidence rotation of
index `Σ = n` of the planar lattice `ℤ[w]`** — the non-generic case of `[BaakeZeiner2017]` Theorem 5.14,
multiplier ring an order in an imaginary quadratic field. In that room's vocabulary our family is *"the
`Σ = n` coincidence rotation of the imaginary quadratic order of discriminant `1 − 4n`, one for each `n`"*.
**Phase H2 §PA.4 Q1 already had the field half of this** (`ρ_n` is a coincidence rotation of
`ℤ[(1+i√(4n−1))/2]`, not of the hexagonal lattice); **what is new is the index, `Σ = n`.** The sweep
found no paper stating the family as a family, so **this is a recognition, not a citation** — and the
`Σ = n` reading carries the usual caveats when `4n−1` is not squarefree or `w` is not primitive.

**(c) A correction to `BIBLIOGRAPHY.md`, and it is ours to make.** Our row for
`[PleasantsBaakeRoth1996]` attributes the sentence *"the multiplier ring is the ring of rational integers
in the generic case, and an order in an imaginary quadratic field otherwise"* to that paper, "as reported
in the survey". **The paper was fetched and read this session (38 pp.: §1, §3, §6.0.2–6.0.4 in full, plus
greps over the whole text) and `grep -i multiplier` returns ZERO hits.** **Re-verified independently by de Bruijn on our own filed copy**, after undoing pdftotext's hyphenation and line breaks — 0 occurrences of `multiplier`, and 0 of `imaginary quadratic` — with positive controls in the same file by the same instrument (`coincidence index` 15, `Σ` 7, `ring of integers` 4), so **the zero is about the paper and not about the grep**. And §6.0.2's scoping sentence, read verbatim on our copy: *"Our definition of `n`-modules makes them ideals in the ring of integers of the `n`th cyclotomic field (and with any broader definition an `n`-module would certainly be equivalent to one of these)."* The sentence's actual home is
`[BaakeZeiner2017]` §5.2, **Theorem 5.14**, which credits **Baake–Scharlau–Zeiner, *Similar sublattices of
planar lattices*, Can. J. Math. 63 (2011) 1220–1237, arXiv:0908.2558**, Prop. 2.3 and Thm. 2.6. **And the
scope is narrower than we recorded: it is about planar LATTICES (rank 2), not planar modules.** The row has
been corrected.

**(d) `[PleasantsBaakeRoth1996]` answers phase H2's §PA.9 item 3 in the negative, and the reason is
structural.** It contains **no tables of coincidence indices by rotation angle**; its tables are Euler
factors of `ζ_K(s)` and prime degrees by residue class mod `n`. `ρ_n` does not appear and **cannot**: its
objects are, verbatim, *"ideals in the ring of integers of the `n`th cyclotomic field"* (§6.0.2), so the
module is `ℤ[ζ_n]` of rank `φ(n)`, and `ρ_n ∈ ℚ(√−(4n−1))` is outside it for every `n > 1`.
**Phase H2's open item 3 is now closed: the family is not tabulated there.**

### Q4's other room, checked and closed

The twisted-bilayer-graphene literature does enumerate commensurate rotations with rational cosine, but its
family is `cos θ = (m²+n²+4mn)/(2(m²+n²+mn))` — the **hexagonal-lattice** (`ℤ[ζ₆]`) case, a different
one-parameter shape. Our family is not there. [external, from the sweep's search]

---

## §PA.5 — Every search, in the exact words it was run

**Mine (Claude WebSearch, US index).**

| # | query as run | outcome |
|---|---|---|
| 1 | `unit distance graph vertex set ring of integers quadratic field all points within radius chromatic number plane construction` | **negative on the join** — only the finite-field (unit-quadrance) literature and general surveys; the full-module vertex set does not surface |
| 2 | `"biquadratic" CM field planar module lattice points on circle representation number degree 8 totally real subfield` | **hit, and it is a trap** — the algebraic/ideal-lattice literature (canonical embedding, discrete rank-`n` lattices), a different object; §PA.3 |
| 3 | `Moser lattice "ring of integers" Hadwiger-Nelson Polymath16 quartic field zeta6 unit distance graph coordinates` | **hit** — the Polymath16 wiki's `R̄₂` generators, which sent me to the local copy |
| 4 | `chromatic number "dense subgroup" of the plane unit distance graph Johnson Chilakamarri rational points field coloring` | **contextual hit** — Chilakamarri 1988 on unit-distance graphs in rational `n`-space, Johnson on two-colourings of a dense subgroup, Fischer on additive `k`-colourable extensions of the rational plane; confirms the colouring half uses full modules, and none of it constructs a finite graph |
| 5 | `"smallest ring" OR "smallest field" 5-chromatic unit-distance graph plane Speyer "-71" imaginary quadratic single-distance graph` | **negative** — no published answer to the wiki's open question |
| 6 | `chromatic number single distance graph ring of algebraic integers dense subring plane 2018 2024 five colors smallest` | **negative** — nothing beyond the Polymath16 material itself |

**Local corpora, searched exhaustively with positive controls** (`~/source/library/notes/`):

| corpus | size | what was run |
|---|---|---|
| `polymath16-threads-1-18-text.txt` | 1,689,442 chars | counts for `zeta_12`, `twelfth root`, `quarter turn`, `rotation by i`, `larger ring`, `bigger ring`, `whole field`, `entire field`, `all points of`, `rank 8`, `rank 4`, `ring of integers`, `adjoin`, `sqrt{33}`, `12-fold`, `dense`, `lattice reduction`, `each of whose coordinates`; every nonzero hit read in a ±180-char window, the decisive one in a ±4,500-char window |
| `polymath16-algebraic-formulation-2018.txt` | 17,965 chars | read the ring table and every `example R̄ᵢ` block in full |

**Positive controls on those zeros, per `CLAUDE.md` G21 and phase H2 §PA.10's own scar** (*"before
believing a zero, run the same query against a case you know is present"*): in the same corpus with the
same tool, `Moser` → 15, `Madore` → 1, `8/3` → 11, `sqrt{11}` → 11, `sqrt{3}` → 16, `lattice` → 13,
`Parts` → 18. So the instrument sees this corpus, and the zeros for `zeta_12` / `twelfth root` /
`quarter turn` / `rotation by i` are about the corpus and not about the grep.

**Delegated sweep — the Hadwiger–Nelson construction literature** (18 queries; table in §PA.2 and in the
sweep's returned report). Its own recorded blockers, worth keeping: `asone.ai` is **dead (DNS)** and
`michaelnielsen.org/polymath/...` **404s**, so the wiki is now reachable only through the Wayback Machine,
and **WebFetch is blocked on `web.archive.org` while `curl` works**. Also: WordPress renders this blog's
mathematics into `<img alt=…>`, so a naive text extraction **silently deletes every formula** — which
nearly produced a false negative on its first pass.

**Delegated sweep — crystallography and aperiodic order** (14 queries). `export.arxiv.org`'s API HTTP-429'd
on every attempt; arXiv's full-text **search UI** worked and is the instrument behind these counts:

| query as run | database | outcome |
|---|---|---|
| `planar modules N-fold symmetry` | arXiv full text | **4 documents ever**: three are Baake's (math/0301021, math/0511147, math/0511306), one unrelated semiconductor physics |
| `planar module non-cyclotomic` | arXiv full text | 1: arXiv:1010.3908 *On Bravais colorings associated with periodic and non-periodic crystals* — **not opened; a recorded debt** |
| `quasicrystal CM field module plane` | arXiv full text | **0** |
| `module with 12-fold symmetry rank 8` | arXiv full text | **0** |
| `Galois stable submodule quasicrystal` | arXiv full text | **0** |
| `shelling cyclotomic` | arXiv full text | 1, unrelated (analytic number theory) |
| `coincidence site modules` | arXiv full text | 19, of which 5 relevant, all Baake/Zeiner school; new to us: arXiv:1402.5013 |
| `planar module N-fold symmetry rank higher than Euler phi` | WebSearch | only the Baake corpus; the summaries themselves state rank `= φ(N)` |
| `"multiplier ring" coincidence rotation planar module "imaginary quadratic field" order` | WebSearch | located the sentence — **and it is not where our records said**; §PA.4(c) |
| `Baake Grimm "Bravais colourings" planar modules N-fold symmetry submodule symmetry group` | WebSearch | arXiv:math/0301021 only |
| `"unit-distance graph" OR "chromatic number" quasicrystal aperiodic order cut-and-project module plane colouring` | WebSearch, + 2 engine refinements | **negative on the join**, third independent confirmation |
| `commensurate twist angles rational cosine (2n−1)/(2n) bilayer graphene` | WebSearch | TBG's family is `(m²+n²+4mn)/(2(m²+n²+mn))` — the hexagonal case; ours not found |
| `rational rotations plane "rational cosine" Niven Sigma sequence` | WebSearch | nothing matching |
| `cites:W2759990410` (Baake–Zeiner 2017) | OpenAlex API | **`cited_by_count = 0`, citing list empty — NOT credible**; OpenAlex has no DOI record for `[BaakeGrimm2003]` either. **The two-database cross-check (gate Q7) was NOT completed**; §PA.10 |

---

## §PA.6 — What was actually read, and how far (gate Q6: an abstract is not a reading)

- **Polymath16 first thread, the Kalai–Silberman exchange of 18–19 April 2018** — read in full at the
  source, in a ±4,500-character window, together with every one of Silberman's seven comments across the
  corpus, to establish that he never returned to it. [de Bruijn]
- **Polymath16 thread of 25–26 April 2018, Speyer's ring `R`** — read in full at the source, including
  Gibbs's proposed colouring and Speyer's `R/4 ≅ ℤ[ω]/4 × ℤ[ω]/4` reply. [de Bruijn]
- **`[Polymath16wiki]`, *Algebraic formulation of Hadwiger–Nelson problem*** — the ring table and every
  `example` block read in full from our local extraction; the sweep independently re-read the live page
  through the Wayback Machine and recovered the explicit coordinate form of `R̄₂` and `R̄₃`, which our
  extraction does not carry. **Our local copy is therefore incomplete** — see §PA.8.
- **`[Polymath16wiki]`, main page *Hadwiger–Nelson problem*** — read in full by the sweep (≈40 kB):
  notable-graph table, the `ω_t` family paragraph, "Further questions", "Code and data". **Not previously
  held here at all.**
- **`[Polymath16wikiR2]`, *Coloring R_2*** — ~70% read by the sweep; it colours the whole ring and contains
  no finite construction. `BIBLIOGRAPHY.md` lists it as a blocking acquisition for FS-20 and **it is still
  not held as a file**; this gate did not discharge that.
- **`[Parts2020a]` (arXiv:2010.12665)** — §2 (Notation, Base graph), §3, §4, §5.6, §6 and references read
  in full by the sweep, specifically looking for a justification of the coordinate restriction. **There is
  none**; he states the coordinate form as a derived property of `⊕ⁿHᵐ`, citing Exoo–Ismailescu and Gibbs's
  wiki page.
- **`[Heule2019]` (arXiv:1805.12181)** — §4.1–4.3 read in full by the sweep.
- **de Grey (arXiv:1804.02385), `[ExooIsmailescu2019]` (arXiv:1805.00157), Haugland (arXiv:2608.04542)** —
  vertex-set and construction passages read in context by the sweep.
- **Voronov–Neopryatnaya–Dergachev (arXiv:2106.11824)** — §5 and §6 read in full by the sweep. **Not
  previously held here**; §PA.8.
- **Heinäsmäki, arXiv:1908.03880** — abstract and subject class read; dismissed with the reason recorded.
- **arXiv:2509.04591 and arXiv:1609.03134** (algebraic/ideal lattices from biquadratic fields) — abstracts
  and construction descriptions read, to establish that the embedding is canonical rather than single-place.
  **Not opened further, deliberately**; the reason is in §PA.3 and is the part that carries.

---

## §PA.7 — Controls on this gate's own claims

Every structural claim here is machinery built this session, so it needs its own controls.

- **The restatement was verified symbolically, not asserted.** `i√3 = √−3`, `i√11 = √−11`,
  `√33 = −√−3·√−11`, `ζ₆ = (1+√−3)/2`, `ω₃ = (5+√−11)/6`, and `ζ₆ω₃ = (5 − √33 + 5√−3 + √−11)/12` — each
  checked to simplify to exactly 0 against its claimed form. `[M:ℚ] = 4` and `[L:ℚ] = 8` computed from
  minimal polynomials. The Galois characterisation checked element by element: `τ = σ∘conj` fixes
  `1, √33, i√3, i√11` and moves `√3` and `i`. **Both outcomes reachable** — the last two rows are the ones
  that would have gone wrong had the involution been misidentified, and they read `False` as required.
- **The congruence identification was verified by relabelling, not by eyeballing.** The wiki's slot order
  is `(1, i√3, i√11, √33)` and ours is `(1, √33, i√3, i√11)`; under the induced relabelling the wiki's
  `a+b+c−d ≡ 0 (mod 4)` maps to `a−b+c+d ≡ 0 (mod 4)`, which is `tools/typem.py`'s condition **character
  for character**. A wrong relabelling would have produced a sign mismatch, which is the failure this check
  can actually exhibit.
- **The `n = 2` emptiness was derived twice, by routes that share nothing.** Hasse local norms at the
  primes above 2 in `ℚ(√33)` (this gate) against Baake–Grimm's inert-prime-at-odd-exponent criterion
  (phase H2 §3b). **This is a positive control, not a new result**, and it is reported as one.
- **Every zero in a local corpus is paired with a positive control in the same corpus with the same tool**
  (§PA.5). This is the defect phase H2's own gate shipped in its §PA.10 and it was not repeated.
- **The restatement is explicitly NOT claimed as new.** It is Speyer's own basis from 25 April 2018, and
  this gate found it only because it went looking in the corpus's vocabulary. Recorded as a G49 instance
  against ourselves.
- **Not controlled:** whether the denominator-12 module H3 will actually build is `ζ₁₂`-closed. `ζ₁₂ ∈ L`
  and `ζ₁₂ ∉ M` are proved; *closure of a particular module under `ζ₁₂`* is a property of that module and
  was not checked, so the "30 → 60 is the `|U_M|` factor" reading is **[derived] for the maximal order and
  a prediction for anything else.** Phase H2 measured `|U_M| = 4` for the plain coordinate module
  `O_K ⊕ i·O_K`, which is a live reminder that the factor is not automatically 12.

---

## §PA.8 — Negatives and named blockers

**Recorded negatives** (each is a finding about where the unworked ground is, not padding):
- **No unit-distance graph in print has a full field-plane module as its vertex set.** Six constructions
  checked at the source, all generative (§PA.2).
- **No follow-up to the Kalai–Silberman proposal anywhere in the Polymath16 corpus**, 2018–2026, across
  1,689,442 characters, with positive controls on the grep (§PA.5).
- **No published answer to `[Polymath16wikiMain]`'s "smallest ring admitting a 5-chromatic single-distance
  graph"**, searched twice (§PA.5 rows 5–6). Speyer's suggested next case, `ℤ[(1+√−71)/2]`, appears to have
  been left untried.
- **`ζ₁₂`, the twelfth root of unity, the quarter turn and "rotation by `i`" occur ZERO times in the
  Polymath16 corpus**, with controls (§PA.5). Wherever the corpus explains its "12-fold symmetry" it means the
  **dihedral** group of order 12 — *"the 12-fold symmetry coming from rotations by `ω` and complex
  conjugations"*, and Parts's *"12-fold symmetric (hexagonal)"* — never `ζ₁₂` rotational closure — **a near
  collision of vocabulary that a reader of a write-up will trip on, so any paper must disambiguate it.**
- **`[Parts2020a]` never justifies the coordinate restriction**, and never reports having tried anything
  wider — read specifically for it. It is not a decision he made; it is a consequence of the generator
  being a hexagonal wheel, and nobody revisited it.
- The algebraic/ideal-lattice literature does not transfer (§PA.3).

**Named blockers, with what was tried** — a named blocker is actionable where a silent gap is not:
- **`[Polymath16wikiMain]` is not held as a file.** It was read this session through the Wayback Machine
  and carries three load-bearing items (§PA.2). **Archive it, per § D rule 0g.** Both live hosts are gone.
- **`[Polymath16wikiR2]`** — still not held; already a blocking acquisition for FS-20 and not discharged
  here.
- **The wiki's "Code and data" Dropbox** (vertex lists, Parts's `JP/Large`) — never opened. If anyone ever
  generated a module slice, an unexplained large vertex file there is where it would be.
- **Fifteen of the eighteen Polymath16 blog threads were not re-swept by the sweep** (it read 2, 3 and 6 at
  the source). **This is less serious than it sounds**: de Bruijn searched the complete local extraction of
  all eighteen threads exhaustively, with controls (§PA.5). What the sweep's method adds is **recovered
  LaTeX from the WordPress `alt` attributes**, which our local extraction already has. Residual exposure:
  formulas our extraction mangled.
- **`[PleasantsBaakeRoth1996]` is NO LONGER a blocker** — fetched and read this session (§PA.4d), and phase
  H2's §PA.9 item 3 is closed in the negative. **Both it and `[BaakeGrimm2004]` are now filed** under
  `library/pdf/`, each title checked against the first line of its own extracted text.
- **`[BaakeScharlauZeiner2011]` (arXiv:0908.2558) not fetched** — the true source of the multiplier-ring
  dichotomy, and the natural place a `Σ`-by-order rotation family would be tabulated if anywhere. **This is
  the one place left that could turn §PA.4(b)'s recognition into a citation.**
- **arXiv:1010.3908 — DEBT DISCHARGED 2026-09-12.** Opened: Bugarin–De Las Peñas, *Bravais colorings of
  N-fold tilings*, whose abstract scopes it to *"planar modules that emerge as the ring of integers in
  cyclotomic fields with class number one"*, `M_n = ℤ[exp(2πi/n)]`, worked at `M₁₅` and `M₁₆`. **Cyclotomic
  only; it does not touch our object.** With positive controls in the same file by the same instrument
  (`cyclotomic` 6, `class number one` 3), the counts for `non-cyclotomic`, `rank`, `CM field`,
  `totally real` and `submodule` are all **0** after undoing hyphenation and line breaks — so the arXiv
  full-text hit was a false positive on three separate terms, not a paper about our case.
- **`h(M)` for `M = ℚ(√−3,√−11)` is unknown here**, and it is the hypothesis of `[BaakeGrimm2003]`'s
  Remark on the rank-4 side. Phase H2 has `h(K) = h(K(i)) = 1` for the rank-8 side; **one `bnfinit` call
  would close the pair** — and there is still no PARI/GP, Sage or Magma on this machine (phase H2 §PA.8's
  standing install case, unchanged and now wanted twice).
- **Pleasants, *Designer quasicrystals: cut-and-project sets with pre-assigned properties***, CRM Monograph
  Series 13, AMS (2000) 95–141. Phase H2 called this "the omission I most regret". **Searched again here
  and still not obtainable online** — bibliographic records only, no full text. **Scope it correctly
  before paying for it:** its subject is designing a *cut-and-project set* (a discrete Delone set from a
  window), whereas ours is the dense module itself with a denominator-and-disc cut, so the relevance is
  analogical rather than direct. **Interlibrary-loan ask, second behind Nagell 1953.**

---

---

## §PA.9 — What, if anything, of phase H3 would be new in a paper's terms

*Stated so it cannot be oversold, and so a reviewer who reads only this section gets the honest version.*

**NOT new — four things, each with its citation:**

| the claim a draft might make | who has it |
|---|---|
| "the vertex set is every point of a number field's plane inside a disc" | **Kalai and Silberman, Polymath16 first thread, 18–19 April 2018** — proposed, with both obstacles named, never implemented (§PA.0.1) |
| "the base lattice's coordinate restriction says the points lie in the quartic CM field `ℚ(√−3,√−11)`" | **Speyer's own basis, 25 April 2018**, `(a + b√−3 + c√−11 + d√33)/(2·3^k)`; and **Gibbs's wiki form of `R̄₂`** with the congruences (§PA.0.2, §PA.2a) |
| "the base lattice's two congruences" | **Gibbs's wiki definition of `R̄₂`**, verbatim after relabelling (§PA.2a) |
| "the usable rotations are `cos θ = (2n−1)/(2n)`" | **`[Polymath16wikiMain]`'s `ω_t`** (2018), with the spindle reading in words; also `[PartsOdd2022]` §3's `m₁ = m₂`, `r = 1` slice (phase H2's settled verdict) |
| "the number of module points on a circle" | **`[BaakeGrimm2003]`** Theorem 1 and its Remark (phase H2's settled verdict) |
| "the circle count doubles when the module gains `ζ₁₂`" | **`[BaakeGrimm2003]`**'s Remark, whose prefactor *is* the module's roots of unity on the unit circle — with the maximal-order gap (§PA.4a) |
| "`ρ_n` is a coincidence rotation of an imaginary quadratic order" | **phase H2 §PA.4 Q1** already; and the index is `Σ = n` (§PA.4b), a classical object under translation |

**Possibly new — three things, in descending confidence:**

1. **The combination: a full field-plane module as the BASE of a base-plus-rotated-copy construction.**
   Kalai and Silberman proposed a distance-`T` graph on a box with no rotated copy; every type-M
   construction in print (de Grey, Heule, Parts, Exoo–Ismailescu, Voronov et al., Haugland) generates its
   base from unit vectors. **Nobody has put the two together.** Confidence **high** on the negative —
   six constructions read at the source, and the corpus searched exhaustively with controls — and the
   negative is the strong kind, since the module framing is *present* in the corpus and simply never
   truncated.
2. **The finiteness cut.** Silberman named the obstacle — *"the image is dense in the real numbers. It is
   therefore not obvious how to make the graph finite"* — and proposed lattice reduction on `O_K ⊂ K⊗ℝ`
   followed by a box and a projection. **The phase's answer is different: bound the denominator and cut
   with an exact inequality at all four conjugates.** That is a better answer for this purpose (it is
   isometry-natural and exact, where his is basis-dependent and approximate), and it is the concrete
   technical content a methods section would carry. Confidence **medium**: it is a small idea, and I did
   not find a source for it because I did not know what to search — see §PA.10.
3. **The submodule itself, as an object nobody has a word for.** A rank-halving, symmetry-lowering
   submodule of a planar module is excluded by definition from the one literature that studies planar
   submodules systematically (§PA.4). That is a *gap*, not a result — but it is the kind of gap that makes
   a naming contribution real, and it is the one place a write-up could honestly say the vocabulary does
   not exist. Confidence **high** on the exclusion (two definitions read at the source), **low** that
   anyone will care without a theorem attached.
4. **Dropping the Loeschian restriction on the rotation family.** The wiki's own list is
   `t ∈ {1,3,4,7,9,12,…}`, the squared distances realised in the triangular lattice; **`t = 2` is not
   Loeschian**, which is why the cheapest wall-breaking 6-open member was never examined. Confidence
   **medium-high** that the restriction is universal in print, **but note it converges with, rather than
   contradicts, phase H2's own caution** that `n = 2`'s circle is not *free*. The two are the same fact in
   two vocabularies, and a paper should say so rather than claim a discovery.

**The sentence a paper would actually be built on, if the phase lands:** *"Every published construction of
a 5-chromatic unit-distance graph generates its vertex set from a finite list of unit vectors. We instead
take the whole denominator-bounded module of a biquadratic field inside a disc — the object Kalai and
Silberman proposed in 2018 and nobody enumerated — and show that it carries [X] at a rotation outside the
Loeschian family."* Everything before "and show that" is prior art, correctly attributed; the value is
entirely in `[X]`, and **if `[X]` is empty the phase has no paper, only a negative worth recording.**

**And the two sentences the brief asks to be carried into every report still hold here.**
**Un-eliminated is not alive:** finding that nobody did this is not evidence that it works, and the one
thing the corpus *does* record about the smaller module — Gibbs's *"`R̄₂` has non-linear 4-colorings and
all 4-colorings are periodic with period 8"*, which agrees with Theorem B — is a reason nobody bothered.
**Silence is not evidence:** a literature negative fires one way only.

---

## §PA.10 — What I could not settle, ranked

1. **Whether the wiki's `ω_t` paragraph and its `ℤ[ω₁,ω₃,ω₄,ω₁₆]` table entry force a rewording of
   `CLAUDE.md` G7 and ledger row 64.** This is a ruling for the product owner, not a search. The facts are
   in §PA.2's last block; my reading is that the *angle family* was already credited (phase G §PA2) but
   that **"the spindle reading" and "`ρ₆₃` is a generator of de Grey's own ring" are stated on the wiki and
   not in our records**, and that what survives as ours is the radicand form, the field screen, the
   6-openness test, and dropping the Loeschian restriction.
2. **Whether `[Polymath16wikiMain]`'s "smallest ring" question belongs in `CLOSED-QUESTIONS.md` § 3.** It
   is not there; only `[ExooIsmailescu2019]`'s smallest-**subfield** version is. I did not add it, because
   adding a row to that ledger is a publication-trigger decision.
3. **CLOSED 2026-09-12 — the two-database cross-check (gate Q7) is done, and it changed one conclusion and
   corrected one of my own reports.** Semantic Scholar and OpenAlex **both** report `cited_by_count = 0`
   for `[BaakeZeiner2017]` — **and their agreement is not independent confirmation**: both records carry
   the same MAG identifier (`2759990410`) and both are the **preprint**. OpenAlex holds the **published
   book chapter** as a separate work with **4** citing papers. **A zero from two databases that share a
   source is one database's zero**, and this is the sharper form of phase H2's "open the list, do not
   compare counts". For `[BaakeGrimm2003]`: OpenAlex **14**, Semantic Scholar **7** — and the sweep's
   report that *"OpenAlex has no DOI record"* for it was **wrong**, the DOI resolving to `W1965389395`.
   **Both citing lists were opened.** Nothing in either is a planar module over a non-cyclotomic field —
   they are Baake's own follow-ups, model-set and covariogram work, coordination numbers, pinwheel
   diffraction — so **the negative stands, now with a denominator.** **One find the cross-check paid for
   on its own**, which neither sweep and neither of phase H2's readers had surfaced: **Zhuravlev, *Sums of
   squares over the Fibonacci ○-ring*** (2007), which cites `[BaakeGrimm2003]` and whose title is a
   sums-of-two-squares count over the integers of `ℚ(√5)` — **possibly a worked non-cyclotomic case of
   exactly the quantity `[BaakeZeiner2017]` Remark 7.12's inventory says nobody has done.** Flagged, not
   read; `BIBLIOGRAPHY.md` § C.
4. **Whether §PA.4(b)'s `Σ = n` recognition is stated in print**, in `[BaakeScharlauZeiner2011]` or
   elsewhere. It was derived here and verified symbolically; no paper was found stating it.
5. **`[Polymath16wikiR2]` and the wiki Dropbox** — both one fetch each, neither done.
6. **Pleasants 2000 and Nagell 1953** — interlibrary loan, inherited from phase H2 unchanged.
