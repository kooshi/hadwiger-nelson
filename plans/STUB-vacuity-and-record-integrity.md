# FS-26 — The vacuity audit, and the record's own integrity

*Minted 2026-09-09 by de Bruijn on Kooshi's direction — **"secure our current position … general
bookkeeping."*** *Four audits ran the same day; **every error they found is already fixed in place** and this
stub holds only what is left to DO. The largest item is a sweep the project's own rules require and has never
performed.*

---

## 0. Why this exists — the incident that minted the rule

On 2026-09-09 a plane-wide pigeonhole this repository had held since M34 — *"no proper 4-colouring of the plane
avoids a monochromatic pair at distance √3"* — turned out to be **vacuous**. It quantifies over
`(unitDistance ℂ).Coloring (Fin 4)`, and this repository's own rung B (`χ(ℝ²) ≥ 5`) makes that type **empty**.
The theorem is true, it is kernel-checked, it cost real work, and it says nothing. It was noticed only because
somebody tried to *use* it four weeks later, and a live argument had been resting on it.

`DEBRUIJN.md` § correctness-over-plausibility already forbade this in as many words — *"exhibit a model of your
hypotheses … before trusting any theorem that assumes them, because a `∀` over an empty domain proves
everything and means nothing"* — and `WORKFLOW.md` step 3 repeats it. **The principle was written down and not
run.** `G30`'s fifth failure mode records the incident and adds the mechanical rule: *every theorem whose
hypothesis is a structure ships with a named inhabitant, in the same file, or a one-line note saying which
theorem supplies one.*

**That rule has never been applied backwards, to the ~725 declarations that predate it.** This milestone is
that sweep.

## 1. Phase A — the vacuity sweep

**Population: 122 declarations whose statements quantify over `G.Coloring (Fin k)`** (measured 2026-09-09,
`grep -rn "Coloring (Fin" Proofs/`). For each, the question is one line: **is there a witness that `G` is
`k`-colourable at all?**

### A1 — the known-empty family: done, and it is small

`(unitDistance ℂ).Coloring (Fin k)` for `k ≤ 4` is empty by rung B. **Swept 2026-09-09: the only members are
`core9_plane` (`Instances/Core9.lean:156`) and `core122_plane` (`Instances/Core122.lean:149`)**, both already
carrying scope comments, both already corrected in ledger row 31, with the emptiness itself now a theorem
(`Instances/Interval.lean:63`, `isEmpty_coloring_plane_four`). **No third instance exists.** Recording the
negative matters as much as the positives: this family is closed.

### A2 — the general trap, which is sharper and has never been checked

**`Forces G k p q` and `Separated G k p q` are both *vacuously true* when `G` is not `k`-colourable.**
`Forces` is literally `∀ C : G.Coloring (Fin k), C p = C q` (`Forcer.lean:40`). So:

* a theorem **concluding** `Forces …` about a graph that refuses `k` colours proves nothing;
* a theorem **assuming** `∀ C : Coloring (Fin k), …` about such a graph has a hypothesis nothing satisfies.

This is not hypothetical arithmetic — it is the same shape as the M34 incident one level down, and the
repository has the detector already: **M45 made vacuity a *value***, `arityFloor G k = 0 ↔ ¬ G.Colorable k`
(`Arity.lean`). So the audit has a crisp form:

> **Every `Forces` / `Separated` / `Fan` statement in the library ships with its base-colourability witness —
> equivalently, with `arityFloor G k ≠ 0`.**

**Where it is already done, and the model to copy:** `Fan.lean` carries explicit non-vacuity witnesses
(`:285` *"the non-vacuity witness for every theorem in this module: a fan of width two"*, `:309`, `:338`). That
module is the standard; the sweep is to bring the other 121 sites up to it or to record why each is exempt.

### A3 — the third category, which is the one I expect to yield

Hypotheses that are **certificates, drawings, ring homomorphisms or embeddings** rather than colourings. These
are the ones where "does anything satisfy this?" is least obvious:

* `UDCert.drawing_*` and the reduction lemmas — a valid certificate plus a subring plus a hom plus an inverse
  of `D`. `M58` supplies instances at 11 and 131, but not every such theorem in the file cites one.
* `LocalGlobal`'s `isEmpty_ringHom_*` family — here **emptiness is the point**, so these are the inverse case
  and must be labelled as such so a reader never mistakes one for a hypothesis to discharge.
