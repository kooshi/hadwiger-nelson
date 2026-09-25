from theta2 import *
U=[]
for p in range(-10,11):
  for q in range(-10,11):
    for r_ in range(-3,4):
      for s in range(-3,4):
        if p*p+q*q+11*(r_*r_+s*s)==100 and p*r_+q*s==0: U.append((p,q,r_,s))
B, C = lattice_coords(U); S = halfset(C); r = B.shape[1]
print("|U|", len(U), "rank", r, "|U+|", len(S))
D, sub, M, Minv, Cu, leaves = enumerate_theta(S, r)
print("leaves", len(leaves))
pts = 0; fat = 0
for (k, A) in leaves:
    ext = leaf_extent(r, A)
    if ext is None: continue
    w = max(b - a for a, b in ext)
    if w < 1e-9: pts += 1
    else: fat += 1; print("FAT cell k=",k,"widths",[round(b-a,4) for a,b in ext])
print("point cells", pts, "fat cells", fat)
