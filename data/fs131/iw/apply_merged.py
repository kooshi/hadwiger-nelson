# applies the proof of aeMap6_merged (developed in data/fs131/iw/scratch/t13.lean) to Steps.lean: moves the theorem after aeMap6_normal
import re
t=open('data/fs131/iw/scratch/t13.lean').read()
a=t.index("theorem finRotate_ne_symm")
b=t.index("namespace ArcMap")
fr=t[a:b].rstrip()+"\n\n"
c=t.index("theorem aeMap6_merged'")
body=t[c:t.rindex("end ArcMap")]
body=body[body.index(":= by\n")+len(":= by\n"):].rstrip()
p='Proofs/HadwigerNelson/Plane/Woodall/Steps.lean'
s=open(p).read()
# cut the old theorem with its docstring
i=s.index("/-- **Steps 3 and 5 give the normal form")
j=s.index("theorem aeMap6_merged (hk : k ≤ 5)")
k_=s.index("  sorry\n", j)+len("  sorry\n")
old=s[i:k_]
doc=old[:old.index("theorem aeMap6_merged")]
stmt="theorem aeMap6_merged (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hM : F.WoodallMerged) : False := by\n"
new="open Fin.NatCast in\n"+doc+stmt+body+"\n\n"
s=s[:i]+s[k_:]
# insert after aeMap6_normal
m=s.index("theorem aeMap6_normal")
e=s.index("  exact step6 hk hF hP hS hinj hang\n",m)+len("  exact step6 hk hF hP hS hinj hang\n")
s=s[:e]+"\n"+new+s[e:]
# finRotate lemma before the first `namespace ArcMap` after the header
n=s.index("namespace ArcMap")
s=s[:n]+fr+s[n:]
open(p,'w').write(s)
