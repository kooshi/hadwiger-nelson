import re,subprocess,sys
brief=open('/home/kooshi/source/lean-dir/data/fs131/briefs/FS131-ML1-merge-land.md').read()
# collect blockquote + source pairs
lines=brief.split('\n')
pairs=[]
for i,l in enumerate(lines):
    if l.startswith('> ') and not l.startswith('> —') and i+1<len(lines) and lines[i+1].startswith('> — source:'):
        pairs.append((l[2:], lines[i+1][len('> — source: '):].strip()))
inv=subprocess.run(['git','-C','/home/kooshi/source/lean-dir','show','main:plans/FS131-close-inventory.md'],capture_output=True,text=True).stdout
ok=True
for q,src in pairs:
    if src=='plans/FS131-close-inventory.md':
        text=inv; where='main'
    else:
        rel=src.split('fs131-w4mm/')[1]
        text=subprocess.run(['git','-C','/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm','show','c9623d04:'+rel],capture_output=True,text=True).stdout; where='c9623d04'
    idx=text.find(q)
    ln=text[:idx].count('\n')+1 if idx>=0 else None
    print(('VERBATIM' if idx>=0 else 'MISMATCH'), where, src.split('/')[-1], 'l.',ln, '|', q[:90])
    ok &= idx>=0
print('ALL VERBATIM' if ok else 'SOME MISMATCH', len(pairs))
