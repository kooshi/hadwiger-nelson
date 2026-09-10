# FS-28 — The vacuity instrument's coverage (subplan)

*Subplan written 2026-09-09 by de Bruijn, on Kooshi's go. The pre-subplan stub is
`plans/STUB-vacuity-coverage.md`; **read it first for the incident that minted the gate**. This
file is what `WORKFLOW.md` step 3 asks for: the measured shape, the skeleton, and the decisions —
including the three places where measurement **overturned the stub's plan**.*

---

## 0. What this milestone is for, in one paragraph

A theorem that begins *"for every X …"* is automatically true and completely empty when no `X`
can exist. That happened here: a theorem held since M34 quantified over proper 4-colourings of
the plane, which this repository had separately proved cannot exist. It was correct,
machine-checked, axiom-clean, and meaningless, and nobody noticed for four weeks. On 2026-09-09
the rule against it became a gate (`scripts/Vacuity.lean` + `scripts/vacuity.sh`). **That gate
looks at four kinds of hypothesis and there are more.** This milestone widens what it looks at,
repairs three defects found in it while doing so, and discharges the backlog of sites it flags.

## §PA — Prior-art gate (WORKFLOW step 3a)

Searched in **two disciplines' own words**, per `G49`, never in this project's coinages.

**1. Model checking owns this concept, and has since 1997, with settled vocabulary.** Beer,
Ben-David, Eisner and Rodeh, *Efficient detection of vacuity in ACTL formulas* (CAV 1997; FMSD
2001); Kupferman and Vardi, *Vacuity detection in temporal model checking*; Ben-David and
Kupferman, *Vacuity in practice: temporal antecedent failure* (FMSD 46(1), 2015). Their terms:

| theirs | ours | note |
|---|---|---|
| **vacuity** | vacuity | same word, and they had it first |
| **antecedent failure** | `VACUOUS` | *"trivially valid because the pre-condition of the implication is not satisfiable"* — our failure mode, exactly |
| **interesting witness** | `WITNESSED` | *"a non-trivial example of the validity of the formula"* |

Their practical claim is **stronger** than ours and worth quoting when this is written up:
temporal antecedent failure *"always indicates a problem in the model, environment or property"*.
**Recommendation: adopt "antecedent failure" and "interesting witness" in prose** (FS-20 carries a
naming deliverable for exactly this reason); keep the verdict tags, which are already
`axioms.sh`-shaped and are an internal contract parsed by a shell script.

**2. There is Lean-specific prior art, and it is three months old.** Ammanamanchi, Bhat and
Biderman, *Faults in Our Formal Benchmarking: Dataset Defects and Evaluation Failures in Lean
Theorem Proving*, arXiv:2606.29493, 30 June 2026, with a toolkit of **thirteen** checkers
(`github.com/Shashi456/atp-checkers`). One is **"Vacuous Hypotheses"**. Read, not skimmed
(`G50`): it **attempts to prove `False` from the hypothesis context**, and its documented
limitation is that it is **local and "cannot follow definitions."**

