# M63 phase H2 — the rotation family, screened exactly

*Screener's findings, 2026-09-12. Every number below is exact integer or `Fraction` arithmetic; no float
decides anything. Two results contradict the phase's standing documents and are flagged **CONTRADICTION**.
Written to be read by someone who has not read the phase.*

---

## §0 — What was asked and what came back

The product owner classified the rotations used to build these graphs by one integer:
`cos θ = (2n−1)/(2n)`, whose **diagonal circle** — the locus of points sitting exactly one unit from their
own rotated image — is `|p|² = n`. He asked for four quantities per live family member, measured on
`[Parts2020a]`'s lattice: the circle's point count, its attachment, its cheapest denominator, and the arena
size at the endpoint bound. **All four, for every member up to `n = 21`, reduce to a finite integer
enumeration**, so the screen cost minutes rather than cores.

**The headline.** The phase was hunting a *new lattice* to put ~30 points on a circle. Parts's own lattice
already does it, for two rotations whose field is 6-open, at zero design cost:

| rotation | field | circle points | cheapest denominator | arena at the bound |
|---|---|---|---|---|
| `n = 4` — `ρ₁₅`, the record | `K(√15)`, **5-sealed** | 30 | 1 | 1,771 |
| **`n = 16` — `ρ₆₃`** | **`K(√7)` = ℚ(√3,√7,√11), 6-open** | **30** | **1** | **25,567** |
| **`n = 20`** | **`K(√79)`, 6-open** | **60** | **1** | **39,829** |

`n = 2`, the member the product owner most wanted answered, **has no circle at all over this lattice** and
its arena is thin on two independent axes. It is reported dead in §3.

---

## §1 — The reproduction gate, passed before any new number

Mandated by the brief's §8.5. Parts's lattice was rebuilt **from scratch** — my own congruence test, my own
exact totally-real disk cut, my own norm — and then compared against `tools/typem.parts_lattice` as a second
implementation.

| check | expected | measured | verdict |
|---|---|---|---|
| `\|Λ_parts(2.44)\|` | 3,433 | **3,433** | PASS |
| points on `\|p\|² = 4` | 30 | **30** | PASS |
| set-equality with `tools/typem.parts_lattice(2.44)` | identical | **identical** | PASS |
| `\|Λ_parts(2.0656)\|`, `\|Λ_parts(1.5119)\|`, `\|Λ_parts(4.0316)\|` | — | **1,771 / 499 / 25,567** | matches the advisor's independent rebuild exactly |

The last row is a genuine second pair of eyes: the advisor built those three numbers from its own code
before seeing mine, and all three agree.

---

## §2 — The enumerator, and why its zeros are real

**The reduction that made the screen cheap.** `tools/typem.parts_lattice` places
`x = (a + b√33)/12` and `y = (c√3 + d√11)/12` with `a ≡ b ≡ c ≡ d (mod 2)` and `a − b + c + d ≡ 0 (mod 4)`.
Expanding,

```
|p|² = (S + 2P·√33)/144 ,    S = a² + 33b² + 3c² + 11d² ,    P = ab + cd     (both in ℤ)
```

so, because `√33` is irrational and the rational and `√33` parts must match separately,

> **`|p|² = n` for a rational integer `n` ⟺ `P = 0` and `S = 144n`.**

**The enumerator's image, written down before any zero was believed** (the discipline the brief demands).
The image is the *complete* module shell, for three reasons, each checkable: (i) every `Λ_parts` point has
integer `(a,b,c,d)` with those congruences — that is the lattice's definition, not a restriction I imposed;
(ii) the equivalence above is an identity, not a sufficient condition; (iii) the search box follows from
`S = 144n` with all four terms non-negative, using exact `isqrt`. **No sub-family restriction anywhere** —
which is the failure that nearly ended this phase, and the reason this paragraph exists.

**And `P = 0` forces both conjugates of `|p|²` to equal `n`, so the shell lies inside radius `√n`
automatically.** There is no radius cut to argue about: the count is the *full* module's, not a truncation.

