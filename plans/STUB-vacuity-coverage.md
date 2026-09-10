# FS-28 — The vacuity instrument's coverage: what it does not yet look at

*Minted 2026-09-09 by de Bruijn, at Kooshi's direction, out of the session that built the vacuity
gate. **Written for a reader with no memory of that session or of this project**, because the stub
rule (`WORKFLOW.md` § Plan) exists precisely because sessions die and compaction loses nuance.*

---

## 0. Why any of this exists — the incident, in plain terms

This repository proves things about the **Hadwiger–Nelson problem**: how many colours are needed to
paint the plane so that no two points exactly one unit apart share a colour. Every claim is checked
by Lean's kernel, so a statement is either proved or it is not.

But there is a way for a proof to pass every check and still say nothing. If a theorem begins *"for
every X …"* and no `X` can exist, the theorem is **automatically true and completely empty**.

That happened. A theorem held since milestone M34 said *"every proper 4-colouring of the plane has
some pair of points at distance `√3` sharing a colour."* This project had **separately proved that
the plane cannot be 4-coloured at all** — so there are no such colourings, and the theorem was
talking about nothing. It was correct, machine-checked, axiom-clean, and meaningless. Nobody
noticed for four weeks, until somebody tried to *use* it and found a live argument resting on it.

`CLAUDE.md` § Grokkings records it as `G30`'s fifth failure mode. The rule minted then — *every
theorem whose hypothesis is a structure ships with a named inhabitant* — was a convention enforced
by memory until 2026-09-09, when it became a gate: **`scripts/Vacuity.lean` + `scripts/vacuity.sh`**,
documented in `CLAUDE.md` § The gate and required by `WORKFLOW.md` step 8.

## 1. What exists now, so you do not rebuild it

`scripts/Vacuity.lean` is an environment linter. It walks every declaration's binders and
conclusion looking for **carrier types**, and asks of each whether the library proves it inhabited
or proves it empty. Deciding vacuity is undecidable, so it does not try: it **requires evidence**,
exactly as `scripts/axioms.sh` requires every trust purchase to be declared rather than verifying
any proof.

Six verdicts. Read `scripts/Vacuity.lean`'s own header for the full rationale; the short form:

| verdict | meaning | gate |
|---|---|---|
| `WITNESSED` | an inhabitant is proved | pass |
| `DECLARED` | provably empty **and the docstring says so, with a reason** | pass, printed every run |
| `VACUOUS` | provably empty and **undeclared** | **fail**, unbaselineable |
| `STALE` | a docstring claims emptiness that is **not proved** | **fail**, unbaselineable |
| `GENERIC` | the carrier is parametric — no witness can exist | counted, never baselined |
| `UNKNOWN` | a **concrete** carrier with no proved inhabitant | baselined, ratchets to zero |

Two facts make the whole thing work and are easy to lose: **`SimpleGraph.Colorable G n` is
*definitionally* `Nonempty (G.Coloring (Fin n))`**, so every unconditional `Colorable` theorem the
library already holds is a non-vacuity witness; and the emptiness facts are **theorems, not
instances**, so instance search alone finds nothing — the first implementation returned 249
`UNKNOWN` and zero verdicts, *including on the declaration that motivated the check*.

**Current reading: 249 sites — 0 vacuous, 0 stale, 3 declared, 8 witnessed, 223 generic, 15
unknown.** Red/green controls were run at introduction and re-run after the `GENERIC` split.

## 2. The gap this stub is about

**The check tracks four carrier families: `SimpleGraph.Coloring`, `Forces`, `Separated`, `Fan`.
Measured 2026-09-09, the library has 87 structure-valued hypothesis sites in families it does not
look at at all:**

| family | binder sites | why it matters |
|---|---|---|
| `UDCert` | 61 | certificates: a valid certificate plus a subring plus a hom plus an inverse |
| `Gadget` | 10 | forcing gadgets |
| `Absorb.Extends` | 6 | the absorption theory's central hypothesis |
| `Lift.IsStress` | 3 | first-order rigidity |
| `AdditiveRigid.AdditivelyRigid` | 3 | **the sharpest — see below** |
| `Brick` | 3 | tiling certificates |
| `Lift.IsLift` | 1 | |

**`AdditivelyRigid` first, and it is three sites.** Milestone M57 **measured that nothing this
project holds is additively rigid at four colours**. So every theorem assuming it is one step from
the `core9_plane` shape — a hypothesis nothing satisfies — and the gate does not currently look at
it. If M57's measurement is right and no witness exists, those three theorems are candidates for
being *exactly* the original bug, in a family nobody has swept.

## 3. The phases

### Phase A — extend the tracked families (~1 hour, confidence high)

`carrierOf?` in `scripts/Vacuity.lean` matches a fixed list of head constants. Extend it. The
probe, the evidence-gathering, the baseline machinery and the gate all work unchanged.

**Order by expected yield, not by size:** `AdditivelyRigid` (3 sites, and M57 says they may fire),
then `Extends` (6), then `UDCert` (61, the bulk, but certificates are probably inhabited and this
is mostly confirmation).

### Phase B — the Prop generalization (folded into A, but stated separately because it is the idea)

For a **`Prop`**-valued hypothesis `H`, `IsEmpty H` **is** `¬H` and `Nonempty H` **is** `H`. So the
existing probe already answers the right question for these families with **no new machinery**:
*does the library refute this hypothesis, or prove it?* `Extends`, `AdditivelyRigid`, `IsStress`
and `IsLift` are all Props; `UDCert`, `Gadget` and `Brick` are data.

