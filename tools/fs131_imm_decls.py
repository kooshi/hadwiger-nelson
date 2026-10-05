#!/usr/bin/env python3
"""FS131-IMM2: list the theorems of `Plane/ValidMap/MergeMove` by full name, and check the audit covers them.

  tools/fs131_imm_decls.py --list          print every theorem's full name (namespaces resolved)
  tools/fs131_imm_decls.py --check         exit 1 unless every theorem has a `#print axioms` line in
                                           scripts/Axioms.lean and in data/fs131/imm/AxiomsIMM.lean
  tools/fs131_imm_decls.py --self-test     plant a missing record and a misnamed namespace; both must fire

A namespace is resolved from the `namespace X.Y` / `section` / `end` stack; `_root_.`-prefixed names are taken as written.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MODULE = ROOT / "Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean"
AUDITS = [ROOT / "scripts/Axioms.lean", ROOT / "data/fs131/imm/AxiomsIMM.lean"]

DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+)?theorem\s+(\S+)")


def theorems(text: str) -> list[str]:
    stack: list[tuple[str, str]] = []
    out: list[str] = []
    for line in text.splitlines():
        m = re.match(r"^namespace\s+(\S+)", line)
        if m:
            stack.append(("ns", m.group(1)))
            continue
        m = re.match(r"^section\b\s*(\S*)", line)
        if m:
            stack.append(("sec", m.group(1)))
            continue
        m = re.match(r"^end\b\s*(\S*)", line)
        if m:
            if not stack:
                raise SystemExit(f"unbalanced `end` in {MODULE}: {line!r}")
            kind, name = stack.pop()
            if m.group(1) and m.group(1) != name:
                raise SystemExit(f"`end {m.group(1)}` closes `{kind} {name}` in {MODULE}")
            continue
        m = DECL.match(line)
        if m:
            name = m.group(1)
            if name.startswith("_root_."):
                out.append(name[len("_root_."):])
            else:
                prefix = ".".join(n for k, n in stack if k == "ns")
                out.append(f"{prefix}.{name}" if prefix else name)
    if stack:
        raise SystemExit(f"unclosed {stack} at the end of {MODULE}")
    return out


def audited(path: Path) -> set[str]:
    return set(re.findall(r"^#print axioms\s+(\S+)", path.read_text(), re.M))


def check(names: list[str], audits: list[tuple[Path, set[str]]]) -> list[str]:
    errs = []
    for path, recs in audits:
        for n in names:
            if n not in recs:
                errs.append(f"{path.relative_to(ROOT)}: no `#print axioms {n}`")
    return errs


def main() -> int:
    arg = sys.argv[1] if len(sys.argv) > 1 else "--check"
    names = theorems(MODULE.read_text())
    if arg == "--list":
        print("\n".join(names))
        return 0
    if arg == "--check":
        errs = check(names, [(p, audited(p)) for p in AUDITS])
        if errs:
            print("\n".join(errs))
            print(f"FAIL: {len(errs)} theorem(s) of MergeMove not audited")
            return 1
        print(f"PASS: all {len(names)} theorems of MergeMove audited in {len(AUDITS)} files")
        return 0
    if arg == "--self-test":
        ok = True
        recs = [(p, audited(p)) for p in AUDITS]
        # control 1: drop one record from the first audit
        victim = names[len(names) // 2]
        planted = [(recs[0][0], recs[0][1] - {victim})] + recs[1:]
        errs = check(names, planted)
        if not any(victim in e for e in errs):
            print(f"SELF-TEST FAIL: dropping {victim} was not reported")
            ok = False
        else:
            print(f"control 1 fired: {errs[0]}")
        # control 2: a theorem inside a namespace must carry it
        text = "namespace A.B\ntheorem foo : True := trivial\nend A.B\n"
        if theorems(text) != ["A.B.foo"]:
            print(f"SELF-TEST FAIL: namespace resolution gave {theorems(text)}")
            ok = False
        else:
            print("control 2 fired: namespace A.B resolves foo to A.B.foo")
        # control 3: a mismatched `end` must abort
        try:
            theorems("namespace A\nsection S\nend A\n")
            print("SELF-TEST FAIL: mismatched end not caught")
            ok = False
        except SystemExit as e:
            print(f"control 3 fired: {e}")
        print("SELF-TEST " + ("PASS" if ok else "FAIL"))
        return 0 if ok else 1
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main())