**Which half produced each number.** All shell counts, arena sizes and unit-edge counts are the **measured**
half — a complete exact enumeration whose only possible error is a *missed* point. The **derived** half is
the cross-edge law at a new rotation, handled separately in §5, where an *invented* edge is the error mode
and a refusal is the suspect verdict.

**Controls, both directions.** The planted point `4v` for `v` a unit vector is found in `shell(16)` (must be
True: True). A perturbed copy is rejected, and independently fails `typem.norm2` (must be False/False:
False/False). Every shell point of `n ∈ {1,4,9,16,20,44,60,64}` had its norm re-derived with
`tools/typem`'s exact `K` arithmetic: **all verified.** The `n = 2` zero was additionally reached **by hand**
over `|b| ≤ 2, |d| ≤ 5, |c| ≤ 9` before the machine was asked.

---

## §3 — The screen, `n = 1 … 21`

Four gates, each a theorem this repository owns. `sin θ = √(4n−1)/(2n)`, so **`sin θ ∈ K` iff the squarefree
part of `4n−1` is in {1, 3, 11, 33}** — and then the whole arena lies in `K²`, where `χ(K²) = 4`
(`chromaticNumber_seamPlane`, ledger row 57) four-colours **every possible base**. The wall breaks iff that
squarefree part is `≡ 5, 7 (mod 8)`, which for `4n−1` means **`n` even**. 6-open = wall broken **and** 11
inert (G43).

```
  n  4n-1 sqfr  sinK  wall        11  6open | shell  den  deg@bound |   bound   arena
  1     3    3  DEAD                        |    30    1            |  1.1547
  2     7    7        True     inert   TRUE  |     0    -          0 |  1.5119     499
  3    11   11  DEAD                        |    42    1            |  1.8091
  4    15   15        True     split         |    30    1          7 |  2.0656    1771   <- the record
  5    19   19       False     inert         |    60    2          7 |  2.2942    2773
  6    23   23        True     split         |     0    -            |  2.5022
  7    27    3  DEAD                        |    60    1            |  2.6943
  8    31   31        True     split         |     0    -            |  2.8737
  9    35   35       False     inert         |    54    1          7 |  3.0426    8299
 10    39   39        True     inert   TRUE  |     0    -          0 |  3.2026   10183
 11    43   43       False     inert         |    30    1          8 |  3.3550   12307
 12    47   47        True     split         |    42    1          8 |  3.5008   14569
 13    51   51       False     inert         |    60    1          8 |  3.6407   17101
 14    55   55        True  RAMIFIED         |     0    -            |  3.7755
 15    59   59       False     split         |    84    1          7 |  3.9057   22609
 16    63    7        True     inert   TRUE  |    30    1          7 |  4.0316   25567   <- rho63
 17    67   67       False     split         |     0    -            |  4.1538
 18    71   71        True     split         |     0    -            |  4.2724
 19    75    3  DEAD                        |    60    1            |  4.3879
 20    79   79        True     inert   TRUE  |    60    1          7 |  4.5004   39829
 21    83   83       False     inert         |    84    1          8 |  4.6101   43921
```

**Four members die for free** — `n = 1, 3, 7, 19` — because `sin θ ∈ K`. `n = 19` (`4n−1 = 75 = 25·3`) was
on nobody's list and was reached here independently; the product owner reached the same four from the
advisor's card, so the list has two routes.

**`deg@bound` is 7 or 8 for every member, including the record.** The diagonal circle sits at radius `√n`
while the endpoint bound is `2n/√(4n−1) = √n · √(4n/(4n−1))`, a ratio that tends to 1 — so **the circle is
always pressed against the arena's outer edge**, and a circle point keeps only 7–8 of its 30 unit
neighbours inside the bound. Scale-invariant, and it explains the advisor's correction from 13 to 30: the
full degree needs a radius-5 cut, not a radius-4 one.

---

## §4 — `n = 2`: dead, with the reason stated

Registered prediction, before running: **the `|p|² = 2` shell over `Λ_parts` is empty.** **Met.**
Both outcomes were reachable — the enumerator's image is the complete shell (§2), so a nonzero count was
available had one existed. The advisor measured the same zero independently.