*Watch for:* Prop hypotheses are everywhere, so the tracked list must stay a **named** list. Do not
generalize to "every Prop binder" — that is thousands of sites and the signal drowns.

### Phase C — the `Forces`-consumer problem (a different check; do not bolt it onto A)

**67 theorems take a `Forces` / `Separated` / `Fan` hypothesis.** Here is the failure they admit,
and it is the one Kooshi identified as the real form of "vacuity is a silent `sorry`":

If `G` is not `k`-colourable then `Forces G k p q` is **vacuously true**. Feed that to a consumer
like `not_colorable_sup_edge_of_forces` and you get `¬ (G ⊔ e).Colorable k` — **true, and NOT
vacuous, and therefore not flagged** — while reading as though the added edge did work it did not
do. No unsoundness; precisely the *"a true thing that means less than the sentence around it
claims"* failure this project actually suffers from.

**The check this needs is different**: *is the conclusion derivable without the hypothesis?* That is
**hypothesis mutation** — delete a hypothesis, re-elaborate, require the proof to break — which was
deferred as tier 3 when the gate was built. Cost is N elaborations. Note `lake lint`'s
`unusedArguments` already catches the literal case where an argument is never referenced; this is
the harder case where it *is* referenced and still does no work.

**Confidence: medium** on it finding anything; **high** that the failure mode is real, since the
example above is constructed from declarations that exist.

### Phase D — burn down the 15 (ongoing, not a milestone)

`scripts/vacuity-baseline.txt` holds 15 concrete carriers, grouped and annotated because they are
not equal work:

* **`hexShell_plane5`, `hexShell_plane6`** — proving the inhabitant here **is Hadwiger–Nelson**.
  They stay until the problem is solved. They are **not defective**: both are consumed to *refute*
  a colouring, and emptiness cannot damage a statement whose conclusion is the emptiness.
* **`core9_pigeonhole`, `core122_pigeonhole`** — the same two the 2026-09-09 audit independently
  flagged (`plans/STUB-consolidation-remainder.md` §1). **Two unrelated methods pointing at one
  declaration is the best evidence the check works.** Repair priced at 60–100 lines plus a bridging
  lemma that does not exist.
* **eleven genuinely dischargeable concrete objects** — this is where the count comes down.

## 4. Blocked, with the measurement — do not re-derive this

**Kooshi's question: can the `GENERIC` carriers be resolved by detecting their instantiations,
recursively?** The idea is right — vacuity really is a property of the instantiation, and a call
site that instantiates a lemma at an empty carrier proves nothing even though the lemma is fine.

**It cannot be done from a script.** Measured 2026-09-09: of **3,307 theorems in this library,
`ConstantInfo.value?` is available for 0**; of 2,708 definitions, for all 2,708. Lean does not
retain theorem bodies in the importable environment, so there is no proof term to walk.

**Two earlier attempts produced clean-looking zeros that were measurements of the instrument, not
of the library** — `G21`, twice in twenty minutes:

1. collecting closed carrier subterms from proof terms → 0, because the **type** never appears as a
   subterm, only the arguments do;
2. inferring types at application sites → 0 across 56 sites, because a fully-applied site's
   `inferType` is its **conclusion**, and the carrier is the type of an **argument**.

The blocker surfaced only on pointing the instrument at `core9_plane`, a case known to exist, which
it could not see at all. **Point every new instrument at a known-positive before believing a zero.**

Two measurements bound what is lost: the library mentions only **13 distinct concrete carriers**,
and **none appears solely inside a proof** — every one occurs in some statement, which the check
already scans.

**The only real route is instrumenting the BUILD** — a hook firing as each theorem is elaborated,
while the proof term is in hand, persisting what it finds into an environment extension. That
changes the build. Not recommended today; recorded so the next person starts from the wall.

### And the argument for why this is not urgent, which should be challenged rather than believed

Vacuity is **not** a silent `sorry`. A `sorry` is *unsound* and can make a meaningful statement
false, which is why it is contagious and why `sorryAx` propagates through `#print axioms`. A
vacuous theorem is **true**, and using it is sound. To *apply* `A : ∀ C : X, P C` you must supply an
inhabitant of `X`; if `X` is empty you cannot, **unless you are under a hypothesis that hands you
one — in which case your own statement quantifies over `X` too and the check flags you as well.**

So vacuity propagates **through statements, not through proofs**, and a chain is caught at every
link. *That is an argument, not a measurement.* Phase C is where it is weakest, because a consumer's
conclusion can be non-vacuous while resting on a vacuous hypothesis.

## 5. Cost, order, bearing

**Order:** A (with B) → D's eleven easy ones → C. Phase C is a different technique and should be
subplanned separately if it is taken.

**Cost:** A+B one hour. D's eleven, an afternoon. C, a day or more, and it is research-shaped.

**Bearing on χ(ℝ²) ≥ 6: none, and this stub says so.** Its value is the one FS-26 named: **this is
the only kind of work on the board that could find another `core9_plane`** — a theorem that passes
the build, the axiom audit, the sorry scan and a read-aloud, and still says nothing.
**M62 (FS-6) remains the ranked rank-1 milestone for the hunt itself.**
