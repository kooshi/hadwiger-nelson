#!/usr/bin/env python3
"""FS111-C §PA sweep: query the zbMATH Open API, save the JSON under data/fs111/fs111-c/zb_<name>.json, print the total and each hit
(year | first author | title | Zbl). An author's summary is a claim, never a reading (G50).

Usage:  tools/fs111_c_zb.py <name> '<search_string>'
        tools/fs111_c_zb.py --self-test
          positive control: an:0599.28008 must return Falconer–Marstrand 1986 (total 1);
          negative control: a nonsense query must return the API's clean zero (status 404, "No results found") — never a network error read as 0.
"""
import json, subprocess, sys, pathlib

OUT = pathlib.Path(__file__).resolve().parent.parent / 'data' / 'fs111' / 'fs111-c'
API = 'https://api.zbmath.org/v1/document/_search'


def query(q, n=100, tries=4):
    import time
    for i in range(tries):
        try:
            return _query(q, n)
        except SystemExit as e:
            if i == tries - 1 or 'not JSON' not in str(e):
                raise
            time.sleep(3)


def _query(q, n=100):
    r = subprocess.run(['curl', '-sS', '-G', API, '--data-urlencode', f'search_string={q}',
                        '--data-urlencode', f'results_per_page={n}'], capture_output=True, text=True, timeout=120)
    if r.returncode != 0:
        raise SystemExit(f'curl failed ({r.returncode}): {r.stderr[:300]}')
    try:
        return json.loads(r.stdout)
    except json.JSONDecodeError:
        raise SystemExit(f'not JSON (a server error, never a zero): {r.stdout[:200]!r}')


def total(d):
    st = d.get('status', {})
    if st.get('status_code') == 404 and 'No results found' in (st.get('internal_code') or ''):
        return 0
    if st.get('status_code') != 200:
        raise SystemExit(f'API status {st.get("status_code")}: {st}')
    return int(st.get('nr_total_results'))


def lines(d):
    out = []
    for x in d.get('result') or []:
        t = (x.get('title') or {}).get('title', '')
        a = ((x.get('contributors') or {}).get('authors') or [{}])[0].get('name', '')
        out.append(f"{x.get('year')} | {a} | {t[:110]} | Zbl {x.get('identifier')}")
    return out


def self_test():
    d = query('an:0599.28008')
    ok_pos = total(d) == 1 and any('Falconer' in s or 'density at infinity' in s for s in lines(d))
    ok_neg = total(query('ti:qzxwvplomb')) == 0   # a quoted nonsense phrase draws a 502 proxy error, which query() refuses loudly
    print('positive control', 'PASS' if ok_pos else 'FAIL', '| negative control', 'PASS' if ok_neg else 'FAIL')
    return 0 if ok_pos and ok_neg else 1


if __name__ == '__main__':
    if sys.argv[1:] == ['--self-test']:
        sys.exit(self_test())
    name, q = sys.argv[1], sys.argv[2]
    d = query(q)
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / f'zb_{name}.json').write_text(json.dumps(d, indent=1))
    print(f'query: {q}\ntotal: {total(d)}')
    for s in lines(d)[:25]:
        print('  ', s)
