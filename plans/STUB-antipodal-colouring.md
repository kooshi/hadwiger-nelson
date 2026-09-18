# FS-55 — the antipodal conjecture: is an optimal colouring always symmetric under z ↦ −z?

*Minted 2026-09-16 at FS-53's close, under WORKFLOW step 9's rule that a milestone sweeps its own plan for
unpursued conjectures. The conjecture is `CLAUDE.md` § Grokkings **G58**; its evidence and its failed killing
test are in `data/fs53/g58/` with their own README.*

## The statement

**Every finite Euclidean plane `UD(𝔽_q,2)` has an optimal colouring `c` — one using exactly `χ` colours —
with `c(−z) = τ(c(z))` for some involution `τ` of the colour set.**

The map `z ↦ −z` is an automorphism of every one of these graphs (it is the rotation by `−1`), so this asks
whether the cheapest available symmetry can always be imposed on a best colouring for free.

## Why it matters, concretely

**It halves every colouring instance**: `(q²+1)/2` antipodal orbits against `q²` vertices — 925 against 1,849
at `q = 43`, 145 against 289 at `q = 17`. More than that, it makes a restricted search **complete** rather
than heuristic: if `χ(43) = 6` then a *symmetric* six-colouring exists, so searching only symmetric
colourings cannot miss the answer. That is the difference between a shortcut and a method.

And it **relocates FS-53's open question.** At the two planes where a colouring is known to exist (`q = 11`
and `q = 19`) the satisfiable symmetry rows are rotation order 2 with `τ` of cycle type `(2,2,1)` or
`(2,1,1,1)` — and **those are exactly the rows left undecided** at 17 (five colours) and at 23, 43 and 47
(six colours). So the equivariant sweeps refused only the rows that are also refused where colourings
demonstrably exist, and the surviving candidate at `q = 17` is a single instance: order 2, `τ = (2,2,1)`,
still undecided after 9,398 s at 40,000,000 conflicts.

## The evidence: 4 of 4 planes whose chromatic number is known

Each colouring re-verified from the definition, from the committed file: 0 monochromatic edge-ends, `τ`
confirmed a genuine involution.

| q | χ | the involution that works |
|---|---|---|
| 3 | 3 | `(2,1)` |
| 7 | 4 | `(2,1,1)` |
| 11 | 5 | `(2,2,1)` **and** `(2,1,1,1)` |
| 19 | 5 | `(2,2,1)` |

**No simpler form survives**: at `q = 19` the identity and every single transposition are refuted, so the
colour involution is load-bearing rather than decorative.

## Derived, not conjectured

A rotation fixes the origin, so `c(0) = τ(c(0))`: **τ must fix a colour.** This refutes **73 of the 226 rows
refused across seven equivariant sweeps (32 %)** with no solver at all, including 17 of 43 at `q = 23` and 23
of 59 at `q = 47`. The identity row dies as cheaply — some `z` is adjacent to `−z`, so `c(z) = c(−z)` fails
on one edge. **Both should be filters in `tools/fplane.py equivariant`, not solver time**, and until they are
every "k of n classes refused" figure in this project overstates its evidence by about a third.

## The deliverables

1. **Test it with a FINDER, not a decider.** The killing test was attempted on 2026-09-16 at 23 (k = 7, 8)
   and 43 (k = 8) as a decision problem and **returned nothing**: every refusal was free, every informative
   row undecided at 3,000,000 conflicts. The diagnosis is an instrument error, not a budget error — **G58
   asserts existence**, so the right tool is a local search on the antipodal quotient (about `(q²+1)/2`
   orbits), and asking a decider to refute is the expensive direction.
2. **Put the two free filters into the sweep tool**, and restate every affected figure in the record.
3. **Use it at 43** — the member with the most room for six — once the finder confirms it there at some `k`.
4. **Settle `q = 17`**: under G58, χ(17) = 5 iff the single surviving instance is satisfiable. That one
   instance is the whole five-colour question at 17, at half the size of the full problem.
   **It acquired a second consumer on 2026-09-17, and it is the cheapest one on the board.** `q = 17` seals no
   field (17 ≡ 1 mod 4), so its digit was only ever bookkeeping against `[Moorhouse2010]` Table 6.1 — but G64's
   **norm reading** says the value 6 never occurs because 6 is the smallest integer that is neither `a² + b²` nor
   `a² + ab + b²`, and `χ(𝔽₁₇²) ∈ {5, 6}` is the reading's cheapest killing test anywhere: **a six at 17 refutes
   it in an afternoon, for zero mathematical cost.** `tools/fq_chi.py` reproduces `≥ 5` and leaves it undecided at
   five in 90 s (`data/fs62/dim2.jsonl`); this stub's half-size instance is the instrument that should decide it.
5. **Prior art** was searched on 2026-09-16 under two disciplines and found nothing asserting or refuting the
   statement for any family. The discipline's frame is the **Burnside chromatic polynomial of group-invariant
   graphs**; the abelian-Cayley colouring literature works on χ itself, not on invariance. Two near
   neighbours that are NOT it: the *distinguishing* chromatic number is the opposite question, and the known
   failure of invariance under the **full** automorphism group says nothing about one involution taken up to
   a colour permutation. **Bibliography keys are owed.**

## Scope, honestly

Four planes, all with `χ ≤ 5`, all `q ≡ 3 (mod 4)`. *Killing test: a plane with an optimal colouring but none
antipodally invariant under any involution.*
