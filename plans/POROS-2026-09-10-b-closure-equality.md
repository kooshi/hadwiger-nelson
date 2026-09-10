# Poros advisory II — M64's closure bound is an EQUALITY, and the rung lattice is free

*2026-09-10, on the M64 close. Nothing written into the repo. The central item is two lines of
derivation and is confirmed by numbers M64 already measured.*

---

## §Lead — you proved an inequality and the same two lines give an equality. You minimised over the wrong index set.

M64's closure argument ranges `M` over **`{M}`, the minimum-size refusers**. Range it over
**`min(R)`, ALL minimal refusers**, and the two-sided pair collapses:

> **Theorem.** `R` upward closed on subsets of `Atoms`; `H` any group acting on `Atoms`. Then
> ```
> M_H  :=  min{ |S| : S H-invariant, S ∈ R }  =  min{ |cl_H(M)| : M ∈ min(R) }
> ```

*Proof.* **≤**: `cl_H(M) ⊇ M` so it refuses (upward closure), and it is H-invariant. **≥**: let `S`
attain `M_H`. `S` contains a refuser minimal under inclusion, `M`; minimal-in-`S` is minimal
globally because every subset of `M` is inside `S`. For `h ∈ H`, `h(M) ⊆ h(S) = S`, so
`cl_H(M) ⊆ S`. ∎

**Two things to notice about the hypotheses, because they are weaker than M64 assumed.** `H` needs
**no equivariance** — it need not be a symmetry of `R`, of `A`, or of the companion; it need only
act on the atoms. And nothing about colouring, geometry or the group's structure is used. **So this
is a statement about upward-closed families, and it applies to any "restrict to invariant
selections" constraint, symmetry-derived or not.**

### Your data already proves the equality, with no new computation

M64: dead involution, bound over `{M}` = **376**, true `M_H` = **375**. The equality says the
minimiser is a minimal refuser **not of minimum size**. And M64 measured exactly that without
naming it:

> `0 of 1,302` rung-2-dead minima contain a rung-1 minimum.

A refuser strictly inside a 375-atom `S` has ≤ 374 atoms; any 374-atom refuser **is** a member of
`{M}` (374 is the minimum); so *"S contains no member of `{M}`"* ⟹ **S contains no proper refuser
at all** ⟹ **all 1,302 are themselves minimal refusers of size 375.** They are precisely the
witnesses that pull `M_H` from 376 down to 375. Same at rung 12: `0 of 4` ⟹ each of the four
contains a minimal refuser of size 375–378, so the rung-12 minimiser is again not of minimum size.

### So the answer to your question (2) is: **the bound never fails to be tight. It is the right
formula on the wrong index set, and the gap has an exact description.**

```
gap(H)  =  min_{M ∈ {M}} |cl_H(M)|  −  min_{M ∈ min(R)} |cl_H(M)|
```
— **the same functional on two nested index sets.** It vanishes exactly when some minimum-size
minimal refuser is a closure-minimiser. Measured: `0` at the live rungs, `1` at the dead
involution, `12` at the full stabiliser.

**And that IS overcompression, stated:** *containment fails at rung `H` exactly when the
`|cl_H|`-minimiser is a minimal refuser that is not of minimum size.* `[Parts2020a]` §6's sentence
— none of the 376-vertex graphs is an overgraph of any of the 375-vertex ones — is that condition,
holding.

---

## §1 — The rung lattice is FREE. `Y` is rung-independent, so every subgroup is a hitting set with zero colouring asks.

An `H`-invariant `S` is a **union of `H`-orbits of atoms**. By §O's duality `S` refuses iff `S`
hits every minimal correction set. Therefore

> **`M_H = min { Σ_ω |ω| · x_ω : x ∈ {0,1}^{Atoms/H},  ∀ C ∈ Y*, ∃ω : x_ω = 1 ∧ ω ∩ C ≠ ∅ }`**
>
> — a **weighted minimum hitting set over the H-orbits**, with weight = orbit size.

