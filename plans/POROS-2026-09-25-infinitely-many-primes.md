*Poros record, crunch job **J36**, 2026-09-25. Advisor session on one finding: T-C and T-C(A) of the milestone "row 88's
question" (`plans/FS86-row88-rigidity.md` §S.1). Brief: `data/crunch-2026-09-25/briefs/J36-poros-infinitely-many-primes.md`, with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it. Opus 5.5. No subagents; no finite-witness search (ban to
2026-10-01); this record is the only file I edit.*

**Inputs added after the brief was written** (from the owner, verbatim in substance, logged here so a successor has them):
1. FS-84 S1's blind check has finished (`plans/FS84-S1V-verification.md`): a second derivation, not using the Ambrus et al.
   certificate, confirms the periodic independence ratio of ℚ(√47) is at most 0.2499972548 < 1/4, binding at 31; which prime attains
   the supremum (11 or 31) is undecided; the amenability hypothesis is load-bearing; one GAP — whether Θ₄ = ∅ on a finitely generated
   unit-distance lattice says anything about four-colourability. **S1 is two derivations at those scopes.**
2. Three later Poros sessions (J37–J39) will assemble "wanted posters" for counterexamples (four colours over ℚ(√47), four-colour
   rigidity over ℚ(√59), five colours over ℚ(√167)). They read this record. I answer my question and do not do theirs.
3. Kooshi's observation, relayed by the coordinator as one more question: *"walls often show up as 'the (impossible?) counter-example
   invariant' and we have had a successful breakthrough when looking for the 'example invariant'."* Asked: what example invariant
   this finding is the shadow of; whether T-A's or T-C's structural form already names it; whether looking for it is a better next
   question than the remainder T-C′. (Answered in its own stage.)

## Stage 1 — SAVED: the expectation, written before reading the two derivations

*Written from `CLAUDE.md` (loaded: Frontier items 10–25, G43, G48, G54, G55, G59, G60, G64, G74–G76) and the brief only. Neither
derivation, nor the verification, nor S1, nor the PA-close has been opened yet. Everything below is a hunch with basis* prior *or*
analogy *until the later stages score it.*

**E1. What "reads infinitely many primes" should mean.** The unit-vector ring `R = ℤ[U_F]` is a ring of S-integers of `F(i)` with
`S` infinite (every rational prime all of whose places split in `F(i)/F` is inverted; `[Fischer1990b]`, G55). Its Pontryagin dual `R̂`
is an adelic solenoid, `(ℂ × Π'_{v split} F(i)_v × Π_{v non-split} O_v) / R`, a restricted product. A character is a product of local
characters; `A` is the image of the archimedean factor, `Fin_S` the image of `Π_{v∈S} F(i)_v` for finite `S`. So `T + A + Fin_S` is a
Haar-null, σ-compact, dense subgroup: the characters that extend continuously to a *locally compact* group `ℂ × Π_{v∈S}`. A spectral
measure "carried by `T + A + Fin_S`" means the colouring's autocorrelation `ρ(r) = E⟨g(c(x)), g(c(x+r))⟩` extends continuously to
that locally compact group (plus a periodic part). "Reads infinitely many primes" = the autocorrelation is continuous for no finite
set of places. **Scope to check:** "for some finite `S`" is stronger than "carried by the union over `S`" — a measure can live on
`∪_S Fin_S` with no single `S` carrying it. I expect T-C(A) to be the single-`S` form, so "reads infinitely many primes" in the brief's
headline may overstate it: a four-colouring could read finitely many primes *per frequency* and infinitely many in total.

**E2. Deep or artefact?** I expect **mostly an artefact of the class chosen**, in this precise sense: the class `T + A + Fin_S` is
exactly the class on which local certificates can be applied, and I expect the proof to be **a product rule over finitely many
places** — strong approximation for the norm-one torus makes the diagonal image of `U` dense in the product of the local unit
circles, so the unit-distance graph on `ℂ × Π_{v∈S}` is a *categorical product* of local planes, and then `[Zhang2012]`'s theorems
(independence ratio of a product of vertex-transitive graphs = the max of the factors'; maximum independent sets pulled back from the
strict-max factor) do the rest. That gives: T-C(A) = "every local ratio is < 1/4" (S1 at the compact places, 31 binding, which G54
records as the Hoffman bound `1/4 − 2.745·10⁻⁶`; the archimedean factor by `[AmbrusEtAl2023]`'s `m₁(ℝ²) ≤ 0.247`; the split places
to be seen); T-C = Zhang's MIS-normal half at the tight dyadic place (row 88's route). If so, the finding is the complement of a
finite-product theorem, and "infinitely many primes" names where the product rule stops, not a new phenomenon of colourings.

**E3. Where it should point.** Two places. **(a)** The question it leaves is a **local–global principle for the invariant
independence ratio** (equivalently the fractional chromatic number) of a field plane: is the Følner independence ratio of
`Cay(R, U)` equal to the supremum of its local ratios? If yes, T-C(A)'s remainder closes and `χ(ℚ(√47)²) ≥ 5` follows from S1 and
Ambrus et al. alone — which I rate unlikely to be *that* easy, so I expect the remainder to be hard, and the brief's "does it reach
five at ℚ(√167)" to be **no by a count I can make now**: the archimedean place permits five fractionally (`m₁(ℝ²) ≥ 0.229 > 1/5`;
`χ_f(ℝ²) ≤ 4.36`, G60), so no ratio/product argument can refuse a five-colouring whose statistics are archimedean. **Four is the only
colour count where the archimedean factor refuses fractionally** (`0.229 ≤ m₁ ≤ 0.247 < 1/4`), so I expect the phenomenon to be
**specific to four colours** and silent on six and seven. **(b)** Averaged over rotations (the semidirect product `R ⋊ U` is
amenable), the spectral measure becomes a `U`-invariant measure on the solenoid, and `U` is a free abelian group of infinite rank
acting by automorphisms — Berend's setting, which rows 95–97 used for *closed sets*. The measure version is Rudolph–Johnson /
Einsiedler–Lindenstrauss for positive entropy and **Furstenberg's ×2×3 conjecture for zero entropy**. So I expect the remainder
T-C′ to split: a positive-entropy part that measure rigidity handles (and that is uncorrelated, hence "dead weight" for the
unit-distance constraint) and a zero-entropy part that is ×2×3 in disguise and open.

