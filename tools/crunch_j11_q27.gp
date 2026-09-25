g=ffgen(3^6,'a); w=ffprimroot(g); o=fforder(w);
mu=vector(28,j,w^(26*j)); if(#Set(mu)!=28,error("mu"));
for(j=1,28, if(mu[j]^28!=1, error("mu28")));
m=100; M=-1; for(e=0,727, b=w^e; n0=sum(j=1,28, trace(b*mu[j])==0); m=min(m,n0); M=max(M,n0));
print("order ",o," minN0 ",m," maxN0 ",M, "  lambda_min=(3*minN0-28)/2=",(3*m-28)/2);
\\ control: the same count at q=23 as a field F_{23^2}, where band characters must appear (N0 = 0 for non-square norm c)
h=ffgen(23^2,'b); v=ffprimroot(h); nu=vector(24,j,v^(22*j));
m2=100; for(e=0,527, b=v^e; n0=sum(j=1,24, trace(b*nu[j])==0); m2=min(m2,n0)); print("q=23 control minN0 ",m2);