**A correction set is a set of atoms whose deletion restores colourability. That is a property of
the base problem, not of the rung.** So the `Y` harvested at rung 1 is the complete constraint
system for **every** subgroup at once. Consequences, all immediate:

1. **Every rung of the whole subgroup lattice is one small weighted hitting set on the `Y` you now
   store — no colouring asks at all.** M64 spent 195 s of solver on four rungs; the ~16 subgroups
   of `D_6` are a table computed in milliseconds.
2. **With a harvested `Y ⊆ Y*` the answer is a certified LOWER bound** (fewer constraints ⟹ smaller
   minimum), which is the matching bracket you asked for in (1). Your closure bound is the upper
   half; this is the lower half; **and §O(1)(b)'s sandwich closes it with ONE ask per rung** — verify
   `R(⋃ω)` — rather than a whole reduction.
3. **The product upgrades from four rows to the complete symmetry-cost function `H ↦ M_H` of one
   reduction problem.** Nobody in the record has that, and it is what a search over rungs needs.

**The registered test, and it can fail:** run the orbit-weighted hitting set over the stored `Y` at
the four rungs M64 already measured. **It must return ≤ 374, 374, 375, 378, and if `Y` is complete
enough it returns them exactly.** A value *above* any of those refutes either the duality or the
rung-independence of `Y` and is a bug. Cost: minutes.

---

## §2 — Your three candidates, scored

### (a) "Is there a matching lower bound?" — **YES, §1 item 2.** Theorem waiting. Rank 1.

### (b) "Does the matching structure predict `|{M}|`? 3,264 = 2⁶·3·17 and the 17 bothers me." — **Wind-egg. Drop it.**

`|{M}|` is a solution count of a covering problem; such counts have no reason to factor. And the
17 appears **once**: the S side is 48 = 2⁴·3, Parts's counts are 1,092 = 2²·3·7·13, and 78, 76, 27,
120, 8. **No 17 anywhere else, and no mechanism on offer.** By this project's own `G30` that is a
pattern seen once with nothing behind it. *What would change my mind: 17 (or 2,943 = 3³·109)
recurring in an independent level set.*

**The good question standing next to it, which you should take instead.** Your decomposition is
`336 necessary + one from each of 24 pairs + 14 of 18 residual` — **42 free binary variables**.
So `|{M}|` is an exact **#SAT** over 42 variables constrained by `Y`. That is instantaneous, and if
it returns **3,264** you have an **independent completeness proof of the level set by a second
method**, orthogonal to `exhaustive-level`. If it returns more, `Y` is incomplete and you have
learned exactly that. Rank 3.

### (c) "The closure excesses are not monotone in `|H|`." — **Category error, and the fix is one line.**

`H ≤ K ⟹ cl_H(M) ⊆ cl_K(M)` for every `M`, so the min is monotone. **`H ↦ M_H` is an
order-preserving map from the SUBGROUP LATTICE to ℕ, always.** Your "+4 at order 4 against +10 at
order 3" is `V` (Klein) against `C_3` — **incomparable subgroups**, so no monotonicity is claimed
or violated. Checked against every one of your numbers: monotone throughout.

*Is it a nicer lattice function? No — I checked yours.* Writing `e(H)` for the excess:
`e(S_3^A) = max(e(C_3), e(s_A)) = 10` and `e(V) = max(e(z), e(s_A), e(s_B)) = 4`, but
`e(S_3^B) = 16 > max(10, 2)` and `e(C_6) = 16 > max(10, 4)` — **not join-preserving**, and it is
supermodular on `{C_3, z}` (16+0 vs 10+4) while submodular on `{z, s_B}` (4+0 vs 4+2). **Neither.**
The structure is not in the group; it is in `min(R)`, exactly as the theorem says.

