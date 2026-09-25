p='Proofs/HadwigerNelson/Kempe.lean'
s=open(p).read()
start=s.index('/-- A translate of a colouring has at least the same periods')
end_=s.index('/-- **A pulled-back quotient colouring is periodic under the kernel')
block=s[start:end_]
s=s[:start]+s[end_:]
anchor=s.index('/-- **H1, pointwise**')
s=s[:anchor]+block+s[anchor:]
open(p,'w').write(s)
