# FS-73 census: every verdict row

*Rendered from `K-rows.jsonl`, `K-periods.jsonl` and `rich-rows.jsonl` by `python3 tools/fs73_screen.py rows-table`. Graph: "saturated" (every unit vector of the lattice) or "generators" (the rich lattices: Cay(Lambda, S)). Period group: Lambda/W as invariant factors. Finder: plain (is there a colouring), sep (one with c(target) != c(0)), gap (one with a colour missing from the origin's closed neighbourhood), force (a ball ask), analyse (Per and KPer of a found colouring). W': none of these rows computes one (the census asks never escape through a re-periodisation; P1g's card does). Seconds are CPU seconds of the solver child. Machine: desktop (16 physical cores / 32 threads, 128 GB) unless the row says otherwise.*

| file | key | lattice | graph | period group Lambda/W | finder | verdict | target (lattice coords) | CPU s |
|---|---|---|---|---|---|---|---|---|
| K-rows.jsonl | `seeded:N2:sep:1,0,0,0` | degrey | saturated | [2, 2, 2, 2] | sep | SAT | [1, 0, 0, 0] | 0.0 |
| K-rows.jsonl | `seeded:N4:sep:1,0,0,0` | degrey | saturated | [4, 4, 4, 4] | sep | SAT | [1, 0, 0, 0] | 0.01 |
| K-rows.jsonl | `seeded:N4:sep:2,0,2,2` | degrey | saturated | [4, 4, 4, 4] | sep | SAT | [2, 0, 2, 2] | 0.02 |
| K-rows.jsonl | `seeded:N4:sep:2,2,2,2` | degrey | saturated | [4, 4, 4, 4] | sep | SAT | [2, 2, 2, 2] | 0.02 |
| K-rows.jsonl | `seeded:N6:sep:1,0,0,0` | degrey | saturated | [6, 6, 6, 6] | sep | SAT | [1, 0, 0, 0] | 0.0 |
| K-rows.jsonl | `seeded:N6:sep:2,0,0,0` | degrey | saturated | [6, 6, 6, 6] | sep | UNSAT | [2, 0, 0, 0] | 0.01 |
| K-rows.jsonl | `seeded:N6:sep:0,2,0,0` | degrey | saturated | [6, 6, 6, 6] | sep | UNSAT | [0, 2, 0, 0] | 0.0 |
| K-rows.jsonl | `seeded:N6:sep:0,0,2,0` | degrey | saturated | [6, 6, 6, 6] | sep | UNSAT | [0, 0, 2, 0] | 0.01 |
| K-rows.jsonl | `seeded:N6:sep:0,0,0,2` | degrey | saturated | [6, 6, 6, 6] | sep | UNSAT | [0, 0, 0, 2] | 0.0 |
| K-rows.jsonl | `seeded:N8:sep:1,0,0,0` | degrey | saturated | [8, 8, 8, 8] | sep | SAT | [1, 0, 0, 0] | 0.26 |
| K-rows.jsonl | `seeded:N8:sep:1,0,4,4` | degrey | saturated | [8, 8, 8, 8] | sep | SAT | [1, 0, 4, 4] | 0.31 |
| K-rows.jsonl | `seeded:N8:sep:2,6,6,2` | degrey | saturated | [8, 8, 8, 8] | sep | SAT | [2, 6, 6, 2] | 0.26 |
| K-rows.jsonl | `seeded:N10:sep:1,1,0,1` | degrey | saturated | [10, 10, 10, 10] | sep | SAT | [1, 1, 0, 1] | 1.55 |
| K-rows.jsonl | `seeded:N10:sep:2,0,0,0` | degrey | saturated | [10, 10, 10, 10] | sep | UNSAT | [2, 0, 0, 0] | 1.67 |
| K-rows.jsonl | `seeded:N10:sep:0,2,0,0` | degrey | saturated | [10, 10, 10, 10] | sep | UNSAT | [0, 2, 0, 0] | 2.39 |
| K-rows.jsonl | `seeded:N10:sep:0,0,2,0` | degrey | saturated | [10, 10, 10, 10] | sep | UNSAT | [0, 0, 2, 0] | 1.98 |
| K-rows.jsonl | `seeded:N10:sep:0,0,0,2` | degrey | saturated | [10, 10, 10, 10] | sep | UNSAT | [0, 0, 0, 2] | 1.91 |
| K-rows.jsonl | `seeded:N12:sep:1,0,0,0` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [1, 0, 0, 0] | 3.57 |
| K-rows.jsonl | `seeded:N12:sep:1,0,0,2` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [1, 0, 0, 2] | 3.52 |
| K-rows.jsonl | `seeded:N12:sep:2,0,0,0` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [2, 0, 0, 0] | 3.77 |
| K-rows.jsonl | `seeded:N12:sep:4,0,0,0` | degrey | saturated | [12, 12, 12, 12] | sep | UNSAT | [4, 0, 0, 0] | 3.4 |
| K-rows.jsonl | `seeded:N12:sep:0,4,0,0` | degrey | saturated | [12, 12, 12, 12] | sep | UNSAT | [0, 4, 0, 0] | 3.86 |
| K-rows.jsonl | `seeded:N12:sep:0,0,2,0` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [0, 0, 2, 0] | 3.91 |
| K-rows.jsonl | `seeded:N12:sep:0,0,4,0` | degrey | saturated | [12, 12, 12, 12] | sep | UNSAT | [0, 0, 4, 0] | 3.93 |
| K-rows.jsonl | `seeded:N12:sep:0,0,0,4` | degrey | saturated | [12, 12, 12, 12] | sep | UNSAT | [0, 0, 0, 4] | 3.89 |
| K-rows.jsonl | `cold:N2:plain` | degrey | saturated | [2, 2, 2, 2] | plain | SAT | - | 0.0 |
| K-rows.jsonl | `cold:N4:plain` | degrey | saturated | [4, 4, 4, 4] | plain | SAT | - | 0.01 |
| K-rows.jsonl | `cold:N6:plain` | degrey | saturated | [6, 6, 6, 6] | plain | SAT | - | 0.0 |
| K-rows.jsonl | `cold:N8:plain` | degrey | saturated | [8, 8, 8, 8] | plain | SAT | - | 0.26 |
| K-rows.jsonl | `cold:N10:plain` | degrey | saturated | [10, 10, 10, 10] | plain | SAT | - | 1.49 |
| K-rows.jsonl | `cold:N12:plain` | degrey | saturated | [12, 12, 12, 12] | plain | SAT | - | 3.82 |
| K-rows.jsonl | `analyse:4dcc74d0b3b87b16` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.1 |
| K-rows.jsonl | `analyse:726286dd163b97d2` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.01 |
| K-rows.jsonl | `analyse:d0addcd09a952cc6` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 0.01 |
| K-rows.jsonl | `analyse:2b4438f34ea81155` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 0.01 |
| K-rows.jsonl | `analyse:5b97e72814f8633f` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 0.01 |
| K-rows.jsonl | `analyse:2f59be7efc4d7161` | degrey | saturated | - | analyse | Per [4], KPer [2, 8] | - | 0.01 |
| K-rows.jsonl | `analyse:5b10aba88d1bec47` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.03 |
| K-rows.jsonl | `analyse:2afb99ff670fe532` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.03 |
| K-rows.jsonl | `analyse:72b08f424a2e89f5` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 0.06 |
| K-rows.jsonl | `analyse:622e92028a4235a6` | degrey | saturated | - | analyse | Per [8], KPer [2, 8] | - | 0.1 |
| K-rows.jsonl | `analyse:9520375dcf4f5ac8` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 0.06 |
| K-rows.jsonl | `analyse:912d0af44d55f492` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 0.06 |
| K-rows.jsonl | `analyse:66dd68b294b419df` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.95 |
| K-rows.jsonl | `analyse:2e7f834e98b3e579` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.95 |
| K-rows.jsonl | `analyse:7be2e69c0e18f946` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 1.99 |
| K-rows.jsonl | `analyse:5d2d2e08c31b11fd` | degrey | saturated | - | analyse | Per [4], KPer [2, 8] | - | 3.93 |
| K-rows.jsonl | `analyse:01ccb061cf2167f2` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 1.98 |
| K-rows.jsonl | `analyse:429dab2ccf42b3fe` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 1.99 |
| K-rows.jsonl | `analyse:968efa1960713fb1` | degrey | saturated | - | analyse | Per [4], KPer [2, 8] | - | 3.92 |
| K-rows.jsonl | `analyse:ea24053b1da8093f` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.01 |
| K-rows.jsonl | `analyse:ef2d1feefcab74f9` | degrey | saturated | - | analyse | Per [8], KPer [2, 8] | - | 0.1 |
| K-rows.jsonl | `sandwich:52` | degrey | saturated | - | sandwich | - | - | - |
| K-rows.jsonl | `cold:N2:sep:1,0,0,0` | degrey | saturated | [2, 2, 2, 2] | sep | SAT | [1, 0, 0, 0] | 0.0 |
| K-rows.jsonl | `cold:N2:sep:1,1,0,1` | degrey | saturated | [2, 2, 2, 2] | sep | SAT | [1, 1, 0, 1] | 0.0 |
| K-rows.jsonl | `cold:N4:sep:1,0,0,0` | degrey | saturated | [4, 4, 4, 4] | sep | SAT | [1, 0, 0, 0] | 0.0 |
| K-rows.jsonl | `cold:N4:sep:1,1,0,3` | degrey | saturated | [4, 4, 4, 4] | sep | SAT | [1, 1, 0, 3] | 0.0 |
| K-rows.jsonl | `cold:N4:sep:2,0,2,2` | degrey | saturated | [4, 4, 4, 4] | sep | SAT | [2, 0, 2, 2] | 0.04 |
| K-rows.jsonl | `cold:N4:sep:2,2,2,2` | degrey | saturated | [4, 4, 4, 4] | sep | SAT | [2, 2, 2, 2] | 0.0 |
| K-rows.jsonl | `cold:N6:sep:1,0,0,0` | degrey | saturated | [6, 6, 6, 6] | sep | SAT | [1, 0, 0, 0] | 0.01 |
| K-rows.jsonl | `cold:N6:sep:1,1,0,1` | degrey | saturated | [6, 6, 6, 6] | sep | SAT | [1, 1, 0, 1] | 0.0 |
| K-rows.jsonl | `cold:N6:sep:2,0,0,0` | degrey | saturated | [6, 6, 6, 6] | sep | UNSAT | [2, 0, 0, 0] | 0.01 |
| K-rows.jsonl | `cold:N6:sep:0,2,0,0` | degrey | saturated | [6, 6, 6, 6] | sep | UNSAT | [0, 2, 0, 0] | 0.01 |
| K-rows.jsonl | `cold:N6:sep:0,0,2,0` | degrey | saturated | [6, 6, 6, 6] | sep | UNSAT | [0, 0, 2, 0] | 0.0 |
| K-rows.jsonl | `cold:N6:sep:0,0,0,2` | degrey | saturated | [6, 6, 6, 6] | sep | UNSAT | [0, 0, 0, 2] | 0.01 |
| K-rows.jsonl | `cold:N8:sep:1,0,0,0` | degrey | saturated | [8, 8, 8, 8] | sep | SAT | [1, 0, 0, 0] | 0.25 |
| K-rows.jsonl | `cold:N8:sep:1,0,0,4` | degrey | saturated | [8, 8, 8, 8] | sep | SAT | [1, 0, 0, 4] | 0.24 |
| K-rows.jsonl | `cold:N8:sep:1,0,4,4` | degrey | saturated | [8, 8, 8, 8] | sep | SAT | [1, 0, 4, 4] | 0.28 |
| K-rows.jsonl | `cold:N8:sep:2,6,6,2` | degrey | saturated | [8, 8, 8, 8] | sep | SAT | [2, 6, 6, 2] | 0.25 |
| K-rows.jsonl | `cold:N10:sep:1,0,0,0` | degrey | saturated | [10, 10, 10, 10] | sep | SAT | [1, 0, 0, 0] | 1.51 |
| K-rows.jsonl | `cold:N10:sep:1,1,0,1` | degrey | saturated | [10, 10, 10, 10] | sep | SAT | [1, 1, 0, 1] | 1.29 |
| K-rows.jsonl | `cold:N10:sep:2,0,0,0` | degrey | saturated | [10, 10, 10, 10] | sep | UNSAT | [2, 0, 0, 0] | 1.67 |
| K-rows.jsonl | `cold:N10:sep:0,2,0,0` | degrey | saturated | [10, 10, 10, 10] | sep | UNSAT | [0, 2, 0, 0] | 2.03 |
| K-rows.jsonl | `cold:N10:sep:0,0,2,0` | degrey | saturated | [10, 10, 10, 10] | sep | UNSAT | [0, 0, 2, 0] | 1.75 |
| K-rows.jsonl | `cold:N10:sep:0,0,0,2` | degrey | saturated | [10, 10, 10, 10] | sep | UNSAT | [0, 0, 0, 2] | 1.57 |
| K-rows.jsonl | `cold:N12:sep:1,0,0,0` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [1, 0, 0, 0] | 3.23 |
| K-rows.jsonl | `cold:N12:sep:1,0,0,2` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [1, 0, 0, 2] | 3.19 |
| K-rows.jsonl | `cold:N12:sep:1,1,0,1` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [1, 1, 0, 1] | 3.19 |
| K-rows.jsonl | `cold:N12:sep:2,0,0,0` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [2, 0, 0, 0] | 3.39 |
| K-rows.jsonl | `cold:N12:sep:4,0,0,0` | degrey | saturated | [12, 12, 12, 12] | sep | UNSAT | [4, 0, 0, 0] | 3.42 |
| K-rows.jsonl | `cold:N12:sep:0,4,0,0` | degrey | saturated | [12, 12, 12, 12] | sep | UNSAT | [0, 4, 0, 0] | 3.45 |
| K-rows.jsonl | `cold:N12:sep:0,0,2,0` | degrey | saturated | [12, 12, 12, 12] | sep | SAT | [0, 0, 2, 0] | 3.3 |
| K-rows.jsonl | `cold:N12:sep:0,0,4,0` | degrey | saturated | [12, 12, 12, 12] | sep | UNSAT | [0, 0, 4, 0] | 3.34 |
| K-rows.jsonl | `cold:N12:sep:0,0,0,4` | degrey | saturated | [12, 12, 12, 12] | sep | UNSAT | [0, 0, 0, 4] | 3.35 |
| K-rows.jsonl | `analyse:46ea4eb0733dc6ff` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 0.1 |
| K-rows.jsonl | `analyse:16788fa60ce79c2b` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.03 |
| K-rows.jsonl | `analyse:9a9a2c6a803cd73c` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 0.06 |
| K-rows.jsonl | `analyse:c8f03b323697ff8e` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.93 |
| K-rows.jsonl | `analyse:bbe26cacbb18a8dc` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 1.94 |
| K-rows.jsonl | `sandwich:89` | degrey | saturated | - | sandwich | - | - | - |
| K-rows.jsonl | `seeded:N16:plain` | degrey | saturated | [16, 16, 16, 16] | plain | SAT | - | 1.26 |
| K-rows.jsonl | `seeded:N16:sep:1,3,0,1` | degrey | saturated | [16, 16, 16, 16] | sep | SAT | [1, 3, 0, 1] | 1.2 |
| K-rows.jsonl | `seeded:N16:sep:2,2,2,4` | degrey | saturated | [16, 16, 16, 16] | sep | SAT | [2, 2, 2, 4] | 1.28 |
| K-rows.jsonl | `seeded:N16:sep:4,0,2,2` | degrey | saturated | [16, 16, 16, 16] | sep | SAT | [4, 0, 2, 2] | 1.65 |
| K-rows.jsonl | `seeded:N16:sep:8,0,0,0` | degrey | saturated | [16, 16, 16, 16] | sep | UNSAT | [8, 0, 0, 0] | 4.69 |
| K-rows.jsonl | `seeded:N16:sep:0,8,0,0` | degrey | saturated | [16, 16, 16, 16] | sep | UNSAT | [0, 8, 0, 0] | 4.12 |
| K-rows.jsonl | `seeded:N16:sep:0,0,8,0` | degrey | saturated | [16, 16, 16, 16] | sep | UNSAT | [0, 0, 8, 0] | 7.12 |
| K-rows.jsonl | `seeded:N16:sep:0,0,0,8` | degrey | saturated | [16, 16, 16, 16] | sep | UNSAT | [0, 0, 0, 8] | 10.35 |
| K-rows.jsonl | `analyse:8eca0fe8b02eb957` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 9.79 |
| K-rows.jsonl | `analyse:68a26676c838c437` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 9.52 |
| K-rows.jsonl | `analyse:865b2ea8b15f4e29` | degrey | saturated | - | analyse | Per [8], KPer [2, 8] | - | 18.43 |
| K-rows.jsonl | `analyse:dece6f453b6f815b` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 9.43 |
| K-rows.jsonl | `force:96,-48,-48,-24:R1.5` | degrey | saturated | - | force | refused (forced in this graph) | 8/3 | - |
| K-rows.jsonl | `seeded:N14:plain` | degrey | saturated | [14, 14, 14, 14] | plain | SAT | - | 0.69 |
| K-rows.jsonl | `seeded:N14:sep:1,0,0,0` | degrey | saturated | [14, 14, 14, 14] | sep | SAT | [1, 0, 0, 0] | 1.5 |
| K-rows.jsonl | `seeded:N14:sep:2,0,0,0` | degrey | saturated | [14, 14, 14, 14] | sep | UNSAT | [2, 0, 0, 0] | 14.16 |
| K-rows.jsonl | `seeded:N14:sep:0,2,0,0` | degrey | saturated | [14, 14, 14, 14] | sep | UNSAT | [0, 2, 0, 0] | 3.4 |
| K-rows.jsonl | `seeded:N14:sep:0,0,2,0` | degrey | saturated | [14, 14, 14, 14] | sep | UNSAT | [0, 0, 2, 0] | 5.18 |
| K-rows.jsonl | `seeded:N14:sep:0,0,0,2` | degrey | saturated | [14, 14, 14, 14] | sep | UNSAT | [0, 0, 0, 2] | 3.33 |
| K-rows.jsonl | `analyse:73f56b0f2da2776b` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 12.97 |
| K-rows.jsonl | `analyse:16a97238d5787490` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 12.81 |
| K-rows.jsonl | `seeded:N15:plain` | degrey | saturated | [15, 15, 15, 15] | plain | UNSAT | - | 1.88 |
| K-rows.jsonl | `seeded:N20:plain` | degrey | saturated | [20, 20, 20, 20] | plain | SAT | - | 7.49 |
| K-rows.jsonl | `seeded:N20:sep:1,0,0,0` | degrey | saturated | [20, 20, 20, 20] | sep | SAT | [1, 0, 0, 0] | 7.13 |
| K-rows.jsonl | `seeded:N20:sep:1,0,2,2` | degrey | saturated | [20, 20, 20, 20] | sep | SAT | [1, 0, 2, 2] | 7.36 |
| K-rows.jsonl | `seeded:N20:sep:1,1,2,1` | degrey | saturated | [20, 20, 20, 20] | sep | SAT | [1, 1, 2, 1] | 11.96 |
| K-rows.jsonl | `force:32,-16,-16,-8:R1.5` | degrey | saturated | - | force | refused (forced in this graph) | 8/9 | - |
| K-rows.jsonl | `force:0,0,0,0:R1.5` | degrey | saturated | - | force | refused (forced in this graph) | 0 | - |
| K-rows.jsonl | `seeded:N20:sep:1,3,2,3` | degrey | saturated | [20, 20, 20, 20] | sep | SAT | [1, 3, 2, 3] | 7.25 |
| K-rows.jsonl | `seeded:N20:sep:2,2,0,2` | degrey | saturated | [20, 20, 20, 20] | sep | SAT | [2, 2, 0, 2] | 10.39 |
| K-rows.jsonl | `retract:force:0,0,0,0:R1.5` | degrey | saturated | - | retract | - | - | - |
| K-rows.jsonl | `seeded:N20:sep:4,0,0,0` | degrey | saturated | [20, 20, 20, 20] | sep | UNSAT | [4, 0, 0, 0] | 200.91 |
| K-rows.jsonl | `seeded:N20:sep:0,4,0,0` | degrey | saturated | [20, 20, 20, 20] | sep | UNSAT | [0, 4, 0, 0] | 102.42 |
| K-rows.jsonl | `seeded:N20:sep:0,0,4,0` | degrey | saturated | [20, 20, 20, 20] | sep | UNSAT | [0, 0, 4, 0] | 105.57 |
| K-rows.jsonl | `seeded:N20:sep:0,0,0,4` | degrey | saturated | [20, 20, 20, 20] | sep | UNSAT | [0, 0, 0, 4] | 32.89 |
| K-rows.jsonl | `analyse:19511008dd442616` | degrey | saturated | - | analyse | Per [4], KPer [2, 8] | - | 215.74 |
| K-rows.jsonl | `analyse:19ce54b2cb190090` | degrey | saturated | - | analyse | Per [4], KPer [2, 8] | - | 215.15 |
| K-rows.jsonl | `analyse:1cce8665b13f9c30` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 215.02 |
| K-rows.jsonl | `analyse:d47545be9a502792` | degrey | saturated | - | analyse | Per [4], KPer [2, 8] | - | 217.61 |
| K-rows.jsonl | `analyse:9b156b094162d7be` | degrey | saturated | - | analyse | Per [2, 4], KPer [2, 8] | - | 112.65 |
| K-rows.jsonl | `analyse:a283884c7f6073bf` | degrey | saturated | - | analyse | Per [4], KPer [2, 8] | - | 0.37 |
| K-rows.jsonl | `seeded:N21:plain` | degrey | saturated | [21, 21, 21, 21] | plain | UNSAT | - | 57.96 |
| K-rows.jsonl | `seeded:N22:plain` | degrey | saturated | [22, 22, 22, 22] | plain | SAT | - | 9.97 |
| K-rows.jsonl | `seeded:N22:sep:1,0,0,0` | degrey | saturated | [22, 22, 22, 22] | sep | SAT | [1, 0, 0, 0] | 10.09 |
| K-rows.jsonl | `seeded:N22:sep:2,0,0,0` | degrey | saturated | [22, 22, 22, 22] | sep | UNSAT | [2, 0, 0, 0] | 23.68 |
| K-rows.jsonl | `seeded:N22:sep:0,2,0,0` | degrey | saturated | [22, 22, 22, 22] | sep | UNSAT | [0, 2, 0, 0] | 212.73 |
| K-rows.jsonl | `seeded:N22:sep:0,0,2,0` | degrey | saturated | [22, 22, 22, 22] | sep | UNSAT | [0, 0, 2, 0] | 101.17 |
| K-rows.jsonl | `seeded:N22:sep:0,0,0,2` | degrey | saturated | [22, 22, 22, 22] | sep | UNSAT | [0, 0, 0, 2] | 29.42 |
| K-rows.jsonl | `analyse:44e27bb6dd2d0096` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.4 |
| K-rows.jsonl | `analyse:8e2dbc33999f4116` | degrey | saturated | - | analyse | Per [2, 2], KPer [8, 8] | - | 0.4 |
| K-rows.jsonl | `seeded:N24:plain` | degrey | saturated | [24, 24, 24, 24] | plain | SAT | - | 7.73 |
| K-rows.jsonl | `seeded:N24:sep:1,0,0,0` | degrey | saturated | [24, 24, 24, 24] | sep | SAT | [1, 0, 0, 0] | 11.11 |
| K-rows.jsonl | `seeded:N24:sep:2,0,0,0` | degrey | saturated | [24, 24, 24, 24] | sep | SAT | [2, 0, 0, 0] | 8.72 |
| K-rows.jsonl | `seeded:N24:sep:2,6,0,6` | degrey | saturated | [24, 24, 24, 24] | sep | SAT | [2, 6, 0, 6] | 8.33 |
| K-rows.jsonl | `seeded:N24:sep:8,0,0,0` | degrey | saturated | [24, 24, 24, 24] | sep | UNSAT | [8, 0, 0, 0] | 171.45 |
| K-rows.jsonl | `seeded:N24:sep:0,8,0,0` | degrey | saturated | [24, 24, 24, 24] | sep | UNSAT | [0, 8, 0, 0] | 60.26 |
| K-rows.jsonl | `seeded:N24:sep:0,0,8,0` | degrey | saturated | [24, 24, 24, 24] | sep | UNSAT | [0, 0, 8, 0] | 82.56 |
| K-rows.jsonl | `seeded:N24:sep:0,0,0,8` | degrey | saturated | [24, 24, 24, 24] | sep | UNSAT | [0, 0, 0, 8] | 70.41 |
| K-rows.jsonl | `analyse:6e044c5a6a6f02b9` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 0.37 |
| K-rows.jsonl | `analyse:94d2aeeae46db762` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 0.38 |
| K-rows.jsonl | `analyse:38fa58428c4970f8` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 0.38 |
| K-rows.jsonl | `analyse:ed1fefa497ec30fe` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 0.38 |
| K-rows.jsonl | `force:-16,8,8,0:R1.5` | degrey | saturated | - | force | refused (forced in this graph) | c:-16,8,8,0 | - |
| K-rows.jsonl | `confirm:force:32,-16,-16,-8:R1.5:cadical` | degrey | saturated | - | force | UNSAT | - | 435.63 |
| K-rows.jsonl | `force:32,-16,-16,-8:R1.0` | degrey | saturated | - | force | UNKNOWN | 8/9 | - |
| K-rows.jsonl | `confirm:force:-16,8,8,0:R1.5:cadical` | degrey | saturated | - | force | UNSAT | - | 91.35 |
| K-rows.jsonl | `force:-16,8,8,0:R1.0` | degrey | saturated | - | force | UNKNOWN | c:-16,8,8,0 | - |
| K-rows.jsonl | `confirm:force:-16,8,8,0:R1.5:cadical:156` | degrey | saturated | - | force | UNSAT | - | 112.26 |
| K-rows.jsonl | `pd3:union:R1.5` | degrey | saturated | - | force | UNKNOWN | - | - |
| K-rows.jsonl | `force:32,-16,-16,-8:R1.25` | degrey | saturated | - | force | UNKNOWN | 8/9 | - |
| K-rows.jsonl | `force:32,-16,-16,-8:R1.3` | degrey | saturated | - | force | UNKNOWN | 8/9 | - |
| K-rows.jsonl | `force:32,-16,-16,-8:R1.4` | degrey | saturated | - | force | UNKNOWN | 8/9 | - |
| K-rows.jsonl | `seeded:N32:plain` | degrey | saturated | [32, 32, 32, 32] | plain | SAT | - | 33.68 |
| K-rows.jsonl | `seeded:N32:sep:1,0,0,0` | degrey | saturated | [32, 32, 32, 32] | sep | SAT | [1, 0, 0, 0] | 100.86 |
| K-rows.jsonl | `seeded:N32:sep:2,0,6,6` | degrey | saturated | [32, 32, 32, 32] | sep | SAT | [2, 0, 6, 6] | 59.66 |
| K-rows.jsonl | `seeded:N32:sep:2,6,0,6` | degrey | saturated | [32, 32, 32, 32] | sep | SAT | [2, 6, 0, 6] | 43.05 |
| K-rows.jsonl | `seeded:N32:sep:8,0,0,0` | degrey | saturated | [32, 32, 32, 32] | sep | UNSAT | [8, 0, 0, 0] | 974.59 |
| K-rows.jsonl | `seeded:N32:sep:0,8,0,0` | degrey | saturated | [32, 32, 32, 32] | sep | UNSAT | [0, 8, 0, 0] | 1052.0 |
| K-rows.jsonl | `seeded:N32:sep:0,0,8,0` | degrey | saturated | [32, 32, 32, 32] | sep | UNSAT | [0, 0, 8, 0] | 298.13 |
| K-rows.jsonl | `seeded:N32:sep:0,0,0,8` | degrey | saturated | [32, 32, 32, 32] | sep | UNSAT | [0, 0, 0, 8] | 1178.84 |
| K-rows.jsonl | `analyse:ac916c9cc4d1974c` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 1.36 |
| K-rows.jsonl | `analyse:9ce954279d178653` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 1.29 |
| K-rows.jsonl | `analyse:de9b03d262246b3a` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 1.28 |
| K-rows.jsonl | `analyse:4a1e6723d2864f39` | degrey | saturated | - | analyse | Per [2, 8], KPer [2, 8] | - | 1.28 |
| K-rows.jsonl | `sandwich:174` | degrey | saturated | - | sandwich | - | - | - |
| K-periods.jsonl | `period:N16` | degrey | saturated | - | period | SAT | - | 31.67 |
| K-periods.jsonl | `period:N14` | degrey | saturated | - | period | SAT | - | 28.259999999999998 |
| K-periods.jsonl | `period:N15` | degrey | saturated | - | period | UNSAT | - | 1.88 |
| K-periods.jsonl | `period:N20` | degrey | saturated | - | period | SAT | - | 493.37 |
| K-periods.jsonl | `period:N21` | degrey | saturated | - | period | UNSAT | - | 57.96 |
| K-periods.jsonl | `period:N22` | degrey | saturated | - | period | SAT | - | 387.06 |
| K-periods.jsonl | `period:N24` | degrey | saturated | - | period | SAT | - | 420.57 |
| K-periods.jsonl | `period:N32` | degrey | saturated | - | period | SAT | - | 3740.81 |
| rich-rows.jsonl | `tu14|setup` | tu14 | generators | - | setup | - | - | - |
| rich-rows.jsonl | `tu14|price:N2` | tu14 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:N4` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:N6` | tu14 | generators | [6, 6, 6, 6, 6, 6, 6, 6] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:11a` | tu14 | generators | [11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:2x11a` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:2x11b` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:2x11c` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:2x11d` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:11a11b` | tu14 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:11a11c` | tu14 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu14|price:11a11d` | tu14 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu14|gap:N2` | tu14 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | gap | UNSAT | - | 0.0 |
| rich-rows.jsonl | `tu14|seeded:N2:sep:1,0,0,0,0,1,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 0, 0, 0, 1, 0, 1] | 0.0 |
| rich-rows.jsonl | `tu14|cold:N2:sep:1,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 0.0 |
| rich-rows.jsonl | `tu14|cold:N2:sep:0,1,0,1,0,0,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [0, 1, 0, 1, 0, 0, 0, 1] | 0.0 |
| rich-rows.jsonl | `tu14|analyse:f9adff0593d36c2d` | tu14 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [2, 390, 390, 5460, 5460] | - | 0.2 |
| rich-rows.jsonl | `tu14|analyse:04f38bb52b96e826` | tu14 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [2, 390, 390, 780, 780] | - | 0.09 |
| rich-rows.jsonl | `tu14|analyse:ac49a3d90eb04e62` | tu14 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [2, 390, 390, 5460, 5460] | - | 0.09 |
| rich-rows.jsonl | `tu14|P:N2` | tu14 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu14|gap:N4` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | gap | UNSAT | - | 1.45 |
| rich-rows.jsonl | `tu14|seeded:N4:sep:1,0,0,0,0,1,0,1` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 0, 0, 0, 0, 1, 0, 1] | 4.62 |
| rich-rows.jsonl | `tu14|seeded:N4:sep:1,0,0,0,0,1,1,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 0, 0, 0, 0, 1, 1, 2] | 1.97 |
| rich-rows.jsonl | `tu14|seeded:N4:sep:1,1,0,3,2,0,1,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 1, 0, 3, 2, 0, 1, 2] | 3.82 |
| rich-rows.jsonl | `tu14|seeded:N4:sep:2,0,1,1,2,0,1,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [2, 0, 1, 1, 2, 0, 1, 2] | 3.02 |
| rich-rows.jsonl | `tu14|seeded:N4:sep:0,0,2,2,0,0,0,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 2, 2, 0, 0, 0, 2] | 8.56 |
| rich-rows.jsonl | `tu14|seeded:N4:sep:0,0,0,0,0,0,2,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 0, 2, 2] | 10.23 |
| rich-rows.jsonl | `tu14|cold:N4:sep:1,0,0,0,0,0,0,0` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.97 |
| rich-rows.jsonl | `tu14|cold:N4:sep:1,0,0,0,3,0,0,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 0, 0, 0, 3, 0, 0, 2] | 1.97 |
| rich-rows.jsonl | `tu14|cold:N4:sep:1,1,0,1,2,2,1,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 1, 0, 1, 2, 2, 1, 2] | 2.8 |
| rich-rows.jsonl | `tu14|cold:N4:sep:0,2,0,2,2,2,0,0` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [0, 2, 0, 2, 2, 2, 0, 0] | 2.79 |
| rich-rows.jsonl | `tu14|cold:N4:sep:0,0,2,2,0,0,0,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 2, 2, 0, 0, 0, 2] | 8.06 |
| rich-rows.jsonl | `tu14|cold:N4:sep:0,0,0,0,0,0,2,2` | tu14 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 0, 2, 2] | 10.53 |
| rich-rows.jsonl | `tu14|analyse:66fb7f8a7de532ec` | tu14 | generators | - | analyse | Per [2, 2, 4], KPer [195, 390, 390, 5460] | - | 0.18 |
| rich-rows.jsonl | `tu14|analyse:29e6a8d6cf29de08` | tu14 | generators | - | analyse | Per [2, 2, 4], KPer [195, 390, 2730, 5460] | - | 0.18 |
| rich-rows.jsonl | `tu14|analyse:9af6ed41d09d278a` | tu14 | generators | - | analyse | Per [2, 2, 2, 4, 4], KPer [2, 390, 390, 5460, 5460] | - | 0.35 |
| rich-rows.jsonl | `tu14|analyse:67f47d107f6cc4e6` | tu14 | generators | - | analyse | Per [2, 2, 4], KPer [195, 390, 390, 5460] | - | 0.18 |
| rich-rows.jsonl | `tu14|analyse:1a1198872f1d9645` | tu14 | generators | - | analyse | Per [2, 2, 2, 4, 4], KPer [2, 390, 390, 780, 780] | - | 0.37 |
| rich-rows.jsonl | `tu14|analyse:2ca5bb738bee218d` | tu14 | generators | - | analyse | Per [2, 2, 4], KPer [195, 390, 390, 5460] | - | 0.17 |
| rich-rows.jsonl | `tu14|analyse:caa266bbe799a1d5` | tu14 | generators | - | analyse | Per [2, 2, 2, 4, 4], KPer [2, 390, 390, 5460, 5460] | - | 0.35 |
| rich-rows.jsonl | `tu14|analyse:07894865c5893cfc` | tu14 | generators | - | analyse | Per [2, 2, 4], KPer [195, 390, 390, 5460] | - | 0.18 |
| rich-rows.jsonl | `tu14|P:N4` | tu14 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu14|gap:11a` | tu14 | generators | [11, 11] | gap | UNSAT | - | 0.01 |
| rich-rows.jsonl | `tu14|seeded:N11a:plain` | tu14 | generators | [11, 11] | plain | UNSAT | - | 0.02 |
| rich-rows.jsonl | `tu14|P:11a` | tu14 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu14|gap:2x11a` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.32 |
| rich-rows.jsonl | `tu14|seeded:N2x11a:plain` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 1.5 |
| rich-rows.jsonl | `tu14|seeded:N2x11a:sep:1,0,0,0,0,0,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 1] | 1.51 |
| rich-rows.jsonl | `tu14|seeded:N2x11a:sep:2,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 1.58 |
| rich-rows.jsonl | `tu14|seeded:N2x11a:sep:0,1,0,1,1,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 1, 0, 0, 0] | 1.51 |
| rich-rows.jsonl | `tu14|seeded:N2x11a:sep:0,2,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 1.66 |
| rich-rows.jsonl | `tu14|cold:N2x11a:sep:1,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.63 |
| rich-rows.jsonl | `tu14|cold:N2x11a:sep:1,0,0,0,0,1,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 1, 0, 1] | 1.51 |
| rich-rows.jsonl | `tu14|cold:N2x11a:sep:1,0,1,1,0,1,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 1, 0, 1, 0, 0] | 1.52 |
| rich-rows.jsonl | `tu14|cold:N2x11a:sep:1,1,1,0,1,0,1,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 1, 0, 1, 0, 1, 1] | 1.44 |
| rich-rows.jsonl | `tu14|cold:N2x11a:sep:2,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 1.77 |
| rich-rows.jsonl | `tu14|cold:N2x11a:sep:0,2,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 1.67 |
| rich-rows.jsonl | `tu14|analyse:8af8bdb0d50f43d6` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [195, 390, 2730, 5460] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:4f079ec424130b76` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [195, 390, 2730, 5460] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:4caec2b5ec7312c7` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [3, 6, 6, 6] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:38025dc6b4b40714` | tu14 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [2, 390, 390, 5460, 5460] | - | 0.13 |
| rich-rows.jsonl | `tu14|analyse:8e689dc99968d725` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [3, 6, 6, 6] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:1a7e9c93e66ecba3` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [195, 390, 390, 5460] | - | 0.11 |
| rich-rows.jsonl | `tu14|P:2x11a` | tu14 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu14|gap:2x11b` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.41 |
| rich-rows.jsonl | `tu14|seeded:N2x11b:plain` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 1.4 |
| rich-rows.jsonl | `tu14|seeded:N2x11b:sep:1,0,0,0,0,0,1,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 1, 1] | 1.43 |
| rich-rows.jsonl | `tu14|seeded:N2x11b:sep:1,0,0,0,1,0,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 1, 0, 0, 1] | 1.45 |
| rich-rows.jsonl | `tu14|seeded:N2x11b:sep:2,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 1.84 |
| rich-rows.jsonl | `tu14|seeded:N2x11b:sep:0,1,1,0,1,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 1, 0, 1, 0, 0, 0] | 1.37 |
| rich-rows.jsonl | `tu14|seeded:N2x11b:sep:0,2,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 1.83 |
| rich-rows.jsonl | `tu14|cold:N2x11b:sep:1,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.34 |
| rich-rows.jsonl | `tu14|cold:N2x11b:sep:1,0,0,0,0,0,1,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 1, 1] | 1.41 |
| rich-rows.jsonl | `tu14|cold:N2x11b:sep:1,0,0,0,1,0,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 1, 0, 0, 1] | 1.45 |
| rich-rows.jsonl | `tu14|cold:N2x11b:sep:2,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 1.95 |
| rich-rows.jsonl | `tu14|cold:N2x11b:sep:0,1,1,0,1,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 1, 0, 1, 0, 0, 0] | 1.43 |
| rich-rows.jsonl | `tu14|cold:N2x11b:sep:0,2,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 1.77 |
| rich-rows.jsonl | `tu14|analyse:911eee35edcd503b` | tu14 | generators | - | analyse | Per [2, 2], KPer [78, 78, 546, 546] | - | 0.12 |
| rich-rows.jsonl | `tu14|analyse:dbeac6e44b73586b` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [195, 390, 2730, 2730] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:cbb74daac4b2ad33` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [3, 6, 6, 6] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:845e1e28f691e21c` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [3, 6, 6, 6] | - | 0.11 |
| rich-rows.jsonl | `tu14|P:2x11b` | tu14 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu14|gap:2x11c` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.4 |
| rich-rows.jsonl | `tu14|seeded:N2x11c:plain` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 1.44 |
| rich-rows.jsonl | `tu14|seeded:N2x11c:sep:1,0,0,0,0,0,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 1] | 1.35 |
| rich-rows.jsonl | `tu14|seeded:N2x11c:sep:2,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 1.74 |
| rich-rows.jsonl | `tu14|seeded:N2x11c:sep:0,1,0,1,0,0,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 0, 0, 0, 1] | 1.41 |
| rich-rows.jsonl | `tu14|seeded:N2x11c:sep:0,2,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 1.77 |
| rich-rows.jsonl | `tu14|cold:N2x11c:sep:1,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.32 |
| rich-rows.jsonl | `tu14|cold:N2x11c:sep:1,0,0,0,0,0,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 1] | 1.37 |
| rich-rows.jsonl | `tu14|cold:N2x11c:sep:2,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 1.67 |
| rich-rows.jsonl | `tu14|cold:N2x11c:sep:0,1,0,1,0,0,0,1` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 0, 0, 0, 1] | 1.36 |
| rich-rows.jsonl | `tu14|cold:N2x11c:sep:0,2,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 1.79 |
| rich-rows.jsonl | `tu14|analyse:00dd0478092d3986` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [39, 78, 546, 546] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:8025cd25eb92436c` | tu14 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [2, 390, 390, 780, 780] | - | 0.14 |
| rich-rows.jsonl | `tu14|analyse:0b95c36427964ffe` | tu14 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [2, 390, 390, 5460, 5460] | - | 0.13 |
| rich-rows.jsonl | `tu14|P:2x11c` | tu14 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu14|gap:2x11d` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.37 |
| rich-rows.jsonl | `tu14|seeded:N2x11d:plain` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 1.34 |
| rich-rows.jsonl | `tu14|seeded:N2x11d:sep:1,0,0,0,1,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 1, 0, 0, 0] | 1.33 |
| rich-rows.jsonl | `tu14|seeded:N2x11d:sep:1,0,1,1,1,0,1,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 1, 1, 0, 1, 0] | 1.46 |
| rich-rows.jsonl | `tu14|seeded:N2x11d:sep:2,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 3.06 |
| rich-rows.jsonl | `tu14|seeded:N2x11d:sep:0,2,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.1 |
| rich-rows.jsonl | `tu14|cold:N2x11d:sep:1,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.33 |
| rich-rows.jsonl | `tu14|cold:N2x11d:sep:1,0,0,0,1,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 1, 0, 0, 0] | 1.45 |
| rich-rows.jsonl | `tu14|cold:N2x11d:sep:1,0,1,1,1,0,1,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 1, 1, 0, 1, 0] | 1.43 |
| rich-rows.jsonl | `tu14|cold:N2x11d:sep:2,0,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.92 |
| rich-rows.jsonl | `tu14|cold:N2x11d:sep:0,2,0,0,0,0,0,0` | tu14 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 1.83 |
| rich-rows.jsonl | `tu14|analyse:70abb92e906b5615` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [195, 390, 390, 5460] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:1f0d8b9d1848231c` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [39, 78, 546, 546] | - | 0.11 |
| rich-rows.jsonl | `tu14|analyse:7f642b017d3dff41` | tu14 | generators | - | analyse | Per [2, 2, 2], KPer [39, 78, 546, 546] | - | 0.11 |
| rich-rows.jsonl | `tu14|P:2x11d` | tu14 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu14|gap:11a11b` | tu14 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 7.92 |
| rich-rows.jsonl | `tu14|seeded:N11a11b:plain` | tu14 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 9.88 |
| rich-rows.jsonl | `tu14|P:11a11b` | tu14 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu14|gap:11a11c` | tu14 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 7.19 |
| rich-rows.jsonl | `tu14|seeded:N11a11c:plain` | tu14 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 8.54 |
| rich-rows.jsonl | `tu14|P:11a11c` | tu14 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu14|gap:11a11d` | tu14 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 7.51 |
| rich-rows.jsonl | `tu14|seeded:N11a11d:plain` | tu14 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 9.33 |
| rich-rows.jsonl | `tu14|P:11a11d` | tu14 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu14|sandwich:121` | tu14 | generators | - | sandwich | - | - | - |
| rich-rows.jsonl | `tu30|setup` | tu30 | generators | - | setup | - | - | - |
| rich-rows.jsonl | `tu30|price:N2` | tu30 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:N4` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:N6` | tu30 | generators | [6, 6, 6, 6, 6, 6, 6, 6] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:11a` | tu30 | generators | [11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:2x11a` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:2x11b` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:2x11c` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:2x11d` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:11a11b` | tu30 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:11a11c` | tu30 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu30|price:11a11d` | tu30 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu30|gap:N2` | tu30 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | gap | UNSAT | - | 0.0 |
| rich-rows.jsonl | `tu30|seeded:N2:sep:1,0,0,1,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 0, 1, 0, 0, 0, 0] | 0.0 |
| rich-rows.jsonl | `tu30|seeded:N2:sep:1,0,1,0,0,1,1,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 1, 0, 0, 1, 1, 0] | 0.0 |
| rich-rows.jsonl | `tu30|cold:N2:sep:1,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 0.0 |
| rich-rows.jsonl | `tu30|cold:N2:sep:1,0,0,1,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 0, 1, 0, 0, 0, 0] | 0.0 |
| rich-rows.jsonl | `tu30|cold:N2:sep:1,0,1,0,0,1,1,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 1, 0, 0, 1, 1, 0] | 0.0 |
| rich-rows.jsonl | `tu30|analyse:75afe44a15307efe` | tu30 | generators | - | analyse | Per [2, 2], KPer [969, 969, 44574, 44574, 19389690, 19389690 | - | 0.08 |
| rich-rows.jsonl | `tu30|analyse:f1e7f08cd5265765` | tu30 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [323, 323, 7429, 14858, 96948450,  | - | 0.26 |
| rich-rows.jsonl | `tu30|analyse:7080be1e351f267a` | tu30 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [323, 323, 7429, 14858, 6463230, 6 | - | 0.28 |
| rich-rows.jsonl | `tu30|P:N2` | tu30 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu30|gap:N4` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | gap | UNSAT | - | 3.27 |
| rich-rows.jsonl | `tu30|seeded:N4:sep:1,0,0,1,0,1,0,2` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 0, 0, 1, 0, 1, 0, 2] | 3.55 |
| rich-rows.jsonl | `tu30|seeded:N4:sep:1,1,0,0,1,0,0,1` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 1, 0, 0, 1, 0, 0, 1] | 3.31 |
| rich-rows.jsonl | `tu30|seeded:N4:sep:0,2,0,2,2,0,0,0` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 2, 0, 2, 2, 0, 0, 0] | 4.31 |
| rich-rows.jsonl | `tu30|seeded:N4:sep:0,0,2,2,0,0,0,2` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 2, 2, 0, 0, 0, 2] | 4.49 |
| rich-rows.jsonl | `tu30|seeded:N4:sep:0,0,0,0,0,2,0,2` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 2, 0, 2] | 5.2 |
| rich-rows.jsonl | `tu30|seeded:N4:sep:0,0,0,0,0,0,2,2` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 0, 2, 2] | 2.79 |
| rich-rows.jsonl | `tu30|cold:N4:sep:1,0,0,0,0,0,0,0` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 2.98 |
| rich-rows.jsonl | `tu30|cold:N4:sep:1,0,0,1,0,1,0,2` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 0, 0, 1, 0, 1, 0, 2] | 3.1 |
| rich-rows.jsonl | `tu30|cold:N4:sep:1,1,0,0,1,0,0,1` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 1, 0, 0, 1, 0, 0, 1] | 3.05 |
| rich-rows.jsonl | `tu30|cold:N4:sep:0,2,0,2,2,0,0,0` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 2, 0, 2, 2, 0, 0, 0] | 4.98 |
| rich-rows.jsonl | `tu30|cold:N4:sep:0,0,2,2,0,0,0,2` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 2, 2, 0, 0, 0, 2] | 4.32 |
| rich-rows.jsonl | `tu30|cold:N4:sep:0,0,0,0,0,2,0,2` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 2, 0, 2] | 5.53 |
| rich-rows.jsonl | `tu30|cold:N4:sep:0,0,0,0,0,0,2,2` | tu30 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 0, 2, 2] | 3.36 |
| rich-rows.jsonl | `tu30|analyse:e670f443c8341658` | tu30 | generators | - | analyse | Per [2, 2, 2, 4, 4], KPer [323, 323, 7429, 14858, 96948450,  | - | 0.89 |
| rich-rows.jsonl | `tu30|analyse:7ad4701cf1d02e79` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [17, 17, 17, 17, 170085, 340170, 6463230 | - | 0.28 |
| rich-rows.jsonl | `tu30|analyse:dbf8893c37e2ca5c` | tu30 | generators | - | analyse | Per [2, 2, 2, 4, 4], KPer [323, 323, 7429, 14858, 96948450,  | - | 0.9 |
| rich-rows.jsonl | `tu30|analyse:dcaecd3409e7fbb0` | tu30 | generators | - | analyse | Per [2, 2, 2, 4, 4], KPer [323, 323, 7429, 14858, 96948450,  | - | 0.9 |
| rich-rows.jsonl | `tu30|P:N4` | tu30 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu30|gap:11a` | tu30 | generators | [11, 11] | gap | UNSAT | - | 0.01 |
| rich-rows.jsonl | `tu30|seeded:N11a:plain` | tu30 | generators | [11, 11] | plain | UNSAT | - | 0.02 |
| rich-rows.jsonl | `tu30|P:11a` | tu30 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu30|gap:2x11a` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.92 |
| rich-rows.jsonl | `tu30|seeded:N2x11a:plain` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 1.94 |
| rich-rows.jsonl | `tu30|seeded:N2x11a:sep:1,0,0,1,1,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 1, 0, 0, 0] | 1.99 |
| rich-rows.jsonl | `tu30|seeded:N2x11a:sep:1,1,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 0, 0, 0, 0, 0, 0] | 1.9 |
| rich-rows.jsonl | `tu30|seeded:N2x11a:sep:1,1,1,1,0,0,0,1` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 1, 1, 0, 0, 0, 1] | 2.05 |
| rich-rows.jsonl | `tu30|seeded:N2x11a:sep:2,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.58 |
| rich-rows.jsonl | `tu30|seeded:N2x11a:sep:0,2,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.52 |
| rich-rows.jsonl | `tu30|cold:N2x11a:sep:1,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 2.08 |
| rich-rows.jsonl | `tu30|cold:N2x11a:sep:1,0,0,1,1,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 1, 0, 0, 0] | 2.02 |
| rich-rows.jsonl | `tu30|cold:N2x11a:sep:1,1,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 0, 0, 0, 0, 0, 0] | 1.97 |
| rich-rows.jsonl | `tu30|cold:N2x11a:sep:1,1,1,1,0,0,0,1` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 1, 1, 0, 0, 0, 1] | 2.11 |
| rich-rows.jsonl | `tu30|cold:N2x11a:sep:2,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.48 |
| rich-rows.jsonl | `tu30|cold:N2x11a:sep:0,2,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.56 |
| rich-rows.jsonl | `tu30|analyse:b5027ce1e4cca06d` | tu30 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [323, 323, 7429, 14858, 96948450,  | - | 0.3 |
| rich-rows.jsonl | `tu30|analyse:2d3e1ec7b77f790b` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [17, 17, 17, 17, 170085, 340170, 6463230 | - | 0.19 |
| rich-rows.jsonl | `tu30|analyse:2b594ca969b604e2` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [19, 19, 19, 19, 1311, 2622, 44574, 4457 | - | 0.19 |
| rich-rows.jsonl | `tu30|analyse:8f1ae8e31016f5de` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [323, 323, 7429, 7429, 3231615, 6463230, | - | 0.19 |
| rich-rows.jsonl | `tu30|P:2x11a` | tu30 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu30|gap:2x11b` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.86 |
| rich-rows.jsonl | `tu30|seeded:N2x11b:plain` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 1.99 |
| rich-rows.jsonl | `tu30|seeded:N2x11b:sep:1,0,0,1,0,1,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 0, 1, 0, 0] | 1.98 |
| rich-rows.jsonl | `tu30|seeded:N2x11b:sep:1,0,0,1,1,0,0,1` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 1, 0, 0, 1] | 2.16 |
| rich-rows.jsonl | `tu30|seeded:N2x11b:sep:1,1,0,0,1,1,1,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 0, 0, 1, 1, 1, 0] | 2.11 |
| rich-rows.jsonl | `tu30|seeded:N2x11b:sep:2,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.59 |
| rich-rows.jsonl | `tu30|seeded:N2x11b:sep:0,2,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.37 |
| rich-rows.jsonl | `tu30|cold:N2x11b:sep:1,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.99 |
| rich-rows.jsonl | `tu30|cold:N2x11b:sep:1,0,0,1,0,1,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 0, 1, 0, 0] | 2.01 |
| rich-rows.jsonl | `tu30|cold:N2x11b:sep:1,0,0,1,1,0,0,1` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 1, 0, 0, 1] | 2.17 |
| rich-rows.jsonl | `tu30|cold:N2x11b:sep:1,1,0,0,1,1,1,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 0, 0, 1, 1, 1, 0] | 2.05 |
| rich-rows.jsonl | `tu30|cold:N2x11b:sep:2,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.52 |
| rich-rows.jsonl | `tu30|cold:N2x11b:sep:0,2,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.34 |
| rich-rows.jsonl | `tu30|analyse:b82c10da2dd71e89` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [323, 323, 7429, 7429, 9694845, 19389690 | - | 0.19 |
| rich-rows.jsonl | `tu30|analyse:18f33b62899cfc69` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [323, 323, 7429, 7429, 9694845, 19389690 | - | 0.19 |
| rich-rows.jsonl | `tu30|analyse:f79d5bd3398f1ad4` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [323, 323, 7429, 7429, 48474225, 9694845 | - | 0.19 |
| rich-rows.jsonl | `tu30|analyse:801904b6dc9bd6a3` | tu30 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [323, 323, 7429, 14858, 6463230, 6 | - | 0.33 |
| rich-rows.jsonl | `tu30|P:2x11b` | tu30 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu30|gap:2x11c` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 2.02 |
| rich-rows.jsonl | `tu30|seeded:N2x11c:plain` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 1.92 |
| rich-rows.jsonl | `tu30|seeded:N2x11c:sep:1,0,0,0,0,0,1,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 1, 0] | 2.0 |
| rich-rows.jsonl | `tu30|seeded:N2x11c:sep:1,0,0,1,1,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 1, 0, 0, 0] | 2.12 |
| rich-rows.jsonl | `tu30|seeded:N2x11c:sep:1,0,1,0,0,1,1,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 0, 0, 1, 1, 0] | 2.01 |
| rich-rows.jsonl | `tu30|seeded:N2x11c:sep:1,1,1,1,0,0,0,1` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 1, 1, 0, 0, 0, 1] | 2.23 |
| rich-rows.jsonl | `tu30|seeded:N2x11c:sep:2,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.21 |
| rich-rows.jsonl | `tu30|seeded:N2x11c:sep:0,2,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.4 |
| rich-rows.jsonl | `tu30|cold:N2x11c:sep:1,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 2.0 |
| rich-rows.jsonl | `tu30|cold:N2x11c:sep:1,0,0,0,0,0,1,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 1, 0] | 2.1 |
| rich-rows.jsonl | `tu30|cold:N2x11c:sep:1,0,0,1,1,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 1, 0, 0, 0] | 2.02 |
| rich-rows.jsonl | `tu30|cold:N2x11c:sep:1,0,1,0,0,1,1,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 0, 0, 1, 1, 0] | 2.09 |
| rich-rows.jsonl | `tu30|cold:N2x11c:sep:1,1,1,1,0,0,0,1` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 1, 1, 1, 0, 0, 0, 1] | 2.07 |
| rich-rows.jsonl | `tu30|cold:N2x11c:sep:2,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.32 |
| rich-rows.jsonl | `tu30|cold:N2x11c:sep:0,2,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.2 |
| rich-rows.jsonl | `tu30|analyse:87f3fe5912c53427` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [23, 69, 69, 138, 44574, 133722] | - | 0.19 |
| rich-rows.jsonl | `tu30|analyse:fda5b84b7226af58` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [323, 323, 7429, 7429, 9694845, 19389690 | - | 0.19 |
| rich-rows.jsonl | `tu30|analyse:e20658c6390506e2` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [17, 17, 17, 17, 170085, 340170, 6463230 | - | 0.19 |
| rich-rows.jsonl | `tu30|analyse:16689c00880d24ce` | tu30 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [323, 323, 7429, 14858, 96948450,  | - | 0.31 |
| rich-rows.jsonl | `tu30|analyse:76602e83aded5434` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [23, 69, 69, 138, 44574, 133722] | - | 0.19 |
| rich-rows.jsonl | `tu30|P:2x11c` | tu30 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu30|gap:2x11d` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.98 |
| rich-rows.jsonl | `tu30|seeded:N2x11d:plain` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 2.02 |
| rich-rows.jsonl | `tu30|seeded:N2x11d:sep:2,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.52 |
| rich-rows.jsonl | `tu30|seeded:N2x11d:sep:0,1,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 0, 0, 0, 0, 0] | 2.06 |
| rich-rows.jsonl | `tu30|seeded:N2x11d:sep:0,1,0,1,1,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 1, 0, 0, 0] | 2.15 |
| rich-rows.jsonl | `tu30|seeded:N2x11d:sep:0,2,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.46 |
| rich-rows.jsonl | `tu30|seeded:N2x11d:sep:0,0,1,1,0,0,0,1` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 0, 1, 1, 0, 0, 0, 1] | 2.04 |
| rich-rows.jsonl | `tu30|cold:N2x11d:sep:1,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 2.06 |
| rich-rows.jsonl | `tu30|cold:N2x11d:sep:2,0,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.48 |
| rich-rows.jsonl | `tu30|cold:N2x11d:sep:0,1,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 0, 0, 0, 0, 0] | 1.97 |
| rich-rows.jsonl | `tu30|cold:N2x11d:sep:0,1,0,1,1,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 1, 0, 0, 0] | 2.18 |
| rich-rows.jsonl | `tu30|cold:N2x11d:sep:0,2,0,0,0,0,0,0` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.31 |
| rich-rows.jsonl | `tu30|cold:N2x11d:sep:0,0,1,1,0,0,0,1` | tu30 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 0, 1, 1, 0, 0, 0, 1] | 1.91 |
| rich-rows.jsonl | `tu30|analyse:bb1723731ecc9e89` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [323, 323, 7429, 7429, 3231615, 6463230, | - | 0.18 |
| rich-rows.jsonl | `tu30|analyse:75757045ddec4a11` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [323, 323, 7429, 7429, 3231615, 6463230, | - | 0.18 |
| rich-rows.jsonl | `tu30|analyse:3db87aafbbe76808` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [17, 17, 17, 17, 170085, 340170, 6463230 | - | 0.18 |
| rich-rows.jsonl | `tu30|analyse:60022df47385ab2f` | tu30 | generators | - | analyse | Per [2, 2, 2], KPer [19, 19, 19, 19, 1311, 2622, 44574, 4457 | - | 0.18 |
| rich-rows.jsonl | `tu30|P:2x11d` | tu30 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu30|gap:11a11b` | tu30 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 9.91 |
| rich-rows.jsonl | `tu30|seeded:N11a11b:plain` | tu30 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 11.6 |
| rich-rows.jsonl | `tu30|P:11a11b` | tu30 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu30|gap:11a11c` | tu30 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 9.55 |
| rich-rows.jsonl | `tu30|seeded:N11a11c:plain` | tu30 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 11.75 |
| rich-rows.jsonl | `tu30|P:11a11c` | tu30 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu30|gap:11a11d` | tu30 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 7.07 |
| rich-rows.jsonl | `tu30|seeded:N11a11d:plain` | tu30 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 8.94 |
| rich-rows.jsonl | `tu30|P:11a11d` | tu30 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu30|sandwich:250` | tu30 | generators | - | sandwich | - | - | - |
| rich-rows.jsonl | `tu42|setup` | tu42 | generators | - | setup | - | - | - |
| rich-rows.jsonl | `tu42|price:N2` | tu42 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:N4` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:N6` | tu42 | generators | [6, 6, 6, 6, 6, 6, 6, 6] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:11a` | tu42 | generators | [11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:2x11a` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:2x11b` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:2x11c` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:2x11d` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:11a11b` | tu42 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:11a11c` | tu42 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu42|price:11a11d` | tu42 | generators | [11, 11, 11, 11] | price | - | - | - |
| rich-rows.jsonl | `tu42|gap:N2` | tu42 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | gap | UNSAT | - | 0.0 |
| rich-rows.jsonl | `tu42|seeded:N2:sep:1,0,0,1,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 0, 1, 0, 0, 0, 0] | 0.0 |
| rich-rows.jsonl | `tu42|seeded:N2:sep:1,0,1,0,0,1,1,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 1, 0, 0, 1, 1, 0] | 0.0 |
| rich-rows.jsonl | `tu42|cold:N2:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 0.0 |
| rich-rows.jsonl | `tu42|cold:N2:sep:1,0,0,1,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 0, 1, 0, 0, 0, 0] | 0.0 |
| rich-rows.jsonl | `tu42|cold:N2:sep:1,0,1,0,0,1,1,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 2, 2] | sep | SAT | [1, 0, 1, 0, 0, 1, 1, 0] | 0.01 |
| rich-rows.jsonl | `tu42|analyse:75afe44a15307efe` | tu42 | generators | - | analyse | Per [2, 2], KPer [31, 31, 1426, 1426, 12233133510, 122331335 | - | 0.14 |
| rich-rows.jsonl | `tu42|analyse:f1e7f08cd5265765` | tu42 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [31, 31, 713, 1426, 61165667550, 6 | - | 0.46 |
| rich-rows.jsonl | `tu42|analyse:7080be1e351f267a` | tu42 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [31, 31, 713, 1426, 12233133510, 1 | - | 0.48 |
| rich-rows.jsonl | `tu42|P:N2` | tu42 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu42|gap:N4` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | gap | UNSAT | - | 2.24 |
| rich-rows.jsonl | `tu42|seeded:N4:sep:0,1,0,1,0,0,0,1` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [0, 1, 0, 1, 0, 0, 0, 1] | 2.9 |
| rich-rows.jsonl | `tu42|seeded:N4:sep:0,1,0,3,0,0,1,0` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [0, 1, 0, 3, 0, 0, 1, 0] | 2.74 |
| rich-rows.jsonl | `tu42|seeded:N4:sep:0,2,0,2,0,0,0,0` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [0, 2, 0, 2, 0, 0, 0, 0] | 2.87 |
| rich-rows.jsonl | `tu42|seeded:N4:sep:0,2,0,2,2,0,0,0` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 2, 0, 2, 2, 0, 0, 0] | 2.88 |
| rich-rows.jsonl | `tu42|seeded:N4:sep:0,0,2,2,0,0,0,2` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 2, 2, 0, 0, 0, 2] | 2.73 |
| rich-rows.jsonl | `tu42|seeded:N4:sep:0,0,0,0,0,2,0,2` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 2, 0, 2] | 2.8 |
| rich-rows.jsonl | `tu42|seeded:N4:sep:0,0,0,0,0,0,2,2` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 0, 2, 2] | 2.79 |
| rich-rows.jsonl | `tu42|cold:N4:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.23 |
| rich-rows.jsonl | `tu42|cold:N4:sep:0,1,0,1,0,0,0,1` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [0, 1, 0, 1, 0, 0, 0, 1] | 2.89 |
| rich-rows.jsonl | `tu42|cold:N4:sep:0,1,0,3,0,0,1,0` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [0, 1, 0, 3, 0, 0, 1, 0] | 2.64 |
| rich-rows.jsonl | `tu42|cold:N4:sep:0,2,0,2,0,0,0,0` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | SAT | [0, 2, 0, 2, 0, 0, 0, 0] | 2.85 |
| rich-rows.jsonl | `tu42|cold:N4:sep:0,2,0,2,2,0,0,0` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 2, 0, 2, 2, 0, 0, 0] | 2.83 |
| rich-rows.jsonl | `tu42|cold:N4:sep:0,0,2,2,0,0,0,2` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 2, 2, 0, 0, 0, 2] | 2.72 |
| rich-rows.jsonl | `tu42|cold:N4:sep:0,0,0,0,0,2,0,2` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 2, 0, 2] | 2.79 |
| rich-rows.jsonl | `tu42|cold:N4:sep:0,0,0,0,0,0,2,2` | tu42 | generators | [4, 4, 4, 4, 4, 4, 4, 4] | sep | UNSAT | [0, 0, 0, 0, 0, 0, 2, 2] | 2.73 |
| rich-rows.jsonl | `tu42|analyse:d17917bd63bfd42d` | tu42 | generators | - | analyse | Per [2, 2, 2, 4, 4], KPer [31, 31, 713, 1426, 12233133510, 1 | - | 7.54 |
| rich-rows.jsonl | `tu42|analyse:bdf03288c45819ea` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 31, 31, 2139, 4278, 4278, 4278] | - | 0.35 |
| rich-rows.jsonl | `tu42|analyse:511952cf1af59f9c` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 31, 31, 2139, 4278, 4278, 4278] | - | 0.35 |
| rich-rows.jsonl | `tu42|analyse:733fca31efa73958` | tu42 | generators | - | analyse | Per [2, 2, 2, 4, 4], KPer [31, 31, 713, 1426, 61165667550, 6 | - | 1.52 |
| rich-rows.jsonl | `tu42|P:N4` | tu42 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu42|gap:11a` | tu42 | generators | [11, 11] | gap | UNSAT | - | 0.01 |
| rich-rows.jsonl | `tu42|seeded:N11a:plain` | tu42 | generators | [11, 11] | plain | UNSAT | - | 0.02 |
| rich-rows.jsonl | `tu42|P:11a` | tu42 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu42|gap:2x11a` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.75 |
| rich-rows.jsonl | `tu42|seeded:N2x11a:plain` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 0.84 |
| rich-rows.jsonl | `tu42|seeded:N2x11a:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.83 |
| rich-rows.jsonl | `tu42|seeded:N2x11a:sep:1,0,0,1,0,1,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 0, 1, 0, 0] | 1.87 |
| rich-rows.jsonl | `tu42|seeded:N2x11a:sep:1,0,1,1,1,1,1,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 1, 1, 1, 1, 1] | 1.86 |
| rich-rows.jsonl | `tu42|seeded:N2x11a:sep:2,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.15 |
| rich-rows.jsonl | `tu42|seeded:N2x11a:sep:0,2,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.11 |
| rich-rows.jsonl | `tu42|cold:N2x11a:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.83 |
| rich-rows.jsonl | `tu42|cold:N2x11a:sep:1,0,0,0,1,1,0,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 1, 1, 0, 1] | 0.85 |
| rich-rows.jsonl | `tu42|cold:N2x11a:sep:1,0,0,1,0,1,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 0, 1, 0, 0] | 1.86 |
| rich-rows.jsonl | `tu42|cold:N2x11a:sep:1,0,1,1,1,1,1,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 1, 1, 1, 1, 1] | 1.87 |
| rich-rows.jsonl | `tu42|cold:N2x11a:sep:2,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.13 |
| rich-rows.jsonl | `tu42|cold:N2x11a:sep:0,2,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.13 |
| rich-rows.jsonl | `tu42|analyse:ab306b654854d6ee` | tu42 | generators | - | analyse | Per [2, 2], KPer [31, 31, 713, 713, 12233133510, 12233133510 | - | 0.22 |
| rich-rows.jsonl | `tu42|analyse:bbc0c64fc67bf47f` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [4812405, 9624810, 298369110, 298369110] | - | 0.27 |
| rich-rows.jsonl | `tu42|analyse:8de63b75e6c34592` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 31, 31, 2139, 4278, 4278, 4278] | - | 0.27 |
| rich-rows.jsonl | `tu42|analyse:cb24c7ef7c28f142` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 31, 31, 2139, 4278, 4278, 4278] | - | 0.26 |
| rich-rows.jsonl | `tu42|P:2x11a` | tu42 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu42|gap:2x11b` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.78 |
| rich-rows.jsonl | `tu42|seeded:N2x11b:plain` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 0.86 |
| rich-rows.jsonl | `tu42|seeded:N2x11b:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.86 |
| rich-rows.jsonl | `tu42|seeded:N2x11b:sep:1,0,0,1,1,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 1, 0, 0, 0] | 1.91 |
| rich-rows.jsonl | `tu42|seeded:N2x11b:sep:2,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.1 |
| rich-rows.jsonl | `tu42|seeded:N2x11b:sep:0,1,0,1,1,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 1, 0, 0, 0] | 1.93 |
| rich-rows.jsonl | `tu42|seeded:N2x11b:sep:0,0,2,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 0, 2, 0, 0, 0, 0, 0] | 2.12 |
| rich-rows.jsonl | `tu42|cold:N2x11b:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 1.88 |
| rich-rows.jsonl | `tu42|cold:N2x11b:sep:1,0,0,1,1,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 1, 1, 0, 0, 0] | 1.88 |
| rich-rows.jsonl | `tu42|cold:N2x11b:sep:2,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.09 |
| rich-rows.jsonl | `tu42|cold:N2x11b:sep:0,1,0,1,1,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 1, 0, 0, 0] | 1.9 |
| rich-rows.jsonl | `tu42|cold:N2x11b:sep:0,0,1,1,0,0,0,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 0, 1, 1, 0, 0, 0, 1] | 0.86 |
| rich-rows.jsonl | `tu42|cold:N2x11b:sep:0,0,2,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 0, 2, 0, 0, 0, 0, 0] | 2.14 |
| rich-rows.jsonl | `tu42|analyse:b4bf9a1a34ba9c3c` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 31, 31, 2139, 4278, 4278, 4278] | - | 0.26 |
| rich-rows.jsonl | `tu42|analyse:f73669502b47285e` | tu42 | generators | - | analyse | Per [2, 2, 2, 2, 2], KPer [31, 31, 713, 1426, 61165667550, 6 | - | 0.49 |
| rich-rows.jsonl | `tu42|analyse:a3d07df04390ac7b` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 713, 713, 6116566755, 122331335 | - | 0.26 |
| rich-rows.jsonl | `tu42|analyse:76a4cc69a7a8ae87` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [4812405, 9624810, 298369110, 298369110] | - | 0.27 |
| rich-rows.jsonl | `tu42|P:2x11b` | tu42 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu42|gap:2x11c` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.77 |
| rich-rows.jsonl | `tu42|seeded:N2x11c:plain` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 0.86 |
| rich-rows.jsonl | `tu42|seeded:N2x11c:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 0.87 |
| rich-rows.jsonl | `tu42|seeded:N2x11c:sep:1,0,1,0,0,0,1,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 0, 0, 0, 1, 1] | 1.83 |
| rich-rows.jsonl | `tu42|seeded:N2x11c:sep:2,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.09 |
| rich-rows.jsonl | `tu42|seeded:N2x11c:sep:0,1,0,1,1,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 1, 0, 0, 0] | 1.82 |
| rich-rows.jsonl | `tu42|seeded:N2x11c:sep:0,2,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.0 |
| rich-rows.jsonl | `tu42|cold:N2x11c:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 0.86 |
| rich-rows.jsonl | `tu42|cold:N2x11c:sep:1,0,1,0,0,0,1,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 0, 0, 0, 1, 1] | 1.81 |
| rich-rows.jsonl | `tu42|cold:N2x11c:sep:2,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.08 |
| rich-rows.jsonl | `tu42|cold:N2x11c:sep:0,1,0,0,0,0,1,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 0, 0, 0, 1, 1] | 0.86 |
| rich-rows.jsonl | `tu42|cold:N2x11c:sep:0,1,0,1,1,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [0, 1, 0, 1, 1, 0, 0, 0] | 1.83 |
| rich-rows.jsonl | `tu42|cold:N2x11c:sep:0,2,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 1.97 |
| rich-rows.jsonl | `tu42|analyse:ef7fd88a202c3f17` | tu42 | generators | - | analyse | Per [2, 2], KPer [31, 31, 1426, 1426, 61165667550, 611656675 | - | 0.23 |
| rich-rows.jsonl | `tu42|analyse:0f42c0c983dd2c0a` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 31, 31, 2139, 4278, 4278, 4278] | - | 0.27 |
| rich-rows.jsonl | `tu42|analyse:99ba2877a77d67fd` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 713, 713, 6116566755, 122331335 | - | 0.27 |
| rich-rows.jsonl | `tu42|analyse:8263ecd241375f06` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [23, 23, 69, 138, 4278, 4278] | - | 0.28 |
| rich-rows.jsonl | `tu42|P:2x11c` | tu42 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu42|gap:2x11d` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | gap | UNSAT | - | 1.79 |
| rich-rows.jsonl | `tu42|seeded:N2x11d:plain` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | plain | SAT | - | 0.84 |
| rich-rows.jsonl | `tu42|seeded:N2x11d:sep:1,0,1,0,0,0,1,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 0, 0, 0, 1, 1] | 1.85 |
| rich-rows.jsonl | `tu42|seeded:N2x11d:sep:1,0,1,0,1,0,0,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 0, 1, 0, 0, 1] | 0.85 |
| rich-rows.jsonl | `tu42|seeded:N2x11d:sep:2,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.17 |
| rich-rows.jsonl | `tu42|seeded:N2x11d:sep:0,2,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.06 |
| rich-rows.jsonl | `tu42|cold:N2x11d:sep:1,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 0] | 0.86 |
| rich-rows.jsonl | `tu42|cold:N2x11d:sep:1,0,0,0,0,0,0,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 0, 0, 0, 0, 0, 1] | 0.84 |
| rich-rows.jsonl | `tu42|cold:N2x11d:sep:1,0,1,0,0,0,1,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 0, 0, 0, 1, 1] | 1.85 |
| rich-rows.jsonl | `tu42|cold:N2x11d:sep:1,0,1,0,1,0,0,1` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | SAT | [1, 0, 1, 0, 1, 0, 0, 1] | 0.87 |
| rich-rows.jsonl | `tu42|cold:N2x11d:sep:2,0,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [2, 0, 0, 0, 0, 0, 0, 0] | 2.15 |
| rich-rows.jsonl | `tu42|cold:N2x11d:sep:0,2,0,0,0,0,0,0` | tu42 | generators | [2, 2, 2, 2, 2, 2, 22, 22] | sep | UNSAT | [0, 2, 0, 0, 0, 0, 0, 0] | 2.17 |
| rich-rows.jsonl | `tu42|analyse:a662ac5119165ee3` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 31, 31, 2139, 4278, 4278, 4278] | - | 0.27 |
| rich-rows.jsonl | `tu42|analyse:efbc375c20f9a4c1` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 713, 713, 6116566755, 122331335 | - | 0.28 |
| rich-rows.jsonl | `tu42|analyse:72a9820043bfa373` | tu42 | generators | - | analyse | Per [2, 2, 2], KPer [31, 31, 31, 31, 2139, 4278, 4278, 4278] | - | 0.27 |
| rich-rows.jsonl | `tu42|analyse:816ff3fb2758ec4b` | tu42 | generators | - | analyse | Per [2, 2], KPer [31, 31, 713, 713, 12233133510, 12233133510 | - | 0.23 |
| rich-rows.jsonl | `tu42|P:2x11d` | tu42 | generators | - | P | exact | - | - |
| rich-rows.jsonl | `tu42|gap:11a11b` | tu42 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 7.55 |
| rich-rows.jsonl | `tu42|seeded:N11a11b:plain` | tu42 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 9.28 |
| rich-rows.jsonl | `tu42|P:11a11b` | tu42 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu42|gap:11a11c` | tu42 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 7.95 |
| rich-rows.jsonl | `tu42|seeded:N11a11c:plain` | tu42 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 9.9 |
| rich-rows.jsonl | `tu42|P:11a11c` | tu42 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu42|gap:11a11d` | tu42 | generators | [11, 11, 11, 11] | gap | UNSAT | - | 7.68 |
| rich-rows.jsonl | `tu42|seeded:N11a11d:plain` | tu42 | generators | [11, 11, 11, 11] | plain | UNSAT | - | 9.37 |
| rich-rows.jsonl | `tu42|P:11a11d` | tu42 | generators | - | P | not colourable | - | - |
| rich-rows.jsonl | `tu42|sandwich:377` | tu42 | generators | - | sandwich | - | - | - |
| rich-rows.jsonl | `tu14|gap:N6` | tu14 | generators | [6, 6, 6, 6, 6, 6, 6, 6] | gap | UNSAT | - | 32.52 |
| rich-rows.jsonl | `tu14|sandwich:379` | tu14 | generators | - | sandwich | - | - | - |
| rich-rows.jsonl | `tu30|gap:N6` | tu30 | generators | [6, 6, 6, 6, 6, 6, 6, 6] | gap | UNSAT | - | 25.0 |
| rich-rows.jsonl | `tu30|sandwich:381` | tu30 | generators | - | sandwich | - | - | - |
| rich-rows.jsonl | `tu42|gap:N6` | tu42 | generators | [6, 6, 6, 6, 6, 6, 6, 6] | gap | UNSAT | - | 36.29 |
| rich-rows.jsonl | `tu42|sandwich:383` | tu42 | generators | - | sandwich | - | - | - |
| rich-rows.jsonl | `tu14|inadmissible` | tu14 | generators | - | inadmissible | - | - | - |
| rich-rows.jsonl | `tu14|sandwich:385` | tu14 | generators | - | sandwich | - | - | - |
| rich-rows.jsonl | `tu30|inadmissible` | tu30 | generators | - | inadmissible | - | - | - |
| rich-rows.jsonl | `tu30|sandwich:387` | tu30 | generators | - | sandwich | - | - | - |
| rich-rows.jsonl | `tu42|inadmissible` | tu42 | generators | - | inadmissible | - | - | - |
| rich-rows.jsonl | `tu42|sandwich:389` | tu42 | generators | - | sandwich | - | - | - |
