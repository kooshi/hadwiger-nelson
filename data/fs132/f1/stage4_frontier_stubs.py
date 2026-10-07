"""FS132-F1 stage 4: plans/FRONTIER-STUBS.md (item 6) and the stubs (item 7)."""
import re, sys
sys.path.insert(0, 'data/fs132/f1')
from flib import *

log, stops = [], []
P = lines_of('plans/POROS-2026-10-07-after-release.md')
S = lines_of('plans/EXT-OAI3-review.md')

def fs_id(cell):
    return re.search(r'\*\*(FS-\d+)\b', cell).group(1)

def punct(c):
    """end a filed cell with a full stop before appended words, if it has no sentence end"""
    return c if c.rstrip()[-1:] in '.?!' else c.rstrip() + '.'

# ---------------- P's table and verdicts ----------------
prow = [l for l in P if re.match(r'\| (\d+) \| \*\*FS-', l)][:12]
assert [int(l.split(' | ')[0][2:]) for l in prow] == list(range(1, 13))
PR = {i + 1: l.split(' | ') for i, l in enumerate(prow)}
for i in PR:
    PR[i][-1] = PR[i][-1].rstrip().rstrip('|').rstrip()
start42 = next(i for i, l in enumerate(P) if l.startswith('### 4.2 Every ranked stub'))
end42 = next(i for i in range(start42, len(P)) if P[i].startswith('### 4.3'))
VERD = {}     # FS id -> (verdict, reason)
for l in P[start42:end42]:
    if not l.startswith('| ') or l.startswith('| old') or l.startswith('|---'):
        continue
    c = [x.strip() for x in l.strip().strip('|').split(' | ')]
    ids = re.findall(r'FS-\d+', c[1].split('(')[0] if c[1].count('(') and not c[1].startswith('FS-') else c[1])
    ids = re.findall(r'FS-\d+', re.sub(r'\([^)]*\)', '', c[1]))
    verdict = c[2]
    reason = c[3] if len(c) > 3 else ''
    for i in ids:
        VERD.setdefault(i, (verdict, reason))
print({k: v[0][:40] for k, v in VERD.items() if k in ('FS-62','FS-39','FS-113','FS-101','FS-80','FS-67','FS-96','FS-64','FS-63','FS-59','FS-102','FS-78','FS-42','FS-43','FS-128','FS-120')})

# ---------------- FRONTIER-STUBS.md ----------------
fpath = 'plans/FRONTIER-STUBS.md'
t = open(fpath, encoding='utf-8').read()
openpar = open('data/fs132/f1/open-milestones-paragraph.txt', encoding='utf-8').read().strip()
si = t.index("**Next, in Kooshi's order**")
mm63 = list(re.finditer(r'\*\*M63\*\*\s+stands at', t))
assert len(mm63) == 1 and t.count("**Next, in Kooshi's order**") == 1 and mm63[0].start() > si
t = t[:si] + openpar + ' ' + t[mm63[0].start():]
log.append('6a: open-milestones span replaced (M7, M8 inside)')

L = t.split('\n')
h = next(i for i, l in enumerate(L) if l.startswith('| rank | stub | the question'))
assert L[h + 1].startswith('|---')
r0 = h + 2
old = []
i = r0
while L[i].startswith('| '):
    old.append(L[i]); i += 1
rend = i
assert len(old) == 74
OLD = {}
order_old = []
for l in old:
    c = l.split(' | ')
    assert len(c) == 7, l[:60]
    k = fs_id(c[1]); OLD[k] = c; order_old.append(k)
assert len(set(order_old)) == 74

# ---- rank 1: new row as drafted
new_rows = []
r1 = PR[1][:]
new_rows.append(' | '.join(r1) + ' |')
log.append('6b: rank 1 FS-132 added as drafted')

def parse_question_rule(cell):
    return cell

def take_quote(cell):
    m = re.search(r'"(.*)"', cell, re.S)
    return ws(m.group(1)) if m else None

