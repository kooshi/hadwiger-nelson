"""FS132-F1 stage 3: grokkings (item 3), instances (item 4), BIBLIOGRAPHY (item 5)."""
import re, sys
sys.path.insert(0, 'data/fs132/f1')
from flib import *

log = []
R = lines_of('plans/EXT-OAI2-reading.md')
S = lines_of('plans/EXT-OAI3-review.md')

def block(src, marker):
    i = next(k for k, l in enumerate(src) if marker in l)
    j = i + 1
    while not src[j].startswith('>'):
        j += 1
    out = []
    while src[j].startswith('>'):
        out.append(re.sub(r'^>\s?', '', src[j])); j += 1
    return ws(' '.join(out))

# ================= grokkings =================
gpath = '.claude/skills/grokkings/SKILL.md'
g = open(gpath, encoding='utf-8').read()
gi = next(i for i, l in enumerate(R) if l.startswith('* **G93 — '))
gj = next(i for i, l in enumerate(R) if l.startswith('**Instances and amendments to existing entries**'))
gtext = '\n'.join(R[gi:gj]).rstrip('\n')
assert gtext.count('* **G9') == 3
# M12 on G95
k95 = gtext.index('* **G95 — ')
g95 = gtext[k95:]
g95 = replace_once(g95, 'are false under slack.', 'are false under local slack.', 'M12a', log)
g95 = replace_once(g95, 'can be true only where no colouring has slack', 'can be true only where no colouring has local slack', 'M12b', log)
g95 = replace_once(g95, 'plant slack in the hexagonal seven-colouring', 'plant local slack in the hexagonal seven-colouring', 'M12c', log)
g95 = replace_once(g95, '*Do: before transplanting',
    "(*Local slack* is freedom to recolour near one vertex; row 132's slack is a forbidden interval of distances everywhere, `[Voronov2023]` Thm 1.1 — FS132-P1.) *Do: before transplanting", 'M12d', log)
gtext = gtext[:k95] + g95
# insert after the G92 bullet (before the G51 retired pointer)
m51 = list(re.finditer(r'^\* \*\*G51 — A competitor and an advisor beat one mind\.', g, re.M))
assert len(m51) == 1
k = m51[0].start()
assert g[:k].rstrip('\n').split('\n')[-1].strip().startswith('statements were tight') or 'G92' in g[:k][-3000:]
g = g[:k] + gtext + '\n' + g[k:]
log.append('grokkings: G93, G94, G95 inserted after G92 (before the G51 pointer)')
g = replace_once(g, 'entries G1 to G92', 'entries G1 to G95', 'M13', log)
open(gpath, 'w', encoding='utf-8').write(g)

# ================= instances =================
ipath = 'plans/GROKKING-INSTANCES.md'
it = open(ipath, encoding='utf-8').read()
par = ws(' '.join(R[i] for i in range(next(k for k, l in enumerate(R) if l.startswith('**Instances and amendments to existing entries**')), next(k for k, l in enumerate(R) if l.startswith('### 5.2 What it leaves untouched')))))
par = re.sub(r'^\*\*Instances and amendments to existing entries\*\* \(for [^)]*\):\s*', '', par)
items = re.split(r'(?<=\.) (?=G\d+ — )', par)
assert len(items) == 8, len(items)
INST = {}
for x in items:
    mm = re.match(r'(G\d+) — (.*)$', x)
    INST[mm.group(1)] = 'EXT-OAI2 (2026-10-07): ' + mm.group(2) + ' Source: `plans/EXT-OAI2-reading.md` § 5.1.'
assert list(INST) == ['G25', 'G60', 'G64', 'G80', 'G81', 'G82', 'G86', 'G91'], list(INST)
d9 = block(S, '**D9 — `plans/GROKKING-INSTANCES.md` § G92**')
assert d9.startswith('EXT-OAI3 (2026-10-07):')
INST['G92'] = d9
# titles from the grokkings file (cut as neighbours do: at the first colon, or ", and")
TITLE = {
 'G25': 'The forcing ladder is recursive',
 'G80': 'Infinite rank is the resource',
 'G81': 'Where every place mixes, the field is the plane',
 'G86': 'Tile counts are blind to Siamese pairs',
 'G91': 'The ring is the pigeonhole',
 'G92': 'A held result reaches as far as its argument, not as far as its statement',
}
gk = open(gpath, encoding='utf-8').read()
for key, ttl in TITLE.items():
    assert re.search(r'^\* \*\*' + key + ' — ' + re.escape(ttl), gk, re.M), key   # copied from the grokkings file
IL = it.split('\n')
def head_idx(key):
    ix = [i for i, l in enumerate(IL) if l.startswith(f'## {key} — ')]
    return ix[0] if ix else None
def add_to_existing(key, para):
    global IL
    i = head_idx(key)
    j = next(k for k in range(i + 1, len(IL)) if IL[k].startswith('## '))
    while IL[j - 1].strip() == '':
        j -= 1
    IL[j:j] = ['', para]
    log.append(f'instances: {key} appended under its existing heading')
def new_section(key, before_key_or_heading, para):
    global IL
    j = next(k for k, l in enumerate(IL) if l.startswith(before_key_or_heading))
    IL[j:j] = [f'## {key} — {TITLE[key]}', '', para, '']
    log.append(f'instances: new heading {key} before {before_key_or_heading!r}')
for key in ('G60', 'G64', 'G82'):
    assert head_idx(key) is not None
    add_to_existing(key, INST[key])