**One control your numbers pass and you did not claim: the excess is a CLASS FUNCTION.** The seven
involutions read `0,0,0 | 2,2,2 | 4` — the two reflection classes of `D_6` and the central element.
That is the right shape and it is free evidence the measurement is sound.

---

## §3 — FS-35: **neither candidate is a measure, and a measure is the wrong product.** Push-back, as asked.

M63 §O(3) is right that the loop has no termination measure. But look at *why*: expansion enlarges
the atom set, so the space of selections grows, so `min |M|` is **non-increasing** — it is already a
decreasing integer sequence bounded below by the true minimum. **Termination is not the problem;
STAGNATION is.** A local search does not have a measure; it has basins and escapes, and §O(3)'s own
sentence — *"the real stopping rule is `A` stopped changing"* — says so.

**So the product FS-35 should aim at is a LOOK-AHEAD: given a candidate expansion, predict whether
it lowers `|M|`, before running the reduction.** §1 gives one for free — the orbit-weighted hitting
set costs no asks, so a candidate expanded atom set can be *priced* rather than tried.

**Scoring the two candidates you were handed:**

| candidate | is it a measure? | is it a useful dial? |
|---|---|---|
| exchange-class vector | **no** — it is a property of `Prof`, and expansion rewrites `Y` arbitrarily | possibly, untested |
| per-rung closure bound | **no** — same reason | **yes, and it is cheap now** (§1) |

**The half-hour gate before you spend a session, and I would make it a hard precondition.**
You hold a recorded path: Parts's four states (M63 §4 phase E) and your own reduction runs.
**Compute both candidates at each recorded state and see whether they MOVE.** A proposed measure
that is constant along the one trajectory anybody has recorded is dead before the milestone opens,
and this costs half an hour against a session.

---

## §4 — Prior art

**(a) The gap has no name I can find.** Searched the symmetric-IP vocabulary — orbit closure /
saturation bound / fixed-space relaxation gap / invariant optimum. The literature's objects are
**core points** (Herr–Rehn–Schürmann; Bödi–Herr–Joswig), **orbitopes** (Kaibel–Pfetsch),
**orbital branching**, **orbitopal fixing** (incl. a 2026 SAT version, arXiv:2601.16855), and
**orbital independence** (Ann. Oper. Res. 2019). All are about *searching* a symmetric IP faster.
**None of them asks what M64 asks — the cost of the symmetry constraint itself, as a function on
the subgroup lattice.** Nearest relative: the LP-symmetrises / IP-does-not gap that core points
exist to repair. **I could not find `min_M |cl_H(M)|` under any name. That is encouraging and it
is also the reason to state the theorem in their vocabulary before believing it is new.**

**(b) Complete level sets: the field is MUS/MCS enumeration, and it is active.** Liffiton–Previti–
Malik–Marques-Silva, **MARCO** (*Fast, flexible MUS enumeration*, Constraints 2016) is the standard
tool; Bacchus–Katsirelos on using MCSes to compute MUSes; *Tunable online MUS/MSS enumeration*
(arXiv:1606.03289); a 2026 hypergraph-GNN acceleration (arXiv:2604.09001). **The one you should
read is `Exploiting Symmetries in MUS Computation` (arXiv:2412.13606)** — it is symmetry × MUS,
which is this milestone's exact intersection, and it was not in the M64 gate.

**What that field would do with a complete level set, which is what you have and they mostly do
not:** their standard derived quantities are **the backbone** (constraints in *every* MUS) and the
per-constraint criticality census. **Your `336 necessary` atoms ARE the backbone, and your 24
conservation pairs are a structure their vocabulary does not have a word for** — a backbone is a
0-dimensional statement (this atom is in every optimum) and a conservation pair is 1-dimensional
(exactly one of these two, always). **If you want a paper-shaped finding from M64 that is not about
Hadwiger–Nelson, that is it: complete optimum-level sets of a covering problem carry a
1-dimensional backbone, and it is computable by ask.**

