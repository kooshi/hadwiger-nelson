# Poros — FS-53 planning pass (2026-09-15, before the planner)

*Advisor's report on the PLANNING of FS-53, "the sixth colour". Written for a planner with zero conversation memory:
every object is named in the vocabulary of the field that owns it before it is named in this project's. My expectation
was written to scratch before any record was opened (`~/.claude/jobs/b1507518/tmp/poros53/EXPECTATION.md`) and is scored
in §1. Every number below was recomputed here from the primary records with numpy and exact arithmetic, or carries a
file path. Citations I could not open are marked "recalled, not read". I spawned nothing, ran no solver, touched no GPU.*

---

## The verdict in one paragraph

**The stub points a GPU-day at the four primes where the semidefinite instrument provably cannot decide anything, and
leaves unrun the three CPU-minute experiments that decide the milestone's shape.** The instrument bounds the
independence number `α` from *above*; it can therefore only ever *remove* a prime from the window, never place a six. Its
measured strength is 0.82–0.90 of the ratio bound (Hoffman) bound; refusing six needs it to reach the fraction
`⌈q²/6⌉ / Hoffman`, which is **0.675 at 23, 0.670 at 31, 0.782 at 43, 0.791 at 47** — out of reach by 10–25 % — and
**0.920 at 67 and 0.947 at 79**, which it should clear. So phase A as ordered ("23 and 47 first") buys nothing at 23, 31,
43 and would buy at 67 and 79, where it was not pointed. Meanwhile: **nobody has ever asked whether any window plane is
six-colourable.** The chromatic asks on record at 23, 31, 43, 47 are `k = 5` only, all undecided at four hours; at
`q = 27` they stop at `k = 5`; the only `k = 6` asks in the whole repository are at 83, where six is now refused. A
six-colouring, if one exists, is a *satisfiable* instance, and satisfiable instances are cheap — this is the one place in
the milestone where a few minutes of one CPU can end the question. Second: the window has **eight** members, not seven —
`q = 27` satisfies the same hypothesis (residue field 𝔽_q with q ≡ 3 mod 4, odd residue degree) and sits inside the Weil
cutoff, and the project has already built it, measured χ(𝔽₂₇²) ≥ 5, and named the number field that sees it
(ℚ(√3, α), α³ = α + 1, where 3 is inert in ℚ(α); `tools/fplane.py` line 992). Third: Kooshi's asymptote is real and its
sign is the opposite of the intuition. The fractional chromatic number of these planes is *exactly* `q²/α` (they are
vertex-transitive), it **diverges** like √q, and it crosses 6 between q = 23 and q = 31. Six is not a ceiling the planes
approach from below; it is a value a diverging sequence passes through once, and the milestone is asking whether it lands
on it. **My bet, 2:1, with a falsifier that costs minutes:** no window plane is six-chromatic, because `α(23) = 87 or 88`
against the 89 a six-colouring needs — the 87-set is a 300-second, 16-thread, 22,390-restart plateau on the one plane
where that search has demonstrably converged, and it carries 51 % of its Fourier mass on the bottom eigenspace, the
signature of an extremal set. *Falsifier: a verified independent set of 89 points in UD(𝔽₂₃, 2), or a six-colouring of
it.* **The first measurement is that pair of questions at 23, then at 27 — one core, under an hour, before any GPU.**

---

## 0. The frame, on its five axes

| axis | as the stub has it | what the reading moves it to |
|---|---|---|
| object | the prime p | **`α(q)`, the independence number of the plane over 𝔽_q**, for q ≡ 3 (mod 4) of odd residue degree — the plane is vertex-transitive, so χ_f = q²/α exactly, and every threshold in the stub's §2 table is that identity in disguise |
| question | "which p has χ = 6?" | "**what is α(q), and does it land in [⌈q²/6⌉, ⌈q²/5⌉)?**" — the bit falls out, and the same number also answers FS-17's five-question |
| discipline | spectral finite geometry + algebraic number theory | add **extremal combinatorics over finite fields**: "the largest subset of 𝔽_q² avoiding a fixed distance" is the Erdős–Falconer/Iosevich–Rudnev room, and it is where the growth law of α lives (*recalled, not read:* Iosevich–Rudnev 2007) |
| audience | the project's ledger | unchanged, but the **certificate side and the finding side have different readers**: a refusal is an exact rational dual certificate, a six-colouring is a 729- or 529-entry table the kernel checks by `decide` |
| product | a table of χ across the window, plus a field | the same table, but its **rows are α, with χ derived** — and the durable product either way is *the growth law of α for finite Euclidean planes*, of which "is six attained" is one corollary |

The object, question and discipline lines I have moved and defend below. The product line is Kooshi's (card 5).

---

## 1. Evidence inventory — my expectation, written first, then scored

