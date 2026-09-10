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
