"""FS132-F1 stage 2: CLAUDE.md (items 1a-1d) and LEDGER.md (item 2), by script; every old string asserted to occur exactly once."""
import re, sys
sys.path.insert(0, 'data/fs132/f1')
from flib import *

log = []
R = lines_of('plans/EXT-OAI2-reading.md')
P = lines_of('plans/POROS-2026-10-07-after-release.md')
A = open('plans/EXT-OAI1-audit.md', encoding='utf-8').read()

# ---------- sources ----------
seg = '\n'.join(R[798:872])                      # R 5.1 CLAUDE.md block, lines 799-872
units = re.split(r'\n(?=\d+\. \*\*§ )', seg)[1:]
assert len(units) == 11
U = {}
for u in units:
    n = int(re.match(r'(\d+)\.', u).group(1))
    body = re.sub(r'^\d+\. \*\*§ .*?\*\*', '', u, count=1, flags=re.S) if False else u
    U[n] = u
def qs(n, skip=0):
    return [ws(x) for x in quotes(U[n])][skip:]

# P: open-milestones paragraph (lines 523-529) and top-three table
pm = '\n'.join(P[522:530])
m = re.search(r'^"(\*\*Since 2026-10-07.*?wave 10 waits\.)"', pm, re.S | re.M)
assert m, 'P open-milestones paragraph not found'
openpar = ws(m.group(1))
# M7
openpar = replace_once(openpar, '**Next: FS-133, the one-class transfer**', '**Opened 2026-10-07: FS-133, the one-class transfer**', 'M7', log)
# M8
M8_old = "**The Lean backlog (FS-131)** resumes by the table of `plans/POROS-2026-10-07-after-release.md` § 4.4: the import first, then wave 7, wave 9 restated over the import, wave 6's in-flight jobs; wave 10 waits."
M8_new = "**The Lean backlog (FS-131**, `plans/STUB-lean-backlog.md`; its input `plans/LEAN-BACKLOG.md`**)** is paused at Kooshi's word (2026-10-07) and restarts on his word; the asking lane's recommendation is the table of `plans/POROS-2026-10-07-after-release.md` § 4.4: the import first, then wave 7, wave 9 restated over the import, wave 6's in-flight jobs; wave 10 waits."
openpar = replace_once(openpar, M8_old, M8_new, 'M8', log)
open('data/fs132/f1/open-milestones-paragraph.txt', 'w', encoding='utf-8').write(openpar + '\n')

top3_start = next(i for i, l in enumerate(P) if l.startswith('**The top three, as `CLAUDE.md` § Paths forward should carry them:**'))
top3_rows = [l for l in P[top3_start:top3_start + 8] if re.match(r'\| [123] \| \*\*FS-', l)]
assert len(top3_rows) == 3

# ---------- CLAUDE.md ----------
path = 'CLAUDE.md'
t = open(path, encoding='utf-8').read()
size0 = len(t.encode())

# M1
t = replace_once(t, 'that is not 4-colourable.', 'that is not 4-colourable. `[OAIMath2026]` (2026) ruled out 5 (row D below).', 'M1', log)
# M2
t = replace_once(t, 'and a five-colour avoider IS the open upper-bound problem',
                 'and a six-colour avoider IS the open upper-bound problem (five is excluded: row D)', 'M2', log)
# M3
t = replace_once(t, "**χ(ℝ²) ≥ 6 would be new mathematics, and a reader's default is to disbelieve it**",
                 "χ(ℝ²) ≥ 6 is `[OAIMath2026]`'s (2026), kernel-checked in its own library and audited here. **Anything this project adds above rung B — seven, a six-colouring, a field's value — would be new mathematics, and a reader's default is to disbelieve it**", 'M3', log)
# M4
t = replace_once(t, '*Last updated: 2026-10-03 —', '*Last updated: 2026-10-07 —', 'M4a', log)
t = replace_once(t, 'Last filed: **FS-129, the cross-application audit**, Derived',
                 "Last filed: **the outside release `[OAIMath2026]`, taken as literature** (Kooshi, 2026-10-07; `plans/EXT-OAI1-audit.md`, `plans/EXT-OAI2-reading.md`; no new row), with FS132-P1's re-rank; before it **FS-129, the cross-application audit**, Derived", 'M4b', log)
t = replace_once(t, '; before it **FS-116, the local exclusion**', ', and **FS-116, the local exclusion**', 'M4c', log)
# M5
t = replace_once(t, '**[external]** (claimed in the literature, unchecked here);',
                 "**[external]** (claimed in the literature, unchecked here); **[kernel, outside]** (kernel-checked in an outside library at its own pin, built and audited here; it enters this library as a declared outside theorem);", 'M5', log)
