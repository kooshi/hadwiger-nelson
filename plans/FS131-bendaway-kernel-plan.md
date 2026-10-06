# FS131-KA1 — the outward collar bend planned (`bend_away_part`): the record

*de Bruijn, the planner, on branch `fs131-w5a` (at `78eba0b4` when the job began). Brief: `data/fs131/briefs/FS131-KA1-bend-away.md` (on
`main`'s tree). Working files: `data/fs131/ka/`. Tools: `tools/fs131_ka_*.py`.*

## Theorems this phase proved

See the last saved stage's list (kept current at each stage).

## Stage 1 — SAVED (FS131-KA1): the readback, the as-given build, what I plan and what I may change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ka_quotes.py` (IA1's checker copied under this job's prefix) on the brief: **19 quotations, 0 failures**, exit 0
(`data/fs131/ka/quotes.txt`); its self-test plants a one-letter change in the first quotation and exits non-zero naming it
(`data/fs131/ka/quotes-selftest.txt`: "19 quotations, 1 failures", "SELF-TEST: FIRED (good)"). No mismatch.

### 1.2 Read for this job

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building.
- `BendStep.lean` whole (341 lines); IA1's record `plans/FS131-arcstep-implementation.md` whole (Stages 1–4); inventory items 433–434, 437–438.
- The toward bend's modules: `RadialPush.lean` l. 1–260 and 692–825 in full and the rest by statement; `CollarMap.lean` l. 1–250 in full and
  the rest by statement, with `CollarFit.map`, `map_lens`, `map_agreesOff`, `map_valid`'s routes; `Pushforward.lean` by statement (its header in
  full); `BendCollar.lean` l. 239–605 in full (the collar's choice: `collarK_thin`, `exists_lens_clear`, `branch_transversal`,
  `branch_tangent`, `exists_end_free`, `exists_collar_free`, `exists_collarFit`) and the rest by statement.
- `UnitArc.lean`: `cutArcs` and its lemmas, `toward_clear`, `away_clear`, `away_lens_clear`'s head, `r2Contacts`, `bend_away_whole`'s statement
  and opening, the `n2_env_*` statements, `isoFrag`.
- `plans/FS131-E5-derivation.md` Stage 4 whole (§§ 4.1–4.4) and §§ 2.4–2.5; `plans/FS112-N-proof.md`'s rows N2-AWAY and N2-TAN (the two quoted
  rows; stage N2-3's prose **not read beyond them** — E5's Stage 4 restates the argument with the exact threshold, and I re-derived the
  clearance from it, § 2.3).
- `fs131-w4ba` at `71cca146`: `bend_away`'s statement and docstring (`git show`); it adds no lemma about `r2Contacts` beyond this branch.
- **Not read**: `plans/FS131-collar-kernel-plan.md` and `plans/FS131-collar-C-implementation.md` beyond what the four modules' docstrings quote
  of them (the modules are the plan as landed; budget).
- Definitions read at their sources: `ArcMap`, `Γ`, `interiorPts`, `region`, `coloursAt`, `Valid`, `IsPlaneMap` (`Plane/ArcMap`); `OnRingArc`,
  `innerColours`, `outerColours`, `IsRingArc` (`Plane/LocalMap`); `HasDegree`, `HasRepeatedColour`, `hornSet`, `IsHorn`, `radiusTwoArc`, `IsR2Arc`,
  `AgreesOff`, `RingArcsWithin` (`ValidMap/Basic`); `LocalStep` (`Limit`); `HasHornCount` (`OpenMove`); `IsSectorChart`, `isSectorChart_of`
  (`LocalStructure`); `Near`, `exists_near`, `germArc` (`Surgery`); `Near.sector_eq_hornSet_iff`, `Near.hasHornCount_chart` (`OpenMove`).

### 1.3 The as-given build (`78eba0b4`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1789 modules already up to date, nothing built,
3 modules with warnings, exit 0** (`build/gate/build/20261006T051724Z-1269351.log`; driver log `data/fs131/ka/build0.log`). The five warnings
are `declaration uses 'sorry'`: `BendStep` l. 285 (`CollarFit.map_hornCount_le`), l. 307 (`bend_away_part`); `Procedure` l. 795, l. 812;
`Terminal` l. 3592 — IA1's Stage 4 state.

### 1.4 What I am planning, and what I may change

**Planning**: the proof of `bend_away_part` (`BendStep.lean` l. 307) — on a valid plane map, the away bend of a constant-sided unit arc whose
inner colour is absent at the centre, everywhere but on its radius-2 contacts, as the image of the map under a homeomorphism supported in a
collar — laid out as named children with `sorry`; and the second open child `CollarFit.map_hornCount_le` (l. 285).

- **May**: `BendStep.lean` (the two open children's proofs; `bend_away_part`'s statement only after a message to Keryx — except the horn
  clause, pre-ruled, item 438 (b)); new modules upstream of `BendStep`, with `Proofs.lean` and `ARCHITECTURE.md`; **new declarations only** in
  `RadialPush`, `CollarMap`, `Pushforward`, `BendCollar`, `UnitArc`; a block "FS131-KA1" in `scripts/Axioms.lean` above `=== PURCHASED ===`;
  this record; `tools/fs131_ka_*.py`; `data/fs131/ka/`; the report.
- **May not**: any landed statement or definition; `Procedure.lean`, `Terminal.lean`, the move modules, `main`; a merge; the gate. No `axiom`,
  no `native_decide`.

## Stage 1 — SAVED (FS131-KA1)
