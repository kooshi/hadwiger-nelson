#!/usr/bin/env python3
"""X22V C-0 check (exact, seconds): the behaviour of the dyadic places of F = Q(sqrt d) in L = F(i).

For each d, PARI computes the primes above 2 in F and in L (absolute fields) and reads the relative
behaviour of each dyadic place of F in L/F: split (two primes above it), inert (f doubles), ramified (e doubles).
A dyadic place of F is conjugation-stable in L exactly when it does not split in L/F.
Row 100's exception is "a ramified stable dyadic place".

Controls (must fire): Q(sqrt 5) is an exception field (ramified stable dyadic place);
Q(sqrt 167) has no stable dyadic place (split).  Plant: --plant replaces x^2 - d by x^2 + d for the
claim's fields, which must change at least one verdict (Q(sqrt -59) etc.), else the check is blind.
"""
import subprocess
import sys

GP = r"""
dyad(d, sgn) = {
  my(F = nfinit(x^2 - sgn*d), L = nfinit(polcompositum(x^2 - sgn*d, x^2 + 1)[1]));
  my(pF = idealprimedec(F, 2), pL = idealprimedec(L, 2));
  \\ one dyadic place of F in every case below (d = 3 mod 4 or 5 mod 8); guarded:
  if (#pF != 1, return([#pF, -1, -1, -1]));
  my(eF = pF[1].e, fF = pF[1].f);
  if (#pL == 2, return([1, eF, fF, 0]));          \\ split in L/F
  my(eL = pL[1].e, fL = pL[1].f);
  if (eL == 2*eF, return([1, eF, fF, 2]));        \\ ramified in L/F
  if (fL == 2*fF, return([1, eF, fF, 1]));        \\ inert in L/F
  return([1, eF, fF, -9]);
}
"""

NAMES = {0: "split (not stable)", 1: "inert (stable)", 2: "RAMIFIED (stable) -- row 100's exception", -9: "??"}


def run(ds, sgn):
    prog = GP + "\n" + "\n".join(f"print({d}, \" \", dyad({d}, {sgn}));" for d in ds) + "\nquit\n"
    out = subprocess.run(["gp", "-q", "-f"], input=prog, capture_output=True, text=True, check=True).stdout
    res = {}
    for line in out.strip().splitlines():
        d, vec = line.split(" ", 1)
        v = [int(t) for t in vec.strip("[]").split(",")]
        res[int(d)] = v
    return res


def main():
    plant = "--plant" in sys.argv
    claim = [59, 83, 131]
    controls = {5: 2, 167: 0}
    r = run(claim, -1 if plant else 1)
    rc = run(list(controls), 1)
    ok = True
    for d in claim:
        v = r[d]
        print(f"F = Q(sqrt({'-' if plant else ''}{d})): dyadic places of F = {v[0]}, e_F = {v[1]}, f_F = {v[2]}; in L/F: {NAMES.get(v[3])}")
        if v[0] != 1 or v[3] != 1:
            ok = False
    for d, want in controls.items():
        v = rc[d]
        print(f"control Q(sqrt({d})): {NAMES.get(v[3])} (expected {NAMES[want]})")
        if v[3] != want:
            print("CONTROL FAILED")
            sys.exit(2)
    print("C-0:", "TRUE (every dyadic place inert in L/F, none ramified)" if ok else "NOT as claimed")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
