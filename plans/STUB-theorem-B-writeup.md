# FS-20 — The paper: one reduction, six lineages, and the first exact value past the Moser obstruction

*(pre-subplan stub; **rewritten 2026-09-08** after `[Madore2015]` was found and the exact claim was searched)*

*Minted at the FS-18 close on Kooshi's firing of the write-up trigger. **Re-scoped the same day**, twice. First
down — `[Madore2015]` turned out to contain much of the machinery, and Kooshi's read of the demand signal was
"clearly they're not looking too hard for it". Then back up, on his own correction: **"it feels like it goes back
up honestly… I think unifying all these lineages is now worth the paper… maybe even if we're the second to find
it."** He is right, and this stub is built around that, not around one exact value.*

---

## 0. What the paper is

**Not** "we computed a chromatic number". The paper is:

> **One theorem has been discovered six times in five decades, by six groups in four literatures that do not
> cite one another. Here it is in the generality its authors kept stopping just short of; here is the first
> exact value it yields past the classical obstruction, closing an eleven-year-old bracket; and here is all of
> it machine-checked.**

Three deliverables, in this order of weight:

1. **The unification.** The reduction — *colour a plane over a field by reducing modulo a prime where the form
   `x² + y²` is anisotropic* — with the six independent derivations set beside one another and their
   dependencies drawn. Nobody has done this. It is the paper's spine and the reason it is worth writing.
2. **The general form.** Theorem A: an arbitrary graph *drawn* in an abelian group, edge differences in a
   subgroup, non-zero under a partial homomorphism out of it. No field, no metric, no ring, no valuation, no
   Cayley structure. **This is the formulation Madore explicitly declined to write** (§2).
3. **The exact value.** `χ(ℚ(√3,√11)²) = 4`, closing `[Madore2015]`'s `4 ≤ χ ≤ 5`. Everything is kernel-checked.

## 1. The search: is the exact value known? — **No, and here is the evidence (re-run 2026-09-09)**

Kooshi: *"are we sure no one has found this? Search for the claim exactly."*

**⚠ THE 2026-09-08 RUN WAS FLAWED, AND THE FLAW IS INSTRUCTIVE — it is `G50` inside a check written to
enforce `G49`.** It walked the citations of `[Madore2015]` and **characterised each one by its abstract**.
`[ExooIsmailescu2019]` was dismissed in five words as *"a new proof of `χ(ℝ²) ≥ 5`"*, which is exactly what its
abstract says and exactly what its **conclusion does not**: three lines above its Madore citation it asks the
question this paper answers. The paper was **on our own shelf, held since 2026-09-05**. A citation list is not a
literature review; the fix is to open the papers, and the repair below does.

### 1a. The corrected citation audit of `[Madore2015]` — all four, opened

| citing work | what it actually says | threat to novelty |
|---|---|---|
| **`[ExooIsmailescu2019]`** (Discrete Comput. Geom. 2019 / arXiv:1805.00157) | **Asks our question.** Verbatim, concluding section: *"One interesting question is whether there exists a 5-chromatic unit distance graph which can be embedded in `Q[√3,√11] × Q[√3,√11]`. If true, this would be the best possible as a recent result of Madore shows. More generally, what is the smallest subfield of `E²` that requires 5 colors?"* **`χ(K²) = 4` answers the first sentence outright (no, there is none); the second is M58's sieve and stays open.** Also on that page: Heule's 826-vertex witness in `Q[√3,√11,√5]`, and *"What is the minimum order of a 5-chromatic unit distance graph in the plane?"* | **none — it poses the question, and is a fourth independent posting** |
| **`[Krebs2022]`** (J. Algebraic Combin. 2023) | cites Madore for the `≥ 4` bound only; his own content is clique numbers, and his `χ > ω` section is Prop. 6.1, weaker than what we hold at every prime that matters | none |
| **Davies, *Chromatic number of spacetime*** (Acta Arith. 2024 / arXiv:2308.16885) | **opened 2026-09-09, held locally.** Cites Madore once, for the pseudo-Euclidean question and the observation that `χ(ℝ^{1,1}) = ∞ ⟹ χ(ℂ²) = ∞`. Zero number-field chromatic content (checked by full-text sweep) | none — the 2026-09-08 characterisation was right |
| **`[Aggarwal2025]`** (MIT PRIMES 2025) — **the "one unindexed item", now identified** | **Names our exact field as the open case**: *"computing `χ(R^d)` for `d > 2` and `χ(K^d)` for certain fields `K`, particularly when `K = Q(√3,√11)`"*, citing Madore. **Does not compute it.** Uses the **Moser Lattice `L_moser ⊂ Q[√3,√11]²`** (our direction ladder under another name) and, in his Thm 2.8, the *norm-one ⟹ unit in `O_{K(i)}`* observation that is our Theorem A's engine — for finiteness of unit vectors, not for a colouring | **none, and it is a gift**: an independent 2025 appearance of both our field and our hinge |

