# FS131-K5 — wave 5's kernel plan: termination, the stuck chains' ends, row 134's base, density

*de Bruijn, the planner (FS131-K5), 2026-10-04. Brief: `data/fs131/briefs/FS131-K5-wave5.md`. Branch `fs131-w5` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`), from `fs131-w4` at `9a8de899`. The model this record follows is
`plans/FS131-kernel-plan.md` § 6; wave 4's vocabulary is `plans/FS131-w4-kernel-plan.md` §§ 2, 3.2, 14.*

## Theorems this phase proved

None: a planning job. Every row of wave 5 is stated with `sorry` at its leaves; the foundation's definitions carry spec examples only.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |
| "3. **States every row at the class its argument reads** (G92), reports each widening …" | `plans/FS131-kernel-plan.md` § 7.3 item 3 | verbatim (the brief truncates mid-sentence, marked) |
| "4. **Names every hypothesis from outside the backlog** in the declaration's docstring and in § 7.4's list; never imports a hand result of ours as an" | § 7.3 item 4 | verbatim (truncated) |
| "69. **Ruling — FS112-C-DOUBLE moves from wave 4 to wave 5** (K4b, message 2026-10-04): its proof is "a sketch over FS112-Y3-END-NEEDS's levels with n reversed and" | `plans/FS131-close-inventory.md` item 69 | verbatim (truncated) |
| "- **FLANK-Q's discharge obligation** [inventory items 79–80, ruled 2026-10-04]: `flankQ_upper`, `flankQ_lower` take `hQR` — every arc of `Γ` on `ω(N)` (resp." | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.5, first bullet | verbatim (truncated); the same text is in this worktree's copy |
| "191. **Ruling: IWd's slot goes to wave 5's planner (FS131-K5), now.** Choice: launch the planner. Alternative weighed: a second wave-4 implementer on a branch" | inventory item 191 | verbatim (truncated) |

No mismatch. The brief's paraphrase "and FS112-N3-END's chain clause ("and the chain is the single vertex", inventory item 74)" matches item 74's
words ("N3-END's "the chain is the single vertex" not stated (needs wave 5's stuck-chain vocabulary …)").

### 1.2 The rows, the merged rows, the obligations, the caution

The statements are quoted verbatim, each with its address, its errata and merge notes, in **`data/fs131/k5/rows.md`**, generated from
`plans/LEAN-BACKLOG.md` by `tools/fs131_k5_rows.py` (`--check`: OK, 18 rows; `--plant`, one id dropped: FIRED). The backlog copy in this
worktree is byte-identical to `main`'s. The 13 rows (CSV `data/fs131/k1/dispositions.csv`, wave 5, *formalize*): FS114-BV-HEX, FS114-CVB-THOM,
FS112-N3-COR3, FS112-ROTHEX, FS112-N3-BASE, FS112-N3-DENSE3, FS114-CV-EXISTS, FS129-OR1-LOCALDENSE, FS129-SR2-DISC1TS, FS114-CV-HD,
FS112-N2-TERM, FS112-C-ENDS, FS112-C-DOUBLE. Merged and carried: FS112-DISC1 → FS129-SR2-DISC1TS; FS112-N2-RED → FS112-N2-TERM ("RED's
procedure as TERM's lemma", SR2 item 13).

**Caution C116** governs FS112-C-ENDS, -C-DOUBLE, -N3-BASE: C-ENDS is formalized in its erratum's form ("*In a terminal valid map, the point of
the normal line one step beyond each finite end of a stuck chain has at least four colours.*", `plans/FS112-derivation.md:443` item 2);
C-DOUBLE's erratum (item 3) and N3-BASE's (item 5) are regrades only, changing no statement.

**The three obligations from wave 4** (§ 14.5 of its plan; inventory items 69, 74, 79):
1. FS112-C-DOUBLE with **FS112-Y3-END-NEEDS in its corrected form** as a supporting lemma, and the reading of its "terminal valid map" (`M*`
   or wave 4's `Terminal`) settled here.
2. **FLANK-Q unconditional**: `flankQ_upper`, `flankQ_lower` with `hQR` discharged from N2-TERM's clause 1.
3. **FS112-N3-END's chain clause** ("and the chain is the single vertex"), stated with the stuck-chain vocabulary.
And FS114-L60-WALK (merged into L60-LE, R8): its five consumers (FS112-N2-RED, -N3-COR3, -N3-BASE, -N3-DENSE3, FS114-CV-EXISTS) are stated
over `l60_le`'s non-strict bound — none of wave 5's statements reads a strict bound, so this holds by construction; its clause L60-D5 sits in
N3-BASE's setting and goes to the Row134Base job (§ 2.3).

### 1.3 The worktree builds as given

`./scripts/build.sh` under the slot (40 GiB, 8 cpus, `BATCH=4`): the result is in § 2.4 (run in the background while the foundation was
written; driver log `data/fs131/k5/build-stage1.log`).

## Stage 2 — SAVED: the foundation (`debruijn-domain-modeling`, invoked fresh)

### 2.1 The model, and why this shape

One module, **`Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`**, sorry-free, every definition a predicate on wave 4's one `ArcMap`
(extrinsic placement, as waves 3–4):

| group | definitions | the modeling decision |
|---|---|---|
| chains | `StuckAlong v α`, `IsChainVertex v`, `stuckRun v α : Set ℤ` | a chain is **a set of consecutive indices** on the normal line `v + jn`, `n = e(α + π/2)`, not a sequence of maps or a combinatorial path: "bi-infinite" is `= univ`, an upper end `j` is `j ∈ run ∧ j + 1 ∉ run`, "one step beyond" is `v + (j+1)n`. The axis enters once, through `StuckAlong` (a two-sector colour with a horn along `e α`). Seams proved: `zero_mem_stuckRun_iff`, order-convexity (`mem_stuckRun_of_between`), reversal (`mem_stuckRun_add_pi`: `j ∈ run(α+π) ↔ −j ∈ run(α)`) |
| `F(M)`, `R(M)` | `fourSet`, `repSet` | points **of the domain** (a fragment's boundary points are no vertex) |
| terminal maps | `QROnly`, `IsTerminalMap` | `IsTerminalMap = Valid ∧ IsPlaneMap ∧ Terminal ∧ QROnly`: the class of every `M*`, never the limit object itself |
| modifications | `IsModification M F` (structure; `refl`, `trans`) | **what consumers read**, not the moves: same domain, `RingArcsWithin` (no unit arc created), and every point of `≥ 4` colours in `M` carrying them in `F` |
| the base | `BaseHyp u` (`Disjoint (B̄(u, 2)) (F(M) ∪ R(M))`), `NoInertNear u`, `Row134Base` | the base's hypothesis in the foundation's own vocabulary; `Row134Base` a `Prop`, never an axiom |

Refused: a type of chains or of vertices (the rows never need one); the moves as operations whose transfinite composition is `M*`
(each row needs only `M*`'s properties, and the limit is the hard leaf of N2-TERM, § 4); a second, Condition-5 copy of the base.

### 2.2 The definitions the derivations never fixed: the choice, the alternatives, the rows each would change

| term | chosen | alternatives | rows whose statement would change |
|---|---|---|---|
| **chain vertex / "stuck" on a chain** | stuck **with at most three colours** (`IsChainVertex`) — "stuck" as FS112-N2-TERM's trichotomy uses it ("cubic, an NB4P exception with at least four colours, or stuck") and N4-STUCK's hypothesis at the vertex | plain `IsStuck` (a stuck point of four colours would continue a chain); or stuck *along the same axis* | under plain `IsStuck`, FS112-C-ENDS needs "three colours at the end vertex" as an added hypothesis (the end's argument runs N4-STUCK there); under the same-axis reading, C-ENDS is false wherever a neighbour is stuck along another axis (its "end" would be that stuck three-colour point). The choice changes no row's words |
| **"a terminal valid map"** (C-DOUBLE, C-ENDS, CV-HD; inventory item 69's question) | `IsTerminalMap`: wave 4's `Terminal` **and** N2-TERM's clause 1 (`QROnly`) | wave 4's `Terminal` alone | C-DOUBLE's "(Q) in `M*`" step reads clause 1 ("not (R2), hence (Q) in `M*`"); CV-L0 reads it ("a unit arc of `M*` is (Q) or (R2)"). Under `Terminal` alone both need the bends' terminality re-derived. Every `M*` is in the class (`exists_terminal`), so no consumer loses |
| **"valid modification"** | `IsModification` (same domain; no unit arc created; four-colour points keep their colours) | an inductive closure of the moves with a limit step | none: FS114-CV-EXISTS reads exactly the third clause ("a modification creating no unit arc keeps a four-colour vertex's colours at the vertex in the map itself"). **The adversary**: any valid map on the same domain with no unit arcs and no four-colour point satisfies the relation, whatever `F` is; N2-TERM's existence is weaker than "by moves" by exactly that, and no consumer reads more |
| **`Row134Base`** (opening plan § 7.4) | row 134's base at a cubic trichromatic `u` of a **valid six-coloured fragment covering `B̄(u, 2)`, unit arcs allowed**, after the inert pre-bend: `BaseHyp u ∧ NoInertNear u` impossible | (a) the Condition-5 base (S–V Cor. 1 as FS-110 repaired it); (b) an interface form taking the walked steps' conclusions as hypotheses | (a) cannot be used: FS112-N3-BASE's walk replaces Condition 5 inside the base's proof, step by step (`plans/FS112-N-proof.md` N3-BASE table), so the Condition-5 statement does not imply the unit-arc one as a black box (an (R2) arc and a leaving centre's in/out arc survive every bend). (b) is (a) with redundant hypotheses: every walked step is a theorem of waves 4–5 about valid maps, which `Row134Base`'s proof may cite since it takes `F.Valid`. **Consequence: FS112-N3-BASE's Lean content is the pre-bend plus `Row134Base`; the walk's assembly (its table) is the `Row134Base` job's, which uses FS112-N3-PAIRS, -FAIL, -ANTI, -NOBOTH, -COR3, -ROTHEX, FS114-BV-HEX as tools** (sent to Keryx, finding F-BASE) |

### 2.3 Validation and the seams

Spec examples (each fails on drift): `F(M)` of the one-colour plane is `∅`; `repSet`'s membership; `const_qrOnly` (an inhabitant of
`QROnly`); `BaseHyp` unfolded pointwise; `NoInertNear` on the one-colour plane; a non-chain-vertex has an empty run.
**Inhabitants of the structures theorems take**: `IsModification.refl` (every clause); `QROnly`: `const_qrOnly`; `IsTerminalMap`:
`sevenBrickMap_isTerminalMap` at seven colours (a skeleton leaf of `Terminal`, § 4 — the map has no horn, no repeated colour and no
unit arc); `Row134Base` is a hypothesis, not a structure: its control is `not_row134Base_seven` (its seven-colour form is false at the
brick corner — a leaf of `Dense`), so it is not true for a reason that ignores six.
**The unsampled member**: a stuck vertex of four colours (excluded from runs by `IsChainVertex`; N2-TERM's clause 2 puts it in the
four-colour class). **The adversarial member** of `IsModification`: § 2.2. **The next lemma**, named before checking: CV-L0
("a stuck vertex of `M*` centres no unit arc") states as `∀ x, ¬ F.OnRingArc E x` — in the vocabulary.

### 2.4 The builds

Stage 1's build (`data/fs131/k5/build-stage1.log`; its plan already included the new files): every module of the worktree as given
built — 444 of 444 batches walked, wave 4's and wave 3's skeleton modules with only `sorry` warnings, `Chain` with none, `Terminal`
with only `sorry` warnings — and `Dense` failed on an identifier (`q₊` is not a Lean identifier), fixed (`qp`, `qm`). The build of
the skeleton is § 3.3.

## Stage 3 — SAVED (partial): the skeleton and the read-backs, 10 of 13 rows

### 3.1 The skeleton

| module | rows | declarations (`sorry` leaves) |
|---|---|---|
| `Plane/ValidMap/Terminal` | FS112-N2-TERM (+ N2-RED), FS114-CV-HD, FS112-C-ENDS, FS112-C-DOUBLE; FLANK-Q unconditional; supporting `stuck_structure_ua`, `y3_end_needs`, `n3_end_chain` | 14 |
| `Plane/ValidMap/Dense` | FS129-SR2-DISC1TS (+ DISC1), FS112-N3-COR3, FS112-N3-BASE, FS129-OR1-LOCALDENSE, FS112-N3-DENSE3, FS114-CV-EXISTS | 9 |

**Not yet stated (the successor's list, § 5): FS112-ROTHEX, FS114-BV-HEX (four clauses), FS114-CVB-THOM.** Each needs definitions
from records not read in this job (FS-110's N2-ROT and N2-HEX; BASE-V's kept points, H, NoDouble and switch points; Thomassen's map
graph and local Hamiltonicity).

### 3.2 The read-backs (each formal statement against its row, `data/fs131/k5/rows.md`)

Conventions: six colours (`ArcMap 6`) wherever the argument spends six (NB4P, the base, Y3-END-NEEDS's seventh colour, CV-HD's branch
`G_N`); `k` general elsewhere. Frames as wave 4's (`n = e(α + π/2)`, `N = v + n`, `S = v − n`; a horn along `e(α + π)` has `n`
reversed, so its `N`-side arc is its lower arc: "on `ω(N)`" is curvature `−1` there).

| row | declarations | read-back |
|---|---|---|
| **FS112-N2-TERM** | `exists_terminal` | Row: valid modification `M*`, no unit arc created, every unit arc (Q)/(R2); every vertex cubic, NB4P exception with `≥ 4` colours, or stuck; every stuck vertex on a non-bi-infinite chain along its normal line, each finite end within 1 of a (Q)/(R2) arc or NB4P exception, every horn bound `±1` on it a (Q)/(R2) arc; one-sided chains a GAP. Formal: `∃ M, F.IsModification M ∧ M.IsTerminalMap ∧` clause 2 (a point of `≥ 3` colours or a repeated colour is cubic trichromatic, `≥ 4`-coloured, or stuck) `∧` clause 3 for every `v` stuck along `e α` with `≤ 3` colours: run `≠ univ`, every end (upper or lower) within distance `1` of a point on a (Q)/(R2) arc or of `≥ 4` colours, every horn bound `±1` at a run vertex along `±e α` the start of a (Q)/(R2) arc (`HornBoundsQR`, FLANK-Q's form). "NB4P exception" read as "`≥ 4` colours" (NB4P is the only source of four-colour vertices; consumers read the count). "Valid modification" read as `IsModification` (§ 2.2). The GAP clause is not claimed. **Same, with those two readings** |
| FS112-N2-RED (merged) | `exists_red` | Row: a valid modification by W-MERGE and whole-arc bends, no unit arc created, every unit arc (Q)/(R2); terminates with no stubs. Formal: `∃ M, F.IsModification M ∧ M.Valid ∧ M.QROnly`, every `k` (NB4P not read). The procedure and its termination are the proof. **Same, widened to every `k`** |
| FLANK-Q unconditional | `flankQ_upper_of_qrOnly`, `flankQ_lower_of_qrOnly` | wave 4's statements with `hQR` replaced by `F.QROnly` (N2-TERM's clause 1). **Same** (the discharge item 79 asks for) |
| **FS114-CV-HD** | `cv_l0`, `cv_hd_main`, `cv_hd`, `cv_class`; (CV-ENDS) `c_ends` | (CV-L0): in a terminal valid map a stuck vertex (`≤ 3` colours) centres no unit arc, `Γ ∩ ω(E)` finite — **same**, every `k`. (CV-HD): `υ± = 1 ∧ ¬H_S` impossible (`cv_hd_main`), and `G_N ⇔ H_S ⇔ υ± = 1 ⇔ λ± = −1` (`cv_hd`, as three iffs), with `υ± = 1` read `κ₂ = 1 ∧ κ₃ = −1`, `λ± = −1` read `κ₁ = −1 ∧ κ₄ = 1`, `G_N` an in-type contact of the upper flank `g` at `N`, `H_S` of the lower flank `h` at `S` — **same**. The row's "(all four horn arcs unit arcs, in-type flank tiles at both antipodes)" is the content of the equivalence. (CV-CLASS): bowtie case (four conditions, both neighbours `≥ 4` colours and both-kind centres, run `= {0}`) or `g` twice at `S`, `h` twice at `N`, each neighbour stuck or `≥ 4` colours — **same** ("a repeated colour" is the two sectors). Three colours at `E` assumed (`= 3`), as wave 4's `n3_end` (ruling 53's pattern; the stuck vertices of `M*` the argument reads) |
| **FS112-C-ENDS** (C116, erratum form) | `c_ends` | Row (corrected): "In a terminal valid map, the point of the normal line one step beyond each finite end of a stuck chain has at least four colours." Formal: `IsTerminalMap`, `v` stuck along `e α`, `j ∈ run`: `j + 1 ∉ run ⟹ 4 ≤ #P_cl(v + (j+1)n)` and `j − 1 ∉ run ⟹ 4 ≤ #P_cl(v + (j−1)n)`. **Same** (residue deleted, as C116 requires) |
| **FS112-C-DOUBLE** (C116, regrade only) | `c_double` | Row: terminal valid map, stuck `E`, all four horn arcs unit arcs (of `ω(E + n)` above, `ω(E − n)` below) ⟹ in-type tiles of the upper flank colour at `E + n` and the lower at `E − n`, both (Q) centres with `≥ 4` colours. Formal: `IsTerminalMap` (§ 2.2), three colours at `E`, `IsHorn E α (−1) 1 c ∧ IsHorn E (α+π) (−1) 1 c` ⟹ in-type contacts of `g` at `N` and `h` at `S`, `≥ 4` colours at both, and the four horn-bounding arcs (Q) (two arcs of `ω(N)` ending at `E`, two of `ω(S)`). "In-type tile" read as wave 4's in-type contact (`IsContact ∧ InType`). **Same**. Its proof is CV-HD's cycle (`cv_hd`: all four arcs unit ⟹ `G_N ∧ H_S`) and `QROnly` (both side colours at the centre: not (R2), hence (Q)) — FS114-CV's route (two minds), not C2's sketch; the corrected Y3-END-NEEDS enters through `cv_hd_main`'s branch `¬G_N` |
| FS112-Y3-END-NEEDS (supporting, item 69) | `y3_end_needs` | YB3-NEEDS: Y3-END-NEEDS holds when no in-type `h` sits at `E − n`. Formal: terminal valid plane six-map, stuck `E` with three colours, `κ₂ = 1`, `κ₃ = −1`, no in-type `g` at `N`, no in-type `h` at `S` ⟹ `False` (the seventh colour). The form FS114-CVB § 1.6's branch `¬G_N` consumes |
| FS112-N3-END's chain clause (item 74) | `n3_end_chain` | n3_end's hypotheses, its second disjunct (in-type `g` at `N`, `κ₂ = 1`) ⟹ `stuckRun v α = {0}`: neither neighbour is a chain vertex. **Same**, every `k` |
| **FS129-SR2-DISC1TS** (+ FS112-DISC1) | `disc1ts`, `disc1ts_degree`; `disc1_local` | Row: every closed disc of radius 1 of a valid map contains a vertex of degree `≥ 3`, as TS-T's case. Formal: plane map, `∃ y ∈ B̄(x, 1), 3 ≤ #P_cl(y)` (**stronger**: three colours, TS-T's own conclusion) and `∃ y ∈ B̄(x, 1), ∃ n ≥ 3, HasDegree y n` (the row). Every `k`. `disc1_local`: the same on a fragment covering `B̄(x, 1)` (LOCALDENSE's reading of DISC1, "nested surrounding tiles inside `B̄(x, 1)`") |
| **FS112-N3-COR3** | `cor3` | Row: valid map, close complementary pair of cubic trichromatic `u, u′` (disjoint multicolours, `d < 2`) on a unit rhombus `u, q₊, u′, q₋` whose other corners have `≥ 4` colours, each a leaving centre of both, a unit arc of each corner's circle both-kind there. Formal: the two common unit points `qp ≠ qm` of `ω(u)`, `ω(u′)`, each with `≥ 4` colours, `IsLeavingCentre u q ∧ IsLeavingCentre u′ q`, and a both-kind arc centred at `q`. On fragments covering `B̄(u, 1)` and `B̄(u′, 1)`: **a widening**, reported (G-COR3). "T2 is forced at both common unit points" is that configuration (FS-110's T2) |
| **FS112-N3-BASE** (C116, regrade only) | `n3_base` | Row: valid map, `B̄(u, 2)` about cubic trichromatic `u` with no `≥ 4`-colour and no repeated-colour vertex ⟹ row 134's base refutes the map near `u` (inert unit arcs centred within 1 first bent). Formal: `Row134Base →` valid six-coloured fragment covering `B̄(u, 2)`, `IsCubicTrichromatic u`, `BaseHyp u` ⟹ `False`. On fragments (LOCALDENSE's reading). **Same, over the named hypothesis**; § 2.2's consequence for what the row's Lean proof contains |
| **FS129-OR1-LOCALDENSE** | `localDense` | Row: every valid six-coloured fragment on `B̄(x, 3)` has in `B̄(x, 3)` a vertex of `≥ 4` colours or a repeated colour. Formal: `Row134Base →` `F.Covers x 3 → ∃ y ∈ B̄(x, 3), y ∈ F(M) ∪ R(M)`. **Same, over `Row134Base`** |
| **FS112-N3-DENSE3** | `dense3` | Row: every closed disc of radius 3 of every valid map holds a vertex of `≥ 4` colours or a repeated colour. Formal: plane six-map, the same conclusion. **Same, over `Row134Base`** |
| **FS114-CV-EXISTS** | `cv_exists` | Row: every valid map has a vertex of at least four colours, in the map itself. Formal: `Row134Base →` valid plane six-map `→ ∃ x, 4 ≤ #P_cl(x)`. The row's route clauses ("passes through `M*`", "uses neither CV-HD nor C-ENDS, no ray step and no residue") are the proof's, recorded in the docstring. **Same, over `Row134Base`**. FS114-L60-WALK's check for its five consumers: none of wave 5's statements reads a bound on a unit arc's length; their proofs cite `l60_le` (non-strict) only |

