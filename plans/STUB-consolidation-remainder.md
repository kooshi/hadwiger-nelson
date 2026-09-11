# FS-27 — What the parallel consolidation left behind

*Minted 2026-09-09 by de Bruijn at the close of the six-package parallel consolidation. **This stub exists so
that six agents' "I deliberately did not do this" sections survive as one ranked list rather than as six
handoff files nobody re-opens.** Every item below was found by an agent that had the material in front of it
and judged, correctly, that the item was out of its package's scope.*

**The parent stubs stay authoritative for their own items**: `plans/STUB-generalize-the-kernel.md` (FS-24),
`plans/STUB-explain-the-unexplained.md` (FS-25), `plans/STUB-vacuity-and-record-integrity.md` (FS-26). Each
item there now carries a status banner. This file is the residue.

---

## 1. The sharpest item, and the only one with real mathematical content

> **CLOSED 2026-09-09 — and the answer is the reassuring one.** `plans/FS27-1-core-inhabitants.md`
> holds the subplan and §R. **`core122`'s 122 points lie in `K = ℚ(√3, √11)`** — measured out of
> the certificate data rather than its docstring: zero `√5`/`√7` leaves across all 122 — **so
> Theorem B four-colours them** (`core122_colorable_four`, via the new leaf `SeamCert.lean`, whose
> general form `UDCert.colorable_four_of_seamFree` covers **any** `√5`- and `√7`-free certificate
> and never mentions `core122`). **There is no unnoticed 122-point 5-chromatic graph.** Verified
> independently before the kernel work: cadical, class sizes `[26, 27, 34, 35]`, all 421 unit edges
> re-checked outside the solver.
>
> **Two corrections to the text below.** *(a)* The route's price was right in shape and low in
> amount — the bridging lemma is `Q4.seamFree`, a `Subring Q4` mirroring `Q4.sevenFree` one level
> deeper so `CoordsIn` still **decides**, and the module came to ~130 lines including its prose.
> *(b)* **`core9` was never the same repair**, and grouping the two cost nothing here only because
> the estimate was generous: its nine points carry `√5` and `√7` and **no `√11`** — cut from de
> Grey's 1581, not the seam lattice — so Theorem B does not reach them. Thirteen unit edges on
> nine vertices are **three**-colourable, by `decide`.


**`core122_pigeonhole` rests on a premise nothing in the library establishes** (found by package P1, phase A3).

The theorem is about proper four-colourings of a specific 122-point graph. **Nothing here shows that graph has
any four-colourings at all.** Its supporting computation refutes a *larger* graph — the 122 points plus added
constraints — and a machine-generated refutation cannot say *which part* did the work.

**Why it is not merely bookkeeping.** If the 122 points were already impossible to four-colour on their own,
this project would own a **122-point graph requiring five colours — roughly four times smaller than the
smallest known** — and would not know it. That is almost certainly not the case; somebody would have noticed.
But *"somebody would have noticed"* is a social argument, and this repository's whole premise is that social
arguments are what the kernel replaces.

**The repair, priced honestly and revised upward once.** P1's first estimate was ~15 lines and it corrected
itself to **60–100 lines, plus a bridging lemma that does not yet exist**. It verified the route: all 122
coordinates parse, and every one lies in the number field where Theorem B (`FieldWall4.lean`,
`chromaticNumber_seamPlane`) hands you a four-colouring for free. The file is a leaf — nothing imports it — so
the build cost is one module.

**The corrected estimate is the more useful finding.** *"The example is three citations away"* and *"the
example needs a lemma nobody has written"* are different situations, and the second explains far better why
this went unchecked for as long as it did.

## 2. Two items that bear on the paper (FS-20), not on the hunt