### 1b. The search the 2026-09-08 run should have done — the citations of the paper that POSED the question

Anyone answering *"is there a 5-chromatic unit-distance graph in `K²`?"* would cite **Exoo–Ismailescu**, not
Madore. That is a different and much larger graph — **47 citing works** (Semantic Scholar, 2026-09-09) against
Madore's four — and it was never walked.

| test | result |
|---|---|
| all 47 citations of `[ExooIsmailescu2019]`, titles and venues scanned | **none answers the `K²` question.** The near neighbours were opened: Voronov et al.'s 5-chromatic constructions (Discrete Math. 2021), Noble's *Embedding Euclidean distance graphs in `ℝⁿ` and `ℚⁿ`* (already a recorded negative, §B), Mukherjee's *conditional approach* (arXiv:2210.16212 — measure-theoretic, no fields), and the ICML 2025 neural six-colouring paper. Nothing computes `χ` over a proper extension of `ℚ` |
| **`[CostaSilvaFilho2026]`** (arXiv:2607.19995, July 2026), the one 2026 citation about **fields** | certifies the **exact coordinate fields** of the triangle-free Exoo–Ismailescu graphs EI17/EI19 by Galois theory — the nearest published relative of this repository's exact-geometry layer, and evidence the community has begun doing exact field arithmetic. **No chromatic number over a field; no `Q(√3,√11)`; does not cite Madore** | none |
| OpenAlex cross-check of Madore's citation count | **1** (it indexes only the Exoo–Ismailescu preprint), against Semantic Scholar's 4 — so a single-database citation audit is itself unsafe, and both were run |

### 1c. The direct searches, re-run

| test | result |
|---|---|
| arXiv full search, `all:"Hadwiger-Nelson problem over"` | **1 hit, ever: Madore 2015** |
| arXiv abstract search, `"chromatic number"` + `"number field"` | **0 hits** |
| web search on the exact claim (`χ` of `Q(√3,√11)²`, 4-colourability of that plane) | returns the `[4,5]` bracket and the two-distance witness literature; **nobody states the value** |
| `[Soifer2024]`, the field's standard reference, 2024 edition | carries **Benda–Perles Open Problem 11.6** as open; contains no number-field chromatic theory at all (838 pages swept, FS-18) |
| any claim CONTRADICTING Theorem B (a 5-chromatic unit-distance graph inside `K²`) | **none found, and the literature says the opposite**: Exoo–Ismailescu 2018 call it open, their own witness needs `√247`, Heule's needs `√5`, de Grey's needs `√5, √7`. Consistent with `χ(K²) = 4` |

**Conclusion, on better evidence than the first run had: the public state of the art is
`4 ≤ χ(ℚ(√3,√11)²) ≤ 5`, standing since 2015, and the exact value is not in the literature.**

**And the repair STRENGTHENS the paper's thesis rather than denting it.** The question has now been posed or
named **six times across fifty years, in four literatures that do not cite one another**:

