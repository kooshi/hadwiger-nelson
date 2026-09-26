import sys, re
sys.path.insert(0, 'tools')
import fs71_ledger_b_check as f
from pathlib import Path
ents, rows, ph = f.load()
def drafted(path, start, end=None):
    t = Path(path).read_text()
    s = t.index(start); e = t.index(end, s) if end else len(t)
    ids = []
    for line in t[s:e].splitlines():
        m = re.match(r"^\|\s*([A-Za-z0-9][^|]*?)\s*\|\s*(FS-91|M2|M3)\s*\|", line)
        if m: ids.append(m.group(1))
    return ids
m1 = drafted('plans/FS91-character-local-global.md', '#### 4.3', '#### 4.4')
m2 = drafted('plans/M2-kernel-lane.md', '#### 4b.', 'Kernel-column changes')
m3 = drafted('plans/M3-exotic-colourings.md', '#### R4.B', '#### R4.C')
for name, d, pre in (('M1', m1, 'FS91-'), ('M2', m2, None), ('M3', m3, 'M3-')):
    E = {k for k in ents if (k.startswith(pre) if pre else k.split('-')[0] in ('J04','J14','J17'))}
    print(name, 'drafted', len(d), 'dup', len(d)-len(set(d)), 'entries', len(E))
    print('  drafted not entries:', sorted(set(d)-E))
    print('  entries not drafted:', sorted(E-set(d)))
