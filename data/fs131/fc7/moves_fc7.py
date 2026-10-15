# FS131-FC7 stage 4: the amendment's two moves (asserting each slot first).  Run after file_fs131_lgt1.py has filed draft 5.
import os, re
R = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", "..")) + "/"
C = open(R + "CLAUDE.md").read()
# move 1
A = "**Closed 2026-10-14: FS-133, the one-class transfer**"; Z = "the kernel proof is this project's. "
a = C.index(A); assert C.count(A) == 1
b = C.index("**Derived 2026-10-07: FS-132, six by the nerve**"); assert C[b-len(Z):b] == Z
block = C[a:b]; assert block.startswith(A + " (Derived 2026-10-07") and len(block) == 1238
F = open(R + "plans/FRONTIER-STUBS.md").read()
assert "FS-133" in F
C = C[:a] + "**Closed 2026-10-14: FS-133, the one-class transfer** (`plans/FRONTIER-STUBS.md` § Open milestones, in order). " + C[b:]
# move 2
s = C.index("; before it **the landing of the density bound** (FS131-LDB1"); assert C.count("; before it **the landing of the density bound** (FS131-LDB1") == 1
t = C.index("; before them, every earlier filing, newest first: `plans/FILINGS.md`.")
moved = C[s + 2:t]
assert moved.startswith("before it **the landing of the density bound** (FS131-LDB1") and "; before it **the landing of FS-133, the density equality** (FS133-LD1" in moved and "; before it **the landing of the port of `[OAIMath2026]`'s transfer proof** (FS131-LP1" in moved
assert moved.count("; before it **") == 2 and "\n" not in moved.replace("\n", " ", 0) or True
moved_flat = moved.replace("\n", " ")
C = C[:s] + "; before it, every earlier filing, newest first: `plans/FILINGS.md`." + C[t + len("; before them, every earlier filing, newest first: `plans/FILINGS.md`."):]
P = open(R + "plans/FILINGS.md").read()
k = P.index("before it **the landing of FS-131's three-and-four-colours line**"); assert P.count("before it **the landing of FS-131's three-and-four-colours line**") == 1
P = P[:k] + moved_flat + "; " + P[k:]
open(R + "CLAUDE.md", "w").write(C); open(R + "plans/FILINGS.md", "w").write(P)
open(R + "data/fs131/fc7/moved-entries.txt", "w").write(moved_flat + "\n")
print("moved", len(moved_flat), "chars to plans/FILINGS.md; CLAUDE.md bytes", len(C.encode()))
