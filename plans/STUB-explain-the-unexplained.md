# FS-25 — Explain the unexplained: six measurements that are theorems

*Minted 2026-09-09 by de Bruijn on Kooshi's direction — **"secure our current position. Explain the unexplained
with proofs."*** *The survey behind this stub combed the whole ledger (rows 1–59), all fifty-one grokkings, the
forty-six theory frames of `plans/STANDING-QUESTIONS.md`, and the `§R` sections they pointed at. Rank 1 was
re-derived and numerically re-checked by hand before this file was written — **and its first sketch was wrong in
a way worth recording**; see §2.1.*

---

## 0. Why this exists — for a reader with no memory of the project

This repository attacks the **Hadwiger–Nelson problem** (how many colours the plane needs so that no two points
one unit apart share a colour) through the arithmetic of the coordinate field. Sixty milestones of measurement
sit behind it, and the project's own methodological finding — grokking `G30` — is that **measurement generates
candidates and derivation kills them**, with a tally of eight-for-eight in favour of things derived before they
were measured and zero-for-ten against things inferred from measurements afterwards.

**This milestone is the harvest of that rule.** Not new mathematics in the sense of new objects: six places
where the record established something *per instance* and a general theorem was available.

## 1. The pattern, which is the survey's most useful output

Every item below has the same shape, and it is **not** the failure mode `G30` catalogues:

> **The record established something per-instance that holds in general, and stopped at the instance because
> the instance was what the instrument produced.** Four primes instead of all primes; one radius instead of the
> classification; one fabric piece instead of the size law; a numerical circulant instead of its closed form;
> measured directions instead of the group.

These readings are all *true*. The failure is quieter than promoting a false induction: **a correct instance
recorded where a theorem was available, because the instrument answered and the question closed.** That is
worth minting as a sixth failure mode under `G30`, and the recipe it implies is mechanical: *do not grep for
"unexplained" — grep for `[measured]` next to a small finite list of instances, and ask each one what the
general statement is.*

## 2. The work, ranked

### E1 — Every finite Euclidean plane is forced-pair-free, at every prime and every colour count

**Today:** four instances. `CLAUDE.md:1105` (ledger row 55): *"the sealing planes at 3, 7, 11, 19 are ALL
pairwise free at their own chromatic number"*, each established by exhibiting a table. `CLAUDE.md:3203` (G47)
carries it as reading (i), *"four instances"*, with a falsifier named.

**The theorem.** For every prime `p ≡ 3 (mod 4)` and every `k`, the graph on `𝔽_p × 𝔽_p` joining points whose
difference has `a² + b² = 1` has **no pair forced to share a colour** in every proper `k`-colouring.

**The proof, in five steps, all of whose pieces are already in the kernel.**

1. A forced pair reduces to the origin (`ResidueObstruction.forces_iff_forces_zero_sub`, `:77`), so it is a
   `d ≠ 0` such that **every** proper colouring is `d`-periodic
   (`ResidueObstruction.not_forces_zero_of_not_periodic`, `:106`).
2. The period group of a colouring is a subgroup of `𝔽_p²`: either `0`, one of the `p+1` lines, or everything.
   It is not `0` (it contains `d`) and not everything (that colouring would be constant, hence improper).
3. So it is a line `ℓ`, and `ℓ` must **miss the unit circle** — otherwise the colouring identifies two adjacent
   points. There are exactly `(p+1)/2` such lines.
4. **Those `(p+1)/2` lines form a single orbit under multiplication by norm-one elements**, and multiplication
   by a norm-one element is a graph automorphism. (Orbit–stabiliser: `|μ_{p+1}| = p+1`, the stabiliser of a
   line is `±1`.)
5. So rotate: `c' = c ∘ r⁻¹` is a proper colouring with the same palette whose period line is `r·ℓ ≠ ℓ`, and
   two distinct lines meet only at `0`, so `d ∉ r·ℓ` and `c'` is not `d`-periodic. Contradiction.

**Verified here 2026-09-09** at `p = 7, 11, 19, 23, 31`: the count of circle-missing lines is exactly `(p+1)/2`
at each, and the norm-one action on them is transitive at each.