- `plans/STUB-sixth-colour.md` §0–§9 and §PA — read against: the semidefinite sweep would lead and the colouring side trail it; P1's falsifier unreachable — surprised: yes, and worse — the colouring side does not exist as an experiment anywhere in the record
- `data/fplane/chi-p23-k5.json`, `chi-p31-k5.json`, `chi-p43-k5.json`, `chi-p47-k5.json` — read against: `k = 5` undecided, with some `k = 6` or `k = 7` ask beside it — surprised: yes; one row each, `k = 5` only, all `unknown` at 14,400 s
- `data/fplane/chi-q27.json` — read against: 27 absent from the project — surprised: yes, twice — it is present (k = 4 UNSAT in 6.9 s, k = 5 unknown at 2,328 s, so χ(𝔽₂₇²) ≥ 5) and it is absent from the stub's §2 window table and from `CLAUDE.md` G56
- `tools/fplane.py` (the `chi_q` path) — read against: it reproduces `chi-q27.json` — surprised: yes; `field_q27()` was deleted by commit `a3adc46`, the shipped tool raises `NameError`, the self-test does not cover it, and the body survives only in `.claude/worktrees/fs38-stubs-paper/tools/fplane.py:887`
- `data/fs50/alpha-p23-ge87.json` and `data/fs50/wo18/p23-alpha87.json`, `p23-k5.json` — read against: 87 is a weak stopping point chosen in advance — surprised: yes, in the other direction; `p23-k5.json` is a 300 s × 16-thread run with 22,390 restarts in which every thread sat at 87 from the 2-second mark to the deadline
- `data/fs50/wo18/p11-alpha28.json`, `p11-target29.json` with `data/fplane/alpha-p11.json` — read against: nothing — surprised: yes; the same searcher plateaus at 28 at p = 11 and 28 **is** α(11) (cadical refuses 29) — the one calibration of the tool against truth, and it is exact
- `data/fplane/theta-below-83.json`, `chi-p3.json`, `chi-p7.json` — read against: the "+1 over the spectral floor" reading has three supporting points — surprised: yes; it has a fourth, decided, omitted and falsifying point — p = 3 has floor 3 and χ = 3
- `data/fplane/periodic-below-71.json` — read against: the line-periodic upper bounds 8/8/8/10/10/12 — surprised: no; and its `alpha_plane_ge` column is where α(19) ≥ 76 comes from
- `plans/POROS-2026-09-14-fs50-planning.md` §3.1, §3.4 and its ledger — read against: my own last pass, to avoid repeating it — surprised: no, but two of its findings are load-bearing here and unused by the stub — the Fourier profiles (51 % at 23, 1.7 % at 83) and "the free search at 83 has not converged; at 23 it has"
- the exact spectra, recomputed here (`tools/fplane.spectrum`, and 𝔽₂₇ rebuilt by hand) — read against: the stub's §2 table — surprised: no for the primes, every figure reproduces; new for 27, whose λ_min is **−8 exactly**, integer spectrum {−8, −5, −2, 1, 4, 7, 10, 28}
- the absent: a `k = 6` colouring ask anywhere in the window; an α lower bound at 31, 43, 47, 59, 67 or 79; any α search at 27 — read against: a record planning a milestone about six colours would hold the first — surprised: yes; none of the three exists, and this is where the report's content comes from

**Scored:** E1 (the instrument is aimed wrong) — confirmed, with numbers. E2 (α is the object) — confirmed. E3 (the growth
law; α ≈ 0.79 q^1.5) — **half wrong and I retract the constant**: α(19) ≥ 76 normalises to 0.918, not 0.79, and the record
already carries a better law (α/Hoffman ≈ ln d/√d, my own FS-50 ledger). E4 (nobody has looked at the extremal sets) —
**wrong, I did, on 2026-09-14**, and the answer is in §3.1 of that pass; the surprise is that the stub does not use it.
E5 (27 missing) — confirmed for the stub and G56, wrong about the project. E6 (17: ask k = 6 first) — stands. E7 (P1's
falsifier unreachable) — confirmed. E8 (the field half is elementary) — confirmed; P5 verified by hand in §3.5.

---

## 2. Said for a stranger

*For a combinatorialist who has never seen this repository.* Fix an odd prime power `q ≡ 3 (mod 4)` and let `G_q` be the
Cayley graph on the additive group of 𝔽_q² whose connection set is the "unit circle" `{(a,b) : a² + b² = 1}`. Because
−1 is a non-square in 𝔽_q the circle is an ellipse with exactly `q + 1` affine points, so `G_q` is a `(q+1)`-regular
graph on `q²` vertices — the *finite Euclidean graph* of Medrano–Myers–Stark–Terras, equivalently the generalized Paley
graph `GP(q², q−1)`. Its eigenvalues are Kloosterman sums, `|λ| ≤ 2√q` by Weil, so it is a Ramanujan-grade expander.
Two classical facts do all the work. First, `G_q` is vertex-transitive, so its **fractional** chromatic number is exactly
`q²/α(G_q)`, and `χ ≥ ⌈q²/α⌉`; in particular a proper `k`-colouring exists only if `α ≥ ⌈q²/k⌉`. Second, the ratio
(Hoffman) bound `α ≤ n·|λ_min|/(d + |λ_min|)` caps α at about `2q^{3/2}`, so `χ ≳ √q/2 → ∞` (Vinh). The question is whether the
integer **6** is ever the value of `χ(G_q)`. Since `χ` diverges and `χ(G_11) = 5`, six can only occur at a handful of
small `q` — nowhere above `q = 103` by the ratio bound. The stake: a real number field `F` with a prime of odd residue
degree over such a `q` has `χ(F²) ≤ χ(G_q)` (Moorhouse; Madore Cor. 3.4), so a six-chromatic `G_q` would exhibit the
first number field whose unit-distance plane is provably at most six-chromatic — Hadwiger–Nelson's missing middle value.

