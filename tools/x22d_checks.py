#!/usr/bin/env python3
"""X22D exact checks (seconds; PARI via gp). C-0: the dyadic place of F = Q(sqrt d)
in L = F(i) -- stable (one prime of L above each prime of F above 2, fixed by
conjugation) and inert/ramified/split in L/F.  Control: Q(sqrt 5) is row 100's
known exception (a ramified stable dyadic place) and must read 'ramified'.
Plant (--plant): report ramification index e(P|p) as 1 always; the Q(sqrt 5)
control must then go red.  Exit status 0 only if every check and control passes."""
import subprocess, sys

PLANT = "--plant" in sys.argv

def gp(cmd):
    out = subprocess.run(["gp", "-q", "-f"], input=cmd + "\nquit\n",
                         capture_output=True, text=True, timeout=60)
    if out.returncode != 0:
        raise SystemExit("gp failed: " + out.stderr)
    return out.stdout.strip()

def dyadic(d):
    # For each prime p of F above 2: the primes P of L above p, with e(P|p), f(P|p).
    script = f"""
F = nfinit(x^2 - {d}); L = nfinit(polcompositum(x^2 - {d}, x^2 + 1)[1]);
pF = idealprimedec(F, 2); pL = idealprimedec(L, 2);
print(#pF); for(i=1,#pF, print(pF[i].e, " ", pF[i].f));
print(#pL); for(i=1,#pL, print(pL[i].e, " ", pL[i].f));
"""
    lines = gp(script).split()
    it = iter(lines)
    nF = int(next(it)); eF = [(int(next(it)), int(next(it))) for _ in range(nF)]
    nL = int(next(it)); eL = [(int(next(it)), int(next(it))) for _ in range(nL)]
    return eF, eL

def classify(d):
    eF, eL = dyadic(d)
    # [L:F] = 2.  One prime of F above 2 and one of L above it: stable (conjugation
    # fixes it); then e(P|p) = eL/eF, f(P|p) = fL/fF decide inert (e=1,f=2) or ramified (e=2,f=1).
    if len(eF) == 1 and len(eL) == 1:
        e = eL[0][0] // eF[0][0]; f = eL[0][1] // eF[0][1]
        if PLANT:
            e = 1
        return {(1, 2): "inert", (2, 1): "ramified"}.get((e, f), f"?e={e},f={f}")
    if len(eL) == 2 * len(eF):
        return "split"
    return f"mixed eF={eF} eL={eL}"

ok = True
for d, want in [(59, "inert"), (83, "inert"), (131, "inert"), (5, "ramified"), (47, "split")]:
    got = classify(d)
    flag = "OK " if got == want else "RED"
    ok &= (got == want)
    print(f"{flag} Q(sqrt {d}): dyadic place of L/F is {got} (expected {want})")
print("ALL PASS" if ok else "FAILURE")
sys.exit(0 if ok else 1)
