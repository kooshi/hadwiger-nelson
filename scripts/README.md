# scripts/

The build and the gate (`../README.md` § How to check it).

| script | what it does |
|---|---|
| `build.sh`, `build_order.py` | the build: modules in dependency order, in batches (`BATCH`) under a memory cap (`MEMMAX`); never a bare `lake build` |
| `axioms.sh`, `Axioms.lean`, `axioms-controls.txt` | the axiom audit: each public record's `#print axioms`, checked as a set against its section (clean, imported, purchased) |
| `assumptions.sh`, `Assumptions.lean`, `assumptions-ledger.txt` | every hypothesis that stands for an outside theorem, an unformalized result or an open question, declared with its source, and every theorem that takes it |
| `vacuity.sh`, `Vacuity.lean`, `vacuity-baseline.txt` | no theorem quantifies over an empty domain without saying so |
| `dupnames.sh`, `DupNames.lean` | no name declared by two modules |
| `lean4checker.sh` | the independent kernel replay (the publication gate) |
| `regen-check.sh` | every generated Lean module, regenerated from its committed inputs and compared byte for byte |
| `gate-log.sh`, `gate_report.py` | each gate's full output kept under `build/gate/`, and a digest of it |
| `Dimacs.lean`, `EmitLrat.lean` | the SAT bridge: emit a graph's colouring formula, read back a solver's LRAT certificate |
| `slot.py` | runs a job within a memory budget on pinned cores (this project's machines) |
| `dev-env.sh` | the Arch Linux compiler workaround |
| `identities.py` | checks the agents' identity files against their skills |

Each gate script has a `--self-test` that plants faults and checks that each one is caught.
