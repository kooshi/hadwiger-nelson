"""Build data/fs112/fs112-pa/extracts.md from the spec files spec_*.txt (job FS112-PA; reading aid).

Every quotation is cut from the held Polymath16 text by (comment id, start phrase, end phrase), so it is
verbatim by construction up to whitespace, which the source's one-line-per-thread form does not preserve.
Checks, each fatal: the comment exists; the start phrase occurs exactly once in it; the end phrase occurs
after it; the cut quote occurs in the whitespace-normalised held file. --self-test plants a phrase from
another comment and a one-word alteration and watches both refused.

Spec lines:  '## ...' or '### ...' or '> ...' pass through (markdown);  '@TT.n ¦ start ¦ end ¦ note' makes
an extract;  '%' starts a comment line (dropped).  A start/end of '*' means the comment's first/last word."""
import glob, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from split_threads import threads, comments, SRC

HERE = os.path.dirname(os.path.abspath(__file__))
TEXT = threads()
HELD = ' '.join(open(SRC).read().split())
CACHE = {}
AUTH = {'ag24ag24': 'ag24ag24 (Aubrey de Grey)', 'Mixon': 'Dustin G. Mixon', 'domotorp': 'domotorp (Dömötör Pálvölgyi)'}

def cut(cid, start, end):
    t, n = cid.split('.')
    if t not in CACHE: CACHE[t] = comments(t, TEXT)
    cs = CACHE[t]; n = int(n)
    if not 1 <= n < len(cs): raise SystemExit(f'FAIL {cid}: no such comment')
    a, d, b = cs[n]
    s = 0 if start == '*' else b.find(start)
    if start != '*' and (s < 0 or b.count(start) != 1):
        raise SystemExit(f'FAIL {cid}: start phrase found {b.count(start)} times: {start[:60]!r}')
    if end == '*': e = len(b)
    else:
        e = b.find(end, s)
        if e < 0: raise SystemExit(f'FAIL {cid}: end phrase not found after start: {end[:60]!r}')
        e += len(end)
    q = b[s:e]
    if q not in HELD: raise SystemExit(f'FAIL {cid}: cut quote not verbatim in held file')
    return a, d, q

def build(lines):
    out = []
    for ln in lines:
        ln = ln.rstrip('\n')
        if ln.startswith('%') or not ln.strip(): 
            if not ln.strip(): out.append('')
            continue
        if ln.startswith('@'):
            cid, start, end, note = [x.strip() for x in ln[1:].split('¦')]
            a, d, q = cut(cid, start, end)
            t = int(cid.split('.')[0])
            loc = ' '.join(q.split()[:9])
            out.append(f'- **[{cid}] {AUTH.get(a, a)}, thread {t}, {d}** — locator: "{loc}"\n  > {q}\n  *States:* {note}')
        else: out.append(ln)
    return '\n'.join(out) + '\n'

def self_test():
    ok = cut('06.62', 'If B is a pentagon', 'joining vertices W to U.')
    assert ok[0] == 'Philip Gibbs', ok
    for bad in [('06.62', 'those six tiles must jointly cover', '*'),        # phrase from another comment (08.17)
                ('06.62', 'If B is a pentagon there must be another cell D', '*')]:  # one-word alteration
        try: cut(*bad)
        except SystemExit as e: print('refused as planted:', str(e)[:70]); continue
        raise AssertionError(f'plant not refused: {bad}')
    try:  # quote-verbatim guard: plant a body alteration that the phrase checks cannot see
        t = '06'; CACHE[t] = [c if i != 62 else (c[0], c[1], c[2].replace('radius one', 'radius two')) for i, c in enumerate(comments(t, TEXT))]
        cut('06.62', 'If B is a pentagon', 'joining vertices W to U.')
        raise AssertionError('altered body not refused')
    except SystemExit as e: print('refused as planted:', str(e)[:70])
    finally: CACHE.pop('06', None)
    print('self-test: all plants refused for their own reason; faithful twin accepted')

if __name__ == '__main__':
    if sys.argv[1:] == ['--self-test']: self_test(); sys.exit(0)
    lines = []
    for f in sorted(glob.glob(os.path.join(HERE, 'spec_*.txt'))): lines += open(f).read().splitlines(True) + ['\n']
    head = open(os.path.join(HERE, 'extracts_head.md')).read()
    open(os.path.join(HERE, 'extracts.md'), 'w').write(head + '\n' + build(lines))
    print('extracts.md written')
