# data/m51 — durable snapshots of the descent's irreplaceable state

Created 2026-09-02 (Kooshi's directive after a double context compaction: "make sure we have
information about the X=5 unit subgraph objects saved durably in the repo"). Everything in
`build/` is gitignored and lives on one machine with a demonstrated hardware-fault history;
the files here are the subset that could NOT be re-derived without re-running days of solver
search. They are snapshots — the *living* copies stay in `build/` and the tools read from
there; refresh these at every iteration commit.

| File | What it is | Why irreplaceable |
|---|---|---|
| `m50-object-S29-depth2r.json` … `…-vdel28-it2v2-depth1.json` | The five-object descent chain, seed → iteration 4's commit (provenance form: each point is `['glue', parent_i, parent_j, sign]` over the Exoo–Ismailescu seed; fingerprints inside) | The halo points were found by solver search across four campaigns; the provenance lists are the only compact record |
| `m51-copycore-about206-graph.json` | The 883-point 1-minimal vertex core of the 5-chromatic union U ∪ R₂₀₆(U) (883 core indices + 4,625 edges) | 3,412 solver asks / 2.3 h to derive |
| `m51-floor-it4-list.json` | Iteration 4's floor (39 essential cheats on the vdel28 object) | census |
| `m51-floor-it5-verdicts.jsonl` | Iteration 5's floor census, per-verdict (27 of 273 essential, 0 unknown, on fingerprint `f0871bab2b915b4f`) | 2,657 s census |
| `q8-transforms.json` | The exact Q8 transform recipes (rotation cos 7/8, sin ±√15/8 about named centres), the refusing unions' stats and verdicts, the lock-centre map, controls | The recipes make every 5-chromatic union re-derivable in seconds with `tools/copy_probe.py` |

The full narrative record: `plans/Q8-FIVE-CHROMATIC-OBJECTS.md` (object cards),
`plans/M51-descent-engine.md` §S-CONT (the campaign log), `plans/STANDING-QUESTIONS.md` Q8.
The per-event ledger `build/m51-jobs.txt` remains build-side (append-only, machine-local).
