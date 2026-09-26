# FS100 — the theorems of FS-100's in-ban round (Kronecker selection; T-C(A)'s class; the MR reading room), filed

*Home `FS100` (WORKFLOW step 9; `tools/fs71_ledger_b_check.py`). Filed by the close planner J53 (de Bruijn, Opus 5.5, 2026-09-26) from the
milestone's records: the plan `plans/FS100-three-field-lemma.md` (J51; its §R-close is the close), the derivation
`plans/FS100-J51D-derivation.md` (J51D) and the blind verification `plans/FS100-J51V-verification.md` (J51V). Every entry names its verification
status: **two derivations** (J51D and J51V, blind to each other — J51D fenced from J51V's files by the owner, J51V blind by brief), **one mind**,
or **one mind + a check**. Where the records differ, both are stated (the divergence table: the plan's §R-close 1.1). Prior-art verdicts are
J53's close-time gate (§R-close stage 2; `data/fs100/j53/gate.out`). Notation: `L = F(i)`, `R = ℤ[U_F] = O′` (Lemma C′, row 100), `R̂` its
dual, `T` torsion characters, `A = A(R_F)` archimedean ones, `Fin_S` those continuous at a finite set `S` of split places, `E_S = T + A + Fin_S`,
`E = ⋃_S E_S`; for `Θ : R → Tⁿ`, `K = cl Θ(R)`, `K̂′ = {m : m·Θ ∈ T + A}`, `K₀ = ann_K(K̂′)`, `K′ = K/K₀`; KS-1 to KS-5, KS-C, K0 verbatim in the
plan's §S.*

**The milestone's result in one paragraph.** Kronecker selection, as the plan fixed it (KS-1: every measurable proper four-colouring of
`Cay(K, cl Θ(U))` selects to one of `Cay(K′, cl π(Θ(U)))`, selecting onto the `T + A` combinations), is **false**, by one counterexample over ℚ
found by both minds; the saturation route (KS-3) is false for the same reason; the reduction behind it (KS-2) is true in an arithmetic-free form.
The failure is local at one split place — a unit vector is integral at one of the two conjugate primes above it — and it is an artefact of the
target `T + A`, not of the question: at ℚ(√47), given T-C(A), the selection, its corrected form onto `E`, and the pure-point layer's conclusion
are one statement, which stays **open** at a named density step. Separately, T-C(A)'s class among real quadratic fields is exactly the
conjecture's `L ≥ 5` family, and J45's SP-Cor holds over the class, so MR would give five colours at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47).

## §1. The selection claims