| # | who | where | what they asked |
|---|---|---|---|
| 1 | **Benda–Perles** | circulated 1976, published Geombinatorics IX(3) 2000; in `[Soifer2024]` ch. 11 as Open Problem 11.6 | *"Find the chromatic number of `ℚ²(√2)` and, in general, of any algebraic extension of `ℚ²`"* |
| 2 | **`[Moorhouse2010]`** §1 | unpublished draft, finite geometry | *"We have not determined the exact value of `χ(K²)` in this case"* |
| 3 | **`[Madore2015]`** Prop. 4.6 | arXiv, number theory | proves `4 ≤ χ(K²) ≤ 5`, leaves the gap |
| 4 | **`[CranstonRabern2015]`** | Combinatorica | *"What is the fractional chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`? What about its chromatic number?"* |
| 5 | **`[ExooIsmailescu2019]`** | **Discrete & Computational Geometry** — the strongest venue of the six | *"whether there exists a 5-chromatic unit distance graph which can be embedded in `Q[√3,√11] × Q[√3,√11]`"* |
| 6 | **`[Aggarwal2025]`** | MIT PRIMES | names `χ(K^d)`, *"particularly when `K = Q(√3,√11)`"*, as the case to study |

*(Registered caveat, unchanged: Geombinatorics is print-first and poorly indexed, and `[Johnson2006]` — the
compendium of this exact direction — is still not obtained. See §5 R2.)*

**Method note for the next check (and for `WORKFLOW.md` step 3a):** walk the citation graph of the paper that
**posed** the question, not only of the paper that **proved** the nearest result; open every citing work whose
title is in the neighbourhood rather than characterising it from its abstract; and cross-check the citation list
in at least two databases, because they disagreed here by a factor of four.

## 2. The six lineages — the paper's actual content

Each derives the same reduction, or its immediate neighbourhood. **The citation graph between them is almost
empty**, which is the fact the paper exists to repair.

| # | source | what it has | who it cites from this list |
|---|---|---|---|
| **1** | **Woodall 1973 → Benda–Perles 1976/2000 → Johnson 1982/87/89 → Chow 1993** (Discrete Math / Geombinatorics; the rational base case) | `χ(ℚ²) = 2` by odd denominators; `Aₙ`; the complete classification of forbidden distance sets by the **two-index** `v₂(d²)`. **Mechanism is odd cycles in a Cayley graph — an existence proof, no colour formula** | each other |
| **2** | **`[Fischer1990]`** (Discrete Math) | **the step to a homomorphism**: `F²` is 2-colourable iff a non-zero ring hom `Σ₀ → ℤ/2` exists; the complete real-quadratic classification (Thms 8–10); the `1/k ∈ Σ₀` obstruction; the polynomial test (Thm 7) | Johnson, Benda–Perles, Woodall, Chilakamarri |
| **3** | **`[Moorhouse2010]`** (unpublished draft; finite geometry) | `K²` over any commutative ring; `χ(K²) = χ(K₀²)`; the Cayley-hom lemma; **the finite-plane bound** (§8.2, §10.3); **Table 6.1 with `χ(𝔽₁₁²) = 5`**; the odd-degree 2-adic colouring; **the Hedetniemi tie for composite ideals** | **nobody on this list** |
| **4** | **`[Manturov2012]`** (Russian; integer/rational lattices) | the reduction along a ring homomorphism **in all dimensions** (Thms 17–19); the `ℤ₃²` and `ℤ₅²` colourings | Benda–Perles only |
| **5** | **`[Madore2015]`** (arXiv; number theory) | **the valuation-ring form (Prop. 3.2)** with the coset-representative construction; **the finite-plane bound (Cor. 3.4)**; **the `mod m²` refinement (Prop. 3.8)**; Chevalley–Warning killing `d > 2`; an explicit 5-colouring of `𝔽₁₁²` and the footnote *"In fact χ((F11)²) = 5"*; `χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3`; **`4 ≤ χ(ℚ(√3,√11)²) ≤ 5`** | **nobody on this list** |
| **6** | **the finite-field side**: Medrano–Myers–Stark–Terras 1996 → `[Vinh2005]`/`[Vinh2006]` → `[SchneiderSilva2013]` → `[Krebs2022]` → `[LorenzZimmermann2023]`; and Bardestani–Mallahi-Karai 2015 on the Borel side | the spectra as Kloosterman sums; `√q/2 ≤ χ(𝔽_q²) ≤ q/2`; `ω ≤ 4`, then **`ω = 3` iff 3 is a square** (complete); `ω ≠ χ` above `q = 3`; the circle-intersection discriminant; and the same **anisotropy** dichotomy for Borel chromatic numbers over local fields | **`[Krebs2022]` is the only paper anywhere that cites both sides** |

