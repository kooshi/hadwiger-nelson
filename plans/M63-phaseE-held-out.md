# M63 phase E — held-out generalization

*Planner's subplan, 2026-09-11. Phase E of milestone M63 (reproduce `[Parts2020a]`'s graph-minimization
algorithm end to end). **Required for M63 to close** — `plans/M63-parts-reproduction.md` §S.1 clause 3:
"Reported as not run" is not an ending.*

*Status: **planned, not approved, nothing run**. The product owner's approval goes in §A. Every number in
§1 was measured during planning from files already on disk, solver-free, at a cost of seconds; every number
in §2 is a forecast.*

---

## §0 — What phase E is for, and why tonight's course correction promotes it

**In one sentence.** Run the reproduction, frozen and untouched, on problems it was never tuned on, and
say row by row whether it agrees with `[Parts2020a]`'s published answers.

**Why that is the product and not a formality.** The product owner's ruling, 2026-09-11:

> *"Shrinks are context dependent, so the goal should be to reproduce Parts' METHOD so that we can find
> smaller graphs that he may not have gotten to — also, we need to get to the point where we introduce new
> bases and rotations, where it is most likely to actually find something novel."*

If the deliverable is **the method** rather than **his object**, then evidence that the method works on
inputs nobody tuned it on *is the warranty on the method*. Phase E stops being the last box to tick and
becomes the thing that licenses phase G. Three consequences shape this plan:

1. **Phase E is the last place one control still works — and on the path E's own required row runs, it is
   already off.** The guard is an anchor: *a known refusing object must still be a literal selection of the
   constructed stage* (`tools/parts_loop.py:check_invariants`, verdict `contains-a-known-minimum`). It is
   strong and cheap **because Parts published minima**. Read the call sites rather than the prose about
   them (Poros, card 5; verified here):

   | caller | anchor |
   |---|---|
   | `parts_loop.run_map` — the 89-candidate `A412` sweep | **supplied** (`:711`, `:769`) |
   | `parts_rule.run_loop` — **the loop E3 runs** | `anchor_tuples=None`, hard-coded (`parts_rule.py:387`) |
   | `parts_diag.hismove` — tonight's calibration gate | `anchor_tuples=None`, hard-coded (`parts_diag.py:196`) |

   With `anchor=None` the function returns `restriction-identity-holds` and simply **omits** the `anchor`
   key: an entry that checked the anchor and an entry that could not are distinguishable only by a missing
   field. That is this repository's signature failure — *a check that reports nothing when it cannot run*
   (`CLAUDE.md` § Make the gate fail). **So the sentence "every reduction is guarded by the anchor" is not
   true today, and this plan does not write it.** §2's **E9** characterises the guard while ground truth
   still exists: planted faults, a measured killed/survived table, and a **written residue** — the fault
   classes it cannot see even when green. **And E9.5 is this phase's headline deliverable** (§A ruling 3):
   the only non-circular geometry re-derivation this repository owns is welded to the 509, and calibrating
   it *means* running it where the anchor also fires. It is a one-way door — after phase E there is no
   object whose answer we know.
2. **The sharpest row is the one whose companion is an edge.** Most rows pair a large half of a type-M
   graph against a small half of the same kind. The `8/3` mono-pair does not: its companion graph is a
   single edge. It exercises the *companion abstraction*, which is exactly the piece phase G leans on
   (a new base may have no natural second half — phase F §2.6 item 7). It is row **E3**, and it is the
   phase, not one of six.
3. **The subtype rows are the nearest thing in his data to a new rotation.** `M6A`/`M6B`/`M6C` differ in
   the **auxiliary connection orbit** — the subtype name `M6` is read off the six auxiliary edges
   (`plans/M63-parts-reproduction.md` §1(i)). Phase G varies the connection law. So the held-out `M6B` and
   `M6C` rows are not near-duplicates of the calibration: they are the only published evidence that the
   pipeline survives a change of connection orbit. **§S.4's list, written before tonight's correction, is
   right about which rows to run and wrong about why** — it ranks them as "more reduction rows"; this plan
   ranks them as *connection-orbit generalization*, which is the phase-G-facing reading. That is the one
   substantive argument this plan makes against the roadmap text it inherits, and §6 decision 5 carries it.

**What phase E is NOT.** It is not a record attempt (that is phase F), not a tuning opportunity (the
configuration is frozen at commit `6158162`), and not a place where a disagreement gets configured away.
**A held-out row that disagrees is a result.**

---

## §A — Product-owner review

**Three rulings, 2026-09-11, during planning.**

1. **E3b is APPROVED, and E3 is re-labelled.** *"A row seeded with his own minimum returns `|M| = 367` at
   iteration zero, so 'reach his `|M|`' is vacuous: it reports a pass while checking nothing. That is this
   project's signature failure, and we have catalogued five instances of it tonight alone. Run E3b with a
   start whose minimum is strictly above 367, and re-label the original row as discharging clause 2(c), not
   2(b) — the vacuity is not a reason to drop the row, only to stop it claiming something it cannot
   support."*
2. **`his_indicators` is OUT OF SCOPE for phase E, with the reason recorded so it is not re-opened.**
   *"Whether his own published ranking device selects his own recorded move is a real fact about his method,
   and the method is the product since tonight's correction. But phase E's entire value is that it runs a
   **frozen** configuration against problems nobody tuned on; implementing a new ranking device inside it is
   exactly the contamination the freeze exists to prevent. It goes to the expansion work, where ranking
   lives."*
3. **E9.5 is phase E's HEADLINE DELIVERABLE, not an addendum.** *"'A builder being exact is not a check.'
   Phase F's §2.6 lists exact geometry among the controls that transfer to new ground, and it does not — the
   only non-circular re-derivation we own is welded to the 509, and it can never be calibrated after phase
   E, because after phase E there is no object whose answer we know. That is a one-way door. It is the
   single artifact the rotation work consumes, and if it is not built now it cannot be built at all."*
   The §X.2 amendment to phase F's plan is **the product owner's to apply**, not this plan's.

*Still open for the product owner: §7's remaining items.*

---

## §PA — The prior-art gate (WORKFLOW step 3a)

*Run 2026-09-11 during planning, before any design below was written. Phases C, D and F each ran their own
gate; this one covers only **what is new in phase E** and cites theirs rather than repeating them.
`plans/M63-phaseD-the-loop.md` §PA owns the loop's literature (large-neighbourhood search, reliability
branching, MUS/MCS enumeration) and the two-database citation walk of `[Parts2020a]`;
`plans/M63-phaseF-beat-509.md` §PA owns "is 509 still the record" and the monotone-predicate framing.*

### PA.0 — What is new here, stated so it can be searched

Three objects, none of them Hadwiger–Nelson:

1. **Validating a reimplementation of a published algorithm on instances it was not developed against.**
2. **Characterising a correctness check by deliberately breaking things** — measuring what a guard catches
   and what it misses.
