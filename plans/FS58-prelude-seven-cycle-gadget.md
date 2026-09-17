# FS-58 prelude — ℚ(√167)'s seven-cycle, the family it belongs to, and the 3-adic barrier

*Recorded 2026-09-17, before FS-58 opens. Read beside `plans/STUB-fractional-four.md` (FS-58) and `plans/FS56-quadratic-167.md` §D.
Tool: `tools/fs58_seven_cycle.py`. Records: `data/fs58/` (README there; regenerate with `data/fs58/run-all.sh`, resumable).
Status tags follow `CLAUDE.md` § Grokkings. **Prior art: not searched** — the FS-58 opening gate owes it (§7).*

**Credit.** Kooshi saw the structure, in the unit-distance atlas drawn this session (below): the shortest odd cycle of ℚ(√167)
looks like a triangle whose long side is three collinear unit edges and whose other two sides are each half of a diamond of
unit edges. He also noticed that denominator 280 shows the same cycle as 420, and proposed the test in §5: build the field's
graph from this shape alone, in every rotation, and see whether it carries the field's chromatic number as Moser's spindle
does. The derivations and computations are de Bruijn's.

*The atlas (private artifacts; sources are not in the repository): Unit Distance Atlas
`https://claude.ai/artifact/3nuVwboAbketNuWw7yRdw2` — exact unit-distance graphs over the 23 fields of the record, from every
unit vector of a chosen denominator; Finite Plane Atlas `https://claude.ai/artifact/6GhLV6m6xmmVP8YVJoKZtn` — UD(𝔽_q, 2) for
q ≡ 3 (mod 4) up to 83.*

## 1. The shape [exact, `data/fs58/census-*.out`]

Directions: `W_N` = every unit vector of ℚ(√167)(i) whose coordinates have denominator dividing N (FS-56's object,
`tools/fs56_low_height.py`). Every zero-sum multiset of seven directions with no proper zero-sum part — the 7-cycles through the
origin, up to the order of their edges — was enumerated by meeting in the middle.

* **N = 140 and N = 420: exactly four such multisets, one shape turned by quarter turns.** Each is three copies of one axis
  direction and four "diamond" directions. In the orientation with the run pointing down, w = (0, −1) and
  `v_A = ((−15 − 7√167)/140, (105 − √167)/140)`, `v_B = ((−15 + 7√167)/140, (105 + √167)/140)`,
  `v_C = ((15 − 7√167)/140, (105 + √167)/140)`, `v_D = ((15 + 7√167)/140, (105 − √167)/140)`, with `3w + v_A + v_B + v_C + v_D = 0`.
* **The triangle.** Corners (0, 0), (0, −3) and the apex (√167/10, −3/2). The long side is the run of three. Each other side is the
  long diagonal of a diamond with unit sides: `v_B + v_D = (√167/10, 3/2)`, `v_A + v_C = (−√167/10, 3/2)`. With both paths of each
  diamond drawn the object has **9 points and 11 unit edges**; a 7-cycle takes one path through each diamond.
* **The diamond.** The angle θ between its sides has cos θ = 24/25, sin θ = 7/25 (the 7–24–25 triangle, θ ≈ 16.26°); its long
  diagonal is 7√2/5 ≈ 1.980. The rotation carrying one side to the other, (24 ± 7i)/25, is **not** a direction at these
  denominators (25 ∤ 420) — the precise sense in which the sides are virtual.
* **Angles.** Apex 98.5087°, cos = −29/196; base angles 40.75°, cos = 15/(14√2). The other two pairings of the same four diamond
  directions give a flatter isosceles reading (legs 1.515, apex 163.74°) and a degenerate collinear one.
* **N = 2184: a different kind.** 32 multisets, every one of seven *distinct* directions — no straight run. The run-plus-diamonds
  shape is the story at 140 | N, not the whole field.
