import cmath, math, random
pi = math.pi
e = lambda t: cmath.exp(1j*t)
def chart(p, a, d): return p + e(a) + e(a - 2*pi/3 - d)
def r(d): return 2*math.cos(pi/3 + d/2)
def shift(d, dp):
    q = (r(d)**2 + r(dp)**2 - 1)/(2*r(d)*r(dp))
    return math.acos(q) - pi/3 - (d+dp)/2
def partner(a, d, dp):  # angle u with chart(a,d) + e(u) = chart(a', dp)
    return a - pi/3 - d/2 + pi - math.acos((r(d)**2 + 1 - r(dp)**2)/(2*r(d)))
random.seed(1)
mx = 0; mxu = 0; mxp = 0; mxh = 0
for _ in range(20000):
    p = complex(random.uniform(-3,3), random.uniform(-3,3)); a = random.uniform(-10,10)
    d = random.uniform(-0.25,0.25); dp = random.uniform(-0.25,0.25)
    z = chart(p,a,d)
    mxp = max(mxp, abs(z - (p + r(d)*e(a - pi/3 - d/2))))
    mxh = max(mxh, abs(chart(p, a + pi/3, 0) - (p + e(a))))
    if d >= 0 and dp >= 0:
        ap = a + pi/3 + dp + shift(d,dp)
        zp = chart(p, ap, dp)
        mx = max(mx, abs(abs(z-zp) - 1))
        mxu = max(mxu, abs(z + e(partner(a,d,dp)) - zp))
print("polar", mxp, "hub", mxh, "dist", mx, "partner", mxu)
# negative d too?
mxn = 0
for _ in range(20000):
    a = random.uniform(-10,10); d = random.uniform(-0.25,0.25); dp = random.uniform(-0.25,0.25)
    ap = a + pi/3 + dp + shift(d,dp)
    mxn = max(mxn, abs(abs(chart(0,a,d)-chart(0,ap,dp)) - 1))
print("dist on |d|<=1/4 box", mxn)
# shift bounds on (0,k]^2
for k in [0.25, 0.1, 0.05, 0.03, 0.02, 0.01]:
    N = 200; lo = 1e9; hi = -1e9; rat_lo = 1e9; rat_hi = -1e9; lip = 0
    h = k/N
    for i in range(1,N+1):
        for j in range(1,N+1):
            d = i*h; dp = j*h
            s = shift(d,dp)
            lo = min(lo, s); rat_lo = min(rat_lo, s/(d*dp)); rat_hi = max(rat_hi, s/(d*dp))
            hi = max(hi, s/min(d,dp))
            if i < N:
                lip = max(lip, abs(shift(d+h,dp) - s)/h)
    print(k, "min", lo, "ratio", rat_lo, rat_hi, "max s/min(d,d')", hi, "lipschitz", lip, "1/32=", 1/32, "1/16=",1/16)
# zero on axes
print(max(abs(shift(d,0)) for d in [i/1000 for i in range(-250,251)]), max(abs(shift(0,d)) for d in [i/1000 for i in range(-250,251)]))
# twoCirc identity: |z-z'|^2 - 1 at shift 0
mxi = 0
for _ in range(10000):
    a = random.uniform(-10,10); d = random.uniform(-1,1); dp = random.uniform(-1,1)
    z = chart(0,a,d); zp = chart(0,a+pi/3+dp,dp)
    mxi = max(mxi, abs(abs(z-zp)**2 - 1 + 8*math.sin(d/2)*math.sin(dp/2)*math.cos((d+dp)/2)))
print("twoCirc", mxi)
# partner angle monotone in dp
bad = 0
for _ in range(2000):
    a = random.uniform(-3,3); d = random.uniform(0.001,0.25)
    us = [partner(a,d,j*0.25/200) for j in range(1,201)]
    difs = [us[i+1]-us[i] for i in range(len(us)-1)]
    if not (all(x>0 for x in difs) or all(x<0 for x in difs)): bad += 1
    
print("partner non-monotone cases", bad, "sample slope", (partner(0,0.1,0.11)-partner(0,0.1,0.1))/0.01)
