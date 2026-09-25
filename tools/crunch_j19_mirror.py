import sys; sys.path.insert(0,'tools')
import crunch_j18_phases as T
A=T.analyse([1,5,7,10])
rig={i for i,p in A['phases'].items() if p['rigid']}
words={}
for i in sorted(A['phases']):
    if i in rig:
        w=T.periodic_colouring(A,i); words[i]=w
        print(i,len(w),''.join(map(str,w)),'chiral',T.chiral(w))
    else: print(i,'NONRIGID size',A['phases'][i]['size'])
def phase_of_periodic(w):
    m=A['m']; P=len(w); ww=(w*((m//P)+3))
    return A['cid'].get(T.canon(tuple(ww[:m])))
for i,w in words.items():
    print(i,'mirror ->',phase_of_periodic(w[::-1]))
print('walls',A['walls'])
