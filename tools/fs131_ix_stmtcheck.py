#!/usr/bin/env python3
"""FS131-IX1: every statement of a Lean file at a base commit is byte-identical in the working copy.

For each top-level `theorem`/`lemma`/`def`/`abbrev`/`structure`/`inductive`/`class` header in `git show <base>:<file>` (from the keyword to the
first `:=`, ` where` or ` :=` at the end of the header), the same header must occur verbatim in the working copy. Prints one line per
statement and a summary. Exit 0 when all match; 2 when any differs or is missing; 3 on a malformed input. `--new` overrides the working-copy
path (the negative control runs on a planted copy).
"""
import argparse
import re
import subprocess
import sys

HDR = re.compile(r"^(?:(?:private|protected|noncomputable|@\[[^\]]*\]) )*(theorem|lemma|def|abbrev|structure|inductive|class) (\S+)", re.M)


def headers(text):
    out = {}
    for m in HDR.finditer(text):
        k = text.find(":=", m.start())
        w = text.find(" where", m.start())
        ends = [x for x in (k, w) if x >= 0]
        if not ends:
            continue
        out[m.group(2)] = text[m.start():min(ends)]
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base", default="01011037")
    ap.add_argument("--file", default="Proofs/HadwigerNelson/Plane/PlaneTopology.lean")
    ap.add_argument("--new", default=None)
    a = ap.parse_args()
    try:
        old = subprocess.run(["git", "show", f"{a.base}:{a.file}"], check=True, capture_output=True, text=True).stdout
    except subprocess.CalledProcessError as exc:
        print(f"MALFORMED: cannot read {a.base}:{a.file}: {exc.stderr.strip()}")
        return 3
    new = open(a.new or a.file).read()
    ho, hn = headers(old), headers(new)
    if not ho:
        print("MALFORMED: no statements found at the base")
        return 3
    bad = 0
    for name, h in ho.items():
        if hn.get(name) == h:
            print(f"SAME     {name}")
        else:
            bad += 1
            print(f"CHANGED  {name}" if name in hn else f"MISSING  {name}")
    added = sorted(set(hn) - set(ho))
    print(f"summary: {len(ho)} base statements, {len(ho) - bad} identical, {bad} changed or missing; {len(added)} added: {', '.join(added)}")
    return 2 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
