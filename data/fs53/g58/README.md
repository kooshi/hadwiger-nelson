# G58 — the antipodal conjecture: the evidence, and the test that did not fire

**The conjecture (`CLAUDE.md` § Grokkings, G58).** Every finite Euclidean plane `UD(𝔽_q,2)` has an
**optimal** colouring `c` with `c(−z) = τ(c(z))` for some **involution** `τ` of the colours.

**Why it would matter.** It halves every colouring instance — `(q²+1)/2` antipodal orbits against `q²`
vertices: 925 against 1,849 at `q = 43`, 145 against 289 at `q = 17`. And it relocates this milestone's
open question, because the rows that carry the colourings where colourings are KNOWN to exist are exactly
the rows that come back **undecided** at 17, 23, 43 and 47.

## The evidence: 4 of 4 planes whose chromatic number is known

Every colouring below was re-verified **from the definition, from the committed file** (not from the
solver's word and not from the scratch copy): the field rebuilt, every edge of the plane swept, and the
colour map checked to be a genuine involution.

| file | q | χ (known) | the involution | check |
|---|---|---|---|---|
| `equivariant-p3-k3.json` | 3 | 3 | `(2,1)` | 3 colours, **0** monochromatic edge-ends, τ² = id |
| `equivariant-p7-k4.json` | 7 | 4 | `(2,1,1)` | 4 colours, **0**, τ² = id |
| `equivariant-p11-k5.json` | 11 | 5 | `(2,2,1)` **and** `(2,1,1,1)` | 5 colours, **0**, τ² = id |
| `equivariant-p19-k5.json` | 19 | 5 | `(2,2,1)` | 5 colours, **0**, τ² = id |

**No simpler form survives.** At `q = 19` the identity permutation is refuted and so is every single
transposition; only `(2,2,1)` works. So "invariant" without a colour involution is **false**, and the
involution is load-bearing rather than decorative.

**Reproduce:** the verification is the loop in this milestone's record; each file's `rows[i].colouring` is
a full `q²`-entry list under the index `v = x·q + y`, and `−v` is `(−x mod q)·q + (−y mod q)`.

## Derived, not conjectured: τ must fix a colour

A rotation fixes the origin, so `c(0) = τ(c(0))`. **Any row whose τ fixes no colour is refuted with no
solver at all** — and that accounts for **73 of the 226 rows refused across seven equivariant sweeps
(32 %)**, including 17 of 43 at `q = 23` and 23 of 59 at `q = 47`. Those refusals were never solver
evidence, and the tool should filter them rather than pay for them.

## The killing test, attempted 2026-09-16 — and it returned NOTHING

`killtest-p23-k7.json`, `killtest-p23-k8.json`, `killtest-p43-k8.json`: ask, at a plane where a colouring
at `k` is already in hand, whether an antipodally symmetric one exists at the same `k`.

| row type | verdict | time |
|---|---|---|
| τ fixes no colour, e.g. `(2,2,2,2)` | UNSAT | **0 s** — free, by the argument above |
| τ = identity | UNSAT | **0 s** — free: some `z` is adjacent to `−z`, so `c(z) = c(−z)` dies on one edge |
| every τ fixing several colours — **the only rows that could carry a colouring** | **undecided** | 170–483 s at 3,000,000 conflicts |

**Every refusal was free and every informative row was undecided: zero solver-earned information.** This is
this project's own rule broken by its author — *state the uninformative outcome and confirm it is reachable*
— and it is recorded as a failure rather than dressed up as a partial result.

**The fix is the instrument, not the budget.** G58 asserts **existence**, so the right tool is a **finder on
the antipodal quotient** (about `(q²+1)/2` orbits), not a decider on the full plane. A decider was being
asked to refute, which is the expensive direction and the wrong one for an existence claim.

## Scope, honestly

Four planes, all with `χ ≤ 5`, all `q ≡ 3 (mod 4)`. The prior-art gate was run on 2026-09-16 under two
disciplines (graph theory: *colouring invariant under a graph automorphism*; algebraic combinatorics:
*Cayley graph colouring invariant under inversion*, *group-invariant colouring*, the **Burnside chromatic
polynomial of group-invariant graphs**) and found **nothing asserting or refuting the statement for any
family**. Two near neighbours that are NOT it: the *distinguishing* chromatic number is the opposite
question, and the known failure of invariance under the **full** automorphism group says nothing about a
single involution taken up to a colour permutation.
