# POROS — FS-86 plan phase (advisor to the planner, de Bruijn)

*Record of the plan-phase Poros for FS-86, "four-colour rigidity over ℚ(√59) and ℚ(√83): does the tight dyadic `K₄` force pairs in a
triangle-free field?" Only writer: this Poros. Lives in scratch until the competition ends (protocol rule 1). Held routes are in
`HELD.md` beside this file, never here.*

## 0. Expectation, written before any exchange with the planner (2026-09-25)

### 0.1 What I expect to bear

- **Grokkings.** G54 (tight/slack, the middle case of row 87), G75 (what triangles did on de Grey's lattice), G55 (the chain
  theorem: a forced δ makes every colouring δR-periodic — I expect this to be marked "never chainable" only, and its *periodicity*
  half missed), G66 (`P = F_clopen`: periodic colourings are continuous colourings of the profinite completion), G43/G59 (products of
  targets; `[Zhang2012]` held and read in full, only its α-formula half ever used), G48 (colourings local at one place; FS-64/66/67's
  "when must a colouring of a product of local targets be local at one place"), G41 (Fischer's ℤ/4 colouring, local at 2 on the fields
  completing to ℚ₂(ζ₁₂) — ℚ(√59) is one), G68/G69 (gap ⟹ free; periodic = residue prime by prime), G71/G73 (no height at four colours;
  certificates averaged, non-local or structure-derived), G74/FS-83 (a Θ₄ point with non-zero archimedean part colours the whole plane),
  G57 (triangle-free), G21 (a null measures its enumeration — and an informative-looking outcome may be free), G72 (§IQ).
- **Rows.** 66 (gap ⟹ free, along homomorphisms), 67 (the 2-adic tower: tight at every level, forcing exactly 𝔓⁴ from level 5 —
  **I expect this to be the load-bearing row, and to be read as "over K" rather than as ℚ(√59)'s own tower**), 75 (all-levels
  certificates at 11, 19, 23), 78 (the Kempe/voltage layer, `forces_iff_exists_finite`), 82 (χ ≥ 4), 85–87.
- **Derivation theorems.** FS85-dB4 (Soifer calibration), FS85-C7/C8/R3a (where triangles and the tight quotient entered), FS85-L16 (the
  middle case), FS79-T2 (chainability needs a unit δ), FS38-D2-A/B (tight ⟹ gap-free, periodic under `H_min`), FS73-T36 (`F = ⋂ Per`).

### 0.2 Which disciplines own the object

"An abelian Cayley graph without triangles that maps onto a Hoffman-tight `K₄`, and the pairs every proper four-colouring identifies":
- **Graph products / homomorphisms:** uniquely colourable graphs, Greenwell–Lovász, *MIS-normal* direct products (Zhang 2011/2012,
  Larose–Tardif), projectivity; the identified pairs are the "forced" structure of the colouring space.
- **Algebraic graph theory:** Hoffman colourability (ratio-bound equality; Blokhuis–Brouwer–Haemers, Abiad et al.).
- **Symbolic dynamics:** hom-shifts; *frozen* configurations (Alon et al. 2021); an SFT all of whose points are periodic; Ellenberg's
  periodic-colouring question; the inheritance `P = F`.
- **Arithmetic:** the norm-one torus `T = R¹_{F(i)/F} 𝔾_m`, its weak approximation, local planes at stable places, local–global for
  colourings (Fischer, Moorhouse, Madore, Bardestani–Mallahi-Karai).
- **Unit-distance geometry:** Soifer's Open Problem 55.1 (triangle-free five-chromatic UDG), O'Donnell/Hochberg triangle-free lineage.

### 0.3 Does H5's analogy from K to ℚ(√59) survive G75 and row 87?

