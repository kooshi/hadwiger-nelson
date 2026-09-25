# FS-86 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-25 at the close (WORKFLOW 2.0 step 9) by the close planner (de Bruijn, Opus 5.5), from the plan
(`plans/FS86-dyadic-rigidity.md` §0, stage A's record), the plan-phase advisor's record (`plans/POROS-2026-09-25-fs86-plan.md` §3), stage B
(`plans/FS86-B1-verification.md`, `plans/FS86-B2-profile.md`), both competitors' working files (`plans/FS86-C-deBruijn.md`,
`plans/FS86-C-Coxeter.md`, each written by three successive seats), the competition advisor's record
(`plans/POROS-2026-09-25-fs86-competition.md` §7, §7a) and the four quiet blind verifiers (`plans/FS86-V-W-verification.md`,
`plans/FS86-V-X-verification.md`, `plans/FS86-V-C-verification.md`, `plans/FS86-V-D-verification.md`). Grades are `CLAUDE.md` § Notation's. A
proof held in a record is not repeated here; this file is the index that survives the ledger rows' compression (rows 88–94). `LEDGER.md` §
B indexes every entry, one line each (`tools/fs71_ledger_b_check.py --strict`). **FS-86 added no Lean**, so nothing below is kernel-checked,
and every kernel decision is recorded per entry.*

**Duplicates are merged, one entry per theorem** (the close brief): an entry carries the id of its first derivation, and its title names
every other id the records give it (`= W-A`, `= VX-D`, …), so a grep for any of them lands here. Every independent derivation is credited.
**Every verifier correction is applied as filed**: W's D1 (Theorem A's grade), D4 (the K sentence), D7 (`h ≠ 0`); X's widenings (D′ and D's
pullback half need no V3, via Lemma C′; H for every number field); C's scope notes (one coset in C14; C12.1's "iff" vacuous; the class); D's
refutation of Theorem C's "more generally" clause and its H* version. Where a statement below is wider than its author's, the widening is
the verifier's and is credited.

**Who found what:** the **planner** (stage A); **Poros (plan)**, the plan-phase advisor; **B1**, the blind frame verifier; **B2**, the lattice
profile (B2–B3); the competitors **de Bruijn** (seats I–III, "dB") and **Coxeter** (seats I–III, "Cx"); **Poros (competition)**; the quiet
blind verifiers **W** (de Bruijn's seat-I theorems), **X** (seat II), **C** (Coxeter's seat II–III), **D** (de Bruijn's seat III and Theorem
C); the **owner** (one-step checks, cited by close-inventory item); and the **close planner** (two entries, §10, one mind each).

