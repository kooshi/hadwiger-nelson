# Handoff — package P5 (FS-24 items G4 and G7b)

*Branch `consolidate/p5`, worktree `/home/kooshi/source/lean-wt-p5`, 2026-09-09.
Subplan and full reasoning: `plans/P5-hexshell-brick-generalization.md`.
Written for someone with no memory of this work.*

---

## 1. What landed

Three theorems in this repository were **written more narrowly than the arguments that prove them**.
Each has been restated at the level its own proof already occupies, and each keeps its original form
at its original name, so nothing that cites it breaks. **No new mathematics.** The gate is green:
`build: OK`, zero `sorry`, **741 declarations clean and exactly 5 declared purchases** (the 5 has not
moved; the clean count rose from 725 because the new public theorems were added to the trust
receipt — see §4).

### (a) The six-colour target was pinned at five colours; it is now stated for any colour count

The repository's statement of what the hunt needs reads: *if some finite gadget forces every pair at
distance `√3` apart to get different colours in every proper 5-colouring of the plane, **and** some
gadget does the same at distance `2`, then the plane needs at least 6 colours*
(`not_colorable_five_of_forced_pairs`, `six_le_chromaticNumber_plane_of_forced_pairs`, both in
`Proofs/HadwigerNelson/Instances/HexShell.lean`). The lemma they consume was **already** stated for
every colour count below seven, and the numeral `5` appeared nowhere in its four-line proof.

Both are now colour-generic (`not_colorable_of_forced_pairs`,
`add_one_le_chromaticNumber_plane_of_forced_pairs`), which makes a sentence typeable that this
repository could not previously write: **two six-colour gadgets at `√3` and `2` give `χ(ℝ²) ≥ 7`**
(`not_colorable_six_of_forced_pairs`, `seven_le_chromaticNumber_plane_of_forced_pairs`) — the
affirmative side of the local–global conjecture in its bold form. Nothing here suggests such gadgets
are within reach, and the docstring says so.

**The conjunction is preserved exactly, and it now carries adversaries at six colours as well as
five.** The original theorem needs a gadget at `√3` **and** one at `2`, never one at either; that
was a correction the record made to itself, proved by two explicit 5-colourings of the seven-point
carrier each of which separates one class entirely. Both witnesses are duplicated at six colours, so
the new instance is as honest as the old one rather than inheriting the old one's evidence.

### (b) The theorems were about the unit-distance graph; the proof needs less — and that closes a real gap

The proof uses only that the colouring separates points at distance `1`, so the right hypothesis is
a colouring of `distanceGraph ℂ D` for any set `D` of forbidden distances containing `1`
(`hexShell_planeIn`, `not_colorable_distanceGraph_of_forced_pairs`).

**Be precise about what this is and is not.** At the level of the pigeonhole it is a *restatement*:
the two forms are interderivable, each in one line, because a colouring of `distanceGraph ℂ D` with
`1 ∈ D` is already a proper unit-distance colouring. The file says so. **The content is one level
up**, at the conditional refutation, where hypothesis and conclusion both weaken and neither
statement implies the other:

> **`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`** — in the plane with both `1` and `2` forbidden,
> the shell's three diameters are already edges, so half the pigeonhole is free and a **single**
> `√3` gadget gives `χ(ℝ²; {1,2}) ≥ 6`.

That is the target of the measurement programme of milestones M49 and M50 (the *μ-dial*), which
until now had **no kernel statement connecting it to the hexagonal shell at all** — and the objects
that programme measures against are `{1,2}`-graphs, so this is the version a real gadget could
discharge.

**The gap this actually closes is between two turns of a session, not between two statements.**
`Homogeneous.lean`'s `Separated.planeIn` already hands a gadget-finder a distance-graph-shaped fact
— it is stated over an arbitrary `D` — and the old conditional theorems accepted only a
unit-distance-shaped one. So the only usable route was `Separated.plane`, the `{1}` case, which
throws the two-distance option away at exactly the step the μ-dial exists to exploit. One turn
produced what the next could not consume. That is invisible at the level of the statements and it is
why the item was worth doing.

