import sys, json
from collections import Counter
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools'); import fs79_p0 as P
last = {}
for r in P.load_jsonl(P.OUT / 'verdicts.jsonl'):
    last[r['lattice']] = r
sw = {str(r['M']): r for r in P.load_jsonl(P.OUT / 'sweep.jsonl')}
sw['L21cc6506'] = sw['420']
sc = {}
for r in P.load_jsonl(P.OUT / 'screen.jsonl'):
    sc.setdefault(r['lattice'], []).append(r)
col = [v for v in last.values() if v['verdict'] == 'FOUR-COLOURABLE']
sur = [v for v in last.values() if v['verdict'] == 'SURVIVOR']
print('screened', len(last), 'four-colourable', len(col), 'survivors', len(sur))
print('first rule:', Counter(v['rules'][0] for v in col), '| gapped', sum(v['gapped'] for v in col))
for v in sorted(sur, key=lambda v: -v['units']):
    L = v['lattice']; s = sw.get(L, {})
    th = [r for r in sc[L] if r['screen'].startswith('theta4')]
    res = [r for r in sc[L] if r['screen'].startswith('residue')]
    rs = ', '.join(f"{r['q']}/{r['s']}:{r['plain']}({r['image']}/{r['circle']})" for r in res)
    qt = [r for r in P.load_jsonl(P.OUT / 'quotients.jsonl') if f'|L{s.get("M")}|' in r['key']]
    print(f"- {L}: {v['units']} units, price18 {(s.get('price18') or {}).get('points')}; additive none; "
          f"Theta4 {[(r['screen'], r['status'], r['nodes']) for r in th]}; residue {rs}; quotients {[(r['key'].split('|')[-2:], r['verdict']) for r in qt]}")
# minimal survivors and the inclusion classification of the unscreened remainder (Lambda_X <= Lambda_Y iff X | Y, true denominators)
Mof = lambda L: 420 if L == 'L21cc6506' else int(L)
survM = sorted(Mof(v['lattice']) for v in sur)
minimal = [X for X in survM if not any(Y != X and X % Y == 0 for Y in survM)]
print('minimal survivors', [(X, last[str(X) if X != 420 else 'L21cc6506']['units']) for X in sorted(minimal, key=lambda X: last[str(X)]['units'])])
print('non-minimal survivors', [(X, [Y for Y in survM if Y != X and X % Y == 0]) for X in survM if X not in minimal])
colM = {Mof(v['lattice']): v for v in col}
pool = P.auto_ids('all')
uns = [L for L in pool if L not in last]
rows = {'restriction': [], 'contains_survivor': [], 'not_screened': []}
for L in uns:
    M = Mof(L)
    up = [Y for Y in colM if Y % M == 0 and Y != M]
    dn = [X for X in survM if M % X == 0 and X != M]
    s = sw[str(M)]
    if up:
        rows['restriction'].append((M, s['units'], up[0], colM[up[0]]['rules']))
    elif dn:
        rows['contains_survivor'].append((M, s['units'], dn))
    else:
        rows['not_screened'].append((M, s['units'], (s.get('price18') or {}).get('points')))
for k, v in rows.items():
    print(k, len(v), v[:40])
