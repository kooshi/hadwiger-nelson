p='LEDGER.md'
s=open(p).read()
# row 79 corrections
old="**[hand] Four colours have neither** — `K₄`'s square complex is `ℝP²`, so a four-colouring carries only a ℤ/2 winding, no height and no slope; `G(ℤ, {1,3,4,5})` is 4-colourable with no linear colouring — so no `Θ`-type two-sided certificate exists at four colours, and one exists iff 4-colourability of Cayley graphs of ℤ^r is decidable (unknown)."
new="**[hand] Four colours have neither, cell by cell** — `K₄`'s square complex is `ℝP²`, whose one loop invariant, a ℤ/2 winding, is each relation's length parity, the same for every colouring; an edge-local height exists only on four-colourable presentations of rank ≤ 2 (Moore–Newman's triangular lattice among them), no height and no slope anywhere else (both row 80); `G(ℤ, {1,3,4,5})` is 4-colourable with no linear colouring — so no `Θ`-type certificate built from edge-local heights exists at four colours, and a two-sided finite certificate scheme exists iff 4-colourability of Cayley graphs of ℤ^r is decidable (stated open in print: `[CGHO2025bg]` §6.2.1)."
assert s.count(old)==1; s=s.replace(old,new)
old="the first bound above three where the conjecture predicts six (FS-59's first target) — by two"
new="the first bound above three where the conjecture predicts six (FS-59's first target; at four colours `L21cc6506` is four-colourable and loose, row 81) — by two"
assert s.count(old)==1; s=s.replace(old,new)
old="**Prior art:** the height lift is the standard device"
new="**Prior art:** the criterion and density answer, at `k = 3` and every rank, a question posed three times — `[Ellenberg2018]` (MathOverflow, 2018: does a `k`-colourable Cayley graph of ℤ^r have a periodic `k`-colouring?), P. Gibbs and D. Mixon on Polymath16 (2018; `[Polymath16threads]`), carried as open by `[CGHO2025bg]` §6.2.1 (2025) — `CLOSED-QUESTIONS.md` §2.4, with the scope of that check; the height lift is the standard device"
assert s.count(old)==1; s=s.replace(old,new)
row80 = open('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-close/row80.txt').read().strip()
row81 = open('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-close/row81.txt').read().strip()
anchor="\n\n## B. Theorems proved outside the kernel"
assert s.count(anchor)==1
s=s.replace(anchor,"\n"+row80+"\n"+row81+anchor)
open(p,'w').write(s)
print("ok")
