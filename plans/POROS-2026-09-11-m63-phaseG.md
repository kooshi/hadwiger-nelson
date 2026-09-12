# Poros — M63 phase G: other bases and the sieve's rotations

*Advisory record, 2026-09-11. Written by Poros (`~/source/poros`) alongside the engineer drafting
`plans/M63-phaseG-bases-and-rotations.md`. Uncommitted by me; the engineer commits it by path.
Cards are numbered C1–C8 and are stable identifiers — cite them, score them, kill them in place.*

## The frame, on its five axes

| axis | as the record states it | address |
|---|---|---|
| **object** | a base point set plus a rotated copy, joined by cross edges — the "type M" construction | `plans/M63-parts-reproduction.md` §G, `tools/typem.py` |
| **question** | do rotations other than `ρ₁₅`, or other bases, carry a refusing construction — and can one go below 509? | `[Parts2020a]` §4: *"Working constructions of type M with other rotations are not known yet"* |
| **discipline** | two of them: the arithmetic of small primes over `ℚ(√3,√11)` (which rotations can matter), and hitting-set / MUS enumeration (what a reduction costs) | G35/G43/G48; row 62 |
| **audience** | the phase's own next session, and — for a negative — a literature that has used one rotation for fifty years | FS-30 |
| **product** | **Kooshi, 2026-09-11:** *"reproduce Parts' METHOD so that we can find smaller graphs he may not have gotten to … introduce new bases and rotations, where it is most likely to actually find something novel"* | MEMORY, CLAUDE.md § Frontier |

The product axis is where this phase is most likely to slip. The stated goal is **the method, turned
on new ground**. A census that eliminates rotations is a finding *about the instrument's reach* unless
its quantifiers are exact; a census that spends the phase's cores and returns "N classes eliminated"
without naming the base, the radius and the law it eliminated them at has changed the product from a
construction to a catalogue. C5 and C6 are that risk made checkable.

## R1 — The finding of this session, exact and controlled

**A radius pair `(a, b)` can carry a type-M cross edge only if `ab` is a square in K.** The derivation is
the code's own, in two steps: a rotation whose sine leaves K forces `q = 0` in `conj_mul(u, v) = p + iq`
(`typem.CrossLaw.joins`, `typem.py:1216`; the same derivation `cross_edges_rho15_fast` rests on), and
`p² + q² = |u|²|v|² = ab`, so `ab = p²` with `p ∈ K`. **The sieve never tests it** (`typem.py:181-190`
accepts a pair whenever `D = ab − k²` is non-negative and not a square, working from the radius spectrum
alone).

Measured exactly over `data/m62/rotations-moser-r2.05.json` with the repository's own `k_is_square`:

| quantity | as stored | edge-capable |
|---|---|---|
| radius families across the 150 stored classes | 1,058 | **131 (12.4 %)** |
| classes meeting the "≥ 2 families" admissibility bar | 150 | **32** |
| the record's own class | 7 | 3 |
| the rank-1 class, which heads the ranking | 31 | 6 |

**A class is a field, not a rotation.** Among edge-capable pairs the cosine is pinned — `c = k/p` with
`p = √(ab) ∈ K`, so `1 − c² = D/ab`. Of the record class's three edge-capable pairs, exactly two satisfy
`D/ab = 15/64` (`c = 7/8`); the third lies in the same radicand class at a different cosine, i.e. it is a
different rotation in the same field. So the 412 enumerate **square classes of the radicand** — the right
unit for the arithmetic ranking, since the 2-adic wall and 6-openness depend only on the field, and the
wrong unit for a geometric census.

**The control, run before any of it was believed** (G21: point a new instrument at a known positive).
The committed `ρ₁₅` law on `Base(2.6)` gives 126 ordered cross edges — the set control c5.1 already
certifies edge for edge. They span **three** radius pairs: the shared centre with radius 1 (60 edges), the
conjugate pair `17/6 ∓ √33/6` (36 edges), and radius 4 with radius 4 (30 edges). All three have `ab` a
square in K; all three satisfy `D/ab = 15/64`. The centre pair is invisible to the sieve by construction
(`a = 0` gives `D = −k² < 0`), so the sieve should see exactly two of the three — and the two it sees are
the two the cosine test selects out of its seven. The necessary condition holds wherever it must, and the
cosine test selects precisely the rotation's real kinds.