* **140 is the least denominator carrying a 7-cycle** [exact within caps, `data/fs58/least-denominator.out`]: breadth-first from the
  origin to 400,000 points, every smaller N with a direction outside ℚ(i) has no odd cycle of length ≤ 7 (N = 120), ≤ 11 (N = 84,
  96, 116) or ≤ 23 (the rest). Denominators whose directions all lie in ℚ(i) are bipartite and skipped.

## 2. The angle can never be right [hand]

A diamond's long diagonal is shorter than 2, so the legs satisfy a² + b² < 8 < 9 = (base)². The apex is always obtuse, and its
cosine is at most −1/8 (legs → 2, flat diamonds): **apex ≥ arccos(−1/8) ≈ 97.18°**, attained only by the flat case over ℚ(√7),
the 3–2–2 triangle of straight runs. ℚ(√167) sits 1.33° above that floor. A right angle would need apex height 3/2 = √225/10
against √167/10.

## 3. The family, and the Moser spindle inside it [hand; exact constructions in `data/fs58/family.out`]

A run of n unit edges closed by two unit diamonds of opening angle θ (an isosceles triangle, legs the diamonds' long diagonals)
closes up exactly when **apex height² = 2(1 + cos θ) − n²/4**. The construction lives in **ℚ(cos θ, sin θ, √(8(1 + cos θ) − n²))**, and
the cycle has length n + 4. Legs are shorter than 2, so the base is shorter than 4: odd n ∈ {1, 3} only.

| run | diamond | field | cycle |
|---|---|---|---|
| 1 | θ = 60° (two unit triangles) | ℚ(√3, √11): 8·(3/2) − 1 = 11 | the Moser spindle `[Moser1961]` |
| 1 | θ = 90° (a square) | ℚ(√7) | 5-cycle, 7 points, 9 edges |
| 3 | θ = 0 (flat) | ℚ(√7) | 7-cycle, the 3–2–2 triangle |
| 3 | cos θ = 4/5, 7/25, 5/13 | ℚ(√15), ℚ(√31), ℚ(√39) | 7-cycle, 9 points, 11 edges |
| 3 | cos θ = 24/25 | ℚ(√167) | Kooshi's 7-cycle |

Each row but the spindle was constructed in exact arithmetic with its odd girth confirmed (`family` subcommand). **The difference
that matters:** the spindle's diamonds are pairs of triangles, so every 3-colouring gives their tips one colour, and the closing
edge refutes three colours. The ℚ(√167) diamonds are 4-cycles (the field has no triangles at all) and force nothing: the shape is
a 7-cycle with two extra paths, 3-colourable, and certifies only χ ≥ 3.

**Rational diamonds.** When cos θ = a/b and sin θ are rational (a rational point of the circle, b odd, gcd(a, b) = 1), the field
is **ℚ(√((8(a + b) − n²b)·b))**. Two consequences, both proved by hand:

1. **Every such field breaks the 2-adic wall.** b is odd, so (8(a + b) − n²b)·b ≡ −n²b² ≡ 7 (mod 8) for odd n, and the squarefree
   part of an odd number ≡ 7 (mod 8) is ≡ 7 (mod 8) — G35's wall-breaking class.
2. **A Legendre condition decides which prime fields can hold which cycle.** Let D be a prime, D ≡ 3 (mod 4), D > 7. If ℚ(√D)
   holds the gadget with a rational diamond then the Legendre symbol **((16 − n²) / D) = +1**: (7/D) = +1 for the 7-cycle,
   (15/D) = +1 for the 5-cycle.
   *Proof.* Every prime factor of b is ≡ 1 (mod 4), so D ∤ b; gcd(b, 8(a + b) − n²b) = gcd(b, 8a) = 1; so b = s² and
   8(a + b) − n²b = Dt². Modulo D, cos θ = a/s² ≡ n²/8 − 1, so the numerator c of sin θ = c/s² satisfies
   c² ≡ s⁴(1 − (n²/8 − 1)²) = s⁴·n²(16 − n²)/64 with s ≢ 0; and c ≢ 0 since D ∤ 16 − n² for D > 7. ∎
   *Reading of the mechanism:* reduce at the prime above D (√D ↦ 0) and the triangle collapses onto its base; the collapsed diamond
   has cosine n²/8 − 1 and exists in 𝔽_D exactly when its sine does.
   **At 167:** (7/167) = +1 and (15/167) = −1 — the family gives ℚ(√167) its 7-cycle and can never give it a 5-cycle, matching
   FS-56's measurement (no 5-cycle among directions of denominator ≤ 10,920). Scope: this excludes the isosceles
   rational-diamond 5-cycle, not every 5-cycle.
   **Measured beside it** (diamond cosines of denominator ≤ 200,000, squarefree D ≡ 7 (mod 8) below 400): every prime D found
   satisfies the condition; primes that satisfy it and were not found at this height: 191, 239, 311, 359 (5-cycles); 47, 199, 223,
   271, 311, 367, 383 (7-cycles). **Necessary, not shown sufficient.** Composite fields found: 7-cycles in ℚ(√D) for D = 15, 39, 87,
   95, 111, 183, 399; 5-cycles for D = 15, 55, 87, 119, 159, 231, 295, 303, 335.

## 4. The 3-adic barrier: 3-integral directions are 3-colourable [hand + verified colouring, `data/fs58/residue-3.out`]

**Theorem.** Every unit-distance graph over ℚ(√167) whose edge directions all have denominators prime to 3 is 3-colourable, at every
size. Explicitly: when its points have 3-free denominators (otherwise translate each connected component by one of its points),
colour ((a + b√167)/m, (c + e√167)/m), 3 ∤ m, by **(a + b + c)·m⁻¹ mod 3**.

*Proof.* 3 is inert in ℚ(√167) and 167 ≡ −1 (mod 3), so reduction is a ring map from the elements with 3-free denominator onto
𝔽₉ = 𝔽₃[t]/(t² + 1), √167 ↦ t. It is additive and preserves x² + y² = 1, so a 3-integral unit vector maps to a unit vector of 𝔽₉²,
which is nonzero. The plane UD(𝔽₉, 2) (81 points, circle of 8, 324 edges) is not 2-colourable, and **κ(x₀ + x₁t, y₀ + y₁t) =
x₀ + x₁ + y₀ (mod 3)** colours it properly (checked on all 324 edges); κ is linear, so κ∘reduction is additive and nonzero on every
3-integral unit vector. Colour each component p₀ + A of the graph by x ↦ κ(reduce(x − p₀)). ∎

It is Theorem A's shape (`colorable_of_residue`, `ResidueColouring.lean`: a graph in an abelian group, edge differences in a subgroup
and nonzero under an additive map to a group of order k) with the subgroup the 3-integral lattice and the target ℤ/3 — a cheap
kernel instance. The rule was also checked nonzero on all 432 unit vectors of W_m for m ∈ {140, 280, 560, 700, 980, 1540, 1960, 3640}.

