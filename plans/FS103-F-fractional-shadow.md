# FS103-F — the fractional shadow: do our field-level arguments run one colour class at a time?

*Derivation record of job **FS103-F**, de Bruijn, Opus 5.5, 2026-09-26. Brief: `data/fs103/briefs/F103-fractional-shadow.md`, with
`data/fs103/briefs/STANDING-RULES.md` as part of it. Not blind: every file is open to me. No subagents; no finite-witness search (ban to
2026-10-01); I touch only this file, `data/fs103/fs103-f/` and `tools/fs103_f_*.py`. Two blind verifiers run on FS-103; I have not
contacted them. Contact: `main` only.*

## Theorems this phase proved

*(filled stage by stage; grades per `CLAUDE.md` § Notation; every one is **one mind** — this job — unless marked)*

| id | statement (one line) | grade | where |
|---|---|---|---|
| (stage 1 proves nothing; see stages 2–3) | | | |

## Would-have-searched-here log (standing rule 3)

- (running; see each stage)

## Stage 1 — SAVED (quotation check; the controls of question 4; an order slip)

### 1.0 An order slip, recorded first

The brief asks for the controls to be written **before** questions 1–2. I read the sources for the quotation check and, in doing so, walked
questions 1–2 mentally and sent the owner the brief's one-line alert (a per-class theorem implying `χ_f > 4`) **before** writing this
section. So the controls below were written knowing where the derivation was heading: they are not a blind pre-registration. I wrote them as
if they were (each one names what would make the per-class claim wrong), and stage 2 scores them honestly.

### 1.1 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | "**if the chain's direction "a colouring of `F²` gives a CP colouring of `ℝ²`" runs on one colour class at a time** — … refuting the published conjecture" | `plans/FS103-G-prior-art.md` §2.3 item 2 | **verbatim** (the source's sentence opens with "So"; the brief drops it) |
| Q2 | `[MatolcsiEtAl2025]` "Conjecture 1. χf,0(R²) = 4, and for all finite unit distance graphs G ⊆ R² we have χf(G) < 4" | arXiv:2311.10069 v4, §4 end (`pdftotext` line 640) | **verbatim**: "Conjecture 1. χf,0 (R2 ) = 4, and for all finite unit distance graphs G ⊆ R2 we have χf (G) < 4." |
| Q3 | "(also `[AmbrusEtAl2023]` §4 Remark)" — cited, not quoted; §2.3 quotes it | arXiv:2207.14179 v3, the Remark after Corollary 2 | §2.3's quotation **verbatim**: "we venture to conjecture that χf (R2 ) = χgf (R2 ) = 4. This would imply that α1 (R2 ) = 1/4 and m1 (R2 ) ≤ 0.247 hold simultaneously, providing an interesting example of a natural infinite graph for which the measurable and the non-measurable variants of a parameter have different values." |
| Q4 | row 123: "every stable place of `F(i)` has all-levels four-colour ratio `< 1/4` ⟺ no stable residue target is four-colourable ⟺ `L(F) ≥ 5`" | `LEDGER.md` row 123 | **verbatim** |
| Q5 | "`m₁(ℝ²) ≤ 0.2470` (`[AmbrusEtAl2023]` Thm 1)" | arXiv:2207.14179 Theorem 1 | agrees: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." — **every measurable set, not only periodic ones** (their §2 reduces to periodic sets for the Fourier side, citing [deOV10, KeMOR16]) |
| Q6 | "their Lemma 1 works with finite-dimensional distributions" (the owner's reading) | same, Lemma 1 | Lemma 1 is **stated for "a measurable, periodic, 1-avoiding set A"**; its atoms `a_X(ε)` are densities of Venn atoms of translates of `A`, i.e. the finite-dimensional probabilities of the process `x ↦ 1_A(x + t)`, `t` uniform on a period cell. So the reading is fair in substance, but the lemma as printed assumes periodicity (answered in stage 3) |
| Q7 | "at `F_dG` (every stable place has `λ* ≤ 0.1734 < 1/3`)" | §2.3; `data/fs103/claims.md` C-131 ("Weil's `2√131/132 = 0.17342…`") | consistent |
| Q8 | "T-J39-3's forward direction (`plans/POROS-2026-09-25-wanted-poster-167.md` §3.2; `plans/FS100-BC-verification.md`) and the extension it uses (`plans/R88-derivation.md` R88-TC-ext)" | the three files | addresses resolve; T-J39-3 at wanted-poster §3.2, BC's L1–L6 at §2.1, R88-TC-ext in R88-derivation |

**The premise "refuting the published conjecture" is out of date — found at the quotation check.** `[MatolcsiEtAl2025]`'s Conjecture 1 was
**disproved in print on 26 June 2026** by `[DuczVarga2026]` (arXiv:2606.28157), held here and "read in full (2026-09-16, FS-56 §PA)"
(`BIBLIOGRAPHY.md`). Its abstract, verbatim: "We prove that there exists a finite unit-distance graph in the plane with independence ratio
strictly smaller than 1/4, answering a question of Erdős. … This disproves their Conjecture 1, and implies that the fractional chromatic
number of the plane is strictly larger than 4." Their G29 has `χ_gf(G29) > 4.0007` ("a rational dual witness, not claimed optimal", our
bibliography row). **And they pose a new conjecture** (§2.1, verbatim): "Conjecture 1. f (n)/n = m1 (R2 ) + o(1) and in particular that
m1 (R2 ) = δCroft." Here `f(n)` is the least independence number of an `n`-point unit-distance graph in the plane, so `lim f(n)/n = α₁(ℝ²)`
(disjoint far-apart copies), and **their conjecture's first clause is `α₁(ℝ²) = m₁(ℝ²)`**. Neither `plans/FS103-G-prior-art.md` nor the
milestone plan cites `[DuczVarga2026]`; `BIBLIOGRAPHY.md`'s own `[MatolcsiEtAl2025]` row says "see `[DuczVarga2026]`". A G50 instance (a held,
read paper that bears, not consulted), for the close. **What this changes:** the flattering outcome of the brief cannot be "a refutation of a
published conjecture" — that has been done. The live question becomes whether the per-class chain gives something *beyond* Dúcz–Varga:
a quantitative bound, or their own Conjecture 1.

