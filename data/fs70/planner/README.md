# data/fs70/planner — the planner's records for FS-70 (2026-09-21)

| path | what | produced by |
|---|---|---|
| `pa/zb-*.json` | raw zbMATH Open API responses of the prior-art gate (`plans/FS70-five-over-sqrt3-sqrt5.md` §PA): author listings (`au-*`), topic searches (`moser-spindle`, `ud-numberfield`, `chrom-plane-field`, `five-chrom`, `mono-pair`, `additive-col`), `polymath` | `curl -G https://api.zbmath.org/v1/document/_search --data-urlencode search_string=…` |
| `pilot.md` | the planner's phase-0 measurements (unit-vector atlas by denominator with depths, lattice saturations and the additive screen, ball law, pilot SAT asks), as run | `tools/fs70_field.py`, `tools/fs70_fabric.py`; the numbers are in the plan's §2 |

Nothing here is a certificate; every number is regenerable from the two tools.
