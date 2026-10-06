#!/usr/bin/env python3
"""FS131-IL2: summarise a `#print axioms` output — each record on the standard three or fewer, through `sorryAx`, or other.

A record is a line `'<name>' depends on axioms: [a, b, ...]` (possibly wrapped over several lines), or `'<name>' does not depend on
any axioms`. The script also counts the `#print axioms` commands in the source file and fails if the two counts differ (a record the
print never produced is a silent gap), and exits non-zero if any record is OTHER.

  python3 tools/fs131_il_axsum.py <out> <source.lean>              # summary on stdout
  python3 tools/fs131_il_axsum.py <out> <source.lean> --self-test  # plants sorryAx in the first standard record; must change the counts
"""
import re
import sys

STD = {"propext", "Classical.choice", "Quot.sound"}


def records(text: str):
    flat = re.sub(r"\n\s+", " ", text)
    out = []
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", flat):
        axs = {a.strip() for a in m.group(2).split(",") if a.strip()}
        out.append((m.group(1), axs))
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", flat):
        out.append((m.group(1), set()))
    return out


def summarise(text: str, nsrc: int):
    recs = records(text)
    std = [n for n, a in recs if a <= STD]
    sor = [n for n, a in recs if "sorryAx" in a]
    oth = [(n, sorted(a)) for n, a in recs if not a <= STD and "sorryAx" not in a]
    lines = [f"records {len(recs)} (print commands in source {nsrc}): standard-three-or-fewer {len(std)}, "
             f"through sorryAx {len(sor)}, other {len(oth)}", "THROUGH sorryAx:"]
    lines += [f"  {n}" for n in sor]
    lines.append("OTHER:")
    lines += [f"  {n} {a}" for n, a in oth]
    ok = len(recs) == nsrc and not oth
    if len(recs) != nsrc:
        lines.append(f"MISMATCH: {nsrc} print commands but {len(recs)} records")
    return "\n".join(lines), ok, (len(std), len(sor))


def main():
    out = open(sys.argv[1]).read()
    nsrc = sum(1 for l in open(sys.argv[2]) if l.startswith("#print axioms"))
    text, ok, counts = summarise(out, nsrc)
    if "--self-test" in sys.argv:
        m = re.search(r"depends on axioms: \[propext", out)
        if not m:
            print("SELF-TEST: no standard record to plant into (bad)"); sys.exit(1)
        planted = out[:m.end()] + ", sorryAx" + out[m.end():]
        _, _, counts2 = summarise(planted, nsrc)
        fired = counts2 == (counts[0] - 1, counts[1] + 1)
        print(f"SELF-TEST: counts {counts} -> {counts2}:", "FIRED (good)" if fired else "DID NOT FIRE (bad)")
        sys.exit(0 if fired else 1)
    print(text)
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