# M6 (within the paragraph beginning '**The program**')
pi = t.index('**The program** (`plans/STUB-regularity-wall.md`)')
pe = t.index('\n\n', pi)
para = t[pi:pe]
para = replace_once(para, '**FS-128, the top colour, at five and six**', '**FS-128, the top colour, at six**', 'M6a', log)
para = replace_once(para, '**FS-120, the pinch at a junction, and the cover route at five**', '**FS-120, the pinch at a junction**', 'M6b', log)
para = replace_once(para, '**FS-122, the forced pair**;', '**FS-122, the forced pair**; on `[OAIMath2026]`, **FS-132, six by the nerve**, and **FS-133, the one-class transfer**;', 'M6c', log)
t = t[:pi] + para + t[pe:]

# R units 1-10
q = qs(1);  t = replace_once(t, q[0], q[1], 'R1 row D', log)
q = qs(2);  t = replace_span(t, '1. **Given MR, the plane is the measurable problem.**', 'what is left is analysis in `ℝ²`.', q[1], 'R2 link 1', log)
q = qs(3);  t = insert_after(t, q[0], ' ' + q[1], 'R3 link 3', log)
q = qs(4);  t = replace_once(t, q[0], q[1], 'R4 link 4', log)
q = qs(5);  t = replace_span(t, '5. **So, given MR, Hadwiger–Nelson is one question', 'the first move of the upper bound since 1950.', q[1], 'R5 link 5', log)
q = qs(6);  add6 = replace_once(q[0], 'false under slack at seven', 'false under local slack at seven', 'M10', log)
t = insert_after(t, "the room after ergodic theory in G30's ladder.", ' ' + add6, 'R6 link 6', log)
q = qs(7, 1)
t = replace_once(t, q[0], q[1], 'R7a Frontier para 1 (the problem)', log)
t = replace_once(t, q[2], q[3], 'R7b Frontier para 1 (given MR)', log)
q = qs(8)
o8 = q[0].rstrip(' …'); n8 = q[1].rstrip(' …')
assert q[0].endswith('statement …') and q[1].endswith('statement …')
t = replace_once(t, o8, n8, 'R8 item 31', log)
q = qs(9, 1)
t = replace_once(t, q[0], q[1], 'R9a theory (value moved)', log)
t = replace_once(t, q[2], q[3], 'R9b theory (given MR)', log)
q = qs(10); t = replace_once(t, q[0], q[1], 'R10 local-global', log)
# unit 11 deliberately NOT filed (replaced by P's top three)

# 1b: the three ranked rows
Lc = t.split('\n')
i1 = next(i for i, l in enumerate(Lc) if l.startswith('| 1 | **FS-124 the (Q) ring**'))
assert Lc[i1 + 1].startswith('| 2 | **FS-123 the Siamese class**') and Lc[i1 + 2].startswith('| 3 | **FS-104 `χ_CP(ℝ²)` at six**')
Lc[i1:i1 + 3] = top3_rows
log.append('1b: three ranked rows replaced by P top-three rows')
t = '\n'.join(Lc)
# M9
t = replace_once(t, '| 4–74 | 71 more open stubs, in rank order in `plans/FRONTIER-STUBS.md` | … | … |',
                 '| 4–72 | 69 more open stubs, in rank order in `plans/FRONTIER-STUBS.md` | … | … |', 'M9', log)
# 1c: open milestones paragraph
si = t.index("**Next, in Kooshi's order**")
mm63 = list(re.finditer(r'\*\*M63\*\*\s+stands at', t))
assert len(mm63) == 1 and t.count("**Next, in Kooshi's order**") == 1
mi = mm63[0].start()
assert mi > si
t = t[:si] + openpar + ' ' + t[mi:]
log.append('1c: open-milestones span replaced (M7, M8 inside)')
# M11
n11 = len(re.findall(r'G1\s*(?:–|-|to)\s*G92', t))
log.append(f'M11: occurrences of "G1–G92" (any dash/"to") in CLAUDE.md: {n11}')
if n11:
    t = re.sub(r'G1(\s*(?:–|-|to)\s*)G92', r'G1\1G95', t)
open(path, 'w', encoding='utf-8').write(t)
log.append(f'CLAUDE.md bytes {size0} -> {len(t.encode())}')

