"""B3 planted fault, two-sided, at the thinnest margin (p = 31, where float lambda_min + d/3 = 1.57e-4): shift the threshold by eps.
eps = 1/1000 exceeds the true margin in 3*lambda + d (about 4.7e-4) and MUST flip the verdict to 'does not refuse';
eps = 1/10000 is below it and MUST keep 'refuses'.  Run: python3 b3_plant.py  (seconds; writes b3_plant.out)"""
import subprocess, re, sys
src = open('gp/p31_split_11.gp').read()
out = open('b3_plant.out', 'w')
ok = True
for eps, must in (("1/1000", "flip"), ("1/10000", "hold")):
    g = src.replace("+2*d; f=charpoly", f"+2*d-2*({eps}); f=charpoly")
    assert g != src
    r = subprocess.run(['gp', '-q', '-f'], input=g + "\n\\q\n", capture_output=True, text=True).stdout.strip()
    bad = int(re.search(r"<= -d/3: (\d+)", r).group(1))
    got = "flip" if bad > 0 else "hold"
    ok &= (got == must)
    print(f"eps={eps}: {r} -> {got} (must {must})", file=out); print(f"eps={eps}: -> {got} (must {must})")
print("PLANT", "PASS: the exact test resolves the margin at 31 on both sides" if ok else "FAIL", file=out)
print("PLANT", "PASS" if ok else "FAIL"); sys.exit(0 if ok else 1)
