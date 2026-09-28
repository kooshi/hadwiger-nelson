# FS112-X stage 3: apply FS112-C's CLAUDE.md drafts D1, D3, D4, D6, D7 (G83, inventory item 65), D8, and the ledger pointer (1–134 -> 1–136).
# D2 (Open milestones) and D5 (paths forward) wait for the owner's message naming NIGHT-A's ranking (brief item 1b; inventory item 70).
# The (old, new) pairs are read from C's measuring script data/fs112/fs112-c/drafts.py (its D list), and each NEW text is checked verbatim
# against plans/FS112-unit-arc-half.md §R-close 4.2 (the authority) before anything is written; every replacement asserted exactly once.
import pathlib, sys
R = pathlib.Path('/home/kooshi/source/lean-dir')
src = (R/'data/fs112/fs112-c/drafts.py').read_text()
head = src.split('\nout = claude\n')[0]
ns = {'__name__': 'drafts'}
sys.argv = ['drafts.py', '/dev/null']
exec(compile(head, 'drafts.py', 'exec'), ns)
D = ns['D']; assert len(D) == 8
plan = (R/'plans/FS112-unit-arc-half.md').read_text()
rclose = plan[plan.index('### Stage 4 — SAVED: the drafts'):]
APPLY = {1: 'D1', 3: 'D3', 4: 'D4', 6: 'D6', 7: 'D7 G83', 8: 'D8'}
claude = (R/'CLAUDE.md').read_text(); before = len(claude.encode())
for i, (old, new) in enumerate(D, 1):
    if i not in APPLY: continue
    chk = new if i != 7 else new.split('* **G51 — ')[0]
    for ln in [l.strip() for l in chk.split('\n') if l.strip()]:
        assert ln in rclose, (APPLY[i], ln[:80])
    assert claude.count(old) == 1, (APPLY[i], claude.count(old))
    claude = claude.replace(old, new)
    print(APPLY[i], 'applied')
old = "**Rows 1–134 live in `LEDGER.md`**"; assert claude.count(old) == 1
claude = claude.replace(old, "**Rows 1–136 live in `LEDGER.md`**")
(R/'CLAUDE.md').write_text(claude)
print('CLAUDE.md', before, '->', len(claude.encode()))
