#!/usr/bin/env python3
"""FS131-FPA1: file the prior-art job's drafts that are ruled for filing, verbatim.
Run from the worktree root.  `file.py --plant` changes one slot text by a character and must FAIL
(nothing written).  `file.py` makes every replacement in memory; every slot must occur exactly once
(whitespace-insensitive) or nothing is written."""
import re, sys, pathlib

REC = pathlib.Path('plans/FS131-PAS1-prior-art.md')
PLANT = '--plant' in sys.argv
norm = lambda s: re.sub(r'\s+', ' ', s).strip()
rec = REC.read_text()

def section(start, end):
    a = rec.index(start); b = rec.index(end, a)
    return norm(rec[a:b])

def items(sec, n):
    """split a normalised '### x.4 Drafts' section into its numbered items"""
    parts = re.split(r'(?:(?<=\s)|^)(?=(?:%s)\. \*\*)' % '|'.join(str(i) for i in range(1, n + 1)), sec)
    return [p for p in parts if re.match(r'\d\. \*\*', p)]

def quotes(t):
    return re.findall(r'\*"(.*?)"\*', t)

sec24 = section('### 2.4 Drafts', '## Stage 3')
sec34 = section('### 3.4 Drafts', '## Stage 4')
sec42 = section('### 4.4 Drafts', '## Stage 5')
sec54 = section('### 5.4 Drafts', '## Stage 6')
sec64 = rec[rec.index('### 6.4 Drafts'):]; sec64 = norm(sec64)
it24 = items(sec24, 5); it34 = items(sec34, 4); it44 = items(sec42, 4)
it54 = items(sec54, 3); it64 = items(sec64, 3)

files = {}
def get(f):
    if f not in files:
        files[f] = pathlib.Path(f).read_text()
    return files[f]

log = []
def sub(f, slot, new, label, keep_slot=False):
    """replace slot (whitespace-insensitive, exactly once) by new; keep_slot: insertion after it"""
    if PLANT and label == 'L79':
        slot = slot[:5] + 'X' + slot[6:]
    txt = get(f)
    rx = r'\s+'.join(re.escape(w) for w in slot.split())
    ms = list(re.finditer(rx, txt))
    if len(ms) != 1:
        sys.exit(f'FAIL {label}: slot occurs {len(ms)} times in {f}: {slot[:70]!r}')
    m = ms[0]
    out = (m.group(0) + new) if keep_slot else new
    files[f] = txt[:m.start()] + out + txt[m.end():]
    log.append(label)

# ---- 2.4 item 1-4
q = quotes(it24[0]); assert len(q) == 2, q
sub('LEDGER.md', q[0], q[1], 'L79')
q = quotes(it24[1]); assert len(q) == 2, q
sub('README.md', q[0], q[1], '2.4-2 README')
q = quotes(it24[2]); assert len(q) == 2, q
sub('RESULTS.md', q[0], q[1], '2.4-3 RESULTS')
q = quotes(it24[3]); assert len(q) == 2, q
sub('CLOSED-QUESTIONS.md', q[0], ' ' + q[1], '2.4-4 CLOSED-QUESTIONS', keep_slot=True)

# ---- 2.4 item 5: BIBLIOGRAPHY
B = 'BIBLIOGRAPHY.md'
t5 = it24[4]
role = re.search(r'add to its role: \*"(.*?)"\*', t5).group(1)
cite = re.search(r'update the citation to \*"(.*?)"\*', t5).group(1)
status_new = re.search(r'to \*"(read in full, FS131-PAS1 \(2026-10-16\))"\*', t5).group(1)
status_old = re.search(r'from \*"(second-hand:.*?)"\*', t5).group(1)
sub(B, 'arXiv:2410.11028 | Thm 1.4: a connected non-bipartite graph', 'arXiv:2410.11028; ' + cite + ' | Thm 1.4: a connected non-bipartite graph', '2.4-5 Krebs citation')
sub(B, 'the sweep agent\'s unverified assessment) |', "the sweep agent's unverified assessment); " + role + ' |', '2.4-5 Krebs role')
sub(B, '**' + status_old + '**', '**' + status_new + '**', '2.4-5 Krebs status')

def bullet(t, key):
    m = re.search(r'- new \*\*`\[%s\]`\*\* \| (.*?\|) (?=- |`\[Payan)' % key, t + ' ')
    return m.group(1)
