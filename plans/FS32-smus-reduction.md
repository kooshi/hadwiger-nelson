# FS-32 — The reduction stage as smallest group-MUS

*Subplan opened 2026-09-10 on Kooshi's "you are go for FS-32". The stub is
`plans/STUB-smus-reduction.md` and carries the finding and the two corrections it has already taken.
Read `plans/M62-evolutionary-type-m.md` §R19–§R21 first — they hold the corrected base this runs on.*

## §PA — Prior-art gate (WORKFLOW step 3a), run before any derivation

Searched in the discipline's own vocabulary, not ours, across two literatures.

**The problem has a name and the name is standard.** A minimal unsatisfiable subset is a **MUS**; a
minimum-cardinality one is a **smallest MUS (SMUS)**; and the version where the atoms are *sets* of
clauses rather than single clauses is **group-oriented MUS (GMUS)**, with a standard file format
(**GCNF**) and a standard encoding — one selector/presence literal per group, assumed. That last is
exactly the encoding `~/source/descent-engine`'s `SubsetSolver` uses, arrived at independently.

**The algorithm is Liffiton–Sakallah minimal-hitting-set dualization**: a set is unsatisfiable iff it
**hits every minimal correction set (MCS)**, so the minimum such set is a minimum hitting set of the
MCSes, computed implicitly. `[IgnatievEtAl2015]` (CP 2015) is the state of the art and `forqes` its
tool.

