from lemmaX_lines import *
names = {(0,0):'0',(1,0):'1',(0,1):'z',(1,1):'Z'}   # z = zeta, Z = zeta^2 ; colours named by line-n column-0 label
lab = {i: names[t] for t, i in col0.items()}
for perm in itertools.permutations(COLS):
    if any(perm[i]==i for i in COLS): continue
    Ln = {t: (col0[t], perm[col0[t]]) for t in F4}
    if ttype(Ln): continue
    pi = ' '.join(f"{names[t]}->{lab[Ln[t][1]]}" for t in F4)
    n1s = lines_after(Ln, lambda Lp: cc(Ln, Lp))
    print("pi:", pi, "| L_(n+1) options:", len(n1s))
    for Ln1 in n1s:
        print("   L_(n+1):", ' '.join(f"{names[t]}:{lab[Ln1[t][0]]}{lab[Ln1[t][1]]}" for t in F4))
        for flips in itertools.product([0,1], repeat=4):
            Ln2 = {t: (Ln[t][f], Ln[t][1-f]) for t, f in zip(F4, flips)}
            if len({Ln2[t][0] for t in F4}) < 4 or len({Ln2[t][1] for t in F4}) < 4: continue
            if not cc(Ln1, Ln2): continue
            viol = [(names[t],mu) for t in F4 for mu in (0,1) if Ln2[add(t,ONE)][(mu+1)%2] == Ln[t][mu]]
            print("      L_(n+2):", ' '.join(f"{names[t]}:{lab[Ln2[t][0]]}{lab[Ln2[t][1]]}" for t in F4),
                  "| equals L_n:", Ln2 == Ln, "| (d) fails at (tau,mu):", viol)
