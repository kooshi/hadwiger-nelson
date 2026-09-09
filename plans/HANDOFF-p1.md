# HANDOFF — package P1 (FS-26: the vacuity audit and the record's integrity)

*Branch `consolidate/p1`, five commits on top of `d093033`. Written for someone with no memory of
this work. The artifact is `plans/FS26-vacuity-table.md`; this file says what happened, what I
changed, what I deliberately did not, and what belongs to someone else.*

---

## 1. What landed

**The audit ran, and the headline is a clean bill with three findings attached.** The question was
the one this project's own written standard has always required and nobody had ever asked backwards:
*for every theorem whose hypothesis is a structure — a colouring, a certificate, a drawing, a ring
homomorphism — does anything satisfy it?* It exists because in September 2026 a theorem held here for
weeks (*"no proper 4-colouring of the plane avoids a monochromatic pair at distance √3"*) turned out
to say nothing: this project's own earlier result makes proper 4-colourings of the plane impossible,
so the statement quantified over an empty domain.

**No second such theorem exists.** Every statement in the library resolved, the "unknown" column is
empty, and the known-empty family is closed at exactly two members — both already corrected. That is
a real result and it should be reported with its enumeration attached, because the sweep found three
*other* things instead, none of them a false statement and all of them places where the record says
slightly more than the kernel checked.

### The three findings, in order of how much they matter

**(a) The self-satisfying producer — found independently by two readers in two different layers,
which is what makes it a failure mode rather than a remark.** A theorem of the form *"if the
augmented graph refuses `k` colours, then every `k`-colouring of the base graph has property `P`"*
degenerates on **both sides at once** whenever the base graph itself refuses `k` colours: the base
being uncolourable makes the augmented graph uncolourable too, so the hypothesis is free — and the
conclusion quantifies over an empty type, so it is free as well. The theorem then fires for every `P`
whatsoever and says nothing. **That is the mechanism of the original incident, stated as a
mechanically checkable property of the API instead of a fact about one instance.** Four sites
(`mono_pair_of_not_colorable_append`, `Fan.of_not_colorable`, the three `Forces.of_*`, and
`six_le_chromaticNumber_plane_of_additivelyRigid`). The guarded form already exists in this
repository **three times over** and none of them is the one instances travel — see
`plans/FS26-vacuity-table.md` §3, which also names the detector M45 already built
(`arityFloor_eq_zero_iff`: the vacuity guard as a *value*).

**(b) `core122_pigeonhole` rests on an argument a certificate cannot supply.** It quantifies over
proper four-colourings of the 122-vertex unit graph, and **nothing in the library says that graph has
any.** Its refutation is of the *augmented* edge list, and **a SAT certificate cannot distinguish
"the forty added pairs did the work" from "the unit part alone was already uncolourable."** If the
second reading were true, this repository would own a **122-vertex 5-chromatic unit-distance graph,
four times smaller than Heule's 510**, and would not know it. Nobody has noticed, so it is not so —
but "nobody has noticed" is a sociological argument. **It is repairable in about fifteen lines and I
verified the route**: all 122 coordinates were parsed and every one lies in `ℚ(√3, √11)`, so
Theorem B supplies the colouring outright.

**(c) Theorem A's headline form has never been exercised.** The declaration the module itself calls
*"Theorem A in the write-up's own shape"* (`colorable_unitDistance_induce_of_valuationSubring`) has
**no consumer and no inhabitant anywhere** — I checked the consumer graph directly. It is not vacuous
and no claim is wrong; the class is plainly non-empty. But **FS-20, the paper, is ranked second on
the frontier and is about Theorem A**, so the sentence a reader will quote is the one branch nothing
checks. One worked instance would close it.

### And the pattern behind the original incident

**Exactly two modules in the whole library carry no model of their own colouring hypotheses:
`Instances/Core9.lean` and `Instances/Core122.lean` — and they are precisely the two that produced
the incident.** Every other instance module ships one, usually labelled as such. Those two ship a
*geometric* adversarial control (move a vertex, watch the certificate fail) and no *colouring*
control at all, so **the one axis on which they could go silent is the one axis nothing tested.**
That was visible from the shape of the files before anyone read a theorem.

## 2. What I changed, and where

I own `CLAUDE.md` and `BIBLIOGRAPHY.md` this round, so these are already applied — nothing below
needs pasting. They are listed so a reviewer can find and undo any of them.

