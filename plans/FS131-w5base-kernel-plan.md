# FS131-KB — the base of row 134 with unit arcs: the plan of `row134BaseUA`'s proof

*de Bruijn, the planner (FS131-KB), 2026-10-04. Brief: `data/fs131/briefs/FS131-KB-base.md` (main tree). Branch `fs131-w5b` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5b`), from `fs131-w5` at `764cc558`. The model this record follows is `plans/FS131-kernel-plan.md`
§ 6; wave 5's vocabulary is `plans/FS131-w5-kernel-plan.md` §§ 2, 8, 10.*

## Theorems this phase proved

None: a planning job. The base's leaves are stated with `sorry`; no row is proved.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "197. **Ruling on F-BASE: the unit-arc statement stays, as an intermediate `Prop` proved inside FS-131 — not as the outside hypothesis.** Choice: K5's unit-arc" | `plans/FS131-close-inventory.md` item 197 (**main tree**, l. 1379; this branch's copy is older and ends before item 177) | verbatim (truncated, marked) |
| "Inventory item 197: the unit-arc statement of the base is wave 5's intermediate `Prop` **`Row134BaseUA`**, proved inside FS-131 (`row134BaseUA`," | `data/fs131/k5/STUB-row134-base-lean.md` § What stays outside (identical on `fs131-w5` and here) | verbatim (truncated) |
| "(b) **`NoInertNear` (exclude only inert arcs not ending at `u`?) is the base planner's call**, since `Row134BaseUA` is an intermediate of ours and the" | inventory item **199** (b) (the brief says "the ruling" without its number) | verbatim (truncated) |
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |

No mismatch. Two slips of address, harmless: the inventory quoted is the main tree's (the branch's copy predates item 177), and the `NoInertNear`
ruling is item 199 (b). The agent file's pointer "`.claude/agents/debruijn.md` § Building Lean" (from `RUNNING.md` § Building) names a section that
does not exist; `LEAN.md` § Building holds that text.

### 1.2 What I am planning, and what I may change

**Planning:** the proof of `row134BaseUA : Row134BaseUA` (`Plane/ValidMap/Dense`; the `Prop` in `Plane/ValidMap/Chain`) as named lemmas with `sorry`
at every leaf, in new modules under `Plane/ValidMap/`; a plan per leaf; the obligation pass; the implementer's handoff. **I may change:** the layout,
the leaves' names and cut, `Dense.lean` only to move `row134BaseUA` and its four consumers downstream of the base (statements unchanged),
`NoInertNear` (after a message), `Proofs.lean`, `ARCHITECTURE.md`, my block of `scripts/Axioms.lean`. **I may not change** any wave-4/5 statement
(`pair_*`, `fail_*`, `anti`, `noBoth`, `cor3`, `p17_ua`, `bv_*`, `rot_*`, `hex_regular`); where the walk needs one in another form, that is a finding.

### 1.3 The as-given build

`764cc558` under the slot (40 GiB, 8 cpus, `BATCH=4`): § 1.4 when it lands (driver log `data/fs131/kb/build-asgiven.log`).
