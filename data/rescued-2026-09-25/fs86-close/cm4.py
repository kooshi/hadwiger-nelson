import sys; sys.path.insert(0,'/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-close')
from wsr import wsr
p='CLAUDE.md'
s=open(p,encoding='utf-8').read()
# G54
s=wsr(s,"Both properties **propagate up a tower** whose level maps carry `S_{m+1}` onto `S_m` with constant fibres (`λ_min/d` is non-increasing under pullback), which is why the 2-adic tower is tight and the 11-adic tower slack at every level;",
"**Slackness propagates up a tower** whose level maps carry `S_{m+1}` onto `S_m` with constant fibres (`λ_min/d` is non-increasing under pullback), which is why the 11-adic tower is slack at every level; **tightness does not** (row 93: `Λ₅₁₀`'s quotients, constant fibres, are tight at 14 and slack at 24) — the 2-adic tower is tight at every level by FS38-L2's non-strict half, as is every unramified quadratic dyadic tower containing `√3` (row 93). *Demotion record:* this sentence said both properties propagate, from FS38-L1, whose tightness half has a wrong-direction step (FS-86's B2);")
s=wsr(s,"(p = 31 misses 4-tightness by 4.4·10⁻⁵).","(p = 31 misses 4-tightness by 4.4·10⁻⁵ in the normalisation `9(λ_min + d/3)/d`: `λ_min + d/3 = 1.5617·10⁻⁴`, ratio `1/4 − 2.745·10⁻⁶`).")
# G75
s=wsr(s,"Killing test of the reading: a triangle-free lattice whose NT-type identity pins the spectrum onto finitely many torsion characters (FS-86, FS-59).*",
"Killing test of the reading: a triangle-free lattice whose NT-type identity pins the spectrum onto finitely many torsion characters (FS-59; not fired at FS-86, where no pinning identity was found on a type-(B) plane and pair correlations provably cannot pin on a real field, row 91).* *The method is Kari–Szabados's annihilator method, and one family alone is Puzynina's exceptional case (`det(B + I) = 0`), which is why one family cannot give periodicity (row 85's attribution); on type-(B) planes such an identity valid for every colouring exists iff `F(R) ≠ 0` (FS86-Cx-C11), so the identity is the question.*")
# G21: FS-86's instances after FS-85's two
s=wsr(s,"measured membership, not logic (the wiki's Prop. 7, V6).",
"measured membership, not logic (the wiki's Prop. 7, V6). **FS-86's four:** a verifier's plant fired first for the wrong reason (a division by zero before the circle-size check it was written for, at `Γ₂₇`); B1's first PARI stability checker compared prime-ideal objects and silently found no stable primes (caught because 2 must be stable); B1's `ζ ↦ ζ⁵` plant was unreachable (another tight torus), kept and labelled; and two owner-brief paraphrases dropped a qualifier (\"unit-distance\"; \"the closure is `ℚ₂(√3)`\"), manufacturing one spurious gap and widening one statement — **quote a statement verbatim in a brief**.")
open(p,'w',encoding='utf-8').write(s)
print(len(s.encode()))
