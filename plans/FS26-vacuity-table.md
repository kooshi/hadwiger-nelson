# FS-26 — the vacuity table

*The audit `DEBRUIJN.md` and `WORKFLOW.md` have required since the beginning and this project had
never run: for every theorem whose hypothesis is a **structure**, does anything satisfy it?*

*Run 2026-09-09 over the whole library. This file is the artifact; the reasoning is in
`plans/HANDOFF-p1.md` and the record amendments are in `CLAUDE.md` (ledger row 31 and the Frontier's
M34 narrative).*

---

## 0. Why the question is not rhetorical

`Forces G k p q` is **defined** as `∀ C : G.Coloring (Fin k), C p = C q` (`Forcer.lean:41`).
`Separated` and `Fan` have the same shape. So all three are **vacuously true when `G` refuses `k`
colours** — a theorem *concluding* one of them about such a graph proves nothing at all, and a
theorem *assuming* a colouring of such a graph has a hypothesis nothing satisfies.

In September 2026 that happened: `core9_plane` and `core122_plane` (M34) quantify over proper
four-colourings of the plane, and this project's own rung B (`χ(ℝ²) ≥ 5`) makes that type empty.
Both are true, both kernel-checked, both cost real work, and both say nothing. Nobody noticed for
four weeks, and by then a live argument was resting on one of them.

## 1. The columns

The stub asked for three. The sweep needed five, and the fifth is the finding.

| # | column | what it means | can vacuity damage it? |
|---|---|---|---|
| 1 | **INHABITED** | something satisfies the hypothesis and the file (or a theorem it names) supplies it | no |
| 2 | **GENERIC** | quantified over an arbitrary graph/ring/group — a transport or API lemma, not about any domain | no, as a theorem; **yes at the moment it is instantiated** |
| 3 | **DELIBERATELY EMPTY** | the conclusion IS a refutation (`¬ Colorable`, `IsEmpty`, a chromatic bound), so the theorem assumes a structure in order to contradict it | no — emptiness is the conclusion, not a hidden hypothesis |
| 4 | **OPEN** | inhabitation is equivalent to the open problem: `(unitDistance ℂ).Coloring (Fin 5)` and `(Fin 6)` are inhabited iff the plane is 5- or 6-colourable | not while every consumer is column 3 |
| 5 | **SELF-SATISFYING PRODUCER** | *(new — see §3)* the hypothesis is **implied by** the emptiness of the conclusion's own domain | **this is the mechanism** |

**Column 4 is worth stating plainly because it is easy to misread as a defect.** If `χ(ℝ²) = 7`
then the six-colour programme's own Act-One seed (`hexShell_plane5`) is vacuous. That is fine, and
the reason is column 3: both of its consumers assume a five-colouring in order to refute it. A
scope note recording the three-step reading now sits at the statements themselves
(`Instances/HexShell.lean` § the plane corollaries), because previously it existed only in a
docstring in `Instances/Interval.lean` that a reader of `HexShell` has no reason to open.

## 2. The known-empty family is CLOSED

Swept independently rather than inherited from the stub, over every spelling of a plane colouring at
four colours or fewer. **Four sites touch the empty type and there is no fifth:**

| site | verdict |
|---|---|
| `core9_plane` (`Instances/Core9.lean:156`) | vacuous; corrected in place, scope comment at `:145` |
| `core122_plane` (`Instances/Core122.lean:149`) | vacuous; corrected in place, scope comment at `:136` |
| `isEmpty_coloring_plane_four` (`Instances/Interval.lean:63`) | **is** the emptiness |
| `vacuous_of_plane_four_coloring` (`Instances/Interval.lean:76`) | **is** the general reading |

**No third substantive instance exists.** Every other plane-shaped statement in the library is over
an `induce`d **subset** of the plane — a different object, and one that really is four-colourable:
`Ladder.lean`, `MetaLadder.lean`, `Hexagram.lean` and `FieldWall4.lean` each *prove* their subset
four-colourable, and those proofs are the inhabitants. Recording this negative is worth as much as
the two positives, because it stops the sweep being re-run.

## 3. THE FINDING — the self-satisfying producer

**Two agents sweeping different layers found the same shape independently**, which is what turns it
from an observation into a named failure mode. It is the mechanism of the `core9_plane` incident,
stated as a property of the API rather than of any instance — and therefore mechanically checkable
ahead of time, which the incident itself was not.