| | `n = 2` | the record `n = 4` | ratio |
|---|---|---|---|
| arena at the endpoint bound | **499** | 1,771 | 0.28× |
| unit edges in it | **2,634** | 12,810 | 0.21× |
| mean unit degree | **10.56** | 14.47 | 0.73× |
| diagonal cross edges | **0** | 30 | — |

**Thin on two independent axes, and thinness cannot be bought with radius** — material past the endpoint
bound carries no cross edge and is absorbed (G40). Against a 509-vertex record that was *reduced* from a
3,433-point base, a ~1,000-vertex arena with 21% of its edges is not a contender.

**What `n = 2` is NOT.** Its circle is not empty *in the field*: `2 = 1² + 1²` puts `(1,1)` on it at
denominator 1, and the advisor measured **180** points of `|p|² = 2` with a unit neighbour already in
`Λ_parts(2.44)`, four of them at denominator 1. So `n = 2` is 6-open with a cheap circle and would need a
**different, finer module** rather than a bigger one. That is the covolume trade, and it is not this
phase's question. **Recorded, not pursued.**

---

## §5 — CONTRADICTION 1: the free-circle gate is sufficient, not necessary, and `n = 20` is a second live member

The phase's gate A says the circle is free exactly when `n = t²`, because then `t·S ⊆ {|p|² = n}` for `S`
the module's norm-1 shell. **Confirmed, and sharper than stated:** `shell(4)` is *exactly* `2·S₁` and
`shell(16)` is *exactly* `4·S₁` — 30 points each, no extras and no omissions, verified against
`typem.norm2`. So the record's cross-edge count equals its unit-shell count `|S₁| = 30` **by identity**.

**But `n = t²` is only sufficient.** `n = 20` is not a perfect square, and its circle over Parts's lattice
carries **60 points at denominator 1** — twice the record's — because `20 = 4·5` and the norm-5 shell has 60
points, so `2·(norm-5 shell)` lies on `|p|² = 20`, in the module, at full unit degree. Likewise
`shell(44) = 2·shell(11)`, `shell(60) = 2·shell(15)`.

**The correct gate is "`n` is in the value set of the module's norm form",** enumerated exhaustively to
`n = 120`. 6-open members with a non-empty circle over `Λ_parts`, with circle counts:

| `n` | 16 | 20 | 44 | 60 | 64 | 76 | 108 | 112 |
|---|---|---|---|---|---|---|---|---|
| circle points | 30 | **60** | 30 | **84** | 30 | 60 | 66 | 60 |
| radius | 4.00 | 4.47 | 6.63 | 7.75 | 8.00 | 8.72 | 10.39 | 10.58 |

**The ordering survives: `n = 16` is still the cheapest.** The queue has eight members, not two.

**Two measured laws, offered as measured and not proved.** No `n ≡ 2 (mod 4)` has a circle over `Λ_parts`
(all 30 such `n ≤ 120` empty), and more generally `v₂(n)` odd ⟹ empty, to 120. Both `n = 2` and `n = 10` —
the two cheap 6-open members — are killed by the first.

---

## §6 — CONTRADICTION 2: a committed enumerator truncates, and it is why no census ever found a 6-open rotation

**`tools/typem_exact.moser_ball_exact` cuts on ONE conjugate only.** The Moser lattice is a rank-4
`ℤ`-module in the plane, so a one-sided disk cut is a **dense, infinite** set, and the function's
`span = 4` coefficient box silently decides the answer:

| radius 2.05 | span 4 | span 6 | span 8 |
|---|---|---|---|
| points | **873** | 1,899 | 3,301 |

So `data/m62/rotations-exact-moser-r2.05.json` — 873 points, 18 unit-norm points, 10 rotation classes,
**none 6-open** — is a property of `span = 4`, not of the Moser lattice inside radius 2.05.

**And the truncation hid exactly what this phase is looking for.** At radius 5:

| circle | span 4 | span 6 | span 8 | span 10 |
|---|---|---|---|---|
| `\|p\|² = 16` | **14** | 14 | **18** | 18 |
| `\|p\|² = 20` | **4** | 16 | **36** | 36 |