3. **Guarding a computation that has no ground truth at all** (phase G's regime).

### PA.1 — Discipline one: empirical algorithmics and algorithm configuration

The recognition sentence (G46): *we have reimplemented a published heuristic and must show it generalises
beyond the trajectory it was built against.* Searched under **empirical algorithmics**, **experimental
analysis of algorithms**, **algorithm configuration**, **over-tuning**, **benchmark overfitting** — never in
this project's vocabulary.

| what the field owns | what it gives phase E | status |
|---|---|---|
| `[Hooker1995]` *Testing heuristics: we have it all wrong* (J. Heuristics 1(1) 33–42) — the case against competitive testing and for controlled experiments that explain rather than rank | the warrant for **no aggregate verdict**: a pass rate over held-out rows is precisely the competitive-testing summary Hooker argues destroys the information | named, **not read** |
| `[Johnson2002]` *A theoretician's guide to the experimental analysis of algorithms* (DIMACS) — instance selection, reporting, the reimplementation trap | the standard statement that a reimplementation's numbers deviate when the paper omits details — which is exactly M63's companion finding (§R3.4) in the general case | named, **not read** |
| `[EggenspergerEtAl2019]` *Pitfalls and best practices in algorithm configuration* — **over-tuning**: configurations that win on training instances and lose on unseen ones; the effect is measurable only *after* configuration ends | the name for the failure §3 of the reproduction plan describes in its own words, and the reason predictions must be committed **after** the freeze commit and **before** the run | named, **not read** |

**Finding, recorded as such:** nothing found applies held-out validation to a *reproduction* of a specific
published combinatorial search. The literature's held-out sets are drawn from an instance distribution;
ours is **fifteen published rows of one paper**, of which two are spent. There is no prior art for the
thing this phase does, and the negative is the finding.

### PA.2 — Discipline two: software testing and code verification

Recognition sentence: *we are testing a program whose correct output we cannot compute independently.* That
is a named problem with a named literature, and this repository has never entered it.

| what the field owns | what it gives phase E | status |
|---|---|---|
| **the test oracle problem** — the difficulty of deciding whether an output is right when no oracle exists | the name for phase G's regime; our anchor is an oracle, and phase G has none | named, **not read** |
| **metamorphic testing** (`[ChenEtAl1998]`, `[SeguraEtAl2016]`) — *metamorphic relations*: properties relating the outputs of two runs on related inputs, requiring no oracle | the oracle-free replacements in **E9.4**: equivariance under the base group, monotonicity under adding vertices, idempotence of re-reduction | named, **not read** |
| **mutation testing / fault injection** — seed known faults, measure how many the test suite kills | the exact shape of **E9**, and the vocabulary for reporting it (killed / survived) | named, **not read** |
| **the method of manufactured solutions** and its **blind-test protocols** (`[SalariKnupp2000]`, SAND2000-1444) — construct a problem whose answer is known, then *deliberately* seed coding mistakes and publish which classes the procedure exposes and which it cannot | **this is E9, already done once in another field.** Its published output is a taxonomy of exposed and unexposed fault classes; ours should be written in the same shape | named, **not read** — and it is the one read that would most improve E9 |

**What this buys, concretely** (the gate is aiming, not insurance):

- **Metamorphic relations are free instruments for phase G**, and they arrive with a known limitation which
  this plan states rather than discovers: *a metamorphic relation cannot see a consistently wrong problem*.
  Build the stage with the wrong cross-edge law and every equivariance and idempotence relation still holds,
  because both runs are wrong the same way. **The only things that catch "we built the wrong graph" are an
  external anchor or an independent re-derivation of the geometry.** On a new base the anchor is gone, so
  the re-derivation — exact unit-distance verification of every edge against the *stated* construction, by
  code that shares nothing with the builder — is not an extra; it is the whole oracle. E9's residue section
  says this in full.
- **"Killed / survived" is the right report shape**, and it has no aggregate: a mutation study reports which
  faults survived, not a score.

### PA.3 — The question, not the method

*Has anyone reproduced or extended `[Parts2020a]`'s minimization?* Phase D §PA(b) walked the citing works in
two databases (OpenAlex 5 + 3, Semantic Scholar 19) and found **nobody cites it as a method**. Re-checked
here by a different route — searches for *graph minimization algorithm reproduced independent
reimplementation unit-distance* return his paper, `[Heule2019]`'s clausal-proof trimming, and nothing that
reruns either. **Is 509 still the record?** Yes: `[Haugland2026]` (August 2026) says so in its
introduction, and MathWorld's Hadwiger–Nelson entry records the 509-vertex Parts graph as the smallest
known. **Is anything published about his non-type-M rows?** The `8/3` mono-pair and the `√(11/3)` non-mono
pair are folklore in the Polymath16 corpus — a chain of four rhombi gives a mono-pair at `8/3` and three
give a non-mono pair at `√(11/3)` — which agrees with his Table 1 and with our own transcription
(`data/m62/parts-table1.json`, `nmp-sqrt11/sqrt3`). Nobody has published *minimal* graphs for these
properties other than Parts.

**Outside arXiv:** the *Geombinatorics* author index for Jaan Parts was checked in phase F §PA.1 and lists
nothing after 2020 on minimization. Not re-checked here.

### PA.4 — Bibliography rows this gate owes

Five, all *named only, not read*: `[Hooker1995]`, `[Johnson2002]`, `[EggenspergerEtAl2019]`,
`[ChenEtAl1998]` (or `[SeguraEtAl2016]` for the survey), `[SalariKnupp2000]`. Draft rows are in §X.3 for
paste; the planner did **not** edit `BIBLIOGRAPHY.md`, which has other writers tonight (§7 item 5).
`python3 tools/bib_audit.py` must be green after they land.

---

## §1 — What the implementer must know before writing a line

*Everything in this section was measured during planning, from files already in the repository, with no
solver and no heavy job. The brief's rule — **ask what is already on disk before proposing a run** — paid
four times here, and each payment removed a risk from a row below.*

### 1.1 — The fifteen rows, and which are held out

`data/m62/parts-table1.json` is the transcription of his Table 1 with per-field attestation counts. It is
**data, not call-site arguments**: no number below is ever typed at a call site.

| row id | problem | companion kind | `\|M\|` | `\|{M}\|` | `A` | phase E status |
|---|---|---|---|---|---|---|
| `S-M6A-136` | `v166e774 → v136e564` | frozen L graph | 136 | 8 | 166 | **SPENT** (§R1 calibration) |
| `L-M6B-375` | `v403e2106 → v375e1916` | frozen S graph | 375 | 66 | 403 | **SPENT** (phase C3) |
| `L-M6A-374` rung 1 | `v412e2106 → v374e1860` | frozen S graph | 374 | 1092 | 412 | **replay, in flight** (E0) |
| `mono-8/3` | `v375e1862 → v367e1822` | **an edge** | 367 | 27 | 375 | **held out** — E2 (reduction), **E3 (the loop)** |
| `L-M6B-374` rung 2 | `v406e2076 → v374e1864` | frozen S graph | 374 | 78 | 406 | **held out** — E4 |
| `L-M6C-374` | `v400e2034 → v374e1872` | frozen S graph | 374 | 76 | 400 | **held out** — E5 |
| `S-M6B-141` | `v172e804 → v141e594` | frozen L graph | 141 | 4 | 172 | **held out** — E6a |
| `S-M6C-150` | `v167e772 → v150e639` | frozen L graph | 150 | 28 | 167 | **held out** — E6b |
| `nmt-sqrt3` | `v238e1131 → v221e1006` | **a joined 3-clique** | 221 | 120 | 238 | **held out** — E7 |
| the other six | `mono-8/√3`, four `nmp-*`, four more `nmt-*` | edge / clique | — | — | — | **not run**; reserve (§2.11) |

**THE SPENT ROWS, EXCLUDED IN WRITING.** This paragraph is the exclusion, not a summary of one:

> **`L-M6B-375` — his M6B 375 row (`v403e2106 → v375e1916`, 66 minima) — is NOT a held-out row and is not
> run in phase E.** Phase C3 spent it as calibration with the product owner's approval
> (`plans/M63-phaseC-joint-stage.md` §A.1 #3); the audit marks it `spent: C3` in both
> `data/m62/parts-table1.json` and `data/m62/m63-audit-M6B403.json`. It appears in no held-out list, no
> agreement count and no judgement below. **`L-M6B-374` at the rung-2 subgroup stays held out** and is row
> E4. **`S-M6A-136` is also spent** (`spent: R1`), which is why the 138-vertex S start is a *mechanism
> control* (E8) and not a held-out row.

**And one leak nobody has written down, which this plan must state before Poros finds it.** The counting
convention for `|{M}|` — *"non-isomorphic" = up to `Aut(A)` with the companion free to move* — was
**fitted** against his published 8 on the spent `S-M6A` row (§R1). Every other row's `|{M}|` therefore
inherits a convention chosen to make one published number come out right. It has since **predicted** two
counts it was not fitted to (282 at L375, 96 at L376), and Poros derived 282 independently by Burnside
before the run.

**And the shape of the remaining exposure is narrower and sharper than "it was fitted"** (Poros's card 13,
sent, then half-withdrawn by its own author against the artifacts, then re-verified here by reading
`data/m62/m63-audit-{S166,L451,M6B403}.json` directly). Each audit already reports the level under three
named groups:

| row | `Aut(A)`, companion free — **his convention** | `Aut(A) ∩ Aut(C)` | the whole order-24 base group |
|---|---|---|---|
| `S166` (**the fit**) | order 6 → **8** | order 2 → 24 | order 6 → **8** |
| `L451` | order 12 → **282** | order 1 → 3,264 | order 12 → **282** |
| `M6B403` (**spent**) | order 6 → **66** | order 1 → 360 | order 6 → **66** |

So the convention was fitted on `S166` and then **agreed on two further rows** where the companion-fixed
rival would have said 3,264 and 360. That is two genuine confirmations, and `tools/parts_audit.py` already
computes this table — **E runs it, E does not build it.**

**What is still unseparated, and it is the live ambiguity:** `Aut(A)` and **the whole base group** give the
*same* order and the *same* count on all three rows. The rival that was ever separated is the
companion-fixed one; **`Aut(A)` against the full base group has been separated on no row that has ever been
run.** Every agreement so far is an agreement against a rival that was never the live one. Two consequences,
both foreclosed in advance rather than argued afterwards:

- a held-out `|{M}|` that agrees is **real held-out evidence for the fitted convention** — and it is not
  "reproducing his count" in the sense a reader hears. Every record says which it is.
- if a row disagrees, *"a different group on this row"* is an available post-hoc escape, and it is **more**
  available now precisely because the artifacts honestly carry several counts. **E-pre.1 forecloses it** by
  naming the predicted group per row before the run.

So the honest classification, which every E row must carry:

- **`|M|` is clean held-out evidence** — triply attested, convention-free, and the hard gate.
- **the orbit-filling ranges and edge ranges are clean** — doubly attested, convention-free.
- **`|{M}|` is semi-held-out**: each new row is a further out-of-sample test *of the convention*, and a
  disagreement in `|{M}|` alone is evidence about the convention, not about the reduction. **It is
  reported, never gated** (§3 gate rank 5 of the reproduction plan), and every E row says this in its
  record rather than leaving a reader to infer it.

### 1.2 — The companion is a per-row parameter — except on three rows, where it is a constant

Binding, from `plans/M63-parts-reproduction.md` §S.1 clause 2(a): *the companion is whatever his loop held
at that moment, and it changes as the loop runs; comparing our numbers against a row of his table without
reconstructing that state is comparing two different problems.* `|M|` is comparable across rows; `|{M}|`
and `A` are comparable **only once that row's companion is identified**, and a row without one reports
`|M|` alone with `|{M}|` and `A` reading `not-compared` and the reason.

**The non-obvious consequence, and it further promotes E2/E3/E7.** The mono-pair and non-mono-set rows
have **no alternating partner**. Their companion is a fixed parameter of the problem statement — the edge
at `8/3`; the 3-clique on the `√3` triple — and it cannot have changed as his loop ran, because there is no
second half to alternate with. **So on exactly these rows `|{M}|` and `A` are comparable with no loop-state
reconstruction at all.** They are the cleanest comparisons on the board, and the L and S rows are the ones
that must pay for a companion identification first.

**How a companion is identified, for the L and S rows** (phase D §R3.4's procedure, and the reason it
exists: at his state 1 the partner was the S *accumulator* `v166e774`, not the S *minimum* `v136e564`, and
assuming the minimum returned a different problem — 82 minima against his 96). For each candidate partner,
ask whether his published minimum refuses four colours against it in some frame of the order-24 group:

```
python3 tools/parts_run.py frames --L <his minimum> --S <candidate partner> --refuses-with <his minimum>
```

Cost: 24 refusal asks **with the §5.9 pin**, ≈ 3 s each ≈ **75 s per candidate** (without the pin it is 40
minutes — the pin is worth 62× on a cold refusing ask, measured 2026-09-11). Candidates per row are that
subtype's published S (or L) minimum and accumulator — two or three each.

### 1.3 — Every designated set is already determined, on disk, and confirmed twice

*This is the largest single de-risking of the phase and it cost eleven seconds of CPU. The mono-pair and
non-mono-set rows need to know **which** pair or triple the key property is about; his `.vtx` files do not
say, and a plan that guessed would have been guessing at the problem statement.*

His own index (`data/m62/parts-ref11/JP/Large/`, joined into `data/m62/parts-table1.json` as
`distance_note`) states each designated set, and the geometry confirms it independently:

| row | designated set, his coordinates | as `(a,b,c,d)/12` tuples | independent confirmation |
|---|---|---|---|
| `mono-8/3` | `(±4/3, 0)` | `(16,0,0,0)`, `(−16,0,0,0)` | **the unique pair at distance `8/3`** in `v367e1822` *and* in `v375e1862` — exhaustive exact scan of all 67,161 and 70,125 pairs, one hit each |
| `nmt-sqrt3` | `(1,0)`, and *"all triples are centred at the origin with the other points obtained by multiplying by `exp(±2πi/3)`"* | `(12,0,0,0)`, `(−6,0,6,0)`, `(−6,0,−6,0)` | present 3/3 in `v221e1006` and `v238e1131`; it is one of the 9 origin-centred `√3` triangles among the 59 the graph contains, and his index picks it out |
| `mono-8/√3` | `(0, ±4/√3)` | `(0,0,16,0)`, `(0,0,−16,0)` | present 2/2 in `v421e2094` and `v433e2186` |
| `nmp-7/3`, `nmp-5/3`, `nmt-1/√3` | `(±7/6, √11/6)`, `(±5/6, √11/6)`, `(1/3,0)·ω` | see `parts-table1.json` | present 2/2, 2/2, 3/3 in both files of each row |

**The `√3` triple would NOT have been recoverable from geometry alone** — `v221e1006` holds 59 `√3`
triangles, 9 of them centred at the origin. It is recoverable from his index, and the two sources agree.
No run is needed to determine any designated set, and none may be used to choose one.

**Excluded for a stated reason:** `nmp-3` and `nmp-1/3` sit off the base by a translation
(`plans/M63-parts-reproduction.md` §1(vi)); their forced pair's midpoint is not a lattice point. They are
not in phase E.

### 1.4 — The §5.9 pin is present on every L-side object and absent from every S-side one

Measured: the pin triangle `(0,0)`, `(1,0)`, `(1/2, √3/2)` = `(0,0,0,0)`, `(12,0,0,0)`, `(6,0,6,0)` is
present 3/3 in `v367e1822`, `v375e1862`, `v221e1006`, `v238e1131`, `v406e2076`, `v400e2034`, `v374e1864`,
`v374e1872`, and **1/3** (the shared centre only) in `v141e594`, `v150e639`, `v167e772`, `v172e804`.

Consequence, and it is a cost fact not a blocker: `Stage` requires the pin on the **L side**, and on an
S-side reduction the L side *is* the companion, which is an L graph and carries it. So every row can be
pinned — the S rows through their companion — and the 62× stands. **A row that ends up unpinned must say so
in its record**, because its ask costs are then a different population (G21).

### 1.5 — What the code does not have yet, named exactly

Three gaps, and the first two are the phase's engineering content:

1. **`Stage` has no companion abstraction.** Its signature is `Stage(base, L_tuples, S_tuples, side=…)` —
   two halves of a type-M graph. The module docstring already describes the right model (*"a **Companion**
   is (extra vertices, extra edges) whose vertices are NEVER deletable"*) but the code implements only the
   frozen-half case. For a mono-pair, `S_tuples = []` gives the wrong answer twice over: the two pair
   endpoints must be **fixed** and are not, and the shared centre must be **deletable** and is not
   (`deletable |= Lbits & ~(1 << self.A.centre)`). E1 builds it.
2. **`parts_rule.run_loop` hard-wires its starting stage.** Lines 321–327 rebuild
   `Stage(base, v451e2400, v136e564, side="L", rung=1)` and refuse any record whose
   `stage_fingerprint` differs. The loop can therefore run on exactly one problem. E1 makes the stage come
   from the record's own problem description. **This is the same change phase F §2.6 calls the input
   interface**, which is why E1's cost is charged to phase G as much as to phase E.
3. **The anchor fails open, and is already off on two of three call sites** (§0, table). E9 fixes the
   reporting — a named `anchor-not-supplied` verdict carried in the record — without changing any
   behaviour the freeze pins. This does **not** retract tonight's calibration: `hismove` is itself a
   known-answer test, so the anchor was redundant there.
4. **`Comparison` cannot carry a companion.** `tools/parts_report.py:136` has fields
   `what / ours / his / attestation / mode / gated / freeze_commit`, with `ours` and `his` bare
   `int | None`. §S.1 clause 2(a) says a `|{M}|` or `A` comparison must name its companion or read
   `not-compared` **with its reason**, and there is nowhere to put either. The repository's own standard is
   the fix (Poros, card 11): **push the invariant into the type** — a `Comparison` whose `what` names
   `|{M}|` or `A` requires a companion (a fingerprint, or the literal `"unidentified"`) and refuses to
   construct without one. Then a row that compares an accumulator without naming its companion is not a
   discipline failure, it is a `ValueError`. An hour's work, and it retires a rule from prose permanently.

**The refactor's own negative control, and it is mandatory.** Every stored record carries a
`stage_fingerprint`, and `tools/parts_run.py compare` regenerates records for identity. The companion
refactor must be **fingerprint-preserving on the type-M path**: regenerate the `S166` and `L451` records
and require identical minima, `Y` and bounds (control `C1`, which already exists). A refactor that moves a
fingerprint has silently changed every comparison in the milestone.

### 1.6 — The cost model, and which cost each row is buying

Two costs, two orders of magnitude apart, measured tonight on the same run: **188 seconds to find the
optimum, 79 minutes to enumerate the complete level set.** Every row below is therefore split:

- **stage (a), the decision** — *is there a refusing selection of at most `t` atoms?* — buys **`|M|`**, the
  hard gate. Priced at one ask per atom for phase 1 (measured means, the machine, ~550-vertex stages:
  colourable 0.065–0.081 CPU s, refusing 0.20–0.40 CPU s) plus the hitting-set search. Minutes.
- **stage (b), the complete level** — buys **`|{M}|`, `A`, the orbit-filling ranges and the edge ranges**
  (gate ranks 2 and 3, plus the reported-never-gated rank 5). Tens of minutes to hours.

Reference points: `L451` (450 atoms, gap 76) closed its level in 605 s over 16,683 asks; `S166` in 587 s;
the `A403` + four-orbit stage found its optimum in 188 s and enumerated in 79 min; the rung-1 374 level on
411 atoms is at 19,331 minima after 3.5 CPU hours and still running.

**A row that only needs `|M|` is never scheduled as if it needed the level.**

**`max_minima` is a per-row decision made in advance, not at hour six** (Poros, card 17). A capped level is
a `Count` with method `truncated-at-budget`; **a row whose cap binds reports `|{M}|` as `not-compared` with
the cap as its reason, never as a `≥`** (§3). Each row's cap is registered with its predicted value, because
deciding a cap once the cost is in the room is deciding with the cost in the room.

**And the level stage is priced on the RAW level, not on the canonical count** (Poros, card 22 — he
conceded the forecast and then found the formula behind it was on the wrong quantity, which is the more
useful correction). The enumeration walks every minimum; the canonical count is what a *group* collapses
them to afterwards. Measured ratios: `S166` 48 raw → 8 canonical (6×); `L451` **3,264** raw → 282 (11.6×);
`M6B403` 360 → 66 (5.5×). So `L451` enumerated **3,264** minima in 605 s, not 282, and the forecast below
holds with *more* headroom than claimed; E7 at 120 canonical is roughly 660–1,400 raw, still inside the
`L451` envelope. **A forecast stated on the canonical count is off by 5–12× the moment phase G inherits it
for a base whose group order differs.** The rule: *level cost scales with `canonical × group order ÷ mean
stabiliser`* — and **E-pre.1 already computes the group that estimate needs**, before any row runs, which
makes that computation do double duty.

### 1.7 — What the freeze actually freezes, and the per-row registration that fixes it

*Checked in the code, not in the plan's prose about it (Poros, cards 1–3; every claim verified here).*

- `R.require_frozen` has **exactly one caller**: `tools/parts_rule.py:519`.
- It sits behind `--require-frozen`, an `action="store_true"` flag, **default off**. A run launched without
  it writes `freeze_commit: None` and nothing objects.
- `data/m62/m63-freeze.json` holds no `wall_ask`, no `max_minima`, no `phase2_wall`, no `rung`, no
  `cross_law` and no `fp_base` — even though §S.5 recorded the intent that *"the freeze pins
  `cross_law = collinear(7/8)` and `fp_base(Base(2.6))` inside the config hash"*. Neither is in the
  committed file.
- Its `held_out_state`, `incumbent_weight` and `target` **describe** a run rather than driving one: the
  runtime incumbent comes from the starting record (`parts_rule.py:329`). On the `8/3` row all three are
  false statements and `require_frozen` passes them by hash equality.

**So "the configuration is frozen" is true of one row in seven.** The fix is not to re-freeze — the freeze
commit is what it is, and editing it would destroy its only property. The fix is a **second registration,
per row, committed before that row runs**, carrying: the starting object and its fingerprint; the companion
constructor, its arguments and its fingerprint; the stage fingerprint and `fp_base`; the rung and the
counting group; `wall_ask`; `max_minima`; and the predicted values. Then *frozen* means something for all
seven rows instead of one, and every row's record can be checked against a commit that predates it.

**Also to be exercised in E, because phase D's acceptance asked for it and no evidence exists that it
happened:** `require_frozen` red and green **on the real file**, not only in a scratch git repository.

---

## §2 — The experiments

*Each row: inputs · companion · what it buys · registered prediction · cost and which cost · what a
disagreement would mean. Predictions are collected in §3 and **committed in one commit after the freeze
`6158162` and before the first held-out run**.*

### E-pre — Two solver-free computations that decide what the rows can test (RUN FIRST)

*Both are minutes, neither touches a solver, and each can change what a later row means. Poros's cards 13
and 8; adopted whole.*

**E-pre.1 — Which group is each row's `|{M}|` predicted under, and can that row separate the live
ambiguity?** For each of the six reduction rows, compute on his published accumulator and companion, with
**no solver** (stabilisers of his own files; handoff §7 records both loop parameters as readable without
one): the order of `Aut(A)`, of `Aut(A) ∩ Aut(C)`, and of the full base group. Register per row, before any
run: the three orders; **whether `Aut(A)` and the full base group are distinct on that row**; and which one
his printed number is predicted to match. A row where they coincide **cannot test the convention** and its
prediction says so in one clause. A row where they differ would be **the first row in this milestone that
can**, and it runs first. Seconds per row.

**And name the artifact, not only the group** (Poros, card 13b — a plumbing hazard, verified here). The
reduction record does **not** hold the number that gets compared: `m63-M6B403-reduction.json` carries
`M_set = {count: 360, up_to: "as found (the companion fixed); canonical counts are the audit's"}`, while
the number reported against his table is **66**, from `m63-audit-M6B403.json`. At `S M6A` the two differ by
**6×** (48 against 8). The labelling is honest and the audit ties back by `stage_fingerprint`, but a
`Comparison`'s `ours` value for `|{M}|` is sourced from a *different artifact* than the reduction. **Each
row's registration names the artifact AND the group its predicted number will be read from**, so a row
cannot later quote the raw count where the canonical was meant.

**E-pre.2 — Does the frozen rule have any content on E3's menu?** `_rank_ours` sorts by
`(−freed_per_vertex, his_rank)` and its own docstring says *"candidates the proxy cannot separate keep his
order, so the rule degrades to his where it has no information."* Audit row B-12 measured the proxy flat:
`look_ahead.freed` read **0 of 336 necessary atoms on every orbit tried**, including an orbit his own
recorded move used. **If it is flat on the mono-pair menu too, `rule="ours"` and `rule="his_degree"` emit
the identical ordering**, and a null on E3 would be written up as *"our rule failed"* when the honest
reading is *"our rule was never in the room."*

So: before E3 runs, compute `look_ahead` over the mono-pair's candidate menu at `wall_ask=60` — tens of
asks, no level enumeration, minutes. If any candidate reads non-zero, the rule has content on that row and
the plan says so. **If none does, that is written down BEFORE the run**, and E3 takes the free control arm:
run it again with `--rule his_degree` and confirm the outcome is identical. That converts a null from a
failure report into a derivation.

**Cost** minutes each, single core. **Blocks** E3's interpretation and every `|{M}|` prediction.

### E0 — Close the rung-1 374 level (a REPLAY, not a held-out row)

**Inputs** `L = v412e2106`, `S = v136e564`, reduce L, rung 1. Already running (PID 2787457, started 19:44,
checkpoint `data/m62/ckpt/m63-D1b.ckpt.json`, 19,331 minima, `w* = 373`, 0 undecided).
**Companion** `v136e564`, identified in phase D (§S.4 phase D acceptance).
**Classification — and this answers a question the roadmap left ambiguous:** `|{M}|` at this row is
assigned to phase E by audit rows G-1/G-3/G-5, but **the row is a replay, not held out**: its accumulator
is his published `A412`, phase D read its `|M|`, and the run is an **unfinished phase D row that happens to
finish during phase E**. It is reported as such, appears in no held-out list, and **plays no part in the
held-out judgement** (Poros, card 14(ii), adopted).
**What it buys** his 1,092 (comparable: the companion is identified), the rung-1 374 edge range against his
1860–1884, and closure of three audit rows.
**Cost** zero new compute — collect the record when the job finishes. **Do not restart it, do not signal it.**
**Disagreement** `|{M}| ≠ 1092` under the named convention is evidence about the convention (§1.1), not
about the reduction, unless `|M| ≠ 374` — which phase D already closed at 374.

### E1 — The companion constructors, with planted controls that flip

**Deliverable** a `Companion` in `tools/parts_stage.py` carrying `(extra vertices, extra edges, fixed
vertices, kind, fingerprint)`, with three constructors, and `Stage` taking it:

| constructor | what it builds | `[Parts2020a]` §5.3 |
|---|---|---|
| `Companion.graph(tuples)` | the existing frozen other half | *"for an L-graph, it is an S-graph and vice versa"* |
| `Companion.mono_pair(u, v)` | **no new vertices**; one edge joining two existing vertices of `W`, both made non-deletable | *"for a mono-pair it is an edge of the corresponding length"* |
| `Companion.non_mono_set(S)` | three **new** vertices forming a triangle, each joined to every vertex of `S`; `S` made non-deletable | *"for a non-mono-set it is a 3-clique, each vertex of which is connected to all vertices of this set"* |

Plus `run_loop` taking its starting stage from the record instead of the hard-wired pair (§1.5 item 2).

**Planted controls, each with the verdict it must flip** (a check is not known to work until it has been
seen to fail):

| # | plant | must flip to |
|---|---|---|
| c-E1.1 | the mono-pair edge at the **wrong length** — join `(16,0,0,0)` to a vertex at distance 1 instead of `8/3` | `v367e1822 ∪ C` becomes **colourable** → `key-property-absent`, never a silent pass |
| c-E1.2 | a `√3` triple that is **not** forced — three pairwise-`√3` points that are not one of his (e.g. `(31,164,188)` in `v221e1006`'s own indexing) | `v221e1006 ∪ C` colourable → the row refuses to start |
| c-E1.3 | the pair endpoints left **deletable** | the reduction deletes one and returns a nonsense `\|M\|`; the guard must reject the stage at construction, not at the report |
| c-E1.4 | `Companion.graph` on the type-M path | **identical** `stage_fingerprint`, minima, `Y` and bounds on the regenerated `S166` and `L451` records (control C1) — the refactor's negative control |
| c-E1.5 | the non-mono-set companion's three new vertices marked **deletable** | rejected at construction (a companion's vertices are never deletable, by definition) |

**Cost** engineering, half a day to a day; compute is five stage builds and about eight refusal asks,
under a minute.
**If c-E1.4 does not hold, phase E stops** and the refactor is redone: a moved fingerprint invalidates
every comparison M63 has made.

### E2 — The `8/3` mono-pair reduction (HELD OUT)

**Inputs** `W = v375e1862` (375 vertices), rung 1, pin on (present 3/3).
**Companion** the edge `(16,0,0,0)–(−16,0,0,0)`, i.e. `(±4/3, 0)` at distance `8/3`. **Constant by
construction** (§1.2), so `|{M}|` and `A` are comparable with no loop-state reconstruction.
**Atoms** 373 (375 less the two fixed endpoints). **Gap** `375 − 367 = 8`.
**Registered targets** `|M| = 367`; `|{M}| = 27`; `A = v375e1862` literally (`M367 ⊆ A375` holds literally
— measured, zero vertices outside, no group element needed); edges `1822–1822`; Table 5's per-orbit ranges.
**Cost** (a) decision ≈ 373 phase-1 asks at ~0.1 CPU s plus a small hitting set — **5–10 min**; (b) the
complete level at 27 minima and gap 8 — **15–40 min**. Single core.
**Prediction** P-E1, P-E2, P-E3 (§3).
**Disagreement** a wrong `|M|` here is the strongest negative available in the phase: the companion is
unambiguous, the containment is literal, and the designated pair is attested twice. It would mean the
companion abstraction is wrong, not that a loop state was misread.

### E3 — The frozen loop on the `8/3` mono-pair, starting from his minimum (HELD OUT) — **and it discharges clause 2(c), not clause 2(b)**

*This row is the only place in his published data where his own success clause 2(c) has an attested target —
the clause phase D could not meet. **It does not discharge §S.1 clause 3**, and §S.4 says it does. That is
the substantive scope finding of this plan's advisory pass (Poros, card 18) and it is put to the product
owner as §6 decision 12, not settled here.*

**Why the row cannot test what §S.1 #3 asks.** The requirement reads: *"at least one held-out run must start
**below** his accumulator and **reach his `|M|`** with the frozen loop."* But `v367e1822` **is his `M`** —
§3 records the mono-pair row as `A375 → M367`. A stage whose vertex set is exactly a minimum has no
deletable subset that still refuses, so `w*` returns at iteration zero and `|M| = 367` is on the record
before the rule proposes anything. *"Start below his accumulator"* holds (367 < 375); *"reach his `|M|`"*
holds **vacuously**. And since 367 is the true minimum over `A375`, the loop's reachable verdicts on this
row are `grew`, `stalled` and `budget-spent` — **`improved` is unreachable by construction.**

**A bug this exposes, verified in the code.** `parts_rule.run_loop` hard-codes its verdict text
(`parts_rule.py:419`): `"MET -- the loop reached |M| <= 374 from our 375-level accumulator"`. On this row
that sentence is **false text emitted under a green `require_frozen`**. It must become a field derived from
the run's own registration (§1.7), not a literal.

**One correction back to the advisor.** Card 18's parenthetical says this row *"is not at rung 1"*, citing
the 7/7 score of his pairs heuristic. That score reads the *second* number of his symmetry column. The
column's own meaning is fixed in `data/m62/parts-table1.json`: *"'1 (2)' means the SET has output symmetry
1 and the fewest-edge member has stabiliser 2; it is not a second search parameter."* So `sym = 1 (4)`
gives this row **output symmetry 1**, and the row runs at **rung 1**. The mathematics of card 18 is
unaffected — a minimum has no deletable atom at any rung.

**Inputs** start from `v367e1822`, his published 367-vertex minimum — **367 vertices, 8 fewer than his
accumulator `A375`**. Companion: the `8/3` edge. Rung 1 (the frozen loop's rung). Frozen configuration
`data/m62/m63-freeze.json` at commit `6158162`, untouched.

**One at-risk quantity, not three — and §S.4 oversells this row** (Poros, card 9, adopted). §S.4 names
*"three attested targets: `|M| = 367`, 27 minima, `A = v375e1862`"*. But `A = ⋃{M}` is the union of the
level, so once the 27 are right the 375 follows: it is a strong check **on** the level, not a second
attestation. And **`|M| = 367` is free**: the row starts from his published *minimum*, whose vertex set has
no deletable subset that still refuses, so `w*` returns at iteration zero before the rule proposes
anything. What is genuinely at risk on this row is exactly two things: **the level at weight 366 has 27
members up to the named group and their union is his 375**, and **what the frozen loop does next**. It is
still precisely the right row — it is the only one whose companion is an edge, hence constant, hence one of
the only rows where `|{M}|` and `A` are comparable with no moving companion to reconstruct.

**The shape of the run.**
1. Reduce `v367e1822` against the edge. Expect `|M| = 367`, exactly one minimum, `A = 367`. *(This is the
   idempotence control of E9.4 — his published minimum must reduce to itself — and it is a control, not a
   held-out result, for the reason just given.)*
2. The loop then has nothing but the base to expand into. The frozen rule ranks candidates, adds vertices,
   and re-reduces, up to `max_iterations = 6` with the escalation schedule `n_new_max: 24 → 12 → 40` and
   `many_then_trim` at the last rung.

**What his own answer says the loop must find, computed during planning and registered before the run.**
`A375 ∖ M367` is exactly **8 vertices**:

```
(±8, 0, ±6, ±2)   — all eight sign combinations, i.e. x = ±2/3, y = (±6√3 ± 2√11)/12
```

and every one of them:
- lies in the **single base orbit `(8,0,6,2)`**, which has **24 members, of which 0 are in `M367`** — so
  from `M367` this orbit is **empty, not partially filled**, and it enters the menu as a **reserve**
  candidate adding all 24 vertices, not as a fill adding 8;
- has **unit-degree exactly 5 into `M367`**, comfortably over his admission threshold of 4.

So: **the rule's menu at `A = M367` contains the right orbit, at 24 new vertices — exactly the frozen
`n_new_max` — and can never propose the 8-vertex sub-orbit his accumulator actually holds.** If the rule
picks that orbit, the reduction of `M367 ∪ orbit(8,0,6,2)` (391 vertices) must delete 16 of the 24 back
out to land at 367, and the level's union is `A375` **if and only if** the 27 minima use exactly his 8.

**What it buys** clause 3 (generalization from below an accumulator); clause 2(c) with an attested target
(`{M}` grows 1 → 27 at fixed `|M| = 367` and fixed rung, in an iteration that added vertices); and the
first test of the rule on a problem whose companion is not a graph.
**The free control arm** (E-pre.2): if the look-ahead proxy is flat on this menu, run E3 a second time
with `--rule his_degree` and record whether the outcome is identical. Cost: one extra loop run. A null
scored against *both* arms is a derivation about the menu; a null scored against one arm alone is a
sentence about a rule that may never have been in the room.

**Cost** (a) each iteration's decision at target on a ≤ 391-vertex stage ≈ **3–8 min**, three candidates
evaluated per iteration, up to six iterations → **1–2.5 h**; (b) the final level only, if the loop lands at
367 with growth → **20–60 min**; the control arm, if taken, doubles (a). Single core, checkpointed per
iteration, resumable.
**Prediction** P-E4 … P-E7 (§3).
**Disagreement, and what each kind would mean:**
- *the rule never proposes `(8,0,6,2)`* → the ranking is wrong on a problem where the right move is in the
  menu and admissible — the sharpest possible negative about the **ranking**;
- *it proposes it and `{M}` does not grow* → the reduction is wrong on a stage his answer says contains 27
  minima;
- *`stalled` at six iterations* → the frozen budget was too small; that is a fact about the **freeze**, is
  reported as `stalled` and not as a failure of the method, and the freeze is **not** changed to fix it.

### E3b — The clause-2(b) row: a start whose minimum is strictly above his (HELD OUT; **conditional on §6 decision 12**)

*What §S.1 #3 actually asks for: a held-out start below his accumulator from which the loop must **do work**
to reach his `|M|`.*

**The construction, and it is cheap and needs no new mathematics.** Take his `A375`, delete a set `S` that
**meets every one of the 27 minima**, and keep `W = A375 ∖ S` only if it still refuses. Then `W` contains
no 367-vertex minimum, so `min(W) > 367`, and the loop must **expand** to get back to a 367-vertex object —
which is exactly the work the requirement wanted to see, against a target that is still his published
number.

**Why not the two cheaper-looking alternatives** — both were weighed and both fail:
- *delete one orbit that lies in some but not all of the 27 minima* (card 18's suggested construction):
  `W` then still contains the other minima, so `min(W) = 367` and the row is vacuous again. The set must
  hit **all** 27.
- *raise the rung until the minimum rises* (the overcompression gap, as on the S side where the rung-2
  minimum is 138 against 136): the loop would then reach 367 **by relaxing the rung**, and §S.1 clause 2(c)
  states in terms that a rung relaxation alone does not count.

**Dependency** `S` is computed from **our own** level at E2, not read from his paper — so E3b runs after
E2(b). Finding `S`: delete atoms greedily, re-asking refusal, until every stored minimum is hit; a few dozen
asks, minutes.
**Registered target** the loop reaches `|M| = 367` from a start whose minimum is `367 + k`, `k ≥ 1`.
**Cost** as E3: **1–2.5 h**, optimum per iteration.
**If the product owner declines this row**, §S.1 clause 3 is reported **NOT MET** in writing, with E3's
vacuity named — *"reported as not run" is not an ending*, and it applies to the clause as much as to the
row.

### E4 — L `M6B` 374 at the rung-2 subgroup (HELD OUT)

**Inputs** `W = v406e2076` (406 vertices), reduce L, the rung-2 subgroup (≈ 203 atoms). Gap 32.
**Companion — must be identified first.** Candidates: the M6B S minimum `v141e594` and the M6B S
accumulator `v172e804`, by the 24-frame refusal test (§1.2), ~75 s each. **Until it is identified this row
reports `|M|` alone** and `|{M}|`/`A` read `not-compared`.
**Registered targets** `|M| = 374`; then, with the companion named, `|{M}| = 78` and `A = v406e2076`;
edges `1864–1880`.
**Why it matters under the correction** the `M6B` subtype is a **different auxiliary connection orbit**
from `M6A`. This is the closest thing in his published data to running the pipeline at a different
rotation, which is what phase G does for a living.
**A prior this row carries, declared so a hit is not read as blind** (Poros, card 14(i)): phase D already
reduced *a* 374-at-rung-2 problem — `A412` against `S136` — and got **78**, with `A = 402`, and the two
78-member levels are **incomparable**, each holding a member the other lacks (§S.3 G-5, §R3.13). So the
prediction `|{M}| = 78` here is **transferred from a sibling subtype, not predicted cold**, and the record
says so.
**Cost** (a) **10–20 min**; (b) the level at 78 minima — **30–90 min**.
**Prediction** P-E8, P-E9.

### E5 — L `M6C` 374 (HELD OUT)

**Inputs** `W = v400e2034` (400 vertices), reduce L, rung 2 per his symmetry column. Gap 26.
**Companion** to be identified; candidates are the M6C S minimum `v150e639` and accumulator `v167e772`.
**Registered targets** `|M| = 374`; `|{M}| = 76`; `A = v400e2034`; edges `1872–1872` (both endpoints equal,
which makes the edge comparison a single exact number rather than a range — the sharpest edge test in the
set).
**Cost** (a) **10–20 min**; (b) **30–90 min**.
**Prediction** P-E10.

### E6 — S `M6B` and S `M6C` (HELD OUT, and the weakest rows on the board)

**E6a** `W = v172e804`, 171 atoms, gap 31, targets `|M| = 141`, `|{M}| = 4`, edges `594–595`.
**E6b** `W = v167e772`, 166 atoms, gap 17, targets `|M| = 150`, `|{M}| = 28`, edges `639–651`.
**Companion** an L graph of the same subtype, identified by the frame test; the companion also supplies the
pin, which these objects lack (§1.4).
**Honest ranking, in one sentence** (Poros, card 15, adopted — §S.4 says both *"no S number is held out
any longer"* and lists these two as held-out rows, and both cannot be read plainly): **the S code path was
calibrated on `S-M6A` and the counting convention was fitted there, so these two rows test generalization
across SUBTYPE and not across APPARATUS.** They are **held out in the strict sense** — their numbers were
never read into any choice — while buying less than the L or mono-pair rows. They are kept because they are the cheapest rows on the board and because they
carry the subtype argument of E4/E5 on the other half. **§6 decision 5 records the alternative (cutting
them) and why it lost.**
**Cost** (a) **3–8 min each**; (b) **10–30 min each**.
**Prediction** P-E11, P-E12.

### E7 — The `√3` non-mono-triple (HELD OUT)

**Inputs** `W = v238e1131` (238 vertices), rung 1, 235 atoms, gap 17.
**Companion** a 3-clique joined to `(12,0,0,0)`, `(−6,0,6,0)`, `(−6,0,−6,0)` — **three new vertices**, the
only row where the companion adds vertices. Constant by construction, so `|{M}|` and `A` are comparable.
**Registered targets** `|M| = 221`; `|{M}| = 120`; `A = v238e1131`; edges `1006–1013`; Table 6's per-orbit
column, which phase C already transcribed row-by-row against `v238e1131` with **zero differing rows** (the
`c2.9` positive control) — so this row's `A` column is the one place a checker is known to be able to agree
rather than merely differ.
**What it buys** the third companion kind; and Parts's §5.9 **five-vertex multi-vertex colour assignment**
(the triple plus the symmetry break pinned together for a reported ~10×), which is the only §5.9 lever
phase E is positioned to measure. Measuring it is **optional** and, if measured, is reported against its
own recorded population (G21).
**Ranking** last of the held-out rows. Its bearing on new bases and rotations is the weakest — a new base
has no 3-clique-companion problem; it has a no-companion or edge-companion problem.
**Cost** (a) **5–10 min**; (b) the level at 120 minima — **40–120 min**.
**Prediction** P-E13, P-E14.

### E8 — The mechanism control (NOT a held-out row)

**Inputs** the S side started from a rung-2-symmetric **138-vertex** minimum (M64 §R10; all three S
involutions close at 138 with 2 minima each, confirmed by phase C), against the M6A L companion.
**Why it is a control and not a row** the S reduction was spent as the calibration (§R1), so no S M6A
number is held out. What it tests is a **mechanism**: the closure gap forbids a 138-vertex rung-2 minimum
from containing any 136-vertex minimum, so the loop **must expand** to reach 136. A loop that reaches 136
without expanding is broken in a way no number would reveal.
**Registered target** the loop expands at least once, then reaches `|M| = 136`.
**Cost** (a) **3–8 min per iteration**; up to six iterations → **under an hour**.
**Prediction** P-E15.

### E9 — THE CONTROL-CHARACTERISATION EXPERIMENT

*The deliverable phase G cannot be run without. `[SalariKnupp2000]`'s blind-test protocol is the published
shape of this experiment in another field (§PA.2), and its output is a taxonomy of exposed and unexposed
fault classes. Ours should read the same way.*

#### E9.1 — The guard, exactly as it stands

`tools/parts_loop.py:check_invariants` runs four checks per candidate, cheapest first:

1. the companion's **fingerprint** is unchanged across the sweep;
2. the **restriction identity** — the expanded stage's induced edges, restricted to the unexpanded stage's
   vertices, equal the unexpanded stage's edges exactly;
3. the **vertex count** is exactly `|A| + n_new`;
4. the **anchor**, two asks: a known minimum of the unexpanded stage still refuses here
   (`unsat`), and that selection minus one atom is colourable (`sat`). Verdict
   `contains-a-known-minimum`, else `known-minimum-absent` → `restriction-identity-broken`.

**With `anchor=None` the fourth check is skipped and the record reads `restriction-identity-holds` — a
pass.** `tools/parts_rule.py:387` already passes `anchor_tuples=None`.

#### E9.2 — The planted faults

**All faults are planted in a SNAPSHOT COPY under `build/m63e/`, never in `tools/`.** Other agents import
`tools/` live, and Python 3.14's `forkserver` re-imports a module in any worker spawned after an edit — a
transient edit to `tools/` can corrupt a running job (`CLAUDE.md` § Toolchain; the same hazard is why
`tools/parts_loop.py` line 810 is still unfixed tonight).

**A plant that breaks the restriction identity proves check 2, not the anchor** (Poros, card 7, adopted
and it reorders the table). To exercise the **anchor specifically**, the plant must be invisible to checks
1–3 — that is, it must live in the code **both sides of check 2 share**, since `check_invariants` compares
the stage against a `reference` that `build_reference` builds from the same base, the same unit-edge
predicate and the same cross law.

| # | planted fault, one line each | realistic? | the guard's expected answer |
|---|---|---|---|
| **f0** | **move one lattice point off the unit circle in the BASE** | yes — a coordinate is one character | **the primary plant.** The reference rebuilds from the same base, so checks 1–3 agree with each other and pass; the anchor's known minimum stops refusing. **This is the plant that demonstrates the anchor is the only external check** |
| f1 | **wrong frame**: apply a non-identity group element to the companion only | yes — §1(v): his objects are each stored in their own frame, and `v136e564 ⊄ v166e774` as stored | **anchor fires — frame-dependently, and that is itself a finding.** Measured precedent: `v375e1916` refuses with `S141` in 12 of 24 frames and with `S136` in **none**, so a *wrong but compatible* companion can pass. **Registered prediction: this plant does NOT fire on every anchor.** If it does not, residue (d) is *demonstrated* rather than argued, which is worth more than a plant that fires |
| f2 | **wrong cross-edge law**: `collinear(3/4)` in place of `collinear(7/8)` | yes — `CrossLaw` became a parameter in phase C | anchor fires |
| f3 | **companion swapped mid-sweep** | yes — it is why the fingerprint check exists | `companion-drifted` fires |
| f4 | **one spurious edge among the NEW vertices only** | yes — "take edges from the assembled stage, never from a relation computed on the base" produced three faults in three agents in one afternoon | **nothing fires** |
| f5 | **the shared centre made deletable** | yes — it is a one-character change in a mask | vertex count or the anchor's stray-vertex path fires |
| f6 | **`anchor_tuples=None`** (not a fault — the shipped default in the frozen loop) | it is live in committed code | **nothing fires; the record reads as a pass** |
| f7 | **target off by one** (`target = incumbent` instead of `incumbent − 1`) | yes — the target knob was added in phase D | **nothing fires**; the run returns `inert` for a candidate that would have improved |

Each fault is run on **one** known row (E2's stage is the cheapest: 373 atoms, a literal containment, a
two-ask anchor), and the outcome recorded as **killed** or **survived**.

#### E9.3 — The residue, written as a list, each with the cheapest thing that would catch it

*This is the deliverable, not the table above. It is what we carry onto ground where the anchor is gone.*

| # | residue — what the guard cannot see even when green | why, mechanically | cheapest catcher |
|---|---|---|---|
| R1 | **extra material in `W`** | the anchor is **monotone**: if a known minimum refuses inside `W` it refuses inside every `W' ⊇ W`. `check_invariants`'s own docstring states the blindness as a feature — *"its answer is invariant under every expansion"*. Only the `minus_one` leg can fall, and it tests exactly **one** atom (the last in the anchor's order) | the vertex-count check catches *accidental* extra; **wrong** extra is caught only by exact geometry on every edge of the assembled stage, one exact pass, `O(V²)` |
| R2 | **anything about the material an expansion ADDS** | the restriction identity compares only edges among the **unexpanded** vertices; the anchor lies entirely in the unexpanded part | promote the restriction identity to a **construction identity**: recompute the whole edge set from the stated law and compare, at the cost of one more stage build |
| R3 | **the counting layer** — which group `up_to` used, and whether the level is complete | no check reads either; `|{M}|` is a report, and a capped level is a sample | a per-row **Burnside cross-check** (`raw / up_to` against the orbit-count formula under the declared group — already done once at 282, never asserted), plus making `LevelSet.require_complete` a **run** guard and not only a loop guard |
| R4 | **the question asked** — target, rung, side | they are **echoed** into the record, never verified against an intention | re-reduce the returned `M` and require it returns **itself** with zero droppable (idempotence). A too-lax target returns a non-minimal object, which idempotence catches |
| R5 | **a consistently wrong problem** | every oracle-free relation — equivariance, monotonicity, idempotence — holds when both runs are wrong the same way | **nothing internal.** Only an external anchor or an independent re-derivation of the geometry (E9.5) |
| R6 | **the anchor being absent at all** | `anchor=None` is a silent skip | a one-line change: a named verdict `anchor-not-supplied`, carried in the record and printed. **A fail-open becomes a fail-loud** |
| R7 | **a fault in the code BOTH SIDES of check 2 share** | `check_invariants` compares the stage against a `reference` that `build_reference` builds from the same base, the same unit-edge predicate and the same cross law. A bug in any of the three corrupts both sides identically and the restriction identity still holds | the anchor (plant f0 demonstrates it), and on new ground E9.5's lifted geometry check |

**The residue in one sentence, which is what travels to phase G** (Poros's formulation, adopted because it
is better than mine): **checks 1–3 are internal consistency — the pipeline compared against itself. Check 4
is the only check that compares against a truth from OUTSIDE the pipeline, namely a vertex list Parts
published.** So on ground truth the apparatus has exactly one external check, and on a new base it has none;
what survives is internal consistency, which by construction cannot detect a fault in shared code.

**Poros's opening hunch, scored** (his card 2): he guessed the anchor is *"nearly blind to the stage being
too big"* — **right, and provably so, not nearly** (R1). He guessed it is *"completely blind to the
counting layer"* — **right** (R3). He guessed it is blind to *"the companion's identity"* — **wrong for
the anchor**, which fires on a wrong companion (f1's measured precedent), and right only for the
fingerprint check taken alone.

#### E9.4 — The oracle-free replacements, and their honest limit

From `[ChenEtAl1998]`'s metamorphic relations (§PA.2), three that need no known minimum and run on any base:

- **equivariance** — reduce `g(W)` against `g(C)` for a group element `g`; `|M|` must be equal and the
  minima must be the `g`-image. One extra reduction per row.
- **monotonicity** — `W' ⊇ W ⟹ |M'| ≤ |M|`. One extra decision ask.
- **idempotence** — re-reducing the returned object returns itself, one minimum, zero droppable. This is
  phase C's `C4.1` control generalised from *a published minimum* to *our own output*, and it is the only
  anchor-shaped control that exists on new ground.

**Their limit, stated before they are believed:** none of the three can see a consistently wrong problem
(R5, R7). The metamorphic relations cover the reduction's **bookkeeping**; they do not cover the graph.

#### E9.5 — Calibrate the external check that survives, because after E there is nothing to calibrate it against

*The single deliverable of phase E that phase G will actually consume. Poros's card 6, constructive half,
confirmed at an address and then refined by its author; verified here against the module's own docstring.*

`tools/parts_edge_verify.py` **leg 4**, verbatim: *"exact geometry, re-derived from the coordinates — every
kept edge re-checked as a unit pair in exact `K = ℚ(√3,√11)` arithmetic. The cross edges are re-derived
from the **STATED law** (`typem.CrossLaw`'s docstring derivation) rather than by calling the committed edge
builder, **which would be circular**."* That is an external check: it compares the graph against the
**mathematics**, not against the pipeline, and its author already named the circularity hazard by hand.

**But it is welded to one object.** Legs 1–3 (an unpinned refutation, a separate process and a different
CaDiCaL, an LRAT proof replayed by our own checker) are about a refutation of the 509 and do not generalise
to a stage. **Leg 4 is the reusable piece.** So phase E's move is not *"run `parts_edge_verify` on the
rows"*; it is:

1. **lift leg 4** into a stage-level geometry check that any `Stage` can be handed;
2. **run it on a row where the anchor ALSO fires**, and confirm the two agree;
3. **plant the geometric fault** (f0 — one lattice point off the unit circle) and confirm the lifted check
   catches what the anchor catches.

**If that calibration is not done in phase E it cannot be done later, because later there is no anchor to
agree with.** Copy its three controls verbatim, because they are the right ones: a known positive the
instrument must agree with; a negative proving the path can return `SAT` at all; and an independent
single-vertex deletion.

**The recommendation to phase G, in one line:** the anchor's successor is the **non-vacuity ask plus this
lifted geometry check** (phase F §2.6 names both halves); the metamorphic relations cover the bookkeeping
the geometry cannot see; and **nothing covers R5**.

**Cost** E9.1–E9.4 is engineering plus about **twelve asks** on E2's stage — **under fifteen minutes of
compute**. E9.5 is half a day of engineering (a lift, not a new instrument) plus two stage builds and about
six asks. Together they are the cheapest items in the phase and the most load-bearing.

### E10 — The written human judgement

**One paragraph per row**, each naming: the row, the companion (or `not-compared` with its reason), the
quantity compared, the verdict, and what a disagreement would mean. Then **one paragraph of judgement over
the whole set, written by a person.**

**Banned, and the record schema must make it impossible:**
- any pass rate, fraction, score, or "k of n rows agreed";
- any field in the artifact that can be summed across rows;
- the words "broadly reproduces";
- folding an `undecided` or a wall hit into a negative (the freeze's third ban).

Six rows agreeing and one disagreeing is **seven facts**.

### E11 — Not run, and why

The remaining six Table 1 rows (`mono-8/√3`, `nmp-7/3`, `nmp-5/3`, `nmp-√11/√3`, `nmt-√7`, `nmt-√5`,
`nmt-√5/3`, `nmt-1/√3`) are **reserve**. `nmp-3` and `nmp-1/3` are **excluded** — off the base by a
translation (§1.3). If the product owner wants a second edge-companion instance, `mono-8/√3`
(`v433e2186 → v421e2094`, 7 minima) is the cheapest replication and its designated pair is already
resolved.

---

## §3 — Registered predictions

*Committed in one commit **after** the freeze `6158162` and **before** the first held-out run. Each is a
statement that can be wrong, with a stated confidence. A prediction registered after an outcome is
worthless and this milestone has held that line throughout.*

**Use the format that already exists — do not invent one** (Poros, card 19's companion note).
`data/m62/m63-sweep-protocol.json` is a hand-written pre-registration frozen in a commit before phase D read
its first outcome, and its fields are exactly what E needs per row: `outcome_variables` (primary, secondary,
and `banned_as_an_outcome` **with the reason written out**), `rankings_to_be_scored` each with its
definition, and a `scoring_rule`. Copy that shape, per row, alongside the registration of §1.7. **It is
itself frozen and must not be edited** — retro-editing a freeze destroys its only property while leaving it
looking intact.

**And do not let E's one bit be read as scoring more than it scores** (Poros, card 19). That protocol names
**seven** rankings; `parts_rule.RULES` implements **three** (`ours`, `his_degree`, `random`). Never
implemented: `his_indicators` — his §5.10's three numerical indicators, which the protocol says are to be
*"reported SEPARATELY and never combined, because he states no combining rule and an invented one would be
ours wearing his name"* — plus `his_priority`, `n_new_asc`, `n_new_desc`. So **if E-pre.2 reads flat, the
single bit E3 buys scores his decreasing-admission-degree order and nothing else**, while the one published
device that might have had power has still never been run. E's write-up must not imply §S.4's fork is
resolved. *The cheap thing that would resolve it:* `his_indicators` is a ranking with **no solver in it** —
free-vertex counts and small-degree hyperedge counts are already harvested by `reduce_stage`, and the
independence number of the degree-2 hyperedge graph is a small graph computation. It is **out of scope for
phase E as planned** and is named here as the cheapest available upgrade, for the product owner's call.

| # | prediction | confidence | decided by |
|---|---|---|---|
| P-E1 | E2 returns `\|M\| = 367` | 0.85 | E2(a) |
| P-E2 | E2 returns `\|{M}\| = 27` under the named convention, and `A` equal to `v375e1862` literally | 0.65 | E2(b) |
| P-E3 | E2's edge count is exactly 1822 at both endpoints | 0.8 | E2(b) |
| P-E4 | E3's step 1 returns `\|M\| = 367` with exactly **one** minimum and `A = 367` (his published minimum is vertex-critical) | 0.9 | E3 |
| P-E5 | the frozen rule's menu at `A = M367` contains orbit `(8,0,6,2)` as a **reserve** candidate of 24 new vertices at internal degree 5, and contains **no** 8-vertex sub-fill of it | 0.95 | solver-free, from the menu census; **registered before the run and decidable without one** |
| P-E6 | the rule **proposes** `(8,0,6,2)` within its six iterations | 0.45 | E3 |
| P-E7 | if it proposes it, `{M}` grows at fixed `\|M\| = 367` and fixed rung 1 — i.e. **clause 2(c) is met on this row** | 0.6 conditional on P-E6 | E3 |
| P-E8 | E4 returns `\|M\| = 374` | 0.8 | E4(a) |
| P-E9 | E4's companion is the M6B S **accumulator** `v172e804`, not the minimum `v141e594` — by analogy with his state 1, where the partner was the accumulator | 0.5 | the 24-frame test, ~75 s each |
| P-E10 | E5 returns `\|M\| = 374` and edges exactly 1872 | 0.75 | E5 |
| P-E11 | E6a returns `\|M\| = 141`; E6b returns `\|M\| = 150` | 0.85 | E6 |
| P-E12 | at least one of E6a/E6b reports `\|{M}\|` **not-compared** because no candidate companion qualifies in any of the 24 frames | 0.35 | E6 |
| P-E13 | E7 returns `\|M\| = 221` | 0.8 | E7(a) |
| P-E14 | E7's `A` column agrees with Table 6 row by row, zero differing rows (phase C's `c2.9` already showed the checker can agree here) | 0.7 | E7(b) |
| P-E15 | E8's loop expands before reaching 136, and does reach 136 | 0.6 | E8 |
| P-E16 | **faults f4, f6 and f7 survive every control** (E9.2) | 0.9 | E9 |
| P-E17 | plant **f0** (a base point off the unit circle) passes checks 1–3 and is killed by the **anchor alone** | 0.85 | E9 |
| P-E19 | plant **f1** (a different published companion half of the same size) does **NOT** fire on every anchor — residue (d) demonstrated rather than argued | 0.55 | E9 |
| P-E20 | **E-pre.1:** on all six reduction rows `Aut(A)` and the whole base group coincide, so **no row separates the live ambiguity** and every `|{M}|` agreement is against the companion-fixed rival only | 0.6 | E-pre.1, solver-free |
| P-E21 | **E-pre.2:** `look_ahead.freed` reads **0 on every candidate** of the mono-pair menu, so `rule="ours"` and `rule="his_degree"` emit the identical ordering on E3 | 0.75 | E-pre.2, minutes |
| P-E22 | **E9.5:** the lifted stage-level geometry check and the anchor **agree** on the row where both run, and the lifted check kills plant f0 | 0.85 | E9.5 |
| P-E23 | at least one row's registered `max_minima` cap binds | 0.3 | E2, E4–E7 |
| P-E18 | across the six held-out reduction rows, **at least one `\|{M}\|` disagrees while its `\|M\|` agrees** | 0.5 | E2, E4–E7 |
| P-E18a–c | **and if one does, its attribution is one of exactly three, each registered below with its discriminator** (Poros, card 21 — adopted; it closes the only post-hoc route left) | — | E2, E4–E7 |

**P-E18's three attributions, registered in advance with what distinguishes each.** The first draft wrote
P-E18 as *"the convention, not the reduction"*, and **that attribution is not available if P-E20 holds**: if
`Aut(A)` and the whole base group coincide on every row, the live ambiguity cannot produce any discrepancy
at all, and the only convention ambiguity left — `Aut(A)` against companion-fixed — is wrong by **5.5× to
11.6×** on the rows measured, not by a near miss. A disagreement would then have to be attributed to
something never named in advance, which is the inductive escape clause in its textbook form (G30 failure
mode 1). **And the cause this milestone has itself measured twice was missing from the list: his printed
numbers.** §S.3 A-7 — *"each `A` file sums EXACTLY to its own caption … both discrepancies live in his
printed per-row columns and not in his data"*; §S.3 G-2 — *"his printed 375 column is strictly narrower
than BOTH the M6A and the M6B level in the same two cells, so the column is a property of neither run."*

| # | attribution | what distinguishes it, decidable after the fact |
|---|---|---|
| P-E18a | **the counting convention** | the disagreement is a clean multiple in the 5.5–11.6× band, **and** one of the audit's other group keys holds his number |
| P-E18b | **an incomplete level** | `Count.method` is not `exhaustive-level`, or `max_minima` bound |
| P-E18c | **his printed number** | our level is closed under the declared group, **all three** of the audit's group keys miss his value, and `A = ⋃{M}` still equals his published accumulator file literally — the exact pattern A-7 found twice |

P-E18c has precedent in this milestone and is the one that will look least attractive to reach for
afterwards, which is exactly why it is written down first.

**And a bound cap makes a row `not-compared`, never a `≥`** (Poros, card 23, adopted). A floor is not a
comparison: *"≥ 27"* against his 27 renders as satisfied and is not agreement. `Count` already refuses to
hide a truncation — `truncated-at-budget` must name its population — so the fix is in the reporting rule
rather than in the type: **a row whose cap binds reports `\|{M}\|` as `not-compared`, with "the cap bound at
N" as the reason**, exactly the treatment an unidentified companion already gets.

**A ban restated from the freeze:** no ranking is scored against an outcome it also predicts. P-E5 is a
statement about the **menu**, not about the ranking, and it may not be used to score the ranking.

---

## §4 — Costed order, and what may interleave

**Machine state at planning time** (the machine, 32 cores): **three** python jobs at ~100% CPU each —
the rung-1 374 level enumeration (E0's input), the `hismove` calibration, and a hitting-set replay
experiment. All are single-core, ~600 MB, checkpointed and deliberate. **Nothing in this plan kills,
signals, inspects or restarts any of them.**

**The interleaving rule.** Every phase E run is **single core, a few hundred megabytes, and light**; the
house "one heavy job at a time" rule is about the 100 GB-class Lean builds and the multi-hour joint
reductions, not these. **At most two phase E runs concurrently**, and none while a Lean build is running.
A run whose forecast exceeds 15 minutes is announced before launch (`parts_run.py --dry-run` prints the
forecast).

| order | item | cost, and which cost | may interleave? | blocks |
|---|---|---|---|---|
| 0 | **E-pre.1** the per-row counting groups, by `parts_audit.py` on his own files | **seconds per row**, no solver, **neither** | yes | every `|{M}|` prediction |
| 1 | **E1** the companion constructors + c-E1.1…c-E1.5, and the `Comparison` companion field | engineering; < 1 min compute | yes — it is mostly typing | **everything**; E2–E8 and E-pre.2 cannot start |
| 2 | **E-pre.2** the look-ahead proxy over the mono-pair menu | tens of asks, **minutes**, **neither** | yes | E3's interpretation and its control arm |
| 3 | **E9.1–E9.4** control characterisation on E2's stage | ~12 asks, **< 15 min** | yes | the residue statement, which is what travels to phase G |
| 3b | **E9.5** lift leg 4 to stage level and calibrate it against the anchor — **the phase's headline deliverable** (§A ruling 3) | half a day engineering, ~6 asks | yes | **phase G** — and it can never be done after E. If the schedule slips, this is the item that does **not** slip |
| 4 | **register §3 and the per-row registrations** in one commit | zero | — | **every held-out run** |
| 5 | **E2(a)** mono-pair decision | 5–10 min, **optimum** | yes | E3 |
| 6 | **E3** the required loop run (+ the `his_degree` control arm if E-pre.2 reads flat) | 1–2.5 h, **optimum per iteration**; doubled with the arm | one at a time; it is the phase | clause 3 |
| 7 | **E4(a), E5(a), E6a(a), E6b(a), E7(a)** — companion identification then decisions | ~75 s per companion candidate + 3–20 min per row, **optimum** | two at a time | their own (b) |
| 8 | **E2(b), E4(b), E5(b), E6(b), E7(b)** — the complete levels | 15 min – 2 h each, **level set** | two at a time | gate ranks 2, 3 |
| 9 | **E8** the mechanism control | < 1 h, **optimum** | yes | — |
| 10 | **E0** collect the in-flight rung-1 374 level | zero new compute | — | three audit rows |
| 11 | **E10** the written judgement | a person, an hour | — | the phase's close |

**Total compute: 6–11 CPU hours, all single core, all light, all resumable.** Wall clock with two
concurrent: **4–6 hours**, plus the engineering in items 1 and 3b.

**A disagreement with the advisor, recorded with its numbers.** Poros (card 17) reads the phase as priced
about 5× low, on the ground that every row needs a complete level and tonight's level enumeration ran 79
minutes. I disagree, and the measurements are the reason: `S166` closed a complete level with **8** minima
in **587 s** and `L451` one with **282** minima in **605 s**, both about ten minutes. The 79-minute run is
an outlier at 411 atoms with **more than 19,000** minima. Phase E's rows carry **4, 27, 28, 76, 78 and 120**
minima at 166–373 atoms, so I forecast level stages of **10–40 minutes each**, not eighty. Where he is
plainly right, and it is adopted: **every cost row now says optimum or level**, and **`max_minima` is a
per-row pre-registered decision** (§1.6). The one row that could still blow up is E7 at 120 minima, and its
cap is registered in advance for exactly that reason.

**Every long run checkpoints outside `build/`.** `build/` is documented as disposable scratch and an agent
tidying up deleted a live job's only resume file there on 2026-09-11. Checkpoints go to
`data/m62/ckpt/m63e-<row>.ckpt.json`, and **each row's plan line names its resume command** beside the
checkpoint path — a checkpoint nobody knows how to resume from is a file, not a recovery.

---

## §5 — What phase E must NOT do

1. **Not tune anything.** The rule is frozen at commit `6158162`. **But `require_frozen` guards one row in
   seven** (§1.7), so the real instrument is the per-row registration of §6 decision 9, committed before
   each row runs, and `--require-frozen` is passed on every run that accepts it. **A held-out row that fails
   is a result.**
2. **Not run, quote or count `L-M6B-375` or `S-M6A-136`.** Both are spent (§1.1).
3. **Not start any loop from `A403`.** It is the frozen rule's `held_out_state` and its outcome map is
   in-sample from phase D.
4. **Not produce an aggregate verdict** (E10).
5. **Not edit `tools/` while jobs are running** — plant every fault in a snapshot under `build/m63e/`.
6. **Not raise `max_iterations`, `n_new_max` or the escalation schedule** to rescue E3. A stall is reported
   as `stalled`.
7. **Not attempt a record.** That is phase F. If a phase E row happens to return an object smaller than
   anything published, it is **recorded and handed to phase F**, and it is called a record only after the
   six-leg verification chain and a Lean kernel certificate.
8. **Not overwrite a stored record.** `parts_run.py` refuses; a regeneration is written as `<name>.v2.json`.

---

## §6 — Decisions, each in four parts

| # | the choice | the alternative weighed | why this one won | confidence, and the one fact that would change it |
|---|---|---|---|---|
| 1 | **E3 starts from `v367e1822`**, his published 367-vertex minimum | start from `A375` minus eight randomly chosen vertices, so the start is not one of his objects | his minimum is published, re-derivable by a reader, and its gap to his accumulator is exactly the 8 vertices his answer names — so the loop has an **attested** target for `{M}` growth (1 → 27) and for `A` (367 → 375). A random start has no attested target and scores nothing | **high** — changes if the reduction of `v367e1822` returns more than one minimum, which would mean the start is not the object his table describes |
| 2 | **Every row is split into a decision stage and a level stage**, priced and scheduled separately | always enumerate the complete level, as every M63 row has so far | measured tonight: 188 s to the optimum against 79 minutes to the level — a factor of 25 on that run, and `|M|` is the only hard gate while `|{M}|` and `A` are reported-never-gated | **high** — changes if a level turns out to be needed to decide `|M|`, which it is not (the decision asks at a target) |
| 3 | **Each L and S row identifies its companion by the 24-frame refusal test before any count is compared** | assume the subtype's published minimum is the companion | phase D measured that assuming was wrong at his state 1: the partner was the S accumulator, and assuming the minimum returned 82 minima against his 96 — a different problem reported as a defect | **high** — it is a measurement, not a preference |
| 4 | **`anchor=None` becomes a named verdict `anchor-not-supplied`** | leave the code and rely on this plan's prose to warn phase G | the repository's signature failure is a check that reports nothing when it cannot run; the frozen loop is **already** calling with `anchor_tuples=None`, so the fail-open is live, not hypothetical. One line, no behaviour change, and it is the single most useful artifact phase E hands phase G | **high** — changes only if the freeze is judged to pin this reporting, which it does not (the freeze pins `parts_rule.frozen_config`, not record fields) |
| 5 | **Keep the two S rows (E6a, E6b)** | cut them as near-duplicates of the spent `S-M6A` calibration | they are the cheapest rows on the board (3–8 min each for `|M|`) and they carry the **subtype = connection orbit** argument on the other half, which is the phase-G-facing reading of the whole held-out set. A held-out set that shrinks because a calibration passed is how a warranty gets thin | **medium** — if both agree on `|M|` within the first hour and neither companion is identifiable, their level stages (stage b) may be dropped and the rows reported `|M|`-only |
| 6 | **Keep E7 (the `√3` triple) and rank it last** | drop it; it is the least phase-G-relevant row | it is the only companion that adds vertices and the only test of his five-vertex pin, and phase C's `c2.9` already showed its `A` column is one a checker can *agree* with rather than merely differ from | **medium** — if E1's clique constructor turns out to need a second code path (a companion whose new vertices join a set rather than a half), the row's engineering cost doubles and it becomes a candidate to defer to phase G |
| 7 | **Every planted fault lives in a snapshot copy under `build/m63e/`** | plant in `tools/` and revert after each run | three jobs import `tools/` live and Python 3.14's `forkserver` re-imports a module in workers spawned after an edit; a transient edit can corrupt a running job, and one such hazard is *why* `tools/parts_loop.py`'s known-false line 810 is still unfixed tonight | **high** |
| 8 | **`|{M}|` is classified semi-held-out everywhere**, and every record says so | treat `|{M}|` as clean held-out evidence, as the acceptance list implies | the convention was fitted against his 8 on the spent `S-M6A` row and confirmed on two more — but only ever against the *companion-fixed* rival; `Aut(A)` against the full base group is unseparated on every row run (§1.1). A row whose `|{M}|` disagrees is evidence about the **convention**, and a plan that did not say so in advance would be free to attribute it either way afterwards | **high** — changes if the convention is ever derived rather than fitted |
| 9 | **A second registration, per row, committed before that row runs** — starting object, companion constructor and fingerprint, stage fingerprint and `fp_base`, rung, counting group **and the artifact its number is read from**, `wall_ask`, `max_minima`, predicted values — in the shape of `data/m62/m63-sweep-protocol.json` | rely on the freeze commit `6158162` alone, as §5 of the first draft of this plan did | checked in the code: `require_frozen` has **one** caller, behind a flag that is **default off**, and the frozen file pins no `wall_ask`, `max_minima`, `rung`, `cross_law` or `fp_base`. *"The configuration is frozen"* is true of one row in seven. Re-freezing would destroy the existing freeze's only property; a second, per-row registration adds one without touching it | **high** — it is a reading of the committed file, not a preference |
| 10 | **Lift `parts_edge_verify` leg 4 to a stage-level geometry check and calibrate it in phase E** (E9.5) | leave it for phase G, where it is actually needed | calibrating it **means** running it where the anchor also fires and confirming they agree. After phase E there is no anchor to agree with, so a check first used on new ground is a check nobody has ever seen succeed against a known answer. It is also the only **external** control that survives — phase F §2.6's two proposed replacements are both internal consistency | **high** — the one deliverable phase G will consume |
| 11 | **E3 takes a `--rule his_degree` control arm if the look-ahead proxy reads flat** | run E3 once under `ours` and report the outcome | `_rank_ours`'s own docstring says it *"degrades to his where it has no information"*, and audit row B-12 measured the proxy at **0 of 336** on every orbit tried. Without the arm, a null on E3 would be written up as *"our rule failed"* when the honest reading is *"our rule was never in the room"* | **high** — the arm costs one extra loop run and converts a null into a derivation |
| 12 | **APPROVED by the product owner, 2026-09-11 (§A ruling 1).** reclassify E3 as the clause-2(c) row it is, **and add E3b** (a start whose minimum is strictly above 367) as the clause-2(b) row | keep E3 as the clause-2(b) row and note the caveat in prose — it buys a day and leaves §S.1 clause 3 discharged by a reading that is met at iteration zero | the whole point of phase E under the corrected product is a **warranty**, and a warranty with a vacuous clause in it is worth less than one with an honestly unmet clause. E3b costs ~1–2.5 h and reuses E3's machinery entirely | **high on the mathematics** (`\|M\| = 367` at iteration zero, at any rung), **medium on the scope call** — if the product owner reads §S.1 #3 as satisfied by the whole Table 5 row rather than by its `\|M\|` clause, the requirement wanted something else and E3 alone discharges it |
| 13 | **`his_indicators` is OUT OF SCOPE for phase E — RULED, 2026-09-11 (§A ruling 2), and recorded here so it is not re-opened** | implement it inside phase E, so a flat proxy has a published baseline to lose to | the product owner's reason is stronger than the one this plan first gave (*"it is phase D's unfinished business"*): **phase E's entire value is that it runs a frozen configuration against problems nobody tuned on, and adding a ranking device inside it is exactly the contamination the freeze exists to prevent.** It goes to the expansion work, where ranking lives | **high**, now that it is ruled |

---

## §7 — What I could not settle, and what it would take

1. **Whether the L and S rows' companions are reconstructible at all.** The 24-frame refusal test may return
   no qualifying frame for any candidate, in which case E4/E5/E6 are `|M|`-only rows and three of the
   fifteen planned comparisons do not happen. **Cost to settle: ~75 s per candidate, after E1 lands.**
   It cannot be settled before E1 because the test needs the refactored stage.
2. **Tables 5 and 7's per-orbit columns are still NOT-COMPARED row by row** (audit row A-7, reassigned from
   phase D to phase E). They are the accumulators of E2 and of a reserve row, so the transcription is
   cheapest here — but it needs the PDF read against the file, which is an hour of careful human
   transcription, not a run. **Not scheduled above; flagged as a deliverable the product owner may cut.**
3. **Whether `max_iterations = 6` is enough for E3.** The freeze fixes it and this plan will not change it.
   If E3 stalls at six, the honest report is that the *frozen budget* was too small, and the question of
   whether a larger budget would have found the move is **open and unanswerable without breaking the
   freeze**. The cleanest resolution is a post-freeze, clearly-labelled continuation run reported
   separately and never as the held-out outcome.
4. **`tools/parts_loop.py` line 810 still emits a claim its own artifact no longer makes** (handoff §6
   item 4): the artifact `data/m62/m63-map-A412.json` was corrected at `3e343e5` but the producer was not,
   so it no longer regenerates from committed code. That breaks this milestone's own rule and it is
   **inside the module E1 modifies**. I did not fix it — the `hismove` job imports it and is running.
   **It must be fixed as E1's first act, once that job has landed.**
5. **The five bibliography rows §PA.4 owes are drafted in §X.3 but not written.** `BIBLIOGRAPHY.md` has
   other writers tonight and the brief's rule is to check `git diff` before staging a shared file. The
   product owner should say whether this planner writes them or the implementer does.
6. **Whether phase E may consume a reserve row.** If the product owner wants a second edge-companion
   instance, `mono-8/√3` is ready. I did not schedule it: it would spend a held-out row for a replication
   rather than for a new question.
7. ~~**§6 decision 12 — whether §S.1 clause 3 is discharged by E3 or needs E3b.**~~ **RULED, §A ruling 1:
   E3b runs and E3 is re-labelled to clause 2(c).**
8. ~~**Whether this planner or the implementer writes the five bibliography rows.**~~ **Done** — the five
   rows of §PA.4 are in `BIBLIOGRAPHY.md` § A, the `[SeguraEtAl2016]` alias is in § A′, and
   `python3 tools/bib_audit.py` reads *"every cited work resolves to a row or a recorded alias"* with its
   three self-test controls all firing. **The §X.2 amendment to phase F's plan is the product owner's**,
   per §A ruling 3.

---

## §X — Text this phase wants in files it may not edit

### X.1 — `plans/M63-parts-reproduction.md` §S.4, the phase E block

*Proposed replacement for the eleven bullet lines under **"Phase E — generalization, required for M63 to
close."** Reason: the list predates the 2026-09-11 course correction, prices no row, and does not say which
of its rows are held out, which are replays and which are controls.*

```
**Phase E — generalization, required for M63 to close.** Purpose: S.1 #3.
*Subplan: `plans/M63-phaseE-held-out.md`.*
Acceptance:
- [ ] Companion constructors -- `Companion.graph` (the frozen half), `Companion.mono_pair` (an edge
  between two existing vertices, both fixed), `Companion.non_mono_set` (three new vertices forming a
  triangle joined to every vertex of the set) -- each with a planted control that flips: a wrong edge
  length, a triple that is not forced, the pair endpoints left deletable, the clique's vertices left
  deletable. **And the refactor's own negative control: `S166` and `L451` regenerate with identical
  stage fingerprints, minima, `Y` and bounds.**
- [ ] `parts_rule.run_loop` takes its starting stage from the record's problem description instead of
  the hard-wired `v451e2400 / v136e564` pair -- which is also phase F section 2.6's input interface.
- [ ] Held-out predictions committed after the freeze `6158162` and before any held-out run; every row
  a frozen `Comparison`.
- [ ] **The held-out list excludes the M6B 375 row in writing** (phase C3 spent it; the audit marks it
  SPENT) **and the S M6A row** (spent as the R1 calibration). **M6B 374 at rung 2 stays held out.**
- [ ] Reduction generalization, each row split into a decision stage (`|M|`, minutes) and a level stage
  (`|{M}|`, `A`, ranges; tens of minutes to hours), and each L/S row identifying its companion by the
  24-frame refusal test before any count is compared: the 8/3 mono-pair (367, 27, `v375e1862`, companion
  constant by construction); L M6B 374 at rung 2 (78, `v406e2076`); L M6C 374 (76, `v400e2034`); S M6B
  (141, 4, `v172e804`) and M6C (150, 28, `v167e772`); the sqrt3 triple (221, 120, `v238e1131`).
- [ ] **Loop generalization, starting below his accumulator -- the required run is the 8/3 mono-pair**:
  start from his published 367-vertex minimum `v367e1822` (8 vertices below his `A375`) and let the
  frozen loop run. `A375 \ M367` is exactly 8 members of the single base orbit `(8,0,6,2)`, each of unit
  degree 5 into `M367`, and that orbit is EMPTY in `M367` -- so it enters the menu as a 24-vertex reserve
  candidate at exactly the frozen `n_new_max`. It is the one row in his published data where success
  clause 2(c) has an attested target: `{M}` must grow 1 -> 27 at fixed `|M| = 367`.
- [ ] **The mechanism control, not a held-out row:** the S side from a rung-2-symmetric 138-vertex
  minimum, whose containment of any 136-minimum is forbidden by the closure gap, so the loop must expand.
- [ ] **The control-characterisation experiment:** planted faults against the `contains-a-known-minimum`
  anchor and the restriction identity, each recorded killed or survived, **plus a written residue** -- the
  fault classes the guard cannot see even when green, each with the cheapest thing that would catch it.
  `anchor=None` gains a named verdict `anchor-not-supplied` so the fail-open becomes a fail-loud.
- [ ] A written human judgement over the frozen rows, and no aggregate verdict: no pass rate, no
  summable field in the artifact, no "broadly reproduces".

*Cost:* 2-3 engineer-days; compute 5-9 CPU hours, single core per run, never more than two at once.
```

### X.2 — `plans/M63-phaseF-beat-509.md` §2.6, two corrections to the transferring-controls paragraph

*Phase F got to this problem first and states it plainly. Two sentences in it are now known to be
understated, and both are the kind that read fine now and get cited later as the stronger thing. Proposed
replacement text for the paragraph beginning **"The controls that transfer, and the one that does not."**:*

```
**The controls that transfer, and the one that does not.** Transferring: the restriction identity; the pin
soundness check at rung 1; the three-state verdict with `unknown` never folded into a negative;
regenerated-identical artifacts. **"Exact geometry on every edge" transfers only in the weak sense and the
distinction decides whether this list is honest:** the stage's geometry is BUILT by `typem.unit_edges_fast`
plus `CrossLaw.edges` in exact arithmetic, and **a builder being exact is not a check**. The check is an
independent re-derivation from the STATED law, and the only implementation of that in this repository is
`tools/parts_edge_verify.py` leg 4 -- whose own docstring names the circularity it exists to avoid
("rather than by calling the committed edge builder, which would be circular") and which is welded into an
object-level verifier for the 509. M63 phase E lifts it to stage level and calibrates it against the anchor
(`plans/M63-phaseE-held-out.md` E9.5); until that lands, this row claims less than it appears to.

**Not transferring, and the risk is PRESENT TENSE rather than future:** `contains-a-known-minimum` has no
known minimum on a new base, so it silently degrades to checking nothing -- and it is ALREADY off on two of
its three call sites today, `parts_rule.run_loop` (`parts_rule.py:387`) and `parts_diag.hismove`
(`parts_diag.py:196`), both hard-coded to `anchor_tuples=None`. The "fired free on all 89 map entries"
count is right for `run_map` and is also the complete list. Its two replacements below are both **internal
consistency** checks -- they share the CNF builder and the geometry with the thing they check -- so they
restore coverage of "every deletion" in a stronger form than the anchor had, and restore **none** of the
external-truth property that made the anchor valuable.
```

### X.2b — `plans/M63-phaseG-*` (unwritten), one line it should inherit

> The anchor control `contains-a-known-minimum` does not transfer: on a new base there is no known
> minimum. Its successor is **the non-vacuity ask plus the stage-level geometry check lifted from
> `parts_edge_verify` leg 4 and calibrated in phase E**, with the metamorphic relations (equivariance,
> monotonicity, idempotence) covering the reduction's bookkeeping — and nothing covering a consistently
> wrong problem, or a fault in code that the stage and its reference share.
> `plans/M63-phaseE-held-out.md` §E9.3 is the residue table.

### X.3 — `BIBLIOGRAPHY.md`, five rows drafted for paste

```
[Hooker1995]  J. N. Hooker, "Testing heuristics: we have it all wrong", Journal of Heuristics 1(1),
  33-42, 1995. Role: the case against competitive testing; the warrant for M63 phase E's "no aggregate
  verdict" rule. Copy: none. Read: named only, not read.
[Johnson2002] D. S. Johnson, "A theoretician's guide to the experimental analysis of algorithms",
  Proc. 5th DIMACS Implementation Challenge. Role: the reimplementation trap and reporting standards.
  Copy: none (open PDF at archive.dimacs.rutgers.edu). Read: named only, not read.
[EggenspergerEtAl2019] Eggensperger, Lindauer, Hutter, "Pitfalls and best practices in algorithm
  configuration" (arXiv:1705.06058). Role: over-tuning -- the named failure M63 section 3 describes in
  its own words. Copy: none. Read: named only, not read.
[ChenEtAl1998] T. Y. Chen, S. C. Cheung, S. M. Yiu, "Metamorphic testing: a new approach for generating
  next test cases". Role: oracle-free controls for phase G (equivariance, monotonicity, idempotence).
  Copy: none. Read: named only, not read.
[SalariKnupp2000] K. Salari, P. Knupp, "Code verification by the method of manufactured solutions",
  SAND2000-1444, Sandia National Laboratories. Role: the published form of M63 phase E's
  control-characterisation experiment -- blind-test protocols reporting which coding mistakes the
  procedure can and cannot expose. Copy: none (open PDF at osti.gov). Read: named only, not read --
  and it is the one read that would most improve E9.
```

---

## §P — Poros's cards, and their fates

*Twenty cards across five messages during planning. The advisor's own record is
`plans/POROS-2026-09-11-m63-phaseE.md` (written by it, uncommitted by it; committed by path by the planner
or the product owner). Every code claim below was re-verified here before adoption, because a ruling made
from a plan's prose about code is a ruling about the prose.*

| # | card, in one line | fate |
|---|---|---|
| 1–3 | what the freeze actually freezes: `require_frozen` has one caller, behind a flag that is default off, and the frozen file pins no `wall_ask`, `max_minima`, `rung`, `cross_law` or `fp_base` | **verified and adopted whole** → §1.7 and §6 decision 9. My first draft's "the configuration is frozen" was an overstatement and is corrected |
| 4 | `run_loop` hard-wires its problem and the new code sits outside the hashed config | **verified and adopted** → §1.5 item 2, §1.7 |
| 5 | the anchor is already off on `run_loop` and on `hismove`, and its absence is a *missing key* rather than a verdict | **verified and adopted** → §0's call-site table, §6 decision 4. It corrects my draft's opening sentence |
| 6 | the residue, six blind spots; and the constructive half — the exact-geometry verifier is the external replacement | **adopted, and his framing beats mine**: *checks 1–3 are internal consistency, check 4 is the only external check*, adopted verbatim in spirit → E9.3 (now seven entries, his (f) added as R7) and **E9.5** |
| 7 | where to plant: the fault must be invisible to checks 1–3, so it must live in shared code | **adopted and it reorders the plant table** → **f0** (a base point off the unit circle) is promoted to the primary plant; his registered prediction that a swapped companion does **not** fire on every anchor is P-E19 |
| 8 | `_rank_ours` degrades to `his_degree` when the proxy is flat, and B-12 measured it flat | **verified in the code — the docstring says so outright — and adopted** → **E-pre.2** and §6 decision 11 (the free control arm) |
| 9 | `\|M\| = 367` is free on E3, and "three attested targets" oversells the row | **adopted** → E3's "one at-risk quantity, not three" |
| 10 | which rows can be compared on all three quantities | **converged independently** → §1.2 |
| 11 | `Comparison` has no companion field, so §S.1 2(a) lives in prose; push the invariant into the type | **adopted** → §1.5 item 4 |
| 12 | the calibration does not make a row redundant, and here is what it does not touch | **adopted with his specifics** → §P's answer to card 5 of his first message, and E3 |
| 13 | *(sent, then half-withdrawn by its author against the artifacts)* the counting group was fitted | **the withdrawal is right and I re-verified it**: the convention was fitted on `S166` and confirmed on `L451` and `M6B403`. **What survives is sharper than what was withdrawn** — the confirmations are against the *companion-fixed* rival, and `Aut(A)` against the whole base group is unseparated on every row ever run → §1.1's table and **E-pre.1** |
| 13b | the reduction record does not hold the number that gets compared (`M6B403`: 360 in the record, 66 in the audit) | **verified and adopted** → E-pre.1's second paragraph; each registration names the artifact as well as the group |
| 14 | two rows carry undeclared priors | **adopted** → E4's declared prior; E0 reclassified as an unfinished phase D row |
| 15 | §S.4 says both "no S number is held out" and lists two S rows | **adopted as his one sentence** → E6: the S rows test generalization across **subtype**, not across **apparatus** |
| 16 | no aggregate verdict; ban any sentence containing a fraction of rows | **adopted** → E10, including his addition that the judgement must name each disagreeing row and what would resolve it |
| 17 | the compute estimate is ~5× low because every row needs a level | **split**: the *column* is adopted (every cost row says optimum or level) and **`max_minima` becomes a per-row pre-registered decision**, which is his best point. **The 5× is disputed with measurements** — `S166` closed 8 minima in 587 s and `L451` 282 minima in 605 s; the 79-minute run is an outlier at 19,000+ minima. Recorded as a disagreement in §4 rather than resolved |
| 18 | **the required loop row cannot test the clause it is listed against** | **the substantive scope finding of the pass. Adopted** → E3 reclassified to clause 2(c), **E3b** added, §6 decision 12 put to the product owner. His suggested construction for E3b is corrected: deleting an orbit in *some but not all* minima leaves the row vacuous — the deleted set must hit **all 27**. His parenthetical that the row is not at rung 1 is **wrong**, by the meaning of his symmetry column fixed in `parts-table1.json` |
| 19 | four of the seven pre-registered rankings were never implemented, one of them his own device; and reuse `m63-sweep-protocol.json`'s format | **adopted** → §3's preamble; `his_indicators` named as the cheapest upgrade and explicitly **not** scheduled (§6 decision 13) |
| 20 | phase F §2.6 names this problem first; its two replacements are both internal, and its "exact geometry transfers" line is ambiguous | **adopted** → **§X.2**, proposed replacement text for that paragraph, since this plan may not edit phase F |

**Where the advisor was wrong, recorded because an advisor that is never corrected is not being used:**
card 13's first form (one row had discriminated — three had, against a different rival); card 18's
parenthetical about the rung; card 18's suggested E3b construction; card 6's guess that the anchor is blind
to the companion's identity (it catches a wrong companion **frame-dependently**, and the frame-dependence is
itself the residue — which is a better finding than either of our first positions).

**Where the advisor was right and this plan was wrong:** the anchor is already off on the loop path, so my
opening sentence was false; the freeze covers one row in seven, so my §5 overstated it; `|M| = 367` is free,
so E3 as listed cannot discharge the clause it was put there for; and the rule may never have been in the
room on E3 at all.