**Notation, fixed once.** `F` a real field; `L = F(i)`; `U = U_F` the norm-one group of `L/F` (the unit vectors); `R = ℤ[U]`; a place of `F`
is **stable** when conjugation fixes the prime of `L` above it (inert or ramified in `L/F`), **split** otherwise. For `d ≡ 3 (mod 8)` the one
dyadic place has completion `ℚ₂(√3)`, and `L_𝔓 = ℚ₂(ζ₁₂)`, `O = ℤ₂[ζ₁₂]`, `𝔓² = (2)`; `T` the local norm-one group; `P_m = Cay(O/𝔓^m, T mod 𝔓^m)`,
row 67's tower (four-tight at every level; every four-colouring of `P_m`, `m ≥ 5`, pulled back from `P₄`; `Forces ⟺ 𝔓⁴`). `𝒫 = Cay(L_𝔓, T)`, the
**local plane**. `F(·)`, `P(·)`: the four-colour forced and periodic-forced subgroups (row 78). A **pullback** is `z ↦ γ(z mod 𝔓⁴)`, `γ` a
four-colouring of `P₄`. `Θ₄(Λ) = {θ ∈ Hom(Λ, ℝ/ℤ) : θ(U ∩ Λ) ⊆ [1/4, 3/4]}`; a **band character** is a point of it; `T`, `A`, `Fin`: torsion,
archimedean, finitely many split components (de Bruijn §7.1; D's `𝒳`). **Type (B)**: ℚ(√59), ℚ(√83), ℚ(√131) — one stable dyadic place of
row 67's type, every odd stable place of all-levels independence ratio `< 1/4`. **S2** (plan §IQ): real fields with exactly one stable place
whose local planes have `χ_f ≤ 4`, that place four-tight at every level; type (B) and ℚ(√2,√3) are members; K has two such places, ℚ(√11)
has a stable 7. **Type (A)**: ℚ(√47), ℚ(√167) — no stable dyadic place (the wall is broken), every stable place of ratio `< 1/4`.

**Scope, stated once.** "Field plane" means `Cay(R, U)`, so every `R`-coset of `F²` separately (the plane's unit-distance graph is a disjoint
union of such cosets; `F(i)` is divisible, so "periodic" is per coset). A result on `𝒫` (local) is not a result on a field plane; a result on
a lattice `Λ ⊂ R` is not a result on `R`. "Not seen in print" is not "new". "Given V3" includes V3's inputs: FS-66's certificates at 11 and 19
and `[Zhang2012]` Thm 1.8.

## §1. The frame (the planner, Poros (plan), B1; the owner)

**FS86-A1 — For `d ≡ 3 (mod 8)`, `ℚ₂(√d) = ℚ₂(√3)` and `ℚ₂(√d, i) = ℚ₂(ζ₁₂)`: the dyadic local plane of ℚ(√59), ℚ(√83), ℚ(√131), and of each of K's two dyadic places, is row 67's (= B1-V0). [tools exact + hand; the planner, Poros (plan) (PARI), B1 blind, the owner]**
`3d ≡ 1 (mod 8)` makes `3d` a 2-adic square; PARI: one prime above 2 in `ℚ(√d, i)`, `e = f = 2`. *Proof:* plan §0.1; Poros (plan) §3 C1;
`plans/FS86-B1-verification.md` V0; inventory item 11. *Proof verdict:* closes. *Rests on it:* every entry below that uses `P_m`. *Prior art:*
row 67 (the tower itself). *Kernel:* declined (a congruence and a PARI decomposition).

**FS86-A2 — The stable places of ℚ(√59) below 60 are 2 (inert in `L/F`), 11, 23, 31, 43, 47 and the ramified 59; of ℚ(√83): 2, 19, 43, 47 (11 not stable); of ℚ(√131): 2, 19, 23, 31, 47. [tools exact + hand; the planner, Poros (plan), the owner by Legendre symbols]**
*Proof:* plan §0.6, `data/fs86/stageA/spec_checks.py`; Poros (plan) §3 C2; plan §R-review R.2 item 2. *Proof verdict:* closes. *Rests on it:*
V3's place list; the correction of the stub's and H5's "11, 19, 23" (19 is inert in ℚ(√59)). *Prior art:* none. *Kernel:* declined.

**FS86-A3 — `Λ₅₁₀` over ℚ(√59) (the saturated chain at `M = 2·3·5·17`): 324 unit vectors, rank 4, covolume `3⁻⁴5⁻⁴17⁻⁴` in the `O_F(i)`-basis, `Λ₅₁₀ ⊗ ℤ₂ = O_𝔓`, `1/3, 1/5, 1/17 ∈ Λ₅₁₀`; `Λ₂₇₃₀`'s image at 59 is 44 of 60 points. [tools exact; the planner]**
*Proof:* plan §S.1, `data/fs86/stageA/` (`index.py`, `profile.py`, `inert.py`, `cover59.py`; two enumerators cross-checked at `M = 30, 210,
2730`). *Proof verdict:* closes (the plan's Hoffman ratios there are float, aiming only; B3 made them exact, FS86-B3-T1). *Rests on it:* the
definition of "rich" (R1–R4) and its named instance. *Prior art:* FS79-T9 (saturation). *Kernel:* declined.

**FS86-A4 — A 3-integral or 5-integral lattice over ℚ(√59) is three-colourable (it maps into `UD(𝔽₉, 2)` or `UD(𝔽₅, 2)`), so loose at four. [hand; the planner]**
*Proof:* plan stage A record (from row 72 and G64's `χ(Γ₅) = 3`). *Proof verdict:* closes. *Rests on it:* (R2) of "rich". *Prior art:*
FS79-T1. *Kernel:* declined.

**FS86-V1 — `F(R) = ⋃ F(Λ)` over finitely generated `Λ ⊆ R` spanned by unit vectors, while `P(Λ) ⊆ P(R) ∩ Λ`, strict in general (`Λ = ℤu`: `P(Λ) = 0`, `P(R) ∩ Λ = 4ℤu`) (= FR-1 (i)). [hand + kernel `forces_iff_exists_finite`; Poros (plan), B1 blind, the owner (the example)]**
*Proof:* plan §0.3 (i); B1 V1. *Proof verdict:* closes. *Rests on it:* V4; "on a lattice, `F` is the field's `F` restricted, `P` a lower
question". *Prior art:* row 78's kernel theorem. *Kernel:* declined (a corollary of a kernel theorem).

**FS86-B1-LR — Lemma R: `ℤ[U_F]` is the ring of elements of `L` integral at every stable prime, and it is dense in the product of the stable completions — for real `F` with `L/ℚ` Galois and no stable prime ramified in `L/F` (scope corrected at the close, FS86-CL2). [hand; B1; the scope, the close planner and D]**
Prime inversion by Chevalley's extension theorem; `cO′ ⊆ R`; density through the parametrisation `(1+it)/(1−it)`, Teichmüller idempotents
and a uniformizer; `O′/R` finite with no torsion. *Proof:* B1 Lemma R. *Proof verdict:* closes on the corrected scope; **fails as B1 stated
it** at a stable dyadic place ramified in `L/F` (FS86-CL2). *Rests on it:* V2, V3, VK, X's Lemma C′ (consequence (b)), D's VD-C proof (its
density step, generalised). *Prior art:* `[Fischer1990b]` Thms 1, 3, 5; G55's prime inversion; the "integral at every stable prime" form not
found. *Kernel:* stub (FS-47, the unit-vector ring in the kernel).

**FS86-LP — Lemma P: on every odd stable residue tower, unramified or ramified, a character new at level `m` has `|λ| ≤ 2p^{m−1}`; so Hoffman's ratio is `max(h(Γ_p), 2/(p+3))` at every level, and FS-66's fibre-density inequality and its certificates bound every level of a ramified tower too (= Poros (plan) C4 for the ramified 59; = inventory item 12's ramified-base constant ratio). [hand + tools exact (FFT at five towers; bound attained on the ramified ones); Poros (plan) (ramified 59, Hoffman), B1 blind (every odd tower, with the certificate extension)]**
A fibre of `S_k → S_{k−1}` is `{s + π^{k−1}sa : Tr a = 0}`; a coset of `𝔽_p^×` meets `μ_{p+1}` in at most two points (`gcd(p−1, p+1) = 2`;
the owner's check, item 11; B1's D9: a coset `{±s₀}`, not necessarily `{±1}`). *Proof:* B1 Lemma P, `data/fs86/b1/tower_spectra.py`;
Poros (plan) §3 C4. *Proof verdict:* closes. *Rests on it:* V3 at the ramified place, V3-ram, VK at K's ramified 11-towers, C14.4, D's H*.
*Prior art:* FS-66's L1 (unramified), `[MMST1998]` (unramified spectra); the ramified extension not found. *Kernel:* declined (finite
character sums; FS-41's stub would host it).

**FS86-B1-LD — Lemma D: `P_m` is Hoffman-tight at four colours at every level, from FS38-L2's non-strict half (not FS38-L1). [hand + tools exact (independent build, levels 2–8); B1]**
*Proof:* B1 Lemma D. *Proof verdict:* closes. *Rests on it:* V3 step 4, VK step 4, C's VC-C4 ("every such tower four-tight unconditionally"),
the re-sourcing of FS38-D2-B's levels 1–4 (FS38-L1's tightness half is defective, FS86-B2-T2). *Prior art:* FS38-L2. *Kernel:* with FS-41's
stub.

**FS86-V2 — `F(R)` is an ideal of `R`, every non-zero ideal has finite index, so `F(R) ∈ {0, P(R)}`: either every four-colouring of the field plane is periodic, or some one is not (= FR-1 (ii); B1-V2). [hand; Poros (plan), B1 blind (route D1: `cO′ ⊆ R`)]**
*Proof:* plan §0.3 (ii); B1 V2. *Proof verdict:* closes on Lemma R's scope; B1's D1 records the sketch's unsaid step (a non-zero ideal holds
an integer, by the norm). *Rests on it:* V4, VK, the whole competition's frame, HD1-cert's ⟸ in de Bruijn's route. *Prior art:* G55's
transport `z ↦ t + u(z − a)`; the dichotomy's form not found. *Kernel:* stub (the ideal half is short on row 78's `forcedSubgroup`; finite
index needs Lemma R).

**FS86-V3 — For `d ∈ {59, 83, 131}`: `P(R) = R ∩ 𝔓⁴`, and every periodic four-colouring of the field plane is a pullback (= FR-1 (iii); B1-V3). [hand + cert + external; Poros (plan), B1 blind; inputs FS-66's certificates at 11 (and 19 for 83, 131) and Zhang 2012 Thm 1.8(i)]**
A finite quotient of `R` is the categorical product of the stable local towers (Lemma R (b): D2, the vertex set, not only the connection
set); every odd factor has all-levels ratio `< 1/4` (11, 19 by FS-66's `U(11) = 28.20 < 121/4`, `U(19) = 77.51 < 361/4` — Hoffman fails
there, 0.2855 and 0.2756; 23, 31, 43, 47, … by Hoffman + Lemma P; the thinnest margin at 31, `1/4 − 2.745·10⁻⁶`); the dyadic factor is exactly
1/4 (Lemma D); `[Zhang2012]` Thm 1.8(i) (MIS-normality; `H` connected, D5) makes every colour class a pullback from `P_m`. *Proof:* plan §0.3
(iii); B1 V3, C2 (D2–D5), C3. *Proof verdict:* closes given the inputs; **if FS-66's certificate at 11 were withdrawn, V3 has a gap exactly
there**. *Rests on it:* V4; "the stub's weak yes is free" (P-free); C7 (via Poros's restriction), HD4, C14.4. *Prior art:* Zhang (the
product step); `[GodsilEtAl2020]` Cor. 4.4 is its vector-colouring form; the field-level statement not found. *Kernel:* declined for now
(Zhang's theorem and FS-66's certificate are each a kernel project).

**FS86-V3ram — The ramified 59-tower has Hoffman ratio `max(0.199120, 2/62) < 1/5` at every level (83: 0.1741; 131: 0.1379) (= FR-1′; Poros (plan) C4). [hand + tools exact; Poros (plan), B1 blind]**
*Proof:* Poros (plan) §3 C4; B1 V3-ram. *Proof verdict:* closes **with "ratio at level one" read as Hoffman's ratio bound** (B1's D10); read
as the true independence ratio, the middle inequality is FS-68's open "the tower never rises" from level 3, while "`< 1/5` at every level"
still holds. *Rests on it:* V3 at the ramified place. *Prior art:* FS-66's L1–L2. *Kernel:* declined (with Lemma P).

**FS86-V4 — Given V2 and V3: `F(R) ≠ 0` ⟺ the single pair `(0, 4)` is four-colour forced ⟺ some finite unit-distance graph over `F` forces a distance-4 pair (`𝔓⁴ = (4)`). [hand; Poros (plan) (after the plan), B1 blind, the owner]**
*Proof:* Poros (plan) §7; B1 V4; inventory item 22. *Proof verdict:* closes given V2–V3. *Rests on it:* the competition's challenge; Theorem
A's reframe; T1. *Prior art:* none. *Kernel:* declined (a corollary).

**FS86-VK — Over `K = ℚ(√3, √11)`: `F(R_K) = P(R_K) = R_K ∩ 𝔓₁⁴ ∩ 𝔓₂⁴ = 4R_K`, and every proper four-colouring of each `R_K`-coset of `K²` is a pullback from `P₄` at exactly one of K's two dyadic places, chosen per coset. [hand + cert + external, given one non-zero forced difference; the planner (four lines, missing the equal-ratio step), Poros (plan) (the step: tightness of `P_m × P′_m`), B1 blind (with D6, D7)]**
The two dyadic factors are `[Zhang2012]`'s equal-ratio case, so MIS-normality does not choose; the product of two four-tight towers is
four-tight with least eigenspace the pure characters, so each class is `a(x) + b(y)` and lies at one place; the odd part (K's two ramified
11-adic places; Hoffman 0.2855 fails there) by FS-66's certificate carried to the ramified tower through Lemma P (ii) (B1's D6, the most
substantive completeness fix). Input: one non-zero forced difference — row 78's 2,044-point certificate `v = −(4/9)(1+√−11)` [cert], or row
85's derivation (given Parts's trees). Positive control by formula: `[Fischer1994]`'s ℤ/4 colouring kills `R_K ∩ 𝔓₁³` and no power of `𝔓₂`
— it reads exactly one dyadic prime (B1, `data/fs86/b1/fischer_vk_control.gp`). Consistency (the owner, item 13): `1/3 ∈ R_K`, so `8/3,
8/9, 16/3, v ∈ 4R_K`; `2P ∉ 4R_K` (the wall stands), as Fischer's colouring requires. On de Grey's lattice `4R_K ∩ Λ = 4Λ ⊋ 8Λ = F(Λ)`: the
field forces more than the lattice. *Proof:* plan §0.4; Poros (plan) §4; B1 VK, C2 (D6, D7), C3. *Proof verdict:* closes under those
inputs; two derivations (the planner with Poros's fix; B1 blind). *Rests on it:* Theorem A's first route; C7's first route (superseded);
C14-K; the free control at K for every K1 condition. *Prior art:* Speyer (Polymath16, 25 April and 3 May 2018; `[Speyer2018]`) posed the
level-one question on the Moser ring and found `8R`-periodic colourings there that are not `4R`-periodic — consistent (the ring's graph is a
subgraph of `Cay(R_K, U_K)`; `ζ₁₂` and `i` force period 4); Hubai (8-periodic, ring, computer) and rows 78, 85 (lattice) answer smaller
graphs; the wiki's *Algebraic formulation* table has no ring containing `i` or `ζ₁₂`; `[Fischer1994]` gives one colouring, no
classification. **The field-level classification not found** (zbMATH and the Johnson papers not searched). *Kernel:* stub (with FS-87; it
needs Lemma R, Zhang and FS-66).

**FS86-B1-D8 — ℚ(√11)'s plane has periodic four-colourings pulled back from its dyadic `K₄` (not through `Γ₇`), and `F = P = 0` there by row 66's gap transport — not by MIS-normality, which says nothing when a factor's ratio exceeds 1/4 (`Γ₇`: 2/7). [hand; B1]**
*Proof:* B1 C2 D8. *Proof verdict:* closes; corrects plan §0.4's "Negative" and Poros (plan)'s M5 (3a). *Rests on it:* the S2 boundary at
ℚ(√11). *Prior art:* row 66; `[Fischer1990]` Thm 10(i). *Kernel:* declined (row 66 is kernel).

## §2. `Λ₅₁₀`'s dyadic profile (B2, B3; the owner)

**FS86-B2-T0 — `Λ₅₁₀`'s saturation depth is `m* = 5`: `U mod 𝔓^m = S_m` exactly for `m ≤ 5`, not at 6 (92 of 96, the 4 missing in one class mod 𝔓); residues injective from level 11; the ℤ₂-span of `U` is `O`. [tools exact; B2]**
*Proof:* `plans/FS86-B2-profile.md` §2, `data/fs86/b2/embed.py`. *Proof verdict:* closes. *Rests on it:* T1, T2. *Prior art:* none.
*Kernel:* declined.

**FS86-B2-T1 — For `5 ≤ m ≤ 14` every four-colouring of `Q_m = Cay(Λ₅₁₀/(Λ₅₁₀ ∩ 𝔓^m), U mod 𝔓^m)` is a pullback from `P₄`; so on `Λ₅₁₀` every `128Λ`-periodic four-colouring is `4Λ`-periodic — the slack levels 6–10 are decided by the tight cover `Q₁₄` (G54's middle case again). [hand, one mind, on exact spectra (tightness at 14 float, margin 2.61); B2; the owner's one-step check]**
*Proof:* B2 §3–§4; inventory item 25 (the owner: compose with `Q₁₄ ↠ Q_m`; `Λ ∩ 𝔓⁴ = 4Λ`, `Λ ∩ 𝔓¹⁴ = 128Λ`). *Proof verdict:* closes.
*Rests on it:* P-undec's split scoring; the lattice fact that `P(Λ₅₁₀)`'s 2-power part stops at `4Λ` below level 15. *Prior art:* FS38-D2-A/B
(the pull-back through a tight cover). *Kernel:* declined.

**FS86-B2-T2 — `Cay(Λ₅₁₀, U)` is not Hoffman-tight at four colours (non-zero exact symbol gradient at 36 of the 45 minimisers), and `Q_m` is tight at 1–5 and 11–14, slack at 6–10 (exact minima −36, −58, −78, −92, −108) and slack at every `m ≥ 24` (first slack level above 14 in [15, 24]); with constant fibres of size 1 from level 11, this refutes "tightness propagates up a tower with constant fibres" in general. [tools exact (gradients, minima) + float with margin (the level-24 slack certificate, 2.76); B2; the owner]**
FS38-L1's tightness half does not follow: four-colourability plus Hoffman gives `λ_min ≤ −d/(k−1)`, the same direction as the pull-back
bound (the owner's hand check, item 26); L1's slack half stands. *Proof:* B2 §3, §5, `data/fs86/b2/descent.py`. *Proof verdict:* closes.
*Rests on it:* the corrections to G54, row 67's propagation clause, FS38-L1 and FS38-D3 (the full 2-adic tower stays tight at every level:
at 1–8 by the exact table, at `m ≥ 5` by FS38-D2-B's induction on L2–L3, and at every level by Lemma D). *Prior art:* none. *Kernel:*
declined.

**FS86-B2-T3 — `Λ₅₁₀`'s analogue of FS38-L3 has elementary divisors 1, 2, 4, 4 (`𝔓⁴ ⊆ M_Λ ⊗ ℤ₂`, `𝔓³ ⊄`), identical to the full tower's. [tools exact, two code paths; B2]**
*Proof:* B2 §6, `l3.py`. *Proof verdict:* closes. *Rests on it:* nothing further (P-B2-L3 not met). *Prior art:* FS38-L3. *Kernel:*
declined.

**FS86-B3-T1 — Exact Hoffman refusals of four colours at `Λ₅₁₀`'s image targets at 7, 13, 19, 23, 31, 41, 43, 47, 53 and the ramified 59 (PARI characteristic polynomials over `ℚ(ζ_p)`, Sturm counts); at 11 by the kernel's `χ(Γ₁₁) = 5` (Hoffman does not refuse, 0.2855); at 29 no theorem refuses (Hoffman 0.2533; `χ(UD(𝔽₂₉, 2)) ≥ 5` is an uncertified 90-second solver run). So `Λ₅₁₀` meets (R4) as a theorem for `B < 29`, measured at 29 (owner ruling R8). [tools exact; B2]**
*Proof:* B2 §7, `data/fs86/b3/`; controls Γ₃, Γ₇ read "does not refuse", a two-sided threshold plant at 31 flips at 10⁻³ and not 10⁻⁴.
*Proof verdict:* closes. *Rests on it:* "rich"'s named instance. *Prior art:* FS81-T25 (23's margin 0.039). *Kernel:* declined.

## §3. The local plane and the extension frame (de Bruijn seat I; verifier W; D; Poros (competition))

**FS86-dB-E — Lemma E: K, ℚ(√59) and ℚ(√3, √11, √59) embed in `ℚ₂(√3)`, and each unit-distance graph over them embeds, induced edges preserved, in `𝒫`. [hand + exact congruences; de Bruijn]**
`33 ≡ 1 (mod 8)`, so `√33 ∈ ℚ₂` and `√11 = √33/√3` (the owner's check, H-37). *Proof:* `plans/FS86-C-deBruijn.md` §1.1. *Proof verdict:*
closes. *Rests on it:* Theorem A's input, A1, B, T1. *Prior art:* none. *Kernel:* declined.

**FS86-W1 — `ℤ[T] = O`: the ℤ-span of the norm-one units of `ℚ₂(ζ₁₂)` is its ring of integers, so `Cay(O, T)` is connected. [hand, elementary; W]**
For `x ∈ 4ℤ₂`, `1 − x²` is a 2-adic square, so `2x = t + t̄` with `t ∈ T`. *Proof:* `plans/FS86-V-W-verification.md` § W-A; the owner's check
(H-43). *Proof verdict:* closes. *Rests on it:* Theorem A's shorter route. *Prior art:* none sought. *Kernel:* **stub — W's cheapest kernel
candidate** (a one-paragraph lemma over `ℤ₂[ζ₁₂]`; FS-87's companion).

**FS86-dB-A — Theorem A: every four-colouring (arbitrary, no measurability) of the plane over `ℚ₂(√3)` is a pullback from `P₄` on each coset of `O`, and its forced group is exactly `𝔓⁴` (= W-A). [hand + certificate (row 78), or given Parts's trees (row 85); plus FS38-D2-B — the grade corrected by W's D1; de Bruijn, W blind (a shorter route), Poros (competition) (walked it)]**
De Bruijn's route: `4 ∈ F_loc` from VK and compactness, then an analytic submersion `T × T → L` makes forced differences open, and
density of `ℤ[ζ₁₂]` fills `𝔓⁴`. W's route needs strictly fewer inputs: W1, row 78's forced `v` with `v_𝔓(v) = 6` at both primes (PARI; the
owner: `−11 ≡ 5 mod 8`, so `v₂(1+√−11) = 1`, `e = 2`, `v_𝔓 = 6`), the ideal `𝔓⁶` it generates, FS38-D2-B at level 6, and `P₄`'s kernel
pairwise freedom for "exactly" (not VK, V2, V3, Zhang, FS-66 or compactness). **Either input needs `√3`: every known local forcer is built
on triangles.** *Proof:* de Bruijn §1.2; W § W-A, C2 (D1–D3, D6), `wa_check.gp` (plant fires). *Proof verdict:* closes; two derivations.
*Rests on it:* the killing test's pass on K1 (Poros (competition) §7); A1; B; the reframe "rigidity is local at the tight place, the
question is extension". *Prior art:* the chromatic number of `p`-adic planes is `[Madore2015]` ¶1.5 and `[BardestaniMallahiKarai2017]`'s; a
four-colour rigidity statement for a local plane not found; **a proper gate on Theorem A as a `p`-adic-plane result is owed** (Poros
(competition)'s item (g)). *Kernel:* stub (W's route: W1, row 78's certificate — already kernel — and D2-B's level-6 table; FS-87's companion).

**FS86-dB-A1 — Corollary A1, the extension form: for ℚ(√59), ℚ(√83), ℚ(√131), `F(R) ≠ 0` ⟺ every four-colouring of the field plane extends to `𝒫`, per coset ⟺ every one is a pullback; (⇐) for every real `F ⊂ ℚ₂(√3)` (= W-A1). [hand; (⇒) at V2–V3's grade; de Bruijn, W blind]**
W's explicit non-extendable colouring at ℚ(√11): colour by position mod 7, a four-colouring of the plane at 7 pulled back. **At K the
statement along a fixed embedding is false (W's D4; FS86-W-A1K), so "K's plane inherits the rigidity" reads: each coset of `K²` inherits it
from one of its two dyadic embeddings, chosen per coset** (owner ruling, H-46). *Proof:* de Bruijn §1.3; W § W-A1, C2 D4, C3. *Proof verdict:*
closes at the corrected scope. *Rests on it:* the reframe of S1 as an extension (realisability) question. *Prior art:* none. *Kernel:*
declined.

**FS86-W-A1K — At K the extension form along a fixed embedding fails: a VK colouring pulled back at `𝔓₂` does not extend along `ι₁` (an extension would be `(R_K ∩ 𝔓₁⁴)`-periodic by Theorem A, and `R_K ∩ 𝔓₁⁴` maps onto `O_{𝔓₂}/𝔓₂⁴`, forcing a constant). [hand; W; the owner's check]**
*Proof:* W C2 D4; H-46. *Proof verdict:* closes. *Rests on it:* the correction of de Bruijn §1.3's K sentence. *Prior art:* none. *Kernel:*
declined.

**FS86-dB-B — Theorem B: a 2-adically locally constant four-colouring of the field plane (every real `F ⊂ ℚ₂(√3)` whose `U_F` is dense in `T`) is a pullback; a non-periodic colouring, if any, is 2-adically discontinuous; the same proof gives agreement with one pullback on the continuity set whenever that set is dense (= W-B). [hand, given Theorem A; de Bruijn, W blind]**
*Proof:* de Bruijn §1.4; W § W-B, C2 D5. *Proof verdict:* closes; the same proof twice. *Rests on it:* the no-go family (2-adically continuous
colourings excluded). *Prior art:* none. *Kernel:* declined.

**FS86-dB-Atf — Where triangles enter: Theorem A uses them only in its input (step 1); for triangle-free `F ⊂ ℚ₂(√3)`, `F(R_F) ⊆ F_tf ∩ R_F`, where `F_tf` is the set of differences forced in `𝒫` by triangle-free finite configurations, and `F_tf` is `{0}` or contains an open ideal. [hand; the dichotomy a sketch with a genericity step; de Bruijn]**
So "is `4 ∈ F_tf`?" is the sharp local question — the 2-adic forced-pair form of Soifer 55.1 — and `F_tf = {0}` would be a class-level "no"
for every triangle-free field inside `ℚ₂(√3)` at once (Poros (competition)'s cards #1, #1a: the class-level no needs only `4 ∉ F_tf`, by
V4). *Proof:* de Bruijn §1.6. *Proof verdict:* closes for the inclusion; the dichotomy is a sketch, not needed for the class-level no. *Rests on it:*
 T1; the stub for the local triangle-free question. *Prior art:* none. *Kernel:* declined.

**FS86-dB-T1 — `4 ∈ F_tf` ⟺ some number field `E ⊂ ℚ₂(√3)` (any signature) carries a finite triangle-free forcer of `(0, 4)` (= VD-T1, VD-5). [hand; de Bruijn (⟹ citing existential closedness of henselian fields in their completions); D blind (the smooth case suffices: a 2-adic point is the generic, hence smooth, point of its own `ℚ(√3)`-Zariski closure, so the 2-adic implicit function theorem gives an algebraic realisation with the identical graph)]**
*Proof:* de Bruijn §5.1; D § VD-T1. The citation, not needed, is `[Kuhlmann2016]` Thm 5.9 / Cor 5.10 (read first-hand by D; the side's
paraphrase is a correct special case). *Proof verdict:* closes; two derivations. *Rests on it:* the reading "`4 ∉ F_tf` would say no
triangle-free field in `ℚ₂(√3)` has a rigid plane, ℚ(√−709) included" (§11). *Prior art:* `[Kuhlmann2016]`. *Kernel:* declined.

## §4. Characters, pinning identities and HD1 (both sides; D; C)

**FS86-dB-W — Lemma W, the wall lemma, and stripes: a cut-and-project phase pattern (phase a function of the residue and `ℓ(z) mod 1`, `ℓ` additive, windows piecewise constant with finitely many breakpoints), with any number of phases, gives a pullback. [hand; de Bruijn]**
Each circle slice is a `P₄`-colouring; adjacent slices are equal by the wall lemma; the circle graph is connected. *Proof:* de Bruijn §2.1,
§6.3a. *Proof verdict:* closes (not verified blind: X's D12). *Rests on it:* the no-go family (stripes). *Prior art:* none. *Kernel:*
declined.

**FS86-dB-S — Proposition S, star identities: (i) rigidity implies star identities exist (including a "virtual hexagon", VK's analogue of `NT`); (ii) a valid one has `λ = −Σa/3`; (iii) its dyadic torsion frequencies are pinned; (iv) split-free frequencies with an archimedean part are excluded. [hand; de Bruijn; retraction 1 corrected (iii)–(iv) before any report]**
Open inside it: mixed dyadic–odd torsion (a Gauss-sum lemma) and split-place frequencies. *Proof:* de Bruijn §2.2. *Proof verdict:* closes
as corrected. *Rests on it:* dB-K3; C11's reading; the annihilator framing (§6.6). *Prior art:* the annihilator method (`[KariSzabados2016]`,
`[HervaKari2023]`): a star identity is an annihilator; they convert an identity to line-periodic sums, never supply one. *Kernel:* declined.

**FS86-dB-Theta — The torsion-plus-archimedean part of `Θ₄(F)` on type-(B) planes is dyadic torsion only: a band character torsion at the stable places plus an archimedean linear part is a pullback character (= Cx-C8; Poros (plan)'s HD1 first case). [hand, given V3 and Zhang; de Bruijn (round 1, §2.3), Coxeter (round 2, C8) independently]**
So FS-83's character route to a "no" at four colours on type-(B) planes lives only in split-place components. *Proof:* de Bruijn §2.3;
Coxeter § Round 2 step 1. *Proof verdict:* closes; two derivations. *Rests on it:* HD1-fin; the fallback's hour-one question (Poros
(competition)'s H-36(a): `χ_c ≥ χ_f = 4` closes HD1's circular step). *Prior art:* none. *Kernel:* declined.

**FS86-dB-K3 — On type-(B) planes, a no-go of any pinning format that contains a would-be pinning identity valid on all pullbacks implies `F(R) = 0`: a K3 there is a K2 in disguise unless the format cannot pin structurally. [hand; de Bruijn]**
*Proof:* de Bruijn §2.4. *Proof verdict:* closes. *Rests on it:* Poros (competition)'s scoring wording (a no-go implying `F(R) = 0` is K2).
*Prior art:* none. *Kernel:* declined.

**FS86-Cx-C11 — On the field plane, `F(R) ≠ 0` iff the zero set of the whole annihilator ideal (finitely supported `f` annihilating every tetrahedral colouring) is a finite set of torsion characters; "some annihilator exists ⟹ `F(R) ≠ 0`" is not claimed. [hand; Coxeter; retraction 1 of its side corrected the first report's "iff" on a single annihilator]**
The owner checked the direction that stands (a forced `δ` gives `X^δ − 1`). *Proof:* `plans/FS86-C-Coxeter.md` § Round 2 step 2, C11 (b);
Retractions 1. *Proof verdict:* closes as corrected (spectral synthesis for finite sets). *Rests on it:* the reading that G75's format,
un-narrowed, is the question itself. *Prior art:* `[KariSzabados2016]`. *Kernel:* declined.

**FS86-dB-HDint — A character of `R` is fixed only up to global elements: every character (dyadic torsion included) has representatives with non-zero split components at infinitely many places, and some character has no finitely-split representative at all; per-place products depend on the representative (the trivial character: 1 against 0); the intrinsic class is `T + A` (= VD-9). [hand; de Bruijn (seat III §7.1), D blind (the explicit character, by strong approximation)]**
*Proof:* de Bruijn §7.1, §7.4; D C1 (3). *Proof verdict:* closes; two derivations. *Rests on it:* Theorem C's downgrade; HD1's precise gap.
*Prior art:* adelic duality (standard). *Kernel:* declined.

**FS86-dB-HDfin — HD1 for characters of finite type: in S2, every band character that is torsion plus archimedean plus finitely many split components is one of the finitely many pullback characters, so every finite-type character colouring of `F²` is periodic and local at the tight place; finite-type characters have well-defined components (= Cx-C10, C10.0; = VC-C6). [hand; de Bruijn (seat III, HD1-fin), Coxeter (seat II, C10) independently, neither seeing the other; C blind (as a corollary of C14)]**
De Bruijn: weak approximation for the norm-one torus (a conic with a rational point, the owner's check), a deep pole at one split place
sweeps that component through a cyclic group minus an index-`p` subgroup. Coxeter: continuity in finitely many components, independence by
weak approximation, a split component sweeps densely, C8 disposes of the archimedean part (its odd-component case fails because the dyadic
plane is not bipartite). Non-vacuous: Fischer's ℤ/4 functional, local at 2 at level 3. The hypothesis is needed: C9 fires at ℚ(√11). C's
route (`⌊4Θ⌋` is a Borel window colouring) closes all but one case, which C8 closes. *Proof:* de Bruijn §7.2; Coxeter § Round 2 step 2; C
§ VC-10, C2. *Proof verdict:* closes; three derivations. *Rests on it:* FS-83 at `k = 4` is dead on type-(B) planes for finite-type points;
HD1-cert. *Prior art:* none. *Kernel:* declined.

**FS86-dB-Sv — (S-v): a frequency in `T + A + Fin` with non-zero split part lies in no star identity's zero set (`Σa ≠ 0`); and on `T + A + Fin`, for every band and every field, the split part of a band character is zero. [hand; de Bruijn]**
*Proof:* de Bruijn §7.2. *Proof verdict:* closes (not verified blind). *Rests on it:* HD1-fin's reach beyond `[1/4, 3/4]`. *Prior art:* none.
*Kernel:* declined.

**FS86-dB-HDcert — HD1-cert: HD1 (`Θ₄(R) ⊆ T`) holds iff some finitely generated `Λ₁ ∋ 1` has `θ(1) ∈ {1/4, 1/2, 3/4}` for every `θ ∈ Θ₄(Λ₁)`; so HD1, if true, has a finite exact certificate, and is semi-decidable with no size bound; given V2–V3, HD1 ⟺ `Θ₄(R)` has no non-torsion point, and a non-torsion point gives a non-periodic colouring, so `F(R) = 0` (= VD-cert, VD-2, VD-3, VD-4). [hand; de Bruijn (seat III, with `Λ₀ ⊆ Λ₁`), D blind (own routes; the simplification to `Λ₀ = ℤ·1`)]**
⟸ needs only `U`-invariance of `Θ₄` and `R ∩ 𝔓⁴ = 4R` (D's rank count, FS86-VD-1), not V2 or V3; ⟹ by isolation of each pullback point
(unit vectors taking 1/4 are dense in the archimedean torus) and inverse-limit compactness — existence only. **Nothing in R1–R4 makes
`Λ₅₁₀` serve on the ⟹ side**: that is a separate exact check (positive spanning). *Proof:* de Bruijn §7.3; D § VD-cert, C2 (D1–D4), C3.
*Proof verdict:* closes; two derivations. *Rests on it:* the post-ban computation that decides HD1 when HD1 is true (a `Θ` relation tree,
banned to 2026-10-01; one of Kooshi's candidate uses of a sanctioned search). *Prior art:* none. *Kernel:* declined.

**FS86-VD-1 — For ℚ(√59): `R ∩ 𝔓⁴ = 4R` and `R ↠ O/𝔓⁴`, by density of `U` at 2 and a rank count (`|R/4R| ≤ 4⁴ = |O/𝔓⁴|`). [hand; D; the owner's check]**
*Proof:* D (F3); H-69. *Proof verdict:* closes. *Rests on it:* HD1-cert's ⟸ without V2, V3. *Prior art:* Lemma R (b) gives it too. *Kernel:*
declined.

**FS86-Cx-C15 — The homogeneous part of `Θ₄` is torsion: a `U`-invariant coset of a closed subgroup of `R̂` lying in `Θ₄` is a finite set of torsion characters, so every algebraic `U`-invariant measure on `Θ₄` is atomic on torsion points (every field whose non-zero ideals of `R` have finite index). [hand, uses V2; Coxeter (seat III)]**
*Proof:* Coxeter § Round 2 step 6. *Proof verdict:* closes (read once by C, not verified). *Rests on it:* the obstruction reading (§11): what
remains of HD1 is non-algebraic invariant measures, i.e. measure rigidity. *Prior art:* none. *Kernel:* declined.

**FS86-Cx-C9 — FS-83's mechanism fires at ℚ(√11): `θ = (2x + 3y)/7` read at the stable prime above 7, plus an archimedean linear term `ℓ` with `0 < max ℓ ≤ 1/28`, is a non-torsion point of `Θ₄(ℚ(√11))` — an explicit non-periodic four-colouring of ℚ(√11)'s plane, by formula. [hand; arithmetic checked mod 7; Coxeter; the owner (script)]**
The eight points of `x² + y² = 1` over `𝔽₇` map under `2x + 3y` exactly to `{2, 3, 4, 5}`, so the plane at 7 lands in `[2/7, 5/7]`, room
`1/28` (H-49). *Proof:* Coxeter § Round 2 step 1. *Proof verdict:* closes. *Rests on it:* C10's hypothesis shown necessary; C14's sharpness at
ℚ(√11). *Prior art:* the unit argument and the layer method (`[Fischer1990]`, G74); an explicit non-periodic four-colouring of a field plane
not seen in print. *Kernel:* declined (a formula; a kernel check of properness on the plane is a candidate, not priced).

## §5. Averaged rigidity and pair correlations (de Bruijn seats II–III; W; D; Poros (competition))

**FS86-dB-C0 — The Bessel obstruction: on any real field plane, unit-distance pair correlations are consistent with a purely archimedean spectrum (a circle of characters at `2πr₀`, `J₀(2πr₀) = −1/3`); with W's repaired measure `μ₁ = w·δ₀ + (1 − w)·circle(j₁,₁)`, `w = 0.04949`, every two-point constraint is met with 95 % of the mass non-periodic (= W-C0). [hand + mpmath; de Bruijn, Poros (competition) independently (H-36 (b)), W blind (the repair)]**
The stated circle alone gives −0.40276 at `|z| = 1.178` or 0.862, below the −1/3 floor (a gap only against the owner's brief paraphrase,
which dropped "unit-distance"; de Bruijn's text was scoped correctly). `J₀`'s minimum −0.402759 at 3.8317 (the owner); `1/(1 − 1/min J₀) =
0.28712`, the Bachoc–Nebe–Oliveira–Vallentin theta bound's extremiser. *Proof:* de Bruijn §4.1; W § W-C0, C2 D10, `wc0_check.py` (plant fires);
Poros (competition) §3. *Proof verdict:* closes; the repaired form extends the no-go to every two-point constraint; three-point constraints
open. *Rests on it:* K3's recorded second-moment format (implied, H-36 (b)); "at the averaged level the archimedean place, not triangles, is
the obstruction". *Prior art:* `[BachocEtAl2009]`, `[OliveiraVallentin2010]`. *Kernel:* declined.

**FS86-dB-C — Theorem C, at its proved scope: for a number field `E` with an embedding whose closure is `ℚ₂(√3)`, `i ∉ E`, such that every stable place other than `𝔓` (odd or dyadic) has `λ/d > −1/3` at every level (H*), every translation-invariant random four-colouring whose spectral measure is carried by `T + A + Fin` is almost surely a pullback. H* holds for every imaginary quadratic `E ⊂ ℚ₂(√3)` avoiding residue fields 𝔽₃, 𝔽₇, 𝔽₁₁, 𝔽₁₉ (e.g. ℚ(√−709)) (= VD-8). [hand; de Bruijn (seat II, downgraded by its own seat III, retraction 2), D blind (weights from weak approximation alone)]**
**Not proved:** the unrestricted form (`F_μ = P` for every invariant random colouring), which needs Lemma X (a weight sequence with `liminf
λ ≥ −1/3` on every character, equality only at dyadic minimisers) — true on `T + A + Fin`, open outside; hence its corollaries (`F_μ = P`
for ℚ(√−709); a re-proof of `χ(E²) ≥ 4` through the complex place) are **conditional**. **False as first stated:** the clause "more generally
a number field with no real place" (FS86-VD-7). *Proof:* de Bruijn §4.2, §7.4; D § VD-C (2), C2 (D5–D12), C3. *Proof verdict:* closes on `T +
A + Fin` under H*. *Rests on it:* the reading that non-real planes' averaged colourings are pinned (§11). *Prior art:* none. *Kernel:*
declined.

**FS86-VD-7 — Theorem C's "more generally, no real place" clause is false: the totally complex quartic `f = 4494337x⁴ + 11933692x³ + 17314816x² + 12362764x + 6083575` has a `ℚ₂(√3)` place inert in `E(i)`, 3, 7, 11, 19 inert, and two `ℚ₂` places ramified in `E(i)`, so `χ(E²) = 2`, and a random shift of its two-colouring is a translation-invariant four-colouring with two torsion atoms, not a pullback. [hand + exact PARI; D; the owner (PARI: irreducible, signature (0, 2), residue degrees, the dyadic ramification and residue degrees)]**
*Proof:* D C1 (1), `data/fs86/v-d/vdc_counterexample.gp`, `vdc_check2.gp`. *Proof verdict:* closes. *Rests on it:* H*; the downgrade of
Theorem C's corollary. *Prior art:* G56's ramified-dyadic mechanism. *Kernel:* declined.

**FS86-VD-10 — `λ_min(Γ₂₇) = −8`, Hoffman ratio `2/9 < 1/4`. [tools float, controls at 7, 11, 23, 31 matching B1's exact table to 9 digits; plant fires (after first firing for the wrong reason); D]**
*Proof:* D, `gamma27.py`. *Proof verdict:* closes at float grade with controls. *Rests on it:* H* at residue 𝔽₂₇ (never met by a quadratic
`E`). *Prior art:* G56's window table. *Kernel:* declined.

**FS86-VD-11 — ℚ(√−709) has one dyadic place, completion `ℚ₂(√3)`, and its stable odd places below 60 are only 23 and 31. [tools exact PARI; control ℚ(√59) returns FS86-A2's list; D]**
*Proof:* D, `vdc_709.gp`. *Proof verdict:* closes. *Rests on it:* ℚ(√−709) as an H* instance. *Prior art:* none. *Kernel:* declined.

## §6. Patchworks and one-sided defects (de Bruijn seat II; verifier X; W)

**FS86-dB-D0 — Theorem D₀, no threshold walls: for `h ≠ 0` additive, a colouring equal to one pullback `γ₁` on `{h < ε(residue)}` and another `γ₂` elsewhere is proper only if `γ₁ = γ₂`; false at `h = 0` (= W-D₀). [hand; de Bruijn, W blind (the same descent; the hypothesis `h ≠ 0` is W's D7)]**
The proof uses only gap-freeness of the dyadic levels plus density, so it holds on every real `F` with this dyadic tower — ℚ(√11) and K
included, where it cannot decide `F` (W's D9). *Proof:* de Bruijn §6.1; W § W-D₀. *Proof verdict:* closes with `h ≠ 0`. *Rests on it:*
nothing further (a corollary of D). *Prior art:* none. *Kernel:* declined.

**FS86-dB-D — Theorem D, two-phase rigidity: a four-colouring of the field plane agreeing at every point with one of two pullbacks is periodic — for every `F` with a row-67-type dyadic place (K and non-real `F` included) — and is itself a pullback (for real `F` with Lemma R (b), no V3) (= VX-D). [hand; de Bruijn (seat II: a residue digraph 8-in/8-out by Hoffman equality, `U₄`-closure, `−1 = 5t₊ + 5t₋ + 5·1` with `t± = −(3±4i)/5 ∈ U₄`), X blind (Lemma C and C′; the pullback half without V3)]**
The owner checked steps (b) and (d) (H-52). X's D4, D5: step 6 closes for every real `F` by density, step 7's finite index from finite rank
alone. *Proof:* de Bruijn §6.2; X § X-D, C2 (D2, D4–D7), C3. *Proof verdict:* closes; two derivations; the periodicity half also by a third
route (X's). *Rests on it:* D′, D₀, HD4. *Prior art:* a light zbMATH check found nothing stating D or H (de Bruijn §6.4). *Kernel:* declined.

**FS86-dB-Dp — Theorem D′: `γ₁` a pullback and `β` any function on residues mod `𝔓⁴`; a four-colouring with `c(z) ∈ {γ₁(πz), β(πz)}` everywhere is a pullback — for every real `F` with row 67's tower and Lemma R (b), with no V3 (X's widening; de Bruijn stated it under V3) (= VX-D′). [hand; de Bruijn (seat II), X blind (the same gap step, a different cycle lemma)]**
Reach: every multi-phase colouring in which each residue carries at most one colour besides `γ₁`'s. X's control: every two-phase colouring
over ℚ(√11) is a pullback too (FS86-VX-11), since `Γ₇`-colourings are never two-valued per dyadic residue. *Proof:* de Bruijn §6.3a; X §
X-D′, § Lemma C′, C2 (D1, D3, D8). *Proof verdict:* closes; two derivations. *Rests on it:* the no-go family. *Prior art:* none. *Kernel:*
declined.

**FS86-VX-C — Lemma C: over any number field with dense unit vectors, the additive semigroup generated by a residue cycle's fibre sums is a group containing `NR`, `N` depending only on `U₄` (no Waring-type input). [hand; X]**
*Proof:* X § Lemma C. *Proof verdict:* closes. *Rests on it:* X's route to D and D′. *Prior art:* none. *Kernel:* declined.

**FS86-VX-Cp — Lemma C′: for real `F` with row 67's tower and Lemma R (b), that group contains `R ∩ 𝔓^m` with `m ≤ 10` (odd stable places and K's second dyadic place: a Teichmüller `t` with `t − 1` a unit generates everything; at `𝔓`, Zariski density of an open subgroup). [hand + tools exact (`jp_check.py`: `𝔓¹⁰ ⊆ J_𝔓`, three plants fire); X]**
*Proof:* X § Lemma C′, `data/fs86/v-x/jp_check.py`. *Proof verdict:* closes (one mind; needs a second derivation before any row rests on it
alone). *Rests on it:* the V3-free forms of D and D′; the V3-free route to HD4. *Prior art:* none. *Kernel:* declined.

**FS86-VX-11 — Over ℚ(√11), every two-phase colouring (as in D′) is a pullback, although periodic colourings that are not pullbacks exist there. [hand; X]**
*Proof:* X C2 D3. *Proof verdict:* closes (one mind). *Rests on it:* the sharpness picture: D, D′ exclude patchworks everywhere, and ℚ(√11)'s
non-periodic colourings are odd-place gap colourings. *Prior art:* row 66. *Kernel:* declined.

**FS86-dB-H — Theorem H, unique continuation from a half-space: over every number field, real or not, with any number of colours, a proper colouring agreeing with a gap-free periodic colouring `γ` on `{h ≤ ε(z mod Q)}`, `h ≠ 0`, equals `γ`; so a non-periodic four-colouring disagrees with every pullback in every archimedean direction (= VX-H). [hand; de Bruijn (seat II: a descent on `M(x) = inf h`), X blind (a fixed-step walk; complex places harmless; `γ`'s properness unused)]**
Gap-freeness is necessary: a one-point repaint of a gapped `Γ₇`-pullback over ℚ(√11) breaks it (X). X's D9: the classes `C_a` are cosets of
`ker π`, not necessarily an ideal; density holds since `ker π ⊇ |Q|R`. Reformulation at ℚ(√59): `F(R) ≠ 0` iff every four-colouring agrees
with some pullback on some half-space. *Proof:* de Bruijn §6.3; X § X-H, C2 (D9–D11), C3. *Proof verdict:* closes; two derivations. *Rests on it:*
 the proved requirements on a non-periodic colouring. *Prior art:* nothing stating it (the symbolic-dynamics words "expansive
direction", "one-sided rigidity" not yet run, X's note). *Kernel:* declined.

**FS86-dB-HD4 — HD4: on the field plane of ℚ(√59), and of every real `F` with row 67's tower, every two-colour Kempe component of a pullback is a union of full `𝔓⁴`-fibres, infinite and `R ∩ 𝔓^m`-periodic; a Kempe swap of a pullback is a pullback, so the voltage-escape screen produces nothing at the field level (= VX-K). [hand; de Bruijn (seat III; V3, or Lemma C′ + D2-B), X independently (a corollary of X-D)]**
*Proof:* de Bruijn §7.6; X § X-D (adversarial attempt). *Proof verdict:* closes; two derivations. *Rests on it:* HD4's release item closed;
FS-76's Kempe screen is blind at the field level. *Prior art:* row 78's voltage-escape certificate. *Kernel:* declined.

## §7. Split places and extensions (Coxeter seat I; Poros (competition))

**FS86-Cx-C1 — For a place `v` of a real `F` split in `L`, the map into the hyperbola graph `H(F_v) = Cay(F_v², {(t, 1/t)})` is an injective graph homomorphism of the field plane. [hand; Coxeter; checked by Poros (competition)]**
*Proof:* Coxeter § First route. *Proof verdict:* closes. *Rests on it:* C2. *Prior art:* none. *Kernel:* declined.

**FS86-Cx-C2 — `F(R_F) ≠ 0` ⟹ `H(F_v)` has no four-colouring, for every split `v`; and (C2′) in `H(E)`, `char E ≠ 2`, a non-zero forced difference at `k` colours implies `χ(H(E)) > k`. [hand; Coxeter]**
So a four-colouring of one split local plane gives `F(R) = 0`; whether the isotropic plane `H(ℚ)` is four-colourable is open in print
(`[Madore2015]` ¶6.4, `[BardestaniMallahiKarai2017]` Rem. 1.3), so X (C2) stayed undecided and was withdrawn from K1 by Coxeter on Poros's
card #2. *Proof:* Coxeter § First route. *Proof verdict:* closes. *Rests on it:* nothing decided. *Prior art:* Madore, BMK (the open
question). *Kernel:* declined.

**FS86-Cx-C6 — For real `F ⊆ F′`, `F(R_F) ⊆ F(R_{F′})`. [hand, one line; Coxeter]**
*Proof:* Coxeter § Second line. *Proof verdict:* closes. *Rests on it:* C7. *Prior art:* monotonicity of forcing (row 78). *Kernel:*
declined.

**FS86-Cx-C7 — For every real finite `F′ ⊇ ℚ(√59)` (likewise 83, 131), no stable-place target local at the dyadic places has a gapped four-colouring at any level, and no odd stable target is four-colourable at any level; so the gap-transport route to a "no" through every extension is closed. [hand; Coxeter (via VK, Krasner, weak approximation, FS-66 at 11, Lemma P); Poros (competition) (a shorter route from V3 by restriction)]**
Scored by Poros as implied by T(2) (a gapped colouring of an extension's target restricts to a gapped colouring of `Cay(R_F, U_F)`), and
real in content; Coxeter records its own route as superseded, not retracted. One named gap: mixed dyadic–odd targets with a dyadic factor of
ratio `> 1/4`. *Proof:* Coxeter § Second line; Poros (competition) §7. *Proof verdict:* closes via V3. *Rests on it:* the no-go family.
*Prior art:* none. *Kernel:* declined.

## §8. S2 with triangles: ℚ(√2, √3) (Coxeter seat II; de Bruijn seat II; verifier C)

**FS86-Cx-C12p1 — C12.1: for every finite `E/ℚ₂` with `√3 ∈ E` and residue field `𝔽₂` (exactly the class where `E(i)/E` is unramified), the dyadic tower's level maps are 2-to-1 on connection sets (4-to-1 on vertices), FS38-L2 holds verbatim, `M ⊇ 𝔓^c` for some finite `c`, and the tower is four-tight at every level unconditionally (by L2's non-strict half; C12.1's "iff tight at levels ≤ c" is true but vacuous); what `c` buys is that every four-colouring at level `m ≥ c` is a pullback from `P_c` (= VC-C4). [hand; Coxeter, C blind (the scope, the class, the vacuity)]**
The correct replacement, in this class, for G54's withdrawn propagation sentence. *Proof:* Coxeter § Round 2 step 3; C § VC-12.1, C2.
*Proof verdict:* closes; two derivations. *Rests on it:* C12; the G54 correction. *Prior art:* FS38-L2, D2-B's induction. *Kernel:* stub
(Kooshi's named kernel target; a basis-free lemma on unramified dyadic towers).

**FS86-Cx-C12 — ℚ(√2, √3)'s dyadic tower `ℚ₂(ζ₂₄)/ℚ₂(√2, √3)` is four-tight at every level (exact at levels 1–8, minimiser counts 3, 9, 21, 45, 45, 45, 45, 45, identical to row 67's; `𝔓⁴ ⊆ M` by 40 sampled elements; trivial common kernel at level 4), so every four-colouring of every level `≥ 4` is a pullback from `P₄`; and ℚ(√2, √3) is in S2, with triangles (odd stable places `p ≡ 23 (mod 24)`, 23 by Hoffman's margin +0.039, `p ≥ 47` by Weil). [tools exact + hand; Coxeter (levels 1–8), de Bruijn (levels 1–5, independently), C blind (membership); the owner (the stable places below 300)]**
**The frame's transfer to ℚ(√2, √3) (Lemma R, Zhang) is argued, not re-derived** (Poros (competition)'s item (c)). *Proof:* Coxeter §
Round 2 step 3, `data/fs86/comp-coxeter/cs2/`; de Bruijn §6.5, `cs2_tower.py`; C C3 item 2; H-57. *Proof verdict:* closes for the tower;
the field-level membership at "argued". *Rests on it:* C13; C14's triangle-blindness at a member with triangles. *Prior art:* T721
(`[Soifer2024]` ch. 54: a triangle-full four-colour forced pair at distance 2 in ℚ(√2,√3)²). *Kernel:* declined.

**FS86-Cx-C13p0 — C13.0: in an unramified quadratic dyadic tower, `√−3` is congruent to a norm-one unit mod `𝔓^m` iff `m ≤ e(E/ℚ₂)`, the "if" with `t = 1` (so in ℚ(√2, √3)'s tower for `m ≤ 4`, in row 67's for `m ≤ 2`) (= VC-C5). [hand + tools exact (levels 1–6 of both towers); Coxeter, C blind]**
`N(1 + 2ω) = 3` and the norm maps `U^(m)` onto `1 + 𝔭^m`. *Proof:* Coxeter § Round 2 step 4, `cs2/sqrt3.py`; C § VC-13.0. *Proof verdict:*
closes; two derivations. *Rests on it:* C13. *Prior art:* local class field theory (standard). *Kernel:* declined.

**FS86-Cx-C13 — Over ℚ(√2, √3), given the frame's transfer: every periodic four-colouring gives `√3`-pairs different colours and 2-pairs the same; `F(R) ≠ 0` iff `(0, 2)` is four-colour forced; a yes makes every `√3`-pair a four-colour virtual edge, so one four-colouring with a monochromatic `√3`-pair proves `F(R) = 0` there; G75's hexagon identities hold on every periodic colouring for free. [hand; field-level parts given the §0.3 frame's transfer; Coxeter]**
*Proof:* Coxeter § Round 2 step 4. *Proof verdict:* closes at its conditional grade (not verified blind). *Rests on it:* the in-class
triangle question "is `√3` a four-colour virtual edge in ℚ(√2, √3)'s plane?" (a finite-witness question for single forcers; after the ban).
*Prior art:* T721 (a forced pair at distance 2; consistent). *Kernel:* declined.

## §9. The window no-go (Coxeter seat III; verifier C; the close planner)

**FS86-Cx-C14 — C14, the measurable-window no-go: for every S2 field and every finite set `S` of places containing the tight place `𝔓` (archimedean, odd stable at full level, split, `𝔓` at any finite level `m`), every proper four-colouring `W` of `Γ_S = Cay(G_S, T_S)` (`T_S` the product of the local circles) with measurable classes is `c ∘ π_𝔓` at every point, for one four-colouring `c` of `P_m` — a single pullback on all of `G_S` (C's sharpening of "finitely many cosets": the index is 1) — so every plane colouring `r ↦ W(ι_S(r) + t)` is periodic and local at `𝔓`, for every `t` (= VC-C1). [hand; two derivations (Coxeter seat III; C blind, the same route); inputs: at every real place AmbrusEtAl2023 Thm 1 (m₁(ℝ²) ≤ 0.2470; external, computer-assisted, published; not re-checked here), V3's all-levels bounds (FS-66's certificates at 11 and 19; Lemma P), row 67, Zhang 2012 Prop. 1.7]**
The proof: a measurable window form of Zhang's No-Homomorphism lemma (C14.1) and product rule (C14.3); local ratios (C14.2): the real place
`m₁`, odd stable places their all-levels ratio, split places ratio → 0 (Hoffman on growing windows with a Kloosterman count, error `≤
3/(2n+4)`; Coxeter's float FFT check at `p = 3, 5, 7, 13`); the non-tight part has ratio `< 1/4` (C14.4; its "`≈ 1/4 − 10⁻⁵`" at 31 is a
numeric slip for `1/4 − 2.745·10⁻⁶`, only "`< 1/4`" is used); one good fibre, then gap-freeness of the tight plane propagates it pointwise.
**Strict `m₁ < 1/4` is used; Hoffman's 0.2871 for the plane would not suffice.** Sharp: fails at ℚ(√11) (Γ₇'s 2/7; C9) and at K (a second tight
place, ratio exactly 1/4). Triangle-blind (holds at ℚ(√2, √3)). Realness enters only through `m₁` at real places (a complex place looks split;
C's sketch, not claimed). **Consequences:** FS-64's adelic window colouring and FS-83's layer method at `k = 4`, with any finite set of places,
cannot give `F(R) = 0` on S2; the plan's fallback (§S.5) was dead before it ran; a "no" must be non-measurable or read infinitely many places.
*Proof:* Coxeter § Round 2 step 5 (C14.1–C14.4); C § VC-14, C2 (rows 1–8), C3. *Proof verdict:* closes; two derivations, both flagged steps
checked (the measurable transplant; C14.2 (c)). *Rests on it:* the no-go family's widest member; FS86-CL1. *Prior art:* `[Zhang2012]` (the
finite theorem); `[AmbrusEtAl2023]` (the input); a measurable form of Zhang not found (two queries). **The external input's audit is a named
post-close item** (inventory item 70). *Kernel:* declined.

**FS86-VC-C2 — For every odd stable place `v`, the additive group generated by `T_v − T_v` is `O_{L_v}`; so the non-tight part of `Γ_S` is connected. [hand; C]**
*Proof:* C C2 row 6. *Proof verdict:* closes (one mind). *Rests on it:* C14's "one coset". *Prior art:* none. *Kernel:* declined.

**FS86-VC-C3 — If `P_m` is Hoffman-tight at four colours, then for any four-colouring of `P_m × H` with `H` connected, either every fibre over `P_m` is proper (and the colouring is a pullback) or none is — no S2 needed. [hand; C]**
*Proof:* C § VC-14 Half 1. *Proof verdict:* closes (one mind). *Rests on it:* C14; the K bookkeeping. *Prior art:* D2-A (tightness);
`[GodsilEtAl2020]` (vector form). *Kernel:* declined.

**FS86-Cx-C14p — C14′, regular windows: if `W` is proper only on pairs inside a conull set (polygonal cut-and-project windows included), then `W` is a.e. a `P_m`-pullback on each coset and the plane colouring is periodic for almost every placement `t` (a Choquet–Deny step). [hand; Coxeter (seat III)]**
*Proof:* Coxeter § Round 2 step 5. *Proof verdict:* closes (one reading by C, not verified). *Rests on it:* the no-go family. *Prior art:*
Choquet–Deny. *Kernel:* declined.

**FS86-Cx-C14K — The window form of VK: over any real field whose stable places are each four-tight at every level or of all-levels ratio `< 1/4` (K included), every measurable window colouring is a pullback from exactly one tight place, on all of `G_S` (= VC-C7). [hand; Coxeter (a sketch resting on VK), C blind (local, no VK: `P_m × P′_m` is four-tight with only pure minimisers)]**
*Proof:* Coxeter § Round 2 step 5; C C2 (C14-K), C3 item 3. *Proof verdict:* closes by C's route. *Rests on it:* C14's K control. *Prior art:*
plan §0.4's product-tightness step. *Kernel:* declined.

**FS86-CL1 — The type-(A) corollary: over ℚ(√47) and ℚ(√167), no four-colouring of the plane is a measurable window colouring over a finite set `S` of places whose split places are odd (`W` proper on `Γ_S`, or off a null set as in C14′); likewise for every real field with no stable dyadic place and every stable place of all-levels ratio `< 1/4`. [hand, one mind (the close planner), from C14.1–C14.3 (two derivations) and the all-levels ratios; external input AmbrusEtAl2023 at real places]**
Every factor of `Γ_S` has measurable independence ratio `< 1/4`: real places `m₁ ≤ 0.2470`; the stable odd places (ℚ(√47): 11 and 19 by FS-66's
certificates, 0.2331 and 0.2147; 23, 31 by Hoffman + Lemma P; `p ≥ 37` by Weil + Lemma P; the ramified 47 by Lemma P; ℚ(√167): 23 by row 75's
all-levels certificate or Hoffman 0.2491, 43 and above by Weil, the ramified 167 by Lemma P); odd split places → 0 (C14.2 (c)). By C14.3 the
product's ratio is the largest factor's, `< 1/4`, so four measurable independent classes cannot cover `G_S` (C14.1's window densities). The
dyadic places are split there (the wall is broken, `d ≡ 7 mod 8`); C14.2 (c) at `p = 2` is **not checked**, which is why `S`'s split places
are required odd. **Not implied:** anything about non-measurable colourings or infinitely many places, so nothing toward `χ ≥ 5` at ℚ(√47)
beyond excluding this format of falsifier; and nothing at five colours, where the count fails at the real place (Croft 1967's `m₁ ≥ 0.22936
> 1/5`, restated in `[AmbrusEtAl2024]`'s row), so FS-59's five-colour question and FS-64's aim at ℚ(√167) are untouched. *Proof:* this entry
(the brief's question, answered at the close). *Proof verdict:* closes, one mind; a second derivation owed before a row rests on it alone.
*Rests on it:* FS-84's and FS-83's re-aims (a falsifying four-colouring of ℚ(√47)'s plane is non-measurable or reads infinitely many places).
*Prior art:* none. *Kernel:* declined.

## §10. A correction the close found (the close planner, from D's retraction note)

**FS86-CL2 — Lemma R's density step fails at a stable dyadic place ramified in `L/F`, and so does its conclusion there: every unit vector is `≡ 1` modulo such a prime (G56), so the closure of `R` has residue image `𝔽₂` there — a proper suborder when the residue field is larger (`d ≡ 5 mod 8`: `𝔽₄`) or when there are two such places (`d ≡ 1 mod 8`: the diagonal of `𝔽₂ × 𝔽₂`); so `ℤ[U_F] ≠ O′` at, for example, ℚ(√5) and ℚ(√17). [hand, one mind (the close planner); D found the failing step (a Teichmüller idempotent that does not exist at a ramified dyadic place)]**
Every use in FS-86 is unaffected: ℚ(√59), ℚ(√83), ℚ(√131), ℚ(√11), K and ℚ(√2, √3) have no ramified stable place (odd stable places are always
inert in `L/F`; their dyadic places are inert), and type-(A) fields' dyadic places are split. Such fields are two-colourable (G56), so the
restriction costs nothing above two colours. *Proof:* this entry; D C1 (1) and its retraction note (H-74). *Proof verdict:* closes (one
mind). *Rests on it:* Lemma R's scope line. *Prior art:* `[Fischer1990b]` Thm 5 gives the ring in closed form for real quadratic fields (to
compare when FS-47 opens). *Kernel:* declined (FS-47's stub carries the corrected scope).

## §11. Conjectures and readings this milestone stated and did not prove (the close's sweep)

- **HD1** (Poros (plan)): `Θ₄(R) ⊆ T` on type-(B) planes. Open; the finite-type case is proved (HD1-fin); the rest needs an `S`-adic
  measure-rigidity theorem for the unit-vector action on `R̂` with isometric archimedean directions (de Bruijn §7.5, Coxeter C15's reading,
  reached independently), or HD1-cert's certificate (after the ban). **Stub: the missing theorem** (`plans/STUB-isometric-measure-rigidity.md`).
- **Lemma X** (D): restores Theorem C's unrestricted form; true on `T + A + Fin`, open outside. Stub-carried with the missing theorem.
- **The colouring-level Hasse principle at L = 4** (de Bruijn §3): in S2 with the tight place's local plane rigid through triangle-free
  configurations (`4 ∈ F_tf`), `F(R) ≠ 0`. No evidence toward it; killing test a non-periodic four-colouring of ℚ(√59)'s plane. **Declined as
  a stub of its own**: it is the milestone's own question with a hypothesis added; carried in the FS-86 stub's § after the close.
- **"Is `4 ∈ F_tf`?"** (de Bruijn §1.6, T1): the local triangle-free question. Carried in the FS-86 stub.
- **The reading "non-real Theorem-C planes are rigid; ℚ(√59)'s obstruction is its real place"** (de Bruijn §5.3). Killing test: a
  non-periodic four-colouring of ℚ(√−709)'s plane. Carried with the missing-theorem stub (its non-real case).
- **Prop. D's Waring lemma**: superseded by Theorem D (unconditional); declined.
- **The three-phase case** (de Bruijn §6.3a): residues where `c` chooses among three pullbacks' colours. Stub (with the missing theorem;
  the brief's candidate (c)).
- **C14 at infinite dyadic depth, at complex places, and for joint windows over infinitely many places** (Coxeter-3; C C3): remarks and a
  sketch, not claimed. Carried in the missing-theorem stub.
- **"Is `√3` a four-colour virtual edge in ℚ(√2, √3)'s plane?"** (C13): a finite-witness question. Stub (sanctioned-search candidate).
- **"Is `H(ℚ)` four-colourable?"** (C2; open in print): declined as a stub of ours (Madore's and BMK's question); recorded in
  `CLOSED-QUESTIONS.md`'s neighbourhood only if it bears.
- **Coxeter's R2.6 reading** (FS-85: triangle-free frequencies generically non-torsion): untested by FS-86 (no pinning identity was found in
  either direction); G75's killing test did not fire.