The true count at `|p|² = 16` is `18 = 4·S₁` — gate A holding on the Moser base too — and `span = 4` was
cutting the circle off. **A zero in the flattering direction, from a generator whose image excludes the
target, in a committed tool** (`CLAUDE.md` G21). Anything resting on that census, including FS-30's
"nothing on either base is 6-open", needs re-reading.

**`parts_lattice` is not affected:** it cuts on **both** conjugates exactly
(`gap ≥ 0 and gap² ≥ 132P²`), which is what makes it finite. The difference between the two functions is
load-bearing and undocumented; that is worth one line wherever this is inherited.

**A second free cross-check, from a file that had sat unread through three ledgers.**
`data/m62/rotations-exact-moser-r2.05.json` does contain one rational-cosine class, `±7/8` — the record's
own `n = 4` — and its diagonal count is **18**, exactly that base's unit-shell count. Gate A, confirmed on
a second base, out of a committed artifact.

---

## §7 — The two sentences the brief asked to be carried

**A rotation that survives a screen is un-eliminated, not alive.** `n = 16` and `n = 20` have survived four
gates. Nothing above says either refuses four colours, and the advisor's PH2-7 stands: the diagonal family
is a perfect matching whose whole contribution inside the colour-twist family saturates at four conditions,
so the circle count cannot carry an object by itself. The record's own force comes from its non-diagonal
connecting orbits, and it *contains* a certified 5-chromatic object rather than producing one.

**Silence is not evidence.** The four-colour filter fires one way only. `n = 16`'s and `n = 20`'s survival
of it teaches nothing about whether their arenas refuse four colours.

---

## §9 — `ρ₆₃` (`n = 16`): the independent recount, and it agrees edge for edge

Run as a **control on the planner's object, not a duplicate of it.** Every number below was produced by my
own enumeration, my own unit-edge construction and my own re-derivation of the cross-edge law.

| quantity | mine | planner's | verdict |
|---|---|---|---|
| base points at radius **4.04** | **25,843** | 25,843 | identical |
| base points at the exact bound `32/√63 = 4.03175` | **25,567** | — | mine cuts at the bound, hence the 276-point gap — **not a disagreement** |
| circle points on `\|p\|² = 16` | **30**, and *exactly* `4·S₁` — no extras, no omissions | 30, each `4×` a unit vector | identical |
| unit degree of a circle point, in the radius-5 cut (`Λ_parts(5)` = 60,691) | **min 30, max 30** | — | matches the Cayley prediction `\|S₁\| = 30` |
| unit edges per point | **10.647** (272,232 / 25,567) | 10.65 | identical |
| cross edges | **126 = 60 centre + 36 off-diagonal + 30 diagonal** | 126 = 60 + 36 + 30 | identical |
| of those, independently re-derived | **126 / 126, 0 invented** | — | see below |

**The re-derivation did not use `CrossLaw`.** For every claimed edge `(u,v)` I recomputed, from the raw
coordinates, the collinearity condition `q = u_x v_y − u_y v_x = 0` and the length condition
`|u|² + |v|² − 2·cos·(u_x v_x + u_y v_y) = 1`. Both are pure `K` arithmetic — **no `√7` is ever
evaluated**, because the sine cancels once `q = 0` — so an invented edge could not survive. All 126 pass,
including the 36 that are law-exposed and the 90 the planner correctly identified as free.

**And the law is complete, not merely sound.** `|u − ρv|² = 1` expands to `c·p − σ√D·q = k` with
`p, q, k ∈ K` and `√D ∉ K`; since `{1, √D}` is a `K`-basis of `K(√D)`, the two components must vanish
separately, forcing `q = 0` and `c·p = k`. So **no cross edge can be missed either**, and the 126 is the
complete count at any radius.

---

## §10 — Why `126 = 60 + 36 + 30` at two different angles is mostly forced, and where it genuinely differs

Reproducing the record's exact decomposition is the single most flattering thing a derived law can output,
so it was taken apart rather than celebrated.

- **The 60 centre edges are forced for every rotation in the family.** A centre cross edge needs
  `|0 − ρv| = |v| = 1`, a condition in which **the cosine does not appear at all**. So it is `2·|S₁| = 60`
  at every angle. Carries no information.
