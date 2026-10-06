# FS-131 wave 8 — the kernel plan: the ring calculus in the non-Siamese class

*Job FS131-K8 (de Bruijn, the planner), 2026-10-06, branch `fs131-w8`. Brief: `data/fs131/briefs/FS131-K8-wave8.md`. The milestone's
plan is `plans/FS131-kernel-plan.md` (§§ 7.1–7.5 bind this job). Working files: `data/fs131/k8/`.*

## Theorems this phase proved

Filled at each saved stage; see the last stage's list.

## Stage 1 — SAVED: the readback, the registered expectations, the branch built as given

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |
| § 7.3's items 1–5 (first lines) | `plans/FS131-kernel-plan.md` ll. 560–573 | verbatim, each cut at its first line |
| items 486 and 484 (first lines) | `plans/FS131-close-inventory.md` ll. 4886, 4854 | verbatim |
| "**Wave 8** (22 rows):" and its four bullets | `plans/FS131-kernel-plan.md` ll. 539–543 | verbatim |
| the wave table's row 8 | `plans/FS131-kernel-plan.md` l. 483 | verbatim |

No mismatch. Two facts about the brief's surroundings, neither a defect of it: the inventory in this worktree stops before item 508
(the branch was cut before it was filed), so items 508 and 511–514 were read from `main`'s copy; and the plan's wave-8 list has 22 rows
plus three merged ones, 25 lines of `data/fs131/k1/dispositions.csv` — counted by script, as the brief says.

### 1.2 What was read

- The plan's §§ 7.1–7.5; the CSV's 25 lines for this wave; each row's entry in `plans/LEAN-BACKLOG.md` (extracted by script to
  `data/fs131/k8/rows-extract.md`, 26 entries with FS114-N7-QOPP's), with its cautions, errata and merge notes.
- The definitions: `data/fs116/claims.md` § 13's notation paragraph (tip, outer tile, tip pair, outer pair, hub, semi-hub of kind O
  and T, closed, full, crossed, parallel) and its l. 203 (Γ-free).
- The landed library the rows reuse: `Plane/ArcMap`, `Plane/LocalMap` (both in full), `Plane/SimpleOn` (in full), the statement
  surface of `Plane/RingGerm` and `Plane/Tiles`, and `ARCHITECTURE.md`'s rows for waves 3–5 and the models.
- The arguments read in full: `plans/FS116-N2-proof.md` § 2.1–2.4 (SIXRING, STAR, RECIP, ANTI) and `plans/FS116-V6-verification.md`
  § 2.1–2.2 (the whole route to EMPTY). **Not read in this pass**: the arguments of the nine SemiHub rows
  (`plans/FS116-N3-proof.md`, `plans/FS116-V5-verification.md`), RING-TWIST-C's (`plans/FS116-N1-proof.md` § 2.2) and the two audits
  behind OUTERADJ and DOUBLETIP (`plans/FS129-SR3-audit.md`, `plans/FS129-MR1-audit.md`); those rows are disposed from their entries,
  and § 2 marks each such row.

### 1.3 Registered expectations

Registered after reading the 25 entries' statements and before any argument (the N2 and V6 arguments were opened after this list was
fixed; it is written down here at the first save, which is later than it was formed — the job's slip, disclosed).

- **Short** (provable in this pass or one implementer sitting): FS129-SR3-OUTERADJ, FS129-MR1-DOUBLETIP, FS116-N3-PAIR,
  FS116-V6-COUNT, FS116-N2-ANTI.
- **An outside theorem**: none (the plan's table says none); the risk is plane topology hidden under "the tile lies in the Reuleaux
  triangle" and "the four tiles form a cycle of shared edges".
- **A statement defect**: FS116-N2-SIXRING (five clauses, an existence of an indexing), FS116-N3-STAR2 (windows; degenerate lengths),
  FS116-V5-OUT2 (the CSV already narrows its setting), the V6 lemmas (the class each reads against the class each is filed in); and
  at least one row filed at "radius above 1" whose argument reads the ring of a point of `ω(p)`, hence radius 2.

Scored in the last stage.

### 1.4 The branch as given

`./scripts/build.sh` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`), log `data/fs131/k8/logs/build-1-as-given.log`; its
result is recorded in Stage 2's first lines (the build waited for a slot and was still walking at this save).