**Two observations the paper can make that no single source can:**

* **The anisotropy condition is the hinge, and all six find it independently.** Fischer's `Σ₀`, Moorhouse's
  `|O/𝔭| ≡ 3 mod 4`, Madore's "`z₁²+⋯+z_d²` anisotropic over `κ`", and Bardestani–Mallahi-Karai's "`Q` represents
  zero non-trivially" are one condition wearing four costumes.
* **Everyone stops at the same place.** Fischer takes `A = Σ₀` and never needs a valuation. Madore needs a
  subgroup that is *not a ring* in his Prop. 3.9, does the coset construction by hand, and writes the
  parenthetical: ***"which the author has not found the courage to try to formulate under the most general
  auspices."*** **Theorem A is that formulation.** That sentence should appear in the introduction.

## 3. The credit table — the paper's spine, and non-negotiable

**Every attribution below was re-verified against the source PDF on 2026-09-09**, not carried from a summary,
because a unification paper is judged on exactly this and a wrong credit is the one error that cannot be
apologised away. Checked verbatim: `[Madore2015]` **Prop. 3.2** (the valuation-ring form with anisotropy over
`κ`), **Prop. 3.8** (the `mod m²` refinement), **Prop. 4.6** (*"If `K = Q(√3,√11)`, then `4 ≤ χ(K²) ≤ 5`"*, its
lower bound from his 2.4 and its upper bound *through the finite plane at 11*), and the *"has not found the
courage"* parenthetical — which introduces **Prop. 3.9**, where the obstacle is stated in his own words as
*"there is a slight difficulty, though, in that `(1/√2)A` is **not a ring**, so we can't immediately apply 2.2"*,
confirming that the thing he declined to formulate is exactly what Theorem A formulates. Checked verbatim:
`[Moorhouse2010]` **Prop. 1.4(b)**, *"`K²` contains a Moser spindle iff `K` contains `1/66`, `√3` and `√11`"*.


| piece | whose |
|---|---|
| `χ(K²) ≥ 4`; `K` is the smallest number field whose plane holds a Moser spindle | **`[Moorhouse2010]` Prop. 1.4(b)**, and independently `[Madore2015]` §2.4 |
| the additive/homomorphism framework | **`[Fischer1990]` Thm 1** |
| the reduction at an anisotropic prime | **`[Moorhouse2010]`, `[Manturov2012]`, `[Madore2015]` — three times** |
| **the valuation-subring form** (our `colorable_unitDistance_induce_of_valuationSubring`) | **`[Madore2015]` Prop. 3.2** |
| the `mod m²` refinement (our parity descent) | **`[Madore2015]` Prop. 3.8** |
| the `1/k` obstruction | **`[Fischer1990]` Thm 10(ii)** |
| `χ(𝔽₁₁²) = 5` | **`[Moorhouse2010]` Table 6.1**; known to `[Madore2015]` |
| `ω(UD(F,2)) = 3` iff 3 is a square | **`[Krebs2022]` Thm 5.2** |
| **Theorem A in full generality** — arbitrary graph, arbitrary subgroup, partial homomorphism | **ours**, and it is the formulation Madore declined |
| the forced-pair-at-`8/3`-then-spindle move into `ℚ(√3,√11,√247)` | **`[ExooIsmailescu2019]` Claim 2.1 (2018)**, whose `G40` forces `[0,0,0,0]` and `[0,0,96,0]` — distance `8/3` — then rotates by `sin θ = 3√247/128`. **Ours is the UNCONDITIONAL version** (their forced pair is conditional on no monochromatic `√(11/3)`-pair, so they need three acts); M53's T20 novelty claim was retracted 2026-09-09 |
| **`χ(K²) ≤ 4`, hence `= 4`** — closing an eleven-year-old bracket | **ours** |
| **the unification and its citation graph** | **ours** |
| **every line machine-checked** on axioms exactly `[propext, Classical.choice, Quot.sound]` | **ours**, and a first in this literature |

