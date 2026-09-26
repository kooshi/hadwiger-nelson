import sys
D=[1,5,7,10,13,27,33]
# count canonical proper words by length (level-by-level BFS), stop at a cap
level=[()]
for L in range(1,34):
    nxt=[]
    for w in level:
        top=(max(w)+2) if w else 1
        for c in range(min(4,top)):
            if all(not(d<=len(w) and w[len(w)-d]==c) for d in D):
                nxt.append(w+(c,))
    level=nxt
    print(L,len(level)); sys.stdout.flush()
    if len(level)>3_000_000: print('cap'); break