---

## 3. The surprises, each with its address

### 3.1 The semidefinite instrument cannot decide six at four of the seven primes, and phase A points it at three of those four

Recomputed here from `tools/fplane.py spectrum` (exact Kloosterman sums) and the three measured semidefinite values in
`data/fs50/` (`cert-p11-N29.json` 29.176808, `cert-p23-real-N108.json` 108.546075, `data/fs50/p83-refusal/` 1076.366454):

| q | Hoffman α ≤ | ⌈q²/6⌉ | **must reach (6/Hoffman)** | ⌈q²/5⌉ | must reach (5/Hoffman) | measured SDP/Hoffman |
|---|---|---|---|---|---|---|
| 23 | 131.76 | 89 | **0.675** | 106 | 0.804 | **0.824** |
| 27 | 162.00 | 122 | **0.753** | 146 | 0.901 | — |
| 31 | 240.25 | 161 | **0.670** | 193 | 0.803 | — |
| 43 | 395.23 | 309 | **0.782** | 370 | 0.936 | — |
| 47 | 466.39 | 369 | **0.791** | 442 | 0.948 | — |
| 59 | 693.14 | 581 | **0.838** | 697 | (spectrally refused) | — |
| 67 | 813.78 | 749 | **0.920** | — | — | — |
| 79 | 1099.19 | 1041 | **0.947** | — | — | — |
| 83 | 1199.46 | 1149 | 0.958 | — | — | **0.897** ✔ refused |
| 11 | 34.55 | 21 | 0.608 | 25 | 0.724 | 0.844 |

The instrument's measured reach is 0.824–0.897 of Hoffman at the three primes where it has run, and the trend is the
unhelpful one — it is *relatively weaker* at 83 (0.897) than at 23 (0.824), so extrapolating it upward is the
conservative direction. Even at 0.91 it still clears 67 (0.920) and 79 (0.947), so that prediction survives the trend;
nothing survives at 23 or 31, where it would need to improve by a quarter. Reading the table: it
should **refuse six at 67 and 79**, is a coin-flip at 59, and is 6–25 % short at 23, 27, 31, 43, 47. It should also
**refuse five at 43 and 47** (0.936, 0.948 — comfortably inside reach; this is the stub's P3, and it is very likely to
land, at 43 as well as 47) and **fail to refuse five at 23 and 31** (0.804, 0.803 — the known 3.4 % shortfall at 23, and
31 is its twin). So a full GPU sweep's honest product is: *two primes removed from the window (67, 79), two floors raised
from 5 to 6 (43, 47), nothing at 23, 27, 31.* That is worth having. It is not the milestone.

### 3.2 The window has eight members. `q = 27` is missing from the stub and from `CLAUDE.md` G56

Row 52's hypothesis is a residue field 𝔽_q with `q ≡ 3 (mod 4)` and **odd residue degree**, not a prime field. The odd
prime powers `q ≡ 3 (mod 4)` below the Weil cutoff (six needs `5|λ_min| ≥ q+1`, so `q ≤ 97`) are
`23, 27, 31, 43, 47, 59, 67, 71, 79, 83`. **27 = 3³ is one of them and appears in neither the stub's §2 table nor G56's
sentence** ("a plane with χ exactly 6 can live only at p ∈ {23, 31, 43, 47, 59, 67, 79}"). The project has already built
it: `data/fplane/chi-q27.json` records `k = 4` UNSAT (6.9 s) and `k = 5` unknown (2,328 s), so `χ(UD(𝔽₂₇,2)) ≥ 5` and
nothing above is known; and `tools/fplane.py:993` says in so many words that the next two odd-degree planes (343, 1331)
are spectrally ≥ 6, i.e. the enumeration was done and 27 was not carried into the window. I computed its spectrum here
(729 vertices, degree 28): **λ_min = −8 exactly**, integer spectrum `{−8, −5, −2, 1, 4, 7, 10, 28}`, Hoffman α ≤ 162,
χ_f ≥ 4.5, spectral floor 5; six needs α ≥ 122, five needs α ≥ 146.