**Consequences.**
* The whole direction graph at any 3-free denominator — 140, and Kooshi's 280 — is 3-colourable by the formula.
* **Every 4-chromatic unit-distance graph over ℚ(√167), if one exists, has an edge whose direction has 3 in its denominator**, such as
  (83 + i√167)/84. FS-56's 3-colourable balls (denominators 420 and 2184, both divisible by 3) lie outside the formula's reach; their
  colourings came from a solver.
* *The same argument at 2* [hand, not machine-checked]: the prime above 2 is ramified with residue 𝔽₂, whose plane is a 4-cycle, and a
  coordinate (a + b√167)/m in lowest terms is integral there iff m is odd — so **every odd cycle uses a direction of even denominator**.
* *No barrier at 5 or 7*: 5 and 7 are inert with residue planes over 𝔽₂₅ and 𝔽₄₉, which refuse three and four colours (CaDiCaL's
  claims, `residue-3.out`).

## 5. The experiment: the shape alone, in every rotation [measured, `data/fs58/union-*.out`]

Rotations: every unit vector of denominator dividing R. Construction: every rotated copy of the 9-point shape through the origin, by
each of its vertices; then copies glued along existing edges, breadth-first, to a point cap. Edges: **every** exact unit distance among
the points (floating point proposes, integers decide), which contains all copies' edges. 3-colourability by CaDiCaL, every model
verified on every edge.