**That limitation is the whole difference, and it is in our favour on this library's own bug.**
`core9_plane`'s emptiness is not a local contradiction: it is a *theorem elsewhere in the
library* (`IsEmpty ((unitDistance ℂ).Coloring (Fin 4))`), reachable only by knowing that
`SimpleGraph.Colorable G n` is **definitionally** `Nonempty (G.Coloring (Fin n))`. A local
`False`-prover would not find it. Conversely, theirs finds shallow arithmetic contradictions
(`Nat` truncation, division by zero) that ours never will. **Complementary; neither subsumes the
other.** Their population is benchmark datasets (miniF2F-shaped), ours is a research library.
Also theirs: an `Axiom` checker (our `axioms.sh`) and an `Unused Binder` checker (Phase C's
neighbour — and `lake lint`'s `unusedArguments` already covers the literal case here).

**3. Mathlib has no vacuity linter.** Its 31-file linter set was read; the nearest is
`UnusedInstancesInType`, which flags instance arguments unused in the type. Not this.

**Verdict: the gate is not novel and does not need to be** — it is infrastructure. What the
search bought is (a) standard vocabulary for prose, (b) confirmation that the
evidence-required-and-definition-following design is the distinguishing choice and should be
stated as such, and (c) a citable adjacent tool. Nine bibliography entries follow at the close.

## 1. What the measurements say — three overturns of the stub

Every number below was taken from the **environment**, never from `grep`. The first attempt used
`grep` and returned **zero for every family**, which is `G21` wearing a tool's clothes for the
third time in this file's history (`CLAUDE.md` § tooling notes has the two from yesterday).

### Overturn 1 — the stub's biggest item is a category error, not merely low-yield

The stub ranks `UDCert` (61 sites) as *"the bulk, but certificates are probably inhabited and
this is mostly confirmation."* It is not even that. **`UDCert`, `Gadget` and `Brick` are
`structure`s** — records of lists and integers, inhabited by anyone who writes one down. The live
question for a certificate is not *"does one exist"* but ***"is this one valid"***, and validity
here is `UDCert.Valid : UDCert n → Bool`, an equation `c.Valid = true` that `decide` settles.
Measured, adding the three families would contribute **~100 `GENERIC` lines** (the binder mentions
bound variables) and **~37 trivially-`WITNESSED` lines** which are the constructions themselves
(`rhombusGadget`, `nineBrick`, `sevenBrick`, `deGreyGadgets`, …). **Excluded, with the reason.**

### Overturn 2 — "every Prop binder" is worse than the stub feared, by an order of magnitude

The stub warns that Prop hypotheses are everywhere and the tracked list must stay a **named**
list. Confirmed, and the number is bigger than guessed: **`HadwigerNelson.Justified` alone has
1,426 binder sites** — the LRAT watermark induction, `Justified t f w₁ → Justified t f w₂`,
chained once per certificate segment and inhabited by construction from `Justified t f 0`. A rule
of "all Props" would have buried every real finding under it.

### Overturn 3 — extending the families finds nothing, and that is the honest headline

Measured with the extension built and run: **249 → 335 sites (+86), and the fifteen baseline
`UNKNOWN`s are unchanged. 0 vacuous, 0 stale.** So Phase A+B is a **coverage increase that lands
green** — a real negative, recorded at the same standard as a positive, which is what stops it
being re-run. The stub's hope that `AdditivelyRigid` might fire (M57 measured that nothing here is
additively rigid at four colours) did **not** pay: its three consumers are generic in the colour
count `k`, so they are `GENERIC`, and M57's measurement is about `k = 4` specifically.

### What the census actually found — the tracked list, chosen from evidence

6,145 of our declarations, 5,459 human-written (`Lean.Name.isBlackListed`; the auto-generated 11 %
turns out to contribute only ~5 of the gate's 249 sites, so filtering them is **not** worth doing
and is not done). The families where *"is this satisfiable?"* is a live question about a named
structure of this project's own theory:

| family | human sites | why it is live |
|---|---|---|
| `Compels` | 9 | M45/M48 measured most compulsions absent |
| `Aperiodic` | 6 | a colouring table with no period — M60's hinge |
| `CoincidesAtNonedges` | 6 | its partner |
| `AdditivelyRigid` | 5 | M57: nothing here is additively rigid at four colours |
| `MonoPair` | 5 | the pigeonholes' conclusion |
| `Extends` | 4 | absorption's central hypothesis |
| `IsAdditive` | 4 | M56/M57: the additive family dies under thickening |
| `IsStress` | 3 | a self-stress need not exist |
| `Realizes` | 3 | M45's pattern realizability |
| `CoverAtLeast` | 3 | coverage floors |
| `UDCert.CoordsIn` | 32 | the coordinates lie in a subring — genuinely can fail |
| `IsLift` | 1 | M59's entire theorem is that lifts need not exist |

Excluded and why: the data families above; `Justified` (1,426); and the algebraic carriers
(`Q4`, `Adjoin`, `Quad`, `F4`, `Pt`, `PtTable`, `Ival`, `IntTable`, `ClauseTable`, `Chunks`,
`LitSet`, `Motion`, `SqrtBounds`, `Outcome`, `Step`, `Action`, …), which are always inhabited and
would add ~800 lines of noise.

## 2. The three defects found in the gate — this is the milestone's real yield

None of these was on the stub's list. All three were found by trying to run a control.

### D1 — a catch-all match arm silently disabled witness-gathering

Placing the new tracked-Prop arm **before** `| some ``SimpleGraph.Colorable` shadowed it. Effect:
`witnessed` fell **8 → 1** and `unknown` rose **15 → 25**. Lean reported it only as a
`redundantMatchAlt` *warning*, and the audit still printed a plausible-looking report.

**Caught only because the previous numbers were held in hand.** A gate whose output is a set of
counts must have those counts written down where the next reader meets them; they are now in
`CLAUDE.md` § The gate and in the baseline header.

### D2 — the gate could not see a refutation, and would have flagged the refuter

For a `Prop` `P`, the emptiness evidence is a theorem `¬ P`. But **`Not P` *is* `P → False`**, so
`gather`'s `forallTelescopeReducing` eats the arrow: the refutation is not recognised as
evidence, *and* it becomes one more site carrying a hypothesis nothing satisfies —
**the emptiness proof flagged by the very emptiness it proves.** Measured: two such theorems
(`pathGraph_not_additivelyRigid_three`, `cycleGraph_six_not_additivelyRigid`) appeared as new
`UNKNOWN`s in the first extended run.

