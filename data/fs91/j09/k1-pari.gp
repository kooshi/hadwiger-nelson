\\ independent check of the K1 failure at q = 27 (PARI finite fields, a different representation)
g = ffgen(3^6, 'g); o = ffprimroot(g);
mu = vector(28, k, o^((k-1)*26));
i4 = o^(728/4);
mu4 = [1, -1, i4, -i4];
tr9(y) = y + y^9 + y^81;
tr3(y) = my(z = tr9(y)); z + z^3;
cnt(a) = sum(k=1,28, my(m = tr9(a*mu[k])); if(setsearch(Set(mu4), m), 1, 0));
zer(a) = sum(k=1,28, if(tr3(a*mu[k]) == 0, 1, 0));
print("a=1: count in mu4 = ", cnt(1), "; values tr9(t) = ", Set(vector(28,k,tr9(mu[k]))));
bad = 0; minz = 99; forstep(e=0,727,1, my(a=o^e, c=cnt(a), n=a^28); if(c==0, bad++; if(n!=1, print("fail with N(a) != 1: ", n))); minz = min(minz, zer(a)));
print("number of a with count 0: ", bad, "; min zeros of Tr_{729/3}(a t) on mu28 over all a: ", minz);
