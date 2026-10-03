#!/usr/bin/env python3
"""X2 stage 2: file the ledger drafts of FS-121 and FS-116 verbatim into LEDGER.md. Fails loudly."""
import re, sys
R = '/home/kooshi/source/lean-dir-close/'
MAP = {'‹R121-a›':'142','‹R121-b›':'143','‹R121-c›':'144','‹R116-a›':'145','‹R116-b›':'146','‹R116-c›':'147','‹R116-d›':'148'}
def num(s):
    for k,v in MAP.items(): s = s.replace(k,v)
    assert '‹' not in s, 'unmerged placeholder'
    return s
def rows(path, tags):
    txt = open(R+path).read()
    out=[]
    for t in tags:
        m = re.findall(r'^\| '+re.escape(t)+r' \| .*$', txt, re.M)
        assert len(m)==1, (t, len(m))
        out.append(m[0])
    return out
a121 = rows('plans/FS121-Z1-close.md', ['‹R121-a›','‹R121-b›','‹R121-c›'])
a116 = rows('plans/FS116-Z2-close.md', ['‹R116-a›','‹R116-b›','‹R116-c›','‹R116-d›'])
L = open(R+'LEDGER.md').read()
# --- section A: after the row 141 line
lines = L.split('\n')
i141 = [i for i,l in enumerate(lines) if l.startswith('| 141 | ')]
assert len(i141)==1
newrows = [num(r).replace('| ‹','| ',1) if False else num(r) for r in a121+a116]
# the placeholder sits as "| 142 |" after substitution
for r,n in zip(newrows, range(142,149)):
    assert r.startswith('| %d | '%n), r[:20]
lines[i141[0]+1:i141[0]+1] = newrows
L = '\n'.join(lines)
# --- row 137 prior-art clause
old = "**Prior art:** not found in print (FS-114's gate); route T's count, cover rule and red blocks are Sirgedas's program (the Google group, 2020–22, stated without proofs)"
new = ("**Prior art:** the local-to-global idea is Sirgedas's, informally, for\nnon-Siamese tilings found by search (\"A biggest disc implies no 6-color-tiling of the plane exists.\", the Google group, 2020-03-17); a four-colour vertex in\nevery valid map, and the reduction to one disc about it with Siamese pairs allowed, not found in print (FS-114's gate); route T's count, cover rule and red\nblocks are Sirgedas's program (the Google group, 2020–22, stated without proofs)").replace('\n',' ')
assert L.count(old)==1, L.count(old)
L = L.replace(old,new)
# --- section B: FS-114 lines
fs = open(R+'data/fs116/fs116-z2/ledger-b-fs114.md').read().split('\n')
newhub = [l for l in fs if l.startswith('| FS114-N7-HUB ')]; repl=[l for l in fs if l.startswith('| FS114-N7-3T ')]
assert len(newhub)==1 and len(repl)==1
lines = L.split('\n')
i3t=[i for i,l in enumerate(lines) if l.startswith('| FS114-N7-3T |')]; iq=[i for i,l in enumerate(lines) if l.startswith('| FS114-N7-QOPP |')]
assert len(i3t)==1 and len(iq)==1 and iq[0]==i3t[0]+1
lines[i3t[0]] = num(repl[0])
lines.insert(iq[0]+1, num(newhub[0]))
L='\n'.join(lines)
# --- section B: append FS-121's 65 then FS-116's 91
def blines(p):
    ls=[l for l in open(R+p).read().split('\n') if l.strip()]
    assert all(l.startswith('| ') for l in ls)
    return [num(l) for l in ls]
b121=blines('data/fs121/fs121-z1/ledger-b-draft.md'); b116=blines('data/fs116/fs116-z2/ledger-b-draft.md')
assert len(b121)==65 and len(b116)==91
if not L.endswith('\n'): L+='\n'
L += '\n'.join(b121+b116)+'\n'
open(R+'LEDGER.md','w').write(L)
print('ok', len(newrows), len(b121), len(b116))