Why it matters beyond bookkeeping: **27 is the only window member whose number field is already named.** `x³ − x − 1` is
irreducible mod 3 (it takes the value 2 at all three points of 𝔽₃, so it has no root and, being cubic, no factor),
so 3 is inert in ℚ(α) and the residue field is 𝔽₂₇ — the cubic field
`ℚ(√3, α)`, `α³ = α + 1`, already on the books as FS-48's last row, has a prime above 3 with `e = 2, f = 3` and therefore
`L ≤ χ(UD(𝔽₂₇,2))`. It contains √3 (so it carries a Moser spindle) and no √11.

*And the exclusion argument needs one extra line at 27.* §0.3 excludes the window for every field containing ℚ(√3,√11)
by "3 and 11 must be squares mod p". At `q = 27` that does not typecheck: 3 is ramified. The correct sentence is the
same conclusion by a different route: `11 ≡ −1 (mod 3)` and −1 is a non-square in 𝔽_q for every `q ≡ 3 (mod 4)`, so
√11 ∉ 𝔽₂₇ and 27 is unusable for any field containing √11. The exclusion survives; the argument as written does not
cover its eighth case.

### 3.3 Nobody has asked whether a window plane is six-colourable

`data/fplane/chi-p{23,31,43,47}-k5.json` each hold exactly one row: `k = 5`, `unknown`, 14,400 s, killed by an external
timeout. `chi-q27.json` stops at `k = 5`. The only `k = 6` asks anywhere are at 83 (`data/fplane/plane-colour-p83-k6*`,
`equivariant-p83-k6*`, `data/fs50/wo18/p83-k6.json`, `lp-p83-k6.json`) — the prime where six is now refused. The stub's
§2 therefore reports `χ(23) ∈ {5,6,7,8}` with the 8 coming from a line-periodic colouring and **no direct attempt at 6 or
7 on record.**

This is the asymmetry that decides the milestone's cost. Refuting `k` colours is expensive (the 4-hour nulls prove it);
*exhibiting* them is cheap when they exist. A six-colouring of `UD(𝔽₂₃,2)` is 529 vertices × 6 colours = 3,174 boolean
variables — trivial for a local-search colourer if the solution space is not empty. **One run of the existing Rust
`plane-colour` tool at `--p 23 --k 6` decides, in the affirmative, a question the milestone is otherwise planning a
GPU-day around.** The same run at `q = 27` (729 vertices) is the second cheapest.

### 3.4 The one calibrated instrument says α(23) is 87 or 88 — which would make χ(23) ≥ 7 and empty the window's best cell

Four facts, each with an address, that the stub's "two above the set found" does not carry:

1. `data/fs50/wo18/p23-k5.json`: 300 s, 16 threads, 22,390 restarts, target 106, `halt: deadline`. The trace's first
   entry (2.0 s) reads `best_size 87` with fifteen of sixteen threads already at 87; the last entry (300 s) reads 87 on
   all sixteen. That is a converged plateau, not a stopping point.
2. `data/fs50/wo18/p11-*.json`: the same searcher plateaus at 28 at p = 11 (60 s, 12,493 restarts, every thread), and
   `data/fplane/alpha-p11.json` records cadical refusing 29. **The tool's plateau equals α exactly at the one prime where
   α is known.**
3. `plans/POROS-2026-09-14-fs50-planning.md` §3.4: "the widening per-thread spread (10 → 75 points over a run) says the
   free search at 83 has not converged; at 23 it has" — the record's own reading, written before this question was asked.
4. Same pass, §3.1: the 87-set at 23 carries **51 % of its centred Fourier mass on the λ_min eigenspace** (uniform would
   be ~4 %), against 70 % for the exact optimum at 11 and 1.7 % for the best set at 83. At 23 the searcher is producing
   near-Hoffman-extremal objects, which is what the neighbourhood of α looks like.

Under the identity χ = ⌈529/α⌉ (see §3.5), `α(23) ∈ {87, 88} ⟹ χ(23) ≥ 7`; `α ∈ [89, 105] ⟹ χ = 6`;
`α ∈ [106, 108] ⟹ χ = 5`. **The entire question at 23 is two vertices wide, and the only instrument that has looked says
it falls on the wrong side.** Note the direction of the asymmetry: a local search can only ever *raise* α, so this
evidence is one-sided and defeasible in minutes — which is exactly why the experiment is worth running first.

### 3.5 The stub's "+1 over the spectral floor" reading has a decided, omitted counterexample — and its repair is a better law

§2: "The heuristic that χ sits one above the spectral floor — true at the three decided primes, 7 (floor 3, χ 4),
11 (floor 4, χ 5) and 19 (floor 4, χ 5)". There is a **fourth** decided plane, and it falsifies the heuristic:
`data/fplane/chi-p3.json` gives χ(𝔽₃²) = 3, and `data/fplane/theta-below-83.json` gives `chi_floor = 3` at p = 3. Floor
+ 1 = 4 ≠ 3. The omission flatters the reading, which is the pattern `CLAUDE.md` G21 names.

