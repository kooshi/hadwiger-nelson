import sys, gzip, hashlib, time, math
sys.path.insert(0, 'tools')
import numpy as np
import fs61_census as C
FS = C.FS
key = '120|1,1,1,3;0,2,0,2;0,0,2,2;0,0,0,4'
D = 167
M, H = C.parse_key(key)
S = C.saturation(D, M, H)
print('units', len(S))
B, coords, cov, mc = FS.reduce_pool(D, M, S)
print('basis (a,b,c,e over M):', B)
print('cov', cov, 'max coord', mc)
for c, s in zip(coords, S):
    print(c, s)
t = time.time()
X, n = FS.piece(D, M, B, (0,0,0,0), 'ball', 1.6656, 2_000_000)
E = FS.piece_edges(X, coords)
print('points', len(X), 'edges', len(E), time.time()-t)
raw = gzip.open('data/fs61/fields/167/models/ea65e4e3687e5bc9.bin.gz').read()
print(hashlib.sha256(raw).hexdigest())
col = np.frombuffer(raw, dtype=np.uint8)
print(len(col), np.bincount(col))
print('proper', bool((col[E[:,0]] != col[E[:,1]]).all()))
np.savez_compressed('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-implC/ball14.npz', X=X, col=col, E=E, coords=np.array(coords), B=np.array(B))
