# Exploration (not a control): winding of the 60-degree hexagon of omega(y) at offset 120 deg, before and after,
# over every assignment of the germ colours at u (120), p (180), v (240) drawn from the candidate sets of SEMI-PAR3 kind O,
# and colours d0, d1, d5 at the far positions 0, 60, 300 (held constant: no change point there).
import itertools
A,Ap,F='a',"a'",'f'
order={A:0,Ap:1,F:2}
def wind(seq):
    s=0
    for i in range(6):
        x,y=order[seq[i]],order[seq[(i+1)%6]]
        d=(y-x)%3
        if d==0: return None
        s+= 1 if d==1 else -1
    return s//3
cand={'u-':[Ap,F],'u+':[A,F],'p-':[F,A],'p+':[F,Ap],'v-':[Ap,F],'v+':[A,F]}
res={}
for um,up,pm,pp,vm,vp in itertools.product(*[cand[k] for k in ['u-','u+','p-','p+','v-','v+']]):
    for d0,d1,d5 in itertools.product([A,Ap,F],repeat=3):
        before=[d0,d1,um,pm,vm,d5]; after=[d0,d1,up,pp,vp,d5]
        wb,wa=wind(before),wind(after)
        if wb is None or wa is None: continue
        key=(wb,wa)
        res.setdefault(key,[]).append((um,up,pm,pp,vm,vp,d0,d1,d5))
for k,v in sorted(res.items()):
    print(k,len(v),v[:4])
