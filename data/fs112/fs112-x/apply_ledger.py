# FS112-X stage 2: apply FS112-C/C2's LEDGER.md drafts (plans/FS112-unit-arc-half.md §R-close 4.1) exactly. Each replacement asserted exactly once.
import pathlib
R = pathlib.Path('/home/kooshi/source/lean-dir')
plan = (R/'plans/FS112-unit-arc-half.md').read_text().split('\n')
r135 = [l for l in plan if l.startswith('| 135 |')]; r136 = [l for l in plan if l.startswith('| 136 |')]
assert len(r135) == 1 and len(r136) == 1
L = (R/'LEDGER.md').read_text()
def rep(s, old, new):
    assert s.count(old) == 1, (old[:60], s.count(old)); return s.replace(old, new)
lines = L.split('\n')
i134 = [i for i, l in enumerate(lines) if l.startswith('| 134 |')]
assert len(i134) == 1 and not any(l.startswith('| 135 |') for l in lines)
lines[i134[0]+1:i134[0]+1] = [r135[0], r136[0]]
L = '\n'.join(lines)
L = rep(L, "the unit-arc half of Question 2 (Condition 5 dropped: (S1), T2, NB-4's exception; FS-112)",
        "the unit-arc half of Question 2 (Condition 5 dropped: reduced at FS-112, rows 135–136; FS-114, FS-115)")
L = rep(L, "| FS110-NB-4 | row 134 | under Condition 5 no vertex of a tight six-map has four colours |",
        "| FS110-NB-4 | row 134 | under Condition 5 no vertex of a tight six-map has four colours; without Condition 5 its general form is FS112-NB4P (NB4′) |")
B = (R/'data/fs112/fs112-c/ledger-b-draft.md').read_text().rstrip('\n').split('\n')
assert len(B) == 56 and all(b.startswith('| FS112-') for b in B)
lines = L.rstrip('\n').split('\n')
assert lines[-1].startswith('| FS110-'), lines[-1][:40]
lines += B
(R/'LEDGER.md').write_text('\n'.join(lines) + '\n')
print('ok')
