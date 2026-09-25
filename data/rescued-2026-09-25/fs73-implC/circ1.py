import numpy as np
d = np.load('ball14.npz')
coords = d['coords']
half = np.array([c for c in coords if tuple(c) > tuple(-c)])
print(len(half), 'directions')
rat = half[(half[:,2]==0)&(half[:,3]==0)]
irr = half[~((half[:,2]==0)&(half[:,3]==0))]
def ok(vals, N):  # vals: integer c.a mod N
    v = vals % N
    return (3*v >= N) & (3*v <= 2*N)
found = []
for N in range(2, 301):
    a = np.arange(N)
    A1, A2 = np.meshgrid(a, a, indexing='ij'); A1 = A1.ravel(); A2 = A2.ravel()
    m = np.ones(len(A1), bool)
    for c in rat:
        m &= ok(c[0]*A1 + c[1]*A2, N)
    P = np.stack([A1[m], A2[m]], 1)
    if len(P) == 0:
        continue
    # for each (a1,a2) pair, need (a3,a4)
    A3, A4 = np.meshgrid(a, a, indexing='ij'); A3 = A3.ravel(); A4 = A4.ravel()
    cnt = 0; ex = None
    for a1, a2 in P:
        mm = np.ones(len(A3), bool)
        for c in irr:
            mm &= ok(c[0]*a1 + c[1]*a2 + c[2]*A3 + c[3]*A4, N)
            if not mm.any(): break
        k = int(mm.sum())
        if k:
            cnt += k
            if ex is None:
                i = np.nonzero(mm)[0][0]; ex = (int(a1), int(a2), int(A3[i]), int(A4[i]))
    if cnt:
        found.append((N, cnt, ex))
        print('N', N, 'solutions', cnt, 'example', ex, flush=True)
        if len(found) >= 12: break