**⚠ A correction to the first sketch, recorded because it is exactly the trap this project keeps falling into.**
The argument was first written with *"the line is **null**"* meaning **isotropic** (`a² + b² = 0`). That is
false and this repository proves it false: `LocalGlobal.quadrance_eq_zero_iff` (`:230`) says a `p ≡ 3 (mod 4)`
plane has **no** isotropic vectors at all. `plans/M61-local-global-tightness.md:304` uses "null line" in a
different sense — *"its direction of non-square norm"*, i.e. a line the circle misses — and the argument is
correct in that reading and only that one. **Anyone writing this up must state which sense they mean in the
first sentence.**

**Why this is rank 1.** M61's central mechanism (`G48` — the spindle over a forced pair turns off exactly the
prime that sealed the fabric) takes *"the plane at `p` is `k`-forces-free"* as a **hypothesis**, discharged
today by a table per prime. So the tightness mechanism only fires where somebody has already solved a plane.
Proved in general **it fires everywhere** — at 23, 31, 43, 47, 83, 107, 131, whose tables nobody has and whose
computation the record prices as possibly out of reach.

**Cost:** an afternoon of mathematics, one short milestone in Lean. The only real work is "rotation by a
norm-one element is an automorphism" and step 3. **Confidence: high** — the argument is checked and the pieces
are named.

### E2 — Which circles close, and why the `r² = 3` shell is the Moser twist

**Today:** `plans/M18-the-120-degree-class.md:118` records *"`r² = 3` is NOT explained by the 120° story (its
angle is irrational, its structure pure paths)"* as a census result, and `:91` defers the general question:
*"the odd-cycle-uniqueness claim is a theorem about the field (deferred, §5)"*. Ledger row 6 holds the single
instance `r² = 1/3` in the kernel (`ClassGeometry.exists_unit_triangle_iff`).

**The theorem.** The unit chords of a circle of radius `r` are all steps of one rotation by `θ` with
`2 cos θ = 2 − 1/r²`. That rotation has **finite order — the chords close into cycles rather than running as
infinite paths — exactly when `r = 1/(2 sin(πk/n))`, the circumradius of a regular `n`-gon of unit side.** For
rational `r²` that leaves precisely `1/r² ∈ {1,2,3,4}`, of orders 6, 4, 3, 2.

**Why derivable, and the repository has run the argument once already.** Ledger row 2 proves the seam rotation
has infinite order because *"its trace squares to 1/3, no algebraic integer"*. Generalise: `2 cos θ` is an
algebraic integer for every rational angle, so if `r²` is rational then `2 − 1/r²` is a rational algebraic
integer in `[−2,2]`, hence an integer. The irrational case inverts directly.

**Two payoffs the record wants and lacks.**
* At `r² = 3`, `cos θ = 5/6` — **the Moser twist**, and `Copy.spindleRot √3 = moserTwist` is already kernel
  (ledger row 46). So the `r² = 3` shell's own chords **are** the direction ladder — the object the literature
  calls the *Moser lattice*. That is why it is the second-heaviest structure in M18's census and why it is all
  paths.
* **It unifies M18's class geometry with `G3`'s heptagonal scope correction.** Haugland's Moser-spindle-free
  5-chromatic graph is built on radii `1/sin(2kπ/7)` — the `n = 7` member of exactly this family. The record
  treats that fabric as foreign; it is the same theorem at a different `n`.

**Cost:** an afternoon; half a page of mathematics and a Lean statement beside `exists_unit_triangle_iff`.
**Confidence: high** (arithmetic checked both directions).

### E3 — The periodic quotient is a classical circulant, and the record never says which

**Today:** `plans/M61-local-global-tightness.md:300–331` reduces every periodic colouring of a finite plane to
a colouring of a circulant `C_p`, then computes `χ(C_p) = 3, 4, 6, 5, 8, 8, 8, …` **prime by prime with a
solver**, *"every `lo` the solver's"*. Registered prediction P7 (`χ(C_p) ≥ 6` for every `p ≥ 23`) is
*"measured to 71"*.

**The theorem.** `C_p = Cay(ℤ/p, D)` with `D = { t : t² − 4ν is a non-square }` for any fixed non-square `ν` —
equivalently `D` is the set of **traces of the non-split torus of `𝔽_{p²}`**, its complement the traces of the
split torus. The projection along a circle-missing line is `z ↦ Tr(cz)`; the unit circle is `μ_{p+1}`; and
`t = Tr(cz)` for some norm-one `z` exactly when `γu² − tu + γ̄` has a norm-one root, which is the non-square
condition. The circle-missing requirement is precisely `N(γ)` a non-square, which is also what forces `0 ∉ D`
— a property the record states and does not explain.

