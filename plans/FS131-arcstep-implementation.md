# FS131-IA1 — the arc step's groundwork (`exists_arcStep`): the record

*de Bruijn, the implementer, on branch `fs131-w5a` (cut from `fs131-w5c` at `ebb0b292`). Brief: `data/fs131/briefs/FS131-IA1-arc-step.md` (on
`main`'s tree). Working files: `data/fs131/ia/`. Tools: `tools/fs131_ia_*.py`.*

## Theorems this phase proved

All in `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean`, namespace `HadwigerNelson.Plane.ArcMap`; each **[kernel]** on
`[propext, Classical.choice, Quot.sound]` (Stage 4's print, `data/fs131/ia/IAAxioms4.out`):

- `r2_notMem_region` — no radius-2 point over a constant-sided unit arc of a valid map lies in the inner colour's class.
- `radiusTwoArc_inter_dom_subset_Γ` — an (R2) witness arc lies in `Γ` wherever it lies in the domain.
- `radiusTwoArc_disjoint_openArc` — a witness arc misses the open part of a free unit arc.
- `isR2Arc_of_fixed` — **question (5)** (FS131-KL1's; `exists_arcStep`'s last clause): a bend by a homeomorphism fixing `Γ` off the open arc keeps (R2) arcs.
- `CollarFit.map_isR2Arc` — question (5) for the collar bend.
- `IsRingArc.free_of_isClean` — the collar bend's `hfree` from cleanness.
- `CollarFit.map_isClean` — the collar bend of a clean map is clean.
- `CollarFit.map_degree_le` — the repaired degree clause of `exists_arcStep` for the collar bend, where it is read.
- `Γ_eq_of_degree_clause` — no-go for the withdrawn degree clause (not a claim about a live theorem).

Stated, **not proved** (`sorry`): `CollarFit.map_hornCount_le`, `bend_away_part`. Found, at **[hand]**, one mind: `exists_arcStep`'s degree
clause false at every instance (D1; its kernel half is the no-go above and `CollarFit.degree_openArc` with `map_lens`); its bad-count
clause false on a fragment with infinitely many bad arcs (D2). Both ruled by Keryx (2026-10-06): the repaired statement is Stage 3.6.

## Stage 1 — SAVED (FS131-IA1): the readback, the as-given build, what I may change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ia_quotes.py` (a copy of IR1's checker under this job's prefix) on the brief: **17 quotations, 0 failures**, exit 0
(`data/fs131/ia/quotes.txt`); its self-test plants a one-letter change in the first quotation and exits non-zero naming it
(`data/fs131/ia/quotes-selftest.txt`: "17 quotations, 1 failures", "SELF-TEST: FIRED (good)"). The nine inventory lines are the head lines of
items 427, 421, 420, 424, 416, 385, 411, 372 on `main`'s `plans/FS131-close-inventory.md`; the two lines of `exists_arcStep` are `Procedure.lean`
l. 812 and l. 821 at `ebb0b292`; the three plan rows are KL1's § 3.1 and § 3.3 and IR1's § 17.3 in `plans/FS131-limit-kernel-plan.md`; the
three bends' first lines are `UnitArc.lean` l. 3776, l. 3968 and `fs131-w5`'s `BendCollar.lean` l. 1403. No mismatch.

### 1.2 Read for this job

- `exists_arcStep` whole with its docstring, and its one consumer `exists_procStep` (`Procedure.lean` l. 1046–1171), clause by clause.
- KL1's §§ 3.1, 3.3; IR1's Stages 14–17; E6's § 4.4 row and § 4.5's owed clause (`plans/FS131-E6-derivation.md` l. 386–397, 445–453).
- `UnitArc.lean`: `bendCol`, `bend_hlc`, `bendMap` and its seven lemmas, `toward_clear`, `away_clear`, `bend_toward`, `bend_away_whole` (proofs read).
- `fs131-w5` at `8ca5fc67`: `bend_toward_collar` whole; `CollarMap.lean` (`CollarFit`, `homeo`, `collarArcs`, `map`, `map_Γ`, `map_lens`,
  `map_agreesOff`); `Pushforward.lean`'s outline; `BendCollar.lean`'s header.
- `fs131-w4ba` at `71cca146`: `bend_away`'s statement and docstring, and `iso` (FS112-ISO).

### 1.3 The as-given build (`ebb0b292`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — 457 of 457 batches, 10 modules rebuilt, 5 with
warnings, 9 min 48 s, exit 0** (`build/gate/build/20261006T042652Z-914089.log`; driver log `data/fs131/ia/build-stage1-asgiven.log`). Every
warning is `declaration uses 'sorry'`: `Procedure` 2 (l. 795 `exists_vertexStep`, l. 812 `exists_arcStep`), `Terminal` 1 (l. 3592), and, not
this line's, `BaseDense` 3, `BendCollar` 1, `HexRing` 1 (this branch's stale copies; `fs131-w5` proved them, Stage 2 brings them).

### 1.4 What I may and may not change

- **May**: the merge's files; a new module `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` with its `Proofs.lean` line and
  `ARCHITECTURE.md` row; **new declarations only** in `UnitArc.lean`; a block "FS131-IA1" in `scripts/Axioms.lean` above `=== PURCHASED ===`;
  this record; `tools/fs131_ia_*.py`; `data/fs131/ia/`; the report.
- **May not**: any statement or definition anywhere; `Procedure.lean` beyond what the merge brings; `Terminal.lean`; the move modules; `main`;
  `fs131-w5c`; the gate. No `axiom`, no `native_decide`.

### 1.5 Found at the reading, sent to Keryx at once (by message, 2026-10-06)

Two clauses of `exists_arcStep` are false as stated (hand grade, one mind; details in Stage 3):

- **D1 — the degree clause** `(∀ x m, F.HasDegree x m → F'.HasDegree x m)`: an interior point of the bent arc has degree `≥ 2` in the clean
  map `F` and degree `1` after any bend; with both maps clean the clause forces `Γ' = Γ`. Its consumer reads it only at the points of `T`
  (`exists_procStep` l. 1146, `intro x _`). Proposed: `(∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, F'.HasDegree x m')`.
- **D2 — `F'.badCount P < F.badCount P` on fragments**: the step assumes `Valid` and `IsClean` only, and on a punctured disc carrying
  infinitely many maximal bad arcs of `ω(P)` both counts are `⊤`. Proposed: add `(hP : F.IsPlaneMap)`.

## Stage 1 — SAVED (FS131-IA1)

## Stage 2 — SAVED (FS131-IA1): `origin/fs131-w5` (`8ca5fc67`) merged into `fs131-w5a`

`git merge --no-ff --no-commit origin/fs131-w5` at `661cafaf` (one merge base, `385b5ad3`). **The merge commit is `90030972`** (parents
`661cafaf`, `8ca5fc67`). Git merged `Proofs.lean`, `ARCHITECTURE.md` and `BaseDense.lean` by itself; **two conflicts**, both of the brief's
expected meetings and both resolved keep-both, ours first, one blank line between: `scripts/Axioms.lean` (this line's wave-5 blocks, then
`fs131-w5`'s "FS131-CC1 …" blocks, above `=== PURCHASED ===`) and `plans/FS131-I5-implementation.md` (Stages 52–55, then 56–59). No conflict
beyond the brief's list; `HexRing`, `BaseWalk`, `BendCollar`, `RadialPush`, `CollarMap`, `Pushforward` are `fs131-w5`'s blobs.

### 2.1 The checks

- **Files, byte for byte** — `tools/fs131_ia_merge_check.py` (IR1's tool copied under my prefix with this merge's refs, `KEEP_BOTH` grown by
  the I5 record and `BaseDense.lean`, and this merge's plants): **PASS, 15,866 files**, on the index before the commit
  (`data/fs131/ia/merge-check.txt`) and on `90030972` (`merge-check-committed.txt`). `--self-test`: a byte in `BendCollar.lean`, a token in the
  merged `BaseDense.lean`, a line added to `Procedure.lean`, `Proofs.lean`'s `Pushforward` import dropped, a doubled axioms record
  (`exists_preBend`), a both-changed file outside `KEEP_BOTH` — **each FIRED naming its file**, the unplanted run PASS
  (`merge-check-selftest.txt`). *Slip of my own, caught by the check*: I had staged my two new tools before the first run, and it failed on
  exactly those two paths (not in any of the three trees); unstaged, they are committed after the merge.
- **Statements, three-way** — `tools/fs131_wl_mergestmts.py 661cafaf 8ca5fc67` (WL1's, run unchanged): **7,681 names, 0 mismatches or
  conflicts, 0 base conflicts — PASS** (`mergestmts.txt`); `--plant` (`CollarFit.collarArcs_nondegenerate`'s merged statement altered):
  MISMATCH, exit 1 (`mergestmts-plant.txt`).
- **No declaration twice** — `tools/fs131_ia_dupes.py 661cafaf 8ca5fc67 385b5ad3` (IR1's/M6's tool with plants that are new at `8ca5fc67`):
  **0 NAME pairs** (no name is declared on both lines, so nothing collides in one environment) and **3 STATEMENT pairs** — one statement
  under two names, one on each line (`dupes-premerge.txt`, exit 1 as the tool must):
  `finite_arcs_inter_compact` (`Limit` l. 39) = `finite_arcs_meeting_compact` (`BaseDense` l. 397);
  `HasDegree.eq` (`OpenMove` l. 47) = `HasDegree.unique` (`Pushforward` l. 105);
  `IsRingArc.union` (`Procedure` l. 132) = `IsRingArc.union_of_overlap` (`BaseDense` l. 425).
  None is mine to remove (other jobs' files, no statement changed in this job): held for the coordinator, for wave 5's final sync. Two
  STATEMENT-OLD and seven CONCL candidates are M6's and IR1's known ones plus `IsMaxRingArc.not_regularAt` ~ `IsRingArc.not_regularAt_of_max`
  (same conclusion, different hypotheses: read, not a copy). `--plant`: NAME (`pushforward_Γ` re-declared), STATEMENT and STATEMENT-NORM
  (`hasDegree_iff_of_mem_interiorPts` under new names) **all reported**, the docstring line not (`dupes-plant.txt`, exit 1). *Tool defect of
  my own, caught by the plant*: my first STATEMENT-NORM plant lacked the source file's `variable` line, which the normalized comparison
  reads, and did not fire; fixed and re-run.
- **The map**: `tools/check_architecture.py` PASS (`arch-stage2.txt`).
- **The build** (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 457 of 457 batches, 11 modules rebuilt, 2 with warnings, 10 min 5 s, exit 0**
  (`build/gate/build/20261006T044442Z-1058079.log`; driver log `data/fs131/ia/build-stage2-merge.log`). The three warnings are `declaration
  uses 'sorry'`: `Procedure` l. 795 (`exists_vertexStep`), l. 812 (`exists_arcStep`), `Terminal` l. 3592 (`stuckRun_ne_univ`); `BaseDense`,
  `BendCollar` and `HexRing` carry none any more (`fs131-w5`'s proofs).
- **Axioms**, against that build's oleans (`data/fs131/ia/IAAxioms2.lean` → `IAAxioms2.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`,
  exit 0; read by IR1's `tools/fs131_ir_axsum.py … --expect-sorry exists_procStep,exists_terminalSeq,exists_terminalMap,exists_vertexStep,
  exists_arcStep`, `IAAxioms2-summary.txt`, PASS): **12 records, 7 on the standard three, 5 through `sorryAx`, 0 other.**
  `bend_toward_collar`, `exists_collarFit`, `exists_preBend`, `bv_l3`, `exists_open`, `exists_clean`, `LocalStep.cleanKeep` on
  `[propext, Classical.choice, Quot.sound]`; **`exists_terminalSeq`'s dependence is as IR1 left it**: on `sorryAx` through `exists_procStep`,
  which cites the two steps; `exists_terminalMap` follows. **Controls**: `exists_vertexStep` and `exists_arcStep` are on `sorryAx` in the
  print; with `exists_arcStep` left off the expectation list the summarizer exits 1 naming it (`IAAxioms2-control.txt`); its `--self-test`
  passes (`axsum-selftest.txt`).

No statement of either side changed; no `axiom`, no `native_decide`.

## Stage 2 — SAVED (FS131-IA1)

## Stage 3 — SAVED (FS131-IA1): the reading — `exists_arcStep` clause by clause against the bends

### 3.1 The three bends as they stand

| bend | where | what it exports | what is hidden or missing |
|---|---|---|---|
| `bend_toward` (wave 4) | `UnitArc` l. 3776 | `∃ F'`: valid; `AgreesOff` on the open `ε`-neighbourhood; `RingArcsWithin`; no point of `α°` on a unit arc about `P`; regions (only `c'` gains, inside `B̄(P, 1)` near `α`) | the map itself (`bendMap … a L c'`: the cut `cutArcs`, **one chord arc** through the two ends, the cap `L` recoloured `c'`), so `LocalStep`'s `keep`/`new`; every count (degree, horns, sites); nothing at the ends |
| `bend_away_whole` (wave 4) | `UnitArc` l. 3968 | the same with `c` gaining outside `B(P, 1)`; needs `Disjoint (radiusTwoArc …) (closure (region c))` | the same |
| `bend_toward_collar` (wave 5) | `BendCollar` l. 1403 | `∃ M h`: valid; `h` a homeomorphism, the identity off the open `ε`-neighbourhood, fixing `Γ` off `α°`; interior points and colours, `coloursAt`, `HasDegree`, `HasRepeatedColour` carried by `h`; R1 (unit arcs of `M` are `F`'s, same sides), R2 (`F`'s off `α°` survive), R3, no new inert arc | needs `hfree` (`Γ` free near `α°`); the horn count; the arcs (`collarArcs = cutArcs ∪ {collarArcA, collarArcB}`, public through `CollarFit.map`); `h '' dom = dom` (`CollarFit.homeo_image_dom`, not in the statement) |

**The difference that decides.** Wave 4's lens is the cap cut off by one circle through the two ends, which crosses `ω(P)` at a positive angle
there: whatever lies in the cap is recoloured. At an end vertex carrying a germ tangent to the arc on the bent side (a horn) the chord crosses
that germ for every parameter, swallows the horn's tip, makes a new vertex where it crosses, and changes the end's degree; the bent map is
no homeomorphic image of the old one, and "no site created, no count raised" would need a general-position argument over every arc the cap
meets. The collar bend's lens is bounded by circles **tangent** to the arc at its ends inside a collar that meets `Γ` only on the arc
(`CollarFit.free`), and the bent map is the image of `F` under a homeomorphism fixing every vertex: the counts are carried, and a cleaning
is not needed (`CollarFit.map_isClean`, Stage 4). **I build the step on the collar bend, and on a like construction outward.**

### 3.2 The cases of the step (`hnb : ¬ (c ∈ coloursAt P ∧ c' ∈ coloursAt P)`, `hQ`, `hR`)

1. **`c' ∉ coloursAt P`** (in-only or inert): the toward collar bend. `hfree` from cleanness: `IsRingArc.free_of_isClean` (Stage 4).
   `hlen`, `hmax` of `bend_toward_collar` are not read (item 427 (a) removes them); `exists_collarFit` is the entry.
2. **`c' ∈ coloursAt P`, hence `c ∉ coloursAt P`** (out-only), `¬ IsR2Arc`: the radius-2 arc is not wholly in `closure (region c)`.
   Whether or not some of it is (`r2Contacts` empty or not), **the bend this case needs is proved nowhere in a form the step can read**:
   `bend_away_whole` covers the empty case but with wave 4's chord lens (3.1); N2-TAN's tangent bend (`bend_away`, `sorry` on `fs131-w4ba`
   at `71cca146`) covers the rest in the same hidden-map form. The step needs one statement for both: **`bend_away_part`** (3.5).

### 3.3 Clause by clause (toward case, collar bend `M = hfit.map`, `h = hfit.homeo`, `K = collarK`; no cleaning)

| clause of `exists_arcStep` | supplied by | state |
|---|---|---|
| `0 < ε < δ`, with `ε` also so small that `cthickening ε α ∩ T ⊆ α` | `T` locally finite (`hT` on `cthickening (1/2) α`), the finitely many points off `α` at positive distance | assembly |
| `F'.Valid` | `CollarFit.map_valid` | kernel (`fs131-w5`) |
| `F'.IsClean` | `CollarFit.map_isClean` | **kernel, Stage 4** |
| `LocalStep F F' (cthickening ε α)` | `agreesOff`: `CollarFit.map_agreesOff` (closed lens `⊆ K ⊆ thickening ε α`); `keep`, `new`: `collarArcs`, with two lemmas about `cutArcs` not yet written (an arc of `ω(P)` missing `α` is its own piece; a piece that is no arc of `F` lies in an arc of `ω(P)` through an end) | assembly — route in the work list |
| `F.IsModification F'` | `dom`: `rfl`; `RingArcsWithin`: `CollarFit.map_ringArcsWithin`; `coloursAt_subset`: off the closed lens the maps agree; in the lens one colour; on the lens boundary degree `2` (`map_degree_lensCurve`) bounds the colours; at the ends `h` fixes the point | assembly |
| `F'.badCount P < F.badCount P` | R3 (`map_R3`), R1, R2, maximality, `P ∉ K`, the witnesses of `P`'s other arcs at distance `2`; **needs `F.IsPlaneMap`** (D2) for `badCount_lt_top` and `exists_isMaxRingArc` | assembly (`badCount` lives in `Procedure`) |
| `∀ x, F'.IsSite x → F.IsSite x` | repeated colour: `map_hasRepeatedColour`, with `c ≠ c'` on `α°` (`degree_openArc`); horn: the horn clause's chart facts | assembly, after `map_hornCount_le` |
| degree (**repaired**, D1): `∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, F'.HasDegree x m'` | `CollarFit.map_degree_le` (off `K` kept; on `α°` `2 → 1`; ends kept) | **kernel, Stage 4** |
| horn: `∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j'` | **`CollarFit.map_hornCount_le`** — true by hand at every point (3.4), open | **`sorry` child** |
| `∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q` | `Q ∉ K`: `h Q = Q`; `Q ∈ α°`: interior of the lens, colour `c'`, an outer colour of `F` there; `Q` an end: fixed | assembly |
| `… ∧ (F'.coloursAt Q = F.coloursAt Q → F'.badCount Q ≤ F.badCount Q)` | a unit arc about `Q ≠ P` in `Γ` cannot meet `α°` (near it `Γ` is `ω(P)`; two unit circles meet twice: `Arc.finite_inter_sphere_or_eq_circ`), so by R1 and R2 the ring arcs and the maximal ring arcs about `Q` are the same in both maps; (Q) is read on the sides and the colours at `Q`; (R2): **question (5), `CollarFit.map_isR2Arc`** | (5): **kernel, Stage 4**; the count: assembly |

### 3.4 The two clauses that were in doubt

- **The horn clause at an end vertex** (E6's flag; ruling 385 (a)): for the collar bend it holds, by hand (one mind). The bent map's chart at an
  end is `F`'s with the arc's germ's curvature `1` replaced by `1/R` and its direction kept (the lens boundary is tangent to `ω(P)` there); the
  collar's crescent between the circles of radius `R'` and `R''` holds no other germ of that direction (`CollarFit.free`, `exists_end_free`), so
  the order of the germs and the set of indices with `β i = nextβ i` are unchanged, and `Near.hasHornCount_chart` (`OpenMove` l. 1384) reads the
  horn count off those indices. A horn at the end between the arc and a tangent germ stays a horn (its bounding curvature moves from `1` to
  `1/R`, strictly on the same side of the other germ's). **For wave 4's chord bend the clause is not provable as it stands**: the chord
  leaves the end at a positive angle, crosses every germ tangent to the arc on its side, and the horn count there falls while a new
  vertex appears — it is the reason for the choice in 3.1, not a counterexample to the statement (`∃ j' ≤ j` allows a fall).
- **Question (5)** — true for any bend by a homeomorphism fixing `Γ` off `α°`, **proved** (`isR2Arc_of_fixed`, Stage 4). KL1's sketch ("a
  witness cannot cross the open arc: beyond it lies the outer tile") is right in substance but not the argument that closes: the fact that
  does the work is that **a witness arc lies in `Γ`** (`radiusTwoArc_inter_dom_subset_Γ`: a witness point interior to its class would be at
  distance exactly `1` from the arc's inner collar — `r2_notMem_region` needs validity only), and `Γ` near `α°` is `ω(P)` alone, which a
  radius-2 circle meets in finitely many points; so no witness point lies on `α°` (`radiusTwoArc_disjoint_openArc`), the witness meets the
  collar at most at the two ends, and `h` fixes every witness point. For wave 4's chord lens the same lemma would not suffice (its cap is
  not `Γ`-free).

### 3.5 The bend that is missing: `bend_away_part` (sent to Keryx; a planner plans to it)

The statement is `BendStep.lean`'s `bend_away_part` (`sorry`), quoted in the report. Why this form: (a) one statement for the out-only
case whether `r2Contacts` is empty or not — on the gaps of `[θ₁, θ₂] \ C₂` the arc is pushed outward, on the contact intervals it stays
and is (R2) in the new map (`c` only gains, the witness is at distance `2`, off the collar), so `¬ IsR2Arc` gives the drop of `P`'s bad
count and is not a hypothesis of the bend; (b) the clauses are `bend_toward_collar`'s (so the assembly reads both cases through the same
lemmas: `isR2Arc_of_fixed`, the degree and site arguments) plus what that theorem's statement lacks and the step reads: the collar `K`
(compact, within `ε`, meeting `Γ` only on `α`, mapped into itself), `LocalStep F M K`, the horn count carried, `RingArcsWithin`, and for a
point of `α°` "fixed, or interior of colour `c`"; (c) R3 in wave 4's `bend_away` form (what is left on `ω(P)` lies in non-degenerate
contact intervals). `hfree` is a hypothesis (the step has it from cleanness). `F.IsPlaneMap` replaces `bend_away`'s
`radiusTwoArc P θ₁ θ₂ ⊆ F.dom` (items 290–291): the repaired step has it. Its truth is at hand grade, one mind, by the construction in its
docstring; the points I checked: at an isolated contact (FS112-ISO) the two lenses pinch tangentially and the point keeps degree `2` and
horn count `0` (two germs of opposite directions); at a contact end the lens lies between `ω(P)` and the unit circle about the contact, so
its boundary is a circle tangent to `ω(P)` there, of radius above `1`; `C₂` is a finite union of points and intervals on a plane map
(`Arc.finite_inter_sphere_two_or_subset`), so the gaps are finitely many and the pushes compose.

### 3.6 The repaired statement of `exists_arcStep` (rulings on D1 and D2, by message, 2026-10-06), for the assembly

```lean
theorem exists_arcStep (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hmax : F.IsMaxRingArc P θ₁ θ₂ c c') (hQ : ¬ F.IsQArc P θ₁ θ₂) (hR : ¬ F.IsR2Arc P θ₁ θ₂)
    (hnb : ¬ (c ∈ F.coloursAt P ∧ c' ∈ F.coloursAt P)) {T : Set ℂ}
    (hT : ∀ K, IsCompact K → (K ∩ T).Finite) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ε, 0 < ε ∧ ε < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧
      LocalStep F F' (cthickening ε (ringArc P θ₁ θ₂)) ∧ F.IsModification F' ∧
      F'.badCount P < F.badCount P ∧ (∀ x, F'.IsSite x → F.IsSite x) ∧
      (∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, F'.HasDegree x m') ∧
      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j') ∧
      ∀ Q ∈ T, Q ≠ P → F'.coloursAt Q ⊆ F.coloursAt Q ∧
        (F'.coloursAt Q = F.coloursAt Q → F'.badCount Q ≤ F.badCount Q)
```

The consumer's changed lines in `exists_procStep` (`Procedure.lean` at `ebb0b292`): l. 1136 `exists_arcStep hG.valid hG.plane hG.clean hmax hQ hR
hnb hT (show (0 : ℝ) < 1 / 2 by norm_num)`; l. 1146–1151, the `pot_le` bullet:

```lean
    · intro x hx
      obtain ⟨mx, -, hmx⟩ := exists_hasDegree_of_mem_dom (hGd x)
      obtain ⟨jx, hjx⟩ := exists_hasHornCount (hGd x)
      obtain ⟨m', hm', hdeg'⟩ := hdegs x hx mx hmx
      obtain ⟨j', hj', hjx'⟩ := hhorns x jx hjx
      rw [pot_eq hdeg' hjx', pot_eq hmx hjx]
      omega
```

(not compiled by me: `Procedure.lean` is not mine to edit; the two changed lines are the `obtain` of `hdegs` and the `pot_eq` rewrite.)

## Stage 3 — SAVED (FS131-IA1)

## Stage 4 — SAVED (FS131-IA1): `BendStep` — question (5) proved, the collar bend's step forms, two open children; the handover

### 4.1 The module (`Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean`; imports `Limit`, `UnitArc`, `BendCollar`, `OpenMove`; upstream of `Procedure`)

Stated against the repaired `exists_arcStep` (3.6). `badCount`, `IsMaxRingArc` and `treatPts` are `Procedure`'s, downstream, so the forms
here are at the level of ring arcs, (R2), degrees and colours; the counts are the assembly's.

**Proved** (no `sorry`; statements in the file):
- `r2_notMem_region` — in a valid map no radius-2 point over a constant-sided unit arc lies in the inner colour's class (interior
  angles by `ne1_region` against the ring point; the ends by openness). No witness is assumed.
- `radiusTwoArc_inter_dom_subset_Γ` — an (R2) witness arc lies in `Γ` wherever it lies in the domain.
- `radiusTwoArc_disjoint_openArc` — a witness arc (in the domain) misses the open part of any unit arc near whose interior points `Γ` is
  `ω(P)` alone (`Arc.finite_inter_sphere_or_eq_circ` on `Arc.circ Q 2 a b`; an infinite interval of angles; `e` injective on `[a, b]`,
  `l60_le`).
- **`isR2Arc_of_fixed` — question (5)** for every bend by a homeomorphism that is the identity off a set `K ⊆ dom`, fixes `Γ` off the open
  arc and carries `coloursAt`: an (R2) arc of `F` about `Q` whose ring arc survives, the colours at `Q` unchanged, is (R2) in the bent
  map. It applies as it stands to `bend_away_part`'s map.
- `CollarFit.map_isR2Arc` — the same for the collar bend, from `map_R2`, `homeo_eq_self`, `homeo_fix_Γ`, `sub_dom`, `free_open`.
- `IsRingArc.free_of_isClean` — in a clean map `Γ` is `ω(P)` alone near each interior point of a constant-sided unit arc: the collar bend's
  `hfree`, which the step has from `hc`.
- `CollarFit.map_isClean` — the bent map of a clean map is clean: **no cleaning after a collar bend**, so `cleanKeep` is not needed in the
  arc step.
- `CollarFit.map_degree_le` — the repaired degree clause where it is read (off the collar: kept; on the open arc: `2 → 1`; at the ends: kept).
- `Γ_eq_of_degree_clause` — the no-go for the withdrawn clause (its docstring says so).

**Open children** (`sorry`, both stated for a planner or the assembly, routes in their docstrings):
- `CollarFit.map_hornCount_le` — the horn clause for the collar bend, in the arc step's form.
- `bend_away_part` — the away bend with the tangent bend, in collar form.

Spec examples: the no-go at the idle pair; `r2_notMem_region` at `l60Frag`'s ring arc (`l60Frag_valid`, `l60Frag_isRingArc`).
`isR2Arc_of_fixed`'s hypotheses are inhabited by the collar bend (`CollarFit.map_isR2Arc`), `CollarFit`'s by `collarModel` (`BendCollar`).

### 4.2 The build and the receipt

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`), the real one (the lakefile's options in force): **OK — 457 of 457 batches, 2 modules rebuilt
  (`BendStep`, `Proofs`), 3 with warnings, 8 min 5 s, exit 0** (`build/gate/build/20261006T050543Z-1193250.log`; driver log
  `data/fs131/ia/build-stage4.log`; the build before the docstring notes were corrected: `build-stage4-first.log`, also OK). The five
  warnings are `declaration uses 'sorry'`: `BendStep` l. 285 (`CollarFit.map_hornCount_le`), l. 307 (`bend_away_part`); `Procedure` l. 795,
  l. 812; `Terminal` l. 3592. Iteration before it (`lake env lean`, never evidence): one error (a `NeBot` instance), one deprecated name.
- **Axioms** against that build's oleans (`data/fs131/ia/IAAxioms4.lean` → `IAAxioms4.out`, `slot.py --mem 12 --cpus 2 -- lake env lean`,
  exit 0; IR1's `tools/fs131_ir_axsum.py … --expect-sorry CollarFit.map_hornCount_le,bend_away_part,exists_arcStep`, `IAAxioms4-summary.txt`,
  PASS): **13 records — 10 on the standard three or fewer (my nine proved theorems and `bend_toward_collar`), 3 through `sorryAx`, exactly
  the three expected, 0 other.** **Control**: with the horn child left off the expectation list the summarizer exits 1 naming it
  (`IAAxioms4-control.txt`); the three `sorryAx` records are the print's own positive control.
- **The map**: `ARCHITECTURE.md` row `Plane/ValidMap/BendStep`; `tools/check_architecture.py` PASS (`arch-stage4.txt`); with `OpenMove` taken
  out of the row's Imports cell it FAILED naming `Plane/ValidMap/BendStep` (`arch-stage4-control.txt`), then PASS on the restored row.
- **Receipt**: a block "FS131-IA1" of 11 records in `scripts/Axioms.lean`, above `=== PURCHASED ===` (the last two are the open children:
  the gate fails on them until they are proved, as it should).
- **Statements**: `git diff --stat 90030972 -- Proofs Proofs.lean` is `BendStep.lean` (new) and one import line; `UnitArc.lean`,
  `Procedure.lean`, `Terminal.lean` and the move modules are untouched. No `axiom`, no `native_decide`. I ran no gate, merged nothing into
  `fs131-w5c`, touched nothing on `main`, and left no process running.
- **Notes** (LEAN.md § The gate, the inhabitant rule; ruling 427 (d)): the module header names `l60Frag` and `collarModel` for the hypotheses
  they satisfy and says that no Lean model is named for an (R2) witness or for a clean map carrying a ring arc — open gate items.
  *Slip of my own, corrected before the stage was saved*: `isR2Arc_of_fixed`'s first docstring called the collar bend an "inhabitant of
  the hypotheses"; it inhabits the bend's hypotheses, not `hR`.

### 4.3 The assembly's work list — what `exists_arcStep`'s proof in `Procedure` still needs, clause by clause

**0. Statement and imports.** Replace `exists_arcStep`'s statement by 3.6's (rulings on D1, D2) and the two consumer lines in
`exists_procStep`; `Procedure` imports `Plane/ValidMap/BendStep` (its `ARCHITECTURE.md` row). The docstring's "then `exists_clean`" and
"`bend_toward`, `bend_away_whole`" go: the step is a collar bend, uncleaned.

**1. The split.** `by_cases hout : c' ∈ F.coloursAt P`. If not: the toward collar bend (2). If so, `hnb` gives `c ∉ F.coloursAt P`:
`bend_away_part` (3).

**2. Toward (`F' := hfit.map`, `hfit` from `exists_collarFit hF hmax.1 hout (hmax.1.free_of_isClean hc) hε`).**

| clause | from | owed |
|---|---|---|
| `ε` | `ε < δ`, `ε < 1/2`, and `cthickening ε α ∩ T ⊆ α` | the choice: `hT (cthickening (1/2) α)` finite, its points off the compact `α` at positive distance |
| `Valid`, `IsClean` | `hfit.map_valid hF`, `hfit.map_isClean hc` | — |
| `LocalStep` on `cthickening ε α` | `agreesOff`: `hfit.map_agreesOff`, mono in the set; `keep`, `new`: `hfit.map`'s arcs are `collarArcs F P θ₁ θ₂ R = F.cutArcs P θ₁ θ₂ ∪ {collarArcA, collarArcB}` (`rfl`) | **W1** `a ∈ F.arcs → Disjoint a.carrier (ringArc P θ₁ θ₂) → a ∈ F.cutArcs P θ₁ θ₂` (an arc of `ω(P)` missing `α` is its own piece: `m := ⌊(θa − θ₂)/(2π)⌋`, `cutLo`, `cutHi`); **W2** `b ∈ F.cutArcs P θ₁ θ₂ → b ∉ F.arcs → ∃ a ∈ F.arcs, (a.carrier ∩ ringArc P θ₁ θ₂).Nonempty ∧ b.carrier ⊆ a.carrier` (`cutArcs_subset`; a proper piece's arc holds `r(θ₁)` or `r(θ₂)`); **W3** `lensSet P θ₁ θ₂ R ⊆ collarK P θ₁ θ₂ R' R''` (`lensCurve_subset` is on file); the lens boundary's two arcs lie in `lensCurve` (`CollarFit.lensCurve_subset`'s neighbours in `CollarMap`) |
| `IsModification` | `dom`: `rfl`; `hfit.map_ringArcsWithin`; `coloursAt_subset` by place: off the closed lens `coloursAt_eq_of_agreesOn` (`isClosed_closedLens`), in `lensSet` one colour (`map_lens`), on the lens boundary at open angles degree `2` (`map_degree_lensCurve`, `exists_hasDegree_of_mem_dom`), at an end `homeo_fix_Γ` and `pushforward_coloursAt` | the case split |
| `badCount P` drops | the maximal ring arcs about `P` of `F'` are `F`'s other than `(θ₁, θ₂)`: R1 (`map_R1`), R2 (`map_R2`), R3 (`map_R3`); (Q) by the colours at `P` (`P ∉ collarK`: `dist_of_mem_cthickening_ringArc`, `homeo_eq_self`, `pushforward_coloursAt`); (R2) by `hfit.map_isR2Arc`; finiteness `badCount_lt_top hF hP P` | **W5** two maximal ring arcs about `P` with different parameters (starts in `[0, 2π)`) have disjoint open arcs (`IsRingArc.sides_eq`, `IsRingArc.union`, `l60_le`); the `encard` step (`Set.encard_lt_encard`-shaped: a subset missing one element of a finite set) |
| no site created | repeated colour: `hfit.map_hasRepeatedColour` with the place of `h⁻¹ x` (interior: none; on `α°`: `degree_openArc`'s `c = c'`, false in a clean map — `c ≠ c'` from `hc` at a point of `α°` and `free_of_isClean`'s argument); horn: `map_hornCount_le` and **W6** | **W6** "a horn at `x` gives horn count `≥ 1`, and horn count `≥ 1` gives a horn" at a chart (`Near.hasHornCount_chart`, `Near.horn_index`; IR2's vertex step needs the same) |
| degree at `T` (repaired) | `hfit.map_degree_le hF (hx) hm`, `hx` from the choice of `ε` and `hfit.sub_thick` | — |
| horn count | **`CollarFit.map_hornCount_le`** | the open child |
| `Q ∈ T`, `Q ≠ P`: colours | `Q ∉ collarK`: equal; `Q ∈ α°`: `map_lens` gives the one colour `c'`, an outer colour of `F` at `Q` (`hmax.1.2.2`); `Q` an end: fixed | the case split |
| `Q ∈ T`, `Q ≠ P`: bad count | **W4** `Q ≠ P → F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)` (the proof of `radiusTwoArc_disjoint_openArc` with `Arc.circ Q 1 a b`: its second alternative is `Q = P`); then `IsRingArc Q` is the same in both maps (R1, R2), so `IsMaxRingArc Q` is (unfold); (Q) by the colours; (R2) by `hfit.map_isR2Arc`; `Set.encard_le_encard` | W4 and the unfolding |

**3. Away (`bend_away_part`).** The same table through its clauses, with `K` for `collarK`: `isR2Arc_of_fixed` applies verbatim; the degree
clause at a point of `T ∩ α°` by its "fixed, or interior of colour `c`" clause; `P`'s count by the last clause — **W7**: an `M`-ring arc
about `P` inside `α` has every interior angle in a contact interval, so (`r2Contacts` closed in `[θ₁, θ₂]`: `closure (region c)` is closed)
its radius-2 arc lies in `closure (F.region c)`, which is `closure (M.region c)` there (`P + 2e(θ) ∉ K`), and with `c' ∈ coloursAt P`,
`c ∉ coloursAt P` it is (R2) in `M`; and `(θ₁, θ₂)` itself is no ring arc of `M` (`hR` gives a non-contact angle, open, so an interior
one, which is on no unit arc of `M` about `P`).

**4. One assembly for both.** The toward bend satisfies every clause of `bend_away_part`'s conclusion with `K = collarK` (compact:
`isCompact_polarSet_Icc`; `homeo_mem_collarK`; R3 gives the last clause vacuously; "fixed or interior" by `map_lens` with colour `c'` in
place of `c`) except the horn count as an iff. So the shortest assembly states one lemma over those clauses with the gaining colour as a
parameter and proves the arc step from it twice. I did not write that lemma: its statement mentions `badCount`, `Procedure`'s.

### 4.4 Re-pricing

The reading and the module took one session beside the merge. Left for the arc step: the assembly (W1–W7 and the table), **M–H, one
session** — no geometry beyond W1, W2 (parameter arithmetic) and W5; `CollarFit.map_hornCount_le`, **M** (the chart at an end: `F`'s chart
from `localSectors`, one curvature changed, `isSectorChart_of`; `map_degree_end`'s docstring names the surgery, its proof avoids it);
`bend_away_part`, **H, a planner pass then one to two sessions** (the outward collar, the tangent ends at contacts, R1 at a pinch point,
the composition over the gaps).

### 4.5 Drafts for the front page

None: wave 5 is not at its gate and this job ran none. For the filing that does: `exists_arcStep`'s statement changes (3.6) before it is
proved, so no ledger row regrades on it yet; the inventory owes a correction to item 422's remark that the arc step does not share the
vertex step's domain gap (D2), and to KL1's § 3.1 row and § 3.3's `bend_step` row ("then `exists_clean`"; `bend_toward`, `bend_away_whole`):
the step is a collar bend, uncleaned.

## Stage 4 — SAVED (FS131-IA1)

---

# FS131-IA2 — the arc step's assembly upstream of `Procedure`: the record (stages from 5)

*de Bruijn, the implementer, on branch `fs131-w5y` (cut from `fs131-w5a` at `78eba0b4`). Brief:
`data/fs131/briefs/FS131-IA2-arc-assembly.md` (on `main`'s tree). Working files: `data/fs131/ia2/`. Tools: `tools/fs131_ia2_*.py`.
The module: `Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean`. "Theorems this phase proved (FS131-IA2)" is at the end of this part.*

## Stage 5 — SAVED (FS131-IA2): the readback, the as-given build, what I may change, two amendments received

### 5.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ia2_quotes.py` (a copy of IA1's checker under this job's prefix) on the brief: **14 quotations, 0 failures**, exit 0
(`data/fs131/ia2/quotes.txt`); its self-test plants a one-letter change in the first quotation and exits non-zero naming it
(`data/fs131/ia2/quotes-selftest.txt`: "14 quotations, 1 failures", "SELF-TEST: FIRED (good)"). No mismatch.

### 5.2 Read for this job

IA1's record whole (Stages 1–4 above); `BendStep.lean` whole; `CollarMap.lean` whole; `BendCollar.lean`: the header lemmas,
`exists_collarFit`, `degree_openArc` to `map_ringArcsWithin`, `homeo_mem_collarK`, `map_R1`–`map_R3`, `coloursAt_subset`, `map_inert`,
`bend_toward_collar` (statements and docstrings; the proofs of `map_R3`, `map_degree_end`, `map_degree_and_repeated` read);
`Procedure.lean` l. 1–412 and l. 780–1171 (`IsMaxRingArc`, `badCount`, the ring-arc lemmas, `exists_arcStep`, the locality lemmas,
`pot`, `exists_procStep`); the definitions `LocalStep`, `IsModification`, `AgreesOff`, `RingArcsWithin`, `IsSite`, `IsHorn`,
`HasHornCount`, `HasDegree`, `HasRepeatedColour`, `IsRingArc`, `IsQArc`, `IsR2Arc`, `OnRingArc`, `r2Contacts`, `cutArcs`, `Near`,
`Near.horn_index`, `Near.sector_eq_hornSet_iff`, `Near.hasHornCount_chart`; inventory items 429, 430, 433, 437–439.

### 5.3 The as-given build (`78eba0b4`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1789 modules already up to date, nothing
built, 3 modules with warnings, 3 s, exit 0** (`build/gate/build/20261006T053913Z-1329009.log`; driver log
`data/fs131/ia2/build-stage1-asgiven.log`). So the copied `.lake/build` is whole. The five warnings are `declaration uses 'sorry'`:
`BendStep` l. 285 (`CollarFit.map_hornCount_le`), l. 307 (`bend_away_part`); `Procedure` l. 795, l. 812; `Terminal` l. 3592 — as IA1's
Stage 4 left them.

### 5.4 What I may and may not change

- **May**: one new module `Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean` (imports `BendStep`; not imported by `Procedure`) with its
  `Proofs.lean` line and `ARCHITECTURE.md` row; a block "FS131-IA2" in `scripts/Axioms.lean` above `=== PURCHASED ===`; this record from
  Stage 5; `tools/fs131_ia2_*.py`; `data/fs131/ia2/`; `data/fs131/reports/FS131-IA2.md`.
- **May not**: any statement or definition anywhere; `Procedure.lean`, `BendStep.lean`, the collar's four modules (`RadialPush`,
  `Pushforward`, `CollarMap`, `BendCollar`), `Terminal.lean`, `main`; no merge, no gate, no `axiom`, no `native_decide`.

### 5.5 A bound found at the reading: `Procedure`'s ring-arc lemmas are downstream too

`IsRingArc.sides_eq`, `IsRingArc.mono`, `IsRingArc.union`, `ringPt_add_int`, `isRingArc_add_int`, `isCompact_ringArc`,
`dist_of_mem_cthickening_ringArc`, `exists_hasHornCount` and the locality lemmas (`hasDegree_iff_of_agreesOff` …) are declared in
`Procedure.lean` (l. 58–170, 842–915, 1028–1041), so this module cannot cite them, and a copy here under the same name would collide
when `Procedure` imports it. What follows from it: the statements here use no whole turn of an arc's parameters — every "the open arcs
meet" is read on point sets (`ringPt Q '' Ioo a b`), W5 (the one step that needs `isRingArc_add_int` and `IsRingArc.union`) stays with
the last lines in `Procedure` as the brief says, and W6 is stated with the horn count's existence inside it so that it is no second copy
of `exists_hasHornCount`.

### 5.6 Two amendments from the coordinator, received during this stage (2026-10-06, by message)

1. **The horn clause both bends export is the arc step's form**, `(∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j')`: KA1
   took ruling 438 (b)'s weakening; every other clause of `bend_away_part` stays as IA1 wrote it. On this branch `BendStep.lean` still
   carries the iff (I do not edit it).
2. **W1 and W2 are one lemma, KA1's `ArcMap.LocalStep.of_cutArcs`** (its new module `BendAway.lean` on `fs131-w5a`, not yet pushed), to
   be stated here with exactly this signature, as a `sorry` child or proved:
   ```lean
   theorem LocalStep.of_cutArcs {M : ArcMap k} {K : Set ℂ} {S : Set Arc} {P : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
       (hag : M.AgreesOff F K) (harcs : M.arcs = F.cutArcs P θ₁ θ₂ ∪ S) (hS : ∀ a ∈ S, a.carrier ⊆ K)
       (hK : ringArc P θ₁ θ₂ ⊆ K) : LocalStep F M K
   ```
   At the merge the two are one statement and a proof of mine moves to `BendAway`. Also: the other groups first, `LocalStep` last;
   `LocalStep.union` (KA1's, proved there) is not importable yet — not needed here.

## Stage 5 — SAVED (FS131-IA2)

## Stage 6 — SAVED (FS131-IA2): the interface, written before the proofs; the module's skeleton

### 6.1 The module and its skeleton

`Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean` (imports `BendStep`; namespace `HadwigerNelson.Plane.ArcMap`). The skeleton —
the interface and every statement, `sorry` at 26 leaves — elaborates under `lake env lean -DautoImplicit=false
-DrelaxedAutoImplicit=false`, exit 0 (`data/fs131/ia2/arcstep-iter1.txt`: 26 `declaration uses 'sorry'`, nothing else; iteration
only, not evidence).

### 6.2 The interface: `ArcBend F M h K P θ₁ θ₂ c c' g ε` — the weakest clauses the step reads

A `Prop` structure: the bent map `M`, the homeomorphism `h`, the collar `K`, the arc's sides `c` (inner), `c'` (outer), the gaining
colour `g`. Each field, why the step reads it, and how each bend supplies it (toward: `hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R''`,
`M = hfit.map`, `h = hfit.homeo`, `K = collarK P θ₁ θ₂ R' R''`, `g = c'`; away: `bend_away_part`'s conclusion, `g = c`):

| field | statement | read by | toward (`CollarFit`) | away (`bend_away_part`) |
|---|---|---|---|---|
| `ring` | `F.IsRingArc P θ₁ θ₂ c c'` | every clause | `hfit.ring` | its hypothesis `hA` |
| `side` | `g = c ∨ g = c'` | colours at a point of `T ∩ α°` | `Or.inr rfl` | `Or.inl rfl` |
| `valid` | `M.Valid` | `F'.Valid` | `hfit.map_valid hF` | clause 1 |
| `sub_thick` | `K ⊆ thickening ε (ringArc P θ₁ θ₂)` | the step's support; `P ∉ K`; radius-2 points off `K` | `hfit.sub_thick` | clause 3 |
| `sub_dom` | `K ⊆ F.dom` | cleanness; question (5) (`isR2Arc_of_fixed`'s `hK`) | `hfit.sub_dom` | `F.IsPlaneMap` |
| `free` | `F.Γ ∩ K ⊆ ringArc P θ₁ θ₂` | the place of a moved point | `hfit.free` | clause 4 |
| `step` | `LocalStep F M K` | `LocalStep` on `cthickening ε α` (`mono`); `M.dom = F.dom` | `LocalStep.of_cutArcs` with `map_agreesOff` (6.4) | clause 5 |
| `fix_off` | `∀ z ∉ K, h z = z` | everywhere | `hfit.homeo_eq_self` | clause 6 |
| `fix_Γ` | `∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z` | the place of a moved point; question (5) | `hfit.homeo_fix_Γ` | clause 8 |
| `interior` | `∀ z ∈ F.interiorPts, h z ∈ M.interiorPts` | cleanness (`M.Γ ⊆ h '' F.Γ`) | `pushforward_mem_interiorPts_iff` | clause 9, `.1.mpr` |
| `coloursAt` | `∀ z, M.coloursAt (h z) = F.coloursAt z` | cleanness, modification, colours, (Q), question (5) | `pushforward_coloursAt` | clause 10 |
| `degree` | `∀ z n, F.HasDegree z n → M.HasDegree (h z) n` | the degree clause at a fixed point | `hfit.map_hasDegree`, `.mpr` | clause 11, `.mpr` |
| `repeated` | `∀ z, M.HasRepeatedColour (h z) → F.HasRepeatedColour z` | no site created | `hfit.map_hasRepeatedColour`, `.mp` | clause 12, `.mp` |
| `horn` | `∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j'` | the horn clause; no site created | **`CollarFit.map_hornCount_le`** (open, KA1's) | clause 13 in the weakened form (ruling 438 (b), amendment 1) |
| `ringArcsWithin` | `M.RingArcsWithin F` | `IsModification` | `hfit.map_ringArcsWithin` | clause 14 |
| `R1` | `∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d'` | both counts | `hfit.map_R1 hF` | clause 15 |
| `R2` | `∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) → M.IsRingArc Q a b d d'` | both counts; (Q), (R2) kept | `hfit.map_R2 hF` | clause 16 |
| `gain` | `∀ θ ∈ Ioo θ₁ θ₂, h (ringPt P θ) = ringPt P θ ∨ ringPt P θ ∈ M.region g` | degree and colours at a point of `T ∩ α°` | `Or.inr`: `map_lens` at `t = 1` | clause 17 |
| `left` | `∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) → c' ∈ F.coloursAt P ∧ c ∉ F.coloursAt P ∧ P + 2 * e θ ∈ closure (F.region c)` | `P`'s count: what is left of `α` is (R2) | vacuous: `hfit.map_R3` | `hout`, `hin`, and clause 18 at the angle (`θ ∈ Icc a b ⊆ r2Contacts`) |

**Where it differs from `bend_away_part`'s conclusion, and why** (each weaker; nothing is asked of a bend that it does not export):
- **Not read at all**: `IsCompact K` and `∀ z ∈ K, h z ∈ K` (clauses 2 and 7). The step's support is `cthickening ε α`, compact by
  itself, and "a moved point's preimage lies in `K`" needs `fix_off` only.
- **One direction of an iff**: `interior` (and the colour of an interior point is never read — `coloursAt` carries it), `degree`,
  `repeated`.
- **`left` is pointwise, on the `F` side**: the non-degenerate interval of contacts in clause 18 is not read (the ends of a surviving
  sub-arc follow by closedness of `closure (F.region c)`), and the two facts about the colours at `P` are the away case's own
  hypotheses. For the toward bend it is vacuous by R3, so the one family covers both without a case split on the colours at `P`.
- **`sub_dom`** is a field (`isR2Arc_of_fixed` reads `K ⊆ F.dom`); `bend_away_part` has it from `F.IsPlaneMap`.
- **Added**: `ring` and `side`, so that every lemma reads the arc and "the gaining colour is a side colour" off the bundle.

`hfree` (`Γ` free near `α°`) is not a field: the step has it from cleanness (`IsRingArc.free_of_isClean`), and the abstract lemmas that
read it take `hc : F.IsClean`.

### 6.3 The statements over the interface (the skeleton's list)

- **At a ring arc's interior points** (no bend): `IsRingArc.coloursAt_openArc` (`= {c, c'}`), `IsRingArc.sides_ne_of_isClean`,
  `IsRingArc.degree_openArc` (degree `2`; a repeated colour iff `c = c'`; `CollarFit.degree_openArc`'s proof, read without the collar),
  `IsRingArc.disjoint_openArc_of_ne` (**W4**).
- **W6**, as one statement with the count's existence: `exists_hasHornCount_isHorn_iff : v ∈ F.dom → ∃ j, F.HasHornCount v j ∧
  ((∃ α κ₁ κ₂ c, F.IsHorn v α κ₁ κ₂ c) ↔ 1 ≤ j)`.
- **The radius**: `exists_arcStep_radius` (`ε < δ`, `ε < 1`, `cthickening ε α ∩ T ⊆ α`).
- **From `hB : ArcBend …`**: `dom_eq`, `dist_of_mem`, `symm_cases` (a point is fixed, or its preimage is interior or on `α°`),
  `coloursAt_of_notMem`, `coloursAt_centre`, `isClean`, `localStep`, `isModification`, `coloursAt_subset`, `degree_le`, `isSite`,
  `isQArc_of`, `isR2Arc_of` (question (5)), `isR2Arc_left` (**W7**), and the package `arcStep`.
- **The two counts at the ring-arc level**: `maxBad` (one lemma for any centre `Q` whose colours are kept, with the hypothesis `hmeet`:
  a unit arc of `F` about `Q` whose open arc meets `α°` is centred at `P`, has `α`'s sides and lies in `α`), and its two corollaries
  `maxBad_centre` (`hmeet` is `α`'s maximality read on point sets — **W5**, `Procedure`'s) and `maxBad_other` (`Q ≠ P`: `hmeet` is
  vacuous by W4). The maximality of an arc is read in `IsMaxRingArc`'s unfolded last clause, so `Procedure` applies these to
  `hmax.2.2` as they stand.
- **The instances**: `LocalStep.of_cutArcs` (KA1's signature, amendment 2), `CollarFit.ringArc_subset_collarK`,
  `CollarFit.lensSet_subset_collarK` (**W3**), `CollarFit.map_localStep`, `CollarFit.arcBend`, `exists_arcBend_toward`; `ArcBend.of_away`
  (from `bend_away_part`'s conclusion as one conjunction, its horn clause in the weakened form).

### 6.4 `LocalStep.of_cutArcs` fits the toward instance (the check amendment 2 asked for)

`M := hfit.map`, `S := {collarArcA P θ₁ θ₂ R, collarArcB P θ₁ θ₂ R}`, `K := collarK P θ₁ θ₂ R' R''`: `harcs` is `rfl` (`collarArcs`);
`hag` is `hfit.map_agreesOff` weakened from the closed lens to `K` (`lensSet ⊆ K`: W3; `lensCurve ⊆ K`: `hfit.lensCurve_subset`);
`hS` by `collarArcs_carrier` (the two carriers' union is `lensCurve`); `hK`: `1 ∈ [lensProf R' θ, outerProf R'' θ]` at every angle
(`PushProfiles.cases`). Nothing is off in the signature.

## Stage 6 — SAVED (FS131-IA2)

## Stage 7 — SAVED (FS131-IA2): every statement of the skeleton proved; the module holds no `sorry`

### 7.1 What is proved (all in `Plane/ValidMap/ArcStep`, namespace `HadwigerNelson.Plane.ArcMap`; 32 theorems, one structure)

In the brief's order (amendment 2: `LocalStep` last), each group elaborated under `lake env lean` before the next
(`data/fs131/ia2/arcstep-iter2.txt` … `arcstep-iter5.txt`; iteration only — the build and the axioms print are 7.3):

1. **At a ring arc's interior points**: `IsRingArc.coloursAt_openArc` (the colours there are the two sides — no freeness is read: near
   the point `ω(P)` lies in `Γ`, so a class reaches it from inside or from outside), `IsRingArc.sides_ne_of_isClean`,
   `IsRingArc.degree_openArc` (`degree_of_circle`), **W4** `IsRingArc.disjoint_openArc_of_ne` (the proof of
   `radiusTwoArc_disjoint_openArc` with `Arc.circ Q 1 a b`, as IA1 said: the second alternative of
   `Arc.finite_inter_sphere_or_eq_circ` is `Q = P`).
2. **W6** `exists_hasHornCount_isHorn_iff`: at a chart (`Near`) with no germ the count is `0` and no horn exists; with germs the count is
   the number of indices with `β i = nextβ i` (`Near.hasHornCount_chart`), and such an index bounds a horn at every chart radius
   (`sectorBetween_eq_hornSet`, `IsSectorChart.isSector_iff`, `Near.hcol`); a horn always gives count `≥ 1` (it is a member of the
   counted set).
3. **The radius** `exists_arcStep_radius`: the points of `T` in `cthickening 1 α` off `α` are finitely many (`hT`), a closed set
   disjoint from the compact `α` (`Disjoint.exists_cthickenings`).
4. **Validity and cleanness; `LocalStep` on the closed thickening; `IsModification`**: `ArcBend.isClean` (a point of the bent map's `Γ`
   is the image of a point of `F`'s with the same colours), `ArcBend.localStep` (`LocalStep.mono`), `ArcBend.isModification` — **no
   cleanness and no validity is read**: a point of at least four colours in the bent map is fixed, a moved point's preimage being
   interior (one colour) or on the open arc (two; `symm_cases`).
5. **No site created** `ArcBend.isSite` (W6 with `horn`; a repeated colour sits at a fixed point, since a moved point's preimage is
   interior or on the open arc, whose sides differ in a clean map).
6. **Degree, horn and colours at the points off the collar or on the closed arc**: `ArcBend.fixed_or_gain`, `ArcBend.degree_le`,
   `ArcBend.coloursAt_subset`; the horn clause is the field `horn`. The package: `ArcBend.arcStep` (for a set `T` whose points in
   `cthickening ε α` lie on `α`).
7. **The two count clauses at the ring-arc level**: `ArcBend.isQArc_of`, `ArcBend.isR2Arc_of` (question (5), `isR2Arc_of_fixed`),
   **W7** `ArcBend.isR2Arc_left` (a unit arc of the bent map about `P` with `α`'s sides inside `α°` is (R2): `left` at each interior
   angle, the radius-2 points off the collar since `ε ≤ 1`, the ends by closedness), and `ArcBend.maxBad` with its corollaries
   `maxBad_centre` and `maxBad_other`.
8. **The instances**: `CollarFit.ringArc_subset_collarK`, **W3** `CollarFit.lensSet_subset_collarK`, `CollarFit.map_localStep`,
   `CollarFit.arcBend`, `exists_arcBend_toward` (the toward case of the step is `ArcBend.arcStep` and `maxBad_*` applied to it);
   `ArcBend.of_away`.
9. **W1 and W2, as KA1's one statement** `LocalStep.of_cutArcs` — **proved here**, with exactly the signature of amendment 2. `keep`:
   an arc `circ P 1 θa θb` of `F` missing `K` is its own piece at `m = ⌊(θa − θ₂)/(2π)⌋` (`cutLo = θa`; `cutHi = θb`, since otherwise
   `[θa, θb]` and `[θ₁, θ₂] + 2π(m + 1)` share an angle, a point of the closed arc on the arc); `new`: a piece that is no arc of `F` has
   `cutLo ≠ θa` or `cutHi ≠ θb`, so its arc holds `r(θ₂)` or `r(θ₁)`. No length hypothesis is read, as KA1's hand check said. At the
   merge this proof moves to `BendAway` and the copy here goes.

**Changed from IA1's work list, and why.**
- **W1 and W2** are one lemma (amendment 2). **W5 is not here** (the brief; § 5.5): it needs `isRingArc_add_int` and `IsRingArc.union`,
  `Procedure`'s; it is proved in the scratch file of Stage 8, for the last job.
- **W7's second half is not needed** ("`(θ₁, θ₂)` itself is no ring arc of `M`"): `maxBad_centre` says a bad maximal arc of the bent
  map has its open arc off `α°`, and `α`'s own open arc is not off itself.
- **The away bend's contact intervals are not read**, only the contact at the angle (`left`, § 6.2).
- **`coloursAt_subset` of `IsModification` needs neither `map_degree_lensCurve` nor a case split on the lens** (IA1's table): it is read
  at the preimage.
- **The degree clause at a point of `T ∩ α°`** reads `gain` and that `F`'s degree there is `2` (`degree_openArc`).

### 7.2 What rests on what

`CollarFit.arcBend` and `exists_arcBend_toward` rest on the open child `CollarFit.map_hornCount_le` (`BendStep`, `sorry`, KA1's by
ruling 438 (a)) — through the field `horn` alone — and on nothing else open. Every other theorem of the module is closed.
`ArcBend.of_away` takes the away bend's conclusion as a hypothesis, so it rests on nothing open; the step's away case rests on
`bend_away_part` at the call in `Procedure`.

### 7.3 The build and the receipt

- **Build** (slot 40 GiB, 8 cpus, `BATCH=4`), the real one (the lakefile's options in force): **OK — 457 of 457 batches, 2 modules
  rebuilt (`ArcStep`, 2.5 s; `Proofs`), 3 with warnings, 8 min 14 s, exit 0** (`build/gate/build/20261006T055730Z-1436630.log`; driver
  log `data/fs131/ia2/build-stage7.log`). The five warnings are `declaration uses 'sorry'` and none is this module's: `BendStep` l. 285,
  l. 307; `Procedure` l. 795, l. 812; `Terminal` l. 3592. `grep -c sorry ArcStep.lean` is `0`.
- **Axioms** against that build's oleans (`data/fs131/ia2/IA2Axioms.lean` → `IA2Axioms.out`, `slot.py --mem 12 --cpus 2 -- lake env
  lean`, exit 0; IR1's `tools/fs131_ir_axsum.py … --expect-sorry CollarFit.arcBend,exists_arcBend_toward`, `IA2Axioms-summary.txt`,
  PASS): **32 records (32 print commands) — 30 on the standard three or fewer, 2 through `sorryAx`, exactly the two expected
  (`CollarFit.arcBend`, `exists_arcBend_toward`: the open horn child), 0 other.** **Control**: with `exists_arcBend_toward` left off
  the expectation list the summarizer exits 1 naming it (`IA2Axioms-control.txt`).
- **The map**: `ARCHITECTURE.md` row `Plane/ValidMap/ArcStep` (imports `Plane/ValidMap/BendStep`); `tools/check_architecture.py` PASS
  (`data/fs131/ia2/arch-stage7.txt`); on a copy with the row's Imports cell changed to `Plane/ValidMap/Limit` it FAILED naming
  `Plane/ValidMap/ArcStep` (`arch-stage7-control.txt`).
- **Receipt**: a block "FS131-IA2" of 32 records in `scripts/Axioms.lean`, above `=== PURCHASED ===`; the last two rest on the open
  child, so the gate fails on them until `CollarFit.map_hornCount_le` is proved, as it should. I ran no gate.
- **Statements**: `git diff --stat 78eba0b4 -- Proofs Proofs.lean` is `ArcStep.lean` (new, 772 lines) and one import line. No
  statement or definition changed anywhere; no `axiom`, no `native_decide`. **Names**: none of the module's 33 declared names occurs
  as a declaration elsewhere under `Proofs/` (a scan by name), and `Procedure` with `ArcStep` load into one environment (Stage 8's
  scratch file imports both).
- **Notes** (LEAN.md § The gate, the inhabitant rule): `ArcBend`'s inhabitant is the collar bend at `collarModel` (the spec example at
  the module's end), on `sorryAx` through the horn child; for a *clean* map carrying a ring arc — `hc` together with `ring`, the
  hypotheses of `isClean`, `isSite`, `degree_le`, `maxBad*`, `arcStep` — and for a bent map with a maximal bad arc left
  (`maxBad*`'s `hM`, `hmax`, `hQ`, `hR` at once) no Lean model is named: open gate items, with IA1's (ruling 427 (d)).

## Stage 7 — SAVED (FS131-IA2)

## Stage 8 — SAVED (FS131-IA2): the last lines for `Procedure`, compiled in a scratch file

`data/fs131/ia2/ProcedureLastLines.lean` (not a module of the library; it imports `Procedure` and `ArcStep`) holds, in this order:

1. `bend_away_part_weak` — a **stand-in**, `sorry`: `bend_away_part` with its horn clause in the arc step's form (ruling 438 (b),
   amendment 1; this branch's `BendStep` still has the iff). In `Procedure` the call is to `bend_away_part` itself.
2. **W5**, `IsMaxRingArc.meet`: `F.IsMaxRingArc P θ₁ θ₂ c c' → F.IsRingArc P a b d d' → ¬ Disjoint (ringPt P '' Ioo a b) (ringPt P ''
   Ioo θ₁ θ₂) → (d = c ∧ d' = c') ∧ ringPt P '' Ioo a b ⊆ ringPt P '' Ioo θ₁ θ₂` — by `e_eq_e_iff`, `isRingArc_add_int`,
   `IsRingArc.sides_eq`, `IsRingArc.union`, the maximality and `ringPt_add_int`. On the standard three.
3. **`exists_arcStep'`**: the repaired statement of § 3.6, verbatim, proved: the radius (`exists_arcStep_radius`); the split on
   `c' ∈ F.coloursAt P` (away: `bend_away_part`, `ArcBend.of_away`; toward: `exists_arcBend_toward`); `ArcBend.arcStep`; `P`'s count
   by `badCount_lt_top`, `ArcBend.maxBad_centre` with `hmax.meet`, and `Set.Finite.encard_lt_encard`; the count at `Q ≠ P` by
   `ArcBend.maxBad_other` and `Set.encard_le_encard`. `IsMaxRingArc` unfolds by itself where `maxBad_*` read its last clause
   (`hM.2.2`).
4. **`exists_procStep'`**: `Procedure`'s `exists_procStep` with the two changed places — the call (`hG.plane`) and the `pot_le` bullet
   (IA1's lines of § 3.6) — generated from `Procedure.lean` by `tools/fs131_ia2_lastlines.py` (each pattern must occur exactly once;
   `--self-test`: a pattern removed and a pattern doubled both exit 1, `data/fs131/ia2/lastlines-selftest.txt`).

**It elaborates**: `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs131/ia2/ProcedureLastLines.lean`, exit 0,
one warning (the stand-in's `sorry`); its prints: `IsMaxRingArc.meet` on `[propext, Classical.choice, Quot.sound]`, `exists_arcStep'`
and `exists_procStep'` through `sorryAx` (the stand-in and the horn child) (`data/fs131/ia2/lastlines-compile.txt`). **This is
iteration-grade evidence only** — `lake env lean` on a file outside the build; the evidence is the last job's build of `Procedure`.
**Control**: with the withdrawn degree clause `(∀ x m, F.HasDegree x m → F'.HasDegree x m)` put back into `exists_arcStep'`'s
statement the same command exits 1 with three errors (`data/fs131/ia2/lastlines-control.txt`).

**What the last job does in `Procedure.lean`** (the report carries the text): add `import
Proofs.HadwigerNelson.Plane.ValidMap.ArcStep` (and the `ARCHITECTURE.md` row's Imports cell); add `IsMaxRingArc.meet` after
`IsMaxRingArc.not_regularAt`; replace `exists_arcStep`'s statement by § 3.6's and its `sorry` by the lines between `-- BEGIN last
lines` and `-- END last lines` with `bend_away_part` for `bend_away_part_weak`; rewrite its docstring (the step is a collar bend,
uncleaned); change the two places of `exists_procStep`. After the merge of KA1's line, `LocalStep.of_cutArcs` stands in `BendAway`
and here: the copy here goes (its proof moves, if KA1's is still open).

## Stage 8 — SAVED (FS131-IA2)

## Theorems this phase proved (FS131-IA2)

All in `Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean`, namespace `HadwigerNelson.Plane.ArcMap`; each **[kernel]** on
`[propext, Classical.choice, Quot.sound]` or fewer (Stage 7's print, `data/fs131/ia2/IA2Axioms.out`) unless marked:

- `IsRingArc.coloursAt_openArc` — the colours at an interior point of a constant-sided unit arc are its two sides.
- `IsRingArc.sides_ne_of_isClean` — in a clean map the two sides differ.
- `IsRingArc.degree_openArc` — degree `2` there, and a repeated colour iff the sides agree (where `Γ` is `ω(P)` nearby).
- `IsRingArc.disjoint_openArc_of_ne` — **W4**: a unit arc about another centre misses the open arc.
- `exists_hasHornCount_isHorn_iff` — **W6**: the horn count exists, and a horn sits at the point iff it is at least `1`.
- `exists_arcStep_radius` — the step's radius.
- `ArcBend.dom_eq`, `dist_of_mem`, `symm_cases`, `fixed_or_gain`, `coloursAt_of_notMem`, `coloursAt_centre` — the interface's first
  consequences.
- `ArcBend.isClean`, `ArcBend.localStep`, `ArcBend.isModification`, `ArcBend.isSite`, `ArcBend.degree_le`,
  `ArcBend.coloursAt_subset`, `ArcBend.arcStep` — the step's clauses from the interface.
- `ArcBend.isQArc_of`, `ArcBend.isR2Arc_of`, `ArcBend.isR2Arc_left` (**W7**), `ArcBend.maxBad`, `ArcBend.maxBad_centre`,
  `ArcBend.maxBad_other` — the two count clauses at the ring-arc level.
- `LocalStep.of_cutArcs` — **W1 and W2** (FS131-KA1's statement).
- `CollarFit.ringArc_subset_collarK`, `CollarFit.lensSet_subset_collarK` (**W3**), `CollarFit.map_localStep`.
- `ArcBend.of_away` — the away bend's conclusion supplies the interface.
- `CollarFit.arcBend`, `exists_arcBend_toward` — the toward collar bend supplies the interface: **through `sorryAx`**, by the open
  child `CollarFit.map_hornCount_le` alone.

Defined: the structure `ArcBend`. Not in the library (scratch, `lake env lean` only): `IsMaxRingArc.meet` (**W5**), `exists_arcStep'`,
`exists_procStep'` (Stage 8).

## Drafts for the front page (FS131-IA2)

None for `CLAUDE.md`: wave 5 is not at its gate and this job ran none; no ledger row regrades (the arc step is `sorry` in `Procedure`
until the last lines land, and then rests on `bend_away_part` and `CollarFit.map_hornCount_le`). For the filing that does: the
corrections IA1 listed (§ 4.5) stand, and `Procedure`'s module docstring (l. 18–23: "`UnitArc` (`bend_toward`, `bend_away_whole`, the
N2-TAN bend) — each cleaned with its colour kept") is wrong for the arc step, which is a collar bend, uncleaned, read through
`Plane/ValidMap/ArcStep`.