enami = bullet(t5, 'EnamiMatsushita2026')
payan = re.search(r'`\[Payan1992\]` \(existing row\): add \*"(.*?)"\*', t5).group(1)
# new rows are inserted at the end of section A, before the blank line that precedes '### A′'
newrows = []
newrows.append('| **[EnamiMatsushita2026]** | ' + enami)
# Davidson2026: its key already has a row (§ C, line 978) -- not filed; reported.

sub(B, "bears on U₆₄'s 6 ≤ χ ≤ 8 only as context |", "bears on U₆₄'s 6 ≤ χ ≤ 8 only as context; " + payan + ' |', '2.4-5 Payan')

# ---- 3.4 item 4 (status only; the copy part is held)
t = it34[3]
dg_status = re.search(r'status to \*"(read in full \(FS131-PAS1, 2026-10-16\);.*?)"\*', t).group(1)
hg_status = re.search(r'status \*"(§ 1 and closing section read \(FS131-PAS1\);.*?)"\*', t).group(1)
sub(B, "**author's summary read (zbMATH 1581.05080, 2026-09-24, FS-85 §PA): Geombinatorics 35(3) 111–118; \"a 61-vertex, 5-chromatic graph of girth 4 in ℝ³\", the author speculating that no 6-chromatic girth-4 case exists; not held, the paper unread**",
    '**' + dg_status + '**', '3.4-4 deGrey status')
sub(B, "**author's summary read (2026-09-24); not held** |", '**' + hg_status + '** |', '3.4-4 Haugstrup status')

# ---- 4.4 item 2: FS100-CLS erratum; item 4: Moorhouse
q = quotes(it44[1]); assert len(q) == 1, q
F = 'plans/FS100-derivation.md'
tx = get(F)
m = list(re.finditer(r'^\*\*FS100-CLS — .*$', tx, re.M)); 
if len(m) != 1: sys.exit('FAIL FS100-CLS paragraph count %d' % len(m))
files[F] = tx[:m[0].end()] + '\n\n' + q[0] + tx[m[0].end():]; log.append('4.4-2 FS100-CLS erratum')
add = re.search(r'add \*"(§ 8 re-read in full,\s*FS131-PAS1)"\*', norm(it44[3])).group(1)
sub(B, '**read in full (2026-09-08); §6, §8 re-read 2026-09-15**', '**read in full (2026-09-08); §6, §8 re-read 2026-09-15; ' + add + '**', '4.4-4 Moorhouse')

# ---- 5.4 item 3 / 6.4 item 3 : new rows
def rows(t, first_key_marker):
    body = t[t.index('new **`['):]
    pieces = re.split(r' \|[;.] ', body + ' ')
    out = []
    for p in pieces:
        p = p.strip()
        if p.startswith('new **`['):
            p = p[len('new '):]
            p = re.sub(r'^\*\*`\[(\w+)\]`\*\*', r'**[\1]**', p)
            out.append('| ' + p.rstrip(' |.') + ' |')
        elif p.startswith('`[Shimura1964]`') or not p:
            pass
    return out
r54 = rows(it54[2], None)
r64 = rows(it64[2], None)
assert len(r54) == 2 and len(r64) == 4, (len(r54), len(r64))
r64 = [r.replace('library/pdf/schinzel-1969-…pdf', 'library/pdf/schinzel-1969-remarque-sur-le-travail-de-nagell-acta-arith15-245-246.pdf') for r in r64]
assert not any('…' in r for r in r64)
newrows[0] = re.sub(r'^\| \*\*\[EnamiMatsushita2026\]\*\* \| (.*)$', r'| **[EnamiMatsushita2026]** | \1', newrows[0])
newrows += r54 + r64
shim = re.search(r'reading status unchanged, \*"(not read;.*?)"\*', norm(it54[2])).group(1)
sub(B, 'not held (§ R.4; JSTOR) | not read |', 'not held (§ R.4; JSTOR) | ' + shim + ' |', '5.4-3 Shimura status (§ A row only; merge held)')

# insert the new rows at the end of § A
t_ = get(B); a_ = "\n\n### A′. Retired and alternate keys"
assert t_.count(a_) == 1
files[B] = t_.replace(a_, "\n" + "\n".join(newrows) + a_); log.append("new rows in § A (%d)" % len(newrows))

if PLANT:
    sys.exit('PLANT NOT CAUGHT')
for f, txt in files.items():
    pathlib.Path(f).write_text(txt)
print('OK', len(log), 'edits:'); print('\n'.join(log))
print('\nNEW ROWS:'); print('\n'.join(r[:150] for r in newrows))