### 3.3 The build of this stage

`./scripts/build.sh` (slot 40 GiB, 8 cpus, `BATCH=4`): **OK — 444 of 444 batches, 2 modules rebuilt** (stage 3: `build/gate/build/20261004T180110Z-1247027.log`); after the amendment **OK — 444 of 444, 4 rebuilt, 5 modules with warnings** (wave 3–4 skeletons, `Terminal`, `Dense`; every warning `declaration uses sorry`; `Chain` none), exit 0 (`build/gate/build/20261004T181052Z-1316464.log`; driver log `data/fs131/k5/build-stage5.log`). `tools/check_architecture.py`: PASS, exit 0 (three rows added, § 3.11 of
`ARCHITECTURE.md` beside wave 4's). `scripts/Axioms.lean`: two sections "FS-131 wave 5 (job FS131-K5)" — the foundation's 8 records (clean
expected) and the skeleton's 23.

### 3.4 Findings (sent to Keryx with this stage)

- **F-BASE (a statement-shape decision, for a ruling).** `Row134Base` is stated at the unit-arc class after the pre-bend (§ 2.2); FS112-N3-BASE's
  Lean content is then the pre-bend plus `Row134Base`, and the walk's assembly (N3-BASE's table) is the `Row134Base` job's, using waves 4–5's step
  lemmas as tools. The Condition-5 alternative does not compose (a black-box Condition-5 base does not imply the unit-arc statement).
