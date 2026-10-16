"""FS131-PAS1 stage 1: check each blockquote in the brief against its named source, verbatim."""
import re, sys, pathlib
root = pathlib.Path(sys.argv[1])
brief = (root / sys.argv[2]).read_text()
blocks = re.findall(r'((?:^> .*\n)+)', brief, re.M)
bad = 0
for b in blocks:
    lines = [l[2:] for l in b.splitlines()]
    src = None
    if lines[-1].startswith('— source: '):
        src = lines[-1][len('— source: '):].strip()
        body = '\n'.join(lines[:-1])
    else:
        continue
    text = (root / src).read_text()
    ok = body in text
    print(('OK  ' if ok else 'MISS'), src, repr(body[:70]))
    bad += not ok
print('mismatches:', bad)
sys.exit(1 if bad else 0)