My reading before any exchange: **only half of it.** G75 says two things happened on de Grey's lattice: triangles pinned the spectrum
(periodicity), and the tight dyadic quotient killed what remained, pointwise. ℚ(√59) has the second ingredient and not the first. Row 87
(L16) removed H5's stated mechanism ("tight ⟹ forcing"): slackness permits gaps and does not supply one, and tightness of a *target*
transfers freeness, never forcing, to a source (row 67's own "transfer is freeness only"). So H5's conclusion can hold only where the
source's colourings are *already known to factor* through the tight target — i.e. for periodic colourings, where the quotient IS the
target. The missing ingredient is exactly the pinning (periodicity), which is the Soifer-strength part (dB4). I expect H5's analogy to
survive for `P` and to say nothing about `F`.

Also expected (checked since, §3): ℚ(√59)'s dyadic completion is ℚ₂(ζ₁₂), the local field of **row 67**, not the unramified ℚ₂(ζ₃) of
de Grey's lattice — so "the tight dyadic K₄" is K₄ only at level one, and the towers above differ.

### 0.4 What a good structural form looks like

About **every** four-colouring, posed where the arithmetic is cleanest: *is every four-colouring of the plane over a type-(B) field
periodic (equivalently, local at the dyadic prime)?* The existence form is "does a rich lattice carry `F₄ ≠ 0`". A structural form that
names a lattice and asks for its forced group is the existence form reworded. The class question: stripped of arithmetic the question is
already answered (dB2 is a triangle-free abelian Cayley graph whose colourings all factor through a tight `K₄`), so the most general
class where it is open must keep the unit-distance (rotation-group) structure.

### 0.5 Where I expect a plan for this to go wrong

1. Route 1 re-deriving row 67 (a kernel theorem) and reading it as evidence about lattices; its falsifier as written ("the tower forces
   nothing at any depth") cannot fire on the full tower.
2. "Rich lattice" defined for the odd primes only; finite `U` cannot fill the dyadic tower at depth, so any finite lattice's 2-power
   quotients go sparse — an artefact of finiteness, not of triangles.
3. An outcome registered as informative that is free (a `P₄ ≠ 0` at the field level), and the likely uninformative outcome (F undecided)
   left without a verdict.
4. The structural form written as the existence form reworded.
5. A lean toward "yes" because H5 is "the route with the most in it".
6. Route 2 at slack levels quietly needing a colouring classification — a search, banned this week.
7. The Soifer prior stated without reading de Grey 2026 (ℝ³, triangle-free, five-chromatic), which bears on its strength.

## 1. Evidence inventory

- `plans/STUB-dyadic-rigidity-triangle-free.md` — read against: H5/H6 restated, routes 1–4 — surprised: yes (route 1's falsifier as
  written is already decided on the full tower by row 67; "19" listed as usable for ℚ(√59), it is not).
- `data/fs85/held/HELD-plan-advisor.md` — read against: H5 derived arithmetic, analogy conclusion — surprised: yes (H5's list omits the
  ramified 59; its mechanism is G54's demoted reading).
- `LEDGER.md` row 67 — read against: "the 2-adic plane of K(i)" — surprised: yes (it is ℚ(√59)'s own dyadic plane: 3·59 ≡ 1 mod 8).
- `LEDGER.md` rows 66, 75, 78, 82, 85, 86, 87 — read against: §0.1 — surprised: no.
- `plans/FS85-derivation.md` A3, dB2–dB8, C4–C15, R3a/b, L16, §7 — read against: §0.3 — surprised: no (C7's NT = the pinning; R3a =
  the pointwise kill; the two are separable).
- `BIBLIOGRAPHY.md` `[Zhang2012]` + the held PDF (arXiv v1, Theorem 1.8) — read against: "α formula only" — surprised: **yes**
  (Theorem 1.8 also gives MIS-normality: for vertex-transitive `G`, `H` with `α(G)/|G| > α(H)/|H|` and `H` connected, every maximum
  independent set of `G × H` is a preimage from `G`; the record cites only the α half).
- `plans/FS79-derivation.md` T2, T9 — read against: chainability, the saturated chain — surprised: no.
- `plans/PROTOCOL-competitor-and-advisor.md` §0–§1 — read against: the rules — surprised: no.
- `plans/FS38-derivation.md` D2-A/B — surprised: unread (relied on row 67's summary of it).
- `CLOSED-QUESTIONS.md` §3 — surprised: unread (relied on dB4's statement).

## 2. Hunch ledger

hunch: F1-row-67-is-the-local-plane
  claim: ℚ(√59)(i) completed at its one dyadic prime is ℚ₂(ζ₁₂), and its local plane with all local unit vectors is row 67's `P_m`
  basis: derived
  falsifier: a PARI decomposition of 2 in ℚ(√59, i) other than one prime with e = f = 2, or a completion not containing √−3
  registered: 2026-09-25
  status: confirmed (by: 3·59 = 177 ≡ 1 mod 8; the planner found it independently; PARI check §3)

hunch: F2-field-level-binary
  claim: at the field level (R = ℤ[U_F], all unit vectors), `F₄ ∈ {0, P₄}`: a nonzero forced δ makes every four-colouring δR-periodic (G55's chain-theorem transport), δR has finite index, so every colouring is periodic and `P₄ = F₄`
  basis: derived
  falsifier: a defect in the transport (needs `U_F·R ⊆ R`, true since R is the ring U_F generates) or a nonzero ideal of R of infinite index
  registered: 2026-09-25
  status: open (derived by me only)

hunch: F3-field-level-P4-decided
  claim: `P₄(R) = R ∩ 𝔓⁴` for ℚ(√59): finite quotients of R are products over stable primes; by weak approximation for the (rational) norm-one torus the unit vectors fill the product of local unit groups, so a periodic colouring is a colouring of a categorical product `P_m × H`; `[Zhang2012]` Thm 1.8(i) (MIS-normality) with `α(P_m)/|P_m| = 1/4 > α(H)/|H|` makes every four-colouring pulled back from `P_m`; row 67 then gives `𝔓⁴`
  basis: derived
  basis note: needs α/n < 1/4 at every level of every odd stable tower: 11, 23 by row 75; 31, 43, 47, 67, … by Hoffman + G54's constant ratio (split, Galois rings); **the ramified 59's tower is the one step not checked**
  falsifier: an odd stable local plane of ℚ(√59) at some level with α/n ≥ 1/4 (first place to look: the ramified tower at 59, level ≥ 2); or the journal version of Zhang's Thm 1.8 differing from arXiv v1
  registered: 2026-09-25
  status: open

hunch: F4-F-is-a-union
  claim: `F(R) = ⋃_M F(Λ_M)` over any cofinal chain of f.g. sublattices (forcing monotone upward + `forces_iff_exists_finite`), while `P(Λ) ⊆ P(R) ∩ Λ`; so the lattice question for F IS the field question, and for P it is a different (lower) one
  basis: derived
  falsifier: a pair forced in R with no finite witness (contradicts row 78's kernel theorem)
  registered: 2026-09-25
  status: open

hunch: prior-F-zero
  claim: F₄(ℚ(√59)²) = 0 (Soifer's problem open since 2019; dB4)
  basis: prior
  falsifier: a finite UDG over ℚ(√59) with a four-colour forced pair
  registered: 2026-09-25
  status: open — NOT sent as advice; the outcome is the competitors'

## 3. Checks run (seconds each)

- **C1 (PARI, `chk.gp` in this directory):** in ℚ(√d, i), d = 59, 83, 131, 2 has one prime, e = f = 2; the prime above d is one,
  e = f = 2; `issquare(3d + O(2^10)) = 1` for all three; control K(i): two primes above 2, e = f = 2. Confirms F1.
- **C2 (python):** stable odd primes (p ≡ 3 mod 4, split or ramified): 59 → 11, 23, 31, 43, 47, 59, 67, 83, …; 83 → 19, 43, 47, 67,
  71, 79, 83, …; 131 → 19, 23, 31, 47, 67, 71, 79, 83, …, 131. The stub's "19" for ℚ(√59) is wrong (the planner found it too).
- **C3 (read):** `[Zhang2012]` arXiv v1 Theorem 1.8: α(G × H) = α(G)|H| and either (i) MIS-normal, or (ii) equal ratios and one
  IS-imprimitive, or (iii) strict ratio and H disconnected.

- **C4 (hand): the ramified tower at 59 keeps its Hoffman ratio at every level.** F_v = ℚ₅₉(√59), π = √59 (fixed by conjugation),
  L = F_v(i) unramified, residue 𝔽₅₉ ⊂ 𝔽_{59²}; G_k = Cay(O_L/π^k, S_k), |S_k| = 60·59^{k−1}, G₁ = Γ₅₉. For k ≥ 2 the fibre of
  S_k → S_{k−1} over s is {s + π^{k−1}sa : Tr(a) = 0} (the π^{2(k−1)}aā term dies mod π^k). A character of exact level k sums over a
  fibre to 59·χ(s) if the induced additive character of 𝔽_{59²} is trivial on s·ker Tr, else 0; trivial only when s ∈ c⁻¹𝔽₅₉^×, which
  meets μ₆₀ in at most ±1 — so |λ| ≤ 2·59^{k−1}. Characters of exact level j < k give 59^{k−j}λ_j, same bound. Level-one characters
  give 59^{k−1}λ₁. Since |λ_min(Γ₅₉)| > 2, λ_min(G_k) = 59^{k−1}λ_min(Γ₅₉) and the Hoffman ratio is level one's at every level
  (< 1/5 < 1/4). Row 75's fibre-share lemma, over a ramified base. This closes F3's one unchecked hypothesis — at my hand, one mind.

## 4. Messages (substance) and retractions

**M0, planner → me (before my first message).** Its spec findings: (1) row 67 is ℚ(√59)'s dyadic plane (independent of my F1);
F ⊆ P ⊆ Λ ∩ 𝔓⁴ for every lattice; Q_m sparse once 3·2^{m−1} > |U|; de Grey's completion is unramified. (2) H5 missed the ramified 59
and listed 19 wrongly; Λ_2730 covers 44/60 at 59 (Hoffman float 0.320 > 1/4). (3) Λ_510 (324 unit vectors, Λ ⊗ ℤ₂ = O, 1/3, 1/5,
1/17 ∈ Λ) certified non-four-colourable at every level-one target of norm ≤ 59 (float, aiming). Shape: stage B exact CA on Λ_510;
stage C competition on the structural question for a rich lattice; route 4 after 10-01.

**M1, me → planner.** (b) PARI confirmation. (c) FR-1: field vs lattice — (i) F union, P not monotone; (ii) F(R) ∈ {0, P(R)} by
G55's transport; (iii) P₄(R) = R ∩ 𝔓⁴ by WA + Zhang 1.8(i) + row 67, ramified 59 tower unchecked → the stub's "Yes P₄" is free at
the field level. FR-2: is stage C posed on Λ_510 or on the field plane; the stripped class is answered by dB2. (a) silent-but-bearing
list: G55, G66, G43/G59 (+Zhang row), G48/FS-64/66/67, G41 (Fischer positive control), G74/FS-83, G54's killing test, G21, G71, G73,
row 75, dB2. Cautions: route 1's falsifier reachable only past saturation depth (m ≥ 8 at 324 vectors); route 2 slack levels need a
search → register "slack, undecided".

**M1', me → owner.** Expectation written; close-inventory items: Zhang's MIS-normal half bears on FS-67 (held paper, prior art for a
question it was not read for); FR-1(iii) changes the registered outcomes (my derivation only; 59 tower unchecked).

**M2, owner → me.** Items logged as close inventory 10 (Zhang MIS-normal) and 11 (field-level frame, hand, one mind, unchecked).
Owner checked in PARI only the row-67 identification. Registrations resting on the {0, P} dichotomy or the product pull-back need two
derivations.

**M3, me → planner and owner.** C4: ramified 59 tower's Hoffman ratio constant (fibre-share over a ramified base) — F3's last hypothesis
closed at my hand; relayed the owner's two-derivations rule.

**M4, planner → me.** FR-1 and FR-2 adopted, re-aiming the milestone. My ramified closure checked at argument level (not blind).
Shape: §0 leads with FR-1; stage B = blind second derivation of FR-1(ii)–(iii) for 59, 83, 131 (B1) + the Λ_510 lattice profile (B2,
"slack, undecided" registered); stage C competition posed on the FIELD plane, Λ_510 as exact instance. Its own corollary: row 85 ⟹
F(R_K) ≠ 0 ⟹ every four-colouring of K² periodic ⟹ local at one dyadic place (B1's control). §PA find: vector colourings
(Godsil–Roberson–Rooney 2017 Thm 4.9; GRRŠV 2020 Cor 4.4, UVC products). Asked: frame items outstanding? Literal scope F²?

**M5, me → planner.** (1) K control correct at argument level; the step to make explicit: two dyadic places have equal ratio (Zhang
case ii) so the one-place step is tightness of P_m × P′_m (pure-character least eigenspace) + dB6's splitting; F(R_K) = 4R_K; consistency
4, 8/3, 8/9, 16/3, v ∈ 4R_K, 2P ∉ (Fischer); flagged as a classification of all four-colourings of K² — needs its own two derivations
and prior-art check. (2) Literal scope: dichotomy survives; F(i) divisible ⟹ no finite-index periods on F², so "periodic/local at 2"
must be per R-coset. (3) Frame: (a) type (B) = exactly one stable place with χ_f ≤ 4, tight — ℚ(√11) pulls back from Γ₇ (H6 recovered),
ℚ(√47)/ℚ(√167) have no periodic four-colouring; (b) verdict asymmetry: F = 0 is a restricted Soifer-negative only; (c) prior to be
registered after reading [deGrey2026] (ℝ³). Asked for FR-1 to be attacked in blind B1.

**M6, owner → me.** K-plane candidate logged as close inventory item 13 (hand, one mind, the planner's; my non-blind check; debts:
two derivations + prior art). Owner checked by hand the consistency memberships only (1/3 ∈ R_K since 3 = 𝔮², 𝔽₉ ∋ i, 𝔮 splits in
K(i); v ∈ 4Λ; 2P ∉ 4R_K since 1/2 ∉ R_K, wall standing).

Retractions: Poros 0, planner 0. (Two convergences, no disagreement — G51: it has not started.)

## 5. "Would have searched here" log

- I would have asked a solver whether `P₅ × Γ₁₁` (the smallest dyadic-times-odd product) has a four-colouring not pulled back from
  `P₅`. Instead: read `[Zhang2012]` Theorem 1.8 in the held PDF (MIS-normality), which decides it with `α(Γ₁₁)/121 < 1/4` (row 75).

## 6. My own errors

- **E1 (found at the final report, 2026-09-25; not retracted before the plan was committed).** In M1, caution 1, I wrote that route 1's
  falsifier can fire only on `Q_m` "past the saturation depth … with 324 vectors that is m ≥ 8 at the earliest". The direction is
  reversed: 324 vectors cannot fill `S_m` once `3·2^{m−1} > 324`, i.e. from m = 8 on, so sparsity is guaranteed **by m = 8 at the latest**
  and may begin as early as the true saturation depth `m* + 1` (possibly 5). The plan did not inherit the error (its P-sat registers
  `m* ≥ 5` at 0.55 and §0.1 states the bound correctly).

## 7. Stage A closed (plan committed at 632c24de) — final notes

- Adopted by the planner: every frame item (§Y of the plan). Declined: nothing. Retractions in stage A: Poros 0, planner 0 (the planner's
  first four-line K corollary missed the equal-ratio step; counted by the planner as a slip, not a retraction). Two convergences and no
  retraction — G51's warning shape; the contest starts in the blind B1.
- **A frame item formed after the plan was committed, not sent to the planner, for the competition advisor to send to both at once:** by
  §0.3 (ii)–(iii), `F(R)` is an ideal in `{0, R ∩ 𝔓⁴}`, so **`F(R) ≠ 0` ⟺ the single pair `(0, 4)` is four-colour forced** (4 ∈ R ∩ 𝔓⁴,
  since 𝔓² = (2)) ⟺ some finite unit-distance graph over ℚ(√59) forces a pair at distance 4; and `F(R) = 0` ⟺ some four-colouring
  separates `0` and `4`, necessarily non-periodic. Over K the same pair is forced (G9's 791-point forcer: the axis pair at distance 4),
  consistent with `F(R_K) = 4R_K`. Conditional on §0.3 (iii) surviving B1.
- **HD1 bears on the plan's fallback (§S.5, FS-83 at k = 4)**: by weak approximation its hour-one question at the field level reduces to
  whether the product of the stable local planes admits an additive circular colouring of ratio below 4. If none exists, `Θ₄(F)` is torsion
  only and the fallback cannot give `F(R) = 0`. Recommended to the owner: release HD1 to whoever staffs the fallback, before it is staffed.
