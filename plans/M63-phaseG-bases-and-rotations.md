# M63 phase G — new bases and new rotations

*Planned 2026-09-11. The phase where this project stops reproducing `[Parts2020a]`'s object and starts
looking for one he never reached. **Planning only: nothing here has been run beyond the cheap exact
arithmetic §3 reports, and every number in §3 is a registered expectation for the implementer to
reproduce, not an established measurement.** Approved as its own milestone at M63's close (M63 §S.4);
this file is its subplan.*

---

## §0 — The correction that created this phase, and what it changes

Kooshi, 2026-09-11: *"Shrinks are context dependent, so the goal should be to reproduce Parts' method so
that we can find smaller graphs that he may not have gotten to — also, we need to get to the point where
we introduce new bases and rotations, where it is most likely to actually find something novel."*

So **his base lattice and his one rotation are his starting point, not ours.** Every phase before this one
worked on inputs he published; this one works on inputs nobody has tried. The record hunt's product is
unchanged (a unit-distance graph below 509 vertices that refuses four colours, kernel-certified), and the
phase's own product is narrower and more likely to land:

> **An exact, exhaustive, arithmetically filtered answer to `[Parts2020a]` §4's own sentence —
> *"Working constructions of type M with other rotations are not known yet"* — on a named base:
> here is every rotation that can carry one, here is what each is worth, and here is which are alive.**

Either verdict is a finding. A positive is a new construction family. A negative — *no rotation outside
the `√15` class can work on this lattice, and here is the theorem that kills each one* — explains a
fifty-year monoculture and is worth publishing beside Theorem B.

**What this phase does NOT do:** shrink his object further (ruled out as a product, M63 handoff §5), run
the joint reduction (abandoned by ruling, M63 handoff §6), or re-plan the expansion loop (a separate
planner owns multi-orbit expansion by group testing over a monotone predicate; this plan assumes it
exists and states in §6 exactly what it must be handed).

---

## §PA — Prior-art gate (WORKFLOW step 3a, G49, G50)

*Run before the derivations in §1, in the disciplines' vocabulary and never in this project's coined
words. Four searches by question, three by method, two disciplines, two venues outside arXiv.*

### PA1 — The question is asked in print, twice, and never answered

1. **`[Parts2020a]` §4, verbatim** (read from our own text extraction, `library/notes/parts-2010.12665-layout-text.txt`, line 288):
   *"Working constructions of type M with other rotations are not known yet."* In the same paragraph he
   gives the mechanism: type M is *"two base graphs rotated relative to each other so as to obtain many
   additional unit edges of two or more kinds"*, and *"Unlike graphs of type A, the existence of triangles
   of the second kind is essential."*
2. **The Polymath16 first thread, 20 April 2018** (`[Polymath16threads]`, held at
   `library/notes/polymath16-threads-1-18-text.txt`). After a construction using a rotation by
   `arccos(7/8)`, **edbonnet** asks, verbatim:

   > *"Is arccos(7/8) 'empirical' or does it come with a reason of why this angle works when other angles
   > fail? Also, is this proper to the Moser spindle? I mean, what about the same type of construction
   > using the Golomb or the 'double' Golomb graph as a building block?"*

   **Tamás Hubai's answer, the same day**, is provenance and not a reason: *"It is the angle used for
   rotation in section 3.3 of the original proof, implicitly occurring as the smallest angle of a triangle
   with sides 1, 2 and 2."* **That is the whole published answer to this phase's question, and it is an
   attribution.** Eight years of subsequent work uses the same angle.

**So the question this phase answers has been posed twice, in two venues, by two people, and answered by
nobody.** That is the aiming information the gate exists to buy.

### PA2 — The method is published, in the exact form §1 re-derives

Also in the first Polymath16 thread (2018), a commenter proposes a **ring-growing recipe** which is
literally the formula §1.1 derives:

> *"Observe that the law of cosines … states that H² = a² + b² − 2ab·cos(T) … It is natural to add to our
> present ring a new element selected to cause there to be a new unit-distance |H| = 1 available. That
> suggests adding to the picture, the complex number `exp(i·arccos((1 − |a|² − |b|²)/(2|a||b|)))` where a
> and b are elements of the old ring. We then get a new extended ring."*

He then runs it greedily — ℤ → Eisenstein integers (χ = 3) → the Moser ring (χ = 4) → `arccos(7/8)` at the
Eisenstein length 2 — and proposes continuing at the next lengths, `arccos(13/14)` and `arccos(17/18)`.
Mixon's notation in the same corpus, `ω_t = exp(i·arccos(1 − 1/2t))`, is `[Polymath16wiki]`'s and
`[Heule2019]` §2's, and is already in our own translation table (`BIBLIOGRAPHY.md` §E, with the warning
that their index is the **squared** distance).

**What this means for us, stated so it cannot be overclaimed:**

* The **diagonal** case of §1.1 (`|a| = |b| = t`, giving `cos = 1 − 1/2t`) **is prior art, from 2018**, and
  is not ours in any form.
* The **off-diagonal** case (`|a| ≠ |b|` on one ray, which is where Parts's own second kind lives) is
  stated by the same formula and **never enumerated by anyone**: the recipe is used greedily, one step at
  a time, to grow a ring, and no posting turns it into a census over a base.
* **Ours is therefore the census, the filters and the verdict — never the formula.** Any write-up says so
  in those words and quotes the 2018 comment.
* Hubai's own rotation-by-`arccos(7/8)` constructions and `[Parts2020a]`'s type T (`G = ⊕³V₃₇`,
  `V₃₇ = H¹ ∪ ρH¹`, 6,937 vertices) show the recipe being used; neither enumerates alternatives.

### PA3 — The second discipline: coincidence site lattices (crystallography)

**The recognition sentence (G46):** *a rotation that maps part of a lattice onto part of the same lattice*
is, in crystallography and quasicrystal theory, a **coincidence rotation**, its image a **coincidence site
lattice (CSL)**, and the index of the intersection its **coincidence index Σ**. Searched under that name:
*coincidence site lattice*, *coincidence rotations*, *planar module N-fold symmetry*, *Eisenstein
integers Σ index*. Found, and **not previously in this project's bibliography**:

* **arXiv:math/0511147**, Baake–Grimm, *Planar coincidences for N-fold symmetry*, and
  **arXiv:math/0511306**, Baake–Grimm, *Multiple planar coincidences with N-fold symmetry*. The planar
  coincidence problem is solved for all N < 46 by reformulating it in cyclotomic fields and factorising
  ideals; for the triangular lattice ℤ[ζ₃] every coincidence rotation is
  `ε · ∏_{p ≡ 1 (3)} (ω_p/ω̄_p)^{t_p}` with `Σ = ∏ p^{|t_p|}`, and the group of them is `C₆ × ℤ^(ℵ₀)`.

**The verdict, which is informative rather than a hit.** A coincidence rotation of the hexagonal lattice
has *rational* cosine and lies in `K(i)` — exactly the class **Theorem B four-colours and our filter 1
rejects structurally** (§2). The rotations this phase wants are precisely the **non-coincidence** ones:
Σ infinite, the intersection of the two copies a thin set, and the union leaving the field. So the
discipline that has solved the neighbouring problem completely has solved the complement of ours, and its
machinery (Dirichlet series counting coincidences by index) does not transfer. Recorded in
`BIBLIOGRAPHY.md` §C with that verdict. **It is still worth having**: it is the vocabulary in which "which
rotations relate two copies of this lattice" is a named, classified question, and it says in one sentence
why the useful rotations are the ones with the fewest coincidences — the same fact M62 §M2.1 measured and
the same reason the ranking must not use cross-edge counts.

### PA4 — Searched, nothing found

| searched | where | result |
|---|---|---|
| smallest 5-chromatic unit-distance graph, 2025–2026 | arXiv, MathWorld, ResearchGate | **509 still stands** (`[Haugland2026]`, August 2026, says so in its introduction). No competing rotation |
| unit-distance chromatic number by **number field / ring of integers / arccos rotation** | arXiv + general web | the known corpus only; nothing enumerating angles |
| **Minkowski-sum base construction** for unit-distance graphs | arXiv + Polymath wiki | the construction is standard (`⊕ⁿ`, `[Parts2020a]` §2, `[Heule2019]`); **no comparison of bases**, and no criterion for choosing one |
| union of two rotated copies of a lattice, angle enumeration | arXiv | `[PartsOdd2022]`'s 6-chromatic odd-distance graph uses **two** angles, `arccos(7/8)` and `arccos(31/32)` — the second is the diagonal `ω_16` of the same family, on the hexagonal lattice, **which is the only published use of a type-M rotation other than `ρ₁₅` we have found**. It is a different problem (odd distances) and does not answer §4's sentence, but it is the nearest thing to a second data point and it should be read in full before the census is believed (it is held: `library/pdf/arXiv-2206.12632.pdf`) |
| a follow-up improving 509 | arXiv, Geombinatorics listings | none; `[deGreyParts2023]`'s edge discard is the only later change to the object |

**One reading debt created and named** (G50): `[PartsOdd2022]` is held and has been searched but its
construction section has not been read. **It blocks nothing in §2–§4** (its object is an odd-distance
graph) **but it must be read before any claim that a second rotation is unprecedented.** Half a day.

---

## §1 — The derivation, before any code

### 1.1 — Every rotation with `cos θ ∈ K` is `k/p` for a collinear pair, and that is a complete enumeration

`typem.CrossLaw`'s derivation, carried one step further. Identify the plane with `K(i)`, `K = ℚ(√3,√11)`.
For `u, v ∈ K²` and a rotation `ρ` of modulus 1,

```
|u − ρv|² = 1   ⟺   Re(ρ · conj(u) v) = k ,      k = (|u|² + |v|² − 1)/2 ∈ K.
```

Write `conj(u) v = p + i q` with `p, q ∈ K`. If `ρ = c + i s` with `c ∈ K` and `s ∉ K`, the identity splits
over the `K`-basis `{1, s}`:

```
q = 0      (u and v are collinear with the centre)        and        c · p = k.
```

**Therefore, on a given base, the rotations with `cos θ ∈ K` that carry any cross edge at all are exactly**

```
cos θ = k / p ,   over pairs (u, v) of base points on one line through the centre,
                  p = Re(conj(u) v) = ± √(|u|²|v|²),   k = (|u|² + |v|² − 1)/2.
```

This is an **enumeration over the base's lines**, not over its point pairs: exact `K` arithmetic, no
squareness test, no float in any verdict, and `O(Σ_lines n_L²)` work — thousands of operations where the
radius sieve does `O(R²)` exact squareness tests. The diagonal sub-case `v = u` gives
`cos = 1 − 1/(2|u|²)`, which is `[Polymath16wiki]`'s `ω_t` and **prior art** (§PA2); the off-diagonal case
is the same formula on the same ray at two different radii, and is where `[Parts2020a]`'s essential second
kind lives.

**Calibration, and it is exact**: on his lattice the diagonal family at `|u|² = 4` returns `cos = 7/8`,
and his auxiliary family `((17 ∓ √33)/6)` — an off-diagonal pair, product `(8/3)²` — returns `cos = 7/8`
as well. **His two "kinds" are two collinear families at one angle, and the derivation hands back both.**

### 1.2 — What the persisted 412-class list actually counts, and why it is not this

`data/m62/rotations-moser-r2.05.json` is **not wrong**, and it is **not a list of rotations** in the sense
this phase needs. Four gaps, each checkable:

1. **It is keyed on the square class of the radicand `D = ab − k²`, not on the angle.** One class holds
   several distinct angles: the record's own class (`D = 205/24 − 35/24·√33`, confirmed here to be the
   square class of **15**) contains `cos = 7/8` **and** a second angle near `0.8039` from the radius pair
   `(19/2 − 3√33/2, 14 − 2√33)`. So "families per class" over-counts the quantity Parts calls essential.