**Free corollary, one sentence:** with `[CranstonRabern2015]`'s `χ_f(K²) ≥ 76/21`, the fractional number is now
bracketed **`76/21 ≤ χ_f(K²) ≤ 4`** — a partial answer to the other half of their question.

## 4. The naming problem — a first-class deliverable (Kooshi's explicit requirement)

**Every working term in this repository is coined in-house and appears in no paper** — the exact mechanism G49
identifies as having hidden this prior art. Publishing in that vocabulary would make the paper unfindable by the
six groups it is trying to unify, which for *this* paper is self-defeating in a way it would not be for another.

**Banned from the manuscript:** `Theorem A`/`Theorem B` · *field wall* · *wall-broken* · *5-sealed* / *sealing
prime* · *seam plane* / *seam field* / *seam group* · *the finite-plane bound* · *the descent* · *the dial* ·
*cheats* · *the ladder* · *the hexagram* · *pigeonhole × kill* · `G1…G50`.

| # | decision | recommendation |
|---|---|---|
| **N1** | the general construction | It must sit correctly beside **Fischer's "additive `k`-colouring"** and **Madore's valuation-ring reduction**, because a unification paper is judged on exactly this. Test: *an additive colouring subordinate to a subgroup* |
| **N2** | the anisotropy/2-adic criterion | **Do not name it.** Fischer, Madore and Bardestani–Mallahi-Karai all state it unnamed; naming it would obscure that they are the same condition, which is the paper's point |
| **N3** | **"quadrance" or not** | The term picks a readership: `[Vinh]`/`[Krebs]` say *unit-quadrance graph*, `[Moorhouse]`/`[Fischer]`/`[Madore]`/`[Soifer]` say `K²` and *unit-distance graph*. **Recommendation: `K²` throughout, and one explicit sentence naming "unit-quadrance graph" as the finite-field literature's term for the same object — that sentence IS the bridge this paper exists to build**, and `[Krebs2022]` is the sole precedent for crossing it |
| **N4** | the title | must be findable from either side. It should say *the reduction*, *number field*, and the value |
| **N5** | **"virtual edge" — the literature has already rejected it, in print** (found 2026-09-09, reading `[Parts2020a]` §2 at the source) | Parts, verbatim: *"A non-mono pair that does not define an edge has sometimes been termed a **virtual edge**, but in our opinion, this term is not entirely successful, since it does not clearly express whether one means a mono- or non-mono-pair, which leads to confusion."* **This project uses "virtual edge" in almost every milestone.** His vocabulary — ***mono-pair***, ***non-mono-pair***, ***spindle*** (*"a cycle of two mono-pairs and a unit edge"*) — is the two-distance community's, it is published, and it is *better*: it names the polarity, which is exactly the distinction the 2-adic law turns on. **Recommendation: adopt mono-pair / non-mono-pair throughout and drop "virtual edge", noting the term in one parenthesis for readers who know it.** This is the ban list's own principle applied to a coinage we did not coin but did inherit |

