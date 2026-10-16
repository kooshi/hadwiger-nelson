"""FS131-KCL1 stage 1: check each quotation of the brief against its named source, verbatim.

Each quotation is the run of '> ' lines in the brief followed by a '> — source: <path>' line.
Lines are joined with '\n' and searched as one substring in the source file; if the quotation is
a single paragraph we also try it as one line.  Exit status 1 if any quote is not found.
Usage: python3 -I quote_check.py <brief> <repo-root> [--plant]
--plant mutates one character of the first quotation, to watch the check fire.
"""
import sys, pathlib, re

brief, root = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
plant = '--plant' in sys.argv
lines = brief.read_text().split('\n')
quotes, cur = [], []
for ln in lines:
    if ln.startswith('> — source:'):
        quotes.append(('\n'.join(cur), ln[len('> — source:'):].strip()))
        cur = []
    elif ln.startswith('> ') or ln == '>':
        cur.append(ln[2:])
    else:
        cur = []
bad = 0
for i, (q, src) in enumerate(quotes):
    if plant and i == 0:
        q = q.replace('formalized', 'formalised', 1)
    text = (root / src).read_text()
    ok = q in text
    how = 'verbatim' if ok else ''
    if not ok:
        # a multi-line quote of one paragraph may be one source line
        q1 = ' '.join(q.split('\n'))
        ok = q1 in text
        how = 'verbatim (one line)' if ok else 'NOT FOUND'
    if not ok:
        bad += 1
        # locate the first differing position against the best prefix
        best = 0
        for k in range(len(q), 0, -1):
            if q[:k] in text:
                best = k; break
        print(f'quote {i+1} ({src}): NOT FOUND; longest found prefix {best}/{len(q)} chars; next: {q[best:best+80]!r}')
    else:
        print(f'quote {i+1} ({src}): {how}; {len(q)} chars')
print(f'{len(quotes)} quotations, {bad} not found')
sys.exit(1 if bad else 0)