2. **It enumerates over all ordered radius pairs, including pairs that no line of the base realises** —
   `√(ab) ∈ K` is required for a collinear pair to exist, and 91 of the 150 persisted classes have **no**
   collinear family at all. Those rotations have `cos ∉ K` and **no cross-edge law exists for them today**
   (§1.4).
3. **Only 150 of the 412 are persisted** (`top` is truncated); the other 262 are not on disk. **And of
   those 150, measured here: 59 have at least one collinear family, 91 have none at all, and *zero* have
   all their families collinear** (family counts 0: 91, 1: 27, 2: 13, 3: 9, 4: 6, 6: 3, 9: 1). So a
   compute census pointed at the parameterised `cos ∈ K` law over that file would be aimed at a sample
   where the majority of entries contribute nothing, which is the number that sizes this phase.
4. **It is computed on the Moser lattice ball**, which M62 §R7/§R22 established is the wrong base: 37 of
   Heule-510's 510 points lie outside it by radius alone, and only 90 lie in it at any radius.

**None of this is a defect of M62's sieve, which was aimed at a different question** (which radicands can
appear at all). It does mean the headline *"411 other admissible rotations"* must not be carried into this
phase or into a write-up without the four qualifications above.

### 1.3 — The endpoint-radius bound is `1/|sin θ|`, and it exists only because `cos θ ∈ K`

For a collinear pair at radii `t, s` on one ray, `1 = t² + s² − 2 t s cos θ`. The form is positive definite
(`|cos θ| < 1`), its solution set is an ellipse, and real `s` requires

```
t ≤ 1 / |sin θ| .
```

At `ρ₁₅` that is `8/√15 ≈ 2.0656`, reproducing M62 §R22's bound and its measured consequence (126 cross
edges at radius 2.00 and 126 at radius 2.44, unchanged). **So each rotation sizes its own arena in one
line, and phase G's acceptance item "a base sized from that rotation's own endpoint bound" is a formula
rather than a per-law derivation.**

**And the asymmetry that follows is a reason to do the `cos ∈ K` family first.** For `cos ∉ K` the angle
between `u` and `ρv` is not fixed, only `| |u| − |v| | ≤ 1` is forced, and **no endpoint-radius bound
exists**: such a rotation's arena cannot be sized by this argument at all.

### 1.4 — The general law, for `cos θ ∉ K`, derived here and worth implementing

Phase G's acceptance calls this *"a new derivation"* and M63 §S.5 prices it as *"worth paying for only
once G's census shows more than one rotation refuses"*. **It is two linear equations, and the plan is to
implement it in phase G2 rather than defer it.** With `ρ ∈ K(i, √D)`, write

```
ρ = (c₁ + c₂√D) + i (s₁ + s₂√D) ,      c₁, c₂, s₁, s₂ ∈ K .
```

`Re(ρ(p + iq)) = k` splits over `{1, √D}` into **two `K`-linear conditions on the pair**:

```
c₁ p − s₁ q = k        and        c₂ p − s₂ q = 0 .
```

The collinear law is the case `c₂ = 0, s₁ = 0`: the second equation becomes `q = 0` and the first
`c₁ p = k`. The coefficients come from the pair that generates the rotation: with `w = conj(u)v = p + iq`,
`ab = |w|²` and `D = ab − k²`,

```
ρ = (k + i√D)/w ,   so   c₁ = kp/ab ,  c₂ = q/ab ,  s₁ = −kq/ab ,  s₂ = p/ab .
```

**Implementation hazard, named because it will bite:** `√D` is defined only up to sign and up to
`K`-scaling (`D' = t²D` gives `√D' = t√D`), so `(c₂, s₂)` must be normalised against a **canonical square-
class representative of `D`** before they are used as a dictionary key, or one angle splits into many.
The census's own control catches this: the record's rotation must appear exactly once.

---

## §2 — The filter cascade: cheapest first, and what each verdict proves