# ---------- LEDGER.md ----------
path = 'LEDGER.md'
t = open(path, encoding='utf-8').read()
Ls = t.split('\n')
seg = '\n'.join(R[872:922])
def row_index(n):
    idx = [i for i, l in enumerate(Ls) if l.startswith(f'| {n} |')]
    assert len(idx) == 1, (n, idx)
    return idx[0]
def edit_row(n, fn):
    i = row_index(n)
    cells = Ls[i].split(' | ')
    assert len(cells) == 4, (n, len(cells))
    cells[1] = fn(cells[1])
    Ls[i] = ' | '.join(cells)
def append_to(n, add):
    edit_row(n, lambda c: c + ' ' + add)
    log.append(f'row {n}: appended {len(add)} chars to the result cell')

# unit texts
bul = re.split(r'\n(?=- \*\*)', seg)
B = {}
for b in bul:
    mm = re.match(r'- \*\*(Row \d+[^*]*|§ The claim list[^*]*)\*\*', b)
    if mm: B[mm.group(1).strip().rstrip('.')] = b
print('ledger units:', list(B))
# Row 33: A (c), then R
ma = re.search(r'taken as clean: "(\*Outside.*?\.\*)"', A, re.S)
if not ma:
    ma = re.search(r'would say if this audit is taken as clean: "(\*Outside.*?\.\*)"', A, re.S)
a33 = ws(ma.group(1))
r33 = ws(quotes(B['Row 33'])[0])
def e33(c):
    assert c.endswith('The colouring is classical; ours is the certificate.')
    return c + ' ' + a33 + ' ' + r33
edit_row(33, e33); log.append('row 33: A(c) sentence then R sentence appended')
append_to(107, ws(quotes(B['Row 107 (the bridge)'])[0]))
append_to(120, ws(quotes(B['Row 120'])[0]))
append_to(125, ws(quotes(B['Row 125'])[0]))
# row 128 two edits
q = [ws(x) for x in quotes(B['Row 128'])]
assert len(q) == 4 and q[0] == '**Not claimed:**', (len(q), q[0])
def e128(c):
    c = replace_once(c, '**Not claimed:**', q[1] + ' **Not claimed:**', 'row128 before Not claimed', log)
    old = q[2].replace(' …)', '')            # 'not found in print (FS103-G:'
    new = q[3].replace(' …)', '')
    assert old == 'not found in print (FS103-G:', old
    c = replace_once(c, old, new, 'row128 prior art', log)
    return c
edit_row(128, e128)
append_to(129, ws(quotes(B['Row 129'])[0]))
# row 130: old has inner double quotes, parse by regex
b130 = B['Row 130']
m130 = re.search(r'\*Replaces\* "(Given MR \(row 128\).*?\(the "only if" half unconditional\)\.)"\s*\*with:\*\s*"(With no hypothesis.*?`χ_B\(ℝ²\) ≥ 6`\.)"\s*\*And appends to its Prior art:\*\s*"(The equality with.*?owed a check against it\)\.)"', b130, re.S)
assert m130, 'row 130 unit not parsed'
o130, n130, p130 = ws(m130.group(1)), ws(m130.group(2)), ws(m130.group(3))
def e130(c):
    c = replace_once(c, o130, n130, 'row130 replacement', log)
    # append to Prior art: before the '**Naming:**' sentence that follows the prior-art text
    c = replace_once(c, '**Naming:**', p130 + ' **Naming:**', 'row130 prior-art addition (before Naming)', log)
    return c
edit_row(130, e130)
for n in (131, 132, 140, 154):
    append_to(n, ws(quotes(B[f'Row {n}'])[0]))
t = '\n'.join(Ls)
# claim list
bc = B['§ The claim list, "Ours"']
mc = re.search(r'\*After\* "(the reduction of six at ℚ\(√167\).*?\(rows 123–125\))" \*add:\*\s*"(\(.*?\))"; \*\*"Not ours"\*\* \*add:\*\s*"(the plane.*?2026\)\.)"', bc, re.S)
assert mc, 'claim list unit not parsed'
anchor, ours_add, notours_add = ws(mc.group(1)), ws(mc.group(2)), ws(mc.group(3))
t = insert_after(t, anchor, ' ' + ours_add, 'claim list Ours', log)
old_tail = "Croft's `m₁(ℝ²) ≥ 0.2293` (`[Croft1967]`)."
assert notours_add.endswith('2026).')
t = replace_once(t, old_tail, old_tail[:-1] + '; ' + notours_add, 'claim list Not ours (appended as the list'+"'"+'s last item)', log)
open(path, 'w', encoding='utf-8').write(t)
open('data/fs132/f1/stage2-log.txt', 'w').write('\n'.join(log) + '\n')
print('\n'.join(log))