- **The 30 diagonal edges are forced by gate A.** Both circles are `t·S₁` — `t = 2` for the record, `t = 4`
  for `ρ₆₃` — so both count `|S₁| = 30`. Structural, not coincidence.
- **Only the 36 off-diagonal edges are law-exposed, and there the two objects differ.** Measured radius
  classes of the off-diagonal endpoints:

| | off-diagonal radius pairs |
|---|---|
| `ρ₁₅` (record) | **one** conjugate pair: `17/6 ∓ √33/6` ↔ `17/6 ± √33/6` |
| `ρ₆₃` | **three** pairs: `100/9 ↔ 64/9`, and `187/18 ∓ 11√33/18 ↔ 86/9 ∓ 10√33/9` |

So `36 = 36` is an agreement of **count at different structure** — three radius families where the record
has one, including a *rational* pair (`100/9 ↔ 64/9`) the record has no analogue of.

**Two controls that make the 126 believable rather than suspicious.**
1. **`ρ₁₅`'s own law on `ρ₆₃`'s 25,567-point lattice still gives exactly `126 = 60 + 36 + 30`** — a base
   **14× larger** than the one the record was measured on. That confirms the endpoint bound empirically:
   the record's cross-edge set does not grow when its base does, so the two 126s are comparable objects
   and not two truncations.
2. **`n = 20` on the same pipeline gives `120 = 60 + 0 + 60`.** The count is **not** constant across the
   family, so 126 is not an artifact of my construction.

**And control 2 reverses the ranking that circle count alone would give.** `n = 20` has **twice** the
record's circle (60 points) and **zero off-diagonal cross edges** — its entire cross structure is a centre
star plus a perfect matching, which G14 and the advisor's PH2-7 both say carries no colour pressure. So on
this evidence `ρ₆₃` outranks `n = 20` decisively, and the circle count — the quantity the phase was built
to maximise — points the **wrong way**. That is PH2-2's lesson, now measured on a fresh member.

---

## §11 — "Defeats the four-colour certificate at both primes" is automatic, and therefore evidence of nothing

**This is the sharpest result here, and it is a derivation.** The residue colouring of Theorem B is a group
homomorphism from the module into `𝔽₄`, a field of **characteristic 2**. A free circle is `t·S₁`. Hence

> `residue(t·v) = t·residue(v) = 0` whenever `t` is **even** —
> so **every circle point carries the centre's residue**, and every diagonal cross edge is monochromatic.

And a twist `π` cannot repair it: the centre is shared between the two halves, so `π` must fix the centre's
colour, so it fixes the circle's colour too, so `C(p) = π(C(p))` on all 30 diagonal edges.

**Measured at both primes, on the `ρ₆₃` base:**

| | prime with `S ≡ 145 (mod 256)` | prime with `S ≡ 111 (mod 256)` |
|---|---|---|
| residue colouring proper on the base? | **0** monochromatic unit edges of 272,232 | **0** of 272,232 |
| centre residue | `(0,0)` | `(0,0)` |
| the 30 circle residues | **`{(0,0)}`** — all equal to the centre's | **`{(0,0)}`** |
| the 30 unit-vector residues | all three nonzero classes | all three nonzero classes |
| twists `(C, π∘C)` satisfying all 126 cross edges | **0 of 24** | **0 of 24** |

The first row is the free geometry check of G36 passing, which independently validates the base: a
misplaced point would show as a monochromatic unit edge, and there are none.

**The consequence for how this phase reads its own results.** `ρ₁₅` has `t = 2`, also even — so **the
record's certificate is defeated for exactly the same free reason**, and so is every free-circle member's.
"Defeats the four-colour argument at both primes" therefore **cannot distinguish a promising arena from a
hopeless one**; it is a property of `t` being even, available before any base exists. Stage 1's base
achieving it was not progress, and `ρ₆₃` achieving it is not progress. It should be retired as a signal and
replaced by the question of what colouring *outside* the twist family does — which is what the solver is
for.

**The third row is also the reason no cheap repair exists.** The centre cannot simply be recoloured: its 30
unit neighbours already carry all three nonzero residues, so no fourth colour is free at the centre.

---

## §12 — The solver

