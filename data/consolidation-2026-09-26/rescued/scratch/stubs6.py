R="/home/kooshi/source/lean-dir/"
def edit(path, fn):
    t=open(R+path,encoding="utf-8").read(); t2=fn(t); assert t2!=t; open(R+path,"w",encoding="utf-8").write(t2)
def rep1(t,old,new):
    assert t.count(old)==1,(t.count(old),old[:80]); return t.replace(old,new)
# FS-84 banner (X29C 4.7, verbatim), after the title line
banner=("***Answered — FS-100 stage 5 (the ×2×3 crunch, 2026-09-26).** `χ(ℚ(√47)²) = 5` (`LEDGER.md` row 121, [hand]; the lower bound by measure rigidity for the unit-"
 "vector group, row 120, and SP-Cor; the upper bound the plane at 11, row 52), and the whole `L = 5` range with it (row 123). The prior-art gate "
 "found the value nowhere in print (X24R; `[Johnson2000]`, `[Johnson2006]` unread). What remains is Soifer's Open Problem 55.1 **as posed** — an "
 "explicit triangle-free five-chromatic unit-distance graph over ℚ(√47) (the owner's re-aim; S2 onward from 2026-10-01) — or closing the stub, "
 "Kooshi's call. The body below is the pre-answer record, kept.***")
def f84(t):
    first=t.split("\n",1)
    assert first[0].startswith("# FS-84")
    return first[0]+"\n\n"+banner+"\n"+first[1]
edit("plans/STUB-five-colours-47.md", f84)
# FS-98: TR-ROT beside T-B1 (X29C 4.6)
def f98(t):
    lines=t.split("\n")
    i=[k for k,l in enumerate(lines) if l.startswith("**Re-aimed at the crunch's close (2026-09-26, J25;")]
    assert len(i)==1
    k=i[0]
    while lines[k].strip()!="": k+=1
    lines.insert(k, "\n**TR-ROT beside T-B1 (FS-100 stage 5, wave 3, 2026-09-26; `LEDGER.md` row 124):** 'no translation-invariant non-pullback colouring measure has every `U`-Følner average converge onto the pullbacks' (X22V §3.3) — T-B1 ⟹ TR-ROT; X27D/X27V attacked it at the close (TR-ROT under attack; their verdict is a follow-on fold).")
    return "\n".join(lines)
edit("plans/STUB-ultrametric-continuation.md", f98)
# R88-TCA's grade (X25B's correction, X29C 4.1)
edit("plans/R88-derivation.md", lambda t: rep1(t, "over the class: J28D one mind; the split dyadic place:",
     "over the class: J28D one mind; a second derivation over totally real fields by X25B (blind to the proofs), and with a complex place the step by restriction to the compact real form (FS100-CX, row 123); the split dyadic place:"))
# queue §7 slip (launch note 2)
def fq(t):
    i=t.index("## §7")
    head,tail=t[:i],t[i:]
    tail=rep1(tail,"row 71\n  (five refused at 43 at level one)","row 69 (corrected at the close; the list first read \"row 71\")\n  (five refused at 43 at level one)")
    return head+tail
edit("plans/CRUNCH-2026-09-26-x2x3-queue.md", fq)
print("ok")