**What this retires.** FS-30's second lead, verbatim: *"The record's own rotation admits SEVEN radius
families and Parts uses TWO … Five unused cross-edge kinds sit at the rotation the record is already built
on."* There are **zero** unused kinds at `ρ₁₅`: the seven are seven radius pairs sharing a field, two of
them are `ρ₁₅`'s, and both are used. **Scope of the kill, stated narrowly:** what dies is the
seven-families framing and the "five unused kinds" sentence. The roadmap's experiment (d) is adjacent and
survives — more *orbit pairs* to connect **within** the two realized kinds is untouched. Only the claim
that unused *kinds* exist is false.

**What it hands the phase, which is the better half.** Card C4 asked how many classes have `cos θ ∈ K` and
called it a file read. Wrong, in a useful direction: the cosine is not in the file, and it needs no
derivation either — it is a division, available the moment one groups by radius pair rather than by
radicand. Three consequences:

1. **Every edge-capable pair has `cos θ ∈ K` automatically**, `k` and `p` both lying in K. So `CrossLaw`
   already covers every rotation reachable through the `q = 0` route, and the gap its docstring names
   (`cos θ ∉ K`, "not implemented") is unreachable from the sieve's own derivation — such a rotation would
   need cross edges with `q ≠ 0`, which the sieve never enumerated either. That derivation should not be
   paid for until something shows the corner is non-empty; it was a line item on the phase's critical path.
2. **The re-sieve already on the checklist gets a second job free.** Item 1 of §G re-sieves on the §5.6
   lattice; adding the `ab`-square filter and the cosine grouping to the same pass yields an enumeration of
   *rotations* with their true kind counts **and** the radicand classes for the arithmetic ranking — both
   units, one run, and the original sieve was 45.6 s.
3. **The ranking becomes honest at the same moment.** FS-30 prescribes ranking by distinct radius families,
   the wall and 6-openness. The stored family count is not the quantity FS-30 means; the edge-capable count
   is. Ranking on the stored column ranks mostly on pairs that cannot carry an edge.

**Two facts from the same reading, neither mine to fix, both belonging in the plan's risk list.**
*Neither rotation file is reproducible from committed code* — the keys `type_m_admissible`,
`record_rotation` and `max_families` appear nowhere outside the JSON, and committed `cmd_rotations` cannot
reproduce even the sibling file (it would write `classes_leaving_K = 1336` where the file says 2042). The
phase's input is an orphan artifact, so it is provenance and not data, and no threshold should be tuned
against it. *A float sign test sits inside a verdict* — `typem.py:185`, `if kfloat(D) < 0`, on an exact K
element, while the file's own `claim_scope` states that floats appear only in the radius cut and in sort
keys. The error is silent and drops candidates, so 412 may be an undercount for a second, independent
reason; `radius_families` canonicalises with `kfloat` too.

## R2 — The snippet, for the re-sieve implementer

§9 item 1 asks for one pass emitting both units: rotations grouped by exact cosine, and radicand classes
for the arithmetic ranking. Both are available from helpers already in `tools/typem.py`, and **neither
needs a square root in K** — which matters, because `typem.py` exposes `k_is_square` but no `k_sqrt`, and
writing one is the obvious wrong turn here.

```python
def edge_capable(a, b):
    """A radius pair can carry a type-M cross edge only if ab is a square in K.
    q = 0 is forced when the sine leaves K (CrossLaw.joins, typem.py:1216), and
    p**2 + q**2 = |u|**2|v|**2 = ab, so ab = p**2 with p in K."""
    return T.k_is_square(T.kmul(a, b))

def cos_sq(a, b):
    """The ROTATION key: cos^2 = k^2/(ab) with k = (a + b - 1)/2, from cos = k/p and p^2 = ab.
    Exact, and it needs no square root: two edge-capable radius pairs belong to the same
    rotation exactly when this element of K agrees."""
    k = T.kscale(T.ksub(T.kadd(a, b), T.ONE), Fr(1, 2))
    return T.kdiv(T.kmul(k, k), T.kmul(a, b))
```

