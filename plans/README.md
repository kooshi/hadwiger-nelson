# plans/

The working records, one file per milestone, derivation or job. They are history: the current state is in `../CLAUDE.md` and
`../LEDGER.md`, and the ranked open questions are in `FRONTIER-STUBS.md`.

| file | what it is |
|---|---|
| `STUB-<slug>.md` | a future or open milestone, written so that a fresh reader can plan it |
| `FSnn-<slug>.md` | a milestone's plan (older milestones: `Mnn-…`) |
| `FSnn-derivation.md` | a milestone's derivation file: its theorems proved by hand, one entry each, with grades |
| `FSnn-kernel-plan.md` | the Lean plan for a milestone: statements, skeleton, a route per leaf |
| `FSnn-<job>-<kind>.md` | one job's record (for example `FS131-LGT1-gate.md`, the last full gate) |
| `FSnn-close-inventory.md` | the coordinator's log of a milestone, item by item |
| `LEAN-BACKLOG.md` | the hand results waiting to be formalized, in dependency order |

Grades (`[kernel]`, `[hand]`, `[tools]`, `[cert]`, …) are defined in `../CLAUDE.md` § Notation. Many working terms are this
project's own; `../BIBLIOGRAPHY.md` § E translates them.
