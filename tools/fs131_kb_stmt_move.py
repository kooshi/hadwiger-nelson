#!/usr/bin/env python3
"""FS131-KB2: check that `bend_toward_collar` moved verbatim from I5o's scratch file into the library (Done-means 2).

Extracts, from the scratch file at a git ref and from `Plane/ValidMap/BendCollar` in the working tree, the block from the docstring's
`/--` above `theorem bend_toward_collar` to the end of its statement (the `:= by` that closes it), and compares the two byte for byte.
Also checks the context the statement elaborates in: the new module declares `namespace HadwigerNelson.Plane`, `namespace ArcMap` and
`variable {k : ℕ} {F : ArcMap k}` before the theorem, as the scratch file does; and exactly one file under `Proofs/` declares it.

Usage: fs131_kb_stmt_move.py [--ref 4a0e5c28] [--self-test]
Exit 0 only when every check passes; a failure prints FAIL lines and exits 1. `--self-test` plants a changed hypothesis, a changed
docstring letter, a dropped `variable` line and a second declaration, and expects each to FAIL, and the unplanted run to PASS.
"""
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
OLD = "data/fs131/i5o/BendCollar.lean"
NEW = "Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean"
NAME = "bend_toward_collar"
CONTEXT = ["namespace HadwigerNelson.Plane", "namespace ArcMap", "variable {k : ℕ} {F : ArcMap k}"]


def extract(text: str) -> str:
    m = re.search(rf"^theorem {NAME}[ \n]", text, re.M)
    if not m or len(re.findall(rf"^theorem {NAME}[ \n]", text, re.M)) != 1:
        raise ValueError(f"expected one `theorem {NAME}`")
    s = text.rfind("/--", 0, m.start())
    if s < 0:
        raise ValueError("no docstring above the declaration")
    t = text.find(":= by", m.start())
    if t < 0:
        raise ValueError("no `:= by` after the statement")
    return text[s:t + len(":= by")]


def context_ok(text: str) -> list:
    m = re.search(rf"^theorem {NAME}[ \n]", text, re.M)
    head = text[:m.start()] if m else ""
    return [c for c in CONTEXT if not re.search(rf"^{re.escape(c)}$", head, re.M)]


def check(old_text: str, new_text: str, hits: list) -> list:
    fails = []
    try:
        a, b = extract(old_text), extract(new_text)
        if a != b:
            fails.append("FAIL statement or docstring differs from the scratch file")
    except ValueError as ex:
        fails.append(f"FAIL extraction: {ex}")
    for c in context_ok(new_text):
        fails.append(f"FAIL context line missing before the theorem: {c}")
    if len(hits) != 1:
        fails.append(f"FAIL expected one declaring file under Proofs/, found {len(hits)}: {hits}")
    return fails


def proofs_hits(extra: str | None = None) -> list:
    hits = []
    for p in (ROOT / "Proofs").rglob("*.lean"):
        if re.search(rf"^theorem {NAME}[ \n]", p.read_text(encoding="utf-8"), re.M):
            hits.append(str(p.relative_to(ROOT)))
    if extra:
        hits.append(extra)
    return hits


def main() -> int:
    ref = "4a0e5c28"
    if "--ref" in sys.argv:
        ref = sys.argv[sys.argv.index("--ref") + 1]
    old = subprocess.run(["git", "-C", str(ROOT), "show", f"{ref}:{OLD}"], check=True, capture_output=True, text=True).stdout
    new = (ROOT / NEW).read_text(encoding="utf-8")
    if "--self-test" in sys.argv:
        plants = {
            "hypothesis changed": (new.replace("(hε : 0 < ε)", "(hε : 0 ≤ ε)", 1), None),
            "docstring letter changed": (new.replace("The bent map", "The bent maps", 1), None),
            "variable line dropped": (new.replace("variable {k : ℕ} {F : ArcMap k}\n", "", 1), None),
            "second declaration": (new, "Proofs/Planted.lean"),
        }
        ok = True
        for label, (txt, extra) in plants.items():
            if txt == new and extra is None:
                print(f"PLANT NOT APPLIED: {label}")
                ok = False
                continue
            f = check(old, txt, proofs_hits(extra))
            print(f"{'FIRED' if f else 'MISSED'}: {label}" + (f" ({f[0]})" if f else ""))
            ok &= bool(f)
        base = check(old, new, proofs_hits())
        print(f"unplanted: {'PASS' if not base else 'FAIL'}")
        ok &= not base
        print("SELF-TEST " + ("PASS" if ok else "FAIL"))
        return 0 if ok else 1
    fails = check(old, new, proofs_hits())
    for f in fails:
        print(f)
    print(f"RESULT: {'PASS' if not fails else 'FAIL'} ({NAME}, {OLD}@{ref} -> {NEW})")
    return 0 if not fails else 1


if __name__ == "__main__":
    sys.exit(main())
