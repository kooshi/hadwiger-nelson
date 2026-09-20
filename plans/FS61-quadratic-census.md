# FS-61 — the census of real quadratic fields: which planes need four colours, and what arithmetic decides it (the subplan)

*Opened 2026-09-19 by de Bruijn (planner). Stub: `plans/STUB-quadratic-census.md`. Predecessor and the source of every instrument used
here: `plans/FS58-four-colours.md` (§2 D1–D3, §R-B4, §R-B5, §C), `data/fs58/search-23/README.md`, `data/fs58/search-167/README.md`.
Understanding so far: `CLAUDE.md` G48, G55, G60, G61, ledger rows 72–73. Status tags follow `CLAUDE.md` § Grokkings ([kernel], [cert],
[measured], [hand], [reading], [method]). **This file is written as a complete letter to an implementer who arrives with no memory of
any conversation**, and to a product owner who scores each phase from artifacts and logs, never from a report's summary.*

> **APPROVED by the product owner, 2026-09-19, as written** (plan at `f7d94f7`). Read cold; every gate in §6 is scoreable from a
> named artifact. Checked independently before approval, first-hand: the zbMATH record for `[Fischer1994]` (verbatim as §PA-R quotes
> it; `p = 3`, `q = 11` meet all three congruences); `[Fischer1990]` Thm 6 and the sentence after Thm 9, in the held PDF's text layer;
> the `L ≥ 5` classes `d ≡ 47, 143, 167 (mod 168)`, re-derived by hand; and O6's atlas rows by a separate brute-force enumeration —
> `D(6) ∩ family = {11, 35}`, `D(18) ∩ family = {11, 35, 155, 203, 299, 323}` (all `≡ 3 mod 8`), `D(24)` all `≡ 7 mod 8`, and
> **`D(12) = {23, 47, 71, 95, 119, 143}` over *every* squarefree `d`, not only within the family**. The planner's three corrections
> to the opening brief (the `mod 84` reading, "never tried" at 35 and 59, the stub's jackpot sentence) stand, and are its findings.
> Decisions A–M stand. From here the implementer writes §R only; a change to §0–§9 is proposed to the owner, not made.

## §0 Read this first

**What the milestone is, in plain words.** Colour every point of the plane whose two coordinates lie in the number field `ℚ(√d)` so
that no two points at distance exactly 1 share a colour; `χ(ℚ(√d)²)` is the fewest colours that suffice. Two days ago (FS-58) this
project proved, with finite computer-certified graphs, that **four colours are needed for `d = 11, 23, 47, 71, 95, 191`** — the first
real quadratic fields known to need more than three — and failed at `d = 167`, the field where this project's local–global conjecture
(`CLAUDE.md` G48: *the chromatic number of a field's plane equals the best bound its finite residue planes give, `L(F)`, whenever that
bound is at most 6*) predicts six or more. FS-61 is the **census**: run one uniform procedure over a whole family of fields, record
where it lands and where it does not, and **explain the pattern by arithmetic**. Three products, in order of value:

1. **the explanation** — which arithmetic of `d` decides landing (the programme values the derivation an order of magnitude above the
   table: `CLAUDE.md` § The mission), including *why 167 does not land*, which is what the falsification target FS-59
   (`plans/STUB-four-colours-167.md`) needs before more solver time is spent there;
2. **new exact values and brackets** — every certified landing at a field whose upper bound is 4 is a new value `χ = 4`;
3. **a class theorem if one is there** — a statement about infinitely many fields (§3 D-F states the candidate precisely; the stub's
   wording of it was wrong, §3 D-F.4).

**Bearing on the hunt for six colours: none directly.** It tests the conjecture's level-4 clause across a family and aims FS-59. Nothing
in this plan leans on any claim about which values `χ(ℝ²)` can take.

**Who does what.** One implementer (Opus 5), one phase at a time, under the gate in §6. The product owner scores §6 item by item by
opening the named artifact. No advisor and **no subagents**: the owner's standing rule (2026-09-19) is *one planner, one implementer,
no nested agents* — nested agents multiply token spend invisibly to the person accounting for it. If a phase does not fit in your
context, stop at a phase boundary, persist everything (§5), and say so; a census complete through phase N with the rest honestly marked
is the right deliverable.

**What is frozen.** `tools/fs58_*.py` (every file) and above all the independent checker `tools/fs58_check_witness.py`: FS-61 *imports
and calls* them and never edits them, because FS-58's certified results rest on them as they are and the regression in phase 0 is
meaningful only if the code under it has not moved. New code goes in `tools/fs61_census.py` (and siblings `tools/fs61_*.py`); new
records under `data/fs61/`. Nothing under `data/fs58/` may change — a gate item checks it.

**No Lean in this milestone** (decision K, §4): kernel forms of the witnesses are FS-60's (`plans/STUB-quadratic-witnesses-kernel.md`).
FS-61's obligation to FS-60 is a format: every witness is emitted in exactly FS-58's `witness.json` + `witness.lrat.gz` shape.

### §0.1 How to read this file, the words it uses, and your first hour

**Reading order for the implementer:** §0, this section, §1–§2, §3, §4 (decisions), §5 (rules), then the phase you are on in §6 with
§7 (records) beside it, and §8 before phase B. §PA is the record of the literature search: you need only its Headlines 2 and 4. §M is
the record of *why* the schema and statements look as they do; where §M and §6–§7 differ, §6–§7 are the specification. In FS-58's
plan (68 KB — read by search, not whole) the useful parts are §2 D1–D4 (lines ~127–210) and §R-B5 (~558–589); in
`tools/fs58_search.py` the 40-line docstring at the top is the manual.

**Words** (FS-58's, kept so one vocabulary runs through plan, code and records):
* **unit vector** — `((a + b√d)/N, (c + e√d)/N)` with integers, `a² + c² + d(b² + e²) = N²`, `ab + ce = 0`; written `(a, b, c, e)` over
  `N`. Its **least denominator** is `N` in lowest terms; it is **3-integral** when `3 ∤ N`, **rational** when `b = e = 0`.
* **class** — an orbit of unit vectors of one least denominator under the order-16 group (quarter turn, swap of coordinates, `√d ↦ −√d`).
  Named by denominator: `12`, or `60.1`, `60.2` when there are several; rational classes carry a `q` (`q1` = the four axis vectors,
  `q5` = the `(3/5, 4/5)` family). Names are meaningful only under the frozen `classes()`.
* **spec** / **pool** — a `+`-joined list of class names (`q1+12+60.1`) and the union of those classes. FS-58's commands take specs.
* **lattice** — the subgroup of the plane a pool generates; here always with **every** unit vector it contains as a generator
  (FS-58: "saturated"). **Covolume** — its 4-volume in the two real embeddings; a ball of radius `R` — a *bidisc*, see below — holds about `π²R⁴/covolume` points (119: `9.87·1.5⁴/0.00367 ≈ 13,610` against 13,605 counted).
* **quotient filter** — asks whether some finite quotient `Λ/L` of the lattice is 3-colourable; if so the whole lattice graph has a
  periodic 3-colouring and **no ball of it can ever refuse** (FS-58: the lattice is "dead"; otherwise "live", here `Open`).
* **ball** — the lattice points within radius `R` of the origin in both embeddings (FS-58's `piece(…, 'ball', R)`), with every unit
  distance among them as an edge. A ball **refuses** when a solver reports no proper 3-colouring.
* **witness** — a finite point set with its edge list and an LRAT refutation, in FS-58's `witness.json` / `witness.lrat.gz` format;
  **certified** when `tools/fs58_check_witness.py` prints `CERTIFIED`. **Direct route** — find a refusing ball and shrink it.
  **Chain route** (11 only, so far) — a finite graph that *forces* two points at difference `3u` to share a colour in every
  3-colouring (a **forcer**), copied along `1/3 = ` a sum of unit vectors until the forced-equal points are adjacent.
* **tier** — a named search depth (decision B). **Landed** — a certified witness exists. **Not landed at tier T** — none was found at
  that depth; it says nothing about the field's chromatic number.

**Your first hour** (it shows the whole instrument working before you write a line): from a scratch copy of `tools/fs58_search.py`,
`fs58_local.py`, `fs58_chain.py` (so that `data/fs58/` is untouched — the tool writes beside itself), reproduce O3 with the exact
commands in `data/fs61/pricing/README.md`: `saturate 119 180` (2 s), the three balls, then — **from the repository root after
`source scripts/dev-env.sh`** — `direct-witness` and the frozen checker. You should see `CERTIFIED: 456 points of Q(sqrt119)^2`.

## §1 The family, and why it is exactly `d ≡ 11 (mod 12)`

Let `F = ℚ(√d)`, `d > 1` squarefree, `K = F(i)`. Identify `F²` with `K` by `(x, y) ↦ x + iy`; a **unit vector** is a `u ∈ K` with
`u·ū = 1` (bar = complex conjugation), and the plane's graph is the Cayley graph of `(K, +)` on the unit vectors. A prime `𝔭` of `F`
that does **not** split in `K` (a *stable* prime) makes every unit vector `𝔭`-integral, and reduction is a graph homomorphism onto a
finite residue graph, so `χ(F²) ≤ χ(`that graph`)`; `L(F)` is the least such bound (prior art: `[Fischer1990]`, `[Moorhouse2010]` §8,
`[Madore2015]`; `CLAUDE.md` rows 52, 57, G35, G56). For real quadratic `F` the bounds are [hand; every piece prior art, assembled here]:

| condition on squarefree `d` | the stable prime | residue graph | consequence |
|---|---|---|---|
| `d ≢ 3 (mod 4)` | a dyadic prime of `F`, **ramified** in `K` | every unit vector `↦ 1 ∈ 𝔽₂` | `χ = 2` (`[Johnson1987]`, `[Fischer1990]` Thm 8) |
| `d ≡ 3 (mod 4)` and `d ≢ 2 (mod 3)` | a prime above 3 with residue field `𝔽₃` | the plane over `𝔽₃`, `χ = 3` | `χ = 3` — **both halves are `[Fischer1990]`** (Thm 9 and the sentence after it: *"the chromatic number of the plane `ℚ(√N)²` is 3 when `N ≡ 3` or `7 mod 12`"*; the lower bound is Thm 8's "only if", for every `N ≡ 3 (mod 4)`); re-derived by `[Moorhouse2010]` Thm 8.6 and `[Madore2015]` |
| `d ≡ 11 (mod 12)`, `d ≡ 3 (mod 8)` | the dyadic prime, **inert** in `K`, residue `𝔽₄` | `Cay(𝔽₄, μ₃) = K₄` | `χ ≤ 4` (`[Fischer1990]` Thm 9) |
| `d ≡ 11 (mod 12)`, `d ≡ 7 (mod 8)`, `(d/7) ≠ −1` | a prime above 7 with residue `𝔽₇` | the plane over `𝔽₇`, `χ = 4` | `χ ≤ 4` (`[Moorhouse2010]` Thm 8.1) |
| …, `(d/7) = −1`, `(d/11) ≠ −1` or `(d/19) ≠ −1` | above 11 or 19 | `χ = 5` | `χ ≤ 5` |
| …, none of 7, 11, 19 usable | above 23, 43, 47, … | floors 6 or more (G56) | `L ≥ 6`; below 500 only **`d = 167`** |

For `d ≡ 2 (mod 3)` the prime 3 is inert in `F` with residue field `𝔽₉ ∋ i`, so it **splits** in `K`: it is not stable, gives no bound,
and unit vectors may carry 3 in a denominator. For `d ≡ 7 (mod 8)` the dyadic prime splits in `K` too (`F₂ = ℚ₂(i)`).

**So the only real quadratic fields whose planes can need four colours are the squarefree `d ≡ 11 (mod 12)`, and the conjecture predicts
every one of them does.** Below 500 there are **40**: twenty with `d ≡ 3 (mod 8)` (11, 35, 59, 83, 107, 131, 155, 179, 203, 227, 251,
299, 323, 347, 371, 395, 419, 443, 467, 491 — all `L = 4`), and twenty with `d ≡ 7 (mod 8)`: twelve with `L = 4` through 7 (23, 71,
95, 119, 191, 239, 263, 287, 359, 407, 431, 455), seven with `L = 5` (47, 143, 215, 311, 335, 383, 479), and 167. *(Correction to the
brief this plan was opened from, which read `[Moorhouse2010]`'s `d ≡ 47, 59, 83 (mod 84)` as "`L ≥ 5`": that theorem uses only the
primes 3 and 7; with `[Fischer1990]`'s dyadic bound the fields 59, 83, 131 have `L = 4`. The `L ≥ 5` fields are
`d ≡ 47, 143, 167 (mod 168)`.)*

## §2 Measured at the opening (2026-09-19, the desktop, 16 physical cores; the machine was idle)

All of this is **pricing**, run from a scratch copy of the FS-58 tools so that `data/fs58/` was not touched; the small records are in
`data/fs61/pricing/`. None of it is a result of this milestone until the implementer reproduces it under §6.

* **O1 — FS-58's fourteen-field scan was mostly uniform in depth, and the counts vary because the fields do.** Twelve of its
  `saturate.jsonl` files were run at one depth (`NMAX = 180`: the axis plus one or two classes of unit vectors whose denominators have
  lcm ≤ 180); 23 ran at 300 and 167 at 420. At that one depth the number of lattices runs from 18 (`d = 107`) to 388 (`d = 11`):
  **the supply of low-height unit vectors is itself an arithmetic invariant of the field**, not a scan artefact. What *is* a scan
  artefact in those records is the "least odd cycle" column: the breadth-first search was capped at 20,000 points, so `odd: None`
  means "none of length ≤ `none_up_to`" (5 to 15 depending on the lattice), never "no odd cycle".
* **O2 — `saturate` is cheap:** `d = 119`, `NMAX = 180`: 144 lattices in 2.1 s wall (21 CPU-s, 16 workers).
* **O3 — a new field refuses, end to end in under a minute.** `d = 119 = 7·17` (never scanned by FS-58): the saturated lattice
  `q1+12+60.1` (28 directions, covolume `3.67·10⁻³`, least odd cycle 5, no 3-colourable quotient among 17 tried) refuses three colours
  on the ball of radius 1.5 (13,605 points, 64,942 edges, 0.69 s) and of radius 1.2 (5,605 points, **116 s** — the hard band just under
  the threshold, as FS-58 saw at 23 and 47); radius 1.0 (2,745 points) is 3-colourable. `direct-witness` shrank it to **456 points,
  1,122 edges in 52 CPU-s, and the frozen checker printed `CERTIFIED`** (`data/fs61/pricing/witness-119/`; LRAT sha256 `0ee2aceb…`,
  regenerable, not committed). With the residue plane at 7 (7 ramifies) this would be **`χ(ℚ(√119)²) = 4`** once phase C runs the full
  certification path (planted faults, wrong radicand, second solvers, a 4-colouring, the owner's recheck).
* **O4 — `d = 143 = 11·13` refuses (solver claim):** the lattice `q1+q5+12+60` (36 directions, covolume `1.77·10⁻⁴`, live: 0 of 16
  quotients 3-colourable): radius 1.5, 283,485 points, 103 s; radius 1.8, 587,333 points, 225 s; radius 1.2 (116,193 points)
  `Unknown` at a 600 s wall. `L(ℚ(√143)) = 5`, so certified this is `4 ≤ χ ≤ 5`. Extraction not priced (FS-58's 440,077-point
  extraction over 23 took 11 minutes).
* **O5 — over `d ≡ 3 (mod 8)` the obvious candidates are dead, by certificate.** The coarsest saturated 3-non-integral lattices with a
  short odd cycle over **11** (`q1+6+30.2`), **35** (`q1+q5+6+30`) and **59** (`q1+q5+30.1+30.2`; least odd cycle 7, covolume
  `1.2·10⁻³` — exactly the profile FS-58's §R-B5 reading says lands) each have a **3-colourable finite quotient** (`Λ/6Λ`, `Λ/12Λ`;
  `Λ/9Λ` for 59), that is, a verified periodic 3-colouring of the whole lattice graph: no ball of them ever refuses. 59's balls colour
  in under a second to radius 2.3 (237,229 points). **One lattice per field was asked — this is a reading, registered as P2, not a
  fact about the class.**
* **O6 — the two halves of the family live in disjoint worlds of *even* denominators** [exact enumeration, all `d`; odd denominators such as 57 (over 143), 63 (over 59), 171 (over 167) occur in both halves]. For a fixed denominator
  `N` only finitely many fields have a non-rational unit vector of least denominator `N` (its coordinates force `d ≤ N²`). Enumerating
  by `N`: `N = 6` → `{11, 35}`; `N = 18` → `{11, 35, 155, 203, 299, 323}`; `N = 30` → `{11, 35, 59, 131, 155, 179, 371, …}`;
  `N = 42` → `{59, 83, 395, …}` — **all `d ≡ 3 (mod 8)`**; while **`N = 12` → exactly `{23, 47, 71, 95, 119, 143}`**, `N = 24` →
  `{23, 47, 119, 167, 215, 239, 263, 287, 407, 455, …}`, `N = 36`, `48`, `60` → further `d`, **all `d ≡ 7 (mod 8)`**. The six fields
  owning a class of denominator 12 are *exactly* FS-58's direct-route landings (23, 47, 71, 95) plus the two that refused today (119,
  143); FS-58's remaining landing, 191, first appears at `N = 48`. This is the census's first explanation candidate (§3 D-H, R-size).
* **O7 — instrument traps met while pricing** (each is now a rule in §5): `fs58_search.py colour-scan`'s pool list is **one
  comma-separated argument** — further space-separated pools are silently ignored; every subcommand's arguments are positional and a
  `--help` after a subcommand is a traceback; `direct-witness` calls `lean --print-prefix`, which fails outside the repository
  directory; `colour-scan` and `extract` take a pool as a **class spec** (`q1+12+60.1`), not a saturated vector list, so a saturated
  lattice must be named by the classes it contains; and a checker exit status read through `| cut` is `cut`'s.

## §PA — prior-art gate (WORKFLOW 3a)

*Filled in §PA-R below once the sweep returned; the questions asked are recorded here so a negative is interpretable.* The seven
questions of WORKFLOW 3a, in the disciplines' words (combinatorial geometry: "chromatic number of the plane over a field / of
`ℚ(√d)²`", "coloring the rational points to forbid the distance one"; number theory: "points of bounded height on a norm-one torus",
"sums of two squares in real quadratic fields"; graph theory: "multiplicative graphs", "uniquely colourable products"): (1) has anyone
tabulated or classified `χ(ℚ(√d)²)`, or printed a lower bound of 4 for a real quadratic field — above all `[Johnson2006]` and Johnson's
2000 status report, which FS-58's gate could not reach; (2) the citation graphs of the papers that *posed* the question (Benda–Perles,
`[Fischer1990]`, `[Fischer1990b]`, `[Johnson1987]`, `[Moorhouse2010]`, `[Madore2015]`, `[Payne2009]`, `[AxenovichEtAl2014]`), in two
databases compared by identifier; (3) the exact statement behind FS-58 D3.4's measured fact that 3-colourings of `G × H` with
`χ(H) > 3` factor through `G` (`[GreenwellLovasz1974]`, Häggkvist–Hell–Miller–Neumann-Lara 1988, `[ElZaharSauer1985]`, Tardif's and
Zhu's surveys, `[Wrochna2020]`); (4) the number-theory side of the unit-vector supply; (5) outside arXiv; (6) attribution of the
control fields' values (`d = 2, 3, 5, 7`); (7) any published table of local data.

### §PA-R — what the gate found (2026-09-19)

**How it was run, and by whom — stated because the read-status of each source depends on it.** De Bruijn delegated the sweep to one
agent (about 95 minutes); that agent, before the owner's no-subagent rule reached it, delegated questions 4 and 5 to two further agents,
which were stopped early and handed back partial reports. Below, **[me]** marks what de Bruijn opened and read himself on 2026-09-19,
**[sweep]** what the sweep agent read and quoted, **[sub]** what only a second-level agent saw. `BIBLIOGRAPHY.md` carries the same marks;
a [sweep] or [sub] item is second-hand there until someone opens the text.

**Headline 1 — the census's question is posed in print, by name, and is otherwise untouched.** `[Moorhouse2010slides]` [me: text layer
of the saved PDF]: *"We are especially interested in how much the chromatic number can grow for quadratic extensions. … What can we
say about `χ(K²)` when `K = ℚ(√d)`, `d ≥ 2` a squarefree integer? … If `d ≢ 47, 59 or 83 mod 84`, then `χ(K²) ≤ 4`. **What about
`χ(ℚ(√47)²)`?**"* — FS-58's `4 ≤ χ(ℚ(√47)²) ≤ 5` is a partial answer to a question asked about that field by name, and the census is an
answer to the general one. Nothing found gives `χ ≥ 4` for any real quadratic field, and no table of `χ(ℚ(√d)²)` over `d` exists in
anything reached [sweep]: `[Payne2009]` §3's index stops at Fischer's upper bounds [sweep, and me at FS-18]; Johnson's 2000 status
report lists *"determine the chromatic number of … `(X, 1)`, when `X` is a finite algebraic extension of `ℚ²`"* as open (zbMATH review
Zbl 0974.05029, [sweep]); MathOverflow and math.SE do not pose it [sub]; Polymath16 makes no claim about a single-radical field
[sub]. **Residual risk, unchanged from FS-58:** `[Johnson2006]` (which by `[Johnson2010]`'s own words discusses *"distance graphs
`G(ℚ(√m)², D)` for square-free integers `m > 1`"*) and Johnson's 2000 report are still unread in full — Geombinatorics sits behind a
challenge page with no archived copies; both are on the interlibrary list. Also unreached and adjacent: Bohannon–Johnson–Lanig–Rubalcaba
2001 (Geombinatorics 10(4), *"particularly for `n = 2`"*, six open problems) and the unfollowed lead that *"similar computations have
been done by Sebastian Cioabă and Jason Williford"* (Moorhouse's slides, [me]).

**Headline 2 — the census family was split at exactly this modulus in 1990.** `[Fischer1990]` Thm 10 [me: the held PDF's text layer]:
`ℚ(√N)²` *has an additive 4-colouring if `N ≡ 3 mod 8`*, and *has no additive `k`-colouring for small `k` if `N ≡ −1 mod 24`*. His
second class is this plan's `d ≡ 23 (mod 24)` — the half where FS-58's direct route lands; his first contains the `d ≡ 11 (mod 24)`
half, where a group colouring with four colours exists and the opening found the coarse lattices periodically 3-colourable (O5). R-mod8
is therefore a statement about a division the literature already drew; what is ours is the lower bounds and the mechanism. The same
paper settles the controls' attribution [me]: Thm 8 (*2-colourable iff `N ≢ 3 mod 4`*; the "only if" half is the lower bound 3 for
every `N ≡ 3 (mod 4)`), Thm 9 and the sentence after it (`χ = 3` for `N ≡ 3, 7 (mod 12)`, so `χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3`) — twenty
years before `[Moorhouse2010]` Thm 8.6 and `[Madore2015]` Prop. 4.3, which FS-58's record credits. `χ = 2` for `d ≡ 1, 2 (mod 4)` is
`[Johnson1987]`.

**Headline 3 — the fact FS-58 D3.4 measured is NOT the multiplicativity of `K₃`, and as the stub words it, it is false.**
*Multiplicativity* (`[ElZaharSauer1985]` for `K₃`; Häggkvist–Hell–Miller–Neumann-Lara 1988 for odd cycles; `[Wrochna2017]` for
square-free graphs) says *which factor* of a product maps to `K`; it says nothing about what a colouring of the product looks like
[sweep: `[Zhu2025]` Def. 3.1, Thms 4.1, 4.2, 4.5]. The structural statement is `[GreenwellLovasz1974]`'s, quoted second-hand from
`[Tardif2008]` §4.2 [sweep]: *"if `G` is connected and `χ(G) > n`, then `G × Kₙ` is uniquely `n`-colorable"* — the 3-colourable
factor must be `K₃` itself. For a general uniquely 3-colourable factor it is Duffus–Sands–Woodrow's statement B(n) (1985), conjectural
[sweep; none of the four originals was reached — all paywalled]. And for a general 3-colourable `G` it **fails** [the sweep's example,
checked by me]: `G = C₅` coloured `(0,1,0,1,2)`, `H = K₄`; the vertex of `C₅` coloured 1 has both neighbours coloured 0, so recolouring
the single vertex `(1, a)` of `C₅ × K₄` to 2 is proper and does not factor through `C₅`. **The hypothesis that repairs it is
gap-freedom** — every vertex of `G` sees both other colours in every 3-colouring — which FS-58's `S₁` has because it is Hoffman-tight
(G54). So D3.4's measured fact is a statement about *tight* `G`, its proof is not in the literature found, and phase A.7's rule for
non-affine quotient colourings lives in the same gap: a lattice quotient that is 3-colourable but **not** tight is exactly where
colourings stop being pulled back. No citation of Greenwell–Lovász or HHMN may carry D3.4; the debt is restated, not paid.

**Headline 4 — the unit-vector supply has a number-theory name.** `[ZanardoZannier1991]` (*The group of pythagorean triples in number
fields*) [sub read §1 to Lemma 1; the sweep confirmed by grep]: for `i ∉ F` the group is the norm-one group of `F(i)`, every element
is `y/σy` (Hilbert 90), primes partition into ramified / inert / split, and a Theorem 3 (unread by anyone) gives a basis of the free
part through the split primes **and the class group**. That is D-H.2's prime-support law with the missing ingredient named: *which*
denominators actually occur at a field is a class-group question in `ℚ(√d, i)`, and `N₃(d)` — the least denominator divisible by 3 —
is the least norm at which the prime above 3 becomes principal up to conjugates. Phase A reads Theorem 3 before deriving A.4.
(A sub-agent's lead that a unit vector of denominator 96 over 167 lies outside FS-58's reach is wrong [me]: class 96 is in
`data/fs58/search-167/classes-180.out`; FS-58's 2520 was a bound, not a modulus.)

**Headline 5 — adjacent open ground.** `[Sokolov2018]` Thm 4 [sweep: §1, Lemma 1, §3 of the Russian original]:
`χ_√ℚ(ℝ²) = max_n χ(ℚ × √n·ℚ)`, with the value 3 called *"quite plausible"*. A 4-chromatic unit-distance graph inside
`ℚ × √d·ℚ ⊂ ℚ(√d)²` would refute that; FS-58's witnesses do not qualify (their coordinates mix `1` and `√d` in both slots), but the
census can ask it for free: E.5 checks whether any certified witness, or any refusing lattice, lies in a rank-2 layer `ℚ × √d·ℚ` up to
rotation. `[JoeNoble2023]` Thm 2.1's preamble is a printed `ℚ³` sibling of row 72's design rule (points with 3 in a denominator are
needed because `x + y + z mod 3` colours the rest) — a cross-reference for the ledger, proposed to the owner. `[KrebsSankar2024]`
Thm 1.4 (a topological lower bound of four without triangles) is recorded as a tool, not a route.

**Outside FS-61 and urgent — reported to the product owner, recorded in `BIBLIOGRAPHY.md` and `CLOSED-QUESTIONS.md` §1.1.**
`[Fischer1994]`, *A planar geometric graph of chromatic number four*, Congressus Numerantium 104 (1994) 73–79, Zbl 0836.05030 [me: the
zbMATH record, an author's summary with no reviewer]: for squarefree coprime `p ≡ 3`, `q ≡ 11 (mod 16)` with `pq ≡ 1 (mod 32)` the
plane over `ℚ(√p, √q)` *"has an additive 4-coloring"*, and *"since the graph `ℚ(√3, √11)²` contains finite graphs which require four
colors, it follows that the chromatic number of this graph is 4."* That is the statement of this project's Theorem B
(`CLAUDE.md` row 57), in print thirty-two years earlier, unknown to `[Moorhouse2010]`, `[Madore2015]`, Polymath16 and to us. Only the
summary has been read by anyone; the proof is unseen; the volume is held (search-only) by Michigan and Penn State. And `[Fischer1990]`
Thm 6 is G63 (`χ(F(t)ᵈ) = χ(Fᵈ)` for transcendental `t`, proved by evaluating at `t = 0`), with his Remark 1 the gap G63 names.
Neither changes FS-61; both change what the ledger may call ours.

**Negatives, recorded.** OpenAlex and Semantic Scholar disagree on these citation lists by factors of two to four (Madore 2015: 1
against 4; Payne 2009: 7 against 14), compared by identifier; Benda–Perles 2000, `[Johnson1987]`, `[Fischer1990b]`, `[Fischer1994]` and
`[Moorhouse2010]` have no record in either and cannot be walked. arXiv returned nothing for `"unit-distance graph" "quadratic field"`
or `"chromatic number" plane "real quadratic"` [sub]. **Not searched by anyone:** points of bounded height on norm-one tori beyond
`[AkhtariVaalerWidmer2025]`; theses (Auburn under Johnson); MathSciNet; Google Scholar's cited-by lists for the unwalkable five.

## §3 Derivations and readings (derivation first: G46)

### D-F — the frame, and the candidate class theorem [hand; assembled from prior art; phase A checks it by two independent computations]

1. `L(ℚ(√d))` is the table of §1. Phase A recomputes it two ways (Legendre symbols and the dyadic congruence; PARI's prime
   decomposition in `K`) for every squarefree `d < 2000`.
2. **Candidate theorem T4 (the jackpot):** *for every squarefree `d ≡ 11 (mod 12)`, `χ(ℚ(√d)²) ≥ 4`.* With §1's upper bounds it would
   complete the classification at the first three levels: **`χ = 2 ⟺ d ≢ 3 (mod 4)`; `χ = 3 ⟺ d ≡ 3 (mod 4)` and `d ≢ 2 (mod 3)`;
   `χ = 4 ⟸ d ≡ 11 (mod 24)`, or `d ≡ 23 (mod 24)` with `(d/7) ≠ −1`** — the conjecture's level-4 clause for every real quadratic field.
3. What is uniform across the family, and what is not [hand]. Uniform: `1/3 ∈ ℤ[U]` for every `d ≡ 2 (mod 3)` (3 splits in `K`; prime
   inversion, G55, `[Fischer1990b]`), so the *chain* half of the `ℚ(√11)` mechanism is free everywhere; the kernel's 3-adic barrier
   (row 72) holds everywhere, so every witness has a direction with 3 in a denominator; every field owns the 3-non-integral unit vector
   `u_d = ((d−1) + 2i√d)/(d+1)` of denominator `(d+1)/2 ≡ 0 (mod 6)` (from `(√d + i)²`; 11's chain vector `(−5 + i√11)/6` is its
   image under a quarter turn and a reflection). **Not uniform:** whether a finite three-colour forcer, or an outright refusing piece,
   exists at a size a solver can reach. `u_d`'s denominator grows with `d`, so a *uniform finite witness* does not follow from it.
4. **The stub's jackpot sentence is false as written** — "every real quadratic field with a usable plane at 7 has `χ = 4`": `ℚ(√2)`
   has 7 usable (`2 ≡ 3² mod 7`) and `χ = 2`; `ℚ(√7)` has `χ = 3`. The usable plane at 7 gives only the *upper* bound. The true
   statement is T4 restricted to the fields where the best bound is 4.

### D-H — the height floor, the sporadic sets, and the size law [hand, three lines each; O6 is the enumeration]

1. **Height floor.** A unit vector `((a + b√d)/N, (c + e√d)/N)` has `a² + c² + d(b² + e²) = N²`, `ab + ce = 0`. If it is not rational,
   `d ≤ d(b² + e²) ≤ N²`: **`N ≥ √d`**, and for fixed `N` the set `D(N)` of fields owning a class of least denominator `N` is finite
   and listable by solving for `d`. *Enumerate the parameter first* (`CLAUDE.md` § The gate): the atlas of phase A is this inverted
   enumeration, and it cannot silently omit a field the way a per-field scan at fixed depth can.
2. **Prime support** [prior art: the `p`-integrality of unit vectors, `[Fischer1990b]`]. An odd prime `p ≡ 3 (mod 4)` divides some
   class denominator iff `(d/p) = −1` (`p` inert in `F`, residue field `𝔽_{p²} ∋ i`); every `p ≡ 1 (mod 4)` can. *Proof of "only if", five lines:* a prime `𝔓` of `K` fixed by conjugation has
   `v_𝔓(u) = v_𝔓(ū)`, and `uū = 1` makes the sum zero, so **every unit vector is a unit at every stable prime**; for odd `p` with
   `(d/p) ∈ {0, 1}` every prime above `p` is stable, the coordinates `(u ± ū)/2`, `/2i` are integral there, and a reduced denominator
   divisible by `p` would force `p` into all of `a, b, c, e`. *"If"* is Hilbert 90 with a `z` of valuation 1 at one prime above `p` and
   0 at its conjugate (no principality needed — the class group decides only *which* `N` occur, `[ZanardoZannier1991]`). **The dyadic
   law:** for `d ≡ 3 (mod 8)` the dyadic prime is stable and `2 = 𝔭²` in `F`, so the same argument gives **`v₂(N) ≤ 1`** [proved: if
   `4 | N` then integrality up to `1/2` puts `a + b√d` and `c + e√d` in `𝔭² = 2𝒪`, so all of `a, b, c, e` are even]. For
   `d ≡ 7 (mod 8)`, **`v₂(N) ≠ 1`** — **proved at phase A (L4, §R-A; the implementer's proof, re-derived by hand by the owner)**: with `N ≡ 2 (mod 4)` the norm equation mod 4 forces as many odd entries among `a, c` as among `b, e`; none contradicts primitivity, two give `0 ≢ 4 (mod 8)`, and with exactly one odd in each pair the norm equation mod 8 makes exactly one of the two even entries `≡ 2 (mod 4)`, whereupon `ab + ce` is odd (odd entries aligned) or `≡ 2 (mod 4)` (crossed) and orthogonality fails. *The norm equation alone does not settle it mod 8; the second equation, read mod 4, does.* `[ZanardoZannier1991]` Thm 3 was read first and is not what decides it (it explains why powers of 2 occur at all: the dyadic prime splits). Both
   halves are tested on every atlas row (a failing row is a defect in the law or in the enumerator; report it, never patch around it).
3. **Size law** [derived shape; the constants are the census's to measure]. The lattice spanned by the axis and a class of
   denominator `N` has covolume `index·(2√d/N²)²` in the trace-form embedding (FS-58 D4), so a ball of radius `R` holds about
   `π²R⁴·N⁴/(4d·index)` points (the ball is a product of two discs, one per embedding); at matched *relative height* `N/√d` that is **proportional to `d`**. Reading **R-size**: *landing
   at a fixed solver budget is decided by size — the least 3-non-integral denominators grow like `√d`, the refusing ball grows with
   `d`, and `ℚ(√167)` is not arithmetically special for four colours, only large* (its analogue of 23's hit is 2–5 million points,
   which is where FS-58's solves went `Unknown`). Killing test: a field `d ≡ 7 (mod 8)` with a live coarse lattice (covolume ≥ `10⁻³`)
   whose balls stay 3-colourable to 10⁶ points.

### D-Q — dead lattices: the quotient filter is a theorem waiting for its statement [measured; derivation is phase A4]

FS-58's necessary filter — *a lattice with a 3-colourable finite quotient has a periodic 3-colouring, so no ball of it refuses* — killed
28 of 31 candidate lattices over 167, and at the opening it killed the best candidate over each of 11, 35, 59 (O5). In FS-58's records
the quotients that carry the colourings are overwhelmingly `Λ/mΛ` with `m ∈ {3, 6, 8, 9, 10, 12}` (`m = 9` the commonest over 23 and
167). `forms_mod3 = 0` on these lattices means the colourings are **not** affine: there is a second family of periodic 3-colourings,
defined on the lattice rather than on the 3-integral vectors, and **nobody has written down what it is**. A formula for it — read off
the verified models — would (a) turn the filter from a search over 24 random quotients into a criterion, (b) say which lattices over
167 can be live at all (FS-59's aiming input), (c) explain O5. Phase A4 attempts it under a timebox; "no pattern found" is a recordable
outcome.

### The readings the census must be able to separate (each with the measurement that can contradict it)

| id | reading | predicts | the measurement that can contradict it |
|---|---|---|---|
| **R-cycle** (FS-58 §R-B5) | a coarse saturated 3-non-integral lattice with a short odd cycle lands | refusal tracks least odd cycle | 59's lattice already contradicts it *as stated* (odd cycle 7, coarse, dead). Restated on **live** lattices only: among live lattices at matched ball size, does odd girth ≤ 9 against > 9 separate refusing from colourable? |
| **R-mod8** (the 2-adic reading, sharpened by O5–O6) | the direct route lands only at `d ≡ 7 (mod 8)`; at `d ≡ 3 (mod 8)` coarse lattices are dead and the chain route (a 3-integral forcer plus the chain, as at 11) is the only one | no **ball** refuses among the twenty `d ≡ 3 (mod 8)` fields at tier 1 (lattices over 11 that contain FS-58's witness are `Refused` *by inheritance* — that is not a ball and does not count) | one refusing ball at any `d ≡ 3 (mod 8)` |
| **R-L** (the mod-84 / local-bound reading) | landing depends on `L(F)` | different landing rates for `L = 4` and `L ≥ 5` among `d ≡ 7 (mod 8)` at matched relative height | 47 and 143 (`L = 5`) landing like their `L = 4` neighbours — already suggestive; the census gives the count |
| **R-C** (G60's ratio reading as a *decider* of finite landing) | a refusing lattice has least character mean above −1/2 | — | FS-58's `charmeans` on every refusing lattice: one reading below −1/2 contradicts it (FS-58 saw none above −1/2 in 1,505 pools over 23, which landed) |
| **R-size** (D-H.3) | the least refusing ball grows like a power of `d` at matched relative height | log–log slope of least refusing size against `d` in `[0.5, 2]` | slope outside, or no correlation |

R-mod8 and R-size can both hold (they describe different halves); R-cycle and R-size disagree on an `Open` lattice with a long odd
girth that refuses; R-L disagrees with all three on the `L = 5` fields. Every reading is scored at the close, won or lost, in those
words. **Each has a unit of analysis, and the tables name it** (§M1.8): R-cycle and R-C are statements about *lattices* (population:
rank-4 `Open`-or-`Refused` lattices at one tier); R-mod8, R-L and R-size about *fields*. **R-mod8 has two strengths, scored
separately:** (a) *no tier-1 ball over any `d ≡ 3 (mod 8)` refuses* — a null at a budget; (b) *every tier-1 lattice over those
fields is `Colourable` by certificate, except — over 11 — the lattices that contain FS-58's witness* — the barrier-shaped finding,
which by downward inheritance needs certificates only on the finest lattices and would make A.7's rule a theorem candidate for the
class. The exception is the point: FS-58's 204-point witness over 11 draws on **ten** classes (denominators 1, 5, 6, 10, 15, 25, 30,
50, 75, 150), so whatever refuses over `d ≡ 3 (mod 8)` is rich in classes, not coarse — A.5 records which tier-1 lattices over 11
contain it, and D.0 asks the same *recipe* of 35 and 59.

## §4 Decisions (choice · alternative weighed · why · confidence, and what would change it)

| # | choice | alternative weighed | why this one | confidence |
|---|---|---|---|---|
| A | **The census family is the 40 squarefree `d ≡ 11 (mod 12)` below 500**; every other `d` appears only as a control | the stub's "squarefree `d < 500`" (about 300 fields) | outside the family `χ ≤ 3` is a theorem, so a scan there can only measure the instrument; seven named control fields do that at 2 % of the cost | high |
| B | **Depth is an explicit, recorded tuple, identical for every field in a tier**: tier 1 = (classes to `NMAX = 180`; lattices = the axis plus one or two classes with lcm ≤ 180, saturated; odd girth exact to length 15 or a 400,000-point BFS cap, whichever first, with `none_up_to` recorded; quotient filter = FS-58's, 24 quotients, 30 s each; balls at `R = 1.5` then `1.8`, point cap 600,000, solve wall 600 s). Tier 2 (phase E, non-landed `d ≡ 7 (mod 8)` fields only) = (`NMAX = 420`, cap 3,000,000, wall 1,800 s) | depth relative to the field (`NMAX = c·√d`) | a fixed `NMAX = 180` is already ≥ 8`√d` for every `d < 500`, reproduces FS-58's records exactly (the phase-0 regression), and keeps one comparable column; relative height `N/√d` is *recorded* per lattice so the analysis can condition on it | medium — if tier 1 lands nothing above `d ≈ 250`, tier 2's definition is what matters and is re-examined then. **Measured at phase 0:** exact odd girth is ~900× the rest of `lattices` (1,648 CPU-s against 1.8 s at `d = 11`), about an hour of wall for the 40 fields — kept ON for the census, because R-cycle is scored on it; `--no-girth` is for the FS-58 regression only. Every record carries `odd_girth.status` ∈ {computed, bipartite, not asked} with `bfs_cap`, `explored`, `levels` — never a bare null |
| C | **A lattice is identified by a canonical key** (Hermite normal form of a basis over the common denominator), never by the class spec that produced it | FS-58's spec strings | many specs give one lattice (`q1+60.1` and `q1+12+60.1` over 119 are the same 28 vectors); FS-58's "38 distinct lattices (39 lines; one listed twice)" is what spec keys cost. The spec stays as a *name*, and one spec per lattice — the union of all classes it contains — is what is handed to FS-58's frozen commands | high |
| C′ | **A lattice's state is one axis with certificate kinds, inherited along inclusion; "3-integral", "bipartite" and "dead" are three kinds of one state** (§M1) | FS-58's separate flags (`bipartite`, `three_integral`, `forms_mod3`, a filter verdict) | the flags are one fact — *a 3-colouring of the whole lattice graph is in hand* — in four costumes, and keeping them apart hid that a 3-non-integral lattice with a form mod 3 needs no solver and that one certificate on a fine lattice closes every lattice under it | high |
| D | **The atlas (inverted enumeration by denominator) runs before any scan, to `N ≤ 420` and `d < 2000`** | per-field `classes` only | D-H.1: an inverted enumeration has a row for every field whether or not anything was found there; and it prices tier 2 before it is run | high |
| E | **Controls run before the census and are paired**: three-chromatic fields `d = 7, 19, 31, 43` and two-chromatic `d = 2, 5, 13` scanned with the 3-integrality filter **off** must yield zero refusals (and the two-chromatic ones only `Bipartite` lattices), beside the *same filter-off code path* at `d = 47`, which must refuse | a negative control alone | a control that cannot go red has not been tested by passing; the filter-off path at 47 shows the path can refuse | high |
| F | **Every field with a `Refused` ball is carried to a certificate** (smallest refusing ball first), by FS-58's full path; an uncertified refusal is reported as `Refusal claimed`, never as landed | certify a sample | a census whose landings are solver claims is a list of rumours; extraction is minutes per field (O3) except for balls above ~300,000 points, which are checkpointed `extract` runs | high |
| G | **The chain route for `d ≡ 3 (mod 8)` is in scope as phase D, conditional on R-mod8 surviving phase B, and timeboxed to two fields (35, 59)** | direct route only, as the stub says | if R-mod8 holds, half the family — all of it `L = 4`, so every landing an exact value — is out of the direct route's reach, and the census would be silent on it; two fields is enough to learn whether 11's mechanism generalises, and no more is spent until that is known | medium — if phase B finds a refusing ball at `d ≡ 3 (mod 8)`, phase D is replaced by certifying it |
| H | **167 is scanned at tier 1 like every other field and gets no tier-2 time** | exclude it; or spend here | the table needs its row under the same definition; deeper work on 167 is FS-59's and must be aimed by this milestone's explanation, not run ahead of it | high |
| K | **No Lean/kernel deliverable** | one kernel instance (say 119) through FS-58's `UDCert` pipeline | FS-60 exists to build one certificate type over `Adjoin d ℤ` that consumes every witness at once; a one-off module here duplicates its design work and holds the machine for a build. FS-61 owes FS-60 only the witness format | high |
| M | **Records are JSONL, one line per unit of work, flushed and fsynced, resumed by re-running the same command; the census table is *derived* from records by one command and never hand-edited** | a hand-maintained table | the table is the consumer surface (FS-59, FS-60, the ledger); a derived table cannot drift from its records, and its regeneration is a gate item | high |

## §5 Standing rules — a violation fails the phase whatever its results (each with its reason; all are `CLAUDE.md` rules)

1. **Checkpoint and resume, with the resume command written in the phase record *before* launch** (`CLAUDE.md`'s PROTECTED paragraph:
   a 19-hour run was lost to state held only in memory). The audit question for every run over ~15 minutes: *if this dies now, what is
   redone?* Here: one JSONL line per (field, lattice, radius); `extract` checkpoints in its `steps.jsonl`. Checkpoints live under
   `data/fs61/`, never under `build/` (another agent's cleanup deleted a live job's resume file there). **No `timeout` wrapper on a
   solve** — killing the wrapper kills the child; use the tools' own walls.
2. **One heavy job at a time.** A 16-worker `scan` is one job. Never run an `extract` beside a `scan`.
3. **Launch long jobs with `setsid`, write the pgid to a file, stop by pid or pgid, and verify by effect** — the named pid gone from
   `ps` *and* the record file's digest static across ten seconds. **Never `pkill -f` / `pgrep -f`** (they match the shell that runs
   them; eight recorded incidents), never a waiter whose condition is a pattern match, and check that a waiter's condition is *false*
   when you arm it. Launch from a snapshot copy of any shell script; never edit a running one.
4. **Verdict words are fixed, with the trust level in the brackets.** For a colourability question: `Colourable (colouring verified)`
   — the model was checked on every edge; `Refused (solver claim)`; `Unknown (budget)`; `Over cap (not asked)`. For a forcing question
   (phase D): FS-58's `Separable (colouring verified)`, `Forced (solver claim)`, `Unknown (budget)`. A field is `Landed (certified)`
   only after the frozen checker prints `CERTIFIED`. **No `Unknown` is ever read as a refusal or as anything else** — FS-58 met a
   4,609-point ball that is certainly 3-colourable and ran to `Unknown`.
5. **Break the symmetry before any SAT ask** (origin colour 0, one neighbour colour 1 — FS-58's `_colour_ball` does; keep it), and
   treat any verdict from an unbroken encoding as a measurement of the encoding.
6. **A refusal is robust and a colourable verdict is suspect here** — edges are *measured* (exact integer arithmetic decides every
   one), so the only possible error is a missed edge, which makes colouring easier. Hence every `Colourable` verdict re-checks its
   model against the full exact edge set, and the saturation (every unit vector of the lattice is a generator) is asserted, not
   assumed.
7. **Every new check ships a planted failure that is seen to fire, and both outcomes of every control are shown reachable** (G21).
   The phase record names each plant and the line that went red.
8. **Gate exit statuses are read from the command, never through a pipe**; nothing whose cleanup matters is piped into `head`.
9. **Never `lake build`** (bare or named); this milestone builds no Lean at all — if you find yourself building, stop and ask.
10. **Commit incrementally**, staging your own paths by name after `git diff -- <path>`; never `git add -A` or `commit -a` (it has
    swept a neighbour's work into the wrong commit twice here). The product owner edits `CLAUDE.md`, `plans/FRONTIER-STUBS.md` and
    several stubs concurrently: leave those alone and propose edits in your report. If `.git/index.lock` is held, wait and retry.
11. **On any unexplained process crash: halt and report.** Do not diagnose past it.
12. **A number travels with what it measures** — units, machine, conditions, population, budget; when two numbers are compared exactly
    one thing differs. Timings are CPU seconds on the named machine.
13. **No subagents** (§0).
14. **Prior art found while working goes into `BIBLIOGRAPHY.md` the same day**, with its read status per section; an abstract is not
    a reading.
15. **The five halts.** Stop, write down what you saw, and report — do not repair and continue — when: a control field refuses (0.4);
    a known witness's lattice comes out `Colourable` (A.5); a monotonicity check fails (B.1b); a *proved* law is violated by the atlas
    (A.3); any process dies unexplained. Each means the instrument is wrong in a direction that would flatter the census, and results
    gathered after it are worth nothing until it is understood.
16. **Each phase ends with a phase record**, `data/fs61/records/phase-<id>.md`: one row per gate item — *item · the command run,
    pasteable · the artifact's path · the line of output that shows the pass · exit status* — plus the machine, the CPU time, the
    resume command written before launch, every plant and the line it turned red, and anything not landed, in those words. The
    product owner scores from this file by re-running its commands; a summary that is not backed by a row is not read as evidence.
    If a gate item cannot go green, say so in its row: **a rung that does not land is reported as not landed, never rescoped.**

## §6 The phases and their gates (what · verified how · pass condition)

*An item is green only when the product owner has opened the named artifact. Sizes: phase 0 — 8 items; A — 9; B — 8; C — 8 per field
plus 2; D — 7; E — 7; F — 5.*

### Phase 0 — the instrument (`tools/fs61_census.py`; half a day)

Build the census driver as a thin layer over FS-58's functions (`import fs58_search`, rebinding its `outdir` to
`data/fs61/fields/<d>/`; `fork` start method, as FS-58 uses, so workers inherit the rebinding — Python 3.14's default is
`forkserver`, which would not). `argparse` throughout, with `--help` on every subcommand (O7). Subcommands: `frame`, `atlas`,
`lattices`, `filter`, `scan`, `land`, `table`, `status`, `selftest` (schemas in §7). **The surface, fixed before code (§M3):**
* the bare call is the common one: `fs61_census.py scan 143` means tier 1; `--tier 2` is the exception;
* every command prints its headline first (what it will do, how many units, how many already on disk) and ends with one summary line
  of counts — `DONE 37 balls: 3 Refused, 31 Colourable, 2 Unknown, 1 Over cap; 12 skipped (on disk)`. Silence is never success;
* resume is **re-running the same command**; finished units are read back from the JSONL and skipped; `Unknown` and `Over cap` units
  are re-asked only when the wall or cap is larger than the one recorded (FS-58's rule);
* `status` prints, per field, where it stands — lattices by state, balls asked, witness or not — from the records alone, so nobody
  reads JSONL to learn progress;
* a check that fails names the culprit and exits non-zero: `DEFECT control field d=7: lattice <key> ball R=1.5 Refused — a
  3-chromatic plane cannot refuse`; `DEFECT monotone: <key> Refused inside <key′> Colourable (certificate <kind>)`. Exit codes: 0
  pass, 1 a check failed, 2 usage;
* verdict strings are exactly §7's, character for character, so one `grep -F` finds every instance;
* `table` writes, for every field not landed, the pasteable command that would deepen it (the next tier, or the re-ask of its
  `Unknown`s) — a null that does not say what would turn it into an answer is a dead end.

| # | what | verified how | pass condition |
|---|---|---|---|
| 0.1 | FS-58 regression, lattices | for each of FS-58's 14 fields at FS-58's own depth (180; 300 for 23; 420 for 167), canonicalise both FS-61's lattices and the `saturated` vector lists in `data/fs58/search-<d>/saturate.jsonl` | identical sets of canonical keys, all 14 fields; the log prints per-field counts of records against distinct lattices |
| 0.2 | FS-58 regression, refusals | the five refusing balls of FS-58 (47 `q1+12+60`, 71, 95, 191 at `R = 1.5`; 23 `q1+q5+12.1+60.2` at `R = 1.3`) re-asked through `scan` | five `Refused (solver claim)`; point and edge counts equal FS-58's records |
| 0.3 | FS-58's certificates still certify | `python3 tools/fs58_check_witness.py --radicand D data/fs58/witness-D/witness.json` for `D = 23, 47, 71, 95, 191`, exit status captured directly | five `CERTIFIED`, exit 0 |
| 0.4 | paired negative controls (decision E) | filter-off `scan` at tier 1 on `d = 7, 19, 31, 43` and `d = 2, 5, 13`; the same command on `d = 47` | zero `Refused` on the seven; every lattice over 2, 5, 13 `Bipartite`; ≥ 1 `Refused` at 47. A refusal at a control field is an **instrument defect**: halt and report. **What this control can and cannot see** (implementer's finding, accepted): over `d = 7, 19, 31, 43` no lattice is `Open`, by arithmetic — `(d/3) ≠ −1`, so 3 divides no class denominator (D-H.2), every lattice is 3-integral and carries a form mod 3 — and no three-chromatic field can be otherwise. So the seven fields test *whether the ball–edge–CNF–solver path invents refusals*, on graphs known colourable, and say nothing about certificate-free lattices; that population is covered only by 47. **State the population as balls ASKED**: phase 0's seven fields hold 1,350 ball records of which 550 were asked (525 verified colourable, 25 `Unknown`) and 800 are `Over cap (not asked)` — zero refusals among 550, not among 1,350 |
| 0.5 | canonical keys | `selftest`: two specs of one lattice (119: `q1+60.1`, `q1+12+60.1`) → one key; a different lattice → a different key; a permuted, sign-flipped basis → the same key | all three, plus **three plants, one per clause** (owner's ruling 2026-09-20 on the implementer's finding): the key is a function of the *lattice*, and these generating sets are negation-closed, so dropping, doubling or mutating one generator leaves the ℤ-span — hence the key — unchanged (all 28 single deletions of one lattice checked); a corrupted generator set is therefore caught by `lattice_record`'s saturation assertion and by `generators_sha256`, never by the key, and the key comparison is shown able to fire on a genuinely smaller lattice. *(As first written this row asked the key to detect a non-saturated list, which it cannot.)* |
| 0.6 | saturation is asserted | for every lattice record, every unit vector over its denominator `M` lying in the lattice is a generator (recomputed independently of FS-58's `_saturate_one`: by enumerating `units_d(M, d)` and testing membership through the HNF) | 0 violations over the 14 regression fields; the plant (one generator removed) is caught by name |
| 0.7 | resume | start `scan` on 143 at tier 1, stop it by pid after the first finished record (rule 3), re-run the identical command | no duplicate keys, no lost finished record, the run completes; the stop is verified by effect and the verification is in the log |
| 0.8 | FS-58 untouched | `git status --porcelain data/fs58 tools/fs58_*` | empty, at the end of this and every later phase |

### Phase A — derive before scanning (no SAT solver; half a day, A4 timeboxed at three hours)

| # | what | verified how | pass condition |
|---|---|---|---|
| A.1 | the frame (D-F.1) → `data/fs61/frame.jsonl`: every squarefree `d < 2000` with `d mod 4, 3, 8`, the stable small primes, `L` as a **bracket** `L_lower, L_upper` with its reason — `2`, `3`, `4 (dyadic)`, `4 (7)`, `5 (11\|19)`, or an open bracket where the deciding plane's own chromatic number is undecided (owner's ruling 2026-09-20 on the implementer's finding: below 2000, `167` and `1319` are `[6, 8]`, and **`887, 1055, 1823` are `[5, 8]` because 31 is usable there and five is still open at 31** — writing "`L ≥ 6`" would be wrong for those three, and FS-57's side digit at 31 has them as named consumers) | two computations: congruences and Legendre symbols; PARI (`gp`) prime decomposition of 2, 3, 7, 11, 19, 23 in `K = ℚ(√d, i)` | they agree on every row; the 40-field list of §1 is reproduced exactly; the known values (`χ = 2`: 2, 5, 13; `= 3`: 3, 7, 19; `L(167) ≥ 6` with first usable primes 23, 43) are rows |
| A.2 | the atlas (D-H.1) → `data/fs61/atlas.jsonl`: for every squarefree `d ≡ 11 (mod 12)`, `d < 2000`, the class denominators `N ≤ 420` with orbit counts, `v₂`, `v₃`, and `N₁(d)` (least non-rational), `N₃(d)` (least with `3 \| N`) | inverted enumeration (solve for `d`); cross-check against FS-58's `classes(D, NMAX)` | exact agreement of (denominator, orbit count) lists with `classes` on FS-58's 14 fields and on 119, 155, 299 at `NMAX = 180`; `D(6) = {11, 35}` *(within the family; over every squarefree `d` it is `{2, 11, 14, 17, 35}`)* and **`D(12) = {23, 47, 71, 95, 119, 143}`** *(over every squarefree `d`, as is `D(24)`; `D(18)` is again a within-family statement)* reproduced; the plant (drop the orthogonality condition `ab + ce = 0`) changes `D(12)` and is caught |
| A.3 | the laws of D-H.2, tested on every atlas row | a script over `atlas.jsonl` | height floor `N ≥ √d`: 0 violations; odd `p ≡ 3 (mod 4)` divides a denominator only if `(d/p) = −1`: 0 violations; `v₂(N) ≤ 1` for `d ≡ 3 (mod 8)` (proved — a violation is an enumerator defect): 0 violations; `v₂(N) ≠ 1` for `d ≡ 7 (mod 8)` (observed): 0 violations **or the violating rows printed in full and the law restated** |
| A.4 | hand derivation of the `d ≡ 7 (mod 8)` half of the dyadic law (`v₂(N) ≠ 1`), after reading `[ZanardoZannier1991]` Thm 3, in `§R-A` of this plan, status `[hand]` | read by the product owner | a proof, or an honest "not derived" with what blocked it |
| A.5 | every known witness's own lattice is **not** `Colourable` (a control on the filter: a non-3-colourable finite subgraph cannot sit in a colourable lattice) | the ℤ-span of the points of `data/fs58/witness-{11,23,47,71,95,191}/witness.json` and of `data/fs61/pricing/witness-119/witness.json`: canonical key, covolume, saturation, quotient filter | seven `Open` (or `Refused`); a `Colourable` here is an instrument defect: halt and report. The 11-witness's lattice and covolume are recorded — they are phase D's starting point |
| A.6 | the killing-quotient table (D-Q) → `data/fs61/dead-quotients.md`, **from FS-58's existing `qscreen.jsonl` files, no new solving** | for each lattice with a verified colourable quotient: the least-order such quotient, its Smith form, the prime support of its order; tallied by `d mod 8` and by 3-integrality | the table regenerates from the records by one command; counts reconcile with FS-58's README (28 dead of 31 over 167 — **population: the README counts the 32 non-bipartite lines of `saturate-2520.out`; its verdict file adds `q1+q5+132` for 29 of 32; phase A agrees with every one of its 33 verdicts**) |
| A.7 | the rule behind the non-affine quotient colourings (D-Q), timebox three hours. **The shape a rule must have (§M2):** a homomorphism `ρ : Λ → A` onto a *small* finite abelian group, a set `T ⊂ A` with `ρ(S) ⊂ T` for every generator, and a proper 3-colouring `f` of `Cay(A, T)` — Theorem A's shape (row 57), of which the kernel barrier is the case `A = 𝔽₃`, `T = 𝔽₃ˣ`. A solver's colouring of `Λ/mΛ` is one of many and hides `A`; so **compute the minimal colourable quotient**: for each dead lattice, the least-order quotient of `Λ/mΛ` (through subgroups containing no generator) that is still 3-colourable, by exhaustive search over subgroups of index ≤ 36 — tiny graphs, no budget issue | three lattices first (59 at `Λ/9Λ`; 35 at `Λ/6Λ`; one over 167), then every dead lattice of A.6's table: the isomorphism type of `A_min`, `|T|`, the number of proper colourings of `Cay(A_min, T)` | one of: a small `A_min` shared by ≥ 90 % of dead lattices, with `ρ` identified arithmetically (a residue at 2, at 3, at 9, or a product) and the class statement it suggests; the same for a sub-family; "no small quotient: `A_min` is large or varies", with the table. Any rule is a `[reading]` until its local obligation — `ρ(s) ∈ T` for **every** unit vector of the class, a congruence on `(a, b, c, e, N)` — is proved |
| A.8 | the size-law inputs: per (field, lattice) predicted ball points at `R = 1.5` from the covolume, beside the relative height `N/√d` | `lattices` records (phase B computes them; here the formula is fixed and tested on FS-58's known balls) | predicted against actual point counts within 15 % on FS-58's recorded balls (8,629; 13,605; 47,597; 53,177; 283,485; 440,077) |
| A.9 | predictions P1–P10 (§8) are in the committed plan before phase B's first solver call | `git log` order | the commit carrying §8 precedes the first `balls.jsonl` line |

### Phase B — the census scan, tier 1, all 40 fields in ascending `d` (an afternoon; checkpointed per ball)

Per field: `lattices` → `filter` gives each lattice its state on the **one axis of §7** — `Colourable (form mod 2)`, `Colourable
(form mod 3)`, `Colourable (periodic colouring verified)`, or `Open` — cheapest certificate first, **and top-down**: a colouring
certificate on a lattice is inherited by every sublattice of it, so the finest lattices are filtered first and everything
under a colourable one is closed without being asked (§M1.3). Then `scan` the `Open` lattices bottom-up, in order of ascending predicted
points: `R = 1.5` for **every** `Open` lattice under the cap (the census's comparable column), then `R = 1.8` for those colourable at
1.5; a `Refused` ball closes every lattice above it. Onset radii (`R = 1.0, 1.2`) are asked only of refusing lattices and with a 120 s
wall, because the band just under the threshold stalls (O3, O4). Lattices of rank below 4 are recorded and filtered, never scanned
(FS-58 found the layered pools dead or poor in odd cycles); E.5 reads them.

| # | what | verified how | pass condition |
|---|---|---|---|
| B.1 | completeness | `table --check` | 40 fields; per field `#lattices = #Colourable (by certificate kind) + #Refused + #Open`; every rank-4 `Open` lattice has an `R = 1.5` record, an inherited verdict with the key it was inherited from, or `Over cap (not asked)`; no field skipped silently — a field with zero `Open` lattices says so |
| B.1b | the two monotonicity controls (§M1.3–4) — they can fail, and a failure is an instrument defect: halt and report | `table --check` | no pair `Λ ⊂ Λ′` with `Λ` `Refused` and `Λ′` `Colourable`; no lattice with a `Colourable` ball at a radius above a `Refused` one; every 3-integral lattice has a form mod 3 (the kernel barrier, row 72, seen by the instrument). Plant: flip one verdict in a scratch copy and watch the check name the pair |
| B.2 | every `Colourable` verdict is verified | each record carries the sha256 of its model; `scan --reverify` re-reads a random 10 % of models and checks every edge | 0 failures |
| B.3 | every `Colourable` lattice carries its certificate | the form (four residues) or the quotient (matrix, order) with the colouring's sha256; `filter --reverify` on all of them, against the **full** generator set | 0 failures |
| B.4 | the priced facts reproduce | 119 `q1+12+60.1` and 143 `q1+q5+12+60` | `Refused (solver claim)` at `R = 1.5` with 13,605 and 283,485 points |
| B.5 | budget honesty | the log, and `census.md` | every `Unknown (budget)` and `Over cap` is listed per field in the table's notes column; none appears in any count of refusals or colourables; **and `census.md` has a column `balls asked / over cap / unknown` per field** (owner's addition 2026-09-20: at phase 0, 59 of 47's 110 tier-1 ball records were over cap and 800 of the controls' 1,350 — so "not landed at tier 1" will usually mean *most lattices were too fine to ask*, and a reader must see that beside the verdict, not in a note) |
| B.6 | the table regenerates | `table` twice | byte-identical `data/fs61/census.md` and `census.jsonl` |
| B.7 | machine and cost | the phase record | machine named, workers, CPU seconds per field, the resume command that was written before launch |

### The owner's re-plan after phase B (2026-09-20) — read this before phases C–E; where it differs from the rows below, it governs

**Phase B is accepted.** Nine fields refuse at tier 1 — 11, 23, 47, 71, 95, 119, 143, 191 and **359 (new; `L = 4`)** — recounted by
the owner from the raw ball records; `table --check` re-run (0 defects), the table byte-identical on regeneration. **P2 lost** (11
refuses by the direct route, four balls on one ten-class lattice, `M = 30`, 108 generators) and **P3 lost** (8 of 20, not ≥ 10).

**What tier 1 did and did not measure — the owner's reading of the `balls asked` column, which is the finding of this phase.** 124 of
343 ball records were asked. The 24 fields that asked nothing are two different populations, and the census must never merge them:
* **eleven fields where every tier-1 lattice is closed by a certificate** (107, 227, 299, 347, 371, 383, 395, 419, 443, 467, 491) —
  a null *by certificate*: no witness exists among the lattices of this depth, and only deeper lattices (more classes, larger
  `NMAX`) can land them. More solver time at tier 1 is worth nothing there;
* **thirteen fields whose `Open` lattices were all over the cap at `R = 1.5`** (35, 59, 83, 131, 167, 179, 203, 239, 251, 323, 407,
  455, 479) — a null *by budget*. At eight of them (131, 167, 179, 203, 239, 407, 455, 479) the smallest `Open` lattice fits under
  the same 600,000-point cap at `R = 1.0` (a ball holds `∝ R⁴` points: `× 0.41` at 1.2, `× 0.20` at 1.0); at the other five it
  fits under tier 2's cap. Every refusal on record occurs at a radius between 1.0 and 1.5 (11 refuses at 1.0; 47 at 3,565 points;
  119 at 1.2 and not at 1.0).

**Rulings.**
1. **Order from here: C, then B′, then C again on anything B′ lands, then E, then F.** Results first: nine certifications.
2. **Phase B′ — tier `1b`, the radius ladder under the same cap** (a NEW tier id in `tiers.json`; tier 1's definition does not change):
   for every rank-4 `Open` lattice whose `R = 1.5` ball is `Over cap (not asked)`, ask `R = 1.2` if its predicted points are under
   the cap, else `R = 1.0` if those are; same cap (600,000), same wall (600 s), all forty fields under the one definition — **167
   included, which is decision H applied, not broken**. Gate: B.1–B.7 re-read at tier `1b`, plus **B′.1: the predicted-points
   formula decides which radius is asked, and the record carries predicted beside actual** (A.8's 15 % bound is the control).
3. **Decision G is revised: the chain route (phase D, items D.1–D.6) is NOT run.** It was conditional on R-mod8 surviving phase B,
   and R-mod8 lost at its first askable field. What replaces it is what decision G itself named — certify 11's ball (phase C) — and
   **E.1's tier 2 is extended to BOTH halves of the family**: every field not landed after `1b` that still has an `Open` lattice.
   D.0 survives as one table in phase E: for each `d ≡ 3 (mod 8)` field, whether a lattice with 11's class recipe (denominators
   dividing 30) exists there, and its state.
4. **Tier 2 must be sized by memory before it is launched** (`CLAUDE.md` § Building: *the batch is the plan; the cap is a
   backstop*): measure one worker's peak RSS on a ball near the 3,000,000-point cap, and set the worker count to
   `available memory / peak`, never to 16 by default — this machine has been taken down by exactly that, and an unexplained crash is
   a halt. Write the measurement in the phase record before the launch.
5. **The two-hour field budget records a verdict of its own, `Not asked (field budget)`**, not silence and not `Over cap` (the
   implementer's departure, accepted in substance: `Over cap` would be a verdict the instrument did not earn; but B.1 wants every
   `Open` lattice accounted for by a record, so the honest record is a third string). It joins §7's vocabulary table.
6. **Census language, binding on `census.md` and on the close:** a field is `Not landed at tier T (by certificate)` when it has no
   `Open` lattice at that tier, and `Not landed at tier T (by budget: k Open lattices, none askable)` otherwise. One phrase for
   both would be the 1,350-against-550 error again, one level up.

### Phase C — certify every refusal (FS-58's full path; minutes per field, up to an hour for balls over 300,000 points)

For each field with a `Refused` ball, smallest ball first, into `data/fs61/witness-<d>/` with a `run-all.sh` modelled on
`data/fs58/witness-47/run-all.sh` (run from the repository root after `source scripts/dev-env.sh`; O7). Balls under ~100,000 points:
`direct-witness`; larger: the checkpointed `extract` (resume = the same command).

| # | what | verified how | pass condition |
|---|---|---|---|
| C.1 | the certificate | `tools/fs58_check_witness.py --radicand D witness.json`, exit status captured directly | `CERTIFIED`, exit 0 |
| C.2 | planted faults | `… --controls witness.json` | `CONTROLS ALL PASS`: the faithful twin certified, all twelve plants refused **for their named reasons** |
| C.3 | wrong radicand | the same files with `--radicand D'`, `D' ≠ D` (use `D + 12`) | `REFUSED`, non-zero exit |
| C.4 | second opinion | `tools/fs58_recheck_witness.py D witness.json` (exact `Fraction` arithmetic over all pairs; three solvers outside the generator's) | `RECHECK PASS` |
| C.5 | exactly four | a 4-colouring of the witness graph, found by any solver and verified on every edge by a ten-line standard-library script | verified; stored as `colouring4.json` |
| C.6 | the barrier is met | count of edges whose direction has 3 in its reduced denominator | > 0 (row 72 says it must be; zero is a defect) |
| C.7 | the value | from `frame.jsonl` | the README states `χ = 4` (upper bound prior art, named) or `4 ≤ χ ≤ L`, never more |
| C.8 | reproducibility | `run-all.sh` from a clean checkout of the witness directory | regenerates byte-identical `witness.json` (FS-58's generator is deterministic) |
| C.9 | (once) a vertex-minimality note | per witness: is it 1-minimal? | recorded yes/no; not required |
| C.10 | (once) the owner's decorrelated recheck | the product owner's own script | done by the owner, not the implementer |

**The owner's rulings after phase C (2026-09-20; phase C ACCEPTED — scored by artifact: frozen files untouched, plan edits confined
to §R, all nine `witness.json` byte-identical to the ones C.10 passed (`data/fs61/owner/recheck-all.out`), C.1 re-run by the owner
at 11 and 359 with exit 0 read directly, C.2's thirteen rows read at 359, C.7 read against `frame.jsonl` at all nine).** They
govern the table above wherever they differ, and apply to every field equally, including fields phase B′ has not landed yet.

1. **C.4 was two claims under one pass condition, and the plan contradicted itself** (the implementer's proposal, accepted; the
   defect is the plan's and the owner approved it). `tools/fs58_recheck_witness.py` (frozen; sha256 `880f5bc48ef39b4c…`) is
   straight-line: (i) every pair in `Fraction` arithmetic equals the file's edge list, else FAIL; (ii) Lingeling, CaDiCaL 1.5.3 and
   MapleChrono each refuse three colours, else FAIL; (iii) deleting the pinned edge's second vertex leaves a 3-colourable graph,
   else FAIL. Step (iii) is a **minimality** control — it presumes the pinned vertex is critical — while C.9 says minimality is
   *recorded, not required*. So:
   * **C.4a, the second opinion proper = steps (i) and (ii). Required.** Evidence: `RECHECK PASS`, **or** the line
     `RECHECK FAIL: deleting vertex … leaves a graph that still refuses` — in that file, at that hash, the line is reachable only
     after (i) and (ii) returned without failing. *A correction to the phase record, which says the second opinion proper is
     "not reached" at 95: the control runs **last**, so at 95 it was reached and passed; what was lost is only the PASS line's
     wording.* C.10 (independent code, two further solvers) reads `RECHECK PASS` on that same file.
   * **C.4b, pinned-vertex criticality = step (iii). Required iff C.9 records the witness 1-minimal; otherwise recorded.** A red
     C.4b on a 1-minimal witness is a defect in the generator or the recheck and halts.
   * **`Landed (certified)` = C.1–C.3, C.4a, C.5–C.7 green.** Under this rule `d = 95` is landed; its C.4b is recorded red, with
     the diagnosis already in the record. The driver's diagnosis line must stop advising *"resume with a larger
     `--deletion-budget`"* — the record itself shows a resumed deletion can never reach 1-minimality — and say *regenerate from
     scratch on a smaller ball (`--ball-rank`)*.
   * `land 95 --ball-rank 2` **is run**, as a nicety and not as a repair: `d = 95`'s state no longer depends on it, so it is not
     tuning an object until a check agrees; it is a from-scratch 1-minimal witness on a 6,997-point ball, wanted by FS-60, whose
     kernel cost tracks witness size (FS-58's 95 witness is 1,068 points and not 1-minimal). Both witnesses stay.
2. **C.8's pass condition, reworded** (accepted): byte-identical `witness.json` from the committed witness **directory**; where
   C.9 records a stopped deletion, the gitignored `steps.jsonl` checkpoint is part of what makes that true, and `run-all.sh` says
   in its header what a rerun without it produces (the larger core-round witness with `--stop-deletion`, a smaller 1-minimal one
   without).
3. **The re-ask rule for deletion** (accepted; the sibling of §6's rule for `Unknown` balls): a `--deletion-budget` larger than the
   one a landing record carries means **regenerate**; the same or smaller budget is a no-op. And because the frozen `extract`
   resumes a deletion at a stale scan position, **a stopped deletion is never finished later** — only a from-scratch run can be
   1-minimal.
5. **The closing task is accepted** (2026-09-20; `5034212`, `68e9fd9`; scored by artifact: frozen files untouched, all nine
   `witness.json` byte-identical to the ones C.10 passed, `census.md` reads 9 `Landed (certified)` of 40, `selftest` re-run by the
   owner — 7 sections, 0 failures). The second implementer's judgement call stands: a *required-but-red* C.4b keeps the field
   `Landed (certified)` and exits non-zero as a named defect — the refusal is sound either way, and the contradiction is between two
   recorded facts that a person must resolve. **`land 95 --ball-rank 2` was declined on a measurement and the decline is
   accepted**: at `d = 95` the core rounds run ~90 s each with a slow tail (6,997 → 3,308 → 2,958 → 2,808 → 2,735) on every ball
   tried, so a from-scratch 1-minimal witness there is priced in hours; FS-60 is told that 95 is the expensive field. Not pursued.
4. **C.9 gains a clause** (accepted): *a witness that is not 1-minimal is not a weaker certificate* — a refusing set refuses
   whether or not it is minimal; minimality buys size (the checker's time, FS-60's kernel cost), never soundness.

### Phase D — the other half: `d ≡ 3 (mod 8)` — **NOT RUN (owner's re-plan above, ruling 3): its condition, R-mod8 surviving phase B, failed at `d = 11`.** The rows below are kept as the record of what was planned

Run only if phase B leaves R-mod8 standing. FS-58's chain route at 11: a 3-integral pool (denominators dividing 10) whose capsule
pieces force `c(0) = c(3u)` from ~2,700 points; `1/3 = 1 + 1 + v + v̄`; four transported copies. Generalise in **new** files
(`tools/fs61_chain.py`); `tools/fs58_witness.py` hardcodes `D, N = 11, 10` and stays frozen.

| # | what | verified how | pass condition |
|---|---|---|---|
| D.0 | does 11's recipe transfer? | the class recipe of the tier-1 lattices over 11 that contain FS-58's witness (A.5), rebuilt over 35 and 59 from the classes of the same denominators where they exist | each rebuilt lattice's state: `Colourable` by certificate (the recipe does not transfer — record the certificate) or `Open` (a chain-route candidate, probed first in D.3) |
| D.1 | calibration | the new tool re-derives 11's forced pair on a capsule piece | `Forced (solver claim)` for `(0, 3u)` and the control `identify (0, 3·basis vector)` `Separable` — FS-58's numbers reproduced |
| D.2 | the 5-cycle supply | for every `d ≡ 3 (mod 8)` in the family: the least odd `m` with `(4m² − n)·n = d·k²`, `n = p² + q²`, `m` a product of primes `≡ 1 (mod 4)` (so three rational unit steps can close the chord; FS-58's hand obstruction is this equation's failure at `d ≡ 7 (mod 8)`) | an atlas column; 11's value is 5 (`n = 1`, `k = 3`) — the control |
| D.3 | forced-pair probes over 35 and 59 | FS-58's `probe` (capsule, `--ks 2,3`) on 3-integral pools chosen by D.2, to 400,000 points | each record one of the three forcing verdicts with its planted-rhombus control |
| D.4 | which forced pairs chain | for any forced `δ`: is `δ` a unit at every stable prime (2, and the odd `p ≡ 3 (mod 4)` with `(d/p) ≠ −1`)? 59's ball already forces `c(0) = c((6/5, 0))` (FS-58's rigidity meter), and `1/δ = 5/6 ∉ ℤ[U]` because 2 is stable — **that pair does not chain; record it as the worked negative** | each forced pair tagged `chains` / `does not chain (prime p)` |
| D.5 | closure and certificate | `1/3` as a sum of unit vectors over the field (meet-in-the-middle, as FS-58 did for 11 and 23), the chained witness, then phase C's whole path | `CERTIFIED`, or the null stated with its enumeration |
| D.6 | stop rule | — | no forced chaining pair at either field within the timebox → the `d ≡ 3 (mod 8)` half is reported **not landed beyond 11**, and a stub is proposed |

### The owner's re-plan after phase B′ (2026-09-20) — read this before phase E; where it differs from the rows below, it governs

**Phase B′ is accepted** (`ef22cd4 … bb5e05e`). Scored by artifact: frozen files untouched, plan edits confined to §R, no certificate
byte moved, `table --check` re-run by the owner (40 fields, accounting at tiers 1 and 1b, 0 defects, no tracked file changed), and the
tier-`1b` records recounted by the owner from the raw `balls.jsonl` with his own script: **78 records — 37 asked (12
`Colourable`, 24 `Unknown`, 1 `Refused`) and 41 `Over cap`; the one refusal is at `d = 23`, already landed; actual / predicted points
0.9982–1.0094 over the 37.** Nothing new lands, and that is the result: **nine of forty.** The nulls are now sorted — 11 by certificate,
5 by budget (35, 59, 83, 251, 323), 15 asked without a refusal.

**Two corrections to the record, both the recurring kind (a number without its population).** (a) §R-B′ and the phase record give
167's two colourable balls as "313,748 and 397,140 points": those are the **pieces put to the solver after low-degree peeling**; the
balls are **314,177 and 397,821 points** (the raw records' `points`). (b) The hand-back's headline said "36 balls asked"; the records
say 37. **And the owner's reading of 167, which goes into E.4:** at `R = 1.0` those two balls carry 481,082 and 609,374 edges — average
degree **3.06** — so "3-colourable in under two seconds" measures the *radius*, not the field: a ball that sparse cannot refuse. The
informative ask at 167 is `R = 1.2` (397,817 points, 1,688,370 edges, average degree 8.5), and it is `Unknown` at the wall. 167 has
therefore still never been asked a question that was both decidable and capable of refusing.

**Rulings.**
1. **Census language gains its third phrase** (the implementer's, accepted — it is the majority case): `Not landed at tier T (asked:
   j of k Open lattices, no refusal[, u undecided at the wall])`. The undecided clause is mandatory whenever `u > 0`.
2. The strengthened rung rule (descend a rung on an exact over-cap) stands as harmless; it never fired. The `evidence` column's
   retirement of `kernel` stands: no row of this census is kernel-checked, and only 11's README names FS-58's 204-point chain witness
   as a different graph. The `load_jsonl` finding stands, and **the lock in `append` is built before any pooled run of phase E** —
   a read that writes is tolerable only while one command runs at a time, and phase E does not.
3. **E.1 as written — tier 2 at a 3,000,000-point cap — is NOT run.** The measurement that decides it is B′'s own: 24 of 37 asks at
   ≤ 600,000 points ended undecided at the wall, so the binding constraint is the solver and tier 2 asks *larger instances of the
   shape already undecided*; at 3.4–5.2 GB per million points a worker wants 10–16 GB, so the pool is six to eight wide, not sixteen;
   the price is a day and the expected yield is low. The big-instance problem belongs to FS-59, with tools built for it
   (cube-and-conquer, priced on a sample). **What replaces it, bounded at six machine-hours in total:**
   * **E.1a — tier `1c`: the 14 `Unknown (budget)` tier-`1b` balls at the ten family fields not landed** (131, 167, 215, 239 ×2,
     287 ×2, 311 ×2, 407, 431, 455, 479 ×2), re-asked at a **3,600 s** wall, same cap, one pooled pass. The 25 tier-1 `Unknown`s
     at the control fields are not re-asked: those planes are 2- or 3-colourable by theorem, which is also the standing reminder
     that an `Unknown` is not a near-refusal. Registered before the run: *the owner expects at most two verdicts to change, and none
     to `Refused`* (low confidence); both outcomes are reachable.
   * **E.1b — tier `2l`: deeper lattices under the same cap.** `NMAX = 420` lattices and the quotient filter at the 31 fields not
     landed; balls by the ladder 1.5 → 1.2 → 1.0 under the **same** 600,000 cap and 600 s wall, pooled. This is the only test the
     eleven by-certificate nulls can ever get. **Priced first on one field** (the lattice and filter stages at `d = 107`): if the
     lattice-and-filter stage projects over two hours for 31 fields, cut to the eleven by-certificate fields plus 167; if it still
     does, it is not run and the record says so with the measurement.
   * Any field that newly refuses is certified under phase C's amended gate. The owner runs C.10 on it.
4. **E.2–E.7 stand as written**, with three additions to E.4 (`aiming-167.md`): the sparsity reading above; B′'s finding that the
   solver and not the cap is the wall, with the memory figures and their population; and, for each of 167's six Open lattices, its
   predicted points at 1.0 / 1.2 / 1.5 and what was asked. **E.5's product is the isomorphism table and the shape table; the theorem
   attempt beyond them is the owner's, at the close.**
5. **Staffing:** the third implementer returned at 472k tokens; phase E and F go to a fresh one.

### Phase E — tier 2, and the explanation (one day)

| # | what | verified how | pass condition |
|---|---|---|---|
| E.1 | tier 2 (decision B) on the `d ≡ 7 (mod 8)` fields not landed at tier 1, 167 excluded (decision H) | as phase B, its own records (`tier: 2`) | B.1–B.7 at tier 2 |
| E.2 | R-cycle, R-mod8, R-L, R-size scored | one analysis script over `census.jsonl` → `data/fs61/readings.md`: the contingency tables and the fit named in §3, each with its population spelled out | each reading **won / lost / not decided (why)**, in those words |
| E.3 | R-C scored | FS-58's `charmeans` on every refusing lattice (a float reading, labelled so) | the table of least character means; R-C lost if any is below −1/2 |
| E.4 | the note for FS-59 | `data/fs61/aiming-167.md`: under the size law, the predicted least refusing size over 167 with its uncertainty; which of 167's lattices A.7's rule says can be live; what budget that implies | written; every number carries its population |
| E.5 | the class-theorem attempt (§M2 names the only two proof shapes in sight) | **(β) a parametric witness:** every field `d = N² − c²` owns the layer vector `(c/N, √d/N)` — an infinite two-parameter family (`N = 12`: 23, 95, 119, 143; `N = 24`: 47, 215, 287, 407, 455, 527, 551; …). Test: a canonical form (Weisfeiler–Leman hash, then an exact isomorphism test on collisions) of every certified witness, compared pairwise; an isomorphic pair in one `N`-family is a candidate for a witness with coordinates polynomial in `c`, whose edges would be identities in `c` and whose refutation **one** LRAT for the whole family. **(α) the chain:** what phase D learned about 3-integral forcers at `d ≡ 3 (mod 8)`. Also: does any witness or refusing lattice lie in a rank-2 layer `ℚ × √d·ℚ` up to rotation (`[Sokolov2018]`)? | the isomorphism table; a statement with its status, or "no route found" with what was tried; **no claim of T4 without a proof** |
| E.6 | predictions scored | §8 | every P scored won / lost / not measured |
| E.7 | P-unreachable audit | — | any prediction whose informative outcome turned out unreachable is named as mis-specified, with evidence that predates the result |

### Phase F — the close (WORKFLOW step 9; the product owner writes `CLAUDE.md` and `plans/FRONTIER-STUBS.md` from your proposals)

| # | what | pass condition |
|---|---|---|
| F.1 | `data/fs61/README.md` | every path, its producer command, its trust level |
| F.2 | `CLOSED-QUESTIONS.md` §1.7 and `BIBLIOGRAPHY.md` | new values added field by field with their certificates; every work cited resolves (`python3 tools/bib_audit.py`) |
| F.3 | proposals to the owner | ledger row text, grokking text (G61's update), the re-ranked stubs — as a proposal file `data/fs61/CLOSE-proposals.md`, not as edits to the owner's files |
| F.4 | the sweeps | this plan grepped for "conjecture", "not claimed", and its §PA re-read asking *what did this teach us about our own object?* — each hit minted as a stub or declined in writing |
| F.5 | stubs | FS-59 and FS-60 updated by proposal with what they now consume |

## §7 Records (the consumer surface: FS-59, FS-60, the ledger, the owner's scoring)

All under `data/fs61/`. One JSON object per line; every record carries `tier` (an id defined once in `data/fs61/tiers.json` —
the tuple of decision B; a tier's definition never changes after its first record, a new depth is a new id), `machine`, and
`claim_scope` ∈ {`exact`, `verified model`, `solver claim`, `checker`, `float reading`}.

**The objects (§M1).** A **lattice** is a finitely generated subgroup `Λ` of `F²`, identified by its canonical key **within its field** — the key is `(M, Hermite form)` and carries no `d`, because the ℤ-module does not depend on the field while the quadratic form `(1, d, 1, d)` and hence the generator set does (phase A: 154 of 817 shapes on disk are shared between fields, among them the witness lattices of (23, 191) and of (95, 119)); **every cross-field table keys on `(D, key)`**, and a shared shape with equal generator counts is the cheap precondition E.5's route (β) looks for before any isomorphism test; its graph is
always the *full* unit-distance graph on `Λ` — generators = every unit vector lying in `Λ` — so "saturated" is part of the
definition and is asserted, never assumed. A lattice's **state** is one axis, *what is known about 3-colouring its graph*:
`Colourable (form mod 2)` (bipartite), `Colourable (form mod 3)` (a linear form `Λ → ℤ/3` nonzero on every generator — every
3-integral lattice has one, by the kernel barrier), `Colourable (periodic colouring verified)` (FS-58's "dead"), `Refused (solver
claim)` / `Refused (certified)` (some ball refuses), or `Open (no certificate among: forms mod 2, 3; Q quotients; balls to R)` (FS-58's
"live" — a statement about the search, which is why it carries its enumeration). Colourability is inherited **downward** (the graph on a sublattice is an induced subgraph, and a colouring periodic under `L′`
restricts to one periodic under `L′ ∩ Λ`, of finite index — no rank condition), refusal **upward**. A lattice's balls give a **refusal bracket**
`(largest radius verified colourable, smallest radius refused)`, never a "least refusing ball". A **field** has a `role` (`census`, or
`control` with its expected `χ`) and, separately, a state; its value is a bracket `[lower, upper]` with a source for each end. A
**landing is a certified witness** — a finite point set the frozen checker certifies — and the direct route and the chain route are
two *searches* for that one kind of object: the route is the witness's provenance (`found_by`), never part of the field's state.

* `frame.jsonl` — `{d, mod4, mod3, mod8, stable_primes, L, L_reason, chi_known, chi_source}`.
* `atlas.jsonl` — `{d, classes: [{N, orbits, v2, v3, rational}], N1, N3}`.
* `fields/<d>/lattices.jsonl` — `{d, key (canonical: exact denominator M and the Hermite normal form of MΛ), spec_full (the one
  spec naming every class the lattice contains; `pool_vectors(spec_full)` must equal the generator set — asserted), class_reps (a
  representative vector per class, because a class *name* means something only under the frozen `classes()`), rank, M, size,
  covolume, rel_height (N/√d of its coarsest non-rational class), three_integral, odd_girth, odd_girth_none_up_to,
  predicted_points_R15, generators_sha256, iso_invariant (covolume, size, sorted multiset of generator inner products — lattices that
  differ by a rotation are *not* merged, this lets the analysis see them)}`.
* `fields/<d>/filter.jsonl` — `{key, state, certificate: {kind: form2|form3|quotient, form | (matrix, snf, order, colouring_sha256)},
  inherited_from (a key, when the state came by monotonicity), quotients_tried}`.
* `fields/<d>/poset.jsonl` — derived: the inclusion pairs among the field's lattices (exact: each basis vector of `Λ` an integer
  combination of `Λ′`'s).
* `fields/<d>/balls.jsonl` — `{key, shape (FS-58's `piece`: `ball`), R, points, edges, verdict, solve_seconds, wall, model_sha256}`.
* `witness-<d>/` — FS-58's bundle: `witness.json`, `witness.lrat.gz`, `certified.out`, `controls.out`, `recheck.out`,
  `colouring4.json`, `run-all.sh`, `README.md`. **The README is written for a reviewer who trusts none of this** (model:
  `data/fs58/witness-47/README.md`): the claim in one sentence; the one command that re-checks it and what that command checks (it
  is standard-library Python sharing no code with the generator); what is **not** claimed (the upper bound is prior art at hand
  level, named); sizes and hashes; how the witness was found (`found_by`, lattice, radius) — provenance, never evidence.
* `witnesses.jsonl` — the manifest FS-60 consumes: `{d, path, points, edges, lcm_denominator, pinned_edge, witness_sha256,
  lrat_sha256, lrat_additions, found_by, certified: true}` — one line per certified witness, FS-58's six included by reference.
* `census.jsonl`, `census.md` — **derived**: one row per field — `d`, `d mod 8`, `L`, `N₁`, `N₃`, lattices by state, the best live
  lattice, the refusal bracket of the best lattice (both ends, with points), the witness (points, edges, `found_by: ball | chain`),
  `role`, the field's state ∈ {`Landed (certified)`, `Refusal claimed`, `Not landed at tier T`}, the value bracket with the source of
  each end, `evidence` ∈ {`kernel` (11 only), `checker`, `solver claim`, `none`}, notes (every `Unknown` and `Over cap`, and the
  command that would deepen the row). A `control` field whose state is not `Not landed` is a defect, and the table says so in red
  words. **`census.md` opens with a legend a stranger can read** — what each column means in plain words, the tier definitions, and
  this sentence in bold: *"Not landed" means no certificate was found at the stated depth; it is not evidence that three colours
  suffice — the conjecture predicts at least four for every row of this table.* A table that lists "landed" beside "not landed"
  without it will be read as a table of chromatic numbers.

**The vocabulary, in one place** (every status string the tools, records and table may use):

| string | said of | trust |
|---|---|---|
| `Colourable (form mod 2)`, `Colourable (form mod 3)` | a lattice | exact — the form is in the record and re-checks in microseconds |
| `Colourable (periodic colouring verified)` | a lattice | verified model — the quotient colouring is stored and re-checked on every generator |
| `Open (no certificate among: …)` | a lattice | a statement about the search; carries its enumeration |
| `Refused (solver claim)`, `Refused (certified)`, `Refused (inherited from <key>)` | a lattice | claim / checker / as its source |
| `Colourable (colouring verified)`, `Refused (solver claim)`, `Unknown (budget)`, `Over cap (not asked)`, `Not asked (field budget)` | a ball | verified model / claim / nothing / nothing / nothing |
| `Separable (colouring verified)`, `Forced (solver claim)`, `Unknown (budget)` | a forcing question (phase D) | as FS-58 |
| `Landed (certified)`, `Refusal claimed`, `Not landed at tier T` | a field | checker / claim / a null at a depth |
| `CERTIFIED`, `REFUSED <CODE>` | the frozen checker's own words | exact |

## §8 Registered predictions (before any census solver call; both outcomes of each checked reachable)

| id | prediction | probability | how each outcome would look | reachable both ways? |
|---|---|---|---|---|
| P1 | the observed half of the dyadic law (`v₂(N) ≠ 1` for `d ≡ 7 (mod 8)`) holds on every atlas row to `N = 420` | 0.85 | 0 violations / a printed violating row | yes — O6 covers nine denominators only |
| P2 | **R-mod8 (a):** tier 1 yields no refusing ball at any of the twenty `d ≡ 3 (mod 8)` fields (inherited refusals over 11 excluded) | 0.7 | zero / at least one | yes — only one lattice per field was asked at the opening (O5), and the 11-witness's own lattice is known live |
| P3 | among the twenty `d ≡ 7 (mod 8)` fields, tier 1 yields a `Refused` ball at **ten or more** (seven are known or priced: 23, 47, 71, 95, 119, 143, 191) | 0.6 | count | yes |
| P4 | every tier-1 refusal certifies (phase C) | 0.9 | all `CERTIFIED` / an extraction that stalls or a refusal that does not survive exact re-derivation | yes — FS-58's 95 stopped short of 1-minimal |
| P5 | R-size: log–log slope of least refusing ball size against `d` in `[0.5, 2]` over the landed `d ≡ 7 (mod 8)` fields | 0.5 | the fit | yes; with fewer than six landed fields it is *not decided*, said so |
| P6 | R-L loses: landing rates for `L = 4` and `L ≥ 5` among `d ≡ 7 (mod 8)` do not differ by more than chance at matched relative height | 0.65 | the contingency table | yes |
| P7 | R-C loses: some refusing lattice has least character mean below −1/2 | 0.75 | the table of means | yes |
| P8 | A.7 finds a rule reproducing the non-affine quotient colourings on ≥ 90 % of dead lattices | 0.35 | a rule / a sub-family rule / none | yes |
| P9 | phase D lands a second `d ≡ 3 (mod 8)` field by the chain | 0.25 | a certificate / the stated null | yes |
| P10 | a statement about infinitely many fields is proved (E.5) | 0.1 | a proof / none | yes |
| — | *not registered, because its informative outcome is unreachable here:* the stub's "informative failure" — a field with `L = 4` whose plane is 3-colourable. No finite census can exhibit a 3-colouring of an infinite plane; what a census *can* produce in that direction is a barrier theorem (A.7), and that is P8 | | | |

## §9 What this milestone is not, and its stop rules

Not an attack on 167 (FS-59). Not a kernel milestone (FS-60). Not a proof of the conjecture's level 4 — T4 is a candidate, and a table
of landings is evidence for it and nothing more. **Stop rules:** tier 1 costs at most a day of machine time — if a single field's scan
passes two hours, record the remainder as `Over cap (not asked)` and move on; phase A.7 three hours; phase D one day, two fields;
tier 2 one day. A null at any tier measures that tier's lattices and balls (G21), and the table says which.

## §M Modeling passes

### M1 — domain (2026-09-19): what the census's objects are

Run as a fresh invocation of `debruijn-domain-modeling` on the committed subplan. The cut it applied throughout: **what belongs to
the problem** (a lattice, its unit-distance graph, whether that graph is 3-colourable, a finite witness) against **what belongs to how
FS-58's search happened to be organised** (class specs, separate flags, "the ball that refused", the route that found a witness).

| # | choice | alternative weighed | why | confidence |
|---|---|---|---|---|
| M1.1 | the lattice is the object and its graph is the full unit-distance graph on it; saturation is definitional and asserted | FS-58's pool (a direction set `W`, graph `Cay(ℤ[W], W)`) | the pool graph is a *subgraph* of the plane's graph on the same points; only the full graph is an induced piece of the plane, so only it is monotone under inclusion and only its colourings mean anything about the plane. A missed generator is the one error that fails silently toward "colourable" (rule 6) | high |
| M1.2 | one state axis with certificate kinds (decision C′) | four flags | above; the control it buys for free — every 3-integral lattice must show a form mod 3 — is the kernel barrier observed by the instrument | high |
| M1.3 | **the lattices of a field form a poset under inclusion; colourability is inherited downward, refusal upward; the census records the inclusions and checks both directions** | independent lattice records | it is the problem's own structure (an induced subgraph of a 3-colourable graph is 3-colourable; the restriction of a periodic colouring to a sublattice is periodic). It gives an order of work (certificates top-down, balls bottom-up), a strong consistency control that can fail (B.1b), and the sharp form of R-mod8 — *certificates on the finest lattices close a field's whole slice* | high |
| M1.4 | a lattice's balls give a bracket `(largest colourable, smallest refused)` | "the least refusing ball" | verdicts are monotone in the radius and the band between the two ends is where solvers stall, so the minimum is not observable; R-size is fitted on the bracket's upper end and says so | high |
| M1.5 | a landing is a certified witness; the route is provenance; a field has a role and, separately, a state | a field state that names the route, and `Control` as a state | the chain route and the direct route search for the same object, and a control field has the same possible states as any other — that it must stay `Not landed` is the *expectation*, which a state cannot also be | high |
| M1.6 | tiers are defined once in `tiers.json`; records carry the id | the depth tuple in every record | one definition cannot drift from itself; a changed depth is a new tier | high |
| M1.7 | lattices of rank below 4 are recorded and filtered, not scanned | skipped, as FS-58's `saturate` does | they are the objects of `[Sokolov2018]`'s adjacent question (E.5) and cost nothing to certify; FS-58's layered-pool nulls say a scan of them is poor value | medium — a rank-3 `Open` lattice with a short odd cycle would reopen it |
| M1.8 | every reading names its unit of analysis and its quantifier; R-mod8 is split into (a) a budget null and (b) a certificate statement | one sentence per reading | (a) and (b) are different kinds of knowledge and the census can deliver the second | high |
| M1.9 | lattices that differ by a rotation are not merged; an isomorphism invariant is recorded | canonicalising up to the plane's symmetries | the symmetry group is infinite (every unit vector is a rotation) and merging is graph isomorphism; duplicates cost only solver time, and the invariant lets the analysis see them | medium — if duplicates turn out to dominate a field's slice, merge by invariant then |

**Seams checked.** *Unsampled members:* a field with no `Open` lattice (the table says so, B.1); a lattice of rank 3 (M1.7); a field
whose only refusing ball is over the cap for `direct-witness` (phase C's checkpointed `extract`). *Adversarial members:* a `Colourable`
verdict on an incomplete edge set — excluded by asserting saturation (0.6) and re-verifying certificates against the full generator
set (B.3); a witness certified under the wrong field — the checker's wrong-radicand refusal (C.3); `χ = 4` claimed where `L = 5` — the
frame is computed two ways (A.1). *The next-lemma test:* FS-59's question ("which lattices over 167 are `Open`, and how large are their
balls?"), FS-60's ("every certified witness with its path and size") and a later tier or route all state in the schema without
changing it.

### M2 — obligations (2026-09-19): what is proved, tested, assumed

Run as a fresh invocation of `debruijn-obligation-modeling`. The master move: every global claim is replaced by a **local
obligation** — a finite per-case check whose discharge implies it — or it is labelled a test or an assumption.

| claim | status | the local obligation, or the instrument |
|---|---|---|
| the frame (§1): `χ = 2`, `χ = 3` off the family; `χ ≤ 4`, `≤ 5` on it | **assume** — prior art at hand level (`[Fischer1990]` Thms 8–10, read in statement; `[Moorhouse2010]` Thm 8.1), and the field-level residue step is row 57's standing gap (FS-37/47). Every "`= 4`" the census reports inherits this status and says so | **test:** PARI's decomposition of 2, 3, 7, 11, 19 in `K` agrees with the congruences on every row (A.1) |
| every unit vector is a unit at every stable prime | **prove** [hand, one line]: `v(u) = v(ū)` and `v(u) + v(ū) = 0` | — |
| height floor; finiteness of `D(N)` | **prove** [hand]: `d(b² + e²) ≤ N²` | **test:** A.3 on every row |
| odd prime support; `v₂(N) ≤ 1` at `d ≡ 3 (mod 8)` | **prove** [hand; D-H.2]; prior art `[Fischer1990b]` | **test:** A.3; a violation is an enumerator defect |
| `v₂(N) ≠ 1` at `d ≡ 7 (mod 8)` | **test** (A.3, P1); a proof is A.4's attempt | — |
| refusal is inherited upward, colourability downward | **prove** [hand, two lines]: both graphs are *induced* subgraphs of the plane's, so `G_Λ` is the induced subgraph of `G_Λ′` on `Λ`; a colouring periodic under `L′` restricts to one periodic under `L′ ∩ Λ`. **The mutation audit removed a hypothesis:** "full rank" is not needed | **test:** B.1b, with a plant |
| balls are nested in the radius | **test:** assert `X_R ⊂ X_R′` on one lattice (FS-58's `piece` is a black box here) | — |
| a lattice's graph is the full unit-distance graph | **test, per record** (0.6): every unit vector of denominator dividing `M` that lies in `Λ` is a generator; and `Λ ⊂ (1/M)ℤ⁴` makes those *all* the unit vectors in `Λ` | — |
| a rule for the dead lattices (A.7) | **a reading until its local obligation is proved:** `ρ(s) ∈ T` for every unit vector `s` of the class — one congruence on `(a, b, c, e, N)` — with `Cay(A, T)` 3-colourable (finite, by exhaustion). This is Theorem A's shape, so a proved rule is a *second barrier* beside row 72's | **instrument:** the minimal colourable quotient (A.7) |
| FS-58 D3.4's repair (3-colourings of `G × H`, `χ(H) > 3`, factor through `G` when `G` is gap-free) | **not used and not attempted here.** The sweep agent sketched an eigenvalue argument for the case `G` Hoffman-tight at three colours and `H`'s ratio `λ_min/d` above −1/2 (by Weil, the residue planes from about `q = 17` up) — *unverified by anyone*; the fact is measured, unproved, at `q = 7, 11` (FS-58 §0 O7). Proposed to the owner as a stub at the close | — |
| every solver verdict | **test:** `Colourable` by a model checked on every edge; `Refused` a claim until the frozen checker's `CERTIFIED` | §5 rule 4 |

**T4 — what a proof would have to look like, and what a census can give it.** Two shapes are in sight. **(α) The chain:** a finite
forcer of a pair at difference `δ` with `1/δ ∈ ℤ[U]`. The chain half is uniform (`1/3 ∈ ℤ[U]` for every `d ≡ 2 (mod 3)`); the forcer
half is uniform only through FS-58 D3.5's dichotomy — a finite forcer among 3-integral graphs exists iff the infinite 3-integral graph
forces — and a proof that it forces for *every* `d` needs control of **aperiodic, non-additive** 3-colourings, for which no tool is
known (periodic ones are affine by the tower; additive ones are affine). A census contributes instances and the 5-cycle supply law
(D.2), never the quantifier. **(β) A parametric witness:** one abstract non-3-colourable graph drawn with coordinates polynomial in a
parameter, every edge an identity — one refutation, infinitely many fields. The local obligations are exactly checkable (a computer
algebra identity per edge; one LRAT). Nothing says such a family exists; E.5's isomorphism test is the cheap way to find out, and both
of its outcomes are reachable. **Outside (α) and (β) the census proves T4 one field at a time, and says so.**

**The mutation audit on this plan's own statements** found three overstatements, all corrected in place: the dyadic law was stated as
"`v₂(N) ≥ 2` for `d ≡ 7 (mod 8)`" when odd denominators occur in both halves (57 over 143, 171 over 167); inheritance carried an
unused "full rank" hypothesis; and R-mod8 was stated on lattices, where FS-58's certified witness over 11 falsifies it by inheritance
before anything is run — it is a statement about *balls*.

### M3 — experience (2026-09-19): the surfaces, read from the consumer's side of the wire

Run as a fresh invocation of `debruijn-experience-modeling`. Four consumers, none of whom holds what the planner held: an implementer
with this file and nothing else; a product owner scoring from artifacts; FS-59, FS-60, the ledger and a future paper reading the
records; a reviewer who trusts none of it opening one witness directory.

| # | choice | alternative | why | confidence |
|---|---|---|---|---|
| M3.1 | a glossary, a reading order and a first hour at the top (§0.1) | let FS-58's tool docstring teach the words | the cold read failed on the first page: "class", "spec", "saturated", "dead", `q5`, `60.1` are used from §2 on and defined nowhere in this file; and the first thing a new colleague should see is the instrument working | high |
| M3.2 | a phase record with one pasteable row per gate item (rule 16) | the implementer's prose report | the owner's scoring becomes re-running commands; a claim with no row is visibly a claim | high |
| M3.3 | the five halts in one rule (rule 15) | each halt stated at its gate item only | at the moment of a red control the question is "may I fix this and go on?", and the answer must be where the eye lands — no | high |
| M3.4 | the tool's surface fixed before code: bare call = tier 1, headline and summary lines, resume by re-running, `status`, failures that name the culprit and exit non-zero, exact verdict strings | leave it to the implementer | FS-58's surface cost the planner three stumbles in one hour (O7); a silent success path and an unreadable failure path are how this project's checks have failed before (`CLAUDE.md` § Make the gate fail) | high |
| M3.5 | one vocabulary table (§7) | strings defined where first used | one `grep -F` must find every instance, and a reader must learn each string's trust level once | high |
| M3.6 | `census.md` opens with a legend and the sentence about what "not landed" does not mean; an `evidence` column | a bare table | implicature: a table of "landed / not landed" reads as a table of chromatic numbers, and a solver's claim beside a checker's certificate reads as the same kind of fact | high |
| M3.7 | every null row carries the command that would deepen it | nulls as end states | each turn funds the next: FS-59 and any later tier start from that line | medium — if the commands rot when the tool changes, the table regenerates them |
| M3.8 | a witness manifest for FS-60, and witness READMEs written for a reviewer | FS-60 walks the directories | FS-60's certificate type needs the common denominator and the pinned edge per witness; asking "what must someone who trusts none of this check?" while the evidence is gathered is this project's own rule (`CLAUDE.md` § The standard of evidence) | high |

**Breakdowns walked.** A control goes red → rule 15, with the message naming the field, lattice and ball. A gate item cannot go green
→ its row says *not landed* (rule 16). The implementer's context fills → stop at a phase boundary; the phase records and JSONL are the
memory, and the next implementer's first command is `status`. A reader meets `Open` → the string itself says which certificates were
tried. A reader meets "`χ = 4`" → the `evidence` column and the value bracket's sources say which half is ours.

## §R Results

*Written by the implementer as each phase closes. The phase records under `data/fs61/records/` are the evidence; this
section is the index and the carry-forward. Current state only — a corrected claim replaces the claim.*

### §R-0 — phase 0, the instrument (2026-09-19/20, closed; commits `a2ff5ec`, `5fb9984`)

**8 of 8 gate items green.** Record with every command, artifact, output line and exit status:
**`data/fs61/records/phase-0.md`**. The driver is `tools/fs61_census.py` (subcommands `lattices`, `filter`, `scan`,
`status`, `selftest`, `regress {lattices,refusals,certificates,controls,untouched,all}`; `frame`, `atlas`, `land`,
`table` exit 2 saying which phase owns them). `data/fs58/` and `tools/fs58_*.py` unmodified.

| item | result |
|---|---|
| 0.1 | FS-58's **1,761** rank-4 records over 14 fields → **648** distinct lattices; key sets agree exactly, field by field. FS-58's depths confirmed from the records, not assumed: 180, with **300 at `d = 23`** and **420 at `d = 167`** |
| 0.2 | the five refusing balls reproduce FS-58's point **and** edge counts exactly, all `Refused (solver claim)` |
| 0.3 | six witnesses `CERTIFIED` (the gate's five plus `d = 11`), exit 0; wrong-radicand plant `REFUSED EDGE_NOT_UNIT`, exit 1 |
| 0.4 | **zero refusals among the 550 balls ASKED** at `d = 2, 5, 7, 13, 19, 31, 43` (1,350 ball records: 525 verified colourable, 25 `Unknown (budget)`, **800 `Over cap (not asked)`** — the zero is over 550, not 1,350; owner's correction 2026-09-20); every lattice over 2, 5, 13 bipartite; **3 refusals at `d = 47`** on the identical `--filter-off` command. Table: `data/fs61/controls.md` |
| 0.5 | one lattice one key over 25 unimodular/permuted/sign-flipped bases; different lattices different keys |
| 0.6 | the saturation recomputed from the canonical key is byte-identical to FS-58's `_saturate_one` on all 648 lattices — a two-implementation cross-check |
| 0.7 | scan stopped mid-run by pgid and resumed: 18 records before, 24 after, **0 duplicates, 0 lost, 0 changed** |
| 0.8 | `git status --porcelain data/fs58 tools/fs58_*` empty |

**Twelve planted faults, every one executed and fired on its named clause** (`data/fs61/records/phase-0.md` §Plants).

**Findings that change later phases.**

1. **Gate 0.5's plant is unreachable as the plan words it.** The canonical key is a function of the lattice, and these
   generating sets are closed under negation, so removing, doubling or mutating a **single** generator leaves the
   ℤ-span fixed — confirmed by exhausting all 28 single-generator deletions of one lattice. A key comparison therefore
   *cannot* detect an unsaturated or corrupted generator set; `lattice_record`'s explicit assertion and the
   `generators_sha256` comparison do, and a third plant (a genuinely smaller lattice) shows the key comparison can fire
   at all. **Proposed rewording of 0.5's plant** in §6, for the owner: *"a corrupted generator set must move
   `generators_sha256` while leaving the key fixed; a genuinely different lattice must move the key."*
2. **Decision C's cost, measured: 261 of the 648 lattices carry more than one class spec** — 40 % of FS-58's lattice
   records are one lattice under another name.
3. **The tier's odd-girth search is the whole cost of `lattices`: 1,648 CPU-s for `d = 11` against 1.8 s with it off**
   (~900×; worst single lattice 6.9 s, 300 generators). Affordable for the census (of the order of an hour of wall time
   over 40 fields) and it buys what FS-58's 20,000-point cap could not: lengths where FS-58 recorded only `None`. The
   regression runs `--no-girth`, since it compares lattices and generators. Records carry `odd_girth.status` ∈
   {`computed`, `bipartite`, `not asked`} and never a bare `null` — FS-58's O1 trap in one field.
   *Deviation, toward more information:* FS-58's `odd_girth` has no length cap, so it can report `none_up_to` above the
   tier's 15; `bfs_cap`, `explored` and `levels` are in every record.
4. **The three-chromatic controls are a theorem-backed null, and cannot test the `Open` population.** Over
   `d = 7, 19, 31, 43` **no lattice is `Open`**: `d ≡ 1 (mod 3)` means 3 divides no class denominator (D-H.2), so every
   lattice is 3-integral and the kernel barrier gives it a form mod 3. The law was checked on **1,091 lattices at
   twelve fields, 0 violations** — and its converse holds exactly too (`forms mod 3 > 0` **iff** `3 ∤ M`, on those 1,091
   and on all 1,761 FS-58 rank-4 records), which is A.3's law met early. So the seven zeros say the instrument does not
   invent refusals and say nothing about certificate-free lattices; `d = 47`'s 29 `Open` lattices and three refusals are
   what covers that. **Worth adding to §6's 0.4 row** so the zeros are not read as stronger than they are.
5. **`Unknown (budget)` has five self-certifying instances — the bound on how much any `Unknown` in the census can be
   read into, and phase E's input when it scores a null.** Twenty-six of the 601 control balls asked hit the 600 s wall;
   five are on **provably bipartite** lattices (an exact form mod 2 two-colours the whole infinite graph), against a
   median colourable solve of 0.21 s and one coloured ball of 557,065 points. Rule 4 now has instances, not an argument.
   *Phase-B improvement proposed, not made:* a lattice with a form mod 2 or 3 can have its ball colouring **constructed**
   from the form (`form(x) mod p`), exact and instant, instead of searched.

**Free carry-forward into later gates.** B.4's `d = 143` half is already met (`R = 1.5`, 283,485 points and `R = 1.8`,
587,333 points, both `Refused`); A.8's point law is verified on seven recorded balls, worst error **2.24 %** against the
15 % bound (`π²R⁴/covolume`, the bidisc); the 119 pricing witness regenerates **byte-identical** (`witness.json` sha256
`f61526fc…`, LRAT `0ee2aceb…`), which is C.8's determinism claim met early.

**My own defects, all repaired and recorded** (`phase-0.md` §The incident): a `timeout` wrapper on the controls run —
a rule this project already holds — killed it at 50 minutes, costing only redo because every unit checkpoints; resume
was keyed per lattice where the unit of work is per class spec (40 % rebuilt every run; after the fix a second
`lattices 119` costs 0.0 s against 29.9 s); and an int/str key comparison stopped finished fields being skipped, found
twice, the second time only by re-running every gate command at the end and reading the **counts** — both runs exited 0
and only the number moved.

**Cost.** Desktop (16 physical cores), 16 workers, one heavy job at a time: `regress lattices` 6.6 s;
`regress refusals` 299 s; `regress certificates` 2.6 s; gate 0.7's scan 608 s; `regress controls` 2,559 s (plus ~2,600 s
lost to the incident); `selftest` 1.1 s; `lattices --tier 1` 115 s wall / 1,648 s CPU at `d = 11`.

**State on disk for phase A/B.** Tier-1 lattice records exist for `d = 2, 5, 7, 11, 13, 19, 23, 31, 43, 47, 119, 143`
and FS-58-depth regression records for the 14 fields; ball records for the eight control fields and for 143; models are
kept under `data/fs61/fields/<d>/models/` and gitignored (12 MB), with `model_sha256` in every record and
`scan <d> --reverify` re-checking a sample against the full exact edge set (exercised: 12 of 111 at `d = 7`, 0 failures).

### §R-A — phase A, derive before scanning (2026-09-20, closed; commit to follow)

**9 of 9 items done; 8 green, A.7 on its third branch (no rule found, with the table).** Record with every command,
artifact and output line: **`data/fs61/records/phase-A.md`**. Nothing halted; A.5, this phase's halt, passed on all
seven witnesses. Total machine cost: **under two minutes** — a derivation phase costs less than one ball of phase 0's
control scan, which is this plan's own point, measured.

| item | result |
|---|---|
| A.1 | `frame.jsonl`, 1,214 squarefree `d < 2000`; congruences+Legendre and PARI's decomposition in `F` and `K` agree on **every row**. §1's 40-field list, the L = 4/4/5 split and all six named controls reproduced |
| A.2 | `atlas.jsonl`, 155 family fields, `N ≤ 420`, **`d` solved for**; (denominator, orbit count) agrees with FS-58's `classes(D,180)` on all 17 fields; O6's `D(6), D(12), D(18), D(24)` reproduced with their mod-8 split |
| A.3 | all four laws, **0 violations** on 3,107 non-rational (field, denominator) pairs |
| A.4 | **L4 PROVED** (below); D-H.2 is now fully proved |
| A.5 | all seven witness lattices `Open` (0 of 9–22 quotients colourable); 11's is `M = 150`, rank 4, 108 generators, covolume 2.17e-4 |
| A.6 | 508 lattices from FS-58's own qscreen records, 256 dead; **0 disagreements** with FS-58's verdicts on all 33 pools at 167 |
| A.7 | **no rule**: smallest groups found are 27, 108, 108, 243, 1728, 2187, 4096; most common order is 29 % against the gate's 90 % |
| A.8 | worst error **2.24 %** on the six named balls; over 588 balls of ≥ 1000 points, **none** above 15 % |
| A.9 | §8 in `8c4b4fb` (09-19) precedes the first ball record in `5fb9984` (09-20): PASS |

#### A.4 — the dyadic law at `d ≡ 7 (mod 8)` [hand, machine-checked]

**Theorem.** *Let `d ≡ 7 (mod 8)` be squarefree and let `((a + b√d)/N, (c + e√d)/N)` be a unit vector in lowest terms,
so that `a² + c² + d(b² + e²) = N²`, `ab + ce = 0` and `gcd(a, b, c, e, N) = 1`. Then `N ≢ 2 (mod 4)`.*

*Proof.* Suppose `N = 2M` with `M` odd. Then `N² = 4M² ≡ 4 (mod 8)`, and `d ≡ −1 (mod 8)`, so the norm equation gives

  `a² + c² − (b² + e²) ≡ 4 (mod 8)`.

A square is `≡ 0 (mod 8)` iff the number is `≡ 0 (mod 4)`, `≡ 4 (mod 8)` iff it is `≡ 2 (mod 4)`, and `≡ 1 (mod 8)` iff
it is odd; so a sum of two squares is one of `0, 1, 2, 4, 5` mod 8, and the congruence forces

  `(a² + c², b² + e²) ≡ (4, 0), (0, 4), (5, 1)` or `(1, 5) (mod 8)`.

In the first two, `a, c, b, e` are all even, contradicting `gcd(a, b, c, e, N) = 1` with `N` even.
In the last two, exactly one of `a, c` is odd and exactly one of `b, e` is odd, and the **second** equation decides it:
* the odd ones *aligned* (`a, b` odd, or `c, e` odd): `ab` is odd and `ce` is even, so `ab + ce` is odd;
* the odd ones *crossed* (`a, e` odd, or `c, b` odd): one of `ab, ce` is `≡ 2 (mod 4)` and the other `≡ 0 (mod 4)`, so
  `ab + ce ≡ 2 (mod 4)`.

Either way `ab + ce ≠ 0`, against orthogonality. ∎

**Machine check** (`selftest --section atlas` and the residue exhaustion in the phase record): exhausting `(a,b,c,e,N)`
mod 8 under the norm equation, orthogonality and primitivity leaves **0** patterns at `d ≡ 7 (mod 8)`; the *same*
exhaustion at `d ≡ 3 (mod 8)` leaves **256**, and denominators `≡ 2 (mod 4)` really do occur there (6, 10, 18, 30, …
over `ℚ(√11)`), so the argument is not vacuous and is exactly as sharp as the phenomenon.

**Two notes on the plan.** (i) Its parenthetical *"a mod-8 count does not settle it"* is right about the **norm
equation alone**; what settles it is orthogonality read mod 4, a second equation rather than a finer count.
(ii) `[ZanardoZannier1991]` Thm 3 was read (with Prop. 2) and is **not** what settles this: it gives a basis of the free
part of the norm-one group indexed by the *split* primes with the obstruction in `Cl(S)/M`, which explains why powers of
2 occur in denominators at all — the dyadic prime is split at `d ≡ 7 (mod 8)` — but says nothing about the parity. Its
read-status in `BIBLIOGRAPHY.md` moves to *Prop. 2 and Thm 3 read, 2026-09-20*.

#### Findings that change later phases

1. **`L` is a bracket** (A.1). Four target chromatic numbers are themselves undecided, so each row carries
   `L_lower, L_upper`. Below 2000 exactly five fields have an undecided `L`: **167** [6,8] (23, 43, 59) and **1319**
   [6,8] (23, 47, 59), and **887, 1055, 1823 at [5,8]** because **31** is usable there and five is still open at 31.
   *A five-colouring of `UD(𝔽₃₁,2)` gives three real quadratic fields an `L` of 5; an `α < 161` certificate pushes all
   three to [6,8].* FS-57's side digit at 31 has three named consumers it did not know it had.
2. **A canonical key names a lattice within a field, not across fields** (A.5). The key is `(M, Hermite form)` and
   carries no `d`; **154 of 817 integral shapes on disk are shared by more than one field**, including the witness
   lattices of (23, 191) and (95, 119). Nothing built is wrong — every record carries `D` and every command is
   per-field — but **phase E must group by `(D, key)`**, and §7 should say so.
3. **A cheap pre-screen for E.5's parametric-witness route (β)**, delivered early. On a shared integral shape the
   generator sets differ (only the rational unit vectors coincide: 12 of 36 at 23/191, 4 of 28 at 95/119) while their
   **counts agree exactly**; `d = 23, 95, 119, 143` are the `N = 12` family `d = N² − c²` that E.5 names. A shared shape
   with equal generator counts is the precondition for one abstract graph drawn over several fields, and it is
   computable from the lattice records alone — where E.5 currently proposes graph isomorphism.
4. **The hidden group of a periodic 3-colouring need not be a 3-group** (A.7). `167 q1+1008.1`'s colouring factors
   through `(ℤ/8)⁴`, order with **no factor of 3**. This kills the natural candidate rule — that `ρ` is the kernel
   barrier's shape with a larger 3-group in place of `𝔽₃`. Registered as a sub-family pattern only: the three coarse
   `d ≡ 3 (mod 8)` lattices (11, 35, 59) all have 3-part exactly **27** and `|A| ≤ 108`, on three data points.
5. **A.7's numbers are upper bounds on `A_min`** (G21): one solver colouring per `(lattice, modulus)`. A small reading
   establishes `A_min` is small; a large one establishes nothing about `A_min`. Four lattices (all over `d = 23`)
   produced no colouring at any `m ≤ 12` and are absent from the table rather than counted.
6. **The bidisc law is safe above a few hundred points and not below** (A.8): over 588 balls of ≥ 1,000 points the
   worst error is 10.89 % and none exceeds 15 %; all six balls above 15 % have fewer than 150 points.
7. **Prediction P1 is won on a population 200× its registration** (A.3): 1,820 non-rational denominators at
   `d ≡ 7 (mod 8)` with `v₂ ≠ 1`, against O6's nine. With A.4 it is now a theorem rather than a prediction.

#### Proposals to the owner (§0–§9 are the specification; these are not edits)

* A.1's row: state `L` as a bracket, and name the three fields that 31 decides.
* A.2's row: mark which of O6's sets are stated within the family and which over every squarefree `d`.
* A.4's row: narrow "a mod-8 count does not settle it" to the norm equation alone.
* §7's lattice paragraph: add that the key identifies a lattice within a field, and that cross-field tables key on
  `(D, key)`.
* A.6's row: name the population — FS-58's README counts 28 dead of 31 distinct lattices over the 32 non-bipartite
  lines of `saturate-2520.out`; its verdict file holds `q1+q5+132` as well, giving 29 of 32, and FS-61 agrees with
  **every** one of its 33 pool verdicts.

#### State on disk for phase B

`frame.jsonl` (1,214 rows), `atlas.jsonl` (155 rows), `atlas-laws.json`, `witness-lattices.jsonl` (7),
`dead-quotients.{md,jsonl}` + `-reconcile.json` (508), `minimal-quotients.jsonl` (11 lattices × 6 moduli). Tier-1
lattice records for `d = 2, 5, 7, 11, 13, 19, 23, 31, 43, 47, 119, 143`; ball records for the eight control fields and
143. Phase B needs `lattices` + `filter` + `scan` per family field; `filter`'s quotient certificate and the inheritance
poset are phase B's to add — phase 0 and A left `filter` with the two exact forms only, and its `Open` string says so.

### §R-B — phase B, the census scan at tier 1 (2026-09-20, closed)

**B.1–B.7 all green; 40 fields, 1.01 h, 0 defects, nothing halted.** Record:
**`data/fs61/records/phase-B.md`**. Table: **`data/fs61/census.md`** (derived, byte-identical on re-run) and
`census.jsonl`.

**898 lattices**: 209 `Colourable (form mod 2)`, 268 `(form mod 3)`, **268 `(periodic colouring verified)`**, 43
`Refused`, 110 `Open`. The quotient certificate closes a third of the family — 268 lattices that would otherwise have
been balls to ask.

**Nine fields refuse at tier 1: 11, 23, 47, 71, 95, 119, 143, 191 and 359.** `d = 359` is **new** (not FS-58's, not
priced in phase 0): `L = 4`, twelve lattices, smallest refusing ball 46,421 points — so phase C would make
**`χ(ℚ(√359)²) = 4`** a new exact value. The onset radii also shrank two known refusals, `d = 47` from 8,629 points to
**3,565** and `d = 95` from 17,169 to **6,997**, which are cheaper starting points for extraction. Everything here is
a solver claim until the frozen checker says otherwise.

**P2 lost.** `d = 11` — a `d ≡ 3 (mod 8)` field — produced **four genuine ball refusals** on one lattice
(`q1+q5+6+10.1+10.2+15.1+15.2+30.1+30.2+30.3`, `M = 30`, 108 generators, covolume 2.17e-4), down to radius 1.0 (45,521
points). Not inheritance: that lattice is not the witness lattice (`M = 150`, and `150 ∤ 30`). Verified before being
believed — all 108 generators pass the exact norm equation, the graph has **zero triangles** (G57, since `√3 ∉ ℚ(√11)`),
and 400 sampled edges re-derive as exact unit distances. **So the direct route does land at `d ≡ 3 (mod 8)`.** What
survives of R-mod8 is the plan's own refinement, not its claim: the refusing lattice draws on **ten classes**, "rich in
classes, not coarse", exactly as §3's note about FS-58's witness predicted.

**Decision G is therefore live and should be re-read before phase D**: phase D (the chain route at 35 and 59) was
conditional on R-mod8 surviving phase B, and it has not. The direct route is now known to work at one `d ≡ 3 (mod 8)`
field; whether it works at 35 and 59 is untested, because *they asked zero balls* (below).

**P3 lost**, 8 of 20 `d ≡ 7 (mod 8)` fields against ten or more predicted.

**Both nulls are bounded by what was askable, and this is the phase's most important number.** Of the twenty
`d ≡ 3 (mod 8)` fields, **eighteen asked ZERO balls** — every lattice either certified colourable or over the tier's
600,000-point cap. Only `d = 11` (4 asked, 4 refused) and `d = 155` (2 asked, 2 colourable) asked anything. Of the
twenty `d ≡ 7 (mod 8)` fields, six asked zero, **including `d = 167`**. Across the family: **343 ball records, 124
asked**, 219 over cap, 20 unknown at the wall. So "Not landed at tier 1" at 31 of 40 fields means, overwhelmingly,
*nothing was askable at this depth* — which is why B.5's per-field `balls asked / over cap / unknown` column is in
`census.md` and why the totals line repeats it.

**Cost, projection reconciled.** 1.01 h total; `d ≡ 3 (mod 8)` fields mean **22 s**, `d ≡ 7 (mod 8)` mean **159 s**.
The running projection moved 2.3 → 2.6 → 1.6 → 1.3 → 1.0 h: the drift is the **mod-8 split**, not noise. The first six
fields hold four of the expensive kind, so the early mean was biased high by about 2.3×; the population changed, not
the rate.

**One departure from the plan's wording, in the direction of visibility:** the two-hour per-field stop rule leaves the
remaining balls **unrecorded** rather than writing them `Over cap (not asked)`, so `table --check` reports a gap
("Open with no R = 1.5 record") instead of a verdict the instrument did not earn. No field reached the budget.

**For phase C** (nine fields to certify, smallest refusing ball first): 47 (3,565 points), 119 (5,605), 95 (6,997),
191 (21,845), 11 (45,521), 359 (46,421), 71 (47,597), 23 (248,213), 143 (283,485). The first seven are inside
`direct-witness`'s range as priced in phase 0 (O3: 13,605 points → 52 CPU-s); the last two want the checkpointed
`extract`.

### §R-C — phase C, certifying the nine refusals (2026-09-20, CLOSED; ACCEPTED by the product owner, then re-scored under the owner's rulings)

**All nine tier-1 refusals are certified**, each by the frozen independent checker, with its twelve planted faults,
its wrong-radicand refusal, a decorrelated second opinion, an explicit verified 4-colouring and its 3-adic barrier
count. Record, one row per gate item per field with every plant: **`data/fs61/records/phase-C.md`**.

| d | points | edges | C.9 minimality | C.4b (pinned vertex) | value now stated | what is new |
|---|---|---|---|---|---|---|
| **359** | 1,190 | 3,243 | stopped at 483 of 2,019 | recorded, pass | **`χ(ℚ(√359)²) = 4`** | **a field nobody had scanned** — found by this milestone's census, not inherited |
| **119** | 456 | 1,122 | 1-minimal | required, pass | **`χ(ℚ(√119)²) = 4`** | priced in phase 0, never certified before |
| **11** | 189 | 452 | 1-minimal | required, pass | `χ(ℚ(√11)²) = 4` | the first witness over 11 from the **direct** route (FS-58 used the chain); nine seconds |
| **143** | 664 | 1,600 | stopped at 1,056 of 1,769 | recorded, pass | `4 ≤ χ(ℚ(√143)²) ≤ 5` | priced in phase 0, never certified before |
| 23 | 573 | 1,365 | stopped at 467 of 1,280 | recorded, pass | `χ(ℚ(√23)²) = 4` | re-certified from a smaller ball (248,213 at `R = 1.3`) |
| 47 | 169 | 385 | 1-minimal | required, pass | `4 ≤ χ(ℚ(√47)²) ≤ 5` | reproduces FS-58's 169-point witness exactly |
| 71 | 131 | 306 | 1-minimal | required, pass | `χ(ℚ(√71)²) = 4` | smaller than FS-58's |
| 191 | 292 | 713 | 1-minimal | required, pass | `χ(ℚ(√191)²) = 4` | smaller than FS-58's |
| 95 | 1,004 | 2,829 | stopped at 407 of 1,737 | **recorded, RED** | `χ(ℚ(√95)²) = 4` | the one red cell; it is a minimality question, not a soundness one |

Every upper bound is prior art at hand level, named per README from `frame.jsonl`: the residue plane at 7 where
`L = 4`, at 11 where `L = 5`. Nothing here is kernel-checked.

**P4 ("every tier-1 refusal certifies", 0.9) is scored: 9 of 9.** No extraction stalled and no refusal failed exact
re-derivation — the failure mode P4 named did not occur.

**The deletion policy, which is what phase C had to design.** `extract`'s stage 1 (assumption-core rounds) runs to
its fixpoint — it is the reduction that matters and the frozen tool cannot stop it. Stage 2 (deletion to 1-minimal)
is a nicety C.9 records and never requires, and at `d = 359` it ran at 45 s a step with ~700 steps left, so it gets
`--deletion-budget` (600 s) from its first checkpoint and is then stopped by pid and emitted from that checkpoint.
Five of nine witnesses came out 1-minimal; the four stopped ones are labelled as stopped in the record, the manifest
and their READMEs.

**Three findings a later phase should not rediscover.**
1. **Ball size does not predict `direct-witness`'s cost** — it deletes one vertex at a time against the *whole
   ball's* formula, so the cost is set by the initial core: 8,629 points → 5.7 s (core 169), 13,605 → 51 s (core
   456), 17,169 → unfinished at 2,124 s (core ≥ 1,737). A threshold is a guess about that, so `direct-witness` now
   runs under a wall and falls back to the checkpointed `extract` on the same ball.
2. **A stopped deletion cannot be finished later.** The frozen `extract` stores a scan position into an order built
   from the kept set and, on resume, rebuilds that order from the *smaller* kept set while reusing the old position
   — so it skips the vertices deleted before it. Sound, but only a from-scratch run is 1-minimal.
3. **C.4 was two claims under one number, and the plan contradicted itself.** The owner's ruling 1 split it: C.4a,
   the second opinion proper (steps i and ii), required; C.4b, the pinned-vertex control (step iii), required only
   where C.9 records 1-minimality. **A correction to this section's first version, which said the second opinion at
   `d = 95` was "not reached": the frozen tool is straight-line and the control runs LAST, so the step-(iii) message
   proves steps (i) and (ii) passed.** At 95 the second opinion was reached and passed; only its PASS line was lost.
   The driver now scores the two separately, ties the inference to the tool's sha256 and refuses it if that hash
   moves, and its diagnosis line no longer advises a larger deletion budget, which finding 2 refutes.

**Two defects in the driver were found by running it, both of the shape this project's gate section names — a check
reporting about something other than the thing it guards.** C.2 read the frozen checker's verdict off the *first*
line of output, but `--controls` prints its verdict on the *last*, so that item could never have gone green; and
`Landed (certified)` was read from `certified.out` **existing**, which `land` writes whatever the checker says, so a
REFUSED run would have promoted its field in `census.md`. Both are fixed, both have plants.

**`census.md` reads 9 `Landed (certified)`, 31 `Not landed at tier 1`** (`table --check`: 40 fields, 0 defects;
byte-identical on regeneration). Every `witness.json` is byte-identical to the one C.10 passed — the whole gate was
re-run twice against the committed files and moved no certificate byte. `git status --porcelain data/fs58
tools/fs58_*` is empty. Machine: the desktop, one heavy job at a time, ≈ 4 h 20 m.

### §R-B′ — phase B′, tier `1b`, the radius ladder (2026-09-20, closed)

**B.1–B.7 re-read at tier `1b` and B′.1 all green; 0 defects; nothing halted. No field lands.**
Record, one pasteable row per gate item with every plant: **`data/fs61/records/phase-Bprime.md`**.
Table: **`data/fs61/census.md`** (derived, byte-identical on re-run) and `census.jsonl`, now at tier `1b`.

**What it asked.** Of the 110 rank-4 `Open` lattices, 77 had an `Over cap (not asked)` record at `R = 1.5`; the
rule gave 15 of them a rung at `R = 1.2`, 21 a rung at `R = 1.0`, and left 41 with no rung under the 600,000-point
cap. **36 balls over 19 fields, 277,442–594,931 predicted points each** (plus one onset follow-up), all forty
fields under one tier definition, **167 included**.

**One refusal, at `d = 23`** (`L1510e5aa`, `R = 1.2`, 462,045 points, 3,265,070 edges, 258.91 s) — a field already
`Landed (certified)`, so it is a tenth refusing lattice there and changes no state, and phase C has nothing new to
do. **`land_order()` confirms no field refuses that the phase-C priority order does not already contain.**

**The nulls are now sorted by kind, which is what the phase was for** (the owner's ruling 6, with a third phrase
the ruling's dichotomy does not cover and which turns out to be the majority case):

| the null | tier 1 | tier 1b |
|---|---|---|
| `(by certificate)` — no `Open` lattice left | 11 | 11 |
| `(by budget: k Open lattices, none askable)` | 13 | **5** (35, 59, 83, 251, 323) |
| `(asked: j of k Open lattices, no refusal[, u undecided at the wall])` | 7 | **15** |

Eight fields moved from *never asked* to *asked* — **131, 167, 179, 203, 239, 407, 455, 479**, exactly the eight
the owner's re-plan named — and the family's asked-ball count went **124 → 161**.

**The phase's finding: the binding constraint is no longer the cap, it is the solver.** Of the 37 asks, **24 ran to
the 600 s wall undecided**, 12 were colourable, 1 refused. The lattices tier 1 could not ask are *fine* — small
covolume, many generators — so their balls are large **and dense** (0.7–3.3 M edges on 0.28–0.60 M points), and
CDCL does not decide that shape in ten minutes. **Tier 2 as defined raises the cap to 3,000,000, which makes larger
instances of exactly the graphs that are already undecided**; E.1 should be re-read against this before it is run
(proposal 4 of the phase record: re-ask the 24 `Unknown` balls at a longer wall first — a re-run of the same
command does it — then price cube-and-conquer on one, then consider radii below 1.0).

**`d = 167`, FS-59's field, was asked for the first time**: three of its six `Open` lattices, and **two are
3-colourable in 0.63 s and 1.46 s on balls of 313,748 and 397,140 points**, the third undecided at the wall. Its
row now reads *asked: 3 of 6 Open lattices, no refusal, 1 undecided at the wall* rather than *nothing was askable*.
Consistent with FS-58's 3-colourable balls to 215,409 points there; it aims FS-59 a little and refutes nothing.

**B′.1 is met and the mechanism it guards never fired.** All 37 asked records carry both rung predictions, the rung
chosen, why it was chosen, and the actual count; the ratio actual/predicted ran **0.9982–1.0094** with **0 outside
A.8's 15 % bound**. The exact-overflow descent I added (recorded in the phase record *before* the run, with its
measurement) was therefore never used: the 1.1078 tail that motivated it lives at the small control fields and
coarse lattices, not on this family's fine ones. Registered as a mis-priced risk, not a finding.

**The memory measurement the owner's ruling 4 requires before tier 2 is launched** [measured, this phase]: every
ball record now carries the worker's peak and end-of-ball RSS. Largest ball asked **595,257 points / 2,370,078
edges**, worker peak **1.93 GB**; max worker peak over all 37 balls **2.47 GB**; **3.37 GB (median) to 5.22 GB
(max) per million points**, so **10–16 GB per worker at tier 2's 3,000,000-point cap** — sixteen workers would ask
160–250 GB of a 128 GB machine. `available memory / peak` gives **six workers, not more than eight**, and the
figure is a floor because tier 2's `NMAX = 420` produces finer lattices with more edges per point. The whole
16-wide tier-1b run peaked at **17.9 GB**.

**Cost.** 20.5 min wall, 16 workers, one pool over the family. The first attempt pooled *inside* each field —
2 to 6 workers of 16 — and was stopped after three fields on Kooshi's observation that the machine was idle; cause,
measurement and forfeit are in the phase record, written before the signal, and the forfeit was at most three balls
because every finished ball is its own fsynced record.

**Three repairs shipped with this phase, each with a plant that was seen to fire.** `load_jsonl` **wrote to the file
it read** — it truncates a partial final line to a length measured earlier, so a read concurrent with a write could
destroy finished records; it is now guarded and says so (no records were lost: 1,760 checked straight off the
bytes). Phase C's field list is now read from the records, so a field that refuses for the first time at a later
tier is appended rather than silently skipped. And a landing record carries `ball_tier`, the tier that asked the
ball, which is not the flag the command was given.

**The `evidence` column no longer reads `kernel` at `d = 11`** (the owner's correction). §7's
`evidence ∈ {kernel (11 only), …}` is retired: no row of `census.md` is kernel-checked. The kernel's
`four_le_chromaticNumber_planeOver_eleven` rests on FS-58's **204-point chain witness**; this census's `d = 11` row
is a **189-point direct witness**, a different graph. The legend, a note under the table and the `d = 11` witness
README each now say which is which.
