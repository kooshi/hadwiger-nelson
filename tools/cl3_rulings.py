#!/usr/bin/env python3
"""CL3: copy the chosen request/ruling rows verbatim into rulings.md. Fails loud if any row is missing or ambiguous."""
import re, sys, os
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WANT = [('plans/FS81-close-inventory.md', '82'), ('plans/FS81-close-inventory.md', '86'), ('plans/FS85-close-inventory.md', '2'),
        ('plans/FS85-close-inventory.md', '3'), ('plans/FS85-close-inventory.md', '37'), ('plans/FS86-close-inventory.md', '2'),
        ('plans/FS89-close-inventory.md', '2'), ('plans/FS89-close-inventory.md', '17'), ('plans/M3-close-inventory.md', '37'),
        ('plans/M3-close-inventory.md', '60'), ('plans/FS114-close-inventory.md', '115'), ('plans/FS116-close-inventory.md', '82'),
        ('plans/FS116-close-inventory.md', '86'), ('plans/FS116-close-inventory.md', '129'), ('plans/FS116-close-inventory.md', 'O7')]
def run(want, out):
    res = []; bad = 0
    for f, item in want:
        rows = [(i + 1, l.rstrip('\n')) for i, l in enumerate(open(os.path.join(ROOT, f), errors='replace')) if re.match(r'^\|\s*' + re.escape(item) + r'\s*\|', l)]
        if len(rows) != 1: print('FAIL', f, item, 'found', len(rows)); bad += 1; continue
        res.append((f, item, rows[0][0], rows[0][1]))
    if out and not bad:
        with open(out, 'w') as fh:
            fh.write('# CL3 — requests to search and their rulings, copied verbatim\n\nEach entry: the address (file, item, line), then the table row exactly as it stands.\n\n')
            for f, item, ln, row in res: fh.write('## %s, item %s (line %d)\n\n%s\n\n' % (f, item, ln, row))
    print('rows', len(res), 'bad', bad); return 1 if bad else 0
if __name__ == '__main__':
    if sys.argv[1] == 'selftest':
        sys.exit(run(WANT + ([('plans/FS116-close-inventory.md', 'NOSUCH')] if '--plant' in sys.argv else []), None))
    sys.exit(run(WANT, os.path.join(sys.argv[1], 'rulings.md')))