The repair is not a patch but a mechanism already in the record. G54: p = 3 is the one **Hoffman-tight** plane in the
table (`hoffman_alpha = 3.0000` exactly, and α(3) = 3); a tight plane is Hoffman-colourable, so χ = χ_f = the floor, with
no +1. Every other decided plane is slack, and there χ = floor + 1. So:

> **χ = ⌈q²/α(q)⌉ at every decided plane**, i.e. these graphs have integrality gap below 1 — verified at q = 3 (α = 3)
> and q = 11 (α = 28), consistent at q = 7 (α ∈ [14,17], the law needs ≤ 16) and q = 19 (α ∈ [76,99], needs ≤ 90).

This is a stronger, falsifiable, mechanism-carrying replacement for P2, and it is *not* automatic: Kneser graphs are
vertex-transitive with arbitrarily large gaps. It also changes what the milestone measures — under it, α decides χ.

*And a free sharpening of G54's classifier.* Adjacency eigenvalues are algebraic integers, so `λ_min = −d/(k−1)` with
`d = q+1` rational forces `(k−1) | (q+1)`. **A finite Euclidean plane can be Hoffman-tight at k colours only if
(k−1) divides q+1.** For six that is `5 | q+1`, which fails at 23, 27, 31, 43, 47, 67 — so six-slackness at those six is
a divisibility theorem, not a numerical observation, and the stub's P4 ("high confidence, from §2") becomes a proof. The
same argument is what makes the floor at 31 safe: `1 + 32/10.6665 = 4.000047` is a hair above 4 in floating point, and
the reason it cannot be exactly 4 is that `32/3` is not an algebraic integer.

### 3.6 Kooshi's asymptote, made exact — and its sign is inverted

The intuition is "fields that come arbitrarily close to six-colourable but always barely miss". The record says something
sharper and opposite in direction. `χ_f(q) = q²/α(q)` exactly, and `α = O(q^{3/2})` by Weil, so **χ_f diverges like √q**.
Six is not a ceiling approached from below; it is a value a divergent increasing sequence steps through, once, near
q = 23–31. From my own FS-50 ledger the empirical law is `α/Hoffman ≈ ln d/√d` (`d = q+1`; predicted 0.72/0.67/0.62/0.48
at 11/19/23/83, measured 0.810/≥0.764/≥0.660/≥0.498). Extrapolated, with the six-threshold beside it:

| q | 23 | 27 | 31 | 43 | 47 | 59 | 67 | 79 | 83 |
|---|---|---|---|---|---|---|---|---|---|
| predicted α | 86 | 102 | 147 | 226 | 261 | 366 | 416 | 539 | 580 |
| six needs α ≥ | 89 | 122 | 161 | 309 | 369 | 581 | 749 | 1041 | 1149 |
| shortfall | **3 %** | 16 % | 9 % | 27 % | 29 % | 37 % | 44 % | 48 % | 50 % (measured: refused) |

So the honest statement of the asymptote: **six is missed at every window member, and at 23 it is missed by about three
per cent — two vertices out of 529.** The "barely misses" feeling is right; what it is about is the crossing point, and
23 is the last plane where six is even close. The sequence's next candidate values are 5 (attained, 11 and 19) and then
7 or more. *This is scorable and it is the milestone's best product either way:* every α measured at a window prime
scores it, and one that lands at or above its six-threshold kills it.

### 3.7 A committed record whose producer is gone

`tools/fplane.py` calls `field_q27()` at line 994; the function is not defined in the file. Commit `a3adc46` (FS-40 phase
A, the equivariant quotient) removed it. `python3 tools/fplane.py chi --q 27` raises `NameError`, the `self-test`
subcommand does not exercise it, and the body survives only in the worktree copy
`.claude/worktrees/fs38-stubs-paper/tools/fplane.py:887`. So `data/fplane/chi-q27.json` — the sole evidence that
χ(𝔽₂₇²) ≥ 5, and about to become a window row — is currently unreproducible from `main`. A five-line restore plus one
self-test row fixes it; it belongs in phase A's first hour, not in a later tidy.

---

## Cards, ranked

*Five, which my own gate calls a menu. The brief asked for one card per question; I have folded the three that a reading
already settles into §Q below, and kept as cards only the forks where an answer changes the plan.*

