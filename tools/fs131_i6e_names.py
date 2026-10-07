#!/usr/bin/env python3
"""FS131-I6E: no declaration this job added to `FanBridge.lean` bears a name held elsewhere.

The build of 2026-10-06 (`data/fs131/i6e/logs/build-1-two-sides.log`) failed at `Proofs.lean` because a helper was
named `polarAngle`, a definition of `Plane/ValidMap/RadialPush`, which `FanBridge` does not import: the module compiled
and the import surface did not. This check asserts the absence before a build can meet it.

A *new name* is a declaration head (`theorem`, `def`, `noncomputable def`, `lemma`, `abbrev`, `structure`, `instance`)
of the current `FanBridge.lean` that the base commit's `FanBridge.lean` does not have. Each is compared, by its last
component and by its whole written name, with
  (a) every declaration head of every other `.lean` file under `Proofs/` in this tree, and
  (b) every declaration head of the `Plane/Saturated` files on the other implementer's branch at `OTHER` (read with
      `git show`; nothing is merged).
The comparison by last component is conservative: `Fan.foo` here and `Bar.foo` elsewhere is reported, and a report that
is a different full name is excused by listing it in ALLOW with its reason.
Prints the collisions and the counts; exit 1 on a collision, exit 2 if no new name was found.

Usage: python3 tools/fs131_i6e_names.py [--plant]
  --plant adds the name `polarAngle` (the collision the build met) to the new names: the check must report it, exit 1."""
import subprocess, sys, pathlib, re

ROOT = pathlib.Path(__file__).resolve().parent.parent
BASE, OTHER = "d62406a2", "8e81fedd"
MINE = "Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean"
HEAD = re.compile(r"^(?:private |protected )?(?:theorem|def|noncomputable def|lemma|abbrev|structure|instance) ([^\s:({\[]+)", re.M)
ALLOW = {"reverse": "IsUnitCurve.reverse here, IsArcOf.reverse on the other branch: two full names"}  # last component -> reason

def git(*a):
    return subprocess.run(["git", *a], cwd=ROOT, capture_output=True, text=True, check=True).stdout

def heads(text):
    return [n.replace("_root_.HadwigerNelson.Plane.", "") for n in HEAD.findall(text)]

base = set(heads(git("show", f"{BASE}:{MINE}")))
new = [n for n in heads((ROOT / MINE).read_text()) if n not in base]
if "--plant" in sys.argv:
    new.append("polarAngle")
if not new:
    print("NO NEW NAME FOUND")
    sys.exit(2)
elsewhere = {}
for f in (ROOT / "Proofs").rglob("*.lean"):
    rel = str(f.relative_to(ROOT))
    if rel == MINE:
        continue
    for n in heads(f.read_text()):
        elsewhere.setdefault(n.rsplit(".", 1)[-1], []).append((n, rel))
for f in git("ls-tree", "-r", "--name-only", OTHER, "Proofs/HadwigerNelson/Plane/Saturated/").split():
    for n in heads(git("show", f"{OTHER}:{f}")):
        if not (f == MINE and n in base):
            elsewhere.setdefault(n.rsplit(".", 1)[-1], []).append((n, f"{OTHER}:{f}"))
bad = 0
for n in new:
    last = n.rsplit(".", 1)[-1]
    hits = sorted(set(elsewhere.get(last, [])))
    if hits and last in ALLOW and all(a != n for a, _ in hits):
        print("allowed   | " + n + " | " + ALLOW[last])
    elif hits:
        bad += 1
        print("COLLISION | " + n + " | " + "; ".join(f"{a} in {b}" for a, b in hits[:4]))
dup = sorted({n for n in new if new.count(n) > 1})
for n in dup:
    bad += 1
    print("DECLARED TWICE HERE | " + n)
print(f"new names: {len(new)}  collisions: {bad}  (tree: Proofs/ less FanBridge; other branch: {OTHER})")
sys.exit(1 if bad else 0)
