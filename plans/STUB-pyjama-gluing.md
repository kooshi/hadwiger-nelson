# FS-93 — band rigidity from the pyjama theorem: one gluing step, an effective bound, density (stub)

*Minted 2026-09-25 at FS-91's close (crunch milestone M1) by its close planner (J23a, resumed as J23a2; de Bruijn, Opus 5.5), from the close
gate's stub candidate (`plans/FS91-PA-close.md` §C.5, J23p). Number assigned by the front-page job (J24); numbered FS-93 there. Written for a
session with zero conversation memory. Solver-free.*

## What is known, in plain words

**Band rigidity** (FS-89's row 95 at four and five colours; FS-91's FS91-J01-7 at every band, two blind readings): for a finite set `S` of
primes `≡ 1 (mod 4)` with `|S| ≥ 2`, every group homomorphism `θ` from `R_S = ℤ[i][1/p : p ∈ S]` to the circle that keeps every unit
vector of `R_S` inside a band `[1/k, 1 − 1/k]` is a torsion character plus an archimedean one; so the band characters of the whole rational
ring `Q = ℤ[i][1/p : p ≡ 1 (4)]`, and of every real field's unit-vector ring, are torsion plus archimedean, with torsion orders bounded by a
finite, **non-effective** `N_k`. The route: Berend's closed-set dichotomy with the rotated archimedean plane set aside, minimal sets
band-free, the band entering once through a multi-digit sweep (`plans/FS91-derivation.md` §1).

**The close gate found it partly in print** (`plans/FS91-PA-close.md` §1.3): `[Manners2015]` (F. Manners, *A solution to the pyjama problem*,
Invent. Math. 2015) Lemma 5.3 proves the same shape for the **half ring** `A = ℤ[i][1/P₅, 1/P₁₃]` — one Gaussian prime above each of 5 and 13,
acting by `⟨θ₅, θ₁₃⟩` — where the band condition is his *pyjama* condition and `[MalikiosisMatolcsiRuzsa2013]`'s "rational obstructions" are
our torsion band characters; `[Wang2012]` proves the torus form (Prop. 4.3 and Lemma 4.2 are PA-B2's architecture);
`[EinsiedlerLindenstrauss2022]` p. 3 says the solenoid form "does not seem to have been written"; `[KravitzLeng2025]` (arXiv 2510.17744)
makes Manners effective, torsion orders `≤ exp exp exp(ε^{−C})`. Not found in print: `R_S` with both primes above each `p` and the full
group `U_S`, other `S`, and the field clause. Undecided until `[Muchnik2005]` (*Semigroup actions on `T^n`*, Geom. Dedicata 110) is read.

## The questions

1. **One gluing step.** Does `RS_k(S)` for `R_S` follow from Manners's statement on the half rings — `A`, its conjugate `Ā`, and the mixed
   ones (`ℤ[i][1/P₅, 1/P̄₁₃]` and its conjugate) — by gluing characters that agree on the common subring? FS-91's one-prime result shows
   exactly where such a gluing can fail: at one prime `ℤ[i][1/π̄] + ℤ[i][1/π] = R_{{p}}`, and characters of the two halves agreeing on
   `ℤ[i]` glue to a band character outside torsion plus archimedean (FS91-J12-ONEa, two derivations). The question is whether two primes
   remove that freedom at the gluing stage.
2. **An effective `N_k`.** Transfer Kravitz–Leng's bound to `R_S`, `Q` and the field clause; FS-91 computed the torsion lists explicitly only
   at `k = 5` (`N₅ = 35,112`) and `k = 6` (`Θ₆(Q) ⊆ T_{105,336} + A`, FS91-J08-10).
3. **Density.** Manners Remark 5.4(i): "We know of no reason why the result could not be strengthened to give `Y = Â`". FS-91 proves values
   arbitrarily close to 0, not density of the orbit (recorded so that no one claims it).
4. **Read `[Muchnik2005]`** (not held; `plans/FS91-PA-close.md` §C.2 item 1) and settle the prior-art position of FS91-J01-7.

## Why it matters, stated honestly

**Bearing on the answer: none.** It settles attribution for band rigidity (row 95 and FS-91's row) and would make `H_k` effective — a finite,
checkable torsion list at every band, which turns every "given `H_k`" in the class theorem into a finite statement.

## Registered expectations (the stub-writer's guesses)

| id | statement | p |
|---|---|---|
| G-a | question 1 answered "yes": the two-prime statement follows from the half rings by a gluing whose one-prime failure mode is excluded | 0.5 |
| G-b | Kravitz–Leng's bound transfers to `Q` with at most one more exponential | 0.6 |
| G-c | `[Muchnik2005]` holds the full `R_S` statement | 0.2 |

## Routes

Derivation and reading only: the gluing (FS91-J12-A1's pushout `R = (S₊ ⊕ S₋)/ℤ[i]` at one prime is the model), Manners §5, Kravitz–Leng §1–§4,
Muchnik (to fetch). No search.

## Provisional bearings

G76 (closed-set rigidity with the rotated plane set aside; count the primes), G49 and G50 (a third literature, found through a dynamics paper's
citers; read what the gate found), G74 (the layer gluing, `5^{−k}`), G66 (effective bounds up a tower), G77.

## Addresses

`plans/FS91-PA-close.md` §1, §C; `plans/FS91-derivation.md` §1, §6; `plans/FS91-S0V-band-to-nine.md`; `plans/FS91-S0V2-SWm-second-reading.md`;
`plans/FS89-derivation.md` §4–§9a; held PDFs in `~/source/library/pdf/` (Manners2015, Wang2012, EinsiedlerLindenstrauss2022, KravitzLeng2025).