Two-part repair, and both parts are needed: a **non-reducing** pre-pass that reads `¬ P` as
emptiness evidence for `P`, and a **`providers` set** so a declaration that supplied emptiness
evidence is never audited against it. That second part is not fussiness — without it the check is
circular by construction on exactly the theorems that make it work.

### D3 — the gate could not see its own controls, twice over

`CLAUDE.md` § "Make the gate fail, and watch it fail" requires every check's negative control to
be run at every milestone. **It could not be, from the audit file:**

* **(a)** `isOurs` asks `env.getModuleIdxFor?`, which returns `none` for a declaration made in the
  file *currently being elaborated* — so a planted control in `scripts/Vacuity.lean` is invisible.
  Planting one therefore meant editing a real library module and rebuilding. **Repair:** no module
  index means *this file*, which is ours.
* **(b)** With (a) fixed, the planted control came back `UNKNOWN` **and looked like a finding.**
  It was not. `lake env lean` **does not apply the lakefile's `autoImplicit := false`** — the trap
  `CLAUDE.md` § Toolchain documents in as many words — so `pathGraph` auto-bound to a fresh
  variable and the planted theorem silently became a *different, generic* statement.
  **Repair:** `set_option autoImplicit false` at the head of the audit file.

**This is the sharpest finding of the milestone**, and it is `G21` a fourth and fifth time inside
the instrument built to prevent it: *the vacuity gate's own controls were not runnable, and the
first attempt to run them produced a clean-looking wrong answer.*

## 3. The skeleton (WORKFLOW step 3)

Everything ships in three files plus a handful of one-line witnesses. Nothing here changes an
existing theorem's statement.

### 3.1 `scripts/Vacuity.lean`

```lean
set_option autoImplicit false                            -- D3(b)
set_option relaxedAutoImplicit false

def trackedProps : List Name := [ … the twelve above … ]  -- Phase A

structure Evidence where
  empties   : Array Expr := #[]
  witnesses : Array Expr := #[]
  providers : Array Name := #[]                          -- D2

def isOurs (env) (n) : Bool := …                          -- D3(a): `| none => true`

def gather (env) : MetaM Evidence := …
  -- non-reducing pre-pass: `⊢ ¬ P`, P tracked  ⟹ empties.push P, providers.push n   (D2)
  -- reducing pass, on the unconditional conclusion τ:
  --   `IsEmpty τ`                       ⟹ empties
  --   `Colorable G k`                   ⟹ witnesses (`G.Coloring (Fin k)`)   [existing]
  --   `Nonempty τ`                      ⟹ witnesses                          [new, free]
  --   τ IS a carrier (a `def` of one)   ⟹ witnesses                          [new — §3.3]
  --   τ = `P …`, P tracked              ⟹ witnesses                          [Phase B]

def carrierOf? (e) : MetaM (Option Expr) := …
  -- `G.Coloring α`                     ↦ itself                              [existing]
  -- `Forces/Separated/Fan G k _ _`     ↦ `G.Coloring (Fin k)`                [existing]
  -- head ∈ trackedProps                ↦ itself                              [Phase A/B]
```

**The one design decision inside this, stated because it is not obvious.** `Forces`/`Separated`/
`Fan` map to the *colouring* carrier, while the twelve new families map to *themselves*. Those
answer different questions and both are wanted:

* *"is this claim empty of content?"* — a `Forces G k p q` claim is vacuously true when `G`
  refuses `k` colours, so its carrier is `G.Coloring (Fin k)`;
* *"is this hypothesis dead?"* — for a `Prop` hypothesis `H`, `IsEmpty H` **is** `¬H` and
  `Nonempty H` **is** `H`, so the carrier is `H` itself.

`AdditivelyRigid` sits on both sides and shows why the split is real: as a **conclusion** it
unfolds to `∀ C : Coloring, …` and the reducing telescope already exposed the colouring carrier
(which is why `pathGraph_additivelyRigid` was already in the baseline); as a **hypothesis** the
binder's head is `AdditivelyRigid` and nothing saw it until now.

### 3.2 `scripts/vacuity.sh --self-test` — the control, made mechanical

`CLAUDE.md` requires the negative control at every milestone and D3 shows it was not runnable.
With D3 repaired it is a one-file operation, so it becomes a **flag on the gate**: append two
planted theorems to a copy of the audit file, run, and assert the exact verdicts.

| planted theorem | hypothesis | required verdict | what it proves |
|---|---|---|---|
| `planted_vacuous_rigid` | `AdditivelyRigid pathAddr (pathGraph 3) 3` — the library **refutes** it | `VACUOUS`, gate exits 1 naming it | the check fires |
| `planted_unknown_rigid` | `AdditivelyRigid pathAddr (pathGraph 3) 5` — the library is **silent** | `UNKNOWN`, never `VACUOUS` | it matches the **instance**, not the family |
| `planted_stale` | a `VACUITY DECLARED:` docstring on a witnessed carrier | `STALE`, gate exits 1 | a declaration is a checked claim |

