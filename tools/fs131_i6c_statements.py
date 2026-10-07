#!/usr/bin/env python3
"""FS131-I6C: no statement or definition of `Curve` or `LocalGraph` changed since the base commit.

For each of the two files, every declaration of the base version (a line at column 0 starting with `theorem`,
`structure`, `def`, `abbrev`, `noncomputable def` or `instance`) is cut out as its *statement*: for a structure, the
block up to the next blank line; otherwise the lines up to and including the first one that holds `:=`. Each statement
must occur verbatim in the current file. Also: the current files hold no `axiom` declaration and no `native_decide`.
Prints one line per declaration and the counts; exit 1 on any failure, exit 2 if no declaration was found (a check
that found nothing to check has not passed).

Usage: python3 tools/fs131_i6c_statements.py [--plant]
  --plant alters one character of the current text inside the first statement: the check must report it and exit 1."""
import subprocess, sys, pathlib, re

ROOT = pathlib.Path(__file__).resolve().parent.parent
BASE = "32f2ab4c"
FILES = ["Proofs/HadwigerNelson/Plane/Saturated/Curve.lean", "Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean"]
HEAD = re.compile(r"^(theorem|structure|def|abbrev|noncomputable def|instance)\b")

def statements(text):
    lines, out, i = text.splitlines(), [], 0
    while i < len(lines):
        if HEAD.match(lines[i]):
            j = i
            if lines[i].startswith("structure"):
                while j + 1 < len(lines) and lines[j + 1].strip():
                    j += 1
            else:
                while ":=" not in lines[j] and j + 1 < len(lines):
                    j += 1
            out.append("\n".join(lines[i:j + 1]))
            i = j + 1
        else:
            i += 1
    return out

total = bad = 0
planted = "--plant" not in sys.argv
for f in FILES:
    base = subprocess.run(["git", "show", f"{BASE}:{f}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
    cur = (ROOT / f).read_text()
    for st in statements(base):
        total += 1
        if not planted:
            k = cur.find(st)
            if k >= 0:
                m = k + len(st) // 2
                cur = cur[:m] + ("x" if cur[m] != "x" else "y") + cur[m + 1:]
            planted = True
        ok = st in cur
        bad += not ok
        print(("same    " if ok else "CHANGED ") + "| " + st.splitlines()[0][:110] + " | " + f.rsplit("/", 1)[1])
    for word in (r"^axiom\b", r"native_decide"):
        if re.search(word, cur, re.M):
            bad += 1
            print("FORBIDDEN | " + word + " | " + f)
if total == 0:
    print("NO DECLARATION FOUND")
    sys.exit(2)
print(f"statements: {total}  same: {total - bad if bad <= total else 0}  failures: {bad}")
sys.exit(1 if bad else 0)