* `Lift.IsLift`, `IsStress`, `Absorb.Extends`, `AdditiveRigid.AdditivelyRigid` — the last is the sharpest, since
  M57 measured that **nothing this project holds is additively rigid at four colours**, so every theorem
  assuming it is close to the M34 shape and needs its inhabitant named loudly (Exoo–Ismailescu's `G`, with its
  cheats).

**Method.** Mechanical first, judgement second: extract every declaration with a structure-valued hypothesis;
for each, grep the file and its spec module for an inhabitant; produce a three-column table — *inhabited (with
the address) / deliberately empty (with the theorem proving it) / unknown*. Only the third column needs
thought, and I expect it to be short.

**Cost:** one to two days, no compute. **Acceptance:** the "unknown" column is empty, and every entry in it
resolved to one of the other two.

## 2. Phase B — what the audits left undone

The four audits of 2026-09-09 returned a **clean bill on almost everything**, which is worth recording as
plainly as the failures: all 176 artifact paths cited by the ledger exist; all 443 cited identifiers resolve;
the trust ledger is an **exact three-way match** across the Lean sources, `ARCHITECTURE.md` § Trust and
`scripts/Axioms.lean` on all five `native_decide` purchases; there are **zero live `sorry`**; and the frontier
ranks are a clean 1–16 with no gaps. Fixed in place the same day: five grokking errors, a self-contradictory
bibliography row, three duplicate keys, three citation-format slips, and `plans/ROADMAP.md` bannered
superseded.

What remains:

* **B1 — the `|` table-escaping bug.** Eight ledger rows and six bibliography rows use `|` as absolute-value
  bars inside markdown tables (`|z|²`, `|K(a,b)| ≤ 2√p`), which breaks table rendering. Nothing false is
  asserted; it is a rendering defect in the project's most-read file. A mechanical `\|` pass, half an hour, and
  worth doing before any of this is shown to anyone outside.
* **B2 — `[Heule2021]` acquisition.** *Odd-distance virtual edges in unit-distance graphs*, Geombinatorics
  31(2) (2021) 68–76, no preprint anywhere. It is the direct prior art for ledger row 59 and it **asks in print
  for the theorem we proved**. Brief in the library's notes; second in priority only to
  `[Johnson2006]`. Not blocking this milestone; blocking any write-up of row 59.
* **B3 — a fresh-clone check.** Every `build/*.json` the ledger cites exists locally but `build/` is
  gitignored, so a fresh clone would fail every one of those citations. Either mark them as local-only in the
  ledger's convention, or accept it explicitly. A decision, not work.

## 3. Phase C — the rule that should come out of this

`G30` gains a **sixth failure mode**, which the "explain the unexplained" survey (FS-25 §1) named
independently and which is not any of the five already listed:

> **A correct instance recorded where a theorem was available.** The record establishes something per-instance
> — four primes instead of all primes, one radius instead of the classification, one fabric piece instead of
> the size law, a numerical circulant instead of its closed form, measured directions instead of the group —
> and stops, because *the instrument answered and the question closed*. Every such reading is **true**, which
> is why it survives every gate this project has: nothing is wrong, something is merely smaller than it needed
> to be.
>
> *The detector is mechanical and it is not "grep for unexplained": **grep for `[measured]` next to a small
> finite list of instances, and ask each one what the general statement is.*** FS-25 found six that way in a
> day, and FS-24 found seven of the same shape in the Lean sources.

## 4. Cost, order, bearing

**Order:** B1 (half an hour, and it improves every subsequent read), then A1's negative into the record, then
A2 (the crisp one), then A3 (the one that may find something). Phase C is a ten-minute edit and should go in
first so the rule is written while the reason is fresh.

**Cost:** two to three days, no compute, no new mathematics.

**Bearing on χ(ℝ²) ≥ 6: none, and this stub says so.** Its value is different and it is worth naming exactly:
**this is the only work on the board that could find another `core9_plane`** — a theorem that passes the build,
the axiom audit, the sorry scan and a read-aloud, and still says nothing. The project's characteristic failure
is no longer proving a false thing; it is proving a true thing that means less than the sentence around it
claims, and nothing in the current gate detects that. **M62 (FS-6) remains the ranked rank-1 milestone for the
hunt itself.**
