import sys,re; sys.path.insert(0,'/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-close')
from wsr import wsr
p='CLAUDE.md'
s=open(p,encoding='utf-8').read()
def item(n):
    a=re.search(r'\n'+str(n)+r'\. \*\*',s).start()+1
    b=re.search(r'\n'+str(n+1)+r'\. \*\*',s).start()+1
    return a,b
a,b=item(9)
s=s[:a]+("9. **`[Parts2020a]`'s 509-vertex record is reproduced and partly explained** (M62–M64, row 62): his reduction stage is reproduced\n"
"   on every attested number, a descent cannot reach the record, **overcompression is an orbit-closure gap**, and what is left of his loop is\n"
"   the expansion step, which has no termination measure (FS-35).\n")+s[b:]
a,b=item(14)
s=s[:a]+("14. **Real quadratic fields: three colours are decided, and four is a theorem of the family** (G61, G74, G65; rows 72–74, 79, 82–84).\n"
"   **The plane over any subfield of ℝ needs four once 1/3 lies in its unit-vector ring and it has an odd cycle** [hand, two independent derivations; row 82]\n"
"   — so every squarefree d ≡ 11 (mod 12) needs four (T4) and the conjecture's L ≤ 4 clause holds for real quadratic fields; **nothing is\n"
"   claimed new while `[Johnson2000]` and `[Johnson2006]` are unread**. **The census is complete** (row 83); ℚ(√47) stands at `4 ≤ χ(ℚ(√47)²) ≤ 5`,\n"
"   five not landed (row 84, FS-84), and cannot close from above by residues at any depth (§1.7, row 75). A three-colour question over any real\n"
"   field is a question about 1/3 (G74).\n")+s[b:]
s=wsr(s,"`plans/FS86-derivation.md`; the stub carries the banner)","`plans/FS86-derivation.md`; the stub, `plans/STUB-dyadic-rigidity-triangle-free.md`, carries the banner)")
open(p,'w',encoding='utf-8').write(s)
print(len(s.encode()))
