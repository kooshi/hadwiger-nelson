# FS-91 (crunch milestone M1) — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-25 at M1's close (WORKFLOW 2.0 step 9) by crunch job J23a (de Bruijn, Opus 5.5, M1's close planner), from the plan
(`plans/FS91-character-local-global.md`, the planner J03) and the nine job records: `plans/FS91-S0V-band-to-nine.md` (J01),
`plans/FS91-S0V2-SWm-second-reading.md` (J03a), `plans/FS91-S0F-three-colours.md` (J02), `plans/FS91-S0FV-three-colours-blind.md` (J09),
`plans/FS91-S1D-character.md` (J07), `plans/FS91-S1V-character.md` (J10, resumed as J10b), `plans/FS91-S1D-six.md` (J08),
`plans/FS91-S1V-six.md` (J11), `plans/FS91-S1D-one-prime.md` (J12). The blind check of J12, J13 (`plans/FS91-S1V-one-prime.md`), had not
reported when §6 was filed; its entries read "J13 pending". Grades are `CLAUDE.md` § Notation's, as each record gives them. A proof held in
a record is not repeated here; this file is the index that survives the ledger rows' compression. `LEDGER.md` § B will index every entry,
one line each (drafted in the plan's §R-close). **M1 added no Lean**, so nothing below is kernel-checked; every kernel decision is recorded
per entry.*

**Duplicates are merged, one entry per theorem.** An entry carries the id of its first full derivation, and its title names every other id
the records give the same theorem (`= J10-T6`, `= J11-T4`, …), so a grep for any id lands here. Independence is stated per entry, in the
records' own words: **blind** means the deriver had seen neither the other derivation nor its statement; **from the statement** means it
had seen the statement, not the proof (J10's and J11's phase 2, J09's stage 4). Where a record and a later record or report differ on a
grade, both are filed with addresses (`plans/CRUNCH-2026-09-25-INDEX.md` §2.3 lists the differences). **Corrections owed are applied as
filed** where a later record corrected a statement: J10-T8's GAP in J07's (g3); J11's CLG_16/CLG_21 in place of the planner's
"CLG_6 and CLG_7" (SIX-e); J11's `χ(ℚ(√167)²) ≤ 7` in J08-8's bracket; J09's restriction step in J02 §2.10; J03a's over-count of its own
`k`-lines; J10's two wording notes on CLG_k and CLG-f.

**Who found what.** **J03** (the planner): J03-1 to J03-4, one mind, handed on to be re-derived. **J01** (blind verifier of FS-89's PA-B2
and PA-B3): J01-1 to J01-8. **J03a** (blind second reader of J01's all-band step): J03a-1 to J03a-9. **J02** (three colours, from an
advisor's sketch): J02-L1 to L4, T1 to T3, C1, C2, A2.1′. **J09** (blind derivation beside J02; J02's statements opened at its stage 4):
J1, J2, J3, J-K, J4, J4-C, J4-A, J2′, J-L4b, J4-T6. **J07** (the class theorem): J07-1 to J07-15. **J10/J10b** (blind verifier of J07;
phase 1 blind, phase 2 from J07's 25 statements): J10-L1 to L8, J10-T1 to T9. **J08** (six at the exposed fields): J08-1 to J08-11, J08-R.
**J11** (blind verifier of J08; phase 2 from J08's statements): J11-T1 to T13 and the `Γ₁₁` remark. **J12** (one prime): J12-A1 to C3p.

**Notation, fixed once** (J07's `data/fs91/j07/lemma-statements.md` header, which carries FS-89's §0.1 with the corrected `A`). `F` a real
number field (finite degree, `F ⊆ ℝ`; other embeddings may be complex), `L = F(i)`, `c` complex conjugation, `U = U_F = {u ∈ L : u·c(u) = 1}
= T(F)` with `T = R¹_{L/F}𝔾_m`, `R = R_F = ℤ[U]`. A **stable place** is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`; `T(F_𝔭)` the local norm-one
group, `S_{𝔓,m}` its image in `O_𝔓/𝔓^m`, `T_{𝔓,m} = Cay(O_𝔓/𝔓^m, S_{𝔓,m})` the **residue target at level `m`**. `B_β = {z ∈ ℝ/ℤ : ‖z‖ ≥ β}`,
`B_k = B_{1/k}`; `Θ_β(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ B_β}`, a **band character** a point of it; a band-`β` character of `Cay(G, S)` is a
homomorphism `λ : G → ℝ/ℤ` with `λ(S) ⊆ B_β`. `χ_char(G, S)` is the least `k` with a band-`k` character (∞ if none); `χ_char(F²)` the least
`k` with `Θ_k(R_F) ≠ ∅`; `κ(G, S) = max{β : some band-β character}` (the lonely-runner / view-obstruction parameter), `χ_char = ⌈1/κ⌉`.
**`A(R_F) = {ℓ mod 1 : ℓ ∈ Hom_ℚ(L, ℝ)}`** — the archimedean characters of **every** place of `L`, not one embedding's `λ_e` (J03a-9: with
one embedding the field clause is false). `T`: torsion characters, `T_N` those killed by `N`. `H_k`: `Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)` for
every `F ⊆ ℝ` (FS91-J01-7). For `Q = ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (4)]`, `R_S`, `U_S`, `w_p`, `RS_k(S)`, `RQ_k`, `MS_k(S)`, leaves and corners:
`plans/FS89-derivation.md`'s notation paragraph, with the `A` above. `Γ_q = Cay(𝔽_{q²}, μ_{q+1})`; `V_c = {t ∈ 𝔽_q : t² − 4c` a non-square or
0`}`; `λ_a(x) = Tr(ax)/q`.

**Scope, stated once.** Every statement below from §1, §2 and §4–§6 is about **characters** — colourings `x ↦ ⌊kθ(x)⌋` — never about `χ`:
from four colours up the emptiness of `Θ_k` is one-sided (G71), and a colouring no character gives is untouched. §3 is the exception: at
three colours every colouring of a real field's plane carries a character (FS73-T22, FS81-T2), so §3's statements are about `χ`.
"Not found in print" is not "new".

**Prior art, at this filing.** M1's close-time gate (J23p, `plans/FS91-PA-close.md`) is running. Its first verdict (owner's forward,
inventory item 130): **band rigidity at every band (§1) is PARTLY IN PRINT** — `[Manners2015]` Lemma 5.3 proves the `RS_k` shape for
`ℤ[i][1/P₅, 1/P₁₃]` (one Gaussian prime above each of 5 and 13) under `⟨θ₅, θ₁₃⟩`; the full `R_S` (both primes above each `p`), other `S`
and the field clause are not there; `[Wang2012]` Prop. 4.3 and Lemma 4.2 are J01-2's architecture. Every other entry reads "pending the
close gate" until J23p's verdicts land; named held inputs (Berend, Furstenberg, Weil, Astra, Fischer) are cited per entry.

## §1. Band rigidity at every band (J01 blind; J03a the second blind reading)

**FS91-J01-1 — `(R̂_S, U_S)` is a group ℱ-flow in `[Berend1984]`'s sense for every nonempty finite `S` (`Σ^{(k)}` = congruence subgroups mod `q^{k−1}`, `q ∉ S`), so every minimal set is restricted (Thm I.2). (= FS89-PA-B1's flow claim, re-derived with the chain explicit.) [hand; J01 one mind; FS-89's Berend reader reached the ℱ-flow claim first]**
*Proof:* `plans/FS91-S0V-band-to-nine.md` stage 2 §2.3 (hypotheses (1)–(3) of `[Berend1984]` checked for this action). *Proof verdict:*
closes. *Rests on it:* FS91-J01-2's case 1. *Prior art:* the frame is `[Berend1984]`'s (Thm I.2, Prop. II.6). *Kernel:* declined (rests
on `[Berend1984]`).

**FS91-J01-2 — PA-B2: for `|S| ≥ 2` every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A` (band-free); hence `MS_k(S)` at every `k`. (= FS89-PA-B2, now blind-verified; case 1 by a second route = J03a-4.) [hand; two derivations of FS-89's claim: J01 blind (stage 2); J03a-4 a second route for case 1, "hypotheses checked at sketch level"]**
Case 2 by D1-L2, case 1 by D1-L3 (`M − M = R̂_S`) and then `M = R̂_S` by `[Berend1984]` Thm I.2 with Prop. II.6 (J01), or by the joining
`J = {(g, x) : x + g ∈ M}` and Furstenberg's F-flow disjointness (J03a-4). No line reads `k` (J01 §2.4: "Where the value of `k` is used in
stage 2: nowhere"). *Proof:* J01 stage 2 §2.1–§2.4; J03a §3.2 and divergence row 4 ("J01's check of the hypotheses is the more careful
one"). *Proof verdict:* closes. *Rests on it:* FS91-J01-6, J01-7, J03a-3. *Prior art:* `[Berend1984]` Thm I.2; Furstenberg's disjointness
(`[Furstenberg1967]`); J23p: `[Wang2012]` Prop. 4.3 and Lemma 4.2 are this architecture. *Kernel:* declined.

**FS91-J01-3 — The parity (doubling) lemma: a case-1 minimal set in `Θ_β` yields `2y ∈ Θ_{2β}`; with the antipodal refusal above band 1/4, `MS_β(S)` for every `β > 0`, `|S| ≥ 2`, without Berend. [hand + tools exact (B1, B2); one mind (J01); J03a did not verify it ("outside my brief"); owner ruling (item 67): a named hypothesis]**
The band edge doubles past 1/4 in `⌈log₂(k/4)⌉` steps or hits 1/4 and the singleton `{θ₂}`. *Proof:* J01 §3.6.2 and the stage-3
sections. *Proof verdict:* closes on one reading. *Rests on it:* nothing (a second route to FS91-J01-2's conclusion inside a band).
*Prior art:* pending the close gate. *Kernel:* declined (no consumer).

**FS91-J01-4 — Lemma SW as written (one digit) holds exactly for `k < 2p` (sharp: an explicit offset at `k = 10`, `p = 5`). [hand + tools exact (A2); J01; the edge reproduced independently by J03a's plant P1 (divergence row 3: "agreement, independent tools")]**
*Proof:* J01 §3.6.1 step 2; `tools/crunch_j01_sweep_check.py`. *Proof verdict:* closes. *Rests on it:* FS91-J01-6's range `k ≤ 9` at
`{5, 13}`. *Prior art:* FS89's Lemma SW. *Kernel:* declined.

**FS91-J01-5 — Lemma SW-m, the multi-digit sweep: "Let `S` be a finite set of primes `≡ 1 (mod 4)`, `k ≥ 3`, `v | p ∈ S`, `x ∈ R̂_S`, `c₀ ∈ K_v`, `s ∈ ℤ`. Then not every `x + c̄` with `c ∈ c₀ + π_v^s O_v` lies in `Θ_k(R_S)`." (= J03a-1, at every `k ≥ 2`.) [hand + tools exact; two blind readings: J01 (stage 3b; plant P4 fires first at `k = 10`) and J03a (§2.1; `tools/crunch_j03a_sweep.py`, three plants)]**
Take `m` least with `p^m > k/2` and the expanding power `w_p^{±(s+m)}`: the values fill a coset of `(1/p^m)ℤ/ℤ`, one point of which lies within
`1/(2p^m) < 1/k` of 0. *Proof:* J01 stage 3b (the audit, six points); J03a §2.1, §2.2. *Proof verdict:* closes; J03a's divergence table:
"the multi-digit step … has now had two, and it is two lines". *Rests on it:* FS91-J01-7 (the band enters the whole chain exactly once,
here: J03a divergence row 5). *Prior art:* the one-digit form is FS89's; J23p's verdict on the rigidity it serves: partly in print
(`[Manners2015]` Lemma 5.3). *Kernel:* declined (no consumer; a candidate if FS91-J01-7 is ever ported).

**FS91-J01-6 — PA-B3 at `k = 6, 7, 8, 9`: `RS_k(S)` for every `|S| ≥ 2` and `RQ_k` (the one-digit lemma suffices). (= FS89's PA-B3 reading, blind-verified.) [hand + tools exact; J01 blind, as FS-89's verifier; owner ruling (item 18, superseded by 67): consumed as verified]**
*Proof:* J01 stage 3 (`k = 6, 7, 8, 9` sections, §3.6.1–§3.6.3, stage-3 summary table). *Proof verdict:* closes. *Rests on it:* `H_k`
at `k ≤ 9` independently of FS91-J01-5. *Prior art:* as FS91-J01-7. *Kernel:* declined.

**FS91-J01-7 — Band rigidity at every band: `RS_k(S)` for every `k` and `|S| ≥ 2`, `RQ_k` for every `k`, and `Θ_k(R_F) ⊆ T + A` for every `F ⊆ ℝ` (with FS89-S0A-2); equivalently, for `|S| ≥ 2` every character of `R_S` outside `T + A` takes values arbitrarily close to 0 on `U_S`. (= J03a-3 (`RS_k`, `MS_k`, every `k ≥ 2`), J03a-7 (`RQ_k`: `Θ_k(Q) ⊆ T_{N_k} + A`), J03a-8 (`Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)`, `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, every `F ⊆ ℝ`, every `k ≥ 2`).) [hand; J01's record: "hand, one mind" (written before J03a); two blind readings, J01 and J03a, agreeing (J03a stage 5: "Differences of truth: none"); owner ruling (item 67): verified at every `k`, with the wide `A`]**
The chain: PA-B2 (FS91-J01-2), VB1 with SW-m (FS91-J01-5, J01-8), VB3/VB4 and the band-free gluing FS89-S0A-2. `N_k` is non-effective.
**Scope qualification (J03a divergence row 10):** J01's field clause is right in S0A's convention for `A`; with one embedding's `λ_e`
it is false (FS91-J03a-9). *Proof:* J01 stage 3b; J03a §3.2–§3.4. *Proof verdict:* closes, twice. *Rests on it:* `H_k` for every `k` —
the input of CLG (FS91-J07-7) at every band; FS91-J08-9–J08-11; row 95's "Not claimed … six is unchecked" (answered, on characters).
*Does not give:* the explicit band-`k` torsion list at `k ≥ 7` (J08 gives `k = 5, 6`), any bound on `N_k` beyond finiteness, anything
about `χ` or non-character colourings. *Prior art:* **partly in print** (J23p, item 130): `[Manners2015]` Lemma 5.3 is the one-ring,
two-prime special case (`ℤ[i][1/P₅, 1/P₁₃]`, one Gaussian prime above each); the full `R_S`, other `S` and the field clause are not there,
and the passage from Manners's ring to `R_S` is a gluing, not formal (at one prime the gluing fails, §6); `[EinsiedlerLindenstrauss2022]`
p. 3 calls the solenoid form of `[Wang2012]` Thm 1.10 unwritten. The classical analogue is Furstenberg's ×2×3 (J01 audit point 6).
*Kernel:* declined for now (Berend's Thm I.2 is not in Mathlib); a stub candidate if a write-up needs it.

**FS91-J01-8 — VB1 at every band, `|S| ≥ 2`, reads `k` only through its call to SW-m; VB3, VB4, D2-L1 and S0A's G1 use the band only as the same band on both sides. (= J03a-2.) [hand (+ tools exact for JC's radius, J03a); two blind readings: J01 §3.6.1 steps 3–4 (at `k = 6`), J03a §3.1 (every `k ≥ 2`); J03a's divergence rows 7–8: agreement]**
*Proof:* J01 §3.6.1; J03a §3.1, §3.5. *Correction applied:* J03a's §3.2/§3.5 counted "`0 ∉ B_k`" as a second `k`-reading line;
`R̂_S` is never minimal, so it needs no `k` (J03a divergence row 5; inventory item 63). *Rests on it:* FS91-J01-7. *Prior art:* FS89's
VB1–VB4. *Kernel:* declined.

**FS91-J03a-5 — `Θ_2(R) ⊆ T_2` for every `R = ℤ[U]`. [hand, one line; one mind (J03a)]**
*Proof:* J03a §3.2. *Rests on it:* the `k = 2` end of FS91-J01-7's statement. *Prior art:* elementary. *Kernel:* declined (no consumer).

**FS91-J03a-6 — VB3 at every band, and the order transfer `ord(τ) = ord(τ|_{ℤ[i]})` for torsion characters of `Q`, so `Θ_k(Q) ∩ T` is finite with orders dividing `N_k`. [hand; one mind (J03a); J01 reached the bound "finite at `R₆₅`, hence bounded" by VB4 instead (divergence row 9: "an alternative … no conflict")]**
*Proof:* J03a §3.3. *Rests on it:* nothing further (FS91-J01-7 reads VB4's `T_N + A` directly). *Prior art:* pending the close gate.
*Kernel:* declined.

**FS91-J03a-9 — With `A` read as one embedding's `λ_e`, the field clause is false: over ℚ(√3), `τ + Re(ē σ₂(·))` (`τ` the additive three-colouring, `0 < |e| ≤ 1/12`) is in `Θ₄` and not torsion plus `λ_f`. [hand; one mind (J03a); its consequence for FS89-CL2's wording agreed by J07 (J07-14) and J10 (§3.1 item 25)]**
*Proof:* J03a §3.4. *Rests on it:* the corrected notation above; the correction owed to `plans/FS89-derivation.md`'s notation paragraph
and FS89-CL2 (inventory items 61, 69, 78). *Prior art:* none needed (a counterexample). *Kernel:* declined.

## §2. The unit-vector ring of a real number field, with no Galois hypothesis (J07, J09, J10, J02)

**FS91-J07-3 — Lemma C: "For every real number field `F` and prime `p`: inside `L ⊗ ℚ_p = V_s × V_n` (stable and non-stable primes above `p`), `R ⊗ ℤ_p = R̄_p × V_n`, where `R̄_p`, the closure of `R` in `∏_{stable 𝔓|p} Ô_𝔓`, is an open subring of finite index; hence `R/p^jR ≅ R̄_p/p^jR̄_p` for all `j`, `R/NR ≅ ∏_{p|N} R̄_p/NR̄_p`, `dim_{𝔽_p} R/pR = Σ_{stable 𝔓|p} [L_𝔓 : ℚ_p]`, and for every `N` there is `K` with `R ∩ ∏_{stable 𝔓|N} 𝔓^K ⊆ NR`. No Galois hypothesis." (= J10-T6's first half; its last clause = J10-L3: a torsion character of order dividing `N` factors through `∏_{𝔓 | cN} O_𝔓/𝔓^M`.) [hand; J07's record: one mind; J10 re-derived it from the statement by an independent route (J10 §3.2, divergence row 1: "both close; independent"); J10-L3 blind in phase 1]**
J07's route: a Cayley–Hamilton projector `P(u)`, `u = c(a)/a`, `(a) = 𝔔^h`, kills every other place. J10's: `cO′ ⊆ R` (FS91-J10-L1) and
`O′ ⊗ ℤ_p = ∏Ô × V_n`. *Proof:* `plans/FS91-S1D-character.md` §2.3; `plans/FS91-S1V-character.md` §2.2 (L3), §3.2. *Proof verdict:*
closes, twice. *Rests on it:* CLG_k's ⟹ (FS91-J07-7, through the factorisation); FS91-J07-4, J07-5. *Prior art:* pending the close gate
(J07 flagged "orders generated by a norm-one torus's rational points … likely classical in parts", inventory item 80). *Kernel:* stub
(FS-47, the unit-vector ring in the kernel, gains Lemma C/C′ as its statement — inventory item 79).

**FS91-J07-4 — Lemma C′: "`R̄_p = ∏_{stable 𝔓|p} Ô_𝔓` (equivalently `R/NR ≅ ∏_{stable 𝔓|N} O_𝔓/NO_𝔓` for `N` a power of `p`) for every `p`, except possibly `p = 2` when some stable dyadic place is ramified in `L/F`; inert stable dyadic places always split off as full factors. No Galois hypothesis." (= J10-T6: "`R_F = O′` and `R_F` dense in every finite product of stable completions, for every real number field with no ramified stable dyadic place — no Galois hypothesis; the ramified exception holds at ℚ(√5), ℚ(√17), ℚ(α) and fails to occur at ℚ(√2)"; J09's J2 is the same statement at every `p` with no ramified stable prime above it: "`ℤ[U_F]_(p) = O′_(p)` …; `R/pR ≅ ∏_{S_p} O_𝔓/p`; `1/p ∈ R` if `S_p = ∅`; `R = O′` if no stable prime ramifies (FS86-B1-LR without "L/ℚ Galois")".) [hand; three derivations — J09's J2 blind (stage 2 §2.2); J07-4 (one mind by its record; J07 read J2's heading, not its proof, after deriving C′ — held item, inventory 114, on which C′'s independence rests); J10-T6 from the statement, with tools exact at seven field–prime pairs and four controls. The owner's ruling (item 68) reads J2 as one mind; J07-4 and J10-T6 reach its completed form independently (index §2.3)]**
The routes differ: J09 by orders, the class group and density; J07 by a Teichmüller idempotent and an element of valuation 1; J10 by the
graded pieces of the smooth torus (`Σ_{μ_{q+1}}(z − 1) = 1` in characteristic 2). J10's scope data make "except possibly" exact.
*Proof:* J09 §2.2; J07 §2.4; J10 §3.2 and `tools/crunch_j10_phase2.py` (D). *Proof verdict:* closes, three times. *Rests on it:* the
correction owed to FS86-B1-LR's scope line (drop "`L/ℚ` Galois"; inventory items 13, 78); FS91-J07-5's product form; FS91-J09-J4 (J2 at 3
and 2). *Prior art:* FS86-B1-LR (with the Galois hypothesis); G55's prime inversion (`[Fischer1990b]` for quadratic and multiquadratic
fields); pending the close gate for the general form. *Kernel:* stub (FS-47).

**FS91-J02-L2 — "`A_p = R/pR` is a finite `𝔽_p`-algebra with `dim A_p ≤ n`, and `c` induces a ring involution on it"; every maximal ideal `𝔪 ∋ p` of `R` equals `R ∩ 𝔓` for a stable prime `𝔓 | p` of `L`, and `c(𝔪) = 𝔪`; full residue fields `𝔽_{q²}` with `𝒩(k_𝔪) = μ_{q+1}` at unramified stable primes, `𝒩(k_𝔪) = {1}` at ramified ones; every `p`. (= J09's J2′: `ℤ[U_F]/p ≅ Ā_p/pĀ_p`, `Ā_p` the closure in `∏_{S_p} O_𝔓`, of dimension `Σ_{S_p}[L_𝔓 : ℚ_p] ≤ [L : ℚ]`.) [hand (GPT Astra's Lemma 1.1 and §3.1–3.2, extended from `p = 3` to every prime); two derivations: J02 §2.3 and J09 §4.2 (from the statement; J09 stage 4 row L2: "TRUE; … the general case derived now")]**
*Proof:* `plans/FS91-S0F-three-colours.md` §2.3; `plans/FS91-S0FV-three-colours-blind.md` §4.2. *Proof verdict:* closes, twice. *Rests on
it:* FS91-J02-L3, J02-T1. *Prior art:* GPT Astra (`reference/ChatGPT-local-global-tightness-conjecture/`), Lemma 1.1 at `p = 3`. *Kernel:*
stub (FS-47; FS-75's re-aimed chain, inventory item 11).

**FS91-J10-L1 — "for every real number field `F`: `R_F` = ℤ-span of `U_F`; `ℚR_F = L`; `R_F ⊆ O′`; `O_L[U_F] = O′`; `cO′ ⊆ R_F` for some integer `c ≥ 1`." [hand; J10 blind, one mind; items (b), (c) = J07's U1, U2, verified by J10 (§3.1 items 1–2)]**
Item (e) is the step of FS86's Lemma R that survives CL2 (J10's inventory proposal, item 88). *Proof:* J10 §2.2. *Proof verdict:* closes.
*Rests on it:* J10's route to Lemma C (FS91-J07-3). *Prior art:* pending the close gate. *Kernel:* stub (FS-47).

**FS91-J02-L3 — The Teichmüller section `T_p = {a^{p^M}}` of `R/pR` is a `c`-stable subring `≅ ∏_{𝔪 ∋ p} k_𝔪`, and "every `s ∈ 𝒩(T)` is the image of a unit vector `u ∈ U`. In particular the image of `U` in `R/6R` contains the product set `𝒩(T₃) × 𝒩(T₂)`" (the joint Hilbert-90 lift). [hand (Astra §3.3, extended to `R/6R`); two derivations: J02 §2.4; J09 §4.2 (first half derived from the statement; the second half is J09's J3)]**
*Proof:* J02 §2.4 (`[u] = b/c(b)` from `u·c(a) = a` reduced mod `6R`); J09 §4.2. *Proof verdict:* closes. *Rests on it:* FS91-J02-T1's
step 2 — "the only step without a precedent" (J02 §4.4). *Prior art:* GPT Astra's Teichmüller subring and Hilbert-90 lift; the joint 2-and-3
lift coupling the parity type to the order-3 type is J02's (§4.2 Credit). *Kernel:* stub (FS-75's re-aimed chain).

**FS91-J07-5 — (J) Joint image, CLG-c in its corrected form: "The image of `U` in `R/NR` is the image of `∏_{stable 𝔓|N} T(F_𝔭)`; when no stable place above `N` is ramified dyadic it is `∏_𝔓 S_{𝔓, v_𝔓(N)}` under Lemma C′'s isomorphism; every fibre of `U → R/NR` is dense in `∏_{w|∞} T(F_w)`." [hand (weak approximation standard); verified by J10 from the statement (§3.1 item 10: "the correction is right: at a ramified stable dyadic place the image is *not* `∏ S` in general"); J10's fibre density by its own route (divergence row 3)]**
*Correction applied:* the plan's CLG-c ("the product, over the stable places `𝔓 | N`, of the images of the local norm-one groups") is the
literal form, TRUE except at ramified stable dyadic places, where it is ill-posed (J07 §5.1). *Proof:* J07 §2.5. *Proof verdict:* closes.
*Rests on it:* FS91-J07-7 (the sumset step). *Prior art:* weak approximation for the norm-one torus (a rational variety). *Kernel:* declined.

**FS91-J10-L2 — (W) weak approximation: "`U_F` is dense in `∏_{v∈Σ} T(F_v)` for every finite set of places `Σ`, archimedean included; `U_F → ∏ S_{𝔓,M}` is onto." (= J07's item 9 (W); = J09's J3, independence of finitely many stable places for `U_F`.) [hand, standard; three derivations: J10 phase 1 blind, J07 §2.5 (as input (W)), J09 §2.3 blind]**
At a real place `T(F_v) = S¹`, at a complex place `T(F_w) ≅ ℂ^×`. *Proof:* J10 §2.2; J09 §2.3. *Proof verdict:* closes. *Rests on it:*
FS91-J07-5, J07-7, J09-J4, J02-L3's second half. *Prior art:* standard (weak approximation on a rational torus). *Kernel:* declined.

## §3. Three colours: the local–global conjecture at `L ≤ 4` for every real number field (J02, J09; statements about `χ`)

**FS91-J02-L1 — Torsion extraction: `Θ₃(R_F) ≠ ∅ ⟹ Θ₃(R_F) ∩ T₆ ≠ ∅`, every `F ⊆ ℝ`: "if `θ ∈ Θ₃(R_F)`, then `τ(x) := lim_k θ(25^{−k}x)` is a character of `R_F` with `6τ = 0` and `τ(U_F) ⊆ {1/3, 1/2, 2/3}`". [hand, a composition of FS81-T3 and T4; two derivations: J02 §2.2, J09 (stage 4 row L1: "TRUE; already established", FS81-T4 as used in J1)]**
*Proof:* J02 §2.2. *Proof verdict:* closes. *Rests on it:* FS91-J02-T2 ((2) ⟹ (3)). *Prior art:* FS81-T3, T4 (this project's); pending the
close gate for the statement. *Kernel:* stub (FS-75's chain).

**FS91-J02-L4 — Norm-one functionals: (a) "For `q = 3^f`, `f` odd, an additive `λ : 𝔽_{q²} → (1/3)ℤ/ℤ` with `λ(t) ≠ 0` for every `t ∈ μ_{q+1}` exists iff `q = 3`"; (b) "For `Q = 2^f`, no additive `λ : 𝔽_{Q²} → (1/2)ℤ/ℤ` equals 1/2 on all of `μ_{Q+1}`." (= J09's J4 step 7 for (a), zero count `(q+1−2K)/3`; (b) = J09's J-L4b.) [hand + external (Weil) + tools exact (`q = 27, 243`, `Q ≤ 32`); two derivations: J02 §2.5, J09 §2.5 and §4.2]**
(b) is one line: `Σ_{t∈μ_{Q+1}} λ(t) = λ(0) = 0` while `(Q+1)·½ = ½`. *Proof:* J02 §2.5, `tools/crunch_j02_additive_check.py` (plants fire);
J09 §2.5, §4.2, `tools/crunch_j09_lemma_k.py`. *Proof verdict:* closes. *Rests on it:* FS91-J02-T1, J02-C2; at `q = 27` it is the same fact
as FS91-J08-R's (no character of `𝔽₇₂₉` misses `μ₂₈`). *Prior art:* Weil's bound. *Kernel:* declined (rests on Weil above 243).

**FS91-J09-J1 — The typing, read on `τ₂`, `τ₃`: `τ₃(u) = 0 ⟺ τ₂(u) = 1/2`; `α = τ₂ = 0` on O-type layers. [derived from FS81-T3, T4; one mind (J09)]**
*Proof:* J09 §2.1. *Rests on it:* FS91-J09-J4; J09's route B to S3. *Prior art:* FS81-T3/T4. *Kernel:* declined.

**FS91-J09-J-K — Lemma K1 is FALSE at `q = 27` exactly for `N(a) = 1` (`Tr_{𝔽₇₂₉/𝔽₉}(μ₂₈) ∩ μ₄ = ∅`); true at 243; false at 3 exactly for `N(a) = −1`; the count `(4/9)[(q+1) − K(n) + 2K(−n)]`. [tools exact, two representations; one mind (J09)]**
It kills J09's own C0 route (rotation invariance plus a character count) at exactly its named risk (inventory items 14, 16). *Proof:* J09
§2.4; `tools/crunch_j09_lemma_k.py`, `data/fs91/j09/`. *Proof verdict:* closes (a finite exact computation). *Rests on it:* nothing (a
refutation of a route). *Prior art:* none needed. *Kernel:* declined (no consumer).

**FS91-J02-T1 — The torsion local–global theorem at three colours: "A character `τ` of `R_F` with `6τ = 0` and `τ(U_F) ⊆ [1/3, 2/3]` exists iff `F` has a stable prime above 3 whose residue field is `𝔽₃`, or a stable prime above 2 ramified in `F(i)/F`." [hand; two derivations: J02 §2.6; J09 (stage 4 row T1: ⟹ is J4 applied to `τ`, ⟸ J4 step 8 and the dyadic residue character); reproduced as a control by J07 for every `θ ∈ Θ₃` (FS91-J07-15)]**
*Proof:* J02 §2.6 (L1, L3's product set, L4). *Proof verdict:* closes. *Rests on it:* FS91-J02-T2, J02-C2. *Prior art:* pending the close gate;
the `k = 3` torsion case of CLG. *Kernel:* stub (FS-75).

**FS91-J09-J4 — No mixing: "for a real number field with no ramified stable dyadic prime, `Θ₃(R_F)` is exactly the `4N₃` additive characters, one quadruple per prime above 3 of residue field `𝔽₃`" — the parity and order-3 parts live at disjoint places and weak approximation makes them independent. [hand, one mind (J09); Weil external; owner ruling (item 68): one mind, a second reading owed before any ledger row rests on it alone]**
J02's statements imply S1–S3 but not this classification (J09 §4.3). *Proof:* J09 §2.5 (level collapse at step 6, the zero count at step
7). *Proof verdict:* closes on one reading. *Rests on it:* FS91-J09-J4-T6; FS-82's CLOSED banner (J09's route A to S3); FS-75's proposed
kernel target (inventory item 117). *Prior art:* pending the close gate; J09 asks the search in the literature's words ("every circular
3-colouring of the unit-distance graph over a real number field is a residue colouring at a prime of norm 3"). *Kernel:* stub (FS-75: J09
proposes J4 as a better kernel target than the per-field route).

**FS91-J02-T2 — S1: "`χ(F²) ≤ 3 ⟺ Θ₃ ≠ ∅ ⟺ Θ₃ ∩ T₆ ≠ ∅ ⟺` (the two prime types) `⟺ L(F) ≤ 3`, every real number field." (= J09's J4-C: "S1 for every real number field; `χ(F²) = 3 ⟺` non-bipartite and a prime above 3 of residue field `𝔽₃`".) [hand (composition); two independent derivations, compared (J09 stage 5: "Are the two S1/S2 statements the same statement? Yes"); owner ruling (item 68): verified]**
(1) ⟹ (2) FS81-T2; (2) ⟹ (3) L1; (3) ⟹ (4) T1; (5) ⟹ (1) row 52 and G56. Hypotheses: finite degree only — no Galois condition, no √3, no
condition at 2. *Proof:* J02 §2.7; J09 §2.6. *Proof verdict:* closes, twice. *Rests on it:* FS91-J02-T3, J02-C1; the proved range of the
conjecture ("L ≤ 3 for every real number field"). *Prior art:* `[Fischer1990]` §1 poses the general question verbatim ("whether some
algebraic criterion can be found to determine the chromatic number of F² where F is a subfield of R, of finite degree over Q"); Johnson's
2000 status report, problem (1), poses it for `χ`; S1 answers it at `χ ≤ 3` — a `CLOSED-QUESTIONS.md` candidate (inventory item 9);
`[Johnson2000]`, `[Johnson2006]` unread; pending the close gate. *Kernel:* stub (FS-75, re-aimed).

**FS91-J09-J4-A — S1 on every algebraic subfield of ℝ (L read through places; König's lemma over the number subfields) and on every purely transcendental extension `E(t₁,…,t_d)` of one (G63, composite places); GAP for a general transcendental `F` at two named steps: (1) `L(F)` is defined through primes, which a general `F` lacks; (2) J2's one use of finite degree has no replacement for finitely generated fields not purely transcendental over an algebraic field (FS-39's gap). [hand, one mind (J09)]**
*Correction applied (J09 stage 5 row 1, inventory item 113):* J02 §2.10 withheld the algebraic case because "a stable ramified dyadic prime
[restricts] to a stable dyadic one that is ramified or inert"; J09: it restricts to a **ramified** one (inert would make the base change
unramified; split would put `i` in the completion), two lines, one mind. *Proof:* J09 §2.6, stage 5. *Proof verdict:* closes on one reading
for algebraic and purely transcendental `F`. *Rests on it:* nothing yet. *Prior art:* `[Fischer1990]` Thm 6 (G63). *Kernel:* declined.

**FS91-J02-T3 — S2: "`χ(F²) = L(F)` whenever `L(F) ≤ 4`, every real number field." [hand (composition); two independent derivations (J02 §3.1; J09 §3.2); owner ruling (item 68): verified]**
`L = 4`: no target is three-colourable, so no ramified stable dyadic prime and no `𝔽₃` prime, so `Θ₃ = ∅` and `χ ≥ 4`; `χ ≤ L` by row 52
and G56 (the residue bound at `𝔽₇`, `χ(Γ₇) = 4`, and at the inert dyadic `U_Q`, `Q ≤ 32`, four-colourable at [tools] grade, FS-54).
*Proof:* J02 §3.1; J09 §3.2. *Proof verdict:* closes. *Rests on it:* the conjecture's proved range becomes "`L ≤ 4`, every real number field"
(corrections owed to G55, G74, G48, the Frontier: inventory item 8); J02's §3.1: "the conjecture's testable range below the problem itself
is now `L = 5` alone". *Prior art:* as FS91-J02-T2; G55 and row 82 held the real quadratic and `√3 ∈ F` cases. *Kernel:* stub (FS-75).

**FS91-J02-C1 — S3: `ℚ(α, √7)`, `α³ = α + 1`: `Θ₃ = ∅`, `χ = L = 4`. [hand + tools exact (PARI); two derivations (J02 §3.2; J09 §3.3, two routes, arithmetic identical line for line)]**
Degree 6, signature `[2, 2]`, discriminant `2⁶·7³·23²`; the prime above 2 splits in `L` (no stable dyadic place — so FS-82's stub's "dyadic
targets have `χ ≥ 4`" is wrong: there is none, inventory item 15); two primes above 3 inert in `L`, residue `𝔽₇₂₉` (`q = 27`); a stable
place above 7 with residue `𝔽₄₉`. J09's route B: `1/2 ∈ R_F` (J2), so `θ` is an additive colouring mod 3 at a prime above 3, and every
`Tr_{𝔽₇₂₉/𝔽₃}(a·)` vanishes somewhere on `μ₂₈`. *Proof:* J02 §3.2, `tools/crunch_j02_field.py`; J09 §3.3, `data/fs91/j09/field-arithmetic.gp`.
*Proof verdict:* closes. *Rests on it:* FS-82 CLOSED (inventory items 8, 117); the prediction "four at ℚ(α,√7)" met — the first `L = 4` field
with neither √3 nor a four-chromatic quadratic subfield. *Prior art:* none (the field is FS-82's). *Kernel:* stub (FS-75's fallback: a
checker for the field's prime data).

**FS91-J02-C2 — Additive colourings: "`F²` has an additive 3-colouring in `[Fischer1990]`'s sense … iff `F` has a stable prime above 3 with residue field `𝔽₃`; `F²` has an additive 2-colouring iff `F` has a stable prime above 2 ramified in `F(i)/F`." [hand, a corollary of T1; two derivations (J02 §4.1; J09 stage 4: the first half J4's by-product, the second derived from L3 and J-L4b)]**
*Proof:* J02 §4.1; J09 §4.2. *Proof verdict:* closes. *Rests on it:* nothing further. *Prior art:* generalises `[Fischer1990]` Thm 9
(quadratic fields at `N ≢ 2 (mod 3)`) to every real number field (J02 §4.1); gives Fischer's Thm 1(iii) the local form Astra's Thm 2.1
gave it. *Kernel:* stub (FS-75).

**FS91-J02-A2.1′ — A second derivation of GPT Astra's Thm 2.1 ⟹ (two colours) via L3. [hand; J02 §3.1; the index reads one mind; J09's §4.2 reaches the same implication by its own route as C2's second half ("Astra's Thm 2.1 re-derived", J09 divergence row 7) — filed as the two records state it]**
*Proof:* J02 §3.1; J09 §4.2. *Rests on it:* FS91-J02-T3's `L = 2` case (with G55). *Prior art:* GPT Astra's Thm 2.1 (G55). *Kernel:* declined.

**FS91-J09-J4-T6 — FS81-T6's open item settled: the additive 3-colourings of `ℚ(√d)`, `d ≡ 3, 7 (mod 12)`, are Fischer's up to symmetry. [hand, one mind (J09), from J2, J4]**
*Proof:* J09 §2.5. *Proof verdict:* closes on one reading. *Rests on it:* the correction to `plans/FS81-derivation.md` T6's open item
(inventory item 15). *Prior art:* `[Fischer1990]`'s colourings. *Kernel:* declined.