new_section('G25', '## G30 — ', INST['G25'])
new_section('G80', '## G82 — ', INST['G80'])
new_section('G81', '## G82 — ', INST['G81'])
new_section('G86', '## G87 — ', INST['G86'])
new_section('G91', '## `CLAUDE.md` § Counter-priors', INST['G91'])
new_section('G92', '## `CLAUDE.md` § Counter-priors', INST['G92'])
open(ipath, 'w', encoding='utf-8').write('\n'.join(IL))

# ================= BIBLIOGRAPHY =================
bpath = 'BIBLIOGRAPHY.md'
b = open(bpath, encoding='utf-8').read()
BL = b.split('\n')
ri = [i for i, l in enumerate(BL) if l.startswith('| **[OAIMath2026]** |')]
assert len(ri) == 1
cells = BL[ri[0]].split(' | ')
assert len(cells) == 5
Rtxt = '\n'.join(R)
m_rest = re.search(r'\*And its\s+third cell, appended:\* "(On it rest, if filed:.*?)"', Rtxt, re.S)
assert m_rest
rest_sentence = ws(m_rest.group(1)).replace('On it rest, if filed:', 'On it rest:')
d2 = block(S, '**D2 — `BIBLIOGRAPHY.md` § A')
d1 = block(S, '**D1 — `BIBLIOGRAPHY.md` § A')
d3 = block(S, '**D3 — `BIBLIOGRAPHY.md` § C')
m_read = re.search(r'"(\*\*Manuscript: read in full\*\*.*?moser_certificate_check\.py`\)\.)"', Rtxt, re.S)
assert m_read
read_words = ws(m_read.group(1))
# M14 (cell 2 'what of ours rests on it')
cells[2] = replace_once(cells[2], "The front page's sentences change at the filing after wave 8's landing; FS-132 opens on it",
                        rest_sentence + ' ' + d2, 'M14', log)
# M15 (cell 4 'read')
c4 = cells[4]
c4 = replace_once(c4, '**Family 158: built and audited here; its first half read in full**', '**Family 158: built and audited here; its manuscript read in full**', 'M15a', log)
c4 = insert_after(c4, '(`data/external/oai1/keryx/`).', " The cone's 70 modules replayed through `leanchecker` module by module, 70 of 70.", 'M15b', log)
c4 = replace_span(c4, '*The manuscript* (EXT-OAI2,', 'being read.', read_words, 'M15c', log)
# M16 (D1)
c4 = replace_once(c4, '**Every other family (371): listed in the catalogue only, unread**', d1, 'M16', log)
cells[4] = c4
BL[ri[0]] = ' | '.join(cells)
b = '\n'.join(BL)

# C: GreenfeldTao2024 (D3)
b = replace_once(b, "FS-73's C3-aper is the colouring form for Cayley graphs of ℤ^r. Paper not read", d3, 'D3 GreenfeldTao2024', log)

# C: sixteen rows
ti = next(i for i, l in enumerate(R) if l.startswith('| proposed key | work |'))
rows = []
for l in R[ti + 2:]:
    if not l.startswith('|'): break
    rows.append(l)
assert len(rows) == 9, len(rows)
def cellsof(l):
    return [c.strip() for c in l.strip().strip('|').split(' | ')]
def keys_of(c):
    return re.findall(r'`(\[[^\]]+\])`', c)
OPEN = 'Cited by `[OAIMath2026]` family 158; **not held, not read.**'
SPLIT = {
 '[Zimmer1976ext]': "R. J. Zimmer, *Extensions of ergodic group actions*, Illinois J. Math. 20 (1976)",
 '[Zimmer1976gds]': "R. J. Zimmer, *Ergodic actions with generalized discrete spectrum*, Illinois J. Math. 20 (1976)",
 '[Jamneshan2023]': "A. Jamneshan, *An uncountable Furstenberg–Zimmer structure theory*, Ergodic Theory Dynam. Systems 43(7) (2023) 2404–2436",
 '[Jamneshan2026corr]': "A. Jamneshan, *An uncountable Furstenberg–Zimmer structure theory*, its Corrigendum (2026)",
}
newrows = []
for l in rows:
    key_c, work, rests, fetch = cellsof(l)
    ks = keys_of(key_c)
    if len(ks) == 1:
        works = {ks[0]: work}
    elif ks[0] in SPLIT:
        works = {k2: SPLIT[k2] for k2 in ks}
        # the split pieces are made only of the draft's own words
        for k2 in ks:
            for tok in re.findall(r'\*[^*]+\*|\d[\d()–]*|[A-Z][a-z]+', works[k2]):
                assert tok in work, (k2, tok)
    else:
        parts = [p.strip() for p in work.split('; ')]
        assert len(parts) == len(ks), (ks, len(parts))
        works = dict(zip(ks, parts))
    for k2 in ks:
        verdict = OPEN + ' ' + rests + ('' if rests.endswith('.') else '.') + ' Fetch: ' + fetch
        newrows.append(f'| **{k2}** {works[k2]} | {verdict} |')
assert len(newrows) == 16, len(newrows)
BL = b.split('\n')
gi_ = next(i for i, l in enumerate(BL) if l.startswith('## G. The Geombinatorics archive walk'))
last_row = max(i for i in range(gi_) if BL[i].startswith('| **['))
assert BL[last_row].startswith('| **[FejesToth1973]**')
BL[last_row + 1:last_row + 1] = newrows
log.append('bibliography § C: sixteen rows appended after [FejesToth1973] (end of § C table)')
open(bpath, 'w', encoding='utf-8').write('\n'.join(BL))
open('data/fs132/f1/stage3-log.txt', 'w').write('\n'.join(log) + '\n')
print('\n'.join(log))
