#!/usr/bin/env python3
"""FS133-IB2 — did a stored statement of `Plane/OneClass/Defs` or `Plane/OneClass/InvariantLaw` move, and how.

  fs133_ib2_moved.py <before.out> <after.out> [--first-module=M,…] [--moved=NAME,…] [--deleted=NAME,…]
                     [--proof-filled=NAME,…] [--strict] [--ignore-new] [--control]

The reader of FS133-IB1 (`tools/fs133_ib1_moved.py`; its `load` and `judge` unchanged), with this job's verdicts in
place of the ruled drops (this job drops no binder).  The two files are outputs of a dumper of FS132-I2's form
(`data/fs133/ib2/lean/StatementDump.lean`, or FS133-IA1's eight-module `StatementDumpErased.lean`): per constant,
the module it is compiled in (`## MODULE`), its kind, the FULL print of its stored type (and a definition's value),
and the ERASED print, every instance argument and proof argument written `_`.  Constants are matched by name, so a
constant compiled in another module on the second side is found and its module change is read.  Per constant of the
first dump (restricted to the modules of `--first-module`, if given):

  IDENTICAL        the full prints agree and the module is the same;
  INSTANCES-ONLY   the erased prints agree and the full prints do not (with `--strict` a failure, except below);
  DIFFERENT        the erased prints differ, or the kind, or the universe parameters: the run fails;
  MISSING          absent from the second dump: the run fails, except below;
  MODULE-CHANGED   identical, but compiled in another module: the run fails, except below.

The coordinator's rulings and the job's own changes, each checked, never assumed:
  --moved=N         N must read IDENTICAL in the full print and be compiled in another module (MOVED-IDENTICAL);
                    any other outcome fails;
  --deleted=N       N must be a private declaration (`_private.…`) and absent from the second dump (DELETED);
  --proof-filled=N  N must be a definition whose stored type is identical in the full print and whose value reads
                    INSTANCES-ONLY — a proof argument filled, nothing else moved (PROOF-FILLED); the constants its
                    value names at one side only are printed.
A constant only in the second dump is listed as NEW (with `--ignore-new` counted only).

`--control` plants, in a copy of the second dump, one fault per verdict and requires each to be read as planted:
a constant changed in an erased print (DIFFERENT), in a full print only (INSTANCES-ONLY, a failure under --strict),
a constant removed (MISSING), a theorem turned into an axiom (DIFFERENT), an unlisted constant moved to another
module (MODULE-CHANGED), a moved constant's type changed (fails), a deleted private put back (fails), a proof-filled
definition's erased value changed (fails).  Exit 0 iff every plant is read as planted.
Exit 0 iff no failure.  Prints may be `.xz`.
"""
import copy
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


def lst(flag):
    out = []
    for a in sys.argv[1:]:
        if a.startswith(flag + "="):
            out += [x for x in a[len(flag) + 1:].split(",") if x]
    return out


