"""C3b item 3, sample: walk Parts's tree S (Table 4, first block, read by eye from t4-002.png) as a fixed certificate."""
from field import sub
from g481 import pt, is_unit, pts as G481
# node: (colour or None for the end node, (a,b,c,d), {colour: [earlier nodes of that colour it is adjacent to]}, is_root)
S = {1:(1,(6,0,6,0),{},True), 2:(1,(6,0,-6,0),{},True), 3:(1,(-12,0,0,0),{},True), 4:(2,(1,1,1,-1),{},True),
     5:(3,(1,-1,-1,-1),{},True), 6:(4,(-2,0,0,2),{},True), 7:(4,(2,0,0,-2),{},True),
     8:(2,(-4,0,-6,-2),{1:[2],3:[5],4:[7]},False), 9:(4,(-9,-1,-1,-3),{1:[3],2:[8],3:[5]},False),
     10:(3,(-9,1,1,-3),{1:[3],2:[4],4:[9]},False), 11:(None,(-4,0,6,-2),{1:[1],2:[4],3:[10],4:[7]},False)}
ok = True
for n,(col,xyz,ports,root) in S.items():
    p = pt(*xyz)
    if p not in G481: print("node", n, "not a vertex of the rebuilt G481"); ok = False
    for c, nbrs in ports.items():
        for m in nbrs:
            if not (m < n and S[m][0] == c and is_unit(sub(p, pt(*S[m][1])))):
                print("node", n, "port", c, "neighbour", m, "fails"); ok = False
    if not root:
        blocked = set(ports)
        if col is None: ok &= blocked == {1,2,3,4}
        else: ok &= blocked == {1,2,3,4} - {col}
# root nodes: the mono-triple 1,2,3 (side sqrt3) and the Golomb wheel around it must be properly coloured among themselves
roots = [n for n in S if S[n][3]]
for i in roots:
    for j in roots:
        if i < j and is_unit(sub(pt(*S[i][1]), pt(*S[j][1]))) and S[i][0] == S[j][0]: print("root edge monochromatic", i, j); ok = False
print("tree S walks:", ok)