# ---- ranks 2..12
for rk in range(2, 13):
    pc = PR[rk]
    key = fs_id(pc[1])
    c = OLD[key][:]
    rule = pc[2]
    # question cell
    if rule.startswith('*as filed, adding:*'):
        c[2] = punct(c[2]) + ' ' + take_quote(rule)
    elif rule.startswith('*as filed*'):
        pass
    elif rule.startswith('*replaces the first sentence:*'):
        newfirst = take_quote(rule.split('*the rest as filed*')[0])
        oldfirst = 'is the singular set of every honest saturated colouring of the plane locally finite (C121-REGJ)?'
        c[2] = replace_once(c[2], oldfirst, newfirst, f'rank {rk} {key} first sentence', log)
    elif rule.startswith('*as filed with the'):
        v, rs = VERD[key]
        c[2] = punct(c[2]) + ' 2026-10-07 (FS132-P1): ' + v + ' — ' + rs     # M17
        log.append(f'M17 on rank {rk} {key}: verdict and reason appended to the question cell')
    else:
        assert key == 'FS-104', key
        c[2] = pc[2]
    # name (only rank 10)
    if key == 'FS-104':
        c[1] = replace_once(c[1], '**FS-104 `χ_CP(ℝ²)` at six**', pc[1], 'rank 10 name', log)
        c[4] = pc[4]; c[6] = pc[6]
        log.append('rank 10: cost and solver cells replaced by P\'s words (unpriced / none)')
    c[3] = pc[3]
    c[5] = pc[5]
    # solver: P's words where given
    if key != 'FS-104':
        if pc[6] != 'as filed':
            stops.append(f'rank {rk} {key} solver cell: P gives "{pc[6]}" — left as filed')
        if pc[4] != 'as filed':
            stops.append(f'rank {rk} {key} cost cell: P gives "{pc[4]}" — left as filed')
    c[0] = f'| {rk}'
    new_rows.append(' | '.join(c))
    # last cell keeps its ' |' ending from the old row
below = ['FS-62', 'FS-39', 'FS-130', 'FS-115', 'FS-113', 'FS-101', 'FS-80', 'FS-67', 'FS-59', 'FS-96', 'FS-64', 'FS-63', 'FS-102', 'FS-69', 'FS-57', 'FS-100', 'FS-65', 'FS-17', 'FS-55', 'FS-78', 'FS-42', 'FS-43', 'FS-45']
assert len(below) == 23
AMBIG = {'FS-101', 'FS-67', 'FS-96', 'FS-64', 'FS-63', 'FS-78', 'FS-42', 'FS-43'}
tail = [k for k in order_old if int(re.search(r'\d+', OLD[k][0]).group()) >= 38]
assert len(tail) == 37, len(tail)
sequence = below + tail
rk = 13
for key in sequence:
    c = OLD[key][:]
    v, rs = VERD.get(key, ('**unchanged**', ''))
    if key in AMBIG:
        stops.append(f'rank {rk} {key}: verdict "{v}"' + (f' / reason "{rs[:60]}…"' if rs else '') + ' carries a clause beside "unchanged"; moved to its rank, status cell NOT appended')
    elif v.strip('*') != 'unchanged':
        c[5] = punct(c[5]) + ' 2026-10-07 (FS132-P1): ' + v + ((' — ' + rs) if rs else '')
        log.append(f'M17 on rank {rk} {key}: verdict appended to the status cell')
    c[0] = f'| {rk}'
    new_rows.append(' | '.join(c))
    rk += 1
assert rk - 1 == 72, rk - 1
L[r0:rend] = new_rows
log.append('6b/6c: ranked table rebuilt: 72 rows')

# ---- closed list
banners = {}
for l in P:
    m = re.match(r'- \*\*`(plans/STUB-[a-z0-9-]+\.md)` \((FS-\d+)\):\*\* "(.*)"\s*$', l)
    if m: banners[m.group(2)] = (m.group(1), ws(m.group(3)))