**E4. What should kill it cheaply.** (i) The single-`S` versus union scope (E1). (ii) A shared input: both derivations resting on one
product-rule step (Zhang for locally compact, non-discrete factors is not Zhang's theorem, which is for finite graphs) or one
archimedean certificate. (iii) The split places: their unit circle is non-compact (`F_v^×`), so "the local ratio at a split place"
needs its own statement — I expect either a Følner-mean argument or an assumption. (iv) Whether "carried by `T + A + Fin_S`" means the
*spectral measure of the one function `g∘c(0)`* or of the whole process (a 2-point statement versus a factor statement): a 2-point
hypothesis cannot license a use of Ambrus et al.'s certificate unless the correlation extends continuously to ℂ, which is what the
`A`-part gives — I will check that step.

**E5. Kooshi's example invariant (hunch, before reading).** The counterexample invariant is "reads infinitely many primes". Its
example-invariant shadow should be a property every *known* four-colouring carries that forbids that: **finite local support of the
autocorrelation** — every four-colouring we can exhibit (Theorem B's residue colourings, the dyadic pullbacks over type-(B) fields,
Fischer's ℤ/4 colouring) has autocorrelation continuous for one dyadic place. The candidate example invariant is then a
*finite-support law*: "every four-colouring's autocorrelation is continuous for a finite set of places", or, sharper, "every
four-colouring is local at a tight place" — which is G76's locality, so T-C's structural form may already name it.

## Stage 2 — SAVED: quotation check and the evidence inventory (read against Stage 1's expectations)

### 2.1 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | T-C, "Over a type-(B) field, every translation-invariant Borel probability measure … is carried by Pull." | `plans/FS86-row88-rigidity.md` §S.1 | **verbatim** (the brief omits the plan's trailing parenthetical on `Fin_S`, which is outside the quoted statement) |
| Q2 | T-C(A), "Over ℚ(√47), no translation-invariant … carried by no `T + A + Fin_S`." | same | **verbatim** |
| Q3 | "The derivation (J28D) states it for the whole class S2." | `plans/FS86-R88-D-derivation.md` l.14, §3.2 "Class (TC-class)" | agrees |
| Q4 | CLG (not in quotation marks in the brief): "a band `k`-character exists iff one exists at a single stable place … never 'every character colouring is local'" | `plans/FS91-S1D-character.md` §3.1, verbatim there: "`Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`" | agrees in substance, existence scope confirmed; **note:** §3.1 and §3.3 of that record carry "Correction owed" banners (`plans/FS91-S1V-character.md` §2.3, §3.1 item 19) which I did not read |
| Q5 | S1: "periodic independence ratio below 1/4 by a margin of about 3·10⁻⁶ at the prime 31" | `plans/FS84-S1-derivation.md` S1a: `h*(31) = 0.2499972548…`, margin `2.745·10⁻⁶` | agrees |
| Q6 | the owner's update on S1V (bound, 11 or 31 undecided, amenability load-bearing, one GAP) | `plans/FS84-S1V-verification.md` S1V-4, V1, S1V-5, V3 (ii) | agrees |

### 2.2 Evidence inventory

- `plans/FS86-row88-rigidity.md` §0, §PA, §IQ, §S, §P, §M, the plan — read against: E1's single-`S` scope, E2's product rule — surprised: no (§M.1 item 5 fixes a single `S` because "a union over all finite `S` has no single completion"; §IQ item 2 already says that at type (A) the measure form **is** the chromatic question)
- `plans/FS86-R88-D-derivation.md` §3 and §5, J28D's proof of T-C and T-C(A) — read against: E2 (strong approximation plus a Zhang-type product count) and E4 (iv) (a 2-point hypothesis cannot license a use of Ambrus et al.) — surprised: yes, on E4 (iv). The hypothesis is 2-point, but C1–C2 turn it into **continuity in probability**, which extends the *whole process* to `G_S`; after that the argument is about genuine Borel colourings, so higher-order facts (`m₁ ≤ 0.2470`) apply legitimately. E2 confirmed: the count is "the stationary Zhang count" (C5), stable places absorbed by Hoffman, split places at ratio 0
- J28D §5.1, T-C′ — read against: E3 (b), an entropy split — surprised: yes, at one sentence: "the spectral measure of a merely translation-invariant `μ` is not `U`-invariant; those theorems see only `U`-averages, which can carry mass onto Pull". **Pull is empty at type (A)**, so this objection does not apply to ℚ(√47) (Stage 3, F4)
- `plans/FS86-R88-V-verification.md` §2.1–§2.2, J28V's blind derivations — read against: an independent route — surprised: partly. Same architecture (extension, regularisation, count), independent regularisation (C3) and tail factor (C4); shared inputs: `[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470`, Coxeter's window lemmas C14.1/C14.3, FS-66 at 11 and 19. Its C0 remark ("any proof of T-C must use more of the colouring than its pair correlations", from FS86-dB-C0's archimedean positive-definite function) is the fact Stage 3's F5 turns into an equivalence. J28V's §Stage 5 (the independence discussion) was sampled only through its headings: **unread in full**
- `plans/FS86-row88-PA-close.md` stages 3–4 and §6.6–6.7, J35's gate — read against: "not found in print" — surprised: no. Useful names: "translation-invariant strict vector 4-colouring" (Karger–Motwani–Sudan), "continuous in probability for the `S`-adic topology", Bardestani–Mallahi-Karai's hyperbola computation (the split places), Bachoc–DeCorte–Oliveira–Vallentin (measurable Hoffman). I do not duplicate it
- `plans/FS84-S1-derivation.md` §2.2–§2.3, S1's invariant-measure section — read against: an invariant-measure form of four-colourability and a price for the single-class route — **surprised: yes.** §2.3 item 3 prices the route "`ι(ℚ(√47)) < 1/4`" as "exactly as hard as" refuting `[MatolcsiEtAl2025]`'s conjecture `α₁(ℝ²) = 1/4`. That conjecture was **already refuted** in the plane by `[DuczVarga2026]` (a 29-vertex unit-distance graph with independence ratio below 1/4; `BIBLIOGRAPHY.md` l.182, "read in full (2026-09-16)"). A `grep` finds no mention of it in S1, S1V, J28D, J28V or J35. Correction owed (Stage 4)
- `plans/FS84-S1V-verification.md`, the theorem table — read against: the owner's summary — surprised: no
- `plans/FS91-S1D-character.md` §3.1, §3.3, CLG and CLG-g — read against: an existence-only statement — surprised: no; CLG-g (g1) gives no exception at `k ≤ 5`. `plans/FS91-PA-close.md` ll.85–125 (M1's gate: Manners's pyjama lemma, Wang 2012, Einsiedler–Lindenstrauss 2022) — read against: nothing held on *measure* rigidity at zero entropy — surprised: no
- `plans/M3-S1D-windows-five.md` §3.2–§3.4 (J21-MX, J21-RED) — read against: a deletion lemma for compact factors — **unread** (used only through the plan's and J28D's quotations; J28D records it did not use J21-MX)
- `plans/STUB-adelic-window-colouring.md` (FS-64) — read against: a window over finitely many places — **unread in full** (used through `CLAUDE.md`'s table row 11)
- the dog that did not bark: no record tests whether "carried by no `T + A + Fin_S`" is *hard to achieve* anywhere colourings exist — read against: a control field — surprised: yes, and it is Stage 3's F2

### 2.3 Would-have-searched-here log

- Would have searched for a `U`-invariant measure on the adelic solenoid with negative mean at 1. Instead derived that one exists iff a non-Haar invariant measure exists (Stage 3, F5).
- Would have searched ℚ(√11) for a four-colouring whose spectrum is off every `T + A + Fin_S`. Instead wrote one down by formula (F2).
- Would have searched a finite `H ⊂ ℚ(√47)²` with `α(H) < |H|/4` (the fractional route). Not run; its price is corrected in Stage 4.
- Would have run a `Θ₄` tree and a colouring finder for a four-colourable unit-distance lattice with `Θ₄ = ∅` (EI-1's falsifier, Stage 4). Not run (ban); posed.
- **One exact check of seconds** (the ban's edge; a derivation fixed the set): the band-`k` characters of `Γ₇` at level one, all 48 non-zero characters (`tools/crunch_j36_band7.py` → `data/crunch-2026-09-25/j36/band7.out`): 0 at `k = 3`, **8 at `k = 4`**, 8 at `k = 5`. The plant (`PLANT=1`, the band replaced by `[0, 1)`) fires: 48 at every `k`, exit 1. Use: `Γ₇` does not falsify EI-1 (Stage 4).

## Stage 3 — SAVED: the examination (F1–F8)

*Everything here is advice: constructions in the hypothetical mood, each graded. Arguments marked "[hand, one mind, sketch]" are mine,
written to be re-derived by the domain's own standard (a derivation job and a blind check), never to be cited as proved. Notation as in
the plan's §S.0: `R = ℤ[U]`, `σ` the trace spectral measure of the tetrahedral embedding `g`, `E_S = T + A + Fin_S`, and `E = ⋃_S E_S`
over finite sets `S` of split places.*

### F1. What it is, in its discipline's words

**T-C(A) says: no translation-invariant random proper four-colouring of ℚ(√47)'s unit-distance graph is continuous in probability for
the topology of any locally compact completion of `R`.** The completions in question are `G_S = (L ⊗ ℝ) × ∏_{stable} O_v × ∏_{v∈S} L_v`.
Equivalently: the stationary (Borel) independence ratio of each `G_S` is `< 1/4`, a fractional statement (J35's words, the PA-close stage 4).
Against the brief's three candidate names:
- **Not the Kronecker factor.** Discrete spectrum may read infinitely many places harmlessly: a character colouring whose characters
  each read one split place lives on a compact infinite product, and `T + A + Fin_S` already reads *all* stable places, infinitely many,
  because their product is compact. The finding is about **split** places only.
- **Not zero entropy.** J28D §5.1 finds no entropy mechanism in the hypothesis, and I find none either.
- **Local compactness, yes.** The finite sets `S` are exactly the ones for which `R` has a locally compact completion that is not
  discrete. With every split place kept, `R` is a lattice of `S`-integers, discrete in its own restricted product. Then "continuous"
  means nothing, and there is no Haar measure to run Fubini with (J28D §5.1, R1).

So "reads infinitely many primes" means, precisely, **"is not stochastically continuous for any locally compact completion"**.

### F2. The cheapest kill test: "carried by no `T + A + Fin_S`" is cheap wherever gapped colourings exist [hand, one mind; a construction]

Over ℚ(√11) the stable place above 7 has residue plane `Γ₇`, slack at four colours with gapped four-colourings (G54; row 94's field).
Take such a colouring `γ` of `Γ₇` and an independent set `Z̄ ⊂ Γ₇` of gapped vertices, with `g(z̄)` the missing colour at `z̄`. Let
`Z = {z ∈ R : z mod 𝔓₇ ∈ Z̄}`, and let `ω` be i.i.d. fair bits on `R`. Put `c_ω(z) = g(z̄)` if `z ∈ Z` and `ω(z) = 1`, and `γ(z̄)`
otherwise.
- **It is proper.** No edge joins two points of `Z`, because `Z̄` is independent and every unit vector is non-zero mod `𝔓₇`. A recoloured
  point takes the one colour missing from its neighbourhood.
- **It is translation-invariant** once `γ ∘ ρ₇` is averaged over its finite translation orbit.
- **Its spectral measure charges the infinite-type characters.** The i.i.d. part contributes a component equivalent to Haar measure on
  `R̂`, and Haar measure gives `E` measure 0: each `E_S` is a σ-compact proper dense subgroup, so it is Haar-null by Steinhaus.

So the *literal* counterexample invariant — a spectral measure carried by no `T + A + Fin_S` — is realised by **noise on a finite-place
colouring**, at any field with a gap. What T-C(A) really excludes at ℚ(√47) is something else. In this example the noise carries **no
unit-distance correlation**, and the finite-place colouring `γ ∘ ρ₇` survives as a **factor**: it can be read off `c_ω` by ergodic
averages over residue classes. F3 shows that this is the whole content.

### F3. The support identity, and T-C(A) and T-C sharpened [hand, one mind, sketch — for a derivation job]

**Lemma SI.** Let `μ` be a translation-invariant random proper four-colouring, and `E′` a Borel subgroup of `R̂` of the form `E_S`. Write
`𝒜` for the factor σ-algebra of the `τ_S`-continuous vectors. (Bounded continuous vectors are closed under products and truncation, so
the continuous vectors are `L²(𝒜)`, and they are exactly the vectors whose spectral measure is carried by `E_S` — J28D's C1.) Put
`p_j(x) = P(c(x) = j | 𝒜)` and `h(x) = E[g(x) | 𝒜] = Σ_j p_j(x) e_j`.

1. For tetrahedral vectors, `⟨Σ p_i e_i, Σ q_j e_j⟩ = (4/3)Σ_i p_i q_i − 1/3 ≥ −1/3`, with equality iff the supports of `p` and `q` are
   disjoint.
2. The spectral projections commute with the translations, so for every `u ∈ U`:
   `−1/3 = E⟨g(0), g(u)⟩ = E⟨h(0), h(u)⟩ + ∫_{R̂∖E_S} χ(u) dσ(χ)`.
3. Hence **`∫_{R̂∖E_S} Re χ(u) dσ ≤ 0` for every `u`**.
4. **If it is 0 for every `u`**, the supports of `p(x)` and `p(x+u)` are a.s. disjoint on every edge. Then `c′(x) = min supp p(x)` is an
   `𝒜`-measurable, translation-equivariant proper four-colouring with spectral measure on `E_S`, and `c(x) ∈ supp p(x)` a.s.

**T-C(A)⁺ (sharpened, no rotation averaging).** Given T-C(A): over ℚ(√47), for every translation-invariant `μ` on `X₄(F)` and every finite
`S`, some `u ∈ U` has `∫_{R̂∖E_S} Re χ(u) dσ_μ(χ) < 0`. The part of a four-colouring's spectrum that no finite set of places reads must
itself be **anticorrelated at unit distance**. Having mass there is not enough (F2).

**T-C⁺ (sharpened, type (B)).** Given T-C: over a type-(B) field, every translation-invariant `μ` with `∫_{R̂∖E_S} Re χ(u) dσ_μ ≥ 0` for
every `u` (some finite `S`) is carried by Pull.
- *Sketch.* SI (4) gives two `𝒜`-measurable selections, `min supp` and `max supp`. Both are proper colourings with spectrum on `E_S`, so
  both are pullbacks by T-C: `γ ∘ ρ₄` and `γ′ ∘ ρ₄`.
- Where they differ at `x`, the neighbours `x + u` must avoid `γ′(x̄)` under `γ`. But `γ` is gap-free (the tight `P₄`, D2-A), and `U` maps
  onto `S₄`, so some neighbour takes that colour.
- Hence the supports are a.s. singletons, `c = c′`, and `c` is a pullback.

T-C⁺ is strictly wider than T-C: it admits mass off `E_S`, provided that mass is not anticorrelated at unit distance.

### F4. At type (A) the rotations may be averaged, and then the headline becomes literal [hand, one mind, sketch]

J28D §5.1's objection to averaging over `U` — a weak-* limit can carry mass onto Pull — is **specific to type (B)**. At ℚ(√47), Pull is
empty. Suppose `X₄ ≠ ∅`. Then `X₄` is compact and invariant under the amenable group `R ⋊ U`, so it carries an `R ⋊ U`-invariant `μ`, and
`σ_μ` is `U`-invariant, because a rotation about 0 fixes `c(0)`.

**Lemma R-U (recurrence).** Every `U`-invariant finite measure on `R̂` gives `E_S ∖ (T + A)` measure 0, for every finite `S`.
- The image of `Ĝ_S` is a Borel copy of `Ĝ_S`, `U`-equivariantly (Lusin–Souslin).
- At a split place `v ∈ S`, take `u = z/z̄` with `(z) = 𝔓_v^h`, where `h` is the class number. Then `u` acts on `L̂_v ≅ F_w²` as
  `(ξ₁, ξ₂) ↦ (tξ₁, ξ₂/t)` with `|t| ≠ 1`. That action is wandering off 0, so every finite invariant measure there is a point mass at 0.

**Consequences at ℚ(√47).**
- **R1 is empty for rotation-averaged measures.** R1 is J28D's case "carried by `E` but by no single `E_S`"; by R-U such a measure is
  carried by `T + A`.
- **The headline becomes literal.** A four-colouring of ℚ(√47)'s plane, if one exists, has an `R ⋊ U`-invariant measure on its
  `R ⋊ U`-orbit closure whose `U`-invariant spectral measure satisfies `∫_{R̂∖E} Re χ(1) dσ < 0`. Every character in `R̂ ∖ E` has
  non-trivial components at infinitely many split places.
- **Fewer inputs.** The chain uses T-C(A) **only at `S = ∅`**. So C14.2 (c), the split-place lemma (J21-D1-2 at `q = 2`, one mind), drops
  out of it.

### F5. The colouring-free remainder is Furstenberg's measure question, exactly, at the level of spectral measures [hand, one mind, sketch]

Define **SP** (the sign problem): *is there a `U`-invariant finite positive measure `τ` on `R̂` with `τ(E) = 0` and
`∫ Re χ(1) dτ(χ) < 0`?* By F3–F4, a "no" proves `χ(ℚ(√47)²) ≥ 5` from T-C(A) at `S = ∅`. **Claim: SP has answer "no" if and only if every
`U`-invariant finite measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure.** The sketch:
- ⟸: Haar measure has `τ̂(1) = 0`.
- ⟹, step 1. A non-Haar `τ` off `E` has `τ̂(r₀) ≠ 0` for some `r₀ ≠ 0`, and the value is real because `−1 ∈ U`.
- ⟹, step 2. The push-forward by the dual of `x ↦ r₀x` is again `U`-invariant, again off `E`, and has coefficient `τ̂(r₀)` at 1. It stays
  off `E` because `r₀R` is `τ_S`-open in `R`, of finite index (J28V-7), so `r₀χ ∈ E_S` forces `χ ∈ E_S`.
- ⟹, step 3. If that coefficient is positive, convolve with the uniform measure on an archimedean circle whose `J₀`-value is negative (`U`
  acts there by rotations). The result is `U`-invariant, off `E` (because `A + (R̂ ∖ E) ⊆ R̂ ∖ E`), and has a negative mean at 1.

What this means:
- **At type (A), T-C′'s colouring-free form is the zero-entropy Furstenberg-type rigidity problem for `U` acting on `R̂`, modulo `E`.** It
  is not a weaker "sign" version of it.
- The positive-entropy half should be algebraic by Einsiedler–Lindenstrauss-type measure rigidity (recalled, not read). Algebraic measures
  off `E` are Haar: a non-zero `ℤ[U′]`-submodule of `R` has finite index, so its annihilator is torsion.
- The zero-entropy half is open, as for ×2×3.
- **So no route through the spectral measure alone can close the remainder without solving a Furstenberg-type conjecture.** This is J28V's
  C0 remark ("any proof of T-C must use more of the colouring than its pair correlations") promoted from T-C to the remainder.

### F6. One theorem behind several results — a finite-place product principle [reading]

CLG, row 92, J21-RED, T-C and T-C(A) are one statement read on four kinds of object:

> For a colouring of `F²` that factors through a locally compact completion `G_S` (all stable places, the archimedean places, finitely
> many split places), the connection set is the full product of local circles, by weak approximation. So the colour-class densities
> obey **the maximum of the local ratios** (Zhang's rule, made stationary), and at a strict tight maximum the colouring is **pulled back**
> from that one place.

The four kinds of object:
- CLG: points, i.e. characters. There the closed-set form is band rigidity (Manners's pyjama lemma, M1's gate).
- Row 92: deterministic Borel windows.
- J21-RED: windows at five colours.
- T-C and T-C(A): stationary processes, through continuity in probability.

**The infinite-place remainder, at the single-class level,** is the gap between the finite-place stationary ratio `max_v r_v` and the
full invariant ratio `ι(F²) = 1/χ_f(F²)` (S1b-iii). This is the arithmetic analogue of the plane's gap between `m₁(ℝ²)` and `α₁(ℝ²)`.
`[MatolcsiEtAl2025]` conjectured the two differ (`δ_Croft = m₁`, `α₁ = 1/4`); `[DuczVarga2026]` moved `α₁` below 1/4. *Killing test:*
a field where `ι(F²) > max_v r_v` is proved, i.e. the fractional chromatic number is strictly below every local one.

### F7. Five at ℚ(√167), six and seven: silent, by one count [derived]

- **The count.** T-C(A)'s count needs every factor of `G_S` below `1/k`. The archimedean factor has `m₁(ℝ²) ≥ 0.2293` (Croft's
  construction), which exceeds 1/5, 1/6 and 1/7. **Four is the only colour count at which the real place refuses fractionally**
  (`0.2293 ≤ m₁ ≤ 0.2470 < 1/4`), so the phenomenon is four-colour-specific.
- **Five at ℚ(√167).** FS-66's certificate at 23 (`97/529 = 0.1834 < 1/5`) removes the 23 factor but not the real places. A five-colouring
  with finite-place spectrum reduces at best to a Borel five-colouring of the archimedean factor times the undeletable places. For a real
  quadratic field that factor is the categorical product of two copies of the plane's unit-distance graph. Its Borel five-colourability
  is at least as open as the measurable chromatic number of the plane (Falconer's `≥ 5`; `≤ 7`). **So no: the method does not say that a
  five-colouring of ℚ(√167)'s plane must read infinitely many primes.**
- **FS-64.** Its window colouring reads finitely many places, so it lies inside T-C(A)'s class.
  - At four colours, T-C(A)'s class form excludes it at ℚ(√47). It does so at every field all of whose stable places are below 1/4, which
    probably includes ℚ(√167) (not checked).
  - At five colours over ℚ(√167), nothing here touches it. It stays the one instrument aimed at that gap.
- **Six and seven (G64).**
  - At seven, the class is **non-empty for every field**: the hexagonal seven-colouring pulled back along one real place is a
    finite-place colouring with spectrum in `A`.
  - At six, finite-place six-colourings of `F²` are governed by Borel six-colourings of the archimedean factor times the undeletable
    places. So *in the finite-place class, six hides in the measurable chromatic number of products of real planes* [reading]. That is a
    sharper address than G64's "the gap between `L(F)` and `χ(F²)`", and it is silent on colourings that are not finite-place.

### F8. What would make the finding weaker than it reads

1. **Scope.**
   - The literal counterexample invariant (mass off every `E_S`) is cheap (F2).
   - The headline's "at once" is true only in the rotation-averaged, type-(A) form (F4). At translation-invariant scope it is "no single
     finite `S`", which admits R1.
2. **Shared inputs.** Both derivations use the same external and one-mind pieces:
   - `[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470`. It is essential: J28D's mutation audit shows that Hoffman's 0.2871 at the real place flips the
     count.
   - Coxeter's C14.1 and C14.3 (two derivations, per J28D).
   - FS-66 at 11 and 19.
   - A single defect in the stationary product count would sink both, since both use one architecture: extension, regularisation, count.
   - Independent: the regularisations (J28D's TC-reg against J28V's C3) and the tail factor.
3. **The "11 or 31" GAP (S1V)** does not touch T-C(A): its count needs only that every factor is below 1/4.
4. **A stale price nearby** (S1 §2.3 item 3; the DuczVarga point, Stage 2). It does not weaken T-C(A). It does change what the
   single-class route costs (Stage 4, R4).

## Stage 4 — SAVED: Kooshi's example invariant, the card, the recommendation, the ledgers

### 4.1 Kooshi's question: the example invariant this finding is the shadow of

**(a) The example invariant.** Call it **EI-2: every translation-invariant four-colouring has a factor that is itself a proper
four-colouring and is continuous in probability at finitely many places.**
- **Every four-colouring we can prove exists carries it, trivially:**
  - residue pullbacks and `[Fischer1994]`'s ℤ/4 colouring (spectrum in `T`);
  - ℚ(√11)'s character colouring C9 (spectrum in `T + A`);
  - row 92's windows (spectrum in `E_S`);
  - F2's noisy colourings, whose finite-place colouring survives as a factor.
- **The shadow relation is exact.** By Lemma SI (F3), EI-2 holds for a colouring iff the part of its spectrum that no finite set of places
  reads is not anticorrelated at unit distance. So T-C(A)⁺'s counterexample invariant is precisely EI-2's failure.
- **What it would give.** EI-2 plus T-C(A) gives `χ(ℚ(√47)²) = 5`. EI-2 plus T-C⁺ gives Q-μ over the type-(B) fields.
- **A caution that applies to every example invariant.** Restricted to ℚ(√47), where no example exists, EI-2 is equivalent to the goal
  itself. Its value, like the three-colour slope's, lies in proving it **as a general statement where four-colourings exist**: ℚ(√11),
  `K`, the type-(B) fields, ℚ(√23). Only then is it applied at ℚ(√47).

**The other candidate, EI-1 — the four-colour slope.** *Every four-colourable finitely generated unit-distance lattice has `Θ₄ ≠ ∅`.* This
is S1V's GAP. With row 96 (`Θ₄(R) = ∅`) and S1V-6's compactness, it too gives five at ℚ(√47). Restricted to ℚ(√47)'s chain it is again
equivalent to the goal, so it is useful only as a general theorem, the four-colour analogue of G71.
- It is false in the abstract class: `Cay(ℤ, ±{1,3,4,5})` (S1V-7).
- It is untested on unit-distance lattices.
- My exact check rules out the cheapest falsifier: `Γ₇`, the only four-colourable target of ℚ(√23), has 8 band-4 characters (Stage 2).
- The live falsifier sites are the inert dyadic towers `U_Q`, `Q ∈ {4, 8, 16, 32}`. They are four-colourable, and `U₄` has no band-4
  character at level one: the five units sum to 0, but five 1's do not sum to 0 mod 2. The other site is the loose lattices over ℚ(√3,√5).

**(b) Does T-A's or T-C's structural form already name it?** Half.
- §IQ item 3 names the **carrier**, the spectral type, but not the **property**: the sign of the infinite-type part at unit distance,
  equivalently a finite-place proper factor.
- F5 shows the carrier is one order too low. At the level of spectral measures, the property is exactly as hard as Furstenberg-type
  zero-entropy rigidity.
- So the structural form names an invariant that cannot finish the job alone.

**(c) Is looking for it a better next question than T-C′?** **Yes.**
- T-C′ as posed asks to classify the infinite-type spectral measures and to decide entropy. By F5, at type (A) that is the zero-entropy
  Furstenberg problem: a wall, not a week.
- EI-2 is a colouring statement. It can use more than pair correlations, as T-C already does through `m₁ < 1/4`. Its falsifier lives in
  fields where colourings are plentiful, so it can be tested.
- Confidence **high** that it is the better target. Confidence **medium-low** (about 0.4) that EI-2 is true over slack fields.
- One fact would change the ranking: a proof that the colouring constraint forces positive entropy on the infinite-type part. That would
  hand T-C′ to Einsiedler–Lindenstrauss-type theorems and make it the cheaper route.

### 4.2 The card

```markdown
question: which-remainder-next
  evidence: this record F5 (SP holds iff every U-invariant measure off E is Haar); F2 (noise on γ∘ρ₇ over ℚ(√11) puts spectrum off every E_S); F3 (T-C(A)⁺); `plans/FS86-R88-V-verification.md` §2.1 C0
  expected: T-C′ is a classification with a tractable positive-entropy half and a small zero-entropy residue
  ask: does every translation-invariant four-colouring, over every real field where one exists, have a proper factor colouring continuous at finitely many places?
  if yes: with T-C(A) it gives χ(ℚ(√47)²) = 5, and with T-C⁺ it gives Q-μ over the type-(B) fields; the proof must use more than the spectral measure
  if no: the witness over ℚ(√11) or another slack field is the counterexample template; the ℚ(√47) wanted poster's first exhibit
  answered by: derivation
  cost: one derivation milestone, solver-free; its falsifier search waits for 2026-10-01
  hunch: true over fields with one tight place, open over slack ones
  falsifier: a translation-invariant four-colouring over ℚ(√11) whose part off every T + A + Fin_S is negatively correlated at some unit vector
  rank: 1
```

### 4.3 Recommendations (ranked, with the default)

| rank | recommendation | alternative weighed | why this one | confidence |
|---|---|---|---|---|
| R1 | Carry the finding into row 88's close **at its sharpened scope**. **(i)** The counterexample invariant is "the infinite-type part is anticorrelated at unit distance" (T-C(A)⁺), never "mass off every `T + A + Fin_S`" (F2: noise does that). **(ii)** J28D §5.1's rotation-averaging objection is type-(B)-only; at type (A) the headline is literal and uses T-C(A) only at `S = ∅` (F4). **(iii)** T-C′ at type (A), colouring-free, is exactly zero-entropy Furstenberg-type rigidity (F5); aim no week at it | record T-C(A) as J28D wrote it | the literal form reads deeper than it is (F2); the sharpened form is the content | medium: sketches, one mind |
| R2 | A small derivation job, **J36-D**, with a blind check, for SI, A⁺, B⁺, R-U and the SP equivalence (statement verbatim in 4.4) | fold it into J41, row 88's close-math | these are new theorems and need a second derivation; a close job is the wrong owner | medium-high that they are true; would change on a defect in SI's factor step |
| R3 | Re-aim the stub line from T-C′ to **EI-2** as a structural question over fields where four-colourings exist, falsifier named (card) | keep T-C′ as the named remainder | F5 makes T-C′ a Furstenberg wall; EI-2 is testable | high on the ranking; about 0.4 on EI-2's truth |
| R4 | Correction owed to `plans/FS84-S1-derivation.md` §2.3 item 3 and FS-84's P-int: `[DuczVarga2026]` already refuted `α₁(ℝ²) = 1/4`. So the single-class route at ℚ(√47) is "a Dúcz–Varga-type finite `H` inside ℚ(√47)²", a post-ban target of unknown cost, not "as hard as a published open conjecture". G60's cap there is `min(4.36, 121/28 ≈ 4.32, …) > 4`, so nothing caps it | leave S1's price | the price rests on a conjecture that is already dead | high on the fact (`BIBLIOGRAPHY.md` l.182); medium on the consequence |
| R5 | EI-1 (the four-colour slope): keep it as a general question on FS-76's line, not as a ℚ(√47) target; its falsifier (the dyadic `U_Q` towers, `Q = 4…32`) is an exact check | aim it at ℚ(√47) | there it is the goal restated | medium |

**If Kooshi does nothing:**
- the close records T-C and T-C(A) at J28D's scope, and T-C′ stays the named remainder;
- this record's sharpenings stay here, uncited;
- S1's price stays stale;
- the three wanted-poster sessions (J37–J39) read F2–F5 here.

### 4.4 J36-D, verbatim, ready for a brief

"Let `F` be a real number field, `R = ℤ[U_F]`, and let `σ_μ` be the trace spectral measure of the tetrahedral embedding of a
translation-invariant random proper four-colouring `μ` of `Cay(R, U_F)`. For a finite set `S` of split places let `E_S = T + A + Fin_S`,
and let `E = ⋃_S E_S`. Prove or refute:
**(SI)** `∫_{R̂∖E_S} Re χ(u) dσ_μ(χ) ≤ 0` for every `u ∈ U_F`, with equality for every `u` if and only if the `E_S`-factor of `μ` carries
a translation-equivariant proper four-colouring `c′` with `c(x) ∈ supp P(c(x) = · | E_S-factor)` almost surely;
**(A⁺)** over ℚ(√47), given T-C(A): for every `μ` and every finite `S`, some `u` gives strict inequality;
**(B⁺)** over a type-(B) field, given T-C: if equality holds for every `u`, then `μ` is carried by Pull;
**(R-U)** every `U_F`-invariant finite measure on `R̂` gives `E_S ∖ (T + A)` measure 0;
**(SP)** a `U_F`-invariant finite positive measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0` exists if and only if some
`U_F`-invariant finite measure on `R̂` with `τ(E) = 0` is not a multiple of Haar measure.
Control: F2's noisy colourings over ℚ(√11) must satisfy (SI) with equality."

### 4.5 Evidence inventory, re-read; the hunch ledger (Stage 1 scored)

- Stage 1's E1–E5, my own expectation — read against: Stages 2–3 — surprised: yes, on E4 (iv) and E5 (below)

hunch: the-product-rule-is-the-mechanism (E2)
  claim: T-C(A) is a finite product of local ratio bounds, joined by weak approximation and a Zhang-type count
  basis: prior
  falsifier: a proof of T-C(A) that uses no product count
  registered: 2026-09-25
  status: confirmed (by: `plans/FS86-R88-D-derivation.md` §3.2 C4–C5 and `plans/FS86-R88-V-verification.md` §2.1 C4–C5)

hunch: the-headline-overstates-the-scope (E1)
  claim: "must read infinitely many primes at once" is stronger than "carried by no single T + A + Fin_S"
  basis: read
  falsifier: T-C(A) proved for measures carried by the union over all finite S
  registered: 2026-09-25
  status: confirmed (by: `plans/FS86-rigidity` §M.1 item 5 and J28D §5.1 R1), at translation-invariant scope; at type (A) after rotation-averaging the headline becomes literal (F4)

hunch: the-phenomenon-is-four-colour-specific (E3a)
  claim: no ratio count can refuse k ≥ 5 colours whose statistics are archimedean
  basis: prior
  falsifier: a real place with measurable independence ratio below 1/5
  registered: 2026-09-25
  status: confirmed (by: derivation F7, Croft's m₁ ≥ 0.2293)

hunch: dead-weight
  claim: characters reading infinitely many split places carry no unit-distance correlation in any U-invariant spectral measure
  basis: analogy
  falsifier: a U-invariant measure off E with non-zero mean at 1
  registered: 2026-09-25
  status: killed (by: derivation F5 — any non-Haar invariant measure off E yields one, by a push-forward by an element of R and a convolution with an archimedean circle)

hunch: the-remainder-is-furstenberg (E3b)
  claim: at type (A), T-C′'s colouring-free form is zero-entropy measure rigidity for U acting on R̂ modulo E
  basis: derived
  falsifier: a defect in F5's push-forward or convolution step
  registered: 2026-09-25
  status: confirmed (by: derivation sketch F5, one mind; J36-D would make it two)

hunch: the-two-point-hypothesis-blocks-higher-order-inputs (E4 iv)
  claim: a spectral-measure hypothesis cannot license Ambrus et al.'s certificate
  basis: prior
  falsifier: an extension of the process from the spectral hypothesis
  registered: 2026-09-25
  status: killed (by: J28D C1–C2 and J28V C2 — continuity in probability extends the whole process)

hunch: the-example-invariant-is-tight-locality (E5)
  claim: the example invariant is G76's locality at a tight place
  basis: prior
  falsifier: four-colourings not local at one place, over a field where colourings exist
  registered: 2026-09-25
  status: killed (by: F2 and C9 over ℚ(√11), which has no tight place; the general form is EI-2, a finite-place factor)

hunch: EI-2
  claim: every translation-invariant four-colouring, over every real field, has a proper factor colouring continuous at finitely many places
  basis: prior
  falsifier: a translation-invariant four-colouring over ℚ(√11) whose part off every T + A + Fin_S is anticorrelated at some unit vector
  registered: 2026-09-25
  status: open

hunch: EI-1
  claim: every four-colourable finitely generated unit-distance lattice has a band-4 character
  basis: analogy
  falsifier: an inert dyadic tower U_Q (Q = 4 … 32) with no band-4 character at any level, or a four-colourable lattice with Θ₄ = ∅
  registered: 2026-09-25
  status: open (Γ₇ has 8 band-4 characters: `data/crunch-2026-09-25/j36/band7.out`)

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| J36-SI | for a stationary proper four-colouring, the part of `σ` off `E_S` has `∫ Re χ(u) ≤ 0` on `U`; equality everywhere iff the `E_S`-factor carries a proper colouring | [hand, one mind, sketch] | §F3 |
| J36-A⁺ | over ℚ(√47), given T-C(A), that part is strictly anticorrelated at some unit vector | [hand, one mind, sketch] | §F3 |
| J36-B⁺ | over type (B), given T-C, equality everywhere forces Pull (gap-freeness of `P₄`) | [hand, one mind, sketch] | §F3 |
| J36-RU | every `U`-invariant finite measure on `R̂` gives `E_S ∖ (T + A)` measure 0 | [hand, one mind, sketch] | §F4 |
| J36-SP | SP has a negative mean off `E` iff a non-Haar `U`-invariant measure off `E` exists | [hand, one mind, sketch] | §F5 |
| J36-noise | ℚ(√11)'s plane has translation-invariant four-colourings whose spectrum is carried by no `T + A + Fin_S` | [hand, one mind] | §F2 |
| J36-count | a ratio count cannot refuse `k ≥ 5` for finite-place colourings (`m₁(ℝ²) ≥ 0.2293 > 1/5`); at seven the class is non-empty for every field | [derived] | §F7 |
| J36-Γ₇ | `Γ₇` has 0 band-3, 8 band-4 and 8 band-5 characters at level one | [tools exact; plant fires] | Stage 2 |
