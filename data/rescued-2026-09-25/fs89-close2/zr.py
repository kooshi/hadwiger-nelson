import sys, re
from zq import q
for s in sys.argv[1:]:
    tot, out = q(s)
    print(f"### {s} -> {tot}")
    for zbl, yr, au, t, kind, ec in out[:6]:
        print(f"  {zbl} {yr} | {au} | {t[:120]} | {kind}")
        for e in ec:
            txt = e.get("text","") or ""
            txt = re.sub(r"\s+"," ",txt)
            print("     TEXT:", txt[:900])
