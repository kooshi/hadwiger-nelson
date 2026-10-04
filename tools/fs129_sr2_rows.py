"""FS129-SR2: dump the Lean-order rows this pass sweeps (SR1's § 6.3 list) with their statements, uses-only lines and handoffs.

Reads data/fs129/index/lean-order.md and data/fs129/index/theorems.jsonl; writes data/fs129/sr2/rows.md.
--fault drops the row-list parse (every row counted as SR2's), so the count check fires.
"""
import json, re, sys

SPEC = "1-27,30-45,47-64,67-100,104-107,109,112-120,123-127,129-137,139-148,153-157,159,160,172,175-179,181-183,192,193"

def rows_of(spec):
    out = []
    for part in spec.split(','):
        a, _, b = part.partition('-')
        out += list(range(int(a), int(b or a) + 1))
    return out

def main():
    fault = '--fault' in sys.argv
    order = {}
    for l in open('data/fs129/index/lean-order.md'):
        m = re.match(r'\| (\d+) \| (\S+) \| ([^|]*) \| ([^|]*) \| (\S*) \| ([^|]*) \| (.*) \|$', l.rstrip())
        if m:
            order[int(m.group(1))] = m.groups()
    mine = list(order) if fault else rows_of(SPEC)
    th = {}
    with open('data/fs129/index/theorems.jsonl') as f:
        f.readline()
        for l in f:
            d = json.loads(l)
            th[d['id']] = d
    out = []
    for r in mine:
        _, tid, role, addr, era, needs, ho = order[r]
        d = th[tid]
        cut = lambda s, n: (s[:n] + ' …') if len(s) > n else s
        out.append(f"### row {r} — {tid} ({role.strip()}; {addr.strip()})\n"
                   f"- grade: {d['grade']} | minds: {cut(d['minds'],120)} | verdict: {cut(d['verdict'],80)}\n"
                   f"- needs: {needs.strip()}\n"
                   f"- statement: {d['statement']}\n"
                   f"- uses: {cut(d['uses_raw'],400)}\n"
                   f"- not claimed: {cut(d['not_claimed'],300)}\n"
                   f"- handoff/kernel: {cut(d['handoff'] or d['kernel'],200)}\n"
                   f"- dependents (index, direct/transitive): {d['n_dependents_direct']}/{d['n_dependents_transitive']}\n")
    open('data/fs129/sr2/rows.md', 'w').write('\n'.join(out))
    n = len(mine)
    print(f"rows dumped: {n}" + ("" if n == 151 else " (expected 151)"))

main()
