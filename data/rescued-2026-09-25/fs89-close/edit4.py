p='/home/kooshi/source/lean-dir/CLAUDE.md'
s=open(p,encoding='utf-8').read()
n0=len(s.encode())
L=s.split('\n')
def setq(prefix,newq):
    idx=[i for i,l in enumerate(L) if l.startswith(prefix)]
    assert len(idx)==1,prefix
    cells=L[idx[0]].split(' | ')
    assert len(cells)==4,(prefix,len(cells))
    cells[2]=newq
    L[idx[0]]=' | '.join(cells)
setq('| 7 | **FS-80 ',"the one obstruction route FS-79 left open (row 80, G73): a window-frequency Farkas certificate of non-four-colourability kept small by the point group and the multilayer structure, aimed at ℚ(√167)'s survivors; beside it the radius-≥ 2 cocycle route (`[CGHO2025coh]` Thm 5.8); radius 1 cannot lift `120Λ` to `8Λ` (row 87) …")
setq('| 11 | **FS-64 ',"every ceiling we own uses ONE place. Build the mixed one: a cut-and-project colouring on the S-integers of F in ℝ² × ℝ² × ℚ₃², the 3-adic place named by the barrier (row 72); can it beat 6 over ℚ(√167)? **At FS-86's and FS-89's closes:** measurable windows over finitely many places cannot four-colour a type-(B) plane non-periodically (row 92), and the one-character case (FS-83) is closed at both exposed fields (row 96); a five-colour window over ℚ(√167) is untouched")
s='\n'.join(L)
open(p,'w',encoding='utf-8').write(s)
print(n0,len(s.encode()),len(s.encode())-n0)
