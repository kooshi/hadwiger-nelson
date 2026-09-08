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

## 1. The search: is the exact value known? — **No, and here is the evidence**

Kooshi: *"are we sure no one has found this? Search for the claim exactly."* Run 2026-09-08:

| test | result |
|---|---|
| arXiv full search, `all:"Hadwiger-Nelson problem over"` | **1 hit, ever: Madore 2015** |
| arXiv abstract search, `"chromatic number"` + `"number field"` | **0 hits** |
| arXiv abstract search, `"Hadwiger-Nelson"` + `"field"`, 2015–2026 | **2 hits, both 2015**: Madore, and Bardestani–Mallahi-Karai (Borel chromatic numbers, a different question) |
| **every citation of Madore 2015** (Semantic Scholar: exactly **4** in eleven years) | `[Krebs2022]` — cites him for the `≥ 4` bound, does not close it; *Chromatic number of spacetime* (2308.16885) — cites him only for a pseudo-Euclidean question; Exoo–Ismailescu 1805.00157 — a new proof of `χ(ℝ²) ≥ 5`; one unindexed item |
| web search on the claim | returns the bracket `4 ≤ χ ≤ 5` as the state of the art |
| `[Soifer2024]`, the field's standard reference, 2024 edition | carries **Benda–Perles Open Problem 11.6** as open and contains no number-field chromatic theory at all |

**Conclusion: the public state of the art is `4 ≤ χ(ℚ(√3,√11)²) ≤ 5`, standing since 2015, in a paper with four
citations none of which touches it.** The exact value is not in the literature. *(Registered caveat: Geombinatorics
is print-first and poorly indexed, and `[Johnson2006]` — the compendium of this exact direction — is not obtained.
See §5 R2.)*

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

**The test:** *would Fischer, Moorhouse, Madore, Soifer, Johnson, Vinh and Krebs each recognize every term
without a definition, and would each find this paper by searching for what they themselves called it?*

## 5. Still owed before submission (blocking, per G50)

* **R1 — `[Fischer1990b]`**, *The connected components of the graph `ℚ(√N₁,…,√N_d)²`*, Congr. Numer. 72 (1990)
  213–221. The **multiquadratic** paper, on exactly this paper's fields. Not digitised; needs a library.
* **R2 — `[Johnson2006]`**, the compendium of this exact direction, Geombinatorics XVI(1) 209–218. **The one
  place a seventh lineage could hide.** Print-only.
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

**Venue:** arXiv immediately, then **Discrete Mathematics** (Fischer's, Johnson's and Chow's home), with
*Geombinatorics* second. A unification paper wants the well-indexed venue — the whole thesis is that obscurity
caused the duplication, and `[Moorhouse2010]`'s fate is the cautionary example.

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
* **R-e: tone.** A paper that says "six people missed each other" must be generous, not clever. Every one of the
  six did good work; the failure is the literature's structure, not theirs — and we are the sixth, which is the
  fact that makes the paper honest rather than smug.

## 9. Cost and bearing

Four to six days of writing (up from three to five: the unification is real work). **No compute, no new Lean.**
Bearing on `χ(ℝ²) ≥ 6`: **none directly** — but the unification is the literature review the programme's own
next milestones need, and doing it once properly is what stops G49 firing a third time.
