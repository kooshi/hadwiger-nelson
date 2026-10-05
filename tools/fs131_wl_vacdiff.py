#!/usr/bin/env python3
"""FS131-WL1: the merged tree's vacuity scan against `main`'s, row for row, with the new rows read as Woodall's.

Every SITE and EVIDENCE row of `main`'s scan must be in the merged scan (a merge adds the branch, it removes nothing of `main`'s),
and every row the merged scan adds must belong to a declaration of the five Woodall modules (tools/fs131_w3_decls.py's names(),
FS131-W3's, read-only here, plus the modules' definitions read from their `def` lines). Prints the added rows' verdict tally.

Usage: fs131_wl_vacdiff.py <main log> <merged log>
       fs131_wl_vacdiff.py --plant <main log> <merged log>   drops one main row from the merged view and adds a non-Woodall row; must exit 1
Exit 0 when both hold; 1 otherwise (each discrepancy printed).
"""
import collections, pathlib, re, sys
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import fs131_w3_decls as W

ROOT = pathlib.Path(__file__).resolve().parents[1]


def read(path):
    rows = collections.Counter()
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("SITE ") or ln.startswith("EVIDENCE "):
            rows[ln] += 1
    return rows


def woodall_names():
    names = set(W.names())
    for m in W.MODS:
        ns = []
        for line in (ROOT / m).read_text().split("\n"):
            mo = re.match(r"namespace (\S+)", line)
            if mo:
                ns.append(mo.group(1)); continue
            mo = re.match(r"end (\S+)", line)
            if mo and ns and ns[-1] == mo.group(1):
                ns.pop(); continue
            mo = re.match(r"(?:noncomputable )?def (\S+)", line)
            if mo:
                names.add(".".join(ns + [mo.group(1)]))
    return names


def decl_of(row):
    parts = row.split(" ")
    return parts[2]  # SITE <VERDICT> <decl> :: … ; EVIDENCE <EMPTY|WITNESS> <decl> :: …


def main():
    args = sys.argv[1:]
    plant = "--plant" in args
    if plant:
        args.remove("--plant")
    a, b = read(args[0]), read(args[1])
    if plant:
        victim = next(iter(sorted(a)))
        b = b.copy(); b[victim] = 0; b += collections.Counter()
        b["SITE GENERIC HadwigerNelson.planted_not_woodall :: X"] += 1
        print(f"planted: dropped {victim[:80]}…; added a non-Woodall row")
    wn, bad = woodall_names(), 0
    lost = a - b
    for r in sorted(lost):
        print("LOST", r[:200]); bad += 1
    added = b - a
    tally = collections.Counter()
    for r in sorted(added):
        d = decl_of(r)
        if d not in wn:
            print("ADDED-NOT-WOODALL", r[:200]); bad += 1
        tally[" ".join(r.split(" ")[:2])] += added[r]
    print(f"main rows {sum(a.values())}, merged rows {sum(b.values())}, lost {sum(lost.values())}, added {sum(added.values())}")
    for k, n in sorted(tally.items()):
        print(f"  added {k}: {n}")
    print("FAIL" if bad else "PASS")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
