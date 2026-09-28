# FS112-X: extract the quoted draft texts of plans/FS112-unit-arc-half.md §R-close 4.3-4.8 by bullet (between the bullet's first and last straight
# double quote, lines joined with single spaces as the plan wraps them). Imported by the stage-4 and stage-5 apply scripts.
import pathlib, re
R = pathlib.Path('/home/kooshi/source/lean-dir')
plan = (R/'plans/FS112-unit-arc-half.md').read_text()
S4 = plan[plan.index('### Stage 4 — SAVED: the drafts'):plan.index('### Stage 4 — SAVED\n')]
def section(num):
    a = S4.index(f'**{num} '); nxt = re.search(r'\n\*\*4\.\d ', S4[a+5:])
    return S4[a: a+5+nxt.start()] if nxt else S4[a:]
def bullets(sec):
    out, cur = [], None
    for l in sec.split('\n'):
        if re.match(r'^- ', l):
            if cur is not None: out.append(cur)
            cur = l[2:]
        elif cur is not None and l.startswith('  '):
            cur += ' ' + l.strip()
        elif cur is not None and l.strip() == '':
            out.append(cur); cur = None
    if cur is not None: out.append(cur)
    return out
def quoted(b):
    i, j = b.index('"'), b.rindex('"'); return b[i+1:j]
if __name__ == '__main__':
    import sys
    for b in bullets(section(sys.argv[1])): print('---', b[:100]); print('   Q:', quoted(b)[:160] if '"' in b else None)
