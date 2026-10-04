import re,sys
root='/home/kooshi/source/lean-dir-fs129-close/'
z=open(root+'plans/FS129-Z2-record.md',encoding='utf-8').read().split('\n')
rows=[l for l in z if re.match(r'\| 1(49|5[0-4]) \| ',l)]
assert len(rows)==6,len(rows)
L=open(root+'LEDGER.md',encoding='utf-8').read().split('\n')
i=[k for k,l in enumerate(L) if l.startswith('| 148 | ')]; assert len(i)==1
L[i[0]+1:i[0]+1]=rows
# row 121
j=[k for k,l in enumerate(L) if l.startswith('| 121 | ')]; assert len(j)==1
old="`tools/x05v_checks.py` | FS-100 stage 5 (crunch 2026-09-26) |"
assert L[j[0]].count(old)==1
add="; `plans/FS84-SI-D-derivation.md` (J45-N1, -N2, -SI-4, -SI-5, -SI-J, -SI-C, -SP-oi, -SP-if — the inputs FS100-Q47's grade names, filed as entries by FS129-Z1)"
L[j[0]]=L[j[0]].replace(old,"`tools/x05v_checks.py`"+add+" | FS-100 stage 5 (crunch 2026-09-26) |")
open(root+'LEDGER.md','w',encoding='utf-8').write('\n'.join(L))
