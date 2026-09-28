# FS112-X stage 5: the ranking, on the owner's message naming NIGHT-A's ruling (plans/POROS-2026-09-27-night-aim.md §2, 2abacbfa; inventory
# items 70, 73): 1 FS-114 (the unit-arc question), 2 FS-111, 3 FS-104 (unchanged), 4 FS-115; FS-112 to the closed list; FS-109 and below one lower.
# Bearings of FS-114, FS-111, FS-115 from §2's table; question/cost/status/solver cells from C's §R-close 4.2 D5 and 4.5; D2 adapted to NIGHT-A §1.
import pathlib, re, sys
sys.path.insert(0, '/home/kooshi/source/lean-dir/data/fs112/fs112-x')
from drafts_extract import section, bullets
R = pathlib.Path('/home/kooshi/source/lean-dir')
def rep(t, old, new, name):
    assert t.count(old) == 1, (name, t.count(old)); return t.replace(old, new)
na = (R/'plans/POROS-2026-09-27-night-aim.md').read_text().split('\n')
def bear(prefix):
    l = [x for x in na if x.startswith(prefix)]; assert len(l) == 1, prefix
    c = l[0].split(' | '); assert c[2].endswith(' |'); return c[2][:-2]
B114, B111, B115 = bear('| 1 | **FS-114'), bear('| 2 | **FS-111'), bear('| 4 | **FS-115')
B111 = rep(B111, "until card 1 is answered", "until its first question (`plans/POROS-2026-09-27-night-aim.md` §3, card 1) is answered", 'card1')

# ---- C's texts
d5 = section('4.2'); d5 = d5[d5.index('- **D5'):d5.index('- **D6')]
c_r1 = [l for l in d5.split('\n') if l.startswith('| 1 | **FS-114')][0].split(' | ')
c_r2 = [l for l in d5.split('\n') if l.startswith('| 2 | **FS-115')][0].split(' | ')
s45 = section('4.5')
f_rows = re.findall(r"  - `(\| [12] \| \*\*FS-11[45] .*?\|)`\n", s45)
assert len(f_rows) == 2, len(f_rows)
f114, f115 = [r.split(' | ') for r in f_rows]
closed = [b for b in bullets(s45) if b.startswith('*Closed list')][0]
closed = closed[re.search(r":\*? \"", closed).end(): closed.rindex('"')]

# ---- CLAUDE.md
p = R/'CLAUDE.md'; t = p.read_text(); before = len(t.encode())
NEXT = ("**Next: FS-114, the unit-arc question, then FS-111, the cone scale** (`plans/STUB-global-step.md`, `plans/STUB-reg-scale.md`), beside "
        "BASE-V's blind re-derivation of row 134's print steps; FS-115 waits for FS-114's plan (NIGHT-A on Kooshi's deferral, "
        "`plans/POROS-2026-09-27-night-aim.md` §1); the finite-witness-free week runs to 2026-10-01 (§ Toolchain).")
t = rep(t, """**Open milestones, in order.** **None is open.** FS-110, the tangency seam, is **closed** (row 134; `plans/FS110-tangency-seam.md` §R-close). **Next:
FS-112, the unit-arc half** (`plans/STUB-unit-arc-half.md`), or FS-111 (Kooshi picks); the finite-witness-free week runs to 2026-10-01 (§ Toolchain).""",
"""**Open milestones, in order.** **None is open.** FS-112, the unit-arc half (`plans/STUB-unit-arc-half.md`), is **closed undecided** (rows 135–136;
`plans/FS112-unit-arc-half.md` §R-close). """ + NEXT, 'D2')
L = t.split('\n'); h = L.index('| rank | stub | the question | bearing on the answer |')
j = h + 2; rows = []
while L[j].startswith('|'): rows.append(L[j]); j += 1
assert rows[0].startswith('| 1 | **FS-112') and rows[1].startswith('| 2 | **FS-111') and rows[2].startswith('| 3 | **FS-104')
r111 = rows[1].split(' | '); assert len(r111) == 4 and r111[3].endswith(' |'); r111[3] = B111 + ' |'
new = ['| 1 | **FS-114 the unit-arc question** — ' + c_r1[1].split(' — ', 1)[1] + ' | ' + c_r1[2] + ' | ' + B114 + ' |',
       ' | '.join(r111), rows[2],
       '| 4 | ' + c_r2[1] + ' | ' + c_r2[2] + ' | ' + B115 + ' |']