**The test:** *would Fischer, Moorhouse, Madore, Soifer, Johnson, Vinh and Krebs each recognize every term
without a definition, and would each find this paper by searching for what they themselves called it?*

## 4b. A SEVENTH LINEAGE, found 2026-09-09 (FS-23) — the Moser-lattice community, and it is the nearest neighbour

**This is the most consequential thing FS-23 found, and it is a gap in §1's evidence, not in the theorem.**
There is an active group — Rényi Institute plus the Polymath16 blog — working with **our exact objects under a
published name**, and none of it was in `BIBLIOGRAPHY.md` before today:

* **`[MatolcsiEtAl2025]`** (`χ_f(ℝ²) ≥ 4`, arXiv:2311.10069) define the **Moser lattice**
  `L = ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩` with `ω₃ = (5 + i√11)/6` — **this project's direction ladder** (ledger row 46, T13) —
  note that `[ℚ(ω₁,ω₃):ℚ] = 4`, and observe that every best-known construction lies in it.
* **`[Ducz2026]`** (arXiv:2606.12325, 10 June 2026) proves the lattice and the **Moser ring** `L[1/3]` have
  **exactly two** integral *geometric* 4-colourings, given by an explicit hom onto `(ℤ/2)²`, with properness
  through the congruence `N + M ≡ 0 (mod 4)` on `|z|² = (N + M√33)/6`. **That is the identification half of
  ledger row 59's 2-adic law, in coordinates, three months before we proved it** — and it reproduces ten for ten
  of the published data our law explains.
* **`[Hubai2018]`** characterised the **22 essentially different 4-colourings of the Moser ring** in a Polymath16
  blog comment in **May 2018**.
* **`[DuczVarga2026]`** (June 2026) push it to `χ_f(ℝ²) > 4`, still inside the Moser lattice.

**Does this threaten the paper's central claim? No — and the distinction must be stated in the paper's own §1,
in one paragraph, or a Polymath16 referee will read the manuscript as re-proving a 2018 blog comment.** The
Moser ring is a `ℚ`-**rank-4** subring of `ℂ`; the field plane `K² = ℚ(√3,√11)²` has `ℚ`-rank **8** and is not
generated by the Moser lattice. `[Madore2015]`'s `4 ≤ χ(K²) ≤ 5` (2015) is the state of the art *for `K²`*, it
is stated by an author who knew the residue method thoroughly, and it stood until Theorem B. Every open
question the paper answers — Benda–Perles 11.6, Moorhouse §1, Cranston–Rabern — is asked about the **field**
plane. **But §1's "verified open" evidence does not currently cover this community at all, and it must**:
Polymath16 threads are not indexed by any citation database, and Geombinatorics is not indexed well either.

**Two consequences, both actionable.**

1. **New blocking item R6 below**: read the Polymath16 threads for `ℚ(√3,√11)` claims. This is where a
   fourth-colour result for the field plane would sit if it exists, and it is the one place §1 has never looked.
2. **A live opportunity for the paper, stated as a lead and not a result.** `[CranstonRabern2015]` ask two
   questions and we currently close only the second (`χ(K²)`), bracketing the first at
   `76/21 ≤ χ_f(K²) ≤ 4`. `[MatolcsiEtAl2025]`'s `G27` lies **entirely in the Moser lattice**, hence in `K²`,
   with `χ_gf(G27) = 4`; their blow-up to `χ_f ≥ 4 − ε` uses the amenability of the plane's isometry group.
   **The subgroup preserving `K²` — `z ↦ az + b`, `a` a norm-one element of `K(i)`, `b ∈ K²` — is metabelian,
   hence amenable, and dense in the full group.** If their Følner argument survives that restriction then
   `χ_f(K²) = 4` exactly and **Cranston–Rabern's first question closes too**. Not attempted here; the
   amenability step is where the work is; a day, and it would strengthen the paper's headline from one answered
   question to two.

## 5. Still owed before submission (blocking, per G50)