question: is-any-window-plane-six-colourable
  evidence: data/fplane/chi-p{23,31,43,47}-k5.json each hold one row — k = 5, unknown, 14,400 s; chi-q27.json stops at
    k = 5 (unknown, 2,328 s). Every k = 6 ask in the repository is at 83 (wo18/p83-k6.json, plane-colour-p83-k6*.json),
    where six is now refused by certificate. The stub's upper bound of 8 at 23 is a line-periodic colouring.
  expected: a direct six-colouring attempt somewhere in the window, since chi = 6 is the milestone's target
  ask: has anyone asked a window plane for six colours, and what does the Rust colourer return at (23, 6) and (27, 6)?
  if a six-colouring is found: the milestone is made on the spot — chi(plane) <= 6, the field half becomes live at that
    prime, alpha >= ceil(q^2/6) follows for free, and the whole GPU sweep is re-aimed at refusing five there
  if not found in minutes: the finding side is a null with a known cause (section 3.4's plateau), phase A proceeds to
    the certificate side, and the GPU is pointed at 67 and 79 where it can win rather than at 23 and 47 where it cannot
  answered by: run — the Rust plane-colour tool, --p 23 --k 6 and the F_27 graph at k = 6, minutes on one core
  cost: under an hour of one CPU, no GPU, no solver wall
  hunch: not found at 23; possibly found at 27, whose six-threshold sits at a friendlier 0.753 of the ratio bound
  falsifier: a verified proper six-colouring of UD(F_23,2)
  rank: 1

question: what-is-alpha-at-23
  evidence: data/fs50/wo18/p23-k5.json — 300 s, 16 threads, 22,390 restarts, every thread at 87 from second 2 to the
    deadline; the same tool plateaus at 28 at p = 11 where cadical proves alpha = 28 (data/fplane/alpha-p11.json); the
    87-set carries 51% of its Fourier mass on the lambda_min eigenspace (POROS-2026-09-14 section 3.1). Six needs 89.
  expected: 87 to be a soft stopping point; it is a converged plateau on the one plane where this search converges
  ask: is alpha(UD(F_23,2)) 87, or does symmetry-seeded search reach 89 and keep six alive at the window's best prime?
  if 89 or more is found: six survives at 23, the six-colouring ask of card 1 becomes the priority, and my bet is lost
  if the plateau holds under seeding: chi(23) >= 7 is the reading (not a proof — a local search cannot bound alpha from
    above), the window's best cell is probably empty, and the milestone should re-price its odds of any six at all
  answered by: run — plane-independent --p 23 with rotation-order seeds dividing 24 and a chain, as at 83 where
    chaining moved 574 to 597 (a 4% gain; 4% of 87 is 90.5, which crosses 89)
  cost: an hour of one core
  hunch: the plateau holds; alpha(23) is 87 or 88
  falsifier: a verified 89-point independent set in UD(F_23,2)
  rank: 2

question: does-the-window-have-eight-members
  evidence: row 52's hypothesis is a residue field F_q with q = 3 (mod 4) of odd residue degree, not a prime field;
    q = 27 satisfies it, lies inside the Weil cutoff q <= 97, and is recorded at chi >= 5 in data/fplane/chi-q27.json;
    it appears in neither the stub's section 2 table nor CLAUDE.md G56. Its spectrum, computed here: lambda_min = -8
    exactly, Hoffman 162, six needs 122 (0.753 of Hoffman, the friendliest ratio in the window).
  expected: the window to be stated over the hypothesis row 52 actually has
  ask: should q = 27 be the window's eighth member, and is its field Q(sqrt 3, alpha), alpha^3 = alpha + 1, the
    milestone's cheapest field half?
  if yes: 27 joins phase A as the second-cheapest prime (729 vertices), the field half is already named rather than
    designed, and the section 0.3 exclusion gains the line it needs (11 = -1 mod 3 is a non-square in every F_q with
    q = 3 mod 4, so sqrt 11 is not in F_27)
  if no: the reason is stated in the stub, since the omission currently reads as an oversight in the instrument's
    parameter rather than a decision
  answered by: the record — CLAUDE.md rows 52 and 53 and the field's factorisation, plus a decision by the planner
  cost: an afternoon for the arithmetic; the graph already exists
  hunch: yes, and 27 is the only window member whose number field the project has already written down
  falsifier: a reason F_27 cannot be a residue field of a real number field at an odd-degree prime
  rank: 3

question: where-should-the-gpu-day-go
  evidence: the fraction of the ratio bound the certificate must reach to refuse six is 0.675 at 23, 0.670 at 31,
    0.753 at 27, 0.782 at 43, 0.791 at 47, 0.838 at 59, 0.920 at 67, 0.947 at 79 (recomputed here); the instrument's
    measured reach is 0.824 at 23, 0.844 at 11, 0.897 at 83. The stub's phase A runs "23 and 47 first".
  expected: the sweep ordered by the chance of a verdict
  ask: should phase A run 79 and 67 first, where the certificate can refuse six, rather than 23 and 47, where the
    arithmetic says it cannot?
  if reordered: the GPU-day returns two primes removed from the window and two floors raised (five refused at 43 and
    47), a table with verdicts instead of four "short by 20%" rows
  if kept: 23 and 47 produce a five-refusal at 47 and nothing at 23, and the milestone learns in a day what one line
    of arithmetic says now
  answered by: a derivation — the table above, which the planner can reproduce in seconds
  cost: nothing; it is an ordering
  hunch: 79 and 67 refuse six; 59 is a coin flip; 43 and 47 refuse five
  falsifier: a certificate at 23 below 89, which would mean the instrument is far stronger than its three measured runs
  rank: 4

question: is-the-product-the-digit-or-the-growth-law
  evidence: chi_f = q^2/alpha exactly for these vertex-transitive graphs; alpha = O(q^1.5) by Weil, so chi_f diverges
    like sqrt q and crosses 6 between q = 23 and q = 31; the empirical law alpha/Hoffman ~ ln d / sqrt d (measured
    0.810 / >=0.764 / >=0.660 / >=0.498 at 11 / 19 / 23 / 83) predicts a shortfall against the six-threshold of 3% at
    23 and 16-50% everywhere above.
  expected: the milestone's product to be a table of chi
  ask: is FS-53's durable product the sequence of digits, or the growth law of alpha for finite Euclidean planes with
    "is six ever attained" as its corollary?
  if the law: every alpha measured scores it, the negative outcome becomes a result rather than a null, and the
    statement generalises past the window to every q
  if the digits: the negative outcome is seven bracketed cells and a conditional sentence about chi(R^2)
  answered by: Kooshi
  cost: a decision; it changes what phase A records, not what it runs
  hunch: the law, on the programme's own rule that derivations outrank objects
  falsifier: an alpha at a window prime that lands above its six-threshold, which would break the law and make six real
  rank: 5

---

## Hunch ledger

hunch: alpha-23-is-87-or-88
  claim: alpha(UD(F_23,2)) is 87 or 88, so chi(UD(F_23,2)) >= 7 and the window's best prime is empty
  basis: measured
  falsifier: a verified independent set of 89 points in UD(F_23,2), or a proper six-colouring of it
  registered: 2026-09-15
  status: open

hunch: chi-equals-ceil-n-over-alpha
  claim: chi(UD(F_q,2)) = ceil(q^2/alpha(q)) for every q = 3 (mod 4) — these planes have integrality gap below one
  basis: measured
  falsifier: a plane with a verified colouring count above ceil(q^2/alpha) with both alpha and chi pinned
  registered: 2026-09-15
  status: open

hunch: tightness-needs-divisibility
  claim: a finite Euclidean plane is Hoffman-tight at k colours only if (k-1) divides q+1, since adjacency eigenvalues
    are algebraic integers and -d/(k-1) is rational; so six-slackness at 23, 27, 31, 43, 47, 67 is a theorem
  basis: derived
  falsifier: a plane with lambda_min = -(q+1)/(k-1) where (k-1) does not divide q+1
  registered: 2026-09-15
  status: open

hunch: the-sdp-refuses-six-at-67-and-79-only
  claim: the triple-level certificate reaches 0.82-0.90 of the ratio bound, so it refuses six at 67 and 79, is a coin
    flip at 59, and cannot at 23, 27, 31, 43, 47; it refuses five at 43 and 47 and not at 23 or 31
  basis: measured
  falsifier: a certified value below 0.80 of the ratio bound at any window prime
  registered: 2026-09-15
  status: open

---

## Answers to the brief's remaining questions

**Q3 — a sharper instrument for "five is refused" at 23–47.** Yes, and the record names it: at 43 and 47 the five-threshold
sits at 0.936 and 0.948 of the ratio bound, inside the instrument's measured reach, so the *existing* certificate should
refuse five there without a new level. At 23 and 31 it sits at 0.804 and 0.803, outside it, and the FS-50 record closes
the alternatives: cadical refutes "α ≥ N" only above a residual density of ≈ 0.41 (`POROS-2026-09-14` §3.2, measured at 19 and 23
alike), and at 23 with N = 106 the easiest cube that has ever been undecided sits at 0.394 while the first one that
refuted sits at 0.433 — the nulls are on the wrong side of a threshold, not short of time. The honest answer for 23 and
31 is that five stays open and the milestone should say so rather than budget for it.

**Q4 — a reading that tells us whether six-colourings exist before searching.** Three, in increasing cost.
(i) *Fractional:* α ≥ ⌈q²/6⌉ is necessary; at 23 the best known α is 2 short and at 27 it is unmeasured — so the α run
IS the pre-reading (card 2). (ii) *Fourier:* a six-colouring's classes each have ≈ q²/6 points and must therefore be
Fourier-concentrated in the way §3.1 of the FS-50 pass measured; spectral seeding (thresholding a random combination of
the λ_min characters) is the cheap dial and it already exists as a prescription in that pass. (iii) *Symmetric census:*
`fplane.py equivariant --p 23 --k 6` enumerates rotation-equivariant six-colourings the way the k = 5 run did — cheap,
one-sided, and its null at k = 5 is already on record (`data/fplane/equivariant-p23-k5.json`).

**Q5 — the field half.** It should not have a phase before a six-chromatic plane exists, with one exception. §PA is right
that existence is Dirichlet + CRT and the content is the exclusion list; a stranger checks it by verifying, for each
radicand `d` and each prime `r` in {3, 7, 11, 19, 23, 31, 43, 47} and the target q, a Legendre symbol — seconds, and the
whole claim is a table of `±1`. The exception is **P5, which is a control and not a phase**: I verified by hand here that
for every prime `p ≡ 3 (mod 4)` in `(11, 83]` — that is 19, 23, 31, 43, 47, 59, 67, 71, 79, 83 — only 83 has both
`(3/p)` and `(11/p)` non-negative; 19 fails on 3 and is not in the stub's table at all. The designer should reproduce
that list as its first self-test. And the one field worth naming **now** is `ℚ(√3, α)`, `α³ = α + 1` (§3.2).

**Q6 — Kooshi's asymptote.** §3.6 gives it a registered form with a falsifier. The one-sentence version to hand back:
*the planes are not approaching six-colourability, they are leaving it behind* — χ_f diverges like √q, six is a value
crossed once near q = 23–31, and what the intuition is really reporting is that **23 misses by about three per cent and
nothing above it is close.** The version of "asymptote" that survives is about the *fields*, not the planes: §0.3's
reciprocity says every field the project has built sees only 11 (→ 5) and then 83 (→ ≥ 7), so the local bound jumps 5 → 7
with no 6 available — an arithmetic gap, not a limit.

**Q7 — the side row at 17.** Worth the hour, with two changes. Ask `k = 6` **before** `k = 5`: a satisfiable answer is
cheap, an unsatisfiable one is dear, and the 50-minute null at k = 5 is evidence that the expensive question was asked
first. And state the two halves in one sentence when reporting: a six-colouring at 17 would be **the first six-chromatic
single-distance graph over any field** (which is precisely the object Kooshi says does not exist anywhere) *and* it
seals no number field, because 17 ≡ 1 (mod 4) puts it outside Madore Cor. 3.4's hypothesis. Both facts, together, or the
row will be over- or under-sold.

**Q8 — the registered expectations.** P1's falsifier ("phase A reads five or ≥ 7 at all seven") is **unreachable**: the
modal outcome of phase A is four primes still bracketed, and the stub does not name that third outcome. Rewrite P1 as a
per-prime scorecard with three cells (six / not six / undecided) and a stated stopping rule, so "undecided" is a recorded
verdict rather than the escape hatch. P2 is falsified as stated (§3.5) and should be replaced by `χ = ⌈q²/α⌉`. P3 is
scorable and should be widened to 43 as well as 47. P4 becomes a theorem (§3.5's divisibility). P5 is verified (§Q5) and
should be a control. P6 is fine. **The escape hatch a motivated reader reaches for** is "the primes we could not decide
are the ones where six lives" — and the only defence is to note in advance that the undecidable primes are undecidable
for a *reason that is independent of their χ* (the certificate's reach, §3.1), so the undecided set is not enriched for
six.

---

## Traps for the planner

1. **A plateau is one-sided.** Every α number in this report is a lower bound from a local search; none bounds α from
   above. §3.4's reading is a reading, and the milestone must not report "χ(23) ≥ 7" on its strength.
2. **The finding side and the refusing side have opposite failure directions.** A missing edge makes a colouring easier
   and a refusal safer; an invented edge does the reverse. The `edges_sha256` field in the `wo18` records is the right
   habit — carry it into every new graph, especially 𝔽₂₇, whose producer is currently broken (§3.7).
3. **"Six needs α ≥ ⌈q²/6⌉" is necessary, never sufficient.** An α that clears the threshold does not give a colouring;
   the classes must also partition. Do not let a cleared threshold be reported as "six is possible" without the word
   "fractionally".
4. **The GPU is not the bottleneck and two of its jobs are live.** Phase A's first day should be CPU: the k = 6 asks,
   the α runs, the 𝔽₂₇ restore. The certificate work is the second day and belongs at 79 and 67.
5. **Do not let the field half start early.** It is an afternoon once a prime exists and an infinite sink before.
6. **The `+1 over the floor` reading is dead; do not quietly carry it in prose** after replacing it in §5.

---

## What I did not do, and why

- No solver, no SAT, no GPU, nothing spawned: the box has two live FS-50 jobs and the brief forbids it. Every number here
  is numpy or exact arithmetic on committed records.
- The 𝔽₂₇ spectrum was computed by rebuilding the field from the deleted `field_q27()` body in the worktree copy, in my
  scratch directory; I did not edit `tools/fplane.py`.
- *Recalled, not read:* Iosevich–Rudnev 2007 (distances in 𝔽_q^d), Scheinerman–Ullman Prop. 3.1.1 (χ_f = n/α for
  vertex-transitive graphs), Croft 1967. The first two are the load-bearing citations of §2 and §3.6 and should be
  opened at the subplan's prior-art step.
- I did not price an exact maximum-independent-set solver at 23 (orbital branching over the order-25,392 automorphism
  group). It is the only instrument that could turn §3.4's reading into a proof, and it is a real candidate for phase B.

*Scratch: `/home/kooshi/.claude/jobs/b1507518/tmp/poros53/` (the pre-reading expectation and the numpy outputs).*
