import re,subprocess
p='/home/kooshi/source/lean-dir/CLAUDE.md'
s=open(p,encoding='utf-8').read()
n0=len(s.encode())
L=s.split('\n')
def setq(prefix,newq):
    idx=[i for i,l in enumerate(L) if l.startswith(prefix)]
    assert len(idx)==1,prefix
    cells=L[idx[0]].split(' | ')
    # cells: ['| r', 'stub', 'question', 'bearing |']
    assert len(cells)==4,(prefix,len(cells))
    cells[2]=newq
    L[idx[0]]=' | '.join(cells)
setq('| 6 | **FS-75 ',"**re-aimed at FS-81's close: T4 for the whole family in the kernel** — T22's ⟹, then FS81-T1–T5; fallback, a kernel checker for FS-81's structural certificates on the census (row 83); the minted target, `χ(ℚ(√167)²) ≥ 4`, is an instance …")
setq('| 10 | FS-67 ',"**re-aimed at FS-85's close to its four-colour form**: `G` Hoffman-tight at `k`, `χ(H) > k` — is every `k`-colouring of `G × H` pulled back from `G`? Yes once (R3a, row 85); `[Zhang2012]` Thm 1.8(i) answers the main case with a strict ratio inequality (row 88); left, the equal-ratio case (row 89) and the integrality gap `χ_f(H) ≤ k < χ(H)` …")
setq('| 8 | **FS-76 ',"existence and inheritance at four colours for Cayley graphs of ℤ^r (`[Ellenberg2018]`'s question at `k = 4`; plain density is false in rank 1, row 80); a two-sided four-colour certificate exists iff four-colourability is decidable, stated open in print; `P = F` on de Grey's lattice (row 85); over type-(B) fields Kempe swaps, patchworks, half-space defects (row 91) and character colourings (row 96) cannot break inheritance …")
s='\n'.join(L)
open(p,'w',encoding='utf-8').write(s)
print(n0,len(s.encode()),len(s.encode())-n0)
