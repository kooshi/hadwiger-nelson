"""FS131-PAS2 stage 1: check each blockquote in the brief against its named source, verbatim.
usage: quote_check.py ROOT BRIEF   (a source written 'path § section' is checked against the whole file at path)"""
import re, sys, pathlib
root = pathlib.Path(sys.argv[1])
brief = (root / sys.argv[2]).read_text()
blocks = re.findall(r'((?:^>(?: .*)?\n)+)', brief, re.M)
bad = 0
for b in blocks:
    lines = [l[2:] if l.startswith('> ') else l[1:] for l in b.splitlines()]
    if not lines[-1].startswith('— source: '):
        continue
    src = lines[-1][len('— source: '):].strip().split(' § ')[0]
    body = '\n'.join(lines[:-1])
    text = (root / src).read_text()
    ok = body in text
    print(('OK  ' if ok else 'MISS'), src, repr(body[:70]))
    bad += not ok
print('mismatches:', bad)
sys.exit(1 if bad else 0)
