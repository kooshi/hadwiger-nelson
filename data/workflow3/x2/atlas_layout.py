#!/usr/bin/env python3
"""X2 stage 5b: place the new atlas nodes by the layout lint. Phase 1: random search on the new nodes' (theta, r) until 0 overlaps;
phase 2: shrink their displacement from the starting guess while keeping 0. Fixed seed. Writes atlas_positions.json."""
import sys, io, random, contextlib, importlib, json, math
sys.path.insert(0,'/home/kooshi/source/lean-dir-close/tools')
f=importlib.import_module('viz_proof_atlas_facts')
NEW=['GFREE','RINGRULE','YESLIM','FS123','FS124','FS125','FS126','FS127','FS128']
by={n['id']:n for n in f.NODES}
def count():
    buf=io.StringIO()
    with contextlib.redirect_stdout(buf): f.lint()
    return int(buf.getvalue().strip().split('\n')[-1].split(':')[1].split()[0])
rng=random.Random(20261003)
start0={i:(by[i]['theta'],by[i]['r']) for i in NEW}
rng_th={'YESLIM':(100,118)}
def move(nid):
    n=by[nid]; old=(n['theta'],n['r']); lo,hi=rng_th.get(nid,(3,78))
    n['theta']=min(hi,max(lo,old[0]+rng.randint(-6,6))); n['r']=min(620,max(150,old[1]+rng.randint(-30,30))); return n,old
best=count(); print('start',best)
for it in range(40000):
    if best==0: break
    n,old=move(rng.choice(NEW)); c=count()
    if c<=best: best=c
    else: n['theta'],n['r']=old
assert best==0
def disp(): return sum(math.hypot((by[i]['theta']-start0[i][0])*5,(by[i]['r']-start0[i][1])/3) for i in NEW)
d=disp()
for it in range(3000):
    n,old=move(rng.choice(NEW))
    if disp()<d and count()==0: d=disp()
    else: n['theta'],n['r']=old
print('end',count(),{i:(by[i]['theta'],by[i]['r']) for i in NEW})
json.dump({i:(by[i]['theta'],by[i]['r']) for i in NEW},open('/home/kooshi/source/lean-dir-close/data/workflow3/x2/atlas_positions.json','w'))
