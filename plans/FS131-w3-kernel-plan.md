# FS-131 wave 3 — the kernel plan: arc maps and fragments, Siamese allowed (de Bruijn, the planner, FS131-K3)

*Brief: `data/fs131/briefs/FS131-K3-wave3.md`. Branch `fs131-w3`, worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3`, built
on wave 1's frozen skeleton (`3358a401`). The opening plan is `plans/FS131-kernel-plan.md` (§§ 4–7); this record follows its § 6 form. Nothing in
this milestone is blind (inventory ruling 1).*

## Theorems this phase proved

None: a planning job. The foundation's spec examples and inhabitants (stage 2) are proved, but they are checks of definitions, not theorems of
the backlog.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in" | `plans/FS131-kernel-plan.md` § 7.3, item 3 | **verbatim**, cut mid-sentence: the source goes on "its record against the row." Nothing changed by the cut |
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors (Kooshi, 2026-09-26) | **verbatim**; the source continues "Your predecessor formalized …" |

The brief's row list checked against `data/fs131/k1/dispositions.csv`: the CSV has 21 rows with wave 3 and disposition *formalize*;
less FS116-O1-YESLIM (inventory ruling 6, moved to wave 2) these are exactly the brief's 20. Merged into them (CSV `merged_into`): FS116-N1-TOUCH →
FS129-SR2-TOUCHW; FS116-RING-Q-PRIME → FS116-RING-Q-PRIME-S; FS110-N2-RING, FS110-Y3-GP → FS129-SR1-RINGBAND (the brief's four); and two the
brief does not name, both carried here: **FS112-SIX → FS116-N2-FIVERING and FS129-SR1-SIXQ** (SR1 item 3; FS112-SIX's erratum of 2026-10-03 makes
its two clauses those two rows), and **FS116-RING-TRANSFER-C → FS116-N2-FIVERING and FS116-N2-SIXRING** (ruling R7: its five-colour clause is
FIVERING's content; its six-colour clause is SIXRING's, wave 8). FS129-SR2-YESLIM-EQ goes with FS116-O1-YESLIM to wave 2.

### 1.2 The rows, quoted

Every statement, not-claimed line, uses-only line and merge note is quoted verbatim by `tools/fs131_k3_rows.py` into
`data/fs131/k3/rows.md` (26 sections: the 20 rows and the six merged ones), from `plans/LEAN-BACKLOG.md`, which quotes the derivation files by
script. `python3 tools/fs131_k3_rows.py --check` re-reads the file against the backlog (OK); `--plant` alters one interval in a copy of the backlog
and the check fires (FIRED). Stage 3's read-backs set each formal statement beside its quotation.

| row | derivation address | its object | caution / merge carried |
|---|---|---|---|
| FS116-V5-NE1 | `plans/FS116-derivation.md:1258` | tiles, any `k` | first clause as FS129-SR2-CLOSURE's corollary (SR2 item 9); "in particular" by FS106-DIAM (i) |
| FS116-V4-DICHOTOMY | `:972` | tiles, any `k` | first clause as FS111-M-HULL2's case (SR2 item 10); "A ~ A" by FS106-DIAM (i) (SR2 item 9) |
| FS116-V4-MEET | `:988` | tiles | — |
| FS116-S1-CLUSTER | `:838` | a finite family of tiles | — |
| FS129-OR1-WHOLE | `plans/FS129-derivation.md:577` | the whole-tile restriction `F_ρ` | — |
| FS116-V4-TWIST | `:1003` | the ring, any `k` | — |
| FS116-N1-TWIST-D | `:108` | the ring, any `k` | in place of RING-TWIST-C's first clause and V5-RING's first two (SR2 item 21) |
| FS116-N1-GERM-R | `:414` | a ring point, any `k` | — |
| FS116-N1-GERM-S | `:452` | a change point, six colours | — |
| FS116-RING-Q-PRIME-S | `:475` | a change point | carries FS116-RING-Q-PRIME (SR2 item 21) |
| FS116-N1-QFREE4 | `:490` | a (Q)-free ring | — |
| FS116-N2-FIVERING | `:655` | a five-colour vertex | carries FS112-SIX's five-colour clause, RING-TRANSFER-C's five-colour clause |
| FS129-SR1-SIXQ | `plans/FS129-derivation.md:913` | a vertex carrying all `k` colours | carries FS112-SIX's six-colour clause |
| FS129-SR2-TOUCHW | `plans/FS129-derivation.md:1120` | a touch point | carries FS116-N1-TOUCH (its idle hypothesis dropped) |
| FS116-N1-ECHO | `:528` | a touch point, saturated | filed in reading (B) |
| FS116-V5-U1 | `:1538` | an arc of `Γ` on `ω(z)` | first three clauses in place of FS112-U1's (SR1 item 4); four-colour clause a corollary |
| FS116-Y4-FLANK | `:1686` | one tile at two ring points | TWOCIRC in place of its identity step (SR1 item 1) |
| FS116-S1-EXIT | `:906` | a curve in a lens | — |
| FS116-Y2-SIXFRAG | `:365` | one explicit fragment | the milestone's six-colour inhabitant (opening plan § 7.3 item 5) |
| FS129-SR1-RINGBAND | `plans/FS129-derivation.md:933` | a ℤ/3 circle colouring | caution C137 (RINGWIND's periodicity clauses); carries FS110-N2-RING, FS110-Y3-GP |

### 1.3 The worktree builds as given

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree, at
`3358a401`: **OK — 440 of 440 batches, 8 modules rebuilt, 7 modules with warnings** (wave 1's skeleton: the `declaration uses 'sorry'` warnings),
8 m 13 s, exit 0 (`build/gate/build/20261004T052558Z-1264653.log` in the worktree; the driver's own log `data/fs131/k3/build-stage1.log`).

### 1.4 Registered before the definitions (scored at stage 3)

1. The likeliest defect is not in a row but in the vocabulary: "arc of `Γ` on `ω(p)`", its "side colours", "a germ lies on a (Q) arc" and
   "change point" were never given a point-set meaning, only the map-edge meaning of FS-112's header (an edge between two tiles). Expect at least
   one row whose truth depends on which reading is taken (probability 0.5).
2. Expect most covering hypotheses ("on a closed disc of radius above 1 about p") to be idle in the rows that rest on N-E1 alone (GERM-R, TWIST,
   ECHO), and the rows to hold at any `k` where the derivation spends no colour count (probability 0.8).
3. Expect wave 3 to need part of the local structure of a map at a point — finitely many tiles near a point, every direction in some tile's cone —
   which § 7.1 of the opening plan places in wave 4's foundation (probability 0.7).
4. Expect no row to need wave 2's measurable vocabulary beyond what the foundation already holds (`upperDensityAt`, `essSupport`); ECHO is the
   only row that reads density (probability 0.9).
