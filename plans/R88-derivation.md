# Row 88's question — the derivation file: every theorem the milestone proved outside the kernel

*Written 2026-09-25 at the milestone's close (WORKFLOW 2.0 step 9) by crunch job J41 (de Bruijn, Opus 5.5, the close planner), from the plan
`plans/FS86-row88-rigidity.md` (J28) and its three records: `plans/FS86-R88-D-derivation.md` (J28D, the derivation), `plans/FS86-R88-V-verification.md`
(J28V, the blind verifier; its verdicts committed blind at e1a29f37, its divergence table at 9262898f), and `plans/FS86-row88-PA-close.md` (J35,
the close-time prior-art gate). The home is `R88` (row 88's open question, as `R52`, `R57`, `R59` are their rows'). Grades are `CLAUDE.md`
§ Notation's, as each record gives them. A proof held in a record is not repeated here; this file is the index that survives the ledger rows'
compression. `LEDGER.md` § B will index every entry, one line each (drafted in the plan's §R-close). **The milestone added no Lean**, so nothing
below is kernel-checked; every kernel decision is recorded per entry.*

**The main question stays undecided.** Row 88 asks whether `(0, 4)` is forced over ℚ(√59), ℚ(√83), ℚ(√131) — equivalently, whether every
four-colouring of the plane is a pullback from the tight dyadic place. Neither record answers it; §G below states the two gaps where both
stopped.

**Notation, fixed once** (the plan's §S.0, verbatim in substance). `F` a real field in S2 (`plans/FS86-derivation.md` Notation: "real fields with
exactly one stable place whose local planes have `χ_f ≤ 4`, that place four-tight at every level"; type (B) = ℚ(√59), ℚ(√83), ℚ(√131)); `L = F(i)`;
`U = U_F`; `R = ℤ[U]`; `𝔓` the tight place, `π₄ : R → O/𝔓⁴` (onto; `𝔓⁴ = 4O` for type (B)); `X₄(F)` the proper four-colourings of `Cay(R, U)`,
compact; **Pull** the colourings `γ ∘ π₄`, `γ` a proper four-colouring of row 67's `P₄` (1,179,936 of them); `Aff_F` the maps `z ↦ t + u·τ(z)`;
`F_μ(R)` the `δ` identified almost surely by every translation-invariant Borel probability `μ` on `X₄(F)`; **(Q-μ)** every such `μ` is carried by
Pull; **transient**: `c ∉ Pull` all of whose orbit closure's invariant measures are carried by Pull; **(Q-tr)** no colouring is transient. The
**spectral measure** of `μ` is that of the tetrahedral embedding `g(x) = e_{c(x)}`; `T` the torsion characters of `R`, `A` the archimedean ones,
`Fin_S` those continuous for the `S`-adic topology, `S` a finite set of split places; `G_S = (L ⊗ ℝ) × ∏_{stable} O_{L_v} × ∏_{v∈S} L_v`, `T_S`
the closure of `U` in it. `d*` is upper Banach density in `R`.

**Duplicates are merged, one entry per theorem.** An entry carries the id of its first full derivation; its title names every other id the records
give the same theorem, so a grep for any id lands here. Independence, in the records' own words: **blind** means the deriver had seen neither the
other derivation nor its statement (J28V's stage 2, committed before J28D's record was opened); **from the statement** means the statement was seen
and the proof was not (J28V's stage 5 on J28D's §5.2 lemma statements, its J28V-11). **J28V-11** ("J28D's §5.2 statements L-C1, L-C4, L-C4b, L-C5
re-derived from their statements") is not a theorem of its own: it is filed as the verification line of R88-TC-ext, R88-TC-Yp, R88-TC-reg and
R88-TC-count.

**Who found what.** **J28D** (derivation): T-A, T-A1, T-A2, L-CL, TC and its lemmas (C1–C8, TC-Y′, TC-reg, TC-count, TC-tab), TC(A), B2-1, B2-2,
B2-3. **J28V** (blind verifier): J28V-1 to J28V-11. **J35** (prior-art gate): no theorems; every *Prior art:* field below is its verdict at the
scope it gives. **J28** (the planner): no theorems; the targets, the decomposition's shape and the controls.

**Prior art — the close-time gate (J35, `plans/FS86-row88-PA-close.md`).** Verdicts, at J35's scope: T-A **partly in print** ((v)'s engine is
`[BergelsonMoragues2021]` Thm 2.3 + Prop. 2.7; "transient" is the literature's *measure centre in Pull*, `[ChenDai2017]` Lemma 1.2 in Følner-relative
form; (i)–(iv) not found by these searches); T-C **partly in print in its inputs** (`[BachocEtAl2014]` Thm 2.2, `[BardestaniMallahiKarai2017]` §3.2,
`[AmbrusEtAl2023]` Thm 1, `[Zhang2012]` Thm 1.8's counting), the theorem not found; T-C(A) **not found** (the two unread Johnson papers could pose its
question); the partials toward transience **methods in print, statements not found**; J28V-7 **in print** (`[LevitzMott1972]` Thm 2.3); J28V-6
**partly in print** (BMK 2017 §3.2 over `ℚ_p`, every `p`). "Not found" measures the queries' words (G21) and is never "new".

## §1. The decomposition (T-A) and its consequences

**R88-TA — T-A, the decomposition: for `F` of type (B), or any real field in S2 where row 88's frame holds, (i) Pull is finite, closed and `Aff_F`-invariant, with `τ` ranging over the automorphisms of `F(i)` commuting with complex conjugation; (ii) `F_μ(R)` is an ideal, equal to `0` or `P(R)`, and `F(R) ⊆ F_μ(R) ⊆ P(R)`; (iii) `F_μ(R) ≠ 0` iff Q-μ; (iv) `F(R) ≠ 0` iff Q-μ and Q-tr; (v) `c ∉ Pull` is transient iff, for every finite `B ⊂ R`, `{t : (t·c)|_B ∉ Pull|_B}` has upper Banach density 0; (vi) if every point of Pull is isolated then Q-tr, and `F(R) = F_μ(R)`. (= J28V-7's first clause; J28D L-A.) [hand; two derivations, J28D and J28V blind]**
Statement verbatim from the plan's §S.1 with the one scope repair both minds reached: "preserving `R`" does not obviously give `τ(U) = U`, so `τ`
is read as commuting with conjugation (J28D) — for type (B) `Gal(F(i)/ℚ) ≅ V₄` and nothing is lost; J28V's wording is "preserving `R` gives
`σ(U) = U` when `F/ℚ` is Galois". **Outside type (B)** (J28V's second scope note), "row 67's `P₄`" is read as the tight place's own stabilised level
(for ℚ(√2,√3), C12.1's `P_c`). The routes agree step for step but one: (ii)'s finite-index step is V2 (Lemma R) in J28D and the rank argument in
J28V (R88-J28V-7). *Proof:* J28D §Stage 2 (i)–(vi); J28V §2.3. *Proof verdict:* closes, twice (J28V §4 rows V1–V5, V8). **Controls read**
(P-controls): ℚ(√11) is outside the hypotheses (periodic non-pullbacks exist there) and C9's `⌊4(θ + s)⌋` is an invariant non-Pull measure, so
Q-μ fails; K per coset and ℚ(√2,√3) (given T721) have `X₄ = Pull`. *Rests on it:* every entry below; the ledger row's frame. *Prior art:* (v)'s
engine is R88-CL, in print; "transient" is the measure centre of the orbit closure lying in Pull (`[ChenDai2017]` Lemma 1.2, Følner-relative; the
measure centre for amenable actions, Wang–Zhou 2016, summary read); (vi) is elementary topology; (i)–(iv) at their scope **not found** (J35
§Stage 2); the sandwich `F ⊆ F_μ ⊆ P` is FS-73's frame (G60, FS73-T38), not this milestone's. *Kernel:* declined — (v) needs Følner sequences
and weak-* compactness of invariant measures on a countable amenable group, far from the kernel's current surface; (ii)'s ideal step is row
43's transport (`transport_pair_of_isometry`), a candidate if T-A is ever wanted there.

**R88-CL — Lemma CL, the clopen correspondence: for a countable abelian group acting on a compact space, a point `c` and a clopen `C`, the upper Banach density of `{t : t·c ∈ C}` equals the maximum of `μ(C)` over invariant `μ` on the orbit closure of `c`. (= J28D L-CL; J28V §2.3 (v).) [hand; two derivations, J28D and J28V blind; in print]**
Both directions by both minds, the same route (J28V §4 row V5: "identical route"): ≤ by Følner empirical measures along translates attaining the
sup, ≥ by a point of the support with a large average and a translate of `c` agreeing with it on a window. *Proof:* J28D §Stage 2 (v); J28V §2.3
(v). *Proof verdict:* closes. *Rests on it:* R88-TA (v), R88-B2-3. *Prior art:* **in print** — `[BergelsonMoragues2021]` Thm 2.3 (the
construction, ≤) and Prop. 2.7 (every ergodic invariant measure on an orbit closure has the point quasi-generic along some Følner sequence, ≥), the
amenable form of Furstenberg 1981 Prop. 3.9 (J35 §Stage 2). Both records re-proved it; cite Bergelson–Moragues. *Kernel:* declined (in print;
Følner machinery).

**R88-TA1 — The hierarchy: T-B1 ⟹ Q-tr ⟹ T-B2; `F(R) ≠ 0` ⟹ T-B1; and T-B1 together with Q-μ gives `F(R) ≠ 0` — so, given T-C, T-B1 would reduce row 88 to Q-μ for spectra outside every `T + A + Fin_S`. (= J28D T-A1; J28V-8 first clause (B2-a), J28V-9 (B1-a, B1-c).) [hand; two derivations of T-B1 ⟹ Q-tr ⟹ T-B2, J28D and J28V blind, by different routes; the rest J28V's, one mind, each a line from R88-TA]**
T-B1 ⟹ Q-tr is R88-TA (vi). Q-tr ⟹ T-B2: J28D through the orbit closure of the pair `(c, p)` in `X₄ × Pull`, whose invariant measures are carried
by the diagonal when `d*(D) = 0`; J28V through return times lying in finitely many translates of `D` (J28V §4 row V6: "both valid"). `F(R) ≠ 0`
makes `X₄ = Pull` finite (B1-a); T-B1 ∧ Q-μ ⟹ `F ≠ 0` by R88-TA (vi), (iii), (iv) (B1-c). *Proof:* J28D §Stage 2 "T-A1"; J28V §2.4 (B2-a),
§2.5 (B1-a, B1-c). *Proof verdict:* closes. *Rests on it:* the order in which the two gaps sit (T-B1 is the stronger target); R88-B2-3. *Prior art:* not gated as a statement (a soft consequence of T-A); J35's result 4 found no printed statement that isolated periodic points of a colouring
shift on an infinite-degree abelian Cayley graph exist or are forced. *Kernel:* declined (rests on R88-TA).

**R88-TA2 — A FALSE for T-B1 or for T-B2 exhibits a four-colouring outside Pull, so `F(R) = 0`: either counterexample answers row 88 "no". (= J28D T-A2, L-A2; J28V-8 (B2-b), J28V-9 (B1-b).) [hand; two derivations, J28D and J28V blind]**
Non-pullbacks converging to `p` cannot lie in the finite Pull (a convergent sequence there is eventually constant); a sparse defect `D` against `p`
cannot come from `c ∈ Pull`, since two pullbacks differ on a union of `R ∩ 𝔓⁴`-cosets. **Consequence for the plan's §P:** its FALSE prices for
P-TB1 and P-TB2 (0.10, 0.15) were incoherent with P-decide "no" (0.02) — flagged by J28D §1.2, made again in J28V's own C0 (J28V §4 row V7).
*Proof:* J28D §Stage 2 "T-A2"; J28V §2.4 (B2-b), §2.5 (B1-b). *Proof verdict:* closes. *Rests on it:* the §P coherence note; the reading of
T-B1 and T-B2 as no easier than row 88 on the "no" side. *Prior art:* not gated (elementary). *Kernel:* declined (elementary; no consumer).

## §2. Theorem C over the real fields, and its type-(A) form

**R88-TC — Theorem C over the real fields of S2: every translation-invariant Borel probability measure on `X₄(F)` whose spectral measure is carried by `T + A + Fin_S`, for a finite set `S` of split places, is carried by Pull; the real place enters only as an input, through `m₁(ℝ²) ≤ 0.2470 < 1/4`. (= J28V-4; J28D TC.) [hand; over ℚ(√59), ℚ(√83), ℚ(√131): two derivations, J28D and J28V blind, independent routes over common inputs; over the rest of S2 (J28D's TC-class): J28D one mind, J28V's stage-5 reading "my route reaches it unchanged"]**
**Scope, exactly.** J28D proves the class form — "`F` real; one stable place `𝔓` whose tower is row 67's (tight at four colours at every level,
every minimiser killing `𝔓⁴`); every other stable place of all-levels ratio `< 1/4` (this is S2); `S` a finite set of split places" (J28D §3.2
TC-class). J28V proves it over the three type-(B) fields (J28V-4) and records at its stage 5, row V11: "J28D's statement is the wider one, and my
route reaches it unchanged" — a verifier's reading from J28D's statement, not a blind derivation of the class form. **Inputs** (the grade line both
records give): C14.1–C14.3 and C14.2 (a)–(c) (window lemmas, two derivations at FS-86); `[AmbrusEtAl2023]` Thm 1 (`m₁(ℝ²) ≤ 0.2470`; external,
computer-assisted; its certificate re-checked, cert + hand, `m₁(ℝ²) ≤ 0.246989`: exact on H1–H3 and H6 by J26,
`plans/PA-ambrus2023-audit.md`, ball arithmetic on H4 and H5 by J49, `plans/FS100-KT1-ambrus-ball.md`); FS-66's certificates at 11 (ℚ(√59)) and 19 (ℚ(√83), ℚ(√131));
Lemmas D and P; FS38-D2-A/B; V3ram; VC-C2; weak and strong approximation; and, in J28D, Lemma R (b) (or J07's Lemma C), Bochner, Doob–Cohn and
Lebesgue differentiation on doubling spaces. **Not used:** J21-MX, J21-RED, V3, C14's main count or C14′ as black boxes (J28D §3.1: C14 reads
`𝔓` at finite level only and C14′'s conull-`Ω` format is not the edge-a.e. format a random extension produces; J21-MX selects a colouring of the
other factors and says nothing about `c`). **Two routes** (J28V §Stage 5, rows V12–V16): both extend the colouring to `G_S` (R88-TC-ext), make it
a.e.-proper, split off the finitely many Hoffman-failing stable places (11 or 19) with the real places and `S` into a factor `X` of ratio `< 1/4`,
count against a compact tight factor, and propagate by gap-freeness. J28D absorbs every other stable place into the tight factor (R88-TC-Yp),
regularises only inside `X` (R88-TC-reg), counts stationarily from the start (R88-TC-count) and returns to `R` by `C(δ) = 1` on `R ∩ 𝔓⁴`; J28V keeps
those places as one compact tail factor (R88-J28V-3), regularises on all of `G_S` to a conull `Ω` (R88-J28V-2), counts samplewise and then uses
stationarity, and returns to `R` by continuity of `h ↦ P(G(h) = γ(π₄h))`. "Neither uses the other's new steps"; they share the architecture and every
transplanted and external input. **Sharp:** at ℚ(√11) the stable 7 (all-levels ratio `≥ 2/7 > 1/4`, `λ_min/d = −0.5617`) fits neither the tight
factor nor `X`, and C9's colouring has spectral measure on `T + A` and is no pullback; at K the second tight place has ratio exactly 1/4; replacing
`m₁` by Hoffman's 0.2871 at the real place flips the count's sign (J28D §3.4, the mutation audit: each hypothesis is the one a control violates).
*Proof:* J28D §3.2 (C1–C8); J28V §2.1 (C0–C7). *Proof verdict:* closes, twice over type (B); over the class, once (J28D) with J28V's reading.
*Rests on it:* R88-TCA (the same steps); the scoring of P-real (won: on `T + A + Fin_S` the real place is an input, not the obstruction); G76's
reading narrowed; T-C′'s statement (what is left of Q-μ). *Prior art:* **partly in print, in its inputs** — the measurable Hoffman bound on edge-null
sets is `[BachocEtAl2014]` Thm 2.2 (their Def. 2.1's independent set is J28D's edge-null set); the split places' ratio 0 is
`[BardestaniMallahiKarai2017]` §3.2; the real place `[AmbrusEtAl2023]`; the product count `[Zhang2012]` Thm 1.8; Hoffman equality forcing the least
eigenspace is Blokhuis–Brouwer–Haemers's in finite form (G54), its measurable form on a compact group the equality case of BDOV Thm 2.2's proof,
not stated there; C1–C2 are Bochner and Doob. **The theorem not found by these searches**: no classification of translation-invariant random proper
colourings of a unit-distance graph over a number field, or of any infinite-degree abelian Cayley graph, by spectral type (J35 §Stage 3; the
nearest, `[PeledSpinka2023]`, is on ℤ^d, bounded degree, another notion). *Kernel:* declined — measure-theoretic throughout (Bochner on a
non-discrete LCA group, Doob's measurable modification, Lebesgue differentiation), none of it on the kernel's surface.

**R88-TC-ext — The extension lemma: the spectral measure of a translation-invariant random four-colouring is carried by `T + A + Fin_S` iff `P(c(0) ≠ c(y)) → 0` as `y → 0` in `G_S`; then the colouring extends to a `G_S`-stationary process, continuous in probability, `{e_j}`-valued, with a jointly measurable version equal to `c` on `R` a.s., and `P(c̃(x) = c̃(x + w)) = 0` for every `x ∈ G_S` and every `w ∈ T_S`. (= J28V-1; J28D C1–C3, L-C1–L-C3.) [hand; two derivations, J28D and J28V blind, two routes; the converse (⟸) J28D's, re-derived by J28V from the statement]**
J28D: the hypothesis **is** `τ_S`-continuity of `y ↦ P(c(0) ≠ c(y)) = 3(1 − σ̂(y))/4` (Bochner on `G_S` for ⟸, dominated convergence for ⟹),
then uniform continuity in probability and Doob–Cohn; `P(c̃(x) = c̃(x+w)) = (1 + 3C̃(w))/4 = 0` since `C̃ = −1/3` on the closure of `U`. J28V: the
cyclic subspace is `L²(Ĝ_S, M)` and the Koopman unitaries extend by multiplication by extended characters; properness at every pair of
`G_S × T_S` by approximation from `R` (J28V §4 row V12: "the same extension, proved two ways"). Density of `R` in `G_S` by strong approximation
away from a split place outside `S`, with Lemma R for integrality (both). *Proof:* J28D §3.2 C1–C3; J28V §2.1 C1–C2; J28V §Stage 5 (L-C1–L-C3
TRUE). *Proof verdict:* closes. *Rests on it:* R88-TC, R88-TCA. *Prior art:* Bochner and Doob (J35 §Stage 3: "C1–C2 … are Bochner and Doob, as
J28D names them"); the lemma as a statement about random colourings not found. *Kernel:* declined (measure theory on LCA groups).

**R88-J28V-2 — Regularisation to a conull set: a measurable path on `G_S`, proper off an `(m × ν_T)`-null set of pairs, is a.e. equal to one proper on every pair inside a conull Borel set `Ω` (C14′'s format), translation-equivariantly. [hand; one mind (J28V); J28D's route does not use it]**
Density points along the nested families `E_n = C_n × V_n`, `E′_n = 1.5C_n × V_n` (not doubling on the infinite product, but
`m(E_n − E_n + E_n) ≤ 3^{2[F:ℚ]}m(E_n)` suffices for Vitali and Lebesgue differentiation). J28V §4 row V13: J28D's objection to C14′ ("a null set
of bad edges can touch every vertex") applies to the unregularised path, which this regularises. *Proof:* J28V §2.1 C3. *Proof verdict:* closes
(one mind). *Rests on it:* J28V's route to R88-TC and R88-TCA. *Prior art:* Lebesgue differentiation along a Vitali family (textbook); the
statement not gated separately. *Kernel:* declined.

**R88-TC-reg — In a doubling LCA Cayley graph with a full-support connection measure, an edge-null measurable set is a.e. equal to an independent set (its Lebesgue density points); so C14.1 holds for edge-null sets with essential neighbourhoods (C14.1-e). (= J28D TC-reg, L-C4b; J28V-11 on L-C4b.) [hand; J28D; re-derived by J28V from the statement (its C3's density-point argument, which also covers the non-doubling product)]**
*Proof:* J28D §3.2 C4 (Lemma X′, "Regularisation"); J28V §Stage 5 (L-C4b TRUE). *Proof verdict:* closes. *Rests on it:* J28D's NH-X step in
R88-TC-count. *Prior art:* the edge-null notion is `[BachocEtAl2014]` Def. 2.1 ("`(Af, f) = 0` for each `f` vanishing a.e. outside `I`");
density points textbook. *Kernel:* declined.

**R88-TC-Yp — Lemma Y′: `O_𝔓 × ∏_{v∈H} O_{L_v}`, with `H` the stable places `v ≠ 𝔓` whose non-trivial characters have `λ/d > −1/3` at every level (D's H*), is Hoffman-tight at four colours with least eigenspace exactly the `𝔓`-minimisers, all killing `𝔓⁴`. (= J28D TC-Y′, L-C4; J28V-11 on L-C4.) [hand; J28D; re-derived by J28V from the statement]**
A product of numbers in `[−1/3, 1]` is `≥ −1/3`, with equality only when every `H`-factor is trivial and the `𝔓`-factor a minimiser; the value 1
at an `H`-factor forces the trivial character since `⟨T_v − T_v⟩ = O_{L_v}` (VC-C2). *Proof:* J28D §3.2 C4; J28V §Stage 5 (L-C4 TRUE). *Proof verdict:* closes. *Rests on it:* J28D's route to R88-TC (the tight factor does not grow when the H*-places join it). *Prior art:* the Hoffman
framework is `[BachocEtAl2014]`; the product-tightness lemma not gated separately. *Kernel:* declined.

**R88-J28V-3 — The tail factor: over a type-(B) field or ℚ(√47), all odd stable places other than 11 and 19 form one compact factor of measurable Hoffman ratio `< 1/4`, since every normalised least eigenvalue there, at every level, is below `1/3` in absolute value (23: 0.3317, 31: `1/3 − 4.9·10⁻⁶`, from B1's exact table; `p ≥ 37` by Weil, `36p < (p + 1)²` from `p = 34`; new levels by Lemma P; the ramified place by V3ram). [hand + tools exact; one mind (J28V); J28D's route absorbs these places into the tight factor instead]**
*Proof:* J28V §2.1 C4; `tools/crunch_j28v_facts.py` (1)–(2) (the stability list by an exact Legendre check of seconds; plants fire). *Proof verdict:* closes (one mind). *Rests on it:* J28V's route to R88-TC and R88-TCA. *Prior art:* Hoffman's bound in measurable form
(`[BachocEtAl2014]` Thm 2.2); Weil's bound; the instance not gated. *Kernel:* declined.

**R88-TC-count — The stationary Zhang count: a stationary, a.e.-proper four-colouring of `X × Y′`, with `Y′` compact and Hoffman-tight at `1/4` and `X` of window ratio `r_X < 1/4`, has almost every fibre `c(x, ·)` an a.e.-proper colouring of `Y′`; its classes then each have measure `1/4`, lie in the least eigenspace, and the fibre is a pullback `γ_x ∘ π₄`, `γ_x` constant a.e. by gap-freeness. (= J28D TC-count, L-C5, L-C6, C5–C7; J28V's C5–C6, the same count executed samplewise; J28V-11 on L-C5.) [hand; two derivations of the count, J28D and J28V blind, executed two ways; J28D's form re-derived by J28V from the statement]**
J28D: social and lonely points, essential neighbourhoods, `p_j ≤ ¼(1 − β_j) + r_X β_j` summed to force every `β_j = 0` in expectation. J28V: C14's
count run on each regularised sample with `P = Cay(O_𝔓, T_𝔓)` for `P_m`, stationarity replacing the finite step "some point has no bad `b`" (J28V
§4 row V15: "the same Zhang counting idea (through C14.1, C14.3, observations (i)–(ii)), executed two ways"). *Proof:* J28D §3.2 C5–C8; J28V §2.1
C5–C7; J28V §Stage 5 (L-C5, L-C6 TRUE). *Proof verdict:* closes. *Rests on it:* R88-TC, R88-TCA (with no tight factor). *Prior art:*
`[Zhang2012]` Thm 1.8's counting (J35: C14.3 names it); Hoffman equality ⟹ least eigenspace, Blokhuis–Brouwer–Haemers (finite); the stationary
measurable form not found. *Kernel:* declined.

**R88-TC-tab — The factor table: the stable places that fail H* (and so stay in `X`) are `{11}` for ℚ(√59), `{19}` for ℚ(√83) and ℚ(√131), `{11, 19}` for ℚ(√47); every other stable place below 72 satisfies H* (23 by `1.6·10⁻³`, 31 by `4.9·10⁻⁶` at level one). [tools, float with controls and a plant (J28D); agreed by J28V's exact check]**
Controls: H* fails at 7, 11, 19 and holds at 23, 31, matching B1's table to 9 digits; the plant (the split conic) fires on the circle-size
assertion, exit 1. J28V §Stage 5: L-tab TRUE, agreeing with `tools/crunch_j28v_facts.py` (margins `1.6·10⁻³`, `4.88·10⁻⁶`). At the ban's edge: a
complete enumeration over a set a derivation fixed (every character of `Γ_p` for the listed `p`), logged as such. *Proof:*
`tools/crunch_j28d_factors.py` → `data/fs86r88/j28d/factors.out`, `factors-plant.out`; J28D §3.2 C4's table. *Proof verdict:* closes at its grade
(level one float with exact-match controls; the all-levels ratios at 11 and 19 are FS-66's certificates). *Rests on it:* R88-TC's split `B`
versus `H`; R88-TCA. *Prior art:* none (a computation on held inputs). *Kernel:* declined (float at level one; the load-bearing ratios are FS-66's
certified ones).

**R88-TCA — T-C(A), the type-(A) form: over ℚ(√47), and (J28D) over every real field whose stable places all have all-levels ratio `< 1/4`, no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places, dyadic ones included; so a four-colouring of ℚ(√47)'s plane, if one exists, has an invariant measure on its orbit closure whose spectrum is carried by no `T + A + Fin_S`. (= J28V-5; J28D TC(A).) [hand; over ℚ(√47): two derivations, J28D and J28V blind; over the class: J28D one mind; a second derivation over totally real fields by X25B (blind to the proofs), and with a complex place the step by restriction to the compact real form (FS100-CX, row 123); the split dyadic place: J28V's derivation (R88-J28V-6) and M3's two, J28D a re-reading]**
The steps of R88-TC with no tight factor: every factor of `G_S` has ratio `< 1/4` (11 and 19 by FS-66, the tail by Hoffman — the maximum 31's
`1/4 − 2.745·10⁻⁶` —, the ramified 47 by Lemma P, the real places `m₁`, split places 0), so four classes cannot cover: `1 ≤ 4 max(α(Y′), r_X) < 1`
(J28D) or `1 ≤ 4(r + η(n))` (J28V). The second clause: an orbit closure is compact and invariant and carries an invariant measure. **The
asymmetry** (J28V §Stage 5): a split dyadic place in `S` (ℚ(√47)'s place above 2 is split, `ℚ(√47)_v = ℚ₂(i)`) rests on C14.2 (c) at `q = 2`;
"for that step, J28D's re-reading is not a derivation; mine is". This is FS86-CL1's count moved from measurable windows to invariant measures with
that spectral type, every stable place at once and dyadic split places allowed. *Proof:* J28D §3.3; J28V §2.2. *Proof verdict:* closes, twice at
ℚ(√47). *Rests on it:* FS-84's re-aim (a falsifier of the conjecture's five-clause at ℚ(√47) has spectrum outside every `T + A + Fin_S`); the
T-C′ stub. It does **not** decide `χ(ℚ(√47)²)`. *Prior art:* **not found** by J35's searches (the zbMATH vocabulary control `ti:"planar geometric
graph"` fired on `[Fischer1994]`); undecided on `[Johnson2000]` and Johnson 2000 (*Infinite graphs and the fractional chromatic number*,
Geombinatorics 9(3)), neither held, which could pose the fractional question on rational planes; its inputs in print as for R88-TC. *Kernel:*
declined (as R88-TC).

**R88-J28V-6 — C14.2 (c) holds at residue size `q = 2`: the split-place integrals `∫_{O^×} ψ(bε)dε` are `1, −1, 0, 0, …` at `v(b) = 0, −1, −2, …`, and the non-stationary substitution needs only `−b ≥ 1`; so a split dyadic place has ratio 0 and FS86-CL1's restriction to odd split places can be dropped. (= a third derivation beside M3-J21-D1-2 and its blind check J22-T3.) [hand + tools float with exact target values; one mind here (J28V); with M3's, three derivations]**
*Proof:* J28V §2.2; `tools/crunch_j28v_facts.py` (3) (its docstring first called the check exact; corrected at 88eb2243 to "a float sum compared with
exact target values"). *Proof verdict:* closes. *Rests on it:* R88-TCA with a dyadic split place in `S`; the independence of that step from J21's
derivation. *Prior art:* **partly in print** — `[BardestaniMallahiKarai2017]` §3.2 (Thm 3.7, Lemmas 3.8–3.11) over `ℚ_p`, every `p`, dyadic
included, for the Borel chromatic number; the one-variable values are their Lemma 3.10 (textbook: Ramanujan-sum values, Tate's local computation);
the `ℚ₂(i)` instance is a transcription not literally printed; whether Sally–Taibleson 1966 Lemma 8(i) (BMK's Lemma 3.11) covers residue
characteristic 2 is **undecided** (not fetched; the three derivations make the step independent of that citation). *Kernel:* declined.

**R88-J28V-7 — Every non-zero ideal of `ℤ[U_F]` has finite index, for every real number field `F`, without Lemma R: a non-zero `δ` puts a non-zero integer `m` in `δR` (clear denominators in its minimal polynomial), and `|R/mR| ≤ m^{rank}`. [hand; one mind (J28V); in print]**
Removes Lemma R from FS86-V2's finite-index step (J28V §4 row V3), which matters for S2 fields outside Lemma R's proved scope. **Scope** (J35
§6.1): "every real `F`" means every real **number** field; for an `F ⊆ ℝ` of infinite degree over ℚ the rank argument fails and the ring need not
have finite norms — not a claim anyone made. *Proof:* J28V §2.3 (ii). *Proof verdict:* closes. *Rests on it:* R88-TA (ii) (J28V's route);
the correction owed to FS86-V2's grade line (a draft in the plan's §R-close). *Prior art:* **in print** — `[LevitzMott1972]` Thm 2.3 with `A = ℤ`
(every subring of a number field has the finite norm property), via Krull–Akizuki and its Prop. 2.2 (= `[ChewLawn1970]` Thm 2.3); J28V's route is
the standard elementary proof. *Kernel:* **stub — FS-47** (the unit-vector ring in the kernel): the rank argument is short, removes Lemma R from
V2, and FS-87's candidate list already names Lemma R.

## §3. The partials toward transience (T-B1, T-B2 stop here)

**R88-B2-1 — Propagation: if `c(z) = j ≠ p(z)` for a pullback `p = γ ∘ π₄`, then `z + u` is a defect for every `u ∈ U` with `γ(π₄(z + u)) = j` — a union of `|S₄|/3` residue classes of `U` mod `𝔓⁴` (8 of 24 for type (B)), infinite and dense in the local circles; so no colouring differs from a pullback on a finite non-empty set. (= J28D B2-1; J28V B2-c.) [hand; two derivations, J28D and J28V blind]**
One line: `c(z + u) ≠ j = p(z + u)`. In the symbolic-dynamics word, **every pullback is frozen** (`[AlonEtAl2021]`'s "a `q`-coloring … is frozen if any
`q`-coloring … which differs from it on finitely many sites is identical to it"). *Proof:* J28D §Stage 4; J28V §2.4 (B2-c). *Proof verdict:*
closes. *Rests on it:* both T-B2 attempts start here; R88-J28V-8d. *Prior art:* the notion is `[AlonEtAl2021]`'s; its criteria need bounded
degree (`Cay(R, U)` has infinite degree), so the paper is silent here; the statement for `Cay(R, U)` not found (J35 §Stage 5). *Kernel:*
declined (low value alone; a candidate beside FS-87's periodicity lemmas if T-B2 is ever proved).

**R88-B2-2 — Every archimedean-bounded subset of `R` has upper Banach density 0; in particular `d*(z + kU) = 0` for every `z ∈ R` and `k ≥ 1`, and every finite union of unit circles has density 0: bounded propagation chains are thin, so a proof of T-B2 must use unboundedly long, colour-dependent chains. (= J28D B2-2, L-B2-2 (stated for `z + kU`, proved for any archimedean-bounded set); J28V B2-e (circles, blind; "two distinct circles meet in at most two points"); J28V-10 (the general form, re-derived from the statement).) [hand; two derivations of the circle case, J28D and J28V blind; the general form J28D's, re-derived by J28V from the statement]**
*Proof:* J28D §Stage 4 B2-2 (every Følner set of `R` has archimedean extent `→ ∞`); J28V §2.4 (B2-e), §Stage 5 (L-B2-2: `m` pairwise disjoint
translates give `δ ≤ 1/m + ε`). *Proof verdict:* closes. *Rests on it:* the named step of T-B2 (§G below). *Prior art:* the method is textbook —
Poincaré recurrence for sets of positive upper Banach density (via `[BergelsonMoragues2021]` Thm 2.3; the intersectivity lemma of `[Bergelson1985]`,
not opened); the instance is no one's claim (J35 §Stage 5). *Kernel:* declined.

**R88-B2-3 — A sparse defect is transient: if `d*({c ≠ p}) = 0` for some `p ∈ Pull` and `c ≠ p`, then `c ∉ Pull` and `c` is transient; so T-B2 is exactly Q-tr's single-pullback case, invisible to every invariant measure, and no measure argument (T-C's included) can reach it. (= J28D B2-3; J28V-8 first clause (B2-a).) [hand; two derivations, J28D and J28V blind]**
*Proof:* J28D §Stage 4 B2-3 (with T-A1); J28V §2.4 (B2-a: every return-time set of R88-TA (v) lies in finitely many translates of `D`). *Proof verdict:* closes. *Rests on it:* the division of labour between T-C (measures) and T-B2 (transience); the T-C′ stub's note that a full classification
of invariant measures would still leave Q-tr. *Prior art:* via R88-CL (in print); the statement not found. *Kernel:* declined.

**R88-J28V-8d — A defect set against a pullback lies in no finite union of cosets of any finitely generated subgroup of `R`: each residue class of `U` is infinite and bounded in `L ⊗ ℝ`, while a finite union of cosets of a discrete finitely generated subgroup has finite bounded part. [hand; one mind (J28V)]**
*Proof:* J28V §2.4 (B2-d). *Proof verdict:* closes (one mind). *Rests on it:* why no lattice-quotient argument reaches T-B2. *Prior art:* not gated
(elementary). *Kernel:* declined.

## §G. Stated and not proved — the two gaps, and the remainder (no truth claims; not entries)

- **T-B1 (isolation) — GAP in both records, at the same step.** "Over a type-(B) field, every point of Pull is isolated in `X₄(F)`: for each
  `p ∈ Pull` there is a finite `B ⊂ R` such that every `c ∈ X₄(F)` with `c|_B = p|_B` equals `p`." (plan §S.1). **The named step:** unique
  continuation from a region that is no archimedean half-space (J28V §Stage 5 row V18). J28D closes the archimedean-dominated re-centring case by
  Theorem H and isolates the split-dominated one: the re-centred region is `{w : |w + z_n|_v < |z_n|_v}`, an ultrametric sphere with empty liminf,
  and "no ultrametric analogue of H is available from a finite set"; its pinned bootstrap stops at the discreteness of `T(O_S)` in
  `∏_{v∈S} T(F_v) × (S¹)²` (`plans/FS86-C-deBruijn.md` §7.5). J28V: isolation is a conditional finite-forcing statement and H needs a half-space a
  finite `B` does not supply. **[reading] (J35 §Stage 5):** in Boyle–Lind's language archimedean half-spaces are expansive at Pull and no split-place
  half-space is; for algebraic actions Einsiedler–Lind–Miles decide expansiveness by the amoeba at all places — vocabulary, not a transferable
  theorem (`X₄(F)` is not algebraic and `R` is not finitely generated). A FALSE answers row 88 "no" (R88-TA2).
- **T-B2 (defect propagation) — GAP in both records, at the same step.** "Over a type-(B) field, if `c ∈ X₄(F)`, `p ∈ Pull` and
  `D = {z ∈ R : c(z) ≠ p(z)}` is non-empty, then `D` has positive upper Banach density in `R`." (plan §S.1). **The named step, B2-growth:** from
  propagation (R88-B2-1), iterated along colour-dependent chains, to `d*(D) > 0`; bounded chains are thin (R88-B2-2), density in `L ⊗ ℝ` is not
  Banach density in `R` (Følner sets of `R` are fine grids over ever more primes), and neither H, D/D′ nor T-C gives an expansion bound for the
  defect graph (J28V §2.4; J28V §Stage 5 row V19: "the same step"). T-B2 is Q-tr's single-pullback case (R88-B2-3). A FALSE answers row 88 "no".
- **T-C′ — the remainder of Q-μ, named, with no truth claim** (J28D §5.1). Beyond R88-TC, Q-μ needs every translation-invariant `μ` whose spectral
  measure is **(R1)** carried by `⋃_S (T + A + Fin_S)` but by no single one — the completion over all split places is their full product, Polish
  but not locally compact, so no Haar measure for the Fubini steps — or **(R2)** charges characters outside every `T + A + Fin_S` (reading
  infinitely many split places: HD1's infinite type). J28D's readings, one mind: the colouring constraint `σ̂|_U = −1/3` is linear in the Fourier
  coefficients and shows no mechanism forcing positive entropy for the `U`-action on `R̂`, so the positive-entropy measure-rigidity theorems
  (Rudolph, A. Johnson, Host, Einsiedler–Lindenstrauss; none held) do not visibly apply and the zero-entropy case is Furstenberg's measure question's
  analogue; and the spectral measure of a merely translation-invariant `μ` is not `U`-invariant, so even a full classification of `U`-invariant
  measures would leave Q-μ open without T-B1-type isolation (the weak-* limit of `U`-averages can move mass onto Pull, the plan's §M.1).
  **Status (FS-100 wave 3b, `LEDGER.md` row 126): (R1) is closed given MR** — every translation-invariant `μ` has `σ_μ(E ∖ T₄) = 0`
  (`plans/FS100-derivation.md` FS100-X27D-E = X27V-TA + X27V-FS, two derivations blind; `T₄ = (R ∩ 𝔓⁴)^⊥`), so a spectrum carried by `E` is
  `T₄`'s and `μ` is a pullback (X27V-R1). Q-μ is then exactly (R2), and given MR it is TR-ROT itself, not a step inside it (FS100-X27D-EQ);
  X22D §2.4's "TR-ROT, the step C-1 needs" is C-1 itself given MR. What is left is NA₀ / COL-E (`plans/FS100-derivation.md` §G).

## §K. Kernel decisions, summarised

Nothing here is kernel-checked. One entry is routed to a kernel stub: **R88-J28V-7 → FS-47** (the finite-index lemma, by the rank argument). Every
other entry is declined: T-A's (v) and all of §2 rest on measure theory on countable amenable groups and LCA groups (Følner sequences, Bochner,
Doob, Lebesgue differentiation) that the kernel's surface does not hold, and §3's partials have no consumer until T-B2 is proved.

## Where the 2026-09-26 work on this lives

*Pointer block (consolidation job C1, 2026-09-26): addresses only — each result lives in its ledger row and derivation entry; the per-job index is `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`.*

See: `LEDGER.md` row 117 (`plans/FS100-derivation.md` FS100-T1); row 121 (`plans/FS100-derivation.md` FS100-Q47); row 124 (`plans/FS100-derivation.md` FS100-X22).
