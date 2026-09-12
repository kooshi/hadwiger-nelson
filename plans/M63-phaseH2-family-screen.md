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

## §8 — What I did not do

- No cross-edge enumeration at `ρ₆₃` is included in this file; it was launched separately and its numbers
  belong beside it, not here. **Checkpoints:** `/tmp/claude-1000/screen-h2/ckpt/`.
  **Resume:** `cd /tmp/claude-1000/screen-h2 && setsid nohup env OMP_NUM_THREADS=1 python3 rho63.py > rho63.log 2>&1 &`
- No solver was run. No colourability verdict is claimed for any member.
- `n = 14` and `n = 36` have `11` **ramified** in their radicand (`55 = 5·11`, `143 = 11·13`); G43's
  criterion is stated for inert-versus-split and is silent there. Both are marked not-6-open above, which is
  a **guess, not a reading** — the advisor flagged the same gap. One line for whoever owns G43. Neither has
  a circle over `Λ_parts` anyway, so nothing here depends on it.
- The `n = 2` covolume question (a finer module reaching `(1,1)`) is recorded in §4 and not pursued.
