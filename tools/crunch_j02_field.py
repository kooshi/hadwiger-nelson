#!/usr/bin/env python3
"""J02 (crunch 2026-09-25): the arithmetic of F = Q(alpha, sqrt 7), alpha^3 = alpha + 1, re-derived in PARI/GP (exact).

For every prime pr of F above 2, 3 and 7 it reports e, f and the behaviour of pr in L = F(i): split (not stable),
inert (stable, unramified) or ramified (stable). It asserts what S3 uses (plans/FS91-S0F-three-colours.md stage 3):
  (A1) F has signature [2, 2] (two real places, two complex places);
  (A2) every prime of F above 3 is stable and has residue field F_27: no stable prime above 3 has residue field F_3;
  (A3) no prime of F above 2 is stable (the wall is broken; no dyadic target, in particular none ramified in L/F);
  (A4) exactly one stable prime above 7 has residue field F_7 (the plane at 7 four-colours F^2).
By J02-T2, (A2)+(A3) give chi(F^2) >= 4 and Theta_3(R_F) = empty; (A4) gives chi(F^2) <= chi(Gamma_7) = 4.

Plants (--plant NAME), each must fail its own assertion:
  cubic2 : the cubic x^3 - 2 in place of x^3 - x - 1 (3 is totally ramified, residue field F_3) -> (A2) fires.
  sqrt11 : sqrt 11 in place of sqrt 7 (Q_2(sqrt 11) = Q_2(sqrt 3) lacks i; the dyadic prime is inert in L) -> (A3) fires.
"""
import argparse
import subprocess
import sys

GP_TEMPLATE = r"""
P = polcompositum({cubic}, {quad})[1];
F = nfinit(subst(P, x, y));
print("POL ", P);
print("SIG ", F.sign[1], " ", F.sign[2]);
R = rnfinit(F, x^2 + 1);
foreach([2, 3, 7], p, D = idealprimedec(F, p); for(j = 1, #D, pr = D[j]; up = rnfidealprimedec(R, pr); print("PR ", p, " ", pr.e, " ", pr.f, " ", #up, " ", up[1].e, " ", up[1].f)));
"""


def run(cubic, quad):
    script = GP_TEMPLATE.format(cubic=cubic, quad=quad)
    out = subprocess.run(["gp", "-q", "-f"], input=script, capture_output=True, text=True, timeout=120)
    if out.returncode != 0 or "***" in out.stdout or "***" in out.stderr:
        raise RuntimeError("gp failed:\n" + out.stdout + out.stderr)
    return out.stdout


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", choices=["cubic2", "sqrt11"], default=None)
    args = ap.parse_args()
    cubic = "x^3 - 2" if args.plant == "cubic2" else "x^3 - x - 1"
    quad = "x^2 - 11" if args.plant == "sqrt11" else "x^2 - 7"
    text = run(cubic, quad)
    sig, primes = None, []
    for line in text.splitlines():
        parts = line.split()
        if not parts:
            continue
        if parts[0] == "POL":
            print("defining polynomial of F:", " ".join(parts[1:]))
        elif parts[0] == "SIG":
            sig = (int(parts[1]), int(parts[2]))
        elif parts[0] == "PR":
            p, e, f, g, eL, fL = map(int, parts[1:])
            if g == 2:
                kind = "split"
            elif fL == 2 * f:
                kind = "inert"
            elif eL == 2 * e:
                kind = "ramified"
            else:
                raise RuntimeError(f"unclassifiable prime above {p}")
            primes.append((p, e, f, kind))
    print(f"cubic {cubic}, quadratic {quad}; signature {sig}")
    for p, e, f, kind in primes:
        stable = kind != "split"
        print(f"  prime above {p}: e={e} f={f} residue field F_{p**f}; in L=F(i): {kind}; stable={stable}")
    a1 = sig == (2, 2)
    three = [(e, f, k) for p, e, f, k in primes if p == 3]
    a2 = all(k != "split" for e, f, k in three) and not any(f == 1 and k != "split" for e, f, k in three)
    two = [(e, f, k) for p, e, f, k in primes if p == 2]
    a3 = all(k == "split" for e, f, k in two)
    seven = [(e, f, k) for p, e, f, k in primes if p == 7]
    a4 = sum(1 for e, f, k in seven if f == 1 and k != "split") == 1
    for name, ok in (("A1 signature [2,2]", a1), ("A2 no stable F_3 prime above 3", a2),
                     ("A3 no stable prime above 2", a3), ("A4 one stable F_7 prime above 7", a4)):
        print(f"{name}: {ok}")
    ok = a1 and a2 and a3 and a4
    print("RESULT:", "PASS" if ok else "FAIL")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