> **A theorem `¬ Colorable(G⁺) k → ∀ C : G.Coloring (Fin k), P C`, where `G ≤ G⁺`.**
>
> If `G` itself refuses `k` colours then so does `G⁺`, so **the hypothesis holds for free** — and
> the conclusion quantifies over an empty type, so **it holds for free too**. The theorem fires for
> every `P` whatsoever and says nothing.

Both halves degenerate at the same moment, which is exactly why no gate catches it: the statement is
true, the proof is correct, the hypothesis is discharged by a genuine certificate, and the conclusion
is empty. Verified at four sites:

| producer | file:line | the inclusion that degenerates it |
|---|---|---|
| `mono_pair_of_not_colorable_append` | `Pigeonhole.lean:82` | `E ⊆ E ++ P` — used in its own guarded twin's proof at `:97` |
| `Fan.of_not_colorable` | `Fan.lean:217` | `edgeGraph n E ≤ edgeGraph n (fanEdges E p Q)` — **built inside `fan_iff_not_colorable`'s own proof at `:249`** |
| `Forces.of_edges` / `.of_gadget` / `.of_unsat` | `Forcer.lean:106, 117, 137` | same shape, one distinguished pair instead of a list |
| `six_le_chromaticNumber_plane_of_additivelyRigid` | `AdditiveRigid.lean:100` | `AdditivelyRigid q Γ 5` is vacuously true when `Γ` refuses five colours, and then `Forces` is too — found independently, in a different layer, by a different reader |

**And the guarded form already exists in this repository, three times over. None of them is the one
instances travel.**

1. **`Pigeonhole.colorable_append_iff_exists_avoiding`** (`:92`) — the same fact two-way. Its right
   side `∃ C, ¬ MonoPair P C` **demands a colouring**, so it cannot be satisfied vacuously. It sits
   ten lines below its unguarded sibling.
2. **`NarrowCert.check`** (`NarrowFan.lean:143`) — folds `!colourings.isEmpty ∧ all properColouring`
   into the single decided `Bool`, so **the certificate carries a proper colouring of its own graph
   as part of what the kernel checks**, and `NarrowCert.sound`'s `¬ Fan` conclusion is non-vacuous
   by construction rather than by a reader's care. This is the pattern to copy.
3. **Make the inhabitant a hypothesis.** `ResidueObstruction.lean`'s theorems take
   `col : (addCayley S).Coloring (Fin k)` as an *argument*, so a caller cannot instantiate them on a
   graph that refuses `k` colours — the trap is closed by the signature, and travels with the
   theorem instead of living in a spec section. `LocalGlobal.lean:265` does it one level up: its
   `hfree` hypothesis *implies* the plane is `k`-colourable, and the docstring says so.

And the guard the project already built and never wired in: **`Arity.arityFloor_eq_zero_iff`**
(`Arity.lean:236`), `arityFloor G k = 0 ↔ ¬ G.Colorable k` — M45 made vacuity a *value*.

### The near miss, measured

The four fan certificates over de Grey's 1,581-vertex graph (`Instances/DeGrey/Narrow*.lean`)
conclude `¬ Fan (edgeGraph 1581 deGrey.edges) 5 …` over the **whole unnarrowed graph**. I expected
these to be a third instance and they are not, for a reason worth recording exactly: **de Grey's
graph refuses FOUR colours, not five** — `χ(ℝ²) ≥ 5` means `¬ Colorable 4` — and the 1581 is
5-colourable kernel-side (`deGrey_balanced`, `Instances/DeGreyBalanced.lean:70`, every class at the
pigeonhole optimum of 317). So the type is inhabited and the fans say something. Better: each
certificate carries 8, 5, 8 and 8 packed colourings checked proper at `k = 5` inside the decided
`Bool`, so they prove their own non-vacuity without appeal to anything else.

**It is a near miss of exactly one numeral.** At `k = 4` all four would have been vacuous in
precisely the `core9_plane` sense. What saves them is not care taken — it is that the live question
happened to be one rung up.

## 4. The second finding — Theorem A's headline form has never been exercised

**Not a vacuity, and the distinction is the point.** The rubric needed one more split, proposed by
the reader who found this: **inhabited-and-exhibited** versus **satisfiable-but-unexercised**. A
hypothesis nothing *can* meet is the `core9_plane` disease. A hypothesis nobody *has* met is a
different risk — the theorem may be stated one hypothesis away from what a caller can actually
supply, and nothing would ever find out.

