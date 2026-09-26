import re, sys
P="/home/kooshi/source/lean-dir/CLAUDE.md"
def replace_items(NEW):
    L=open(P).read().split("\n")
    start=[i for i,l in enumerate(L) if l.startswith("### Where the problem stands")][0]
    end=[i for i,l in enumerate(L) if i>start and l.startswith("**The prior-art position.**")][0]
    idx={}
    for i in range(start,end):
        m=re.match(r"^(\d+)\. \*\*",L[i])
        if m: idx[int(m.group(1))]=i
    order=sorted(idx)
    # compute spans
    spans={}
    for k,n in enumerate(order):
        a=idx[n]; b=idx[order[k+1]] if k+1<len(order) else end
        while b>a and not L[b-1].strip(): b-=1
        spans[n]=(a,b)
    for n in sorted(NEW, reverse=True):
        a,b=spans[n]
        L[a:b]=NEW[n].split("\n")
    open(P,"w").write("\n".join(L))