`cos_sq` keys the rotation up to the sign of the cosine. Negating it is rotation by `π − θ`, which on a
centrally symmetric base — every lattice here is closed under negation — is rotation by `−θ` composed with
a symmetry of the point set, so the sign is absorbed and `cos²` is the right granularity. Say so in the
re-sieve's docstring; on a base that is *not* centrally symmetric the two signs are different rotations and
the key must carry it.

**Verified on the known positive, both halves.** Over the 126 committed `ρ₁₅` cross edges of `Base(2.6)`:
60 are centre edges (`ab = 0`, no key) and **all 66 of the rest return `cos² = 49/64` exactly**, which is
`(7/8)²`. And on the record class's seven stored families: four are not edge-capable, two return `49/64`,
and the seventh returns `417/512 − (15/512)√33` — the third rotation in the same field, now with its
cosine in hand rather than inferred.

**The two units, one pass.** Group the edge-capable pairs by `cos_sq` for the rotation enumeration and the
true kind counts; keep the existing square-class merge on `D` for the radicand classes, which is what the
2-adic wall and 6-openness read. The same loop emits both, and the original sieve ran in 45.6 s.

## Evidence inventory

- `plans/STUB-consume-rotation-list.md` (FS-30) — read against: the rotation list is unconsumed and generalising the cross-edge law is the first code task — **surprised: yes**; the roadmap's H-5 row says the law is already a parameter with three controls, so the stub is stale on its own first task
- `plans/M63-parts-reproduction.md` §G (lines 341–356), rows 13, H-4, H-5, line 368 — read against: phase G is unscoped — surprised: yes; it is scoped in seven checklist items, and two of its standing hazards (truncated list, wrong lattice) are already named as *not done*
- `tools/parts_loop.py` lines 440–620, 985–1070 — read against: the anchor is a control — **surprised: yes**; it is also the upper half of a reported value (line 583) and its absence is silent (line 500)
- `tools/parts_loop.py:609` + roadmap line 323 — read against: nothing in particular — **surprised: yes**; §3.3's rule forbids a capped level from seeding a loop, which makes the bootstrap's unbounded enumeration cost a *rule* problem and not only a budget problem
- `data/m62/m63-map-A412.json`, `…-first.json` — read against: "A412" is the 412 rotations — **surprised: yes**; A412 is a 412-vertex accumulator, not the rotation list. The two are one keystroke apart in every filename in this phase and I misread it once already
- `plans/POROS-2026-09-11-m63-phaseF.md` line 25 — read against: the 214–246 s medians describe the runs — surprised: yes (my predecessor's finding, re-read here): p50 185, p90 269, max 418, ratio 2.26
- `data/m62/rotations-moser-r2.05.json`, `rotations-r2.05.json` — read against: 412 and 396 records of rotations with exact algebraic data — **surprised: yes, twice**. The files hold the top 150 and top 200, not 412 and 396; a record carries the radicand and the radius families but **no cosine**, so it names a field and not a rotation; and 87.6 % of the stored families cannot carry an edge at any rotation (R1). The sibling file is not "the other base" as FS-30 says — same lattice, same radius, same point count, produced before the square-class merge existed
- coordinator's live numbers (Parts's recorded 30-vertex expansion): optimum 373 at 188 s, level set 79 min and climbing at 11,700 minima — read against: reduction cost is one number — surprised: yes; it is two numbers two orders of magnitude apart, and only one of them is what a census needs

## Hunch ledger

