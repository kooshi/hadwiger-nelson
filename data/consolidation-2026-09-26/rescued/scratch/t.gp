nf=nfinit(y^2-3); rnf=rnfinit(nf,x^2+1);
P=idealprimedec(nf,2); print(P[1].e," ",P[1].f);
Q=rnfidealprimedec(rnf,P[1]); print(#Q); print(type(Q)); print(Q[1].e, " ", Q[1].f);
nf1=nfinit(y-1); rnf1=rnfinit(nf1,x^2+1); P1=idealprimedec(nf1,2); Q1=rnfidealprimedec(rnf1,P1[1]); print(#Q1," ",Q1[1].e," ",Q1[1].f);