*The design rule (the coordinator's cost lesson, 2026-09-11): **the cost of a reduction is the enumeration
of its level set, not finding its optimum** — 188 seconds to the optimum against 79+ minutes and counting
to enumerate the level, on the same instance. **This census never enumerates a level.** It asks one
refusal question per rotation and stops. Only a rotation that survives every filter is handed to a
reduction, and even then the first question asked of it is "is there a refusing selection below X", never
"how many are there".*

| # | filter | cost per rotation | what a rejection **proves** | what it merely **suggests** |
|---|---|---|---|---|
| 0 | **`cos θ ∈ K`?** | free | nothing — this is a *scope* cut, not a rejection: `cos ∉ K` rotations are deferred to §1.4, never eliminated | — |
| 1 | **Theorem B**: `sin²θ` a square in `K` | one exact squareness test, µs | **Everything, for ever, on every base.** `ρ ∈ K(i)`, the whole union is drawn in `K²`, and `chromaticNumber_seamPlane` (kernel) four-colours it. No search over such a rotation can ever return a 5-chromatic object | — |
| 2 | **the 2-adic wall**: is `K(√(sin²θ))` wall-breaking? | one 2-adic classification, µs (`tools/wall_break_test.py`) | **The union's coordinate field has a conjugation-fixed prime above 2 with residue field of size ≤ 4, so its whole plane is 4-colourable** — *modulo G35's stated field-level gate* (kernel for graphs over the valuation subring; the general field statement needs the residue-field lemma). For `K` itself the kernel proves it outright (Theorem B) | that the specific arena is 4-colourable — which filter 4 then confirms, and which is exactly the registered prediction that makes filter 4 a **negative control for the wall theory** |
| 3 | **≥ 2 radius kinds at this angle** | free (the census counts them) | that the construction shape `[Parts2020a]` calls type M is unavailable. **Proved exhaustively for `ρ₁₅` on his radius-2 base** (M62 §R20: all 32 orbit subsets decided, 21 refuse and 11 do not, split exactly by kind, in **both** directions) | that no *other* shape works at that angle. A one-kind rotation might still force through some construction nobody has described. Record as `one-kind`, not as `dead` |
| 4 | **the non-vacuity ask**: does the whole arena `L ∪ ρS` refuse four colours? | one SAT call; SAT (the cheap verdict) ~1 s, UNSAT 10–50 s at this scale (M62 §R20, §R22) | **that this arena is 4-colourable, so no selection of it is 5-chromatic.** A proof about the arena | nothing about the rotation on a *larger* base. Adding `L`-side material can only tighten, so a SAT at radius 2.44 does not close the rotation — it closes that arena. State the radius in the verdict, every time |
| 5 | the reduction loop | hours, and it needs a first accumulator (§6) | — | — |

**Why the cascade's own premise can be trusted, stated here because a reader who doubts the census will
doubt the filter first.** The condition every filter rests on — that a cross edge joins two points
collinear with the centre, equivalently that `ab` is a square in `K` — was **derived twice, from different
starting points, and implemented twice, over different objects**: from the cross-edge identity, enumerated
over the base's *lines* (§1.1, this plan), and from the radius spectrum with `k_is_square`, enumerated over
*radius pairs* (the advisor, §11.1). The two agree digit for digit on every quantity they share, including
the decomposition of `ρ₁₅`'s 126 committed cross edges.

**Two consequences worth stating plainly.**

1. **Filters 1–3 are proof-grade and cost microseconds.** A rotation eliminated there is eliminated by a
   theorem, not by a search, and it stays eliminated on every base and at every radius. This is what makes
   a census affordable: on Parts's own lattice at radius 2.44 the cascade takes **26 candidate angles down
   to 6** before a solver is started (§3).
2. **Filter 4 is run on *everything that reaches it*, including the rotations filter 2 has already
   condemned, because that is the wall theory's negative control.** Every wall-standing rotation must come
   back SAT. If one comes back UNSAT, either the tooling is wrong or G35's gate is false — and both are
   worth a day of anyone's time. This is the check's positive signal for the thing that did not happen:
   it asserts a count (`20 of 20 SAT`), rather than waiting for an event.

---

## §3 — The ranking, applied

*Computed 2026-09-11 in exact arithmetic, single core, 8.5 seconds total, while four heavy jobs held the
machine. **The scratch script that produced these numbers no longer exists** (the scratchpad was cleared),
which is deliberate in one respect: **every number below is a registered expectation, and the implementer's
committed tool must reproduce it before any of it is believed.** A disagreement is a finding about the
tool, not a correction to the table.*

### 3.1 — The instrument, and its control

The angle census of §1.1, plus the arithmetic ranking:

* **wall**: `tools/wall_break_test.py`'s `classify_radicand` on `r = 1 − cos²θ` — `breaks_alone` means
  `−r` is a square in **both** 2-adic completions of `K`, so `K(√r)` has `i` in every completion above 2
  and no conjugation-fixed prime above 2 survives.
* **11**: the two primes above 11 in `K` (`√3 ↦ ±5`, `√11 ↦ 0`, both with residue field `𝔽₁₁`, both
  usable). At each, `K(√r)` is **inert** (residue field `𝔽₁₂₁`, `121 ≡ 1 mod 4`, 11 stops being usable),
  **split** or **ramified** (`𝔽₁₁` survives, the field stays 5-sealed). 6-open needs **inert at both**
  (G43); no other prime can seal a field over `K`, because every other prime of `K` already has a residue
  field that is not `𝔽_q` with `q ≡ 3 (mod 4)`.

**The control, which must be in the committed tool and must fail loudly:** the census's own count of
collinear pairs at `cos = 7/8` must reconstruct the committed cross-edge law's edge count exactly,

```
committed  len(CrossLaw.rho15().edges(pts))  ==  2·(off-diagonal) + (diagonal) + 2·(points of norm 1).
```

**Observed: PASS on `parts_lattice(2.44)` (126 = 126, from 18 off-diagonal + 30 diagonal + 60 centre) and
on the Moser lattice at 2.05 (66 = 66).** An earlier version of the census flipped the sign of `p` by hand
to catch "`u` with `−v`"; on a centrally symmetric base that pair is already in the enumeration, so the
count doubled and **this control caught it**. Put the sign flip back and it must go red.

### 3.2 — The census, three bases

| base | points | lines | distinct `cos ∈ K` | ≥ 2 kinds | rejected by Theorem B | **candidate angles** | **wall-breaking** | 6-open |
|---|---|---|---|---|---|---|---|---|
| `parts_lattice(2.00)` (his own, §5.6) | 1,603 | 528 | 440 | 26 | 12 | **14** | **6** | **0** |
| `parts_lattice(2.44)` (contains Heule-510 exactly) | 3,433 | 1,218 | 804 | 44 | 18 | **26** | **6** | **0** |
| Moser lattice ball, r = 2.05 (the 412-list's own base) | 873 | 304 | 308 | 26 | 6 | **20** | **2** | **0** |

`ρ₁₅` is **rank 1 of 14** by kinds at radius 2.00 and **rank 3 of 26** at radius 2.44 — the instrument
re-derives the record's own rotation from the lattice, with no knowledge of the paper.

### 3.3 — The ranked list, on his own lattice at radius 2.44

*Ranked by the cascade: wall-breaking first (filter 2), then kinds, then cross material. **Never by
cross-edge count** — M62 §M2.1 measured that maximal coupling means the rotation nearly preserves the
lattice, means it lies in `K(i)`, means Theorem B kills it; the top-voted rotations are exactly the
useless ones.*

| rank | `cos θ` | ≈ | kinds | off-diag | diag | wall | 11 | radicand `1 − cos²θ` | arena radius `1/|sin θ|` | verdict |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | `7/8` | +0.8750 | 2 | 18 | 30 | **breaks** | split | `15/64` (class of **15**) | 2.066 | **`ρ₁₅` — the record's own. Positive control, not a candidate** |
| 2 | `−7/8` | −0.8750 | 2 | 33 | 0 | **breaks** | split | `15/64` | 2.066 | **LIVE** — same field, different adjacency (33 off-diagonal pairs, no diagonal), and **no published construction uses it** |
| 3 | `11/32 + 3/32√33` | +0.8823 | 2 | 18 | 0 | **breaks** | split | `303/512 − 33/512·√33` | 2.125 | **LIVE — the new rotation.** Its radicand is irrational and lies in **no** rational square class (checked against 2,3,5,7,11,13,15,21,23,33,35,70,79,97,127,247): a field no published construction uses |
| 4 | `−11/32 − 3/32√33` | −0.8823 | 2 | 18 | 0 | **breaks** | split | `303/512 − 33/512·√33` | 2.125 | **LIVE** |
| 5 | `11/32 − 3/32√33` | −0.1948 | 2 | 18 | 0 | **breaks** | split | `303/512 + 33/512·√33` | **1.020** | **LIVE**, and the cheapest arena in the table — the Galois conjugate radicand, a *different* field from rank 3 (their product is not a square in `K`) |
| 6 | `−11/32 + 3/32√33` | +0.1948 | 2 | 18 | 0 | **breaks** | split | `303/512 + 33/512·√33` | 1.020 | **LIVE** |
| 7 | `±(23/32 − 9/32√33)` | ∓0.8969 | **3** | 18 | 0 | stands | ramified | `−1089/512 + 207/512·√33` | 2.26 | **DEAD by filter 2 — and it is the table's rebuttal of ranking by kinds**: it is the only 3-kind angle on this base, it would top any kinds-ordered or coupling-ordered list, and its field is 4-colourable |
| 8–26 | nineteen further angles | — | 2 | 12–27 | 0–18 | stands | mixed | — | — | **DEAD by filter 2**, and each is a registered SAT prediction (§5) |

**The calibration that makes this table believable.** The instrument was pointed at the one known positive
before anything else was read off it, and it reproduces three independently-known facts about the record:

* `ρ₁₅`'s radicand is the square class of **15** — so the record's coordinate field is `K(√15) =
  ℚ(√3,√5,√11)`, de Grey's and Heule's and Parts's field, recovered from the lattice;
* that field **breaks the 2-adic wall** — which it must, since the record is 5-chromatic (G1, G35);
* and **11 splits** in it, so the field is **5-sealed** — which is exactly why the record is 5-chromatic
  and not 6 (G43, G48), and why FS-6 needs a spindle out of it.

### 3.4 — Three findings from the table, stated as findings

1. **On his own lattice, the wall cuts 26 candidate angles to 6, and the 6 are two fields.** Everything
   else is 4-colourable by arithmetic, before a solver runs. **The phase's real candidate list is one new
   rotation class (with its Galois conjugate and its sign variants) plus the record's own, not 412.**
2. **Nothing on either base is 6-open.** Every wall-breaking candidate is 11-split, hence 5-sealed. So
   **FS-6's design target is not reachable through a type-M rotation with `cos ∈ K` on this lattice** — the
   spindle out of a 5-sealed field has to come from somewhere else. That is a negative worth carrying to
   FS-6's stub, and it is the first time the 6-openness criterion has been applied to anything.
3. **Radius does not buy rotations.** Going from 1,603 to 3,433 points adds twelve candidate angles and
   **zero** wall-breaking ones. Registered as P-G4 below rather than asserted: the census at radius 3.0
   must be run before this is believed as a law.

---

## §4 — New bases

*The other half of the phase, and the half nobody has planned. The census of §1.1 changes what a base is
worth, because it scores one in **seconds** and the score is arithmetic rather than a search outcome.*

### 4.1 — What makes a base plausible, derived rather than asserted

Because every cross edge at `cos θ ∈ K` joins two points **collinear with the centre** (§1.1), a base's
entire seam structure lives on **rays through the centre**, at radii tied to the angle by
`1 = t² + s² − 2ts·cos θ`. Everything else in the base is `L`-side material, which by Theorem B can never
be the obstruction. So:

> **A base is good for a rotation exactly when it is rich on rays: many points on the same line through
> the centre, at radii that solve the ellipse for that angle.** A base that is rich in *points* but poor in
> *collinear pairs* carries no seam, however large it is.

That is a design criterion, it is checkable in seconds, and it explains the two measured facts we already
had: why the Moser ball (873 points, 304 lines) supports only 2 wall-breaking angles where Parts's lattice
(1,603 points, 528 lines) supports 6, and why enlarging the radius past `1/|sin θ|` adds no cross edges.

### 4.2 — The candidates, ranked, each with its cheapest discriminating test

*The discriminating test is the same for all of them and costs seconds: **run the angle census; count the
wall-breaking candidate angles.** A base with zero is dead for type M with `cos ∈ K`, by theorem, with no
solver. A base whose census does not contain `cos = 7/8` with ≥ 2 kinds cannot host the known
construction, which is a validity check on the base before it is a search over it.*

| rank | base | what it is | why plausible | cost | status of §6's seven items |
|---|---|---|---|---|---|
| 1 | **`parts_lattice(r)`, r = 2.6, 3.0, 3.5** | his §5.6 denominator-12 lattice, radius swept | the only base whose orbit labels, group and pin triangle are already wired into every M63 tool; the radius is already a constructor argument | seconds per census; the arena ask grows with `r²` | **all seven supplied today** |
| 2 | **`⊕ⁿHᵐ` Minkowski variants** — `(n,m)` = (3,2), (5,2), (4,3), (3,3) | his own §2 construction: `H = W₇` the hexagonal wheel, `η` the Moser twist, `Hᵐ = ⋃ η^a H`, `B = ⊕ⁿ Hᵐ`; his working choice is `⊕⁴H²` | it is **his** stated base family, and the one place his own negative (*"expanding the base graph … did not lead to new results in our case"*, §5.6) was about his **filter** rather than his lattice (M63 phase D §X.3) | `T.parts_base` exists; §R14 measured `⊕⁴H²` at 13,063 points / 82,782 edges / 209 s for one ask, so **census first, ask later** | 1 ✓, 2 ✗ (**his orbit labels are denominator-12; a Minkowski base needs its own**), 3 ✓ (same group), 5 ✓, 6 ✓ by §1.3, 7 ✓ |
| 3 | **`build_c13_base`** — Heule's `G2167 = ⊕⁸C_{1/3}` | the record's actual ancestry: Heule's base, from which 553 and 529 and then 509 descend | already implemented; it is the lineage the radius-2 truncation was measured to exclude | seconds to build, seconds to census | as row 2 |
| 4 | **A base designed for a chosen angle** (the inverse construction) | pick a wall-breaking angle from §3.3; build the ray-richest lattice containing its ellipse's radii | §4.1 says this is the only thing that matters for the seam, and **§PA2's 2018 ring-growing recipe is exactly this procedure**, used greedily and never systematically | a day of design per angle | 2, 3, 5 must be **built**: a new lattice has no orbit labels, no group, no pin triangle |
| 5 | **Type T** (`[Parts2020a]` §4, Hubai): `G = ⊕³V₃₇`, `V₃₇ = H¹ ∪ ρH¹` | base graphs merged into **one lattice**, sharing many vertices, rather than two copies sharing a centre | a genuinely different topology; Parts reports it *"allows the simplest base subgraphs"* but yields ~5,000-vertex objects | unbuilt | **item 7 fails by construction**: there is no second half to freeze, so the cheapest reduction regime (frozen companion, worth ~13× per ask) is unavailable |
| 6 | **Haugland's heptagonal fabric** (`[Haugland2026]`) | 21 vertices: a heptagon, two heptagrams, seven triangles; a **cubic** field | it is the one published 5-chromatic object outside the hexagonal/`K` world, and G3's scope correction | **high**: every instrument in §2–§3 is `K`-specific — the wall test, the 11-inertness, `typem`'s whole tower | nothing transfers; FS-8 already stubs the 7-adic question |

### 4.3 — The base-side gap that is not in phase F's list, and it is load-bearing

**A new radicand needs a field the committed tower does not have.** Exact geometry in this project runs on
`ℚ(√3,√5,√7,√11)`. The rank-3 candidate rotation's radicand is `(303 − 33√33)/512` — **not** a rational
square class, so `K(√r)` is not inside that tower, and **the exact verification of its cross edges cannot
be performed by the committed arithmetic at all.** Phase F §2.6 item 1 says "a base needing a fifth
radicand needs the tower extended"; this is the same gap arriving from the **rotation** side, where it is
worse, because the radicand is not a rational number and a fifth quadratic generator will not fix it.

**The fix, and it is small:** one generic quadratic-extension layer over `K` — elements `x + y√r` with
`x, y ∈ K` and `r ∈ K` a parameter — which is 40 lines of the arithmetic `typem` already has, plus a
squareness test that already exists (`k_is_square`). Half a day. **Nothing in §2's cascade needs it**
(filters 1–3 are computations in `K` alone, and filter 4's *graph* is built by the law rather than by
distance arithmetic), but the moment a candidate survives to a certificate, it is on the critical path,
and a certificate is what makes a record a record.

---

## §5 — Registered predictions and costs

*Registered before the run, scored afterwards as met / not met / not decided (never "partly"). Costs are
for the desktop (32 cores, 128 GB) and are **single-core unless stated**; the census never uses more than
one core, so it can run beside anything. **None of these costs assumes the hitting-set solve is fixed** —
the census contains no hitting-set solve and no level enumeration. Only P-G7 touches the reduction loop,
and its cost is stated conditionally.*

| # | prediction | why | cost | scored by |
|---|---|---|---|---|
| **P-G1** | The committed census reproduces §3.2 exactly: 14 / 6 at r = 2.00, **26 / 6** at r = 2.44, 20 / 2 on the Moser base, and the `ρ₁₅` control passes on all three | it is the same derivation; a disagreement means the scratch run or the tool is wrong | seconds | the artifact, against §3.2 |
| **P-G2** | **Every wall-standing candidate angle's arena is 4-colourable: 20 of 20 SAT at r = 2.44.** This is the wall theory's negative control, not a formality | filter 2's theorem, modulo G35's gate | 20 asks; SAT is the cheap verdict (~1 s each measured at this scale), budget 20 min | the ask log, three-way (`SAT` / `UNSAT` / `undecided at cap`, never two-way) |
| **P-G3** | **`ρ₁₅`'s own arena at r = 2.44 refuses four colours (UNSAT).** The positive control, and it is already known: that arena contains Heule-510 exactly | M62 §R22 measured UNSAT in 10.5 s on the 510-vertex selection | one ask, ~10–60 s | the log |
| **P-G4** | Going to radius 3.0 on his lattice adds candidate angles but **no** new wall-breaking ones (the count stays at 6) | radius adds radii, and the wall is a condition on the square class; measured stable 2.00 → 2.44. **Genuinely uncertain — 0.5** | seconds for the census | the artifact |
| **P-G5** | The new rotation class (rank 3–6) **does not** refuse four colours on the first arena tried, at 0.65 | it carries 18 off-diagonal pairs and **no** diagonal or centre edges, against `ρ₁₅`'s 18 + 30 + 60. Cross material is not the ranking criterion, but zero diagonal edges means the two halves touch only along one family | **1 ask**, not 4 — the four rows are one rotation up to base symmetry (§11.6) | the log. **A refusal here is the phase's headline result** |
| **P-G6** | The general (`cos ∉ K`) census on `parts_lattice(2.00)` returns **fewer than 60 angles with ≥ 2 kinds**, against the 412 radicand classes the old list reports | §1.2: a class holds several angles and most angles hold one kind | `O(n²)` exact pairs: ~2–5 min at 1,603 points, priced on a 500-point prefix first | the artifact |
| **P-G7** | If a rotation survives filter 4, manufacturing its **first accumulator** costs at least as much as the largest ladder rung that closed on his base (phase F's P-F14), and **this is the phase's dominant cost, not the census** | a new base or rotation has no published accumulator; the only way to get one is a closed reduction of a large arena | **unpriced until phase F's ladder lands**; do not start it on a guess | phase F's F1 curve |
| **P-G8** | Every base in §4.2 rows 1–3 has `cos = 7/8` with ≥ 2 kinds in its census | if it does not, the base cannot host the known construction and the base builder is wrong | seconds per base | the artifact |

**The cost of the whole phase, honestly.** Filters 0–3 over every angle on every base in §4.2 rows 1–3:
**minutes, single core.** Filter 4 over everything that reaches it: **26 asks on his lattice, ~30 minutes**;
similar per new base. **The census is not the expensive part and never was.** The expense is P-G7 — the
first accumulator for any rotation that survives — and it is unpriced. Phase G's original estimate of
*"the laws and the census 2–3 days; one to two weeks"* is right in total and wrong in distribution: the
census is an afternoon, and the two weeks are one surviving rotation's bootstrap.

---

## §6 — What the loop must be handed before it can accept a new base or a new rotation

*Phase F §2.6 (`plans/M63-phaseF-beat-509.md`, committed at `66214e1`) makes this a deliverable and lists
seven items a base must supply and two a rotation must. **I am its first consumer. It is close to
sufficient, and here is what it is missing** — offered as additions, not corrections.*

### 6.1 — The four additions

| # | addition | why §2.6's list does not cover it |
|---|---|---|
| **A1** | **The rotation's datum is `cos θ` as an exact `K` element with a canonical key** — and for `cos θ ∉ K`, the four-tuple `(c₁, c₂, s₁, s₂)` normalised against a canonical square-class representative of `D` (§1.4) | item 4 names `CrossLaw` as the interface but not the **key**. Without canonicalisation one angle silently splits into several and the census double-counts — the same class of error the sign-flip bug in §3.1 produced |
| **A2** | **An exact-arithmetic layer for one new radicand over `K`** (§4.3) | item 1 anticipates "a fifth radicand" in the **tower**; a rotation's radicand is generally **not rational**, so no fixed tower covers it. Without this, a surviving rotation's object cannot be certified — and an uncertified object is not a record |
| **A3** | **A brute-force prefix recount as the replacement for `contains-a-known-minimum`** (§6.2) | item's two replacements check the *object's difficulty*; neither checks the *law*, and the law is the thing that is new on new ground |
| **A5** | **The anchor and the incumbent are one artifact, and its absence must be declared** — three-valued (present / declared absent with its reason, printed every run / missing-and-fatal), with `entry["M"]` rendering as a **bound** whenever the anchor is absent, since its upper half comes from the anchor alone | neither is in §2.6's list, and the silent path is live today (`check_invariants` writes the anchor block only `if anchor is not None`, while two callers already pass `None` and the verdict still reads `restriction-identity-holds`). It also fixes the run order: **census → screen → bootstrap → map**, because the map's target is `incumbent − 1` and a new base has no incumbent |
| **A4** | **The arena radius, as the formula `1/|sin θ|`, and the statement that beyond it the cross structure is provably complete** (§1.3) | item 6 says the bound is "per-law, and meaningless until the law exists". It is one line for the whole `cos ∈ K` class — and, importantly, **there is no such bound for `cos ∉ K`**, which item 6 should say |

### 6.2 — The fail-open control, answered directly

The coordinator's warning is the right one: `contains-a-known-minimum` — the guard that refuses to run a
stage unless a known refusing object is literally a selection of it — **has nothing to check on a new base,
and will pass while checking nothing.** Phase F §2.6 offers two replacements: a non-vacuity ask and an
end-of-run criticality check. **They are necessary and they are not sufficient, and the gap is specific:**

> **Both replacements check whether the object is hard. Neither checks whether the object is the object you
> think it is.** And on new ground the dangerous error runs in the *helpful* direction: **a cross-edge law
> that invents edges makes the arena denser, makes UNSAT easier and cheaper, and looks exactly like
> success.** The non-vacuity ask cannot see it. The criticality check cannot see it. A 5-chromatic object
> built on phantom edges passes both and dies at the certificate, after the expensive part.

**A3, stated so it can be implemented:** on every new base and every new rotation, recompute the cross
edges of a **radius-ordered prefix** (300–500 points) by brute force over all pairs — every pair's distance
tested exactly, with no reference to the law — and require the two edge sets to be **identical**, reporting
the two counts. It is `O(n²)` exact tests on a prefix, seconds, and it has the property every check in this
project is now required to have: **it asserts a positive number for the thing that did not happen**, rather
than reacting to an event. Its negative control is free: perturb one base point off the lattice and it must
go red.

Note this needs A2 (exact arithmetic in `K(√r)`) whenever the rotation's radicand leaves the tower. **That
is the strongest argument for building A2 early**: without it the law's own soundness check cannot run on
exactly the inputs that are new.

### 6.3 — The bootstrap, priced rather than assumed

Confirmed and carried: **a new base or rotation has no accumulator.** Parts's `A412`, `A166` and `A451`
*are* the union of all minima at their size, handed to us in his paper; a new input has nothing, and the
only way to manufacture one is a closed reduction of a large arena — a big-Δ run, which is what phase F's
ladder prices. Two consequences this plan commits to:

1. **The census does not depend on it.** Filters 0–4 need no accumulator, no level set and no loop. A
   census over hundreds of rotations is affordable *because* it stops at a single refusal question.
2. **The cost of *adopting* a rotation is the bootstrap, not the census** (P-G7), and it is unpriced until
   the ladder lands. **This plan does not extrapolate the flat-cost measurement** (214 / 246 / 221 CPU
   seconds at 3 / 12 / 24 added points): that flatness is measured only to 24 added vertices on an
   instance with a bound already climbed, and manufacturing a first accumulator is the opposite regime.
   Any schedule that assumes otherwise is assuming the thing nobody has measured.

---

## §7 — Decisions

*House format: the choice, an alternative actually weighed, why this one beat that alternative, and
confidence with the one fact that would change it.*

### 7.1 — Decisions I settled (skip this section unless auditing)

| # | choice | alternative weighed | why this one | confidence |
|---|---|---|---|---|
| D1 | **Enumerate rotations by `cos θ` over the base's lines** | re-sieve radicands by radius pairs, as phase G's acceptance says | the sieve keys on square classes, and one class provably holds several angles (§1.2, demonstrated on the record's own class); the census keys on the angle, needs no squareness tests, costs 8.5 s for three bases against 45.6 s for one sieve, and its output is exactly what `CrossLaw` consumes | **high** — it reproduces the committed law's edge count exactly on two bases (126 = 126, 66 = 66) |
| D2 | **The 2-adic wall is an eliminator, not a preference** | use it to sort a candidate list, as FS-30's stub reads | a rotation whose field keeps the wall has a 4-colourable plane; sorting it lower still spends a solver call on it. As a filter it removes 20 of 26 candidates for microseconds | **high** for the mechanism (kernel, Theorem B at `K`); **medium** for the general field statement, which rests on G35's stated gate — closing that gate promotes this from "predicted SAT" to "proved 4-colourable" |
| D3 | **6-openness is a strategic tag, not a filter** | apply all three of FS-30's criteria as co-equal rankers | 6-openness is what FS-6 needs for a **χ ≥ 6** gadget; this phase's product is a smaller **5-chromatic** graph, and filtering on it would discard the record's own rotation (`K(√15)` is 5-sealed). Applied as a tag it produced a real finding anyway (§3.4 #2) | **high** |
| D4 | **Derive the `cos ∉ K` law now (§1.4, done) and implement it only if the six `cos ∈ K` candidates all screen SAT** | (a) implement it unconditionally this phase; (b) defer the derivation too, as M63 §S.5 decided | **Revised 2026-09-11 after the advisor's correction (§11).** The derivation is written and costs nothing more. Implementing it is a different purchase, and his point stands: every construction anyone has built lives in the `cos ∈ K` family, and nothing yet shows a `q ≠ 0` rotation carries two kinds at one angle. **But the family is not empty** (§11.3), and the question is a census costing minutes (P-G6), not a derivation — so the trigger is P-G6's count, not a hunch | **medium-high** — if P-G6 returns any `cos ∉ K` angle with ≥ 2 kinds *and* a wall-breaking radicand, this becomes the phase's main line |
| D5 | **Run filter 4 on the rotations filter 2 already condemned** | skip them, since they are proved dead | 20 cheap SAT calls buy the wall theory's only end-to-end negative control on new ground. A check that only ever confirms what it already believes is not a check | **high** |
| D6 | **Standard arena radius = max(1/\|sin θ\|, 2.44)** | use `1/\|sin θ\|` exactly, as the acceptance says | the bound guarantees the **seam** is complete, not that the halves are big enough to force; 2.44 is the radius at which this lattice provably contains a known 5-chromatic object, so it keeps every rotation comparable with a known positive | **medium** — if ask cost at 2.44 proves prohibitive for some angle, drop to the bound and say so in the verdict |
| D7 | **The census never enumerates a level set** | reduce each surviving rotation to its minimum and count minima, as the reduction stage does | measured, 2026-09-11: 188 s to the optimum against 79+ minutes and counting to enumerate the level on one instance. The census asks "does this refuse", which is one call | **high** |

### 7.2 — Decisions that are Kooshi's, with defaults

| rank | decision | options | recommendation | if you say nothing |
|---|---|---|---|---|
| **RULED 2026-09-11** | **Does a 5-chromatic object at a *new rotation* count as a result even if it is larger than 509?** | (a) only sub-509 counts; (b) any object at a rotation nobody has used is a finding, reported with its size | **(b), ruled by the product owner.** `[Parts2020a]` §4 says working constructions at other rotations are **not known**, not that small ones are not known; the publication bar includes *"a result that answers a question the literature has independently and repeatedly posed, whatever its size"*; §PA1 found that question asked in print twice and answered by nobody; and such an object is the warranty on the **method**, which is the product. **Binding on the report: state the finding in its own right and answer the record question separately — never blended**, so a reader after the record number does not have to disentangle it from a different claim | — |
| decide when convenient | **Build the one-radicand exact-arithmetic layer (A2) now or at the first surviving candidate?** | (a) now, half a day, before the census; (b) when something survives | **(a)** — it is the soundness check's own prerequisite (§6.2), so deferring it means the first new object is checked by the law that built it | **(b)** — the census runs without it and nothing is lost but ordering |
| decide when convenient | **Read `[PartsOdd2022]`'s construction section (half a day) before or after the census?** | (a) before; (b) after | **(b)** — it is the only other published type-M-shaped rotation (`arccos(31/32)`), so it bears on the write-up and on P-G5's prior, but it cannot change the census | **(b)** |
| know, do not decide | **Nothing on either base is 6-open** (§3.4 #2) | — | it belongs in FS-6's stub, whose design target this narrows | recorded here; FS-6's stub updated at the phase close |

---

## §8 — What I could not settle

*Listed rather than omitted. "Not done, because X" is a complete answer; a silent omission is not.*

1. **The `cos ∉ K` census is derived but not run.** §1.4 gives the law and §5 prices the census (P-G6);
   the cost is minutes, and I did not spend them because four heavy jobs hold the machine and a census
   whose key is not yet canonicalised (A1) would produce a number I would have to withdraw.
2. **262 of the 412 persisted classes are not on disk** and I did not regenerate them. The census replaces
   that list rather than completing it, so regenerating is only worth it as an audit of §1.2's claim.
3. **G35's field-level gate is open, and filter 2 rests on it.** For `K` itself the kernel proves the
   4-colouring outright (Theorem B); for `K(√r)` the statement is the gated one. The census's P-G2 turns
   every one of those eliminations into a *testable* prediction, which is the best available substitute —
   but a SAT verdict is a fact about an arena, not a proof about a field. FS-37 is the stub that closes it.
4. **I did not verify the census against a second implementation.** The control ties it to the committed
   `CrossLaw`, which is one instrument; a brute-force `O(n²)` recount on a prefix (A3) is the independent
   check and it is planned, not run.
5. **`[PartsOdd2022]`'s construction section is unread** (§PA4), so "no second rotation has been used in
   print" is stated as *we have found none*, not as *there is none*.
6. **Whether a smaller arena helps or hurts at the rank-5/6 angle** (`1/|sin θ| = 1.02`, a very small
   seam) is unknown; D6 chooses the larger arena for comparability and I have no measurement either way.
7. **The two Baake–Grimm papers are catalogued from search listings, not read** (§PA3). The verdict —
   that coincidence rotations are precisely the class Theorem B kills — follows from their abstract's
   statement of the classification plus our own theorem, and would survive a reading; the *"nothing
   transfers"* half is the part a reading could overturn.

---

## §9 — Proposed replacement for `plans/M63-parts-reproduction.md` §S.4, phase G

*That file has another writer, so this is text to paste, not an edit. Every change is a consequence of
§1–§3 above. The re-aim of 2026-09-11 also means its bullet 5 now names a route that was abandoned.*

```
**Phase G — other bases and the sieve's rotations.** Purpose: Kooshi's second direction (S.1). **Approved
2026-09-11 as its own milestone**, numbered at M63's close; subplan `plans/M63-phaseG-bases-and-rotations.md`.
Acceptance:
- [ ] The ANGLE census, on the §5.6 lattice's own lines: every rotation with cos θ ∈ K that carries a cross
      edge is cos = k/p over collinear pairs, enumerated exactly, persisted whole (not truncated), with the
      control that it reconstructs `CrossLaw.rho15().edges` count on two bases.
- [ ] The general law for cos θ ∉ K implemented — two K-linear conditions, c₁p − s₁q = k and c₂p − s₂q = 0
      — with the square-class canonicalisation of √D as its key, checked against ρ₁₅ and Heule-510.
- [ ] The cascade applied in cost order, each verdict recorded with what it proves: Theorem B (eliminates
      for ever), the 2-adic wall (eliminates modulo G35's gate), ≥ 2 radius kinds, then one refusal ask.
      **Ranked by the arithmetic, never by cross-edge count.** 6-openness is a strategic tag, not a filter.
- [ ] The arena sized by 1/|sin θ| (derived; 8/√15 at ρ₁₅), and the standard arena max(1/|sin θ|, 2.44).
- [ ] Every wall-standing rotation's arena asked anyway, as the wall theory's negative control: all must
      return SAT.
- [ ] For each passing rotation, the frozen-companion loop (phase D's), **not** the joint reduction, which
      was abandoned by ruling on 2026-09-11.
- [ ] Other bases: ⊕ⁿHᵐ variants, Heule's ⊕⁸C_{1/3}, and a radius sweep — each scored FIRST by its own
      angle census (seconds), and only then by an ask. Note that at ρ₁₅ a radius sweep past 2.0656 adds no
      cross edges at all (endpoint bound, measured 126 = 126), so it can only add L-side material.
- [ ] Any graph below the record of the day certified as in F — which requires the one-radicand exact
      arithmetic layer over K, since a rotation's radicand is generally not rational.

*Cost:* the census is an afternoon, not two weeks; the two weeks are one surviving rotation's first
accumulator (phase F's ladder prices it, and it is unpriced until that lands).
```

---

## §10 — The advisor's cards, answered

*Poros, advising phase G, 2026-09-11, seven cards; his record is `plans/POROS-2026-09-11-m63-phaseG.md`
(uncommitted). Answered here in his ranked order, with what changed in the plan. Two cards changed the
plan's shape, one settles a question he flagged as his least certain, and one I can answer with a number
that was already computed.*

### C4 (his first) — how many admissible classes have `cos θ ∈ K`? **Computed: a minority, and it sizes the phase**

Answered in §1.2 and §3.2, from the file and from the census:

* **Of the 150 persisted classes, 59 have at least one collinear family and 91 have none at all** —
  so 91 of them contain no `cos ∈ K` angle whatsoever. **Zero classes have all their families collinear.**
* The sharper statement is the census's, because it counts **angles** rather than classes: on that same
  Moser base the whole `cos ∈ K` family is **308 angles, 26 with ≥ 2 kinds, 20 surviving Theorem B, 2
  surviving the wall** — against "412 admissible classes".

So: *both* of his branches are live, and that is why §1.4 derives the general law and D4 schedules it in
this phase rather than deferring it. The `cos ∈ K` family is small enough on his lattice (**one** new
class, §3.4 #1) that a phase resting on it alone would be thin.

**And his stale-stub warning is correct and acted on**: `plans/STUB-consume-rotation-list.md` calls
generalising the cross-edge law "the first code task", but `typem.CrossLaw` with `Stage(cross_law=…)` and
controls c5.1/c5.3/c5.4 has shipped. A banner now says so. What is genuinely unbuilt is the `cos ∉ K` law,
and §1.4 derives it.

### C1 — the three cost tiers, and whether a bootstrap may be capped

**Adopted into the cost model.** §5's table now reads against his three purchases explicitly:

| tier | question | what it costs | who pays it in this phase |
|---|---|---|---|
| **screen** | is this rotation alive at all? | **one refusal ask**, no reduction, no level | **every rotation** — this is the census (§2, filter 4) |
| **rank** | how small does it go? | reduction to the optimum, ~10² s at this size | only a rotation that survives screening |
| **seed** | what is the accumulator? | the **complete level**, ~10⁴ s with no known ceiling (188 s to the optimum against 79+ minutes and climbing, on the same instance) | only a rotation being handed to the loop — P-G7, and it is the phase's dominant cost |

**On his load-bearing question — is the accumulator needed complete, or only for coverage — my reading
agrees with his, with the boundary drawn:**

> **Completeness is required for any claim *about* `{M}`, and not for the menu.** The refusal bound comes
> from the optimisation; the accumulator's role in the loop is to source the expansion menu, and an
> under-enumerated accumulator gives a smaller menu — a heuristic loss, not a soundness loss. But row 62's
> rung-minimum statement (the rung-`H` minimum equals `min |cl_H(M)|` over inclusion-minimal refusers) is
> a claim about the complete set and **is** destroyed by a cap, as is any statement of the form "`{M}` grew"
> (M63's acceptance clause 2c).

**So a budgeted bootstrap with a declared cap is legal for the menu role and illegal for everything else**,
and the rule that makes that safe is the one this project already uses: the cap is **declared in the
artifact, printed every run, and any number derived from a capped level renders as a bound**, never as a
value. `tools/parts_loop.py` §3.3's blanket *"no loop may start from a capped union"* is therefore
stricter than the mathematics requires **for menu generation alone** — and I would not relax it in code
without that three-valued rendering in place first, because the failure mode is a capped union being read
later as a level set by someone who was not there. **Falsifier, stated so this reading can die:** find one
consumer downstream of the menu that needs completeness. I checked row 62's use (needs it, and is not the
menu) and clause 2c (needs it, and is not the menu); I did **not** audit every consumer.

### C2 — the anchor and the incumbent are one missing artifact

**Correct, and it is a sequencing constraint rather than a control gap.** `parts_loop.py:583` computes
`entry["M"] = incumbent + 1` with the lower half from the refutation and **the upper half from the
anchor**; `--incumbent` is required and `--anchor` defaults to a fixed filename. On a new base neither
exists, and they are the same object — a known refusing selection, which is exactly what the bootstrap
manufactures. Three things follow, now in the plan:

1. **The map cannot run on a new base before the bootstrap** — not "should not": the target is
   `incumbent − 1`, so without an incumbent there is no question. **Run order for a new input is therefore
   fixed: census → screen → bootstrap → map/loop**, and any map run before the bootstrap is uncontrolled
   by construction.
2. **The silent path is live today**, not merely a future hazard: `check_invariants` writes the anchor
   block only `if anchor is not None`, and `tools/parts_diag.py` and `tools/parts_rule.py` already call
   `sweep_candidate(..., anchor_tuples=None)` while the verdict still reads `restriction-identity-holds`.
   That is this project's characteristic failure — a check reporting nothing when it cannot run.
3. **The fix matches the vacuity gate's shape**: present / **declared absent with its reason, printed every
   run** / missing-and-fatal; and with the anchor absent, `entry["M"]` must **render as a bound**, because
   its upper half is then unproven. Added as interface item **A5** (§6.1) and as a phase-G admission item.

### C3 — three controls that survive a new base

**Adopted, and they are better than the single check §6.2 proposed.** All three assert rather than react:

* **the monotone sandwich** — refusal is upward-closed, so a superset of a refusing selection must refuse
  and a subset of a colourable one must be colourable: two asks whose answers are known in advance with no
  known minimum in hand;
* **the transported answer** — apply a base automorphism to any decided selection and require the same
  verdict; needs no known value, only equality with itself, and it catches exactly the index/label
  mismatch that produced one of phase C's nine broken instruments;
* **the planted fault, per base** — promote the edge verification's five planted faults from a one-time
  test to a per-base admission gate.

Together with §6.2's brute-force prefix recount, these are the replacement for
`contains-a-known-minimum`, and the phase's admission checklist for a new base is now: **symmetry closure
(a gate that refuses, never warns — §11.6)** · prefix recount · monotone sandwich · transported answer ·
planted fault · non-vacuity ask. The first four all guard defects biased in the same direction — toward a
census that looks productive — which is the worst bias available to a survey whose entire output is
eliminations.

### C6 — the law's error runs in *both* directions, and I had only named one

**A real correction to §2 and §6.2.** I wrote that a law which **invents** edges makes UNSAT easier and so
hides itself. He adds the other half, which is the one that bites a census: **a law that *misses* edges
makes the arena easier to colour, produces SAT, and reads as a sound elimination** — indistinguishable
from a true negative, and failing silently in the direction that makes the census look productive. So the
per-law admission gate is not optional: **c5.1 (the general law reproduces the committed `ρ₁₅` edge set,
edge for edge) becomes a gate every law must pass, not a test one law passed once**, plus the brute-force
all-pairs check at a radius where `O(n²)` is affordable. Without one of those, "N classes eliminated"
measures the law (G21).

### C5 — the quantifiers on an elimination

Agreed, and already the §2 rule; sharpened into a sentence the artifact must print verbatim:

> **"No refusing selection on *this base* at *this radius* under *this law*"** — never "the rotation is
> dead". Elimination by filter 4 is relative to four parameters (base, radius, law, rotation), and the
> radius is the dangerous one, since a rotation may want a larger disk than the one it was screened at.
> Filters 1–3 are the exception and may be stated absolutely, because they are theorems about the field.

And his reason for the care is the right one: the negative is publishable (it answers `[Parts2020a]` §4),
which is exactly why its quantifiers have to survive a referee.

### C7 — the flatness datum, and the guess he offered

**Both halves accepted, and the second one I can settle exactly rather than in ten minutes.**

* **The flatness does not transfer**, and not because 24 points is near its edge: it was measured **across
  added points on one fixed stage**, while a rotation census varies *the graph itself* — different edge
  set, different SAT hardness. Wrong axis, not a short axis. Also his predecessor's re-read stands (p50
  185 s, p90 269 s, **max 418 s, ratio 2.26** over 266 entries), so the medians describe the middle and not
  the runs. §5 and §6.3 now say the census is priced on the **screen** tier, which does not use the
  reduction at all.
* **His guess about the base-sizing bound is right, and it is exactly `1/|sin θ|`** (§1.3, derived; it
  reproduces `8/√15` at `ρ₁₅` and M62 §R22's measured 126 = 126). So the required base **does** blow up as
  `cos θ → 1` — and those are precisely the maximally-coupled rotations that stay inside `K(i)`, where
  Theorem B four-colours everything. **The cost ranking and the arithmetic ranking therefore agree**: the
  census is cheap exactly where it is worth running, and per-rotation base sizing is a selection instrument
  rather than an overhead. One concrete instance from §3.3: the rank-5/6 angle needs radius **1.02**.

---

## §11 — The advisor's correction, and an independent agreement worth recording

*Poros, 2026-09-11, withdrawing his own card C4 and replacing it. He derived, from the code rather than
from this plan, the same necessary condition §1.1 derives from the cross-edge identity — and the two
instruments were then compared. **They agree exactly, from different code paths**, which is the strongest
evidence either of us has that the census is right.*

### 11.1 — The same condition, twice, by two routes

He argues: a radius pair `(a, b)` can carry a type-M cross edge only if **`ab` is a square in `K`**, since
`q = 0` forces `p² = ab` with `p ∈ K`. That is §1.1's collinearity condition stated on radii instead of on
points — *`v = λu` with `λ ∈ K`* and *`ab` a square in `K`* are the same requirement — and the sieve at
`tools/typem.py:181` never tests it, working from the radius spectrum alone.

**Where the two instruments overlap, they return the same numbers:**

| quantity | his route (radius pairs + `k_is_square`) | this plan's route (lines of the base) |
|---|---|---|
| the record's class: stored families → edge-capable | 7 → **3** | 7 → **3** |
| of those, how many are `cos = 7/8` | **2**, the third a different angle in the same field | **2**, the third near `0.8039` in the same field |
| `ρ₁₅`'s 126 ordered cross edges, decomposed | 60 centre (radius 1) + 36 conjugate pair `(17 ∓ √33)/6` + 30 at radius 4 | 60 centre + 2 × 18 off-diagonal + 30 diagonal |

**The decomposition matches digit for digit**, and both were checked against control c5.1's committed edge
count. Two independent derivations, two implementations, one answer.

His complementary counts over the stored file — **131 of 1,058 stored families are edge-capable (12.4%),
and 32 of 150 classes clear the "≥ 2 families" bar** — sit consistently beside §1.2's (59 of 150 classes
have ≥ 1 collinear family, 91 have none). **His estimate that "412 admissible classes" is nearer 90 once
families are counted correctly belongs in any write-up**, and supersedes the number FS-30 carries.

### 11.2 — What it retires: FS-30's second lead is dead

FS-30 and M62 §R1 both carry: *"The record's own rotation admits SEVEN radius families and Parts uses TWO
… Five unused cross-edge kinds sit at the rotation the record is already built on."* **There are zero
unused kinds at `ρ₁₅`.** The seven are seven radius pairs sharing a *field*; three can carry an edge; two
of those are `ρ₁₅`'s own, and Parts uses **both**. The "cheaper lead in the same file" that FS-30 offers as
*"days, not weeks"* does not exist.

**Scope of the kill, stated narrowly:** what dies is the *seven-families* framing and the five-unused-kinds
sentence. The **orbit-level** lead is untouched and still live — more orbit pairs to connect *within* the
two realized kinds, M62 §R20's `(0,0,2,6) + (24,0,0,0)` at 18 cross edges and the rest. Only the claim
that unused *kinds* exist is false.

### 11.3 — Where I do not follow him, and it changes only the schedule

He concludes that the `cos ∉ K` law *"is not reachable from the sieve's own derivation"* and would not be
implemented *"until something shows it is non-empty"*. **The first half is right about the sieve and the
second half is wrong about the family**, and the distinction matters enough to write down:

> **The `cos ∉ K` family is provably non-empty.** For *any* pair `u, v` with `conj(u)v = p + iq`, `q ≠ 0`,
> the rotation `ρ = (k + i√D)/w` carries that pair at unit distance; its cosine is
> `(kp + q√D)/ab ∉ K` precisely because `q ≠ 0`. Such pairs are the overwhelming majority on every base.
> What is **unknown** is whether any single such rotation carries **two kinds**, which is what makes a
> type-M construction possible.

So this is not a derivation question and not an emptiness question — it is a **census** question, priced at
minutes (P-G6), and the honest schedule is his in effect and mine in reason: **derive now (done, §1.4),
implement when P-G6 says the set is non-trivial.** D4 is revised accordingly.

### 11.4 — Two risks he found in the input, both adopted

1. **Neither rotation file is reproducible from committed code.** The keys `type_m_admissible`,
   `record_rotation` and `max_families` appear nowhere in the repository outside the JSON, and the
   committed `cmd_rotations` cannot reproduce even the sibling file (it would write
   `classes_leaving_K = 1336` where that file says 2042). **The phase's input is an orphan artifact.**
   Consequence, adopted: **treat both files as provenance, never as data, and tune no threshold against
   them.** The re-sieve is happening anyway (§9 item 1), and it should carry its own regeneration command.
2. **A float sign test sits inside a verdict**: `typem.py:185`, `if kfloat(D) < 0: no_rotation += w`, on an
   exact `K` element, while the artifact's own `claim_scope` states that floats appear *"only in the radius
   cut and in sort keys"* — so **the claim_scope is wrong**, and the error direction is silent and drops
   candidates. `radius_families` canonicalises with `kfloat` too.
   **And the same hazard is in my own census**, named here rather than left for someone else to find: it
   cuts `|cos| < 1` with `abs(kfloat(c)) >= 1.0`. The exact test is the sign of `1 − c²` in `K`, decidable
   exactly, and the committed tool must use it. A float may propose; it may never decide.

### 11.5 — The re-sieve gets a second job for free

Adopted into §9's item 1: the re-sieve on the §5.6 lattice should, in **one pass**, emit **both** units —

* **rotations**, grouped by the exact cosine `c = k/p`, with their true (edge-capable) kind counts: the
  unit for the geometric census and for `CrossLaw`;
* **radicand square classes**, with the wall and 11-inertness: the unit for the arithmetic ranking, because
  the wall and 6-openness depend only on the field and not on the angle.

**A class is a field, not a rotation** — his sentence, and it is the cleanest statement of §1.2's whole
finding. The original sieve cost 45.6 s; this costs the same and answers both questions.

### 11.6 — The six wall-breaking rows are **two** rotations, and the census's reporting unit must say so

*Caught while reading the advisor's §R2 snippet, whose rotation key is `cos²` rather than `cos`. His
reasoning is right and §3.3's table, which is correct as a list of **angles**, is missing the grouping.*

Rotation by `π − θ` is `−ρ̄`. This base is closed under **negation** (`ζ₆³ = −1`), under **complex
conjugation** (the Galois flip `√3, √11 ↦ −√3, −√11` *is* the geometric reflection, M62 §R19(1)) and under
**`√33 ↦ −√33`** (the remaining Galois element of the order-24 group). For any base symmetry `g`,
`g(ρ·v) = ρ^g·g(v)`, so `g` carries the arena of `ρ` onto the arena of `ρ^g`. Therefore:

> **The four sign-and-conjugate variants of a rotation give isomorphic arenas**, and §3.3's six
> wall-breaking rows are **two rotations up to base symmetry: `ρ₁₅`, and one new one.**

**The arithmetic confirms it in my own control's numbers**, which is why this is a grouping error and not a
contradiction: at `cos = +7/8` the census reads `2 × 18 + 30 + 60 = 126`, and at `cos = −7/8`
`2 × 33 + 0 + 60 = 126` — **the same total by a different decomposition**, exactly as an isomorphism that
moves which pairs are diagonal requires.

**Two consequences, both binding on the implementation:**

1. **The census's reporting unit is "rotation up to base symmetry", never "angle".** Reporting four
   negatives that are one negative would be a false count in the phase's headline sentence — the same
   class of error §1.2 catches in the stored file, arriving from the other direction.
2. **Screening cost falls accordingly**: P-G5 is **one** ask, not four, and the same collapse applies to
   every row of §3.3.

**Why the collapse is exact and not approximate.** `cos²` determines `|cos|` and `sin² = 1 − cos²`, so
its fibre is exactly `{c + is, c − is, −c + is, −c − is} = {±ρ, ±ρ̄}` — **precisely the orbit of the three
base symmetries and nothing coarser.** So on a base carrying all three, the key can neither split one
rotation into two (it is a function of the pair) nor merge two rotations from different orbits. That the
edge count survives a re-decomposition (`2×18 + 30` against `2×33 + 0`, both totalling 126) is the cheapest
possible confirmation that the two arenas are one object.

**The failure direction, and it is why this is a gate rather than a checklist line.** Where a base does
*not* carry all three symmetries, `cos²` **over-merges and never under-merges**: it can report two
genuinely distinct rotations as one, never one as two. The resulting defect is that **the census tests one
representative, records an elimination, and the untested sibling is eliminated without ever being built —
a silent false elimination**, pointing in the same direction as the dropped-edge bug of §11.4 and C6:
toward a census that looks productive. The key's failure mode, the law's failure mode and the dropped-edge
failure mode now all point that way, which is the argument for **one gate instead of three checklist
lines**:

> **Before a new base is trusted, assert its closure under negation, under complex conjugation, and under
> `√33 ↦ −√33` — applying each symmetry to the point set and requiring zero images outside — and REFUSE
> the run rather than warn.** §4.2 rows 1–3 are closed under all three; rows 4–6 are the gate's first
> customers and must be checked rather than assumed.