hunch: the-accumulator-is-needed-for-coverage-not-completeness
  claim: the accumulator's role in the loop is to source the expansion menu, so an
    under-enumerated accumulator costs menu breadth and not soundness; §3.3's ban on a capped
    level is therefore stricter than the menu role requires, and a budgeted bootstrap with a
    declared cap is legal for menu generation even though row 62's rung-minimum claim needs
    completeness
  basis: read
  falsifier: a named consumer of the accumulator whose correctness — not merely its yield —
    depends on the level being exhaustive, anywhere on the menu path
  registered: 2026-09-11
  status: open — this is C1's load-bearing half and the one I am least sure of

hunch: a-dropped-edge-reads-as-a-sound-elimination
  claim: in the census's elimination test, a cross-edge law that under-generates edges yields a
    graph that is easier to colour, yields SAT, and reads as a true negative; so the census's
    error mode is silent and points in the direction that makes the phase look productive
  basis: derived
  falsifier: a per-law gate that reproduces a known edge set exactly, failing when edges are
    dropped — c5.1 is that gate if it is run per law rather than once
  registered: 2026-09-11
  status: open

hunch: the-cost-ranking-and-the-arithmetic-ranking-agree
  claim: per-rotation base sizing of the `t² ≤ 1/(1 − c²)` shape blows up as `cos θ → 1`, i.e. for
    small-angle rotations, which are exactly the maximally-coupled ones that stay inside
    ℚ(√3,√11) where Theorem B four-colours everything; so the census is cheap precisely on the
    rotations worth testing, and base sizing is a selection instrument rather than an overhead
  basis: analogy
  falsifier: the per-law base-size bound computed across the admissible classes, showing no
    monotone relation between required radius and the 2-adic/6-openness ranking
  registered: 2026-09-11
  status: open — offered in the hypothetical mood; ten minutes to kill or confirm

hunch: the-ab-square-filter-cuts-the-census-denominator-fivefold
  claim: applying the edge-capability filter to all 412 classes leaves on the order of 90 with two
    or more edge-capable radius families, so the census's true denominator is about a fifth of the
    number the phase is planning against
  basis: measured
  falsifier: the re-sieve over all classes returning substantially more than ~90 survivors, which
    would mean the stored top-150 is unrepresentative in the direction opposite to the one I expect
  registered: 2026-09-11
  status: open — the rate is measured only on the ranked head, and the head was ranked by the very
    quantity the filter corrects, so selection bias is live and could push either way

hunch: a-radius-pair-can-carry-a-cross-edge-only-if-ab-is-a-square-in-K
  claim: q = 0 is forced whenever the sine leaves K, and p^2 + q^2 = ab, so ab = p^2 with p in K
  basis: derived
  falsifier: a committed cross edge whose radius pair has ab a non-square in K
  registered: 2026-09-11
  status: confirmed (by: all three radius pairs spanned by the 126 committed rho15 cross edges on
    Base(2.6) have ab a square in K and satisfy D/ab = 15/64; and the sieve sees exactly the two of
    them it can see, the centre pair being excluded by D < 0)

hunch: the-cos-not-in-K-family-is-likely-empty
  claim: rotations with cos outside K carry no type-M cross edge, so CrossLaw's stated gap is
    unreachable and the derivation need not be paid for
  basis: derived
  falsifier: an explicit rotation with cos outside K carrying a cross edge
  registered: 2026-09-11
  status: killed (by: de Bruijn, same day — for any pair with q != 0 the rotation
    rho = (k + i*sqrt(D))/w carries it and has cos = (kp + q*sqrt(D))/ab, outside K exactly because
    q != 0; such pairs are most of every base, so the family is non-empty by a one-line
    construction). The mechanism of my miss: I inferred emptiness from "the sieve never enumerated
    them", i.e. from the absence of a thing in an instrument, and an instrument's silence is not a
    fact about the world -- G21's own rule, turned on myself. The useful question was never
    emptiness but whether any such rotation carries TWO kinds, which is a census of minutes.
    What survives: the schedule conclusion, that the law is derived now and implemented only if the
    census says the set is non-trivial.

