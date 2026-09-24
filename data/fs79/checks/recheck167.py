"""Owner's re-ask of phase 0's survivors at the ramified prime 167 (the competition advisor's card, 2026-09-24).
Phase 0 asked 167 for 15 s (UNKNOWN). Here: per distinct residue image, gap-aimed then plain, 300 s each (kissat), one ask per
invocation so each takes the heavy lock separately. Resumable: results appended to data/fs79/phase0/owner-recheck-167.jsonl.
Usage: python3 recheck167.py plan            -> writes the image table, prints the ask list
       python3 recheck167.py ask <idx> <gap|plain>"""
import sys, json, os
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
os.chdir('/home/kooshi/source/lean-dir')
import fs79_p0 as P
OUTF = P.OUT / 'owner-recheck-167.jsonl'
PLAN = P.OUT / 'owner-recheck-167-plan.json'
SURV = ['2448', '2328', '2400', '4200', '10920', '14280', '24360', '12600', '16800', '21000', '25200', '29400']
q, s = 167, 0
if sys.argv[1] == 'plan':
    imgs = {}
    for lid in SURV:
        M = int(lid); U = P.units_M(M)
        Ub = tuple(sorted({P.reduce_vec(u, M, q, s) for u in U}))
        circ = set(P.circle(q)); assert all(p in circ for p in Ub)
        imgs.setdefault(Ub, []).append((lid, len(U)))
    plan = [{'idx': i, 'image': [list(p) for p in Ub], 'size': len(Ub), 'lattices': L} for i, (Ub, L) in enumerate(imgs.items())]
    PLAN.write_text(json.dumps(plan))
    for p in plan: print(p['idx'], 'image', p['size'], 'lattices', p['lattices'])
else:
    idx, aim = int(sys.argv[2]), sys.argv[3]
    plan = json.loads(PLAN.read_text()); p = plan[idx]
    done = [json.loads(l) for l in open(OUTF)] if OUTF.exists() else []
    if any(r['idx'] == idx and r['aim'] == aim for r in done): print('skip', idx, aim); sys.exit(0)
    Ub = [tuple(x) for x in p['image']]
    r = P.residue_ask(q, Ub, 4, gap=(aim == 'gap'), budget=300.0)
    rec = {'idx': idx, 'aim': aim, 'q': q, 's': s, 'image': p['size'], 'lattices': p['lattices'], 'verdict': r['verdict'],
           'by': r['by'], 'cpu_s': r.get('cpu_s'), 'hoffman_floor': r.get('hoffman_floor'), 'who': 'owner', 'machine': P.MACHINE}
    if r.get('colouring'):
        rec['colouring'] = r['colouring']
    with open(OUTF, 'a') as f:
        f.write(json.dumps(rec, sort_keys=True) + '\n'); f.flush(); os.fsync(f.fileno())
    print(idx, aim, r['verdict'], r['by'][:80], r.get('cpu_s'))