`ResidueColouring.lean`'s valuation layer is that second thing, and it is the branch that matters
most, because **FS-20 — the paper, ranked 2 on the frontier — is about Theorem A**:

| declaration | `ResidueColouring.lean` | consumers | inhabitants |
|---|---|---|---|
| **`colorable_unitDistance_induce_of_valuationSubring`** — the module's own docstring calls this *"Theorem A in the write-up's own shape"* | `:418` | **none** (its own docstrings and the axiom audit only) | **none** |
| `colorable_of_valuationSubring` | `:333` | one — the row above, which has none | none |
| `normOne_subset_valuationSubring` | `:300` | one — the row above, which has none | none |
| `conj_mem_valuationSubringAtPrime` | `:320` | **none** | none |
| `colorable_unitQuadrance_of_residue` — offered as evidence that `ℂ` was never needed | `:445` | **none** | none |

So the whole valuation branch is a chain that terminates in nothing: proved, kernel-checked,
axiom-audited, and never once applied to an object. `FieldWall4.lean` — the only real consumer of
Theorem A in the repository — reaches the plane through **`colorable_of_normOne`** instead, because
its own subring is explicitly *not* a valuation ring.

**This is not a defect and no claim is wrong.** The class is plainly non-empty (`L = ℚ`,
`A = ℤ_(p)`, `ψ =` reduction mod `p`), and the module's docstring already says the number-field
instantiation is deliberately unproved. What is *not* recorded anywhere is the consequence: **the
sentence a reader of the paper will quote is the one branch nothing checks.** One worked instance —
any valuation subring, any prime — would close it, and would be cheap.

The other unexercised rows, in descending order of how much they matter:

* **`Lift.IsLift`** (`Lift.lean:145`) and the two theorems concluding a *positive* fact from it,
  `stressPairing_eq_zero_of_lift` (`:186`) and `UDCert.stressPairing_eq_zero_of_drawing` (`:256`).
  `IsLift` occurs in the entire repository **only underneath `¬ ∃`** — three times, in
  `Instances/LiftObstruction{11,19,131}.lean` — so **nothing anywhere exhibits a lift.** It is
  satisfiable (a two-vertex model in `ZMod 121` was checked by hand), so this is not a second
  `core9_plane`; what it means is that only the contrapositive of M59's machinery has ever been
  used, and the forward theorem has never been run on a real configuration. The module docstring
  claims one exists — *"the closed hex shell … is a real configuration"* — and then checks only
  `IsStress` and the pairing (`:300, :301`), never the lift. **A five-line example would close it
  and would double as a red**, showing the machinery distinguishes shadows from non-shadows rather
  than only refusing.
* `UDCert.chromaticNumber_le_of_drawing` (`Lift.lean:81`) and
  `add_one_le_chromaticNumber_plane_of_lift` (`:94`) — the recipe a lifted forcer would consume,
  never instantiated at any `k`. At `k = 5` instantiating it **is** the six-colour problem, so this
  one is honestly unexercisable today.
* `Fractional.lean` and `UnitDistance.lean` have no in-file model **by design**, naming their spec
  modules in their docstrings (`FractionalSpec.lean`, `Instances/Triangle.lean`). Both fine; listed
  only so the count is complete.

## 5. The third finding — UNWITNESSED, and the one row that matters

The rubric needed a sixth label, proposed independently by the reader who swept the instance
modules, and it is the sharpest one because **it is where a `core9_plane` is born**:

> **UNWITNESSED** — inhabited *in fact*, but neither the file nor any theorem it names supplies the
> inhabitant. Not `UNKNOWN` (a witness can be named) and not `INHABITED` (nothing in the repository
> supplies it). The failure mode is never a false statement; it is a true one **whose truth nobody
> has checked and everybody assumes.**

Three rows, and one of them is load-bearing.

### 5.1 `core122_pigeonhole` — and the reason an LRAT certificate cannot settle it

`Instances/Core122.lean:129` quantifies over proper four-colourings of the **122-vertex unit graph**.
Its entire content evaporates if that graph refuses four colours, and **nothing in the library says
it does not.**