### (c) Two facts about one function became one theorem

`Brick.colorable` says a passing periodic-tiling certificate properly colours the plane;
`Brick.avoids` says the same colouring never repeats a colour at any guarded distance. Together they
**are** a colouring of `distanceGraph ℂ D`. New leaf module
`Proofs/HadwigerNelson/BrickDistance.lean` (`Brick.colorable_distanceGraph`,
`Brick.chromaticNumber_distanceGraph_le`, `Brick.colorable_avoiding`), and the record's *"certified
9-colouring avoiding `√(3/2)`"* is now one theorem in `Instances/Nine.lean`: **the plane with both
distance `1` and distance `√(3/2)` forbidden needs at most nine colours**
(`chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine`). One `decide` does all of it — the
existing `nineBrick_check_avoid`.

`Brick.lean` is **byte-for-byte unchanged**, which is why `Instances/Seven.lean` and
`Instances/Interval.lean` (the module carrying `5 ≤ χ(ℝ²) ≤ 7`) were not rebuilt.

### (d) The house rule is now compiled, not promised

*"Every generalized theorem keeps its old form at its old name"* is a promise unless something checks
it. A pinning section at the foot of `HexShell.lean` ascribes the **pre-generalization type** to each
of the eight names the record cites and closes it with the name as it now stands. **The negative
control was run and watched**: mutating one pin's `Fin 5` to `Fin 6` produces the expected type
mismatch naming both types; reverting restores green.

### (e) One measurement, with its enumeration in the same sentence

`Instances/Nine.lean`'s docstring has always claimed the nine-colouring is kept, though superseded as
a bound, because *"it carries the avoidance surface at distances the seven-colouring does not avoid."*
That had never been measured. Probed over **480 rationals `n/d` with `n < 41`, `d < 13`**:

* **the seven-colouring passes with NO second guard** — one hit in 480, and it is the properness
  guard `1` itself. Its cell diagonal is exactly `1` (M36's boundary-tightness finding), so every
  margin it has is zero and it can avoid nothing;
* **the nine-colouring passes with 41 of them**, `3/2` among them.

So the module's stated reason for existing is confirmed quantitatively, for the first time, and
`χ(ℝ²; {1, √q}) ≤ 9` is available at 41 probed values of `q`. Only `q = 3/2` is minted as a theorem,
because that is the value the record quotes.

---

## 2. Amendments to `CLAUDE.md` — quoted for pasting

I did not edit `CLAUDE.md`; package P1 and then the coordinator own it. Four amendments, in
descending order of importance. The house rule is honoured throughout: **nothing measured is erased,
the derivation is added beside it.**

### 2a. A NEW ledger row, after row 59 (the last row in § "The novel-results ledger")

I recommend a new row rather than surgery on rows 32/43/44, because this pass touches three
milestones' surfaces at once and splitting it three ways would make each fragment unreadable.

```
| 60 | **Statements moved to the level their proofs occupy: the hex-shell target over any distance set, and a brick certificate as a two-distance bound** (FS-24 items G4 and G7b, 2026-09-09; all on axioms exactly the standard three; **no new mathematics — every item is a statement relocated, and each keeps its old form at its old name, mechanically**). **(a) The six-colour target is colour-generic.** `hexShell_plane` was already `{k : ℕ} (hk : k < 7)` and the numeral `5` appeared nowhere in its proof, so the two conditional theorems it feeds (`not_colorable_of_forced_pairs`, `add_one_le_chromaticNumber_plane_of_forced_pairs`) now are too — which makes typeable a sentence the repository could not previously write: **two SIX-colour gadgets at `√3` and `2` give `χ(ℝ²) ≥ 7`** (`not_colorable_six_of_forced_pairs`, `seven_le_chromaticNumber_plane_of_forced_pairs`), the affirmative side of G48's local–global conjecture in its bold form. The conjunction of ledger row 43 is preserved exactly and **now carries its two independence witnesses at six colours as well as five**, so the new instance is as honest as the old rather than inheriting the old one's adversaries. **(b) The pigeonhole over an arbitrary forbidden-distance set** (`hexShell_planeIn`, `not_colorable_distanceGraph_of_forced_pairs`), and the honest reading, which the module states: **at the pigeonhole this is a RESTATEMENT, not a strengthening** — the `distanceGraph ℂ D` and `unitDistance ℂ` forms are interderivable each in one line, because a colouring of the former with `1 ∈ D` is already a proper unit-distance colouring. **The content is one level up**, at the conditional refutation, where hypothesis and conclusion both weaken and neither statement implies the other: **`six_le_chromaticNumber_oneTwo_of_forced_sqrt3` — over `{1,2}` the shell's three diameters are already edges, so a SINGLE `√3` gadget at five colours gives `χ(ℝ²; {1,2}) ≥ 6`**, which is M49/M50's μ-dial target and had no kernel statement connecting it to the hex shell at all (the mirror is `not_colorable_distanceGraph_of_forced_two` at `D = {1, √3}`, one line). **The gap it closes is between two TURNS OF A SESSION, not two statements**: `Separated.planeIn` (M49) already returns a distance-graph-shaped fact and the old conditionals accepted only a unit-distance-shaped one, so a gadget-finder had to route through `Separated.plane` and discard the two-distance option at exactly the step the μ-dial exploits. Collapse worth recording: membership in `D` **implies** the separation hypothesis, so there is exactly ONE conditional theorem and the one-gadget forms are instances of it through a four-line discharge map (`coloring_ne_of_dist_mem`), not copies of an argument. **(c) `Brick.colorable` + `Brick.avoids` are one theorem** (`BrickDistance.lean`, a new leaf so `Brick.lean` is byte-for-byte unchanged and `Seven`/`Interval` are not rebuilt): a passing certificate colours `distanceGraph ℂ D` for every `D` whose distances are square roots of guards, so row 32's *"certified 9-colouring avoiding `√(3/2)`"* becomes **`χ(ℝ²; {1, √(3/2)}) ≤ 9`** — the form a future avoider find is quoted in, which is what row 32 says the module exists for. **(d) The keep-the-old-name rule is now COMPILED**: a pinning section ascribes the pre-generalization type to each of the eight names the record cites and closes it with the name as it stands, and **the negative control was watched to fire** (mutating one pin's `Fin 5` to `Fin 6` errors, naming both types). **(e) One measurement, over a named enumeration** (G21): across 480 rationals `n/d`, `n < 41`, `d < 13`, **`sevenBrick` passes with NO second guard — one hit, the properness guard itself — while `nineBrick` passes with 41.** M36's boundary-tightness, seen from a new side: a zero-margin certificate can carry no avoidance at all, and `Instances/Nine.lean`'s standing claim that it is kept *"because it carries the avoidance surface at distances the seven-colouring does not avoid"* is confirmed quantitatively for the first time. | `Proofs/HadwigerNelson/{Instances/HexShell,BrickDistance,Instances/Nine}.lean`, `plans/P5-hexshell-brick-generalization.md` | FS-24 |
```

### 2b. Ledger row 32 (M35) — one sentence appended, nothing removed

Find, in row 32, the phrase:

> `plus a certified 9-colouring avoiding √(3/2) (`Brick.avoids` live)`

and append immediately after it:

> ` — **PROMOTED 2026-09-09 (FS-24 G7b, ledger row 60): those are two facts about one function, and joined they are a colouring of `distanceGraph ℂ D`, so the row now reads as one theorem, `χ(ℝ²; {1, √(3/2)}) ≤ 9` (`chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine`). Measured with it, over 480 rationals `n/d` (`n < 41`, `d < 13`): `nineBrick` passes with 41 avoidance guards and `sevenBrick` with NONE — so the sentence "kept because it carries the avoidance surface at distances the seven-colouring does not avoid" is now quantitative, and the reason is M36's boundary-tightness (a zero-margin certificate has no room for a second guard).**`

### 2c. Ledger row 43 (M48) — one clause appended to the conjunction sentence

Find, in row 43, the end of the sentence:

> `so neither class is forced alone and the conjunction is not an artifact of phrasing.`

and append:

> ` **COLOUR-GENERIC 2026-09-09 (FS-24 G4, ledger row 60): the numeral 5 was decoration — `hexShell_plane` was already `k`-generic below seven — so the conjunction now reads at every `k < 7`, and its `k = 6` instance is `χ(ℝ²) ≥ 7` from two six-colour gadgets, a sentence this repository could not previously write. Both independence witnesses are duplicated at six colours, so the new instance carries its own adversaries.**`

### 2d. Grokking G26 — one paragraph appended to the `[PROMOTED TO KERNEL at M48 …]` block

Immediately after the sentence ending `it is a theorem with its own adversaries.]**`, add:

> **COLOUR-GENERIC AND DISTANCE-SET-GENERIC 2026-09-09 (FS-24 G4, ledger row 60).** The five was
> decoration: `hexShell_plane` had always been stated for every `k < 7`. So the conjunction is now a
> theorem at every colour count below seven, and **its `k = 6` instance says two six-colour gadgets
> at `√3` and `2` give `χ(ℝ²) ≥ 7`** — G48's bold form, from below. And because the pigeonhole's
> proof needs only properness at distance `1`, the same theorem holds over `distanceGraph ℂ D` for
> any `D ∋ 1` — which changes the reduction's *shape* for the first time since it was minted:
> **over `{1,2}` the three diameters are already edges, so a single `√3` gadget suffices and gives
> `χ(ℝ²; {1,2}) ≥ 6`** (`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`). Both halves of that trade
> are weaker than the plane's — the hypothesis quantifies over a smaller family of colourings, the
> conclusion bounds a larger graph — and neither statement implies the other; that is precisely why
> it is reachable, since the objects M49 and M50 measured `μ` against are `{1,2}`-graphs. *The
> "AND, never either" reading is untouched and remains the sharp one for the plane itself.*

### 2e. `BIBLIOGRAPHY.md` — one addition (P1 owns the file this round)

Found by the prior-art gate (WORKFLOW step 3a) and **absent from the bibliography**; the three
Exoo–Ismailescu entries there are arXiv:1805.00157, arXiv:1909.13177 and the 2020 Geombinatorics
note. This is a fourth, different paper by the same pair.

> `| **[ExooIsmailescu2018]** | G. Exoo, D. Ismailescu, *The Hadwiger–Nelson problem with two forbidden distances*, arXiv:1805.06055 (2018) | **the reference paper for `χ(ℝ²; {1,d})`, and the two-distance landscape M49–M50's μ-dial is measured against.** *"We find several values of `d`, for which the answer to the previous question is at least 5"* — **lower bounds only**: no periodic upper-bound construction, no triangular-lattice shell, no `{1, √3, 2}`. Relevant because FS-24's G4b now states the μ-dial's target as a theorem about exactly this quantity (`six_le_chromaticNumber_oneTwo_of_forced_sqrt3`, ledger row 60), and G7b puts an upper bound of the same shape in the kernel (`χ(ℝ²; {1, √(3/2)}) ≤ 9`). Sits beside `[DeNeve2025]`, which is the other two-distance entry and is also lower-bound-only | not held (abstract read) | **abstract read 2026-09-09 (FS-24 P5 prior-art gate)** |`

---

## 3. What I did NOT do, and why

* **I did not touch `DistanceGraph.lean`, though one new lemma belongs there.**
  `coloring_ne_of_dist_mem` — *a proper colouring of a distance graph separates any pair at a nonzero
  listed distance* — is stated for an arbitrary metric space and an arbitrary colour type, and its
  natural home is `DistanceGraph.lean`. It is kept local to `HexShell.lean` with a `--` comment
  saying so, because a declaration added upstream rebuilds `Homogeneous.lean` (package P3's file,
  being edited in this same batch), `Copy.lean` and `Mascot.lean` forever after. **This is a
  deliberate debt and moving it later is a cut-and-paste.** Recommend the coordinator do it in a
  quiet moment, or leave it — it costs nothing where it is except discoverability.
* **I did not mint a `{1, √3}` named instance** to mirror `six_le_chromaticNumber_oneTwo_of_
  forced_sqrt3`. `not_colorable_distanceGraph_of_forced_two` at `D = {1, Real.sqrt 3}` is one line
  for anyone who wants it, and its docstring says so; only the `{1,2}` shape has a measurement
  programme behind it. The asymmetry is documented rather than left as a puzzle.
* **I did not make the hex shell generic over the metric space.** The seven points are a *drawing*
  and the drawing is `ℂ`-valued by construction; a `V`-generic form would have to take the drawing
  as a parameter, which is exactly what `add_one_le_chromaticNumber_distanceGraph_edgeList` already
  is. Noted because it is the obvious next question and the answer is "that theorem already exists".
* **I did not state anything over the field planes** (`K² = ℚ(√3,√11)²` and friends), which is where
  the project's live work is. Same reason: it needs the shell's points transported into a subfield,
  which is a construction, not a relaxation. It is also blocked on FS-24 item G1 (package P3's
  `transport_pair`), so it belongs after that lands, not here.
* **I did not mark `plans/STUB-generalize-the-kernel.md` items G4 and G7b as done.** That file is the
  shared FS-24 stub and other packages are working from it; a banner from me would conflict.
  **Coordinator: G4 (both halves) and G7's second bullet are complete.**
* **I did not add the 41 measured avoidance guards as theorems.** One (`q = 3/2`) is minted because
  the record quotes it; the rest is reported as a measurement over a named enumeration.

---

## 4. Things another package owns, or that need a coordinator decision

* **`scripts/Axioms.lean` — I edited it, and it is shared.** Eighteen `#print axioms` lines for the
  new public surface, in **one contiguous block** placed inside the M35 Brick/Nine region (right
  after `#print axioms nine_avoids_sqrt_three_halves`), which no other package touches — chosen
  specifically to merge cleanly. Leaving the new theorems off the trust receipt would have been the
  "check that fails open" pattern `CLAUDE.md` warns about, so I judged adding them the lesser risk.
  **The clean count therefore rises 725 → 741; the declared purchases stay at exactly 5.** If the
  coordinator prefers, the block deletes cleanly and the count returns to 725.
* **`Proofs.lean` — one import line added** (`Proofs.HadwigerNelson.BrickDistance`), between
  `…Brick` and `…Instances.Nine`. Low conflict risk but worth knowing about.
* **A dangling forward reference in a file nobody owns.** `DistanceGraph.lean`'s module docstring
  says the edge-list reduction is *"consumed by the certified `{1,2}` six-forcer
  (`Instances/OneTwo`)"* — **that module was never built.** M49 priced its certificate at ~50 million
  proof hints and deferred it (ledger row 44), so the reference has been dangling since. Not a bug;
  worth a one-line correction whenever someone is in that file. I picked up the intended vocabulary
  in the name `six_le_chromaticNumber_oneTwo_of_forced_sqrt3`.
* **`Instances/ResidueObstruction11.lean` (package P4) imports `HexShell.lean`** and therefore
  rebuilds. It uses only `hexShell`, `hexShellEdges`, `hexShell_valid`, `hexShell_p3_dist` and
  `hexShell_p4_dist`, all unchanged, and the full build is green — but the coordinator should expect
  that rebuild at merge.