* **R6 — the Polymath16 threads (NEW, 2026-09-09, and it is now the top of this list alongside R2).** Seventeen
  threads on Dustin Mixon's blog, plus the wiki mirror at `asone.ai/polymath`. Search them for `ℚ(√3,√11)`,
  "Moser lattice", "Moser ring", and any four-colouring claim about a field plane. `[Hubai2018]` shows the
  community was enumerating 4-colourings of the Moser ring in 2018; `[Heule2021]`'s odd-distance duality and
  `[PartsOdd2022]`'s `ℚ(√3,√11)` observation both come out of it. **No citation database indexes it**, so no
  search in §1 has ever touched it.

* **R1 — `[Fischer1990b]`**, *The connected components of the graph `ℚ(√N₁,…,√N_d)²`*, Congr. Numer. 72 (1990)
  213–221. The **multiquadratic** paper, on exactly this paper's fields. Not digitised; needs a library.
* **R2 — `[Johnson2006]`**, the compendium of this exact direction, Geombinatorics XVI(1) 209–218. **The one
  place a seventh lineage could hide.** **NEARLY IN HAND**: the OJS galley is at
  `https://geombinatorics.uccs.edu/archive/index.php/home/article/view/62/198` (Kooshi, 2026-09-08) — a browser
  walks through the Cloudflare challenge that blocks every script. Needs a subscription or a one-off purchase.
* **R3 — `[BendaPerles2000]`**, to quote Open Problem 11.6 from the source rather than through Soifer.
* **R4 — `[MMST1996]`**, still second-hand.
* **R5** — hand-check Geombinatorics' back issues 2015–2026; it is where this community publishes and it is not
  indexed well enough for §1's searches to have covered it.

## 6. Shape, venue, artifact

**Shape:** (1) introduction — the six lineages, the citation graph, the question posed four times;
(2) the general theorem; (3) how each of the six is an instance or a neighbour; (4) the field `K` and the order
`ℤ[ω, i, T]`; (5) `χ(K²) = 4`; (6) consequences, incl. the fractional bracket; (7) formal verification, stating
exactly **what is not** proved in Lean (the residue-field-size statement is not; the σ-stability half is);
(8) open problems handed back, incl. the number-field analogue of Chow's classification (FS-19).

**Venue — REVISED 2026-09-08 on Kooshi's read of the field** (*"It looks like geombinatorics is where we want to
be though"*), and he is right, with one condition that is not a hedge:

**arXiv on completion, and submit to *Geombinatorics*.** Not a compromise — the two do different jobs and the paper
needs both.

*Why Geombinatorics is the right journal.* It is not merely where this community publishes; it is where **four of
this paper's six lineages actually appear**: `[BendaPerles2000]` (the source of the open problem), `[Johnson2006]`
(the compendium), the Exoo–Ismailescu and Parts two-distance work, and Soifer's own essays. **Alexander Soifer
edits it, and his 2024 book poses the open problem this paper answers and then refers the reader to Johnson's
compendium in the same journal.** A unification of this literature submitted anywhere else is addressed to people
who did not write it.

