"""copy_controls — the controls the centre sweep demands before 'the lock is a property of the material'
may be read: (i) the ρ₁₅ angle perturbed (cross chords must vanish and the union must be SAT);
(ii) the same rotation (about 206 and about v0) on the EARLIER objects — the seed's unit part alone
(214 points), iteration 1 (690), iteration 2 (1,008), iteration 3 before deletion (1,862) — to date
the lock's first appearance; (iii) the Moser (√3) angle as the many-chords-but-SAT control, re-read."""
from __future__ import annotations
import json, math, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
from batchkill import BUILD, load_object
import copy_probe as CP

def rot(C, th):
    R = np.array([[math.cos(th), -math.sin(th)], [math.sin(th), math.cos(th)]])
    return lambda Q: C + (Q - C) @ R.T

def run(tag, pts, live, ue, C, th, cap=600):
    n2, e2, info = CP.union_graph(pts, live, ue, rot(np.array(C), th))
    st, t = CP.ask_k(n2, e2, 4, cap)
    print(f"[ctrl] {tag:60s} n={n2:5d} cross={info['cross']:5d} fused={info['fused']:3d} k=4 {st.upper():7s} {t:5.1f}s", flush=True)
    return dict(tag=tag, n=n2, cross=info["cross"], fused=info["fused"], k4=st, secs=round(t, 1))

def main():
    out = []
    th2 = 2 * math.asin(0.25)
    # (i) perturbed angles on the it-4 object about 206
    obj, _ = load_object("S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28")
    ue = obj.unit_edges(); live = set(range(obj.n)) - set(obj.deleted)
    st, t = CP.ask_k(obj.n, ue, 4, 60); print(f"[ctrl] it-4 U alone k=4: {st.upper()} (must be SAT)", flush=True)
    for dd in (0.3, -0.3, 1.0, -1.0, 5.0):
        out.append(run(f"it-4 about206 angle {math.degrees(th2)+dd:.4f} (perturbed {dd:+.1f})", obj.pts, live, ue, obj.pts[206], th2 + math.radians(dd)))
    # (ii) earlier objects
    for label, name in [("S29-depth2r", "it-1 (690)"), ("S29-depth2r-it2v2-depth1", "it-2 (1,008)"),
                        ("S29-depth2r-it2v2-depth1-it2v2-depth1", "it-3 (1,862, before deletion)")]:
        o, _ = load_object(label); u = o.unit_edges(); lv = set(range(o.n)) - set(getattr(o, "deleted", []) or [])
        st, t = CP.ask_k(o.n, u, 4, 60); print(f"[ctrl] {name} U alone k=4: {st.upper()}", flush=True)
        for c in (206, 0):
            out.append(run(f"{name} about {c} rho15 angle", o.pts, lv, u, o.pts[c], th2))
        out.append(run(f"{name} about 206 Moser angle (sqrt3)", o.pts, lv, u, o.pts[206], 2 * math.asin(1 / (2 * math.sqrt(3)))))
    # the seed alone: the it-1 object's first 214 points and the unit edges among them
    o, _ = load_object("S29-depth2r"); seed_edges = [e for e in o.unit_edges() if e[0] < 214 and e[1] < 214]
    seed_pts = o.pts[:214]; lv = set(range(214))
    st, t = CP.ask_k(214, seed_edges, 4, 60); print(f"[ctrl] seed unit part alone (214 pts, {len(seed_edges)} unit edges) k=4: {st.upper()}", flush=True)
    for c in (206, 0):
        out.append(run(f"seed (214) about {c} rho15 angle", seed_pts, lv, seed_edges, seed_pts[c], th2))
    json.dump(out, open(BUILD / "m51-copycontrols.json", "w"), indent=1)

if __name__ == "__main__":
    main()
