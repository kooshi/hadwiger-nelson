# FS131-I8D — wave 8, the semi-hub rows' second module and the outer-adjacency row

*Job FS131-I8D (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8d` (cut from `fs131-w8b` at `6e0cf10d`). Brief:
`data/fs131/briefs/FS131-I8D-wave8-semihub.md` (on `main`). The plans: `plans/FS131-w8-kernel-plan.md` (the planner's record, Stages
6–10) and `plans/FS131-I8B-implementation.md` (the join job's record, its section "For the two implementers who start from here").
Working files: `data/fs131/i8d/`. Tools: `tools/fs131_i8d_*.py`.*

## Theorems this phase proved

*Filled stage by stage; each line is read against its row. Until the wave's join every leaf here that cites a statement of
`Plane/RingCalculus/SemiHub` rests on that module's open leaves (FS131-I8C's, proved in a tree of its own): the line says which.*

(none yet — Stage 1 is the readback)

## Stage 1 — SAVED (FS131-I8D): the readback, the branch built as given

### 1.1 What I may and may not change

- **May**: the proofs of the six open leaves of `Plane/RingCalculus/SemiHubPlaces` and of `outerAdj` in `Plane/RingCalculus/Empty`;
  helper declarations under names no other module declares; a new module of my own beside them, with its `Proofs.lean` and
  `ARCHITECTURE.md` lines; docstrings; a block "FS131-I8D" in `scripts/Axioms.lean` above the PURCHASED banner; this record;
  `tools/fs131_i8d_*.py`; `data/fs131/i8d/`; `data/fs131/reports/FS131-I8D.md`.
- **May not**: any statement or definition; the shared module `Plane/RingCalculus/StarChart` (a change to it is a message to the
  coordinator); `Plane/RingCalculus/SemiHub` (FS131-I8C's); the wave's other modules; any landed module; `main`; an `axiom`;
  `native_decide`; a merge of another branch; the gate.

### 1.2 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i8d_quotes.py` (the form of the join job's `tools/fs131_i8b_quotes.py`, which is another job's and is not edited) reads
every `> …` block of the brief with its `> — source:` line and looks for the text, whitespace collapsed, in the source:
**27 quotations, 27 found verbatim, 0 missing** (`data/fs131/i8d/logs/quotes.log`, exit 0). Planted fault (`--fault`, one letter of the
first quotation changed): exit 1, one `MISS`, the other 26 `ok` (`data/fs131/i8d/logs/quotes-fault.log`).

One note on the sources, not a defect of wording: the fourteen quotations of statements are first lines of longer signatures, and the
seven of the plan are headings; each was read whole (§ 1.3, § 1.4).

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record, Stages 6–10 whole (§ 7.4 on `outerAdj`; § 8.3 the statements against their rows; § 8.4 the attacks; § 9.1 the
  three carrying lemmas; § 9.3 the six routes and the case table of `semiHub_places`; § 9.4 the plan for `outerAdj`; §§ 9.5–9.8).
- The join job's record: Stages 2–5 and "For the two implementers who start from here" whole (its seven notes on what will not go as
  the plan writes it).
- The wave's modules in this tree, in full: `Plane/RingCalculus/Basic`, `Star`, `SemiHub`, `SemiHubPlaces`, `SoleTip` (the template for
  `outerAdj`); of `Empty` the header and the section of `outerAdj`; of `Plane/LocalMap` the vocabulary (ll. 60–300: cones, germs,
  ring arcs, (Q), change points, hubs).
- The rows' entries (`data/fs131/k8/rows-extract.md`: FS116-N3-SEMI, FS116-N3-CROSS, FS116-RING-TRANSFER-QC, FS129-SR3-OUTERADJ) and
  their arguments: `plans/FS116-N3-proof.md` §§ 2.1–2.4, 3.1, 3.2; `plans/FS116-V5-verification.md` §§ 3.2–3.4;
  `plans/FS129-SR3-audit.md` Stage 3 whole (§ 3.1).

### 1.4 The leaves as the kernel has them

