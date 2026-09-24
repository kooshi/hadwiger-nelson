from census import *
from collections import Counter
d,a=load(True)
keys=list(itertools.product(range(8),repeat=4))
def add(k,l): return tuple((x+y)%8 for x,y in zip(k,l))
kz=key8
two=[kz(2*Z**j) for j in range(3)]
cnt=Counter()
for s in a:
    c=colouring_map(s)
    per=tuple(j for j in range(3) if all(c[k]==c[add(k,two[j])] for k in keys))
    cnt[per]+=1
print('which 2*zeta^j are periods, over all 380 pinned colourings:',cnt)