**Checked against the record's own table**: at `p = 7` it gives `Cay(ℤ/7, {±1,±2})`, `α = 2`, `χ = 4` ✓; at
`p = 11` a cycle power whose chromatic number is the classical `⌈11/⌊11/4⌋⌉ = 6` ✓ — matching the solver
exactly and giving *"no periodic 5-colouring at 11"*, the record's most load-bearing periodic fact, a
closed-form proof.

**Payoff.** `χ_per` stops being a solver output; the eigenvalues of `D` join the same Kloosterman/Salié family
M58 already uses for the plane itself (ledger row 53), so **P7 becomes a bound to prove rather than a table to
extend**; and `α(C_p)` acquires a combinatorial description, which is what drives M61's `α(UD) ≥ p·α(C_p)`.

**Cost:** the identification, an afternoon. `χ(C_p) ≥ 6` for all `p ≥ 23`, one milestone and possibly research
— but the identification is worth having either way. **Confidence: high** on the closed form (verified at two
primes against our own table); **medium** on P7 falling out.

### E4 — The 1581's zero forced-equal pairs at five colours is a corollary, not a sweep — and it is the cheapest item here

**Today:** `CLAUDE.md:2545` (G31) reports *"nothing at arity 2 (complete, 1,248,990 pairs)"* as a completed
measurement.

**Half of it is free.** `CriticalSet.encard_criticalSet_le_two_of_forces` (`:276`, kernel, M54): an injectively
drawn unit-distance graph forcing a pair equal at its own chromatic number has **at most two** critical
vertices. And `G10` (`CLAUDE.md:2001`) already holds the input: *"two edges PROVEN critical end-to-end"*.
Deleting either endpoint of a critical edge leaves a subgraph of a 4-colourable graph, so both endpoints are
critical vertices; two distinct edges have **at least three** endpoints. `3 > 2`, so **de Grey's 1581 forces no
pair equal at five colours, by theorem.** The forced-equal half of that sweep was measuring a theorem.

**M54 already ran this exact argument for the other witness** — `plans/M54-five-colour-dial.md:419`: *"Hence 0
forced-equal candidates and 0 virtual-edge candidates at five colours BY THEOREM, and T21's exhaustive zero
(858 s) was an instance."* It was never carried back to the 1581, which is the object `G9` and `G31` are about.

**What does *not* promote, and this matters:** the **virtual-edge** half needs
`|C| > |N(p) ∪ N(q)| ≤ 120` (`criticalSet_subset_union_neighborSet_of_separated`, `:200`), so ~121 four-colour
asks — or the exhaustive edge-criticality sweep `G10` prices at a day of CPU, which would give `C = V` and
close both halves at once. **Arity 3 and 4 are not covered at all**, so M48's 3.3-billion-question sweep keeps
its full value; only the pair layer collapses.

**Cost:** an hour to write, or a day of CPU to close both halves. **Confidence: high.**

### E5 — The 16-pair residue on `K`-fabric is a size effect, and three of the four facts are already ours

**Today:** `plans/STANDING-QUESTIONS.md:701` (T26) records that on the 1,953-point `K`-fabric the algebraic
localization forces 187 pairs at four colours and the solver forces 171 — *"the 16 depth-3 pairs (13 at 64/9, 3
at 64/3) … are the non-additive residue"* — and asks whether they are two Kempe swaps away.

**They are at `d = 8/3` and `d = 8/√3`.** Ledger row 59 records from `[Parts2020a]`'s Table 1: *"monochromatic
pairs at `8/3` (367 vertices) and `8/√3` (421)"*. Ledger row 47 records our own dial on the descended
`K`-object: *"163/178 at 8/3, 8/11 at 8/√3"*. **The same two distances are forced on three other objects and
not on `U`.** Three of those four facts are in this repository and the fourth is in a paper it cites; nobody
has put them in one sentence. The localization is not over-forcing — `U` is under-sized.

**The sharper theorem underneath, which is the real prize.** There are now two independent necessary conditions
on a four-colour mono pair over `K`, and they differ by one level:
* the **valuation law** (ledger row 59, kernel): forced ⟹ `v_𝔭(d) > 0`, i.e. **depth ≥ 1**;
* the **additive localization** (T26, measured): forced ⟹ **depth ≥ 2**.

They reconcile arithmetically: the residue colouring **is** one of `U`'s eight additive colourings, so
`F_add ⊆ ker(residue) = {v > 0}` for free, and the extra depth is contributed by the **six `ℤ/4`-type
homomorphisms**. Identifying those six explains where the depth-2 boundary comes from — and T27 already notices
the offset without explaining it.