**And the tool is already installed, which the stub did not know.** `pysat.examples.optux.OptUx` —
*"roughly follows the implementation of Forqes"*, its own docstring — ships inside the PySAT we
already depend on (1.9.dev15, verified importable). It takes a **weighted** partial CNF, so a group's
weight can be its vertex count and the optimum is then *minimum vertices* rather than minimum
groups. `Hitman` (its hitting-set solver) and `MARCO` (Liffiton's MUS/MCS enumerator) are the
neighbours. **No `forqes` binary and no Rust port is needed for the minimum.**

**What the search did NOT find, and it is worth recording as a negative:** no paper applying SMUS to
**critical subgraph extraction in graph colouring**. The colouring literature has vertex-critical and
`k`-critical graphs; the SAT literature has MUS; the bridge — *a minimum non-`k`-colourable induced
subgraph is a smallest group-MUS of the colouring CNF, with one group per vertex* — is stated nowhere
we can find. That is a small observation, not a theorem, and it is the frame this milestone runs in.

**Prior art inside this project, which two searches missed and Kooshi supplied:**
* `~/source/descent-engine` `crates/descent-sat/src/subset.rs` — assumption-based, **group-level**
  core extraction with structural `core ⊆ allowed`, core descent while it shrinks, and a growable
  universe. `crates/descent-cull/` is the cull on top. Gate 269/269.
* **`tools/hitset.py` (M49, 2026-08) is already an implicit-hitting-set exact engine** — the same
  CP-2015 algorithm family, for `μ` rather than for vertices: minimum hitting set of collected
  witness sets, ask the oracle, minimise the witness, repeat, terminate when the oracle refuses with
  `|S| = μ` **exactly**, and a cap ends it with the sandwich `[LB, UB]` *reported as a sandwich*.
  **Its measured scaling limit is in ledger row 44: right for ≤ ~60 columns, wrong for 446.** Ours is
  184 groups, between the two, which is the milestone's first real risk.

## §A — The formulation, and the measurement that killed the shortcut

**The reduction stage IS smallest group-MUS on one formula.** Encode the arena with one **presence
literal per orbit** (both the `L` and the `ρS` copy of each base orbit are separate groups): a
vertex's at-least-one clause is guarded by its group's presence, conflict clauses stay unconditional
(an absent vertex has all its colour literals false, which satisfies them). Then

> `hard ∧ {a_o : o ∈ S}` is **UNSAT** exactly when the selection `S` refuses four colours,

so a MUS **is** a minimal working selection and a smallest MUS is the minimum one. **The box
decomposition M62 has been using is an optimisation of the acceptance test, not a different problem**
— and it is not needed at all in this framing.

**Then the shortcut I proposed to Kooshi an hour earlier was measured and it is dead.** The claim was:
a refutation's failed assumptions are a sufficient selection, so one pass over the boxes replaces the
doubling probe at ~14× fewer solves. Measured on the corrected base, subtype `(0,4,4,0)+(0,0,2,6)`,
3,206 arena vertices / 184 groups / 106,685 hard clauses:

| | |
|---|---|
| all orbits present | **UNSAT in 9.5 s** |
| **first core** | **180 of 184 groups** — 3,180 arena vertices of 3,206 |
| confirm (re-ask over exactly the core) | UNSAT in 0.0 s |
| **second core** | **180 — it does not descend at all** |

**The solver's core is 98% of its input and the descent is a fixed point at round one.** So
core-driven descent is not a shortcut here, and *this project already knew it*: **ledger row 44
(M49) records "proof-guided shrink a fixed point at iteration one"**, measured in August on the
Exoo–Ismailescu certificate. **That is the third time in one day that what I needed was already
written down** — `[Parts2020a]` §5.6 this morning, `descent-engine`'s `SubsetSolver` at midday
(Kooshi), and now our own ledger. `G50`'s fourth half, minted into memory today, applies to this
project's own record and not only to the literature.

**What survives is the real algorithm**, which never depended on cores being small: hitting-set
dualization over MCSes, which is what `OptUx` implements and what `hitset.py` implements for `μ`.

## §B — Phases

**B1 — the planted control, before any real instance.** A graph whose minimum is known by hand
(a Moser spindle padded with irrelevant vertices; the answer must be a 4-critical subgraph, and the
padding must not appear). Validates the group encoding, the weights, and the tool at once. Minutes.

**B2 — the calibrated instance, per the stub's own insistence: point it at an object whose answer is
known.** Heule-510's own `L`/`S` split (375 + 135, measured at §R3), asking for the minimum `L`
keeping the arena non-4-colourable. If the answer is 375 the instrument agrees with the record; if it
is smaller, **the record is not vertex-minimal and that is a finding in itself**. This is the row
that decides whether anything below is worth running.

**B3 — the type-M arena**, weighted by orbit size so the optimum is minimum *vertices*, on the
corrected base at Parts's own subtype.

## §C — What may be reported, and what may not

* An `OptUx` optimum is a **candidate**, never a find. Promotion is the Lean pipeline's, unchanged.
* **A budget or a cap ends a run as a SANDWICH `[LB, UB]`, reported as a sandwich** — `hitset.py`
  already does exactly this and it is the house rule (`G21`: a cap is never a negative).
* Every reported selection is **re-verified independently** by rebuilding its arena from geometry and
  asking `refuses_four` directly, not by trusting the MUS tool's bookkeeping.
* **The box machinery keeps a defect that must be fixed wherever it is used**: `blocks()` gives its
  box solves no budget, so one hard box hangs the descent forever — measured today, two workers at
  18 minutes of CPU on a single refine step. A box solve that exceeds its budget is **undecided**,
  the drop is **not accepted**, and the log must say `undecided at budget`, never `survivor`.

## §M1 — Domain modelling pass: one representation, and a bug the pass caught

**Three representations were in play and they collapse to one, because two of them differ only in a
LIST.** `descent-cull` already names the role — `GroupKind::{Cheats, Vertices}` — and the type-M
descent's orbit granularity is a third value of that same enum, not a third model:

```
Arena       vertices 0..2n, edges          — exists (typem.Arena), unchanged
GroupList   [(label, weight, members)]     — the one thing missing
              members ⊆ arena vertices, pairwise disjoint
              their union is exactly the DROPPABLE vertices
              anything in no group is HARD — always present
Encoding    hard = guarded at-least-one ∧ colour⇒present ∧ conflicts ∧ pins
            soft = unit (a_g), weight |members|
```

**"Orbit-level" and "vertex-level" are one model with two group lists**, which is what makes the
two-stage descent (coarse then fine) a parameter rather than a rewrite.

**Decision 1 — the box decomposition is INCIDENTAL and is dropped.** What is intrinsic is the
*interface*: the two blocks touch only at the cross-endpoint vertices, so each constrains the other
only through the colouring pattern there. The box enumeration is one way to exploit that separation
and it **materialises a set exponential in the interface** — measured today at 18,408 for 24
endpoints. The monolithic CNF exploits the same separation implicitly, inside the solver, for free.
*What the box form uniquely gives is diagnostic, not structural*: `|P_L|` and `|P_S|` are objects one
can count, and their asymmetry (264 against 18,408) is how §R21 found the centre-pin effect. Keep it
as an instrument; do not build the search on it. **A second reason, from the unsampled member:** the
box form indexes patterns by one side's endpoints and quietly assumes the two sides' endpoint sets
correspond — true at `ρ₁₅` on this base, where cross edges join `u` to `ρu` within one orbit, and
**not a fact about type M in general**. The monolithic form never asks.

**Decision 2 — the `L` and `ρS` copies of one base orbit are TWO groups, and the pass found the
symmetry that makes that safe.** Parts chooses them independently (his reference orbit is *"always
full"*, his auxiliary *"may be only partially filled"*). And the problem has a genuine involution:
since `ρρ̄ = 1` and complex conjugation `σ` is *in* the order-24 group,

> `ρσ(L ∪ ρS) = σS ∪ ρ(σL)` — **the arena of `(L, S)` is isometric to the arena of `(σS, σL)`.**

So the optimum comes in pairs under a permutation of the group list, which halves the space and is a
**free control**: any reported optimum must be matched by its image.

**Decision 3 — weight is the VERTEX COUNT, not the group count.** The record is quoted in vertices
(509) and orbits here are 1, 6, 12 or 24 vertices, so minimising groups is a different problem.
`OptUx` takes a weighted WCNF, so this costs nothing.

**Decision 4 — orbit granularity provably cannot reach the record, and that is fine.** Parts's `L` is
375 vertices; orbit sizes are `{1, 6, 12, 24}` with **exactly one orbit of size 1** (the centre — a
point fixed by the whole group is the origin), so 375 is not plausibly a union of whole orbits, and
his §5.6 says so outright: *"priority should be given to partially filled base orbits"*. **Orbit
groups are stage one; vertex groups are stage two; they are the same model.**

**The bug the pass caught, before any run.** The centre is pinned by a **hard** clause
(`colour(centre) = 0`) while also sitting in an orbit of its own. Make that orbit droppable and the
encoding says *"the centre wears colour 0"* and *"the centre wears no colour"* at once — **UNSAT for
a reason that has nothing to do with colouring**, so a hitting-set search would price the centre as
essential on a contradiction and every optimum below it would be corrupt. **The centre belongs to no
group: it is hard.** The feasibility probe of §A had this defect; its 180-of-184 core reading is
unaffected (it asked with every group present), but nothing further could have been trusted.

*Illegal states remaining, audited rather than assumed:* an empty selection (legal, 4-colourable, and
the tool's own base case); a selection whose two sides are unequal (legal — Parts's own object is
375 + 135); a group whose members span both blocks (**forbidden by construction** — the group list is
built per side).

## §M2 — Execution modelling pass: the invariant, and the failure mode that would look like a record

**The one structural fact everything rests on is monotonicity.** `S ⊆ S'` and `refutes(S)` implies
`refutes(S')` — more vertices, more constraints, and a colouring of `S'` restricts to one of `S`. So
`refutes` is **upward closed**, and that alone gives the duality:

> **`refutes(S)` ⟺ `S` hits every correction set.**
> (⟸) if `S` misses a correction set `C` then `S ⊆ G ∖ C`, which is colourable, so by monotonicity
> `S` is too. (⟹) if `S` refutes and `S ∩ C = ∅` then `S ⊆ G ∖ C` and monotonicity contradicts `C`
> being a correction set.

**The loop invariant.** `M` is a set of **correction sets** (`¬refutes(G ∖ C)` for each), and `S` is a
minimum-**weight** hitting set of `M`.

**Why `w(S)` is a rigorous LOWER bound at every single iteration** — the property that makes an
interrupted run reportable: every refuting selection hits every correction set, so it hits every
member of `M`; `M` is a *subset* of the correction sets, so minimising over it is a **relaxation**.
Hence `w(S) ≤ w(S*)` always, and `w(S)` is non-decreasing as `M` grows. **The bound needs only that
each `C ∈ M` really is a correction set — minimality is nowhere required**, which is why the loop may
add un-minimised correction sets and stay sound.

**The exit condition and the optimality certificate are the same event.** `UB` = the least weight
among selections the oracle has *refuted*; when the oracle refutes the current minimum hitting set,
`LB = UB` and the answer is optimal. Nothing else has to be checked.

**Termination.** If the oracle finds a colouring of `S` then `G ∖ S` is a correction set, and it is
**new**, because `S` hits every member of `M` while `S ∩ (G ∖ S) = ∅`. So `|M|` strictly grows and
the loop terminates. **The bound is `2^m` and therefore useless in practice** (`m = 184`); real
termination is `LB` rising to meet `UB`, which is empirical. *Recorded as a known-weak measure rather
than dressed up*: minimising each correction set to an MCS would bound the count by the number of
MCSes, at `|C|` extra oracle calls apiece — with `|C| ≈ 180` and ~10 s per call that is half an hour
per minimisation, so it is a measured trade and not an obvious win.

**The failure mode that would look like a record, and it is the sharpest thing in this pass.** The
oracle is three-valued — refutes / colourable / **unknown at budget** — and an `unknown` may be
folded into *neither*:

* fold it as **colourable** and you add `G ∖ S` to `M` as a correction set **without having shown it
  is one**. If it is not, the hitting-set constraint is spurious, `w(S)` **stops being a lower
  bound**, and the loop can return a selection **lighter than the true optimum**. That is not a lost
  measurement — *it is a smaller-than-true answer wearing the shape of a record.*
* fold it as **refuting** and an infeasible selection is reported as feasible.
* skip it and continue, and the hitting-set solver returns the same `S` next iteration forever;
  excluding `S` to escape that **is** the first unsound move in different clothes.

**So `unknown` halts the loop and reports the sandwich `[LB, UB]`, naming the selection that caused
it.** Raising the budget and re-asking is the only other sound response. `tools/hitset.py` already
does exactly this and its docstring says so — *"Oracle `unknown` at cap ends the run with the
sandwich `[LB, UB]` reported as such"* — which is the third time today the answer was already in the
repository.

**The box test, same question, different answer, because the two are asymmetric.** `blocks()` decides
whether to *accept a drop*, and **declining a drop is always safe** — it costs completeness, never
soundness. So an undecided box may be treated as "do not accept". What it may **not** do is *say
survivor*, because "a survivor exists" is a claim about the world that later reasoning consumes
("this orbit is essential"). The verdict type is therefore three-valued —
`Blocked | Survivor(i) | Undecided(i, budget)` — the decision folds `Undecided` with `Survivor`, the
**log and the artifact do not**, and a descent that finishes with any `Undecided` has converged to a
fixed point **of its budget**, not of the mathematics, and its summary must say so. This is M62
§M3.1's own verdict rule applied where it had not been: today's live descent had **no budget at
all** and spent 18 minutes of CPU on one box before it was stopped.

**The `L↔S` involution is sound as symmetry breaking, and is being used as a control anyway.**
`τ(L, S) = (σS, σL)` is an isometry of arenas, so it preserves feasibility *exactly* and preserves
weight (`σ` permutes orbits of equal size; the swap preserves the total). The minimisation hazard —
breaking a symmetry whose two images are not both feasible can cut the optimum — **does not arise
here**, because `refutes(τ(X)) ⟺ refutes(X)`. So a lex-leader restriction to one representative per
`τ`-orbit is sound and would buy ~2×. **It is nonetheless held in reserve**: the same fact used as a
*control* is free and catches encoding bugs (any reported optimum's `τ`-image must have equal weight
and must also refute), while as symmetry *breaking* it is new constraint code inside the one place a
bug produces a too-small answer. **Control first; the 2× only if the run needs it.**