| rotations | points | gadget copies | unit edges | directions (up to sign) | with 3 in the denominator | additive ℤ/3 colourings | 3 colours |
|---|---|---|---|---|---|---|---|
| R = 140 (control) | 5,002 | 1,591 | 19,256 | 50 | 0 | 16 | yes, verified |
| R = 420 | 5,002 | 1,724 | 17,435 | 102 | 52 | 0 | yes, verified |
| R = 84 | 50,001 | 39,314 | 223,557 | 54 | 28 | 0 | yes, verified (0.6 s) |
| R = 420 | 50,001 | 27,802 | 222,243 | 102 | 52 | 0 | yes, verified (0.6 s) |

The control behaves as §4 predicts (16 linear colourings). With 3-denominator rotations every linear 3-colouring dies, and the solver
finds non-linear ones at once.

**Reading [reading].** The shape is not a spindle for ℚ(√167): nothing in it forces at three colours, and gluing copies in every
rotation produces no rigidity at 50,000 points. If χ(ℚ(√167)²) ≥ 4, the reason is not local in the way Moser's is. *Killing test:* a
finite graph over ℚ(√167) with a pair forced equal at three colours (the chain theorem, G55, would then turn it into χ ≥ 4 if its
difference inverts to a sum of unit vectors).

## 6. What FS-58 inherits

* **A necessary condition for its SAT route (R3):** a refusal of three colours needs 3-non-integral directions; pieces built only from
  W_N with 3 ∤ N are wasted by theorem. Design pieces rich in 3-non-integral edges, and read every null against that.
* **The residue barrier as an instrument:** for any real field and any prime whose residue plane is small and colourable, the
  unit-distance graph on the directions integral at that prime is colourable by the plane's colouring. The four window fields
  ℚ(√167), ℚ(√1055), ℚ(√2351), ℚ(√4703) all have d ≡ 2 (mod 3) and d ≡ 3 (mod 4), so each has **both** barriers: 3 inert with residue
  𝔽₉ (three colours, by the same linear rule) and 2 ramified with residue 𝔽₂ (odd cycles need even denominators).
* **For R1 (the equidistribution reading):** the 7-cycle family is a small explicit object where the local picture at the ramified
  prime (the collapsed triangle) decides existence — a worked instance of "local conditions at small primes decide the shapes".
* **Open, unrecorded:** the atlas (its own JavaScript core, not a repository tool) shows 7-cycles over ℚ(√23) at N = 12, but
  (7/23) = (15/23) = −1, so they are **not** this family — their shape is unexamined.
* **A kernel target:** §4 as an instance of Theorem A (the formula, the lattice, one `decide` on 𝔽₉).

## 7. Prior art owed (the FS-58 opening gate)

Not searched. Queries, in the disciplines' words: *unit distance graph over a real quadratic field, odd girth*; *chromatic number of
F² for F = ℚ(√d), triangle-free*; *additive colouring of a subgroup of the plane, residue field of characteristic 3*; *generalized
Moser spindle, rhombus, base three*; the additive-colouring framework of `[Fischer1990]` (its 1/k obstruction concerns the whole
plane, not integral subgroups); triangle-free 4-chromatic unit-distance graphs `[Wormald1979]`, `[ODonnell1999]` for how forcing
works without triangles.
