default(parisize,10^8);
for(k=1,3,d=[59,83,131][k]; K=nfinit(polcompositum(x^2-d,x^2+1)[1]); P=idealprimedec(K,2); print(d,": primes above 2 in Q(sqrt d,i): ",#P," e=",P[1].e," f=",P[1].f); P59=idealprimedec(K,d); print("   primes above ",d,": ",#P59," e=",P59[1].e," f=",P59[1].f));
\\ local field check: is 3*d a square in Q_2 ?
for(k=1,3,d=[59,83,131][k]; print(d," 3d mod 8 = ",(3*d)%8, "  issquare(3d+O(2^10)) = ", issquare(3*d+O(2^10))));
\\ K(i) control
K=nfinit(polcompositum(polcompositum(x^2-3,x^2-11)[1],x^2+1)[1]); P=idealprimedec(K,2); print("K(i): ",#P," primes above 2, e=",P[1].e," f=",P[1].f);