**(a) Theorem A's headline form has no user and no example anywhere** (package P1, phase A3). The exact
statement the module's own notes call *"Theorem A in the write-up's own shape"* —
`colorable_unitDistance_induce_of_valuationSubring` — is consumed by nothing in the repository. It is not
vacuous; such objects plainly exist. But **the sentence a reader of the paper will quote is the one branch
nothing has ever exercised**, and one worked example closes it. FS-20 is ranked 2; this is cheap and it should
land before the paper does.

**(b) A Polymath16 wiki page nobody here has read** (package P2). An unfinished draft attempting a **rigidity**
proof for the exact mechanism behind Theorem B — stopping mid-argument. Every other prior-art find in this
project's seventh-lineage sweep *posed* the question; this one **attempts the argument**. It is now a
bibliography row marked blocking, and FS-20 must read it before submission.

## 3. Consolidation items held back deliberately, with their reasons

* **FS-24 item D — the fourteen private copies of `Real.sqrt 3 * Real.sqrt 3 = 3`** (plus `√5`, `√11`, `√33`,
  `√15` copies alongside), across fourteen modules. **Run it last and alone**, in the main tree, into a **new
  leaf module** (`Field/Radicals.lean`). The observation is worth more than the duplication: a declaration
  added to an existing upstream module rebuilds every dependent forever after, which is *why* each file minted
  its own copy — a new leaf costs one rebuild and nothing thereafter.
* **FS-24 items G5 and G6.** G5 (`Coset.lean` proves one theorem five times) has **no bearing on the hunt at
  all** — the Frontier has struck that family as a source of novelty — and is ~200 lines becoming ~60. G6 (the
  2-adic independence engine hard-coded at `√5`) is a **real re-proof**, and this project's own discipline says
  derive the `linear_combination` witnesses in sympy and verify them to zero residual *before* Lean states
  them. Neither was worth a package.
* **FS-25 items E2, E6, E7.** E2 collides with FS-24's consolidation item A (both touch the same rotation
  lemmas); do E2 first, then A. E6 and E7 were not attempted.

## 4. A three-way collapse, seen and declined

`Forces.comap`, `Separated.comap` and the new `transport_pair_of_isometry` are **three copies of one pattern**
(package P3). They sit in three files that three different packages owned on the same day, which is exactly why
it was right to decline. **Do it alone, in the main tree, or a fourth copy accretes later** — which is how the
fourteen radical copies happened.

## 5. Record-integrity leftovers

* **A dangling module reference.** `DistanceGraph.lean` and `Homogeneous.lean` both cite `Instances/OneTwo`, a
  module priced and deferred at M49 and **never built**. Ledger row 44 now carries a note. The Lean-side fix is
  a two-word docstring edit — but a docstring change rebuilds every dependent, so it is not free and should
  ride along with the next edit to those files.
* **Two disputed rows in a quoted published table.** Ledger row 59 proves a theorem about each of seven
  distances from `[Parts2020a]`'s Table 1. Two are disputed between independent readings (`3` vs `√3`, `1/3`
  vs `1/√3`) — **a square-root sign that automated PDF text extraction drops**, which is the same failure that
  cost this project a day earlier in the same week. The row now carries a flag. **Resolving it needs the actual
  PDF read by eye**, and the two *monochromatic* rows the theorem leans on are not disputed.
* **The three-way inconsistency in `G30`'s instance count** is repaired (P3's two additions are the fourteenth
  and fifteenth, P4's the sixteenth, P6's the seventeenth) — recorded here because three agents each counted
  correctly from what they could see, and only the coordinator could see all three.

## 6. Cost, order, bearing

**Order:** §1 first (it is the only item that could change what this project believes it owns), then §2's two
paper items before FS-20 opens, then §3's item D alone in the main tree, then §4.

**Cost:** §1 is a day with the bridging lemma. §2(a) is an afternoon, §2(b) is an hour's reading. §3's item D is
half a day and one full rebuild. §4 is an afternoon.

**Bearing on χ(ℝ²) ≥ 6: none, and this stub says so.** **The hunt itself continues in M63, M62 and FS-6, ranked in `plans/FRONTIER-STUBS.md`.**