hunch: a-capped-accumulator-is-legal-for-the-menu-and-nothing-else
  claim: completeness of the level is required for any claim ABOUT {M} -- CLAUDE.md ledger row 62's
    rung-minimum statement, and every "{M} grew" verdict under acceptance clause 2c -- and not for
    the menu, whose loss under a cap is breadth and not soundness, since the refusal bound comes
    from the optimisation and not from the enumeration (tools/parts_loop.py:601-625,
    plans/M63-parts-reproduction.md:323)
  basis: derived
  falsifier: a consumer downstream of the menu whose correctness, not merely its yield, needs the
    level exhausted
  registered: 2026-09-11
  status: confirmed (by: de Bruijn, who drew the boundary and named the two consumers that die
    under a cap; conditional on an audit of every menu-downstream consumer, which neither of us has
    run). Carried with its condition: the cap must be printed every run and every number derived
    from a capped level must render as a bound and never a value, or the capped union is read later
    as a level set by someone who was not there.

## The cards

question: how-many-admissible-classes-have-cos-theta-in-K
  STATUS: WITHDRAWN 2026-09-11, replaced by C9. Kept per deprecate-never-delete. Killed by R1: the
    question is malformed. A class does not determine a cosine (it is a square class of the radicand,
    i.e. a field, and holds several cosines); and every edge-capable radius pair has cos in K
    automatically, since c = k/p with k and p both in K. The premise that a derivation was needed to
    turn a record into a law was wrong — it is a division. The mechanism of my miss: I took "the
    record carries the radicand" to mean the radicand identifies the rotation, and never asked what
    else a radicand class contains. The rule amended: before pricing a derivation, check whether the
    quantity is pinned by data already in hand.
  evidence: the roadmap's H-5 row marks the cross-edge law done as a parameter (`typem.CrossLaw`,
    `Stage(cross_law=…)`, controls c5.1/c5.3/c5.4) and gates the remainder to phase G as "the laws
    at `cos θ ∉ K`"; FS-30 still calls generalising the law "the first code task"
  expected: the parameterised law covers most admissible classes, so the compute census is the
    phase's main cost
  ask: of the admissible rotation classes on disk, how many have `cos θ ∈ K`, and how many need
    the underived law?
  if most are inside: the compute census is the phase and the cost model in C1 is the next question
  if most are outside: phase G is a derivation task first, the census is aimed at a nearly empty
    set, and the plan's centre of gravity moves from cores to algebra
  answered by: the record — a file read plus a field-membership test, seconds
  cost: minutes
  hunch: nobody has computed it; it appears in no artifact I found
  falsifier: a field in the rotation JSON, or a count in any plan, that already reports it
  rank: 10

question: which-of-three-purchases-does-the-census-make-per-rotation
  evidence: `tools/parts_loop.py:609` quotes §3.3 — "a capped level halts the loop; no loop may
    start from a capped union"; the roadmap (line 323) calls a capped level's union "a sample and
    not the loop's state variable"; and on one live run the optimum came at 188 s while the
    complete level is at 79 minutes and climbing, 11,700 minima
  expected: a reduction has one cost, and the flatness measurement prices the census
  ask: per rotation, does the census buy a screen, an optimum, or a complete accumulator — and
    does the cost model say which?
  if a screen or an optimum: the census is affordable, the bootstrap is deferred to survivors
    only, and the 100x error cannot be made
  if an accumulator per rotation: the phase is gated on an enumeration with no known ceiling, and
    that belongs in the plan's first paragraph rather than in its budget table
  answered by: human — de Bruijn, who states the tier per rotation before the cores are aimed
  cost: none; it is a sentence in the cost model
  hunch: the plan will price the screen and need the accumulator, because the accumulator is the
    loop's state variable and the loop is what "reproduce the METHOD" means
  falsifier: a cost model naming the tier per rotation with the level's cost carried separately
  rank: 2

