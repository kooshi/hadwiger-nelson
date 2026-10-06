# FS131-IA1 — the arc step's groundwork (`exists_arcStep`): the record

*de Bruijn, the implementer, on branch `fs131-w5a` (cut from `fs131-w5c` at `ebb0b292`). Brief: `data/fs131/briefs/FS131-IA1-arc-step.md` (on
`main`'s tree). Working files: `data/fs131/ia/`. Tools: `tools/fs131_ia_*.py`.*

## Theorems this phase proved

(Filled stage by stage; each line: the declaration, its module, its axioms.)

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