**FS100-L0 — Purity and continuity: `T + A` and `E` are pure subgroups of `R̂`, so `K̂′` is a direct summand of `ℤⁿ` and, after a unimodular change of basis, `Θ = (Φ, B)` with `Φ ∈ (T + A)^r`, `m·B ∉ T + A` for `m ≠ 0`, and `K/K₀ ≅ cl Φ(R)`; `cl π(Θ(U)) = π(cl Θ(U))`; for measurable `W`, properness at every `s ∈ Θ(U)` gives it at every `s ∈ cl Θ(U)`, and `x ↦ W(Θ(x) + t)` is proper for a.e. `t` iff `W(t) ≠ W(t + Θ(u))` for a.e. `t` and every `u`. (= J51V-L0, L1, L2; J51D §M.2's purity of `E`.) [hand; two derivations, blind to each other]**
*Proof:* J51V §2.0 (`kθ = τ + α` gives `θ − α/k ∈ T`); J51D §M.2 (`A` and `Fin_S` divisible). *Proof verdict:* closes, twice. *Rests on it:*
FS100-C45, FS100-N1, the plan's §R-close ruling 1, FS100-R's splitting `Γ = Γ_E ⊕ Γ_∞`. *Prior art:* standard (pure subgroups of abelian groups;
continuity of `s ↦ ⟨1_A, 1_A(· + s)⟩`). *Kernel:* declined — measure theory on compact groups off the kernel's surface, and no consumer.

**FS100-KS2 — KS-2, in an arithmetic-free form: let `K` be a compact metrizable abelian group, `C ⊆ K` closed, `H ≤ K` a closed subgroup with `C + H = C`; if `W : K → {0,1,2,3}` is measurable and, for every `s ∈ C`, `W(t) ≠ W(t + s)` for a.e. `t`, then the essential colour sets `S(t)` on `H`-cosets are disjoint on `C`-adjacent cosets, and any measurable selection `W′(q(t)) ∈ S(t)` is proper on `Cay(K/H, q(C))`; the selection iterates along a chain of saturating subgroups. So KS-sat ⟹ Kronecker selection. (= J51D-T1; J51V-KS2; J51-T3's sketch, written out.) [hand; two derivations, blind to each other]**
*Proof:* J51D §2.1 (Fubini and the change of variables `(t, h₁, h₂) ↦ (t + h₁, h₂ − h₁)`, the step J51-T3 left unwritten); J51V §2.3 (Tonelli,
Weil's formula, a Borel section). Different proofs of one Fubini argument. *Mutation:* drop `C + H = C` and the conclusion fails (FS100-X1's `C`,
with `H = K`). *Proof verdict:* closes, twice. *Rests on it:* FS100-R (KS-sat_E ⟹ KS-1_E); the plan's no-swap decision (§S head), whose premise
"KS-sat ⟹ selection needs no measure" it confirms. *Prior art:* **not found** as stated (J53's gate: `ab:"measurable coloring" & ab:"compact
abelian group"`, 0); a Fubini selection, likely folklore. *Kernel:* declined — Haar measure and Fubini on compact groups; no consumer beyond a
statement that is false in the form it was built for.

**FS100-CP — The conjugate-pair dichotomy: for every real number field `F` and every place `v = w w̄` of `F` split in `L/F`, (a) for every `u ∈ U`, `ψ_w(u) = 0` or `ψ_w̄(u) = 0` (`ι_w̄(u) = ι_w(u)⁻¹`, so one of them is integral); (b) no non-zero `m₁ψ_w + m₂ψ_w̄` lies in `T + A`. So the pair `(ψ_w, ψ_w̄)` sends every unit vector into the cross `(T × 0) ∪ (0 × T)`. (= J51D-T2; J51V-X1 step 1 and §2.5; the owner's check, inventory row 48.) [hand; (a) two derivations, blind, and the owner's check, and tools exact at ℚ; (b) one mind (J51D) in general, two at ℚ above 5]**
*Proof:* (a) J51D §2.2, J51V §2.4 step 1 (one line from `u ū = 1`); (b) J51D §2.2 by strong approximation with a second split place omitted;
J51V §2.4 step 3 at ℚ by the subring `R₀` and orders `5^k`. *Tools:* `tools/j51d_or_check.py` D1 (25,492 rational unit vectors of height
`≤ 20,000`; 4,256 non-zero in each coordinate, none in both; plant P1, the place above 13, fires with 48 joint non-zeros); `tools/j51v_cross.py`
C1 (3,920 unit vectors, 1,272 with a pole above 5; plant `same-prime` fires, 865 failures). *Proof verdict:* closes. *Rests on it:* FS100-X1,
FS100-KS3, FS100-X2B. *Prior art:* (a) **textbook** — the norm-one torus at a split place is `F_v^×` embedded as `y ↦ (y, y⁻¹)`; in this project FS86-Cx-C1
(the plane in the hyperbola graph at every split place) and, in print, `[BardestaniMallahiKarai2017]` §3.2 (the split-place hyperbola) — added
by J53b's §PA sweep; (b) strong approximation for `L`, standard. Filed for its use, not as a new fact. *Kernel:* declined — no consumer in the kernel's surface.

**FS100-X1 — KS-1 is false: over `F = ℚ` (`R = ℤ[i][1/q : q ≡ 1 (4)]`), with `τ` the dyadic parity character (`τ(U) = {1/2}`) and `w, w̄` the places above 5, `Θ = (τ + ψ_w, τ + ψ_w̄)` and `W(t₁, t₂) = 2⌊2t₁⌋ + ⌊2t₂⌋` satisfy KS-1's hypothesis (every `Θ(u)` has a coordinate equal to `1/2`, so `W(t) ≠ W(t + s)` for every `t` and every `s ∈ cl Θ(U)`) while `K̂′ = 0`, so `K′ = {0}` and no `W′` exists. The same holds over every real number field with a stable dyadic place ramified in `L/F`, i.e. with `χ(F²) = 2`; and `0 ∉ cl Θ(U)` does not force any non-zero `m·Θ` into `T + A` (no naive vector form of band rigidity). (= J51V-X1, X2 (a), X2 (c); J51D-T3.) [hand + tools exact; two derivations — J51V blind; J51D's construction committed before any disclosure, its write-up possibly informed that the verifier had refuted some claim; the owner's hand check a third mind, not blind]**
*Proof:* J51V §2.4 (steps 1–4); J51D §2.4 (via FS100-CP). The two `W` are the same function. *What it is:* `x ↦ W(Θ(x) + t)` is the parity
two-colouring written twice, each copy hidden inside a character that is not in `T + A`; its spectrum lies in `E_{{5}}`, so it has a finite-place
proper factor (itself) — **it is not in the gap**, not over ℚ(√11), and not "the first control the gap has ever had" (J37 §4.3 (d)'s qualifier,
J51D §1.2 B5). *Tools:* `tools/j51v_cross.py` (C1–C4; plants `same-prime` and `no-parity` fire, exit 1; re-run by the owner: ALL CHECKS PASS,
exit 0, inventory row 48); `tools/j51d_or_check.py` D2–D4 (plants P1, P2 fire; `data/fs100/j51d/or_check.out`). *Independence* (the plan's
§R-close ruling 2): J51D's §M.1 committed the construction at `aa12db5e` (23:58:31) and priced KS-1 FALSE 0.80 at `2654b675` (23:59:22), before
`3648d3a5` (00:01:16) put "counterexample" in a subject it could read (owner error, inventory row 52). One object found twice; the `K̂′ = 0` step
proved two ways. *Proof verdict:* closes. *Rests on it:* the refutation of the plan's stage-4 lemma as stated; FS100-KS3; the re-aim of
FS-100 stage 4 and of FS-64 (to the `E`-form); the discriminating control every future selection statement must pass (J51V §3.4 item 2).
*Prior art:* **not found** (J53's gate: measurable and Borel chromatic numbers of Cayley graphs on compact abelian groups; Kronecker factors and
discrete spectrum with colouring; measurable Hedetniemi — no hit bears); its ingredients are textbook (FS100-CP (a); the co-normal product's
`χ(G)χ(H)` bound). *Kernel:* declined — the object lives on `R̂`; its combinatorial core (the cross and the bit flip) is two lines.

**FS100-X2B — The `k²`-colour analogue of KS-1 fails over every real number field: with any band character `θ` (`I = cl θ(U) ∌ 0`), a `k`-colouring `g` of `Cay(T, I)` and a split place `v = w w̄`, `Θ = (θ + ψ_w, θ + ψ_w̄)` has `cl Θ(U) ⊆ (I × T) ∪ (T × I)`, `K̂′ = 0`, and `(g(t₁), g(t₂))` is a proper `k²`-colouring; take `k = χ_char(F²)`, finite by CLG. At four colours the mechanism needs `k = 2`, a bipartite plane, so over ℚ(√47) it is unavailable. (= J51V-X2 (b), (d).) [hand; one mind (J51V)]**
*Proof:* J51V §2.4 "How far it reaches". *Reading beside it* (J51V §3.2 [reading]): the map lands in the co-normal (disjunctive) product
`Cay(T, I) ∗ Cay(T, I)`, which is `χ(G)²`-colourable; killing test of the reading that this is the only cheap mechanism — a four-colouring
`W(Θ(x) + t)` over a field with no two-colour `T + A` character and `K̂′` too small to carry it, which at ℚ(√47) would falsify the conjecture.
*Proof verdict:* closes (one mind). *Rests on it:* the scope of any future selection at five colours (J51V §3.4 item 2: `k = 2` gives four colours
`≤ 5`). *Prior art:* the co-normal product bound is classical (J53's gate: Körner–Pilotto–Simonyi 2005; Akgüneş 2018; Fritz 2021 on the
disjunctive product); its use here not found. *Kernel:* declined.

**FS100-KS3 — KS-3 is false over every real number field: `Θ = (ψ_w, ψ_w̄)` at any split place has `Γ ∩ (T + A) = 0`, `K = K₀ = T²` and `cl Θ(U) ⊆ (T × 0) ∪ (0 × T) ≠ T²`, so KS-sat fails at `s = 0`. Over ℚ(√11), `Θ = (θ_{C9}, ψ_w, ψ_w̄)` makes it non-vacuous: `W = ⌊4t₁⌋` is proper, KS-sat fails on every fibre, and KS-1's conclusion holds with `W′ = ⌊4·⌋` — so KS-sat is not necessary for KS-1. (= J51D §2.3; J51V §2.5.) [hand + tools exact; two derivations, blind, for the counterexample; the non-necessity clause one mind (J51D)]**
*Proof:* J51D §2.3; J51V §2.5 (also with the parity added, FS100-X1's example). *Proof verdict:* closes. *Rests on it:* the no-swap decision's
premise (the plan's §S head: "confidence medium; it changes if J51D finds KS-sat false while Kronecker selection is true") — **its trigger fired
in the letter** (KS-sat false while KS-1 holds on the ℚ(√11) instance) **but not in its sense**: the failure is closed-set and local (a union of
subgroups, J53's §PA reading), not measure-theoretic, so stage 6 does not take the slot (§R-close stage 4). *Prior art:* the orbit closure is a
union of closed invariant subgroups — "topological rigidity" in Berend's and Lindenstrauss–Wang's sense (LW2012's review, read) — so KS-sat asked
for more than rigidity gives; as a statement about KS-sat, not found. *Kernel:* declined.

**FS100-N1 — KS-1 at `n = 1` holds over every real number field, given row 98: if `θ ∉ T + A` and a proper `W` existed, `0 ∉ cl θ(U)`, so `θ` is a band character and row 98 puts it in `T + A`; if `θ ∈ T + A`, `K′ = K` and `W′ = W`. (= J51V-N1; the selection-level form of T-J37-1.) [hand; one mind (J51V)]**
*Proof:* J51V §2.4, last paragraph. *Proof verdict:* closes. **Not the same statement as FS100-T4/T5** (KS-3 at `n = 1`, a density statement):
N1 follows from density and does not imply it (the plan's §R-close ruling 1). *Rests on it:* FS100-EQ's `n = 1` clause. *Prior art:* a corollary
of row 98 (`[Manners2015]`'s pyjama lemma is row 98's prior art on the half ring). *Kernel:* declined.

**FS100-T4 — Inside `E`, rank one saturates: for every real number field and every `θ ∈ E ∖ (T + A)`, `cl θ(U) = T`. (= J51D-T4.) [hand; one mind (J51D)]**
*Proof:* J51D §3.1 — `θ(u)` reads `u` at `∞`, finitely many stable places and `S`; `U` is dense in that finite product (weak approximation,
FS91-J10-L2); letting `|ι_w(u)| → ∞` at one place of `S` sweeps `ψ_v(c_w x)` over `p^{−k′}`-dense sets. *Proof verdict:* closes (one mind).
*Rests on it:* the rank-one half of FS-100's corrected stage 4. *Prior art:* weak approximation for the norm-one torus (FS91-J10-L2's
citation); the statement not searched separately. *Kernel:* declined.

**FS100-T5 — At `F = ℚ`, rank one saturates everywhere: for every `θ ∉ T + A`, `cl θ(U) = T`. (= J51D-T5.) [hand; one mind (J51D); a composition of FS89 lemmas held at two derivations (PA-B2) and one (VB1's mechanism, SW-m)]**
*Proof:* J51D §3.1 — reduce to `R_S`, `|S| ≥ 2`; minimal subsets of `cl(U_Sθ)` either fill `R̂_S` or lie in `T + A` (PA-B2, band-free); VB1's
proof gives a ball of translates; the sweep SW-m run at an arc instead of at 0. *For general `F` off `E`:* **GAP** at the field form of PA-B2 and JC
over `R_{F,S}` (row 98's field gluing uses a torsion-order bound only the band supplies; J51D's example `θ = ψ_w` above 3 at ℚ(√47)). *Proof verdict:*
 closes at ℚ (one mind); GAP stated, not an entry. *Rests on it:* P-sat1's score. *Prior art:* its inputs are `[Berend1984min]`,
`[Wang2012]` (PA-B2's architecture, Prop. 4.3 with Lemma 4.2) and `[Manners2015]` as filed at FS-89; not searched separately. *Kernel:*
declined.

**FS100-R — The reduction of the corrected saturation: KS-sat_E (`s + ann(Γ ∩ E) ⊆ cl Θ(U)` for every `s ∈ cl Θ(U)`) holds for all `Θ` iff, for every finitely generated `Φ` independent off `E` and every neighbourhood `N` of 1 in `U` for the topology of finitely many places, `Φ(N)` is dense in `T^k`. It is stopped at one named step (stated, not proved): the characters of `Φ` read infinitely many split places, `g ∈ N` can be controlled only at finitely many places, and `U_{Σ′}` is discrete in `∏_{Σ′}` (no strong approximation for the anisotropic norm-one torus), so the values are sums over a cut-and-project set whose density is J37's "equidistribution statement for the `U`-values of an infinite-type character". (= J51D-R.) [hand; one mind (J51D)]**
*Proof:* J51D §3.2 (`Γ = Γ_E ⊕ Γ_∞` by purity, FS100-L0; `Γ_E(u₀g) ≈ Γ_E(u₀)` on `N`). *Proof verdict:* the reduction closes (one mind); its right
side is **open** — the milestone's GAP. The OR obstruction of FS100-CP does not arise off `E` (a `g` can have poles on the `w`-side at one place and
the `w̄`-side at another), so no FALSE is in sight. *Rests on it:* FS-100 stage 4's re-aim (the stub). *Prior art:* the nearest literature is
topological self-joinings (Lindenstrauss–Wang 2012, zbMATH review read: rigid for Cartan `ℤ^r` actions with `r ≥ 3`, **not** for `r = 2`) and
`[Wang2012]`; neither applies (FS100-T2), and LW's "not for `r = 2`" is a warning that diagonal rigidity can fail at low rank. *Kernel:* declined.

**FS100-EQ — KS-C, and what it is worth: over ℚ(√47), KS-1 at ℚ(√47) together with T-C(A) at `S = ∅` implies that no four-colouring of the plane has the form `x ↦ W(Θ(x) + t)` (X); the same with KS-1_E (selecting onto `Γ ∩ E`) and T-C(A) at every finite `S`; and over any real number field where T-C(A) holds at `S = ∅` (resp. at every finite `S`), KS-1 at `F` ⟺ KS-1_E at `F` ⟺ X at `F`. X holds for `Θ ∈ Eⁿ` and at `n = 1`; for `n ≥ 2` with a combination outside `E` it is open. (= J51V-EQ and J51V §2.6; J51D-C, J51D §3.3.) [hand; two derivations, blind to each other; the `E`-form one mind (J51D)]**
*Proof:* random placement: `c_{t′}(x) = W′(πΘ(x) + t′)` is proper for a.e. `t′`, translation-invariant, with spectrum on `{m·Θ : m ∈ K̂′} ⊆ E_S`,
which T-C(A) forbids (J51V §2.6; J51D §3.3). ⟸ of the equivalence: if X holds, no proper `W` exists (FS100-L0) and KS-1 holds vacuously. *Proof verdict:*
 closes. *What it means:* a selection lemma cannot be an independent input at ℚ(√47) — "whatever it uses would already prove X" (J51V);
the refutation "costs the milestone its uniform lemma, not its target" (J51D). KS-C as a material conditional with KS-1's universal antecedent is
vacuously true (J51V: "hollow"). *Rests on it:* FS-100 stage 4's re-aim; FS-64's four-colour clause. *Prior art:* an instance of the
Furstenberg-correspondence reading of R88-TCA; not searched separately. *Kernel:* declined.

**FS100-C45 — The two controls hold and cannot fail: over ℚ(√11), with `θ_{C9}` row 94's character plus an archimedean term below `1/28`, KS-4 (`Θ = (θ_{C9}, θ₁)`) and KS-5 (`Θ = (θ_{C9}, θ_{C9} + θ₁)`), `θ₁ ∉ E`, `W = ⌊4t₁⌋`, satisfy KS-1's conclusion with `W′ = ⌊4·⌋`; in KS-5 `K′` is the closure of the image of `θ_{C9}`, via the first coordinate. Both pass whatever `θ₁` is, because `W` factors through `π`: their failure outcome is unreachable. (= J51D §2.5; J51V-K4, K5.) [hand + tools exact; two derivations, blind — both minds found the controls uninformative]**
*Proof:* J51D §2.5; J51V §2.1–§2.2 (`θ_{C9}(U) ⊆ [1/4, 3/4]` from `2x + 3y ∈ {2,3,4,5}` on the 8 points of the `𝔽₇` circle; J51V's C5, J51D's P3
fire). *Proof verdict:* closes; **uninformative** (G21: a control of the wrong shape; the discriminating control is FS100-X1). *Rests on it:*
nothing (the controls' purpose failed). *Prior art:* none needed. *Kernel:* declined.

## §2. T-C(A)'s class, K0, and the reading room

**FS100-T1 — For a real quadratic field `ℚ(√d)`: every stable place of `ℚ(√d, i)` has all-levels four-colour ratio `< 1/4` (T-C(A)'s class, R88-TCA's class form) ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L(ℚ(√d)) ≥ 5`; so ℚ(√143), ℚ(√311), ℚ(√335) and ℚ(√167) are in the class, ℚ(√59) and ℚ(√11) are not. (= J51-T1.) [hand + tools exact; one mind (J51); the three fields' membership re-derived by J51V (not blind: fence breach, inventory rows 46, 49) and by J53's Legendre re-check]**
*Proof:* the plan's §1.4 — a place is stable iff it does not split in `L/F`; odd stable places have ratio `< 1/4` except at `p ∈ {3, 7}` (FS-66's
certificates at 11 and 19 at every level of the unramified and ramified towers, Lemma P (ii); Hoffman at 23 and 31 with Lemma P (i); Weil +
Hoffman + Lemma P from 37); a stable dyadic place is Hoffman-tight at `1/4` (row 67) or ramified (ratio `1/2`); the dyadic place is non-stable iff
`d ≡ 7 (mod 8)`. *Tools:* `tools/j51_tca_class.py` (`data/fs100/j51/tca_class.out`; plant: a wrong dyadic test that moves ℚ(√59) into the class —
fires, `tca_class_plant.out`); `tools/j51v_class.py` (controls ℚ(√47) in, ℚ(√59), ℚ(√11), ℚ(√23), ℚ(√31) out; plant `forget-seven` fires on
ℚ(√23)). *Proof verdict:* closes (one mind + two checks). *Rests on it:* FS100-K0's field list; FS-100's §IQ item 5; the correction to J43's facts
file (inventory row 11). *Prior art:* the congruence family `L ≥ 5` is `CLAUDE.md` G61's, from `[Fischer1990]` Thm 10 (held, read); **the
identification with T-C(A)'s class is ours** (its terms are this project's; J53's gate: `"chromatic number" & "quadratic field"` and `"unit
distance" & "quadratic field"`, 0). *Kernel:* declined — the class rests on FS-66's certificates and Lemma P, not on a kernel-shaped statement.

**FS100-K0 — J45's SP-Cor and A⁺ at `S = ∅` hold, with J45's proofs, over every real number field where T-C(A) holds at `S = ∅`; in particular over ℚ(√143), ℚ(√311), ℚ(√335): if every finite positive `U`-invariant `E`-null measure on `R̂` is a multiple of Haar measure, the plane needs five colours. A⁺ at a finite `S ≠ ∅` needs T-C(A) at that `S`, which R88-TCA's class form supplies. (= J51V-K0, with its scope note; plan claim K0.) [hand; one mind (J51V) + a one-step check (J53, not blind); class membership FS100-T1; resting on R88-TCA's class form, one mind outside ℚ(√47)]**
*Proof:* J51V §2.7; J53's check, the plan's §R-close 1.1 ruling 3 — SP-Cor's proof (J45 §4.2) uses an `R ⋊ U`-invariant measure (every real
number field), `U`-invariance of `σ_μ` (field-free), R-U (J45: every real number field) and A⁺ at `S = ∅` (SI-4, N2 field-free; T-C(A)@∅), and
nothing else; R88-TCA's input list at ℚ(√47) ("11 and 19 by FS-66, the tail by Hoffman — the maximum 31's `1/4 − 2.745·10⁻⁶` —, the ramified 47 by
Lemma P, the real places `m₁`, split places 0") has its analogue at each of the three fields (11 ramified at ℚ(√143) through Lemma P (ii); 11 and 19
split at ℚ(√311); 11 split at ℚ(√335); 23, 31 by Hoffman; the ramified 311 and 67 by Weil + Lemma P). *Proof verdict:* closes at the stated
scope. *Rests on it:* the `CLAUDE.md` Frontier's item 10 (the three fields join ℚ(√47) as MR's instances); FS-100's §IQ item 5. *Prior art:* none
beyond J45's and R88's. *Kernel:* declined (as SP-Cor).

**FS100-T2 — For every real number field `F` and every finitely generated subgroup `Γ ⊂ U_F`, `ann(ℤ[Γ])` is a proper, infinite, closed, `Γ`-invariant subgroup of `R̂`: `ℤ[Γ] ⊆ O_L[1/N]` inverts finitely many primes while `R = O′` inverts infinitely many, so `R/ℤ[Γ]` is infinite. So no such `Γ` acts irreducibly on the solenoid `R̂`, and Einsiedler–Lindenstrauss's Theorem 1.2 (EL2003 Thm 1.1) never applies. (= J51-T2.) [hand; one mind (J51)]**
*Proof:* the plan's §PA.3 (two lines). *Proof verdict:* closes (one mind). *Rests on it:* the card's answer "first yes, second no" (the plan's
§PA.3, a reading: EL2021 Thm 1.3 is the in-print statement that can apply, modulo the owed lemma PE-lim); FS100-R's prior-art note. *Prior art:*
the definitions and Thms 1.1–1.3 are `[EinsiedlerLindenstrauss2022]` §1 (held since J23p; read at §1); the observation for `U_F` not found (J51's
negative: `ab:"solenoid" & ab:"invariant measure" & (ab:"S-adic" | …)`, 0). *Kernel:* declined.

## §3. Stage 5 (the ×2×3 crunch, 2026-09-26)

*Filed by the close planner X09C (de Bruijn, Opus 5.5) from the records `plans/FS100-X01D-derivation.md` (X01D), `plans/FS100-X01V-verification.md`
(X01V, blind; its stage 4 a non-blind reading), `plans/FS100-X12B-derivation.md` (X12B, blind to X01D), `plans/FS100-X02D-derivation.md` (X02D),
`plans/FS100-X02V-verification.md` (X02V, blind to X02D and X03D), `plans/FS100-X03D-derivation.md` (X03D), `plans/FS100-X05V-verification.md` (X05V,
blind to X03D) and `plans/FS100-X13R-check.md` (X13R, a non-blind reading of X03D §4). Reconciliation and the headline ruling: the plan's §R-close
(stage 5), stages 1–1b. Notation as §1; `U_ℚ = {(a+bi)/c : a² + b² = c²} ⊆ U_F`; `h_μ(u)` the entropy of `χ ↦ u·χ`; `m` Haar probability on `R̂`;
**admissible** (= X02V's (★)): `Γ ⊂ U` generated by two independent elements with `ℚ(Γ′) = L` for every finite-index `Γ′ ⊆ Γ`.*

**The stage's result in one paragraph.** MR(F) — "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar" —
holds for every real number field `F` with `R_F = O′` (row 100: every `F` without a ramified stable dyadic place). It splits by entropy.
The positive-entropy half (PE-2) is Einsiedler–Lindenstrauss's Thm 1.2 on the finitely generated pieces `M̂`, applied only under admissibility,
which the queue's PE-1 omitted (false at ℚ(√47) and at ℚ(√5)). The zero-entropy half (EF_F⁺) is Einsiedler–Fish's pigeonhole, transferred with
the rational unit vectors as multipliers and the product formula as the Diophantine step: `U` has polynomially many elements of bounded height,
which is exactly EF's hypothesis; no finitely generated subgroup has it. With J45's SP-Cor and R88-TCA, **`χ(ℚ(√47)²) = 5`**. The one-sided flip (FL-1,
FL-2) does not reach a weaker consumer: it stops at a quantitative T-C(A) the spectral inputs cannot give, because the real place's `J₀` minimum
`−0.402759` lies below `−1/3`.

**FS100-EFP — EF_F⁺: for every real number field `F` (with `R = O′`), every `U`-invariant finite positive Borel measure `μ` on `R̂` with `h_μ(u*) = 0` for one non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`; hence EF_F. (= X01D EF_F⁺; X12B-EF + X12B-Z.) [hand; two derivations blind to each other (X01D; X12B), a checking reading by X01V (stage 4, after its blind stage-2 GAP at "UZ", withdrawn for a named reason), readings by the advisor (not independent: X01D writes out its sketch) and the close]**
*Proof:* X01D §3.1–3.8 (Lemma PF; an expanding place `v*`; Lemma 3.1′, SMB + Jacobs + Egorov; the pigeonhole over `V_M ⊆ U_ℚ`, `#V_M ≥ c₀M^{1/[F:ℚ]}`;
two scales, `z = ℓ₁e₂ − ℓ₂e₁ = 0` by the product formula; one division at `v*`; leaves and wandering shells). X12B §2.0–2.3 (the model
`R̂ ≅ 𝔸_S/𝔡⁻¹R`; Bowen sets on `X_Q`; the pigeonhole over `U_ℚ(X)`, `(4/π + o(1))X` elements; `ℓ = λ/(q₁ − q₂)` with polynomial height, stabilised
across `X, X², …` by the product formula; Lemma Z by `ord_w` and `u_w = α/ᾱ`). *Proof verdict:* closes, twice, by different Diophantine steps and
different treatments of the other places (the plan's §R-close stage 1b). *Tools:* `tools/x12b_multiplier_count.py` (the `U_ℚ` count at
`X = 5…1500`, plant fires). *Scope:* both proofs use the adelic model, which needs `R = O′` (row 100's Lemma C′); at its exception fields
(ℚ(√5), ℚ(√17), ℚ(α)) a GAP, not claimed. *Rests on it:* FS100-MR; the headline FS100-Q47; `§5` item 7 of the queue (T + A as the conclusion).
*Prior art:* the method is `[EinsiedlerFish2010]` Lemmas 3.1–3.2 (read in full by X01D, X01V, X12B and the advisor); its transfer to an `S`-adic
solenoid or a number field **not found** — X01D's four zbMATH queries (`ab:"polynomial growth" & ab:"invariant measure"` and variants with
solenoid, adelic, number field, S-adic; 0 relevant) and the citing works read (Huang 2017 §1, Huang–Li–Shi–Xu 2023 §1: circle and tori only);
Sataev 1975 (EF's Thm 1.2 first) unheld, unread. *Kernel:* declined — Kolmogorov–Sinai entropy, SMB and restricted-product duality are not on
Mathlib's surface; X11K's lane (Kooshi's request, 06:08) decides what of the chain it ports.

**FS100-EFZ — For every real number field `F` and every `U`-invariant finite positive measure `μ` on `R̂`: `μ(E ∖ (T + A)) = 0`; and a `U`-invariant finite measure carried by `L + Z_P` (`P` a non-empty finite set of places) is carried by `T + A`. (= X12B-Z, X12B-E; X01D Step 7; J45's R-U, J46-7.) [hand; R-U now three derivations, two blind to each other (J45, J46-7) and X12B's by valuations]**
*Proof:* X12B §2.1 (push to the adelic coordinates, `ord_w` equivariant, a finite measure on `ℤ ∪ {∞}` invariant under `k ↦ k + h` charges no
integer). *Rests on it:* SP-Cor's P4; the corollary MR ⟹ PE-2 (FS100-MR (c)). *Prior art:* the non-compactness of the split torus (J46-7's remark).
*Kernel:* declined (as FS100-EFP).

**FS100-PE1 — PE-1 is FALSE as written: over ℚ(√47), `Γ = ⟨v, u′⟩` (`v = (329+√−47)/(48√47)`, `u′ = (3+√−47)/(3−√−47)`) has `ℚ(Γ) = L` but an index-2 subgroup inside ℚ(√−47); over ℚ(√5), `Γ = ⟨(2+i)/√5, (5+12i)/13⟩` has an index-2 subgroup inside ℚ(i), and there Thm 1.2's conclusion fails too (`(m_{Y₁} + m_{Y₂})/2` is `Γ`-ergodic, of positive entropy, not Haar). PE-1′: for admissible `Γ` the action on `M̂` (`M ⊆ R` finitely generated over `ℤ[Γ]`, `ℚM = L`) is by automorphisms of a solenoid, totally irreducible (iff admissible), not virtually cyclic and without virtually cyclic factor, so EL2021 Thm 1.2 applies. Lemma W: every non-torsion `u ∈ U` lies in an admissible `⟨u, w⟩ ≅ ℤ²`, `w = z/c(z)`, `(z) = 𝔓ʰ` at a totally split prime. (= X02D-CX, X02D-C, X02D-PE1′, X02D-W; X02V-2, X02V-3.) [hand + tools exact; two derivations blind to each other, two counterexamples, one Lemma W found twice]**
*Proof:* X02D §2.2; X02V §2.2 (Lemma TI by Krull dimension one). *Tools:* `tools/x02d_pe1_counterexample.py` (plants `--plant-norm`,
`--plant-dependent` fire); `tools/x02v_checks.py` C1. *Rests on it:* FS100-PE2. *Prior art:* the definitions and Thm 1.2 are
`[EinsiedlerLindenstrauss2022]` §1 (read in full by X02D, pp. 1–3 by X02V); the subfield failure mode is the advisor's addendum. *Kernel:* declined.

**FS100-HX1 — For every real number field `F`, every closed `U`-invariant subgroup of `R̂` is finite or `R̂`: its annihilator is a `U`-stable subgroup of `R`, hence an ideal (`ℤ[U] = R`), and a non-zero ideal has finite index. (= X02D-HX1; X02V-1; X01V's held proof.) [hand; three proofs, two blind to each other]**
*Rests on it:* nothing in the chain (the advisor's stage-0 irreducibility remark). *Prior art:* `[LevitzMott1972]` Thm 2.3 for the finite index.
*Kernel:* declined.

**FS100-PE2 — PE-2 (PE-lim): for every real number field `F`, every `U`-invariant finite positive measure `τ` on `R̂` is `a·m + τ′`, `a ≥ 0`, `τ′` `U`-invariant with `h_{τ′}(u) = 0` for every `u ∈ U`; equivalently every `U`-ergodic `ν` is `m` or of zero entropy for every `u`. (= X02D-LΓ, X02D-PE2; X02V-4.) [hand; two derivations blind to each other, by different routes, both applying EL2021 Thm 1.2 by statement only on admissible `Γ` — E1 external, in print, its proof in EL2021 §§2–9, unread here]**
*Proof:* X02D §3.1–3.2 (Lemma Γ: a `Γ`-ergodic measure on `R̂` is `m` or of zero `Γ`-entropy, via the increasing factors `M̂_k`; `U` permutes the
`Γ`-ergodic components); X02D §3.3 (a second route on `M̂_k`, one mind with the first); X02V §2.3 (reduction to `U`-ergodic `τ`; on each `M̂_j` a
`Γ`-ergodic decomposition, uniqueness by Lemma H, a Haar mass constant up the inverse system, extension, extremality). *Proof verdict:* closes,
twice. *Rests on it:* FS100-MR. *Prior art:* PE-2's shape is Johnson's nonlacunary theorem (1992, review only) transposed; **EL2021 §2 ("Actions
on adelic solenoids") is unread and may already contain the inverse-limit step — no novelty claimed until it is read** (X02D §4.4). *Kernel:* declined.

**FS100-MR — MR(F) holds for every real number field `F` with `R = O′`: (a) PE-2 ∧ EF_F⁺ ⟹ MR(F) (`τ = a·m + τ′`, `τ′ ≤ τ` carried by `T + A ⊆ E`, `τ(E) = 0`, so `τ′ = 0`); (b) given PE-2, MR(F) ⟺ every `U`-invariant `E`-null `τ` of zero entropy for every `u` is 0; (c) given R-U, MR(F) ⟺ PE-2(F); (d) every `U`-ergodic `μ` with `μ(E) = 1` has zero entropy for every `u`. (= X01D EF-MR first half, Corollary MR⟺PE; X01V-T5, T6, §4.3; X02V-8; X12B-MR.) [hand; (a) a composition, three minds (X01D, X01V, X12B); (b) X02V; (c) X01D, one mind; (d) X01V; resting on FS100-PE2 and FS100-EFP at their grades]**
*Proof:* X01D §4.1, §4.3; X01V §2.4, §4.3; X02V §3.2; X12B §3.2. MR uses neither R-U nor `m(E) = 0`. *Rests on it:* FS100-Q47; FS100-K0's fields;
the stub's three wanted posters. *Prior art:* as FS100-EFP and FS100-PE2. *Kernel:* X11K's lane.

**FS100-Q47 — `χ(ℚ(√47)²) = 5`. Consequences at their grades: `χ(F²) = 5` at ℚ(√143), ℚ(√311), ℚ(√335) (K0; 11 usable at each, so `χ ≤ 5`); `χ(ℚ(√167)²) ≥ 5` (FS100-T1 puts it in T-C(A)'s class, K0's argument applies); at ℚ(√59), ℚ(√83), ℚ(√131), row 88 ⟺ T-B1 (T-J38-2 (iii)). (EF-MR's second half; X01D §4.1, X01V §2.4 part 2; X05V-1, X05V-2.) [hand; at ℚ(√47): FS100-MR at its grade; SP-Cor three minds (J45; J46-13 from its statement; X05V blind) over N1, N2, R-U, A⁺ each two blind minds (J45; J46-1, J46-7, J46-5); T-C(A) at `S = ∅` two blind (J28D, J28V; row 113); `χ ≤ 5` row 52 at 11 (`47 ≡ 5² (mod 11)`), prior art `[Moorhouse2010]`, `[Madore2015]`. The consequences carry K0's and R88-TCA's class form's one-mind grades (FS100-K0, FS100-T1)]**
*Proof:* the ladder, the plan's §R-close stage 1, 1.2 (L1–L6), no link broken. *Tools:* `tools/x05v_checks.py` (KC check 5, the MR step exercised at
`a = 2/21` on J45's F2 colouring over ℚ(√11); plants fire). *Control (KC):* at K and ℚ(√11), where four-colourings exist, the chain stops exactly at
T-C(A) (X05V-3; X01D §4.2). *What it answers* (`CLOSED-QUESTIONS.md` §1.7, §3): Moorhouse's "What about `χ(ℚ(√47)²)`?"; the existence half of
Soifer's Open Problem 55.1, **non-constructively** (the plane has no unit triangles, G57; de Bruijn–Erdős gives a finite five-chromatic subgraph,
none exhibited); Exoo–Ismailescu's smallest-subfield question in part (ℚ(√47) is the first real quadratic field needing five). *Prior art:* **a
gate on the value is owed** (the posers' author listings in zbMATH, the Polymath16 threads) before any novelty or publication claim. *Kernel:*
X11K's lane (Kooshi's request); nothing of the chain is kernel yet.

**FS100-EFG — For `u ∈ U`, `h_m(u) = Σ_v log max(1, |u|_v)` over all places of `L` (the finite ones in `supp u`); `= log H(u)` for totally real `F`. EF-G (a) is FALSE for `F` with a complex place: over ℚ(∛2), a non-torsion relative unit has `H = 1 < exp h_m` (X01D's `u₀`; X01V's `u = (1+∛2 i)/(1−∛2 i)`, `h_m = log 5 + 2.4658… > log 5 = log H`); `U_N` is then infinite (rank `r₂(F)`). EF-G (b) holds (`#U_N ≥ c·N^{1/[F:ℚ]}` via `U_ℚ ⊆ U_F`). (= X01D EF-G; X01V-T1, T2, T3; X12B-G; X02V's C2.) [hand + tools exact; four minds, three blind to one another]**
*Tools:* `tools/x01d_unit_check.py`, `tools/x01v_entropy_check.py` (Sturm count; its first certificate could not fire, replaced before any
verdict), `tools/x02v_checks.py` C2. *Rests on it:* the owner's ruling that claim lists say "totally real" where they mean it (inventory 16).
*Prior art:* the entropy formula is Lind–Ward 1988 and Chothi–Everest–Ward 1997's (cited from memory, unread — a debt). *Kernel:* declined.

**FS100-EFX — Over every real `F`, normalised arc length on a circle of archimedean characters at one complex place of `L` over a real place of `F` is `U`-invariant, `U`-ergodic, atomless, of zero entropy for every `u`, carried by `A`. So EF_F's conclusion cannot be finite support. (= X01D EF-X; X01V-T4.) [hand; two blind]**
*Rests on it:* FS100-CE1's refutation of (H). *Kernel:* declined.

**FS100-CE1 — CE-1 is TRUE as an implication and void: its hypothesis (every ergodic measure of a totally irreducible, not virtually cyclic ℤ²-solenoid action is Haar or finitely supported) is FALSE for the actions PE-1′ produces over every real `F` (a rotation circle at a complex place over a real embedding; Fourier coefficient `J₀(2π) ≠ 0`, atomless). Under it, every `U`-invariant `τ` with `τ(T) = 0` would be a multiple of Haar — refuted by FS100-EFX. Lemma LT: `⋂_{Γ admissible}{χ : χ|_{ℤ[Γ]} of finite image} = T`, given `R = O′`. (= X02D-HF, X02D-LT; X02V-5.) [hand; the implication two blind minds; the hypothesis's falsity X02D (numeric sanity `tools/x02d_circle_measure.py`), confirmed by X02V's own strengthened conclusion against FS100-EFX; LT one mind (X02D), with X02V §2.4 Step C the same intersection]**
*Correction owed:* X02V §3.2's "MR … is no harder than that classical open question" — (HF) is false, not open. *Kernel:* declined.

**FS100-FR1 — For every real `F`, the `U`-orbits on `R ∖ 0` are the non-empty fibres of `x ↦ x x̄`; so `τ` is `U`-invariant iff `τ̂` is constant on them. (= X03D-FR1; X02V-6.) [hand; two blind]** *Kernel:* declined (one line each way).

**FS100-ED1 — If `Y_N ⊆ U` are finite and every `χ ∉ E` has `(1/#Y_N)Σ_{Y_N} χ(u) → 0`, then MR(F); so ED-1 is TRUE wherever `U_N` is finite (every totally real `F`) and ill-posed as written when `F` has a complex place. (= X03D-ED1, ED1-R; X02V-7.) [hand; two blind]** *Kernel:* declined.

**FS100-ED2 — ED-2 is FALSE: over ℚ, for every infinite set `P′` of primes `≡ 1 (mod 4)` with `Σ_{P′} 1/p < ∞`, `χ_{P′}(r) = ∏_{p∈P′} e({ι_{π̄_p}(r)}_p)` is a character of `R` outside `E` whose averages over `U_N` tend to `∏_{P′}(1 − 1/p) ≠ 0`. Also X03D-Z (no `U`-invariant finite measure charges the summable set `Z` off `T + A`) and X03D-ED1′ (Weyl averages → 0 off `Z ∪ E` would give MR(ℚ); a GAP at the mean value for non-summable split characters). (= X03D-ED2, Z, ED1′.) [hand, on one classical input (Gaussian lattice points in residue classes, Möbius, Hilbert 90, CRT); one derivation (X03D) + a checking reading (X13R, not blind), which found both VALID]**
*Tools:* `tools/x03d_weyl.py` (finite-`P′` averages as floats at tolerance `5·10⁻³`; three defects logged by X13R: a mislabelled plant, a PASS
line blind to its five largest primes, a plant that fires by `0.24·10⁻³`); `tools/x13r_check.py`. *Rests on it:* nothing in the chain — it
shows equidistribution is strictly stronger than rigidity here (the advisor's Nazarov warning, EF §4). *Kernel:* declined.

**FS100-FLK — The example invariant of an actual four-colouring's spectrum (G79): for every rotation-invariant random proper four-colouring over a real field, `ν := σ|_{R̂∖E}` has `ν̂(u)/ν(R̂) = −P(c¹(0) = c²(u))/P(c¹(0) ≠ c²(0))` (the relatively independent self-joining over the `E`-factor); over ℚ(√47), given T-C(A) at `S = ∅`, `τ₀ = σ|_{R̂∖E} ≠ 0`, not a Haar multiple, with `τ̂₀(u) ≡ −(4/3)Σ_j E[p_j(0)p_j(u)] < 0` on `U`. (= X03D-FL-K, FL-1a; X05V-4.) [hand; two blind]** *Kernel:* declined.

**FS100-SPEC — Every `U`-invariant finite positive `ρ` carried by `T + A` has `ρ̂(1) ≥ −Λ(F)ρ(R̂)`, sharp, with `Λ(F) ≥ −J₀(j₁,₁) = 0.402759` over every real field (the real place); at ℚ(√47) `Λ = 0.402759` (11: 0.3996; 19: 0.3805). So no spectral route reaches `−1/3`. (= X03D-SPEC; X05V-6.) [hand + tools (float, with controls matching R88-TC-tab at 23 and 31); two blind]** *Tools:* `tools/x03d_factor_minima.py`; `tools/x05v_checks.py` checks 2b, 3, 4. *Kernel:* declined.

**FS100-FLH — FL-1's inequality `τ̂(1) ≤ −τ(R̂)/3` is equivalent to `σ̂_E(1) ≥ −(σ_E(R̂) + a)/3` (X05V-5), which follows from `Λ(F) ≤ 1/3` and T-C(A) (X03D-FL-H) — never met over a real field; so FL-1 and FL-2 are GAP at that one step, QTCA_{1/3}. FL-1 ⟹ FL-2 (X03D-FL-12). The consumer needs MR, or `H_κ` with QTCA_κ for one `κ > 0` (X05V-7); `H_κ` for every `κ > 0` ⟺ MR (via SP-if); MR ⟹ `H_{1/3}` (X05V-8); a bound `s_E ≤ s* < 0.8276` would give a threshold in `(−1/3, 0)` (X03D-FL-Q). [hand; the GAP two blind minds at one step; the consumer statements one mind each]** *Rests on it:* the stub QTCA_κ (held for Kooshi: drafted, not minted). *Kernel:* declined.

## §G. Stated and not proved (no truth claims; not entries)

- **KS-1_E / KS-sat_E** (J51D §M.1): KS-1 and KS-sat with `Γ ∩ E` in place of `Γ ∩ (T + A)` — the corrected Kronecker selection. KS-2 reduces
  KS-1_E to KS-sat_E; FS100-R reduces KS-sat_E to a density statement stopped at a named step. At ℚ(√47) it is FS100-EQ's X.
- **P-sat1 for general `F` off `E`**: GAP at the field form of PA-B2 and JC over `R_{F,S}` (FS100-T5's note).
- **PE-lim** (the plan's §PA.3): for a `U`-invariant `E`-null `μ` on `R̂`, pass from EL2021 Thm 1.3 at finitely generated `Γ` to all of `U`:
  positive entropy for some `u` ⟹ Haar. **Proved at stage 5 as FS100-PE2 (§3)**, through EL2021 Thm 1.2 on admissible `Γ`; the card's reading
  "MR is its zero-entropy half plus PE-lim" is superseded by FS100-MR (§3).
- **The swap question** (the plan's §PA.3): Kronecker selection's missing input can be posed closed-set (KS-sat) rather than as the
  zero-entropy measure problem [reading, one mind]; after FS100-KS3 the closed-set form must allow unions of subgroup translates (J53's reading,
  §R-close stage 2).

## §K. Kernel decisions, summarised

**Stage 5 (§3):** every entry declined for this file's reasons (entropy, SMB, Haar measure on non-finitely-generated duals), except that the
chain FS100-MR → FS100-Q47 is handed to X11K's Lean lane (launched at Kooshi's request, 06:08), which decides what it ports; nothing of it is
kernel yet. **Stage 4′ and earlier (§1–§2):**

All fifteen entries **declined**, each with its reason above: the objects live on duals of non-finitely-generated rings with Haar measure; the
one combinatorial core (FS100-X1's cross and bit flip) is two lines with no kernel consumer; FS100-T1 and FS100-K0 rest on certificates (FS-66)
and one-mind class forms (R88-TCA) whose kernel home, if any, is FS-75's or FS-87's. No stub route is opened.