question: does-the-new-base-path-refuse-to-run-without-an-anchor
  evidence: `parts_loop.py:583` — `entry["M"] = incumbent + 1  # free: >= by the refutation,
    <= by the anchor`; `check_invariants` writes the anchor block only `if anchor is not None`
    (line 500) and otherwise returns `restriction-identity-holds` with no trace that it was
    skipped; `parts_diag.py:196` and `parts_rule.py:387` already pass `anchor_tuples=None`
  expected: the anchor's absence on a new base removes a guard
  ask: with no anchor, does the run refuse, or does it report an `M` whose upper half is unproven?
  if it refuses: the sequencing constraint is enforced by the code — no map before the bootstrap —
    and the new-base hazard is closed at its source
  if it runs: two changes are owed — a declared-absence verdict printed every run, in the shape
    `scripts/vacuity.sh` already uses for deliberate emptiness, and `entry["M"]` degraded to a
    bound render whenever the anchor is absent
  answered by: human — de Bruijn; then the code path itself
  cost: an hour
  hunch: it runs, and the silent path is already live in two callers rather than a future risk
  falsifier: a guard on the None path that raises or records
  rank: 3

question: what-does-an-elimination-prove-about-a-rotation
  evidence: roadmap row 13 — the files hold the **top 150 of 412** and **top 200 of 396**, sieved
    on the Moser lattice's radius spectrum and not the §5.6 lattice the record lives on; H-4 marks
    that not done
  expected: the census sweeps the admissible classes
  ask: does an eliminated rotation's headline name the base, the radius and the law it was
    eliminated at, or does it say the rotation is dead?
  if it names all four: the negative is a result — it answers `[Parts2020a]` §4 for a stated
    family, and its quantifiers survive a reader
  if it says dead: the phase has produced a claim broader than its enumeration, which is the
    failure mode G21 exists for, and the eliminated classes will have to be re-run to say anything
  answered by: human — de Bruijn, in the headline sentence, written before the census runs
  cost: none
  rank: 6

question: is-the-census-measuring-the-rotation-or-the-law
  evidence: the elimination test is "the full base is 4-colourable, so every subgraph is, so the
    rotation is dead" — valid; but a law that misses cross edges yields an easier graph, yields
    SAT, and reads as a true negative
  expected: the SAT call is where the census can go wrong
  ask: is the per-rotation cross-edge law gated against a known edge set before its verdict is
    believed, per law rather than once?
  if gated: an elimination measures the rotation, and the negative is worth reporting
  if not: the census measures the law's completeness, its errors all point toward "eliminated",
    and no count it produces bounds anything
  answered by: human — de Bruijn: promote c5.1 to a per-law admission gate, and add a brute-force exact all-pairs check at small radius for each new law
    all-pairs check at small radius for each new law
  cost: hours, and it is the cheap half of the cheap/sound trade
  hunch: registered above — a dropped edge reads as a sound elimination
  falsifier: c5.1 invoked per law in the census path
  rank: 4

question: what-control-fires-when-the-apparatus-is-broken-on-a-new-base
  evidence: the known-answer anchor needs a known minimum and a new base has none; the restriction
    identity (check 2) needs no prior answer and survives; CLAUDE.md's phase-C post-mortem names
    nine instruments that broke, eight by silence, and mints the rule that every check needs a
    positive signal for the thing that did not happen
  expected: the new base has no controls, so the phase proceeds on unfamiliar ground uninstrumented
  ask: which controls assert rather than react on a base with no known answer?
  if the sandwich and the transported answer are adopted: the new base is instrumented without any
    prior knowledge — refusal is upward-closed, so a superset of a refuser must refuse and a subset
    of a colourable selection must be colourable; and a base automorphism applied to any selection
    must leave the answer unchanged, which catches the index/label mismatch that already produced
    a false refutation once in this project
  if they are not: the phase runs its most novel ground with its weakest instrumentation, which is
    the inversion the record warns about
  answered by: human — de Bruijn
  cost: two asks per stage, plus a per-base planted fault of the kind the edge verification already
    runs
  rank: 5

