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
