#!/usr/bin/env python3
"""FS-131: what an implementer job measured, for the price-against-plan calibration (inventory item 541).

Per job: Lean lines inserted under Proofs/ between the parent of its first commit and its last commit (commit subjects
"<job>: ..."), the harness's token count where the inventory records it, and minutes (the harness's duration where a task
notice gave it, else first-to-last commit plus 12 for the readback before the first commit — an estimate, marked ~).
Run from the repository root: python3 data/fs131/calibration/measure.py
"""
import re, subprocess
R = subprocess.run(["git", "rev-parse", "--show-toplevel"], capture_output=True, text=True).stdout.strip()
def git(*a): return subprocess.run(["git", "-C", R] + list(a), capture_output=True, text=True).stdout
TOK = {"FS131-I6A": 411, "FS131-I6B": 407, "FS131-I6C": 546, "FS131-I6D": 542, "FS131-I10A": 404, "FS131-I10B": 449,
       "FS131-I10C": 444, "FS131-I10D": 353}                      # thousands, "harness NNNk by the task notice"
MIN = {"FS131-I6B": 59, "FS131-I6C": 79, "FS131-I6D": 68, "FS131-I10D": 44}   # the task notices' duration_ms
JOBS = list(TOK) + ["FS131-MA1", "FS131-MB1", "FS131-MB2", "FS131-BA1", "FS131-BA2", "FS131-IR3", "FS131-IA2", "FS131-IS1",
                    "FS131-CG1", "FS131-CC2", "FS131-IL2"]
log = git("log", "--all", "--format=%H %at %s").split("\n")
print(f"{'job':12} {'+lines':>7} {'tokens':>7} {'minutes':>8} {'tok/line':>8} {'lines/h':>8}")
pts = []
for j in JOBS:
    cs = sorted((int(l.split()[1]), l.split()[0]) for l in log if re.match(r"\S+ \d+ " + re.escape(j) + r":", l))
    if not cs: print(j, "no commits"); continue
    st = git("diff", "--shortstat", cs[0][1] + "^", cs[-1][1], "--", "Proofs")
    ins = int(re.search(r"(\d+) insertions?", st).group(1)) if "insertion" in st else 0
    span = (cs[-1][0] - cs[0][0]) / 60
    mins, mark = (MIN[j], "") if j in MIN else (span + 12, "~")
    tok = TOK.get(j)
    if tok: pts.append((ins, tok))
    print(f"{j:12} {ins:7d} {(str(tok) + 'k') if tok else '-':>7} {mark + format(mins, '.0f'):>8} "
          f"{format(tok * 1000 / ins, '.0f') if tok and ins else '-':>8} {format(ins / (mins / 60), '.0f'):>8}")
n = len(pts); mx = sum(x for x, _ in pts) / n; my = sum(y for _, y in pts) / n
b = sum((x - mx) * (y - my) for x, y in pts) / sum((x - mx) ** 2 for x, _ in pts)
print(f"least squares over the {n} jobs with a harness count: tokens ~ {my - b * mx:.0f}k + {b * 1000:.0f} per line")