`#check @…` on the seven leaves and on eight shared lemmas, from the built modules (`data/fs131/i8d/logs/leaf-signatures.log`):
**every hypothesis of every leaf is a binder of its kernel statement** — the two modules declare only `{k}` and `{F}` as section
variables, and each leaf's printed type carries `F.Valid`, `F.NonSiamese` and every named hypothesis of its source text, in order.
No leaf lacks a hypothesis its row reads (inventory item 556's check); nothing to message.

### 1.5 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, log `data/fs131/i8d/logs/build-1-as-given.log`:
"build: OK — all 1812 modules already up to date, nothing built, 3 module(s) with warnings", `EXIT=0`. `rg -c "^\s*sorry"` on
`Proofs/HadwigerNelson/Plane/RingCalculus/`: `SemiHub` 17, `SemiHubPlaces` 6, `Empty` 1 — 24 leaves, seven of them this job's.

## Stage 2 — SAVED (FS131-I8D): the statement defect and its ruling; `crossed_no_tip`, `crossed_outer`, `crossed_four`

### 2.1 The first two leaves, and the re-pricing the brief asks for

`crossed_no_tip` and `crossed_outer` closed at first elaboration, over one composition minted once (`crossed_star_data`: the two
sub-arc lemmas and `fullSemiHub_star_crossed`): 30 and 22 lines against 120 and 80 priced. **Re-priced from them**: a leaf whose
route exists costs a quarter to a third of its price here; the whole of `SemiHubPlaces` is one job, and `outerAdj` rides with it if
the budget holds. Two routes are shorter than the plan's: a tip's exclusion from `t_a'`, `t_b'` needs no C1 (both cones hold the
star's edge `e₃`, more than `90°` from `ψ`: `cos_nonneg_of_mem_coneAt`), and `crossed_outer` needs no "four distinct colours" child
(the tile of an outer colour is one of the star's four).

### 2.2 The statement defect (sent to the coordinator; ruled)

**Found** at the third leaf: `crossed_four`, `crossed_changePoint`, `crossed_semiHub`, `semiHub_places` and the planner's `transferQC`
read "`p` has exactly four colours" and were stated with `(h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2)`.
Wave 3's `germS_absent` gives `(F.coloursAt p).ncard + 2 = k` — two colours absent, so four present only at `k = 6` — and every route
goes through a statement of `SemiHub` that asks `ncard = 4`. The sharp case, in Lean (`data/fs131/i8d/scratch/k6_remark.lean`,
elaborated clean, `data/fs131/i8d/logs/k6-remark.log` empty): under `crossed_four`'s hypotheses its conclusion
`(F.coloursAt (ringPt p ψ))ᶜ = {a, b}` implies `k = 6`; at `k ≥ 7` the leaf as written claimed that no such configuration exists,
which no row does (FS116-N3-CROSS's *not claimed*: "anything at k ≥ 7"). No counterexample map is held: unprovable as stated, not
shown false. The planner's sentence the slip comes from: `fullSemiHub_star_crossed`'s docstring, "four colours by `germS_absent`".

**Ruled** (the coordinator's message, 2026-10-06; its inventory number is the coordinator's to give): form (i) — the five statements
take `(h4 : (F.coloursAt p).ncard = 4)` in place of `(h4 : 4 ≤ (F.coloursAt p).ncard)`, `hk` kept; a docstring clause on each naming
the class and why. Done exactly so:

- `tools/fs131_i8d_stmt.py` (the form of the wave's statement check, over the ten modules of the ring calculus; elaborated
  signatures, never text) against `6e0cf10d` with `--expect` the five names: 235 base declarations compared, **5 changed — exactly the
  five**, 2 added (`crossed_star_data`, `crossed_coloursAt`), exit 0 (`data/fs131/i8d/logs/stmt-2-vs-6e0cf10d.log`).
- `tools/fs131_i8d_binders.py` on that log: each of the five is its base statement with `4 ≤ (F.coloursAt p).ncard` replaced by
  `(F.coloursAt p).ncard = 4` and nothing else (`binders-2.log`, exit 0); planted fault (`= 5` expected): five `MISMATCH`, exit 1
  (`binders-2-fault.log`).
- The statement check's self-test (`stmt-selftest.log`, exit 0): each of the three planted faults (a hypothesis altered in `Empty`, an
  `include` adding `0 = 1 →` with the text unchanged, a binder added to `star_recip`) adds exactly its culprit to the changed set. The
  join job's self-test judged a control by exit 1 alone, which the already-changed `star_anti` gave it; this one compares sets.

### 2.3 `crossed_four`, at the ruled statement

`y` has no tip (`crossed_no_tip`), so by `star_coloursAt` its colours are the two absent at `p` and its outer colours, which lie in
`{a', b'}` (`crossed_outer`): four colours need both. The absent pair is `P ∖ {a', b'}` with `P = {a, a', b, b'}` and `a ≠ a'`,
`b ≠ b'` (`crossed_coloursAt`: the star's first and third, second and fourth tiles are distinct tiles of `p`, one per colour).
About 40 lines against 80.

### 2.4 The save

- Build: `data/fs131/i8d/logs/build-2-crossed-three.log` — "build: OK — 468 of 468 batches, 2 module(s) rebuilt, 3 module(s) with
  warnings", `EXIT=0`; the full log's `declaration uses sorry` lines are in `SemiHub` (17 leaves), `SemiHubPlaces` (3:
  `semiHub_places`, `crossed_changePoint`, `crossed_semiHub`) and `Empty` (1).
- **Axioms, with the debt beneath each record named** (`tools/fs131_i8d_axioms.py`, `axioms-2.txt`, `axioms-2.verdict`): my leaves
  cite statements the sibling implementer proves in a tree of its own, so `#print axioms` shows `sorryAx` and cannot say whose. The
  tool prints, per record, its axioms and its *sorry roots* (the declarations beneath it whose own term mentions `sorryAx`, with their
  module), and passes a record only if every root is in `Plane/RingCalculus/SemiHub`. Six records, each on the standard three and
  resting besides on open leaves of `SemiHub` only — four distinct: `GermOnQWith.exists_isRingArc_ccw`, `…_cw`,
  `fullSemiHub_star_crossed`, `qcol_inner_tile` (the first, second and fourth are proved on `origin/fs131-w8c` at `1e605b60`). The
  planted control (a theorem proved by `sorry` in the scratch file) prints `sorryAx` with itself as its one root; `--fault` (the
  control audited) exits 1 naming it (`axioms-2-fault.verdict`).
- `./scripts/dupnames.sh`: OK, exit 0 (`dupnames-2.log`). My helper names scanned by declaration keyword on `origin/fs131-w8c`,
  `-w6`, `-w7`, `-w9`, `main`: no hit; the scan fires on a known name of the sibling's. The sibling's names (the coordinator's relay)
  are declared nowhere here.
