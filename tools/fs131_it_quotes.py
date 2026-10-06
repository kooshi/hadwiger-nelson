#!/usr/bin/env python3
"""FS131-IT1: check every quotation of a brief against its sources, line by line (standing rule 3).

Each `> ` line of the brief (blank-line separated blocks; `— source:` lines skipped) must occur verbatim in one of the
source files named on the command line. A planted control line (absent from every source) must report MISS, or the
check exits 2: a checker that cannot see an absent line has not been tested by passing.

Usage: fs131_it_quotes.py BRIEF SOURCE [SOURCE ...]
Exit: 0 every quotation line found and the control missed; 1 some line missing; 2 the control was found.
"""
import sys

CONTROL = "ABSENT-CONTROL-STRING-fs131-it1-xyzzy"


def main() -> int:
    brief, *sources = sys.argv[1:]
    texts = {s: open(s, encoding="utf-8").read() for s in sources}
    lines = [l[2:] for l in open(brief, encoding="utf-8").read().split("\n") if l.startswith("> ")]
    lines = [l for l in lines if not l.startswith("— source")]
    missing = 0
    for l in lines:
        where = [s for s, t in texts.items() if l in t]
        if where:
            print(f"OK    {where[0].split('/')[-1]:40s} {l[:90]}")
        else:
            missing += 1
            print(f"MISS  {'':40s} {l[:90]}")
    control_found = any(CONTROL in t for t in texts.values())
    print(f"control line {'FOUND (checker blind)' if control_found else 'MISS (as it must)'}")
    print(f"{len(lines)} quotation lines, {missing} missing")
    if control_found:
        return 2
    return 1 if missing else 0


if __name__ == "__main__":
    sys.exit(main())
