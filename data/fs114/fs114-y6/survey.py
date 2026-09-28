# FS114-Y6 stage 4: FLOAT survey of held fragments (aiming only; no claim rests on these numbers).
# For each degree-4 vertex: colours, unit-arc edges with their centres, the inner tile, whether the centre lies in it, and the tiles of the outer colour at the centre; rimdist is a float estimate.
import sys, math, os
sys.path.insert(0, 'tools')
import fs114_yb3_run as XR
import fs112_yb2_objects as O, fs112_yb3_frags as F, fs114_yb2_run as B
def f(p): return (float(p[0]), float(p[1]))
def objects():
    yield "strip", XR.conv_tiles(O.Strip().tiles(-4, 6))
    yield "disk", XR.conv_tiles(O.Disk().tiles())
    yield "FS112-BOWTIE", XR.conv_tiles(F.bowtie())
    yield "YB2 bowtie (Y2-BOWTIE rebuild)", XR.conv_tiles(B.Bowtie().tiles())
def key(p): return (round(p[0], 7), round(p[1], 7))
for name, T in objects():
    pieces = {}   # tile -> list of (kind, a, b, C, rho)
    ptiles = {}   # point -> set of tiles
    pk = {}       # piece key -> tiles
    for nm, (col, ps) in T.items():
        for pc in ps:
            if pc.kind == "S":
                a, b = f(pc.P), f(pc.Q); rec = ("S", a, b, None, None)
            else:
                a, b = f(pc.S), f(pc.E); rec = ("A", a, b, f(pc.C), float(pc.rho))
            pieces.setdefault(nm, []).append(rec)
            for x in (a, b): ptiles.setdefault(key(x), set()).add(nm)
            k = (rec[0], frozenset([key(a), key(b)]), key(rec[3]) if rec[3] else None)
            pk.setdefault(k, set()).add(nm)
    rim = [k for k, v in pk.items() if len(v) == 1]
    def rimdist(v):
        best = 9
        for k in rim:
            kind, ends, C = k
            ends = list(ends)
            for e in ends: best = min(best, math.dist(v, e))
            if kind == "S" and len(ends) == 2:
                a, b = ends; ax, ay = b[0]-a[0], b[1]-a[1]; L = ax*ax+ay*ay
                t = max(0, min(1, ((v[0]-a[0])*ax+(v[1]-a[1])*ay)/L)); best = min(best, math.dist(v, (a[0]+t*ax, a[1]+t*ay)))
            if kind == "A":
                # distance to circle arc approx: sample
                a, b = ends; r = math.dist(a, C)
                a0 = math.atan2(a[1]-C[1], a[0]-C[0]); b0 = math.atan2(b[1]-C[1], b[0]-C[0])
                d = (b0 - a0) % (2*math.pi)
                for i in range(201):
                    t = a0 + d*i/200; best = min(best, math.dist(v, (C[0]+r*math.cos(t), C[1]+r*math.sin(t))))
        return best
    colour = {nm: T[nm][0] for nm in T}
    print(f"== {name}: {len(T)} tiles")
    for v, ts in ptiles.items():
        if len(ts) != 4: continue
        # edges at v: shared pieces with endpoint v
        edges = [(k, pk[k]) for k in pk if len(pk[k]) == 2 and v in k[1]]
        cols = sorted(set(colour[t] for t in ts))
        tact = 0; desc = []
        for k, two in edges:
            kind, ends, C = k
            if kind != "A": desc.append("seg"); continue
            # radius
            e = list(ends)[0]; r = math.dist(e, C)
            if abs(r - 1) > 1e-6: desc.append(f"arc r{r:.3f}"); continue
            q = C
            a, b = sorted(two)
            # inner tile: the one with a point inside B(q,1) near the arc midpoint: test tile vertex set
            def inside(t):
                pts = [x for rec in pieces[t] for x in (rec[1], rec[2])]
                return any(math.dist(x, q) < 1 - 1e-7 for x in pts)
            inn = a if inside(a) else b; out = b if inn == a else a
            q_in_inner = any(math.dist(x, q) < 1e-7 for rec in pieces[inn] for x in (rec[1], rec[2]))
            Ts = [t for t in ptiles.get(key(q), set()) if colour[t] == colour[out] and t != out]
            ok = q_in_inner and bool(Ts)
            tact += ok
            desc.append(f"unit arc c={tuple(round(z,3) for z in q)} inner={inn} q∈inner={q_in_inner} T={Ts}")
        if tact >= 1 or len(cols) >= 4:
            print(f" v={v} deg4 colours={cols} tactic={tact} rimdist={rimdist(v):.4f}")
            for d in desc: print("    ", d)
