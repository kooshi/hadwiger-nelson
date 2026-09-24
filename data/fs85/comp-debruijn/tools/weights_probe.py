"""AIMING ONLY (logged): can orbit weights w_|b| on U = mu6*eta^b make the continuous-torus Hoffman ratio of Cay(Lambda, U) reach 1/4?
ratio(w) = -m(w)/(d(w) - m(w)), m(w) = min over the torus of sum_u w_u cos(2 pi theta.u)."""
import numpy as np
from lam import *
from scipy.optimize import minimize
U = load_U()
eta=(Fr(0),Fr(1,6),Fr(0),Fr(-1,6))
def pw(a,k):
    r=ONE
    if k<0: a=inv(a); k=-k
    for _ in range(k): r=mul(r,a)
    return r
bof = {}
for b in range(-4,5):
    for a in range(6):
        bof[mul(pw(Z6,a),pw(eta,b))] = abs(b)
UC = np.array([[int(9*x) for x in coords(u)] for u in U]); orb = np.array([bof[u] for u in U])
rng = np.random.default_rng(7)
TH = rng.random((60000,4))
PH = np.cos(2*np.pi*TH @ UC.T)                      # (N, 54)
def mmin(w):
    wu = w[orb]; v = PH @ wu; i = np.argsort(v)[:20]
    best = v[i[0]]
    for j in i:                                     # refine the 20 lowest samples
        t = TH[j].copy(); step = 0.02; cur = (np.cos(2*np.pi*t @ UC.T) * wu).sum()
        for it in range(300):
            c = t + rng.normal(0, step, (32,4)); vv = (np.cos(2*np.pi*c @ UC.T) * wu).sum(axis=1); k = vv.argmin()
            if vv[k] < cur: cur = vv[k]; t = c[k]
            else: step *= 0.9
            if step < 1e-7: break
        best = min(best, cur)
    return best
def ratio(x):
    w = np.abs(x); d = (w[orb]).sum(); m = mmin(w)
    return -m/(d - m)
for w0 in [np.ones(5), np.array([1,1,1,1,0.]), np.array([1,0,1,0,1.]), np.array([1,1,0,0,0.]), np.array([0,0,1,0,0.])]:
    print('w =', w0, ' ratio = %.5f' % ratio(w0))
res = minimize(ratio, np.ones(5), method='Nelder-Mead', options={'maxiter': 150, 'xatol':1e-3, 'fatol':1e-5})
print('best found:', np.round(np.abs(res.x)/np.abs(res.x).max(), 4), ' ratio = %.5f' % res.fun, ' (1/4 = 0.25)')
