pol=polcompositum(y^3-y-1,y^2-7)[1]; nf=nfinit(pol); rnf=rnfinit(nf,x^2+1);
print("deg ",poldegree(pol)," real embeddings ",nf.sign);
P3=idealprimedec(nf,3); for(k=1,#P3,print("3: e=",P3[k].e," f=",P3[k].f));
P2=idealprimedec(nf,2); for(k=1,#P2, Q=rnfidealprimedec(rnf,P2[k]); print("2: eF=",P2[k].e," fF=",P2[k].f," #above in L=",#Q," rel e=",Q[1].e/P2[k].e));
P7=idealprimedec(nf,7); for(k=1,#P7,print("7: e=",P7[k].e," f=",P7[k].f));
