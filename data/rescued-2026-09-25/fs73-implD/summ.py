import json, collections
rows=[json.loads(l) for l in open('data/fs73/census/rich-rows.jsonl') if l.strip()]
by=collections.defaultdict(dict)
for d in rows:
    if '|' not in d['key']: continue
    tag, body = d['key'].split('|',1)
    by[tag][body]=d
for tag in by:
    R=by[tag]; print(tag)
    for body,d in R.items():
        if body.startswith('price:'):
            nm=body[6:]
            g=R.get('gap:'+nm); P=R.get('P:'+nm)
            ptxt = (P['status']+' '+str(P.get('P',{}).get('Lambda_mod',{}).get('torsion')) + (' cold='+str(P.get('cold_reproduces')) if 'cold_reproduces' in P else '')) if P else '-'
            print(f"  {nm}: {d['classes']} cl, {d['generator_classes']} gcl, adm {d['admissible']}, ~{d['est_gb']} GB | gap {g['verdict'] if g else '-'} {g.get('cpu_s') if g else ''} | P {ptxt}")
    an=[d for b,d in R.items() if b.startswith('analyse:')]
    print('  analysed', len(an), 'KPer ranks', sorted({d['KPer_rank'] for d in an}))
    sw=[d for b,d in R.items() if b.startswith('sandwich')]
    if sw: print('  sandwich', sw[-1]['P_found']['Lambda_mod'], sw[-1]['targets_in_P_found'], sw[-1]['periods_searched'])
    cpu=sum(d.get('cpu_s',0) or 0 for d in R.values()); print('  solver cpu s', round(cpu,1))