**Both halves of the first pair already measured passing** with the extension built
(`VACUOUS`/`UNKNOWN` respectively). The second row is the load-bearing one: a check that flagged
it would be matching the family name rather than the instantiation, and would be worthless.

Run under `--self-test` the script must **exit 1 unless the planted verdicts are exactly these**,
and must never write a baseline.

### 3.3 Phase D — the eleven, and the four that stay

Read from the sites, and it is much cheaper than the stub priced it, because **most of the
witnesses already exist in the library and the gate simply could not see them**:

| # | witness needed | route | cost |
|---|---|---|---|
| 1 | `(edgeGraph 4 rhombus).Colorable 3` | `decide` — the rhombus is `K₄ − e` | one line |
| 2 | `(pathGraph 3).Colorable 2` | the parity colouring already in `AdditiveRigid.lean` | one line |
| 3 | `(edgeGraph 1581 deGrey.edges).Colorable 5` | **already proved** — `DeGreyBalanced.lean`'s `balancedColoring` with `balancedColorRaw_proper` (ledger row 8) | assemble |
| 4 | `(edgeGraph 553 heule553.edges).Colorable 5` | **new general lemma**, below | ~10 lines |
| 5 | `hexColoring`, `pathColoring3` | **no library work** — they *are* colourings; `gather` must read a `def`'s type as a witness (§3.1) | instrument |

Discharges: 1 → `rhombus_forces`, `rhombus_forces_of_gadget`. 2 → `pathGraph_three_coloring_two`,
`pathGraph_additivelyRigid`. 3 → the four `deGrey_no_narrow_fan_*`. 4 → `heule553_no_five_fan`.
5 → `hexColoring`, `pathColoring3`. **Eleven for four theorems and one instrument rule.**

The new general lemma, which is the only real mathematics in the milestone and is worth having
independently of this gate — it is the missing converse of the criticality machinery:

```lean
/-- A `k`-colouring of `G` with one vertex's edges deleted extends to a `(k+1)`-colouring of `G`:
paint that vertex the fresh colour. The upper bound that vertex-criticality data has always
implied and this repository never stated — `Critical.lean` proves `(G.deleteIncidenceSet p).Colorable k`
for every `p` and stops there, so every witness built from it was a lower bound only. -/
theorem colorable_succ_of_deleteIncidenceSet {V} {G : SimpleGraph V} {p : V} {k : ℕ}
    (h : (G.deleteIncidenceSet p).Colorable k) : G.Colorable (k + 1)
```

**The four that stay in the baseline, with their reasons unchanged** — `hexShell_plane5`,
`hexShell_plane6` (proving the inhabitant **is** Hadwiger–Nelson; and both are consumed to
*refute* a colouring, so emptiness cannot damage them), `core9_pigeonhole`, `core122_pigeonhole`
(the open item `plans/STUB-consolidation-remainder.md` §1 flagged independently — 60–100 lines
plus a bridging lemma). **Target after this milestone: a four-entry baseline, all four principled.**

### 3.4 Not in this milestone

**Phase C — the `Forces`-consumer problem (67 theorems).** A consumer of a vacuously-true
`Forces` hypothesis has a conclusion that is *true and not vacuous*, so no vacuity check can
flag it, while the sentence around it overstates what was shown. The check that finds it is
**hypothesis mutation** — delete a hypothesis, re-elaborate, require the proof to break — which
is N elaborations and a different technique. **Subplan separately if taken**, per the stub.
Recorded here so the boundary is deliberate: this milestone does not address it, and
`plans/STUB-vacuity-coverage.md` §4 is where the argument for why it is not urgent lives, stated
as an argument and not a measurement.

## 4. Acceptance

1. `./scripts/build.sh` green, zero `sorry`, `./scripts/axioms.sh` at **794 clean / exactly 5
   declared purchases** (a three-way match; if it moves, something is wrong), `lake lint` silent.
2. `./scripts/vacuity.sh` green with **≥ 335 sites, 0 vacuous, 0 stale**, and a baseline of
   **four entries**, all four principled.
3. `./scripts/vacuity.sh --self-test` **exits 1** on each planted defect, naming it, and green
   with none planted. Watched to fail, not assumed.
4. The counts are written into `CLAUDE.md` § The gate, so the next D1 is catchable.

**Cost:** half a day. **No compute.** **Bearing on χ(ℝ²) ≥ 6: none, and this milestone says so.**
Its value is FS-26's: this is the only kind of work on the board that could find another
`core9_plane`. **M62 (FS-6) remains rank 1 for the hunt itself.**
