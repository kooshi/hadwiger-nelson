"""FS-85 Part 2 by-product (Coxeter): a triangle-free uniquely 4-colourable circulant, answering Klotz-Sander 2017 Problem 3.6
('is chi = omega for every uniquely colourable circulant?') in the negative at four colours, and the rank-1 distance graph whose
only 4-colouring up to relabelling is x mod 4.  Object given by formula; every check below is a check, not a search.
The one external fact: Mycielski's theorem, chi(M(G)) = chi(G) + 1."""
import math
from part2_rank1 import n3, EH, f, u_, v_
from sympy import isprime as is_prime
def _unused(p):
    if p<2: return False
    for q in range(2,int(math.isqrt(p))+1):
        if p%q==0: return False
    return True
def embed(B,K,off):
    return [f[i]+4*K*B**(i+off) for i in range(n3)]
# --- (a) the circulant: one copy of H, N = 4q with q prime, q > 3*maxD/4 + everything, q not dividing delta/4
Nv=embed(7,5,0)
D=sorted({abs(Nv[a]-Nv[b]) for a,b in EH}); Dset=set(D)
delta=Nv[v_]-Nv[u_]; assert delta%4==0
q=3*max(D)//4+1
while not (is_prime(q) and (delta//4)%q!=0): q+=1
N=4*q
S={d%N for d in D}|{(-d)%N for d in D}
assert 0 not in S
# triangle-free mod N: any +-d1+-d2+-d3 = 0 mod N has |.| <= 3 maxD < N, so is 0 in Z, excluded by sum-freeness
assert 3*max(D)<N and not any(d1+d2 in Dset for d1 in D for d2 in D)
assert all(d%4 for d in D)                         # x mod 4 is proper
res={d%4 for d in D}; assert res>={1,2} or res>={3,2}, res   # quotient Cay(Z/4, D mod 4) is K4
g=math.gcd(delta,N)
print('circulant Z/N, N = 4q, q prime =',q,'; |S| =',len(S),'; gcd(delta, N) =',g,'-> <delta> = 4Z/N:',g==4)
print('D mod 4 residues:',sorted(res))
# --- (b) rank 1: two disjoint copies with gcd(delta1/4, delta2/4) = 1  ->  F4 = 4Z, unique 4-colouring x mod 4
N1=embed(7,5,0); N2=embed(7,5,23)          # second copy uses powers 7^23..7^45: disjoint supports keep genericity
allN=N1+N2
EH2=[(a,b) for a,b in EH]+[(a+n3,b+n3) for a,b in EH]
D2=sorted({abs(allN[a]-allN[b]) for a,b in EH2}); D2s=set(D2)
assert len(D2)==len(EH2)==140
assert not any(d1+d2 in D2s for d1 in D2 for d2 in D2)
assert all(d%4 for d in D2)
d1=N1[v_]-N1[u_]; d2=N2[v_]-N2[u_]
print('two copies: gcd(delta1, delta2) =', math.gcd(d1,d2), '; gcd(D2) =', math.gcd(*D2))