- **F-WALK5 (backlog completeness, like wave 4's F-NB4).** N4-STUCK (i)–(ii) with unit arcs (FS112-WALK's row 5; FS112-WALK is declined) is read by
  CV-L0, CV-HD, CV-CLASS, C-ENDS, N2-TERM's chain clause and CV-EXISTS; wave 4's `stuck_structure` assumes Condition 5. Formalized here as the
  supporting lemma `stuck_structure_ua`.
- **R-CDOUBLE (inventory item 69's question, settled).** "Terminal valid map" = `IsTerminalMap` (wave 4's `Terminal` and N2-TERM's clause 1). C-DOUBLE's
  proof route is FS114-CV's (C-DOUBLE as a corollary of CV-HD's cycle and clause 1, two minds) rather than C2's sketch; the corrected Y3-END-NEEDS is
  used inside CV-HD's branch `¬G_N` (`y3_end_needs`), so it stays in wave 5 as item 69 ruled.
- **R-CHAIN (a definition reading, no row's words change).** A chain vertex is stuck with at most three colours (§ 2.2); under plain `IsStuck`,
  C-ENDS would need "three colours at the end" as a hypothesis.
- **Generalizations**: G-COR3 (N3-COR3 on fragments covering `B̄(u, 1)`, `B̄(u′, 1)`); G-DISC1 (DISC1TS gives three colours, not only degree 3);
  N3-BASE, LOCALDENSE's base on fragments covering `B̄(u, 2)`; N2-RED, CV-L0, FLANK-Q unconditional and N3-END's chain clause at every `k`.
- **R-MOD (a reading).** "Valid modification" read as `IsModification` (what consumers read); its adversary in § 2.2.
- **Risk (for the implementer and the Row134Base job):** the pre-bend at an inert arc ending at `u` (`bend_toward` moves end vertices).

## Stage 4 — SAVED (partial): the plan per stated leaf; the obligation-modeling pass is owed

*The `debruijn-obligation-modeling` pass was not run in this job (context): the successor planner runs it fresh over § 3's statements before the
implementer starts. Below, a route per leaf from the derivations read in stages 1–3; Mathlib names are not yet confirmed with `#check` (owed with the
pass). E easy, M moderate, H hard.*

**`Plane/ValidMap/Chain`** — sorry-free.

**`Plane/ValidMap/Terminal`**
1. `stuck_structure_ua` — **H**. FS-110's N4-STUCK (i)–(ii) proof with unit arcs: no MERGE at `v` ⟹ `interior (allowedCone v c) = ∅` (the moves'
   preconditions are definitions) ⟹ `woodallCone` (wave 4, unit arcs, `[−1, 1]`) gives the axis, out-type contacts at `v ± n`, horns along `±e α`;
   no RAY ⟹ one horn per ray ⟹ exactly two sectors; three colours ⟹ the two complementary regions are `g` above and `h` below (a second sector of
   `g` or `h` would make a MERGE available — the half-plane cone argument of FS110-N §2.6). Children: `sectors_eq_two_of_noRay`, `halfPlanes_of_three`.
