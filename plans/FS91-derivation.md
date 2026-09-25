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

**Prior art — M1's close-time gate (J23p, `plans/FS91-PA-close.md` §C.1; DONE, commits 51459af1 … 9032661b).** Seven verdicts, each at the
exact scope J23p gives it: (1) band rigidity at every band (§1) — **partly in print**: `[Manners2015]` Lemma 5.3 on `ℤ[i][1/P₅, 1/P₁₃]`
(one Gaussian prime above each of 5 and 13, under `⟨θ₅, θ₁₃⟩`); the solenoid form of `[Wang2012]` Thm 1.10 stated unwritten by
`[EinsiedlerLindenstrauss2022]` p. 3; `R_S` with both primes and the group `U_S`, other `S`, and the field clause not found; undecided until
Muchnik 2005 is read. (2) CLG (§4) — **not found**; `χ_char` is `[BarajasSerra2008]`'s *regular chromatic number*, in print for cyclic groups;
undecided until `[Johnson2000]`, `[Johnson2006]` are read. (3) three colours over every real number field (§3) — **not found**; posed by
`[Fischer1990]` §1; undecided on the two Johnson papers. (4) Lemma C/C′ (§2) — **partly in print** (`[Fischer1990b]`'s quadratic and
multiquadratic cases); the general form not found; Shimura 1964 undecided. (5) the peeling lemma — **not found**, folklore-grade; the Borel
product literature undecided. (6) one prime (§6) — **not found as stated**; `[Manners2015]` §5.5 asserts the one-prime failure without proof
in §1–§5; Bosio–Vivaldi 2000 and Vivaldi 2006 undecided. (7) `χ_char` of the finite planes (§5) — **not found**. "Not found" measures the
queries' words (G21) and is never "new". Named held inputs (Berend, Furstenberg, Weil, GPT Astra, Fischer 1990/1994, `[MMST1998]`) are cited
per entry.

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
about `χ` or non-character colourings; nor density of the orbit (`[Manners2015]` Remark 5.4(i)'s "`Y = Â`" is not answered: M1 proves values near 0,
not density), nor an effective `N_k` (`[KravitzLeng2025]` gives one for Manners's half ring). *Prior art:* **partly in print** (J23p result 1, items 130–131; undecided until Muchnik 2005 is read): `[Manners2015]` Lemma 5.3 is the one-ring,
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
closes, twice. *Rests on it:* CLG_k's ⟹ (FS91-J07-7, through the factorisation); FS91-J07-4, J07-5. *Prior art:* **partly in print**
(J23p result 4): `[Fischer1990b]`'s quadratic and multiquadratic cases; the general form not found; Shimura 1964 undecided. *Kernel:* stub
(FS-47, the unit-vector ring in the kernel, gains Lemma C/C′ as its statement — inventory item 79).

**FS91-J07-4 — Lemma C′: "`R̄_p = ∏_{stable 𝔓|p} Ô_𝔓` (equivalently `R/NR ≅ ∏_{stable 𝔓|N} O_𝔓/NO_𝔓` for `N` a power of `p`) for every `p`, except possibly `p = 2` when some stable dyadic place is ramified in `L/F`; inert stable dyadic places always split off as full factors. No Galois hypothesis." (= J10-T6: "`R_F = O′` and `R_F` dense in every finite product of stable completions, for every real number field with no ramified stable dyadic place — no Galois hypothesis; the ramified exception holds at ℚ(√5), ℚ(√17), ℚ(α) and fails to occur at ℚ(√2)"; J09's J2 is the same statement at every `p` with no ramified stable prime above it: "`ℤ[U_F]_(p) = O′_(p)` …; `R/pR ≅ ∏_{S_p} O_𝔓/p`; `1/p ∈ R` if `S_p = ∅`; `R = O′` if no stable prime ramifies (FS86-B1-LR without "L/ℚ Galois")".) [hand; three derivations — J09's J2 blind (stage 2 §2.2); J07-4 (one mind by its record; J07 read J2's heading, not its proof, after deriving C′ — held item, inventory 114, on which C′'s independence rests); J10-T6 from the statement, with tools exact at seven field–prime pairs and four controls. The owner's ruling (item 68) reads J2 as one mind; J07-4 and J10-T6 reach its completed form independently (index §2.3)]**
The routes differ: J09 by orders, the class group and density; J07 by a Teichmüller idempotent and an element of valuation 1; J10 by the
graded pieces of the smooth torus (`Σ_{μ_{q+1}}(z − 1) = 1` in characteristic 2). J10's scope data make "except possibly" exact.
*Proof:* J09 §2.2; J07 §2.4; J10 §3.2 and `tools/crunch_j10_phase2.py` (D). *Proof verdict:* closes, three times. *Rests on it:* the
correction owed to FS86-B1-LR's scope line (drop "`L/ℚ` Galois"; inventory items 13, 78); FS91-J07-5's product form; FS91-J09-J4 (J2 at 3
and 2). *Prior art:* FS86-B1-LR (with the Galois hypothesis); G55's prime inversion (`[Fischer1990b]` for quadratic and multiquadratic
fields); the general form **not found** by the close gate (J23p result 4; Shimura 1964 undecided). *Kernel:* stub (FS-47).

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
literal form, TRUE except at ramified stable dyadic places, where it is ill-posed (J07 §5.1). The planner's J03-4 second clause ("a finite-index subgroup of a dense subgroup of a connected group is dense") is its form of the
fibre density. *Proof:* J07 §2.5. *Proof verdict:* closes.
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
`[Johnson2000]`, `[Johnson2006]` unread; the close gate: **not found**, undecided on the two Johnson papers (J23p result 3; its citation
walk of `[Fischer1990]`: OpenAlex 13 citers, Semantic Scholar 11). *Kernel:* stub (FS-75, re-aimed).

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

## §4. The class theorem: a character colouring of a real number field's plane comes from one residue target (J07; J10/J10b blind)

**FS91-J07-1 — CLG-a (the pullback): "A band-`β` character of `T_{𝔓,m}` composed with the reduction `R → O_𝔓/𝔓^m` lies in `Θ_β(R_F)`; no hypothesis on `F` or `𝔓`." (= J08-7; = J11-T8: "`χ_char(F²) ≤ min` over targets, unconditionally"; = J10-T1's ⟸.) [hand; four derivations (J07 §2.1; J08 stage 5; J10 phase 1, blind; J11 §W4, blind)]**
*Proof:* J07 §2.1 (one line: a residue map sends unit vectors into the local norm-one image). *Proof verdict:* closes. *Rests on it:*
every upper half of `χ_char`: FS91-J08-8's `Θ₈, Θ₁₇, Θ₂₂ ≠ ∅`. *Prior art:* the residue colouring of Theorem A (row 57) in character
form; `[Moorhouse2010]`. *Kernel:* declined (row 56's `addCayleyMap` is the kernel consumer if ever wanted).

**FS91-J07-2 — CLG-b and CLG-b_n, the peeling lemma: "For `0 < β ≤ ½`, `X, Y ⊆ ℝ/ℤ`, `X = −X`, `X + Y ⊆ B_β`: if some `x ∈ X` has `‖x‖ < β`, then every `y ∈ Y` has `‖y‖ ≥ β + ‖x‖`"; "If `X_1 + ⋯ + X_n ⊆ B_β` with every `X_j` non-empty and symmetric, some `X_j ⊆ B_β`." (= J03-1, the planner's, one mind; its contrapositive = J10-L5: "a Minkowski sum of symmetric subsets of ℝ/ℤ each meeting `{‖x‖ < β}` meets it".) [hand + tools exact (J07 check D: all symmetric subsets of `ℤ/12`, `ℤ/13`); three derivations (J03 §S/§M.2; J07 §2.2; J10-L5 blind, and J10 items 5–6 from the statements)]**
*Proof:* J07 §2.2. *Proof verdict:* closes. *Rests on it:* FS91-J07-7's peel. It proves "some", never "one" (J07 §5.1 (iv)). *Prior art:*
elementary; **not found** by the close gate, folklore-grade (J23p result 5; the Borel product literature undecided). *Kernel:*
declined for now (a short, self-contained kernel candidate if CLG is ever ported).

**FS91-J07-6 — CLG-d, the archimedean factor: "If `θ = τ + (ℓ mod 1) ∈ Θ_β(R_F)`, `τ` torsion, `ℓ ∈ Hom_ℚ(L, ℝ)`, then `ℓ` vanishes on `L ⊗_F F_w` at every complex place `w`, and `τ(U) + [−r, r] ⊆ B_β` with `r = Σ_{w real} |e_w|` (`ℓ_w(z) = Re(ē_w z)`); in particular `τ ∈ Θ_β(R_F)`. Every real number field." (= J03-4's complex half, the planner's "archimedean places have local `κ = 0`"; = J10-L4: "the archimedean part vanishes at every complex place of `F`; the torsion part alone is band on `U_F`".) [hand; three derivations (J03 §M.1; J07 §2.6, two routes; J10-L4 blind — divergence row 4: "convergent, independent")]**
Complex places by unboundedness of `Re(az) + Re(b/z)` on `ℂ^×`; a real place's `ℓ_w(S¹)` is an interval about 0, never avoiding 0, which
is what makes the archimedean summand unpeelable (J07 §5.1 (iii)). It repairs FS89-S0A-7's density step at complex places (J02 §2.8's
warning). *Proof:* J07 §2.6; J10 §2.2. *Proof verdict:* closes. *Rests on it:* FS91-J07-7. The plan's P-CM (0.60): won. *Prior art:*
pending the close gate. *Kernel:* declined.

**FS91-J07-7 — CLG_k, the class theorem: "Given `H_k`, for every real number field `F` and `k ≥ 2`: `Θ_k(R_F) ≠ ∅` iff some stable `𝔓` and level `m` carry a band-`k` character of `T_{𝔓,m}`; `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})`; a character `k`-colouring of `F²` exists only if some `T_{𝔓,m}` is `k`-colourable." And its converged form: "Given `H_β` at every band: `κ(R_F, U_F) = max_{stable 𝔓} κ_loc(𝔓)`, `κ_loc(𝔓) = sup{β : some T_{𝔓,m} has a band-β character}`, the maximum attained; `χ_char = ⌈1/κ⌉`." (= J10-T1, V1: "⟸ unconditional; ⟹ given `H_k`; every real number field, complex embeddings included, no Lemma R"; = J10-T2, V2.) [hand; two independent derivations — J07 (§2.7, §3.1) and J10 (phase 1 blind, §2.3; phase 2 from J07's statements, §3.1 items 13–14, §3.3: "do the lemmas, as stated, imply V1–V4? … yes"; divergence row 5: "convergent, independent; neither uses Lemma R or C′"); owner ruling (item 126): blind-verified]**
⟹: `θ = τ + α` by `H_k`; `τ ∈ Θ_k` (CLG-d); `τ` factors through `∏_{stable 𝔓|N} O_𝔓/𝔓^K` (Lemma C's last clause); extend, split `τ = Σ τ_𝔓`; by
(W) the image of `U` is `∏ S_{𝔓,K}`, so `τ(U) = Σ τ_𝔓(S_{𝔓,K}) ⊆ B_k`; each summand symmetric; the peel leaves one band local character.
**Scope notes, applied as filed (J10 §2.3, divergence rows 6, 14; inventory item 89):** (i) the middle clause `χ_char(F²) = min` needs `H`
at `χ_char(F²)`, which `H_k` gives only when `χ_char(F²) ≤ k` — moot given FS91-J01-7 (`H_k` at every `k`), so the statement reads "given
`H` at every band"; (ii) HD1 (the plan's CLG-f) does not follow from CLG_k's *statement*, which is existential — it follows from CLG's
*proof* with Lemma D (FS91-J07-12). *Proof:* J07 §2.7, §3.1; J10 §2.2–§2.3, §3.3. *Proof verdict:* closes, twice. *Rests on it:* FS91-J07-11
to J07-15; FS91-J08-8 and J11-T10/T11 (the lower halves, now given a blind-verified CLG); the sharpened G64 ("six, or any falsifier, hides
only in a non-character colouring"). *Prior art:* **not found** by the close gate (J23p result 2); `χ_char` is `[BarajasSerra2008]`'s regular chromatic number, in print for
cyclic groups; undecided until `[Johnson2000]`, `[Johnson2006]` are read; the question is posed for `χ` by `[Fischer1990]` §1 and Johnson's
2000 status report (problem (1)); the discipline is circular colouring / the lonely-runner parameter (plan §PA.1); the nearest printed
relative found at the opening gate is Kang–Maharaj 2010 (one-place colourings of distance graphs, rank 1). *Kernel:* declined for now
(rests on `H_k`, hence on `[Berend1984]`); its local half is FS-47's.

**FS91-J11-T12 — Monotonicity: `Θ_k(R_F) ⊆ Θ_{k+1}(R_F)`; hence `χ_char(F²) = m` follows from the pullback and CLG_{m−1} alone, `m` the minimum over targets, whenever every stable place has `p > (m − 1)/2`. [hand, elementary (`B_k ⊆ B_{k+1}`); J11 stage 3 (one mind in its record's table); J08-8 uses the same step ("`Θ_k` grows with `k`")]**
*Proof:* J11 stage 3. *Proof verdict:* closes. *Rests on it:* the correction of SIX-e's hypothesis to CLG_16, CLG_21 (FS91-J08-8). *Prior
art:* elementary. *Kernel:* declined.

**FS91-J07-8 — Lemma LB and LB′, the level bound: "At a stable `𝔓` over odd `p`, `e = e(𝔭|p)`: a band-`β` character of `T_{𝔓,m}` of exact level `L ≥ 2` has `2β·p^a ≤ 1`, `a = ⌊(⌊L/2⌋ − 1)/e⌋ + 1`"; "moreover `2β·p^E ≤ p^{E−a} − 1` with `E = ⌈L/e⌉`. So at `e = 1` level 2 needs `k ≥ 2p²/(p−1)` and level 3 needs `k ≥ 2p³/(p²−1)`; at `e ≥ 2` level 2 never occurs." (= J10-T7.) [hand + tools exact (J07 check A: all characters of `ℤ[i]/3⁴`, `ℤ[i]/7³`); two derivations (J07 §3.2, §4.2; J10 §3.2 from the statement, by trace duality — divergence row 7)]**
J10's scope data: LB′ is sharp at (`e = 1`, level 2) and (`e = 2`, level 3) on `f = 1` towers, **not** at (1, 3) or (2, 5), where the true
best margin is `1/27`. LB′ came from reading the check (J07 §5.1 (v)). *Proof:* J07 §3.2, §4.2; J10 §3.2, tool (E). *Proof verdict:*
closes. *Rests on it:* FS91-J07-9, J07-11. *Prior art:* pending the close gate. *Kernel:* declined.

**FS91-J07-9 — CLG-e, level collapse: "At a stable place over odd `p`, every band-`k` character of `T_{𝔓,m}` factors through `T_{𝔓,1}` whenever `k ≤ 2p`; at an inert stable dyadic place the same for `k = 3`; `U_Q` (level one, inert dyadic) has no band character at all. Ramified dyadic at `k = 3`: not claimed." (= J08-6: "at an odd stable place with `p > k/2`, every band `k`-character of any level factors through level one"; = J10-L6: at inert stable places with `p > k/2`, "the exception at `p ≤ k/2` is non-vacuous (`p = 3`, `k = 9`)"; = J11-T7.) [hand + tools exact; four derivations — J07 §3.2, §4.2 (the sharp `k ≤ 2p`); J08 stage 5 (one mind by its record); J10-L6 blind (tools exact at level 2, `p = 3, 7, 11`, `k ≤ 9`); J11-T7 blind, which J08's Cayley step (`(1 + y)/(1 − y)`, `c(y) = −y`) completes (J11 stage 4: "T7 stands with J08's Cayley line inserted")]**
J10 adopted J07's sharper form at `k = 2p` (divergence row 8: values lie in `p^{−E}ℤ`, `p` odd). *Proof:* J07 §3.2, §4.2; J08 stage 5;
J10 §2.2, `tools/crunch_j10_checks.py` (A); J11 §W4. *Proof verdict:* closes. *Rests on it:* FS91-J07-11; FS91-J08-8 (every stable place of
the three fields has `p` far above `k/2`). *Prior art:* the band form of row 75's fibre step (G66); FS89-S0A-4 did bands 1/4, 1/5. *Kernel:*
declined.

**FS91-J07-10 — Lemma AV: "A band-`β` character of a finite Cayley graph `Cay(G, S)` forces `α(Cay(G, S)) ≥ β|G|`." [hand; two derivations (J07 §3.3; J10 item 12 from the statement, by J10-L7's averaging: `I_t = λ^{−1}[t, t + β)` is independent, mean size `β|G|`)]**
*Proof:* J07 §3.3. *Rests on it:* FS91-J07-11 (with Hoffman floors); C-167 above 67. *Prior art:* the fractional wall's form for characters
(G59; a band character is a circular colouring). *Kernel:* declined.

**FS91-J10-L7 — "a band 4-character of a Cayley graph with `α ≤ |G|/4` takes the value `±1/4`." [hand; one mind (J10)]**
*Proof:* J10 §2.2. *Rests on it:* FS91-J07-12's second derivation (J10-T4). *Prior art:* pending the close gate. *Kernel:* declined.

**FS91-J10-L8 — "in every inert residue tower (odd stable place, or inert stable dyadic place; `F_𝔭` possibly ramified over `ℚ_p`) a character new at level `j` has `|λ| ≤ c·Q^{j−1}` (`c` = 2 odd, 1 dyadic), so `λ_min` scales exactly by `Q^{j−1}` and every Hoffman floor survives every level." [hand + tools exact at four towers; one mind (J10)]**
It extends G54's all-levels ratio (stated for Galois rings; `[MMST1998]` for odd prime `Q`) to every inert tower, and closes the input
scope of CLG-g's (E2) (J10 divergence row 9). *Proof:* J10 §3.2; `tools/crunch_j10_phase2.py` (E). *Proof verdict:* closes on one
reading. *Rests on it:* FS91-J07-11's (E2). *Prior art:* `[MMST1998]` Thms 2.1, 2.3, 2.9 for odd prime `Q`; GPT Astra's recomputation (G54);
pending the close gate for the general tower. *Kernel:* declined.

**FS91-J07-11 — CLG-g, the conjecture for character colourings, with the exception explicit: "Given `H_k`, `k ≥ 3`, `F` a real number field, `Θ_k(R_F) ≠ ∅`: then `L(F) ≤ k`, unless every stable place carrying a band `k`-character carries it only above level one and is (E1) odd with residue field `𝔽_{p^f}`, `f ≥ 3`, `2p < k < χ(Γ_{p^f})`, or (E2) inert dyadic of norm `Q ≥ 64` with `k < χ(U_Q)` and `k ≥` `U_Q`'s Hoffman floor." Corollaries: "(g1) no exception at `k ≤ 5`; (g2) no exception for `[F : ℚ] ≤ 2` at any `k`; (g3) at `k = 6` only (E2) with `Q = 64`; at `k = 7`, (E1) only at `q = 3^f`, `f ≥ 3`, **exact level `2e(𝔭|3) + 1`** [corrected from "`e(𝔭|3) = 1`, exact level 3"], and (E2) at `Q = 64`." (= J10-T3, V3; the correction = J10-T8.) [hand; tools-grade inputs named (G56's four-colourings of `U_Q`, `Q ≤ 32`; Brooks; the all-levels ratio, now FS91-J10-L8); two derivations of the theorem (J07 §3.3, §4.2; J10 phase 1, V3, and phase 2 items 18–19 from the statements: "strictly sharper"); **GAP in (g3)** (J10-T8)]**
**J10-T8, filed here as a finding:** at `k = 7`, "LB/LB′ leave exact level `2e(𝔭|3) + 1` open at **every** `e`, so '`e(𝔭|3) = 1`' does not
follow from J07's lemmas" — the `f = 1` towers show the same best margin `1/27` at `(e, L′) = (1, 3)` and `(2, 5)` (J10 §3.1 item 19, divergence
row 10; tool (G)). J07 checked level 2 at `e ≥ 2`, not level `2e + 1`. The supported form is the bracketed one above, unless a further lemma
kills `e ≥ 2` (inventory item 105). (g1) needs `U₆₄`'s exact `λ_min = −15` (floor 5.33); (g3)'s (E2) at 128 needs `U₁₂₈`'s exact
`λ_min = −19` (floor 7.79; Weil alone gives 6.7), recomputed by J10. *Proof:* J07 §3.3, §4.2; J10 §3.1 items 18–19, §3.2. *Proof verdict:*
the theorem and (g1), (g2), (g3) at `k = 6` close twice; (g3) at `k = 7` closes only in the corrected form. *Rests on it:* the conjecture's
character form: "a falsifier at any real number field is no character, at every `k ≤ 5`, and at every `k` over a quadratic field" (J07's
proposed Frontier line). *Open:* whether (E1) or (E2) is ever realised (inventory item 79: a band 6/7-character at level ≥ 2 of the `U₆₄`
tower, or level 3 at `q = 27`; fields of degree ≥ 6 / ≥ 3). *Prior art:* pending the close gate. *Kernel:* declined.

**FS91-J07-12 — HD1 through CLG: "For ℚ(√59), ℚ(√83), ℚ(√131): every `θ ∈ Θ₄(R_F)` is `λ_D∘ρ_D` for the unique stable dyadic place `D`. Inputs: 13, 17, 20, 12, and FS86-B1-LD … Not used: FS-66's certificates, `[Zhang2012]`, Lemma R." (= J10-T4: "HD1 … from `H₄` + S0A-8 + Lemma D, no FS-66 certificate, no Zhang, no Lemma R".) [hand (given FS86-B1-LD); two independent derivations (J07 §4.4; J10 phase 1, blind — divergence row 13)]**
*Proof:* J07 §4.4; J10 §2.3 V4. *Proof verdict:* closes, twice, with fewer inputs than FS89-CL3. *Rests on it:* row 96's HD1 re-proved (a
proposed ledger wording, inventory item 87). *Prior art:* FS89-CL3's statement. *Kernel:* declined.

**FS91-J07-13 — C-47 and C-167 through CLG: "`Θ₄(R_{ℚ(√47)}) = ∅`"; "`Θ₅(R_{ℚ(√167)}) = ∅` … no certificate" (complete character lists at 23, 43, 59). (= J10-T5.) [hand + tools exact (J07 checks B, C); two derivations (J07 §4.4; J10 phase 1 and items 22–23, the band-5 check at 23 and 43 by J10's multiplicity count)]**
*Proof:* J07 §4.4; J10 §2.3 V4, §3.1 items 22–23. *Proof verdict:* closes. *Rests on it:* row 96's C-167 without FS-53's and FS-66's
certificates. *Prior art:* FS89-CL4, CL5. *Kernel:* declined.

**FS91-J07-14 — "Under the corrected `A(R_F)`: FS89-CL3, CL4, CL5 are TRUE; each FS-89 proof step already reads every real place; the narrow reading sits only in FS89-CL2's wording." [hand; two derivations of the conclusions (J07 §4.4; J10 phase 1 blind and item 25 — J10 checked the proof text at S0A's G3 step 3 only, J07 every step: divergence row 18)]**
*Proof:* J07 §4.4. *Proof verdict:* closes. *Rests on it:* rows 95–96 stand with the wide `A` (inventory items 69, 75, 92); FS89-CL2 needs
the wording correction (FS91-J03a-9). *Prior art:* none needed. *Kernel:* declined.

**FS91-J07-15 — Controls reproduced: "CLG returns: the ramified dyadic place at level 1 for `θ₂`; one dyadic place of K at level 3 for `[Fischer1994]` (existing checker `data/fs86/b1/fischer_vk_control.gp`); the stable place above 7 of ℚ(√11) at level 1 for C9; an `𝔽₃` or ramified dyadic place for every `θ ∈ Θ₃` (J02-T1's generalisation); `κ_loc(𝔓′) ≤ κ_loc(𝔓′ ∩ L)` for `F ⊆ F′`." [hand + tools (an existing checker); verified by J10 from the statement (item 24); the Fischer control is one checker, "not an independent confirmation" (J10 divergence row 16)]**
The last clause is the planner's predicted "next lemma" (§M.1), met. J10's wording note: `θ₂` "at level 1" means one exists there; the
route's extension may return a higher level (divergence row 17, harmless). *Proof:* J07 §4.3. *Rests on it:* the plan's CLG-f. *Prior art:*
`[Fischer1994]`; row 94's C9. *Kernel:* declined.

## §5. Six at the exposed fields: the character chromatic numbers of the targets and of three planes (J08; J11 blind)

**FS91-J08-1 — SIX-a, the reduction: every band `k`-character of `Γ_q` (`q ≡ 3 (mod 4)` prime) is `λ_a`, with value set `V_{N(a)}` (multiplicities 2/1/0); band iff `min_{V_c}|t| ≥ q/k`; only non-square `c` can be band. (= J03-2, the planner's, one mind; = J11-T1: "every band `k`-character of `Γ_q` is `λ_a`, with `λ_a(μ_{q+1}) = V_{N(a)}/q`; band iff `min_{V_c}|t| ≥ q/k`"; its last clause = J11-T2's first half.) [hand; the law checked against the circle directly at every `a` (J08, `q ≤ 67`; J11, every prime `q ≤ 139`); three derivations (J03 §PA.1; J08 stage 2; J11 stage 2 §W1, blind)]**
A line `Tr(ax) = t` meets the norm-`c` circle iff `X² − tX + c` has roots of norm `c`, i.e. a non-square or zero discriminant. The law is
derived, so its refusals are the suspect verdict (`CLAUDE.md` § The gate): both jobs checked it against a direct circle enumeration, and
row 69's periodic colourings' `D` is exactly `V_c` for one non-square `c` at every `p ≡ 3 (mod 4)` in `data/fplane/periodic-below-71.json`
(J08 stage 3 control 3). *Proof:* J08 stage 2; J11 §W1. *Proof verdict:* closes, three times. *Rests on it:* §5's every list. *Prior art:*
Kloosterman/Weil control of `Γ_q`'s spectrum (G44); runs of quadratic residues of a polynomial (plan §PA.1); the close gate: **not found** (J23p result 7).
*Kernel:* declined (a finite `decide` per `q` would port it if a consumer appears).

**FS91-J11-T2 — every band character has `N(a)` a non-square; `χ_char(Γ_q) = ⌈q/max_c d(c)⌉`. [hand; J11 §W1 (one mind in its table); J08's stage-3 definitions give the same formula (`κ = max_c m(c)/q`, band `k` at `c` iff `k·m(c) ≥ q`)]**
*Proof:* J11 §W1; J08 stage 3. *Rests on it:* FS91-J08-2, J08-5. *Prior art:* the `κ` form of FS91-J07-7 at one target. *Kernel:* declined.

**FS91-J08-2 — `χ_char(Γ₂₃) = 8`, `κ = 3/23`; band 8 exactly at `c ∈ {11, 20, 21}`; no band 6 or 7. FS91-J08-3 — `χ_char(Γ₄₃) = 9`, `κ = 5/43`; band 9 exactly at `c = 33`; no band 6, 7, 8. (= J03-3 at 23, the planner's hand check, fenced; = J11-T4, "23 in full, 43 at `c = 33`" by hand as well.) [tools exact (two halves: the law and the circle); three computations at 23 (J03 by hand; J08; J11 by tool and by hand), two at 43 (J08; J11) — J11-T13: identical, value by value]**
A complete exact enumeration of `c ∈ 𝔽_q^×` (22 and 42 values), the set fixed by FS91-J08-1 — the ban's edge, logged. **Read aloud (J08
stage 3):** "no colouring of the form `x ↦ ⌊kλ(x)⌋`, `λ` a character, colours Γ₂₃ with fewer than 8 colours or Γ₄₃ with fewer than 9. It
says nothing about `χ(Γ₂₃)` or `χ(Γ₄₃)`: the window question (G56 — is either six-chromatic?) is untouched." **The positive control failed
at 43, for a stated reason** (J08 stage 3 item 4; J11's control, found independently): row 69's ceiling 8 at 43 is a line colouring of the
circulant `C₄₃ = Cay(ℤ/43, V₂₂)`, not of multiplier form, so `χ(C₄₃) ≤ 8 < 9 = χ_char(Γ₄₃)`; "periodic under a line" is strictly wider
than "character" (inventory items 83, 111). *Proof:* J08 stage 3, `tools/crunch_j08_kappa.py`, `crunch_j08_sixa.py`, `data/fs91/j08/kappa-23-43.json`;
J11 `data/fs91/j11/band-lists.json`. *Proof verdict:* closes. *Rests on it:* the lost predictions P-W6 and C0-43 (no band six-character at
23 or 43); FS91-J08-8 at ℚ(√167). *Prior art:* none (a computation). *Kernel:* declined (no consumer; `decide` over 529 and 1,849
characters would do it).

**FS91-J08-4 — The Weil threshold: "band `k` on Γ_q ⟹ `⌈q/k⌉(q+1) ≤ 2√q(q − ⌈q/k⌉)` ⟹ `q < 4(k−1)²`; `χ_char(Γ_q) > 1 + √q/2`." (= J11-T3: "band `k` at `Γ_q` ⟹ `(q + 1)² ≤ 4(k − 1)²q`; `Q₆ = 97`, `Q₇ = 141`".) [hand, given Weil (G44); two derivations by two routes (J08: a Fejér function against `max|λ|`; J11: Hoffman on the colour class against `λ_min`) — J08's constants `Q₆ = 100`, `Q₇ = 144`, J11's 97, 141: "both valid; mine is the same inequality read without the last rounding; the prime lists coincide"]**
J08's inequality is consistent with all 218 exact values below 3,000; J11 asserts it at every band character to 199 (0 violations).
*Proof:* J08 stage 4; J11 §W3. *Proof verdict:* closes, twice. *Rests on it:* FS91-J08-5's completeness; FS91-J08-8's "every stable `q`
below the bound was computed". *Prior art:* Weil's bound for a squarefree quadratic character sum; Burgess (plan §PA.3 item 3). *Kernel:*
declined (rests on Weil).

**FS91-J08-5 — Band 6 and band 7 characters exist exactly at `q ∈ {3, 7, 11, 19}` (lists of `c` in stage 4); `χ_char ≥ 8` for every prime `q ≡ 3 (4)` from 23. (= J11-T5, with the `χ_char` table to 199.) [hand (J08-4) + tools exact; two derivations (J08 stage 4; J11 §W3), identical lists]**
J11's table (to 199): 3: 3 · 7: 4 · 11: **6** · 19: 5 · 23: 8 · 31: 8 · 43: 9 · 47: 10 · 59: 10 · 67: 14 · 71: 18 · 79: 14 · 83: 17 · 103: 15 · … ·
199: 25 — `χ_char` is not monotone in `q`. *Proof:* J08 stage 4, `tools/crunch_j08_threshold.py`; J11 §W3, `tools/crunch_j11_band.py`.
*Proof verdict:* closes. *Rests on it:* "the window is closed to characters": no usable prime plane of the window {23, 31, 43, 47} carries a
band six-character, and 27 carries none at all (FS91-J08-R). *Prior art:* none. *Kernel:* declined.

**FS91-J11-W3 — `χ_char(Γ₁₁) = 6 > χ(Γ₁₁) = 5`: at 11 no optimal colouring is a character colouring. [tools exact; three computations agree — J11 stage 2 §W3 (in its report and §W3, not in a theorems table); J10-T9 ("none [of band 5] at 11 either"); J08 stage 3's table ("11: **6** … (`χ(Γ₁₁) = 5`, kernel, by a non-line colouring)")]**
*Proof:* the three tools named. *Rests on it:* the observation that character colourings are strictly weaker than colourings on a usable
plane already at 11 (and at 43 against line colourings, FS91-J08-3). *Prior art:* `χ(Γ₁₁) = 5` is `[Moorhouse2010]`/`[Manturov2012]`/
`[Madore2015]`'s, kernel here (row 53). *Kernel:* declined (a candidate: 121 characters × 12 circle points, `decide`-sized, if wanted).

**FS91-J08-R — `χ_char(Γ₂₇) = ∞`: no band character at any `k`. (= J11-T6: "every character is 0 on at least 4 circle points".) [hand + cert (row 70) for J08; tools exact (PARI) for J11 — two routes, J11's needing no certificate]**
The same fact as FS91-J02-L4 (a) at `q = 27` and J09's zero count: a character of `𝔽₇₂₉` takes values in `(1/3)ℤ/ℤ`, and every one vanishes on
`μ₂₈` somewhere. J11's count reproduces `λ_min = −8` (row 70); its control at 23 finds characters with no zero. *Proof:* J08 stage 4
remark; J11 `tools/crunch_j11_q27.gp`, `data/fs91/j11/q27.out`. *Proof verdict:* closes. *Rests on it:* the non-prime window member is closed
to characters at every `k`. *Prior art:* none. *Kernel:* declined.

**FS91-J10-T9 — The level-one table: "no band-4 character of `Γ_q`, prime `q ≡ 3 (4)`, `11 ≤ q ≤ 59`; none of band 5 at 23, 43, 59 (none at 11 either; one at 19); `λ_min(U₆₄, U₁₂₈, U₂₅₆) = −15, −19, −31`." [tools exact, via a brute-forced multiplicity formula `1 − η(t² − 4N(a))`; one computation (J10); its band-5 entries at 23 and 43 agree with FS91-J08-2/J08-3, its `Γ₁₉` band-5 character with J08-5's list]**
*Proof:* J10 §3.4, `tools/crunch_j10_phase2.py` (F), `data/fs91/j10/phase2.out`. *Proof verdict:* closes (exact). *Rests on it:* J07's
level-one inputs (item 20) and CLG-g's (g1)/(g3) floors. *Prior art:* none. *Kernel:* declined.

**FS91-J11-T9 — The stable places of ℚ(√167), `K(√7)`, `K(√5,√7)`; none dyadic. [tools exact + PARI to 300; one computation (J11), compared with J08's target lists in J11-T13 ("no stable place of mine below `4(m − 2)²` is missing from J08's")]**
All three fields break the 2-adic wall (odd square class 7 or 167 ≡ 7 mod 8), so none has a stable dyadic place; for the multiquadratic
fields every odd ramified prime has residue field `⊇ 𝔽_{p²}` (J08 stage 5). *Proof:* `data/fs91/j11/targets.json`; J08
`tools/crunch_j08_threshold.py` §(4). *Rests on it:* FS91-J08-8. *Prior art:* none (a computation). *Kernel:* declined.

**FS91-J08-8 — The three fields: `χ_char` = 8 (ℚ(√167)), 17 (`K(√7)` = ℚ(√3,√7,√11)), 22 (de Grey's field `K(√5,√7)` = ℚ(√3,√5,√7,√11)) given CLG_7, CLG_16, CLG_21; `Θ₈`, `Θ₁₇`, `Θ₂₂ ≠ ∅` unconditionally. (= J11-T10: "given CLG_7, `χ_char(ℚ(√167)²) = 8`; unconditionally `6 ≤ χ_char(ℚ(√167)²) ≤ 8`"; = J11-T11 as corrected in J11's stage 3: "given CLG_{m−1}, `χ_char(K(√7)²) = 17` and `χ_char(K(√5,√7)²) = 22`".) [hand + tools exact; two derivations (J08 stage 5; J11 §W4 and stage 3, closing its stage-2 gap by FS91-J11-T12); the lower halves given CLG, which is now blind-verified (FS91-J07-7)]**
Minima: ℚ(√167) at 23 (`c ∈ {11, 20, 21}`; other targets 43: 9, 59: 10, 67: 14, …, the ramified 167: 24); `K(√7)` at 83 (`c = 43`,
`κ = 5/83`); de Grey's field at 131 (`c = 30`, `κ = 6/131`); every stable `q` below `4(m − 2)²` computed, and no higher level does better
(FS91-J07-9). **Corrections applied as filed:** (i) the planner's SIX-e ("Given CLG_6 and CLG_7") under-names the hypothesis at `K(√7)` and
de Grey's field — J11: CLG_6, CLG_7 give only `8 ≤ χ_char ≤ 17` and `≤ 22`; CLG_16, CLG_21 close it, one instance each, by monotonicity
(inventory item 110); J08's own statement names the right hypotheses; (ii) J08's bullet "Not claimed: anything about `χ(ℚ(√167)²)` beyond
`4 ≤ χ ≤ 8`" is true and not sharp: the known bracket is `4 ≤ χ(ℚ(√167)²) ≤ 7` (row 79; row 33) (inventory item 109). **Read aloud:** at the
6-open fields character colourings need 17 and 22 colours, far above the plane's 7; given CLG, the only colourings that could make any of
these planes six-chromatic — or seven-chromatic — are non-character colourings (J08's reading, "a restatement of J08-8 plus the plane's
7-colouring"). Consistent with `[Fischer1990]` Ex. 4 (no additive `k < 11` over ℚ(√167)): the band characters found have order 23, 43, …
*Proof:* J08 stage 5; J11 §W4, stage 3. *Proof verdict:* closes, twice. *Rests on it:* the predictions P-167 (≥ 7) and P-167-8 (= 8), won
given CLG; FS-59's and FS-64's re-aim ("the one-character case is closed at six and seven", inventory item 85). *Prior art:* none. *Kernel:*
declined.

**FS91-J08-9 — `Θ₆(Q)` reduces to a sumset over places `{2, 3, 7, 11, 19}`, levels `8, 27, q`. [hand (N₀'s dyadic step and weak approximation cited, FS89-S0A-3); one mind (J08); outside J11's fixed list]**
J08-9's anti-band case replaced a wrong first idea, caught by the tool before recording (inventory item 115). *Proof:* J08 stage 6.
*Rests on it:* FS91-J08-10, J08-11. *Prior art:* FS89-S0A-3's structure. *Kernel:* declined.

**FS91-J08-10 — The complete band-1/6 list for `Q`: 18 types, 173 torsion characters; `Θ₆(Q) = ⋃ {τ + α : |α| ≤ r_max(τ)}` over the list, and `Θ₆(Q) ⊆ T_{105,336} + A(Q)`, `105,336 = 8·9·7·11·19`. FS91-J08-11 — the band-1/5 list: 10 types, 77 characters, `N₅ = 35,112 = 8·3·7·11·19`. [hand (J08-9) + tools exact; one mind + tools (J08); not in J11's list]**
New at band 1/6: a 3-adic level-two type (parity + order 9); the order-3 leaf of radius 1/6. Controls: band 1/4 reproduces Lemma N₀ exactly
(FS89-S0A-3, two blind derivations); `T(ℤ₂) mod 8` equals N₀'s eight points; the measured half (1,916 rational unit vectors) finds every
`r_max` sharp; every passing tuple has a summand whose own value set is in the band — the peeling lemma's conclusion checked on all 34
tuples, a free consistency check of CLG for `F = ℚ`. Exhaustive over a product the derivation fixed (273,581 tuples, 2.6 s) — the ban's
edge, logged. *Proof:* J08 stage 6, `tools/crunch_j08_sixf.py`, `crunch_j08_sixf_points.py`. *Proof verdict:* closes on one derivation
with exact checks. *Rests on it:* FS91-J01-7's "does not give" (the explicit list at 1/6) is now given for `k = 5, 6`; FS89-S0A-10's
"finite, not computed, at five" becomes `N₅ = 35,112` (inventory item 85); the stub question "the explicit band-`k` torsion list" (item 6)
is answered at `k = 6`. *Prior art:* none. *Kernel:* declined.

**FS91-J11-T13 — J08's `κ`, `χ_char`, `m(c)`, band lists, targets and minima agree with J11's at 146 values, 0 divergences. [tools exact (a comparison; the planted divergence `χ_char(Γ₃₁) = 9` is caught and nothing else); J11 stage 4]**
*Proof:* `tools/crunch_j11_compare.py` → `data/fs91/j11/compare-j08.json`. *Rests on it:* the "two derivations" status of every §5 entry
above. *Prior art:* none (a comparison). *Kernel:* declined.

## §6. One prime is not enough, three ways (J12; the blind check J13 pending at this filing)

*Every entry below is one derivation (J12, `plans/FS91-S1D-one-prime.md`); J13's verdicts, when they land, are added to each entry's
verification line. Statements are J12's theorems table, verbatim; `data/fs91/j12/lemma-statements.md` holds the self-contained forms
(26 items). **Prior art, for every §6 entry that names none:** pending the close gate; the piecewise-rotation and S-adic literatures
(inventory item 122) are unsearched. The close gate's verdict on §6 (J23p result 6): **not found as stated**; `[Manners2015]` §5.5
asserts the one-prime failure without proof in §1–§5; Bosio–Vivaldi 2000 and Vivaldi 2006 undecided. `R₅ = R_{{5}}`, `S₊ = ℤ[i][1/π̄_p]`, `S₋ = ℤ[i][1/π_p]`, `ω = (−4−3i)/5`, `Q₀ = [−1/4, 1/4]²`, `C₉` the nine centres.*

**FS91-J12-A1, J12-A2, J12-A3 — the half-rings and the `p`-free margins:** "`S₊ ∩ S₋ = ℤ[i]`, `S₊ + S₋ = R_{{p}}`, `U_p ⊆ S₊ ∪ S₋`"; "characters of `S₊`, `S₋` agreeing on `ℤ[i]` glue uniquely to `R_{{p}}`"; "at every `p ≡ 1 (4)`: `θ₂ = 1/2` and `τ_{(1+i)/3} ∈ {1/3, 2/3}` on `U_p` (margins 1/4, 1/12, `p`-free)". **[hand (A3: tools exact at 5, 13, 17, 29); one derivation (J12 stage 2); J13 pending]**
A1 is the only place one prime is used in ONE-a: with two primes `w₅w₁₃` lies in no half-ring (J12's remark). *Proof:* J12 stage 2.
*Rests on it:* FS91-J12-ONEa, J12-HL, the `p`-generalisations MSp and C3p. *Kernel:* declined.

**FS91-J12-ONEa — ONE-a (U3): "`Θ₄(R_{{p}}) ⊄ T + A` for every prime `p ≡ 1 (mod 4)`, by the heteroclinic `τ` on `S₊`, `θ₂ + λ_{C−P}` on `S₋`"; with FS91-J12-HL, the heteroclinic lemma: "two band torsion leaves whose discs meet on layer 0 give a band character outside `T + A`". [hand; tools exact (4 primes, `|m| ≤ 40`, three plants); one derivation (J12 stage 2); J13 pending]**
FS89's U3 was proved at `p = 5` only (S0B-T3/T4); this is every split prime. *Proof:* J12 stage 2, `tools/crunch_j12_onea.py`. *Rests on
it:* the correction owed to FS89-derivation §10's U3 row ("open → proved at every `p`", inventory item 121); the plan's P-U3 (0.75) met.
*Prior art:* pending the close gate; J23p relays `[Manners2015]` §5.5's unproved assertion that "the appropriate results are false for"
`{θ₅^r}` (inventory item 130). *Kernel:* declined.

**FS91-J12-B1, J12-B2, J12-B3, J12-B4 — the nine-rotation model:** "`Θ₄(U₅)` ≅ bi-infinite orbits in `Q₀` of the rotation `ω = (−4−3i)/5` about one of nine centres per step"; "`θ ∈ T + A` iff its centre sequence is periodic"; "displaced orbits: same centres from `q₀ + δ` give `q_m + ω^mδ`, admissible when `|δ| ≤` margin"; "a minimal set meeting `T + A` is a finite union of leaf circles or a finite torsion orbit". **[hand (B1: tools exact, alphabet and heteroclinic); one derivation (J12 stage 3 §3.1); J13 pending]**
Parity is the centre 0; the four `X₃` leaves are the four diagonal centres; the four edge centres lie outside `Q₀`. *Proof:* J12 §3.1,
`tools/crunch_j12_oneb.py`. *Rests on it:* FS91-J12-B5, J12-MS. *Prior art:* pending the close gate — piecewise and discretized rotations
with rational cosine (Adler–Kitchens–Tresser, Goetz, Buzzi, Bosio–Vivaldi, Akiyama–Pethő) are unsearched (inventory item 122). *Kernel:*
declined.

**FS91-J12-B5 — "`MS₄({5})` fails iff some band character is uniformly recurrent with a non-periodic centre sequence (§M.2 corrected)." [hand; one derivation (J12 §3.2); J13 pending]**
It replaces the plan's §M.2 ONE-b reduction, whose clause 1 is TRUE, clause 2 a GAP (no classification by parity and `X₃`), clause 3
incomplete, and whose obligation ("switches at bounded gaps") is answered yes by periodic `T + A` orbits and so does not decide ONE-b
(inventory item 119). *Proof:* J12 §3.2. *Rests on it:* FS91-J12-MS. *Kernel:* declined.

**FS91-J12-B6 — "two blocks freely concatenable over a compact set are powers of one word; distinct band torsion characters never share a layer-0 point." [hand; one derivation (J12 §3.3); J13 pending]**
*Proof:* J12 §3.3. *Rests on it:* FS91-J12-CL's uniqueness of leaves. *Kernel:* declined.

**FS91-J12-CL, J12-CL′ — the two-leaf closing lemma** "(fixed point `D(1−y)/(1−xy)`, admissible with margin `≥ depth`)"; "the closed-up points for `a, b ≥ 2` are dense in the lens of two leaf discs". **[hand; CL tools exact (levels 2, 3); one derivation (J12 §3.3); J13 pending]**
Level 2 (`W₂ = c₀^a 0^b`, complete box `2 ≤ a, b ≤ 12`): 16 pairs admitted, all verified directly; level 3 (box `2 ≤ a, b ≤ 6` from
`(2, 10)`): 17 admitted, all verified; plant P2 (the `X₃` margin as 1/6) admits 23 pairs that fail. Complete boxes a derivation fixed —
the ban's edge, logged; no member is load-bearing for FS91-J12-MS, whose proof is existential. *Proof:* J12 §3.3, `data/fs91/j12/oneb-check.txt`.
*Rests on it:* FS91-J12-H, J12-C2. *Kernel:* declined.

**FS91-J12-H, J12-W, J12-Ω — the hierarchy:** "an infinite hierarchy of band torsion characters with words `W_{n+1} = W_n^{a}W_{n−1}^{b}`"; "the words are primitive; their S-adic subshift is minimal and aperiodic". **[hand (H: tools exact at levels 2, 3); one derivation (J12 §3.3); J13 pending]**
*Proof:* J12 §3.3. *Rests on it:* FS91-J12-MS. *Kernel:* declined.

**FS91-J12-MS — "`MS₄({5})` is false: a `U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A` exists." [hand, one mind (J12 §3.3); J13 pending]**
Its points are switching characters on two letters (the parity leaf `0` and the `X₃` leaf `c₀`), uniformly recurrent, with bounded runs in
both directions — the construction branch of the brief's Stage 3 (J12 stage 5 addendum). `M` lies in the closure of the band torsion
characters but meets no leaf; its coding is an S-adic subshift of continued-fraction kind, not Berend's positive-entropy one; **Berend's
Lemma 3.3 is not used**; whether `M` has positive dimension is not decided (J12's remarks). *Proof:* J12 §3.3, `tools/crunch_j12_oneb.py`.
*Proof verdict:* closes on one reading. *Rests on it:* the correction owed to Frontier item 25 and G76 ("one prime fails for minimal sets
too", inventory item 121); FS-89's D prediction (`MS₄({5})` false, 0.75) met by a different mechanism; the plan's P-MS5 (0.60) met. *Prior
art:* pending the close gate; Manners §5.5's assertion (above) bears. *Kernel:* declined.

**FS91-J12-MSp — "the same at every `p ≡ 1 (mod 4)` (corollary; B1 re-derived at 5 only)." [hand, one mind (J12, stage 3 remarks); J13 pending]**
Uses only the parity and `X₃` leaves (margins `p`-free, A3), the rotating frame with `ε_p := w̄_p mod 3 ∈ μ₄`, and that `ω_p := ε̄_p w̄_p` is
not a root of unity. *Proof:* J12 stage 3 remarks. *Rests on it:* the "every `p`" form of the Frontier correction. *Kernel:* declined.

**FS91-J12-C1, J12-C2 — torsion by closing:** "a torsion `τ_e` of order `N` is band iff the `w̄`-orbit of `e` in `N^{−1}ℤ[i]/ℤ[i]` stays in `Q` (`w̄ ↦ tπ̄²`, `t ≡ 5^{−1}`)"; "one-segment closing lemma: margin `r`, return `|z_L − z₀| ≤ r|1 − ω^L|` ⟹ a band torsion character". **[hand; one derivation (J12 stage 4); J13 pending]**
*Proof:* J12 stage 4. *Rests on it:* FS91-J12-C3. *Kernel:* declined.

**FS91-J12-C3 — ONE-c (U5): "the orders of band torsion characters of `R₅` are unbounded — the family `c₀^a 0^b`, `N_{a,b} > √(a+b)`." With FS91-J12-C4: "`N_{a,b} ∣ 2·Nm(π^L − (−i)^Lπ̄^L)`, `L = a+b`: the orders' primes are those of `Φ_k^{hom}(π, −iπ̄)`, `k ∣ L`"; and FS91-J12-C3p, "the same at every `p ≡ 1 (mod 4)` (corollary; family re-derived at 5 only)". [hand; tools exact (the complete box `a, b ≤ 10`: 14 members, three code paths); one derivation (J12 stage 4); C3p one mind; J13 pending]**
The advisor's pointer (primes dividing `Φ_k(w₅)`) meets the family in its primes (J12's C0-c′). Complete box, the ban's edge, logged; S0B's
`torsion_points.py` not run past its own `N ≤ 130`. *Proof:* J12 stage 4, `tools/crunch_j12_onec.py`. *Proof verdict:* closes on one
reading. *Rests on it:* FS89-derivation §10's U5 row ("reading → theorem"); FS89-S0B §4's reading promoted and §6's "the leaf graph is
infinite if the torsion orders are unbounded: it is" (inventory item 121); the plan's P-U5 (0.35) met. *Prior art:* pending the close gate.
*Kernel:* declined.

## §7. Conjectures, readings and open steps M1 stated and did not prove (the close's sweep)

*Swept: "conjectur", "not claimed", "reading", "open", "GAP" in the plan and the nine records (WORKFLOW step 9's conjecture sweep). Each
gets a stub or a recorded decline in the plan's §R-close stage 4.*

| statement | who | status at this filing | where it goes |
|---|---|---|---|
| (g3) at `k = 7`: is the exact level `2e(𝔭|3) + 1` realised at `e ≥ 2`, or does a further lemma kill `e ≥ 2`? | J10-T8 against J07-11 | open (GAP in J07's lemmas; a `729⁵` search declined under the ban) | the stub of inventory item 79 |
| is CLG-g's exception (E1)/(E2) ever realised — a band 6/7-character at level ≥ 2 of the `U₆₄` tower, or level 3 at `q = 27`? | J07 §3.3, §4.2 | open; fields of degree ≥ 6 (E2) and ≥ 3 (E1) | the same stub |
| minimal sets of `Θ₄(R_p)`: positive dimension? is every non-`T + A` minimal set S-adic of J12's kind? the band-1/5 one-prime analogue | J12 §3.3 remarks | open | a stub (inventory item 123) |
| the explicit band-`k` torsion list of `Q` for `k ≥ 7` (an effective `N_k`) | J01 stage 3b "does not give"; J03a | open (`N_k` non-effective; J08 gives `k = 5, 6`) | FS-91's successor stub, a side question |
| S1 on every subfield of ℝ | J09 (J4-A) | GAP at two named steps (the definition of `L(F)`; J2's finiteness), FS-39's gap | FS-39 (the bridge) |
| CLG-e at a ramified dyadic place at `k = 3` | J07 | not claimed; harmless (`L = 2`) | declined (no consumer) |
| J01's parity route R2 as a second, Berend-free proof of `MS_β` | J01 | a theorem at one reader (FS91-J01-3) | declined (no consumer) |
| whether FS91-J01-7 is in print in full (Manners 2015 has the one-ring case; Wang 2012's solenoid form unwritten per Einsiedler–Lindenstrauss) | J23p | partly in print | J23p's later verdicts |
| `χ(ℚ(√167)²)`, `χ(Γ₂₃)`, `χ(Γ₄₃)` themselves | — | untouched: every M1 statement at four colours and up is about characters | FS-59, FS-17, FS-57 unchanged in substance |
| J08's reading "six hides only in non-character colourings; at the 6-open fields characters do not reach seven" | J08 stage 5 | a restatement of FS91-J08-8 plus the plane's 7-colouring; "Killing test of this reading: none" | G64's sentence (stage 4 draft) |
