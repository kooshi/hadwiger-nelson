"""The tower's SAT confirmation AND the missing positive control of the `forces` encoding at four colours.
P_4 = Cay((O/p^4)^2, {(t,1/t)}): 65,536 vertices, degree 192.  H_min(4) is nontrivial (order 4, valuation 3), so
G54's Theorem D2-A says every four-colouring is H_min-periodic and the pairs of H_min are FORCED.  The ask pins
0 and h apart with a common neighbour at a third colour -- the same pin phase 1e uses -- so UNSAT confirms the
derivation and, at the same time, is the first time the `forces` encoding has been seen to fire anywhere."""
import sys, os, json, time, subprocess, hashlib
sys.path.insert(0,'tools')
import fs70_tower as T
import numpy as np

lv = T.level(4)
shape, lam = T.spectrum(lv)
H, _, nmin = T.h_min(lv, lam, shape)
k = len(lv.inv_factors); back = {lv.coords(e): e for e in lv.elts}
mem = {(back[tuple(int(x) for x in h[:k])], back[tuple(int(x) for x in h[k:])]) for h in H}
nz = sorted(m for m in mem if m != (lv.zero, lv.zero))
print('H_min(4) nonzero members:', nz, flush=True)
verts = [(a,b) for a in lv.elts for b in lv.elts]
idx = {v:i for i,v in enumerate(verts)}
S = T.connection_set(lv)
print(f'building P_4: {len(verts)} vertices, degree {len(S)}', flush=True)
t=time.time(); E=set()
for v in verts:
    i=idx[v]
    for s in S:
        j=idx[(lv.add(v[0],s[0]), lv.add(v[1],s[1]))]
        if i<j: E.add((i,j))
E=sorted(E); print(f'  {len(E)} edges in {time.time()-t:.0f}s', flush=True)
adj_of=lambda v: {idx[(lv.add(v[0],s[0]), lv.add(v[1],s[1]))] for s in S}
zero=(lv.zero,lv.zero); A=idx[zero]; nA=adj_of(zero)
def ask(name, pair, expect):
    Bt=idx[pair]; common=sorted(nA & adj_of(pair))
    pins=[(A,0),(Bt,1)]+([(common[0],2)] if common else [])
    p=f'build/fs70/1d/{name}.cnf'
    t=time.time()
    with open(p,'w') as f:
        n=len(verts); cls=n+4*len(E)+len(pins)
        f.write(f'p cnf {4*n} {cls}\n')
        f.write(''.join(f'{4*v+1} {4*v+2} {4*v+3} {4*v+4} 0\n' for v in range(n)))
        buf=[]
        for i,j in E:
            a=4*i; b=4*j
            buf.append(f'-{a+1} -{b+1} 0\n-{a+2} -{b+2} 0\n-{a+3} -{b+3} 0\n-{a+4} -{b+4} 0\n')
            if len(buf)>200000: f.write(''.join(buf)); buf=[]
        f.write(''.join(buf))
        f.write(''.join(f'{4*v+c+1} 0\n' for v,c in pins))
    sz=os.path.getsize(p)/2**30
    print(f'  {name}: CNF {sz:.2f} GB written in {time.time()-t:.0f}s, {len(common)} common neighbours', flush=True)
    t=time.time()
    try:
        r=subprocess.run(['kissat','-q',p],capture_output=True,text=True,timeout=5400)
        out=r.stdout
    except subprocess.TimeoutExpired:
        out=''
    v='UNKNOWN'
    for line in out.splitlines():
        if line.startswith('s '): v='UNSAT' if 'UNSATISFIABLE' in line else 'SAT'
    secs=time.time()-t
    print(f'  {name}: {v} in {secs:.0f}s (expected {expect}) {"OK" if v==expect else "MISMATCH"}', flush=True)
    os.remove(p)
    return {'ask':name,'pair':[list(pair[0]),list(pair[1])],'verdict':v,'expected':expect,
            'seconds':round(secs,1),'common_neighbours':len(common),'vertices':len(verts),'edges':len(E)}
rows=[]
rows.append(ask('P4_forces_hmin', nz[0], 'UNSAT'))
# negative control: a pair of valuation 2 -- outside H_min, and the additive bound separates it
two = T.split_E(((__import__('fractions').Fraction(2),)+(__import__('fractions').Fraction(0),)*3,
                 (__import__('fractions').Fraction(0),)*4), lv)
print('the image of delta = 2 at level 4:', two, 'valuation', T._val(lv,two[0]), flush=True)
rows.append(ask('P4_forces_two', two, 'SAT'))
json.dump(rows, open('data/fs70/tower/forces-confirmation.json','w'), indent=1)
print('wrote data/fs70/tower/forces-confirmation.json', flush=True)