Handed the **whole** `ρ₆₃` arena to CaDiCaL as a satisfiability question — `2 × 25,567 − 1 = 51,133`
vertices (the centre is shared), `2 × 272,232 + 126 = 544,590` edges, encoded as **204,536 variables and
2,536,291 clauses** (`/tmp/claude-1000/screen-h2/arena.cnf`).

**Registered before launching, with both outcomes reachable.** *Prediction: SATISFIABLE — the arena is
four-colourable.* Grounds: both halves are individually four-colourable by Theorem B (the base lies in
`K²`, and the rotated half is graph-isomorphic to it), and they are joined by only **126** edges touching
at most ~133 of the 51,133 vertices. The uninformative-versus-informative split is genuine here because the
instance is the same size and shape either way, and the solver decides it rather than my construction.

**Which verdict is suspect.** The base edges are **measured** but *complete* — they are differences in the
exact norm-1 shell `S₁`, and the Cayley property makes that exhaustive, so no edge can be missing. The
cross edges are **derived**, and §9 shows the law is both sound (126/126 re-derived) and complete (the
`{1,√D}` basis argument). So for once neither direction has the usual asymmetry — but the object's novelty
still lives in the derived half, so **a refusal (UNSAT) would be the suspect verdict** and would need the
126 edges re-audited before it is reported as a five-chromatic object.

**Status at the time of writing: still running**, 200 s of CPU, 406 MB, 2.34 M clauses irredundant and
153 k learned, no verdict. Not yet a cost statement — the record's own arena refutes in about ten seconds at
3,433 points, and this is 51,133 vertices, so a long run is expected either way and its length carries no
information about the answer. **Whoever inherits this should re-launch or resume rather than infer from the
absence of a verdict.**
`/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical --sat /tmp/claude-1000/screen-h2/arena.cnf`

**A constructive shortcut was tried first and failed, and the failure is informative.** Recolour each of the
30 base circle points off the centre's residue and leave the copy as the residue colouring: every cross-edge
kind would then be satisfied. It does not work — **all 30 circle points are stuck at both primes**, because a
circle point `4v`'s unit neighbours are `4v + u` with residue `residue(u)`, and those cover all three nonzero
classes, so no colour is free. The same obstruction kills every colouring built from the residue map composed
with a base automorphism or a colour twist: `residue(4x) = 0` regardless. **So the arena's colourability is
genuinely a solver question and not a construction question.**

**Handed to the dedicated solver agent**, which is taking over with cube-and-conquer across 32 cores. Its
exit of the monolithic process is expected and is not a crash. Artifacts produced for it, each a measurement
in its own right:

| fact | value | why it matters |
|---|---|---|
| arena edge list, `2n` index space | `/tmp/claude-1000/screen-h2/arena_edges.txt`, **544,590** edges | lets a model be verified against the graph rather than the encoding |
| metadata | `/tmp/claude-1000/screen-h2/arena_meta.json` | centre, circle points, unit vectors, cross edges, interface, degrees |
| **the interface** | only **97** base vertices are touched by the 126 cross edges | the entire coupling between two independently four-colourable halves; the real branching frontier |
| the genuine coupling | **96** constraints = 30 diagonal + 36 off-diagonal + 30 copy-centre | 30 of the 126 collapse onto base unit edges and are redundant duplicates |
| degree | a **plateau**: 8,239 vertices at the maximum 30, then 36/192/228/408 at 29/28/27/26 | the Cayley identity again — every interior module point has degree exactly `\|S₁\|`, so "highest degree" is not a discriminator |
| maximum clique | a **triangle**, and this is a theorem not a search | four plane points are never pairwise unit-distant (`Mascot.lean`, ledger row 58), so 24× is the whole symmetry break available; one through the centre is `(12783, 12677, 14417)` |
| monolithic hardness at kill | 533 s, **134,238** conflicts, ~250 conflicts/s, 410 MB, not converging | a cost observation, not a hint about the answer |

**One encoding subtlety, recorded because it is the kind of thing a later reader gets wrong.** The centre is
shared, so the copy-centre index `38350` is *not a vertex*; its four variables are declared and never
constrained. Consequently the copy's own centre edges do **not** arrive through the copy-internal edge list —
those clauses mention the free variable and are vacuous — they arrive as the 30 cross edges `(org, n+j)`.

