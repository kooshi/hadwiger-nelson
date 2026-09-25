"""Cross-check the verifier's C4 thresholds with phase 0's relation tree (tools/fs81_theta.py, imported unmodified),
each verdict then re-checked by tools/fs81_theta_check.py --no-enumerate. Outputs in the verifier's scratch only."""
import json, os, subprocess, sys, time
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import fs81_theta as T
OUT = os.path.dirname(os.path.abspath(__file__))
cases = [  # (d, config, K, predicted)
    (11, "B", 1, "EMPTY"), (11, "A", 1, "NONEMPTY"), (11, "A", 2, "NONEMPTY"),
    (23, "A", 1, "NONEMPTY"), (23, "A", 2, "EMPTY"), (47, "A", 1, "NONEMPTY"), (47, "A", 2, "EMPTY"),
    (35, "B", 2, "EMPTY"), (59, "A", 2, "NONEMPTY"), (107, "B", 2, "NONEMPTY"), (119, "A", 2, "NONEMPTY"),
]
if len(sys.argv) > 1:
    cases = [c for c in cases if f"{c[0]}{c[1]}{c[2]}" in sys.argv[1:]]
for d, name, K, pred in cases:
    tag = f"d{d}-{name}-K{K}"
    out = os.path.join(OUT, tag + ".json")
    rec_path = os.path.join(OUT, tag + ".rec.json")
    if os.path.exists(rec_path):
        print(open(rec_path).read().strip()); continue
    layers = T.configuration(d, name, K)
    D, units = T.units_of(d, layers, K)
    t0 = time.time()
    res = T.decide(d, D, units, out, ckpt_path=None, cap_s=100.0, screen=(3, 6, 9, 12), log=lambda *a: None)
    verdict = res["verdict"]
    chk = "-"
    if verdict in ("EMPTY", "NONEMPTY"):
        p = subprocess.run([sys.executable, "/home/kooshi/source/lean-dir/tools/fs81_theta_check.py", "--no-enumerate", out],
                           capture_output=True, text=True)
        chk = ("PASS" if p.returncode == 0 else "FAIL") + ": " + (p.stdout + p.stderr).strip().splitlines()[-1][:120]
    rec = {"d": d, "config": name, "K": K, "pairs": len(units), "D": D, "predicted": pred, "verdict": verdict,
           "agree": verdict == pred, "finder": res.get("finder"), "nodes": res["stats"].get("nodes"),
           "wall_s": round(time.time() - t0, 1), "check": chk}
    json.dump(rec, open(rec_path, "w"))
    print(json.dumps(rec), flush=True)
