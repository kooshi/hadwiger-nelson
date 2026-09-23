"""FS-73 P3b — planted faults in the L21cc6506 certificates themselves; every checker must refuse each, by its own name.

Each plant writes a modified copy to a scratch file and runs a checker on it. The faithful copy must pass (so a refusal is
seen to come from the fault, not the scaffolding), and every plant must fail with the named message.

Usage: python3 tools/fs73_theta_plant.py struct STRUCT.json SCRATCH_DIR
       python3 tools/fs73_theta_plant.py tree TREE.json SCRATCH_DIR     (runs both tree checkers)
"""
import copy
import json
import os
import subprocess
import sys
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)


def run(checker, obj, scratch, kind=None):
    path = os.path.join(scratch, "plant.json")
    json.dump(obj, open(path, "w"))
    cmd = ["python3", checker] + ([kind] if kind else []) + [path]
    r = subprocess.run(cmd, capture_output=True, text=True)
    lines = (r.stdout + r.stderr).strip().splitlines()
    return r.returncode, (lines[-1] if lines else "")[:160]


def expect(name, res, want_ok, needle):
    code, msg = res
    needles = needle if isinstance(needle, tuple) else (needle,)
    good = (code == 0) if want_ok else (code != 0 and any(n in msg for n in needles))
    print(f"{'PASS' if good else 'FAIL'}  {name}: exit {code}: {msg}")
    return good


def struct(path, scratch):
    chk = os.path.join(HERE, "fs73_theta_struct_check.py")
    C = json.load(open(path))
    ok = [expect("faithful copy", run(chk, copy.deepcopy(C), scratch), True, "")]
    X = copy.deepcopy(C); del X["B5"]["zbar"]; X["conditions"] = ["vbar", "z"]
    ok.append(expect("rotation zbar dropped", run(chk, X, scratch), False, "R1"))
    X = copy.deepcopy(C); X["B5"]["z"] = [336, 0, 252, 0]
    ok.append(expect("rotation z replaced by a rational unit", run(chk, X, scratch), False, "R1"))
    X = copy.deepcopy(C); e = X["farkas_certificates"][0]; e["farkas"][0][-1] = str(Fr(e["farkas"][0][-1]) * 2)
    ok.append(expect("one Farkas multiplier doubled", run(chk, X, scratch), False, "Farkas vector fails"))
    X = copy.deepcopy(C); X["farkas_certificates"] = X["farkas_certificates"][1:]
    ok.append(expect("one Farkas certificate removed", run(chk, X, scratch), False, "no certificate"))
    X = copy.deepcopy(C); X["basis"][0] = [4, 0, 0, 0]
    ok.append(expect("basis vector doubled", run(chk, X, scratch), False, "R2"))
    X = copy.deepcopy(C); X["d"] = 59
    ok.append(expect("wrong field", run(chk, X, scratch), False, "AssertionError"))
    return all(ok)


def first_path(C):
    """The nodes the checkers' depth-first walk visits first (they pop the largest child first), root to first end."""
    node = {tuple(tuple(x) for x in n["p"]): i for i, n in enumerate(C["nodes"])}
    p, out = (), []
    while p in node:
        i = node[p]; out.append(i); n = C["nodes"][i]
        if not n.get("ch"):
            break
        p = p + ((len(p), max(n["ch"])),)
    return out


def tree(path, scratch, faithful=False):
    """Plants placed on the first path the walk visits, so each refusal comes early (the file is 220 MB)."""
    chks = [(os.path.join(HERE, "fs73_theta_check.py"), "cert"),
            (os.path.join(ROOT, "data", "fs73", "coxeter-c3", "certcheck.py"), None)]
    C = json.load(open(path))
    fp = first_path(C)
    ok = []
    for chk, kind in chks:
        name = os.path.basename(chk)
        if faithful:
            ok.append(expect(f"[{name}] faithful copy", run(chk, C, scratch, kind), True, ""))
        X = dict(C); X["S"] = C["S"][:6] + C["S"][7:]           # a rational unit vector dropped from S
        ok.append(expect(f"[{name}] rational unit dropped from S", run(chk, X, scratch, kind), False,
                         ("not the full unit set", "missing from S")))
        X = dict(C); nodes = list(C["nodes"])
        i = next(i for i in fp if "yl" in nodes[i] and any(v != "0" for v in nodes[i]["yl"]) and nodes[i]["ch"])
        n2 = dict(nodes[i]); n2["yl"] = [str(Fr(v) * 3) for v in n2["yl"]]; nodes[i] = n2; X["nodes"] = nodes
        ok.append(expect(f"[{name}] one lower-bound multiplier vector tripled (node {i})", run(chk, X, scratch, kind),
                         False, "children"))
        X = dict(C); nodes = list(C["nodes"])
        i = next(i for i in fp if nodes[i].get("ch"))
        n2 = dict(nodes[i]); n2["ch"] = n2["ch"][:-1]; nodes[i] = n2; X["nodes"] = nodes
        ok.append(expect(f"[{name}] one child dropped (node {i})", run(chk, X, scratch, kind), False, "children"))
        X = dict(C); nodes = list(C["nodes"])
        i = fp[-1]
        assert nodes[i].get("ch") == []
        n2 = {"p": nodes[i]["p"], "farkas": ["0"] * (2 * len(nodes[i]["p"]))}; nodes[i] = n2; X["nodes"] = nodes
        ok.append(expect(f"[{name}] a zero Farkas vector on a feasible node (node {i})", run(chk, X, scratch, kind),
                         False, "Farkas"))
    return all(ok)


if __name__ == "__main__":
    mode, path, scratch = sys.argv[1:4]
    good = struct(path, scratch) if mode == "struct" else tree(path, scratch, faithful="--faithful" in sys.argv)
    print("ALL PLANTS BEHAVED" if good else "A PLANT MISBEHAVED")
    sys.exit(0 if good else 1)
