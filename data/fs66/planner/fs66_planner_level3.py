#!/usr/bin/env python3
"""Scratch: level THREE at 11, four colours, asked on the preimage (in (Z/1331)^2) of a level-two vertex set.
Streams a plain CNF (ALO + one clause per edge and colour + a pinned triangle). Vertex ids are local indices."""
import sys, json, time, numpy as np
p = 11; n2 = 121; n3 = 1331; k = int(sys.argv[2]); out = sys.argv[3]
core = json.load(open(sys.argv[1]))["verts"]
t0 = time.time()
sq = (np.arange(n3, dtype=np.int64)**2) % n3
S3 = [(a, b) for a in range(n3) for b in np.nonzero((sq[a] + sq) % n3 == 1)[0].tolist()]
assert len(S3) == p*p*(p+1), len(S3)
# preimage vertices
pre = []
for v in core:
    a, b = divmod(v, n2)
    for i in range(p):
        for j in range(p):
            pre.append((a + n2*i) * n3 + (b + n2*j))
pre = np.array(sorted(pre), dtype=np.int64); N = len(pre)
lookup = -np.ones(n3*n3, dtype=np.int32); lookup[pre] = np.arange(N, dtype=np.int32)
A = pre // n3; B = pre % n3
src = []; dst = []
for (x, y) in S3:
    w = lookup[((A + x) % n3) * n3 + ((B + y) % n3)]
    m = w >= 0
    idx = np.nonzero(m)[0]
    keep = idx < w[idx]
    src.append(idx[keep].astype(np.int32)); dst.append(w[idx][keep])
src = np.concatenate(src); dst = np.concatenate(dst)
E = len(src)
deg = np.bincount(np.concatenate([src, dst]), minlength=N)
print(f"level-3 preimage: {N} vertices, {E} edges, degree min/mean/max = {deg.min()}/{deg.mean():.1f}/{deg.max()}  ({time.time()-t0:.0f}s)", flush=True)
# a triangle through vertex 0
adj0 = set(dst[src == 0].tolist()) | set(src[dst == 0].tolist())
tri = None
es = set(zip(src.tolist(), dst.tolist())) if E < 3_000_000 else None
for u in sorted(adj0):
    nu = set(dst[src == u].tolist()) | set(src[dst == u].tolist())
    c = adj0 & nu
    if c: tri = (0, u, min(c)); break
print("pinned triangle (local ids):", tri, flush=True)
with open(out, "w") as f:
    f.write(f"p cnf {N*k} {N + E*k + (3 if tri else 0)}\n")
    V = np.arange(N, dtype=np.int64)[:, None]*k + np.arange(1, k+1)[None, :]
    np.savetxt(f, np.hstack([V, np.zeros((N, 1), dtype=np.int64)]), fmt="%d")
    for c in range(k):
        blk = np.stack([-(src.astype(np.int64)*k + c + 1), -(dst.astype(np.int64)*k + c + 1), np.zeros(E, dtype=np.int64)], axis=1)
        np.savetxt(f, blk, fmt="%d")
    if tri:
        for c, v in enumerate(tri): f.write(f"{v*k + c + 1} 0\n")
print(f"wrote {out} ({time.time()-t0:.0f}s)", flush=True)
