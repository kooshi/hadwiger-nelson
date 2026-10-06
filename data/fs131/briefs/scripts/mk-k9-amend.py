exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# Appends a dated amendment to FS131-K9's brief: what changed between its writing and its launch (run once).
B=ROOT+"data/fs131/briefs/FS131-K9-wave9.md"
E=WT+"fs131-w8/Proofs/HadwigerNelson/Plane/RingCalculus/Empty.lean"
s=open(B).read()
assert "## Amendment 1" not in s
a=f'''

## Amendment 1 (2026-10-06, at launch) — what changed since this brief was written

Information only; nothing above is withdrawn.

1. **Wave 8's first planning pass has handed back.** The one row of another wave that a row of yours rests on, FS129-SR3-EMPTY-NS, is
   now stated in Lean on `origin/fs131-w8` at `f1c13612` (not on your branch; read it with `git show f1c13612:<path>` or in the tree
   below). State your named hypothesis for FS129-SR3-QFREE-NS so that this theorem discharges it at the join in a line:

{Q(E,"theorem emptyNS ")}
{Q(E,"    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) : False := by")}
   It is stated at `ArcMap 6` and reads no simplicity (inventory item 524). `GammaFreeRing` is in the foundation you already hold.
2. **Wave 7's first pass has handed back too** (inventory item 513): its thirteen four-colour rows are not yet stated; a second pass
   will state them on `fs131-w7`. If a row of yours reads one of them, take it as a named hypothesis under a name of your own, as
   ruling 498 has it, and tell me which.
3. **A lesson from today, for your mid-job messages** (inventory item 526): when you report a defect, say which kind it is — a
   *statement* that needs a hypothesis its entry lacks, or a *route* that reads more than the statement needs (a shorter-route note, no
   defect). One report this session was the second kind and was retracted by its reporter within the hour.
'''
open(B,"w").write(s.rstrip("\n")+a)
print("amended")