def verdicts(before, wb, after, wa, moved, deleted, filled, strict):
    """-> (rows, failures): one row per constant of the first dump."""
    rows, bad = [], []
    for name, b in before.items():
        a = after.get(name)
        v, gone, came = judge(b, a)
        same_mod = a is not None and wa.get(name) == wb.get(name)
        if name in deleted:
            if not name.startswith("_private."):
                verdict = "DELETED-NOT-PRIVATE"
            else:
                verdict = "DELETED" if a is None else "DELETED-BUT-PRESENT"
        elif name in moved:
            verdict = "MOVED-IDENTICAL" if (v == "IDENTICAL" and a is not None and not same_mod) else \
                f"MOVED-BUT-{v}{'' if not same_mod else '-SAME-MODULE'}"
        elif name in filled:
            ok = (v == "INSTANCES-ONLY" and b["kind"] == "def" and a["type"] == b["type"] and same_mod)
            verdict = "PROOF-FILLED" if ok else f"PROOF-FILLED-BUT-{v}"
        elif v == "IDENTICAL" and a is not None and not same_mod:
            verdict = "MODULE-CHANGED"
        else:
            verdict = v
        good = verdict in ("IDENTICAL", "DELETED", "MOVED-IDENTICAL", "PROOF-FILLED") or \
            (verdict == "INSTANCES-ONLY" and not strict)
        rows.append((wb.get(name), name, b["kind"], verdict, gone, came, wa.get(name)))
        if not good:
            bad.append(f"  {verdict:22s} {name}")
    return rows, bad


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    first_mods, moved, deleted, filled = lst("--first-module"), lst("--moved"), lst("--deleted"), lst("--proof-filled")
    strict, ignore_new, control = "--strict" in sys.argv, "--ignore-new" in sys.argv, "--control" in sys.argv
    before, wb = load(read(args[0]))
    after, wa = load(read(args[1]))
    if first_mods:
        keep = {n for n, m in wb.items() if any(m == fm or m.endswith("." + fm) for fm in first_mods)}
        if not keep:
            print(f"FIRST-MODULE FILTER KEEPS NOTHING: {first_mods}")
            return 2
        before = {n: d for n, d in before.items() if n in keep}
    for n in moved + deleted + filled:
        if n not in before:
            print(f"LISTED NAME NOT IN THE FIRST DUMP: {n}")
            return 2

    if control:
        ok = True

        def expect(label, name, a2, wa2, fails=True, strict_=strict):
            nonlocal ok
            _, bad = verdicts(before, wb, a2, wa2, moved, deleted, filled, strict_)
            hit = any(ln.split()[-1] == name for ln in bad)
            print(f"plant '{label}' in {name}: {'the run fails and names it' if hit else 'NOT REPORTED'}")
            ok = ok and hit == fails

        _, bad0 = verdicts(before, wb, after, wa, moved, deleted, filled, strict)
        print(f"the run itself, before any plant: {'no failure' if not bad0 else bad0}")
        ok = ok and not bad0
        plain = [n for n, d in before.items() if n not in moved + deleted + filled and n in after
                 and d["kind"] == "theorem" and "(c " in (after[n]["etype"] or "")]
        thm = plain[0]
        c = sorted(constants(after[thm]["etype"]))[0]
        a2 = copy.deepcopy(after)
        for f in ("type", "etype"):
            a2[thm][f] = a2[thm][f].replace(f"(c {c} [", f"(c {c}' [", 1)
        expect("a constant changed in the erased and the full print", thm, a2, wa)
        inst = next(((n, x) for n in plain for x in sorted(constants(after[n]["type"]) - constants(after[n]["etype"]))[:1]),
                    None)
        if inst:
            a2 = copy.deepcopy(after)
            a2[inst[0]]["type"] = a2[inst[0]]["type"].replace(f"(c {inst[1]} [", f"(c {inst[1]}' [", 1)
            expect(f"a constant changed in the full print only ({inst[1]}), --strict", inst[0], a2, wa, strict_=True)
        else:
            print("plant 'full print only': no theorem with an instance argument — NOT PLANTED")
            ok = False
        a2 = copy.deepcopy(after)
        del a2[thm]
        expect("a constant removed", thm, a2, wa)
        a2 = copy.deepcopy(after)
        a2[thm]["kind"] = "axiom"
        expect("a theorem turned into an axiom", thm, a2, wa)
        wa2 = dict(wa)
        wa2[thm] = "Proofs.Elsewhere"
        expect("an unlisted constant compiled in another module", thm, after, wa2)
        for n in moved:
            a2 = copy.deepcopy(after)
            a2[n]["type"] = a2[n]["type"] + " "
            expect("a moved constant's full print changed", n, a2, wa)
            wa2 = dict(wa)
            wa2[n] = wb[n]
            expect("a moved constant left in its old module", n, after, wa2)
        for n in deleted:
            a2 = copy.deepcopy(after)
            a2[n] = copy.deepcopy(before[n])
            expect("a deleted private put back", n, a2, wa)
        for n in filled:
            a2 = copy.deepcopy(after)
            a2[n]["evalue"] = (a2[n]["evalue"] or "") + " X"
            expect("a proof-filled definition's erased value changed", n, a2, wa)
            a2 = copy.deepcopy(after)
            a2[n]["type"] = (a2[n]["type"] or "") + " X"
            a2[n]["etype"] = (a2[n]["etype"] or "") + " X"
            expect("a proof-filled definition's type changed", n, a2, wa)
        print("CONTROL OK: each plant read as planted" if ok else "CONTROL FAILED")
        return 0 if ok else 1

    rows, bad = verdicts(before, wb, after, wa, moved, deleted, filled, strict)
    counts = {}
    for r in rows:
        counts[r[3]] = counts.get(r[3], 0) + 1
    for mod in dict.fromkeys(r[0] for r in rows):
        mine = [r for r in rows if r[0] == mod]
        c = {}
        for r in mine:
            c[r[3]] = c.get(r[3], 0) + 1
        print(f"{mod}: " + ", ".join(f"{k} {v}" for k, v in sorted(c.items())))
        for r in mine:
            if r[3] != "IDENTICAL":
                extra = f" -> {r[6]}" if r[3].startswith("MOVED") or r[3] == "MODULE-CHANGED" else ""
                print(f"  {r[3]:22s} {r[2]:8s} {r[1]}{extra}")
                if r[4] or r[5]:
                    print(f"      only before: {' '.join(r[4]) or '—'}")
                    print(f"      only after:  {' '.join(r[5]) or '—'}")
    new = sorted(n for n in after if n not in before and not (first_mods and n in wb))
    print(f"constants of the first dump: {len(before)}  " + "  ".join(f"{k} {v}" for k, v in sorted(counts.items()))
          + f"  new in the second: {len(new)}")
    if not ignore_new:
        for n in new:
            print(f"  NEW {after[n]['kind']} {n} @ {wa.get(n)}")
    print("MOVED OK: every listed change is as listed; nothing else moved"
          + ("" if strict else " outside instance and proof arguments") if not bad else f"MOVED FAILED: {len(bad)}")
    for ln in bad:
        print(ln)
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