| # | change | where |
|---|---|---|
| 1 | **The `|`-escaping pass.** Absolute-value and set-builder bars inside table cells split rows into extra columns. 19 bars escaped across 8 ledger rows, 10 across 4 bibliography rows. Verified **content-identical to HEAD modulo pipes and whitespace**, and every table row now matches its header's column count. | `CLAUDE.md` rows 28, 29, 41, 44, 48, 52, 54, 59; `BIBLIOGRAPHY.md` rows 38, 75, 76, 108 |
| 2 | **A row that was dropping two cells.** `[Krebs2022]` carried **seven** cells in a five-column table, because the 2026-09-08 read appended its findings as new cells rather than folding them in — so the row's actual *copy* and *read* values sat in columns six and seven, which every renderer drops. Folded back, no word lost. Its stale *"Needs the PDF: interlibrary loan"* clause struck in the audit's own convention: it is contradicted three cells later in its own row, the second such contradiction in that single entry. | `BIBLIOGRAPHY.md:34` |
| 3 | **B3 decided, not fixed.** The ledger cites 34 paths under `build/`; `build/` is gitignored, holds 29 GB, and **exactly one of the 34 resolves in a fresh checkout** — not hypothetical, since this worktree is one. Cited subset is 51 MB. Decided against tracking: it would add untrusted *search* output to a proof repository, and from M51 onward artifacts went to `data/`, which **is** tracked, so the convention had already migrated. Convention now stated at the ledger's own heading. | `CLAUDE.md`, under the ledger heading |
| 4 | **A `G21` instance on our own instrument, recorded with it.** The record audit of 2026-09-09 reported *"all 176 cited artifact paths exist"* — true **of the directory it ran in**. A positive result measured its working directory the way a negative measures its enumeration. | same note |
| 5 | **Ledger row 31 amended in place**, twice: the known-empty family recorded as **closed at two** with the negative stated explicitly; and its own next sentence — *"At FIVE colours nothing is emptied"* — **sharpened, because it asserted something nobody knows, in the row correcting exactly that failure.** Whether the plane has a proper five-colouring *is* the open problem. What makes the five-colour statements safe is not a known-inhabited domain but that both consumers assume a colouring in order to **refute** it. | `CLAUDE.md` ledger row 31 |
| 6 | **The Frontier's M34 narrative struck.** It still read *"with the plane corollaries: no proper 4-colouring of the plane avoids monochromatic pairs at distance √3, nor at distance 2"* — stated as a result, in the most-read section, four weeks after the ledger row was corrected. **The correction had reached the ledger and not the prose summarising the same milestone**, and nothing in the gate compares them. | `CLAUDE.md` § Frontier, M34 paragraph |
| 7 | **Phase C was already present** (`G30`'s sixth failure mode). Verified it reads correctly; fixed one slip — it said it composes with *"the fifth mode below"* when the fifth sits above it. | `CLAUDE.md` § Grokkings, G30 |
| 8 | **A scope note at the six-colour programme's seed**, as `--` line comments so the `.olean` stays byte-identical and nothing downstream rebuilds. Records the three-step reading of `hexShell_plane`: **vacuous** at four colours and below, **OPEN** at five and six in the exact sense that inhabitation *is* Hadwiger–Nelson, **inhabited** at seven. And why that needs no repair: both consumers refute rather than use. Previously this lived only in a docstring in `Instances/Interval.lean`, which a reader of `HexShell` has no reason to open. | `Instances/HexShell.lean`, § the plane corollaries |

**Verification of the mechanical edits.** `CLAUDE.md` is content-identical to HEAD modulo pipes and
whitespace; the `HexShell` edit is 24 insertions and 0 deletions with every added line a comment,
block-comment depth 0 at the insertion point, and the declaration count unchanged.

## 3. Ready to paste — one amendment I did NOT apply, deliberately

**`G30` deserves a SEVENTH failure mode, and I left it for you.** My brief limited my `CLAUDE.md`
edits to the mechanical and additive ones the stub named; this is a substantive narrative addition
and five other packages have amendments to weigh beside it. **It is also the most important thing the
package found**, so please do not lose it. Suggested text, to follow the sixth mode in `§ Grokkings`,
`G30`:

> **A SEVENTH FAILURE MODE, from the vacuity sweep of 2026-09-09 (FS-26), and it is the fifth mode's
> mechanism rather than another instance of it: a theorem whose HYPOTHESIS is implied by the
> EMPTINESS OF ITS OWN CONCLUSION'S DOMAIN.** The shape is
> `¬ Colorable(G⁺) k → ∀ C : G.Coloring (Fin k), P C` with `G ≤ G⁺`. If `G` itself refuses `k`
> colours then so does `G⁺`, so the hypothesis is free — and the conclusion quantifies over an empty
> type, so it is free too. **Both halves degenerate at the same moment**, which is exactly why no gate
> catches it: the statement is true, the proof is correct, the hypothesis is discharged by a genuine
> certificate, and the conclusion is empty. `core9_plane` was an instance of this, not a one-off.
> Four sites carry the shape (`Pigeonhole.lean:82`, `Fan.lean:217`, `Forcer.lean:106/117/137`,
> `AdditiveRigid.lean:100`), and it was found **twice independently, in two different layers**, which
> is what makes it a mode rather than a remark. *The remedy already exists in this repository three
> times over and is never the entry point instances travel*: the two-way form whose right side demands
> a colouring (`Pigeonhole.colorable_append_iff_exists_avoiding`); folding the witness into the
> checked `Bool` so the certificate carries a proper colouring of its own graph
> (`NarrowFan.lean`'s `NarrowCert.check` — the pattern to copy); and taking the inhabitant as a
> *hypothesis* so the trap is closed by the signature and travels with the theorem
> (`ResidueObstruction.lean`). *And the detector exists too*: `Arity.arityFloor_eq_zero_iff` makes
> vacuity a **value** — `arityFloor G k = 0 ↔ ¬ G.Colorable k` — which is the sixth mode applied to
> this project's own instrument, since it is a theorem being used as a per-tool convention.

## 4. What I did NOT do, and why

**The two `example`s that would close finding (b) and its sibling.** Both repairs are identified,
verified and cheap — `Instances/Core122.lean` gets its four-colouring from Theorem B (all 122 points
verified in `ℚ(√3,√11)`), and `Instances/Core9.lean` gets `![0,1,0,2,2,1,2,2,2]`, which I checked is
proper on all thirteen edges with the pigeonhole's conclusion live on it at four of the six listed
pairs. **Both modules are leaves — nothing imports either — so each costs one module
re-elaboration and nothing downstream.** I did not write them for one reason: **this worktree has no
Lean build cache** (see §5), so I could not verify that anything I wrote elaborates, and handing an
unverified declaration into a six-way parallel merge is worse than handing over a precise
instruction. Note for whoever writes them: **Theorem B does not reach the nine-core** — its
coordinates use `√5, √7, √15, √21, √35, √105`, verified here — so the hand colouring is the only
route there.

**The docstrings on `core9_plane` and `core122_plane`.** The scope corrections on both are `--`
comments, so a reader who arrives via `exact?` or a hover still sees only the original docstring —
*"**No proper 4-colouring of the plane avoids monochromatic √3-pairs** … kernel-checked end to end"* —
with no hint that it is empty. The correction is correct and complete; it is simply not where a Lean
user looks. Since both modules are leaves, moving it into the docstring costs nothing downstream.
Left alone because my brief excluded docstring edits and I could not build to check.

**A full narrative-versus-ledger reconciliation.** I found and fixed one instance (item 6 above) and
named the shape. Twelve ledger rows carry corrections against six correction markers in the whole
narrative, so there may be more — but most of those are *prior-art* corrections, which change
attribution rather than truth and are recorded prominently in the Frontier's dated header entries.
Only the vacuity one asserted a live mathematical result in the milestone prose. **A full
reconciliation is a bigger job than this package and I would rather say so than half-do it.**

**`[Heule2021]` acquisition (B2).** Not mine; needs interlibrary loan and is already briefed in
the library's notes.

## 5. Things another package owns, or nobody does

**The worktree setup is inconsistent, and P2 is the one it could cost.** `lean-wt-p3` through
`lean-wt-p6` each have `.lake/packages` symlinked to the main tree's pinned copy, exactly as the
shared briefing describes. **`lean-wt-p1` (mine) and `lean-wt-p2` have no `.lake` at all.** For me
that is harmless — my package writes no Lean — but I discovered it by running `lake env lean` once to
check a comment, which caused Lake to clone 675 MB of fresh package sources. **No harm was done: the
main tree's Mathlib is untouched (still dated August), its 4.2 GB build cache is intact, no sibling
worktree was affected, and no clone was left running.** I removed the stray clone and the worktree is
back to the state I found it in. **P2 writes Lean, so if it has not already hit this, it will.**

**`plans/FRONTIER-STUBS.md`** should mark FS-26 closed and record the three findings; I did not edit
it because it is the coordinator's file.

**A research note, free and unasked-for.** `AdditiveRigid`'s five-colour target theorem has a
degenerate satisfaction route: `AdditivelyRigid q Γ 5` is vacuously true whenever `Γ` refuses five
colours, and then the `Forces` it produces is vacuous too, so the theorem fires with both sides empty
and still concludes correctly — by a route that does not need the interesting hypothesis at all. It
is sound, and worth a docstring line, because a reader would not see it.
