#!/usr/bin/env python3
"""FS111-P §PA: query the zbMATH Open API (WORKFLOW 3.2 item 8), save the JSON under data/fs111/fs111-p/zb_<name>.json, and print each hit:
year | authors | title | source | Zbl | [review kind] first 300 characters. An author's `summary` is a claim, never a reading (G50).

Usage:  tools/fs111_p_zb.py <name> '<search_string>'        (e.g. 'ab:"unit distance" & ab:measurable')
        tools/fs111_p_zb.py --self-test                      (positive control: Zbl 0599.28008 must return Falconer-Marstrand 1986;
                                                              negative control: a nonsense query must return the API's clean zero — status 404 with "No results found" —, never a network error read as 0)
"""
import json, subprocess, sys, pathlib

OUT = pathlib.Path(__file__).resolve().parent.parent / 'data' / 'fs111' / 'fs111-p'
API = 'https://api.zbmath.org/v1/document/_search'


def query(q, n=100):
    r = subprocess.run(['curl', '-sS', '-G', API, '--data-urlencode', f'search_string={q}',
                        '--data-urlencode', f'results_per_page={n}'], capture_output=True, text=True, timeout=120)
    if r.returncode != 0:
        raise SystemExit(f'curl failed ({r.returncode}): {r.stderr[:300]}')
    return json.loads(r.stdout)


def show(d):
    st = d.get('status', {})
    res = d.get('result')
    if st.get('status_code') == 404 and 'No results found' in (st.get('internal_code') or ''):
        print('total: 0 (the API answers a clean zero with status 404, "No results found")')
        return []
    print('total:', st.get('nr_total_results'), '| status:', st.get('status_code'))
    if not isinstance(res, list):
        print('  (no result list)', str(d)[:300])
        return []
    for x in res:
        t = (x.get('title') or {}).get('title', '?')
        au = '; '.join(a.get('name', '?') for a in ((x.get('contributors') or {}).get('authors') or []))
        yr = x.get('year')
        so = ' '.join(s.get('source', '') for s in (x.get('source') or {}).get('series', []) or []) or str((x.get('source') or {}).get('source', ''))
        zbl = x.get('identifier')
        ec = x.get('editorial_contributions') or []
        kind, txt = '', ''
        if ec:
            kind = ec[0].get('contribution_type', '')
            txt = (ec[0].get('text') or '')[:300].replace('\n', ' ')
        print(f'- {yr} | {au} | {t} | {so} | {zbl} | [{kind}] {txt}')
    return res


def main():
    if sys.argv[1:] == ['--self-test']:
        d = query('an:0599.28008')
        res = d.get('result') or []
        ok_pos = any('positive density at infinity' in ((x.get('title') or {}).get('title') or '') for x in res)
        d2 = query('ti:"qwzxv plorbt"')
        st2 = d2.get('status', {})
        ok_neg = st2.get('status_code') == 404 and 'No results found' in (st2.get('internal_code') or '')
        print('positive control (Falconer-Marstrand found):', ok_pos)
        print('negative control (nonsense returns a clean 0):', ok_neg)
        raise SystemExit(0 if (ok_pos and ok_neg) else 1)
    name, q = sys.argv[1], sys.argv[2]
    d = query(q)
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / f'zb_{name}.json').write_text(json.dumps(d, indent=1))
    print('query:', q)
    show(d)


if __name__ == '__main__':
    main()