fs75 = None
for r in rows[3:]:
    lab = r.split('|')[1].strip()
    if lab.isdigit():
        k = int(lab)
        if k == 29: fs75 = r; assert r.startswith('| 29 | **FS-75'); continue
        new.append(r.replace(f'| {k} |', f'| {k+1} |', 1))
    else:
        assert r.startswith('| 30–65 | FS-90,'); new.append(r.replace('| 30–65 | FS-90,', '| 30–66 | FS-75, FS-90,', 1))
L[h+2:j] = new; t = '\n'.join(L)
p.write_text(t); print('CLAUDE.md', before, '->', len(t.encode()))

# ---- plans/FRONTIER-STUBS.md
p = R/'plans/FRONTIER-STUBS.md'; t = p.read_text()
t = rep(t, "**None is open.** FS-110, the tangency seam, is **closed** (row 134; `plans/FS110-tangency-seam.md` §R-close). **Next: FS-112, the unit-arc half** (`plans/STUB-unit-arc-half.md`), or FS-111 (Kooshi picks); the finite-witness-free week runs to 2026-10-01 (§ Toolchain).",
        "**None is open.** FS-112, the unit-arc half (`plans/STUB-unit-arc-half.md`), is **closed undecided** (rows 135–136; `plans/FS112-unit-arc-half.md` §R-close). " + NEXT, 'F-D2')
para = ("*At FS-112's close (2026-09-27, FS112-X; `plans/FS112-unit-arc-half.md` §R-close 4.5; the ranking NIGHT-A's, `plans/POROS-2026-09-27-night-aim.md` §2, "
        "binding on Kooshi's deferral, `plans/FS112-close-inventory.md` items 70, 73): FS-112 closed undecided and left the table; **minted** on Kooshi's ruling "
        "(inventory item 59): FS-114, the unit-arc question (1), and FS-115, the stuck ray (4: none alone; it moves to 2 the day FS-114's plan commits to the "
        "four-colour form); FS-111 (2) re-aimed at FS-114's NO, the composition into seven a one-mind reading (FS107-MEET); FS-104 stays at 3; old ranks 4–65 "
        "become 5–66.*\n\n")
t = rep(t, "## Ranked stubs\n\n", "## Ranked stubs\n\n" + para, 'para')
L = t.split('\n')
i1 = [k for k, l in enumerate(L) if l.startswith('| 1 | **FS-112')]; assert len(i1) == 1; i1 = i1[0]
assert L[i1+1].startswith('| 2 | **FS-111') and L[i1+2].startswith('| 3 | **FS-104')
g111 = L[i1+1].split(' | '); assert len(g111) == 7; g111[3] = B111
f114[1] = f114[1].replace('**FS-114 the global step**', '**FS-114 the unit-arc question**'); f114[3] = B114
f115[0] = '| 4'; f115[3] = B115
out = ['| 1 | ' + ' | '.join(f114[1:]) if f114[0] == '| 1' else None, ' | '.join(g111), L[i1+2], ' | '.join(f115)]
assert out[0]
k = i1 + 3; body = []
while L[k].startswith('|'):
    m = re.match(r'\| (\d+) \|', L[k]); n = int(m.group(1)); assert n >= 4
    body.append(L[k].replace(f'| {n} |', f'| {n+1} |', 1)); k += 1
assert body[-1].startswith('| 66 |'), body[-1][:12]
L[i1:k] = out + body; t = '\n'.join(L)
t = rep(t, "## Closed, absorbed and demoted\n", "## Closed, absorbed and demoted\n" + closed + "\n", 'closed')
p.write_text(t); print('FRONTIER-STUBS ok')
