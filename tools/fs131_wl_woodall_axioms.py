#!/usr/bin/env python3
"""FS131-WL1: every record of Woodall's chain, read from a saved axiom-audit log, against the standard three.

Reads the record names from the Woodall sections of scripts/Axioms.lean (through tools/fs131_w3_decls.py's records(), FS131-W3's,
read-only here) and each record's axiom list from the log `scripts/axioms.sh` saved (`build/gate/axioms/<run>.log`), rejoining
wrapped lists. Prints the count per axiom set; exit 1 if any record is absent from the log or carries an axiom outside
{propext, Classical.choice, Quot.sound}.

Usage: fs131_wl_woodall_axioms.py <log>
       fs131_wl_woodall_axioms.py --plant <log>   rewrites one record's list to add sorryAx and drops another, in memory; must exit 1
"""
import collections, pathlib, re, sys
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import fs131_w3_decls as W

STD = {"propext", "Classical.choice", "Quot.sound"}


def axioms_of(log):
    text = pathlib.Path(log).read_text()
    out = {}
    for m in re.finditer(r"^'([^']+)' depends on axioms: \[(.*?)\]", text, re.S | re.M):
        out[m.group(1)] = frozenset(a.strip() for a in m.group(2).replace("\n", " ").split(",") if a.strip())
    for m in re.finditer(r"^'([^']+)' does not depend on any axioms", text, re.M):
        out[m.group(1)] = frozenset()
    return out


def main():
    args = sys.argv[1:]
    plant = "--plant" in args
    if plant:
        args.remove("--plant")
    ax, recs = axioms_of(args[0]), W.records()
    if plant:
        ax = dict(ax)
        ax[recs[0]] = ax[recs[0]] | {"sorryAx"}
        ax.pop(recs[1], None)
        print(f"planted: sorryAx on {recs[0]}; {recs[1]} dropped")
    bad, sets = 0, collections.Counter()
    for r in recs:
        if r not in ax:
            print("ABSENT", r); bad += 1; continue
        sets[tuple(sorted(ax[r]))] += 1
        if not ax[r] <= STD:
            print("OUTSIDE", r, sorted(ax[r] - STD)); bad += 1
    for s, n in sets.most_common():
        print(f"{n:5d}  [{', '.join(s)}]")
    print(f"{len(recs)} Woodall records; {bad} failures")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