**Cost:** the connection, an afternoon. The reconciliation, an afternoon to a milestone. **Confidence:** high on
the connection (the numbers match exactly), medium-high on the reconciliation.

### E6 — The mirror of additive rigidity: virtual edges from arithmetic

**Today:** `AdditiveRigid.lean` proves `forces_of_additivelyRigid` — if every colouring of a chunk is additive
then a pair at a `5Λ`-difference is forced monochromatic. **The mirror is missing**: if every colouring is
additive then a pair separated by every homomorphism is a **virtual edge**. Same two lines
(`Additive.not_forces_of_addMonoidHom` is the existing sibling).

**What it converts.** Ledger row 45's *"148 absolute virtual edges at distances 3 and 4"* and *"412 absolute
never-3-distinct triangles in five families on {√3, √7, 2√3, √13}"* — both established by **enumeration**, the
second after `G21`'s third instance corrected the count from 16 to 412. The distance-3/4 half already has its
arithmetic explanation recorded (`CLAUDE.md:977`, M56's L5); the triangles have none. The triangle statement is
the same lemma at arity 3: a triple with difference vectors `a, b, a+b` fails to be rainbow under an additive
colouring exactly when one of `ψ(a), ψ(b), ψ(a+b)` vanishes — a condition on the lattice and nothing else.

**Why it is worth doing:** T2 gates design decisions on a replication of the polarization that has not run. A
derivation removes the gate, and says which lattice condition puts the fifth family at `√13`.

**Cost:** an afternoon. **Confidence:** high on the lemma, medium on how much of the 412 it covers without case
analysis.

## 3. The honest part — what is unexplained because it is hard

Recorded so nobody re-opens these expecting an afternoon:

* **`G24`'s gap** — `ω = 3`, every relaxation ≈ 4, `χ = 7` on the 23-vertex core — is Hadwiger–Nelson's own
  pathology in miniature. No mechanism is available. `[Krebs2022]`'s criterion for `χ > ω` is the nearest thing
  and is one page nobody can get.
* **The exact chromatic numbers of the planes at 23, 31, 43, 47** (T38/T41/T46) are computations, and the
  milestone that would run them is explicitly out of the current scope.
* **`G9`'s five antipodal forced pairs on de Grey's 791-forcer** (*"still mechanically unexplained"*) is
  tempting because all six forced distances have positive 2-adic valuation, matching ledger row 59's law
  exactly. **Do not start on that.** The law's hypothesis is the field `K`, and de Grey's field breaks the
  2-adic wall, so the proof has no purchase; extending the law to wall-broken fields is research. Chasing it on
  the strength of a numerical coincidence is precisely what `G30` warns against, and the warning is worth more
  than the lead.
* **T24's one-sided freeing** and **T44's residue-norm-1 concentration** are real and registered, but both want
  a measurement before a derivation rather than after; they are already ranked as FS-16.
* **M34's 122-vertex core against de Grey's 121** — *"the size echo is striking and unexplained"* — is almost
  certainly a coincidence. Not worth an hour.

## 4. Method, order, acceptance

* **E4 first** (an hour, and it converts a headline measurement into a theorem), then **E2** and **E3's
  identification** (an afternoon each, no Lean required to be useful), then **E1** (the prize), then E5, E6.
* **E1 blocks nothing but unblocks much**: G48's hypothesis at every prime. Do it before any milestone that
  wants the tightness mechanism at a prime whose plane is unsolved.
* Every promoted statement **keeps the measurement beside it**, marked as the instance that motivated it — the
  record's rule is amend-in-place, and a derivation that erases the measurement that found it is a worse record
  than one that carries both.
* Any Lean work goes through **`./scripts/build.sh`, never `lake build`**, then `./scripts/axioms.sh`.

**Acceptance:** each item lands as a theorem or as an honest "this did not work, and here is where it broke";
the grokking or ledger row it came from is amended in place with its new status; and `G30` gains the sixth
failure mode of §1.

**Bearing on χ(ℝ²) ≥ 6:** E1 is real (it makes G48 fire at unsolved primes, which is the mechanism the whole
FS-6 design target rests on); E2 and E3 are structural; E4, E5, E6 are consolidation. **M62 (FS-6) remains the
ranked rank-1 milestone for the hunt itself.**
