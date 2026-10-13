#!/usr/bin/env python3
"""FS131-KN3 stage 1: the brief's quoted statements against the claim list, and the claim
list's leaves against the kernel map.

Two comparisons, each exact (character for character after the stated joining):

  (a) every line `> NF2-…: …` of the brief equals the line of that id in
      data/fs131/claims-NF2.md;
  (b) every NF2-LEAF-nn of the claim list equals item nn of the map's section
      "The chain's leaves, in dependency order", its paragraph joined into one line
      (leading whitespace of continuation lines collapsed to one space).

`--plant` changes one character of one claim and one of one map item in memory and
requires both comparisons to report it (the negative control).
Exit 0: every line identical. Exit 1: a mismatch, each printed.
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
BRIEF = ROOT / "data/fs131/briefs/FS131-KN3-chain-plan.md"
CLAIMS = ROOT / "data/fs131/claims-NF2.md"
MAP = ROOT / "plans/FS131-KN1-number-field-kernel-map.md"


def claims(text):
    out = {}
    for line in text.splitlines():
        m = re.match(r"^(NF2-[A-Z0-9-]+): (.*)$", line)
        if m:
            out[m.group(1)] = m.group(2)
    return out


def brief_quotes(text):
    out = []
    for line in text.splitlines():
        m = re.match(r"^> (NF2-[A-Z0-9-]+): (.*)$", line)
        if m:
            out.append((m.group(1), m.group(2)))
    return out


def map_leaves(text):
    lines = text.splitlines()
    start = next(i for i, l in enumerate(lines) if l.startswith("**The chain's leaves, in dependency order.**"))
    end = next(i for i, l in enumerate(lines) if i > start and l.startswith("**None of leaves 8"))
    items, cur, num = {}, None, None
    for l in lines[start + 1:end]:
        m = re.match(r"^(\d+)\. (.*)$", l)
        if m:
            if num is not None:
                items[num] = cur
            num, cur = int(m.group(1)), m.group(2)
        elif num is not None:
            if l.strip() == "" or l.startswith("*C") or l.strip().startswith("Then "):
                items[num] = cur
                num, cur = None, None
            else:
                cur = cur + " " + l.strip()
    if num is not None:
        items[num] = cur
    return items


def main():
    plant = "--plant" in sys.argv
    cl = claims(CLAIMS.read_text())
    bq = brief_quotes(BRIEF.read_text())
    ml = map_leaves(MAP.read_text())
    if plant:
        k = "NF2-MRPLUS"
        cl[k] = cl[k].replace("measure 0", "measure 1", 1)
        ml[13] = ml[13].replace("invariant probability", "invariant finite", 1)
    bad = 0
    print(f"(a) brief quotations: {len(bq)}")
    for k, v in bq:
        if k not in cl:
            print(f"  MISSING in claim list: {k}"); bad += 1
        elif cl[k] != v:
            print(f"  DIFFERS: {k}\n    brief : {v}\n    claims: {cl[k]}"); bad += 1
    leaves = sorted(k for k in cl if k.startswith("NF2-LEAF-"))
    print(f"(b) claim-list leaves: {len(leaves)}; map items: {len(ml)}")
    for k in leaves:
        n = int(k.rsplit("-", 1)[1])
        if n not in ml:
            print(f"  MISSING in map: item {n}"); bad += 1
        elif ml[n] != cl[k]:
            print(f"  DIFFERS: {k}\n    claims: {cl[k]}\n    map   : {ml[n]}"); bad += 1
    for n in sorted(ml):
        if f"NF2-LEAF-{n:02d}" not in cl:
            print(f"  map item {n} has no claim"); bad += 1
    if plant:
        print(f"PLANT: {bad} mismatches reported (expected at least 2)")
        sys.exit(0 if bad >= 2 else 1)
    print("identical" if bad == 0 else f"{bad} mismatches")
    sys.exit(0 if bad == 0 else 1)


if __name__ == "__main__":
    main()