### 1.2 The controls of question 4, with what a wrong-reason "per class" would look like

The per-class claim under test (the brief's, in my words): *given MR(F), every translation- (and rotation-) invariant random independent set
of `F²` has density at most the best local ratio of `F`*. Each control is a field where a per-class argument **must not** conclude a density
bound below the truth.

| control | the truth, independently | what a correct per-class argument must say there | where a wrong one would show |
|---|---|---|---|
| **CTL-K**: `K = ℚ(√3,√11)` | `χ_f(K²) = 4` (G60; lower bound `[MatolcsiEtAl2025]`'s G27 blown up inside `K²`, upper the dyadic residue colouring); `[Ducz2026]`: "the entire Moser lattice is geometrically integer 4-colorable". So the finitary ratio `α₁(K²) = 1/4`, and there **is** an invariant random independent set of density exactly `1/4` (a residue class at a dyadic place, pulled back with a random translate) | its bound must be **exactly `1/4`**, carried by the two stable dyadic places (inert in `K(i)/K`, target `𝔽₄` with the norm-one group `μ₃`, i.e. `K₄`, tight at `1/4` at every level — row 67) | a bound `< 1/4` at `K`: it would mean the argument treated a tight dyadic place as removable (thick). At density `δ = 1/4` the thickness threshold must be `λ* < δ/(1−δ) = 1/3`, and `K₄`'s `λ* = 1/3` exactly — **the boundary**, so a correct argument keeps the dyadic places, and a wrong one would use a non-strict threshold |
| **CTL-11**: ℚ(√11) | `χ(ℚ(√11)²) = 4`; the stable place above 7 has target `Γ₇`, `α(Γ₇)/49 = 2/7`, and every finite subgraph maps to it, so `α₁(ℚ(√11)²) ≥ 2/7` | bound exactly `2/7` (the place at 7 is not thick at `δ = 2/7`: `λ*(Γ₇) = 0.5617 > (2/7)/(5/7) = 0.4`) | a bound below `2/7` |
| **CTL-√3**: ℚ(√3) and ℚ(√7) | three-chromatic, a stable place with residue field `𝔽₃` of ratio `1/3` (G38; row 99) | bound `1/3` | below `1/3` |
| **CTL-EXC**: ℚ(√5) (row 100's exception) | bipartite; a ramified stable dyadic place, ratio `1/2` | the argument is **out of scope** (MR is not claimed there, row 120); if run anyway its dyadic factor has Hoffman ratio `1/2` | any claim below `1/2`, or any claim at all that uses MR there |
| **CTL-ℤ[√2]** (arithmetic-free analogue of the planner's CTL-ABS): `Λ = ℤ + ℤ√2 ⊂ ℝ`, connection set `{±1, ±√2}` | finite subgraphs are subgraphs of the grid `ℤ²`, bipartite, so the finitary ratio is `1/2`; a measurable set of `ℝ` avoiding `{1, √2}` has density `< 1/2` (density `1/2` forces `A + 1 = A^c = A + √2` a.e., so `A` is invariant under the irrational `√2 − 1`, so null or conull) | the gap between finitary (`1/2`) and measurable (`< 1/2`) must be carried by a **torsion character** — here the parity `a + b√2 ↦ a + b (mod 2)`, a "place" of ratio `1/2`. The analogue of the chain gives `max(measurable, torsion) = 1/2`, the truth. (There is no rotation group here, so no MR analogue; this controls the arithmetic of the bound, not branch (B)) | a claim "finitary = measurable" in a group whose torsion quotients beat the measurable ratio |
| **CTL-DV** (a published positive result the conclusion must be consistent with) | `[DuczVarga2026]`: `α₁(ℝ²) < 1/4`, `χ_f(ℝ²) > 4` | any per-class conclusion `α₁(ℝ²) ≤ ρ` must have `ρ ≥ m₁(ℝ²) ≥ 0.22936` (Croft) and is consistent with `α₁ < 1/4` | a conclusion `α₁(ℝ²) < m₁(ℝ²)` (impossible: `m₁ ≤ α₁` by averaging translates of a periodic set) |

**Wrong-reason lines** (a pass for the wrong reason would look like this):
- **WR-1 (a hidden second class).** A "per-class" step that selects `min M(x)` or any choice from a support *because every point has some
  colour*. Per class the object must be the support set `J = {x : P(x ∈ I | 𝒜) > 0}`, and `J ⊇ I` must come from `P(x ∈ I, p(x) = 0) = 0`,
  not from a pigeonhole over colours.
- **WR-2 (the count).** Any use of `Σ_j δ_j = 1`, or of "four classes", or of `1/k` as a threshold.
- **WR-3 (the real place).** Using Hoffman's `0.2871` for `UD(ℝ²)` (too weak to matter), or using `m₁` on a set that is not shown measurable.
  `m₁` bounds measurable sets (Q5); the argument must produce a measurable version first.
- **WR-4 (Følner backwards).** Claiming `α₁(F²) ≥ α_inv(F²)`: the true direction is `α₁(F²) ≤ α_inv(F²)` (invariant sets are built from
  finite ones), and the conclusion needs exactly that direction.
- **WR-5 (MR on the wrong measure).** Applying MR to the spectral measure of a merely translation-invariant set: MR needs `U`-invariance, so
  the random set must be `R ⋊ U`-invariant (J45 SP-Cor's first lines; BC's L2, note 2).
- **WR-6 (level one).** Using a level-one ratio where the all-levels ratio is needed (e.g. 43's `0.1974` at level one against Hoffman's
  `0.21376` at every level): the per-class count reads the full-depth compact planes.
- **WR-7 (a thick place read non-strictly).** At density `δ`, a place may be dropped only when `λ*_v < δ/(1−δ)` strictly; CTL-K sits on the
  boundary.

### 1.3 Would-have-searched-here log (stage 1)

- None: reading and quotation only.