This is not idle. The theorem is derived from `core122Aug_not_colorable` — a refutation of the
*augmented* edge list (421 unit edges **plus** 40 pair edges) — and **an LRAT certificate cannot
distinguish "the forty pairs did the work" from "the unit part alone was already uncolourable."**
It is the self-satisfying producer of §3 at its most consequential instance: `E ⊆ E ++ P`.

If the second reading were the true one, this repository would be sitting on a **122-vertex
5-chromatic unit-distance graph — four times smaller than Heule's 510** — and would not know it.
Nobody has noticed, so it is not so; but *"nobody has noticed"* is a sociological argument, and it is
currently the only one on offer.

**It is cheaply and completely repairable, and the route is verified here.** All 122 points were
parsed out of `Instances/Core122/Base.lean` and every coordinate uses only the basis
`{1, √3, √11, √33}` — **they lie in `K = ℚ(√3, √11)`** — so **Theorem B**
(`FieldWall4.colorable_four_of_subset_seamPlane`, `FieldWall4.lean:1167`) supplies the four-colouring
outright, and it pulls back along `core122.point` because `core122_valid` makes every listed edge
exactly unit. **About fifteen lines, and `Instances/Core122.lean` is a LEAF — nothing in the
repository imports it, so nothing downstream rebuilds.**

### 5.2 `core9_pigeonhole` — same gap, harmless, and Theorem B does *not* reach it

`Instances/Core9.lean:111` has the identical shape and no inhabitant. It is harmless because the
nine-vertex graph really is three-colourable, and the witness is checkable by hand:

> `![0, 1, 0, 2, 2, 1, 2, 2, 2]` — **verified proper on all thirteen edges**, using three colours,
> and the pigeonhole's conclusion is **live** on it: four of the six listed `√3`-pairs — `(3,4)`,
> `(6,7)`, `(6,8)`, `(7,8)` — come out monochromatic.

Worth recording: **Theorem B does not apply here.** The nine points were parsed too, and they use
`√5, √7, √15, √21, √35, √105` — the core9 configuration does **not** lie in `K`, so the hand
colouring above is the only route. (`Instances/Interval.lean:53` currently *asserts* the nine-core is
three-colourable in prose, unproved — three lines after correcting a different unproved assertion.)

### 5.3 `Coset.seven_le_card_gap` and its four siblings

`Instances/Core23.lean:150` needs a proper cell-constant colouring at a G\*-band scale, and **no such
colouring exists anywhere in the library**: the only model the coset development supplies
(`Coset.exists_proper_coset_colouring`, `Coset.lean:718`) is at `p = 6/7`, outside the band. The risk
is low — the constraint graph has bounded degree, so a finite proper colouring exists — but the same
gap runs through all five window theorems of that family, **which are the only kernel statements the
M37–M43 cell arc leaves standing** now that `[SokolovVoronov2025]` has subsumed its floor.

## 6. The pattern, and it is not a coincidence

**Exactly two modules in the whole library carry no model of their own colouring hypotheses:
`Instances/Core9.lean` and `Instances/Core122.lean` — and they are precisely the two that produced
this project's only known vacuity incident.**

Every other instance module ships at least one, usually several, usually labelled as such:
`Instances/SpindleBound.lean` writes *"the concrete model … so that nothing below is a `∀` over an
empty domain"* beside `spindleFour`; `Instances/AritySpec.lean`'s module docstring **is** that
sentence; `HexShell`, `Core23`, `Mycielski`, `FinitePlane11`, `LocalGlobal19` and both `Critical`
modules each ship a positive colouring as a red control.

Core9 and Core122 ship the **geometric** adversarial control — move a vertex, watch `Valid` fail —
and no **colouring** control at all. *So the one axis on which they could go silent is the one axis
nothing tested.* That is the whole incident, in one sentence, and it was visible from the shape of
the files before anyone read a theorem.

## 7. Verdict

**The `UNKNOWN` column is empty. No third vacuous theorem exists.** Every statement in the library
was resolved into one of the other columns, and the two known members of the empty family are closed.

That is a clean bill and it should be read with its enumeration attached, in the same sentence:
**it is a clean bill about *vacuity*, and the sweep found three other things instead** — the
self-satisfying producer shape (§3, found twice independently), Theorem A's headline form never
having been exercised (§4), and `core122_pigeonhole` resting on an argument a certificate cannot
supply (§5.1). None of those is a false statement. All three are places where the record says
slightly more than the kernel checked.
