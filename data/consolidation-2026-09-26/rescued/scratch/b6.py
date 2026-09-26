P="/home/kooshi/source/lean-dir/CLAUDE.md"; Q="/home/kooshi/source/lean-dir/LEDGER.md"
t=open(P).read(); lg=open(Q).read()
n=t.find("**The prior-art position.**"); e=t.find("\n\n", n); para=t[n:e]
a=para.find("**Ours:**"); b=para.find("**Not ours:**")
ours=para[a:b]
head="**Ours:** Theorem A's general form (that\nformulation); Theorem B's kernel proof and its 𝔽₄-valued residue colouring — **the value χ(K²) = 4 itself is `[Fischer1994]`'s** (1994, read and verified 2026-09-22; row 57, § Publication), which closed the five questions row 57 lists sixteen to thirty-one years before they were posed; "
assert ours.startswith(head), ours[:300]
rest=ours[len(head):]
tail="every kernel certificate. "
assert rest.endswith(tail)
body=rest[:-len(tail)]
newours=head+"every kernel certificate; and the rest of the claim, row by row with its unread-prior-art caveats, in `LEDGER.md` § The claim list. "
t=t[:n]+para[:a]+newours+para[b:]+t[e:]
# small edits
R=[("missed it, which is G49's mechanism once more (his title's *planar geometric graph* is the discipline's name for our *field plane*, and no citation graph reaches a 1994 proceedings volume).",
    "missed it — G49's mechanism once more."),
   ("FS-66's instrument is priced at 84 GPU-days there, so the ask is a smaller relaxation; ", "a smaller relaxation than FS-66's; ")]
for x,y in R:
    assert t.count(x)==1, x[:60]; t=t.replace(x,y)
open(P,"w").write(t)
sec=("## The claim list — what is ours beyond Theorems A and B (moved from `CLAUDE.md` § The prior-art position, 2026-09-26)\n\n"
 "*`CLAUDE.md` keeps the position's lineage sentence, Theorems A and B with `[Fischer1994]`'s value, every kernel certificate, and the whole\n"
 "**Not ours** list, which stays in context against misclaims; this is the rest of its **Ours** list, verbatim, beside the rows it names.*\n\n"
 "**Ours:** "+body.strip()+"\n\n")
k=lg.find("## A. The novel-results ledger"); assert k>0 and lg.count("## A. The novel-results ledger")==1
lg=lg[:k]+sec+lg[k:]
open(Q,"w").write(lg)
print(len(body.encode()))
