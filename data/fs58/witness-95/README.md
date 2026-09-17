# data/fs58/witness-95 — FS-58 phase B5 side result: the plane over ℚ(√95) needs four colours

Method as `data/fs58/witness-23/README.md` (checkpointed extraction) on the pool `q1+12+60.2` — the axis, the orbit of
`(√95/12, 7/12)` and a class of denominator 60 (28 directions) — whose ball of physical radius 1.5 (17,169 points, 82,206 edges) refuses
three colours. The Glucose4 deletion was **stopped** after 363 of 1,737 tests (it ran at about one test per second): the witness is the
last recorded refusing set, **1,068 points, 3,096 edges, not 1-minimal**.

| record | what |
|---|---|
| `certified.out` | `tools/fs58_check_witness.py --radicand 95`: CERTIFIED |
| `controls.out` | twelve planted faults refused, faithful twin certified, all-pairs = bucketed = file |
| `recheck.out` | Fraction all-pairs edges = file; Lingeling, CaDiCaL 1.5.3, MapleChrono UNSAT; deleting the pinned vertex leaves a 3-colourable graph |
| `extract.out` | the (re-)emission log; `steps.jsonl` (gitignored) holds the 72 core rounds (17,169 → 1,737) and the deletion records |

95 ≡ 4 = 2² (mod 7), so 7 splits with residue field 𝔽₇ and row 52's bound (hand level) gives χ ≤ 4: χ(ℚ(√95)²) = 4 at the same trust
split as `witness-23`.