assert len(banners) == 14, len(banners)
ci = next(i for i, l in enumerate(L) if l.startswith('## Closed, absorbed and demoted'))
first = next(i for i in range(ci, len(L)) if L[i].startswith('* **'))
entries = []
for key in ('FS-44', 'FS-49', 'FS-108'):
    nm = re.match(r'(\*\*FS-\d+ [^*]+\*\* — `[^`]+`)', OLD[key][1]).group(1)
    path, text = banners[key]
    assert path in nm
    entries.append(f'* {nm}. {text}')
L[first:first] = entries
log.append('6d: FS-44, FS-49, FS-108 entered the closed list (at its head), banners verbatim')
t = '\n'.join(L)
# count assertions
body = t.split('## Ranked stubs')[1].split('## Closed, absorbed and demoted')[0]
ids = [re.search(r'\*\*(FS-\d+)\b', l.split(' | ')[1]).group(1) for l in body.split('\n') if re.match(r'\| \d+ \| \*\*FS-', l)]
assert len(ids) == 72 and len(set(ids)) == 72
expected = (set(order_old) - {'FS-44', 'FS-49', 'FS-108'}) | {'FS-132'}
assert set(ids) == expected
log.append(f'count: ranked table holds {len(ids)} rows; every FS number once; closed three absent')
open(fpath, 'w', encoding='utf-8').write(t)

# ---------------- the stubs ----------------
def edit(path, fn):
    s = open(path, encoding='utf-8').read()
    s2 = fn(s)
    open(path, 'w', encoding='utf-8').write(s2)
# M18 first
edit('plans/STUB-top-colour.md', lambda s: replace_once(s, '— the top colour, at five and six:', '— the top colour, at six:', 'M18 FS-128 title', log))
edit('plans/STUB-pinch-at-junction.md', lambda s: replace_once(s, '— the pinch at a junction, and the cover route at five:', '— the pinch at a junction:', 'M18 FS-120 title', log))
# banners
for key, (path, text) in banners.items():
    def add(s, text=text):
        lines = s.split('\n')
        assert lines[0].startswith('# '), path
        assert lines[1] == '', path
        lines[2:2] = ['> ' + text, '']
        return '\n'.join(lines)
    edit(path, add)
    log.append(f'7: banner of {key} filed under the title of {path}')
# D4, D5, D7
def block(src, marker):
    i = next(k for k, l in enumerate(src) if marker in l)
    j = i + 1
    while not src[j].startswith('>'):
        j += 1
    out = []
    while src[j].startswith('>'):
        out.append(re.sub(r'^>\s?', '', src[j])); j += 1
    return ws(' '.join(out))
d4 = block(S, '**D4 — a bearing line for `plans/STUB-four-colour-inheritance.md`')
d5 = block(S, '**D5 — a bearing line for `plans/STUB-mr-in-lean.md`')
d7 = block(S, '**D7 — a bearing line for `plans/STUB-six-by-the-nerve.md`')
def after_paragraph(s, starts, new, label):
    ps = s.split('\n\n')
    ix = [i for i, p in enumerate(ps) if p.startswith(starts)]
    assert len(ix) == 1, (label, len(ix))
    ps.insert(ix[0] + 1, new)
    log.append(f'{label}: one paragraph inserted after the paragraph beginning {starts[:50]!r}')
    return '\n\n'.join(ps)
edit('plans/STUB-four-colour-inheritance.md', lambda s: after_paragraph(s, "**Provisional bearings, updated at the 2026-09-25 crunch's close (M1–M3):**", d4, 'D4'))
edit('plans/STUB-mr-in-lean.md', lambda s: after_paragraph(s, 'G80 (infinite rank is the resource; the height count is the hypothesis)', d5, 'D5'))
edit('plans/STUB-six-by-the-nerve.md', lambda s: after_paragraph(s, "**Provisional bearings (Poros, 2026-10-07; Ephodos's re-grokking replaces this line at the opening):**", d7, 'D7'))
open('data/fs132/f1/stage4-log.txt', 'w').write('\n'.join(log) + '\n\nSTOPS (left unfiled or filed as stated):\n' + '\n'.join(stops) + '\n')
print('\n'.join(log)); print('STOPS:'); print('\n'.join(stops))
