exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# Appends a dated amendment to FS131-I10E's brief: its branch fast-forwarded to FS131-I10D's hand-back (run once).
B=ROOT+"data/fs131/briefs/FS131-I10E-wave10-second.md"
A=WT+"fs131-w10e/Proofs/HadwigerNelson/Arith/"
s=open(B).read()
assert "## Amendment 1" not in s
a=f'''

## Amendment 1 (2026-10-06, at launch) — your branch now holds the planes' floor, proved

Nothing above is withdrawn; three facts changed.

1. **Your branch was fast-forwarded** from `330d2f48` to `a14f9ab0`, the hand-back of the implementer of `NormOneTarget` and `FloorPlanes`
   (FS131-I10D, inventory item 538) — your tree was untouched, so nothing of yours moved, and your one file is byte-identical. Your
   statement check is against `a14f9ab0`; the branch as given now has seventeen `sorry` leaves, one yours. The first build recompiles
   those two modules and what imports them.
2. **Two of the children the plan names for `charSum_128_ge` are now theorems in your tree — cite them, declare neither again**: "every
   non-trivial additive character is a shift of one" and the count of the norm-one set, which at `Q = 128` is the number of solutions of
   `u ^ 129 = 1`:

{Q(A+"FloorPlanes.lean","theorem exists_mulShift_eq ")}
{Q(A+"NormOneTarget.lean","theorem card_normOne ")}
{Q(A+"NormOneTarget.lean","theorem card_filter_pow_eq_one ")}
   If one does not fit your leaf as stated (its binders, its field), write a corollary under a name of your own and say so in your report.
3. **A lesson from today, for your mid-job messages** (inventory item 526): when you report a defect, say which kind it is — a
   *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs (a shorter-route note, no defect).
'''
open(B,"w").write(s.rstrip("\n")+a)
print("amended")
