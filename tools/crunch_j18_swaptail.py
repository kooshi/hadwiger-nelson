"""J18: for each rigid-rigid wall point of X_4(D) (one BFS wall point per wall, from crunch_j18_phases), swap each one-sided
two-colour Kempe component of size >= 10 and report the phase of the swapped tail, whether it is rigid, and the swapped tail's fan gaps
and finite Kempe components.  Exact on a finite window of the (eventually periodic) wall point.  --plant swaps only half of each
component; the properness assertion must then fire."""
import sys, itertools, collections
import os; sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import crunch_j18_phases as T
def analyse_walls(D, maxw=3):
    A=T.analyse(D)
    rig={i for i,p in A['phases'].items() if p['rigid']}
    rr=[(i,j) for i,j in A['walls'] if i in rig and j in rig]
    for (i,j) in rr[:maxw]:
        seq,jn=T.wall_point(A,i,j)
        n=len(seq); m=A['m']
        for it in T.kempe_report(A,seq,jn):
            if it['kind'] not in ('left-only','right-only') or it['size']<10: continue
            e,f=it['pair']
            # rebuild swapped seq
            # find component again: vertices in span with colours e,f connected - reuse report's span; recompute
            vs={x for x in range(n) if seq[x] in (e,f)}
            x0=it['span'][0]+jn
            comp={x0}; st=[x0]
            while st:
                x=st.pop()
                for d in D:
                    for y in (x-d,x+d):
                        if y in vs and y not in comp: comp.add(y); st.append(y)
            if PLANT:
                med=sorted(comp)[len(comp)//2]; comp={x for x in comp if x<med}
            sw=[ (f if seq[x]==e else e) if x in comp else seq[x] for x in range(n)]
            assert T.proper(sw, D, 0, n), 'swapped colouring not proper'
            side = 'right' if it['kind']=='right-only' else 'left'
            seg = sw[n-400:n-100] if side=='right' else sw[100:400]
            # fan gaps in the middle of seg
            gaps=[x for x in range(40,len(seg)-40) if len({seg[x]}|{seg[x+s*d] for d in D for s in (1,-1)})<4]
            # finite Kempe components inside seg interior (size <= 20, not touching seg boundary)
            fin=0
            for a,b in itertools.combinations(range(4),2):
                vv={x for x in range(len(seg)) if seg[x] in (a,b)}
                seen=set()
                for x0 in vv:
                    if x0 in seen: continue
                    comp2={x0}; st=[x0]
                    while st:
                        x=st.pop()
                        for d in D:
                            for y in (x-d,x+d):
                                if y in vv and y not in comp2: comp2.add(y); st.append(y)
                    seen|=comp2
                    if min(comp2)>2*m and max(comp2)<len(seg)-2*m: fin+=1
            print(D,(i,j),it['pair'],it['kind'],'swapped',side,'tail phase',it['left_phase'] if side=='left' else it['right_phase'],
                  'rigid' if (it['left_phase'] if side=='left' else it['right_phase']) in rig else 'NONRIGID',
                  'fan-gaps',len(gaps),'finite-Kempe',fin)
PLANT = sys.argv[1:] == ['--plant']
if PLANT:
    try:
        analyse_walls([1,5,7,10],1)
        print('plant DID NOT FIRE'); sys.exit(1)
    except AssertionError as ex:
        print('plant FIRED:', ex); sys.exit(0)
analyse_walls([1,5,7,10],9)
analyse_walls([1,5,7,10,13,27,33])