2. `exists_red` — **H**. N2's count (`plans/FS112-N-proof.md` N2-3; NB2-RED): enumerate the unit arcs of `Γ` (countable: local finiteness on a plane
   map); for each, bend (toward if the outer colour is absent at the centre, away if the inner is absent and no R2 blocks; `bend_toward`, `bend_away`)
   or merge at a repeated-colour centre (`exists_merge`); a (Q) or (R2) arc is left. Termination by a locally finite count re-enabled only by a merge
   or a colour lost at a centre. The limit: every point is touched finitely often (each move acts in an `ε`-neighbourhood, `ε` chosen summable and
   inside a locally finite cover), so the maps are eventually constant near each point and their limit is an `ArcMap`. Children: `IsModification` of
   each move (needs **strengthened moves**: every point of `≥ 4` colours after a move had them before — wave 4's `exists_shave` states it at `v` only;
   new children, not statement changes), `limit_of_locallyEventuallyConst` (the limit map and its validity), the count's descent.
3. `exists_terminal` — **H, the wave's hardest leaf.** After `exists_red`, apply W-MERGE, MERGE-RAY, SHAVE (`exists_merge`, `exists_rayMerge`,
   `exists_shave`) at the countably many vertices with a repeated colour, a horn or a non-degenerate allowed cone; each removes a sector and adds
   only rim points of `≤ 3` colours (FS110 N4-TERM's enumeration); bends re-applied where a move exposes a non-(Q)/(R2) arc (none: moves create no
   unit arc, `RingArcsWithin`). Clause 2 from `Terminal` and the sector charts (`exists_hasDegree_of_chart`); clause 3: not bi-infinite by `n4_fin`
   along the curvature sequence (`stuck_structure_ua` at each run vertex, horn bounds strictly inside `(−1, 1)` off the ends by `cv_l0`'s argument,
   N4-SHADOW's inequalities `shadow_farSide_above/_below`); the ends' clause from N4-STUCK (iii)–(iv)'s failure (FS112-N2-4); `HornBoundsQR` from
   `flankQ_upper_of_qrOnly`/`_lower_` and `IsHorn.isRingArc_upper` (wave 4's engine 5).
4. `flankQ_upper_of_qrOnly`, `flankQ_lower_of_qrOnly` — **E**: wave 4's `flankQ_upper`/`_lower` with `hQR := fun θ₁ θ₂ d d' h => hQR _ _ _ _ _ h`.
5. `cv_l0` — **M**: a unit arc of `ω(E)` is (Q) (needs `≥ 4` colours at `E`, against `≤ 3`) or (R2) (its outer colour at `E`; U1's cone, wave 4's
   `u1_shadow`/the U1 wedge, has width `π − ℓ < π`, but `stuck_structure_ua` puts `g`, `h` on open half-planes and `c` on two antipodal horns).
   Finiteness: local finiteness on the compact `ω(E)` and each non-unit arc meeting a circle in at most two points.
6. `cv_hd_main` — **H**: CVB § 1.6, two branches: `G_N` (six named colours at `N` — `c, g, h, r₊, r₋, x₁` — and a seventh `x₂`, each distinctness
   by no MERGE: `interior (allowedCone) ≠ ∅` otherwise); `¬G_N` by `y3_end_needs`.
7. `cv_hd` — **M** over leaf 6: `G_N ⇒ υ± = 1` (Siamese: the flank lies in `B̄(N, 1)`, `flank_siamese_of_inType`, `flankQ_both`), `H_S ⇒ λ± = −1`
   (mirror by reflection `α ↦ α + π`), `υ± = 1 ⇒ H_S` (leaf 6), `λ± = −1 ⇒ G_N` (leaf 6 at `α + π`, `g ↔ h`).
8. `cv_class` — **M**: leaf 7; the bowtie case by `QROnly` (both side colours at `N` ⟹ not (R2) ⟹ (Q) ⟹ `≥ 4`), neighbours centre unit arcs so are
   not chain vertices (`cv_l0`); otherwise CVB § 1.4 item 5's separation at `N`, `S`.
9. `y3_end_needs` — **H**: YB3 § 3.1 Steps 1–4 (`plans/FS112-YB3-verification.md`), Y3 § 3.3's levels: `h` two sectors at `N` (no SHAVE at `E`,
   FLANK's list), out-type `h` at `N + n` (no MERGE at `N`), horns at `N` with flanks `x₁ ≠ x₂` and lower flank `y`, then `z₁ ≠ z₂` at `N + n` outside
   a five-set: seven colours in `Fin 6`.
10. `c_ends` — **M**: `cv_class` at the end vertex (three colours: `IsChainVertex` and `stuck_structure_ua`); bowtie case: the neighbour has `≥ 4`;
    else it has a repeated colour and is not a chain vertex: not stuck (then not terminal unless `≥ 4`: clause 2 of `exists_terminal`'s reasoning —
    here from `Terminal` directly: a repeated colour with no move is stuck) or `≥ 4` colours.
11. `c_double` — **E–M**: `cv_hd` (all four arcs unit ⟹ `G_N`, `H_S`); the four arcs are ring arcs (`IsHorn.isRingArc_upper`) whose side colours
    `g`/`c` (resp. `h`/`c`) are carried at the centre (in-type `g` at `N`; out-type `c` at `N`), so not (R2), so (Q) by `QROnly`, so `≥ 4`.
12. `n3_end_chain` — **M**: NB3's N3-END item 1 at `v + n` (a chain vertex there would need `c` to fill its `+n` side); at `v − n`, `c` is an
    out-contact colour of `ω(v − n)` (U1's cone `< π`) against a chain vertex's colours (half-planes, antipodal horns) — both via `stuck_structure_ua`.
13. `sevenBrickMap_isTerminalMap` — **M**: valid, plane (proved in wave 4); no repeated colour and no horn at any point (by periodicity, three point
    types: interior, edge, corner — `sevenBrick_corner_interior` generalized), so no move's precondition; no arc of `Γ` on a unit circle (bricks of
    side `4/5`, `3/5`: segments only), so `QROnly` vacuously.

**`Plane/ValidMap/Dense`**
14. `disc1ts` — **E**: `ts_t` with `ε = 1 − 1/√2`. 15. `disc1ts_degree` — **E**: 14 and `exists_hasDegree_of_mem_dom`.
16. `disc1_local` — **M–H**: NB2's nested surrounding tiles (each of diameter `< 1`, FS106-DIAM's `dist_lt_one_of_forall_dist_ne_one`) inside
    `B̄(x, 1)`; local finiteness ends the nesting at a point of three colours. Alternative: TS-T's region argument read on the fragment — check whether
    it reads only `B̄(x, 1)`.
17. `cor3` — **H**: N3 stage N3-3 / NB3-COR3: N-E1 at `u` puts `Ω`'s half on `u′`'s clean side in `Γ` (both-kind at `u`, against `noBoth`), so the
    strips fail at `q±` (leaving centres, `fail_leavingCentre`), then `fail_colours` at both gives `s_in`, `s_out` at `q`, four colours; the both-kind
    arc at `q` from the two sides. Children: `common_unit_points` (two points at distance 1 from both, `0 < d < 2`).
18. `n3_base` — **M–H**: the pre-bend (finitely many inert arcs centred in `B̄(u, 1)`: local finiteness on `B̄(u, 2)`; `bend_toward` each, with a
    strengthened child "no point of `B̄(u, 2)` gains a colour or a sector"), `BaseHyp` and `IsCubicTrichromatic u` preserved, then `hB`. Risk § 3.4.
19. `localDense` — **M**: `disc1_local` gives `y ∈ B̄(x, 1)` with `≥ 3` colours; `≥ 4` ⟹ `fourSet`; three with a repeated colour ⟹ `repSet`; three,
    none repeated ⟹ cubic trichromatic (degree = colours, the sector chart) ⟹ `n3_base` on `B̄(y, 2) ⊆ B̄(x, 3)` gives the point.
20. `dense3` — **E**: 19 on the plane.
21. `cv_exists` — **M** over `exists_terminal`, `dense3`, `stuck_structure_ua`, `n4_fin`: CVB § 1.4 items 1–7 (with no `≥ 4`-colour vertex in `M*`,
    every run is bi-infinite, against clause 3), then `IsModification.coloursAt_subset`.
22. `not_row134Base_seven` — **M**: the brick corner `0` (`sevenBrick_corner_isCubicTrichromatic`), `B̄(0, 2)`'s points have `≤ 3` colours and no
    repeated colour (leaf 13's point types), no unit arc.

**Price** (re-price from the first two leaves): leaves 2–3 (the limit construction), 6, 9, 17 are hard; the rest easy or moderate. Estimate, to be
scored: two implementer sessions for these 23 leaves, plus the three rows still to state.

## Stage 5 — SAVED: what is left, and the handoff

### 5.1 The successor planner's list (in order)

1. **State FS112-ROTHEX** (read `plans/FS110-N-proof.md` l. 374, 393 for N2-ROT and N2-HEX; NB3 §1.4 step 10, §2.2 #7): the two ring lemmas with
   unit arcs under the base's hypothesis, P17's only unit-arc exception a both-centre `x₂`, N2-ROT's "no `r`-tile at `x`" over `cor3`.
2. **State FS114-BV-HEX's four clauses** (read `plans/BASE-V-verification.md` § Theorems this phase proved): BV-HEX (Lemma 6's `< 9` branch under H —
   fix "kept points", "the regular hexagon", H), BV-L3 (Lemma 3 at cusps: "proper finite circle colourings in the complementary triple"), BV-ND (NoDouble
   with unit arcs at cusps), BV-ND1 (switch points of `ω(u)` at distance 1, opposite senses). Wave 3's `Plane/CircleColouring` likely holds the circle
   vocabulary.
3. **State FS114-CVB-THOM** (read `plans/FS114-CVB-verification.md` § 1.9; the CSV's reason: "as the list of [Thomassen1999]'s steps other than the
   rainbow step, each stated for valid maps with Siamese pairs allowed"): the reduced map graph `H` of a valid map (holes filled, facial cycles as
   boundary walks, local finiteness), its local Hamiltonicity, and Thomassen's Lemma 1 (a connected, locally finite, locally Hamiltonian graph with at
   least 13 vertices has a vertex of degree `≥ 6`) — an outside theorem: formalize (Mathlib's `SimpleGraph`) or an axiom with the four items.
4. **Run `debruijn-obligation-modeling` fresh** over §§ 3 and 5.1's statements; confirm § 4's Mathlib names with `#check`; extend § 4 to the new rows.
5. **Write § 14's handoff** (the form of wave 4's plan § 14): the vacuity carriers (recommendation: **IN** for `IsTerminalMap` and `QROnly` — refutable on
   a map with an inert unit arc, inhabited by `sevenBrickMap_isTerminalMap` and `const_qrOnly`; **OUT** for `IsModification` (a conclusion), `BaseHyp`,
   `NoInertNear` (hypotheses of a refutation)), what the implementer may change (children; strengthened moves as new lemmas; never a statement of § 3.2
   or a definition of `Chain`), and the landing (after wave 4: merge `fs131-w4` or `main`, the full gate).

### 5.2 Inhabitants and vacuity, as stated so far

Structures theorems take: `IsTerminalMap` — `sevenBrickMap_isTerminalMap` (leaf 13, seven colours); `QROnly` — `const_qrOnly`; `IsModification` —
`refl` (only in conclusions). Local hypotheses of the stuck-vertex theorems (`cv_*`, `c_double`, `y3_end_needs`, `n3_end_chain`, `stuck_structure_ua`):
`bowtie` at `0` on a fragment; on terminal plane maps no model is known (`GENERIC`: FS-115's question), as wave 4's `stuck_chain`, `n3_end`. Refutations
(skipped by the scan): `cv_hd_main`, `y3_end_needs`, `n3_base`. `cor3`, `localDense`, `dense3`, `cv_exists`: `GENERIC` (no valid six-coloured fragment of
radius 3 and no valid six-map of the plane is known; the rows' own model lines say so). `Row134Base`: a named hypothesis; control `not_row134Base_seven`.

## Stage 6 — SAVED: the brief's amendment (F-BASE ruled, inventory items 196–197)

1. **The intermediate renamed and proved here.** `Row134Base` is now **`Row134BaseUA`** (`Plane/ValidMap/Chain`), wave 5's intermediate statement
   of the base with unit arcs, not an outside hypothesis. The walk's assembly is the skeleton theorem **`row134BaseUA : Row134BaseUA`**
   (`Plane/ValidMap/Dense`, one `sorry` leaf, its leaves to be laid out by the successor — § 5.1 item 0), and `n3_base`, `localDense`, `dense3`,
   `cv_exists` no longer take a hypothesis: `n3_base` is the pre-bend plus `row134BaseUA`. The control is renamed `not_row134BaseUA_seven`.
   **Statement change scheduled, not yet made**: when the successor names the outside pieces (item 2 below), each becomes a hypothesis of
   `row134BaseUA` and of the four consumers.
2. **Which pieces of `[SokolovVoronov2025]` the walk uses by statement, and which it reads inside a proof.** On FS112-N3-BASE's table (`plans/FS112-N-proof.md`
   N3-3, read in full): (P) sweep — inside (no Condition 5); (P′) — inside (N3-P′); D2's strip, S–V Prop. 10 — inside (N3-FAIL); the pseudo-colouring
   facts — inside (N3's sub-lemmas); (i) — inside (N3-I); (ii), Lemma 3's swaps and endpoints, CE7, **S–V Lemma 5, Prop. 18** — inside (each reads (ii),
   replaced by N3-II); Cor. 3 — inside (N3-COR3); CE5 — inside (N3-ANTI); **Prop. 17** — inside (FS112-ROTHEX, row 12's both-kind exception); D5's
   reduction R1–R4, the 10 + 1 count, hole-filling, **Lemma 4 at cusps** (CUSP-BASE) — inside (generic centres moved off unit-arc centres); the eleventh
   point — inside (N-E1); **Lemma 6's `< 9` branch** — FS114-BV-HEX, a wave-5 row (BASE-V: "BV-HEX reads the map"); **Lemma 3** at cusps — BV-L3, a
   wave-5 clause. **So the second list is the whole argument as far as the table shows: no piece is used purely by statement.** The base is ours to
   formalize; Keryx's stated option applies (its own planner job in this milestone). Unconfirmed: FS110-CB, -CD, -CE, -CC and BASE-V not read here; a
   pure circle-colouring lemma cited from the paper without re-proof would be the one kind of by-statement use to look for.
3. **The stub rewritten** (`data/fs131/k5/STUB-row134-base-lean.md`): it covers nothing outside, provisionally (item 2), and its body is kept as the brief
   for the in-milestone job formalizing `row134BaseUA`.

**§ 5.1 gains an item 0**, first in order: lay out `row134BaseUA`'s leaves (CB's route D1–D6 by line, CE's R1–R4, CD's Theorem D2, CUSP-BASE, S–V
Lemmas 3–6, Props. 10, 17–19, Cor. 3, each Condition-5 use replaced as the table says) — or hand it to its own planner job if Keryx places it so — and
confirm item 2's list against CB and BASE-V. The obligation pass (§ 5.1 item 4) then covers it.

## Stage 7 — SAVED: FS131-K5b's readback (the second planner resumes here)

*de Bruijn, the planner (FS131-K5b), 2026-10-04. Brief: `data/fs131/briefs/FS131-K5b-wave5.md`. Resuming this record (standing rule 2): its last
SAVED stage is 6 (`git log -- plans/FS131-w5-kernel-plan.md`: `978bdfd4` stage 1, `4cbece6c` stages 2–6); this job continues at stage 7 and redoes
nothing saved.*

### 7.1 The brief's quotations against their sources

| quotation in the brief | source | result |
|---|---|---|
| "1. **State FS112-ROTHEX** (read `plans/FS110-N-proof.md` l. 374, 393 for N2-ROT and N2-HEX; NB3 §1.4 step 10, §2.2 #7): the two ring lemmas with" | this record § 5.1 item 1 | verbatim (truncated, marked) |
| "5. **Write § 14's handoff** (the form of wave 4's plan § 14): the vacuity carriers (recommendation: **IN** for `IsTerminalMap` and `QROnly` — refutable on" | § 5.1 item 5 | verbatim (truncated, marked) |
| "(a) **`row134BaseUA` gets its own planner job inside FS-131 (FS131-KB)**, after wave 5's successor planner has stated ROTHEX and BV-HEX, which the walk" | `plans/FS131-close-inventory.md` item 199 (a) (main tree, l. 1405) | verbatim (truncated, marked) |
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |

No mismatch. The brief's paraphrase of items 2–4 matches § 5.1 items 2–4.

### 7.2 The as-given build

`3f7b5a14` under the slot (40 GiB, 8 cpus, `BATCH=4`): **OK — all 1747 modules already up to date, nothing built, 5 modules with warnings** (every
warning `declaration uses sorry`), exit 0 (`build/gate/build/20261004T182304Z-1409474.log`; driver log `data/fs131/k5/build-k5b-asgiven.log`).

### 7.3 What is mine, and what is not

**Mine (§ 5.1 items 1–5):** state FS112-ROTHEX, FS114-BV-HEX (four clauses) and FS114-CVB-THOM with `sorry` leaves, each read back; the
`debruijn-obligation-modeling` pass over every wave-5 statement with § 4's Mathlib names confirmed by `#check` and § 4 extended to the new rows; § 14's
handoff in wave 4's form. **Not mine (§ 5.1 item 0):** `row134BaseUA`'s leaves, FS131-KB's; I note for KB where ROTHEX or BV-HEX as stated changes
what § 4 assumes of the walk.
