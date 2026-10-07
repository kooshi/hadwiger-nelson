#!/usr/bin/env python3
"""FS132-Z1: assemble plans/FS132-derivation.md from the six FS-132 derivers' records and this job's template.

The template (data/fs132/z1/template.md) is this job's prose and the entries it authored itself; a line
    @@ENTRY <rec> <name>        or        @@CONTROL <rec> <name>
is replaced by that block of plans/FS132-<rec>-derivation.md, verbatim, except that
  * a "§ ..." address in `argument:` or `converse:` is pointed into the source record (FS132-<rec>-derivation.md § ...);
  * the fields listed in OVERRIDES are replaced (each override is named in the prose under its entry).

  python3 data/fs132/z1/assemble.py            write plans/FS132-derivation.md, then check it
  python3 data/fs132/z1/assemble.py --check    check only: every derivation and control block of the six records is in the
                                               output exactly once, and every statement, verdict and grade in the output equals
                                               its source's, spacing aside; the only fields that differ are OVERRIDES' and the
                                               re-pointed addresses
  python3 data/fs132/z1/assemble.py --check --fault   the same check with one statement altered in memory: must FAIL
"""
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
PLANS = ROOT / "plans"
OUT = PLANS / "FS132-derivation.md"
TEMPLATE = HERE / "template.md"
RECS = ["E1", "E2", "E3", "E4", "E5", "E6"]
HEAD = re.compile(r"^(derivation|control): (\S+)\s*$")
FIELD = re.compile(r"^  ([a-z][a-z ]*?): ?(.*)$")
DIRECTIVE = re.compile(r"^@@(ENTRY|CONTROL) (E[1-6]) (\S+)\s*$")

# The record job's field changes. One: the exclusion's count of minds keeps its source's number and gains the account of
# who derived, reworked and read each step (the brief's item 2); the reason is in the prose under the entry.
OVERRIDES = {
    ("derivation", "C132-M-ORBIT"): {
        "minds": "1 — one derivation (FS132-E3). A second mind, the kernel lane's planner (FS132-K1), kept from the derivers' "
                 "records until its commit 1eb4b94b, reached blind the state, the chart, a forced label at each hub by another "
                 "route, the unit-pair relation on its diagonal and the kill for a clean change, and stopped at the step lemma "
                 "(M8); with the fence lifted it read M4 to M9 line by line and found no gap. FS132-E5 reworked M1 to M6 from "
                 "the argument and read M7 to M9. The number is 1 because M6 and M8 have one derivation and readings made with "
                 "the argument open, and the weakest step governs; the table under the entry says who did what",
    },
}


def blocks(rec):
    lines = (PLANS / f"FS132-{rec}-derivation.md").read_text().split("\n")
    out, i = {}, 0
    while i < len(lines):
        m = HEAD.match(lines[i])
        if not m:
            i += 1
            continue
        j = i + 1
        while j < len(lines) and lines[j].strip() != "":
            j += 1
        key = (m.group(1), m.group(2))
        assert key not in out, (rec, key)
        out[key] = lines[i:j]
        i = j
    return out


def fields(block):
    f, last = {}, None
    for ln in block[1:]:
        m = FIELD.match(ln)
        if m and not ln.startswith("    "):
            last = m.group(1)
            f[last] = m.group(2)
        elif last:
            f[last] += " " + ln.strip()
    return f


def norm(s):
    return re.sub(r"\s+", " ", s or "").strip()


def transform(block, rec, kind, name):
    out = []
    ov = OVERRIDES.get((kind, name), {})
    skip = False
    for ln in block:
        m = FIELD.match(ln)
        if m and not ln.startswith("    "):
            skip = False
            if m.group(1) in ov:
                out.append(f"  {m.group(1)}: {ov[m.group(1)]}")
                skip = True
                continue
            if m.group(1) in ("argument", "converse") and m.group(2).startswith("§ "):
                out.append(f"  {m.group(1)}: FS132-{rec}-derivation.md {m.group(2)}")
                continue
        elif skip:
            continue
        out.append(ln)
    return out


def build():
    src = {r: blocks(r) for r in RECS}
    used, out = [], []
    for ln in TEMPLATE.read_text().split("\n"):
        m = DIRECTIVE.match(ln)
        if not m:
            assert not ln.startswith("@@"), ln
            out.append(ln)
            continue
        kind = "derivation" if m.group(1) == "ENTRY" else "control"
        rec, name = m.group(2), m.group(3)
        assert (kind, name) in src[rec], (rec, kind, name)
        used.append((rec, kind, name))
        out.extend(transform(src[rec][(kind, name)], rec, kind, name))
    return src, used, "\n".join(out)


def check(text, src, fault=False):
    bad = []
    out_blocks, lines, i = {}, text.split("\n"), 0
    while i < len(lines):
        m = HEAD.match(lines[i])
        if not m:
            i += 1
            continue
        j = i + 1
        while j < len(lines) and lines[j].strip() != "":
            j += 1
        key = (m.group(1), m.group(2))
        if key in out_blocks:
            bad.append(f"twice in the output: {key}")
        out_blocks[key] = lines[i:j]
        i = j
    n = 0
    for rec in RECS:
        for key, blk in src[rec].items():
            n += 1
            if key not in out_blocks:
                bad.append(f"missing from the output: {rec} {key}")
                continue
            a, b = fields(blk), fields(out_blocks[key])
            if fault and key == ("derivation", "C132-CROSS"):
                b = dict(b, statement=b["statement"].replace("0 < |x − y| < 2", "0 < |x − y| ≤ 2"))
            ov = OVERRIDES.get(key, {})
            for k in set(a) | set(b):
                if k in ov:
                    continue
                va, vb = norm(a.get(k)), norm(b.get(k))
                if k in ("argument", "converse") and va.startswith("§ "):
                    va = f"FS132-{rec}-derivation.md {va}"
                if va != vb:
                    bad.append(f"{rec} {key[1]}: field {k!r} differs from its source")
    return n, len(out_blocks), bad


def main():
    src, used, text = build()
    if "--check" not in sys.argv:
        OUT.write_text(text)
    else:
        text = OUT.read_text()
    n, m, bad = check(text, src, fault="--fault" in sys.argv)
    for b in bad:
        print("FAIL", b)
    print(f"source blocks: {n}  blocks in the output: {m}  (authored here: {m - n})  failures: {len(bad)}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
