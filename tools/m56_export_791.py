"""M56 B3: the 791-forcer as the centrosymmetric core V ∩ −V of the 1581 (M41 P9), exported in tools/heule510.json's
shape (names, denom, coords, edges, primes) with the induced unit edges — coordinates exact in field16[3,5,7,11]."""
import sys, json
sys.path.insert(0, 'tools')
import field as Fld
d = json.load(open('tools/degrey_cert.json')); coords = d['coords']; denom = d['denom']; primes = d['primes']
tab = Fld.mul_table(primes)
key = {tuple(map(tuple, c)): i for i, c in enumerate(coords)}
neg = lambda c: (tuple(-x for x in c[0]), tuple(-x for x in c[1]))
core = sorted(i for i, c in enumerate(coords) if neg((tuple(c[0]), tuple(c[1]))) in key)
idx = {v: i for i, v in enumerate(core)}
E = [(idx[u], idx[v]) for u, v in d['edges'] if u in idx and v in idx]
print(f"V ∩ −V: {len(core)} vertices, {len(E)} induced unit edges (M30's 791-forcer: 791 vertices, 3938 edges)")
assert len(core) == 791 and len(E) == 3938, "the centrosymmetric core does not match the 791-forcer's counts"
json.dump(dict(names=[str(v) for v in core], denom=denom, coords=[coords[v] for v in core], edges=E, primes=primes,
               note="V ∩ −V of tools/degrey_cert.json (M41 P9: the 791-forcer); vertex i here = vertex names[i] of the 1581"),
          open('build/m56/forcer791-field16.json', 'w'))
print("wrote build/m56/forcer791-field16.json")
