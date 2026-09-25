"""J23a control: every theorem id in M1's records' "Theorems this phase proved" tables appears in plans/FS91-derivation.md.
Run: python3 data/fs91/j23a/coverage.py [--plant]; exits 1 and names each missing id. The plant adds a fake id that must be reported."""
import re, sys
ids = """J03-1 J03-2 J03-3 J03-4 J01-1 J01-2 J01-3 J01-4 J01-5 J01-6 J01-7 J01-8 J03a-1 J03a-2 J03a-3 J03a-4 J03a-5 J03a-6 J03a-7
J03a-8 J03a-9 J02-L1 J02-L2 J02-L3 J02-L4 J02-T1 J02-T2 J02-T3 J02-C1 J02-C2 J02-A2.1′ J1 J2 J3 J-K J4 J4-C J4-A J2′ J-L4b J4-T6
J07-1 J07-2 J07-3 J07-4 J07-5 J07-6 J07-7 J07-8 J07-9 J07-10 J07-11 J07-12 J07-13 J07-14 J07-15 J10-L1 J10-L2 J10-L3 J10-L4 J10-L5
J10-L6 J10-L7 J10-L8 J10-T1 J10-T2 J10-T3 J10-T4 J10-T5 J10-T6 J10-T7 J10-T8 J10-T9 J08-1 J08-2 J08-3 J08-4 J08-5 J08-6 J08-7 J08-8
J08-9 J08-10 J08-11 J08-R J11-T1 J11-T2 J11-T3 J11-T4 J11-T5 J11-T6 J11-T7 J11-T8 J11-T9 J11-T10 J11-T11 J11-T12 J11-T13 J11-W3
J12-A1 J12-A2 J12-A3 J12-ONEa J12-HL J12-B1 J12-B2 J12-B3 J12-B4 J12-B5 J12-B6 J12-CL J12-CL′ J12-H J12-W J12-Ω J12-MS J12-MSp
J12-C1 J12-C2 J12-C3 J12-C4 J12-C3p""".split()
if "--plant" in sys.argv:
    ids.append("J99-PLANT")
s = open("plans/FS91-derivation.md", encoding="utf-8").read()
def present(i):
    # J09's bare ids (J1, J2, J3, J4 …) are written "J09-J1", "J09's J2", "J2′" etc.; require a non-alphanumeric boundary
    return re.search(r"(?<![\w])" + re.escape(i) + r"(?![\w′]|\.\d)", s) is not None
missing = [i for i in ids if not present(i)]
print(f"{len(ids)} ids, {len(missing)} missing: {missing}")
sys.exit(1 if missing else 0)