**And an asymmetry for anyone tempted to shrink the instance.** A sub-object is valid evidence in **one
direction only**: an UNSAT sub-instance proves the whole arena UNSAT, while a SAT sub-instance proves
**nothing**, because colourings of a subgraph need not extend. So the UNSAT direction may be pursued on the
interface's neighbourhood closure and the SAT direction may not.

---

## §13 — The phase's own distance-to-colourable metric, measured — and `ρ₆₃` nearly doubles the record

The brief's §2 defines the distance between a candidate and a *proof that it fails* as the number of cross
edges whose endpoints share a residue: delete those and the residue colouring four-colours the arena. Higher
is better. Measured, at both primes, on one pipeline:

| arena | cross edges lost at prime 145 | at prime 111 | **metric (min)** | of which **forced-free** (diagonal) | **informative residual** |
|---|---|---|---|---|---|
| stage 1's base (the phase's own rotation) | 32 | 8 | **8** | — | — |
| **`ρ₁₅`, the record** | 30 | 30 | **30** | **30** | **0** |
| **`ρ₆₃` (`n = 16`)** | **54** | **54** | **54** | 30 | **24** |

**Two readings, and the second is the one that is new.**

1. **On the phase's own yardstick `ρ₆₃` leads decisively** — 54 against the record's 30 and stage 1's 8.
2. **The record's 30 are *entirely* the forced diagonal kind; it loses not a single off-diagonal edge.** So
   the metric, evaluated on the only positive instance anyone holds, is measuring the free quantity of §11
   and nothing else — the same failure mode as the circle count. **`ρ₆₃` is the first arena in this phase
   whose certificate defeat is not free:** 24 of its 54 losses are off-diagonal, the law-exposed kind, where
   the record and stage 1 have zero.

That residual of 24 is the quantity I would put in place of the circle count as the phase's objective. It is
the part that no `t`-even member gets for nothing.

---

## §14 — Answering the two questions I was sent to answer

**`n = 2`: dead, and cheaply.** Prediction registered and met (§4). Thin on two axes, no circle over this
lattice, and the circle it has in the field needs a finer module — recorded, not pursued.

**`ρ₆₃` (`n = 16`): un-eliminated, and now for a reason that is not free.** My recount agrees with the
planner's object edge for edge, including the 36 law-exposed cross edges and the 90 free ones, with **0
invented** under an independent re-derivation. It is denser than the record's fabric (10.65 unit edges per
point against 8.32), its field `ℚ(√3,√7,√11)` is 6-open, and it scores 54 on the phase's own metric against
the record's 30. **Nothing above shows it refuses four colours**, and the solver has not returned.

**The two sentences the brief asked to be carried, restated where they bite.** *A rotation that survives a
screen is un-eliminated, not alive* — `ρ₆₃` has survived four gates and one metric, and the metric's leader
on the only positive instance is a free quantity. *Silence is not evidence* — and §11 upgrades that: at every
free-circle member with `t` even, the four-colour filter is defeated **by construction**, so its silence there
is not even silence about the object. It is silence about `t`.

---

## §15 — What I did not do

- No cross-edge enumeration at `ρ₆₃` is included in this file; it was launched separately and its numbers
  belong beside it, not here. **Checkpoints:** `/tmp/claude-1000/screen-h2/ckpt/`.
  **Resume:** `cd /tmp/claude-1000/screen-h2 && setsid nohup env OMP_NUM_THREADS=1 python3 rho63.py > rho63.log 2>&1 &`
- No solver was run. No colourability verdict is claimed for any member.
- `n = 14` and `n = 36` have `11` **ramified** in their radicand (`55 = 5·11`, `143 = 11·13`); G43's
  criterion is stated for inert-versus-split and is silent there. Both are marked not-6-open above, which is
  a **guess, not a reading** — the advisor flagged the same gap. One line for whoever owns G43. Neither has
  a circle over `Λ_parts` anyway, so nothing here depends on it.
- The `n = 2` covolume question (a finer module reaching `(1,1)`) is recorded in §4 and not pursued.
