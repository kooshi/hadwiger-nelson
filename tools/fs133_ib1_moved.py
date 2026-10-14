#!/usr/bin/env python3
"""FS133-IB1 — did a stored statement of this job's two modules move, and how.

  fs133_ib1_moved.py <before.out> <after.out> [--control] [--ignore-new]

The reader is FS133-IA1's (`tools/fs133_ia1_moved.py`), its logic unchanged; this copy is this job's instrument.
The two files are outputs of `data/fs133/ib1/lean/StatementDump.lean` (FS132-I2's dumper: for every named constant of
`Plane/OneClass/InvariantLaw` and `Plane/OneClass/SectionDensity`, and every private declaration of theirs, the FULL
print of its stored type — and of a definition's stored value — and the ERASED print, with every instance argument and
every proof argument written `_`).  Per constant of the first dump:

  IDENTICAL        the full prints agree: the same stored term;
  INSTANCES-ONLY   the erased prints agree and the full prints do not: the term moved inside instance arguments and
                   proof arguments, and nowhere else.  The constants named at one side only are listed;
  DIFFERENT        the erased prints differ (or the kind, or the universe parameters): a statement or a definition
                   changed.  The run fails;
  MISSING          in the first dump, not in the second.  The run fails.
A constant only in the second dump is listed as NEW (a private helper; with `--ignore-new` counted only).

`--control` plants, in a copy of the second dump: one constant changed in an ERASED print (must read DIFFERENT), one
changed in a FULL print only (must read INSTANCES-ONLY — a move must never read as identical), one constant removed
(MISSING), one theorem turned into an axiom (DIFFERENT); exit 0 only if each is read as planted.
Exit 0 iff no DIFFERENT and no MISSING.  Prints may be `.xz`.
"""
import lzma
import re
import sys
from pathlib import Path

FIELDS = {"DUMP   type  = ": "type", "DUMP   etype = ": "etype", "DUMP   value = ": "value", "DUMP   evalue= ": "evalue"}


def read(path):
    path = Path(path)
    if path.suffix == ".xz":
        return lzma.open(path, "rt", encoding="utf-8").read()
    return path.read_text()


def load(text):
    out, cur, done, mod, where = {}, None, None, None, {}
    for ln in text.splitlines():
        if ln.startswith("## MODULE "):
            mod = ln.split()[2]
            continue
        m = re.match(r"DUMP (\S+) : (\w+)(?: levels=(.*))?$", ln)
        if m:
            cur = m.group(1)
            if cur in out:
                print(f"DUPLICATE {cur}")
                sys.exit(2)
            out[cur] = {"kind": m.group(2), "levels": m.group(3), "type": None, "etype": None, "value": None,
                        "evalue": None}
            where[cur] = mod
        elif ln.startswith("DUMP   ") and cur:
            key = ln[:15]
            if key in FIELDS:
                out[cur][FIELDS[key]] = ln[15:]
        elif ln.startswith("DONE "):
            done = int(ln.split()[1])
    if done is None or done != len(out) or not out:
        print(f"BROKEN DUMP: DONE {done}, {len(out)} constants read")
        sys.exit(2)
    return out, where


def constants(s):
    return set(re.findall(r"\(c (\S+) \[", s or ""))


def judge(b, a):
    if a is None:
        return "MISSING", [], []
    if a["kind"] != b["kind"] or a["levels"] != b["levels"]:
        return "DIFFERENT", [f"kind/levels {b['kind']} {b['levels']} -> {a['kind']} {a['levels']}"], []
    parts = [("type", "etype")] + ([("value", "evalue")] if b["kind"] == "def" else [])
    for full, er in parts:
        if b[er] is None or a[er] is None or b[er] != a[er]:
            return "DIFFERENT", sorted(constants(b[er]) - constants(a[er])), sorted(constants(a[er]) - constants(b[er]))
    if all(b[f] == a[f] for f, _ in parts):
        return "IDENTICAL", [], []
    gone, came = set(), set()
    for f, _ in parts:
        gone |= constants(b[f]) - constants(a[f])
        came |= constants(a[f]) - constants(b[f])
    return "INSTANCES-ONLY", sorted(gone), sorted(came)


def run(before, after, where, quiet=False, ignore_new=False):
    rows, counts = [], {}
    for name, b in before.items():
        v, gone, came = judge(b, after.get(name))
        rows.append((where[name], name, b["kind"], v, gone, came))
        counts[v] = counts.get(v, 0) + 1
    new = sorted(n for n in after if n not in before)
    if not quiet:
        for mod in dict.fromkeys(where.values()):
            mine = [r for r in rows if r[0] == mod]
            c = {}
            for r in mine:
                c[r[3]] = c.get(r[3], 0) + 1
            print(f"{mod}: " + ", ".join(f"{k} {v}" for k, v in sorted(c.items())))
            for r in mine:
                if r[3] != "IDENTICAL":
                    print(f"  {r[3]:15s} {r[2]:8s} {r[1]}")
                    if r[4] or r[5]:
                        print(f"      only before: {' '.join(r[4]) or '—'}")
                        print(f"      only after:  {' '.join(r[5]) or '—'}")
        print(f"constants of the first dump: {len(before)}  " + "  ".join(f"{k} {v}" for k, v in sorted(counts.items()))
              + f"  new in the second: {len(new)}")
        if not ignore_new:
            for n in new:
                print(f"  NEW {after[n]['kind']} {n}")
    return rows, counts


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, where = load(read(args[0]))
    after, _ = load(read(args[1]))
    if control:
        ok = True

        def expect(label, name, want, a2):
            nonlocal ok
            v, _, _ = judge(before[name], a2.get(name))
            print(f"plant '{label}' in {name}: read {v}, planted {want} — {'as planted' if v == want else 'NOT AS PLANTED'}")
            ok = ok and v == want

        thm = next(n for n, d in before.items() if d["kind"] == "theorem" and n in after and "(c " in (after[n]["etype"] or ""))
        c = sorted(constants(after[thm]["etype"]))[0]
        a2 = {k: dict(v) for k, v in after.items()}
        a2[thm]["etype"] = a2[thm]["etype"].replace(f"(c {c} [", f"(c {c}' [", 1)
        a2[thm]["type"] = a2[thm]["type"].replace(f"(c {c} [", f"(c {c}' [", 1)
        expect("a constant changed in the erased and the full print", thm, "DIFFERENT", a2)
        inst = next((n, x) for n, d in after.items() if n in before and d["kind"] == "theorem"
                    for x in sorted(constants(d["type"]) - constants(d["etype"]))[:1])
        a2 = {k: dict(v) for k, v in after.items()}
        a2[inst[0]]["type"] = a2[inst[0]]["type"].replace(f"(c {inst[1]} [", f"(c {inst[1]}' [", 1)
        want = "INSTANCES-ONLY"
        expect(f"a constant changed in the full print only ({inst[1]})", inst[0], want, a2)
        a2 = {k: dict(v) for k, v in after.items()}
        del a2[thm]
        expect("a constant removed", thm, "MISSING", a2)
        a2 = {k: dict(v) for k, v in after.items()}
        a2[thm]["kind"] = "axiom"
        expect("a theorem turned into an axiom", thm, "DIFFERENT", a2)
        print("CONTROL OK: each plant read as planted" if ok else "CONTROL FAILED")
        return 0 if ok else 1
    rows, counts = run(before, after, where, ignore_new="--ignore-new" in sys.argv)
    bad = counts.get("DIFFERENT", 0) + counts.get("MISSING", 0)
    print("MOVED OK: nothing moved outside instance and proof arguments" if not bad else f"MOVED FAILED: {bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