*Why arXiv is not optional.* **The paper's thesis is that this literature is hard to find, and Geombinatorics is
the sharpest instance of the diagnosis.** Concretely, on 2026-09-08: its digital archive sits behind a Cloudflare
browser challenge (`[Johnson2006]`'s own PDF is one click from a browser and unreachable from a script); its
subscription flow defeated a motivated reader; its two web properties disagree (a metadata-only listing at
`geombina.uccs.edu`, an OJS archive at `geombinatorics.uccs.edu/archive`); zbMATH carries no review for the
compendium; and this project — actively hunting exactly this literature, with a prior-art gate in its workflow —
**took a day of searching to learn that the compendium exists.** Publishing the diagnosis *only* into the venue
that best exemplifies it would perform the failure the paper documents.

So: **arXiv gives permanence, indexing and a citable preprint the day it is done; Geombinatorics gives the
readership that posed the question.** Discrete Mathematics (Fischer's, Johnson's and Chow's archival home) stays
the fallback if Geombinatorics declines or stalls.

*One thing to decide before submitting, not after:* whether the §3 credit table and the tone rules (§8 R-e) read
correctly to an editor who is himself one of the people being unified. They should — the paper is generous by
construction and names us sixth — but Soifer is the reader most able to tell if they do not.

**Artifact:** the zeta-23 comparator pattern (`CLAUDE.md` § Paths forward), or a repository link plus the
`#print axioms` receipt. **Do not claim independent-kernel replay unless `lean4checker` has actually been run.**

## 7. Registered predictions

* **P1** — R1–R5 turn up no exact value for `χ(K²)`, and the result stands. *(Medium confidence; R2 is the risk.)*
* **P2** — R1–R5 turn up **at least one further lineage or near-miss** we do not yet know about. *(The base rate
  over 2026-09-08 is five for five.)*
* **P3** — the naming pass overturns at least two of N1–N4.
* **P4** — under 25 pages.
* **P5** — writing §3 honestly surfaces at least one more attribution currently wrong.

## 8. Risks

* **R-a: the unification claim is the paper's weight-bearing wall, and it is a claim about absence.** "These six
  do not cite each other" must be checked citation by citation, stated as *what we could find*, and never
  overstated. G21 applies to us here more sharply than anywhere.
* **R-b: overclaiming the formalization.** The Lean proves `χ(K²) = 4`; it does not prove the general
  number-field residue-field-size statement.
* **R-c: our vocabulary leaking in.** A dedicated late pass grepping for every banned term.
* **R-d: scope creep.** The sieve, the lift theory, the compulsion transfer and the tightness mechanism
  (M58–M61) are **not** in this paper.
* **R-e: TONE — and this is a hard requirement, not a risk to be managed.** Kooshi, 2026-09-08, on reading a
  draft of this section: *"We shouldn't be smug at all, I mean, it shouldn't even risk coming off that way."*
  The bar is therefore not "avoid smugness"; it is **leave no sentence that could be read as smug by an unkind
  reader on a bad day** — including by any of the six authors, each of whom will recognize their own work in it.

  What that means concretely, and every one of these is checkable:
  - **The paper never says anyone "missed" anything.** They worked in different decades, different countries,
    different disciplines, and mostly before the search tools that made this synthesis possible existed. Fischer
    and Chow published in the same volume of the same journal on the same problem without meeting; that is a
    fact about how mathematics is indexed, not about them.
  - **We are the sixth, and the paper says so early and plainly.** We did not find these six by being careful.
    We found them *after* reconstructing four milestones' worth of results that were already published, and we
    found the closest one — Madore — only because a reference list in a paper we had wrongly declared
    unobtainable happened to name it. The introduction states this. It is the paper's own evidence for its
    thesis, and withholding it would be both dishonest and worse writing.
  - **Every one of the six is cited for what they did, in their own vocabulary, at their strongest form** — not
    at the weakest form that makes our contribution look larger. §3's credit table is the instrument for this.
  - **Madore's "has not found the courage" line is quoted with warmth, never as a gotcha.** He identified the
    exact gap, said so in print, and declined to fill it — which is a service, not an omission. That we filled
    it eleven years later with a proof assistant he did not have is a statement about tools, not about
    mathematicians.
  - **No claim about novelty appears without its search attached** (§1), and no claim about absence of citation
    appears without "as far as we could determine".

  *The honest register for the whole paper: we are reporting a structural feature of a literature, we are
  standing inside the feature we are reporting, and the result we add is one value and one generalization on top
  of six people's work.*

## 9. Cost and bearing

Four to six days of writing (up from three to five: the unification is real work). **No compute, no new Lean.**
Bearing on `χ(ℝ²) ≥ 6`: **none directly** — but the unification is the literature review the programme's own
next milestones need, and doing it once properly is what stops G49 firing a third time.
