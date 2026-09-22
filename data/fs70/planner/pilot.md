# The planner's pilot measurements (2026-09-21, desktop, kissat 4.0.4, PARI 2.17)

Commands, in the order run; outputs are the tables of `plans/FS70-five-over-sqrt3-sqrt5.md` §2.

```
python3 tools/fs70_field.py --selftest                       # depths: zeta12 (0,0,0); u (0,-2,0); v (2,0,0); rho15 (-4,0,0); w (-1,0,0)
python3 tools/fs70_fabric.py lattice zeta12 zeta12+u3 zeta12+u3+q7 zeta12+v4 zeta12+w4 zeta12+u3+v4 zeta12+u3+w4   # §2.2
python3 tools/fs70_fabric.py tn zeta12+v4 6 --out build/fs70/tn-v4-6            # T_6: 2,115 pts / 10,489 edges / deg 9.92
python3 tools/fs70_fabric.py tn zeta12+u3 6 --target 4/3 --out build/fs70/tn-u3-43-6   # 2,188 / 10,128 / 9.26
python3 tools/fs70_fabric.py ball zeta12+v4 2   --out build/fs70/ball-v4-2      # 3,793 / 15,990 / 8.43  (predicted 3,152 / 7.9)
python3 tools/fs70_fabric.py ball zeta12+v4 2.5 --out build/fs70/ball-v4-25     # 19,957 / 111,990 / 11.22 (predicted 18,790 / 11.2); 3 m 22 s to build
kissat -q <dir>/{control,pinned,pinned_neq,sep_isqrt3,eq_isqrt3,sep_2,eq_2}.cnf  # every verdict SAT; longest 10.9 s (sep_isqrt3 at R = 2.5)
```

`tn zeta12+u3 8 --target 4/3` was killed by PID at 7.5 min / 5.8 GB RSS (rational-arithmetic BFS to depth 8): §3.7 of the plan.

The `units_of_denominator(M)` table for M ≤ 16 and the depth-by-denominator counts are in the plan's §2.1 (regenerate with
`python3 -c "import sys; sys.path.insert(0,'tools'); from fs70_field import *; ..."`, or the atlas command phase 0.1 adds).