question: does-the-flatness-datum-reach-a-rotation-census
  evidence: `plans/POROS-2026-09-11-m63-phaseF.md` line 25 — p50 185 s, p90 269 s, max 418 s, ratio 2.26 over 266 timed entries; and the 3/12/24-point flatness was measured across added points on ONE fixed stage
    a rotation census varies the graph itself. And the phase-F record already re-read the medians:
    p50 185 s, p90 269 s, max 418 s, ratio 2.26 over 266 entries
  expected: 24 added points is the edge of a valid extrapolation
  ask: is the census priced off a measurement taken on a different axis?
  if yes: the budget rests on a quantity nobody measured, and the screen tier does not use the
    reduction at all, so the flatness prices the wrong instrument
  if no: the plan names what it measured the census's cost on, per tier
  answered by: human — de Bruijn, in the cost model
  cost: none
  rank: 7

question: does-the-rotation-file-carry-what-the-ranking-needs
  evidence: FS-30 requires ranking by distinct radius families, the 2-adic wall-breaking radicand
    and 6-openness under the M58 sieve, and forbids ranking by cross-edge count; the file's own
    fields are unread by me
  expected: the file carries the radicand, from which the wall test and 6-openness are computable
    without re-deriving anything
  ask: does a record carry the radicand and the family count, so the theory-ranking is a file read
    rather than a re-derivation?
  if it carries them: the ranking is minutes and precedes every core spent
  if it does not: the sieve must be re-run — which the roadmap wants anyway on the §5.6 lattice —
    and the ranking's cost joins the bootstrap's in the plan
  answered by: the record (delegated read, in flight)
  cost: minutes
  rank: 9

question: does-the-re-sieve-enumerate-rotations-or-fields
  evidence: R1 — 131 of 1,058 stored radius families are edge-capable, 32 of 150 classes keep two,
    and the record's class holds three edge-capable pairs at two different cosines, exactly two of
    them at c = 7/8; the committed 126 cross edges confirm the condition and the cosine test
  expected: the 412 classes are 412 candidate rotations, and the family counts rank them
  ask: does the re-sieve on the §5.6 lattice group by pinned cosine, so its output is an
    enumeration of rotations, or does it group by radicand as the present one does?
  if by cosine: the phase gets its true candidate list, the true kind counts, and the radicand
    classes for the arithmetic ranking, from one 46-second pass — and the ranking FS-30 prescribes
    becomes computable on the quantity FS-30 means
  if by radicand: the census enumerates fields, tests one cosine per field, and any elimination it
    reports covers one point of a class that holds several — a weaker claim than the phase intends
    and one no reader could check
  answered by: run — the re-sieve already on the §G checklist as item 1, with the filter added
  cost: the filter and the grouping are a few lines inside a pass that is already planned
  hunch: registered below — the cheap filter also cuts the census's denominator by about 4.7x
  falsifier: a class whose edge-capable pairs all share one cosine, found across the stored 150,
    would mean radicand and rotation coincide in practice and the grouping is cosmetic
  rank: 1

question: is-the-phase-input-provenance-or-data
  evidence: the keys `type_m_admissible`, `record_rotation` and `max_families` appear nowhere in the
    repository outside the JSON; committed `cmd_rotations` would write `classes_leaving_K = 1336`
    where the sibling file says 2042; the files hold the top 150 and 200 of their populations; both
    were sieved on the Moser lattice, which `typem.py:425-427` records as the WRONG base, caught by
    the non-vacuity gate (only 90 of Heule-510's 510 points lie in it at any radius)
  expected: the rotation list is a derived artifact the phase can build on
  ask: is any number in the plan — a count, a threshold, a rank cut — read from a file no committed
    code can reproduce?
  if none: the re-sieve supersedes the files and they are provenance, which is the clean outcome
  if some: that number is unfalsifiable by construction, and the phase inherits a figure whose
    producer is gone; the 412 in particular should not appear in a headline until it is re-derived
  answered by: human — de Bruijn
  cost: none
  rank: 8

## What I did not ask, and why

No card on whether the phase should run at all, and none on the choice between new bases and new
rotations. Both are Kooshi's, and both are already decided in his words on the product axis. My
concern is only that what the phase *reports* matches what it *enumerated* — C4, C5 and C6 are three
faces of that single worry, and C1 and C2 are about paying for it accurately and knowing when the
apparatus is lying.
