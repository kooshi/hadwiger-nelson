#!/usr/bin/env python3
"""FS131-I6E: no statement or definition changed since the base commit, and no file that is not mine was touched.

(1) `FanBridge.lean`: every declaration of the base version (a line at column 0 starting with `theorem`, `structure`,
    `def`, `abbrev`, `noncomputable def` or `instance`) is cut out as its *statement* — for a structure, the block up
    to the next blank line; otherwise the lines up to and including the first one that holds `:=` — and must occur
    verbatim in the current file. Docstrings are not part of a statement: the check allows a docstring line to change
    (the brief asks for one: `Fan.branch_contacts`' alternative is inclusive) and nothing between `theorem` and `:=`.
(2) The seven leaves that are another implementer's still end in `sorry` exactly as at the base (their statement
    followed by a line `  sorry`).
(3) The files that are not mine (`Basic`, `Pinch`, `MapColouring`, `Fan`, `FanExamples`, `Curve`, `LocalGraph`) are
    byte-identical to the base.
(4) The current `FanBridge.lean`, and every new module named on the command line after `--new`, hold no `axiom`
    declaration and no `native_decide`.
Prints one line per item and the counts; exit 1 on any failure, exit 2 if no declaration was found (a check that found
nothing to check has not passed).

Usage: python3 tools/fs131_i6e_statements.py [--plant] [--new <file> ...]
  --plant alters one character of the current text inside the first statement: the check must report it and exit 1."""
import subprocess, sys, pathlib, re

ROOT = pathlib.Path(__file__).resolve().parent.parent
BASE = "d62406a2"
SAT = "Proofs/HadwigerNelson/Plane/Saturated/"
MINE = SAT + "FanBridge.lean"
FROZEN = [SAT + f + ".lean" for f in ("Basic", "Pinch", "MapColouring", "Fan", "FanExamples", "Curve", "LocalGraph")]
OTHERS = ["gamma", "IsUnitCurve.exists_polarGraph", "beta", "alpha", "fan_of_isolated", "regJLiteral_of_saturated",
          "finite_arcs_of_isBounded"]
HEAD = re.compile(r"^(theorem|structure|def|abbrev|noncomputable def|instance)\b")

def show(f):
    return subprocess.run(["git", "show", f"{BASE}:{f}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout

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

args = sys.argv[1:]
new = args[args.index("--new") + 1:] if "--new" in args else []
total = bad = 0
planted = "--plant" not in args
cur = (ROOT / MINE).read_text()
for st in statements(show(MINE)):
    total += 1
    if not planted:
        k = cur.find(st)
        if k >= 0:
            m = k + len(st) // 2
            cur = cur[:m] + ("x" if cur[m] != "x" else "y") + cur[m + 1:]
        planted = True
    ok = st in cur
    bad += not ok
    print(("same    " if ok else "CHANGED ") + "| " + st.splitlines()[0][:110])
    name = st.split()[1]
    if name in OTHERS:
        ok2 = (st + "\n  sorry\n") in cur
        bad += not ok2
        print(("  still sorry, not mine" if ok2 else "  NOT-MINE LEAF TOUCHED") + " | " + name)
for f in FROZEN:
    same = show(f) == (ROOT / f).read_text()
    bad += not same
    print(("identical " if same else "TOUCHED   ") + "| " + f)
for f in [MINE] + new:
    text = cur if f == MINE else (ROOT / f).read_text()
    for word in (r"^axiom\b", r"native_decide"):
        if re.search(word, text, re.M):
            bad += 1
            print("FORBIDDEN | " + word + " | " + f)
if total == 0:
    print("NO DECLARATION FOUND")
    sys.exit(2)
print(f"statements: {total}  failures: {bad}  base: {BASE}")
sys.exit(1 if bad else 0)
