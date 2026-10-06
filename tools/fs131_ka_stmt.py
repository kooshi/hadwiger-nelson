#!/usr/bin/env python3
"""FS131-KA1: no statement of a landed declaration changed between the base commit and the working tree.

  python3 tools/fs131_ka_stmt.py [--base 78eba0b4]            # exit 0 iff the checks hold
  python3 tools/fs131_ka_stmt.py --self-test                  # plants faults in memory; each must fire

Checks, for every `.lean` file under `Proofs/` (and `Proofs.lean`) that exists at the base:
1. a file other than `BendStep.lean` and `Proofs.lean` is byte-identical to the base;
2. `Proofs.lean` differs from the base only by added `import` lines;
3. in `BendStep.lean`, every declaration of the base is declared exactly once with an identical statement — for a theorem the header
   up to its first `:=` (no theorem of the file has a `:=` inside a binder), for a `def`/`structure`/`inductive` the whole declaration —
   except the names in ALLOW (`bend_away_part`: its horn clause and its last clause weakened under inventory rulings 438 (b) and 444);
4. no `axiom` declaration and no `native_decide` in any file under `Proofs/` that is new or changed.
New declarations and new files are listed, not judged. Docstrings are not statements here; changed ones are listed.
"""
import re
import subprocess
import sys
from pathlib import Path

ALLOW = {"bend_away_part"}
EDITABLE = {"Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean"}
DECL = re.compile(r"^(?:private |protected |noncomputable )*(theorem|lemma|def|structure|inductive|abbrev|instance)\s+([^\s:({\[]+)", re.M)
STOP = re.compile(r"^(?:/--|/-!|end |namespace |section|variable |open |example|#|(?:private |protected |noncomputable )*(?:theorem|lemma|def|structure|inductive|abbrev|instance)\s)", re.M)


def git(*a):
    return subprocess.run(["git", *a], check=True, capture_output=True, text=True).stdout


def decls(text):
    out = {}
    for m in DECL.finditer(text):
        kind, name = m.group(1), m.group(2)
        nxt = STOP.search(text, m.end())
        block = text[m.start(): nxt.start() if nxt else len(text)]
        if kind in ("theorem", "lemma"):
            block = block.split(":=", 1)[0]
        out.setdefault(name, []).append(re.sub(r"\s+", " ", block).strip())
    return out


def check(base, tree_text=None, extra=None):
    """tree_text: {path: text} overrides of the working tree (for plants); extra: {path: text} new files."""
    tree_text = tree_text or {}
    bad = []
    base_files = [f for f in git("ls-tree", "-r", "--name-only", base, "--", "Proofs", "Proofs.lean").split("\n") if f.endswith(".lean")]
    for f in base_files:
        old = git("show", f"{base}:{f}")
        p = Path(f)
        new = tree_text.get(f, p.read_text() if p.exists() else None)
        if new is None:
            bad.append(f"DELETED {f}"); continue
        if new == old:
            continue
        if f == "Proofs.lean":
            o, n = old.split("\n"), new.split("\n")
            added = [l for l in n if l not in o]
            gone = [l for l in o if l not in n]
            if gone or any(not l.startswith("import ") for l in added):
                bad.append(f"Proofs.lean changed beyond added imports: -{gone} +{[l for l in added if not l.startswith('import ')]}")
            continue
        if f not in EDITABLE:
            bad.append(f"CHANGED (not editable) {f}"); continue
        do, dn = decls(old), decls(new)
        for name, stmts in do.items():
            if name not in dn:
                bad.append(f"MISSING {f}: {name}")
            elif len(dn[name]) != len(stmts):
                bad.append(f"COUNT {f}: {name} declared {len(dn[name])} time(s), base {len(stmts)}")
            elif dn[name] != stmts and name not in ALLOW:
                bad.append(f"STATEMENT {f}: {name}")
            elif dn[name] != stmts:
                print(f"allowed statement change: {f}: {name}")
        for name in dn:
            if name not in do:
                print(f"new declaration: {f}: {name}")
    tracked = set(base_files)
    news = [str(p) for p in list(Path("Proofs").rglob("*.lean")) if str(p) not in tracked]
    for f in sorted(news):
        print(f"new file: {f}")
    scan = {f: Path(f).read_text() for f in news}
    scan.update({f: tree_text.get(f, Path(f).read_text()) for f in EDITABLE})
    scan.update(extra or {})
    for f, t in scan.items():
        if re.search(r"^\s*(?:private |protected )?axiom\s", t, re.M):
            bad.append(f"AXIOM in {f}")
        if "native_decide" in re.sub(r"/-.*?-/", "", t, flags=re.S):
            bad.append(f"native_decide in {f}")
    for b in bad:
        print("FAIL", b)
    print(f"{len(base_files)} base files, {len(news)} new files, {len(bad)} failures")
    return 1 if bad else 0


def main():
    base = "78eba0b4"
    if "--base" in sys.argv:
        base = sys.argv[sys.argv.index("--base") + 1]
    if "--self-test" in sys.argv:
        f = "Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean"
        t = Path(f).read_text()
        g = "Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean"
        plants = {
            "a changed hypothesis of a proved theorem (isR2Arc_of_fixed)": ({f: t.replace("(hK : K ⊆ F.dom)", "(hK : K ⊆ F.dom ∪ ∅)", 1)}, None),
            "a deleted theorem (r2_notMem_region renamed)": ({f: t.replace("theorem r2_notMem_region", "theorem r2_notMem_region'", 1)}, None),
            "an edit to a file that is not editable (BendCollar)": ({g: Path(g).read_text() + "\n-- planted\n"}, None),
            "an axiom in a new file": (None, {"Proofs/Planted.lean": "axiom planted : False\n"}),
            "native_decide in a new file": (None, {"Proofs/Planted.lean": "example : 1 = 1 := by native_decide\n"}),
        }
        ok = True
        for label, (tt, ex) in plants.items():
            rc = check(base, tt, ex)
            print(f"PLANT [{label}]: {'FIRED' if rc else 'DID NOT FIRE'}")
            ok = ok and rc != 0
        assert t.replace("(hK : K ⊆ F.dom)", "X", 1) != t, "the plant's anchor is gone"
        rc0 = check(base)
        print(f"UNPLANTED: {'PASS' if rc0 == 0 else 'FAIL'}")
        sys.exit(0 if ok and rc0 == 0 else 1)
    sys.exit(check(base))


if __name__ == "__main__":
    main()
