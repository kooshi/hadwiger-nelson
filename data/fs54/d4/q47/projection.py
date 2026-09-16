#!/usr/bin/env python3
"""FS-54 D4 at 47: project the iterations for the certificate-shaped value to fall below 369, from the measured
trajectories (trajectories.json).  The target is a drop of 0.649 % below the converged triple level 371.409; the
certificate-shaped value N sits 0.10-0.19 % above the upper reading on the calibration iterates (19: 0.105 %, 23:
0.196 %, 27: 0.07-0.19 %), so the N-crossing lies between the upper reading's 0.65 % and 1 % crossings.  Descent
iterations are counted from each plane's peak, scaled in the number of points n = q^2 by a power law, and added to
47's own peak (estimated from its measured climb).  Every exponent is fitted on four planes; the band is the spread of
the fits, not a confidence interval."""
import json, math
import numpy as np
T = json.load(open("data/fs54/d4/q47/trajectories.json"))
qs = [11, 19, 23, 27]
n = {q: q * q for q in qs + [47]}
peak47 = 420          # measured climb: lower reading 227 at 340 growing x1.8 per 47 iterations reaches the triple level ~380
out = {}
for key in ("upper_below_0.0065", "upper_below_0.01"):
    d = {q: T[str(q)][key] - T[str(q)]["peak"][0] for q in qs}
    x = np.log([n[q] for q in qs]); y = np.log([d[q] for q in qs])
    a_all, b_all = np.polyfit(x, y, 1)
    steps = {f"{qa}->{qb}": math.log(d[qb] / d[qa]) / math.log(n[qb] / n[qa]) for qa, qb in ((11, 19), (19, 23), (23, 27))}
    proj = {}
    proj["fit_all_four"] = peak47 + math.exp(b_all + a_all * math.log(n[47]))
    for name, alpha in steps.items():
        proj[f"from_27_with_exponent_{name}"] = peak47 + d[27] * (n[47] / n[27]) ** alpha
    out[key] = dict(descent_iterations=d, exponent_all_four=a_all, exponent_steps=steps,
                    projected_total_iterations_at_47={k: round(v) for k, v in proj.items()})
    print(key, json.dumps(out[key], indent=1))
json.dump(out, open("data/fs54/d4/q47/projection.json", "w"), indent=1)