---

## §5 — What you did not ask, and it is the one that touches the mission

**M62's own search is running at a rung, and this theory prices its tax.** The record says M62's
census *"collapses from 756 asks to 47, exactly, because all 24 group elements are automorphisms of
an orbit-closed selection"* — that is a rung-24 search — and the ladder reads **624 (24) / 576 (6) /
558 (3) / 582 (1)**. Two immediate consequences, both free:

1. **`H ↦ M_H` is monotone in the subgroup lattice**, so if those subgroups are nested the *true*
   minima satisfy `M_1 ≤ M_3 ≤ M_6 ≤ M_24`. **582 at rung 1 is therefore provably not the minimum**
   (the stub knew this); more usefully, **624, 576, 558 are certified upper bounds at every SMALLER
   rung too**, so the ladder's own numbers already bracket rungs nobody ran.
2. **The closure bound turns any single object into free upper bounds at every LARGER rung.** Take
   the 558-vertex rung-3 object and compute `|cl_H(·)|` for the order-6, -12, -24 groups — no
   solver, no search. On the L side the closure excess ran `0–16` and on the S side `8–24`
   (M64's own table, quantifying Parts's *"especially noticeable for S-subgraphs"*), so these are
   tight enough to be worth having.

**That converts the stub's honest *"bearing on χ(ℝ²) ≥ 6: indirect"* into something direct: M62 is
paying an overcompression tax it has never measured, and M64 just built the instrument that
measures it.** I would put one paragraph of the M64 close on this, because it is the sentence that
makes the milestone part of the hunt rather than beside it.

---

## §6 — Cards

```
question: is-the-rung-lattice-computable-with-zero-asks
  evidence: M64 stores Y (703 correction sets, L); an H-invariant refuser is a union of H-orbits and
    refuses iff it hits every correction set (M63 sec-O duality); a correction set is a property of
    the base problem, not of the rung
  expected: M64's four rungs cost 195 s of solver
  ask: does the orbit-weighted minimum hitting set over the stored Y reproduce 374, 374, 375, 378?
  if yes: the whole subgroup lattice is a table with no colouring asks, harvested Y gives a certified
    lower bound at every rung, and one verification ask per rung closes the sandwich
  if it returns a value ABOVE any of the four: either the duality or the rung-independence of Y is
    wrong -- that is a bug in the reduction, found cheaply
  answered by: run -- the hitting-set solver already in the pipeline, on Y, at orbit granularity
  cost: minutes
  hunch: yes, and Y is complete enough to be exact at the small rungs
  falsifier: a rung where the hitting set exceeds the measured minimum
  rank: 1
```

```
question: does-the-symmetry-cost-function-need-min-R-or-only-Y
  evidence: M_H = min over ALL minimal refusers of |cl_H(M)| (proved above); M64's bound minimises
    over {M} only and is loose by 1 and by 12; the 1,302 rung-2-dead minima are provably minimal
    refusers of size 375, which is what closes the gap there
  expected: M64 recorded the gap as an unexplained looseness
  ask: is the gap min_{M}|cl_H| - M_H predictable from Y alone, without enumerating min(R)?
  if yes: overcompression is computable a priori for any rung, which is FS-35's look-ahead
  if no: the gap is an invariant of min(R), and the honest product is the exact formula plus the
    orbit hitting set -- still a theorem, and it retires the search for a closed form
  answered by: derivation, then a run against the four measured rungs
  cost: half a day
  rank: 2
```

```
no question: whether 3,264 = 2^6 * 3 * 17 means anything
  need: a second occurrence. 17 appears in one count; the S side is 48, Parts's are 1,092, 78, 76,
    27, 120, 8, none divisible by 17, and no mechanism has been proposed. Take the 42-variable #SAT
    instead: it counts |{M}| exactly and gives an independent completeness proof of the level set.
```
